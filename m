Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B814802F0F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjLDJpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 04:45:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjLDJpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 04:45:22 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DB85CB2;
        Mon,  4 Dec 2023 01:45:27 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E018EFEC;
        Mon,  4 Dec 2023 01:46:14 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.44.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F6443F6C4;
        Mon,  4 Dec 2023 01:45:26 -0800 (PST)
Date:   Mon, 4 Dec 2023 09:45:21 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm: perf: Remove PMU locking
Message-ID: <ZW2fsXX-cTpjm9KA@FVFF77S0Q05N>
References: <20231115092805.737822-1-anshuman.khandual@arm.com>
 <20231115092805.737822-2-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115092805.737822-2-anshuman.khandual@arm.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 02:58:04PM +0530, Anshuman Khandual wrote:
> The PMU is disabled and enabled, and the counters are programmed from
> contexts where interrupts or preemption is disabled.
> 
> The functions to toggle the PMU and to program the PMU counters access the
> registers directly and don't access data modified by the interrupt handler.
> That, and the fact that they're always called from non-preemptible
> contexts, means that we don't need to disable interrupts or use a spinlock.
> 
> This is very similar to an earlier change on arm64 platform.
> 
> commit 2a0e2a02e4b7 ("arm64: perf: Remove PMU locking").

I realise the commit message is a copy of the wording from 2a0e2a02e4b7, but
some of this isn't quite right; could we please replace that with:

| Currently the 32-bit arm PMU drivers use the pmu_hw_events::lock spinlock in
| their arm_pmu::{start,stop,enable,disable}() callbacks to protect hardware
| state and event data.
|
| This locking is not necessary as the perf core code already provides mutual
| exclusion, disabling interrupts to serialize against the IRQ handler, and
| using perf_event_context::lock to protect against concurrent modifications of
| events cross-cpu.
|
| The locking was removed from the arm64 (now PMUv3) PMU driver in commit:
|
|   2a0e2a02e4b7 ("arm64: perf: Remove PMU locking")
|
| ... and the same reasoning applies to all the 32-bit PMU drivers.
|
| Remove the locking from the 32-bit PMU drivers.

