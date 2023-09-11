Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A14279B5AC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346734AbjIKVXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236574AbjIKLBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 07:01:17 -0400
Received: from out-219.mta0.migadu.com (out-219.mta0.migadu.com [91.218.175.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4588E198
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 04:01:11 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1694430069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=E5yHKp0OcXp3JHJgg+0qOrM4VXGsFKESg9vuY4j64KM=;
        b=RFgJBw48EPZafs2msT138v8SXX3p9xUpN/mvU6RgMl44mFl5tuNwYlwSB0mKtJRoeAdXUJ
        C1g5Lk5GblE6HBE93nzpeDZldouoYN22NM8R+3AHXm+4Q85V5H++AgcpRZ8xxh5kYJFzwH
        SMsGTEyx07SRu2mkQtSXMN2LZfpAFAE=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     corbet@lwn.net, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        mhiramat@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH] sched: Change the name of preempt mode from full to low_latency
Date:   Mon, 11 Sep 2023 19:00:46 +0800
Message-Id: <20230911110046.3877123-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a similar name fully in Kconfig.preempt, but it corresponds to
PREEMPT_RT. In order to distinguish them, change the name of preempt mode
from full to low_latency.

Also, define a global array and variable that used to save preempt mode
name and size.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 .../admin-guide/kernel-parameters.txt         |  2 +-
 include/linux/sched.h                         |  8 ++--
 kernel/sched/core.c                           | 43 ++++++++++---------
 kernel/sched/debug.c                          |  5 +--
 kernel/sched/sched.h                          |  2 +
 kernel/trace/trace.c                          |  4 +-
 6 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0a1731a0f0ef..9284fd7999d7 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4581,7 +4581,7 @@
 			Select preemption mode if you have CONFIG_PREEMPT_DYNAMIC
 			none - Limited to cond_resched() calls
 			voluntary - Limited to cond_resched() and might_sleep() calls
-			full - Any section that isn't explicitly preempt disabled
+			low_latency - Any section that isn't explicitly preempt disabled
 			       can be preempted anytime.
 
 	print-fatal-signals=
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 6d1341b1673f..ea607a0ce6f6 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2181,7 +2181,7 @@ static inline void cond_resched_rcu(void)
 
 extern bool preempt_model_none(void);
 extern bool preempt_model_voluntary(void);
-extern bool preempt_model_full(void);
+extern bool preempt_model_low_latency(void);
 
 #else
 
@@ -2193,14 +2193,14 @@ static inline bool preempt_model_voluntary(void)
 {
 	return IS_ENABLED(CONFIG_PREEMPT_VOLUNTARY);
 }
-static inline bool preempt_model_full(void)
+static inline bool preempt_model_low_latency(void)
 {
 	return IS_ENABLED(CONFIG_PREEMPT);
 }
 
 #endif
 
-static inline bool preempt_model_rt(void)
+static inline bool preempt_model_fully(void)
 {
 	return IS_ENABLED(CONFIG_PREEMPT_RT);
 }
@@ -2215,7 +2215,7 @@ static inline bool preempt_model_rt(void)
  */
 static inline bool preempt_model_preemptible(void)
 {
-	return preempt_model_full() || preempt_model_rt();
+	return preempt_model_low_latency() || preempt_model_fully();
 }
 
 /*
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2299a5cfbfb9..2abbc0baaae7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8705,7 +8705,7 @@ EXPORT_SYMBOL(__cond_resched_rwlock_write);
  *   preempt_schedule_notrace   <- NOP
  *   irqentry_exit_cond_resched <- NOP
  *
- * FULL:
+ * LOW_LATENCY:
  *   cond_resched               <- RET0
  *   might_resched              <- RET0
  *   preempt_schedule           <- preempt_schedule
@@ -8717,21 +8717,25 @@ enum {
 	preempt_dynamic_undefined = -1,
 	preempt_dynamic_none,
 	preempt_dynamic_voluntary,
-	preempt_dynamic_full,
+	preempt_dynamic_low_latency,
 };
-
 int preempt_dynamic_mode = preempt_dynamic_undefined;
 
+const char *preempt_modes[] = {
+	[preempt_dynamic_none]        = "none",
+	[preempt_dynamic_voluntary]   = "voluntary",
+	[preempt_dynamic_low_latency] = "low_latency",
+};
+int preempt_modes_size = ARRAY_SIZE(preempt_modes);
+
 int sched_dynamic_mode(const char *str)
 {
-	if (!strcmp(str, "none"))
-		return preempt_dynamic_none;
-
-	if (!strcmp(str, "voluntary"))
-		return preempt_dynamic_voluntary;
+	int i;
 
-	if (!strcmp(str, "full"))
-		return preempt_dynamic_full;
+	for (i = 0; i < preempt_modes_size; i++) {
+		if (!strcmp(str, preempt_modes[i]))
+			return i;
+	}
 
 	return -EINVAL;
 }
@@ -8752,7 +8756,7 @@ static bool klp_override;
 static void __sched_dynamic_update(int mode)
 {
 	/*
-	 * Avoid {NONE,VOLUNTARY} -> FULL transitions from ever ending up in
+	 * Avoid {NONE,VOLUNTARY} -> LOW_LATENCY transitions from ever ending up in
 	 * the ZERO state, which is invalid.
 	 */
 	if (!klp_override)
@@ -8770,8 +8774,6 @@ static void __sched_dynamic_update(int mode)
 		preempt_dynamic_disable(preempt_schedule);
 		preempt_dynamic_disable(preempt_schedule_notrace);
 		preempt_dynamic_disable(irqentry_exit_cond_resched);
-		if (mode != preempt_dynamic_mode)
-			pr_info("Dynamic Preempt: none\n");
 		break;
 
 	case preempt_dynamic_voluntary:
@@ -8781,22 +8783,21 @@ static void __sched_dynamic_update(int mode)
 		preempt_dynamic_disable(preempt_schedule);
 		preempt_dynamic_disable(preempt_schedule_notrace);
 		preempt_dynamic_disable(irqentry_exit_cond_resched);
-		if (mode != preempt_dynamic_mode)
-			pr_info("Dynamic Preempt: voluntary\n");
 		break;
 
-	case preempt_dynamic_full:
+	case preempt_dynamic_low_latency:
 		if (!klp_override)
 			preempt_dynamic_disable(cond_resched);
 		preempt_dynamic_disable(might_resched);
 		preempt_dynamic_enable(preempt_schedule);
 		preempt_dynamic_enable(preempt_schedule_notrace);
 		preempt_dynamic_enable(irqentry_exit_cond_resched);
-		if (mode != preempt_dynamic_mode)
-			pr_info("Dynamic Preempt: full\n");
 		break;
 	}
 
