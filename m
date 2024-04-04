Return-Path: <linux-kernel+bounces-131563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD9F898993
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4301628A54B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2ED412DD99;
	Thu,  4 Apr 2024 14:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M4ilw87K"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEEB12BF06
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 14:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712239670; cv=none; b=uxV2SQQTvajxFcY2IYNUEtfq4BqjtoFh5mgmajRC7oKl5L4tS1Y94ulNq4IS9MtGAJ55aObA9gRMfIR77HOcwmA6pCjXU5MZ8KAedrO/IR3fjJ67WLRDUhEWW/weCvJL/2FI77bzbgegqpKe5iWS7VilcM37DAjQUUIvDXKhTLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712239670; c=relaxed/simple;
	bh=2gmo/fpy1sUeMxYRU8IRq5WeNfc6Xtl1euu28QI9R3E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dyPd+bDYtxuONvmYD8QYdjbuae+iYP47BQ10Gkc2075zpEZ0dh/WiPutsEtN9+Hps9eMUPI3CoNUNYPRWzREejly9HgQ0sD9FYzq2SNtWFlA6S6aEJbB14wPE/NShQT6lVbhxe0JRcIu/zhXRgL29OXBSdnZ8qjZVHMo2lQuhrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M4ilw87K; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712239668; x=1743775668;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2gmo/fpy1sUeMxYRU8IRq5WeNfc6Xtl1euu28QI9R3E=;
  b=M4ilw87K6RJZQMRzcM5oxF0OQa6OqqF0ERTk/QuzMbquJxeRlnMo5VAW
   VfnOYJHuXSQpJ+vYE9H87elPvyolpsfD1bEsuYlz2yO62cN6aFXpttpWw
   lNUGmsQvTPs+9alI8S02rxhbQivICagvz28WpAusKnxyq5JTG5yMNOZtD
   QQg8CzfkIpLfdLQpNjGtjZcEEXpKvhxXXNwxv6xHX82zQ1ftpKATLWSkX
   lncIBpqI9uFk424tFvbzGkRjtZI0oFQ/lOCqqhbaJCA1gtNJXYXRl89ln
   Nad5uD7b3uRiT/01KaathguMclr6Y/XU/sOFfaf04geLutBjuj3tbXoKj
   w==;
X-CSE-ConnectionGUID: 5CiwRZZuQOaU4q/FKfH9Zw==
X-CSE-MsgGUID: viF2w3iFQqqxjnhZrk1k0g==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="11346545"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="11346545"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 07:07:48 -0700
X-CSE-ConnectionGUID: 2Q4vSjHoRLWECwKBLFlANQ==
X-CSE-MsgGUID: tXt0CLPQSAWwcuzZatA2ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="23258901"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa005.fm.intel.com with ESMTP; 04 Apr 2024 07:07:47 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	linux-kernel@vger.kernel.org
Cc: ak@linux.intel.com,
	Kan Liang <kan.liang@linux.intel.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	silviazhao <silviazhao-oc@zhaoxin.com>,
	CodyYao-oc <CodyYao-oc@zhaoxin.com>
Subject: [PATCH 08/12] perf/x86: Extend event update interface
Date: Thu,  4 Apr 2024 07:06:33 -0700
Message-Id: <20240404140637.1232635-9-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20240404140637.1232635-1-kan.liang@linux.intel.com>
References: <20240404140637.1232635-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The current event update interface directly reads the values from the
counter, but the values may not be the accurate ones users require. For
example, the sample read feature wants the counter value of the member
events when the leader event is overflow. But with the current
implementation, the read (event update) actually happens in the NMI
handler. There may be a small gap between the overflow and the NMI
handler. The new Intel PEBS counters snapshotting feature can provide
the accurate counter value in the overflow. The event update interface
has to be updated to apply the given accurate values.

Pass the accurate values via the event update interface. If the value is
not available, still directly read the counter.

For some cases, e.g., intel_update_topdown_event, there could be more
than one counter/register are read. Using u64 * rather than u64 as the
new parameter.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: Sandipan Das <sandipan.das@amd.com>
Cc: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: silviazhao <silviazhao-oc@zhaoxin.com>
Cc: CodyYao-oc <CodyYao-oc@zhaoxin.com>
---
 arch/x86/events/amd/core.c     |  2 +-
 arch/x86/events/core.c         | 13 ++++++-----
 arch/x86/events/intel/core.c   | 40 +++++++++++++++++++---------------
 arch/x86/events/intel/p4.c     |  2 +-
 arch/x86/events/perf_event.h   |  4 ++--
 arch/x86/events/zhaoxin/core.c |  2 +-
 6 files changed, 36 insertions(+), 27 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 281273fbf621..d758d081520b 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -924,7 +924,7 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
 
 		event = cpuc->events[idx];
 		hwc = &event->hw;
