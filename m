Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBC378CD05
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 21:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240404AbjH2TcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 15:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240455AbjH2TcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 15:32:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04346E49;
        Tue, 29 Aug 2023 12:31:53 -0700 (PDT)
Date:   Tue, 29 Aug 2023 19:31:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693337507;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=quohDY/tQ98vV2QkChfFiTdhQ74SY0yLBzT1VCIi7sM=;
        b=QXA9plM8YrjbMBTyqHH62RsJvB323ojixuduCLTnFQjpovJOWcusf+SB0SrxgSYgWv2KjG
        P/3ip+8VCsGLo1e5pVBeTixMlDHLvw4z9IGdBGuRCDXoL/L2cnXtUSdOnAfRKOQ3T5acse
        nHBB9XWING4I/h44iM1ntz+a1zpEK0NDbKqRhlf9vbpCTR1ecoF+rd7K0Guf2fb+52Tni1
        /eM0Ol4MUciCDuK3pz/BBIMU6yfcERt6XN65cdP1s4Oab2DWXyS6sQy3c+UfqiR+/qwpLF
        VIASok6jUecwEzb4fFD44iMgVL2sspjXxifkNqAf/cyU8aXEbbiCpBZM6hb9WA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693337507;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=quohDY/tQ98vV2QkChfFiTdhQ74SY0yLBzT1VCIi7sM=;
        b=eVyUWHm0ADUNNxEm22eemW9GYU3wTcGS/o8/nVfgNDqAaw66cthyW7qoL9vo5aF5a2yyHM
        ysV8WqF8Uw4c3+DA==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Use the common uarch name for the
 shared functions
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230829125806.3016082-2-kan.liang@linux.intel.com>
References: <20230829125806.3016082-2-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <169333750647.27769.10175556254592835652.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     d4b5694c75d4eba8238d541a55da0c67e876213e
Gitweb:        https://git.kernel.org/tip/d4b5694c75d4eba8238d541a55da0c67e876213e
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Tue, 29 Aug 2023 05:58:01 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 29 Aug 2023 20:59:22 +02:00

perf/x86/intel: Use the common uarch name for the shared functions

>From PMU's perspective, the SPR/GNR server has a similar uarch to the
ADL/MTL client p-core. Many functions are shared. However, the shared
function name uses the abbreviation of the server product code name,
rather than the common uarch code name.

Rename these internal shared functions by the common uarch name.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230829125806.3016082-2-kan.liang@linux.intel.com
---
 arch/x86/events/intel/core.c | 64 +++++++++++++++++------------------
 arch/x86/events/intel/ds.c   |  2 +-
 arch/x86/events/perf_event.h |  2 +-
 3 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index fa355d3..93be19c 100644
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
@@ -4273,7 +4273,7 @@ icl_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 }
 
 static struct event_constraint *
