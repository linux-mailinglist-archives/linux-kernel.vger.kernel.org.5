Return-Path: <linux-kernel+bounces-83390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE6D8697BD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C7CD1C21C8B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216D913B798;
	Tue, 27 Feb 2024 14:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="hl4khlB0"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2D413B2B4
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 14:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709043872; cv=none; b=TPcDAWxCTZ2I88Lv4bn8mCwIiOsXM7ONIPQd9lhkuo9c+2KKeNzfKQxpbMXpXb440a4vTdbLhC3+5UTmIo1bph1Xcn1AH54XF4CntH7to7wL1yoc0qGuyh4mp6FfdslSrOR1BywCleFZpzjFWAxDX/x4RBrQkBDoR3/TJxxVn2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709043872; c=relaxed/simple;
	bh=svJ8doLT2AQdgyIKlvrkMHsN3B7MU3sRe807nvD36VE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DORJ80CuIfJ4lzCgIfsoxK3H/wAqIkqlOxCiDCACyWevbk8b66NuqSioQRadDX1ha/fmr3SQdYZqt48P4znCl7MfnWzWvUyLbaIPrg0uzMCgU5uzd1hruwgClMo8vzsOEl17ua4ma/prqZGYwMcdTosEAMZcf/krc74/LL5JoII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=hl4khlB0; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41R7nGnY028206;
	Tue, 27 Feb 2024 06:24:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=pfpt0220; bh=WfbsJj9v
	GZtx0SxZOrGBC6pyDj7Ubie1UW9/TisA3Sc=; b=hl4khlB0qbxLIhnLJf8coVhL
	iJl+fNkKCAK9hMdzIw7Bel/NdEbtjbEmQJC/aiGHyn/trzj2fDn1hPl6Beyjd7XL
	YEcHScAdX1SwQc1CzepRclEDQw62G7S2R4OC3Bhyq/dGTWVeXly8IE3bIsOj6c9c
	fPsmWGwjbxhsRxQmu/OlDPujTDbe9DSgurflCa8Xlhn9vndDCBRyoqOZwV+ulkKI
	BXnhHONn8TIVpZk6yp7EiFSexu4GUsu65RpvtqbS25DgbNCDx9HoI91EWEv7e4rj
	3DYtwcIhLTcviVmEgSsrmhCdk24GgA37TkUFC5zN+lUJiyS1flNK8u/062L3Fw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3whbpe112w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 06:24:21 -0800 (PST)
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 27 Feb
 2024 06:24:20 -0800
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH02.marvell.com (10.69.176.39) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Tue, 27 Feb 2024 06:24:19 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Tue, 27 Feb 2024 06:24:19 -0800
Received: from IPBU-BLR-SERVER1.marvell.com (IPBU-BLR-SERVER1.marvell.com [10.28.8.41])
	by maili.marvell.com (Postfix) with ESMTP id A299A3F717E;
	Tue, 27 Feb 2024 06:24:16 -0800 (PST)
From: Gowthami Thiagarajan <gthiagarajan@marvell.com>
To: <will@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <gcherian@marvell.com>, <lcherian@marvell.com>,
        Gowthami Thiagarajan <gthiagarajan@marvell.com>
Subject: [PATCH v3] perf/marvell: Marvell PEM performance monitor support
Date: Tue, 27 Feb 2024 19:54:14 +0530
Message-ID: <20240227142414.3431984-1-gthiagarajan@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: AhhDXFJyzknWz9PC2sx3DH7-064eKnrZ
X-Proofpoint-ORIG-GUID: AhhDXFJyzknWz9PC2sx3DH7-064eKnrZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-27_01,2023-05-22_02

PCI Express Interface PMU includes various performance counters
to monitor the data that is transmitted over the PCIe link. The
counters track various inbound and outbound transactions which
includes separate counters for posted/non-posted/completion TLPs.
Also, inbound and outbound memory read requests along with their
latencies can also be monitored. Address Translation Services(ATS)events
such as ATS Translation, ATS Page Request, ATS Invalidation along with
their corresponding latencies are also supported.

