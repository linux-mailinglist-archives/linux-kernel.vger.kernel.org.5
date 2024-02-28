Return-Path: <linux-kernel+bounces-84894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F79B86AD42
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 561971F21F67
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D363B158D71;
	Wed, 28 Feb 2024 11:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="c/BsSpnm"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A218148FE5;
	Wed, 28 Feb 2024 11:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709119707; cv=none; b=Diwos9nXIPavWuoKBgjAQA5r0feDGJLyJPRqSsijzPkxaPFL0WB3wrGoKJ5PbFOruZx5JzVjDM2DFpMLcebrm76q8AAtl29C+xm5KOON/NLMBbOmAQJgBWa8gq7h2RWGYIDexbgbBbZ58ztHdCug2uwMjoUM6FIaDJycfeSPiJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709119707; c=relaxed/simple;
	bh=OgwMaM+b8GH6uKY4FpjQxJ75kX/7bDkjfIEFjJ3pA/s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oFnS9sFk2LBHsoyigv34IqtXUlYmk+0uRDKE4Ymlh5FDjpiuNXv2ZP52n7gGJcXAMD4tIRaltP4pvi1++0844P35o3m+9iLx4gsVGMUWKgLirOqmxTFYitNJ9iGZW99qbSbv57X/o5Lr3GZ//dXSTTrxZPWK4P+Khf5PBiSOZH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=c/BsSpnm; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A6A491BF21A;
	Wed, 28 Feb 2024 11:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709119703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E0ZmgzMXKbmkgBa8vxJZo+tPY2HqLbOAvRCSZwlQWL0=;
	b=c/BsSpnm7nh6f7Cx1rg0yF82sBXXPq5tkaVYmHW+h+5QsLX71uzOesLUMMfyw/fwwsIeWR
	mK1ZdFaPAhnpDreF8D0jt7PIyOJVdqrDos2vBW82GMFv0+xQzMujFO48A2H+TEctczqWov
	PyUBoyne04uIcilLPWGSaJf/lo5rJkd2QnelZeFuQ2/EEoybqeUjHjRKTdRpQ7TURxuJFj
	V6KUJSy2tCqGkb+cEnoujv10JQKFwzIZqt3d9h8YuDtgAg57GK4Uf9KgVV5Oa4sMqFjfHY
	YW22LBUCyt/UnOtRh/wuMaZD+R5Ki2RMz8nB6sAqvqtJokzED7bCe0A5hHgrrQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 28 Feb 2024 12:28:15 +0100
Subject: [PATCH v2 17/30] gpio: nomadik: use
 devm_platform_ioremap_resource() helper
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240228-mbly-gpio-v2-17-3ba757474006@bootlin.com>
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

Replace calls to platform_get_resource() then devm_ioremap_resource() by
a single call to devm_platform_ioremap_resource().

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/gpio/gpio-nomadik.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-nomadik.c b/drivers/gpio/gpio-nomadik.c
index bba183c0b597..93015fa3d010 100644
--- a/drivers/gpio/gpio-nomadik.c
+++ b/drivers/gpio/gpio-nomadik.c
@@ -485,7 +485,6 @@ struct nmk_gpio_chip *nmk_gpio_populate_chip(struct device_node *np,
 	struct platform_device *gpio_pdev;
 	struct device *gpio_dev;
 	struct gpio_chip *chip;
-	struct resource *res;
 	struct clk *clk;
 	void __iomem *base;
 	u32 id;
@@ -525,8 +524,7 @@ struct nmk_gpio_chip *nmk_gpio_populate_chip(struct device_node *np,
 	chip->label = dev_name(gpio_dev);
 	chip->parent = gpio_dev;
 
-	res = platform_get_resource(gpio_pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(&pdev->dev, res);
+	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base)) {
 		platform_device_put(gpio_pdev);
 		return ERR_CAST(base);

-- 
2.44.0


