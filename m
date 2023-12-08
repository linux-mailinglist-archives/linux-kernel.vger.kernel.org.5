Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904E680AF5C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 23:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574892AbjLHWGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 17:06:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574896AbjLHWF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 17:05:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE35610E0
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 14:06:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2059C433CB;
        Fri,  8 Dec 2023 22:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702073164;
        bh=2VSL0I6CDQD3On48r7ZZl2KNfsOXx4qI+XGTjXvz4To=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sfV0bAA3jMUaWQ7vGD0VMm4RIRuqF0R57O6AyLWLuIz64dUmxfQpa8c1ga8kShpyW
         w/tmMOwatv3tjWq6lRY5NzU3lVvcHjTa6NLBBeUgAHOR9YdENAOSGYTgK3vs6pystc
         e+GqnbPLuT7sFWpY1mrdr55j099gb7C2lTMluQur4lQOFYzcWPm3r33wagwqn7AYZ+
         e/T7zYVHXergvzndqp/awswOBzn26JxZhhw01hSmeGlJSJdxi6vwEHnWJaXdDV+f2f
         pSnEbC4NZlMyi2DCb3fYtdjlnztzoxJiLz6/recBTwHZpXndpdXAXKsgYKyHdhqKKM
         DQ/9wRlfXoBUQ==
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
        Thomas Gleixner <tglx@linutronix.de>,
        Kalesh Singh <kaleshsingh@google.com>
Subject: [PATCH 4/8] rcu/exp: Handle RCU expedited grace period kworker allocation failure
Date:   Fri,  8 Dec 2023 23:05:41 +0100
Message-ID: <20231208220545.7452-5-frederic@kernel.org>
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

Just like is done for the kworker performing nodes initialization,
gracefully handle the possible allocation failure of the RCU expedited
grace period main kworker.

While at it perform a rename of the related checking functions to better
reflect the expedited specifics.

Fixes: 9621fbee44df ("rcu: Move expedited grace period (GP) work to RT kthread_worker")
Cc: Kalesh Singh <kaleshsingh@google.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree.c     |  2 ++
 kernel/rcu/tree_exp.h | 25 +++++++++++++++++++------
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 055f4817bc70..39679cf66c3a 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4717,6 +4717,7 @@ static void __init rcu_start_exp_gp_kworkers(void)
 	rcu_exp_gp_kworker = kthread_create_worker(0, gp_kworker_name);
 	if (IS_ERR_OR_NULL(rcu_exp_gp_kworker)) {
 		pr_err("Failed to create %s!\n", gp_kworker_name);
+		rcu_exp_gp_kworker = NULL;
 		return;
 	}
 
@@ -4725,6 +4726,7 @@ static void __init rcu_start_exp_gp_kworkers(void)
 		pr_err("Failed to create %s!\n", par_gp_kworker_name);
 		rcu_exp_par_gp_kworker = NULL;
 		kthread_destroy_worker(rcu_exp_gp_kworker);
+		rcu_exp_gp_kworker = NULL;
 		return;
 	}
 
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 6d7cea5d591f..cb31f4fb4b36 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -429,7 +429,12 @@ static void sync_rcu_exp_select_node_cpus(struct kthread_work *wp)
 	__sync_rcu_exp_select_node_cpus(rewp);
 }
 
-static inline bool rcu_gp_par_worker_started(void)
+static inline bool rcu_exp_worker_started(void)
+{
+	return !!READ_ONCE(rcu_exp_gp_kworker);
+}
+
+static inline bool rcu_exp_par_worker_started(void)
 {
 	return !!READ_ONCE(rcu_exp_par_gp_kworker);
 }
@@ -479,7 +484,12 @@ static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
 	__sync_rcu_exp_select_node_cpus(rewp);
 }
 
-static inline bool rcu_gp_par_worker_started(void)
+static inline bool rcu_exp_worker_started(void)
+{
+	return !!READ_ONCE(rcu_gp_wq);
+}
+
+static inline bool rcu_exp_par_worker_started(void)
 {
 	return !!READ_ONCE(rcu_par_gp_wq);
 }
@@ -542,7 +552,7 @@ static void sync_rcu_exp_select_cpus(void)
 		rnp->exp_need_flush = false;
 		if (!READ_ONCE(rnp->expmask))
 			continue; /* Avoid early boot non-existent wq. */
-		if (!rcu_gp_par_worker_started() ||
+		if (!rcu_exp_par_worker_started() ||
 		    rcu_scheduler_active != RCU_SCHEDULER_RUNNING ||
 		    rcu_is_last_leaf_node(rnp)) {
 			/* No worker started yet or last leaf, do direct call. */
@@ -957,7 +967,7 @@ static void rcu_exp_print_detail_task_stall_rnp(struct rcu_node *rnp)
  */
 void synchronize_rcu_expedited(void)
 {
-	bool boottime = (rcu_scheduler_active == RCU_SCHEDULER_INIT);
+	bool can_queue;
 	unsigned long flags;
 	struct rcu_exp_work rew;
 	struct rcu_node *rnp;
@@ -968,6 +978,9 @@ void synchronize_rcu_expedited(void)
 			 lock_is_held(&rcu_sched_lock_map),
 			 "Illegal synchronize_rcu_expedited() in RCU read-side critical section");
 
+	can_queue = (rcu_scheduler_active != RCU_SCHEDULER_INIT) &&
+		    rcu_exp_worker_started();
+
 	/* Is the state is such that the call is a grace period? */
 	if (rcu_blocking_is_gp()) {
 		// Note well that this code runs with !PREEMPT && !SMP.
@@ -997,7 +1010,7 @@ void synchronize_rcu_expedited(void)
 		return;  /* Someone else did our work for us. */
 
 	/* Ensure that load happens before action based on it. */
-	if (unlikely(boottime)) {
+	if (unlikely(!can_queue)) {
 		/* Direct call during scheduler init and early_initcalls(). */
 		rcu_exp_sel_wait_wake(s);
 	} else {
@@ -1015,7 +1028,7 @@ void synchronize_rcu_expedited(void)
 	/* Let the next expedited grace period start. */
 	mutex_unlock(&rcu_state.exp_mutex);
 
-	if (likely(!boottime))
+	if (likely(can_queue))
 		synchronize_rcu_expedited_destroy_work(&rew);
 }
 EXPORT_SYMBOL_GPL(synchronize_rcu_expedited);
-- 
2.42.1

