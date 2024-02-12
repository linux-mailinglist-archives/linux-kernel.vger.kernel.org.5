Return-Path: <linux-kernel+bounces-61741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2C685160D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3E40B24E95
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20304D13B;
	Mon, 12 Feb 2024 13:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Vy96bdXJ"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8536B481D7;
	Mon, 12 Feb 2024 13:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707745489; cv=none; b=UKt8eFdFAhvmDuxshIFFVNc33J7NdubRmniP3Dr7nYiAoBz3cYfYXx88A3iS2tQn+MiOirgcgdIM9F3DiMKN3MXvLJzmPR0sJB1CqoyXLuCycxpfZpmcdEvUlWyHdv8Uqh1zauCgJgInaikQZpBkR8qPm9ds4tB6MEF+bkY3J9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707745489; c=relaxed/simple;
	bh=7tacFbATuHLACojMWVe1Fb8Dq1zbXatLfDzZr+nBHhk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FS76YrI6ksYmJ4sidCAjOme9vaYDJoGygSTL80PIOwvxHvISnoBDEbYSYbLx0qMCH+6vAAMkVN3JRFk0NMmIwVHjqTWx91qLuZDmYwuWORT+8EP3feLObWgedxi4Wf3tn8rA58a5AySAem3lDPZv5+A0zya+gCY5zps5q318Rq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Vy96bdXJ; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 14964FF80A;
	Mon, 12 Feb 2024 13:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707745484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BaAH/txD0ZSJCug0F9IruK7CsdNif1nz4F+71F4j3Ts=;
	b=Vy96bdXJeXnd6fVN3a30bH/PBBI8xN/2tianri1oWSW0Q1EllkegwlV+lwXoF4E1ougfY6
	ZgoriIaddapZwgOSOBZF9rRNFBoVbBlDEJfK2ZD0PUa3bGQSepwKHV2RkHTnM7hz6WmlbR
	8iWvNMuFJg2S/vRRWRP7MPmNZT8/HyVHlpz1eviGZukcOS3qOv7iF3KgWcrOdDOqnLfVFK
	8jctAXsFQP553X1KfJi9DoBV6TCic+HyX1fT8ksTv7WlLY7awq/0ZHAKIoDqPet+8nbHJl
	BlMmAR7m9E2TAZ+txAO8/gWFK35bY89bykhGG/Lh2NVyPpDEPVcyP8PQSM6AsQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Mon, 12 Feb 2024 14:44:43 +0100
Subject: [PATCH v6 12/13] MIPS: mobileye: eyeq5: add OLB reset controller
 node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240212-mbly-clk-v6-12-c46fa1f93839@bootlin.com>
References: <20240212-mbly-clk-v6-0-c46fa1f93839@bootlin.com>
In-Reply-To: <20240212-mbly-clk-v6-0-c46fa1f93839@bootlin.com>
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
2.43.0


