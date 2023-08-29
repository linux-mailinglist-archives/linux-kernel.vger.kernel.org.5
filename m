Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD1978C49D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 14:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235753AbjH2M6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 08:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235695AbjH2M6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 08:58:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AC8103
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 05:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693313885; x=1724849885;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2fO88cgS2dndEL6XdAkpOAGNtf0jrYKCFzDS190Nwag=;
  b=iiWjmMkc9HTPIMvIR7F8bsW+tJ9OpqkDn/sADzR3Wgas+4uHnOwpr0nA
   urJF0uCDjEhPfwBq9N80lHrITlqHROoUd9A2hFHYsSORSCVU8eYQuwE2+
   KcN0lCBSMRfucdSBHCUkmRGAbHjZPFgMm33x/vc0CyhGlNjbdSBL38KJt
   W9xJ3K6NwgTlDJIhYz6rJ8j251rzI1TJJpFU+dmPp7erEIIBYf6ZguIcb
   ARRlof9AhLYBFUsdsx5Fe+dmNL2qGJhA7gBrPMIShVblcnfmbiKUvsYbw
   pWIR4gvWYXeUDVymKLy6/T4Og4r6gC/yNZhcjrWp6gts/khx4uViqE3Fj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="406354920"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="406354920"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 05:58:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="853272034"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="853272034"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga002.fm.intel.com with ESMTP; 29 Aug 2023 05:58:05 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     dapeng1.mi@linux.intel.com, zhenyuw@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 4/6] perf/x86/intel: Apply the common initialization code for ADL
Date:   Tue, 29 Aug 2023 05:58:04 -0700
Message-Id: <20230829125806.3016082-5-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230829125806.3016082-1-kan.liang@linux.intel.com>
References: <20230829125806.3016082-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Use the intel_pmu_init_glc() and intel_pmu_init_grt() to replace the
duplicate code for ADL.

The current code already checks the PERF_X86_EVENT_TOPDOWN flag before
invoking the Topdown metrics functions. (The PERF_X86_EVENT_TOPDOWN flag
is to indicate the Topdown metric feature, which is only available for
the p-core.) Drop the unnecessary adl_set_topdown_event_period() and
adl_update_topdown_event().

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c | 53 ++----------------------------------
 1 file changed, 2 insertions(+), 51 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index cffaa97035a0..3537b62a4f17 100644
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
@@ -6605,32 +6585,11 @@ __init int intel_pmu_init(void)
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
@@ -6642,6 +6601,7 @@ __init int intel_pmu_init(void)
 		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_CORE_IDX];
 		pmu->name = "cpu_core";
 		pmu->cpu_type = hybrid_big;
+		intel_pmu_init_glc(&pmu->pmu);
 		pmu->late_ack = true;
 		if (cpu_feature_enabled(X86_FEATURE_HYBRID_CPU)) {
 			pmu->num_counters = x86_pmu.num_counters + 2;
@@ -6671,16 +6631,13 @@ __init int intel_pmu_init(void)
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
@@ -6692,12 +6649,6 @@ __init int intel_pmu_init(void)
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
-- 
2.35.1

