Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3907B8AD3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 20:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243722AbjJDSkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 14:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243683AbjJDSks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:40:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7CEF98
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 11:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696444844; x=1727980844;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kxZg7pM+ZgTIS+2pCslTI1nBxg1AM3SNhCsGF5a1yr8=;
  b=hoQqEAcx/83yGy0WXrMAhg5Gb3FgZh+FR/ie/nshv+Bn4OFKGweWGBcR
   yyKul2iWjO9jMwMHtGIoNhv+Qifab0GbYpkhmpMFrkKhfGo5Hp1vL0rWj
   qHYTJlss8NPO3Ll1OkwrqrjB3EAZxSyspirHFznrAxnDRI5MSvEY71nRq
   B77NIhmOX+Nw8GrJyTg6afJE5dRqkEg62rb60/17tuHuPBPPyVIOA/ACw
   LUfxRZCUQv1vGrPd7CFk1dox9DDCrQ2jSac8qBOXvPOHvxZP+6Cg1+ex1
   5rRu445RHbgqZQ0icWzjo3QCW7OBgW4Eh2XxTdtj2b0IH9MBNszTElZTF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="469537675"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="469537675"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 11:40:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="786625985"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="786625985"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga001.jf.intel.com with ESMTP; 04 Oct 2023 11:40:41 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, ak@linux.intel.com, eranian@google.com,
        alexey.v.bayduraev@linux.intel.com, tinghao.zhang@intel.com,
        Kan Liang <kan.liang@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: [PATCH V4 1/7] perf: Add branch stack counters
Date:   Wed,  4 Oct 2023 11:40:38 -0700
Message-Id: <20231004184044.3062788-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
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

Currently, the additional information of a branch entry is stored in a
u64 space. With more and more information added, the space is running
out. For example, the information of occurrences of events will be added
for each branch.

Two places were suggested to append the counters.
https://lore.kernel.org/lkml/20230802215814.GH231007@hirez.programming.kicks-ass.net/
One place is right after the flags of each branch entry. It changes the
existing struct perf_branch_entry. The later ARCH specific
implementation has to be really careful to consistently pick
the right struct.
The other place is right after the entire struct perf_branch_stack.
The disadvantage is that the pointer of the extra space has to be
recorded. The common interface perf_sample_save_brstack() has to be
updated.

The latter is much straightforward, and should be easily understood and
maintained. It is implemented in the patch.

Add a new branch sample type, PERF_SAMPLE_BRANCH_COUNTERS, to indicate
the event which is recorded in the branch info.

The "u64 counters" may store the occurrences of several events. The
information regarding the number of events/counters and the width of
each counter should be exposed via sysfs as a reference for the perf
tool. Define the branch_counter_nr and branch_counter_width ABI here.
The support will be implemented later in the Intel-specific patch.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: Sandipan Das <sandipan.das@amd.com>
Cc: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
---

Changes since V3:
- Add a new branch sample type, PERF_SAMPLE_BRANCH_COUNTERS
  Drop the two  branch sample type in V2.
- Add the branch_counter_nr and branch_counter_width ABI

 .../testing/sysfs-bus-event_source-devices-caps |  6 ++++++
 arch/powerpc/perf/core-book3s.c                 |  2 +-
 arch/x86/events/amd/core.c                      |  2 +-
 arch/x86/events/core.c                          |  2 +-
 arch/x86/events/intel/core.c                    |  2 +-
 arch/x86/events/intel/ds.c                      |  4 ++--
 include/linux/perf_event.h                      | 17 ++++++++++++++++-
 include/uapi/linux/perf_event.h                 | 10 ++++++++++
 kernel/events/core.c                            |  8 ++++++++
 9 files changed, 46 insertions(+), 7 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-caps b/Documentation/ABI/testing/sysfs-bus-event_source-devices-caps
