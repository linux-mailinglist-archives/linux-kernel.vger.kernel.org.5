Return-Path: <linux-kernel+bounces-65527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DA0854E43
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 044301F213B9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BF8612E6;
	Wed, 14 Feb 2024 16:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KDUEmIGK"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAC560BA5;
	Wed, 14 Feb 2024 16:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707927901; cv=none; b=PJcVnfevy9IEouJffrpevQ+9Uxv7QqlNKuG7dM7K2wGJc5SsDCgzX071/6VVy9TXmmGm+xpDniMgg9Orf5Xkptt0wWxW0td4GgbwpU4agwLS/Q8XHKpQBpED49GZBDqghferw+Dtnl1qJ28GtAaU7+Zp71wiNojUMQvUNGm67Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707927901; c=relaxed/simple;
	bh=4p/q1upzUmGBHDVdiIWRLWepvE6bL1nLmhXsDRF2978=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SHzVJXe441Aq+iytLdXatINFad5RwzVztdHThIUVGPZrMurisRvxkU11mrRvR5Mym6Fh/wPWyarLa0TQ1o30V/vwAcouNqmtL37W4lGivxlHaaMV4A2zkSH2YVPHG5Y+lueeVgZesHfEz0ZzIQX8xbkqJEkhmrSVPTv4Pnbl/EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KDUEmIGK; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A1E0A6000A;
	Wed, 14 Feb 2024 16:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707927897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fLUHnKwkOTd/IZBZWn2NU/F1aOSU/MFfTb5Afq/ZxpU=;
	b=KDUEmIGKKiQDc+J8thUyJZBerQLKaPdgsNZr7DehO3Rhy5toF0HOTW1YOrn6nNzpcrwGN/
	oj9RuY99yzMjMvxcyvxgwWqUSoMKptuu7bduNmiuGAKVM3Re4ZOny3YU5b7NB7W9gzzeuw
	k33u0eePU0RATJdE7JonqNNPXucIs6ejOm2U5fUcEKFFyXpmn2mkZ7pFCrSMmvW9idAeWz
	Y2T2Yi72fUlewtLa4z06hJwGuJawSbt7RnZ6Gy41wxK5FFHsjRHDzjBJgWivUbu/U3FBz7
	x4txLn3YXqhc6ep62U95osgQi7VjQ9VItfL/Y0bpXCrB4T0eMFp3RSWp5dOnZQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 14 Feb 2024 17:24:10 +0100
Subject: [PATCH 17/23] gpio: nomadik: handle variadic GPIO count
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240214-mbly-gpio-v1-17-f88c0ccf372b@bootlin.com>
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

Read the "ngpios" device-tree property to determine the number of GPIOs
for a bank. If not available, fallback to NMK_GPIO_PER_CHIP ie 32 ie
the current behavior.

The IP block always supports 32 GPIOs, but platforms can expose a lesser
amount. The Mobileye EyeQ5 is in this case; one bank is 29 GPIOs and
the other is 23.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/gpio/gpio-nomadik.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-nomadik.c b/drivers/gpio/gpio-nomadik.c
index 5b1e3b3efcff..02b53c58adf7 100644
--- a/drivers/gpio/gpio-nomadik.c
+++ b/drivers/gpio/gpio-nomadik.c
@@ -490,7 +490,7 @@ struct nmk_gpio_chip *nmk_gpio_populate_chip(struct device_node *np,
 	struct resource *res;
 	struct clk *clk;
 	void __iomem *base;
-	u32 id;
+	u32 id, ngpio;
 
 	gpio_pdev = of_find_device_by_node(np);
 	if (!gpio_pdev) {
@@ -518,10 +518,15 @@ struct nmk_gpio_chip *nmk_gpio_populate_chip(struct device_node *np,
 		return ERR_PTR(-ENOMEM);
 	}
 
+	if (of_property_read_u32(np, "ngpios", &ngpio)) {
+		ngpio = NMK_GPIO_PER_CHIP;
+		dev_dbg(&pdev->dev, "populate: using default ngpio (%d)\n", ngpio);
+	}
+
 	nmk_chip->bank = id;
 	chip = &nmk_chip->chip;
 	chip->base = -1;
-	chip->ngpio = NMK_GPIO_PER_CHIP;
+	chip->ngpio = ngpio;
 	chip->label = dev_name(&gpio_pdev->dev);
 	chip->parent = &gpio_pdev->dev;
 

-- 
2.43.1