-		x86_perf_event_update(event);
+		x86_perf_event_update(event, NULL);
 		mask = BIT_ULL(idx);
 
 		if (!(status & mask))
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 5380f7a84840..befb2f2e55b9 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -112,7 +112,7 @@ u64 __read_mostly hw_cache_extra_regs
  * Can only be executed on the CPU where the event is active.
  * Returns the delta events processed.
  */
-u64 x86_perf_event_update(struct perf_event *event)
+u64 x86_perf_event_update(struct perf_event *event, u64 *val)
 {
 	struct hw_perf_event *hwc = &event->hw;
 	int shift = 64 - x86_pmu.cntval_bits;
@@ -131,7 +131,10 @@ u64 x86_perf_event_update(struct perf_event *event)
 	 */
 	prev_raw_count = local64_read(&hwc->prev_count);
 	do {
-		rdpmcl(hwc->event_base_rdpmc, new_raw_count);
+		if (!val)
+			rdpmcl(hwc->event_base_rdpmc, new_raw_count);
+		else
+			new_raw_count = *val;
 	} while (!local64_try_cmpxchg(&hwc->prev_count,
 				      &prev_raw_count, new_raw_count));
 
@@ -1598,7 +1601,7 @@ void x86_pmu_stop(struct perf_event *event, int flags)
 		 * Drain the remaining delta count out of a event
 		 * that we are disabling:
 		 */
-		static_call(x86_pmu_update)(event);
+		static_call(x86_pmu_update)(event, NULL);
 		hwc->state |= PERF_HES_UPTODATE;
 	}
 }
@@ -1688,7 +1691,7 @@ int x86_pmu_handle_irq(struct pt_regs *regs)
 
 		event = cpuc->events[idx];
 
-		val = static_call(x86_pmu_update)(event);
+		val = static_call(x86_pmu_update)(event, NULL);
 		if (val & (1ULL << (x86_pmu.cntval_bits - 1)))
 			continue;
 
@@ -2035,7 +2038,7 @@ static void x86_pmu_static_call_update(void)
 
 static void _x86_pmu_read(struct perf_event *event)
 {
-	static_call(x86_pmu_update)(event);
+	static_call(x86_pmu_update)(event, NULL);
 }
 
 void x86_pmu_show_pmu_cap(struct pmu *pmu)
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index f9eccdf6eea6..5e0d22e5681d 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2418,7 +2418,7 @@ static void intel_pmu_nhm_workaround(void)
 	for (i = 0; i < 4; i++) {
 		event = cpuc->events[i];
 		if (event)
-			static_call(x86_pmu_update)(event);
+			static_call(x86_pmu_update)(event, NULL);
 	}
 
 	for (i = 0; i < 4; i++) {
@@ -2710,7 +2710,7 @@ static void update_saved_topdown_regs(struct perf_event *event, u64 slots,
  * modify by a NMI. PMU has to be disabled before calling this function.
  */
 
-static u64 intel_update_topdown_event(struct perf_event *event, int metric_end)
+static u64 intel_update_topdown_event(struct perf_event *event, int metric_end, u64 *val)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct perf_event *other;
@@ -2718,13 +2718,18 @@ static u64 intel_update_topdown_event(struct perf_event *event, int metric_end)
 	bool reset = true;
 	int idx;
 
-	/* read Fixed counter 3 */
-	rdpmcl((3 | INTEL_PMC_FIXED_RDPMC_BASE), slots);
-	if (!slots)
-		return 0;
+	if (!val) {
+		/* read Fixed counter 3 */
+		rdpmcl((3 | INTEL_PMC_FIXED_RDPMC_BASE), slots);
+		if (!slots)
+			return 0;
 
-	/* read PERF_METRICS */
-	rdpmcl(INTEL_PMC_FIXED_RDPMC_METRICS, metrics);
+		/* read PERF_METRICS */
+		rdpmcl(INTEL_PMC_FIXED_RDPMC_METRICS, metrics);
+	} else {
+		slots = val[0];
+		metrics = val[1];
+	}
 
 	for_each_set_bit(idx, cpuc->active_mask, metric_end + 1) {
 		if (!is_topdown_idx(idx))
@@ -2767,10 +2772,11 @@ static u64 intel_update_topdown_event(struct perf_event *event, int metric_end)
 	return slots;
 }
 
-static u64 icl_update_topdown_event(struct perf_event *event)
+static u64 icl_update_topdown_event(struct perf_event *event, u64 *val)
 {
 	return intel_update_topdown_event(event, INTEL_PMC_IDX_METRIC_BASE +
-						 x86_pmu.num_topdown_events - 1);
+						 x86_pmu.num_topdown_events - 1,
+					  val);
 }
 
 DEFINE_STATIC_CALL(intel_pmu_update_topdown_event, x86_perf_event_update);
@@ -2785,7 +2791,7 @@ static void intel_pmu_read_topdown_event(struct perf_event *event)
 		return;
 
 	perf_pmu_disable(event->pmu);
-	static_call(intel_pmu_update_topdown_event)(event);
+	static_call(intel_pmu_update_topdown_event)(event, NULL);
 	perf_pmu_enable(event->pmu);
 }
 
