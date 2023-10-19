Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74497CF7E9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345593AbjJSMCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345553AbjJSMCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:02:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232CF185;
        Thu, 19 Oct 2023 05:02:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 823F8C433C7;
        Thu, 19 Oct 2023 12:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697716940;
        bh=bhK7cpMcCCHf65DdGbg8GB1m9tvgdwB0ladW+FEjA30=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fNaDKtq/fWbOHQCRBpTHuRLfmW/MkoB4YaR+5e7TvIKkSpO9vMtSbl8LPYrwEC6GU
         kGh+KVdvoaTwG+I5OB34Q6CUfaM/Vb0u7mJKhbm+xx6YYeKL3+Gjobcv6PdyGNr7hi
         Ak8ZoNd3jjByotxBUXe+iBAHO+9W0kacIJrFExvo8ghKWRk4qhmcnJNFX0B11u8eTP
         pxwb/A80ol9BUz4O58JTSbAl5/TAbiEV3JAvfVSziiMKL1d7yhqPPGhQikuejMPpCF
         N4CyeTeIOPXZg7iUACYUZuRcNTzHLYJXY0GEkB16aEGmRxm223FhE7BFHNukrH21ac
         uwmPuz1lye1rQ==
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
Subject: [PATCH 4/6] rcu: Add RCU CPU stall notifier
Date:   Thu, 19 Oct 2023 14:02:00 +0200
Message-Id: <20231019120202.1216228-5-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019120202.1216228-1-frederic@kernel.org>
References: <20231019120202.1216228-1-frederic@kernel.org>
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

It is sometimes helpful to have a way for the subsystem causing
the stall to dump its state when an RCU CPU stall occurs.  This
commit therefore bases rcu_stall_chain_notifier_register() and
rcu_stall_chain_notifier_unregister() on atomic notifiers in order to
provide this functionality.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/rcu_notifier.h | 32 +++++++++++++++++++
 kernel/rcu/rcu.h             |  6 ++++
 kernel/rcu/tree_exp.h        |  6 +++-
 kernel/rcu/tree_stall.h      | 59 +++++++++++++++++++++++++++++++++++-
 4 files changed, 101 insertions(+), 2 deletions(-)
 create mode 100644 include/linux/rcu_notifier.h

diff --git a/include/linux/rcu_notifier.h b/include/linux/rcu_notifier.h
new file mode 100644
index 000000000000..ebf371364581
--- /dev/null
+++ b/include/linux/rcu_notifier.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Read-Copy Update notifiers, initially RCU CPU stall notifier.
+ * Separate from rcupdate.h to avoid #include loops.
+ *
+ * Copyright (C) 2023 Paul E. McKenney.
+ */
+
+#ifndef __LINUX_RCU_NOTIFIER_H
+#define __LINUX_RCU_NOTIFIER_H
+
+// Actions for RCU CPU stall notifier calls.
+#define RCU_STALL_NOTIFY_NORM	1
+#define RCU_STALL_NOTIFY_EXP	2
+
+#ifdef CONFIG_RCU_STALL_COMMON
+
+#include <linux/notifier.h>
+#include <linux/types.h>
+
+int rcu_stall_chain_notifier_register(struct notifier_block *n);
+int rcu_stall_chain_notifier_unregister(struct notifier_block *n);
+
+#else // #ifdef CONFIG_RCU_STALL_COMMON
+
+// No RCU CPU stall warnings in Tiny RCU.
+static inline int rcu_stall_chain_notifier_register(struct notifier_block *n) { return -EEXIST; }
+static inline int rcu_stall_chain_notifier_unregister(struct notifier_block *n) { return -ENOENT; }
+
+#endif // #else // #ifdef CONFIG_RCU_STALL_COMMON
+
+#endif /* __LINUX_RCU_NOTIFIER_H */
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 98e13be411af..ef3bab977407 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -654,4 +654,10 @@ static inline bool rcu_cpu_beenfullyonline(int cpu) { return true; }
 bool rcu_cpu_beenfullyonline(int cpu);
 #endif
 