index 8757dcf41c08..451f0c620aa7 100644
--- a/Documentation/ABI/testing/sysfs-bus-event_source-devices-caps
+++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-caps
@@ -16,3 +16,9 @@ Description:
 		Example output in powerpc:
 		grep . /sys/bus/event_source/devices/cpu/caps/*
 		/sys/bus/event_source/devices/cpu/caps/pmu_name:POWER9
+
+		The "branch_counter_nr" in the supported platform exposes the
+		maximum number of counters which can be shown in the u64 counters
+		of PERF_SAMPLE_BRANCH_COUNTERS, while the "branch_counter_width"
+		exposes the width of each counter. Both of them can be used by
+		the perf tool to parse the logged counters in each branch.
diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 8c1f7def596e..3c14596bbfaf 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -2313,7 +2313,7 @@ static void record_and_restart(struct perf_event *event, unsigned long val,
 			struct cpu_hw_events *cpuhw;
 			cpuhw = this_cpu_ptr(&cpu_hw_events);
 			power_pmu_bhrb_read(event, cpuhw);
-			perf_sample_save_brstack(&data, event, &cpuhw->bhrb_stack);
+			perf_sample_save_brstack(&data, event, &cpuhw->bhrb_stack, NULL);
 		}
 
 		if (event->attr.sample_type & PERF_SAMPLE_DATA_SRC &&
diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index e24976593a29..4ee6390b45c9 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -940,7 +940,7 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
 			continue;
 
 		if (has_branch_stack(event))
-			perf_sample_save_brstack(&data, event, &cpuc->lbr_stack);
+			perf_sample_save_brstack(&data, event, &cpuc->lbr_stack, NULL);
 
 		if (perf_event_overflow(event, &data, regs))
 			x86_pmu_stop(event, 0);
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 40ad1425ffa2..40c9af124128 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1702,7 +1702,7 @@ int x86_pmu_handle_irq(struct pt_regs *regs)
 		perf_sample_data_init(&data, 0, event->hw.last_period);
 
 		if (has_branch_stack(event))
-			perf_sample_save_brstack(&data, event, &cpuc->lbr_stack);
+			perf_sample_save_brstack(&data, event, &cpuc->lbr_stack, NULL);
 
 		if (perf_event_overflow(event, &data, regs))
 			x86_pmu_stop(event, 0);
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index a08f794a0e79..41a164764a84 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3047,7 +3047,7 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 		perf_sample_data_init(&data, 0, event->hw.last_period);
 
 		if (has_branch_stack(event))
-			perf_sample_save_brstack(&data, event, &cpuc->lbr_stack);
+			perf_sample_save_brstack(&data, event, &cpuc->lbr_stack, NULL);
 
 		if (perf_event_overflow(event, &data, regs))
 			x86_pmu_stop(event, 0);
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index bf97ab904d40..cb3f329f8fa4 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1755,7 +1755,7 @@ static void setup_pebs_fixed_sample_data(struct perf_event *event,
 		setup_pebs_time(event, data, pebs->tsc);
 
 	if (has_branch_stack(event))
-		perf_sample_save_brstack(data, event, &cpuc->lbr_stack);
+		perf_sample_save_brstack(data, event, &cpuc->lbr_stack, NULL);
 }
 
 static void adaptive_pebs_save_regs(struct pt_regs *regs,
@@ -1912,7 +1912,7 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 
 		if (has_branch_stack(event)) {
 			intel_pmu_store_pebs_lbrs(lbr);
-			perf_sample_save_brstack(data, event, &cpuc->lbr_stack);
+			perf_sample_save_brstack(data, event, &cpuc->lbr_stack, NULL);
 		}
 	}
 
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index e85cd1c0eaf3..9ad79f8107cb 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1138,6 +1138,10 @@ static inline bool branch_sample_priv(const struct perf_event *event)
 	return event->attr.branch_sample_type & PERF_SAMPLE_BRANCH_PRIV_SAVE;
 }
 
+static inline bool branch_sample_counters(const struct perf_event *event)
+{
+	return event->attr.branch_sample_type & PERF_SAMPLE_BRANCH_COUNTERS;
+}
 
 struct perf_sample_data {
 	/*
@@ -1172,6 +1176,7 @@ struct perf_sample_data {
 	struct perf_callchain_entry	*callchain;
 	struct perf_raw_record		*raw;
 	struct perf_branch_stack	*br_stack;
+	u64				*br_stack_cntr;
 	union perf_sample_weight	weight;
 	union  perf_mem_data_src	data_src;
 	u64				txn;
@@ -1249,7 +1254,8 @@ static inline void perf_sample_save_raw_data(struct perf_sample_data *data,
 
 static inline void perf_sample_save_brstack(struct perf_sample_data *data,
 					    struct perf_event *event,
-					    struct perf_branch_stack *brs)
+					    struct perf_branch_stack *brs,
+					    u64 *brs_cntr)
 {
 	int size = sizeof(u64); /* nr */
 
