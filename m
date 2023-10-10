Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEEA87C40BB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 22:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbjJJUFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 16:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234410AbjJJUEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 16:04:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178A712D;
        Tue, 10 Oct 2023 13:04:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8121FC433CA;
        Tue, 10 Oct 2023 20:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696968248;
        bh=C24GvUVtayAqMzBXuo0W6tcUajLr6iifjKQSAytcvyU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WRS7ujy4bPp0XEZ4NE32PFD+pjJdD+lUIpCAJrbzhnR4zgHkjHjilknG7xrdYvg5U
         VMIk/pXhP3Iz3hoRA6h+fok3WQtwQrnEiIRsEb3opZMju8ZV7ktCRP/2apHYNj+Q+r
         GVi15OaHAe586Tk9EIcNU3VoAylKScB196MYOdEo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.10.198
Date:   Tue, 10 Oct 2023 22:03:58 +0200
Message-ID: <2023101058-riveter-carded-1d5d@gregkh>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <2023101058-enchilada-helpless-2a72@gregkh>
References: <2023101058-enchilada-helpless-2a72@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index 12986f3532a9..470e11dcf2a3 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 10
-SUBLEVEL = 197
+SUBLEVEL = 198
 EXTRAVERSION =
 NAME = Dare mighty things
 
diff --git a/arch/arm/boot/dts/am335x-guardian.dts b/arch/arm/boot/dts/am335x-guardian.dts
index 1918766c1f80..9594276acf9d 100644
--- a/arch/arm/boot/dts/am335x-guardian.dts
+++ b/arch/arm/boot/dts/am335x-guardian.dts
@@ -100,11 +100,12 @@ panel-info {
 
 	};
 
-	pwm7: dmtimer-pwm {
+	guardian_beeper: pwm-7 {
 		compatible = "ti,omap-dmtimer-pwm";
+		#pwm-cells = <3>;
 		ti,timers = <&timer7>;
 		pinctrl-names = "default";
-		pinctrl-0 = <&dmtimer7_pins>;
+		pinctrl-0 = <&guardian_beeper_pins>;
 		ti,clock-source = <0x01>;
 	};
 
@@ -343,9 +344,9 @@ AM33XX_IOPAD(0x9b4, PIN_OUTPUT_PULLDOWN | MUX_MODE3)
 		>;
 	};
 
-	dmtimer7_pins: pinmux_dmtimer7_pins {
+	guardian_beeper_pins: pinmux_dmtimer7_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x968, PIN_OUTPUT | MUX_MODE5)
+			AM33XX_IOPAD(0x968, PIN_OUTPUT | MUX_MODE5) /* (E18) timer7 */
 		>;
 	};
 
diff --git a/arch/arm/boot/dts/am3517-evm.dts b/arch/arm/boot/dts/am3517-evm.dts
index c8b80f156ec9..9cc1ae36c420 100644
--- a/arch/arm/boot/dts/am3517-evm.dts
+++ b/arch/arm/boot/dts/am3517-evm.dts
@@ -150,7 +150,7 @@ bl: backlight {
 		enable-gpios = <&gpio6 22 GPIO_ACTIVE_HIGH>; /* gpio_182 */
 	};
 
-	pwm11: dmtimer-pwm@11 {
+	pwm11: pwm-11 {
 		compatible = "ti,omap-dmtimer-pwm";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwm_pins>;
diff --git a/arch/arm/boot/dts/logicpd-torpedo-baseboard.dtsi b/arch/arm/boot/dts/logicpd-torpedo-baseboard.dtsi
index 533a47bc4a53..1386a5e63eff 100644
--- a/arch/arm/boot/dts/logicpd-torpedo-baseboard.dtsi
+++ b/arch/arm/boot/dts/logicpd-torpedo-baseboard.dtsi
@@ -59,7 +59,7 @@ led2 {
 		};
 	};
 
-	pwm10: dmtimer-pwm {
+	pwm10: pwm-10 {
 		compatible = "ti,omap-dmtimer-pwm";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwm_pins>;
diff --git a/arch/arm/boot/dts/motorola-mapphone-common.dtsi b/arch/arm/boot/dts/motorola-mapphone-common.dtsi
index 5f8f77cfbe59..8cb26b924d3c 100644
--- a/arch/arm/boot/dts/motorola-mapphone-common.dtsi
+++ b/arch/arm/boot/dts/motorola-mapphone-common.dtsi
@@ -156,7 +156,7 @@ soundcard {
 		dais = <&mcbsp2_port>, <&mcbsp3_port>;
 	};
 
-	pwm8: dmtimer-pwm-8 {
+	pwm8: pwm-8 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&vibrator_direction_pin>;
 
@@ -166,7 +166,7 @@ pwm8: dmtimer-pwm-8 {
 		ti,clock-source = <0x01>;
 	};
 
-	pwm9: dmtimer-pwm-9 {
+	pwm9: pwm-9 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&vibrator_enable_pin>;
 
@@ -192,6 +192,29 @@ backlight: backlight {
 	};
 };
 
+&cpu_thermal {
+	polling-delay = <10000>; /* milliseconds */
+};
+
+&cpu_alert0 {
+        temperature = <80000>; /* millicelsius */
+};
+
+&cpu0 {
+        /*
+	 * Note that the 1.2GiHz mode is enabled for all SoC variants for
+	 * the Motorola Android Linux v3.0.8 based kernel.
+	 */
+        operating-points = <
+	        /* kHz    uV */
+	        300000  1025000
+	        600000  1200000
+	        800000  1313000
+	        1008000 1375000
+		1200000 1375000
+        >;
+};
+
 &dss {
 	status = "okay";
 };
@@ -384,7 +407,7 @@ &mmc3 {
 	#address-cells = <1>;
 	#size-cells = <0>;
 	wlcore: wlcore@2 {
-		compatible = "ti,wl1285", "ti,wl1283";
+		compatible = "ti,wl1285";
 		reg = <2>;
 		/* gpio_100 with gpmc_wait2 pad as wakeirq */
 		interrupts-extended = <&gpio4 4 IRQ_TYPE_LEVEL_HIGH>,
@@ -716,12 +739,12 @@ &rng_target {
 /* Configure pwm clock source for timers 8 & 9 */
 &timer8 {
 	assigned-clocks = <&abe_clkctrl OMAP4_TIMER8_CLKCTRL 24>;
-	assigned-clock-parents = <&sys_clkin_ck>;
+	assigned-clock-parents = <&sys_32k_ck>;
 };
 
 &timer9 {
 	assigned-clocks = <&l4_per_clkctrl OMAP4_TIMER9_CLKCTRL 24>;
-	assigned-clock-parents = <&sys_clkin_ck>;
+	assigned-clock-parents = <&sys_32k_ck>;
 };
 
 /*
diff --git a/arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi b/arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi
index ded7e8fec9eb..9cf52650f073 100644
--- a/arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi
+++ b/arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi
@@ -8,9 +8,9 @@
 
 / {
 	vddvario: regulator-vddvario {
-		  compatible = "regulator-fixed";
-		  regulator-name = "vddvario";
-		  regulator-always-on;
+		compatible = "regulator-fixed";
+		regulator-name = "vddvario";
+		regulator-always-on;
 	};
 
 	vdd33a: regulator-vdd33a {
diff --git a/arch/arm/boot/dts/omap-gpmc-smsc9221.dtsi b/arch/arm/boot/dts/omap-gpmc-smsc9221.dtsi
index e7534fe9c53c..bc8961f3690f 100644
--- a/arch/arm/boot/dts/omap-gpmc-smsc9221.dtsi
+++ b/arch/arm/boot/dts/omap-gpmc-smsc9221.dtsi
@@ -12,9 +12,9 @@
 
 / {
 	vddvario: regulator-vddvario {
-		  compatible = "regulator-fixed";
-		  regulator-name = "vddvario";
-		  regulator-always-on;
+		compatible = "regulator-fixed";
+		regulator-name = "vddvario";
+		regulator-always-on;
 	};
 
 	vdd33a: regulator-vdd33a {
diff --git a/arch/arm/boot/dts/omap3-cm-t3517.dts b/arch/arm/boot/dts/omap3-cm-t3517.dts
index 3b8349094baa..f25c0a84a190 100644
--- a/arch/arm/boot/dts/omap3-cm-t3517.dts
+++ b/arch/arm/boot/dts/omap3-cm-t3517.dts
@@ -11,12 +11,12 @@ / {
 	model = "CompuLab CM-T3517";
 	compatible = "compulab,omap3-cm-t3517", "ti,am3517", "ti,omap3";
 
-	vmmc:  regulator-vmmc {
-                compatible = "regulator-fixed";
-                regulator-name = "vmmc";
-                regulator-min-microvolt = <3300000>;
-                regulator-max-microvolt = <3300000>;
-        };
+	vmmc: regulator-vmmc {
+		compatible = "regulator-fixed";
+		regulator-name = "vmmc";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
 
 	wl12xx_vmmc2: wl12xx_vmmc2 {
 		compatible = "regulator-fixed";
diff --git a/arch/arm/boot/dts/omap3-cpu-thermal.dtsi b/arch/arm/boot/dts/omap3-cpu-thermal.dtsi
index 1ed837859374..51e6c2d42be2 100644
--- a/arch/arm/boot/dts/omap3-cpu-thermal.dtsi
+++ b/arch/arm/boot/dts/omap3-cpu-thermal.dtsi
@@ -15,8 +15,7 @@ cpu_thermal: cpu_thermal {
 	polling-delay = <1000>; /* milliseconds */
 	coefficients = <0 20000>;
 
-			/* sensor       ID */
-	thermal-sensors = <&bandgap     0>;
+	thermal-sensors = <&bandgap>;
 
 	cpu_trips: trips {
 		cpu_alert0: cpu_alert {
diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index e61e5ddbf202..68e56b50652a 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -147,7 +147,7 @@ backlight: backlight {
 		pinctrl-0 = <&backlight_pins>;
 	};
 
-	pwm11: dmtimer-pwm {
+	pwm11: pwm-11 {
 		compatible = "ti,omap-dmtimer-pwm";
 		ti,timers = <&timer11>;
 		#pwm-cells = <3>;
@@ -332,7 +332,7 @@ OMAP3_CORE1_IOPAD(0x2106, PIN_OUTPUT | MUX_MODE0)   /* dss_data21.dss_data21 */
 			OMAP3_CORE1_IOPAD(0x2108, PIN_OUTPUT | MUX_MODE0)   /* dss_data22.dss_data22 */
 			OMAP3_CORE1_IOPAD(0x210a, PIN_OUTPUT | MUX_MODE0)   /* dss_data23.dss_data23 */
 		>;
-       };
+	};
 
 	gps_pins: pinmux_gps_pins {
 		pinctrl-single,pins = <
@@ -866,8 +866,8 @@ &mcbsp4 { /* GSM voice PCM */
 };
 
 &hdqw1w {
-        pinctrl-names = "default";
-        pinctrl-0 = <&hdq_pins>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&hdq_pins>;
 };
 
 /* image signal processor within OMAP3 SoC */
diff --git a/arch/arm/boot/dts/omap3-ldp.dts b/arch/arm/boot/dts/omap3-ldp.dts
index 9c6a92724590..b898e2f6f41d 100644
--- a/arch/arm/boot/dts/omap3-ldp.dts
+++ b/arch/arm/boot/dts/omap3-ldp.dts
@@ -301,5 +301,5 @@ &usb_otg_hs {
 
 &vaux1 {
 	/* Needed for ads7846 */
-        regulator-name = "vcc";
+	regulator-name = "vcc";
 };
diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index d40c3d2c4914..7dafd69b7d35 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -156,7 +156,7 @@ battery: n900-battery {
 		io-channel-names = "temp", "bsi", "vbat";
 	};
 
-	pwm9: dmtimer-pwm {
+	pwm9: pwm-9 {
 		compatible = "ti,omap-dmtimer-pwm";
 		#pwm-cells = <3>;
 		ti,timers = <&timer9>;
@@ -236,27 +236,27 @@ gpmc_pins: pinmux_gpmc_pins {
 		pinctrl-single,pins = <
 
 			/* address lines */
-                        OMAP3_CORE1_IOPAD(0x207a, PIN_OUTPUT | MUX_MODE0)       /* gpmc_a1.gpmc_a1 */
-                        OMAP3_CORE1_IOPAD(0x207c, PIN_OUTPUT | MUX_MODE0)       /* gpmc_a2.gpmc_a2 */
-                        OMAP3_CORE1_IOPAD(0x207e, PIN_OUTPUT | MUX_MODE0)       /* gpmc_a3.gpmc_a3 */
+			OMAP3_CORE1_IOPAD(0x207a, PIN_OUTPUT | MUX_MODE0)       /* gpmc_a1.gpmc_a1 */
+			OMAP3_CORE1_IOPAD(0x207c, PIN_OUTPUT | MUX_MODE0)       /* gpmc_a2.gpmc_a2 */
+			OMAP3_CORE1_IOPAD(0x207e, PIN_OUTPUT | MUX_MODE0)       /* gpmc_a3.gpmc_a3 */
 
 			/* data lines, gpmc_d0..d7 not muxable according to TRM */
-                        OMAP3_CORE1_IOPAD(0x209e, PIN_INPUT | MUX_MODE0)        /* gpmc_d8.gpmc_d8 */
-                        OMAP3_CORE1_IOPAD(0x20a0, PIN_INPUT | MUX_MODE0)        /* gpmc_d9.gpmc_d9 */
-                        OMAP3_CORE1_IOPAD(0x20a2, PIN_INPUT | MUX_MODE0)        /* gpmc_d10.gpmc_d10 */
-                        OMAP3_CORE1_IOPAD(0x20a4, PIN_INPUT | MUX_MODE0)        /* gpmc_d11.gpmc_d11 */
-                        OMAP3_CORE1_IOPAD(0x20a6, PIN_INPUT | MUX_MODE0)        /* gpmc_d12.gpmc_d12 */
-                        OMAP3_CORE1_IOPAD(0x20a8, PIN_INPUT | MUX_MODE0)        /* gpmc_d13.gpmc_d13 */
-                        OMAP3_CORE1_IOPAD(0x20aa, PIN_INPUT | MUX_MODE0)        /* gpmc_d14.gpmc_d14 */
-                        OMAP3_CORE1_IOPAD(0x20ac, PIN_INPUT | MUX_MODE0)        /* gpmc_d15.gpmc_d15 */
+			OMAP3_CORE1_IOPAD(0x209e, PIN_INPUT | MUX_MODE0)        /* gpmc_d8.gpmc_d8 */
+			OMAP3_CORE1_IOPAD(0x20a0, PIN_INPUT | MUX_MODE0)        /* gpmc_d9.gpmc_d9 */
+			OMAP3_CORE1_IOPAD(0x20a2, PIN_INPUT | MUX_MODE0)        /* gpmc_d10.gpmc_d10 */
+			OMAP3_CORE1_IOPAD(0x20a4, PIN_INPUT | MUX_MODE0)        /* gpmc_d11.gpmc_d11 */
+			OMAP3_CORE1_IOPAD(0x20a6, PIN_INPUT | MUX_MODE0)        /* gpmc_d12.gpmc_d12 */
+			OMAP3_CORE1_IOPAD(0x20a8, PIN_INPUT | MUX_MODE0)        /* gpmc_d13.gpmc_d13 */
+			OMAP3_CORE1_IOPAD(0x20aa, PIN_INPUT | MUX_MODE0)        /* gpmc_d14.gpmc_d14 */
+			OMAP3_CORE1_IOPAD(0x20ac, PIN_INPUT | MUX_MODE0)        /* gpmc_d15.gpmc_d15 */
 
 			/*
 			 * gpmc_ncs0, gpmc_nadv_ale, gpmc_noe, gpmc_nwe, gpmc_wait0 not muxable
 			 * according to TRM. OneNAND seems to require PIN_INPUT on clock.
 			 */
-                        OMAP3_CORE1_IOPAD(0x20b0, PIN_OUTPUT | MUX_MODE0)       /* gpmc_ncs1.gpmc_ncs1 */
-                        OMAP3_CORE1_IOPAD(0x20be, PIN_INPUT | MUX_MODE0)        /* gpmc_clk.gpmc_clk */
-		>;
+			OMAP3_CORE1_IOPAD(0x20b0, PIN_OUTPUT | MUX_MODE0)       /* gpmc_ncs1.gpmc_ncs1 */
+			OMAP3_CORE1_IOPAD(0x20be, PIN_INPUT | MUX_MODE0)        /* gpmc_clk.gpmc_clk */
+			>;
 	};
 
 	i2c1_pins: pinmux_i2c1_pins {
@@ -738,12 +738,12 @@ tpa6130a2: tpa6130a2@60 {
 
 	si4713: si4713@63 {
 		compatible = "silabs,si4713";
-                reg = <0x63>;
+		reg = <0x63>;
 
-                interrupts-extended = <&gpio2 21 IRQ_TYPE_EDGE_FALLING>; /* 53 */
-                reset-gpios = <&gpio6 3 GPIO_ACTIVE_HIGH>; /* 163 */
-                vio-supply = <&vio>;
-                vdd-supply = <&vaux1>;
+		interrupts-extended = <&gpio2 21 IRQ_TYPE_EDGE_FALLING>; /* 53 */
+		reset-gpios = <&gpio6 3 GPIO_ACTIVE_HIGH>; /* 163 */
+		vio-supply = <&vio>;
+		vdd-supply = <&vaux1>;
 	};
 
 	bq24150a: bq24150a@6b {
diff --git a/arch/arm/boot/dts/omap3-zoom3.dts b/arch/arm/boot/dts/omap3-zoom3.dts
index 0482676d1830..ce58b1f208e8 100644
--- a/arch/arm/boot/dts/omap3-zoom3.dts
+++ b/arch/arm/boot/dts/omap3-zoom3.dts
@@ -23,9 +23,9 @@ memory@80000000 {
 	};
 
 	vddvario: regulator-vddvario {
-		  compatible = "regulator-fixed";
-		  regulator-name = "vddvario";
-		  regulator-always-on;
+		compatible = "regulator-fixed";
+		regulator-name = "vddvario";
+		regulator-always-on;
 	};
 
 	vdd33a: regulator-vdd33a {
@@ -84,28 +84,28 @@ OMAP3_CORE1_IOPAD(0x21d0, PIN_INPUT_PULLUP | MUX_MODE3)	/* mcspi1_cs1.sdmmc3_cmd
 
 	uart1_pins: pinmux_uart1_pins {
 		pinctrl-single,pins = <
-                        OMAP3_CORE1_IOPAD(0x2180, PIN_INPUT | MUX_MODE0)		/* uart1_cts.uart1_cts */
-                        OMAP3_CORE1_IOPAD(0x217e, PIN_OUTPUT | MUX_MODE0)		/* uart1_rts.uart1_rts */
-                        OMAP3_CORE1_IOPAD(0x2182, WAKEUP_EN | PIN_INPUT | MUX_MODE0) /* uart1_rx.uart1_rx */
-                        OMAP3_CORE1_IOPAD(0x217c, PIN_OUTPUT | MUX_MODE0)		/* uart1_tx.uart1_tx */
+			OMAP3_CORE1_IOPAD(0x2180, PIN_INPUT | MUX_MODE0)		/* uart1_cts.uart1_cts */
+			OMAP3_CORE1_IOPAD(0x217e, PIN_OUTPUT | MUX_MODE0)		/* uart1_rts.uart1_rts */
+			OMAP3_CORE1_IOPAD(0x2182, WAKEUP_EN | PIN_INPUT | MUX_MODE0) /* uart1_rx.uart1_rx */
+			OMAP3_CORE1_IOPAD(0x217c, PIN_OUTPUT | MUX_MODE0)		/* uart1_tx.uart1_tx */
 		>;
 	};
 
 	uart2_pins: pinmux_uart2_pins {
 		pinctrl-single,pins = <
-                        OMAP3_CORE1_IOPAD(0x2174, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart2_cts.uart2_cts */
-                        OMAP3_CORE1_IOPAD(0x2176, PIN_OUTPUT | MUX_MODE0)		/* uart2_rts.uart2_rts */
-                        OMAP3_CORE1_IOPAD(0x217a, PIN_INPUT | MUX_MODE0)		/* uart2_rx.uart2_rx */
-                        OMAP3_CORE1_IOPAD(0x2178, PIN_OUTPUT | MUX_MODE0)		/* uart2_tx.uart2_tx */
+			OMAP3_CORE1_IOPAD(0x2174, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart2_cts.uart2_cts */
+			OMAP3_CORE1_IOPAD(0x2176, PIN_OUTPUT | MUX_MODE0)		/* uart2_rts.uart2_rts */
+			OMAP3_CORE1_IOPAD(0x217a, PIN_INPUT | MUX_MODE0)		/* uart2_rx.uart2_rx */
+			OMAP3_CORE1_IOPAD(0x2178, PIN_OUTPUT | MUX_MODE0)		/* uart2_tx.uart2_tx */
 		>;
 	};
 
 	uart3_pins: pinmux_uart3_pins {
 		pinctrl-single,pins = <
-                        OMAP3_CORE1_IOPAD(0x219a, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* uart3_cts_rctx.uart3_cts_rctx */
-                        OMAP3_CORE1_IOPAD(0x219c, PIN_OUTPUT | MUX_MODE0)		/* uart3_rts_sd.uart3_rts_sd */
-                        OMAP3_CORE1_IOPAD(0x219e, PIN_INPUT | MUX_MODE0)		/* uart3_rx_irrx.uart3_rx_irrx */
-                        OMAP3_CORE1_IOPAD(0x21a0, PIN_OUTPUT | MUX_MODE0)		/* uart3_tx_irtx.uart3_tx_irtx */
+			OMAP3_CORE1_IOPAD(0x219a, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* uart3_cts_rctx.uart3_cts_rctx */
+			OMAP3_CORE1_IOPAD(0x219c, PIN_OUTPUT | MUX_MODE0)		/* uart3_rts_sd.uart3_rts_sd */
+			OMAP3_CORE1_IOPAD(0x219e, PIN_INPUT | MUX_MODE0)		/* uart3_rx_irrx.uart3_rx_irrx */
+			OMAP3_CORE1_IOPAD(0x21a0, PIN_OUTPUT | MUX_MODE0)		/* uart3_tx_irtx.uart3_tx_irtx */
 		>;
 	};
 
@@ -205,22 +205,22 @@ wlcore: wlcore@2 {
 };
 
 &uart1 {
-       pinctrl-names = "default";
-       pinctrl-0 = <&uart1_pins>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>;
 };
 
 &uart2 {
-       pinctrl-names = "default";
-       pinctrl-0 = <&uart2_pins>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart2_pins>;
 };
 
 &uart3 {
-       pinctrl-names = "default";
-       pinctrl-0 = <&uart3_pins>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart3_pins>;
 };
 
 &uart4 {
-       status = "disabled";
+	status = "disabled";
 };
 
 &usb_otg_hs {
diff --git a/arch/arm/boot/dts/omap4-cpu-thermal.dtsi b/arch/arm/boot/dts/omap4-cpu-thermal.dtsi
index 03d054b2bf9a..4b3afe298062 100644
--- a/arch/arm/boot/dts/omap4-cpu-thermal.dtsi
+++ b/arch/arm/boot/dts/omap4-cpu-thermal.dtsi
@@ -15,21 +15,24 @@ cpu_thermal: cpu_thermal {
 	polling-delay-passive = <250>; /* milliseconds */
 	polling-delay = <1000>; /* milliseconds */
 
-			/* sensor       ID */
-        thermal-sensors = <&bandgap     0>;
+	/*
+	 * See 44xx files for single sensor addressing, omap5 and dra7 need
+	 * also sensor ID for addressing.
+	 */
+	thermal-sensors = <&bandgap     0>;
 
 	cpu_trips: trips {
-                cpu_alert0: cpu_alert {
-                        temperature = <100000>; /* millicelsius */
-                        hysteresis = <2000>; /* millicelsius */
-                        type = "passive";
-                };
-                cpu_crit: cpu_crit {
-                        temperature = <125000>; /* millicelsius */
-                        hysteresis = <2000>; /* millicelsius */
-                        type = "critical";
-                };
-        };
+		cpu_alert0: cpu_alert {
+			temperature = <100000>; /* millicelsius */
+			hysteresis = <2000>; /* millicelsius */
+			type = "passive";
+		};
+		cpu_crit: cpu_crit {
+			temperature = <125000>; /* millicelsius */
+			hysteresis = <2000>; /* millicelsius */
+			type = "critical";
+		};
+	};
 
 	cpu_cooling_maps: cooling-maps {
 		map0 {
diff --git a/arch/arm/boot/dts/omap443x.dtsi b/arch/arm/boot/dts/omap443x.dtsi
index dd8ef58cbaed..cce39dce1428 100644
--- a/arch/arm/boot/dts/omap443x.dtsi
+++ b/arch/arm/boot/dts/omap443x.dtsi
@@ -72,6 +72,7 @@ abb_iva: regulator-abb-iva {
 };
 
 &cpu_thermal {
+	thermal-sensors = <&bandgap>;
 	coefficients = <0 20000>;
 };
 
diff --git a/arch/arm/boot/dts/omap4460.dtsi b/arch/arm/boot/dts/omap4460.dtsi
index 2d3e54901b6e..d62e2bacca18 100644
--- a/arch/arm/boot/dts/omap4460.dtsi
+++ b/arch/arm/boot/dts/omap4460.dtsi
@@ -89,6 +89,7 @@ abb_iva: regulator-abb-iva {
 };
 
 &cpu_thermal {
+	thermal-sensors = <&bandgap>;
 	coefficients = <348 (-9301)>;
 };
 
diff --git a/arch/arm/boot/dts/omap5-cm-t54.dts b/arch/arm/boot/dts/omap5-cm-t54.dts
index e62ea8b6d53f..af288d63a26a 100644
--- a/arch/arm/boot/dts/omap5-cm-t54.dts
+++ b/arch/arm/boot/dts/omap5-cm-t54.dts
@@ -84,36 +84,36 @@ led1 {
 	};
 
 	lcd0: display {
-                compatible = "startek,startek-kd050c", "panel-dpi";
-                label = "lcd";
-
-                pinctrl-names = "default";
-                pinctrl-0 = <&lcd_pins>;
-
-                enable-gpios = <&gpio8 3 GPIO_ACTIVE_HIGH>;
-
-                panel-timing {
-                        clock-frequency = <33000000>;
-                        hactive = <800>;
-                        vactive = <480>;
-                        hfront-porch = <40>;
-                        hback-porch = <40>;
-                        hsync-len = <43>;
-                        vback-porch = <29>;
-                        vfront-porch = <13>;
-                        vsync-len = <3>;
-                        hsync-active = <0>;
-                        vsync-active = <0>;
-                        de-active = <1>;
-                        pixelclk-active = <1>;
-                };
-
-                port {
-                        lcd_in: endpoint {
-                                remote-endpoint = <&dpi_lcd_out>;
-                        };
-                };
-        };
+		compatible = "startek,startek-kd050c", "panel-dpi";
+		label = "lcd";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&lcd_pins>;
+
+		enable-gpios = <&gpio8 3 GPIO_ACTIVE_HIGH>;
+
+		panel-timing {
+			clock-frequency = <33000000>;
+			hactive = <800>;
+			vactive = <480>;
+			hfront-porch = <40>;
+			hback-porch = <40>;
+			hsync-len = <43>;
+			vback-porch = <29>;
+			vfront-porch = <13>;
+			vsync-len = <3>;
+			hsync-active = <0>;
+			vsync-active = <0>;
+			de-active = <1>;
+			pixelclk-active = <1>;
+		};
+
+		port {
+			lcd_in: endpoint {
+				remote-endpoint = <&dpi_lcd_out>;
+			};
+		};
+	};
 
 	hdmi0: connector0 {
 		compatible = "hdmi-connector";
@@ -644,8 +644,8 @@ &usbhsehci {
 };
 
 &usb3 {
-       extcon = <&extcon_usb3>;
-       vbus-supply = <&smps10_out1_reg>;
+	extcon = <&extcon_usb3>;
+	vbus-supply = <&smps10_out1_reg>;
 };
 
 &cpu0 {
diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 9cf5d9551e99..c2a1ccd5fd46 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -79,6 +79,7 @@
 #define ARM_CPU_PART_CORTEX_A78AE	0xD42
 #define ARM_CPU_PART_CORTEX_X1		0xD44
 #define ARM_CPU_PART_CORTEX_A510	0xD46
+#define ARM_CPU_PART_CORTEX_A520	0xD80
 #define ARM_CPU_PART_CORTEX_A710	0xD47
 #define ARM_CPU_PART_CORTEX_X2		0xD48
 #define ARM_CPU_PART_NEOVERSE_N2	0xD49
@@ -130,6 +131,7 @@
 #define MIDR_CORTEX_A78AE	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A78AE)
 #define MIDR_CORTEX_X1	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X1)
 #define MIDR_CORTEX_A510 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A510)
+#define MIDR_CORTEX_A520 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A520)
 #define MIDR_CORTEX_A710 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A710)
 #define MIDR_CORTEX_X2 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X2)
 #define MIDR_NEOVERSE_N2 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_N2)
diff --git a/arch/mips/alchemy/devboards/db1000.c b/arch/mips/alchemy/devboards/db1000.c
index 50de86eb8784..3183df60ad33 100644
--- a/arch/mips/alchemy/devboards/db1000.c
+++ b/arch/mips/alchemy/devboards/db1000.c
@@ -164,6 +164,7 @@ static struct platform_device db1x00_audio_dev = {
 
 /******************************************************************************/
 
+#ifdef CONFIG_MMC_AU1X
 static irqreturn_t db1100_mmc_cd(int irq, void *ptr)
 {
 	mmc_detect_change(ptr, msecs_to_jiffies(500));
@@ -369,6 +370,7 @@ static struct platform_device db1100_mmc1_dev = {
 	.num_resources	= ARRAY_SIZE(au1100_mmc1_res),
 	.resource	= au1100_mmc1_res,
 };
+#endif /* CONFIG_MMC_AU1X */
 
 /******************************************************************************/
 
@@ -432,8 +434,10 @@ static struct platform_device *db1x00_devs[] = {
 
 static struct platform_device *db1100_devs[] = {
 	&au1100_lcd_device,
+#ifdef CONFIG_MMC_AU1X
 	&db1100_mmc0_dev,
 	&db1100_mmc1_dev,
+#endif
 };
 
 int __init db1000_dev_setup(void)
diff --git a/arch/mips/alchemy/devboards/db1200.c b/arch/mips/alchemy/devboards/db1200.c
index b70e2cf8a27b..414f92eacb5e 100644
--- a/arch/mips/alchemy/devboards/db1200.c
+++ b/arch/mips/alchemy/devboards/db1200.c
@@ -326,6 +326,7 @@ static struct platform_device db1200_ide_dev = {
 
 /**********************************************************************/
 
+#ifdef CONFIG_MMC_AU1X
 /* SD carddetects:  they're supposed to be edge-triggered, but ack
  * doesn't seem to work (CPLD Rev 2).  Instead, the screaming one
  * is disabled and its counterpart enabled.  The 200ms timeout is
@@ -584,6 +585,7 @@ static struct platform_device pb1200_mmc1_dev = {
 	.num_resources	= ARRAY_SIZE(au1200_mmc1_res),
 	.resource	= au1200_mmc1_res,
 };
+#endif /* CONFIG_MMC_AU1X */
 
 /**********************************************************************/
 
@@ -751,7 +753,9 @@ static struct platform_device db1200_audiodma_dev = {
 static struct platform_device *db1200_devs[] __initdata = {
 	NULL,		/* PSC0, selected by S6.8 */
 	&db1200_ide_dev,
+#ifdef CONFIG_MMC_AU1X
 	&db1200_mmc0_dev,
+#endif
 	&au1200_lcd_dev,
 	&db1200_eth_dev,
 	&db1200_nand_dev,
@@ -762,7 +766,9 @@ static struct platform_device *db1200_devs[] __initdata = {
 };
 
 static struct platform_device *pb1200_devs[] __initdata = {
+#ifdef CONFIG_MMC_AU1X
 	&pb1200_mmc1_dev,
+#endif
 };
 
 /* Some peripheral base addresses differ on the PB1200 */
diff --git a/arch/mips/alchemy/devboards/db1300.c b/arch/mips/alchemy/devboards/db1300.c
index ca71e5ed51ab..c965d0007481 100644
--- a/arch/mips/alchemy/devboards/db1300.c
+++ b/arch/mips/alchemy/devboards/db1300.c
@@ -450,6 +450,7 @@ static struct platform_device db1300_ide_dev = {
 
 /**********************************************************************/
 
+#ifdef CONFIG_MMC_AU1X
 static irqreturn_t db1300_mmc_cd(int irq, void *ptr)
 {
 	disable_irq_nosync(irq);
@@ -632,6 +633,7 @@ static struct platform_device db1300_sd0_dev = {
 	.resource	= au1300_sd0_res,
 	.num_resources	= ARRAY_SIZE(au1300_sd0_res),
 };
+#endif /* CONFIG_MMC_AU1X */
 
 /**********************************************************************/
 
@@ -776,8 +778,10 @@ static struct platform_device *db1300_dev[] __initdata = {
 	&db1300_5waysw_dev,
 	&db1300_nand_dev,
 	&db1300_ide_dev,
+#ifdef CONFIG_MMC_AU1X
 	&db1300_sd0_dev,
 	&db1300_sd1_dev,
+#endif
 	&db1300_lcd_dev,
 	&db1300_ac97_dev,
 	&db1300_i2s_dev,
diff --git a/arch/parisc/include/asm/ldcw.h b/arch/parisc/include/asm/ldcw.h
index 6d28b5514699..10a061d6899c 100644
--- a/arch/parisc/include/asm/ldcw.h
+++ b/arch/parisc/include/asm/ldcw.h
@@ -2,14 +2,28 @@
 #ifndef __PARISC_LDCW_H
 #define __PARISC_LDCW_H
 
-#ifndef CONFIG_PA20
 /* Because kmalloc only guarantees 8-byte alignment for kmalloc'd data,
    and GCC only guarantees 8-byte alignment for stack locals, we can't
    be assured of 16-byte alignment for atomic lock data even if we
    specify "__attribute ((aligned(16)))" in the type declaration.  So,
    we use a struct containing an array of four ints for the atomic lock
    type and dynamically select the 16-byte aligned int from the array
-   for the semaphore.  */
+   for the semaphore. */
+
+/* From: "Jim Hull" <jim.hull of hp.com>
+   I've attached a summary of the change, but basically, for PA 2.0, as
+   long as the ",CO" (coherent operation) completer is implemented, then the
+   16-byte alignment requirement for ldcw and ldcd is relaxed, and instead
+   they only require "natural" alignment (4-byte for ldcw, 8-byte for
+   ldcd).
+
+   Although the cache control hint is accepted by all PA 2.0 processors,
+   it is only implemented on PA8800/PA8900 CPUs. Prior PA8X00 CPUs still
+   require 16-byte alignment. If the address is unaligned, the operation
+   of the instruction is undefined. The ldcw instruction does not generate
+   unaligned data reference traps so misaligned accesses are not detected.
+   This hid the problem for years. So, restore the 16-byte alignment dropped
+   by Kyle McMartin in "Remove __ldcw_align for PA-RISC 2.0 processors". */
 
 #define __PA_LDCW_ALIGNMENT	16
 #define __PA_LDCW_ALIGN_ORDER	4
@@ -19,22 +33,12 @@
 		& ~(__PA_LDCW_ALIGNMENT - 1);			\
 	(volatile unsigned int *) __ret;			\
 })
-#define __LDCW	"ldcw"
 
-#else /*CONFIG_PA20*/
-/* From: "Jim Hull" <jim.hull of hp.com>
-   I've attached a summary of the change, but basically, for PA 2.0, as
-   long as the ",CO" (coherent operation) completer is specified, then the
-   16-byte alignment requirement for ldcw and ldcd is relaxed, and instead
-   they only require "natural" alignment (4-byte for ldcw, 8-byte for
-   ldcd). */
-
-#define __PA_LDCW_ALIGNMENT	4
-#define __PA_LDCW_ALIGN_ORDER	2
-#define __ldcw_align(a) (&(a)->slock)
+#ifdef CONFIG_PA20
 #define __LDCW	"ldcw,co"
-
-#endif /*!CONFIG_PA20*/
+#else
+#define __LDCW	"ldcw"
+#endif
 
 /* LDCW, the only atomic read-write operation PA-RISC has. *sigh*.
    We don't explicitly expose that "*a" may be written as reload
diff --git a/arch/parisc/include/asm/ropes.h b/arch/parisc/include/asm/ropes.h
index 8e51c775c80a..62399c7ea94a 100644
--- a/arch/parisc/include/asm/ropes.h
+++ b/arch/parisc/include/asm/ropes.h
@@ -86,6 +86,9 @@ struct sba_device {
 	struct ioc		ioc[MAX_IOC];
 };
 
+/* list of SBA's in system, see drivers/parisc/sba_iommu.c */
+extern struct sba_device *sba_list;
+
 #define ASTRO_RUNWAY_PORT	0x582
 #define IKE_MERCED_PORT		0x803
 #define REO_MERCED_PORT		0x804
diff --git a/arch/parisc/include/asm/spinlock_types.h b/arch/parisc/include/asm/spinlock_types.h
index ca39ee350c3f..35c5086b74d7 100644
--- a/arch/parisc/include/asm/spinlock_types.h
+++ b/arch/parisc/include/asm/spinlock_types.h
@@ -3,13 +3,8 @@
 #define __ASM_SPINLOCK_TYPES_H
 
 typedef struct {
-#ifdef CONFIG_PA20
-	volatile unsigned int slock;
-# define __ARCH_SPIN_LOCK_UNLOCKED { 1 }
-#else
 	volatile unsigned int lock[4];
 # define __ARCH_SPIN_LOCK_UNLOCKED	{ { 1, 1, 1, 1 } }
-#endif
 } arch_spinlock_t;
 
 
diff --git a/arch/parisc/kernel/drivers.c b/arch/parisc/kernel/drivers.c
index d95157488832..d11a3123f3dc 100644
--- a/arch/parisc/kernel/drivers.c
+++ b/arch/parisc/kernel/drivers.c
@@ -925,9 +925,9 @@ static __init void qemu_header(void)
 	pr_info("#define PARISC_MODEL \"%s\"\n\n",
 			boot_cpu_data.pdc.sys_model_name);
 
+	#define p ((unsigned long *)&boot_cpu_data.pdc.model)
 	pr_info("#define PARISC_PDC_MODEL 0x%lx, 0x%lx, 0x%lx, "
 		"0x%lx, 0x%lx, 0x%lx, 0x%lx, 0x%lx, 0x%lx\n\n",
-	#define p ((unsigned long *)&boot_cpu_data.pdc.model)
 		p[0], p[1], p[2], p[3], p[4], p[5], p[6], p[7], p[8]);
 	#undef p
 
diff --git a/arch/parisc/kernel/irq.c b/arch/parisc/kernel/irq.c
index 60f5829d476f..2762e8540672 100644
--- a/arch/parisc/kernel/irq.c
+++ b/arch/parisc/kernel/irq.c
@@ -388,7 +388,7 @@ union irq_stack_union {
 	volatile unsigned int lock[1];
 };
 
-DEFINE_PER_CPU(union irq_stack_union, irq_stack_union) = {
+static DEFINE_PER_CPU(union irq_stack_union, irq_stack_union) = {
 		.slock = { 1,1,1,1 },
 	};
 #endif
diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
index f4e8f21046f5..6e5bed50c357 100644
--- a/arch/powerpc/kernel/hw_breakpoint.c
+++ b/arch/powerpc/kernel/hw_breakpoint.c
@@ -479,11 +479,13 @@ void thread_change_pc(struct task_struct *tsk, struct pt_regs *regs)
 	struct arch_hw_breakpoint *info;
 	int i;
 
+	preempt_disable();
+
 	for (i = 0; i < nr_wp_slots(); i++) {
 		if (unlikely(tsk->thread.last_hit_ubp[i]))
 			goto reset;
 	}
-	return;
+	goto out;
 
 reset:
 	regs->msr &= ~MSR_SE;
@@ -492,6 +494,9 @@ void thread_change_pc(struct task_struct *tsk, struct pt_regs *regs)
 		__set_breakpoint(i, info);
 		tsk->thread.last_hit_ubp[i] = NULL;
 	}
+
+out:
+	preempt_enable();
 }
 
 static bool is_larx_stcx_instr(int type)
diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index 1cd2351d241e..61a08747b164 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -1410,7 +1410,7 @@ static int h_24x7_event_init(struct perf_event *event)
 	}
 
 	domain = event_get_domain(event);
-	if (domain >= HV_PERF_DOMAIN_MAX) {
+	if (domain  == 0 || domain >= HV_PERF_DOMAIN_MAX) {
 		pr_devel("invalid domain %d\n", domain);
 		return -EINVAL;
 	}
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 4d11a50089b2..ec3ddb9a456b 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2344,7 +2344,7 @@ static void __init srso_select_mitigation(void)
 
 	switch (srso_cmd) {
 	case SRSO_CMD_OFF:
-		return;
+		goto pred_cmd;
 
 	case SRSO_CMD_MICROCODE:
 		if (has_microcode) {
@@ -2622,7 +2622,7 @@ static ssize_t srso_show_state(char *buf)
 
 	return sysfs_emit(buf, "%s%s\n",
 			  srso_strings[srso_mitigation],
-			  (cpu_has_ibpb_brtype_microcode() ? "" : ", no microcode"));
+			  boot_cpu_has(X86_FEATURE_IBPB_BRTYPE) ? "" : ", no microcode");
 }
 
 static ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr,
diff --git a/arch/xtensa/boot/Makefile b/arch/xtensa/boot/Makefile
index f6bb352f94b4..c8fd705d08b2 100644
--- a/arch/xtensa/boot/Makefile
+++ b/arch/xtensa/boot/Makefile
@@ -9,8 +9,7 @@
 
 
 # KBUILD_CFLAGS used when building rest of boot (takes effect recursively)
-KBUILD_CFLAGS	+= -fno-builtin -Iarch/$(ARCH)/boot/include
-HOSTFLAGS	+= -Iarch/$(ARCH)/boot/include
+KBUILD_CFLAGS	+= -fno-builtin
 
 BIG_ENDIAN	:= $(shell echo __XTENSA_EB__ | $(CC) -E - | grep -v "\#")
 
diff --git a/arch/xtensa/boot/lib/zmem.c b/arch/xtensa/boot/lib/zmem.c
index e3ecd743c515..b89189355122 100644
--- a/arch/xtensa/boot/lib/zmem.c
+++ b/arch/xtensa/boot/lib/zmem.c
@@ -4,13 +4,14 @@
 /* bits taken from ppc */
 
 extern void *avail_ram, *end_avail;
+void gunzip(void *dst, int dstlen, unsigned char *src, int *lenp);
 
-void exit (void)
+static void exit(void)
 {
   for (;;);
 }
 
-void *zalloc(unsigned size)
+static void *zalloc(unsigned int size)
 {
         void *p = avail_ram;
 
diff --git a/arch/xtensa/include/asm/core.h b/arch/xtensa/include/asm/core.h
index a4e40166ff4b..0fa3649649e9 100644
--- a/arch/xtensa/include/asm/core.h
+++ b/arch/xtensa/include/asm/core.h
@@ -6,6 +6,10 @@
 
 #include <variant/core.h>
 
+#ifndef XCHAL_HAVE_DIV32
+#define XCHAL_HAVE_DIV32 0
+#endif
+
 #ifndef XCHAL_HAVE_EXCLUSIVE
 #define XCHAL_HAVE_EXCLUSIVE 0
 #endif
diff --git a/arch/xtensa/platforms/iss/network.c b/arch/xtensa/platforms/iss/network.c
index 1270de83435e..e8491ac0d5b9 100644
--- a/arch/xtensa/platforms/iss/network.c
+++ b/arch/xtensa/platforms/iss/network.c
@@ -204,7 +204,7 @@ static int tuntap_write(struct iss_net_private *lp, struct sk_buff **skb)
 	return simc_write(lp->tp.info.tuntap.fd, (*skb)->data, (*skb)->len);
 }
 
-unsigned short tuntap_protocol(struct sk_buff *skb)
+static unsigned short tuntap_protocol(struct sk_buff *skb)
 {
 	return eth_type_trans(skb, skb->dev);
 }
@@ -477,7 +477,7 @@ static int iss_net_change_mtu(struct net_device *dev, int new_mtu)
 	return -EINVAL;
 }
 
-void iss_net_user_timer_expire(struct timer_list *unused)
+static void iss_net_user_timer_expire(struct timer_list *unused)
 {
 }
 
diff --git a/block/blk-core.c b/block/blk-core.c
index d0d0dd8151f7..e5eeec801f56 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -414,8 +414,6 @@ void blk_cleanup_queue(struct request_queue *q)
 		blk_mq_sched_free_requests(q);
 	mutex_unlock(&q->sysfs_lock);
 
-	percpu_ref_exit(&q->q_usage_counter);
-
 	/* @q is and will stay empty, shutdown and put */
 	blk_put_queue(q);
 }
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 8c5816364dd1..9174137a913c 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -726,6 +726,8 @@ static void blk_free_queue_rcu(struct rcu_head *rcu_head)
 {
 	struct request_queue *q = container_of(rcu_head, struct request_queue,
 					       rcu_head);
+
+	percpu_ref_exit(&q->q_usage_counter);
 	kmem_cache_free(blk_requestq_cachep, q);
 }
 
diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index ecd2ddc2215f..66e53df75865 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -1326,4 +1326,33 @@ int acpi_dev_pm_attach(struct device *dev, bool power_on)
 	return 1;
 }
 EXPORT_SYMBOL_GPL(acpi_dev_pm_attach);
+
+/**
+ * acpi_storage_d3 - Check if D3 should be used in the suspend path
+ * @dev: Device to check
+ *
+ * Return %true if the platform firmware wants @dev to be programmed
+ * into D3hot or D3cold (if supported) in the suspend path, or %false
+ * when there is no specific preference. On some platforms, if this
+ * hint is ignored, @dev may remain unresponsive after suspending the
+ * platform as a whole.
+ *
+ * Although the property has storage in the name it actually is
+ * applied to the PCIe slot and plugging in a non-storage device the
+ * same platform restrictions will likely apply.
+ */
+bool acpi_storage_d3(struct device *dev)
+{
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+	u8 val;
+
+	if (!adev)
+		return false;
+	if (fwnode_property_read_u8(acpi_fwnode_handle(adev), "StorageD3Enable",
+			&val))
+		return false;
+	return val == 1;
+}
+EXPORT_SYMBOL_GPL(acpi_storage_d3);
+
 #endif /* CONFIG_PM */
diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index bf949f7da483..4297a8d69dbf 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -50,7 +50,8 @@ enum board_ids {
 	/* board IDs by feature in alphabetical order */
 	board_ahci,
 	board_ahci_ign_iferr,
-	board_ahci_mobile,
+	board_ahci_low_power,
+	board_ahci_no_debounce_delay,
 	board_ahci_nomsi,
 	board_ahci_noncq,
 	board_ahci_nosntf,
@@ -135,13 +136,20 @@ static const struct ata_port_info ahci_port_info[] = {
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &ahci_ops,
 	},
-	[board_ahci_mobile] = {
+	[board_ahci_low_power] = {
 		AHCI_HFLAGS	(AHCI_HFLAG_IS_MOBILE),
 		.flags		= AHCI_FLAG_COMMON,
 		.pio_mask	= ATA_PIO4,
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &ahci_ops,
 	},
+	[board_ahci_no_debounce_delay] = {
+		.flags		= AHCI_FLAG_COMMON,
+		.link_flags	= ATA_LFLAG_NO_DEBOUNCE_DELAY,
+		.pio_mask	= ATA_PIO4,
+		.udma_mask	= ATA_UDMA6,
+		.port_ops	= &ahci_ops,
+	},
 	[board_ahci_nomsi] = {
 		AHCI_HFLAGS	(AHCI_HFLAG_NO_MSI),
 		.flags		= AHCI_FLAG_COMMON,
@@ -268,13 +276,13 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x2924), board_ahci }, /* ICH9 */
 	{ PCI_VDEVICE(INTEL, 0x2925), board_ahci }, /* ICH9 */
 	{ PCI_VDEVICE(INTEL, 0x2927), board_ahci }, /* ICH9 */
-	{ PCI_VDEVICE(INTEL, 0x2929), board_ahci_mobile }, /* ICH9M */
-	{ PCI_VDEVICE(INTEL, 0x292a), board_ahci_mobile }, /* ICH9M */
-	{ PCI_VDEVICE(INTEL, 0x292b), board_ahci_mobile }, /* ICH9M */
-	{ PCI_VDEVICE(INTEL, 0x292c), board_ahci_mobile }, /* ICH9M */
-	{ PCI_VDEVICE(INTEL, 0x292f), board_ahci_mobile }, /* ICH9M */
+	{ PCI_VDEVICE(INTEL, 0x2929), board_ahci_low_power }, /* ICH9M */
+	{ PCI_VDEVICE(INTEL, 0x292a), board_ahci_low_power }, /* ICH9M */
+	{ PCI_VDEVICE(INTEL, 0x292b), board_ahci_low_power }, /* ICH9M */
+	{ PCI_VDEVICE(INTEL, 0x292c), board_ahci_low_power }, /* ICH9M */
+	{ PCI_VDEVICE(INTEL, 0x292f), board_ahci_low_power }, /* ICH9M */
 	{ PCI_VDEVICE(INTEL, 0x294d), board_ahci }, /* ICH9 */
-	{ PCI_VDEVICE(INTEL, 0x294e), board_ahci_mobile }, /* ICH9M */
+	{ PCI_VDEVICE(INTEL, 0x294e), board_ahci_low_power }, /* ICH9M */
 	{ PCI_VDEVICE(INTEL, 0x502a), board_ahci }, /* Tolapai */
 	{ PCI_VDEVICE(INTEL, 0x502b), board_ahci }, /* Tolapai */
 	{ PCI_VDEVICE(INTEL, 0x3a05), board_ahci }, /* ICH10 */
@@ -284,9 +292,9 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x3b23), board_ahci }, /* PCH AHCI */
 	{ PCI_VDEVICE(INTEL, 0x3b24), board_ahci }, /* PCH RAID */
 	{ PCI_VDEVICE(INTEL, 0x3b25), board_ahci }, /* PCH RAID */
-	{ PCI_VDEVICE(INTEL, 0x3b29), board_ahci_mobile }, /* PCH M AHCI */
+	{ PCI_VDEVICE(INTEL, 0x3b29), board_ahci_low_power }, /* PCH M AHCI */
 	{ PCI_VDEVICE(INTEL, 0x3b2b), board_ahci }, /* PCH RAID */
-	{ PCI_VDEVICE(INTEL, 0x3b2c), board_ahci_mobile }, /* PCH M RAID */
+	{ PCI_VDEVICE(INTEL, 0x3b2c), board_ahci_low_power }, /* PCH M RAID */
 	{ PCI_VDEVICE(INTEL, 0x3b2f), board_ahci }, /* PCH AHCI */
 	{ PCI_VDEVICE(INTEL, 0x19b0), board_ahci_pcs7 }, /* DNV AHCI */
 	{ PCI_VDEVICE(INTEL, 0x19b1), board_ahci_pcs7 }, /* DNV AHCI */
@@ -309,9 +317,9 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x19cE), board_ahci_pcs7 }, /* DNV AHCI */
 	{ PCI_VDEVICE(INTEL, 0x19cF), board_ahci_pcs7 }, /* DNV AHCI */
 	{ PCI_VDEVICE(INTEL, 0x1c02), board_ahci }, /* CPT AHCI */
-	{ PCI_VDEVICE(INTEL, 0x1c03), board_ahci_mobile }, /* CPT M AHCI */
+	{ PCI_VDEVICE(INTEL, 0x1c03), board_ahci_low_power }, /* CPT M AHCI */
 	{ PCI_VDEVICE(INTEL, 0x1c04), board_ahci }, /* CPT RAID */
-	{ PCI_VDEVICE(INTEL, 0x1c05), board_ahci_mobile }, /* CPT M RAID */
+	{ PCI_VDEVICE(INTEL, 0x1c05), board_ahci_low_power }, /* CPT M RAID */
 	{ PCI_VDEVICE(INTEL, 0x1c06), board_ahci }, /* CPT RAID */
 	{ PCI_VDEVICE(INTEL, 0x1c07), board_ahci }, /* CPT RAID */
 	{ PCI_VDEVICE(INTEL, 0x1d02), board_ahci }, /* PBG AHCI */
@@ -320,29 +328,29 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x2826), board_ahci }, /* PBG RAID */
 	{ PCI_VDEVICE(INTEL, 0x2323), board_ahci }, /* DH89xxCC AHCI */
 	{ PCI_VDEVICE(INTEL, 0x1e02), board_ahci }, /* Panther Point AHCI */
-	{ PCI_VDEVICE(INTEL, 0x1e03), board_ahci_mobile }, /* Panther M AHCI */
+	{ PCI_VDEVICE(INTEL, 0x1e03), board_ahci_low_power }, /* Panther M AHCI */
 	{ PCI_VDEVICE(INTEL, 0x1e04), board_ahci }, /* Panther Point RAID */
 	{ PCI_VDEVICE(INTEL, 0x1e05), board_ahci }, /* Panther Point RAID */
 	{ PCI_VDEVICE(INTEL, 0x1e06), board_ahci }, /* Panther Point RAID */
-	{ PCI_VDEVICE(INTEL, 0x1e07), board_ahci_mobile }, /* Panther M RAID */
+	{ PCI_VDEVICE(INTEL, 0x1e07), board_ahci_low_power }, /* Panther M RAID */
 	{ PCI_VDEVICE(INTEL, 0x1e0e), board_ahci }, /* Panther Point RAID */
 	{ PCI_VDEVICE(INTEL, 0x8c02), board_ahci }, /* Lynx Point AHCI */
-	{ PCI_VDEVICE(INTEL, 0x8c03), board_ahci_mobile }, /* Lynx M AHCI */
+	{ PCI_VDEVICE(INTEL, 0x8c03), board_ahci_low_power }, /* Lynx M AHCI */
 	{ PCI_VDEVICE(INTEL, 0x8c04), board_ahci }, /* Lynx Point RAID */
-	{ PCI_VDEVICE(INTEL, 0x8c05), board_ahci_mobile }, /* Lynx M RAID */
+	{ PCI_VDEVICE(INTEL, 0x8c05), board_ahci_low_power }, /* Lynx M RAID */
 	{ PCI_VDEVICE(INTEL, 0x8c06), board_ahci }, /* Lynx Point RAID */
-	{ PCI_VDEVICE(INTEL, 0x8c07), board_ahci_mobile }, /* Lynx M RAID */
+	{ PCI_VDEVICE(INTEL, 0x8c07), board_ahci_low_power }, /* Lynx M RAID */
 	{ PCI_VDEVICE(INTEL, 0x8c0e), board_ahci }, /* Lynx Point RAID */
-	{ PCI_VDEVICE(INTEL, 0x8c0f), board_ahci_mobile }, /* Lynx M RAID */
-	{ PCI_VDEVICE(INTEL, 0x9c02), board_ahci_mobile }, /* Lynx LP AHCI */
-	{ PCI_VDEVICE(INTEL, 0x9c03), board_ahci_mobile }, /* Lynx LP AHCI */
-	{ PCI_VDEVICE(INTEL, 0x9c04), board_ahci_mobile }, /* Lynx LP RAID */
-	{ PCI_VDEVICE(INTEL, 0x9c05), board_ahci_mobile }, /* Lynx LP RAID */
-	{ PCI_VDEVICE(INTEL, 0x9c06), board_ahci_mobile }, /* Lynx LP RAID */
-	{ PCI_VDEVICE(INTEL, 0x9c07), board_ahci_mobile }, /* Lynx LP RAID */
-	{ PCI_VDEVICE(INTEL, 0x9c0e), board_ahci_mobile }, /* Lynx LP RAID */
-	{ PCI_VDEVICE(INTEL, 0x9c0f), board_ahci_mobile }, /* Lynx LP RAID */
-	{ PCI_VDEVICE(INTEL, 0x9dd3), board_ahci_mobile }, /* Cannon Lake PCH-LP AHCI */
+	{ PCI_VDEVICE(INTEL, 0x8c0f), board_ahci_low_power }, /* Lynx M RAID */
+	{ PCI_VDEVICE(INTEL, 0x9c02), board_ahci_low_power }, /* Lynx LP AHCI */
+	{ PCI_VDEVICE(INTEL, 0x9c03), board_ahci_low_power }, /* Lynx LP AHCI */
+	{ PCI_VDEVICE(INTEL, 0x9c04), board_ahci_low_power }, /* Lynx LP RAID */
+	{ PCI_VDEVICE(INTEL, 0x9c05), board_ahci_low_power }, /* Lynx LP RAID */
+	{ PCI_VDEVICE(INTEL, 0x9c06), board_ahci_low_power }, /* Lynx LP RAID */
+	{ PCI_VDEVICE(INTEL, 0x9c07), board_ahci_low_power }, /* Lynx LP RAID */
+	{ PCI_VDEVICE(INTEL, 0x9c0e), board_ahci_low_power }, /* Lynx LP RAID */
+	{ PCI_VDEVICE(INTEL, 0x9c0f), board_ahci_low_power }, /* Lynx LP RAID */
+	{ PCI_VDEVICE(INTEL, 0x9dd3), board_ahci_low_power }, /* Cannon Lake PCH-LP AHCI */
 	{ PCI_VDEVICE(INTEL, 0x1f22), board_ahci }, /* Avoton AHCI */
 	{ PCI_VDEVICE(INTEL, 0x1f23), board_ahci }, /* Avoton AHCI */
 	{ PCI_VDEVICE(INTEL, 0x1f24), board_ahci }, /* Avoton RAID */
@@ -374,26 +382,26 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x8d66), board_ahci }, /* Wellsburg RAID */
 	{ PCI_VDEVICE(INTEL, 0x8d6e), board_ahci }, /* Wellsburg RAID */
 	{ PCI_VDEVICE(INTEL, 0x23a3), board_ahci }, /* Coleto Creek AHCI */
-	{ PCI_VDEVICE(INTEL, 0x9c83), board_ahci_mobile }, /* Wildcat LP AHCI */
-	{ PCI_VDEVICE(INTEL, 0x9c85), board_ahci_mobile }, /* Wildcat LP RAID */
-	{ PCI_VDEVICE(INTEL, 0x9c87), board_ahci_mobile }, /* Wildcat LP RAID */
-	{ PCI_VDEVICE(INTEL, 0x9c8f), board_ahci_mobile }, /* Wildcat LP RAID */
+	{ PCI_VDEVICE(INTEL, 0x9c83), board_ahci_low_power }, /* Wildcat LP AHCI */
+	{ PCI_VDEVICE(INTEL, 0x9c85), board_ahci_low_power }, /* Wildcat LP RAID */
+	{ PCI_VDEVICE(INTEL, 0x9c87), board_ahci_low_power }, /* Wildcat LP RAID */
+	{ PCI_VDEVICE(INTEL, 0x9c8f), board_ahci_low_power }, /* Wildcat LP RAID */
 	{ PCI_VDEVICE(INTEL, 0x8c82), board_ahci }, /* 9 Series AHCI */
-	{ PCI_VDEVICE(INTEL, 0x8c83), board_ahci_mobile }, /* 9 Series M AHCI */
+	{ PCI_VDEVICE(INTEL, 0x8c83), board_ahci_low_power }, /* 9 Series M AHCI */
 	{ PCI_VDEVICE(INTEL, 0x8c84), board_ahci }, /* 9 Series RAID */
-	{ PCI_VDEVICE(INTEL, 0x8c85), board_ahci_mobile }, /* 9 Series M RAID */
+	{ PCI_VDEVICE(INTEL, 0x8c85), board_ahci_low_power }, /* 9 Series M RAID */
 	{ PCI_VDEVICE(INTEL, 0x8c86), board_ahci }, /* 9 Series RAID */
-	{ PCI_VDEVICE(INTEL, 0x8c87), board_ahci_mobile }, /* 9 Series M RAID */
+	{ PCI_VDEVICE(INTEL, 0x8c87), board_ahci_low_power }, /* 9 Series M RAID */
 	{ PCI_VDEVICE(INTEL, 0x8c8e), board_ahci }, /* 9 Series RAID */
-	{ PCI_VDEVICE(INTEL, 0x8c8f), board_ahci_mobile }, /* 9 Series M RAID */
-	{ PCI_VDEVICE(INTEL, 0x9d03), board_ahci_mobile }, /* Sunrise LP AHCI */
-	{ PCI_VDEVICE(INTEL, 0x9d05), board_ahci_mobile }, /* Sunrise LP RAID */
-	{ PCI_VDEVICE(INTEL, 0x9d07), board_ahci_mobile }, /* Sunrise LP RAID */
+	{ PCI_VDEVICE(INTEL, 0x8c8f), board_ahci_low_power }, /* 9 Series M RAID */
+	{ PCI_VDEVICE(INTEL, 0x9d03), board_ahci_low_power }, /* Sunrise LP AHCI */
+	{ PCI_VDEVICE(INTEL, 0x9d05), board_ahci_low_power }, /* Sunrise LP RAID */
+	{ PCI_VDEVICE(INTEL, 0x9d07), board_ahci_low_power }, /* Sunrise LP RAID */
 	{ PCI_VDEVICE(INTEL, 0xa102), board_ahci }, /* Sunrise Point-H AHCI */
-	{ PCI_VDEVICE(INTEL, 0xa103), board_ahci_mobile }, /* Sunrise M AHCI */
+	{ PCI_VDEVICE(INTEL, 0xa103), board_ahci_low_power }, /* Sunrise M AHCI */
 	{ PCI_VDEVICE(INTEL, 0xa105), board_ahci }, /* Sunrise Point-H RAID */
 	{ PCI_VDEVICE(INTEL, 0xa106), board_ahci }, /* Sunrise Point-H RAID */
-	{ PCI_VDEVICE(INTEL, 0xa107), board_ahci_mobile }, /* Sunrise M RAID */
+	{ PCI_VDEVICE(INTEL, 0xa107), board_ahci_low_power }, /* Sunrise M RAID */
 	{ PCI_VDEVICE(INTEL, 0xa10f), board_ahci }, /* Sunrise Point-H RAID */
 	{ PCI_VDEVICE(INTEL, 0x2822), board_ahci }, /* Lewisburg RAID*/
 	{ PCI_VDEVICE(INTEL, 0x2823), board_ahci }, /* Lewisburg AHCI*/
@@ -410,13 +418,15 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0xa356), board_ahci }, /* Cannon Lake PCH-H RAID */
 	{ PCI_VDEVICE(INTEL, 0x06d7), board_ahci }, /* Comet Lake-H RAID */
 	{ PCI_VDEVICE(INTEL, 0xa386), board_ahci }, /* Comet Lake PCH-V RAID */
-	{ PCI_VDEVICE(INTEL, 0x0f22), board_ahci_mobile }, /* Bay Trail AHCI */
-	{ PCI_VDEVICE(INTEL, 0x0f23), board_ahci_mobile }, /* Bay Trail AHCI */
-	{ PCI_VDEVICE(INTEL, 0x22a3), board_ahci_mobile }, /* Cherry Tr. AHCI */
-	{ PCI_VDEVICE(INTEL, 0x5ae3), board_ahci_mobile }, /* ApolloLake AHCI */
-	{ PCI_VDEVICE(INTEL, 0x34d3), board_ahci_mobile }, /* Ice Lake LP AHCI */
-	{ PCI_VDEVICE(INTEL, 0x02d3), board_ahci_mobile }, /* Comet Lake PCH-U AHCI */
-	{ PCI_VDEVICE(INTEL, 0x02d7), board_ahci_mobile }, /* Comet Lake PCH RAID */
+	{ PCI_VDEVICE(INTEL, 0x0f22), board_ahci_low_power }, /* Bay Trail AHCI */
+	{ PCI_VDEVICE(INTEL, 0x0f23), board_ahci_low_power }, /* Bay Trail AHCI */
+	{ PCI_VDEVICE(INTEL, 0x22a3), board_ahci_low_power }, /* Cherry Tr. AHCI */
+	{ PCI_VDEVICE(INTEL, 0x5ae3), board_ahci_low_power }, /* ApolloLake AHCI */
+	{ PCI_VDEVICE(INTEL, 0x34d3), board_ahci_low_power }, /* Ice Lake LP AHCI */
+	{ PCI_VDEVICE(INTEL, 0x02d3), board_ahci_low_power }, /* Comet Lake PCH-U AHCI */
+	{ PCI_VDEVICE(INTEL, 0x02d7), board_ahci_low_power }, /* Comet Lake PCH RAID */
+	/* Elkhart Lake IDs 0x4b60 & 0x4b62 https://sata-io.org/product/8803 not tested yet */
+	{ PCI_VDEVICE(INTEL, 0x4b63), board_ahci_low_power }, /* Elkhart Lake AHCI */
 
 	/* JMicron 360/1/3/5/6, match class to avoid IDE function */
 	{ PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
@@ -442,8 +452,9 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 		board_ahci_al },
 	/* AMD */
 	{ PCI_VDEVICE(AMD, 0x7800), board_ahci }, /* AMD Hudson-2 */
+	{ PCI_VDEVICE(AMD, 0x7801), board_ahci_no_debounce_delay }, /* AMD Hudson-2 (AHCI mode) */
 	{ PCI_VDEVICE(AMD, 0x7900), board_ahci }, /* AMD CZ */
-	{ PCI_VDEVICE(AMD, 0x7901), board_ahci_mobile }, /* AMD Green Sardine */
+	{ PCI_VDEVICE(AMD, 0x7901), board_ahci_low_power }, /* AMD Green Sardine */
 	/* AMD is using RAID class only for ahci controllers */
 	{ PCI_VENDOR_ID_AMD, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
 	  PCI_CLASS_STORAGE_RAID << 8, 0xffffff, board_ahci },
@@ -703,7 +714,7 @@ static void ahci_pci_init_controller(struct ata_host *host)
 
 		/* clear port IRQ */
 		tmp = readl(port_mmio + PORT_IRQ_STAT);
-		VPRINTK("PORT_IRQ_STAT 0x%x\n", tmp);
+		dev_dbg(&pdev->dev, "PORT_IRQ_STAT 0x%x\n", tmp);
 		if (tmp)
 			writel(tmp, port_mmio + PORT_IRQ_STAT);
 	}
@@ -1495,7 +1506,6 @@ static irqreturn_t ahci_thunderx_irq_handler(int irq, void *dev_instance)
 	u32 irq_stat, irq_masked;
 	unsigned int handled = 1;
 
-	VPRINTK("ENTER\n");
 	hpriv = host->private_data;
 	mmio = hpriv->mmio;
 	irq_stat = readl(mmio + HOST_IRQ_STAT);
@@ -1512,7 +1522,6 @@ static irqreturn_t ahci_thunderx_irq_handler(int irq, void *dev_instance)
 		irq_stat = readl(mmio + HOST_IRQ_STAT);
 		spin_unlock(&host->lock);
 	} while (irq_stat);
-	VPRINTK("EXIT\n");
 
 	return IRQ_RETVAL(handled);
 }
diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
index 5b32df5d33ad..2e4252545fd2 100644
--- a/drivers/ata/ahci_brcm.c
+++ b/drivers/ata/ahci_brcm.c
@@ -332,7 +332,7 @@ static struct ata_port_operations ahci_brcm_platform_ops = {
 
 static const struct ata_port_info ahci_brcm_port_info = {
 	.flags		= AHCI_FLAG_COMMON | ATA_FLAG_NO_DIPM,
-	.link_flags	= ATA_LFLAG_NO_DB_DELAY,
+	.link_flags	= ATA_LFLAG_NO_DEBOUNCE_DELAY,
 	.pio_mask	= ATA_PIO4,
 	.udma_mask	= ATA_UDMA6,
 	.port_ops	= &ahci_brcm_platform_ops,
diff --git a/drivers/ata/ahci_xgene.c b/drivers/ata/ahci_xgene.c
index 16246c843365..e0f0577ac191 100644
--- a/drivers/ata/ahci_xgene.c
+++ b/drivers/ata/ahci_xgene.c
@@ -588,8 +588,6 @@ static irqreturn_t xgene_ahci_irq_intr(int irq, void *dev_instance)
 	void __iomem *mmio;
 	u32 irq_stat, irq_masked;
 
-	VPRINTK("ENTER\n");
-
 	hpriv = host->private_data;
 	mmio = hpriv->mmio;
 
@@ -612,8 +610,6 @@ static irqreturn_t xgene_ahci_irq_intr(int irq, void *dev_instance)
 
 	spin_unlock(&host->lock);
 
-	VPRINTK("EXIT\n");
-
 	return IRQ_RETVAL(rc);
 }
 
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index fec2e9754aed..e188850f65ff 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1199,6 +1199,26 @@ static ssize_t ahci_activity_show(struct ata_device *dev, char *buf)
 	return sprintf(buf, "%d\n", emp->blink_policy);
 }
 
+static void ahci_port_clear_pending_irq(struct ata_port *ap)
+{
+	struct ahci_host_priv *hpriv = ap->host->private_data;
+	void __iomem *port_mmio = ahci_port_base(ap);
+	u32 tmp;
+
+	/* clear SError */
+	tmp = readl(port_mmio + PORT_SCR_ERR);
+	dev_dbg(ap->host->dev, "PORT_SCR_ERR 0x%x\n", tmp);
+	writel(tmp, port_mmio + PORT_SCR_ERR);
+
+	/* clear port IRQ */
+	tmp = readl(port_mmio + PORT_IRQ_STAT);
+	dev_dbg(ap->host->dev, "PORT_IRQ_STAT 0x%x\n", tmp);
+	if (tmp)
+		writel(tmp, port_mmio + PORT_IRQ_STAT);
+
+	writel(1 << ap->port_no, hpriv->mmio + HOST_IRQ_STAT);
+}
+
 static void ahci_port_init(struct device *dev, struct ata_port *ap,
 			   int port_no, void __iomem *mmio,
 			   void __iomem *port_mmio)
@@ -1213,18 +1233,7 @@ static void ahci_port_init(struct device *dev, struct ata_port *ap,
 	if (rc)
 		dev_warn(dev, "%s (%d)\n", emsg, rc);
 
-	/* clear SError */
-	tmp = readl(port_mmio + PORT_SCR_ERR);
-	VPRINTK("PORT_SCR_ERR 0x%x\n", tmp);
-	writel(tmp, port_mmio + PORT_SCR_ERR);
-
-	/* clear port IRQ */
-	tmp = readl(port_mmio + PORT_IRQ_STAT);
-	VPRINTK("PORT_IRQ_STAT 0x%x\n", tmp);
-	if (tmp)
-		writel(tmp, port_mmio + PORT_IRQ_STAT);
-
-	writel(1 << port_no, mmio + HOST_IRQ_STAT);
+	ahci_port_clear_pending_irq(ap);
 
 	/* mark esata ports */
 	tmp = readl(port_mmio + PORT_CMD);
@@ -1251,10 +1260,10 @@ void ahci_init_controller(struct ata_host *host)
 	}
 
 	tmp = readl(mmio + HOST_CTL);
-	VPRINTK("HOST_CTL 0x%x\n", tmp);
+	dev_dbg(host->dev, "HOST_CTL 0x%x\n", tmp);
 	writel(tmp | HOST_IRQ_EN, mmio + HOST_CTL);
 	tmp = readl(mmio + HOST_CTL);
-	VPRINTK("HOST_CTL 0x%x\n", tmp);
+	dev_dbg(host->dev, "HOST_CTL 0x%x\n", tmp);
 }
 EXPORT_SYMBOL_GPL(ahci_init_controller);
 
@@ -1554,6 +1563,8 @@ int ahci_do_hardreset(struct ata_link *link, unsigned int *class,
 	tf.command = ATA_BUSY;
 	ata_tf_to_fis(&tf, 0, 0, d2h_fis);
 
+	ahci_port_clear_pending_irq(ap);
+
 	rc = sata_link_hardreset(link, timing, deadline, online,
 				 ahci_check_ready);
 
@@ -1905,8 +1916,6 @@ static irqreturn_t ahci_multi_irqs_intr_hard(int irq, void *dev_instance)
 	void __iomem *port_mmio = ahci_port_base(ap);
 	u32 status;
 
-	VPRINTK("ENTER\n");
-
 	status = readl(port_mmio + PORT_IRQ_STAT);
 	writel(status, port_mmio + PORT_IRQ_STAT);
 
@@ -1914,8 +1923,6 @@ static irqreturn_t ahci_multi_irqs_intr_hard(int irq, void *dev_instance)
 	ahci_handle_port_interrupt(ap, port_mmio, status);
 	spin_unlock(ap->lock);
 
-	VPRINTK("EXIT\n");
-
 	return IRQ_HANDLED;
 }
 
@@ -1932,9 +1939,7 @@ u32 ahci_handle_port_intr(struct ata_host *host, u32 irq_masked)
 		ap = host->ports[i];
 		if (ap) {
 			ahci_port_intr(ap);
-			VPRINTK("port %u\n", i);
 		} else {
-			VPRINTK("port %u (no irq)\n", i);
 			if (ata_ratelimit())
 				dev_warn(host->dev,
 					 "interrupt on disabled port %u\n", i);
@@ -1955,8 +1960,6 @@ static irqreturn_t ahci_single_level_irq_intr(int irq, void *dev_instance)
 	void __iomem *mmio;
 	u32 irq_stat, irq_masked;
 
-	VPRINTK("ENTER\n");
-
 	hpriv = host->private_data;
 	mmio = hpriv->mmio;
 
@@ -1984,8 +1987,6 @@ static irqreturn_t ahci_single_level_irq_intr(int irq, void *dev_instance)
 
 	spin_unlock(&host->lock);
 
-	VPRINTK("EXIT\n");
-
 	return IRQ_RETVAL(rc);
 }
 
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 14150767be44..702b8e061b36 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4974,17 +4974,19 @@ static void ata_port_request_pm(struct ata_port *ap, pm_message_t mesg,
 	struct ata_link *link;
 	unsigned long flags;
 
-	/* Previous resume operation might still be in
-	 * progress.  Wait for PM_PENDING to clear.
+	spin_lock_irqsave(ap->lock, flags);
+
+	/*
+	 * A previous PM operation might still be in progress. Wait for
+	 * ATA_PFLAG_PM_PENDING to clear.
 	 */
 	if (ap->pflags & ATA_PFLAG_PM_PENDING) {
+		spin_unlock_irqrestore(ap->lock, flags);
 		ata_port_wait_eh(ap);
-		WARN_ON(ap->pflags & ATA_PFLAG_PM_PENDING);
+		spin_lock_irqsave(ap->lock, flags);
 	}
 
-	/* request PM ops to EH */
-	spin_lock_irqsave(ap->lock, flags);
-
+	/* Request PM operation to EH */
 	ap->pm_mesg = mesg;
 	ap->pflags |= ATA_PFLAG_PM_PENDING;
 	ata_for_each_link(link, ap, HOST_FIRST) {
@@ -4996,10 +4998,8 @@ static void ata_port_request_pm(struct ata_port *ap, pm_message_t mesg,
 
 	spin_unlock_irqrestore(ap->lock, flags);
 
-	if (!async) {
+	if (!async)
 		ata_port_wait_eh(ap);
-		WARN_ON(ap->pflags & ATA_PFLAG_PM_PENDING);
-	}
 }
 
 /*
@@ -5167,7 +5167,7 @@ EXPORT_SYMBOL_GPL(ata_host_resume);
 #endif
 
 const struct device_type ata_port_type = {
-	.name = "ata_port",
+	.name = ATA_PORT_TYPE_NAME,
 #ifdef CONFIG_PM
 	.pm = &ata_port_pm_ops,
 #endif
@@ -5915,11 +5915,30 @@ static void ata_port_detach(struct ata_port *ap)
 	if (!ap->ops->error_handler)
 		goto skip_eh;
 
-	/* tell EH we're leaving & flush EH */
+	/* Wait for any ongoing EH */
+	ata_port_wait_eh(ap);
+
+	mutex_lock(&ap->scsi_scan_mutex);
 	spin_lock_irqsave(ap->lock, flags);
+
+	/* Remove scsi devices */
+	ata_for_each_link(link, ap, HOST_FIRST) {
+		ata_for_each_dev(dev, link, ALL) {
+			if (dev->sdev) {
+				spin_unlock_irqrestore(ap->lock, flags);
+				scsi_remove_device(dev->sdev);
+				spin_lock_irqsave(ap->lock, flags);
+				dev->sdev = NULL;
+			}
+		}
+	}
+
+	/* Tell EH to disable all devices */
 	ap->pflags |= ATA_PFLAG_UNLOADING;
 	ata_port_schedule_eh(ap);
+
 	spin_unlock_irqrestore(ap->lock, flags);
+	mutex_unlock(&ap->scsi_scan_mutex);
 
 	/* wait till EH commits suicide */
 	ata_port_wait_eh(ap);
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 973f4d34d7cd..5fb3eda0a280 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2703,18 +2703,11 @@ int ata_eh_reset(struct ata_link *link, int classify,
 			postreset(slave, classes);
 	}
 
-	/*
-	 * Some controllers can't be frozen very well and may set spurious
-	 * error conditions during reset.  Clear accumulated error
-	 * information and re-thaw the port if frozen.  As reset is the
-	 * final recovery action and we cross check link onlineness against
-	 * device classification later, no hotplug event is lost by this.
-	 */
+	/* clear cached SError */
 	spin_lock_irqsave(link->ap->lock, flags);
-	memset(&link->eh_info, 0, sizeof(link->eh_info));
+	link->eh_info.serror = 0;
 	if (slave)
-		memset(&slave->eh_info, 0, sizeof(link->eh_info));
-	ap->pflags &= ~ATA_PFLAG_EH_PENDING;
+		slave->eh_info.serror = 0;
 	spin_unlock_irqrestore(link->ap->lock, flags);
 
 	if (ap->pflags & ATA_PFLAG_FROZEN)
diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 4fd9a107fe7f..45656067c547 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -317,7 +317,7 @@ int sata_link_resume(struct ata_link *link, const unsigned long *params,
 		 * immediately after resuming.  Delay 200ms before
 		 * debouncing.
 		 */
-		if (!(link->flags & ATA_LFLAG_NO_DB_DELAY))
+		if (!(link->flags & ATA_LFLAG_NO_DEBOUNCE_DELAY))
 			ata_msleep(link->ap, 200);
 
 		/* is SControl restored correctly? */
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index dfa090ccd21c..36f32fa052df 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -4259,7 +4259,7 @@ void ata_scsi_simulate(struct ata_device *dev, struct scsi_cmnd *cmd)
 		break;
 
 	case MAINTENANCE_IN:
-		if (scsicmd[1] == MI_REPORT_SUPPORTED_OPERATION_CODES)
+		if ((scsicmd[1] & 0x1f) == MI_REPORT_SUPPORTED_OPERATION_CODES)
 			ata_scsi_rbuf_fill(&args, ata_scsiop_maint_in);
 		else
 			ata_scsi_set_invalid_field(dev, cmd, 1, 0xff);
diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
index 31a66fc0c31d..513b37942422 100644
--- a/drivers/ata/libata-transport.c
+++ b/drivers/ata/libata-transport.c
@@ -266,6 +266,10 @@ void ata_tport_delete(struct ata_port *ap)
 	put_device(dev);
 }
 
+static const struct device_type ata_port_sas_type = {
+	.name = ATA_PORT_TYPE_NAME,
+};
+
 /** ata_tport_add - initialize a transport ATA port structure
  *
  * @parent:	parent device
@@ -283,7 +287,10 @@ int ata_tport_add(struct device *parent,
 	struct device *dev = &ap->tdev;
 
 	device_initialize(dev);
-	dev->type = &ata_port_type;
+	if (ap->flags & ATA_FLAG_SAS_HOST)
+		dev->type = &ata_port_sas_type;
+	else
+		dev->type = &ata_port_type;
 
 	dev->parent = parent;
 	ata_host_get(ap->host);
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 68cdd81d747c..bf71bd9e66cd 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -30,6 +30,8 @@ enum {
 	ATA_DNXFER_QUIET	= (1 << 31),
 };
 
+#define ATA_PORT_TYPE_NAME	"ata_port"
+
 extern atomic_t ata_print_id;
 extern int atapi_passthru16;
 extern int libata_fua;
diff --git a/drivers/base/regmap/regcache-rbtree.c b/drivers/base/regmap/regcache-rbtree.c
index ae6b8788d5f3..d65715b9e129 100644
--- a/drivers/base/regmap/regcache-rbtree.c
+++ b/drivers/base/regmap/regcache-rbtree.c
@@ -453,7 +453,8 @@ static int regcache_rbtree_write(struct regmap *map, unsigned int reg,
 		if (!rbnode)
 			return -ENOMEM;
 		regcache_rbtree_set_register(map, rbnode,
-					     reg - rbnode->base_reg, value);
+					     (reg - rbnode->base_reg) / map->reg_stride,
+					     value);
 		regcache_rbtree_insert(map, &rbtree_ctx->root, rbnode);
 		rbtree_ctx->cached_rbnode = rbnode;
 	}
diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 95cbd5790ed6..b0f7930524ba 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -632,9 +632,8 @@ void rbd_warn(struct rbd_device *rbd_dev, const char *fmt, ...)
 static void rbd_dev_remove_parent(struct rbd_device *rbd_dev);
 
 static int rbd_dev_refresh(struct rbd_device *rbd_dev);
-static int rbd_dev_v2_header_onetime(struct rbd_device *rbd_dev);
-static int rbd_dev_header_info(struct rbd_device *rbd_dev);
-static int rbd_dev_v2_parent_info(struct rbd_device *rbd_dev);
+static int rbd_dev_v2_header_onetime(struct rbd_device *rbd_dev,
+				     struct rbd_image_header *header);
 static const char *rbd_dev_v2_snap_name(struct rbd_device *rbd_dev,
 					u64 snap_id);
 static int _rbd_dev_v2_snap_size(struct rbd_device *rbd_dev, u64 snap_id,
@@ -1047,15 +1046,24 @@ static void rbd_init_layout(struct rbd_device *rbd_dev)
 	RCU_INIT_POINTER(rbd_dev->layout.pool_ns, NULL);
 }
 
+static void rbd_image_header_cleanup(struct rbd_image_header *header)
+{
+	kfree(header->object_prefix);
+	ceph_put_snap_context(header->snapc);
+	kfree(header->snap_sizes);
+	kfree(header->snap_names);
+
+	memset(header, 0, sizeof(*header));
+}
+
 /*
  * Fill an rbd image header with information from the given format 1
  * on-disk header.
  */
-static int rbd_header_from_disk(struct rbd_device *rbd_dev,
-				 struct rbd_image_header_ondisk *ondisk)
+static int rbd_header_from_disk(struct rbd_image_header *header,
+				struct rbd_image_header_ondisk *ondisk,
+				bool first_time)
 {
-	struct rbd_image_header *header = &rbd_dev->header;
-	bool first_time = header->object_prefix == NULL;
 	struct ceph_snap_context *snapc;
 	char *object_prefix = NULL;
 	char *snap_names = NULL;
@@ -1122,11 +1130,6 @@ static int rbd_header_from_disk(struct rbd_device *rbd_dev,
 	if (first_time) {
 		header->object_prefix = object_prefix;
 		header->obj_order = ondisk->options.order;
-		rbd_init_layout(rbd_dev);
-	} else {
-		ceph_put_snap_context(header->snapc);
-		kfree(header->snap_names);
-		kfree(header->snap_sizes);
 	}
 
 	/* The remaining fields always get updated (when we refresh) */
@@ -4916,7 +4919,9 @@ static int rbd_obj_read_sync(struct rbd_device *rbd_dev,
  * return, the rbd_dev->header field will contain up-to-date
  * information about the image.
  */
-static int rbd_dev_v1_header_info(struct rbd_device *rbd_dev)
+static int rbd_dev_v1_header_info(struct rbd_device *rbd_dev,
+				  struct rbd_image_header *header,
+				  bool first_time)
 {
 	struct rbd_image_header_ondisk *ondisk = NULL;
 	u32 snap_count = 0;
@@ -4964,7 +4969,7 @@ static int rbd_dev_v1_header_info(struct rbd_device *rbd_dev)
 		snap_count = le32_to_cpu(ondisk->snap_count);
 	} while (snap_count != want_count);
 
-	ret = rbd_header_from_disk(rbd_dev, ondisk);
+	ret = rbd_header_from_disk(header, ondisk, first_time);
 out:
 	kfree(ondisk);
 
@@ -4989,39 +4994,6 @@ static void rbd_dev_update_size(struct rbd_device *rbd_dev)
 	}
 }
 
-static int rbd_dev_refresh(struct rbd_device *rbd_dev)
-{
-	u64 mapping_size;
-	int ret;
-
-	down_write(&rbd_dev->header_rwsem);
-	mapping_size = rbd_dev->mapping.size;
-
-	ret = rbd_dev_header_info(rbd_dev);
-	if (ret)
-		goto out;
-
-	/*
-	 * If there is a parent, see if it has disappeared due to the
-	 * mapped image getting flattened.
-	 */
-	if (rbd_dev->parent) {
-		ret = rbd_dev_v2_parent_info(rbd_dev);
-		if (ret)
-			goto out;
-	}
-
-	rbd_assert(!rbd_is_snap(rbd_dev));
-	rbd_dev->mapping.size = rbd_dev->header.image_size;
-
-out:
-	up_write(&rbd_dev->header_rwsem);
-	if (!ret && mapping_size != rbd_dev->mapping.size)
-		rbd_dev_update_size(rbd_dev);
-
-	return ret;
-}
-
 static const struct blk_mq_ops rbd_mq_ops = {
 	.queue_rq	= rbd_queue_rq,
 };
@@ -5576,17 +5548,12 @@ static int _rbd_dev_v2_snap_size(struct rbd_device *rbd_dev, u64 snap_id,
 	return 0;
 }
 
-static int rbd_dev_v2_image_size(struct rbd_device *rbd_dev)
-{
-	return _rbd_dev_v2_snap_size(rbd_dev, CEPH_NOSNAP,
-					&rbd_dev->header.obj_order,
-					&rbd_dev->header.image_size);
-}
-
-static int rbd_dev_v2_object_prefix(struct rbd_device *rbd_dev)
+static int rbd_dev_v2_object_prefix(struct rbd_device *rbd_dev,
+				    char **pobject_prefix)
 {
 	size_t size;
 	void *reply_buf;
+	char *object_prefix;
 	int ret;
 	void *p;
 
@@ -5604,16 +5571,16 @@ static int rbd_dev_v2_object_prefix(struct rbd_device *rbd_dev)
 		goto out;
 
 	p = reply_buf;
-	rbd_dev->header.object_prefix = ceph_extract_encoded_string(&p,
-						p + ret, NULL, GFP_NOIO);
+	object_prefix = ceph_extract_encoded_string(&p, p + ret, NULL,
+						    GFP_NOIO);
+	if (IS_ERR(object_prefix)) {
+		ret = PTR_ERR(object_prefix);
+		goto out;
+	}
 	ret = 0;
 
-	if (IS_ERR(rbd_dev->header.object_prefix)) {
-		ret = PTR_ERR(rbd_dev->header.object_prefix);
-		rbd_dev->header.object_prefix = NULL;
-	} else {
-		dout("  object_prefix = %s\n", rbd_dev->header.object_prefix);
-	}
+	*pobject_prefix = object_prefix;
+	dout("  object_prefix = %s\n", object_prefix);
 out:
 	kfree(reply_buf);
 
@@ -5664,13 +5631,6 @@ static int _rbd_dev_v2_snap_features(struct rbd_device *rbd_dev, u64 snap_id,
 	return 0;
 }
 
-static int rbd_dev_v2_features(struct rbd_device *rbd_dev)
-{
-	return _rbd_dev_v2_snap_features(rbd_dev, CEPH_NOSNAP,
-					 rbd_is_ro(rbd_dev),
-					 &rbd_dev->header.features);
-}
-
 /*
  * These are generic image flags, but since they are used only for
  * object map, store them in rbd_dev->object_map_flags.
@@ -5707,6 +5667,14 @@ struct parent_image_info {
 	u64		overlap;
 };
 
+static void rbd_parent_info_cleanup(struct parent_image_info *pii)
+{
+	kfree(pii->pool_ns);
+	kfree(pii->image_id);
+
+	memset(pii, 0, sizeof(*pii));
+}
+
 /*
  * The caller is responsible for @pii.
  */
@@ -5776,6 +5744,9 @@ static int __get_parent_info(struct rbd_device *rbd_dev,
 	if (pii->has_overlap)
 		ceph_decode_64_safe(&p, end, pii->overlap, e_inval);
 
+	dout("%s pool_id %llu pool_ns %s image_id %s snap_id %llu has_overlap %d overlap %llu\n",
+	     __func__, pii->pool_id, pii->pool_ns, pii->image_id, pii->snap_id,
+	     pii->has_overlap, pii->overlap);
 	return 0;
 
 e_inval:
@@ -5814,14 +5785,17 @@ static int __get_parent_info_legacy(struct rbd_device *rbd_dev,
 	pii->has_overlap = true;
 	ceph_decode_64_safe(&p, end, pii->overlap, e_inval);
 
+	dout("%s pool_id %llu pool_ns %s image_id %s snap_id %llu has_overlap %d overlap %llu\n",
+	     __func__, pii->pool_id, pii->pool_ns, pii->image_id, pii->snap_id,
+	     pii->has_overlap, pii->overlap);
 	return 0;
 
 e_inval:
 	return -EINVAL;
 }
 
-static int get_parent_info(struct rbd_device *rbd_dev,
-			   struct parent_image_info *pii)
+static int rbd_dev_v2_parent_info(struct rbd_device *rbd_dev,
+				  struct parent_image_info *pii)
 {
 	struct page *req_page, *reply_page;
 	void *p;
@@ -5849,7 +5823,7 @@ static int get_parent_info(struct rbd_device *rbd_dev,
 	return ret;
 }
 
-static int rbd_dev_v2_parent_info(struct rbd_device *rbd_dev)
+static int rbd_dev_setup_parent(struct rbd_device *rbd_dev)
 {
 	struct rbd_spec *parent_spec;
 	struct parent_image_info pii = { 0 };
@@ -5859,37 +5833,12 @@ static int rbd_dev_v2_parent_info(struct rbd_device *rbd_dev)
 	if (!parent_spec)
 		return -ENOMEM;
 
-	ret = get_parent_info(rbd_dev, &pii);
+	ret = rbd_dev_v2_parent_info(rbd_dev, &pii);
 	if (ret)
 		goto out_err;
 
-	dout("%s pool_id %llu pool_ns %s image_id %s snap_id %llu has_overlap %d overlap %llu\n",
-	     __func__, pii.pool_id, pii.pool_ns, pii.image_id, pii.snap_id,
-	     pii.has_overlap, pii.overlap);
-
-	if (pii.pool_id == CEPH_NOPOOL || !pii.has_overlap) {
-		/*
-		 * Either the parent never existed, or we have
-		 * record of it but the image got flattened so it no
-		 * longer has a parent.  When the parent of a
-		 * layered image disappears we immediately set the
-		 * overlap to 0.  The effect of this is that all new
-		 * requests will be treated as if the image had no
-		 * parent.
-		 *
-		 * If !pii.has_overlap, the parent image spec is not
-		 * applicable.  It's there to avoid duplication in each
-		 * snapshot record.
-		 */
-		if (rbd_dev->parent_overlap) {
-			rbd_dev->parent_overlap = 0;
-			rbd_dev_parent_put(rbd_dev);
-			pr_info("%s: clone image has been flattened\n",
-				rbd_dev->disk->disk_name);
-		}
-
+	if (pii.pool_id == CEPH_NOPOOL || !pii.has_overlap)
 		goto out;	/* No parent?  No problem. */
-	}
 
 	/* The ceph file layout needs to fit pool id in 32 bits */
 
@@ -5901,58 +5850,46 @@ static int rbd_dev_v2_parent_info(struct rbd_device *rbd_dev)
 	}
 
 	/*
-	 * The parent won't change (except when the clone is
-	 * flattened, already handled that).  So we only need to
-	 * record the parent spec we have not already done so.
+	 * The parent won't change except when the clone is flattened,
+	 * so we only need to record the parent image spec once.
 	 */
-	if (!rbd_dev->parent_spec) {
-		parent_spec->pool_id = pii.pool_id;
-		if (pii.pool_ns && *pii.pool_ns) {
-			parent_spec->pool_ns = pii.pool_ns;
-			pii.pool_ns = NULL;
-		}
-		parent_spec->image_id = pii.image_id;
-		pii.image_id = NULL;
-		parent_spec->snap_id = pii.snap_id;
-
-		rbd_dev->parent_spec = parent_spec;
-		parent_spec = NULL;	/* rbd_dev now owns this */
+	parent_spec->pool_id = pii.pool_id;
+	if (pii.pool_ns && *pii.pool_ns) {
+		parent_spec->pool_ns = pii.pool_ns;
+		pii.pool_ns = NULL;
 	}
+	parent_spec->image_id = pii.image_id;
+	pii.image_id = NULL;
+	parent_spec->snap_id = pii.snap_id;
+
+	rbd_assert(!rbd_dev->parent_spec);
+	rbd_dev->parent_spec = parent_spec;
+	parent_spec = NULL;	/* rbd_dev now owns this */
 
 	/*
-	 * We always update the parent overlap.  If it's zero we issue
-	 * a warning, as we will proceed as if there was no parent.
+	 * Record the parent overlap.  If it's zero, issue a warning as
+	 * we will proceed as if there is no parent.
 	 */
-	if (!pii.overlap) {
-		if (parent_spec) {
-			/* refresh, careful to warn just once */
-			if (rbd_dev->parent_overlap)
-				rbd_warn(rbd_dev,
-				    "clone now standalone (overlap became 0)");
-		} else {
-			/* initial probe */
-			rbd_warn(rbd_dev, "clone is standalone (overlap 0)");
-		}
-	}
+	if (!pii.overlap)
+		rbd_warn(rbd_dev, "clone is standalone (overlap 0)");
 	rbd_dev->parent_overlap = pii.overlap;
 
 out:
 	ret = 0;
 out_err:
-	kfree(pii.pool_ns);
-	kfree(pii.image_id);
+	rbd_parent_info_cleanup(&pii);
 	rbd_spec_put(parent_spec);
 	return ret;
 }
 
-static int rbd_dev_v2_striping_info(struct rbd_device *rbd_dev)
+static int rbd_dev_v2_striping_info(struct rbd_device *rbd_dev,
+				    u64 *stripe_unit, u64 *stripe_count)
 {
 	struct {
 		__le64 stripe_unit;
 		__le64 stripe_count;
 	} __attribute__ ((packed)) striping_info_buf = { 0 };
 	size_t size = sizeof (striping_info_buf);
-	void *p;
 	int ret;
 
 	ret = rbd_obj_method_sync(rbd_dev, &rbd_dev->header_oid,
@@ -5964,27 +5901,33 @@ static int rbd_dev_v2_striping_info(struct rbd_device *rbd_dev)
 	if (ret < size)
 		return -ERANGE;
 
-	p = &striping_info_buf;
-	rbd_dev->header.stripe_unit = ceph_decode_64(&p);
-	rbd_dev->header.stripe_count = ceph_decode_64(&p);
+	*stripe_unit = le64_to_cpu(striping_info_buf.stripe_unit);
+	*stripe_count = le64_to_cpu(striping_info_buf.stripe_count);
+	dout("  stripe_unit = %llu stripe_count = %llu\n", *stripe_unit,
+	     *stripe_count);
+
 	return 0;
 }
 
-static int rbd_dev_v2_data_pool(struct rbd_device *rbd_dev)
+static int rbd_dev_v2_data_pool(struct rbd_device *rbd_dev, s64 *data_pool_id)
 {
-	__le64 data_pool_id;
+	__le64 data_pool_buf;
 	int ret;
 
 	ret = rbd_obj_method_sync(rbd_dev, &rbd_dev->header_oid,
 				  &rbd_dev->header_oloc, "get_data_pool",
-				  NULL, 0, &data_pool_id, sizeof(data_pool_id));
+				  NULL, 0, &data_pool_buf,
+				  sizeof(data_pool_buf));
+	dout("%s: rbd_obj_method_sync returned %d\n", __func__, ret);
 	if (ret < 0)
 		return ret;
-	if (ret < sizeof(data_pool_id))
+	if (ret < sizeof(data_pool_buf))
 		return -EBADMSG;
 
-	rbd_dev->header.data_pool_id = le64_to_cpu(data_pool_id);
-	WARN_ON(rbd_dev->header.data_pool_id == CEPH_NOPOOL);
+	*data_pool_id = le64_to_cpu(data_pool_buf);
+	dout("  data_pool_id = %lld\n", *data_pool_id);
+	WARN_ON(*data_pool_id == CEPH_NOPOOL);
+
 	return 0;
 }
 
@@ -6176,7 +6119,8 @@ static int rbd_spec_fill_names(struct rbd_device *rbd_dev)
 	return ret;
 }
 
-static int rbd_dev_v2_snap_context(struct rbd_device *rbd_dev)
+static int rbd_dev_v2_snap_context(struct rbd_device *rbd_dev,
+				   struct ceph_snap_context **psnapc)
 {
 	size_t size;
 	int ret;
@@ -6237,9 +6181,7 @@ static int rbd_dev_v2_snap_context(struct rbd_device *rbd_dev)
 	for (i = 0; i < snap_count; i++)
 		snapc->snaps[i] = ceph_decode_64(&p);
 
-	ceph_put_snap_context(rbd_dev->header.snapc);
-	rbd_dev->header.snapc = snapc;
-
+	*psnapc = snapc;
 	dout("  snap context seq = %llu, snap_count = %u\n",
 		(unsigned long long)seq, (unsigned int)snap_count);
 out:
@@ -6288,38 +6230,42 @@ static const char *rbd_dev_v2_snap_name(struct rbd_device *rbd_dev,
 	return snap_name;
 }
 
-static int rbd_dev_v2_header_info(struct rbd_device *rbd_dev)
+static int rbd_dev_v2_header_info(struct rbd_device *rbd_dev,
+				  struct rbd_image_header *header,
+				  bool first_time)
 {
-	bool first_time = rbd_dev->header.object_prefix == NULL;
 	int ret;
 
-	ret = rbd_dev_v2_image_size(rbd_dev);
+	ret = _rbd_dev_v2_snap_size(rbd_dev, CEPH_NOSNAP,
+				    first_time ? &header->obj_order : NULL,
+				    &header->image_size);
 	if (ret)
 		return ret;
 
 	if (first_time) {
-		ret = rbd_dev_v2_header_onetime(rbd_dev);
+		ret = rbd_dev_v2_header_onetime(rbd_dev, header);
 		if (ret)
 			return ret;
 	}
 
-	ret = rbd_dev_v2_snap_context(rbd_dev);
-	if (ret && first_time) {
-		kfree(rbd_dev->header.object_prefix);
-		rbd_dev->header.object_prefix = NULL;
-	}
+	ret = rbd_dev_v2_snap_context(rbd_dev, &header->snapc);
+	if (ret)
+		return ret;
 
-	return ret;
+	return 0;
 }
 
-static int rbd_dev_header_info(struct rbd_device *rbd_dev)
+static int rbd_dev_header_info(struct rbd_device *rbd_dev,
+			       struct rbd_image_header *header,
+			       bool first_time)
 {
 	rbd_assert(rbd_image_format_valid(rbd_dev->image_format));
+	rbd_assert(!header->object_prefix && !header->snapc);
 
 	if (rbd_dev->image_format == 1)
-		return rbd_dev_v1_header_info(rbd_dev);
+		return rbd_dev_v1_header_info(rbd_dev, header, first_time);
 
-	return rbd_dev_v2_header_info(rbd_dev);
+	return rbd_dev_v2_header_info(rbd_dev, header, first_time);
 }
 
 /*
@@ -6806,60 +6752,49 @@ static int rbd_dev_image_id(struct rbd_device *rbd_dev)
  */
 static void rbd_dev_unprobe(struct rbd_device *rbd_dev)
 {
-	struct rbd_image_header	*header;
-
 	rbd_dev_parent_put(rbd_dev);
 	rbd_object_map_free(rbd_dev);
 	rbd_dev_mapping_clear(rbd_dev);
 
 	/* Free dynamic fields from the header, then zero it out */
 
-	header = &rbd_dev->header;
-	ceph_put_snap_context(header->snapc);
-	kfree(header->snap_sizes);
-	kfree(header->snap_names);
-	kfree(header->object_prefix);
-	memset(header, 0, sizeof (*header));
+	rbd_image_header_cleanup(&rbd_dev->header);
 }
 
-static int rbd_dev_v2_header_onetime(struct rbd_device *rbd_dev)
+static int rbd_dev_v2_header_onetime(struct rbd_device *rbd_dev,
+				     struct rbd_image_header *header)
 {
 	int ret;
 
-	ret = rbd_dev_v2_object_prefix(rbd_dev);
+	ret = rbd_dev_v2_object_prefix(rbd_dev, &header->object_prefix);
 	if (ret)
-		goto out_err;
+		return ret;
 
 	/*
 	 * Get the and check features for the image.  Currently the
 	 * features are assumed to never change.
 	 */
-	ret = rbd_dev_v2_features(rbd_dev);
+	ret = _rbd_dev_v2_snap_features(rbd_dev, CEPH_NOSNAP,
+					rbd_is_ro(rbd_dev), &header->features);
 	if (ret)
-		goto out_err;
+		return ret;
 
 	/* If the image supports fancy striping, get its parameters */
 
-	if (rbd_dev->header.features & RBD_FEATURE_STRIPINGV2) {
-		ret = rbd_dev_v2_striping_info(rbd_dev);
-		if (ret < 0)
-			goto out_err;
+	if (header->features & RBD_FEATURE_STRIPINGV2) {
+		ret = rbd_dev_v2_striping_info(rbd_dev, &header->stripe_unit,
+					       &header->stripe_count);
+		if (ret)
+			return ret;
 	}
 
-	if (rbd_dev->header.features & RBD_FEATURE_DATA_POOL) {
-		ret = rbd_dev_v2_data_pool(rbd_dev);
+	if (header->features & RBD_FEATURE_DATA_POOL) {
+		ret = rbd_dev_v2_data_pool(rbd_dev, &header->data_pool_id);
 		if (ret)
-			goto out_err;
+			return ret;
 	}
 
-	rbd_init_layout(rbd_dev);
 	return 0;
-
-out_err:
-	rbd_dev->header.features = 0;
-	kfree(rbd_dev->header.object_prefix);
-	rbd_dev->header.object_prefix = NULL;
-	return ret;
 }
 
 /*
@@ -7054,13 +6989,15 @@ static int rbd_dev_image_probe(struct rbd_device *rbd_dev, int depth)
 	if (!depth)
 		down_write(&rbd_dev->header_rwsem);
 
-	ret = rbd_dev_header_info(rbd_dev);
+	ret = rbd_dev_header_info(rbd_dev, &rbd_dev->header, true);
 	if (ret) {
 		if (ret == -ENOENT && !need_watch)
 			rbd_print_dne(rbd_dev, false);
 		goto err_out_probe;
 	}
 
+	rbd_init_layout(rbd_dev);
+
 	/*
 	 * If this image is the one being mapped, we have pool name and
 	 * id, image name and id, and snap name - need to fill snap id.
@@ -7089,7 +7026,7 @@ static int rbd_dev_image_probe(struct rbd_device *rbd_dev, int depth)
 	}
 
 	if (rbd_dev->header.features & RBD_FEATURE_LAYERING) {
-		ret = rbd_dev_v2_parent_info(rbd_dev);
+		ret = rbd_dev_setup_parent(rbd_dev);
 		if (ret)
 			goto err_out_probe;
 	}
@@ -7115,6 +7052,107 @@ static int rbd_dev_image_probe(struct rbd_device *rbd_dev, int depth)
 	return ret;
 }
 
+static void rbd_dev_update_header(struct rbd_device *rbd_dev,
+				  struct rbd_image_header *header)
+{
+	rbd_assert(rbd_image_format_valid(rbd_dev->image_format));
+	rbd_assert(rbd_dev->header.object_prefix); /* !first_time */
+
+	if (rbd_dev->header.image_size != header->image_size) {
+		rbd_dev->header.image_size = header->image_size;
+
+		if (!rbd_is_snap(rbd_dev)) {
+			rbd_dev->mapping.size = header->image_size;
+			rbd_dev_update_size(rbd_dev);
+		}
+	}
+
+	ceph_put_snap_context(rbd_dev->header.snapc);
+	rbd_dev->header.snapc = header->snapc;
+	header->snapc = NULL;
+
+	if (rbd_dev->image_format == 1) {
+		kfree(rbd_dev->header.snap_names);
+		rbd_dev->header.snap_names = header->snap_names;
+		header->snap_names = NULL;
+
+		kfree(rbd_dev->header.snap_sizes);
+		rbd_dev->header.snap_sizes = header->snap_sizes;
+		header->snap_sizes = NULL;
+	}
+}
+
+static void rbd_dev_update_parent(struct rbd_device *rbd_dev,
+				  struct parent_image_info *pii)
+{
+	if (pii->pool_id == CEPH_NOPOOL || !pii->has_overlap) {
+		/*
+		 * Either the parent never existed, or we have
+		 * record of it but the image got flattened so it no
+		 * longer has a parent.  When the parent of a
+		 * layered image disappears we immediately set the
+		 * overlap to 0.  The effect of this is that all new
+		 * requests will be treated as if the image had no
+		 * parent.
+		 *
+		 * If !pii.has_overlap, the parent image spec is not
+		 * applicable.  It's there to avoid duplication in each
+		 * snapshot record.
+		 */
+		if (rbd_dev->parent_overlap) {
+			rbd_dev->parent_overlap = 0;
+			rbd_dev_parent_put(rbd_dev);
+			pr_info("%s: clone has been flattened\n",
+				rbd_dev->disk->disk_name);
+		}
+	} else {
+		rbd_assert(rbd_dev->parent_spec);
+
+		/*
+		 * Update the parent overlap.  If it became zero, issue
+		 * a warning as we will proceed as if there is no parent.
+		 */
+		if (!pii->overlap && rbd_dev->parent_overlap)
+			rbd_warn(rbd_dev,
+				 "clone has become standalone (overlap 0)");
+		rbd_dev->parent_overlap = pii->overlap;
+	}
+}
+
+static int rbd_dev_refresh(struct rbd_device *rbd_dev)
+{
+	struct rbd_image_header	header = { 0 };
+	struct parent_image_info pii = { 0 };
+	int ret;
+
+	dout("%s rbd_dev %p\n", __func__, rbd_dev);
+
+	ret = rbd_dev_header_info(rbd_dev, &header, false);
+	if (ret)
+		goto out;
+
+	/*
+	 * If there is a parent, see if it has disappeared due to the
+	 * mapped image getting flattened.
+	 */
+	if (rbd_dev->parent) {
+		ret = rbd_dev_v2_parent_info(rbd_dev, &pii);
+		if (ret)
+			goto out;
+	}
+
+	down_write(&rbd_dev->header_rwsem);
+	rbd_dev_update_header(rbd_dev, &header);
+	if (rbd_dev->parent)
+		rbd_dev_update_parent(rbd_dev, &pii);
+	up_write(&rbd_dev->header_rwsem);
+
+out:
+	rbd_parent_info_cleanup(&pii);
+	rbd_image_header_cleanup(&header);
+	return ret;
+}
+
 static ssize_t do_rbd_add(struct bus_type *bus,
 			  const char *buf,
 			  size_t count)
diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index 5e8c078efd22..ef8c7bfd79a8 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -38,6 +38,7 @@ enum sysc_soc {
 	SOC_2420,
 	SOC_2430,
 	SOC_3430,
+	SOC_AM35,
 	SOC_3630,
 	SOC_4430,
 	SOC_4460,
@@ -1113,6 +1114,11 @@ static int sysc_enable_module(struct device *dev)
 	if (ddata->cfg.quirks & (SYSC_QUIRK_SWSUP_SIDLE |
 				 SYSC_QUIRK_SWSUP_SIDLE_ACT)) {
 		best_mode = SYSC_IDLE_NO;
+
+		/* Clear WAKEUP */
+		if (regbits->enwkup_shift >= 0 &&
+		    ddata->cfg.sysc_val & BIT(regbits->enwkup_shift))
+			reg &= ~BIT(regbits->enwkup_shift);
 	} else {
 		best_mode = fls(ddata->cfg.sidlemodes) - 1;
 		if (best_mode > SYSC_IDLE_MASK) {
@@ -1233,6 +1239,13 @@ static int sysc_disable_module(struct device *dev)
 		}
 	}
 
+	if (ddata->cfg.quirks & SYSC_QUIRK_SWSUP_SIDLE_ACT) {
+		/* Set WAKEUP */
+		if (regbits->enwkup_shift >= 0 &&
+		    ddata->cfg.sysc_val & BIT(regbits->enwkup_shift))
+			reg |= BIT(regbits->enwkup_shift);
+	}
+
 	reg &= ~(SYSC_IDLE_MASK << regbits->sidle_shift);
 	reg |= best_mode << regbits->sidle_shift;
 	if (regbits->autoidle_shift >= 0 &&
@@ -1496,16 +1509,16 @@ static const struct sysc_revision_quirk sysc_revision_quirks[] = {
 	SYSC_QUIRK("smartreflex", 0, -ENODEV, 0x38, -ENODEV, 0x00000000, 0xffffffff,
 		   SYSC_QUIRK_LEGACY_IDLE),
 	SYSC_QUIRK("uart", 0, 0x50, 0x54, 0x58, 0x00000046, 0xffffffff,
-		   SYSC_QUIRK_SWSUP_SIDLE | SYSC_QUIRK_LEGACY_IDLE),
+		   SYSC_QUIRK_SWSUP_SIDLE_ACT | SYSC_QUIRK_LEGACY_IDLE),
 	SYSC_QUIRK("uart", 0, 0x50, 0x54, 0x58, 0x00000052, 0xffffffff,
-		   SYSC_QUIRK_SWSUP_SIDLE | SYSC_QUIRK_LEGACY_IDLE),
+		   SYSC_QUIRK_SWSUP_SIDLE_ACT | SYSC_QUIRK_LEGACY_IDLE),
 	/* Uarts on omap4 and later */
 	SYSC_QUIRK("uart", 0, 0x50, 0x54, 0x58, 0x50411e03, 0xffff00ff,
-		   SYSC_QUIRK_SWSUP_SIDLE | SYSC_QUIRK_LEGACY_IDLE),
+		   SYSC_QUIRK_SWSUP_SIDLE_ACT | SYSC_QUIRK_LEGACY_IDLE),
 	SYSC_QUIRK("uart", 0, 0x50, 0x54, 0x58, 0x47422e03, 0xffffffff,
-		   SYSC_QUIRK_SWSUP_SIDLE | SYSC_QUIRK_LEGACY_IDLE),
+		   SYSC_QUIRK_SWSUP_SIDLE_ACT | SYSC_QUIRK_LEGACY_IDLE),
 	SYSC_QUIRK("uart", 0, 0x50, 0x54, 0x58, 0x47424e03, 0xffffffff,
-		   SYSC_QUIRK_SWSUP_SIDLE | SYSC_QUIRK_LEGACY_IDLE),
+		   SYSC_QUIRK_SWSUP_SIDLE_ACT | SYSC_QUIRK_LEGACY_IDLE),
 
 	/* Quirks that need to be set based on the module address */
 	SYSC_QUIRK("mcpdm", 0x40132000, 0, 0x10, -ENODEV, 0x50000800, 0xffffffff,
@@ -1818,7 +1831,7 @@ static void sysc_pre_reset_quirk_dss(struct sysc *ddata)
 		dev_warn(ddata->dev, "%s: timed out %08x !+ %08x\n",
 			 __func__, val, irq_mask);
 
-	if (sysc_soc->soc == SOC_3430) {
+	if (sysc_soc->soc == SOC_3430 || sysc_soc->soc == SOC_AM35) {
 		/* Clear DSS_SDI_CONTROL */
 		sysc_write(ddata, 0x44, 0);
 
@@ -2085,8 +2098,7 @@ static int sysc_reset(struct sysc *ddata)
 	}
 
 	if (ddata->cfg.srst_udelay)
-		usleep_range(ddata->cfg.srst_udelay,
-			     ddata->cfg.srst_udelay * 2);
+		fsleep(ddata->cfg.srst_udelay);
 
 	if (ddata->post_reset_quirk)
 		ddata->post_reset_quirk(ddata);
@@ -2960,6 +2972,7 @@ static void ti_sysc_idle(struct work_struct *work)
 static const struct soc_device_attribute sysc_soc_match[] = {
 	SOC_FLAG("OMAP242*", SOC_2420),
 	SOC_FLAG("OMAP243*", SOC_2430),
+	SOC_FLAG("AM35*", SOC_AM35),
 	SOC_FLAG("OMAP3[45]*", SOC_3430),
 	SOC_FLAG("OMAP3[67]*", SOC_3630),
 	SOC_FLAG("OMAP443*", SOC_4430),
@@ -3147,7 +3160,7 @@ static int sysc_check_active_timer(struct sysc *ddata)
 	 * can be dropped if we stop supporting old beagleboard revisions
 	 * A to B4 at some point.
 	 */
-	if (sysc_soc->soc == SOC_3430)
+	if (sysc_soc->soc == SOC_3430 || sysc_soc->soc == SOC_AM35)
 		error = -ENXIO;
 	else
 		error = -EBUSY;
diff --git a/drivers/char/agp/parisc-agp.c b/drivers/char/agp/parisc-agp.c
index 514f9f287a78..c6f181702b9a 100644
--- a/drivers/char/agp/parisc-agp.c
+++ b/drivers/char/agp/parisc-agp.c
@@ -394,8 +394,6 @@ find_quicksilver(struct device *dev, void *data)
 static int __init
 parisc_agp_init(void)
 {
-	extern struct sba_device *sba_list;
-
 	int err = -1;
 	struct parisc_device *sba = NULL, *lba = NULL;
 	struct lba_device *lbadev = NULL;
diff --git a/drivers/clk/imx/clk-pll14xx.c b/drivers/clk/imx/clk-pll14xx.c
index e46311c2e63e..aba36e4217d2 100644
--- a/drivers/clk/imx/clk-pll14xx.c
+++ b/drivers/clk/imx/clk-pll14xx.c
@@ -60,6 +60,8 @@ static const struct imx_pll14xx_rate_table imx_pll1443x_tbl[] = {
 	PLL_1443X_RATE(650000000U, 325, 3, 2, 0),
 	PLL_1443X_RATE(594000000U, 198, 2, 2, 0),
 	PLL_1443X_RATE(519750000U, 173, 2, 2, 16384),
+	PLL_1443X_RATE(393216000U, 262, 2, 3, 9437),
+	PLL_1443X_RATE(361267200U, 361, 3, 3, 17511),
 };
 
 struct imx_pll14xx_clk imx_1443x_pll = {
diff --git a/drivers/clk/tegra/clk-bpmp.c b/drivers/clk/tegra/clk-bpmp.c
index a66263b6490d..00845044c98e 100644
--- a/drivers/clk/tegra/clk-bpmp.c
+++ b/drivers/clk/tegra/clk-bpmp.c
@@ -159,7 +159,7 @@ static unsigned long tegra_bpmp_clk_recalc_rate(struct clk_hw *hw,
 
 	err = tegra_bpmp_clk_transfer(clk->bpmp, &msg);
 	if (err < 0)
-		return err;
+		return 0;
 
 	return response.rate;
 }
diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
index e0d5d80ec8e0..bbd04a63fb12 100644
--- a/drivers/gpio/gpio-aspeed.c
+++ b/drivers/gpio/gpio-aspeed.c
@@ -966,7 +966,7 @@ static int aspeed_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
 	else if (param == PIN_CONFIG_BIAS_DISABLE ||
 			param == PIN_CONFIG_BIAS_PULL_DOWN ||
 			param == PIN_CONFIG_DRIVE_STRENGTH)
-		return pinctrl_gpio_set_config(offset, config);
+		return pinctrl_gpio_set_config(chip->base + offset, config);
 	else if (param == PIN_CONFIG_DRIVE_OPEN_DRAIN ||
 			param == PIN_CONFIG_DRIVE_OPEN_SOURCE)
 		/* Return -ENOTSUPP to trigger emulation, as per datasheet */
diff --git a/drivers/gpio/gpio-pmic-eic-sprd.c b/drivers/gpio/gpio-pmic-eic-sprd.c
index 938285190566..e969ce9131dd 100644
--- a/drivers/gpio/gpio-pmic-eic-sprd.c
+++ b/drivers/gpio/gpio-pmic-eic-sprd.c
@@ -338,6 +338,7 @@ static int sprd_pmic_eic_probe(struct platform_device *pdev)
 	pmic_eic->chip.set_config = sprd_pmic_eic_set_config;
 	pmic_eic->chip.set = sprd_pmic_eic_set;
 	pmic_eic->chip.get = sprd_pmic_eic_get;
+	pmic_eic->chip.can_sleep = true;
 
 	pmic_eic->intc.name = dev_name(&pdev->dev);
 	pmic_eic->intc.irq_mask = sprd_pmic_eic_irq_mask;
diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index 0cb6600b8eee..1dbeaf6d0045 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -243,6 +243,7 @@ static bool pxa_gpio_has_pinctrl(void)
 	switch (gpio_type) {
 	case PXA3XX_GPIO:
 	case MMP2_GPIO:
+	case MMP_GPIO:
 		return false;
 
 	default:
diff --git a/drivers/gpio/gpio-tb10x.c b/drivers/gpio/gpio-tb10x.c
index 866201cf5f65..4a9dcaad4a6c 100644
--- a/drivers/gpio/gpio-tb10x.c
+++ b/drivers/gpio/gpio-tb10x.c
@@ -195,7 +195,7 @@ static int tb10x_gpio_probe(struct platform_device *pdev)
 				handle_edge_irq, IRQ_NOREQUEST, IRQ_NOPROBE,
 				IRQ_GC_INIT_MASK_CACHE);
 		if (ret)
-			return ret;
+			goto err_remove_domain;
 
 		gc = tb10x_gpio->domain->gc->gc[0];
 		gc->reg_base                         = tb10x_gpio->base;
@@ -209,6 +209,10 @@ static int tb10x_gpio_probe(struct platform_device *pdev)
 	}
 
 	return 0;
+
+err_remove_domain:
+	irq_domain_remove(tb10x_gpio->domain);
+	return ret;
 }
 
 static int tb10x_gpio_remove(struct platform_device *pdev)
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_gem.c b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
index fe64bf2176f3..b20ea58907c2 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_gem.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
@@ -252,7 +252,7 @@ void *mtk_drm_gem_prime_vmap(struct drm_gem_object *obj)
 	if (!mtk_gem->kvaddr) {
 		kfree(sgt);
 		kfree(mtk_gem->pages);
-		return -ENOMEM;
+		return NULL;
 	}
 out:
 	kfree(sgt);
diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 45682d30d705..4aec451d7251 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -1907,6 +1907,7 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
 		"SMBus I801 adapter at %04lx", priv->smba);
 	err = i2c_add_adapter(&priv->adapter);
 	if (err) {
+		platform_device_unregister(priv->tco_pdev);
 		i801_acpi_remove(priv);
 		return err;
 	}
diff --git a/drivers/i2c/busses/i2c-npcm7xx.c b/drivers/i2c/busses/i2c-npcm7xx.c
index c1b679737240..73c808ef1bfe 100644
--- a/drivers/i2c/busses/i2c-npcm7xx.c
+++ b/drivers/i2c/busses/i2c-npcm7xx.c
@@ -675,6 +675,7 @@ static void npcm_i2c_callback(struct npcm_i2c *bus,
 {
 	struct i2c_msg *msgs;
 	int msgs_num;
+	bool do_complete = false;
 
 	msgs = bus->msgs;
 	msgs_num = bus->msgs_num;
@@ -701,23 +702,17 @@ static void npcm_i2c_callback(struct npcm_i2c *bus,
 				 msgs[1].flags & I2C_M_RD)
 				msgs[1].len = info;
 		}
-		if (completion_done(&bus->cmd_complete) == false)
-			complete(&bus->cmd_complete);
-	break;
-
+		do_complete = true;
+		break;
 	case I2C_NACK_IND:
 		/* MASTER transmit got a NACK before tx all bytes */
 		bus->cmd_err = -ENXIO;
-		if (bus->master_or_slave == I2C_MASTER)
-			complete(&bus->cmd_complete);
-
+		do_complete = true;
 		break;
 	case I2C_BUS_ERR_IND:
 		/* Bus error */
 		bus->cmd_err = -EAGAIN;
-		if (bus->master_or_slave == I2C_MASTER)
-			complete(&bus->cmd_complete);
-
+		do_complete = true;
 		break;
 	case I2C_WAKE_UP_IND:
 		/* I2C wake up */
@@ -731,6 +726,8 @@ static void npcm_i2c_callback(struct npcm_i2c *bus,
 	if (bus->slave)
 		bus->master_or_slave = I2C_SLAVE;
 #endif
+	if (do_complete)
+		complete(&bus->cmd_complete);
 }
 
 static u8 npcm_i2c_fifo_usage(struct npcm_i2c *bus)
diff --git a/drivers/i2c/muxes/i2c-demux-pinctrl.c b/drivers/i2c/muxes/i2c-demux-pinctrl.c
index f7a7405d4350..8e8688e8de0f 100644
--- a/drivers/i2c/muxes/i2c-demux-pinctrl.c
+++ b/drivers/i2c/muxes/i2c-demux-pinctrl.c
@@ -243,6 +243,10 @@ static int i2c_demux_pinctrl_probe(struct platform_device *pdev)
 
 		props[i].name = devm_kstrdup(&pdev->dev, "status", GFP_KERNEL);
 		props[i].value = devm_kstrdup(&pdev->dev, "ok", GFP_KERNEL);
+		if (!props[i].name || !props[i].value) {
+			err = -ENOMEM;
+			goto err_rollback;
+		}
 		props[i].length = 3;
 
 		of_changeset_init(&priv->chan[i].chgset);
diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 805678f6fe57..0603d069de92 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -4723,7 +4723,7 @@ static int cma_iboe_join_multicast(struct rdma_id_private *id_priv,
 	int err = 0;
 	struct sockaddr *addr = (struct sockaddr *)&mc->addr;
 	struct net_device *ndev = NULL;
-	struct ib_sa_multicast ib;
+	struct ib_sa_multicast ib = {};
 	enum ib_gid_type gid_type;
 	bool send_only;
 
diff --git a/drivers/infiniband/core/cma_configfs.c b/drivers/infiniband/core/cma_configfs.c
index 35d1ec1095f9..d7cc8d5dcf35 100644
--- a/drivers/infiniband/core/cma_configfs.c
+++ b/drivers/infiniband/core/cma_configfs.c
@@ -221,7 +221,7 @@ static int make_cma_ports(struct cma_dev_group *cma_dev_group,
 	}
 
 	for (i = 0; i < ports_num; i++) {
-		char port_str[10];
+		char port_str[11];
 
 		ports[i].port_num = i + 1;
 		snprintf(port_str, sizeof(port_str), "%u", i + 1);
diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index f7f80707af4b..f8dfec7ad7cc 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -2148,6 +2148,7 @@ static const struct rdma_nl_cbs nldev_cb_table[RDMA_NLDEV_NUM_OPS] = {
 	},
 	[RDMA_NLDEV_CMD_SYS_SET] = {
 		.doit = nldev_set_sys_set_doit,
+		.flags = RDMA_NL_ADMIN_PERM,
 	},
 	[RDMA_NLDEV_CMD_STAT_SET] = {
 		.doit = nldev_stat_set_doit,
diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index 099f5acc749e..f2fcdb70d903 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -535,7 +535,7 @@ static ssize_t verify_hdr(struct ib_uverbs_cmd_hdr *hdr,
 	if (hdr->in_words * 4 != count)
 		return -EINVAL;
 
-	if (count < method_elm->req_size + sizeof(hdr)) {
+	if (count < method_elm->req_size + sizeof(*hdr)) {
 		/*
 		 * rdma-core v18 and v19 have a bug where they send DESTROY_CQ
 		 * with a 16 byte write instead of 24. Old kernels didn't
diff --git a/drivers/infiniband/hw/mlx4/sysfs.c b/drivers/infiniband/hw/mlx4/sysfs.c
index ea1f3a081b05..6c3a23ee3bc7 100644
--- a/drivers/infiniband/hw/mlx4/sysfs.c
+++ b/drivers/infiniband/hw/mlx4/sysfs.c
@@ -221,7 +221,7 @@ void del_sysfs_port_mcg_attr(struct mlx4_ib_dev *device, int port_num,
 static int add_port_entries(struct mlx4_ib_dev *device, int port_num)
 {
 	int i;
-	char buff[11];
+	char buff[12];
 	struct mlx4_ib_iov_port *port = NULL;
 	int ret = 0 ;
 	struct ib_port_attr attr;
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 215d6618839b..d36436d4277a 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -2069,7 +2069,7 @@ static inline char *mmap_cmd2str(enum mlx5_ib_mmap_cmd cmd)
 	case MLX5_IB_MMAP_DEVICE_MEM:
 		return "Device Memory";
 	default:
-		return NULL;
+		return "Unknown";
 	}
 }
 
diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index de5ab282ac74..df5f675993c7 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -973,6 +973,7 @@ static void siw_accept_newconn(struct siw_cep *cep)
 			siw_cep_put(cep);
 			new_cep->listen_cep = NULL;
 			if (rv) {
+				siw_cancel_mpatimer(new_cep);
 				siw_cep_set_free(new_cep);
 				goto error;
 			}
@@ -1097,9 +1098,12 @@ static void siw_cm_work_handler(struct work_struct *w)
 				/*
 				 * Socket close before MPA request received.
 				 */
-				siw_dbg_cep(cep, "no mpareq: drop listener\n");
-				siw_cep_put(cep->listen_cep);
-				cep->listen_cep = NULL;
+				if (cep->listen_cep) {
+					siw_dbg_cep(cep,
+						"no mpareq: drop listener\n");
+					siw_cep_put(cep->listen_cep);
+					cep->listen_cep = NULL;
+				}
 			}
 		}
 		release_cep = 1;
@@ -1222,7 +1226,11 @@ static void siw_cm_llp_data_ready(struct sock *sk)
 	if (!cep)
 		goto out;
 
-	siw_dbg_cep(cep, "state: %d\n", cep->state);
+	siw_dbg_cep(cep, "cep state: %d, socket state %d\n",
+		    cep->state, sk->sk_state);
+
+	if (sk->sk_state != TCP_ESTABLISHED)
+		goto out;
 
 	switch (cep->state) {
 	case SIW_EPSTATE_RDMA_MODE:
diff --git a/drivers/input/serio/i8042-acpipnpio.h b/drivers/input/serio/i8042-acpipnpio.h
new file mode 100644
index 000000000000..1bd5898abb97
--- /dev/null
+++ b/drivers/input/serio/i8042-acpipnpio.h
@@ -0,0 +1,1597 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _I8042_ACPIPNPIO_H
+#define _I8042_ACPIPNPIO_H
+
+
+#ifdef CONFIG_X86
+#include <asm/x86_init.h>
+#endif
+
+/*
+ * Names.
+ */
+
+#define I8042_KBD_PHYS_DESC "isa0060/serio0"
+#define I8042_AUX_PHYS_DESC "isa0060/serio1"
+#define I8042_MUX_PHYS_DESC "isa0060/serio%d"
+
+/*
+ * IRQs.
+ */
+
+#if defined(__ia64__)
+# define I8042_MAP_IRQ(x)	isa_irq_to_vector((x))
+#else
+# define I8042_MAP_IRQ(x)	(x)
+#endif
+
+#define I8042_KBD_IRQ	i8042_kbd_irq
+#define I8042_AUX_IRQ	i8042_aux_irq
+
+static int i8042_kbd_irq;
+static int i8042_aux_irq;
+
+/*
+ * Register numbers.
+ */
+
+#define I8042_COMMAND_REG	i8042_command_reg
+#define I8042_STATUS_REG	i8042_command_reg
+#define I8042_DATA_REG		i8042_data_reg
+
+static int i8042_command_reg = 0x64;
+static int i8042_data_reg = 0x60;
+
+
+static inline int i8042_read_data(void)
+{
+	return inb(I8042_DATA_REG);
+}
+
+static inline int i8042_read_status(void)
+{
+	return inb(I8042_STATUS_REG);
+}
+
+static inline void i8042_write_data(int val)
+{
+	outb(val, I8042_DATA_REG);
+}
+
+static inline void i8042_write_command(int val)
+{
+	outb(val, I8042_COMMAND_REG);
+}
+
+#ifdef CONFIG_X86
+
+#include <linux/dmi.h>
+
+#define SERIO_QUIRK_NOKBD		BIT(0)
+#define SERIO_QUIRK_NOAUX		BIT(1)
+#define SERIO_QUIRK_NOMUX		BIT(2)
+#define SERIO_QUIRK_FORCEMUX		BIT(3)
+#define SERIO_QUIRK_UNLOCK		BIT(4)
+#define SERIO_QUIRK_PROBE_DEFER		BIT(5)
+#define SERIO_QUIRK_RESET_ALWAYS	BIT(6)
+#define SERIO_QUIRK_RESET_NEVER		BIT(7)
+#define SERIO_QUIRK_DIECT		BIT(8)
+#define SERIO_QUIRK_DUMBKBD		BIT(9)
+#define SERIO_QUIRK_NOLOOP		BIT(10)
+#define SERIO_QUIRK_NOTIMEOUT		BIT(11)
+#define SERIO_QUIRK_KBDRESET		BIT(12)
+#define SERIO_QUIRK_DRITEK		BIT(13)
+#define SERIO_QUIRK_NOPNP		BIT(14)
+
+/* Quirk table for different mainboards. Options similar or identical to i8042
+ * module parameters.
+ * ORDERING IS IMPORTANT! The first match will be apllied and the rest ignored.
+ * This allows entries to overwrite vendor wide quirks on a per device basis.
+ * Where this is irrelevant, entries are sorted case sensitive by DMI_SYS_VENDOR
+ * and/or DMI_BOARD_VENDOR to make it easier to avoid dublicate entries.
+ */
+static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ALIENWARE"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Sentia"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "X750LN"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
+	},
+	{
+		/* Asus X450LCP */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "X450LCP"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_NEVER)
+	},
+	{
+		/* ASUS ZenBook UX425UA */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ZenBook UX425UA"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_PROBE_DEFER | SERIO_QUIRK_RESET_NEVER)
+	},
+	{
+		/* ASUS ZenBook UM325UA */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ZenBook UX325UA_UM325UA"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_PROBE_DEFER | SERIO_QUIRK_RESET_NEVER)
+	},
+	/*
+	 * On some Asus laptops, just running self tests cause problems.
+	 */
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_CHASSIS_TYPE, "10"), /* Notebook */
+		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_NEVER)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_CHASSIS_TYPE, "31"), /* Convertible Notebook */
+		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_NEVER)
+	},
+	{
+		/* ASUS P65UP5 - AUX LOOP command does not raise AUX IRQ */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "P/I-P65UP5"),
+			DMI_MATCH(DMI_BOARD_VERSION, "REV 2.X"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
+	},
+	{
+		/* ASUS G1S */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer Inc."),
+			DMI_MATCH(DMI_BOARD_NAME, "G1S"),
+			DMI_MATCH(DMI_BOARD_VERSION, "1.0"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 1360"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		/* Acer Aspire 5710 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5710"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		/* Acer Aspire 7738 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 7738"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		/* Acer Aspire 5536 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5536"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "0100"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		/*
+		 * Acer Aspire 5738z
+		 * Touchpad stops working in mux mode when dis- + re-enabled
+		 * with the touchpad enable/disable toggle hotkey
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5738"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		/* Acer Aspire One 150 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "AOA150"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire A114-31"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire A314-31"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire A315-31"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire ES1-132"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire ES1-332"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire ES1-432"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate Spin B118-RN"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
+	},
+	/*
+	 * Some Wistron based laptops need us to explicitly enable the 'Dritek
+	 * keyboard extension' to make their extra keys start generating scancodes.
+	 * Originally, this was just confined to older laptops, but a few Acer laptops
+	 * have turned up in 2007 that also need this again.
+	 */
+	{
+		/* Acer Aspire 5100 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5100"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_DRITEK)
+	},
+	{
+		/* Acer Aspire 5610 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5610"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_DRITEK)
+	},
+	{
+		/* Acer Aspire 5630 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5630"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_DRITEK)
+	},
+	{
+		/* Acer Aspire 5650 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5650"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_DRITEK)
+	},
+	{
+		/* Acer Aspire 5680 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5680"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_DRITEK)
+	},
+	{
+		/* Acer Aspire 5720 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5720"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_DRITEK)
+	},
+	{
+		/* Acer Aspire 9110 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 9110"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_DRITEK)
+	},
+	{
+		/* Acer TravelMate 660 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 660"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_DRITEK)
+	},
+	{
+		/* Acer TravelMate 2490 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 2490"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_DRITEK)
+	},
+	{
+		/* Acer TravelMate 4280 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 4280"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_DRITEK)
+	},
+	{
+		/* Amoi M636/A737 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Amoi Electronics CO.,LTD."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "M636/A737 platform"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ByteSpeed LLC"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ByteSpeed Laptop C15B"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
+	},
+	{
+		/* Compal HEL80I */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "COMPAL"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HEL80I"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Compaq"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ProLiant"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "8500"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Compaq"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ProLiant"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "DL760"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
+	},
+	{
+		/* Advent 4211 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "DIXONSXP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Advent 4211"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
+	},
+	{
+		/* Dell Embedded Box PC 3000 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Embedded Box PC 3000"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
+	},
+	{
+		/* Dell XPS M1530 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "XPS M1530"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		/* Dell Vostro 1510 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Vostro1510"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		/* Dell Vostro V13 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Vostro V13"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_NOTIMEOUT)
+	},
+	{
+		/* Dell Vostro 1320 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 1320"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
+	},
+	{
+		/* Dell Vostro 1520 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 1520"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
+	},
+	{
+		/* Dell Vostro 1720 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 1720"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
+	},
+	{
+		/* Entroware Proteus */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Entroware"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Proteus"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "EL07R4"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS)
+	},
+	/*
+	 * Some Fujitsu notebooks are having trouble with touchpads if
+	 * active multiplexing mode is activated. Luckily they don't have
+	 * external PS/2 ports so we can safely disable it.
+	 * ... apparently some Toshibas don't like MUX mode either and
+	 * die horrible death on reboot.
+	 */
+	{
+		/* Fujitsu Lifebook P7010/P7010D */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "P7010"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		/* Fujitsu Lifebook P5020D */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "LifeBook P Series"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		/* Fujitsu Lifebook S2000 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "LifeBook S Series"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		/* Fujitsu Lifebook S6230 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "LifeBook S6230"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		/* Fujitsu Lifebook T725 laptop */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK T725"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_NOTIMEOUT)
+	},
+	{
+		/* Fujitsu Lifebook U745 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK U745"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		/* Fujitsu T70H */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "FMVLT70H"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		/* Fujitsu A544 laptop */
+		/* https://bugzilla.redhat.com/show_bug.cgi?id=1111138 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK A544"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOTIMEOUT)
+	},
+	{
+		/* Fujitsu AH544 laptop */
+		/* https://bugzilla.kernel.org/show_bug.cgi?id=69731 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK AH544"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOTIMEOUT)
+	},
+	{
+		/* Fujitsu U574 laptop */
+		/* https://bugzilla.kernel.org/show_bug.cgi?id=69731 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK U574"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOTIMEOUT)
+	},
+	{
+		/* Fujitsu UH554 laptop */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK UH544"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOTIMEOUT)
+	},
+	{
+		/* Fujitsu Lifebook P7010 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "0000000000"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		/* Fujitsu-Siemens Lifebook T3010 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK T3010"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		/* Fujitsu-Siemens Lifebook E4010 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK E4010"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		/* Fujitsu-Siemens Amilo Pro 2010 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "AMILO Pro V2010"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		/* Fujitsu-Siemens Amilo Pro 2030 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "AMILO PRO V2030"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		/* Fujitsu Lifebook A574/H */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "FMVA0501PZ"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		/* Gigabyte M912 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "GIGABYTE"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "M912"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "01"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
+	},
+	{
+		/* Gigabyte Spring Peak - defines wrong chassis type */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "GIGABYTE"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Spring Peak"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
+	},
+	{
+		/* Gigabyte T1005 - defines wrong chassis type ("Other") */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "GIGABYTE"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "T1005"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
+	},
+	{
+		/* Gigabyte T1005M/P - defines wrong chassis type ("Other") */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "GIGABYTE"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "T1005M/P"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
+	},
+	/*
+	 * Some laptops need keyboard reset before probing for the trackpad to get
+	 * it detected, initialised & finally work.
+	 */
+	{
+		/* Gigabyte P35 v2 - Elantech touchpad */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "GIGABYTE"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "P35V2"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_KBDRESET)
+	},
+		{
+		/* Aorus branded Gigabyte X3 Plus - Elantech touchpad */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "GIGABYTE"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "X3"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_KBDRESET)
+	},
+	{
+		/* Gigabyte P34 - Elantech touchpad */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "GIGABYTE"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "P34"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_KBDRESET)
+	},
+	{
+		/* Gigabyte P57 - Elantech touchpad */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "GIGABYTE"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "P57"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_KBDRESET)
+	},
+	{
+		/* Gericom Bellagio */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Gericom"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "N34AS6"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		/* Gigabyte M1022M netbook */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Gigabyte Technology Co.,Ltd."),
+			DMI_MATCH(DMI_BOARD_NAME, "M1022E"),
+			DMI_MATCH(DMI_BOARD_VERSION, "1.02"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion dv9700"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "Rev 1"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
+	},
+	{
+		/*
+		 * HP Pavilion DV4017EA -
+		 * errors on MUX ports are reported without raising AUXDATA
+		 * causing "spurious NAK" messages.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Pavilion dv4000 (EA032EA#ABF)"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		/*
+		 * HP Pavilion ZT1000 -
+		 * like DV4017EA does not raise AUXERR for errors on MUX ports.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion Notebook PC"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "HP Pavilion Notebook ZT1000"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		/*
+		 * HP Pavilion DV4270ca -
+		 * like DV4017EA does not raise AUXERR for errors on MUX ports.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Pavilion dv4000 (EH476UA#ABL)"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		/* Newer HP Pavilion dv4 models */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion dv4 Notebook PC"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_NOTIMEOUT)
+	},
+	{
+		/* IBM 2656 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "IBM"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "2656"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		/* Avatar AVIU-145A6 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Intel"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "IC4I"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		/* Intel MBO Desktop D845PESV */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Intel Corporation"),
+			DMI_MATCH(DMI_BOARD_NAME, "D845PESV"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOPNP)
+	},
+	{
+		/*
+		 * Intel NUC D54250WYK - does not have i8042 controller but
+		 * declares PS/2 devices in DSDT.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Intel Corporation"),
+			DMI_MATCH(DMI_BOARD_NAME, "D54250WYK"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOPNP)
+	},
+	{
+		/* Lenovo 3000 n100 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "076804U"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		/* Lenovo XiaoXin Air 12 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "80UN"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		/* Lenovo LaVie Z */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo LaVie Z"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		/* Lenovo Ideapad U455 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "20046"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
+	},
+	{
+		/* Lenovo ThinkPad L460 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad L460"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
+	},
+	{
+		/* Lenovo ThinkPad Twist S230u */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "33474HU"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
+	},
+	{
+		/* LG Electronics X110 */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LG Electronics Inc."),
+			DMI_MATCH(DMI_BOARD_NAME, "X110"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
+	},
+	{
+		/* Medion Akoya Mini E1210 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "MEDION"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "E1210"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
+	},
+	{
+		/* Medion Akoya E1222 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "MEDION"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "E122X"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
+	},
+	{
+		/* MSI Wind U-100 */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "MICRO-STAR INTERNATIONAL CO., LTD"),
+			DMI_MATCH(DMI_BOARD_NAME, "U-100"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS | SERIO_QUIRK_NOPNP)
+	},
+	{
+		/*
+		 * No data is coming from the touchscreen unless KBC
+		 * is in legacy mode.
+		 */
+		/* Panasonic CF-29 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Matsushita"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "CF-29"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		/* Medion Akoya E7225 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Medion"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Akoya E7225"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "1.0"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
+	},
+	{
+		/* Microsoft Virtual Machine */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Microsoft Corporation"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Virtual Machine"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "VS2005R2"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
+	},
+	{
+		/* Medion MAM 2070 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "MAM 2070"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "5a"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
+	},
+	{
+		/* TUXEDO BU1406 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "N24_25BU"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		/* Clevo P650RS, 650RP6, Sager NP8152-S, and others */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "P65xRP"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
+	},
+	{
+		/* OQO Model 01 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "OQO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ZEPTO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "00"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "PEGATRON CORPORATION"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "C15B"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
+	},
+	{
+		/* Acer Aspire 5 A515 */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "PK"),
+			DMI_MATCH(DMI_BOARD_NAME, "Grumpy_PK"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOPNP)
+	},
+	{
+		/* ULI EV4873 - AUX LOOP does not work properly */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ULI"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "EV4873"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "5a"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
+	},
+	{
+		/*
+		 * Arima-Rioworks HDAMB -
+		 * AUX LOOP command does not raise AUX IRQ
+		 */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "RIOWORKS"),
+			DMI_MATCH(DMI_BOARD_NAME, "HDAMB"),
+			DMI_MATCH(DMI_BOARD_VERSION, "Rev E"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
+	},
+	{
+		/* Sharp Actius MM20 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "SHARP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "PC-MM20 Series"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		/*
+		 * Sony Vaio FZ-240E -
+		 * reset and GET ID commands issued via KBD port are
+		 * sometimes being delivered to AUX3.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "VGN-FZ240E"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		/*
+		 * Most (all?) VAIOs do not have external PS/2 ports nor
+		 * they implement active multiplexing properly, and
+		 * MUX discovery usually messes up keyboard/touchpad.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
+			DMI_MATCH(DMI_BOARD_NAME, "VAIO"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		/* Sony Vaio FS-115b */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "VGN-FS115B"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		/*
+		 * Sony Vaio VGN-CS series require MUX or the touch sensor
+		 * buttons will disturb touchpad operation
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "VGN-CS"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_FORCEMUX)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Satellite P10"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "EQUIUM A110"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "SATELLITE C850D"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	/*
+	 * A lot of modern Clevo barebones have touchpad and/or keyboard issues
+	 * after suspend fixable with nomux + reset + noloop + nopnp. Luckily,
+	 * none of them have an external PS/2 port so this can safely be set for
+	 * all of them. These two are based on a Clevo design, but have the
+	 * board_name changed.
+	 */
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
+			DMI_MATCH(DMI_BOARD_NAME, "AURA1501"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
+					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
+			DMI_MATCH(DMI_BOARD_NAME, "EDUBOOK1502"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
+					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+	},
+	{
+		/* Mivvy M310 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "VIOOO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "N10"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
+	},
+	/*
+	 * Some laptops need keyboard reset before probing for the trackpad to get
+	 * it detected, initialised & finally work.
+	 */
+	{
+		/* Schenker XMG C504 - Elantech touchpad */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "XMG"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "C504"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_KBDRESET)
+	},
+	{
+		/* Blue FB5601 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "blue"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "FB5601"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "M606"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
+	},
+	/*
+	 * A lot of modern Clevo barebones have touchpad and/or keyboard issues
+	 * after suspend fixable with nomux + reset + noloop + nopnp. Luckily,
+	 * none of them have an external PS/2 port so this can safely be set for
+	 * all of them.
+	 * Clevo barebones come with board_vendor and/or system_vendor set to
+	 * either the very generic string "Notebook" and/or a different value
+	 * for each individual reseller. The only somewhat universal way to
+	 * identify them is by board_name.
+	 */
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71A"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
+					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71B"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
+					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "N140CU"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
+					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "N141CU"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
+					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "NH5xAx"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
+					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
+					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+	},
+	/*
+	 * At least one modern Clevo barebone has the touchpad connected both
+	 * via PS/2 and i2c interface. This causes a race condition between the
+	 * psmouse and i2c-hid driver. Since the full capability of the touchpad
+	 * is available via the i2c interface and the device has no external
+	 * PS/2 port, it is safe to just ignore all ps2 mouses here to avoid
+	 * this issue. The known affected device is the
+	 * TUXEDO InfinityBook S17 Gen6 / Clevo NS70MU which comes with one of
+	 * the two different dmi strings below. NS50MU is not a typo!
+	 */
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "NS50MU"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOAUX | SERIO_QUIRK_NOMUX |
+					SERIO_QUIRK_RESET_ALWAYS | SERIO_QUIRK_NOLOOP |
+					SERIO_QUIRK_NOPNP)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "NS50_70MU"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOAUX | SERIO_QUIRK_NOMUX |
+					SERIO_QUIRK_RESET_ALWAYS | SERIO_QUIRK_NOLOOP |
+					SERIO_QUIRK_NOPNP)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "NJ50_70CU"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
+					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "PB50_70DFx,DDx"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
+					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "PCX0DX"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
+					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+	},
+	/* See comment on TUXEDO InfinityBook S17 Gen6 / Clevo NS70MU above */
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "PD5x_7xPNP_PNR_PNN_PNT"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOAUX)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "X170SM"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
+					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "X170KM-G"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
+					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+	},
+	{ }
+};
+
+#ifdef CONFIG_PNP
+static const struct dmi_system_id i8042_dmi_laptop_table[] __initconst = {
+	{
+		.matches = {
+			DMI_MATCH(DMI_CHASSIS_TYPE, "8"), /* Portable */
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_CHASSIS_TYPE, "9"), /* Laptop */
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_CHASSIS_TYPE, "10"), /* Notebook */
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_CHASSIS_TYPE, "14"), /* Sub-Notebook */
+		},
+	},
+	{ }
+};
+#endif
+
+#endif /* CONFIG_X86 */
+
+#ifdef CONFIG_PNP
+#include <linux/pnp.h>
+
+static bool i8042_pnp_kbd_registered;
+static unsigned int i8042_pnp_kbd_devices;
+static bool i8042_pnp_aux_registered;
+static unsigned int i8042_pnp_aux_devices;
+
+static int i8042_pnp_command_reg;
+static int i8042_pnp_data_reg;
+static int i8042_pnp_kbd_irq;
+static int i8042_pnp_aux_irq;
+
+static char i8042_pnp_kbd_name[32];
+static char i8042_pnp_aux_name[32];
+
+static void i8042_pnp_id_to_string(struct pnp_id *id, char *dst, int dst_size)
+{
+	strlcpy(dst, "PNP:", dst_size);
+
+	while (id) {
+		strlcat(dst, " ", dst_size);
+		strlcat(dst, id->id, dst_size);
+		id = id->next;
+	}
+}
+
+static int i8042_pnp_kbd_probe(struct pnp_dev *dev, const struct pnp_device_id *did)
+{
+	if (pnp_port_valid(dev, 0) && pnp_port_len(dev, 0) == 1)
+		i8042_pnp_data_reg = pnp_port_start(dev,0);
+
+	if (pnp_port_valid(dev, 1) && pnp_port_len(dev, 1) == 1)
+		i8042_pnp_command_reg = pnp_port_start(dev, 1);
+
+	if (pnp_irq_valid(dev,0))
+		i8042_pnp_kbd_irq = pnp_irq(dev, 0);
+
+	strlcpy(i8042_pnp_kbd_name, did->id, sizeof(i8042_pnp_kbd_name));
+	if (strlen(pnp_dev_name(dev))) {
+		strlcat(i8042_pnp_kbd_name, ":", sizeof(i8042_pnp_kbd_name));
+		strlcat(i8042_pnp_kbd_name, pnp_dev_name(dev), sizeof(i8042_pnp_kbd_name));
+	}
+	i8042_pnp_id_to_string(dev->id, i8042_kbd_firmware_id,
+			       sizeof(i8042_kbd_firmware_id));
+	i8042_kbd_fwnode = dev_fwnode(&dev->dev);
+
+	/* Keyboard ports are always supposed to be wakeup-enabled */
+	device_set_wakeup_enable(&dev->dev, true);
+
+	i8042_pnp_kbd_devices++;
+	return 0;
+}
+
+static int i8042_pnp_aux_probe(struct pnp_dev *dev, const struct pnp_device_id *did)
+{
+	if (pnp_port_valid(dev, 0) && pnp_port_len(dev, 0) == 1)
+		i8042_pnp_data_reg = pnp_port_start(dev,0);
+
+	if (pnp_port_valid(dev, 1) && pnp_port_len(dev, 1) == 1)
+		i8042_pnp_command_reg = pnp_port_start(dev, 1);
+
+	if (pnp_irq_valid(dev, 0))
+		i8042_pnp_aux_irq = pnp_irq(dev, 0);
+
+	strlcpy(i8042_pnp_aux_name, did->id, sizeof(i8042_pnp_aux_name));
+	if (strlen(pnp_dev_name(dev))) {
+		strlcat(i8042_pnp_aux_name, ":", sizeof(i8042_pnp_aux_name));
+		strlcat(i8042_pnp_aux_name, pnp_dev_name(dev), sizeof(i8042_pnp_aux_name));
+	}
+	i8042_pnp_id_to_string(dev->id, i8042_aux_firmware_id,
+			       sizeof(i8042_aux_firmware_id));
+
+	i8042_pnp_aux_devices++;
+	return 0;
+}
+
+static const struct pnp_device_id pnp_kbd_devids[] = {
+	{ .id = "PNP0300", .driver_data = 0 },
+	{ .id = "PNP0301", .driver_data = 0 },
+	{ .id = "PNP0302", .driver_data = 0 },
+	{ .id = "PNP0303", .driver_data = 0 },
+	{ .id = "PNP0304", .driver_data = 0 },
+	{ .id = "PNP0305", .driver_data = 0 },
+	{ .id = "PNP0306", .driver_data = 0 },
+	{ .id = "PNP0309", .driver_data = 0 },
+	{ .id = "PNP030a", .driver_data = 0 },
+	{ .id = "PNP030b", .driver_data = 0 },
+	{ .id = "PNP0320", .driver_data = 0 },
+	{ .id = "PNP0343", .driver_data = 0 },
+	{ .id = "PNP0344", .driver_data = 0 },
+	{ .id = "PNP0345", .driver_data = 0 },
+	{ .id = "CPQA0D7", .driver_data = 0 },
+	{ .id = "", },
+};
+MODULE_DEVICE_TABLE(pnp, pnp_kbd_devids);
+
+static struct pnp_driver i8042_pnp_kbd_driver = {
+	.name           = "i8042 kbd",
+	.id_table       = pnp_kbd_devids,
+	.probe          = i8042_pnp_kbd_probe,
+	.driver         = {
+		.probe_type = PROBE_FORCE_SYNCHRONOUS,
+		.suppress_bind_attrs = true,
+	},
+};
+
+static const struct pnp_device_id pnp_aux_devids[] = {
+	{ .id = "AUI0200", .driver_data = 0 },
+	{ .id = "FJC6000", .driver_data = 0 },
+	{ .id = "FJC6001", .driver_data = 0 },
+	{ .id = "PNP0f03", .driver_data = 0 },
+	{ .id = "PNP0f0b", .driver_data = 0 },
+	{ .id = "PNP0f0e", .driver_data = 0 },
+	{ .id = "PNP0f12", .driver_data = 0 },
+	{ .id = "PNP0f13", .driver_data = 0 },
+	{ .id = "PNP0f19", .driver_data = 0 },
+	{ .id = "PNP0f1c", .driver_data = 0 },
+	{ .id = "SYN0801", .driver_data = 0 },
+	{ .id = "", },
+};
+MODULE_DEVICE_TABLE(pnp, pnp_aux_devids);
+
+static struct pnp_driver i8042_pnp_aux_driver = {
+	.name           = "i8042 aux",
+	.id_table       = pnp_aux_devids,
+	.probe          = i8042_pnp_aux_probe,
+	.driver         = {
+		.probe_type = PROBE_FORCE_SYNCHRONOUS,
+		.suppress_bind_attrs = true,
+	},
+};
+
+static void i8042_pnp_exit(void)
+{
+	if (i8042_pnp_kbd_registered) {
+		i8042_pnp_kbd_registered = false;
+		pnp_unregister_driver(&i8042_pnp_kbd_driver);
+	}
+
+	if (i8042_pnp_aux_registered) {
+		i8042_pnp_aux_registered = false;
+		pnp_unregister_driver(&i8042_pnp_aux_driver);
+	}
+}
+
+static int __init i8042_pnp_init(void)
+{
+	char kbd_irq_str[4] = { 0 }, aux_irq_str[4] = { 0 };
+	bool pnp_data_busted = false;
+	int err;
+
+	if (i8042_nopnp) {
+		pr_info("PNP detection disabled\n");
+		return 0;
+	}
+
+	err = pnp_register_driver(&i8042_pnp_kbd_driver);
+	if (!err)
+		i8042_pnp_kbd_registered = true;
+
+	err = pnp_register_driver(&i8042_pnp_aux_driver);
+	if (!err)
+		i8042_pnp_aux_registered = true;
+
+	if (!i8042_pnp_kbd_devices && !i8042_pnp_aux_devices) {
+		i8042_pnp_exit();
+#if defined(__ia64__)
+		return -ENODEV;
+#else
+		pr_info("PNP: No PS/2 controller found.\n");
+		if (x86_platform.legacy.i8042 !=
+				X86_LEGACY_I8042_EXPECTED_PRESENT)
+			return -ENODEV;
+		pr_info("Probing ports directly.\n");
+		return 0;
+#endif
+	}
+
+	if (i8042_pnp_kbd_devices)
+		snprintf(kbd_irq_str, sizeof(kbd_irq_str),
+			"%d", i8042_pnp_kbd_irq);
+	if (i8042_pnp_aux_devices)
+		snprintf(aux_irq_str, sizeof(aux_irq_str),
+			"%d", i8042_pnp_aux_irq);
+
+	pr_info("PNP: PS/2 Controller [%s%s%s] at %#x,%#x irq %s%s%s\n",
+		i8042_pnp_kbd_name, (i8042_pnp_kbd_devices && i8042_pnp_aux_devices) ? "," : "",
+		i8042_pnp_aux_name,
+		i8042_pnp_data_reg, i8042_pnp_command_reg,
+		kbd_irq_str, (i8042_pnp_kbd_devices && i8042_pnp_aux_devices) ? "," : "",
+		aux_irq_str);
+
+#if defined(__ia64__)
+	if (!i8042_pnp_kbd_devices)
+		i8042_nokbd = true;
+	if (!i8042_pnp_aux_devices)
+		i8042_noaux = true;
+#endif
+
+	if (((i8042_pnp_data_reg & ~0xf) == (i8042_data_reg & ~0xf) &&
+	      i8042_pnp_data_reg != i8042_data_reg) ||
+	    !i8042_pnp_data_reg) {
+		pr_warn("PNP: PS/2 controller has invalid data port %#x; using default %#x\n",
+			i8042_pnp_data_reg, i8042_data_reg);
+		i8042_pnp_data_reg = i8042_data_reg;
+		pnp_data_busted = true;
+	}
+
+	if (((i8042_pnp_command_reg & ~0xf) == (i8042_command_reg & ~0xf) &&
+	      i8042_pnp_command_reg != i8042_command_reg) ||
+	    !i8042_pnp_command_reg) {
+		pr_warn("PNP: PS/2 controller has invalid command port %#x; using default %#x\n",
+			i8042_pnp_command_reg, i8042_command_reg);
+		i8042_pnp_command_reg = i8042_command_reg;
+		pnp_data_busted = true;
+	}
+
+	if (!i8042_nokbd && !i8042_pnp_kbd_irq) {
+		pr_warn("PNP: PS/2 controller doesn't have KBD irq; using default %d\n",
+			i8042_kbd_irq);
+		i8042_pnp_kbd_irq = i8042_kbd_irq;
+		pnp_data_busted = true;
+	}
+
+	if (!i8042_noaux && !i8042_pnp_aux_irq) {
+		if (!pnp_data_busted && i8042_pnp_kbd_irq) {
+			pr_warn("PNP: PS/2 appears to have AUX port disabled, "
+				"if this is incorrect please boot with i8042.nopnp\n");
+			i8042_noaux = true;
+		} else {
+			pr_warn("PNP: PS/2 controller doesn't have AUX irq; using default %d\n",
+				i8042_aux_irq);
+			i8042_pnp_aux_irq = i8042_aux_irq;
+		}
+	}
+
+	i8042_data_reg = i8042_pnp_data_reg;
+	i8042_command_reg = i8042_pnp_command_reg;
+	i8042_kbd_irq = i8042_pnp_kbd_irq;
+	i8042_aux_irq = i8042_pnp_aux_irq;
+
+#ifdef CONFIG_X86
+	i8042_bypass_aux_irq_test = !pnp_data_busted &&
+				    dmi_check_system(i8042_dmi_laptop_table);
+#endif
+
+	return 0;
+}
+
+#else  /* !CONFIG_PNP */
+static inline int i8042_pnp_init(void) { return 0; }
+static inline void i8042_pnp_exit(void) { }
+#endif /* CONFIG_PNP */
+
+
+#ifdef CONFIG_X86
+static void __init i8042_check_quirks(void)
+{
+	const struct dmi_system_id *device_quirk_info;
+	uintptr_t quirks;
+
+	device_quirk_info = dmi_first_match(i8042_dmi_quirk_table);
+	if (!device_quirk_info)
+		return;
+
+	quirks = (uintptr_t)device_quirk_info->driver_data;
+
+	if (quirks & SERIO_QUIRK_NOKBD)
+		i8042_nokbd = true;
+	if (quirks & SERIO_QUIRK_NOAUX)
+		i8042_noaux = true;
+	if (quirks & SERIO_QUIRK_NOMUX)
+		i8042_nomux = true;
+	if (quirks & SERIO_QUIRK_FORCEMUX)
+		i8042_nomux = false;
+	if (quirks & SERIO_QUIRK_UNLOCK)
+		i8042_unlock = true;
+	if (quirks & SERIO_QUIRK_PROBE_DEFER)
+		i8042_probe_defer = true;
+	/* Honor module parameter when value is not default */
+	if (i8042_reset == I8042_RESET_DEFAULT) {
+		if (quirks & SERIO_QUIRK_RESET_ALWAYS)
+			i8042_reset = I8042_RESET_ALWAYS;
+		if (quirks & SERIO_QUIRK_RESET_NEVER)
+			i8042_reset = I8042_RESET_NEVER;
+	}
+	if (quirks & SERIO_QUIRK_DIECT)
+		i8042_direct = true;
+	if (quirks & SERIO_QUIRK_DUMBKBD)
+		i8042_dumbkbd = true;
+	if (quirks & SERIO_QUIRK_NOLOOP)
+		i8042_noloop = true;
+	if (quirks & SERIO_QUIRK_NOTIMEOUT)
+		i8042_notimeout = true;
+	if (quirks & SERIO_QUIRK_KBDRESET)
+		i8042_kbdreset = true;
+	if (quirks & SERIO_QUIRK_DRITEK)
+		i8042_dritek = true;
+#ifdef CONFIG_PNP
+	if (quirks & SERIO_QUIRK_NOPNP)
+		i8042_nopnp = true;
+#endif
+}
+#else
+static inline void i8042_check_quirks(void) {}
+#endif
+
+static int __init i8042_platform_init(void)
+{
+	int retval;
+
+#ifdef CONFIG_X86
+	u8 a20_on = 0xdf;
+	/* Just return if platform does not have i8042 controller */
+	if (x86_platform.legacy.i8042 == X86_LEGACY_I8042_PLATFORM_ABSENT)
+		return -ENODEV;
+#endif
+
+/*
+ * On ix86 platforms touching the i8042 data register region can do really
+ * bad things. Because of this the region is always reserved on ix86 boxes.
+ *
+ *	if (!request_region(I8042_DATA_REG, 16, "i8042"))
+ *		return -EBUSY;
+ */
+
+	i8042_kbd_irq = I8042_MAP_IRQ(1);
+	i8042_aux_irq = I8042_MAP_IRQ(12);
+
+#if defined(__ia64__)
+	i8042_reset = I8042_RESET_ALWAYS;
+#endif
+
+	i8042_check_quirks();
+
+	retval = i8042_pnp_init();
+	if (retval)
+		return retval;
+
+#ifdef CONFIG_X86
+	/*
+	 * A20 was already enabled during early kernel init. But some buggy
+	 * BIOSes (in MSI Laptops) require A20 to be enabled using 8042 to
+	 * resume from S3. So we do it here and hope that nothing breaks.
+	 */
+	i8042_command(&a20_on, 0x10d1);
+	i8042_command(NULL, 0x00ff);	/* Null command for SMM firmware */
+#endif /* CONFIG_X86 */
+
+	return retval;
+}
+
+static inline void i8042_platform_exit(void)
+{
+	i8042_pnp_exit();
+}
+
+#endif /* _I8042_ACPIPNPIO_H */
diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
deleted file mode 100644
index 9dcdf21c50bd..000000000000
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ /dev/null
@@ -1,1590 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-#ifndef _I8042_X86IA64IO_H
-#define _I8042_X86IA64IO_H
-
-
-#ifdef CONFIG_X86
-#include <asm/x86_init.h>
-#endif
-
-/*
- * Names.
- */
-
-#define I8042_KBD_PHYS_DESC "isa0060/serio0"
-#define I8042_AUX_PHYS_DESC "isa0060/serio1"
-#define I8042_MUX_PHYS_DESC "isa0060/serio%d"
-
-/*
- * IRQs.
- */
-
-#if defined(__ia64__)
-# define I8042_MAP_IRQ(x)	isa_irq_to_vector((x))
-#else
-# define I8042_MAP_IRQ(x)	(x)
-#endif
-
-#define I8042_KBD_IRQ	i8042_kbd_irq
-#define I8042_AUX_IRQ	i8042_aux_irq
-
-static int i8042_kbd_irq;
-static int i8042_aux_irq;
-
-/*
- * Register numbers.
- */
-
-#define I8042_COMMAND_REG	i8042_command_reg
-#define I8042_STATUS_REG	i8042_command_reg
-#define I8042_DATA_REG		i8042_data_reg
-
-static int i8042_command_reg = 0x64;
-static int i8042_data_reg = 0x60;
-
-
-static inline int i8042_read_data(void)
-{
-	return inb(I8042_DATA_REG);
-}
-
-static inline int i8042_read_status(void)
-{
-	return inb(I8042_STATUS_REG);
-}
-
-static inline void i8042_write_data(int val)
-{
-	outb(val, I8042_DATA_REG);
-}
-
-static inline void i8042_write_command(int val)
-{
-	outb(val, I8042_COMMAND_REG);
-}
-
-#ifdef CONFIG_X86
-
-#include <linux/dmi.h>
-
-#define SERIO_QUIRK_NOKBD		BIT(0)
-#define SERIO_QUIRK_NOAUX		BIT(1)
-#define SERIO_QUIRK_NOMUX		BIT(2)
-#define SERIO_QUIRK_FORCEMUX		BIT(3)
-#define SERIO_QUIRK_UNLOCK		BIT(4)
-#define SERIO_QUIRK_PROBE_DEFER		BIT(5)
-#define SERIO_QUIRK_RESET_ALWAYS	BIT(6)
-#define SERIO_QUIRK_RESET_NEVER		BIT(7)
-#define SERIO_QUIRK_DIECT		BIT(8)
-#define SERIO_QUIRK_DUMBKBD		BIT(9)
-#define SERIO_QUIRK_NOLOOP		BIT(10)
-#define SERIO_QUIRK_NOTIMEOUT		BIT(11)
-#define SERIO_QUIRK_KBDRESET		BIT(12)
-#define SERIO_QUIRK_DRITEK		BIT(13)
-#define SERIO_QUIRK_NOPNP		BIT(14)
-
-/* Quirk table for different mainboards. Options similar or identical to i8042
- * module parameters.
- * ORDERING IS IMPORTANT! The first match will be apllied and the rest ignored.
- * This allows entries to overwrite vendor wide quirks on a per device basis.
- * Where this is irrelevant, entries are sorted case sensitive by DMI_SYS_VENDOR
- * and/or DMI_BOARD_VENDOR to make it easier to avoid dublicate entries.
- */
-static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
-	{
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "ALIENWARE"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Sentia"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "X750LN"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
-	},
-	{
-		/* Asus X450LCP */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "X450LCP"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_NEVER)
-	},
-	{
-		/* ASUS ZenBook UX425UA */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "ZenBook UX425UA"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_PROBE_DEFER | SERIO_QUIRK_RESET_NEVER)
-	},
-	{
-		/* ASUS ZenBook UM325UA */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "ZenBook UX325UA_UM325UA"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_PROBE_DEFER | SERIO_QUIRK_RESET_NEVER)
-	},
-	/*
-	 * On some Asus laptops, just running self tests cause problems.
-	 */
-	{
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-			DMI_MATCH(DMI_CHASSIS_TYPE, "10"), /* Notebook */
-		},
-		.driver_data = (void *)(SERIO_QUIRK_RESET_NEVER)
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-			DMI_MATCH(DMI_CHASSIS_TYPE, "31"), /* Convertible Notebook */
-		},
-		.driver_data = (void *)(SERIO_QUIRK_RESET_NEVER)
-	},
-	{
-		/* ASUS P65UP5 - AUX LOOP command does not raise AUX IRQ */
-		.matches = {
-			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
-			DMI_MATCH(DMI_BOARD_NAME, "P/I-P65UP5"),
-			DMI_MATCH(DMI_BOARD_VERSION, "REV 2.X"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
-	},
-	{
-		/* ASUS G1S */
-		.matches = {
-			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer Inc."),
-			DMI_MATCH(DMI_BOARD_NAME, "G1S"),
-			DMI_MATCH(DMI_BOARD_VERSION, "1.0"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 1360"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		/* Acer Aspire 5710 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5710"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		/* Acer Aspire 7738 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 7738"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		/* Acer Aspire 5536 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5536"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "0100"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		/*
-		 * Acer Aspire 5738z
-		 * Touchpad stops working in mux mode when dis- + re-enabled
-		 * with the touchpad enable/disable toggle hotkey
-		 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5738"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		/* Acer Aspire One 150 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "AOA150"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire A114-31"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire A314-31"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire A315-31"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire ES1-132"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire ES1-332"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire ES1-432"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate Spin B118-RN"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
-	},
-	/*
-	 * Some Wistron based laptops need us to explicitly enable the 'Dritek
-	 * keyboard extension' to make their extra keys start generating scancodes.
-	 * Originally, this was just confined to older laptops, but a few Acer laptops
-	 * have turned up in 2007 that also need this again.
-	 */
-	{
-		/* Acer Aspire 5100 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5100"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_DRITEK)
-	},
-	{
-		/* Acer Aspire 5610 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5610"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_DRITEK)
-	},
-	{
-		/* Acer Aspire 5630 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5630"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_DRITEK)
-	},
-	{
-		/* Acer Aspire 5650 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5650"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_DRITEK)
-	},
-	{
-		/* Acer Aspire 5680 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5680"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_DRITEK)
-	},
-	{
-		/* Acer Aspire 5720 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5720"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_DRITEK)
-	},
-	{
-		/* Acer Aspire 9110 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 9110"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_DRITEK)
-	},
-	{
-		/* Acer TravelMate 660 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 660"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_DRITEK)
-	},
-	{
-		/* Acer TravelMate 2490 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 2490"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_DRITEK)
-	},
-	{
-		/* Acer TravelMate 4280 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 4280"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_DRITEK)
-	},
-	{
-		/* Amoi M636/A737 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Amoi Electronics CO.,LTD."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "M636/A737 platform"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "ByteSpeed LLC"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "ByteSpeed Laptop C15B"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
-	},
-	{
-		/* Compal HEL80I */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "COMPAL"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "HEL80I"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Compaq"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "ProLiant"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "8500"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Compaq"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "ProLiant"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "DL760"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
-	},
-	{
-		/* Advent 4211 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "DIXONSXP"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Advent 4211"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
-	},
-	{
-		/* Dell Embedded Box PC 3000 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Embedded Box PC 3000"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
-	},
-	{
-		/* Dell XPS M1530 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "XPS M1530"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		/* Dell Vostro 1510 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Vostro1510"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		/* Dell Vostro V13 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Vostro V13"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_NOTIMEOUT)
-	},
-	{
-		/* Dell Vostro 1320 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 1320"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
-	},
-	{
-		/* Dell Vostro 1520 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 1520"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
-	},
-	{
-		/* Dell Vostro 1720 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 1720"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
-	},
-	{
-		/* Entroware Proteus */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Entroware"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Proteus"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "EL07R4"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS)
-	},
-	/*
-	 * Some Fujitsu notebooks are having trouble with touchpads if
-	 * active multiplexing mode is activated. Luckily they don't have
-	 * external PS/2 ports so we can safely disable it.
-	 * ... apparently some Toshibas don't like MUX mode either and
-	 * die horrible death on reboot.
-	 */
-	{
-		/* Fujitsu Lifebook P7010/P7010D */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "P7010"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		/* Fujitsu Lifebook P5020D */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "LifeBook P Series"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		/* Fujitsu Lifebook S2000 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "LifeBook S Series"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		/* Fujitsu Lifebook S6230 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "LifeBook S6230"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		/* Fujitsu Lifebook T725 laptop */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK T725"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_NOTIMEOUT)
-	},
-	{
-		/* Fujitsu Lifebook U745 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK U745"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		/* Fujitsu T70H */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "FMVLT70H"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		/* Fujitsu A544 laptop */
-		/* https://bugzilla.redhat.com/show_bug.cgi?id=1111138 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK A544"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOTIMEOUT)
-	},
-	{
-		/* Fujitsu AH544 laptop */
-		/* https://bugzilla.kernel.org/show_bug.cgi?id=69731 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK AH544"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOTIMEOUT)
-	},
-	{
-		/* Fujitsu U574 laptop */
-		/* https://bugzilla.kernel.org/show_bug.cgi?id=69731 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK U574"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOTIMEOUT)
-	},
-	{
-		/* Fujitsu UH554 laptop */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK UH544"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOTIMEOUT)
-	},
-	{
-		/* Fujitsu Lifebook P7010 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "0000000000"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		/* Fujitsu-Siemens Lifebook T3010 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK T3010"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		/* Fujitsu-Siemens Lifebook E4010 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK E4010"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		/* Fujitsu-Siemens Amilo Pro 2010 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "AMILO Pro V2010"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		/* Fujitsu-Siemens Amilo Pro 2030 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "AMILO PRO V2030"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		/* Fujitsu Lifebook A574/H */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "FMVA0501PZ"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		/* Gigabyte M912 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "GIGABYTE"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "M912"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "01"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
-	},
-	{
-		/* Gigabyte Spring Peak - defines wrong chassis type */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "GIGABYTE"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Spring Peak"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
-	},
-	{
-		/* Gigabyte T1005 - defines wrong chassis type ("Other") */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "GIGABYTE"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "T1005"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
-	},
-	{
-		/* Gigabyte T1005M/P - defines wrong chassis type ("Other") */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "GIGABYTE"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "T1005M/P"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
-	},
-	/*
-	 * Some laptops need keyboard reset before probing for the trackpad to get
-	 * it detected, initialised & finally work.
-	 */
-	{
-		/* Gigabyte P35 v2 - Elantech touchpad */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "GIGABYTE"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "P35V2"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_KBDRESET)
-	},
-		{
-		/* Aorus branded Gigabyte X3 Plus - Elantech touchpad */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "GIGABYTE"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "X3"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_KBDRESET)
-	},
-	{
-		/* Gigabyte P34 - Elantech touchpad */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "GIGABYTE"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "P34"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_KBDRESET)
-	},
-	{
-		/* Gigabyte P57 - Elantech touchpad */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "GIGABYTE"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "P57"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_KBDRESET)
-	},
-	{
-		/* Gericom Bellagio */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Gericom"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "N34AS6"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		/* Gigabyte M1022M netbook */
-		.matches = {
-			DMI_MATCH(DMI_BOARD_VENDOR, "Gigabyte Technology Co.,Ltd."),
-			DMI_MATCH(DMI_BOARD_NAME, "M1022E"),
-			DMI_MATCH(DMI_BOARD_VERSION, "1.02"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion dv9700"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "Rev 1"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
-	},
-	{
-		/*
-		 * HP Pavilion DV4017EA -
-		 * errors on MUX ports are reported without raising AUXDATA
-		 * causing "spurious NAK" messages.
-		 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Pavilion dv4000 (EA032EA#ABF)"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		/*
-		 * HP Pavilion ZT1000 -
-		 * like DV4017EA does not raise AUXERR for errors on MUX ports.
-		 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion Notebook PC"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "HP Pavilion Notebook ZT1000"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		/*
-		 * HP Pavilion DV4270ca -
-		 * like DV4017EA does not raise AUXERR for errors on MUX ports.
-		 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Pavilion dv4000 (EH476UA#ABL)"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		/* Newer HP Pavilion dv4 models */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion dv4 Notebook PC"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_NOTIMEOUT)
-	},
-	{
-		/* IBM 2656 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "IBM"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "2656"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		/* Avatar AVIU-145A6 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Intel"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "IC4I"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		/* Intel MBO Desktop D845PESV */
-		.matches = {
-			DMI_MATCH(DMI_BOARD_VENDOR, "Intel Corporation"),
-			DMI_MATCH(DMI_BOARD_NAME, "D845PESV"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOPNP)
-	},
-	{
-		/*
-		 * Intel NUC D54250WYK - does not have i8042 controller but
-		 * declares PS/2 devices in DSDT.
-		 */
-		.matches = {
-			DMI_MATCH(DMI_BOARD_VENDOR, "Intel Corporation"),
-			DMI_MATCH(DMI_BOARD_NAME, "D54250WYK"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOPNP)
-	},
-	{
-		/* Lenovo 3000 n100 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "076804U"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		/* Lenovo XiaoXin Air 12 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "80UN"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		/* Lenovo LaVie Z */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo LaVie Z"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		/* Lenovo Ideapad U455 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "20046"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
-	},
-	{
-		/* Lenovo ThinkPad L460 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad L460"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
-	},
-	{
-		/* Lenovo ThinkPad Twist S230u */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "33474HU"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
-	},
-	{
-		/* LG Electronics X110 */
-		.matches = {
-			DMI_MATCH(DMI_BOARD_VENDOR, "LG Electronics Inc."),
-			DMI_MATCH(DMI_BOARD_NAME, "X110"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
-	},
-	{
-		/* Medion Akoya Mini E1210 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "MEDION"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "E1210"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
-	},
-	{
-		/* Medion Akoya E1222 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "MEDION"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "E122X"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
-	},
-	{
-		/* MSI Wind U-100 */
-		.matches = {
-			DMI_MATCH(DMI_BOARD_VENDOR, "MICRO-STAR INTERNATIONAL CO., LTD"),
-			DMI_MATCH(DMI_BOARD_NAME, "U-100"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS | SERIO_QUIRK_NOPNP)
-	},
-	{
-		/*
-		 * No data is coming from the touchscreen unless KBC
-		 * is in legacy mode.
-		 */
-		/* Panasonic CF-29 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Matsushita"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "CF-29"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		/* Medion Akoya E7225 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Medion"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Akoya E7225"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "1.0"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
-	},
-	{
-		/* Microsoft Virtual Machine */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Microsoft Corporation"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Virtual Machine"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "VS2005R2"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
-	},
-	{
-		/* Medion MAM 2070 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "MAM 2070"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "5a"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
-	},
-	{
-		/* TUXEDO BU1406 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "N24_25BU"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		/* Clevo P650RS, 650RP6, Sager NP8152-S, and others */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "P65xRP"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
-	},
-	{
-		/* OQO Model 01 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "OQO"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "ZEPTO"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "00"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "PEGATRON CORPORATION"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "C15B"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
-	},
-	{
-		/* Acer Aspire 5 A515 */
-		.matches = {
-			DMI_MATCH(DMI_BOARD_VENDOR, "PK"),
-			DMI_MATCH(DMI_BOARD_NAME, "Grumpy_PK"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOPNP)
-	},
-	{
-		/* ULI EV4873 - AUX LOOP does not work properly */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "ULI"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "EV4873"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "5a"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
-	},
-	{
-		/*
-		 * Arima-Rioworks HDAMB -
-		 * AUX LOOP command does not raise AUX IRQ
-		 */
-		.matches = {
-			DMI_MATCH(DMI_BOARD_VENDOR, "RIOWORKS"),
-			DMI_MATCH(DMI_BOARD_NAME, "HDAMB"),
-			DMI_MATCH(DMI_BOARD_VERSION, "Rev E"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
-	},
-	{
-		/* Sharp Actius MM20 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "SHARP"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "PC-MM20 Series"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		/*
-		 * Sony Vaio FZ-240E -
-		 * reset and GET ID commands issued via KBD port are
-		 * sometimes being delivered to AUX3.
-		 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "VGN-FZ240E"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		/*
-		 * Most (all?) VAIOs do not have external PS/2 ports nor
-		 * they implement active multiplexing properly, and
-		 * MUX discovery usually messes up keyboard/touchpad.
-		 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
-			DMI_MATCH(DMI_BOARD_NAME, "VAIO"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		/* Sony Vaio FS-115b */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "VGN-FS115B"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		/*
-		 * Sony Vaio VGN-CS series require MUX or the touch sensor
-		 * buttons will disturb touchpad operation
-		 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "VGN-CS"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_FORCEMUX)
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Satellite P10"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "EQUIUM A110"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "SATELLITE C850D"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	/*
-	 * A lot of modern Clevo barebones have touchpad and/or keyboard issues
-	 * after suspend fixable with nomux + reset + noloop + nopnp. Luckily,
-	 * none of them have an external PS/2 port so this can safely be set for
-	 * all of them. These two are based on a Clevo design, but have the
-	 * board_name changed.
-	 */
-	{
-		.matches = {
-			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
-			DMI_MATCH(DMI_BOARD_NAME, "AURA1501"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
-					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
-			DMI_MATCH(DMI_BOARD_NAME, "EDUBOOK1502"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
-					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
-	},
-	{
-		/* Mivvy M310 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "VIOOO"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "N10"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
-	},
-	/*
-	 * Some laptops need keyboard reset before probing for the trackpad to get
-	 * it detected, initialised & finally work.
-	 */
-	{
-		/* Schenker XMG C504 - Elantech touchpad */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "XMG"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "C504"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_KBDRESET)
-	},
-	{
-		/* Blue FB5601 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "blue"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "FB5601"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "M606"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
-	},
-	/*
-	 * A lot of modern Clevo barebones have touchpad and/or keyboard issues
-	 * after suspend fixable with nomux + reset + noloop + nopnp. Luckily,
-	 * none of them have an external PS/2 port so this can safely be set for
-	 * all of them.
-	 * Clevo barebones come with board_vendor and/or system_vendor set to
-	 * either the very generic string "Notebook" and/or a different value
-	 * for each individual reseller. The only somewhat universal way to
-	 * identify them is by board_name.
-	 */
-	{
-		.matches = {
-			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71A"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
-					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71B"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
-					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_BOARD_NAME, "N140CU"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
-					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_BOARD_NAME, "N141CU"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
-					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_BOARD_NAME, "NH5xAx"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
-					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
-					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
-	},
-	/*
-	 * At least one modern Clevo barebone has the touchpad connected both
-	 * via PS/2 and i2c interface. This causes a race condition between the
-	 * psmouse and i2c-hid driver. Since the full capability of the touchpad
-	 * is available via the i2c interface and the device has no external
-	 * PS/2 port, it is safe to just ignore all ps2 mouses here to avoid
-	 * this issue. The known affected device is the
-	 * TUXEDO InfinityBook S17 Gen6 / Clevo NS70MU which comes with one of
-	 * the two different dmi strings below. NS50MU is not a typo!
-	 */
-	{
-		.matches = {
-			DMI_MATCH(DMI_BOARD_NAME, "NS50MU"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOAUX | SERIO_QUIRK_NOMUX |
-					SERIO_QUIRK_RESET_ALWAYS | SERIO_QUIRK_NOLOOP |
-					SERIO_QUIRK_NOPNP)
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_BOARD_NAME, "NS50_70MU"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOAUX | SERIO_QUIRK_NOMUX |
-					SERIO_QUIRK_RESET_ALWAYS | SERIO_QUIRK_NOLOOP |
-					SERIO_QUIRK_NOPNP)
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_BOARD_NAME, "NJ50_70CU"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
-					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_BOARD_NAME, "PB50_70DFx,DDx"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
-					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_BOARD_NAME, "PCX0DX"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
-					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_BOARD_NAME, "X170SM"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
-					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_BOARD_NAME, "X170KM-G"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
-					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
-	},
-	{ }
-};
-
-#ifdef CONFIG_PNP
-static const struct dmi_system_id i8042_dmi_laptop_table[] __initconst = {
-	{
-		.matches = {
-			DMI_MATCH(DMI_CHASSIS_TYPE, "8"), /* Portable */
-		},
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_CHASSIS_TYPE, "9"), /* Laptop */
-		},
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_CHASSIS_TYPE, "10"), /* Notebook */
-		},
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_CHASSIS_TYPE, "14"), /* Sub-Notebook */
-		},
-	},
-	{ }
-};
-#endif
-
-#endif /* CONFIG_X86 */
-
-#ifdef CONFIG_PNP
-#include <linux/pnp.h>
-
-static bool i8042_pnp_kbd_registered;
-static unsigned int i8042_pnp_kbd_devices;
-static bool i8042_pnp_aux_registered;
-static unsigned int i8042_pnp_aux_devices;
-
-static int i8042_pnp_command_reg;
-static int i8042_pnp_data_reg;
-static int i8042_pnp_kbd_irq;
-static int i8042_pnp_aux_irq;
-
-static char i8042_pnp_kbd_name[32];
-static char i8042_pnp_aux_name[32];
-
-static void i8042_pnp_id_to_string(struct pnp_id *id, char *dst, int dst_size)
-{
-	strlcpy(dst, "PNP:", dst_size);
-
-	while (id) {
-		strlcat(dst, " ", dst_size);
-		strlcat(dst, id->id, dst_size);
-		id = id->next;
-	}
-}
-
-static int i8042_pnp_kbd_probe(struct pnp_dev *dev, const struct pnp_device_id *did)
-{
-	if (pnp_port_valid(dev, 0) && pnp_port_len(dev, 0) == 1)
-		i8042_pnp_data_reg = pnp_port_start(dev,0);
-
-	if (pnp_port_valid(dev, 1) && pnp_port_len(dev, 1) == 1)
-		i8042_pnp_command_reg = pnp_port_start(dev, 1);
-
-	if (pnp_irq_valid(dev,0))
-		i8042_pnp_kbd_irq = pnp_irq(dev, 0);
-
-	strlcpy(i8042_pnp_kbd_name, did->id, sizeof(i8042_pnp_kbd_name));
-	if (strlen(pnp_dev_name(dev))) {
-		strlcat(i8042_pnp_kbd_name, ":", sizeof(i8042_pnp_kbd_name));
-		strlcat(i8042_pnp_kbd_name, pnp_dev_name(dev), sizeof(i8042_pnp_kbd_name));
-	}
-	i8042_pnp_id_to_string(dev->id, i8042_kbd_firmware_id,
-			       sizeof(i8042_kbd_firmware_id));
-	i8042_kbd_fwnode = dev_fwnode(&dev->dev);
-
-	/* Keyboard ports are always supposed to be wakeup-enabled */
-	device_set_wakeup_enable(&dev->dev, true);
-
-	i8042_pnp_kbd_devices++;
-	return 0;
-}
-
-static int i8042_pnp_aux_probe(struct pnp_dev *dev, const struct pnp_device_id *did)
-{
-	if (pnp_port_valid(dev, 0) && pnp_port_len(dev, 0) == 1)
-		i8042_pnp_data_reg = pnp_port_start(dev,0);
-
-	if (pnp_port_valid(dev, 1) && pnp_port_len(dev, 1) == 1)
-		i8042_pnp_command_reg = pnp_port_start(dev, 1);
-
-	if (pnp_irq_valid(dev, 0))
-		i8042_pnp_aux_irq = pnp_irq(dev, 0);
-
-	strlcpy(i8042_pnp_aux_name, did->id, sizeof(i8042_pnp_aux_name));
-	if (strlen(pnp_dev_name(dev))) {
-		strlcat(i8042_pnp_aux_name, ":", sizeof(i8042_pnp_aux_name));
-		strlcat(i8042_pnp_aux_name, pnp_dev_name(dev), sizeof(i8042_pnp_aux_name));
-	}
-	i8042_pnp_id_to_string(dev->id, i8042_aux_firmware_id,
-			       sizeof(i8042_aux_firmware_id));
-
-	i8042_pnp_aux_devices++;
-	return 0;
-}
-
-static const struct pnp_device_id pnp_kbd_devids[] = {
-	{ .id = "PNP0300", .driver_data = 0 },
-	{ .id = "PNP0301", .driver_data = 0 },
-	{ .id = "PNP0302", .driver_data = 0 },
-	{ .id = "PNP0303", .driver_data = 0 },
-	{ .id = "PNP0304", .driver_data = 0 },
-	{ .id = "PNP0305", .driver_data = 0 },
-	{ .id = "PNP0306", .driver_data = 0 },
-	{ .id = "PNP0309", .driver_data = 0 },
-	{ .id = "PNP030a", .driver_data = 0 },
-	{ .id = "PNP030b", .driver_data = 0 },
-	{ .id = "PNP0320", .driver_data = 0 },
-	{ .id = "PNP0343", .driver_data = 0 },
-	{ .id = "PNP0344", .driver_data = 0 },
-	{ .id = "PNP0345", .driver_data = 0 },
-	{ .id = "CPQA0D7", .driver_data = 0 },
-	{ .id = "", },
-};
-MODULE_DEVICE_TABLE(pnp, pnp_kbd_devids);
-
-static struct pnp_driver i8042_pnp_kbd_driver = {
-	.name           = "i8042 kbd",
-	.id_table       = pnp_kbd_devids,
-	.probe          = i8042_pnp_kbd_probe,
-	.driver         = {
-		.probe_type = PROBE_FORCE_SYNCHRONOUS,
-		.suppress_bind_attrs = true,
-	},
-};
-
-static const struct pnp_device_id pnp_aux_devids[] = {
-	{ .id = "AUI0200", .driver_data = 0 },
-	{ .id = "FJC6000", .driver_data = 0 },
-	{ .id = "FJC6001", .driver_data = 0 },
-	{ .id = "PNP0f03", .driver_data = 0 },
-	{ .id = "PNP0f0b", .driver_data = 0 },
-	{ .id = "PNP0f0e", .driver_data = 0 },
-	{ .id = "PNP0f12", .driver_data = 0 },
-	{ .id = "PNP0f13", .driver_data = 0 },
-	{ .id = "PNP0f19", .driver_data = 0 },
-	{ .id = "PNP0f1c", .driver_data = 0 },
-	{ .id = "SYN0801", .driver_data = 0 },
-	{ .id = "", },
-};
-MODULE_DEVICE_TABLE(pnp, pnp_aux_devids);
-
-static struct pnp_driver i8042_pnp_aux_driver = {
-	.name           = "i8042 aux",
-	.id_table       = pnp_aux_devids,
-	.probe          = i8042_pnp_aux_probe,
-	.driver         = {
-		.probe_type = PROBE_FORCE_SYNCHRONOUS,
-		.suppress_bind_attrs = true,
-	},
-};
-
-static void i8042_pnp_exit(void)
-{
-	if (i8042_pnp_kbd_registered) {
-		i8042_pnp_kbd_registered = false;
-		pnp_unregister_driver(&i8042_pnp_kbd_driver);
-	}
-
-	if (i8042_pnp_aux_registered) {
-		i8042_pnp_aux_registered = false;
-		pnp_unregister_driver(&i8042_pnp_aux_driver);
-	}
-}
-
-static int __init i8042_pnp_init(void)
-{
-	char kbd_irq_str[4] = { 0 }, aux_irq_str[4] = { 0 };
-	bool pnp_data_busted = false;
-	int err;
-
-	if (i8042_nopnp) {
-		pr_info("PNP detection disabled\n");
-		return 0;
-	}
-
-	err = pnp_register_driver(&i8042_pnp_kbd_driver);
-	if (!err)
-		i8042_pnp_kbd_registered = true;
-
-	err = pnp_register_driver(&i8042_pnp_aux_driver);
-	if (!err)
-		i8042_pnp_aux_registered = true;
-
-	if (!i8042_pnp_kbd_devices && !i8042_pnp_aux_devices) {
-		i8042_pnp_exit();
-#if defined(__ia64__)
-		return -ENODEV;
-#else
-		pr_info("PNP: No PS/2 controller found.\n");
-		if (x86_platform.legacy.i8042 !=
-				X86_LEGACY_I8042_EXPECTED_PRESENT)
-			return -ENODEV;
-		pr_info("Probing ports directly.\n");
-		return 0;
-#endif
-	}
-
-	if (i8042_pnp_kbd_devices)
-		snprintf(kbd_irq_str, sizeof(kbd_irq_str),
-			"%d", i8042_pnp_kbd_irq);
-	if (i8042_pnp_aux_devices)
-		snprintf(aux_irq_str, sizeof(aux_irq_str),
-			"%d", i8042_pnp_aux_irq);
-
-	pr_info("PNP: PS/2 Controller [%s%s%s] at %#x,%#x irq %s%s%s\n",
-		i8042_pnp_kbd_name, (i8042_pnp_kbd_devices && i8042_pnp_aux_devices) ? "," : "",
-		i8042_pnp_aux_name,
-		i8042_pnp_data_reg, i8042_pnp_command_reg,
-		kbd_irq_str, (i8042_pnp_kbd_devices && i8042_pnp_aux_devices) ? "," : "",
-		aux_irq_str);
-
-#if defined(__ia64__)
-	if (!i8042_pnp_kbd_devices)
-		i8042_nokbd = true;
-	if (!i8042_pnp_aux_devices)
-		i8042_noaux = true;
-#endif
-
-	if (((i8042_pnp_data_reg & ~0xf) == (i8042_data_reg & ~0xf) &&
-	      i8042_pnp_data_reg != i8042_data_reg) ||
-	    !i8042_pnp_data_reg) {
-		pr_warn("PNP: PS/2 controller has invalid data port %#x; using default %#x\n",
-			i8042_pnp_data_reg, i8042_data_reg);
-		i8042_pnp_data_reg = i8042_data_reg;
-		pnp_data_busted = true;
-	}
-
-	if (((i8042_pnp_command_reg & ~0xf) == (i8042_command_reg & ~0xf) &&
-	      i8042_pnp_command_reg != i8042_command_reg) ||
-	    !i8042_pnp_command_reg) {
-		pr_warn("PNP: PS/2 controller has invalid command port %#x; using default %#x\n",
-			i8042_pnp_command_reg, i8042_command_reg);
-		i8042_pnp_command_reg = i8042_command_reg;
-		pnp_data_busted = true;
-	}
-
-	if (!i8042_nokbd && !i8042_pnp_kbd_irq) {
-		pr_warn("PNP: PS/2 controller doesn't have KBD irq; using default %d\n",
-			i8042_kbd_irq);
-		i8042_pnp_kbd_irq = i8042_kbd_irq;
-		pnp_data_busted = true;
-	}
-
-	if (!i8042_noaux && !i8042_pnp_aux_irq) {
-		if (!pnp_data_busted && i8042_pnp_kbd_irq) {
-			pr_warn("PNP: PS/2 appears to have AUX port disabled, "
-				"if this is incorrect please boot with i8042.nopnp\n");
-			i8042_noaux = true;
-		} else {
-			pr_warn("PNP: PS/2 controller doesn't have AUX irq; using default %d\n",
-				i8042_aux_irq);
-			i8042_pnp_aux_irq = i8042_aux_irq;
-		}
-	}
-
-	i8042_data_reg = i8042_pnp_data_reg;
-	i8042_command_reg = i8042_pnp_command_reg;
-	i8042_kbd_irq = i8042_pnp_kbd_irq;
-	i8042_aux_irq = i8042_pnp_aux_irq;
-
-#ifdef CONFIG_X86
-	i8042_bypass_aux_irq_test = !pnp_data_busted &&
-				    dmi_check_system(i8042_dmi_laptop_table);
-#endif
-
-	return 0;
-}
-
-#else  /* !CONFIG_PNP */
-static inline int i8042_pnp_init(void) { return 0; }
-static inline void i8042_pnp_exit(void) { }
-#endif /* CONFIG_PNP */
-
-
-#ifdef CONFIG_X86
-static void __init i8042_check_quirks(void)
-{
-	const struct dmi_system_id *device_quirk_info;
-	uintptr_t quirks;
-
-	device_quirk_info = dmi_first_match(i8042_dmi_quirk_table);
-	if (!device_quirk_info)
-		return;
-
-	quirks = (uintptr_t)device_quirk_info->driver_data;
-
-	if (quirks & SERIO_QUIRK_NOKBD)
-		i8042_nokbd = true;
-	if (quirks & SERIO_QUIRK_NOAUX)
-		i8042_noaux = true;
-	if (quirks & SERIO_QUIRK_NOMUX)
-		i8042_nomux = true;
-	if (quirks & SERIO_QUIRK_FORCEMUX)
-		i8042_nomux = false;
-	if (quirks & SERIO_QUIRK_UNLOCK)
-		i8042_unlock = true;
-	if (quirks & SERIO_QUIRK_PROBE_DEFER)
-		i8042_probe_defer = true;
-	/* Honor module parameter when value is not default */
-	if (i8042_reset == I8042_RESET_DEFAULT) {
-		if (quirks & SERIO_QUIRK_RESET_ALWAYS)
-			i8042_reset = I8042_RESET_ALWAYS;
-		if (quirks & SERIO_QUIRK_RESET_NEVER)
-			i8042_reset = I8042_RESET_NEVER;
-	}
-	if (quirks & SERIO_QUIRK_DIECT)
-		i8042_direct = true;
-	if (quirks & SERIO_QUIRK_DUMBKBD)
-		i8042_dumbkbd = true;
-	if (quirks & SERIO_QUIRK_NOLOOP)
-		i8042_noloop = true;
-	if (quirks & SERIO_QUIRK_NOTIMEOUT)
-		i8042_notimeout = true;
-	if (quirks & SERIO_QUIRK_KBDRESET)
-		i8042_kbdreset = true;
-	if (quirks & SERIO_QUIRK_DRITEK)
-		i8042_dritek = true;
-#ifdef CONFIG_PNP
-	if (quirks & SERIO_QUIRK_NOPNP)
-		i8042_nopnp = true;
-#endif
-}
-#else
-static inline void i8042_check_quirks(void) {}
-#endif
-
-static int __init i8042_platform_init(void)
-{
-	int retval;
-
-#ifdef CONFIG_X86
-	u8 a20_on = 0xdf;
-	/* Just return if platform does not have i8042 controller */
-	if (x86_platform.legacy.i8042 == X86_LEGACY_I8042_PLATFORM_ABSENT)
-		return -ENODEV;
-#endif
-
-/*
- * On ix86 platforms touching the i8042 data register region can do really
- * bad things. Because of this the region is always reserved on ix86 boxes.
- *
- *	if (!request_region(I8042_DATA_REG, 16, "i8042"))
- *		return -EBUSY;
- */
-
-	i8042_kbd_irq = I8042_MAP_IRQ(1);
-	i8042_aux_irq = I8042_MAP_IRQ(12);
-
-#if defined(__ia64__)
-	i8042_reset = I8042_RESET_ALWAYS;
-#endif
-
-	i8042_check_quirks();
-
-	retval = i8042_pnp_init();
-	if (retval)
-		return retval;
-
-#ifdef CONFIG_X86
-	/*
-	 * A20 was already enabled during early kernel init. But some buggy
-	 * BIOSes (in MSI Laptops) require A20 to be enabled using 8042 to
-	 * resume from S3. So we do it here and hope that nothing breaks.
-	 */
-	i8042_command(&a20_on, 0x10d1);
-	i8042_command(NULL, 0x00ff);	/* Null command for SMM firmware */
-#endif /* CONFIG_X86 */
-
-	return retval;
-}
-
-static inline void i8042_platform_exit(void)
-{
-	i8042_pnp_exit();
-}
-
-#endif /* _I8042_X86IA64IO_H */
diff --git a/drivers/input/serio/i8042.h b/drivers/input/serio/i8042.h
index 55381783dc82..bf2592fa9a78 100644
--- a/drivers/input/serio/i8042.h
+++ b/drivers/input/serio/i8042.h
@@ -20,7 +20,7 @@
 #elif defined(CONFIG_SPARC)
 #include "i8042-sparcio.h"
 #elif defined(CONFIG_X86) || defined(CONFIG_IA64)
-#include "i8042-x86ia64io.h"
+#include "i8042-acpipnpio.h"
 #else
 #include "i8042-io.h"
 #endif
diff --git a/drivers/md/dm-zoned-target.c b/drivers/md/dm-zoned-target.c
index 7e88df64d197..48fc723f1ac8 100644
--- a/drivers/md/dm-zoned-target.c
+++ b/drivers/md/dm-zoned-target.c
@@ -750,17 +750,16 @@ static int dmz_get_zoned_device(struct dm_target *ti, char *path,
 /*
  * Cleanup zoned device information.
  */
-static void dmz_put_zoned_device(struct dm_target *ti)
+static void dmz_put_zoned_devices(struct dm_target *ti)
 {
 	struct dmz_target *dmz = ti->private;
 	int i;
 
-	for (i = 0; i < dmz->nr_ddevs; i++) {
-		if (dmz->ddev[i]) {
+	for (i = 0; i < dmz->nr_ddevs; i++)
+		if (dmz->ddev[i])
 			dm_put_device(ti, dmz->ddev[i]);
-			dmz->ddev[i] = NULL;
-		}
-	}
+
+	kfree(dmz->ddev);
 }
 
 static int dmz_fixup_devices(struct dm_target *ti)
@@ -951,7 +950,7 @@ static int dmz_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 err_meta:
 	dmz_dtr_metadata(dmz->metadata);
 err_dev:
-	dmz_put_zoned_device(ti);
+	dmz_put_zoned_devices(ti);
 err:
 	kfree(dmz->dev);
 	kfree(dmz);
@@ -982,7 +981,7 @@ static void dmz_dtr(struct dm_target *ti)
 
 	bioset_exit(&dmz->bio_set);
 
-	dmz_put_zoned_device(ti);
+	dmz_put_zoned_devices(ti);
 
 	mutex_destroy(&dmz->chunk_lock);
 
diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 62d11c6e41d6..5f7ac2807e5f 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -21,6 +21,7 @@
 #include "core.h"
 #include "firmware.h"
 #include "pm_helpers.h"
+#include "hfi_venus_io.h"
 
 static void venus_event_notify(struct venus_core *core, u32 event)
 {
@@ -210,6 +211,15 @@ static int venus_enumerate_codecs(struct venus_core *core, u32 type)
 	return ret;
 }
 
+static void venus_assign_register_offsets(struct venus_core *core)
+{
+	core->vbif_base = core->base + VBIF_BASE;
+	core->cpu_base = core->base + CPU_BASE;
+	core->cpu_cs_base = core->base + CPU_CS_BASE;
+	core->cpu_ic_base = core->base + CPU_IC_BASE;
+	core->wrapper_base = core->base + WRAPPER_BASE;
+}
+
 static int venus_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -276,6 +286,8 @@ static int venus_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_core_put;
 
+	venus_assign_register_offsets(core);
+
 	ret = v4l2_device_register(dev, &core->v4l2_dev);
 	if (ret)
 		goto err_core_deinit;
diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index aebd4c664bfa..75d006803327 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -119,6 +119,11 @@ struct venus_caps {
  * struct venus_core - holds core parameters valid for all instances
  *
  * @base:	IO memory base address
+ * @vbif_base	IO memory vbif base address
+ * @cpu_base	IO memory cpu base address
+ * @cpu_cs_base	IO memory cpu_cs base address
+ * @cpu_ic_base	IO memory cpu_ic base address
+ * @wrapper_base	IO memory wrapper base address
  * @irq:		Venus irq
  * @clks:	an array of struct clk pointers
  * @vcodec0_clks: an array of vcodec0 struct clk pointers
@@ -152,6 +157,11 @@ struct venus_caps {
  */
 struct venus_core {
 	void __iomem *base;
+	void __iomem *vbif_base;
+	void __iomem *cpu_base;
+	void __iomem *cpu_cs_base;
+	void __iomem *cpu_ic_base;
+	void __iomem *wrapper_base;
 	int irq;
 	struct clk *clks[VIDC_CLKS_NUM_MAX];
 	struct clk *vcodec0_clks[VIDC_VCODEC_CLKS_NUM_MAX];
@@ -416,6 +426,7 @@ struct venus_inst {
 #define IS_V1(core)	((core)->res->hfi_version == HFI_VERSION_1XX)
 #define IS_V3(core)	((core)->res->hfi_version == HFI_VERSION_3XX)
 #define IS_V4(core)	((core)->res->hfi_version == HFI_VERSION_4XX)
+#define IS_V6(core)	((core)->res->hfi_version == HFI_VERSION_6XX)
 
 #define ctrl_to_inst(ctrl)	\
 	container_of((ctrl)->handler, struct venus_inst, ctrl_handler)
diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
index 1db64a854b88..67b9138a7c5f 100644
--- a/drivers/media/platform/qcom/venus/firmware.c
+++ b/drivers/media/platform/qcom/venus/firmware.c
@@ -27,19 +27,19 @@
 static void venus_reset_cpu(struct venus_core *core)
 {
 	u32 fw_size = core->fw.mapped_mem_size;
-	void __iomem *base = core->base;
+	void __iomem *wrapper_base = core->wrapper_base;
 
-	writel(0, base + WRAPPER_FW_START_ADDR);
-	writel(fw_size, base + WRAPPER_FW_END_ADDR);
-	writel(0, base + WRAPPER_CPA_START_ADDR);
-	writel(fw_size, base + WRAPPER_CPA_END_ADDR);
-	writel(fw_size, base + WRAPPER_NONPIX_START_ADDR);
-	writel(fw_size, base + WRAPPER_NONPIX_END_ADDR);
-	writel(0x0, base + WRAPPER_CPU_CGC_DIS);
-	writel(0x0, base + WRAPPER_CPU_CLOCK_CONFIG);
+	writel(0, wrapper_base + WRAPPER_FW_START_ADDR);
+	writel(fw_size, wrapper_base + WRAPPER_FW_END_ADDR);
+	writel(0, wrapper_base + WRAPPER_CPA_START_ADDR);
+	writel(fw_size, wrapper_base + WRAPPER_CPA_END_ADDR);
+	writel(fw_size, wrapper_base + WRAPPER_NONPIX_START_ADDR);
+	writel(fw_size, wrapper_base + WRAPPER_NONPIX_END_ADDR);
+	writel(0x0, wrapper_base + WRAPPER_CPU_CGC_DIS);
+	writel(0x0, wrapper_base + WRAPPER_CPU_CLOCK_CONFIG);
 
 	/* Bring ARM9 out of reset */
-	writel(0, base + WRAPPER_A9SS_SW_RESET);
+	writel(0, wrapper_base + WRAPPER_A9SS_SW_RESET);
 }
 
 int venus_set_hw_state(struct venus_core *core, bool resume)
@@ -56,7 +56,7 @@ int venus_set_hw_state(struct venus_core *core, bool resume)
 	if (resume)
 		venus_reset_cpu(core);
 	else
-		writel(1, core->base + WRAPPER_A9SS_SW_RESET);
+		writel(1, core->wrapper_base + WRAPPER_A9SS_SW_RESET);
 
 	return 0;
 }
@@ -159,12 +159,12 @@ static int venus_shutdown_no_tz(struct venus_core *core)
 	size_t unmapped;
 	u32 reg;
 	struct device *dev = core->fw.dev;
-	void __iomem *base = core->base;
+	void __iomem *wrapper_base = core->wrapper_base;
 
 	/* Assert the reset to ARM9 */
-	reg = readl_relaxed(base + WRAPPER_A9SS_SW_RESET);
+	reg = readl_relaxed(wrapper_base + WRAPPER_A9SS_SW_RESET);
 	reg |= WRAPPER_A9SS_SW_RESET_BIT;
-	writel_relaxed(reg, base + WRAPPER_A9SS_SW_RESET);
+	writel_relaxed(reg, wrapper_base + WRAPPER_A9SS_SW_RESET);
 
 	/* Make sure reset is asserted before the mapping is removed */
 	mb();
diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
index 4be4a75ddcb6..9d939f63d16f 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus.c
+++ b/drivers/media/platform/qcom/venus/hfi_venus.c
@@ -345,16 +345,6 @@ static void venus_free(struct venus_hfi_device *hdev, struct mem_desc *mem)
 	dma_free_attrs(dev, mem->size, mem->kva, mem->da, mem->attrs);
 }
 
-static void venus_writel(struct venus_hfi_device *hdev, u32 reg, u32 value)
-{
-	writel(value, hdev->core->base + reg);
-}
-
-static u32 venus_readl(struct venus_hfi_device *hdev, u32 reg)
-{
-	return readl(hdev->core->base + reg);
-}
-
 static void venus_set_registers(struct venus_hfi_device *hdev)
 {
 	const struct venus_resources *res = hdev->core->res;
@@ -363,12 +353,14 @@ static void venus_set_registers(struct venus_hfi_device *hdev)
 	unsigned int i;
 
 	for (i = 0; i < count; i++)
-		venus_writel(hdev, tbl[i].reg, tbl[i].value);
+		writel(tbl[i].value, hdev->core->base + tbl[i].reg);
 }
 
 static void venus_soft_int(struct venus_hfi_device *hdev)
 {
-	venus_writel(hdev, CPU_IC_SOFTINT, BIT(CPU_IC_SOFTINT_H2A_SHIFT));
+	void __iomem *cpu_ic_base = hdev->core->cpu_ic_base;
+
+	writel(BIT(CPU_IC_SOFTINT_H2A_SHIFT), cpu_ic_base + CPU_IC_SOFTINT);
 }
 
 static int venus_iface_cmdq_write_nolock(struct venus_hfi_device *hdev,
@@ -439,16 +431,25 @@ static int venus_boot_core(struct venus_hfi_device *hdev)
 {
 	struct device *dev = hdev->core->dev;
 	static const unsigned int max_tries = 100;
-	u32 ctrl_status = 0;
+	u32 ctrl_status = 0, mask_val;
 	unsigned int count = 0;
+	void __iomem *cpu_cs_base = hdev->core->cpu_cs_base;
+	void __iomem *wrapper_base = hdev->core->wrapper_base;
 	int ret = 0;
 
-	venus_writel(hdev, VIDC_CTRL_INIT, BIT(VIDC_CTRL_INIT_CTRL_SHIFT));
-	venus_writel(hdev, WRAPPER_INTR_MASK, WRAPPER_INTR_MASK_A2HVCODEC_MASK);
-	venus_writel(hdev, CPU_CS_SCIACMDARG3, 1);
+	if (IS_V6(hdev->core)) {
+		mask_val = readl(wrapper_base + WRAPPER_INTR_MASK);
+		mask_val &= ~(WRAPPER_INTR_MASK_A2HWD_BASK_V6 |
+			      WRAPPER_INTR_MASK_A2HCPU_MASK);
+	} else {
+		mask_val = WRAPPER_INTR_MASK_A2HVCODEC_MASK;
+	}
+	writel(mask_val, wrapper_base + WRAPPER_INTR_MASK);
+	writel(1, cpu_cs_base + CPU_CS_SCIACMDARG3);
 
+	writel(BIT(VIDC_CTRL_INIT_CTRL_SHIFT), cpu_cs_base + VIDC_CTRL_INIT);
 	while (!ctrl_status && count < max_tries) {
-		ctrl_status = venus_readl(hdev, CPU_CS_SCIACMDARG0);
+		ctrl_status = readl(cpu_cs_base + CPU_CS_SCIACMDARG0);
 		if ((ctrl_status & CPU_CS_SCIACMDARG0_ERROR_STATUS_MASK) == 4) {
 			dev_err(dev, "invalid setting for UC_REGION\n");
 			ret = -EINVAL;
@@ -462,15 +463,20 @@ static int venus_boot_core(struct venus_hfi_device *hdev)
 	if (count >= max_tries)
 		ret = -ETIMEDOUT;
 
+	if (IS_V6(hdev->core))
+		writel(0x0, cpu_cs_base + CPU_CS_X2RPMH_V6);
+
 	return ret;
 }
 
 static u32 venus_hwversion(struct venus_hfi_device *hdev)
 {
 	struct device *dev = hdev->core->dev;
-	u32 ver = venus_readl(hdev, WRAPPER_HW_VERSION);
+	void __iomem *wrapper_base = hdev->core->wrapper_base;
+	u32 ver;
 	u32 major, minor, step;
 
+	ver = readl(wrapper_base + WRAPPER_HW_VERSION);
 	major = ver & WRAPPER_HW_VERSION_MAJOR_VERSION_MASK;
 	major = major >> WRAPPER_HW_VERSION_MAJOR_VERSION_SHIFT;
 	minor = ver & WRAPPER_HW_VERSION_MINOR_VERSION_MASK;
@@ -485,6 +491,7 @@ static u32 venus_hwversion(struct venus_hfi_device *hdev)
 static int venus_run(struct venus_hfi_device *hdev)
 {
 	struct device *dev = hdev->core->dev;
+	void __iomem *cpu_cs_base = hdev->core->cpu_cs_base;
 	int ret;
 
 	/*
@@ -493,12 +500,12 @@ static int venus_run(struct venus_hfi_device *hdev)
 	 */
 	venus_set_registers(hdev);
 
-	venus_writel(hdev, UC_REGION_ADDR, hdev->ifaceq_table.da);
-	venus_writel(hdev, UC_REGION_SIZE, SHARED_QSIZE);
-	venus_writel(hdev, CPU_CS_SCIACMDARG2, hdev->ifaceq_table.da);
-	venus_writel(hdev, CPU_CS_SCIACMDARG1, 0x01);
+	writel(hdev->ifaceq_table.da, cpu_cs_base + UC_REGION_ADDR);
+	writel(SHARED_QSIZE, cpu_cs_base + UC_REGION_SIZE);
+	writel(hdev->ifaceq_table.da, cpu_cs_base + CPU_CS_SCIACMDARG2);
+	writel(0x01, cpu_cs_base + CPU_CS_SCIACMDARG1);
 	if (hdev->sfr.da)
-		venus_writel(hdev, SFR_ADDR, hdev->sfr.da);
+		writel(hdev->sfr.da, cpu_cs_base + SFR_ADDR);
 
 	ret = venus_boot_core(hdev);
 	if (ret) {
@@ -513,17 +520,18 @@ static int venus_run(struct venus_hfi_device *hdev)
 
 static int venus_halt_axi(struct venus_hfi_device *hdev)
 {
-	void __iomem *base = hdev->core->base;
+	void __iomem *wrapper_base = hdev->core->wrapper_base;
+	void __iomem *vbif_base = hdev->core->vbif_base;
 	struct device *dev = hdev->core->dev;
 	u32 val;
 	int ret;
 
 	if (IS_V4(hdev->core)) {
-		val = venus_readl(hdev, WRAPPER_CPU_AXI_HALT);
+		val = readl(wrapper_base + WRAPPER_CPU_AXI_HALT);
 		val |= WRAPPER_CPU_AXI_HALT_HALT;
-		venus_writel(hdev, WRAPPER_CPU_AXI_HALT, val);
+		writel(val, wrapper_base + WRAPPER_CPU_AXI_HALT);
 
-		ret = readl_poll_timeout(base + WRAPPER_CPU_AXI_HALT_STATUS,
+		ret = readl_poll_timeout(wrapper_base + WRAPPER_CPU_AXI_HALT_STATUS,
 					 val,
 					 val & WRAPPER_CPU_AXI_HALT_STATUS_IDLE,
 					 POLL_INTERVAL_US,
@@ -537,12 +545,12 @@ static int venus_halt_axi(struct venus_hfi_device *hdev)
 	}
 
 	/* Halt AXI and AXI IMEM VBIF Access */
-	val = venus_readl(hdev, VBIF_AXI_HALT_CTRL0);
+	val = readl(vbif_base + VBIF_AXI_HALT_CTRL0);
 	val |= VBIF_AXI_HALT_CTRL0_HALT_REQ;
-	venus_writel(hdev, VBIF_AXI_HALT_CTRL0, val);
+	writel(val, vbif_base + VBIF_AXI_HALT_CTRL0);
 
 	/* Request for AXI bus port halt */
-	ret = readl_poll_timeout(base + VBIF_AXI_HALT_CTRL1, val,
+	ret = readl_poll_timeout(vbif_base + VBIF_AXI_HALT_CTRL1, val,
 				 val & VBIF_AXI_HALT_CTRL1_HALT_ACK,
 				 POLL_INTERVAL_US,
 				 VBIF_AXI_HALT_ACK_TIMEOUT_US);
@@ -1035,19 +1043,21 @@ static irqreturn_t venus_isr(struct venus_core *core)
 {
 	struct venus_hfi_device *hdev = to_hfi_priv(core);
 	u32 status;
+	void __iomem *cpu_cs_base = hdev->core->cpu_cs_base;
+	void __iomem *wrapper_base = hdev->core->wrapper_base;
 
 	if (!hdev)
 		return IRQ_NONE;
 
-	status = venus_readl(hdev, WRAPPER_INTR_STATUS);
+	status = readl(wrapper_base + WRAPPER_INTR_STATUS);
 
 	if (status & WRAPPER_INTR_STATUS_A2H_MASK ||
 	    status & WRAPPER_INTR_STATUS_A2HWD_MASK ||
 	    status & CPU_CS_SCIACMDARG0_INIT_IDLE_MSG_MASK)
 		hdev->irq_status = status;
 
-	venus_writel(hdev, CPU_CS_A2HSOFTINTCLR, 1);
-	venus_writel(hdev, WRAPPER_INTR_CLEAR, status);
+	writel(1, cpu_cs_base + CPU_CS_A2HSOFTINTCLR);
+	writel(status, wrapper_base + WRAPPER_INTR_CLEAR);
 
 	return IRQ_WAKE_THREAD;
 }
@@ -1380,6 +1390,7 @@ static int venus_suspend_1xx(struct venus_core *core)
 {
 	struct venus_hfi_device *hdev = to_hfi_priv(core);
 	struct device *dev = core->dev;
+	void __iomem *cpu_cs_base = hdev->core->cpu_cs_base;
 	u32 ctrl_status;
 	int ret;
 
@@ -1414,7 +1425,7 @@ static int venus_suspend_1xx(struct venus_core *core)
 		return -EINVAL;
 	}
 
-	ctrl_status = venus_readl(hdev, CPU_CS_SCIACMDARG0);
+	ctrl_status = readl(cpu_cs_base + CPU_CS_SCIACMDARG0);
 	if (!(ctrl_status & CPU_CS_SCIACMDARG0_PC_READY)) {
 		mutex_unlock(&hdev->lock);
 		return -EINVAL;
@@ -1435,10 +1446,12 @@ static int venus_suspend_1xx(struct venus_core *core)
 
 static bool venus_cpu_and_video_core_idle(struct venus_hfi_device *hdev)
 {
+	void __iomem *wrapper_base = hdev->core->wrapper_base;
+	void __iomem *cpu_cs_base = hdev->core->cpu_cs_base;
 	u32 ctrl_status, cpu_status;
 
-	cpu_status = venus_readl(hdev, WRAPPER_CPU_STATUS);
-	ctrl_status = venus_readl(hdev, CPU_CS_SCIACMDARG0);
+	cpu_status = readl(wrapper_base + WRAPPER_CPU_STATUS);
+	ctrl_status = readl(cpu_cs_base + CPU_CS_SCIACMDARG0);
 
 	if (cpu_status & WRAPPER_CPU_STATUS_WFI &&
 	    ctrl_status & CPU_CS_SCIACMDARG0_INIT_IDLE_MSG_MASK)
@@ -1449,10 +1462,12 @@ static bool venus_cpu_and_video_core_idle(struct venus_hfi_device *hdev)
 
 static bool venus_cpu_idle_and_pc_ready(struct venus_hfi_device *hdev)
 {
+	void __iomem *wrapper_base = hdev->core->wrapper_base;
+	void __iomem *cpu_cs_base = hdev->core->cpu_cs_base;
 	u32 ctrl_status, cpu_status;
 
-	cpu_status = venus_readl(hdev, WRAPPER_CPU_STATUS);
-	ctrl_status = venus_readl(hdev, CPU_CS_SCIACMDARG0);
+	cpu_status = readl(wrapper_base + WRAPPER_CPU_STATUS);
+	ctrl_status = readl(cpu_cs_base + CPU_CS_SCIACMDARG0);
 
 	if (cpu_status & WRAPPER_CPU_STATUS_WFI &&
 	    ctrl_status & CPU_CS_SCIACMDARG0_PC_READY)
@@ -1465,6 +1480,7 @@ static int venus_suspend_3xx(struct venus_core *core)
 {
 	struct venus_hfi_device *hdev = to_hfi_priv(core);
 	struct device *dev = core->dev;
+	void __iomem *cpu_cs_base = hdev->core->cpu_cs_base;
 	u32 ctrl_status;
 	bool val;
 	int ret;
@@ -1481,7 +1497,7 @@ static int venus_suspend_3xx(struct venus_core *core)
 		return -EINVAL;
 	}
 
-	ctrl_status = venus_readl(hdev, CPU_CS_SCIACMDARG0);
+	ctrl_status = readl(cpu_cs_base + CPU_CS_SCIACMDARG0);
 	if (ctrl_status & CPU_CS_SCIACMDARG0_PC_READY)
 		goto power_off;
 
diff --git a/drivers/media/platform/qcom/venus/hfi_venus_io.h b/drivers/media/platform/qcom/venus/hfi_venus_io.h
index 3b52f98478db..9cad15eac9e8 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus_io.h
+++ b/drivers/media/platform/qcom/venus/hfi_venus_io.h
@@ -8,27 +8,28 @@
 
 #define VBIF_BASE				0x80000
 
-#define VBIF_AXI_HALT_CTRL0			(VBIF_BASE + 0x208)
-#define VBIF_AXI_HALT_CTRL1			(VBIF_BASE + 0x20c)
+#define VBIF_AXI_HALT_CTRL0			0x208
+#define VBIF_AXI_HALT_CTRL1			0x20c
 
 #define VBIF_AXI_HALT_CTRL0_HALT_REQ		BIT(0)
 #define VBIF_AXI_HALT_CTRL1_HALT_ACK		BIT(0)
 #define VBIF_AXI_HALT_ACK_TIMEOUT_US		500000
 
 #define CPU_BASE				0xc0000
+
 #define CPU_CS_BASE				(CPU_BASE + 0x12000)
 #define CPU_IC_BASE				(CPU_BASE + 0x1f000)
 
-#define CPU_CS_A2HSOFTINTCLR			(CPU_CS_BASE + 0x1c)
+#define CPU_CS_A2HSOFTINTCLR			0x1c
 
-#define VIDC_CTRL_INIT				(CPU_CS_BASE + 0x48)
+#define VIDC_CTRL_INIT				0x48
 #define VIDC_CTRL_INIT_RESERVED_BITS31_1_MASK	0xfffffffe
 #define VIDC_CTRL_INIT_RESERVED_BITS31_1_SHIFT	1
 #define VIDC_CTRL_INIT_CTRL_MASK		0x1
 #define VIDC_CTRL_INIT_CTRL_SHIFT		0
 
 /* HFI control status */
-#define CPU_CS_SCIACMDARG0			(CPU_CS_BASE + 0x4c)
+#define CPU_CS_SCIACMDARG0			0x4c
 #define CPU_CS_SCIACMDARG0_MASK			0xff
 #define CPU_CS_SCIACMDARG0_SHIFT		0x0
 #define CPU_CS_SCIACMDARG0_ERROR_STATUS_MASK	0xfe
@@ -39,42 +40,55 @@
 #define CPU_CS_SCIACMDARG0_INIT_IDLE_MSG_MASK	BIT(30)
 
 /* HFI queue table info */
-#define CPU_CS_SCIACMDARG1			(CPU_CS_BASE + 0x50)
+#define CPU_CS_SCIACMDARG1			0x50
 
 /* HFI queue table address */
-#define CPU_CS_SCIACMDARG2			(CPU_CS_BASE + 0x54)
+#define CPU_CS_SCIACMDARG2			0x54
 
 /* Venus cpu */
-#define CPU_CS_SCIACMDARG3			(CPU_CS_BASE + 0x58)
-
-#define SFR_ADDR				(CPU_CS_BASE + 0x5c)
-#define MMAP_ADDR				(CPU_CS_BASE + 0x60)
-#define UC_REGION_ADDR				(CPU_CS_BASE + 0x64)
-#define UC_REGION_SIZE				(CPU_CS_BASE + 0x68)
-
-#define CPU_IC_SOFTINT				(CPU_IC_BASE + 0x18)
+#define CPU_CS_SCIACMDARG3			0x58
+
+#define SFR_ADDR				0x5c
+#define MMAP_ADDR				0x60
+#define UC_REGION_ADDR				0x64
+#define UC_REGION_SIZE				0x68
+
+#define CPU_CS_H2XSOFTINTEN_V6			0x148
+
+#define CPU_CS_X2RPMH_V6			0x168
+#define CPU_CS_X2RPMH_MASK0_BMSK_V6		0x1
+#define CPU_CS_X2RPMH_MASK0_SHFT_V6		0x0
+#define CPU_CS_X2RPMH_MASK1_BMSK_V6		0x2
+#define CPU_CS_X2RPMH_MASK1_SHFT_V6		0x1
+#define CPU_CS_X2RPMH_SWOVERRIDE_BMSK_V6	0x4
+#define CPU_CS_X2RPMH_SWOVERRIDE_SHFT_V6	0x3
+
+/* Relative to CPU_IC_BASE */
+#define CPU_IC_SOFTINT				0x18
+#define CPU_IC_SOFTINT_V6			0x150
 #define CPU_IC_SOFTINT_H2A_MASK			0x8000
 #define CPU_IC_SOFTINT_H2A_SHIFT		0xf
+#define CPU_IC_SOFTINT_H2A_SHIFT_V6		0x0
 
 /* Venus wrapper */
 #define WRAPPER_BASE				0x000e0000
 
-#define WRAPPER_HW_VERSION			(WRAPPER_BASE + 0x00)
+#define WRAPPER_HW_VERSION			0x00
 #define WRAPPER_HW_VERSION_MAJOR_VERSION_MASK	0x78000000
 #define WRAPPER_HW_VERSION_MAJOR_VERSION_SHIFT	28
 #define WRAPPER_HW_VERSION_MINOR_VERSION_MASK	0xfff0000
 #define WRAPPER_HW_VERSION_MINOR_VERSION_SHIFT	16
 #define WRAPPER_HW_VERSION_STEP_VERSION_MASK	0xffff
 
-#define WRAPPER_CLOCK_CONFIG			(WRAPPER_BASE + 0x04)
+#define WRAPPER_CLOCK_CONFIG			0x04
 
-#define WRAPPER_INTR_STATUS			(WRAPPER_BASE + 0x0c)
+#define WRAPPER_INTR_STATUS			0x0c
 #define WRAPPER_INTR_STATUS_A2HWD_MASK		0x10
 #define WRAPPER_INTR_STATUS_A2HWD_SHIFT		0x4
 #define WRAPPER_INTR_STATUS_A2H_MASK		0x4
 #define WRAPPER_INTR_STATUS_A2H_SHIFT		0x2
 
-#define WRAPPER_INTR_MASK			(WRAPPER_BASE + 0x10)
+#define WRAPPER_INTR_MASK			0x10
 #define WRAPPER_INTR_MASK_A2HWD_BASK		0x10
 #define WRAPPER_INTR_MASK_A2HWD_SHIFT		0x4
 #define WRAPPER_INTR_MASK_A2HVCODEC_MASK	0x8
@@ -82,41 +96,59 @@
 #define WRAPPER_INTR_MASK_A2HCPU_MASK		0x4
 #define WRAPPER_INTR_MASK_A2HCPU_SHIFT		0x2
 
-#define WRAPPER_INTR_CLEAR			(WRAPPER_BASE + 0x14)
+#define WRAPPER_INTR_STATUS_A2HWD_MASK_V6	0x8
+#define WRAPPER_INTR_MASK_A2HWD_BASK_V6		0x8
+
+#define WRAPPER_INTR_CLEAR			0x14
 #define WRAPPER_INTR_CLEAR_A2HWD_MASK		0x10
 #define WRAPPER_INTR_CLEAR_A2HWD_SHIFT		0x4
 #define WRAPPER_INTR_CLEAR_A2H_MASK		0x4
 #define WRAPPER_INTR_CLEAR_A2H_SHIFT		0x2
 
-#define WRAPPER_POWER_STATUS			(WRAPPER_BASE + 0x44)
-#define WRAPPER_VDEC_VCODEC_POWER_CONTROL	(WRAPPER_BASE + 0x48)
-#define WRAPPER_VENC_VCODEC_POWER_CONTROL	(WRAPPER_BASE + 0x4c)
-#define WRAPPER_VDEC_VENC_AHB_BRIDGE_SYNC_RESET	(WRAPPER_BASE + 0x64)
+#define WRAPPER_POWER_STATUS			0x44
+#define WRAPPER_VDEC_VCODEC_POWER_CONTROL	0x48
+#define WRAPPER_VENC_VCODEC_POWER_CONTROL	0x4c
+#define WRAPPER_DEBUG_BRIDGE_LPI_CONTROL_V6	0x54
+#define WRAPPER_DEBUG_BRIDGE_LPI_STATUS_V6	0x58
+#define WRAPPER_VDEC_VENC_AHB_BRIDGE_SYNC_RESET	0x64
 
-#define WRAPPER_CPU_CLOCK_CONFIG		(WRAPPER_BASE + 0x2000)
-#define WRAPPER_CPU_AXI_HALT			(WRAPPER_BASE + 0x2008)
+#define WRAPPER_CPU_CLOCK_CONFIG		0x2000
+#define WRAPPER_CPU_AXI_HALT			0x2008
 #define WRAPPER_CPU_AXI_HALT_HALT		BIT(16)
-#define WRAPPER_CPU_AXI_HALT_STATUS		(WRAPPER_BASE + 0x200c)
+#define WRAPPER_CPU_AXI_HALT_STATUS		0x200c
 #define WRAPPER_CPU_AXI_HALT_STATUS_IDLE	BIT(24)
 
-#define WRAPPER_CPU_CGC_DIS			(WRAPPER_BASE + 0x2010)
-#define WRAPPER_CPU_STATUS			(WRAPPER_BASE + 0x2014)
+#define WRAPPER_CPU_CGC_DIS			0x2010
+#define WRAPPER_CPU_STATUS			0x2014
 #define WRAPPER_CPU_STATUS_WFI			BIT(0)
-#define WRAPPER_SW_RESET			(WRAPPER_BASE + 0x3000)
-#define WRAPPER_CPA_START_ADDR			(WRAPPER_BASE + 0x1020)
-#define WRAPPER_CPA_END_ADDR			(WRAPPER_BASE + 0x1024)
-#define WRAPPER_FW_START_ADDR			(WRAPPER_BASE + 0x1028)
-#define WRAPPER_FW_END_ADDR			(WRAPPER_BASE + 0x102C)
-#define WRAPPER_NONPIX_START_ADDR		(WRAPPER_BASE + 0x1030)
-#define WRAPPER_NONPIX_END_ADDR			(WRAPPER_BASE + 0x1034)
-#define WRAPPER_A9SS_SW_RESET			(WRAPPER_BASE + 0x3000)
+#define WRAPPER_SW_RESET			0x3000
+#define WRAPPER_CPA_START_ADDR			0x1020
+#define WRAPPER_CPA_END_ADDR			0x1024
+#define WRAPPER_FW_START_ADDR			0x1028
+#define WRAPPER_FW_END_ADDR			0x102C
+#define WRAPPER_NONPIX_START_ADDR		0x1030
+#define WRAPPER_NONPIX_END_ADDR			0x1034
+#define WRAPPER_A9SS_SW_RESET			0x3000
 #define WRAPPER_A9SS_SW_RESET_BIT		BIT(4)
 
 /* Venus 4xx */
-#define WRAPPER_VCODEC0_MMCC_POWER_STATUS	(WRAPPER_BASE + 0x90)
-#define WRAPPER_VCODEC0_MMCC_POWER_CONTROL	(WRAPPER_BASE + 0x94)
+#define WRAPPER_VCODEC0_MMCC_POWER_STATUS	0x90
+#define WRAPPER_VCODEC0_MMCC_POWER_CONTROL	0x94
+
+#define WRAPPER_VCODEC1_MMCC_POWER_STATUS	0x110
+#define WRAPPER_VCODEC1_MMCC_POWER_CONTROL	0x114
+
+/* Venus 6xx */
+#define WRAPPER_CORE_POWER_STATUS_V6		0x80
+#define WRAPPER_CORE_POWER_CONTROL_V6		0x84
+
+/* Wrapper TZ 6xx */
+#define WRAPPER_TZ_BASE_V6			0x000c0000
+#define WRAPPER_TZ_CPU_STATUS_V6		0x10
 
-#define WRAPPER_VCODEC1_MMCC_POWER_STATUS	(WRAPPER_BASE + 0x110)
-#define WRAPPER_VCODEC1_MMCC_POWER_CONTROL	(WRAPPER_BASE + 0x114)
+/* Venus AON */
+#define AON_BASE_V6				0x000e0000
+#define AON_WRAPPER_MVP_NOC_LPI_CONTROL		0x00
+#define AON_WRAPPER_MVP_NOC_LPI_STATUS		0x04
 
 #endif
diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
index f7de02352f1b..6bf9c5c319de 100644
--- a/drivers/media/platform/qcom/venus/pm_helpers.c
+++ b/drivers/media/platform/qcom/venus/pm_helpers.c
@@ -304,9 +304,9 @@ vcodec_control_v3(struct venus_core *core, u32 session_type, bool enable)
 	void __iomem *ctrl;
 
 	if (session_type == VIDC_SESSION_TYPE_DEC)
-		ctrl = core->base + WRAPPER_VDEC_VCODEC_POWER_CONTROL;
+		ctrl = core->wrapper_base + WRAPPER_VDEC_VCODEC_POWER_CONTROL;
 	else
-		ctrl = core->base + WRAPPER_VENC_VCODEC_POWER_CONTROL;
+		ctrl = core->wrapper_base + WRAPPER_VENC_VCODEC_POWER_CONTROL;
 
 	if (enable)
 		writel(0, ctrl);
@@ -381,11 +381,11 @@ static int vcodec_control_v4(struct venus_core *core, u32 coreid, bool enable)
 	int ret;
 
 	if (coreid == VIDC_CORE_ID_1) {
-		ctrl = core->base + WRAPPER_VCODEC0_MMCC_POWER_CONTROL;
-		stat = core->base + WRAPPER_VCODEC0_MMCC_POWER_STATUS;
+		ctrl = core->wrapper_base + WRAPPER_VCODEC0_MMCC_POWER_CONTROL;
+		stat = core->wrapper_base + WRAPPER_VCODEC0_MMCC_POWER_STATUS;
 	} else {
-		ctrl = core->base + WRAPPER_VCODEC1_MMCC_POWER_CONTROL;
-		stat = core->base + WRAPPER_VCODEC1_MMCC_POWER_STATUS;
+		ctrl = core->wrapper_base + WRAPPER_VCODEC1_MMCC_POWER_CONTROL;
+		stat = core->wrapper_base + WRAPPER_VCODEC1_MMCC_POWER_STATUS;
 	}
 
 	if (enable) {
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index a49b8fe2a098..be4c2a848b52 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -556,16 +556,18 @@ static void renesas_sdhi_reset(struct tmio_mmc_host *host)
 {
 	struct renesas_sdhi *priv = host_to_priv(host);
 
-	renesas_sdhi_reset_scc(host, priv);
-	renesas_sdhi_reset_hs400_mode(host, priv);
-	priv->needs_adjust_hs400 = false;
+	if (priv->scc_ctl) {
+		renesas_sdhi_reset_scc(host, priv);
+		renesas_sdhi_reset_hs400_mode(host, priv);
+		priv->needs_adjust_hs400 = false;
 
-	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, CLK_CTL_SCLKEN |
-			sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
+		sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, CLK_CTL_SCLKEN |
+				sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
 
-	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_RVSCNTL,
-		       ~SH_MOBILE_SDHI_SCC_RVSCNTL_RVSEN &
-		       sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_RVSCNTL));
+		sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_RVSCNTL,
+			       ~SH_MOBILE_SDHI_SCC_RVSCNTL_RVSEN &
+			       sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_RVSCNTL));
+	}
 
 	if (host->pdata->flags & TMIO_MMC_MIN_RCAR2)
 		sd_ctrl_write32_as_16_and_16(host, CTL_IRQ_MASK,
@@ -1010,11 +1012,9 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 		host->ops.start_signal_voltage_switch =
 			renesas_sdhi_start_signal_voltage_switch;
 		host->sdcard_irq_setbit_mask = TMIO_STAT_ALWAYS_SET_27;
-
-		if (of_data && of_data->scc_offset) {
-			priv->scc_ctl = host->ctl + of_data->scc_offset;
-			host->reset = renesas_sdhi_reset;
-		}
+		host->reset = renesas_sdhi_reset;
+	} else {
+		host->sdcard_irq_mask_all = TMIO_MASK_ALL;
 	}
 
 	/* Orginally registers were 16 bit apart, could be 32 or 64 nowadays */
@@ -1070,10 +1070,6 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 			quirks->hs400_calib_table + 1);
 	}
 
-	ret = tmio_mmc_host_probe(host);
-	if (ret < 0)
-		goto edisclk;
-
 	/* Enable tuning iff we have an SCC and a supported mode */
 	if (of_data && of_data->scc_offset &&
 	    (host->mmc->caps & MMC_CAP_UHS_SDR104 ||
@@ -1098,6 +1094,7 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 		if (!hit)
 			dev_warn(&host->pdev->dev, "Unknown clock rate for tuning\n");
 
+		priv->scc_ctl = host->ctl + of_data->scc_offset;
 		host->check_retune = renesas_sdhi_check_scc_error;
 		host->ops.execute_tuning = renesas_sdhi_execute_tuning;
 		host->ops.prepare_hs400_tuning = renesas_sdhi_prepare_hs400_tuning;
@@ -1105,6 +1102,8 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 		host->ops.hs400_complete = renesas_sdhi_hs400_complete;
 	}
 
+	sd_ctrl_write32_as_16_and_16(host, CTL_IRQ_MASK, host->sdcard_irq_mask_all);
+
 	num_irqs = platform_irq_count(pdev);
 	if (num_irqs < 0) {
 		ret = num_irqs;
@@ -1130,6 +1129,10 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 			goto eirq;
 	}
 
+	ret = tmio_mmc_host_probe(host);
+	if (ret < 0)
+		goto edisclk;
+
 	dev_info(&pdev->dev, "%s base at %pa, max clock rate %u MHz\n",
 		 mmc_hostname(host->mmc), &res->start, host->mmc->f_max / 1000000);
 
diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 9546e542619c..d6ed5e1f8386 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -161,6 +161,7 @@ struct tmio_mmc_host {
 	u32			sdio_irq_mask;
 	unsigned int		clk_cache;
 	u32			sdcard_irq_setbit_mask;
+	u32			sdcard_irq_mask_all;
 
 	spinlock_t		lock;		/* protect host private data */
 	unsigned long		last_req_ts;
diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index ac4e7874a3f1..abf36acb2641 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -1158,7 +1158,9 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host)
 	tmio_mmc_reset(_host);
 
 	_host->sdcard_irq_mask = sd_ctrl_read16_and_16_as_32(_host, CTL_IRQ_MASK);
-	tmio_mmc_disable_mmc_irqs(_host, TMIO_MASK_ALL);
+	if (!_host->sdcard_irq_mask_all)
+		_host->sdcard_irq_mask_all = TMIO_MASK_ALL;
+	tmio_mmc_disable_mmc_irqs(_host, _host->sdcard_irq_mask_all);
 
 	if (_host->native_hotplug)
 		tmio_mmc_enable_mmc_irqs(_host,
@@ -1212,7 +1214,7 @@ void tmio_mmc_host_remove(struct tmio_mmc_host *host)
 	cancel_work_sync(&host->done);
 	cancel_delayed_work_sync(&host->delayed_reset_work);
 	tmio_mmc_release_dma(host);
-	tmio_mmc_disable_mmc_irqs(host, TMIO_MASK_ALL);
+	tmio_mmc_disable_mmc_irqs(host, host->sdcard_irq_mask_all);
 
 	if (host->native_hotplug)
 		pm_runtime_put_noidle(&pdev->dev);
@@ -1242,7 +1244,7 @@ int tmio_mmc_host_runtime_suspend(struct device *dev)
 {
 	struct tmio_mmc_host *host = dev_get_drvdata(dev);
 
-	tmio_mmc_disable_mmc_irqs(host, TMIO_MASK_ALL);
+	tmio_mmc_disable_mmc_irqs(host, host->sdcard_irq_mask_all);
 
 	if (host->clk_cache)
 		host->set_clock(host, 0);
diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
index 929ce489b062..c689bed64628 100644
--- a/drivers/mtd/ubi/build.c
+++ b/drivers/mtd/ubi/build.c
@@ -889,6 +889,13 @@ int ubi_attach_mtd_dev(struct mtd_info *mtd, int ubi_num,
 		return -EINVAL;
 	}
 
+	/* UBI cannot work on flashes with zero erasesize. */
+	if (!mtd->erasesize) {
+		pr_err("ubi: refuse attaching mtd%d - zero erasesize flash is not supported\n",
+			mtd->index);
+		return -EINVAL;
+	}
+
 	if (ubi_num == UBI_DEV_NUM_AUTO) {
 		/* Search for an empty slot in the @ubi_devices array */
 		for (ubi_num = 0; ubi_num < UBI_MAX_DEVICES; ubi_num++)
diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 177151298d72..53fbef9f4ce5 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -2316,14 +2316,16 @@ static void mv88e6xxx_hardware_reset(struct mv88e6xxx_chip *chip)
 		 * from the wrong location resulting in the switch booting
 		 * to wrong mode and inoperable.
 		 */
-		mv88e6xxx_g1_wait_eeprom_done(chip);
+		if (chip->info->ops->get_eeprom)
+			mv88e6xxx_g2_eeprom_wait(chip);
 
 		gpiod_set_value_cansleep(gpiod, 1);
 		usleep_range(10000, 20000);
 		gpiod_set_value_cansleep(gpiod, 0);
 		usleep_range(10000, 20000);
 
-		mv88e6xxx_g1_wait_eeprom_done(chip);
+		if (chip->info->ops->get_eeprom)
+			mv88e6xxx_g2_eeprom_wait(chip);
 	}
 }
 
diff --git a/drivers/net/dsa/mv88e6xxx/global1.c b/drivers/net/dsa/mv88e6xxx/global1.c
index 9936ae69e5ee..ff43d9c9a7eb 100644
--- a/drivers/net/dsa/mv88e6xxx/global1.c
+++ b/drivers/net/dsa/mv88e6xxx/global1.c
@@ -75,37 +75,6 @@ static int mv88e6xxx_g1_wait_init_ready(struct mv88e6xxx_chip *chip)
 	return mv88e6xxx_g1_wait_bit(chip, MV88E6XXX_G1_STS, bit, 1);
 }
 
-void mv88e6xxx_g1_wait_eeprom_done(struct mv88e6xxx_chip *chip)
-{
-	const unsigned long timeout = jiffies + 1 * HZ;
-	u16 val;
-	int err;
-
-	/* Wait up to 1 second for the switch to finish reading the
-	 * EEPROM.
-	 */
-	while (time_before(jiffies, timeout)) {
-		err = mv88e6xxx_g1_read(chip, MV88E6XXX_G1_STS, &val);
-		if (err) {
-			dev_err(chip->dev, "Error reading status");
-			return;
-		}
-
-		/* If the switch is still resetting, it may not
-		 * respond on the bus, and so MDIO read returns
-		 * 0xffff. Differentiate between that, and waiting for
-		 * the EEPROM to be done by bit 0 being set.
-		 */
-		if (val != 0xffff &&
-		    val & BIT(MV88E6XXX_G1_STS_IRQ_EEPROM_DONE))
-			return;
-
-		usleep_range(1000, 2000);
-	}
-
-	dev_err(chip->dev, "Timeout waiting for EEPROM done");
-}
-
 /* Offset 0x01: Switch MAC Address Register Bytes 0 & 1
  * Offset 0x02: Switch MAC Address Register Bytes 2 & 3
  * Offset 0x03: Switch MAC Address Register Bytes 4 & 5
diff --git a/drivers/net/dsa/mv88e6xxx/global1.h b/drivers/net/dsa/mv88e6xxx/global1.h
index e05abe61fa11..1e3546f8b072 100644
--- a/drivers/net/dsa/mv88e6xxx/global1.h
+++ b/drivers/net/dsa/mv88e6xxx/global1.h
@@ -278,7 +278,6 @@ int mv88e6xxx_g1_set_switch_mac(struct mv88e6xxx_chip *chip, u8 *addr);
 int mv88e6185_g1_reset(struct mv88e6xxx_chip *chip);
 int mv88e6352_g1_reset(struct mv88e6xxx_chip *chip);
 int mv88e6250_g1_reset(struct mv88e6xxx_chip *chip);
-void mv88e6xxx_g1_wait_eeprom_done(struct mv88e6xxx_chip *chip);
 
 int mv88e6185_g1_ppu_enable(struct mv88e6xxx_chip *chip);
 int mv88e6185_g1_ppu_disable(struct mv88e6xxx_chip *chip);
diff --git a/drivers/net/dsa/mv88e6xxx/global2.c b/drivers/net/dsa/mv88e6xxx/global2.c
index 75b227d0f73b..8607b2445e1a 100644
--- a/drivers/net/dsa/mv88e6xxx/global2.c
+++ b/drivers/net/dsa/mv88e6xxx/global2.c
@@ -323,7 +323,7 @@ int mv88e6xxx_g2_pot_clear(struct mv88e6xxx_chip *chip)
  * Offset 0x15: EEPROM Addr (for 8-bit data access)
  */
 
-static int mv88e6xxx_g2_eeprom_wait(struct mv88e6xxx_chip *chip)
+int mv88e6xxx_g2_eeprom_wait(struct mv88e6xxx_chip *chip)
 {
 	int bit = __bf_shf(MV88E6XXX_G2_EEPROM_CMD_BUSY);
 	int err;
diff --git a/drivers/net/dsa/mv88e6xxx/global2.h b/drivers/net/dsa/mv88e6xxx/global2.h
index 1f42ee656816..de63e3f08e5c 100644
--- a/drivers/net/dsa/mv88e6xxx/global2.h
+++ b/drivers/net/dsa/mv88e6xxx/global2.h
@@ -349,6 +349,7 @@ int mv88e6xxx_g2_trunk_clear(struct mv88e6xxx_chip *chip);
 
 int mv88e6xxx_g2_device_mapping_write(struct mv88e6xxx_chip *chip, int target,
 				      int port);
+int mv88e6xxx_g2_eeprom_wait(struct mv88e6xxx_chip *chip);
 
 extern const struct mv88e6xxx_irq_ops mv88e6097_watchdog_ops;
 extern const struct mv88e6xxx_irq_ops mv88e6250_watchdog_ops;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index d8366351cf14..c67a108c2c07 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -2404,6 +2404,7 @@ static int bnxt_poll_nitroa0(struct napi_struct *napi, int budget)
 	struct rx_cmp_ext *rxcmp1;
 	u32 cp_cons, tmp_raw_cons;
 	u32 raw_cons = cpr->cp_raw_cons;
+	bool flush_xdp = false;
 	u32 rx_pkts = 0;
 	u8 event = 0;
 
@@ -2438,6 +2439,8 @@ static int bnxt_poll_nitroa0(struct napi_struct *napi, int budget)
 				rx_pkts++;
 			else if (rc == -EBUSY)	/* partial completion */
 				break;
+			if (event & BNXT_REDIRECT_EVENT)
+				flush_xdp = true;
 		} else if (unlikely(TX_CMP_TYPE(txcmp) ==
 				    CMPL_BASE_TYPE_HWRM_DONE)) {
 			bnxt_hwrm_handler(bp, txcmp);
@@ -2457,6 +2460,8 @@ static int bnxt_poll_nitroa0(struct napi_struct *napi, int budget)
 
 	if (event & BNXT_AGG_EVENT)
 		bnxt_db_write(bp, &rxr->rx_agg_db, rxr->rx_agg_prod);
+	if (flush_xdp)
+		xdp_do_flush();
 
 	if (!bnxt_has_work(bp, cpr) && rx_pkts < budget) {
 		napi_complete_done(napi, rx_pkts);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 47f8f66cf7ec..deba485ced1b 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -3125,8 +3125,13 @@ static u32 hclge_check_event_cause(struct hclge_dev *hdev, u32 *clearval)
 static void hclge_clear_event_cause(struct hclge_dev *hdev, u32 event_type,
 				    u32 regclr)
 {
+#define HCLGE_IMP_RESET_DELAY		5
+
 	switch (event_type) {
 	case HCLGE_VECTOR0_EVENT_RST:
+		if (regclr == BIT(HCLGE_VECTOR0_IMPRESET_INT_B))
+			mdelay(HCLGE_IMP_RESET_DELAY);
+
 		hclge_write_dev(&hdev->hw, HCLGE_MISC_RESET_STS_REG, regclr);
 		break;
 	case HCLGE_VECTOR0_EVENT_MBX:
@@ -7850,7 +7855,7 @@ static void hclge_update_overflow_flags(struct hclge_vport *vport,
 	if (mac_type == HCLGE_MAC_ADDR_UC) {
 		if (is_all_added)
 			vport->overflow_promisc_flags &= ~HNAE3_OVERFLOW_UPE;
-		else
+		else if (hclge_is_umv_space_full(vport, true))
 			vport->overflow_promisc_flags |= HNAE3_OVERFLOW_UPE;
 	} else {
 		if (is_all_added)
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index bb2a79b70c3a..dfaa34f2473a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -4332,9 +4332,6 @@ int i40e_ndo_set_vf_port_vlan(struct net_device *netdev, int vf_id,
 		/* duplicate request, so just return success */
 		goto error_pvid;
 
-	i40e_vc_reset_vf(vf, true);
-	/* During reset the VF got a new VSI, so refresh a pointer. */
-	vsi = pf->vsi[vf->lan_vsi_idx];
 	/* Locked once because multiple functions below iterate list */
 	spin_lock_bh(&vsi->mac_filter_hash_lock);
 
@@ -4420,6 +4417,10 @@ int i40e_ndo_set_vf_port_vlan(struct net_device *netdev, int vf_id,
 	 */
 	vf->port_vlan_id = le16_to_cpu(vsi->info.pvid);
 
+	i40e_vc_reset_vf(vf, true);
+	/* During reset the VF got a new VSI, so refresh a pointer. */
+	vsi = pf->vsi[vf->lan_vsi_idx];
+
 	ret = i40e_config_vf_promiscuous_mode(vf, vsi->id, allmulti, alluni);
 	if (ret) {
 		dev_err(&pf->pdev->dev, "Unable to config vf promiscuous mode\n");
diff --git a/drivers/net/ethernet/qlogic/qed/qed_ll2.h b/drivers/net/ethernet/qlogic/qed/qed_ll2.h
index df88d00053a2..efd025d15655 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_ll2.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_ll2.h
@@ -111,9 +111,9 @@ struct qed_ll2_info {
 	enum core_tx_dest tx_dest;
 	u8 tx_stats_en;
 	bool main_func_queue;
+	struct qed_ll2_cbs cbs;
 	struct qed_ll2_rx_queue rx_queue;
 	struct qed_ll2_tx_queue tx_queue;
-	struct qed_ll2_cbs cbs;
 };
 
 extern const struct qed_ll2_ops qed_ll2_ops_pass;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
index 5d4df4c5254e..6623f5a07927 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
@@ -105,6 +105,7 @@ struct stm32_ops {
 	int (*parse_data)(struct stm32_dwmac *dwmac,
 			  struct device *dev);
 	u32 syscfg_eth_mask;
+	bool clk_rx_enable_in_suspend;
 };
 
 static int stm32_dwmac_init(struct plat_stmmacenet_data *plat_dat)
@@ -122,7 +123,8 @@ static int stm32_dwmac_init(struct plat_stmmacenet_data *plat_dat)
 	if (ret)
 		return ret;
 
-	if (!dwmac->dev->power.is_suspended) {
+	if (!dwmac->ops->clk_rx_enable_in_suspend ||
+	    !dwmac->dev->power.is_suspended) {
 		ret = clk_prepare_enable(dwmac->clk_rx);
 		if (ret) {
 			clk_disable_unprepare(dwmac->clk_tx);
@@ -515,7 +517,8 @@ static struct stm32_ops stm32mp1_dwmac_data = {
 	.suspend = stm32mp1_suspend,
 	.resume = stm32mp1_resume,
 	.parse_data = stm32mp1_parse_data,
-	.syscfg_eth_mask = SYSCFG_MP1_ETH_MASK
+	.syscfg_eth_mask = SYSCFG_MP1_ETH_MASK,
+	.clk_rx_enable_in_suspend = true
 };
 
 static const struct of_device_id stm32_dwmac_match[] = {
diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index e4af1f506b83..d10324431354 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -1496,6 +1496,7 @@ static int am65_cpsw_nuss_init_tx_chns(struct am65_cpsw_common *common)
 		if (tx_chn->irq <= 0) {
 			dev_err(dev, "Failed to get tx dma irq %d\n",
 				tx_chn->irq);
+			ret = tx_chn->irq ?: -ENXIO;
 			goto err;
 		}
 
diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
index 721b536ce886..97a77dabed64 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -2122,7 +2122,12 @@ static const struct ethtool_ops team_ethtool_ops = {
 static void team_setup_by_port(struct net_device *dev,
 			       struct net_device *port_dev)
 {
-	dev->header_ops	= port_dev->header_ops;
+	struct team *team = netdev_priv(dev);
+
+	if (port_dev->type == ARPHRD_ETHER)
+		dev->header_ops	= team->header_ops_cache;
+	else
+		dev->header_ops	= port_dev->header_ops;
 	dev->type = port_dev->type;
 	dev->hard_header_len = port_dev->hard_header_len;
 	dev->needed_headroom = port_dev->needed_headroom;
@@ -2169,8 +2174,11 @@ static int team_dev_type_check_change(struct net_device *dev,
 
 static void team_setup(struct net_device *dev)
 {
+	struct team *team = netdev_priv(dev);
+
 	ether_setup(dev);
 	dev->max_mtu = ETH_MAX_MTU;
+	team->header_ops_cache = dev->header_ops;
 
 	dev->netdev_ops = &team_netdev_ops;
 	dev->ethtool_ops = &team_ethtool_ops;
diff --git a/drivers/net/thunderbolt.c b/drivers/net/thunderbolt.c
index 5d96dc1b00b3..e05bcf86306c 100644
--- a/drivers/net/thunderbolt.c
+++ b/drivers/net/thunderbolt.c
@@ -958,12 +958,11 @@ static bool tbnet_xmit_csum_and_map(struct tbnet *net, struct sk_buff *skb,
 		*tucso = ~csum_tcpudp_magic(ip_hdr(skb)->saddr,
 					    ip_hdr(skb)->daddr, 0,
 					    ip_hdr(skb)->protocol, 0);
-	} else if (skb_is_gso_v6(skb)) {
+	} else if (skb_is_gso(skb) && skb_is_gso_v6(skb)) {
 		tucso = dest + ((void *)&(tcp_hdr(skb)->check) - data);
 		*tucso = ~csum_ipv6_magic(&ipv6_hdr(skb)->saddr,
 					  &ipv6_hdr(skb)->daddr, 0,
 					  IPPROTO_TCP, 0);
-		return false;
 	} else if (protocol == htons(ETH_P_IPV6)) {
 		tucso = dest + skb_checksum_start_offset(skb) + skb->csum_offset;
 		*tucso = ~csum_ipv6_magic(&ipv6_hdr(skb)->saddr,
diff --git a/drivers/net/usb/smsc75xx.c b/drivers/net/usb/smsc75xx.c
index fb1389bd0939..6310841aeac7 100644
--- a/drivers/net/usb/smsc75xx.c
+++ b/drivers/net/usb/smsc75xx.c
@@ -90,7 +90,9 @@ static int __must_check __smsc75xx_read_reg(struct usbnet *dev, u32 index,
 	ret = fn(dev, USB_VENDOR_REQUEST_READ_REGISTER, USB_DIR_IN
 		 | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
 		 0, index, &buf, 4);
-	if (unlikely(ret < 0)) {
+	if (unlikely(ret < 4)) {
+		ret = ret < 0 ? ret : -ENODATA;
+
 		netdev_warn(dev->net, "Failed to read reg index 0x%08x: %d\n",
 			    index, ret);
 		return ret;
diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index ae1ae65e7f90..bc3650c70730 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -34,6 +34,8 @@
 #define TDM_PPPOHT_SLIC_MAXIN
 #define RX_BD_ERRORS (R_CD_S | R_OV_S | R_CR_S | R_AB_S | R_NO_S | R_LG_S)
 
+static int uhdlc_close(struct net_device *dev);
+
 static struct ucc_tdm_info utdm_primary_info = {
 	.uf_info = {
 		.tsa = 0,
@@ -708,6 +710,7 @@ static int uhdlc_open(struct net_device *dev)
 	hdlc_device *hdlc = dev_to_hdlc(dev);
 	struct ucc_hdlc_private *priv = hdlc->priv;
 	struct ucc_tdm *utdm = priv->utdm;
+	int rc = 0;
 
 	if (priv->hdlc_busy != 1) {
 		if (request_irq(priv->ut_info->uf_info.irq,
@@ -731,10 +734,13 @@ static int uhdlc_open(struct net_device *dev)
 		napi_enable(&priv->napi);
 		netdev_reset_queue(dev);
 		netif_start_queue(dev);
-		hdlc_open(dev);
+
+		rc = hdlc_open(dev);
+		if (rc)
+			uhdlc_close(dev);
 	}
 
-	return 0;
+	return rc;
 }
 
 static void uhdlc_memclean(struct ucc_hdlc_private *priv)
@@ -824,6 +830,8 @@ static int uhdlc_close(struct net_device *dev)
 	netdev_reset_queue(dev);
 	priv->hdlc_busy = 0;
 
+	hdlc_close(dev);
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h b/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
index cb40f509ab61..d08750abac95 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
@@ -334,9 +334,9 @@ struct iwl_fw_ini_fifo_hdr {
 struct iwl_fw_ini_error_dump_range {
 	__le32 range_data_size;
 	union {
-		__le32 internal_base_addr;
-		__le64 dram_base_addr;
-		__le32 page_num;
+		__le32 internal_base_addr __packed;
+		__le64 dram_base_addr __packed;
+		__le32 page_num __packed;
 		struct iwl_fw_ini_fifo_hdr fifo_hdr;
 		struct iwl_cmd_header fw_pkt_hdr;
 	};
diff --git a/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c b/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
index 1046b59647f5..cbe4a200e4ea 100644
--- a/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
+++ b/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
@@ -977,8 +977,8 @@ void mwifiex_11n_rxba_sync_event(struct mwifiex_private *priv,
 			}
 		}
 
-		tlv_buf_left -= (sizeof(*tlv_rxba) + tlv_len);
-		tmp = (u8 *)tlv_rxba + tlv_len + sizeof(*tlv_rxba);
+		tlv_buf_left -= (sizeof(tlv_rxba->header) + tlv_len);
+		tmp = (u8 *)tlv_rxba  + sizeof(tlv_rxba->header) + tlv_len;
 		tlv_rxba = (struct mwifiex_ie_types_rxba_sync *)tmp;
 	}
 }
diff --git a/drivers/net/wireless/marvell/mwifiex/sta_rx.c b/drivers/net/wireless/marvell/mwifiex/sta_rx.c
index 3c555946cb2c..5b16e330014a 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_rx.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_rx.c
@@ -98,7 +98,8 @@ int mwifiex_process_rx_packet(struct mwifiex_private *priv,
 	rx_pkt_len = le16_to_cpu(local_rx_pd->rx_pkt_length);
 	rx_pkt_hdr = (void *)local_rx_pd + rx_pkt_off;
 
-	if (sizeof(*rx_pkt_hdr) + rx_pkt_off > skb->len) {
+	if (sizeof(rx_pkt_hdr->eth803_hdr) + sizeof(rfc1042_header) +
+	    rx_pkt_off > skb->len) {
 		mwifiex_dbg(priv->adapter, ERROR,
 			    "wrong rx packet offset: len=%d, rx_pkt_off=%d\n",
 			    skb->len, rx_pkt_off);
@@ -107,12 +108,13 @@ int mwifiex_process_rx_packet(struct mwifiex_private *priv,
 		return -1;
 	}
 
-	if ((!memcmp(&rx_pkt_hdr->rfc1042_hdr, bridge_tunnel_header,
-		     sizeof(bridge_tunnel_header))) ||
-	    (!memcmp(&rx_pkt_hdr->rfc1042_hdr, rfc1042_header,
-		     sizeof(rfc1042_header)) &&
-	     ntohs(rx_pkt_hdr->rfc1042_hdr.snap_type) != ETH_P_AARP &&
-	     ntohs(rx_pkt_hdr->rfc1042_hdr.snap_type) != ETH_P_IPX)) {
+	if (sizeof(*rx_pkt_hdr) + rx_pkt_off <= skb->len &&
+	    ((!memcmp(&rx_pkt_hdr->rfc1042_hdr, bridge_tunnel_header,
+		      sizeof(bridge_tunnel_header))) ||
+	     (!memcmp(&rx_pkt_hdr->rfc1042_hdr, rfc1042_header,
+		      sizeof(rfc1042_header)) &&
+	      ntohs(rx_pkt_hdr->rfc1042_hdr.snap_type) != ETH_P_AARP &&
+	      ntohs(rx_pkt_hdr->rfc1042_hdr.snap_type) != ETH_P_IPX))) {
 		/*
 		 *  Replace the 803 header and rfc1042 header (llc/snap) with an
 		 *    EthernetII header, keep the src/dst and snap_type
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.c b/drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.c
index 0acabba2d1a5..5d402cf2951c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.c
@@ -131,15 +131,8 @@ u8 mt76x02_get_lna_gain(struct mt76x02_dev *dev,
 			s8 *lna_2g, s8 *lna_5g,
 			struct ieee80211_channel *chan)
 {
-	u16 val;
 	u8 lna;
 
-	val = mt76x02_eeprom_get(dev, MT_EE_NIC_CONF_1);
-	if (val & MT_EE_NIC_CONF_1_LNA_EXT_2G)
-		*lna_2g = 0;
-	if (val & MT_EE_NIC_CONF_1_LNA_EXT_5G)
-		memset(lna_5g, 0, sizeof(s8) * 3);
-
 	if (chan->band == NL80211_BAND_2GHZ)
 		lna = *lna_2g;
 	else if (chan->hw_value <= 64)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c
index 410ffce3baff..60478116014f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c
@@ -256,7 +256,8 @@ void mt76x2_read_rx_gain(struct mt76x02_dev *dev)
 	struct ieee80211_channel *chan = dev->mphy.chandef.chan;
 	int channel = chan->hw_value;
 	s8 lna_5g[3], lna_2g;
-	u8 lna;
+	bool use_lna;
+	u8 lna = 0;
 	u16 val;
 
 	if (chan->band == NL80211_BAND_2GHZ)
@@ -275,7 +276,15 @@ void mt76x2_read_rx_gain(struct mt76x02_dev *dev)
 	dev->cal.rx.mcu_gain |= (lna_5g[1] & 0xff) << 16;
 	dev->cal.rx.mcu_gain |= (lna_5g[2] & 0xff) << 24;
 
-	lna = mt76x02_get_lna_gain(dev, &lna_2g, lna_5g, chan);
+	val = mt76x02_eeprom_get(dev, MT_EE_NIC_CONF_1);
+	if (chan->band == NL80211_BAND_2GHZ)
+		use_lna = !(val & MT_EE_NIC_CONF_1_LNA_EXT_2G);
+	else
+		use_lna = !(val & MT_EE_NIC_CONF_1_LNA_EXT_5G);
+
+	if (use_lna)
+		lna = mt76x02_get_lna_gain(dev, &lna_2g, lna_5g, chan);
+
 	dev->cal.rx.lna_gain = mt76x02_sign_extend(lna, 8);
 }
 EXPORT_SYMBOL_GPL(mt76x2_read_rx_gain);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 3aaead9b3a57..9c67ebd4eac3 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -387,14 +387,6 @@ static int nvme_pci_npages_sgl(void)
 			NVME_CTRL_PAGE_SIZE);
 }
 
-static size_t nvme_pci_iod_alloc_size(void)
-{
-	size_t npages = max(nvme_pci_npages_prp(), nvme_pci_npages_sgl());
-
-	return sizeof(__le64 *) * npages +
-		sizeof(struct scatterlist) * NVME_MAX_SEGS;
-}
-
 static int nvme_admin_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 				unsigned int hctx_idx)
 {
@@ -2557,6 +2549,22 @@ static void nvme_release_prp_pools(struct nvme_dev *dev)
 	dma_pool_destroy(dev->prp_small_pool);
 }
 
+static int nvme_pci_alloc_iod_mempool(struct nvme_dev *dev)
+{
+	size_t npages = max(nvme_pci_npages_prp(), nvme_pci_npages_sgl());
+	size_t alloc_size = sizeof(__le64 *) * npages +
+			    sizeof(struct scatterlist) * NVME_MAX_SEGS;
+
+	WARN_ON_ONCE(alloc_size > PAGE_SIZE);
+	dev->iod_mempool = mempool_create_node(1,
+			mempool_kmalloc, mempool_kfree,
+			(void *)alloc_size, GFP_KERNEL,
+			dev_to_node(dev->dev));
+	if (!dev->iod_mempool)
+		return -ENOMEM;
+	return 0;
+}
+
 static void nvme_free_tagset(struct nvme_dev *dev)
 {
 	if (dev->tagset.tags)
@@ -2564,6 +2572,7 @@ static void nvme_free_tagset(struct nvme_dev *dev)
 	dev->ctrl.tagset = NULL;
 }
 
+/* pairs with nvme_pci_alloc_dev */
 static void nvme_pci_free_ctrl(struct nvme_ctrl *ctrl)
 {
 	struct nvme_dev *dev = to_nvme_dev(ctrl);
@@ -2840,32 +2849,6 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_ACPI
-static bool nvme_acpi_storage_d3(struct pci_dev *dev)
-{
-	struct acpi_device *adev = ACPI_COMPANION(&dev->dev);
-	u8 val;
-
-	/*
-	 * Look for _DSD property specifying that the storage device on the port
-	 * must use D3 to support deep platform power savings during
-	 * suspend-to-idle.
-	 */
-
-	if (!adev)
-		return false;
-	if (fwnode_property_read_u8(acpi_fwnode_handle(adev), "StorageD3Enable",
-			&val))
-		return false;
-	return val == 1;
-}
-#else
-static inline bool nvme_acpi_storage_d3(struct pci_dev *dev)
-{
-	return false;
-}
-#endif /* CONFIG_ACPI */
-
 static void nvme_async_probe(void *data, async_cookie_t cookie)
 {
 	struct nvme_dev *dev = data;
@@ -2875,20 +2858,20 @@ static void nvme_async_probe(void *data, async_cookie_t cookie)
 	nvme_put_ctrl(&dev->ctrl);
 }
 
-static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
+		const struct pci_device_id *id)
 {
-	int node, result = -ENOMEM;
-	struct nvme_dev *dev;
 	unsigned long quirks = id->driver_data;
-	size_t alloc_size;
-
-	node = dev_to_node(&pdev->dev);
-	if (node == NUMA_NO_NODE)
-		set_dev_node(&pdev->dev, first_memory_node);
+	int node = dev_to_node(&pdev->dev);
+	struct nvme_dev *dev;
+	int ret = -ENOMEM;
 
 	dev = kzalloc_node(sizeof(*dev), GFP_KERNEL, node);
 	if (!dev)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
+	INIT_WORK(&dev->ctrl.reset_work, nvme_reset_work);
+	INIT_WORK(&dev->remove_work, nvme_remove_dead_ctrl_work);
+	mutex_init(&dev->shutdown_lock);
 
 	dev->nr_write_queues = write_queues;
 	dev->nr_poll_queues = poll_queues;
@@ -2896,26 +2879,12 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	dev->queues = kcalloc_node(dev->nr_allocated_queues,
 			sizeof(struct nvme_queue), GFP_KERNEL, node);
 	if (!dev->queues)
-		goto free;
+		goto out_free_dev;
 
 	dev->dev = get_device(&pdev->dev);
-	pci_set_drvdata(pdev, dev);
-
-	result = nvme_dev_map(dev);
-	if (result)
-		goto put_pci;
-
-	INIT_WORK(&dev->ctrl.reset_work, nvme_reset_work);
-	INIT_WORK(&dev->remove_work, nvme_remove_dead_ctrl_work);
-	mutex_init(&dev->shutdown_lock);
-
-	result = nvme_setup_prp_pools(dev);
-	if (result)
-		goto unmap;
 
 	quirks |= check_vendor_combination_bug(pdev);
-
-	if (!noacpi && nvme_acpi_storage_d3(pdev)) {
+	if (!noacpi && acpi_storage_d3(&pdev->dev)) {
 		/*
 		 * Some systems use a bios work around to ask for D3 on
 		 * platforms that support kernel managed suspend.
@@ -2924,46 +2893,54 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 			 "platform quirk: setting simple suspend\n");
 		quirks |= NVME_QUIRK_SIMPLE_SUSPEND;
 	}
+	ret = nvme_init_ctrl(&dev->ctrl, &pdev->dev, &nvme_pci_ctrl_ops,
+			     quirks);
+	if (ret)
+		goto out_put_device;
+	return dev;
 
-	/*
-	 * Double check that our mempool alloc size will cover the biggest
-	 * command we support.
-	 */
-	alloc_size = nvme_pci_iod_alloc_size();
-	WARN_ON_ONCE(alloc_size > PAGE_SIZE);
+out_put_device:
+	put_device(dev->dev);
+	kfree(dev->queues);
+out_free_dev:
+	kfree(dev);
+	return ERR_PTR(ret);
+}
 
-	dev->iod_mempool = mempool_create_node(1, mempool_kmalloc,
-						mempool_kfree,
-						(void *) alloc_size,
-						GFP_KERNEL, node);
-	if (!dev->iod_mempool) {
-		result = -ENOMEM;
-		goto release_pools;
-	}
+static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	struct nvme_dev *dev;
+	int result = -ENOMEM;
 
-	result = nvme_init_ctrl(&dev->ctrl, &pdev->dev, &nvme_pci_ctrl_ops,
-			quirks);
+	dev = nvme_pci_alloc_dev(pdev, id);
+	if (IS_ERR(dev))
+		return PTR_ERR(dev);
+
+	result = nvme_dev_map(dev);
 	if (result)
-		goto release_mempool;
+		goto out_uninit_ctrl;
+
+	result = nvme_setup_prp_pools(dev);
+	if (result)
+		goto out_dev_unmap;
+
+	result = nvme_pci_alloc_iod_mempool(dev);
+	if (result)
+		goto out_release_prp_pools;
 
 	dev_info(dev->ctrl.device, "pci function %s\n", dev_name(&pdev->dev));
+	pci_set_drvdata(pdev, dev);
 
 	nvme_reset_ctrl(&dev->ctrl);
 	async_schedule(nvme_async_probe, dev);
-
 	return 0;
 
- release_mempool:
-	mempool_destroy(dev->iod_mempool);
- release_pools:
+out_release_prp_pools:
 	nvme_release_prp_pools(dev);
- unmap:
+out_dev_unmap:
 	nvme_dev_unmap(dev);
- put_pci:
-	put_device(dev->dev);
- free:
-	kfree(dev->queues);
-	kfree(dev);
+out_uninit_ctrl:
+	nvme_uninit_ctrl(&dev->ctrl);
 	return result;
 }
 
diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index be26346085fa..7d0232af9c23 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -893,13 +893,13 @@ int of_changeset_action(struct of_changeset *ocs, unsigned long action,
 {
 	struct of_changeset_entry *ce;
 
+	if (WARN_ON(action >= ARRAY_SIZE(action_names)))
+		return -EINVAL;
+
 	ce = kzalloc(sizeof(*ce), GFP_KERNEL);
 	if (!ce)
 		return -ENOMEM;
 
-	if (WARN_ON(action >= ARRAY_SIZE(action_names)))
-		return -EINVAL;
-
 	/* get a reference to the node */
 	ce->action = action;
 	ce->np = of_node_get(np);
diff --git a/drivers/parisc/iosapic.c b/drivers/parisc/iosapic.c
index fd99735dca3e..6ef663bbcdb0 100644
--- a/drivers/parisc/iosapic.c
+++ b/drivers/parisc/iosapic.c
@@ -202,9 +202,9 @@ static inline void iosapic_write(void __iomem *iosapic, unsigned int reg, u32 va
 
 static DEFINE_SPINLOCK(iosapic_lock);
 
-static inline void iosapic_eoi(void __iomem *addr, unsigned int data)
+static inline void iosapic_eoi(__le32 __iomem *addr, __le32 data)
 {
-	__raw_writel(data, addr);
+	__raw_writel((__force u32)data, addr);
 }
 
 /*
diff --git a/drivers/parisc/iosapic_private.h b/drivers/parisc/iosapic_private.h
index 73ecc657ad95..bd8ff40162b4 100644
--- a/drivers/parisc/iosapic_private.h
+++ b/drivers/parisc/iosapic_private.h
@@ -118,8 +118,8 @@ struct iosapic_irt {
 struct vector_info {
 	struct iosapic_info *iosapic;	/* I/O SAPIC this vector is on */
 	struct irt_entry *irte;		/* IRT entry */
-	u32 __iomem *eoi_addr;		/* precalculate EOI reg address */
-	u32	eoi_data;		/* IA64: ?       PA: swapped txn_data */
+	__le32 __iomem *eoi_addr;	/* precalculate EOI reg address */
+	__le32	eoi_data;		/* IA64: ?       PA: swapped txn_data */
 	int	txn_irq;		/* virtual IRQ number for processor */
 	ulong	txn_addr;		/* IA64: id_eid  PA: partial HPA */
 	u32	txn_data;		/* CPU interrupt bit */
diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 737cc9d6fa6a..c68e14271c02 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -771,8 +771,6 @@ static int qcom_pcie_get_resources_2_4_0(struct qcom_pcie *pcie)
 			return PTR_ERR(res->phy_ahb_reset);
 	}
 
-	dw_pcie_dbi_ro_wr_dis(pci);
-
 	return 0;
 }
 
diff --git a/drivers/platform/mellanox/Kconfig b/drivers/platform/mellanox/Kconfig
index 916b39dc11bc..1a11d1a441b5 100644
--- a/drivers/platform/mellanox/Kconfig
+++ b/drivers/platform/mellanox/Kconfig
@@ -48,6 +48,7 @@ config MLXBF_BOOTCTL
 	tristate "Mellanox BlueField Firmware Boot Control driver"
 	depends on ARM64
 	depends on ACPI
+	depends on NET
 	help
 	  The Mellanox BlueField firmware implements functionality to
 	  request swapping the primary and alternate eMMC boot partition,
diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
index bdeb888c0fea..84ed82869463 100644
--- a/drivers/platform/x86/intel_scu_ipc.c
+++ b/drivers/platform/x86/intel_scu_ipc.c
@@ -19,6 +19,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 
@@ -232,19 +233,15 @@ static inline u32 ipc_data_readl(struct intel_scu_ipc_dev *scu, u32 offset)
 /* Wait till scu status is busy */
 static inline int busy_loop(struct intel_scu_ipc_dev *scu)
 {
-	unsigned long end = jiffies + IPC_TIMEOUT;
-
-	do {
-		u32 status;
-
-		status = ipc_read_status(scu);
-		if (!(status & IPC_STATUS_BUSY))
-			return (status & IPC_STATUS_ERR) ? -EIO : 0;
+	u8 status;
+	int err;
 
-		usleep_range(50, 100);
-	} while (time_before(jiffies, end));
+	err = readx_poll_timeout(ipc_read_status, scu, status, !(status & IPC_STATUS_BUSY),
+				 100, jiffies_to_usecs(IPC_TIMEOUT));
+	if (err)
+		return err;
 
-	return -ETIMEDOUT;
+	return (status & IPC_STATUS_ERR) ? -EIO : 0;
 }
 
 /* Wait till ipc ioc interrupt is received or timeout in 10 HZ */
@@ -252,10 +249,12 @@ static inline int ipc_wait_for_interrupt(struct intel_scu_ipc_dev *scu)
 {
 	int status;
 
-	if (!wait_for_completion_timeout(&scu->cmd_complete, IPC_TIMEOUT))
-		return -ETIMEDOUT;
+	wait_for_completion_timeout(&scu->cmd_complete, IPC_TIMEOUT);
 
 	status = ipc_read_status(scu);
+	if (status & IPC_STATUS_BUSY)
+		return -ETIMEDOUT;
+
 	if (status & IPC_STATUS_ERR)
 		return -EIO;
 
@@ -267,6 +266,24 @@ static int intel_scu_ipc_check_status(struct intel_scu_ipc_dev *scu)
 	return scu->irq > 0 ? ipc_wait_for_interrupt(scu) : busy_loop(scu);
 }
 
+static struct intel_scu_ipc_dev *intel_scu_ipc_get(struct intel_scu_ipc_dev *scu)
+{
+	u8 status;
+
+	if (!scu)
+		scu = ipcdev;
+	if (!scu)
+		return ERR_PTR(-ENODEV);
+
+	status = ipc_read_status(scu);
+	if (status & IPC_STATUS_BUSY) {
+		dev_dbg(&scu->dev, "device is busy\n");
+		return ERR_PTR(-EBUSY);
+	}
+
+	return scu;
+}
+
 /* Read/Write power control(PMIC in Langwell, MSIC in PenWell) registers */
 static int pwr_reg_rdwr(struct intel_scu_ipc_dev *scu, u16 *addr, u8 *data,
 			u32 count, u32 op, u32 id)
@@ -280,11 +297,10 @@ static int pwr_reg_rdwr(struct intel_scu_ipc_dev *scu, u16 *addr, u8 *data,
 	memset(cbuf, 0, sizeof(cbuf));
 
 	mutex_lock(&ipclock);
-	if (!scu)
-		scu = ipcdev;
-	if (!scu) {
+	scu = intel_scu_ipc_get(scu);
+	if (IS_ERR(scu)) {
 		mutex_unlock(&ipclock);
-		return -ENODEV;
+		return PTR_ERR(scu);
 	}
 
 	for (nc = 0; nc < count; nc++, offset += 2) {
@@ -439,13 +455,12 @@ int intel_scu_ipc_dev_simple_command(struct intel_scu_ipc_dev *scu, int cmd,
 	int err;
 
 	mutex_lock(&ipclock);
-	if (!scu)
-		scu = ipcdev;
-	if (!scu) {
+	scu = intel_scu_ipc_get(scu);
+	if (IS_ERR(scu)) {
 		mutex_unlock(&ipclock);
-		return -ENODEV;
+		return PTR_ERR(scu);
 	}
-	scu = ipcdev;
+
 	cmdval = sub << 12 | cmd;
 	ipc_command(scu, cmdval);
 	err = intel_scu_ipc_check_status(scu);
@@ -485,11 +500,10 @@ int intel_scu_ipc_dev_command_with_size(struct intel_scu_ipc_dev *scu, int cmd,
 		return -EINVAL;
 
 	mutex_lock(&ipclock);
-	if (!scu)
-		scu = ipcdev;
-	if (!scu) {
+	scu = intel_scu_ipc_get(scu);
+	if (IS_ERR(scu)) {
 		mutex_unlock(&ipclock);
-		return -ENODEV;
+		return PTR_ERR(scu);
 	}
 
 	memcpy(inbuf, in, inlen);
diff --git a/drivers/power/supply/ucs1002_power.c b/drivers/power/supply/ucs1002_power.c
index ef673ec3db56..332cb50d9fb4 100644
--- a/drivers/power/supply/ucs1002_power.c
+++ b/drivers/power/supply/ucs1002_power.c
@@ -384,7 +384,8 @@ static int ucs1002_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_USB_TYPE:
 		return ucs1002_get_usb_type(info, val);
 	case POWER_SUPPLY_PROP_HEALTH:
-		return val->intval = info->health;
+		val->intval = info->health;
+		return 0;
 	case POWER_SUPPLY_PROP_PRESENT:
 		val->intval = info->present;
 		return 0;
diff --git a/drivers/s390/scsi/zfcp_aux.c b/drivers/s390/scsi/zfcp_aux.c
index 18b713a616de..36c2bd2016f2 100644
--- a/drivers/s390/scsi/zfcp_aux.c
+++ b/drivers/s390/scsi/zfcp_aux.c
@@ -497,12 +497,12 @@ struct zfcp_port *zfcp_port_enqueue(struct zfcp_adapter *adapter, u64 wwpn,
 	if (port) {
 		put_device(&port->dev);
 		retval = -EEXIST;
-		goto err_out;
+		goto err_put;
 	}
 
 	port = kzalloc(sizeof(struct zfcp_port), GFP_KERNEL);
 	if (!port)
-		goto err_out;
+		goto err_put;
 
 	rwlock_init(&port->unit_list_lock);
 	INIT_LIST_HEAD(&port->unit_list);
@@ -525,7 +525,7 @@ struct zfcp_port *zfcp_port_enqueue(struct zfcp_adapter *adapter, u64 wwpn,
 
 	if (dev_set_name(&port->dev, "0x%016llx", (unsigned long long)wwpn)) {
 		kfree(port);
-		goto err_out;
+		goto err_put;
 	}
 	retval = -EINVAL;
 
@@ -542,7 +542,8 @@ struct zfcp_port *zfcp_port_enqueue(struct zfcp_adapter *adapter, u64 wwpn,
 
 	return port;
 
-err_out:
+err_put:
 	zfcp_ccw_adapter_put(adapter);
+err_out:
 	return ERR_PTR(retval);
 }
diff --git a/drivers/scsi/pm8001/pm8001_hwi.c b/drivers/scsi/pm8001/pm8001_hwi.c
index e9b3485baee0..2b20c6a0293f 100644
--- a/drivers/scsi/pm8001/pm8001_hwi.c
+++ b/drivers/scsi/pm8001/pm8001_hwi.c
@@ -4344,7 +4344,7 @@ pm8001_chip_phy_start_req(struct pm8001_hba_info *pm8001_ha, u8 phy_id)
 	payload.sas_identify.dev_type = SAS_END_DEVICE;
 	payload.sas_identify.initiator_bits = SAS_PROTOCOL_ALL;
 	memcpy(payload.sas_identify.sas_addr,
-		pm8001_ha->sas_addr, SAS_ADDR_SIZE);
+		&pm8001_ha->phy[phy_id].dev_sas_addr, SAS_ADDR_SIZE);
 	payload.sas_identify.phy_id = phy_id;
 	ret = pm8001_mpi_build_cmd(pm8001_ha, circularQ, opcode, &payload,
 			sizeof(payload), 0);
diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
index c98c0a53a018..89051722e04d 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.c
+++ b/drivers/scsi/pm8001/pm80xx_hwi.c
@@ -3722,10 +3722,12 @@ static int mpi_set_controller_config_resp(struct pm8001_hba_info *pm8001_ha,
 			(struct set_ctrl_cfg_resp *)(piomb + 4);
 	u32 status = le32_to_cpu(pPayload->status);
 	u32 err_qlfr_pgcd = le32_to_cpu(pPayload->err_qlfr_pgcd);
+	u32 tag = le32_to_cpu(pPayload->tag);
 
 	pm8001_dbg(pm8001_ha, MSG,
 		   "SET CONTROLLER RESP: status 0x%x qlfr_pgcd 0x%x\n",
 		   status, err_qlfr_pgcd);
+	pm8001_tag_free(pm8001_ha, tag);
 
 	return 0;
 }
@@ -4741,7 +4743,7 @@ pm80xx_chip_phy_start_req(struct pm8001_hba_info *pm8001_ha, u8 phy_id)
 	payload.sas_identify.dev_type = SAS_END_DEVICE;
 	payload.sas_identify.initiator_bits = SAS_PROTOCOL_ALL;
 	memcpy(payload.sas_identify.sas_addr,
-	  &pm8001_ha->sas_addr, SAS_ADDR_SIZE);
+		&pm8001_ha->phy[phy_id].dev_sas_addr, SAS_ADDR_SIZE);
 	payload.sas_identify.phy_id = phy_id;
 	ret = pm8001_mpi_build_cmd(pm8001_ha, circularQ, opcode, &payload,
 			sizeof(payload), 0);
diff --git a/drivers/scsi/qedf/qedf_io.c b/drivers/scsi/qedf/qedf_io.c
index 472374d83ced..1f8e81296beb 100644
--- a/drivers/scsi/qedf/qedf_io.c
+++ b/drivers/scsi/qedf/qedf_io.c
@@ -1924,6 +1924,7 @@ int qedf_initiate_abts(struct qedf_ioreq *io_req, bool return_scsi_cmd_on_abts)
 		goto drop_rdata_kref;
 	}
 
+	spin_lock_irqsave(&fcport->rport_lock, flags);
 	if (!test_bit(QEDF_CMD_OUTSTANDING, &io_req->flags) ||
 	    test_bit(QEDF_CMD_IN_CLEANUP, &io_req->flags) ||
 	    test_bit(QEDF_CMD_IN_ABORT, &io_req->flags)) {
@@ -1931,17 +1932,20 @@ int qedf_initiate_abts(struct qedf_ioreq *io_req, bool return_scsi_cmd_on_abts)
 			 "io_req xid=0x%x sc_cmd=%p already in cleanup or abort processing or already completed.\n",
 			 io_req->xid, io_req->sc_cmd);
 		rc = 1;
+		spin_unlock_irqrestore(&fcport->rport_lock, flags);
 		goto drop_rdata_kref;
 	}
 
+	/* Set the command type to abort */
+	io_req->cmd_type = QEDF_ABTS;
+	spin_unlock_irqrestore(&fcport->rport_lock, flags);
+
 	kref_get(&io_req->refcount);
 
 	xid = io_req->xid;
 	qedf->control_requests++;
 	qedf->packet_aborts++;
 
-	/* Set the command type to abort */
-	io_req->cmd_type = QEDF_ABTS;
 	io_req->return_scsi_cmd_on_abts = return_scsi_cmd_on_abts;
 
 	set_bit(QEDF_CMD_IN_ABORT, &io_req->flags);
@@ -2230,7 +2234,9 @@ int qedf_initiate_cleanup(struct qedf_ioreq *io_req,
 		  refcount, fcport, fcport->rdata->ids.port_id);
 
 	/* Cleanup cmds re-use the same TID as the original I/O */
+	spin_lock_irqsave(&fcport->rport_lock, flags);
 	io_req->cmd_type = QEDF_CLEANUP;
+	spin_unlock_irqrestore(&fcport->rport_lock, flags);
 	io_req->return_scsi_cmd_on_abts = return_scsi_cmd_on_abts;
 
 	init_completion(&io_req->cleanup_done);
diff --git a/drivers/scsi/qedf/qedf_main.c b/drivers/scsi/qedf/qedf_main.c
index 63c9368bafcf..6923862be3fb 100644
--- a/drivers/scsi/qedf/qedf_main.c
+++ b/drivers/scsi/qedf/qedf_main.c
@@ -2803,6 +2803,8 @@ void qedf_process_cqe(struct qedf_ctx *qedf, struct fcoe_cqe *cqe)
 	struct qedf_ioreq *io_req;
 	struct qedf_rport *fcport;
 	u32 comp_type;
+	u8 io_comp_type;
+	unsigned long flags;
 
 	comp_type = (cqe->cqe_data >> FCOE_CQE_CQE_TYPE_SHIFT) &
 	    FCOE_CQE_CQE_TYPE_MASK;
@@ -2836,11 +2838,14 @@ void qedf_process_cqe(struct qedf_ctx *qedf, struct fcoe_cqe *cqe)
 		return;
 	}
 
+	spin_lock_irqsave(&fcport->rport_lock, flags);
+	io_comp_type = io_req->cmd_type;
+	spin_unlock_irqrestore(&fcport->rport_lock, flags);
 
 	switch (comp_type) {
 	case FCOE_GOOD_COMPLETION_CQE_TYPE:
 		atomic_inc(&fcport->free_sqes);
-		switch (io_req->cmd_type) {
+		switch (io_comp_type) {
 		case QEDF_SCSI_CMD:
 			qedf_scsi_completion(qedf, cqe, io_req);
 			break;
diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index bcc0b5a3a459..90b5fbc914ae 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -950,6 +950,13 @@ static int nxp_fspi_default_setup(struct nxp_fspi *f)
 	fspi_writel(f, FSPI_AHBCR_PREF_EN | FSPI_AHBCR_RDADDROPT,
 		 base + FSPI_AHBCR);
 
+	/* Reset the FLSHxCR1 registers. */
+	reg = FSPI_FLSHXCR1_TCSH(0x3) | FSPI_FLSHXCR1_TCSS(0x3);
+	fspi_writel(f, reg, base + FSPI_FLSHA1CR1);
+	fspi_writel(f, reg, base + FSPI_FLSHA2CR1);
+	fspi_writel(f, reg, base + FSPI_FLSHB1CR1);
+	fspi_writel(f, reg, base + FSPI_FLSHB2CR1);
+
 	/* AHB Read - Set lut sequence ID for all CS. */
 	fspi_writel(f, SEQID_LUT, base + FSPI_FLSHA1CR2);
 	fspi_writel(f, SEQID_LUT, base + FSPI_FLSHA2CR2);
diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 3d3ac48243eb..12d9c5d6b9e2 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -1147,11 +1147,16 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 	pm_runtime_set_autosuspend_delay(&pdev->dev, SPI_AUTOSUSPEND_TIMEOUT);
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
+
+	ret = pm_runtime_get_sync(&pdev->dev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to pm_runtime_get_sync: %d\n", ret);
+		goto clk_dis_all;
+	}
+
 	/* QSPI controller initializations */
 	zynqmp_qspi_init_hw(xqspi);
 
-	pm_runtime_mark_last_busy(&pdev->dev);
-	pm_runtime_put_autosuspend(&pdev->dev);
 	xqspi->irq = platform_get_irq(pdev, 0);
 	if (xqspi->irq <= 0) {
 		ret = -ENXIO;
@@ -1178,6 +1183,7 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_RX_DUAL | SPI_RX_QUAD |
 			    SPI_TX_DUAL | SPI_TX_QUAD;
 	ctlr->dev.of_node = np;
+	ctlr->auto_runtime_pm = true;
 
 	ret = devm_spi_register_controller(&pdev->dev, ctlr);
 	if (ret) {
@@ -1185,11 +1191,15 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 		goto clk_dis_all;
 	}
 
+	pm_runtime_mark_last_busy(&pdev->dev);
+	pm_runtime_put_autosuspend(&pdev->dev);
+
 	return 0;
 
 clk_dis_all:
-	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
 	clk_disable_unprepare(xqspi->refclk);
 clk_dis_pclk:
 	clk_disable_unprepare(xqspi->pclk);
@@ -1213,11 +1223,15 @@ static int zynqmp_qspi_remove(struct platform_device *pdev)
 {
 	struct zynqmp_qspi *xqspi = platform_get_drvdata(pdev);
 
+	pm_runtime_get_sync(&pdev->dev);
+
 	zynqmp_gqspi_write(xqspi, GQSPI_EN_OFST, 0x0);
+
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
 	clk_disable_unprepare(xqspi->refclk);
 	clk_disable_unprepare(xqspi->pclk);
-	pm_runtime_set_suspended(&pdev->dev);
-	pm_runtime_disable(&pdev->dev);
 
 	return 0;
 }
diff --git a/drivers/target/target_core_device.c b/drivers/target/target_core_device.c
index 4664330fb55d..9aeedcff7d02 100644
--- a/drivers/target/target_core_device.c
+++ b/drivers/target/target_core_device.c
@@ -867,7 +867,6 @@ sector_t target_to_linux_sector(struct se_device *dev, sector_t lb)
 EXPORT_SYMBOL(target_to_linux_sector);
 
 struct devices_idr_iter {
-	struct config_item *prev_item;
 	int (*fn)(struct se_device *dev, void *data);
 	void *data;
 };
@@ -877,11 +876,9 @@ static int target_devices_idr_iter(int id, void *p, void *data)
 {
 	struct devices_idr_iter *iter = data;
 	struct se_device *dev = p;
+	struct config_item *item;
 	int ret;
 
-	config_item_put(iter->prev_item);
-	iter->prev_item = NULL;
-
 	/*
 	 * We add the device early to the idr, so it can be used
 	 * by backend modules during configuration. We do not want
@@ -891,12 +888,13 @@ static int target_devices_idr_iter(int id, void *p, void *data)
 	if (!target_dev_configured(dev))
 		return 0;
 
-	iter->prev_item = config_item_get_unless_zero(&dev->dev_group.cg_item);
-	if (!iter->prev_item)
+	item = config_item_get_unless_zero(&dev->dev_group.cg_item);
+	if (!item)
 		return 0;
 	mutex_unlock(&device_mutex);
 
 	ret = iter->fn(dev, iter->data);
+	config_item_put(item);
 
 	mutex_lock(&device_mutex);
 	return ret;
@@ -919,7 +917,6 @@ int target_for_each_device(int (*fn)(struct se_device *dev, void *data),
 	mutex_lock(&device_mutex);
 	ret = idr_for_each(&devices_idr, target_devices_idr_iter, &iter);
 	mutex_unlock(&device_mutex);
-	config_item_put(iter.prev_item);
 	return ret;
 }
 
diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 94c963462d74..3693ad9f4521 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2179,10 +2179,8 @@ static void gsm_cleanup_mux(struct gsm_mux *gsm, bool disc)
 
 	/* Free up any link layer users and finally the control channel */
 	for (i = NUM_DLCI - 1; i >= 0; i--)
-		if (gsm->dlci[i]) {
+		if (gsm->dlci[i])
 			gsm_dlci_release(gsm->dlci[i]);
-			gsm->dlci[i] = NULL;
-		}
 	mutex_unlock(&gsm->mutex);
 	/* Now wipe the queues */
 	tty_ldisc_flush(gsm->tty);
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 7499954c9aa7..8b49ac4856d2 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1914,7 +1914,10 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 		skip_rx = true;
 
 	if (status & (UART_LSR_DR | UART_LSR_BI) && !skip_rx) {
-		if (irqd_is_wakeup_set(irq_get_irq_data(port->irq)))
+		struct irq_data *d;
+
+		d = irq_get_irq_data(port->irq);
+		if (d && irqd_is_wakeup_set(d))
 			pm_wakeup_event(tport->tty->dev, 0);
 		if (!up->dma || handle_rx_dma(up, iir))
 			status = serial8250_rx_chars(up, status);
diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 3ac78db17e46..dd5958463097 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -2014,7 +2014,7 @@ config FB_COBALT
 
 config FB_SH7760
 	bool "SH7760/SH7763/SH7720/SH7721 LCDC support"
-	depends on FB && (CPU_SUBTYPE_SH7760 || CPU_SUBTYPE_SH7763 \
+	depends on FB=y && (CPU_SUBTYPE_SH7760 || CPU_SUBTYPE_SH7763 \
 		|| CPU_SUBTYPE_SH7720 || CPU_SUBTYPE_SH7721)
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
index a370a185a41c..50c874d48860 100644
--- a/drivers/watchdog/iTCO_wdt.c
+++ b/drivers/watchdog/iTCO_wdt.c
@@ -426,6 +426,20 @@ static unsigned int iTCO_wdt_get_timeleft(struct watchdog_device *wd_dev)
 	return time_left;
 }
 
+/* Returns true if the watchdog was running */
+static bool iTCO_wdt_set_running(struct iTCO_wdt_private *p)
+{
+	u16 val;
+
+	/* Bit 11: TCO Timer Halt -> 0 = The TCO timer is enabled */
+	val = inw(TCO1_CNT(p));
+	if (!(val & BIT(11))) {
+		set_bit(WDOG_HW_RUNNING, &p->wddev.status);
+		return true;
+	}
+	return false;
+}
+
 /*
  *	Kernel Interfaces
  */
@@ -514,9 +528,6 @@ static int iTCO_wdt_probe(struct platform_device *pdev)
 		return -ENODEV;	/* Cannot reset NO_REBOOT bit */
 	}
 
-	/* Set the NO_REBOOT bit to prevent later reboots, just for sure */
-	p->update_no_reboot_bit(p->no_reboot_priv, true);
-
 	if (turn_SMI_watchdog_clear_off >= p->iTCO_version) {
 		/*
 		 * Bit 13: TCO_EN -> 0
@@ -568,8 +579,13 @@ static int iTCO_wdt_probe(struct platform_device *pdev)
 	watchdog_set_drvdata(&p->wddev, p);
 	platform_set_drvdata(pdev, p);
 
-	/* Make sure the watchdog is not running */
-	iTCO_wdt_stop(&p->wddev);
+	if (!iTCO_wdt_set_running(p)) {
+		/*
+		 * If the watchdog was not running set NO_REBOOT now to
+		 * prevent later reboots.
+		 */
+		p->update_no_reboot_bit(p->no_reboot_priv, true);
+	}
 
 	/* Check that the heartbeat value is within it's range;
 	   if not reset to the default */
diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index fba78daee449..52891546e697 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -33,6 +33,7 @@
 #include <linux/slab.h>
 #include <linux/irqnr.h>
 #include <linux/pci.h>
+#include <linux/rcupdate.h>
 #include <linux/spinlock.h>
 #include <linux/cpuhotplug.h>
 #include <linux/atomic.h>
@@ -94,6 +95,7 @@ enum xen_irq_type {
 struct irq_info {
 	struct list_head list;
 	struct list_head eoi_list;
+	struct rcu_work rwork;
 	short refcnt;
 	short spurious_cnt;
 	short type;             /* type */
@@ -141,23 +143,13 @@ const struct evtchn_ops *evtchn_ops;
  */
 static DEFINE_MUTEX(irq_mapping_update_lock);
 
-/*
- * Lock protecting event handling loop against removing event channels.
- * Adding of event channels is no issue as the associated IRQ becomes active
- * only after everything is setup (before request_[threaded_]irq() the handler
- * can't be entered for an event, as the event channel will be unmasked only
- * then).
- */
-static DEFINE_RWLOCK(evtchn_rwlock);
-
 /*
  * Lock hierarchy:
  *
  * irq_mapping_update_lock
- *   evtchn_rwlock
- *     IRQ-desc lock
- *       percpu eoi_list_lock
- *         irq_info->lock
+ *   IRQ-desc lock
+ *     percpu eoi_list_lock
+ *       irq_info->lock
  */
 
 static LIST_HEAD(xen_irq_list_head);
@@ -272,6 +264,22 @@ static void set_info_for_irq(unsigned int irq, struct irq_info *info)
 		irq_set_chip_data(irq, info);
 }
 
+static void delayed_free_irq(struct work_struct *work)
+{
+	struct irq_info *info = container_of(to_rcu_work(work), struct irq_info,
+					     rwork);
+	unsigned int irq = info->irq;
+
+	/* Remove the info pointer only now, with no potential users left. */
+	set_info_for_irq(irq, NULL);
+
+	kfree(info);
+
+	/* Legacy IRQ descriptors are managed by the arch. */
+	if (irq >= nr_legacy_irqs())
+		irq_free_desc(irq);
+}
+
 /* Constructors for packed IRQ information. */
 static int xen_irq_info_common_setup(struct irq_info *info,
 				     unsigned irq,
@@ -606,33 +614,36 @@ static void xen_irq_lateeoi_worker(struct work_struct *work)
 
 	eoi = container_of(to_delayed_work(work), struct lateeoi_work, delayed);
 
-	read_lock_irqsave(&evtchn_rwlock, flags);
+	rcu_read_lock();
 
 	while (true) {
-		spin_lock(&eoi->eoi_list_lock);
+		spin_lock_irqsave(&eoi->eoi_list_lock, flags);
 
 		info = list_first_entry_or_null(&eoi->eoi_list, struct irq_info,
 						eoi_list);
 
-		if (info == NULL || now < info->eoi_time) {
-			spin_unlock(&eoi->eoi_list_lock);
+		if (info == NULL)
+			break;
+
+		if (now < info->eoi_time) {
+			mod_delayed_work_on(info->eoi_cpu, system_wq,
+					    &eoi->delayed,
+					    info->eoi_time - now);
 			break;
 		}
 
 		list_del_init(&info->eoi_list);
 
-		spin_unlock(&eoi->eoi_list_lock);
+		spin_unlock_irqrestore(&eoi->eoi_list_lock, flags);
 
 		info->eoi_time = 0;
 
 		xen_irq_lateeoi_locked(info, false);
 	}
 
-	if (info)
-		mod_delayed_work_on(info->eoi_cpu, system_wq,
-				    &eoi->delayed, info->eoi_time - now);
+	spin_unlock_irqrestore(&eoi->eoi_list_lock, flags);
 
-	read_unlock_irqrestore(&evtchn_rwlock, flags);
+	rcu_read_unlock();
 }
 
 static void xen_cpu_init_eoi(unsigned int cpu)
@@ -647,16 +658,15 @@ static void xen_cpu_init_eoi(unsigned int cpu)
 void xen_irq_lateeoi(unsigned int irq, unsigned int eoi_flags)
 {
 	struct irq_info *info;
-	unsigned long flags;
 
-	read_lock_irqsave(&evtchn_rwlock, flags);
+	rcu_read_lock();
 
 	info = info_for_irq(irq);
 
 	if (info)
 		xen_irq_lateeoi_locked(info, eoi_flags & XEN_EOI_FLAG_SPURIOUS);
 
-	read_unlock_irqrestore(&evtchn_rwlock, flags);
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL_GPL(xen_irq_lateeoi);
 
@@ -675,6 +685,7 @@ static void xen_irq_init(unsigned irq)
 
 	info->type = IRQT_UNBOUND;
 	info->refcnt = -1;
+	INIT_RCU_WORK(&info->rwork, delayed_free_irq);
 
 	set_info_for_irq(irq, info);
 
@@ -727,31 +738,18 @@ static int __must_check xen_allocate_irq_gsi(unsigned gsi)
 static void xen_free_irq(unsigned irq)
 {
 	struct irq_info *info = info_for_irq(irq);
-	unsigned long flags;
 
 	if (WARN_ON(!info))
 		return;
 
-	write_lock_irqsave(&evtchn_rwlock, flags);
-
 	if (!list_empty(&info->eoi_list))
 		lateeoi_list_del(info);
 
 	list_del(&info->list);
 
-	set_info_for_irq(irq, NULL);
-
 	WARN_ON(info->refcnt > 0);
 
-	write_unlock_irqrestore(&evtchn_rwlock, flags);
-
-	kfree(info);
-
-	/* Legacy IRQ descriptors are managed by the arch. */
-	if (irq < nr_legacy_irqs())
-		return;
-
-	irq_free_desc(irq);
+	queue_rcu_work(system_wq, &info->rwork);
 }
 
 static void xen_evtchn_close(evtchn_port_t port)
@@ -1639,7 +1637,14 @@ static void __xen_evtchn_do_upcall(void)
 	int cpu = smp_processor_id();
 	struct evtchn_loop_ctrl ctrl = { 0 };
 
-	read_lock(&evtchn_rwlock);
+	/*
+	 * When closing an event channel the associated IRQ must not be freed
+	 * until all cpus have left the event handling loop. This is ensured
+	 * by taking the rcu_read_lock() while handling events, as freeing of
+	 * the IRQ is handled via queue_rcu_work() _after_ closing the event
+	 * channel.
+	 */
+	rcu_read_lock();
 
 	do {
 		vcpu_info->evtchn_upcall_pending = 0;
@@ -1652,7 +1657,7 @@ static void __xen_evtchn_do_upcall(void)
 
 	} while (vcpu_info->evtchn_upcall_pending);
 
-	read_unlock(&evtchn_rwlock);
+	rcu_read_unlock();
 
 	/*
 	 * Increment irq_epoch only now to defer EOIs only for
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 8c3b7cc8e2a1..48bb1290ed2f 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -345,10 +345,9 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm)
 	/* there's now no turning back... the old userspace image is dead,
 	 * defunct, deceased, etc.
 	 */
+	SET_PERSONALITY(exec_params.hdr);
 	if (elf_check_fdpic(&exec_params.hdr))
-		set_personality(PER_LINUX_FDPIC);
-	else
-		set_personality(PER_LINUX);
+		current->personality |= PER_LINUX_FDPIC;
 	if (elf_read_implies_exec(&exec_params.hdr, executable_stack))
 		current->personality |= READ_IMPLIES_EXEC;
 
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 0e266772beae..685a375bb6af 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5634,8 +5634,14 @@ void read_extent_buffer(const struct extent_buffer *eb, void *dstv,
 	char *dst = (char *)dstv;
 	unsigned long i = start >> PAGE_SHIFT;
 
-	if (check_eb_range(eb, start, len))
+	if (check_eb_range(eb, start, len)) {
+		/*
+		 * Invalid range hit, reset the memory, so callers won't get
+		 * some random garbage for their uninitialzed memory.
+		 */
+		memset(dstv, 0, len);
 		return;
+	}
 
 	offset = offset_in_page(start);
 
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index b33505330e33..ea731fa8bd35 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2267,7 +2267,7 @@ static int btrfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	 * calculated f_bavail.
 	 */
 	if (!mixed && block_rsv->space_info->full &&
-	    total_free_meta - thresh < block_rsv->size)
+	    (total_free_meta < thresh || total_free_meta - thresh < block_rsv->size))
 		buf->f_bavail = 0;
 
 	buf->f_type = BTRFS_SUPER_MAGIC;
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index c3e9cb503763..fec021e6bb60 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1580,7 +1580,7 @@ struct ext4_sb_info {
 	struct task_struct *s_mmp_tsk;
 
 	/* record the last minlen when FITRIM is called. */
-	atomic_t s_last_trim_minblks;
+	unsigned long s_last_trim_minblks;
 
 	/* Reference to checksum algorithm driver via cryptoapi */
 	struct crypto_shash *s_chksum_driver;
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 2f6ed59d81f0..b35d59d41c89 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 #include <linux/nospec.h>
 #include <linux/backing-dev.h>
+#include <linux/freezer.h>
 #include <trace/events/ext4.h>
 
 /*
@@ -5859,19 +5860,19 @@ int ext4_group_add_blocks(handle_t *handle, struct super_block *sb,
  * @sb:		super block for the file system
  * @start:	starting block of the free extent in the alloc. group
  * @count:	number of blocks to TRIM
- * @group:	alloc. group we are working with
  * @e4b:	ext4 buddy for the group
  *
  * Trim "count" blocks starting at "start" in the "group". To assure that no
  * one will allocate those blocks, mark it as used in buddy bitmap. This must
  * be called with under the group lock.
  */
-static int ext4_trim_extent(struct super_block *sb, int start, int count,
-			     ext4_group_t group, struct ext4_buddy *e4b)
+static int ext4_trim_extent(struct super_block *sb,
+		int start, int count, struct ext4_buddy *e4b)
 __releases(bitlock)
 __acquires(bitlock)
 {
 	struct ext4_free_extent ex;
+	ext4_group_t group = e4b->bd_group;
 	int ret = 0;
 
 	trace_ext4_trim_extent(sb, group, start, count);
@@ -5894,6 +5895,71 @@ __acquires(bitlock)
 	return ret;
 }
 
+static ext4_grpblk_t ext4_last_grp_cluster(struct super_block *sb,
+					   ext4_group_t grp)
+{
+	if (grp < ext4_get_groups_count(sb))
+		return EXT4_CLUSTERS_PER_GROUP(sb) - 1;
+	return (ext4_blocks_count(EXT4_SB(sb)->s_es) -
+		ext4_group_first_block_no(sb, grp) - 1) >>
+					EXT4_CLUSTER_BITS(sb);
+}
+
+static bool ext4_trim_interrupted(void)
+{
+	return fatal_signal_pending(current) || freezing(current);
+}
+
+static int ext4_try_to_trim_range(struct super_block *sb,
+		struct ext4_buddy *e4b, ext4_grpblk_t start,
+		ext4_grpblk_t max, ext4_grpblk_t minblocks)
+{
+	ext4_grpblk_t next, count, free_count;
+	bool set_trimmed = false;
+	void *bitmap;
+
+	bitmap = e4b->bd_bitmap;
+	if (start == 0 && max >= ext4_last_grp_cluster(sb, e4b->bd_group))
+		set_trimmed = true;
+	start = max(e4b->bd_info->bb_first_free, start);
+	count = 0;
+	free_count = 0;
+
+	while (start <= max) {
+		start = mb_find_next_zero_bit(bitmap, max + 1, start);
+		if (start > max)
+			break;
+		next = mb_find_next_bit(bitmap, max + 1, start);
+
+		if ((next - start) >= minblocks) {
+			int ret = ext4_trim_extent(sb, start, next - start, e4b);
+
+			if (ret && ret != -EOPNOTSUPP)
+				return count;
+			count += next - start;
+		}
+		free_count += next - start;
+		start = next + 1;
+
+		if (ext4_trim_interrupted())
+			return count;
+
+		if (need_resched()) {
+			ext4_unlock_group(sb, e4b->bd_group);
+			cond_resched();
+			ext4_lock_group(sb, e4b->bd_group);
+		}
+
+		if ((e4b->bd_info->bb_free - free_count) < minblocks)
+			break;
+	}
+
+	if (set_trimmed)
+		EXT4_MB_GRP_SET_TRIMMED(e4b->bd_info);
+
+	return count;
+}
+
 /**
  * ext4_trim_all_free -- function to trim all free space in alloc. group
  * @sb:			super block for file system
@@ -5917,10 +5983,8 @@ ext4_trim_all_free(struct super_block *sb, ext4_group_t group,
 		   ext4_grpblk_t start, ext4_grpblk_t max,
 		   ext4_grpblk_t minblocks)
 {
-	void *bitmap;
-	ext4_grpblk_t next, count = 0, free_count = 0;
 	struct ext4_buddy e4b;
-	int ret = 0;
+	int ret;
 
 	trace_ext4_trim_all_free(sb, group, start, max);
 
@@ -5930,58 +5994,20 @@ ext4_trim_all_free(struct super_block *sb, ext4_group_t group,
 			     ret, group);
 		return ret;
 	}
-	bitmap = e4b.bd_bitmap;
 
 	ext4_lock_group(sb, group);
-	if (EXT4_MB_GRP_WAS_TRIMMED(e4b.bd_info) &&
-	    minblocks >= atomic_read(&EXT4_SB(sb)->s_last_trim_minblks))
-		goto out;
 
-	start = (e4b.bd_info->bb_first_free > start) ?
-		e4b.bd_info->bb_first_free : start;
-
-	while (start <= max) {
-		start = mb_find_next_zero_bit(bitmap, max + 1, start);
-		if (start > max)
-			break;
-		next = mb_find_next_bit(bitmap, max + 1, start);
-
-		if ((next - start) >= minblocks) {
-			ret = ext4_trim_extent(sb, start,
-					       next - start, group, &e4b);
-			if (ret && ret != -EOPNOTSUPP)
-				break;
-			ret = 0;
-			count += next - start;
-		}
-		free_count += next - start;
-		start = next + 1;
-
-		if (fatal_signal_pending(current)) {
-			count = -ERESTARTSYS;
-			break;
-		}
-
-		if (need_resched()) {
-			ext4_unlock_group(sb, group);
-			cond_resched();
-			ext4_lock_group(sb, group);
-		}
-
-		if ((e4b.bd_info->bb_free - free_count) < minblocks)
-			break;
-	}
+	if (!EXT4_MB_GRP_WAS_TRIMMED(e4b.bd_info) ||
+	    minblocks < EXT4_SB(sb)->s_last_trim_minblks)
+		ret = ext4_try_to_trim_range(sb, &e4b, start, max, minblocks);
+	else
+		ret = 0;
 
-	if (!ret) {
-		ret = count;
-		EXT4_MB_GRP_SET_TRIMMED(e4b.bd_info);
-	}
-out:
 	ext4_unlock_group(sb, group);
 	ext4_mb_unload_buddy(&e4b);
 
 	ext4_debug("trimmed %d blocks in the group %d\n",
-		count, group);
+		ret, group);
 
 	return ret;
 }
@@ -6026,7 +6052,7 @@ int ext4_trim_fs(struct super_block *sb, struct fstrim_range *range)
 		if (minlen > EXT4_CLUSTERS_PER_GROUP(sb))
 			goto out;
 	}
-	if (end >= max_blks)
+	if (end >= max_blks - 1)
 		end = max_blks - 1;
 	if (end <= first_data_blk)
 		goto out;
@@ -6043,6 +6069,8 @@ int ext4_trim_fs(struct super_block *sb, struct fstrim_range *range)
 	end = EXT4_CLUSTERS_PER_GROUP(sb) - 1;
 
 	for (group = first_group; group <= last_group; group++) {
+		if (ext4_trim_interrupted())
+			break;
 		grp = ext4_get_group_info(sb, group);
 		if (!grp)
 			continue;
@@ -6061,10 +6089,9 @@ int ext4_trim_fs(struct super_block *sb, struct fstrim_range *range)
 		 */
 		if (group == last_group)
 			end = last_cluster;
-
 		if (grp->bb_free >= minlen) {
 			cnt = ext4_trim_all_free(sb, group, first_cluster,
-						end, minlen);
+						 end, minlen);
 			if (cnt < 0) {
 				ret = cnt;
 				break;
@@ -6080,7 +6107,7 @@ int ext4_trim_fs(struct super_block *sb, struct fstrim_range *range)
 	}
 
 	if (!ret)
-		atomic_set(&EXT4_SB(sb)->s_last_trim_minblks, minlen);
+		EXT4_SB(sb)->s_last_trim_minblks = minlen;
 
 out:
 	range->len = EXT4_C2B(EXT4_SB(sb), trimmed) << sb->s_blocksize_bits;
@@ -6109,8 +6136,7 @@ ext4_mballoc_query_range(
 
 	ext4_lock_group(sb, group);
 
-	start = (e4b.bd_info->bb_first_free > start) ?
-		e4b.bd_info->bb_first_free : start;
+	start = max(e4b.bd_info->bb_first_free, start);
 	if (end >= EXT4_CLUSTERS_PER_GROUP(sb))
 		end = EXT4_CLUSTERS_PER_GROUP(sb) - 1;
 
diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 018af6ec97b4..5d86ffa72cea 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -525,7 +525,9 @@ static void nfs_direct_add_page_head(struct list_head *list,
 	kref_get(&head->wb_kref);
 }
 
-static void nfs_direct_join_group(struct list_head *list, struct inode *inode)
+static void nfs_direct_join_group(struct list_head *list,
+				  struct nfs_commit_info *cinfo,
+				  struct inode *inode)
 {
 	struct nfs_page *req, *subreq;
 
@@ -547,7 +549,7 @@ static void nfs_direct_join_group(struct list_head *list, struct inode *inode)
 				nfs_release_request(subreq);
 			}
 		} while ((subreq = subreq->wb_this_page) != req);
-		nfs_join_page_group(req, inode);
+		nfs_join_page_group(req, cinfo, inode);
 	}
 }
 
@@ -573,7 +575,7 @@ static void nfs_direct_write_reschedule(struct nfs_direct_req *dreq)
 	nfs_init_cinfo_from_dreq(&cinfo, dreq);
 	nfs_direct_write_scan_commit_list(dreq->inode, &reqs, &cinfo);
 
-	nfs_direct_join_group(&reqs, dreq->inode);
+	nfs_direct_join_group(&reqs, &cinfo, dreq->inode);
 
 	dreq->count = 0;
 	dreq->max_count = 0;
diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index a8a02081942d..e4f2820ba5a5 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -1240,6 +1240,7 @@ static void ff_layout_io_track_ds_error(struct pnfs_layout_segment *lseg,
 		case -EPFNOSUPPORT:
 		case -EPROTONOSUPPORT:
 		case -EOPNOTSUPP:
+		case -EINVAL:
 		case -ECONNREFUSED:
 		case -ECONNRESET:
 		case -EHOSTDOWN:
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index c34df51a8f2b..1c2ed14bccef 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -10408,7 +10408,9 @@ static void nfs4_disable_swap(struct inode *inode)
 	 */
 	struct nfs_client *clp = NFS_SERVER(inode)->nfs_client;
 
-	nfs4_schedule_state_manager(clp);
+	set_bit(NFS4CLNT_RUN_MANAGER, &clp->cl_state);
+	clear_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_state);
+	wake_up_var(&clp->cl_state);
 }
 
 static const struct inode_operations nfs4_dir_inode_operations = {
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index ff6ca05a9d44..afb617a4a7e4 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -1212,17 +1212,23 @@ void nfs4_schedule_state_manager(struct nfs_client *clp)
 {
 	struct task_struct *task;
 	char buf[INET6_ADDRSTRLEN + sizeof("-manager") + 1];
-	struct rpc_clnt *cl = clp->cl_rpcclient;
-
-	while (cl != cl->cl_parent)
-		cl = cl->cl_parent;
+	struct rpc_clnt *clnt = clp->cl_rpcclient;
+	bool swapon = false;
 
 	set_bit(NFS4CLNT_RUN_MANAGER, &clp->cl_state);
-	if (test_and_set_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_state) != 0) {
-		wake_up_var(&clp->cl_state);
-		return;
+
+	if (atomic_read(&clnt->cl_swapper)) {
+		swapon = !test_and_set_bit(NFS4CLNT_MANAGER_AVAILABLE,
+					   &clp->cl_state);
+		if (!swapon) {
+			wake_up_var(&clp->cl_state);
+			return;
+		}
 	}
-	set_bit(NFS4CLNT_MANAGER_RUNNING, &clp->cl_state);
+
+	if (test_and_set_bit(NFS4CLNT_MANAGER_RUNNING, &clp->cl_state) != 0)
+		return;
+
 	__module_get(THIS_MODULE);
 	refcount_inc(&clp->cl_count);
 
@@ -1239,8 +1245,9 @@ void nfs4_schedule_state_manager(struct nfs_client *clp)
 			__func__, PTR_ERR(task));
 		if (!nfs_client_init_is_complete(clp))
 			nfs_mark_client_ready(clp, PTR_ERR(task));
+		if (swapon)
+			clear_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_state);
 		nfs4_clear_state_manager_bit(clp);
-		clear_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_state);
 		nfs_put_client(clp);
 		module_put(THIS_MODULE);
 	}
@@ -2683,6 +2690,13 @@ static void nfs4_state_manager(struct nfs_client *clp)
 		nfs4_end_drain_session(clp);
 		nfs4_clear_state_manager_bit(clp);
 
+		if (test_bit(NFS4CLNT_RUN_MANAGER, &clp->cl_state) &&
+		    !test_and_set_bit(NFS4CLNT_MANAGER_RUNNING,
+				      &clp->cl_state)) {
+			memflags = memalloc_nofs_save();
+			continue;
+		}
+
 		if (!test_and_set_bit(NFS4CLNT_RECALL_RUNNING, &clp->cl_state)) {
 			if (test_and_clear_bit(NFS4CLNT_DELEGRETURN, &clp->cl_state)) {
 				nfs_client_return_marked_delegations(clp);
@@ -2721,22 +2735,25 @@ static int nfs4_run_state_manager(void *ptr)
 
 	allow_signal(SIGKILL);
 again:
-	set_bit(NFS4CLNT_MANAGER_RUNNING, &clp->cl_state);
 	nfs4_state_manager(clp);
-	if (atomic_read(&cl->cl_swapper)) {
+
+	if (test_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_state) &&
+	    !test_bit(NFS4CLNT_MANAGER_RUNNING, &clp->cl_state)) {
 		wait_var_event_interruptible(&clp->cl_state,
 					     test_bit(NFS4CLNT_RUN_MANAGER,
 						      &clp->cl_state));
-		if (atomic_read(&cl->cl_swapper) &&
-		    test_bit(NFS4CLNT_RUN_MANAGER, &clp->cl_state))
+		if (!atomic_read(&cl->cl_swapper))
+			clear_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_state);
+		if (refcount_read(&clp->cl_count) > 1 && !signalled() &&
+		    !test_and_set_bit(NFS4CLNT_MANAGER_RUNNING, &clp->cl_state))
 			goto again;
 		/* Either no longer a swapper, or were signalled */
+		clear_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_state);
 	}
-	clear_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_state);
 
 	if (refcount_read(&clp->cl_count) > 1 && !signalled() &&
 	    test_bit(NFS4CLNT_RUN_MANAGER, &clp->cl_state) &&
-	    !test_and_set_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_state))
+	    !test_and_set_bit(NFS4CLNT_MANAGER_RUNNING, &clp->cl_state))
 		goto again;
 
 	nfs_put_client(clp);
diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
index 8cb70755e3c9..f7f778e3e5ca 100644
--- a/fs/nfs/sysfs.c
+++ b/fs/nfs/sysfs.c
@@ -18,7 +18,7 @@
 #include "sysfs.h"
 
 struct kobject *nfs_client_kobj;
-static struct kset *nfs_client_kset;
+static struct kset *nfs_kset;
 
 static void nfs_netns_object_release(struct kobject *kobj)
 {
@@ -55,13 +55,13 @@ static struct kobject *nfs_netns_object_alloc(const char *name,
 
 int nfs_sysfs_init(void)
 {
-	nfs_client_kset = kset_create_and_add("nfs", NULL, fs_kobj);
-	if (!nfs_client_kset)
+	nfs_kset = kset_create_and_add("nfs", NULL, fs_kobj);
+	if (!nfs_kset)
 		return -ENOMEM;
-	nfs_client_kobj = nfs_netns_object_alloc("net", nfs_client_kset, NULL);
+	nfs_client_kobj = nfs_netns_object_alloc("net", nfs_kset, NULL);
 	if  (!nfs_client_kobj) {
-		kset_unregister(nfs_client_kset);
-		nfs_client_kset = NULL;
+		kset_unregister(nfs_kset);
+		nfs_kset = NULL;
 		return -ENOMEM;
 	}
 	return 0;
@@ -70,7 +70,7 @@ int nfs_sysfs_init(void)
 void nfs_sysfs_exit(void)
 {
 	kobject_put(nfs_client_kobj);
-	kset_unregister(nfs_client_kset);
+	kset_unregister(nfs_kset);
 }
 
 static ssize_t nfs_netns_identifier_show(struct kobject *kobj,
@@ -158,7 +158,7 @@ static struct nfs_netns_client *nfs_netns_client_alloc(struct kobject *parent,
 	p = kzalloc(sizeof(*p), GFP_KERNEL);
 	if (p) {
 		p->net = net;
-		p->kobject.kset = nfs_client_kset;
+		p->kobject.kset = nfs_kset;
 		if (kobject_init_and_add(&p->kobject, &nfs_netns_client_type,
 					parent, "nfs_client") == 0)
 			return p;
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index dc08a0c02f09..d3cd099ffb6e 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -58,7 +58,8 @@ static const struct nfs_pgio_completion_ops nfs_async_write_completion_ops;
 static const struct nfs_commit_completion_ops nfs_commit_completion_ops;
 static const struct nfs_rw_ops nfs_rw_write_ops;
 static void nfs_inode_remove_request(struct nfs_page *req);
-static void nfs_clear_request_commit(struct nfs_page *req);
+static void nfs_clear_request_commit(struct nfs_commit_info *cinfo,
+				     struct nfs_page *req);
 static void nfs_init_cinfo_from_inode(struct nfs_commit_info *cinfo,
 				      struct inode *inode);
 static struct nfs_page *
@@ -500,8 +501,8 @@ nfs_destroy_unlinked_subrequests(struct nfs_page *destroy_list,
  * the (former) group.  All subrequests are removed from any write or commit
  * lists, unlinked from the group and destroyed.
  */
-void
-nfs_join_page_group(struct nfs_page *head, struct inode *inode)
+void nfs_join_page_group(struct nfs_page *head, struct nfs_commit_info *cinfo,
+			 struct inode *inode)
 {
 	struct nfs_page *subreq;
 	struct nfs_page *destroy_list = NULL;
@@ -531,7 +532,7 @@ nfs_join_page_group(struct nfs_page *head, struct inode *inode)
 	 * Commit list removal accounting is done after locks are dropped */
 	subreq = head;
 	do {
-		nfs_clear_request_commit(subreq);
+		nfs_clear_request_commit(cinfo, subreq);
 		subreq = subreq->wb_this_page;
 	} while (subreq != head);
 
@@ -565,8 +566,10 @@ nfs_lock_and_join_requests(struct page *page)
 {
 	struct inode *inode = page_file_mapping(page)->host;
 	struct nfs_page *head;
+	struct nfs_commit_info cinfo;
 	int ret;
 
+	nfs_init_cinfo_from_inode(&cinfo, inode);
 	/*
 	 * A reference is taken only on the head request which acts as a
 	 * reference to the whole page group - the group will not be destroyed
@@ -583,7 +586,7 @@ nfs_lock_and_join_requests(struct page *page)
 		return ERR_PTR(ret);
 	}
 
-	nfs_join_page_group(head, inode);
+	nfs_join_page_group(head, &cinfo, inode);
 
 	return head;
 }
@@ -944,18 +947,16 @@ nfs_clear_page_commit(struct page *page)
 }
 
 /* Called holding the request lock on @req */
-static void
-nfs_clear_request_commit(struct nfs_page *req)
+static void nfs_clear_request_commit(struct nfs_commit_info *cinfo,
+				     struct nfs_page *req)
 {
 	if (test_bit(PG_CLEAN, &req->wb_flags)) {
 		struct nfs_open_context *ctx = nfs_req_openctx(req);
 		struct inode *inode = d_inode(ctx->dentry);
-		struct nfs_commit_info cinfo;
 
-		nfs_init_cinfo_from_inode(&cinfo, inode);
 		mutex_lock(&NFS_I(inode)->commit_mutex);
-		if (!pnfs_clear_request_commit(req, &cinfo)) {
-			nfs_request_remove_commit_list(req, &cinfo);
+		if (!pnfs_clear_request_commit(req, cinfo)) {
+			nfs_request_remove_commit_list(req, cinfo);
 		}
 		mutex_unlock(&NFS_I(inode)->commit_mutex);
 		nfs_clear_page_commit(req->wb_page);
diff --git a/fs/nilfs2/gcinode.c b/fs/nilfs2/gcinode.c
index aadea660c66c..b0077f5f7112 100644
--- a/fs/nilfs2/gcinode.c
+++ b/fs/nilfs2/gcinode.c
@@ -73,10 +73,8 @@ int nilfs_gccache_submit_read_data(struct inode *inode, sector_t blkoff,
 		struct the_nilfs *nilfs = inode->i_sb->s_fs_info;
 
 		err = nilfs_dat_translate(nilfs->ns_dat, vbn, &pbn);
-		if (unlikely(err)) { /* -EIO, -ENOMEM, -ENOENT */
-			brelse(bh);
+		if (unlikely(err)) /* -EIO, -ENOMEM, -ENOENT */
 			goto failed;
-		}
 	}
 
 	lock_buffer(bh);
@@ -102,6 +100,8 @@ int nilfs_gccache_submit_read_data(struct inode *inode, sector_t blkoff,
  failed:
 	unlock_page(bh->b_page);
 	put_page(bh->b_page);
+	if (unlikely(err))
+		brelse(bh);
 	return err;
 }
 
diff --git a/fs/proc/task_nommu.c b/fs/proc/task_nommu.c
index a6d21fc0033c..97f387d30e74 100644
--- a/fs/proc/task_nommu.c
+++ b/fs/proc/task_nommu.c
@@ -208,11 +208,16 @@ static void *m_start(struct seq_file *m, loff_t *pos)
 		return ERR_PTR(-ESRCH);
 
 	mm = priv->mm;
-	if (!mm || !mmget_not_zero(mm))
+	if (!mm || !mmget_not_zero(mm)) {
+		put_task_struct(priv->task);
+		priv->task = NULL;
 		return NULL;
+	}
 
 	if (mmap_read_lock_killable(mm)) {
 		mmput(mm);
+		put_task_struct(priv->task);
+		priv->task = NULL;
 		return ERR_PTR(-EINTR);
 	}
 
@@ -221,23 +226,21 @@ static void *m_start(struct seq_file *m, loff_t *pos)
 		if (n-- == 0)
 			return p;
 
-	mmap_read_unlock(mm);
-	mmput(mm);
 	return NULL;
 }
 
-static void m_stop(struct seq_file *m, void *_vml)
+static void m_stop(struct seq_file *m, void *v)
 {
 	struct proc_maps_private *priv = m->private;
+	struct mm_struct *mm = priv->mm;
 
-	if (!IS_ERR_OR_NULL(_vml)) {
-		mmap_read_unlock(priv->mm);
-		mmput(priv->mm);
-	}
-	if (priv->task) {
-		put_task_struct(priv->task);
-		priv->task = NULL;
-	}
+	if (!priv->task)
+		return;
+
+	mmap_read_unlock(mm);
+	mmput(mm);
+	put_task_struct(priv->task);
+	priv->task = NULL;
 }
 
 static void *m_next(struct seq_file *m, void *_p, loff_t *pos)
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 96d69404a54f..9c184dbceba4 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1001,6 +1001,7 @@ int acpi_dev_resume(struct device *dev);
 int acpi_subsys_runtime_suspend(struct device *dev);
 int acpi_subsys_runtime_resume(struct device *dev);
 int acpi_dev_pm_attach(struct device *dev, bool power_on);
+bool acpi_storage_d3(struct device *dev);
 #else
 static inline int acpi_subsys_runtime_suspend(struct device *dev) { return 0; }
 static inline int acpi_subsys_runtime_resume(struct device *dev) { return 0; }
@@ -1008,6 +1009,10 @@ static inline int acpi_dev_pm_attach(struct device *dev, bool power_on)
 {
 	return 0;
 }
+static inline bool acpi_storage_d3(struct device *dev)
+{
+	return false;
+}
 #endif
 
 #if defined(CONFIG_ACPI) && defined(CONFIG_PM_SLEEP)
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b010d45a1ecd..8f4379e93ad4 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -725,7 +725,7 @@ static inline int bpf_trampoline_unlink_prog(struct bpf_prog *prog,
 static inline struct bpf_trampoline *bpf_trampoline_get(u64 key,
 							struct bpf_attach_target_info *tgt_info)
 {
-	return ERR_PTR(-EOPNOTSUPP);
+	return NULL;
 }
 static inline void bpf_trampoline_put(struct bpf_trampoline *tr) {}
 #define DEFINE_BPF_DISPATCHER(name)
diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
index 57890b357f85..eca91e7a4d39 100644
--- a/include/linux/btf_ids.h
+++ b/include/linux/btf_ids.h
@@ -38,7 +38,7 @@ asm(							\
 	____BTF_ID(symbol)
 
 #define __ID(prefix) \
-	__PASTE(prefix, __COUNTER__)
+	__PASTE(__PASTE(prefix, __COUNTER__), __LINE__)
 
 /*
  * The BTF_ID defines unique symbol for each ID pointing
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 959b370733f0..c9c430712d47 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -451,6 +451,7 @@ extern struct mutex cgroup_mutex;
 extern spinlock_t css_set_lock;
 #define task_css_set_check(task, __c)					\
 	rcu_dereference_check((task)->cgroups,				\
+		rcu_read_lock_sched_held() ||				\
 		lockdep_is_held(&cgroup_mutex) ||			\
 		lockdep_is_held(&css_set_lock) ||			\
 		((task)->flags & PF_EXITING) || (__c))
@@ -779,11 +780,9 @@ static inline void cgroup_account_cputime(struct task_struct *task,
 
 	cpuacct_charge(task, delta_exec);
 
-	rcu_read_lock();
 	cgrp = task_dfl_cgroup(task);
 	if (cgroup_parent(cgrp))
 		__cgroup_account_cputime(cgrp, delta_exec);
-	rcu_read_unlock();
 }
 
 static inline void cgroup_account_cputime_field(struct task_struct *task,
diff --git a/include/linux/if_team.h b/include/linux/if_team.h
index 5dd1657947b7..762c77d13e7d 100644
--- a/include/linux/if_team.h
+++ b/include/linux/if_team.h
@@ -189,6 +189,8 @@ struct team {
 	struct net_device *dev; /* associated netdevice */
 	struct team_pcpu_stats __percpu *pcpu_stats;
 
+	const struct header_ops *header_ops_cache;
+
 	struct mutex lock; /* used for overall locking, e.g. port lists write */
 
 	/*
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 5ca9347bd8ef..1ceec830d5f7 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -187,7 +187,7 @@ enum {
 	ATA_LFLAG_NO_LPM	= (1 << 8), /* disable LPM on this link */
 	ATA_LFLAG_RST_ONCE	= (1 << 9), /* limit recovery to one reset */
 	ATA_LFLAG_CHANGED	= (1 << 10), /* LPM state changed on this link */
-	ATA_LFLAG_NO_DB_DELAY	= (1 << 11), /* no debounce delay on link resume */
+	ATA_LFLAG_NO_DEBOUNCE_DELAY = (1 << 11), /* no debounce delay on link resume */
 
 	/* struct ata_port flags */
 	ATA_FLAG_SLAVE_POSS	= (1 << 0), /* host supports slave dev */
@@ -297,7 +297,7 @@ enum {
 	 * advised to wait only for the following duration before
 	 * doing SRST.
 	 */
-	ATA_TMOUT_PMP_SRST_WAIT	= 5000,
+	ATA_TMOUT_PMP_SRST_WAIT	= 10000,
 
 	/* When the LPM policy is set to ATA_LPM_MAX_POWER, there might
 	 * be a spurious PHY event, so ignore the first PHY event that
diff --git a/include/linux/netfilter/nf_conntrack_sctp.h b/include/linux/netfilter/nf_conntrack_sctp.h
index 625f491b95de..fb31312825ae 100644
--- a/include/linux/netfilter/nf_conntrack_sctp.h
+++ b/include/linux/netfilter/nf_conntrack_sctp.h
@@ -9,6 +9,7 @@ struct ip_ct_sctp {
 	enum sctp_conntrack state;
 
 	__be32 vtag[IP_CT_DIR_MAX];
+	u8 init[IP_CT_DIR_MAX];
 	u8 last_dir;
 	u8 flags;
 };
diff --git a/include/linux/nfs_page.h b/include/linux/nfs_page.h
index f0373a6cb5fb..40aa09a21f75 100644
--- a/include/linux/nfs_page.h
+++ b/include/linux/nfs_page.h
@@ -145,7 +145,9 @@ extern	void nfs_unlock_request(struct nfs_page *req);
 extern	void nfs_unlock_and_release_request(struct nfs_page *);
 extern	struct nfs_page *nfs_page_group_lock_head(struct nfs_page *req);
 extern	int nfs_page_group_lock_subrequests(struct nfs_page *head);
-extern	void nfs_join_page_group(struct nfs_page *head, struct inode *inode);
+extern void nfs_join_page_group(struct nfs_page *head,
+				struct nfs_commit_info *cinfo,
+				struct inode *inode);
 extern int nfs_page_group_lock(struct nfs_page *);
 extern void nfs_page_group_unlock(struct nfs_page *);
 extern bool nfs_page_group_sync_on_bit(struct nfs_page *, unsigned int);
diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 1ac20d75b061..0928a60b8f82 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -307,10 +307,10 @@ SEQCOUNT_LOCKNAME(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mu
 	__seqprop_case((s),	mutex,		prop),			\
 	__seqprop_case((s),	ww_mutex,	prop))
 
-#define __seqcount_ptr(s)		__seqprop(s, ptr)
-#define __seqcount_sequence(s)		__seqprop(s, sequence)
-#define __seqcount_lock_preemptible(s)	__seqprop(s, preemptible)
-#define __seqcount_assert_lock_held(s)	__seqprop(s, assert)
+#define seqprop_ptr(s)			__seqprop(s, ptr)
+#define seqprop_sequence(s)		__seqprop(s, sequence)
+#define seqprop_preemptible(s)		__seqprop(s, preemptible)
+#define seqprop_assert(s)		__seqprop(s, assert)
 
 /**
  * __read_seqcount_begin() - begin a seqcount_t read section w/o barrier
@@ -328,13 +328,13 @@ SEQCOUNT_LOCKNAME(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mu
  */
 #define __read_seqcount_begin(s)					\
 ({									\
-	unsigned seq;							\
+	unsigned __seq;							\
 									\
-	while ((seq = __seqcount_sequence(s)) & 1)			\
+	while ((__seq = seqprop_sequence(s)) & 1)			\
 		cpu_relax();						\
 									\
 	kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);			\
-	seq;								\
+	__seq;								\
 })
 
 /**
@@ -345,10 +345,10 @@ SEQCOUNT_LOCKNAME(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mu
  */
 #define raw_read_seqcount_begin(s)					\
 ({									\
-	unsigned seq = __read_seqcount_begin(s);			\
+	unsigned _seq = __read_seqcount_begin(s);			\
 									\
 	smp_rmb();							\
-	seq;								\
+	_seq;								\
 })
 
 /**
@@ -359,7 +359,7 @@ SEQCOUNT_LOCKNAME(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mu
  */
 #define read_seqcount_begin(s)						\
 ({									\
-	seqcount_lockdep_reader_access(__seqcount_ptr(s));		\
+	seqcount_lockdep_reader_access(seqprop_ptr(s));			\
 	raw_read_seqcount_begin(s);					\
 })
 
@@ -376,11 +376,11 @@ SEQCOUNT_LOCKNAME(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mu
  */
 #define raw_read_seqcount(s)						\
 ({									\
-	unsigned seq = __seqcount_sequence(s);				\
+	unsigned __seq = seqprop_sequence(s);				\
 									\
 	smp_rmb();							\
 	kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);			\
-	seq;								\
+	__seq;								\
 })
 
 /**
@@ -425,9 +425,9 @@ SEQCOUNT_LOCKNAME(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mu
  * Return: true if a read section retry is required, else false
  */
 #define __read_seqcount_retry(s, start)					\
-	__read_seqcount_t_retry(__seqcount_ptr(s), start)
+	do___read_seqcount_retry(seqprop_ptr(s), start)
 
-static inline int __read_seqcount_t_retry(const seqcount_t *s, unsigned start)
+static inline int do___read_seqcount_retry(const seqcount_t *s, unsigned start)
 {
 	kcsan_atomic_next(0);
 	return unlikely(READ_ONCE(s->sequence) != start);
@@ -445,12 +445,12 @@ static inline int __read_seqcount_t_retry(const seqcount_t *s, unsigned start)
  * Return: true if a read section retry is required, else false
  */
 #define read_seqcount_retry(s, start)					\
-	read_seqcount_t_retry(__seqcount_ptr(s), start)
+	do_read_seqcount_retry(seqprop_ptr(s), start)
 
-static inline int read_seqcount_t_retry(const seqcount_t *s, unsigned start)
+static inline int do_read_seqcount_retry(const seqcount_t *s, unsigned start)
 {
 	smp_rmb();
-	return __read_seqcount_t_retry(s, start);
+	return do___read_seqcount_retry(s, start);
 }
 
 /**
@@ -459,13 +459,13 @@ static inline int read_seqcount_t_retry(const seqcount_t *s, unsigned start)
  */
 #define raw_write_seqcount_begin(s)					\
 do {									\
-	if (__seqcount_lock_preemptible(s))				\
+	if (seqprop_preemptible(s))					\
 		preempt_disable();					\
 									\
-	raw_write_seqcount_t_begin(__seqcount_ptr(s));			\
+	do_raw_write_seqcount_begin(seqprop_ptr(s));			\
 } while (0)
 
-static inline void raw_write_seqcount_t_begin(seqcount_t *s)
+static inline void do_raw_write_seqcount_begin(seqcount_t *s)
 {
 	kcsan_nestable_atomic_begin();
 	s->sequence++;
@@ -478,13 +478,13 @@ static inline void raw_write_seqcount_t_begin(seqcount_t *s)
  */
 #define raw_write_seqcount_end(s)					\
 do {									\
-	raw_write_seqcount_t_end(__seqcount_ptr(s));			\
+	do_raw_write_seqcount_end(seqprop_ptr(s));			\
 									\
-	if (__seqcount_lock_preemptible(s))				\
+	if (seqprop_preemptible(s))					\
 		preempt_enable();					\
 } while (0)
 
-static inline void raw_write_seqcount_t_end(seqcount_t *s)
+static inline void do_raw_write_seqcount_end(seqcount_t *s)
 {
 	smp_wmb();
 	s->sequence++;
@@ -501,18 +501,18 @@ static inline void raw_write_seqcount_t_end(seqcount_t *s)
  */
 #define write_seqcount_begin_nested(s, subclass)			\
 do {									\
-	__seqcount_assert_lock_held(s);					\
+	seqprop_assert(s);						\
 									\
-	if (__seqcount_lock_preemptible(s))				\
+	if (seqprop_preemptible(s))					\
 		preempt_disable();					\
 									\
-	write_seqcount_t_begin_nested(__seqcount_ptr(s), subclass);	\
+	do_write_seqcount_begin_nested(seqprop_ptr(s), subclass);	\
 } while (0)
 
-static inline void write_seqcount_t_begin_nested(seqcount_t *s, int subclass)
+static inline void do_write_seqcount_begin_nested(seqcount_t *s, int subclass)
 {
-	raw_write_seqcount_t_begin(s);
 	seqcount_acquire(&s->dep_map, subclass, 0, _RET_IP_);
+	do_raw_write_seqcount_begin(s);
 }
 
 /**
@@ -528,17 +528,17 @@ static inline void write_seqcount_t_begin_nested(seqcount_t *s, int subclass)
  */
 #define write_seqcount_begin(s)						\
 do {									\
-	__seqcount_assert_lock_held(s);					\
+	seqprop_assert(s);						\
 									\
-	if (__seqcount_lock_preemptible(s))				\
+	if (seqprop_preemptible(s))					\
 		preempt_disable();					\
 									\
-	write_seqcount_t_begin(__seqcount_ptr(s));			\
+	do_write_seqcount_begin(seqprop_ptr(s));			\
 } while (0)
 
-static inline void write_seqcount_t_begin(seqcount_t *s)
+static inline void do_write_seqcount_begin(seqcount_t *s)
 {
-	write_seqcount_t_begin_nested(s, 0);
+	do_write_seqcount_begin_nested(s, 0);
 }
 
 /**
@@ -549,16 +549,16 @@ static inline void write_seqcount_t_begin(seqcount_t *s)
  */
 #define write_seqcount_end(s)						\
 do {									\
-	write_seqcount_t_end(__seqcount_ptr(s));			\
+	do_write_seqcount_end(seqprop_ptr(s));				\
 									\
-	if (__seqcount_lock_preemptible(s))				\
+	if (seqprop_preemptible(s))					\
 		preempt_enable();					\
 } while (0)
 
-static inline void write_seqcount_t_end(seqcount_t *s)
+static inline void do_write_seqcount_end(seqcount_t *s)
 {
 	seqcount_release(&s->dep_map, _RET_IP_);
-	raw_write_seqcount_t_end(s);
+	do_raw_write_seqcount_end(s);
 }
 
 /**
@@ -603,9 +603,9 @@ static inline void write_seqcount_t_end(seqcount_t *s)
  *      }
  */
 #define raw_write_seqcount_barrier(s)					\
-	raw_write_seqcount_t_barrier(__seqcount_ptr(s))
+	do_raw_write_seqcount_barrier(seqprop_ptr(s))
 
-static inline void raw_write_seqcount_t_barrier(seqcount_t *s)
+static inline void do_raw_write_seqcount_barrier(seqcount_t *s)
 {
 	kcsan_nestable_atomic_begin();
 	s->sequence++;
@@ -623,9 +623,9 @@ static inline void raw_write_seqcount_t_barrier(seqcount_t *s)
  * will complete successfully and see data older than this.
  */
 #define write_seqcount_invalidate(s)					\
-	write_seqcount_t_invalidate(__seqcount_ptr(s))
+	do_write_seqcount_invalidate(seqprop_ptr(s))
 
-static inline void write_seqcount_t_invalidate(seqcount_t *s)
+static inline void do_write_seqcount_invalidate(seqcount_t *s)
 {
 	smp_wmb();
 	kcsan_nestable_atomic_begin();
@@ -862,9 +862,9 @@ static inline unsigned read_seqretry(const seqlock_t *sl, unsigned start)
 }
 
 /*
- * For all seqlock_t write side functions, use write_seqcount_*t*_begin()
- * instead of the generic write_seqcount_begin(). This way, no redundant
- * lockdep_assert_held() checks are added.
+ * For all seqlock_t write side functions, use the the internal
+ * do_write_seqcount_begin() instead of generic write_seqcount_begin().
+ * This way, no redundant lockdep_assert_held() checks are added.
  */
 
 /**
@@ -883,7 +883,7 @@ static inline unsigned read_seqretry(const seqlock_t *sl, unsigned start)
 static inline void write_seqlock(seqlock_t *sl)
 {
 	spin_lock(&sl->lock);
-	write_seqcount_t_begin(&sl->seqcount.seqcount);
+	do_write_seqcount_begin(&sl->seqcount.seqcount);
 }
 
 /**
@@ -895,7 +895,7 @@ static inline void write_seqlock(seqlock_t *sl)
  */
 static inline void write_sequnlock(seqlock_t *sl)
 {
-	write_seqcount_t_end(&sl->seqcount.seqcount);
+	do_write_seqcount_end(&sl->seqcount.seqcount);
 	spin_unlock(&sl->lock);
 }
 
@@ -909,7 +909,7 @@ static inline void write_sequnlock(seqlock_t *sl)
 static inline void write_seqlock_bh(seqlock_t *sl)
 {
 	spin_lock_bh(&sl->lock);
-	write_seqcount_t_begin(&sl->seqcount.seqcount);
+	do_write_seqcount_begin(&sl->seqcount.seqcount);
 }
 
 /**
@@ -922,7 +922,7 @@ static inline void write_seqlock_bh(seqlock_t *sl)
  */
 static inline void write_sequnlock_bh(seqlock_t *sl)
 {
-	write_seqcount_t_end(&sl->seqcount.seqcount);
+	do_write_seqcount_end(&sl->seqcount.seqcount);
 	spin_unlock_bh(&sl->lock);
 }
 
@@ -936,7 +936,7 @@ static inline void write_sequnlock_bh(seqlock_t *sl)
 static inline void write_seqlock_irq(seqlock_t *sl)
 {
 	spin_lock_irq(&sl->lock);
-	write_seqcount_t_begin(&sl->seqcount.seqcount);
+	do_write_seqcount_begin(&sl->seqcount.seqcount);
 }
 
 /**
@@ -948,7 +948,7 @@ static inline void write_seqlock_irq(seqlock_t *sl)
  */
 static inline void write_sequnlock_irq(seqlock_t *sl)
 {
-	write_seqcount_t_end(&sl->seqcount.seqcount);
+	do_write_seqcount_end(&sl->seqcount.seqcount);
 	spin_unlock_irq(&sl->lock);
 }
 
@@ -957,7 +957,7 @@ static inline unsigned long __write_seqlock_irqsave(seqlock_t *sl)
 	unsigned long flags;
 
 	spin_lock_irqsave(&sl->lock, flags);
-	write_seqcount_t_begin(&sl->seqcount.seqcount);
+	do_write_seqcount_begin(&sl->seqcount.seqcount);
 	return flags;
 }
 
@@ -986,7 +986,7 @@ static inline unsigned long __write_seqlock_irqsave(seqlock_t *sl)
 static inline void
 write_sequnlock_irqrestore(seqlock_t *sl, unsigned long flags)
 {
-	write_seqcount_t_end(&sl->seqcount.seqcount);
+	do_write_seqcount_end(&sl->seqcount.seqcount);
 	spin_unlock_irqrestore(&sl->lock, flags);
 }
 
diff --git a/include/net/netfilter/ipv4/nf_reject.h b/include/net/netfilter/ipv4/nf_reject.h
index 40e0e0623f46..d8207a82d761 100644
--- a/include/net/netfilter/ipv4/nf_reject.h
+++ b/include/net/netfilter/ipv4/nf_reject.h
@@ -8,8 +8,8 @@
 #include <net/netfilter/nf_reject.h>
 
 void nf_send_unreach(struct sk_buff *skb_in, int code, int hook);
-void nf_send_reset(struct net *net, struct sk_buff *oldskb, int hook);
-
+void nf_send_reset(struct net *net, struct sock *, struct sk_buff *oldskb,
+		   int hook);
 const struct tcphdr *nf_reject_ip_tcphdr_get(struct sk_buff *oldskb,
 					     struct tcphdr *_oth, int hook);
 struct iphdr *nf_reject_iphdr_put(struct sk_buff *nskb,
diff --git a/include/net/netfilter/ipv6/nf_reject.h b/include/net/netfilter/ipv6/nf_reject.h
index 4a3ef9ebdf6f..86e87bc2c516 100644
--- a/include/net/netfilter/ipv6/nf_reject.h
+++ b/include/net/netfilter/ipv6/nf_reject.h
@@ -7,9 +7,8 @@
 
 void nf_send_unreach6(struct net *net, struct sk_buff *skb_in, unsigned char code,
 		      unsigned int hooknum);
-
-void nf_send_reset6(struct net *net, struct sk_buff *oldskb, int hook);
-
+void nf_send_reset6(struct net *net, struct sock *sk, struct sk_buff *oldskb,
+		    int hook);
 const struct tcphdr *nf_reject_ip6_tcphdr_get(struct sk_buff *oldskb,
 					      struct tcphdr *otcph,
 					      unsigned int *otcplen, int hook);
diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index eec29dd6681c..1d59a109417d 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -28,6 +28,16 @@ struct nft_pktinfo {
 	struct xt_action_param		xt;
 };
 
+static inline struct sock *nft_sk(const struct nft_pktinfo *pkt)
+{
+	return pkt->xt.state->sk;
+}
+
+static inline unsigned int nft_thoff(const struct nft_pktinfo *pkt)
+{
+	return pkt->xt.thoff;
+}
+
 static inline struct net *nft_net(const struct nft_pktinfo *pkt)
 {
 	return pkt->xt.state->net;
@@ -373,7 +383,8 @@ struct nft_set_ops {
 					       const struct nft_set *set,
 					       const struct nft_set_elem *elem,
 					       unsigned int flags);
-
+	void				(*commit)(const struct nft_set *set);
+	void				(*abort)(const struct nft_set *set);
 	u64				(*privsize)(const struct nlattr * const nla[],
 						    const struct nft_set_desc *desc);
 	bool				(*estimate)(const struct nft_set_desc *desc,
@@ -406,6 +417,7 @@ struct nft_set_type {
  *
  *	@list: table set list node
  *	@bindings: list of set bindings
+ *	@refs: internal refcounting for async set destruction
  *	@table: table this set belongs to
  *	@net: netnamespace this set belongs to
  * 	@name: name of the set
@@ -427,6 +439,7 @@ struct nft_set_type {
  *	@expr: stateful expression
  * 	@ops: set ops
  * 	@flags: set flags
+ *	@dead: set will be freed, never cleared
  *	@genmask: generation mask
  * 	@klen: key length
  * 	@dlen: data length
@@ -435,6 +448,7 @@ struct nft_set_type {
 struct nft_set {
 	struct list_head		list;
 	struct list_head		bindings;
+	refcount_t			refs;
 	struct nft_table		*table;
 	possible_net_t			net;
 	char				*name;
@@ -454,9 +468,11 @@ struct nft_set {
 	u16				udlen;
 	unsigned char			*udata;
 	struct nft_expr			*expr;
+	struct list_head		pending_update;
 	/* runtime data below here */
 	const struct nft_set_ops	*ops ____cacheline_aligned;
-	u16				flags:14,
+	u16				flags:13,
+					dead:1,
 					genmask:2;
 	u8				klen;
 	u8				dlen;
@@ -474,6 +490,11 @@ static inline void *nft_set_priv(const struct nft_set *set)
 	return (void *)set->data;
 }
 
+static inline bool nft_set_gc_is_pending(const struct nft_set *s)
+{
+	return refcount_read(&s->refs) != 1;
+}
+
 static inline struct nft_set *nft_set_container_of(const void *priv)
 {
 	return (void *)priv - offsetof(struct nft_set, data);
@@ -690,62 +711,6 @@ void nft_set_elem_destroy(const struct nft_set *set, void *elem,
 void nf_tables_set_elem_destroy(const struct nft_ctx *ctx,
 				const struct nft_set *set, void *elem);
 
-/**
- *	struct nft_set_gc_batch_head - nf_tables set garbage collection batch
- *
- *	@rcu: rcu head
- *	@set: set the elements belong to
- *	@cnt: count of elements
- */
-struct nft_set_gc_batch_head {
-	struct rcu_head			rcu;
-	const struct nft_set		*set;
-	unsigned int			cnt;
-};
-
-#define NFT_SET_GC_BATCH_SIZE	((PAGE_SIZE -				  \
-				  sizeof(struct nft_set_gc_batch_head)) / \
-				 sizeof(void *))
-
-/**
- *	struct nft_set_gc_batch - nf_tables set garbage collection batch
- *
- * 	@head: GC batch head
- * 	@elems: garbage collection elements
- */
-struct nft_set_gc_batch {
-	struct nft_set_gc_batch_head	head;
-	void				*elems[NFT_SET_GC_BATCH_SIZE];
-};
-
-struct nft_set_gc_batch *nft_set_gc_batch_alloc(const struct nft_set *set,
-						gfp_t gfp);
-void nft_set_gc_batch_release(struct rcu_head *rcu);
-
-static inline void nft_set_gc_batch_complete(struct nft_set_gc_batch *gcb)
-{
-	if (gcb != NULL)
-		call_rcu(&gcb->head.rcu, nft_set_gc_batch_release);
-}
-
-static inline struct nft_set_gc_batch *
-nft_set_gc_batch_check(const struct nft_set *set, struct nft_set_gc_batch *gcb,
-		       gfp_t gfp)
-{
-	if (gcb != NULL) {
-		if (gcb->head.cnt + 1 < ARRAY_SIZE(gcb->elems))
-			return gcb;
-		nft_set_gc_batch_complete(gcb);
-	}
-	return nft_set_gc_batch_alloc(set, gfp);
-}
-
-static inline void nft_set_gc_batch_add(struct nft_set_gc_batch *gcb,
-					void *elem)
-{
-	gcb->elems[gcb->head.cnt++] = elem;
-}
-
 struct nft_expr_ops;
 /**
  *	struct nft_expr_type - nf_tables expression type
@@ -1413,39 +1378,30 @@ static inline void nft_set_elem_change_active(const struct net *net,
 
 #endif /* IS_ENABLED(CONFIG_NF_TABLES) */
 
-/*
- * We use a free bit in the genmask field to indicate the element
- * is busy, meaning it is currently being processed either by
- * the netlink API or GC.
- *
- * Even though the genmask is only a single byte wide, this works
- * because the extension structure if fully constant once initialized,
- * so there are no non-atomic write accesses unless it is already
- * marked busy.
- */
-#define NFT_SET_ELEM_BUSY_MASK	(1 << 2)
+#define NFT_SET_ELEM_DEAD_MASK	(1 << 2)
 
 #if defined(__LITTLE_ENDIAN_BITFIELD)
-#define NFT_SET_ELEM_BUSY_BIT	2
+#define NFT_SET_ELEM_DEAD_BIT	2
 #elif defined(__BIG_ENDIAN_BITFIELD)
-#define NFT_SET_ELEM_BUSY_BIT	(BITS_PER_LONG - BITS_PER_BYTE + 2)
+#define NFT_SET_ELEM_DEAD_BIT	(BITS_PER_LONG - BITS_PER_BYTE + 2)
 #else
 #error
 #endif
 
-static inline int nft_set_elem_mark_busy(struct nft_set_ext *ext)
+static inline void nft_set_elem_dead(struct nft_set_ext *ext)
 {
 	unsigned long *word = (unsigned long *)ext;
 
 	BUILD_BUG_ON(offsetof(struct nft_set_ext, genmask) != 0);
-	return test_and_set_bit(NFT_SET_ELEM_BUSY_BIT, word);
+	set_bit(NFT_SET_ELEM_DEAD_BIT, word);
 }
 
-static inline void nft_set_elem_clear_busy(struct nft_set_ext *ext)
+static inline int nft_set_elem_is_dead(const struct nft_set_ext *ext)
 {
 	unsigned long *word = (unsigned long *)ext;
 
-	clear_bit(NFT_SET_ELEM_BUSY_BIT, word);
+	BUILD_BUG_ON(offsetof(struct nft_set_ext, genmask) != 0);
+	return test_bit(NFT_SET_ELEM_DEAD_BIT, word);
 }
 
 /**
@@ -1573,6 +1529,35 @@ struct nft_trans_flowtable {
 #define nft_trans_flowtable_flags(trans)	\
 	(((struct nft_trans_flowtable *)trans->data)->flags)
 
+#define NFT_TRANS_GC_BATCHCOUNT		256
+
+struct nft_trans_gc {
+	struct list_head	list;
+	struct net		*net;
+	struct nft_set		*set;
+	u32			seq;
+	u16			count;
+	void			*priv[NFT_TRANS_GC_BATCHCOUNT];
+	struct rcu_head		rcu;
+};
+
+struct nft_trans_gc *nft_trans_gc_alloc(struct nft_set *set,
+					unsigned int gc_seq, gfp_t gfp);
+void nft_trans_gc_destroy(struct nft_trans_gc *trans);
+
+struct nft_trans_gc *nft_trans_gc_queue_async(struct nft_trans_gc *gc,
+					      unsigned int gc_seq, gfp_t gfp);
+void nft_trans_gc_queue_async_done(struct nft_trans_gc *gc);
+
+struct nft_trans_gc *nft_trans_gc_queue_sync(struct nft_trans_gc *gc, gfp_t gfp);
+void nft_trans_gc_queue_sync_done(struct nft_trans_gc *trans);
+
+void nft_trans_gc_elem_add(struct nft_trans_gc *gc, void *priv);
+
+void nft_setelem_data_deactivate(const struct net *net,
+				 const struct nft_set *set,
+				 struct nft_set_elem *elem);
+
 int __init nft_chain_filter_init(void);
 void nft_chain_filter_fini(void);
 
@@ -1593,6 +1578,7 @@ struct nftables_pernet {
 	struct mutex		commit_mutex;
 	unsigned int		base_seq;
 	u8			validate_state;
+	unsigned int		gc_seq;
 };
 
 #endif /* _NET_NF_TABLES_H */
diff --git a/include/net/tcp.h b/include/net/tcp.h
index b56f34602035..cb4b2fddd9eb 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -337,12 +337,14 @@ ssize_t tcp_splice_read(struct socket *sk, loff_t *ppos,
 			struct pipe_inode_info *pipe, size_t len,
 			unsigned int flags);
 
-static inline void tcp_dec_quickack_mode(struct sock *sk,
-					 const unsigned int pkts)
+static inline void tcp_dec_quickack_mode(struct sock *sk)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
 
 	if (icsk->icsk_ack.quick) {
+		/* How many ACKs S/ACKing new data have we sent? */
+		const unsigned int pkts = inet_csk_ack_scheduled(sk) ? 1 : 0;
+
 		if (pkts >= icsk->icsk_ack.quick) {
 			icsk->icsk_ack.quick = 0;
 			/* Leaving quickack mode we deflate ATO. */
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 2a234023821e..36ddfb98b70e 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -976,7 +976,9 @@ union bpf_attr {
  * 		performed again, if the helper is used in combination with
  * 		direct packet access.
  * 	Return
- * 		0 on success, or a negative error in case of failure.
+ * 		0 on success, or a negative error in case of failure. Positive
+ * 		error indicates a potential drop or congestion in the target
+ * 		device. The particular positive error codes are not defined.
  *
  * u64 bpf_get_current_pid_tgid(void)
  * 	Return
diff --git a/include/uapi/linux/netfilter/nf_tables.h b/include/uapi/linux/netfilter/nf_tables.h
index 98272cb5f617..1d8dd58f83a5 100644
--- a/include/uapi/linux/netfilter/nf_tables.h
+++ b/include/uapi/linux/netfilter/nf_tables.h
@@ -797,11 +797,13 @@ enum nft_exthdr_flags {
  * @NFT_EXTHDR_OP_IPV6: match against ipv6 extension headers
  * @NFT_EXTHDR_OP_TCP: match against tcp options
  * @NFT_EXTHDR_OP_IPV4: match against ipv4 options
+ * @NFT_EXTHDR_OP_SCTP: match against sctp chunks
  */
 enum nft_exthdr_op {
 	NFT_EXTHDR_OP_IPV6,
 	NFT_EXTHDR_OP_TCPOPT,
 	NFT_EXTHDR_OP_IPV4,
+	NFT_EXTHDR_OP_SCTP,
 	__NFT_EXTHDR_OP_MAX
 };
 #define NFT_EXTHDR_OP_MAX	(__NFT_EXTHDR_OP_MAX - 1)
diff --git a/kernel/bpf/queue_stack_maps.c b/kernel/bpf/queue_stack_maps.c
index 0ee2347ba510..a047a2053d41 100644
--- a/kernel/bpf/queue_stack_maps.c
+++ b/kernel/bpf/queue_stack_maps.c
@@ -111,7 +111,12 @@ static int __queue_map_get(struct bpf_map *map, void *value, bool delete)
 	int err = 0;
 	void *ptr;
 
-	raw_spin_lock_irqsave(&qs->lock, flags);
+	if (in_nmi()) {
+		if (!raw_spin_trylock_irqsave(&qs->lock, flags))
+			return -EBUSY;
+	} else {
+		raw_spin_lock_irqsave(&qs->lock, flags);
+	}
 
 	if (queue_stack_map_is_empty(qs)) {
 		memset(value, 0, qs->map.value_size);
@@ -141,7 +146,12 @@ static int __stack_map_get(struct bpf_map *map, void *value, bool delete)
 	void *ptr;
 	u32 index;
 
-	raw_spin_lock_irqsave(&qs->lock, flags);
+	if (in_nmi()) {
+		if (!raw_spin_trylock_irqsave(&qs->lock, flags))
+			return -EBUSY;
+	} else {
+		raw_spin_lock_irqsave(&qs->lock, flags);
+	}
 
 	if (queue_stack_map_is_empty(qs)) {
 		memset(value, 0, qs->map.value_size);
@@ -206,7 +216,12 @@ static int queue_stack_map_push_elem(struct bpf_map *map, void *value,
 	if (flags & BPF_NOEXIST || flags > BPF_EXIST)
 		return -EINVAL;
 
-	raw_spin_lock_irqsave(&qs->lock, irq_flags);
+	if (in_nmi()) {
+		if (!raw_spin_trylock_irqsave(&qs->lock, irq_flags))
+			return -EBUSY;
+	} else {
+		raw_spin_lock_irqsave(&qs->lock, irq_flags);
+	}
 
 	if (queue_stack_map_is_full(qs)) {
 		if (!replace) {
diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index ae9fc1ee6d20..026398308909 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -606,15 +606,19 @@ static struct dma_debug_entry *__dma_entry_alloc(void)
 	return entry;
 }
 
-static void __dma_entry_alloc_check_leak(void)
+/*
+ * This should be called outside of free_entries_lock scope to avoid potential
+ * deadlocks with serial consoles that use DMA.
+ */
+static void __dma_entry_alloc_check_leak(u32 nr_entries)
 {
-	u32 tmp = nr_total_entries % nr_prealloc_entries;
+	u32 tmp = nr_entries % nr_prealloc_entries;
 
 	/* Shout each time we tick over some multiple of the initial pool */
 	if (tmp < DMA_DEBUG_DYNAMIC_ENTRIES) {
 		pr_info("dma_debug_entry pool grown to %u (%u00%%)\n",
-			nr_total_entries,
-			(nr_total_entries / nr_prealloc_entries));
+			nr_entries,
+			(nr_entries / nr_prealloc_entries));
 	}
 }
 
@@ -625,8 +629,10 @@ static void __dma_entry_alloc_check_leak(void)
  */
 static struct dma_debug_entry *dma_entry_alloc(void)
 {
+	bool alloc_check_leak = false;
 	struct dma_debug_entry *entry;
 	unsigned long flags;
+	u32 nr_entries;
 
 	spin_lock_irqsave(&free_entries_lock, flags);
 	if (num_free_entries == 0) {
@@ -636,13 +642,17 @@ static struct dma_debug_entry *dma_entry_alloc(void)
 			pr_err("debugging out of memory - disabling\n");
 			return NULL;
 		}
-		__dma_entry_alloc_check_leak();
+		alloc_check_leak = true;
+		nr_entries = nr_total_entries;
 	}
 
 	entry = __dma_entry_alloc();
 
 	spin_unlock_irqrestore(&free_entries_lock, flags);
 
+	if (alloc_check_leak)
+		__dma_entry_alloc_check_leak(nr_entries);
+
 #ifdef CONFIG_STACKTRACE
 	entry->stack_len = stack_trace_save(entry->stack_entries,
 					    ARRAY_SIZE(entry->stack_entries),
diff --git a/kernel/sched/cpuacct.c b/kernel/sched/cpuacct.c
index 941c28cf9738..8ee298321d78 100644
--- a/kernel/sched/cpuacct.c
+++ b/kernel/sched/cpuacct.c
@@ -21,15 +21,11 @@ static const char * const cpuacct_stat_desc[] = {
 	[CPUACCT_STAT_SYSTEM] = "system",
 };
 
-struct cpuacct_usage {
-	u64	usages[CPUACCT_STAT_NSTATS];
-};
-
 /* track CPU usage of a group of tasks and its child groups */
 struct cpuacct {
 	struct cgroup_subsys_state	css;
 	/* cpuusage holds pointer to a u64-type object on every CPU */
-	struct cpuacct_usage __percpu	*cpuusage;
+	u64 __percpu	*cpuusage;
 	struct kernel_cpustat __percpu	*cpustat;
 };
 
@@ -49,7 +45,7 @@ static inline struct cpuacct *parent_ca(struct cpuacct *ca)
 	return css_ca(ca->css.parent);
 }
 
-static DEFINE_PER_CPU(struct cpuacct_usage, root_cpuacct_cpuusage);
+static DEFINE_PER_CPU(u64, root_cpuacct_cpuusage);
 static struct cpuacct root_cpuacct = {
 	.cpustat	= &kernel_cpustat,
 	.cpuusage	= &root_cpuacct_cpuusage,
@@ -68,7 +64,7 @@ cpuacct_css_alloc(struct cgroup_subsys_state *parent_css)
 	if (!ca)
 		goto out;
 
-	ca->cpuusage = alloc_percpu(struct cpuacct_usage);
+	ca->cpuusage = alloc_percpu(u64);
 	if (!ca->cpuusage)
 		goto out_free_ca;
 
@@ -99,7 +95,8 @@ static void cpuacct_css_free(struct cgroup_subsys_state *css)
 static u64 cpuacct_cpuusage_read(struct cpuacct *ca, int cpu,
 				 enum cpuacct_stat_index index)
 {
-	struct cpuacct_usage *cpuusage = per_cpu_ptr(ca->cpuusage, cpu);
+	u64 *cpuusage = per_cpu_ptr(ca->cpuusage, cpu);
+	u64 *cpustat = per_cpu_ptr(ca->cpustat, cpu)->cpustat;
 	u64 data;
 
 	/*
@@ -115,14 +112,17 @@ static u64 cpuacct_cpuusage_read(struct cpuacct *ca, int cpu,
 	raw_spin_lock_irq(&cpu_rq(cpu)->lock);
 #endif
 
-	if (index == CPUACCT_STAT_NSTATS) {
-		int i = 0;
-
-		data = 0;
-		for (i = 0; i < CPUACCT_STAT_NSTATS; i++)
-			data += cpuusage->usages[i];
-	} else {
-		data = cpuusage->usages[index];
+	switch (index) {
+	case CPUACCT_STAT_USER:
+		data = cpustat[CPUTIME_USER] + cpustat[CPUTIME_NICE];
+		break;
+	case CPUACCT_STAT_SYSTEM:
+		data = cpustat[CPUTIME_SYSTEM] + cpustat[CPUTIME_IRQ] +
+			cpustat[CPUTIME_SOFTIRQ];
+		break;
+	case CPUACCT_STAT_NSTATS:
+		data = *cpuusage;
+		break;
 	}
 
 #ifndef CONFIG_64BIT
@@ -132,10 +132,14 @@ static u64 cpuacct_cpuusage_read(struct cpuacct *ca, int cpu,
 	return data;
 }
 
-static void cpuacct_cpuusage_write(struct cpuacct *ca, int cpu, u64 val)
+static void cpuacct_cpuusage_write(struct cpuacct *ca, int cpu)
 {
-	struct cpuacct_usage *cpuusage = per_cpu_ptr(ca->cpuusage, cpu);
-	int i;
+	u64 *cpuusage = per_cpu_ptr(ca->cpuusage, cpu);
+	u64 *cpustat = per_cpu_ptr(ca->cpustat, cpu)->cpustat;
+
+	/* Don't allow to reset global kernel_cpustat */
+	if (ca == &root_cpuacct)
+		return;
 
 #ifndef CONFIG_64BIT
 	/*
@@ -143,9 +147,10 @@ static void cpuacct_cpuusage_write(struct cpuacct *ca, int cpu, u64 val)
 	 */
 	raw_spin_lock_irq(&cpu_rq(cpu)->lock);
 #endif
-
-	for (i = 0; i < CPUACCT_STAT_NSTATS; i++)
-		cpuusage->usages[i] = val;
+	*cpuusage = 0;
+	cpustat[CPUTIME_USER] = cpustat[CPUTIME_NICE] = 0;
+	cpustat[CPUTIME_SYSTEM] = cpustat[CPUTIME_IRQ] = 0;
+	cpustat[CPUTIME_SOFTIRQ] = 0;
 
 #ifndef CONFIG_64BIT
 	raw_spin_unlock_irq(&cpu_rq(cpu)->lock);
@@ -196,7 +201,7 @@ static int cpuusage_write(struct cgroup_subsys_state *css, struct cftype *cft,
 		return -EINVAL;
 
 	for_each_possible_cpu(cpu)
-		cpuacct_cpuusage_write(ca, cpu, 0);
+		cpuacct_cpuusage_write(ca, cpu);
 
 	return 0;
 }
@@ -243,25 +248,10 @@ static int cpuacct_all_seq_show(struct seq_file *m, void *V)
 	seq_puts(m, "\n");
 
 	for_each_possible_cpu(cpu) {
-		struct cpuacct_usage *cpuusage = per_cpu_ptr(ca->cpuusage, cpu);
-
 		seq_printf(m, "%d", cpu);
-
-		for (index = 0; index < CPUACCT_STAT_NSTATS; index++) {
-#ifndef CONFIG_64BIT
-			/*
-			 * Take rq->lock to make 64-bit read safe on 32-bit
-			 * platforms.
-			 */
-			raw_spin_lock_irq(&cpu_rq(cpu)->lock);
-#endif
-
-			seq_printf(m, " %llu", cpuusage->usages[index]);
-
-#ifndef CONFIG_64BIT
-			raw_spin_unlock_irq(&cpu_rq(cpu)->lock);
-#endif
-		}
+		for (index = 0; index < CPUACCT_STAT_NSTATS; index++)
+			seq_printf(m, " %llu",
+				   cpuacct_cpuusage_read(ca, cpu, index));
 		seq_puts(m, "\n");
 	}
 	return 0;
@@ -338,19 +328,13 @@ static struct cftype files[] = {
  */
 void cpuacct_charge(struct task_struct *tsk, u64 cputime)
 {
+	unsigned int cpu = task_cpu(tsk);
 	struct cpuacct *ca;
-	int index = CPUACCT_STAT_SYSTEM;
-	struct pt_regs *regs = get_irq_regs() ? : task_pt_regs(tsk);
 
-	if (regs && user_mode(regs))
-		index = CPUACCT_STAT_USER;
-
-	rcu_read_lock();
+	lockdep_assert_held(&cpu_rq(cpu)->lock);
 
 	for (ca = task_ca(tsk); ca; ca = parent_ca(ca))
-		__this_cpu_add(ca->cpuusage->usages[index], cputime);
-
-	rcu_read_unlock();
+		*per_cpu_ptr(ca->cpuusage, cpu) += cputime;
 }
 
 /*
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index f8126fa0630e..0938222b4598 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -355,10 +355,11 @@ static void rb_init_page(struct buffer_data_page *bpage)
 	local_set(&bpage->commit, 0);
 }
 
-/*
- * Also stolen from mm/slob.c. Thanks to Mathieu Desnoyers for pointing
- * this issue out.
- */
+static __always_inline unsigned int rb_page_commit(struct buffer_page *bpage)
+{
+	return local_read(&bpage->page->commit);
+}
+
 static void free_buffer_page(struct buffer_page *bpage)
 {
 	free_page((unsigned long)bpage->page);
@@ -1008,6 +1009,9 @@ __poll_t ring_buffer_poll_wait(struct trace_buffer *buffer, int cpu,
 	if (full) {
 		poll_wait(filp, &work->full_waiters, poll_table);
 		work->full_waiters_pending = true;
+		if (!cpu_buffer->shortest_full ||
+		    cpu_buffer->shortest_full > full)
+			cpu_buffer->shortest_full = full;
 	} else {
 		poll_wait(filp, &work->waiters, poll_table);
 		work->waiters_pending = true;
@@ -1887,7 +1891,7 @@ rb_remove_pages(struct ring_buffer_per_cpu *cpu_buffer, unsigned long nr_pages)
 			 * Increment overrun to account for the lost events.
 			 */
 			local_add(page_entries, &cpu_buffer->overrun);
-			local_sub(BUF_PAGE_SIZE, &cpu_buffer->entries_bytes);
+			local_sub(rb_page_commit(to_remove_page), &cpu_buffer->entries_bytes);
 			local_inc(&cpu_buffer->pages_lost);
 		}
 
@@ -2080,6 +2084,8 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 				err = -ENOMEM;
 				goto out_err;
 			}
+
+			cond_resched();
 		}
 
 		get_online_cpus();
@@ -2235,11 +2241,6 @@ rb_reader_event(struct ring_buffer_per_cpu *cpu_buffer)
 			       cpu_buffer->reader_page->read);
 }
 
-static __always_inline unsigned rb_page_commit(struct buffer_page *bpage)
-{
-	return local_read(&bpage->page->commit);
-}
-
 static struct ring_buffer_event *
 rb_iter_head_event(struct ring_buffer_iter *iter)
 {
@@ -2258,6 +2259,11 @@ rb_iter_head_event(struct ring_buffer_iter *iter)
 	 */
 	commit = rb_page_commit(iter_head_page);
 	smp_rmb();
+
+	/* An event needs to be at least 8 bytes in size */
+	if (iter->head > commit - 8)
+		goto reset;
+
 	event = __rb_page_index(iter_head_page, iter->head);
 	length = rb_event_length(event);
 
@@ -2380,7 +2386,7 @@ rb_handle_head_page(struct ring_buffer_per_cpu *cpu_buffer,
 		 * the counters.
 		 */
 		local_add(entries, &cpu_buffer->overrun);
-		local_sub(BUF_PAGE_SIZE, &cpu_buffer->entries_bytes);
+		local_sub(rb_page_commit(next_page), &cpu_buffer->entries_bytes);
 		local_inc(&cpu_buffer->pages_lost);
 
 		/*
@@ -2523,9 +2529,6 @@ rb_reset_tail(struct ring_buffer_per_cpu *cpu_buffer,
 
 	event = __rb_page_index(tail_page, tail);
 
-	/* account for padding bytes */
-	local_add(BUF_PAGE_SIZE - tail, &cpu_buffer->entries_bytes);
-
 	/*
 	 * Save the original length to the meta data.
 	 * This will be used by the reader to add lost event
@@ -2539,7 +2542,8 @@ rb_reset_tail(struct ring_buffer_per_cpu *cpu_buffer,
 	 * write counter enough to allow another writer to slip
 	 * in on this page.
 	 * We put in a discarded commit instead, to make sure
-	 * that this space is not used again.
+	 * that this space is not used again, and this space will
+	 * not be accounted into 'entries_bytes'.
 	 *
 	 * If we are less than the minimum size, we don't need to
 	 * worry about it.
@@ -2564,6 +2568,9 @@ rb_reset_tail(struct ring_buffer_per_cpu *cpu_buffer,
 	/* time delta must be non zero */
 	event->time_delta = 1;
 
+	/* account for padding bytes */
+	local_add(BUF_PAGE_SIZE - tail, &cpu_buffer->entries_bytes);
+
 	/* Make sure the padding is visible before the tail_page->write update */
 	smp_wmb();
 
@@ -3929,7 +3936,7 @@ u64 ring_buffer_oldest_event_ts(struct trace_buffer *buffer, int cpu)
 EXPORT_SYMBOL_GPL(ring_buffer_oldest_event_ts);
 
 /**
- * ring_buffer_bytes_cpu - get the number of bytes consumed in a cpu buffer
+ * ring_buffer_bytes_cpu - get the number of bytes unconsumed in a cpu buffer
  * @buffer: The ring buffer
  * @cpu: The per CPU buffer to read from.
  */
@@ -4437,6 +4444,7 @@ static void rb_advance_reader(struct ring_buffer_per_cpu *cpu_buffer)
 
 	length = rb_event_length(event);
 	cpu_buffer->reader_page->read += length;
+	cpu_buffer->read_bytes += length;
 }
 
 static void rb_advance_iter(struct ring_buffer_iter *iter)
@@ -5528,7 +5536,7 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 	} else {
 		/* update the entry counter */
 		cpu_buffer->read += rb_page_entries(reader);
-		cpu_buffer->read_bytes += BUF_PAGE_SIZE;
+		cpu_buffer->read_bytes += rb_page_commit(reader);
 
 		/* swap the pages */
 		rb_init_page(bpage);
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 7a64c0cd8819..196eec0423ff 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4559,6 +4559,33 @@ int tracing_open_generic_tr(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+/*
+ * The private pointer of the inode is the trace_event_file.
+ * Update the tr ref count associated to it.
+ */
+int tracing_open_file_tr(struct inode *inode, struct file *filp)
+{
+	struct trace_event_file *file = inode->i_private;
+	int ret;
+
+	ret = tracing_check_open_get_tr(file->tr);
+	if (ret)
+		return ret;
+
+	filp->private_data = inode->i_private;
+
+	return 0;
+}
+
+int tracing_release_file_tr(struct inode *inode, struct file *filp)
+{
+	struct trace_event_file *file = inode->i_private;
+
+	trace_array_put(file->tr);
+
+	return 0;
+}
+
 static int tracing_release(struct inode *inode, struct file *file)
 {
 	struct trace_array *tr = inode->i_private;
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index dfde855dafda..7fa00b83dfa4 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -730,6 +730,8 @@ void tracing_reset_all_online_cpus(void);
 void tracing_reset_all_online_cpus_unlocked(void);
 int tracing_open_generic(struct inode *inode, struct file *filp);
 int tracing_open_generic_tr(struct inode *inode, struct file *filp);
+int tracing_open_file_tr(struct inode *inode, struct file *filp);
+int tracing_release_file_tr(struct inode *inode, struct file *filp);
 bool tracing_is_disabled(void);
 bool tracer_tracing_is_on(struct trace_array *tr);
 void tracer_tracing_on(struct trace_array *tr);
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index a46d34d840f6..321cfda1b333 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1855,9 +1855,10 @@ static const struct file_operations ftrace_set_event_notrace_pid_fops = {
 };
 
 static const struct file_operations ftrace_enable_fops = {
-	.open = tracing_open_generic,
+	.open = tracing_open_file_tr,
 	.read = event_enable_read,
 	.write = event_enable_write,
+	.release = tracing_release_file_tr,
 	.llseek = default_llseek,
 };
 
@@ -1874,9 +1875,10 @@ static const struct file_operations ftrace_event_id_fops = {
 };
 
 static const struct file_operations ftrace_event_filter_fops = {
-	.open = tracing_open_generic,
+	.open = tracing_open_file_tr,
 	.read = event_filter_read,
 	.write = event_filter_write,
+	.release = tracing_release_file_tr,
 	.llseek = default_llseek,
 };
 
diff --git a/kernel/trace/trace_events_inject.c b/kernel/trace/trace_events_inject.c
index 22bcf7c51d1e..149c7dc6a447 100644
--- a/kernel/trace/trace_events_inject.c
+++ b/kernel/trace/trace_events_inject.c
@@ -323,7 +323,8 @@ event_inject_read(struct file *file, char __user *buf, size_t size,
 }
 
 const struct file_operations event_inject_fops = {
-	.open = tracing_open_generic,
+	.open = tracing_open_file_tr,
 	.read = event_inject_read,
 	.write = event_inject_write,
+	.release = tracing_release_file_tr,
 };
diff --git a/mm/frame_vector.c b/mm/frame_vector.c
index 0e589a9a8801..1cd81d38ad2d 100644
--- a/mm/frame_vector.c
+++ b/mm/frame_vector.c
@@ -29,6 +29,10 @@
  * different type underlying the specified range of virtual addresses.
  * When the function isn't able to map a single page, it returns error.
  *
+ * Note that get_vaddr_frames() cannot follow VM_IO mappings. It used
+ * to be able to do that, but that could (racily) return non-refcounted
+ * pfns.
+ *
  * This function takes care of grabbing mmap_lock as necessary.
  */
 int get_vaddr_frames(unsigned long start, unsigned int nr_frames,
@@ -77,8 +81,6 @@ int get_vaddr_frames(unsigned long start, unsigned int nr_frames,
 			goto out;
 	}
 
-	/* This used to (racily) return non-refcounted pfns. Let people know */
-	WARN_ONCE(1, "get_vaddr_frames() cannot follow VM_IO mapping");
 	vec->nr_frames = 0;
 
 out:
diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index 4610f3a13966..f2ef75c7ccc6 100644
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -118,7 +118,7 @@ static int deliver_clone(const struct net_bridge_port *prev,
 
 	skb = skb_clone(skb, GFP_ATOMIC);
 	if (!skb) {
-		dev->stats.tx_dropped++;
+		DEV_STATS_INC(dev, tx_dropped);
 		return -ENOMEM;
 	}
 
@@ -255,7 +255,7 @@ static void maybe_deliver_addr(struct net_bridge_port *p, struct sk_buff *skb,
 
 	skb = skb_copy(skb, GFP_ATOMIC);
 	if (!skb) {
-		dev->stats.tx_dropped++;
+		DEV_STATS_INC(dev, tx_dropped);
 		return;
 	}
 
diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index bf5bf148091f..52dd0708fd14 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -145,12 +145,12 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 			if ((mdst && mdst->host_joined) ||
 			    br_multicast_is_router(br)) {
 				local_rcv = true;
-				br->dev->stats.multicast++;
+				DEV_STATS_INC(br->dev, multicast);
 			}
 			mcast_hit = true;
 		} else {
 			local_rcv = true;
-			br->dev->stats.multicast++;
+			DEV_STATS_INC(br->dev, multicast);
 		}
 		break;
 	case BR_PKT_UNICAST:
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 3b642c412cf3..15267428c4f8 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -935,7 +935,9 @@ static void neigh_periodic_work(struct work_struct *work)
 			    (state == NUD_FAILED ||
 			     !time_in_range_open(jiffies, n->used,
 						 n->used + NEIGH_VAR(n->parms, GC_STALETIME)))) {
-				*np = n->next;
+				rcu_assign_pointer(*np,
+					rcu_dereference_protected(n->next,
+						lockdep_is_held(&tbl->lock)));
 				neigh_mark_dead(n);
 				write_unlock(&n->lock);
 				neigh_cleanup_and_release(n);
diff --git a/net/dccp/ipv4.c b/net/dccp/ipv4.c
index 398dc3e47d0c..f2a0a4e6dd74 100644
--- a/net/dccp/ipv4.c
+++ b/net/dccp/ipv4.c
@@ -243,13 +243,8 @@ static int dccp_v4_err(struct sk_buff *skb, u32 info)
 	int err;
 	struct net *net = dev_net(skb->dev);
 
-	/* For the first __dccp_basic_hdr_len() check, we only need dh->dccph_x,
-	 * which is in byte 7 of the dccp header.
-	 * Our caller (icmp_socket_deliver()) already pulled 8 bytes for us.
-	 *
-	 * Later on, we want to access the sequence number fields, which are
-	 * beyond 8 bytes, so we have to pskb_may_pull() ourselves.
-	 */
+	if (!pskb_may_pull(skb, offset + sizeof(*dh)))
+		return -EINVAL;
 	dh = (struct dccp_hdr *)(skb->data + offset);
 	if (!pskb_may_pull(skb, offset + __dccp_basic_hdr_len(dh)))
 		return -EINVAL;
diff --git a/net/dccp/ipv6.c b/net/dccp/ipv6.c
index bfe11e96af7c..6d6bbd43a141 100644
--- a/net/dccp/ipv6.c
+++ b/net/dccp/ipv6.c
@@ -76,13 +76,8 @@ static int dccp_v6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 	__u64 seq;
 	struct net *net = dev_net(skb->dev);
 
-	/* For the first __dccp_basic_hdr_len() check, we only need dh->dccph_x,
-	 * which is in byte 7 of the dccp header.
-	 * Our caller (icmpv6_notify()) already pulled 8 bytes for us.
-	 *
-	 * Later on, we want to access the sequence number fields, which are
-	 * beyond 8 bytes, so we have to pskb_may_pull() ourselves.
-	 */
+	if (!pskb_may_pull(skb, offset + sizeof(*dh)))
+		return -EINVAL;
 	dh = (struct dccp_hdr *)(skb->data + offset);
 	if (!pskb_may_pull(skb, offset + __dccp_basic_hdr_len(dh)))
 		return -EINVAL;
diff --git a/net/ipv4/netfilter/ipt_REJECT.c b/net/ipv4/netfilter/ipt_REJECT.c
index e16b98ee6266..4b8840734762 100644
--- a/net/ipv4/netfilter/ipt_REJECT.c
+++ b/net/ipv4/netfilter/ipt_REJECT.c
@@ -56,7 +56,8 @@ reject_tg(struct sk_buff *skb, const struct xt_action_param *par)
 		nf_send_unreach(skb, ICMP_PKT_FILTERED, hook);
 		break;
 	case IPT_TCP_RESET:
-		nf_send_reset(xt_net(par), skb, hook);
+		nf_send_reset(xt_net(par), par->state->sk, skb, hook);
+		break;
 	case IPT_ICMP_ECHOREPLY:
 		/* Doesn't happen. */
 		break;
diff --git a/net/ipv4/netfilter/nf_reject_ipv4.c b/net/ipv4/netfilter/nf_reject_ipv4.c
index 93b07739807b..efe14a6a5d9b 100644
--- a/net/ipv4/netfilter/nf_reject_ipv4.c
+++ b/net/ipv4/netfilter/nf_reject_ipv4.c
@@ -112,7 +112,8 @@ static int nf_reject_fill_skb_dst(struct sk_buff *skb_in)
 }
 
 /* Send RST reply */
-void nf_send_reset(struct net *net, struct sk_buff *oldskb, int hook)
+void nf_send_reset(struct net *net, struct sock *sk, struct sk_buff *oldskb,
+		   int hook)
 {
 	struct net_device *br_indev __maybe_unused;
 	struct sk_buff *nskb;
@@ -144,8 +145,7 @@ void nf_send_reset(struct net *net, struct sk_buff *oldskb, int hook)
 	niph = nf_reject_iphdr_put(nskb, oldskb, IPPROTO_TCP,
 				   ip4_dst_hoplimit(skb_dst(nskb)));
 	nf_reject_ip_tcphdr_put(nskb, oldskb, oth);
-
-	if (ip_route_me_harder(net, nskb->sk, nskb, RTN_UNSPEC))
+	if (ip_route_me_harder(net, sk, nskb, RTN_UNSPEC))
 		goto free_nskb;
 
 	niph = ip_hdr(nskb);
diff --git a/net/ipv4/netfilter/nft_reject_ipv4.c b/net/ipv4/netfilter/nft_reject_ipv4.c
index e408f813f5d8..55fc23a8f7a7 100644
--- a/net/ipv4/netfilter/nft_reject_ipv4.c
+++ b/net/ipv4/netfilter/nft_reject_ipv4.c
@@ -27,7 +27,8 @@ static void nft_reject_ipv4_eval(const struct nft_expr *expr,
 		nf_send_unreach(pkt->skb, priv->icmp_code, nft_hook(pkt));
 		break;
 	case NFT_REJECT_TCP_RST:
-		nf_send_reset(nft_net(pkt), pkt->skb, nft_hook(pkt));
+		nf_send_reset(nft_net(pkt), nft_sk(pkt), pkt->skb,
+			      nft_hook(pkt));
 		break;
 	default:
 		break;
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 3ddeb4fc0d08..445b1a2966d7 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1240,6 +1240,7 @@ static struct dst_entry *ipv4_dst_check(struct dst_entry *dst, u32 cookie)
 
 static void ipv4_send_dest_unreach(struct sk_buff *skb)
 {
+	struct net_device *dev;
 	struct ip_options opt;
 	int res;
 
@@ -1257,7 +1258,8 @@ static void ipv4_send_dest_unreach(struct sk_buff *skb)
 		opt.optlen = ip_hdr(skb)->ihl * 4 - sizeof(struct iphdr);
 
 		rcu_read_lock();
-		res = __ip_options_compile(dev_net(skb->dev), &opt, skb, NULL);
+		dev = skb->dev ? skb->dev : skb_rtable(skb)->dst.dev;
+		res = __ip_options_compile(dev_net(dev), &opt, skb, NULL);
 		rcu_read_unlock();
 
 		if (res)
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index b8d2c45edbe0..3f2b6a3adf6a 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -242,6 +242,19 @@ static void tcp_measure_rcv_mss(struct sock *sk, const struct sk_buff *skb)
 		if (unlikely(len > icsk->icsk_ack.rcv_mss +
 				   MAX_TCP_OPTION_SPACE))
 			tcp_gro_dev_warn(sk, skb, len);
+		/* If the skb has a len of exactly 1*MSS and has the PSH bit
+		 * set then it is likely the end of an application write. So
+		 * more data may not be arriving soon, and yet the data sender
+		 * may be waiting for an ACK if cwnd-bound or using TX zero
+		 * copy. So we set ICSK_ACK_PUSHED here so that
+		 * tcp_cleanup_rbuf() will send an ACK immediately if the app
+		 * reads all of the data and is not ping-pong. If len > MSS
+		 * then this logic does not matter (and does not hurt) because
+		 * tcp_cleanup_rbuf() will always ACK immediately if the app
+		 * reads data and there is more than an MSS of unACKed data.
+		 */
+		if (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_PSH)
+			icsk->icsk_ack.pending |= ICSK_ACK_PUSHED;
 	} else {
 		/* Otherwise, we make more careful check taking into account,
 		 * that SACKs block is variable.
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 86e896351364..6c14d67715d1 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -177,8 +177,7 @@ static void tcp_event_data_sent(struct tcp_sock *tp,
 }
 
 /* Account for an ACK we sent. */
-static inline void tcp_event_ack_sent(struct sock *sk, unsigned int pkts,
-				      u32 rcv_nxt)
+static inline void tcp_event_ack_sent(struct sock *sk, u32 rcv_nxt)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 
@@ -192,7 +191,7 @@ static inline void tcp_event_ack_sent(struct sock *sk, unsigned int pkts,
 
 	if (unlikely(rcv_nxt != tp->rcv_nxt))
 		return;  /* Special ACK sent by DCTCP to reflect ECN */
-	tcp_dec_quickack_mode(sk, pkts);
+	tcp_dec_quickack_mode(sk);
 	inet_csk_clear_xmit_timer(sk, ICSK_TIME_DACK);
 }
 
@@ -1374,7 +1373,7 @@ static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb,
 			   sk, skb);
 
 	if (likely(tcb->tcp_flags & TCPHDR_ACK))
-		tcp_event_ack_sent(sk, tcp_skb_pcount(skb), rcv_nxt);
+		tcp_event_ack_sent(sk, rcv_nxt);
 
 	if (skb->len != tcp_header_size) {
 		tcp_event_data_sent(tp, sk);
diff --git a/net/ipv6/netfilter/ip6t_REJECT.c b/net/ipv6/netfilter/ip6t_REJECT.c
index 3ac5485049f0..a35019d2e480 100644
--- a/net/ipv6/netfilter/ip6t_REJECT.c
+++ b/net/ipv6/netfilter/ip6t_REJECT.c
@@ -61,7 +61,7 @@ reject_tg6(struct sk_buff *skb, const struct xt_action_param *par)
 		/* Do nothing */
 		break;
 	case IP6T_TCP_RESET:
-		nf_send_reset6(net, skb, xt_hooknum(par));
+		nf_send_reset6(net, par->state->sk, skb, xt_hooknum(par));
 		break;
 	case IP6T_ICMP6_POLICY_FAIL:
 		nf_send_unreach6(net, skb, ICMPV6_POLICY_FAIL, xt_hooknum(par));
diff --git a/net/ipv6/netfilter/nf_reject_ipv6.c b/net/ipv6/netfilter/nf_reject_ipv6.c
index bf95513736c9..832d9f9cd10a 100644
--- a/net/ipv6/netfilter/nf_reject_ipv6.c
+++ b/net/ipv6/netfilter/nf_reject_ipv6.c
@@ -141,7 +141,8 @@ static int nf_reject6_fill_skb_dst(struct sk_buff *skb_in)
 	return 0;
 }
 
-void nf_send_reset6(struct net *net, struct sk_buff *oldskb, int hook)
+void nf_send_reset6(struct net *net, struct sock *sk, struct sk_buff *oldskb,
+		    int hook)
 {
 	struct net_device *br_indev __maybe_unused;
 	struct sk_buff *nskb;
@@ -233,7 +234,7 @@ void nf_send_reset6(struct net *net, struct sk_buff *oldskb, int hook)
 		dev_queue_xmit(nskb);
 	} else
 #endif
-		ip6_local_out(net, nskb->sk, nskb);
+		ip6_local_out(net, sk, nskb);
 }
 EXPORT_SYMBOL_GPL(nf_send_reset6);
 
diff --git a/net/ipv6/netfilter/nft_reject_ipv6.c b/net/ipv6/netfilter/nft_reject_ipv6.c
index c1098a1968e1..ed69c768797e 100644
--- a/net/ipv6/netfilter/nft_reject_ipv6.c
+++ b/net/ipv6/netfilter/nft_reject_ipv6.c
@@ -28,7 +28,8 @@ static void nft_reject_ipv6_eval(const struct nft_expr *expr,
 				 nft_hook(pkt));
 		break;
 	case NFT_REJECT_TCP_RST:
-		nf_send_reset6(nft_net(pkt), pkt->skb, nft_hook(pkt));
+		nf_send_reset6(nft_net(pkt), nft_sk(pkt), pkt->skb,
+			       nft_hook(pkt));
 		break;
 	default:
 		break;
diff --git a/net/l2tp/l2tp_ip6.c b/net/l2tp/l2tp_ip6.c
index 382124d6f764..9746c624a550 100644
--- a/net/l2tp/l2tp_ip6.c
+++ b/net/l2tp/l2tp_ip6.c
@@ -508,7 +508,6 @@ static int l2tp_ip6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	 */
 	if (len > INT_MAX - transhdrlen)
 		return -EMSGSIZE;
-	ulen = len + transhdrlen;
 
 	/* Mirror BSD error message compatibility */
 	if (msg->msg_flags & MSG_OOB)
@@ -629,6 +628,7 @@ static int l2tp_ip6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 back_from_confirm:
 	lock_sock(sk);
+	ulen = len + skb_queue_empty(&sk->sk_write_queue) ? transhdrlen : 0;
 	err = ip6_append_data(sk, ip_generic_getfrag, msg,
 			      ulen, transhdrlen, &ipc6,
 			      &fl6, (struct rt6_info *)dst,
diff --git a/net/ncsi/ncsi-aen.c b/net/ncsi/ncsi-aen.c
index 62fb1031763d..f8854bff286c 100644
--- a/net/ncsi/ncsi-aen.c
+++ b/net/ncsi/ncsi-aen.c
@@ -89,6 +89,11 @@ static int ncsi_aen_handler_lsc(struct ncsi_dev_priv *ndp,
 	if ((had_link == has_link) || chained)
 		return 0;
 
+	if (had_link)
+		netif_carrier_off(ndp->ndev.dev);
+	else
+		netif_carrier_on(ndp->ndev.dev);
+
 	if (!ndp->multi_package && !nc->package->multi_channel) {
 		if (had_link) {
 			ndp->flags |= NCSI_DEV_RESHUFFLE;
diff --git a/net/netfilter/ipset/ip_set_core.c b/net/netfilter/ipset/ip_set_core.c
index 55ac0cc12657..26613e3731d0 100644
--- a/net/netfilter/ipset/ip_set_core.c
+++ b/net/netfilter/ipset/ip_set_core.c
@@ -682,6 +682,14 @@ __ip_set_put(struct ip_set *set)
 /* set->ref can be swapped out by ip_set_swap, netlink events (like dump) need
  * a separate reference counter
  */
+static void
+__ip_set_get_netlink(struct ip_set *set)
+{
+	write_lock_bh(&ip_set_ref_lock);
+	set->ref_netlink++;
+	write_unlock_bh(&ip_set_ref_lock);
+}
+
 static void
 __ip_set_put_netlink(struct ip_set *set)
 {
@@ -1705,11 +1713,11 @@ call_ad(struct sock *ctnl, struct sk_buff *skb, struct ip_set *set,
 
 	do {
 		if (retried) {
-			__ip_set_get(set);
+			__ip_set_get_netlink(set);
 			nfnl_unlock(NFNL_SUBSYS_IPSET);
 			cond_resched();
 			nfnl_lock(NFNL_SUBSYS_IPSET);
-			__ip_set_put(set);
+			__ip_set_put_netlink(set);
 		}
 
 		ip_set_lock(set);
diff --git a/net/netfilter/ipvs/ip_vs_sync.c b/net/netfilter/ipvs/ip_vs_sync.c
index fc8db03d3efc..e45ffa762bbe 100644
--- a/net/netfilter/ipvs/ip_vs_sync.c
+++ b/net/netfilter/ipvs/ip_vs_sync.c
@@ -1507,8 +1507,8 @@ static int make_send_sock(struct netns_ipvs *ipvs, int id,
 	}
 
 	get_mcast_sockaddr(&mcast_addr, &salen, &ipvs->mcfg, id);
-	result = sock->ops->connect(sock, (struct sockaddr *) &mcast_addr,
-				    salen, 0);
+	result = kernel_connect(sock, (struct sockaddr *)&mcast_addr,
+				salen, 0);
 	if (result < 0) {
 		pr_err("Error connecting to the multicast addr\n");
 		goto error;
diff --git a/net/netfilter/nf_conntrack_proto_sctp.c b/net/netfilter/nf_conntrack_proto_sctp.c
index 21cbaf6dac33..e7545bcca805 100644
--- a/net/netfilter/nf_conntrack_proto_sctp.c
+++ b/net/netfilter/nf_conntrack_proto_sctp.c
@@ -112,7 +112,7 @@ static const u8 sctp_conntracks[2][11][SCTP_CONNTRACK_MAX] = {
 /* shutdown_ack */ {sSA, sCL, sCW, sCE, sES, sSA, sSA, sSA, sSA},
 /* error        */ {sCL, sCL, sCW, sCE, sES, sSS, sSR, sSA, sCL},/* Can't have Stale cookie*/
 /* cookie_echo  */ {sCL, sCL, sCE, sCE, sES, sSS, sSR, sSA, sCL},/* 5.2.4 - Big TODO */
-/* cookie_ack   */ {sCL, sCL, sCW, sCE, sES, sSS, sSR, sSA, sCL},/* Can't come in orig dir */
+/* cookie_ack   */ {sCL, sCL, sCW, sES, sES, sSS, sSR, sSA, sCL},/* Can't come in orig dir */
 /* shutdown_comp*/ {sCL, sCL, sCW, sCE, sES, sSS, sSR, sCL, sCL},
 /* heartbeat    */ {sHS, sCL, sCW, sCE, sES, sSS, sSR, sSA, sHS},
 /* heartbeat_ack*/ {sCL, sCL, sCW, sCE, sES, sSS, sSR, sSA, sHS},
@@ -126,7 +126,7 @@ static const u8 sctp_conntracks[2][11][SCTP_CONNTRACK_MAX] = {
 /* shutdown     */ {sIV, sCL, sCW, sCE, sSR, sSS, sSR, sSA, sIV},
 /* shutdown_ack */ {sIV, sCL, sCW, sCE, sES, sSA, sSA, sSA, sIV},
 /* error        */ {sIV, sCL, sCW, sCL, sES, sSS, sSR, sSA, sIV},
-/* cookie_echo  */ {sIV, sCL, sCW, sCE, sES, sSS, sSR, sSA, sIV},/* Can't come in reply dir */
+/* cookie_echo  */ {sIV, sCL, sCE, sCE, sES, sSS, sSR, sSA, sIV},/* Can't come in reply dir */
 /* cookie_ack   */ {sIV, sCL, sCW, sES, sES, sSS, sSR, sSA, sIV},
 /* shutdown_comp*/ {sIV, sCL, sCW, sCE, sES, sSS, sSR, sCL, sIV},
 /* heartbeat    */ {sIV, sCL, sCW, sCE, sES, sSS, sSR, sSA, sHS},
@@ -426,6 +426,9 @@ int nf_conntrack_sctp_packet(struct nf_conn *ct,
 			/* (D) vtag must be same as init_vtag as found in INIT_ACK */
 			if (sh->vtag != ct->proto.sctp.vtag[dir])
 				goto out_unlock;
+		} else if (sch->type == SCTP_CID_COOKIE_ACK) {
+			ct->proto.sctp.init[dir] = 0;
+			ct->proto.sctp.init[!dir] = 0;
 		} else if (sch->type == SCTP_CID_HEARTBEAT) {
 			if (ct->proto.sctp.vtag[dir] == 0) {
 				pr_debug("Setting %d vtag %x for dir %d\n", sch->type, sh->vtag, dir);
@@ -474,16 +477,18 @@ int nf_conntrack_sctp_packet(struct nf_conn *ct,
 		}
 
 		/* If it is an INIT or an INIT ACK note down the vtag */
-		if (sch->type == SCTP_CID_INIT ||
-		    sch->type == SCTP_CID_INIT_ACK) {
-			struct sctp_inithdr _inithdr, *ih;
+		if (sch->type == SCTP_CID_INIT) {
+			struct sctp_inithdr _ih, *ih;
 
-			ih = skb_header_pointer(skb, offset + sizeof(_sch),
-						sizeof(_inithdr), &_inithdr);
-			if (ih == NULL)
+			ih = skb_header_pointer(skb, offset + sizeof(_sch), sizeof(*ih), &_ih);
+			if (!ih)
 				goto out_unlock;
-			pr_debug("Setting vtag %x for dir %d\n",
-				 ih->init_tag, !dir);
+
+			if (ct->proto.sctp.init[dir] && ct->proto.sctp.init[!dir])
+				ct->proto.sctp.init[!dir] = 0;
+			ct->proto.sctp.init[dir] = 1;
+
+			pr_debug("Setting vtag %x for dir %d\n", ih->init_tag, !dir);
 			ct->proto.sctp.vtag[!dir] = ih->init_tag;
 
 			/* don't renew timeout on init retransmit so
@@ -494,6 +499,24 @@ int nf_conntrack_sctp_packet(struct nf_conn *ct,
 			    old_state == SCTP_CONNTRACK_CLOSED &&
 			    nf_ct_is_confirmed(ct))
 				ignore = true;
+		} else if (sch->type == SCTP_CID_INIT_ACK) {
+			struct sctp_inithdr _ih, *ih;
+			__be32 vtag;
+
+			ih = skb_header_pointer(skb, offset + sizeof(_sch), sizeof(*ih), &_ih);
+			if (!ih)
+				goto out_unlock;
+
+			vtag = ct->proto.sctp.vtag[!dir];
+			if (!ct->proto.sctp.init[!dir] && vtag && vtag != ih->init_tag)
+				goto out_unlock;
+			/* collision */
+			if (ct->proto.sctp.init[dir] && ct->proto.sctp.init[!dir] &&
+			    vtag != ih->init_tag)
+				goto out_unlock;
+
+			pr_debug("Setting vtag %x for dir %d\n", ih->init_tag, !dir);
+			ct->proto.sctp.vtag[!dir] = ih->init_tag;
 		}
 
 		ct->proto.sctp.state = new_state;
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 2669999d1bc9..78b268bd7f01 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -32,7 +32,9 @@ static LIST_HEAD(nf_tables_expressions);
 static LIST_HEAD(nf_tables_objects);
 static LIST_HEAD(nf_tables_flowtables);
 static LIST_HEAD(nf_tables_destroy_list);
+static LIST_HEAD(nf_tables_gc_list);
 static DEFINE_SPINLOCK(nf_tables_destroy_list_lock);
+static DEFINE_SPINLOCK(nf_tables_gc_list_lock);
 static u64 table_handle;
 
 enum {
@@ -124,6 +126,9 @@ static void nft_validate_state_update(struct net *net, u8 new_validate_state)
 static void nf_tables_trans_destroy_work(struct work_struct *w);
 static DECLARE_WORK(trans_destroy_work, nf_tables_trans_destroy_work);
 
+static void nft_trans_gc_work(struct work_struct *work);
+static DECLARE_WORK(trans_gc_work, nft_trans_gc_work);
+
 static void nft_ctx_init(struct nft_ctx *ctx,
 			 struct net *net,
 			 const struct sk_buff *skb,
@@ -298,12 +303,18 @@ static int nft_netdev_register_hooks(struct net *net,
 }
 
 static void nft_netdev_unregister_hooks(struct net *net,
-					struct list_head *hook_list)
+					struct list_head *hook_list,
+					bool release_netdev)
 {
-	struct nft_hook *hook;
+	struct nft_hook *hook, *next;
 
-	list_for_each_entry(hook, hook_list, list)
+	list_for_each_entry_safe(hook, next, hook_list, list) {
 		nf_unregister_net_hook(net, &hook->ops);
+		if (release_netdev) {
+			list_del(&hook->list);
+			kfree_rcu(hook, rcu);
+		}
+	}
 }
 
 static int nf_tables_register_hook(struct net *net,
@@ -329,9 +340,10 @@ static int nf_tables_register_hook(struct net *net,
 	return nf_register_net_hook(net, &basechain->ops);
 }
 
-static void nf_tables_unregister_hook(struct net *net,
-				      const struct nft_table *table,
-				      struct nft_chain *chain)
+static void __nf_tables_unregister_hook(struct net *net,
+					const struct nft_table *table,
+					struct nft_chain *chain,
+					bool release_netdev)
 {
 	struct nft_base_chain *basechain;
 	const struct nf_hook_ops *ops;
@@ -346,11 +358,19 @@ static void nf_tables_unregister_hook(struct net *net,
 		return basechain->type->ops_unregister(net, ops);
 
 	if (nft_base_chain_netdev(table->family, basechain->ops.hooknum))
-		nft_netdev_unregister_hooks(net, &basechain->hook_list);
+		nft_netdev_unregister_hooks(net, &basechain->hook_list,
+					    release_netdev);
 	else
 		nf_unregister_net_hook(net, &basechain->ops);
 }
 
+static void nf_tables_unregister_hook(struct net *net,
+				      const struct nft_table *table,
+				      struct nft_chain *chain)
+{
+	return __nf_tables_unregister_hook(net, table, chain, false);
+}
+
 static void nft_trans_commit_list_add_tail(struct net *net, struct nft_trans *trans)
 {
 	struct nftables_pernet *nft_net;
@@ -559,10 +579,6 @@ static int nft_trans_set_add(const struct nft_ctx *ctx, int msg_type,
 	return 0;
 }
 
-static void nft_setelem_data_deactivate(const struct net *net,
-					const struct nft_set *set,
-					struct nft_set_elem *elem);
-
 static int nft_mapelem_deactivate(const struct nft_ctx *ctx,
 				  struct nft_set *set,
 				  const struct nft_set_iter *iter,
@@ -1252,7 +1268,7 @@ static int nft_flush_table(struct nft_ctx *ctx)
 		if (!nft_is_active_next(ctx->net, chain))
 			continue;
 
-		if (nft_chain_is_bound(chain))
+		if (nft_chain_binding(chain))
 			continue;
 
 		ctx->chain = chain;
@@ -1266,8 +1282,7 @@ static int nft_flush_table(struct nft_ctx *ctx)
 		if (!nft_is_active_next(ctx->net, set))
 			continue;
 
-		if (nft_set_is_anonymous(set) &&
-		    !list_empty(&set->bindings))
+		if (nft_set_is_anonymous(set))
 			continue;
 
 		err = nft_delset(ctx, set);
@@ -1297,7 +1312,7 @@ static int nft_flush_table(struct nft_ctx *ctx)
 		if (!nft_is_active_next(ctx->net, chain))
 			continue;
 
-		if (nft_chain_is_bound(chain))
+		if (nft_chain_binding(chain))
 			continue;
 
 		ctx->chain = chain;
@@ -2584,6 +2599,9 @@ static int nf_tables_delchain(struct net *net, struct sock *nlsk,
 		return PTR_ERR(chain);
 	}
 
+	if (nft_chain_binding(chain))
+		return -EOPNOTSUPP;
+
 	if (nlh->nlmsg_flags & NLM_F_NONREC &&
 	    chain->use > 0)
 		return -EBUSY;
@@ -3483,6 +3501,11 @@ static int nf_tables_newrule(struct net *net, struct sock *nlsk,
 	}
 
 	if (nlh->nlmsg_flags & NLM_F_REPLACE) {
+		if (nft_chain_binding(chain)) {
+			err = -EOPNOTSUPP;
+			goto err_destroy_flow_rule;
+		}
+
 		trans = nft_trans_rule_add(&ctx, NFT_MSG_NEWRULE, rule);
 		if (trans == NULL) {
 			err = -ENOMEM;
@@ -3591,7 +3614,7 @@ static int nf_tables_delrule(struct net *net, struct sock *nlsk,
 			NL_SET_BAD_ATTR(extack, nla[NFTA_RULE_CHAIN]);
 			return PTR_ERR(chain);
 		}
-		if (nft_chain_is_bound(chain))
+		if (nft_chain_binding(chain))
 			return -EOPNOTSUPP;
 	}
 
@@ -3621,7 +3644,7 @@ static int nf_tables_delrule(struct net *net, struct sock *nlsk,
 		list_for_each_entry(chain, &table->chains, list) {
 			if (!nft_is_active_next(net, chain))
 				continue;
-			if (nft_chain_is_bound(chain))
+			if (nft_chain_binding(chain))
 				continue;
 
 			ctx.chain = chain;
@@ -4474,6 +4497,7 @@ static int nf_tables_newset(struct net *net, struct sock *nlsk,
 	}
 
 	INIT_LIST_HEAD(&set->bindings);
+	refcount_set(&set->refs, 1);
 	set->table = table;
 	write_pnet(&set->net, net);
 	set->ops = ops;
@@ -4509,6 +4533,7 @@ static int nf_tables_newset(struct net *net, struct sock *nlsk,
 	}
 
 	set->handle = nf_tables_alloc_handle(table);
+	INIT_LIST_HEAD(&set->pending_update);
 
 	err = nft_trans_set_add(&ctx, NFT_MSG_NEWSET, set);
 	if (err < 0)
@@ -4533,6 +4558,14 @@ static int nf_tables_newset(struct net *net, struct sock *nlsk,
 	return err;
 }
 
+static void nft_set_put(struct nft_set *set)
+{
+	if (refcount_dec_and_test(&set->refs)) {
+		kfree(set->name);
+		kvfree(set);
+	}
+}
+
 static void nft_set_destroy(const struct nft_ctx *ctx, struct nft_set *set)
 {
 	if (WARN_ON(set->use > 0))
@@ -4542,8 +4575,7 @@ static void nft_set_destroy(const struct nft_ctx *ctx, struct nft_set *set)
 		nft_expr_destroy(ctx, set->expr);
 
 	set->ops->destroy(ctx, set);
-	kfree(set->name);
-	kvfree(set);
+	nft_set_put(set);
 }
 
 static int nf_tables_delset(struct net *net, struct sock *nlsk,
@@ -4928,8 +4960,12 @@ static int nf_tables_dump_setelem(const struct nft_ctx *ctx,
 				  const struct nft_set_iter *iter,
 				  struct nft_set_elem *elem)
 {
+	const struct nft_set_ext *ext = nft_set_elem_ext(set, elem->priv);
 	struct nft_set_dump_args *args;
 
+	if (nft_set_elem_expired(ext))
+		return 0;
+
 	args = container_of(iter, struct nft_set_dump_args, iter);
 	return nf_tables_fill_setelem(args->skb, set, elem);
 }
@@ -5623,7 +5659,8 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 		goto err_elem_expr;
 	}
 
-	ext->genmask = nft_genmask_cur(ctx->net) | NFT_SET_ELEM_BUSY_MASK;
+	ext->genmask = nft_genmask_cur(ctx->net);
+
 	err = set->ops->insert(ctx->net, set, &elem, &ext2);
 	if (err) {
 		if (err == -EEXIST) {
@@ -5763,9 +5800,9 @@ static void nft_setelem_data_activate(const struct net *net,
 		nft_use_inc_restore(&(*nft_set_ext_obj(ext))->use);
 }
 
-static void nft_setelem_data_deactivate(const struct net *net,
-					const struct nft_set *set,
-					struct nft_set_elem *elem)
+void nft_setelem_data_deactivate(const struct net *net,
+				 const struct nft_set *set,
+				 struct nft_set_elem *elem)
 {
 	const struct nft_set_ext *ext = nft_set_elem_ext(set, elem->priv);
 
@@ -5907,8 +5944,10 @@ static int nf_tables_delsetelem(struct net *net, struct sock *nlsk,
 	if (IS_ERR(set))
 		return PTR_ERR(set);
 
-	if (!list_empty(&set->bindings) &&
-	    (set->flags & (NFT_SET_CONSTANT | NFT_SET_ANONYMOUS)))
+	if (nft_set_is_anonymous(set))
+		return -EOPNOTSUPP;
+
+	if (!list_empty(&set->bindings) && (set->flags & NFT_SET_CONSTANT))
 		return -EBUSY;
 
 	if (nla[NFTA_SET_ELEM_LIST_ELEMENTS] == NULL) {
@@ -5931,29 +5970,6 @@ static int nf_tables_delsetelem(struct net *net, struct sock *nlsk,
 	return err;
 }
 
-void nft_set_gc_batch_release(struct rcu_head *rcu)
-{
-	struct nft_set_gc_batch *gcb;
-	unsigned int i;
-
-	gcb = container_of(rcu, struct nft_set_gc_batch, head.rcu);
-	for (i = 0; i < gcb->head.cnt; i++)
-		nft_set_elem_destroy(gcb->head.set, gcb->elems[i], true);
-	kfree(gcb);
-}
-
-struct nft_set_gc_batch *nft_set_gc_batch_alloc(const struct nft_set *set,
-						gfp_t gfp)
-{
-	struct nft_set_gc_batch *gcb;
-
-	gcb = kzalloc(sizeof(*gcb), gfp);
-	if (gcb == NULL)
-		return gcb;
-	gcb->head.set = set;
-	return gcb;
-}
-
 /*
  * Stateful objects
  */
@@ -6829,13 +6845,25 @@ static void nft_unregister_flowtable_hook(struct net *net,
 				    FLOW_BLOCK_UNBIND);
 }
 
-static void nft_unregister_flowtable_net_hooks(struct net *net,
-					       struct list_head *hook_list)
+static void __nft_unregister_flowtable_net_hooks(struct net *net,
+						 struct list_head *hook_list,
+					         bool release_netdev)
 {
-	struct nft_hook *hook;
+	struct nft_hook *hook, *next;
 
-	list_for_each_entry(hook, hook_list, list)
+	list_for_each_entry_safe(hook, next, hook_list, list) {
 		nf_unregister_net_hook(net, &hook->ops);
+		if (release_netdev) {
+			list_del(&hook->list);
+			kfree_rcu(hook, rcu);
+		}
+	}
+}
+
+static void nft_unregister_flowtable_net_hooks(struct net *net,
+					       struct list_head *hook_list)
+{
+	__nft_unregister_flowtable_net_hooks(net, hook_list, false);
 }
 
 static int nft_register_flowtable_net_hooks(struct net *net,
@@ -7997,6 +8025,190 @@ void nft_chain_del(struct nft_chain *chain)
 	list_del_rcu(&chain->list);
 }
 
+static void nft_trans_gc_setelem_remove(struct nft_ctx *ctx,
+					struct nft_trans_gc *trans)
+{
+	void **priv = trans->priv;
+	unsigned int i;
+
+	for (i = 0; i < trans->count; i++) {
+		struct nft_set_elem elem = {
+			.priv = priv[i],
+		};
+
+		nft_setelem_data_deactivate(ctx->net, trans->set, &elem);
+		trans->set->ops->remove(trans->net, trans->set, &elem);
+	}
+}
+
+void nft_trans_gc_destroy(struct nft_trans_gc *trans)
+{
+	nft_set_put(trans->set);
+	put_net(trans->net);
+	kfree(trans);
+}
+
+static void nft_trans_gc_trans_free(struct rcu_head *rcu)
+{
+	struct nft_set_elem elem = {};
+	struct nft_trans_gc *trans;
+	struct nft_ctx ctx = {};
+	unsigned int i;
+
+	trans = container_of(rcu, struct nft_trans_gc, rcu);
+	ctx.net = read_pnet(&trans->set->net);
+
+	for (i = 0; i < trans->count; i++) {
+		elem.priv = trans->priv[i];
+		atomic_dec(&trans->set->nelems);
+
+		nf_tables_set_elem_destroy(&ctx, trans->set, elem.priv);
+	}
+
+	nft_trans_gc_destroy(trans);
+}
+
+static bool nft_trans_gc_work_done(struct nft_trans_gc *trans)
+{
+	struct nftables_pernet *nft_net;
+	struct nft_ctx ctx = {};
+
+	nft_net = net_generic(trans->net, nf_tables_net_id);
+
+	mutex_lock(&nft_net->commit_mutex);
+
+	/* Check for race with transaction, otherwise this batch refers to
+	 * stale objects that might not be there anymore. Skip transaction if
+	 * set has been destroyed from control plane transaction in case gc
+	 * worker loses race.
+	 */
+	if (READ_ONCE(nft_net->gc_seq) != trans->seq || trans->set->dead) {
+		mutex_unlock(&nft_net->commit_mutex);
+		return false;
+	}
+
+	ctx.net = trans->net;
+	ctx.table = trans->set->table;
+
+	nft_trans_gc_setelem_remove(&ctx, trans);
+	mutex_unlock(&nft_net->commit_mutex);
+
+	return true;
+}
+
+static void nft_trans_gc_work(struct work_struct *work)
+{
+	struct nft_trans_gc *trans, *next;
+	LIST_HEAD(trans_gc_list);
+
+	spin_lock(&nf_tables_gc_list_lock);
+	list_splice_init(&nf_tables_gc_list, &trans_gc_list);
+	spin_unlock(&nf_tables_gc_list_lock);
+
+	list_for_each_entry_safe(trans, next, &trans_gc_list, list) {
+		list_del(&trans->list);
+		if (!nft_trans_gc_work_done(trans)) {
+			nft_trans_gc_destroy(trans);
+			continue;
+		}
+		call_rcu(&trans->rcu, nft_trans_gc_trans_free);
+	}
+}
+
+struct nft_trans_gc *nft_trans_gc_alloc(struct nft_set *set,
+					unsigned int gc_seq, gfp_t gfp)
+{
+	struct net *net = read_pnet(&set->net);
+	struct nft_trans_gc *trans;
+
+	trans = kzalloc(sizeof(*trans), gfp);
+	if (!trans)
+		return NULL;
+
+	trans->net = maybe_get_net(net);
+	if (!trans->net) {
+		kfree(trans);
+		return NULL;
+	}
+
+	refcount_inc(&set->refs);
+	trans->set = set;
+	trans->seq = gc_seq;
+
+	return trans;
+}
+
+void nft_trans_gc_elem_add(struct nft_trans_gc *trans, void *priv)
+{
+	trans->priv[trans->count++] = priv;
+}
+
+static void nft_trans_gc_queue_work(struct nft_trans_gc *trans)
+{
+	spin_lock(&nf_tables_gc_list_lock);
+	list_add_tail(&trans->list, &nf_tables_gc_list);
+	spin_unlock(&nf_tables_gc_list_lock);
+
+	schedule_work(&trans_gc_work);
+}
+
+static int nft_trans_gc_space(struct nft_trans_gc *trans)
+{
+	return NFT_TRANS_GC_BATCHCOUNT - trans->count;
+}
+
+struct nft_trans_gc *nft_trans_gc_queue_async(struct nft_trans_gc *gc,
+					      unsigned int gc_seq, gfp_t gfp)
+{
+	struct nft_set *set;
+
+	if (nft_trans_gc_space(gc))
+		return gc;
+
+	set = gc->set;
+	nft_trans_gc_queue_work(gc);
+
+	return nft_trans_gc_alloc(set, gc_seq, gfp);
+}
+
+void nft_trans_gc_queue_async_done(struct nft_trans_gc *trans)
+{
+	if (trans->count == 0) {
+		nft_trans_gc_destroy(trans);
+		return;
+	}
+
+	nft_trans_gc_queue_work(trans);
+}
+
+struct nft_trans_gc *nft_trans_gc_queue_sync(struct nft_trans_gc *gc, gfp_t gfp)
+{
+	struct nft_set *set;
+
+	if (WARN_ON_ONCE(!lockdep_commit_lock_is_held(gc->net)))
+		return NULL;
+
+	if (nft_trans_gc_space(gc))
+		return gc;
+
+	set = gc->set;
+	call_rcu(&gc->rcu, nft_trans_gc_trans_free);
+
+	return nft_trans_gc_alloc(set, 0, gfp);
+}
+
+void nft_trans_gc_queue_sync_done(struct nft_trans_gc *trans)
+{
+	WARN_ON_ONCE(!lockdep_commit_lock_is_held(trans->net));
+
+	if (trans->count == 0) {
+		nft_trans_gc_destroy(trans);
+		return;
+	}
+
+	call_rcu(&trans->rcu, nft_trans_gc_trans_free);
+}
+
 static void nf_tables_module_autoload_cleanup(struct net *net)
 {
 	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
@@ -8141,13 +8353,45 @@ static void nf_tables_commit_audit_log(struct list_head *adl, u32 generation)
 	}
 }
 
+static void nft_set_commit_update(struct list_head *set_update_list)
+{
+	struct nft_set *set, *next;
+
+	list_for_each_entry_safe(set, next, set_update_list, pending_update) {
+		list_del_init(&set->pending_update);
+
+		if (!set->ops->commit)
+			continue;
+
+		set->ops->commit(set);
+	}
+}
+
+static unsigned int nft_gc_seq_begin(struct nftables_pernet *nft_net)
+{
+	unsigned int gc_seq;
+
+	/* Bump gc counter, it becomes odd, this is the busy mark. */
+	gc_seq = READ_ONCE(nft_net->gc_seq);
+	WRITE_ONCE(nft_net->gc_seq, ++gc_seq);
+
+	return gc_seq;
+}
+
+static void nft_gc_seq_end(struct nftables_pernet *nft_net, unsigned int gc_seq)
+{
+	WRITE_ONCE(nft_net->gc_seq, ++gc_seq);
+}
+
 static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 {
 	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
 	struct nft_trans *trans, *next;
+	LIST_HEAD(set_update_list);
 	struct nft_trans_elem *te;
 	struct nft_chain *chain;
 	struct nft_table *table;
+	unsigned int gc_seq;
 	LIST_HEAD(adl);
 	int err;
 
@@ -8220,6 +8464,8 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 	while (++nft_net->base_seq == 0)
 		;
 
+	gc_seq = nft_gc_seq_begin(nft_net);
+
 	/* step 3. Start new generation, rules_gen_X now in use. */
 	net->nft.gencursor = nft_gencursor_next(net);
 
@@ -8299,6 +8545,7 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 			nft_trans_destroy(trans);
 			break;
 		case NFT_MSG_DELSET:
+			nft_trans_set(trans)->dead = 1;
 			list_del_rcu(&nft_trans_set(trans)->list);
 			nf_tables_set_notify(&trans->ctx, nft_trans_set(trans),
 					     NFT_MSG_DELSET, GFP_KERNEL);
@@ -8310,6 +8557,11 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 			nf_tables_setelem_notify(&trans->ctx, te->set,
 						 &te->elem,
 						 NFT_MSG_NEWSETELEM, 0);
+			if (te->set->ops->commit &&
+			    list_empty(&te->set->pending_update)) {
+				list_add_tail(&te->set->pending_update,
+					      &set_update_list);
+			}
 			nft_trans_destroy(trans);
 			break;
 		case NFT_MSG_DELSETELEM:
@@ -8321,6 +8573,11 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 			te->set->ops->remove(net, te->set, &te->elem);
 			atomic_dec(&te->set->nelems);
 			te->set->ndeact--;
+			if (te->set->ops->commit &&
+			    list_empty(&te->set->pending_update)) {
+				list_add_tail(&te->set->pending_update,
+					      &set_update_list);
+			}
 			break;
 		case NFT_MSG_NEWOBJ:
 			if (nft_trans_obj_update(trans)) {
@@ -8381,9 +8638,13 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 		}
 	}
 
+	nft_set_commit_update(&set_update_list);
+
 	nft_commit_notify(net, NETLINK_CB(skb).portid);
 	nf_tables_gen_notify(net, skb, NFT_MSG_NEWGEN);
 	nf_tables_commit_audit_log(&adl, nft_net->base_seq);
+
+	nft_gc_seq_end(nft_net, gc_seq);
 	nf_tables_commit_release(net);
 
 	return 0;
@@ -8437,10 +8698,25 @@ static void nf_tables_abort_release(struct nft_trans *trans)
 	kfree(trans);
 }
 
+static void nft_set_abort_update(struct list_head *set_update_list)
+{
+	struct nft_set *set, *next;
+
+	list_for_each_entry_safe(set, next, set_update_list, pending_update) {
+		list_del_init(&set->pending_update);
+
+		if (!set->ops->abort)
+			continue;
+
+		set->ops->abort(set);
+	}
+}
+
 static int __nf_tables_abort(struct net *net, enum nfnl_abort_action action)
 {
 	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
 	struct nft_trans *trans, *next;
+	LIST_HEAD(set_update_list);
 	struct nft_trans_elem *te;
 
 	if (action == NFNL_ABORT_VALIDATE &&
@@ -8529,6 +8805,12 @@ static int __nf_tables_abort(struct net *net, enum nfnl_abort_action action)
 			te = (struct nft_trans_elem *)trans->data;
 			te->set->ops->remove(net, te->set, &te->elem);
 			atomic_dec(&te->set->nelems);
+
+			if (te->set->ops->abort &&
+			    list_empty(&te->set->pending_update)) {
+				list_add_tail(&te->set->pending_update,
+					      &set_update_list);
+			}
 			break;
 		case NFT_MSG_DELSETELEM:
 			te = (struct nft_trans_elem *)trans->data;
@@ -8537,6 +8819,11 @@ static int __nf_tables_abort(struct net *net, enum nfnl_abort_action action)
 			te->set->ops->activate(net, te->set, &te->elem);
 			te->set->ndeact--;
 
+			if (te->set->ops->abort &&
+			    list_empty(&te->set->pending_update)) {
+				list_add_tail(&te->set->pending_update,
+					      &set_update_list);
+			}
 			nft_trans_destroy(trans);
 			break;
 		case NFT_MSG_NEWOBJ:
@@ -8577,6 +8864,8 @@ static int __nf_tables_abort(struct net *net, enum nfnl_abort_action action)
 		}
 	}
 
+	nft_set_abort_update(&set_update_list);
+
 	synchronize_rcu();
 
 	list_for_each_entry_safe_reverse(trans, next,
@@ -8597,7 +8886,12 @@ static int nf_tables_abort(struct net *net, struct sk_buff *skb,
 			   enum nfnl_abort_action action)
 {
 	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
-	int ret = __nf_tables_abort(net, action);
+	unsigned int gc_seq;
+	int ret;
+
+	gc_seq = nft_gc_seq_begin(nft_net);
+	ret = __nf_tables_abort(net, action);
+	nft_gc_seq_end(nft_net, gc_seq);
 
 	mutex_unlock(&nft_net->commit_mutex);
 
@@ -9207,16 +9501,25 @@ int __nft_release_basechain(struct nft_ctx *ctx)
 }
 EXPORT_SYMBOL_GPL(__nft_release_basechain);
 
+static void __nft_release_hook(struct net *net, struct nft_table *table)
+{
+	struct nft_flowtable *flowtable;
+	struct nft_chain *chain;
+
+	list_for_each_entry(chain, &table->chains, list)
+		__nf_tables_unregister_hook(net, table, chain, true);
+	list_for_each_entry(flowtable, &table->flowtables, list)
+		__nft_unregister_flowtable_net_hooks(net, &flowtable->hook_list,
+						     true);
+}
+
 static void __nft_release_hooks(struct net *net)
 {
 	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
 	struct nft_table *table;
-	struct nft_chain *chain;
 
-	list_for_each_entry(table, &nft_net->tables, list) {
-		list_for_each_entry(chain, &table->chains, list)
-			nf_tables_unregister_hook(net, table, chain);
-	}
+	list_for_each_entry(table, &nft_net->tables, list)
+		__nft_release_hook(net, table);
 }
 
 static void __nft_release_table(struct net *net, struct nft_table *table)
@@ -9234,7 +9537,7 @@ static void __nft_release_table(struct net *net, struct nft_table *table)
 	ctx.family = table->family;
 	ctx.table = table;
 	list_for_each_entry(chain, &table->chains, list) {
-		if (nft_chain_is_bound(chain))
+		if (nft_chain_binding(chain))
 			continue;
 
 		ctx.chain = chain;
@@ -9293,6 +9596,7 @@ static int __net_init nf_tables_init_net(struct net *net)
 	mutex_init(&nft_net->commit_mutex);
 	nft_net->base_seq = 1;
 	nft_net->validate_state = NFT_VALIDATE_SKIP;
+	nft_net->gc_seq = 0;
 
 	return 0;
 }
@@ -9309,21 +9613,34 @@ static void __net_exit nf_tables_pre_exit_net(struct net *net)
 static void __net_exit nf_tables_exit_net(struct net *net)
 {
 	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
+	unsigned int gc_seq;
 
 	mutex_lock(&nft_net->commit_mutex);
+
+	gc_seq = nft_gc_seq_begin(nft_net);
+
 	if (!list_empty(&nft_net->commit_list))
 		__nf_tables_abort(net, NFNL_ABORT_NONE);
 	__nft_release_tables(net);
+
+	nft_gc_seq_end(nft_net, gc_seq);
+
 	mutex_unlock(&nft_net->commit_mutex);
 	WARN_ON_ONCE(!list_empty(&nft_net->tables));
 	WARN_ON_ONCE(!list_empty(&nft_net->module_list));
 	WARN_ON_ONCE(!list_empty(&nft_net->notify_list));
 }
 
+static void nf_tables_exit_batch(struct list_head *net_exit_list)
+{
+	flush_work(&trans_gc_work);
+}
+
 static struct pernet_operations nf_tables_net_ops = {
 	.init		= nf_tables_init_net,
 	.pre_exit	= nf_tables_pre_exit_net,
 	.exit		= nf_tables_exit_net,
+	.exit_batch	= nf_tables_exit_batch,
 	.id		= &nf_tables_net_id,
 	.size		= sizeof(struct nftables_pernet),
 };
@@ -9388,6 +9705,7 @@ static void __exit nf_tables_module_exit(void)
 	nft_chain_filter_fini();
 	nft_chain_route_fini();
 	unregister_pernet_subsys(&nf_tables_net_ops);
+	cancel_work_sync(&trans_gc_work);
 	cancel_work_sync(&trans_destroy_work);
 	rcu_barrier();
 	rhltable_destroy(&nft_objname_ht);
diff --git a/net/netfilter/nf_tables_core.c b/net/netfilter/nf_tables_core.c
index 9dc18429ed87..b0d711d498c6 100644
--- a/net/netfilter/nf_tables_core.c
+++ b/net/netfilter/nf_tables_core.c
@@ -125,7 +125,7 @@ static bool nft_payload_fast_eval(const struct nft_expr *expr,
 	else {
 		if (!pkt->tprot_set)
 			return false;
-		ptr = skb_network_header(skb) + pkt->xt.thoff;
+		ptr = skb_network_header(skb) + nft_thoff(pkt);
 	}
 
 	ptr += priv->offset;
diff --git a/net/netfilter/nf_tables_trace.c b/net/netfilter/nf_tables_trace.c
index 0cf3278007ba..e4fe2f0780eb 100644
--- a/net/netfilter/nf_tables_trace.c
+++ b/net/netfilter/nf_tables_trace.c
@@ -113,17 +113,17 @@ static int nf_trace_fill_pkt_info(struct sk_buff *nlskb,
 	int off = skb_network_offset(skb);
 	unsigned int len, nh_end;
 
-	nh_end = pkt->tprot_set ? pkt->xt.thoff : skb->len;
+	nh_end = pkt->tprot_set ? nft_thoff(pkt) : skb->len;
 	len = min_t(unsigned int, nh_end - skb_network_offset(skb),
 		    NFT_TRACETYPE_NETWORK_HSIZE);
 	if (trace_fill_header(nlskb, NFTA_TRACE_NETWORK_HEADER, skb, off, len))
 		return -1;
 
 	if (pkt->tprot_set) {
-		len = min_t(unsigned int, skb->len - pkt->xt.thoff,
+		len = min_t(unsigned int, skb->len - nft_thoff(pkt),
 			    NFT_TRACETYPE_TRANSPORT_HSIZE);
 		if (trace_fill_header(nlskb, NFTA_TRACE_TRANSPORT_HEADER, skb,
-				      pkt->xt.thoff, len))
+				      nft_thoff(pkt), len))
 			return -1;
 	}
 
diff --git a/net/netfilter/nft_exthdr.c b/net/netfilter/nft_exthdr.c
index 670dd146fb2b..cb69a299f10c 100644
--- a/net/netfilter/nft_exthdr.c
+++ b/net/netfilter/nft_exthdr.c
@@ -10,8 +10,10 @@
 #include <linux/netlink.h>
 #include <linux/netfilter.h>
 #include <linux/netfilter/nf_tables.h>
+#include <linux/sctp.h>
 #include <net/netfilter/nf_tables_core.h>
 #include <net/netfilter/nf_tables.h>
+#include <net/sctp/sctp.h>
 #include <net/tcp.h>
 
 struct nft_exthdr {
@@ -33,6 +35,14 @@ static unsigned int optlen(const u8 *opt, unsigned int offset)
 		return opt[offset + 1];
 }
 
+static int nft_skb_copy_to_reg(const struct sk_buff *skb, int offset, u32 *dest, unsigned int len)
+{
+	if (len % NFT_REG32_SIZE)
+		dest[len / NFT_REG32_SIZE] = 0;
+
+	return skb_copy_bits(skb, offset, dest, len);
+}
+
 static void nft_exthdr_ipv6_eval(const struct nft_expr *expr,
 				 struct nft_regs *regs,
 				 const struct nft_pktinfo *pkt)
@@ -54,8 +64,7 @@ static void nft_exthdr_ipv6_eval(const struct nft_expr *expr,
 	}
 	offset += priv->offset;
 
-	dest[priv->len / NFT_REG32_SIZE] = 0;
-	if (skb_copy_bits(pkt->skb, offset, dest, priv->len) < 0)
+	if (nft_skb_copy_to_reg(pkt->skb, offset, dest, priv->len) < 0)
 		goto err;
 	return;
 err:
@@ -151,8 +160,7 @@ static void nft_exthdr_ipv4_eval(const struct nft_expr *expr,
 	}
 	offset += priv->offset;
 
-	dest[priv->len / NFT_REG32_SIZE] = 0;
-	if (skb_copy_bits(pkt->skb, offset, dest, priv->len) < 0)
+	if (nft_skb_copy_to_reg(pkt->skb, offset, dest, priv->len) < 0)
 		goto err;
 	return;
 err:
@@ -168,7 +176,7 @@ nft_tcp_header_pointer(const struct nft_pktinfo *pkt,
 	if (!pkt->tprot_set || pkt->tprot != IPPROTO_TCP)
 		return NULL;
 
-	tcph = skb_header_pointer(pkt->skb, pkt->xt.thoff, sizeof(*tcph), buffer);
+	tcph = skb_header_pointer(pkt->skb, nft_thoff(pkt), sizeof(*tcph), buffer);
 	if (!tcph)
 		return NULL;
 
@@ -176,7 +184,7 @@ nft_tcp_header_pointer(const struct nft_pktinfo *pkt,
 	if (*tcphdr_len < sizeof(*tcph) || *tcphdr_len > len)
 		return NULL;
 
-	return skb_header_pointer(pkt->skb, pkt->xt.thoff, *tcphdr_len, buffer);
+	return skb_header_pointer(pkt->skb, nft_thoff(pkt), *tcphdr_len, buffer);
 }
 
 static void nft_exthdr_tcp_eval(const struct nft_expr *expr,
@@ -208,7 +216,8 @@ static void nft_exthdr_tcp_eval(const struct nft_expr *expr,
 		if (priv->flags & NFT_EXTHDR_F_PRESENT) {
 			*dest = 1;
 		} else {
-			dest[priv->len / NFT_REG32_SIZE] = 0;
+			if (priv->len % NFT_REG32_SIZE)
+				dest[priv->len / NFT_REG32_SIZE] = 0;
 			memcpy(dest, opt + offset, priv->len);
 		}
 
@@ -234,9 +243,14 @@ static void nft_exthdr_tcp_set_eval(const struct nft_expr *expr,
 
 	tcph = nft_tcp_header_pointer(pkt, sizeof(buff), buff, &tcphdr_len);
 	if (!tcph)
-		return;
+		goto err;
 
+	if (skb_ensure_writable(pkt->skb, nft_thoff(pkt) + tcphdr_len))
+		goto err;
+
+	tcph = (struct tcphdr *)(pkt->skb->data + nft_thoff(pkt));
 	opt = (u8 *)tcph;
+
 	for (i = sizeof(*tcph); i < tcphdr_len - 1; i += optl) {
 		union {
 			__be16 v16;
@@ -249,16 +263,7 @@ static void nft_exthdr_tcp_set_eval(const struct nft_expr *expr,
 			continue;
 
 		if (i + optl > tcphdr_len || priv->len + priv->offset > optl)
-			return;
-
-		if (skb_ensure_writable(pkt->skb,
-					pkt->xt.thoff + i + priv->len))
-			return;
-
-		tcph = nft_tcp_header_pointer(pkt, sizeof(buff), buff,
-					      &tcphdr_len);
-		if (!tcph)
-			return;
+			goto err;
 
 		offset = i + priv->offset;
 
@@ -301,6 +306,107 @@ static void nft_exthdr_tcp_set_eval(const struct nft_expr *expr,
 
 		return;
 	}
+	return;
+err:
+	regs->verdict.code = NFT_BREAK;
+}
+
+static void nft_exthdr_tcp_strip_eval(const struct nft_expr *expr,
+				      struct nft_regs *regs,
+				      const struct nft_pktinfo *pkt)
+{
+	u8 buff[sizeof(struct tcphdr) + MAX_TCP_OPTION_SPACE];
+	struct nft_exthdr *priv = nft_expr_priv(expr);
+	unsigned int i, tcphdr_len, optl;
+	struct tcphdr *tcph;
+	u8 *opt;
+
+	tcph = nft_tcp_header_pointer(pkt, sizeof(buff), buff, &tcphdr_len);
+	if (!tcph)
+		goto err;
+
+	if (skb_ensure_writable(pkt->skb, nft_thoff(pkt) + tcphdr_len))
+		goto drop;
+
+	tcph = (struct tcphdr *)(pkt->skb->data + nft_thoff(pkt));
+	opt = (u8 *)tcph;
+
+	for (i = sizeof(*tcph); i < tcphdr_len - 1; i += optl) {
+		unsigned int j;
+
+		optl = optlen(opt, i);
+		if (priv->type != opt[i])
+			continue;
+
+		if (i + optl > tcphdr_len)
+			goto drop;
+
+		for (j = 0; j < optl; ++j) {
+			u16 n = TCPOPT_NOP;
+			u16 o = opt[i+j];
+
+			if ((i + j) % 2 == 0) {
+				o <<= 8;
+				n <<= 8;
+			}
+			inet_proto_csum_replace2(&tcph->check, pkt->skb, htons(o),
+						 htons(n), false);
+		}
+		memset(opt + i, TCPOPT_NOP, optl);
+		return;
+	}
+
+	/* option not found, continue. This allows to do multiple
+	 * option removals per rule.
+	 */
+	return;
+err:
+	regs->verdict.code = NFT_BREAK;
+	return;
+drop:
+	/* can't remove, no choice but to drop */
+	regs->verdict.code = NF_DROP;
+}
+
+static void nft_exthdr_sctp_eval(const struct nft_expr *expr,
+				 struct nft_regs *regs,
+				 const struct nft_pktinfo *pkt)
+{
+	unsigned int offset = nft_thoff(pkt) + sizeof(struct sctphdr);
+	struct nft_exthdr *priv = nft_expr_priv(expr);
+	u32 *dest = &regs->data[priv->dreg];
+	const struct sctp_chunkhdr *sch;
+	struct sctp_chunkhdr _sch;
+
+	if (pkt->tprot != IPPROTO_SCTP)
+		goto err;
+
+	do {
+		sch = skb_header_pointer(pkt->skb, offset, sizeof(_sch), &_sch);
+		if (!sch || !sch->length)
+			break;
+
+		if (sch->type == priv->type) {
+			if (priv->flags & NFT_EXTHDR_F_PRESENT) {
+				nft_reg_store8(dest, true);
+				return;
+			}
+			if (priv->offset + priv->len > ntohs(sch->length) ||
+			    offset + ntohs(sch->length) > pkt->skb->len)
+				break;
+
+			if (nft_skb_copy_to_reg(pkt->skb, offset + priv->offset,
+						dest, priv->len) < 0)
+				break;
+			return;
+		}
+		offset += SCTP_PAD4(ntohs(sch->length));
+	} while (offset < pkt->skb->len);
+err:
+	if (priv->flags & NFT_EXTHDR_F_PRESENT)
+		nft_reg_store8(dest, false);
+	else
+		regs->verdict.code = NFT_BREAK;
 }
 
 static const struct nla_policy nft_exthdr_policy[NFTA_EXTHDR_MAX + 1] = {
@@ -410,6 +516,28 @@ static int nft_exthdr_tcp_set_init(const struct nft_ctx *ctx,
 				       priv->len);
 }
 
+static int nft_exthdr_tcp_strip_init(const struct nft_ctx *ctx,
+				     const struct nft_expr *expr,
+				     const struct nlattr * const tb[])
+{
+	struct nft_exthdr *priv = nft_expr_priv(expr);
+
+	if (tb[NFTA_EXTHDR_SREG] ||
+	    tb[NFTA_EXTHDR_DREG] ||
+	    tb[NFTA_EXTHDR_FLAGS] ||
+	    tb[NFTA_EXTHDR_OFFSET] ||
+	    tb[NFTA_EXTHDR_LEN])
+		return -EINVAL;
+
+	if (!tb[NFTA_EXTHDR_TYPE])
+		return -EINVAL;
+
+	priv->type = nla_get_u8(tb[NFTA_EXTHDR_TYPE]);
+	priv->op = NFT_EXTHDR_OP_TCPOPT;
+
+	return 0;
+}
+
 static int nft_exthdr_ipv4_init(const struct nft_ctx *ctx,
 				const struct nft_expr *expr,
 				const struct nlattr * const tb[])
@@ -470,6 +598,13 @@ static int nft_exthdr_dump_set(struct sk_buff *skb, const struct nft_expr *expr)
 	return nft_exthdr_dump_common(skb, priv);
 }
 
+static int nft_exthdr_dump_strip(struct sk_buff *skb, const struct nft_expr *expr)
+{
+	const struct nft_exthdr *priv = nft_expr_priv(expr);
+
+	return nft_exthdr_dump_common(skb, priv);
+}
+
 static const struct nft_expr_ops nft_exthdr_ipv6_ops = {
 	.type		= &nft_exthdr_type,
 	.size		= NFT_EXPR_SIZE(sizeof(struct nft_exthdr)),
@@ -502,6 +637,22 @@ static const struct nft_expr_ops nft_exthdr_tcp_set_ops = {
 	.dump		= nft_exthdr_dump_set,
 };
 
+static const struct nft_expr_ops nft_exthdr_tcp_strip_ops = {
+	.type		= &nft_exthdr_type,
+	.size		= NFT_EXPR_SIZE(sizeof(struct nft_exthdr)),
+	.eval		= nft_exthdr_tcp_strip_eval,
+	.init		= nft_exthdr_tcp_strip_init,
+	.dump		= nft_exthdr_dump_strip,
+};
+
+static const struct nft_expr_ops nft_exthdr_sctp_ops = {
+	.type		= &nft_exthdr_type,
+	.size		= NFT_EXPR_SIZE(sizeof(struct nft_exthdr)),
+	.eval		= nft_exthdr_sctp_eval,
+	.init		= nft_exthdr_init,
+	.dump		= nft_exthdr_dump,
+};
+
 static const struct nft_expr_ops *
 nft_exthdr_select_ops(const struct nft_ctx *ctx,
 		      const struct nlattr * const tb[])
@@ -521,7 +672,7 @@ nft_exthdr_select_ops(const struct nft_ctx *ctx,
 			return &nft_exthdr_tcp_set_ops;
 		if (tb[NFTA_EXTHDR_DREG])
 			return &nft_exthdr_tcp_ops;
-		break;
+		return &nft_exthdr_tcp_strip_ops;
 	case NFT_EXTHDR_OP_IPV6:
 		if (tb[NFTA_EXTHDR_DREG])
 			return &nft_exthdr_ipv6_ops;
@@ -532,6 +683,10 @@ nft_exthdr_select_ops(const struct nft_ctx *ctx,
 				return &nft_exthdr_ipv4_ops;
 		}
 		break;
+	case NFT_EXTHDR_OP_SCTP:
+		if (tb[NFTA_EXTHDR_DREG])
+			return &nft_exthdr_sctp_ops;
+		break;
 	}
 
 	return ERR_PTR(-EOPNOTSUPP);
diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
index d868eade6017..a44340dd3ce6 100644
--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -90,7 +90,7 @@ static void nft_flow_offload_eval(const struct nft_expr *expr,
 
 	switch (ct->tuplehash[IP_CT_DIR_ORIGINAL].tuple.dst.protonum) {
 	case IPPROTO_TCP:
-		tcph = skb_header_pointer(pkt->skb, pkt->xt.thoff,
+		tcph = skb_header_pointer(pkt->skb, nft_thoff(pkt),
 					  sizeof(_tcph), &_tcph);
 		if (unlikely(!tcph || tcph->fin || tcph->rst))
 			goto out;
diff --git a/net/netfilter/nft_payload.c b/net/netfilter/nft_payload.c
index 74c220eeec1a..b2b63c3653d4 100644
--- a/net/netfilter/nft_payload.c
+++ b/net/netfilter/nft_payload.c
@@ -110,7 +110,7 @@ void nft_payload_eval(const struct nft_expr *expr,
 	case NFT_PAYLOAD_TRANSPORT_HEADER:
 		if (!pkt->tprot_set)
 			goto err;
-		offset = pkt->xt.thoff;
+		offset = nft_thoff(pkt);
 		break;
 	default:
 		BUG();
@@ -510,7 +510,7 @@ static int nft_payload_l4csum_offset(const struct nft_pktinfo *pkt,
 		*l4csum_offset = offsetof(struct tcphdr, check);
 		break;
 	case IPPROTO_UDP:
-		if (!nft_payload_udp_checksum(skb, pkt->xt.thoff))
+		if (!nft_payload_udp_checksum(skb, nft_thoff(pkt)))
 			return -1;
 		fallthrough;
 	case IPPROTO_UDPLITE:
@@ -523,7 +523,7 @@ static int nft_payload_l4csum_offset(const struct nft_pktinfo *pkt,
 		return -1;
 	}
 
-	*l4csum_offset += pkt->xt.thoff;
+	*l4csum_offset += nft_thoff(pkt);
 	return 0;
 }
 
@@ -615,7 +615,7 @@ static void nft_payload_set_eval(const struct nft_expr *expr,
 	case NFT_PAYLOAD_TRANSPORT_HEADER:
 		if (!pkt->tprot_set)
 			goto err;
-		offset = pkt->xt.thoff;
+		offset = nft_thoff(pkt);
 		break;
 	default:
 		BUG();
@@ -646,7 +646,7 @@ static void nft_payload_set_eval(const struct nft_expr *expr,
 	if (priv->csum_type == NFT_PAYLOAD_CSUM_SCTP &&
 	    pkt->tprot == IPPROTO_SCTP &&
 	    skb->ip_summed != CHECKSUM_PARTIAL) {
-		if (nft_payload_csum_sctp(skb, pkt->xt.thoff))
+		if (nft_payload_csum_sctp(skb, nft_thoff(pkt)))
 			goto err;
 	}
 
diff --git a/net/netfilter/nft_reject_inet.c b/net/netfilter/nft_reject_inet.c
index cf8f2646e93c..c00b94a16682 100644
--- a/net/netfilter/nft_reject_inet.c
+++ b/net/netfilter/nft_reject_inet.c
@@ -28,7 +28,8 @@ static void nft_reject_inet_eval(const struct nft_expr *expr,
 					nft_hook(pkt));
 			break;
 		case NFT_REJECT_TCP_RST:
-			nf_send_reset(nft_net(pkt), pkt->skb, nft_hook(pkt));
+			nf_send_reset(nft_net(pkt), nft_sk(pkt),
+				      pkt->skb, nft_hook(pkt));
 			break;
 		case NFT_REJECT_ICMPX_UNREACH:
 			nf_send_unreach(pkt->skb,
@@ -44,7 +45,8 @@ static void nft_reject_inet_eval(const struct nft_expr *expr,
 					 priv->icmp_code, nft_hook(pkt));
 			break;
 		case NFT_REJECT_TCP_RST:
-			nf_send_reset6(nft_net(pkt), pkt->skb, nft_hook(pkt));
+			nf_send_reset6(nft_net(pkt), nft_sk(pkt),
+				       pkt->skb, nft_hook(pkt));
 			break;
 		case NFT_REJECT_ICMPX_UNREACH:
 			nf_send_unreach6(nft_net(pkt), pkt->skb,
diff --git a/net/netfilter/nft_set_hash.c b/net/netfilter/nft_set_hash.c
index 51d3e6f0934a..f0a9ad1c4ea4 100644
--- a/net/netfilter/nft_set_hash.c
+++ b/net/netfilter/nft_set_hash.c
@@ -17,6 +17,9 @@
 #include <linux/netfilter.h>
 #include <linux/netfilter/nf_tables.h>
 #include <net/netfilter/nf_tables_core.h>
+#include <net/netns/generic.h>
+
+extern unsigned int nf_tables_net_id;
 
 /* We target a hash table size of 4, element hint is 75% of final size */
 #define NFT_RHASH_ELEMENT_HINT 3
@@ -59,6 +62,8 @@ static inline int nft_rhash_cmp(struct rhashtable_compare_arg *arg,
 
 	if (memcmp(nft_set_ext_key(&he->ext), x->key, x->set->klen))
 		return 1;
+	if (nft_set_elem_is_dead(&he->ext))
+		return 1;
 	if (nft_set_elem_expired(&he->ext))
 		return 1;
 	if (!nft_set_elem_active(&he->ext, x->genmask))
@@ -187,7 +192,6 @@ static void nft_rhash_activate(const struct net *net, const struct nft_set *set,
 	struct nft_rhash_elem *he = elem->priv;
 
 	nft_set_elem_change_active(net, set, &he->ext);
-	nft_set_elem_clear_busy(&he->ext);
 }
 
 static bool nft_rhash_flush(const struct net *net,
@@ -195,12 +199,9 @@ static bool nft_rhash_flush(const struct net *net,
 {
 	struct nft_rhash_elem *he = priv;
 
-	if (!nft_set_elem_mark_busy(&he->ext) ||
-	    !nft_is_active(net, &he->ext)) {
-		nft_set_elem_change_active(net, set, &he->ext);
-		return true;
-	}
-	return false;
+	nft_set_elem_change_active(net, set, &he->ext);
+
+	return true;
 }
 
 static void *nft_rhash_deactivate(const struct net *net,
@@ -217,9 +218,8 @@ static void *nft_rhash_deactivate(const struct net *net,
 
 	rcu_read_lock();
 	he = rhashtable_lookup(&priv->ht, &arg, nft_rhash_params);
-	if (he != NULL &&
-	    !nft_rhash_flush(net, set, he))
-		he = NULL;
+	if (he)
+		nft_set_elem_change_active(net, set, &he->ext);
 
 	rcu_read_unlock();
 
@@ -251,7 +251,9 @@ static bool nft_rhash_delete(const struct nft_set *set,
 	if (he == NULL)
 		return false;
 
-	return rhashtable_remove_fast(&priv->ht, &he->node, nft_rhash_params) == 0;
+	nft_set_elem_dead(&he->ext);
+
+	return true;
 }
 
 static void nft_rhash_walk(const struct nft_ctx *ctx, struct nft_set *set,
@@ -277,8 +279,6 @@ static void nft_rhash_walk(const struct nft_ctx *ctx, struct nft_set *set,
 
 		if (iter->count < iter->skip)
 			goto cont;
-		if (nft_set_elem_expired(&he->ext))
-			goto cont;
 		if (!nft_set_elem_active(&he->ext, iter->genmask))
 			goto cont;
 
@@ -297,49 +297,75 @@ static void nft_rhash_walk(const struct nft_ctx *ctx, struct nft_set *set,
 
 static void nft_rhash_gc(struct work_struct *work)
 {
+	struct nftables_pernet *nft_net;
 	struct nft_set *set;
 	struct nft_rhash_elem *he;
 	struct nft_rhash *priv;
-	struct nft_set_gc_batch *gcb = NULL;
 	struct rhashtable_iter hti;
+	struct nft_trans_gc *gc;
+	struct net *net;
+	u32 gc_seq;
 
 	priv = container_of(work, struct nft_rhash, gc_work.work);
 	set  = nft_set_container_of(priv);
+	net  = read_pnet(&set->net);
+	nft_net = net_generic(net, nf_tables_net_id);
+	gc_seq = READ_ONCE(nft_net->gc_seq);
+
+	if (nft_set_gc_is_pending(set))
+		goto done;
+
+	gc = nft_trans_gc_alloc(set, gc_seq, GFP_KERNEL);
+	if (!gc)
+		goto done;
 
 	rhashtable_walk_enter(&priv->ht, &hti);
 	rhashtable_walk_start(&hti);
 
 	while ((he = rhashtable_walk_next(&hti))) {
 		if (IS_ERR(he)) {
-			if (PTR_ERR(he) != -EAGAIN)
-				break;
-			continue;
+			nft_trans_gc_destroy(gc);
+			gc = NULL;
+			goto try_later;
 		}
 
+		/* Ruleset has been updated, try later. */
+		if (READ_ONCE(nft_net->gc_seq) != gc_seq) {
+			nft_trans_gc_destroy(gc);
+			gc = NULL;
+			goto try_later;
+		}
+
+		if (nft_set_elem_is_dead(&he->ext))
+			goto dead_elem;
+
 		if (nft_set_ext_exists(&he->ext, NFT_SET_EXT_EXPR)) {
 			struct nft_expr *expr = nft_set_ext_expr(&he->ext);
 
 			if (expr->ops->gc &&
 			    expr->ops->gc(read_pnet(&set->net), expr))
-				goto gc;
+				goto needs_gc_run;
 		}
+
 		if (!nft_set_elem_expired(&he->ext))
 			continue;
-gc:
-		if (nft_set_elem_mark_busy(&he->ext))
-			continue;
-
-		gcb = nft_set_gc_batch_check(set, gcb, GFP_ATOMIC);
-		if (gcb == NULL)
-			break;
-		rhashtable_remove_fast(&priv->ht, &he->node, nft_rhash_params);
-		atomic_dec(&set->nelems);
-		nft_set_gc_batch_add(gcb, he);
+needs_gc_run:
+		nft_set_elem_dead(&he->ext);
+dead_elem:
+		gc = nft_trans_gc_queue_async(gc, gc_seq, GFP_ATOMIC);
+		if (!gc)
+			goto try_later;
+
+		nft_trans_gc_elem_add(gc, he);
 	}
+
+try_later:
 	rhashtable_walk_stop(&hti);
 	rhashtable_walk_exit(&hti);
 
-	nft_set_gc_batch_complete(gcb);
+	if (gc)
+		nft_trans_gc_queue_async_done(gc);
+done:
 	queue_delayed_work(system_power_efficient_wq, &priv->gc_work,
 			   nft_set_gc_interval(set));
 }
@@ -374,7 +400,7 @@ static int nft_rhash_init(const struct nft_set *set,
 		return err;
 
 	INIT_DEFERRABLE_WORK(&priv->gc_work, nft_rhash_gc);
-	if (set->flags & NFT_SET_TIMEOUT)
+	if (set->flags & (NFT_SET_TIMEOUT | NFT_SET_EVAL))
 		nft_rhash_gc_init(set);
 
 	return 0;
@@ -402,7 +428,6 @@ static void nft_rhash_destroy(const struct nft_ctx *ctx,
 	};
 
 	cancel_delayed_work_sync(&priv->gc_work);
-	rcu_barrier();
 	rhashtable_free_and_destroy(&priv->ht, nft_rhash_elem_destroy,
 				    (void *)&rhash_ctx);
 }
diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 50f840e312b0..fbfcc3275cad 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -566,8 +566,9 @@ static struct nft_pipapo_elem *pipapo_get(const struct net *net,
 			goto out;
 
 		if (last) {
-			if (nft_set_elem_expired(&f->mt[b].e->ext) ||
-			    (genmask &&
+			if (nft_set_elem_expired(&f->mt[b].e->ext))
+				goto next_match;
+			if ((genmask &&
 			     !nft_set_elem_active(&f->mt[b].e->ext, genmask)))
 				goto next_match;
 
@@ -1536,15 +1537,32 @@ static void pipapo_drop(struct nft_pipapo_match *m,
 	}
 }
 
+static void nft_pipapo_gc_deactivate(struct net *net, struct nft_set *set,
+				     struct nft_pipapo_elem *e)
+{
+	struct nft_set_elem elem = {
+		.priv   = e,
+	};
+
+	nft_setelem_data_deactivate(net, set, &elem);
+}
+
 /**
  * pipapo_gc() - Drop expired entries from set, destroy start and end elements
- * @set:	nftables API set representation
+ * @_set:	nftables API set representation
  * @m:		Matching data
  */
-static void pipapo_gc(const struct nft_set *set, struct nft_pipapo_match *m)
+static void pipapo_gc(const struct nft_set *_set, struct nft_pipapo_match *m)
 {
+	struct nft_set *set = (struct nft_set *) _set;
 	struct nft_pipapo *priv = nft_set_priv(set);
+	struct net *net = read_pnet(&set->net);
 	int rules_f0, first_rule = 0;
+	struct nft_trans_gc *gc;
+
+	gc = nft_trans_gc_alloc(set, 0, GFP_KERNEL);
+	if (!gc)
+		return;
 
 	while ((rules_f0 = pipapo_rules_same_key(m->f, first_rule))) {
 		union nft_pipapo_map_bucket rulemap[NFT_PIPAPO_MAX_FIELDS];
@@ -1569,13 +1587,19 @@ static void pipapo_gc(const struct nft_set *set, struct nft_pipapo_match *m)
 		f--;
 		i--;
 		e = f->mt[rulemap[i].to].e;
-		if (nft_set_elem_expired(&e->ext) &&
-		    !nft_set_elem_mark_busy(&e->ext)) {
+		/* synchronous gc never fails, there is no need to set on
+		 * NFT_SET_ELEM_DEAD_BIT.
+		 */
+		if (nft_set_elem_expired(&e->ext)) {
 			priv->dirty = true;
-			pipapo_drop(m, rulemap);
 
-			rcu_barrier();
-			nft_set_elem_destroy(set, e, true);
+			gc = nft_trans_gc_queue_sync(gc, GFP_ATOMIC);
+			if (!gc)
+				return;
+
+			nft_pipapo_gc_deactivate(net, set, e);
+			pipapo_drop(m, rulemap);
+			nft_trans_gc_elem_add(gc, e);
 
 			/* And check again current first rule, which is now the
 			 * first we haven't checked.
@@ -1585,7 +1609,10 @@ static void pipapo_gc(const struct nft_set *set, struct nft_pipapo_match *m)
 		}
 	}
 
-	priv->last_gc = jiffies;
+	if (gc) {
+		nft_trans_gc_queue_sync_done(gc);
+		priv->last_gc = jiffies;
+	}
 }
 
 /**
@@ -1603,17 +1630,10 @@ static void pipapo_free_fields(struct nft_pipapo_match *m)
 	}
 }
 
-/**
- * pipapo_reclaim_match - RCU callback to free fields from old matching data
- * @rcu:	RCU head
- */
-static void pipapo_reclaim_match(struct rcu_head *rcu)
+static void pipapo_free_match(struct nft_pipapo_match *m)
 {
-	struct nft_pipapo_match *m;
 	int i;
 
-	m = container_of(rcu, struct nft_pipapo_match, rcu);
-
 	for_each_possible_cpu(i)
 		kfree(*per_cpu_ptr(m->scratch, i));
 
@@ -1628,7 +1648,19 @@ static void pipapo_reclaim_match(struct rcu_head *rcu)
 }
 
 /**
- * pipapo_commit() - Replace lookup data with current working copy
+ * pipapo_reclaim_match - RCU callback to free fields from old matching data
+ * @rcu:	RCU head
+ */
+static void pipapo_reclaim_match(struct rcu_head *rcu)
+{
+	struct nft_pipapo_match *m;
+
+	m = container_of(rcu, struct nft_pipapo_match, rcu);
+	pipapo_free_match(m);
+}
+
+/**
+ * nft_pipapo_commit() - Replace lookup data with current working copy
  * @set:	nftables API set representation
  *
  * While at it, check if we should perform garbage collection on the working
@@ -1638,7 +1670,7 @@ static void pipapo_reclaim_match(struct rcu_head *rcu)
  * We also need to create a new working copy for subsequent insertions and
  * deletions.
  */
-static void pipapo_commit(const struct nft_set *set)
+static void nft_pipapo_commit(const struct nft_set *set)
 {
 	struct nft_pipapo *priv = nft_set_priv(set);
 	struct nft_pipapo_match *new_clone, *old;
@@ -1663,6 +1695,26 @@ static void pipapo_commit(const struct nft_set *set)
 	priv->clone = new_clone;
 }
 
+static void nft_pipapo_abort(const struct nft_set *set)
+{
+	struct nft_pipapo *priv = nft_set_priv(set);
+	struct nft_pipapo_match *new_clone, *m;
+
+	if (!priv->dirty)
+		return;
+
+	m = rcu_dereference(priv->match);
+
+	new_clone = pipapo_clone(m);
+	if (IS_ERR(new_clone))
+		return;
+
+	priv->dirty = false;
+
+	pipapo_free_match(priv->clone);
+	priv->clone = new_clone;
+}
+
 /**
  * nft_pipapo_activate() - Mark element reference as active given key, commit
  * @net:	Network namespace
@@ -1670,8 +1722,7 @@ static void pipapo_commit(const struct nft_set *set)
  * @elem:	nftables API element representation containing key data
  *
  * On insertion, elements are added to a copy of the matching data currently
- * in use for lookups, and not directly inserted into current lookup data, so
- * we'll take care of that by calling pipapo_commit() here. Both
+ * in use for lookups, and not directly inserted into current lookup data. Both
  * nft_pipapo_insert() and nft_pipapo_activate() are called once for each
  * element, hence we can't purpose either one as a real commit operation.
  */
@@ -1679,16 +1730,9 @@ static void nft_pipapo_activate(const struct net *net,
 				const struct nft_set *set,
 				const struct nft_set_elem *elem)
 {
-	struct nft_pipapo_elem *e;
-
-	e = pipapo_get(net, set, (const u8 *)elem->key.val.data, 0);
-	if (IS_ERR(e))
-		return;
+	struct nft_pipapo_elem *e = elem->priv;
 
 	nft_set_elem_change_active(net, set, &e->ext);
-	nft_set_elem_clear_busy(&e->ext);
-
-	pipapo_commit(set);
 }
 
 /**
@@ -1900,10 +1944,6 @@ static void nft_pipapo_remove(const struct net *net, const struct nft_set *set,
 
 	data = (const u8 *)nft_set_ext_key(&e->ext);
 
-	e = pipapo_get(net, set, data, 0);
-	if (IS_ERR(e))
-		return;
-
 	while ((rules_f0 = pipapo_rules_same_key(m->f, first_rule))) {
 		union nft_pipapo_map_bucket rulemap[NFT_PIPAPO_MAX_FIELDS];
 		const u8 *match_start, *match_end;
@@ -1938,7 +1978,6 @@ static void nft_pipapo_remove(const struct net *net, const struct nft_set *set,
 		if (i == m->field_count) {
 			priv->dirty = true;
 			pipapo_drop(m, rulemap);
-			pipapo_commit(set);
 			return;
 		}
 
@@ -1988,8 +2027,6 @@ static void nft_pipapo_walk(const struct nft_ctx *ctx, struct nft_set *set,
 			goto cont;
 
 		e = f->mt[r].e;
-		if (nft_set_elem_expired(&e->ext))
-			goto cont;
 
 		elem.priv = e;
 
@@ -2245,6 +2282,8 @@ const struct nft_set_type nft_set_pipapo_type = {
 		.init		= nft_pipapo_init,
 		.destroy	= nft_pipapo_destroy,
 		.gc_init	= nft_pipapo_gc_init,
+		.commit		= nft_pipapo_commit,
+		.abort		= nft_pipapo_abort,
 		.elemsize	= offsetof(struct nft_pipapo_elem, ext),
 	},
 };
@@ -2267,6 +2306,8 @@ const struct nft_set_type nft_set_pipapo_avx2_type = {
 		.init		= nft_pipapo_init,
 		.destroy	= nft_pipapo_destroy,
 		.gc_init	= nft_pipapo_gc_init,
+		.commit		= nft_pipapo_commit,
+		.abort		= nft_pipapo_abort,
 		.elemsize	= offsetof(struct nft_pipapo_elem, ext),
 	},
 };
diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
index eae760adae4d..17abf17b673e 100644
--- a/net/netfilter/nft_set_rbtree.c
+++ b/net/netfilter/nft_set_rbtree.c
@@ -14,6 +14,9 @@
 #include <linux/netfilter.h>
 #include <linux/netfilter/nf_tables.h>
 #include <net/netfilter/nf_tables_core.h>
+#include <net/netns/generic.h>
+
+extern unsigned int nf_tables_net_id;
 
 struct nft_rbtree {
 	struct rb_root		root;
@@ -46,6 +49,12 @@ static int nft_rbtree_cmp(const struct nft_set *set,
 		      set->klen);
 }
 
+static bool nft_rbtree_elem_expired(const struct nft_rbtree_elem *rbe)
+{
+	return nft_set_elem_expired(&rbe->ext) ||
+	       nft_set_elem_is_dead(&rbe->ext);
+}
+
 static bool __nft_rbtree_lookup(const struct net *net, const struct nft_set *set,
 				const u32 *key, const struct nft_set_ext **ext,
 				unsigned int seq)
@@ -80,7 +89,7 @@ static bool __nft_rbtree_lookup(const struct net *net, const struct nft_set *set
 				continue;
 			}
 
-			if (nft_set_elem_expired(&rbe->ext))
+			if (nft_rbtree_elem_expired(rbe))
 				return false;
 
 			if (nft_rbtree_interval_end(rbe)) {
@@ -98,7 +107,7 @@ static bool __nft_rbtree_lookup(const struct net *net, const struct nft_set *set
 
 	if (set->flags & NFT_SET_INTERVAL && interval != NULL &&
 	    nft_set_elem_active(&interval->ext, genmask) &&
-	    !nft_set_elem_expired(&interval->ext) &&
+	    !nft_rbtree_elem_expired(interval) &&
 	    nft_rbtree_interval_start(interval)) {
 		*ext = &interval->ext;
 		return true;
@@ -214,19 +223,31 @@ static void *nft_rbtree_get(const struct net *net, const struct nft_set *set,
 	return rbe;
 }
 
-static int nft_rbtree_gc_elem(const struct nft_set *__set,
-			      struct nft_rbtree *priv,
-			      struct nft_rbtree_elem *rbe,
-			      u8 genmask)
+static void nft_rbtree_gc_remove(struct net *net, struct nft_set *set,
+				 struct nft_rbtree *priv,
+				 struct nft_rbtree_elem *rbe)
+{
+	struct nft_set_elem elem = {
+		.priv   = rbe,
+	};
+
+	nft_setelem_data_deactivate(net, set, &elem);
+	rb_erase(&rbe->node, &priv->root);
+}
+
+static const struct nft_rbtree_elem *
+nft_rbtree_gc_elem(const struct nft_set *__set, struct nft_rbtree *priv,
+		   struct nft_rbtree_elem *rbe, u8 genmask)
 {
 	struct nft_set *set = (struct nft_set *)__set;
 	struct rb_node *prev = rb_prev(&rbe->node);
+	struct net *net = read_pnet(&set->net);
 	struct nft_rbtree_elem *rbe_prev;
-	struct nft_set_gc_batch *gcb;
+	struct nft_trans_gc *gc;
 
-	gcb = nft_set_gc_batch_check(set, NULL, GFP_ATOMIC);
-	if (!gcb)
-		return -ENOMEM;
+	gc = nft_trans_gc_alloc(set, 0, GFP_ATOMIC);
+	if (!gc)
+		return ERR_PTR(-ENOMEM);
 
 	/* search for end interval coming before this element.
 	 * end intervals don't carry a timeout extension, they
@@ -241,21 +262,33 @@ static int nft_rbtree_gc_elem(const struct nft_set *__set,
 		prev = rb_prev(prev);
 	}
 
+	rbe_prev = NULL;
 	if (prev) {
 		rbe_prev = rb_entry(prev, struct nft_rbtree_elem, node);
+		nft_rbtree_gc_remove(net, set, priv, rbe_prev);
 
-		rb_erase(&rbe_prev->node, &priv->root);
-		atomic_dec(&set->nelems);
-		nft_set_gc_batch_add(gcb, rbe_prev);
+		/* There is always room in this trans gc for this element,
+		 * memory allocation never actually happens, hence, the warning
+		 * splat in such case. No need to set NFT_SET_ELEM_DEAD_BIT,
+		 * this is synchronous gc which never fails.
+		 */
+		gc = nft_trans_gc_queue_sync(gc, GFP_ATOMIC);
+		if (WARN_ON_ONCE(!gc))
+			return ERR_PTR(-ENOMEM);
+
+		nft_trans_gc_elem_add(gc, rbe_prev);
 	}
 
-	rb_erase(&rbe->node, &priv->root);
-	atomic_dec(&set->nelems);
+	nft_rbtree_gc_remove(net, set, priv, rbe);
+	gc = nft_trans_gc_queue_sync(gc, GFP_ATOMIC);
+	if (WARN_ON_ONCE(!gc))
+		return ERR_PTR(-ENOMEM);
 
-	nft_set_gc_batch_add(gcb, rbe);
-	nft_set_gc_batch_complete(gcb);
+	nft_trans_gc_elem_add(gc, rbe);
 
-	return 0;
+	nft_trans_gc_queue_sync_done(gc);
+
+	return rbe_prev;
 }
 
 static bool nft_rbtree_update_first(const struct nft_set *set,
@@ -281,8 +314,9 @@ static int __nft_rbtree_insert(const struct net *net, const struct nft_set *set,
 	struct nft_rbtree_elem *rbe, *rbe_le = NULL, *rbe_ge = NULL;
 	struct rb_node *node, *next, *parent, **p, *first = NULL;
 	struct nft_rbtree *priv = nft_set_priv(set);
+	u8 cur_genmask = nft_genmask_cur(net);
 	u8 genmask = nft_genmask_next(net);
-	int d, err;
+	int d;
 
 	/* Descend the tree to search for an existing element greater than the
 	 * key value to insert that is greater than the new element. This is the
@@ -326,11 +360,19 @@ static int __nft_rbtree_insert(const struct net *net, const struct nft_set *set,
 		if (!nft_set_elem_active(&rbe->ext, genmask))
 			continue;
 
-		/* perform garbage collection to avoid bogus overlap reports. */
-		if (nft_set_elem_expired(&rbe->ext)) {
-			err = nft_rbtree_gc_elem(set, priv, rbe, genmask);
-			if (err < 0)
-				return err;
+		/* perform garbage collection to avoid bogus overlap reports
+		 * but skip new elements in this transaction.
+		 */
+		if (nft_set_elem_expired(&rbe->ext) &&
+		    nft_set_elem_active(&rbe->ext, cur_genmask)) {
+			const struct nft_rbtree_elem *removed_end;
+
+			removed_end = nft_rbtree_gc_elem(set, priv, rbe, genmask);
+			if (IS_ERR(removed_end))
+				return PTR_ERR(removed_end);
+
+			if (removed_end == rbe_le || removed_end == rbe_ge)
+				return -EAGAIN;
 
 			continue;
 		}
@@ -451,11 +493,18 @@ static int nft_rbtree_insert(const struct net *net, const struct nft_set *set,
 	struct nft_rbtree_elem *rbe = elem->priv;
 	int err;
 
-	write_lock_bh(&priv->lock);
-	write_seqcount_begin(&priv->count);
-	err = __nft_rbtree_insert(net, set, rbe, ext);
-	write_seqcount_end(&priv->count);
-	write_unlock_bh(&priv->lock);
+	do {
+		if (fatal_signal_pending(current))
+			return -EINTR;
+
+		cond_resched();
+
+		write_lock_bh(&priv->lock);
+		write_seqcount_begin(&priv->count);
+		err = __nft_rbtree_insert(net, set, rbe, ext);
+		write_seqcount_end(&priv->count);
+		write_unlock_bh(&priv->lock);
+	} while (err == -EAGAIN);
 
 	return err;
 }
@@ -481,7 +530,6 @@ static void nft_rbtree_activate(const struct net *net,
 	struct nft_rbtree_elem *rbe = elem->priv;
 
 	nft_set_elem_change_active(net, set, &rbe->ext);
-	nft_set_elem_clear_busy(&rbe->ext);
 }
 
 static bool nft_rbtree_flush(const struct net *net,
@@ -489,12 +537,9 @@ static bool nft_rbtree_flush(const struct net *net,
 {
 	struct nft_rbtree_elem *rbe = priv;
 
-	if (!nft_set_elem_mark_busy(&rbe->ext) ||
-	    !nft_is_active(net, &rbe->ext)) {
-		nft_set_elem_change_active(net, set, &rbe->ext);
-		return true;
-	}
-	return false;
+	nft_set_elem_change_active(net, set, &rbe->ext);
+
+	return true;
 }
 
 static void *nft_rbtree_deactivate(const struct net *net,
@@ -551,8 +596,6 @@ static void nft_rbtree_walk(const struct nft_ctx *ctx,
 
 		if (iter->count < iter->skip)
 			goto cont;
-		if (nft_set_elem_expired(&rbe->ext))
-			goto cont;
 		if (!nft_set_elem_active(&rbe->ext, iter->genmask))
 			goto cont;
 
@@ -571,26 +614,42 @@ static void nft_rbtree_walk(const struct nft_ctx *ctx,
 
 static void nft_rbtree_gc(struct work_struct *work)
 {
-	struct nft_rbtree_elem *rbe, *rbe_end = NULL, *rbe_prev = NULL;
-	struct nft_set_gc_batch *gcb = NULL;
+	struct nft_rbtree_elem *rbe, *rbe_end = NULL;
+	struct nftables_pernet *nft_net;
 	struct nft_rbtree *priv;
+	struct nft_trans_gc *gc;
 	struct rb_node *node;
 	struct nft_set *set;
+	unsigned int gc_seq;
 	struct net *net;
-	u8 genmask;
 
 	priv = container_of(work, struct nft_rbtree, gc_work.work);
 	set  = nft_set_container_of(priv);
 	net  = read_pnet(&set->net);
-	genmask = nft_genmask_cur(net);
+	nft_net = net_generic(net, nf_tables_net_id);
+	gc_seq	= READ_ONCE(nft_net->gc_seq);
 
-	write_lock_bh(&priv->lock);
-	write_seqcount_begin(&priv->count);
+	if (nft_set_gc_is_pending(set))
+		goto done;
+
+	gc = nft_trans_gc_alloc(set, gc_seq, GFP_KERNEL);
+	if (!gc)
+		goto done;
+
+	read_lock_bh(&priv->lock);
 	for (node = rb_first(&priv->root); node != NULL; node = rb_next(node)) {
+
+		/* Ruleset has been updated, try later. */
+		if (READ_ONCE(nft_net->gc_seq) != gc_seq) {
+			nft_trans_gc_destroy(gc);
+			gc = NULL;
+			goto try_later;
+		}
+
 		rbe = rb_entry(node, struct nft_rbtree_elem, node);
 
-		if (!nft_set_elem_active(&rbe->ext, genmask))
-			continue;
+		if (nft_set_elem_is_dead(&rbe->ext))
+			goto dead_elem;
 
 		/* elements are reversed in the rbtree for historical reasons,
 		 * from highest to lowest value, that is why end element is
@@ -603,40 +662,32 @@ static void nft_rbtree_gc(struct work_struct *work)
 		if (!nft_set_elem_expired(&rbe->ext))
 			continue;
 
-		if (nft_set_elem_mark_busy(&rbe->ext)) {
-			rbe_end = NULL;
+		nft_set_elem_dead(&rbe->ext);
+
+		if (!rbe_end)
 			continue;
-		}
 
-		if (rbe_prev) {
-			rb_erase(&rbe_prev->node, &priv->root);
-			rbe_prev = NULL;
-		}
-		gcb = nft_set_gc_batch_check(set, gcb, GFP_ATOMIC);
-		if (!gcb)
-			break;
+		nft_set_elem_dead(&rbe_end->ext);
 
-		atomic_dec(&set->nelems);
-		nft_set_gc_batch_add(gcb, rbe);
-		rbe_prev = rbe;
+		gc = nft_trans_gc_queue_async(gc, gc_seq, GFP_ATOMIC);
+		if (!gc)
+			goto try_later;
 
-		if (rbe_end) {
-			atomic_dec(&set->nelems);
-			nft_set_gc_batch_add(gcb, rbe_end);
-			rb_erase(&rbe_end->node, &priv->root);
-			rbe_end = NULL;
-		}
-		node = rb_next(node);
-		if (!node)
-			break;
-	}
-	if (rbe_prev)
-		rb_erase(&rbe_prev->node, &priv->root);
-	write_seqcount_end(&priv->count);
-	write_unlock_bh(&priv->lock);
+		nft_trans_gc_elem_add(gc, rbe_end);
+		rbe_end = NULL;
+dead_elem:
+		gc = nft_trans_gc_queue_async(gc, gc_seq, GFP_ATOMIC);
+		if (!gc)
+			goto try_later;
 
-	nft_set_gc_batch_complete(gcb);
+		nft_trans_gc_elem_add(gc, rbe);
+	}
+try_later:
+	read_unlock_bh(&priv->lock);
 
+	if (gc)
+		nft_trans_gc_queue_async_done(gc);
+done:
 	queue_delayed_work(system_power_efficient_wq, &priv->gc_work,
 			   nft_set_gc_interval(set));
 }
diff --git a/net/netfilter/nft_synproxy.c b/net/netfilter/nft_synproxy.c
index 59c4dfaf2ea1..1133e06f3c40 100644
--- a/net/netfilter/nft_synproxy.c
+++ b/net/netfilter/nft_synproxy.c
@@ -109,7 +109,7 @@ static void nft_synproxy_do_eval(const struct nft_synproxy *priv,
 {
 	struct synproxy_options opts = {};
 	struct sk_buff *skb = pkt->skb;
-	int thoff = pkt->xt.thoff;
+	int thoff = nft_thoff(pkt);
 	const struct tcphdr *tcp;
 	struct tcphdr _tcph;
 
@@ -123,7 +123,7 @@ static void nft_synproxy_do_eval(const struct nft_synproxy *priv,
 		return;
 	}
 
-	tcp = skb_header_pointer(skb, pkt->xt.thoff,
+	tcp = skb_header_pointer(skb, thoff,
 				 sizeof(struct tcphdr),
 				 &_tcph);
 	if (!tcp) {
diff --git a/net/netfilter/nft_tproxy.c b/net/netfilter/nft_tproxy.c
index c49d318f8e6e..f8d277e05ef4 100644
--- a/net/netfilter/nft_tproxy.c
+++ b/net/netfilter/nft_tproxy.c
@@ -88,9 +88,9 @@ static void nft_tproxy_eval_v6(const struct nft_expr *expr,
 	const struct nft_tproxy *priv = nft_expr_priv(expr);
 	struct sk_buff *skb = pkt->skb;
 	const struct ipv6hdr *iph = ipv6_hdr(skb);
-	struct in6_addr taddr;
-	int thoff = pkt->xt.thoff;
+	int thoff = nft_thoff(pkt);
 	struct udphdr _hdr, *hp;
+	struct in6_addr taddr;
 	__be16 tport = 0;
 	struct sock *sk;
 	int l4proto;
diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index ddfd159f64e1..b1107570eaee 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -1646,7 +1646,9 @@ int nfc_llcp_register_device(struct nfc_dev *ndev)
 	timer_setup(&local->sdreq_timer, nfc_llcp_sdreq_timer, 0);
 	INIT_WORK(&local->sdreq_timeout_work, nfc_llcp_sdreq_timeout_work);
 
+	spin_lock(&llcp_devices_lock);
 	list_add(&local->list, &llcp_devices);
+	spin_unlock(&llcp_devices_lock);
 
 	return 0;
 }
diff --git a/net/rds/rdma_transport.c b/net/rds/rdma_transport.c
index 5f741e51b4ba..bb38124a5d3d 100644
--- a/net/rds/rdma_transport.c
+++ b/net/rds/rdma_transport.c
@@ -86,10 +86,12 @@ static int rds_rdma_cm_event_handler_cmn(struct rdma_cm_id *cm_id,
 		break;
 
 	case RDMA_CM_EVENT_ADDR_RESOLVED:
-		rdma_set_service_type(cm_id, conn->c_tos);
-		/* XXX do we need to clean up if this fails? */
-		ret = rdma_resolve_route(cm_id,
+		if (conn) {
+			rdma_set_service_type(cm_id, conn->c_tos);
+			/* XXX do we need to clean up if this fails? */
+			ret = rdma_resolve_route(cm_id,
 					 RDS_RDMA_RESOLVE_TIMEOUT_MS);
+		}
 		break;
 
 	case RDMA_CM_EVENT_ROUTE_RESOLVED:
diff --git a/net/rds/tcp_connect.c b/net/rds/tcp_connect.c
index 4e64598176b0..2f38dac0160e 100644
--- a/net/rds/tcp_connect.c
+++ b/net/rds/tcp_connect.c
@@ -169,7 +169,7 @@ int rds_tcp_conn_path_connect(struct rds_conn_path *cp)
 	 * own the socket
 	 */
 	rds_tcp_set_callbacks(sock, cp);
-	ret = sock->ops->connect(sock, addr, addrlen, O_NONBLOCK);
+	ret = kernel_connect(sock, addr, addrlen, O_NONBLOCK);
 
 	rdsdebug("connect to address %pI6c returned %d\n", &conn->c_faddr, ret);
 	if (ret == -EINPROGRESS)
diff --git a/net/sctp/associola.c b/net/sctp/associola.c
index 2d4ec6187755..765eb617776b 100644
--- a/net/sctp/associola.c
+++ b/net/sctp/associola.c
@@ -1151,8 +1151,7 @@ int sctp_assoc_update(struct sctp_association *asoc,
 		/* Add any peer addresses from the new association. */
 		list_for_each_entry(trans, &new->peer.transport_addr_list,
 				    transports)
-			if (!sctp_assoc_lookup_paddr(asoc, &trans->ipaddr) &&
-			    !sctp_assoc_add_peer(asoc, &trans->ipaddr,
+			if (!sctp_assoc_add_peer(asoc, &trans->ipaddr,
 						 GFP_ATOMIC, trans->state))
 				return -ENOMEM;
 
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 68d53e3f0d07..bc4fe944ef85 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -2452,6 +2452,7 @@ static int sctp_apply_peer_addr_params(struct sctp_paddrparams *params,
 			if (trans) {
 				trans->hbinterval =
 				    msecs_to_jiffies(params->spp_hbinterval);
+				sctp_transport_reset_hb_timer(trans);
 			} else if (asoc) {
 				asoc->hbinterval =
 				    msecs_to_jiffies(params->spp_hbinterval);
diff --git a/net/socket.c b/net/socket.c
index 1a4033511703..de89ab55d475 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -655,6 +655,14 @@ static inline int sock_sendmsg_nosec(struct socket *sock, struct msghdr *msg)
 	return ret;
 }
 
+static int __sock_sendmsg(struct socket *sock, struct msghdr *msg)
+{
+	int err = security_socket_sendmsg(sock, msg,
+					  msg_data_left(msg));
+
+	return err ?: sock_sendmsg_nosec(sock, msg);
+}
+
 /**
  *	sock_sendmsg - send a message through @sock
  *	@sock: socket
@@ -665,10 +673,19 @@ static inline int sock_sendmsg_nosec(struct socket *sock, struct msghdr *msg)
  */
 int sock_sendmsg(struct socket *sock, struct msghdr *msg)
 {
-	int err = security_socket_sendmsg(sock, msg,
-					  msg_data_left(msg));
+	struct sockaddr_storage *save_addr = (struct sockaddr_storage *)msg->msg_name;
+	struct sockaddr_storage address;
+	int ret;
 
-	return err ?: sock_sendmsg_nosec(sock, msg);
+	if (msg->msg_name) {
+		memcpy(&address, msg->msg_name, msg->msg_namelen);
+		msg->msg_name = &address;
+	}
+
+	ret = __sock_sendmsg(sock, msg);
+	msg->msg_name = save_addr;
+
+	return ret;
 }
 EXPORT_SYMBOL(sock_sendmsg);
 
@@ -995,7 +1012,7 @@ static ssize_t sock_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (sock->type == SOCK_SEQPACKET)
 		msg.msg_flags |= MSG_EOR;
 
-	res = sock_sendmsg(sock, &msg);
+	res = __sock_sendmsg(sock, &msg);
 	*from = msg.msg_iter;
 	return res;
 }
@@ -1983,7 +2000,7 @@ int __sys_sendto(int fd, void __user *buff, size_t len, unsigned int flags,
 	if (sock->file->f_flags & O_NONBLOCK)
 		flags |= MSG_DONTWAIT;
 	msg.msg_flags = flags;
-	err = sock_sendmsg(sock, &msg);
+	err = __sock_sendmsg(sock, &msg);
 
 out_put:
 	fput_light(sock->file, fput_needed);
@@ -2356,7 +2373,7 @@ static int ____sys_sendmsg(struct socket *sock, struct msghdr *msg_sys,
 		err = sock_sendmsg_nosec(sock, msg_sys);
 		goto out_freectl;
 	}
-	err = sock_sendmsg(sock, msg_sys);
+	err = __sock_sendmsg(sock, msg_sys);
 	/*
 	 * If this is sendmmsg() and sending to current destination address was
 	 * successful, remember it.
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index e1ce0f261f0b..c7c1754f8744 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2354,8 +2354,7 @@ call_status(struct rpc_task *task)
 		goto out_exit;
 	}
 	task->tk_action = call_encode;
-	if (status != -ECONNRESET && status != -ECONNABORTED)
-		rpc_check_timeout(task);
+	rpc_check_timeout(task);
 	return;
 out_exit:
 	rpc_call_rpcerror(task, status);
@@ -2630,6 +2629,7 @@ rpc_decode_header(struct rpc_task *task, struct xdr_stream *xdr)
 	case rpc_autherr_rejectedverf:
 	case rpcsec_gsserr_credproblem:
 	case rpcsec_gsserr_ctxproblem:
+		rpcauth_invalcred(task);
 		if (!task->tk_cred_retry)
 			break;
 		task->tk_cred_retry--;
diff --git a/net/tipc/crypto.c b/net/tipc/crypto.c
index 2784d6989211..b5aa0a835bce 100644
--- a/net/tipc/crypto.c
+++ b/net/tipc/crypto.c
@@ -1445,14 +1445,14 @@ static int tipc_crypto_key_revoke(struct net *net, u8 tx_key)
 	struct tipc_crypto *tx = tipc_net(net)->crypto_tx;
 	struct tipc_key key;
 
-	spin_lock(&tx->lock);
+	spin_lock_bh(&tx->lock);
 	key = tx->key;
 	WARN_ON(!key.active || tx_key != key.active);
 
 	/* Free the active key */
 	tipc_crypto_key_set_state(tx, key.passive, 0, key.pending);
 	tipc_crypto_key_detach(tx->aead[key.active], &tx->lock);
-	spin_unlock(&tx->lock);
+	spin_unlock_bh(&tx->lock);
 
 	pr_warn("%s: key is revoked\n", tx->name);
 	return -EKEYREVOKED;
diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index 2417dd1dee33..da4df53ee695 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -1490,7 +1490,7 @@ void handle_moddevtable(struct module *mod, struct elf_info *info,
 	/* First handle the "special" cases */
 	if (sym_is(name, namelen, "usb"))
 		do_usb_table(symval, sym->st_size, mod);
-	if (sym_is(name, namelen, "of"))
+	else if (sym_is(name, namelen, "of"))
 		do_of_table(symval, sym->st_size, mod);
 	else if (sym_is(name, namelen, "pnp"))
 		do_pnp_device_entry(symval, sym->st_size, mod);
diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 05b8f5bcc37a..d0d3ff58da49 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -29,9 +29,11 @@ config IMA
 	  to learn more about IMA.
 	  If unsure, say N.
 
+if IMA
+
 config IMA_KEXEC
 	bool "Enable carrying the IMA measurement list across a soft boot"
-	depends on IMA && TCG_TPM && HAVE_IMA_KEXEC
+	depends on TCG_TPM && HAVE_IMA_KEXEC
 	default n
 	help
 	   TPM PCRs are only reset on a hard reboot.  In order to validate
@@ -43,7 +45,6 @@ config IMA_KEXEC
 
 config IMA_MEASURE_PCR_IDX
 	int
-	depends on IMA
 	range 8 14
 	default 10
 	help
@@ -53,7 +54,7 @@ config IMA_MEASURE_PCR_IDX
 
 config IMA_LSM_RULES
 	bool
-	depends on IMA && AUDIT && (SECURITY_SELINUX || SECURITY_SMACK || SECURITY_APPARMOR)
+	depends on AUDIT && (SECURITY_SELINUX || SECURITY_SMACK || SECURITY_APPARMOR)
 	default y
 	help
 	  Disabling this option will disregard LSM based policy rules.
@@ -61,7 +62,6 @@ config IMA_LSM_RULES
 choice
 	prompt "Default template"
 	default IMA_NG_TEMPLATE
-	depends on IMA
 	help
 	  Select the default IMA measurement template.
 
@@ -80,14 +80,12 @@ endchoice
 
 config IMA_DEFAULT_TEMPLATE
 	string
-	depends on IMA
 	default "ima-ng" if IMA_NG_TEMPLATE
 	default "ima-sig" if IMA_SIG_TEMPLATE
 
 choice
 	prompt "Default integrity hash algorithm"
 	default IMA_DEFAULT_HASH_SHA1
-	depends on IMA
 	help
 	   Select the default hash algorithm used for the measurement
 	   list, integrity appraisal and audit log.  The compiled default
@@ -117,7 +115,6 @@ endchoice
 
 config IMA_DEFAULT_HASH
 	string
-	depends on IMA
 	default "sha1" if IMA_DEFAULT_HASH_SHA1
 	default "sha256" if IMA_DEFAULT_HASH_SHA256
 	default "sha512" if IMA_DEFAULT_HASH_SHA512
@@ -126,7 +123,6 @@ config IMA_DEFAULT_HASH
 
 config IMA_WRITE_POLICY
 	bool "Enable multiple writes to the IMA policy"
-	depends on IMA
 	default n
 	help
 	  IMA policy can now be updated multiple times.  The new rules get
@@ -137,7 +133,6 @@ config IMA_WRITE_POLICY
 
 config IMA_READ_POLICY
 	bool "Enable reading back the current IMA policy"
-	depends on IMA
 	default y if IMA_WRITE_POLICY
 	default n if !IMA_WRITE_POLICY
 	help
@@ -147,7 +142,6 @@ config IMA_READ_POLICY
 
 config IMA_APPRAISE
 	bool "Appraise integrity measurements"
-	depends on IMA
 	default n
 	help
 	  This option enables local measurement integrity appraisal.
@@ -268,7 +262,7 @@ config IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
 config IMA_BLACKLIST_KEYRING
 	bool "Create IMA machine owner blacklist keyrings (EXPERIMENTAL)"
 	depends on SYSTEM_TRUSTED_KEYRING
-	depends on IMA_TRUSTED_KEYRING
+	depends on INTEGRITY_TRUSTED_KEYRING
 	default n
 	help
 	   This option creates an IMA blacklist keyring, which contains all
@@ -278,7 +272,7 @@ config IMA_BLACKLIST_KEYRING
 
 config IMA_LOAD_X509
 	bool "Load X509 certificate onto the '.ima' trusted keyring"
-	depends on IMA_TRUSTED_KEYRING
+	depends on INTEGRITY_TRUSTED_KEYRING
 	default n
 	help
 	   File signature verification is based on the public keys
@@ -303,7 +297,6 @@ config IMA_APPRAISE_SIGNED_INIT
 
 config IMA_MEASURE_ASYMMETRIC_KEYS
 	bool
-	depends on IMA
 	depends on ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
 	default y
 
@@ -319,3 +312,5 @@ config IMA_SECURE_AND_OR_TRUSTED_BOOT
        help
           This option is selected by architectures to enable secure and/or
           trusted boot based on IMA runtime policies.
+
+endif
diff --git a/security/smack/smack.h b/security/smack/smack.h
index a9768b12716b..b5187915e074 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -120,6 +120,7 @@ struct inode_smack {
 struct task_smack {
 	struct smack_known	*smk_task;	/* label for access control */
 	struct smack_known	*smk_forked;	/* label when forked */
+	struct smack_known	*smk_transmuted;/* label when transmuted */
 	struct list_head	smk_rules;	/* per task access rules */
 	struct mutex		smk_rules_lock;	/* lock for the rules */
 	struct list_head	smk_relabel;	/* transit allowed labels */
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index b36b8668f1f4..814518ad4402 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -972,8 +972,9 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
 				     const struct qstr *qstr, const char **name,
 				     void **value, size_t *len)
 {
+	struct task_smack *tsp = smack_cred(current_cred());
 	struct inode_smack *issp = smack_inode(inode);
-	struct smack_known *skp = smk_of_current();
+	struct smack_known *skp = smk_of_task(tsp);
 	struct smack_known *isp = smk_of_inode(inode);
 	struct smack_known *dsp = smk_of_inode(dir);
 	int may;
@@ -982,20 +983,34 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
 		*name = XATTR_SMACK_SUFFIX;
 
 	if (value && len) {
-		rcu_read_lock();
-		may = smk_access_entry(skp->smk_known, dsp->smk_known,
-				       &skp->smk_rules);
-		rcu_read_unlock();
+		/*
+		 * If equal, transmuting already occurred in
+		 * smack_dentry_create_files_as(). No need to check again.
+		 */
+		if (tsp->smk_task != tsp->smk_transmuted) {
+			rcu_read_lock();
+			may = smk_access_entry(skp->smk_known, dsp->smk_known,
+					       &skp->smk_rules);
+			rcu_read_unlock();
+		}
 
 		/*
-		 * If the access rule allows transmutation and
-		 * the directory requests transmutation then
-		 * by all means transmute.
+		 * In addition to having smk_task equal to smk_transmuted,
+		 * if the access rule allows transmutation and the directory
+		 * requests transmutation then by all means transmute.
 		 * Mark the inode as changed.
 		 */
-		if (may > 0 && ((may & MAY_TRANSMUTE) != 0) &&
-		    smk_inode_transmutable(dir)) {
-			isp = dsp;
+		if ((tsp->smk_task == tsp->smk_transmuted) ||
+		    (may > 0 && ((may & MAY_TRANSMUTE) != 0) &&
+		     smk_inode_transmutable(dir))) {
+			/*
+			 * The caller of smack_dentry_create_files_as()
+			 * should have overridden the current cred, so the
+			 * inode label was already set correctly in
+			 * smack_inode_alloc_security().
+			 */
+			if (tsp->smk_task != tsp->smk_transmuted)
+				isp = dsp;
 			issp->smk_flags |= SMK_INODE_CHANGED;
 		}
 
@@ -1429,10 +1444,19 @@ static int smack_inode_getsecurity(struct inode *inode,
 	struct super_block *sbp;
 	struct inode *ip = (struct inode *)inode;
 	struct smack_known *isp;
+	struct inode_smack *ispp;
+	size_t label_len;
+	char *label = NULL;
 
-	if (strcmp(name, XATTR_SMACK_SUFFIX) == 0)
+	if (strcmp(name, XATTR_SMACK_SUFFIX) == 0) {
 		isp = smk_of_inode(inode);
-	else {
+	} else if (strcmp(name, XATTR_SMACK_TRANSMUTE) == 0) {
+		ispp = smack_inode(inode);
+		if (ispp->smk_flags & SMK_INODE_TRANSMUTE)
+			label = TRANS_TRUE;
+		else
+			label = "";
+	} else {
 		/*
 		 * The rest of the Smack xattrs are only on sockets.
 		 */
@@ -1454,13 +1478,18 @@ static int smack_inode_getsecurity(struct inode *inode,
 			return -EOPNOTSUPP;
 	}
 
+	if (!label)
+		label = isp->smk_known;
+
+	label_len = strlen(label);
+
 	if (alloc) {
-		*buffer = kstrdup(isp->smk_known, GFP_KERNEL);
+		*buffer = kstrdup(label, GFP_KERNEL);
 		if (*buffer == NULL)
 			return -ENOMEM;
 	}
 
-	return strlen(isp->smk_known);
+	return label_len;
 }
 
 
@@ -4634,7 +4663,7 @@ static int smack_inode_copy_up(struct dentry *dentry, struct cred **new)
 	/*
 	 * Get label from overlay inode and set it in create_sid
 	 */
-	isp = smack_inode(d_inode(dentry->d_parent));
+	isp = smack_inode(d_inode(dentry));
 	skp = isp->smk_inode;
 	tsp->smk_task = skp;
 	*new = new_creds;
@@ -4685,8 +4714,10 @@ static int smack_dentry_create_files_as(struct dentry *dentry, int mode,
 		 * providing access is transmuting use the containing
 		 * directory label instead of the process label.
 		 */
-		if (may > 0 && (may & MAY_TRANSMUTE))
+		if (may > 0 && (may & MAY_TRANSMUTE)) {
 			ntsp->smk_task = isp->smk_inode;
+			ntsp->smk_transmuted = ntsp->smk_task;
+		}
 	}
 	return 0;
 }
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 1f641712233e..dfef761d5521 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2271,6 +2271,7 @@ static const struct snd_pci_quirk power_save_denylist[] = {
 	SND_PCI_QUIRK(0x8086, 0x2068, "Intel NUC7i3BNB", 0),
 	/* https://bugzilla.kernel.org/show_bug.cgi?id=198611 */
 	SND_PCI_QUIRK(0x17aa, 0x2227, "Lenovo X1 Carbon 3rd Gen", 0),
+	SND_PCI_QUIRK(0x17aa, 0x316e, "Lenovo ThinkCentre M70q", 0),
 	/* https://bugzilla.redhat.com/show_bug.cgi?id=1689623 */
 	SND_PCI_QUIRK(0x17aa, 0x367b, "Lenovo IdeaCentre B550", 0),
 	/* https://bugzilla.redhat.com/show_bug.cgi?id=1572975 */
diff --git a/sound/soc/fsl/imx-audmix.c b/sound/soc/fsl/imx-audmix.c
index 77d8234c7ac4..bb2aab1d2389 100644
--- a/sound/soc/fsl/imx-audmix.c
+++ b/sound/soc/fsl/imx-audmix.c
@@ -322,7 +322,7 @@ static int imx_audmix_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->cpu_mclk)) {
 		ret = PTR_ERR(priv->cpu_mclk);
 		dev_err(&cpu_pdev->dev, "failed to get DAI mclk1: %d\n", ret);
-		return -EINVAL;
+		return ret;
 	}
 
 	priv->audmix_pdev = audmix_pdev;
diff --git a/sound/soc/meson/axg-spdifin.c b/sound/soc/meson/axg-spdifin.c
index d0d09f945b48..7aaded1fc376 100644
--- a/sound/soc/meson/axg-spdifin.c
+++ b/sound/soc/meson/axg-spdifin.c
@@ -112,34 +112,6 @@ static int axg_spdifin_prepare(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int axg_spdifin_startup(struct snd_pcm_substream *substream,
-			       struct snd_soc_dai *dai)
-{
-	struct axg_spdifin *priv = snd_soc_dai_get_drvdata(dai);
-	int ret;
-
-	ret = clk_prepare_enable(priv->refclk);
-	if (ret) {
-		dev_err(dai->dev,
-			"failed to enable spdifin reference clock\n");
-		return ret;
-	}
-
-	regmap_update_bits(priv->map, SPDIFIN_CTRL0, SPDIFIN_CTRL0_EN,
-			   SPDIFIN_CTRL0_EN);
-
-	return 0;
-}
-
-static void axg_spdifin_shutdown(struct snd_pcm_substream *substream,
-				 struct snd_soc_dai *dai)
-{
-	struct axg_spdifin *priv = snd_soc_dai_get_drvdata(dai);
-
-	regmap_update_bits(priv->map, SPDIFIN_CTRL0, SPDIFIN_CTRL0_EN, 0);
-	clk_disable_unprepare(priv->refclk);
-}
-
 static void axg_spdifin_write_mode_param(struct regmap *map, int mode,
 					 unsigned int val,
 					 unsigned int num_per_reg,
@@ -251,25 +223,38 @@ static int axg_spdifin_dai_probe(struct snd_soc_dai *dai)
 	ret = axg_spdifin_sample_mode_config(dai, priv);
 	if (ret) {
 		dev_err(dai->dev, "mode configuration failed\n");
-		clk_disable_unprepare(priv->pclk);
-		return ret;
+		goto pclk_err;
 	}
 
+	ret = clk_prepare_enable(priv->refclk);
+	if (ret) {
+		dev_err(dai->dev,
+			"failed to enable spdifin reference clock\n");
+		goto pclk_err;
+	}
+
+	regmap_update_bits(priv->map, SPDIFIN_CTRL0, SPDIFIN_CTRL0_EN,
+			   SPDIFIN_CTRL0_EN);
+
 	return 0;
+
+pclk_err:
+	clk_disable_unprepare(priv->pclk);
+	return ret;
 }
 
 static int axg_spdifin_dai_remove(struct snd_soc_dai *dai)
 {
 	struct axg_spdifin *priv = snd_soc_dai_get_drvdata(dai);
 
+	regmap_update_bits(priv->map, SPDIFIN_CTRL0, SPDIFIN_CTRL0_EN, 0);
+	clk_disable_unprepare(priv->refclk);
 	clk_disable_unprepare(priv->pclk);
 	return 0;
 }
 
 static const struct snd_soc_dai_ops axg_spdifin_ops = {
 	.prepare	= axg_spdifin_prepare,
-	.startup	= axg_spdifin_startup,
-	.shutdown	= axg_spdifin_shutdown,
 };
 
 static int axg_spdifin_iec958_info(struct snd_kcontrol *kcontrol,
diff --git a/tools/include/linux/btf_ids.h b/tools/include/linux/btf_ids.h
index 57890b357f85..eca91e7a4d39 100644
--- a/tools/include/linux/btf_ids.h
+++ b/tools/include/linux/btf_ids.h
@@ -38,7 +38,7 @@ asm(							\
 	____BTF_ID(symbol)
 
 #define __ID(prefix) \
-	__PASTE(prefix, __COUNTER__)
+	__PASTE(__PASTE(prefix, __COUNTER__), __LINE__)
 
 /*
  * The BTF_ID defines unique symbol for each ID pointing
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 7943e748916d..fd1a4d843e6f 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -976,7 +976,9 @@ union bpf_attr {
  * 		performed again, if the helper is used in combination with
  * 		direct packet access.
  * 	Return
- * 		0 on success, or a negative error in case of failure.
+ * 		0 on success, or a negative error in case of failure. Positive
+ * 		error indicates a potential drop or congestion in the target
+ * 		device. The particular positive error codes are not defined.
  *
  * u64 bpf_get_current_pid_tgid(void)
  * 	Return
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 0cf27354aa45..0f9732d5452e 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -253,6 +253,12 @@ ifeq ($(BISON_GE_35),1)
 else
   bison_flags += -w
 endif
+
+BISON_LT_381 := $(shell expr $(shell $(BISON) --version | grep bison | sed -e 's/.\+ \([0-9]\+\).\([0-9]\+\).\([0-9]\+\)/\1\2\3/g') \< 381)
+ifeq ($(BISON_LT_381),1)
+  bison_flags += -DYYNOMEM=YYABORT
+endif
+
 CFLAGS_parse-events-bison.o += $(bison_flags)
 CFLAGS_pmu-bison.o          += -DYYLTYPE_IS_TRIVIAL=0 $(bison_flags)
 CFLAGS_expr-bison.o         += -DYYLTYPE_IS_TRIVIAL=0 $(bison_flags)
diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
index c7bcddbd486d..3b1594447f29 100644
--- a/tools/power/cpupower/Makefile
+++ b/tools/power/cpupower/Makefile
@@ -270,14 +270,14 @@ clean:
 	$(MAKE) -C bench O=$(OUTPUT) clean
 
 
-install-lib:
+install-lib: libcpupower
 	$(INSTALL) -d $(DESTDIR)${libdir}
 	$(CP) $(OUTPUT)libcpupower.so* $(DESTDIR)${libdir}/
 	$(INSTALL) -d $(DESTDIR)${includedir}
 	$(INSTALL_DATA) lib/cpufreq.h $(DESTDIR)${includedir}/cpufreq.h
 	$(INSTALL_DATA) lib/cpuidle.h $(DESTDIR)${includedir}/cpuidle.h
 
-install-tools:
+install-tools: $(OUTPUT)cpupower
 	$(INSTALL) -d $(DESTDIR)${bindir}
 	$(INSTALL_PROGRAM) $(OUTPUT)cpupower $(DESTDIR)${bindir}
 	$(INSTALL) -d $(DESTDIR)${bash_completion_dir}
@@ -293,14 +293,14 @@ install-man:
 	$(INSTALL_DATA) -D man/cpupower-info.1 $(DESTDIR)${mandir}/man1/cpupower-info.1
 	$(INSTALL_DATA) -D man/cpupower-monitor.1 $(DESTDIR)${mandir}/man1/cpupower-monitor.1
 
-install-gmo:
+install-gmo: create-gmo
 	$(INSTALL) -d $(DESTDIR)${localedir}
 	for HLANG in $(LANGUAGES); do \
 		echo '$(INSTALL_DATA) -D $(OUTPUT)po/$$HLANG.gmo $(DESTDIR)${localedir}/$$HLANG/LC_MESSAGES/cpupower.mo'; \
 		$(INSTALL_DATA) -D $(OUTPUT)po/$$HLANG.gmo $(DESTDIR)${localedir}/$$HLANG/LC_MESSAGES/cpupower.mo; \
 	done;
 
-install-bench:
+install-bench: compile-bench
 	@#DESTDIR must be set from outside to survive
 	@sbindir=$(sbindir) bindir=$(bindir) docdir=$(docdir) confdir=$(confdir) $(MAKE) -C bench O=$(OUTPUT) install
 
diff --git a/tools/power/cpupower/bench/Makefile b/tools/power/cpupower/bench/Makefile
index f68b4bc55273..d9d9923af85c 100644
--- a/tools/power/cpupower/bench/Makefile
+++ b/tools/power/cpupower/bench/Makefile
@@ -27,7 +27,7 @@ $(OUTPUT)cpufreq-bench: $(OBJS)
 
 all: $(OUTPUT)cpufreq-bench
 
-install:
+install: $(OUTPUT)cpufreq-bench
 	mkdir -p $(DESTDIR)/$(sbindir)
 	mkdir -p $(DESTDIR)/$(bindir)
 	mkdir -p $(DESTDIR)/$(docdir)
diff --git a/tools/testing/selftests/ftrace/test.d/instances/instance-event.tc b/tools/testing/selftests/ftrace/test.d/instances/instance-event.tc
index 0eb47fbb3f44..42422e425107 100644
--- a/tools/testing/selftests/ftrace/test.d/instances/instance-event.tc
+++ b/tools/testing/selftests/ftrace/test.d/instances/instance-event.tc
@@ -39,7 +39,7 @@ instance_read() {
 
 instance_set() {
         while :; do
-                echo 1 > foo/events/sched/sched_switch
+                echo 1 > foo/events/sched/sched_switch/enable
         done 2> /dev/null
 }
 
diff --git a/tools/testing/selftests/kselftest_deps.sh b/tools/testing/selftests/kselftest_deps.sh
index bbc04646346b..e6010de67820 100755
--- a/tools/testing/selftests/kselftest_deps.sh
+++ b/tools/testing/selftests/kselftest_deps.sh
@@ -46,11 +46,11 @@ fi
 print_targets=0
 
 while getopts "p" arg; do
-    case $arg in
-        p)
+	case $arg in
+		p)
 		print_targets=1
 	shift;;
-    esac
+	esac
 done
 
 if [ $# -eq 0 ]
@@ -92,6 +92,10 @@ pass_cnt=0
 # Get all TARGETS from selftests Makefile
 targets=$(egrep "^TARGETS +|^TARGETS =" Makefile | cut -d "=" -f2)
 
+# Initially, in LDLIBS related lines, the dep checker needs
+# to ignore lines containing the following strings:
+filter="\$(VAR_LDLIBS)\|pkg-config\|PKG_CONFIG\|IOURING_EXTRA_LIBS"
+
 # Single test case
 if [ $# -eq 2 ]
 then
@@ -100,6 +104,8 @@ then
 	l1_test $test
 	l2_test $test
 	l3_test $test
+	l4_test $test
+	l5_test $test
 
 	print_results $1 $2
 	exit $?
@@ -113,7 +119,7 @@ fi
 # Append space at the end of the list to append more tests.
 
 l1_tests=$(grep -r --include=Makefile "^LDLIBS" | \
-		grep -v "VAR_LDLIBS" | awk -F: '{print $1}')
+		grep -v "$filter" | awk -F: '{print $1}' | uniq)
 
 # Level 2: LDLIBS set dynamically.
 #
@@ -126,7 +132,7 @@ l1_tests=$(grep -r --include=Makefile "^LDLIBS" | \
 # Append space at the end of the list to append more tests.
 
 l2_tests=$(grep -r --include=Makefile ": LDLIBS" | \
-		grep -v "VAR_LDLIBS" | awk -F: '{print $1}')
+		grep -v "$filter" | awk -F: '{print $1}' | uniq)
 
 # Level 3
 # gpio,  memfd and others use pkg-config to find mount and fuse libs
@@ -140,11 +146,32 @@ l2_tests=$(grep -r --include=Makefile ": LDLIBS" | \
 #	VAR_LDLIBS := $(shell pkg-config fuse --libs 2>/dev/null)
 
 l3_tests=$(grep -r --include=Makefile "^VAR_LDLIBS" | \
-		grep -v "pkg-config" | awk -F: '{print $1}')
+		grep -v "pkg-config\|PKG_CONFIG" | awk -F: '{print $1}' | uniq)
 
-#echo $l1_tests
-#echo $l2_1_tests
-#echo $l3_tests
+# Level 4
+# some tests may fall back to default using `|| echo -l<libname>`
+# if pkg-config doesn't find the libs, instead of using VAR_LDLIBS
+# as per level 3 checks.
+# e.g:
+# netfilter/Makefile
+#	LDLIBS += $(shell $(HOSTPKG_CONFIG) --libs libmnl 2>/dev/null || echo -lmnl)
+l4_tests=$(grep -r --include=Makefile "^LDLIBS" | \
+		grep "pkg-config\|PKG_CONFIG" | awk -F: '{print $1}' | uniq)
+
+# Level 5
+# some tests may use IOURING_EXTRA_LIBS to add extra libs to LDLIBS,
+# which in turn may be defined in a sub-Makefile
+# e.g.:
+# mm/Makefile
+#	$(OUTPUT)/gup_longterm: LDLIBS += $(IOURING_EXTRA_LIBS)
+l5_tests=$(grep -r --include=Makefile "LDLIBS +=.*\$(IOURING_EXTRA_LIBS)" | \
+	awk -F: '{print $1}' | uniq)
+
+#echo l1_tests $l1_tests
+#echo l2_tests $l2_tests
+#echo l3_tests $l3_tests
+#echo l4_tests $l4_tests
+#echo l5_tests $l5_tests
 
 all_tests
 print_results $1 $2
@@ -166,24 +193,32 @@ all_tests()
 	for test in $l3_tests; do
 		l3_test $test
 	done
+
+	for test in $l4_tests; do
+		l4_test $test
+	done
+
+	for test in $l5_tests; do
+		l5_test $test
+	done
 }
 
 # Use same parsing used for l1_tests and pick libraries this time.
 l1_test()
 {
 	test_libs=$(grep --include=Makefile "^LDLIBS" $test | \
-			grep -v "VAR_LDLIBS" | \
+			grep -v "$filter" | \
 			sed -e 's/\:/ /' | \
 			sed -e 's/+/ /' | cut -d "=" -f 2)
 
 	check_libs $test $test_libs
 }
 
-# Use same parsing used for l2__tests and pick libraries this time.
+# Use same parsing used for l2_tests and pick libraries this time.
 l2_test()
 {
 	test_libs=$(grep --include=Makefile ": LDLIBS" $test | \
-			grep -v "VAR_LDLIBS" | \
+			grep -v "$filter" | \
 			sed -e 's/\:/ /' | sed -e 's/+/ /' | \
 			cut -d "=" -f 2)
 
@@ -199,6 +234,24 @@ l3_test()
 	check_libs $test $test_libs
 }
 
+l4_test()
+{
+	test_libs=$(grep --include=Makefile "^VAR_LDLIBS\|^LDLIBS" $test | \
+			grep "\(pkg-config\|PKG_CONFIG\).*|| echo " | \
+			sed -e 's/.*|| echo //' | sed -e 's/)$//')
+
+	check_libs $test $test_libs
+}
+
+l5_test()
+{
+	tests=$(find $(dirname "$test") -type f -name "*.mk")
+	test_libs=$(grep "^IOURING_EXTRA_LIBS +\?=" $tests | \
+			cut -d "=" -f 2)
+
+	check_libs $test $test_libs
+}
+
 check_libs()
 {
 
diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index b599f1fa99b5..44a25a9f1f72 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -384,11 +384,12 @@ TEST_F(tls, sendmsg_large)
 
 		msg.msg_iov = &vec;
 		msg.msg_iovlen = 1;
-		EXPECT_EQ(sendmsg(self->cfd, &msg, 0), send_len);
+		EXPECT_EQ(sendmsg(self->fd, &msg, 0), send_len);
 	}
 
-	while (recvs++ < sends)
-		EXPECT_NE(recv(self->fd, mem, send_len, 0), -1);
+	while (recvs++ < sends) {
+		EXPECT_NE(recv(self->cfd, mem, send_len, 0), -1);
+	}
 
 	free(mem);
 }
@@ -416,9 +417,9 @@ TEST_F(tls, sendmsg_multiple)
 	msg.msg_iov = vec;
 	msg.msg_iovlen = iov_len;
 
-	EXPECT_EQ(sendmsg(self->cfd, &msg, 0), total_len);
+	EXPECT_EQ(sendmsg(self->fd, &msg, 0), total_len);
 	buf = malloc(total_len);
-	EXPECT_NE(recv(self->fd, buf, total_len, 0), -1);
+	EXPECT_NE(recv(self->cfd, buf, total_len, 0), -1);
 	for (i = 0; i < iov_len; i++) {
 		EXPECT_EQ(memcmp(test_strs[i], buf + len_cmp,
 				 strlen(test_strs[i])),
