Return-Path: <linux-kernel+bounces-65528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 500D3854E5A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B6E4B2C408
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3C4651B3;
	Wed, 14 Feb 2024 16:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cd6HbRrJ"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9A660DEF;
	Wed, 14 Feb 2024 16:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707927902; cv=none; b=BxhfriDuiac9C74fEQ81SjX9jpxSVMW2O0RkCAJBwtJ+p499Jn6ko9ltmLijEDqRTjZuQaJ5DVsYi1D8C6htMdL6M8TS53lxDndvPErt1KE7FhJxm0rFxYmWeTck4YgTNHitNq1DE3kK+ZxNsGXESugOcEB4XAf8LXJskENB5MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707927902; c=relaxed/simple;
	bh=iYjgZMz+zud05N2dUW31PmYu0TF9Tjn1dXL+vZsBZF0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uukRCOkS+/xS6aUzEC6CGBCdGx2+nap37KMxrBAXQjnZvL60mhSCuRuawY3VjlsI4TVeeTNaNV/WzVjKrA17gqVIbHQXMMRzu0rdHufVlqJOmAlISEQRLxkQCUIFZD8lnSWFvchACAvHQ0z0syliaAqh9OP0j3d/RZ7CBjkSEnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cd6HbRrJ; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6D7AA6000D;
	Wed, 14 Feb 2024 16:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707927898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PJIrBCaT9FsGrZNNRu2G44b64W62E7DgN52EGgqwMkw=;
	b=cd6HbRrJ+R1NtODzzdxAxt3Kk1xIqoCVn7TCRATO61EaAd9p53MU4mhH40/Mxx+EmMUeNz
	ES49dVnDBWjCsM6f1xQINzeGJweVTUQx4k1gIUeE3Oq7vhpPO0oQyctBXpDueFh5Uqp7Dy
	dTJX+enOfbJWpzyvFav8C7rxZEsbH4AWKv1uYc8LIQTsHQFBkYGU+mF5V2wfSxPC0Sk3Yn
	iSTXpL6ufq6BKs1WxzIzPxt4gML0A37RoH/RQDahCizqHVtmVidU9ukvkRNewwjXYJxbSF
	/SxW+S3qlEBcTzlQ/vb+LoMYkzVEeV2uajXm0OxpSTtbDoa6xbZzCCWC5Y0f5Q==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 14 Feb 2024 17:24:11 +0100
Subject: [PATCH 18/23] gpio: nomadik: support mobileye,eyeq5-gpio
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240214-mbly-gpio-v1-18-f88c0ccf372b@bootlin.com>
References: <20240214-mbly-gpio-v1-0-f88c0ccf372b@bootlin.com>
In-Reply-To: <20240214-mbly-gpio-v1-0-f88c0ccf372b@bootlin.com>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mips@vger.kernel.org, Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: theo.lebrun@bootlin.com

We create a custom compatible for the STA2X11 IP block as integrated
into the Mobileye EyeQ5 platform. Its wake and alternate functions have
been disabled, we want to avoid touching those registers.

We both do: (1) early return in functions that do not support the
platform, but with warnings, and (2) avoid calling those functions in
the first place.

We ensure that pinctrl-nomadik is not used with this STA2X11 variant.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/gpio/Kconfig                      |  5 +--
 drivers/gpio/gpio-nomadik.c               | 52 ++++++++++++++++++++++++++-----
 drivers/pinctrl/nomadik/pinctrl-nomadik.c |  2 ++
 include/linux/gpio/gpio-nomadik.h         |  1 +
 4 files changed, 51 insertions(+), 9 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index ff83371251c1..fe6112abb73a 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -480,11 +480,12 @@ config GPIO_MXS
 
 config GPIO_NOMADIK
 	bool "Nomadik GPIO driver"
-	depends on ARCH_U8500 || ARCH_NOMADIK || COMPILE_TEST
+	depends on ARCH_U8500 || ARCH_NOMADIK || MACH_EYEQ5 || COMPILE_TEST
 	select OF_GPIO
 	select GPIOLIB_IRQCHIP
 	help
-	  Say yes here to support the Nomadik SoC GPIO block.
+	  Say yes here to support the Nomadik SoC GPIO block. This block is also
+	  used by the Mobileye EyeQ5 SoC.
 
 	  It handles up to 32 GPIOs per bank, that can all be interrupt sources.
 	  It is deeply interconnected with the associated pinctrl driver as GPIO
