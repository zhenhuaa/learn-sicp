#lang racket/base

(require rackunit r5rs racket/trace)

(provide last-pair)

; The following procedure for appending lists was introduced in 2.2.1:
(define (append x y)
  (if (null? x)
      y
      (cons (car x) (append (cdr x) y))))

;   Append forms a new list by successively consing the elements of x onto y. The procedure append! is similar to append, but it is a mutator rather than a constructor. It appends the lists by splicing them together, modifying the final pair of x so that its cdr is now y. (It is an error to call append! with an empty x.)

(define (append! x y)
  (set-cdr! (last-pair x) y)
x)

(define (last-pair x)
  (if (null? (cdr x))
      x
      (last-pair (cdr x))))


(define x (list 'a 'b))
(define y (list 'c 'd))
(define z (append x y))

(check-equal? z '(a b c d))
(check-equal? (cdr x) '(b))

(define w (append! x y))

(check-equal? w '(a b c d))
(check-equal? (cdr x) '(b c d))