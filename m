Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D469078C4A0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 14:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235808AbjH2M6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 08:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235704AbjH2M6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 08:58:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568741B1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 05:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693313888; x=1724849888;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B19Z5mDZjHZJzulH+0lq1kciqImUSK7h19ku8N3Ofx4=;
  b=EeM7MqkiYEoSwE/PswYlkXO020QXtCOCzxE3poa2B4edhgIui3BvCmXt
   IPGErFSJmEBT+sEVUeUn8mE8TSq/IU8J5K8PiM7dxf/sY0FqISy+fKw4o
   qkqsH6RAUh0DBWjXK4wQ/tMPoZlV6ijKbb2JE1/f/CzM8oLRhz9E9OOWb
   s5I03z/AI87Ybape8wI1RJaOnHNNP9oRxaLjTWDeChfnsjgp2juzMQZn4
   HcrswdnJA/+cj9KLQtM55X9CCvVWxZYWsLcl3xtHy+yJJTlHFw4rpOJu4
   2u2gvUdiE0TPfc0d1BOYNBIbTMmYW11p6GGojtTlp7FjmnhFJre+Dlrkv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="406354928"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="406354928"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 05:58:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="853272045"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="853272045"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga002.fm.intel.com with ESMTP; 29 Aug 2023 05:58:07 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     dapeng1.mi@linux.intel.com, zhenyuw@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 6/6] perf/x86/intel: Add common intel_pmu_init_hybrid
Date:   Tue, 29 Aug 2023 05:58:06 -0700
Message-Id: <20230829125806.3016082-7-kan.liang@linux.intel.com>
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

The current hybrid initialization codes aren't well organized and are
hard to read.

Factor out intel_pmu_init_hybrid() to do a common setup for each
hybrid PMU. The PMU-specific capability will be updated later via either
hard code (ADL) or CPUID hybrid enumeration (MTL).

Splitting the ADL and MTL initialization codes, since they have
different uarches. The hard code PMU capabilities are not required for
MTL either. They can be enumerated by the new leaf 0x23 and
IA32_PERF_CAPABILITIES MSR.

The hybrid enumeration of the IA32_PERF_CAPABILITIES MSR is broken on
MTL. Using the default value.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c | 162 ++++++++++++++++++++++++-----------
 1 file changed, 111 insertions(+), 51 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index bfa0649c31f4..89be504abca9 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4591,6 +4591,16 @@ static void intel_pmu_check_num_counters(int *num_counters,
 					 int *num_counters_fixed,
 					 u64 *intel_ctrl, u64 fixed_mask);
 
+static inline bool intel_pmu_broken_perf_cap(void)
+{
+	/* The Perf Metric (Bit 15) is always cleared */
+	if ((boot_cpu_data.x86_model == INTEL_FAM6_METEORLAKE) ||
+	    (boot_cpu_data.x86_model == INTEL_FAM6_METEORLAKE_L))
+		return true;
+
+	return false;
+}
+
 static void update_pmu_cap(struct x86_hybrid_pmu *pmu)
 {
 	unsigned int sub_bitmaps = cpuid_eax(ARCH_PERFMON_EXT_LEAF);
@@ -4603,7 +4613,27 @@ static void update_pmu_cap(struct x86_hybrid_pmu *pmu)
 		pmu->num_counters_fixed = fls(ebx);
 		intel_pmu_check_num_counters(&pmu->num_counters, &pmu->num_counters_fixed,
 					     &pmu->intel_ctrl, ebx);
+		pmu->max_pebs_events = min_t(unsigned, MAX_PEBS_EVENTS, pmu->num_counters);
+		pmu->unconstrained = (struct event_constraint)
+				     __EVENT_CONSTRAINT(0, (1ULL << pmu->num_counters) - 1,
+							0, pmu->num_counters, 0, 0);
 	}
+
+
+	if (!intel_pmu_broken_perf_cap()) {
+		/* Perf Metric (Bit 15) and PEBS via PT (Bit 16) are hybrid enumeration */
+		rdmsrl(MSR_IA32_PERF_CAPABILITIES, pmu->intel_cap.capabilities);
+	}
+
+	if (pmu->intel_cap.perf_metrics)
+		pmu->intel_ctrl |= 1ULL << GLOBAL_CTRL_EN_PERF_METRICS;
+	else
+		pmu->intel_ctrl &= ~(1ULL << GLOBAL_CTRL_EN_PERF_METRICS);
+
+	if (pmu->intel_cap.pebs_output_pt_available)
+		pmu->pmu.capabilities |= PERF_PMU_CAP_AUX_OUTPUT;
+	else
+		pmu->pmu.capabilities |= ~PERF_PMU_CAP_AUX_OUTPUT;
 }
 
 static struct x86_hybrid_pmu *find_hybrid_pmu_for_cpu(void)
