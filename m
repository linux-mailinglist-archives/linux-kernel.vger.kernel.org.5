Return-Path: <linux-kernel+bounces-84906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D33C486AD7D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6212B21973
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3BF15E5A4;
	Wed, 28 Feb 2024 11:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XMIpp4tG"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3107D15CD57;
	Wed, 28 Feb 2024 11:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709119716; cv=none; b=SwLrJIjGMkyl3O+sTpQ1s4+aTb6VfEXIsB8RuicwoMWFFWhVOvBSZHjfTzXmocvP2qoPHYHV6RaK8YOOSwhv+XxRGeR4xQABBOk8C5R8xikpjLRJrLZr+OKQ9px+Ty1vEFq6Fx+ESbYwH/OthwNm+LAORbYcfVL5VoY0FEbAqNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709119716; c=relaxed/simple;
	bh=scoXGBjHtapVDwyNRsT3nzK/OYslkAGYZkSdqOZ17fM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XLdPp2U7qvEDbVAxt7RXPDQ9XWnVNqK2kalg/s+apbrCf3pc57GpEtMxF/R8Bhxiqt/MRZFmtpcUrNJvq07l6UUDbttjjfur9Bc5uAOv7N9Ev32XzsWkwR8a3rTr1dfH/PyPDEjal6P0IogIwNPgWu9eUSiPSjCVjBLxd3Kg0is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XMIpp4tG; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 49D751BF210;
	Wed, 28 Feb 2024 11:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709119712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YKcXEFXFtj/83Z5hgCIOhTpOO4T5SFVRu7N+tcLxJRU=;
	b=XMIpp4tGyLmn6M46me/FpCRHP5UB3+E2zxJOh5w8k0RY3lH7UnPTmm38uenYHYySPKILM/
	dxDjJB8EdHz1bqldZcYCZqAlu9eDGoCAzNWdXCGDZqr5UdZcYO0yNIpbBfZMtWbf+jqt2S
	K9IUH5gu4OEfyneiVL9NuBYnDcVpg8BwPEtVdJCEvsXnPqb3CT7F4RT70HFr3MR4qrF/x8
	7J+twvJ6GdTobDHtVIW5lzsqghZ7+S3Myrorcm53BAu/ONZHXUENTIXPu9ckzD+L+AP08W
	IvCiSsMQIfbueOzl5gKZTjBhf0ns8II5vJt8FqAIMYcZG6LRCrk5X5rnPPu1rA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 28 Feb 2024 12:28:27 +0100
Subject: [PATCH v2 29/30] MIPS: mobileye: eyeq5: add resets to GPIO banks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240228-mbly-gpio-v2-29-3ba757474006@bootlin.com>
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

The two GPIO banks share a single reset line.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 arch/mips/boot/dts/mobileye/eyeq5.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/boot/dts/mobileye/eyeq5.dtsi b/arch/mips/boot/dts/mobileye/eyeq5.dtsi
index 0f18ac73620b..5f00d129c057 100644
--- a/arch/mips/boot/dts/mobileye/eyeq5.dtsi
+++ b/arch/mips/boot/dts/mobileye/eyeq5.dtsi
@@ -170,6 +170,7 @@ gpio0: gpio@1400000 {
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			resets = <&reset 0 26>;
 		};
 
 		gpio1: gpio@1500000 {
@@ -183,6 +184,7 @@ gpio1: gpio@1500000 {
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			resets = <&reset 0 26>;
 		};
 	};
 };

-- 
2.44.0


