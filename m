Return-Path: <linux-kernel+bounces-84901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DB386AD65
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E83FA28CCD9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CD115CD41;
	Wed, 28 Feb 2024 11:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QGJBqIHz"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEDD15A482;
	Wed, 28 Feb 2024 11:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709119712; cv=none; b=hRAxgJ3qV4S/3LEGG+cnPugwqtv5ZkB101RaxUXsA4Rj2IAKvkshTG+TaKmJ0dQQDDgYwlAcVqkn9F8EZJ9b9zL12kNUGH24/uy+bvMhqOCz5OsKjQD/g6z8FBc+xMD/ygcfir+YA2Dmw1bChGuEazVgVVGhiRAWBkfIWeINKug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709119712; c=relaxed/simple;
	bh=C8wzUiMMPN153dY2ai4SVgqCUlLyJb13QYhk4yIEGYQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ecYFAB/9wwRdfVPZTgswx+zh1vPWUFXTslmUdurqXkZloHtuKwMYBWSWOiN1b+oD8rJLVb1f0rGuinDU3K5HVqrHPR5j4ayNaeizOKHGn8pZ541GoqH33p7+zD6RHowc2QGwRZS2WR8NiWBR3g8rRJ7BlLznP+LHz/KqCw0aw9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QGJBqIHz; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1210B1BF20F;
	Wed, 28 Feb 2024 11:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709119708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FMmsOBRNX0bkvaPiwBdj1qqN+PLRV9gop71FqQuBE0g=;
	b=QGJBqIHzO6Rg3hNskxbVaNa1Mar9TPUqxHriIoRA4/4S1lfmKO8blzXGXzrhT6lRsIxQ8s
	C2MASwK831ppseqtyPAfg/IAdcSCEpodRIrOqHWR3Nov7jqARilh9qTIV9F5jHpN9YEXcu
	VNkdIeOJK91VbbZn65DuRjySkgpmaNLC3fUEAScwndn72za1Y42hNQJd2WEiypSZcSN1VK
	DhBV06JPj91MdZyK2r+xXhTsUx0U2nkFp45RvUpcVN0I4nqstIhkmTq4DOz1PTNDnMoiyW
	D+upTgKzygmoW147XtF5wL2j8F/N3gOv+moF77bLHkZTThHXgVUZ2+y3ulvhKg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 28 Feb 2024 12:28:22 +0100
Subject: [PATCH v2 24/30] gpio: nomadik: support mobileye,eyeq5-gpio
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240228-mbly-gpio-v2-24-3ba757474006@bootlin.com>
References: <20240228-mbly-gpio-v2-0-3ba757474006@bootlin.com>
In-Reply-To: <20240228-mbly-gpio-v2-0-3ba757474006@bootlin.com>
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
X-Mailer: b4 0.13.0
X-GND-Sasl: theo.lebrun@bootlin.com

We create a custom compatible for the STA2X11 IP block as integrated
into the Mobileye EyeQ5 platform. Its wake and alternate functions have
been disabled, we want to avoid touching those registers.

We both do: (1) early return in functions that do not support the
platform, but with warnings, and (2) avoid calling those functions in
the first place.

