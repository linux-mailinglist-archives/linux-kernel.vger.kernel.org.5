Return-Path: <linux-kernel+bounces-65523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 235E2854E32
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 565B41C2137E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8750760DD4;
	Wed, 14 Feb 2024 16:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pkVxLA+O"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170005FF03;
	Wed, 14 Feb 2024 16:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707927898; cv=none; b=WEOqSDUp6fekcU/pVegmePu8wQmC5YldyyTaoBUYM5ZdjxVSa929kVsg7oltvWfcJF0DzD5shiaWX4qMu8a2ZWcAD5ZFdC2BJYDpW6OJQ6JXUADl6lFAci1xB51UxYb7qaR4in+DS5bcM+9CCAc6Eo/swf+4OqidEoeQy63D08g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707927898; c=relaxed/simple;
	bh=PiULlxoY9sFSzbUhnnrxaXNFppXlk4suqKPpxb9RyTg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VJwyFOOkLGVbN957m+qQ1uPNiC0VNUrlKRNLqLmVjLad0GcTtfpdKaZuiAM77/mOQ33jTpzgi/iwL0cjR1RF0lOvQw1GwLnX/HqPDqOhSBuRANjWgM2RZZHwfCa8k7/5U6DtjNHKuX1kZ/elnMwAuIPGQDWj7zjqviONye/4vAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pkVxLA+O; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9A9E060017;
	Wed, 14 Feb 2024 16:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707927894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bLoA0P9RlkSFaslaKEMQVpOFEKtcgMw82K3D06dO8ZY=;
	b=pkVxLA+Oeupka39b5nAyT6X7owzZdCh7sz2tRioW4gOKFg6LOSuzSoRvOvv6cSs8l8HX6b
	L78roBLoJfUNtfVyWoJ0C4nPrzuYvQK9YOReklchCWkrZT/OdcNZqTZLTsEVntgPb1Awiz
	+9qsQRqqzKVRaEfmXLnuLs6fMqxXsvudZ4fAdEbMm8Pn8oHe/RBCZ5kjOE7YUDjbEZxeGa
	uivzinwAqD0crB4C+h7y91mnI+yDgy/tCN2fUjPG4TEq96Ksyw34p1jNRrrn1DK8MxSfBB
	7beHuHVwPzjXKvj2KYg95MwjMKpq1V01I/u7uvvyUcvDyHnsrimEqMxfdzLoOA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 14 Feb 2024 17:24:06 +0100
Subject: [PATCH 13/23] gpio: nomadik: fix offset bug in nmk_pmx_set()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240214-mbly-gpio-v1-13-f88c0ccf372b@bootlin.com>
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

Previously, the statement looked like:

    slpm[x] &= ~BIT(g->pins[i]);

Where:
 - slpm is a unsigned int pointer;
 - g->pins[i] is a pin number which can grow to more than 32.

The expected shift amount is a pin bank offset.

This bug does not occur on every group or pin: the altsetting must be
NMK_GPIO_ALT_C and the pin must be 32 or above. It is possible that it
occurred. For example, in pinctrl-nomadik-db8500.c, pin group i2c3_c_2
has the right altsetting and has pins 229 and 230.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/pinctrl/nomadik/pinctrl-nomadik.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/nomadik/pinctrl-nomadik.c b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
index c7693fbc0484..99bdb25f358d 100644
--- a/drivers/pinctrl/nomadik/pinctrl-nomadik.c
+++ b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
@@ -913,8 +913,9 @@ static int nmk_pmx_set(struct pinctrl_dev *pctldev, unsigned int function,
 		 */
 		for (i = 0; i < g->grp.npins; i++) {
 			struct nmk_gpio_chip *nmk_chip;
+			unsigned int bit;
 
-			nmk_chip = find_nmk_gpio_from_pin(g->grp.pins[i], NULL);
+			nmk_chip = find_nmk_gpio_from_pin(g->grp.pins[i], &bit);
 			if (!nmk_chip) {
 				dev_err(npct->dev,
 					"invalid pin offset %d in group %s at index %d\n",
@@ -922,7 +923,7 @@ static int nmk_pmx_set(struct pinctrl_dev *pctldev, unsigned int function,
 				goto out_pre_slpm_init;
 			}
 
-			slpm[nmk_chip->bank] &= ~BIT(g->grp.pins[i]);
+			slpm[nmk_chip->bank] &= ~BIT(bit);
 		}
 		nmk_gpio_glitch_slpm_init(slpm);
 	}

-- 
2.43.1


