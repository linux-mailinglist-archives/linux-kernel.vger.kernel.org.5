Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E503878CD01
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 21:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240230AbjH2TcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 15:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240397AbjH2Tby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 15:31:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7FA198;
        Tue, 29 Aug 2023 12:31:46 -0700 (PDT)
Date:   Tue, 29 Aug 2023 19:31:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693337505;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VL9juU4w/cYscZ6aCMkAnSFQXoSvdNqmOO6zGmPB8qE=;
        b=EM9tf2FVBhOu/Ahw3d2jqlqo0FTe5raOLqEttiVpLl+QyLuZWjWOLShD3Y6dD3FbPt8KH1
        4rc73zasIj0jfA0DGCPAsTjhnzNM/x0k86IaD22yh6R5WWhMV3KzNMG85yb4eklFk3Ak5Z
        adl2zbG0rRRuZK4YVjGRTSQlRZZhL3c9C7zjVRpqs8LDBMgd/zttj/SyTc2ElbUArmifkj
        P0fQH6kA0okD8eVQKXSLn/oFdfFoLk7S7gRmOl8630dsvx4P5XWu2WHYDVmTi4tnn4A+CZ
        woOD3AibmgrF2sk6fll5by+jbioBClEgb9pjiYiBBxg36+I5taASwg1XwCDm7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693337505;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VL9juU4w/cYscZ6aCMkAnSFQXoSvdNqmOO6zGmPB8qE=;
        b=F/oxhc5JdiPSTak+1PbjkYNVGIUxgF5qDUP6o7by9Nzu93640fysjrMfsAmxEVlQsKnoJi
        HOSw1sr8rGac4fBA==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Apply the common initialization code for ADL
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230829125806.3016082-5-kan.liang@linux.intel.com>
References: <20230829125806.3016082-5-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <169333750506.27769.14668320985686955118.tip-bot2@tip-bot2>
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

Commit-ID:     299a5fc8e783eed705015e83e381912dbbf3eabc
Gitweb:        https://git.kernel.org/tip/299a5fc8e783eed705015e83e381912dbbf3eabc
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Tue, 29 Aug 2023 05:58:04 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 29 Aug 2023 20:59:23 +02:00

perf/x86/intel: Apply the common initialization code for ADL

Use the intel_pmu_init_glc() and intel_pmu_init_grt() to replace the
duplicate code for ADL.

The current code already checks the PERF_X86_EVENT_TOPDOWN flag before
invoking the Topdown metrics functions. (The PERF_X86_EVENT_TOPDOWN flag
is to indicate the Topdown metric feature, which is only available for
the p-core.) Drop the unnecessary adl_set_topdown_event_period() and
adl_update_topdown_event().

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230829125806.3016082-5-kan.liang@linux.intel.com
---
 arch/x86/events/intel/core.c | 53 +----------------------------------
 1 file changed, 2 insertions(+), 51 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 95ac7bb..a5ba491 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2556,16 +2556,6 @@ static int icl_set_topdown_event_period(struct perf_event *event)
 	return 0;
 }
 
-static int adl_set_topdown_event_period(struct perf_event *event)
-{
-	struct x86_hybrid_pmu *pmu = hybrid_pmu(event->pmu);
-
-	if (pmu->cpu_type != hybrid_big)
-		return 0;
-
-	return icl_set_topdown_event_period(event);
-}
-
 DEFINE_STATIC_CALL(intel_pmu_set_topdown_event_period, x86_perf_event_set_period);
 
 static inline u64 icl_get_metrics_event_value(u64 metric, u64 slots, int idx)
@@ -2708,16 +2698,6 @@ static u64 icl_update_topdown_event(struct perf_event *event)
 						 x86_pmu.num_topdown_events - 1);
 }
 
-static u64 adl_update_topdown_event(struct perf_event *event)
-{
-	struct x86_hybrid_pmu *pmu = hybrid_pmu(event->pmu);
-
-	if (pmu->cpu_type != hybrid_big)
-		return 0;
-
-	return icl_update_topdown_event(event);
-}
-
 DEFINE_STATIC_CALL(intel_pmu_update_topdown_event, x86_perf_event_update);
 
 static void intel_pmu_read_topdown_event(struct perf_event *event)
@@ -6612,32 +6592,11 @@ __init int intel_pmu_init(void)
 		static_branch_enable(&perf_is_hybrid);
 		x86_pmu.num_hybrid_pmus = X86_HYBRID_NUM_PMUS;
 
