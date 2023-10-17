Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F1E7CBA19
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 07:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234658AbjJQF0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 01:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234592AbjJQFZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 01:25:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCE51BF;
        Mon, 16 Oct 2023 22:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697520319; x=1729056319;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=sMUr0p6GsDTt7jB2LuU724MrPrsFBlCWOk8zjOW+ydE=;
  b=lkzQAeS3lx1+nQ7AMCY/s9kvdL6APZLA/FzZOuwP3UE6OVnp4ARM6CXC
   B42roIzMUmNJpmp356ndixK2RzwzIElcMSmEjIy/umv5yjSFWjRTD2+P1
   Xq3V+qtXPtKOsuuDQuGkdOslbREvXbJdGc4ZM+t6W8oIU8bdOf+9tuZiA
   z0OoFGegYBJKfA/FZjwsfN/K7GQebFE4q5xewsJxRVCaLu052I8qpzGNV
   jWM49ivvVNU+xN8r86p4Bz3S0d2dm4JdxYeL9zH1BSwwXyCwY/KqUa28n
   iANpiept5r3M/0qcIOfyU2pEq9rWjDwYidq23/Vr3kCOWSUGLU2yBhYO8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="388561762"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="388561762"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 22:25:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="1087358003"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="1087358003"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmsmga005.fm.intel.com with ESMTP; 16 Oct 2023 22:25:14 -0700
From:   lakshmi.sowjanya.d@intel.com
To:     tglx@linutronix.de, jstultz@google.com, giometti@enneenne.com,
        corbet@lwn.net, linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, linux-doc@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, eddie.dong@intel.com,
        christopher.s.hall@intel.com, pandith.n@intel.com,
        mallikarjunappa.sangannavar@intel.com, thejesh.reddy.t.r@intel.com,
        lakshmi.sowjanya.d@intel.com
Subject: [PATCH v1 4/6] pps: generators: Add PPS Generator TIO Driver
Date:   Tue, 17 Oct 2023 10:54:55 +0530
Message-Id: <20231017052457.25287-5-lakshmi.sowjanya.d@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231017052457.25287-1-lakshmi.sowjanya.d@intel.com>
References: <20231017052457.25287-1-lakshmi.sowjanya.d@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>

The Intel PPS Generator Timed IO driver provides PPS signal generation
functionality. It uses hrtimers to schedule output. The timer handler
writes the ART trigger value - derived from the system time - to the
Timed IO hardware. The Timed IO hardware generates an event precisely
at the requested system time without software involvement.

Co-developed-by: Christopher Hall <christopher.s.hall@intel.com>
Signed-off-by: Christopher Hall <christopher.s.hall@intel.com>
Co-developed-by: Pandith N <pandith.n@intel.com>
Signed-off-by: Pandith N <pandith.n@intel.com>
Co-developed-by: Thejesh Reddy T R <thejesh.reddy.t.r@intel.com>
Signed-off-by: Thejesh Reddy T R <thejesh.reddy.t.r@intel.com>
Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
Reviewed-by: Eddie Dong <eddie.dong@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pps/generators/Kconfig       |  16 ++
 drivers/pps/generators/Makefile      |   1 +
 drivers/pps/generators/pps_gen_tio.c | 302 +++++++++++++++++++++++++++
 3 files changed, 319 insertions(+)
 create mode 100644 drivers/pps/generators/pps_gen_tio.c

diff --git a/drivers/pps/generators/Kconfig b/drivers/pps/generators/Kconfig
index d615e640fcad..0f090932336f 100644
--- a/drivers/pps/generators/Kconfig
+++ b/drivers/pps/generators/Kconfig
@@ -12,3 +12,19 @@ config PPS_GENERATOR_PARPORT
 	  If you say yes here you get support for a PPS signal generator which
 	  utilizes STROBE pin of a parallel port to send PPS signals. It uses
 	  parport abstraction layer and hrtimers to precisely control the signal.
