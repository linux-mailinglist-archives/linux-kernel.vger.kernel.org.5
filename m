Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBFC80E04F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 01:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345540AbjLLAcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 19:32:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbjLLAbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 19:31:53 -0500
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D41EB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 16:31:57 -0800 (PST)
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7b7282c8941so117781339f.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 16:31:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702341116; x=1702945916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yBzcRTFaiR0ilwxHlsslqn3F7i5n50sLy2f363pQ9AQ=;
        b=GJgOIa8+yC6rEFpLya1tJ7q4sv4s5qIg7Fqqsbh66iGR0LB1GWOFwA9muC4Z59HOOk
         VuswMIPhWO/+u6opcOnfA6R8ncUZptGXdBueMBP41eFjgYzo7nE5L2E6UcZSsyLQfNb0
         kJn7msk3Zw7HWBTm2jXLmTloGDMQCPyGzWYmXMEUEy8tgit1y106s2sykoe12BmwQIfj
         cokOrWI4mWXWaJFKgPk3l0y1YAl934fLCpVT4k6qh4NwfdfqvmTSeaFIX7YKSdbLVFi7
         nX2xkmCfcONt3n40vbjPz34QPOzyk04TuWutCXWFToy9n7HSxym8/Wj8aFF6mqIiYGuT
         lHBw==
X-Gm-Message-State: AOJu0YxjcIR7VUoXQl3aOHkHvHyMMr/pX4O9aEQchddQYYsBybtCLE8i
        ePxrhnyaBRtVrT1FJuZRdROcMvI2kiDGSiCg
X-Google-Smtp-Source: AGHT+IHdSq9KNjoa9fidVqsbX5RYTRO6wWu2x+6fFubqi6wzFUJjpseH+vm31I41WPd3xg+jy0wUNA==
X-Received: by 2002:a05:6602:21d8:b0:7b6:fffd:a0ff with SMTP id c24-20020a05660221d800b007b6fffda0ffmr6634964ioc.32.1702341116362;
        Mon, 11 Dec 2023 16:31:56 -0800 (PST)
