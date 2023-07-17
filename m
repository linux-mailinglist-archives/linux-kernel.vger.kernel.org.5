Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322D5756374
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 14:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjGQM42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 08:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjGQM40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 08:56:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46AB10D8;
        Mon, 17 Jul 2023 05:56:03 -0700 (PDT)
Date:   Mon, 17 Jul 2023 12:55:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689598558;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=SgZqW9RddXgn6IwxLivsXd52mIhpbSLafU3rkUx1N30=;
        b=j+cuzMj0CMvtUtJQrIT6YSy8uQWJWPZvdACdvhjXxidNByJty1j8svt5WJTLvzXsVI+kcQ
        q/ZXeByNlHJmVFU/LOlpOkCPs1wV2tAwCJVe3f74WNymEgZ7NLiunBVVhV+IkhX/8HkvRO
        R+8Po5wBTT8Qs54HkHQ2jGcl4XiC5Yw8fhVnL5s61zPwBhWdnVm+/eyn64mhrzHTOvza3L
        ypLkwYTXVvXcy0oKN0OltRsCd0vU757FINpnDOaLi9Hmw7PI9tJ4pw/z1kGnE55NgMQqFD
        vmmiEAk4V3H4eA7R91/ehJxCjqWl7LKAHoDBh1N6HfVTAiQ/k7N3qpuMevstPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689598558;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=SgZqW9RddXgn6IwxLivsXd52mIhpbSLafU3rkUx1N30=;
        b=ue9V4T5DzREyj5MPEmwnAG2AAeocGsTgjSvDlWRz314YgW5mnYOpp47ua7uCWBwqL3tftA
        +kPmL3cYBxyYpDBg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] locking/rtmutex: Fix task->pi_waiters integrity
Cc:     Henry Wu <triangletrap12@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168959855775.28540.3741618896919693994.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     f7853c34241807bb97673a5e97719123be39a09e
Gitweb:        https://git.kernel.org/tip/f7853c34241807bb97673a5e97719123be39a09e
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 07 Jul 2023 16:19:09 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Jul 2023 13:59:10 +02:00

locking/rtmutex: Fix task->pi_waiters integrity

Henry reported that rt_mutex_adjust_prio_check() has an ordering
problem and puts the lie to the comment in [7]. Sharing the sort key
between lock->waiters and owner->pi_waiters *does* create problems,
since unlike what the comment claims, holding [L] is insufficient.

Notably, consider:

	A
      /   \
     M1   M2
     |     |
     B     C

That is, task A owns both M1 and M2, B and C block on them. In this
case a concurrent chain walk (B & C) will modify their resp. sort keys
in [7] while holding M1->wait_lock and M2->wait_lock. So holding [L]
is meaningless, they're different Ls.

This then gives rise to a race condition between [7] and [11], where
the requeue of pi_waiters will observe an inconsistent tree order.

	B				C

  (holds M1->wait_lock,		(holds M2->wait_lock,
   holds B->pi_lock)		 holds A->pi_lock)

  [7]
  waiter_update_prio();
  ...
  [8]
  raw_spin_unlock(B->pi_lock);
  ...
  [10]
  raw_spin_lock(A->pi_lock);

				[11]
				rt_mutex_enqueue_pi();
				// observes inconsistent A->pi_waiters
				// tree order

Fixing this means either extending the range of the owner lock from
[10-13] to [6-13], with the immediate problem that this means [6-8]
hold both blocked and owner locks, or duplicating the sort key.

Since the locking in chain walk is horrible enough without having to
consider pi_lock nesting rules, duplicate the sort key instead.

By giving each tree their own sort key, the above race becomes
harmless, if C sees B at the old location, then B will correct things
(if they need correcting) when it walks up the chain and reaches A.

Fixes: fb00aca47440 ("rtmutex: Turn the plist into an rb-tree")
Reported-by: Henry Wu <triangletrap12@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Henry Wu <triangletrap12@gmail.com>
Link: https://lkml.kernel.org/r/20230707161052.GF2883469%40hirez.programming.kicks-ass.net
---
 kernel/locking/rtmutex.c        | 170 ++++++++++++++++++++-----------
 kernel/locking/rtmutex_api.c    |   2 +-
 kernel/locking/rtmutex_common.h |  47 ++++++---
 kernel/locking/ww_mutex.h       |  12 +-
 4 files changed, 155 insertions(+), 76 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 728f434..21db0df 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -333,21 +333,43 @@ static __always_inline int __waiter_prio(struct task_struct *task)
 	return prio;
 }
 
