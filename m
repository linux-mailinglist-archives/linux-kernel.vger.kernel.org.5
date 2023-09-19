Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA9E7A5E9A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 11:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbjISJwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 05:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbjISJwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 05:52:14 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B2644122;
        Tue, 19 Sep 2023 02:52:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE5FC1FB;
        Tue, 19 Sep 2023 02:52:43 -0700 (PDT)
Received: from e127643.broadband (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E9A833F67D;
        Tue, 19 Sep 2023 02:52:04 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Cc:     James Clark <james.clark@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Zaid Al-Bassam <zalbassam@google.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] arm64: perf: Add support for event counting threshold
Date:   Tue, 19 Sep 2023 10:51:28 +0100
Message-Id: <20230919095137.360963-2-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230919095137.360963-1-james.clark@arm.com>
References: <20230919095137.360963-1-james.clark@arm.com>
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

FEAT_PMUv3_TH (Armv8.8) permits a PMU counter to increment only on
events whose count meets a specified threshold condition. For example if
PMEVTYPERn.TC (Threshold Control) is set to 0b101 (Greater than or
equal, count), and the threshold is set to 2, then the PMU counter will
now only increment by 1 when an event would have previously incremented
the PMU counter by 2 or more on a single processor cycle.

Two new Perf event config fields, 'threshold' and 'threshold_control'
have been added for controlling the feature:

  $ perf stat -e stall_slot/threshold=2,threshold_control=5/

A new capability for reading out the maximum supported threshold value
has also been added:

  $ cat /sys/bus/event_source/devices/armv8_pmuv3/caps/threshold_max

  0x000000ff

If a threshold higher than threshold_max is provided, then no error is
generated but the threshold is clamped to the max value. If
FEAT_PMUv3_TH isn't implemented, then threshold_max reads zero, and
neither the 'threshold' nor 'threshold_control' parameters will be used.

The threshold is per PMU counter, and there are potentially different
threshold_max values per PMU type on heterogeneous systems.

Bits higher than 32 now need to be written into PMEVTYPER, so
armv8pmu_write_evtype() has to be updated to take a u64 value rather
than u32.

Signed-off-by: James Clark <james.clark@arm.com>
---
 drivers/perf/arm_pmuv3.c       | 59 +++++++++++++++++++++++++++++++++-
 include/linux/perf/arm_pmuv3.h |  7 +++-
 2 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index e5a2ac4155f6..ad6574b2bdab 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -294,9 +294,16 @@ static const struct attribute_group armv8_pmuv3_events_attr_group = {
 	.is_visible = armv8pmu_event_attr_is_visible,
 };
 
+#define TH_LO	2
+#define TH_HI	13
+#define TH_CNTL_LO	14
+#define TH_CNTL_HI	16
+
 PMU_FORMAT_ATTR(event, "config:0-15");
 PMU_FORMAT_ATTR(long, "config1:0");
 PMU_FORMAT_ATTR(rdpmc, "config1:1");
+PMU_FORMAT_ATTR(threshold, "config1:" __stringify(TH_LO) "-" __stringify(TH_HI));
+PMU_FORMAT_ATTR(threshold_control, "config1:" __stringify(TH_CNTL_LO) "-" __stringify(TH_CNTL_HI));
 
 static int sysctl_perf_user_access __read_mostly;
 
@@ -310,10 +317,22 @@ static inline bool armv8pmu_event_want_user_access(struct perf_event *event)
 	return event->attr.config1 & 0x2;
 }
 
+static inline u32 armv8pmu_event_threshold(struct perf_event_attr *attr)
+{
+	return FIELD_GET(GENMASK(TH_HI, TH_LO), attr->config1);
+}
+
+static inline u8 armv8pmu_event_threshold_control(struct perf_event_attr *attr)
+{
+	return FIELD_GET(GENMASK(TH_CNTL_HI, TH_CNTL_LO), attr->config1);
+}
+
 static struct attribute *armv8_pmuv3_format_attrs[] = {
 	&format_attr_event.attr,
 	&format_attr_long.attr,
 	&format_attr_rdpmc.attr,
+	&format_attr_threshold.attr,
+	&format_attr_threshold_control.attr,
 	NULL,
 };
 
