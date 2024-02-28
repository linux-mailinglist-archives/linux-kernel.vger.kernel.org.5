Return-Path: <linux-kernel+bounces-84892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5F986AD39
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD2931C21452
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE100155307;
	Wed, 28 Feb 2024 11:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PP1gpCD0"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D8F145B3F;
	Wed, 28 Feb 2024 11:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709119706; cv=none; b=iXsoYT+26EkUrgE6xXF1KmbyCdVRee2xSksrKirHglswSyTtewFjSj48bO7SKygC8eU3t8PUrzSrjjPkfkQo/aM7sVcVGfKxWbJ2dFoNpmijhjCnrD36zOTzdlaBLn517RXXJejhYKsEp9HZsS7XbIwZO8oOmClY/pabIUSXvHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709119706; c=relaxed/simple;
	bh=gU9cgFP1eW1ErSI0tVUIno18z4mihP0BGkwcTO3apZs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bt0/e5GLM7NdsDEQqlMXVTTuxdyF037Va1xPr2CBXpm6qgDDN/tU43jIqjDPpxEvSaKFpYBrCe+puFU5RonS9/xBTDC6RHh+S5rySREROru7EgVOIBV8kT/IqsWsf9vIw7MIkE6Mx/Qx6a1T+5F51rL4bT0xYZB4mzhNBIsgl/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PP1gpCD0; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 07A861BF216;
	Wed, 28 Feb 2024 11:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709119702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R3+PrmUdd2JxDTzSX+hLtESErBB0gvWqKNs59dVKhlg=;
	b=PP1gpCD0nIoqW9wwkVhZc7WMU1fSYlTP1LZ7XicD/2IMB9mknsnzgf8+wwHjUeQZttCarg
	sHoXgb+Zr8a38CcTpqRNAlYSWuUYrLl5BswX3jR2YJzRvpnXztjZEKXQPW7lmQXOObwQ/P
	NaTpg9M5vet0Lyuk7xgAPOZDX2xkcNSUW7wWyA+vluJMXWzq3lrSvmEgqt/oaMF5jQgtDJ
	7oM6s7hlFeZn/DdfFJIbMPdKMJTutQP+Sb+Hzu1O6cOWukDb1YBI6hD/8Z5+79MV9EkRym
	OJmb2TtYiMHo7E5aJ9z8l49yPgZft6mfCmJoOUeWAJl/+oyc8xeMyPqzKnM5Lg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 28 Feb 2024 12:28:14 +0100
Subject: [PATCH v2 16/30] gpio: nomadik: replace of_property_read_*() by
 device_property_read_*()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240228-mbly-gpio-v2-16-3ba757474006@bootlin.com>
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
of_property_read_{u32,bool}() call by device_property_read_{u32,bool}().

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/gpio/gpio-nomadik.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-nomadik.c b/drivers/gpio/gpio-nomadik.c
index f3ef3b4d08eb..bba183c0b597 100644
--- a/drivers/gpio/gpio-nomadik.c
+++ b/drivers/gpio/gpio-nomadik.c
@@ -497,7 +497,7 @@ struct nmk_gpio_chip *nmk_gpio_populate_chip(struct device_node *np,
 	}
 	gpio_pdev = to_platform_device(gpio_dev);
 
-	if (of_property_read_u32(np, "gpio-bank", &id)) {
+	if (device_property_read_u32(gpio_dev, "gpio-bank", &id)) {
 		dev_err(&pdev->dev, "populate: gpio-bank property not found\n");
 		platform_device_put(gpio_pdev);
 		return ERR_PTR(-EINVAL);
@@ -587,7 +587,7 @@ static int nmk_gpio_probe(struct platform_device *dev)
 	}
 
 	supports_sleepmode =
-		of_property_read_bool(np, "st,supports-sleepmode");
+		device_property_read_bool(dev, "st,supports-sleepmode");
 
 	/* Correct platform device ID */
 	dev->id = nmk_chip->bank;

-- 
2.44.0