With that wording:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: linux-perf-users@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  arch/arm/kernel/perf_event_v6.c     | 28 ++++--------------
>  arch/arm/kernel/perf_event_v7.c     | 44 -----------------------------
>  arch/arm/kernel/perf_event_xscale.c | 44 ++++++-----------------------
>  3 files changed, 13 insertions(+), 103 deletions(-)
> 
> diff --git a/arch/arm/kernel/perf_event_v6.c b/arch/arm/kernel/perf_event_v6.c
> index 1ae99deeec54..8fc080c9e4fb 100644
> --- a/arch/arm/kernel/perf_event_v6.c
> +++ b/arch/arm/kernel/perf_event_v6.c
> @@ -268,10 +268,8 @@ static inline void armv6pmu_write_counter(struct perf_event *event, u64 value)
>  
>  static void armv6pmu_enable_event(struct perf_event *event)
>  {
> -	unsigned long val, mask, evt, flags;
> -	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
> +	unsigned long val, mask, evt;
>  	struct hw_perf_event *hwc = &event->hw;
> -	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
>  	int idx = hwc->idx;
>  
>  	if (ARMV6_CYCLE_COUNTER == idx) {
> @@ -294,12 +292,10 @@ static void armv6pmu_enable_event(struct perf_event *event)
>  	 * Mask out the current event and set the counter to count the event
>  	 * that we're interested in.
>  	 */
> -	raw_spin_lock_irqsave(&events->pmu_lock, flags);
>  	val = armv6_pmcr_read();
>  	val &= ~mask;
>  	val |= evt;
>  	armv6_pmcr_write(val);
> -	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
>  }
>  
>  static irqreturn_t
> @@ -362,26 +358,20 @@ armv6pmu_handle_irq(struct arm_pmu *cpu_pmu)
>  
>  static void armv6pmu_start(struct arm_pmu *cpu_pmu)
>  {
> -	unsigned long flags, val;
> -	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
> +	unsigned long val;
>  
> -	raw_spin_lock_irqsave(&events->pmu_lock, flags);
>  	val = armv6_pmcr_read();
>  	val |= ARMV6_PMCR_ENABLE;
>  	armv6_pmcr_write(val);
> -	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
>  }
>  
>  static void armv6pmu_stop(struct arm_pmu *cpu_pmu)
>  {
> -	unsigned long flags, val;
> -	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
> +	unsigned long val;
>  
> -	raw_spin_lock_irqsave(&events->pmu_lock, flags);
>  	val = armv6_pmcr_read();
>  	val &= ~ARMV6_PMCR_ENABLE;
>  	armv6_pmcr_write(val);
> -	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
>  }
>  
>  static int
> @@ -419,10 +409,8 @@ static void armv6pmu_clear_event_idx(struct pmu_hw_events *cpuc,
>  
>  static void armv6pmu_disable_event(struct perf_event *event)
>  {
> -	unsigned long val, mask, evt, flags;
> -	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
> +	unsigned long val, mask, evt;
>  	struct hw_perf_event *hwc = &event->hw;
> -	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
>  	int idx = hwc->idx;
>  
>  	if (ARMV6_CYCLE_COUNTER == idx) {
> @@ -444,20 +432,16 @@ static void armv6pmu_disable_event(struct perf_event *event)
>  	 * of ETM bus signal assertion cycles. The external reporting should
>  	 * be disabled and so this should never increment.
>  	 */
> -	raw_spin_lock_irqsave(&events->pmu_lock, flags);
>  	val = armv6_pmcr_read();
>  	val &= ~mask;
>  	val |= evt;
>  	armv6_pmcr_write(val);
> -	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
>  }
>  
>  static void armv6mpcore_pmu_disable_event(struct perf_event *event)
>  {
> -	unsigned long val, mask, flags, evt = 0;
> -	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
> +	unsigned long val, mask, evt = 0;
>  	struct hw_perf_event *hwc = &event->hw;
> -	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
>  	int idx = hwc->idx;
>  
>  	if (ARMV6_CYCLE_COUNTER == idx) {
> @@ -475,12 +459,10 @@ static void armv6mpcore_pmu_disable_event(struct perf_event *event)
>  	 * Unlike UP ARMv6, we don't have a way of stopping the counters. We
>  	 * simply disable the interrupt reporting.
>  	 */
> -	raw_spin_lock_irqsave(&events->pmu_lock, flags);
>  	val = armv6_pmcr_read();
>  	val &= ~mask;
>  	val |= evt;
>  	armv6_pmcr_write(val);
> -	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
>  }
>  
>  static int armv6_map_event(struct perf_event *event)
> diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
> index eb2190477da1..c890354b04e9 100644
> --- a/arch/arm/kernel/perf_event_v7.c
> +++ b/arch/arm/kernel/perf_event_v7.c
> @@ -870,10 +870,8 @@ static void armv7_pmnc_dump_regs(struct arm_pmu *cpu_pmu)
>  
>  static void armv7pmu_enable_event(struct perf_event *event)
>  {
> -	unsigned long flags;
>  	struct hw_perf_event *hwc = &event->hw;
>  	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
> -	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
>  	int idx = hwc->idx;
>  
>  	if (!armv7_pmnc_counter_valid(cpu_pmu, idx)) {
> @@ -886,7 +884,6 @@ static void armv7pmu_enable_event(struct perf_event *event)
>  	 * Enable counter and interrupt, and set the counter to count
>  	 * the event that we're interested in.
>  	 */
> -	raw_spin_lock_irqsave(&events->pmu_lock, flags);
>  
>  	/*
>  	 * Disable counter
> @@ -910,16 +907,12 @@ static void armv7pmu_enable_event(struct perf_event *event)
>  	 * Enable counter
>  	 */
>  	armv7_pmnc_enable_counter(idx);
> -
> -	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
>  }
>  
>  static void armv7pmu_disable_event(struct perf_event *event)
>  {
> -	unsigned long flags;
>  	struct hw_perf_event *hwc = &event->hw;
>  	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
> -	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
>  	int idx = hwc->idx;
>  
>  	if (!armv7_pmnc_counter_valid(cpu_pmu, idx)) {
> @@ -931,7 +924,6 @@ static void armv7pmu_disable_event(struct perf_event *event)
>  	/*
>  	 * Disable counter and interrupt
>  	 */
> -	raw_spin_lock_irqsave(&events->pmu_lock, flags);
>  
>  	/*
>  	 * Disable counter
> @@ -942,8 +934,6 @@ static void armv7pmu_disable_event(struct perf_event *event)
>  	 * Disable interrupt for this counter
>  	 */
>  	armv7_pmnc_disable_intens(idx);
> -
> -	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
>  }
>  
>  static irqreturn_t armv7pmu_handle_irq(struct arm_pmu *cpu_pmu)
> @@ -1009,24 +999,14 @@ static irqreturn_t armv7pmu_handle_irq(struct arm_pmu *cpu_pmu)
>  
>  static void armv7pmu_start(struct arm_pmu *cpu_pmu)
>  {
> -	unsigned long flags;
> -	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
> -
> -	raw_spin_lock_irqsave(&events->pmu_lock, flags);
>  	/* Enable all counters */
>  	armv7_pmnc_write(armv7_pmnc_read() | ARMV7_PMNC_E);
> -	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
>  }
>  
>  static void armv7pmu_stop(struct arm_pmu *cpu_pmu)
>  {
> -	unsigned long flags;
> -	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
> -
> -	raw_spin_lock_irqsave(&events->pmu_lock, flags);
>  	/* Disable all counters */
>  	armv7_pmnc_write(armv7_pmnc_read() & ~ARMV7_PMNC_E);
> -	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
>  }
>  
>  static int armv7pmu_get_event_idx(struct pmu_hw_events *cpuc,
> @@ -1492,14 +1472,10 @@ static void krait_clearpmu(u32 config_base)
>  
>  static void krait_pmu_disable_event(struct perf_event *event)
>  {
> -	unsigned long flags;
>  	struct hw_perf_event *hwc = &event->hw;
>  	int idx = hwc->idx;
> -	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
> -	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
>  
>  	/* Disable counter and interrupt */
> -	raw_spin_lock_irqsave(&events->pmu_lock, flags);
>  
>  	/* Disable counter */
>  	armv7_pmnc_disable_counter(idx);
> @@ -1512,23 +1488,17 @@ static void krait_pmu_disable_event(struct perf_event *event)
>  
>  	/* Disable interrupt for this counter */
>  	armv7_pmnc_disable_intens(idx);
> -
> -	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
>  }
>  
>  static void krait_pmu_enable_event(struct perf_event *event)
>  {
> -	unsigned long flags;
>  	struct hw_perf_event *hwc = &event->hw;
>  	int idx = hwc->idx;
> -	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
> -	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
>  
>  	/*
>  	 * Enable counter and interrupt, and set the counter to count
>  	 * the event that we're interested in.
>  	 */
> -	raw_spin_lock_irqsave(&events->pmu_lock, flags);
>  
>  	/* Disable counter */
>  	armv7_pmnc_disable_counter(idx);
> @@ -1548,8 +1518,6 @@ static void krait_pmu_enable_event(struct perf_event *event)
>  
>  	/* Enable counter */
>  	armv7_pmnc_enable_counter(idx);
> -
> -	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
>  }
>  
>  static void krait_pmu_reset(void *info)
> @@ -1825,14 +1793,10 @@ static void scorpion_clearpmu(u32 config_base)
>  
>  static void scorpion_pmu_disable_event(struct perf_event *event)
>  {
> -	unsigned long flags;
>  	struct hw_perf_event *hwc = &event->hw;
>  	int idx = hwc->idx;
> -	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
> -	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
>  
>  	/* Disable counter and interrupt */
> -	raw_spin_lock_irqsave(&events->pmu_lock, flags);
>  
>  	/* Disable counter */
>  	armv7_pmnc_disable_counter(idx);
> @@ -1845,23 +1809,17 @@ static void scorpion_pmu_disable_event(struct perf_event *event)
>  
>  	/* Disable interrupt for this counter */
>  	armv7_pmnc_disable_intens(idx);
> -
> -	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
>  }
>  
>  static void scorpion_pmu_enable_event(struct perf_event *event)
>  {
> -	unsigned long flags;
>  	struct hw_perf_event *hwc = &event->hw;
>  	int idx = hwc->idx;
> -	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
> -	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
>  
>  	/*
>  	 * Enable counter and interrupt, and set the counter to count
>  	 * the event that we're interested in.
>  	 */
> -	raw_spin_lock_irqsave(&events->pmu_lock, flags);
>  
>  	/* Disable counter */
>  	armv7_pmnc_disable_counter(idx);
> @@ -1881,8 +1839,6 @@ static void scorpion_pmu_enable_event(struct perf_event *event)
>  
>  	/* Enable counter */
>  	armv7_pmnc_enable_counter(idx);
> -
> -	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
>  }
>  
>  static void scorpion_pmu_reset(void *info)
> diff --git a/arch/arm/kernel/perf_event_xscale.c b/arch/arm/kernel/perf_event_xscale.c
> index f6cdcacfb96d..7a2ba1c689a7 100644
> --- a/arch/arm/kernel/perf_event_xscale.c
> +++ b/arch/arm/kernel/perf_event_xscale.c
> @@ -203,10 +203,8 @@ xscale1pmu_handle_irq(struct arm_pmu *cpu_pmu)
>  
>  static void xscale1pmu_enable_event(struct perf_event *event)
>  {
> -	unsigned long val, mask, evt, flags;
> -	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
> +	unsigned long val, mask, evt;
>  	struct hw_perf_event *hwc = &event->hw;
> -	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
>  	int idx = hwc->idx;
>  
>  	switch (idx) {
> @@ -229,20 +227,16 @@ static void xscale1pmu_enable_event(struct perf_event *event)
>  		return;
>  	}
>  
> -	raw_spin_lock_irqsave(&events->pmu_lock, flags);
>  	val = xscale1pmu_read_pmnc();
>  	val &= ~mask;
>  	val |= evt;
>  	xscale1pmu_write_pmnc(val);
> -	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
>  }
>  
>  static void xscale1pmu_disable_event(struct perf_event *event)
>  {
> -	unsigned long val, mask, evt, flags;
> -	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
> +	unsigned long val, mask, evt;
>  	struct hw_perf_event *hwc = &event->hw;
> -	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
>  	int idx = hwc->idx;
>  
>  	switch (idx) {
> @@ -263,12 +257,10 @@ static void xscale1pmu_disable_event(struct perf_event *event)
>  		return;
>  	}
>  
> -	raw_spin_lock_irqsave(&events->pmu_lock, flags);
>  	val = xscale1pmu_read_pmnc();
>  	val &= ~mask;
>  	val |= evt;
>  	xscale1pmu_write_pmnc(val);
> -	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
>  }
>  
>  static int
> @@ -300,26 +292,20 @@ static void xscalepmu_clear_event_idx(struct pmu_hw_events *cpuc,
>  
>  static void xscale1pmu_start(struct arm_pmu *cpu_pmu)
>  {
> -	unsigned long flags, val;
> -	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
> +	unsigned long val;
>  
> -	raw_spin_lock_irqsave(&events->pmu_lock, flags);
>  	val = xscale1pmu_read_pmnc();
>  	val |= XSCALE_PMU_ENABLE;
>  	xscale1pmu_write_pmnc(val);
> -	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
>  }
>  
>  static void xscale1pmu_stop(struct arm_pmu *cpu_pmu)
>  {
> -	unsigned long flags, val;
> -	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
> +	unsigned long val;
>  
> -	raw_spin_lock_irqsave(&events->pmu_lock, flags);
>  	val = xscale1pmu_read_pmnc();
>  	val &= ~XSCALE_PMU_ENABLE;
>  	xscale1pmu_write_pmnc(val);
> -	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
>  }
>  
>  static inline u64 xscale1pmu_read_counter(struct perf_event *event)
> @@ -549,10 +535,8 @@ xscale2pmu_handle_irq(struct arm_pmu *cpu_pmu)
>  
>  static void xscale2pmu_enable_event(struct perf_event *event)
>  {
> -	unsigned long flags, ien, evtsel;
> -	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
> +	unsigned long ien, evtsel;
>  	struct hw_perf_event *hwc = &event->hw;
> -	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
>  	int idx = hwc->idx;
>  
>  	ien = xscale2pmu_read_int_enable();
> @@ -587,18 +571,14 @@ static void xscale2pmu_enable_event(struct perf_event *event)
>  		return;
>  	}
>  
> -	raw_spin_lock_irqsave(&events->pmu_lock, flags);
>  	xscale2pmu_write_event_select(evtsel);
>  	xscale2pmu_write_int_enable(ien);
> -	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
>  }
>  
>  static void xscale2pmu_disable_event(struct perf_event *event)
>  {
> -	unsigned long flags, ien, evtsel, of_flags;
> -	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
> +	unsigned long ien, evtsel, of_flags;
>  	struct hw_perf_event *hwc = &event->hw;
> -	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
>  	int idx = hwc->idx;
>  
>  	ien = xscale2pmu_read_int_enable();
> @@ -638,11 +618,9 @@ static void xscale2pmu_disable_event(struct perf_event *event)
>  		return;
>  	}
>  
> -	raw_spin_lock_irqsave(&events->pmu_lock, flags);
>  	xscale2pmu_write_event_select(evtsel);
>  	xscale2pmu_write_int_enable(ien);
>  	xscale2pmu_write_overflow_flags(of_flags);
> -	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
>  }
>  
>  static int
> @@ -663,26 +641,20 @@ xscale2pmu_get_event_idx(struct pmu_hw_events *cpuc,
>  
>  static void xscale2pmu_start(struct arm_pmu *cpu_pmu)
>  {
> -	unsigned long flags, val;
> -	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
> +	unsigned long val;
>  
> -	raw_spin_lock_irqsave(&events->pmu_lock, flags);
>  	val = xscale2pmu_read_pmnc() & ~XSCALE_PMU_CNT64;
>  	val |= XSCALE_PMU_ENABLE;
>  	xscale2pmu_write_pmnc(val);
> -	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
>  }
>  
>  static void xscale2pmu_stop(struct arm_pmu *cpu_pmu)
>  {
> -	unsigned long flags, val;
> -	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
> +	unsigned long val;
>  
> -	raw_spin_lock_irqsave(&events->pmu_lock, flags);
>  	val = xscale2pmu_read_pmnc();
>  	val &= ~XSCALE_PMU_ENABLE;
>  	xscale2pmu_write_pmnc(val);
> -	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
>  }
>  
>  static inline u64 xscale2pmu_read_counter(struct perf_event *event)
> -- 
> 2.25.1
> 
