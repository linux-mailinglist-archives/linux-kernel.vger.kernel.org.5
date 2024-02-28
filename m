Return-Path: <linux-kernel+bounces-84902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D727D86AD67
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D59F1F292A9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD3A15CD51;
	Wed, 28 Feb 2024 11:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="k/iehBZp"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BF915A4BA;
	Wed, 28 Feb 2024 11:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709119713; cv=none; b=FtRJn01CCJXh+yZgfE1x1Mxa9SSB+biWGWDNQlyjyYC86pa5lW+tsJuMhL8uw0Q70/XU5WbCIKbmNmXBR93HQQCEg6Z5UZoFQLRyyWZ+Mak2aAGSSs45nbx1Eg9sLCierNoIeWhrxBvCqBcbz9MTbBD6wQfH4hI5raPY3ohsJ1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709119713; c=relaxed/simple;
	bh=P+PS9P5cePM2VctJfuVuc5xinmTQv+oenygZVIJyQ+I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nBrvEoKKYhs6prY552QIvG9YYMyt06e4ac4aPavRUIK2NdDan41PFchQX/fru7cGNpOZpCEkikeOVxvGsM7HH8W7q4Ogc2jK/NG1zX3i0WRh4w+bTnPGZO6/YYIMgc+zrgh3HddNlTxgaDfOOFv8JxNb9gPwDPKHXXsSAyV/0BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=k/iehBZp; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BA1DE1BF203;
	Wed, 28 Feb 2024 11:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709119709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7c9tumQQXuG4HieeWpZE+FRQlT5QELiXjdV48vp4z3o=;
	b=k/iehBZporOFOkjyRzIBzHutL0jHTIkX2HF3wMsXMUDCXGPWYoOJpPgmPxTVhcidxY/Ak6
	Ju2GfeYXaBaNfnjii+TahW7TfEjhmKAvzBhJPHVJQMbQNtVs8WdhgIZF/wPYMaYINCNtPo
	HZXvCqXq2xEVWTMCSuzoVTLCiROviRrjPg/K7BimabQnIgzfawdqndMac5gUeuXxcpMYZr
	hpG0MfmwAozmxgPzbx07LrSSDrpHBeYg2b/vG7k13Jt1WWyZ+msOIfjRUh94rfXxAHbAGv
	b+BRVh/pM9K0L61U5Ax+UaxSqnRuga+M/jrpRcd4pTxJBSQsfTLcvhEfuInLgA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 28 Feb 2024 12:28:23 +0100
Subject: [PATCH v2 25/30] gpio: nomadik: grab optional reset control and
 deassert it at probe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240228-mbly-gpio-v2-25-3ba757474006@bootlin.com>
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

Fetch a reference to the optional shared reset control and deassert it
if it exists.

Optional because not all platforms that use this driver have a reset
attached to the reset block. Shared because some platforms that use the
reset (at least Mobileye EyeQ5) share the reset across banks.

Do not keep a reference to the reset control as it is not needed
afterwards; the driver does not handle suspend, does not use runtime
PM, does not register a remove callback and does not support unbinding
from sysfs (made explicit with suppress_bind_attrs).

The operation is done in nmk_gpio_populate_chip(). This function is
called by either gpio-nomadik or pinctrl-nomadik, whoever comes first.
This is here for historic reasons and could probably be removed now; it
seems gpio-ranges enforces the ordering to be pinctrl-first. It is not
the topic of the present patch however.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/gpio/gpio-nomadik.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpio/gpio-nomadik.c b/drivers/gpio/gpio-nomadik.c
index 6adb3c4417d3..c9fd6631e0aa 100644
--- a/drivers/gpio/gpio-nomadik.c
+++ b/drivers/gpio/gpio-nomadik.c
@@ -509,11 +509,13 @@ struct nmk_gpio_chip *nmk_gpio_populate_chip(struct device_node *np,
 {
 	struct nmk_gpio_chip *nmk_chip;
 	struct platform_device *gpio_pdev;
+	struct reset_control *reset;
 	struct device *gpio_dev;
 	struct gpio_chip *chip;
 	struct clk *clk;
 	void __iomem *base;
 	u32 id, ngpio;
+	int ret;
 
 	gpio_dev = bus_find_device_by_of_node(&platform_bus_type, np);
 	if (!gpio_dev) {
@@ -572,6 +574,24 @@ struct nmk_gpio_chip *nmk_gpio_populate_chip(struct device_node *np,
 	clk_prepare(clk);
 	nmk_chip->clk = clk;
 
+	reset = devm_reset_control_get_optional_shared(gpio_dev, NULL);
+	if (IS_ERR(reset)) {
+		dev_err(&pdev->dev, "failed getting reset control: %ld\n",
+			PTR_ERR(reset));
+		return ERR_CAST(reset);
+	}
+
+	/*
+	 * Reset might be shared and asserts/deasserts calls are unbalanced. We
+	 * only support sharing this reset with other gpio-nomadik devices that
+	 * use this reset to ensure deassertion at probe.
+	 */
+	ret = reset_control_deassert(reset);
+	if (ret) {
+		dev_err(&pdev->dev, "failed reset deassert: %d\n", ret);
+		return ERR_PTR(ret);
+	}
+
 #ifdef CONFIG_PINCTRL_NOMADIK
 	BUG_ON(nmk_chip->bank >= ARRAY_SIZE(nmk_gpio_chips));
 	nmk_gpio_chips[id] = nmk_chip;
@@ -690,6 +710,7 @@ static struct platform_driver nmk_gpio_driver = {
 	.driver = {
 		.name = "nomadik-gpio",
 		.of_match_table = nmk_gpio_match,
+		.suppress_bind_attrs = true,
 	},
 	.probe = nmk_gpio_probe,
 };

-- 
2.44.0


