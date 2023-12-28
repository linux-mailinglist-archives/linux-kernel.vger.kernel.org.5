Return-Path: <linux-kernel+bounces-12440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 467DA81F4DE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 07:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9C37283BCD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 06:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFBB63AA;
	Thu, 28 Dec 2023 06:09:18 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33C423B7;
	Thu, 28 Dec 2023 06:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BS694Ow81766933, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BS694Ow81766933
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Dec 2023 14:09:04 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Thu, 28 Dec 2023 14:09:04 +0800
Received: from james-bs01.realtek.com.tw (172.21.190.247) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Dec 2023 14:09:04 +0800
From: James Tai <james.tai@realtek.com>
To: Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>,
        "Rob
 Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, James Tai <james.tai@realtek.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v4 2/6] irqchip: Add interrupt controller support for Realtek DHC SoCs
Date: Thu, 28 Dec 2023 14:08:21 +0800
Message-ID: <20231228060825.1380439-3-james.tai@realtek.com>
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

Realtek DHC (Digital Home Center) SoCs share a common interrupt controller
design. This universal interrupt controller driver provides support for
various variants within the Realtek DHC SoC family.

Each DHC SoC features two sets of extended interrupt controllers, each
capable of handling up to 32 interrupts. These expansion controllers are
connected to the GIC (Generic Interrupt Controller).

Signed-off-by: James Tai <james.tai@realtek.com>
---
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Marc Zyngier <maz@kernel.org>
CC: linux-kernel@vger.kernel.org

v3 to v4 change:
- Adjusted the error path and label
- Added the 'irq_domain_remove' to the error path
- Removed the 'devm_kfree' from the error path
- Replaced the 'irq_of_parse_and_map' with 'of_irq_get'
- Replaced the 'raw_spin_lock' with 'raw_spin_lock_irqsave'
- Adjusted the return value of the 'realtek_intc_subset'
- Replaced the '~1' with macro 'CLEAN_INTC_STATUS'
- Improved code comments and description
- Fixed coding style issues
- Fixed the incorrect control register in mask and unmask functions
- Changed the 'EXPORT_SYMBOL' to the 'EXPORT_SYMBOL_GPL'
- Renamed the 'realtek_intc_subset_cfg' to 'realtek_intc_mask'
- Removed unused and unnecessary code
- Removed 'irq_enable' and 'irq_disable' callback

v2 to v3 change:
- Resolved kernel test robot build warnings
  https://lore.kernel.org/r/202311201929.2FpvMRlg-lkp@intel.com/

v1 to v2 change:
- Fixed code style issues
- Removed the realtek_intc_set_affinity funcation
- Replaced spin_lock_irqsave with raw_spin_lock

 drivers/irqchip/Kconfig                   |   4 +
 drivers/irqchip/Makefile                  |   1 +
 drivers/irqchip/irq-realtek-intc-common.c | 211 ++++++++++++++++++++++
 drivers/irqchip/irq-realtek-intc-common.h |  76 ++++++++
 4 files changed, 292 insertions(+)
 create mode 100644 drivers/irqchip/irq-realtek-intc-common.c
 create mode 100644 drivers/irqchip/irq-realtek-intc-common.h

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index f7149d0f3d45..267c3429b48d 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -218,6 +218,10 @@ config RDA_INTC
 	bool
 	select IRQ_DOMAIN
 
+config REALTEK_DHC_INTC
+	tristate
+	select IRQ_DOMAIN
+
 config RENESAS_INTC_IRQPIN
 	bool "Renesas INTC External IRQ Pin Support" if COMPILE_TEST
 	select IRQ_DOMAIN
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index ffd945fe71aa..f6774af7fde2 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -47,6 +47,7 @@ obj-$(CONFIG_IRQ_MIPS_CPU)		+= irq-mips-cpu.o
 obj-$(CONFIG_IXP4XX_IRQ)		+= irq-ixp4xx.o
 obj-$(CONFIG_JCORE_AIC)			+= irq-jcore-aic.o
 obj-$(CONFIG_RDA_INTC)			+= irq-rda-intc.o
+obj-$(CONFIG_REALTEK_DHC_INTC)		+= irq-realtek-intc-common.o
 obj-$(CONFIG_RENESAS_INTC_IRQPIN)	+= irq-renesas-intc-irqpin.o
 obj-$(CONFIG_RENESAS_IRQC)		+= irq-renesas-irqc.o
 obj-$(CONFIG_RENESAS_RZA1_IRQC)		+= irq-renesas-rza1.o
