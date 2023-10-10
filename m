Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41CBC7BFA96
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 14:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbjJJMB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 08:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbjJJMA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 08:00:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1C310D4;
        Tue, 10 Oct 2023 05:00:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C528C433C8;
        Tue, 10 Oct 2023 12:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696939224;
        bh=ha2jr1RYr7HhVfbt6KZ0EmGhSb2PFj9LG18wINl8AWA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J8GQOFGv3Fl5LVw8DXcXJ94En597LSNTkyCP9zaUyTuQ1dq68wEANQOV0totn72n0
         ScnPwHq9+DQIvBm5OLKD4SYDrPMxm8K/i4ODjzs52SXx++8A5kYxCqNJ8xjBJreX6A
         /V6aAM52reCWBnQHpA+yJv9o5mUPPLOVlFtp1NXZGLN2Eq83J4xzKhOSmkuoq7ZYjC
         t93gesmdNOV5DuqOydf0uWt+SV25h6ybH0wDrodFeebdSYEVIq014pdMsMeeZkaP9+
         6otDs5Bk59HdSJ8mTu/j2GgL5pJ5baZNEbTORAId0H1tfao5Qnck08U1uOVUvbEZHv
         xbzasBg7wuVKQ==
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
Subject: [PATCH 18/23] locktorture: Rename readers_bind/writers_bind to bind_readers/bind_writers
Date:   Tue, 10 Oct 2023 13:59:16 +0200
Message-Id: <20231010115921.988766-19-frederic@kernel.org>
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

This commit renames the readers_bind and writers_bind module parameters
to bind_readers and bind_writers, respectively.  This provides added
clarity via the imperative mode and better organizes the documentation.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 .../admin-guide/kernel-parameters.txt         | 16 +++++------
 kernel/locking/locktorture.c                  | 28 +++++++++----------
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 47f8b1cef4fd..1d539c6d9d1c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2918,6 +2918,14 @@
 			acquisition.  Acquisitions exceeding this limit
 			will result in a splat once they do complete.
 
+	locktorture.bind_readers= [KNL]
+			Specify the list of CPUs to which the readers are
+			to be bound.
+
+	locktorture.bind_writers= [KNL]
+			Specify the list of CPUs to which the writers are
+			to be bound.
+
 	locktorture.call_rcu_chains= [KNL]
 			Specify the number of self-propagating call_rcu()
 			chains to set up.  These are used to ensure that
@@ -2952,10 +2960,6 @@
 			Set time (s) between CPU-hotplug operations, or
 			zero to disable CPU-hotplug testing.
 
-	locktorture.readers_bind= [KNL]
-			Specify the list of CPUs to which the readers are
-			to be bound.
-
 	locktorture.rt_boost= [KNL]
 			Do periodic testing of real-time lock priority
 			boosting.  Select 0 to disable, 1 to boost
@@ -3000,10 +3004,6 @@
 	locktorture.verbose= [KNL]
 			Enable additional printk() statements.
 
-	locktorture.writers_bind= [KNL]
-			Specify the list of CPUs to which the writers are
-			to be bound.
-
 	locktorture.writer_fifo= [KNL]
 			Run the write-side locktorture kthreads at
 			sched_set_fifo() real-time priority.
diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 01d56e6c44d7..a3abcd136f56 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -58,8 +58,8 @@ module_param(torture_type, charp, 0444);
 MODULE_PARM_DESC(torture_type,
 		 "Type of lock to torture (spin_lock, spin_lock_irq, mutex_lock, ...)");
 
-static cpumask_var_t readers_bind; // Bind the readers to the specified set of CPUs.
-static cpumask_var_t writers_bind; // Bind the writers to the specified set of CPUs.
+static cpumask_var_t bind_readers; // Bind the readers to the specified set of CPUs.
+static cpumask_var_t bind_writers; // Bind the writers to the specified set of CPUs.
 
 // Parse a cpumask kernel parameter.  If there are more users later on,
 // this might need to got to a more central location.
@@ -102,8 +102,8 @@ static const struct kernel_param_ops lt_bind_ops = {
 	.get = param_get_cpumask,
 };
 