@@ -5908,10 +5938,52 @@ static void intel_pmu_check_hybrid_pmus(u64 fixed_mask)
 	}
 }
 
-static __always_inline bool is_mtl(u8 x86_model)
+static const struct { enum hybrid_pmu_type id; char *name; } intel_hybrid_pmu_type_map[] __initconst = {
+	{ hybrid_small, "cpu_atom" },
+	{ hybrid_big, "cpu_core" },
+};
+
+static __always_inline int intel_pmu_init_hybrid(enum hybrid_pmu_type pmus)
 {
-	return (x86_model == INTEL_FAM6_METEORLAKE) ||
-	       (x86_model == INTEL_FAM6_METEORLAKE_L);
+	unsigned long pmus_mask = pmus;
+	struct x86_hybrid_pmu *pmu;
+	int idx = 0, bit;
+
+	x86_pmu.num_hybrid_pmus = hweight_long(pmus_mask);
+	x86_pmu.hybrid_pmu = kcalloc(x86_pmu.num_hybrid_pmus,
+				     sizeof(struct x86_hybrid_pmu),
+				     GFP_KERNEL);
+	if (!x86_pmu.hybrid_pmu)
+		return -ENOMEM;
+
+	static_branch_enable(&perf_is_hybrid);
+	x86_pmu.filter = intel_pmu_filter;
+
+	for_each_set_bit(bit, &pmus_mask, ARRAY_SIZE(intel_hybrid_pmu_type_map)) {
+		pmu = &x86_pmu.hybrid_pmu[idx++];
+		pmu->pmu_type = intel_hybrid_pmu_type_map[bit].id;
+		pmu->name = intel_hybrid_pmu_type_map[bit].name;
+
+		pmu->num_counters = x86_pmu.num_counters;
+		pmu->num_counters_fixed = x86_pmu.num_counters_fixed;
+		pmu->max_pebs_events = min_t(unsigned, MAX_PEBS_EVENTS, pmu->num_counters);
+		pmu->unconstrained = (struct event_constraint)
+				     __EVENT_CONSTRAINT(0, (1ULL << pmu->num_counters) - 1,
+							0, pmu->num_counters, 0, 0);
+
+		pmu->intel_cap.capabilities = x86_pmu.intel_cap.capabilities;
+		if (pmu->pmu_type & hybrid_small) {
+			pmu->intel_cap.perf_metrics = 0;
+			pmu->intel_cap.pebs_output_pt_available = 1;
+			pmu->mid_ack = true;
+		} else if (pmu->pmu_type & hybrid_big) {
+			pmu->intel_cap.perf_metrics = 1;
+			pmu->intel_cap.pebs_output_pt_available = 0;
+			pmu->late_ack = true;
+		}
+	}
+
+	return 0;
 }
 
 static __always_inline void intel_pmu_init_glc(struct pmu *pmu)
@@ -6595,23 +6667,14 @@ __init int intel_pmu_init(void)
 	case INTEL_FAM6_RAPTORLAKE:
 	case INTEL_FAM6_RAPTORLAKE_P:
 	case INTEL_FAM6_RAPTORLAKE_S:
-	case INTEL_FAM6_METEORLAKE:
-	case INTEL_FAM6_METEORLAKE_L:
 		/*
 		 * Alder Lake has 2 types of CPU, core and atom.
 		 *
 		 * Initialize the common PerfMon capabilities here.
 		 */
-		x86_pmu.hybrid_pmu = kcalloc(X86_HYBRID_NUM_PMUS,
-					     sizeof(struct x86_hybrid_pmu),
-					     GFP_KERNEL);
-		if (!x86_pmu.hybrid_pmu)
-			return -ENOMEM;
-		static_branch_enable(&perf_is_hybrid);
-		x86_pmu.num_hybrid_pmus = X86_HYBRID_NUM_PMUS;
+		intel_pmu_init_hybrid(hybrid_big_small);
 
 		x86_pmu.pebs_latency_data = adl_latency_data_small;
-		x86_pmu.filter = intel_pmu_filter;
 		x86_pmu.get_event_constraints = adl_get_event_constraints;
 		x86_pmu.hw_config = adl_hw_config;
 		x86_pmu.get_hybrid_cpu_type = adl_get_hybrid_cpu_type;
@@ -6624,10 +6687,7 @@ __init int intel_pmu_init(void)
 
 		/* Initialize big core specific PerfMon capabilities.*/
 		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_CORE_IDX];
-		pmu->name = "cpu_core";
-		pmu->pmu_type = hybrid_big;
 		intel_pmu_init_glc(&pmu->pmu);
