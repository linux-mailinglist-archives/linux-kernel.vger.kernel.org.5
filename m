Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F04F7B7703
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 06:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbjJDEIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 00:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbjJDEIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 00:08:52 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C375AC;
        Tue,  3 Oct 2023 21:08:48 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-7741b18a06aso122683985a.1;
        Tue, 03 Oct 2023 21:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696392527; x=1696997327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=KXzJ3D1GcfX5orm7vFTwCo+aKz92sYx9472yuyz2s0A=;
        b=hfpHsL+YO9QlKhejhemHYaS4ulZmaiAl6sBSeOwsskUES9PVVkEKJmVk5YTNSP/n0w
         s+N8d+95oz/oRweP4/3IVhRFnyNUUyRzH95M5kgKt+/BJVEU7qEwRKQ8nen5Fg+u4czm
         rd2I19cJApd9fJmPdgdPF0mdCBNK5TTTEhYJ4w5Dg7+gr/r+2PmHNp+Viszkjkdg5sOF
         R1e1Knr6TTRaXHVOFXFXU74YMjev3FnjQD9yTT/OshRcfBISNsR6SqBukWngWdP0Ws9b
         8kcx1Hvn19LqAs6uvN1MJm81Y5azhXhxPiAeEEpsF/1Nmhm1H4Cg8h8ZECsikErwBEPg
         EFIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696392527; x=1696997327;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KXzJ3D1GcfX5orm7vFTwCo+aKz92sYx9472yuyz2s0A=;
        b=XOxXApaQAlye+4ssaf7WXp5Ba4/m76sbahbRHhAFAND62WmaCsGWJq62zSoj8oDKYc
         2psPmQMN3DK/qAx2zgCn3yFE9sRAlyv3BGN0ze2uHG7rWYQGP0ul8e6Y9+IUAWpxHwuA
         OLm8PTOTk1pXXqyDsuQLFNfXqgsqfU3l+BOiNyk20M/hLHqsXVu+810PRjMbLessdjvz
         K3FlflJXLwoHRSvgPhBypS968OPSCgnZXgyAgfATIaf86cnYW+EEpQW+gw+3VCxaWZ8c
         JFdCVubM9YkDDbH4rkwGIfwHXkBC2tqH68TQw3VH3mj9zBUsM4fkUXduT7gWC/jBOUgr
         TmrA==
X-Gm-Message-State: AOJu0YxFxUhPHJOMvXwEpHsQWyplNQZYC2IvOB3A/wuLAG8i/PNmNBSh
        tbAs0APjL7tz56zFY4GCHBnS0x5eHmg=
X-Google-Smtp-Source: AGHT+IGPMHYCR7h93PO9ZD6gYYUFohsnwrzn92/mLsBUapIdoIEH9SH2K+EKpKx/SBcji3M/oAblHg==
X-Received: by 2002:a05:620a:2950:b0:76f:2f7b:cf61 with SMTP id n16-20020a05620a295000b0076f2f7bcf61mr1465437qkp.61.1696392527084;
        Tue, 03 Oct 2023 21:08:47 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:cb85:e14:b63a:6d8d])
        by smtp.gmail.com with ESMTPSA id a24-20020a637058000000b00581048ffc13sm2245081pgn.81.2023.10.03.21.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 21:08:46 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>, stable@vger.kernel.org
Subject: [PATCH] perf/core: Introduce cpuctx->cgrp_ctx_list
Date:   Tue,  3 Oct 2023 21:08:44 -0700
Message-ID: <20231004040844.797044-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit bd2756811766 ("perf: Rewrite core context handling") removed
cgrp_cpuctx_list to link active cpu (pmu) contexts together.  It's used
in the perf_cgroup_switch() to access cgroup events only.

But after the change, it ended up iterating all pmus/events in the cpu
context if there's a cgroup event somewhere on the cpu context.
Unfortunately it includes uncore pmus which have much longer latency to
control.

That regressed some load tests occasionally (only when unrelated perf
stat with cgroup events and uncore events ran on the same cpu) due to
increased context switch time.

