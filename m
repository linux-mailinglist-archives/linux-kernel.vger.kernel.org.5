Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E2D7DF671
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 16:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345447AbjKBPdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 11:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjKBPc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 11:32:59 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B88138
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 08:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=TIflEc6HK/22xB9+LAc8fdYfMJHSxjY/dB735CDFq7w=; b=P6kB5/pEItGyT9udySZwn5g3Qv
        DokDZMGlAiB4g+5YMtKB0RmZbfY/pSLOWVbj5SPF6cIDKqKZn1inehV8/qd0OzY/wn9JdZcifSQj8
        3dH2nA6JS9foEyCWzBfy2FYGKj4LmT0pao4ngY0As0C25SUXZ540eeGac7JIDrYE/ebOo/ehFs1XS
        uEVmLDDifA+yYjw0mpY8V81H06JBxnpUcCgwR66s2d9LTWqPI5szoghluskYsv0VEb+nsMdEQYP/6
        iTI4qNM/z+xa/z7t/+iAAIFUnvAPSqkLVuq9byN3ej3VbidX8FqhNvqpNRFC/A+oIEiju20IssCS+
        VKZ9UYPA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qyZgW-006gQO-0R;
        Thu, 02 Nov 2023 15:32:41 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
        id 505FE302187; Thu,  2 Nov 2023 16:32:39 +0100 (CET)
Message-Id: <20231102152018.391356347@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 02 Nov 2023 16:09:25 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com
Subject: [PATCH 06/13] perf; Simplify event_sched_in()
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

Use guards to reduce gotos and simplify control flow.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c |   13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1153,6 +1153,8 @@ void perf_pmu_enable(struct pmu *pmu)
 		pmu->pmu_enable(pmu);
 }
 
+DEFINE_GUARD(perf_pmu_disable, struct pmu *, perf_pmu_disable(_T), perf_pmu_enable(_T))
+
 static void perf_assert_pmu_disabled(struct pmu *pmu)
 {
 	WARN_ON_ONCE(*this_cpu_ptr(pmu->pmu_disable_count) == 0);
@@ -2489,7 +2491,6 @@ event_sched_in(struct perf_event *event,
 {
 	struct perf_event_pmu_context *epc = event->pmu_ctx;
 	struct perf_cpu_pmu_context *cpc = this_cpu_ptr(epc->pmu->cpu_pmu_context);
-	int ret = 0;
 
 	WARN_ON_ONCE(event->ctx != ctx);
 
@@ -2517,15 +2518,14 @@ event_sched_in(struct perf_event *event,
 		event->hw.interrupts = 0;
 	}
 
-	perf_pmu_disable(event->pmu);
+	guard(perf_pmu_disable)(event->pmu);
 
 	perf_log_itrace_start(event);
 
 	if (event->pmu->add(event, PERF_EF_START)) {
 		perf_event_set_state(event, PERF_EVENT_STATE_INACTIVE);
 		event->oncpu = -1;
-		ret = -EAGAIN;
-		goto out;
+		return -EAGAIN;
 	}
 
 	if (!is_software_event(event))
@@ -2536,10 +2536,7 @@ event_sched_in(struct perf_event *event,
 	if (event->attr.exclusive)
 		cpc->exclusive = 1;
 
-out:
-	perf_pmu_enable(event->pmu);
-
-	return ret;
+	return 0;
 }
 
 static int


