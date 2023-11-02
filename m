Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53C07DF0EC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 12:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347152AbjKBLIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 07:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347283AbjKBLI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 07:08:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5BB196
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 04:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=7W49TRUT7mF/cAs1KlJPftLquObVPnXXCZ1Z4Fl4mU8=; b=D888II8AWl8id+w5D4nWM4qIIM
        xql/wjDVc0j2XMKQEx3kQatUu9ALpFSmdc8ZfsACjHekYSzWvfYEnZoGC5jPWZrV0U6UrqUGfO0r4
        4BzGIbyF+5j4NI01hEfneQUWs/uosuo7Q4adb2yBIaCnRibFC2UVz+6bARkAkkiCEkqAGEijxhMHH
        hWPuzunyhI/RXSrMDakxt8BfP5GM/W02hdBxj24jdVpW1cfD1dabEaysezuWNWKinBAHuCZsB08H9
        9n1rGvLGtrw6zCLpAZvqxC4Bnawim7llfzI4RcBS/S8ertbOt519EKG53KoluI8YgXnf37zgX6WSz
        keEU8T7g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qyVYZ-00467N-Pu; Thu, 02 Nov 2023 11:08:11 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
        id 7174130057E; Thu,  2 Nov 2023 12:08:11 +0100 (CET)
Message-Id: <20231102110706.460851167@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 02 Nov 2023 11:44:30 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linuxfoundation.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
        Jonathan Cameron <jic23@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>
Subject: [PATCH 1/2] cleanup: Add conditional guard support
References: <20231102104429.025835330@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
---
 include/linux/cleanup.h  |   52 ++++++++++++++++++++++++++++++++++++++++++++---
 include/linux/mutex.h    |    3 +-
 include/linux/rwsem.h    |    8 +++----
 include/linux/spinlock.h |   15 +++++++++++++
 4 files changed, 70 insertions(+), 8 deletions(-)

--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -125,25 +125,55 @@ static inline class_##_name##_t class_##
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
@@ -152,6 +182,7 @@ static inline class_##_name##_t class_##
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
 
 
@@ -201,4 +237,14 @@ __DEFINE_LOCK_GUARD_1(_name, _type, _loc
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
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -221,6 +221,7 @@ extern void mutex_unlock(struct mutex *l
 extern int atomic_dec_and_mutex_lock(atomic_t *cnt, struct mutex *lock);
 
 DEFINE_GUARD(mutex, struct mutex *, mutex_lock(_T), mutex_unlock(_T))
-DEFINE_FREE(mutex, struct mutex *, if (_T) mutex_unlock(_T))
+DEFINE_GUARD_COND(mutex, _try, mutex_trylock(_T))
+DEFINE_GUARD_COND(mutex, _intr, mutex_lock_interruptible(_T) == 0)
 
 #endif /* __LINUX_MUTEX_H */
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
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
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
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