The performance counters are 64 bits wide.

For instance,
perf stat -e ib_tlp_pr <workload>
tracks the inbound posted TLPs for the workload.

Signed-off-by: Gowthami Thiagarajan <gthiagarajan@marvell.com>
---
v2->v3 changes:
- Dropped device tree support as the acpi table based probing is used.

 MAINTAINERS                    |   6 +
 drivers/perf/Kconfig           |   7 +
 drivers/perf/Makefile          |   1 +
 drivers/perf/marvell_pem_pmu.c | 428 +++++++++++++++++++++++++++++++++
 include/linux/cpuhotplug.h     |   1 +
 5 files changed, 443 insertions(+)
 create mode 100644 drivers/perf/marvell_pem_pmu.c

diff --git a/MAINTAINERS b/MAINTAINERS
index dd5de540ec0b..50c11e128a98 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12759,6 +12759,12 @@ S:	Supported
 F:	Documentation/networking/device_drivers/ethernet/marvell/octeontx2.rst
 F:	drivers/net/ethernet/marvell/octeontx2/af/
 
+MARVELL PEM PMU DRIVER
+M:	Linu Cherian <lcherian@marvell.com>
+M:	Gowthami Thiagarajan <gthiagarajan@marvell.com>
+S:	Supported
+F:	drivers/perf/marvell_pem_pmu.c
+
 MARVELL PRESTERA ETHERNET SWITCH DRIVER
 M:	Taras Chornyi <taras.chornyi@plvision.eu>
 S:	Supported
diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index 273d67ecf6d2..12ac8409263a 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -234,4 +234,11 @@ config CXL_PMU
 
 	  If unsure say 'm'.
 
+config MARVELL_PEM_PMU
+	tristate "MARVELL PEM PMU Support"
+	depends on ARCH_THUNDER || (COMPILE_TEST && 64BIT)
+	help
+	  Enable support for PCIe Interface performance monitoring
+	  on Marvell platform.
+
 endmenu
diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
index 16b3ec4db916..db3c473cc5c7 100644
--- a/drivers/perf/Makefile
+++ b/drivers/perf/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_ARM_SPE_PMU) += arm_spe_pmu.o
 obj-$(CONFIG_ARM_DMC620_PMU) += arm_dmc620_pmu.o
 obj-$(CONFIG_MARVELL_CN10K_TAD_PMU) += marvell_cn10k_tad_pmu.o
 obj-$(CONFIG_MARVELL_CN10K_DDR_PMU) += marvell_cn10k_ddr_pmu.o
+obj-$(CONFIG_MARVELL_PEM_PMU) += marvell_pem_pmu.o
 obj-$(CONFIG_APPLE_M1_CPU_PMU) += apple_m1_cpu_pmu.o
 obj-$(CONFIG_ALIBABA_UNCORE_DRW_PMU) += alibaba_uncore_drw_pmu.o
 obj-$(CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU) += arm_cspmu/
