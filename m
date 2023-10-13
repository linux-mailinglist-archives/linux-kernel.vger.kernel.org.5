Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D487C8534
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 14:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbjJMMAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 08:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbjJMMAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 08:00:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F151707;
        Fri, 13 Oct 2023 04:59:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E05E9C433C8;
        Fri, 13 Oct 2023 11:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697198389;
        bh=gBu5d6YUhfCKIA13MA7EoAu72nhKwN2C8OoerYKkJQw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S+XhprrZuKYQhkPOGnbJV7Ei0BptNRQ+kTCnTCtt9/Qt2cgIRP/nJg8PQwfnqXsFV
         wHtVcbS9955Q+UReAhH2yh7NIeWCN2xIhdSFZ9saUh2//i+b49fa4KxTfe5IyniKoc
         PkIs7JyzhXHkK8tLBxkRoCloMCGDPiNMMtCeY9LoyEX1ft5mzp69oNmghN5mELrQt4
         e1LYsvvdtMu6XhFsvWfG9zl8tsK/T9+h8Jm5l7bpaKtARXcZfmB+vaPsseGlD93KEF
         nq47VSSNuWPeqGiBSub3PxkKul9UHyw3xBpxQwI0SOE/IODa9HtCWtPAUbJ+lxfEke
         mdvcK8rP8F/jQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: [PATCH 14/18] rcu: Conditionally build CPU-hotplug teardown callbacks
Date:   Fri, 13 Oct 2023 13:58:58 +0200
Message-Id: <20231013115902.1059735-15-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013115902.1059735-1-frederic@kernel.org>
References: <20231013115902.1059735-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/rcutree.h |  11 +++-
 kernel/rcu/tree.c       | 114 +++++++++++++++++++---------------------
 2 files changed, 63 insertions(+), 62 deletions(-)

diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 153cfc7bbffd..46875c4e9f56 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -110,9 +110,16 @@ void rcu_all_qs(void);
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
index 2e1e7eadf2cc..f9c6b2680cbb 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4237,25 +4237,6 @@ static bool rcu_init_invoked(void)
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
@@ -4301,23 +4282,6 @@ static void rcu_cleanup_dead_rnp(struct rcu_node *rnp_leaf)
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
@@ -4470,29 +4434,6 @@ int rcutree_online_cpu(unsigned int cpu)
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
@@ -4646,7 +4587,60 @@ void rcutree_migrate_callbacks(int cpu)
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
2.34.1

