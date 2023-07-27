Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4B7765152
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 12:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjG0Kf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 06:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbjG0KfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 06:35:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517AC19A7;
        Thu, 27 Jul 2023 03:35:19 -0700 (PDT)
Date:   Thu, 27 Jul 2023 12:35:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690454116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=v6GgCz44QC8+oD/PfJ1zhMzPOIDSse10CCst0HKmibM=;
        b=d2lpNGOvaoS/pqwaweq7WSm+4VxRonR3/lYNN3xSD0VyiY4ooGcaEXaZssHG3f/5Y+lxMk
        QW27EapOICjxqZbSCRQArpNNiGo02oYQkQ3qt5EPVm0ve4ZGK+Hog9P7UiHg3yvdgrTwFO
        eMsu93JU82ax2HTKo2bvPX9HoEcEI4CDtCOtaSrXAsAx/U43u3Bcidj+zVsJ6xMGhPAaG5
        OTN1EvpPHCfxSo/5mAqHI9hL2LhMZQdB+RDnkM5Tb1j5WfRHWSC7d2Fq4LMpM95p0lul+m
        qa0FqMu8lQmM2mJO7OKbSb6cWKRBKK2mcBU6g/oJYnoLjDZULtswNxXNtcZeGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690454116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=v6GgCz44QC8+oD/PfJ1zhMzPOIDSse10CCst0HKmibM=;
        b=5QN4fJEptS1QfY+FQx/rNvePbEFGxV9UwC7FBFvWYY94E2Za/TdI7MLj3ve46rKrs/usCy
        B2keVO/L+c3E8bCg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.4.6-rt8
Message-ID: <20230727103514.ePGRJLNE@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v6.4.6-rt8 patch set. 

Changes since v6.4.6-rt7:

  - Hu Chunyu reported that a task can be released in the wrong context.
    This can happen for instance if the task is using the DL scheduling
    policy. Patch by Wander Lairson.

  - Henry Wu reported a problem within the rtmutex code that can occur
    during PI-boosting. Patch by Peter Zijlstra.

  - Paul Gortmaker reported a warning during reset in the i915 driver.
    Patch by Tvrtko Ursulin.

Known issues
     None

The delta patch against v6.4.6-rt7 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.4/incr/patch-6.4.6-rt7-rt8.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.4.6-rt8

The RT patch against v6.4.6 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.4/older/patch-6.4.6-rt8.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.4/older/patches-6.4.6-rt8.tar.xz

Sebastian

diff --git a/drivers/gpu/drm/i915/gt/intel_reset.c b/drivers/gpu/drm/i915/gt/intel_reset.c
index 797ea8340467e..21e50c7d8ce91 100644
--- a/drivers/gpu/drm/i915/gt/intel_reset.c
+++ b/drivers/gpu/drm/i915/gt/intel_reset.c
@@ -166,13 +166,13 @@ static int i915_do_reset(struct intel_gt *gt,
 	/* Assert reset for at least 20 usec, and wait for acknowledgement. */
 	pci_write_config_byte(pdev, I915_GDRST, GRDOM_RESET_ENABLE);
 	udelay(50);
-	err = wait_for_atomic(i915_in_reset(pdev), 50);
+	err = _wait_for_atomic(i915_in_reset(pdev), 50, 0);
 
 	/* Clear the reset request. */
 	pci_write_config_byte(pdev, I915_GDRST, 0);
 	udelay(50);
 	if (!err)
-		err = wait_for_atomic(!i915_in_reset(pdev), 50);
+		err = _wait_for_atomic(!i915_in_reset(pdev), 50, 0);
 
 	return err;
 }
