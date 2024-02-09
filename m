Return-Path: <linux-kernel+bounces-59472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7514784F794
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 310C8282DB9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E302174E18;
	Fri,  9 Feb 2024 14:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LPiAdOe7"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97FB80BF2;
	Fri,  9 Feb 2024 14:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707489126; cv=none; b=bhoAUoAFG4dFlLrJJTAmjvmcsE5IpGa7NSFFci4o28em8f/9bDgL2NNyYj43MxExfr26x5PkrRZzCVaEEnO9O8ivE8BP/fGgwbAQMrl+CRdPpVXYhQi7DZghh/8HMLywz8PzTZqe73ayIy5XjbxLn2q37U2pOfUM8arUE2Xq2GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707489126; c=relaxed/simple;
	bh=nHpU1D7vePiiUmMnW0BUVXPPq/tMiD6WtqmwDc11l5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FpWiWzqS904VU+nXy5hVwjEGxnNgZY3WKNvbuCoQ1iNqYHpnZEXFW+saty5gS+GK9RT2xblk/tC0fPjgs7+ryXc9pkYfQaa10JP23TwGdThcqAzeLkcV6gNfH+W1LcPLuVnRIHF/PzOQXe2cS/SGxLnNx1wX1b38NMPjVByAziA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LPiAdOe7; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B28CC240007;
	Fri,  9 Feb 2024 14:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707489122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YjzH8us36qfzbp3mhYrknBNc6xeLQlFhaU/yX/UTwvc=;
	b=LPiAdOe7GYRT8vM08CPZZjwaWNVpdgFZHy0wD6sxSKI4FQs5jAvJ1Oqh7Mc50MLgLzlykg
	m+9y3SQsAHl12kLFIiIFFbS90WSzOVFPtvh0NHIG+8VFfqX4TIGVa+ZAxmjUac4FgCEho4
	ryHdTZNmYg8I/HB29Dz14mi2Dv7myf7RI2irDRl5ZHJtfmb+6NA0y3dmwnpNw0AKQHp22s
	0onQhKmT3sCFM67qW6ZTitDPqIyU2mk+F+LwUTB1ig6aDv10jkd4XCritmS17gBfqJRB4b
	jPV0YBKYZR4TbwWmeAwrQpbY/fbpo6CMtFxVVdUZvXNseS1cETgOWlyaerSUCQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 09 Feb 2024 15:31:46 +0100
Subject: [PATCH v5 10/13] MIPS: mobileye: eyeq5: add OLB syscon node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240209-mbly-clk-v5-10-f094ee5e918a@bootlin.com>
References: <20240209-mbly-clk-v5-0-f094ee5e918a@bootlin.com>
In-Reply-To: <20240209-mbly-clk-v5-0-f094ee5e918a@bootlin.com>
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

The OLB ("Other Logic Block") is a syscon region hosting the clock,
reset and pin controllers. It contains registers such as I2C speed mode
that need to be accessible by other nodes.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 arch/mips/boot/dts/mobileye/eyeq5.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/mips/boot/dts/mobileye/eyeq5.dtsi b/arch/mips/boot/dts/mobileye/eyeq5.dtsi
index 6cc5980e2fa1..e82d2a57f6da 100644
--- a/arch/mips/boot/dts/mobileye/eyeq5.dtsi
+++ b/arch/mips/boot/dts/mobileye/eyeq5.dtsi
@@ -100,6 +100,14 @@ uart2: serial@a00000 {
 			clock-names = "uartclk", "apb_pclk";
 		};
 
+		olb: system-controller@e00000 {
+			compatible = "mobileye,eyeq5-olb", "syscon", "simple-mfd";
+			reg = <0 0xe00000 0x0 0x400>;
+			ranges = <0x0 0x0 0xe00000 0x400>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
+
 		gic: interrupt-controller@140000 {
 			compatible = "mti,gic";
 			reg = <0x0 0x140000 0x0 0x20000>;

-- 
2.43.0