+#ifdef CONFIG_RCU_STALL_COMMON
+int rcu_stall_notifier_call_chain(unsigned long val, void *v);
+#else // #ifdef CONFIG_RCU_STALL_COMMON
+static inline int rcu_stall_notifier_call_chain(unsigned long val, void *v) { return NOTIFY_DONE; }
+#endif // #else // #ifdef CONFIG_RCU_STALL_COMMON
+
 #endif /* __LINUX_RCU_H */
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 8239b39d945b..6d7cea5d591f 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -621,10 +621,14 @@ static void synchronize_rcu_expedited_wait(void)
 	}
 
 	for (;;) {
+		unsigned long j;
+
 		if (synchronize_rcu_expedited_wait_once(jiffies_stall))
 			return;
 		if (rcu_stall_is_suppressed())
 			continue;
+		j = jiffies;
+		rcu_stall_notifier_call_chain(RCU_STALL_NOTIFY_EXP, (void *)(j - jiffies_start));
 		trace_rcu_stall_warning(rcu_state.name, TPS("ExpeditedStall"));
 		pr_err("INFO: %s detected expedited stalls on CPUs/tasks: {",
 		       rcu_state.name);
@@ -647,7 +651,7 @@ static void synchronize_rcu_expedited_wait(void)
 			}
 		}
 		pr_cont(" } %lu jiffies s: %lu root: %#lx/%c\n",
-			jiffies - jiffies_start, rcu_state.expedited_sequence,
+			j - jiffies_start, rcu_state.expedited_sequence,
 			data_race(rnp_root->expmask),
 			".T"[!!data_race(rnp_root->exp_tasks)]);
 		if (ndetected) {
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 2443d1d4a6dc..49544f932279 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -8,6 +8,7 @@
  */
 
 #include <linux/kvm_para.h>
+#include <linux/rcu_notifier.h>
 
 //////////////////////////////////////////////////////////////////////////////
 //
@@ -770,6 +771,7 @@ static void check_cpu_stall(struct rcu_data *rdp)
 		if (kvm_check_and_clear_guest_paused())
 			return;
 
+		rcu_stall_notifier_call_chain(RCU_STALL_NOTIFY_NORM, (void *)j - gps);
 		if (self_detected) {
 			/* We haven't checked in, so go dump stack. */
 			print_cpu_stall(gps);
@@ -790,7 +792,7 @@ static void check_cpu_stall(struct rcu_data *rdp)
 
 //////////////////////////////////////////////////////////////////////////////
 //
-// RCU forward-progress mechanisms, including of callback invocation.
+// RCU forward-progress mechanisms, including for callback invocation.
 
 
 /*
@@ -1042,3 +1044,58 @@ static int __init rcu_sysrq_init(void)
 	return 0;
 }
 early_initcall(rcu_sysrq_init);
+
+
+//////////////////////////////////////////////////////////////////////////////
+//
+// RCU CPU stall-warning notifiers
+
+static ATOMIC_NOTIFIER_HEAD(rcu_cpu_stall_notifier_list);
+
+/**
+ * rcu_stall_chain_notifier_register - Add an RCU CPU stall notifier
+ * @n: Entry to add.
+ *
+ * Adds an RCU CPU stall notifier to an atomic notifier chain.
+ * The @action passed to a notifier will be @RCU_STALL_NOTIFY_NORM or
+ * friends.  The @data will be the duration of the stalled grace period,
+ * in jiffies, coerced to a void* pointer.
+ *
+ * Returns 0 on success, %-EEXIST on error.
+ */
+int rcu_stall_chain_notifier_register(struct notifier_block *n)
+{
+	return atomic_notifier_chain_register(&rcu_cpu_stall_notifier_list, n);
+}
+EXPORT_SYMBOL_GPL(rcu_stall_chain_notifier_register);
+
+/**
+ * rcu_stall_chain_notifier_unregister - Remove an RCU CPU stall notifier
+ * @n: Entry to add.
+ *
+ * Removes an RCU CPU stall notifier from an atomic notifier chain.
+ *
+ * Returns zero on success, %-ENOENT on failure.
+ */
+int rcu_stall_chain_notifier_unregister(struct notifier_block *n)
+{
+	return atomic_notifier_chain_unregister(&rcu_cpu_stall_notifier_list, n);
+}
+EXPORT_SYMBOL_GPL(rcu_stall_chain_notifier_unregister);
+
+/*
+ * rcu_stall_notifier_call_chain - Call functions in an RCU CPU stall notifier chain
+ * @val: Value passed unmodified to notifier function
+ * @v: Pointer passed unmodified to notifier function
+ *
+ * Calls each function in the RCU CPU stall notifier chain in turn, which
+ * is an atomic call chain.  See atomic_notifier_call_chain() for more
+ * information.
+ *
+ * This is for use within RCU, hence the omission of the extra asterisk
+ * to indicate a non-kerneldoc format header comment.
+ */
+int rcu_stall_notifier_call_chain(unsigned long val, void *v)
+{
+	return atomic_notifier_call_chain(&rcu_cpu_stall_notifier_list, val, v);
+}
-- 
2.34.1

