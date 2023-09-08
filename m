Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A2C79910C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 22:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344524AbjIHUgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 16:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344410AbjIHUgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 16:36:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0713E6F;
        Fri,  8 Sep 2023 13:36:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A67EC433C7;
        Fri,  8 Sep 2023 20:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694205390;
        bh=Rt+u8fsiOu0KPpZnkh8F2sls3vmHsEdxXPsoe1TZo9g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NPbjI4+QtqWC800HkW6GYwQyoKJ1L/UMbwCYTDdDn11zkS6O35ZmWoMu7QdHEdkg+
         fyMCeezOfdYYVA9tRdmNKwnPFeBY8NYQERiVG2zHdKPSorqhK+Z60m37maviO3H5IS
         TuZ0oJ3nd9V+5IfjQkScC166gyABtTOY8l43s5x2c+z2TyE4DWQa52S7byfYdwJUAc
         mPJBUyZbzjlhKY1ANPxrUEesAbQES4RgH6vxgoy2YA2BXFnP/hCzzy+O86zi7LzK92
         KEOSRhtjXW9KfQLmT+RWkCs3DKB1oURYh/jLgzBSNp7htWs0BTB8Y6+u9RyYn4pBWn
         oj/NEI1NFTFuA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        rcu <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 07/10] rcu: Conditionally build CPU-hotplug teardown callbacks
Date:   Fri,  8 Sep 2023 22:36:00 +0200
Message-ID: <20230908203603.5865-8-frederic@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230908203603.5865-1-frederic@kernel.org>
References: <20230908203603.5865-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Among the three CPU-hotplug teardown RCU callbacks, two of them early
exit if CONFIG_HOTPLUG_CPU=n, and one is left unchanged. In any case
all of them have an implementation when CONFIG_HOTPLUG_CPU=n.

Align instead with the common way to deal with CPU-hotplug teardown
callbacks and provide a proper stub when they are not supported.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/rcutree.h |  11 +++-
 kernel/rcu/tree.c       | 114 +++++++++++++++++++---------------------
 2 files changed, 63 insertions(+), 62 deletions(-)

diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index af6ddbd291eb..7d75066c72aa 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -109,9 +109,16 @@ void rcu_all_qs(void);
 /* RCUtree hotplug events */
 int rcutree_prepare_cpu(unsigned int cpu);
 int rcutree_online_cpu(unsigned int cpu);
-int rcutree_offline_cpu(unsigned int cpu);
+void rcu_cpu_starting(unsigned int cpu);
+
+#ifdef CONFIG_HOTPLUG_CPU
 int rcutree_dead_cpu(unsigned int cpu);
 int rcutree_dying_cpu(unsigned int cpu);
-void rcu_cpu_starting(unsigned int cpu);
+int rcutree_offline_cpu(unsigned int cpu);
+#else
+#define rcutree_dead_cpu NULL
+#define rcutree_dying_cpu NULL
+#define rcutree_offline_cpu NULL
+#endif
 
 #endif /* __LINUX_RCUTREE_H */
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 289c51417cbc..875f241db508 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4228,25 +4228,6 @@ static bool rcu_init_invoked(void)
 	return !!rcu_state.n_online_cpus;
 }
 
