Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6532E7CD44E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 08:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344596AbjJRGUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 02:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344544AbjJRGSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 02:18:46 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE39D66
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 23:18:02 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1qszrs-0001Zx-JU; Wed, 18 Oct 2023 08:17:20 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1qszrr-002UYS-3F; Wed, 18 Oct 2023 08:17:19 +0200
Received: from sha by dude02.red.stw.pengutronix.de with local (Exim 4.96)
        (envelope-from <sha@pengutronix.de>)
        id 1qszrq-00Evj2-37;
        Wed, 18 Oct 2023 08:17:18 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-rockchip@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Chanwoo Choi <chanwoo@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, kernel@pengutronix.de,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Robin Murphy <robin.murphy@arm.com>,
        Vincent Legoll <vincent.legoll@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v8 16/26] PM / devfreq: rockchip-dfi: Add perf support
Date:   Wed, 18 Oct 2023 08:17:04 +0200
Message-Id: <20231018061714.3553817-17-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231018061714.3553817-1-s.hauer@pengutronix.de>
References: <20231018061714.3553817-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DFI is a unit which is suitable for measuring DDR utilization, but
so far it could only be used as an event driver for the DDR frequency
scaling driver. This adds perf support to the DFI driver.

Usage with the 'perf' tool can look like:

perf stat -a -e rockchip_ddr/cycles/,\
		rockchip_ddr/read-bytes/,\
		rockchip_ddr/write-bytes/,\
		rockchip_ddr/bytes/ sleep 1

 Performance counter stats for 'system wide':

        1582524826      rockchip_ddr/cycles/
           1802.25 MB   rockchip_ddr/read-bytes/
           1793.72 MB   rockchip_ddr/write-bytes/
           3595.90 MB   rockchip_ddr/bytes/

       1.014369709 seconds time elapsed

perf support has been tested on a RK3568 and a RK3399, the latter with
dual channel DDR.

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---

Notes:
    Changes since v7:
     - rename variable 'c' to 'count'
    
    Changes since v5:
     - Add missing initialization of &dfi->last_perf_count
    
    Changes since v4:
    
     - use __stringify to ensure event type definitions and event numbers in sysfs are consistent
     - only use 64bit values in structs holding counters
     - support monitoring individual DDR channels
     - fix return value in rockchip_ddr_perf_event_init(): -EOPNOTSUPP -> -EINVAL
     - check for invalid event->attr.config values
     - start hrtimer to trigger in one second, not immediately
     - use devm_add_action_or_reset()
     - add suppress_bind_attrs
     - enable DDRMON during probe when perf is enabled
     - use a seqlock to protect perf reading the counters from the hrtimer callback modifying them

 drivers/devfreq/event/rockchip-dfi.c | 440 ++++++++++++++++++++++++++-
 include/soc/rockchip/rk3399_grf.h    |   2 +
 include/soc/rockchip/rk3568_grf.h    |   1 +
 3 files changed, 438 insertions(+), 5 deletions(-)

diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
index 3d5c6d737ccd9..63977f9fc2693 100644
--- a/drivers/devfreq/event/rockchip-dfi.c
+++ b/drivers/devfreq/event/rockchip-dfi.c
@@ -16,10 +16,12 @@
 #include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/list.h>
+#include <linux/seqlock.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/bitfield.h>
 #include <linux/bits.h>
+#include <linux/perf_event.h>
 
 #include <soc/rockchip/rockchip_grf.h>
 #include <soc/rockchip/rk3399_grf.h>
@@ -41,19 +43,39 @@
 					 DDRMON_CTRL_LPDDR4 | \
 					 DDRMON_CTRL_LPDDR23)
 
+#define DDRMON_CH0_WR_NUM		0x20
+#define DDRMON_CH0_RD_NUM		0x24
 #define DDRMON_CH0_COUNT_NUM		0x28
 #define DDRMON_CH0_DFI_ACCESS_NUM	0x2c
 #define DDRMON_CH1_COUNT_NUM		0x3c
 #define DDRMON_CH1_DFI_ACCESS_NUM	0x40
 
