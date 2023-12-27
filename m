Return-Path: <linux-kernel+bounces-12123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5078F81F056
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 17:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 746F01C21262
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 16:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE2847F73;
	Wed, 27 Dec 2023 16:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Kj7sUyPS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA2845C13;
	Wed, 27 Dec 2023 16:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1B8E5FF815;
	Wed, 27 Dec 2023 16:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1703694248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PHw8m05DOzdhKocLz6vovvFnXaDaWYDfUcSk4DXmRVM=;
	b=Kj7sUyPSUKiUuzGhIbKJ5A3pPmxu89lfjopkVLMeOPGD2QBsopdL6YmMPUr8t5hx8pcAF0
	+lD/9tlIKqF6ksJ7ZBCP+NYiNYciHN3F3z1QpBdJm+AqdLpPi4vhCejrIoqJWiLq4ip3Tl
	UanQcHSN/dqgkNCdVBKTtcMnA8+cz0De5SnLMMDt2HS/8sgp2FHiO0/L7BOUxiidl0CDyG
	cYVbUNLQ1oXC0fUBGHSu8yIEARy+iQlokbmdGxpbCdXf8hlanvSlynaaExCpt2XEwKZSm9
	azIe4n63+VvAiTefbJV7I/ar4YO6M0o/SMyCaB32M78jNEe1IuRRF9PuN5HoIQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 27 Dec 2023 17:23:56 +0100
Subject: [PATCH v2 6/6] MIPS: mobileye: eyeq5: use OLB clocks controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231227-mbly-clk-v2-6-a05db63c380f@bootlin.com>
References: <20231227-mbly-clk-v2-0-a05db63c380f@bootlin.com>
In-Reply-To: <20231227-mbly-clk-v2-0-a05db63c380f@bootlin.com>
To: Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 linux-mips@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: theo.lebrun@bootlin.com

We add the clock controller inside the OLB syscon region and removed
previous fixed devicetree nodes representing PLLs exposed by the clock
controller.

Two quirks are present:

 - The OLB node is moved prior to UARTs, as platform device probe
   scheduling is dependent on devicetree ordering.

 - The core0-timer-clk fixed clock is created to feed the GIC timer. It
   requires a clock earlier than platform bus type initialisation (and
   therefore platform device init).

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 .../{eyeq5-fixed-clocks.dtsi => eyeq5-clocks.dtsi} | 54 ++++++++--------------
 arch/mips/boot/dts/mobileye/eyeq5.dtsi             | 23 +++++----
 2 files changed, 34 insertions(+), 43 deletions(-)

diff --git a/arch/mips/boot/dts/mobileye/eyeq5-fixed-clocks.dtsi b/arch/mips/boot/dts/mobileye/eyeq5-clocks.dtsi
similarity index 89%
rename from arch/mips/boot/dts/mobileye/eyeq5-fixed-clocks.dtsi
rename to arch/mips/boot/dts/mobileye/eyeq5-clocks.dtsi
index 78f5533a95c6..bbdaa399e408 100644
--- a/arch/mips/boot/dts/mobileye/eyeq5-fixed-clocks.dtsi
+++ b/arch/mips/boot/dts/mobileye/eyeq5-clocks.dtsi
@@ -3,42 +3,26 @@
  * Copyright 2023 Mobileye Vision Technologies Ltd.
  */
 
