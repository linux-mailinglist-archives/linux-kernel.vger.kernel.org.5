Return-Path: <linux-kernel+bounces-58199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C05A084E2A5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CA592924DA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45C97B3E9;
	Thu,  8 Feb 2024 13:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Q7ELiIks"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E23B768E1
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 13:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707400609; cv=none; b=saXw5p1Bu6oBreGX9Yh4wARdZrNwpobJCvLKai9KMtHN+xH/9sgWFvID09nzVWUd0pr0LsCPu7ByzcZvvJkxwNnlHB//mcoHOov3REgih9egc4K893o+D7LiVV8BV5ij+TtXtxRhaFkZBwznkyTa9xbUYyuGRQURzEJGrZmo3Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707400609; c=relaxed/simple;
	bh=ATlqNdtLr7xo+I/5WENVZOrMdbjM16Urm5b9fU9QVso=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o0zdwhBghTFuRhwmip+ydK9BK9alxRb1m6DPvoVbl+LiUX4R4vT/yajWINm2mqQXOWjZfVDBLA0KZ24ggwmfjj8qkhl9VYDg/Nk19t9/O1uxj7dwB0PJ2uyhHDnA+AKM0u/7UsdYerrnKY2eO4ak209lSUvB9evfP6LMKHJTEuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Q7ELiIks; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33b189ae5e8so1021370f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 05:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1707400605; x=1708005405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tNMGTECMGB71BjN4qtGnb25Swo724MrpdkpiFvBreEg=;
        b=Q7ELiIksNqxnhJ7oyw5/1IG9dkaxQ942K/F+/QRYahT6mtq5CYTNBOBb60836KfPDq
         nk8Ck/ktk7MluqesjbmVJidlgh/qisY1nWDMniwpU5tX9aFykYd8n3Y4iTAupDHI8ZuP
         ynL9pM9RcbHsRuBpR659lKhJOQmwdysrJ00WO16b02QG6/rqQuH+SmyIgFSlrYF8RKYS
         SrVIlvS3eQ9U/hoL53uu9b8L/p5obKGAMRr6HPmf+Jz7bVTMvVGO/oS8P0dnBm5hMfCl
         yBXCzvRDn8LWksGl8Txlx+m390Vqxl0Hf6wKvX2Vxo0Wv9eACR+Ql8KhVSdmCT7bL7nN
         93Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707400605; x=1708005405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tNMGTECMGB71BjN4qtGnb25Swo724MrpdkpiFvBreEg=;
        b=r+azGRHrQv0peehAu2oPWYRwsElQMBp1SrjQLZhHxAHr2XS1KVInZ7Djgt3VQgknoA
         sP7Cl+rBAYQBmZI32ml9yKIG4gSl1qLqEIqZJDgwTucsXG4YRaYiQQ87o1ViElgKZ5ML
         0AY1g9FsOCqbdrgCQJEyq9iwHSc90BvXzcEMPt3x3sr+svHCVajfGvyc/BlBS1rnv9a4
         eKFTsxvJV0B91fbkPieYXvfTa4pyZNq35W61Uh2Pcwa9bdFrpvozwxutlLitw38wnC8U
         7EjD0hGsVaUHpt5c3wbImCThh9QcQJzlK779IMXu633jLOT4gU53bNURAuWrdOjgh+WC
         QwcA==
X-Gm-Message-State: AOJu0Yw4fxfWCqpXdrb+3qdcuGCAQooZfkEjGZwLKuB2XMDBvSc4xAcX
	4Cs0ASYLLlK7oPkofEx11r4U1ymFWoa62DzghNVCAZWxaGQ/ed683k3+MUy6csY=