diff --git a/drivers/gpio/gpio-nomadik.c b/drivers/gpio/gpio-nomadik.c
index 02b53c58adf7..21bb6d6363fc 100644
--- a/drivers/gpio/gpio-nomadik.c
+++ b/drivers/gpio/gpio-nomadik.c
@@ -7,6 +7,12 @@
  * The GPIO chips are shared with pinctrl-nomadik if used; it needs access for
  * pinmuxing functionality and others.
  *
+ * This driver also handles the mobileye,eyeq5-gpio compatible. It is an STA2X11
+ * but with only data, direction and interrupts register active. We want to
+ * avoid touching SLPM, RWIMSC, FWIMSC, AFSLA and AFSLB registers; that is,
+ * wake and alternate function registers. It is NOT compatible with
+ * pinctrl-nomadik.
+ *
  * Copyright (C) 2008,2009 STMicroelectronics
  * Copyright (C) 2009 Alessandro Rubini <rubini@unipv.it>
  *   Rewritten based on work by Prafulla WADASKAR <prafulla.wadaskar@st.com>
@@ -31,11 +37,17 @@
 static DEFINE_SPINLOCK(nmk_gpio_slpm_lock);
 #endif
 
+#define NMK_GPIO_FLAG_QUIRK_MBLY	BIT(0)
+
 void __nmk_gpio_set_slpm(struct nmk_gpio_chip *nmk_chip, unsigned int offset,
 			 enum nmk_gpio_slpm mode)
 {
 	u32 slpm;
 
+	/* We should NOT have been called. */
+	if (WARN_ON(nmk_chip->quirk_mbly))
+		return;
+
 	slpm = readl(nmk_chip->addr + NMK_GPIO_SLPC);
 	if (mode == NMK_GPIO_SLPM_NOCHANGE)
 		slpm |= BIT(offset);
@@ -92,6 +104,9 @@ static void __nmk_gpio_irq_modify(struct nmk_gpio_chip *nmk_chip,
 		rimscval = &nmk_chip->rimsc;
 		fimscval = &nmk_chip->fimsc;
 	} else  {
+		/* We should NOT have been called. */
+		if (WARN_ON(nmk_chip->quirk_mbly))
+			return;
 		rimscreg = NMK_GPIO_RWIMSC;
 		fimscreg = NMK_GPIO_FWIMSC;
 		rimscval = &nmk_chip->rwimsc;
@@ -118,6 +133,10 @@ static void __nmk_gpio_irq_modify(struct nmk_gpio_chip *nmk_chip,
 static void __nmk_gpio_set_wake(struct nmk_gpio_chip *nmk_chip,
 				int offset, bool on)
 {
+	/* We should NOT have been called. */
+	if (WARN_ON(nmk_chip->quirk_mbly))
+		return;
+
 	/*
 	 * Ensure WAKEUP_ENABLE is on.  No need to disable it if wakeup is
 	 * disabled, since setting SLPM to 1 increases power consumption, and
@@ -142,7 +161,7 @@ static void nmk_gpio_irq_maskunmask(struct nmk_gpio_chip *nmk_chip,
 
 	__nmk_gpio_irq_modify(nmk_chip, d->hwirq, NORMAL, enable);
 
-	if (!(nmk_chip->real_wake & BIT(d->hwirq)))
+	if (!nmk_chip->quirk_mbly && !(nmk_chip->real_wake & BIT(d->hwirq)))
 		__nmk_gpio_set_wake(nmk_chip, d->hwirq, enable);
 
 	spin_unlock(&nmk_chip->lock);
@@ -174,6 +193,10 @@ static int nmk_gpio_irq_set_wake(struct irq_data *d, unsigned int on)
 	struct nmk_gpio_chip *nmk_chip = gpiochip_get_data(gc);
 	unsigned long flags;
 
+	/* Handler is registered in all cases. */
+	if (nmk_chip->quirk_mbly)
+		return -ENXIO;
+
 	clk_enable(nmk_chip->clk);
 	spin_lock_irqsave(&nmk_gpio_slpm_lock, flags);
 	spin_lock(&nmk_chip->lock);
@@ -212,7 +235,7 @@ static int nmk_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 	if (enabled)
 		__nmk_gpio_irq_modify(nmk_chip, d->hwirq, NORMAL, false);
 
-	if (enabled || wake)
+	if (!nmk_chip->quirk_mbly && (enabled || wake))
 		__nmk_gpio_irq_modify(nmk_chip, d->hwirq, WAKE, false);
 
 	nmk_chip->edge_rising &= ~BIT(d->hwirq);
@@ -226,7 +249,7 @@ static int nmk_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 	if (enabled)
 		__nmk_gpio_irq_modify(nmk_chip, d->hwirq, NORMAL, true);
 
-	if (enabled || wake)
+	if (!nmk_chip->quirk_mbly && (enabled || wake))
 		__nmk_gpio_irq_modify(nmk_chip, d->hwirq, WAKE, true);
 
 	spin_unlock_irqrestore(&nmk_chip->lock, flags);
@@ -359,6 +382,10 @@ static int nmk_gpio_get_mode(struct nmk_gpio_chip *nmk_chip, int offset)
 {
 	u32 afunc, bfunc;
 
+	/* We don't support modes. */
+	if (nmk_chip->quirk_mbly)
+		return NMK_GPIO_ALT_GPIO;
+
 	clk_enable(nmk_chip->clk);
 
 	afunc = readl(nmk_chip->addr + NMK_GPIO_AFSLA) & BIT(offset);
@@ -490,6 +517,7 @@ struct nmk_gpio_chip *nmk_gpio_populate_chip(struct device_node *np,
 	struct resource *res;
 	struct clk *clk;
 	void __iomem *base;
+	uintptr_t flags;
 	u32 id, ngpio;
 
 	gpio_pdev = of_find_device_by_node(np);
@@ -523,6 +551,8 @@ struct nmk_gpio_chip *nmk_gpio_populate_chip(struct device_node *np,
 		dev_dbg(&pdev->dev, "populate: using default ngpio (%d)\n", ngpio);
 	}
 
+	flags = (uintptr_t)of_device_get_match_data(&gpio_pdev->dev);
+	nmk_chip->quirk_mbly = !!(flags & NMK_GPIO_FLAG_QUIRK_MBLY);
 	nmk_chip->bank = id;
 	chip = &nmk_chip->chip;
 	chip->base = -1;
@@ -637,9 +667,11 @@ static int nmk_gpio_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	clk_enable(nmk_chip->clk);
-	nmk_chip->lowemi = readl_relaxed(nmk_chip->addr + NMK_GPIO_LOWEMI);
-	clk_disable(nmk_chip->clk);
+	if (!nmk_chip->quirk_mbly) {
+		clk_enable(nmk_chip->clk);
+		nmk_chip->lowemi = readl_relaxed(nmk_chip->addr + NMK_GPIO_LOWEMI);
+		clk_disable(nmk_chip->clk);
+	}
 
 	ret = gpiochip_add_data(chip, nmk_chip);
 	if (ret)
@@ -653,7 +685,13 @@ static int nmk_gpio_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id nmk_gpio_match[] = {
-	{ .compatible = "st,nomadik-gpio", },
+	{
+		.compatible = "st,nomadik-gpio",
+	},
+	{
+		.compatible = "mobileye,eyeq5-gpio",
+		.data = (void*)NMK_GPIO_FLAG_QUIRK_MBLY,
+	},
 	{}
 };
 
diff --git a/drivers/pinctrl/nomadik/pinctrl-nomadik.c b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
index 99bdb25f358d..d1c5f353c6a9 100644
--- a/drivers/pinctrl/nomadik/pinctrl-nomadik.c
+++ b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
@@ -1229,6 +1229,8 @@ static int nmk_pinctrl_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev,
 				"could not populate nmk chip struct - continue anyway\n");
 		of_node_put(gpio_np);
+		/* We are NOT compatible with mobileye,eyeq5-gpio. */
+		BUG_ON(nmk_chip->quirk_mbly);
 	}
 
 	prcm_np = of_parse_phandle(np, "prcm", 0);
diff --git a/include/linux/gpio/gpio-nomadik.h b/include/linux/gpio/gpio-nomadik.h
index 8f7bb756ad35..8d0134dd3771 100644
--- a/include/linux/gpio/gpio-nomadik.h
+++ b/include/linux/gpio/gpio-nomadik.h
@@ -58,6 +58,7 @@ struct nmk_gpio_chip {
 	spinlock_t lock;
 	raw_spinlock_t fake_lock;
 	bool sleepmode;
+	bool quirk_mbly;
 	/* Keep track of configured edges */
 	u32 edge_rising;
 	u32 edge_falling;

-- 
2.43.1


