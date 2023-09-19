Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABBE67A6415
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 14:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbjISM61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 08:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbjISM6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 08:58:15 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83577E6E
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 05:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HMqgMw86VN9AXiB3htOitViaUrrotMkJ245EFer28SY=; b=mawo7EK+2Pjf4WxRO4RbhkFI8c
        yMSToWrasRr12XmQzKfvdo4xoxmeDvfPmQSKbMfNCeDsNjONzkL4PBiQvOBmrTvj3ZlBZBCWHlgDY
        bvZ310envEpHOrl8At40xyy1MTHtlSdFV/A0Ji5mujQHG/njFHwz/uZr5lYb8RZuZX7vyLha4BhLZ
        4WP7camp2qhbILMXSsFvApe6qtfkvoZt46vhwhXHRwXJhjKgSefuFMv4BThYb7iKbq4ShTeBW5/ae
        wtX299whZpiqKNTv+yOsIgmZJqELzfntuABfPzfLcCqQdLKM9GMxvycQgS8vHpwLMBWk1PtZpfT6M
        LjmtC7xw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qiaIZ-00DcNU-2K;
        Tue, 19 Sep 2023 12:57:53 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id C87B0300585; Tue, 19 Sep 2023 14:57:52 +0200 (CEST)
Date:   Tue, 19 Sep 2023 14:57:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        akpm@linux-foundation.org
Subject: Re: Buggy __free(kfree) usage pattern already in tree
Message-ID: <20230919125752.GA39346@noisy.programming.kicks-ass.net>
References: <CACMJSetxQi+t3SBXu6OvBbmxV8AbX2CfdSA9JvF1chLJSU9Ppw@mail.gmail.com>
 <CAHk-=wgRHiV5VSxtfXA4S6aLUmcQYEuB67u3BJPJPtuESs1JyA@mail.gmail.com>
 <CACMJSevZQgik7S-62fz9H7+Mib+W0CgYMV4GyWjYV7N_E6iHVQ@mail.gmail.com>
 <CACMJSevrJ5KSPAZVheXkNaYj8KQFD8ck55kU_E4vEj4vzR8wnQ@mail.gmail.com>
 <CAHk-=wicfvWPuRVDG5R1mZSxD8Xg=-0nLOiHay2T_UJ0yDX42g@mail.gmail.com>
 <20230915210851.GA23174@noisy.programming.kicks-ass.net>
 <CAHk-=whvOGL3aNhtps0YksGtzvaob_bvZpbaTcVEqGwNMxB6xg@mail.gmail.com>
 <20230915213231.GB23174@noisy.programming.kicks-ass.net>
 <CAHk-=wi08ZUguV_n88h=bP6X01-tah29RtB0t9TmXtyuEJev-Q@mail.gmail.com>
 <20230915221332.GC23174@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915221332.GC23174@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 16, 2023 at 12:13:32AM +0200, Peter Zijlstra wrote:

> I think I can make it work, I'll go have a play, but perhaps not now,
> it's past midnight ;-)

So I have been playing about with this a bit and it keeps falling short
of 'nice' :/

What I ended up with is the below. The simple scoped_guard () extension
is useful, albeit slightly awkward (I'll reply with another patch making
use of it). But the basic problem is that it will have to have the form:

	scoped_guard (mutex_intr, &task->signal->cred_guard_mutex) {
		...
		return 0;
	}
	return -EINTR;

That is; the guard body must terminate such that after the body is the
'fail' case. This is not always convenient.

Additionally, this did not help with my case where I need to hold the
lock conditionally (when I have a task) but need to execute the body
unconditionally. Then the above form just doesn't work.

For that, I ended up with:

	cond_guard(name, stmt, args...)

Which can be used like:


	do {
		cond_guard(rwsem_down_intr, if (task) return -EINTR,
			   task ? task->signal->exec_update_lock : NULL);

		... do stuff that is conditionally guarded by @exec_update_lock ...

	} while (0);


I'll continue poking for a bit,.. see if there's something better.


---
Subject: cleanup: Add conditional guard support
From: Peter Zijlstra <peterz@infradead.org>
Date: Sun Sep 17 13:22:17 CEST 2023

