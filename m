Return-Path: <linux-kernel+bounces-42976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5B3840988
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B34C11C217C9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D31154BF0;
	Mon, 29 Jan 2024 15:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASuTGVHH"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D57153BCC;
	Mon, 29 Jan 2024 15:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706541394; cv=none; b=jqwbsb6DAiC0xc6Rts6pGgLqfIAGgyWlH/6C7R7anUL6kq0ZoO6yUzwOOs7w/qk5t2wTr8rvhHFbX4PI3+1cL2viQW+2vjrRv9MIHWXj9F0q0q13M7+jiJ/4qgMRdkaahL0xIcLbMw7bnesV9TjRy1tBBzNxKS/ar04NY4LukGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706541394; c=relaxed/simple;
	bh=WiALgpuCiyP5eUEkEXcIzk6A5RCLciU9y4SPXrC6cfo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c+Gjicl8ep0O5TlMbzxyBTPAhRJ2sKeeIMt3CYlpTbsa6CADkSyNOl3qA3xfLBb/lH0IqLw876K2BQvCkj1HY8X/SnivNrc/Z+cd+Q+X88cstpzOY4zyHEB/5QT0OOdNg6bOLfD63QUsTnQSfw4YLJefZzHq4gONi0KCX0uacA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ASuTGVHH; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40e800461baso43706325e9.3;
        Mon, 29 Jan 2024 07:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706541389; x=1707146189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IASguh5aQbxO74V2rxNG4OIKBUmHt4c+RrRbON3ICTE=;
        b=ASuTGVHHDTI2wtThtsjoRCxgf5BecnWZO5qlbN6nzldbxBE61A7cDot/ZvIzdgRxMt
         TZtGrRef6unyI6kaAmzKu62Hb6cjNZMIowE+AZgqbsSqeNtKANVofPRMWybN3VZtYXMa
         n4O5c7bOqwc5cXQiSrQQ/jhbmeQCHy94h/615w0T97lp9RW8CO6RHTa6JONdKxrb8hh8
         pNYRD6QmBxrY2u8tg8JlYbaunuz+8oBmaWYFZa11A0TfcHaz4OWEXHY/t50uFg+NXybO
         RjH0e6eJYz2l99MEl4KBAGx1xD9hnkvhSR1aM02CAwDJa7h7HTC+/qUTUR1dJj6DsPxR
         dp2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706541389; x=1707146189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IASguh5aQbxO74V2rxNG4OIKBUmHt4c+RrRbON3ICTE=;
        b=klNuJCTHU+2korIAFCgyp0NFttp2aZ9u+13ZR3KimHJY0Nz1VJk1BDV49XG9/OnfaB
         zPHG3pNLxvTo8lmhf/ZOgxMM5p2N/MKAEAd+bC7rV7/l/wbVIvmE55Z8Eo2FAwU1AaKk
         /TXQImEz0uiV6JA5BP4QBd3mtbzm27AxRHsHsByyjJWlJv3yik5CyJFkK5BT0t3UdpYm
         OPhpil0kDB7If9jSfowUg/Yu9a+E+XGKWSrUbbzgfuBmWxmQVbLCS1O7TwA9cu7es9RQ
         KbJjdpbQWNnyNpZo+Rl4F3oR3IHVY3WcEx0PUSd3vEk81SRcUsjfgGjiCHy7GGflXI+d
         sdrA==
X-Gm-Message-State: AOJu0YxuOKuU2OILN5qrwD0sxR+b1Kr78tDNFyT636tfanv0XM7brsOt
	Ta5h/dQEZcGehELcptH9sjbBN6mql5jJ13Hi43/yCeo0/dE8B8JC
X-Google-Smtp-Source: AGHT+IHoTFuNLMl927g6cbRBKakXRsPcfNSENOcUKWQPxS8T5mWHuxTtNY/sAOmh7UhnSu91nJUrSQ==
X-Received: by 2002:a7b:c4c5:0:b0:40e:cf0f:5fc9 with SMTP id g5-20020a7bc4c5000000b0040ecf0f5fc9mr4687262wmk.31.1706541389323;
        Mon, 29 Jan 2024 07:16:29 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2500:a01:5616:a18c:ea50:2995])
        by smtp.gmail.com with ESMTPSA id h4-20020adfa4c4000000b00337d4eed87asm8397774wrb.115.2024.01.29.07.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 07:16:28 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 2/5] irqchip/renesas-rzg2l: Add support for RZ/Five SoC
Date: Mon, 29 Jan 2024 15:16:15 +0000
Message-Id: <20240129151618.90922-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129151618.90922-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240129151618.90922-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

The IX45 block has additional mask registers (NMSK/IMSK/TMSK) as compared
to the RZ/G2L (family) SoC.

