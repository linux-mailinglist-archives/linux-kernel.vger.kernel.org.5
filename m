Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1797580AF5D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 23:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574867AbjLHWGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 17:06:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574908AbjLHWGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 17:06:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839D210E0
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 14:06:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9066C433CA;
        Fri,  8 Dec 2023 22:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702073167;
        bh=yWebujIG4HSorgdJi4M3lUUuBe+hsvsBv+UYBWpi03o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p9mX3ajPq8YULvimHUvR6KN5ezjGUnX5P3BFYLS3YyCehL1VtWGV705VErfOiqhdj
         83TJ5wXcahka4lu7FykluPIc2eMRrgnuA4nfuXuam3jdhKyXOcg4PO7LYNtJF2N0hG
         84uR1qF51GWYppty8R1UFYywgyxgWON2AnUWu5HjdqI96nMlCsrBZn5REKeriurL2p
         84Rhf5qVjgnnIiynDaMaM6kAiE5hQlHumfu7vaYRKcgu04PV+USxKeWNemMDRCBhpz
         8L12JkJGnXg/O9cPQTedeJFC8ymzxvtPSDWPCO8LEUTn0v+409vJFdc/9SVj298Czh
         ac7QIUKTOUMpg==
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
Subject: [PATCH 5/8] rcu: s/boost_kthread_mutex/kthread_mutex
Date:   Fri,  8 Dec 2023 23:05:42 +0100
Message-ID: <20231208220545.7452-6-frederic@kernel.org>
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

This mutex currently protecting per node boost kthreads creation and
affinity setting across CPU hotplug operations will soon be used also
for expedited kworkers.

Generalize its name to prepare for that.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree.c        |  2 +-
 kernel/rcu/tree.h        |  2 +-
 kernel/rcu/tree_plugin.h | 10 +++++-----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 39679cf66c3a..996efaded5bf 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4892,7 +4892,7 @@ static void __init rcu_init_one(void)
 			init_waitqueue_head(&rnp->exp_wq[2]);
 			init_waitqueue_head(&rnp->exp_wq[3]);
 			spin_lock_init(&rnp->exp_lock);
-			mutex_init(&rnp->boost_kthread_mutex);
+			mutex_init(&rnp->kthread_mutex);
 			raw_spin_lock_init(&rnp->exp_poll_lock);
 			rnp->exp_seq_poll_rq = RCU_GET_STATE_COMPLETED;
 			INIT_WORK(&rnp->exp_poll_wq, sync_rcu_do_polled_gp);
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index e0e70b663cbf..f98a245e5f32 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -113,7 +113,7 @@ struct rcu_node {
 				/*  side effect, not as a lock. */
 	unsigned long boost_time;
 				/* When to start boosting (jiffies). */
-	struct mutex boost_kthread_mutex;
+	struct mutex kthread_mutex;
 				/* Exclusion for thread spawning and affinity */
 				/*  manipulation. */
 	struct task_struct *boost_kthread_task;
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 41021080ad25..0d307674915c 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1195,7 +1195,7 @@ static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
 	struct sched_param sp;
 	struct task_struct *t;
 
-	mutex_lock(&rnp->boost_kthread_mutex);
+	mutex_lock(&rnp->kthread_mutex);
 	if (rnp->boost_kthread_task || !rcu_scheduler_fully_active)
 		goto out;
 
@@ -1212,7 +1212,7 @@ static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
 	wake_up_process(t); /* get to TASK_INTERRUPTIBLE quickly. */
 
  out:
-	mutex_unlock(&rnp->boost_kthread_mutex);
+	mutex_unlock(&rnp->kthread_mutex);
 }
 
 /*
@@ -1224,7 +1224,7 @@ static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
  * no outgoing CPU.  If there are no CPUs left in the affinity set,
  * this function allows the kthread to execute on any CPU.
  *
- * Any future concurrent calls are serialized via ->boost_kthread_mutex.
+ * Any future concurrent calls are serialized via ->kthread_mutex.
  */
 static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
 {
@@ -1237,7 +1237,7 @@ static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
 		return;
 	if (!zalloc_cpumask_var(&cm, GFP_KERNEL))
 		return;
-	mutex_lock(&rnp->boost_kthread_mutex);
+	mutex_lock(&rnp->kthread_mutex);
 	mask = rcu_rnp_online_cpus(rnp);
 	for_each_leaf_node_possible_cpu(rnp, cpu)
 		if ((mask & leaf_node_cpu_bit(rnp, cpu)) &&
@@ -1250,7 +1250,7 @@ static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
 			cpumask_clear_cpu(outgoingcpu, cm);
 	}
 	set_cpus_allowed_ptr(t, cm);
-	mutex_unlock(&rnp->boost_kthread_mutex);
+	mutex_unlock(&rnp->kthread_mutex);
 	free_cpumask_var(cm);
 }
 
-- 
2.42.1

