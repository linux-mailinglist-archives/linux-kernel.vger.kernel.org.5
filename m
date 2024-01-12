Return-Path: <linux-kernel+bounces-24825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 513F782C308
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 16:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8EB61F250F5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 15:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FB4768F3;
	Fri, 12 Jan 2024 15:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aO/cYc46"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9709768E0;
	Fri, 12 Jan 2024 15:46:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCAA9C43399;
	Fri, 12 Jan 2024 15:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705074408;
	bh=ghE3NvV6Osi8mVKGPqrvdRHt1SQMGOctvMN/yTIyii8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aO/cYc46DIMH3mlv7H3k3jWKxDvCCCttXDIa+56/NUh/ybmPJ0lMTmI/VO+ziEBHK
	 xFrxNxtFKQ2S0hr9f31ZYD4S9NviEMqUVtjmBT9n0I+qQBt1L8T46YWtgZbUEKS9NF
	 8EbPE9hpvs265Cqa+mq9q5EbXRc1Uw7WK4HCywWm3eBwXUBR1u8tI1RiwTkc/tNOi0
	 Vk6cATHsIKHWJ2nsXxNHiDEvTcqY9bCrdqi/tpe6CkiUHuCWa/6BItjDe8YgSJwmJc
	 +d2OdEXmySVgUwog8t+p91l/NFwOecEXeVIE5XQlO4z6+U/cdaMKdGLVyZwrM69Wyh
	 l5JhhgIz4bIag==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	rcu <rcu@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>
Subject: [PATCH 7/7] rcu/exp: Remove rcu_par_gp_wq
Date: Fri, 12 Jan 2024 16:46:21 +0100
Message-Id: <20240112154621.261852-8-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240112154621.261852-1-frederic@kernel.org>
References: <20240112154621.261852-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TREE04 running on short iterations can produce writer stalls of the
following kind:

 ??? Writer stall state RTWS_EXP_SYNC(4) g3968 f0x0 ->state 0x2 cpu 0
 task:rcu_torture_wri state:D stack:14568 pid:83    ppid:2      flags:0x00004000
 Call Trace:
  <TASK>
  __schedule+0x2de/0x850
  ? trace_event_raw_event_rcu_exp_funnel_lock+0x6d/0xb0
  schedule+0x4f/0x90
  synchronize_rcu_expedited+0x430/0x670
  ? __pfx_autoremove_wake_function+0x10/0x10
  ? __pfx_synchronize_rcu_expedited+0x10/0x10
  do_rtws_sync.constprop.0+0xde/0x230
  rcu_torture_writer+0x4b4/0xcd0
  ? __pfx_rcu_torture_writer+0x10/0x10
  kthread+0xc7/0xf0
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0x2f/0x50
  ? __pfx_kthread+0x10/0x10
  ret_from_fork_asm+0x1b/0x30
  </TASK>

Waiting for an expedited grace period and polling for an expedited
grace period both are operations that internally rely on the same
workqueue performing necessary asynchronous work.

However, a dependency chain is involved between those two operations,
as depicted below:

       ====== CPU 0 =======                          ====== CPU 1 =======

                                                     synchronize_rcu_expedited()
                                                         exp_funnel_lock()
                                                             mutex_lock(&rcu_state.exp_mutex);
    start_poll_synchronize_rcu_expedited
        queue_work(rcu_gp_wq, &rnp->exp_poll_wq);
                                                         synchronize_rcu_expedited_queue_work()
                                                             queue_work(rcu_gp_wq, &rew->rew_work);
                                                         wait_event() // A, wait for &rew->rew_work completion
                                                         mutex_unlock() // B
    //======> switch to kworker

    sync_rcu_do_polled_gp() {
        synchronize_rcu_expedited()
            exp_funnel_lock()
                mutex_lock(&rcu_state.exp_mutex); // C, wait B
                ....
    } // D

