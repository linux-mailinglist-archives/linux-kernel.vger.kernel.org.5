Return-Path: <linux-kernel+bounces-84879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFE886AD03
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15EDD1F22EDA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02BF1384A9;
	Wed, 28 Feb 2024 11:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gPghGJ2l"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCD612EBF4;
	Wed, 28 Feb 2024 11:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709119701; cv=none; b=MycEEsABjeYNYC5Y6TI8K8W9ydIS6tyeIlPf2jCqVhN+i67bHEYtn+9Qr0iXjCWDO84njniq1MnUDwPEWKCcFOqWNIABLZBJ8GojtOBSD+VhsE6KRaNh5tQYj3ZfL8RuWkbQVDa50rMvgOe3y1g7VwRcPrtyTCvyWsYKIfkhrNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709119701; c=relaxed/simple;
	bh=NUu8zN6xqrju2bNcfPvo4/Zo8f0Ipw0pbnNHUKylwzM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X3mmt+XF6noWc/24ZQZB6c6cjdv6H3wCMjeScEroJ+J4aEds1u52TJM9Qm7SlaXwCbMW1D6B19RReEBQodHnNdxLHR+gDIRi3Wd//zlfanwnAWxB4YVEwYRig58rlIzHs/pI2T78Pg2I6Pyg08Tdq+GlAesG7vrpKWn1Wphum/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gPghGJ2l; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DE5261BF216;
	Wed, 28 Feb 2024 11:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709119697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7uQzyRzXBi1cM/sDEW5ZhksCKgQRrZdcLK2Y5fiRh7o=;
	b=gPghGJ2likpuh6bn3kGEI10IWheNaKjcSOf+/rMK/FnqFTWFDFtHZSGRxS84PSHtjTrTje
	Xw2ExCe6nBHnQp/5U97ND92n2LfvXmgsV+/d8+/bbdx2+wilCAvBRdRReyik4jsYxNpjTT
	qbfXcZRKlsTy140Iga9TKjZU7e0GwhoDR1dboDSf1mIQ4mzVM+OUAynXh80t7r2t+ob85S
	YpDLl7CiZIAXcb6iKSN5fS4u4tYExLRIX5uT0qspwvcX5T/f+7BH+6tMd5fmhGWpD7YY+F
	Q847SWHnWM+MDaT1c2MdeN6dPzF6MycwJdQI2QFA9HjLy/cZ6i9zNlQn3Lipiw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 28 Feb 2024 12:28:07 +0100
Subject: [PATCH v2 09/30] pinctrl: nomadik: fix build warning
 (-Wpointer-to-int-cast)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240228-mbly-gpio-v2-9-3ba757474006@bootlin.com>
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

Fix compiler warning found in the pinctrl-nomadik platform driver. GCC
message is as such:

drivers/pinctrl/nomadik/pinctrl-nomadik.c:1169:12: warning: cast from
pointer to integer of different size [-Wpointer-to-int-cast]

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/pinctrl/nomadik/pinctrl-nomadik.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/nomadik/pinctrl-nomadik.c b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
index 1be0c48712b7..c8d2699be985 100644
--- a/drivers/pinctrl/nomadik/pinctrl-nomadik.c
+++ b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
@@ -1176,14 +1176,14 @@ static int nmk_pinctrl_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	struct device_node *prcm_np;
 	struct nmk_pinctrl *npct;
-	unsigned int version = 0;
+	uintptr_t version = 0;
 	int i;
 
 	npct = devm_kzalloc(&pdev->dev, sizeof(*npct), GFP_KERNEL);
 	if (!npct)
 		return -ENOMEM;
 
-	version = (unsigned int)device_get_match_data(&pdev->dev);
+	version = (uintptr_t)device_get_match_data(&pdev->dev);
 
 	/* Poke in other ASIC variants here */
 	if (version == PINCTRL_NMK_STN8815)

-- 
2.44.0


