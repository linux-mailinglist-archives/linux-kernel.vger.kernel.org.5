Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95CE578C49C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 14:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235735AbjH2M6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 08:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235671AbjH2M6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 08:58:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F9199
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 05:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693313882; x=1724849882;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PGt4g7CgoiWLmvBstya6mXeIAJWoEZJWoOB/DLSYmd4=;
  b=nus5uqLJwr5NIGKklEfgbdraT+hhoMDSIGOt6WqZmcTfiTZZUhNIHPbL
   h1oQ3+B9JFyKSXsh47Z4FOHAp5n+ZL/MWP9yJS+XkAyYFn5bAODkQhzYK
   IrxctiTk0y2LMV4PNk06gEArsPEwmo/BrUYL9LCCElKS/c3f4UKvIkwVl
   7/3FamXMWE21YpSLp4F/QONeanGVqeijF109mwaK4EpQQz0ucn4hOv67C
   Wn4s454Xe6gi50kuTGciVypV6DbsxFjDjKxTuWxzafFGpK393JwI+g2Wh
   c3RDPgCKS/Jt/3+7DBgWweYVCnRCO/6goKoVr2ws5QFSMxbkRicZzH7CR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="406354906"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="406354906"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 05:58:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="853272012"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="853272012"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga002.fm.intel.com with ESMTP; 29 Aug 2023 05:58:01 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     dapeng1.mi@linux.intel.com, zhenyuw@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 1/6] perf/x86/intel: Use the common uarch name for the shared functions
Date:   Tue, 29 Aug 2023 05:58:01 -0700
Message-Id: <20230829125806.3016082-2-kan.liang@linux.intel.com>
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

From PMU's perspective, the SPR/GNR server has a similar uarch to the
ADL/MTL client p-core. Many functions are shared. However, the shared
function name uses the abbreviation of the server product code name,
rather than the common uarch code name.

Rename these internal shared functions by the common uarch name.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c | 64 ++++++++++++++++++------------------
 arch/x86/events/intel/ds.c   |  2 +-
 arch/x86/events/perf_event.h |  2 +-
 3 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 64a3533997e1..6c98c272d4f8 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -299,7 +299,7 @@ static struct extra_reg intel_icl_extra_regs[] __read_mostly = {
 	EVENT_EXTRA_END
 };
 