+
+config PPS_GENERATOR_TIO
+	tristate "TIO PPS signal generator"
+	depends on X86 && CPU_SUP_INTEL
+	help
+	  If you say yes here you get support for a PPS TIO signal generator
+	  which generates a pulse at a prescribed time based on the system clock.
+	  It uses time translation and hrtimers to precisely generate a pulse.
+	  This hardware is present on 2019 and newer Intel CPUs. However, this
+	  driver is not useful without adding highly specialized hardware outside
+	  the Linux system to observe these pulses.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pps_gen_tio.
+
+	  If unsure, say N.
diff --git a/drivers/pps/generators/Makefile b/drivers/pps/generators/Makefile
index 2d56dd0495d5..07004cfd3996 100644
--- a/drivers/pps/generators/Makefile
+++ b/drivers/pps/generators/Makefile
@@ -4,6 +4,7 @@
 #
 
 obj-$(CONFIG_PPS_GENERATOR_PARPORT) += pps_gen_parport.o
+obj-$(CONFIG_PPS_GENERATOR_TIO) += pps_gen_tio.o
 
 ifeq ($(CONFIG_PPS_DEBUG),y)
 EXTRA_CFLAGS += -DDEBUG
diff --git a/drivers/pps/generators/pps_gen_tio.c b/drivers/pps/generators/pps_gen_tio.c
new file mode 100644
index 000000000000..4ab7020a5cb6
--- /dev/null
+++ b/drivers/pps/generators/pps_gen_tio.c
@@ -0,0 +1,302 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Intel PPS signal Generator Driver
+ *
+ * Copyright (C) 2023 Intel Corporation
+ */
+
+#include <linux/bits.h>
+#include <linux/bitfield.h>
+#include <linux/cleanup.h>
+#include <linux/cpu.h>
+#include <linux/io-64-nonatomic-hi-lo.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/timekeeping.h>
+#include <linux/types.h>
+
+#include <asm/cpu_device_id.h>
+
+#define TIOCTL			0x00
+#define TIOCOMPV		0x10
+
+/* Control Register */
+#define TIOCTL_EN			BIT(0)
+#define TIOCTL_DIR			BIT(1)
+#define TIOCTL_EP			GENMASK(3, 2)
+#define TIOCTL_EP_RISING_EDGE		FIELD_PREP(TIOCTL_EP, 0)
+#define TIOCTL_EP_FALLING_EDGE		FIELD_PREP(TIOCTL_EP, 1)
+#define TIOCTL_EP_TOGGLE_EDGE		FIELD_PREP(TIOCTL_EP, 2)
+
+#define PREP_INTERVAL_NS		(10 * NSEC_PER_MSEC) /* Safety time to set hrtimer early */
+
+struct pps_tio {
+	struct hrtimer timer;
+	struct device *dev;
+	spinlock_t lock;
+	struct attribute_group attrs;
+	void __iomem *base;
+	bool enabled;
+};
+
+static inline u32 pps_ctl_read(struct pps_tio *tio)
+{
+	return readl(tio->base + TIOCTL);
+}
+
+static inline void pps_ctl_write(struct pps_tio *tio, u32 value)
+{
+	writel(value, tio->base + TIOCTL);
+}
+
+/* For COMPV register, It's safer to write higher 32-bit followed by lower 32-bit */
+static inline void pps_compv_write(struct pps_tio *tio, u64 value)
+{
+	hi_lo_writeq(value, tio->base + TIOCOMPV);
+}
+
+static inline ktime_t first_event(struct pps_tio *tio)
+{
+	struct timespec64 ts;
+
+	ktime_get_real_ts64(&ts);
+
+	return ktime_set(ts.tv_sec + 1, NSEC_PER_SEC - PREP_INTERVAL_NS);
+}
+
+static int translate_system_time_to_art_cycles(struct timespec64 ts, u64 *art_timestamp,
+					       bool *real_to_tsc_result)
+{
+	struct system_counterval_t sys_counter;
+	ktime_t sys_realtime;
+	int err;
+
+	sys_realtime = timespec64_to_ktime(ts);
+	err = ktime_convert_real_to_system_counter(sys_realtime, &sys_counter);
+	if (err) {
+		*real_to_tsc_result = true;
+		return err;
+	}
+
+	return convert_tsc_to_art(&sys_counter, art_timestamp);
+}
+
+static u32 pps_tio_disable(struct pps_tio *tio)
+{
+	u32 ctrl;
+
+	ctrl = pps_ctl_read(tio);
+	pps_compv_write(tio, 0);
+
+	ctrl &= ~TIOCTL_EN;
+	pps_ctl_write(tio, ctrl);
+
+	return ctrl;
+}
+
+static void pps_tio_direction_output(struct pps_tio *tio)
+{
+	u32 ctrl;
+
+	ctrl = pps_tio_disable(tio);
+
+	/* We enable the device, be sure that the 'compare' value is invalid */
+	pps_compv_write(tio, 0);
+
+	ctrl &= ~(TIOCTL_DIR | TIOCTL_EP);
+	ctrl |= TIOCTL_EP_TOGGLE_EDGE;
+	pps_ctl_write(tio, ctrl);
+
+	ctrl |= TIOCTL_EN;
+	pps_ctl_write(tio, ctrl);
+}
+
+static int pps_tio_generate_output(struct pps_tio *tio, struct timespec64 time)
+{
+	bool real_to_tsc_result;
+	u64 art_timestamp;
+	int err;
+
+	real_to_tsc_result = false;
+	err = translate_system_time_to_art_cycles(time, &art_timestamp, &real_to_tsc_result);
+	if (err) {
+		pps_tio_disable(tio);
+		dev_err(tio->dev, "Disabling PPS due to failure in conversion of %s",
+			real_to_tsc_result ? "realtime to system_counter" : "tsc to art");
+		return err;
+	}
+	/* The timed IO hardware adds a two cycle delay on output */
+	art_timestamp -= 2;
+	pps_compv_write(tio, art_timestamp);
+
+	return 0;
+}
+
+static int schedule_event(struct hrtimer *timer, struct timespec64 *next_event)
+{
+	struct pps_tio *tio = container_of(timer, struct pps_tio, timer);
+	struct timespec64 expire_time, cur_time, roundoff;
+	long half_sec_ns = NSEC_PER_SEC / 2;
+
+	/* get the current time */
+	ktime_get_real_ts64(&cur_time);
+	expire_time = ktime_to_timespec64(hrtimer_get_softexpires(timer));
+
+	/*
+	 * Figure out if it is in "top half" or "bottom half" of the second
+	 * and round-off to the nearest 500ms
+	 */
+	if (cur_time.tv_nsec > half_sec_ns) {
+		roundoff.tv_sec = cur_time.tv_sec + 1;
+		roundoff.tv_nsec = 0;
+		next_event->tv_sec = roundoff.tv_sec;
+		next_event->tv_nsec = half_sec_ns;
+	} else {
+		roundoff.tv_sec = cur_time.tv_sec;
+		roundoff.tv_nsec = half_sec_ns;
+		next_event->tv_sec = roundoff.tv_sec;
+		next_event->tv_nsec = roundoff.tv_nsec + half_sec_ns;
+	}
+	next_event->tv_nsec -= PREP_INTERVAL_NS;
+
+	/* Check for elapsed time */
+	if (expire_time.tv_sec != cur_time.tv_sec ||
+	    (cur_time.tv_nsec - PREP_INTERVAL_NS) > expire_time.tv_nsec) {
+		dev_warn(tio->dev, "Time expired, edge not scheduled at time: %lld.%09ld\n",
+			 cur_time.tv_sec, cur_time.tv_nsec);
+		return 0;
+	}
+
+	return pps_tio_generate_output(tio, roundoff);
+}
+
+static enum hrtimer_restart hrtimer_callback(struct hrtimer *timer)
+{
+	struct pps_tio *tio = container_of(timer, struct pps_tio, timer);
+	struct timespec64 next_event;
+	int err = 0;
+
+	scoped_guard(spinlock_irqsave, &tio->lock) {
+		if (tio->enabled)
+			err = schedule_event(timer, &next_event);
+	}
+	if (err)
+		return HRTIMER_NORESTART;
+
+	hrtimer_set_expires(timer, ktime_set(next_event.tv_sec, next_event.tv_nsec));
+
+	return HRTIMER_RESTART;
+}
+
+static ssize_t enable_store(struct device *dev, struct device_attribute *attr, const char *buf,
+			    size_t count)
+{
+	struct pps_tio *tio = dev_get_drvdata(dev);
+	bool enable;
+	int err;
+
+	err = kstrtobool(buf, &enable);
+	if (err)
+		return err;
+
+	guard(spinlock_irqsave)(&tio->lock);
+	if (enable && !tio->enabled) {
+		if (!is_current_clocksource_art_related()) {
+			dev_err(tio->dev, "PPS cannot be started as clock is not related to ART");
+			return -EPERM;
+		}
+		pps_tio_direction_output(tio);
+		hrtimer_start(&tio->timer, first_event(tio), HRTIMER_MODE_ABS);
+		tio->enabled = true;
+	} else if (!enable && tio->enabled) {
+		hrtimer_cancel(&tio->timer);
+		pps_tio_disable(tio);
+		tio->enabled = false;
+	}
+	return count;
+}
+
+static ssize_t enable_show(struct device *dev, struct device_attribute *devattr, char *buf)
+{
+	struct pps_tio *tio = dev_get_drvdata(dev);
+	u32 ctrl;
+
+	ctrl = pps_ctl_read(tio);
+	ctrl &= TIOCTL_EN;
+
+	return sysfs_emit(buf, "%u\n", ctrl);
+}
+static DEVICE_ATTR_RW(enable);
+
+static struct attribute *pps_tio_attrs[] = {
+	&dev_attr_enable.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(pps_tio);
+
+static int pps_tio_probe(struct platform_device *pdev)
+{
+	struct pps_tio *tio;
+
+	if (!(cpu_feature_enabled(X86_FEATURE_TSC_KNOWN_FREQ) &&
+	      cpu_feature_enabled(X86_FEATURE_ART))) {
+		dev_warn(&pdev->dev, "TSC/ART is not enabled");
+		return -ENODEV;
+	}
+
+	tio = devm_kzalloc(&pdev->dev, sizeof(*tio), GFP_KERNEL);
+	if (!tio)
+		return -ENOMEM;
+
+	tio->dev = &pdev->dev;
+	tio->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(tio->base))
+		return PTR_ERR(tio->base);
+
+	pps_tio_disable(tio);
+	hrtimer_init(&tio->timer, CLOCK_REALTIME, HRTIMER_MODE_ABS);
+	tio->timer.function = hrtimer_callback;
+	spin_lock_init(&tio->lock);
+	tio->enabled = false;
+	platform_set_drvdata(pdev, tio);
+
+	return 0;
+}
+
+static int pps_tio_remove(struct platform_device *pdev)
+{
+	struct pps_tio *tio = platform_get_drvdata(pdev);
+
+	hrtimer_cancel(&tio->timer);
+	pps_tio_disable(tio);
+
+	return 0;
+}
+
+static const struct acpi_device_id intel_pmc_tio_acpi_match[] = {
+	{ "INTC1021" },
+	{ "INTC1022" },
+	{ "INTC1023" },
+	{ "INTC1024" },
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, intel_pmc_tio_acpi_match);
+
+static struct platform_driver pps_tio_driver = {
+	.probe          = pps_tio_probe,
+	.remove         = pps_tio_remove,
+	.driver         = {
+		.name                   = "intel-pps-generator",
+		.acpi_match_table       = intel_pmc_tio_acpi_match,
+		.dev_groups             = pps_tio_groups,
+	},
+};
+module_platform_driver(pps_tio_driver);
+
+MODULE_AUTHOR("Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>");
+MODULE_AUTHOR("Christopher Hall <christopher.s.hall@intel.com>");
+MODULE_AUTHOR("Pandith N <pandith.n@intel.com>");
+MODULE_AUTHOR("Thejesh Reddy T R <thejesh.reddy.t.r@intel.com>");
+MODULE_DESCRIPTION("Intel PMC Time-Aware IO Generator Driver");
+MODULE_LICENSE("GPL");
-- 
2.17.1

