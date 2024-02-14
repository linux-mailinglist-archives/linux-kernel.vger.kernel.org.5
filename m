Return-Path: <linux-kernel+bounces-65543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D0D854E7F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AA381F2A54B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8D363401;
	Wed, 14 Feb 2024 16:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UgzKu1dS"
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD83F60ED2;
	Wed, 14 Feb 2024 16:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707928083; cv=none; b=mqsbHdBweaYOih3fk4rNPoW3v/MGISu9htf3px0Txdwlk27ZSESjTDBKho4poHv6sEmeFkmPJiCq6eBvYskdLgjEeSJayvuWSsFLKw2FZMUMnD1JB3RU00KM8fNkGk++0j9Q65go06KB9Tr6T2oaAzfBf4cwj8q7ZRV7hfI9pjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707928083; c=relaxed/simple;
	bh=AC+69MRBi3CQUcdl8mSedZmwJ6Gy8HYyOO7Mzl3OjFQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KiqqUayMLSTixanKxPHx1nuNirwkKgUbgV+VHCBb8Bg5wP6KOX97x6NatQ3U2muuwUv6Se1YiRK8a3GDOw5yDEtaKzeh2HGqtGxcobw7M8uX9G4+C5+ps8bqOkPm6KxxdzAMgGAg+DuCH6HgolLkingtg9LRJ1mhrTJw+9/LRP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UgzKu1dS; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay3-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::223])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 1E2C4C38EE;
	Wed, 14 Feb 2024 16:24:57 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7817860004;
	Wed, 14 Feb 2024 16:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707927889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+wsn+jBCyAUawbTGmVyBrS+8c7hk5AWGpkwIkj0NY+U=;
	b=UgzKu1dSOK3t5P0+yFYbUc0G+EW1d7fw6zkqIR9j+u1aq3EBFxXxw/HQoy7l787Zoi1FBX
	sq7xLeSuCme+y4uuIVPcRRvAkWADPTveSfJFUZklkJO7AVefcLMWwMRKNxDdE0hqZ+9Sor
	+utEeY5rF1/3XYVXzUgvXJ0szEjuM0mI21q2osdJMhDIFdGvL2R6Vi1ZNQSD5cAxnlYCWi
	6GrVQu13SYyoSa6tH7xn3x0vU5a/cmZiPvea4OlGe8qjZp7MV/r8WyIO7N35/3x8OioVa5
	mxWRlhVJwkw0r80Ww4jpoZ+Qz6JjhoGWUiWAZXNGicZot+1mUpN/OxA8jqkJMA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 14 Feb 2024 17:23:59 +0100
Subject: [PATCH 06/23] pinctrl: nomadik: fix build warning (-Wformat)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240214-mbly-gpio-v1-6-f88c0ccf372b@bootlin.com>
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

drivers/pinctrl/nomadik/pinctrl-nomadik.c:855:21: warning:
format ‘%u’ expects argument of type ‘unsigned int’, but argument 5
has type ‘size_t {aka const long unsigned int}’ [-Wformat=]

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/pinctrl/nomadik/pinctrl-nomadik.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/nomadik/pinctrl-nomadik.c b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
index f3897dbfa2c3..d2a40c3dd0f6 100644
--- a/drivers/pinctrl/nomadik/pinctrl-nomadik.c
+++ b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
@@ -871,7 +871,7 @@ static int nmk_pmx_set(struct pinctrl_dev *pctldev, unsigned function,
 	if (g->altsetting < 0)
 		return -EINVAL;
 
-	dev_dbg(npct->dev, "enable group %s, %u pins\n", g->grp.name, g->grp.npins);
+	dev_dbg(npct->dev, "enable group %s, %zu pins\n", g->grp.name, g->grp.npins);
 
 	/*
 	 * If we're setting altfunc C by setting both AFSLA and AFSLB to 1,

-- 
2.43.1


