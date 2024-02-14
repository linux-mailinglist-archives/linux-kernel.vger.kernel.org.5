Return-Path: <linux-kernel+bounces-65529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B62854E48
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35AB6281029
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D538C651BC;
	Wed, 14 Feb 2024 16:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cI045bFG"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89B060ED6;
	Wed, 14 Feb 2024 16:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707927903; cv=none; b=K+eqi+UVy4kRHkOz632wZi0aeKyxpsG32hEXdZP5haHAnzKWKKWx1f0z2ZljMMbj6vDPfUa9XA3EaneoRvWf9lRY3rMQous+dYWi3xaHnPU9br+S1LKSxtS5M/12AIojDCU2Yg1YqNT2DNG1wDUHEuS2tpxeuCqLYec2BkTr8zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707927903; c=relaxed/simple;
	bh=EkUy1nLA54mqJAK3tbxLB1hjTfBhVrxe499dx0UqNZA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h7oAb0tp2nUHcXJCc6Tw6SnKa743sWSSixZhICbdENZLjb48E2wQAlLBxYtlFwb7Vjd05yjluk1x8BsnLL0DxrxkluedaI6tm9xEgIYltZEmtUol608FsE/ucoa46EPSNYEGrOlyoHSr4oA9STQ+ukoeBPrPed+VT0SzrdYuAsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cI045bFG; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4421260014;
	Wed, 14 Feb 2024 16:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707927898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mx4eKIZP1RNoV0SR3mSA7oSrFxZZeflSCi2iKWG97hE=;
	b=cI045bFGJ4BuGYDauc4UkQ7+0nOEpMIy2Xt63ULUOQ3URiqZVQmI/gWv7ASp4wxJIslF52
	ZH9fYiz2QugxJevAtu7CVq8glHjnROrkN/p24YzXgpQn8Y0Dg6A7QTdqxG5tQvLU0ja/a9
	3QhYPzvUE3MEnZOWtcq54b8t98xgqnWXv2ZZhgma6XKJvmZofdSFl56JY0nCpFMS4h+Vvv
	FxHWeN9mOODUsxPOjJ3csp2TMobDKhdMN3S+B6prc6E2RrwNtA87/307cwNMw71DCTxWf6
	/gr6YhDEj+R+EvT217bkhiErkUddlljihWIPiqLtay4chhMhY90Aevffb+j+xA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 14 Feb 2024 17:24:12 +0100
Subject: [PATCH 19/23] gpio: nomadik: grab optional reset control and
 deassert it at probe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240214-mbly-gpio-v1-19-f88c0ccf372b@bootlin.com>
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

Fetch a reference to the optional shared reset control and deassert it
if it exists.

Optional because not all platforms that use this driver have a reset
attached to the reset block. Shared because some platforms that use the
reset (at least Mobileye EyeQ5) share the reset across banks.

Do not keep a reference to the reset control as it is not needed
afterwards; the driver does not handle suspend, does not use runtime PM
and does not register a remove callback.

The operation is done in nmk_gpio_populate_chip(). This function is
called by either gpio-nomadik or pinctrl-nomadik, whoever comes first.
This is here for historic reasons and could probably be removed now; it
seems gpio-ranges enforces the ordering to be pinctrl-first. It is not
the topic of the present patch however.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/gpio/gpio-nomadik.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpio/gpio-nomadik.c b/drivers/gpio/gpio-nomadik.c
index 21bb6d6363fc..b623c093b54d 100644
--- a/drivers/gpio/gpio-nomadik.c
+++ b/drivers/gpio/gpio-nomadik.c
@@ -513,12 +513,14 @@ struct nmk_gpio_chip *nmk_gpio_populate_chip(struct device_node *np,
 {
 	struct nmk_gpio_chip *nmk_chip;
 	struct platform_device *gpio_pdev;
+	struct reset_control *reset;
 	struct gpio_chip *chip;
 	struct resource *res;
 	struct clk *clk;
 	void __iomem *base;
 	uintptr_t flags;
 	u32 id, ngpio;
+	int ret;
 
 	gpio_pdev = of_find_device_by_node(np);
 	if (!gpio_pdev) {
@@ -576,6 +578,19 @@ struct nmk_gpio_chip *nmk_gpio_populate_chip(struct device_node *np,
 	clk_prepare(clk);
 	nmk_chip->clk = clk;
 
+	reset = devm_reset_control_get_optional_shared(&gpio_pdev->dev, NULL);
+	if (IS_ERR(reset)) {
+		dev_err(&pdev->dev, "failed getting reset control: %ld\n",
+			PTR_ERR(reset));
+		return ERR_CAST(reset);
+	}
+
+	ret = reset_control_deassert(reset);
+	if (ret) {
+		dev_err(&pdev->dev, "failed reset deassert: %d\n", ret);
+		return ERR_PTR(ret);
+	}
+
 #ifdef CONFIG_PINCTRL_NOMADIK
 	BUG_ON(nmk_chip->bank >= ARRAY_SIZE(nmk_gpio_chips));
 	nmk_gpio_chips[id] = nmk_chip;

-- 
2.43.1


