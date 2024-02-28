Return-Path: <linux-kernel+bounces-84897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3944686AD4D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66FEB1C228A4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B458515A4B7;
	Wed, 28 Feb 2024 11:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="h8eRII9p"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CE4152DED;
	Wed, 28 Feb 2024 11:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709119709; cv=none; b=UsZGuOKYlBB6IR4tDU5K5sz4p4PbexJSOEhnmqjanO/Kp8IZpjF4vIRtlG3qKCZAFK2Fxcxs/6eHIkhxPqkIdCdRBCn4wD46fvEGhxmbqysSJNB6mXkh1iJU0V2j4Xt3I1p0NnwsR42bBgZ/ex2c8b0YynGnmQV5LCjN+nM5RzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709119709; c=relaxed/simple;
	bh=XWWL3eyR8a1smbNLx8fU1UmuVxwfhD8TNlUTq3LKaMk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CSIUw5J491DC4rkxZptHwg4QciyekMfPW1d8tA29HlFOxefk0UHniFAD6vwcReXeVEC4jBRiFJsKWTxMtlQw+8H4ToGCIqzHY/nrVh2ex7guxdrQQQAwvfquI+xNiLpARiFVKu0zdnjEQtGOEzzbvh4/XND0wFNrYxSP49EeLeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=h8eRII9p; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2574D1BF218;
	Wed, 28 Feb 2024 11:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709119705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WxIu54NFmTQm8hNsehWJC+M+NOJFTGcij28O895cc+A=;
	b=h8eRII9pZ0tb8GDAwVRIFfmiql0iTGIE70/fRLgPkWkGlQzSAfmhKVQJXo9J9H+ZQWTfr2
	n3vl3ZTEqPv0Di6MHlYG6B4tbeFmd/uU4giyF04BZda91t03zQ68bin8PikzX67G5iVSbG
	ocLdX1e3GvfLQlBe24Aj7BeTw/XqyJaFOJRx+AC5h3F+7DRCQUq5cuC5grutClJ6WnBQTM
	V6qATt294LM4EzuEHiPE1j6CwTL6C8j0NBbmclgeDu2amd8+Sqs2IeMUSutu5Fs4nF9MdO
	Qq4HYzqJQv5zDPK6uFP8fsvnazVAcjgFv/CFmojaK1zF0qV5+Yk979DCdfDUFg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 28 Feb 2024 12:28:18 +0100
Subject: [PATCH v2 20/30] gpio: nomadik: make clock optional
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240228-mbly-gpio-v2-20-3ba757474006@bootlin.com>
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

Not all platforms using this platform driver expose a clock for this
GPIO controller. Turn devm_clk_get() into devm_clk_get_optional() to
avoid failing when no clocks are provided.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/gpio/gpio-nomadik.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-nomadik.c b/drivers/gpio/gpio-nomadik.c
index b7d76cc901dc..3ccbb731cb68 100644
--- a/drivers/gpio/gpio-nomadik.c
+++ b/drivers/gpio/gpio-nomadik.c
@@ -531,7 +531,7 @@ struct nmk_gpio_chip *nmk_gpio_populate_chip(struct device_node *np,
 	}
 	nmk_chip->addr = base;
 
-	clk = devm_clk_get(gpio_dev, NULL);
+	clk = devm_clk_get_optional(gpio_dev, NULL);
 	if (IS_ERR(clk)) {
 		platform_device_put(gpio_pdev);
 		return (void *)clk;

-- 
2.44.0