diff --git a/drivers/irqchip/irq-realtek-intc-common.c b/drivers/irqchip/irq-realtek-intc-common.c
new file mode 100644
index 000000000000..caff61730ff8
--- /dev/null
+++ b/drivers/irqchip/irq-realtek-intc-common.c
@@ -0,0 +1,211 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
+/*
+ * Realtek DHC SoCs interrupt controller driver
+ *
+ * Copyright (c) 2023 Realtek Semiconductor Corporation
+ */
+
+#include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+
+#include "irq-realtek-intc-common.h"
+
+static inline unsigned int realtek_intc_get_ints(struct realtek_intc_data *data)
+{
+	return readl(data->base + data->info->isr_offset);
+}
+
+static inline void realtek_intc_clear_ints_bit(struct realtek_intc_data *data, int bit)
+{
+	writel(BIT(bit) & CLEAN_INTC_STATUS, data->base + data->info->isr_offset);
+}
+
+static inline unsigned int realtek_intc_get_inte(struct realtek_intc_data *data)
+{
+	unsigned int val;
+
+	val = readl(data->base + data->info->scpu_int_en_offset);
+
+	return val;
+}
+
+static void realtek_intc_handler(struct irq_desc *desc)
+{
+	struct realtek_intc_subset_data *subset_data = irq_desc_get_handler_data(desc);
+	struct realtek_intc_data *data = subset_data->common;
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	u32 ints, inte, mask;
+	int irq;
+
+	chained_irq_enter(chip, desc);
+
+	ints = realtek_intc_get_ints(data) & subset_data->subset_mask->ints_mask;
+	inte = realtek_intc_get_inte(data);
+
+	while (ints) {
+		irq = __ffs(ints);
+		ints &= ~BIT(irq);
+
+		mask = data->info->isr_to_scpu_int_en_mask[irq];
+		if (mask != IRQ_ALWAYS_ENABLED && !(inte & mask))
+			continue;
+
+		generic_handle_irq(irq_find_mapping(data->domain, irq));
+		realtek_intc_clear_ints_bit(data, irq);
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+static void realtek_intc_mask_irq(struct irq_data *data)
+{
+	struct realtek_intc_data *intc_data = irq_data_get_irq_chip_data(data);
+	unsigned long lock_flags;
+	u32 scpu_int_en, mask;
+
+	mask = intc_data->info->isr_to_scpu_int_en_mask[data->hwirq];
+	if (!mask)
+		return;
+
+	raw_spin_lock_irqsave(&intc_data->lock, lock_flags);
+	scpu_int_en = readl(intc_data->base + intc_data->info->scpu_int_en_offset);
+	scpu_int_en &= ~mask;
+	writel(scpu_int_en, intc_data->base + intc_data->info->scpu_int_en_offset);
+	raw_spin_unlock_irqrestore(&intc_data->lock, lock_flags);
+}
+
+static void realtek_intc_unmask_irq(struct irq_data *data)
+{
+	struct realtek_intc_data *intc_data = irq_data_get_irq_chip_data(data);
+	unsigned long lock_flags;
+	u32 scpu_int_en, mask;
+
+	mask = intc_data->info->isr_to_scpu_int_en_mask[data->hwirq];
+	if (!mask)
+		return;
+
+	raw_spin_lock_irqsave(&intc_data->lock, lock_flags);
+	scpu_int_en = readl(intc_data->base + intc_data->info->scpu_int_en_offset);
+	scpu_int_en |= mask;
+	writel(scpu_int_en, intc_data->base + intc_data->info->scpu_int_en_offset);
+	raw_spin_unlock_irqrestore(&intc_data->lock, lock_flags);
+}
+
+static struct irq_chip realtek_intc_chip = {
+	.name	     = "realtek-intc",
+	.irq_mask    = realtek_intc_mask_irq,
+	.irq_unmask  = realtek_intc_unmask_irq,
+};
+
+static int realtek_intc_domain_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hw)
+{
+	struct realtek_intc_data *data = d->host_data;
+
+	irq_set_chip_and_handler(irq, &realtek_intc_chip, handle_level_irq);
+	irq_set_chip_data(irq, data);
+	irq_set_probe(irq);
+
+	return 0;
+}
+
+static const struct irq_domain_ops realtek_intc_domain_ops = {
+	.xlate = irq_domain_xlate_onecell,
+	.map   = realtek_intc_domain_map,
+};
+
+static int realtek_intc_subset(struct device_node *node, struct realtek_intc_data *data, int index)
+{
+	struct realtek_intc_subset_data *subset_data = &data->subset_data[index];
+	const struct realtek_intc_mask *mask = &data->info->subset_mask[index];
+	int irq;
+
+	irq = of_irq_get(node, index);
+	if (irq <= 0)
+		return -EINVAL;
+
+	subset_data->common = data;
+	subset_data->subset_mask = mask;
+	subset_data->parent_irq = irq;
+	irq_set_chained_handler_and_data(irq, realtek_intc_handler, subset_data);
+
+	return irq;
+}
+
+int realtek_intc_suspend(struct device *dev)
+{
+	struct realtek_intc_data *data = dev_get_drvdata(dev);
+	const struct realtek_intc_info *info = data->info;
+
+	data->saved_en = readl(data->base + info->scpu_int_en_offset);
+
+	writel(DISABLE_INTC, data->base + info->scpu_int_en_offset);
+	writel(CLEAN_INTC_STATUS, data->base + info->isr_offset);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(realtek_intc_suspend);
+
+int realtek_intc_resume(struct device *dev)
+{
+	struct realtek_intc_data *data = dev_get_drvdata(dev);
+	const struct realtek_intc_info *info = data->info;
+
+	writel(CLEAN_INTC_STATUS, data->base + info->isr_offset);
+	writel(data->saved_en, data->base + info->scpu_int_en_offset);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(realtek_intc_resume);
+
+int realtek_intc_probe(struct platform_device *pdev, const struct realtek_intc_info *info)
+{
+	struct realtek_intc_data *data;
+	struct device *dev = &pdev->dev;
+	struct device_node *node = dev->of_node;
+	int ret, i;
+
+	data = devm_kzalloc(dev, struct_size(data, subset_data, info->subset_num), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->base = of_iomap(node, 0);
+	if (!data->base)
+		goto iomap_cleanup;
+
+	data->info = info;
+
+	raw_spin_lock_init(&data->lock);
+
+	data->domain = irq_domain_add_linear(node, 32, &realtek_intc_domain_ops, data);
+	if (!data->domain)
+		goto iomap_cleanup;
+
+	data->subset_data_num = info->subset_num;
+	for (i = 0; i < info->subset_num; i++) {
+		ret = realtek_intc_subset(node, data, i);
+		if (ret <= 0) {
+			dev_err(dev, "failed to init subset %d: %d", i, ret);
+			goto irq_domain_cleanup;
+		}
+	}
+
+	platform_set_drvdata(pdev, data);
+
+	return 0;
+
+irq_domain_cleanup:
+	if (data->domain)
+		irq_domain_remove(data->domain);
+
+iomap_cleanup:
+	if (data->base)
+		iounmap(data->base);
+
+	return -ENOMEM;
+}
+EXPORT_SYMBOL_GPL(realtek_intc_probe);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Realtek DHC SoC Interrupt Controller Driver");
diff --git a/drivers/irqchip/irq-realtek-intc-common.h b/drivers/irqchip/irq-realtek-intc-common.h
new file mode 100644
index 000000000000..0af989c09693
--- /dev/null
+++ b/drivers/irqchip/irq-realtek-intc-common.h
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2023 Realtek Semiconductor Corporation
+ */
+
+#ifndef _IRQ_REALTEK_COMMON_H
+#define _IRQ_REALTEK_COMMON_H
+
+#include <linux/bits.h>
+#include <linux/limits.h>
+#include <linux/hwspinlock.h>
+
+/**
+ * realtek_intc_mask - The mask of an interrupt subset.
+ * @ints_mask: The interrupt mask.
+ */
+struct realtek_intc_mask {
+	u32	ints_mask;
+};
+
+/**
+ * realtek_intc_info - Information about the interrupt controller.
+ * @subset_mask:	The masks of the interrupt subsets.
+ * @subset_num:		The number of interrupt subsets.
+ * @isr_offset:		The offset of the interrupt status register.
+ * @scpu_int_en_offset:	The offset of the interrupt enable register.
+ */
+struct realtek_intc_info {
+	const struct realtek_intc_mask	*subset_mask;
+	int				subset_num;
+	unsigned int			isr_offset;
+	unsigned int			scpu_int_en_offset;
+	const u32			*isr_to_scpu_int_en_mask;
+};
+
+/**
+ * realtek_intc_subset_data - The data of interrupt subset.
+ * @subset_mask:	The subset interrupt masks.
+ * @common:		The configuration data of interrupt controller.
+ * @parent_irq:		The subset interrupt source.
+ */
+struct realtek_intc_subset_data {
+	const struct realtek_intc_mask	*subset_mask;
+	struct realtek_intc_data	*common;
+	int				parent_irq;
+};
+
+/**
+ * realtek_intc_data - The configuration data for interrupt controller driver.
+ * @base:		The base address of interrupt register.
+ * @info:		The Information of the interrupt controller.
+ * @domain:		Interrupt domain of the interrupt controller.
+ * @lock:		The lock of the interrupt controller.
+ * @saved_en:		Stores the state of the interrupt enable.
+ * @subset_data_num:	The number of entries in the interrupt subset data.
+ * @subset_data:	The data for the interrupt subset.
+ */
+struct realtek_intc_data {
+	void __iomem			*base;
+	const struct realtek_intc_info	*info;
+	struct irq_domain		*domain;
+	struct raw_spinlock		lock;
+	unsigned int			saved_en;
+	int				subset_data_num;
+	struct realtek_intc_subset_data subset_data[];
+};
+
+#define IRQ_ALWAYS_ENABLED	U32_MAX
+#define DISABLE_INTC		(0)
+#define CLEAN_INTC_STATUS	GENMASK(31, 1)
+
+int realtek_intc_probe(struct platform_device *pdev, const struct realtek_intc_info *info);
+int realtek_intc_suspend(struct device *dev);
+int realtek_intc_resume(struct device *dev);
+
+#endif /* _IRQ_REALTEK_COMMON_H */
-- 
2.25.1


