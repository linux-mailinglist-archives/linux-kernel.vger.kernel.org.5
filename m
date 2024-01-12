Return-Path: <linux-kernel+bounces-24823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AEF82C306
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 16:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 681651F25154
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 15:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F3974E05;
	Fri, 12 Jan 2024 15:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B3LfSmTl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B28F745FD;
	Fri, 12 Jan 2024 15:46:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF70C43390;
	Fri, 12 Jan 2024 15:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705074403;
	bh=1IQabjvd17B12deVrDUr1/xKUrLOgjkUshKCpo4h+Yg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B3LfSmTlRJu9qNVlOBptMzJL5aEZLZ3OlaQSdxWnjzg7y3ayQ5ET4FUnIPEvGSZuL
	 mnqF6MCbdpeZsZaX7XtPZyONoRN/4bW0yY6fPK+l0PhcyM+Z5jKo8pIOjUngWXKaTI
	 0v24jY6KX9Hf6DIJhpxipvdGow8jkn1IZSQB19Qevn9mz0S4PJhRCBZQN3TArUpBOL
	 AU9hpr2dN+/jRlHH/A139XCZwvKPX9RxZ8uRi9bpAujfOWsQNfXWdguVHVSV80fhyz
	 IAph+yPXe2Pc1M2cQfkGlT0p2W7O7bvECk5oqE6jlDVqU0hBMKFN7uz+ST3Gm8Y8CY
	 g3ENoYMFadDuQ==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	rcu <rcu@vger.kernel.org>
Subject: [PATCH 5/7] rcu/exp: Make parallel exp gp kworker per rcu node
Date: Fri, 12 Jan 2024 16:46:19 +0100
Message-Id: <20240112154621.261852-6-frederic@kernel.org>
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

When CONFIG_RCU_EXP_KTHREAD=n, the expedited grace period per node
initialization is performed in parallel via workqueues (one work per
node).

However in CONFIG_RCU_EXP_KTHREAD=y, this per node initialization is
performed by a single kworker serializing each node initialization (one
work for all nodes).

The second part is certainly less scalable and efficient beyond a single
leaf node.

To improve this, expand this single kworker into per-node kworkers. This
new layout is eventually intended to remove the workqueues based
implementation since it will essentially now become duplicate code.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/rcu.h         |  1 -
 kernel/rcu/tree.c        | 65 ++++++++++++++++++++++++++--------------
 kernel/rcu/tree.h        |  3 ++
 kernel/rcu/tree_exp.h    | 10 +++----
 kernel/rcu/tree_plugin.h | 10 ++-----
 5 files changed, 54 insertions(+), 35 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index dcfb666f2499..4bc8cd6d461e 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -625,7 +625,6 @@ void rcu_force_quiescent_state(void);
 extern struct workqueue_struct *rcu_gp_wq;
 #ifdef CONFIG_RCU_EXP_KTHREAD
 extern struct kthread_worker *rcu_exp_gp_kworker;
-extern struct kthread_worker *rcu_exp_par_gp_kworker;
 #else /* !CONFIG_RCU_EXP_KTHREAD */
 extern struct workqueue_struct *rcu_par_gp_wq;
 #endif /* CONFIG_RCU_EXP_KTHREAD */
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8f4fc8882e93..af6dd4e0be48 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4407,33 +4407,39 @@ rcu_boot_init_percpu_data(int cpu)
 
 #ifdef CONFIG_RCU_EXP_KTHREAD
 struct kthread_worker *rcu_exp_gp_kworker;
-struct kthread_worker *rcu_exp_par_gp_kworker;
 