We ensure that pinctrl-nomadik is not used with this STA2X11 variant.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/gpio/Kconfig                      |  5 ++--
 drivers/gpio/gpio-nomadik.c               | 42 ++++++++++++++++++++++++++-----
 drivers/pinctrl/nomadik/pinctrl-nomadik.c |  2 ++
 include/linux/gpio/gpio-nomadik.h         |  1 +
 4 files changed, 42 insertions(+), 8 deletions(-)

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
index 19394dc7e34a..6adb3c4417d3 100644
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
@@ -37,6 +43,10 @@ void __nmk_gpio_set_slpm(struct nmk_gpio_chip *nmk_chip, unsigned int offset,
 {
 	u32 slpm;
 
+	/* We should NOT have been called. */
+	if (WARN_ON(nmk_chip->is_mobileye_soc))
+		return;
+
 	slpm = readl(nmk_chip->addr + NMK_GPIO_SLPC);
 	if (mode == NMK_GPIO_SLPM_NOCHANGE)
 		slpm |= BIT(offset);
@@ -93,6 +103,9 @@ static void __nmk_gpio_irq_modify(struct nmk_gpio_chip *nmk_chip,
 		rimscval = &nmk_chip->rimsc;
 		fimscval = &nmk_chip->fimsc;
 	} else  {
+		/* We should NOT have been called. */
+		if (WARN_ON(nmk_chip->is_mobileye_soc))
+			return;
 		rimscreg = NMK_GPIO_RWIMSC;
 		fimscreg = NMK_GPIO_FWIMSC;
 		rimscval = &nmk_chip->rwimsc;
@@ -119,6 +132,10 @@ static void __nmk_gpio_irq_modify(struct nmk_gpio_chip *nmk_chip,
 static void __nmk_gpio_set_wake(struct nmk_gpio_chip *nmk_chip,
 				int offset, bool on)
 {
+	/* We should NOT have been called. */
+	if (WARN_ON(nmk_chip->is_mobileye_soc))
+		return;
+
 	/*
 	 * Ensure WAKEUP_ENABLE is on.  No need to disable it if wakeup is
 	 * disabled, since setting SLPM to 1 increases power consumption, and
@@ -143,7 +160,7 @@ static void nmk_gpio_irq_maskunmask(struct nmk_gpio_chip *nmk_chip,
 
 	__nmk_gpio_irq_modify(nmk_chip, d->hwirq, NORMAL, enable);
 
-	if (!(nmk_chip->real_wake & BIT(d->hwirq)))
+	if (!nmk_chip->is_mobileye_soc && !(nmk_chip->real_wake & BIT(d->hwirq)))
 		__nmk_gpio_set_wake(nmk_chip, d->hwirq, enable);
 
 	spin_unlock(&nmk_chip->lock);
@@ -175,6 +192,10 @@ static int nmk_gpio_irq_set_wake(struct irq_data *d, unsigned int on)
 	struct nmk_gpio_chip *nmk_chip = gpiochip_get_data(gc);
 	unsigned long flags;
 
+	/* Handler is registered in all cases. */
+	if (nmk_chip->is_mobileye_soc)
+		return -ENXIO;
+
 	clk_enable(nmk_chip->clk);
 	spin_lock_irqsave(&nmk_gpio_slpm_lock, flags);
 	spin_lock(&nmk_chip->lock);
@@ -213,7 +234,7 @@ static int nmk_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 	if (enabled)
 		__nmk_gpio_irq_modify(nmk_chip, d->hwirq, NORMAL, false);
 
-	if (enabled || wake)
+	if (!nmk_chip->is_mobileye_soc && (enabled || wake))
 		__nmk_gpio_irq_modify(nmk_chip, d->hwirq, WAKE, false);
 
 	nmk_chip->edge_rising &= ~BIT(d->hwirq);
@@ -227,7 +248,7 @@ static int nmk_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 	if (enabled)
 		__nmk_gpio_irq_modify(nmk_chip, d->hwirq, NORMAL, true);
 
-	if (enabled || wake)
+	if (!nmk_chip->is_mobileye_soc && (enabled || wake))
 		__nmk_gpio_irq_modify(nmk_chip, d->hwirq, WAKE, true);
 
 	spin_unlock_irqrestore(&nmk_chip->lock, flags);
@@ -357,6 +378,10 @@ static int nmk_gpio_get_mode(struct nmk_gpio_chip *nmk_chip, int offset)
 {
 	u32 afunc, bfunc;
 
+	/* We don't support modes. */
+	if (nmk_chip->is_mobileye_soc)
+		return NMK_GPIO_ALT_GPIO;
+
 	clk_enable(nmk_chip->clk);
 
 	afunc = readl(nmk_chip->addr + NMK_GPIO_AFSLA) & BIT(offset);
@@ -523,6 +548,8 @@ struct nmk_gpio_chip *nmk_gpio_populate_chip(struct device_node *np,
 		dev_dbg(&pdev->dev, "populate: using default ngpio (%d)\n", ngpio);
 	}
 
+	nmk_chip->is_mobileye_soc = device_is_compatible(gpio_dev,
+							 "mobileye,eyeq5-gpio");
 	nmk_chip->bank = id;
 	chip = &nmk_chip->chip;
 	chip->base = -1;
@@ -636,9 +663,11 @@ static int nmk_gpio_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	clk_enable(nmk_chip->clk);
-	nmk_chip->lowemi = readl_relaxed(nmk_chip->addr + NMK_GPIO_LOWEMI);
-	clk_disable(nmk_chip->clk);
+	if (!nmk_chip->is_mobileye_soc) {
+		clk_enable(nmk_chip->clk);
+		nmk_chip->lowemi = readl_relaxed(nmk_chip->addr + NMK_GPIO_LOWEMI);
+		clk_disable(nmk_chip->clk);
+	}
 
 	ret = gpiochip_add_data(chip, nmk_chip);
 	if (ret)
@@ -653,6 +682,7 @@ static int nmk_gpio_probe(struct platform_device *pdev)
 
 static const struct of_device_id nmk_gpio_match[] = {
 	{ .compatible = "st,nomadik-gpio", },
+	{ .compatible = "mobileye,eyeq5-gpio", },
 	{}
 };
 
diff --git a/drivers/pinctrl/nomadik/pinctrl-nomadik.c b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
index 5633f0ec2715..7849144b3b80 100644
--- a/drivers/pinctrl/nomadik/pinctrl-nomadik.c
+++ b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
@@ -1230,6 +1230,8 @@ static int nmk_pinctrl_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev,
 				"could not populate nmk chip struct - continue anyway\n");
 		of_node_put(gpio_np);
+		/* We are NOT compatible with mobileye,eyeq5-gpio. */
+		BUG_ON(nmk_chip->is_mobileye_soc);
 	}
 
 	prcm_np = of_parse_phandle(np, "prcm", 0);
diff --git a/include/linux/gpio/gpio-nomadik.h b/include/linux/gpio/gpio-nomadik.h
index 0166ddb71f43..9bdb09fda4c9 100644
--- a/include/linux/gpio/gpio-nomadik.h
+++ b/include/linux/gpio/gpio-nomadik.h
@@ -57,6 +57,7 @@ struct nmk_gpio_chip {
 	void (*set_ioforce)(bool enable);
 	spinlock_t lock;
 	bool sleepmode;
+	bool is_mobileye_soc;
 	/* Keep track of configured edges */
 	u32 edge_rising;
 	u32 edge_falling;

-- 
2.44.0


