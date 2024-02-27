Return-Path: <linux-kernel+bounces-83449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C4C869984
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5AF11F2C18F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC8814DFF5;
	Tue, 27 Feb 2024 14:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="e7MTeAjB"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E450C149011;
	Tue, 27 Feb 2024 14:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709045745; cv=none; b=UxigakGSg78H0OClMboV7NA3tJFqZ12kbSvfzx0e7oqkqU7eBHoCaP7w4OYdXlyL6Jjg1k2uHfzx7rrVG6cJmnKCY+0ErBptkuMIdceBWU0xcxm1aquyA1qWC5MH8bkIrIxf/1RArJqK9DTPXzwcmuvNV2bUhIwRMXsF/TFeQwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709045745; c=relaxed/simple;
	bh=tK4x4KGtYIXb7OTHT3sFaJe5r/9OUZNpPI5rSRlDXrg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hp8tgVi8CBI4gBjNbi92kVPxM9TH1sFAdy8bonLQPdQ49XQOVRsHSxOiv8i4d6uNuA7pPFtPmiuqBSRRyGNjLyByzIAncjO5BwozTjsGDyrKx2bL4lHim1lfwHbG9N0F4q1aqkWr+1PQj/ZEvryrt8fcjzu1czUmyOhYlYQlcfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=e7MTeAjB; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3C8EF20008;
	Tue, 27 Feb 2024 14:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709045741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v1HP/zKCNKZ7DKj4WcSicb0WzfIqg8843dS/QsXReo0=;
	b=e7MTeAjB1+3G1TvpwSyLtNIicMg452UE5OfHEWLDIzDTZ+zID8O++L9ABst8cvD99S3guv
	jldqfDFNoYsP81FUPLqdvMotv0/g8HgClDdv5V3xBHyJOIdUv9UhnUPN8Tj9UN6ihL4vfz
	dnE6aVUQxbkgDoj3cQqR3gcjb36DZ5gYo3eWPTp+GZG5uXqvYfxurhLIK+jGqCq1SWp9JR
	6Hw6OxDtgqZHSWqrkKyaK6+LX/+KFne/oR2CRBL7elZU74KU4wmpa5dbrp1XouVUfhAy0z
	ICyNJdvgvYdrXyegfoLERZ7LxlZsLF3UVaA50q1GxGse9WXavo0wyLJ6ocA8XQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Tue, 27 Feb 2024 15:55:29 +0100
Subject: [PATCH v8 08/10] MIPS: mobileye: eyeq5: use OLB clocks controller
 node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240227-mbly-clk-v8-8-c57fbda7664a@bootlin.com>
References: <20240227-mbly-clk-v8-0-c57fbda7664a@bootlin.com>
In-Reply-To: <20240227-mbly-clk-v8-0-c57fbda7664a@bootlin.com>
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
2.44.0