@@ -192,7 +192,7 @@ static int g33_do_reset(struct intel_gt *gt,
 	struct pci_dev *pdev = to_pci_dev(gt->i915->drm.dev);
 
 	pci_write_config_byte(pdev, I915_GDRST, GRDOM_RESET_ENABLE);
-	return wait_for_atomic(g4x_reset_complete(pdev), 50);
+	return _wait_for_atomic(g4x_reset_complete(pdev), 50, 0);
 }
 
 static int g4x_do_reset(struct intel_gt *gt,
@@ -209,7 +209,7 @@ static int g4x_do_reset(struct intel_gt *gt,
 
 	pci_write_config_byte(pdev, I915_GDRST,
 			      GRDOM_MEDIA | GRDOM_RESET_ENABLE);
-	ret =  wait_for_atomic(g4x_reset_complete(pdev), 50);
+	ret =  _wait_for_atomic(g4x_reset_complete(pdev), 50, 0);
 	if (ret) {
 		GT_TRACE(gt, "Wait for media reset failed\n");
 		goto out;
@@ -217,7 +217,7 @@ static int g4x_do_reset(struct intel_gt *gt,
 
 	pci_write_config_byte(pdev, I915_GDRST,
 			      GRDOM_RENDER | GRDOM_RESET_ENABLE);
-	ret =  wait_for_atomic(g4x_reset_complete(pdev), 50);
+	ret =  _wait_for_atomic(g4x_reset_complete(pdev), 50, 0);
 	if (ret) {
 		GT_TRACE(gt, "Wait for render reset failed\n");
 		goto out;
@@ -787,9 +787,7 @@ int __intel_gt_reset(struct intel_gt *gt, intel_engine_mask_t engine_mask)
 		reset_mask = wa_14015076503_start(gt, engine_mask, !retry);
 
 		GT_TRACE(gt, "engine_mask=%x\n", reset_mask);
-		preempt_disable();
 		ret = reset(gt, reset_mask, retry);
-		preempt_enable();
 
 		wa_14015076503_end(gt, reset_mask);
 	}
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index e0f5ac90a228b..b539090277714 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -118,11 +118,47 @@ static inline struct task_struct *get_task_struct(struct task_struct *t)
 }
 
 extern void __put_task_struct(struct task_struct *t);
+extern void __put_task_struct_rcu_cb(struct rcu_head *rhp);
 
 static inline void put_task_struct(struct task_struct *t)
 {
-	if (refcount_dec_and_test(&t->usage))
+	if (!refcount_dec_and_test(&t->usage))
+		return;
+
+	/*
+	 * In !RT, it is always safe to call __put_task_struct().
+	 * Under RT, we can only call it in preemptible context.
+	 */
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible()) {
+		static DEFINE_WAIT_OVERRIDE_MAP(put_task_map, LD_WAIT_SLEEP);
+
+		lock_map_acquire_try(&put_task_map);
 		__put_task_struct(t);
+		lock_map_release(&put_task_map);
+		return;
+	}
+
+	/*
+	 * under PREEMPT_RT, we can't call put_task_struct
+	 * in atomic context because it will indirectly
+	 * acquire sleeping locks.
+	 *
+	 * call_rcu() will schedule delayed_put_task_struct_rcu()
+	 * to be called in process context.
+	 *
+	 * __put_task_struct() is called when
+	 * refcount_dec_and_test(&t->usage) succeeds.
+	 *
+	 * This means that it can't "conflict" with
+	 * put_task_struct_rcu_user() which abuses ->rcu the same
+	 * way; rcu_users has a reference so task->usage can't be
+	 * zero after rcu_users 1 -> 0 transition.
+	 *
+	 * delayed_free_task() also uses ->rcu, but it is only called
+	 * when it fails to fork a process. Therefore, there is no
+	 * way it can conflict with put_task_struct().
+	 */
+	call_rcu(&t->rcu, __put_task_struct_rcu_cb);
 }
 
 static inline void put_task_struct_many(struct task_struct *t, int nr)
diff --git a/kernel/fork.c b/kernel/fork.c
index 8103ffd217e97..38cfcfbd8b489 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -989,6 +989,14 @@ void __put_task_struct(struct task_struct *tsk)
 }
 EXPORT_SYMBOL_GPL(__put_task_struct);
 
+void __put_task_struct_rcu_cb(struct rcu_head *rhp)
+{
+	struct task_struct *task = container_of(rhp, struct task_struct, rcu);
+
+	__put_task_struct(task);
+}
+EXPORT_SYMBOL_GPL(__put_task_struct_rcu_cb);
+
 void __init __weak arch_task_cache_init(void) { }
 
 /*
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 479a9487edcc2..08a4555076f73 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -356,21 +356,43 @@ static __always_inline int __waiter_prio(struct task_struct *task)
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
 }
 
 /*
- * Only use with rt_mutex_waiter_{less,equal}()
+ * Update the waiter->pi_tree copy of the sort keys (from the tree copy).
  */
-#define task_to_waiter(p)	\
-	&(struct rt_mutex_waiter){ .prio = __waiter_prio(p), .deadline = (p)->dl.deadline }
+static __always_inline void
+waiter_clone_prio(struct rt_mutex_waiter *waiter, struct task_struct *task)
+{
+	lockdep_assert_held(&waiter->lock->wait_lock);
+	lockdep_assert_held(&task->pi_lock);
+	lockdep_assert(RB_EMPTY_NODE(&waiter->pi_tree.entry));
 
-static __always_inline int rt_mutex_waiter_less(struct rt_mutex_waiter *left,
-						struct rt_mutex_waiter *right)
+	waiter->pi_tree.prio = waiter->tree.prio;
+	waiter->pi_tree.deadline = waiter->tree.deadline;
+}
+
+/*
+ * Only use with rt_waiter_node_{less,equal}()
+ */
+#define task_to_waiter_node(p)	\
+	&(struct rt_waiter_node){ .prio = __waiter_prio(p), .deadline = (p)->dl.deadline }
+#define task_to_waiter(p)	\
+	&(struct rt_mutex_waiter){ .tree = *task_to_waiter_node(p) }
+
+static __always_inline int rt_waiter_node_less(struct rt_waiter_node *left,
+					       struct rt_waiter_node *right)
 {
 	if (left->prio < right->prio)
 		return 1;
@@ -387,8 +409,8 @@ static __always_inline int rt_mutex_waiter_less(struct rt_mutex_waiter *left,
 	return 0;
 }
 
-static __always_inline int rt_mutex_waiter_equal(struct rt_mutex_waiter *left,
-						 struct rt_mutex_waiter *right)
+static __always_inline int rt_waiter_node_equal(struct rt_waiter_node *left,
+						 struct rt_waiter_node *right)
 {
 	if (left->prio != right->prio)
 		return 0;
@@ -408,7 +430,7 @@ static __always_inline int rt_mutex_waiter_equal(struct rt_mutex_waiter *left,
 static inline bool rt_mutex_steal(struct rt_mutex_waiter *waiter,
 				  struct rt_mutex_waiter *top_waiter)
 {
-	if (rt_mutex_waiter_less(waiter, top_waiter))
+	if (rt_waiter_node_less(&waiter->tree, &top_waiter->tree))
 		return true;
 
 #ifdef RT_MUTEX_BUILD_SPINLOCKS
@@ -416,30 +438,30 @@ static inline bool rt_mutex_steal(struct rt_mutex_waiter *waiter,
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
@@ -457,48 +479,58 @@ static __always_inline bool __waiter_less(struct rb_node *a, const struct rb_nod
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
@@ -594,9 +626,14 @@ static __always_inline struct rt_mutex_base *task_blocked_on_lock(struct task_st
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
@@ -611,27 +648,32 @@ static __always_inline struct rt_mutex_base *task_blocked_on_lock(struct task_st
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
@@ -779,7 +821,7 @@ static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
 	 * enabled we continue, but stop the requeueing in the chain
 	 * walk.
 	 */
-	if (rt_mutex_waiter_equal(waiter, task_to_waiter(task))) {
+	if (rt_waiter_node_equal(&waiter->tree, task_to_waiter_node(task))) {
 		if (!detect_deadlock)
 			goto out_unlock_pi;
 		else
@@ -787,13 +829,18 @@ static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
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
@@ -897,17 +944,18 @@ static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
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
 
@@ -931,7 +979,12 @@ static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
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
 
@@ -944,8 +997,9 @@ static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
 		 * and adjust the priority of the owner.
 		 */
 		rt_mutex_dequeue_pi(task, prerequeue_top_waiter);
+		waiter_clone_prio(waiter, task);
 		rt_mutex_enqueue_pi(task, waiter);
-		rt_mutex_adjust_prio(task);
+		rt_mutex_adjust_prio(lock, task);
 
 	} else if (prerequeue_top_waiter == waiter) {
 		/*
@@ -960,8 +1014,9 @@ static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
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
@@ -1177,6 +1232,7 @@ static int __sched task_blocks_on_rt_mutex(struct rt_mutex_base *lock,
 	waiter->task = task;
 	waiter->lock = lock;
 	waiter_update_prio(waiter, task);
+	waiter_clone_prio(waiter, task);
 
 	/* Get the top priority waiter on the lock */
 	if (rt_mutex_has_waiters(lock))
@@ -1210,7 +1266,7 @@ static int __sched task_blocks_on_rt_mutex(struct rt_mutex_base *lock,
 		rt_mutex_dequeue_pi(owner, top_waiter);
 		rt_mutex_enqueue_pi(owner, waiter);
 
-		rt_mutex_adjust_prio(owner);
+		rt_mutex_adjust_prio(lock, owner);
 		if (owner->pi_blocked_on)
 			chain_walk = 1;
 	} else if (rt_mutex_cond_detect_deadlock(waiter, chwalk)) {
@@ -1257,6 +1313,8 @@ static void __sched mark_wakeup_next_waiter(struct rt_wake_q_head *wqh,
 {
 	struct rt_mutex_waiter *waiter;
 
+	lockdep_assert_held(&lock->wait_lock);
+
 	raw_spin_lock(&current->pi_lock);
 
 	waiter = rt_mutex_top_waiter(lock);
@@ -1269,7 +1327,7 @@ static void __sched mark_wakeup_next_waiter(struct rt_wake_q_head *wqh,
 	 * task unblocks.
 	 */
 	rt_mutex_dequeue_pi(current, waiter);
-	rt_mutex_adjust_prio(current);
+	rt_mutex_adjust_prio(lock, current);
 
 	/*
 	 * As we are waking up the top waiter, and the waiter stays
@@ -1505,7 +1563,7 @@ static void __sched remove_waiter(struct rt_mutex_base *lock,
 	if (rt_mutex_has_waiters(lock))
 		rt_mutex_enqueue_pi(owner, rt_mutex_top_waiter(lock));
 
-	rt_mutex_adjust_prio(owner);
+	rt_mutex_adjust_prio(lock, owner);
 
 	/* Store the lock on which owner is blocked or NULL */
 	next_lock = task_blocked_on_lock(owner);
diff --git a/kernel/locking/rtmutex_api.c b/kernel/locking/rtmutex_api.c
index cb9fdff76a8a3..a6974d0445930 100644
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
index c47e8361bfb5c..1162e07cdaea1 100644
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
index 56f139201f246..3ad2cc4823e59 100644
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
diff --git a/localversion-rt b/localversion-rt
index 045478966e9f1..700c857efd9ba 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt7
+-rt8
