Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0C27DF677
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 16:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376825AbjKBPda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 11:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347580AbjKBPdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 11:33:10 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC63193
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 08:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=RF7AlZRmRPruwiE6WSJ8fgsVWKVvpbmYdppCd/KBEkQ=; b=pGACWceG5OkXDjHEQOIpl0EsDB
        tdjDIEfJtqREzGV8uDOeMJF18ilnbvzS9vXNGXp1RVpudhQJEaA9CWjnf1iANtvN6zRhN7FsNbQuU
        h92x20a4sQCzDow+aPWeGaEVyzSq2ChWnfXXR/tAAqA51m2sWyUQmkK1rMG+eri8nCFFtZnhNPpTf
        BHNoS/CNPiZ8w+FwstiR6H7zmovfOW9/xu/JKVgsqLgCup6OepD7DwHa3Kcdm0v2t51QoiKYE9BLa
        liKTm3md9tx3aojk9Ltl9+tIb+l4CgUo1Uigz+iMozgbC8rmymUEVYAlt7vXn8SVpEt2DL6uStp0n
        fpKbkelw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qyZgW-006gQN-0R;
        Thu, 02 Nov 2023 15:32:41 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
        id 58794302202; Thu,  2 Nov 2023 16:32:39 +0100 (CET)
Message-Id: <20231102152018.626814126@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 02 Nov 2023 16:09:27 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com
Subject: [PATCH 08/13] perf: Simplify: *perf_event_{dis,en}able*()
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
 kernel/events/core.c |   51 ++++++++++++++++++++++-----------------------------
 1 file changed, 22 insertions(+), 29 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2415,7 +2415,7 @@ static void __perf_event_disable(struct
 		update_cgrp_time_from_event(event);
 	}
 
-	perf_pmu_disable(event->pmu_ctx->pmu);
+	guard(perf_pmu_disable)(event->pmu_ctx->pmu);
 
 	if (event == event->group_leader)
 		group_sched_out(event, ctx);
@@ -2424,8 +2424,6 @@ static void __perf_event_disable(struct
 
 	perf_event_set_state(event, PERF_EVENT_STATE_OFF);
 	perf_cgroup_event_disable(event, ctx);
-
-	perf_pmu_enable(event->pmu_ctx->pmu);
 }
 
 /*
@@ -2446,12 +2444,10 @@ static void _perf_event_disable(struct p
 {
 	struct perf_event_context *ctx = event->ctx;
 
-	raw_spin_lock_irq(&ctx->lock);
-	if (event->state <= PERF_EVENT_STATE_OFF) {
-		raw_spin_unlock_irq(&ctx->lock);
-		return;
+	scoped_guard (raw_spinlock_irq, &ctx->lock) {
+		if (event->state <= PERF_EVENT_STATE_OFF)
+			return;
 	}
-	raw_spin_unlock_irq(&ctx->lock);
 
 	event_function_call(event, __perf_event_disable, NULL);
 }
@@ -2955,32 +2951,29 @@ static void _perf_event_enable(struct pe
 {
 	struct perf_event_context *ctx = event->ctx;
 
-	raw_spin_lock_irq(&ctx->lock);
-	if (event->state >= PERF_EVENT_STATE_INACTIVE ||
-	    event->state <  PERF_EVENT_STATE_ERROR) {
-out:
-		raw_spin_unlock_irq(&ctx->lock);
-		return;
-	}
+	scoped_guard (raw_spinlock_irq, &ctx->lock) {
+		if (event->state >= PERF_EVENT_STATE_INACTIVE ||
+		    event->state <  PERF_EVENT_STATE_ERROR)
+			return;
 
-	/*
-	 * If the event is in error state, clear that first.
-	 *
-	 * That way, if we see the event in error state below, we know that it
-	 * has gone back into error state, as distinct from the task having
-	 * been scheduled away before the cross-call arrived.
-	 */
-	if (event->state == PERF_EVENT_STATE_ERROR) {
 		/*
-		 * Detached SIBLING events cannot leave ERROR state.
+		 * If the event is in error state, clear that first.
+		 *
+		 * That way, if we see the event in error state below, we know that it
+		 * has gone back into error state, as distinct from the task having
+		 * been scheduled away before the cross-call arrived.
 		 */
-		if (event->event_caps & PERF_EV_CAP_SIBLING &&
-		    event->group_leader == event)
-			goto out;
+		if (event->state == PERF_EVENT_STATE_ERROR) {
+			/*
+			 * Detached SIBLING events cannot leave ERROR state.
+			 */
+			if (event->event_caps & PERF_EV_CAP_SIBLING &&
+			    event->group_leader == event)
+				return;
 
-		event->state = PERF_EVENT_STATE_OFF;
+			event->state = PERF_EVENT_STATE_OFF;
+		}
 	}
-	raw_spin_unlock_irq(&ctx->lock);
 
 	event_function_call(event, __perf_event_enable, NULL);
 }