-static struct extra_reg intel_spr_extra_regs[] __read_mostly = {
+static struct extra_reg intel_glc_extra_regs[] __read_mostly = {
 	INTEL_UEVENT_EXTRA_REG(0x012a, MSR_OFFCORE_RSP_0, 0x3fffffffffull, RSP_0),
 	INTEL_UEVENT_EXTRA_REG(0x012b, MSR_OFFCORE_RSP_1, 0x3fffffffffull, RSP_1),
 	INTEL_UEVENT_PEBS_LDLAT_EXTRA_REG(0x01cd),
@@ -309,7 +309,7 @@ static struct extra_reg intel_spr_extra_regs[] __read_mostly = {
 	EVENT_EXTRA_END
 };
 
-static struct event_constraint intel_spr_event_constraints[] = {
+static struct event_constraint intel_glc_event_constraints[] = {
 	FIXED_EVENT_CONSTRAINT(0x00c0, 0),	/* INST_RETIRED.ANY */
 	FIXED_EVENT_CONSTRAINT(0x0100, 0),	/* INST_RETIRED.PREC_DIST */
 	FIXED_EVENT_CONSTRAINT(0x003c, 1),	/* CPU_CLK_UNHALTED.CORE */
@@ -349,7 +349,7 @@ static struct event_constraint intel_spr_event_constraints[] = {
 	EVENT_CONSTRAINT_END
 };
 
-static struct extra_reg intel_gnr_extra_regs[] __read_mostly = {
+static struct extra_reg intel_rwc_extra_regs[] __read_mostly = {
 	INTEL_UEVENT_EXTRA_REG(0x012a, MSR_OFFCORE_RSP_0, 0x3fffffffffull, RSP_0),
 	INTEL_UEVENT_EXTRA_REG(0x012b, MSR_OFFCORE_RSP_1, 0x3fffffffffull, RSP_1),
 	INTEL_UEVENT_PEBS_LDLAT_EXTRA_REG(0x01cd),
@@ -473,7 +473,7 @@ static u64 intel_pmu_event_map(int hw_event)
 	return intel_perfmon_event_map[hw_event];
 }
 
-static __initconst const u64 spr_hw_cache_event_ids
+static __initconst const u64 glc_hw_cache_event_ids
 				[PERF_COUNT_HW_CACHE_MAX]
 				[PERF_COUNT_HW_CACHE_OP_MAX]
 				[PERF_COUNT_HW_CACHE_RESULT_MAX] =
@@ -552,7 +552,7 @@ static __initconst const u64 spr_hw_cache_event_ids
  },
 };
 
-static __initconst const u64 spr_hw_cache_extra_regs
+static __initconst const u64 glc_hw_cache_extra_regs
 				[PERF_COUNT_HW_CACHE_MAX]
 				[PERF_COUNT_HW_CACHE_OP_MAX]
 				[PERF_COUNT_HW_CACHE_RESULT_MAX] =
@@ -4266,7 +4266,7 @@ icl_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 }
 
 static struct event_constraint *
-spr_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
+glc_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 			  struct perf_event *event)
 {
 	struct event_constraint *c;
@@ -4355,7 +4355,7 @@ adl_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 	struct x86_hybrid_pmu *pmu = hybrid_pmu(event->pmu);
 
 	if (pmu->cpu_type == hybrid_big)
-		return spr_get_event_constraints(cpuc, idx, event);
+		return glc_get_event_constraints(cpuc, idx, event);
 	else if (pmu->cpu_type == hybrid_small)
 		return tnt_get_event_constraints(cpuc, idx, event);
 
@@ -4402,7 +4402,7 @@ rwc_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 {
 	struct event_constraint *c;
 
-	c = spr_get_event_constraints(cpuc, idx, event);
+	c = glc_get_event_constraints(cpuc, idx, event);
 
 	/* The Retire Latency is not supported by the fixed counter 0. */
 	if (event->attr.precise_ip &&
@@ -4483,7 +4483,7 @@ static void nhm_limit_period(struct perf_event *event, s64 *left)
 	*left = max(*left, 32LL);
 }
 
-static void spr_limit_period(struct perf_event *event, s64 *left)
+static void glc_limit_period(struct perf_event *event, s64 *left)
 {
 	if (event->attr.precise_ip == 3)
 		*left = max(*left, 128LL);
@@ -5330,14 +5330,14 @@ static struct attribute *icl_tsx_events_attrs[] = {
 EVENT_ATTR_STR(mem-stores,	mem_st_spr,	"event=0xcd,umask=0x2");
 EVENT_ATTR_STR(mem-loads-aux,	mem_ld_aux,	"event=0x03,umask=0x82");
 
-static struct attribute *spr_events_attrs[] = {
+static struct attribute *glc_events_attrs[] = {
 	EVENT_PTR(mem_ld_hsw),
 	EVENT_PTR(mem_st_spr),
 	EVENT_PTR(mem_ld_aux),
 	NULL,
 };
 
-static struct attribute *spr_td_events_attrs[] = {
+static struct attribute *glc_td_events_attrs[] = {
 	EVENT_PTR(slots),
 	EVENT_PTR(td_retiring),
 	EVENT_PTR(td_bad_spec),
@@ -5350,7 +5350,7 @@ static struct attribute *spr_td_events_attrs[] = {
 	NULL,
 };
 
-static struct attribute *spr_tsx_events_attrs[] = {
+static struct attribute *glc_tsx_events_attrs[] = {
 	EVENT_PTR(tx_start),
 	EVENT_PTR(tx_abort),
 	EVENT_PTR(tx_commit),
@@ -6208,7 +6208,7 @@ __init int intel_pmu_init(void)
 		intel_pmu_pebs_data_source_grt();
 		x86_pmu.pebs_latency_data = adl_latency_data_small;
 		x86_pmu.get_event_constraints = tnt_get_event_constraints;
-		x86_pmu.limit_period = spr_limit_period;
+		x86_pmu.limit_period = glc_limit_period;
 		td_attr = tnt_events_attrs;
 		mem_attr = grt_mem_attrs;
 		extra_attr = nhm_format_attr;
@@ -6239,7 +6239,7 @@ __init int intel_pmu_init(void)
 		intel_pmu_pebs_data_source_cmt();
 		x86_pmu.pebs_latency_data = mtl_latency_data_small;
 		x86_pmu.get_event_constraints = cmt_get_event_constraints;
-		x86_pmu.limit_period = spr_limit_period;
+		x86_pmu.limit_period = glc_limit_period;
 		td_attr = cmt_events_attrs;
 		mem_attr = grt_mem_attrs;
 		extra_attr = cmt_format_attr;
@@ -6556,20 +6556,20 @@ __init int intel_pmu_init(void)
 	case INTEL_FAM6_SAPPHIRERAPIDS_X:
 	case INTEL_FAM6_EMERALDRAPIDS_X:
 		x86_pmu.flags |= PMU_FL_MEM_LOADS_AUX;
-		x86_pmu.extra_regs = intel_spr_extra_regs;
+		x86_pmu.extra_regs = intel_glc_extra_regs;
 		fallthrough;
 	case INTEL_FAM6_GRANITERAPIDS_X:
 	case INTEL_FAM6_GRANITERAPIDS_D:
 		pmem = true;
 		x86_pmu.late_ack = true;
-		memcpy(hw_cache_event_ids, spr_hw_cache_event_ids, sizeof(hw_cache_event_ids));
-		memcpy(hw_cache_extra_regs, spr_hw_cache_extra_regs, sizeof(hw_cache_extra_regs));
+		memcpy(hw_cache_event_ids, glc_hw_cache_event_ids, sizeof(hw_cache_event_ids));
+		memcpy(hw_cache_extra_regs, glc_hw_cache_extra_regs, sizeof(hw_cache_extra_regs));
 
-		x86_pmu.event_constraints = intel_spr_event_constraints;
-		x86_pmu.pebs_constraints = intel_spr_pebs_event_constraints;
+		x86_pmu.event_constraints = intel_glc_event_constraints;
+		x86_pmu.pebs_constraints = intel_glc_pebs_event_constraints;
 		if (!x86_pmu.extra_regs)
-			x86_pmu.extra_regs = intel_gnr_extra_regs;
-		x86_pmu.limit_period = spr_limit_period;
+			x86_pmu.extra_regs = intel_rwc_extra_regs;
+		x86_pmu.limit_period = glc_limit_period;
 		x86_pmu.pebs_ept = 1;
 		x86_pmu.pebs_aliases = NULL;
 		x86_pmu.pebs_prec_dist = true;
@@ -6579,13 +6579,13 @@ __init int intel_pmu_init(void)
 		x86_pmu.flags |= PMU_FL_INSTR_LATENCY;
 
 		x86_pmu.hw_config = hsw_hw_config;
-		x86_pmu.get_event_constraints = spr_get_event_constraints;
+		x86_pmu.get_event_constraints = glc_get_event_constraints;
 		extra_attr = boot_cpu_has(X86_FEATURE_RTM) ?
 			hsw_format_attr : nhm_format_attr;
 		extra_skl_attr = skl_format_attr;
-		mem_attr = spr_events_attrs;
-		td_attr = spr_td_events_attrs;
-		tsx_attr = spr_tsx_events_attrs;
+		mem_attr = glc_events_attrs;
+		td_attr = glc_td_events_attrs;
+		tsx_attr = glc_tsx_events_attrs;
 		x86_pmu.rtm_abort_event = X86_CONFIG(.event=0xc9, .umask=0x04);
 		x86_pmu.lbr_pt_coexist = true;
 		intel_pmu_pebs_data_source_skl(pmem);
@@ -6635,7 +6635,7 @@ __init int intel_pmu_init(void)
 		x86_pmu.filter = intel_pmu_filter;
 		x86_pmu.get_event_constraints = adl_get_event_constraints;
 		x86_pmu.hw_config = adl_hw_config;
-		x86_pmu.limit_period = spr_limit_period;
+		x86_pmu.limit_period = glc_limit_period;
 		x86_pmu.get_hybrid_cpu_type = adl_get_hybrid_cpu_type;
 		/*
 		 * The rtm_abort_event is used to check whether to enable GPRs
@@ -6684,11 +6684,11 @@ __init int intel_pmu_init(void)
 		pmu->intel_cap.perf_metrics = 1;
 		pmu->intel_cap.pebs_output_pt_available = 0;
 
-		memcpy(pmu->hw_cache_event_ids, spr_hw_cache_event_ids, sizeof(pmu->hw_cache_event_ids));
-		memcpy(pmu->hw_cache_extra_regs, spr_hw_cache_extra_regs, sizeof(pmu->hw_cache_extra_regs));
-		pmu->event_constraints = intel_spr_event_constraints;
-		pmu->pebs_constraints = intel_spr_pebs_event_constraints;
-		pmu->extra_regs = intel_spr_extra_regs;
+		memcpy(pmu->hw_cache_event_ids, glc_hw_cache_event_ids, sizeof(pmu->hw_cache_event_ids));
+		memcpy(pmu->hw_cache_extra_regs, glc_hw_cache_extra_regs, sizeof(pmu->hw_cache_extra_regs));
+		pmu->event_constraints = intel_glc_event_constraints;
+		pmu->pebs_constraints = intel_glc_pebs_event_constraints;
+		pmu->extra_regs = intel_glc_extra_regs;
 
 		/* Initialize Atom core specific PerfMon capabilities.*/
 		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_ATOM_IDX];
@@ -6712,7 +6712,7 @@ __init int intel_pmu_init(void)
 		pmu->pebs_constraints = intel_grt_pebs_event_constraints;
 		pmu->extra_regs = intel_grt_extra_regs;
 		if (is_mtl(boot_cpu_data.x86_model)) {
-			x86_pmu.hybrid_pmu[X86_HYBRID_PMU_CORE_IDX].extra_regs = intel_gnr_extra_regs;
+			x86_pmu.hybrid_pmu[X86_HYBRID_PMU_CORE_IDX].extra_regs = intel_rwc_extra_regs;
 			x86_pmu.pebs_latency_data = mtl_latency_data_small;
 			extra_attr = boot_cpu_has(X86_FEATURE_RTM) ?
 				mtl_hybrid_extra_attr_rtm : mtl_hybrid_extra_attr;
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index eb8dd8b8a1e8..74642469ca7b 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1058,7 +1058,7 @@ struct event_constraint intel_icl_pebs_event_constraints[] = {
 	EVENT_CONSTRAINT_END
 };
 
-struct event_constraint intel_spr_pebs_event_constraints[] = {
+struct event_constraint intel_glc_pebs_event_constraints[] = {
 	INTEL_FLAGS_UEVENT_CONSTRAINT(0x100, 0x100000000ULL),	/* INST_RETIRED.PREC_DIST */
 	INTEL_FLAGS_UEVENT_CONSTRAINT(0x0400, 0x800000000ULL),
 
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index c8ba2be7585d..96a427fc55cf 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1521,7 +1521,7 @@ extern struct event_constraint intel_skl_pebs_event_constraints[];
 
 extern struct event_constraint intel_icl_pebs_event_constraints[];
 
-extern struct event_constraint intel_spr_pebs_event_constraints[];
+extern struct event_constraint intel_glc_pebs_event_constraints[];
 
 struct event_constraint *intel_pebs_constraints(struct perf_event *event);
 
-- 
2.35.1

