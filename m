Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A485D7C9EAA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 07:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjJPFYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 01:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbjJPFYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 01:24:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 85366A1;
        Sun, 15 Oct 2023 22:24:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC65C2F4;
        Sun, 15 Oct 2023 22:25:24 -0700 (PDT)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.41.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C2D2D3F762;
        Sun, 15 Oct 2023 22:24:41 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC 1/2] arm: perf: Remove PMU locking
Date:   Mon, 16 Oct 2023 10:54:30 +0530
Message-Id: <20231016052431.1390269-2-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231016052431.1390269-1-anshuman.khandual@arm.com>
References: <20231016052431.1390269-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PMU is disabled and enabled, and the counters are programmed from
contexts where interrupts or preemption is disabled.

The functions to toggle the PMU and to program the PMU counters access the
registers directly and don't access data modified by the interrupt handler.
That, and the fact that they're always called from non-preemptible
contexts, means that we don't need to disable interrupts or use a spinlock.

This is very similar to an earlier change on arm64 platform.

commit 2a0e2a02e4b7 ("arm64: perf: Remove PMU locking").

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm/kernel/perf_event_v6.c     | 20 ++++---------
 arch/arm/kernel/perf_event_v7.c     | 44 -----------------------------
 arch/arm/kernel/perf_event_xscale.c | 30 +++++---------------
 3 files changed, 12 insertions(+), 82 deletions(-)