-		pmu->late_ack = true;
 		if (cpu_feature_enabled(X86_FEATURE_HYBRID_CPU)) {
 			pmu->num_counters = x86_pmu.num_counters + 2;
 			pmu->num_counters_fixed = x86_pmu.num_counters_fixed + 1;
@@ -6652,45 +6712,45 @@ __init int intel_pmu_init(void)
 		pmu->unconstrained = (struct event_constraint)
 					__EVENT_CONSTRAINT(0, (1ULL << pmu->num_counters) - 1,
 							   0, pmu->num_counters, 0, 0);
-		pmu->intel_cap.capabilities = x86_pmu.intel_cap.capabilities;
-		pmu->intel_cap.perf_metrics = 1;
-		pmu->intel_cap.pebs_output_pt_available = 0;
-
 		pmu->extra_regs = intel_glc_extra_regs;
 
 		/* Initialize Atom core specific PerfMon capabilities.*/
 		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_ATOM_IDX];
-		pmu->name = "cpu_atom";
-		pmu->pmu_type = hybrid_small;
 		intel_pmu_init_grt(&pmu->pmu);
-		pmu->mid_ack = true;
-		pmu->num_counters = x86_pmu.num_counters;
-		pmu->num_counters_fixed = x86_pmu.num_counters_fixed;
-		pmu->max_pebs_events = x86_pmu.max_pebs_events;
-		pmu->unconstrained = (struct event_constraint)
-					__EVENT_CONSTRAINT(0, (1ULL << pmu->num_counters) - 1,
-							   0, pmu->num_counters, 0, 0);
-		pmu->intel_cap.capabilities = x86_pmu.intel_cap.capabilities;
-		pmu->intel_cap.perf_metrics = 0;
-		pmu->intel_cap.pebs_output_pt_available = 1;
-
-		if (is_mtl(boot_cpu_data.x86_model)) {
-			x86_pmu.hybrid_pmu[X86_HYBRID_PMU_CORE_IDX].extra_regs = intel_rwc_extra_regs;
-			x86_pmu.pebs_latency_data = mtl_latency_data_small;
-			extra_attr = boot_cpu_has(X86_FEATURE_RTM) ?
-				mtl_hybrid_extra_attr_rtm : mtl_hybrid_extra_attr;
-			mem_attr = mtl_hybrid_mem_attrs;
-			intel_pmu_pebs_data_source_mtl();
-			x86_pmu.get_event_constraints = mtl_get_event_constraints;
-			pmu->extra_regs = intel_cmt_extra_regs;
-			pr_cont("Meteorlake Hybrid events, ");
-			name = "meteorlake_hybrid";
-		} else {
-			x86_pmu.flags |= PMU_FL_MEM_LOADS_AUX;
-			intel_pmu_pebs_data_source_adl();
-			pr_cont("Alderlake Hybrid events, ");
-			name = "alderlake_hybrid";
-		}
+
+		x86_pmu.flags |= PMU_FL_MEM_LOADS_AUX;
+		intel_pmu_pebs_data_source_adl();
+		pr_cont("Alderlake Hybrid events, ");
+		name = "alderlake_hybrid";
+		break;
+
+	case INTEL_FAM6_METEORLAKE:
+	case INTEL_FAM6_METEORLAKE_L:
+		intel_pmu_init_hybrid(hybrid_big_small);
+
+		x86_pmu.pebs_latency_data = mtl_latency_data_small;
+		x86_pmu.get_event_constraints = mtl_get_event_constraints;
+		x86_pmu.hw_config = adl_hw_config;
+
+		td_attr = adl_hybrid_events_attrs;
+		mem_attr = mtl_hybrid_mem_attrs;
+		tsx_attr = adl_hybrid_tsx_attrs;
+		extra_attr = boot_cpu_has(X86_FEATURE_RTM) ?
+			mtl_hybrid_extra_attr_rtm : mtl_hybrid_extra_attr;
+
+		/* Initialize big core specific PerfMon capabilities.*/
+		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_CORE_IDX];
+		intel_pmu_init_glc(&pmu->pmu);
+		pmu->extra_regs = intel_rwc_extra_regs;
+
+		/* Initialize Atom core specific PerfMon capabilities.*/
+		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_ATOM_IDX];
+		intel_pmu_init_grt(&pmu->pmu);
+		pmu->extra_regs = intel_cmt_extra_regs;
+
+		intel_pmu_pebs_data_source_mtl();
+		pr_cont("Meteorlake Hybrid events, ");
+		name = "meteorlake_hybrid";
 		break;
 
 	default:
@@ -6802,7 +6862,7 @@ __init int intel_pmu_init(void)
 	if (!is_hybrid() && x86_pmu.intel_cap.perf_metrics)
 		x86_pmu.intel_ctrl |= 1ULL << GLOBAL_CTRL_EN_PERF_METRICS;
 
-	if (is_hybrid())
+	if (is_hybrid() && !boot_cpu_has(X86_FEATURE_ARCH_PERFMON_EXT))
 		intel_pmu_check_hybrid_pmus((u64)fixed_mask);
 
 	if (x86_pmu.intel_cap.pebs_timing_info)
-- 
2.35.1

