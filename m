Return-Path: <linux-kernel+bounces-46593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9821E8441C2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBEF21C22BE2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D9B83CC9;
	Wed, 31 Jan 2024 14:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ReevSnKX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EAF83CB2;
	Wed, 31 Jan 2024 14:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706711037; cv=none; b=RP9Xsf67HY6c+K6nsNZtWE9nlIEu25rXxiuMCOqxbCXDmpmuFS31baVFeKz/nlRZaHTEDppYqDJLjT/peDUAbnWAOdwKn9ZemhBM+NVg8DLCjFRxt3mk9amCNAJHZuwCwr7eOgtunl//1pegV/NTErQjhNfLtvDW39rB2UyFZjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706711037; c=relaxed/simple;
	bh=MNYyJaRmNaZjkli6XFAM+Od3XgEgAiNmNHWd8Irf9ls=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P0IGF3Jxv/tWDnWUbrS2vhpapqWCGYVDO1Z+Hsua+Tk4qNrg5qrWCw7DYb3dunZz4VHml5wwdoJO9ecvxJNqyhSTDjAbYzeobEGIQCeZCrIy+N3/n41Rxh9LYXPXK0cutF+308Mdbe6S40OWKzy35Yjqp4kl4wijmAbraIVy91k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ReevSnKX; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706711035; x=1738247035;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MNYyJaRmNaZjkli6XFAM+Od3XgEgAiNmNHWd8Irf9ls=;
  b=ReevSnKXPOrOyTCW8XSqruGQ1dv53gOCDOuAmMBRZvcNUr/MW6rWnZ20
   dRgnebrOZzlpiRKAfy3fTBI+q+n6ngTaAPFOUzC5W6+SVzfXb7EyYyXBE
   kZ3u5VPUV3knL2OtqmOEWFlIRAT8vN+XGX2KBcmkdhFGcWdMjKP3uOGO4
   IsNNXimwIwPGWwzMsFgyeyjQSDt0Q+QbB3Z+qtJ7WO39exL07In7X9NZ+
   RAANI0Wvp8bb1OwsVDozzflCZc12AU2BEZka6r0IPvbHJXZwVD3jhMcGf
   cw3ByMg80Cs/Z88U2577pre4abfLh9Wvl8997TgIXpGqA+0Us92iPH7Up
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10995813"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="10995813"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 06:23:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="4068690"
Received: from puhongt-mobl2.ccr.corp.intel.com (HELO rzhang1-mobl7.ccr.corp.intel.com) ([10.255.29.147])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 06:23:51 -0800
From: Zhang Rui <rui.zhang@intel.com>
To: rafael.j.wysocki@intel.com,
	peterz@infradead.org
Cc: mingo@redhat.com,
	kan.liang@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH 2/5] powercap: intel_rapl: Add PMU support
Date: Wed, 31 Jan 2024 22:23:32 +0800
Message-Id: <20240131142335.84218-3-rui.zhang@intel.com>
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

MSR RAPL powercap sysfs is done in drivers/powercap/intel_rapl_msr.c.
MSR RAPL PMU is done in arch/x86/events/rapl.c.

They maintain two separate CPU model lists, describing the same feature
available on the same set of hardware. This increases unnecessary
maintenance burden a lot.

Plus that, TPMI RAPL also needs PMU support, which shares similar code
with MSR RAPL PMU.

To unify all of these, introduce PMU support as part of RAPL framework.

The idea is that, if a RAPL Package device is registered to RAPL
framework, and is ready for energy reporting and control via sysfs, it
is also ready for PMU. So register a PMU in RAPL framework that works
for all registered RAPL Package devices with .enable_pmu flag set.
Note the RAPL PMU does not distinguish RAPL Package devices from
different Interface because MSR RAPL and TPMI RAPL do not co-exist on
any platform, and MMIO RAPL does not set .enable_pmu flag.

The RAPL PMU is fully compatible with current MSR RAPL PMU, including
using the same PMU name and events name/id/unit/scale, etc. For example,
on platforms use either MSR or TPMI, use the same command
 perf stat -e power/energy-pkg/ -e power/energy-ram/ -e power/energy-cores/ FOO
