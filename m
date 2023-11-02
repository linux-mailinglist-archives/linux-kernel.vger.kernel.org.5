Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099597DF4FB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 15:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbjKBO2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 10:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjKBO2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 10:28:46 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9FA13A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 07:28:42 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3A2ERXdwC3062452, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3A2ERXdwC3062452
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Nov 2023 22:27:33 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 2 Nov 2023 22:27:33 +0800
Received: from james-bs01.realtek.com.tw (172.21.190.247) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 2 Nov 2023 22:27:33 +0800
From:   James Tai <james.tai@realtek.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-realtek-soc@lists.infradead.org>
CC:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Subject: [PATCH 5/6] irqchip: Introduce RTD1325 support using the Realtek Common Interrupt Controller Driver
Date:   Thu, 2 Nov 2023 22:27:30 +0800
Message-ID: <20231102142731.2087245-6-james.tai@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231102142731.2087245-1-james.tai@realtek.com>
References: <20231102142731.2087245-1-james.tai@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.190.247]
X-ClientProxiedBy: RTEXH36506.realtek.com.tw (172.21.6.27) To
 RTEXMBS03.realtek.com.tw (172.21.6.96)
X-KSE-ServerInfo: RTEXMBS03.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: license violation
X-KSE-Antivirus-Attachment-Filter-Interceptor-Info: license violation
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the RTD1325 platform.

Signed-off-by: James Tai <james.tai@realtek.com>
Change-Id: I9f1f504aa02a86449ae010993da28dc57c79dc77
---
 drivers/irqchip/Kconfig               |   6 +
 drivers/irqchip/Makefile              |   1 +
 drivers/irqchip/irq-realtek-rtd1325.c | 214 ++++++++++++++++++++++++++
 3 files changed, 221 insertions(+)
 create mode 100644 drivers/irqchip/irq-realtek-rtd1325.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index c6552c513442..65e2d67d1505 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -234,6 +234,12 @@ config REALTEK_RTD1319D_INTC
 	help
 	  Support for Realtek RTD1319D Interrupt Controller.
 
+config REALTEK_RTD1325_INTC
+	tristate "Realtek RTD1325 interrupt controller"
+	select REALTEK_DHC_INTC
+	help
+	  Support for Realtek RTD1325 Interrupt Controller.
+
 config RENESAS_INTC_IRQPIN
 	bool "Renesas INTC External IRQ Pin Support" if COMPILE_TEST
 	select IRQ_DOMAIN
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index c8adaed4c1b2..eaa12928d60b 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -50,6 +50,7 @@ obj-$(CONFIG_RDA_INTC)			+= irq-rda-intc.o
 obj-$(CONFIG_REALTEK_DHC_INTC)		+= irq-realtek-intc-common.o
 obj-$(CONFIG_REALTEK_RTD1319_INTC)	+= irq-realtek-rtd1319.o
 obj-$(CONFIG_REALTEK_RTD1319D_INTC)	+= irq-realtek-rtd1319d.o
+obj-$(CONFIG_REALTEK_RTD1325_INTC)	+= irq-realtek-rtd1325.o
 obj-$(CONFIG_RENESAS_INTC_IRQPIN)	+= irq-renesas-intc-irqpin.o
 obj-$(CONFIG_RENESAS_IRQC)		+= irq-renesas-irqc.o
 obj-$(CONFIG_RENESAS_RZA1_IRQC)		+= irq-renesas-rza1.o
