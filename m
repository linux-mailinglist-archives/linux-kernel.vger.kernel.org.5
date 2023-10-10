Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9E97BFB80
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 14:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbjJJMdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 08:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbjJJMd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 08:33:26 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2CCB7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 05:33:24 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4S4Zwf0rHCzVlV2;
        Tue, 10 Oct 2023 20:29:54 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 10 Oct 2023 20:33:22 +0800
From:   Yicong Yang <yangyicong@huawei.com>
To:     <mark.rutland@arm.com>, <maz@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <daniel.lezcano@linaro.org>, <tglx@linutronix.de>,
        <jonathan.cameron@huawei.com>, <prime.zeng@huawei.com>,
        <wanghuiqiang@huawei.com>, <wangwudi@hisilicon.com>,
        <guohanjun@huawei.com>, <yangyicong@hisilicon.com>,
        <linuxarm@huawei.com>
Subject: [RFC PATCH 3/3] clocksource/drivers: Add HiSilicon system timer driver
Date:   Tue, 10 Oct 2023 20:30:33 +0800
Message-ID: <20231010123033.23258-4-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20231010123033.23258-1-yangyicong@huawei.com>
References: <20231010123033.23258-1-yangyicong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yicong Yang <yangyicong@hisilicon.com>

HiSilicon system timer is compatible with arm's generic timer
specification but is enumerated through DSDT and can use SPI/LPI
interrupt as timer interrupt. This patch adds the support
for the timer. The driver probes the device IO memory and
interrupt resources through DSDT and then reuse the codes
of the arm_arch_timer for setup and register the clockevent
device.

Example DSDT node will be like:
	Device (TIM0)
        {
            Name (_HID, "HISI03F2")  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Name (RBUF, ResourceTemplate ()
            {
                QWordMemory (ResourceConsumer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x0000000000000000, // Granularity
                    0x0000000401170000, // Range Minimum
                    0x0000000401170fff, // Range Maximum
                    0x0000000000000000, // Translation Offset
                    0x0000000000001000, // Length
                    ,, , AddressRangeMemory, TypeStatic)
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x000003C6,
                }
            })
	    Method (_CRS, 0, NotSerialized)
	    {
		Return (RBUF)
	    }
	}

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/clocksource/Kconfig          | 10 ++++
 drivers/clocksource/Makefile         |  1 +
 drivers/clocksource/timer-hisi-sys.c | 68 ++++++++++++++++++++++++++++
 3 files changed, 79 insertions(+)
 create mode 100644 drivers/clocksource/timer-hisi-sys.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 0ba0dc4ecf06..2e43cd6e2add 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -732,4 +732,14 @@ config GOLDFISH_TIMER
 	help
 	  Support for the timer/counter of goldfish-rtc
 
+config HISI_SYS_TIMER
+	tristate "HiSilicon system timer driver"
+	depends on ARM_ARCH_TIMER && ARM64 && ACPI
+	help
+	  Support for HiSilicon system timer which used as a clockevent
+	  device.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called timer_hisi_sys.
+
 endmenu
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 368c3461dab8..39ababd0d4dd 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -89,3 +89,4 @@ obj-$(CONFIG_MSC313E_TIMER)		+= timer-msc313e.o
 obj-$(CONFIG_GOLDFISH_TIMER)		+= timer-goldfish.o
 obj-$(CONFIG_GXP_TIMER)			+= timer-gxp.o
 obj-$(CONFIG_CLKSRC_LOONGSON1_PWM)	+= timer-loongson1-pwm.o
+obj-$(CONFIG_HISI_SYS_TIMER)		+= timer-hisi-sys.o
diff --git a/drivers/clocksource/timer-hisi-sys.c b/drivers/clocksource/timer-hisi-sys.c
new file mode 100644
index 000000000000..1ef39d97e83d
--- /dev/null
+++ b/drivers/clocksource/timer-hisi-sys.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for HiSilicon system timer driver.
+ *
+ * The device is fully compatible with ARM's Generic Timer specification.
+ * The device is enumerated through DSDT rather than GTDT and can use
+ * LPI interrupt besides SPI.
+ *
+ * Copyright (c) 2023 HiSilicon Technologies Co., Ltd.
+ * Author: Yicong Yang <yangyicong@hisilicon.com>
+ */
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/units.h>
+
+#include <clocksource/arm_arch_timer.h>
+
+#define DRV_NAME	"hisi_sys_timer"
+
+#define CNTFRQ		0x10
+
+static const struct acpi_device_id hisi_sys_timer_acpi_ids[] = {
+	{ "HISI03F2", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, hisi_sys_timer_acpi_ids);
+
+static int hisi_sys_timer_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	void __iomem *iobase;
+	int ret, irq;
+	u32 freq;
+
+	iobase = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(iobase))
+		return PTR_ERR(iobase);
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq <= 0)
+		return dev_err_probe(dev, ret, "failed to get interrupt\n");
+
+	ret = arch_timer_mem_register(iobase, irq, false, DRV_NAME);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to register timer\n");
+
+	freq = readl_relaxed(iobase + CNTFRQ);
+	dev_info(dev, "%s works at %ldMHz\n", DRV_NAME, freq / HZ_PER_MHZ);
+	return 0;
+}
+
+static struct platform_driver hisi_sys_timer_driver = {
+	.probe = hisi_sys_timer_probe,
+	.driver = {
+		.name = DRV_NAME,
+		.acpi_match_table = hisi_sys_timer_acpi_ids,
+	},
+};
+module_platform_driver(hisi_sys_timer_driver);
+
+MODULE_AUTHOR("Yicong Yang <yangyicong@hisilicon.com>");
+MODULE_DESCRIPTION("HiSilicon system timer driver");
+MODULE_LICENSE("GPL");
-- 
2.24.0