diff --git a/drivers/perf/marvell_pem_pmu.c b/drivers/perf/marvell_pem_pmu.c
new file mode 100644
index 000000000000..d4175483b982
--- /dev/null
+++ b/drivers/perf/marvell_pem_pmu.c
@@ -0,0 +1,428 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Marvell PEM(PCIe RC) Performance Monitor Driver
+ *
+ * Copyright (C) 2024 Marvell.
+ */
+
+#include <linux/acpi.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/perf_event.h>
+
+/*
+ * Each of these events maps to a free running 64 bit counter
+ * with no event control, but can be reset.
+ *
+ */
+enum pem_events {
+	IB_TLP_NPR,
+	IB_TLP_PR,
+	IB_TLP_CPL,
+	IB_TLP_DWORDS_NPR,
+	IB_TLP_DWORDS_PR,
+	IB_TLP_DWORDS_CPL,
+	IB_INFLIGHT,
+	IB_READS,
+	IB_REQ_NO_RO_NCB,
+	IB_REQ_NO_RO_EBUS,
+	OB_TLP_NPR,
+	OB_TLP_PR,
+	OB_TLP_CPL,
+	OB_TLP_DWORDS_NPR,
+	OB_TLP_DWORDS_PR,
+	OB_TLP_DWORDS_CPL,
+	OB_INFLIGHT,
+	OB_READS,
+	OB_MERGES_NPR,
+	OB_MERGES_PR,
+	OB_MERGES_CPL,
+	ATS_TRANS,
+	ATS_TRANS_LATENCY,
+	ATS_PRI,
+	ATS_PRI_LATENCY,
+	ATS_INV,
+	ATS_INV_LATENCY,
+	PEM_EVENTIDS_MAX,
+};
+
+static u64 eventid_to_offset_table[] = {
+	[IB_TLP_NPR]	     = 0x0,
+	[IB_TLP_PR]	     = 0x8,
+	[IB_TLP_CPL]	     = 0x10,
+	[IB_TLP_DWORDS_NPR]  = 0x100,
+	[IB_TLP_DWORDS_PR]   = 0x108,
+	[IB_TLP_DWORDS_CPL]  = 0x110,
+	[IB_INFLIGHT]	     = 0x200,
+	[IB_READS]	     = 0x300,
+	[IB_REQ_NO_RO_NCB]   = 0x400,
+	[IB_REQ_NO_RO_EBUS]  = 0x408,
+	[OB_TLP_NPR]         = 0x500,
+	[OB_TLP_PR]          = 0x508,
+	[OB_TLP_CPL]         = 0x510,
+	[OB_TLP_DWORDS_NPR]  = 0x600,
+	[OB_TLP_DWORDS_PR]   = 0x608,
+	[OB_TLP_DWORDS_CPL]  = 0x610,
+	[OB_INFLIGHT]        = 0x700,
+	[OB_READS]	     = 0x800,
+	[OB_MERGES_NPR]      = 0x900,
+	[OB_MERGES_PR]       = 0x908,
+	[OB_MERGES_CPL]      = 0x910,
+	[ATS_TRANS]          = 0x2D18,
+	[ATS_TRANS_LATENCY]  = 0x2D20,
+	[ATS_PRI]            = 0x2D28,
+	[ATS_PRI_LATENCY]    = 0x2D30,
+	[ATS_INV]            = 0x2D38,
+	[ATS_INV_LATENCY]    = 0x2D40,
+};
+
+struct pem_pmu {
+	struct pmu pmu;
+	void __iomem *base;
+	unsigned int cpu;
+	struct	device *dev;
+	struct hlist_node node;
+};
+
+#define to_pem_pmu(p)	container_of(p, struct pem_pmu, pmu)
+
+static int eventid_to_offset(int eventid)
+{
+	return eventid_to_offset_table[eventid];
+}
+
+/* Events */
+static ssize_t pem_pmu_event_show(struct device *dev,
+				  struct device_attribute *attr,
+				  char *page)
+{
+	struct perf_pmu_events_attr *pmu_attr;
+
+	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
+	return sysfs_emit(page, "event=0x%02llx\n", pmu_attr->id);
+}
+
+#define PEM_EVENT_ATTR(_name, _id)					\
+	(&((struct perf_pmu_events_attr[]) {				\
+	{ .attr = __ATTR(_name, 0444, pem_pmu_event_show, NULL),	\
+		.id = _id, }						\
+	})[0].attr.attr)
+
+static struct attribute *pem_perf_events_attrs[] = {
+	PEM_EVENT_ATTR(ib_tlp_npr, IB_TLP_NPR),
+	PEM_EVENT_ATTR(ib_tlp_pr, IB_TLP_PR),
+	PEM_EVENT_ATTR(ib_tlp_cpl_partid, IB_TLP_CPL),
+	PEM_EVENT_ATTR(ib_tlp_dwords_npr, IB_TLP_DWORDS_NPR),
+	PEM_EVENT_ATTR(ib_tlp_dwords_pr, IB_TLP_DWORDS_PR),
+	PEM_EVENT_ATTR(ib_tlp_dwords_cpl_partid, IB_TLP_DWORDS_CPL),
+	PEM_EVENT_ATTR(ib_inflight, IB_INFLIGHT),
+	PEM_EVENT_ATTR(ib_reads, IB_READS),
+	PEM_EVENT_ATTR(ib_req_no_ro_ncb, IB_REQ_NO_RO_NCB),
+	PEM_EVENT_ATTR(ib_req_no_ro_ebus, IB_REQ_NO_RO_EBUS),
+	PEM_EVENT_ATTR(ob_tlp_npr_partid, OB_TLP_NPR),
+	PEM_EVENT_ATTR(ob_tlp_pr_partid, OB_TLP_PR),
+	PEM_EVENT_ATTR(ob_tlp_cpl_partid, OB_TLP_CPL),
+	PEM_EVENT_ATTR(ob_tlp_dwords_npr_partid, OB_TLP_DWORDS_NPR),
+	PEM_EVENT_ATTR(ob_tlp_dwords_pr_partid, OB_TLP_DWORDS_PR),
+	PEM_EVENT_ATTR(ob_tlp_dwords_cpl_partid, OB_TLP_DWORDS_CPL),
+	PEM_EVENT_ATTR(ob_inflight_partid, OB_INFLIGHT),
+	PEM_EVENT_ATTR(ob_reads_partid, OB_READS),
+	PEM_EVENT_ATTR(ob_merges_npr_partid, OB_MERGES_NPR),
+	PEM_EVENT_ATTR(ob_merges_pr_partid, OB_MERGES_PR),
+	PEM_EVENT_ATTR(ob_merges_cpl_partid, OB_MERGES_CPL),
+	PEM_EVENT_ATTR(ats_trans, ATS_TRANS),
+	PEM_EVENT_ATTR(ats_trans_latency, ATS_TRANS_LATENCY),
+	PEM_EVENT_ATTR(ats_pri, ATS_PRI),
+	PEM_EVENT_ATTR(ats_pri_latency, ATS_PRI_LATENCY),
+	PEM_EVENT_ATTR(ats_inv, ATS_INV),
+	PEM_EVENT_ATTR(ats_inv_latency, ATS_INV_LATENCY),
+	NULL
+};
+
+static struct attribute_group pem_perf_events_attr_group = {
+	.name = "events",
+	.attrs = pem_perf_events_attrs,
+};
+
+PMU_FORMAT_ATTR(event, "config:0-5");
+
+static struct attribute *pem_perf_format_attrs[] = {
+	&format_attr_event.attr,
+	NULL
+};
+
+static struct attribute_group pem_perf_format_attr_group = {
+	.name = "format",
+	.attrs = pem_perf_format_attrs,
+};
+
+/* cpumask */
+static ssize_t pem_perf_cpumask_show(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	struct pem_pmu *pmu = dev_get_drvdata(dev);
+
+	return cpumap_print_to_pagebuf(true, buf, cpumask_of(pmu->cpu));
+}
+
+static struct device_attribute pem_perf_cpumask_attr =
+	__ATTR(cpumask, 0444, pem_perf_cpumask_show, NULL);
+
+static struct attribute *pem_perf_cpumask_attrs[] = {
+	&pem_perf_cpumask_attr.attr,
+	NULL
+};
+
+static struct attribute_group pem_perf_cpumask_attr_group = {
+	.attrs = pem_perf_cpumask_attrs,
+};
+
+static const struct attribute_group *pem_perf_attr_groups[] = {
+	&pem_perf_events_attr_group,
+	&pem_perf_cpumask_attr_group,
+	&pem_perf_format_attr_group,
+	NULL
+};
+
+static int pem_perf_event_init(struct perf_event *event)
+{
+	struct pem_pmu *pmu = to_pem_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (event->attr.type != event->pmu->type)
+		return -ENOENT;
+
+	if (is_sampling_event(event) ||
+	    event->attach_state & PERF_ATTACH_TASK) {
+		return -EOPNOTSUPP;
+	}
+
+	if (event->cpu < 0)
+		return -EOPNOTSUPP;
+
+	/*  We must NOT create groups containing mixed PMUs */
+	if (event->group_leader->pmu != event->pmu &&
+	    !is_software_event(event->group_leader))
+		return -EINVAL;
+
+	/*
+	 * Set ownership of event to one CPU, same event can not be observed
+	 * on multiple cpus at same time.
+	 */
+	event->cpu = pmu->cpu;
+	hwc->idx = -1;
+	return 0;
+}
+
+static void pem_perf_counter_reset(struct pem_pmu *pmu,
+				   struct perf_event *event, int eventid)
+{
+	writeq_relaxed(0x0, pmu->base + eventid_to_offset(eventid));
+}
+
+static u64 pem_perf_read_counter(struct pem_pmu *pmu,
+				 struct perf_event *event, int eventid)
+{
+	return readq_relaxed(pmu->base + eventid_to_offset(eventid));
+}
+
+static void pem_perf_event_update(struct perf_event *event)
+{
+	struct pem_pmu *pmu = to_pem_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	u64 prev_count, new_count;
+
+	do {
+		prev_count = local64_read(&hwc->prev_count);
+		new_count = pem_perf_read_counter(pmu, event, hwc->idx);
+	} while (local64_xchg(&hwc->prev_count, new_count) != prev_count);
+
+	local64_add((new_count - prev_count), &event->count);
+}
+
+static void pem_perf_event_start(struct perf_event *event, int flags)
+{
+	struct pem_pmu *pmu = to_pem_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	int eventid = hwc->idx;
+
+	local64_set(&hwc->prev_count, 0);
+
+	pem_perf_counter_reset(pmu, event, eventid);
+
+	hwc->state = 0;
+}
+
+static int pem_perf_event_add(struct perf_event *event, int flags)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	hwc->idx = event->attr.config;
+	if (hwc->idx >= PEM_EVENTIDS_MAX)
+		return -EINVAL;
+	hwc->state |= PERF_HES_STOPPED;
+
+	if (flags & PERF_EF_START)
+		pem_perf_event_start(event, flags);
+
+	return 0;
+}
+
+static void pem_perf_event_stop(struct perf_event *event, int flags)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (flags & PERF_EF_UPDATE)
+		pem_perf_event_update(event);
+
+	hwc->state |= PERF_HES_STOPPED;
+}
+
+static void pem_perf_event_del(struct perf_event *event, int flags)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	pem_perf_event_stop(event, PERF_EF_UPDATE);
+	hwc->idx = -1;
+}
+
+static int pem_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
+{
+	struct pem_pmu *pmu = hlist_entry_safe(node, struct pem_pmu,
+					       node);
+	unsigned int target;
+
+	if (cpu != pmu->cpu)
+		return 0;
+
+	target = cpumask_any_but(cpu_online_mask, cpu);
+	if (target >= nr_cpu_ids)
+		return 0;
+
+	perf_pmu_migrate_context(&pmu->pmu, cpu, target);
+	pmu->cpu = target;
+	return 0;
+}
+
+static int pem_perf_probe(struct platform_device *pdev)
+{
+	struct pem_pmu *pem_pmu;
+	struct resource *res;
+	void __iomem *base;
+	char *name;
+	int ret;
+
+	pem_pmu = devm_kzalloc(&pdev->dev, sizeof(*pem_pmu), GFP_KERNEL);
+	if (!pem_pmu)
+		return -ENOMEM;
+
+	pem_pmu->dev = &pdev->dev;
+	platform_set_drvdata(pdev, pem_pmu);
+
+	base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	pem_pmu->base = base;
+
+	pem_pmu->pmu = (struct pmu) {
+		.module	      = THIS_MODULE,
+		.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
+		.task_ctx_nr = perf_invalid_context,
+		.attr_groups = pem_perf_attr_groups,
+		.event_init  = pem_perf_event_init,
+		.add	     = pem_perf_event_add,
+		.del	     = pem_perf_event_del,
+		.start	     = pem_perf_event_start,
+		.stop	     = pem_perf_event_stop,
+		.read	     = pem_perf_event_update,
+	};
+
+	/* Choose this cpu to collect perf data */
+	pem_pmu->cpu = raw_smp_processor_id();
+
+	name = devm_kasprintf(pem_pmu->dev, GFP_KERNEL, "mrvl_pcie_rc_pmu_%llx",
+			      res->start);
+	if (!name)
+		return -ENOMEM;
+
+	cpuhp_state_add_instance_nocalls
+			(CPUHP_AP_PERF_ARM_MARVELL_PEM_ONLINE,
+			 &pem_pmu->node);
+
+	ret = perf_pmu_register(&pem_pmu->pmu, name, -1);
+	if (ret)
+		goto error;
+
+	pr_info("Marvell PEM(PCIe RC) PMU Driver for pem@%llx\n", res->start);
+	return 0;
+error:
+	cpuhp_state_remove_instance_nocalls
+			(CPUHP_AP_PERF_ARM_MARVELL_PEM_ONLINE,
+			 &pem_pmu->node);
+	return ret;
+}
+
+static int pem_perf_remove(struct platform_device *pdev)
+{
+	struct pem_pmu *pem_pmu = platform_get_drvdata(pdev);
+
+	cpuhp_state_remove_instance_nocalls
+			(CPUHP_AP_PERF_ARM_MARVELL_PEM_ONLINE,
+			 &pem_pmu->node);
+
+	perf_pmu_unregister(&pem_pmu->pmu);
+	return 0;
+}
+
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id pem_pmu_acpi_match[] = {
+	{"MRVL000E", 0},
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, pem_pmu_acpi_match);
+#endif
+
+static struct platform_driver pem_pmu_driver = {
+	.driver	= {
+		.name   = "pem-pmu",
+		.acpi_match_table = ACPI_PTR(pem_pmu_acpi_match),
+		.suppress_bind_attrs = true,
+	},
+	.probe		= pem_perf_probe,
+	.remove		= pem_perf_remove,
+};
+
+static int __init pem_pmu_init(void)
+{
+	int ret;
+
+	ret = cpuhp_setup_state_multi(CPUHP_AP_PERF_ARM_MARVELL_PEM_ONLINE,
+				      "perf/marvell/pem:online", NULL,
+				       pem_pmu_offline_cpu);
+	if (ret)
+		return ret;
+
+	ret = platform_driver_register(&pem_pmu_driver);
+	if (ret)
+		cpuhp_remove_multi_state(CPUHP_AP_PERF_ARM_MARVELL_PEM_ONLINE);
+	return ret;
+}
+
+static void __exit pem_pmu_exit(void)
+{
+	platform_driver_unregister(&pem_pmu_driver);
+	cpuhp_remove_multi_state(CPUHP_AP_PERF_ARM_MARVELL_PEM_ONLINE);
+}
+
+module_init(pem_pmu_init);
+module_exit(pem_pmu_exit);
+
+MODULE_DESCRIPTION("Marvell PEM Perf driver");
+MODULE_AUTHOR("Linu Cherian <lcherian@marvell.com>");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 624d4a38c358..9bf34f66e5f5 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -238,6 +238,7 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_ARM_APM_XGENE_ONLINE,
 	CPUHP_AP_PERF_ARM_CAVIUM_TX2_UNCORE_ONLINE,
 	CPUHP_AP_PERF_ARM_MARVELL_CN10K_DDR_ONLINE,
+	CPUHP_AP_PERF_ARM_MARVELL_PEM_ONLINE,
 	CPUHP_AP_PERF_POWERPC_NEST_IMC_ONLINE,
 	CPUHP_AP_PERF_POWERPC_CORE_IMC_ONLINE,
 	CPUHP_AP_PERF_POWERPC_THREAD_IMC_ONLINE,
-- 
2.25.1


