Return-Path: <linux-kernel+bounces-12442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C27681F4E2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 07:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB4701F22543
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 06:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EDD2904;
	Thu, 28 Dec 2023 06:09:23 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49286FBF;
	Thu, 28 Dec 2023 06:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BS69AjkC1766945, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BS69AjkC1766945
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Dec 2023 14:09:10 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Thu, 28 Dec 2023 14:09:10 +0800
Received: from james-bs01.realtek.com.tw (172.21.190.247) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Dec 2023 14:09:06 +0800
From: James Tai <james.tai@realtek.com>
To: Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>,
        "Rob
 Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, James Tai <james.tai@realtek.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v4 4/6] irqchip: Introduce RTD1319D support using the Realtek common interrupt controller driver
Date: Thu, 28 Dec 2023 14:08:23 +0800
Message-ID: <20231228060825.1380439-5-james.tai@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231228060825.1380439-1-james.tai@realtek.com>
References: <20231228060825.1380439-1-james.tai@realtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36505.realtek.com.tw (172.21.6.25) To
 RTEXMBS03.realtek.com.tw (172.21.6.96)
X-KSE-ServerInfo: RTEXMBS03.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

Add support for the RTD1319D platform.

Signed-off-by: James Tai <james.tai@realtek.com>
---
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Marc Zyngier <maz@kernel.org>
CC: linux-kernel@vger.kernel.org

v3 to v4 change:
- Replaced the 'core_initcall' with 'module_init'
- Removed redundant header files
- Moved the function of suspend and resume to common code
- Improved the description of config

v2 to v3 change:
- Unchanged

v1 to v2 change:
- Resolved kernel test robot build warnings
- Replaced magic number with macro
- Fixed code style issues

 drivers/irqchip/Kconfig                |  10 ++
 drivers/irqchip/Makefile               |   1 +
 drivers/irqchip/irq-realtek-rtd1319d.c | 196 +++++++++++++++++++++++++
 3 files changed, 207 insertions(+)
 create mode 100644 drivers/irqchip/irq-realtek-rtd1319d.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index b17006ff38c4..e34312ef7cd4 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -232,6 +232,16 @@ config REALTEK_RTD1319_INTC
 
 	  If unsure, say N.
 
+config REALTEK_RTD1319D_INTC
+	tristate "Realtek RTD1319D interrupt controller"
+	select REALTEK_DHC_INTC
+	help
+	  Enable support for the Realtek RTD1319D SoC Interrupt Controller.
+	  Each Realtek DHC SoC has two sets of interrupt controllers, each
+	  capable of handling up to 32 interrupts.
+
+	  If unsure, say N.
+
 config RENESAS_INTC_IRQPIN
 	bool "Renesas INTC External IRQ Pin Support" if COMPILE_TEST
 	select IRQ_DOMAIN
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 6a2650b0a924..c8adaed4c1b2 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -49,6 +49,7 @@ obj-$(CONFIG_JCORE_AIC)			+= irq-jcore-aic.o
 obj-$(CONFIG_RDA_INTC)			+= irq-rda-intc.o
 obj-$(CONFIG_REALTEK_DHC_INTC)		+= irq-realtek-intc-common.o
 obj-$(CONFIG_REALTEK_RTD1319_INTC)	+= irq-realtek-rtd1319.o
+obj-$(CONFIG_REALTEK_RTD1319D_INTC)	+= irq-realtek-rtd1319d.o
 obj-$(CONFIG_RENESAS_INTC_IRQPIN)	+= irq-renesas-intc-irqpin.o
 obj-$(CONFIG_RENESAS_IRQC)		+= irq-renesas-irqc.o
 obj-$(CONFIG_RENESAS_RZA1_IRQC)		+= irq-renesas-rza1.o