+/*
+ * Update the waiter->tree copy of the sort keys.
+ */
 static __always_inline void
 waiter_update_prio(struct rt_mutex_waiter *waiter, struct task_struct *task)
 {
-	waiter->prio = __waiter_prio(task);
-	waiter->deadline = task->dl.deadline;
+	lockdep_assert_held(&waiter->lock->wait_lock);
+	lockdep_assert(RB_EMPTY_NODE(&waiter->tree.entry));
+
+	waiter->tree.prio = __waiter_prio(task);
+	waiter->tree.deadline = task->dl.deadline;
+}
+
+/*
+ * Update the waiter->pi_tree copy of the sort keys (from the tree copy).
+ */
+static __always_inline void
+waiter_clone_prio(struct rt_mutex_waiter *waiter, struct task_struct *task)
+{
+	lockdep_assert_held(&waiter->lock->wait_lock);
+	lockdep_assert_held(&task->pi_lock);
+	lockdep_assert(RB_EMPTY_NODE(&waiter->pi_tree.entry));
+
+	waiter->pi_tree.prio = waiter->tree.prio;
+	waiter->pi_tree.deadline = waiter->tree.deadline;
 }
 
 /*
- * Only use with rt_mutex_waiter_{less,equal}()
+ * Only use with rt_waiter_node_{less,equal}()
  */
+#define task_to_waiter_node(p)	\
+	&(struct rt_waiter_node){ .prio = __waiter_prio(p), .deadline = (p)->dl.deadline }
 #define task_to_waiter(p)	\
-	&(struct rt_mutex_waiter){ .prio = __waiter_prio(p), .deadline = (p)->dl.deadline }
+	&(struct rt_mutex_waiter){ .tree = *task_to_waiter_node(p) }
 