Since workqueues are usually implemented on top of several kworkers
handling the queue concurrently, the above situation wouldn't deadlock
most of the time because A then doesn't depend on D. But in case of
memory stress, a single kworker may end up handling alone all the works
in a serialized way. In that case the above layout becomes a problem
because A then waits for D, closing a circular dependency:

	A -> D -> C -> B -> A

This however only happens when CONFIG_RCU_EXP_KTHREAD=n. Indeed
synchronize_rcu_expedited() is otherwise implemented on top of a kthread
worker while polling still relies on rcu_gp_wq workqueue, breaking the
above circular dependency chain.

Fix this with making expedited grace period to always rely on kthread
worker. The workqueue based implementation is essentially a duplicate
anyway now that the per-node initialization is performed by per-node
kthread workers.

Meanwhile the CONFIG_RCU_EXP_KTHREAD switch is still kept around to
manage the scheduler policy of these kthread workers.

Reported-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Reported-by: Thomas Gleixner <tglx@linutronix.de>
Suggested-by: Joel Fernandes <joel@joelfernandes.org>
Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Suggested-by: Neeraj upadhyay <Neeraj.Upadhyay@amd.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/rcu.h      |  4 ---
 kernel/rcu/tree.c     | 40 ++++--------------------
 kernel/rcu/tree.h     |  6 +---
 kernel/rcu/tree_exp.h | 73 +------------------------------------------
 4 files changed, 8 insertions(+), 115 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 4bc8cd6d461e..4e65a92e528e 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -623,11 +623,7 @@ int rcu_get_gp_kthreads_prio(void);
 void rcu_fwd_progress_check(unsigned long j);
 void rcu_force_quiescent_state(void);
 extern struct workqueue_struct *rcu_gp_wq;
-#ifdef CONFIG_RCU_EXP_KTHREAD
 extern struct kthread_worker *rcu_exp_gp_kworker;
-#else /* !CONFIG_RCU_EXP_KTHREAD */
-extern struct workqueue_struct *rcu_par_gp_wq;
-#endif /* CONFIG_RCU_EXP_KTHREAD */
 void rcu_gp_slow_register(atomic_t *rgssp);
 void rcu_gp_slow_unregister(atomic_t *rgssp);
 #endif /* #else #ifdef CONFIG_TINY_RCU */
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 10fc2551d160..944e55085262 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4405,7 +4405,6 @@ rcu_boot_init_percpu_data(int cpu)
 	rcu_boot_init_nocb_percpu_data(rdp);
 }
 
-#ifdef CONFIG_RCU_EXP_KTHREAD
 struct kthread_worker *rcu_exp_gp_kworker;
 
 static void rcu_spawn_exp_par_gp_kworker(struct rcu_node *rnp)
@@ -4425,7 +4424,9 @@ static void rcu_spawn_exp_par_gp_kworker(struct rcu_node *rnp)
 		return;
 	}
 	WRITE_ONCE(rnp->exp_kworker, kworker);
-	sched_setscheduler_nocheck(kworker->task, SCHED_FIFO, &param);
+
+	if (IS_ENABLED(CONFIG_RCU_EXP_KTHREAD))
+		sched_setscheduler_nocheck(kworker->task, SCHED_FIFO, &param);
 }
 
 static struct task_struct *rcu_exp_par_gp_task(struct rcu_node *rnp)
@@ -4449,39 +4450,14 @@ static void __init rcu_start_exp_gp_kworker(void)
 		rcu_exp_gp_kworker = NULL;
 		return;
 	}
-	sched_setscheduler_nocheck(rcu_exp_gp_kworker->task, SCHED_FIFO, &param);
-}
-
-static inline void rcu_alloc_par_gp_wq(void)
-{
-}
-#else /* !CONFIG_RCU_EXP_KTHREAD */
-struct workqueue_struct *rcu_par_gp_wq;
-
-static void rcu_spawn_exp_par_gp_kworker(struct rcu_node *rnp)
-{
-}
-
-static struct task_struct *rcu_exp_par_gp_task(struct rcu_node *rnp)
-{
-	return NULL;
-}
-
-static void __init rcu_start_exp_gp_kworker(void)
-{
-}
 