-module_param_cb(readers_bind, &lt_bind_ops, &readers_bind, 0644);
-module_param_cb(writers_bind, &lt_bind_ops, &writers_bind, 0644);
+module_param_cb(bind_readers, &lt_bind_ops, &bind_readers, 0644);
+module_param_cb(bind_writers, &lt_bind_ops, &bind_writers, 0644);
 
 long torture_sched_setaffinity(pid_t pid, const struct cpumask *in_mask);
 
@@ -1039,18 +1039,18 @@ lock_torture_print_module_parms(struct lock_torture_ops *cur_ops,
 				const char *tag)
 {
 	static cpumask_t cpumask_all;
-	cpumask_t *rcmp = cpumask_nonempty(readers_bind) ? readers_bind : &cpumask_all;
-	cpumask_t *wcmp = cpumask_nonempty(writers_bind) ? writers_bind : &cpumask_all;
+	cpumask_t *rcmp = cpumask_nonempty(bind_readers) ? bind_readers : &cpumask_all;
+	cpumask_t *wcmp = cpumask_nonempty(bind_writers) ? bind_writers : &cpumask_all;
 
 	cpumask_setall(&cpumask_all);
 	pr_alert("%s" TORTURE_FLAG
-		 "--- %s%s: acq_writer_lim=%d call_rcu_chains=%d long_hold=%d nested_locks=%d nreaders_stress=%d nwriters_stress=%d onoff_holdoff=%d onoff_interval=%d rt_boost=%d rt_boost_factor=%d shuffle_interval=%d shutdown_secs=%d stat_interval=%d stutter=%d verbose=%d writer_fifo=%d readers_bind=%*pbl writers_bind=%*pbl\n",
+		 "--- %s%s: acq_writer_lim=%d bind_readers=%*pbl bind_writers=%*pbl call_rcu_chains=%d long_hold=%d nested_locks=%d nreaders_stress=%d nwriters_stress=%d onoff_holdoff=%d onoff_interval=%d rt_boost=%d rt_boost_factor=%d shuffle_interval=%d shutdown_secs=%d stat_interval=%d stutter=%d verbose=%d writer_fifo=%d\n",
 		 torture_type, tag, cxt.debug_lock ? " [debug]": "",
-		 acq_writer_lim, call_rcu_chains, long_hold, nested_locks, cxt.nrealreaders_stress,
+		 acq_writer_lim, cpumask_pr_args(rcmp), cpumask_pr_args(wcmp),
+		 call_rcu_chains, long_hold, nested_locks, cxt.nrealreaders_stress,
 		 cxt.nrealwriters_stress, onoff_holdoff, onoff_interval, rt_boost,
 		 rt_boost_factor, shuffle_interval, shutdown_secs, stat_interval, stutter,
-		 verbose, writer_fifo,
-		 cpumask_pr_args(rcmp), cpumask_pr_args(wcmp));
+		 verbose, writer_fifo);
 }
 
 // If requested, maintain call_rcu() chains to keep a grace period always
@@ -1356,8 +1356,8 @@ static int __init lock_torture_init(void)
 						     writer_fifo ? sched_set_fifo : NULL);
 		if (torture_init_error(firsterr))
 			goto unwind;
-		if (cpumask_nonempty(writers_bind))
-			torture_sched_setaffinity(writer_tasks[i]->pid, writers_bind);
+		if (cpumask_nonempty(bind_writers))
+			torture_sched_setaffinity(writer_tasks[i]->pid, bind_writers);
 
 	create_reader:
 		if (cxt.cur_ops->readlock == NULL || (j >= cxt.nrealreaders_stress))
@@ -1367,8 +1367,8 @@ static int __init lock_torture_init(void)
 						  reader_tasks[j]);
 		if (torture_init_error(firsterr))
 			goto unwind;
-		if (cpumask_nonempty(readers_bind))
-			torture_sched_setaffinity(reader_tasks[j]->pid, readers_bind);
+		if (cpumask_nonempty(bind_readers))
+			torture_sched_setaffinity(reader_tasks[j]->pid, bind_readers);
 	}
 	if (stat_interval > 0) {
 		firsterr = torture_create_kthread(lock_torture_stats, NULL,
-- 
2.34.1

