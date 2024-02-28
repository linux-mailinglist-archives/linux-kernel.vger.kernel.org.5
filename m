Return-Path: <linux-kernel+bounces-84891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5D986AD36
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 845D51F22D5B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78892153518;
	Wed, 28 Feb 2024 11:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dyEF1nRs"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA3D1420D0;
	Wed, 28 Feb 2024 11:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709119706; cv=none; b=gkY9Mr4zIO8PJpDOn9FteN9jFI2KHh4IbdgxXGKmn/35vNc1q+toULSIXt7tgPRVKHmfBLUxtc3wXPPRjm0Tc8YFGCKqi+qKHp2mnPwa9vod5UBhiX23NVl7ES6Hrio1UQgAY2yK3E6x1bVFUf5VHgHDvmiramuRlJOOl/xVCcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709119706; c=relaxed/simple;
	bh=O3eMSu40fMZuZcdZREanAgltxZLpQq8CYwl9qWdWfIc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LZtdfExljw3shbonCWIFqqqywoSnp9NnQdR49FxNj40hKSgTSSMIrOGkU+cU4RfcAfXRM5IPWy04MDCg2YPtrkv+THe9Smvo5FhMBZcSeUG7AFWwVYQTahNJOh+WgKnrjesOq3VTwdEAsE4FhMdKTXVVLUQXwYKR9SXlSIYQ/xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dyEF1nRs; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4D7B21BF20D;
	Wed, 28 Feb 2024 11:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709119701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c75kgKOiYHpbQtix7uno8/XdcHRwYzLdGlRcddNvHAw=;
	b=dyEF1nRs6W8USi7Wll44T3bf/F3aSNNi0evKR7LL09TL3L+d7KaIjAwLkPy0b0waIERjWj
	wt5ZrEPm5Mkg+/F/7u8JdxvE/doQuPzMkjadC6YtE0IgagJzdGKq8Oj8S1HUGwJKZRUpmx
	ZU/62WVI3i334NRCxpFrCU2lmmSg7JoBTarQI/NgP0M9TEM5CVFRcuzgJaXy8Ol3vFHFfW
	/7Sa2eChLSNQVk8qbg1J7jipIGn8MThz7Mehs0gqpsv8rJ5agzWrYoS9moaKwORgpojIqT
	lQcH7sy6eo6xK8RFCBkiQhFPxY0TjEaLZeSBVJ0Tz9RvPDDtSJEGWw+KSXsjCw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 28 Feb 2024 12:28:13 +0100
Subject: [PATCH v2 15/30] gpio: nomadik: replace of_find_*() by
 bus_find_device_by_of_node()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240228-mbly-gpio-v2-15-3ba757474006@bootlin.com>
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

Avoid OF APIs in the GPIO subsystem. Here, replace
of_find_device_by_node() call by bus_find_device_by_of_node().

The new helper returns a struct device pointer. Store it in a new local
variable and use it down the road.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/gpio/gpio-nomadik.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-nomadik.c b/drivers/gpio/gpio-nomadik.c
index 9347c93af62c..f3ef3b4d08eb 100644
--- a/drivers/gpio/gpio-nomadik.c
+++ b/drivers/gpio/gpio-nomadik.c
@@ -483,17 +483,20 @@ struct nmk_gpio_chip *nmk_gpio_populate_chip(struct device_node *np,
 {
 	struct nmk_gpio_chip *nmk_chip;
 	struct platform_device *gpio_pdev;
+	struct device *gpio_dev;
 	struct gpio_chip *chip;
 	struct resource *res;
 	struct clk *clk;
 	void __iomem *base;
 	u32 id;
 
-	gpio_pdev = of_find_device_by_node(np);
-	if (!gpio_pdev) {
+	gpio_dev = bus_find_device_by_of_node(&platform_bus_type, np);
+	if (!gpio_dev) {
 		pr_err("populate \"%pOFn\": device not found\n", np);
 		return ERR_PTR(-ENODEV);
 	}
+	gpio_pdev = to_platform_device(gpio_dev);
+
 	if (of_property_read_u32(np, "gpio-bank", &id)) {
 		dev_err(&pdev->dev, "populate: gpio-bank property not found\n");
 		platform_device_put(gpio_pdev);
@@ -519,8 +522,8 @@ struct nmk_gpio_chip *nmk_gpio_populate_chip(struct device_node *np,
 	chip = &nmk_chip->chip;
 	chip->base = id * NMK_GPIO_PER_CHIP;
 	chip->ngpio = NMK_GPIO_PER_CHIP;
-	chip->label = dev_name(&gpio_pdev->dev);
-	chip->parent = &gpio_pdev->dev;
+	chip->label = dev_name(gpio_dev);
+	chip->parent = gpio_dev;
 
 	res = platform_get_resource(gpio_pdev, IORESOURCE_MEM, 0);
 	base = devm_ioremap_resource(&pdev->dev, res);
@@ -530,7 +533,7 @@ struct nmk_gpio_chip *nmk_gpio_populate_chip(struct device_node *np,
 	}
 	nmk_chip->addr = base;
 
-	clk = clk_get(&gpio_pdev->dev, NULL);
+	clk = clk_get(gpio_dev, NULL);
 	if (IS_ERR(clk)) {
 		platform_device_put(gpio_pdev);
 		return (void *)clk;

-- 
2.44.0


