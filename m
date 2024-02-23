Return-Path: <linux-kernel+bounces-78122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2670860F31
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B51A1F236EF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B765CDEC;
	Fri, 23 Feb 2024 10:26:30 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8177C5C8FC;
	Fri, 23 Feb 2024 10:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708683989; cv=none; b=AOoI++Mk7yptQkxy/Q53gFfC6YWJLWyc9yXuRnkw/DRuW6huvCeUQ+1w7kjRIKhdHPMkZtI0jC03zQpc/mRrFuo/tBDretcJ36nR4+Wd28GBQuy/pq8w+jxIgFYsUjVvqDtlY34EvWSHUzLuZt0bKtHuVzpKbyq6sGy4dkKwBtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708683989; c=relaxed/simple;
	bh=GcNInCiESGd72nZWGLINRCaFpUgFKoPJj/wLQk+2P/o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ktBNQBHcJ11ajrKQua2ruB6Hzki9to4HTea4AxxguP4igG1cbrdBvz8DiDSZc8Ltw4N9sD7PQjadZRvnV82UTvRmwUy1kDiGUdsXQdS9MhSW7q4u2umMOI178frM08mRrOkuwhzMGdBXvGjsZWa50nDcmFzolimoFlecXWDYUWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.10.34])
	by gateway (Coremail) with SMTP id _____8CxifDKcthlt6MQAA--.43357S3;
	Fri, 23 Feb 2024 18:26:18 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.10.34])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxRMzHcthlsrE_AA--.26840S2;
	Fri, 23 Feb 2024 18:26:17 +0800 (CST)
From: Tianyang Zhang <zhangtianyang@loongson.cn>
To: chenhuacai@kernel.org,
	jiaxun.yang@flygoat.com,
	tglx@linutronix.de
Cc: linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Baoqi Zhang <zhangbaoqi@loongson.cn>,
	Zhang Tianyang <zhangtianyang@loongson.cn>,
	Biao Dong <dongbiao@loongson.cn>
Subject: [PATCH] irqchip/loongson-pch-pic: Update interrupt registration policy
Date: Fri, 23 Feb 2024 18:26:12 +0800
Message-Id: <20240223102612.1499-1-zhangtianyang@loongson.cn>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxRMzHcthlsrE_AA--.26840S2
X-CM-SenderInfo: x2kd0wxwld05hdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW3JrWkKr4ftF13KFWfWrWkKrX_yoWxXF1UpF
	W5ArZxuF4UJr1UX3y8C3WUZryfZF9Ivay0gaySy3saqwnIvrykG3Wxur9rAa18JFZ5ZFZx
	Zws8CFyF9a17AagCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1WlkUUUUU=

From: Baoqi Zhang <zhangbaoqi@loongson.cn>

We have removed the fixed mapping between the 7A interrupt source
and the HT interrupt vector, and replaced it with a dynamically
allocated approach. This will be more conducive to fully utilizing
existing vectors to support more devices

Signed-off-by: Baoqi Zhang <zhangbaoqi@loongson.cn>
Signed-off-by: Zhang Tianyang <zhangtianyang@loongson.cn>
Signed-off-by: Biao Dong <dongbiao@loongson.cn>
---
 drivers/irqchip/irq-loongson-pch-pic.c | 64 +++++++++++++++++++-------
 1 file changed, 47 insertions(+), 17 deletions(-)

diff --git a/drivers/irqchip/irq-loongson-pch-pic.c b/drivers/irqchip/irq-loongson-pch-pic.c
index 63db8e2172e0..86549356e76e 100644
--- a/drivers/irqchip/irq-loongson-pch-pic.c
+++ b/drivers/irqchip/irq-loongson-pch-pic.c
@@ -34,6 +34,8 @@
 #define PIC_REG_IDX(irq_id)	((irq_id) / PIC_COUNT_PER_REG)
 #define PIC_REG_BIT(irq_id)	((irq_id) % PIC_COUNT_PER_REG)
 
