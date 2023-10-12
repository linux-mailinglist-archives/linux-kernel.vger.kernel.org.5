Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF01C7C74EA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 19:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344065AbjJLRhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 13:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347448AbjJLRhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 13:37:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69766EA;
        Thu, 12 Oct 2023 10:34:37 -0700 (PDT)
Date:   Thu, 12 Oct 2023 17:34:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697132075;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yvwOrUFWrpu9Nc3ylQ7uW/c3OdgBaPqsHxReckC4MJU=;
        b=dppdalZeKL4r9LTF75yvb9l0BbN5GAeUD/CVtO9GZ1W1W/Pb63QNlbjyf8Crc8T+1Reug7
        h4j3VDvq+IymV0WCFWF1MmXgagagUYF+WxWGAs+T2pD8KAcfywKCSQyuU7SANUrg5yJ4sW
        jxAo5lvF6mUSfpfa1diArHmhq4BNAcpDyDgxEN7T6vQPUveHi/vstRox93PMbLOGI393y5
        owI+eAsW17OpvtLs0u/i2iwlQAIu2awoZlqjQWrTCKz+IYFtB0NDLSV2PZVeVO04pW6WWu
        HUPZSZ0RGT8mT8zgQLx7+ejx2gJeslMazcnYAxuhoBW7L+fwVJjL6Sak0CIPqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697132075;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yvwOrUFWrpu9Nc3ylQ7uW/c3OdgBaPqsHxReckC4MJU=;
        b=3bp2R36+JyL8QSRtZ9YLfVPCLpjINNDuTms8Wf2wzXmmkVhIIhkZ09LO8fBJ1bqp8ZV2/P
        ZlXqHdaDHoRSMNCA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Optimize perf_cgroup_switch()
Cc:     Namhyung Kim <namhyung@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231009210425.GC6307@noisy.programming.kicks-ass.net>
References: <20231009210425.GC6307@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <169713207414.3135.17659480704085791106.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     f06cc667f79909e9175460b167c277b7c64d3df0
Gitweb:        https://git.kernel.org/tip/f06cc667f79909e9175460b167c277b7c64d3df0
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 09 Oct 2023 23:04:25 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 12 Oct 2023 19:28:38 +02:00

perf: Optimize perf_cgroup_switch()

Namhyung reported that bd2756811766 ("perf: Rewrite core context handling")
regresses context switch overhead when perf-cgroup is in use together
with 'slow' PMUs like uncore.

Specifically, perf_cgroup_switch()'s perf_ctx_disable() /
ctx_sched_out() etc.. all iterate the full list of active PMUs for
that CPU, even if they don't have cgroup events.

Previously there was cgrp_cpuctx_list which linked the relevant PMUs
together, but that got lost in the rework. Instead of re-instruducing
a similar list, let the perf_event_pmu_context iteration skip those
that do not have cgroup events. This avoids growing multiple versions
of the perf_event_pmu_context iteration.

Measured performance (on a slightly different patch):

Before)

  $ taskset -c 0 ./perf bench sched pipe -l 10000 -G AAA,BBB
  # Running 'sched/pipe' benchmark:
  # Executed 10000 pipe operations between two processes

       Total time: 0.901 [sec]

        90.128700 usecs/op
            11095 ops/sec

After)

  $ taskset -c 0 ./perf bench sched pipe -l 10000 -G AAA,BBB
  # Running 'sched/pipe' benchmark:
  # Executed 10000 pipe operations between two processes

       Total time: 0.065 [sec]

         6.560100 usecs/op
           152436 ops/sec

Fixes: bd2756811766 ("perf: Rewrite core context handling")
Reported-by: Namhyung Kim <namhyung@kernel.org>
Debugged-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20231009210425.GC6307@noisy.programming.kicks-ass.net
---
 include/linux/perf_event.h |   1 +-
 kernel/events/core.c       | 115 ++++++++++++++++++------------------
 2 files changed, 61 insertions(+), 55 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index f31f962..0367d74 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -878,6 +878,7 @@ struct perf_event_pmu_context {
 	unsigned int			embedded : 1;
 
 	unsigned int			nr_events;
+	unsigned int			nr_cgroups;
 
 	atomic_t			refcount; /* event <-> epc */
 	struct rcu_head			rcu_head;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 708d474..3eb26c2 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -375,6 +375,7 @@ enum event_type_t {
 	EVENT_TIME = 0x4,
 	/* see ctx_resched() for details */
 	EVENT_CPU = 0x8,
+	EVENT_CGROUP = 0x10,
 	EVENT_ALL = EVENT_FLEXIBLE | EVENT_PINNED,
 };
 
@@ -684,20 +685,26 @@ do {									\
 	___p;								\
 })
 
