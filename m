Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A110F79D160
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 14:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235285AbjILMuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 08:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbjILMt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 08:49:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A2510D7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 05:49:54 -0700 (PDT)
Date:   Tue, 12 Sep 2023 12:49:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694522993;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ghSylTAjDTfYpuicOmkRLAyqu3UlP7E8gE4e1blAsfM=;
        b=afXR8d06ECgesYSB990BBdnizZoRI6cjfyKKToFrziZCiOXoLOq5LhZ4E3ZeQkwYjWfgbL
        WFm+/CS7ayNhUlQDiaerY0CFPJ0zPYIGOUjTge1sIfWqN5garfW5cqxUR8kO8yq8XG2Xyf
        9aK9ROgryLluOL/swPc5pBjmmPh2Nxw78TzTTliypM8st71f1HI1BS6TLwu3gwD+jkIqm/
        aFht0aleerQg0sVGjDG4o3Ed4aId1vQ0RhQTnZVfzpMPqdp+EdSjMcAlCLYr6XZAfrxyZ+
        d2u/nWaA78cuigGzAaA0rSJUrrENbv5MEbYoZ9cf6qK7FPjSYTFtPRhO3Ydq9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694522993;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ghSylTAjDTfYpuicOmkRLAyqu3UlP7E8gE4e1blAsfM=;
        b=oOknAry+X/qq0vhni2f7xD3y0qfExBx9FexOamUgEilyZj/+tEfcRyTUhwVQyabR1nLiBb
        AAdCAYoCP5mCl4Ag==
From:   "irqchip-bot for Neil Armstrong" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] irqchip/qcom-pdc: Add support for v3.2 HW
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20230905-topic-sm8x50-upstream-pdc-ver-v4-1-fc633c7df84b@linaro.org>
References: <20230905-topic-sm8x50-upstream-pdc-ver-v4-1-fc633c7df84b@linaro.org>
MIME-Version: 1.0
Message-ID: <169452299250.27769.12946603076037629467.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-fixes branch of irqchip:

Commit-ID:     5873d380f4c0ff23ec7d0d1780107e46a4637c0e
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/5873d380f4c0ff23ec7d0d1780107e46a4637c0e
Author:        Neil Armstrong <neil.armstrong@linaro.org>
AuthorDate:    Tue, 05 Sep 2023 15:19:25 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 12 Sep 2023 13:38:08 +01:00

irqchip/qcom-pdc: Add support for v3.2 HW

Starting from HW version 3.2 the IRQ_ENABLE bit has moved to the
IRQ_i_CFG register and requires a change of the driver to avoid
writing into an undefined register address.

Get the HW version from registers and set the IRQ_ENABLE bit to the
correct register depending on the HW version.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Maulik Shah <quic_mkshah@quicinc.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230905-topic-sm8x50-upstream-pdc-ver-v4-1-fc633c7df84b@linaro.org
---
 drivers/irqchip/qcom-pdc.c | 69 +++++++++++++++++++++++++++----------
 1 file changed, 51 insertions(+), 18 deletions(-)

diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
index a32c0d2..74b2f12 100644
--- a/drivers/irqchip/qcom-pdc.c
+++ b/drivers/irqchip/qcom-pdc.c
@@ -22,9 +22,20 @@
 
 #define PDC_MAX_GPIO_IRQS	256
 
+/* Valid only on HW version < 3.2 */
 #define IRQ_ENABLE_BANK		0x10
 #define IRQ_i_CFG		0x110
 
