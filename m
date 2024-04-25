Return-Path: <linux-kernel+bounces-158521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F3E8B219F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 984861F231D3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDA512C55D;
	Thu, 25 Apr 2024 12:30:05 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0E412BF38
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 12:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714048204; cv=none; b=QpeDdhK2xGyv6MSPiadSsbEUr4LNmeoXUgakAv0k69qeqOHbgsr6JmhBuOUg6fgumq3NNj3n5OVeMDrg8DnKU/bZT3I0J3ZaRq4gtLkA0moZJ1BLps+/jsg1lq0bPVYxiH25C+9H4CZ9RMC4Ib7Ul6cMXiLO848xqONfpG2NCtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714048204; c=relaxed/simple;
	bh=vlo+GEJjBw1zVlAqXMaXaWVDfHQJXuZ0S6RithIdOC0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MucWyqMPNCFXNE9MQkrPYG4NwOJU/xK2bp54kv3Leah8S0qxkE01PGmDydiwWWkTIBnVu3U5e8YYGquUnbYwkQq9EAWrh4MdO7U+8W9syu0c6KgAyrRjtRq0jogGSelT+B94kcQF9feu4WwELiJV5AeR5xsrTjdgHw0Mrr33QPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CFA9A1424;
	Thu, 25 Apr 2024 05:30:29 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CAA753F7BD;
	Thu, 25 Apr 2024 05:30:00 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org,
	mark.rutland@arm.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jialong.yang@shingroup.cn
Subject: [PATCH 2/3] perf: Add driver for Arm NI-700 interconnect PMU
Date: Thu, 25 Apr 2024 13:29:53 +0100
Message-Id: <eb471ea519d358880eda01c95fd1f11a63663907.1713972897.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1713972897.git.robin.murphy@arm.com>
References: <cover.1713972897.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Arm NI-700 Network-on-Chip Interconnect has a relatively
straightforward design with a hierarchy of voltage, power, and clock
domains, where each clock domain then contains a number of interface
units and a PMU which can monitor events thereon. As such, it begets a
relatively straightforward driver to interface those PMUs with perf.

Even more so than with arm-cmn, users will require detailed knowledge of
the wider system topology in order to meaningfully analyse anything,
since the interconnect itself cannot know what lies beyond the boundary
of each inscrutably-numbered interface. Given that, for now they are
also expected to refer to the NI-700 documentation for the relevant
event IDs to provide as well. An identifier is implemented so we can
come back and add jevents if anyone really wants to.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/Kconfig  |   7 +
 drivers/perf/Makefile |   1 +
 drivers/perf/arm-ni.c | 767 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 775 insertions(+)
 create mode 100644 drivers/perf/arm-ni.c

diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index 7526a9e714fa..adc9365b041b 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -48,6 +48,13 @@ config ARM_CMN
 	  Support for PMU events monitoring on the Arm CMN-600 Coherent Mesh
 	  Network interconnect.
 
+config ARM_NI
+	tristate "Arm NI-700 PMU support"
+	depends on ARM64 || COMPILE_TEST
+	help
+	  Support for PMU events monitoring on the Arm NI-700 Network-on-Chip
+	  interconnect and family.
+
 config ARM_PMU
 	depends on ARM || ARM64
 	bool "ARM PMU framework"
diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
index 29b1c28203ef..d21ed2896bc7 100644
--- a/drivers/perf/Makefile
+++ b/drivers/perf/Makefile
@@ -3,6 +3,7 @@ obj-$(CONFIG_ARM_CCI_PMU) += arm-cci.o
 obj-$(CONFIG_ARM_CCN) += arm-ccn.o
 obj-$(CONFIG_ARM_CMN) += arm-cmn.o
 obj-$(CONFIG_ARM_DSU_PMU) += arm_dsu_pmu.o
+obj-$(CONFIG_ARM_NI) += arm-ni.o
 obj-$(CONFIG_ARM_PMU) += arm_pmu.o arm_pmu_platform.o
 obj-$(CONFIG_ARM_PMU_ACPI) += arm_pmu_acpi.o
 obj-$(CONFIG_ARM_PMUV3) += arm_pmuv3.o