-static void perf_ctx_disable(struct perf_event_context *ctx)
+static void perf_ctx_disable(struct perf_event_context *ctx, bool cgroup)
 {
 	struct perf_event_pmu_context *pmu_ctx;
 
-	list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry)
+	list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry) {
+		if (cgroup && !pmu_ctx->nr_cgroups)
+			continue;
 		perf_pmu_disable(pmu_ctx->pmu);
+	}
 }
 
-static void perf_ctx_enable(struct perf_event_context *ctx)
+static void perf_ctx_enable(struct perf_event_context *ctx, bool cgroup)
 {
 	struct perf_event_pmu_context *pmu_ctx;
 
-	list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry)
+	list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry) {
+		if (cgroup && !pmu_ctx->nr_cgroups)
+			continue;
 		perf_pmu_enable(pmu_ctx->pmu);
+	}
 }
 
 static void ctx_sched_out(struct perf_event_context *ctx, enum event_type_t event_type);
@@ -856,9 +863,9 @@ static void perf_cgroup_switch(struct task_struct *task)
 		return;
 
 	perf_ctx_lock(cpuctx, cpuctx->task_ctx);
-	perf_ctx_disable(&cpuctx->ctx);
+	perf_ctx_disable(&cpuctx->ctx, true);
 
-	ctx_sched_out(&cpuctx->ctx, EVENT_ALL);
+	ctx_sched_out(&cpuctx->ctx, EVENT_ALL|EVENT_CGROUP);
 	/*
 	 * must not be done before ctxswout due
 	 * to update_cgrp_time_from_cpuctx() in
@@ -870,9 +877,9 @@ static void perf_cgroup_switch(struct task_struct *task)
 	 * perf_cgroup_set_timestamp() in ctx_sched_in()
 	 * to not have to pass task around
 	 */
-	ctx_sched_in(&cpuctx->ctx, EVENT_ALL);
+	ctx_sched_in(&cpuctx->ctx, EVENT_ALL|EVENT_CGROUP);
 
-	perf_ctx_enable(&cpuctx->ctx);
+	perf_ctx_enable(&cpuctx->ctx, true);
 	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
 }
 
