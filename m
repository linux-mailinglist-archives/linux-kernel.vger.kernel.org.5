Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B38C79C835
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbjILHbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjILHbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:31:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB3DB9;
        Tue, 12 Sep 2023 00:31:40 -0700 (PDT)
Date:   Tue, 12 Sep 2023 07:31:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694503898;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/1XdMFAWkhhn5/7eom8PbEM0SQHenQhaogqbW4MERog=;
        b=DbW/ayJcNHYkHPdqGQnCddZVED0bMQZe4Nb3Is1ZC7Gw6iAWgzdttKyTHc4IlW/rSAggOV
        xJ40dWJ/5v1f1oSfAdwkIMwf0I4jTxdOpVQBJvkvDAdHHw8WeJGhLVwvCvlztTHP7CbVRH
        gYe62HfiYAiEqA7EasTBy/xHPtSQCEfxPCmEBixwS4x1/emSwhq3HBRmp+Cn2pR9bJDFAb
        U8JYnjkp9uNqeW5Wq1gCvT1+RI9KF/EM+R1Xt6EVCiSUbGD71mjXGO5FeBESJKpDqbUHSw
        hpmC8/B1wEqIvMGWCEDAvsptK1nzbx2dh2SprJK9KuhaPcxNzHYgbhEpxm6d8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694503898;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/1XdMFAWkhhn5/7eom8PbEM0SQHenQhaogqbW4MERog=;
        b=OOoGIp8cHFEQuj3TV4A333ybaJKAjV+FZ3SWCH8HjD7iYaghOr/bQh386VJLl5/XHxYFjt
        dSYeJ9/cO5vqcICQ==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Extend the ref-cycles event to GP counters
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230911144139.2354015-1-kan.liang@linux.intel.com>
References: <20230911144139.2354015-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <169450389765.27769.14626010672569075307.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     ffbe4ab0beda55b5c467aa3d95ca14db75a84717
Gitweb:        https://git.kernel.org/tip/ffbe4ab0beda55b5c467aa3d95ca14db75a84717
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Mon, 11 Sep 2023 07:41:38 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 12 Sep 2023 08:22:24 +02:00

perf/x86/intel: Extend the ref-cycles event to GP counters

The current ref-cycles event is only available on the fixed counter 2.
Starting from the GLC and GRT core, the architectural UnHalted Reference
Cycles event (0x013c) which is available on general-purpose counters
can collect the exact same events as the fixed counter 2.

Update the mapping of ref-cycles to 0x013c. So the ref-cycles can be
available on both fixed counter 2 and general-purpose counters.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230911144139.2354015-1-kan.liang@linux.intel.com
---
 arch/x86/events/intel/core.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index e1543d6..a08f794 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -211,6 +211,14 @@ static struct event_constraint intel_slm_event_constraints[] __read_mostly =
 	EVENT_CONSTRAINT_END
 };
 
+static struct event_constraint intel_grt_event_constraints[] __read_mostly = {
+	FIXED_EVENT_CONSTRAINT(0x00c0, 0), /* INST_RETIRED.ANY */
+	FIXED_EVENT_CONSTRAINT(0x003c, 1), /* CPU_CLK_UNHALTED.CORE */
+	FIXED_EVENT_CONSTRAINT(0x0300, 2), /* pseudo CPU_CLK_UNHALTED.REF */
+	FIXED_EVENT_CONSTRAINT(0x013c, 2), /* CPU_CLK_UNHALTED.REF_TSC_P */
+	EVENT_CONSTRAINT_END
+};
+
 static struct event_constraint intel_skl_event_constraints[] = {
 	FIXED_EVENT_CONSTRAINT(0x00c0, 0),	/* INST_RETIRED.ANY */
 	FIXED_EVENT_CONSTRAINT(0x003c, 1),	/* CPU_CLK_UNHALTED.CORE */
@@ -314,6 +322,7 @@ static struct event_constraint intel_glc_event_constraints[] = {
 	FIXED_EVENT_CONSTRAINT(0x0100, 0),	/* INST_RETIRED.PREC_DIST */
 	FIXED_EVENT_CONSTRAINT(0x003c, 1),	/* CPU_CLK_UNHALTED.CORE */
 	FIXED_EVENT_CONSTRAINT(0x0300, 2),	/* CPU_CLK_UNHALTED.REF */
+	FIXED_EVENT_CONSTRAINT(0x013c, 2),	/* CPU_CLK_UNHALTED.REF_TSC_P */
 	FIXED_EVENT_CONSTRAINT(0x0400, 3),	/* SLOTS */
 	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_RETIRING, 0),
 	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_BAD_SPEC, 1),
@@ -5983,6 +5992,12 @@ static __always_inline int intel_pmu_init_hybrid(enum hybrid_pmu_type pmus)
 	return 0;
 }
 
+static __always_inline void intel_pmu_ref_cycles_ext(void)
+{
+	if (!(x86_pmu.events_maskl & (INTEL_PMC_MSK_FIXED_REF_CYCLES >> INTEL_PMC_IDX_FIXED)))
+		intel_perfmon_event_map[PERF_COUNT_HW_REF_CPU_CYCLES] = 0x013c;
+}
+
 static __always_inline void intel_pmu_init_glc(struct pmu *pmu)
 {
 	x86_pmu.late_ack = true;
@@ -6005,6 +6020,8 @@ static __always_inline void intel_pmu_init_glc(struct pmu *pmu)
 	memcpy(hybrid_var(pmu, hw_cache_extra_regs), glc_hw_cache_extra_regs, sizeof(hw_cache_extra_regs));
 	hybrid(pmu, event_constraints) = intel_glc_event_constraints;
 	hybrid(pmu, pebs_constraints) = intel_glc_pebs_event_constraints;
+
+	intel_pmu_ref_cycles_ext();
 }
 
 static __always_inline void intel_pmu_init_grt(struct pmu *pmu)
@@ -6021,9 +6038,11 @@ static __always_inline void intel_pmu_init_grt(struct pmu *pmu)
 	memcpy(hybrid_var(pmu, hw_cache_event_ids), glp_hw_cache_event_ids, sizeof(hw_cache_event_ids));
 	memcpy(hybrid_var(pmu, hw_cache_extra_regs), tnt_hw_cache_extra_regs, sizeof(hw_cache_extra_regs));
 	hybrid_var(pmu, hw_cache_event_ids)[C(ITLB)][C(OP_READ)][C(RESULT_ACCESS)] = -1;
-	hybrid(pmu, event_constraints) = intel_slm_event_constraints;
+	hybrid(pmu, event_constraints) = intel_grt_event_constraints;
 	hybrid(pmu, pebs_constraints) = intel_grt_pebs_event_constraints;
 	hybrid(pmu, extra_regs) = intel_grt_extra_regs;
+
+	intel_pmu_ref_cycles_ext();
 }
 
 __init int intel_pmu_init(void)