+	if (mode != preempt_dynamic_mode)
+		pr_info("Dynamic Preempt: %s\n", preempt_modes[mode]);
+
 	preempt_dynamic_mode = mode;
 }
 
@@ -8860,8 +8861,8 @@ static void __init preempt_dynamic_init(void)
 		} else {
 			/* Default static call setting, nothing to do */
 			WARN_ON_ONCE(!IS_ENABLED(CONFIG_PREEMPT));
-			preempt_dynamic_mode = preempt_dynamic_full;
-			pr_info("Dynamic Preempt: full\n");
+			preempt_dynamic_mode = preempt_dynamic_low_latency;
+			pr_info("Dynamic Preempt: %s\n", preempt_modes[preempt_dynamic_mode]);
 		}
 	}
 }
@@ -8876,7 +8877,7 @@ static void __init preempt_dynamic_init(void)
 
 PREEMPT_MODEL_ACCESSOR(none);
 PREEMPT_MODEL_ACCESSOR(voluntary);
-PREEMPT_MODEL_ACCESSOR(full);
+PREEMPT_MODEL_ACCESSOR(low_latency);
 
 #else /* !CONFIG_PREEMPT_DYNAMIC */
 
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 4c3d0d9f3db6..fd516dcff988 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -244,12 +244,9 @@ static ssize_t sched_dynamic_write(struct file *filp, const char __user *ubuf,
 
 static int sched_dynamic_show(struct seq_file *m, void *v)
 {
-	static const char * preempt_modes[] = {
-		"none", "voluntary", "full"
-	};
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(preempt_modes); i++) {
+	for (i = 0; i < preempt_modes_size; i++) {
 		if (preempt_dynamic_mode == i)
 			seq_puts(m, "(");
 		seq_puts(m, preempt_modes[i]);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 04846272409c..6210c40f35da 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3276,6 +3276,8 @@ extern int try_to_wake_up(struct task_struct *tsk, unsigned int state, int wake_
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
 extern int preempt_dynamic_mode;
+extern const char *preempt_modes[];
+extern int preempt_modes_size;
 extern int sched_dynamic_mode(const char *str);
 extern void sched_dynamic_update(int mode);
 #endif
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 2b4ded753367..3d731b4fea65 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4394,8 +4394,8 @@ print_trace_header(struct seq_file *m, struct trace_iterator *iter)
 		   buf->cpu,
 		   preempt_model_none()      ? "server" :
 		   preempt_model_voluntary() ? "desktop" :
-		   preempt_model_full()      ? "preempt" :
-		   preempt_model_rt()        ? "preempt_rt" :
+		   preempt_model_low_latency() ? "preempt" :
+		   preempt_model_fully()     ? "preempt_rt" :
 		   "unknown",
 		   /* These are reserved for later use */
 		   0, 0, 0, 0);
-- 
2.25.1

