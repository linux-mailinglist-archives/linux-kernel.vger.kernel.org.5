Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF42980AF60
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 23:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574870AbjLHWGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 17:06:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574854AbjLHWGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 17:06:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8973B1706
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 14:06:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FD22C433C9;
        Fri,  8 Dec 2023 22:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702073173;
        bh=AcdnP+nheXUu6zmk19wWpBUVB1bhfK7chHBbiVuRGSY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tmXWY8s5C92lss79645hQK/enaj+GdOHvU0t3O5h5jPdFzYkc8EAJjAXevCXfzGwn
         fXIVHh2uloQjEqyXxhf14PcM3xq1rHBwoO3xqHdXkXWprdRbzGk7nX9eC+Mr5UV2Ys
         mLXeDTSBkQjNEPN8VgaHhDxCB/VzBQW1yZdRGEyP5AO22SWK8aWjUKYVvPmMD3Wbbj
         zCe212qGBmpuQFj+PB+I7erLlH3BXgX4rRmK7ig36md7k/1820PDsZPF1sp1MmB9eN
         AFM1r9CcmCvJsGfk/vKsEzYEVbg5Tpp0bPGvvECdpVPyBdlWyN8BaGvNpV24JM+9pS
         ndRJDa6HYI2ig==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria.behnsen@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 7/8] rcu/exp: Handle parallel exp gp kworkers affinity
Date:   Fri,  8 Dec 2023 23:05:44 +0100
Message-ID: <20231208220545.7452-8-frederic@kernel.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231208220545.7452-1-frederic@kernel.org>
References: <20231208220545.7452-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 060d418c2b44..e75ddf42e9b1 100644
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
@@ -4390,6 +4390,16 @@ static void rcu_spawn_exp_par_gp_kworker(struct rcu_node *rnp)
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
@@ -4414,6 +4424,11 @@ static void rcu_spawn_exp_par_gp_kworker(struct rcu_node *rnp)
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
@@ -4492,13 +4507,67 @@ int rcutree_prepare_cpu(unsigned int cpu)
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
2.42.1