@@ -2796,7 +2802,7 @@ static void intel_pmu_read_event(struct perf_event *event)
 	else if (is_topdown_count(event))
 		intel_pmu_read_topdown_event(event);
 	else
-		x86_perf_event_update(event);
+		x86_perf_event_update(event, NULL);
 }
 
 static void intel_pmu_enable_fixed(struct perf_event *event)
@@ -2899,7 +2905,7 @@ static void intel_pmu_add_event(struct perf_event *event)
  */
 int intel_pmu_save_and_restart(struct perf_event *event)
 {
-	static_call(x86_pmu_update)(event);
+	static_call(x86_pmu_update)(event, NULL);
 	/*
 	 * For a checkpointed counter always reset back to 0.  This
 	 * avoids a situation where the counter overflows, aborts the
@@ -2922,12 +2928,12 @@ static int intel_pmu_set_period(struct perf_event *event)
 	return x86_perf_event_set_period(event);
 }
 
-static u64 intel_pmu_update(struct perf_event *event)
+static u64 intel_pmu_update(struct perf_event *event, u64 *val)
 {
 	if (unlikely(is_topdown_count(event)))
-		return static_call(intel_pmu_update_topdown_event)(event);
+		return static_call(intel_pmu_update_topdown_event)(event, val);
 
-	return x86_perf_event_update(event);
+	return x86_perf_event_update(event, val);
 }
 
 static void intel_pmu_reset(void)
@@ -3091,7 +3097,7 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 	 */
 	if (__test_and_clear_bit(GLOBAL_STATUS_PERF_METRICS_OVF_BIT, (unsigned long *)&status)) {
 		handled++;
-		static_call(intel_pmu_update_topdown_event)(NULL);
+		static_call(intel_pmu_update_topdown_event)(NULL, NULL);
 	}
 
 	/*
diff --git a/arch/x86/events/intel/p4.c b/arch/x86/events/intel/p4.c
index 844bc4fc4724..3177be0dedd1 100644
--- a/arch/x86/events/intel/p4.c
+++ b/arch/x86/events/intel/p4.c
@@ -1058,7 +1058,7 @@ static int p4_pmu_handle_irq(struct pt_regs *regs)
 		/* it might be unflagged overflow */
 		overflow = p4_pmu_clear_cccr_ovf(hwc);
 
-		val = x86_perf_event_update(event);
+		val = x86_perf_event_update(event, NULL);
 		if (!overflow && (val & (1ULL << (x86_pmu.cntval_bits - 1))))
 			continue;
 
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index ebfa5eb75cd2..7f0544fe2444 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -782,7 +782,7 @@ struct x86_pmu {
 	void		(*del)(struct perf_event *);
 	void		(*read)(struct perf_event *event);
 	int		(*set_period)(struct perf_event *event);
-	u64		(*update)(struct perf_event *event);
+	u64		(*update)(struct perf_event *event, u64 *val);
 	int		(*hw_config)(struct perf_event *event);
 	int		(*schedule_events)(struct cpu_hw_events *cpuc, int n, int *assign);
 	unsigned	eventsel;
@@ -1131,7 +1131,7 @@ extern u64 __read_mostly hw_cache_extra_regs
 				[PERF_COUNT_HW_CACHE_OP_MAX]
 				[PERF_COUNT_HW_CACHE_RESULT_MAX];
 
-u64 x86_perf_event_update(struct perf_event *event);
+u64 x86_perf_event_update(struct perf_event *event, u64 *cntr);
 
 static inline unsigned int x86_pmu_config_addr(int index)
 {
diff --git a/arch/x86/events/zhaoxin/core.c b/arch/x86/events/zhaoxin/core.c
index 2fd9b0cf9a5e..5fe3a9eed650 100644
--- a/arch/x86/events/zhaoxin/core.c
+++ b/arch/x86/events/zhaoxin/core.c
@@ -391,7 +391,7 @@ static int zhaoxin_pmu_handle_irq(struct pt_regs *regs)
 		if (!test_bit(bit, cpuc->active_mask))
 			continue;
 
-		x86_perf_event_update(event);
+		x86_perf_event_update(event, NULL);
 		perf_sample_data_init(&data, 0, event->hw.last_period);
 
 		if (!x86_perf_event_set_period(event))
-- 
2.35.1


