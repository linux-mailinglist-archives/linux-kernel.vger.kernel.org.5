Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2957EBF59
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 10:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234740AbjKOJUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 04:20:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234695AbjKOJU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 04:20:28 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F414FFE;
        Wed, 15 Nov 2023 01:20:24 -0800 (PST)
Date:   Wed, 15 Nov 2023 09:20:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1700040023;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=+XLO1iXClZQAdz5+bvaGgUlrU81KZLVSU0wnnmCWQSo=;
        b=V6nWPqCjXn29mD5oaQjnPo6YUDhKyixPJxMg7eBmLmFg5lY6f+XYsv+nFcuDO1pe0yoSma
        fH36IeCsIsV6MRnIZh594iyUlxj7RCE5Jj46/OtIQXpfq8WQtPE3k0cjhoY7OoD6X1xDqU
        LxkSAfzM9G8K7RKsrxakMUZhIbHx1aqBBn69DbHzxrqPAimSMjl/ontEGMj5IQhV0HUwmW
        ZDZzj92j3Vb+Ytyq3i6kJZPZ2p1Mulk7UN49FySCYetZFWzLz7TvUbMVvYR5BBBnBDaUdP
        sEpkAoOA0q0F5w5mW7HZW/HDipMkpbZc6wWTP9e5tGRDTvuY+Jb7oQk3c8XhcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1700040023;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=+XLO1iXClZQAdz5+bvaGgUlrU81KZLVSU0wnnmCWQSo=;
        b=AhMck5nAe/QBKjErXTA/DezuV/zHgYesPovdLqPed6253vVQsNxYjG+E8H1uEu2kyz/mxZ
        NkDKSt4ttNdAeBBQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] cleanup: Add conditional guard support
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <170004002294.391.491457024125736824.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     e4ab322fbaaaf84b23d6cb0e3317a7f68baf36dc
Gitweb:        https://git.kernel.org/tip/e4ab322fbaaaf84b23d6cb0e3317a7f68baf36dc
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Sun, 17 Sep 2023 13:22:17 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 15 Nov 2023 10:15:33 +01:00

cleanup: Add conditional guard support

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

 - provides scoped_cond_guard(name, fail, args...); which extends
   scoped_guard() to do fail when the lock-acquire fails.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20231102110706.460851167%40infradead.org
---
 include/linux/cleanup.h  | 52 ++++++++++++++++++++++++++++++++++++---
 include/linux/mutex.h    |  3 +-
 include/linux/rwsem.h    |  8 +++---
 include/linux/spinlock.h | 15 +++++++++++-
 4 files changed, 70 insertions(+), 8 deletions(-)

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index 9f1a9c4..c2d09bc 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -125,25 +125,55 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
  *	trivial wrapper around DEFINE_CLASS() above specifically
  *	for locks.
  *
+ * DEFINE_GUARD_COND(name, ext, condlock)
+ *	wrapper around EXTEND_CLASS above to add conditional lock
+ *	variants to a base class, eg. mutex_trylock() or
+ *	mutex_lock_interruptible().
+ *
  * guard(name):
- *	an anonymous instance of the (guard) class
+ *	an anonymous instance of the (guard) class, not recommended for
+ *	conditional locks.
  *
  * scoped_guard (name, args...) { }:
  *	similar to CLASS(name, scope)(args), except the variable (with the
  *	explicit name 'scope') is declard in a for-loop such that its scope is
  *	bound to the next (compound) statement.
  *
+ *	for conditional locks the loop body is skipped when the lock is not
+ *	acquired.
+ *
+ * scoped_cond_guard (name, fail, args...) { }:
+ *      similar to scoped_guard(), except it does fail when the lock
+ *      acquire fails.
+ *
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
 
 #define guard(_name) \
 	CLASS(_name, __UNIQUE_ID(guard))
 
+#define __guard_ptr(_name) class_##_name##_lock_ptr
+
 #define scoped_guard(_name, args...)					\
 	for (CLASS(_name, scope)(args),					\
-	     *done = NULL; !done; done = (void *)1)
+	     *done = NULL; __guard_ptr(_name)(&scope) && !done; done = (void *)1)
+
+#define scoped_cond_guard(_name, _fail, args...) \
+	for (CLASS(_name, scope)(args), \
+	     *done = NULL; !done; done = (void *)1) \
+		if (!__guard_ptr(_name)(&scope)) _fail; \
+		else
 
 /*
  * Additional helper macros for generating lock guards with types, either for
@@ -152,6 +182,7 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
  *
  * DEFINE_LOCK_GUARD_0(name, lock, unlock, ...)
  * DEFINE_LOCK_GUARD_1(name, type, lock, unlock, ...)
+ * DEFINE_LOCK_GUARD_1_COND(name, ext, condlock)
  *
  * will result in the following type:
  *
@@ -173,6 +204,11 @@ typedef struct {							\
 static inline void class_##_name##_destructor(class_##_name##_t *_T)	\
 {									\
 	if (_T->lock) { _unlock; }					\
+}									\
+									\
+static inline void *class_##_name##_lock_ptr(class_##_name##_t *_T)	\
+{									\
+	return _T->lock;						\
 }
 
 
@@ -201,4 +237,14 @@ __DEFINE_LOCK_GUARD_1(_name, _type, _lock)
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
diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index a33aa9e..95d1130 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -221,6 +221,7 @@ extern void mutex_unlock(struct mutex *lock);
 extern int atomic_dec_and_mutex_lock(atomic_t *cnt, struct mutex *lock);
 
 DEFINE_GUARD(mutex, struct mutex *, mutex_lock(_T), mutex_unlock(_T))
-DEFINE_FREE(mutex, struct mutex *, if (_T) mutex_unlock(_T))
+DEFINE_GUARD_COND(mutex, _try, mutex_trylock(_T))
+DEFINE_GUARD_COND(mutex, _intr, mutex_lock_interruptible(_T) == 0)
 
 #endif /* __LINUX_MUTEX_H */
diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index 1dd530c..9c29689 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -203,11 +203,11 @@ extern void up_read(struct rw_semaphore *sem);
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
diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 31d3d74..ceb56b3 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -507,6 +507,8 @@ DEFINE_LOCK_GUARD_1(raw_spinlock, raw_spinlock_t,
 		    raw_spin_lock(_T->lock),
 		    raw_spin_unlock(_T->lock))
 
+DEFINE_LOCK_GUARD_1_COND(raw_spinlock, _try, raw_spin_trylock(_T->lock))
+
 DEFINE_LOCK_GUARD_1(raw_spinlock_nested, raw_spinlock_t,
 		    raw_spin_lock_nested(_T->lock, SINGLE_DEPTH_NESTING),
 		    raw_spin_unlock(_T->lock))
@@ -515,23 +517,36 @@ DEFINE_LOCK_GUARD_1(raw_spinlock_irq, raw_spinlock_t,
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