X-Google-Smtp-Source: AGHT+IGTYZfJLjcbRc/8CFiM4KxlQcTxLXYj0kB/4Fa+O+Np3KqA04DAtLgcKS5ZhFGJWCyoADOj0g==
X-Received: by 2002:a5d:4b09:0:b0:33b:47ed:eda1 with SMTP id v9-20020a5d4b09000000b0033b47ededa1mr5853720wrq.3.1707400604661;
        Thu, 08 Feb 2024 05:56:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVK2C2qR41q5M2VvnqbZVNOPWviyf6oX4h0mCZUclJdPPyivb8rADf448jOCV/HiJjafXnvGsSoidicDklHu81FsFZaVeRX/xxuj5a32e2lUtZW2uUcprybnzANokKZQdCznVht09upoRZVPq//DSg5EoqEDLlYJQTdx/SgKZa+CqJnu2iJOeeb/G6Ohe98h6BTLpx6Vj7/U/+15lqcOb2rxnIrvPMMm3Q/vHzr6DEfSTqNngMSXgBSFyPfuIXGRmPksfsm6YxLvnvHxGMhnAxUdbjEwRSRqK8XOpWMJah/Ga98wKGQgnZzlpTsC4Av5PKd9hTMQnPJtNp9TEt4XJvnKsa+ZQSGwvZaLqTgJ863DJQbm3aBbVyilzJsUkFP2+ZrFzV7IoNRg3hQTBbRcacyvKcZiFv2GpHsBA==
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.45])
        by smtp.gmail.com with ESMTPSA id iv6-20020a05600c548600b0040ef3ae26cdsm1703058wmb.37.2024.02.08.05.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 05:56:44 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	magnus.damm@gmail.com,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	linus.walleij@linaro.org
Cc: linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 1/2] pinctrl: renesas: rzg2l: Add suspend/resume support
Date: Thu,  8 Feb 2024 15:56:28 +0200
Message-Id: <20240208135629.2840932-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240208135629.2840932-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240208135629.2840932-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

pinctrl-rzg2l driver is used on RZ/G3S which support deep sleep states
where power to most of the SoC components is turned off.

For this add suspend/resume support. This involves saving and restoring
configured registers along with disabling clock in case there is no pin
configured as wakeup sources.

To save/restore registers 2 caches were allocated: one for GPIO pins and
one for dedicated pins.

On suspend path the pin controller registers are saved and if none of the
pins are configured as wakeup sources the pinctrl clock is disabled.
Otherwise it remains on.

On resume path the configuration is done as follows:
1/ setup PFCs by writing to registers on pin based accesses
2/ setup GPIOs by writing to registers on port based accesses and
   following configuration steps specified in hardware manual
3/ setup dedicated pins by writing to registers on port based accesses
4/ setup interrupts.

Because interrupt signals are routed to IA55 interrupt controller and
IA55 interrupt controller resumes before pin controller, patch restores
also the configured interrupts just after pin settings are restored to
avoid invalid interrupts while resuming.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 397 +++++++++++++++++++++++-
 1 file changed, 393 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 818dccdd70da..09d9b448d819 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -149,6 +149,33 @@
 #define RZG2L_TINT_IRQ_START_INDEX	9
 #define RZG2L_PACK_HWIRQ(t, i)		(((t) << 16) | (i))
 