-/*
- * Near the end of the offline process.  Trace the fact that this CPU
- * is going offline.
- */
-int rcutree_dying_cpu(unsigned int cpu)
-{
-	bool blkd;
-	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
-	struct rcu_node *rnp = rdp->mynode;
-
-	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
-		return 0;
-
-	blkd = !!(READ_ONCE(rnp->qsmask) & rdp->grpmask);
-	trace_rcu_grace_period(rcu_state.name, READ_ONCE(rnp->gp_seq),
-			       blkd ? TPS("cpuofl-bgp") : TPS("cpuofl"));
-	return 0;
-}
-
 /*
  * All CPUs for the specified rcu_node structure have gone offline,
  * and all tasks that were preempted within an RCU read-side critical
@@ -4292,23 +4273,6 @@ static void rcu_cleanup_dead_rnp(struct rcu_node *rnp_leaf)
 	}
 }
 
-/*
- * The CPU has been completely removed, and some other CPU is reporting
- * this fact from process context.  Do the remainder of the cleanup.
- * There can only be one CPU hotplug operation at a time, so no need for
- * explicit locking.
- */
-int rcutree_dead_cpu(unsigned int cpu)
-{
-	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
-		return 0;
-
-	WRITE_ONCE(rcu_state.n_online_cpus, rcu_state.n_online_cpus - 1);
-	// Stop-machine done, so allow nohz_full to disable tick.
-	tick_dep_clear(TICK_DEP_BIT_RCU);
-	return 0;
-}
-
 /*
  * Propagate ->qsinitmask bits up the rcu_node tree to account for the
  * first CPU in a given leaf rcu_node structure coming online.  The caller
@@ -4461,29 +4425,6 @@ int rcutree_online_cpu(unsigned int cpu)
 	return 0;
 }
 
-/*
- * Near the beginning of the process.  The CPU is still very much alive
- * with pretty much all services enabled.
- */
-int rcutree_offline_cpu(unsigned int cpu)
-{
-	unsigned long flags;
-	struct rcu_data *rdp;
-	struct rcu_node *rnp;
-
-	rdp = per_cpu_ptr(&rcu_data, cpu);
-	rnp = rdp->mynode;
-	raw_spin_lock_irqsave_rcu_node(rnp, flags);
-	rnp->ffmask &= ~rdp->grpmask;
-	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
-
-	rcutree_affinity_setting(cpu, cpu);
-
-	// nohz_full CPUs need the tick for stop-machine to work quickly
-	tick_dep_set(TICK_DEP_BIT_RCU);
-	return 0;
-}
-
 /*
  * Mark the specified CPU as being online so that subsequent grace periods
  * (both expedited and normal) will wait on it.  Note that this means that
@@ -4637,7 +4578,60 @@ void rcutree_migrate_callbacks(int cpu)
 		  cpu, rcu_segcblist_n_cbs(&rdp->cblist),
 		  rcu_segcblist_first_cb(&rdp->cblist));
 }
-#endif
+
+/*
+ * The CPU has been completely removed, and some other CPU is reporting
+ * this fact from process context.  Do the remainder of the cleanup.
+ * There can only be one CPU hotplug operation at a time, so no need for
+ * explicit locking.
+ */
+int rcutree_dead_cpu(unsigned int cpu)
+{
+	WRITE_ONCE(rcu_state.n_online_cpus, rcu_state.n_online_cpus - 1);
+	// Stop-machine done, so allow nohz_full to disable tick.
+	tick_dep_clear(TICK_DEP_BIT_RCU);
+	return 0;
+}
+
+/*
+ * Near the end of the offline process.  Trace the fact that this CPU
+ * is going offline.
+ */
+int rcutree_dying_cpu(unsigned int cpu)
+{
+	bool blkd;
+	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
+	struct rcu_node *rnp = rdp->mynode;
+
+	blkd = !!(READ_ONCE(rnp->qsmask) & rdp->grpmask);
+	trace_rcu_grace_period(rcu_state.name, READ_ONCE(rnp->gp_seq),
+			       blkd ? TPS("cpuofl-bgp") : TPS("cpuofl"));
+	return 0;
+}
+
+/*
+ * Near the beginning of the process.  The CPU is still very much alive
+ * with pretty much all services enabled.
+ */
+int rcutree_offline_cpu(unsigned int cpu)
+{
+	unsigned long flags;
+	struct rcu_data *rdp;
+	struct rcu_node *rnp;
+
+	rdp = per_cpu_ptr(&rcu_data, cpu);
+	rnp = rdp->mynode;
+	raw_spin_lock_irqsave_rcu_node(rnp, flags);
+	rnp->ffmask &= ~rdp->grpmask;
+	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+
+	rcutree_affinity_setting(cpu, cpu);
+
+	// nohz_full CPUs need the tick for stop-machine to work quickly
+	tick_dep_set(TICK_DEP_BIT_RCU);
+	return 0;
+}
+#endif /* #ifdef CONFIG_HOTPLUG_CPU */
 
 /*
  * On non-huge systems, use expedited RCU grace periods to make suspend
-- 
2.41.0

