Return-Path: <linux-kernel+bounces-66909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA90856378
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E9791F26452
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91B012EBDB;
	Thu, 15 Feb 2024 12:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="VD2WyMdv"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB94C12D74F
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 12:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708000897; cv=none; b=XZAxNEx1rkYVKDVhxIw73wMaHboMgH0yF8AkSgmvzhFhYuuEi53ExqGhdceyzhpKDx6uriHys+mM/wx+ldqrcSE1tBKFH8Qd3imL8yoNuAOW0inOst75Ypr8Axkti033aENwHKoX2PSQ+xVgi/ed5Pt61RAHXOz0ysbG9k6KcMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708000897; c=relaxed/simple;
	bh=3r2hp3/Q7jGc/O04zu9NxGou7pHcI3g1mgV5Mmn8eOQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I8uXit+LMT7g2aUrNNChYj1Gyt8j+yvien2KEXWjpIUQJG9GkltKkyi+mB/ngI5YISLo0O4ARrNTrZVxhi/EdYtwuiP8akk/9Oi5kR3I09fj6S2aZKHa5fwOuhwC+CunM3aLji3fcFnVx/AVBrOspswVZy13UKzK8FvKBuVs1mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=VD2WyMdv; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33aea66a31cso436984f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 04:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1708000892; x=1708605692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zY03LI9eTwIaXczCnv2uGINoKlZdRzt+YmyGrzkFxsw=;
        b=VD2WyMdvOLUsiyiW3zmvyIaWFY7mggswlmE4chZXMJOXzaBv/NWS9yKQSL8YZ9kZys
         78csu++oqYcHwAqT8FST5P60tG5G93D2Fs1X9Hq3e2kaQIGkyW/maKCi67kUXqymtUk7
         dKdQvrpD0GK5JERxwPSfscwnrgsugbu3rRMUOnqWSYRJLKdTbgZdcqKLnXXUX3cCYtkp
         JvG5lmkLn4uapg8Y7lKfiEUkGva/TQU5cNwT7Sr8NJDEB+5wpZS5Mf2san0tNxSB5Joh
         dzBcBsebqdi/MKg0RE+/EtsIQWqr/58RMXQTQkGhOd91YTpmUpnMz9LouA/tPTZ9xxz/
         aZzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708000892; x=1708605692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zY03LI9eTwIaXczCnv2uGINoKlZdRzt+YmyGrzkFxsw=;
        b=Kvj1THpRks7k84bToqpZtcfTT3wJ4l/TCGpTZean3HWvwFa3IdqWKE6yLEgj13oGw/
         bRggAYDkrXLtNrCkmJoPo06huVwWWuLNJ5ZNL3lzF3ky+J6CD4IlLWhnNjHvKZyotIAa
         sB4VKzrD0B1IxozD8vhhlB6ZbCeEQxWLSQ75IgdWpHVaH9tngFtPkppmB2dZ5w31Axug
         OYEPbuxY88NWb65WfB+6Lk5LPO9oPzqPOkvR5Ta5bFm74XSecXk0DXQ9L+HBAHJmU3zz
         OOGJD77vmfp4aTcqNcIdNxAN2gLj+IkxvWFkk3KyBaLY7KgY9Ec0tIipMZqUMbfvwy9U
         7b8g==
X-Forwarded-Encrypted: i=1; AJvYcCVN5fpRkPc7X3SrqgmQumFaKRWffHf/j7tBff4iOFD9F8c9u+Zqna4efZ+j/Ql2KZ9SeYtCPGGVsPWSIwwpCqHTjPl6tX7Mm0agxNkP
X-Gm-Message-State: AOJu0Yzf4hN9SUYFPImbAElIGbHIuf7rdaJJXTXz+719CAqgEEXD4w3R
	SdKFNQ7GHPJzUZ6rDS60UtsXMUKq85HdaZypzAhFTwRj63qB40cm3k75JaMu1ZZkkP4cqtK/iNU
	0
X-Google-Smtp-Source: AGHT+IEtHZSHyxI98o4xHKyMrMLi7hDQUknqMVsNqFSY9aFx+v8g9HARaFSq9dMPiKl20rIy8bdNpg==
X-Received: by 2002:adf:a344:0:b0:33b:60ba:d990 with SMTP id d4-20020adfa344000000b0033b60bad990mr1150689wrb.19.1708000891892;
        Thu, 15 Feb 2024 04:41:31 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.20])
        by smtp.gmail.com with ESMTPSA id n16-20020a5d51d0000000b0033cefb84b16sm1674931wrv.52.2024.02.15.04.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 04:41:30 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	linus.walleij@linaro.org
Cc: linux-renesas-soc@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v2 2/2] pinctrl: renesas: rzg2l: Add suspend/resume support
Date: Thu, 15 Feb 2024 14:41:12 +0200
Message-Id: <20240215124112.2259103-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240215124112.2259103-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240215124112.2259103-1-claudiu.beznea.uj@bp.renesas.com>
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

Changes in v2:
- use u8 for sd_ch, eth_poc, eth_mode, qspi members of
  struct rzg2l_pinctrl_reg_cache and readb()/writeb() where necessary