-/ {
-	/* Fixed clock */
-	pll_cpu: pll-cpu {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <1500000000>;
-	};
+#include <dt-bindings/clock/mobileye,eyeq5-clk.h>
 
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
+/ {
+/* Fixed clock */
+	xtal: xtal {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
-		clock-frequency = <1857210000>;
+		clock-frequency = <30000000>;
 	};
 
-	pll_ddr1: pll-ddr1 {
+	core0_timer_clk: core0-timer-clk {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
-		clock-frequency = <1857210000>;
+		clock-frequency = <1500000000>;
 	};
 
 /* PLL_CPU derivatives */
 	occ_cpu: occ-cpu {
 		compatible = "fixed-factor-clock";
-		clocks = <&pll_cpu>;
+		clocks = <&clocks EQ5C_PLL_CPU>;
 		#clock-cells = <0>;
 		clock-div = <1>;
 		clock-mult = <1>;
@@ -101,7 +85,7 @@ mem_clk: mem-clk {
 	};
 	occ_isram: occ-isram {
 		compatible = "fixed-factor-clock";
-		clocks = <&pll_cpu>;
+		clocks = <&clocks EQ5C_PLL_CPU>;
 		#clock-cells = <0>;
 		clock-div = <2>;
 		clock-mult = <1>;
@@ -115,7 +99,7 @@ isram_clk: isram-clk { /* gate ClkRstGen_isram */
 	};
 	occ_dbu: occ-dbu {
 		compatible = "fixed-factor-clock";
-		clocks = <&pll_cpu>;
+		clocks = <&clocks EQ5C_PLL_CPU>;
 		#clock-cells = <0>;
 		clock-div = <10>;
 		clock-mult = <1>;
@@ -130,7 +114,7 @@ si_dbu_tp_pclk: si-dbu-tp-pclk { /* gate ClkRstGen_dbu */
 /* PLL_VDI derivatives */
 	occ_vdi: occ-vdi {
 		compatible = "fixed-factor-clock";
-		clocks = <&pll_vdi>;
+		clocks = <&clocks EQ5C_PLL_VDI>;
 		#clock-cells = <0>;
 		clock-div = <2>;
 		clock-mult = <1>;
@@ -144,7 +128,7 @@ vdi_clk: vdi-clk { /* gate ClkRstGen_vdi */
 	};
 	occ_can_ser: occ-can-ser {
 		compatible = "fixed-factor-clock";
-		clocks = <&pll_vdi>;
+		clocks = <&clocks EQ5C_PLL_VDI>;
 		#clock-cells = <0>;
 		clock-div = <16>;
 		clock-mult = <1>;
@@ -158,7 +142,7 @@ can_ser_clk: can-ser-clk { /* gate ClkRstGen_can_ser */
 	};
 	i2c_ser_clk: i2c-ser-clk {
 		compatible = "fixed-factor-clock";
-		clocks = <&pll_vdi>;
+		clocks = <&clocks EQ5C_PLL_VDI>;
 		#clock-cells = <0>;
 		clock-div = <20>;
 		clock-mult = <1>;
@@ -166,7 +150,7 @@ i2c_ser_clk: i2c-ser-clk {
 /* PLL_PER derivatives */
 	occ_periph: occ-periph {
 		compatible = "fixed-factor-clock";
-		clocks = <&pll_per>;
+		clocks = <&clocks EQ5C_PLL_PER>;
 		#clock-cells = <0>;
 		clock-div = <16>;
 		clock-mult = <1>;
@@ -225,7 +209,7 @@ gpio_clk: gpio-clk {
 	};
 	emmc_sys_clk: emmc-sys-clk {
 		compatible = "fixed-factor-clock";
-		clocks = <&pll_per>;
+		clocks = <&clocks EQ5C_PLL_PER>;
 		#clock-cells = <0>;
 		clock-div = <10>;
 		clock-mult = <1>;
@@ -233,7 +217,7 @@ emmc_sys_clk: emmc-sys-clk {
 	};
 	ccf_ctrl_clk: ccf-ctrl-clk {
 		compatible = "fixed-factor-clock";
-		clocks = <&pll_per>;
+		clocks = <&clocks EQ5C_PLL_PER>;
 		#clock-cells = <0>;
 		clock-div = <4>;
 		clock-mult = <1>;
@@ -241,7 +225,7 @@ ccf_ctrl_clk: ccf-ctrl-clk {
 	};
 	occ_mjpeg_core: occ-mjpeg-core {
 		compatible = "fixed-factor-clock";
-		clocks = <&pll_per>;
+		clocks = <&clocks EQ5C_PLL_PER>;
 		#clock-cells = <0>;
 		clock-div = <2>;
 		clock-mult = <1>;
@@ -265,7 +249,7 @@ mjpeg_core_clk: mjpeg-core-clk { /* gate ClkRstGen_mjpeg_gen */
 	};
 	fcmu_a_clk: fcmu-a-clk {
 		compatible = "fixed-factor-clock";
-		clocks = <&pll_per>;
+		clocks = <&clocks EQ5C_PLL_PER>;
 		#clock-cells = <0>;
 		clock-div = <20>;
 		clock-mult = <1>;
@@ -273,7 +257,7 @@ fcmu_a_clk: fcmu-a-clk {
 	};
 	occ_pci_sys: occ-pci-sys {
 		compatible = "fixed-factor-clock";
-		clocks = <&pll_per>;
+		clocks = <&clocks EQ5C_PLL_PER>;
 		#clock-cells = <0>;
 		clock-div = <8>;
 		clock-mult = <1>;
diff --git a/arch/mips/boot/dts/mobileye/eyeq5.dtsi b/arch/mips/boot/dts/mobileye/eyeq5.dtsi
index d32da8fabe5a..23c67ffbad5b 100644
--- a/arch/mips/boot/dts/mobileye/eyeq5.dtsi
+++ b/arch/mips/boot/dts/mobileye/eyeq5.dtsi
@@ -7,7 +7,7 @@
 
 /memreserve/ 0x40000000 0xc0000000; /* DDR32 */
 
-#include "eyeq5-fixed-clocks.dtsi"
+#include "eyeq5-clocks.dtsi"
 
 / {
 	#address-cells = <2>;
@@ -42,6 +42,19 @@ soc: soc {
 		ranges;
 		compatible = "simple-bus";
 
+		olb: olb@e00000 {
+			compatible = "mobileye,eyeq5-olb", "syscon", "simple-mfd";
+			reg = <0 0xe00000 0x0 0x400>;
+			reg-io-width = <4>;
+
+			clocks: clock-controller {
+				compatible = "mobileye,eyeq5-clk";
+				#clock-cells = <1>;
+				clocks = <&xtal>;
+				clock-names = "ref";
+			};
+		};
+
 		uart0: serial@800000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0 0x800000 0x0 0x1000>;
@@ -72,12 +85,6 @@ uart2: serial@a00000 {
 			clock-names = "uartclk", "apb_pclk";
 		};
 
-		olb: olb@e00000 {
-			compatible = "mobileye,eyeq5-olb", "syscon", "simple-mfd";
-			reg = <0 0xe00000 0x0 0x400>;
-			reg-io-width = <4>;
-		};
-
 		gic: interrupt-controller@140000 {
 			compatible = "mti,gic";
 			reg = <0x0 0x140000 0x0 0x20000>;
@@ -95,7 +102,7 @@ gic: interrupt-controller@140000 {
 			timer {
 				compatible = "mti,gic-timer";
 				interrupts = <GIC_LOCAL 1 IRQ_TYPE_NONE>;
-				clocks = <&core0_clk>;
+				clocks = <&core0_timer_clk>;
 			};
 		};
 	};

-- 
2.43.0


