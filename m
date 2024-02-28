Return-Path: <linux-kernel+bounces-84877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1992886AD01
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A73B1F22F43
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DF31369BF;
	Wed, 28 Feb 2024 11:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Tj3Fawby"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4116D2561D;
	Wed, 28 Feb 2024 11:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709119700; cv=none; b=VrpYdCSkExGVsk+vDKfHmVhqb8cQEYUNFEPiyvfn9kaMMISHw8cMChpw/paBtxO8qSjkXcsltlF2t78hjv7maNA5Sw02geA+nYAdHs9FlO1mS+JwZwDsAM4G4np19Vk0gWqv+MR+ZDsye88JBz4Th7LjNQciF0NQK+yLfnY3BIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709119700; c=relaxed/simple;
	bh=yr8WX4A44trJtUxl2P9pZk9ZMjMyxNKtR2O698qVrvo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eSzc7qbFfvaybEkMbT5TsCIZaH+Mst8rnKvMlhrNpihkdBYJ7tm2L7+AtOl88CdBqJ6y10G2RP5y09W0y3dP4IgbWUzBVPTE+wir6qpHpwyEXwPWv+fb3Jg+f+BGqDjQXr/dKMvLvbxCLhkEuxEg9HPo3Y7b8aJOdXa3DgVVn4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Tj3Fawby; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2CEA91BF20D;
	Wed, 28 Feb 2024 11:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709119696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BpsD83BM+PlNWBQdcZslFjWvjlE691PT9L/5TLzg2mc=;
	b=Tj3FawbyJENHxmceKliYSLPqE6Hp1GKvvRnQ3ZAyremnWZUy2b5RpAqxCnNMz2VoYuZWlp
	UcNdL1qoKeF5I1vDuTVuHSWxNaQJpgHgnl/HUr/zGmh4Zs2MsiDzpcEZ/j2DS07mGz4s6I
	jNJcrWwuHfCqsKIJGKgGqj4+k+kovhSZtupcbZsGlj+bOpb52PSbaGiLOTCtQee+jdQZMT
	bvRct0OhtZyY7S85KwwFECaXG0uVPgSmVDf4+/rsNMkEHwpR3aQ8llZ+d+Iivss//yTBIr
	LP/co5yvACfpYIT0zlalV6yoyFlGvW0EGso+wqfhr2v4ZST98wG5u4bAj8usNA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 28 Feb 2024 12:28:06 +0100
Subject: [PATCH v2 08/30] pinctrl: nomadik: fix build warning (-Wformat)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240228-mbly-gpio-v2-8-3ba757474006@bootlin.com>
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

drivers/pinctrl/nomadik/pinctrl-nomadik.c:855:21: warning:
format ‘%u’ expects argument of type ‘unsigned int’, but argument 5
has type ‘size_t {aka const long unsigned int}’ [-Wformat=]

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/pinctrl/nomadik/pinctrl-nomadik.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/nomadik/pinctrl-nomadik.c b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
index 16d836157f74..1be0c48712b7 100644
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
2.44.0