-static __always_inline int rt_mutex_waiter_less(struct rt_mutex_waiter *left,
-						struct rt_mutex_waiter *right)
+static __always_inline int rt_waiter_node_less(struct rt_waiter_node *left,
+					       struct rt_waiter_node *right)
 {
 	if (left->prio < right->prio)
 		return 1;
@@ -364,8 +386,8 @@ static __always_inline int rt_mutex_waiter_less(struct rt_mutex_waiter *left,
 	return 0;
 }
 
-static __always_inline int rt_mutex_waiter_equal(struct rt_mutex_waiter *left,
-						 struct rt_mutex_waiter *right)
+static __always_inline int rt_waiter_node_equal(struct rt_waiter_node *left,
+						 struct rt_waiter_node *right)
 {
 	if (left->prio != right->prio)
 		return 0;
@@ -385,7 +407,7 @@ static __always_inline int rt_mutex_waiter_equal(struct rt_mutex_waiter *left,
 static inline bool rt_mutex_steal(struct rt_mutex_waiter *waiter,
 				  struct rt_mutex_waiter *top_waiter)
 {
-	if (rt_mutex_waiter_less(waiter, top_waiter))
+	if (rt_waiter_node_less(&waiter->tree, &top_waiter->tree))
 		return true;
 
 #ifdef RT_MUTEX_BUILD_SPINLOCKS
@@ -393,30 +415,30 @@ static inline bool rt_mutex_steal(struct rt_mutex_waiter *waiter,
 	 * Note that RT tasks are excluded from same priority (lateral)
 	 * steals to prevent the introduction of an unbounded latency.
 	 */
-	if (rt_prio(waiter->prio) || dl_prio(waiter->prio))
+	if (rt_prio(waiter->tree.prio) || dl_prio(waiter->tree.prio))
 		return false;
 
-	return rt_mutex_waiter_equal(waiter, top_waiter);
+	return rt_waiter_node_equal(&waiter->tree, &top_waiter->tree);
 #else
 	return false;
 #endif
 }
 
 #define __node_2_waiter(node) \
-	rb_entry((node), struct rt_mutex_waiter, tree_entry)
+	rb_entry((node), struct rt_mutex_waiter, tree.entry)
 
 static __always_inline bool __waiter_less(struct rb_node *a, const struct rb_node *b)
 {
 	struct rt_mutex_waiter *aw = __node_2_waiter(a);
 	struct rt_mutex_waiter *bw = __node_2_waiter(b);
 
-	if (rt_mutex_waiter_less(aw, bw))
+	if (rt_waiter_node_less(&aw->tree, &bw->tree))
 		return 1;
 
 	if (!build_ww_mutex())
 		return 0;
 
-	if (rt_mutex_waiter_less(bw, aw))
+	if (rt_waiter_node_less(&bw->tree, &aw->tree))
 		return 0;
 
 	/* NOTE: relies on waiter->ww_ctx being set before insertion */
@@ -434,48 +456,58 @@ static __always_inline bool __waiter_less(struct rb_node *a, const struct rb_nod
 static __always_inline void
 rt_mutex_enqueue(struct rt_mutex_base *lock, struct rt_mutex_waiter *waiter)
 {
-	rb_add_cached(&waiter->tree_entry, &lock->waiters, __waiter_less);
+	lockdep_assert_held(&lock->wait_lock);
+
+	rb_add_cached(&waiter->tree.entry, &lock->waiters, __waiter_less);
 }
 
 static __always_inline void
 rt_mutex_dequeue(struct rt_mutex_base *lock, struct rt_mutex_waiter *waiter)
 {
-	if (RB_EMPTY_NODE(&waiter->tree_entry))
+	lockdep_assert_held(&lock->wait_lock);
+
+	if (RB_EMPTY_NODE(&waiter->tree.entry))
 		return;
 
-	rb_erase_cached(&waiter->tree_entry, &lock->waiters);
-	RB_CLEAR_NODE(&waiter->tree_entry);
+	rb_erase_cached(&waiter->tree.entry, &lock->waiters);
+	RB_CLEAR_NODE(&waiter->tree.entry);
 }
 
-#define __node_2_pi_waiter(node) \
-	rb_entry((node), struct rt_mutex_waiter, pi_tree_entry)
+#define __node_2_rt_node(node) \
+	rb_entry((node), struct rt_waiter_node, entry)
 
-static __always_inline bool
-__pi_waiter_less(struct rb_node *a, const struct rb_node *b)
+static __always_inline bool __pi_waiter_less(struct rb_node *a, const struct rb_node *b)
 {
-	return rt_mutex_waiter_less(__node_2_pi_waiter(a), __node_2_pi_waiter(b));
+	return rt_waiter_node_less(__node_2_rt_node(a), __node_2_rt_node(b));
 }
 
 static __always_inline void
 rt_mutex_enqueue_pi(struct task_struct *task, struct rt_mutex_waiter *waiter)
 {
-	rb_add_cached(&waiter->pi_tree_entry, &task->pi_waiters, __pi_waiter_less);
+	lockdep_assert_held(&task->pi_lock);
+
+	rb_add_cached(&waiter->pi_tree.entry, &task->pi_waiters, __pi_waiter_less);
 }
 
 static __always_inline void
 rt_mutex_dequeue_pi(struct task_struct *task, struct rt_mutex_waiter *waiter)
 {
-	if (RB_EMPTY_NODE(&waiter->pi_tree_entry))
+	lockdep_assert_held(&task->pi_lock);
+
+	if (RB_EMPTY_NODE(&waiter->pi_tree.entry))
 		return;
 
-	rb_erase_cached(&waiter->pi_tree_entry, &task->pi_waiters);
-	RB_CLEAR_NODE(&waiter->pi_tree_entry);
+	rb_erase_cached(&waiter->pi_tree.entry, &task->pi_waiters);
+	RB_CLEAR_NODE(&waiter->pi_tree.entry);
 }
 
-static __always_inline void rt_mutex_adjust_prio(struct task_struct *p)
+static __always_inline void rt_mutex_adjust_prio(struct rt_mutex_base *lock,
+						 struct task_struct *p)
 {
 	struct task_struct *pi_task = NULL;
 
+	lockdep_assert_held(&lock->wait_lock);
+	lockdep_assert(rt_mutex_owner(lock) == p);
 	lockdep_assert_held(&p->pi_lock);
 
 	if (task_has_pi_waiters(p))
@@ -571,9 +603,14 @@ static __always_inline struct rt_mutex_base *task_blocked_on_lock(struct task_st
  * Chain walk basics and protection scope
  *
  * [R] refcount on task
- * [P] task->pi_lock held
+ * [Pn] task->pi_lock held
  * [L] rtmutex->wait_lock held
  *
+ * Normal locking order:
+ *
+ *   rtmutex->wait_lock
+ *     task->pi_lock
+ *
  * Step	Description				Protected by
  *	function arguments:
  *	@task					[R]
@@ -588,27 +625,32 @@ static __always_inline struct rt_mutex_base *task_blocked_on_lock(struct task_st
  *	again:
  *	  loop_sanity_check();
  *	retry:
- * [1]	  lock(task->pi_lock);			[R] acquire [P]
- * [2]	  waiter = task->pi_blocked_on;		[P]
- * [3]	  check_exit_conditions_1();		[P]
- * [4]	  lock = waiter->lock;			[P]
- * [5]	  if (!try_lock(lock->wait_lock)) {	[P] try to acquire [L]
- *	    unlock(task->pi_lock);		release [P]
+ * [1]	  lock(task->pi_lock);			[R] acquire [P1]
+ * [2]	  waiter = task->pi_blocked_on;		[P1]
+ * [3]	  check_exit_conditions_1();		[P1]
+ * [4]	  lock = waiter->lock;			[P1]
+ * [5]	  if (!try_lock(lock->wait_lock)) {	[P1] try to acquire [L]
+ *	    unlock(task->pi_lock);		release [P1]
  *	    goto retry;
  *	  }
- * [6]	  check_exit_conditions_2();		[P] + [L]
- * [7]	  requeue_lock_waiter(lock, waiter);	[P] + [L]
- * [8]	  unlock(task->pi_lock);		release [P]
+ * [6]	  check_exit_conditions_2();		[P1] + [L]
+ * [7]	  requeue_lock_waiter(lock, waiter);	[P1] + [L]
+ * [8]	  unlock(task->pi_lock);		release [P1]
  *	  put_task_struct(task);		release [R]
  * [9]	  check_exit_conditions_3();		[L]
  * [10]	  task = owner(lock);			[L]
  *	  get_task_struct(task);		[L] acquire [R]
- *	  lock(task->pi_lock);			[L] acquire [P]
- * [11]	  requeue_pi_waiter(tsk, waiters(lock));[P] + [L]
- * [12]	  check_exit_conditions_4();		[P] + [L]
- * [13]	  unlock(task->pi_lock);		release [P]
+ *	  lock(task->pi_lock);			[L] acquire [P2]
+ * [11]	  requeue_pi_waiter(tsk, waiters(lock));[P2] + [L]
+ * [12]	  check_exit_conditions_4();		[P2] + [L]
+ * [13]	  unlock(task->pi_lock);		release [P2]
  *	  unlock(lock->wait_lock);		release [L]
  *	  goto again;
+ *
+ * Where P1 is the blocking task and P2 is the lock owner; going up one step
+ * the owner becomes the next blocked task etc..
+ *
+*
  */
 static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
 					      enum rtmutex_chainwalk chwalk,
@@ -756,7 +798,7 @@ static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
 	 * enabled we continue, but stop the requeueing in the chain
 	 * walk.
 	 */
-	if (rt_mutex_waiter_equal(waiter, task_to_waiter(task))) {
+	if (rt_waiter_node_equal(&waiter->tree, task_to_waiter_node(task))) {
 		if (!detect_deadlock)
 			goto out_unlock_pi;
 		else
@@ -764,13 +806,18 @@ static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
 	}
 
 	/*
-	 * [4] Get the next lock
+	 * [4] Get the next lock; per holding task->pi_lock we can't unblock
+	 * and guarantee @lock's existence.
 	 */
 	lock = waiter->lock;
 	/*
 	 * [5] We need to trylock here as we are holding task->pi_lock,
 	 * which is the reverse lock order versus the other rtmutex
 	 * operations.
+	 *
+	 * Per the above, holding task->pi_lock guarantees lock exists, so
+	 * inverting this lock order is infeasible from a life-time
+	 * perspective.
 	 */
 	if (!raw_spin_trylock(&lock->wait_lock)) {
 		raw_spin_unlock_irq(&task->pi_lock);
@@ -874,17 +921,18 @@ static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
 	 * or
 	 *
 	 *   DL CBS enforcement advancing the effective deadline.
-	 *
-	 * Even though pi_waiters also uses these fields, and that tree is only
-	 * updated in [11], we can do this here, since we hold [L], which
-	 * serializes all pi_waiters access and rb_erase() does not care about
-	 * the values of the node being removed.
 	 */
 	waiter_update_prio(waiter, task);
 
 	rt_mutex_enqueue(lock, waiter);
 
-	/* [8] Release the task */
+	/*
+	 * [8] Release the (blocking) task in preparation for
+	 * taking the owner task in [10].
+	 *
+	 * Since we hold lock->waiter_lock, task cannot unblock, even if we
+	 * release task->pi_lock.
+	 */
 	raw_spin_unlock(&task->pi_lock);
 	put_task_struct(task);
 
@@ -908,7 +956,12 @@ static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
 		return 0;
 	}
 
-	/* [10] Grab the next task, i.e. the owner of @lock */
+	/*
+	 * [10] Grab the next task, i.e. the owner of @lock
+	 *
+	 * Per holding lock->wait_lock and checking for !owner above, there
+	 * must be an owner and it cannot go away.
+	 */
 	task = get_task_struct(rt_mutex_owner(lock));
 	raw_spin_lock(&task->pi_lock);
 
@@ -921,8 +974,9 @@ static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
 		 * and adjust the priority of the owner.
 		 */
 		rt_mutex_dequeue_pi(task, prerequeue_top_waiter);
+		waiter_clone_prio(waiter, task);
 		rt_mutex_enqueue_pi(task, waiter);
-		rt_mutex_adjust_prio(task);
+		rt_mutex_adjust_prio(lock, task);
 
 	} else if (prerequeue_top_waiter == waiter) {
 		/*
@@ -937,8 +991,9 @@ static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
 		 */
 		rt_mutex_dequeue_pi(task, waiter);
 		waiter = rt_mutex_top_waiter(lock);
+		waiter_clone_prio(waiter, task);
 		rt_mutex_enqueue_pi(task, waiter);
-		rt_mutex_adjust_prio(task);
+		rt_mutex_adjust_prio(lock, task);
 	} else {
 		/*
 		 * Nothing changed. No need to do any priority
@@ -1154,6 +1209,7 @@ static int __sched task_blocks_on_rt_mutex(struct rt_mutex_base *lock,
 	waiter->task = task;
 	waiter->lock = lock;
 	waiter_update_prio(waiter, task);
+	waiter_clone_prio(waiter, task);
 
 	/* Get the top priority waiter on the lock */
 	if (rt_mutex_has_waiters(lock))
@@ -1187,7 +1243,7 @@ static int __sched task_blocks_on_rt_mutex(struct rt_mutex_base *lock,
 		rt_mutex_dequeue_pi(owner, top_waiter);
 		rt_mutex_enqueue_pi(owner, waiter);
 
-		rt_mutex_adjust_prio(owner);
+		rt_mutex_adjust_prio(lock, owner);
 		if (owner->pi_blocked_on)
 			chain_walk = 1;
 	} else if (rt_mutex_cond_detect_deadlock(waiter, chwalk)) {
@@ -1234,6 +1290,8 @@ static void __sched mark_wakeup_next_waiter(struct rt_wake_q_head *wqh,
 {
 	struct rt_mutex_waiter *waiter;
 
+	lockdep_assert_held(&lock->wait_lock);
+
 	raw_spin_lock(&current->pi_lock);
 
 	waiter = rt_mutex_top_waiter(lock);
@@ -1246,7 +1304,7 @@ static void __sched mark_wakeup_next_waiter(struct rt_wake_q_head *wqh,
 	 * task unblocks.
 	 */
 	rt_mutex_dequeue_pi(current, waiter);
-	rt_mutex_adjust_prio(current);
+	rt_mutex_adjust_prio(lock, current);
 
 	/*
 	 * As we are waking up the top waiter, and the waiter stays
@@ -1482,7 +1540,7 @@ static void __sched remove_waiter(struct rt_mutex_base *lock,
 	if (rt_mutex_has_waiters(lock))
 		rt_mutex_enqueue_pi(owner, rt_mutex_top_waiter(lock));
 
-	rt_mutex_adjust_prio(owner);
+	rt_mutex_adjust_prio(lock, owner);
 
 	/* Store the lock on which owner is blocked or NULL */
 	next_lock = task_blocked_on_lock(owner);
diff --git a/kernel/locking/rtmutex_api.c b/kernel/locking/rtmutex_api.c
index cb9fdff..a6974d0 100644
--- a/kernel/locking/rtmutex_api.c
+++ b/kernel/locking/rtmutex_api.c
@@ -459,7 +459,7 @@ void __sched rt_mutex_adjust_pi(struct task_struct *task)
 	raw_spin_lock_irqsave(&task->pi_lock, flags);
 
 	waiter = task->pi_blocked_on;
-	if (!waiter || rt_mutex_waiter_equal(waiter, task_to_waiter(task))) {
+	if (!waiter || rt_waiter_node_equal(&waiter->tree, task_to_waiter_node(task))) {
 		raw_spin_unlock_irqrestore(&task->pi_lock, flags);
 		return;
 	}
diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_common.h
index c47e836..1162e07 100644
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -17,27 +17,44 @@
 #include <linux/rtmutex.h>
 #include <linux/sched/wake_q.h>
 
+
+/*
+ * This is a helper for the struct rt_mutex_waiter below. A waiter goes in two
+ * separate trees and they need their own copy of the sort keys because of
+ * different locking requirements.
+ *
+ * @entry:		rbtree node to enqueue into the waiters tree
+ * @prio:		Priority of the waiter
+ * @deadline:		Deadline of the waiter if applicable
+ *
+ * See rt_waiter_node_less() and waiter_*_prio().
+ */
+struct rt_waiter_node {
+	struct rb_node	entry;
+	int		prio;
+	u64		deadline;
+};
+
 /*
  * This is the control structure for tasks blocked on a rt_mutex,
  * which is allocated on the kernel stack on of the blocked task.
  *
- * @tree_entry:		pi node to enqueue into the mutex waiters tree
- * @pi_tree_entry:	pi node to enqueue into the mutex owner waiters tree
+ * @tree:		node to enqueue into the mutex waiters tree
+ * @pi_tree:		node to enqueue into the mutex owner waiters tree
  * @task:		task reference to the blocked task
  * @lock:		Pointer to the rt_mutex on which the waiter blocks
  * @wake_state:		Wakeup state to use (TASK_NORMAL or TASK_RTLOCK_WAIT)
- * @prio:		Priority of the waiter
- * @deadline:		Deadline of the waiter if applicable
  * @ww_ctx:		WW context pointer
+ *
+ * @tree is ordered by @lock->wait_lock
+ * @pi_tree is ordered by rt_mutex_owner(@lock)->pi_lock
  */
 struct rt_mutex_waiter {
-	struct rb_node		tree_entry;
-	struct rb_node		pi_tree_entry;
+	struct rt_waiter_node	tree;
+	struct rt_waiter_node	pi_tree;
 	struct task_struct	*task;
 	struct rt_mutex_base	*lock;
 	unsigned int		wake_state;
-	int			prio;
-	u64			deadline;
 	struct ww_acquire_ctx	*ww_ctx;
 };
 
@@ -105,7 +122,7 @@ static inline bool rt_mutex_waiter_is_top_waiter(struct rt_mutex_base *lock,
 {
 	struct rb_node *leftmost = rb_first_cached(&lock->waiters);
 
-	return rb_entry(leftmost, struct rt_mutex_waiter, tree_entry) == waiter;
+	return rb_entry(leftmost, struct rt_mutex_waiter, tree.entry) == waiter;
 }
 
 static inline struct rt_mutex_waiter *rt_mutex_top_waiter(struct rt_mutex_base *lock)
@@ -113,8 +130,10 @@ static inline struct rt_mutex_waiter *rt_mutex_top_waiter(struct rt_mutex_base *
 	struct rb_node *leftmost = rb_first_cached(&lock->waiters);
 	struct rt_mutex_waiter *w = NULL;
 
+	lockdep_assert_held(&lock->wait_lock);
+
 	if (leftmost) {
-		w = rb_entry(leftmost, struct rt_mutex_waiter, tree_entry);
+		w = rb_entry(leftmost, struct rt_mutex_waiter, tree.entry);
 		BUG_ON(w->lock != lock);
 	}
 	return w;
@@ -127,8 +146,10 @@ static inline int task_has_pi_waiters(struct task_struct *p)
 
 static inline struct rt_mutex_waiter *task_top_pi_waiter(struct task_struct *p)
 {
+	lockdep_assert_held(&p->pi_lock);
+
 	return rb_entry(p->pi_waiters.rb_leftmost, struct rt_mutex_waiter,
-			pi_tree_entry);
+			pi_tree.entry);
 }
 
 #define RT_MUTEX_HAS_WAITERS	1UL
@@ -190,8 +211,8 @@ static inline void debug_rt_mutex_free_waiter(struct rt_mutex_waiter *waiter)
 static inline void rt_mutex_init_waiter(struct rt_mutex_waiter *waiter)
 {
 	debug_rt_mutex_init_waiter(waiter);
-	RB_CLEAR_NODE(&waiter->pi_tree_entry);
-	RB_CLEAR_NODE(&waiter->tree_entry);
+	RB_CLEAR_NODE(&waiter->pi_tree.entry);
+	RB_CLEAR_NODE(&waiter->tree.entry);
 	waiter->wake_state = TASK_NORMAL;
 	waiter->task = NULL;
 }
diff --git a/kernel/locking/ww_mutex.h b/kernel/locking/ww_mutex.h
index 56f1392..3ad2cc4 100644
--- a/kernel/locking/ww_mutex.h
+++ b/kernel/locking/ww_mutex.h
@@ -96,25 +96,25 @@ __ww_waiter_first(struct rt_mutex *lock)
 	struct rb_node *n = rb_first(&lock->rtmutex.waiters.rb_root);
 	if (!n)
 		return NULL;
-	return rb_entry(n, struct rt_mutex_waiter, tree_entry);
+	return rb_entry(n, struct rt_mutex_waiter, tree.entry);
 }
 
 static inline struct rt_mutex_waiter *
 __ww_waiter_next(struct rt_mutex *lock, struct rt_mutex_waiter *w)
 {
-	struct rb_node *n = rb_next(&w->tree_entry);
+	struct rb_node *n = rb_next(&w->tree.entry);
 	if (!n)
 		return NULL;
-	return rb_entry(n, struct rt_mutex_waiter, tree_entry);
+	return rb_entry(n, struct rt_mutex_waiter, tree.entry);
 }
 
 static inline struct rt_mutex_waiter *
 __ww_waiter_prev(struct rt_mutex *lock, struct rt_mutex_waiter *w)
 {
-	struct rb_node *n = rb_prev(&w->tree_entry);
+	struct rb_node *n = rb_prev(&w->tree.entry);
 	if (!n)
 		return NULL;
-	return rb_entry(n, struct rt_mutex_waiter, tree_entry);
+	return rb_entry(n, struct rt_mutex_waiter, tree.entry);
 }
 
 static inline struct rt_mutex_waiter *
@@ -123,7 +123,7 @@ __ww_waiter_last(struct rt_mutex *lock)
 	struct rb_node *n = rb_last(&lock->rtmutex.waiters.rb_root);
 	if (!n)
 		return NULL;
-	return rb_entry(n, struct rt_mutex_waiter, tree_entry);
+	return rb_entry(n, struct rt_mutex_waiter, tree.entry);
 }
 
 static inline void