AFAIK we don't have a tool to measure the context switch overhead
directly.  (I think I should add one to perf ftrace latency).  But I can
see it with a simple perf bench command like this.

  $ perf bench sched pipe -l 100000
  # Running 'sched/pipe' benchmark:
  # Executed 100000 pipe operations between two processes

       Total time: 0.650 [sec]

         6.505740 usecs/op
           153710 ops/sec

It runs two tasks communicate each other using a pipe so it should
stress the context switch code.  This is the normal numbers on my
system.  But after I run these two perf stat commands in background,
the numbers vary a lot.

  $ sudo perf stat -a -e cycles -G user.slice -- sleep 100000 &
  $ sudo perf stat -a -e uncore_imc/cas_count_read/ -- sleep 10000 &

I will show the last two lines of perf bench sched pipe output for
three runs.

        58.597060 usecs/op    # run 1
            17065 ops/sec

        11.329240 usecs/op    # run 2
            88267 ops/sec

        88.481920 usecs/op    # run 3
            11301 ops/sec

I think the deviation comes from the fact that uncore events are managed
a certain number of cpus only.  If the target process runs on a cpu that
manages uncore pmu, it'd take longer.  Otherwise it won't affect the
performance much.

To fix the issue, I restored a linked list equivalent to cgrp_cpuctx_list
in the perf_cpu_context and link perf_cpu_pmu_contexts that have cgroup
events only.  Also add new helpers to enable/disable and does ctx sched
in/out for cgroups.

After the change, I got something like this constantly.  It's slightly
higher than the normal, but it includes actual cgroup event switch time.

         8.970910 usecs/op
           111471 ops/sec

