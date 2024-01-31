Return-Path: <linux-kernel+bounces-46596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1998441C8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E656228BD26
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86C58289F;
	Wed, 31 Jan 2024 14:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D39H2NH7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A7784A47;
	Wed, 31 Jan 2024 14:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706711050; cv=none; b=CmwgRphocTUoRu7Ble+vmiE3mpB/Wgh27ZvWeQwYFTcArWyarqd/zBOvDPNXCHhOB9c7qM1tGZ4vZHH8sBaUqJi3cUIE4FirfM05S2H9sOVik6hn1Y1BoVoQQ7y9Fq6AHmPFdfceUX/Eg/40qO27+RnLOFybLdTP2ovzZiK5zEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706711050; c=relaxed/simple;
	bh=zFbrDHjMoBgUim1lK6ftm8LbXXs0k4K2Fz9zYDcRkQM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k0Aoh4cCC3OYtVWcDewxpFSnynFOOzIQy9/XrSaer7SyGt6uu1Xqn0V1bHAqwSEExGlCSwzDrhrbN9DqLGHClksnsPLw78S0DCMIhY2Y9l68iWWZvj5tNXhCXE6zW9sRNb+j1Z1RlFV2O0fiip0dXdgq6UMy6Qb17krQHDUu+10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D39H2NH7; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706711047; x=1738247047;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zFbrDHjMoBgUim1lK6ftm8LbXXs0k4K2Fz9zYDcRkQM=;
  b=D39H2NH7wH7HFtMb9pm3nttDfz4UiQlFUo+dX7WlHKyTgZUDg3Azga8V
   PDrOS/1as7+iiT/3mnCDL+pD9PlhBHUe/o7dSYQ5aMSS2DSM6ZD4+H0V7
   ARPpc8nt15+T1+88SmtiTJ2+3ZrA5BJKcd2KzsEpDOAaRKPZJIMTXU0/m
   udOxSOeGOw+ma8hSjw9gKag4f8VuF3zdP6OsvrdQbTi847YB0bpduF9dC
   6HnI1wkATh24qp7i18Lh1AlI5anXGVjI5QeUmFKL/RGtnkHbtRErlcSrZ
   AdR9GZlJpIkSqW9N3/CLlFqFwrAC5kumobtWphfiqHi6D0Le5cMnwt05Y
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10995860"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="10995860"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 06:24:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="4068779"
Received: from puhongt-mobl2.ccr.corp.intel.com (HELO rzhang1-mobl7.ccr.corp.intel.com) ([10.255.29.147])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 06:24:02 -0800
From: Zhang Rui <rui.zhang@intel.com>
To: rafael.j.wysocki@intel.com,
	peterz@infradead.org
Cc: mingo@redhat.com,
	kan.liang@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH 5/5] powercap: intel_rapl_msr: Enable PMU support for MSR RAPL
Date: Wed, 31 Jan 2024 22:23:35 +0800
Message-Id: <20240131142335.84218-6-rui.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240131142335.84218-1-rui.zhang@intel.com>
References: <20240131142335.84218-1-rui.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable PMU support in intel_rapl_msr driver and remove previous MSR
RAPL PMU support in arch/x86/events/rapl.c.

Note that, there are some divergence between the CPU model lists of
these two drivers, switching from arch/x86/events/rapl.c CPU model list
to the intel_rapl driver CPU model list indeed brings some functional
changes including
1. Enable PMU for some Intel platforms, which were missing in
   arch/x86/events/rapl.c. This includes
	ICELAKE_NNPI
	ROCKETLAKE
	LUNARLAKE_M
	LAKEFIELD
	ATOM_SILVERMONT
	ATOM_SILVERMONT_MID
	ATOM_AIRMONT
	ATOM_AIRMONT_MID
	ATOM_TREMONT
	ATOM_TREMONT_D
	ATOM_TREMONT_L
2. Change the logic for enumerating AMD/HYGON platforms
   Previously, it was
	X86_MATCH_FEATURE(X86_FEATURE_RAPL,             &model_amd_hygon)
   And now it is
	X86_MATCH_VENDOR_FAM(AMD, 0x17, &rapl_defaults_amd)
	X86_MATCH_VENDOR_FAM(AMD, 0x19, &rapl_defaults_amd)
	X86_MATCH_VENDOR_FAM(HYGON, 0x18, &rapl_defaults_amd)

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
Given that both of the CPU model lists describe the same feature that is
available on the same set of hardwares, any bug during this transition
suggests a gap in either of the previous code.
So IMO, the risk is acceptable.
---
 arch/x86/events/Kconfig           |   8 -
 arch/x86/events/Makefile          |   1 -
 arch/x86/events/rapl.c            | 871 ------------------------------
 drivers/powercap/intel_rapl_msr.c |   2 +
 4 files changed, 2 insertions(+), 880 deletions(-)
 delete mode 100644 arch/x86/events/rapl.c

diff --git a/arch/x86/events/Kconfig b/arch/x86/events/Kconfig
index dabdf3d7bf84..21f7ea817dcf 100644
--- a/arch/x86/events/Kconfig
+++ b/arch/x86/events/Kconfig
@@ -9,14 +9,6 @@ config PERF_EVENTS_INTEL_UNCORE
 	  Include support for Intel uncore performance events. These are
 	  available on NehalemEX and more modern processors.
 
