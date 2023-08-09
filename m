Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD8E1776C04
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 00:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbjHIWND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 18:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjHIWM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 18:12:56 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE49FE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 15:12:54 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-40fd2de0ddcso1401881cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 15:12:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691619173; x=1692223973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=my7KvWpBax07SiFGA75jMeAqtWUxF1Y/C+Nl9uBqALw=;
        b=d6tpVQEJIhqG9INdfyZos7vupdpaTkItOGIyhMhDu/fmZjhO+0lo2Nd33IH1QuWBPQ
         ZajP98eUKRPyRPEJEwzoS7mQ8/xV8MOlW2viOYSV1FJ8+D+AFDd6y0iBOr/AVd618BsP
         IXyDtQ1GepZWHd55LMj0ZLtf/cW8z5UTswKDhbSt3aC5Zc7wOq0Zz/DZbQZaQwE4fJRq
         80xa1rPKGGePektULh0hygle/n3ey6wCAfsYbdv9g/AH+rUdQl6pxbS3ckI4ou22Et7J
         2rHVFDH2cpg0PdbwHfsZLhuYdwjjpYOL100tJxx8ovgsoGPTYAsO/m9xv+adHlHakJxW
         CfsA==
X-Gm-Message-State: AOJu0Yz6WewfQ/78K2ArblfyupdpKBv5xIne2l4HYda5y2A2yNyU0P+L
        T+e1gml6z2tJM49LQmdejFlLdUVvWetmX68s
X-Google-Smtp-Source: AGHT+IEhS7+dHkIMTLR7HLmTiHfjdlJJaZQ6ts8Yn+4aufQCuVeXCecsX1btMZJvJglWa9RgWg8J4A==
X-Received: by 2002:a05:622a:153:b0:403:c3cd:d7c3 with SMTP id v19-20020a05622a015300b00403c3cdd7c3mr736588qtw.50.1691619172985;
        Wed, 09 Aug 2023 15:12:52 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:ed08])
        by smtp.gmail.com with ESMTPSA id c17-20020ac80091000000b003ff1f891206sm38648qtg.61.2023.08.09.15.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 15:12:52 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, tj@kernel.org,
        roman.gushchin@linux.dev, gautham.shenoy@amd.com,
        kprateek.nayak@amd.com, aaron.lu@intel.com,
        wuyun.abel@bytedance.com, kernel-team@meta.com
Subject: [PATCH v3 4/7] sched: Enable sched_feat callbacks on enable/disable
Date:   Wed,  9 Aug 2023 17:12:15 -0500
Message-ID: <20230809221218.163894-5-void@manifault.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809221218.163894-1-void@manifault.com>
References: <20230809221218.163894-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a scheduler feature is enabled or disabled, the sched_feat_enable()
and sched_feat_disable() functions are invoked respectively for that
feature. For features that don't require resetting any state, this works
fine. However, there will be an upcoming feature called shared_runq
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
index dd6412a49263..385c565da87f 100644
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
index aeeba46a096b..803dff75c56f 100644
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
index 88cca7cc00cf..2631da3c8a4d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2065,6 +2065,8 @@ static inline void __set_task_cpu(struct task_struct *p, unsigned int cpu)
 #endif
 }
 
+#define SCHED_FEAT(name, enabled) SCHED_FEAT_CALLBACK(name, enabled, NULL)
+
 /*
  * Tunables that become constants when CONFIG_SCHED_DEBUG is off:
  */
@@ -2074,7 +2076,7 @@ static inline void __set_task_cpu(struct task_struct *p, unsigned int cpu)
 # define const_debug const
 #endif
 
-#define SCHED_FEAT(name, enabled)	\
+#define SCHED_FEAT_CALLBACK(name, enabled, cb)	\
 	__SCHED_FEAT_##name ,
 
 enum {
@@ -2082,7 +2084,7 @@ enum {
 	__SCHED_FEAT_NR,
 };
 
-#undef SCHED_FEAT
+#undef SCHED_FEAT_CALLBACK
 
 #ifdef CONFIG_SCHED_DEBUG
 
@@ -2093,14 +2095,14 @@ enum {
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
@@ -2118,17 +2120,19 @@ extern struct static_key sched_feat_keys[__SCHED_FEAT_NR];
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
2.41.0

