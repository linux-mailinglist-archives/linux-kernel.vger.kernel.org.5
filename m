Return-Path: <linux-kernel+bounces-46798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B24844467
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86D3E1F2633D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308041386A3;
	Wed, 31 Jan 2024 16:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Q3c22cB0"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE20B12F5A1;
	Wed, 31 Jan 2024 16:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706718444; cv=none; b=tg2peILrBylTCGSOMDKhPKrk1zuEFGvBo4jjn6E+qVxITSRpWz8pZy+8DiTtxxY6sDPFG02tndDbLBumoGAyoayFT+gEL8MCWipRICNumJXFKGglVg7CLCADb/uaR3/Iq3rL9ZVGb9lFqEACsOkQnkCRmnclQ8gIDHcLJ2jFg8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706718444; c=relaxed/simple;
	bh=fMUKxUl/EuiGibTvhkWfXXTqt1w1R6A8pIcQGGaOvmU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eDbp/geXMfq8I+gBEj1PDG2+uoA8gAW5AfCXuI1Dx4WzS7h4CgWDtPMbRoXgWupXVaUkmHZfgBlvibeCGarcDghgjD5O0CDovj92+us7AsI91L32fAGBpQvcfchJowonHqfmZmoumSic0hTkz0YXBQmZqSF4PrDlZgfskeE7vhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Q3c22cB0; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 69BEE40012;
	Wed, 31 Jan 2024 16:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706718440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uvFAvzfq7+hFGweJFxbN+uqUZSVxDpI6pzlv2xpGDIc=;
	b=Q3c22cB00X22uU0+unIxoZ+GCChLde2WYBhFhq49tKHhG5Sr3j/22PVstaFnvqgWehQbbi
	scYh4QMKo5sT5dVw4ugJYgBBBgT23bytEV0WqaPpZf4C5qF5x8nM+FkIaeZu0+rHiXdGsC
	TBVqhjj9MPsOSagfRh8Nl1Z2UBRqdMUuwD64Ol4oB50pIo3V5Y33vkMguMXlQQQvh7LuHP
	iBSrQ+vMyGisJhHzYvnRfoj5eodYsmCMRLK0LrjYR2KEd2pwX8kwvrfsGSGRQsau4rr0NK
	abFfKtSmPrWSL0gQo2G/Y9nVtmmULsYcquLdWCvQ1DRuPwtd5kVZelnFR2Pfnw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 31 Jan 2024 17:26:25 +0100
Subject: [PATCH v4 12/18] MIPS: mobileye: eyeq5: remove reg-io-width
 property from OLB syscon
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240131-mbly-clk-v4-12-bcd00510d6a0@bootlin.com>
References: <20240131-mbly-clk-v4-0-bcd00510d6a0@bootlin.com>
In-Reply-To: <20240131-mbly-clk-v4-0-bcd00510d6a0@bootlin.com>
To: Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 linux-mips@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, linux-gpio@vger.kernel.org, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: theo.lebrun@bootlin.com

Remove the `reg-io-width` property from the system-controller@e00000
syscon. The default memory access width is what we desire: no need to
make it explicit.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 arch/mips/boot/dts/mobileye/eyeq5.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/boot/dts/mobileye/eyeq5.dtsi b/arch/mips/boot/dts/mobileye/eyeq5.dtsi
index 81497febcdee..03e7e942ee22 100644
--- a/arch/mips/boot/dts/mobileye/eyeq5.dtsi
+++ b/arch/mips/boot/dts/mobileye/eyeq5.dtsi
@@ -103,7 +103,6 @@ uart2: serial@a00000 {
 		olb: system-controller@e00000 {
 			compatible = "mobileye,eyeq5-olb", "syscon", "simple-mfd";
 			reg = <0 0xe00000 0x0 0x400>;
-			reg-io-width = <4>;
 		};
 
 		gic: interrupt-controller@140000 {

-- 
2.43.0