+#define hwirq_to_bit(priv, hirq)	(((priv)->table)[(hirq)])
+
 static int nr_pics;
 
 struct pch_pic {
@@ -46,6 +48,8 @@ struct pch_pic {
 	u32			saved_vec_en[PIC_REG_COUNT];
 	u32			saved_vec_pol[PIC_REG_COUNT];
 	u32			saved_vec_edge[PIC_REG_COUNT];
+	u8			table[PIC_COUNT];
+	int			inuse;
 };
 
 static struct pch_pic *pch_pic_priv[MAX_IO_PICS];
@@ -80,45 +84,47 @@ static void pch_pic_mask_irq(struct irq_data *d)
 {
 	struct pch_pic *priv = irq_data_get_irq_chip_data(d);
 
-	pch_pic_bitset(priv, PCH_PIC_MASK, d->hwirq);
+	pch_pic_bitset(priv, PCH_PIC_MASK, hwirq_to_bit(priv, d->hwirq));
 	irq_chip_mask_parent(d);
 }
 
 static void pch_pic_unmask_irq(struct irq_data *d)
 {
+	int bit = hwirq_to_bit(priv, d->hwirq);
 	struct pch_pic *priv = irq_data_get_irq_chip_data(d);
 
-	writel(BIT(PIC_REG_BIT(d->hwirq)),
-			priv->base + PCH_PIC_CLR + PIC_REG_IDX(d->hwirq) * 4);
+	writel(BIT(PIC_REG_BIT(bit)),
+			priv->base + PCH_PIC_CLR + PIC_REG_IDX(bit) * 4);
 
 	irq_chip_unmask_parent(d);
-	pch_pic_bitclr(priv, PCH_PIC_MASK, d->hwirq);
+	pch_pic_bitclr(priv, PCH_PIC_MASK, bit);
 }
 
 static int pch_pic_set_type(struct irq_data *d, unsigned int type)
 {
+	int bit = hwirq_to_bit(priv, d->hwirq);
 	struct pch_pic *priv = irq_data_get_irq_chip_data(d);
 	int ret = 0;
 
 	switch (type) {
 	case IRQ_TYPE_EDGE_RISING:
-		pch_pic_bitset(priv, PCH_PIC_EDGE, d->hwirq);
-		pch_pic_bitclr(priv, PCH_PIC_POL, d->hwirq);
+		pch_pic_bitset(priv, PCH_PIC_EDGE, bit);
+		pch_pic_bitclr(priv, PCH_PIC_POL, bit);
 		irq_set_handler_locked(d, handle_edge_irq);
 		break;
 	case IRQ_TYPE_EDGE_FALLING:
-		pch_pic_bitset(priv, PCH_PIC_EDGE, d->hwirq);
-		pch_pic_bitset(priv, PCH_PIC_POL, d->hwirq);
+		pch_pic_bitset(priv, PCH_PIC_EDGE, bit);
+		pch_pic_bitset(priv, PCH_PIC_POL, bit);
 		irq_set_handler_locked(d, handle_edge_irq);
 		break;
 	case IRQ_TYPE_LEVEL_HIGH:
-		pch_pic_bitclr(priv, PCH_PIC_EDGE, d->hwirq);
-		pch_pic_bitclr(priv, PCH_PIC_POL, d->hwirq);
+		pch_pic_bitclr(priv, PCH_PIC_EDGE, bit);
+		pch_pic_bitclr(priv, PCH_PIC_POL, bit);
 		irq_set_handler_locked(d, handle_level_irq);
 		break;
 	case IRQ_TYPE_LEVEL_LOW:
-		pch_pic_bitclr(priv, PCH_PIC_EDGE, d->hwirq);
-		pch_pic_bitset(priv, PCH_PIC_POL, d->hwirq);
+		pch_pic_bitclr(priv, PCH_PIC_EDGE, bit);
+		pch_pic_bitset(priv, PCH_PIC_POL, bit);
 		irq_set_handler_locked(d, handle_level_irq);
 		break;
 	default:
@@ -132,12 +138,13 @@ static int pch_pic_set_type(struct irq_data *d, unsigned int type)
 static void pch_pic_ack_irq(struct irq_data *d)
 {
 	unsigned int reg;
+	int bit = hwirq_to_bit(priv, d->hwirq);
 	struct pch_pic *priv = irq_data_get_irq_chip_data(d);
 
-	reg = readl(priv->base + PCH_PIC_EDGE + PIC_REG_IDX(d->hwirq) * 4);
-	if (reg & BIT(PIC_REG_BIT(d->hwirq))) {
-		writel(BIT(PIC_REG_BIT(d->hwirq)),
-			priv->base + PCH_PIC_CLR + PIC_REG_IDX(d->hwirq) * 4);
+	reg = readl(priv->base + PCH_PIC_EDGE + PIC_REG_IDX(bit) * 4);
+	if (reg & BIT(PIC_REG_BIT(bit))) {
+		writel(BIT(PIC_REG_BIT(bit)),
+			priv->base + PCH_PIC_CLR + PIC_REG_IDX(bit) * 4);
 	}
 	irq_chip_ack_parent(d);
 }
@@ -157,6 +164,7 @@ static int pch_pic_domain_translate(struct irq_domain *d,
 					unsigned long *hwirq,
 					unsigned int *type)
 {
+	int i;
 	struct pch_pic *priv = d->host_data;
 	struct device_node *of_node = to_of_node(fwspec->fwnode);
 
@@ -171,6 +179,20 @@ static int pch_pic_domain_translate(struct irq_domain *d,
 			return -EINVAL;
 
 		*hwirq = fwspec->param[0] - priv->gsi_base;
+
+		raw_spin_lock(&priv->pic_lock);
+		for (i = 0; i < priv->inuse; i++) {
+			if (priv->table[i] == *hwirq) {
+				*hwirq = i;
+				break;
+			}
+		}
+		if (i == priv->inuse && priv->inuse < PIC_COUNT) {
+			priv->table[priv->inuse] = *hwirq;
+			*hwirq = priv->inuse++;
+		}
+		raw_spin_unlock(&priv->pic_lock);
+
 		if (fwspec->param_count > 1)
 			*type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
 		else
@@ -194,6 +216,9 @@ static int pch_pic_alloc(struct irq_domain *domain, unsigned int virq,
 	if (err)
 		return err;
 
+	/* Write vector ID */
+	writeb(priv->ht_vec_base + hwirq, priv->base + PCH_INT_HTVEC(hwirq_to_bit(priv, hwirq)));
+
 	parent_fwspec.fwnode = domain->parent->fwnode;
 	parent_fwspec.param_count = 1;
 	parent_fwspec.param[0] = hwirq + priv->ht_vec_base;
@@ -222,7 +247,7 @@ static void pch_pic_reset(struct pch_pic *priv)
 
 	for (i = 0; i < PIC_COUNT; i++) {
 		/* Write vector ID */
-		writeb(priv->ht_vec_base + i, priv->base + PCH_INT_HTVEC(i));
+		writeb(priv->ht_vec_base + i, priv->base + PCH_INT_HTVEC(hwirq_to_bit(priv, i)));
 		/* Hardcode route to HT0 Lo */
 		writeb(1, priv->base + PCH_INT_ROUTE(i));
 	}
@@ -283,6 +308,7 @@ static int pch_pic_init(phys_addr_t addr, unsigned long size, int vec_base,
 			struct irq_domain *parent_domain, struct fwnode_handle *domain_handle,
 			u32 gsi_base)
 {
+	int i;
 	struct pch_pic *priv;
 
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
@@ -294,6 +320,10 @@ static int pch_pic_init(phys_addr_t addr, unsigned long size, int vec_base,
 	if (!priv->base)
 		goto free_priv;
 
+	priv->inuse = 0;
+	for (i = 0; i < PIC_COUNT; i++)
+		priv->table[i] = -1;
+
 	priv->ht_vec_base = vec_base;
 	priv->vec_count = ((readq(priv->base) >> 48) & 0xff) + 1;
 	priv->gsi_base = gsi_base;
-- 
2.20.1