-static void __init rcu_start_exp_gp_kworkers(void)
+static void rcu_spawn_exp_par_gp_kworker(struct rcu_node *rnp)
 {
-	const char *par_gp_kworker_name = "rcu_exp_par_gp_kthread_worker";
-	const char *gp_kworker_name = "rcu_exp_gp_kthread_worker";
+	struct kthread_worker *kworker;
+	const char *name = "rcu_exp_par_gp_kthread_worker/%d";
 	struct sched_param param = { .sched_priority = kthread_prio };
+	int rnp_index = rnp - rcu_get_root();
 
-	rcu_exp_gp_kworker = kthread_create_worker(0, gp_kworker_name);
+	if (rnp->exp_kworker)
+		return;
+
+	kworker = kthread_create_worker(0, name, rnp_index);
+	if (IS_ERR_OR_NULL(kworker)) {
+		pr_err("Failed to create par gp kworker on %d/%d\n",
+		       rnp->grplo, rnp->grphi);
+		return;
+	}
+	WRITE_ONCE(rnp->exp_kworker, kworker);
+	sched_setscheduler_nocheck(kworker->task, SCHED_FIFO, &param);
+}
+
+static void __init rcu_start_exp_gp_kworker(void)
+{
+	const char *name = "rcu_exp_gp_kthread_worker";
+	struct sched_param param = { .sched_priority = kthread_prio };
+
+	rcu_exp_gp_kworker = kthread_create_worker(0, name);
 	if (IS_ERR_OR_NULL(rcu_exp_gp_kworker)) {
-		pr_err("Failed to create %s!\n", gp_kworker_name);
+		pr_err("Failed to create %s!\n", name);
 		rcu_exp_gp_kworker = NULL;
 		return;
 	}
-
-	rcu_exp_par_gp_kworker = kthread_create_worker(0, par_gp_kworker_name);
-	if (IS_ERR_OR_NULL(rcu_exp_par_gp_kworker)) {
-		pr_err("Failed to create %s!\n", par_gp_kworker_name);
-		rcu_exp_par_gp_kworker = NULL;
-		kthread_destroy_worker(rcu_exp_gp_kworker);
-		rcu_exp_gp_kworker = NULL;
-		return;
-	}
-
 	sched_setscheduler_nocheck(rcu_exp_gp_kworker->task, SCHED_FIFO, &param);
-	sched_setscheduler_nocheck(rcu_exp_par_gp_kworker->task, SCHED_FIFO,
-				   &param);
 }
 
 static inline void rcu_alloc_par_gp_wq(void)
@@ -4442,7 +4448,11 @@ static inline void rcu_alloc_par_gp_wq(void)
 #else /* !CONFIG_RCU_EXP_KTHREAD */
 struct workqueue_struct *rcu_par_gp_wq;
 
-static void __init rcu_start_exp_gp_kworkers(void)
+static void rcu_spawn_exp_par_gp_kworker(struct rcu_node *rnp)
+{
+}
+
+static void __init rcu_start_exp_gp_kworker(void)
 {
 }
 
@@ -4453,6 +4463,17 @@ static inline void rcu_alloc_par_gp_wq(void)
 }
 #endif /* CONFIG_RCU_EXP_KTHREAD */
 
+static void rcu_spawn_rnp_kthreads(struct rcu_node *rnp)
+{
+	if ((IS_ENABLED(CONFIG_RCU_EXP_KTHREAD) ||
+	     IS_ENABLED(CONFIG_RCU_BOOST)) && rcu_scheduler_fully_active) {
+		mutex_lock(&rnp->kthread_mutex);
+		rcu_spawn_one_boost_kthread(rnp);
+		rcu_spawn_exp_par_gp_kworker(rnp);
+		mutex_unlock(&rnp->kthread_mutex);
+	}
+}
+
 /*
  * Invoked early in the CPU-online process, when pretty much all services
  * are available.  The incoming CPU is not present.
@@ -4501,7 +4522,7 @@ int rcutree_prepare_cpu(unsigned int cpu)
 	rdp->rcu_iw_gp_seq = rdp->gp_seq - 1;
 	trace_rcu_grace_period(rcu_state.name, rdp->gp_seq, TPS("cpuonl"));
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
-	rcu_spawn_one_boost_kthread(rnp);
+	rcu_spawn_rnp_kthreads(rnp);
 	rcu_spawn_cpu_nocb_kthread(cpu);
 	WRITE_ONCE(rcu_state.n_online_cpus, rcu_state.n_online_cpus + 1);
 
@@ -4823,10 +4844,10 @@ static int __init rcu_spawn_gp_kthread(void)
 	 * due to rcu_scheduler_fully_active.
 	 */
 	rcu_spawn_cpu_nocb_kthread(smp_processor_id());
