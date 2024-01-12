Return-Path: <linux-kernel+bounces-24824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF54182C307
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 16:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09337B23DF8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 15:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A7F74E2A;
	Fri, 12 Jan 2024 15:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tY1pMKUv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CFF74E1B;
	Fri, 12 Jan 2024 15:46:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95A49C433F1;
	Fri, 12 Jan 2024 15:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705074405;
	bh=W7d1v2FEbfmQrL73SdAC9c2Lc8l9OAodYD1knjYh+P4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tY1pMKUvqPs4oTm7xBPHiPsvQ2a569yt4ovw2IxwZDbiF4LTJmkCx0DcjDP4H8lJ4
	 AKX7YqSCLH3V5SdLMJrVJhUoMrsgZ9SDB8ndMj8SQ2huSe1WSC3c6FJnpz4+MumGNs
	 EECSZkOOFlv1ErfuABj0T8MDwFL7zJ0UCHmNStCelDdktnXPSmuPp/Murka0QHO0Bs
	 h45+ghD5v/5hNzg8zLDB1dFZsvApDDTvxngIPNxBjnqIIs75qD3Ap7ApxmKKj81no3
	 RH1m5R0x7FBvCKNXkv6YnnPSZL6CA5pK9NUDZ9OTCEIgWSUhI+Retrwt+zaTncornM
	 ET2C1lKttjnfw==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	rcu <rcu@vger.kernel.org>
Subject: [PATCH 6/7] rcu/exp: Handle parallel exp gp kworkers affinity
Date: Fri, 12 Jan 2024 16:46:20 +0100
Message-Id: <20240112154621.261852-7-frederic@kernel.org>
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

Affine the parallel expedited gp kworkers to their respective RCU node
in order to make them close to the cache their are playing with.

This reuses the boost kthreads machinery that probe into CPU hotplug
operations such that the kthreads become/stay affine to their respective
node as soon/long as they contain online CPUs. Otherwise and if the
current CPU going down was the last online on the leaf node, the related
kthread is affine to the housekeeping CPUs.

In the long run, this affinity VS CPU hotplug operation game should
probably be implemented at the generic kthread level.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree.c        | 79 +++++++++++++++++++++++++++++++++++++---
 kernel/rcu/tree_plugin.h | 42 ++-------------------
 2 files changed, 78 insertions(+), 43 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index af6dd4e0be48..10fc2551d160 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -145,7 +145,7 @@ static int rcu_scheduler_fully_active __read_mostly;
 
 static void rcu_report_qs_rnp(unsigned long mask, struct rcu_node *rnp,
 			      unsigned long gps, unsigned long flags);
-static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu);
+static struct task_struct *rcu_boost_task(struct rcu_node *rnp);
 static void invoke_rcu_core(void);
 static void rcu_report_exp_rdp(struct rcu_data *rdp);
 static void sync_sched_exp_online_cleanup(int cpu);
@@ -4428,6 +4428,16 @@ static void rcu_spawn_exp_par_gp_kworker(struct rcu_node *rnp)
 	sched_setscheduler_nocheck(kworker->task, SCHED_FIFO, &param);
 }
 
+static struct task_struct *rcu_exp_par_gp_task(struct rcu_node *rnp)
+{
+	struct kthread_worker *kworker = READ_ONCE(rnp->exp_kworker);
+
+	if (!kworker)
+		return NULL;
+
+	return kworker->task;
+}
+
 static void __init rcu_start_exp_gp_kworker(void)
 {
 	const char *name = "rcu_exp_gp_kthread_worker";
@@ -4452,6 +4462,11 @@ static void rcu_spawn_exp_par_gp_kworker(struct rcu_node *rnp)
 {
 }
 
+static struct task_struct *rcu_exp_par_gp_task(struct rcu_node *rnp)
+{
+	return NULL;
+}
+
 static void __init rcu_start_exp_gp_kworker(void)
 {
 }
@@ -4530,13 +4545,67 @@ int rcutree_prepare_cpu(unsigned int cpu)
 }
 
 /*
- * Update RCU priority boot kthread affinity for CPU-hotplug changes.
+ * Update kthreads affinity during CPU-hotplug changes.
+ *
+ * Set the per-rcu_node kthread's affinity to cover all CPUs that are
+ * served by the rcu_node in question.  The CPU hotplug lock is still
+ * held, so the value of rnp->qsmaskinit will be stable.
+ *
+ * We don't include outgoingcpu in the affinity set, use -1 if there is
+ * no outgoing CPU.  If there are no CPUs left in the affinity set,
+ * this function allows the kthread to execute on any CPU.
+ *
+ * Any future concurrent calls are serialized via ->kthread_mutex.
  */