+/* Read/write 8 bits register */
+#define RZG2L_PCTRL_REG_ACCESS8(_read, _addr, _val)	\
+	do {						\
+		if (_read)				\
+			_val = readb(_addr);		\
+		else					\
+			writeb(_val, _addr);		\
+	} while (0)
+
+/* Read/write 16 bits register */
+#define RZG2L_PCTRL_REG_ACCESS16(_read, _addr, _val)	\
+	do {						\
+		if (_read)				\
+			_val = readw(_addr);		\
+		else					\
+			writew(_val, _addr);		\
+	} while (0)
+
+/* Read/write 32 bits register */
+#define RZG2L_PCTRL_REG_ACCESS32(_read, _addr, _val)	\
+	do {						\
+		if (_read)				\
+			_val = readl(_addr);		\
+		else					\
+			writel(_val, _addr);		\
+	} while (0)
+
 /**
  * struct rzg2l_register_offsets - specific register offsets
  * @pwpr: PWPR register offset
@@ -241,6 +268,32 @@ struct rzg2l_pinctrl_pin_settings {
 	u16 drive_strength_ua;
 };
 
+/**
+ * struct rzg2l_pinctrl_reg_cache - register cache structure (to be used in suspend/resume)
+ * @p: P registers cache
+ * @pm: PM registers cache
+ * @pmc: PMC registers cache
+ * @pfc: PFC registers cache
+ * @iolh: IOLH registers cache
+ * @ien: IEN registers cache
+ * @sd_ch: SD_CH registers cache
+ * @eth_poc: ET_POC registers cache
+ * @eth_mode: ETH_MODE register cache
+ * @qspi: QSPI registers cache
+ */
+struct rzg2l_pinctrl_reg_cache {
+	u8	*p;
+	u16	*pm;
+	u8	*pmc;
+	u32	*pfc;
+	u32	*iolh[2];
+	u32	*ien[2];
+	u32	sd_ch[2];
+	u32	eth_poc[2];
+	u32	eth_mode;
+	u32	qspi;
+};
+
 struct rzg2l_pinctrl {
 	struct pinctrl_dev		*pctl;
 	struct pinctrl_desc		desc;
@@ -250,6 +303,8 @@ struct rzg2l_pinctrl {
 	void __iomem			*base;
 	struct device			*dev;
 
+	struct clk			*clk;
+
 	struct gpio_chip		gpio_chip;
 	struct pinctrl_gpio_range	gpio_range;
 	DECLARE_BITMAP(tint_slot, RZG2L_TINT_MAX_INTERRUPT);
@@ -260,6 +315,9 @@ struct rzg2l_pinctrl {
 	struct mutex			mutex; /* serialize adding groups and functions */
 
 	struct rzg2l_pinctrl_pin_settings *settings;
+	struct rzg2l_pinctrl_reg_cache	*cache;
+	struct rzg2l_pinctrl_reg_cache	*dedicated_cache;
+	atomic_t			wakeup_source;
 };
 
 static const u16 available_ps[] = { 1800, 2500, 3300 };
@@ -1880,6 +1938,19 @@ static void rzg2l_gpio_irq_print_chip(struct irq_data *data, struct seq_file *p)
 	seq_printf(p, dev_name(gc->parent));
 }
 
+static int rzg2l_gpio_irq_set_wake(struct irq_data *data, unsigned int on)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(data);
+	struct rzg2l_pinctrl *pctrl = container_of(gc, struct rzg2l_pinctrl, gpio_chip);
+
+	if (on)
+		atomic_inc(&pctrl->wakeup_source);
+	else
+		atomic_dec(&pctrl->wakeup_source);
+
+	return 0;
+}
+
 static const struct irq_chip rzg2l_gpio_irqchip = {
 	.name = "rzg2l-gpio",
 	.irq_disable = rzg2l_gpio_irq_disable,
@@ -1890,6 +1961,7 @@ static const struct irq_chip rzg2l_gpio_irqchip = {
 	.irq_eoi = rzg2l_gpio_irqc_eoi,
 	.irq_print_chip = rzg2l_gpio_irq_print_chip,
 	.irq_set_affinity = irq_chip_set_affinity_parent,
+	.irq_set_wake = rzg2l_gpio_irq_set_wake,
 	.flags = IRQCHIP_IMMUTABLE,
 	GPIOCHIP_IRQ_RESOURCE_HELPERS,
 };
@@ -1937,6 +2009,35 @@ static int rzg2l_gpio_populate_parent_fwspec(struct gpio_chip *chip,
 	return 0;
 }
 
+static void rzg2l_gpio_irq_restore(struct rzg2l_pinctrl *pctrl)
+{
+	struct irq_domain *domain = pctrl->gpio_chip.irq.domain;
+
+	for (unsigned int i = 0; i < RZG2L_TINT_MAX_INTERRUPT; i++) {
+		struct irq_data *data;
+		unsigned int virq;
+
+		if (!pctrl->hwirq[i])
+			continue;
+
+		virq = irq_find_mapping(domain, pctrl->hwirq[i]);
+		if (!virq) {
+			dev_crit(pctrl->dev, "Failed to find IRQ mapping for hwirq %u\n",
+				 pctrl->hwirq[i]);
+			continue;
+		}
+
+		data = irq_domain_get_irq_data(domain, virq);
+		if (!data) {
+			dev_crit(pctrl->dev, "Failed to get IRQ data for virq=%u\n", virq);
+			continue;
+		}
+
+		if (!irqd_irq_disabled(data))
+			rzg2l_gpio_irq_enable(data);
+	}
+}
+
 static void rzg2l_gpio_irq_domain_free(struct irq_domain *domain, unsigned int virq,
 				       unsigned int nr_irqs)
 {
@@ -1985,6 +2086,68 @@ static void rzg2l_init_irq_valid_mask(struct gpio_chip *gc,
 	}
 }
 
+static int rzg2l_pinctrl_reg_cache_alloc(struct rzg2l_pinctrl *pctrl)
+{
+	u32 nports = pctrl->data->n_port_pins / RZG2L_PINS_PER_PORT;
+	struct rzg2l_pinctrl_reg_cache *cache, *dedicated_cache;
+
+	cache = devm_kzalloc(pctrl->dev, sizeof(*cache), GFP_KERNEL);
+	if (!cache)
+		return -ENOMEM;
+
+	dedicated_cache = devm_kzalloc(pctrl->dev, sizeof(*dedicated_cache), GFP_KERNEL);
+	if (!dedicated_cache)
+		return -ENOMEM;
+
+	cache->p = devm_kcalloc(pctrl->dev, nports, sizeof(*cache->p), GFP_KERNEL);
+	if (!cache->p)
+		return -ENOMEM;
+
+	cache->pm = devm_kcalloc(pctrl->dev, nports, sizeof(*cache->pm), GFP_KERNEL);
+	if (!cache->pm)
+		return -ENOMEM;
+
+	cache->pmc = devm_kcalloc(pctrl->dev, nports, sizeof(*cache->pmc), GFP_KERNEL);
+	if (!cache->pmc)
+		return -ENOMEM;
+
+	cache->pfc = devm_kcalloc(pctrl->dev, nports, sizeof(*cache->pfc), GFP_KERNEL);
+	if (!cache->pfc)
+		return -ENOMEM;
+
+	for (u8 i = 0; i < 2; i++) {
+		u32 n_dedicated_pins = pctrl->data->n_dedicated_pins;
+
+		cache->iolh[i] = devm_kcalloc(pctrl->dev, nports, sizeof(*cache->iolh[i]),
+					      GFP_KERNEL);
+		if (!cache->iolh[i])
+			return -ENOMEM;
+
+		cache->ien[i] = devm_kcalloc(pctrl->dev, nports, sizeof(*cache->ien[i]),
+					     GFP_KERNEL);
+		if (!cache->ien[i])
+			return -ENOMEM;
+
+		/* Allocate dedicated cache. */
+		dedicated_cache->iolh[i] = devm_kcalloc(pctrl->dev, n_dedicated_pins,
+							sizeof(*dedicated_cache->iolh[i]),
+							GFP_KERNEL);
+		if (!dedicated_cache->iolh[i])
+			return -ENOMEM;
+
+		dedicated_cache->ien[i] = devm_kcalloc(pctrl->dev, n_dedicated_pins,
+						       sizeof(*dedicated_cache->ien[i]),
+						       GFP_KERNEL);
+		if (!dedicated_cache->ien[i])
+			return -ENOMEM;
+	}
+
+	pctrl->cache = cache;
+	pctrl->dedicated_cache = dedicated_cache;
+
+	return 0;
+}
+
 static int rzg2l_gpio_register(struct rzg2l_pinctrl *pctrl)
 {
 	struct device_node *np = pctrl->dev->of_node;
@@ -2125,6 +2288,10 @@ static int rzg2l_pinctrl_register(struct rzg2l_pinctrl *pctrl)
 		}
 	}
 
