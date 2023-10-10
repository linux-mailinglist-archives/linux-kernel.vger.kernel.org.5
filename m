Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944BC7BFACB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 14:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbjJJMHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 08:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbjJJMHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 08:07:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96603D77;
        Tue, 10 Oct 2023 05:00:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3287C43391;
        Tue, 10 Oct 2023 12:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696939219;
        bh=uIpDokdeZURQXHGW68Zdq69flN3tCoi7qF+XGqyqLDk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oh12frYctjf0MvTV6Z1i0VfqWBFdmGREItA2W6VcaDgCFdEI5/i1srDWjTf2ADG6U
         LBKQIlECQE4aqLaH37V7Nwzrl/ro2C4CZfeZRvAHYjBAxT5w0HF16OmHhMLJc/9u+G
         vh71HEpALHjYHoq98Je16TUmpHJdhLvYJmWznbC9BKUyQy1XQ9mxsB1qs3E5HXfnDS
         bGQjbqFV5BgyiRKUClcKPqhUFT79lwhcpLvcqetuX+5A5ob6h2O7u7/Wne29bXjRww
         LvvMYsEgvIT2rb6t7BeRduGo38lw8u3HPaUN2tjgFHhlfidCKsIu36pGOilIdcRFV2
         8G5i6LnMfkVOQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 16/23] locktorture: Add call_rcu_chains module parameter
Date:   Tue, 10 Oct 2023 13:59:14 +0200
Message-Id: <20231010115921.988766-17-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010115921.988766-1-frederic@kernel.org>
References: <20231010115921.988766-1-frederic@kernel.org>
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

From: "Paul E. McKenney" <paulmck@kernel.org>

When running locktorture on large systems, there will normally be
enough RCU activity to ensure that there is a grace period in flight
at all times.  However, on smaller systems, RCU might well be idle the
majority of the time.  This situation can be inconvenient in cases where
the RCU CPU stall warning is part of the debugging process.

This commit therefore adds an call_rcu_chains module parameter to
locktorture, allowing the user to specify the desired number of
self-propagating call_rcu() chains.  For good measure, immediately
before invoking call_rcu(), the self-propagating RCU callback invokes
start_poll_synchronize_rcu() to force the immediate start of a grace
period, with the call_rcu() forcing another to start shortly thereafter.

Booting with locktorture.call_rcu_chains=2 increases the probability
of a stuck locking primitive resulting in an RCU CPU stall warning from
about 25% to nearly 100%.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 .../admin-guide/kernel-parameters.txt         |  7 +++
 kernel/locking/locktorture.c                  | 62 ++++++++++++++++++-
 2 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0a1731a0f0ef..300e2c30986c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2913,6 +2913,13 @@
 			to extract confidential information from the kernel
 			are also disabled.
 
+	locktorture.call_rcu_chains= [KNL]
+			Specify the number of self-propagating call_rcu()
+			chains to set up.  These are used to ensure that
+			there is a high probability of an RCU grace period
+			in progress at any given time.	Defaults to 0,
+			which disables these call_rcu() chains.
+
 	locktorture.nreaders_stress= [KNL]
 			Set the number of locking read-acquisition kthreads.
 			Defaults to being automatically set based on the
diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index d2a3a8cc1902..01d56e6c44d7 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -34,6 +34,7 @@ MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Paul E. McKenney <paulmck@linux.ibm.com>");
 
 torture_param(int, acq_writer_lim, 0, "Write_acquisition time limit (jiffies).");
+torture_param(int, call_rcu_chains, 0, "Self-propagate call_rcu() chains during test (0=disable).");
 torture_param(int, long_hold, 100, "Do occasional long hold of lock (ms), 0=disable");
 torture_param(int, nested_locks, 0, "Number of nested locks (max = 8)");
 torture_param(int, nreaders_stress, -1, "Number of read-locking stress-test threads");
@@ -119,6 +120,12 @@ struct lock_stress_stats {
 	long n_lock_acquired;
 };
 
+struct call_rcu_chain {
+	struct rcu_head crc_rh;
+	bool crc_stop;
+};
+struct call_rcu_chain *call_rcu_chain;
+
 /* Forward reference. */
 static void lock_torture_cleanup(void);
 