- s/wakeup_source/wakeup_path/g
- call device_set_wakeup_path() on suspend
- call irq_chip_set_wake_parent() on rzg2l_gpio_irq_set_wake()

 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 408 +++++++++++++++++++++++-
 1 file changed, 404 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 818dccdd70da..9903739ba75a 100644
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
+	u8	sd_ch[2];
+	u8	eth_poc[2];
+	u8	eth_mode;
+	u8	qspi;
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
+	atomic_t			wakeup_path;
 };
 
 static const u16 available_ps[] = { 1800, 2500, 3300 };
@@ -1880,6 +1938,28 @@ static void rzg2l_gpio_irq_print_chip(struct irq_data *data, struct seq_file *p)
 	seq_printf(p, dev_name(gc->parent));
 }
 
+static int rzg2l_gpio_irq_set_wake(struct irq_data *data, unsigned int on)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(data);
+	struct rzg2l_pinctrl *pctrl = container_of(gc, struct rzg2l_pinctrl, gpio_chip);
+	int ret;
+
+	/* It should not happen. */
+	if (!data->parent_data)
+		return -EOPNOTSUPP;
+
+	ret = irq_chip_set_wake_parent(data, on);
+	if (ret)
+		return ret;
+
+	if (on)
+		atomic_inc(&pctrl->wakeup_path);
+	else
+		atomic_dec(&pctrl->wakeup_path);
+
+	return 0;
+}
+
 static const struct irq_chip rzg2l_gpio_irqchip = {
 	.name = "rzg2l-gpio",
 	.irq_disable = rzg2l_gpio_irq_disable,
@@ -1890,6 +1970,7 @@ static const struct irq_chip rzg2l_gpio_irqchip = {
 	.irq_eoi = rzg2l_gpio_irqc_eoi,
 	.irq_print_chip = rzg2l_gpio_irq_print_chip,
 	.irq_set_affinity = irq_chip_set_affinity_parent,
+	.irq_set_wake = rzg2l_gpio_irq_set_wake,
 	.flags = IRQCHIP_IMMUTABLE,
 	GPIOCHIP_IRQ_RESOURCE_HELPERS,
 };
@@ -1937,6 +2018,35 @@ static int rzg2l_gpio_populate_parent_fwspec(struct gpio_chip *chip,
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
@@ -1985,6 +2095,68 @@ static void rzg2l_init_irq_valid_mask(struct gpio_chip *gc,
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
@@ -2125,6 +2297,10 @@ static int rzg2l_pinctrl_register(struct rzg2l_pinctrl *pctrl)
 		}
 	}
 
+	ret = rzg2l_pinctrl_reg_cache_alloc(pctrl);
+	if (ret)
+		return ret;
+
 	ret = devm_pinctrl_register_and_init(pctrl->dev, &pctrl->desc, pctrl,
 					     &pctrl->pctl);
 	if (ret) {
@@ -2150,7 +2326,6 @@ static int rzg2l_pinctrl_register(struct rzg2l_pinctrl *pctrl)
 static int rzg2l_pinctrl_probe(struct platform_device *pdev)
 {
 	struct rzg2l_pinctrl *pctrl;
-	struct clk *clk;
 	int ret;
 
 	BUILD_BUG_ON(ARRAY_SIZE(r9a07g044_gpio_configs) * RZG2L_PINS_PER_PORT >
@@ -2176,14 +2351,16 @@ static int rzg2l_pinctrl_probe(struct platform_device *pdev)
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
+	atomic_set(&pctrl->wakeup_path, 0);
 
 	platform_set_drvdata(pdev, pctrl);
 
@@ -2195,6 +2372,224 @@ static int rzg2l_pinctrl_probe(struct platform_device *pdev)
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
+		cache->sd_ch[i] = readb(pctrl->base + SD_CH(regs->sd_ch, i));
+		cache->eth_poc[i] = readb(pctrl->base + ETH_POC(regs->eth_poc, i));
+	}
+
+	cache->qspi = readb(pctrl->base + QSPI);
+	cache->eth_mode = readb(pctrl->base + ETH_MODE);
+
+	if (!atomic_read(&pctrl->wakeup_path))
+		clk_disable_unprepare(pctrl->clk);
+	else
+		device_set_wakeup_path(dev);
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
+	if (!atomic_read(&pctrl->wakeup_path)) {
+		ret = clk_prepare_enable(pctrl->clk);
+		if (ret)
+			return ret;
+	}
+
+	writeb(cache->qspi, pctrl->base + QSPI);
+	writeb(cache->eth_mode, pctrl->base + ETH_MODE);
+	for (u8 i = 0; i < 2; i++) {
+		writeb(cache->sd_ch[i], pctrl->base + SD_CH(regs->sd_ch, i));
+		writeb(cache->eth_poc[i], pctrl->base + ETH_POC(regs->eth_poc, i));
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
@@ -2291,10 +2686,15 @@ static const struct of_device_id rzg2l_pinctrl_of_table[] = {
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


