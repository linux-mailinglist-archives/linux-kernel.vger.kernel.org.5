Return-Path: <linux-kernel+bounces-84884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0032186AD1D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 952F21F23766
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90094149E0B;
	Wed, 28 Feb 2024 11:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UY4k68Fm"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59257135A6B;
	Wed, 28 Feb 2024 11:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709119703; cv=none; b=JCpsiTmRAZTcadD63zKqKnw+g6hSCLDcP1orPmZ676zV8cdP2ha3OnvD9BXjqpRTtUR6Wr0AVBljdcbRbdMqkUM2/pChSuOgc2ZJQvxL3FIeXgWQd0XyKmej+kFfBeAjXdJRvZZlD478s34acYvmJvphXCS2Vb3f8znwcKDSxJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709119703; c=relaxed/simple;
	bh=aS4vsmKOiyXUzu/gtsh1LG1nA/WQDCKMrN7hnt9Q3Pw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n+3AnWdaW+M7cKHKkTZ8YRjFnvqABN6vWG/gQYfDgb0auJBosLZXnZDnEZPBTqXig9TeaegQo/da2an3TVyeB1JGaJ6ijm2ZWu1sGORDQGITnSodm9XZR5z8SJJxEwCwoQgggWztDUtUnaHEQqPsVfmejzCUf8Eyqda0Ye0WPvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UY4k68Fm; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D60371BF207;
	Wed, 28 Feb 2024 11:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709119694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=obEsZr5TqYQ+s6w0haLqPuWmQvfUOmeEY6NOi1OIfoc=;
	b=UY4k68Fmjuo+t50X2+k2fLHa0B33dKhPVDyu/+wbj+/NL9OdUOXrCDuFHyahShKI6kP2A+
	fEDyx5UVsjQZgPhLVSNwUNa3NeFkg28U4lyIYJtLAiKGHsjLzWRQv56HGwZUwzo+4Et5Yg
	4wjXYZQu7nsTZG3jLYsg6zFBZr9qeJDKo83dSbju/C3c7fj8uMaIq+vtpYd6YaCxzHs59H
	TT3ilkazvII1wpQ1rn4UhX8+6pmMgQQAQWGq8dImgjVfF1BV6epGb46HtN+lt6VnwrPHN1
	bl36D8DRnLJjske06uyabkqYtXZSXF7af0WfLp569fp7Si7Ihk0jR2GDq6JiDQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 28 Feb 2024 12:28:03 +0100
Subject: [PATCH v2 05/30] gpio: nomadik: fix offset bug in nmk_pmx_set()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240228-mbly-gpio-v2-5-3ba757474006@bootlin.com>
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

Previously, the statement looked like:

    slpm[x] &= ~BIT(g->grp.pins[i]);

Where:
 - slpm is a unsigned int pointer;
 - g->grp.pins[i] is a pin number. It can grow to more than 32.

The expected shift amount is a pin bank offset.

This bug does not occur on every group or pin: the altsetting must be
NMK_GPIO_ALT_C and the pin must be 32 or above. It might have occured.
For example, in pinctrl-nomadik-db8500.c, pin group i2c3_c_2 has the
right altsetting and pins 229 and 230.

Fixes: dbfe8ca259e1 ("pinctrl/nomadik: implement pin multiplexing")
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/pinctrl/nomadik/pinctrl-nomadik.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/nomadik/pinctrl-nomadik.c b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
index 7911353ac97d..4f7c4af4f93c 100644
--- a/drivers/pinctrl/nomadik/pinctrl-nomadik.c
+++ b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
@@ -1579,8 +1579,10 @@ static int nmk_pmx_set(struct pinctrl_dev *pctldev, unsigned function,
 		 * Then mask the pins that need to be sleeping now when we're
 		 * switching to the ALT C function.
 		 */
-		for (i = 0; i < g->grp.npins; i++)
-			slpm[g->grp.pins[i] / NMK_GPIO_PER_CHIP] &= ~BIT(g->grp.pins[i]);
+		for (i = 0; i < g->grp.npins; i++) {
+			unsigned int bit = g->grp.pins[i] % NMK_GPIO_PER_CHIP;
+			slpm[g->grp.pins[i] / NMK_GPIO_PER_CHIP] &= ~BIT(bit);
+		}
 		nmk_gpio_glitch_slpm_init(slpm);
 	}
 

-- 
2.44.0


