Return-Path: <linux-kernel+bounces-65542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB5A854E7E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE1791C28BAC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC29E633E8;
	Wed, 14 Feb 2024 16:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fbvKoBri"
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE6860ED7;
	Wed, 14 Feb 2024 16:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707928083; cv=none; b=WcbZt2peQgzAbVE7C463xgdZezWbOjRUJ6fXEKiKJGCbM0x4bbWnVMvojCI2yzFCqLMbctCbTolj8At84VBI1cDOdmw4FxvD2r057VtqXNGX766Dk7FHhOl4qVmuxEWcsFF/nKVRSLvzs74Sz71BlaEeTkhHGzNYrOJ/RVGo6fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707928083; c=relaxed/simple;
	bh=zHzoNBjvcRL7OWs7kGXGyXjhEkGly7HUA37dQMH48mg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YywEB7S17OGRgFCXP6X6JnPVtXjEMk0qGhng92yQNYi3Z05iK6kzJJzYD1HSLmxSdz0YP2YT2yNNUYxf2P2DsmXBs6SW+9/KB9FTwKQej37F7bB23hoss9tvSvPm7cs71g/daCf9kqYV1pQWbCaqWCZy9Ufzlq3pwfsiJ9lr0yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fbvKoBri; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay3-d.mail.gandi.net (unknown [217.70.183.195])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 12878C3900;
	Wed, 14 Feb 2024 16:24:58 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 342AE60012;
	Wed, 14 Feb 2024 16:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707927889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FPaEKDZRsqQg1o2M83ZjHSqgMFpHL4FJm1MMwf5vGg8=;
	b=fbvKoBrirsLJ2R6bh/URlGt9prJA9TbLFcs2zj+csdVV2KQ+Knfv9hzvvXCpBOETgnAmPT
	jm8nug3kP9SrZOI40+Ne1dU+/o7jmcdcOsM+fZ6K5SnTn+ZnBiHa8lvecg63vzqjt4A20D
	2rviWyAk54uCK+k6lYV6CqdgL8qp5a9fVUPYeTqBr7pr87eMbmU+kLpatmK+8GURs8jyh8
	CWL3wOZ6Eo3BuoAv2MFhOFtb4NRx3rwcEBFRH6co5L1mNCnJuulQBQfTFAhR2O37QuuOCD
	qhkwAhDCFeyQTtTUzDztwpZkvTw8CGA8s/EFwFM1dkQx05/vuv2o6Y2EE1kZFw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 14 Feb 2024 17:24:00 +0100
Subject: [PATCH 07/23] pinctrl: nomadik: fix build warning
 (-Wpointer-to-int-cast)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240214-mbly-gpio-v1-7-f88c0ccf372b@bootlin.com>
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

Fix compiler warning found in the pinctrl-nomadik platform driver. GCC
message is as such:

drivers/pinctrl/nomadik/pinctrl-nomadik.c:1169:12: warning: cast from
pointer to integer of different size [-Wpointer-to-int-cast]

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/pinctrl/nomadik/pinctrl-nomadik.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/nomadik/pinctrl-nomadik.c b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
index d2a40c3dd0f6..60443de439fd 100644
--- a/drivers/pinctrl/nomadik/pinctrl-nomadik.c
+++ b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
@@ -1174,14 +1174,14 @@ static int nmk_pinctrl_probe(struct platform_device *pdev)
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
2.43.1