to get the energy consumption when the events are in "perf list" output.

Note that,
MSR RAPL PMU is CPU model based and the events supported are known at
driver initialization time. TPMI RAPL is probed dynamically, and the
events supported by each TPMI RAPL device can be different. Thus, when a
new RAPL Package device is registered with .enable_pmu set,
1. if PMU has not been registered yet, register the PMU
2. if current PMU already covers all events that the new RAPL Package
   device supports, do nothing (always true for MSR RAPL)
2. or else, unregister current PMU and re-register the PMU with events
   supported by all probed RAPL Package devices.
   For example, on a dual-package system using TPMI RAPL, it is possible
   that Package 1 behaves as TPMI domain root. In this case, register
   PMU without Psys event support when probing TPMI RAPL Package 0, and
   re-register the PMU with Psys event support when probing Package 1.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/powercap/intel_rapl_common.c | 536 +++++++++++++++++++++++++++
 include/linux/intel_rapl.h           |  17 +
 2 files changed, 553 insertions(+)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 315e304219e2..318174c87249 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -15,6 +15,8 @@
 #include <linux/list.h>
 #include <linux/log2.h>
 #include <linux/module.h>
+#include <linux/nospec.h>
+#include <linux/perf_event.h>
 #include <linux/platform_device.h>
 #include <linux/powercap.h>
 #include <linux/processor.h>
@@ -1506,6 +1508,532 @@ static int rapl_detect_domains(struct rapl_package *rp)
 	return 0;
 }
 
