Return-Path: <linux-kernel+bounces-84907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3907B86AD84
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC1BEB2570D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA7F15E5D7;
	Wed, 28 Feb 2024 11:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="V0d5XFLH"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FF615D5A2;
	Wed, 28 Feb 2024 11:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709119717; cv=none; b=tfPMrbgbxczQSIxfdxX2MrTmd1Xcne0RqnrkZwP9egU/RzxJLoqpLV809ONm2FDbJ5vpPOVXj0GG4lybuU9PR4e0wHuOV0sOk/n+gO2DtJS10BBw/uUI5vUwsNtZW6i6SpODxHSyV5wDb9likyQDScPUB4HfCggQIoX3jVZTjTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709119717; c=relaxed/simple;
	bh=LZXd37PvNSwXU5xfvI/2wf4xPTyEjUPaJOZPtTjdEuk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HWjLO9EiAJJ1jGAKjJBy9ImUbxn59gkTW/8+fRNlfxdvmwrOr2u5Aiztyyvi+PBzF01tOsBrWNYz0DxfHXc67Cad5omYBpZ0xib3STgRi3iSJ8XT0RIeLWU3Z7VDXwvgG24zesudhB4s2nU2myBZ+A5cD59E7TZBJeWFv/sMzt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=V0d5XFLH; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F2F7B1BF21A;
	Wed, 28 Feb 2024 11:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709119713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VpV5SvbrLw6BtffS77u0tmC5Cq+M6dFN+xE6ca04/74=;
	b=V0d5XFLHmBCXn5TfFeKJHIG2hVLgs1bsqH9BDqqayu45k42SOPN07miDPppVL9EpKui5zt
	TpUkX5X7TS/35ocivrHFc0O9mHToArmHY+OL66bZIeUMyMqVp1x+4UGlTK7iDDKHB4TsDD
	NpQq3vLV4eTSl0burMLrMvfbz2hIZk7HPB7hA5ptn0JwICHIhkHJz/vzLvR1nDAnKKH+WM
	BgKMemBgQ1NPx2ggGomj0OaE8+uWjb3WIBARzcQsarC2XTdSCeU0FNBq3kEwCZ5evoJ/gM
	rrYr4An8/+JqSNQ3FmfHapmTUoUV9NNPNmt8tQt9YCizfVt1TMpruFrhmp9Q7g==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 28 Feb 2024 12:28:28 +0100
Subject: [PATCH v2 30/30] MIPS: mobileye: eyeq5: map GPIOs to pins using
 gpio-ranges
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240228-mbly-gpio-v2-30-3ba757474006@bootlin.com>
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

Create a mapping between the GPIO controllers and the pin controllers.
GPIO is handled in a one-instance-per-bank manner while pinctrl is done
with a single instance for both pin banks.

See gpio-ranges documentation:
Documentation/devicetree/bindings/gpio/gpio.txt

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 arch/mips/boot/dts/mobileye/eyeq5.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/boot/dts/mobileye/eyeq5.dtsi b/arch/mips/boot/dts/mobileye/eyeq5.dtsi
index 5f00d129c057..68f6c81331d7 100644
--- a/arch/mips/boot/dts/mobileye/eyeq5.dtsi
+++ b/arch/mips/boot/dts/mobileye/eyeq5.dtsi
@@ -168,6 +168,7 @@ gpio0: gpio@1400000 {
 			interrupts = <GIC_SHARED 14 IRQ_TYPE_LEVEL_HIGH>;
 			gpio-controller;
 			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl 0 0 29>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			resets = <&reset 0 26>;
@@ -182,6 +183,7 @@ gpio1: gpio@1500000 {
 			interrupts = <GIC_SHARED 14 IRQ_TYPE_LEVEL_HIGH>;
 			gpio-controller;
 			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl 0 29 23>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			resets = <&reset 0 26>;

-- 
2.44.0


