Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6CE7D5CB4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 22:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344357AbjJXUzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 16:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344308AbjJXUz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 16:55:28 -0400
X-Greylist: delayed 473 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 24 Oct 2023 13:55:20 PDT
Received: from proxmox1.postmarketos.org (proxmox1.postmarketos.org [IPv6:2a01:4f8:a0:821d::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C932610D4;
        Tue, 24 Oct 2023 13:55:20 -0700 (PDT)
From:   Stefan Hansson <newbyte@postmarketos.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
        s=donut; t=1698180446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c3PDpBx7y6mi35kIslIL/iNJmJyZpKW7qPucJuzql04=;
        b=MCpbNc2SCVqvGf18M118k9ssexs1AhbNr+LFNueINCraWrs96/k2jkFMIkUkZmfBAlxIn9
        6nA8Njk9sDrHw8QJ53P9cMzgKhRchkXKHPlbLiXJKWapc9gf4qt1u066ZC93q0cN16sdKo
        +3e8prE9fPFEbed4hiNq7f2pKdyjt1I=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Stefan Hansson <newbyte@postmarketos.org>
Subject: [PATCH v2 1/4] ARM: dts: qcom: samsung-matisse-common: Add initial common device tree
Date:   Tue, 24 Oct 2023 22:33:42 +0200
Message-ID: <20231024204505.125813-2-newbyte@postmarketos.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231024204505.125813-1-newbyte@postmarketos.org>
References: <20231024204505.125813-1-newbyte@postmarketos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the dts from the kernel source code released by Samsung,
matissewifi and matisselte only have minor differences in hardware, so
use a shared dtsi to reduce duplicated code. Additionally, this should
make adding support for matisse3g easier should someone want to do that
at a later point.

As such, add a common device tree for all matisse devices by Samsung
based on the matissewifi dts. Support for matisselte will be introduced
in a later patch in this series and will use the common dtsi as well.

Signed-off-by: Stefan Hansson <newbyte@postmarketos.org>
---
 .../qcom-apq8026-samsung-matisse-wifi.dts     | 467 +----------------
 .../qcom-msm8226-samsung-matisse-common.dtsi  | 474 ++++++++++++++++++
 2 files changed, 483 insertions(+), 458 deletions(-)
 create mode 100644 arch/arm/boot/dts/qcom/qcom-msm8226-samsung-matisse-common.dtsi

diff --git a/arch/arm/boot/dts/qcom/qcom-apq8026-samsung-matisse-wifi.dts b/arch/arm/boot/dts/qcom/qcom-apq8026-samsung-matisse-wifi.dts
index f516e0426bb9..98d4bb797617 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8026-samsung-matisse-wifi.dts
+++ b/arch/arm/boot/dts/qcom/qcom-apq8026-samsung-matisse-wifi.dts
@@ -5,222 +5,12 @@
 
 /dts-v1/;
 
-#include <dt-bindings/input/input.h>
-#include "qcom-msm8226.dtsi"
-#include "qcom-pm8226.dtsi"
-
-/delete-node/ &adsp_region;
-/delete-node/ &smem_region;
+#include "qcom-msm8226-samsung-matisse-common.dtsi"
 
 / {
 	model = "Samsung Galaxy Tab 4 10.1";
 	compatible = "samsung,matisse-wifi", "qcom,apq8026";
 	chassis-type = "tablet";
-
-	aliases {
-		mmc0 = &sdhc_1; /* SDC1 eMMC slot */
-		mmc1 = &sdhc_2; /* SDC2 SD card slot */
-		display0 = &framebuffer0;
-	};
-
-	chosen {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-
-		stdout-path = "display0";
-
-		framebuffer0: framebuffer@3200000 {
-			compatible = "simple-framebuffer";
-			reg = <0x03200000 0x800000>;
-			width = <1280>;
-			height = <800>;
-			stride = <(1280 * 3)>;
-			format = "r8g8b8";
-		};
-	};
-
-	gpio-hall-sensor {
-		compatible = "gpio-keys";
-
-		event-hall-sensor {
-			label = "Hall Effect Sensor";
-			gpios = <&tlmm 110 GPIO_ACTIVE_LOW>;
-			linux,input-type = <EV_SW>;
-			linux,code = <SW_LID>;
-			debounce-interval = <15>;
-			linux,can-disable;
-			wakeup-source;
-		};
-	};
-
-	gpio-keys {
-		compatible = "gpio-keys";
-		autorepeat;
-
-		key-home {
-			label = "Home";
-			gpios = <&tlmm 108 GPIO_ACTIVE_LOW>;
-			linux,code = <KEY_HOMEPAGE>;
-			debounce-interval = <15>;
-		};
-
-		key-volume-down {
-			label = "Volume Down";
-			gpios = <&tlmm 107 GPIO_ACTIVE_LOW>;
-			linux,code = <KEY_VOLUMEDOWN>;
-			debounce-interval = <15>;
-		};
-
-		key-volume-up {
-			label = "Volume Up";
-			gpios = <&tlmm 106 GPIO_ACTIVE_LOW>;
-			linux,code = <KEY_VOLUMEUP>;
-			debounce-interval = <15>;
-		};
-	};
-
-	i2c-backlight {
-		compatible = "i2c-gpio";
-		sda-gpios = <&tlmm 20 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
-		scl-gpios = <&tlmm 21 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
-
-		pinctrl-0 = <&backlight_i2c_default_state>;
-		pinctrl-names = "default";
-
-		i2c-gpio,delay-us = <4>;
-
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		backlight@2c {
-			compatible = "ti,lp8556";
-			reg = <0x2c>;
-
-			dev-ctrl = /bits/ 8 <0x80>;
-			init-brt = /bits/ 8 <0x3f>;
-
-			pwms = <&backlight_pwm 0 100000>;
-			pwm-names = "lp8556";
-
-			rom-a0h {
-				rom-addr = /bits/ 8 <0xa0>;
-				rom-val = /bits/ 8 <0x44>;
-			};
-
-			rom-a1h {
-				rom-addr = /bits/ 8 <0xa1>;
-				rom-val = /bits/ 8 <0x6c>;
-			};
-
-			rom-a5h {
-				rom-addr = /bits/ 8 <0xa5>;
-				rom-val = /bits/ 8 <0x24>;
-			};
-		};
-	};
-
-	backlight_pwm: pwm {
-		compatible = "clk-pwm";
-		#pwm-cells = <2>;
-		clocks = <&mmcc CAMSS_GP0_CLK>;
-		pinctrl-0 = <&backlight_pwm_default_state>;
-		pinctrl-names = "default";
-	};
-
-	reg_tsp_1p8v: regulator-tsp-1p8v {
-		compatible = "regulator-fixed";
-		regulator-name = "tsp_1p8v";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-
-		gpio = <&tlmm 31 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-
-		pinctrl-names = "default";
-		pinctrl-0 = <&tsp_en_default_state>;
-	};
-
-	reg_tsp_3p3v: regulator-tsp-3p3v {
-		compatible = "regulator-fixed";
-		regulator-name = "tsp_3p3v";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-
-		gpio = <&tlmm 73 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-
-		pinctrl-names = "default";
-		pinctrl-0 = <&tsp_en1_default_state>;
-	};
-
-	reserved-memory {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-
-		framebuffer@3200000 {
-			reg = <0x03200000 0x800000>;
-			no-map;
-		};
-
-		mpss@8400000 {
-			reg = <0x08400000 0x1f00000>;
-			no-map;
-		};
-
-		mba@a300000 {
-			reg = <0x0a300000 0x100000>;
-			no-map;
-		};
-
-		reserved@cb00000 {
-			reg = <0x0cb00000 0x700000>;
-			no-map;
-		};
-
-		wcnss@d200000 {
-			reg = <0x0d200000 0x700000>;
-			no-map;
-		};
-
-		adsp_region: adsp@d900000 {
-			reg = <0x0d900000 0x1800000>;
-			no-map;
-		};
-
-		venus@f100000 {
-			reg = <0x0f100000 0x500000>;
-			no-map;
-		};
-
-		smem_region: smem@fa00000 {
-			reg = <0x0fa00000 0x100000>;
-			no-map;
-		};
-
-		reserved@fb00000 {
-			reg = <0x0fb00000 0x260000>;
-			no-map;
-		};
-
-		rfsa@fd60000 {
-			reg = <0x0fd60000 0x20000>;
-			no-map;
-		};
-
-		rmtfs@fd80000 {
-			compatible = "qcom,rmtfs-mem";
-			reg = <0x0fd80000 0x180000>;
-			no-map;
-
-			qcom,client-id = <1>;
-		};
-	};
-};
-
-&adsp {
-	status = "okay";
 };
 
 &blsp1_i2c2 {
@@ -243,21 +33,6 @@ accelerometer@1d {
 	};
 };
 
-&blsp1_i2c4 {
-	status = "okay";
-
-	muic: usb-switch@25 {
-		compatible = "siliconmitus,sm5502-muic";
-		reg = <0x25>;
-
-		interrupt-parent = <&tlmm>;
-		interrupts = <67 IRQ_TYPE_EDGE_FALLING>;
-
-		pinctrl-names = "default";
-		pinctrl-0 = <&muic_int_default_state>;
-	};
-};
-
 &blsp1_i2c5 {
 	status = "okay";
 
@@ -278,242 +53,18 @@ touchscreen@4a {
 	};
 };
 
-&rpm_requests {
-	regulators {
-		compatible = "qcom,rpm-pm8226-regulators";
-
-		pm8226_s3: s3 {
-			regulator-min-microvolt = <1200000>;
-			regulator-max-microvolt = <1300000>;
-		};
-
-		pm8226_s4: s4 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-		};
-
-		pm8226_s5: s5 {
-			regulator-min-microvolt = <1150000>;
-			regulator-max-microvolt = <1150000>;
-		};
-
-		pm8226_l1: l1 {
-			regulator-min-microvolt = <1225000>;
-			regulator-max-microvolt = <1225000>;
-		};
-
-		pm8226_l2: l2 {
-			regulator-min-microvolt = <1200000>;
-			regulator-max-microvolt = <1200000>;
-		};
-
-		pm8226_l3: l3 {
-			regulator-min-microvolt = <750000>;
-			regulator-max-microvolt = <1337500>;
-			regulator-always-on;
-		};
-
-		pm8226_l4: l4 {
-			regulator-min-microvolt = <1200000>;
-			regulator-max-microvolt = <1200000>;
-		};
-
-		pm8226_l5: l5 {
-			regulator-min-microvolt = <1200000>;
-			regulator-max-microvolt = <1200000>;
-		};
-
-		pm8226_l6: l6 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-			regulator-always-on;
-		};
-
-		pm8226_l7: l7 {
-			regulator-min-microvolt = <1850000>;
-			regulator-max-microvolt = <1850000>;
-		};
-
-		pm8226_l8: l8 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-			regulator-always-on;
-		};
-
-		pm8226_l9: l9 {
-			regulator-min-microvolt = <2050000>;
-			regulator-max-microvolt = <2050000>;
-		};
-
-		pm8226_l10: l10 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-		};
-
-		pm8226_l12: l12 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-		};
-
-		pm8226_l14: l14 {
-			regulator-min-microvolt = <2750000>;
-			regulator-max-microvolt = <2750000>;
-		};
-
-		pm8226_l15: l15 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <3300000>;
-		};
-
-		pm8226_l16: l16 {
-			regulator-min-microvolt = <3000000>;
-			regulator-max-microvolt = <3350000>;
-		};
-
-		pm8226_l17: l17 {
-			regulator-min-microvolt = <2950000>;
-			regulator-max-microvolt = <2950000>;
-
-			regulator-system-load = <200000>;
-			regulator-allow-set-load;
-			regulator-always-on;
-		};
-
-		pm8226_l18: l18 {
-			regulator-min-microvolt = <2950000>;
-			regulator-max-microvolt = <2950000>;
-		};
-
-		pm8226_l19: l19 {
-			regulator-min-microvolt = <2850000>;
-			regulator-max-microvolt = <3000000>;
-		};
-
-		pm8226_l20: l20 {
-			regulator-min-microvolt = <3075000>;
-			regulator-max-microvolt = <3075000>;
-		};
-
-		pm8226_l21: l21 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <2950000>;
-		};
-
-		pm8226_l22: l22 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <3000000>;
-		};
-
-		pm8226_l23: l23 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <3300000>;
-		};
-
-		pm8226_l24: l24 {
-			regulator-min-microvolt = <1300000>;
-			regulator-max-microvolt = <1350000>;
-		};
-
-		pm8226_l25: l25 {
-			regulator-min-microvolt = <1775000>;
-			regulator-max-microvolt = <2125000>;
-		};
-
-		pm8226_l26: l26 {
-			regulator-min-microvolt = <1225000>;
-			regulator-max-microvolt = <1300000>;
-		};
-
-		pm8226_l27: l27 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-		};
-
-		pm8226_l28: l28 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <2950000>;
-		};
-
-		pm8226_lvs1: lvs1 {};
-	};
-};
-
-&sdhc_1 {
-	vmmc-supply = <&pm8226_l17>;
-	vqmmc-supply = <&pm8226_l6>;
-
-	bus-width = <8>;
-	non-removable;
-
-	status = "okay";
-};
-
-&sdhc_2 {
-	vmmc-supply = <&pm8226_l18>;
-	vqmmc-supply = <&pm8226_l21>;
-
-	bus-width = <4>;
-	cd-gpios = <&tlmm 38 GPIO_ACTIVE_LOW>;
-
-	status = "okay";
+&pm8226_l3 {
+	regulator-max-microvolt = <1337500>;
 };
 
-&tlmm {
-	accel_int_default_state: accel-int-default-state {
-		pins = "gpio54";
-		function = "gpio";
-		drive-strength = <2>;
-		bias-disable;
-	};
-
-	backlight_i2c_default_state: backlight-i2c-default-state {
-		pins = "gpio20", "gpio21";
-		function = "gpio";
-		drive-strength = <2>;
-		bias-disable;
-	};
-
-	backlight_pwm_default_state: backlight-pwm-default-state {
-		pins = "gpio33";
-		function = "gp0_clk";
-	};
-
-	muic_int_default_state: muic-int-default-state {
-		pins = "gpio67";
-		function = "gpio";
-		drive-strength = <2>;
-		bias-disable;
-	};
-
-	tsp_en_default_state: tsp-en-default-state {
-		pins = "gpio31";
-		function = "gpio";
-		drive-strength = <2>;
-		bias-disable;
-	};
-
-	tsp_en1_default_state: tsp-en1-default-state {
-		pins = "gpio73";
-		function = "gpio";
-		drive-strength = <2>;
-		bias-disable;
-	};
-
-	tsp_int_rst_default_state: tsp-int-rst-default-state {
-		pins = "gpio17";
-		function = "gpio";
-		drive-strength = <10>;
-		bias-pull-up;
-	};
+&pm8226_s4 {
+	regulator-max-microvolt = <1800000>;
 };
 
-&usb {
-	extcon = <&muic>, <&muic>;
-	status = "okay";
+&reg_tsp_3p3v {
+	gpio = <&tlmm 73 GPIO_ACTIVE_HIGH>;
 };
 
-&usb_hs_phy {
-	extcon = <&muic>;
-	v1p8-supply = <&pm8226_l10>;
-	v3p3-supply = <&pm8226_l20>;
+&tsp_en1_default_state {
+	pins = "gpio73";
 };
diff --git a/arch/arm/boot/dts/qcom/qcom-msm8226-samsung-matisse-common.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8226-samsung-matisse-common.dtsi
new file mode 100644
index 000000000000..11fec4e963b7
--- /dev/null
+++ b/arch/arm/boot/dts/qcom/qcom-msm8226-samsung-matisse-common.dtsi
@@ -0,0 +1,474 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2022, Matti Lehtimäki <matti.lehtimaki@gmail.com>
+ * Copyright (c) 2023, Stefan Hansson <newbyte@postmarketos.org>
+ */
+
+#include <dt-bindings/input/input.h>
+#include "qcom-msm8226.dtsi"
+#include "qcom-pm8226.dtsi"
+
+/delete-node/ &adsp_region;
+/delete-node/ &smem_region;
+
+/ {
+	aliases {
+		mmc0 = &sdhc_1; /* SDC1 eMMC slot */
+		mmc1 = &sdhc_2; /* SDC2 SD card slot */
+		display0 = &framebuffer0;
+	};
+
+	chosen {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		stdout-path = "display0";
+
+		framebuffer0: framebuffer@3200000 {
+			compatible = "simple-framebuffer";
+			reg = <0x03200000 0x800000>;
+			width = <1280>;
+			height = <800>;
+			stride = <(1280 * 3)>;
+			format = "r8g8b8";
+		};
+	};
+
+	gpio-hall-sensor {
+		compatible = "gpio-keys";
+
+		event-hall-sensor {
+			label = "Hall Effect Sensor";
+			gpios = <&tlmm 110 GPIO_ACTIVE_LOW>;
+			linux,input-type = <EV_SW>;
+			linux,code = <SW_LID>;
+			debounce-interval = <15>;
+			linux,can-disable;
+			wakeup-source;
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		autorepeat;
+
+		key-home {
+			label = "Home";
+			gpios = <&tlmm 108 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_HOMEPAGE>;
+			debounce-interval = <15>;
+		};
+
+		key-volume-down {
+			label = "Volume Down";
+			gpios = <&tlmm 107 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEDOWN>;
+			debounce-interval = <15>;
+		};
+
+		key-volume-up {
+			label = "Volume Up";
+			gpios = <&tlmm 106 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEUP>;
+			debounce-interval = <15>;
+		};
+	};
+
+	i2c-backlight {
+		compatible = "i2c-gpio";
+		sda-gpios = <&tlmm 20 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+		scl-gpios = <&tlmm 21 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+
+		pinctrl-0 = <&backlight_i2c_default_state>;
+		pinctrl-names = "default";
+
+		i2c-gpio,delay-us = <4>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		backlight@2c {
+			compatible = "ti,lp8556";
+			reg = <0x2c>;
+
+			dev-ctrl = /bits/ 8 <0x80>;
+			init-brt = /bits/ 8 <0x3f>;
+
+			pwms = <&backlight_pwm 0 100000>;
+			pwm-names = "lp8556";
+
+			rom-a0h {
+				rom-addr = /bits/ 8 <0xa0>;
+				rom-val = /bits/ 8 <0x44>;
+			};
+
+			rom-a1h {
+				rom-addr = /bits/ 8 <0xa1>;
+				rom-val = /bits/ 8 <0x6c>;
+			};
+
+			rom-a5h {
+				rom-addr = /bits/ 8 <0xa5>;
+				rom-val = /bits/ 8 <0x24>;
+			};
+		};
+	};
+
+	backlight_pwm: pwm {
+		compatible = "clk-pwm";
+		#pwm-cells = <2>;
+		clocks = <&mmcc CAMSS_GP0_CLK>;
+		pinctrl-0 = <&backlight_pwm_default_state>;
+		pinctrl-names = "default";
+	};
+
+	reg_tsp_1p8v: regulator-tsp-1p8v {
+		compatible = "regulator-fixed";
+		regulator-name = "tsp_1p8v";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+
+		gpio = <&tlmm 31 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-0 = <&tsp_en_default_state>;
+		pinctrl-names = "default";
+	};
+
+	reg_tsp_3p3v: regulator-tsp-3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "tsp_3p3v";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		/* GPIO is board-specific */
+		enable-active-high;
+
+		pinctrl-0 = <&tsp_en1_default_state>;
+		pinctrl-names = "default";
+	};
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		framebuffer@3200000 {
+			reg = <0x03200000 0x800000>;
+			no-map;
+		};
+
+		mpss@8400000 {
+			reg = <0x08400000 0x1f00000>;
+			no-map;
+		};
+
+		mba@a300000 {
+			reg = <0x0a300000 0x100000>;
+			no-map;
+		};
+
+		reserved@cb00000 {
+			reg = <0x0cb00000 0x700000>;
+			no-map;
+		};
+
+		wcnss@d200000 {
+			reg = <0x0d200000 0x700000>;
+			no-map;
+		};
+
+		adsp_region: adsp@d900000 {
+			reg = <0x0d900000 0x1800000>;
+			no-map;
+		};
+
+		venus@f100000 {
+			reg = <0x0f100000 0x500000>;
+			no-map;
+		};
+
+		smem_region: smem@fa00000 {
+			reg = <0x0fa00000 0x100000>;
+			no-map;
+		};
+
+		reserved@fb00000 {
+			reg = <0x0fb00000 0x260000>;
+			no-map;
+		};
+
+		rfsa@fd60000 {
+			reg = <0x0fd60000 0x20000>;
+			no-map;
+		};
+
+		rmtfs@fd80000 {
+			compatible = "qcom,rmtfs-mem";
+			reg = <0x0fd80000 0x180000>;
+			no-map;
+
+			qcom,client-id = <1>;
+		};
+	};
+};
+
+&adsp {
+	status = "okay";
+};
+
+&blsp1_i2c4 {
+	status = "okay";
+
+	muic: usb-switch@25 {
+		compatible = "siliconmitus,sm5502-muic";
+		reg = <0x25>;
+
+		interrupt-parent = <&tlmm>;
+		interrupts = <67 IRQ_TYPE_EDGE_FALLING>;
+
+		pinctrl-0 = <&muic_int_default_state>;
+		pinctrl-names = "default";
+	};
+};
+
+&rpm_requests {
+	regulators {
+		compatible = "qcom,rpm-pm8226-regulators";
+
+		pm8226_s3: s3 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1300000>;
+		};
+
+		/* Upper voltage constraint is board-specific */
+		pm8226_s4: s4 {
+			regulator-min-microvolt = <1800000>;
+		};
+
+		pm8226_s5: s5 {
+			regulator-min-microvolt = <1150000>;
+			regulator-max-microvolt = <1150000>;
+		};
+
+		pm8226_l1: l1 {
+			regulator-min-microvolt = <1225000>;
+			regulator-max-microvolt = <1225000>;
+		};
+
+		pm8226_l2: l2 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
+
+		/* Upper voltage constraint is board-specific */
+		pm8226_l3: l3 {
+			regulator-min-microvolt = <750000>;
+			regulator-always-on;
+		};
+
+		pm8226_l4: l4 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
+
+		pm8226_l5: l5 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
+
+		pm8226_l6: l6 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-always-on;
+		};
+
+		pm8226_l7: l7 {
+			regulator-min-microvolt = <1850000>;
+			regulator-max-microvolt = <1850000>;
+		};
+
+		pm8226_l8: l8 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-always-on;
+		};
+
+		pm8226_l9: l9 {
+			regulator-min-microvolt = <2050000>;
+			regulator-max-microvolt = <2050000>;
+		};
+
+		pm8226_l10: l10 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8226_l12: l12 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8226_l14: l14 {
+			regulator-min-microvolt = <2750000>;
+			regulator-max-microvolt = <2750000>;
+		};
+
+		pm8226_l15: l15 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3300000>;
+		};
+
+		pm8226_l16: l16 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3350000>;
+		};
+
+		pm8226_l17: l17 {
+			regulator-min-microvolt = <2950000>;
+			regulator-max-microvolt = <2950000>;
+
+			regulator-system-load = <200000>;
+			regulator-allow-set-load;
+			regulator-always-on;
+		};
+
+		pm8226_l18: l18 {
+			regulator-min-microvolt = <2950000>;
+			regulator-max-microvolt = <2950000>;
+		};
+
+		pm8226_l19: l19 {
+			regulator-min-microvolt = <2850000>;
+			regulator-max-microvolt = <3000000>;
+		};
+
+		pm8226_l20: l20 {
+			regulator-min-microvolt = <3075000>;
+			regulator-max-microvolt = <3075000>;
+		};
+
+		pm8226_l21: l21 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2950000>;
+		};
+
+		pm8226_l22: l22 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3000000>;
+		};
+
+		pm8226_l23: l23 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3300000>;
+		};
+
+		pm8226_l24: l24 {
+			regulator-min-microvolt = <1300000>;
+			regulator-max-microvolt = <1350000>;
+		};
+
+		pm8226_l25: l25 {
+			regulator-min-microvolt = <1775000>;
+			regulator-max-microvolt = <2125000>;
+		};
+
+		pm8226_l26: l26 {
+			regulator-min-microvolt = <1225000>;
+			regulator-max-microvolt = <1300000>;
+		};
+
+		pm8226_l27: l27 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8226_l28: l28 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2950000>;
+		};
+
+		pm8226_lvs1: lvs1 {};
+	};
+};
+
+&sdhc_1 {
+	vmmc-supply = <&pm8226_l17>;
+	vqmmc-supply = <&pm8226_l6>;
+
+	bus-width = <8>;
+	non-removable;
+
+	status = "okay";
+};
+
+&sdhc_2 {
+	vmmc-supply = <&pm8226_l18>;
+	vqmmc-supply = <&pm8226_l21>;
+
+	bus-width = <4>;
+	cd-gpios = <&tlmm 38 GPIO_ACTIVE_LOW>;
+
+	status = "okay";
+};
+
+&tlmm {
+	accel_int_default_state: accel-int-default-state {
+		pins = "gpio54";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	backlight_i2c_default_state: backlight-i2c-default-state {
+		pins = "gpio20", "gpio21";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	backlight_pwm_default_state: backlight-pwm-default-state {
+		pins = "gpio33";
+		function = "gp0_clk";
+	};
+
+	muic_int_default_state: muic-int-default-state {
+		pins = "gpio67";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	tsp_en_default_state: tsp-en-default-state {
+		pins = "gpio31";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	tsp_en1_default_state: tsp-en1-default-state {
+		/* pins is board-specific */
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	tsp_int_rst_default_state: tsp-int-rst-default-state {
+		pins = "gpio17";
+		function = "gpio";
+		drive-strength = <10>;
+		bias-pull-up;
+	};
+};
+
+&usb {
+	extcon = <&muic>, <&muic>;
+	status = "okay";
+};
+
+&usb_hs_phy {
+	extcon = <&muic>;
+	v1p8-supply = <&pm8226_l10>;
+	v3p3-supply = <&pm8226_l20>;
+};
-- 
2.41.0