@@ -1037,15 +1044,60 @@ lock_torture_print_module_parms(struct lock_torture_ops *cur_ops,
 
 	cpumask_setall(&cpumask_all);
 	pr_alert("%s" TORTURE_FLAG
-		 "--- %s%s: acq_writer_lim=%d long_hold=%d nested_locks=%d nreaders_stress=%d nwriters_stress=%d onoff_holdoff=%d onoff_interval=%d rt_boost=%d rt_boost_factor=%d shuffle_interval=%d shutdown_secs=%d stat_interval=%d stutter=%d verbose=%d writer_fifo=%d readers_bind=%*pbl writers_bind=%*pbl\n",
+		 "--- %s%s: acq_writer_lim=%d call_rcu_chains=%d long_hold=%d nested_locks=%d nreaders_stress=%d nwriters_stress=%d onoff_holdoff=%d onoff_interval=%d rt_boost=%d rt_boost_factor=%d shuffle_interval=%d shutdown_secs=%d stat_interval=%d stutter=%d verbose=%d writer_fifo=%d readers_bind=%*pbl writers_bind=%*pbl\n",
 		 torture_type, tag, cxt.debug_lock ? " [debug]": "",
-		 acq_writer_lim, long_hold, nested_locks, cxt.nrealreaders_stress,
+		 acq_writer_lim, call_rcu_chains, long_hold, nested_locks, cxt.nrealreaders_stress,
 		 cxt.nrealwriters_stress, onoff_holdoff, onoff_interval, rt_boost,
 		 rt_boost_factor, shuffle_interval, shutdown_secs, stat_interval, stutter,
 		 verbose, writer_fifo,
 		 cpumask_pr_args(rcmp), cpumask_pr_args(wcmp));
 }
 
+// If requested, maintain call_rcu() chains to keep a grace period always
+// in flight.  These increase the probability of getting an RCU CPU stall
+// warning and associated diagnostics when a locking primitive stalls.
+
+static void call_rcu_chain_cb(struct rcu_head *rhp)
+{
+	struct call_rcu_chain *crcp = container_of(rhp, struct call_rcu_chain, crc_rh);
+
+	if (!smp_load_acquire(&crcp->crc_stop)) {
+		(void)start_poll_synchronize_rcu(); // Start one grace period...
+		call_rcu(&crcp->crc_rh, call_rcu_chain_cb); // ... and later start another.
+	}
+}
+
+// Start the requested number of call_rcu() chains.
+static int call_rcu_chain_init(void)
+{
+	int i;
+
+	if (call_rcu_chains <= 0)
+		return 0;
+	call_rcu_chain = kcalloc(call_rcu_chains, sizeof(*call_rcu_chain), GFP_KERNEL);
+	if (!call_rcu_chains)
+		return -ENOMEM;
+	for (i = 0; i < call_rcu_chains; i++) {
+		call_rcu_chain[i].crc_stop = false;
+		call_rcu(&call_rcu_chain[i].crc_rh, call_rcu_chain_cb);
+	}
+	return 0;
+}
+
+// Stop all of the call_rcu() chains.
+static void call_rcu_chain_cleanup(void)
+{
+	int i;
+
+	if (!call_rcu_chain)
+		return;
+	for (i = 0; i < call_rcu_chains; i++)
+		smp_store_release(&call_rcu_chain[i].crc_stop, true);
+	rcu_barrier();
+	kfree(call_rcu_chain);
+	call_rcu_chain = NULL;
+}
+
 static void lock_torture_cleanup(void)
 {
 	int i;
@@ -1096,6 +1148,8 @@ static void lock_torture_cleanup(void)
 	kfree(cxt.lrsa);
 	cxt.lrsa = NULL;
 
+	call_rcu_chain_cleanup();
+
 end:
 	if (cxt.init_called) {
 		if (cxt.cur_ops->exit)
@@ -1225,6 +1279,10 @@ static int __init lock_torture_init(void)
 		}
 	}
 
+	firsterr = call_rcu_chain_init();
+	if (torture_init_error(firsterr))
+		goto unwind;
+
 	lock_torture_print_module_parms(cxt.cur_ops, "Start of test");
 
 	/* Prepare torture context. */
-- 
2.34.1