@@ -365,10 +384,31 @@ static ssize_t bus_width_show(struct device *dev, struct device_attribute *attr,
 
 static DEVICE_ATTR_RO(bus_width);
 
+static u32 threshold_max(struct arm_pmu *cpu_pmu)
+{
+	/*
+	 * The largest value that can be written to PMEVTYPER<n>_EL0.TH is
+	 * (2 ^ PMMIR.THWIDTH) - 1
+	 */
+	return (1 << FIELD_GET(ARMV8_PMU_THWIDTH, cpu_pmu->reg_pmmir)) - 1;
+}
+
+static ssize_t threshold_max_show(struct device *dev,
+				  struct device_attribute *attr, char *page)
+{
+	struct pmu *pmu = dev_get_drvdata(dev);
+	struct arm_pmu *cpu_pmu = container_of(pmu, struct arm_pmu, pmu);
+
+	return sysfs_emit(page, "0x%08x\n", threshold_max(cpu_pmu));
+}
+
+static DEVICE_ATTR_RO(threshold_max);
+
 static struct attribute *armv8_pmuv3_caps_attrs[] = {
 	&dev_attr_slots.attr,
 	&dev_attr_bus_slots.attr,
 	&dev_attr_bus_width.attr,
+	&dev_attr_threshold_max.attr,
 	NULL,
 };
 
@@ -552,7 +592,7 @@ static void armv8pmu_write_counter(struct perf_event *event, u64 value)
 		armv8pmu_write_hw_counter(event, value);
 }
 
-static inline void armv8pmu_write_evtype(int idx, u32 val)
+static inline void armv8pmu_write_evtype(int idx, u64 val)
 {
 	u32 counter = ARMV8_IDX_TO_COUNTER(idx);
 
@@ -912,6 +952,10 @@ static int armv8pmu_set_event_filter(struct hw_perf_event *event,
 				     struct perf_event_attr *attr)
 {
 	unsigned long config_base = 0;
+	struct perf_event *perf_event = container_of(attr, struct perf_event,
+						     attr);
+	struct arm_pmu *cpu_pmu = to_arm_pmu(perf_event->pmu);
+	u32 th, th_max;
 
 	if (attr->exclude_idle)
 		return -EPERM;
@@ -943,6 +987,19 @@ static int armv8pmu_set_event_filter(struct hw_perf_event *event,
 	if (attr->exclude_user)
 		config_base |= ARMV8_PMU_EXCLUDE_EL0;
 
+	/*
+	 * Insert event counting threshold (FEAT_PMUv3_TH) values. If
+	 * FEAT_PMUv3_TH isn't implemented, then THWIDTH (threshold_max) will be
+	 * 0 and no values will be written.
+	 */
+	th_max = threshold_max(cpu_pmu);
+	if (th_max) {
+		th = min(armv8pmu_event_threshold(attr), th_max);
+		config_base |= FIELD_PREP(ARMV8_PMU_EVTYPE_TH, th);
+		config_base |= FIELD_PREP(ARMV8_PMU_EVTYPE_TC,
+					  armv8pmu_event_threshold_control(attr));
+	}
+
 	/*
 	 * Install the filter into config_base as this is used to
 	 * construct the event type.
diff --git a/include/linux/perf/arm_pmuv3.h b/include/linux/perf/arm_pmuv3.h
index e3899bd77f5c..0e2a3c927150 100644
--- a/include/linux/perf/arm_pmuv3.h
+++ b/include/linux/perf/arm_pmuv3.h
@@ -228,7 +228,11 @@
 /*
  * PMXEVTYPER: Event selection reg
  */
-#define ARMV8_PMU_EVTYPE_MASK	0xc800ffff	/* Mask for writable bits */
+#define ARMV8_PMU_EVTYPE_TH	GENMASK(43, 32)
+#define ARMV8_PMU_EVTYPE_TC	GENMASK(63, 61)
+/* Mask for writable bits */
+#define ARMV8_PMU_EVTYPE_MASK	(0xc800ffff | ARMV8_PMU_EVTYPE_TH | \
+				ARMV8_PMU_EVTYPE_TC)
 #define ARMV8_PMU_EVTYPE_EVENT	0xffff		/* Mask for EVENT bits */
 
 /*
@@ -254,6 +258,7 @@
 #define ARMV8_PMU_BUS_SLOTS_MASK 0xff
 #define ARMV8_PMU_BUS_WIDTH_SHIFT 16
 #define ARMV8_PMU_BUS_WIDTH_MASK 0xf
+#define ARMV8_PMU_THWIDTH GENMASK(23, 20)
 
 /*
  * This code is really good
-- 
2.34.1

