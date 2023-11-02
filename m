Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD107DF4FE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 15:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbjKBO3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 10:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjKBO2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 10:28:48 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1277B12E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 07:28:44 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3A2ERWvdC3062443, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3A2ERWvdC3062443
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Nov 2023 22:27:32 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 2 Nov 2023 22:27:33 +0800
Received: from james-bs01.realtek.com.tw (172.21.190.247) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 2 Nov 2023 22:27:32 +0800
From:   James Tai <james.tai@realtek.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-realtek-soc@lists.infradead.org>
CC:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Subject: [PATCH 2/6] irqchip: Add interrupt controller support for Realtek DHC SoCs
Date:   Thu, 2 Nov 2023 22:27:27 +0800
Message-ID: <20231102142731.2087245-3-james.tai@realtek.com>
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

Realtek DHC (Digital Home Center) SoCs share a common interrupt controller design.
This universal interrupt controller driver provides support for various variants
within the Realtek DHC SoC family.

Each DHC SoC features two sets of extended interrupt controllers, each capable of
handling up to 32 interrupts. These expansion controllers are connected to the GIC
(Generic Interrupt Controller).

Signed-off-by: James Tai <james.tai@realtek.com>
Change-Id: I1e711c70414c97c2c8497bd4ac9e8bbd964225c3
---
 drivers/irqchip/Kconfig                   |   4 +
 drivers/irqchip/Makefile                  |   1 +
 drivers/irqchip/irq-realtek-intc-common.c | 232 ++++++++++++++++++++++
 drivers/irqchip/irq-realtek-intc-common.h |  75 +++++++
 4 files changed, 312 insertions(+)
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
index 000000000000..2bd174f2bc2c
--- /dev/null
+++ b/drivers/irqchip/irq-realtek-intc-common.c
@@ -0,0 +1,232 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
+/*
+ * Realtek DHC SoCs interrupt controller driver
+ *
+ * Copyright (c) 2023 Realtek Semiconductor Corporation
+ */
+
+#include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+
+#include "irq-realtek-intc-common.h"
+
+struct realtek_intc_data;
+
+static unsigned int realtek_intc_get_ints(struct realtek_intc_data *data)
+{
+	return readl(data->base + data->info->isr_offset);
+}
+
+static void realtek_intc_clear_ints_bit(struct realtek_intc_data *data, int bit)
+{
+	writel(BIT(bit) & ~1, data->base + data->info->isr_offset);
+}
+
+static unsigned int realtek_intc_get_inte(struct realtek_intc_data *data)
+{
+	unsigned int val;
+	unsigned long flags;
+
+	spin_lock_irqsave(&data->lock, flags);
+	val = readl(data->base + data->info->scpu_int_en_offset);
+	spin_unlock_irqrestore(&data->lock, flags);
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
+	ints = realtek_intc_get_ints(data) & subset_data->cfg->ints_mask;
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
+
+	writel(BIT(data->hwirq), intc_data->base + intc_data->info->isr_offset);
+}
+
+static void realtek_intc_unmask_irq(struct irq_data *data)
+{
+	struct realtek_intc_data *intc_data = irq_data_get_irq_chip_data(data);
+
+	writel(BIT(data->hwirq), intc_data->base + intc_data->info->umsk_isr_offset);
+}
+
+static void realtek_intc_enable_irq(struct irq_data *data)
+{
+	struct realtek_intc_data *intc_data = irq_data_get_irq_chip_data(data);
+	unsigned long flags;
+	u32 scpu_int_en, mask;
+
+	mask = intc_data->info->isr_to_scpu_int_en_mask[data->hwirq];
+	if (!mask)
+		return;
+
+	spin_lock_irqsave(&intc_data->lock, flags);
+
+	scpu_int_en = readl(intc_data->base + intc_data->info->scpu_int_en_offset);
+	scpu_int_en |= mask;
+	writel(scpu_int_en, intc_data->base + intc_data->info->umsk_isr_offset);
+
+	spin_unlock_irqrestore(&intc_data->lock, flags);
+}
+
+static void realtek_intc_disable_irq(struct irq_data *data)
+{
+	struct realtek_intc_data *intc_data = irq_data_get_irq_chip_data(data);
+	unsigned long flags;
+	u32 scpu_int_en, mask;
+
+	mask = intc_data->info->isr_to_scpu_int_en_mask[data->hwirq];
+	if (!mask)
+		return;
+
+	spin_lock_irqsave(&intc_data->lock, flags);
+
+	scpu_int_en = readl(intc_data->base + intc_data->info->scpu_int_en_offset);
+	scpu_int_en &= ~mask;
+	writel(scpu_int_en, intc_data->base + intc_data->info->umsk_isr_offset);
+
+	spin_unlock_irqrestore(&intc_data->lock, flags);
+}
+
+static int realtek_intc_lookup_parent_irq(struct realtek_intc_data *intc_data, struct irq_data *d)
+{
+	unsigned int mask = BIT(d->hwirq);
+	int i;
+
+	for (i = 0; i < intc_data->subset_data_num; i++)
+		if (intc_data->subset_data[i].cfg->ints_mask & mask)
+			return intc_data->subset_data[i].parent_irq;
+
+	return -EINVAL;
+}
+
+static int realtek_intc_set_affinity(struct irq_data *d, const struct cpumask *mask_val, bool force)
+{
+	struct realtek_intc_data *intc_data = irq_data_get_irq_chip_data(d);
+	int irq;
+	struct irq_chip *chip;
+	struct irq_data *data;
+
+	irq = realtek_intc_lookup_parent_irq(intc_data, d);
+	if (irq < 0)
+		return irq;
+
+	chip = irq_get_chip(irq);
+	data = irq_get_irq_data(irq);
+
+	irq_data_update_effective_affinity(d, cpu_online_mask);
+	if (chip && chip->irq_set_affinity)
+		return chip->irq_set_affinity(data, mask_val, force);
+	else
+		return -EINVAL;
+}
+
+static struct irq_chip realtek_intc_chip = {
+	.name = "realtek-intc",
+	.irq_mask = realtek_intc_mask_irq,
+	.irq_unmask = realtek_intc_unmask_irq,
+	.irq_enable = realtek_intc_enable_irq,
+	.irq_disable = realtek_intc_disable_irq,
+	.irq_set_affinity = realtek_intc_set_affinity,
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
+	.map = realtek_intc_domain_map,
+};
+
+static int realtek_intc_subset(struct device_node *node, struct realtek_intc_data *data, int index)
+{
+	int irq;
+	struct realtek_intc_subset_data *subset_data = &data->subset_data[index];
+	const struct realtek_intc_subset_cfg *cfg = &data->info->cfg[index];
+
+	irq = irq_of_parse_and_map(node, index);
+	if (irq <= 0)
+		return irq;
+
+	subset_data->common = data;
+	subset_data->cfg = cfg;
+	subset_data->parent_irq = irq;
+	irq_set_chained_handler_and_data(irq, realtek_intc_handler, subset_data);
+
+	return 0;
+}
+
+int realtek_intc_probe(struct platform_device *pdev, const struct realtek_intc_info *info)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *node = dev->of_node;
+	struct realtek_intc_data *data;
+	int ret, i;
+
+	data = devm_kzalloc(dev, struct_size(data, subset_data, info->cfg_num), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->base = of_iomap(node, 0);
+	if (!data->base)
+		return -ENOMEM;
+
+	data->info = info;
+
+	spin_lock_init(&data->lock);
+
+	data->domain = irq_domain_add_linear(node, 32, &realtek_intc_domain_ops, data);
+	if (!data->domain)
+		return -ENOMEM;
+
+	data->subset_data_num = info->cfg_num;
+	for (i = 0; i < info->cfg_num; i++) {
+		ret = realtek_intc_subset(node, data, i);
+		WARN(ret, "failed to init subset %d: %d", i, ret);
+	}
+
+	platform_set_drvdata(pdev, data);
+
+	return 0;
+}
+EXPORT_SYMBOL(realtek_intc_probe);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Realtek DHC SoC Interrupt Controller Driver");
diff --git a/drivers/irqchip/irq-realtek-intc-common.h b/drivers/irqchip/irq-realtek-intc-common.h
new file mode 100644
index 000000000000..8b1954a05b41
--- /dev/null
+++ b/drivers/irqchip/irq-realtek-intc-common.h
@@ -0,0 +1,75 @@
+/* SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2023 Realtek Semiconductor Corporation
+ */
+
+#ifndef _IRQ_REALTEK_COMMON_H
+#define _IRQ_REALTEK_COMMON_H
+
+#include <linux/spinlock_types.h>
+
+/**
+ * realtek_intc_subset_cfg - subset interrupt mask
+ * @ints_mask: inetrrupt mask
+ */
+struct realtek_intc_subset_cfg {
+	unsigned int ints_mask;
+};
+
+/**
+ * realtek_intc_info - interrupt controller data.
+ * @isr_offset: interrupt status register offset.
+ * @umsk_isr_offset: unmask interrupt status register offset.
+ * @scpu_int_en_offset: interrupt enable register offset.
+ * @cfg: cfg of the subset.
+ * @cfg_num: number of cfg.
+ */
+struct realtek_intc_info {
+	unsigned int isr_offset;
+	unsigned int umsk_isr_offset;
+	unsigned int scpu_int_en_offset;
+	const u32 *isr_to_scpu_int_en_mask;
+	const struct realtek_intc_subset_cfg *cfg;
+	int cfg_num;
+};
+
+/**
+ * realtek_intc_subset_data - handler of a interrupt source only handles ints
+ *                            bits in the mask.
+ * @cfg: cfg of the subset.
+ * @common: common data.
+ * @parent_irq: interrupt source.
+ */
+struct realtek_intc_subset_data {
+	const struct realtek_intc_subset_cfg *cfg;
+	struct realtek_intc_data *common;
+	int parent_irq;
+};
+
+/**
+ * realtek_intc_data - configuration data for realtek interrupt controller driver.
+ * @base: base of interrupt register
+ * @info: info of intc
+ * @domain: interrupt domain
+ * @lock: lock
+ * @saved_en: status of interrupt enable
+ * @subset_data_num: number of subset data
+ * @subset_data: subset data
+ */
+struct realtek_intc_data {
+	void __iomem *base;
+	const struct realtek_intc_info *info;
+	struct irq_domain *domain;
+	spinlock_t lock;
+	unsigned int saved_en;
+	int subset_data_num;
+	struct realtek_intc_subset_data subset_data[];
+};
+
+#define IRQ_ALWAYS_ENABLED  (-1)
+#define DISABLE_INTC (0)
+#define CLEAN_INTC_STATUS (0xfffffffe)
+
+int realtek_intc_probe(struct platform_device *pdev, const struct realtek_intc_info *info);
+
+#endif /* _IRQ_REALTEK_COMMON_H */
-- 
2.25.1