diff --git a/arch/arm/kernel/perf_event_v6.c b/arch/arm/kernel/perf_event_v6.c
index 1ae99deeec54..867b145125fb 100644
--- a/arch/arm/kernel/perf_event_v6.c
+++ b/arch/arm/kernel/perf_event_v6.c
@@ -268,7 +268,7 @@ static inline void armv6pmu_write_counter(struct perf_event *event, u64 value)
 
 static void armv6pmu_enable_event(struct perf_event *event)
 {
-	unsigned long val, mask, evt, flags;
+	unsigned long val, mask, evt;
 	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
 	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
@@ -294,12 +294,10 @@ static void armv6pmu_enable_event(struct perf_event *event)
 	 * Mask out the current event and set the counter to count the event
 	 * that we're interested in.
 	 */
-	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	val = armv6_pmcr_read();
 	val &= ~mask;
 	val |= evt;
 	armv6_pmcr_write(val);
-	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
 static irqreturn_t
@@ -362,26 +360,22 @@ armv6pmu_handle_irq(struct arm_pmu *cpu_pmu)
 
 static void armv6pmu_start(struct arm_pmu *cpu_pmu)
 {
-	unsigned long flags, val;
+	unsigned long val;
 	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
 
-	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	val = armv6_pmcr_read();
 	val |= ARMV6_PMCR_ENABLE;
 	armv6_pmcr_write(val);
-	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
 static void armv6pmu_stop(struct arm_pmu *cpu_pmu)
 {
-	unsigned long flags, val;
+	unsigned long val;
 	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
 
-	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	val = armv6_pmcr_read();
 	val &= ~ARMV6_PMCR_ENABLE;
 	armv6_pmcr_write(val);
-	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
 static int
@@ -419,7 +413,7 @@ static void armv6pmu_clear_event_idx(struct pmu_hw_events *cpuc,
 
 static void armv6pmu_disable_event(struct perf_event *event)
 {
-	unsigned long val, mask, evt, flags;
+	unsigned long val, mask, evt;
 	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
 	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
@@ -444,17 +438,15 @@ static void armv6pmu_disable_event(struct perf_event *event)
 	 * of ETM bus signal assertion cycles. The external reporting should
 	 * be disabled and so this should never increment.
 	 */
-	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	val = armv6_pmcr_read();
 	val &= ~mask;
 	val |= evt;
 	armv6_pmcr_write(val);
-	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
 static void armv6mpcore_pmu_disable_event(struct perf_event *event)
 {
-	unsigned long val, mask, flags, evt = 0;
+	unsigned long val, mask, evt = 0;
 	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
 	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
@@ -475,12 +467,10 @@ static void armv6mpcore_pmu_disable_event(struct perf_event *event)
 	 * Unlike UP ARMv6, we don't have a way of stopping the counters. We
 	 * simply disable the interrupt reporting.
 	 */
-	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	val = armv6_pmcr_read();
 	val &= ~mask;
 	val |= evt;
 	armv6_pmcr_write(val);
-	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
 static int armv6_map_event(struct perf_event *event)
diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index eb2190477da1..c890354b04e9 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -870,10 +870,8 @@ static void armv7_pmnc_dump_regs(struct arm_pmu *cpu_pmu)
 
 static void armv7pmu_enable_event(struct perf_event *event)
 {
-	unsigned long flags;
 	struct hw_perf_event *hwc = &event->hw;
 	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
-	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
 	int idx = hwc->idx;
 
 	if (!armv7_pmnc_counter_valid(cpu_pmu, idx)) {
@@ -886,7 +884,6 @@ static void armv7pmu_enable_event(struct perf_event *event)
 	 * Enable counter and interrupt, and set the counter to count
 	 * the event that we're interested in.
 	 */
-	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 
 	/*
 	 * Disable counter
@@ -910,16 +907,12 @@ static void armv7pmu_enable_event(struct perf_event *event)
 	 * Enable counter
 	 */
 	armv7_pmnc_enable_counter(idx);
-
-	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
 static void armv7pmu_disable_event(struct perf_event *event)
 {
-	unsigned long flags;
 	struct hw_perf_event *hwc = &event->hw;
 	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
-	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
 	int idx = hwc->idx;
 
 	if (!armv7_pmnc_counter_valid(cpu_pmu, idx)) {
@@ -931,7 +924,6 @@ static void armv7pmu_disable_event(struct perf_event *event)
 	/*
 	 * Disable counter and interrupt
 	 */
-	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 
 	/*
 	 * Disable counter
@@ -942,8 +934,6 @@ static void armv7pmu_disable_event(struct perf_event *event)
 	 * Disable interrupt for this counter
 	 */
 	armv7_pmnc_disable_intens(idx);
-
-	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
 static irqreturn_t armv7pmu_handle_irq(struct arm_pmu *cpu_pmu)
@@ -1009,24 +999,14 @@ static irqreturn_t armv7pmu_handle_irq(struct arm_pmu *cpu_pmu)
 
 static void armv7pmu_start(struct arm_pmu *cpu_pmu)
 {
-	unsigned long flags;
-	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
-
-	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	/* Enable all counters */
 	armv7_pmnc_write(armv7_pmnc_read() | ARMV7_PMNC_E);
-	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
 static void armv7pmu_stop(struct arm_pmu *cpu_pmu)
 {
-	unsigned long flags;
-	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
-
-	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	/* Disable all counters */
 	armv7_pmnc_write(armv7_pmnc_read() & ~ARMV7_PMNC_E);
-	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
 static int armv7pmu_get_event_idx(struct pmu_hw_events *cpuc,
@@ -1492,14 +1472,10 @@ static void krait_clearpmu(u32 config_base)
 
 static void krait_pmu_disable_event(struct perf_event *event)
 {
-	unsigned long flags;
 	struct hw_perf_event *hwc = &event->hw;
 	int idx = hwc->idx;
-	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
-	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
 
 	/* Disable counter and interrupt */
-	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 
 	/* Disable counter */
 	armv7_pmnc_disable_counter(idx);
@@ -1512,23 +1488,17 @@ static void krait_pmu_disable_event(struct perf_event *event)
 
 	/* Disable interrupt for this counter */
 	armv7_pmnc_disable_intens(idx);
-
-	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
 static void krait_pmu_enable_event(struct perf_event *event)
 {
-	unsigned long flags;
 	struct hw_perf_event *hwc = &event->hw;
 	int idx = hwc->idx;
-	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
-	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
 
 	/*
 	 * Enable counter and interrupt, and set the counter to count
 	 * the event that we're interested in.
 	 */
-	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 
 	/* Disable counter */
 	armv7_pmnc_disable_counter(idx);
@@ -1548,8 +1518,6 @@ static void krait_pmu_enable_event(struct perf_event *event)
 
 	/* Enable counter */
 	armv7_pmnc_enable_counter(idx);
-
-	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
 static void krait_pmu_reset(void *info)
@@ -1825,14 +1793,10 @@ static void scorpion_clearpmu(u32 config_base)
 
 static void scorpion_pmu_disable_event(struct perf_event *event)
 {
-	unsigned long flags;
 	struct hw_perf_event *hwc = &event->hw;
 	int idx = hwc->idx;
-	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
-	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
 
 	/* Disable counter and interrupt */
-	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 
 	/* Disable counter */
 	armv7_pmnc_disable_counter(idx);
@@ -1845,23 +1809,17 @@ static void scorpion_pmu_disable_event(struct perf_event *event)
 
 	/* Disable interrupt for this counter */
 	armv7_pmnc_disable_intens(idx);
-
-	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
 static void scorpion_pmu_enable_event(struct perf_event *event)
 {
-	unsigned long flags;
 	struct hw_perf_event *hwc = &event->hw;
 	int idx = hwc->idx;
-	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
-	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
 
 	/*
 	 * Enable counter and interrupt, and set the counter to count
 	 * the event that we're interested in.
 	 */
-	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 
 	/* Disable counter */
 	armv7_pmnc_disable_counter(idx);
@@ -1881,8 +1839,6 @@ static void scorpion_pmu_enable_event(struct perf_event *event)
 
 	/* Enable counter */
 	armv7_pmnc_enable_counter(idx);
-
-	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
 static void scorpion_pmu_reset(void *info)
diff --git a/arch/arm/kernel/perf_event_xscale.c b/arch/arm/kernel/perf_event_xscale.c
index f6cdcacfb96d..ba7f6e26c228 100644
--- a/arch/arm/kernel/perf_event_xscale.c
+++ b/arch/arm/kernel/perf_event_xscale.c
@@ -203,7 +203,7 @@ xscale1pmu_handle_irq(struct arm_pmu *cpu_pmu)
 
 static void xscale1pmu_enable_event(struct perf_event *event)
 {
-	unsigned long val, mask, evt, flags;
+	unsigned long val, mask, evt;
 	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
 	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
@@ -229,17 +229,15 @@ static void xscale1pmu_enable_event(struct perf_event *event)
 		return;
 	}
 
-	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	val = xscale1pmu_read_pmnc();
 	val &= ~mask;
 	val |= evt;
 	xscale1pmu_write_pmnc(val);
-	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
 static void xscale1pmu_disable_event(struct perf_event *event)
 {
-	unsigned long val, mask, evt, flags;
+	unsigned long val, mask, evt;
 	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
 	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
@@ -263,12 +261,10 @@ static void xscale1pmu_disable_event(struct perf_event *event)
 		return;
 	}
 
-	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	val = xscale1pmu_read_pmnc();
 	val &= ~mask;
 	val |= evt;
 	xscale1pmu_write_pmnc(val);
-	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
 static int
@@ -300,26 +296,22 @@ static void xscalepmu_clear_event_idx(struct pmu_hw_events *cpuc,
 
 static void xscale1pmu_start(struct arm_pmu *cpu_pmu)
 {
-	unsigned long flags, val;
+	unsigned long val;
 	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
 
-	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	val = xscale1pmu_read_pmnc();
 	val |= XSCALE_PMU_ENABLE;
 	xscale1pmu_write_pmnc(val);
-	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
 static void xscale1pmu_stop(struct arm_pmu *cpu_pmu)
 {
-	unsigned long flags, val;
+	unsigned long val;
 	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
 
-	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	val = xscale1pmu_read_pmnc();
 	val &= ~XSCALE_PMU_ENABLE;
 	xscale1pmu_write_pmnc(val);
-	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
 static inline u64 xscale1pmu_read_counter(struct perf_event *event)
@@ -549,7 +541,7 @@ xscale2pmu_handle_irq(struct arm_pmu *cpu_pmu)
 
 static void xscale2pmu_enable_event(struct perf_event *event)
 {
-	unsigned long flags, ien, evtsel;
+	unsigned long ien, evtsel;
 	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
 	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
@@ -587,10 +579,8 @@ static void xscale2pmu_enable_event(struct perf_event *event)
 		return;
 	}
 
-	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	xscale2pmu_write_event_select(evtsel);
 	xscale2pmu_write_int_enable(ien);
-	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
 static void xscale2pmu_disable_event(struct perf_event *event)
@@ -638,11 +628,9 @@ static void xscale2pmu_disable_event(struct perf_event *event)
 		return;
 	}
 
-	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	xscale2pmu_write_event_select(evtsel);
 	xscale2pmu_write_int_enable(ien);
 	xscale2pmu_write_overflow_flags(of_flags);
-	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
 static int
@@ -663,26 +651,22 @@ xscale2pmu_get_event_idx(struct pmu_hw_events *cpuc,
 
 static void xscale2pmu_start(struct arm_pmu *cpu_pmu)
 {
-	unsigned long flags, val;
+	unsigned long val;
 	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
 
-	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	val = xscale2pmu_read_pmnc() & ~XSCALE_PMU_CNT64;
 	val |= XSCALE_PMU_ENABLE;
 	xscale2pmu_write_pmnc(val);
-	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
 static void xscale2pmu_stop(struct arm_pmu *cpu_pmu)
 {
-	unsigned long flags, val;
+	unsigned long val;
 	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
 
-	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	val = xscale2pmu_read_pmnc();
 	val &= ~XSCALE_PMU_ENABLE;
 	xscale2pmu_write_pmnc(val);
-	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
 static inline u64 xscale2pmu_read_counter(struct perf_event *event)
-- 
2.25.1