Introduce masking/unmasking support for IRQ and TINT interrupts in IRQC
controller driver. Two new registers, IMSK and TMSK, are defined to
handle masking on RZ/Five SoC. The implementation utilizes a new data
structure, `struct rzg2l_irqc_data`, to determine mask support for a
specific controller instance.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzg2l.c | 132 +++++++++++++++++++++++++++-
 1 file changed, 128 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index 9494fc26259c..949280f95c29 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -37,6 +37,8 @@
 #define TSSEL_SHIFT(n)			(8 * (n))
 #define TSSEL_MASK			GENMASK(7, 0)
 #define IRQ_MASK			0x3
+#define IMSK				0x10010
+#define TMSK				0x10020
 
 #define TSSR_OFFSET(n)			((n) % 4)
 #define TSSR_INDEX(n)			((n) / 4)
@@ -66,15 +68,25 @@ struct rzg2l_irqc_reg_cache {
 	u32	titsr[2];
 };
 
+/**
+ * struct rzg2l_irqc_data - OF data structure
+ * @mask_supported: Indicates if mask registers are available
+ */
+struct rzg2l_irqc_data {
+	bool	mask_supported;
+};
+
 /**
  * struct rzg2l_irqc_priv - IRQ controller private data structure
  * @base:	Controller's base address
+ * @data:	OF data pointer
  * @fwspec:	IRQ firmware specific data
  * @lock:	Lock to serialize access to hardware registers
  * @cache:	Registers cache for suspend/resume
  */
 static struct rzg2l_irqc_priv {
 	void __iomem			*base;
+	const struct rzg2l_irqc_data	*data;
 	struct irq_fwspec		fwspec[IRQC_NUM_IRQ];
 	raw_spinlock_t			lock;
 	struct rzg2l_irqc_reg_cache	cache;
@@ -129,44 +141,136 @@ static void rzg2l_irqc_eoi(struct irq_data *d)
 	irq_chip_eoi_parent(d);
 }
 
+static void rzg2l_irqc_mask_irq_interrupt(struct rzg2l_irqc_priv *priv,
+					  unsigned int hwirq)
+{
+	u32 imsk = readl_relaxed(priv->base + IMSK);
+	u32 bit = BIT(hwirq - IRQC_IRQ_START);
+
+	writel_relaxed(imsk | bit, priv->base + IMSK);
+}
+
+static void rzg2l_irqc_unmask_irq_interrupt(struct rzg2l_irqc_priv *priv,
+					    unsigned int hwirq)
+{
+	u32 imsk = readl_relaxed(priv->base + IMSK);
+	u32 bit = BIT(hwirq - IRQC_IRQ_START);
+
+	writel_relaxed(imsk & ~bit, priv->base + IMSK);
+}
+
+static void rzg2l_irqc_mask_tint_interrupt(struct rzg2l_irqc_priv *priv,
+					   unsigned int hwirq)
+{
+	u32 tmsk = readl_relaxed(priv->base + TMSK);
+	u32 bit = BIT(hwirq - IRQC_TINT_START);
+
+	writel_relaxed(tmsk | bit, priv->base + TMSK);
+}
+
+static void rzg2l_irqc_unmask_tint_interrupt(struct rzg2l_irqc_priv *priv,
+					     unsigned int hwirq)
+{
+	u32 tmsk = readl_relaxed(priv->base + TMSK);
+	u32 bit = BIT(hwirq - IRQC_TINT_START);
+
+	writel_relaxed(tmsk & ~bit, priv->base + TMSK);
+}
+
+/* Must be called while priv->lock is held */
+static void rzg2l_irqc_mask_once(struct rzg2l_irqc_priv *priv, unsigned int hwirq)
+{
+	if (!priv->data->mask_supported)
+		return;
+
+	if (hwirq >= IRQC_IRQ_START && hwirq <= IRQC_IRQ_COUNT)
+		rzg2l_irqc_mask_irq_interrupt(priv, hwirq);
+	else if (hwirq >= IRQC_TINT_START && hwirq < IRQC_NUM_IRQ)
+		rzg2l_irqc_mask_tint_interrupt(priv, hwirq);
+}
+
+static void rzg2l_irqc_mask(struct irq_data *d)
+{
+	struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
+
+	raw_spin_lock(&priv->lock);
+	rzg2l_irqc_mask_once(priv, irqd_to_hwirq(d));
+	raw_spin_unlock(&priv->lock);
+	irq_chip_mask_parent(d);
+}
+
+/* Must be called while priv->lock is held */
+static void rzg2l_irqc_unmask_once(struct rzg2l_irqc_priv *priv, unsigned int hwirq)
+{
+	if (!priv->data->mask_supported)
+		return;
+
+	if (hwirq >= IRQC_IRQ_START && hwirq <= IRQC_IRQ_COUNT)
+		rzg2l_irqc_unmask_irq_interrupt(priv, hwirq);
+	else if (hwirq >= IRQC_TINT_START && hwirq < IRQC_NUM_IRQ)
+		rzg2l_irqc_unmask_tint_interrupt(priv, hwirq);
+}
+
+static void rzg2l_irqc_unmask(struct irq_data *d)
+{
+	struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
+
+	raw_spin_lock(&priv->lock);
+	rzg2l_irqc_unmask_once(priv, irqd_to_hwirq(d));
+	raw_spin_unlock(&priv->lock);
+	irq_chip_unmask_parent(d);
+}
+
 static void rzg2l_irqc_irq_disable(struct irq_data *d)
 {
+	struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
 	unsigned int hw_irq = irqd_to_hwirq(d);
 
 	if (hw_irq >= IRQC_TINT_START && hw_irq < IRQC_NUM_IRQ) {
-		struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
 		u32 offset = hw_irq - IRQC_TINT_START;
 		u32 tssr_offset = TSSR_OFFSET(offset);
 		u8 tssr_index = TSSR_INDEX(offset);
 		u32 reg;
 
 		raw_spin_lock(&priv->lock);
+		rzg2l_irqc_mask_once(priv, hw_irq);
 		reg = readl_relaxed(priv->base + TSSR(tssr_index));
 		reg &= ~(TSSEL_MASK << TSSEL_SHIFT(tssr_offset));
 		writel_relaxed(reg, priv->base + TSSR(tssr_index));
 		raw_spin_unlock(&priv->lock);
+	} else {
+		raw_spin_lock(&priv->lock);
+		rzg2l_irqc_mask_once(priv, hw_irq);
+		raw_spin_unlock(&priv->lock);
 	}
+
 	irq_chip_disable_parent(d);
 }
 
 static void rzg2l_irqc_irq_enable(struct irq_data *d)
 {
+	struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
 	unsigned int hw_irq = irqd_to_hwirq(d);
 
 	if (hw_irq >= IRQC_TINT_START && hw_irq < IRQC_NUM_IRQ) {
 		unsigned long tint = (uintptr_t)irq_data_get_irq_chip_data(d);
-		struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
 		u32 offset = hw_irq - IRQC_TINT_START;
 		u32 tssr_offset = TSSR_OFFSET(offset);
 		u8 tssr_index = TSSR_INDEX(offset);
 		u32 reg;
 
 		raw_spin_lock(&priv->lock);
+		rzg2l_irqc_unmask_once(priv, hw_irq);
 		reg = readl_relaxed(priv->base + TSSR(tssr_index));
 		reg |= (TIEN | tint) << TSSEL_SHIFT(tssr_offset);
 		writel_relaxed(reg, priv->base + TSSR(tssr_index));
 		raw_spin_unlock(&priv->lock);
+	} else {
+		raw_spin_lock(&priv->lock);
+		rzg2l_irqc_unmask_once(priv, hw_irq);
+		raw_spin_unlock(&priv->lock);
 	}
+
 	irq_chip_enable_parent(d);
 }
 