diff --git a/drivers/irqchip/irq-realtek-rtd1325.c b/drivers/irqchip/irq-realtek-rtd1325.c
new file mode 100644
index 000000000000..4e67f1ab5073
--- /dev/null
+++ b/drivers/irqchip/irq-realtek-rtd1325.c
@@ -0,0 +1,214 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
+/*
+ * Realtek RTD1325 interrupt controller driver
+ *
+ * Copyright (c) 2023 Realtek Semiconductor Corporation
+ */
+
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/irqchip.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#include "irq-realtek-intc-common.h"
+
+enum rtd1325_iso_isr_bits {
+	RTD1325_ISO_ISR_TC3_SHIFT = 1,
+	RTD1325_ISO_ISR_UR0_SHIFT = 2,
+	RTD1325_ISO_ISR_LSADC0_SHIFT = 3,
+	RTD1325_ISO_ISR_WDOG1_NMI_SHIFT = 4,
+	RTD1325_ISO_ISR_IRDA_SHIFT = 5,
+	RTD1325_ISO_ISR_SPI1_SHIFT = 6,
+	RTD1325_ISO_ISR_WDOG2_NMI_SHIFT = 7,
+	RTD1325_ISO_ISR_I2C0_SHIFT = 8,
+	RTD1325_ISO_ISR_TC4_SHIFT = 9,
+	RTD1325_ISO_ISR_TC7_SHIFT = 10,
+	RTD1325_ISO_ISR_I2C1_SHIFT = 11,
+	RTD1325_ISO_ISR_HIFI_WAKEUP_SHIFT = 14,
+	RTD1325_ISO_ISR_WDOG4_NMI_SHIFT = 15,
+	RTD1325_ISO_ISR_TC8_SHIFT = 16,
+	RTD1325_ISO_ISR_VFD_SHIFT = 17,
+	RTD1325_ISO_ISR_VTC_SHIFT = 18,
+	RTD1325_ISO_ISR_GPIOA_SHIFT = 19,
+	RTD1325_ISO_ISR_GPIODA_SHIFT = 20,
+	RTD1325_ISO_ISR_ISO_MISC_SHIFT = 21,
+	RTD1325_ISO_ISR_CBUS_SHIFT = 22,
+	RTD1325_ISO_ISR_ETN_SHIFT = 23,
+	RTD1325_ISO_ISR_USB_HOST_SHIFT = 24,
+	RTD1325_ISO_ISR_USB_U3_DRD_SHIFT = 25,
+	RTD1325_ISO_ISR_USB_U2_DRD_SHIFT = 26,
+	RTD1325_ISO_ISR_WDOG3_NMI_SHIFT = 27,
+	RTD1325_ISO_ISR_PORB_HV_CEN_SHIFT = 28,
+	RTD1325_ISO_ISR_PORB_DV_CEN_SHIFT = 29,
+	RTD1325_ISO_ISR_PORB_AV_CEN_SHIFT = 30,
+	RTD1325_ISO_ISR_I2C1_REQ_SHIFT = 31,
+};
+
+static const u32 rtd1325_iso_isr_to_scpu_int_en_mask[32] = {
+	[RTD1325_ISO_ISR_SPI1_SHIFT] = BIT(1),
+	[RTD1325_ISO_ISR_UR0_SHIFT] = BIT(2),
+	[RTD1325_ISO_ISR_LSADC0_SHIFT] = BIT(3),
+	[RTD1325_ISO_ISR_IRDA_SHIFT] = BIT(5),
+	[RTD1325_ISO_ISR_I2C0_SHIFT] = BIT(8),
+	[RTD1325_ISO_ISR_I2C1_SHIFT] = BIT(11),
+	[RTD1325_ISO_ISR_VFD_SHIFT] = BIT(17),
+	[RTD1325_ISO_ISR_GPIOA_SHIFT] = BIT(19),
+	[RTD1325_ISO_ISR_GPIODA_SHIFT] = BIT(20),
+	[RTD1325_ISO_ISR_PORB_HV_CEN_SHIFT] = BIT(28),
+	[RTD1325_ISO_ISR_PORB_DV_CEN_SHIFT] = BIT(29),
+	[RTD1325_ISO_ISR_PORB_AV_CEN_SHIFT] = BIT(30),
+	[RTD1325_ISO_ISR_I2C1_REQ_SHIFT] = BIT(31),
+	[RTD1325_ISO_ISR_WDOG1_NMI_SHIFT] = IRQ_ALWAYS_ENABLED,
+	[RTD1325_ISO_ISR_WDOG2_NMI_SHIFT] = IRQ_ALWAYS_ENABLED,
+	[RTD1325_ISO_ISR_WDOG3_NMI_SHIFT] = IRQ_ALWAYS_ENABLED,
+	[RTD1325_ISO_ISR_WDOG4_NMI_SHIFT] = IRQ_ALWAYS_ENABLED,
+};
+
+enum rtd1325_misc_isr_bits {
+	RTD1325_ISR_UR1_SHIFT = 3,
+	RTD1325_ISR_TC5_SHIFT = 4,
+	RTD1325_ISR_UR1_TO_SHIFT = 5,
+	RTD1325_ISR_TC0_SHIFT = 6,
+	RTD1325_ISR_TC1_SHIFT = 7,
+	RTD1325_ISR_UR2_SHIFT = 8,
+	RTD1325_ISR_UR2_TO_SHIFT = 13,
+	RTD1325_ISR_I2C5_SHIFT = 14,
+	RTD1325_ISR_I2C4_SHIFT = 15,
+	RTD1325_ISR_DRTC_HSEC_SHIFT = 16,
+	RTD1325_ISR_DRTC_MIN_SHIFT = 17,
+	RTD1325_ISR_DRTC_HOUR_SHIFT = 18,
+	RTD1325_ISR_DRTC_DATE_SHIFT = 19,
+	RTD1325_ISR_DRTC_ALARM_SHIFT = 20,
+	RTD1325_ISR_I2C3_SHIFT = 23,
+	RTD1325_ISR_SC0_SHIFT = 24,
+	RTD1325_ISR_SC1_SHIFT = 25,
+	RTD1325_ISR_SPI_SHIFT = 27,
+	RTD1325_ISR_FAN_SHIFT = 29,
+};
+
+static const u32 rtd1325_misc_isr_to_scpu_int_en_mask[32] = {
+	[RTD1325_ISR_UR1_SHIFT] = BIT(3),
+	[RTD1325_ISR_UR1_TO_SHIFT] = BIT(5),
+	[RTD1325_ISR_UR2_TO_SHIFT] = BIT(6),
+	[RTD1325_ISR_UR2_SHIFT] = BIT(7),
+	[RTD1325_ISR_I2C5_SHIFT] = BIT(14),
+	[RTD1325_ISR_I2C4_SHIFT] = BIT(15),
+	[RTD1325_ISR_DRTC_HSEC_SHIFT] = BIT(16),
+	[RTD1325_ISR_DRTC_MIN_SHIFT] = BIT(17),
+	[RTD1325_ISR_DRTC_HOUR_SHIFT] = BIT(18),
+	[RTD1325_ISR_DRTC_DATE_SHIFT] = BIT(19),
+	[RTD1325_ISR_DRTC_ALARM_SHIFT] = BIT(20),
+	[RTD1325_ISR_SC0_SHIFT] = BIT(24),
+	[RTD1325_ISR_SC1_SHIFT] = BIT(25),
+	[RTD1325_ISR_SPI_SHIFT] = BIT(27),
+	[RTD1325_ISR_I2C3_SHIFT] = BIT(28),
+	[RTD1325_ISR_FAN_SHIFT] = BIT(29),
+};
+
+static struct realtek_intc_subset_cfg rtd1325_intc_iso_cfgs[] = {
+	{ 0xf7ff7f6e, }, /* normal case */
+	{ 0x08008090, }, /* nmi wathdog case */
+};
+
+static const struct realtek_intc_info rtd1325_intc_iso_info = {
+	.isr_offset = 0x0,
+	.umsk_isr_offset = 0x4,
+	.scpu_int_en_offset = 0x40,
+	.isr_to_scpu_int_en_mask = rtd1325_iso_isr_to_scpu_int_en_mask,
+	.cfg = rtd1325_intc_iso_cfgs,
+	.cfg_num = ARRAY_SIZE(rtd1325_intc_iso_cfgs),
+};
+
+static struct realtek_intc_subset_cfg rtd1325_intc_misc_cfgs[] = {
+	{ 0xffe0ded6, }, /* normal case */
+	{ 0x00000028, }, /* uart1 case */
+	{ 0x00002100, }, /* uart2 case */
+};
+
+static const struct realtek_intc_info rtd1325_intc_misc_info = {
+	.umsk_isr_offset = 0x8,
+	.isr_offset = 0xc,
+	.scpu_int_en_offset = 0x80,
+	.isr_to_scpu_int_en_mask = rtd1325_misc_isr_to_scpu_int_en_mask,
+	.cfg = rtd1325_intc_misc_cfgs,
+	.cfg_num = ARRAY_SIZE(rtd1325_intc_misc_cfgs),
+};
+
+static const struct of_device_id realtek_intc_rtd1325_dt_matches[] = {
+	{
+		.compatible = "realtek,rtd1325-intc-iso",
+		.data = &rtd1325_intc_iso_info,
+	}, {
+		.compatible = "realtek,rtd1325-intc-misc",
+		.data = &rtd1325_intc_misc_info,
+	},
+	{ /* sentinel */ }
+};
+
+static int realtek_intc_rtd1325_suspend(struct device *dev)
+{
+	struct realtek_intc_data *data = dev_get_drvdata(dev);
+	const struct realtek_intc_info *info = data->info;
+
+	data->saved_en = readl(data->base + info->scpu_int_en_offset);
+
+	writel(DISABLE_INTC, data->base + info->scpu_int_en_offset);
+	writel(CLEAN_INTC_STATUS, data->base + info->umsk_isr_offset);
+	writel(CLEAN_INTC_STATUS, data->base + info->isr_offset);
+
+	return 0;
+}
+
+static int realtek_intc_rtd1325_resume(struct device *dev)
+{
+	struct realtek_intc_data *data = dev_get_drvdata(dev);
+	const struct realtek_intc_info *info = data->info;
+
+	writel(CLEAN_INTC_STATUS, data->base + info->umsk_isr_offset);
+	writel(CLEAN_INTC_STATUS, data->base + info->isr_offset);
+	writel(data->saved_en, data->base + info->scpu_int_en_offset);
+
+	return 0;
+}
+
+const struct dev_pm_ops realtek_intc_rtd1325_pm_ops = {
+	.suspend_noirq = realtek_intc_rtd1325_suspend,
+	.resume_noirq = realtek_intc_rtd1325_resume,
+};
+
+static int rtd1325_intc_probe(struct platform_device *pdev)
+{
+	const struct realtek_intc_info *info;
+
+	info = of_device_get_match_data(&pdev->dev);
+	if (!info)
+		return -EINVAL;
+
+	return realtek_intc_probe(pdev, info);
+}
+
+static struct platform_driver realtek_intc_rtd1325_driver = {
+	.probe = rtd1325_intc_probe,
+	.driver = {
+		.name = "realtek_intc_rtd1325",
+		.of_match_table = realtek_intc_rtd1325_dt_matches,
+		.suppress_bind_attrs = true,
+		.pm = &realtek_intc_rtd1325_pm_ops,
+	},
+};
+
+static int __init realtek_intc_rtd1325_init(void)
+{
+	return platform_driver_register(&realtek_intc_rtd1325_driver);
+}
+core_initcall(realtek_intc_rtd1325_init);
+
+static void __exit realtek_intc_rtd1325_exit(void)
+{
+	platform_driver_unregister(&realtek_intc_rtd1325_driver);
+}
+module_exit(realtek_intc_rtd1325_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Realtek RTD1325 Interrupt Controller Driver");
-- 
2.25.1

