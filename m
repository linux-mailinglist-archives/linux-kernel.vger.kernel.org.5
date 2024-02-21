Return-Path: <linux-kernel+bounces-75280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7560C85E5CB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14CE01F26CE6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD1312880D;
	Wed, 21 Feb 2024 18:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dp7xOejO"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA49E126F04;
	Wed, 21 Feb 2024 18:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708539747; cv=none; b=DWUPX7jRp2WC7n69Rvr1TStd3s6nzViDF2HlBcAwLEB3ZVn3WBvSx8m+18GAQjRHI6QLMjnv+qSJEguikjOepPS2+2OwsGStJLsrEN2gheTCuaiYqvYRS3UZcBlxjs9YNBS88OBjKGXuNPdCK91BICMxaKL/YfN6yoez+5MatrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708539747; c=relaxed/simple;
	bh=gfXf3/Hixb5jRDcV9G5x/rfTcx5OW4kiosEC0HyIzdg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nj0qX0DsMWTw0p3U1B4BTaT+OzXp5t0fJgUGHk4yPjhoNqDQZqF8KBPilqSjoZb6TB98TZmu3Y0BL5MmmtalwJQ2mGmTT9j/dN1g4we1wekaqSm+4o1dZznrip+oEyio9vQ9jJvkCQetE8Q3iXGjxGbcjYlI5JwdCa+UK/pkOwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dp7xOejO; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 75AC71C000D;
	Wed, 21 Feb 2024 18:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708539743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6K2cpP1kyacxCl/LufjKMgr4VxYxhZyln51deU43LfI=;
	b=dp7xOejOeqb0tpbI0fz0toYAjcIqPOEfd+SxxbfBXXgi1LuA+Gf/g+xxk3rmwCu/4JOgLw
	KPQmpJG+BoF1arx9o6WeeTQGTpipobh5VJRsvCpU8n9/u9aoeLFCo93gOAtwzE8alCGfMS
	6EmcAxq3t8jmSAiB/mfMBxMziA7iK987KDHWoQxEW0O+Mky6xizVG7EEXvTRX0Wdm231BH
	98nv4kVMnfVyy20Wo8x86htBhaA7x/jnkSULddUIIX8BkgACxRuvajtx7zj3l9kzA3z1Xw
	SP2hAy0zWY7IvY2rYSE7F26Q4RvoenQ+oPJjgr4kiWGb9Ql50zkqjktg6Pz+aQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 21 Feb 2024 19:22:21 +0100
Subject: [PATCH v7 13/14] MIPS: mobileye: eyeq5: add OLB reset controller
 node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240221-mbly-clk-v7-13-31d4ce3630c3@bootlin.com>
References: <20240221-mbly-clk-v7-0-31d4ce3630c3@bootlin.com>
In-Reply-To: <20240221-mbly-clk-v7-0-31d4ce3630c3@bootlin.com>
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
X-Mailer: b4 0.13.0
X-GND-Sasl: theo.lebrun@bootlin.com

Add the devicetree node for the reset controller on the Mobileye EyeQ5
platform. It appears as a subnode to the OLB syscon as its registers
are located in this shared register region.

Add reset phandles to UART nodes.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 arch/mips/boot/dts/mobileye/eyeq5.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/mips/boot/dts/mobileye/eyeq5.dtsi b/arch/mips/boot/dts/mobileye/eyeq5.dtsi
index 1a65b43e13b1..76935f237ab5 100644
--- a/arch/mips/boot/dts/mobileye/eyeq5.dtsi
+++ b/arch/mips/boot/dts/mobileye/eyeq5.dtsi
@@ -78,6 +78,7 @@ uart0: serial@800000 {
 			interrupts = <GIC_SHARED 6 IRQ_TYPE_LEVEL_HIGH>;
 			clocks  = <&uart_clk>, <&occ_periph>;
 			clock-names = "uartclk", "apb_pclk";
+			resets = <&reset 0 10>;
 		};
 
 		uart1: serial@900000 {
@@ -88,6 +89,7 @@ uart1: serial@900000 {
 			interrupts = <GIC_SHARED 6 IRQ_TYPE_LEVEL_HIGH>;
 			clocks  = <&uart_clk>, <&occ_periph>;
 			clock-names = "uartclk", "apb_pclk";
+			resets = <&reset 0 11>;
 		};
 
 		uart2: serial@a00000 {
@@ -98,6 +100,7 @@ uart2: serial@a00000 {
 			interrupts = <GIC_SHARED 6 IRQ_TYPE_LEVEL_HIGH>;
 			clocks  = <&uart_clk>, <&occ_periph>;
 			clock-names = "uartclk", "apb_pclk";
+			resets = <&reset 0 12>;
 		};
 
 		olb: system-controller@e00000 {
@@ -107,6 +110,13 @@ olb: system-controller@e00000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 
+			reset: reset-controller@e00000 {
+				compatible = "mobileye,eyeq5-reset";
+				reg = <0x000 0x0c>, <0x200 0x34>, <0x120 0x04>;
+				reg-names = "d0", "d1", "d2";
+				#reset-cells = <2>;
+			};
+
 			clocks: clock-controller@e0002c {
 				compatible = "mobileye,eyeq5-clk";
 				reg = <0x02c 0x50>, <0x11c 0x04>;

-- 
2.43.2


