Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927B57DF67A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 16:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376840AbjKBPde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 11:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347645AbjKBPdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 11:33:11 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67C118B
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 08:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=Flz3lC+6VWh6RSfoR6MvKdhu9gsbmcKYNkChdKqx6SM=; b=BVE+b0jo+rlvT0zgww+y/0ZSgf
        uqgnmATxegsfIBHQuwLr6nnQVYZ9MPKO+0t5Bct+irYnS8WXY7qExCLBuabnWgL+LaGCQtDERBvrN
        zhrdJjf+Ecya4i6fjTQP+6i5mgzgSgAt/y+WgMig5SqYPQlBRnQGCIVJkcO5QrSCP3Vgx2wVMXtdJ
        +aH8yDUdaHZ8vWtymQgf20RM1TKdrStSjsG68uCZAMgBH/2go6qq8x6YDWwKbGfPMAIMRVbe8KsIJ
        ayi4+yVviScp8ZzPTkcAqgzhGLZZnlmf/VicigTl2ji5mXJMfIcyWp3MIAvrE1L0ZGttHHs5L6Tcr
        ZmzBrzdQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qyZgW-006gQQ-2D;
        Thu, 02 Nov 2023 15:32:41 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
        id 6D39430311A; Thu,  2 Nov 2023 16:32:39 +0100 (CET)
Message-Id: <20231102152019.211374348@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 02 Nov 2023 16:09:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com
Subject: [PATCH 13/13] perf: Simplify *perf_event_read*()
References: <20231102150919.719936610@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c |   54 ++++++++++++++++-----------------------------------
 1 file changed, 17 insertions(+), 37 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4434,7 +4434,8 @@ static void __perf_event_read(void *info
 	if (ctx->task && cpuctx->task_ctx != ctx)
 		return;
 
-	raw_spin_lock(&ctx->lock);
+	guard(raw_spinlock)(&ctx->lock);
+
 	if (ctx->is_active & EVENT_TIME) {
 		update_context_time(ctx);
 		update_cgrp_time_from_event(event);
@@ -4445,12 +4446,12 @@ static void __perf_event_read(void *info
 		perf_event_update_sibling_time(event);
 
 	if (event->state != PERF_EVENT_STATE_ACTIVE)
-		goto unlock;
+		return;
 
 	if (!data->group) {
 		pmu->read(event);
 		data->ret = 0;
-		goto unlock;
+		return;
 	}
 
 	pmu->start_txn(pmu, PERF_PMU_TXN_READ);
@@ -4468,9 +4469,6 @@ static void __perf_event_read(void *info
 	}
 
 	data->ret = pmu->commit_txn(pmu);
-
-unlock:
-	raw_spin_unlock(&ctx->lock);
 }
 
 static inline u64 perf_event_count(struct perf_event *event)
@@ -4501,32 +4499,25 @@ static void calc_timer_values(struct per
 int perf_event_read_local(struct perf_event *event, u64 *value,
 			  u64 *enabled, u64 *running)
 {
-	unsigned long flags;
 	int event_oncpu;
 	int event_cpu;
-	int ret = 0;
-
 	/*
 	 * Disabling interrupts avoids all counter scheduling (context
 	 * switches, timer based rotation and IPIs).
 	 */
-	local_irq_save(flags);
+	guard(irqsave)();
 
 	/*
 	 * It must not be an event with inherit set, we cannot read
 	 * all child counters from atomic context.
 	 */
-	if (event->attr.inherit) {
-		ret = -EOPNOTSUPP;
-		goto out;
-	}
+	if (event->attr.inherit)
+		return -EOPNOTSUPP;
 
 	/* If this is a per-task event, it must be for current */
 	if ((event->attach_state & PERF_ATTACH_TASK) &&
-	    event->hw.target != current) {
-		ret = -EINVAL;
-		goto out;
-	}
+	    event->hw.target != current)
+		return -EINVAL;
 
 	/*
 	 * Get the event CPU numbers, and adjust them to local if the event is
@@ -4537,16 +4528,12 @@ int perf_event_read_local(struct perf_ev
 
 	/* If this is a per-CPU event, it must be for this CPU */
 	if (!(event->attach_state & PERF_ATTACH_TASK) &&
-	    event_cpu != smp_processor_id()) {
-		ret = -EINVAL;
-		goto out;
-	}
+	    event_cpu != smp_processor_id())
+		return -EINVAL;
 
 	/* If this is a pinned event it must be running on this CPU */
-	if (event->attr.pinned && event_oncpu != smp_processor_id()) {
-		ret = -EBUSY;
-		goto out;
-	}
+	if (event->attr.pinned && event_oncpu != smp_processor_id())
+		return -EBUSY;
 
 	/*
 	 * If the event is currently on this CPU, its either a per-task event,
@@ -4566,10 +4553,8 @@ int perf_event_read_local(struct perf_ev
 		if (running)
 			*running = __running;
 	}
-out:
-	local_irq_restore(flags);
 
-	return ret;
+	return 0;
 }
 
 static int perf_event_read(struct perf_event *event, bool group)
@@ -4603,7 +4588,7 @@ static int perf_event_read(struct perf_e
 			.ret = 0,
 		};
 
-		preempt_disable();
+		guard(preempt)();
 		event_cpu = __perf_event_read_cpu(event, event_cpu);
 
 		/*
@@ -4617,19 +4602,15 @@ static int perf_event_read(struct perf_e
 		 * after this.
 		 */
 		(void)smp_call_function_single(event_cpu, __perf_event_read, &data, 1);
-		preempt_enable();
 		ret = data.ret;
 
 	} else if (state == PERF_EVENT_STATE_INACTIVE) {
 		struct perf_event_context *ctx = event->ctx;
-		unsigned long flags;
 
-		raw_spin_lock_irqsave(&ctx->lock, flags);
+		guard(raw_spinlock_irqsave)(&ctx->lock);
 		state = event->state;
-		if (state != PERF_EVENT_STATE_INACTIVE) {
-			raw_spin_unlock_irqrestore(&ctx->lock, flags);
+		if (state != PERF_EVENT_STATE_INACTIVE)
 			goto again;
-		}
 
 		/*
 		 * May read while context is not active (e.g., thread is
@@ -4643,7 +4624,6 @@ static int perf_event_read(struct perf_e
 		perf_event_update_time(event);
 		if (group)
 			perf_event_update_sibling_time(event);
-		raw_spin_unlock_irqrestore(&ctx->lock, flags);
 	}
 
 	return ret;


