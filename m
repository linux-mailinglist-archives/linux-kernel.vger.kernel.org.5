Return-Path: <linux-kernel+bounces-65533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F97E854E57
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2B221C20FBF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9024C69D2A;
	Wed, 14 Feb 2024 16:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="g2lyUSu4"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DA5612E7;
	Wed, 14 Feb 2024 16:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707927905; cv=none; b=XT1FZ0hQJuZh+OTMI6ol/C72FmWEYGzP+HesOveQyirRWRtQqBoUPdvHTBDg6JWVH2UmBOy44cAVz5CuTjgmhlZIqMMskCszoX5SU0g1WSzOZA7WfkdOs/m8zC7smvFtOKMNrcb0VI0ulFXmg6SQke6k5w9Tf9BD9RUe93nyJlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707927905; c=relaxed/simple;
	bh=ScH3ISK4xEVrupm84aSwwMYB/pi5IA9PUdSxzmGFguU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QM56PqvjwClM9+PuiSKoLrhbQWNcR6SlKjGuXCzhoH64vAgL6G14mJURn8rgo0jZ/RKgeO2elrRAm0rHQMIN+jfSaKmkGqxVozKIdBnN/P0BGeKZF9rxx6/AGiHeLQcIrpmhQE9uh57aCey/WmvmZ2WpwXfVbYZqIQC0JnsL12E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=g2lyUSu4; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 549FA60011;
	Wed, 14 Feb 2024 16:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707927901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cvpgZwi39A8c9IIwUG5REki+jOi12VpmEmI6+/qQDOw=;
	b=g2lyUSu4/3Y5kQJR25v1y+cYvvgnSYGTA93RU//D5Jqh2k4nbPsknVcIMV/Nb8BCEdSjeM
	eAYjfYYa/cP/8ZoFZ41SdFV2eolxBeFTZrU45h/YApDC1oa/ZiARquV9QOvJe4p/mGFQBF
	AO69+gzKyzwL3qewSkVYsymbz6c24nikGHZdGEe5NareGrZOOikLhoWTDRX9NM3MH9Z0FA
	O6CjZA+uy2Ir8IpEe+5o+wk8eDCJ2T0fZQCMX/hMjGM5YqCwd3YKNQ+V4nKXu2ZhS2CzFz
	l7FzstXYxhKJ0RFEqMkCfCudbAoQniiks9djICyNX9Z1CvudSTZ9OoPIaNLLZQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 14 Feb 2024 17:24:16 +0100
Subject: [PATCH 23/23] MIPS: mobileye: eyeq5: map GPIOs to pins using
 gpio-ranges
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240214-mbly-gpio-v1-23-f88c0ccf372b@bootlin.com>
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
2.43.1


