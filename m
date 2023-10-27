Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6397D9988
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 15:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345895AbjJ0NRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 09:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345787AbjJ0NQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 09:16:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E59718A;
        Fri, 27 Oct 2023 06:16:54 -0700 (PDT)
Date:   Fri, 27 Oct 2023 13:16:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698412612;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MBRiQg+l4N0pzNZaLuy2B/7ch/Ow44J63/npJzjB+c8=;
        b=MFUiNYF3gYEBwep4zqCy0ktNN71fF2wPCmjNDozjRstGtvVRQdtIXMdiLaMdjkQIbzhqmH
        orOe7GUpx0O4O5MjdK+d1nhptVhR0+c/WwksDWOMaazgkTnVfWtl8ON2b0c+qyh3sIasEw
        rorjkzvuq/bTib/iwobABY7RWKRYmawXjeXgU9crdFiwUJUDsdbiTIa7WI/7Wmvg5Q7u3x
        ZvYCP/9fb0g2rXra+OW6DegjzEtjFfEhJr8E/1F4G9JdHU33PJOsnYahNv/J8VDbxpFbC7
        IJLeomPK2OwX+asNKsFwamA3bqcuwXAb6eBOyAIqxQk+1V/Us4axjmYjMrj9bw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698412612;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MBRiQg+l4N0pzNZaLuy2B/7ch/Ow44J63/npJzjB+c8=;
        b=AwyR5kGBiVm8qgzDTMF4o5rYuWBZOZA629qV8k9wV5IIE2kDII5dYSjXupMjxlF9m1Rh+h
        /gTED8FejY8ApGBQ==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Add branch stack counters
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231025201626.3000228-1-kan.liang@linux.intel.com>
References: <20231025201626.3000228-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <169841261197.3135.15297996753672595080.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     571d91dcadfa3cef499010b4eddb9b58b0da4d24
Gitweb:        https://git.kernel.org/tip/571d91dcadfa3cef499010b4eddb9b58b0da4d24
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Wed, 25 Oct 2023 13:16:19 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 Oct 2023 15:05:08 +02:00

perf: Add branch stack counters

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
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20231025201626.3000228-1-kan.liang@linux.intel.com
---
 Documentation/ABI/testing/sysfs-bus-event_source-devices-caps |  6 ++-
 arch/powerpc/perf/core-book3s.c                               |  2 +-
 arch/x86/events/amd/core.c                                    |  2 +-
 arch/x86/events/core.c                                        |  2 +-
 arch/x86/events/intel/core.c                                  |  2 +-
 arch/x86/events/intel/ds.c                                    |  4 +-
 include/linux/perf_event.h                                    | 17 ++++++-
 include/uapi/linux/perf_event.h                               | 10 ++++-
 kernel/events/core.c                                          |  8 +++-
 9 files changed, 46 insertions(+), 7 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-caps b/Documentation/ABI/testing/sysfs-bus-event_source-devices-caps
index 8757dcf..a5f506f 100644
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
index 8c1f7de..3c14596 100644
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
index e249765..4ee6390 100644
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
index 40ad142..40c9af1 100644
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
index a08f794..41a1647 100644
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
index bf97ab9..cb3f329 100644
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
index 0367d74..7897ef0 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1139,6 +1139,10 @@ static inline bool branch_sample_priv(const struct perf_event *event)
 	return event->attr.branch_sample_type & PERF_SAMPLE_BRANCH_PRIV_SAVE;
 }
 
+static inline bool branch_sample_counters(const struct perf_event *event)
+{
+	return event->attr.branch_sample_type & PERF_SAMPLE_BRANCH_COUNTERS;
+}
 
 struct perf_sample_data {
 	/*
@@ -1173,6 +1177,7 @@ struct perf_sample_data {
 	struct perf_callchain_entry	*callchain;
 	struct perf_raw_record		*raw;
 	struct perf_branch_stack	*br_stack;
+	u64				*br_stack_cntr;
 	union perf_sample_weight	weight;
 	union  perf_mem_data_src	data_src;
 	u64				txn;
@@ -1250,7 +1255,8 @@ static inline void perf_sample_save_raw_data(struct perf_sample_data *data,
 
 static inline void perf_sample_save_brstack(struct perf_sample_data *data,
 					    struct perf_event *event,
-					    struct perf_branch_stack *brs)
+					    struct perf_branch_stack *brs,
+					    u64 *brs_cntr)
 {
 	int size = sizeof(u64); /* nr */
 
@@ -1258,7 +1264,16 @@ static inline void perf_sample_save_brstack(struct perf_sample_data *data,
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
index 39c6a25..4461f38 100644
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
index 3eb26c2..d27ffd8 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7341,6 +7341,14 @@ void perf_output_sample(struct perf_output_handle *handle,
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