+#ifdef CONFIG_PERF_EVENTS
+
+/* Support for RAPL PMU */
+
+struct rapl_pmu {
+	struct pmu pmu;
+	u64 timer_ms;
+	cpumask_t cpu_mask;
+	unsigned long domain_map;	/* Events supported by all registered RAPL packages */
+	bool registered;
+};
+
+static struct rapl_pmu rapl_pmu;
+
+/* PMU helpers */
+static int get_pmu_cpu(struct rapl_package *rp)
+{
+	int cpu;
+
+	if (!rp->priv->enable_pmu)
+		return nr_cpu_ids;
+
+	/* MSR RAPL uses rp->lead_cpu for PMU */
+	if (rp->lead_cpu >= 0)
+		return rp->lead_cpu;
+
+	/* TPMI RAPL uses any CPU in the package for PMU */
+	for_each_online_cpu(cpu)
+		if (topology_physical_package_id(cpu) == rp->id)
+			return cpu;
+
+	return nr_cpu_ids;
+}
+
+static bool is_rp_pmu_cpu(struct rapl_package *rp, int cpu)
+{
+	if (!rp->priv->enable_pmu)
+		return false;
+
+	/* MSR RAPL uses rp->lead_cpu for PMU */
+	if (rp->lead_cpu >= 0)
+		return cpu == rp->lead_cpu;
+
+	/* TPMI RAPL uses any CPU in the package for PMU */
+	return topology_physical_package_id(cpu) == rp->id;
+}
+
+static struct rapl_package_pmu_data *event_to_pmu_data(struct perf_event *event)
+{
+	struct rapl_package *rp = event->pmu_private;
+
+	return &rp->pmu_data;
+}
+
+/* PMU event callbacks */
+
+/* Return 0 for unsupported events or failed read */
+static u64 event_read_counter(struct perf_event *event)
+{
+	struct rapl_package *rp = event->pmu_private;
+	u64 val;
+	int ret;
+
+	if (event->hw.idx < 0)
+		return 0;
+
+	ret = rapl_read_data_raw(&rp->domains[event->hw.idx], ENERGY_COUNTER, false, &val);
+	return ret ? 0 : val;
+}
+
+static void __rapl_pmu_event_start(struct perf_event *event)
+{
+	struct rapl_package_pmu_data *data = event_to_pmu_data(event);
+
+	if (WARN_ON_ONCE(!(event->hw.state & PERF_HES_STOPPED)))
+		return;
+
+	event->hw.state = 0;
+
+	list_add_tail(&event->active_entry, &data->active_list);
+
+	local64_set(&event->hw.prev_count, event_read_counter(event));
+	if (++data->n_active == 1)
+		hrtimer_start(&data->hrtimer, data->timer_interval,
+			      HRTIMER_MODE_REL_PINNED);
+}
+
+static void rapl_pmu_event_start(struct perf_event *event, int mode)
+{
+	struct rapl_package_pmu_data *data = event_to_pmu_data(event);
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&data->lock, flags);
+	__rapl_pmu_event_start(event);
+	raw_spin_unlock_irqrestore(&data->lock, flags);
+}
+
+static u64 rapl_event_update(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	struct rapl_package_pmu_data *data = event_to_pmu_data(event);
+	u64 prev_raw_count, new_raw_count;
+	s64 delta, sdelta;
+
+again:
+	prev_raw_count = local64_read(&hwc->prev_count);
+	new_raw_count = event_read_counter(event);
+
+	if (local64_cmpxchg(&hwc->prev_count, prev_raw_count,
+			new_raw_count) != prev_raw_count)
+		goto again;
+
+	/*
+	 * Now we have the new raw value and have updated the prev
+	 * timestamp already. We can now calculate the elapsed delta
+	 * (event-)time and add that to the generic event.
+	 */
+	delta = new_raw_count - prev_raw_count;
+
+	/*
+	 * Scale delta to smallest unit (2^-32)
+	 * users must then scale back: count * 1/(1e9*2^32) to get Joules
+	 * or use ldexp(count, -32).
+	 * Watts = Joules/Time delta
+	 */
+	sdelta = delta * data->scale[event->hw.flags];
+
+	local64_add(sdelta, &event->count);
+
+	return new_raw_count;
+}
+
+static void rapl_pmu_event_stop(struct perf_event *event, int mode)
+{
+	struct rapl_package_pmu_data *data = event_to_pmu_data(event);
+	struct hw_perf_event *hwc = &event->hw;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&data->lock, flags);
+
+	/* Mark event as deactivated and stopped */
+	if (!(hwc->state & PERF_HES_STOPPED)) {
+		WARN_ON_ONCE(data->n_active <= 0);
+		if (--data->n_active == 0)
+			hrtimer_cancel(&data->hrtimer);
+
+		list_del(&event->active_entry);
+
+		WARN_ON_ONCE(hwc->state & PERF_HES_STOPPED);
+		hwc->state |= PERF_HES_STOPPED;
+	}
+
+	/* Check if update of sw counter is necessary */
+	if ((mode & PERF_EF_UPDATE) && !(hwc->state & PERF_HES_UPTODATE)) {
+		/*
+		 * Drain the remaining delta count out of a event
+		 * that we are disabling:
+		 */
+		rapl_event_update(event);
+		hwc->state |= PERF_HES_UPTODATE;
+	}
+
+	raw_spin_unlock_irqrestore(&data->lock, flags);
+}
+
+static int rapl_pmu_event_add(struct perf_event *event, int mode)
+{
+	struct rapl_package_pmu_data *data = event_to_pmu_data(event);
+	struct hw_perf_event *hwc = &event->hw;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&data->lock, flags);
+
+	hwc->state = PERF_HES_UPTODATE | PERF_HES_STOPPED;
+
+	if (mode & PERF_EF_START)
+		__rapl_pmu_event_start(event);
+
+	raw_spin_unlock_irqrestore(&data->lock, flags);
+
+	return 0;
+}
+
+static void rapl_pmu_event_del(struct perf_event *event, int flags)
+{
+	rapl_pmu_event_stop(event, PERF_EF_UPDATE);
+}
+
+/*
+ * RAPL energy status counters
+ */
+enum perf_rapl_events {
+	PERF_RAPL_PP0 = 0,	/* all cores */
+	PERF_RAPL_PKG,		/* entire package */
+	PERF_RAPL_RAM,		/* DRAM */
+	PERF_RAPL_PP1,		/* gpu */
+	PERF_RAPL_PSYS,		/* psys */
+};
+#define RAPL_EVENT_MASK GENMASK(7, 0)
+
+static int event_to_domain(int event)
+{
+	switch (event) {
+	case PERF_RAPL_PP0:
+		return RAPL_DOMAIN_PP0;
+	case PERF_RAPL_PKG:
+		return RAPL_DOMAIN_PACKAGE;
+	case PERF_RAPL_RAM:
+		return RAPL_DOMAIN_DRAM;
+	case PERF_RAPL_PP1:
+		return RAPL_DOMAIN_PP1;
+	case PERF_RAPL_PSYS:
+		return RAPL_DOMAIN_PLATFORM;
+	default:
+		return RAPL_DOMAIN_MAX;
+	}
+}
+
+static int rapl_pmu_event_init(struct perf_event *event)
+{
+	struct rapl_package *pos, *rp = NULL;
+	u64 cfg = event->attr.config & RAPL_EVENT_MASK;
+	int domain, idx;
+
+	/* Only look at RAPL events */
+	if (event->attr.type != event->pmu->type)
+		return -ENOENT;
+
+	/* Check only supported bits are set */
+	if (event->attr.config & ~RAPL_EVENT_MASK)
+		return -EINVAL;
+
+	if (event->cpu < 0)
+		return -EINVAL;
+
+	list_for_each_entry(pos, &rapl_packages, plist) {
+		if (is_rp_pmu_cpu(pos, event->cpu)) {
+			rp = pos;
+			break;
+		}
+	}
+	if (!rp)
+		return -ENODEV;
+
+	domain = event_to_domain(cfg - 1);
+	if (domain >= RAPL_DOMAIN_MAX)
+		return -EINVAL;
+
+	event->event_caps |= PERF_EV_CAP_READ_ACTIVE_PKG;
+	event->pmu_private = rp;	/* Which package */
+	event->hw.flags = domain;	/* Which domain */
+	event->hw.idx = -1;		/* Index in rp->domains[] to get domain pointer */
+	for (idx = 0; idx < rp->nr_domains; idx++) {
+		if (rp->domains[idx].id == domain) {
+			event->hw.idx = idx;
+			break;
+		}
+	}
+
+	return 0;
+}
+
+static void rapl_pmu_event_read(struct perf_event *event)
+{
+	rapl_event_update(event);
+}
+
+static enum hrtimer_restart rapl_hrtimer_handle(struct hrtimer *hrtimer)
+{
+	struct rapl_package_pmu_data *data =
+		container_of(hrtimer, struct rapl_package_pmu_data, hrtimer);
+	struct perf_event *event;
+	unsigned long flags;
+
+	if (!data->n_active)
+		return HRTIMER_NORESTART;
+
+	raw_spin_lock_irqsave(&data->lock, flags);
+
+	list_for_each_entry(event, &data->active_list, active_entry)
+		rapl_event_update(event);
+
+	raw_spin_unlock_irqrestore(&data->lock, flags);
+
+	hrtimer_forward_now(hrtimer, data->timer_interval);
+
+	return HRTIMER_RESTART;
+}
+
+/* PMU sysfs attributes */
+
+/*
+ * There are no default events, but we need to create "events" group (with
+ * empty attrs) before updating it with detected events.
+ */
+static struct attribute *attrs_empty[] = {
+	NULL,
+};
+
+static struct attribute_group pmu_events_group = {
+	.name = "events",
+	.attrs = attrs_empty,
+};
+
+static ssize_t cpumask_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	struct rapl_package *rp;
+	int cpu;
+
+	cpus_read_lock();
+	cpumask_clear(&rapl_pmu.cpu_mask);
+
+	/* Choose a cpu for each RAPL Package */
+	list_for_each_entry(rp, &rapl_packages, plist) {
+		cpu = get_pmu_cpu(rp);
+		if (cpu < nr_cpu_ids)
+			cpumask_set_cpu(cpu, &rapl_pmu.cpu_mask);
+	}
+	cpus_read_unlock();
+
+	return cpumap_print_to_pagebuf(true, buf, &rapl_pmu.cpu_mask);
+}
+
+static DEVICE_ATTR_RO(cpumask);
+
+static struct attribute *pmu_cpumask_attrs[] = {
+	&dev_attr_cpumask.attr,
+	NULL
+};
+
+static struct attribute_group pmu_cpumask_group = {
+	.attrs = pmu_cpumask_attrs,
+};
+
+PMU_FORMAT_ATTR(event, "config:0-7");
+static struct attribute *pmu_format_attr[] = {
+	&format_attr_event.attr,
+	NULL
+};
+
+static struct attribute_group pmu_format_group = {
+	.name = "format",
+	.attrs = pmu_format_attr,
+};
+
+static const struct attribute_group *pmu_attr_groups[] = {
+	&pmu_events_group,
+	&pmu_cpumask_group,
+	&pmu_format_group,
+	NULL
+};
+
+#define RAPL_EVENT_ATTR_STR(_name, v, str)					\
+static struct perf_pmu_events_attr event_attr_##v = {				\
+	.attr		= __ATTR(_name, 0444, perf_event_sysfs_show, NULL),	\
+	.event_str	= str,							\
+}
+
+RAPL_EVENT_ATTR_STR(energy-cores,	rapl_cores,	"event=0x01");
+RAPL_EVENT_ATTR_STR(energy-pkg,		rapl_pkg,	"event=0x02");
+RAPL_EVENT_ATTR_STR(energy-ram,		rapl_ram,	"event=0x03");
+RAPL_EVENT_ATTR_STR(energy-gpu,		rapl_gpu,	"event=0x04");
+RAPL_EVENT_ATTR_STR(energy-psys,	rapl_psys,	"event=0x05");
+
+RAPL_EVENT_ATTR_STR(energy-cores.unit,	rapl_unit_cores,	"Joules");
+RAPL_EVENT_ATTR_STR(energy-pkg.unit,	rapl_unit_pkg,		"Joules");
+RAPL_EVENT_ATTR_STR(energy-ram.unit,	rapl_unit_ram,		"Joules");
+RAPL_EVENT_ATTR_STR(energy-gpu.unit,	rapl_unit_gpu,		"Joules");
+RAPL_EVENT_ATTR_STR(energy-psys.unit,	rapl_unit_psys,		"Joules");
+
+RAPL_EVENT_ATTR_STR(energy-cores.scale,	rapl_scale_cores,	"2.3283064365386962890625e-10");
+RAPL_EVENT_ATTR_STR(energy-pkg.scale,	rapl_scale_pkg,		"2.3283064365386962890625e-10");
+RAPL_EVENT_ATTR_STR(energy-ram.scale,	rapl_scale_ram,		"2.3283064365386962890625e-10");
+RAPL_EVENT_ATTR_STR(energy-gpu.scale,	rapl_scale_gpu,		"2.3283064365386962890625e-10");
+RAPL_EVENT_ATTR_STR(energy-psys.scale,	rapl_scale_psys,	"2.3283064365386962890625e-10");
+
+#define RAPL_EVENT_GROUP(_name, domain)			\
+static struct attribute *pmu_attr_##_name[] = {		\
+	&event_attr_rapl_##_name.attr.attr,		\
+	&event_attr_rapl_unit_##_name.attr.attr,	\
+	&event_attr_rapl_scale_##_name.attr.attr,	\
+	NULL						\
+};							\
+static umode_t is_visible_##_name(struct kobject *kobj, struct attribute *attr, int event)	\
+{											\
+	return rapl_pmu.domain_map & BIT(domain) ? attr->mode : 0;	\
+}							\
+static struct attribute_group pmu_group_##_name = {	\
+	.name  = "events",				\
+	.attrs = pmu_attr_##_name,			\
+	.is_visible = is_visible_##_name,		\
+}
+
+RAPL_EVENT_GROUP(cores,	RAPL_DOMAIN_PP0);
+RAPL_EVENT_GROUP(pkg,	RAPL_DOMAIN_PACKAGE);
+RAPL_EVENT_GROUP(ram,	RAPL_DOMAIN_DRAM);
+RAPL_EVENT_GROUP(gpu,	RAPL_DOMAIN_PP1);
+RAPL_EVENT_GROUP(psys,	RAPL_DOMAIN_PLATFORM);
+
+static const struct attribute_group *pmu_attr_update[] = {
+	&pmu_group_cores,
+	&pmu_group_pkg,
+	&pmu_group_ram,
+	&pmu_group_gpu,
+	&pmu_group_psys,
+	NULL
+};
+
+static int rapl_pmu_update(struct rapl_package *rp)
+{
+	int ret;
+
+	/* Return if PMU already covers all events supported by current RAPL Package */
+	if (rapl_pmu.registered && !(rp->domain_map & (~rapl_pmu.domain_map)))
+		return 0;
+
+	/* Unregister previous registered PMU */
+	if (rapl_pmu.registered) {
+		perf_pmu_unregister(&rapl_pmu.pmu);
+		memset(&rapl_pmu.pmu, 0, sizeof(struct pmu));
+	}
+
+	rapl_pmu.domain_map |= rp->domain_map;
+
+	memset(&rapl_pmu.pmu, 0, sizeof(struct pmu));
+	rapl_pmu.pmu.attr_groups = pmu_attr_groups;
+	rapl_pmu.pmu.attr_update = pmu_attr_update;
+	rapl_pmu.pmu.task_ctx_nr = perf_invalid_context;
+	rapl_pmu.pmu.event_init = rapl_pmu_event_init;
+	rapl_pmu.pmu.add = rapl_pmu_event_add;
+	rapl_pmu.pmu.del = rapl_pmu_event_del;
+	rapl_pmu.pmu.start = rapl_pmu_event_start;
+	rapl_pmu.pmu.stop = rapl_pmu_event_stop;
+	rapl_pmu.pmu.read = rapl_pmu_event_read;
+	rapl_pmu.pmu.module = THIS_MODULE;
+	rapl_pmu.pmu.capabilities = PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_NO_INTERRUPT;
+	ret = perf_pmu_register(&rapl_pmu.pmu, "power", -1);
+	if (ret)
+		pr_warn("Failed to register PMU\n");
+
+	rapl_pmu.registered = !ret;
+
+	return ret;
+}
+
+static int rapl_package_add_pmu(struct rapl_package *rp)
+{
+	struct rapl_package_pmu_data *data = &rp->pmu_data;
+	int idx;
+
+	if (!rp->priv->enable_pmu)
+		return 0;
+
+	for (idx = 0; idx < rp->nr_domains; idx++) {
+		struct rapl_domain *rd = &rp->domains[idx];
+		int domain = rd->id;
+		u64 val;
+
+		if (!test_bit(domain, &rp->domain_map))
+			continue;
+
+		/*
+		 * The RAPL PMU granularity is 2^-32 Joules
+		 * data->scale[]: times of 2^-32 Joules for each ENERGY COUNTER increase
+		 */
+		val = rd->energy_unit * (1ULL << 32);
+		do_div(val, ENERGY_UNIT_SCALE * 1000000);
+		data->scale[domain] = val;
+
+		if (!rapl_pmu.timer_ms) {
+			struct rapl_primitive_info *rpi = get_rpi(rp, ENERGY_COUNTER);
+
+
+			/*
+			 * Calculate the timer rate:
+			 * Use reference of 200W for scaling the timeout to avoid counter
+			 * overflows.
+			 *
+			 * max_count = rpi->mask >> rpi->shift + 1
+			 * max_energy_pj = max_count * rd->energy_unit
+			 * max_time_sec = (max_energy_pj / 1000000000) / 200w
+			 *
+			 * rapl_pmu.timer_ms = max_time_sec * 1000 / 2
+			 */
+			val = (rpi->mask >> rpi->shift) + 1;
+			val *= rd->energy_unit;
+			do_div(val, 1000000 * 200 * 2);
+			rapl_pmu.timer_ms = val;
+
+			pr_info("%llu ms ovfl timer\n", rapl_pmu.timer_ms);
+		}
+
+		pr_info("Domain %s: hw unit %lld * 2^-32 Joules\n", rd->name, data->scale[domain]);
+	}
+
+	/* Initialize per package PMU data */
+	raw_spin_lock_init(&data->lock);
+	INIT_LIST_HEAD(&data->active_list);
+	data->timer_interval = ms_to_ktime(rapl_pmu.timer_ms);
+	hrtimer_init(&data->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	data->hrtimer.function = rapl_hrtimer_handle;
+
+	return rapl_pmu_update(rp);
+}
+
+static void rapl_package_remove_pmu(struct rapl_package *rp)
+{
+	struct rapl_package *pos;
+
+	if (!rp->priv->enable_pmu || !rapl_pmu.registered)
+		return;
+
+	list_for_each_entry(pos, &rapl_packages, plist) {
+		if (pos->priv->enable_pmu)
+			return;
+	}
+
+	perf_pmu_unregister(&rapl_pmu.pmu);
+	memset(&rapl_pmu, 0, sizeof(struct rapl_pmu));
+}
+#else
+static int rapl_package_add_pmu(struct rapl_package *rp) { return 0; }
+static void rapl_package_remove_pmu(struct rapl_package *rp) { }
+#endif
+
 /* called from CPU hotplug notifier, hotplug lock held */
 void rapl_remove_package_cpuslocked(struct rapl_package *rp)
 {
@@ -1534,6 +2062,8 @@ void rapl_remove_package_cpuslocked(struct rapl_package *rp)
 	powercap_unregister_zone(rp->priv->control_type,
 				 &rd_package->power_zone);
 	list_del(&rp->plist);
+	/* Do PMU update after rp removed from rapl_packages list */
+	rapl_package_remove_pmu(rp);
 	kfree(rp);
 }
 EXPORT_SYMBOL_GPL(rapl_remove_package_cpuslocked);
@@ -1613,6 +2143,12 @@ struct rapl_package *rapl_add_package_cpuslocked(int id, struct rapl_if_priv *pr
 	if (!ret) {
 		INIT_LIST_HEAD(&rp->plist);
 		list_add(&rp->plist, &rapl_packages);
+		/*
+		 * PMU failure does not affect the registered RAPL packages.
+		 * Thus it should not block the current RAPL package neither.
+		 * Ignore the return value.
+		 */
+		rapl_package_add_pmu(rp);
 		return rp;
 	}
 
diff --git a/include/linux/intel_rapl.h b/include/linux/intel_rapl.h
index f3196f82fd8a..6f27380d4bab 100644
--- a/include/linux/intel_rapl.h
+++ b/include/linux/intel_rapl.h
@@ -138,6 +138,7 @@ struct reg_action {
  * @reg_unit:			Register for getting energy/power/time unit.
  * @regs:			Register sets for different RAPL Domains.
  * @limits:			Number of power limits supported by each domain.
+ * @enable_pmu:			Enable Perf PMU for Domain energy counters.
  * @read_raw:			Callback for reading RAPL interface specific
  *				registers.
  * @write_raw:			Callback for writing RAPL interface specific
@@ -152,12 +153,25 @@ struct rapl_if_priv {
 	union rapl_reg reg_unit;
 	union rapl_reg regs[RAPL_DOMAIN_MAX][RAPL_DOMAIN_REG_MAX];
 	int limits[RAPL_DOMAIN_MAX];
+	bool enable_pmu;
 	int (*read_raw)(int id, struct reg_action *ra);
 	int (*write_raw)(int id, struct reg_action *ra);
 	void *defaults;
 	void *rpi;
 };
 
+#ifdef CONFIG_PERF_EVENTS
+struct rapl_package_pmu_data {
+	u64 scale[RAPL_DOMAIN_MAX];
+	raw_spinlock_t lock;
+	int n_active;
+	struct list_head active_list;
+	ktime_t timer_interval;
+	struct hrtimer hrtimer;
+	u8 domain_mask;
+};
+#endif
+
 /* maximum rapl package domain name: package-%d-die-%d */
 #define PACKAGE_DOMAIN_NAME_LENGTH 30
 
@@ -176,6 +190,9 @@ struct rapl_package {
 	struct cpumask cpumask;
 	char name[PACKAGE_DOMAIN_NAME_LENGTH];
 	struct rapl_if_priv *priv;
+#ifdef CONFIG_PERF_EVENTS
+	struct rapl_package_pmu_data pmu_data;
+#endif
 };
 
 struct rapl_package *rapl_find_package_domain_cpuslocked(int id, struct rapl_if_priv *priv,
-- 
2.34.1