-static inline void rcu_alloc_par_gp_wq(void)
-{
-	rcu_par_gp_wq = alloc_workqueue("rcu_par_gp", WQ_MEM_RECLAIM, 0);
-	WARN_ON(!rcu_par_gp_wq);
+	if (IS_ENABLED(CONFIG_RCU_EXP_KTHREAD))
+		sched_setscheduler_nocheck(rcu_exp_gp_kworker->task, SCHED_FIFO, &param);
 }
-#endif /* CONFIG_RCU_EXP_KTHREAD */
 
 static void rcu_spawn_rnp_kthreads(struct rcu_node *rnp)
 {
-	if ((IS_ENABLED(CONFIG_RCU_EXP_KTHREAD) ||
-	     IS_ENABLED(CONFIG_RCU_BOOST)) && rcu_scheduler_fully_active) {
+	if (rcu_scheduler_fully_active) {
 		mutex_lock(&rnp->kthread_mutex);
 		rcu_spawn_one_boost_kthread(rnp);
 		rcu_spawn_exp_par_gp_kworker(rnp);
@@ -4565,9 +4541,6 @@ static void rcutree_affinity_setting(unsigned int cpu, int outgoingcpu)
 	struct rcu_node *rnp;
 	struct task_struct *task_boost, *task_exp;
 
-	if (!IS_ENABLED(CONFIG_RCU_EXP_KTHREAD) && !IS_ENABLED(CONFIG_RCU_BOOST))
-		return;
-
 	rdp = per_cpu_ptr(&rcu_data, cpu);
 	rnp = rdp->mynode;
 
@@ -5256,7 +5229,6 @@ void __init rcu_init(void)
 	/* Create workqueue for Tree SRCU and for expedited GPs. */
 	rcu_gp_wq = alloc_workqueue("rcu_gp", WQ_MEM_RECLAIM, 0);
 	WARN_ON(!rcu_gp_wq);
-	rcu_alloc_par_gp_wq();
 
 	/* Fill in default value for rcutree.qovld boot parameter. */
 	/* -After- the rcu_node ->lock fields are initialized! */
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index e173808f486f..f35e47f24d80 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -21,14 +21,10 @@
 
 #include "rcu_segcblist.h"
 
-/* Communicate arguments to a workqueue handler. */
+/* Communicate arguments to a kthread worker handler. */
 struct rcu_exp_work {
 	unsigned long rew_s;
-#ifdef CONFIG_RCU_EXP_KTHREAD
 	struct kthread_work rew_work;
-#else
-	struct work_struct rew_work;
-#endif /* CONFIG_RCU_EXP_KTHREAD */
 };
 
 /* RCU's kthread states for tracing. */
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 0318a8a062d5..6b83537480b1 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -418,7 +418,6 @@ static void __sync_rcu_exp_select_node_cpus(struct rcu_exp_work *rewp)
 
 static void rcu_exp_sel_wait_wake(unsigned long s);
 
-#ifdef CONFIG_RCU_EXP_KTHREAD
 static void sync_rcu_exp_select_node_cpus(struct kthread_work *wp)
 {
 	struct rcu_exp_work *rewp =
@@ -470,69 +469,6 @@ static inline void synchronize_rcu_expedited_queue_work(struct rcu_exp_work *rew
 	kthread_queue_work(rcu_exp_gp_kworker, &rew->rew_work);
 }
 
-static inline void synchronize_rcu_expedited_destroy_work(struct rcu_exp_work *rew)
-{
-}
-#else /* !CONFIG_RCU_EXP_KTHREAD */
-static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
-{
-	struct rcu_exp_work *rewp =
-		container_of(wp, struct rcu_exp_work, rew_work);
-
-	__sync_rcu_exp_select_node_cpus(rewp);
-}
-
-static inline bool rcu_exp_worker_started(void)
-{
-	return !!READ_ONCE(rcu_gp_wq);
-}
-
-static inline bool rcu_exp_par_worker_started(struct rcu_node *rnp)
-{
-	return !!READ_ONCE(rcu_par_gp_wq);
-}
-
-static inline void sync_rcu_exp_select_cpus_queue_work(struct rcu_node *rnp)
-{
-	int cpu = find_next_bit(&rnp->ffmask, BITS_PER_LONG, -1);
-
-	INIT_WORK(&rnp->rew.rew_work, sync_rcu_exp_select_node_cpus);
-	/* If all offline, queue the work on an unbound CPU. */
-	if (unlikely(cpu > rnp->grphi - rnp->grplo))
-		cpu = WORK_CPU_UNBOUND;
-	else
-		cpu += rnp->grplo;
-	queue_work_on(cpu, rcu_par_gp_wq, &rnp->rew.rew_work);
-}
-
-static inline void sync_rcu_exp_select_cpus_flush_work(struct rcu_node *rnp)
-{
-	flush_work(&rnp->rew.rew_work);
-}
-
-/*
- * Work-queue handler to drive an expedited grace period forward.
- */
-static void wait_rcu_exp_gp(struct work_struct *wp)
-{
-	struct rcu_exp_work *rewp;
-
-	rewp = container_of(wp, struct rcu_exp_work, rew_work);
-	rcu_exp_sel_wait_wake(rewp->rew_s);
-}
-
-static inline void synchronize_rcu_expedited_queue_work(struct rcu_exp_work *rew)
-{
-	INIT_WORK_ONSTACK(&rew->rew_work, wait_rcu_exp_gp);
-	queue_work(rcu_gp_wq, &rew->rew_work);
-}
-
-static inline void synchronize_rcu_expedited_destroy_work(struct rcu_exp_work *rew)
-{
-	destroy_work_on_stack(&rew->rew_work);
-}
-#endif /* CONFIG_RCU_EXP_KTHREAD */
-
 /*
  * Select the nodes that the upcoming expedited grace period needs
  * to wait for.
@@ -965,7 +901,6 @@ static void rcu_exp_print_detail_task_stall_rnp(struct rcu_node *rnp)
  */
 void synchronize_rcu_expedited(void)
 {
-	bool use_worker;
 	unsigned long flags;
 	struct rcu_exp_work rew;
 	struct rcu_node *rnp;
@@ -976,9 +911,6 @@ void synchronize_rcu_expedited(void)
 			 lock_is_held(&rcu_sched_lock_map),
 			 "Illegal synchronize_rcu_expedited() in RCU read-side critical section");
 
-	use_worker = (rcu_scheduler_active != RCU_SCHEDULER_INIT) &&
-		      rcu_exp_worker_started();
-
 	/* Is the state is such that the call is a grace period? */
 	if (rcu_blocking_is_gp()) {
 		// Note well that this code runs with !PREEMPT && !SMP.
@@ -1008,7 +940,7 @@ void synchronize_rcu_expedited(void)
 		return;  /* Someone else did our work for us. */
 
 	/* Ensure that load happens before action based on it. */
-	if (unlikely(!use_worker)) {
+	if (unlikely((rcu_scheduler_active == RCU_SCHEDULER_INIT) || !rcu_exp_worker_started())) {
 		/* Direct call during scheduler init and early_initcalls(). */
 		rcu_exp_sel_wait_wake(s);
 	} else {
@@ -1025,9 +957,6 @@ void synchronize_rcu_expedited(void)
 
 	/* Let the next expedited grace period start. */
 	mutex_unlock(&rcu_state.exp_mutex);
-
-	if (likely(use_worker))
-		synchronize_rcu_expedited_destroy_work(&rew);
 }
 EXPORT_SYMBOL_GPL(synchronize_rcu_expedited);
 
-- 
2.34.1