+#define PERF_EVENT_CYCLES		0x0
+#define PERF_EVENT_READ_BYTES		0x1
+#define PERF_EVENT_WRITE_BYTES		0x2
+#define PERF_EVENT_READ_BYTES0		0x3
+#define PERF_EVENT_WRITE_BYTES0		0x4
+#define PERF_EVENT_READ_BYTES1		0x5
+#define PERF_EVENT_WRITE_BYTES1		0x6
+#define PERF_EVENT_READ_BYTES2		0x7
+#define PERF_EVENT_WRITE_BYTES2		0x8
+#define PERF_EVENT_READ_BYTES3		0x9
+#define PERF_EVENT_WRITE_BYTES3		0xa
+#define PERF_EVENT_BYTES		0xb
+#define PERF_ACCESS_TYPE_MAX		0xc
+
 /**
  * struct dmc_count_channel - structure to hold counter values from the DDR controller
  * @access:       Number of read and write accesses
  * @clock_cycles: DDR clock cycles
+ * @read_access:  number of read accesses
+ * @write_acccess: number of write accesses
  */
 struct dmc_count_channel {
-	u32 access;
-	u32 clock_cycles;
+	u64 access;
+	u64 clock_cycles;
+	u64 read_access;
+	u64 write_access;
 };
 
 struct dmc_count {
@@ -69,6 +91,11 @@ struct rockchip_dfi {
 	struct devfreq_event_dev *edev;
 	struct devfreq_event_desc desc;
 	struct dmc_count last_event_count;
+
+	struct dmc_count last_perf_count;
+	struct dmc_count total_count;
+	seqlock_t count_seqlock; /* protects last_perf_count and total_count */
+
 	struct device *dev;
 	void __iomem *regs;
 	struct regmap *regmap_pmu;
@@ -78,6 +105,14 @@ struct rockchip_dfi {
 	u32 ddr_type;
 	unsigned int channel_mask;
 	unsigned int max_channels;
+	enum cpuhp_state cpuhp_state;
+	struct hlist_node node;
+	struct pmu pmu;
+	struct hrtimer timer;
+	unsigned int cpu;
+	int active_events;
+	int burst_len;
+	int buswidth[DMC_MAX_CHANNELS];
 };
 
 static int rockchip_dfi_enable(struct rockchip_dfi *dfi)
@@ -146,7 +181,7 @@ static void rockchip_dfi_disable(struct rockchip_dfi *dfi)
 	mutex_unlock(&dfi->mutex);
 }
 
-static void rockchip_dfi_read_counters(struct rockchip_dfi *dfi, struct dmc_count *count)
+static void rockchip_dfi_read_counters(struct rockchip_dfi *dfi, struct dmc_count *res)
 {
 	u32 i;
 	void __iomem *dfi_regs = dfi->regs;
@@ -154,13 +189,36 @@ static void rockchip_dfi_read_counters(struct rockchip_dfi *dfi, struct dmc_coun
 	for (i = 0; i < dfi->max_channels; i++) {
 		if (!(dfi->channel_mask & BIT(i)))
 			continue;
-		count->c[i].access = readl_relaxed(dfi_regs +
+		res->c[i].read_access = readl_relaxed(dfi_regs +
+				DDRMON_CH0_RD_NUM + i * 20);
+		res->c[i].write_access = readl_relaxed(dfi_regs +
+				DDRMON_CH0_WR_NUM + i * 20);
+		res->c[i].access = readl_relaxed(dfi_regs +
 				DDRMON_CH0_DFI_ACCESS_NUM + i * 20);
-		count->c[i].clock_cycles = readl_relaxed(dfi_regs +
+		res->c[i].clock_cycles = readl_relaxed(dfi_regs +
 				DDRMON_CH0_COUNT_NUM + i * 20);
 	}
 }
 
+static void rockchip_ddr_perf_counters_add(struct rockchip_dfi *dfi,
+					   const struct dmc_count *now,
+					   struct dmc_count *res)
+{
+	const struct dmc_count *last = &dfi->last_perf_count;
+	int i;
+
+	for (i = 0; i < dfi->max_channels; i++) {
+		res->c[i].read_access = dfi->total_count.c[i].read_access +
+			(u32)(now->c[i].read_access - last->c[i].read_access);
+		res->c[i].write_access = dfi->total_count.c[i].write_access +
+			(u32)(now->c[i].write_access - last->c[i].write_access);
+		res->c[i].access = dfi->total_count.c[i].access +
+			(u32)(now->c[i].access - last->c[i].access);
+		res->c[i].clock_cycles = dfi->total_count.c[i].clock_cycles +
+			(u32)(now->c[i].clock_cycles - last->c[i].clock_cycles);
+	}
+}
+
 static int rockchip_dfi_event_disable(struct devfreq_event_dev *edev)
 {
 	struct rockchip_dfi *dfi = devfreq_event_get_drvdata(edev);
@@ -224,6 +282,368 @@ static const struct devfreq_event_ops rockchip_dfi_ops = {
 	.set_event = rockchip_dfi_set_event,
 };
 
+#ifdef CONFIG_PERF_EVENTS
+
+static ssize_t ddr_perf_cpumask_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct pmu *pmu = dev_get_drvdata(dev);
+	struct rockchip_dfi *dfi = container_of(pmu, struct rockchip_dfi, pmu);
+
+	return cpumap_print_to_pagebuf(true, buf, cpumask_of(dfi->cpu));
+}
+
+static struct device_attribute ddr_perf_cpumask_attr =
+	__ATTR(cpumask, 0444, ddr_perf_cpumask_show, NULL);
+
+static struct attribute *ddr_perf_cpumask_attrs[] = {
+	&ddr_perf_cpumask_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group ddr_perf_cpumask_attr_group = {
+	.attrs = ddr_perf_cpumask_attrs,
+};
+
+PMU_EVENT_ATTR_STRING(cycles, ddr_pmu_cycles, "event="__stringify(PERF_EVENT_CYCLES))
+
+#define DFI_PMU_EVENT_ATTR(_name, _var, _str) \
+	PMU_EVENT_ATTR_STRING(_name, _var, _str); \
+	PMU_EVENT_ATTR_STRING(_name.unit, _var##_unit, "MB"); \
+	PMU_EVENT_ATTR_STRING(_name.scale, _var##_scale, "9.536743164e-07")
+
+DFI_PMU_EVENT_ATTR(read-bytes0, ddr_pmu_read_bytes0, "event="__stringify(PERF_EVENT_READ_BYTES0));
+DFI_PMU_EVENT_ATTR(write-bytes0, ddr_pmu_write_bytes0, "event="__stringify(PERF_EVENT_WRITE_BYTES0));
+
+DFI_PMU_EVENT_ATTR(read-bytes1, ddr_pmu_read_bytes1, "event="__stringify(PERF_EVENT_READ_BYTES1));
+DFI_PMU_EVENT_ATTR(write-bytes1, ddr_pmu_write_bytes1, "event="__stringify(PERF_EVENT_WRITE_BYTES1));
+
+DFI_PMU_EVENT_ATTR(read-bytes2, ddr_pmu_read_bytes2, "event="__stringify(PERF_EVENT_READ_BYTES2));
+DFI_PMU_EVENT_ATTR(write-bytes2, ddr_pmu_write_bytes2, "event="__stringify(PERF_EVENT_WRITE_BYTES2));
+
+DFI_PMU_EVENT_ATTR(read-bytes3, ddr_pmu_read_bytes3, "event="__stringify(PERF_EVENT_READ_BYTES3));
+DFI_PMU_EVENT_ATTR(write-bytes3, ddr_pmu_write_bytes3, "event="__stringify(PERF_EVENT_WRITE_BYTES3));
+
+DFI_PMU_EVENT_ATTR(read-bytes, ddr_pmu_read_bytes, "event="__stringify(PERF_EVENT_READ_BYTES));
+DFI_PMU_EVENT_ATTR(write-bytes, ddr_pmu_write_bytes, "event="__stringify(PERF_EVENT_WRITE_BYTES));
+
+DFI_PMU_EVENT_ATTR(bytes, ddr_pmu_bytes, "event="__stringify(PERF_EVENT_BYTES));
+
+#define DFI_ATTR_MB(_name) 		\
+	&_name.attr.attr,		\
+	&_name##_unit.attr.attr,	\
+	&_name##_scale.attr.attr
+
+static struct attribute *ddr_perf_events_attrs[] = {
+	&ddr_pmu_cycles.attr.attr,
+	DFI_ATTR_MB(ddr_pmu_read_bytes),
+	DFI_ATTR_MB(ddr_pmu_write_bytes),
+	DFI_ATTR_MB(ddr_pmu_read_bytes0),
+	DFI_ATTR_MB(ddr_pmu_write_bytes0),
+	DFI_ATTR_MB(ddr_pmu_read_bytes1),
+	DFI_ATTR_MB(ddr_pmu_write_bytes1),
+	DFI_ATTR_MB(ddr_pmu_read_bytes2),
+	DFI_ATTR_MB(ddr_pmu_write_bytes2),
+	DFI_ATTR_MB(ddr_pmu_read_bytes3),
+	DFI_ATTR_MB(ddr_pmu_write_bytes3),
+	DFI_ATTR_MB(ddr_pmu_bytes),
+	NULL,
+};
+
+static const struct attribute_group ddr_perf_events_attr_group = {
+	.name = "events",
+	.attrs = ddr_perf_events_attrs,
+};
+
+PMU_FORMAT_ATTR(event, "config:0-7");
+
+static struct attribute *ddr_perf_format_attrs[] = {
+	&format_attr_event.attr,
+	NULL,
+};
+
+static const struct attribute_group ddr_perf_format_attr_group = {
+	.name = "format",
+	.attrs = ddr_perf_format_attrs,
+};
+
+static const struct attribute_group *attr_groups[] = {
+	&ddr_perf_events_attr_group,
+	&ddr_perf_cpumask_attr_group,
+	&ddr_perf_format_attr_group,
+	NULL,
+};
+
+static int rockchip_ddr_perf_event_init(struct perf_event *event)
+{
+	struct rockchip_dfi *dfi = container_of(event->pmu, struct rockchip_dfi, pmu);
+
+	if (event->attr.type != event->pmu->type)
+		return -ENOENT;
+
+	if (event->attach_state & PERF_ATTACH_TASK)
+		return -EINVAL;
+
+	if (event->cpu < 0) {
+		dev_warn(dfi->dev, "Can't provide per-task data!\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static u64 rockchip_ddr_perf_event_get_count(struct perf_event *event)
+{
+	struct rockchip_dfi *dfi = container_of(event->pmu, struct rockchip_dfi, pmu);
+	int blen = dfi->burst_len;
+	struct dmc_count total, now;
+	unsigned int seq;
+	u64 count = 0;
+	int i;
+
+	rockchip_dfi_read_counters(dfi, &now);
+
+	do {
+		seq = read_seqbegin(&dfi->count_seqlock);
+		rockchip_ddr_perf_counters_add(dfi, &now, &total);
+	} while (read_seqretry(&dfi->count_seqlock, seq));
+
+	switch (event->attr.config) {
+	case PERF_EVENT_CYCLES:
+		count = total.c[0].clock_cycles;
+		break;
+	case PERF_EVENT_READ_BYTES:
+		for (i = 0; i < dfi->max_channels; i++)
+			count += total.c[i].read_access * blen * dfi->buswidth[i];
+		break;
+	case PERF_EVENT_WRITE_BYTES:
+		for (i = 0; i < dfi->max_channels; i++)
+			count += total.c[i].write_access * blen * dfi->buswidth[i];
+		break;
+	case PERF_EVENT_READ_BYTES0:
+		count = total.c[0].read_access * blen * dfi->buswidth[0];
+		break;
+	case PERF_EVENT_WRITE_BYTES0:
+		count = total.c[0].write_access * blen * dfi->buswidth[0];
+		break;
+	case PERF_EVENT_READ_BYTES1:
+		count = total.c[1].read_access * blen * dfi->buswidth[1];
+		break;
+	case PERF_EVENT_WRITE_BYTES1:
+		count = total.c[1].write_access * blen * dfi->buswidth[1];
+		break;
+	case PERF_EVENT_READ_BYTES2:
+		count = total.c[2].read_access * blen * dfi->buswidth[2];
+		break;
+	case PERF_EVENT_WRITE_BYTES2:
+		count = total.c[2].write_access * blen * dfi->buswidth[2];
+		break;
+	case PERF_EVENT_READ_BYTES3:
+		count = total.c[3].read_access * blen * dfi->buswidth[3];
+		break;
+	case PERF_EVENT_WRITE_BYTES3:
+		count = total.c[3].write_access * blen * dfi->buswidth[3];
+		break;
+	case PERF_EVENT_BYTES:
+		for (i = 0; i < dfi->max_channels; i++)
+			count += total.c[i].access * blen * dfi->buswidth[i];
+		break;
+	}
+
+	return count;
+}
+
+static void rockchip_ddr_perf_event_update(struct perf_event *event)
+{
+	u64 now;
+	s64 prev;
+
+	if (event->attr.config >= PERF_ACCESS_TYPE_MAX)
+		return;
+
+	now = rockchip_ddr_perf_event_get_count(event);
+	prev = local64_xchg(&event->hw.prev_count, now);
+	local64_add(now - prev, &event->count);
+}
+
+static void rockchip_ddr_perf_event_start(struct perf_event *event, int flags)
+{
+	u64 now = rockchip_ddr_perf_event_get_count(event);
+
+	local64_set(&event->hw.prev_count, now);
+}
+
+static int rockchip_ddr_perf_event_add(struct perf_event *event, int flags)
+{
+	struct rockchip_dfi *dfi = container_of(event->pmu, struct rockchip_dfi, pmu);
+
+	dfi->active_events++;
+
+	if (dfi->active_events == 1) {
+		dfi->total_count = (struct dmc_count){};
+		rockchip_dfi_read_counters(dfi, &dfi->last_perf_count);
+		hrtimer_start(&dfi->timer, ns_to_ktime(NSEC_PER_SEC), HRTIMER_MODE_REL);
+	}
+
+	if (flags & PERF_EF_START)
+		rockchip_ddr_perf_event_start(event, flags);
+
+	return 0;
+}
+
+static void rockchip_ddr_perf_event_stop(struct perf_event *event, int flags)
+{
+	rockchip_ddr_perf_event_update(event);
+}
+
+static void rockchip_ddr_perf_event_del(struct perf_event *event, int flags)
+{
+	struct rockchip_dfi *dfi = container_of(event->pmu, struct rockchip_dfi, pmu);
+
+	rockchip_ddr_perf_event_stop(event, PERF_EF_UPDATE);
+
+	dfi->active_events--;
+
+	if (dfi->active_events == 0)
+		hrtimer_cancel(&dfi->timer);
+}
+
+static enum hrtimer_restart rockchip_dfi_timer(struct hrtimer *timer)
+{
+	struct rockchip_dfi *dfi = container_of(timer, struct rockchip_dfi, timer);
+	struct dmc_count now, total;
+
+	rockchip_dfi_read_counters(dfi, &now);
+
+	write_seqlock(&dfi->count_seqlock);
+
+	rockchip_ddr_perf_counters_add(dfi, &now, &total);
+	dfi->total_count = total;
+	dfi->last_perf_count = now;
+
+	write_sequnlock(&dfi->count_seqlock);
+
+	hrtimer_forward_now(&dfi->timer, ns_to_ktime(NSEC_PER_SEC));
+
+	return HRTIMER_RESTART;
+};
+
+static int ddr_perf_offline_cpu(unsigned int cpu, struct hlist_node *node)
+{
+	struct rockchip_dfi *dfi = hlist_entry_safe(node, struct rockchip_dfi, node);
+	int target;
+
+	if (cpu != dfi->cpu)
+		return 0;
+
+	target = cpumask_any_but(cpu_online_mask, cpu);
+	if (target >= nr_cpu_ids)
+		return 0;
+
+	perf_pmu_migrate_context(&dfi->pmu, cpu, target);
+	dfi->cpu = target;
+
+	return 0;
+}
+
+static void rockchip_ddr_cpuhp_remove_state(void *data)
+{
+	struct rockchip_dfi *dfi = data;
+
+	cpuhp_remove_multi_state(dfi->cpuhp_state);
+
+	rockchip_dfi_disable(dfi);
+}
+
+static void rockchip_ddr_cpuhp_remove_instance(void *data)
+{
+	struct rockchip_dfi *dfi = data;
+
+	cpuhp_state_remove_instance_nocalls(dfi->cpuhp_state, &dfi->node);
+}
+
+static void rockchip_ddr_perf_remove(void *data)
+{
+	struct rockchip_dfi *dfi = data;
+
+	perf_pmu_unregister(&dfi->pmu);
+}
+
+static int rockchip_ddr_perf_init(struct rockchip_dfi *dfi)
+{
+	struct pmu *pmu = &dfi->pmu;
+	int ret;
+
+	seqlock_init(&dfi->count_seqlock);
+
+	pmu->module = THIS_MODULE;
+	pmu->capabilities = PERF_PMU_CAP_NO_EXCLUDE;
+	pmu->task_ctx_nr = perf_invalid_context;
+	pmu->attr_groups = attr_groups;
+	pmu->event_init  = rockchip_ddr_perf_event_init;
+	pmu->add = rockchip_ddr_perf_event_add;
+	pmu->del = rockchip_ddr_perf_event_del;
+	pmu->start = rockchip_ddr_perf_event_start;
+	pmu->stop = rockchip_ddr_perf_event_stop;
+	pmu->read = rockchip_ddr_perf_event_update;
+
+	dfi->cpu = raw_smp_processor_id();
+
+	ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
+				      "rockchip_ddr_perf_pmu",
+				      NULL,
+				      ddr_perf_offline_cpu);
+
+	if (ret < 0) {
+		dev_err(dfi->dev, "cpuhp_setup_state_multi failed: %d\n", ret);
+		return ret;
+	}
+
+	dfi->cpuhp_state = ret;
+
+	rockchip_dfi_enable(dfi);
+
+	ret = devm_add_action_or_reset(dfi->dev, rockchip_ddr_cpuhp_remove_state, dfi);
+	if (ret)
+		return ret;
+
+	ret = cpuhp_state_add_instance_nocalls(dfi->cpuhp_state, &dfi->node);
+	if (ret) {
+		dev_err(dfi->dev, "Error %d registering hotplug\n", ret);
+		return ret;
+	}
+
+	ret = devm_add_action_or_reset(dfi->dev, rockchip_ddr_cpuhp_remove_instance, dfi);
+	if (ret)
+		return ret;
+
+	hrtimer_init(&dfi->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	dfi->timer.function = rockchip_dfi_timer;
+
+	switch (dfi->ddr_type) {
+	case ROCKCHIP_DDRTYPE_LPDDR2:
+	case ROCKCHIP_DDRTYPE_LPDDR3:
+		dfi->burst_len = 8;
+		break;
+	case ROCKCHIP_DDRTYPE_LPDDR4:
+	case ROCKCHIP_DDRTYPE_LPDDR4X:
+		dfi->burst_len = 16;
+		break;
+	}
+
+	ret = perf_pmu_register(pmu, "rockchip_ddr", -1);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(dfi->dev, rockchip_ddr_perf_remove, dfi);
+}
+#else
+static int rockchip_ddr_perf_init(struct rockchip_dfi *dfi)
+{
+	return 0;
+}
+#endif
+
 static int rk3399_dfi_init(struct rockchip_dfi *dfi)
 {
 	struct regmap *regmap_pmu = dfi->regmap_pmu;
@@ -241,6 +661,9 @@ static int rk3399_dfi_init(struct rockchip_dfi *dfi)
 	dfi->channel_mask = GENMASK(1, 0);
 	dfi->max_channels = 2;
 
+	dfi->buswidth[0] = FIELD_GET(RK3399_PMUGRF_OS_REG2_BW_CH0, val) == 0 ? 4 : 2;
+	dfi->buswidth[1] = FIELD_GET(RK3399_PMUGRF_OS_REG2_BW_CH1, val) == 0 ? 4 : 2;
+
 	return 0;
 };
 
@@ -265,6 +688,8 @@ static int rk3568_dfi_init(struct rockchip_dfi *dfi)
 	dfi->channel_mask = BIT(0);
 	dfi->max_channels = 1;
 
+	dfi->buswidth[0] = FIELD_GET(RK3568_PMUGRF_OS_REG2_BW_CH0, reg2) == 0 ? 4 : 2;
+
 	return 0;
 };
 
@@ -325,6 +750,10 @@ static int rockchip_dfi_probe(struct platform_device *pdev)
 		return PTR_ERR(dfi->edev);
 	}
 
+	ret = rockchip_ddr_perf_init(dfi);
+	if (ret)
+		return ret;
+
 	platform_set_drvdata(pdev, dfi);
 
 	return 0;
@@ -335,6 +764,7 @@ static struct platform_driver rockchip_dfi_driver = {
 	.driver = {
 		.name	= "rockchip-dfi",
 		.of_match_table = rockchip_dfi_id_match,
+		.suppress_bind_attrs = true,
 	},
 };
 module_platform_driver(rockchip_dfi_driver);
diff --git a/include/soc/rockchip/rk3399_grf.h b/include/soc/rockchip/rk3399_grf.h
index 775f8444bea8d..39cd44cec982f 100644
--- a/include/soc/rockchip/rk3399_grf.h
+++ b/include/soc/rockchip/rk3399_grf.h
@@ -12,5 +12,7 @@
 /* PMU GRF Registers */
 #define RK3399_PMUGRF_OS_REG2		0x308
 #define RK3399_PMUGRF_OS_REG2_DDRTYPE		GENMASK(15, 13)
+#define RK3399_PMUGRF_OS_REG2_BW_CH0		GENMASK(3, 2)
+#define RK3399_PMUGRF_OS_REG2_BW_CH1		GENMASK(19, 18)
 
 #endif
diff --git a/include/soc/rockchip/rk3568_grf.h b/include/soc/rockchip/rk3568_grf.h
index 575584e9d8834..52853efd6720e 100644
--- a/include/soc/rockchip/rk3568_grf.h
+++ b/include/soc/rockchip/rk3568_grf.h
@@ -4,6 +4,7 @@
 
 #define RK3568_PMUGRF_OS_REG2		0x208
 #define RK3568_PMUGRF_OS_REG2_DRAMTYPE_INFO		GENMASK(15, 13)
+#define RK3568_PMUGRF_OS_REG2_BW_CH0			GENMASK(3, 2)
 
 #define RK3568_PMUGRF_OS_REG3		0x20c
 #define RK3568_PMUGRF_OS_REG3_DRAMTYPE_INFO_V3		GENMASK(13, 12)
-- 
2.39.2