+	ret = rzg2l_pinctrl_reg_cache_alloc(pctrl);
+	if (ret)
+		return ret;
+
 	ret = devm_pinctrl_register_and_init(pctrl->dev, &pctrl->desc, pctrl,
 					     &pctrl->pctl);
 	if (ret) {
@@ -2150,7 +2317,6 @@ static int rzg2l_pinctrl_register(struct rzg2l_pinctrl *pctrl)
 static int rzg2l_pinctrl_probe(struct platform_device *pdev)
 {
 	struct rzg2l_pinctrl *pctrl;
-	struct clk *clk;
 	int ret;
 
 	BUILD_BUG_ON(ARRAY_SIZE(r9a07g044_gpio_configs) * RZG2L_PINS_PER_PORT >
@@ -2176,14 +2342,16 @@ static int rzg2l_pinctrl_probe(struct platform_device *pdev)
 	if (IS_ERR(pctrl->base))
 		return PTR_ERR(pctrl->base);
 
-	clk = devm_clk_get_enabled(pctrl->dev, NULL);
-	if (IS_ERR(clk))
-		return dev_err_probe(pctrl->dev, PTR_ERR(clk),
+	pctrl->clk = devm_clk_get_enabled(pctrl->dev, NULL);
+	if (IS_ERR(pctrl->clk)) {
+		return dev_err_probe(pctrl->dev, PTR_ERR(pctrl->clk),
 				     "failed to enable GPIO clk\n");
+	}
 
 	spin_lock_init(&pctrl->lock);
 	spin_lock_init(&pctrl->bitmap_lock);
 	mutex_init(&pctrl->mutex);
+	atomic_set(&pctrl->wakeup_source, 0);
 
 	platform_set_drvdata(pdev, pctrl);
 
@@ -2195,6 +2363,222 @@ static int rzg2l_pinctrl_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static void rzg2l_pinctrl_pm_setup_regs(struct rzg2l_pinctrl *pctrl, bool suspend)
+{
+	u32 nports = pctrl->data->n_port_pins / RZG2L_PINS_PER_PORT;
+	struct rzg2l_pinctrl_reg_cache *cache = pctrl->cache;
+
+	for (u32 port = 0; port < nports; port++) {
+		bool has_iolh, has_ien;
+		u32 off, caps;
+		u8 pincnt;
+		u64 cfg;
+
+		cfg = pctrl->data->port_pin_configs[port];
+		off = RZG2L_PIN_CFG_TO_PORT_OFFSET(cfg);
+		pincnt = hweight8(FIELD_GET(PIN_CFG_PIN_MAP_MASK, cfg));
+
+		caps = FIELD_GET(PIN_CFG_MASK, cfg);
+		has_iolh = !!(caps & (PIN_CFG_IOLH_A | PIN_CFG_IOLH_B | PIN_CFG_IOLH_C));
+		has_ien = !!(caps & PIN_CFG_IEN);
+
+		if (suspend)
+			RZG2L_PCTRL_REG_ACCESS32(suspend, pctrl->base + PFC(off), cache->pfc[port]);
+
+		/*
+		 * Now cache the registers or set them in the order suggested by
+		 * HW manual (section "Operation for GPIO Function").
+		 */
+		RZG2L_PCTRL_REG_ACCESS8(suspend, pctrl->base + PMC(off), cache->pmc[port]);
+		if (has_iolh) {
+			RZG2L_PCTRL_REG_ACCESS32(suspend, pctrl->base + IOLH(off),
+						 cache->iolh[0][port]);
+			if (pincnt >= 4) {
+				RZG2L_PCTRL_REG_ACCESS32(suspend, pctrl->base + IOLH(off) + 4,
+							 cache->iolh[1][port]);
+			}
+		}
+
+		RZG2L_PCTRL_REG_ACCESS16(suspend, pctrl->base + PM(off), cache->pm[port]);
+		RZG2L_PCTRL_REG_ACCESS8(suspend, pctrl->base + P(off), cache->p[port]);
+
+		if (has_ien) {
+			RZG2L_PCTRL_REG_ACCESS32(suspend, pctrl->base + IEN(off),
+						 cache->ien[0][port]);
+			if (pincnt >= 4) {
+				RZG2L_PCTRL_REG_ACCESS32(suspend, pctrl->base + IEN(off) + 4,
+							 cache->ien[1][port]);
+			}
+		}
+	}
+}
+
+static void rzg2l_pinctrl_pm_setup_dedicated_regs(struct rzg2l_pinctrl *pctrl, bool suspend)
+{
+	struct rzg2l_pinctrl_reg_cache *cache = pctrl->dedicated_cache;
+
+	/*
+	 * Make sure entries in pctrl->data->n_dedicated_pins[] having the same
+	 * port offset are close together.
+	 */
+	for (u32 i = 0, caps = 0; i < pctrl->data->n_dedicated_pins; i++) {
+		bool has_iolh, has_ien;
+		u32 off, next_off = 0;
+		u64 cfg, next_cfg;
+		u8 pincnt;
+
+		cfg = pctrl->data->dedicated_pins[i].config;
+		off = RZG2L_PIN_CFG_TO_PORT_OFFSET(cfg);
+		if (i + 1 < pctrl->data->n_dedicated_pins) {
+			next_cfg = pctrl->data->dedicated_pins[i + 1].config;
+			next_off = RZG2L_PIN_CFG_TO_PORT_OFFSET(next_cfg);
+		}
+
+		if (off == next_off) {
+			/* Gather caps of all port pins. */
+			caps |= FIELD_GET(PIN_CFG_MASK, cfg);
+			continue;
+		}
+
+		/* And apply them in a single shot. */
+		has_iolh = !!(caps & (PIN_CFG_IOLH_A | PIN_CFG_IOLH_B | PIN_CFG_IOLH_C));
+		has_ien = !!(caps & PIN_CFG_IEN);
+		pincnt = hweight8(FIELD_GET(RZG2L_SINGLE_PIN_BITS_MASK, cfg));
+
+		if (has_iolh) {
+			RZG2L_PCTRL_REG_ACCESS32(suspend, pctrl->base + IOLH(off),
+						 cache->iolh[0][i]);
+		}
+		if (has_ien) {
+			RZG2L_PCTRL_REG_ACCESS32(suspend, pctrl->base + IEN(off),
+						 cache->ien[0][i]);
+		}
+
+		if (pincnt >= 4) {
+			if (has_iolh) {
+				RZG2L_PCTRL_REG_ACCESS32(suspend,
+							 pctrl->base + IOLH(off) + 4,
+							 cache->iolh[1][i]);
+			}
+			if (has_ien) {
+				RZG2L_PCTRL_REG_ACCESS32(suspend,
+							 pctrl->base + IEN(off) + 4,
+							 cache->ien[1][i]);
+			}
+		}
+		caps = 0;
+	}
+}
+
+static void rzg2l_pinctrl_pm_setup_pfc(struct  rzg2l_pinctrl *pctrl)
+{
+	u32 nports = pctrl->data->n_port_pins / RZG2L_PINS_PER_PORT;
+	const struct rzg2l_hwcfg *hwcfg = pctrl->data->hwcfg;
+	const struct rzg2l_register_offsets *regs = &hwcfg->regs;
+
+	/* Set the PWPR register to allow PFC register to write. */
+	writel(0x0, pctrl->base + regs->pwpr);		/* B0WI=0, PFCWE=0 */
+	writel(PWPR_PFCWE, pctrl->base + regs->pwpr);	/* B0WI=0, PFCWE=1 */
+
+	/* Restore port registers. */
+	for (u32 port = 0; port < nports; port++) {
+		unsigned long pinmap;
+		u8 pmc = 0, max_pin;
+		u32 off, pfc = 0;
+		u64 cfg;
+		u16 pm;
+		u8 pin;
+
+		cfg = pctrl->data->port_pin_configs[port];
+		off = RZG2L_PIN_CFG_TO_PORT_OFFSET(cfg);
+		pinmap = FIELD_GET(PIN_CFG_PIN_MAP_MASK, cfg);
+		max_pin = fls(pinmap);
+
+		pm = readw(pctrl->base + PM(off));
+		for_each_set_bit(pin, &pinmap, max_pin) {
+			struct rzg2l_pinctrl_reg_cache *cache = pctrl->cache;
+
+			/* Nothing to do if PFC was not configured before. */
+			if (!(cache->pmc[port] & BIT(pin)))
+				continue;
+
+			/* Set pin to 'Non-use (Hi-Z input protection)' */
+			pm &= ~(PM_MASK << (pin * 2));
+			writew(pm, pctrl->base + PM(off));
+
+			/* Temporarily switch to GPIO mode with PMC register */
+			pmc &= ~BIT(pin);
+			writeb(pmc, pctrl->base + PMC(off));
+
+			/* Select Pin function mode. */
+			pfc &= ~(PFC_MASK << (pin * 4));
+			pfc |= (cache->pfc[port] & (PFC_MASK << (pin * 4)));
+			writel(pfc, pctrl->base + PFC(off));
+
+			/* Switch to Peripheral pin function. */
+			pmc |= BIT(pin);
+			writeb(pmc, pctrl->base + PMC(off));
+		}
+	}
+
+	/* Set the PWPR register to be write-protected. */
+	writel(0x0, pctrl->base + regs->pwpr);		/* B0WI=0, PFCWE=0 */
+	writel(PWPR_B0WI, pctrl->base + regs->pwpr);	/* B0WI=1, PFCWE=0 */
+}
+
+static int rzg2l_pinctrl_suspend_noirq(struct device *dev)
+{
+	struct rzg2l_pinctrl *pctrl = dev_get_drvdata(dev);
+	const struct rzg2l_hwcfg *hwcfg = pctrl->data->hwcfg;
+	const struct rzg2l_register_offsets *regs = &hwcfg->regs;
+	struct rzg2l_pinctrl_reg_cache *cache = pctrl->cache;
+
+	rzg2l_pinctrl_pm_setup_regs(pctrl, true);
+	rzg2l_pinctrl_pm_setup_dedicated_regs(pctrl, true);
+
+	for (u8 i = 0; i < 2; i++) {
+		cache->sd_ch[i] = readl(pctrl->base + SD_CH(regs->sd_ch, i));
+		cache->eth_poc[i] = readl(pctrl->base + ETH_POC(regs->eth_poc, i));
+	}
+
+	cache->qspi = readl(pctrl->base + QSPI);
+	cache->eth_mode = readl(pctrl->base + ETH_MODE);
+
+	if (!atomic_read(&pctrl->wakeup_source))
+		clk_disable_unprepare(pctrl->clk);
+
+	return 0;
+}
+
+static int rzg2l_pinctrl_resume_noirq(struct device *dev)
+{
+	struct rzg2l_pinctrl *pctrl = dev_get_drvdata(dev);
+	const struct rzg2l_hwcfg *hwcfg = pctrl->data->hwcfg;
+	const struct rzg2l_register_offsets *regs = &hwcfg->regs;
+	struct rzg2l_pinctrl_reg_cache *cache = pctrl->cache;
+	int ret;
+
+	if (!atomic_read(&pctrl->wakeup_source)) {
+		ret = clk_prepare_enable(pctrl->clk);
+		if (ret)
+			return ret;
+	}
+
+	writel(cache->qspi, pctrl->base + QSPI);
+	writel(cache->eth_mode, pctrl->base + ETH_MODE);
+	for (u8 i = 0; i < 2; i++) {
+		writel(cache->sd_ch[i], pctrl->base + SD_CH(regs->sd_ch, i));
+		writel(cache->eth_poc[i], pctrl->base + ETH_POC(regs->eth_poc, i));
+	}
+
+	rzg2l_pinctrl_pm_setup_pfc(pctrl);
+	rzg2l_pinctrl_pm_setup_regs(pctrl, false);
+	rzg2l_pinctrl_pm_setup_dedicated_regs(pctrl, false);
+	rzg2l_gpio_irq_restore(pctrl);
+
+	return 0;
+}
+
 static const struct rzg2l_hwcfg rzg2l_hwcfg = {
 	.regs = {
 		.pwpr = 0x3014,
@@ -2291,10 +2675,15 @@ static const struct of_device_id rzg2l_pinctrl_of_table[] = {
 	{ /* sentinel */ }
 };
 
+static const struct dev_pm_ops rzg2l_pinctrl_pm_ops = {
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(rzg2l_pinctrl_suspend_noirq, rzg2l_pinctrl_resume_noirq)
+};
+
 static struct platform_driver rzg2l_pinctrl_driver = {
 	.driver = {
 		.name = DRV_NAME,
 		.of_match_table = of_match_ptr(rzg2l_pinctrl_of_table),
+		.pm = pm_sleep_ptr(&rzg2l_pinctrl_pm_ops),
 	},
 	.probe = rzg2l_pinctrl_probe,
 };
-- 
2.39.2