diff --git a/drivers/irqchip/irq-realtek-rtd1319d.c b/drivers/irqchip/irq-realtek-rtd1319d.c
new file mode 100644
index 000000000000..8a18adeedc67
--- /dev/null
+++ b/drivers/irqchip/irq-realtek-rtd1319d.c
@@ -0,0 +1,196 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
+/*
+ * Realtek RTD1319D interrupt controller driver
+ *
+ * Copyright (c) 2023 Realtek Semiconductor Corporation
+ */
+
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
+#include "irq-realtek-intc-common.h"
+
+#define ISO_NMI_WDT_MASK     0x08008090
+#define ISO_NORMAL_MASK      0xf7ff7f6e
+#define MISC_NORMAL_MASK     0xffe0ded6
+#define MISC_UART1_MASK      0x00000028
+#define MISC_UART2_MASK      0x00002100
+
+#define ISO_ISR_EN_OFFSET    0x40
+#define ISO_ISR_OFFSET       0
+#define ISO_ISR_UMSK_OFFSET  0x4
+#define MISC_ISR_EN_OFFSET   0x80
+#define MISC_ISR_OFFSET      0xc
+#define MISC_ISR_UMSK_OFFSET 0x8
+
+enum rtd1319d_iso_isr_bits {
+	RTD1319D_ISO_ISR_TC3_SHIFT	   = 1,
+	RTD1319D_ISO_ISR_UR0_SHIFT	   = 2,
+	RTD1319D_ISO_ISR_LSADC0_SHIFT	   = 3,
+	RTD1319D_ISO_ISR_WDOG1_NMI_SHIFT   = 4,
+	RTD1319D_ISO_ISR_IRDA_SHIFT	   = 5,
+	RTD1319D_ISO_ISR_SPI1_SHIFT	   = 6,
+	RTD1319D_ISO_ISR_WDOG2_NMI_SHIFT   = 7,
+	RTD1319D_ISO_ISR_I2C0_SHIFT	   = 8,
+	RTD1319D_ISO_ISR_TC4_SHIFT	   = 9,
+	RTD1319D_ISO_ISR_TC7_SHIFT	   = 10,
+	RTD1319D_ISO_ISR_I2C1_SHIFT	   = 11,
+	RTD1319D_ISO_ISR_HIFI_WAKEUP_SHIFT = 14,
+	RTD1319D_ISO_ISR_WDOG4_NMI_SHIFT   = 15,
+	RTD1319D_ISO_ISR_TC8_SHIFT	   = 16,
+	RTD1319D_ISO_ISR_VFD_SHIFT	   = 17,
+	RTD1319D_ISO_ISR_VTC_SHIFT	   = 18,
+	RTD1319D_ISO_ISR_GPIOA_SHIFT	   = 19,
+	RTD1319D_ISO_ISR_GPIODA_SHIFT	   = 20,
+	RTD1319D_ISO_ISR_ISO_MISC_SHIFT	   = 21,
+	RTD1319D_ISO_ISR_CBUS_SHIFT	   = 22,
+	RTD1319D_ISO_ISR_ETN_SHIFT	   = 23,
+	RTD1319D_ISO_ISR_USB_HOST_SHIFT	   = 24,
+	RTD1319D_ISO_ISR_USB_U3_DRD_SHIFT  = 25,
+	RTD1319D_ISO_ISR_USB_U2_DRD_SHIFT  = 26,
+	RTD1319D_ISO_ISR_WDOG3_NMI_SHIFT   = 27,
+	RTD1319D_ISO_ISR_PORB_HV_CEN_SHIFT = 28,
+	RTD1319D_ISO_ISR_PORB_DV_CEN_SHIFT = 29,
+	RTD1319D_ISO_ISR_PORB_AV_CEN_SHIFT = 30,
+	RTD1319D_ISO_ISR_I2C1_REQ_SHIFT	   = 31,
+};
+
+static const u32 rtd1319d_iso_isr_to_scpu_int_en_mask[32] = {
+	[RTD1319D_ISO_ISR_SPI1_SHIFT]	     = BIT(1),
+	[RTD1319D_ISO_ISR_UR0_SHIFT]	     = BIT(2),
+	[RTD1319D_ISO_ISR_LSADC0_SHIFT]	     = BIT(3),
+	[RTD1319D_ISO_ISR_IRDA_SHIFT]	     = BIT(5),
+	[RTD1319D_ISO_ISR_I2C0_SHIFT]	     = BIT(8),
+	[RTD1319D_ISO_ISR_I2C1_SHIFT]	     = BIT(11),
+	[RTD1319D_ISO_ISR_VFD_SHIFT]	     = BIT(17),
+	[RTD1319D_ISO_ISR_GPIOA_SHIFT]	     = BIT(19),
+	[RTD1319D_ISO_ISR_GPIODA_SHIFT]	     = BIT(20),
+	[RTD1319D_ISO_ISR_PORB_HV_CEN_SHIFT] = BIT(28),
+	[RTD1319D_ISO_ISR_PORB_DV_CEN_SHIFT] = BIT(29),
+	[RTD1319D_ISO_ISR_PORB_AV_CEN_SHIFT] = BIT(30),
+	[RTD1319D_ISO_ISR_I2C1_REQ_SHIFT]    = BIT(31),
+	[RTD1319D_ISO_ISR_WDOG1_NMI_SHIFT]   = IRQ_ALWAYS_ENABLED,
+	[RTD1319D_ISO_ISR_WDOG2_NMI_SHIFT]   = IRQ_ALWAYS_ENABLED,
+	[RTD1319D_ISO_ISR_WDOG3_NMI_SHIFT]   = IRQ_ALWAYS_ENABLED,
+	[RTD1319D_ISO_ISR_WDOG4_NMI_SHIFT]   = IRQ_ALWAYS_ENABLED,
+};
+
+enum rtd1319d_misc_isr_bits {
+	RTD1319D_ISR_UR1_SHIFT	      = 3,
+	RTD1319D_ISR_TC5_SHIFT	      = 4,
+	RTD1319D_ISR_UR1_TO_SHIFT     = 5,
+	RTD1319D_ISR_TC0_SHIFT	      = 6,
+	RTD1319D_ISR_TC1_SHIFT	      = 7,
+	RTD1319D_ISR_UR2_SHIFT	      = 8,
+	RTD1319D_ISR_UR2_TO_SHIFT     = 13,
+	RTD1319D_ISR_I2C5_SHIFT	      = 14,
+	RTD1319D_ISR_I2C4_SHIFT	      = 15,
+	RTD1319D_ISR_DRTC_HSEC_SHIFT  = 16,
+	RTD1319D_ISR_DRTC_MIN_SHIFT   = 17,
+	RTD1319D_ISR_DRTC_HOUR_SHIFT  = 18,
+	RTD1319D_ISR_DRTC_DATE_SHIFT  = 19,
+	RTD1319D_ISR_DRTC_ALARM_SHIFT = 20,
+	RTD1319D_ISR_I2C3_SHIFT	      = 23,
+	RTD1319D_ISR_SC0_SHIFT	      = 24,
+	RTD1319D_ISR_SC1_SHIFT	      = 25,
+	RTD1319D_ISR_SPI_SHIFT	      = 27,
+	RTD1319D_ISR_FAN_SHIFT	      = 29,
+};
+
+static const u32 rtd1319d_misc_isr_to_scpu_int_en_mask[32] = {
+	[RTD1319D_ISR_UR1_SHIFT]	= BIT(3),
+	[RTD1319D_ISR_UR1_TO_SHIFT]	= BIT(5),
+	[RTD1319D_ISR_UR2_TO_SHIFT]	= BIT(6),
+	[RTD1319D_ISR_UR2_SHIFT]	= BIT(7),
+	[RTD1319D_ISR_I2C5_SHIFT]	= BIT(14),
+	[RTD1319D_ISR_I2C4_SHIFT]	= BIT(15),
+	[RTD1319D_ISR_DRTC_HSEC_SHIFT]	= BIT(16),
+	[RTD1319D_ISR_DRTC_MIN_SHIFT]	= BIT(17),
+	[RTD1319D_ISR_DRTC_HOUR_SHIFT]	= BIT(18),
+	[RTD1319D_ISR_DRTC_DATE_SHIFT]	= BIT(19),
+	[RTD1319D_ISR_DRTC_ALARM_SHIFT] = BIT(20),
+	[RTD1319D_ISR_SC0_SHIFT]	= BIT(24),
+	[RTD1319D_ISR_SC1_SHIFT]	= BIT(25),
+	[RTD1319D_ISR_SPI_SHIFT]	= BIT(27),
+	[RTD1319D_ISR_I2C3_SHIFT]	= BIT(28),
+	[RTD1319D_ISR_FAN_SHIFT]	= BIT(29),
+};
+
+static struct realtek_intc_mask rtd1319d_intc_iso_cfgs[] = {
+	{ ISO_NORMAL_MASK, },
+	{ ISO_NMI_WDT_MASK, },
+};
+
+static const struct realtek_intc_info rtd1319d_intc_iso_info = {
+	.isr_offset		 = ISO_ISR_OFFSET,
+	.scpu_int_en_offset	 = ISO_ISR_EN_OFFSET,
+	.isr_to_scpu_int_en_mask = rtd1319d_iso_isr_to_scpu_int_en_mask,
+	.subset_mask		 = rtd1319d_intc_iso_cfgs,
+	.subset_num		 = ARRAY_SIZE(rtd1319d_intc_iso_cfgs),
+};
+
+static struct realtek_intc_mask rtd1319d_intc_misc_cfgs[] = {
+	{ MISC_NORMAL_MASK, },
+	{ MISC_UART1_MASK, },
+	{ MISC_UART2_MASK, },
+};
+
+static const struct realtek_intc_info rtd1319d_intc_misc_info = {
+	.isr_offset		 = MISC_ISR_OFFSET,
+	.scpu_int_en_offset	 = MISC_ISR_EN_OFFSET,
+	.isr_to_scpu_int_en_mask = rtd1319d_misc_isr_to_scpu_int_en_mask,
+	.subset_mask		 = rtd1319d_intc_misc_cfgs,
+	.subset_num		 = ARRAY_SIZE(rtd1319d_intc_misc_cfgs),
+};
+
+static const struct of_device_id realtek_intc_rtd1319d_dt_matches[] = {
+	{
+		.compatible = "realtek,rtd1319d-intc-iso",
+		.data = &rtd1319d_intc_iso_info,
+	}, {
+		.compatible = "realtek,rtd1319d-intc-misc",
+		.data = &rtd1319d_intc_misc_info,
+	},
+	{ /* sentinel */ }
+};
+
+static const struct dev_pm_ops realtek_intc_rtd1319d_pm_ops = {
+	.suspend_noirq = realtek_intc_suspend,
+	.resume_noirq  = realtek_intc_resume,
+};
+
+static int rtd1319d_intc_probe(struct platform_device *pdev)
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
+static struct platform_driver realtek_intc_rtd1319d_driver = {
+	.probe = rtd1319d_intc_probe,
+	.driver = {
+		.name = "realtek_intc_rtd1319d",
+		.of_match_table = realtek_intc_rtd1319d_dt_matches,
+		.suppress_bind_attrs = true,
+		.pm = &realtek_intc_rtd1319d_pm_ops,
+	},
+};
+
+static int __init realtek_intc_rtd1319d_init(void)
+{
+	return platform_driver_register(&realtek_intc_rtd1319d_driver);
+}
+module_init(realtek_intc_rtd1319d_init);
+
+static void __exit realtek_intc_rtd1319d_exit(void)
+{
+	platform_driver_unregister(&realtek_intc_rtd1319d_driver);
+}
+module_exit(realtek_intc_rtd1319d_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Realtek RTD1319D Interrupt Controller Driver");
-- 
2.25.1


