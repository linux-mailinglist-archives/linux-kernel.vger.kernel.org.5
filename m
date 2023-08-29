Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AEF278C4A1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 14:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235826AbjH2M6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 08:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235702AbjH2M6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 08:58:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ACB9BF
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 05:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693313887; x=1724849887;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=THg7GnXcWD5Z0mLbTgh+8xaYdma4pHunCisGc6fKDGM=;
  b=Do23nOYKjR3aQlvST9cSbkNDw7dbKOvqGsSo9gGiINACS17BKni4N8/D
   2iQjFrGYhTDtVYvmmXbxFdSaBkVuwFPpTvqIgAGFjlNsPzkxPVDJ7Eadl
   OUwE+WY5OcL9ueUfPG4jEjwWhDVQwpc9Yf0Oxe7q8SACBRMi1wSlkGE+9
   r13/1CMlfk0rQVS8WWjHYEu17Uj41ygq2bL6ky12eRp99+L15KMUL9eO7
   fKVMmIhAOAcGp3tqtcXbPgsjwSBdV9t04lC5RT8S4Vmxmt6QbhUivgKOD
   DY5ZPVOhWfDGhpfnS35NNNYilGSvgnjY0UEpGSLS397vP46vqJC1v416i
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="406354924"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="406354924"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 05:58:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="853272040"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="853272040"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga002.fm.intel.com with ESMTP; 29 Aug 2023 05:58:06 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     dapeng1.mi@linux.intel.com, zhenyuw@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH 5/6] perf/x86/intel: Cleanup the hybrid CPU type
Date:   Tue, 29 Aug 2023 05:58:05 -0700
Message-Id: <20230829125806.3016082-6-kan.liang@linux.intel.com>
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

There is a fairly long list of grievances about the current code. The
main beefs:

   1. hybrid_big_small assumes that the *HARDWARE* (CPUID) provided
      core types are a bitmap. They are not. If Intel happened to
      make a core type of 0xff, hilarity would ensue.
   2. adl_get_hybrid_cpu_type() utterly inscrutable.  There are
      precisely zero comments and zero changelog about what it is
      attempting to do.

According to Kan, the adl_get_hybrid_cpu_type() is there because some
Alder Lake (ADL) CPUs can do some silly things. Some ADL models are
*supposed* to be hybrid CPUs with big and little cores, but there are
some SKUs that only have big cores. CPUID(0x1a) on those CPUs does
not say that the CPUs are big cores. It apparently just returns 0x0.
It confuses perf because it expects to see either 0x40 (Core) or
0x20 (Atom).

The perf workaround for this is to watch for a CPU core saying it is
type 0x0. If that happens on an Alder Lake, it calls
x86_pmu.get_hybrid_cpu_type() and just assumes that the core is a
Core (0x40) CPU.

To fix up the mess, separate out the CPU types and the 'pmu' types.
This allows 'hybrid_pmu_type' bitmaps without worrying that some
future CPU type will set multiple bits.

Since the types are now separate, add a function to glue them back
together again. Actual comment on the situation in the glue
function (find_hybrid_pmu_for_cpu()).

Also, give ->get_hybrid_cpu_type() a real return type and make it
clear that it is overriding the *CPU* type, not the PMU type.

Rename cpu_type to pmu_type in the struct x86_hybrid_pmu to reflect the
change.

