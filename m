Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA307DF670
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 16:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347539AbjKBPdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 11:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234194AbjKBPc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 11:32:59 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E9313E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 08:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=PDycx4fpiS6PTok+N6ddTvPXW/vNvT8Lmj3Yl8Tx4xE=; b=H7HBpu3sR+BkCk0NREtlw1ja8/
        A4hW1cSlDpmlE4lz1CP8KaZ53xnBIgZrCfN9oF42tzkgLbjd3eeU+NbY6VjK3H+4ZqUCvk5dFEkHR
        env3dsiYcwxY+yYoDW+gCRKe3f3ZstEqUjq0hPAc9lkfdnlprOeE8WvbIICxzAZHIgAFaayYPrsY5
        2ARgzP/mQrlDPq3E5k5R3va8nhxjkFLs8j9OIWAnSyULaFxPdEh1yX2M8P0Q0QkBX1yQEbCz6HT3j
        n2xykC6quW6iGR3LHsDsdri9fYklgyI4yOTrMqnEDgB7UWumS4IL/fiJ+yHC0bSOfW24XHBNamoay
        s83lQYiA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qyZgW-006gQP-26;
        Thu, 02 Nov 2023 15:32:41 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
        id 63E9A302EAB; Thu,  2 Nov 2023 16:32:39 +0100 (CET)
Message-Id: <20231102152018.986157891@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 02 Nov 2023 16:09:30 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com
Subject: [PATCH 11/13] perf: Simplify perf_adjust_freq_unthr_context()
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
 kernel/events/core.c |   51 +++++++++++++++++++++++----------------------------
 1 file changed, 23 insertions(+), 28 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4090,7 +4090,7 @@ perf_adjust_freq_unthr_context(struct pe
 	if (!(ctx->nr_freq || unthrottle))
 		return;
 
-	raw_spin_lock(&ctx->lock);
+	guard(raw_spinlock)(&ctx->lock);
 
 	list_for_each_entry_rcu(event, &ctx->event_list, event_entry) {
 		if (event->state != PERF_EVENT_STATE_ACTIVE)
@@ -4100,7 +4100,7 @@ perf_adjust_freq_unthr_context(struct pe
 		if (!event_filter_match(event))
 			continue;
 
-		perf_pmu_disable(event->pmu);
+		guard(perf_pmu_disable)(event->pmu);
 
 		hwc = &event->hw;
 
@@ -4110,34 +4110,29 @@ perf_adjust_freq_unthr_context(struct pe
 			event->pmu->start(event, 0);
 		}
 
-		if (!event->attr.freq || !event->attr.sample_freq)
-			goto next;
+		if (event->attr.freq && event->attr.sample_freq) {
+			/*
+			 * stop the event and update event->count
+			 */
+			event->pmu->stop(event, PERF_EF_UPDATE);
+
+			now = local64_read(&event->count);
+			delta = now - hwc->freq_count_stamp;
+			hwc->freq_count_stamp = now;
+
+			/*
+			 * restart the event
+			 * reload only if value has changed
+			 * we have stopped the event so tell that
+			 * to perf_adjust_period() to avoid stopping it
+			 * twice.
+			 */
+			if (delta > 0)
+				perf_adjust_period(event, period, delta, false);
 
-		/*
-		 * stop the event and update event->count
-		 */
-		event->pmu->stop(event, PERF_EF_UPDATE);
-
-		now = local64_read(&event->count);
-		delta = now - hwc->freq_count_stamp;
-		hwc->freq_count_stamp = now;
-
-		/*
-		 * restart the event
-		 * reload only if value has changed
-		 * we have stopped the event so tell that
-		 * to perf_adjust_period() to avoid stopping it
-		 * twice.
-		 */
-		if (delta > 0)
-			perf_adjust_period(event, period, delta, false);
-
-		event->pmu->start(event, delta > 0 ? PERF_EF_RELOAD : 0);
-	next:
-		perf_pmu_enable(event->pmu);
+			event->pmu->start(event, delta > 0 ? PERF_EF_RELOAD : 0);
+		}
 	}
-
-	raw_spin_unlock(&ctx->lock);
 }
 
 /*