@@ -965,6 +972,8 @@ perf_cgroup_event_enable(struct perf_event *event, struct perf_event_context *ct
 	if (!is_cgroup_event(event))
 		return;
 
+	event->pmu_ctx->nr_cgroups++;
+
 	/*
 	 * Because cgroup events are always per-cpu events,
 	 * @ctx == &cpuctx->ctx.
@@ -985,6 +994,8 @@ perf_cgroup_event_disable(struct perf_event *event, struct perf_event_context *c
 	if (!is_cgroup_event(event))
 		return;
 
+	event->pmu_ctx->nr_cgroups--;
+
 	/*
 	 * Because cgroup events are always per-cpu events,
 	 * @ctx == &cpuctx->ctx.
@@ -2677,9 +2688,9 @@ static void ctx_resched(struct perf_cpu_context *cpuctx,
 
 	event_type &= EVENT_ALL;
 
-	perf_ctx_disable(&cpuctx->ctx);
+	perf_ctx_disable(&cpuctx->ctx, false);
 	if (task_ctx) {
-		perf_ctx_disable(task_ctx);
+		perf_ctx_disable(task_ctx, false);
 		task_ctx_sched_out(task_ctx, event_type);
 	}
 
@@ -2697,9 +2708,9 @@ static void ctx_resched(struct perf_cpu_context *cpuctx,
 
 	perf_event_sched_in(cpuctx, task_ctx);
 
-	perf_ctx_enable(&cpuctx->ctx);
+	perf_ctx_enable(&cpuctx->ctx, false);
 	if (task_ctx)
-		perf_ctx_enable(task_ctx);
+		perf_ctx_enable(task_ctx, false);
 }
 
 void perf_pmu_resched(struct pmu *pmu)
@@ -3244,6 +3255,9 @@ ctx_sched_out(struct perf_event_context *ctx, enum event_type_t event_type)
 	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
 	struct perf_event_pmu_context *pmu_ctx;
 	int is_active = ctx->is_active;
+	bool cgroup = event_type & EVENT_CGROUP;
+
+	event_type &= ~EVENT_CGROUP;
 
 	lockdep_assert_held(&ctx->lock);
 
@@ -3290,8 +3304,11 @@ ctx_sched_out(struct perf_event_context *ctx, enum event_type_t event_type)
 
 	is_active ^= ctx->is_active; /* changed bits */
 
-	list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry)
+	list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry) {
+		if (cgroup && !pmu_ctx->nr_cgroups)
+			continue;
 		__pmu_ctx_sched_out(pmu_ctx, is_active);
+	}
 }
 
 /*
@@ -3482,7 +3499,7 @@ perf_event_context_sched_out(struct task_struct *task, struct task_struct *next)
 		raw_spin_lock_nested(&next_ctx->lock, SINGLE_DEPTH_NESTING);
 		if (context_equiv(ctx, next_ctx)) {
 
-			perf_ctx_disable(ctx);
+			perf_ctx_disable(ctx, false);
 
 			/* PMIs are disabled; ctx->nr_pending is stable. */
 			if (local_read(&ctx->nr_pending) ||
@@ -3502,7 +3519,7 @@ perf_event_context_sched_out(struct task_struct *task, struct task_struct *next)
 			perf_ctx_sched_task_cb(ctx, false);
 			perf_event_swap_task_ctx_data(ctx, next_ctx);
 
-			perf_ctx_enable(ctx);
+			perf_ctx_enable(ctx, false);
 
 			/*
 			 * RCU_INIT_POINTER here is safe because we've not
@@ -3526,13 +3543,13 @@ unlock:
 
 	if (do_switch) {
 		raw_spin_lock(&ctx->lock);
-		perf_ctx_disable(ctx);
+		perf_ctx_disable(ctx, false);
 
 inside_switch:
 		perf_ctx_sched_task_cb(ctx, false);
 		task_ctx_sched_out(ctx, EVENT_ALL);
 
-		perf_ctx_enable(ctx);
+		perf_ctx_enable(ctx, false);
 		raw_spin_unlock(&ctx->lock);
 	}
 }
@@ -3818,47 +3835,32 @@ static int merge_sched_in(struct perf_event *event, void *data)
 	return 0;
 }
 
-static void ctx_pinned_sched_in(struct perf_event_context *ctx, struct pmu *pmu)
+static void pmu_groups_sched_in(struct perf_event_context *ctx,
+				struct perf_event_groups *groups,
+				struct pmu *pmu)
 {
-	struct perf_event_pmu_context *pmu_ctx;
 	int can_add_hw = 1;
-
-	if (pmu) {
-		visit_groups_merge(ctx, &ctx->pinned_groups,
-				   smp_processor_id(), pmu,
-				   merge_sched_in, &can_add_hw);
-	} else {
-		list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry) {
-			can_add_hw = 1;
-			visit_groups_merge(ctx, &ctx->pinned_groups,
-					   smp_processor_id(), pmu_ctx->pmu,
-					   merge_sched_in, &can_add_hw);
-		}
-	}
+	visit_groups_merge(ctx, groups, smp_processor_id(), pmu,
+			   merge_sched_in, &can_add_hw);
 }
 
-static void ctx_flexible_sched_in(struct perf_event_context *ctx, struct pmu *pmu)
+static void ctx_groups_sched_in(struct perf_event_context *ctx,
+				struct perf_event_groups *groups,
+				bool cgroup)
 {
 	struct perf_event_pmu_context *pmu_ctx;
-	int can_add_hw = 1;
 
-	if (pmu) {
-		visit_groups_merge(ctx, &ctx->flexible_groups,
-				   smp_processor_id(), pmu,
-				   merge_sched_in, &can_add_hw);
-	} else {
-		list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry) {
-			can_add_hw = 1;
-			visit_groups_merge(ctx, &ctx->flexible_groups,
-					   smp_processor_id(), pmu_ctx->pmu,
-					   merge_sched_in, &can_add_hw);
-		}
+	list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry) {
+		if (cgroup && !pmu_ctx->nr_cgroups)
+			continue;
+		pmu_groups_sched_in(ctx, groups, pmu_ctx->pmu);
 	}
 }
 
-static void __pmu_ctx_sched_in(struct perf_event_context *ctx, struct pmu *pmu)
+static void __pmu_ctx_sched_in(struct perf_event_context *ctx,
+			       struct pmu *pmu)
 {
-	ctx_flexible_sched_in(ctx, pmu);
+	pmu_groups_sched_in(ctx, &ctx->flexible_groups, pmu);
 }
 
 static void
@@ -3866,6 +3868,9 @@ ctx_sched_in(struct perf_event_context *ctx, enum event_type_t event_type)
 {
 	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
 	int is_active = ctx->is_active;
+	bool cgroup = event_type & EVENT_CGROUP;
+
+	event_type &= ~EVENT_CGROUP;
 
 	lockdep_assert_held(&ctx->lock);
 
@@ -3898,11 +3903,11 @@ ctx_sched_in(struct perf_event_context *ctx, enum event_type_t event_type)
 	 * in order to give them the best chance of going on.
 	 */
 	if (is_active & EVENT_PINNED)
-		ctx_pinned_sched_in(ctx, NULL);
+		ctx_groups_sched_in(ctx, &ctx->pinned_groups, cgroup);
 
 	/* Then walk through the lower prio flexible groups */
 	if (is_active & EVENT_FLEXIBLE)
-		ctx_flexible_sched_in(ctx, NULL);
+		ctx_groups_sched_in(ctx, &ctx->flexible_groups, cgroup);
 }
 
 static void perf_event_context_sched_in(struct task_struct *task)
