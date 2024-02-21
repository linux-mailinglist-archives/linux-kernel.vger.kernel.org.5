Return-Path: <linux-kernel+bounces-75279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7E785E5CA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C5C51C2401C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B323F12837E;
	Wed, 21 Feb 2024 18:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="g+QnhhmE"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17BC86ACE;
	Wed, 21 Feb 2024 18:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708539746; cv=none; b=CSZGgIN9hYDbOYMfXqN/SAgagRhBsC1ivXWXHlUDYdRGYq9r6VL5xPhmF4Zf8vgAqfoHk4GUwsUxfVnRFSULHDNpAEVeCPkl0L8mxqpWO8ur8Adt8hvSmOyLG7nqiv/xQG5zHi1C0+9I7jNNVU+k6x9nui3Ou0hggLm2oEe3ygw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708539746; c=relaxed/simple;
	bh=4FS3o7ZWnUfxMsTqNZlzB8T/fnOsHC/iBF7lgUCvZhA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hMTXp5zTFbco6lyci0Ra1jtP2ooztUSGKHLrpjk3cGsvJydVQl5APpnXPht3DGMyhpg2WwRZdJJVkZ+TSfc42QQoKOQ/l2jtIPjkEv/UYCbShRemrvbNUOxNeLp3McPN78F/RhI1Y04RLzj8joFYx8zYo902vFtaUQuY8o9DObo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=g+QnhhmE; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A76AB1C0009;
	Wed, 21 Feb 2024 18:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708539742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qQE00hj6aCsO8HAaXmw7EJeS3I06858DGf/Z+exIm+0=;
	b=g+QnhhmE8+mjR7UghjCFIe97Z4KakC9U1IPB1jHO09pR6k3wAKjL/wTWbyyUdls5BRLpgp
	btMTkbEKOcZDv+T3peYWW/OVHvWWb3ZtfR6wogmH0mHJUAtR854b+pxFwYoxei+50Y2+yr
	AoWfGCoy/DF78gRxOlKd4Prcmk7rXyIffS1q02+G6HXuqsR8uwZ85P6tNnNPLjGqu6CsC0
	8SSpm7ciVXwZ4/LzyhONK10XPlv4OzTfvo5Czt6BwHxUiKP3fzDIEuDjZFIcRojHjkUiQi
	WeBfMUW4WMMKDX2ikZlGxqe+CCBarPcrfKBAi2gGwBdWs5K0bDzEJ2uuAtweEw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 21 Feb 2024 19:22:20 +0100
Subject: [PATCH v7 12/14] MIPS: mobileye: eyeq5: use OLB clocks controller
 node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240221-mbly-clk-v7-12-31d4ce3630c3@bootlin.com>
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

We add the clock controller inside the OLB syscon region and remove
previous fixed devicetree nodes representing PLLs exposed by the clock
controller.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 .../{eyeq5-fixed-clocks.dtsi => eyeq5-clocks.dtsi} | 54 +++++++---------------
 arch/mips/boot/dts/mobileye/eyeq5.dtsi             | 11 ++++-
 2 files changed, 26 insertions(+), 39 deletions(-)

diff --git a/arch/mips/boot/dts/mobileye/eyeq5-fixed-clocks.dtsi b/arch/mips/boot/dts/mobileye/eyeq5-clocks.dtsi
similarity index 88%
rename from arch/mips/boot/dts/mobileye/eyeq5-fixed-clocks.dtsi
rename to arch/mips/boot/dts/mobileye/eyeq5-clocks.dtsi
index 78f5533a95c6..aa6db704a786 100644
--- a/arch/mips/boot/dts/mobileye/eyeq5-fixed-clocks.dtsi
+++ b/arch/mips/boot/dts/mobileye/eyeq5-clocks.dtsi
@@ -3,42 +3,20 @@
  * Copyright 2023 Mobileye Vision Technologies Ltd.
  */
 