Fixes: bd2756811766 ("perf: Rewrite core context handling")
Cc: stable@vger.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 include/linux/perf_event.h |   5 ++
 kernel/events/core.c       | 117 +++++++++++++++++++++++++++++++++----
 2 files changed, 111 insertions(+), 11 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index e85cd1c0eaf3..7d56d7aa6b34 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -972,6 +972,10 @@ struct perf_cpu_pmu_context {
 	struct perf_event_pmu_context	epc;
 	struct perf_event_pmu_context	*task_epc;
 
+#ifdef CONFIG_CGROUP_PERF
+	struct list_head		cgrp_ctx_entry;
+#endif
+
 	struct list_head		sched_cb_entry;
 	int				sched_cb_usage;
 
@@ -994,6 +998,7 @@ struct perf_cpu_context {
 
 #ifdef CONFIG_CGROUP_PERF
 	struct perf_cgroup		*cgrp;
+	struct list_head		cgrp_ctx_list;
 #endif
 
 	/*
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4c72a41f11af..06b39b8066a9 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -700,11 +700,73 @@ static void perf_ctx_enable(struct perf_event_context *ctx)
 		perf_pmu_enable(pmu_ctx->pmu);
 }
 
+static int __ctx_sched_out(struct perf_event_context *ctx, enum event_type_t event_type);
 static void ctx_sched_out(struct perf_event_context *ctx, enum event_type_t event_type);
+static int __ctx_sched_in(struct perf_event_context *ctx, enum event_type_t event_type);
 static void ctx_sched_in(struct perf_event_context *ctx, enum event_type_t event_type);
+static void __pmu_ctx_sched_out(struct perf_event_pmu_context *pmu_ctx,
+				enum event_type_t event_type);
+static void ctx_pinned_sched_in(struct perf_event_context *ctx, struct pmu *pmu);
+static void ctx_flexible_sched_in(struct perf_event_context *ctx, struct pmu *pmu);
 
 #ifdef CONFIG_CGROUP_PERF
 
+static void perf_cgrp_ctx_disable(struct perf_event_context *ctx)
+{
+	struct perf_cpu_context *cpuctx;
+	struct perf_cpu_pmu_context *cpc;
+
+	cpuctx = container_of(ctx, struct perf_cpu_context, ctx);
+	list_for_each_entry(cpc, &cpuctx->cgrp_ctx_list, cgrp_ctx_entry)
+		perf_pmu_disable(cpc->epc.pmu);
+}
+
+static void perf_cgrp_ctx_enable(struct perf_event_context *ctx)
+{
+	struct perf_cpu_context *cpuctx;
+	struct perf_cpu_pmu_context *cpc;
+
+	cpuctx = container_of(ctx, struct perf_cpu_context, ctx);
+	list_for_each_entry(cpc, &cpuctx->cgrp_ctx_list, cgrp_ctx_entry)
+		perf_pmu_enable(cpc->epc.pmu);
+}
+
+static void cgrp_ctx_sched_out(struct perf_cpu_context *cpuctx,
+			       enum event_type_t event_type)
+{
+	struct perf_cpu_pmu_context *cpc;
+	int is_active = __ctx_sched_out(&cpuctx->ctx, event_type);
+
+	if (is_active < 0)
+		return;
+
+	list_for_each_entry(cpc, &cpuctx->cgrp_ctx_list, cgrp_ctx_entry)
+		__pmu_ctx_sched_out(&cpc->epc, is_active);
+}
+
+static void cgrp_ctx_sched_in(struct perf_cpu_context *cpuctx,
+			      enum event_type_t event_type)
+{
+	struct perf_cpu_pmu_context *cpc;
+	int is_active = __ctx_sched_in(&cpuctx->ctx, event_type);
+
+	if (is_active < 0)
+		return;
+
+	list_for_each_entry(cpc, &cpuctx->cgrp_ctx_list, cgrp_ctx_entry) {
+		/*
+		 * First go through the list and put on any pinned groups
+		 * in order to give them the best chance of going on.
+		 */
+		if (is_active & EVENT_PINNED)
+			ctx_pinned_sched_in(&cpuctx->ctx, cpc->epc.pmu);
+
+		/* Then walk through the lower prio flexible groups */
+		if (is_active & EVENT_FLEXIBLE)
+			ctx_flexible_sched_in(&cpuctx->ctx, cpc->epc.pmu);
+	}
+}
+
 static inline bool
 perf_cgroup_match(struct perf_event *event)
 {
@@ -856,9 +918,9 @@ static void perf_cgroup_switch(struct task_struct *task)
 		return;
 
 	perf_ctx_lock(cpuctx, cpuctx->task_ctx);
-	perf_ctx_disable(&cpuctx->ctx);
+	perf_cgrp_ctx_disable(&cpuctx->ctx);
 
-	ctx_sched_out(&cpuctx->ctx, EVENT_ALL);
+	cgrp_ctx_sched_out(cpuctx, EVENT_ALL);
 	/*
 	 * must not be done before ctxswout due
 	 * to update_cgrp_time_from_cpuctx() in
@@ -870,9 +932,9 @@ static void perf_cgroup_switch(struct task_struct *task)
 	 * perf_cgroup_set_timestamp() in ctx_sched_in()
 	 * to not have to pass task around
 	 */
-	ctx_sched_in(&cpuctx->ctx, EVENT_ALL);
+	cgrp_ctx_sched_in(cpuctx, EVENT_ALL);
 
-	perf_ctx_enable(&cpuctx->ctx);
+	perf_cgrp_ctx_enable(&cpuctx->ctx);
 	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
 }
 