+/* Valid only on HW version >= 3.2 */
+#define IRQ_i_CFG_IRQ_ENABLE	3
+
+#define IRQ_i_CFG_TYPE_MASK	GENMASK(2, 0)
+
+#define PDC_VERSION_REG		0x1000
+
+/* Notable PDC versions */
+#define PDC_VERSION_3_2		0x30200
+
 struct pdc_pin_region {
 	u32 pin_base;
 	u32 parent_base;
@@ -37,6 +48,7 @@ static DEFINE_RAW_SPINLOCK(pdc_lock);
 static void __iomem *pdc_base;
 static struct pdc_pin_region *pdc_region;
 static int pdc_region_cnt;
+static unsigned int pdc_version;
 
 static void pdc_reg_write(int reg, u32 i, u32 val)
 {
@@ -48,20 +60,32 @@ static u32 pdc_reg_read(int reg, u32 i)
 	return readl_relaxed(pdc_base + reg + i * sizeof(u32));
 }
 
-static void pdc_enable_intr(struct irq_data *d, bool on)
+static void __pdc_enable_intr(int pin_out, bool on)
 {
-	int pin_out = d->hwirq;
 	unsigned long enable;
-	unsigned long flags;
-	u32 index, mask;
 
-	index = pin_out / 32;
-	mask = pin_out % 32;
+	if (pdc_version < PDC_VERSION_3_2) {
+		u32 index, mask;
+
+		index = pin_out / 32;
+		mask = pin_out % 32;
+
+		enable = pdc_reg_read(IRQ_ENABLE_BANK, index);
+		__assign_bit(mask, &enable, on);
+		pdc_reg_write(IRQ_ENABLE_BANK, index, enable);
+	} else {
+		enable = pdc_reg_read(IRQ_i_CFG, pin_out);
+		__assign_bit(IRQ_i_CFG_IRQ_ENABLE, &enable, on);
+		pdc_reg_write(IRQ_i_CFG, pin_out, enable);
+	}
+}
+
+static void pdc_enable_intr(struct irq_data *d, bool on)
+{
+	unsigned long flags;
 
 	raw_spin_lock_irqsave(&pdc_lock, flags);
-	enable = pdc_reg_read(IRQ_ENABLE_BANK, index);
-	__assign_bit(mask, &enable, on);
-	pdc_reg_write(IRQ_ENABLE_BANK, index, enable);
+	__pdc_enable_intr(d->hwirq, on);
 	raw_spin_unlock_irqrestore(&pdc_lock, flags);
 }
 
@@ -142,6 +166,7 @@ static int qcom_pdc_gic_set_type(struct irq_data *d, unsigned int type)
 	}
 
 	old_pdc_type = pdc_reg_read(IRQ_i_CFG, d->hwirq);
+	pdc_type |= (old_pdc_type & ~IRQ_i_CFG_TYPE_MASK);
 	pdc_reg_write(IRQ_i_CFG, d->hwirq, pdc_type);
 
 	ret = irq_chip_set_type_parent(d, type);
@@ -246,7 +271,6 @@ static const struct irq_domain_ops qcom_pdc_ops = {
 static int pdc_setup_pin_mapping(struct device_node *np)
 {
 	int ret, n, i;
-	u32 irq_index, reg_index, val;
 
 	n = of_property_count_elems_of_size(np, "qcom,pdc-ranges", sizeof(u32));
 	if (n <= 0 || n % 3)
@@ -276,29 +300,38 @@ static int pdc_setup_pin_mapping(struct device_node *np)
 		if (ret)
 			return ret;
 
-		for (i = 0; i < pdc_region[n].cnt; i++) {
-			reg_index = (i + pdc_region[n].pin_base) >> 5;
-			irq_index = (i + pdc_region[n].pin_base) & 0x1f;
-			val = pdc_reg_read(IRQ_ENABLE_BANK, reg_index);
-			val &= ~BIT(irq_index);
-			pdc_reg_write(IRQ_ENABLE_BANK, reg_index, val);
-		}
+		for (i = 0; i < pdc_region[n].cnt; i++)
+			__pdc_enable_intr(i + pdc_region[n].pin_base, 0);
 	}
 
 	return 0;
 }
 
+#define QCOM_PDC_SIZE 0x30000
+
 static int qcom_pdc_init(struct device_node *node, struct device_node *parent)
 {
 	struct irq_domain *parent_domain, *pdc_domain;
+	resource_size_t res_size;
+	struct resource res;
 	int ret;
 
-	pdc_base = of_iomap(node, 0);
+	/* compat with old sm8150 DT which had very small region for PDC */
+	if (of_address_to_resource(node, 0, &res))
+		return -EINVAL;
+
+	res_size = max_t(resource_size_t, resource_size(&res), QCOM_PDC_SIZE);
+	if (res_size > resource_size(&res))
+		pr_warn("%pOF: invalid reg size, please fix DT\n", node);
+
+	pdc_base = ioremap(res.start, res_size);
 	if (!pdc_base) {
 		pr_err("%pOF: unable to map PDC registers\n", node);
 		return -ENXIO;
 	}
 
+	pdc_version = pdc_reg_read(PDC_VERSION_REG, 0);
+
 	parent_domain = irq_find_host(parent);
 	if (!parent_domain) {
 		pr_err("%pOF: unable to find PDC's parent domain\n", node);