diff --git a/drivers/perf/arm-ni.c b/drivers/perf/arm-ni.c
new file mode 100644
index 000000000000..af1796ab482e
--- /dev/null
+++ b/drivers/perf/arm-ni.c
@@ -0,0 +1,767 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2022-2024 Arm Limited
+// NI-700 Network-on-Chip PMU driver
+
+#include <linux/acpi.h>
+#include <linux/bitfield.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/perf_event.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+/* Common registers */
+#define NI_NODE_TYPE		0x000
+#define NI_NODE_TYPE_NODE_ID	GENMASK(31, 16)
+#define NI_NODE_TYPE_NODE_TYPE	GENMASK(15, 0)
+
+#define NI_CHILD_NODE_INFO	0x004
+#define NI_CHILD_PTR(n)		(0x008 + (n) * 4)
+
+#define NI700_PMUSELA		0x00c
+
+/* Config node */
+#define NI_PERIPHERAL_ID0	0xfe0
+#define NI_PIDR0_PART_7_0	GENMASK(7, 0)
+#define NI_PERIPHERAL_ID1	0xfe4
+#define NI_PIDR1_PART_11_8	GENMASK(3, 0)
+#define NI_PERIPHERAL_ID2	0xfe8
+#define NI_PIDR2_VERSION	GENMASK(7, 4)
+
+/* PMU node */
+#define NI_PMEVCNTR(n)		(0x008 + (n) * 8)
+#define NI_PMCCNTR_L		0x0f8
+#define NI_PMCCNTR_U		0x0fc
+#define NI_PMEVTYPER(n)		(0x400 + (n) * 4)
+#define NI_PMEVTYPER_NODE_TYPE	GENMASK(12, 9)
+#define NI_PMEVTYPER_NODE_ID	GENMASK(8, 0)
+#define NI_PMCNTENSET		0xc00
+#define NI_PMCNTENCLR		0xc20
+#define NI_PMINTENSET		0xc40
+#define NI_PMINTENCLR		0xc60
+#define NI_PMOVSCLR		0xc80
+#define NI_PMOVSSET		0xcc0
+#define NI_PMCFGR		0xe00
+#define NI_PMCR			0xe04
+#define NI_PMCR_RESET_CCNT	BIT(2)
+#define NI_PMCR_RESET_EVCNT	BIT(1)
+#define NI_PMCR_ENABLE		BIT(0)
+
+#define NI_NUM_COUNTERS		8
+#define NI_CCNT_IDX		31
+
+/* Event attributes */
+#define NI_CONFIG_TYPE		GENMASK_ULL(15, 0)
+#define NI_CONFIG_NODEID	GENMASK_ULL(31, 16)
+#define NI_CONFIG_EVENTID	GENMASK_ULL(47, 32)
+
+#define NI_EVENT_TYPE(event)	FIELD_GET(NI_CONFIG_TYPE, (event)->attr.config)
+#define NI_EVENT_NODEID(event)	FIELD_GET(NI_CONFIG_NODEID, (event)->attr.config)
+#define NI_EVENT_EVENTID(event)	FIELD_GET(NI_CONFIG_EVENTID, (event)->attr.config)
+
+enum ni_part {
+	PART_NI_700 = 0x43b,
+	PART_NI_710AE = 0x43d,
+};
+
+enum ni_node_type {
+	NI_GLOBAL,
+	NI_VOLTAGE,
+	NI_POWER,
+	NI_CLOCK,
+	NI_ASNI,
+	NI_AMNI,
+	NI_PMU,
+	NI_HSNI,
+	NI_HMNI,
+	NI_PMNI,
+};
+
+struct arm_ni_node {
+	void __iomem *base;
+	enum ni_node_type type;
+	u16 id;
+	u32 num_components;
+};
+
+struct arm_ni_unit {
+	void __iomem *pmusela;
+	enum ni_node_type type;
+	u16 id;
+	bool ns;
+	union {
+		__le64 pmusel;
+		u8 event[8];
+	};
+};
+
+struct arm_ni_cd {
+	void __iomem *pmu_base;
+	u16 id;
+	int num_units;
+	int irq;
+	int cpu;
+	struct hlist_node cpuhp_node;
+	struct pmu pmu;
+	struct arm_ni_unit *units;
+	struct perf_event *evcnt[NI_NUM_COUNTERS];
+	struct perf_event *ccnt;
+};
+
+struct arm_ni {
+	struct device *dev;
+	void __iomem *base;
+	enum ni_part part;
+	int id;
+	int num_cds;
+	struct arm_ni_cd cds[];
+};
+
+#define cd_to_ni(cd) container_of((cd), struct arm_ni, cds[(cd)->id])
+#define pmu_to_cd(p) container_of((p), struct arm_ni_cd, pmu)
+
+#define cd_for_each_unit(cd, u) \
+	for (struct arm_ni_unit *u = cd->units; u < cd->units + cd->num_units; u++)
+
+static int arm_ni_hp_state;
+
+struct arm_ni_event_attr {
+	struct device_attribute attr;
+	enum ni_node_type type;
+};
+
+#define NI_EVENT_ATTR(_name, _type)					\
+	(&((struct arm_ni_event_attr[]) {{				\
+		.attr = __ATTR(_name, 0444, arm_ni_event_show, NULL),	\
+		.type = _type,						\
+	}})[0].attr.attr)
+
+static ssize_t arm_ni_event_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct arm_ni_event_attr *eattr = container_of(attr, typeof(*eattr), attr);
+
+	if (eattr->type == NI_PMU)
+		return sysfs_emit(buf, "type=0x%x\n", eattr->type);
+
+	return sysfs_emit(buf, "type=0x%x,eventid=?,nodeid=?\n", eattr->type);
+}
+
+static umode_t arm_ni_event_attr_is_visible(struct kobject *kobj,
+					    struct attribute *attr, int unused)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct arm_ni_cd *cd = pmu_to_cd(dev_get_drvdata(dev));
+	struct arm_ni_event_attr *eattr;
+
+	eattr = container_of(attr, typeof(*eattr), attr.attr);
+
+	cd_for_each_unit(cd, unit) {
+		if (unit->type == eattr->type && unit->ns)
+			return attr->mode;
+	}
+
+	return 0;
+}
+
+static struct attribute *arm_ni_event_attrs[] = {
+	NI_EVENT_ATTR(asni, NI_ASNI),
+	NI_EVENT_ATTR(amni, NI_AMNI),
+	NI_EVENT_ATTR(cycles, NI_PMU),
+	NI_EVENT_ATTR(hsni, NI_HSNI),
+	NI_EVENT_ATTR(hmni, NI_HMNI),
+	NI_EVENT_ATTR(pmni, NI_PMNI),
+	NULL
+};
+
+static const struct attribute_group arm_ni_event_attrs_group = {
+	.name = "events",
+	.attrs = arm_ni_event_attrs,
+	.is_visible = arm_ni_event_attr_is_visible,
+};
+
+struct arm_ni_format_attr {
+	struct device_attribute attr;
+	u64 field;
+};
+
+#define NI_FORMAT_ATTR(_name, _fld)					\
+	(&((struct arm_ni_format_attr[]) {{				\
+		.attr = __ATTR(_name, 0444, arm_ni_format_show, NULL),	\
+		.field = _fld,						\
+	}})[0].attr.attr)
+
+static ssize_t arm_ni_format_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct arm_ni_format_attr *fmt = container_of(attr, typeof(*fmt), attr);
+	int lo = __ffs(fmt->field), hi = __fls(fmt->field);
+
+	return sysfs_emit(buf, "config:%d-%d\n", lo, hi);
+}
+
+static struct attribute *arm_ni_format_attrs[] = {
+	NI_FORMAT_ATTR(type, NI_CONFIG_TYPE),
+	NI_FORMAT_ATTR(nodeid, NI_CONFIG_NODEID),
+	NI_FORMAT_ATTR(eventid, NI_CONFIG_EVENTID),
+	NULL
+};
+
+static const struct attribute_group arm_ni_format_attrs_group = {
+	.name = "format",
+	.attrs = arm_ni_format_attrs,
+};
+
+static ssize_t arm_ni_cpumask_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct arm_ni_cd *cd = pmu_to_cd(dev_get_drvdata(dev));
+
+	return cpumap_print_to_pagebuf(true, buf, cpumask_of(cd->cpu));
+}
+
+static struct device_attribute arm_ni_cpumask_attr =
+		__ATTR(cpumask, 0444, arm_ni_cpumask_show, NULL);
+
+static ssize_t arm_ni_identifier_show(struct device *dev,
+				      struct device_attribute *attr, char *buf)
+{
+	struct arm_ni *ni = cd_to_ni(pmu_to_cd(dev_get_drvdata(dev)));
+	u32 reg = readl_relaxed(ni->base + NI_PERIPHERAL_ID2);
+	int version = FIELD_GET(NI_PIDR2_VERSION, reg);
+
+	return sysfs_emit(buf, "%03x%02x\n", ni->part, version);
+}
+
+static struct device_attribute arm_ni_identifier_attr =
+		__ATTR(identifier, 0444, arm_ni_identifier_show, NULL);
+
+static struct attribute *arm_ni_other_attrs[] = {
+	&arm_ni_cpumask_attr.attr,
+	&arm_ni_identifier_attr.attr,
+	NULL
+};
+
+static const struct attribute_group arm_ni_other_attr_group = {
+	.attrs = arm_ni_other_attrs,
+	NULL
+};
+
+static const struct attribute_group *arm_ni_attr_groups[] = {
+	&arm_ni_event_attrs_group,
+	&arm_ni_format_attrs_group,
+	&arm_ni_other_attr_group,
+	NULL
+};
+
+static void arm_ni_pmu_enable(struct pmu *pmu)
+{
+	writel_relaxed(NI_PMCR_ENABLE, pmu_to_cd(pmu)->pmu_base + NI_PMCR);
+}
+
+static void arm_ni_pmu_disable(struct pmu *pmu)
+{
+	writel_relaxed(0, pmu_to_cd(pmu)->pmu_base + NI_PMCR);
+}
+
+static bool arm_ni_validate_event(struct perf_event *this,
+				  struct perf_event *that, int *count)
+{
+	if (is_software_event(this))
+		return true;
+	if (this->pmu != that->pmu)
+		return false;
+	return --count[NI_EVENT_TYPE(this) == NI_PMU] >= 0;
+}
+
+static int arm_ni_validate_group(struct perf_event *event)
+{
+	struct perf_event *sibling, *leader;
+	int count[2] = {NI_NUM_COUNTERS, 1};
+
+	arm_ni_validate_event(event, event, count);
+
+	leader = event->group_leader;
+	if (leader != event && !arm_ni_validate_event(leader, event, count))
+		return - EINVAL;
+
+	for_each_sibling_event(sibling, leader) {
+		if (!arm_ni_validate_event(sibling, event, count))
+			return - EINVAL;
+	}
+	return 0;
+}
+
+static int arm_ni_event_init(struct perf_event *event)
+{
+	struct arm_ni_cd *cd = pmu_to_cd(event->pmu);
+
+	if (event->attr.type != event->pmu->type)
+		return -ENOENT;
+
+	if (is_sampling_event(event))
+		return -EINVAL;
+
+	event->cpu = cd->cpu;
+	if (NI_EVENT_TYPE(event) == NI_PMU)
+		return arm_ni_validate_group(event);
+
+	cd_for_each_unit(cd, unit) {
+		if (unit->type == NI_EVENT_TYPE(event) &&
+		    unit->id == NI_EVENT_NODEID(event) && unit->ns) {
+			event->hw.config_base = (unsigned long)unit;
+			return arm_ni_validate_group(event);
+		}
+	}
+	return -EINVAL;
+}
+
+static u64 arm_ni_read_ccnt(struct arm_ni_cd *cd)
+{
+	u64 l, u_old, u_new;
+
+	u_new = readl_relaxed(cd->pmu_base + NI_PMCCNTR_U);
+	do {
+		u_old = u_new;
+		l = readl_relaxed(cd->pmu_base + NI_PMCCNTR_L);
+		u_new = readl_relaxed(cd->pmu_base + NI_PMCCNTR_U);
+	} while (u_new != u_old);
+
+	return (u_new << 32) | l;
+}
+
+static void arm_ni_event_read(struct perf_event *event)
+{
+	struct arm_ni_cd *cd = pmu_to_cd(event->pmu);
+	struct hw_perf_event *hw = &event->hw;
+	u64 count, prev;
+	bool ccnt = hw->idx == NI_CCNT_IDX;
+
+	do {
+		prev = local64_read(&hw->prev_count);
+		if (ccnt)
+			count = arm_ni_read_ccnt(cd);
+		else
+			count = readl_relaxed(cd->pmu_base + NI_PMEVCNTR(hw->idx));
+	} while (local64_cmpxchg(&hw->prev_count, prev, count) != prev);
+
+	count -= prev;
+	if (!ccnt)
+		count = (u32)count;
+	local64_add(count, &event->count);
+}
+
+static void arm_ni_event_start(struct perf_event *event, int flags)
+{
+	struct arm_ni_cd *cd = pmu_to_cd(event->pmu);
+
+	writel_relaxed(1U << event->hw.idx, cd->pmu_base + NI_PMCNTENSET);
+}
+
+static void arm_ni_event_stop(struct perf_event *event, int flags)
+{
+	struct arm_ni_cd *cd = pmu_to_cd(event->pmu);
+
+	writel_relaxed(1U << event->hw.idx, cd->pmu_base + NI_PMCNTENCLR);
+	if (flags & PERF_EF_UPDATE)
+		arm_ni_event_read(event);
+}
+
+static void arm_ni_init_ccnt(struct arm_ni_cd *cd)
+{
+	local64_set(&cd->ccnt->hw.prev_count, S64_MIN);
+	lo_hi_writeq_relaxed(S64_MIN, cd->pmu_base + NI_PMCCNTR_L);
+}
+
+static void arm_ni_init_evcnt(struct arm_ni_cd *cd, int idx)
+{
+	local64_set(&cd->evcnt[idx]->hw.prev_count, S32_MIN);
+	writel_relaxed(S32_MIN, cd->pmu_base + NI_PMEVCNTR(idx));
+}
+
+static int arm_ni_event_add(struct perf_event *event, int flags)
+{
+	struct arm_ni_cd *cd = pmu_to_cd(event->pmu);
+	struct hw_perf_event *hw = &event->hw;
+	struct arm_ni_unit *unit;
+	enum ni_node_type type = NI_EVENT_TYPE(event);
+	u32 reg;
+
+	if (type == NI_PMU) {
+		if (cd->ccnt)
+			return -ENOSPC;
+		hw->idx = NI_CCNT_IDX;
+		cd->ccnt = event;
+		arm_ni_init_ccnt(cd);
+	} else {
+		hw->idx = 0;
+		while (cd->evcnt[hw->idx]) {
+			if (++hw->idx == NI_NUM_COUNTERS)
+				return -ENOSPC;
+		}
+		cd->evcnt[hw->idx] = event;
+		unit = (void *)hw->config_base;
+		unit->event[hw->idx] = NI_EVENT_EVENTID(event);
+		arm_ni_init_evcnt(cd, hw->idx);
+		lo_hi_writeq_relaxed(le64_to_cpu(unit->pmusel), unit->pmusela);
+
+		reg = FIELD_PREP(NI_PMEVTYPER_NODE_TYPE, type) |
+		      FIELD_PREP(NI_PMEVTYPER_NODE_ID, NI_EVENT_NODEID(event));
+		writel_relaxed(reg, cd->pmu_base + NI_PMEVTYPER(hw->idx));
+	}
+	if (flags & PERF_EF_START)
+		arm_ni_event_start(event, 0);
+	return 0;
+}
+
+static void arm_ni_event_del(struct perf_event *event, int flags)
+{
+	struct arm_ni_cd *cd = pmu_to_cd(event->pmu);
+	struct hw_perf_event *hw = &event->hw;
+
+	arm_ni_event_stop(event, PERF_EF_UPDATE);
+
+	if (hw->idx == NI_CCNT_IDX)
+		cd->ccnt = NULL;
+	else
+		cd->evcnt[hw->idx] = NULL;
+}
+
+static irqreturn_t arm_ni_handle_irq(int irq, void *dev_id)
+{
+	struct arm_ni_cd *cd = dev_id;
+	irqreturn_t ret = IRQ_NONE;
+	u32 reg = readl_relaxed(cd->pmu_base + NI_PMOVSCLR);
+
+	if (reg & (1U << NI_CCNT_IDX)) {
+		ret = IRQ_HANDLED;
+		if (!(WARN_ON(!cd->ccnt))) {
+			arm_ni_event_read(cd->ccnt);
+			arm_ni_init_ccnt(cd);
+		}
+	}
+	for (int i = 0; i < NI_NUM_COUNTERS; i++) {
+		if (!(reg & (1U << i)))
+			continue;
+		ret = IRQ_HANDLED;
+		if (!(WARN_ON(!cd->evcnt[i]))) {
+			arm_ni_event_read(cd->evcnt[i]);
+			arm_ni_init_evcnt(cd, i);
+		}
+	}
+	writel_relaxed(reg, cd->pmu_base + NI_PMOVSCLR);
+	return ret;
+}
+
+static int arm_ni_init_cd(struct arm_ni *ni, struct arm_ni_node *node, u64 res_start)
+{
+	struct arm_ni_cd *cd = ni->cds + node->id;
+	const char *name;
+	int err;
+
+	cd->id = node->id;
+	cd->num_units = node->num_components;
+	cd->units = devm_kcalloc(ni->dev, cd->num_units, sizeof(*(cd->units)), GFP_KERNEL);
+	if (!cd->units)
+		return -ENOMEM;
+
+	for (int i = 0; i < cd->num_units; i++) {
+		u32 reg = readl_relaxed(node->base + NI_CHILD_PTR(i));
+		void __iomem *unit_base = ni->base + reg;
+		struct arm_ni_unit *unit = cd->units + i;
+
+		reg = readl_relaxed(unit_base + NI_NODE_TYPE);
+		unit->type = FIELD_GET(NI_NODE_TYPE_NODE_TYPE, reg);
+		unit->id = FIELD_GET(NI_NODE_TYPE_NODE_ID, reg);
+
+		switch (unit->type) {
+		case NI_PMU:
+			reg = readl_relaxed(unit_base + NI_PMCFGR);
+			if (!reg) {
+				dev_info(ni->dev, "No access to PMU %d\n", cd->id);
+				devm_kfree(ni->dev, cd->units);
+				return 0;
+			}
+			unit->ns = true;
+			cd->pmu_base = unit_base;
+			break;
+		case NI_ASNI:
+		case NI_AMNI:
+		case NI_HSNI:
+		case NI_HMNI:
+		case NI_PMNI:
+			unit->pmusela = unit_base + NI700_PMUSELA;
+			writel_relaxed(1, unit->pmusela);
+			if (readl_relaxed(unit->pmusela) != 1)
+				dev_info(ni->dev, "No access to node 0x%04x%04x\n", unit->id, unit->type);
+			else
+				unit->ns = true;
+			break;
+		default:
+			/*
+			 * e.g. FMU - thankfully bits 3:2 of FMU_ERR_FR0 are RES0 so
+			 * can't alias any of the leaf node types we're looking for.
+			 */
+			dev_dbg(ni->dev, "Mystery node 0x%04x%04x\n", unit->id, unit->type);
+			break;
+		}
+	}
+
+	res_start += cd->pmu_base - ni->base;
+	if (!devm_request_mem_region(ni->dev, res_start, SZ_4K, dev_name(ni->dev))) {
+		dev_err(ni->dev, "Failed to request PMU region 0x%llx\n", res_start);
+		return -EBUSY;
+	}
+
+	writel_relaxed(NI_PMCR_RESET_CCNT | NI_PMCR_RESET_EVCNT,
+		       cd->pmu_base + NI_PMCR);
+	writel_relaxed(U32_MAX, cd->pmu_base + NI_PMCNTENCLR);
+	writel_relaxed(U32_MAX, cd->pmu_base + NI_PMOVSCLR);
+	writel_relaxed(U32_MAX, cd->pmu_base + NI_PMINTENSET);
+
+	cd->irq = platform_get_irq(to_platform_device(ni->dev), cd->id);
+	if (cd->irq < 0)
+		return cd->irq;
+
+	err = devm_request_irq(ni->dev, cd->irq, arm_ni_handle_irq,
+			       IRQF_NOBALANCING | IRQF_NO_THREAD,
+			       dev_name(ni->dev), cd);
+	if (err)
+		return err;
+
+	cd->cpu = cpumask_local_spread(0, dev_to_node(ni->dev));
+	cd->pmu = (struct pmu) {
+		.module = THIS_MODULE,
+		.parent = ni->dev,
+		.attr_groups = arm_ni_attr_groups,
+		.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
+		.task_ctx_nr = perf_invalid_context,
+		.pmu_enable = arm_ni_pmu_enable,
+		.pmu_disable = arm_ni_pmu_disable,
+		.event_init = arm_ni_event_init,
+		.add = arm_ni_event_add,
+		.del = arm_ni_event_del,
+		.start = arm_ni_event_start,
+		.stop = arm_ni_event_stop,
+		.read = arm_ni_event_read,
+	};
+
+	name = devm_kasprintf(ni->dev, GFP_KERNEL, "arm_ni_%d_cd_%d", ni->id, cd->id);
+	if (!name)
+		return -ENOMEM;
+
+	err = cpuhp_state_add_instance(arm_ni_hp_state, &cd->cpuhp_node);
+	if (err)
+		return err;
+
+	return perf_pmu_register(&cd->pmu, name, -1);
+}
+
+static void arm_ni_probe_domain(void __iomem *base, struct arm_ni_node *node)
+{
+	u32 reg = readl_relaxed(base + NI_NODE_TYPE);
+
+	node->base = base;
+	node->type = FIELD_GET(NI_NODE_TYPE_NODE_TYPE, reg);
+	node->id = FIELD_GET(NI_NODE_TYPE_NODE_ID, reg);
+	node->num_components = readl_relaxed(base + NI_CHILD_NODE_INFO);
+}
+
+static int arm_ni_probe(struct platform_device *pdev)
+{
+	struct arm_ni_node cfg, vd, pd, cd;
+	struct arm_ni *ni;
+	struct resource *res;
+	void __iomem *base;
+	static atomic_t id;
+	int num_cds;
+	u32 reg, part;
+
+	/*
+	 * We want to map the whole configuration space for ease of discovery,
+	 * but the PMU pages are the only ones for which we can honestly claim
+	 * exclusive ownership, so we'll request them explicitly once found.
+	 */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	arm_ni_probe_domain(base, &cfg);
+	if (cfg.type != NI_GLOBAL)
+		return -ENODEV;
+
+	reg = readl_relaxed(cfg.base + NI_PERIPHERAL_ID0);
+	part = FIELD_GET(NI_PIDR0_PART_7_0, reg);
+	reg = readl_relaxed(cfg.base + NI_PERIPHERAL_ID1);
+	part |= FIELD_GET(NI_PIDR1_PART_11_8, reg) << 8;
+
+	switch (part) {
+	case PART_NI_700:
+	case PART_NI_710AE:
+		break;
+	default:
+		dev_WARN(&pdev->dev, "Unknown part number: 0x%03x, this may go badly\n", part);
+		break;
+	}
+
+	num_cds = 0;
+	for (int v = 0; v < cfg.num_components; v++) {
+		reg = readl_relaxed(cfg.base + NI_CHILD_PTR(v));
+		arm_ni_probe_domain(base + reg, &vd);
+		for (int p = 0; p < vd.num_components; p++) {
+			reg = readl_relaxed(vd.base + NI_CHILD_PTR(p));
+			arm_ni_probe_domain(base + reg, &pd);
+			num_cds += pd.num_components;
+		}
+	}
+
+	ni = devm_kzalloc(&pdev->dev, struct_size(ni, cds, num_cds), GFP_KERNEL);
+	if (!ni)
+		return -ENOMEM;
+
+	ni->dev = &pdev->dev;
+	ni->base = base;
+	ni->num_cds = num_cds;
+	ni->part = part;
+	ni->id = atomic_fetch_inc(&id);
+
+	for (int v = 0; v < cfg.num_components; v++) {
+		reg = readl_relaxed(cfg.base + NI_CHILD_PTR(v));
+		arm_ni_probe_domain(base + reg, &vd);
+		for (int p = 0; p < vd.num_components; p++) {
+			reg = readl_relaxed(vd.base + NI_CHILD_PTR(p));
+			arm_ni_probe_domain(base + reg, &pd);
+			for (int c = 0; c < pd.num_components; c++) {
+				int ret;
+
+				reg = readl_relaxed(pd.base + NI_CHILD_PTR(c));
+				arm_ni_probe_domain(base + reg, &cd);
+				ret = arm_ni_init_cd(ni, &cd, res->start);
+				if (ret)
+					return ret;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static int arm_ni_remove(struct platform_device *pdev)
+{
+	struct arm_ni *ni = platform_get_drvdata(pdev);
+
+	for (int i = 0; i < ni->num_cds; i++) {
+		struct arm_ni_cd *cd = ni->cds + i;
+
+		if (!cd->pmu_base)
+			continue;
+
+		writel_relaxed(0, cd->pmu_base + NI_PMCR);
+		writel_relaxed(U32_MAX, cd->pmu_base + NI_PMINTENCLR);
+		perf_pmu_unregister(&cd->pmu);
+		cpuhp_state_remove_instance_nocalls(arm_ni_hp_state, &cd->cpuhp_node);
+	}
+	return 0;
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id arm_ni_of_match[] = {
+	{ .compatible = "arm,ni-700" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, arm_ni_of_match);
+#endif
+
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id arm_ni_acpi_match[] = {
+	{ "ARMHCB70" },
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, arm_ni_acpi_match);
+#endif
+
+static struct platform_driver arm_ni_driver = {
+	.driver = {
+		.name = "arm-ni",
+		.of_match_table = of_match_ptr(arm_ni_of_match),
+		.acpi_match_table = ACPI_PTR(arm_ni_acpi_match),
+	},
+	.probe = arm_ni_probe,
+	.remove = arm_ni_remove,
+};
+
+static void arm_ni_pmu_migrate(struct arm_ni_cd *cd, unsigned int cpu)
+{
+	perf_pmu_migrate_context(&cd->pmu, cd->cpu, cpu);
+	irq_set_affinity(cd->irq, cpumask_of(cpu));
+	cd->cpu = cpu;
+}
+
+static int arm_ni_pmu_online_cpu(unsigned int cpu, struct hlist_node *cpuhp_node)
+{
+	struct arm_ni_cd *cd;
+	int node;
+
+	cd = hlist_entry_safe(cpuhp_node, struct arm_ni_cd, cpuhp_node);
+	node = dev_to_node(cd_to_ni(cd)->dev);
+	if (node != NUMA_NO_NODE && cpu_to_node(cd->cpu) != node && cpu_to_node(cpu) == node)
+		arm_ni_pmu_migrate(cd, cpu);
+	return 0;
+}
+
+static int arm_ni_pmu_offline_cpu(unsigned int cpu, struct hlist_node *cpuhp_node)
+{
+	struct arm_ni_cd *cd;
+	unsigned int target;
+	int node;
+
+	cd = hlist_entry_safe(cpuhp_node, struct arm_ni_cd, cpuhp_node);
+	if (cpu != cd->cpu)
+		return 0;
+
+	node = dev_to_node(cd_to_ni(cd)->dev);
+	target = cpumask_any_and_but(cpumask_of_node(node), cpu_online_mask, cpu);
+	if (target >= nr_cpu_ids)
+		target = cpumask_any_but(cpu_online_mask, cpu);
+
+	if (target < nr_cpu_ids)
+		arm_ni_pmu_migrate(cd, target);
+	return 0;
+}
+
+static int __init arm_ni_init(void)
+{
+	int ret;
+
+	ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
+				      "perf/arm/ni:online",
+				      arm_ni_pmu_online_cpu,
+				      arm_ni_pmu_offline_cpu);
+	if (ret < 0)
+		return ret;
+
+	arm_ni_hp_state = ret;
+
+	ret = platform_driver_register(&arm_ni_driver);
+	if (ret)
+		cpuhp_remove_multi_state(arm_ni_hp_state);
+	return ret;
+}
+
+static void __exit arm_ni_exit(void)
+{
+	platform_driver_unregister(&arm_ni_driver);
+	cpuhp_remove_multi_state(arm_ni_hp_state);
+}
+
+module_init(arm_ni_init);
+module_exit(arm_ni_exit);
+
+MODULE_AUTHOR("Robin Murphy <robin.murphy@arm.com>");
+MODULE_DESCRIPTION("Arm NI-700 PMU driver");
+MODULE_LICENSE("GPL v2");
-- 
2.39.2.101.g768bb238c484.dirty


