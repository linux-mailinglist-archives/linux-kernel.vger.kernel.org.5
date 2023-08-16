Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6824877E3C5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 16:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343715AbjHPOhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 10:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343688AbjHPOgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 10:36:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFDD271E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 07:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692196606; x=1723732606;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=at8blr0KZ75lCxrGtLuqBPWOv2BCBtFQbJdxYmV2AYY=;
  b=ALXgkpTsnSbOGL36Hm3XCzLvgPoXr51LJm9Z4HB0tXfQJluQGN9bF2xd
   ++6gvxO750muyMgwodcIMfca7NCUnkjfnFnc14empdxBU2F2pNvlxb8Cv
   3ZUXd31LDIn9r6OBVK3mUxA0DqXfWdLqKCl+E4nSBLx7Va0Jl7tqzk6qv
   Z3VT4rrrzUVMtqg03udMAFITei4Ua5CUp/d7C4y5gL04afgcHfuna5WUE
   M4qFXQlB0ZWRC9lLxfWDP+L2udM+9Es/KAOKBRBMm3zFLrLzQFSlMrkZK
   AmbPV42jq50phTmhizEbsDOndQ6tm1NZTJTCJIFRuqJT9lvtRmm7bmjBX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="352138650"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="352138650"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 07:36:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="980758852"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="980758852"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga006.fm.intel.com with ESMTP; 16 Aug 2023 07:36:43 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, ak@linux.intel.com, eranian@google.com,
        alexey.v.bayduraev@linux.intel.com, tinghao.zhang@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 4/6] perf/x86/intel: Support LBR event logging
Date:   Wed, 16 Aug 2023 07:36:26 -0700
Message-Id: <20230816143628.1885281-4-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230816143628.1885281-1-kan.liang@linux.intel.com>
References: <20230816143628.1885281-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The LBR event logging introduces a per-counter indication of precise
event occurrences in LBRs. It can provide a means to attribute exposed
retirement latency to combinations of events across a block of
instructions. It also provides a means of attributing Timed LBR
latencies to events.

The feature is first introduced on SRF/GRR. It is an enhancement of the
ARCH LBR. It adds new fields in the LBR_INFO MSRs to log the occurrences
of events on the GP counters. The information is displayed by the order
of counters.

The design proposed in this patch requires that the events which are
logged must be in a group with the event that has LBR. If there are
more than one LBR group, the event logging information only from the
current group (overflowed) are stored for the perf tool, otherwise the
perf tool cannot know which and when other groups are scheduled
especially when multiplexing is triggered. The user can ensure it uses
the maximum number of counters that support LBR info (4 by now) by
making the group large enough.

The HW only logs events by the order of counters. The order may be
different from the order of enabling which the perf tool can understand.
When parsing the information of each branch entry, convert the counter
order to the enabled order, and store the enabled order in the extension
space.

Unconditionally reset LBRs for an LBR event group when it's deleted. The
logged events' occurrences information is only valid for the current LBR
group. If another LBR group is scheduled later, the information from the
stale LBRs would be otherwise wrongly interpreted.

Add a sanity check in intel_pmu_hw_config(). Disable the feature if other
counter filters (inv, cmask, edge, in_tx) are set or LBR call stack mode
is enabled. (For the LBR call stack mode, we cannot simply flush the
LBR, since it will break the call stack. Also, there is no obvious usage
with the call stack mode for now.)
Only applying the PERF_SAMPLE_BRANCH_EVT_CNTRS or the
PERF_SAMPLE_BRANCH_EXTRA doesn't require any branch stack setup.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

