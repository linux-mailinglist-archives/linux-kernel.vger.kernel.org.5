Return-Path: <linux-kernel+bounces-88688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BEF86E560
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CB5D1F25C2F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844177581F;
	Fri,  1 Mar 2024 16:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ip/Kh/hX"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2F373191;
	Fri,  1 Mar 2024 16:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709310149; cv=none; b=A9blGHymSi5fbZaCdk+gxPmP3gE48O2f6GenVLndjZ2YzAMuRZQHauxrkW8yB7jLBY5emZQ3aMhwsVX1dcBVf7Weia1ge1oMlpOOoIioroix5cVqFEsgunvyyqLDZnuM7cI8uGQVVbhPzc3MzhlE7IDwT7jKRvYCSjU0jYJt0hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709310149; c=relaxed/simple;
	bh=Q1vQNvApTuVLdHGNKf+3ksoWjYkeKzGyOW6P0xmAFi4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aTT0TpbCFnrl2rjEtAOXQyCz4Fz0DfIGIkE+et8AQ8sWwHH3MZBdI/ZphUfsjz+H/y3PPWwj1y6o7SKeStgHLeQZRZIG6wyLadzP26kD7vJdRf45dcGUEOJcIbR5ZkK6TzeuKWEgBaeB4KEcjPLRbLThweh4pUCqkKYDJOWIYZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ip/Kh/hX; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2A056C0004;
	Fri,  1 Mar 2024 16:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709310144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RkkcturGDH6iyLvdo+o7gBVlQfQ+pKB/Y+IIwDxn5RM=;
	b=ip/Kh/hXjeY72FVe0TeYzjJ2O2LSj1I69GBRNbGEi+RtCiBv/ik8jiaRd1d6C6lMR+f8It
	kEM5Ht2+cyU0iUyzq3IuF8lfwnbrIL7KF4SXYNpmPIG797Vi24wWQxpRQK68JjKvP+ynf3
	MyCakcFuFs7pr97ToVkdgBts+Yoj5+7i0NY6JxFdkn/oUwRhnHw5EUTbQogJns2QJStlpy
	xkfLjLEnW1fyL7ejgZEWnmcXv7SAnazwIB0nHX4gOZAivoR3att3Gp++AlMXCMBx7hF4cN
	UiqTMIop7wvnRtCYyPM4BFQsaVZh7B6IDz8I/8tFBTcWVxAs4uZYW2nzYN4wQA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 01 Mar 2024 17:22:21 +0100
Subject: [PATCH v9 8/9] MIPS: mobileye: eyeq5: add OLB reset controller
 node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240301-mbly-clk-v9-8-cbf06eb88708@bootlin.com>
References: <20240301-mbly-clk-v9-0-cbf06eb88708@bootlin.com>
In-Reply-To: <20240301-mbly-clk-v9-0-cbf06eb88708@bootlin.com>
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
2.44.0