+#include <dt-bindings/clock/mobileye,eyeq5-clk.h>
+
 / {
 	/* Fixed clock */
-	pll_cpu: pll-cpu {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <1500000000>;
-	};
-
-	pll_vdi: pll-vdi {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <1280000000>;
-	};
-
-	pll_per: pll-per {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <2000000000>;
-	};
-
-	pll_ddr0: pll-ddr0 {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <1857210000>;
-	};
-
-	pll_ddr1: pll-ddr1 {
+	xtal: xtal {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
-		clock-frequency = <1857210000>;
+		clock-frequency = <30000000>;
 	};
 
 /* PLL_CPU derivatives */
 	occ_cpu: occ-cpu {
 		compatible = "fixed-factor-clock";
-		clocks = <&pll_cpu>;
+		clocks = <&clocks EQ5C_PLL_CPU>;
 		#clock-cells = <0>;
 		clock-div = <1>;
 		clock-mult = <1>;
@@ -101,7 +79,7 @@ mem_clk: mem-clk {
 	};
 	occ_isram: occ-isram {
 		compatible = "fixed-factor-clock";
-		clocks = <&pll_cpu>;
+		clocks = <&clocks EQ5C_PLL_CPU>;
 		#clock-cells = <0>;
 		clock-div = <2>;
 		clock-mult = <1>;
@@ -115,7 +93,7 @@ isram_clk: isram-clk { /* gate ClkRstGen_isram */
 	};
 	occ_dbu: occ-dbu {
 		compatible = "fixed-factor-clock";
-		clocks = <&pll_cpu>;
+		clocks = <&clocks EQ5C_PLL_CPU>;
 		#clock-cells = <0>;
 		clock-div = <10>;
 		clock-mult = <1>;
@@ -130,7 +108,7 @@ si_dbu_tp_pclk: si-dbu-tp-pclk { /* gate ClkRstGen_dbu */
 /* PLL_VDI derivatives */
 	occ_vdi: occ-vdi {
 		compatible = "fixed-factor-clock";
-		clocks = <&pll_vdi>;
+		clocks = <&clocks EQ5C_PLL_VDI>;
 		#clock-cells = <0>;
 		clock-div = <2>;
 		clock-mult = <1>;
@@ -144,7 +122,7 @@ vdi_clk: vdi-clk { /* gate ClkRstGen_vdi */
 	};
 	occ_can_ser: occ-can-ser {
 		compatible = "fixed-factor-clock";
-		clocks = <&pll_vdi>;
+		clocks = <&clocks EQ5C_PLL_VDI>;
 		#clock-cells = <0>;
 		clock-div = <16>;
 		clock-mult = <1>;
@@ -158,7 +136,7 @@ can_ser_clk: can-ser-clk { /* gate ClkRstGen_can_ser */
 	};
 	i2c_ser_clk: i2c-ser-clk {
 		compatible = "fixed-factor-clock";
-		clocks = <&pll_vdi>;
+		clocks = <&clocks EQ5C_PLL_VDI>;
 		#clock-cells = <0>;
 		clock-div = <20>;
 		clock-mult = <1>;
@@ -166,7 +144,7 @@ i2c_ser_clk: i2c-ser-clk {
 /* PLL_PER derivatives */
 	occ_periph: occ-periph {
 		compatible = "fixed-factor-clock";
-		clocks = <&pll_per>;
+		clocks = <&clocks EQ5C_PLL_PER>;
 		#clock-cells = <0>;
 		clock-div = <16>;
 		clock-mult = <1>;
@@ -225,7 +203,7 @@ gpio_clk: gpio-clk {
 	};
 	emmc_sys_clk: emmc-sys-clk {
 		compatible = "fixed-factor-clock";
-		clocks = <&pll_per>;
+		clocks = <&clocks EQ5C_PLL_PER>;
 		#clock-cells = <0>;
 		clock-div = <10>;
 		clock-mult = <1>;
@@ -233,7 +211,7 @@ emmc_sys_clk: emmc-sys-clk {
 	};
 	ccf_ctrl_clk: ccf-ctrl-clk {
 		compatible = "fixed-factor-clock";
-		clocks = <&pll_per>;
+		clocks = <&clocks EQ5C_PLL_PER>;
 		#clock-cells = <0>;
 		clock-div = <4>;
 		clock-mult = <1>;
@@ -241,7 +219,7 @@ ccf_ctrl_clk: ccf-ctrl-clk {
 	};
 	occ_mjpeg_core: occ-mjpeg-core {
 		compatible = "fixed-factor-clock";
-		clocks = <&pll_per>;
+		clocks = <&clocks EQ5C_PLL_PER>;
 		#clock-cells = <0>;
 		clock-div = <2>;
 		clock-mult = <1>;
@@ -265,7 +243,7 @@ mjpeg_core_clk: mjpeg-core-clk { /* gate ClkRstGen_mjpeg_gen */
 	};
 	fcmu_a_clk: fcmu-a-clk {
 		compatible = "fixed-factor-clock";
-		clocks = <&pll_per>;
+		clocks = <&clocks EQ5C_PLL_PER>;
 		#clock-cells = <0>;
 		clock-div = <20>;
 		clock-mult = <1>;
@@ -273,7 +251,7 @@ fcmu_a_clk: fcmu-a-clk {
 	};
 	occ_pci_sys: occ-pci-sys {
 		compatible = "fixed-factor-clock";
-		clocks = <&pll_per>;
+		clocks = <&clocks EQ5C_PLL_PER>;
 		#clock-cells = <0>;
 		clock-div = <8>;
 		clock-mult = <1>;
diff --git a/arch/mips/boot/dts/mobileye/eyeq5.dtsi b/arch/mips/boot/dts/mobileye/eyeq5.dtsi
index e82d2a57f6da..1a65b43e13b1 100644
--- a/arch/mips/boot/dts/mobileye/eyeq5.dtsi
+++ b/arch/mips/boot/dts/mobileye/eyeq5.dtsi
@@ -5,7 +5,7 @@
 
 #include <dt-bindings/interrupt-controller/mips-gic.h>
 
-#include "eyeq5-fixed-clocks.dtsi"
+#include "eyeq5-clocks.dtsi"
 
 / {
 	#address-cells = <2>;
@@ -106,6 +106,15 @@ olb: system-controller@e00000 {
 			ranges = <0x0 0x0 0xe00000 0x400>;
 			#address-cells = <1>;
 			#size-cells = <1>;
+
+			clocks: clock-controller@e0002c {
+				compatible = "mobileye,eyeq5-clk";
+				reg = <0x02c 0x50>, <0x11c 0x04>;
+				reg-names = "plls", "ospi";
+				#clock-cells = <1>;
+				clocks = <&xtal>;
+				clock-names = "ref";
+			};
 		};
 
 		gic: interrupt-controller@140000 {

-- 
2.43.2