@@ -961,6 +1023,7 @@ static inline void
 perf_cgroup_event_enable(struct perf_event *event, struct perf_event_context *ctx)
 {
 	struct perf_cpu_context *cpuctx;
+	struct perf_cpu_pmu_context *cpc;
 
 	if (!is_cgroup_event(event))
 		return;
@@ -975,12 +1038,16 @@ perf_cgroup_event_enable(struct perf_event *event, struct perf_event_context *ct
 		return;
 
 	cpuctx->cgrp = perf_cgroup_from_task(current, ctx);
+
+	cpc = container_of(event->pmu_ctx, struct perf_cpu_pmu_context, epc);
+	list_add(&cpc->cgrp_ctx_entry, &cpuctx->cgrp_ctx_list);
 }
 
 static inline void
 perf_cgroup_event_disable(struct perf_event *event, struct perf_event_context *ctx)
 {
 	struct perf_cpu_context *cpuctx;
+	struct perf_cpu_pmu_context *cpc;
 
 	if (!is_cgroup_event(event))
 		return;
@@ -995,6 +1062,9 @@ perf_cgroup_event_disable(struct perf_event *event, struct perf_event_context *c
 		return;
 
 	cpuctx->cgrp = NULL;
+
+	cpc = container_of(event->pmu_ctx, struct perf_cpu_pmu_context, epc);
+	list_del(&cpc->cgrp_ctx_entry);
 }
 
 #else /* !CONFIG_CGROUP_PERF */
@@ -3238,11 +3308,10 @@ static void __pmu_ctx_sched_out(struct perf_event_pmu_context *pmu_ctx,
 	perf_pmu_enable(pmu);
 }
 
-static void
-ctx_sched_out(struct perf_event_context *ctx, enum event_type_t event_type)
+static int
+__ctx_sched_out(struct perf_event_context *ctx, enum event_type_t event_type)
 {
 	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
-	struct perf_event_pmu_context *pmu_ctx;
 	int is_active = ctx->is_active;
 
 	lockdep_assert_held(&ctx->lock);
@@ -3254,7 +3323,7 @@ ctx_sched_out(struct perf_event_context *ctx, enum event_type_t event_type)
 		WARN_ON_ONCE(ctx->is_active);
 		if (ctx->task)
 			WARN_ON_ONCE(cpuctx->task_ctx);
-		return;
+		return -1;
 	}
 
 	/*
@@ -3290,6 +3359,18 @@ ctx_sched_out(struct perf_event_context *ctx, enum event_type_t event_type)
 
 	is_active ^= ctx->is_active; /* changed bits */
 
+	return is_active;
+}
+
+static void
+ctx_sched_out(struct perf_event_context *ctx, enum event_type_t event_type)
+{
+	struct perf_event_pmu_context *pmu_ctx;
+	int is_active = __ctx_sched_out(ctx, event_type);
+
+	if (is_active < 0)
+		return;
+
 	list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry)
 		__pmu_ctx_sched_out(pmu_ctx, is_active);
 }
@@ -3861,8 +3942,8 @@ static void __pmu_ctx_sched_in(struct perf_event_context *ctx, struct pmu *pmu)
 	ctx_flexible_sched_in(ctx, pmu);
 }
 
-static void
-ctx_sched_in(struct perf_event_context *ctx, enum event_type_t event_type)
+static int
+__ctx_sched_in(struct perf_event_context *ctx, enum event_type_t event_type)
 {
 	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
 	int is_active = ctx->is_active;
@@ -3870,7 +3951,7 @@ ctx_sched_in(struct perf_event_context *ctx, enum event_type_t event_type)
 	lockdep_assert_held(&ctx->lock);
 
 	if (likely(!ctx->nr_events))
-		return;
+		return -1;
 
 	if (!(is_active & EVENT_TIME)) {
 		/* start ctx time */
@@ -3893,6 +3974,17 @@ ctx_sched_in(struct perf_event_context *ctx, enum event_type_t event_type)
 
 	is_active ^= ctx->is_active; /* changed bits */
 
+	return is_active;
+}
+
+static void
+ctx_sched_in(struct perf_event_context *ctx, enum event_type_t event_type)
+{
+	int is_active = __ctx_sched_in(ctx, event_type);
+
+	if (is_active < 0)
+		return;
+
 	/*
 	 * First go through the list and put on any pinned groups
 	 * in order to give them the best chance of going on.
@@ -13541,6 +13633,9 @@ static void __init perf_event_init_all_cpus(void)
 		cpuctx->online = cpumask_test_cpu(cpu, perf_online_mask);
 		cpuctx->heap_size = ARRAY_SIZE(cpuctx->heap_default);
 		cpuctx->heap = cpuctx->heap_default;
+#ifdef CONFIG_CGROUP_PERF
+		INIT_LIST_HEAD(&cpuctx->cgrp_ctx_list);
+#endif
 	}
 }
 
-- 
2.42.0.582.g8ccd20d70d-goog