-	rcu_spawn_one_boost_kthread(rdp->mynode);
+	rcu_spawn_rnp_kthreads(rdp->mynode);
 	rcu_spawn_core_kthreads();
 	/* Create kthread worker for expedited GPs */
-	rcu_start_exp_gp_kworkers();
+	rcu_start_exp_gp_kworker();
 	return 0;
 }
 early_initcall(rcu_spawn_gp_kthread);
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 13e7b0d907ab..e173808f486f 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -72,6 +72,9 @@ struct rcu_node {
 				/* Online CPUs for next expedited GP. */
 				/*  Any CPU that has ever been online will */
 				/*  have its bit set. */
+	struct kthread_worker *exp_kworker;
+				/* Workers performing per node expedited GP */
+				/* initialization. */
 	unsigned long cbovldmask;
 				/* CPUs experiencing callback overload. */
 	unsigned long ffmask;	/* Fully functional CPUs. */
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 6123a60d9a4d..0318a8a062d5 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -432,9 +432,9 @@ static inline bool rcu_exp_worker_started(void)
 	return !!READ_ONCE(rcu_exp_gp_kworker);
 }
 
-static inline bool rcu_exp_par_worker_started(void)
+static inline bool rcu_exp_par_worker_started(struct rcu_node *rnp)
 {
-	return !!READ_ONCE(rcu_exp_par_gp_kworker);
+	return !!READ_ONCE(rnp->exp_kworker);
 }
 
 static inline void sync_rcu_exp_select_cpus_queue_work(struct rcu_node *rnp)
@@ -445,7 +445,7 @@ static inline void sync_rcu_exp_select_cpus_queue_work(struct rcu_node *rnp)
 	 * another work item on the same kthread worker can result in
 	 * deadlock.
 	 */
-	kthread_queue_work(rcu_exp_par_gp_kworker, &rnp->rew.rew_work);
+	kthread_queue_work(READ_ONCE(rnp->exp_kworker), &rnp->rew.rew_work);
 }
 
 static inline void sync_rcu_exp_select_cpus_flush_work(struct rcu_node *rnp)
@@ -487,7 +487,7 @@ static inline bool rcu_exp_worker_started(void)
 	return !!READ_ONCE(rcu_gp_wq);
 }
 
-static inline bool rcu_exp_par_worker_started(void)
+static inline bool rcu_exp_par_worker_started(struct rcu_node *rnp)
 {
 	return !!READ_ONCE(rcu_par_gp_wq);
 }
@@ -550,7 +550,7 @@ static void sync_rcu_exp_select_cpus(void)
 		rnp->exp_need_flush = false;
 		if (!READ_ONCE(rnp->expmask))
 			continue; /* Avoid early boot non-existent wq. */
-		if (!rcu_exp_par_worker_started() ||
+		if (!rcu_exp_par_worker_started(rnp) ||
 		    rcu_scheduler_active != RCU_SCHEDULER_RUNNING ||
 		    rcu_is_last_leaf_node(rnp)) {
 			/* No worker started yet or last leaf, do direct call. */
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 0d307674915c..09bdd36ca9ff 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1195,14 +1195,13 @@ static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
 	struct sched_param sp;
 	struct task_struct *t;
 
-	mutex_lock(&rnp->kthread_mutex);
-	if (rnp->boost_kthread_task || !rcu_scheduler_fully_active)
-		goto out;
+	if (rnp->boost_kthread_task)
+		return;
 
 	t = kthread_create(rcu_boost_kthread, (void *)rnp,
 			   "rcub/%d", rnp_index);
 	if (WARN_ON_ONCE(IS_ERR(t)))
-		goto out;
+		return;
 
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
 	rnp->boost_kthread_task = t;
@@ -1210,9 +1209,6 @@ static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
 	sp.sched_priority = kthread_prio;
 	sched_setscheduler_nocheck(t, SCHED_FIFO, &sp);
 	wake_up_process(t); /* get to TASK_INTERRUPTIBLE quickly. */
-
- out:
-	mutex_unlock(&rnp->kthread_mutex);
 }
 
 /*
-- 
2.34.1


