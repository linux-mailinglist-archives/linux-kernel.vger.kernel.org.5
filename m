Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2E07BFA87
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 14:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbjJJMAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 08:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbjJJL7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 07:59:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC37B99;
        Tue, 10 Oct 2023 04:59:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBB98C433CB;
        Tue, 10 Oct 2023 11:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696939191;
        bh=6SHl5yfLgLqz1a6BKYTG8WutUg7DP24A8wyXyXhog08=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lo9wKiLolE7HeqR3SyrggItEhXe1sKN/TT5jSQmc+wC7lONQtjTehFXue8moGRqyF
         O9S8vZ4vJAPqswjraWZPC4kfkl6j9SLbkxg3EdNVfQKVv8XRHKvK9J6rDCP1D5+4Fm
         zkAuSFAIw7B+WYm+2BH4A72RhNSAUD8YDBLZCr1OEFSq5/Nki1kMXT2sw4pXDnQTNu
         UdNvk1eYf1NYMnmq7HxjIjTsIab25JMihPI8M+sbLELkEJJrFkJdEjjTdNICsIG2Ab
         iE6g2eZz0vQsadvzvEZidjUMs54qZYib2bqLvBCSFAt0PAQRaecXTcwCvbcAJ0q3NB
         r9ZLtcUh74YfQ==
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
Subject: [PATCH 06/23] locktorture: Add readers_bind and writers_bind module parameters
Date:   Tue, 10 Oct 2023 13:59:04 +0200
Message-Id: <20231010115921.988766-7-frederic@kernel.org>
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

This commit adds readers_bind and writers_bind module parameters to
locktorture in order to skew tests across socket boundaries.  This skewing
is intended to provide additional variable-latency stress on the primitive
under test.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/locking/locktorture.c | 64 ++++++++++++++++++++++++++++++++++--
 1 file changed, 62 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 270c7f80ce84..441866259278 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -56,6 +56,55 @@ module_param(torture_type, charp, 0444);
 MODULE_PARM_DESC(torture_type,
 		 "Type of lock to torture (spin_lock, spin_lock_irq, mutex_lock, ...)");
 
+static cpumask_var_t readers_bind; // Bind the readers to the specified set of CPUs.
+static cpumask_var_t writers_bind; // Bind the writers to the specified set of CPUs.
+
+// Parse a cpumask kernel parameter.  If there are more users later on,
+// this might need to got to a more central location.
+static int param_set_cpumask(const char *val, const struct kernel_param *kp)
+{
+	cpumask_var_t *cm_bind = kp->arg;
+	int ret;
+	char *s;
+
+	if (!alloc_cpumask_var(cm_bind, GFP_KERNEL)) {
+		s = "Out of memory";
+		ret = -ENOMEM;
+		goto out_err;
+	}
+	ret = cpulist_parse(val, *cm_bind);
+	if (!ret)
+		return ret;
+	s = "Bad CPU range";
+out_err:
+	pr_warn("%s: %s, all CPUs set\n", kp->name, s);
+	cpumask_setall(*cm_bind);
+	return ret;
+}
+
+// Output a cpumask kernel parameter.
+static int param_get_cpumask(char *buffer, const struct kernel_param *kp)
+{
+	cpumask_var_t *cm_bind = kp->arg;
+
+	return sprintf(buffer, "%*pbl", cpumask_pr_args(*cm_bind));
+}
+
+static bool cpumask_nonempty(cpumask_var_t mask)
+{
+	return cpumask_available(mask) && !cpumask_empty(mask);
+}
+
+static const struct kernel_param_ops lt_bind_ops = {
+	.set = param_set_cpumask,
+	.get = param_get_cpumask,
+};
+
+module_param_cb(readers_bind, &lt_bind_ops, &readers_bind, 0644);
+module_param_cb(writers_bind, &lt_bind_ops, &writers_bind, 0644);
+
+long torture_sched_setaffinity(pid_t pid, const struct cpumask *in_mask);
+
 static struct task_struct *stats_task;
 static struct task_struct **writer_tasks;
 static struct task_struct **reader_tasks;
@@ -986,16 +1035,23 @@ static int lock_torture_stats(void *arg)
 	return 0;
 }
 
+
 static inline void
 lock_torture_print_module_parms(struct lock_torture_ops *cur_ops,
 				const char *tag)
 {
+	static cpumask_t cpumask_all;
+	cpumask_t *rcmp = cpumask_nonempty(readers_bind) ? readers_bind : &cpumask_all;
+	cpumask_t *wcmp = cpumask_nonempty(writers_bind) ? writers_bind : &cpumask_all;
+
+	cpumask_setall(&cpumask_all);
 	pr_alert("%s" TORTURE_FLAG
-		 "--- %s%s: nwriters_stress=%d nreaders_stress=%d nested_locks=%d stat_interval=%d verbose=%d shuffle_interval=%d stutter=%d shutdown_secs=%d onoff_interval=%d onoff_holdoff=%d\n",
+		 "--- %s%s: nwriters_stress=%d nreaders_stress=%d nested_locks=%d stat_interval=%d verbose=%d shuffle_interval=%d stutter=%d shutdown_secs=%d onoff_interval=%d onoff_holdoff=%d readers_bind=%*pbl writers_bind=%*pbl\n",
 		 torture_type, tag, cxt.debug_lock ? " [debug]": "",
 		 cxt.nrealwriters_stress, cxt.nrealreaders_stress,
 		 nested_locks, stat_interval, verbose, shuffle_interval,
-		 stutter, shutdown_secs, onoff_interval, onoff_holdoff);
+		 stutter, shutdown_secs, onoff_interval, onoff_holdoff,
+		 cpumask_pr_args(rcmp), cpumask_pr_args(wcmp));
 }
 
 static void lock_torture_cleanup(void)
@@ -1250,6 +1306,8 @@ static int __init lock_torture_init(void)
 						     writer_fifo ? sched_set_fifo : NULL);
 		if (torture_init_error(firsterr))
 			goto unwind;
+		if (cpumask_nonempty(writers_bind))
+			torture_sched_setaffinity(writer_tasks[i]->pid, writers_bind);
 
 	create_reader:
 		if (cxt.cur_ops->readlock == NULL || (j >= cxt.nrealreaders_stress))
@@ -1259,6 +1317,8 @@ static int __init lock_torture_init(void)
 						  reader_tasks[j]);
 		if (torture_init_error(firsterr))
 			goto unwind;
+		if (cpumask_nonempty(readers_bind))
+			torture_sched_setaffinity(reader_tasks[j]->pid, readers_bind);
 	}
 	if (stat_interval > 0) {
 		firsterr = torture_create_kthread(lock_torture_stats, NULL,
-- 
2.34.1