Received: from localhost (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id z26-20020a056602005a00b007b6ed1d8884sm2412341ioz.39.2023.12.11.16.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 16:31:55 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, youssefesmat@google.com, joelaf@google.com,
        roman.gushchin@linux.dev, yu.c.chen@intel.com,
        kprateek.nayak@amd.com, gautham.shenoy@amd.com,
        aboorvad@linux.vnet.ibm.com, wuyun.abel@bytedance.com,
        tj@kernel.org, kernel-team@meta.com
Subject: [PATCH v4 5/8] sched: Enable sched_feat callbacks on enable/disable
Date:   Mon, 11 Dec 2023 18:31:38 -0600
Message-ID: <20231212003141.216236-6-void@manifault.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231212003141.216236-1-void@manifault.com>
References: <20231212003141.216236-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a scheduler feature is enabled or disabled, the sched_feat_enable()
and sched_feat_disable() functions are invoked respectively for that
feature. For features that don't require resetting any state, this works
fine. However, there will be an upcoming feature called SHARED_RUNQ
which needs to drain all tasks from a set of global shared runqueues in
order to avoid stale tasks from staying in the queues after the feature
has been disabled.

This patch therefore defines a new SCHED_FEAT_CALLBACK macro which
allows scheduler features to specify a callback that should be invoked
when a feature is enabled or disabled respectively. The SCHED_FEAT macro
assumes a NULL callback.

Signed-off-by: David Vernet <void@manifault.com>
---
 kernel/sched/core.c  |  4 ++--
 kernel/sched/debug.c | 18 ++++++++++++++----
 kernel/sched/sched.h | 16 ++++++++++------
 3 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9ad7f0255e14..045ac2539f37 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -124,12 +124,12 @@ DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
  * sysctl_sched_features, defined in sched.h, to allow constants propagation
  * at compile time and compiler optimization based on features default.
  */
-#define SCHED_FEAT(name, enabled)	\
+#define SCHED_FEAT_CALLBACK(name, enabled, cb)	\
 	(1UL << __SCHED_FEAT_##name) * enabled |
 const_debug unsigned int sysctl_sched_features =
 #include "features.h"
 	0;
-#undef SCHED_FEAT
+#undef SCHED_FEAT_CALLBACK
 
 /*
  * Print a warning if need_resched is set for the given duration (if
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 168eecc209b4..0b72799c7e84 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -44,14 +44,14 @@ static unsigned long nsec_low(unsigned long long nsec)
 
 #define SPLIT_NS(x) nsec_high(x), nsec_low(x)
 
-#define SCHED_FEAT(name, enabled)	\
+#define SCHED_FEAT_CALLBACK(name, enabled, cb)	\
 	#name ,
 
 static const char * const sched_feat_names[] = {
 #include "features.h"
 };
 
-#undef SCHED_FEAT
+#undef SCHED_FEAT_CALLBACK
 
 static int sched_feat_show(struct seq_file *m, void *v)
 {
@@ -72,22 +72,32 @@ static int sched_feat_show(struct seq_file *m, void *v)
 #define jump_label_key__true  STATIC_KEY_INIT_TRUE
 #define jump_label_key__false STATIC_KEY_INIT_FALSE
 
-#define SCHED_FEAT(name, enabled)	\
+#define SCHED_FEAT_CALLBACK(name, enabled, cb)	\
 	jump_label_key__##enabled ,
 
 struct static_key sched_feat_keys[__SCHED_FEAT_NR] = {
 #include "features.h"
 };
 
-#undef SCHED_FEAT
+#undef SCHED_FEAT_CALLBACK
+
+#define SCHED_FEAT_CALLBACK(name, enabled, cb) cb,
+static const sched_feat_change_f sched_feat_cbs[__SCHED_FEAT_NR] = {
+#include "features.h"
+};
+#undef SCHED_FEAT_CALLBACK
 
 static void sched_feat_disable(int i)
 {
+	if (sched_feat_cbs[i])
+		sched_feat_cbs[i](false);
 	static_key_disable_cpuslocked(&sched_feat_keys[i]);
 }
 
 static void sched_feat_enable(int i)
 {
+	if (sched_feat_cbs[i])
+		sched_feat_cbs[i](true);
 	static_key_enable_cpuslocked(&sched_feat_keys[i]);
 }
 #else
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 53fe2294eec7..517e67a0cc9a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2091,6 +2091,8 @@ static inline void __set_task_cpu(struct task_struct *p, unsigned int cpu)
 #endif
 }
 
+#define SCHED_FEAT(name, enabled) SCHED_FEAT_CALLBACK(name, enabled, NULL)
+
 /*
  * Tunables that become constants when CONFIG_SCHED_DEBUG is off:
  */
@@ -2100,7 +2102,7 @@ static inline void __set_task_cpu(struct task_struct *p, unsigned int cpu)
 # define const_debug const
 #endif
 
-#define SCHED_FEAT(name, enabled)	\
+#define SCHED_FEAT_CALLBACK(name, enabled, cb)	\
 	__SCHED_FEAT_##name ,
 
 enum {
@@ -2108,7 +2110,7 @@ enum {
 	__SCHED_FEAT_NR,
 };
 
-#undef SCHED_FEAT
+#undef SCHED_FEAT_CALLBACK
 
 #ifdef CONFIG_SCHED_DEBUG
 
@@ -2119,14 +2121,14 @@ enum {
 extern const_debug unsigned int sysctl_sched_features;
 
 #ifdef CONFIG_JUMP_LABEL
-#define SCHED_FEAT(name, enabled)					\
+#define SCHED_FEAT_CALLBACK(name, enabled, cb)				\
 static __always_inline bool static_branch_##name(struct static_key *key) \
 {									\
 	return static_key_##enabled(key);				\
 }
 
 #include "features.h"
-#undef SCHED_FEAT
+#undef SCHED_FEAT_CALLBACK
 
 extern struct static_key sched_feat_keys[__SCHED_FEAT_NR];
 #define sched_feat(x) (static_branch_##x(&sched_feat_keys[__SCHED_FEAT_##x]))
@@ -2144,17 +2146,19 @@ extern struct static_key sched_feat_keys[__SCHED_FEAT_NR];
  * constants propagation at compile time and compiler optimization based on
  * features default.
  */
-#define SCHED_FEAT(name, enabled)	\
+#define SCHED_FEAT_CALLBACK(name, enabled, cb)	\
 	(1UL << __SCHED_FEAT_##name) * enabled |
 static const_debug __maybe_unused unsigned int sysctl_sched_features =
 #include "features.h"
 	0;
-#undef SCHED_FEAT
+#undef SCHED_FEAT_CALLBACK
 
 #define sched_feat(x) !!(sysctl_sched_features & (1UL << __SCHED_FEAT_##x))
 
 #endif /* SCHED_DEBUG */
 
+typedef void (*sched_feat_change_f)(bool enabling);
+
 extern struct static_key_false sched_numa_balancing;
 extern struct static_key_false sched_schedstats;
 
-- 
2.42.1