-config PERF_EVENTS_INTEL_RAPL
-	tristate "Intel/AMD rapl performance events"
-	depends on PERF_EVENTS && (CPU_SUP_INTEL || CPU_SUP_AMD) && PCI
-	default y
-	help
-	  Include support for Intel and AMD rapl performance events for power
-	  monitoring on modern processors.
-
 config PERF_EVENTS_INTEL_CSTATE
 	tristate "Intel cstate performance events"
 	depends on PERF_EVENTS && CPU_SUP_INTEL && PCI
diff --git a/arch/x86/events/Makefile b/arch/x86/events/Makefile
index 86a76efa8bb6..b9d51fa83b06 100644
--- a/arch/x86/events/Makefile
+++ b/arch/x86/events/Makefile
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-y					+= core.o probe.o utils.o
-obj-$(CONFIG_PERF_EVENTS_INTEL_RAPL)	+= rapl.o
 obj-y					+= amd/
 obj-$(CONFIG_X86_LOCAL_APIC)            += msr.o
 obj-$(CONFIG_CPU_SUP_INTEL)		+= intel/
diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
deleted file mode 100644
index 8d98d468b976..000000000000
--- a/arch/x86/events/rapl.c
+++ /dev/null
@@ -1,871 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Support Intel/AMD RAPL energy consumption counters
- * Copyright (C) 2013 Google, Inc., Stephane Eranian
- *
- * Intel RAPL interface is specified in the IA-32 Manual Vol3b
- * section 14.7.1 (September 2013)
- *
- * AMD RAPL interface for Fam17h is described in the public PPR:
- * https://bugzilla.kernel.org/show_bug.cgi?id=206537
- *
- * RAPL provides more controls than just reporting energy consumption
- * however here we only expose the 3 energy consumption free running
- * counters (pp0, pkg, dram).
- *
- * Each of those counters increments in a power unit defined by the
- * RAPL_POWER_UNIT MSR. On SandyBridge, this unit is 1/(2^16) Joules
- * but it can vary.
- *
- * Counter to rapl events mappings:
- *
- *  pp0 counter: consumption of all physical cores (power plane 0)
- * 	  event: rapl_energy_cores
- *    perf code: 0x1
- *
- *  pkg counter: consumption of the whole processor package
- *	  event: rapl_energy_pkg
- *    perf code: 0x2
- *
- * dram counter: consumption of the dram domain (servers only)
- *	  event: rapl_energy_dram
- *    perf code: 0x3
- *
- * gpu counter: consumption of the builtin-gpu domain (client only)
- *	  event: rapl_energy_gpu
- *    perf code: 0x4
- *
- *  psys counter: consumption of the builtin-psys domain (client only)
- *	  event: rapl_energy_psys
- *    perf code: 0x5
- *
- * We manage those counters as free running (read-only). They may be
- * use simultaneously by other tools, such as turbostat.
- *
- * The events only support system-wide mode counting. There is no
- * sampling support because it does not make sense and is not
- * supported by the RAPL hardware.
- *
- * Because we want to avoid floating-point operations in the kernel,
- * the events are all reported in fixed point arithmetic (32.32).
- * Tools must adjust the counts to convert them to Watts using
- * the duration of the measurement. Tools may use a function such as
- * ldexp(raw_count, -32);
- */
-
-#define pr_fmt(fmt) "RAPL PMU: " fmt
-
-#include <linux/module.h>
-#include <linux/slab.h>
-#include <linux/perf_event.h>
-#include <linux/nospec.h>
-#include <asm/cpu_device_id.h>
-#include <asm/intel-family.h>
-#include "perf_event.h"
-#include "probe.h"
-
-MODULE_LICENSE("GPL");
-
-/*
- * RAPL energy status counters
- */
-enum perf_rapl_events {
-	PERF_RAPL_PP0 = 0,		/* all cores */
-	PERF_RAPL_PKG,			/* entire package */
-	PERF_RAPL_RAM,			/* DRAM */
-	PERF_RAPL_PP1,			/* gpu */
-	PERF_RAPL_PSYS,			/* psys */
-
-	PERF_RAPL_MAX,
-	NR_RAPL_DOMAINS = PERF_RAPL_MAX,
-};
-
-static const char *const rapl_domain_names[NR_RAPL_DOMAINS] __initconst = {
-	"pp0-core",
-	"package",
-	"dram",
-	"pp1-gpu",
-	"psys",
-};
-
-/*
- * event code: LSB 8 bits, passed in attr->config
- * any other bit is reserved
- */
-#define RAPL_EVENT_MASK	0xFFULL
-#define RAPL_CNTR_WIDTH 32
-
-#define RAPL_EVENT_ATTR_STR(_name, v, str)					\
-static struct perf_pmu_events_attr event_attr_##v = {				\
-	.attr		= __ATTR(_name, 0444, perf_event_sysfs_show, NULL),	\
-	.id		= 0,							\
-	.event_str	= str,							\
-};
-
-struct rapl_pmu {
-	raw_spinlock_t		lock;
-	int			n_active;
-	int			cpu;
-	struct list_head	active_list;
-	struct pmu		*pmu;
-	ktime_t			timer_interval;
-	struct hrtimer		hrtimer;
-};
-
-struct rapl_pmus {
-	struct pmu		pmu;
-	unsigned int		maxdie;
-	struct rapl_pmu		*pmus[] __counted_by(maxdie);
-};
-
-enum rapl_unit_quirk {
-	RAPL_UNIT_QUIRK_NONE,
-	RAPL_UNIT_QUIRK_INTEL_HSW,
-	RAPL_UNIT_QUIRK_INTEL_SPR,
-};
-
-struct rapl_model {
-	struct perf_msr *rapl_msrs;
-	unsigned long	events;
-	unsigned int	msr_power_unit;
-	enum rapl_unit_quirk	unit_quirk;
-};
-
- /* 1/2^hw_unit Joule */
-static int rapl_hw_unit[NR_RAPL_DOMAINS] __read_mostly;
-static struct rapl_pmus *rapl_pmus;
-static cpumask_t rapl_cpu_mask;
-static unsigned int rapl_cntr_mask;
-static u64 rapl_timer_ms;
-static struct perf_msr *rapl_msrs;
-
-static inline struct rapl_pmu *cpu_to_rapl_pmu(unsigned int cpu)
-{
-	unsigned int dieid = topology_logical_die_id(cpu);
-
-	/*
-	 * The unsigned check also catches the '-1' return value for non
-	 * existent mappings in the topology map.
-	 */
-	return dieid < rapl_pmus->maxdie ? rapl_pmus->pmus[dieid] : NULL;
-}
-
-static inline u64 rapl_read_counter(struct perf_event *event)
-{
-	u64 raw;
-	rdmsrl(event->hw.event_base, raw);
-	return raw;
-}
-
-static inline u64 rapl_scale(u64 v, int cfg)
-{
-	if (cfg > NR_RAPL_DOMAINS) {
-		pr_warn("Invalid domain %d, failed to scale data\n", cfg);
-		return v;
-	}
-	/*
-	 * scale delta to smallest unit (1/2^32)
-	 * users must then scale back: count * 1/(1e9*2^32) to get Joules
-	 * or use ldexp(count, -32).
-	 * Watts = Joules/Time delta
-	 */
-	return v << (32 - rapl_hw_unit[cfg - 1]);
-}
-
-static u64 rapl_event_update(struct perf_event *event)
-{
-	struct hw_perf_event *hwc = &event->hw;
-	u64 prev_raw_count, new_raw_count;
-	s64 delta, sdelta;
-	int shift = RAPL_CNTR_WIDTH;
-
-	prev_raw_count = local64_read(&hwc->prev_count);
-	do {
-		rdmsrl(event->hw.event_base, new_raw_count);
-	} while (!local64_try_cmpxchg(&hwc->prev_count,
-				      &prev_raw_count, new_raw_count));
-
-	/*
-	 * Now we have the new raw value and have updated the prev
-	 * timestamp already. We can now calculate the elapsed delta
-	 * (event-)time and add that to the generic event.
-	 *
-	 * Careful, not all hw sign-extends above the physical width
-	 * of the count.
-	 */
-	delta = (new_raw_count << shift) - (prev_raw_count << shift);
-	delta >>= shift;
-
-	sdelta = rapl_scale(delta, event->hw.config);
-
-	local64_add(sdelta, &event->count);
-
-	return new_raw_count;
-}
-
-static void rapl_start_hrtimer(struct rapl_pmu *pmu)
-{
-       hrtimer_start(&pmu->hrtimer, pmu->timer_interval,
-		     HRTIMER_MODE_REL_PINNED);
-}
-
-static enum hrtimer_restart rapl_hrtimer_handle(struct hrtimer *hrtimer)
-{
-	struct rapl_pmu *pmu = container_of(hrtimer, struct rapl_pmu, hrtimer);
-	struct perf_event *event;
-	unsigned long flags;
-
-	if (!pmu->n_active)
-		return HRTIMER_NORESTART;
-
-	raw_spin_lock_irqsave(&pmu->lock, flags);
-
-	list_for_each_entry(event, &pmu->active_list, active_entry)
-		rapl_event_update(event);
-
-	raw_spin_unlock_irqrestore(&pmu->lock, flags);
-
-	hrtimer_forward_now(hrtimer, pmu->timer_interval);
-
-	return HRTIMER_RESTART;
-}
-
-static void rapl_hrtimer_init(struct rapl_pmu *pmu)
-{
-	struct hrtimer *hr = &pmu->hrtimer;
-
-	hrtimer_init(hr, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	hr->function = rapl_hrtimer_handle;
-}
-
-static void __rapl_pmu_event_start(struct rapl_pmu *pmu,
-				   struct perf_event *event)
-{
-	if (WARN_ON_ONCE(!(event->hw.state & PERF_HES_STOPPED)))
-		return;
-
-	event->hw.state = 0;
-
-	list_add_tail(&event->active_entry, &pmu->active_list);
-
-	local64_set(&event->hw.prev_count, rapl_read_counter(event));
-
-	pmu->n_active++;
-	if (pmu->n_active == 1)
-		rapl_start_hrtimer(pmu);
-}
-
-static void rapl_pmu_event_start(struct perf_event *event, int mode)
-{
-	struct rapl_pmu *pmu = event->pmu_private;
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&pmu->lock, flags);
-	__rapl_pmu_event_start(pmu, event);
-	raw_spin_unlock_irqrestore(&pmu->lock, flags);
-}
-
-static void rapl_pmu_event_stop(struct perf_event *event, int mode)
-{
-	struct rapl_pmu *pmu = event->pmu_private;
-	struct hw_perf_event *hwc = &event->hw;
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&pmu->lock, flags);
-
-	/* mark event as deactivated and stopped */
-	if (!(hwc->state & PERF_HES_STOPPED)) {
-		WARN_ON_ONCE(pmu->n_active <= 0);
-		pmu->n_active--;
-		if (pmu->n_active == 0)
-			hrtimer_cancel(&pmu->hrtimer);
-
-		list_del(&event->active_entry);
-
-		WARN_ON_ONCE(hwc->state & PERF_HES_STOPPED);
-		hwc->state |= PERF_HES_STOPPED;
-	}
-
-	/* check if update of sw counter is necessary */
-	if ((mode & PERF_EF_UPDATE) && !(hwc->state & PERF_HES_UPTODATE)) {
-		/*
-		 * Drain the remaining delta count out of a event
-		 * that we are disabling:
-		 */
-		rapl_event_update(event);
-		hwc->state |= PERF_HES_UPTODATE;
-	}
-
-	raw_spin_unlock_irqrestore(&pmu->lock, flags);
-}
-
-static int rapl_pmu_event_add(struct perf_event *event, int mode)
-{
-	struct rapl_pmu *pmu = event->pmu_private;
-	struct hw_perf_event *hwc = &event->hw;
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&pmu->lock, flags);
-
-	hwc->state = PERF_HES_UPTODATE | PERF_HES_STOPPED;
-
-	if (mode & PERF_EF_START)
-		__rapl_pmu_event_start(pmu, event);
-
-	raw_spin_unlock_irqrestore(&pmu->lock, flags);
-
-	return 0;
-}
-
-static void rapl_pmu_event_del(struct perf_event *event, int flags)
-{
-	rapl_pmu_event_stop(event, PERF_EF_UPDATE);
-}
-
-static int rapl_pmu_event_init(struct perf_event *event)
-{
-	u64 cfg = event->attr.config & RAPL_EVENT_MASK;
-	int bit, ret = 0;
-	struct rapl_pmu *pmu;
-
-	/* only look at RAPL events */
-	if (event->attr.type != rapl_pmus->pmu.type)
-		return -ENOENT;
-
-	/* check only supported bits are set */
-	if (event->attr.config & ~RAPL_EVENT_MASK)
-		return -EINVAL;
-
-	if (event->cpu < 0)
-		return -EINVAL;
-
-	event->event_caps |= PERF_EV_CAP_READ_ACTIVE_PKG;
-
-	if (!cfg || cfg >= NR_RAPL_DOMAINS + 1)
-		return -EINVAL;
-
-	cfg = array_index_nospec((long)cfg, NR_RAPL_DOMAINS + 1);
-	bit = cfg - 1;
-
-	/* check event supported */
-	if (!(rapl_cntr_mask & (1 << bit)))
-		return -EINVAL;
-
-	/* unsupported modes and filters */
-	if (event->attr.sample_period) /* no sampling */
-		return -EINVAL;
-
-	/* must be done before validate_group */
-	pmu = cpu_to_rapl_pmu(event->cpu);
-	if (!pmu)
-		return -EINVAL;
-	event->cpu = pmu->cpu;
-	event->pmu_private = pmu;
-	event->hw.event_base = rapl_msrs[bit].msr;
-	event->hw.config = cfg;
-	event->hw.idx = bit;
-
-	return ret;
-}
-
-static void rapl_pmu_event_read(struct perf_event *event)
-{
-	rapl_event_update(event);
-}
-
-static ssize_t rapl_get_attr_cpumask(struct device *dev,
-				struct device_attribute *attr, char *buf)
-{
-	return cpumap_print_to_pagebuf(true, buf, &rapl_cpu_mask);
-}
-
-static DEVICE_ATTR(cpumask, S_IRUGO, rapl_get_attr_cpumask, NULL);
-
-static struct attribute *rapl_pmu_attrs[] = {
-	&dev_attr_cpumask.attr,
-	NULL,
-};
-
-static struct attribute_group rapl_pmu_attr_group = {
-	.attrs = rapl_pmu_attrs,
-};
-
-RAPL_EVENT_ATTR_STR(energy-cores, rapl_cores, "event=0x01");
-RAPL_EVENT_ATTR_STR(energy-pkg  ,   rapl_pkg, "event=0x02");
-RAPL_EVENT_ATTR_STR(energy-ram  ,   rapl_ram, "event=0x03");
-RAPL_EVENT_ATTR_STR(energy-gpu  ,   rapl_gpu, "event=0x04");
-RAPL_EVENT_ATTR_STR(energy-psys,   rapl_psys, "event=0x05");
-
-RAPL_EVENT_ATTR_STR(energy-cores.unit, rapl_cores_unit, "Joules");
-RAPL_EVENT_ATTR_STR(energy-pkg.unit  ,   rapl_pkg_unit, "Joules");
-RAPL_EVENT_ATTR_STR(energy-ram.unit  ,   rapl_ram_unit, "Joules");
-RAPL_EVENT_ATTR_STR(energy-gpu.unit  ,   rapl_gpu_unit, "Joules");
-RAPL_EVENT_ATTR_STR(energy-psys.unit,   rapl_psys_unit, "Joules");
-
-/*
- * we compute in 0.23 nJ increments regardless of MSR
- */
-RAPL_EVENT_ATTR_STR(energy-cores.scale, rapl_cores_scale, "2.3283064365386962890625e-10");
-RAPL_EVENT_ATTR_STR(energy-pkg.scale,     rapl_pkg_scale, "2.3283064365386962890625e-10");
-RAPL_EVENT_ATTR_STR(energy-ram.scale,     rapl_ram_scale, "2.3283064365386962890625e-10");
-RAPL_EVENT_ATTR_STR(energy-gpu.scale,     rapl_gpu_scale, "2.3283064365386962890625e-10");
-RAPL_EVENT_ATTR_STR(energy-psys.scale,   rapl_psys_scale, "2.3283064365386962890625e-10");
-
-/*
- * There are no default events, but we need to create
- * "events" group (with empty attrs) before updating
- * it with detected events.
- */
-static struct attribute *attrs_empty[] = {
-	NULL,
-};
-
-static struct attribute_group rapl_pmu_events_group = {
-	.name = "events",
-	.attrs = attrs_empty,
-};
-
-PMU_FORMAT_ATTR(event, "config:0-7");
-static struct attribute *rapl_formats_attr[] = {
-	&format_attr_event.attr,
-	NULL,
-};
-
-static struct attribute_group rapl_pmu_format_group = {
-	.name = "format",
-	.attrs = rapl_formats_attr,
-};
-
-static const struct attribute_group *rapl_attr_groups[] = {
-	&rapl_pmu_attr_group,
-	&rapl_pmu_format_group,
-	&rapl_pmu_events_group,
-	NULL,
-};
-
-static struct attribute *rapl_events_cores[] = {
-	EVENT_PTR(rapl_cores),
-	EVENT_PTR(rapl_cores_unit),
-	EVENT_PTR(rapl_cores_scale),
-	NULL,
-};
-
-static struct attribute_group rapl_events_cores_group = {
-	.name  = "events",
-	.attrs = rapl_events_cores,
-};
-
-static struct attribute *rapl_events_pkg[] = {
-	EVENT_PTR(rapl_pkg),
-	EVENT_PTR(rapl_pkg_unit),
-	EVENT_PTR(rapl_pkg_scale),
-	NULL,
-};
-
-static struct attribute_group rapl_events_pkg_group = {
-	.name  = "events",
-	.attrs = rapl_events_pkg,
-};
-
-static struct attribute *rapl_events_ram[] = {
-	EVENT_PTR(rapl_ram),
-	EVENT_PTR(rapl_ram_unit),
-	EVENT_PTR(rapl_ram_scale),
-	NULL,
-};
-
-static struct attribute_group rapl_events_ram_group = {
-	.name  = "events",
-	.attrs = rapl_events_ram,
-};
-
-static struct attribute *rapl_events_gpu[] = {
-	EVENT_PTR(rapl_gpu),
-	EVENT_PTR(rapl_gpu_unit),
-	EVENT_PTR(rapl_gpu_scale),
-	NULL,
-};
-
-static struct attribute_group rapl_events_gpu_group = {
-	.name  = "events",
-	.attrs = rapl_events_gpu,
-};
-
-static struct attribute *rapl_events_psys[] = {
-	EVENT_PTR(rapl_psys),
-	EVENT_PTR(rapl_psys_unit),
-	EVENT_PTR(rapl_psys_scale),
-	NULL,
-};
-
-static struct attribute_group rapl_events_psys_group = {
-	.name  = "events",
-	.attrs = rapl_events_psys,
-};
-
-static bool test_msr(int idx, void *data)
-{
-	return test_bit(idx, (unsigned long *) data);
-}
-
-/* Only lower 32bits of the MSR represents the energy counter */
-#define RAPL_MSR_MASK 0xFFFFFFFF
-
-static struct perf_msr intel_rapl_msrs[] = {
-	[PERF_RAPL_PP0]  = { MSR_PP0_ENERGY_STATUS,      &rapl_events_cores_group, test_msr, false, RAPL_MSR_MASK },
-	[PERF_RAPL_PKG]  = { MSR_PKG_ENERGY_STATUS,      &rapl_events_pkg_group,   test_msr, false, RAPL_MSR_MASK },
-	[PERF_RAPL_RAM]  = { MSR_DRAM_ENERGY_STATUS,     &rapl_events_ram_group,   test_msr, false, RAPL_MSR_MASK },
-	[PERF_RAPL_PP1]  = { MSR_PP1_ENERGY_STATUS,      &rapl_events_gpu_group,   test_msr, false, RAPL_MSR_MASK },
-	[PERF_RAPL_PSYS] = { MSR_PLATFORM_ENERGY_STATUS, &rapl_events_psys_group,  test_msr, false, RAPL_MSR_MASK },
-};
-
-static struct perf_msr intel_rapl_spr_msrs[] = {
-	[PERF_RAPL_PP0]  = { MSR_PP0_ENERGY_STATUS,      &rapl_events_cores_group, test_msr, false, RAPL_MSR_MASK },
-	[PERF_RAPL_PKG]  = { MSR_PKG_ENERGY_STATUS,      &rapl_events_pkg_group,   test_msr, false, RAPL_MSR_MASK },
-	[PERF_RAPL_RAM]  = { MSR_DRAM_ENERGY_STATUS,     &rapl_events_ram_group,   test_msr, false, RAPL_MSR_MASK },
-	[PERF_RAPL_PP1]  = { MSR_PP1_ENERGY_STATUS,      &rapl_events_gpu_group,   test_msr, false, RAPL_MSR_MASK },
-	[PERF_RAPL_PSYS] = { MSR_PLATFORM_ENERGY_STATUS, &rapl_events_psys_group,  test_msr, true, RAPL_MSR_MASK },
-};
-
-/*
- * Force to PERF_RAPL_MAX size due to:
- * - perf_msr_probe(PERF_RAPL_MAX)
- * - want to use same event codes across both architectures
- */
-static struct perf_msr amd_rapl_msrs[] = {
-	[PERF_RAPL_PP0]  = { 0, &rapl_events_cores_group, NULL, false, 0 },
-	[PERF_RAPL_PKG]  = { MSR_AMD_PKG_ENERGY_STATUS,  &rapl_events_pkg_group,   test_msr, false, RAPL_MSR_MASK },
-	[PERF_RAPL_RAM]  = { 0, &rapl_events_ram_group,   NULL, false, 0 },
-	[PERF_RAPL_PP1]  = { 0, &rapl_events_gpu_group,   NULL, false, 0 },
-	[PERF_RAPL_PSYS] = { 0, &rapl_events_psys_group,  NULL, false, 0 },
-};
-
-static int rapl_cpu_offline(unsigned int cpu)
-{
-	struct rapl_pmu *pmu = cpu_to_rapl_pmu(cpu);
-	int target;
-
-	/* Check if exiting cpu is used for collecting rapl events */
-	if (!cpumask_test_and_clear_cpu(cpu, &rapl_cpu_mask))
-		return 0;
-
-	pmu->cpu = -1;
-	/* Find a new cpu to collect rapl events */
-	target = cpumask_any_but(topology_die_cpumask(cpu), cpu);
-
-	/* Migrate rapl events to the new target */
-	if (target < nr_cpu_ids) {
-		cpumask_set_cpu(target, &rapl_cpu_mask);
-		pmu->cpu = target;
-		perf_pmu_migrate_context(pmu->pmu, cpu, target);
-	}
-	return 0;
-}
-
-static int rapl_cpu_online(unsigned int cpu)
-{
-	struct rapl_pmu *pmu = cpu_to_rapl_pmu(cpu);
-	int target;
-
-	if (!pmu) {
-		pmu = kzalloc_node(sizeof(*pmu), GFP_KERNEL, cpu_to_node(cpu));
-		if (!pmu)
-			return -ENOMEM;
-
-		raw_spin_lock_init(&pmu->lock);
-		INIT_LIST_HEAD(&pmu->active_list);
-		pmu->pmu = &rapl_pmus->pmu;
-		pmu->timer_interval = ms_to_ktime(rapl_timer_ms);
-		rapl_hrtimer_init(pmu);
-
-		rapl_pmus->pmus[topology_logical_die_id(cpu)] = pmu;
-	}
-
-	/*
-	 * Check if there is an online cpu in the package which collects rapl
-	 * events already.
-	 */
-	target = cpumask_any_and(&rapl_cpu_mask, topology_die_cpumask(cpu));
-	if (target < nr_cpu_ids)
-		return 0;
-
-	cpumask_set_cpu(cpu, &rapl_cpu_mask);
-	pmu->cpu = cpu;
-	return 0;
-}
-
-static int rapl_check_hw_unit(struct rapl_model *rm)
-{
-	u64 msr_rapl_power_unit_bits;
-	int i;
-
-	/* protect rdmsrl() to handle virtualization */
-	if (rdmsrl_safe(rm->msr_power_unit, &msr_rapl_power_unit_bits))
-		return -1;
-	for (i = 0; i < NR_RAPL_DOMAINS; i++)
-		rapl_hw_unit[i] = (msr_rapl_power_unit_bits >> 8) & 0x1FULL;
-
-	switch (rm->unit_quirk) {
-	/*
-	 * DRAM domain on HSW server and KNL has fixed energy unit which can be
-	 * different than the unit from power unit MSR. See
-	 * "Intel Xeon Processor E5-1600 and E5-2600 v3 Product Families, V2
-	 * of 2. Datasheet, September 2014, Reference Number: 330784-001 "
-	 */
-	case RAPL_UNIT_QUIRK_INTEL_HSW:
-		rapl_hw_unit[PERF_RAPL_RAM] = 16;
-		break;
-	/* SPR uses a fixed energy unit for Psys domain. */
-	case RAPL_UNIT_QUIRK_INTEL_SPR:
-		rapl_hw_unit[PERF_RAPL_PSYS] = 0;
-		break;
-	default:
-		break;
-	}
-
-
-	/*
-	 * Calculate the timer rate:
-	 * Use reference of 200W for scaling the timeout to avoid counter
-	 * overflows. 200W = 200 Joules/sec
-	 * Divide interval by 2 to avoid lockstep (2 * 100)
-	 * if hw unit is 32, then we use 2 ms 1/200/2
-	 */
-	rapl_timer_ms = 2;
-	if (rapl_hw_unit[0] < 32) {
-		rapl_timer_ms = (1000 / (2 * 100));
-		rapl_timer_ms *= (1ULL << (32 - rapl_hw_unit[0] - 1));
-	}
-	return 0;
-}
-
-static void __init rapl_advertise(void)
-{
-	int i;
-
-	pr_info("API unit is 2^-32 Joules, %d fixed counters, %llu ms ovfl timer\n",
-		hweight32(rapl_cntr_mask), rapl_timer_ms);
-
-	for (i = 0; i < NR_RAPL_DOMAINS; i++) {
-		if (rapl_cntr_mask & (1 << i)) {
-			pr_info("hw unit of domain %s 2^-%d Joules\n",
-				rapl_domain_names[i], rapl_hw_unit[i]);
-		}
-	}
-}
-
-static void cleanup_rapl_pmus(void)
-{
-	int i;
-
-	for (i = 0; i < rapl_pmus->maxdie; i++)
-		kfree(rapl_pmus->pmus[i]);
-	kfree(rapl_pmus);
-}
-
-static const struct attribute_group *rapl_attr_update[] = {
-	&rapl_events_cores_group,
-	&rapl_events_pkg_group,
-	&rapl_events_ram_group,
-	&rapl_events_gpu_group,
-	&rapl_events_psys_group,
-	NULL,
-};
-
-static int __init init_rapl_pmus(void)
-{
-	int maxdie = topology_max_packages() * topology_max_die_per_package();
-	size_t size;
-
-	size = sizeof(*rapl_pmus) + maxdie * sizeof(struct rapl_pmu *);
-	rapl_pmus = kzalloc(size, GFP_KERNEL);
-	if (!rapl_pmus)
-		return -ENOMEM;
-
-	rapl_pmus->maxdie		= maxdie;
-	rapl_pmus->pmu.attr_groups	= rapl_attr_groups;
-	rapl_pmus->pmu.attr_update	= rapl_attr_update;
-	rapl_pmus->pmu.task_ctx_nr	= perf_invalid_context;
-	rapl_pmus->pmu.event_init	= rapl_pmu_event_init;
-	rapl_pmus->pmu.add		= rapl_pmu_event_add;
-	rapl_pmus->pmu.del		= rapl_pmu_event_del;
-	rapl_pmus->pmu.start		= rapl_pmu_event_start;
-	rapl_pmus->pmu.stop		= rapl_pmu_event_stop;
-	rapl_pmus->pmu.read		= rapl_pmu_event_read;
-	rapl_pmus->pmu.module		= THIS_MODULE;
-	rapl_pmus->pmu.capabilities	= PERF_PMU_CAP_NO_EXCLUDE;
-	return 0;
-}
-
-static struct rapl_model model_snb = {
-	.events		= BIT(PERF_RAPL_PP0) |
-			  BIT(PERF_RAPL_PKG) |
-			  BIT(PERF_RAPL_PP1),
-	.msr_power_unit = MSR_RAPL_POWER_UNIT,
-	.rapl_msrs      = intel_rapl_msrs,
-};
-
-static struct rapl_model model_snbep = {
-	.events		= BIT(PERF_RAPL_PP0) |
-			  BIT(PERF_RAPL_PKG) |
-			  BIT(PERF_RAPL_RAM),
-	.msr_power_unit = MSR_RAPL_POWER_UNIT,
-	.rapl_msrs      = intel_rapl_msrs,
-};
-
-static struct rapl_model model_hsw = {
-	.events		= BIT(PERF_RAPL_PP0) |
-			  BIT(PERF_RAPL_PKG) |
-			  BIT(PERF_RAPL_RAM) |
-			  BIT(PERF_RAPL_PP1),
-	.msr_power_unit = MSR_RAPL_POWER_UNIT,
-	.rapl_msrs      = intel_rapl_msrs,
-};
-
-static struct rapl_model model_hsx = {
-	.events		= BIT(PERF_RAPL_PP0) |
-			  BIT(PERF_RAPL_PKG) |
-			  BIT(PERF_RAPL_RAM),
-	.unit_quirk	= RAPL_UNIT_QUIRK_INTEL_HSW,
-	.msr_power_unit = MSR_RAPL_POWER_UNIT,
-	.rapl_msrs      = intel_rapl_msrs,
-};
-
-static struct rapl_model model_knl = {
-	.events		= BIT(PERF_RAPL_PKG) |
-			  BIT(PERF_RAPL_RAM),
-	.unit_quirk	= RAPL_UNIT_QUIRK_INTEL_HSW,
-	.msr_power_unit = MSR_RAPL_POWER_UNIT,
-	.rapl_msrs      = intel_rapl_msrs,
-};
-
-static struct rapl_model model_skl = {
-	.events		= BIT(PERF_RAPL_PP0) |
-			  BIT(PERF_RAPL_PKG) |
-			  BIT(PERF_RAPL_RAM) |
-			  BIT(PERF_RAPL_PP1) |
-			  BIT(PERF_RAPL_PSYS),
-	.msr_power_unit = MSR_RAPL_POWER_UNIT,
-	.rapl_msrs      = intel_rapl_msrs,
-};
-
-static struct rapl_model model_spr = {
-	.events		= BIT(PERF_RAPL_PP0) |
-			  BIT(PERF_RAPL_PKG) |
-			  BIT(PERF_RAPL_RAM) |
-			  BIT(PERF_RAPL_PSYS),
-	.unit_quirk	= RAPL_UNIT_QUIRK_INTEL_SPR,
-	.msr_power_unit = MSR_RAPL_POWER_UNIT,
-	.rapl_msrs      = intel_rapl_spr_msrs,
-};
-
-static struct rapl_model model_amd_hygon = {
-	.events		= BIT(PERF_RAPL_PKG),
-	.msr_power_unit = MSR_AMD_RAPL_POWER_UNIT,
-	.rapl_msrs      = amd_rapl_msrs,
-};
-
-static const struct x86_cpu_id rapl_model_match[] __initconst = {
-	X86_MATCH_FEATURE(X86_FEATURE_RAPL,		&model_amd_hygon),
-	X86_MATCH_INTEL_FAM6_MODEL(SANDYBRIDGE,		&model_snb),
-	X86_MATCH_INTEL_FAM6_MODEL(SANDYBRIDGE_X,	&model_snbep),
-	X86_MATCH_INTEL_FAM6_MODEL(IVYBRIDGE,		&model_snb),
-	X86_MATCH_INTEL_FAM6_MODEL(IVYBRIDGE_X,		&model_snbep),
-	X86_MATCH_INTEL_FAM6_MODEL(HASWELL,		&model_hsw),
-	X86_MATCH_INTEL_FAM6_MODEL(HASWELL_X,		&model_hsx),
-	X86_MATCH_INTEL_FAM6_MODEL(HASWELL_L,		&model_hsw),
-	X86_MATCH_INTEL_FAM6_MODEL(HASWELL_G,		&model_hsw),
-	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL,		&model_hsw),
-	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_G,		&model_hsw),
-	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_X,		&model_hsx),
-	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_D,		&model_hsx),
-	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNL,	&model_knl),
-	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNM,	&model_knl),
-	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_L,		&model_skl),
-	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE,		&model_skl),
-	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X,		&model_hsx),
-	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE_L,		&model_skl),
-	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE,		&model_skl),
-	X86_MATCH_INTEL_FAM6_MODEL(CANNONLAKE_L,	&model_skl),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT,	&model_hsw),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_D,	&model_hsw),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_PLUS,	&model_hsw),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L,		&model_skl),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE,		&model_skl),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,		&model_hsx),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,		&model_hsx),
-	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE_L,		&model_skl),
-	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE,		&model_skl),
-	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L,		&model_skl),
-	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE,		&model_skl),
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		&model_skl),
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		&model_skl),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GRACEMONT,	&model_skl),
-	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&model_spr),
-	X86_MATCH_INTEL_FAM6_MODEL(EMERALDRAPIDS_X,	&model_spr),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		&model_skl),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,	&model_skl),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,	&model_skl),
-	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE,		&model_skl),
-	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE_L,	&model_skl),
-	{},
-};
-MODULE_DEVICE_TABLE(x86cpu, rapl_model_match);
-
-static int __init rapl_pmu_init(void)
-{
-	const struct x86_cpu_id *id;
-	struct rapl_model *rm;
-	int ret;
-
-	id = x86_match_cpu(rapl_model_match);
-	if (!id)
-		return -ENODEV;
-
-	rm = (struct rapl_model *) id->driver_data;
-
-	rapl_msrs = rm->rapl_msrs;
-
-	rapl_cntr_mask = perf_msr_probe(rapl_msrs, PERF_RAPL_MAX,
-					false, (void *) &rm->events);
-
-	ret = rapl_check_hw_unit(rm);
-	if (ret)
-		return ret;
-
-	ret = init_rapl_pmus();
-	if (ret)
-		return ret;
-
-	/*
-	 * Install callbacks. Core will call them for each online cpu.
-	 */
-	ret = cpuhp_setup_state(CPUHP_AP_PERF_X86_RAPL_ONLINE,
-				"perf/x86/rapl:online",
-				rapl_cpu_online, rapl_cpu_offline);
-	if (ret)
-		goto out;
-
-	ret = perf_pmu_register(&rapl_pmus->pmu, "power", -1);
-	if (ret)
-		goto out1;
-
-	rapl_advertise();
-	return 0;
-
-out1:
-	cpuhp_remove_state(CPUHP_AP_PERF_X86_RAPL_ONLINE);
-out:
-	pr_warn("Initialization failed (%d), disabled\n", ret);
-	cleanup_rapl_pmus();
-	return ret;
-}
-module_init(rapl_pmu_init);
-
-static void __exit intel_rapl_exit(void)
-{
-	cpuhp_remove_state_nocalls(CPUHP_AP_PERF_X86_RAPL_ONLINE);
-	perf_pmu_unregister(&rapl_pmus->pmu);
-	cleanup_rapl_pmus();
-}
-module_exit(intel_rapl_exit);
diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
index b4b6930cacb0..564623471a68 100644
--- a/drivers/powercap/intel_rapl_msr.c
+++ b/drivers/powercap/intel_rapl_msr.c
@@ -53,6 +53,7 @@ static struct rapl_if_priv rapl_msr_priv_intel = {
 	.regs[RAPL_DOMAIN_PLATFORM][RAPL_DOMAIN_REG_STATUS].msr	= MSR_PLATFORM_ENERGY_STATUS,
 	.limits[RAPL_DOMAIN_PACKAGE] = BIT(POWER_LIMIT2),
 	.limits[RAPL_DOMAIN_PLATFORM] = BIT(POWER_LIMIT2),
+	.enable_pmu = true,
 };
 
 static struct rapl_if_priv rapl_msr_priv_amd = {
@@ -60,6 +61,7 @@ static struct rapl_if_priv rapl_msr_priv_amd = {
 	.reg_unit.msr = MSR_AMD_RAPL_POWER_UNIT,
 	.regs[RAPL_DOMAIN_PACKAGE][RAPL_DOMAIN_REG_STATUS].msr	= MSR_AMD_PKG_ENERGY_STATUS,
 	.regs[RAPL_DOMAIN_PP0][RAPL_DOMAIN_REG_STATUS].msr	= MSR_AMD_CORE_ENERGY_STATUS,
+	.enable_pmu = true,
 };
 
 /* Handles CPU hotplug on multi-socket systems.
-- 
2.34.1