@@ -3917,11 +3922,11 @@ static void perf_event_context_sched_in(struct task_struct *task)
 
 	if (cpuctx->task_ctx == ctx) {
 		perf_ctx_lock(cpuctx, ctx);
-		perf_ctx_disable(ctx);
+		perf_ctx_disable(ctx, false);
 
 		perf_ctx_sched_task_cb(ctx, true);
 
-		perf_ctx_enable(ctx);
+		perf_ctx_enable(ctx, false);
 		perf_ctx_unlock(cpuctx, ctx);
 		goto rcu_unlock;
 	}
@@ -3934,7 +3939,7 @@ static void perf_event_context_sched_in(struct task_struct *task)
 	if (!ctx->nr_events)
 		goto unlock;
 
-	perf_ctx_disable(ctx);
+	perf_ctx_disable(ctx, false);
 	/*
 	 * We want to keep the following priority order:
 	 * cpu pinned (that don't need to move), task pinned,
@@ -3944,7 +3949,7 @@ static void perf_event_context_sched_in(struct task_struct *task)
 	 * events, no need to flip the cpuctx's events around.
 	 */
 	if (!RB_EMPTY_ROOT(&ctx->pinned_groups.tree)) {
-		perf_ctx_disable(&cpuctx->ctx);
+		perf_ctx_disable(&cpuctx->ctx, false);
 		ctx_sched_out(&cpuctx->ctx, EVENT_FLEXIBLE);
 	}
 
@@ -3953,9 +3958,9 @@ static void perf_event_context_sched_in(struct task_struct *task)
 	perf_ctx_sched_task_cb(cpuctx->task_ctx, true);
 
 	if (!RB_EMPTY_ROOT(&ctx->pinned_groups.tree))
-		perf_ctx_enable(&cpuctx->ctx);
+		perf_ctx_enable(&cpuctx->ctx, false);
 
-	perf_ctx_enable(ctx);
+	perf_ctx_enable(ctx, false);
 
 unlock:
 	perf_ctx_unlock(cpuctx, ctx);