-		x86_pmu.pebs_aliases = NULL;
-		x86_pmu.pebs_prec_dist = true;
-		x86_pmu.pebs_block = true;
-		x86_pmu.flags |= PMU_FL_HAS_RSP_1;
-		x86_pmu.flags |= PMU_FL_NO_HT_SHARING;
-		x86_pmu.flags |= PMU_FL_INSTR_LATENCY;
-		x86_pmu.lbr_pt_coexist = true;
 		x86_pmu.pebs_latency_data = adl_latency_data_small;
-		x86_pmu.num_topdown_events = 8;
-		static_call_update(intel_pmu_update_topdown_event,
-				   &adl_update_topdown_event);
-		static_call_update(intel_pmu_set_topdown_event_period,
-				   &adl_set_topdown_event_period);
-
 		x86_pmu.filter = intel_pmu_filter;
 		x86_pmu.get_event_constraints = adl_get_event_constraints;
 		x86_pmu.hw_config = adl_hw_config;
-		x86_pmu.limit_period = glc_limit_period;
 		x86_pmu.get_hybrid_cpu_type = adl_get_hybrid_cpu_type;
-		/*
-		 * The rtm_abort_event is used to check whether to enable GPRs
-		 * for the RTM abort event. Atom doesn't have the RTM abort
-		 * event. There is no harmful to set it in the common
-		 * x86_pmu.rtm_abort_event.
-		 */
-		x86_pmu.rtm_abort_event = X86_CONFIG(.event=0xc9, .umask=0x04);
 
 		td_attr = adl_hybrid_events_attrs;
 		mem_attr = adl_hybrid_mem_attrs;
@@ -6649,6 +6608,7 @@ __init int intel_pmu_init(void)
 		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_CORE_IDX];
 		pmu->name = "cpu_core";
 		pmu->cpu_type = hybrid_big;
+		intel_pmu_init_glc(&pmu->pmu);
 		pmu->late_ack = true;
 		if (cpu_feature_enabled(X86_FEATURE_HYBRID_CPU)) {
 			pmu->num_counters = x86_pmu.num_counters + 2;
@@ -6678,16 +6638,13 @@ __init int intel_pmu_init(void)
 		pmu->intel_cap.perf_metrics = 1;
 		pmu->intel_cap.pebs_output_pt_available = 0;
 
-		memcpy(pmu->hw_cache_event_ids, glc_hw_cache_event_ids, sizeof(pmu->hw_cache_event_ids));
-		memcpy(pmu->hw_cache_extra_regs, glc_hw_cache_extra_regs, sizeof(pmu->hw_cache_extra_regs));
-		pmu->event_constraints = intel_glc_event_constraints;
-		pmu->pebs_constraints = intel_glc_pebs_event_constraints;
 		pmu->extra_regs = intel_glc_extra_regs;
 
 		/* Initialize Atom core specific PerfMon capabilities.*/
 		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_ATOM_IDX];
 		pmu->name = "cpu_atom";
 		pmu->cpu_type = hybrid_small;
+		intel_pmu_init_grt(&pmu->pmu);
 		pmu->mid_ack = true;
 		pmu->num_counters = x86_pmu.num_counters;
 		pmu->num_counters_fixed = x86_pmu.num_counters_fixed;
@@ -6699,12 +6656,6 @@ __init int intel_pmu_init(void)
 		pmu->intel_cap.perf_metrics = 0;
 		pmu->intel_cap.pebs_output_pt_available = 1;
 
-		memcpy(pmu->hw_cache_event_ids, glp_hw_cache_event_ids, sizeof(pmu->hw_cache_event_ids));
-		memcpy(pmu->hw_cache_extra_regs, tnt_hw_cache_extra_regs, sizeof(pmu->hw_cache_extra_regs));
-		pmu->hw_cache_event_ids[C(ITLB)][C(OP_READ)][C(RESULT_ACCESS)] = -1;
-		pmu->event_constraints = intel_slm_event_constraints;
-		pmu->pebs_constraints = intel_grt_pebs_event_constraints;
-		pmu->extra_regs = intel_grt_extra_regs;
 		if (is_mtl(boot_cpu_data.x86_model)) {
 			x86_pmu.hybrid_pmu[X86_HYBRID_PMU_CORE_IDX].extra_regs = intel_rwc_extra_regs;
 			x86_pmu.pebs_latency_data = mtl_latency_data_small;