Changes since V2:
- Drop the SW bit LBR_EVENT_LOG_BIT and flag PERF_X86_EVENT_LBR_EVENT.
  They can be replaced by branch_sample_evt_cntrs() and
  branch_sample_extra().

 arch/x86/events/intel/core.c      | 62 ++++++++++++++++++--
 arch/x86/events/intel/ds.c        |  2 +-
 arch/x86/events/intel/lbr.c       | 94 ++++++++++++++++++++++++++++++-
 arch/x86/events/perf_event.h      |  7 +++
 arch/x86/include/asm/msr-index.h  |  2 +
 arch/x86/include/asm/perf_event.h |  4 ++
 6 files changed, 164 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 8434315b765f..e54f4db89da1 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2803,6 +2803,7 @@ static void intel_pmu_enable_fixed(struct perf_event *event)
 
 static void intel_pmu_enable_event(struct perf_event *event)
 {
+	u64 enable_mask = ARCH_PERFMON_EVENTSEL_ENABLE;
 	struct hw_perf_event *hwc = &event->hw;
 	int idx = hwc->idx;
 
@@ -2811,8 +2812,10 @@ static void intel_pmu_enable_event(struct perf_event *event)
 
 	switch (idx) {
 	case 0 ... INTEL_PMC_IDX_FIXED - 1:
+		if (branch_sample_evt_cntrs(event))
+			enable_mask |= ARCH_PERFMON_EVENTSEL_LBR_LOG;
 		intel_set_masks(event, idx);
-		__x86_pmu_enable_event(hwc, ARCH_PERFMON_EVENTSEL_ENABLE);
+		__x86_pmu_enable_event(hwc, enable_mask);
 		break;
 	case INTEL_PMC_IDX_FIXED ... INTEL_PMC_IDX_FIXED_BTS - 1:
 	case INTEL_PMC_IDX_METRIC_BASE ... INTEL_PMC_IDX_METRIC_END:
@@ -3063,7 +3066,7 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 		perf_sample_data_init(&data, 0, event->hw.last_period);
 
 		if (has_branch_stack(event))
-			perf_sample_save_brstack(&data, event, &cpuc->lbr_stack, NULL);
+			intel_pmu_lbr_save_brstack(&data, cpuc, event);
 
 		if (perf_event_overflow(event, &data, regs))
 			x86_pmu_stop(event, 0);
@@ -3628,6 +3631,13 @@ intel_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 	if (cpuc->excl_cntrs)
 		return intel_get_excl_constraints(cpuc, event, idx, c2);
 
+	/* The LBR event logging may not be available for all counters. */
+	if (branch_sample_evt_cntrs(event)) {
+		c2 = dyn_constraint(cpuc, c2, idx);
+		c2->idxmsk64 &= x86_pmu.lbr_events;
+		c2->weight = hweight64(c2->idxmsk64);
+	}
+
 	return c2;
 }
 
@@ -3916,6 +3926,44 @@ static int intel_pmu_hw_config(struct perf_event *event)
 	if (needs_branch_stack(event) && is_sampling_event(event))
 		event->hw.flags  |= PERF_X86_EVENT_NEEDS_BRANCH_STACK;
 
+	if (branch_sample_evt_cntrs(event) || branch_sample_extra(event)) {
+		struct perf_event *leader, *sibling;
+
+		if (!(x86_pmu.flags & PMU_FL_LBR_EVENT) ||
+		    (event->attr.config & ~INTEL_ARCH_EVENT_MASK))
+			return -EINVAL;
+
+		/*
+		 * The event logging is not supported in the call stack mode
+		 * yet, since we cannot simply flush the LBR during e.g.,
+		 * multiplexing. Also, there is no obvious usage with the call
+		 * stack mode. Simply forbids it for now.
+		 *
+		 * If any events in the group enable the LBR event logging
+		 * feature, the group is treated as a LBR event logging group,
+		 * which requires the extra space.
+		 */
+		leader = event->group_leader;
+		if (branch_sample_call_stack(leader) || !branch_sample_extra(leader))
+			return -EINVAL;
+
+		for_each_sibling_event(sibling, leader) {
+			if (branch_sample_call_stack(sibling) || !branch_sample_extra(leader))
+				return -EINVAL;
+		}
+
+		/*
+		 * Only applying the PERF_SAMPLE_BRANCH_EVT_CNTRS or the
+		 * PERF_SAMPLE_BRANCH_EXTRA doesn't require any branch stack setup.
+		 * Clear the bit to avoid unnecessary branch stack setup.
+		 */
+		if (0 == (event->attr.branch_sample_type &
+			  ~(PERF_SAMPLE_BRANCH_PLM_ALL |
+			    PERF_SAMPLE_BRANCH_EVT_CNTRS |
+			    PERF_SAMPLE_BRANCH_EXTRA)))
+			event->hw.flags  &= ~PERF_X86_EVENT_NEEDS_BRANCH_STACK;
+	}
+
 	if (intel_pmu_needs_branch_stack(event)) {
 		ret = intel_pmu_setup_lbr_filter(event);
 		if (ret)
@@ -4387,8 +4435,12 @@ cmt_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 	 */
 	if (event->attr.precise_ip == 3) {
 		/* Force instruction:ppp on PMC0, 1 and Fixed counter 0 */
-		if (constraint_match(&fixed0_constraint, event->hw.config))
-			return &fixed0_counter0_1_constraint;
+		if (constraint_match(&fixed0_constraint, event->hw.config)) {
+			if (branch_sample_evt_cntrs(event))
+				return &counter0_1_constraint;
+			else
+				return &fixed0_counter0_1_constraint;
+		}
 
 		switch (c->idxmsk64 & 0x3ull) {
 		case 0x1:
@@ -4567,7 +4619,7 @@ int intel_cpuc_prepare(struct cpu_hw_events *cpuc, int cpu)
 			goto err;
 	}
 
-	if (x86_pmu.flags & (PMU_FL_EXCL_CNTRS | PMU_FL_TFA)) {
+	if (x86_pmu.flags & (PMU_FL_EXCL_CNTRS | PMU_FL_TFA | PMU_FL_LBR_EVENT)) {
 		size_t sz = X86_PMC_IDX_MAX * sizeof(struct event_constraint);
 
 		cpuc->constraint_list = kzalloc_node(sz, GFP_KERNEL, cpu_to_node(cpu));
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 7566190389f0..5ff81dbf8aa3 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1912,7 +1912,7 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 
 		if (has_branch_stack(event)) {
 			intel_pmu_store_pebs_lbrs(lbr);
-			perf_sample_save_brstack(data, event, &cpuc->lbr_stack, NULL);
+			intel_pmu_lbr_save_brstack(data, cpuc, event);
 		}
 	}
 
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index c3b0d15a9841..5b7159b9db92 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -676,6 +676,21 @@ void intel_pmu_lbr_del(struct perf_event *event)
 	WARN_ON_ONCE(cpuc->lbr_users < 0);
 	WARN_ON_ONCE(cpuc->lbr_pebs_users < 0);
 	perf_sched_cb_dec(event->pmu);
+
+	/*
+	 * The logged occurrences information is only valid for the
+	 * current LBR group. If another LBR group is scheduled in
+	 * later, the information from the stale LBRs will be wrongly
+	 * interpreted. Reset the LBRs here.
+	 * For the context switch, the LBR will be unconditionally
+	 * flushed when a new task is scheduled in. If both the new task
+	 * and the old task are monitored by a LBR event group. The
+	 * reset here is redundant. But the extra reset doesn't impact
+	 * the functionality. It's hard to distinguish the above case.
+	 * Keep the unconditionally reset for a LBR event group for now.
+	 */
+	if (branch_sample_extra(event))
+		intel_pmu_lbr_reset();
 }
 
 static inline bool vlbr_exclude_host(void)
@@ -866,6 +881,18 @@ static __always_inline u16 get_lbr_cycles(u64 info)
 	return cycles;
 }
 
+static __always_inline void get_lbr_events(struct cpu_hw_events *cpuc,
+					   int i, u64 info)
+{
+	/*
+	 * The later code will decide what content can be disclosed
+	 * to the perf tool. It's no harmful to unconditionally update
+	 * the cpuc->lbr_events.
+	 * Pleae see intel_pmu_lbr_event_reorder()
+	 */
+	cpuc->lbr_events[i] = info & LBR_INFO_EVENTS;
+}
+
 static void intel_pmu_store_lbr(struct cpu_hw_events *cpuc,
 				struct lbr_entry *entries)
 {
@@ -898,11 +925,70 @@ static void intel_pmu_store_lbr(struct cpu_hw_events *cpuc,
 		e->abort	= !!(info & LBR_INFO_ABORT);
 		e->cycles	= get_lbr_cycles(info);
 		e->type		= get_lbr_br_type(info);
+
+		get_lbr_events(cpuc, i, info);
 	}
 
 	cpuc->lbr_stack.nr = i;
 }
 
+#define ARCH_LBR_EVENT_LOG_WIDTH	2
+#define ARCH_LBR_EVENT_LOG_MASK		0x3
+
+static __always_inline void intel_pmu_update_lbr_event(u64 *lbr_events, int idx, int pos)
+{
+	u64 logs = *lbr_events >> (LBR_INFO_EVENTS_OFFSET +
+				   idx * ARCH_LBR_EVENT_LOG_WIDTH);
+
+	logs &= ARCH_LBR_EVENT_LOG_MASK;
+	*lbr_events |= logs << (pos * ARCH_LBR_EVENT_LOG_WIDTH);
+}
+
+/*
+ * The enabled order may be different from the counter order.
+ * Update the lbr_events with the enabled order.
+ */
+static void intel_pmu_lbr_event_reorder(struct cpu_hw_events *cpuc,
+					struct perf_event *event)
+{
+	int i, j, pos = 0, enabled[X86_PMC_IDX_MAX];
+	struct perf_event *leader, *sibling;
+
+	leader = event->group_leader;
+	if (branch_sample_evt_cntrs(leader))
+		enabled[pos++] = leader->hw.idx;
+
+	for_each_sibling_event(sibling, leader) {
+		if (!branch_sample_evt_cntrs(sibling))
+			continue;
+		enabled[pos++] = sibling->hw.idx;
+	}
+
+	if (!pos)
+		return;
+
+	for (i = 0; i < cpuc->lbr_stack.nr; i++) {
+		for (j = 0; j < pos; j++)
+			intel_pmu_update_lbr_event(&cpuc->lbr_events[i], enabled[j], j);
+
+		/* Clear the original counter order */
+		cpuc->lbr_events[i] &= ~LBR_INFO_EVENTS;
+	}
+}
+
+void intel_pmu_lbr_save_brstack(struct perf_sample_data *data,
+				struct cpu_hw_events *cpuc,
+				struct perf_event *event)
+{
+	if (!branch_sample_extra(event)) {
+		perf_sample_save_brstack(data, event, &cpuc->lbr_stack, NULL);
+		return;
+	}
+
+	intel_pmu_lbr_event_reorder(cpuc, event);
+	perf_sample_save_brstack(data, event, &cpuc->lbr_stack, cpuc->lbr_events);
+}
+
 static void intel_pmu_arch_lbr_read(struct cpu_hw_events *cpuc)
 {
 	intel_pmu_store_lbr(cpuc, NULL);
@@ -1173,8 +1259,10 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
 	for (i = 0; i < cpuc->lbr_stack.nr; ) {
 		if (!cpuc->lbr_entries[i].from) {
 			j = i;
-			while (++j < cpuc->lbr_stack.nr)
+			while (++j < cpuc->lbr_stack.nr) {
 				cpuc->lbr_entries[j-1] = cpuc->lbr_entries[j];
+				cpuc->lbr_events[j-1] = cpuc->lbr_events[j];
+			}
 			cpuc->lbr_stack.nr--;
 			if (!cpuc->lbr_entries[i].from)
 				continue;
@@ -1525,8 +1613,12 @@ void __init intel_pmu_arch_lbr_init(void)
 	x86_pmu.lbr_mispred = ecx.split.lbr_mispred;
 	x86_pmu.lbr_timed_lbr = ecx.split.lbr_timed_lbr;
 	x86_pmu.lbr_br_type = ecx.split.lbr_br_type;
+	x86_pmu.lbr_events = ecx.split.lbr_events;
 	x86_pmu.lbr_nr = lbr_nr;
 
+	if (!!x86_pmu.lbr_events)
+		x86_pmu.flags |= PMU_FL_LBR_EVENT;
+
 	if (x86_pmu.lbr_mispred)
 		static_branch_enable(&x86_lbr_mispred);
 	if (x86_pmu.lbr_timed_lbr)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index c8ba2be7585d..4a51253a107c 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -283,6 +283,7 @@ struct cpu_hw_events {
 	int				lbr_pebs_users;
 	struct perf_branch_stack	lbr_stack;
 	struct perf_branch_entry	lbr_entries[MAX_LBR_ENTRIES];
+	u64				lbr_events[MAX_LBR_ENTRIES]; /* branch stack extra */
 	union {
 		struct er_account		*lbr_sel;
 		struct er_account		*lbr_ctl;
@@ -881,6 +882,7 @@ struct x86_pmu {
 	unsigned int	lbr_mispred:1;
 	unsigned int	lbr_timed_lbr:1;
 	unsigned int	lbr_br_type:1;
+	unsigned int	lbr_events:4;
 
 	void		(*lbr_reset)(void);
 	void		(*lbr_read)(struct cpu_hw_events *cpuc);
@@ -1005,6 +1007,7 @@ do {									\
 #define PMU_FL_INSTR_LATENCY	0x80 /* Support Instruction Latency in PEBS Memory Info Record */
 #define PMU_FL_MEM_LOADS_AUX	0x100 /* Require an auxiliary event for the complete memory info */
 #define PMU_FL_RETIRE_LATENCY	0x200 /* Support Retire Latency in PEBS */
+#define PMU_FL_LBR_EVENT	0x400 /* Support LBR event logging */
 
 #define EVENT_VAR(_id)  event_attr_##_id
 #define EVENT_PTR(_id) &event_attr_##_id.attr.attr
@@ -1545,6 +1548,10 @@ void intel_pmu_store_pebs_lbrs(struct lbr_entry *lbr);
 
 void intel_ds_init(void);
 
+void intel_pmu_lbr_save_brstack(struct perf_sample_data *data,
+				struct cpu_hw_events *cpuc,
+				struct perf_event *event);
+
 void intel_pmu_lbr_swap_task_ctx(struct perf_event_pmu_context *prev_epc,
 				 struct perf_event_pmu_context *next_epc);
 
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 3aedae61af4f..d38091cc174a 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -224,6 +224,8 @@
 #define LBR_INFO_CYCLES			0xffff
 #define LBR_INFO_BR_TYPE_OFFSET		56
 #define LBR_INFO_BR_TYPE		(0xfull << LBR_INFO_BR_TYPE_OFFSET)
+#define LBR_INFO_EVENTS_OFFSET		32
+#define LBR_INFO_EVENTS			(0xffull << LBR_INFO_EVENTS_OFFSET)
 
 #define MSR_ARCH_LBR_CTL		0x000014ce
 #define ARCH_LBR_CTL_LBREN		BIT(0)
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 85a9fd5a3ec3..7677605a39ef 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -31,6 +31,7 @@
 #define ARCH_PERFMON_EVENTSEL_ENABLE			(1ULL << 22)
 #define ARCH_PERFMON_EVENTSEL_INV			(1ULL << 23)
 #define ARCH_PERFMON_EVENTSEL_CMASK			0xFF000000ULL
+#define ARCH_PERFMON_EVENTSEL_LBR_LOG			(1ULL << 35)
 
 #define INTEL_FIXED_BITS_MASK				0xFULL
 #define INTEL_FIXED_BITS_STRIDE			4
@@ -216,6 +217,9 @@ union cpuid28_ecx {
 		unsigned int    lbr_timed_lbr:1;
 		/* Branch Type Field Supported */
 		unsigned int    lbr_br_type:1;
+		unsigned int	reserved:13;
+		/* Event Logging Supported */
+		unsigned int	lbr_events:4;
 	} split;
 	unsigned int            full;
 };
-- 
2.35.1

