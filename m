Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD8A7DF681
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 16:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347598AbjKBPdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 11:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347590AbjKBPdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 11:33:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A431B188
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 08:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=0Nln3H/TQf9zjJAhRuDD5Vdsf6AHs8EETAgdoNVjkyE=; b=nsGBHSM3VplY00jpcPdnfQpcXu
        7BEkJV8Ta5CZ9VtP1cTK/WwyhPanO1wXOsnQeSEqzyYpl/4xzzhKBKjJ6qHyR0UJT6L2Ml3+iUqI5
        gk0RWwVad3PdTiW/XS9sQRzv67oxgLKdtTahHUAHCr0viDrlFgW/IJj+KsviSOmy6wzKDnEJme1IY
        ywUiHOVSNCDprk/PRAF4UgDv/3A2KutyC2/irWcU5IIMlZFHShESgUa8woK1WyudM81MsUgLSNa99
        jeubDbscY0gEu8eACCiABP7yarKTWRJ80x9M60LW9BIejCjboPF0TMBqMeq3t5Wy4tYMjuELTaXAm
        RRee22qw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qyZgV-0005PT-VU; Thu, 02 Nov 2023 15:32:40 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
        id 68CF1302EB9; Thu,  2 Nov 2023 16:32:39 +0100 (CET)
Message-Id: <20231102152019.099969167@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 02 Nov 2023 16:09:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com
Subject: [PATCH 12/13] perf: Simplify perf_event_*_on_exec()
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
 kernel/events/core.c |   88 +++++++++++++++++++++++----------------------------
 1 file changed, 40 insertions(+), 48 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4318,39 +4318,36 @@ static void perf_event_enable_on_exec(st
 	enum event_type_t event_type = 0;
 	struct perf_cpu_context *cpuctx;
 	struct perf_event *event;
-	unsigned long flags;
 	int enabled = 0;
 
-	local_irq_save(flags);
-	if (WARN_ON_ONCE(current->perf_event_ctxp != ctx))
-		goto out;
-
-	if (!ctx->nr_events)
-		goto out;
-
-	cpuctx = this_cpu_ptr(&perf_cpu_context);
-	perf_ctx_lock(cpuctx, ctx);
-	ctx_sched_out(ctx, EVENT_TIME);
-
-	list_for_each_entry(event, &ctx->event_list, event_entry) {
-		enabled |= event_enable_on_exec(event, ctx);
-		event_type |= get_event_type(event);
+	scoped_guard (irqsave) {
+		if (WARN_ON_ONCE(current->perf_event_ctxp != ctx))
+			return;
+
+		if (!ctx->nr_events)
+			return;
+
+		cpuctx = this_cpu_ptr(&perf_cpu_context);
+		guard(perf_ctx_lock)(cpuctx, ctx);
+
+		ctx_sched_out(ctx, EVENT_TIME);
+
+		list_for_each_entry(event, &ctx->event_list, event_entry) {
+			enabled |= event_enable_on_exec(event, ctx);
+			event_type |= get_event_type(event);
+		}
+
+		/*
+		 * Unclone and reschedule this context if we enabled any event.
+		 */
+		if (enabled) {
+			clone_ctx = unclone_ctx(ctx);
+			ctx_resched(cpuctx, ctx, event_type);
+		} else {
+			ctx_sched_in(ctx, EVENT_TIME);
+		}
 	}
 
-	/*
-	 * Unclone and reschedule this context if we enabled any event.
-	 */
-	if (enabled) {
-		clone_ctx = unclone_ctx(ctx);
-		ctx_resched(cpuctx, ctx, event_type);
-	} else {
-		ctx_sched_in(ctx, EVENT_TIME);
-	}
-	perf_ctx_unlock(cpuctx, ctx);
-
-out:
-	local_irq_restore(flags);
-
 	if (clone_ctx)
 		put_ctx(clone_ctx);
 }
@@ -4367,34 +4364,29 @@ static void perf_event_remove_on_exec(st
 {
 	struct perf_event_context *clone_ctx = NULL;
 	struct perf_event *event, *next;
-	unsigned long flags;
 	bool modified = false;
 
-	mutex_lock(&ctx->mutex);
+	scoped_guard (mutex, &ctx->mutex) {
+		if (WARN_ON_ONCE(ctx->task != current))
+			return;
 
-	if (WARN_ON_ONCE(ctx->task != current))
-		goto unlock;
+		list_for_each_entry_safe(event, next, &ctx->event_list, event_entry) {
+			if (!event->attr.remove_on_exec)
+				continue;
 
-	list_for_each_entry_safe(event, next, &ctx->event_list, event_entry) {
-		if (!event->attr.remove_on_exec)
-			continue;
+			if (!is_kernel_event(event))
+				perf_remove_from_owner(event);
 
-		if (!is_kernel_event(event))
-			perf_remove_from_owner(event);
+			modified = true;
 
-		modified = true;
+			perf_event_exit_event(event, ctx);
+		}
 
-		perf_event_exit_event(event, ctx);
+		guard(raw_spinlock_irqsave)(&ctx->lock);
+		if (modified)
+			clone_ctx = unclone_ctx(ctx);
 	}
 
-	raw_spin_lock_irqsave(&ctx->lock, flags);
-	if (modified)
-		clone_ctx = unclone_ctx(ctx);
-	raw_spin_unlock_irqrestore(&ctx->lock, flags);
-
-unlock:
-	mutex_unlock(&ctx->mutex);
-
 	if (clone_ctx)
 		put_ctx(clone_ctx);
 }