-spr_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
+glc_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 			  struct perf_event *event)
 {
 	struct event_constraint *c;
@@ -4362,7 +4362,7 @@ adl_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 	struct x86_hybrid_pmu *pmu = hybrid_pmu(event->pmu);
 
 	if (pmu->cpu_type == hybrid_big)
-		return spr_get_event_constraints(cpuc, idx, event);
+		return glc_get_event_constraints(cpuc, idx, event);
 	else if (pmu->cpu_type == hybrid_small)
 		return tnt_get_event_constraints(cpuc, idx, event);
 
@@ -4409,7 +4409,7 @@ rwc_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 {
 	struct event_constraint *c;
 
-	c = spr_get_event_constraints(cpuc, idx, event);
+	c = glc_get_event_constraints(cpuc, idx, event);
 
 	/* The Retire Latency is not supported by the fixed counter 0. */
 	if (event->attr.precise_ip &&
@@ -4490,7 +4490,7 @@ static void nhm_limit_period(struct perf_event *event, s64 *left)
 	*left = max(*left, 32LL);
 }
 
-static void spr_limit_period(struct perf_event *event, s64 *left)
+static void glc_limit_period(struct perf_event *event, s64 *left)
 {
 	if (event->attr.precise_ip == 3)
 		*left = max(*left, 128LL);
@@ -5337,14 +5337,14 @@ static struct attribute *icl_tsx_events_attrs[] = {
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
@@ -5357,7 +5357,7 @@ static struct attribute *spr_td_events_attrs[] = {
 	NULL,
 };
 
-static struct attribute *spr_tsx_events_attrs[] = {
+static struct attribute *glc_tsx_events_attrs[] = {
 	EVENT_PTR(tx_start),
 	EVENT_PTR(tx_abort),
 	EVENT_PTR(tx_commit),
@@ -6215,7 +6215,7 @@ __init int intel_pmu_init(void)
 		intel_pmu_pebs_data_source_grt();
 		x86_pmu.pebs_latency_data = adl_latency_data_small;
 		x86_pmu.get_event_constraints = tnt_get_event_constraints;
-		x86_pmu.limit_period = spr_limit_period;
+		x86_pmu.limit_period = glc_limit_period;
 		td_attr = tnt_events_attrs;
 		mem_attr = grt_mem_attrs;
 		extra_attr = nhm_format_attr;
@@ -6246,7 +6246,7 @@ __init int intel_pmu_init(void)
 		intel_pmu_pebs_data_source_cmt();
 		x86_pmu.pebs_latency_data = mtl_latency_data_small;
 		x86_pmu.get_event_constraints = cmt_get_event_constraints;
-		x86_pmu.limit_period = spr_limit_period;
+		x86_pmu.limit_period = glc_limit_period;
 		td_attr = cmt_events_attrs;
 		mem_attr = grt_mem_attrs;
 		extra_attr = cmt_format_attr;
@@ -6563,20 +6563,20 @@ __init int intel_pmu_init(void)
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
@@ -6586,13 +6586,13 @@ __init int intel_pmu_init(void)
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
@@ -6642,7 +6642,7 @@ __init int intel_pmu_init(void)
 		x86_pmu.filter = intel_pmu_filter;
 		x86_pmu.get_event_constraints = adl_get_event_constraints;
 		x86_pmu.hw_config = adl_hw_config;
-		x86_pmu.limit_period = spr_limit_period;
+		x86_pmu.limit_period = glc_limit_period;
 		x86_pmu.get_hybrid_cpu_type = adl_get_hybrid_cpu_type;
 		/*
 		 * The rtm_abort_event is used to check whether to enable GPRs
@@ -6691,11 +6691,11 @@ __init int intel_pmu_init(void)
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
@@ -6719,7 +6719,7 @@ __init int intel_pmu_init(void)
 		pmu->pebs_constraints = intel_grt_pebs_event_constraints;
 		pmu->extra_regs = intel_grt_extra_regs;
 		if (is_mtl(boot_cpu_data.x86_model)) {
-			x86_pmu.hybrid_pmu[X86_HYBRID_PMU_CORE_IDX].extra_regs = intel_gnr_extra_regs;
+			x86_pmu.hybrid_pmu[X86_HYBRID_PMU_CORE_IDX].extra_regs = intel_rwc_extra_regs;
 			x86_pmu.pebs_latency_data = mtl_latency_data_small;
 			extra_attr = boot_cpu_has(X86_FEATURE_RTM) ?
 				mtl_hybrid_extra_attr_rtm : mtl_hybrid_extra_attr;
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index eb8dd8b..7464246 100644
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
index c8ba2be..96a427f 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1521,7 +1521,7 @@ extern struct event_constraint intel_skl_pebs_event_constraints[];
 
 extern struct event_constraint intel_icl_pebs_event_constraints[];
 
-extern struct event_constraint intel_spr_pebs_event_constraints[];
+extern struct event_constraint intel_glc_pebs_event_constraints[];
 
 struct event_constraint *intel_pebs_constraints(struct perf_event *event);
 