@@ -1257,7 +1263,16 @@ static inline void perf_sample_save_brstack(struct perf_sample_data *data,
 		size += sizeof(u64);
 	size += brs->nr * sizeof(struct perf_branch_entry);
 
+	/*
+	 * The extension space for counters is appended after the
+	 * struct perf_branch_stack. It is used to store the occurrences
+	 * of events of each branch.
+	 */
+	if (brs_cntr)
+		size += brs->nr * sizeof(u64);
+
 	data->br_stack = brs;
+	data->br_stack_cntr = brs_cntr;
 	data->dyn_size += size;
 	data->sample_flags |= PERF_SAMPLE_BRANCH_STACK;
 }
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 39c6a250dd1b..4461f380425b 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -204,6 +204,8 @@ enum perf_branch_sample_type_shift {
 
 	PERF_SAMPLE_BRANCH_PRIV_SAVE_SHIFT	= 18, /* save privilege mode */
 
+	PERF_SAMPLE_BRANCH_COUNTERS_SHIFT	= 19, /* save occurrences of events on a branch */
+
 	PERF_SAMPLE_BRANCH_MAX_SHIFT		/* non-ABI */
 };
 
@@ -235,6 +237,8 @@ enum perf_branch_sample_type {
 
 	PERF_SAMPLE_BRANCH_PRIV_SAVE	= 1U << PERF_SAMPLE_BRANCH_PRIV_SAVE_SHIFT,
 
+	PERF_SAMPLE_BRANCH_COUNTERS	= 1U << PERF_SAMPLE_BRANCH_COUNTERS_SHIFT,
+
 	PERF_SAMPLE_BRANCH_MAX		= 1U << PERF_SAMPLE_BRANCH_MAX_SHIFT,
 };
 
@@ -982,6 +986,12 @@ enum perf_event_type {
 	 *	{ u64                   nr;
 	 *	  { u64	hw_idx; } && PERF_SAMPLE_BRANCH_HW_INDEX
 	 *        { u64 from, to, flags } lbr[nr];
+	 *        #
+	 *        # The format of the counters is decided by the
+	 *        # "branch_counter_nr" and "branch_counter_width",
+	 *        # which are defined in the ABI.
+	 *        #
+	 *        { u64 counters; } cntr[nr] && PERF_SAMPLE_BRANCH_COUNTERS
 	 *      } && PERF_SAMPLE_BRANCH_STACK
 	 *
 	 * 	{ u64			abi; # enum perf_sample_regs_abi
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 41e28f64a4a9..56b08ffeed2f 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7336,6 +7336,14 @@ void perf_output_sample(struct perf_output_handle *handle,
 			if (branch_sample_hw_index(event))
 				perf_output_put(handle, data->br_stack->hw_idx);
 			perf_output_copy(handle, data->br_stack->entries, size);
+			/*
+			 * Add the extension space which is appended
+			 * right after the struct perf_branch_stack.
+			 */
+			if (data->br_stack_cntr) {
+				size = data->br_stack->nr * sizeof(u64);
+				perf_output_copy(handle, data->br_stack_cntr, size);
+			}
 		} else {
 			/*
 			 * we always store at least the value of nr
-- 
2.35.1