Adds:

 - DEFINE_GUARD_COND() / DEFINE_LOCK_GUARD_1_COND() to extend existing
   guards with conditional lock primitives, eg. mutex_trylock(),
   mutex_lock_interruptible().

   nb. both primitives allow NULL 'locks', which cause the lock to
       fail (obviously).

 - extends scoped_guard() to not take the body when the the
   conditional guard 'fails'. eg.

     scoped_guard (mutex_intr, &task->signal_cred_guard_mutex) {
	...
     }

   will only execute the body when the mutex is held.

 - provides cond_guard(name, stmt, args...); which extends guard()
   to execute @stmt when the lock fails.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
Index: linux-2.6/include/linux/cleanup.h
===================================================================
--- linux-2.6.orig/include/linux/cleanup.h
+++ linux-2.6/include/linux/cleanup.h
@@ -136,14 +136,36 @@ static inline class_##_name##_t class_##
  */
 
 #define DEFINE_GUARD(_name, _type, _lock, _unlock) \
-	DEFINE_CLASS(_name, _type, _unlock, ({ _lock; _T; }), _type _T)
+	DEFINE_CLASS(_name, _type, if (_T) { _unlock; }, ({ _lock; _T; }), _type _T); \
+	static inline void * class_##_name##_lock_ptr(class_##_name##_t *_T) \
+	{ return *_T; }
+
+#define DEFINE_GUARD_COND(_name, _ext, _condlock) \
+	EXTEND_CLASS(_name, _ext, \
+		     ({ void *_t = _T; if (_T && !(_condlock)) _t = NULL; _t; }), \
+		     class_##_name##_t _T) \
+	static inline void * class_##_name##_ext##_lock_ptr(class_##_name##_t *_T) \
+	{ return class_##_name##_lock_ptr(_T); }
+
+#define _guard(_name, var)						\
+	class_##_name##_t var __cleanup(class_##_name##_destructor) =	\
+		class_##_name##_constructor
 
 #define guard(_name) \
-	CLASS(_name, __UNIQUE_ID(guard))
+	_guard(_name, __UNIQUE_ID(guard))
+
+#define __guard_ptr(_name) class_##_name##_lock_ptr
 
 #define scoped_guard(_name, args...)					\
 	for (CLASS(_name, scope)(args),					\
-	     *done = NULL; !done; done = (void *)1)
+	     *done = NULL; __guard_ptr(_name)(&scope) && !done; done = (void *)1)
+
+#define _cond_guard(_name, _var, _stmt, args...) \
+	_guard(_name, _var)(args); \
+	if (!__guard_ptr(_name)(&_var)) _stmt
+
+#define cond_guard(_name, _stmt, args...) \
+	_cond_guard(_name, __UNIQUE_ID(guard), _stmt, args)
 
 /*
  * Additional helper macros for generating lock guards with types, either for
@@ -173,6 +195,11 @@ typedef struct {							\
 static inline void class_##_name##_destructor(class_##_name##_t *_T)	\
 {									\
 	if (_T->lock) { _unlock; }					\
+}									\
+									\
+static inline void *class_##_name##_lock_ptr(class_##_name##_t *_T)	\
+{									\
+	return _T->lock;						\
 }
 
 
@@ -201,4 +228,14 @@ __DEFINE_LOCK_GUARD_1(_name, _type, _loc
 __DEFINE_UNLOCK_GUARD(_name, void, _unlock, __VA_ARGS__)		\
 __DEFINE_LOCK_GUARD_0(_name, _lock)
 
+#define DEFINE_LOCK_GUARD_1_COND(_name, _ext, _condlock)		\
+	EXTEND_CLASS(_name, _ext,					\
+		     ({ class_##_name##_t _t = { .lock = l }, *_T = &_t;\
+		        if (_T->lock && !(_condlock)) _T->lock = NULL;	\
+			_t; }),						\
+		     typeof_member(class_##_name##_t, lock) l)		\
+	static inline void * class_##_name##_ext##_lock_ptr(class_##_name##_t *_T) \
+	{ return class_##_name##_lock_ptr(_T); }
+
+
 #endif /* __LINUX_GUARDS_H */
Index: linux-2.6/include/linux/mutex.h
===================================================================
--- linux-2.6.orig/include/linux/mutex.h
+++ linux-2.6/include/linux/mutex.h
@@ -221,6 +221,7 @@ extern void mutex_unlock(struct mutex *l
 extern int atomic_dec_and_mutex_lock(atomic_t *cnt, struct mutex *lock);
 
 DEFINE_GUARD(mutex, struct mutex *, mutex_lock(_T), mutex_unlock(_T))
-DEFINE_FREE(mutex, struct mutex *, if (_T) mutex_unlock(_T))
+DEFINE_GUARD_COND(mutex, _try, mutex_trylock(_T))
+DEFINE_GUARD_COND(mutex, _intr, mutex_lock_interruptible(_T) == 0)
 
 #endif /* __LINUX_MUTEX_H */
Index: linux-2.6/include/linux/spinlock.h
===================================================================
--- linux-2.6.orig/include/linux/spinlock.h
+++ linux-2.6/include/linux/spinlock.h
@@ -507,6 +507,8 @@ DEFINE_LOCK_GUARD_1(raw_spinlock, raw_sp
 		    raw_spin_lock(_T->lock),
 		    raw_spin_unlock(_T->lock))
 
+DEFINE_LOCK_GUARD_1_COND(raw_spinlock, _try, raw_spin_trylock(_T->lock))
+
 DEFINE_LOCK_GUARD_1(raw_spinlock_nested, raw_spinlock_t,
 		    raw_spin_lock_nested(_T->lock, SINGLE_DEPTH_NESTING),
 		    raw_spin_unlock(_T->lock))
@@ -515,23 +517,36 @@ DEFINE_LOCK_GUARD_1(raw_spinlock_irq, ra
 		    raw_spin_lock_irq(_T->lock),
 		    raw_spin_unlock_irq(_T->lock))
 
+DEFINE_LOCK_GUARD_1_COND(raw_spinlock_irq, _try, raw_spin_trylock_irq(_T->lock))
+
 DEFINE_LOCK_GUARD_1(raw_spinlock_irqsave, raw_spinlock_t,
 		    raw_spin_lock_irqsave(_T->lock, _T->flags),
 		    raw_spin_unlock_irqrestore(_T->lock, _T->flags),
 		    unsigned long flags)
 
+DEFINE_LOCK_GUARD_1_COND(raw_spinlock_irqsave, _try,
+			 raw_spin_trylock_irqsave(_T->lock, _T->flags))
+
 DEFINE_LOCK_GUARD_1(spinlock, spinlock_t,
 		    spin_lock(_T->lock),
 		    spin_unlock(_T->lock))
 
+DEFINE_LOCK_GUARD_1_COND(spinlock, _try, spin_trylock(_T->lock))
+
 DEFINE_LOCK_GUARD_1(spinlock_irq, spinlock_t,
 		    spin_lock_irq(_T->lock),
 		    spin_unlock_irq(_T->lock))
 
+DEFINE_LOCK_GUARD_1_COND(spinlock_irq, _try,
+			 spin_trylock_irq(_T->lock))
+
 DEFINE_LOCK_GUARD_1(spinlock_irqsave, spinlock_t,
 		    spin_lock_irqsave(_T->lock, _T->flags),
 		    spin_unlock_irqrestore(_T->lock, _T->flags),
 		    unsigned long flags)
 
+DEFINE_LOCK_GUARD_1_COND(spinlock_irqsave, _try,
+			 spin_trylock_irqsave(_T->lock, _T->flags))
+
 #undef __LINUX_INSIDE_SPINLOCK_H
 #endif /* __LINUX_SPINLOCK_H */
Index: linux-2.6/include/linux/rwsem.h
===================================================================
--- linux-2.6.orig/include/linux/rwsem.h
+++ linux-2.6/include/linux/rwsem.h
@@ -203,11 +203,11 @@ extern void up_read(struct rw_semaphore
 extern void up_write(struct rw_semaphore *sem);
 
 DEFINE_GUARD(rwsem_read, struct rw_semaphore *, down_read(_T), up_read(_T))
-DEFINE_GUARD(rwsem_write, struct rw_semaphore *, down_write(_T), up_write(_T))
-
-DEFINE_FREE(up_read, struct rw_semaphore *, if (_T) up_read(_T))
-DEFINE_FREE(up_write, struct rw_semaphore *, if (_T) up_write(_T))
+DEFINE_GUARD_COND(rwsem_read, _try, down_read_trylock(_T))
+DEFINE_GUARD_COND(rwsem_read, _intr, down_read_interruptible(_T) == 0)
 
+DEFINE_GUARD(rwsem_write, struct rw_semaphore *, down_write(_T), up_write(_T))
+DEFINE_GUARD_COND(rwsem_write, _try, down_write_trylock(_T))
 
 /*
  * downgrade write lock to read lock
