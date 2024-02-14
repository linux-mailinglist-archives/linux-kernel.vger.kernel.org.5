Return-Path: <linux-kernel+bounces-65524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CD6854E37
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27422B2B56A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90E160DEE;
	Wed, 14 Feb 2024 16:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ivwwZO/w"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCF860273;
	Wed, 14 Feb 2024 16:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707927899; cv=none; b=rWBQDThtFJsqlastNSH5Yp527Hm0iSIDFHrUGqOuvuLAi6+KOFeLjod95JbDZpnG+SQFPZ0JcTCXwnqY96ppOWxKNm1bR1Y22sXIkSuy2eTg94+oFHZU1utyPq6san9H/FKQdGO2n0O324aFMUodZgB55X2yo8JNbx4wvPX6xTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707927899; c=relaxed/simple;
	bh=U6k7W5Fq1n6gOOX+p+GbRgpWwthVriHT6YvEE+eq5Lo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N/isFTxe7oSTLe0JufD9uivzo3xU1cQJxn62pO6vNdOYFTCIF8AZNmHV6DXFw4PUKUm59NyNx/5GTyv48KTT3r0psB4SdwECKoxVlL+3B81gJSIyWx46rlTZLN5A1VaOvLddv0Ct+DjIenEEA76D5TzhMAxPbryuenq8N3gQRpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ivwwZO/w; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 68C2460015;
	Wed, 14 Feb 2024 16:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707927895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dcSANx3V5HdwU4Q2yUKOyMI1Lkb0mNogZZKZ/7YW7Iw=;
	b=ivwwZO/wnK/bEX6lRTc1LAq3zZ5nLTyL8+7z+AAYbE1a2gacSSJg8WNwwn3r2Pi0g2NZAD
	3oLKILX1aaGhweoAacTygOqu46XPXagdVvzJq230hYknwEEUGsMsRxc0xZkHZ+n+eaCFHQ
	2cNeImyXZBETSPPiZY8/0BaAg63bVCsOdu5hqHlJ4b5wUBMsks4iFtUcjF1MT1b7ZmVEwj
	5GCra9LpMA5stkZHgqggyTs2dBnZ+x57fu4UfbNDY1UviENn6G5R5uctQaIIPGiDP8ZMAf
	S0S1zHvgrphIMJ1ccOLyy7POnlfYoXmF3BhChcQnyVYy2BfHWzvrBmYJEPSzmg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 14 Feb 2024 17:24:07 +0100
Subject: [PATCH 14/23] gpio: nomadik: make clock optional
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240214-mbly-gpio-v1-14-f88c0ccf372b@bootlin.com>
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

Not all platforms using this platform driver expose a clock for this
GPIO controller. Turn clk_get() into clk_get_optional() to avoid
failing when no clocks are provided.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/gpio/gpio-nomadik.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-nomadik.c b/drivers/gpio/gpio-nomadik.c
index 8d47aef8d2c4..2e7d3840b714 100644
--- a/drivers/gpio/gpio-nomadik.c
+++ b/drivers/gpio/gpio-nomadik.c
@@ -529,7 +529,7 @@ struct nmk_gpio_chip *nmk_gpio_populate_chip(struct device_node *np,
 	}
 	nmk_chip->addr = base;
 
-	clk = clk_get(&gpio_pdev->dev, NULL);
+	clk = clk_get_optional(&gpio_pdev->dev, NULL);
 	if (IS_ERR(clk)) {
 		platform_device_put(gpio_pdev);
 		return (void *)clk;

-- 
2.43.1


