Return-Path: <linux-kernel+bounces-84895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8123F86AD43
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDC8AB22B7C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C0F158D9B;
	Wed, 28 Feb 2024 11:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DEbDrTeU"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C771B14A4D6;
	Wed, 28 Feb 2024 11:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709119708; cv=none; b=Tlrzl8IRKXWNvNLxmx98pcwgLwNgsctbHq441JSz/7mm49WNog7fSfc8U4pj09DJqTRCtSh6849NoipyvqhrbVCSREpqDxbXOe5MUxms5Gtr78Xv+azCzYi2AWU0wUIl0wFsusWyu61Mir90Kth35bXZ0pkTMsPFlmMdDusvR2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709119708; c=relaxed/simple;
	bh=QDeGx8kwTh+bFt6eCqKGKD/p/BMyvNhx782+ALmCRTc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RqKFNd6waJ6p7gFvpeQHzEEv0zXn5h3HogE1ShgDeoD2XK9nXeaJKoPke/i6Bp1eLdbZO/j5QqR7A6Y50ugxkf8OKzargNbU1lzLkGcUfYpk2qJoBQNh9++MYFX3xROyo737h4H7hl9kocH3ktFjCcMDkKIdi0oBHRywGco6ESU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DEbDrTeU; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 62A361BF205;
	Wed, 28 Feb 2024 11:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709119704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UVzgKFNV1exaQlx/j0qa2NvTSBRsCqWJEp+Uxg45yLc=;
	b=DEbDrTeUS9hpivzB2+bbkgjpy4iFDaNFXkHbvH8DL+IfJ8JqPqEyNLhzaP2SqGRps792vk
	em75tNECn3Y4VbEEUUzPn62ah99Scl88Hu921iT6yk96rVWSq3gJ6xIUOfHpJJkOiyW9nn
	bakUCQxPTofiVZl5pI/IzGeg7opuM8DwaJXnbc78fA+zqtFuf//sAp9OJBBFxeOGOsKWo7
	2pwiePihE5pW6cHWxAJ0EYUBOdKbCFOaSW8q4QoRnhP0mtRxyhmVBqpCyxwifsZjnw9H1r
	MXncWd+Bx64KJY8qdHP0Dtjd/FQrsXDSGugUFHS+Uq+YXBOs4fw6pkoLxnPa1Q==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 28 Feb 2024 12:28:16 +0100
Subject: [PATCH v2 18/30] gpio: nomadik: use devres version of clk_get*()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240228-mbly-gpio-v2-18-3ba757474006@bootlin.com>
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

Replace call to clk_get() by call to devm_clk_get(). Allow automatic
cleanup of the clock in case of probe error.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/gpio/gpio-nomadik.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-nomadik.c b/drivers/gpio/gpio-nomadik.c
index 93015fa3d010..fb821a9b6c5f 100644
--- a/drivers/gpio/gpio-nomadik.c
+++ b/drivers/gpio/gpio-nomadik.c
@@ -531,7 +531,7 @@ struct nmk_gpio_chip *nmk_gpio_populate_chip(struct device_node *np,
 	}
 	nmk_chip->addr = base;
 
-	clk = clk_get(gpio_dev, NULL);
+	clk = devm_clk_get(gpio_dev, NULL);
 	if (IS_ERR(clk)) {
 		platform_device_put(gpio_pdev);
 		return (void *)clk;

-- 
2.44.0