-static void rcutree_affinity_setting(unsigned int cpu, int outgoing)
+static void rcutree_affinity_setting(unsigned int cpu, int outgoingcpu)
 {
-	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
+	cpumask_var_t cm;
+	unsigned long mask;
+	struct rcu_data *rdp;
+	struct rcu_node *rnp;
+	struct task_struct *task_boost, *task_exp;
 
-	rcu_boost_kthread_setaffinity(rdp->mynode, outgoing);
+	if (!IS_ENABLED(CONFIG_RCU_EXP_KTHREAD) && !IS_ENABLED(CONFIG_RCU_BOOST))
+		return;
+
+	rdp = per_cpu_ptr(&rcu_data, cpu);
+	rnp = rdp->mynode;
+
+	task_boost = rcu_boost_task(rnp);
+	task_exp = rcu_exp_par_gp_task(rnp);
+
+	/*
+	 * If CPU is the boot one, those tasks are created later from early
+	 * initcall since kthreadd must be created first.
+	 */
+	if (!task_boost && !task_exp)
+		return;
+
+	if (!zalloc_cpumask_var(&cm, GFP_KERNEL))
+		return;
+
+	mutex_lock(&rnp->kthread_mutex);
+	mask = rcu_rnp_online_cpus(rnp);
+	for_each_leaf_node_possible_cpu(rnp, cpu)
+		if ((mask & leaf_node_cpu_bit(rnp, cpu)) &&
+		    cpu != outgoingcpu)
+			cpumask_set_cpu(cpu, cm);
+	cpumask_and(cm, cm, housekeeping_cpumask(HK_TYPE_RCU));
+	if (cpumask_empty(cm)) {
+		cpumask_copy(cm, housekeeping_cpumask(HK_TYPE_RCU));
+		if (outgoingcpu >= 0)
+			cpumask_clear_cpu(outgoingcpu, cm);
+	}
+
+	if (task_exp)
+		set_cpus_allowed_ptr(task_exp, cm);
+
+	if (task_boost)
+		set_cpus_allowed_ptr(task_boost, cm);
+
+	mutex_unlock(&rnp->kthread_mutex);
+
+	free_cpumask_var(cm);
 }
 
 /*
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 09bdd36ca9ff..08246cca663f 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1211,43 +1211,9 @@ static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
 	wake_up_process(t); /* get to TASK_INTERRUPTIBLE quickly. */
 }
 
-/*
- * Set the per-rcu_node kthread's affinity to cover all CPUs that are
- * served by the rcu_node in question.  The CPU hotplug lock is still
- * held, so the value of rnp->qsmaskinit will be stable.
- *
- * We don't include outgoingcpu in the affinity set, use -1 if there is
- * no outgoing CPU.  If there are no CPUs left in the affinity set,
- * this function allows the kthread to execute on any CPU.
- *
- * Any future concurrent calls are serialized via ->kthread_mutex.
- */
-static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
+static struct task_struct *rcu_boost_task(struct rcu_node *rnp)
 {
-	struct task_struct *t = rnp->boost_kthread_task;
-	unsigned long mask;
-	cpumask_var_t cm;
-	int cpu;
-
-	if (!t)
-		return;
-	if (!zalloc_cpumask_var(&cm, GFP_KERNEL))
-		return;
-	mutex_lock(&rnp->kthread_mutex);
-	mask = rcu_rnp_online_cpus(rnp);
-	for_each_leaf_node_possible_cpu(rnp, cpu)
-		if ((mask & leaf_node_cpu_bit(rnp, cpu)) &&
-		    cpu != outgoingcpu)
-			cpumask_set_cpu(cpu, cm);
-	cpumask_and(cm, cm, housekeeping_cpumask(HK_TYPE_RCU));
-	if (cpumask_empty(cm)) {
-		cpumask_copy(cm, housekeeping_cpumask(HK_TYPE_RCU));
-		if (outgoingcpu >= 0)
-			cpumask_clear_cpu(outgoingcpu, cm);
-	}
-	set_cpus_allowed_ptr(t, cm);
-	mutex_unlock(&rnp->kthread_mutex);
-	free_cpumask_var(cm);
+	return READ_ONCE(rnp->boost_kthread_task);
 }
 
 #else /* #ifdef CONFIG_RCU_BOOST */
@@ -1266,10 +1232,10 @@ static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
 {
 }
 
-static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
+static struct task_struct * rcu_boost_task(struct rcu_node *rnp)
 {
+	return NULL;
 }
-
 #endif /* #else #ifdef CONFIG_RCU_BOOST */
 
 /*
-- 
2.34.1