Originally-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
---
 arch/x86/events/core.c       |  6 ++--
 arch/x86/events/intel/core.c | 69 ++++++++++++++++++++++++------------
 arch/x86/events/intel/ds.c   |  2 +-
 arch/x86/events/perf_event.h | 35 ++++++++++--------
 4 files changed, 72 insertions(+), 40 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 185f902e5f28..40ad1425ffa2 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1887,9 +1887,9 @@ ssize_t events_hybrid_sysfs_show(struct device *dev,
 
 	str = pmu_attr->event_str;
 	for (i = 0; i < x86_pmu.num_hybrid_pmus; i++) {
-		if (!(x86_pmu.hybrid_pmu[i].cpu_type & pmu_attr->pmu_type))
+		if (!(x86_pmu.hybrid_pmu[i].pmu_type & pmu_attr->pmu_type))
 			continue;
-		if (x86_pmu.hybrid_pmu[i].cpu_type & pmu->cpu_type) {
+		if (x86_pmu.hybrid_pmu[i].pmu_type & pmu->pmu_type) {
 			next_str = strchr(str, ';');
 			if (next_str)
 				return snprintf(page, next_str - str + 1, "%s", str);
@@ -2169,7 +2169,7 @@ static int __init init_hw_perf_events(void)
 			hybrid_pmu->pmu.capabilities |= PERF_PMU_CAP_EXTENDED_HW_TYPE;
 
 			err = perf_pmu_register(&hybrid_pmu->pmu, hybrid_pmu->name,
-						(hybrid_pmu->cpu_type == hybrid_big) ? PERF_TYPE_RAW : -1);
+						(hybrid_pmu->pmu_type == hybrid_big) ? PERF_TYPE_RAW : -1);
 			if (err)
 				break;
 		}
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 3537b62a4f17..bfa0649c31f4 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3849,7 +3849,7 @@ static inline bool require_mem_loads_aux_event(struct perf_event *event)
 		return false;
 
 	if (is_hybrid())
-		return hybrid_pmu(event->pmu)->cpu_type == hybrid_big;
+		return hybrid_pmu(event->pmu)->pmu_type == hybrid_big;
 
 	return true;
 }
@@ -4334,9 +4334,9 @@ adl_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 {
 	struct x86_hybrid_pmu *pmu = hybrid_pmu(event->pmu);
 
-	if (pmu->cpu_type == hybrid_big)
+	if (pmu->pmu_type == hybrid_big)
 		return glc_get_event_constraints(cpuc, idx, event);
-	else if (pmu->cpu_type == hybrid_small)
+	else if (pmu->pmu_type == hybrid_small)
 		return tnt_get_event_constraints(cpuc, idx, event);
 
 	WARN_ON(1);
@@ -4406,9 +4406,9 @@ mtl_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 {
 	struct x86_hybrid_pmu *pmu = hybrid_pmu(event->pmu);
 
-	if (pmu->cpu_type == hybrid_big)
+	if (pmu->pmu_type == hybrid_big)
 		return rwc_get_event_constraints(cpuc, idx, event);
-	if (pmu->cpu_type == hybrid_small)
+	if (pmu->pmu_type == hybrid_small)
 		return cmt_get_event_constraints(cpuc, idx, event);
 
 	WARN_ON(1);
@@ -4419,18 +4419,18 @@ static int adl_hw_config(struct perf_event *event)
 {
 	struct x86_hybrid_pmu *pmu = hybrid_pmu(event->pmu);
 
-	if (pmu->cpu_type == hybrid_big)
+	if (pmu->pmu_type == hybrid_big)
 		return hsw_hw_config(event);
-	else if (pmu->cpu_type == hybrid_small)
+	else if (pmu->pmu_type == hybrid_small)
 		return intel_pmu_hw_config(event);
 
 	WARN_ON(1);
 	return -EOPNOTSUPP;
 }
 
-static u8 adl_get_hybrid_cpu_type(void)
+static enum hybrid_cpu_type adl_get_hybrid_cpu_type(void)
 {
-	return hybrid_big;
+	return HYBRID_INTEL_CORE;
 }
 
 /*
@@ -4606,22 +4606,47 @@ static void update_pmu_cap(struct x86_hybrid_pmu *pmu)
 	}
 }
 
-static bool init_hybrid_pmu(int cpu)
+static struct x86_hybrid_pmu *find_hybrid_pmu_for_cpu(void)
 {
-	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
 	u8 cpu_type = get_this_hybrid_cpu_type();
-	struct x86_hybrid_pmu *pmu = NULL;
 	int i;
 
-	if (!cpu_type && x86_pmu.get_hybrid_cpu_type)
-		cpu_type = x86_pmu.get_hybrid_cpu_type();
+	/*
+	 * This is running on a CPU model that is known to have hybrid
+	 * configurations. But the CPU told us it is not hybrid, shame
+	 * on it. There should be a fixup function provided for these
+	 * troublesome cpus (->get_hybrid_cpu_type).
+	 */
+	if (cpu_type == HYBRID_INTEL_NONE) {
+		if (x86_pmu.get_hybrid_cpu_type)
+			cpu_type = x86_pmu.get_hybrid_cpu_type();
+		else
+			return NULL;
+	}
 
+	/*
+	 * This essentially just maps between the 'hybrid_cpu_type'
+	 * and 'hybrid_pmu_type' enums:
+	 */
 	for (i = 0; i < x86_pmu.num_hybrid_pmus; i++) {
-		if (x86_pmu.hybrid_pmu[i].cpu_type == cpu_type) {
-			pmu = &x86_pmu.hybrid_pmu[i];
-			break;
-		}
+		enum hybrid_pmu_type pmu_type = x86_pmu.hybrid_pmu[i].pmu_type;
+
+		if (cpu_type == HYBRID_INTEL_CORE &&
+		    pmu_type == hybrid_big)
+			return &x86_pmu.hybrid_pmu[i];
+		if (cpu_type == HYBRID_INTEL_ATOM &&
+		    pmu_type == hybrid_small)
+			return &x86_pmu.hybrid_pmu[i];
 	}
+
+	return NULL;
+}
+
+static bool init_hybrid_pmu(int cpu)
+{
+	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
+	struct x86_hybrid_pmu *pmu = find_hybrid_pmu_for_cpu();
+
 	if (WARN_ON_ONCE(!pmu || (pmu->pmu.type == -1))) {
 		cpuc->pmu = NULL;
 		return false;
@@ -5672,7 +5697,7 @@ static bool is_attr_for_this_pmu(struct kobject *kobj, struct attribute *attr)
 	struct perf_pmu_events_hybrid_attr *pmu_attr =
 		container_of(attr, struct perf_pmu_events_hybrid_attr, attr.attr);
 
-	return pmu->cpu_type & pmu_attr->pmu_type;
+	return pmu->pmu_type & pmu_attr->pmu_type;
 }
 
 static umode_t hybrid_events_is_visible(struct kobject *kobj,
@@ -5709,7 +5734,7 @@ static umode_t hybrid_format_is_visible(struct kobject *kobj,
 		container_of(attr, struct perf_pmu_format_hybrid_attr, attr.attr);
 	int cpu = hybrid_find_supported_cpu(pmu);
 
-	return (cpu >= 0) && (pmu->cpu_type & pmu_attr->pmu_type) ? attr->mode : 0;
+	return (cpu >= 0) && (pmu->pmu_type & pmu_attr->pmu_type) ? attr->mode : 0;
 }
 
 static struct attribute_group hybrid_group_events_td  = {
@@ -6600,7 +6625,7 @@ __init int intel_pmu_init(void)
 		/* Initialize big core specific PerfMon capabilities.*/
 		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_CORE_IDX];
 		pmu->name = "cpu_core";
-		pmu->cpu_type = hybrid_big;
+		pmu->pmu_type = hybrid_big;
 		intel_pmu_init_glc(&pmu->pmu);
 		pmu->late_ack = true;
 		if (cpu_feature_enabled(X86_FEATURE_HYBRID_CPU)) {
@@ -6636,7 +6661,7 @@ __init int intel_pmu_init(void)
 		/* Initialize Atom core specific PerfMon capabilities.*/
 		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_ATOM_IDX];
 		pmu->name = "cpu_atom";
-		pmu->cpu_type = hybrid_small;
+		pmu->pmu_type = hybrid_small;
 		intel_pmu_init_grt(&pmu->pmu);
 		pmu->mid_ack = true;
 		pmu->num_counters = x86_pmu.num_counters;
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 74642469ca7b..bf97ab904d40 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -261,7 +261,7 @@ static u64 __adl_latency_data_small(struct perf_event *event, u64 status,
 {
 	u64 val;
 
-	WARN_ON_ONCE(hybrid_pmu(event->pmu)->cpu_type == hybrid_big);
+	WARN_ON_ONCE(hybrid_pmu(event->pmu)->pmu_type == hybrid_big);
 
 	dse &= PERF_PEBS_DATA_SOURCE_MASK;
 	val = hybrid_var(event->pmu, pebs_data_source)[dse];
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 96a427fc55cf..53dd5d495ba6 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -652,10 +652,29 @@ enum {
 #define PERF_PEBS_DATA_SOURCE_MAX	0x10
 #define PERF_PEBS_DATA_SOURCE_MASK	(PERF_PEBS_DATA_SOURCE_MAX - 1)
 
+enum hybrid_cpu_type {
+	HYBRID_INTEL_NONE,
+	HYBRID_INTEL_ATOM	= 0x20,
+	HYBRID_INTEL_CORE	= 0x40,
+};
+
+enum hybrid_pmu_type {
+	not_hybrid,
+	hybrid_small		= BIT(0),
+	hybrid_big		= BIT(1),
+
+	hybrid_big_small	= hybrid_big | hybrid_small, /* only used for matching */
+};
+
+#define X86_HYBRID_PMU_ATOM_IDX		0
+#define X86_HYBRID_PMU_CORE_IDX		1
+
+#define X86_HYBRID_NUM_PMUS		2
+
 struct x86_hybrid_pmu {
 	struct pmu			pmu;
 	const char			*name;
-	u8				cpu_type;
+	enum hybrid_pmu_type		pmu_type;
 	cpumask_t			supported_cpus;
 	union perf_capabilities		intel_cap;
 	u64				intel_ctrl;
@@ -721,18 +740,6 @@ extern struct static_key_false perf_is_hybrid;
 	__Fp;						\
 })
 
-enum hybrid_pmu_type {
-	hybrid_big		= 0x40,
-	hybrid_small		= 0x20,
-
-	hybrid_big_small	= hybrid_big | hybrid_small,
-};
-
-#define X86_HYBRID_PMU_ATOM_IDX		0
-#define X86_HYBRID_PMU_CORE_IDX		1
-
-#define X86_HYBRID_NUM_PMUS		2
-
 /*
  * struct x86_pmu - generic x86 pmu
  */
@@ -940,7 +947,7 @@ struct x86_pmu {
 	 */
 	int				num_hybrid_pmus;
 	struct x86_hybrid_pmu		*hybrid_pmu;
-	u8 (*get_hybrid_cpu_type)	(void);
+	enum hybrid_cpu_type (*get_hybrid_cpu_type)	(void);
 };
 
 struct x86_perf_task_context_opt {
-- 
2.35.1