@@ -294,8 +398,8 @@ static struct syscore_ops rzg2l_irqc_syscore_ops = {
 static const struct irq_chip irqc_chip = {
 	.name			= "rzg2l-irqc",
 	.irq_eoi		= rzg2l_irqc_eoi,
-	.irq_mask		= irq_chip_mask_parent,
-	.irq_unmask		= irq_chip_unmask_parent,
+	.irq_mask		= rzg2l_irqc_mask,
+	.irq_unmask		= rzg2l_irqc_unmask,
 	.irq_disable		= rzg2l_irqc_irq_disable,
 	.irq_enable		= rzg2l_irqc_irq_enable,
 	.irq_get_irqchip_state	= irq_chip_get_parent_state,
@@ -371,9 +475,23 @@ static int rzg2l_irqc_parse_interrupts(struct rzg2l_irqc_priv *priv,
 	return 0;
 }
 
+static const struct rzg2l_irqc_data rzfive_irqc_data = {
+	.mask_supported = true,
+};
+
+static const struct rzg2l_irqc_data rzg2l_irqc_default_data = {
+	.mask_supported = false,
+};
+
+static const struct of_device_id rzg2l_irqc_matches[] = {
+	{ .compatible = "renesas,r9a07g043f-irqc", .data = &rzfive_irqc_data },
+	{ }
+};
+
 static int rzg2l_irqc_init(struct device_node *node, struct device_node *parent)
 {
 	struct irq_domain *irq_domain, *parent_domain;
+	const struct of_device_id *match;
 	struct platform_device *pdev;
 	struct reset_control *resetn;
 	int ret;
@@ -392,6 +510,12 @@ static int rzg2l_irqc_init(struct device_node *node, struct device_node *parent)
 	if (!rzg2l_irqc_data)
 		return -ENOMEM;
 
+	match = of_match_node(rzg2l_irqc_matches, node);
+	if (match)
+		rzg2l_irqc_data->data = match->data;
+	else
+		rzg2l_irqc_data->data = &rzg2l_irqc_default_data;
+
 	rzg2l_irqc_data->base = devm_of_iomap(&pdev->dev, pdev->dev.of_node, 0, NULL);
 	if (IS_ERR(rzg2l_irqc_data->base))
 		return PTR_ERR(rzg2l_irqc_data->base);
-- 
2.34.1


