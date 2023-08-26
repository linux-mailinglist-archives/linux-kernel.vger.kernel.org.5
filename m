Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581A6789725
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 16:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbjHZOGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 10:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjHZOFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 10:05:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB5519AC;
        Sat, 26 Aug 2023 07:05:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C84760BED;
        Sat, 26 Aug 2023 14:05:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7938C433CA;
        Sat, 26 Aug 2023 14:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693058745;
        bh=W06blyoMHnGSczNq+MBu2X05z4rHA6QhbszfFxaARxQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rYqhE/y2oYVlLYM7mVkUqALAruuezq0pv4KyrkHo2KhmI4ijwlU5kszT/6AAaBAdT
         i6FJg1PlJrOEdPG3Q7RNwL06defs7vpT/qPSW+iuZe87d7b8tEQLSUAqkYF4ikjBhC
         WbzTZLVBQn12bpm+lPRukDnhgRdC8NJiADdNi97A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.10.192
Date:   Sat, 26 Aug 2023 16:05:34 +0200
Message-ID: <2023082634-postnasal-anaconda-09f0@gregkh>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <2023082634-tightrope-bountiful-f121@gregkh>
References: <2023082634-tightrope-bountiful-f121@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Documentation/admin-guide/hw-vuln/srso.rst b/Documentation/admin-guide/hw-vuln/srso.rst
index 2f923c805802..f79cb11b080f 100644
--- a/Documentation/admin-guide/hw-vuln/srso.rst
+++ b/Documentation/admin-guide/hw-vuln/srso.rst
@@ -124,8 +124,8 @@ sequence.
 To ensure the safety of this mitigation, the kernel must ensure that the
 safe return sequence is itself free from attacker interference.  In Zen3
 and Zen4, this is accomplished by creating a BTB alias between the
-untraining function srso_untrain_ret_alias() and the safe return
-function srso_safe_ret_alias() which results in evicting a potentially
+untraining function srso_alias_untrain_ret() and the safe return
+function srso_alias_safe_ret() which results in evicting a potentially
 poisoned BTB entry and using that safe one for all function returns.
 
 In older Zen1 and Zen2, this is accomplished using a reinterpretation
diff --git a/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml b/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
new file mode 100644
index 000000000000..baa65a521bad
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
@@ -0,0 +1,158 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/addac/adi,ad74413r.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD74412R/AD74413R device
+
+maintainers:
+  - Cosmin Tanislav <cosmin.tanislav@analog.com>
+
+description: |
+  The AD74412R and AD74413R are quad-channel software configurable input/output
+  solutions for building and process control applications. They contain
+  functionality for analog output, analog input, digital input, resistance
+  temperature detector, and thermocouple measurements integrated
+  into a single chip solution with an SPI interface.
+  The devices feature a 16-bit ADC and four configurable 13-bit DACs to provide
+  four configurable input/output channels and a suite of diagnostic functions.
+  The AD74413R differentiates itself from the AD74412R by being HART-compatible.
+    https://www.analog.com/en/products/ad74412r.html
+    https://www.analog.com/en/products/ad74413r.html
+
+properties:
+  compatible:
+    enum:
+      - adi,ad74412r
+      - adi,ad74413r
+
+  reg:
+    maxItems: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  spi-max-frequency:
+    maximum: 1000000
+
+  spi-cpol: true
+
+  interrupts:
+    maxItems: 1
+
+  refin-supply: true
+
+  shunt-resistor-micro-ohms:
+    description:
+      Shunt (sense) resistor value in micro-Ohms.
+    default: 100000000
+
+required:
+  - compatible
+  - reg
+  - spi-max-frequency
+  - spi-cpol
+  - refin-supply
+
+additionalProperties: false
+
+patternProperties:
+  "^channel@[0-3]$":
+    type: object
+    description: Represents the external channels which are connected to the device.
+
+    properties:
+      reg:
+        description: |
+          The channel number. It can have up to 4 channels numbered from 0 to 3.
+        minimum: 0
+        maximum: 3
+
+      adi,ch-func:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: |
+          Channel function.
+          HART functions are not supported on AD74412R.
+          0 - CH_FUNC_HIGH_IMPEDANCE
+          1 - CH_FUNC_VOLTAGE_OUTPUT
+          2 - CH_FUNC_CURRENT_OUTPUT
+          3 - CH_FUNC_VOLTAGE_INPUT
+          4 - CH_FUNC_CURRENT_INPUT_EXT_POWER
+          5 - CH_FUNC_CURRENT_INPUT_LOOP_POWER
+          6 - CH_FUNC_RESISTANCE_INPUT
+          7 - CH_FUNC_DIGITAL_INPUT_LOGIC
+          8 - CH_FUNC_DIGITAL_INPUT_LOOP_POWER
+          9 - CH_FUNC_CURRENT_INPUT_EXT_POWER_HART
+          10 - CH_FUNC_CURRENT_INPUT_LOOP_POWER_HART
+        minimum: 0
+        maximum: 10
+        default: 0
+
+      adi,gpo-comparator:
+        type: boolean
+        description: |
+          Whether to configure GPO as a comparator or not.
+          When not configured as a comparator, the GPO will be treated as an
+          output-only GPIO.
+
+    required:
+      - reg
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/iio/addac/adi,ad74413r.h>
+
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      cs-gpios = <&gpio 17 GPIO_ACTIVE_LOW>;
+      status = "okay";
+
+      ad74413r@0 {
+        compatible = "adi,ad74413r";
+        reg = <0>;
+        spi-max-frequency = <1000000>;
+        spi-cpol;
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        interrupt-parent = <&gpio>;
+        interrupts = <26 IRQ_TYPE_EDGE_FALLING>;
+
+        refin-supply = <&ad74413r_refin>;
+
+        channel@0 {
+          reg = <0>;
+
+          adi,ch-func = <CH_FUNC_VOLTAGE_OUTPUT>;
+        };
+
+        channel@1 {
+          reg = <1>;
+
+          adi,ch-func = <CH_FUNC_CURRENT_OUTPUT>;
+        };
+
+        channel@2 {
+          reg = <2>;
+
+          adi,ch-func = <CH_FUNC_DIGITAL_INPUT_LOGIC>;
+          adi,gpo-comparator;
+        };
+
+        channel@3 {
+          reg = <3>;
+
+          adi,ch-func = <CH_FUNC_CURRENT_INPUT_EXT_POWER>;
+        };
+      };
+    };
+...
diff --git a/Makefile b/Makefile
index ecf9ab05e13a..316598ce1b12 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 10
-SUBLEVEL = 191
+SUBLEVEL = 192
 EXTRAVERSION =
 NAME = Dare mighty things
 
diff --git a/arch/arm/boot/dts/imx6dl-prtrvt.dts b/arch/arm/boot/dts/imx6dl-prtrvt.dts
index 5ac84445e9cc..90e01de8c2c1 100644
--- a/arch/arm/boot/dts/imx6dl-prtrvt.dts
+++ b/arch/arm/boot/dts/imx6dl-prtrvt.dts
@@ -126,6 +126,10 @@ &usbh1 {
 	status = "disabled";
 };
 
+&usbotg {
+	disable-over-current;
+};
+
 &vpu {
 	status = "disabled";
 };
diff --git a/arch/arm/boot/dts/imx6qdl-prti6q.dtsi b/arch/arm/boot/dts/imx6qdl-prti6q.dtsi
index 19578f660b09..70dfa07a1698 100644
--- a/arch/arm/boot/dts/imx6qdl-prti6q.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-prti6q.dtsi
@@ -69,6 +69,7 @@ &usbh1 {
 	vbus-supply = <&reg_usb_h1_vbus>;
 	phy_type = "utmi";
 	dr_mode = "host";
+	disable-over-current;
 	status = "okay";
 };
 
@@ -78,10 +79,18 @@ &usbotg {
 	pinctrl-0 = <&pinctrl_usbotg>;
 	phy_type = "utmi";
 	dr_mode = "host";
-	disable-over-current;
+	over-current-active-low;
 	status = "okay";
 };
 
+&usbphynop1 {
+	status = "disabled";
+};
+
+&usbphynop2 {
+	status = "disabled";
+};
+
 &usdhc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc1>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
index 64df64339119..2f52b91b7215 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
@@ -31,32 +31,56 @@ sdio_pwrseq: sdio-pwrseq {
 		reset-gpios = <&gpio0 RK_PB2 GPIO_ACTIVE_LOW>;
 	};
 
-	vcc12v_dcin: dc-12v {
+	sound {
+		compatible = "audio-graph-card";
+		label = "Analog";
+		dais = <&i2s0_p0>;
+	};
+
+	sound-dit {
+		compatible = "audio-graph-card";
+		label = "SPDIF";
+		dais = <&spdif_p0>;
+	};
+
+	spdif-dit {
+		compatible = "linux,spdif-dit";
+		#sound-dai-cells = <0>;
+
+		port {
+			dit_p0_0: endpoint {
+				remote-endpoint = <&spdif_p0_0>;
+			};
+		};
+	};
+
+	vbus_typec: vbus-typec-regulator {
 		compatible = "regulator-fixed";
-		regulator-name = "vcc12v_dcin";
+		enable-active-high;
+		gpio = <&gpio1 RK_PA3 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vcc5v0_typec_en>;
+		regulator-name = "vbus_typec";
 		regulator-always-on;
-		regulator-boot-on;
-		regulator-min-microvolt = <12000000>;
-		regulator-max-microvolt = <12000000>;
+		vin-supply = <&vcc5v0_sys>;
 	};
 
-	vcc5v0_sys: vcc-sys {
+	vcc12v_dcin: dc-12v {
 		compatible = "regulator-fixed";
-		regulator-name = "vcc5v0_sys";
+		regulator-name = "vcc12v_dcin";
 		regulator-always-on;
 		regulator-boot-on;
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		vin-supply = <&vcc12v_dcin>;
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
 	};
 
-	vcc_0v9: vcc-0v9 {
+	vcc3v3_lan: vcc3v3-lan-regulator {
 		compatible = "regulator-fixed";
-		regulator-name = "vcc_0v9";
+		regulator-name = "vcc3v3_lan";
 		regulator-always-on;
 		regulator-boot-on;
-		regulator-min-microvolt = <900000>;
-		regulator-max-microvolt = <900000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
 		vin-supply = <&vcc3v3_sys>;
 	};
 
@@ -93,28 +117,24 @@ vcc5v0_host: vcc5v0-host-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};
 
-	vcc5v0_typec: vcc5v0-typec-regulator {
+	vcc5v0_sys: vcc-sys {
 		compatible = "regulator-fixed";
-		enable-active-high;
-		gpio = <&gpio1 RK_PA3 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&vcc5v0_typec_en>;
-		regulator-name = "vcc5v0_typec";
+		regulator-name = "vcc5v0_sys";
 		regulator-always-on;
-		vin-supply = <&vcc5v0_sys>;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc12v_dcin>;
 	};
 
-	vcc_lan: vcc3v3-phy-regulator {
+	vcc_0v9: vcc-0v9 {
 		compatible = "regulator-fixed";
-		regulator-name = "vcc_lan";
+		regulator-name = "vcc_0v9";
 		regulator-always-on;
 		regulator-boot-on;
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-
-		regulator-state-mem {
-			regulator-off-in-suspend;
-		};
+		regulator-min-microvolt = <900000>;
+		regulator-max-microvolt = <900000>;
+		vin-supply = <&vcc3v3_sys>;
 	};
 
 	vdd_log: vdd-log {
@@ -161,7 +181,7 @@ &gmac {
 	assigned-clocks = <&cru SCLK_RMII_SRC>;
 	assigned-clock-parents = <&clkin_gmac>;
 	clock_in_out = "input";
-	phy-supply = <&vcc_lan>;
+	phy-supply = <&vcc3v3_lan>;
 	phy-mode = "rgmii";
 	pinctrl-names = "default";
 	pinctrl-0 = <&rgmii_pins>;
@@ -266,8 +286,8 @@ regulator-state-mem {
 				};
 			};
 
-			vcc1v8_codec: LDO_REG1 {
-				regulator-name = "vcc1v8_codec";
+			vcca1v8_codec: LDO_REG1 {
+				regulator-name = "vcca1v8_codec";
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-min-microvolt = <1800000>;
@@ -277,8 +297,8 @@ regulator-state-mem {
 				};
 			};
 
-			vcc1v8_hdmi: LDO_REG2 {
-				regulator-name = "vcc1v8_hdmi";
+			vcca1v8_hdmi: LDO_REG2 {
+				regulator-name = "vcca1v8_hdmi";
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-min-microvolt = <1800000>;
@@ -335,8 +355,8 @@ regulator-state-mem {
 				};
 			};
 
-			vcc0v9_hdmi: LDO_REG7 {
-				regulator-name = "vcc0v9_hdmi";
+			vcca0v9_hdmi: LDO_REG7 {
+				regulator-name = "vcca0v9_hdmi";
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-min-microvolt = <900000>;
@@ -362,8 +382,6 @@ vcc_cam: SWITCH_REG1 {
 				regulator-name = "vcc_cam";
 				regulator-always-on;
 				regulator-boot-on;
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
 				regulator-state-mem {
 					regulator-off-in-suspend;
 				};
@@ -373,8 +391,6 @@ vcc_mipi: SWITCH_REG2 {
 				regulator-name = "vcc_mipi";
 				regulator-always-on;
 				regulator-boot-on;
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
 				regulator-state-mem {
 					regulator-off-in-suspend;
 				};
@@ -425,6 +441,20 @@ &i2c1 {
 	i2c-scl-rising-time-ns = <300>;
 	i2c-scl-falling-time-ns = <15>;
 	status = "okay";
+
+	es8316: codec@11 {
+		compatible = "everest,es8316";
+		reg = <0x11>;
+		clocks = <&cru SCLK_I2S_8CH_OUT>;
+		clock-names = "mclk";
+		#sound-dai-cells = <0>;
+
+		port {
+			es8316_p0_0: endpoint {
+				remote-endpoint = <&i2s0_p0_0>;
+			};
+		};
+	};
 };
 
 &i2c3 {
@@ -443,6 +473,14 @@ &i2s0 {
 	rockchip,playback-channels = <8>;
 	rockchip,capture-channels = <8>;
 	status = "okay";
+
+	i2s0_p0: port {
+		i2s0_p0_0: endpoint {
+			dai-format = "i2s";
+			mclk-fs = <256>;
+			remote-endpoint = <&es8316_p0_0>;
+		};
+	};
 };
 
 &i2s1 {
@@ -455,21 +493,10 @@ &i2s2 {
 };
 
 &io_domains {
-	status = "okay";
-
+	audio-supply = <&vcca1v8_codec>;
 	bt656-supply = <&vcc_3v0>;
-	audio-supply = <&vcc1v8_codec>;
-	sdmmc-supply = <&vcc_sdio>;
 	gpio1830-supply = <&vcc_3v0>;
-};
-
-&pmu_io_domains {
-	status = "okay";
-
-	pmu1830-supply = <&vcc_3v0>;
-};
-
-&pcie_phy {
+	sdmmc-supply = <&vcc_sdio>;
 	status = "okay";
 };
 
@@ -485,6 +512,10 @@ &pcie0 {
 	status = "okay";
 };
 
+&pcie_phy {
+	status = "okay";
+};
+
 &pinctrl {
 	bt {
 		bt_enable_h: bt-enable-h {
@@ -506,6 +537,20 @@ pcie_pwr_en: pcie-pwr-en {
 		};
 	};
 
+	pmic {
+		pmic_int_l: pmic-int-l {
+			rockchip,pins = <1 RK_PC5 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+
+		vsel1_pin: vsel1-pin {
+			rockchip,pins = <1 RK_PC1 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+
+		vsel2_pin: vsel2-pin {
+			rockchip,pins = <1 RK_PB6 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+	};
+
 	sdio0 {
 		sdio0_bus4: sdio0-bus4 {
 			rockchip,pins = <2 RK_PC4 1 &pcfg_pull_up_20ma>,
@@ -523,20 +568,6 @@ sdio0_clk: sdio0-clk {
 		};
 	};
 
-	pmic {
-		pmic_int_l: pmic-int-l {
-			rockchip,pins = <1 RK_PC5 RK_FUNC_GPIO &pcfg_pull_up>;
-		};
-
-		vsel1_pin: vsel1-pin {
-			rockchip,pins = <1 RK_PC1 RK_FUNC_GPIO &pcfg_pull_down>;
-		};
-
-		vsel2_pin: vsel2-pin {
-			rockchip,pins = <1 RK_PB6 RK_FUNC_GPIO &pcfg_pull_down>;
-		};
-	};
-
 	usb-typec {
 		vcc5v0_typec_en: vcc5v0-typec-en {
 			rockchip,pins = <1 RK_PA3 RK_FUNC_GPIO &pcfg_pull_up>;
@@ -560,6 +591,11 @@ wifi_host_wake_l: wifi-host-wake-l {
 	};
 };
 
+&pmu_io_domains {
+	pmu1830-supply = <&vcc_3v0>;
+	status = "okay";
+};
+
 &pwm2 {
 	status = "okay";
 };
@@ -570,6 +606,14 @@ &saradc {
 	vref-supply = <&vcc_1v8>;
 };
 
+&sdhci {
+	max-frequency = <150000000>;
+	bus-width = <8>;
+	mmc-hs200-1_8v;
+	non-removable;
+	status = "okay";
+};
+
 &sdio0 {
 	#address-cells = <1>;
 	#size-cells = <0>;
@@ -597,12 +641,13 @@ &sdmmc {
 	status = "okay";
 };
 
-&sdhci {
-	bus-width = <8>;
-	mmc-hs400-1_8v;
-	mmc-hs400-enhanced-strobe;
-	non-removable;
-	status = "okay";
+&spdif {
+
+	spdif_p0: port {
+		spdif_p0_0: endpoint {
+			remote-endpoint = <&dit_p0_0>;
+		};
+	};
 };
 
 &tcphy0 {
@@ -677,13 +722,13 @@ &usbdrd3_0 {
 	status = "okay";
 };
 
-&usbdrd_dwc3_0 {
+&usbdrd3_1 {
 	status = "okay";
-	dr_mode = "otg";
 };
 
-&usbdrd3_1 {
+&usbdrd_dwc3_0 {
 	status = "okay";
+	dr_mode = "host";
 };
 
 &usbdrd_dwc3_1 {
diff --git a/arch/mips/include/asm/dec/prom.h b/arch/mips/include/asm/dec/prom.h
index 1e1247add1cf..908e96e3a311 100644
--- a/arch/mips/include/asm/dec/prom.h
+++ b/arch/mips/include/asm/dec/prom.h
@@ -70,7 +70,7 @@ static inline bool prom_is_rex(u32 magic)
  */
 typedef struct {
 	int pagesize;
-	unsigned char bitmap[0];
+	unsigned char bitmap[];
 } memmap;
 
 
diff --git a/arch/powerpc/kernel/rtas_flash.c b/arch/powerpc/kernel/rtas_flash.c
index a99179d83538..56bd0aa30f93 100644
--- a/arch/powerpc/kernel/rtas_flash.c
+++ b/arch/powerpc/kernel/rtas_flash.c
@@ -710,9 +710,9 @@ static int __init rtas_flash_init(void)
 	if (!rtas_validate_flash_data.buf)
 		return -ENOMEM;
 
-	flash_block_cache = kmem_cache_create("rtas_flash_cache",
-					      RTAS_BLK_SIZE, RTAS_BLK_SIZE, 0,
-					      NULL);
+	flash_block_cache = kmem_cache_create_usercopy("rtas_flash_cache",
+						       RTAS_BLK_SIZE, RTAS_BLK_SIZE,
+						       0, 0, RTAS_BLK_SIZE, NULL);
 	if (!flash_block_cache) {
 		printk(KERN_ERR "%s: failed to create block cache\n",
 				__func__);
diff --git a/arch/powerpc/mm/kasan/Makefile b/arch/powerpc/mm/kasan/Makefile
index bb1a5408b86b..8636b17c6a20 100644
--- a/arch/powerpc/mm/kasan/Makefile
+++ b/arch/powerpc/mm/kasan/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 KASAN_SANITIZE := n
+KCOV_INSTRUMENT := n
 
 obj-$(CONFIG_PPC32)           += kasan_init_32.o
 obj-$(CONFIG_PPC_8xx)		+= 8xx.o
diff --git a/arch/x86/include/asm/entry-common.h b/arch/x86/include/asm/entry-common.h
index 4a382fb6a9ef..5443851d3aa6 100644
--- a/arch/x86/include/asm/entry-common.h
+++ b/arch/x86/include/asm/entry-common.h
@@ -78,6 +78,7 @@ static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
 static __always_inline void arch_exit_to_user_mode(void)
 {
 	mds_user_clear_cpu_buffers();
+	amd_clear_divider();
 }
 #define arch_exit_to_user_mode arch_exit_to_user_mode
 
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 99fbce2c1c7c..7b4782249a92 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -156,9 +156,9 @@
 .endm
 
 #ifdef CONFIG_CPU_UNRET_ENTRY
-#define CALL_ZEN_UNTRAIN_RET	"call zen_untrain_ret"
+#define CALL_UNTRAIN_RET	"call entry_untrain_ret"
 #else
-#define CALL_ZEN_UNTRAIN_RET	""
+#define CALL_UNTRAIN_RET	""
 #endif
 
 /*
@@ -166,7 +166,7 @@
  * return thunk isn't mapped into the userspace tables (then again, AMD
  * typically has NO_MELTDOWN).
  *
- * While zen_untrain_ret() doesn't clobber anything but requires stack,
+ * While retbleed_untrain_ret() doesn't clobber anything but requires stack,
  * entry_ibpb() will clobber AX, CX, DX.
  *
  * As such, this must be placed after every *SWITCH_TO_KERNEL_CR3 at a point
@@ -177,14 +177,9 @@
 	defined(CONFIG_CPU_SRSO)
 	ANNOTATE_UNRET_END
 	ALTERNATIVE_2 "",						\
-	              CALL_ZEN_UNTRAIN_RET, X86_FEATURE_UNRET,		\
+		      CALL_UNTRAIN_RET, X86_FEATURE_UNRET,		\
 		      "call entry_ibpb", X86_FEATURE_ENTRY_IBPB
 #endif
-
-#ifdef CONFIG_CPU_SRSO
-	ALTERNATIVE_2 "", "call srso_untrain_ret", X86_FEATURE_SRSO, \
-			  "call srso_untrain_ret_alias", X86_FEATURE_SRSO_ALIAS
-#endif
 .endm
 
 #else /* __ASSEMBLY__ */
@@ -195,10 +190,21 @@
 	_ASM_PTR " 999b\n\t"					\
 	".popsection\n\t"
 
+#ifdef CONFIG_RETHUNK
 extern void __x86_return_thunk(void);
-extern void zen_untrain_ret(void);
+#else
+static inline void __x86_return_thunk(void) {}
+#endif
+
+extern void retbleed_return_thunk(void);
+extern void srso_return_thunk(void);
+extern void srso_alias_return_thunk(void);
+
+extern void retbleed_untrain_ret(void);
 extern void srso_untrain_ret(void);
-extern void srso_untrain_ret_alias(void);
+extern void srso_alias_untrain_ret(void);
+
+extern void entry_untrain_ret(void);
 extern void entry_ibpb(void);
 
 #ifdef CONFIG_RETPOLINE
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 7f351093cd94..2bc1c78a7cc5 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1332,3 +1332,4 @@ void noinstr amd_clear_divider(void)
 	asm volatile(ALTERNATIVE("", "div %2\n\t", X86_BUG_DIV0)
 		     :: "a" (0), "d" (0), "r" (1));
 }
+EXPORT_SYMBOL_GPL(amd_clear_divider);
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index d31639e3ce28..4d11a50089b2 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -61,6 +61,8 @@ EXPORT_SYMBOL_GPL(x86_pred_cmd);
 
 static DEFINE_MUTEX(spec_ctrl_mutex);
 
+void (*x86_return_thunk)(void) __ro_after_init = &__x86_return_thunk;
+
 /* Update SPEC_CTRL MSR and its cached copy unconditionally */
 static void update_spec_ctrl(u64 val)
 {
@@ -155,8 +157,13 @@ void __init cpu_select_mitigations(void)
 	l1tf_select_mitigation();
 	md_clear_select_mitigation();
 	srbds_select_mitigation();
-	gds_select_mitigation();
+
+	/*
+	 * srso_select_mitigation() depends and must run after
+	 * retbleed_select_mitigation().
+	 */
 	srso_select_mitigation();
+	gds_select_mitigation();
 }
 
 /*
@@ -976,6 +983,9 @@ static void __init retbleed_select_mitigation(void)
 		setup_force_cpu_cap(X86_FEATURE_RETHUNK);
 		setup_force_cpu_cap(X86_FEATURE_UNRET);
 
+		if (IS_ENABLED(CONFIG_RETHUNK))
+			x86_return_thunk = retbleed_return_thunk;
+
 		if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
 		    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
 			pr_err(RETBLEED_UNTRAIN_MSG);
@@ -2318,9 +2328,10 @@ static void __init srso_select_mitigation(void)
 		 * Zen1/2 with SMT off aren't vulnerable after the right
 		 * IBPB microcode has been applied.
 		 */
-		if ((boot_cpu_data.x86 < 0x19) &&
-		    (!cpu_smt_possible() || (cpu_smt_control == CPU_SMT_DISABLED)))
+		if (boot_cpu_data.x86 < 0x19 && !cpu_smt_possible()) {
 			setup_force_cpu_cap(X86_FEATURE_SRSO_NO);
+			return;
+		}
 	}
 
 	if (retbleed_mitigation == RETBLEED_MITIGATION_IBPB) {
@@ -2349,11 +2360,15 @@ static void __init srso_select_mitigation(void)
 			 * like ftrace, static_call, etc.
 			 */
 			setup_force_cpu_cap(X86_FEATURE_RETHUNK);
+			setup_force_cpu_cap(X86_FEATURE_UNRET);
 
-			if (boot_cpu_data.x86 == 0x19)
+			if (boot_cpu_data.x86 == 0x19) {
 				setup_force_cpu_cap(X86_FEATURE_SRSO_ALIAS);
-			else
+				x86_return_thunk = srso_alias_return_thunk;
+			} else {
 				setup_force_cpu_cap(X86_FEATURE_SRSO);
+				x86_return_thunk = srso_return_thunk;
+			}
 			srso_mitigation = SRSO_MITIGATION_SAFE_RET;
 		} else {
 			pr_err("WARNING: kernel not compiled with CPU_SRSO.\n");
@@ -2602,6 +2617,9 @@ static ssize_t gds_show_state(char *buf)
 
 static ssize_t srso_show_state(char *buf)
 {
+	if (boot_cpu_has(X86_FEATURE_SRSO_NO))
+		return sysfs_emit(buf, "Mitigation: SMT disabled\n");
+
 	return sysfs_emit(buf, "%s%s\n",
 			  srso_strings[srso_mitigation],
 			  (cpu_has_ibpb_brtype_microcode() ? "" : ", no microcode"));
diff --git a/arch/x86/kernel/static_call.c b/arch/x86/kernel/static_call.c
index 2973b3fb0ec1..759b986b7f03 100644
--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -123,6 +123,19 @@ EXPORT_SYMBOL_GPL(arch_static_call_transform);
  */
 bool __static_call_fixup(void *tramp, u8 op, void *dest)
 {
+	unsigned long addr = (unsigned long)tramp;
+	/*
+	 * Not all .return_sites are a static_call trampoline (most are not).
+	 * Check if the 3 bytes after the return are still kernel text, if not,
+	 * then this definitely is not a trampoline and we need not worry
+	 * further.
+	 *
+	 * This avoids the memcmp() below tripping over pagefaults etc..
+	 */
+	if (((addr >> PAGE_SHIFT) != ((addr + 7) >> PAGE_SHIFT)) &&
+	    !kernel_text_address(addr + 7))
+		return false;
+
 	if (memcmp(tramp+5, tramp_ud, 3)) {
 		/* Not a trampoline site, not our problem. */
 		return false;
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 28f5cc0a9dec..98838b784524 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -198,8 +198,6 @@ DEFINE_IDTENTRY(exc_divide_error)
 {
 	do_error_trap(regs, 0, "divide error", X86_TRAP_DE, SIGFPE,
 		      FPE_INTDIV, error_get_trap_addr(regs));
-
-	amd_clear_divider();
 }
 
 DEFINE_IDTENTRY(exc_overflow)
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 72ba175cb9d4..f0d4500ae77a 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -134,18 +134,18 @@ SECTIONS
 		KPROBES_TEXT
 		ALIGN_ENTRY_TEXT_BEGIN
 #ifdef CONFIG_CPU_SRSO
-		*(.text.__x86.rethunk_untrain)
+		*(.text..__x86.rethunk_untrain)
 #endif
 
 		ENTRY_TEXT
 
 #ifdef CONFIG_CPU_SRSO
 		/*
-		 * See the comment above srso_untrain_ret_alias()'s
+		 * See the comment above srso_alias_untrain_ret()'s
 		 * definition.
 		 */
-		. = srso_untrain_ret_alias | (1 << 2) | (1 << 8) | (1 << 14) | (1 << 20);
-		*(.text.__x86.rethunk_safe)
+		. = srso_alias_untrain_ret | (1 << 2) | (1 << 8) | (1 << 14) | (1 << 20);
+		*(.text..__x86.rethunk_safe)
 #endif
 		ALIGN_ENTRY_TEXT_END
 		SOFTIRQENTRY_TEXT
@@ -155,8 +155,8 @@ SECTIONS
 
 #ifdef CONFIG_RETPOLINE
 		__indirect_thunk_start = .;
-		*(.text.__x86.indirect_thunk)
-		*(.text.__x86.return_thunk)
+		*(.text..__x86.indirect_thunk)
+		*(.text..__x86.return_thunk)
 		__indirect_thunk_end = .;
 #endif
 	} :text =0xcccc
@@ -518,7 +518,7 @@ INIT_PER_CPU(irq_stack_backing_store);
 #endif
 
 #ifdef CONFIG_RETHUNK
-. = ASSERT((__ret & 0x3f) == 0, "__ret not cacheline-aligned");
+. = ASSERT((retbleed_return_thunk & 0x3f) == 0, "retbleed_return_thunk not cacheline-aligned");
 . = ASSERT((srso_safe_ret & 0x3f) == 0, "srso_safe_ret not cacheline-aligned");
 #endif
 
@@ -533,8 +533,8 @@ INIT_PER_CPU(irq_stack_backing_store);
  * Instead do: (A | B) - (A & B) in order to compute the XOR
  * of the two function addresses:
  */
-. = ASSERT(((ABSOLUTE(srso_untrain_ret_alias) | srso_safe_ret_alias) -
-		(ABSOLUTE(srso_untrain_ret_alias) & srso_safe_ret_alias)) == ((1 << 2) | (1 << 8) | (1 << 14) | (1 << 20)),
+. = ASSERT(((ABSOLUTE(srso_alias_untrain_ret) | srso_alias_safe_ret) -
+		(ABSOLUTE(srso_alias_untrain_ret) & srso_alias_safe_ret)) == ((1 << 2) | (1 << 8) | (1 << 14) | (1 << 20)),
 		"SRSO function pair won't alias");
 #endif
 
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 8544bca6b335..1616e39ddc3f 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3376,6 +3376,7 @@ static void svm_flush_tlb_gva(struct kvm_vcpu *vcpu, gva_t gva)
 
 static void svm_prepare_guest_switch(struct kvm_vcpu *vcpu)
 {
+	amd_clear_divider();
 }
 
 static inline void sync_cr8_to_lapic(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 5f7eed97487e..6f5321b36dbb 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -11,7 +11,7 @@
 #include <asm/frame.h>
 #include <asm/nops.h>
 
-	.section .text.__x86.indirect_thunk
+	.section .text..__x86.indirect_thunk
 
 .macro RETPOLINE reg
 	ANNOTATE_INTRA_FUNCTION_CALL
@@ -75,74 +75,105 @@ SYM_CODE_END(__x86_indirect_thunk_array)
 #ifdef CONFIG_RETHUNK
 
 /*
- * srso_untrain_ret_alias() and srso_safe_ret_alias() are placed at
+ * srso_alias_untrain_ret() and srso_alias_safe_ret() are placed at
  * special addresses:
  *
- * - srso_untrain_ret_alias() is 2M aligned
- * - srso_safe_ret_alias() is also in the same 2M page but bits 2, 8, 14
+ * - srso_alias_untrain_ret() is 2M aligned
+ * - srso_alias_safe_ret() is also in the same 2M page but bits 2, 8, 14
  * and 20 in its virtual address are set (while those bits in the
- * srso_untrain_ret_alias() function are cleared).
+ * srso_alias_untrain_ret() function are cleared).
  *
  * This guarantees that those two addresses will alias in the branch
  * target buffer of Zen3/4 generations, leading to any potential
  * poisoned entries at that BTB slot to get evicted.
  *
- * As a result, srso_safe_ret_alias() becomes a safe return.
+ * As a result, srso_alias_safe_ret() becomes a safe return.
  */
 #ifdef CONFIG_CPU_SRSO
-	.section .text.__x86.rethunk_untrain
+	.section .text..__x86.rethunk_untrain
 
-SYM_START(srso_untrain_ret_alias, SYM_L_GLOBAL, SYM_A_NONE)
+SYM_START(srso_alias_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
+	UNWIND_HINT_FUNC
 	ASM_NOP2
 	lfence
-	jmp __x86_return_thunk
-SYM_FUNC_END(srso_untrain_ret_alias)
-__EXPORT_THUNK(srso_untrain_ret_alias)
+	jmp srso_alias_return_thunk
+SYM_FUNC_END(srso_alias_untrain_ret)
+__EXPORT_THUNK(srso_alias_untrain_ret)
 
-	.section .text.__x86.rethunk_safe
+	.section .text..__x86.rethunk_safe
+#else
+/* dummy definition for alternatives */
+SYM_START(srso_alias_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+SYM_FUNC_END(srso_alias_untrain_ret)
 #endif
 
-/* Needs a definition for the __x86_return_thunk alternative below. */
-SYM_START(srso_safe_ret_alias, SYM_L_GLOBAL, SYM_A_NONE)
-#ifdef CONFIG_CPU_SRSO
-	add $8, %_ASM_SP
+SYM_START(srso_alias_safe_ret, SYM_L_GLOBAL, SYM_A_NONE)
+	lea 8(%_ASM_SP), %_ASM_SP
 	UNWIND_HINT_FUNC
-#endif
 	ANNOTATE_UNRET_SAFE
 	ret
 	int3
-SYM_FUNC_END(srso_safe_ret_alias)
+SYM_FUNC_END(srso_alias_safe_ret)
 
-	.section .text.__x86.return_thunk
+	.section .text..__x86.return_thunk
+
+SYM_CODE_START(srso_alias_return_thunk)
+	UNWIND_HINT_FUNC
+	ANNOTATE_NOENDBR
+	call srso_alias_safe_ret
+	ud2
+SYM_CODE_END(srso_alias_return_thunk)
+
+/*
+ * Some generic notes on the untraining sequences:
+ *
+ * They are interchangeable when it comes to flushing potentially wrong
+ * RET predictions from the BTB.
+ *
+ * The SRSO Zen1/2 (MOVABS) untraining sequence is longer than the
+ * Retbleed sequence because the return sequence done there
+ * (srso_safe_ret()) is longer and the return sequence must fully nest
+ * (end before) the untraining sequence. Therefore, the untraining
+ * sequence must fully overlap the return sequence.
+ *
+ * Regarding alignment - the instructions which need to be untrained,
+ * must all start at a cacheline boundary for Zen1/2 generations. That
+ * is, instruction sequences starting at srso_safe_ret() and
+ * the respective instruction sequences at retbleed_return_thunk()
+ * must start at a cacheline boundary.
+ */
 
 /*
  * Safety details here pertain to the AMD Zen{1,2} microarchitecture:
- * 1) The RET at __x86_return_thunk must be on a 64 byte boundary, for
+ * 1) The RET at retbleed_return_thunk must be on a 64 byte boundary, for
  *    alignment within the BTB.
- * 2) The instruction at zen_untrain_ret must contain, and not
+ * 2) The instruction at retbleed_untrain_ret must contain, and not
  *    end with, the 0xc3 byte of the RET.
  * 3) STIBP must be enabled, or SMT disabled, to prevent the sibling thread
  *    from re-poisioning the BTB prediction.
  */
 	.align 64
-	.skip 64 - (__ret - zen_untrain_ret), 0xcc
-SYM_FUNC_START_NOALIGN(zen_untrain_ret);
+	.skip 64 - (retbleed_return_thunk - retbleed_untrain_ret), 0xcc
+SYM_FUNC_START_NOALIGN(retbleed_untrain_ret);
 
 	/*
-	 * As executed from zen_untrain_ret, this is:
+	 * As executed from retbleed_untrain_ret, this is:
 	 *
 	 *   TEST $0xcc, %bl
 	 *   LFENCE
-	 *   JMP __x86_return_thunk
+	 *   JMP retbleed_return_thunk
 	 *
 	 * Executing the TEST instruction has a side effect of evicting any BTB
 	 * prediction (potentially attacker controlled) attached to the RET, as
-	 * __x86_return_thunk + 1 isn't an instruction boundary at the moment.
+	 * retbleed_return_thunk + 1 isn't an instruction boundary at the moment.
 	 */
 	.byte	0xf6
 
 	/*
-	 * As executed from __x86_return_thunk, this is a plain RET.
+	 * As executed from retbleed_return_thunk, this is a plain RET.
 	 *
 	 * As part of the TEST above, RET is the ModRM byte, and INT3 the imm8.
 	 *
@@ -154,13 +185,13 @@ SYM_FUNC_START_NOALIGN(zen_untrain_ret);
 	 * With SMT enabled and STIBP active, a sibling thread cannot poison
 	 * RET's prediction to a type of its choice, but can evict the
 	 * prediction due to competitive sharing. If the prediction is
-	 * evicted, __x86_return_thunk will suffer Straight Line Speculation
+	 * evicted, retbleed_return_thunk will suffer Straight Line Speculation
 	 * which will be contained safely by the INT3.
 	 */
-SYM_INNER_LABEL(__ret, SYM_L_GLOBAL)
+SYM_INNER_LABEL(retbleed_return_thunk, SYM_L_GLOBAL)
 	ret
 	int3
-SYM_CODE_END(__ret)
+SYM_CODE_END(retbleed_return_thunk)
 
 	/*
 	 * Ensure the TEST decoding / BTB invalidation is complete.
@@ -171,16 +202,16 @@ SYM_CODE_END(__ret)
 	 * Jump back and execute the RET in the middle of the TEST instruction.
 	 * INT3 is for SLS protection.
 	 */
-	jmp __ret
+	jmp retbleed_return_thunk
 	int3
-SYM_FUNC_END(zen_untrain_ret)
-__EXPORT_THUNK(zen_untrain_ret)
+SYM_FUNC_END(retbleed_untrain_ret)
+__EXPORT_THUNK(retbleed_untrain_ret)
 
 /*
- * SRSO untraining sequence for Zen1/2, similar to zen_untrain_ret()
+ * SRSO untraining sequence for Zen1/2, similar to retbleed_untrain_ret()
  * above. On kernel entry, srso_untrain_ret() is executed which is a
  *
- * movabs $0xccccccc308c48348,%rax
+ * movabs $0xccccc30824648d48,%rax
  *
  * and when the return thunk executes the inner label srso_safe_ret()
  * later, it is a stack manipulation and a RET which is mispredicted and
@@ -191,22 +222,44 @@ __EXPORT_THUNK(zen_untrain_ret)
 SYM_START(srso_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
 	.byte 0x48, 0xb8
 
+/*
+ * This forces the function return instruction to speculate into a trap
+ * (UD2 in srso_return_thunk() below).  This RET will then mispredict
+ * and execution will continue at the return site read from the top of
+ * the stack.
+ */
 SYM_INNER_LABEL(srso_safe_ret, SYM_L_GLOBAL)
-	add $8, %_ASM_SP
+	lea 8(%_ASM_SP), %_ASM_SP
 	ret
 	int3
 	int3
-	int3
+	/* end of movabs */
 	lfence
 	call srso_safe_ret
-	int3
+	ud2
 SYM_CODE_END(srso_safe_ret)
 SYM_FUNC_END(srso_untrain_ret)
 __EXPORT_THUNK(srso_untrain_ret)
 
-SYM_FUNC_START(__x86_return_thunk)
-	ALTERNATIVE_2 "jmp __ret", "call srso_safe_ret", X86_FEATURE_SRSO, \
-			"call srso_safe_ret_alias", X86_FEATURE_SRSO_ALIAS
+SYM_CODE_START(srso_return_thunk)
+	UNWIND_HINT_FUNC
+	ANNOTATE_NOENDBR
+	call srso_safe_ret
+	ud2
+SYM_CODE_END(srso_return_thunk)
+
+SYM_FUNC_START(entry_untrain_ret)
+	ALTERNATIVE_2 "jmp retbleed_untrain_ret", \
+		      "jmp srso_untrain_ret", X86_FEATURE_SRSO, \
+		      "jmp srso_alias_untrain_ret", X86_FEATURE_SRSO_ALIAS
+SYM_FUNC_END(entry_untrain_ret)
+__EXPORT_THUNK(entry_untrain_ret)
+
+SYM_CODE_START(__x86_return_thunk)
+	UNWIND_HINT_FUNC
+	ANNOTATE_NOENDBR
+	ANNOTATE_UNRET_SAFE
+	ret
 	int3
 SYM_CODE_END(__x86_return_thunk)
 EXPORT_SYMBOL(__x86_return_thunk)
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 2695ece47eb0..49d5375b04f4 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -432,6 +432,9 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x0489, 0xe0d9), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH |
 						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x0489, 0xe0f5), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
 	{ USB_DEVICE(0x13d3, 0x3568), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH |
 						     BTUSB_VALID_LE_STATES },
diff --git a/drivers/bus/Makefile b/drivers/bus/Makefile
index 397e35392bff..16c47a0616ae 100644
--- a/drivers/bus/Makefile
+++ b/drivers/bus/Makefile
@@ -38,4 +38,4 @@ obj-$(CONFIG_VEXPRESS_CONFIG)	+= vexpress-config.o
 obj-$(CONFIG_DA8XX_MSTPRI)	+= da8xx-mstpri.o
 
 # MHI
-obj-$(CONFIG_MHI_BUS)		+= mhi/
+obj-y				+= mhi/
diff --git a/drivers/bus/mhi/Kconfig b/drivers/bus/mhi/Kconfig
index e841c1097fb4..4748df7f9cd5 100644
--- a/drivers/bus/mhi/Kconfig
+++ b/drivers/bus/mhi/Kconfig
@@ -2,21 +2,7 @@
 #
 # MHI bus
 #
-# Copyright (c) 2018-2020, The Linux Foundation. All rights reserved.
+# Copyright (c) 2021, Linaro Ltd.
 #
 
-config MHI_BUS
-	tristate "Modem Host Interface (MHI) bus"
-	help
-	  Bus driver for MHI protocol. Modem Host Interface (MHI) is a
-	  communication protocol used by the host processors to control
-	  and communicate with modem devices over a high speed peripheral
-	  bus or shared memory.
-
-config MHI_BUS_DEBUG
-	bool "Debugfs support for the MHI bus"
-	depends on MHI_BUS && DEBUG_FS
-	help
-	  Enable debugfs support for use with the MHI transport. Allows
-	  reading and/or modifying some values within the MHI controller
-	  for debug and test purposes.
+source "drivers/bus/mhi/host/Kconfig"
diff --git a/drivers/bus/mhi/Makefile b/drivers/bus/mhi/Makefile
index 19e6443b72df..5f5708a249f5 100644
--- a/drivers/bus/mhi/Makefile
+++ b/drivers/bus/mhi/Makefile
@@ -1,2 +1,2 @@
-# core layer
-obj-y += core/
+# Host MHI stack
+obj-y += host/
diff --git a/drivers/bus/mhi/core/Makefile b/drivers/bus/mhi/core/Makefile
deleted file mode 100644
index c3feb4130aa3..000000000000
--- a/drivers/bus/mhi/core/Makefile
+++ /dev/null
@@ -1,4 +0,0 @@
-obj-$(CONFIG_MHI_BUS) += mhi.o
-
-mhi-y := init.o main.o pm.o boot.o
-mhi-$(CONFIG_MHI_BUS_DEBUG) += debugfs.o
diff --git a/drivers/bus/mhi/core/boot.c b/drivers/bus/mhi/core/boot.c
deleted file mode 100644
index 24422f5c3d80..000000000000
--- a/drivers/bus/mhi/core/boot.c
+++ /dev/null
@@ -1,525 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (c) 2018-2020, The Linux Foundation. All rights reserved.
- *
- */
-
-#include <linux/delay.h>
-#include <linux/device.h>
-#include <linux/dma-direction.h>
-#include <linux/dma-mapping.h>
-#include <linux/firmware.h>
-#include <linux/interrupt.h>
-#include <linux/list.h>
-#include <linux/mhi.h>
-#include <linux/module.h>
-#include <linux/random.h>
-#include <linux/slab.h>
-#include <linux/wait.h>
-#include "internal.h"
-
-/* Setup RDDM vector table for RDDM transfer and program RXVEC */
-void mhi_rddm_prepare(struct mhi_controller *mhi_cntrl,
-		      struct image_info *img_info)
-{
-	struct mhi_buf *mhi_buf = img_info->mhi_buf;
-	struct bhi_vec_entry *bhi_vec = img_info->bhi_vec;
-	void __iomem *base = mhi_cntrl->bhie;
-	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-	u32 sequence_id;
-	unsigned int i;
-
-	for (i = 0; i < img_info->entries - 1; i++, mhi_buf++, bhi_vec++) {
-		bhi_vec->dma_addr = mhi_buf->dma_addr;
-		bhi_vec->size = mhi_buf->len;
-	}
-
-	dev_dbg(dev, "BHIe programming for RDDM\n");
-
-	mhi_write_reg(mhi_cntrl, base, BHIE_RXVECADDR_HIGH_OFFS,
-		      upper_32_bits(mhi_buf->dma_addr));
-
-	mhi_write_reg(mhi_cntrl, base, BHIE_RXVECADDR_LOW_OFFS,
-		      lower_32_bits(mhi_buf->dma_addr));
-
-	mhi_write_reg(mhi_cntrl, base, BHIE_RXVECSIZE_OFFS, mhi_buf->len);
-	sequence_id = MHI_RANDOM_U32_NONZERO(BHIE_RXVECSTATUS_SEQNUM_BMSK);
-
-	mhi_write_reg_field(mhi_cntrl, base, BHIE_RXVECDB_OFFS,
-			    BHIE_RXVECDB_SEQNUM_BMSK, BHIE_RXVECDB_SEQNUM_SHFT,
-			    sequence_id);
-
-	dev_dbg(dev, "Address: %p and len: 0x%zx sequence: %u\n",
-		&mhi_buf->dma_addr, mhi_buf->len, sequence_id);
-}
-
-/* Collect RDDM buffer during kernel panic */
-static int __mhi_download_rddm_in_panic(struct mhi_controller *mhi_cntrl)
-{
-	int ret;
-	u32 rx_status;
-	enum mhi_ee_type ee;
-	const u32 delayus = 2000;
-	u32 retry = (mhi_cntrl->timeout_ms * 1000) / delayus;
-	const u32 rddm_timeout_us = 200000;
-	int rddm_retry = rddm_timeout_us / delayus;
-	void __iomem *base = mhi_cntrl->bhie;
-	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-
-	dev_dbg(dev, "Entered with pm_state:%s dev_state:%s ee:%s\n",
-		to_mhi_pm_state_str(mhi_cntrl->pm_state),
-		TO_MHI_STATE_STR(mhi_cntrl->dev_state),
-		TO_MHI_EXEC_STR(mhi_cntrl->ee));
-
-	/*
-	 * This should only be executing during a kernel panic, we expect all
-	 * other cores to shutdown while we're collecting RDDM buffer. After
-	 * returning from this function, we expect the device to reset.
-	 *
-	 * Normaly, we read/write pm_state only after grabbing the
-	 * pm_lock, since we're in a panic, skipping it. Also there is no
-	 * gurantee that this state change would take effect since
-	 * we're setting it w/o grabbing pm_lock
-	 */
-	mhi_cntrl->pm_state = MHI_PM_LD_ERR_FATAL_DETECT;
-	/* update should take the effect immediately */
-	smp_wmb();
-
-	/*
-	 * Make sure device is not already in RDDM. In case the device asserts
-	 * and a kernel panic follows, device will already be in RDDM.
-	 * Do not trigger SYS ERR again and proceed with waiting for
-	 * image download completion.
-	 */
-	ee = mhi_get_exec_env(mhi_cntrl);
-	if (ee != MHI_EE_RDDM) {
-		dev_dbg(dev, "Trigger device into RDDM mode using SYS ERR\n");
-		mhi_set_mhi_state(mhi_cntrl, MHI_STATE_SYS_ERR);
-
-		dev_dbg(dev, "Waiting for device to enter RDDM\n");
-		while (rddm_retry--) {
-			ee = mhi_get_exec_env(mhi_cntrl);
-			if (ee == MHI_EE_RDDM)
-				break;
-
-			udelay(delayus);
-		}
-
-		if (rddm_retry <= 0) {
-			/* Hardware reset so force device to enter RDDM */
-			dev_dbg(dev,
-				"Did not enter RDDM, do a host req reset\n");
-			mhi_write_reg(mhi_cntrl, mhi_cntrl->regs,
-				      MHI_SOC_RESET_REQ_OFFSET,
-				      MHI_SOC_RESET_REQ);
-			udelay(delayus);
-		}
-
-		ee = mhi_get_exec_env(mhi_cntrl);
-	}
-
-	dev_dbg(dev,
-		"Waiting for RDDM image download via BHIe, current EE:%s\n",
-		TO_MHI_EXEC_STR(ee));
-
-	while (retry--) {
-		ret = mhi_read_reg_field(mhi_cntrl, base, BHIE_RXVECSTATUS_OFFS,
-					 BHIE_RXVECSTATUS_STATUS_BMSK,
-					 BHIE_RXVECSTATUS_STATUS_SHFT,
-					 &rx_status);
-		if (ret)
-			return -EIO;
-
-		if (rx_status == BHIE_RXVECSTATUS_STATUS_XFER_COMPL)
-			return 0;
-
-		udelay(delayus);
-	}
-
-	ee = mhi_get_exec_env(mhi_cntrl);
-	ret = mhi_read_reg(mhi_cntrl, base, BHIE_RXVECSTATUS_OFFS, &rx_status);
-
-	dev_err(dev, "Did not complete RDDM transfer\n");
-	dev_err(dev, "Current EE: %s\n", TO_MHI_EXEC_STR(ee));
-	dev_err(dev, "RXVEC_STATUS: 0x%x\n", rx_status);
-
-	return -EIO;
-}
-
-/* Download RDDM image from device */
-int mhi_download_rddm_img(struct mhi_controller *mhi_cntrl, bool in_panic)
-{
-	void __iomem *base = mhi_cntrl->bhie;
-	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-	u32 rx_status;
-
-	if (in_panic)
-		return __mhi_download_rddm_in_panic(mhi_cntrl);
-
-	dev_dbg(dev, "Waiting for RDDM image download via BHIe\n");
-
-	/* Wait for the image download to complete */
-	wait_event_timeout(mhi_cntrl->state_event,
-			   mhi_read_reg_field(mhi_cntrl, base,
-					      BHIE_RXVECSTATUS_OFFS,
-					      BHIE_RXVECSTATUS_STATUS_BMSK,
-					      BHIE_RXVECSTATUS_STATUS_SHFT,
-					      &rx_status) || rx_status,
-			   msecs_to_jiffies(mhi_cntrl->timeout_ms));
-
-	return (rx_status == BHIE_RXVECSTATUS_STATUS_XFER_COMPL) ? 0 : -EIO;
-}
-EXPORT_SYMBOL_GPL(mhi_download_rddm_img);
-
-static int mhi_fw_load_amss(struct mhi_controller *mhi_cntrl,
-			    const struct mhi_buf *mhi_buf)
-{
-	void __iomem *base = mhi_cntrl->bhie;
-	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-	rwlock_t *pm_lock = &mhi_cntrl->pm_lock;
-	u32 tx_status, sequence_id;
-	int ret;
-
-	read_lock_bh(pm_lock);
-	if (!MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state)) {
-		read_unlock_bh(pm_lock);
-		return -EIO;
-	}
-
-	sequence_id = MHI_RANDOM_U32_NONZERO(BHIE_TXVECSTATUS_SEQNUM_BMSK);
-	dev_dbg(dev, "Starting AMSS download via BHIe. Sequence ID:%u\n",
-		sequence_id);
-	mhi_write_reg(mhi_cntrl, base, BHIE_TXVECADDR_HIGH_OFFS,
-		      upper_32_bits(mhi_buf->dma_addr));
-
-	mhi_write_reg(mhi_cntrl, base, BHIE_TXVECADDR_LOW_OFFS,
-		      lower_32_bits(mhi_buf->dma_addr));
-
-	mhi_write_reg(mhi_cntrl, base, BHIE_TXVECSIZE_OFFS, mhi_buf->len);
-
-	mhi_write_reg_field(mhi_cntrl, base, BHIE_TXVECDB_OFFS,
-			    BHIE_TXVECDB_SEQNUM_BMSK, BHIE_TXVECDB_SEQNUM_SHFT,
-			    sequence_id);
-	read_unlock_bh(pm_lock);
-
-	/* Wait for the image download to complete */
-	ret = wait_event_timeout(mhi_cntrl->state_event,
-				 MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state) ||
-				 mhi_read_reg_field(mhi_cntrl, base,
-						   BHIE_TXVECSTATUS_OFFS,
-						   BHIE_TXVECSTATUS_STATUS_BMSK,
-						   BHIE_TXVECSTATUS_STATUS_SHFT,
-						   &tx_status) || tx_status,
-				 msecs_to_jiffies(mhi_cntrl->timeout_ms));
-	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state) ||
-	    tx_status != BHIE_TXVECSTATUS_STATUS_XFER_COMPL)
-		return -EIO;
-
-	return (!ret) ? -ETIMEDOUT : 0;
-}
-
-static int mhi_fw_load_sbl(struct mhi_controller *mhi_cntrl,
-			   dma_addr_t dma_addr,
-			   size_t size)
-{
-	u32 tx_status, val, session_id;
-	int i, ret;
-	void __iomem *base = mhi_cntrl->bhi;
-	rwlock_t *pm_lock = &mhi_cntrl->pm_lock;
-	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-	struct {
-		char *name;
-		u32 offset;
-	} error_reg[] = {
-		{ "ERROR_CODE", BHI_ERRCODE },
-		{ "ERROR_DBG1", BHI_ERRDBG1 },
-		{ "ERROR_DBG2", BHI_ERRDBG2 },
-		{ "ERROR_DBG3", BHI_ERRDBG3 },
-		{ NULL },
-	};
-
-	read_lock_bh(pm_lock);
-	if (!MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state)) {
-		read_unlock_bh(pm_lock);
-		goto invalid_pm_state;
-	}
-
-	session_id = MHI_RANDOM_U32_NONZERO(BHI_TXDB_SEQNUM_BMSK);
-	dev_dbg(dev, "Starting SBL download via BHI. Session ID:%u\n",
-		session_id);
-	mhi_write_reg(mhi_cntrl, base, BHI_STATUS, 0);
-	mhi_write_reg(mhi_cntrl, base, BHI_IMGADDR_HIGH,
-		      upper_32_bits(dma_addr));
-	mhi_write_reg(mhi_cntrl, base, BHI_IMGADDR_LOW,
-		      lower_32_bits(dma_addr));
-	mhi_write_reg(mhi_cntrl, base, BHI_IMGSIZE, size);
-	mhi_write_reg(mhi_cntrl, base, BHI_IMGTXDB, session_id);
-	read_unlock_bh(pm_lock);
-
-	/* Wait for the image download to complete */
-	ret = wait_event_timeout(mhi_cntrl->state_event,
-			   MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state) ||
-			   mhi_read_reg_field(mhi_cntrl, base, BHI_STATUS,
-					      BHI_STATUS_MASK, BHI_STATUS_SHIFT,
-					      &tx_status) || tx_status,
-			   msecs_to_jiffies(mhi_cntrl->timeout_ms));
-	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state))
-		goto invalid_pm_state;
-
-	if (tx_status == BHI_STATUS_ERROR) {
-		dev_err(dev, "Image transfer failed\n");
-		read_lock_bh(pm_lock);
-		if (MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state)) {
-			for (i = 0; error_reg[i].name; i++) {
-				ret = mhi_read_reg(mhi_cntrl, base,
-						   error_reg[i].offset, &val);
-				if (ret)
-					break;
-				dev_err(dev, "Reg: %s value: 0x%x\n",
-					error_reg[i].name, val);
-			}
-		}
-		read_unlock_bh(pm_lock);
-		goto invalid_pm_state;
-	}
-
-	return (!ret) ? -ETIMEDOUT : 0;
-
-invalid_pm_state:
-
-	return -EIO;
-}
-
-void mhi_free_bhie_table(struct mhi_controller *mhi_cntrl,
-			 struct image_info *image_info)
-{
-	int i;
-	struct mhi_buf *mhi_buf = image_info->mhi_buf;
-
-	for (i = 0; i < image_info->entries; i++, mhi_buf++)
-		mhi_free_coherent(mhi_cntrl, mhi_buf->len, mhi_buf->buf,
-				  mhi_buf->dma_addr);
-
-	kfree(image_info->mhi_buf);
-	kfree(image_info);
-}
-
-int mhi_alloc_bhie_table(struct mhi_controller *mhi_cntrl,
-			 struct image_info **image_info,
-			 size_t alloc_size)
-{
-	size_t seg_size = mhi_cntrl->seg_len;
-	int segments = DIV_ROUND_UP(alloc_size, seg_size) + 1;
-	int i;
-	struct image_info *img_info;
-	struct mhi_buf *mhi_buf;
-
-	img_info = kzalloc(sizeof(*img_info), GFP_KERNEL);
-	if (!img_info)
-		return -ENOMEM;
-
-	/* Allocate memory for entries */
-	img_info->mhi_buf = kcalloc(segments, sizeof(*img_info->mhi_buf),
-				    GFP_KERNEL);
-	if (!img_info->mhi_buf)
-		goto error_alloc_mhi_buf;
-
-	/* Allocate and populate vector table */
-	mhi_buf = img_info->mhi_buf;
-	for (i = 0; i < segments; i++, mhi_buf++) {
-		size_t vec_size = seg_size;
-
-		/* Vector table is the last entry */
-		if (i == segments - 1)
-			vec_size = sizeof(struct bhi_vec_entry) * i;
-
-		mhi_buf->len = vec_size;
-		mhi_buf->buf = mhi_alloc_coherent(mhi_cntrl, vec_size,
-						  &mhi_buf->dma_addr,
-						  GFP_KERNEL);
-		if (!mhi_buf->buf)
-			goto error_alloc_segment;
-	}
-
-	img_info->bhi_vec = img_info->mhi_buf[segments - 1].buf;
-	img_info->entries = segments;
-	*image_info = img_info;
-
-	return 0;
-
-error_alloc_segment:
-	for (--i, --mhi_buf; i >= 0; i--, mhi_buf--)
-		mhi_free_coherent(mhi_cntrl, mhi_buf->len, mhi_buf->buf,
-				  mhi_buf->dma_addr);
-
-error_alloc_mhi_buf:
-	kfree(img_info);
-
-	return -ENOMEM;
-}
-
-static void mhi_firmware_copy(struct mhi_controller *mhi_cntrl,
-			      const struct firmware *firmware,
-			      struct image_info *img_info)
-{
-	size_t remainder = firmware->size;
-	size_t to_cpy;
-	const u8 *buf = firmware->data;
-	int i = 0;
-	struct mhi_buf *mhi_buf = img_info->mhi_buf;
-	struct bhi_vec_entry *bhi_vec = img_info->bhi_vec;
-
-	while (remainder) {
-		to_cpy = min(remainder, mhi_buf->len);
-		memcpy(mhi_buf->buf, buf, to_cpy);
-		bhi_vec->dma_addr = mhi_buf->dma_addr;
-		bhi_vec->size = to_cpy;
-
-		buf += to_cpy;
-		remainder -= to_cpy;
-		i++;
-		bhi_vec++;
-		mhi_buf++;
-	}
-}
-
-void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
-{
-	const struct firmware *firmware = NULL;
-	struct image_info *image_info;
-	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-	const char *fw_name;
-	void *buf;
-	dma_addr_t dma_addr;
-	size_t size;
-	int i, ret;
-
-	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
-		dev_err(dev, "Device MHI is not in valid state\n");
-		return;
-	}
-
-	/* save hardware info from BHI */
-	ret = mhi_read_reg(mhi_cntrl, mhi_cntrl->bhi, BHI_SERIALNU,
-			   &mhi_cntrl->serial_number);
-	if (ret)
-		dev_err(dev, "Could not capture serial number via BHI\n");
-
-	for (i = 0; i < ARRAY_SIZE(mhi_cntrl->oem_pk_hash); i++) {
-		ret = mhi_read_reg(mhi_cntrl, mhi_cntrl->bhi, BHI_OEMPKHASH(i),
-				   &mhi_cntrl->oem_pk_hash[i]);
-		if (ret) {
-			dev_err(dev, "Could not capture OEM PK HASH via BHI\n");
-			break;
-		}
-	}
-
-	/* If device is in pass through, do reset to ready state transition */
-	if (mhi_cntrl->ee == MHI_EE_PTHRU)
-		goto fw_load_ee_pthru;
-
-	fw_name = (mhi_cntrl->ee == MHI_EE_EDL) ?
-		mhi_cntrl->edl_image : mhi_cntrl->fw_image;
-
-	if (!fw_name || (mhi_cntrl->fbc_download && (!mhi_cntrl->sbl_size ||
-						     !mhi_cntrl->seg_len))) {
-		dev_err(dev,
-			"No firmware image defined or !sbl_size || !seg_len\n");
-		return;
-	}
-
-	ret = request_firmware(&firmware, fw_name, dev);
-	if (ret) {
-		dev_err(dev, "Error loading firmware: %d\n", ret);
-		return;
-	}
-
-	size = (mhi_cntrl->fbc_download) ? mhi_cntrl->sbl_size : firmware->size;
-
-	/* SBL size provided is maximum size, not necessarily the image size */
-	if (size > firmware->size)
-		size = firmware->size;
-
-	buf = mhi_alloc_coherent(mhi_cntrl, size, &dma_addr, GFP_KERNEL);
-	if (!buf) {
-		release_firmware(firmware);
-		return;
-	}
-
-	/* Download SBL image */
-	memcpy(buf, firmware->data, size);
-	ret = mhi_fw_load_sbl(mhi_cntrl, dma_addr, size);
-	mhi_free_coherent(mhi_cntrl, size, buf, dma_addr);
-
-	if (!mhi_cntrl->fbc_download || ret || mhi_cntrl->ee == MHI_EE_EDL)
-		release_firmware(firmware);
-
-	/* Error or in EDL mode, we're done */
-	if (ret) {
-		dev_err(dev, "MHI did not load SBL, ret:%d\n", ret);
-		return;
-	}
-
-	if (mhi_cntrl->ee == MHI_EE_EDL)
-		return;
-
-	write_lock_irq(&mhi_cntrl->pm_lock);
-	mhi_cntrl->dev_state = MHI_STATE_RESET;
-	write_unlock_irq(&mhi_cntrl->pm_lock);
-
-	/*
-	 * If we're doing fbc, populate vector tables while
-	 * device transitioning into MHI READY state
-	 */
-	if (mhi_cntrl->fbc_download) {
-		ret = mhi_alloc_bhie_table(mhi_cntrl, &mhi_cntrl->fbc_image,
-					   firmware->size);
-		if (ret)
-			goto error_alloc_fw_table;
-
-		/* Load the firmware into BHIE vec table */
-		mhi_firmware_copy(mhi_cntrl, firmware, mhi_cntrl->fbc_image);
-	}
-
-fw_load_ee_pthru:
-	/* Transitioning into MHI RESET->READY state */
-	ret = mhi_ready_state_transition(mhi_cntrl);
-
-	if (!mhi_cntrl->fbc_download)
-		return;
-
-	if (ret) {
-		dev_err(dev, "MHI did not enter READY state\n");
-		goto error_read;
-	}
-
-	/* Wait for the SBL event */
-	ret = wait_event_timeout(mhi_cntrl->state_event,
-				 mhi_cntrl->ee == MHI_EE_SBL ||
-				 MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state),
-				 msecs_to_jiffies(mhi_cntrl->timeout_ms));
-
-	if (!ret || MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
-		dev_err(dev, "MHI did not enter SBL\n");
-		goto error_read;
-	}
-
-	/* Start full firmware image download */
-	image_info = mhi_cntrl->fbc_image;
-	ret = mhi_fw_load_amss(mhi_cntrl,
-			       /* Vector table is the last entry */
-			       &image_info->mhi_buf[image_info->entries - 1]);
-	if (ret)
-		dev_err(dev, "MHI did not load AMSS, ret:%d\n", ret);
-
-	release_firmware(firmware);
-
-	return;
-
-error_read:
-	mhi_free_bhie_table(mhi_cntrl, mhi_cntrl->fbc_image);
-	mhi_cntrl->fbc_image = NULL;
-
-error_alloc_fw_table:
-	release_firmware(firmware);
-}
diff --git a/drivers/bus/mhi/core/debugfs.c b/drivers/bus/mhi/core/debugfs.c
deleted file mode 100644
index 3a48801e01f4..000000000000
--- a/drivers/bus/mhi/core/debugfs.c
+++ /dev/null
@@ -1,411 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (c) 2020, The Linux Foundation. All rights reserved.
- *
- */
-
-#include <linux/debugfs.h>
-#include <linux/device.h>
-#include <linux/interrupt.h>
-#include <linux/list.h>
-#include <linux/mhi.h>
-#include <linux/module.h>
-#include "internal.h"
-
-static int mhi_debugfs_states_show(struct seq_file *m, void *d)
-{
-	struct mhi_controller *mhi_cntrl = m->private;
-
-	/* states */
-	seq_printf(m, "PM state: %s Device: %s MHI state: %s EE: %s wake: %s\n",
-		   to_mhi_pm_state_str(mhi_cntrl->pm_state),
-		   mhi_is_active(mhi_cntrl) ? "Active" : "Inactive",
-		   TO_MHI_STATE_STR(mhi_cntrl->dev_state),
-		   TO_MHI_EXEC_STR(mhi_cntrl->ee),
-		   mhi_cntrl->wake_set ? "true" : "false");
-
-	/* counters */
-	seq_printf(m, "M0: %u M2: %u M3: %u", mhi_cntrl->M0, mhi_cntrl->M2,
-		   mhi_cntrl->M3);
-
-	seq_printf(m, " device wake: %u pending packets: %u\n",
-		   atomic_read(&mhi_cntrl->dev_wake),
-		   atomic_read(&mhi_cntrl->pending_pkts));
-
-	return 0;
-}
-
-static int mhi_debugfs_events_show(struct seq_file *m, void *d)
-{
-	struct mhi_controller *mhi_cntrl = m->private;
-	struct mhi_event *mhi_event;
-	struct mhi_event_ctxt *er_ctxt;
-	int i;
-
-	if (!mhi_is_active(mhi_cntrl)) {
-		seq_puts(m, "Device not ready\n");
-		return -ENODEV;
-	}
-
-	er_ctxt = mhi_cntrl->mhi_ctxt->er_ctxt;
-	mhi_event = mhi_cntrl->mhi_event;
-	for (i = 0; i < mhi_cntrl->total_ev_rings;
-						i++, er_ctxt++, mhi_event++) {
-		struct mhi_ring *ring = &mhi_event->ring;
-
-		if (mhi_event->offload_ev) {
-			seq_printf(m, "Index: %d is an offload event ring\n",
-				   i);
-			continue;
-		}
-
-		seq_printf(m, "Index: %d intmod count: %lu time: %lu",
-			   i, (er_ctxt->intmod & EV_CTX_INTMODC_MASK) >>
-			   EV_CTX_INTMODC_SHIFT,
-			   (er_ctxt->intmod & EV_CTX_INTMODT_MASK) >>
-			   EV_CTX_INTMODT_SHIFT);
-
-		seq_printf(m, " base: 0x%0llx len: 0x%llx", er_ctxt->rbase,
-			   er_ctxt->rlen);
-
-		seq_printf(m, " rp: 0x%llx wp: 0x%llx", er_ctxt->rp,
-			   er_ctxt->wp);
-
-		seq_printf(m, " local rp: 0x%pK db: 0x%pad\n", ring->rp,
-			   &mhi_event->db_cfg.db_val);
-	}
-
-	return 0;
-}
-
-static int mhi_debugfs_channels_show(struct seq_file *m, void *d)
-{
-	struct mhi_controller *mhi_cntrl = m->private;
-	struct mhi_chan *mhi_chan;
-	struct mhi_chan_ctxt *chan_ctxt;
-	int i;
-
-	if (!mhi_is_active(mhi_cntrl)) {
-		seq_puts(m, "Device not ready\n");
-		return -ENODEV;
-	}
-
-	mhi_chan = mhi_cntrl->mhi_chan;
-	chan_ctxt = mhi_cntrl->mhi_ctxt->chan_ctxt;
-	for (i = 0; i < mhi_cntrl->max_chan; i++, chan_ctxt++, mhi_chan++) {
-		struct mhi_ring *ring = &mhi_chan->tre_ring;
-
-		if (mhi_chan->offload_ch) {
-			seq_printf(m, "%s(%u) is an offload channel\n",
-				   mhi_chan->name, mhi_chan->chan);
-			continue;
-		}
-
-		if (!mhi_chan->mhi_dev)
-			continue;
-
-		seq_printf(m,
-			   "%s(%u) state: 0x%lx brstmode: 0x%lx pollcfg: 0x%lx",
-			   mhi_chan->name, mhi_chan->chan, (chan_ctxt->chcfg &
-			   CHAN_CTX_CHSTATE_MASK) >> CHAN_CTX_CHSTATE_SHIFT,
-			   (chan_ctxt->chcfg & CHAN_CTX_BRSTMODE_MASK) >>
-			   CHAN_CTX_BRSTMODE_SHIFT, (chan_ctxt->chcfg &
-			   CHAN_CTX_POLLCFG_MASK) >> CHAN_CTX_POLLCFG_SHIFT);
-
-		seq_printf(m, " type: 0x%x event ring: %u", chan_ctxt->chtype,
-			   chan_ctxt->erindex);
-
-		seq_printf(m, " base: 0x%llx len: 0x%llx rp: 0x%llx wp: 0x%llx",
-			   chan_ctxt->rbase, chan_ctxt->rlen, chan_ctxt->rp,
-			   chan_ctxt->wp);
-
-		seq_printf(m, " local rp: 0x%pK local wp: 0x%pK db: 0x%pad\n",
-			   ring->rp, ring->wp,
-			   &mhi_chan->db_cfg.db_val);
-	}
-
-	return 0;
-}
-
-static int mhi_device_info_show(struct device *dev, void *data)
-{
-	struct mhi_device *mhi_dev;
-
-	if (dev->bus != &mhi_bus_type)
-		return 0;
-
-	mhi_dev = to_mhi_device(dev);
-
-	seq_printf((struct seq_file *)data, "%s: type: %s dev_wake: %u",
-		   mhi_dev->name, mhi_dev->dev_type ? "Controller" : "Transfer",
-		   mhi_dev->dev_wake);
-
-	/* for transfer device types only */
-	if (mhi_dev->dev_type == MHI_DEVICE_XFER)
-		seq_printf((struct seq_file *)data, " channels: %u(UL)/%u(DL)",
-			   mhi_dev->ul_chan_id, mhi_dev->dl_chan_id);
-
-	seq_puts((struct seq_file *)data, "\n");
-
-	return 0;
-}
-
-static int mhi_debugfs_devices_show(struct seq_file *m, void *d)
-{
-	struct mhi_controller *mhi_cntrl = m->private;
-
-	if (!mhi_is_active(mhi_cntrl)) {
-		seq_puts(m, "Device not ready\n");
-		return -ENODEV;
-	}
-
-	device_for_each_child(mhi_cntrl->cntrl_dev, m, mhi_device_info_show);
-
-	return 0;
-}
-
-static int mhi_debugfs_regdump_show(struct seq_file *m, void *d)
-{
-	struct mhi_controller *mhi_cntrl = m->private;
-	enum mhi_state state;
-	enum mhi_ee_type ee;
-	int i, ret = -EIO;
-	u32 val;
-	void __iomem *mhi_base = mhi_cntrl->regs;
-	void __iomem *bhi_base = mhi_cntrl->bhi;
-	void __iomem *bhie_base = mhi_cntrl->bhie;
-	void __iomem *wake_db = mhi_cntrl->wake_db;
-	struct {
-		const char *name;
-		int offset;
-		void __iomem *base;
-	} regs[] = {
-		{ "MHI_REGLEN", MHIREGLEN, mhi_base},
-		{ "MHI_VER", MHIVER, mhi_base},
-		{ "MHI_CFG", MHICFG, mhi_base},
-		{ "MHI_CTRL", MHICTRL, mhi_base},
-		{ "MHI_STATUS", MHISTATUS, mhi_base},
-		{ "MHI_WAKE_DB", 0, wake_db},
-		{ "BHI_EXECENV", BHI_EXECENV, bhi_base},
-		{ "BHI_STATUS", BHI_STATUS, bhi_base},
-		{ "BHI_ERRCODE", BHI_ERRCODE, bhi_base},
-		{ "BHI_ERRDBG1", BHI_ERRDBG1, bhi_base},
-		{ "BHI_ERRDBG2", BHI_ERRDBG2, bhi_base},
-		{ "BHI_ERRDBG3", BHI_ERRDBG3, bhi_base},
-		{ "BHIE_TXVEC_DB", BHIE_TXVECDB_OFFS, bhie_base},
-		{ "BHIE_TXVEC_STATUS", BHIE_TXVECSTATUS_OFFS, bhie_base},
-		{ "BHIE_RXVEC_DB", BHIE_RXVECDB_OFFS, bhie_base},
-		{ "BHIE_RXVEC_STATUS", BHIE_RXVECSTATUS_OFFS, bhie_base},
-		{ NULL },
-	};
-
-	if (!MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state))
-		return ret;
-
-	seq_printf(m, "Host PM state: %s Device state: %s EE: %s\n",
-		   to_mhi_pm_state_str(mhi_cntrl->pm_state),
-		   TO_MHI_STATE_STR(mhi_cntrl->dev_state),
-		   TO_MHI_EXEC_STR(mhi_cntrl->ee));
-
-	state = mhi_get_mhi_state(mhi_cntrl);
-	ee = mhi_get_exec_env(mhi_cntrl);
-	seq_printf(m, "Device EE: %s state: %s\n", TO_MHI_EXEC_STR(ee),
-		   TO_MHI_STATE_STR(state));
-
-	for (i = 0; regs[i].name; i++) {
-		if (!regs[i].base)
-			continue;
-		ret = mhi_read_reg(mhi_cntrl, regs[i].base, regs[i].offset,
-				   &val);
-		if (ret)
-			continue;
-
-		seq_printf(m, "%s: 0x%x\n", regs[i].name, val);
-	}
-
-	return 0;
-}
-
-static int mhi_debugfs_device_wake_show(struct seq_file *m, void *d)
-{
-	struct mhi_controller *mhi_cntrl = m->private;
-	struct mhi_device *mhi_dev = mhi_cntrl->mhi_dev;
-
-	if (!mhi_is_active(mhi_cntrl)) {
-		seq_puts(m, "Device not ready\n");
-		return -ENODEV;
-	}
-
-	seq_printf(m,
-		   "Wake count: %d\n%s\n", mhi_dev->dev_wake,
-		   "Usage: echo get/put > device_wake to vote/unvote for M0");
-
-	return 0;
-}
-
-static ssize_t mhi_debugfs_device_wake_write(struct file *file,
-					     const char __user *ubuf,
-					     size_t count, loff_t *ppos)
-{
-	struct seq_file	*m = file->private_data;
-	struct mhi_controller *mhi_cntrl = m->private;
-	struct mhi_device *mhi_dev = mhi_cntrl->mhi_dev;
-	char buf[16];
-	int ret = -EINVAL;
-
-	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
-		return -EFAULT;
-
-	if (!strncmp(buf, "get", 3)) {
-		ret = mhi_device_get_sync(mhi_dev);
-	} else if (!strncmp(buf, "put", 3)) {
-		mhi_device_put(mhi_dev);
-		ret = 0;
-	}
-
-	return ret ? ret : count;
-}
-
-static int mhi_debugfs_timeout_ms_show(struct seq_file *m, void *d)
-{
-	struct mhi_controller *mhi_cntrl = m->private;
-
-	seq_printf(m, "%u ms\n", mhi_cntrl->timeout_ms);
-
-	return 0;
-}
-
-static ssize_t mhi_debugfs_timeout_ms_write(struct file *file,
-					    const char __user *ubuf,
-					    size_t count, loff_t *ppos)
-{
-	struct seq_file	*m = file->private_data;
-	struct mhi_controller *mhi_cntrl = m->private;
-	u32 timeout_ms;
-
-	if (kstrtou32_from_user(ubuf, count, 0, &timeout_ms))
-		return -EINVAL;
-
-	mhi_cntrl->timeout_ms = timeout_ms;
-
-	return count;
-}
-
-static int mhi_debugfs_states_open(struct inode *inode, struct file *fp)
-{
-	return single_open(fp, mhi_debugfs_states_show, inode->i_private);
-}
-
-static int mhi_debugfs_events_open(struct inode *inode, struct file *fp)
-{
-	return single_open(fp, mhi_debugfs_events_show, inode->i_private);
-}
-
-static int mhi_debugfs_channels_open(struct inode *inode, struct file *fp)
-{
-	return single_open(fp, mhi_debugfs_channels_show, inode->i_private);
-}
-
-static int mhi_debugfs_devices_open(struct inode *inode, struct file *fp)
-{
-	return single_open(fp, mhi_debugfs_devices_show, inode->i_private);
-}
-
-static int mhi_debugfs_regdump_open(struct inode *inode, struct file *fp)
-{
-	return single_open(fp, mhi_debugfs_regdump_show, inode->i_private);
-}
-
-static int mhi_debugfs_device_wake_open(struct inode *inode, struct file *fp)
-{
-	return single_open(fp, mhi_debugfs_device_wake_show, inode->i_private);
-}
-
-static int mhi_debugfs_timeout_ms_open(struct inode *inode, struct file *fp)
-{
-	return single_open(fp, mhi_debugfs_timeout_ms_show, inode->i_private);
-}
-
-static const struct file_operations debugfs_states_fops = {
-	.open = mhi_debugfs_states_open,
-	.release = single_release,
-	.read = seq_read,
-};
-
-static const struct file_operations debugfs_events_fops = {
-	.open = mhi_debugfs_events_open,
-	.release = single_release,
-	.read = seq_read,
-};
-
-static const struct file_operations debugfs_channels_fops = {
-	.open = mhi_debugfs_channels_open,
-	.release = single_release,
-	.read = seq_read,
-};
-
-static const struct file_operations debugfs_devices_fops = {
-	.open = mhi_debugfs_devices_open,
-	.release = single_release,
-	.read = seq_read,
-};
-
-static const struct file_operations debugfs_regdump_fops = {
-	.open = mhi_debugfs_regdump_open,
-	.release = single_release,
-	.read = seq_read,
-};
-
-static const struct file_operations debugfs_device_wake_fops = {
-	.open = mhi_debugfs_device_wake_open,
-	.write = mhi_debugfs_device_wake_write,
-	.release = single_release,
-	.read = seq_read,
-};
-
-static const struct file_operations debugfs_timeout_ms_fops = {
-	.open = mhi_debugfs_timeout_ms_open,
-	.write = mhi_debugfs_timeout_ms_write,
-	.release = single_release,
-	.read = seq_read,
-};
-
-static struct dentry *mhi_debugfs_root;
-
-void mhi_create_debugfs(struct mhi_controller *mhi_cntrl)
-{
-	mhi_cntrl->debugfs_dentry =
-			debugfs_create_dir(dev_name(mhi_cntrl->cntrl_dev),
-					   mhi_debugfs_root);
-
-	debugfs_create_file("states", 0444, mhi_cntrl->debugfs_dentry,
-			    mhi_cntrl, &debugfs_states_fops);
-	debugfs_create_file("events", 0444, mhi_cntrl->debugfs_dentry,
-			    mhi_cntrl, &debugfs_events_fops);
-	debugfs_create_file("channels", 0444, mhi_cntrl->debugfs_dentry,
-			    mhi_cntrl, &debugfs_channels_fops);
-	debugfs_create_file("devices", 0444, mhi_cntrl->debugfs_dentry,
-			    mhi_cntrl, &debugfs_devices_fops);
-	debugfs_create_file("regdump", 0444, mhi_cntrl->debugfs_dentry,
-			    mhi_cntrl, &debugfs_regdump_fops);
-	debugfs_create_file("device_wake", 0644, mhi_cntrl->debugfs_dentry,
-			    mhi_cntrl, &debugfs_device_wake_fops);
-	debugfs_create_file("timeout_ms", 0644, mhi_cntrl->debugfs_dentry,
-			    mhi_cntrl, &debugfs_timeout_ms_fops);
-}
-
-void mhi_destroy_debugfs(struct mhi_controller *mhi_cntrl)
-{
-	debugfs_remove_recursive(mhi_cntrl->debugfs_dentry);
-	mhi_cntrl->debugfs_dentry = NULL;
-}
-
-void mhi_debugfs_init(void)
-{
-	mhi_debugfs_root = debugfs_create_dir(mhi_bus_type.name, NULL);
-}
-
-void mhi_debugfs_exit(void)
-{
-	debugfs_remove_recursive(mhi_debugfs_root);
-}
diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
deleted file mode 100644
index 0d0386f67ffe..000000000000
--- a/drivers/bus/mhi/core/init.c
+++ /dev/null
@@ -1,1375 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (c) 2018-2020, The Linux Foundation. All rights reserved.
- *
- */
-
-#include <linux/debugfs.h>
-#include <linux/device.h>
-#include <linux/dma-direction.h>
-#include <linux/dma-mapping.h>
-#include <linux/interrupt.h>
-#include <linux/list.h>
-#include <linux/mhi.h>
-#include <linux/mod_devicetable.h>
-#include <linux/module.h>
-#include <linux/slab.h>
-#include <linux/vmalloc.h>
-#include <linux/wait.h>
-#include "internal.h"
-
-const char * const mhi_ee_str[MHI_EE_MAX] = {
-	[MHI_EE_PBL] = "PBL",
-	[MHI_EE_SBL] = "SBL",
-	[MHI_EE_AMSS] = "AMSS",
-	[MHI_EE_RDDM] = "RDDM",
-	[MHI_EE_WFW] = "WFW",
-	[MHI_EE_PTHRU] = "PASS THRU",
-	[MHI_EE_EDL] = "EDL",
-	[MHI_EE_DISABLE_TRANSITION] = "DISABLE",
-	[MHI_EE_NOT_SUPPORTED] = "NOT SUPPORTED",
-};
-
-const char * const dev_state_tran_str[DEV_ST_TRANSITION_MAX] = {
-	[DEV_ST_TRANSITION_PBL] = "PBL",
-	[DEV_ST_TRANSITION_READY] = "READY",
-	[DEV_ST_TRANSITION_SBL] = "SBL",
-	[DEV_ST_TRANSITION_MISSION_MODE] = "MISSION_MODE",
-	[DEV_ST_TRANSITION_SYS_ERR] = "SYS_ERR",
-	[DEV_ST_TRANSITION_DISABLE] = "DISABLE",
-};
-
-const char * const mhi_state_str[MHI_STATE_MAX] = {
-	[MHI_STATE_RESET] = "RESET",
-	[MHI_STATE_READY] = "READY",
-	[MHI_STATE_M0] = "M0",
-	[MHI_STATE_M1] = "M1",
-	[MHI_STATE_M2] = "M2",
-	[MHI_STATE_M3] = "M3",
-	[MHI_STATE_M3_FAST] = "M3_FAST",
-	[MHI_STATE_BHI] = "BHI",
-	[MHI_STATE_SYS_ERR] = "SYS_ERR",
-};
-
-static const char * const mhi_pm_state_str[] = {
-	[MHI_PM_STATE_DISABLE] = "DISABLE",
-	[MHI_PM_STATE_POR] = "POR",
-	[MHI_PM_STATE_M0] = "M0",
-	[MHI_PM_STATE_M2] = "M2",
-	[MHI_PM_STATE_M3_ENTER] = "M?->M3",
-	[MHI_PM_STATE_M3] = "M3",
-	[MHI_PM_STATE_M3_EXIT] = "M3->M0",
-	[MHI_PM_STATE_FW_DL_ERR] = "FW DL Error",
-	[MHI_PM_STATE_SYS_ERR_DETECT] = "SYS_ERR Detect",
-	[MHI_PM_STATE_SYS_ERR_PROCESS] = "SYS_ERR Process",
-	[MHI_PM_STATE_SHUTDOWN_PROCESS] = "SHUTDOWN Process",
-	[MHI_PM_STATE_LD_ERR_FATAL_DETECT] = "LD or Error Fatal Detect",
-};
-
-const char *to_mhi_pm_state_str(enum mhi_pm_state state)
-{
-	int index = find_last_bit((unsigned long *)&state, 32);
-
-	if (index >= ARRAY_SIZE(mhi_pm_state_str))
-		return "Invalid State";
-
-	return mhi_pm_state_str[index];
-}
-
-static ssize_t serial_number_show(struct device *dev,
-				  struct device_attribute *attr,
-				  char *buf)
-{
-	struct mhi_device *mhi_dev = to_mhi_device(dev);
-	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
-
-	return snprintf(buf, PAGE_SIZE, "Serial Number: %u\n",
-			mhi_cntrl->serial_number);
-}
-static DEVICE_ATTR_RO(serial_number);
-
-static ssize_t oem_pk_hash_show(struct device *dev,
-				struct device_attribute *attr,
-				char *buf)
-{
-	struct mhi_device *mhi_dev = to_mhi_device(dev);
-	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
-	int i, cnt = 0;
-
-	for (i = 0; i < ARRAY_SIZE(mhi_cntrl->oem_pk_hash); i++)
-		cnt += snprintf(buf + cnt, PAGE_SIZE - cnt,
-				"OEMPKHASH[%d]: 0x%x\n", i,
-				mhi_cntrl->oem_pk_hash[i]);
-
-	return cnt;
-}
-static DEVICE_ATTR_RO(oem_pk_hash);
-
-static struct attribute *mhi_dev_attrs[] = {
-	&dev_attr_serial_number.attr,
-	&dev_attr_oem_pk_hash.attr,
-	NULL,
-};
-ATTRIBUTE_GROUPS(mhi_dev);
-
-/* MHI protocol requires the transfer ring to be aligned with ring length */
-static int mhi_alloc_aligned_ring(struct mhi_controller *mhi_cntrl,
-				  struct mhi_ring *ring,
-				  u64 len)
-{
-	ring->alloc_size = len + (len - 1);
-	ring->pre_aligned = mhi_alloc_coherent(mhi_cntrl, ring->alloc_size,
-					       &ring->dma_handle, GFP_KERNEL);
-	if (!ring->pre_aligned)
-		return -ENOMEM;
-
-	ring->iommu_base = (ring->dma_handle + (len - 1)) & ~(len - 1);
-	ring->base = ring->pre_aligned + (ring->iommu_base - ring->dma_handle);
-
-	return 0;
-}
-
-void mhi_deinit_free_irq(struct mhi_controller *mhi_cntrl)
-{
-	int i;
-	struct mhi_event *mhi_event = mhi_cntrl->mhi_event;
-
-	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
-		if (mhi_event->offload_ev)
-			continue;
-
-		free_irq(mhi_cntrl->irq[mhi_event->irq], mhi_event);
-	}
-
-	free_irq(mhi_cntrl->irq[0], mhi_cntrl);
-}
-
-int mhi_init_irq_setup(struct mhi_controller *mhi_cntrl)
-{
-	struct mhi_event *mhi_event = mhi_cntrl->mhi_event;
-	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-	int i, ret;
-
-	/* Setup BHI_INTVEC IRQ */
-	ret = request_threaded_irq(mhi_cntrl->irq[0], mhi_intvec_handler,
-				   mhi_intvec_threaded_handler,
-				   IRQF_SHARED | IRQF_NO_SUSPEND,
-				   "bhi", mhi_cntrl);
-	if (ret)
-		return ret;
-
-	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
-		if (mhi_event->offload_ev)
-			continue;
-
-		if (mhi_event->irq >= mhi_cntrl->nr_irqs) {
-			dev_err(dev, "irq %d not available for event ring\n",
-				mhi_event->irq);
-			ret = -EINVAL;
-			goto error_request;
-		}
-
-		ret = request_irq(mhi_cntrl->irq[mhi_event->irq],
-				  mhi_irq_handler,
-				  IRQF_SHARED | IRQF_NO_SUSPEND,
-				  "mhi", mhi_event);
-		if (ret) {
-			dev_err(dev, "Error requesting irq:%d for ev:%d\n",
-				mhi_cntrl->irq[mhi_event->irq], i);
-			goto error_request;
-		}
-	}
-
-	return 0;
-
-error_request:
-	for (--i, --mhi_event; i >= 0; i--, mhi_event--) {
-		if (mhi_event->offload_ev)
-			continue;
-
-		free_irq(mhi_cntrl->irq[mhi_event->irq], mhi_event);
-	}
-	free_irq(mhi_cntrl->irq[0], mhi_cntrl);
-
-	return ret;
-}
-
-void mhi_deinit_dev_ctxt(struct mhi_controller *mhi_cntrl)
-{
-	int i;
-	struct mhi_ctxt *mhi_ctxt = mhi_cntrl->mhi_ctxt;
-	struct mhi_cmd *mhi_cmd;
-	struct mhi_event *mhi_event;
-	struct mhi_ring *ring;
-
-	mhi_cmd = mhi_cntrl->mhi_cmd;
-	for (i = 0; i < NR_OF_CMD_RINGS; i++, mhi_cmd++) {
-		ring = &mhi_cmd->ring;
-		mhi_free_coherent(mhi_cntrl, ring->alloc_size,
-				  ring->pre_aligned, ring->dma_handle);
-		ring->base = NULL;
-		ring->iommu_base = 0;
-	}
-
-	mhi_free_coherent(mhi_cntrl,
-			  sizeof(*mhi_ctxt->cmd_ctxt) * NR_OF_CMD_RINGS,
-			  mhi_ctxt->cmd_ctxt, mhi_ctxt->cmd_ctxt_addr);
-
-	mhi_event = mhi_cntrl->mhi_event;
-	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
-		if (mhi_event->offload_ev)
-			continue;
-
-		ring = &mhi_event->ring;
-		mhi_free_coherent(mhi_cntrl, ring->alloc_size,
-				  ring->pre_aligned, ring->dma_handle);
-		ring->base = NULL;
-		ring->iommu_base = 0;
-	}
-
-	mhi_free_coherent(mhi_cntrl, sizeof(*mhi_ctxt->er_ctxt) *
-			  mhi_cntrl->total_ev_rings, mhi_ctxt->er_ctxt,
-			  mhi_ctxt->er_ctxt_addr);
-
-	mhi_free_coherent(mhi_cntrl, sizeof(*mhi_ctxt->chan_ctxt) *
-			  mhi_cntrl->max_chan, mhi_ctxt->chan_ctxt,
-			  mhi_ctxt->chan_ctxt_addr);
-
-	kfree(mhi_ctxt);
-	mhi_cntrl->mhi_ctxt = NULL;
-}
-
-int mhi_init_dev_ctxt(struct mhi_controller *mhi_cntrl)
-{
-	struct mhi_ctxt *mhi_ctxt;
-	struct mhi_chan_ctxt *chan_ctxt;
-	struct mhi_event_ctxt *er_ctxt;
-	struct mhi_cmd_ctxt *cmd_ctxt;
-	struct mhi_chan *mhi_chan;
-	struct mhi_event *mhi_event;
-	struct mhi_cmd *mhi_cmd;
-	u32 tmp;
-	int ret = -ENOMEM, i;
-
-	atomic_set(&mhi_cntrl->dev_wake, 0);
-	atomic_set(&mhi_cntrl->pending_pkts, 0);
-
-	mhi_ctxt = kzalloc(sizeof(*mhi_ctxt), GFP_KERNEL);
-	if (!mhi_ctxt)
-		return -ENOMEM;
-
-	/* Setup channel ctxt */
-	mhi_ctxt->chan_ctxt = mhi_alloc_coherent(mhi_cntrl,
-						 sizeof(*mhi_ctxt->chan_ctxt) *
-						 mhi_cntrl->max_chan,
-						 &mhi_ctxt->chan_ctxt_addr,
-						 GFP_KERNEL);
-	if (!mhi_ctxt->chan_ctxt)
-		goto error_alloc_chan_ctxt;
-
-	mhi_chan = mhi_cntrl->mhi_chan;
-	chan_ctxt = mhi_ctxt->chan_ctxt;
-	for (i = 0; i < mhi_cntrl->max_chan; i++, chan_ctxt++, mhi_chan++) {
-		/* Skip if it is an offload channel */
-		if (mhi_chan->offload_ch)
-			continue;
-
-		tmp = chan_ctxt->chcfg;
-		tmp &= ~CHAN_CTX_CHSTATE_MASK;
-		tmp |= (MHI_CH_STATE_DISABLED << CHAN_CTX_CHSTATE_SHIFT);
-		tmp &= ~CHAN_CTX_BRSTMODE_MASK;
-		tmp |= (mhi_chan->db_cfg.brstmode << CHAN_CTX_BRSTMODE_SHIFT);
-		tmp &= ~CHAN_CTX_POLLCFG_MASK;
-		tmp |= (mhi_chan->db_cfg.pollcfg << CHAN_CTX_POLLCFG_SHIFT);
-		chan_ctxt->chcfg = tmp;
-
-		chan_ctxt->chtype = mhi_chan->type;
-		chan_ctxt->erindex = mhi_chan->er_index;
-
-		mhi_chan->ch_state = MHI_CH_STATE_DISABLED;
-		mhi_chan->tre_ring.db_addr = (void __iomem *)&chan_ctxt->wp;
-	}
-
-	/* Setup event context */
-	mhi_ctxt->er_ctxt = mhi_alloc_coherent(mhi_cntrl,
-					       sizeof(*mhi_ctxt->er_ctxt) *
-					       mhi_cntrl->total_ev_rings,
-					       &mhi_ctxt->er_ctxt_addr,
-					       GFP_KERNEL);
-	if (!mhi_ctxt->er_ctxt)
-		goto error_alloc_er_ctxt;
-
-	er_ctxt = mhi_ctxt->er_ctxt;
-	mhi_event = mhi_cntrl->mhi_event;
-	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, er_ctxt++,
-		     mhi_event++) {
-		struct mhi_ring *ring = &mhi_event->ring;
-
-		/* Skip if it is an offload event */
-		if (mhi_event->offload_ev)
-			continue;
-
-		tmp = er_ctxt->intmod;
-		tmp &= ~EV_CTX_INTMODC_MASK;
-		tmp &= ~EV_CTX_INTMODT_MASK;
-		tmp |= (mhi_event->intmod << EV_CTX_INTMODT_SHIFT);
-		er_ctxt->intmod = tmp;
-
-		er_ctxt->ertype = MHI_ER_TYPE_VALID;
-		er_ctxt->msivec = mhi_event->irq;
-		mhi_event->db_cfg.db_mode = true;
-
-		ring->el_size = sizeof(struct mhi_tre);
-		ring->len = ring->el_size * ring->elements;
-		ret = mhi_alloc_aligned_ring(mhi_cntrl, ring, ring->len);
-		if (ret)
-			goto error_alloc_er;
-
-		/*
-		 * If the read pointer equals to the write pointer, then the
-		 * ring is empty
-		 */
-		ring->rp = ring->wp = ring->base;
-		er_ctxt->rbase = ring->iommu_base;
-		er_ctxt->rp = er_ctxt->wp = er_ctxt->rbase;
-		er_ctxt->rlen = ring->len;
-		ring->ctxt_wp = &er_ctxt->wp;
-	}
-
-	/* Setup cmd context */
-	ret = -ENOMEM;
-	mhi_ctxt->cmd_ctxt = mhi_alloc_coherent(mhi_cntrl,
-						sizeof(*mhi_ctxt->cmd_ctxt) *
-						NR_OF_CMD_RINGS,
-						&mhi_ctxt->cmd_ctxt_addr,
-						GFP_KERNEL);
-	if (!mhi_ctxt->cmd_ctxt)
-		goto error_alloc_er;
-
-	mhi_cmd = mhi_cntrl->mhi_cmd;
-	cmd_ctxt = mhi_ctxt->cmd_ctxt;
-	for (i = 0; i < NR_OF_CMD_RINGS; i++, mhi_cmd++, cmd_ctxt++) {
-		struct mhi_ring *ring = &mhi_cmd->ring;
-
-		ring->el_size = sizeof(struct mhi_tre);
-		ring->elements = CMD_EL_PER_RING;
-		ring->len = ring->el_size * ring->elements;
-		ret = mhi_alloc_aligned_ring(mhi_cntrl, ring, ring->len);
-		if (ret)
-			goto error_alloc_cmd;
-
-		ring->rp = ring->wp = ring->base;
-		cmd_ctxt->rbase = ring->iommu_base;
-		cmd_ctxt->rp = cmd_ctxt->wp = cmd_ctxt->rbase;
-		cmd_ctxt->rlen = ring->len;
-		ring->ctxt_wp = &cmd_ctxt->wp;
-	}
-
-	mhi_cntrl->mhi_ctxt = mhi_ctxt;
-
-	return 0;
-
-error_alloc_cmd:
-	for (--i, --mhi_cmd; i >= 0; i--, mhi_cmd--) {
-		struct mhi_ring *ring = &mhi_cmd->ring;
-
-		mhi_free_coherent(mhi_cntrl, ring->alloc_size,
-				  ring->pre_aligned, ring->dma_handle);
-	}
-	mhi_free_coherent(mhi_cntrl,
-			  sizeof(*mhi_ctxt->cmd_ctxt) * NR_OF_CMD_RINGS,
-			  mhi_ctxt->cmd_ctxt, mhi_ctxt->cmd_ctxt_addr);
-	i = mhi_cntrl->total_ev_rings;
-	mhi_event = mhi_cntrl->mhi_event + i;
-
-error_alloc_er:
-	for (--i, --mhi_event; i >= 0; i--, mhi_event--) {
-		struct mhi_ring *ring = &mhi_event->ring;
-
-		if (mhi_event->offload_ev)
-			continue;
-
-		mhi_free_coherent(mhi_cntrl, ring->alloc_size,
-				  ring->pre_aligned, ring->dma_handle);
-	}
-	mhi_free_coherent(mhi_cntrl, sizeof(*mhi_ctxt->er_ctxt) *
-			  mhi_cntrl->total_ev_rings, mhi_ctxt->er_ctxt,
-			  mhi_ctxt->er_ctxt_addr);
-
-error_alloc_er_ctxt:
-	mhi_free_coherent(mhi_cntrl, sizeof(*mhi_ctxt->chan_ctxt) *
-			  mhi_cntrl->max_chan, mhi_ctxt->chan_ctxt,
-			  mhi_ctxt->chan_ctxt_addr);
-
-error_alloc_chan_ctxt:
-	kfree(mhi_ctxt);
-
-	return ret;
-}
-
-int mhi_init_mmio(struct mhi_controller *mhi_cntrl)
-{
-	u32 val;
-	int i, ret;
-	struct mhi_chan *mhi_chan;
-	struct mhi_event *mhi_event;
-	void __iomem *base = mhi_cntrl->regs;
-	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-	struct {
-		u32 offset;
-		u32 mask;
-		u32 shift;
-		u32 val;
-	} reg_info[] = {
-		{
-			CCABAP_HIGHER, U32_MAX, 0,
-			upper_32_bits(mhi_cntrl->mhi_ctxt->chan_ctxt_addr),
-		},
-		{
-			CCABAP_LOWER, U32_MAX, 0,
-			lower_32_bits(mhi_cntrl->mhi_ctxt->chan_ctxt_addr),
-		},
-		{
-			ECABAP_HIGHER, U32_MAX, 0,
-			upper_32_bits(mhi_cntrl->mhi_ctxt->er_ctxt_addr),
-		},
-		{
-			ECABAP_LOWER, U32_MAX, 0,
-			lower_32_bits(mhi_cntrl->mhi_ctxt->er_ctxt_addr),
-		},
-		{
-			CRCBAP_HIGHER, U32_MAX, 0,
-			upper_32_bits(mhi_cntrl->mhi_ctxt->cmd_ctxt_addr),
-		},
-		{
-			CRCBAP_LOWER, U32_MAX, 0,
-			lower_32_bits(mhi_cntrl->mhi_ctxt->cmd_ctxt_addr),
-		},
-		{
-			MHICFG, MHICFG_NER_MASK, MHICFG_NER_SHIFT,
-			mhi_cntrl->total_ev_rings,
-		},
-		{
-			MHICFG, MHICFG_NHWER_MASK, MHICFG_NHWER_SHIFT,
-			mhi_cntrl->hw_ev_rings,
-		},
-		{
-			MHICTRLBASE_HIGHER, U32_MAX, 0,
-			upper_32_bits(mhi_cntrl->iova_start),
-		},
-		{
-			MHICTRLBASE_LOWER, U32_MAX, 0,
-			lower_32_bits(mhi_cntrl->iova_start),
-		},
-		{
-			MHIDATABASE_HIGHER, U32_MAX, 0,
-			upper_32_bits(mhi_cntrl->iova_start),
-		},
-		{
-			MHIDATABASE_LOWER, U32_MAX, 0,
-			lower_32_bits(mhi_cntrl->iova_start),
-		},
-		{
-			MHICTRLLIMIT_HIGHER, U32_MAX, 0,
-			upper_32_bits(mhi_cntrl->iova_stop),
-		},
-		{
-			MHICTRLLIMIT_LOWER, U32_MAX, 0,
-			lower_32_bits(mhi_cntrl->iova_stop),
-		},
-		{
-			MHIDATALIMIT_HIGHER, U32_MAX, 0,
-			upper_32_bits(mhi_cntrl->iova_stop),
-		},
-		{
-			MHIDATALIMIT_LOWER, U32_MAX, 0,
-			lower_32_bits(mhi_cntrl->iova_stop),
-		},
-		{ 0, 0, 0 }
-	};
-
-	dev_dbg(dev, "Initializing MHI registers\n");
-
-	/* Read channel db offset */
-	ret = mhi_read_reg_field(mhi_cntrl, base, CHDBOFF, CHDBOFF_CHDBOFF_MASK,
-				 CHDBOFF_CHDBOFF_SHIFT, &val);
-	if (ret) {
-		dev_err(dev, "Unable to read CHDBOFF register\n");
-		return -EIO;
-	}
-
-	/* Setup wake db */
-	mhi_cntrl->wake_db = base + val + (8 * MHI_DEV_WAKE_DB);
-	mhi_write_reg(mhi_cntrl, mhi_cntrl->wake_db, 4, 0);
-	mhi_write_reg(mhi_cntrl, mhi_cntrl->wake_db, 0, 0);
-	mhi_cntrl->wake_set = false;
-
-	/* Setup channel db address for each channel in tre_ring */
-	mhi_chan = mhi_cntrl->mhi_chan;
-	for (i = 0; i < mhi_cntrl->max_chan; i++, val += 8, mhi_chan++)
-		mhi_chan->tre_ring.db_addr = base + val;
-
-	/* Read event ring db offset */
-	ret = mhi_read_reg_field(mhi_cntrl, base, ERDBOFF, ERDBOFF_ERDBOFF_MASK,
-				 ERDBOFF_ERDBOFF_SHIFT, &val);
-	if (ret) {
-		dev_err(dev, "Unable to read ERDBOFF register\n");
-		return -EIO;
-	}
-
-	/* Setup event db address for each ev_ring */
-	mhi_event = mhi_cntrl->mhi_event;
-	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, val += 8, mhi_event++) {
-		if (mhi_event->offload_ev)
-			continue;
-
-		mhi_event->ring.db_addr = base + val;
-	}
-
-	/* Setup DB register for primary CMD rings */
-	mhi_cntrl->mhi_cmd[PRIMARY_CMD_RING].ring.db_addr = base + CRDB_LOWER;
-
-	/* Write to MMIO registers */
-	for (i = 0; reg_info[i].offset; i++)
-		mhi_write_reg_field(mhi_cntrl, base, reg_info[i].offset,
-				    reg_info[i].mask, reg_info[i].shift,
-				    reg_info[i].val);
-
-	return 0;
-}
-
-void mhi_deinit_chan_ctxt(struct mhi_controller *mhi_cntrl,
-			  struct mhi_chan *mhi_chan)
-{
-	struct mhi_ring *buf_ring;
-	struct mhi_ring *tre_ring;
-	struct mhi_chan_ctxt *chan_ctxt;
-	u32 tmp;
-
-	buf_ring = &mhi_chan->buf_ring;
-	tre_ring = &mhi_chan->tre_ring;
-	chan_ctxt = &mhi_cntrl->mhi_ctxt->chan_ctxt[mhi_chan->chan];
-
-	mhi_free_coherent(mhi_cntrl, tre_ring->alloc_size,
-			  tre_ring->pre_aligned, tre_ring->dma_handle);
-	vfree(buf_ring->base);
-
-	buf_ring->base = tre_ring->base = NULL;
-	tre_ring->ctxt_wp = NULL;
-	chan_ctxt->rbase = 0;
-	chan_ctxt->rlen = 0;
-	chan_ctxt->rp = 0;
-	chan_ctxt->wp = 0;
-
-	tmp = chan_ctxt->chcfg;
-	tmp &= ~CHAN_CTX_CHSTATE_MASK;
-	tmp |= (MHI_CH_STATE_DISABLED << CHAN_CTX_CHSTATE_SHIFT);
-	chan_ctxt->chcfg = tmp;
-
-	/* Update to all cores */
-	smp_wmb();
-}
-
-int mhi_init_chan_ctxt(struct mhi_controller *mhi_cntrl,
-		       struct mhi_chan *mhi_chan)
-{
-	struct mhi_ring *buf_ring;
-	struct mhi_ring *tre_ring;
-	struct mhi_chan_ctxt *chan_ctxt;
-	u32 tmp;
-	int ret;
-
-	buf_ring = &mhi_chan->buf_ring;
-	tre_ring = &mhi_chan->tre_ring;
-	tre_ring->el_size = sizeof(struct mhi_tre);
-	tre_ring->len = tre_ring->el_size * tre_ring->elements;
-	chan_ctxt = &mhi_cntrl->mhi_ctxt->chan_ctxt[mhi_chan->chan];
-	ret = mhi_alloc_aligned_ring(mhi_cntrl, tre_ring, tre_ring->len);
-	if (ret)
-		return -ENOMEM;
-
-	buf_ring->el_size = sizeof(struct mhi_buf_info);
-	buf_ring->len = buf_ring->el_size * buf_ring->elements;
-	buf_ring->base = vzalloc(buf_ring->len);
-
-	if (!buf_ring->base) {
-		mhi_free_coherent(mhi_cntrl, tre_ring->alloc_size,
-				  tre_ring->pre_aligned, tre_ring->dma_handle);
-		return -ENOMEM;
-	}
-
-	tmp = chan_ctxt->chcfg;
-	tmp &= ~CHAN_CTX_CHSTATE_MASK;
-	tmp |= (MHI_CH_STATE_ENABLED << CHAN_CTX_CHSTATE_SHIFT);
-	chan_ctxt->chcfg = tmp;
-
-	chan_ctxt->rbase = tre_ring->iommu_base;
-	chan_ctxt->rp = chan_ctxt->wp = chan_ctxt->rbase;
-	chan_ctxt->rlen = tre_ring->len;
-	tre_ring->ctxt_wp = &chan_ctxt->wp;
-
-	tre_ring->rp = tre_ring->wp = tre_ring->base;
-	buf_ring->rp = buf_ring->wp = buf_ring->base;
-	mhi_chan->db_cfg.db_mode = 1;
-
-	/* Update to all cores */
-	smp_wmb();
-
-	return 0;
-}
-
-static int parse_ev_cfg(struct mhi_controller *mhi_cntrl,
-			const struct mhi_controller_config *config)
-{
-	struct mhi_event *mhi_event;
-	const struct mhi_event_config *event_cfg;
-	struct device *dev = mhi_cntrl->cntrl_dev;
-	int i, num;
-
-	num = config->num_events;
-	mhi_cntrl->total_ev_rings = num;
-	mhi_cntrl->mhi_event = kcalloc(num, sizeof(*mhi_cntrl->mhi_event),
-				       GFP_KERNEL);
-	if (!mhi_cntrl->mhi_event)
-		return -ENOMEM;
-
-	/* Populate event ring */
-	mhi_event = mhi_cntrl->mhi_event;
-	for (i = 0; i < num; i++) {
-		event_cfg = &config->event_cfg[i];
-
-		mhi_event->er_index = i;
-		mhi_event->ring.elements = event_cfg->num_elements;
-		mhi_event->intmod = event_cfg->irq_moderation_ms;
-		mhi_event->irq = event_cfg->irq;
-
-		if (event_cfg->channel != U32_MAX) {
-			/* This event ring has a dedicated channel */
-			mhi_event->chan = event_cfg->channel;
-			if (mhi_event->chan >= mhi_cntrl->max_chan) {
-				dev_err(dev,
-					"Event Ring channel not available\n");
-				goto error_ev_cfg;
-			}
-
-			mhi_event->mhi_chan =
-				&mhi_cntrl->mhi_chan[mhi_event->chan];
-		}
-
-		/* Priority is fixed to 1 for now */
-		mhi_event->priority = 1;
-
-		mhi_event->db_cfg.brstmode = event_cfg->mode;
-		if (MHI_INVALID_BRSTMODE(mhi_event->db_cfg.brstmode))
-			goto error_ev_cfg;
-
-		if (mhi_event->db_cfg.brstmode == MHI_DB_BRST_ENABLE)
-			mhi_event->db_cfg.process_db = mhi_db_brstmode;
-		else
-			mhi_event->db_cfg.process_db = mhi_db_brstmode_disable;
-
-		mhi_event->data_type = event_cfg->data_type;
-
-		switch (mhi_event->data_type) {
-		case MHI_ER_DATA:
-			mhi_event->process_event = mhi_process_data_event_ring;
-			break;
-		case MHI_ER_CTRL:
-			mhi_event->process_event = mhi_process_ctrl_ev_ring;
-			break;
-		default:
-			dev_err(dev, "Event Ring type not supported\n");
-			goto error_ev_cfg;
-		}
-
-		mhi_event->hw_ring = event_cfg->hardware_event;
-		if (mhi_event->hw_ring)
-			mhi_cntrl->hw_ev_rings++;
-		else
-			mhi_cntrl->sw_ev_rings++;
-
-		mhi_event->cl_manage = event_cfg->client_managed;
-		mhi_event->offload_ev = event_cfg->offload_channel;
-		mhi_event++;
-	}
-
-	return 0;
-
-error_ev_cfg:
-
-	kfree(mhi_cntrl->mhi_event);
-	return -EINVAL;
-}
-
-static int parse_ch_cfg(struct mhi_controller *mhi_cntrl,
-			const struct mhi_controller_config *config)
-{
-	const struct mhi_channel_config *ch_cfg;
-	struct device *dev = mhi_cntrl->cntrl_dev;
-	int i;
-	u32 chan;
-
-	mhi_cntrl->max_chan = config->max_channels;
-
-	/*
-	 * The allocation of MHI channels can exceed 32KB in some scenarios,
-	 * so to avoid any memory possible allocation failures, vzalloc is
-	 * used here
-	 */
-	mhi_cntrl->mhi_chan = vzalloc(mhi_cntrl->max_chan *
-				      sizeof(*mhi_cntrl->mhi_chan));
-	if (!mhi_cntrl->mhi_chan)
-		return -ENOMEM;
-
-	INIT_LIST_HEAD(&mhi_cntrl->lpm_chans);
-
-	/* Populate channel configurations */
-	for (i = 0; i < config->num_channels; i++) {
-		struct mhi_chan *mhi_chan;
-
-		ch_cfg = &config->ch_cfg[i];
-
-		chan = ch_cfg->num;
-		if (chan >= mhi_cntrl->max_chan) {
-			dev_err(dev, "Channel %d not available\n", chan);
-			goto error_chan_cfg;
-		}
-
-		mhi_chan = &mhi_cntrl->mhi_chan[chan];
-		mhi_chan->name = ch_cfg->name;
-		mhi_chan->chan = chan;
-
-		mhi_chan->tre_ring.elements = ch_cfg->num_elements;
-		if (!mhi_chan->tre_ring.elements)
-			goto error_chan_cfg;
-
-		/*
-		 * For some channels, local ring length should be bigger than
-		 * the transfer ring length due to internal logical channels
-		 * in device. So host can queue much more buffers than transfer
-		 * ring length. Example, RSC channels should have a larger local
-		 * channel length than transfer ring length.
-		 */
-		mhi_chan->buf_ring.elements = ch_cfg->local_elements;
-		if (!mhi_chan->buf_ring.elements)
-			mhi_chan->buf_ring.elements = mhi_chan->tre_ring.elements;
-		mhi_chan->er_index = ch_cfg->event_ring;
-		mhi_chan->dir = ch_cfg->dir;
-
-		/*
-		 * For most channels, chtype is identical to channel directions.
-		 * So, if it is not defined then assign channel direction to
-		 * chtype
-		 */
-		mhi_chan->type = ch_cfg->type;
-		if (!mhi_chan->type)
-			mhi_chan->type = (enum mhi_ch_type)mhi_chan->dir;
-
-		mhi_chan->ee_mask = ch_cfg->ee_mask;
-		mhi_chan->db_cfg.pollcfg = ch_cfg->pollcfg;
-		mhi_chan->lpm_notify = ch_cfg->lpm_notify;
-		mhi_chan->offload_ch = ch_cfg->offload_channel;
-		mhi_chan->db_cfg.reset_req = ch_cfg->doorbell_mode_switch;
-		mhi_chan->pre_alloc = ch_cfg->auto_queue;
-		mhi_chan->auto_start = ch_cfg->auto_start;
-
-		/*
-		 * If MHI host allocates buffers, then the channel direction
-		 * should be DMA_FROM_DEVICE
-		 */
-		if (mhi_chan->pre_alloc && mhi_chan->dir != DMA_FROM_DEVICE) {
-			dev_err(dev, "Invalid channel configuration\n");
-			goto error_chan_cfg;
-		}
-
-		/*
-		 * Bi-directional and direction less channel must be an
-		 * offload channel
-		 */
-		if ((mhi_chan->dir == DMA_BIDIRECTIONAL ||
-		     mhi_chan->dir == DMA_NONE) && !mhi_chan->offload_ch) {
-			dev_err(dev, "Invalid channel configuration\n");
-			goto error_chan_cfg;
-		}
-
-		if (!mhi_chan->offload_ch) {
-			mhi_chan->db_cfg.brstmode = ch_cfg->doorbell;
-			if (MHI_INVALID_BRSTMODE(mhi_chan->db_cfg.brstmode)) {
-				dev_err(dev, "Invalid Door bell mode\n");
-				goto error_chan_cfg;
-			}
-		}
-
-		if (mhi_chan->db_cfg.brstmode == MHI_DB_BRST_ENABLE)
-			mhi_chan->db_cfg.process_db = mhi_db_brstmode;
-		else
-			mhi_chan->db_cfg.process_db = mhi_db_brstmode_disable;
-
-		mhi_chan->configured = true;
-
-		if (mhi_chan->lpm_notify)
-			list_add_tail(&mhi_chan->node, &mhi_cntrl->lpm_chans);
-	}
-
-	return 0;
-
-error_chan_cfg:
-	vfree(mhi_cntrl->mhi_chan);
-
-	return -EINVAL;
-}
-
-static int parse_config(struct mhi_controller *mhi_cntrl,
-			const struct mhi_controller_config *config)
-{
-	int ret;
-
-	/* Parse MHI channel configuration */
-	ret = parse_ch_cfg(mhi_cntrl, config);
-	if (ret)
-		return ret;
-
-	/* Parse MHI event configuration */
-	ret = parse_ev_cfg(mhi_cntrl, config);
-	if (ret)
-		goto error_ev_cfg;
-
-	mhi_cntrl->timeout_ms = config->timeout_ms;
-	if (!mhi_cntrl->timeout_ms)
-		mhi_cntrl->timeout_ms = MHI_TIMEOUT_MS;
-
-	mhi_cntrl->bounce_buf = config->use_bounce_buf;
-	mhi_cntrl->buffer_len = config->buf_len;
-	if (!mhi_cntrl->buffer_len)
-		mhi_cntrl->buffer_len = MHI_MAX_MTU;
-
-	/* By default, host is allowed to ring DB in both M0 and M2 states */
-	mhi_cntrl->db_access = MHI_PM_M0 | MHI_PM_M2;
-	if (config->m2_no_db)
-		mhi_cntrl->db_access &= ~MHI_PM_M2;
-
-	return 0;
-
-error_ev_cfg:
-	vfree(mhi_cntrl->mhi_chan);
-
-	return ret;
-}
-
-int mhi_register_controller(struct mhi_controller *mhi_cntrl,
-			    const struct mhi_controller_config *config)
-{
-	struct mhi_event *mhi_event;
-	struct mhi_chan *mhi_chan;
-	struct mhi_cmd *mhi_cmd;
-	struct mhi_device *mhi_dev;
-	u32 soc_info;
-	int ret, i;
-
-	if (!mhi_cntrl)
-		return -EINVAL;
-
-	if (!mhi_cntrl->runtime_get || !mhi_cntrl->runtime_put ||
-	    !mhi_cntrl->status_cb || !mhi_cntrl->read_reg ||
-	    !mhi_cntrl->write_reg)
-		return -EINVAL;
-
-	ret = parse_config(mhi_cntrl, config);
-	if (ret)
-		return -EINVAL;
-
-	mhi_cntrl->mhi_cmd = kcalloc(NR_OF_CMD_RINGS,
-				     sizeof(*mhi_cntrl->mhi_cmd), GFP_KERNEL);
-	if (!mhi_cntrl->mhi_cmd) {
-		ret = -ENOMEM;
-		goto error_alloc_cmd;
-	}
-
-	INIT_LIST_HEAD(&mhi_cntrl->transition_list);
-	mutex_init(&mhi_cntrl->pm_mutex);
-	rwlock_init(&mhi_cntrl->pm_lock);
-	spin_lock_init(&mhi_cntrl->transition_lock);
-	spin_lock_init(&mhi_cntrl->wlock);
-	INIT_WORK(&mhi_cntrl->st_worker, mhi_pm_st_worker);
-	init_waitqueue_head(&mhi_cntrl->state_event);
-
-	mhi_cmd = mhi_cntrl->mhi_cmd;
-	for (i = 0; i < NR_OF_CMD_RINGS; i++, mhi_cmd++)
-		spin_lock_init(&mhi_cmd->lock);
-
-	mhi_event = mhi_cntrl->mhi_event;
-	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
-		/* Skip for offload events */
-		if (mhi_event->offload_ev)
-			continue;
-
-		mhi_event->mhi_cntrl = mhi_cntrl;
-		spin_lock_init(&mhi_event->lock);
-		if (mhi_event->data_type == MHI_ER_CTRL)
-			tasklet_init(&mhi_event->task, mhi_ctrl_ev_task,
-				     (ulong)mhi_event);
-		else
-			tasklet_init(&mhi_event->task, mhi_ev_task,
-				     (ulong)mhi_event);
-	}
-
-	mhi_chan = mhi_cntrl->mhi_chan;
-	for (i = 0; i < mhi_cntrl->max_chan; i++, mhi_chan++) {
-		mutex_init(&mhi_chan->mutex);
-		init_completion(&mhi_chan->completion);
-		rwlock_init(&mhi_chan->lock);
-
-		/* used in setting bei field of TRE */
-		mhi_event = &mhi_cntrl->mhi_event[mhi_chan->er_index];
-		mhi_chan->intmod = mhi_event->intmod;
-	}
-
-	if (mhi_cntrl->bounce_buf) {
-		mhi_cntrl->map_single = mhi_map_single_use_bb;
-		mhi_cntrl->unmap_single = mhi_unmap_single_use_bb;
-	} else {
-		mhi_cntrl->map_single = mhi_map_single_no_bb;
-		mhi_cntrl->unmap_single = mhi_unmap_single_no_bb;
-	}
-
-	/* Read the MHI device info */
-	ret = mhi_read_reg(mhi_cntrl, mhi_cntrl->regs,
-			   SOC_HW_VERSION_OFFS, &soc_info);
-	if (ret)
-		goto error_alloc_dev;
-
-	mhi_cntrl->family_number = (soc_info & SOC_HW_VERSION_FAM_NUM_BMSK) >>
-					SOC_HW_VERSION_FAM_NUM_SHFT;
-	mhi_cntrl->device_number = (soc_info & SOC_HW_VERSION_DEV_NUM_BMSK) >>
-					SOC_HW_VERSION_DEV_NUM_SHFT;
-	mhi_cntrl->major_version = (soc_info & SOC_HW_VERSION_MAJOR_VER_BMSK) >>
-					SOC_HW_VERSION_MAJOR_VER_SHFT;
-	mhi_cntrl->minor_version = (soc_info & SOC_HW_VERSION_MINOR_VER_BMSK) >>
-					SOC_HW_VERSION_MINOR_VER_SHFT;
-
-	/* Register controller with MHI bus */
-	mhi_dev = mhi_alloc_device(mhi_cntrl);
-	if (IS_ERR(mhi_dev)) {
-		dev_err(mhi_cntrl->cntrl_dev, "Failed to allocate MHI device\n");
-		ret = PTR_ERR(mhi_dev);
-		goto error_alloc_dev;
-	}
-
-	mhi_dev->dev_type = MHI_DEVICE_CONTROLLER;
-	mhi_dev->mhi_cntrl = mhi_cntrl;
-	dev_set_name(&mhi_dev->dev, "%s", dev_name(mhi_cntrl->cntrl_dev));
-	mhi_dev->name = dev_name(mhi_cntrl->cntrl_dev);
-
-	/* Init wakeup source */
-	device_init_wakeup(&mhi_dev->dev, true);
-
-	ret = device_add(&mhi_dev->dev);
-	if (ret)
-		goto error_add_dev;
-
-	mhi_cntrl->mhi_dev = mhi_dev;
-
-	mhi_create_debugfs(mhi_cntrl);
-
-	return 0;
-
-error_add_dev:
-	put_device(&mhi_dev->dev);
-
-error_alloc_dev:
-	kfree(mhi_cntrl->mhi_cmd);
-
-error_alloc_cmd:
-	vfree(mhi_cntrl->mhi_chan);
-	kfree(mhi_cntrl->mhi_event);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(mhi_register_controller);
-
-void mhi_unregister_controller(struct mhi_controller *mhi_cntrl)
-{
-	struct mhi_device *mhi_dev = mhi_cntrl->mhi_dev;
-	struct mhi_chan *mhi_chan = mhi_cntrl->mhi_chan;
-	unsigned int i;
-
-	mhi_destroy_debugfs(mhi_cntrl);
-
-	kfree(mhi_cntrl->mhi_cmd);
-	kfree(mhi_cntrl->mhi_event);
-
-	/* Drop the references to MHI devices created for channels */
-	for (i = 0; i < mhi_cntrl->max_chan; i++, mhi_chan++) {
-		if (!mhi_chan->mhi_dev)
-			continue;
-
-		put_device(&mhi_chan->mhi_dev->dev);
-	}
-	vfree(mhi_cntrl->mhi_chan);
-
-	device_del(&mhi_dev->dev);
-	put_device(&mhi_dev->dev);
-}
-EXPORT_SYMBOL_GPL(mhi_unregister_controller);
-
-struct mhi_controller *mhi_alloc_controller(void)
-{
-	struct mhi_controller *mhi_cntrl;
-
-	mhi_cntrl = kzalloc(sizeof(*mhi_cntrl), GFP_KERNEL);
-
-	return mhi_cntrl;
-}
-EXPORT_SYMBOL_GPL(mhi_alloc_controller);
-
-void mhi_free_controller(struct mhi_controller *mhi_cntrl)
-{
-	kfree(mhi_cntrl);
-}
-EXPORT_SYMBOL_GPL(mhi_free_controller);
-
-int mhi_prepare_for_power_up(struct mhi_controller *mhi_cntrl)
-{
-	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-	u32 bhie_off;
-	int ret;
-
-	mutex_lock(&mhi_cntrl->pm_mutex);
-
-	ret = mhi_init_dev_ctxt(mhi_cntrl);
-	if (ret)
-		goto error_dev_ctxt;
-
-	/*
-	 * Allocate RDDM table if specified, this table is for debugging purpose
-	 */
-	if (mhi_cntrl->rddm_size) {
-		mhi_alloc_bhie_table(mhi_cntrl, &mhi_cntrl->rddm_image,
-				     mhi_cntrl->rddm_size);
-
-		/*
-		 * This controller supports RDDM, so we need to manually clear
-		 * BHIE RX registers since POR values are undefined.
-		 */
-		ret = mhi_read_reg(mhi_cntrl, mhi_cntrl->regs, BHIEOFF,
-				   &bhie_off);
-		if (ret) {
-			dev_err(dev, "Error getting BHIE offset\n");
-			goto bhie_error;
-		}
-
-		mhi_cntrl->bhie = mhi_cntrl->regs + bhie_off;
-		memset_io(mhi_cntrl->bhie + BHIE_RXVECADDR_LOW_OFFS,
-			  0, BHIE_RXVECSTATUS_OFFS - BHIE_RXVECADDR_LOW_OFFS +
-			  4);
-
-		if (mhi_cntrl->rddm_image)
-			mhi_rddm_prepare(mhi_cntrl, mhi_cntrl->rddm_image);
-	}
-
-	mhi_cntrl->pre_init = true;
-
-	mutex_unlock(&mhi_cntrl->pm_mutex);
-
-	return 0;
-
-bhie_error:
-	if (mhi_cntrl->rddm_image) {
-		mhi_free_bhie_table(mhi_cntrl, mhi_cntrl->rddm_image);
-		mhi_cntrl->rddm_image = NULL;
-	}
-
-error_dev_ctxt:
-	mutex_unlock(&mhi_cntrl->pm_mutex);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(mhi_prepare_for_power_up);
-
-void mhi_unprepare_after_power_down(struct mhi_controller *mhi_cntrl)
-{
-	if (mhi_cntrl->fbc_image) {
-		mhi_free_bhie_table(mhi_cntrl, mhi_cntrl->fbc_image);
-		mhi_cntrl->fbc_image = NULL;
-	}
-
-	if (mhi_cntrl->rddm_image) {
-		mhi_free_bhie_table(mhi_cntrl, mhi_cntrl->rddm_image);
-		mhi_cntrl->rddm_image = NULL;
-	}
-
-	mhi_deinit_dev_ctxt(mhi_cntrl);
-	mhi_cntrl->pre_init = false;
-}
-EXPORT_SYMBOL_GPL(mhi_unprepare_after_power_down);
-
-static void mhi_release_device(struct device *dev)
-{
-	struct mhi_device *mhi_dev = to_mhi_device(dev);
-
-	/*
-	 * We need to set the mhi_chan->mhi_dev to NULL here since the MHI
-	 * devices for the channels will only get created if the mhi_dev
-	 * associated with it is NULL. This scenario will happen during the
-	 * controller suspend and resume.
-	 */
-	if (mhi_dev->ul_chan)
-		mhi_dev->ul_chan->mhi_dev = NULL;
-
-	if (mhi_dev->dl_chan)
-		mhi_dev->dl_chan->mhi_dev = NULL;
-
-	kfree(mhi_dev);
-}
-
-struct mhi_device *mhi_alloc_device(struct mhi_controller *mhi_cntrl)
-{
-	struct mhi_device *mhi_dev;
-	struct device *dev;
-
-	mhi_dev = kzalloc(sizeof(*mhi_dev), GFP_KERNEL);
-	if (!mhi_dev)
-		return ERR_PTR(-ENOMEM);
-
-	dev = &mhi_dev->dev;
-	device_initialize(dev);
-	dev->bus = &mhi_bus_type;
-	dev->release = mhi_release_device;
-	dev->parent = mhi_cntrl->cntrl_dev;
-	mhi_dev->mhi_cntrl = mhi_cntrl;
-	mhi_dev->dev_wake = 0;
-
-	return mhi_dev;
-}
-
-static int mhi_driver_probe(struct device *dev)
-{
-	struct mhi_device *mhi_dev = to_mhi_device(dev);
-	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
-	struct device_driver *drv = dev->driver;
-	struct mhi_driver *mhi_drv = to_mhi_driver(drv);
-	struct mhi_event *mhi_event;
-	struct mhi_chan *ul_chan = mhi_dev->ul_chan;
-	struct mhi_chan *dl_chan = mhi_dev->dl_chan;
-	int ret;
-
-	/* Bring device out of LPM */
-	ret = mhi_device_get_sync(mhi_dev);
-	if (ret)
-		return ret;
-
-	ret = -EINVAL;
-
-	if (ul_chan) {
-		/*
-		 * If channel supports LPM notifications then status_cb should
-		 * be provided
-		 */
-		if (ul_chan->lpm_notify && !mhi_drv->status_cb)
-			goto exit_probe;
-
-		/* For non-offload channels then xfer_cb should be provided */
-		if (!ul_chan->offload_ch && !mhi_drv->ul_xfer_cb)
-			goto exit_probe;
-
-		ul_chan->xfer_cb = mhi_drv->ul_xfer_cb;
-		if (ul_chan->auto_start) {
-			ret = mhi_prepare_channel(mhi_cntrl, ul_chan);
-			if (ret)
-				goto exit_probe;
-		}
-	}
-
-	ret = -EINVAL;
-	if (dl_chan) {
-		/*
-		 * If channel supports LPM notifications then status_cb should
-		 * be provided
-		 */
-		if (dl_chan->lpm_notify && !mhi_drv->status_cb)
-			goto exit_probe;
-
-		/* For non-offload channels then xfer_cb should be provided */
-		if (!dl_chan->offload_ch && !mhi_drv->dl_xfer_cb)
-			goto exit_probe;
-
-		mhi_event = &mhi_cntrl->mhi_event[dl_chan->er_index];
-
-		/*
-		 * If the channel event ring is managed by client, then
-		 * status_cb must be provided so that the framework can
-		 * notify pending data
-		 */
-		if (mhi_event->cl_manage && !mhi_drv->status_cb)
-			goto exit_probe;
-
-		dl_chan->xfer_cb = mhi_drv->dl_xfer_cb;
-	}
-
-	/* Call the user provided probe function */
-	ret = mhi_drv->probe(mhi_dev, mhi_dev->id);
-	if (ret)
-		goto exit_probe;
-
-	if (dl_chan && dl_chan->auto_start)
-		mhi_prepare_channel(mhi_cntrl, dl_chan);
-
-	mhi_device_put(mhi_dev);
-
-	return ret;
-
-exit_probe:
-	mhi_unprepare_from_transfer(mhi_dev);
-
-	mhi_device_put(mhi_dev);
-
-	return ret;
-}
-
-static int mhi_driver_remove(struct device *dev)
-{
-	struct mhi_device *mhi_dev = to_mhi_device(dev);
-	struct mhi_driver *mhi_drv = to_mhi_driver(dev->driver);
-	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
-	struct mhi_chan *mhi_chan;
-	enum mhi_ch_state ch_state[] = {
-		MHI_CH_STATE_DISABLED,
-		MHI_CH_STATE_DISABLED
-	};
-	int dir;
-
-	/* Skip if it is a controller device */
-	if (mhi_dev->dev_type == MHI_DEVICE_CONTROLLER)
-		return 0;
-
-	/* Reset both channels */
-	for (dir = 0; dir < 2; dir++) {
-		mhi_chan = dir ? mhi_dev->ul_chan : mhi_dev->dl_chan;
-
-		if (!mhi_chan)
-			continue;
-
-		/* Wake all threads waiting for completion */
-		write_lock_irq(&mhi_chan->lock);
-		mhi_chan->ccs = MHI_EV_CC_INVALID;
-		complete_all(&mhi_chan->completion);
-		write_unlock_irq(&mhi_chan->lock);
-
-		/* Set the channel state to disabled */
-		mutex_lock(&mhi_chan->mutex);
-		write_lock_irq(&mhi_chan->lock);
-		ch_state[dir] = mhi_chan->ch_state;
-		mhi_chan->ch_state = MHI_CH_STATE_SUSPENDED;
-		write_unlock_irq(&mhi_chan->lock);
-
-		/* Reset the non-offload channel */
-		if (!mhi_chan->offload_ch)
-			mhi_reset_chan(mhi_cntrl, mhi_chan);
-
-		mutex_unlock(&mhi_chan->mutex);
-	}
-
-	mhi_drv->remove(mhi_dev);
-
-	/* De-init channel if it was enabled */
-	for (dir = 0; dir < 2; dir++) {
-		mhi_chan = dir ? mhi_dev->ul_chan : mhi_dev->dl_chan;
-
-		if (!mhi_chan)
-			continue;
-
-		mutex_lock(&mhi_chan->mutex);
-
-		if ((ch_state[dir] == MHI_CH_STATE_ENABLED ||
-		     ch_state[dir] == MHI_CH_STATE_STOP) &&
-		    !mhi_chan->offload_ch)
-			mhi_deinit_chan_ctxt(mhi_cntrl, mhi_chan);
-
-		mhi_chan->ch_state = MHI_CH_STATE_DISABLED;
-
-		mutex_unlock(&mhi_chan->mutex);
-	}
-
-	while (mhi_dev->dev_wake)
-		mhi_device_put(mhi_dev);
-
-	return 0;
-}
-
-int __mhi_driver_register(struct mhi_driver *mhi_drv, struct module *owner)
-{
-	struct device_driver *driver = &mhi_drv->driver;
-
-	if (!mhi_drv->probe || !mhi_drv->remove)
-		return -EINVAL;
-
-	driver->bus = &mhi_bus_type;
-	driver->owner = owner;
-	driver->probe = mhi_driver_probe;
-	driver->remove = mhi_driver_remove;
-
-	return driver_register(driver);
-}
-EXPORT_SYMBOL_GPL(__mhi_driver_register);
-
-void mhi_driver_unregister(struct mhi_driver *mhi_drv)
-{
-	driver_unregister(&mhi_drv->driver);
-}
-EXPORT_SYMBOL_GPL(mhi_driver_unregister);
-
-static int mhi_uevent(struct device *dev, struct kobj_uevent_env *env)
-{
-	struct mhi_device *mhi_dev = to_mhi_device(dev);
-
-	return add_uevent_var(env, "MODALIAS=" MHI_DEVICE_MODALIAS_FMT,
-					mhi_dev->name);
-}
-
-static int mhi_match(struct device *dev, struct device_driver *drv)
-{
-	struct mhi_device *mhi_dev = to_mhi_device(dev);
-	struct mhi_driver *mhi_drv = to_mhi_driver(drv);
-	const struct mhi_device_id *id;
-
-	/*
-	 * If the device is a controller type then there is no client driver
-	 * associated with it
-	 */
-	if (mhi_dev->dev_type == MHI_DEVICE_CONTROLLER)
-		return 0;
-
-	for (id = mhi_drv->id_table; id->chan[0]; id++)
-		if (!strcmp(mhi_dev->name, id->chan)) {
-			mhi_dev->id = id;
-			return 1;
-		}
-
-	return 0;
-};
-
-struct bus_type mhi_bus_type = {
-	.name = "mhi",
-	.dev_name = "mhi",
-	.match = mhi_match,
-	.uevent = mhi_uevent,
-	.dev_groups = mhi_dev_groups,
-};
-
-static int __init mhi_init(void)
-{
-	mhi_debugfs_init();
-	return bus_register(&mhi_bus_type);
-}
-
-static void __exit mhi_exit(void)
-{
-	mhi_debugfs_exit();
-	bus_unregister(&mhi_bus_type);
-}
-
-postcore_initcall(mhi_init);
-module_exit(mhi_exit);
-
-MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("MHI Host Interface");
diff --git a/drivers/bus/mhi/core/internal.h b/drivers/bus/mhi/core/internal.h
deleted file mode 100644
index 7989269ddd96..000000000000
--- a/drivers/bus/mhi/core/internal.h
+++ /dev/null
@@ -1,722 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (c) 2018-2020, The Linux Foundation. All rights reserved.
- *
- */
-
-#ifndef _MHI_INT_H
-#define _MHI_INT_H
-
-#include <linux/mhi.h>
-
-extern struct bus_type mhi_bus_type;
-
-#define MHIREGLEN (0x0)
-#define MHIREGLEN_MHIREGLEN_MASK (0xFFFFFFFF)
-#define MHIREGLEN_MHIREGLEN_SHIFT (0)
-
-#define MHIVER (0x8)
-#define MHIVER_MHIVER_MASK (0xFFFFFFFF)
-#define MHIVER_MHIVER_SHIFT (0)
-
-#define MHICFG (0x10)
-#define MHICFG_NHWER_MASK (0xFF000000)
-#define MHICFG_NHWER_SHIFT (24)
-#define MHICFG_NER_MASK (0xFF0000)
-#define MHICFG_NER_SHIFT (16)
-#define MHICFG_NHWCH_MASK (0xFF00)
-#define MHICFG_NHWCH_SHIFT (8)
-#define MHICFG_NCH_MASK (0xFF)
-#define MHICFG_NCH_SHIFT (0)
-
-#define CHDBOFF (0x18)
-#define CHDBOFF_CHDBOFF_MASK (0xFFFFFFFF)
-#define CHDBOFF_CHDBOFF_SHIFT (0)
-
-#define ERDBOFF (0x20)
-#define ERDBOFF_ERDBOFF_MASK (0xFFFFFFFF)
-#define ERDBOFF_ERDBOFF_SHIFT (0)
-
-#define BHIOFF (0x28)
-#define BHIOFF_BHIOFF_MASK (0xFFFFFFFF)
-#define BHIOFF_BHIOFF_SHIFT (0)
-
-#define BHIEOFF (0x2C)
-#define BHIEOFF_BHIEOFF_MASK (0xFFFFFFFF)
-#define BHIEOFF_BHIEOFF_SHIFT (0)
-
-#define DEBUGOFF (0x30)
-#define DEBUGOFF_DEBUGOFF_MASK (0xFFFFFFFF)
-#define DEBUGOFF_DEBUGOFF_SHIFT (0)
-
-#define MHICTRL (0x38)
-#define MHICTRL_MHISTATE_MASK (0x0000FF00)
-#define MHICTRL_MHISTATE_SHIFT (8)
-#define MHICTRL_RESET_MASK (0x2)
-#define MHICTRL_RESET_SHIFT (1)
-
-#define MHISTATUS (0x48)
-#define MHISTATUS_MHISTATE_MASK (0x0000FF00)
-#define MHISTATUS_MHISTATE_SHIFT (8)
-#define MHISTATUS_SYSERR_MASK (0x4)
-#define MHISTATUS_SYSERR_SHIFT (2)
-#define MHISTATUS_READY_MASK (0x1)
-#define MHISTATUS_READY_SHIFT (0)
-
-#define CCABAP_LOWER (0x58)
-#define CCABAP_LOWER_CCABAP_LOWER_MASK (0xFFFFFFFF)
-#define CCABAP_LOWER_CCABAP_LOWER_SHIFT (0)
-
-#define CCABAP_HIGHER (0x5C)
-#define CCABAP_HIGHER_CCABAP_HIGHER_MASK (0xFFFFFFFF)
-#define CCABAP_HIGHER_CCABAP_HIGHER_SHIFT (0)
-
-#define ECABAP_LOWER (0x60)
-#define ECABAP_LOWER_ECABAP_LOWER_MASK (0xFFFFFFFF)
-#define ECABAP_LOWER_ECABAP_LOWER_SHIFT (0)
-
-#define ECABAP_HIGHER (0x64)
-#define ECABAP_HIGHER_ECABAP_HIGHER_MASK (0xFFFFFFFF)
-#define ECABAP_HIGHER_ECABAP_HIGHER_SHIFT (0)
-
-#define CRCBAP_LOWER (0x68)
-#define CRCBAP_LOWER_CRCBAP_LOWER_MASK (0xFFFFFFFF)
-#define CRCBAP_LOWER_CRCBAP_LOWER_SHIFT (0)
-
-#define CRCBAP_HIGHER (0x6C)
-#define CRCBAP_HIGHER_CRCBAP_HIGHER_MASK (0xFFFFFFFF)
-#define CRCBAP_HIGHER_CRCBAP_HIGHER_SHIFT (0)
-
-#define CRDB_LOWER (0x70)
-#define CRDB_LOWER_CRDB_LOWER_MASK (0xFFFFFFFF)
-#define CRDB_LOWER_CRDB_LOWER_SHIFT (0)
-
-#define CRDB_HIGHER (0x74)
-#define CRDB_HIGHER_CRDB_HIGHER_MASK (0xFFFFFFFF)
-#define CRDB_HIGHER_CRDB_HIGHER_SHIFT (0)
-
-#define MHICTRLBASE_LOWER (0x80)
-#define MHICTRLBASE_LOWER_MHICTRLBASE_LOWER_MASK (0xFFFFFFFF)
-#define MHICTRLBASE_LOWER_MHICTRLBASE_LOWER_SHIFT (0)
-
-#define MHICTRLBASE_HIGHER (0x84)
-#define MHICTRLBASE_HIGHER_MHICTRLBASE_HIGHER_MASK (0xFFFFFFFF)
-#define MHICTRLBASE_HIGHER_MHICTRLBASE_HIGHER_SHIFT (0)
-
-#define MHICTRLLIMIT_LOWER (0x88)
-#define MHICTRLLIMIT_LOWER_MHICTRLLIMIT_LOWER_MASK (0xFFFFFFFF)
-#define MHICTRLLIMIT_LOWER_MHICTRLLIMIT_LOWER_SHIFT (0)
-
-#define MHICTRLLIMIT_HIGHER (0x8C)
-#define MHICTRLLIMIT_HIGHER_MHICTRLLIMIT_HIGHER_MASK (0xFFFFFFFF)
-#define MHICTRLLIMIT_HIGHER_MHICTRLLIMIT_HIGHER_SHIFT (0)
-
-#define MHIDATABASE_LOWER (0x98)
-#define MHIDATABASE_LOWER_MHIDATABASE_LOWER_MASK (0xFFFFFFFF)
-#define MHIDATABASE_LOWER_MHIDATABASE_LOWER_SHIFT (0)
-
-#define MHIDATABASE_HIGHER (0x9C)
-#define MHIDATABASE_HIGHER_MHIDATABASE_HIGHER_MASK (0xFFFFFFFF)
-#define MHIDATABASE_HIGHER_MHIDATABASE_HIGHER_SHIFT (0)
-
-#define MHIDATALIMIT_LOWER (0xA0)
-#define MHIDATALIMIT_LOWER_MHIDATALIMIT_LOWER_MASK (0xFFFFFFFF)
-#define MHIDATALIMIT_LOWER_MHIDATALIMIT_LOWER_SHIFT (0)
-
-#define MHIDATALIMIT_HIGHER (0xA4)
-#define MHIDATALIMIT_HIGHER_MHIDATALIMIT_HIGHER_MASK (0xFFFFFFFF)
-#define MHIDATALIMIT_HIGHER_MHIDATALIMIT_HIGHER_SHIFT (0)
-
-/* Host request register */
-#define MHI_SOC_RESET_REQ_OFFSET (0xB0)
-#define MHI_SOC_RESET_REQ BIT(0)
-
-/* MHI BHI offfsets */
-#define BHI_BHIVERSION_MINOR (0x00)
-#define BHI_BHIVERSION_MAJOR (0x04)
-#define BHI_IMGADDR_LOW (0x08)
-#define BHI_IMGADDR_HIGH (0x0C)
-#define BHI_IMGSIZE (0x10)
-#define BHI_RSVD1 (0x14)
-#define BHI_IMGTXDB (0x18)
-#define BHI_TXDB_SEQNUM_BMSK (0x3FFFFFFF)
-#define BHI_TXDB_SEQNUM_SHFT (0)
-#define BHI_RSVD2 (0x1C)
-#define BHI_INTVEC (0x20)
-#define BHI_RSVD3 (0x24)
-#define BHI_EXECENV (0x28)
-#define BHI_STATUS (0x2C)
-#define BHI_ERRCODE (0x30)
-#define BHI_ERRDBG1 (0x34)
-#define BHI_ERRDBG2 (0x38)
-#define BHI_ERRDBG3 (0x3C)
-#define BHI_SERIALNU (0x40)
-#define BHI_SBLANTIROLLVER (0x44)
-#define BHI_NUMSEG (0x48)
-#define BHI_MSMHWID(n) (0x4C + (0x4 * n))
-#define BHI_OEMPKHASH(n) (0x64 + (0x4 * n))
-#define BHI_RSVD5 (0xC4)
-#define BHI_STATUS_MASK (0xC0000000)
-#define BHI_STATUS_SHIFT (30)
-#define BHI_STATUS_ERROR (3)
-#define BHI_STATUS_SUCCESS (2)
-#define BHI_STATUS_RESET (0)
-
-/* MHI BHIE offsets */
-#define BHIE_MSMSOCID_OFFS (0x0000)
-#define BHIE_TXVECADDR_LOW_OFFS (0x002C)
-#define BHIE_TXVECADDR_HIGH_OFFS (0x0030)
-#define BHIE_TXVECSIZE_OFFS (0x0034)
-#define BHIE_TXVECDB_OFFS (0x003C)
-#define BHIE_TXVECDB_SEQNUM_BMSK (0x3FFFFFFF)
-#define BHIE_TXVECDB_SEQNUM_SHFT (0)
-#define BHIE_TXVECSTATUS_OFFS (0x0044)
-#define BHIE_TXVECSTATUS_SEQNUM_BMSK (0x3FFFFFFF)
-#define BHIE_TXVECSTATUS_SEQNUM_SHFT (0)
-#define BHIE_TXVECSTATUS_STATUS_BMSK (0xC0000000)
-#define BHIE_TXVECSTATUS_STATUS_SHFT (30)
-#define BHIE_TXVECSTATUS_STATUS_RESET (0x00)
-#define BHIE_TXVECSTATUS_STATUS_XFER_COMPL (0x02)
-#define BHIE_TXVECSTATUS_STATUS_ERROR (0x03)
-#define BHIE_RXVECADDR_LOW_OFFS (0x0060)
-#define BHIE_RXVECADDR_HIGH_OFFS (0x0064)
-#define BHIE_RXVECSIZE_OFFS (0x0068)
-#define BHIE_RXVECDB_OFFS (0x0070)
-#define BHIE_RXVECDB_SEQNUM_BMSK (0x3FFFFFFF)
-#define BHIE_RXVECDB_SEQNUM_SHFT (0)
-#define BHIE_RXVECSTATUS_OFFS (0x0078)
-#define BHIE_RXVECSTATUS_SEQNUM_BMSK (0x3FFFFFFF)
-#define BHIE_RXVECSTATUS_SEQNUM_SHFT (0)
-#define BHIE_RXVECSTATUS_STATUS_BMSK (0xC0000000)
-#define BHIE_RXVECSTATUS_STATUS_SHFT (30)
-#define BHIE_RXVECSTATUS_STATUS_RESET (0x00)
-#define BHIE_RXVECSTATUS_STATUS_XFER_COMPL (0x02)
-#define BHIE_RXVECSTATUS_STATUS_ERROR (0x03)
-
-#define SOC_HW_VERSION_OFFS (0x224)
-#define SOC_HW_VERSION_FAM_NUM_BMSK (0xF0000000)
-#define SOC_HW_VERSION_FAM_NUM_SHFT (28)
-#define SOC_HW_VERSION_DEV_NUM_BMSK (0x0FFF0000)
-#define SOC_HW_VERSION_DEV_NUM_SHFT (16)
-#define SOC_HW_VERSION_MAJOR_VER_BMSK (0x0000FF00)
-#define SOC_HW_VERSION_MAJOR_VER_SHFT (8)
-#define SOC_HW_VERSION_MINOR_VER_BMSK (0x000000FF)
-#define SOC_HW_VERSION_MINOR_VER_SHFT (0)
-
-#define EV_CTX_RESERVED_MASK GENMASK(7, 0)
-#define EV_CTX_INTMODC_MASK GENMASK(15, 8)
-#define EV_CTX_INTMODC_SHIFT 8
-#define EV_CTX_INTMODT_MASK GENMASK(31, 16)
-#define EV_CTX_INTMODT_SHIFT 16
-struct mhi_event_ctxt {
-	__u32 intmod;
-	__u32 ertype;
-	__u32 msivec;
-
-	__u64 rbase __packed __aligned(4);
-	__u64 rlen __packed __aligned(4);
-	__u64 rp __packed __aligned(4);
-	__u64 wp __packed __aligned(4);
-};
-
-#define CHAN_CTX_CHSTATE_MASK GENMASK(7, 0)
-#define CHAN_CTX_CHSTATE_SHIFT 0
-#define CHAN_CTX_BRSTMODE_MASK GENMASK(9, 8)
-#define CHAN_CTX_BRSTMODE_SHIFT 8
-#define CHAN_CTX_POLLCFG_MASK GENMASK(15, 10)
-#define CHAN_CTX_POLLCFG_SHIFT 10
-#define CHAN_CTX_RESERVED_MASK GENMASK(31, 16)
-struct mhi_chan_ctxt {
-	__u32 chcfg;
-	__u32 chtype;
-	__u32 erindex;
-
-	__u64 rbase __packed __aligned(4);
-	__u64 rlen __packed __aligned(4);
-	__u64 rp __packed __aligned(4);
-	__u64 wp __packed __aligned(4);
-};
-
-struct mhi_cmd_ctxt {
-	__u32 reserved0;
-	__u32 reserved1;
-	__u32 reserved2;
-
-	__u64 rbase __packed __aligned(4);
-	__u64 rlen __packed __aligned(4);
-	__u64 rp __packed __aligned(4);
-	__u64 wp __packed __aligned(4);
-};
-
-struct mhi_ctxt {
-	struct mhi_event_ctxt *er_ctxt;
-	struct mhi_chan_ctxt *chan_ctxt;
-	struct mhi_cmd_ctxt *cmd_ctxt;
-	dma_addr_t er_ctxt_addr;
-	dma_addr_t chan_ctxt_addr;
-	dma_addr_t cmd_ctxt_addr;
-};
-
-struct mhi_tre {
-	u64 ptr;
-	u32 dword[2];
-};
-
-struct bhi_vec_entry {
-	u64 dma_addr;
-	u64 size;
-};
-
-enum mhi_cmd_type {
-	MHI_CMD_NOP = 1,
-	MHI_CMD_RESET_CHAN = 16,
-	MHI_CMD_STOP_CHAN = 17,
-	MHI_CMD_START_CHAN = 18,
-};
-
-/* No operation command */
-#define MHI_TRE_CMD_NOOP_PTR (0)
-#define MHI_TRE_CMD_NOOP_DWORD0 (0)
-#define MHI_TRE_CMD_NOOP_DWORD1 (MHI_CMD_NOP << 16)
-
-/* Channel reset command */
-#define MHI_TRE_CMD_RESET_PTR (0)
-#define MHI_TRE_CMD_RESET_DWORD0 (0)
-#define MHI_TRE_CMD_RESET_DWORD1(chid) ((chid << 24) | \
-					(MHI_CMD_RESET_CHAN << 16))
-
-/* Channel stop command */
-#define MHI_TRE_CMD_STOP_PTR (0)
-#define MHI_TRE_CMD_STOP_DWORD0 (0)
-#define MHI_TRE_CMD_STOP_DWORD1(chid) ((chid << 24) | \
-				       (MHI_CMD_STOP_CHAN << 16))
-
-/* Channel start command */
-#define MHI_TRE_CMD_START_PTR (0)
-#define MHI_TRE_CMD_START_DWORD0 (0)
-#define MHI_TRE_CMD_START_DWORD1(chid) ((chid << 24) | \
-					(MHI_CMD_START_CHAN << 16))
-
-#define MHI_TRE_GET_CMD_CHID(tre) (((tre)->dword[1] >> 24) & 0xFF)
-#define MHI_TRE_GET_CMD_TYPE(tre) (((tre)->dword[1] >> 16) & 0xFF)
-
-/* Event descriptor macros */
-#define MHI_TRE_EV_PTR(ptr) (ptr)
-#define MHI_TRE_EV_DWORD0(code, len) ((code << 24) | len)
-#define MHI_TRE_EV_DWORD1(chid, type) ((chid << 24) | (type << 16))
-#define MHI_TRE_GET_EV_PTR(tre) ((tre)->ptr)
-#define MHI_TRE_GET_EV_CODE(tre) (((tre)->dword[0] >> 24) & 0xFF)
-#define MHI_TRE_GET_EV_LEN(tre) ((tre)->dword[0] & 0xFFFF)
-#define MHI_TRE_GET_EV_CHID(tre) (((tre)->dword[1] >> 24) & 0xFF)
-#define MHI_TRE_GET_EV_TYPE(tre) (((tre)->dword[1] >> 16) & 0xFF)
-#define MHI_TRE_GET_EV_STATE(tre) (((tre)->dword[0] >> 24) & 0xFF)
-#define MHI_TRE_GET_EV_EXECENV(tre) (((tre)->dword[0] >> 24) & 0xFF)
-#define MHI_TRE_GET_EV_SEQ(tre) ((tre)->dword[0])
-#define MHI_TRE_GET_EV_TIME(tre) ((tre)->ptr)
-#define MHI_TRE_GET_EV_COOKIE(tre) lower_32_bits((tre)->ptr)
-#define MHI_TRE_GET_EV_VEID(tre) (((tre)->dword[0] >> 16) & 0xFF)
-#define MHI_TRE_GET_EV_LINKSPEED(tre) (((tre)->dword[1] >> 24) & 0xFF)
-#define MHI_TRE_GET_EV_LINKWIDTH(tre) ((tre)->dword[0] & 0xFF)
-
-/* Transfer descriptor macros */
-#define MHI_TRE_DATA_PTR(ptr) (ptr)
-#define MHI_TRE_DATA_DWORD0(len) (len & MHI_MAX_MTU)
-#define MHI_TRE_DATA_DWORD1(bei, ieot, ieob, chain) ((2 << 16) | (bei << 10) \
-	| (ieot << 9) | (ieob << 8) | chain)
-
-/* RSC transfer descriptor macros */
-#define MHI_RSCTRE_DATA_PTR(ptr, len) (((u64)len << 48) | ptr)
-#define MHI_RSCTRE_DATA_DWORD0(cookie) (cookie)
-#define MHI_RSCTRE_DATA_DWORD1 (MHI_PKT_TYPE_COALESCING << 16)
-
-enum mhi_pkt_type {
-	MHI_PKT_TYPE_INVALID = 0x0,
-	MHI_PKT_TYPE_NOOP_CMD = 0x1,
-	MHI_PKT_TYPE_TRANSFER = 0x2,
-	MHI_PKT_TYPE_COALESCING = 0x8,
-	MHI_PKT_TYPE_RESET_CHAN_CMD = 0x10,
-	MHI_PKT_TYPE_STOP_CHAN_CMD = 0x11,
-	MHI_PKT_TYPE_START_CHAN_CMD = 0x12,
-	MHI_PKT_TYPE_STATE_CHANGE_EVENT = 0x20,
-	MHI_PKT_TYPE_CMD_COMPLETION_EVENT = 0x21,
-	MHI_PKT_TYPE_TX_EVENT = 0x22,
-	MHI_PKT_TYPE_RSC_TX_EVENT = 0x28,
-	MHI_PKT_TYPE_EE_EVENT = 0x40,
-	MHI_PKT_TYPE_TSYNC_EVENT = 0x48,
-	MHI_PKT_TYPE_BW_REQ_EVENT = 0x50,
-	MHI_PKT_TYPE_STALE_EVENT, /* internal event */
-};
-
-/* MHI transfer completion events */
-enum mhi_ev_ccs {
-	MHI_EV_CC_INVALID = 0x0,
-	MHI_EV_CC_SUCCESS = 0x1,
-	MHI_EV_CC_EOT = 0x2, /* End of transfer event */
-	MHI_EV_CC_OVERFLOW = 0x3,
-	MHI_EV_CC_EOB = 0x4, /* End of block event */
-	MHI_EV_CC_OOB = 0x5, /* Out of block event */
-	MHI_EV_CC_DB_MODE = 0x6,
-	MHI_EV_CC_UNDEFINED_ERR = 0x10,
-	MHI_EV_CC_BAD_TRE = 0x11,
-};
-
-enum mhi_ch_state {
-	MHI_CH_STATE_DISABLED = 0x0,
-	MHI_CH_STATE_ENABLED = 0x1,
-	MHI_CH_STATE_RUNNING = 0x2,
-	MHI_CH_STATE_SUSPENDED = 0x3,
-	MHI_CH_STATE_STOP = 0x4,
-	MHI_CH_STATE_ERROR = 0x5,
-};
-
-#define MHI_INVALID_BRSTMODE(mode) (mode != MHI_DB_BRST_DISABLE && \
-				    mode != MHI_DB_BRST_ENABLE)
-
-extern const char * const mhi_ee_str[MHI_EE_MAX];
-#define TO_MHI_EXEC_STR(ee) (((ee) >= MHI_EE_MAX) ? \
-			     "INVALID_EE" : mhi_ee_str[ee])
-
-#define MHI_IN_PBL(ee) (ee == MHI_EE_PBL || ee == MHI_EE_PTHRU || \
-			ee == MHI_EE_EDL)
-
-#define MHI_IN_MISSION_MODE(ee) (ee == MHI_EE_AMSS || ee == MHI_EE_WFW)
-
-enum dev_st_transition {
-	DEV_ST_TRANSITION_PBL,
-	DEV_ST_TRANSITION_READY,
-	DEV_ST_TRANSITION_SBL,
-	DEV_ST_TRANSITION_MISSION_MODE,
-	DEV_ST_TRANSITION_SYS_ERR,
-	DEV_ST_TRANSITION_DISABLE,
-	DEV_ST_TRANSITION_MAX,
-};
-
-extern const char * const dev_state_tran_str[DEV_ST_TRANSITION_MAX];
-#define TO_DEV_STATE_TRANS_STR(state) (((state) >= DEV_ST_TRANSITION_MAX) ? \
-				"INVALID_STATE" : dev_state_tran_str[state])
-
-extern const char * const mhi_state_str[MHI_STATE_MAX];
-#define TO_MHI_STATE_STR(state) ((state >= MHI_STATE_MAX || \
-				  !mhi_state_str[state]) ? \
-				"INVALID_STATE" : mhi_state_str[state])
-
-/* internal power states */
-enum mhi_pm_state {
-	MHI_PM_STATE_DISABLE,
-	MHI_PM_STATE_POR,
-	MHI_PM_STATE_M0,
-	MHI_PM_STATE_M2,
-	MHI_PM_STATE_M3_ENTER,
-	MHI_PM_STATE_M3,
-	MHI_PM_STATE_M3_EXIT,
-	MHI_PM_STATE_FW_DL_ERR,
-	MHI_PM_STATE_SYS_ERR_DETECT,
-	MHI_PM_STATE_SYS_ERR_PROCESS,
-	MHI_PM_STATE_SHUTDOWN_PROCESS,
-	MHI_PM_STATE_LD_ERR_FATAL_DETECT,
-	MHI_PM_STATE_MAX
-};
-
-#define MHI_PM_DISABLE			BIT(0)
-#define MHI_PM_POR			BIT(1)
-#define MHI_PM_M0			BIT(2)
-#define MHI_PM_M2			BIT(3)
-#define MHI_PM_M3_ENTER			BIT(4)
-#define MHI_PM_M3			BIT(5)
-#define MHI_PM_M3_EXIT			BIT(6)
-/* firmware download failure state */
-#define MHI_PM_FW_DL_ERR		BIT(7)
-#define MHI_PM_SYS_ERR_DETECT		BIT(8)
-#define MHI_PM_SYS_ERR_PROCESS		BIT(9)
-#define MHI_PM_SHUTDOWN_PROCESS		BIT(10)
-/* link not accessible */
-#define MHI_PM_LD_ERR_FATAL_DETECT	BIT(11)
-
-#define MHI_REG_ACCESS_VALID(pm_state) ((pm_state & (MHI_PM_POR | MHI_PM_M0 | \
-		MHI_PM_M2 | MHI_PM_M3_ENTER | MHI_PM_M3_EXIT | \
-		MHI_PM_SYS_ERR_DETECT | MHI_PM_SYS_ERR_PROCESS | \
-		MHI_PM_SHUTDOWN_PROCESS | MHI_PM_FW_DL_ERR)))
-#define MHI_PM_IN_ERROR_STATE(pm_state) (pm_state >= MHI_PM_FW_DL_ERR)
-#define MHI_PM_IN_FATAL_STATE(pm_state) (pm_state == MHI_PM_LD_ERR_FATAL_DETECT)
-#define MHI_DB_ACCESS_VALID(mhi_cntrl) (mhi_cntrl->pm_state & \
-					mhi_cntrl->db_access)
-#define MHI_WAKE_DB_CLEAR_VALID(pm_state) (pm_state & (MHI_PM_M0 | \
-						MHI_PM_M2 | MHI_PM_M3_EXIT))
-#define MHI_WAKE_DB_SET_VALID(pm_state) (pm_state & MHI_PM_M2)
-#define MHI_WAKE_DB_FORCE_SET_VALID(pm_state) MHI_WAKE_DB_CLEAR_VALID(pm_state)
-#define MHI_EVENT_ACCESS_INVALID(pm_state) (pm_state == MHI_PM_DISABLE || \
-					    MHI_PM_IN_ERROR_STATE(pm_state))
-#define MHI_PM_IN_SUSPEND_STATE(pm_state) (pm_state & \
-					   (MHI_PM_M3_ENTER | MHI_PM_M3))
-
-#define NR_OF_CMD_RINGS			1
-#define CMD_EL_PER_RING			128
-#define PRIMARY_CMD_RING		0
-#define MHI_DEV_WAKE_DB			127
-#define MHI_MAX_MTU			0xffff
-#define MHI_RANDOM_U32_NONZERO(bmsk)	(prandom_u32_max(bmsk) + 1)
-
-enum mhi_er_type {
-	MHI_ER_TYPE_INVALID = 0x0,
-	MHI_ER_TYPE_VALID = 0x1,
-};
-
-struct db_cfg {
-	bool reset_req;
-	bool db_mode;
-	u32 pollcfg;
-	enum mhi_db_brst_mode brstmode;
-	dma_addr_t db_val;
-	void (*process_db)(struct mhi_controller *mhi_cntrl,
-			   struct db_cfg *db_cfg, void __iomem *io_addr,
-			   dma_addr_t db_val);
-};
-
-struct mhi_pm_transitions {
-	enum mhi_pm_state from_state;
-	u32 to_states;
-};
-
-struct state_transition {
-	struct list_head node;
-	enum dev_st_transition state;
-};
-
-struct mhi_ring {
-	dma_addr_t dma_handle;
-	dma_addr_t iommu_base;
-	u64 *ctxt_wp; /* point to ctxt wp */
-	void *pre_aligned;
-	void *base;
-	void *rp;
-	void *wp;
-	size_t el_size;
-	size_t len;
-	size_t elements;
-	size_t alloc_size;
-	void __iomem *db_addr;
-};
-
-struct mhi_cmd {
-	struct mhi_ring ring;
-	spinlock_t lock;
-};
-
-struct mhi_buf_info {
-	void *v_addr;
-	void *bb_addr;
-	void *wp;
-	void *cb_buf;
-	dma_addr_t p_addr;
-	size_t len;
-	enum dma_data_direction dir;
-	bool used; /* Indicates whether the buffer is used or not */
-	bool pre_mapped; /* Already pre-mapped by client */
-};
-
-struct mhi_event {
-	struct mhi_controller *mhi_cntrl;
-	struct mhi_chan *mhi_chan; /* dedicated to channel */
-	u32 er_index;
-	u32 intmod;
-	u32 irq;
-	int chan; /* this event ring is dedicated to a channel (optional) */
-	u32 priority;
-	enum mhi_er_data_type data_type;
-	struct mhi_ring ring;
-	struct db_cfg db_cfg;
-	struct tasklet_struct task;
-	spinlock_t lock;
-	int (*process_event)(struct mhi_controller *mhi_cntrl,
-			     struct mhi_event *mhi_event,
-			     u32 event_quota);
-	bool hw_ring;
-	bool cl_manage;
-	bool offload_ev; /* managed by a device driver */
-};
-
-struct mhi_chan {
-	const char *name;
-	/*
-	 * Important: When consuming, increment tre_ring first and when
-	 * releasing, decrement buf_ring first. If tre_ring has space, buf_ring
-	 * is guranteed to have space so we do not need to check both rings.
-	 */
-	struct mhi_ring buf_ring;
-	struct mhi_ring tre_ring;
-	u32 chan;
-	u32 er_index;
-	u32 intmod;
-	enum mhi_ch_type type;
-	enum dma_data_direction dir;
-	struct db_cfg db_cfg;
-	enum mhi_ch_ee_mask ee_mask;
-	enum mhi_ch_state ch_state;
-	enum mhi_ev_ccs ccs;
-	struct mhi_device *mhi_dev;
-	void (*xfer_cb)(struct mhi_device *mhi_dev, struct mhi_result *result);
-	struct mutex mutex;
-	struct completion completion;
-	rwlock_t lock;
-	struct list_head node;
-	bool lpm_notify;
-	bool configured;
-	bool offload_ch;
-	bool pre_alloc;
-	bool auto_start;
-	bool wake_capable;
-};
-
-/* Default MHI timeout */
-#define MHI_TIMEOUT_MS (1000)
-
-/* debugfs related functions */
-#ifdef CONFIG_MHI_BUS_DEBUG
-void mhi_create_debugfs(struct mhi_controller *mhi_cntrl);
-void mhi_destroy_debugfs(struct mhi_controller *mhi_cntrl);
-void mhi_debugfs_init(void);
-void mhi_debugfs_exit(void);
-#else
-static inline void mhi_create_debugfs(struct mhi_controller *mhi_cntrl)
-{
-}
-
-static inline void mhi_destroy_debugfs(struct mhi_controller *mhi_cntrl)
-{
-}
-
-static inline void mhi_debugfs_init(void)
-{
-}
-
-static inline void mhi_debugfs_exit(void)
-{
-}
-#endif
-
-struct mhi_device *mhi_alloc_device(struct mhi_controller *mhi_cntrl);
-
-int mhi_destroy_device(struct device *dev, void *data);
-void mhi_create_devices(struct mhi_controller *mhi_cntrl);
-
-int mhi_alloc_bhie_table(struct mhi_controller *mhi_cntrl,
-			 struct image_info **image_info, size_t alloc_size);
-void mhi_free_bhie_table(struct mhi_controller *mhi_cntrl,
-			 struct image_info *image_info);
-
-/* Power management APIs */
-enum mhi_pm_state __must_check mhi_tryset_pm_state(
-					struct mhi_controller *mhi_cntrl,
-					enum mhi_pm_state state);
-const char *to_mhi_pm_state_str(enum mhi_pm_state state);
-enum mhi_ee_type mhi_get_exec_env(struct mhi_controller *mhi_cntrl);
-int mhi_queue_state_transition(struct mhi_controller *mhi_cntrl,
-			       enum dev_st_transition state);
-void mhi_pm_st_worker(struct work_struct *work);
-void mhi_pm_sys_err_handler(struct mhi_controller *mhi_cntrl);
-void mhi_fw_load_worker(struct work_struct *work);
-int mhi_ready_state_transition(struct mhi_controller *mhi_cntrl);
-int mhi_pm_m0_transition(struct mhi_controller *mhi_cntrl);
-void mhi_pm_m1_transition(struct mhi_controller *mhi_cntrl);
-int mhi_pm_m3_transition(struct mhi_controller *mhi_cntrl);
-int __mhi_device_get_sync(struct mhi_controller *mhi_cntrl);
-int mhi_send_cmd(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan,
-		 enum mhi_cmd_type cmd);
-static inline bool mhi_is_active(struct mhi_controller *mhi_cntrl)
-{
-	return (mhi_cntrl->dev_state >= MHI_STATE_M0 &&
-		mhi_cntrl->dev_state <= MHI_STATE_M3_FAST);
-}
-
-static inline void mhi_trigger_resume(struct mhi_controller *mhi_cntrl)
-{
-	pm_wakeup_event(&mhi_cntrl->mhi_dev->dev, 0);
-	mhi_cntrl->runtime_get(mhi_cntrl);
-	mhi_cntrl->runtime_put(mhi_cntrl);
-}
-
-/* Register access methods */
-void mhi_db_brstmode(struct mhi_controller *mhi_cntrl, struct db_cfg *db_cfg,
-		     void __iomem *db_addr, dma_addr_t db_val);
-void mhi_db_brstmode_disable(struct mhi_controller *mhi_cntrl,
-			     struct db_cfg *db_mode, void __iomem *db_addr,
-			     dma_addr_t db_val);
-int __must_check mhi_read_reg(struct mhi_controller *mhi_cntrl,
-			      void __iomem *base, u32 offset, u32 *out);
-int __must_check mhi_read_reg_field(struct mhi_controller *mhi_cntrl,
-				    void __iomem *base, u32 offset, u32 mask,
-				    u32 shift, u32 *out);
-void mhi_write_reg(struct mhi_controller *mhi_cntrl, void __iomem *base,
-		   u32 offset, u32 val);
-void mhi_write_reg_field(struct mhi_controller *mhi_cntrl, void __iomem *base,
-			 u32 offset, u32 mask, u32 shift, u32 val);
-void mhi_ring_er_db(struct mhi_event *mhi_event);
-void mhi_write_db(struct mhi_controller *mhi_cntrl, void __iomem *db_addr,
-		  dma_addr_t db_val);
-void mhi_ring_cmd_db(struct mhi_controller *mhi_cntrl, struct mhi_cmd *mhi_cmd);
-void mhi_ring_chan_db(struct mhi_controller *mhi_cntrl,
-		      struct mhi_chan *mhi_chan);
-
-/* Initialization methods */
-int mhi_init_mmio(struct mhi_controller *mhi_cntrl);
-int mhi_init_dev_ctxt(struct mhi_controller *mhi_cntrl);
-void mhi_deinit_dev_ctxt(struct mhi_controller *mhi_cntrl);
-int mhi_init_irq_setup(struct mhi_controller *mhi_cntrl);
-void mhi_deinit_free_irq(struct mhi_controller *mhi_cntrl);
-void mhi_rddm_prepare(struct mhi_controller *mhi_cntrl,
-		      struct image_info *img_info);
-void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl);
-int mhi_prepare_channel(struct mhi_controller *mhi_cntrl,
-			struct mhi_chan *mhi_chan);
-int mhi_init_chan_ctxt(struct mhi_controller *mhi_cntrl,
-		       struct mhi_chan *mhi_chan);
-void mhi_deinit_chan_ctxt(struct mhi_controller *mhi_cntrl,
-			  struct mhi_chan *mhi_chan);
-void mhi_reset_chan(struct mhi_controller *mhi_cntrl,
-		    struct mhi_chan *mhi_chan);
-
-/* Memory allocation methods */
-static inline void *mhi_alloc_coherent(struct mhi_controller *mhi_cntrl,
-				       size_t size,
-				       dma_addr_t *dma_handle,
-				       gfp_t gfp)
-{
-	void *buf = dma_alloc_coherent(mhi_cntrl->cntrl_dev, size, dma_handle,
-				       gfp);
-
-	return buf;
-}
-
-static inline void mhi_free_coherent(struct mhi_controller *mhi_cntrl,
-				     size_t size,
-				     void *vaddr,
-				     dma_addr_t dma_handle)
-{
-	dma_free_coherent(mhi_cntrl->cntrl_dev, size, vaddr, dma_handle);
-}
-
-/* Event processing methods */
-void mhi_ctrl_ev_task(unsigned long data);
-void mhi_ev_task(unsigned long data);
-int mhi_process_data_event_ring(struct mhi_controller *mhi_cntrl,
-				struct mhi_event *mhi_event, u32 event_quota);
-int mhi_process_ctrl_ev_ring(struct mhi_controller *mhi_cntrl,
-			     struct mhi_event *mhi_event, u32 event_quota);
-
-/* ISR handlers */
-irqreturn_t mhi_irq_handler(int irq_number, void *dev);
-irqreturn_t mhi_intvec_threaded_handler(int irq_number, void *dev);
-irqreturn_t mhi_intvec_handler(int irq_number, void *dev);
-
-int mhi_gen_tre(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan,
-		struct mhi_buf_info *info, enum mhi_flags flags);
-int mhi_map_single_no_bb(struct mhi_controller *mhi_cntrl,
-			 struct mhi_buf_info *buf_info);
-int mhi_map_single_use_bb(struct mhi_controller *mhi_cntrl,
-			  struct mhi_buf_info *buf_info);
-void mhi_unmap_single_no_bb(struct mhi_controller *mhi_cntrl,
-			    struct mhi_buf_info *buf_info);
-void mhi_unmap_single_use_bb(struct mhi_controller *mhi_cntrl,
-			     struct mhi_buf_info *buf_info);
-
-#endif /* _MHI_INT_H */
diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
deleted file mode 100644
index 614dd287cb4f..000000000000
--- a/drivers/bus/mhi/core/main.c
+++ /dev/null
@@ -1,1630 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (c) 2018-2020, The Linux Foundation. All rights reserved.
- *
- */
-
-#include <linux/device.h>
-#include <linux/dma-direction.h>
-#include <linux/dma-mapping.h>
-#include <linux/interrupt.h>
-#include <linux/list.h>
-#include <linux/mhi.h>
-#include <linux/module.h>
-#include <linux/skbuff.h>
-#include <linux/slab.h>
-#include "internal.h"
-
-int __must_check mhi_read_reg(struct mhi_controller *mhi_cntrl,
-			      void __iomem *base, u32 offset, u32 *out)
-{
-	return mhi_cntrl->read_reg(mhi_cntrl, base + offset, out);
-}
-
-int __must_check mhi_read_reg_field(struct mhi_controller *mhi_cntrl,
-				    void __iomem *base, u32 offset,
-				    u32 mask, u32 shift, u32 *out)
-{
-	u32 tmp;
-	int ret;
-
-	ret = mhi_read_reg(mhi_cntrl, base, offset, &tmp);
-	if (ret)
-		return ret;
-
-	*out = (tmp & mask) >> shift;
-
-	return 0;
-}
-
-void mhi_write_reg(struct mhi_controller *mhi_cntrl, void __iomem *base,
-		   u32 offset, u32 val)
-{
-	mhi_cntrl->write_reg(mhi_cntrl, base + offset, val);
-}
-
-void mhi_write_reg_field(struct mhi_controller *mhi_cntrl, void __iomem *base,
-			 u32 offset, u32 mask, u32 shift, u32 val)
-{
-	int ret;
-	u32 tmp;
-
-	ret = mhi_read_reg(mhi_cntrl, base, offset, &tmp);
-	if (ret)
-		return;
-
-	tmp &= ~mask;
-	tmp |= (val << shift);
-	mhi_write_reg(mhi_cntrl, base, offset, tmp);
-}
-
-void mhi_write_db(struct mhi_controller *mhi_cntrl, void __iomem *db_addr,
-		  dma_addr_t db_val)
-{
-	mhi_write_reg(mhi_cntrl, db_addr, 4, upper_32_bits(db_val));
-	mhi_write_reg(mhi_cntrl, db_addr, 0, lower_32_bits(db_val));
-}
-
-void mhi_db_brstmode(struct mhi_controller *mhi_cntrl,
-		     struct db_cfg *db_cfg,
-		     void __iomem *db_addr,
-		     dma_addr_t db_val)
-{
-	if (db_cfg->db_mode) {
-		db_cfg->db_val = db_val;
-		mhi_write_db(mhi_cntrl, db_addr, db_val);
-		db_cfg->db_mode = 0;
-	}
-}
-
-void mhi_db_brstmode_disable(struct mhi_controller *mhi_cntrl,
-			     struct db_cfg *db_cfg,
-			     void __iomem *db_addr,
-			     dma_addr_t db_val)
-{
-	db_cfg->db_val = db_val;
-	mhi_write_db(mhi_cntrl, db_addr, db_val);
-}
-
-void mhi_ring_er_db(struct mhi_event *mhi_event)
-{
-	struct mhi_ring *ring = &mhi_event->ring;
-
-	mhi_event->db_cfg.process_db(mhi_event->mhi_cntrl, &mhi_event->db_cfg,
-				     ring->db_addr, *ring->ctxt_wp);
-}
-
-void mhi_ring_cmd_db(struct mhi_controller *mhi_cntrl, struct mhi_cmd *mhi_cmd)
-{
-	dma_addr_t db;
-	struct mhi_ring *ring = &mhi_cmd->ring;
-
-	db = ring->iommu_base + (ring->wp - ring->base);
-	*ring->ctxt_wp = db;
-	mhi_write_db(mhi_cntrl, ring->db_addr, db);
-}
-
-void mhi_ring_chan_db(struct mhi_controller *mhi_cntrl,
-		      struct mhi_chan *mhi_chan)
-{
-	struct mhi_ring *ring = &mhi_chan->tre_ring;
-	dma_addr_t db;
-
-	db = ring->iommu_base + (ring->wp - ring->base);
-	*ring->ctxt_wp = db;
-	mhi_chan->db_cfg.process_db(mhi_cntrl, &mhi_chan->db_cfg,
-				    ring->db_addr, db);
-}
-
-enum mhi_ee_type mhi_get_exec_env(struct mhi_controller *mhi_cntrl)
-{
-	u32 exec;
-	int ret = mhi_read_reg(mhi_cntrl, mhi_cntrl->bhi, BHI_EXECENV, &exec);
-
-	return (ret) ? MHI_EE_MAX : exec;
-}
-
-enum mhi_state mhi_get_mhi_state(struct mhi_controller *mhi_cntrl)
-{
-	u32 state;
-	int ret = mhi_read_reg_field(mhi_cntrl, mhi_cntrl->regs, MHISTATUS,
-				     MHISTATUS_MHISTATE_MASK,
-				     MHISTATUS_MHISTATE_SHIFT, &state);
-	return ret ? MHI_STATE_MAX : state;
-}
-
-int mhi_map_single_no_bb(struct mhi_controller *mhi_cntrl,
-			 struct mhi_buf_info *buf_info)
-{
-	buf_info->p_addr = dma_map_single(mhi_cntrl->cntrl_dev,
-					  buf_info->v_addr, buf_info->len,
-					  buf_info->dir);
-	if (dma_mapping_error(mhi_cntrl->cntrl_dev, buf_info->p_addr))
-		return -ENOMEM;
-
-	return 0;
-}
-
-int mhi_map_single_use_bb(struct mhi_controller *mhi_cntrl,
-			  struct mhi_buf_info *buf_info)
-{
-	void *buf = mhi_alloc_coherent(mhi_cntrl, buf_info->len,
-				       &buf_info->p_addr, GFP_ATOMIC);
-
-	if (!buf)
-		return -ENOMEM;
-
-	if (buf_info->dir == DMA_TO_DEVICE)
-		memcpy(buf, buf_info->v_addr, buf_info->len);
-
-	buf_info->bb_addr = buf;
-
-	return 0;
-}
-
-void mhi_unmap_single_no_bb(struct mhi_controller *mhi_cntrl,
-			    struct mhi_buf_info *buf_info)
-{
-	dma_unmap_single(mhi_cntrl->cntrl_dev, buf_info->p_addr, buf_info->len,
-			 buf_info->dir);
-}
-
-void mhi_unmap_single_use_bb(struct mhi_controller *mhi_cntrl,
-			     struct mhi_buf_info *buf_info)
-{
-	if (buf_info->dir == DMA_FROM_DEVICE)
-		memcpy(buf_info->v_addr, buf_info->bb_addr, buf_info->len);
-
-	mhi_free_coherent(mhi_cntrl, buf_info->len, buf_info->bb_addr,
-			  buf_info->p_addr);
-}
-
-static int get_nr_avail_ring_elements(struct mhi_controller *mhi_cntrl,
-				      struct mhi_ring *ring)
-{
-	int nr_el;
-
-	if (ring->wp < ring->rp) {
-		nr_el = ((ring->rp - ring->wp) / ring->el_size) - 1;
-	} else {
-		nr_el = (ring->rp - ring->base) / ring->el_size;
-		nr_el += ((ring->base + ring->len - ring->wp) /
-			  ring->el_size) - 1;
-	}
-
-	return nr_el;
-}
-
-static void *mhi_to_virtual(struct mhi_ring *ring, dma_addr_t addr)
-{
-	return (addr - ring->iommu_base) + ring->base;
-}
-
-static void mhi_add_ring_element(struct mhi_controller *mhi_cntrl,
-				 struct mhi_ring *ring)
-{
-	ring->wp += ring->el_size;
-	if (ring->wp >= (ring->base + ring->len))
-		ring->wp = ring->base;
-	/* smp update */
-	smp_wmb();
-}
-
-static void mhi_del_ring_element(struct mhi_controller *mhi_cntrl,
-				 struct mhi_ring *ring)
-{
-	ring->rp += ring->el_size;
-	if (ring->rp >= (ring->base + ring->len))
-		ring->rp = ring->base;
-	/* smp update */
-	smp_wmb();
-}
-
-static bool is_valid_ring_ptr(struct mhi_ring *ring, dma_addr_t addr)
-{
-	return addr >= ring->iommu_base && addr < ring->iommu_base + ring->len;
-}
-
-int mhi_destroy_device(struct device *dev, void *data)
-{
-	struct mhi_chan *ul_chan, *dl_chan;
-	struct mhi_device *mhi_dev;
-	struct mhi_controller *mhi_cntrl;
-	enum mhi_ee_type ee = MHI_EE_MAX;
-
-	if (dev->bus != &mhi_bus_type)
-		return 0;
-
-	mhi_dev = to_mhi_device(dev);
-	mhi_cntrl = mhi_dev->mhi_cntrl;
-
-	/* Only destroy virtual devices thats attached to bus */
-	if (mhi_dev->dev_type == MHI_DEVICE_CONTROLLER)
-		return 0;
-
-	ul_chan = mhi_dev->ul_chan;
-	dl_chan = mhi_dev->dl_chan;
-
-	/*
-	 * If execution environment is specified, remove only those devices that
-	 * started in them based on ee_mask for the channels as we move on to a
-	 * different execution environment
-	 */
-	if (data)
-		ee = *(enum mhi_ee_type *)data;
-
-	/*
-	 * For the suspend and resume case, this function will get called
-	 * without mhi_unregister_controller(). Hence, we need to drop the
-	 * references to mhi_dev created for ul and dl channels. We can
-	 * be sure that there will be no instances of mhi_dev left after
-	 * this.
-	 */
-	if (ul_chan) {
-		if (ee != MHI_EE_MAX && !(ul_chan->ee_mask & BIT(ee)))
-			return 0;
-
-		put_device(&ul_chan->mhi_dev->dev);
-	}
-
-	if (dl_chan) {
-		if (ee != MHI_EE_MAX && !(dl_chan->ee_mask & BIT(ee)))
-			return 0;
-
-		put_device(&dl_chan->mhi_dev->dev);
-	}
-
-	dev_dbg(&mhi_cntrl->mhi_dev->dev, "destroy device for chan:%s\n",
-		 mhi_dev->name);
-
-	/* Notify the client and remove the device from MHI bus */
-	device_del(dev);
-	put_device(dev);
-
-	return 0;
-}
-
-void mhi_notify(struct mhi_device *mhi_dev, enum mhi_callback cb_reason)
-{
-	struct mhi_driver *mhi_drv;
-
-	if (!mhi_dev->dev.driver)
-		return;
-
-	mhi_drv = to_mhi_driver(mhi_dev->dev.driver);
-
-	if (mhi_drv->status_cb)
-		mhi_drv->status_cb(mhi_dev, cb_reason);
-}
-EXPORT_SYMBOL_GPL(mhi_notify);
-
-/* Bind MHI channels to MHI devices */
-void mhi_create_devices(struct mhi_controller *mhi_cntrl)
-{
-	struct mhi_chan *mhi_chan;
-	struct mhi_device *mhi_dev;
-	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-	int i, ret;
-
-	mhi_chan = mhi_cntrl->mhi_chan;
-	for (i = 0; i < mhi_cntrl->max_chan; i++, mhi_chan++) {
-		if (!mhi_chan->configured || mhi_chan->mhi_dev ||
-		    !(mhi_chan->ee_mask & BIT(mhi_cntrl->ee)))
-			continue;
-		mhi_dev = mhi_alloc_device(mhi_cntrl);
-		if (IS_ERR(mhi_dev))
-			return;
-
-		mhi_dev->dev_type = MHI_DEVICE_XFER;
-		switch (mhi_chan->dir) {
-		case DMA_TO_DEVICE:
-			mhi_dev->ul_chan = mhi_chan;
-			mhi_dev->ul_chan_id = mhi_chan->chan;
-			break;
-		case DMA_FROM_DEVICE:
-			/* We use dl_chan as offload channels */
-			mhi_dev->dl_chan = mhi_chan;
-			mhi_dev->dl_chan_id = mhi_chan->chan;
-			break;
-		default:
-			dev_err(dev, "Direction not supported\n");
-			put_device(&mhi_dev->dev);
-			return;
-		}
-
-		get_device(&mhi_dev->dev);
-		mhi_chan->mhi_dev = mhi_dev;
-
-		/* Check next channel if it matches */
-		if ((i + 1) < mhi_cntrl->max_chan && mhi_chan[1].configured) {
-			if (!strcmp(mhi_chan[1].name, mhi_chan->name)) {
-				i++;
-				mhi_chan++;
-				if (mhi_chan->dir == DMA_TO_DEVICE) {
-					mhi_dev->ul_chan = mhi_chan;
-					mhi_dev->ul_chan_id = mhi_chan->chan;
-				} else {
-					mhi_dev->dl_chan = mhi_chan;
-					mhi_dev->dl_chan_id = mhi_chan->chan;
-				}
-				get_device(&mhi_dev->dev);
-				mhi_chan->mhi_dev = mhi_dev;
-			}
-		}
-
-		/* Channel name is same for both UL and DL */
-		mhi_dev->name = mhi_chan->name;
-		dev_set_name(&mhi_dev->dev, "%s_%s",
-			     dev_name(mhi_cntrl->cntrl_dev),
-			     mhi_dev->name);
-
-		/* Init wakeup source if available */
-		if (mhi_dev->dl_chan && mhi_dev->dl_chan->wake_capable)
-			device_init_wakeup(&mhi_dev->dev, true);
-
-		ret = device_add(&mhi_dev->dev);
-		if (ret)
-			put_device(&mhi_dev->dev);
-	}
-}
-
-irqreturn_t mhi_irq_handler(int irq_number, void *dev)
-{
-	struct mhi_event *mhi_event = dev;
-	struct mhi_controller *mhi_cntrl = mhi_event->mhi_cntrl;
-	struct mhi_event_ctxt *er_ctxt =
-		&mhi_cntrl->mhi_ctxt->er_ctxt[mhi_event->er_index];
-	struct mhi_ring *ev_ring = &mhi_event->ring;
-	dma_addr_t ptr = er_ctxt->rp;
-	void *dev_rp;
-
-	if (!is_valid_ring_ptr(ev_ring, ptr)) {
-		dev_err(&mhi_cntrl->mhi_dev->dev,
-			"Event ring rp points outside of the event ring\n");
-		return IRQ_HANDLED;
-	}
-
-	dev_rp = mhi_to_virtual(ev_ring, ptr);
-
-	/* Only proceed if event ring has pending events */
-	if (ev_ring->rp == dev_rp)
-		return IRQ_HANDLED;
-
-	/* For client managed event ring, notify pending data */
-	if (mhi_event->cl_manage) {
-		struct mhi_chan *mhi_chan = mhi_event->mhi_chan;
-		struct mhi_device *mhi_dev = mhi_chan->mhi_dev;
-
-		if (mhi_dev)
-			mhi_notify(mhi_dev, MHI_CB_PENDING_DATA);
-	} else {
-		tasklet_schedule(&mhi_event->task);
-	}
-
-	return IRQ_HANDLED;
-}
-
-irqreturn_t mhi_intvec_threaded_handler(int irq_number, void *priv)
-{
-	struct mhi_controller *mhi_cntrl = priv;
-	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-	enum mhi_state state = MHI_STATE_MAX;
-	enum mhi_pm_state pm_state = 0;
-	enum mhi_ee_type ee = 0;
-
-	write_lock_irq(&mhi_cntrl->pm_lock);
-	if (!MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state)) {
-		write_unlock_irq(&mhi_cntrl->pm_lock);
-		goto exit_intvec;
-	}
-
-	state = mhi_get_mhi_state(mhi_cntrl);
-	ee = mhi_cntrl->ee;
-	mhi_cntrl->ee = mhi_get_exec_env(mhi_cntrl);
-	dev_dbg(dev, "local ee:%s device ee:%s dev_state:%s\n",
-		TO_MHI_EXEC_STR(mhi_cntrl->ee), TO_MHI_EXEC_STR(ee),
-		TO_MHI_STATE_STR(state));
-
-	if (state == MHI_STATE_SYS_ERR) {
-		dev_dbg(dev, "System error detected\n");
-		pm_state = mhi_tryset_pm_state(mhi_cntrl,
-					       MHI_PM_SYS_ERR_DETECT);
-	}
-	write_unlock_irq(&mhi_cntrl->pm_lock);
-
-	 /* If device supports RDDM don't bother processing SYS error */
-	if (mhi_cntrl->rddm_image) {
-		if (mhi_cntrl->ee == MHI_EE_RDDM && mhi_cntrl->ee != ee) {
-			mhi_cntrl->status_cb(mhi_cntrl, MHI_CB_EE_RDDM);
-			wake_up_all(&mhi_cntrl->state_event);
-		}
-		goto exit_intvec;
-	}
-
-	if (pm_state == MHI_PM_SYS_ERR_DETECT) {
-		wake_up_all(&mhi_cntrl->state_event);
-
-		/* For fatal errors, we let controller decide next step */
-		if (MHI_IN_PBL(ee))
-			mhi_cntrl->status_cb(mhi_cntrl, MHI_CB_FATAL_ERROR);
-		else
-			mhi_pm_sys_err_handler(mhi_cntrl);
-	}
-
-exit_intvec:
-
-	return IRQ_HANDLED;
-}
-
-irqreturn_t mhi_intvec_handler(int irq_number, void *dev)
-{
-	struct mhi_controller *mhi_cntrl = dev;
-
-	/* Wake up events waiting for state change */
-	wake_up_all(&mhi_cntrl->state_event);
-
-	return IRQ_WAKE_THREAD;
-}
-
-static void mhi_recycle_ev_ring_element(struct mhi_controller *mhi_cntrl,
-					struct mhi_ring *ring)
-{
-	dma_addr_t ctxt_wp;
-
-	/* Update the WP */
-	ring->wp += ring->el_size;
-	ctxt_wp = *ring->ctxt_wp + ring->el_size;
-
-	if (ring->wp >= (ring->base + ring->len)) {
-		ring->wp = ring->base;
-		ctxt_wp = ring->iommu_base;
-	}
-
-	*ring->ctxt_wp = ctxt_wp;
-
-	/* Update the RP */
-	ring->rp += ring->el_size;
-	if (ring->rp >= (ring->base + ring->len))
-		ring->rp = ring->base;
-
-	/* Update to all cores */
-	smp_wmb();
-}
-
-static int parse_xfer_event(struct mhi_controller *mhi_cntrl,
-			    struct mhi_tre *event,
-			    struct mhi_chan *mhi_chan)
-{
-	struct mhi_ring *buf_ring, *tre_ring;
-	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-	struct mhi_result result;
-	unsigned long flags = 0;
-	u32 ev_code;
-
-	ev_code = MHI_TRE_GET_EV_CODE(event);
-	buf_ring = &mhi_chan->buf_ring;
-	tre_ring = &mhi_chan->tre_ring;
-
-	result.transaction_status = (ev_code == MHI_EV_CC_OVERFLOW) ?
-		-EOVERFLOW : 0;
-
-	/*
-	 * If it's a DB Event then we need to grab the lock
-	 * with preemption disabled and as a write because we
-	 * have to update db register and there are chances that
-	 * another thread could be doing the same.
-	 */
-	if (ev_code >= MHI_EV_CC_OOB)
-		write_lock_irqsave(&mhi_chan->lock, flags);
-	else
-		read_lock_bh(&mhi_chan->lock);
-
-	if (mhi_chan->ch_state != MHI_CH_STATE_ENABLED)
-		goto end_process_tx_event;
-
-	switch (ev_code) {
-	case MHI_EV_CC_OVERFLOW:
-	case MHI_EV_CC_EOB:
-	case MHI_EV_CC_EOT:
-	{
-		dma_addr_t ptr = MHI_TRE_GET_EV_PTR(event);
-		struct mhi_tre *local_rp, *ev_tre;
-		void *dev_rp;
-		struct mhi_buf_info *buf_info;
-		u16 xfer_len;
-
-		if (!is_valid_ring_ptr(tre_ring, ptr)) {
-			dev_err(&mhi_cntrl->mhi_dev->dev,
-				"Event element points outside of the tre ring\n");
-			break;
-		}
-		/* Get the TRB this event points to */
-		ev_tre = mhi_to_virtual(tre_ring, ptr);
-
-		dev_rp = ev_tre + 1;
-		if (dev_rp >= (tre_ring->base + tre_ring->len))
-			dev_rp = tre_ring->base;
-
-		result.dir = mhi_chan->dir;
-
-		local_rp = tre_ring->rp;
-		while (local_rp != dev_rp) {
-			buf_info = buf_ring->rp;
-			/* If it's the last TRE, get length from the event */
-			if (local_rp == ev_tre)
-				xfer_len = MHI_TRE_GET_EV_LEN(event);
-			else
-				xfer_len = buf_info->len;
-
-			/* Unmap if it's not pre-mapped by client */
-			if (likely(!buf_info->pre_mapped))
-				mhi_cntrl->unmap_single(mhi_cntrl, buf_info);
-
-			result.buf_addr = buf_info->cb_buf;
-
-			/* truncate to buf len if xfer_len is larger */
-			result.bytes_xferd =
-				min_t(u16, xfer_len, buf_info->len);
-			mhi_del_ring_element(mhi_cntrl, buf_ring);
-			mhi_del_ring_element(mhi_cntrl, tre_ring);
-			local_rp = tre_ring->rp;
-
-			/* notify client */
-			mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
-
-			if (mhi_chan->dir == DMA_TO_DEVICE)
-				atomic_dec(&mhi_cntrl->pending_pkts);
-
-			/*
-			 * Recycle the buffer if buffer is pre-allocated,
-			 * if there is an error, not much we can do apart
-			 * from dropping the packet
-			 */
-			if (mhi_chan->pre_alloc) {
-				if (mhi_queue_buf(mhi_chan->mhi_dev,
-						  mhi_chan->dir,
-						  buf_info->cb_buf,
-						  buf_info->len, MHI_EOT)) {
-					dev_err(dev,
-						"Error recycling buffer for chan:%d\n",
-						mhi_chan->chan);
-					kfree(buf_info->cb_buf);
-				}
-			}
-		}
-		break;
-	} /* CC_EOT */
-	case MHI_EV_CC_OOB:
-	case MHI_EV_CC_DB_MODE:
-	{
-		unsigned long flags;
-
-		mhi_chan->db_cfg.db_mode = 1;
-		read_lock_irqsave(&mhi_cntrl->pm_lock, flags);
-		if (tre_ring->wp != tre_ring->rp &&
-		    MHI_DB_ACCESS_VALID(mhi_cntrl)) {
-			mhi_ring_chan_db(mhi_cntrl, mhi_chan);
-		}
-		read_unlock_irqrestore(&mhi_cntrl->pm_lock, flags);
-		break;
-	}
-	case MHI_EV_CC_BAD_TRE:
-	default:
-		dev_err(dev, "Unknown event 0x%x\n", ev_code);
-		break;
-	} /* switch(MHI_EV_READ_CODE(EV_TRB_CODE,event)) */
-
-end_process_tx_event:
-	if (ev_code >= MHI_EV_CC_OOB)
-		write_unlock_irqrestore(&mhi_chan->lock, flags);
-	else
-		read_unlock_bh(&mhi_chan->lock);
-
-	return 0;
-}
-
-static int parse_rsc_event(struct mhi_controller *mhi_cntrl,
-			   struct mhi_tre *event,
-			   struct mhi_chan *mhi_chan)
-{
-	struct mhi_ring *buf_ring, *tre_ring;
-	struct mhi_buf_info *buf_info;
-	struct mhi_result result;
-	int ev_code;
-	u32 cookie; /* offset to local descriptor */
-	u16 xfer_len;
-
-	buf_ring = &mhi_chan->buf_ring;
-	tre_ring = &mhi_chan->tre_ring;
-
-	ev_code = MHI_TRE_GET_EV_CODE(event);
-	cookie = MHI_TRE_GET_EV_COOKIE(event);
-	xfer_len = MHI_TRE_GET_EV_LEN(event);
-
-	/* Received out of bound cookie */
-	WARN_ON(cookie >= buf_ring->len);
-
-	buf_info = buf_ring->base + cookie;
-
-	result.transaction_status = (ev_code == MHI_EV_CC_OVERFLOW) ?
-		-EOVERFLOW : 0;
-
-	/* truncate to buf len if xfer_len is larger */
-	result.bytes_xferd = min_t(u16, xfer_len, buf_info->len);
-	result.buf_addr = buf_info->cb_buf;
-	result.dir = mhi_chan->dir;
-
-	read_lock_bh(&mhi_chan->lock);
-
-	if (mhi_chan->ch_state != MHI_CH_STATE_ENABLED)
-		goto end_process_rsc_event;
-
-	WARN_ON(!buf_info->used);
-
-	/* notify the client */
-	mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
-
-	/*
-	 * Note: We're arbitrarily incrementing RP even though, completion
-	 * packet we processed might not be the same one, reason we can do this
-	 * is because device guaranteed to cache descriptors in order it
-	 * receive, so even though completion event is different we can re-use
-	 * all descriptors in between.
-	 * Example:
-	 * Transfer Ring has descriptors: A, B, C, D
-	 * Last descriptor host queue is D (WP) and first descriptor
-	 * host queue is A (RP).
-	 * The completion event we just serviced is descriptor C.
-	 * Then we can safely queue descriptors to replace A, B, and C
-	 * even though host did not receive any completions.
-	 */
-	mhi_del_ring_element(mhi_cntrl, tre_ring);
-	buf_info->used = false;
-
-end_process_rsc_event:
-	read_unlock_bh(&mhi_chan->lock);
-
-	return 0;
-}
-
-static void mhi_process_cmd_completion(struct mhi_controller *mhi_cntrl,
-				       struct mhi_tre *tre)
-{
-	dma_addr_t ptr = MHI_TRE_GET_EV_PTR(tre);
-	struct mhi_cmd *cmd_ring = &mhi_cntrl->mhi_cmd[PRIMARY_CMD_RING];
-	struct mhi_ring *mhi_ring = &cmd_ring->ring;
-	struct mhi_tre *cmd_pkt;
-	struct mhi_chan *mhi_chan;
-	u32 chan;
-
-	if (!is_valid_ring_ptr(mhi_ring, ptr)) {
-		dev_err(&mhi_cntrl->mhi_dev->dev,
-			"Event element points outside of the cmd ring\n");
-		return;
-	}
-
-	cmd_pkt = mhi_to_virtual(mhi_ring, ptr);
-
-	chan = MHI_TRE_GET_CMD_CHID(cmd_pkt);
-
-	if (chan < mhi_cntrl->max_chan &&
-	    mhi_cntrl->mhi_chan[chan].configured) {
-		mhi_chan = &mhi_cntrl->mhi_chan[chan];
-		write_lock_bh(&mhi_chan->lock);
-		mhi_chan->ccs = MHI_TRE_GET_EV_CODE(tre);
-		complete(&mhi_chan->completion);
-		write_unlock_bh(&mhi_chan->lock);
-	} else {
-		dev_err(&mhi_cntrl->mhi_dev->dev,
-			"Completion packet for invalid channel ID: %d\n", chan);
-	}
-
-	mhi_del_ring_element(mhi_cntrl, mhi_ring);
-}
-
-int mhi_process_ctrl_ev_ring(struct mhi_controller *mhi_cntrl,
-			     struct mhi_event *mhi_event,
-			     u32 event_quota)
-{
-	struct mhi_tre *dev_rp, *local_rp;
-	struct mhi_ring *ev_ring = &mhi_event->ring;
-	struct mhi_event_ctxt *er_ctxt =
-		&mhi_cntrl->mhi_ctxt->er_ctxt[mhi_event->er_index];
-	struct mhi_chan *mhi_chan;
-	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-	u32 chan;
-	int count = 0;
-	dma_addr_t ptr = er_ctxt->rp;
-
-	/*
-	 * This is a quick check to avoid unnecessary event processing
-	 * in case MHI is already in error state, but it's still possible
-	 * to transition to error state while processing events
-	 */
-	if (unlikely(MHI_EVENT_ACCESS_INVALID(mhi_cntrl->pm_state)))
-		return -EIO;
-
-	if (!is_valid_ring_ptr(ev_ring, ptr)) {
-		dev_err(&mhi_cntrl->mhi_dev->dev,
-			"Event ring rp points outside of the event ring\n");
-		return -EIO;
-	}
-
-	dev_rp = mhi_to_virtual(ev_ring, ptr);
-	local_rp = ev_ring->rp;
-
-	while (dev_rp != local_rp) {
-		enum mhi_pkt_type type = MHI_TRE_GET_EV_TYPE(local_rp);
-
-		switch (type) {
-		case MHI_PKT_TYPE_BW_REQ_EVENT:
-		{
-			struct mhi_link_info *link_info;
-
-			link_info = &mhi_cntrl->mhi_link_info;
-			write_lock_irq(&mhi_cntrl->pm_lock);
-			link_info->target_link_speed =
-				MHI_TRE_GET_EV_LINKSPEED(local_rp);
-			link_info->target_link_width =
-				MHI_TRE_GET_EV_LINKWIDTH(local_rp);
-			write_unlock_irq(&mhi_cntrl->pm_lock);
-			dev_dbg(dev, "Received BW_REQ event\n");
-			mhi_cntrl->status_cb(mhi_cntrl, MHI_CB_BW_REQ);
-			break;
-		}
-		case MHI_PKT_TYPE_STATE_CHANGE_EVENT:
-		{
-			enum mhi_state new_state;
-
-			new_state = MHI_TRE_GET_EV_STATE(local_rp);
-
-			dev_dbg(dev, "State change event to state: %s\n",
-				TO_MHI_STATE_STR(new_state));
-
-			switch (new_state) {
-			case MHI_STATE_M0:
-				mhi_pm_m0_transition(mhi_cntrl);
-				break;
-			case MHI_STATE_M1:
-				mhi_pm_m1_transition(mhi_cntrl);
-				break;
-			case MHI_STATE_M3:
-				mhi_pm_m3_transition(mhi_cntrl);
-				break;
-			case MHI_STATE_SYS_ERR:
-			{
-				enum mhi_pm_state new_state;
-
-				/* skip SYS_ERROR handling if RDDM supported */
-				if (mhi_cntrl->ee == MHI_EE_RDDM ||
-				    mhi_cntrl->rddm_image)
-					break;
-
-				dev_dbg(dev, "System error detected\n");
-				write_lock_irq(&mhi_cntrl->pm_lock);
-				new_state = mhi_tryset_pm_state(mhi_cntrl,
-							MHI_PM_SYS_ERR_DETECT);
-				write_unlock_irq(&mhi_cntrl->pm_lock);
-				if (new_state == MHI_PM_SYS_ERR_DETECT)
-					mhi_pm_sys_err_handler(mhi_cntrl);
-				break;
-			}
-			default:
-				dev_err(dev, "Invalid state: %s\n",
-					TO_MHI_STATE_STR(new_state));
-			}
-
-			break;
-		}
-		case MHI_PKT_TYPE_CMD_COMPLETION_EVENT:
-			mhi_process_cmd_completion(mhi_cntrl, local_rp);
-			break;
-		case MHI_PKT_TYPE_EE_EVENT:
-		{
-			enum dev_st_transition st = DEV_ST_TRANSITION_MAX;
-			enum mhi_ee_type event = MHI_TRE_GET_EV_EXECENV(local_rp);
-
-			dev_dbg(dev, "Received EE event: %s\n",
-				TO_MHI_EXEC_STR(event));
-			switch (event) {
-			case MHI_EE_SBL:
-				st = DEV_ST_TRANSITION_SBL;
-				break;
-			case MHI_EE_WFW:
-			case MHI_EE_AMSS:
-				st = DEV_ST_TRANSITION_MISSION_MODE;
-				break;
-			case MHI_EE_RDDM:
-				mhi_cntrl->status_cb(mhi_cntrl, MHI_CB_EE_RDDM);
-				write_lock_irq(&mhi_cntrl->pm_lock);
-				mhi_cntrl->ee = event;
-				write_unlock_irq(&mhi_cntrl->pm_lock);
-				wake_up_all(&mhi_cntrl->state_event);
-				break;
-			default:
-				dev_err(dev,
-					"Unhandled EE event: 0x%x\n", type);
-			}
-			if (st != DEV_ST_TRANSITION_MAX)
-				mhi_queue_state_transition(mhi_cntrl, st);
-
-			break;
-		}
-		case MHI_PKT_TYPE_TX_EVENT:
-			chan = MHI_TRE_GET_EV_CHID(local_rp);
-
-			WARN_ON(chan >= mhi_cntrl->max_chan);
-
-			/*
-			 * Only process the event ring elements whose channel
-			 * ID is within the maximum supported range.
-			 */
-			if (chan < mhi_cntrl->max_chan) {
-				mhi_chan = &mhi_cntrl->mhi_chan[chan];
-				if (!mhi_chan->configured)
-					break;
-				parse_xfer_event(mhi_cntrl, local_rp, mhi_chan);
-				event_quota--;
-			}
-			break;
-		default:
-			dev_err(dev, "Unhandled event type: %d\n", type);
-			break;
-		}
-
-		mhi_recycle_ev_ring_element(mhi_cntrl, ev_ring);
-		local_rp = ev_ring->rp;
-
-		ptr = er_ctxt->rp;
-		if (!is_valid_ring_ptr(ev_ring, ptr)) {
-			dev_err(&mhi_cntrl->mhi_dev->dev,
-				"Event ring rp points outside of the event ring\n");
-			return -EIO;
-		}
-
-		dev_rp = mhi_to_virtual(ev_ring, ptr);
-		count++;
-	}
-
-	read_lock_bh(&mhi_cntrl->pm_lock);
-	if (likely(MHI_DB_ACCESS_VALID(mhi_cntrl)))
-		mhi_ring_er_db(mhi_event);
-	read_unlock_bh(&mhi_cntrl->pm_lock);
-
-	return count;
-}
-
-int mhi_process_data_event_ring(struct mhi_controller *mhi_cntrl,
-				struct mhi_event *mhi_event,
-				u32 event_quota)
-{
-	struct mhi_tre *dev_rp, *local_rp;
-	struct mhi_ring *ev_ring = &mhi_event->ring;
-	struct mhi_event_ctxt *er_ctxt =
-		&mhi_cntrl->mhi_ctxt->er_ctxt[mhi_event->er_index];
-	int count = 0;
-	u32 chan;
-	struct mhi_chan *mhi_chan;
-	dma_addr_t ptr = er_ctxt->rp;
-
-	if (unlikely(MHI_EVENT_ACCESS_INVALID(mhi_cntrl->pm_state)))
-		return -EIO;
-
-	if (!is_valid_ring_ptr(ev_ring, ptr)) {
-		dev_err(&mhi_cntrl->mhi_dev->dev,
-			"Event ring rp points outside of the event ring\n");
-		return -EIO;
-	}
-
-	dev_rp = mhi_to_virtual(ev_ring, ptr);
-	local_rp = ev_ring->rp;
-
-	while (dev_rp != local_rp && event_quota > 0) {
-		enum mhi_pkt_type type = MHI_TRE_GET_EV_TYPE(local_rp);
-
-		chan = MHI_TRE_GET_EV_CHID(local_rp);
-
-		WARN_ON(chan >= mhi_cntrl->max_chan);
-
-		/*
-		 * Only process the event ring elements whose channel
-		 * ID is within the maximum supported range.
-		 */
-		if (chan < mhi_cntrl->max_chan &&
-		    mhi_cntrl->mhi_chan[chan].configured) {
-			mhi_chan = &mhi_cntrl->mhi_chan[chan];
-
-			if (likely(type == MHI_PKT_TYPE_TX_EVENT)) {
-				parse_xfer_event(mhi_cntrl, local_rp, mhi_chan);
-				event_quota--;
-			} else if (type == MHI_PKT_TYPE_RSC_TX_EVENT) {
-				parse_rsc_event(mhi_cntrl, local_rp, mhi_chan);
-				event_quota--;
-			}
-		}
-
-		mhi_recycle_ev_ring_element(mhi_cntrl, ev_ring);
-		local_rp = ev_ring->rp;
-
-		ptr = er_ctxt->rp;
-		if (!is_valid_ring_ptr(ev_ring, ptr)) {
-			dev_err(&mhi_cntrl->mhi_dev->dev,
-				"Event ring rp points outside of the event ring\n");
-			return -EIO;
-		}
-
-		dev_rp = mhi_to_virtual(ev_ring, ptr);
-		count++;
-	}
-	read_lock_bh(&mhi_cntrl->pm_lock);
-	if (likely(MHI_DB_ACCESS_VALID(mhi_cntrl)))
-		mhi_ring_er_db(mhi_event);
-	read_unlock_bh(&mhi_cntrl->pm_lock);
-
-	return count;
-}
-
-void mhi_ev_task(unsigned long data)
-{
-	struct mhi_event *mhi_event = (struct mhi_event *)data;
-	struct mhi_controller *mhi_cntrl = mhi_event->mhi_cntrl;
-
-	/* process all pending events */
-	spin_lock_bh(&mhi_event->lock);
-	mhi_event->process_event(mhi_cntrl, mhi_event, U32_MAX);
-	spin_unlock_bh(&mhi_event->lock);
-}
-
-void mhi_ctrl_ev_task(unsigned long data)
-{
-	struct mhi_event *mhi_event = (struct mhi_event *)data;
-	struct mhi_controller *mhi_cntrl = mhi_event->mhi_cntrl;
-	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-	enum mhi_state state;
-	enum mhi_pm_state pm_state = 0;
-	int ret;
-
-	/*
-	 * We can check PM state w/o a lock here because there is no way
-	 * PM state can change from reg access valid to no access while this
-	 * thread being executed.
-	 */
-	if (!MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state)) {
-		/*
-		 * We may have a pending event but not allowed to
-		 * process it since we are probably in a suspended state,
-		 * so trigger a resume.
-		 */
-		mhi_trigger_resume(mhi_cntrl);
-
-		return;
-	}
-
-	/* Process ctrl events events */
-	ret = mhi_event->process_event(mhi_cntrl, mhi_event, U32_MAX);
-
-	/*
-	 * We received an IRQ but no events to process, maybe device went to
-	 * SYS_ERR state? Check the state to confirm.
-	 */
-	if (!ret) {
-		write_lock_irq(&mhi_cntrl->pm_lock);
-		state = mhi_get_mhi_state(mhi_cntrl);
-		if (state == MHI_STATE_SYS_ERR) {
-			dev_dbg(dev, "System error detected\n");
-			pm_state = mhi_tryset_pm_state(mhi_cntrl,
-						       MHI_PM_SYS_ERR_DETECT);
-		}
-		write_unlock_irq(&mhi_cntrl->pm_lock);
-		if (pm_state == MHI_PM_SYS_ERR_DETECT)
-			mhi_pm_sys_err_handler(mhi_cntrl);
-	}
-}
-
-static bool mhi_is_ring_full(struct mhi_controller *mhi_cntrl,
-			     struct mhi_ring *ring)
-{
-	void *tmp = ring->wp + ring->el_size;
-
-	if (tmp >= (ring->base + ring->len))
-		tmp = ring->base;
-
-	return (tmp == ring->rp);
-}
-
-int mhi_queue_skb(struct mhi_device *mhi_dev, enum dma_data_direction dir,
-		  struct sk_buff *skb, size_t len, enum mhi_flags mflags)
-{
-	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
-	struct mhi_chan *mhi_chan = (dir == DMA_TO_DEVICE) ? mhi_dev->ul_chan :
-							     mhi_dev->dl_chan;
-	struct mhi_ring *tre_ring = &mhi_chan->tre_ring;
-	struct mhi_buf_info buf_info = { };
-	int ret;
-
-	/* If MHI host pre-allocates buffers then client drivers cannot queue */
-	if (mhi_chan->pre_alloc)
-		return -EINVAL;
-
-	if (mhi_is_ring_full(mhi_cntrl, tre_ring))
-		return -ENOMEM;
-
-	read_lock_bh(&mhi_cntrl->pm_lock);
-	if (unlikely(MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state))) {
-		read_unlock_bh(&mhi_cntrl->pm_lock);
-		return -EIO;
-	}
-
-	/* we're in M3 or transitioning to M3 */
-	if (MHI_PM_IN_SUSPEND_STATE(mhi_cntrl->pm_state))
-		mhi_trigger_resume(mhi_cntrl);
-
-	/* Toggle wake to exit out of M2 */
-	mhi_cntrl->wake_toggle(mhi_cntrl);
-
-	buf_info.v_addr = skb->data;
-	buf_info.cb_buf = skb;
-	buf_info.len = len;
-
-	ret = mhi_gen_tre(mhi_cntrl, mhi_chan, &buf_info, mflags);
-	if (unlikely(ret)) {
-		read_unlock_bh(&mhi_cntrl->pm_lock);
-		return ret;
-	}
-
-	if (mhi_chan->dir == DMA_TO_DEVICE)
-		atomic_inc(&mhi_cntrl->pending_pkts);
-
-	if (likely(MHI_DB_ACCESS_VALID(mhi_cntrl))) {
-		read_lock_bh(&mhi_chan->lock);
-		mhi_ring_chan_db(mhi_cntrl, mhi_chan);
-		read_unlock_bh(&mhi_chan->lock);
-	}
-
-	read_unlock_bh(&mhi_cntrl->pm_lock);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(mhi_queue_skb);
-
-int mhi_queue_dma(struct mhi_device *mhi_dev, enum dma_data_direction dir,
-		  struct mhi_buf *mhi_buf, size_t len, enum mhi_flags mflags)
-{
-	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
-	struct mhi_chan *mhi_chan = (dir == DMA_TO_DEVICE) ? mhi_dev->ul_chan :
-							     mhi_dev->dl_chan;
-	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-	struct mhi_ring *tre_ring = &mhi_chan->tre_ring;
-	struct mhi_buf_info buf_info = { };
-	int ret;
-
-	/* If MHI host pre-allocates buffers then client drivers cannot queue */
-	if (mhi_chan->pre_alloc)
-		return -EINVAL;
-
-	if (mhi_is_ring_full(mhi_cntrl, tre_ring))
-		return -ENOMEM;
-
-	read_lock_bh(&mhi_cntrl->pm_lock);
-	if (unlikely(MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state))) {
-		dev_err(dev, "MHI is not in activate state, PM state: %s\n",
-			to_mhi_pm_state_str(mhi_cntrl->pm_state));
-		read_unlock_bh(&mhi_cntrl->pm_lock);
-
-		return -EIO;
-	}
-
-	/* we're in M3 or transitioning to M3 */
-	if (MHI_PM_IN_SUSPEND_STATE(mhi_cntrl->pm_state))
-		mhi_trigger_resume(mhi_cntrl);
-
-	/* Toggle wake to exit out of M2 */
-	mhi_cntrl->wake_toggle(mhi_cntrl);
-
-	buf_info.p_addr = mhi_buf->dma_addr;
-	buf_info.cb_buf = mhi_buf;
-	buf_info.pre_mapped = true;
-	buf_info.len = len;
-
-	ret = mhi_gen_tre(mhi_cntrl, mhi_chan, &buf_info, mflags);
-	if (unlikely(ret)) {
-		read_unlock_bh(&mhi_cntrl->pm_lock);
-		return ret;
-	}
-
-	if (mhi_chan->dir == DMA_TO_DEVICE)
-		atomic_inc(&mhi_cntrl->pending_pkts);
-
-	if (likely(MHI_DB_ACCESS_VALID(mhi_cntrl))) {
-		read_lock_bh(&mhi_chan->lock);
-		mhi_ring_chan_db(mhi_cntrl, mhi_chan);
-		read_unlock_bh(&mhi_chan->lock);
-	}
-
-	read_unlock_bh(&mhi_cntrl->pm_lock);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(mhi_queue_dma);
-
-int mhi_gen_tre(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan,
-			struct mhi_buf_info *info, enum mhi_flags flags)
-{
-	struct mhi_ring *buf_ring, *tre_ring;
-	struct mhi_tre *mhi_tre;
-	struct mhi_buf_info *buf_info;
-	int eot, eob, chain, bei;
-	int ret;
-
-	buf_ring = &mhi_chan->buf_ring;
-	tre_ring = &mhi_chan->tre_ring;
-
-	buf_info = buf_ring->wp;
-	WARN_ON(buf_info->used);
-	buf_info->pre_mapped = info->pre_mapped;
-	if (info->pre_mapped)
-		buf_info->p_addr = info->p_addr;
-	else
-		buf_info->v_addr = info->v_addr;
-	buf_info->cb_buf = info->cb_buf;
-	buf_info->wp = tre_ring->wp;
-	buf_info->dir = mhi_chan->dir;
-	buf_info->len = info->len;
-
-	if (!info->pre_mapped) {
-		ret = mhi_cntrl->map_single(mhi_cntrl, buf_info);
-		if (ret)
-			return ret;
-	}
-
-	eob = !!(flags & MHI_EOB);
-	eot = !!(flags & MHI_EOT);
-	chain = !!(flags & MHI_CHAIN);
-	bei = !!(mhi_chan->intmod);
-
-	mhi_tre = tre_ring->wp;
-	mhi_tre->ptr = MHI_TRE_DATA_PTR(buf_info->p_addr);
-	mhi_tre->dword[0] = MHI_TRE_DATA_DWORD0(info->len);
-	mhi_tre->dword[1] = MHI_TRE_DATA_DWORD1(bei, eot, eob, chain);
-
-	/* increment WP */
-	mhi_add_ring_element(mhi_cntrl, tre_ring);
-	mhi_add_ring_element(mhi_cntrl, buf_ring);
-
-	return 0;
-}
-
-int mhi_queue_buf(struct mhi_device *mhi_dev, enum dma_data_direction dir,
-		  void *buf, size_t len, enum mhi_flags mflags)
-{
-	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
-	struct mhi_chan *mhi_chan = (dir == DMA_TO_DEVICE) ? mhi_dev->ul_chan :
-							     mhi_dev->dl_chan;
-	struct mhi_ring *tre_ring;
-	struct mhi_buf_info buf_info = { };
-	unsigned long flags;
-	int ret;
-
-	/*
-	 * this check here only as a guard, it's always
-	 * possible mhi can enter error while executing rest of function,
-	 * which is not fatal so we do not need to hold pm_lock
-	 */
-	if (unlikely(MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)))
-		return -EIO;
-
-	tre_ring = &mhi_chan->tre_ring;
-	if (mhi_is_ring_full(mhi_cntrl, tre_ring))
-		return -ENOMEM;
-
-	buf_info.v_addr = buf;
-	buf_info.cb_buf = buf;
-	buf_info.len = len;
-
-	ret = mhi_gen_tre(mhi_cntrl, mhi_chan, &buf_info, mflags);
-	if (unlikely(ret))
-		return ret;
-
-	read_lock_irqsave(&mhi_cntrl->pm_lock, flags);
-
-	/* we're in M3 or transitioning to M3 */
-	if (MHI_PM_IN_SUSPEND_STATE(mhi_cntrl->pm_state))
-		mhi_trigger_resume(mhi_cntrl);
-
-	/* Toggle wake to exit out of M2 */
-	mhi_cntrl->wake_toggle(mhi_cntrl);
-
-	if (mhi_chan->dir == DMA_TO_DEVICE)
-		atomic_inc(&mhi_cntrl->pending_pkts);
-
-	if (likely(MHI_DB_ACCESS_VALID(mhi_cntrl))) {
-		unsigned long flags;
-
-		read_lock_irqsave(&mhi_chan->lock, flags);
-		mhi_ring_chan_db(mhi_cntrl, mhi_chan);
-		read_unlock_irqrestore(&mhi_chan->lock, flags);
-	}
-
-	read_unlock_irqrestore(&mhi_cntrl->pm_lock, flags);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(mhi_queue_buf);
-
-int mhi_send_cmd(struct mhi_controller *mhi_cntrl,
-		 struct mhi_chan *mhi_chan,
-		 enum mhi_cmd_type cmd)
-{
-	struct mhi_tre *cmd_tre = NULL;
-	struct mhi_cmd *mhi_cmd = &mhi_cntrl->mhi_cmd[PRIMARY_CMD_RING];
-	struct mhi_ring *ring = &mhi_cmd->ring;
-	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-	int chan = 0;
-
-	if (mhi_chan)
-		chan = mhi_chan->chan;
-
-	spin_lock_bh(&mhi_cmd->lock);
-	if (!get_nr_avail_ring_elements(mhi_cntrl, ring)) {
-		spin_unlock_bh(&mhi_cmd->lock);
-		return -ENOMEM;
-	}
-
-	/* prepare the cmd tre */
-	cmd_tre = ring->wp;
-	switch (cmd) {
-	case MHI_CMD_RESET_CHAN:
-		cmd_tre->ptr = MHI_TRE_CMD_RESET_PTR;
-		cmd_tre->dword[0] = MHI_TRE_CMD_RESET_DWORD0;
-		cmd_tre->dword[1] = MHI_TRE_CMD_RESET_DWORD1(chan);
-		break;
-	case MHI_CMD_START_CHAN:
-		cmd_tre->ptr = MHI_TRE_CMD_START_PTR;
-		cmd_tre->dword[0] = MHI_TRE_CMD_START_DWORD0;
-		cmd_tre->dword[1] = MHI_TRE_CMD_START_DWORD1(chan);
-		break;
-	default:
-		dev_err(dev, "Command not supported\n");
-		break;
-	}
-
-	/* queue to hardware */
-	mhi_add_ring_element(mhi_cntrl, ring);
-	read_lock_bh(&mhi_cntrl->pm_lock);
-	if (likely(MHI_DB_ACCESS_VALID(mhi_cntrl)))
-		mhi_ring_cmd_db(mhi_cntrl, mhi_cmd);
-	read_unlock_bh(&mhi_cntrl->pm_lock);
-	spin_unlock_bh(&mhi_cmd->lock);
-
-	return 0;
-}
-
-static void __mhi_unprepare_channel(struct mhi_controller *mhi_cntrl,
-				    struct mhi_chan *mhi_chan)
-{
-	int ret;
-	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-
-	dev_dbg(dev, "Entered: unprepare channel:%d\n", mhi_chan->chan);
-
-	/* no more processing events for this channel */
-	mutex_lock(&mhi_chan->mutex);
-	write_lock_irq(&mhi_chan->lock);
-	if (mhi_chan->ch_state != MHI_CH_STATE_ENABLED) {
-		write_unlock_irq(&mhi_chan->lock);
-		mutex_unlock(&mhi_chan->mutex);
-		return;
-	}
-
-	mhi_chan->ch_state = MHI_CH_STATE_DISABLED;
-	write_unlock_irq(&mhi_chan->lock);
-
-	reinit_completion(&mhi_chan->completion);
-	read_lock_bh(&mhi_cntrl->pm_lock);
-	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
-		read_unlock_bh(&mhi_cntrl->pm_lock);
-		goto error_invalid_state;
-	}
-
-	mhi_cntrl->wake_toggle(mhi_cntrl);
-	read_unlock_bh(&mhi_cntrl->pm_lock);
-
-	mhi_cntrl->runtime_get(mhi_cntrl);
-	mhi_cntrl->runtime_put(mhi_cntrl);
-	ret = mhi_send_cmd(mhi_cntrl, mhi_chan, MHI_CMD_RESET_CHAN);
-	if (ret)
-		goto error_invalid_state;
-
-	/* even if it fails we will still reset */
-	ret = wait_for_completion_timeout(&mhi_chan->completion,
-				msecs_to_jiffies(mhi_cntrl->timeout_ms));
-	if (!ret || mhi_chan->ccs != MHI_EV_CC_SUCCESS)
-		dev_err(dev,
-			"Failed to receive cmd completion, still resetting\n");
-
-error_invalid_state:
-	if (!mhi_chan->offload_ch) {
-		mhi_reset_chan(mhi_cntrl, mhi_chan);
-		mhi_deinit_chan_ctxt(mhi_cntrl, mhi_chan);
-	}
-	dev_dbg(dev, "chan:%d successfully resetted\n", mhi_chan->chan);
-	mutex_unlock(&mhi_chan->mutex);
-}
-
-int mhi_prepare_channel(struct mhi_controller *mhi_cntrl,
-			struct mhi_chan *mhi_chan)
-{
-	int ret = 0;
-	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-
-	dev_dbg(dev, "Preparing channel: %d\n", mhi_chan->chan);
-
-	if (!(BIT(mhi_cntrl->ee) & mhi_chan->ee_mask)) {
-		dev_err(dev,
-			"Current EE: %s Required EE Mask: 0x%x for chan: %s\n",
-			TO_MHI_EXEC_STR(mhi_cntrl->ee), mhi_chan->ee_mask,
-			mhi_chan->name);
-		return -ENOTCONN;
-	}
-
-	mutex_lock(&mhi_chan->mutex);
-
-	/* If channel is not in disable state, do not allow it to start */
-	if (mhi_chan->ch_state != MHI_CH_STATE_DISABLED) {
-		ret = -EIO;
-		dev_dbg(dev, "channel: %d is not in disabled state\n",
-			mhi_chan->chan);
-		goto error_init_chan;
-	}
-
-	/* Check of client manages channel context for offload channels */
-	if (!mhi_chan->offload_ch) {
-		ret = mhi_init_chan_ctxt(mhi_cntrl, mhi_chan);
-		if (ret)
-			goto error_init_chan;
-	}
-
-	reinit_completion(&mhi_chan->completion);
-	read_lock_bh(&mhi_cntrl->pm_lock);
-	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
-		read_unlock_bh(&mhi_cntrl->pm_lock);
-		ret = -EIO;
-		goto error_pm_state;
-	}
-
-	mhi_cntrl->wake_toggle(mhi_cntrl);
-	read_unlock_bh(&mhi_cntrl->pm_lock);
-	mhi_cntrl->runtime_get(mhi_cntrl);
-	mhi_cntrl->runtime_put(mhi_cntrl);
-
-	ret = mhi_send_cmd(mhi_cntrl, mhi_chan, MHI_CMD_START_CHAN);
-	if (ret)
-		goto error_pm_state;
-
-	ret = wait_for_completion_timeout(&mhi_chan->completion,
-				msecs_to_jiffies(mhi_cntrl->timeout_ms));
-	if (!ret || mhi_chan->ccs != MHI_EV_CC_SUCCESS) {
-		ret = -EIO;
-		goto error_pm_state;
-	}
-
-	write_lock_irq(&mhi_chan->lock);
-	mhi_chan->ch_state = MHI_CH_STATE_ENABLED;
-	write_unlock_irq(&mhi_chan->lock);
-
-	/* Pre-allocate buffer for xfer ring */
-	if (mhi_chan->pre_alloc) {
-		int nr_el = get_nr_avail_ring_elements(mhi_cntrl,
-						       &mhi_chan->tre_ring);
-		size_t len = mhi_cntrl->buffer_len;
-
-		while (nr_el--) {
-			void *buf;
-			struct mhi_buf_info info = { };
-			buf = kmalloc(len, GFP_KERNEL);
-			if (!buf) {
-				ret = -ENOMEM;
-				goto error_pre_alloc;
-			}
-
-			/* Prepare transfer descriptors */
-			info.v_addr = buf;
-			info.cb_buf = buf;
-			info.len = len;
-			ret = mhi_gen_tre(mhi_cntrl, mhi_chan, &info, MHI_EOT);
-			if (ret) {
-				kfree(buf);
-				goto error_pre_alloc;
-			}
-		}
-
-		read_lock_bh(&mhi_cntrl->pm_lock);
-		if (MHI_DB_ACCESS_VALID(mhi_cntrl)) {
-			read_lock_irq(&mhi_chan->lock);
-			mhi_ring_chan_db(mhi_cntrl, mhi_chan);
-			read_unlock_irq(&mhi_chan->lock);
-		}
-		read_unlock_bh(&mhi_cntrl->pm_lock);
-	}
-
-	mutex_unlock(&mhi_chan->mutex);
-
-	dev_dbg(dev, "Chan: %d successfully moved to start state\n",
-		mhi_chan->chan);
-
-	return 0;
-
-error_pm_state:
-	if (!mhi_chan->offload_ch)
-		mhi_deinit_chan_ctxt(mhi_cntrl, mhi_chan);
-
-error_init_chan:
-	mutex_unlock(&mhi_chan->mutex);
-
-	return ret;
-
-error_pre_alloc:
-	mutex_unlock(&mhi_chan->mutex);
-	__mhi_unprepare_channel(mhi_cntrl, mhi_chan);
-
-	return ret;
-}
-
-static void mhi_mark_stale_events(struct mhi_controller *mhi_cntrl,
-				  struct mhi_event *mhi_event,
-				  struct mhi_event_ctxt *er_ctxt,
-				  int chan)
-
-{
-	struct mhi_tre *dev_rp, *local_rp;
-	struct mhi_ring *ev_ring;
-	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-	unsigned long flags;
-	dma_addr_t ptr;
-
-	dev_dbg(dev, "Marking all events for chan: %d as stale\n", chan);
-
-	ev_ring = &mhi_event->ring;
-
-	/* mark all stale events related to channel as STALE event */
-	spin_lock_irqsave(&mhi_event->lock, flags);
-
-	ptr = er_ctxt->rp;
-	if (!is_valid_ring_ptr(ev_ring, ptr)) {
-		dev_err(&mhi_cntrl->mhi_dev->dev,
-			"Event ring rp points outside of the event ring\n");
-		dev_rp = ev_ring->rp;
-	} else {
-		dev_rp = mhi_to_virtual(ev_ring, ptr);
-	}
-
-	local_rp = ev_ring->rp;
-	while (dev_rp != local_rp) {
-		if (MHI_TRE_GET_EV_TYPE(local_rp) == MHI_PKT_TYPE_TX_EVENT &&
-		    chan == MHI_TRE_GET_EV_CHID(local_rp))
-			local_rp->dword[1] = MHI_TRE_EV_DWORD1(chan,
-					MHI_PKT_TYPE_STALE_EVENT);
-		local_rp++;
-		if (local_rp == (ev_ring->base + ev_ring->len))
-			local_rp = ev_ring->base;
-	}
-
-	dev_dbg(dev, "Finished marking events as stale events\n");
-	spin_unlock_irqrestore(&mhi_event->lock, flags);
-}
-
-static void mhi_reset_data_chan(struct mhi_controller *mhi_cntrl,
-				struct mhi_chan *mhi_chan)
-{
-	struct mhi_ring *buf_ring, *tre_ring;
-	struct mhi_result result;
-
-	/* Reset any pending buffers */
-	buf_ring = &mhi_chan->buf_ring;
-	tre_ring = &mhi_chan->tre_ring;
-	result.transaction_status = -ENOTCONN;
-	result.bytes_xferd = 0;
-	while (tre_ring->rp != tre_ring->wp) {
-		struct mhi_buf_info *buf_info = buf_ring->rp;
-
-		if (mhi_chan->dir == DMA_TO_DEVICE)
-			atomic_dec(&mhi_cntrl->pending_pkts);
-
-		if (!buf_info->pre_mapped)
-			mhi_cntrl->unmap_single(mhi_cntrl, buf_info);
-
-		mhi_del_ring_element(mhi_cntrl, buf_ring);
-		mhi_del_ring_element(mhi_cntrl, tre_ring);
-
-		if (mhi_chan->pre_alloc) {
-			kfree(buf_info->cb_buf);
-		} else {
-			result.buf_addr = buf_info->cb_buf;
-			mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
-		}
-	}
-}
-
-void mhi_reset_chan(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan)
-{
-	struct mhi_event *mhi_event;
-	struct mhi_event_ctxt *er_ctxt;
-	int chan = mhi_chan->chan;
-
-	/* Nothing to reset, client doesn't queue buffers */
-	if (mhi_chan->offload_ch)
-		return;
-
-	read_lock_bh(&mhi_cntrl->pm_lock);
-	mhi_event = &mhi_cntrl->mhi_event[mhi_chan->er_index];
-	er_ctxt = &mhi_cntrl->mhi_ctxt->er_ctxt[mhi_chan->er_index];
-
-	mhi_mark_stale_events(mhi_cntrl, mhi_event, er_ctxt, chan);
-
-	mhi_reset_data_chan(mhi_cntrl, mhi_chan);
-
-	read_unlock_bh(&mhi_cntrl->pm_lock);
-}
-
-/* Move channel to start state */
-int mhi_prepare_for_transfer(struct mhi_device *mhi_dev)
-{
-	int ret, dir;
-	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
-	struct mhi_chan *mhi_chan;
-
-	for (dir = 0; dir < 2; dir++) {
-		mhi_chan = dir ? mhi_dev->dl_chan : mhi_dev->ul_chan;
-		if (!mhi_chan)
-			continue;
-
-		ret = mhi_prepare_channel(mhi_cntrl, mhi_chan);
-		if (ret)
-			goto error_open_chan;
-	}
-
-	return 0;
-
-error_open_chan:
-	for (--dir; dir >= 0; dir--) {
-		mhi_chan = dir ? mhi_dev->dl_chan : mhi_dev->ul_chan;
-		if (!mhi_chan)
-			continue;
-
-		__mhi_unprepare_channel(mhi_cntrl, mhi_chan);
-	}
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(mhi_prepare_for_transfer);
-
-void mhi_unprepare_from_transfer(struct mhi_device *mhi_dev)
-{
-	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
-	struct mhi_chan *mhi_chan;
-	int dir;
-
-	for (dir = 0; dir < 2; dir++) {
-		mhi_chan = dir ? mhi_dev->ul_chan : mhi_dev->dl_chan;
-		if (!mhi_chan)
-			continue;
-
-		__mhi_unprepare_channel(mhi_cntrl, mhi_chan);
-	}
-}
-EXPORT_SYMBOL_GPL(mhi_unprepare_from_transfer);
-
-int mhi_poll(struct mhi_device *mhi_dev, u32 budget)
-{
-	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
-	struct mhi_chan *mhi_chan = mhi_dev->dl_chan;
-	struct mhi_event *mhi_event = &mhi_cntrl->mhi_event[mhi_chan->er_index];
-	int ret;
-
-	spin_lock_bh(&mhi_event->lock);
-	ret = mhi_event->process_event(mhi_cntrl, mhi_event, budget);
-	spin_unlock_bh(&mhi_event->lock);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(mhi_poll);
diff --git a/drivers/bus/mhi/core/pm.c b/drivers/bus/mhi/core/pm.c
deleted file mode 100644
index 7d69b740b9f9..000000000000
--- a/drivers/bus/mhi/core/pm.c
+++ /dev/null
@@ -1,1157 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (c) 2018-2020, The Linux Foundation. All rights reserved.
- *
- */
-
-#include <linux/delay.h>
-#include <linux/device.h>
-#include <linux/dma-direction.h>
-#include <linux/dma-mapping.h>
-#include <linux/interrupt.h>
-#include <linux/list.h>
-#include <linux/mhi.h>
-#include <linux/module.h>
-#include <linux/slab.h>
-#include <linux/wait.h>
-#include "internal.h"
-
-/*
- * Not all MHI state transitions are synchronous. Transitions like Linkdown,
- * SYS_ERR, and shutdown can happen anytime asynchronously. This function will
- * transition to a new state only if we're allowed to.
- *
- * Priority increases as we go down. For instance, from any state in L0, the
- * transition can be made to states in L1, L2 and L3. A notable exception to
- * this rule is state DISABLE.  From DISABLE state we can only transition to
- * POR state. Also, while in L2 state, user cannot jump back to previous
- * L1 or L0 states.
- *
- * Valid transitions:
- * L0: DISABLE <--> POR
- *     POR <--> POR
- *     POR -> M0 -> M2 --> M0
- *     POR -> FW_DL_ERR
- *     FW_DL_ERR <--> FW_DL_ERR
- *     M0 <--> M0
- *     M0 -> FW_DL_ERR
- *     M0 -> M3_ENTER -> M3 -> M3_EXIT --> M0
- * L1: SYS_ERR_DETECT -> SYS_ERR_PROCESS --> POR
- * L2: SHUTDOWN_PROCESS -> DISABLE
- * L3: LD_ERR_FATAL_DETECT <--> LD_ERR_FATAL_DETECT
- *     LD_ERR_FATAL_DETECT -> SHUTDOWN_PROCESS
- */
-static struct mhi_pm_transitions const dev_state_transitions[] = {
-	/* L0 States */
-	{
-		MHI_PM_DISABLE,
-		MHI_PM_POR
-	},
-	{
-		MHI_PM_POR,
-		MHI_PM_POR | MHI_PM_DISABLE | MHI_PM_M0 |
-		MHI_PM_SYS_ERR_DETECT | MHI_PM_SHUTDOWN_PROCESS |
-		MHI_PM_LD_ERR_FATAL_DETECT | MHI_PM_FW_DL_ERR
-	},
-	{
-		MHI_PM_M0,
-		MHI_PM_M0 | MHI_PM_M2 | MHI_PM_M3_ENTER |
-		MHI_PM_SYS_ERR_DETECT | MHI_PM_SHUTDOWN_PROCESS |
-		MHI_PM_LD_ERR_FATAL_DETECT | MHI_PM_FW_DL_ERR
-	},
-	{
-		MHI_PM_M2,
-		MHI_PM_M0 | MHI_PM_SYS_ERR_DETECT | MHI_PM_SHUTDOWN_PROCESS |
-		MHI_PM_LD_ERR_FATAL_DETECT
-	},
-	{
-		MHI_PM_M3_ENTER,
-		MHI_PM_M3 | MHI_PM_SYS_ERR_DETECT | MHI_PM_SHUTDOWN_PROCESS |
-		MHI_PM_LD_ERR_FATAL_DETECT
-	},
-	{
-		MHI_PM_M3,
-		MHI_PM_M3_EXIT | MHI_PM_SYS_ERR_DETECT |
-		MHI_PM_SHUTDOWN_PROCESS | MHI_PM_LD_ERR_FATAL_DETECT
-	},
-	{
-		MHI_PM_M3_EXIT,
-		MHI_PM_M0 | MHI_PM_SYS_ERR_DETECT | MHI_PM_SHUTDOWN_PROCESS |
-		MHI_PM_LD_ERR_FATAL_DETECT
-	},
-	{
-		MHI_PM_FW_DL_ERR,
-		MHI_PM_FW_DL_ERR | MHI_PM_SYS_ERR_DETECT |
-		MHI_PM_SHUTDOWN_PROCESS | MHI_PM_LD_ERR_FATAL_DETECT
-	},
-	/* L1 States */
-	{
-		MHI_PM_SYS_ERR_DETECT,
-		MHI_PM_SYS_ERR_PROCESS | MHI_PM_SHUTDOWN_PROCESS |
-		MHI_PM_LD_ERR_FATAL_DETECT
-	},
-	{
-		MHI_PM_SYS_ERR_PROCESS,
-		MHI_PM_POR | MHI_PM_SHUTDOWN_PROCESS |
-		MHI_PM_LD_ERR_FATAL_DETECT
-	},
-	/* L2 States */
-	{
-		MHI_PM_SHUTDOWN_PROCESS,
-		MHI_PM_DISABLE | MHI_PM_LD_ERR_FATAL_DETECT
-	},
-	/* L3 States */
-	{
-		MHI_PM_LD_ERR_FATAL_DETECT,
-		MHI_PM_LD_ERR_FATAL_DETECT | MHI_PM_SHUTDOWN_PROCESS
-	},
-};
-
-enum mhi_pm_state __must_check mhi_tryset_pm_state(struct mhi_controller *mhi_cntrl,
-						   enum mhi_pm_state state)
-{
-	unsigned long cur_state = mhi_cntrl->pm_state;
-	int index = find_last_bit(&cur_state, 32);
-
-	if (unlikely(index >= ARRAY_SIZE(dev_state_transitions)))
-		return cur_state;
-
-	if (unlikely(dev_state_transitions[index].from_state != cur_state))
-		return cur_state;
-
-	if (unlikely(!(dev_state_transitions[index].to_states & state)))
-		return cur_state;
-
-	mhi_cntrl->pm_state = state;
-	return mhi_cntrl->pm_state;
-}
-
-void mhi_set_mhi_state(struct mhi_controller *mhi_cntrl, enum mhi_state state)
-{
-	if (state == MHI_STATE_RESET) {
-		mhi_write_reg_field(mhi_cntrl, mhi_cntrl->regs, MHICTRL,
-				    MHICTRL_RESET_MASK, MHICTRL_RESET_SHIFT, 1);
-	} else {
-		mhi_write_reg_field(mhi_cntrl, mhi_cntrl->regs, MHICTRL,
-				    MHICTRL_MHISTATE_MASK,
-				    MHICTRL_MHISTATE_SHIFT, state);
-	}
-}
-
-/* NOP for backward compatibility, host allowed to ring DB in M2 state */
-static void mhi_toggle_dev_wake_nop(struct mhi_controller *mhi_cntrl)
-{
-}
-
-static void mhi_toggle_dev_wake(struct mhi_controller *mhi_cntrl)
-{
-	mhi_cntrl->wake_get(mhi_cntrl, false);
-	mhi_cntrl->wake_put(mhi_cntrl, true);
-}
-
-/* Handle device ready state transition */
-int mhi_ready_state_transition(struct mhi_controller *mhi_cntrl)
-{
-	void __iomem *base = mhi_cntrl->regs;
-	struct mhi_event *mhi_event;
-	enum mhi_pm_state cur_state;
-	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-	u32 reset = 1, ready = 0;
-	int ret, i;
-
-	/* Wait for RESET to be cleared and READY bit to be set by the device */
-	wait_event_timeout(mhi_cntrl->state_event,
-			   MHI_PM_IN_FATAL_STATE(mhi_cntrl->pm_state) ||
-			   mhi_read_reg_field(mhi_cntrl, base, MHICTRL,
-					      MHICTRL_RESET_MASK,
-					      MHICTRL_RESET_SHIFT, &reset) ||
-			   mhi_read_reg_field(mhi_cntrl, base, MHISTATUS,
-					      MHISTATUS_READY_MASK,
-					      MHISTATUS_READY_SHIFT, &ready) ||
-			   (!reset && ready),
-			   msecs_to_jiffies(mhi_cntrl->timeout_ms));
-
-	/* Check if device entered error state */
-	if (MHI_PM_IN_FATAL_STATE(mhi_cntrl->pm_state)) {
-		dev_err(dev, "Device link is not accessible\n");
-		return -EIO;
-	}
-
-	/* Timeout if device did not transition to ready state */
-	if (reset || !ready) {
-		dev_err(dev, "Device Ready timeout\n");
-		return -ETIMEDOUT;
-	}
-
-	dev_dbg(dev, "Device in READY State\n");
-	write_lock_irq(&mhi_cntrl->pm_lock);
-	cur_state = mhi_tryset_pm_state(mhi_cntrl, MHI_PM_POR);
-	mhi_cntrl->dev_state = MHI_STATE_READY;
-	write_unlock_irq(&mhi_cntrl->pm_lock);
-
-	if (cur_state != MHI_PM_POR) {
-		dev_err(dev, "Error moving to state %s from %s\n",
-			to_mhi_pm_state_str(MHI_PM_POR),
-			to_mhi_pm_state_str(cur_state));
-		return -EIO;
-	}
-
-	read_lock_bh(&mhi_cntrl->pm_lock);
-	if (!MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state)) {
-		dev_err(dev, "Device registers not accessible\n");
-		goto error_mmio;
-	}
-
-	/* Configure MMIO registers */
-	ret = mhi_init_mmio(mhi_cntrl);
-	if (ret) {
-		dev_err(dev, "Error configuring MMIO registers\n");
-		goto error_mmio;
-	}
-
-	/* Add elements to all SW event rings */
-	mhi_event = mhi_cntrl->mhi_event;
-	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
-		struct mhi_ring *ring = &mhi_event->ring;
-
-		/* Skip if this is an offload or HW event */
-		if (mhi_event->offload_ev || mhi_event->hw_ring)
-			continue;
-
-		ring->wp = ring->base + ring->len - ring->el_size;
-		*ring->ctxt_wp = ring->iommu_base + ring->len - ring->el_size;
-		/* Update all cores */
-		smp_wmb();
-
-		/* Ring the event ring db */
-		spin_lock_irq(&mhi_event->lock);
-		mhi_ring_er_db(mhi_event);
-		spin_unlock_irq(&mhi_event->lock);
-	}
-
-	/* Set MHI to M0 state */
-	mhi_set_mhi_state(mhi_cntrl, MHI_STATE_M0);
-	read_unlock_bh(&mhi_cntrl->pm_lock);
-
-	return 0;
-
-error_mmio:
-	read_unlock_bh(&mhi_cntrl->pm_lock);
-
-	return -EIO;
-}
-
-int mhi_pm_m0_transition(struct mhi_controller *mhi_cntrl)
-{
-	enum mhi_pm_state cur_state;
-	struct mhi_chan *mhi_chan;
-	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-	int i;
-
-	write_lock_irq(&mhi_cntrl->pm_lock);
-	mhi_cntrl->dev_state = MHI_STATE_M0;
-	cur_state = mhi_tryset_pm_state(mhi_cntrl, MHI_PM_M0);
-	write_unlock_irq(&mhi_cntrl->pm_lock);
-	if (unlikely(cur_state != MHI_PM_M0)) {
-		dev_err(dev, "Unable to transition to M0 state\n");
-		return -EIO;
-	}
-	mhi_cntrl->M0++;
-
-	/* Wake up the device */
-	read_lock_bh(&mhi_cntrl->pm_lock);
-	mhi_cntrl->wake_get(mhi_cntrl, true);
-
-	/* Ring all event rings and CMD ring only if we're in mission mode */
-	if (MHI_IN_MISSION_MODE(mhi_cntrl->ee)) {
-		struct mhi_event *mhi_event = mhi_cntrl->mhi_event;
-		struct mhi_cmd *mhi_cmd =
-			&mhi_cntrl->mhi_cmd[PRIMARY_CMD_RING];
-
-		for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
-			if (mhi_event->offload_ev)
-				continue;
-
-			spin_lock_irq(&mhi_event->lock);
-			mhi_ring_er_db(mhi_event);
-			spin_unlock_irq(&mhi_event->lock);
-		}
-
-		/* Only ring primary cmd ring if ring is not empty */
-		spin_lock_irq(&mhi_cmd->lock);
-		if (mhi_cmd->ring.rp != mhi_cmd->ring.wp)
-			mhi_ring_cmd_db(mhi_cntrl, mhi_cmd);
-		spin_unlock_irq(&mhi_cmd->lock);
-	}
-
-	/* Ring channel DB registers */
-	mhi_chan = mhi_cntrl->mhi_chan;
-	for (i = 0; i < mhi_cntrl->max_chan; i++, mhi_chan++) {
-		struct mhi_ring *tre_ring = &mhi_chan->tre_ring;
-
-		if (mhi_chan->db_cfg.reset_req) {
-			write_lock_irq(&mhi_chan->lock);
-			mhi_chan->db_cfg.db_mode = true;
-			write_unlock_irq(&mhi_chan->lock);
-		}
-
-		read_lock_irq(&mhi_chan->lock);
-
-		/* Only ring DB if ring is not empty */
-		if (tre_ring->base && tre_ring->wp  != tre_ring->rp &&
-		    mhi_chan->ch_state == MHI_CH_STATE_ENABLED)
-			mhi_ring_chan_db(mhi_cntrl, mhi_chan);
-		read_unlock_irq(&mhi_chan->lock);
-	}
-
-	mhi_cntrl->wake_put(mhi_cntrl, false);
-	read_unlock_bh(&mhi_cntrl->pm_lock);
-	wake_up_all(&mhi_cntrl->state_event);
-
-	return 0;
-}
-
-/*
- * After receiving the MHI state change event from the device indicating the
- * transition to M1 state, the host can transition the device to M2 state
- * for keeping it in low power state.
- */
-void mhi_pm_m1_transition(struct mhi_controller *mhi_cntrl)
-{
-	enum mhi_pm_state state;
-	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-
-	write_lock_irq(&mhi_cntrl->pm_lock);
-	state = mhi_tryset_pm_state(mhi_cntrl, MHI_PM_M2);
-	if (state == MHI_PM_M2) {
-		mhi_set_mhi_state(mhi_cntrl, MHI_STATE_M2);
-		mhi_cntrl->dev_state = MHI_STATE_M2;
-
-		write_unlock_irq(&mhi_cntrl->pm_lock);
-
-		mhi_cntrl->M2++;
-		wake_up_all(&mhi_cntrl->state_event);
-
-		/* If there are any pending resources, exit M2 immediately */
-		if (unlikely(atomic_read(&mhi_cntrl->pending_pkts) ||
-			     atomic_read(&mhi_cntrl->dev_wake))) {
-			dev_dbg(dev,
-				"Exiting M2, pending_pkts: %d dev_wake: %d\n",
-				atomic_read(&mhi_cntrl->pending_pkts),
-				atomic_read(&mhi_cntrl->dev_wake));
-			read_lock_bh(&mhi_cntrl->pm_lock);
-			mhi_cntrl->wake_get(mhi_cntrl, true);
-			mhi_cntrl->wake_put(mhi_cntrl, true);
-			read_unlock_bh(&mhi_cntrl->pm_lock);
-		} else {
-			mhi_cntrl->status_cb(mhi_cntrl, MHI_CB_IDLE);
-		}
-	} else {
-		write_unlock_irq(&mhi_cntrl->pm_lock);
-	}
-}
-
-/* MHI M3 completion handler */
-int mhi_pm_m3_transition(struct mhi_controller *mhi_cntrl)
-{
-	enum mhi_pm_state state;
-	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-
-	write_lock_irq(&mhi_cntrl->pm_lock);
-	mhi_cntrl->dev_state = MHI_STATE_M3;
-	state = mhi_tryset_pm_state(mhi_cntrl, MHI_PM_M3);
-	write_unlock_irq(&mhi_cntrl->pm_lock);
-	if (state != MHI_PM_M3) {
-		dev_err(dev, "Unable to transition to M3 state\n");
-		return -EIO;
-	}
-
-	mhi_cntrl->M3++;
-	wake_up_all(&mhi_cntrl->state_event);
-
-	return 0;
-}
-
-/* Handle device Mission Mode transition */
-static int mhi_pm_mission_mode_transition(struct mhi_controller *mhi_cntrl)
-{
-	struct mhi_event *mhi_event;
-	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-	enum mhi_ee_type current_ee = mhi_cntrl->ee;
-	int i, ret;
-
-	dev_dbg(dev, "Processing Mission Mode transition\n");
-
-	write_lock_irq(&mhi_cntrl->pm_lock);
-	if (MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state))
-		mhi_cntrl->ee = mhi_get_exec_env(mhi_cntrl);
-	write_unlock_irq(&mhi_cntrl->pm_lock);
-
-	if (!MHI_IN_MISSION_MODE(mhi_cntrl->ee))
-		return -EIO;
-
-	wake_up_all(&mhi_cntrl->state_event);
-
-	device_for_each_child(&mhi_cntrl->mhi_dev->dev, &current_ee,
-			      mhi_destroy_device);
-	mhi_cntrl->status_cb(mhi_cntrl, MHI_CB_EE_MISSION_MODE);
-
-	/* Force MHI to be in M0 state before continuing */
-	ret = __mhi_device_get_sync(mhi_cntrl);
-	if (ret)
-		return ret;
-
-	read_lock_bh(&mhi_cntrl->pm_lock);
-
-	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
-		ret = -EIO;
-		goto error_mission_mode;
-	}
-
-	/* Add elements to all HW event rings */
-	mhi_event = mhi_cntrl->mhi_event;
-	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
-		struct mhi_ring *ring = &mhi_event->ring;
-
-		if (mhi_event->offload_ev || !mhi_event->hw_ring)
-			continue;
-
-		ring->wp = ring->base + ring->len - ring->el_size;
-		*ring->ctxt_wp = ring->iommu_base + ring->len - ring->el_size;
-		/* Update to all cores */
-		smp_wmb();
-
-		spin_lock_irq(&mhi_event->lock);
-		if (MHI_DB_ACCESS_VALID(mhi_cntrl))
-			mhi_ring_er_db(mhi_event);
-		spin_unlock_irq(&mhi_event->lock);
-	}
-
-	read_unlock_bh(&mhi_cntrl->pm_lock);
-
-	/*
-	 * The MHI devices are only created when the client device switches its
-	 * Execution Environment (EE) to either SBL or AMSS states
-	 */
-	mhi_create_devices(mhi_cntrl);
-
-	read_lock_bh(&mhi_cntrl->pm_lock);
-
-error_mission_mode:
-	mhi_cntrl->wake_put(mhi_cntrl, false);
-	read_unlock_bh(&mhi_cntrl->pm_lock);
-
-	return ret;
-}
-
-/* Handle SYS_ERR and Shutdown transitions */
-static void mhi_pm_disable_transition(struct mhi_controller *mhi_cntrl,
-				      enum mhi_pm_state transition_state)
-{
-	enum mhi_pm_state cur_state, prev_state;
-	struct mhi_event *mhi_event;
-	struct mhi_cmd_ctxt *cmd_ctxt;
-	struct mhi_cmd *mhi_cmd;
-	struct mhi_event_ctxt *er_ctxt;
-	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-	int ret, i;
-
-	dev_dbg(dev, "Transitioning from PM state: %s to: %s\n",
-		to_mhi_pm_state_str(mhi_cntrl->pm_state),
-		to_mhi_pm_state_str(transition_state));
-
-	/* We must notify MHI control driver so it can clean up first */
-	if (transition_state == MHI_PM_SYS_ERR_PROCESS)
-		mhi_cntrl->status_cb(mhi_cntrl, MHI_CB_SYS_ERROR);
-
-	mutex_lock(&mhi_cntrl->pm_mutex);
-	write_lock_irq(&mhi_cntrl->pm_lock);
-	prev_state = mhi_cntrl->pm_state;
-	cur_state = mhi_tryset_pm_state(mhi_cntrl, transition_state);
-	if (cur_state == transition_state) {
-		mhi_cntrl->ee = MHI_EE_DISABLE_TRANSITION;
-		mhi_cntrl->dev_state = MHI_STATE_RESET;
-	}
-	write_unlock_irq(&mhi_cntrl->pm_lock);
-
-	/* Wake up threads waiting for state transition */
-	wake_up_all(&mhi_cntrl->state_event);
-
-	if (cur_state != transition_state) {
-		dev_err(dev, "Failed to transition to state: %s from: %s\n",
-			to_mhi_pm_state_str(transition_state),
-			to_mhi_pm_state_str(cur_state));
-		mutex_unlock(&mhi_cntrl->pm_mutex);
-		return;
-	}
-
-	/* Trigger MHI RESET so that the device will not access host memory */
-	if (MHI_REG_ACCESS_VALID(prev_state)) {
-		u32 in_reset = -1;
-		unsigned long timeout = msecs_to_jiffies(mhi_cntrl->timeout_ms);
-
-		dev_dbg(dev, "Triggering MHI Reset in device\n");
-		mhi_set_mhi_state(mhi_cntrl, MHI_STATE_RESET);
-
-		/* Wait for the reset bit to be cleared by the device */
-		ret = wait_event_timeout(mhi_cntrl->state_event,
-					 mhi_read_reg_field(mhi_cntrl,
-							    mhi_cntrl->regs,
-							    MHICTRL,
-							    MHICTRL_RESET_MASK,
-							    MHICTRL_RESET_SHIFT,
-							    &in_reset) ||
-					!in_reset, timeout);
-		if ((!ret || in_reset) && cur_state == MHI_PM_SYS_ERR_PROCESS) {
-			dev_err(dev, "Device failed to exit MHI Reset state\n");
-			mutex_unlock(&mhi_cntrl->pm_mutex);
-			return;
-		}
-
-		/*
-		 * Device will clear BHI_INTVEC as a part of RESET processing,
-		 * hence re-program it
-		 */
-		mhi_write_reg(mhi_cntrl, mhi_cntrl->bhi, BHI_INTVEC, 0);
-	}
-
-	dev_dbg(dev,
-		 "Waiting for all pending event ring processing to complete\n");
-	mhi_event = mhi_cntrl->mhi_event;
-	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
-		if (mhi_event->offload_ev)
-			continue;
-		tasklet_kill(&mhi_event->task);
-	}
-
-	/* Release lock and wait for all pending threads to complete */
-	mutex_unlock(&mhi_cntrl->pm_mutex);
-	dev_dbg(dev, "Waiting for all pending threads to complete\n");
-	wake_up_all(&mhi_cntrl->state_event);
-
-	dev_dbg(dev, "Reset all active channels and remove MHI devices\n");
-	device_for_each_child(mhi_cntrl->cntrl_dev, NULL, mhi_destroy_device);
-
-	mutex_lock(&mhi_cntrl->pm_mutex);
-
-	WARN_ON(atomic_read(&mhi_cntrl->dev_wake));
-	WARN_ON(atomic_read(&mhi_cntrl->pending_pkts));
-
-	/* Reset the ev rings and cmd rings */
-	dev_dbg(dev, "Resetting EV CTXT and CMD CTXT\n");
-	mhi_cmd = mhi_cntrl->mhi_cmd;
-	cmd_ctxt = mhi_cntrl->mhi_ctxt->cmd_ctxt;
-	for (i = 0; i < NR_OF_CMD_RINGS; i++, mhi_cmd++, cmd_ctxt++) {
-		struct mhi_ring *ring = &mhi_cmd->ring;
-
-		ring->rp = ring->base;
-		ring->wp = ring->base;
-		cmd_ctxt->rp = cmd_ctxt->rbase;
-		cmd_ctxt->wp = cmd_ctxt->rbase;
-	}
-
-	mhi_event = mhi_cntrl->mhi_event;
-	er_ctxt = mhi_cntrl->mhi_ctxt->er_ctxt;
-	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, er_ctxt++,
-		     mhi_event++) {
-		struct mhi_ring *ring = &mhi_event->ring;
-
-		/* Skip offload events */
-		if (mhi_event->offload_ev)
-			continue;
-
-		ring->rp = ring->base;
-		ring->wp = ring->base;
-		er_ctxt->rp = er_ctxt->rbase;
-		er_ctxt->wp = er_ctxt->rbase;
-	}
-
-	if (cur_state == MHI_PM_SYS_ERR_PROCESS) {
-		mhi_ready_state_transition(mhi_cntrl);
-	} else {
-		/* Move to disable state */
-		write_lock_irq(&mhi_cntrl->pm_lock);
-		cur_state = mhi_tryset_pm_state(mhi_cntrl, MHI_PM_DISABLE);
-		write_unlock_irq(&mhi_cntrl->pm_lock);
-		if (unlikely(cur_state != MHI_PM_DISABLE))
-			dev_err(dev, "Error moving from PM state: %s to: %s\n",
-				to_mhi_pm_state_str(cur_state),
-				to_mhi_pm_state_str(MHI_PM_DISABLE));
-	}
-
-	dev_dbg(dev, "Exiting with PM state: %s, MHI state: %s\n",
-		to_mhi_pm_state_str(mhi_cntrl->pm_state),
-		TO_MHI_STATE_STR(mhi_cntrl->dev_state));
-
-	mutex_unlock(&mhi_cntrl->pm_mutex);
-}
-
-/* Queue a new work item and schedule work */
-int mhi_queue_state_transition(struct mhi_controller *mhi_cntrl,
-			       enum dev_st_transition state)
-{
-	struct state_transition *item = kmalloc(sizeof(*item), GFP_ATOMIC);
-	unsigned long flags;
-
-	if (!item)
-		return -ENOMEM;
-
-	item->state = state;
-	spin_lock_irqsave(&mhi_cntrl->transition_lock, flags);
-	list_add_tail(&item->node, &mhi_cntrl->transition_list);
-	spin_unlock_irqrestore(&mhi_cntrl->transition_lock, flags);
-
-	schedule_work(&mhi_cntrl->st_worker);
-
-	return 0;
-}
-
-/* SYS_ERR worker */
-void mhi_pm_sys_err_handler(struct mhi_controller *mhi_cntrl)
-{
-	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-
-	/* skip if controller supports RDDM */
-	if (mhi_cntrl->rddm_image) {
-		dev_dbg(dev, "Controller supports RDDM, skip SYS_ERROR\n");
-		return;
-	}
-
-	mhi_queue_state_transition(mhi_cntrl, DEV_ST_TRANSITION_SYS_ERR);
-}
-
-/* Device State Transition worker */
-void mhi_pm_st_worker(struct work_struct *work)
-{
-	struct state_transition *itr, *tmp;
-	LIST_HEAD(head);
-	struct mhi_controller *mhi_cntrl = container_of(work,
-							struct mhi_controller,
-							st_worker);
-	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-
-	spin_lock_irq(&mhi_cntrl->transition_lock);
-	list_splice_tail_init(&mhi_cntrl->transition_list, &head);
-	spin_unlock_irq(&mhi_cntrl->transition_lock);
-
-	list_for_each_entry_safe(itr, tmp, &head, node) {
-		list_del(&itr->node);
-		dev_dbg(dev, "Handling state transition: %s\n",
-			TO_DEV_STATE_TRANS_STR(itr->state));
-
-		switch (itr->state) {
-		case DEV_ST_TRANSITION_PBL:
-			write_lock_irq(&mhi_cntrl->pm_lock);
-			if (MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state))
-				mhi_cntrl->ee = mhi_get_exec_env(mhi_cntrl);
-			write_unlock_irq(&mhi_cntrl->pm_lock);
-			if (MHI_IN_PBL(mhi_cntrl->ee))
-				mhi_fw_load_handler(mhi_cntrl);
-			break;
-		case DEV_ST_TRANSITION_SBL:
-			write_lock_irq(&mhi_cntrl->pm_lock);
-			mhi_cntrl->ee = MHI_EE_SBL;
-			write_unlock_irq(&mhi_cntrl->pm_lock);
-			/*
-			 * The MHI devices are only created when the client
-			 * device switches its Execution Environment (EE) to
-			 * either SBL or AMSS states
-			 */
-			mhi_create_devices(mhi_cntrl);
-			break;
-		case DEV_ST_TRANSITION_MISSION_MODE:
-			mhi_pm_mission_mode_transition(mhi_cntrl);
-			break;
-		case DEV_ST_TRANSITION_READY:
-			mhi_ready_state_transition(mhi_cntrl);
-			break;
-		case DEV_ST_TRANSITION_SYS_ERR:
-			mhi_pm_disable_transition
-				(mhi_cntrl, MHI_PM_SYS_ERR_PROCESS);
-			break;
-		case DEV_ST_TRANSITION_DISABLE:
-			mhi_pm_disable_transition
-				(mhi_cntrl, MHI_PM_SHUTDOWN_PROCESS);
-			break;
-		default:
-			break;
-		}
-		kfree(itr);
-	}
-}
-
-int mhi_pm_suspend(struct mhi_controller *mhi_cntrl)
-{
-	struct mhi_chan *itr, *tmp;
-	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-	enum mhi_pm_state new_state;
-	int ret;
-
-	if (mhi_cntrl->pm_state == MHI_PM_DISABLE)
-		return -EINVAL;
-
-	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state))
-		return -EIO;
-
-	/* Return busy if there are any pending resources */
-	if (atomic_read(&mhi_cntrl->dev_wake) ||
-	    atomic_read(&mhi_cntrl->pending_pkts))
-		return -EBUSY;
-
-	/* Take MHI out of M2 state */
-	read_lock_bh(&mhi_cntrl->pm_lock);
-	mhi_cntrl->wake_get(mhi_cntrl, false);
-	read_unlock_bh(&mhi_cntrl->pm_lock);
-
-	ret = wait_event_timeout(mhi_cntrl->state_event,
-				 mhi_cntrl->dev_state == MHI_STATE_M0 ||
-				 mhi_cntrl->dev_state == MHI_STATE_M1 ||
-				 MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state),
-				 msecs_to_jiffies(mhi_cntrl->timeout_ms));
-
-	read_lock_bh(&mhi_cntrl->pm_lock);
-	mhi_cntrl->wake_put(mhi_cntrl, false);
-	read_unlock_bh(&mhi_cntrl->pm_lock);
-
-	if (!ret || MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
-		dev_err(dev,
-			"Could not enter M0/M1 state");
-		return -EIO;
-	}
-
-	write_lock_irq(&mhi_cntrl->pm_lock);
-
-	if (atomic_read(&mhi_cntrl->dev_wake) ||
-	    atomic_read(&mhi_cntrl->pending_pkts)) {
-		write_unlock_irq(&mhi_cntrl->pm_lock);
-		return -EBUSY;
-	}
-
-	dev_info(dev, "Allowing M3 transition\n");
-	new_state = mhi_tryset_pm_state(mhi_cntrl, MHI_PM_M3_ENTER);
-	if (new_state != MHI_PM_M3_ENTER) {
-		write_unlock_irq(&mhi_cntrl->pm_lock);
-		dev_err(dev,
-			"Error setting to PM state: %s from: %s\n",
-			to_mhi_pm_state_str(MHI_PM_M3_ENTER),
-			to_mhi_pm_state_str(mhi_cntrl->pm_state));
-		return -EIO;
-	}
-
-	/* Set MHI to M3 and wait for completion */
-	mhi_set_mhi_state(mhi_cntrl, MHI_STATE_M3);
-	write_unlock_irq(&mhi_cntrl->pm_lock);
-	dev_info(dev, "Wait for M3 completion\n");
-
-	ret = wait_event_timeout(mhi_cntrl->state_event,
-				 mhi_cntrl->dev_state == MHI_STATE_M3 ||
-				 MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state),
-				 msecs_to_jiffies(mhi_cntrl->timeout_ms));
-
-	if (!ret || MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
-		dev_err(dev,
-			"Did not enter M3 state, MHI state: %s, PM state: %s\n",
-			TO_MHI_STATE_STR(mhi_cntrl->dev_state),
-			to_mhi_pm_state_str(mhi_cntrl->pm_state));
-		return -EIO;
-	}
-
-	/* Notify clients about entering LPM */
-	list_for_each_entry_safe(itr, tmp, &mhi_cntrl->lpm_chans, node) {
-		mutex_lock(&itr->mutex);
-		if (itr->mhi_dev)
-			mhi_notify(itr->mhi_dev, MHI_CB_LPM_ENTER);
-		mutex_unlock(&itr->mutex);
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(mhi_pm_suspend);
-
-int mhi_pm_resume(struct mhi_controller *mhi_cntrl)
-{
-	struct mhi_chan *itr, *tmp;
-	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-	enum mhi_pm_state cur_state;
-	int ret;
-
-	dev_info(dev, "Entered with PM state: %s, MHI state: %s\n",
-		 to_mhi_pm_state_str(mhi_cntrl->pm_state),
-		 TO_MHI_STATE_STR(mhi_cntrl->dev_state));
-
-	if (mhi_cntrl->pm_state == MHI_PM_DISABLE)
-		return 0;
-
-	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state))
-		return -EIO;
-
-	/* Notify clients about exiting LPM */
-	list_for_each_entry_safe(itr, tmp, &mhi_cntrl->lpm_chans, node) {
-		mutex_lock(&itr->mutex);
-		if (itr->mhi_dev)
-			mhi_notify(itr->mhi_dev, MHI_CB_LPM_EXIT);
-		mutex_unlock(&itr->mutex);
-	}
-
-	write_lock_irq(&mhi_cntrl->pm_lock);
-	cur_state = mhi_tryset_pm_state(mhi_cntrl, MHI_PM_M3_EXIT);
-	if (cur_state != MHI_PM_M3_EXIT) {
-		write_unlock_irq(&mhi_cntrl->pm_lock);
-		dev_info(dev,
-			 "Error setting to PM state: %s from: %s\n",
-			 to_mhi_pm_state_str(MHI_PM_M3_EXIT),
-			 to_mhi_pm_state_str(mhi_cntrl->pm_state));
-		return -EIO;
-	}
-
-	/* Set MHI to M0 and wait for completion */
-	mhi_set_mhi_state(mhi_cntrl, MHI_STATE_M0);
-	write_unlock_irq(&mhi_cntrl->pm_lock);
-
-	ret = wait_event_timeout(mhi_cntrl->state_event,
-				 mhi_cntrl->dev_state == MHI_STATE_M0 ||
-				 mhi_cntrl->dev_state == MHI_STATE_M2 ||
-				 MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state),
-				 msecs_to_jiffies(mhi_cntrl->timeout_ms));
-
-	if (!ret || MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
-		dev_err(dev,
-			"Did not enter M0 state, MHI state: %s, PM state: %s\n",
-			TO_MHI_STATE_STR(mhi_cntrl->dev_state),
-			to_mhi_pm_state_str(mhi_cntrl->pm_state));
-		return -EIO;
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(mhi_pm_resume);
-
-int __mhi_device_get_sync(struct mhi_controller *mhi_cntrl)
-{
-	int ret;
-
-	/* Wake up the device */
-	read_lock_bh(&mhi_cntrl->pm_lock);
-	mhi_cntrl->wake_get(mhi_cntrl, true);
-	if (MHI_PM_IN_SUSPEND_STATE(mhi_cntrl->pm_state))
-		mhi_trigger_resume(mhi_cntrl);
-	read_unlock_bh(&mhi_cntrl->pm_lock);
-
-	ret = wait_event_timeout(mhi_cntrl->state_event,
-				 mhi_cntrl->pm_state == MHI_PM_M0 ||
-				 MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state),
-				 msecs_to_jiffies(mhi_cntrl->timeout_ms));
-
-	if (!ret || MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
-		read_lock_bh(&mhi_cntrl->pm_lock);
-		mhi_cntrl->wake_put(mhi_cntrl, false);
-		read_unlock_bh(&mhi_cntrl->pm_lock);
-		return -EIO;
-	}
-
-	return 0;
-}
-
-/* Assert device wake db */
-static void mhi_assert_dev_wake(struct mhi_controller *mhi_cntrl, bool force)
-{
-	unsigned long flags;
-
-	/*
-	 * If force flag is set, then increment the wake count value and
-	 * ring wake db
-	 */
-	if (unlikely(force)) {
-		spin_lock_irqsave(&mhi_cntrl->wlock, flags);
-		atomic_inc(&mhi_cntrl->dev_wake);
-		if (MHI_WAKE_DB_FORCE_SET_VALID(mhi_cntrl->pm_state) &&
-		    !mhi_cntrl->wake_set) {
-			mhi_write_db(mhi_cntrl, mhi_cntrl->wake_db, 1);
-			mhi_cntrl->wake_set = true;
-		}
-		spin_unlock_irqrestore(&mhi_cntrl->wlock, flags);
-	} else {
-		/*
-		 * If resources are already requested, then just increment
-		 * the wake count value and return
-		 */
-		if (likely(atomic_add_unless(&mhi_cntrl->dev_wake, 1, 0)))
-			return;
-
-		spin_lock_irqsave(&mhi_cntrl->wlock, flags);
-		if ((atomic_inc_return(&mhi_cntrl->dev_wake) == 1) &&
-		    MHI_WAKE_DB_SET_VALID(mhi_cntrl->pm_state) &&
-		    !mhi_cntrl->wake_set) {
-			mhi_write_db(mhi_cntrl, mhi_cntrl->wake_db, 1);
-			mhi_cntrl->wake_set = true;
-		}
-		spin_unlock_irqrestore(&mhi_cntrl->wlock, flags);
-	}
-}
-
-/* De-assert device wake db */
-static void mhi_deassert_dev_wake(struct mhi_controller *mhi_cntrl,
-				  bool override)
-{
-	unsigned long flags;
-
-	/*
-	 * Only continue if there is a single resource, else just decrement
-	 * and return
-	 */
-	if (likely(atomic_add_unless(&mhi_cntrl->dev_wake, -1, 1)))
-		return;
-
-	spin_lock_irqsave(&mhi_cntrl->wlock, flags);
-	if ((atomic_dec_return(&mhi_cntrl->dev_wake) == 0) &&
-	    MHI_WAKE_DB_CLEAR_VALID(mhi_cntrl->pm_state) && !override &&
-	    mhi_cntrl->wake_set) {
-		mhi_write_db(mhi_cntrl, mhi_cntrl->wake_db, 0);
-		mhi_cntrl->wake_set = false;
-	}
-	spin_unlock_irqrestore(&mhi_cntrl->wlock, flags);
-}
-
-int mhi_async_power_up(struct mhi_controller *mhi_cntrl)
-{
-	enum mhi_state state;
-	enum mhi_ee_type current_ee;
-	enum dev_st_transition next_state;
-	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-	u32 val;
-	int ret;
-
-	dev_info(dev, "Requested to power ON\n");
-
-	if (mhi_cntrl->nr_irqs < 1)
-		return -EINVAL;
-
-	/* Supply default wake routines if not provided by controller driver */
-	if (!mhi_cntrl->wake_get || !mhi_cntrl->wake_put ||
-	    !mhi_cntrl->wake_toggle) {
-		mhi_cntrl->wake_get = mhi_assert_dev_wake;
-		mhi_cntrl->wake_put = mhi_deassert_dev_wake;
-		mhi_cntrl->wake_toggle = (mhi_cntrl->db_access & MHI_PM_M2) ?
-			mhi_toggle_dev_wake_nop : mhi_toggle_dev_wake;
-	}
-
-	mutex_lock(&mhi_cntrl->pm_mutex);
-	mhi_cntrl->pm_state = MHI_PM_DISABLE;
-
-	if (!mhi_cntrl->pre_init) {
-		/* Setup device context */
-		ret = mhi_init_dev_ctxt(mhi_cntrl);
-		if (ret)
-			goto error_dev_ctxt;
-	}
-
-	ret = mhi_init_irq_setup(mhi_cntrl);
-	if (ret)
-		goto error_setup_irq;
-
-	/* Setup BHI offset & INTVEC */
-	write_lock_irq(&mhi_cntrl->pm_lock);
-	ret = mhi_read_reg(mhi_cntrl, mhi_cntrl->regs, BHIOFF, &val);
-	if (ret) {
-		write_unlock_irq(&mhi_cntrl->pm_lock);
-		goto error_bhi_offset;
-	}
-
-	mhi_cntrl->bhi = mhi_cntrl->regs + val;
-
-	/* Setup BHIE offset */
-	if (mhi_cntrl->fbc_download) {
-		ret = mhi_read_reg(mhi_cntrl, mhi_cntrl->regs, BHIEOFF, &val);
-		if (ret) {
-			write_unlock_irq(&mhi_cntrl->pm_lock);
-			dev_err(dev, "Error reading BHIE offset\n");
-			goto error_bhi_offset;
-		}
-
-		mhi_cntrl->bhie = mhi_cntrl->regs + val;
-	}
-
-	mhi_write_reg(mhi_cntrl, mhi_cntrl->bhi, BHI_INTVEC, 0);
-	mhi_cntrl->pm_state = MHI_PM_POR;
-	mhi_cntrl->ee = MHI_EE_MAX;
-	current_ee = mhi_get_exec_env(mhi_cntrl);
-	write_unlock_irq(&mhi_cntrl->pm_lock);
-
-	/* Confirm that the device is in valid exec env */
-	if (!MHI_IN_PBL(current_ee) && current_ee != MHI_EE_AMSS) {
-		dev_err(dev, "Not a valid EE for power on\n");
-		ret = -EIO;
-		goto error_bhi_offset;
-	}
-
-	state = mhi_get_mhi_state(mhi_cntrl);
-	if (state == MHI_STATE_SYS_ERR) {
-		mhi_set_mhi_state(mhi_cntrl, MHI_STATE_RESET);
-		ret = wait_event_timeout(mhi_cntrl->state_event,
-				MHI_PM_IN_FATAL_STATE(mhi_cntrl->pm_state) ||
-					mhi_read_reg_field(mhi_cntrl,
-							   mhi_cntrl->regs,
-							   MHICTRL,
-							   MHICTRL_RESET_MASK,
-							   MHICTRL_RESET_SHIFT,
-							   &val) ||
-					!val,
-				msecs_to_jiffies(mhi_cntrl->timeout_ms));
-		if (!ret) {
-			ret = -EIO;
-			dev_info(dev, "Failed to reset MHI due to syserr state\n");
-			goto error_bhi_offset;
-		}
-
-		/*
-		 * device cleares INTVEC as part of RESET processing,
-		 * re-program it
-		 */
-		mhi_write_reg(mhi_cntrl, mhi_cntrl->bhi, BHI_INTVEC, 0);
-	}
-
-	/* Transition to next state */
-	next_state = MHI_IN_PBL(current_ee) ?
-		DEV_ST_TRANSITION_PBL : DEV_ST_TRANSITION_READY;
-
-	mhi_queue_state_transition(mhi_cntrl, next_state);
-
-	mutex_unlock(&mhi_cntrl->pm_mutex);
-
-	dev_info(dev, "Power on setup success\n");
-
-	return 0;
-
-error_bhi_offset:
-	mhi_deinit_free_irq(mhi_cntrl);
-
-error_setup_irq:
-	if (!mhi_cntrl->pre_init)
-		mhi_deinit_dev_ctxt(mhi_cntrl);
-
-error_dev_ctxt:
-	mutex_unlock(&mhi_cntrl->pm_mutex);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(mhi_async_power_up);
-
-void mhi_power_down(struct mhi_controller *mhi_cntrl, bool graceful)
-{
-	enum mhi_pm_state cur_state;
-	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-
-	/* If it's not a graceful shutdown, force MHI to linkdown state */
-	if (!graceful) {
-		mutex_lock(&mhi_cntrl->pm_mutex);
-		write_lock_irq(&mhi_cntrl->pm_lock);
-		cur_state = mhi_tryset_pm_state(mhi_cntrl,
-						MHI_PM_LD_ERR_FATAL_DETECT);
-		write_unlock_irq(&mhi_cntrl->pm_lock);
-		mutex_unlock(&mhi_cntrl->pm_mutex);
-		if (cur_state != MHI_PM_LD_ERR_FATAL_DETECT)
-			dev_dbg(dev, "Failed to move to state: %s from: %s\n",
-				to_mhi_pm_state_str(MHI_PM_LD_ERR_FATAL_DETECT),
-				to_mhi_pm_state_str(mhi_cntrl->pm_state));
-	}
-
-	mhi_queue_state_transition(mhi_cntrl, DEV_ST_TRANSITION_DISABLE);
-
-	/* Wait for shutdown to complete */
-	flush_work(&mhi_cntrl->st_worker);
-
-	mhi_deinit_free_irq(mhi_cntrl);
-
-	if (!mhi_cntrl->pre_init) {
-		/* Free all allocated resources */
-		if (mhi_cntrl->fbc_image) {
-			mhi_free_bhie_table(mhi_cntrl, mhi_cntrl->fbc_image);
-			mhi_cntrl->fbc_image = NULL;
-		}
-		mhi_deinit_dev_ctxt(mhi_cntrl);
-	}
-}
-EXPORT_SYMBOL_GPL(mhi_power_down);
-
-int mhi_sync_power_up(struct mhi_controller *mhi_cntrl)
-{
-	int ret = mhi_async_power_up(mhi_cntrl);
-
-	if (ret)
-		return ret;
-
-	wait_event_timeout(mhi_cntrl->state_event,
-			   MHI_IN_MISSION_MODE(mhi_cntrl->ee) ||
-			   MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state),
-			   msecs_to_jiffies(mhi_cntrl->timeout_ms));
-
-	ret = (MHI_IN_MISSION_MODE(mhi_cntrl->ee)) ? 0 : -ETIMEDOUT;
-	if (ret)
-		mhi_power_down(mhi_cntrl, false);
-
-	return ret;
-}
-EXPORT_SYMBOL(mhi_sync_power_up);
-
-int mhi_force_rddm_mode(struct mhi_controller *mhi_cntrl)
-{
-	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-	int ret;
-
-	/* Check if device is already in RDDM */
-	if (mhi_cntrl->ee == MHI_EE_RDDM)
-		return 0;
-
-	dev_dbg(dev, "Triggering SYS_ERR to force RDDM state\n");
-	mhi_set_mhi_state(mhi_cntrl, MHI_STATE_SYS_ERR);
-
-	/* Wait for RDDM event */
-	ret = wait_event_timeout(mhi_cntrl->state_event,
-				 mhi_cntrl->ee == MHI_EE_RDDM,
-				 msecs_to_jiffies(mhi_cntrl->timeout_ms));
-	ret = ret ? 0 : -EIO;
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(mhi_force_rddm_mode);
-
-void mhi_device_get(struct mhi_device *mhi_dev)
-{
-	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
-
-	mhi_dev->dev_wake++;
-	read_lock_bh(&mhi_cntrl->pm_lock);
-	if (MHI_PM_IN_SUSPEND_STATE(mhi_cntrl->pm_state))
-		mhi_trigger_resume(mhi_cntrl);
-
-	mhi_cntrl->wake_get(mhi_cntrl, true);
-	read_unlock_bh(&mhi_cntrl->pm_lock);
-}
-EXPORT_SYMBOL_GPL(mhi_device_get);
-
-int mhi_device_get_sync(struct mhi_device *mhi_dev)
-{
-	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
-	int ret;
-
-	ret = __mhi_device_get_sync(mhi_cntrl);
-	if (!ret)
-		mhi_dev->dev_wake++;
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(mhi_device_get_sync);
-
-void mhi_device_put(struct mhi_device *mhi_dev)
-{
-	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
-
-	mhi_dev->dev_wake--;
-	read_lock_bh(&mhi_cntrl->pm_lock);
-	if (MHI_PM_IN_SUSPEND_STATE(mhi_cntrl->pm_state))
-		mhi_trigger_resume(mhi_cntrl);
-
-	mhi_cntrl->wake_put(mhi_cntrl, false);
-	read_unlock_bh(&mhi_cntrl->pm_lock);
-}
-EXPORT_SYMBOL_GPL(mhi_device_put);
diff --git a/drivers/bus/mhi/host/Kconfig b/drivers/bus/mhi/host/Kconfig
new file mode 100644
index 000000000000..da5cd0c9fc62
--- /dev/null
+++ b/drivers/bus/mhi/host/Kconfig
@@ -0,0 +1,31 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# MHI bus
+#
+# Copyright (c) 2018-2020, The Linux Foundation. All rights reserved.
+#
+
+config MHI_BUS
+	tristate "Modem Host Interface (MHI) bus"
+	help
+	  Bus driver for MHI protocol. Modem Host Interface (MHI) is a
+	  communication protocol used by the host processors to control
+	  and communicate with modem devices over a high speed peripheral
+	  bus or shared memory.
+
+config MHI_BUS_DEBUG
+	bool "Debugfs support for the MHI bus"
+	depends on MHI_BUS && DEBUG_FS
+	help
+	  Enable debugfs support for use with the MHI transport. Allows
+	  reading and/or modifying some values within the MHI controller
+	  for debug and test purposes.
+
+config MHI_BUS_PCI_GENERIC
+	tristate "MHI PCI controller driver"
+	depends on MHI_BUS
+	depends on PCI
+	help
+	  This driver provides MHI PCI controller driver for devices such as
+	  Qualcomm SDX55 based PCIe modems.
+
diff --git a/drivers/bus/mhi/host/Makefile b/drivers/bus/mhi/host/Makefile
new file mode 100644
index 000000000000..859c2f38451c
--- /dev/null
+++ b/drivers/bus/mhi/host/Makefile
@@ -0,0 +1,6 @@
+obj-$(CONFIG_MHI_BUS) += mhi.o
+mhi-y := init.o main.o pm.o boot.o
+mhi-$(CONFIG_MHI_BUS_DEBUG) += debugfs.o
+
+obj-$(CONFIG_MHI_BUS_PCI_GENERIC) += mhi_pci_generic.o
+mhi_pci_generic-y += pci_generic.o
diff --git a/drivers/bus/mhi/host/boot.c b/drivers/bus/mhi/host/boot.c
new file mode 100644
index 000000000000..24422f5c3d80
--- /dev/null
+++ b/drivers/bus/mhi/host/boot.c
@@ -0,0 +1,525 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018-2020, The Linux Foundation. All rights reserved.
+ *
+ */
+
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/dma-direction.h>
+#include <linux/dma-mapping.h>
+#include <linux/firmware.h>
+#include <linux/interrupt.h>
+#include <linux/list.h>
+#include <linux/mhi.h>
+#include <linux/module.h>
+#include <linux/random.h>
+#include <linux/slab.h>
+#include <linux/wait.h>
+#include "internal.h"
+
+/* Setup RDDM vector table for RDDM transfer and program RXVEC */
+void mhi_rddm_prepare(struct mhi_controller *mhi_cntrl,
+		      struct image_info *img_info)
+{
+	struct mhi_buf *mhi_buf = img_info->mhi_buf;
+	struct bhi_vec_entry *bhi_vec = img_info->bhi_vec;
+	void __iomem *base = mhi_cntrl->bhie;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	u32 sequence_id;
+	unsigned int i;
+
+	for (i = 0; i < img_info->entries - 1; i++, mhi_buf++, bhi_vec++) {
+		bhi_vec->dma_addr = mhi_buf->dma_addr;
+		bhi_vec->size = mhi_buf->len;
+	}
+
+	dev_dbg(dev, "BHIe programming for RDDM\n");
+
+	mhi_write_reg(mhi_cntrl, base, BHIE_RXVECADDR_HIGH_OFFS,
+		      upper_32_bits(mhi_buf->dma_addr));
+
+	mhi_write_reg(mhi_cntrl, base, BHIE_RXVECADDR_LOW_OFFS,
+		      lower_32_bits(mhi_buf->dma_addr));
+
+	mhi_write_reg(mhi_cntrl, base, BHIE_RXVECSIZE_OFFS, mhi_buf->len);
+	sequence_id = MHI_RANDOM_U32_NONZERO(BHIE_RXVECSTATUS_SEQNUM_BMSK);
+
+	mhi_write_reg_field(mhi_cntrl, base, BHIE_RXVECDB_OFFS,
+			    BHIE_RXVECDB_SEQNUM_BMSK, BHIE_RXVECDB_SEQNUM_SHFT,
+			    sequence_id);
+
+	dev_dbg(dev, "Address: %p and len: 0x%zx sequence: %u\n",
+		&mhi_buf->dma_addr, mhi_buf->len, sequence_id);
+}
+
+/* Collect RDDM buffer during kernel panic */
+static int __mhi_download_rddm_in_panic(struct mhi_controller *mhi_cntrl)
+{
+	int ret;
+	u32 rx_status;
+	enum mhi_ee_type ee;
+	const u32 delayus = 2000;
+	u32 retry = (mhi_cntrl->timeout_ms * 1000) / delayus;
+	const u32 rddm_timeout_us = 200000;
+	int rddm_retry = rddm_timeout_us / delayus;
+	void __iomem *base = mhi_cntrl->bhie;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+
+	dev_dbg(dev, "Entered with pm_state:%s dev_state:%s ee:%s\n",
+		to_mhi_pm_state_str(mhi_cntrl->pm_state),
+		TO_MHI_STATE_STR(mhi_cntrl->dev_state),
+		TO_MHI_EXEC_STR(mhi_cntrl->ee));
+
+	/*
+	 * This should only be executing during a kernel panic, we expect all
+	 * other cores to shutdown while we're collecting RDDM buffer. After
+	 * returning from this function, we expect the device to reset.
+	 *
+	 * Normaly, we read/write pm_state only after grabbing the
+	 * pm_lock, since we're in a panic, skipping it. Also there is no
+	 * gurantee that this state change would take effect since
+	 * we're setting it w/o grabbing pm_lock
+	 */
+	mhi_cntrl->pm_state = MHI_PM_LD_ERR_FATAL_DETECT;
+	/* update should take the effect immediately */
+	smp_wmb();
+
+	/*
+	 * Make sure device is not already in RDDM. In case the device asserts
+	 * and a kernel panic follows, device will already be in RDDM.
+	 * Do not trigger SYS ERR again and proceed with waiting for
+	 * image download completion.
+	 */
+	ee = mhi_get_exec_env(mhi_cntrl);
+	if (ee != MHI_EE_RDDM) {
+		dev_dbg(dev, "Trigger device into RDDM mode using SYS ERR\n");
+		mhi_set_mhi_state(mhi_cntrl, MHI_STATE_SYS_ERR);
+
+		dev_dbg(dev, "Waiting for device to enter RDDM\n");
+		while (rddm_retry--) {
+			ee = mhi_get_exec_env(mhi_cntrl);
+			if (ee == MHI_EE_RDDM)
+				break;
+
+			udelay(delayus);
+		}
+
+		if (rddm_retry <= 0) {
+			/* Hardware reset so force device to enter RDDM */
+			dev_dbg(dev,
+				"Did not enter RDDM, do a host req reset\n");
+			mhi_write_reg(mhi_cntrl, mhi_cntrl->regs,
+				      MHI_SOC_RESET_REQ_OFFSET,
+				      MHI_SOC_RESET_REQ);
+			udelay(delayus);
+		}
+
+		ee = mhi_get_exec_env(mhi_cntrl);
+	}
+
+	dev_dbg(dev,
+		"Waiting for RDDM image download via BHIe, current EE:%s\n",
+		TO_MHI_EXEC_STR(ee));
+
+	while (retry--) {
+		ret = mhi_read_reg_field(mhi_cntrl, base, BHIE_RXVECSTATUS_OFFS,
+					 BHIE_RXVECSTATUS_STATUS_BMSK,
+					 BHIE_RXVECSTATUS_STATUS_SHFT,
+					 &rx_status);
+		if (ret)
+			return -EIO;
+
+		if (rx_status == BHIE_RXVECSTATUS_STATUS_XFER_COMPL)
+			return 0;
+
+		udelay(delayus);
+	}
+
+	ee = mhi_get_exec_env(mhi_cntrl);
+	ret = mhi_read_reg(mhi_cntrl, base, BHIE_RXVECSTATUS_OFFS, &rx_status);
+
+	dev_err(dev, "Did not complete RDDM transfer\n");
+	dev_err(dev, "Current EE: %s\n", TO_MHI_EXEC_STR(ee));
+	dev_err(dev, "RXVEC_STATUS: 0x%x\n", rx_status);
+
+	return -EIO;
+}
+
+/* Download RDDM image from device */
+int mhi_download_rddm_img(struct mhi_controller *mhi_cntrl, bool in_panic)
+{
+	void __iomem *base = mhi_cntrl->bhie;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	u32 rx_status;
+
+	if (in_panic)
+		return __mhi_download_rddm_in_panic(mhi_cntrl);
+
+	dev_dbg(dev, "Waiting for RDDM image download via BHIe\n");
+
+	/* Wait for the image download to complete */
+	wait_event_timeout(mhi_cntrl->state_event,
+			   mhi_read_reg_field(mhi_cntrl, base,
+					      BHIE_RXVECSTATUS_OFFS,
+					      BHIE_RXVECSTATUS_STATUS_BMSK,
+					      BHIE_RXVECSTATUS_STATUS_SHFT,
+					      &rx_status) || rx_status,
+			   msecs_to_jiffies(mhi_cntrl->timeout_ms));
+
+	return (rx_status == BHIE_RXVECSTATUS_STATUS_XFER_COMPL) ? 0 : -EIO;
+}
+EXPORT_SYMBOL_GPL(mhi_download_rddm_img);
+
+static int mhi_fw_load_amss(struct mhi_controller *mhi_cntrl,
+			    const struct mhi_buf *mhi_buf)
+{
+	void __iomem *base = mhi_cntrl->bhie;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	rwlock_t *pm_lock = &mhi_cntrl->pm_lock;
+	u32 tx_status, sequence_id;
+	int ret;
+
+	read_lock_bh(pm_lock);
+	if (!MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state)) {
+		read_unlock_bh(pm_lock);
+		return -EIO;
+	}
+
+	sequence_id = MHI_RANDOM_U32_NONZERO(BHIE_TXVECSTATUS_SEQNUM_BMSK);
+	dev_dbg(dev, "Starting AMSS download via BHIe. Sequence ID:%u\n",
+		sequence_id);
+	mhi_write_reg(mhi_cntrl, base, BHIE_TXVECADDR_HIGH_OFFS,
+		      upper_32_bits(mhi_buf->dma_addr));
+
+	mhi_write_reg(mhi_cntrl, base, BHIE_TXVECADDR_LOW_OFFS,
+		      lower_32_bits(mhi_buf->dma_addr));
+
+	mhi_write_reg(mhi_cntrl, base, BHIE_TXVECSIZE_OFFS, mhi_buf->len);
+
+	mhi_write_reg_field(mhi_cntrl, base, BHIE_TXVECDB_OFFS,
+			    BHIE_TXVECDB_SEQNUM_BMSK, BHIE_TXVECDB_SEQNUM_SHFT,
+			    sequence_id);
+	read_unlock_bh(pm_lock);
+
+	/* Wait for the image download to complete */
+	ret = wait_event_timeout(mhi_cntrl->state_event,
+				 MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state) ||
+				 mhi_read_reg_field(mhi_cntrl, base,
+						   BHIE_TXVECSTATUS_OFFS,
+						   BHIE_TXVECSTATUS_STATUS_BMSK,
+						   BHIE_TXVECSTATUS_STATUS_SHFT,
+						   &tx_status) || tx_status,
+				 msecs_to_jiffies(mhi_cntrl->timeout_ms));
+	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state) ||
+	    tx_status != BHIE_TXVECSTATUS_STATUS_XFER_COMPL)
+		return -EIO;
+
+	return (!ret) ? -ETIMEDOUT : 0;
+}
+
+static int mhi_fw_load_sbl(struct mhi_controller *mhi_cntrl,
+			   dma_addr_t dma_addr,
+			   size_t size)
+{
+	u32 tx_status, val, session_id;
+	int i, ret;
+	void __iomem *base = mhi_cntrl->bhi;
+	rwlock_t *pm_lock = &mhi_cntrl->pm_lock;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	struct {
+		char *name;
+		u32 offset;
+	} error_reg[] = {
+		{ "ERROR_CODE", BHI_ERRCODE },
+		{ "ERROR_DBG1", BHI_ERRDBG1 },
+		{ "ERROR_DBG2", BHI_ERRDBG2 },
+		{ "ERROR_DBG3", BHI_ERRDBG3 },
+		{ NULL },
+	};
+
+	read_lock_bh(pm_lock);
+	if (!MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state)) {
+		read_unlock_bh(pm_lock);
+		goto invalid_pm_state;
+	}
+
+	session_id = MHI_RANDOM_U32_NONZERO(BHI_TXDB_SEQNUM_BMSK);
+	dev_dbg(dev, "Starting SBL download via BHI. Session ID:%u\n",
+		session_id);
+	mhi_write_reg(mhi_cntrl, base, BHI_STATUS, 0);
+	mhi_write_reg(mhi_cntrl, base, BHI_IMGADDR_HIGH,
+		      upper_32_bits(dma_addr));
+	mhi_write_reg(mhi_cntrl, base, BHI_IMGADDR_LOW,
+		      lower_32_bits(dma_addr));
+	mhi_write_reg(mhi_cntrl, base, BHI_IMGSIZE, size);
+	mhi_write_reg(mhi_cntrl, base, BHI_IMGTXDB, session_id);
+	read_unlock_bh(pm_lock);
+
+	/* Wait for the image download to complete */
+	ret = wait_event_timeout(mhi_cntrl->state_event,
+			   MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state) ||
+			   mhi_read_reg_field(mhi_cntrl, base, BHI_STATUS,
+					      BHI_STATUS_MASK, BHI_STATUS_SHIFT,
+					      &tx_status) || tx_status,
+			   msecs_to_jiffies(mhi_cntrl->timeout_ms));
+	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state))
+		goto invalid_pm_state;
+
+	if (tx_status == BHI_STATUS_ERROR) {
+		dev_err(dev, "Image transfer failed\n");
+		read_lock_bh(pm_lock);
+		if (MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state)) {
+			for (i = 0; error_reg[i].name; i++) {
+				ret = mhi_read_reg(mhi_cntrl, base,
+						   error_reg[i].offset, &val);
+				if (ret)
+					break;
+				dev_err(dev, "Reg: %s value: 0x%x\n",
+					error_reg[i].name, val);
+			}
+		}
+		read_unlock_bh(pm_lock);
+		goto invalid_pm_state;
+	}
+
+	return (!ret) ? -ETIMEDOUT : 0;
+
+invalid_pm_state:
+
+	return -EIO;
+}
+
+void mhi_free_bhie_table(struct mhi_controller *mhi_cntrl,
+			 struct image_info *image_info)
+{
+	int i;
+	struct mhi_buf *mhi_buf = image_info->mhi_buf;
+
+	for (i = 0; i < image_info->entries; i++, mhi_buf++)
+		mhi_free_coherent(mhi_cntrl, mhi_buf->len, mhi_buf->buf,
+				  mhi_buf->dma_addr);
+
+	kfree(image_info->mhi_buf);
+	kfree(image_info);
+}
+
+int mhi_alloc_bhie_table(struct mhi_controller *mhi_cntrl,
+			 struct image_info **image_info,
+			 size_t alloc_size)
+{
+	size_t seg_size = mhi_cntrl->seg_len;
+	int segments = DIV_ROUND_UP(alloc_size, seg_size) + 1;
+	int i;
+	struct image_info *img_info;
+	struct mhi_buf *mhi_buf;
+
+	img_info = kzalloc(sizeof(*img_info), GFP_KERNEL);
+	if (!img_info)
+		return -ENOMEM;
+
+	/* Allocate memory for entries */
+	img_info->mhi_buf = kcalloc(segments, sizeof(*img_info->mhi_buf),
+				    GFP_KERNEL);
+	if (!img_info->mhi_buf)
+		goto error_alloc_mhi_buf;
+
+	/* Allocate and populate vector table */
+	mhi_buf = img_info->mhi_buf;
+	for (i = 0; i < segments; i++, mhi_buf++) {
+		size_t vec_size = seg_size;
+
+		/* Vector table is the last entry */
+		if (i == segments - 1)
+			vec_size = sizeof(struct bhi_vec_entry) * i;
+
+		mhi_buf->len = vec_size;
+		mhi_buf->buf = mhi_alloc_coherent(mhi_cntrl, vec_size,
+						  &mhi_buf->dma_addr,
+						  GFP_KERNEL);
+		if (!mhi_buf->buf)
+			goto error_alloc_segment;
+	}
+
+	img_info->bhi_vec = img_info->mhi_buf[segments - 1].buf;
+	img_info->entries = segments;
+	*image_info = img_info;
+
+	return 0;
+
+error_alloc_segment:
+	for (--i, --mhi_buf; i >= 0; i--, mhi_buf--)
+		mhi_free_coherent(mhi_cntrl, mhi_buf->len, mhi_buf->buf,
+				  mhi_buf->dma_addr);
+
+error_alloc_mhi_buf:
+	kfree(img_info);
+
+	return -ENOMEM;
+}
+
+static void mhi_firmware_copy(struct mhi_controller *mhi_cntrl,
+			      const struct firmware *firmware,
+			      struct image_info *img_info)
+{
+	size_t remainder = firmware->size;
+	size_t to_cpy;
+	const u8 *buf = firmware->data;
+	int i = 0;
+	struct mhi_buf *mhi_buf = img_info->mhi_buf;
+	struct bhi_vec_entry *bhi_vec = img_info->bhi_vec;
+
+	while (remainder) {
+		to_cpy = min(remainder, mhi_buf->len);
+		memcpy(mhi_buf->buf, buf, to_cpy);
+		bhi_vec->dma_addr = mhi_buf->dma_addr;
+		bhi_vec->size = to_cpy;
+
+		buf += to_cpy;
+		remainder -= to_cpy;
+		i++;
+		bhi_vec++;
+		mhi_buf++;
+	}
+}
+
+void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
+{
+	const struct firmware *firmware = NULL;
+	struct image_info *image_info;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	const char *fw_name;
+	void *buf;
+	dma_addr_t dma_addr;
+	size_t size;
+	int i, ret;
+
+	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
+		dev_err(dev, "Device MHI is not in valid state\n");
+		return;
+	}
+
+	/* save hardware info from BHI */
+	ret = mhi_read_reg(mhi_cntrl, mhi_cntrl->bhi, BHI_SERIALNU,
+			   &mhi_cntrl->serial_number);
+	if (ret)
+		dev_err(dev, "Could not capture serial number via BHI\n");
+
+	for (i = 0; i < ARRAY_SIZE(mhi_cntrl->oem_pk_hash); i++) {
+		ret = mhi_read_reg(mhi_cntrl, mhi_cntrl->bhi, BHI_OEMPKHASH(i),
+				   &mhi_cntrl->oem_pk_hash[i]);
+		if (ret) {
+			dev_err(dev, "Could not capture OEM PK HASH via BHI\n");
+			break;
+		}
+	}
+
+	/* If device is in pass through, do reset to ready state transition */
+	if (mhi_cntrl->ee == MHI_EE_PTHRU)
+		goto fw_load_ee_pthru;
+
+	fw_name = (mhi_cntrl->ee == MHI_EE_EDL) ?
+		mhi_cntrl->edl_image : mhi_cntrl->fw_image;
+
+	if (!fw_name || (mhi_cntrl->fbc_download && (!mhi_cntrl->sbl_size ||
+						     !mhi_cntrl->seg_len))) {
+		dev_err(dev,
+			"No firmware image defined or !sbl_size || !seg_len\n");
+		return;
+	}
+
+	ret = request_firmware(&firmware, fw_name, dev);
+	if (ret) {
+		dev_err(dev, "Error loading firmware: %d\n", ret);
+		return;
+	}
+
+	size = (mhi_cntrl->fbc_download) ? mhi_cntrl->sbl_size : firmware->size;
+
+	/* SBL size provided is maximum size, not necessarily the image size */
+	if (size > firmware->size)
+		size = firmware->size;
+
+	buf = mhi_alloc_coherent(mhi_cntrl, size, &dma_addr, GFP_KERNEL);
+	if (!buf) {
+		release_firmware(firmware);
+		return;
+	}
+
+	/* Download SBL image */
+	memcpy(buf, firmware->data, size);
+	ret = mhi_fw_load_sbl(mhi_cntrl, dma_addr, size);
+	mhi_free_coherent(mhi_cntrl, size, buf, dma_addr);
+
+	if (!mhi_cntrl->fbc_download || ret || mhi_cntrl->ee == MHI_EE_EDL)
+		release_firmware(firmware);
+
+	/* Error or in EDL mode, we're done */
+	if (ret) {
+		dev_err(dev, "MHI did not load SBL, ret:%d\n", ret);
+		return;
+	}
+
+	if (mhi_cntrl->ee == MHI_EE_EDL)
+		return;
+
+	write_lock_irq(&mhi_cntrl->pm_lock);
+	mhi_cntrl->dev_state = MHI_STATE_RESET;
+	write_unlock_irq(&mhi_cntrl->pm_lock);
+
+	/*
+	 * If we're doing fbc, populate vector tables while
+	 * device transitioning into MHI READY state
+	 */
+	if (mhi_cntrl->fbc_download) {
+		ret = mhi_alloc_bhie_table(mhi_cntrl, &mhi_cntrl->fbc_image,
+					   firmware->size);
+		if (ret)
+			goto error_alloc_fw_table;
+
+		/* Load the firmware into BHIE vec table */
+		mhi_firmware_copy(mhi_cntrl, firmware, mhi_cntrl->fbc_image);
+	}
+
+fw_load_ee_pthru:
+	/* Transitioning into MHI RESET->READY state */
+	ret = mhi_ready_state_transition(mhi_cntrl);
+
+	if (!mhi_cntrl->fbc_download)
+		return;
+
+	if (ret) {
+		dev_err(dev, "MHI did not enter READY state\n");
+		goto error_read;
+	}
+
+	/* Wait for the SBL event */
+	ret = wait_event_timeout(mhi_cntrl->state_event,
+				 mhi_cntrl->ee == MHI_EE_SBL ||
+				 MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state),
+				 msecs_to_jiffies(mhi_cntrl->timeout_ms));
+
+	if (!ret || MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
+		dev_err(dev, "MHI did not enter SBL\n");
+		goto error_read;
+	}
+
+	/* Start full firmware image download */
+	image_info = mhi_cntrl->fbc_image;
+	ret = mhi_fw_load_amss(mhi_cntrl,
+			       /* Vector table is the last entry */
+			       &image_info->mhi_buf[image_info->entries - 1]);
+	if (ret)
+		dev_err(dev, "MHI did not load AMSS, ret:%d\n", ret);
+
+	release_firmware(firmware);
+
+	return;
+
+error_read:
+	mhi_free_bhie_table(mhi_cntrl, mhi_cntrl->fbc_image);
+	mhi_cntrl->fbc_image = NULL;
+
+error_alloc_fw_table:
+	release_firmware(firmware);
+}
diff --git a/drivers/bus/mhi/host/debugfs.c b/drivers/bus/mhi/host/debugfs.c
new file mode 100644
index 000000000000..3a48801e01f4
--- /dev/null
+++ b/drivers/bus/mhi/host/debugfs.c
@@ -0,0 +1,411 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020, The Linux Foundation. All rights reserved.
+ *
+ */
+
+#include <linux/debugfs.h>
+#include <linux/device.h>
+#include <linux/interrupt.h>
+#include <linux/list.h>
+#include <linux/mhi.h>
+#include <linux/module.h>
+#include "internal.h"
+
+static int mhi_debugfs_states_show(struct seq_file *m, void *d)
+{
+	struct mhi_controller *mhi_cntrl = m->private;
+
+	/* states */
+	seq_printf(m, "PM state: %s Device: %s MHI state: %s EE: %s wake: %s\n",
+		   to_mhi_pm_state_str(mhi_cntrl->pm_state),
+		   mhi_is_active(mhi_cntrl) ? "Active" : "Inactive",
+		   TO_MHI_STATE_STR(mhi_cntrl->dev_state),
+		   TO_MHI_EXEC_STR(mhi_cntrl->ee),
+		   mhi_cntrl->wake_set ? "true" : "false");
+
+	/* counters */
+	seq_printf(m, "M0: %u M2: %u M3: %u", mhi_cntrl->M0, mhi_cntrl->M2,
+		   mhi_cntrl->M3);
+
+	seq_printf(m, " device wake: %u pending packets: %u\n",
+		   atomic_read(&mhi_cntrl->dev_wake),
+		   atomic_read(&mhi_cntrl->pending_pkts));
+
+	return 0;
+}
+
+static int mhi_debugfs_events_show(struct seq_file *m, void *d)
+{
+	struct mhi_controller *mhi_cntrl = m->private;
+	struct mhi_event *mhi_event;
+	struct mhi_event_ctxt *er_ctxt;
+	int i;
+
+	if (!mhi_is_active(mhi_cntrl)) {
+		seq_puts(m, "Device not ready\n");
+		return -ENODEV;
+	}
+
+	er_ctxt = mhi_cntrl->mhi_ctxt->er_ctxt;
+	mhi_event = mhi_cntrl->mhi_event;
+	for (i = 0; i < mhi_cntrl->total_ev_rings;
+						i++, er_ctxt++, mhi_event++) {
+		struct mhi_ring *ring = &mhi_event->ring;
+
+		if (mhi_event->offload_ev) {
+			seq_printf(m, "Index: %d is an offload event ring\n",
+				   i);
+			continue;
+		}
+
+		seq_printf(m, "Index: %d intmod count: %lu time: %lu",
+			   i, (er_ctxt->intmod & EV_CTX_INTMODC_MASK) >>
+			   EV_CTX_INTMODC_SHIFT,
+			   (er_ctxt->intmod & EV_CTX_INTMODT_MASK) >>
+			   EV_CTX_INTMODT_SHIFT);
+
+		seq_printf(m, " base: 0x%0llx len: 0x%llx", er_ctxt->rbase,
+			   er_ctxt->rlen);
+
+		seq_printf(m, " rp: 0x%llx wp: 0x%llx", er_ctxt->rp,
+			   er_ctxt->wp);
+
+		seq_printf(m, " local rp: 0x%pK db: 0x%pad\n", ring->rp,
+			   &mhi_event->db_cfg.db_val);
+	}
+
+	return 0;
+}
+
+static int mhi_debugfs_channels_show(struct seq_file *m, void *d)
+{
+	struct mhi_controller *mhi_cntrl = m->private;
+	struct mhi_chan *mhi_chan;
+	struct mhi_chan_ctxt *chan_ctxt;
+	int i;
+
+	if (!mhi_is_active(mhi_cntrl)) {
+		seq_puts(m, "Device not ready\n");
+		return -ENODEV;
+	}
+
+	mhi_chan = mhi_cntrl->mhi_chan;
+	chan_ctxt = mhi_cntrl->mhi_ctxt->chan_ctxt;
+	for (i = 0; i < mhi_cntrl->max_chan; i++, chan_ctxt++, mhi_chan++) {
+		struct mhi_ring *ring = &mhi_chan->tre_ring;
+
+		if (mhi_chan->offload_ch) {
+			seq_printf(m, "%s(%u) is an offload channel\n",
+				   mhi_chan->name, mhi_chan->chan);
+			continue;
+		}
+
+		if (!mhi_chan->mhi_dev)
+			continue;
+
+		seq_printf(m,
+			   "%s(%u) state: 0x%lx brstmode: 0x%lx pollcfg: 0x%lx",
+			   mhi_chan->name, mhi_chan->chan, (chan_ctxt->chcfg &
+			   CHAN_CTX_CHSTATE_MASK) >> CHAN_CTX_CHSTATE_SHIFT,
+			   (chan_ctxt->chcfg & CHAN_CTX_BRSTMODE_MASK) >>
+			   CHAN_CTX_BRSTMODE_SHIFT, (chan_ctxt->chcfg &
+			   CHAN_CTX_POLLCFG_MASK) >> CHAN_CTX_POLLCFG_SHIFT);
+
+		seq_printf(m, " type: 0x%x event ring: %u", chan_ctxt->chtype,
+			   chan_ctxt->erindex);
+
+		seq_printf(m, " base: 0x%llx len: 0x%llx rp: 0x%llx wp: 0x%llx",
+			   chan_ctxt->rbase, chan_ctxt->rlen, chan_ctxt->rp,
+			   chan_ctxt->wp);
+
+		seq_printf(m, " local rp: 0x%pK local wp: 0x%pK db: 0x%pad\n",
+			   ring->rp, ring->wp,
+			   &mhi_chan->db_cfg.db_val);
+	}
+
+	return 0;
+}
+
+static int mhi_device_info_show(struct device *dev, void *data)
+{
+	struct mhi_device *mhi_dev;
+
+	if (dev->bus != &mhi_bus_type)
+		return 0;
+
+	mhi_dev = to_mhi_device(dev);
+
+	seq_printf((struct seq_file *)data, "%s: type: %s dev_wake: %u",
+		   mhi_dev->name, mhi_dev->dev_type ? "Controller" : "Transfer",
+		   mhi_dev->dev_wake);
+
+	/* for transfer device types only */
+	if (mhi_dev->dev_type == MHI_DEVICE_XFER)
+		seq_printf((struct seq_file *)data, " channels: %u(UL)/%u(DL)",
+			   mhi_dev->ul_chan_id, mhi_dev->dl_chan_id);
+
+	seq_puts((struct seq_file *)data, "\n");
+
+	return 0;
+}
+
+static int mhi_debugfs_devices_show(struct seq_file *m, void *d)
+{
+	struct mhi_controller *mhi_cntrl = m->private;
+
+	if (!mhi_is_active(mhi_cntrl)) {
+		seq_puts(m, "Device not ready\n");
+		return -ENODEV;
+	}
+
+	device_for_each_child(mhi_cntrl->cntrl_dev, m, mhi_device_info_show);
+
+	return 0;
+}
+
+static int mhi_debugfs_regdump_show(struct seq_file *m, void *d)
+{
+	struct mhi_controller *mhi_cntrl = m->private;
+	enum mhi_state state;
+	enum mhi_ee_type ee;
+	int i, ret = -EIO;
+	u32 val;
+	void __iomem *mhi_base = mhi_cntrl->regs;
+	void __iomem *bhi_base = mhi_cntrl->bhi;
+	void __iomem *bhie_base = mhi_cntrl->bhie;
+	void __iomem *wake_db = mhi_cntrl->wake_db;
+	struct {
+		const char *name;
+		int offset;
+		void __iomem *base;
+	} regs[] = {
+		{ "MHI_REGLEN", MHIREGLEN, mhi_base},
+		{ "MHI_VER", MHIVER, mhi_base},
+		{ "MHI_CFG", MHICFG, mhi_base},
+		{ "MHI_CTRL", MHICTRL, mhi_base},
+		{ "MHI_STATUS", MHISTATUS, mhi_base},
+		{ "MHI_WAKE_DB", 0, wake_db},
+		{ "BHI_EXECENV", BHI_EXECENV, bhi_base},
+		{ "BHI_STATUS", BHI_STATUS, bhi_base},
+		{ "BHI_ERRCODE", BHI_ERRCODE, bhi_base},
+		{ "BHI_ERRDBG1", BHI_ERRDBG1, bhi_base},
+		{ "BHI_ERRDBG2", BHI_ERRDBG2, bhi_base},
+		{ "BHI_ERRDBG3", BHI_ERRDBG3, bhi_base},
+		{ "BHIE_TXVEC_DB", BHIE_TXVECDB_OFFS, bhie_base},
+		{ "BHIE_TXVEC_STATUS", BHIE_TXVECSTATUS_OFFS, bhie_base},
+		{ "BHIE_RXVEC_DB", BHIE_RXVECDB_OFFS, bhie_base},
+		{ "BHIE_RXVEC_STATUS", BHIE_RXVECSTATUS_OFFS, bhie_base},
+		{ NULL },
+	};
+
+	if (!MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state))
+		return ret;
+
+	seq_printf(m, "Host PM state: %s Device state: %s EE: %s\n",
+		   to_mhi_pm_state_str(mhi_cntrl->pm_state),
+		   TO_MHI_STATE_STR(mhi_cntrl->dev_state),
+		   TO_MHI_EXEC_STR(mhi_cntrl->ee));
+
+	state = mhi_get_mhi_state(mhi_cntrl);
+	ee = mhi_get_exec_env(mhi_cntrl);
+	seq_printf(m, "Device EE: %s state: %s\n", TO_MHI_EXEC_STR(ee),
+		   TO_MHI_STATE_STR(state));
+
+	for (i = 0; regs[i].name; i++) {
+		if (!regs[i].base)
+			continue;
+		ret = mhi_read_reg(mhi_cntrl, regs[i].base, regs[i].offset,
+				   &val);
+		if (ret)
+			continue;
+
+		seq_printf(m, "%s: 0x%x\n", regs[i].name, val);
+	}
+
+	return 0;
+}
+
+static int mhi_debugfs_device_wake_show(struct seq_file *m, void *d)
+{
+	struct mhi_controller *mhi_cntrl = m->private;
+	struct mhi_device *mhi_dev = mhi_cntrl->mhi_dev;
+
+	if (!mhi_is_active(mhi_cntrl)) {
+		seq_puts(m, "Device not ready\n");
+		return -ENODEV;
+	}
+
+	seq_printf(m,
+		   "Wake count: %d\n%s\n", mhi_dev->dev_wake,
+		   "Usage: echo get/put > device_wake to vote/unvote for M0");
+
+	return 0;
+}
+
+static ssize_t mhi_debugfs_device_wake_write(struct file *file,
+					     const char __user *ubuf,
+					     size_t count, loff_t *ppos)
+{
+	struct seq_file	*m = file->private_data;
+	struct mhi_controller *mhi_cntrl = m->private;
+	struct mhi_device *mhi_dev = mhi_cntrl->mhi_dev;
+	char buf[16];
+	int ret = -EINVAL;
+
+	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
+		return -EFAULT;
+
+	if (!strncmp(buf, "get", 3)) {
+		ret = mhi_device_get_sync(mhi_dev);
+	} else if (!strncmp(buf, "put", 3)) {
+		mhi_device_put(mhi_dev);
+		ret = 0;
+	}
+
+	return ret ? ret : count;
+}
+
+static int mhi_debugfs_timeout_ms_show(struct seq_file *m, void *d)
+{
+	struct mhi_controller *mhi_cntrl = m->private;
+
+	seq_printf(m, "%u ms\n", mhi_cntrl->timeout_ms);
+
+	return 0;
+}
+
+static ssize_t mhi_debugfs_timeout_ms_write(struct file *file,
+					    const char __user *ubuf,
+					    size_t count, loff_t *ppos)
+{
+	struct seq_file	*m = file->private_data;
+	struct mhi_controller *mhi_cntrl = m->private;
+	u32 timeout_ms;
+
+	if (kstrtou32_from_user(ubuf, count, 0, &timeout_ms))
+		return -EINVAL;
+
+	mhi_cntrl->timeout_ms = timeout_ms;
+
+	return count;
+}
+
+static int mhi_debugfs_states_open(struct inode *inode, struct file *fp)
+{
+	return single_open(fp, mhi_debugfs_states_show, inode->i_private);
+}
+
+static int mhi_debugfs_events_open(struct inode *inode, struct file *fp)
+{
+	return single_open(fp, mhi_debugfs_events_show, inode->i_private);
+}
+
+static int mhi_debugfs_channels_open(struct inode *inode, struct file *fp)
+{
+	return single_open(fp, mhi_debugfs_channels_show, inode->i_private);
+}
+
+static int mhi_debugfs_devices_open(struct inode *inode, struct file *fp)
+{
+	return single_open(fp, mhi_debugfs_devices_show, inode->i_private);
+}
+
+static int mhi_debugfs_regdump_open(struct inode *inode, struct file *fp)
+{
+	return single_open(fp, mhi_debugfs_regdump_show, inode->i_private);
+}
+
+static int mhi_debugfs_device_wake_open(struct inode *inode, struct file *fp)
+{
+	return single_open(fp, mhi_debugfs_device_wake_show, inode->i_private);
+}
+
+static int mhi_debugfs_timeout_ms_open(struct inode *inode, struct file *fp)
+{
+	return single_open(fp, mhi_debugfs_timeout_ms_show, inode->i_private);
+}
+
+static const struct file_operations debugfs_states_fops = {
+	.open = mhi_debugfs_states_open,
+	.release = single_release,
+	.read = seq_read,
+};
+
+static const struct file_operations debugfs_events_fops = {
+	.open = mhi_debugfs_events_open,
+	.release = single_release,
+	.read = seq_read,
+};
+
+static const struct file_operations debugfs_channels_fops = {
+	.open = mhi_debugfs_channels_open,
+	.release = single_release,
+	.read = seq_read,
+};
+
+static const struct file_operations debugfs_devices_fops = {
+	.open = mhi_debugfs_devices_open,
+	.release = single_release,
+	.read = seq_read,
+};
+
+static const struct file_operations debugfs_regdump_fops = {
+	.open = mhi_debugfs_regdump_open,
+	.release = single_release,
+	.read = seq_read,
+};
+
+static const struct file_operations debugfs_device_wake_fops = {
+	.open = mhi_debugfs_device_wake_open,
+	.write = mhi_debugfs_device_wake_write,
+	.release = single_release,
+	.read = seq_read,
+};
+
+static const struct file_operations debugfs_timeout_ms_fops = {
+	.open = mhi_debugfs_timeout_ms_open,
+	.write = mhi_debugfs_timeout_ms_write,
+	.release = single_release,
+	.read = seq_read,
+};
+
+static struct dentry *mhi_debugfs_root;
+
+void mhi_create_debugfs(struct mhi_controller *mhi_cntrl)
+{
+	mhi_cntrl->debugfs_dentry =
+			debugfs_create_dir(dev_name(mhi_cntrl->cntrl_dev),
+					   mhi_debugfs_root);
+
+	debugfs_create_file("states", 0444, mhi_cntrl->debugfs_dentry,
+			    mhi_cntrl, &debugfs_states_fops);
+	debugfs_create_file("events", 0444, mhi_cntrl->debugfs_dentry,
+			    mhi_cntrl, &debugfs_events_fops);
+	debugfs_create_file("channels", 0444, mhi_cntrl->debugfs_dentry,
+			    mhi_cntrl, &debugfs_channels_fops);
+	debugfs_create_file("devices", 0444, mhi_cntrl->debugfs_dentry,
+			    mhi_cntrl, &debugfs_devices_fops);
+	debugfs_create_file("regdump", 0444, mhi_cntrl->debugfs_dentry,
+			    mhi_cntrl, &debugfs_regdump_fops);
+	debugfs_create_file("device_wake", 0644, mhi_cntrl->debugfs_dentry,
+			    mhi_cntrl, &debugfs_device_wake_fops);
+	debugfs_create_file("timeout_ms", 0644, mhi_cntrl->debugfs_dentry,
+			    mhi_cntrl, &debugfs_timeout_ms_fops);
+}
+
+void mhi_destroy_debugfs(struct mhi_controller *mhi_cntrl)
+{
+	debugfs_remove_recursive(mhi_cntrl->debugfs_dentry);
+	mhi_cntrl->debugfs_dentry = NULL;
+}
+
+void mhi_debugfs_init(void)
+{
+	mhi_debugfs_root = debugfs_create_dir(mhi_bus_type.name, NULL);
+}
+
+void mhi_debugfs_exit(void)
+{
+	debugfs_remove_recursive(mhi_debugfs_root);
+}
diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
new file mode 100644
index 000000000000..2cc48f96afdb
--- /dev/null
+++ b/drivers/bus/mhi/host/init.c
@@ -0,0 +1,1387 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018-2020, The Linux Foundation. All rights reserved.
+ *
+ */
+
+#include <linux/debugfs.h>
+#include <linux/device.h>
+#include <linux/dma-direction.h>
+#include <linux/dma-mapping.h>
+#include <linux/interrupt.h>
+#include <linux/list.h>
+#include <linux/mhi.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+#include <linux/wait.h>
+#include "internal.h"
+
+const char * const mhi_ee_str[MHI_EE_MAX] = {
+	[MHI_EE_PBL] = "PBL",
+	[MHI_EE_SBL] = "SBL",
+	[MHI_EE_AMSS] = "AMSS",
+	[MHI_EE_RDDM] = "RDDM",
+	[MHI_EE_WFW] = "WFW",
+	[MHI_EE_PTHRU] = "PASS THRU",
+	[MHI_EE_EDL] = "EDL",
+	[MHI_EE_DISABLE_TRANSITION] = "DISABLE",
+	[MHI_EE_NOT_SUPPORTED] = "NOT SUPPORTED",
+};
+
+const char * const dev_state_tran_str[DEV_ST_TRANSITION_MAX] = {
+	[DEV_ST_TRANSITION_PBL] = "PBL",
+	[DEV_ST_TRANSITION_READY] = "READY",
+	[DEV_ST_TRANSITION_SBL] = "SBL",
+	[DEV_ST_TRANSITION_MISSION_MODE] = "MISSION_MODE",
+	[DEV_ST_TRANSITION_SYS_ERR] = "SYS_ERR",
+	[DEV_ST_TRANSITION_DISABLE] = "DISABLE",
+};
+
+const char * const mhi_state_str[MHI_STATE_MAX] = {
+	[MHI_STATE_RESET] = "RESET",
+	[MHI_STATE_READY] = "READY",
+	[MHI_STATE_M0] = "M0",
+	[MHI_STATE_M1] = "M1",
+	[MHI_STATE_M2] = "M2",
+	[MHI_STATE_M3] = "M3",
+	[MHI_STATE_M3_FAST] = "M3_FAST",
+	[MHI_STATE_BHI] = "BHI",
+	[MHI_STATE_SYS_ERR] = "SYS_ERR",
+};
+
+static const char * const mhi_pm_state_str[] = {
+	[MHI_PM_STATE_DISABLE] = "DISABLE",
+	[MHI_PM_STATE_POR] = "POR",
+	[MHI_PM_STATE_M0] = "M0",
+	[MHI_PM_STATE_M2] = "M2",
+	[MHI_PM_STATE_M3_ENTER] = "M?->M3",
+	[MHI_PM_STATE_M3] = "M3",
+	[MHI_PM_STATE_M3_EXIT] = "M3->M0",
+	[MHI_PM_STATE_FW_DL_ERR] = "FW DL Error",
+	[MHI_PM_STATE_SYS_ERR_DETECT] = "SYS_ERR Detect",
+	[MHI_PM_STATE_SYS_ERR_PROCESS] = "SYS_ERR Process",
+	[MHI_PM_STATE_SHUTDOWN_PROCESS] = "SHUTDOWN Process",
+	[MHI_PM_STATE_LD_ERR_FATAL_DETECT] = "LD or Error Fatal Detect",
+};
+
+const char *to_mhi_pm_state_str(enum mhi_pm_state state)
+{
+	int index = find_last_bit((unsigned long *)&state, 32);
+
+	if (index >= ARRAY_SIZE(mhi_pm_state_str))
+		return "Invalid State";
+
+	return mhi_pm_state_str[index];
+}
+
+static ssize_t serial_number_show(struct device *dev,
+				  struct device_attribute *attr,
+				  char *buf)
+{
+	struct mhi_device *mhi_dev = to_mhi_device(dev);
+	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
+
+	return snprintf(buf, PAGE_SIZE, "Serial Number: %u\n",
+			mhi_cntrl->serial_number);
+}
+static DEVICE_ATTR_RO(serial_number);
+
+static ssize_t oem_pk_hash_show(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct mhi_device *mhi_dev = to_mhi_device(dev);
+	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
+	int i, cnt = 0;
+
+	for (i = 0; i < ARRAY_SIZE(mhi_cntrl->oem_pk_hash); i++)
+		cnt += snprintf(buf + cnt, PAGE_SIZE - cnt,
+				"OEMPKHASH[%d]: 0x%x\n", i,
+				mhi_cntrl->oem_pk_hash[i]);
+
+	return cnt;
+}
+static DEVICE_ATTR_RO(oem_pk_hash);
+
+static struct attribute *mhi_dev_attrs[] = {
+	&dev_attr_serial_number.attr,
+	&dev_attr_oem_pk_hash.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(mhi_dev);
+
+/* MHI protocol requires the transfer ring to be aligned with ring length */
+static int mhi_alloc_aligned_ring(struct mhi_controller *mhi_cntrl,
+				  struct mhi_ring *ring,
+				  u64 len)
+{
+	ring->alloc_size = len + (len - 1);
+	ring->pre_aligned = mhi_alloc_coherent(mhi_cntrl, ring->alloc_size,
+					       &ring->dma_handle, GFP_KERNEL);
+	if (!ring->pre_aligned)
+		return -ENOMEM;
+
+	ring->iommu_base = (ring->dma_handle + (len - 1)) & ~(len - 1);
+	ring->base = ring->pre_aligned + (ring->iommu_base - ring->dma_handle);
+
+	return 0;
+}
+
+void mhi_deinit_free_irq(struct mhi_controller *mhi_cntrl)
+{
+	int i;
+	struct mhi_event *mhi_event = mhi_cntrl->mhi_event;
+
+	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
+		if (mhi_event->offload_ev)
+			continue;
+
+		free_irq(mhi_cntrl->irq[mhi_event->irq], mhi_event);
+	}
+
+	free_irq(mhi_cntrl->irq[0], mhi_cntrl);
+}
+
+int mhi_init_irq_setup(struct mhi_controller *mhi_cntrl)
+{
+	struct mhi_event *mhi_event = mhi_cntrl->mhi_event;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	int i, ret;
+
+	/* Setup BHI_INTVEC IRQ */
+	ret = request_threaded_irq(mhi_cntrl->irq[0], mhi_intvec_handler,
+				   mhi_intvec_threaded_handler,
+				   IRQF_SHARED | IRQF_NO_SUSPEND,
+				   "bhi", mhi_cntrl);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
+		if (mhi_event->offload_ev)
+			continue;
+
+		if (mhi_event->irq >= mhi_cntrl->nr_irqs) {
+			dev_err(dev, "irq %d not available for event ring\n",
+				mhi_event->irq);
+			ret = -EINVAL;
+			goto error_request;
+		}
+
+		ret = request_irq(mhi_cntrl->irq[mhi_event->irq],
+				  mhi_irq_handler,
+				  IRQF_SHARED | IRQF_NO_SUSPEND,
+				  "mhi", mhi_event);
+		if (ret) {
+			dev_err(dev, "Error requesting irq:%d for ev:%d\n",
+				mhi_cntrl->irq[mhi_event->irq], i);
+			goto error_request;
+		}
+	}
+
+	return 0;
+
+error_request:
+	for (--i, --mhi_event; i >= 0; i--, mhi_event--) {
+		if (mhi_event->offload_ev)
+			continue;
+
+		free_irq(mhi_cntrl->irq[mhi_event->irq], mhi_event);
+	}
+	free_irq(mhi_cntrl->irq[0], mhi_cntrl);
+
+	return ret;
+}
+
+void mhi_deinit_dev_ctxt(struct mhi_controller *mhi_cntrl)
+{
+	int i;
+	struct mhi_ctxt *mhi_ctxt = mhi_cntrl->mhi_ctxt;
+	struct mhi_cmd *mhi_cmd;
+	struct mhi_event *mhi_event;
+	struct mhi_ring *ring;
+
+	mhi_cmd = mhi_cntrl->mhi_cmd;
+	for (i = 0; i < NR_OF_CMD_RINGS; i++, mhi_cmd++) {
+		ring = &mhi_cmd->ring;
+		mhi_free_coherent(mhi_cntrl, ring->alloc_size,
+				  ring->pre_aligned, ring->dma_handle);
+		ring->base = NULL;
+		ring->iommu_base = 0;
+	}
+
+	mhi_free_coherent(mhi_cntrl,
+			  sizeof(*mhi_ctxt->cmd_ctxt) * NR_OF_CMD_RINGS,
+			  mhi_ctxt->cmd_ctxt, mhi_ctxt->cmd_ctxt_addr);
+
+	mhi_event = mhi_cntrl->mhi_event;
+	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
+		if (mhi_event->offload_ev)
+			continue;
+
+		ring = &mhi_event->ring;
+		mhi_free_coherent(mhi_cntrl, ring->alloc_size,
+				  ring->pre_aligned, ring->dma_handle);
+		ring->base = NULL;
+		ring->iommu_base = 0;
+	}
+
+	mhi_free_coherent(mhi_cntrl, sizeof(*mhi_ctxt->er_ctxt) *
+			  mhi_cntrl->total_ev_rings, mhi_ctxt->er_ctxt,
+			  mhi_ctxt->er_ctxt_addr);
+
+	mhi_free_coherent(mhi_cntrl, sizeof(*mhi_ctxt->chan_ctxt) *
+			  mhi_cntrl->max_chan, mhi_ctxt->chan_ctxt,
+			  mhi_ctxt->chan_ctxt_addr);
+
+	kfree(mhi_ctxt);
+	mhi_cntrl->mhi_ctxt = NULL;
+}
+
+int mhi_init_dev_ctxt(struct mhi_controller *mhi_cntrl)
+{
+	struct mhi_ctxt *mhi_ctxt;
+	struct mhi_chan_ctxt *chan_ctxt;
+	struct mhi_event_ctxt *er_ctxt;
+	struct mhi_cmd_ctxt *cmd_ctxt;
+	struct mhi_chan *mhi_chan;
+	struct mhi_event *mhi_event;
+	struct mhi_cmd *mhi_cmd;
+	u32 tmp;
+	int ret = -ENOMEM, i;
+
+	atomic_set(&mhi_cntrl->dev_wake, 0);
+	atomic_set(&mhi_cntrl->pending_pkts, 0);
+
+	mhi_ctxt = kzalloc(sizeof(*mhi_ctxt), GFP_KERNEL);
+	if (!mhi_ctxt)
+		return -ENOMEM;
+
+	/* Setup channel ctxt */
+	mhi_ctxt->chan_ctxt = mhi_alloc_coherent(mhi_cntrl,
+						 sizeof(*mhi_ctxt->chan_ctxt) *
+						 mhi_cntrl->max_chan,
+						 &mhi_ctxt->chan_ctxt_addr,
+						 GFP_KERNEL);
+	if (!mhi_ctxt->chan_ctxt)
+		goto error_alloc_chan_ctxt;
+
+	mhi_chan = mhi_cntrl->mhi_chan;
+	chan_ctxt = mhi_ctxt->chan_ctxt;
+	for (i = 0; i < mhi_cntrl->max_chan; i++, chan_ctxt++, mhi_chan++) {
+		/* Skip if it is an offload channel */
+		if (mhi_chan->offload_ch)
+			continue;
+
+		tmp = chan_ctxt->chcfg;
+		tmp &= ~CHAN_CTX_CHSTATE_MASK;
+		tmp |= (MHI_CH_STATE_DISABLED << CHAN_CTX_CHSTATE_SHIFT);
+		tmp &= ~CHAN_CTX_BRSTMODE_MASK;
+		tmp |= (mhi_chan->db_cfg.brstmode << CHAN_CTX_BRSTMODE_SHIFT);
+		tmp &= ~CHAN_CTX_POLLCFG_MASK;
+		tmp |= (mhi_chan->db_cfg.pollcfg << CHAN_CTX_POLLCFG_SHIFT);
+		chan_ctxt->chcfg = tmp;
+
+		chan_ctxt->chtype = mhi_chan->type;
+		chan_ctxt->erindex = mhi_chan->er_index;
+
+		mhi_chan->ch_state = MHI_CH_STATE_DISABLED;
+		mhi_chan->tre_ring.db_addr = (void __iomem *)&chan_ctxt->wp;
+	}
+
+	/* Setup event context */
+	mhi_ctxt->er_ctxt = mhi_alloc_coherent(mhi_cntrl,
+					       sizeof(*mhi_ctxt->er_ctxt) *
+					       mhi_cntrl->total_ev_rings,
+					       &mhi_ctxt->er_ctxt_addr,
+					       GFP_KERNEL);
+	if (!mhi_ctxt->er_ctxt)
+		goto error_alloc_er_ctxt;
+
+	er_ctxt = mhi_ctxt->er_ctxt;
+	mhi_event = mhi_cntrl->mhi_event;
+	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, er_ctxt++,
+		     mhi_event++) {
+		struct mhi_ring *ring = &mhi_event->ring;
+
+		/* Skip if it is an offload event */
+		if (mhi_event->offload_ev)
+			continue;
+
+		tmp = er_ctxt->intmod;
+		tmp &= ~EV_CTX_INTMODC_MASK;
+		tmp &= ~EV_CTX_INTMODT_MASK;
+		tmp |= (mhi_event->intmod << EV_CTX_INTMODT_SHIFT);
+		er_ctxt->intmod = tmp;
+
+		er_ctxt->ertype = MHI_ER_TYPE_VALID;
+		er_ctxt->msivec = mhi_event->irq;
+		mhi_event->db_cfg.db_mode = true;
+
+		ring->el_size = sizeof(struct mhi_tre);
+		ring->len = ring->el_size * ring->elements;
+		ret = mhi_alloc_aligned_ring(mhi_cntrl, ring, ring->len);
+		if (ret)
+			goto error_alloc_er;
+
+		/*
+		 * If the read pointer equals to the write pointer, then the
+		 * ring is empty
+		 */
+		ring->rp = ring->wp = ring->base;
+		er_ctxt->rbase = ring->iommu_base;
+		er_ctxt->rp = er_ctxt->wp = er_ctxt->rbase;
+		er_ctxt->rlen = ring->len;
+		ring->ctxt_wp = &er_ctxt->wp;
+	}
+
+	/* Setup cmd context */
+	ret = -ENOMEM;
+	mhi_ctxt->cmd_ctxt = mhi_alloc_coherent(mhi_cntrl,
+						sizeof(*mhi_ctxt->cmd_ctxt) *
+						NR_OF_CMD_RINGS,
+						&mhi_ctxt->cmd_ctxt_addr,
+						GFP_KERNEL);
+	if (!mhi_ctxt->cmd_ctxt)
+		goto error_alloc_er;
+
+	mhi_cmd = mhi_cntrl->mhi_cmd;
+	cmd_ctxt = mhi_ctxt->cmd_ctxt;
+	for (i = 0; i < NR_OF_CMD_RINGS; i++, mhi_cmd++, cmd_ctxt++) {
+		struct mhi_ring *ring = &mhi_cmd->ring;
+
+		ring->el_size = sizeof(struct mhi_tre);
+		ring->elements = CMD_EL_PER_RING;
+		ring->len = ring->el_size * ring->elements;
+		ret = mhi_alloc_aligned_ring(mhi_cntrl, ring, ring->len);
+		if (ret)
+			goto error_alloc_cmd;
+
+		ring->rp = ring->wp = ring->base;
+		cmd_ctxt->rbase = ring->iommu_base;
+		cmd_ctxt->rp = cmd_ctxt->wp = cmd_ctxt->rbase;
+		cmd_ctxt->rlen = ring->len;
+		ring->ctxt_wp = &cmd_ctxt->wp;
+	}
+
+	mhi_cntrl->mhi_ctxt = mhi_ctxt;
+
+	return 0;
+
+error_alloc_cmd:
+	for (--i, --mhi_cmd; i >= 0; i--, mhi_cmd--) {
+		struct mhi_ring *ring = &mhi_cmd->ring;
+
+		mhi_free_coherent(mhi_cntrl, ring->alloc_size,
+				  ring->pre_aligned, ring->dma_handle);
+	}
+	mhi_free_coherent(mhi_cntrl,
+			  sizeof(*mhi_ctxt->cmd_ctxt) * NR_OF_CMD_RINGS,
+			  mhi_ctxt->cmd_ctxt, mhi_ctxt->cmd_ctxt_addr);
+	i = mhi_cntrl->total_ev_rings;
+	mhi_event = mhi_cntrl->mhi_event + i;
+
+error_alloc_er:
+	for (--i, --mhi_event; i >= 0; i--, mhi_event--) {
+		struct mhi_ring *ring = &mhi_event->ring;
+
+		if (mhi_event->offload_ev)
+			continue;
+
+		mhi_free_coherent(mhi_cntrl, ring->alloc_size,
+				  ring->pre_aligned, ring->dma_handle);
+	}
+	mhi_free_coherent(mhi_cntrl, sizeof(*mhi_ctxt->er_ctxt) *
+			  mhi_cntrl->total_ev_rings, mhi_ctxt->er_ctxt,
+			  mhi_ctxt->er_ctxt_addr);
+
+error_alloc_er_ctxt:
+	mhi_free_coherent(mhi_cntrl, sizeof(*mhi_ctxt->chan_ctxt) *
+			  mhi_cntrl->max_chan, mhi_ctxt->chan_ctxt,
+			  mhi_ctxt->chan_ctxt_addr);
+
+error_alloc_chan_ctxt:
+	kfree(mhi_ctxt);
+
+	return ret;
+}
+
+int mhi_init_mmio(struct mhi_controller *mhi_cntrl)
+{
+	u32 val;
+	int i, ret;
+	struct mhi_chan *mhi_chan;
+	struct mhi_event *mhi_event;
+	void __iomem *base = mhi_cntrl->regs;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	struct {
+		u32 offset;
+		u32 mask;
+		u32 shift;
+		u32 val;
+	} reg_info[] = {
+		{
+			CCABAP_HIGHER, U32_MAX, 0,
+			upper_32_bits(mhi_cntrl->mhi_ctxt->chan_ctxt_addr),
+		},
+		{
+			CCABAP_LOWER, U32_MAX, 0,
+			lower_32_bits(mhi_cntrl->mhi_ctxt->chan_ctxt_addr),
+		},
+		{
+			ECABAP_HIGHER, U32_MAX, 0,
+			upper_32_bits(mhi_cntrl->mhi_ctxt->er_ctxt_addr),
+		},
+		{
+			ECABAP_LOWER, U32_MAX, 0,
+			lower_32_bits(mhi_cntrl->mhi_ctxt->er_ctxt_addr),
+		},
+		{
+			CRCBAP_HIGHER, U32_MAX, 0,
+			upper_32_bits(mhi_cntrl->mhi_ctxt->cmd_ctxt_addr),
+		},
+		{
+			CRCBAP_LOWER, U32_MAX, 0,
+			lower_32_bits(mhi_cntrl->mhi_ctxt->cmd_ctxt_addr),
+		},
+		{
+			MHICFG, MHICFG_NER_MASK, MHICFG_NER_SHIFT,
+			mhi_cntrl->total_ev_rings,
+		},
+		{
+			MHICFG, MHICFG_NHWER_MASK, MHICFG_NHWER_SHIFT,
+			mhi_cntrl->hw_ev_rings,
+		},
+		{
+			MHICTRLBASE_HIGHER, U32_MAX, 0,
+			upper_32_bits(mhi_cntrl->iova_start),
+		},
+		{
+			MHICTRLBASE_LOWER, U32_MAX, 0,
+			lower_32_bits(mhi_cntrl->iova_start),
+		},
+		{
+			MHIDATABASE_HIGHER, U32_MAX, 0,
+			upper_32_bits(mhi_cntrl->iova_start),
+		},
+		{
+			MHIDATABASE_LOWER, U32_MAX, 0,
+			lower_32_bits(mhi_cntrl->iova_start),
+		},
+		{
+			MHICTRLLIMIT_HIGHER, U32_MAX, 0,
+			upper_32_bits(mhi_cntrl->iova_stop),
+		},
+		{
+			MHICTRLLIMIT_LOWER, U32_MAX, 0,
+			lower_32_bits(mhi_cntrl->iova_stop),
+		},
+		{
+			MHIDATALIMIT_HIGHER, U32_MAX, 0,
+			upper_32_bits(mhi_cntrl->iova_stop),
+		},
+		{
+			MHIDATALIMIT_LOWER, U32_MAX, 0,
+			lower_32_bits(mhi_cntrl->iova_stop),
+		},
+		{ 0, 0, 0 }
+	};
+
+	dev_dbg(dev, "Initializing MHI registers\n");
+
+	/* Read channel db offset */
+	ret = mhi_read_reg_field(mhi_cntrl, base, CHDBOFF, CHDBOFF_CHDBOFF_MASK,
+				 CHDBOFF_CHDBOFF_SHIFT, &val);
+	if (ret) {
+		dev_err(dev, "Unable to read CHDBOFF register\n");
+		return -EIO;
+	}
+
+	if (val >= mhi_cntrl->reg_len - (8 * MHI_DEV_WAKE_DB)) {
+		dev_err(dev, "CHDB offset: 0x%x is out of range: 0x%zx\n",
+			val, mhi_cntrl->reg_len - (8 * MHI_DEV_WAKE_DB));
+		return -ERANGE;
+	}
+
+	/* Setup wake db */
+	mhi_cntrl->wake_db = base + val + (8 * MHI_DEV_WAKE_DB);
+	mhi_write_reg(mhi_cntrl, mhi_cntrl->wake_db, 4, 0);
+	mhi_write_reg(mhi_cntrl, mhi_cntrl->wake_db, 0, 0);
+	mhi_cntrl->wake_set = false;
+
+	/* Setup channel db address for each channel in tre_ring */
+	mhi_chan = mhi_cntrl->mhi_chan;
+	for (i = 0; i < mhi_cntrl->max_chan; i++, val += 8, mhi_chan++)
+		mhi_chan->tre_ring.db_addr = base + val;
+
+	/* Read event ring db offset */
+	ret = mhi_read_reg_field(mhi_cntrl, base, ERDBOFF, ERDBOFF_ERDBOFF_MASK,
+				 ERDBOFF_ERDBOFF_SHIFT, &val);
+	if (ret) {
+		dev_err(dev, "Unable to read ERDBOFF register\n");
+		return -EIO;
+	}
+
+	if (val >= mhi_cntrl->reg_len - (8 * mhi_cntrl->total_ev_rings)) {
+		dev_err(dev, "ERDB offset: 0x%x is out of range: 0x%zx\n",
+			val, mhi_cntrl->reg_len - (8 * mhi_cntrl->total_ev_rings));
+		return -ERANGE;
+	}
+
+	/* Setup event db address for each ev_ring */
+	mhi_event = mhi_cntrl->mhi_event;
+	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, val += 8, mhi_event++) {
+		if (mhi_event->offload_ev)
+			continue;
+
+		mhi_event->ring.db_addr = base + val;
+	}
+
+	/* Setup DB register for primary CMD rings */
+	mhi_cntrl->mhi_cmd[PRIMARY_CMD_RING].ring.db_addr = base + CRDB_LOWER;
+
+	/* Write to MMIO registers */
+	for (i = 0; reg_info[i].offset; i++)
+		mhi_write_reg_field(mhi_cntrl, base, reg_info[i].offset,
+				    reg_info[i].mask, reg_info[i].shift,
+				    reg_info[i].val);
+
+	return 0;
+}
+
+void mhi_deinit_chan_ctxt(struct mhi_controller *mhi_cntrl,
+			  struct mhi_chan *mhi_chan)
+{
+	struct mhi_ring *buf_ring;
+	struct mhi_ring *tre_ring;
+	struct mhi_chan_ctxt *chan_ctxt;
+	u32 tmp;
+
+	buf_ring = &mhi_chan->buf_ring;
+	tre_ring = &mhi_chan->tre_ring;
+	chan_ctxt = &mhi_cntrl->mhi_ctxt->chan_ctxt[mhi_chan->chan];
+
+	mhi_free_coherent(mhi_cntrl, tre_ring->alloc_size,
+			  tre_ring->pre_aligned, tre_ring->dma_handle);
+	vfree(buf_ring->base);
+
+	buf_ring->base = tre_ring->base = NULL;
+	tre_ring->ctxt_wp = NULL;
+	chan_ctxt->rbase = 0;
+	chan_ctxt->rlen = 0;
+	chan_ctxt->rp = 0;
+	chan_ctxt->wp = 0;
+
+	tmp = chan_ctxt->chcfg;
+	tmp &= ~CHAN_CTX_CHSTATE_MASK;
+	tmp |= (MHI_CH_STATE_DISABLED << CHAN_CTX_CHSTATE_SHIFT);
+	chan_ctxt->chcfg = tmp;
+
+	/* Update to all cores */
+	smp_wmb();
+}
+
+int mhi_init_chan_ctxt(struct mhi_controller *mhi_cntrl,
+		       struct mhi_chan *mhi_chan)
+{
+	struct mhi_ring *buf_ring;
+	struct mhi_ring *tre_ring;
+	struct mhi_chan_ctxt *chan_ctxt;
+	u32 tmp;
+	int ret;
+
+	buf_ring = &mhi_chan->buf_ring;
+	tre_ring = &mhi_chan->tre_ring;
+	tre_ring->el_size = sizeof(struct mhi_tre);
+	tre_ring->len = tre_ring->el_size * tre_ring->elements;
+	chan_ctxt = &mhi_cntrl->mhi_ctxt->chan_ctxt[mhi_chan->chan];
+	ret = mhi_alloc_aligned_ring(mhi_cntrl, tre_ring, tre_ring->len);
+	if (ret)
+		return -ENOMEM;
+
+	buf_ring->el_size = sizeof(struct mhi_buf_info);
+	buf_ring->len = buf_ring->el_size * buf_ring->elements;
+	buf_ring->base = vzalloc(buf_ring->len);
+
+	if (!buf_ring->base) {
+		mhi_free_coherent(mhi_cntrl, tre_ring->alloc_size,
+				  tre_ring->pre_aligned, tre_ring->dma_handle);
+		return -ENOMEM;
+	}
+
+	tmp = chan_ctxt->chcfg;
+	tmp &= ~CHAN_CTX_CHSTATE_MASK;
+	tmp |= (MHI_CH_STATE_ENABLED << CHAN_CTX_CHSTATE_SHIFT);
+	chan_ctxt->chcfg = tmp;
+
+	chan_ctxt->rbase = tre_ring->iommu_base;
+	chan_ctxt->rp = chan_ctxt->wp = chan_ctxt->rbase;
+	chan_ctxt->rlen = tre_ring->len;
+	tre_ring->ctxt_wp = &chan_ctxt->wp;
+
+	tre_ring->rp = tre_ring->wp = tre_ring->base;
+	buf_ring->rp = buf_ring->wp = buf_ring->base;
+	mhi_chan->db_cfg.db_mode = 1;
+
+	/* Update to all cores */
+	smp_wmb();
+
+	return 0;
+}
+
+static int parse_ev_cfg(struct mhi_controller *mhi_cntrl,
+			const struct mhi_controller_config *config)
+{
+	struct mhi_event *mhi_event;
+	const struct mhi_event_config *event_cfg;
+	struct device *dev = mhi_cntrl->cntrl_dev;
+	int i, num;
+
+	num = config->num_events;
+	mhi_cntrl->total_ev_rings = num;
+	mhi_cntrl->mhi_event = kcalloc(num, sizeof(*mhi_cntrl->mhi_event),
+				       GFP_KERNEL);
+	if (!mhi_cntrl->mhi_event)
+		return -ENOMEM;
+
+	/* Populate event ring */
+	mhi_event = mhi_cntrl->mhi_event;
+	for (i = 0; i < num; i++) {
+		event_cfg = &config->event_cfg[i];
+
+		mhi_event->er_index = i;
+		mhi_event->ring.elements = event_cfg->num_elements;
+		mhi_event->intmod = event_cfg->irq_moderation_ms;
+		mhi_event->irq = event_cfg->irq;
+
+		if (event_cfg->channel != U32_MAX) {
+			/* This event ring has a dedicated channel */
+			mhi_event->chan = event_cfg->channel;
+			if (mhi_event->chan >= mhi_cntrl->max_chan) {
+				dev_err(dev,
+					"Event Ring channel not available\n");
+				goto error_ev_cfg;
+			}
+
+			mhi_event->mhi_chan =
+				&mhi_cntrl->mhi_chan[mhi_event->chan];
+		}
+
+		/* Priority is fixed to 1 for now */
+		mhi_event->priority = 1;
+
+		mhi_event->db_cfg.brstmode = event_cfg->mode;
+		if (MHI_INVALID_BRSTMODE(mhi_event->db_cfg.brstmode))
+			goto error_ev_cfg;
+
+		if (mhi_event->db_cfg.brstmode == MHI_DB_BRST_ENABLE)
+			mhi_event->db_cfg.process_db = mhi_db_brstmode;
+		else
+			mhi_event->db_cfg.process_db = mhi_db_brstmode_disable;
+
+		mhi_event->data_type = event_cfg->data_type;
+
+		switch (mhi_event->data_type) {
+		case MHI_ER_DATA:
+			mhi_event->process_event = mhi_process_data_event_ring;
+			break;
+		case MHI_ER_CTRL:
+			mhi_event->process_event = mhi_process_ctrl_ev_ring;
+			break;
+		default:
+			dev_err(dev, "Event Ring type not supported\n");
+			goto error_ev_cfg;
+		}
+
+		mhi_event->hw_ring = event_cfg->hardware_event;
+		if (mhi_event->hw_ring)
+			mhi_cntrl->hw_ev_rings++;
+		else
+			mhi_cntrl->sw_ev_rings++;
+
+		mhi_event->cl_manage = event_cfg->client_managed;
+		mhi_event->offload_ev = event_cfg->offload_channel;
+		mhi_event++;
+	}
+
+	return 0;
+
+error_ev_cfg:
+
+	kfree(mhi_cntrl->mhi_event);
+	return -EINVAL;
+}
+
+static int parse_ch_cfg(struct mhi_controller *mhi_cntrl,
+			const struct mhi_controller_config *config)
+{
+	const struct mhi_channel_config *ch_cfg;
+	struct device *dev = mhi_cntrl->cntrl_dev;
+	int i;
+	u32 chan;
+
+	mhi_cntrl->max_chan = config->max_channels;
+
+	/*
+	 * The allocation of MHI channels can exceed 32KB in some scenarios,
+	 * so to avoid any memory possible allocation failures, vzalloc is
+	 * used here
+	 */
+	mhi_cntrl->mhi_chan = vzalloc(mhi_cntrl->max_chan *
+				      sizeof(*mhi_cntrl->mhi_chan));
+	if (!mhi_cntrl->mhi_chan)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&mhi_cntrl->lpm_chans);
+
+	/* Populate channel configurations */
+	for (i = 0; i < config->num_channels; i++) {
+		struct mhi_chan *mhi_chan;
+
+		ch_cfg = &config->ch_cfg[i];
+
+		chan = ch_cfg->num;
+		if (chan >= mhi_cntrl->max_chan) {
+			dev_err(dev, "Channel %d not available\n", chan);
+			goto error_chan_cfg;
+		}
+
+		mhi_chan = &mhi_cntrl->mhi_chan[chan];
+		mhi_chan->name = ch_cfg->name;
+		mhi_chan->chan = chan;
+
+		mhi_chan->tre_ring.elements = ch_cfg->num_elements;
+		if (!mhi_chan->tre_ring.elements)
+			goto error_chan_cfg;
+
+		/*
+		 * For some channels, local ring length should be bigger than
+		 * the transfer ring length due to internal logical channels
+		 * in device. So host can queue much more buffers than transfer
+		 * ring length. Example, RSC channels should have a larger local
+		 * channel length than transfer ring length.
+		 */
+		mhi_chan->buf_ring.elements = ch_cfg->local_elements;
+		if (!mhi_chan->buf_ring.elements)
+			mhi_chan->buf_ring.elements = mhi_chan->tre_ring.elements;
+		mhi_chan->er_index = ch_cfg->event_ring;
+		mhi_chan->dir = ch_cfg->dir;
+
+		/*
+		 * For most channels, chtype is identical to channel directions.
+		 * So, if it is not defined then assign channel direction to
+		 * chtype
+		 */
+		mhi_chan->type = ch_cfg->type;
+		if (!mhi_chan->type)
+			mhi_chan->type = (enum mhi_ch_type)mhi_chan->dir;
+
+		mhi_chan->ee_mask = ch_cfg->ee_mask;
+		mhi_chan->db_cfg.pollcfg = ch_cfg->pollcfg;
+		mhi_chan->lpm_notify = ch_cfg->lpm_notify;
+		mhi_chan->offload_ch = ch_cfg->offload_channel;
+		mhi_chan->db_cfg.reset_req = ch_cfg->doorbell_mode_switch;
+		mhi_chan->pre_alloc = ch_cfg->auto_queue;
+		mhi_chan->auto_start = ch_cfg->auto_start;
+
+		/*
+		 * If MHI host allocates buffers, then the channel direction
+		 * should be DMA_FROM_DEVICE
+		 */
+		if (mhi_chan->pre_alloc && mhi_chan->dir != DMA_FROM_DEVICE) {
+			dev_err(dev, "Invalid channel configuration\n");
+			goto error_chan_cfg;
+		}
+
+		/*
+		 * Bi-directional and direction less channel must be an
+		 * offload channel
+		 */
+		if ((mhi_chan->dir == DMA_BIDIRECTIONAL ||
+		     mhi_chan->dir == DMA_NONE) && !mhi_chan->offload_ch) {
+			dev_err(dev, "Invalid channel configuration\n");
+			goto error_chan_cfg;
+		}
+
+		if (!mhi_chan->offload_ch) {
+			mhi_chan->db_cfg.brstmode = ch_cfg->doorbell;
+			if (MHI_INVALID_BRSTMODE(mhi_chan->db_cfg.brstmode)) {
+				dev_err(dev, "Invalid Door bell mode\n");
+				goto error_chan_cfg;
+			}
+		}
+
+		if (mhi_chan->db_cfg.brstmode == MHI_DB_BRST_ENABLE)
+			mhi_chan->db_cfg.process_db = mhi_db_brstmode;
+		else
+			mhi_chan->db_cfg.process_db = mhi_db_brstmode_disable;
+
+		mhi_chan->configured = true;
+
+		if (mhi_chan->lpm_notify)
+			list_add_tail(&mhi_chan->node, &mhi_cntrl->lpm_chans);
+	}
+
+	return 0;
+
+error_chan_cfg:
+	vfree(mhi_cntrl->mhi_chan);
+
+	return -EINVAL;
+}
+
+static int parse_config(struct mhi_controller *mhi_cntrl,
+			const struct mhi_controller_config *config)
+{
+	int ret;
+
+	/* Parse MHI channel configuration */
+	ret = parse_ch_cfg(mhi_cntrl, config);
+	if (ret)
+		return ret;
+
+	/* Parse MHI event configuration */
+	ret = parse_ev_cfg(mhi_cntrl, config);
+	if (ret)
+		goto error_ev_cfg;
+
+	mhi_cntrl->timeout_ms = config->timeout_ms;
+	if (!mhi_cntrl->timeout_ms)
+		mhi_cntrl->timeout_ms = MHI_TIMEOUT_MS;
+
+	mhi_cntrl->bounce_buf = config->use_bounce_buf;
+	mhi_cntrl->buffer_len = config->buf_len;
+	if (!mhi_cntrl->buffer_len)
+		mhi_cntrl->buffer_len = MHI_MAX_MTU;
+
+	/* By default, host is allowed to ring DB in both M0 and M2 states */
+	mhi_cntrl->db_access = MHI_PM_M0 | MHI_PM_M2;
+	if (config->m2_no_db)
+		mhi_cntrl->db_access &= ~MHI_PM_M2;
+
+	return 0;
+
+error_ev_cfg:
+	vfree(mhi_cntrl->mhi_chan);
+
+	return ret;
+}
+
+int mhi_register_controller(struct mhi_controller *mhi_cntrl,
+			    const struct mhi_controller_config *config)
+{
+	struct mhi_event *mhi_event;
+	struct mhi_chan *mhi_chan;
+	struct mhi_cmd *mhi_cmd;
+	struct mhi_device *mhi_dev;
+	u32 soc_info;
+	int ret, i;
+
+	if (!mhi_cntrl)
+		return -EINVAL;
+
+	if (!mhi_cntrl->runtime_get || !mhi_cntrl->runtime_put ||
+	    !mhi_cntrl->status_cb || !mhi_cntrl->read_reg ||
+	    !mhi_cntrl->write_reg)
+		return -EINVAL;
+
+	ret = parse_config(mhi_cntrl, config);
+	if (ret)
+		return -EINVAL;
+
+	mhi_cntrl->mhi_cmd = kcalloc(NR_OF_CMD_RINGS,
+				     sizeof(*mhi_cntrl->mhi_cmd), GFP_KERNEL);
+	if (!mhi_cntrl->mhi_cmd) {
+		ret = -ENOMEM;
+		goto error_alloc_cmd;
+	}
+
+	INIT_LIST_HEAD(&mhi_cntrl->transition_list);
+	mutex_init(&mhi_cntrl->pm_mutex);
+	rwlock_init(&mhi_cntrl->pm_lock);
+	spin_lock_init(&mhi_cntrl->transition_lock);
+	spin_lock_init(&mhi_cntrl->wlock);
+	INIT_WORK(&mhi_cntrl->st_worker, mhi_pm_st_worker);
+	init_waitqueue_head(&mhi_cntrl->state_event);
+
+	mhi_cmd = mhi_cntrl->mhi_cmd;
+	for (i = 0; i < NR_OF_CMD_RINGS; i++, mhi_cmd++)
+		spin_lock_init(&mhi_cmd->lock);
+
+	mhi_event = mhi_cntrl->mhi_event;
+	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
+		/* Skip for offload events */
+		if (mhi_event->offload_ev)
+			continue;
+
+		mhi_event->mhi_cntrl = mhi_cntrl;
+		spin_lock_init(&mhi_event->lock);
+		if (mhi_event->data_type == MHI_ER_CTRL)
+			tasklet_init(&mhi_event->task, mhi_ctrl_ev_task,
+				     (ulong)mhi_event);
+		else
+			tasklet_init(&mhi_event->task, mhi_ev_task,
+				     (ulong)mhi_event);
+	}
+
+	mhi_chan = mhi_cntrl->mhi_chan;
+	for (i = 0; i < mhi_cntrl->max_chan; i++, mhi_chan++) {
+		mutex_init(&mhi_chan->mutex);
+		init_completion(&mhi_chan->completion);
+		rwlock_init(&mhi_chan->lock);
+
+		/* used in setting bei field of TRE */
+		mhi_event = &mhi_cntrl->mhi_event[mhi_chan->er_index];
+		mhi_chan->intmod = mhi_event->intmod;
+	}
+
+	if (mhi_cntrl->bounce_buf) {
+		mhi_cntrl->map_single = mhi_map_single_use_bb;
+		mhi_cntrl->unmap_single = mhi_unmap_single_use_bb;
+	} else {
+		mhi_cntrl->map_single = mhi_map_single_no_bb;
+		mhi_cntrl->unmap_single = mhi_unmap_single_no_bb;
+	}
+
+	/* Read the MHI device info */
+	ret = mhi_read_reg(mhi_cntrl, mhi_cntrl->regs,
+			   SOC_HW_VERSION_OFFS, &soc_info);
+	if (ret)
+		goto error_alloc_dev;
+
+	mhi_cntrl->family_number = (soc_info & SOC_HW_VERSION_FAM_NUM_BMSK) >>
+					SOC_HW_VERSION_FAM_NUM_SHFT;
+	mhi_cntrl->device_number = (soc_info & SOC_HW_VERSION_DEV_NUM_BMSK) >>
+					SOC_HW_VERSION_DEV_NUM_SHFT;
+	mhi_cntrl->major_version = (soc_info & SOC_HW_VERSION_MAJOR_VER_BMSK) >>
+					SOC_HW_VERSION_MAJOR_VER_SHFT;
+	mhi_cntrl->minor_version = (soc_info & SOC_HW_VERSION_MINOR_VER_BMSK) >>
+					SOC_HW_VERSION_MINOR_VER_SHFT;
+
+	/* Register controller with MHI bus */
+	mhi_dev = mhi_alloc_device(mhi_cntrl);
+	if (IS_ERR(mhi_dev)) {
+		dev_err(mhi_cntrl->cntrl_dev, "Failed to allocate MHI device\n");
+		ret = PTR_ERR(mhi_dev);
+		goto error_alloc_dev;
+	}
+
+	mhi_dev->dev_type = MHI_DEVICE_CONTROLLER;
+	mhi_dev->mhi_cntrl = mhi_cntrl;
+	dev_set_name(&mhi_dev->dev, "%s", dev_name(mhi_cntrl->cntrl_dev));
+	mhi_dev->name = dev_name(mhi_cntrl->cntrl_dev);
+
+	/* Init wakeup source */
+	device_init_wakeup(&mhi_dev->dev, true);
+
+	ret = device_add(&mhi_dev->dev);
+	if (ret)
+		goto error_add_dev;
+
+	mhi_cntrl->mhi_dev = mhi_dev;
+
+	mhi_create_debugfs(mhi_cntrl);
+
+	return 0;
+
+error_add_dev:
+	put_device(&mhi_dev->dev);
+
+error_alloc_dev:
+	kfree(mhi_cntrl->mhi_cmd);
+
+error_alloc_cmd:
+	vfree(mhi_cntrl->mhi_chan);
+	kfree(mhi_cntrl->mhi_event);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mhi_register_controller);
+
+void mhi_unregister_controller(struct mhi_controller *mhi_cntrl)
+{
+	struct mhi_device *mhi_dev = mhi_cntrl->mhi_dev;
+	struct mhi_chan *mhi_chan = mhi_cntrl->mhi_chan;
+	unsigned int i;
+
+	mhi_destroy_debugfs(mhi_cntrl);
+
+	kfree(mhi_cntrl->mhi_cmd);
+	kfree(mhi_cntrl->mhi_event);
+
+	/* Drop the references to MHI devices created for channels */
+	for (i = 0; i < mhi_cntrl->max_chan; i++, mhi_chan++) {
+		if (!mhi_chan->mhi_dev)
+			continue;
+
+		put_device(&mhi_chan->mhi_dev->dev);
+	}
+	vfree(mhi_cntrl->mhi_chan);
+
+	device_del(&mhi_dev->dev);
+	put_device(&mhi_dev->dev);
+}
+EXPORT_SYMBOL_GPL(mhi_unregister_controller);
+
+struct mhi_controller *mhi_alloc_controller(void)
+{
+	struct mhi_controller *mhi_cntrl;
+
+	mhi_cntrl = kzalloc(sizeof(*mhi_cntrl), GFP_KERNEL);
+
+	return mhi_cntrl;
+}
+EXPORT_SYMBOL_GPL(mhi_alloc_controller);
+
+void mhi_free_controller(struct mhi_controller *mhi_cntrl)
+{
+	kfree(mhi_cntrl);
+}
+EXPORT_SYMBOL_GPL(mhi_free_controller);
+
+int mhi_prepare_for_power_up(struct mhi_controller *mhi_cntrl)
+{
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	u32 bhie_off;
+	int ret;
+
+	mutex_lock(&mhi_cntrl->pm_mutex);
+
+	ret = mhi_init_dev_ctxt(mhi_cntrl);
+	if (ret)
+		goto error_dev_ctxt;
+
+	/*
+	 * Allocate RDDM table if specified, this table is for debugging purpose
+	 */
+	if (mhi_cntrl->rddm_size) {
+		mhi_alloc_bhie_table(mhi_cntrl, &mhi_cntrl->rddm_image,
+				     mhi_cntrl->rddm_size);
+
+		/*
+		 * This controller supports RDDM, so we need to manually clear
+		 * BHIE RX registers since POR values are undefined.
+		 */
+		ret = mhi_read_reg(mhi_cntrl, mhi_cntrl->regs, BHIEOFF,
+				   &bhie_off);
+		if (ret) {
+			dev_err(dev, "Error getting BHIE offset\n");
+			goto bhie_error;
+		}
+
+		mhi_cntrl->bhie = mhi_cntrl->regs + bhie_off;
+		memset_io(mhi_cntrl->bhie + BHIE_RXVECADDR_LOW_OFFS,
+			  0, BHIE_RXVECSTATUS_OFFS - BHIE_RXVECADDR_LOW_OFFS +
+			  4);
+
+		if (mhi_cntrl->rddm_image)
+			mhi_rddm_prepare(mhi_cntrl, mhi_cntrl->rddm_image);
+	}
+
+	mhi_cntrl->pre_init = true;
+
+	mutex_unlock(&mhi_cntrl->pm_mutex);
+
+	return 0;
+
+bhie_error:
+	if (mhi_cntrl->rddm_image) {
+		mhi_free_bhie_table(mhi_cntrl, mhi_cntrl->rddm_image);
+		mhi_cntrl->rddm_image = NULL;
+	}
+
+error_dev_ctxt:
+	mutex_unlock(&mhi_cntrl->pm_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mhi_prepare_for_power_up);
+
+void mhi_unprepare_after_power_down(struct mhi_controller *mhi_cntrl)
+{
+	if (mhi_cntrl->fbc_image) {
+		mhi_free_bhie_table(mhi_cntrl, mhi_cntrl->fbc_image);
+		mhi_cntrl->fbc_image = NULL;
+	}
+
+	if (mhi_cntrl->rddm_image) {
+		mhi_free_bhie_table(mhi_cntrl, mhi_cntrl->rddm_image);
+		mhi_cntrl->rddm_image = NULL;
+	}
+
+	mhi_deinit_dev_ctxt(mhi_cntrl);
+	mhi_cntrl->pre_init = false;
+}
+EXPORT_SYMBOL_GPL(mhi_unprepare_after_power_down);
+
+static void mhi_release_device(struct device *dev)
+{
+	struct mhi_device *mhi_dev = to_mhi_device(dev);
+
+	/*
+	 * We need to set the mhi_chan->mhi_dev to NULL here since the MHI
+	 * devices for the channels will only get created if the mhi_dev
+	 * associated with it is NULL. This scenario will happen during the
+	 * controller suspend and resume.
+	 */
+	if (mhi_dev->ul_chan)
+		mhi_dev->ul_chan->mhi_dev = NULL;
+
+	if (mhi_dev->dl_chan)
+		mhi_dev->dl_chan->mhi_dev = NULL;
+
+	kfree(mhi_dev);
+}
+
+struct mhi_device *mhi_alloc_device(struct mhi_controller *mhi_cntrl)
+{
+	struct mhi_device *mhi_dev;
+	struct device *dev;
+
+	mhi_dev = kzalloc(sizeof(*mhi_dev), GFP_KERNEL);
+	if (!mhi_dev)
+		return ERR_PTR(-ENOMEM);
+
+	dev = &mhi_dev->dev;
+	device_initialize(dev);
+	dev->bus = &mhi_bus_type;
+	dev->release = mhi_release_device;
+	dev->parent = mhi_cntrl->cntrl_dev;
+	mhi_dev->mhi_cntrl = mhi_cntrl;
+	mhi_dev->dev_wake = 0;
+
+	return mhi_dev;
+}
+
+static int mhi_driver_probe(struct device *dev)
+{
+	struct mhi_device *mhi_dev = to_mhi_device(dev);
+	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
+	struct device_driver *drv = dev->driver;
+	struct mhi_driver *mhi_drv = to_mhi_driver(drv);
+	struct mhi_event *mhi_event;
+	struct mhi_chan *ul_chan = mhi_dev->ul_chan;
+	struct mhi_chan *dl_chan = mhi_dev->dl_chan;
+	int ret;
+
+	/* Bring device out of LPM */
+	ret = mhi_device_get_sync(mhi_dev);
+	if (ret)
+		return ret;
+
+	ret = -EINVAL;
+
+	if (ul_chan) {
+		/*
+		 * If channel supports LPM notifications then status_cb should
+		 * be provided
+		 */
+		if (ul_chan->lpm_notify && !mhi_drv->status_cb)
+			goto exit_probe;
+
+		/* For non-offload channels then xfer_cb should be provided */
+		if (!ul_chan->offload_ch && !mhi_drv->ul_xfer_cb)
+			goto exit_probe;
+
+		ul_chan->xfer_cb = mhi_drv->ul_xfer_cb;
+		if (ul_chan->auto_start) {
+			ret = mhi_prepare_channel(mhi_cntrl, ul_chan);
+			if (ret)
+				goto exit_probe;
+		}
+	}
+
+	ret = -EINVAL;
+	if (dl_chan) {
+		/*
+		 * If channel supports LPM notifications then status_cb should
+		 * be provided
+		 */
+		if (dl_chan->lpm_notify && !mhi_drv->status_cb)
+			goto exit_probe;
+
+		/* For non-offload channels then xfer_cb should be provided */
+		if (!dl_chan->offload_ch && !mhi_drv->dl_xfer_cb)
+			goto exit_probe;
+
+		mhi_event = &mhi_cntrl->mhi_event[dl_chan->er_index];
+
+		/*
+		 * If the channel event ring is managed by client, then
+		 * status_cb must be provided so that the framework can
+		 * notify pending data
+		 */
+		if (mhi_event->cl_manage && !mhi_drv->status_cb)
+			goto exit_probe;
+
+		dl_chan->xfer_cb = mhi_drv->dl_xfer_cb;
+	}
+
+	/* Call the user provided probe function */
+	ret = mhi_drv->probe(mhi_dev, mhi_dev->id);
+	if (ret)
+		goto exit_probe;
+
+	if (dl_chan && dl_chan->auto_start)
+		mhi_prepare_channel(mhi_cntrl, dl_chan);
+
+	mhi_device_put(mhi_dev);
+
+	return ret;
+
+exit_probe:
+	mhi_unprepare_from_transfer(mhi_dev);
+
+	mhi_device_put(mhi_dev);
+
+	return ret;
+}
+
+static int mhi_driver_remove(struct device *dev)
+{
+	struct mhi_device *mhi_dev = to_mhi_device(dev);
+	struct mhi_driver *mhi_drv = to_mhi_driver(dev->driver);
+	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
+	struct mhi_chan *mhi_chan;
+	enum mhi_ch_state ch_state[] = {
+		MHI_CH_STATE_DISABLED,
+		MHI_CH_STATE_DISABLED
+	};
+	int dir;
+
+	/* Skip if it is a controller device */
+	if (mhi_dev->dev_type == MHI_DEVICE_CONTROLLER)
+		return 0;
+
+	/* Reset both channels */
+	for (dir = 0; dir < 2; dir++) {
+		mhi_chan = dir ? mhi_dev->ul_chan : mhi_dev->dl_chan;
+
+		if (!mhi_chan)
+			continue;
+
+		/* Wake all threads waiting for completion */
+		write_lock_irq(&mhi_chan->lock);
+		mhi_chan->ccs = MHI_EV_CC_INVALID;
+		complete_all(&mhi_chan->completion);
+		write_unlock_irq(&mhi_chan->lock);
+
+		/* Set the channel state to disabled */
+		mutex_lock(&mhi_chan->mutex);
+		write_lock_irq(&mhi_chan->lock);
+		ch_state[dir] = mhi_chan->ch_state;
+		mhi_chan->ch_state = MHI_CH_STATE_SUSPENDED;
+		write_unlock_irq(&mhi_chan->lock);
+
+		/* Reset the non-offload channel */
+		if (!mhi_chan->offload_ch)
+			mhi_reset_chan(mhi_cntrl, mhi_chan);
+
+		mutex_unlock(&mhi_chan->mutex);
+	}
+
+	mhi_drv->remove(mhi_dev);
+
+	/* De-init channel if it was enabled */
+	for (dir = 0; dir < 2; dir++) {
+		mhi_chan = dir ? mhi_dev->ul_chan : mhi_dev->dl_chan;
+
+		if (!mhi_chan)
+			continue;
+
+		mutex_lock(&mhi_chan->mutex);
+
+		if ((ch_state[dir] == MHI_CH_STATE_ENABLED ||
+		     ch_state[dir] == MHI_CH_STATE_STOP) &&
+		    !mhi_chan->offload_ch)
+			mhi_deinit_chan_ctxt(mhi_cntrl, mhi_chan);
+
+		mhi_chan->ch_state = MHI_CH_STATE_DISABLED;
+
+		mutex_unlock(&mhi_chan->mutex);
+	}
+
+	while (mhi_dev->dev_wake)
+		mhi_device_put(mhi_dev);
+
+	return 0;
+}
+
+int __mhi_driver_register(struct mhi_driver *mhi_drv, struct module *owner)
+{
+	struct device_driver *driver = &mhi_drv->driver;
+
+	if (!mhi_drv->probe || !mhi_drv->remove)
+		return -EINVAL;
+
+	driver->bus = &mhi_bus_type;
+	driver->owner = owner;
+	driver->probe = mhi_driver_probe;
+	driver->remove = mhi_driver_remove;
+
+	return driver_register(driver);
+}
+EXPORT_SYMBOL_GPL(__mhi_driver_register);
+
+void mhi_driver_unregister(struct mhi_driver *mhi_drv)
+{
+	driver_unregister(&mhi_drv->driver);
+}
+EXPORT_SYMBOL_GPL(mhi_driver_unregister);
+
+static int mhi_uevent(struct device *dev, struct kobj_uevent_env *env)
+{
+	struct mhi_device *mhi_dev = to_mhi_device(dev);
+
+	return add_uevent_var(env, "MODALIAS=" MHI_DEVICE_MODALIAS_FMT,
+					mhi_dev->name);
+}
+
+static int mhi_match(struct device *dev, struct device_driver *drv)
+{
+	struct mhi_device *mhi_dev = to_mhi_device(dev);
+	struct mhi_driver *mhi_drv = to_mhi_driver(drv);
+	const struct mhi_device_id *id;
+
+	/*
+	 * If the device is a controller type then there is no client driver
+	 * associated with it
+	 */
+	if (mhi_dev->dev_type == MHI_DEVICE_CONTROLLER)
+		return 0;
+
+	for (id = mhi_drv->id_table; id->chan[0]; id++)
+		if (!strcmp(mhi_dev->name, id->chan)) {
+			mhi_dev->id = id;
+			return 1;
+		}
+
+	return 0;
+};
+
+struct bus_type mhi_bus_type = {
+	.name = "mhi",
+	.dev_name = "mhi",
+	.match = mhi_match,
+	.uevent = mhi_uevent,
+	.dev_groups = mhi_dev_groups,
+};
+
+static int __init mhi_init(void)
+{
+	mhi_debugfs_init();
+	return bus_register(&mhi_bus_type);
+}
+
+static void __exit mhi_exit(void)
+{
+	mhi_debugfs_exit();
+	bus_unregister(&mhi_bus_type);
+}
+
+postcore_initcall(mhi_init);
+module_exit(mhi_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("MHI Host Interface");
diff --git a/drivers/bus/mhi/host/internal.h b/drivers/bus/mhi/host/internal.h
new file mode 100644
index 000000000000..7989269ddd96
--- /dev/null
+++ b/drivers/bus/mhi/host/internal.h
@@ -0,0 +1,722 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2018-2020, The Linux Foundation. All rights reserved.
+ *
+ */
+
+#ifndef _MHI_INT_H
+#define _MHI_INT_H
+
+#include <linux/mhi.h>
+
+extern struct bus_type mhi_bus_type;
+
+#define MHIREGLEN (0x0)
+#define MHIREGLEN_MHIREGLEN_MASK (0xFFFFFFFF)
+#define MHIREGLEN_MHIREGLEN_SHIFT (0)
+
+#define MHIVER (0x8)
+#define MHIVER_MHIVER_MASK (0xFFFFFFFF)
+#define MHIVER_MHIVER_SHIFT (0)
+
+#define MHICFG (0x10)
+#define MHICFG_NHWER_MASK (0xFF000000)
+#define MHICFG_NHWER_SHIFT (24)
+#define MHICFG_NER_MASK (0xFF0000)
+#define MHICFG_NER_SHIFT (16)
+#define MHICFG_NHWCH_MASK (0xFF00)
+#define MHICFG_NHWCH_SHIFT (8)
+#define MHICFG_NCH_MASK (0xFF)
+#define MHICFG_NCH_SHIFT (0)
+
+#define CHDBOFF (0x18)
+#define CHDBOFF_CHDBOFF_MASK (0xFFFFFFFF)
+#define CHDBOFF_CHDBOFF_SHIFT (0)
+
+#define ERDBOFF (0x20)
+#define ERDBOFF_ERDBOFF_MASK (0xFFFFFFFF)
+#define ERDBOFF_ERDBOFF_SHIFT (0)
+
+#define BHIOFF (0x28)
+#define BHIOFF_BHIOFF_MASK (0xFFFFFFFF)
+#define BHIOFF_BHIOFF_SHIFT (0)
+
+#define BHIEOFF (0x2C)
+#define BHIEOFF_BHIEOFF_MASK (0xFFFFFFFF)
+#define BHIEOFF_BHIEOFF_SHIFT (0)
+
+#define DEBUGOFF (0x30)
+#define DEBUGOFF_DEBUGOFF_MASK (0xFFFFFFFF)
+#define DEBUGOFF_DEBUGOFF_SHIFT (0)
+
+#define MHICTRL (0x38)
+#define MHICTRL_MHISTATE_MASK (0x0000FF00)
+#define MHICTRL_MHISTATE_SHIFT (8)
+#define MHICTRL_RESET_MASK (0x2)
+#define MHICTRL_RESET_SHIFT (1)
+
+#define MHISTATUS (0x48)
+#define MHISTATUS_MHISTATE_MASK (0x0000FF00)
+#define MHISTATUS_MHISTATE_SHIFT (8)
+#define MHISTATUS_SYSERR_MASK (0x4)
+#define MHISTATUS_SYSERR_SHIFT (2)
+#define MHISTATUS_READY_MASK (0x1)
+#define MHISTATUS_READY_SHIFT (0)
+
+#define CCABAP_LOWER (0x58)
+#define CCABAP_LOWER_CCABAP_LOWER_MASK (0xFFFFFFFF)
+#define CCABAP_LOWER_CCABAP_LOWER_SHIFT (0)
+
+#define CCABAP_HIGHER (0x5C)
+#define CCABAP_HIGHER_CCABAP_HIGHER_MASK (0xFFFFFFFF)
+#define CCABAP_HIGHER_CCABAP_HIGHER_SHIFT (0)
+
+#define ECABAP_LOWER (0x60)
+#define ECABAP_LOWER_ECABAP_LOWER_MASK (0xFFFFFFFF)
+#define ECABAP_LOWER_ECABAP_LOWER_SHIFT (0)
+
+#define ECABAP_HIGHER (0x64)
+#define ECABAP_HIGHER_ECABAP_HIGHER_MASK (0xFFFFFFFF)
+#define ECABAP_HIGHER_ECABAP_HIGHER_SHIFT (0)
+
+#define CRCBAP_LOWER (0x68)
+#define CRCBAP_LOWER_CRCBAP_LOWER_MASK (0xFFFFFFFF)
+#define CRCBAP_LOWER_CRCBAP_LOWER_SHIFT (0)
+
+#define CRCBAP_HIGHER (0x6C)
+#define CRCBAP_HIGHER_CRCBAP_HIGHER_MASK (0xFFFFFFFF)
+#define CRCBAP_HIGHER_CRCBAP_HIGHER_SHIFT (0)
+
+#define CRDB_LOWER (0x70)
+#define CRDB_LOWER_CRDB_LOWER_MASK (0xFFFFFFFF)
+#define CRDB_LOWER_CRDB_LOWER_SHIFT (0)
+
+#define CRDB_HIGHER (0x74)
+#define CRDB_HIGHER_CRDB_HIGHER_MASK (0xFFFFFFFF)
+#define CRDB_HIGHER_CRDB_HIGHER_SHIFT (0)
+
+#define MHICTRLBASE_LOWER (0x80)
+#define MHICTRLBASE_LOWER_MHICTRLBASE_LOWER_MASK (0xFFFFFFFF)
+#define MHICTRLBASE_LOWER_MHICTRLBASE_LOWER_SHIFT (0)
+
+#define MHICTRLBASE_HIGHER (0x84)
+#define MHICTRLBASE_HIGHER_MHICTRLBASE_HIGHER_MASK (0xFFFFFFFF)
+#define MHICTRLBASE_HIGHER_MHICTRLBASE_HIGHER_SHIFT (0)
+
+#define MHICTRLLIMIT_LOWER (0x88)
+#define MHICTRLLIMIT_LOWER_MHICTRLLIMIT_LOWER_MASK (0xFFFFFFFF)
+#define MHICTRLLIMIT_LOWER_MHICTRLLIMIT_LOWER_SHIFT (0)
+
+#define MHICTRLLIMIT_HIGHER (0x8C)
+#define MHICTRLLIMIT_HIGHER_MHICTRLLIMIT_HIGHER_MASK (0xFFFFFFFF)
+#define MHICTRLLIMIT_HIGHER_MHICTRLLIMIT_HIGHER_SHIFT (0)
+
+#define MHIDATABASE_LOWER (0x98)
+#define MHIDATABASE_LOWER_MHIDATABASE_LOWER_MASK (0xFFFFFFFF)
+#define MHIDATABASE_LOWER_MHIDATABASE_LOWER_SHIFT (0)
+
+#define MHIDATABASE_HIGHER (0x9C)
+#define MHIDATABASE_HIGHER_MHIDATABASE_HIGHER_MASK (0xFFFFFFFF)
+#define MHIDATABASE_HIGHER_MHIDATABASE_HIGHER_SHIFT (0)
+
+#define MHIDATALIMIT_LOWER (0xA0)
+#define MHIDATALIMIT_LOWER_MHIDATALIMIT_LOWER_MASK (0xFFFFFFFF)
+#define MHIDATALIMIT_LOWER_MHIDATALIMIT_LOWER_SHIFT (0)
+
+#define MHIDATALIMIT_HIGHER (0xA4)
+#define MHIDATALIMIT_HIGHER_MHIDATALIMIT_HIGHER_MASK (0xFFFFFFFF)
+#define MHIDATALIMIT_HIGHER_MHIDATALIMIT_HIGHER_SHIFT (0)
+
+/* Host request register */
+#define MHI_SOC_RESET_REQ_OFFSET (0xB0)
+#define MHI_SOC_RESET_REQ BIT(0)
+
+/* MHI BHI offfsets */
+#define BHI_BHIVERSION_MINOR (0x00)
+#define BHI_BHIVERSION_MAJOR (0x04)
+#define BHI_IMGADDR_LOW (0x08)
+#define BHI_IMGADDR_HIGH (0x0C)
+#define BHI_IMGSIZE (0x10)
+#define BHI_RSVD1 (0x14)
+#define BHI_IMGTXDB (0x18)
+#define BHI_TXDB_SEQNUM_BMSK (0x3FFFFFFF)
+#define BHI_TXDB_SEQNUM_SHFT (0)
+#define BHI_RSVD2 (0x1C)
+#define BHI_INTVEC (0x20)
+#define BHI_RSVD3 (0x24)
+#define BHI_EXECENV (0x28)
+#define BHI_STATUS (0x2C)
+#define BHI_ERRCODE (0x30)
+#define BHI_ERRDBG1 (0x34)
+#define BHI_ERRDBG2 (0x38)
+#define BHI_ERRDBG3 (0x3C)
+#define BHI_SERIALNU (0x40)
+#define BHI_SBLANTIROLLVER (0x44)
+#define BHI_NUMSEG (0x48)
+#define BHI_MSMHWID(n) (0x4C + (0x4 * n))
+#define BHI_OEMPKHASH(n) (0x64 + (0x4 * n))
+#define BHI_RSVD5 (0xC4)
+#define BHI_STATUS_MASK (0xC0000000)
+#define BHI_STATUS_SHIFT (30)
+#define BHI_STATUS_ERROR (3)
+#define BHI_STATUS_SUCCESS (2)
+#define BHI_STATUS_RESET (0)
+
+/* MHI BHIE offsets */
+#define BHIE_MSMSOCID_OFFS (0x0000)
+#define BHIE_TXVECADDR_LOW_OFFS (0x002C)
+#define BHIE_TXVECADDR_HIGH_OFFS (0x0030)
+#define BHIE_TXVECSIZE_OFFS (0x0034)
+#define BHIE_TXVECDB_OFFS (0x003C)
+#define BHIE_TXVECDB_SEQNUM_BMSK (0x3FFFFFFF)
+#define BHIE_TXVECDB_SEQNUM_SHFT (0)
+#define BHIE_TXVECSTATUS_OFFS (0x0044)
+#define BHIE_TXVECSTATUS_SEQNUM_BMSK (0x3FFFFFFF)
+#define BHIE_TXVECSTATUS_SEQNUM_SHFT (0)
+#define BHIE_TXVECSTATUS_STATUS_BMSK (0xC0000000)
+#define BHIE_TXVECSTATUS_STATUS_SHFT (30)
+#define BHIE_TXVECSTATUS_STATUS_RESET (0x00)
+#define BHIE_TXVECSTATUS_STATUS_XFER_COMPL (0x02)
+#define BHIE_TXVECSTATUS_STATUS_ERROR (0x03)
+#define BHIE_RXVECADDR_LOW_OFFS (0x0060)
+#define BHIE_RXVECADDR_HIGH_OFFS (0x0064)
+#define BHIE_RXVECSIZE_OFFS (0x0068)
+#define BHIE_RXVECDB_OFFS (0x0070)
+#define BHIE_RXVECDB_SEQNUM_BMSK (0x3FFFFFFF)
+#define BHIE_RXVECDB_SEQNUM_SHFT (0)
+#define BHIE_RXVECSTATUS_OFFS (0x0078)
+#define BHIE_RXVECSTATUS_SEQNUM_BMSK (0x3FFFFFFF)
+#define BHIE_RXVECSTATUS_SEQNUM_SHFT (0)
+#define BHIE_RXVECSTATUS_STATUS_BMSK (0xC0000000)
+#define BHIE_RXVECSTATUS_STATUS_SHFT (30)
+#define BHIE_RXVECSTATUS_STATUS_RESET (0x00)
+#define BHIE_RXVECSTATUS_STATUS_XFER_COMPL (0x02)
+#define BHIE_RXVECSTATUS_STATUS_ERROR (0x03)
+
+#define SOC_HW_VERSION_OFFS (0x224)
+#define SOC_HW_VERSION_FAM_NUM_BMSK (0xF0000000)
+#define SOC_HW_VERSION_FAM_NUM_SHFT (28)
+#define SOC_HW_VERSION_DEV_NUM_BMSK (0x0FFF0000)
+#define SOC_HW_VERSION_DEV_NUM_SHFT (16)
+#define SOC_HW_VERSION_MAJOR_VER_BMSK (0x0000FF00)
+#define SOC_HW_VERSION_MAJOR_VER_SHFT (8)
+#define SOC_HW_VERSION_MINOR_VER_BMSK (0x000000FF)
+#define SOC_HW_VERSION_MINOR_VER_SHFT (0)
+
+#define EV_CTX_RESERVED_MASK GENMASK(7, 0)
+#define EV_CTX_INTMODC_MASK GENMASK(15, 8)
+#define EV_CTX_INTMODC_SHIFT 8
+#define EV_CTX_INTMODT_MASK GENMASK(31, 16)
+#define EV_CTX_INTMODT_SHIFT 16
+struct mhi_event_ctxt {
+	__u32 intmod;
+	__u32 ertype;
+	__u32 msivec;
+
+	__u64 rbase __packed __aligned(4);
+	__u64 rlen __packed __aligned(4);
+	__u64 rp __packed __aligned(4);
+	__u64 wp __packed __aligned(4);
+};
+
+#define CHAN_CTX_CHSTATE_MASK GENMASK(7, 0)
+#define CHAN_CTX_CHSTATE_SHIFT 0
+#define CHAN_CTX_BRSTMODE_MASK GENMASK(9, 8)
+#define CHAN_CTX_BRSTMODE_SHIFT 8
+#define CHAN_CTX_POLLCFG_MASK GENMASK(15, 10)
+#define CHAN_CTX_POLLCFG_SHIFT 10
+#define CHAN_CTX_RESERVED_MASK GENMASK(31, 16)
+struct mhi_chan_ctxt {
+	__u32 chcfg;
+	__u32 chtype;
+	__u32 erindex;
+
+	__u64 rbase __packed __aligned(4);
+	__u64 rlen __packed __aligned(4);
+	__u64 rp __packed __aligned(4);
+	__u64 wp __packed __aligned(4);
+};
+
+struct mhi_cmd_ctxt {
+	__u32 reserved0;
+	__u32 reserved1;
+	__u32 reserved2;
+
+	__u64 rbase __packed __aligned(4);
+	__u64 rlen __packed __aligned(4);
+	__u64 rp __packed __aligned(4);
+	__u64 wp __packed __aligned(4);
+};
+
+struct mhi_ctxt {
+	struct mhi_event_ctxt *er_ctxt;
+	struct mhi_chan_ctxt *chan_ctxt;
+	struct mhi_cmd_ctxt *cmd_ctxt;
+	dma_addr_t er_ctxt_addr;
+	dma_addr_t chan_ctxt_addr;
+	dma_addr_t cmd_ctxt_addr;
+};
+
+struct mhi_tre {
+	u64 ptr;
+	u32 dword[2];
+};
+
+struct bhi_vec_entry {
+	u64 dma_addr;
+	u64 size;
+};
+
+enum mhi_cmd_type {
+	MHI_CMD_NOP = 1,
+	MHI_CMD_RESET_CHAN = 16,
+	MHI_CMD_STOP_CHAN = 17,
+	MHI_CMD_START_CHAN = 18,
+};
+
+/* No operation command */
+#define MHI_TRE_CMD_NOOP_PTR (0)
+#define MHI_TRE_CMD_NOOP_DWORD0 (0)
+#define MHI_TRE_CMD_NOOP_DWORD1 (MHI_CMD_NOP << 16)
+
+/* Channel reset command */
+#define MHI_TRE_CMD_RESET_PTR (0)
+#define MHI_TRE_CMD_RESET_DWORD0 (0)
+#define MHI_TRE_CMD_RESET_DWORD1(chid) ((chid << 24) | \
+					(MHI_CMD_RESET_CHAN << 16))
+
+/* Channel stop command */
+#define MHI_TRE_CMD_STOP_PTR (0)
+#define MHI_TRE_CMD_STOP_DWORD0 (0)
+#define MHI_TRE_CMD_STOP_DWORD1(chid) ((chid << 24) | \
+				       (MHI_CMD_STOP_CHAN << 16))
+
+/* Channel start command */
+#define MHI_TRE_CMD_START_PTR (0)
+#define MHI_TRE_CMD_START_DWORD0 (0)
+#define MHI_TRE_CMD_START_DWORD1(chid) ((chid << 24) | \
+					(MHI_CMD_START_CHAN << 16))
+
+#define MHI_TRE_GET_CMD_CHID(tre) (((tre)->dword[1] >> 24) & 0xFF)
+#define MHI_TRE_GET_CMD_TYPE(tre) (((tre)->dword[1] >> 16) & 0xFF)
+
+/* Event descriptor macros */
+#define MHI_TRE_EV_PTR(ptr) (ptr)
+#define MHI_TRE_EV_DWORD0(code, len) ((code << 24) | len)
+#define MHI_TRE_EV_DWORD1(chid, type) ((chid << 24) | (type << 16))
+#define MHI_TRE_GET_EV_PTR(tre) ((tre)->ptr)
+#define MHI_TRE_GET_EV_CODE(tre) (((tre)->dword[0] >> 24) & 0xFF)
+#define MHI_TRE_GET_EV_LEN(tre) ((tre)->dword[0] & 0xFFFF)
+#define MHI_TRE_GET_EV_CHID(tre) (((tre)->dword[1] >> 24) & 0xFF)
+#define MHI_TRE_GET_EV_TYPE(tre) (((tre)->dword[1] >> 16) & 0xFF)
+#define MHI_TRE_GET_EV_STATE(tre) (((tre)->dword[0] >> 24) & 0xFF)
+#define MHI_TRE_GET_EV_EXECENV(tre) (((tre)->dword[0] >> 24) & 0xFF)
+#define MHI_TRE_GET_EV_SEQ(tre) ((tre)->dword[0])
+#define MHI_TRE_GET_EV_TIME(tre) ((tre)->ptr)
+#define MHI_TRE_GET_EV_COOKIE(tre) lower_32_bits((tre)->ptr)
+#define MHI_TRE_GET_EV_VEID(tre) (((tre)->dword[0] >> 16) & 0xFF)
+#define MHI_TRE_GET_EV_LINKSPEED(tre) (((tre)->dword[1] >> 24) & 0xFF)
+#define MHI_TRE_GET_EV_LINKWIDTH(tre) ((tre)->dword[0] & 0xFF)
+
+/* Transfer descriptor macros */
+#define MHI_TRE_DATA_PTR(ptr) (ptr)
+#define MHI_TRE_DATA_DWORD0(len) (len & MHI_MAX_MTU)
+#define MHI_TRE_DATA_DWORD1(bei, ieot, ieob, chain) ((2 << 16) | (bei << 10) \
+	| (ieot << 9) | (ieob << 8) | chain)
+
+/* RSC transfer descriptor macros */
+#define MHI_RSCTRE_DATA_PTR(ptr, len) (((u64)len << 48) | ptr)
+#define MHI_RSCTRE_DATA_DWORD0(cookie) (cookie)
+#define MHI_RSCTRE_DATA_DWORD1 (MHI_PKT_TYPE_COALESCING << 16)
+
+enum mhi_pkt_type {
+	MHI_PKT_TYPE_INVALID = 0x0,
+	MHI_PKT_TYPE_NOOP_CMD = 0x1,
+	MHI_PKT_TYPE_TRANSFER = 0x2,
+	MHI_PKT_TYPE_COALESCING = 0x8,
+	MHI_PKT_TYPE_RESET_CHAN_CMD = 0x10,
+	MHI_PKT_TYPE_STOP_CHAN_CMD = 0x11,
+	MHI_PKT_TYPE_START_CHAN_CMD = 0x12,
+	MHI_PKT_TYPE_STATE_CHANGE_EVENT = 0x20,
+	MHI_PKT_TYPE_CMD_COMPLETION_EVENT = 0x21,
+	MHI_PKT_TYPE_TX_EVENT = 0x22,
+	MHI_PKT_TYPE_RSC_TX_EVENT = 0x28,
+	MHI_PKT_TYPE_EE_EVENT = 0x40,
+	MHI_PKT_TYPE_TSYNC_EVENT = 0x48,
+	MHI_PKT_TYPE_BW_REQ_EVENT = 0x50,
+	MHI_PKT_TYPE_STALE_EVENT, /* internal event */
+};
+
+/* MHI transfer completion events */
+enum mhi_ev_ccs {
+	MHI_EV_CC_INVALID = 0x0,
+	MHI_EV_CC_SUCCESS = 0x1,
+	MHI_EV_CC_EOT = 0x2, /* End of transfer event */
+	MHI_EV_CC_OVERFLOW = 0x3,
+	MHI_EV_CC_EOB = 0x4, /* End of block event */
+	MHI_EV_CC_OOB = 0x5, /* Out of block event */
+	MHI_EV_CC_DB_MODE = 0x6,
+	MHI_EV_CC_UNDEFINED_ERR = 0x10,
+	MHI_EV_CC_BAD_TRE = 0x11,
+};
+
+enum mhi_ch_state {
+	MHI_CH_STATE_DISABLED = 0x0,
+	MHI_CH_STATE_ENABLED = 0x1,
+	MHI_CH_STATE_RUNNING = 0x2,
+	MHI_CH_STATE_SUSPENDED = 0x3,
+	MHI_CH_STATE_STOP = 0x4,
+	MHI_CH_STATE_ERROR = 0x5,
+};
+
+#define MHI_INVALID_BRSTMODE(mode) (mode != MHI_DB_BRST_DISABLE && \
+				    mode != MHI_DB_BRST_ENABLE)
+
+extern const char * const mhi_ee_str[MHI_EE_MAX];
+#define TO_MHI_EXEC_STR(ee) (((ee) >= MHI_EE_MAX) ? \
+			     "INVALID_EE" : mhi_ee_str[ee])
+
+#define MHI_IN_PBL(ee) (ee == MHI_EE_PBL || ee == MHI_EE_PTHRU || \
+			ee == MHI_EE_EDL)
+
+#define MHI_IN_MISSION_MODE(ee) (ee == MHI_EE_AMSS || ee == MHI_EE_WFW)
+
+enum dev_st_transition {
+	DEV_ST_TRANSITION_PBL,
+	DEV_ST_TRANSITION_READY,
+	DEV_ST_TRANSITION_SBL,
+	DEV_ST_TRANSITION_MISSION_MODE,
+	DEV_ST_TRANSITION_SYS_ERR,
+	DEV_ST_TRANSITION_DISABLE,
+	DEV_ST_TRANSITION_MAX,
+};
+
+extern const char * const dev_state_tran_str[DEV_ST_TRANSITION_MAX];
+#define TO_DEV_STATE_TRANS_STR(state) (((state) >= DEV_ST_TRANSITION_MAX) ? \
+				"INVALID_STATE" : dev_state_tran_str[state])
+
+extern const char * const mhi_state_str[MHI_STATE_MAX];
+#define TO_MHI_STATE_STR(state) ((state >= MHI_STATE_MAX || \
+				  !mhi_state_str[state]) ? \
+				"INVALID_STATE" : mhi_state_str[state])
+
+/* internal power states */
+enum mhi_pm_state {
+	MHI_PM_STATE_DISABLE,
+	MHI_PM_STATE_POR,
+	MHI_PM_STATE_M0,
+	MHI_PM_STATE_M2,
+	MHI_PM_STATE_M3_ENTER,
+	MHI_PM_STATE_M3,
+	MHI_PM_STATE_M3_EXIT,
+	MHI_PM_STATE_FW_DL_ERR,
+	MHI_PM_STATE_SYS_ERR_DETECT,
+	MHI_PM_STATE_SYS_ERR_PROCESS,
+	MHI_PM_STATE_SHUTDOWN_PROCESS,
+	MHI_PM_STATE_LD_ERR_FATAL_DETECT,
+	MHI_PM_STATE_MAX
+};
+
+#define MHI_PM_DISABLE			BIT(0)
+#define MHI_PM_POR			BIT(1)
+#define MHI_PM_M0			BIT(2)
+#define MHI_PM_M2			BIT(3)
+#define MHI_PM_M3_ENTER			BIT(4)
+#define MHI_PM_M3			BIT(5)
+#define MHI_PM_M3_EXIT			BIT(6)
+/* firmware download failure state */
+#define MHI_PM_FW_DL_ERR		BIT(7)
+#define MHI_PM_SYS_ERR_DETECT		BIT(8)
+#define MHI_PM_SYS_ERR_PROCESS		BIT(9)
+#define MHI_PM_SHUTDOWN_PROCESS		BIT(10)
+/* link not accessible */
+#define MHI_PM_LD_ERR_FATAL_DETECT	BIT(11)
+
+#define MHI_REG_ACCESS_VALID(pm_state) ((pm_state & (MHI_PM_POR | MHI_PM_M0 | \
+		MHI_PM_M2 | MHI_PM_M3_ENTER | MHI_PM_M3_EXIT | \
+		MHI_PM_SYS_ERR_DETECT | MHI_PM_SYS_ERR_PROCESS | \
+		MHI_PM_SHUTDOWN_PROCESS | MHI_PM_FW_DL_ERR)))
+#define MHI_PM_IN_ERROR_STATE(pm_state) (pm_state >= MHI_PM_FW_DL_ERR)
+#define MHI_PM_IN_FATAL_STATE(pm_state) (pm_state == MHI_PM_LD_ERR_FATAL_DETECT)
+#define MHI_DB_ACCESS_VALID(mhi_cntrl) (mhi_cntrl->pm_state & \
+					mhi_cntrl->db_access)
+#define MHI_WAKE_DB_CLEAR_VALID(pm_state) (pm_state & (MHI_PM_M0 | \
+						MHI_PM_M2 | MHI_PM_M3_EXIT))
+#define MHI_WAKE_DB_SET_VALID(pm_state) (pm_state & MHI_PM_M2)
+#define MHI_WAKE_DB_FORCE_SET_VALID(pm_state) MHI_WAKE_DB_CLEAR_VALID(pm_state)
+#define MHI_EVENT_ACCESS_INVALID(pm_state) (pm_state == MHI_PM_DISABLE || \
+					    MHI_PM_IN_ERROR_STATE(pm_state))
+#define MHI_PM_IN_SUSPEND_STATE(pm_state) (pm_state & \
+					   (MHI_PM_M3_ENTER | MHI_PM_M3))
+
+#define NR_OF_CMD_RINGS			1
+#define CMD_EL_PER_RING			128
+#define PRIMARY_CMD_RING		0
+#define MHI_DEV_WAKE_DB			127
+#define MHI_MAX_MTU			0xffff
+#define MHI_RANDOM_U32_NONZERO(bmsk)	(prandom_u32_max(bmsk) + 1)
+
+enum mhi_er_type {
+	MHI_ER_TYPE_INVALID = 0x0,
+	MHI_ER_TYPE_VALID = 0x1,
+};
+
+struct db_cfg {
+	bool reset_req;
+	bool db_mode;
+	u32 pollcfg;
+	enum mhi_db_brst_mode brstmode;
+	dma_addr_t db_val;
+	void (*process_db)(struct mhi_controller *mhi_cntrl,
+			   struct db_cfg *db_cfg, void __iomem *io_addr,
+			   dma_addr_t db_val);
+};
+
+struct mhi_pm_transitions {
+	enum mhi_pm_state from_state;
+	u32 to_states;
+};
+
+struct state_transition {
+	struct list_head node;
+	enum dev_st_transition state;
+};
+
+struct mhi_ring {
+	dma_addr_t dma_handle;
+	dma_addr_t iommu_base;
+	u64 *ctxt_wp; /* point to ctxt wp */
+	void *pre_aligned;
+	void *base;
+	void *rp;
+	void *wp;
+	size_t el_size;
+	size_t len;
+	size_t elements;
+	size_t alloc_size;
+	void __iomem *db_addr;
+};
+
+struct mhi_cmd {
+	struct mhi_ring ring;
+	spinlock_t lock;
+};
+
+struct mhi_buf_info {
+	void *v_addr;
+	void *bb_addr;
+	void *wp;
+	void *cb_buf;
+	dma_addr_t p_addr;
+	size_t len;
+	enum dma_data_direction dir;
+	bool used; /* Indicates whether the buffer is used or not */
+	bool pre_mapped; /* Already pre-mapped by client */
+};
+
+struct mhi_event {
+	struct mhi_controller *mhi_cntrl;
+	struct mhi_chan *mhi_chan; /* dedicated to channel */
+	u32 er_index;
+	u32 intmod;
+	u32 irq;
+	int chan; /* this event ring is dedicated to a channel (optional) */
+	u32 priority;
+	enum mhi_er_data_type data_type;
+	struct mhi_ring ring;
+	struct db_cfg db_cfg;
+	struct tasklet_struct task;
+	spinlock_t lock;
+	int (*process_event)(struct mhi_controller *mhi_cntrl,
+			     struct mhi_event *mhi_event,
+			     u32 event_quota);
+	bool hw_ring;
+	bool cl_manage;
+	bool offload_ev; /* managed by a device driver */
+};
+
+struct mhi_chan {
+	const char *name;
+	/*
+	 * Important: When consuming, increment tre_ring first and when
+	 * releasing, decrement buf_ring first. If tre_ring has space, buf_ring
+	 * is guranteed to have space so we do not need to check both rings.
+	 */
+	struct mhi_ring buf_ring;
+	struct mhi_ring tre_ring;
+	u32 chan;
+	u32 er_index;
+	u32 intmod;
+	enum mhi_ch_type type;
+	enum dma_data_direction dir;
+	struct db_cfg db_cfg;
+	enum mhi_ch_ee_mask ee_mask;
+	enum mhi_ch_state ch_state;
+	enum mhi_ev_ccs ccs;
+	struct mhi_device *mhi_dev;
+	void (*xfer_cb)(struct mhi_device *mhi_dev, struct mhi_result *result);
+	struct mutex mutex;
+	struct completion completion;
+	rwlock_t lock;
+	struct list_head node;
+	bool lpm_notify;
+	bool configured;
+	bool offload_ch;
+	bool pre_alloc;
+	bool auto_start;
+	bool wake_capable;
+};
+
+/* Default MHI timeout */
+#define MHI_TIMEOUT_MS (1000)
+
+/* debugfs related functions */
+#ifdef CONFIG_MHI_BUS_DEBUG
+void mhi_create_debugfs(struct mhi_controller *mhi_cntrl);
+void mhi_destroy_debugfs(struct mhi_controller *mhi_cntrl);
+void mhi_debugfs_init(void);
+void mhi_debugfs_exit(void);
+#else
+static inline void mhi_create_debugfs(struct mhi_controller *mhi_cntrl)
+{
+}
+
+static inline void mhi_destroy_debugfs(struct mhi_controller *mhi_cntrl)
+{
+}
+
+static inline void mhi_debugfs_init(void)
+{
+}
+
+static inline void mhi_debugfs_exit(void)
+{
+}
+#endif
+
+struct mhi_device *mhi_alloc_device(struct mhi_controller *mhi_cntrl);
+
+int mhi_destroy_device(struct device *dev, void *data);
+void mhi_create_devices(struct mhi_controller *mhi_cntrl);
+
+int mhi_alloc_bhie_table(struct mhi_controller *mhi_cntrl,
+			 struct image_info **image_info, size_t alloc_size);
+void mhi_free_bhie_table(struct mhi_controller *mhi_cntrl,
+			 struct image_info *image_info);
+
+/* Power management APIs */
+enum mhi_pm_state __must_check mhi_tryset_pm_state(
+					struct mhi_controller *mhi_cntrl,
+					enum mhi_pm_state state);
+const char *to_mhi_pm_state_str(enum mhi_pm_state state);
+enum mhi_ee_type mhi_get_exec_env(struct mhi_controller *mhi_cntrl);
+int mhi_queue_state_transition(struct mhi_controller *mhi_cntrl,
+			       enum dev_st_transition state);
+void mhi_pm_st_worker(struct work_struct *work);
+void mhi_pm_sys_err_handler(struct mhi_controller *mhi_cntrl);
+void mhi_fw_load_worker(struct work_struct *work);
+int mhi_ready_state_transition(struct mhi_controller *mhi_cntrl);
+int mhi_pm_m0_transition(struct mhi_controller *mhi_cntrl);
+void mhi_pm_m1_transition(struct mhi_controller *mhi_cntrl);
+int mhi_pm_m3_transition(struct mhi_controller *mhi_cntrl);
+int __mhi_device_get_sync(struct mhi_controller *mhi_cntrl);
+int mhi_send_cmd(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan,
+		 enum mhi_cmd_type cmd);
+static inline bool mhi_is_active(struct mhi_controller *mhi_cntrl)
+{
+	return (mhi_cntrl->dev_state >= MHI_STATE_M0 &&
+		mhi_cntrl->dev_state <= MHI_STATE_M3_FAST);
+}
+
+static inline void mhi_trigger_resume(struct mhi_controller *mhi_cntrl)
+{
+	pm_wakeup_event(&mhi_cntrl->mhi_dev->dev, 0);
+	mhi_cntrl->runtime_get(mhi_cntrl);
+	mhi_cntrl->runtime_put(mhi_cntrl);
+}
+
+/* Register access methods */
+void mhi_db_brstmode(struct mhi_controller *mhi_cntrl, struct db_cfg *db_cfg,
+		     void __iomem *db_addr, dma_addr_t db_val);
+void mhi_db_brstmode_disable(struct mhi_controller *mhi_cntrl,
+			     struct db_cfg *db_mode, void __iomem *db_addr,
+			     dma_addr_t db_val);
+int __must_check mhi_read_reg(struct mhi_controller *mhi_cntrl,
+			      void __iomem *base, u32 offset, u32 *out);
+int __must_check mhi_read_reg_field(struct mhi_controller *mhi_cntrl,
+				    void __iomem *base, u32 offset, u32 mask,
+				    u32 shift, u32 *out);
+void mhi_write_reg(struct mhi_controller *mhi_cntrl, void __iomem *base,
+		   u32 offset, u32 val);
+void mhi_write_reg_field(struct mhi_controller *mhi_cntrl, void __iomem *base,
+			 u32 offset, u32 mask, u32 shift, u32 val);
+void mhi_ring_er_db(struct mhi_event *mhi_event);
+void mhi_write_db(struct mhi_controller *mhi_cntrl, void __iomem *db_addr,
+		  dma_addr_t db_val);
+void mhi_ring_cmd_db(struct mhi_controller *mhi_cntrl, struct mhi_cmd *mhi_cmd);
+void mhi_ring_chan_db(struct mhi_controller *mhi_cntrl,
+		      struct mhi_chan *mhi_chan);
+
+/* Initialization methods */
+int mhi_init_mmio(struct mhi_controller *mhi_cntrl);
+int mhi_init_dev_ctxt(struct mhi_controller *mhi_cntrl);
+void mhi_deinit_dev_ctxt(struct mhi_controller *mhi_cntrl);
+int mhi_init_irq_setup(struct mhi_controller *mhi_cntrl);
+void mhi_deinit_free_irq(struct mhi_controller *mhi_cntrl);
+void mhi_rddm_prepare(struct mhi_controller *mhi_cntrl,
+		      struct image_info *img_info);
+void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl);
+int mhi_prepare_channel(struct mhi_controller *mhi_cntrl,
+			struct mhi_chan *mhi_chan);
+int mhi_init_chan_ctxt(struct mhi_controller *mhi_cntrl,
+		       struct mhi_chan *mhi_chan);
+void mhi_deinit_chan_ctxt(struct mhi_controller *mhi_cntrl,
+			  struct mhi_chan *mhi_chan);
+void mhi_reset_chan(struct mhi_controller *mhi_cntrl,
+		    struct mhi_chan *mhi_chan);
+
+/* Memory allocation methods */
+static inline void *mhi_alloc_coherent(struct mhi_controller *mhi_cntrl,
+				       size_t size,
+				       dma_addr_t *dma_handle,
+				       gfp_t gfp)
+{
+	void *buf = dma_alloc_coherent(mhi_cntrl->cntrl_dev, size, dma_handle,
+				       gfp);
+
+	return buf;
+}
+
+static inline void mhi_free_coherent(struct mhi_controller *mhi_cntrl,
+				     size_t size,
+				     void *vaddr,
+				     dma_addr_t dma_handle)
+{
+	dma_free_coherent(mhi_cntrl->cntrl_dev, size, vaddr, dma_handle);
+}
+
+/* Event processing methods */
+void mhi_ctrl_ev_task(unsigned long data);
+void mhi_ev_task(unsigned long data);
+int mhi_process_data_event_ring(struct mhi_controller *mhi_cntrl,
+				struct mhi_event *mhi_event, u32 event_quota);
+int mhi_process_ctrl_ev_ring(struct mhi_controller *mhi_cntrl,
+			     struct mhi_event *mhi_event, u32 event_quota);
+
+/* ISR handlers */
+irqreturn_t mhi_irq_handler(int irq_number, void *dev);
+irqreturn_t mhi_intvec_threaded_handler(int irq_number, void *dev);
+irqreturn_t mhi_intvec_handler(int irq_number, void *dev);
+
+int mhi_gen_tre(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan,
+		struct mhi_buf_info *info, enum mhi_flags flags);
+int mhi_map_single_no_bb(struct mhi_controller *mhi_cntrl,
+			 struct mhi_buf_info *buf_info);
+int mhi_map_single_use_bb(struct mhi_controller *mhi_cntrl,
+			  struct mhi_buf_info *buf_info);
+void mhi_unmap_single_no_bb(struct mhi_controller *mhi_cntrl,
+			    struct mhi_buf_info *buf_info);
+void mhi_unmap_single_use_bb(struct mhi_controller *mhi_cntrl,
+			     struct mhi_buf_info *buf_info);
+
+#endif /* _MHI_INT_H */
diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
new file mode 100644
index 000000000000..614dd287cb4f
--- /dev/null
+++ b/drivers/bus/mhi/host/main.c
@@ -0,0 +1,1630 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018-2020, The Linux Foundation. All rights reserved.
+ *
+ */
+
+#include <linux/device.h>
+#include <linux/dma-direction.h>
+#include <linux/dma-mapping.h>
+#include <linux/interrupt.h>
+#include <linux/list.h>
+#include <linux/mhi.h>
+#include <linux/module.h>
+#include <linux/skbuff.h>
+#include <linux/slab.h>
+#include "internal.h"
+
+int __must_check mhi_read_reg(struct mhi_controller *mhi_cntrl,
+			      void __iomem *base, u32 offset, u32 *out)
+{
+	return mhi_cntrl->read_reg(mhi_cntrl, base + offset, out);
+}
+
+int __must_check mhi_read_reg_field(struct mhi_controller *mhi_cntrl,
+				    void __iomem *base, u32 offset,
+				    u32 mask, u32 shift, u32 *out)
+{
+	u32 tmp;
+	int ret;
+
+	ret = mhi_read_reg(mhi_cntrl, base, offset, &tmp);
+	if (ret)
+		return ret;
+
+	*out = (tmp & mask) >> shift;
+
+	return 0;
+}
+
+void mhi_write_reg(struct mhi_controller *mhi_cntrl, void __iomem *base,
+		   u32 offset, u32 val)
+{
+	mhi_cntrl->write_reg(mhi_cntrl, base + offset, val);
+}
+
+void mhi_write_reg_field(struct mhi_controller *mhi_cntrl, void __iomem *base,
+			 u32 offset, u32 mask, u32 shift, u32 val)
+{
+	int ret;
+	u32 tmp;
+
+	ret = mhi_read_reg(mhi_cntrl, base, offset, &tmp);
+	if (ret)
+		return;
+
+	tmp &= ~mask;
+	tmp |= (val << shift);
+	mhi_write_reg(mhi_cntrl, base, offset, tmp);
+}
+
+void mhi_write_db(struct mhi_controller *mhi_cntrl, void __iomem *db_addr,
+		  dma_addr_t db_val)
+{
+	mhi_write_reg(mhi_cntrl, db_addr, 4, upper_32_bits(db_val));
+	mhi_write_reg(mhi_cntrl, db_addr, 0, lower_32_bits(db_val));
+}
+
+void mhi_db_brstmode(struct mhi_controller *mhi_cntrl,
+		     struct db_cfg *db_cfg,
+		     void __iomem *db_addr,
+		     dma_addr_t db_val)
+{
+	if (db_cfg->db_mode) {
+		db_cfg->db_val = db_val;
+		mhi_write_db(mhi_cntrl, db_addr, db_val);
+		db_cfg->db_mode = 0;
+	}
+}
+
+void mhi_db_brstmode_disable(struct mhi_controller *mhi_cntrl,
+			     struct db_cfg *db_cfg,
+			     void __iomem *db_addr,
+			     dma_addr_t db_val)
+{
+	db_cfg->db_val = db_val;
+	mhi_write_db(mhi_cntrl, db_addr, db_val);
+}
+
+void mhi_ring_er_db(struct mhi_event *mhi_event)
+{
+	struct mhi_ring *ring = &mhi_event->ring;
+
+	mhi_event->db_cfg.process_db(mhi_event->mhi_cntrl, &mhi_event->db_cfg,
+				     ring->db_addr, *ring->ctxt_wp);
+}
+
+void mhi_ring_cmd_db(struct mhi_controller *mhi_cntrl, struct mhi_cmd *mhi_cmd)
+{
+	dma_addr_t db;
+	struct mhi_ring *ring = &mhi_cmd->ring;
+
+	db = ring->iommu_base + (ring->wp - ring->base);
+	*ring->ctxt_wp = db;
+	mhi_write_db(mhi_cntrl, ring->db_addr, db);
+}
+
+void mhi_ring_chan_db(struct mhi_controller *mhi_cntrl,
+		      struct mhi_chan *mhi_chan)
+{
+	struct mhi_ring *ring = &mhi_chan->tre_ring;
+	dma_addr_t db;
+
+	db = ring->iommu_base + (ring->wp - ring->base);
+	*ring->ctxt_wp = db;
+	mhi_chan->db_cfg.process_db(mhi_cntrl, &mhi_chan->db_cfg,
+				    ring->db_addr, db);
+}
+
+enum mhi_ee_type mhi_get_exec_env(struct mhi_controller *mhi_cntrl)
+{
+	u32 exec;
+	int ret = mhi_read_reg(mhi_cntrl, mhi_cntrl->bhi, BHI_EXECENV, &exec);
+
+	return (ret) ? MHI_EE_MAX : exec;
+}
+
+enum mhi_state mhi_get_mhi_state(struct mhi_controller *mhi_cntrl)
+{
+	u32 state;
+	int ret = mhi_read_reg_field(mhi_cntrl, mhi_cntrl->regs, MHISTATUS,
+				     MHISTATUS_MHISTATE_MASK,
+				     MHISTATUS_MHISTATE_SHIFT, &state);
+	return ret ? MHI_STATE_MAX : state;
+}
+
+int mhi_map_single_no_bb(struct mhi_controller *mhi_cntrl,
+			 struct mhi_buf_info *buf_info)
+{
+	buf_info->p_addr = dma_map_single(mhi_cntrl->cntrl_dev,
+					  buf_info->v_addr, buf_info->len,
+					  buf_info->dir);
+	if (dma_mapping_error(mhi_cntrl->cntrl_dev, buf_info->p_addr))
+		return -ENOMEM;
+
+	return 0;
+}
+
+int mhi_map_single_use_bb(struct mhi_controller *mhi_cntrl,
+			  struct mhi_buf_info *buf_info)
+{
+	void *buf = mhi_alloc_coherent(mhi_cntrl, buf_info->len,
+				       &buf_info->p_addr, GFP_ATOMIC);
+
+	if (!buf)
+		return -ENOMEM;
+
+	if (buf_info->dir == DMA_TO_DEVICE)
+		memcpy(buf, buf_info->v_addr, buf_info->len);
+
+	buf_info->bb_addr = buf;
+
+	return 0;
+}
+
+void mhi_unmap_single_no_bb(struct mhi_controller *mhi_cntrl,
+			    struct mhi_buf_info *buf_info)
+{
+	dma_unmap_single(mhi_cntrl->cntrl_dev, buf_info->p_addr, buf_info->len,
+			 buf_info->dir);
+}
+
+void mhi_unmap_single_use_bb(struct mhi_controller *mhi_cntrl,
+			     struct mhi_buf_info *buf_info)
+{
+	if (buf_info->dir == DMA_FROM_DEVICE)
+		memcpy(buf_info->v_addr, buf_info->bb_addr, buf_info->len);
+
+	mhi_free_coherent(mhi_cntrl, buf_info->len, buf_info->bb_addr,
+			  buf_info->p_addr);
+}
+
+static int get_nr_avail_ring_elements(struct mhi_controller *mhi_cntrl,
+				      struct mhi_ring *ring)
+{
+	int nr_el;
+
+	if (ring->wp < ring->rp) {
+		nr_el = ((ring->rp - ring->wp) / ring->el_size) - 1;
+	} else {
+		nr_el = (ring->rp - ring->base) / ring->el_size;
+		nr_el += ((ring->base + ring->len - ring->wp) /
+			  ring->el_size) - 1;
+	}
+
+	return nr_el;
+}
+
+static void *mhi_to_virtual(struct mhi_ring *ring, dma_addr_t addr)
+{
+	return (addr - ring->iommu_base) + ring->base;
+}
+
+static void mhi_add_ring_element(struct mhi_controller *mhi_cntrl,
+				 struct mhi_ring *ring)
+{
+	ring->wp += ring->el_size;
+	if (ring->wp >= (ring->base + ring->len))
+		ring->wp = ring->base;
+	/* smp update */
+	smp_wmb();
+}
+
+static void mhi_del_ring_element(struct mhi_controller *mhi_cntrl,
+				 struct mhi_ring *ring)
+{
+	ring->rp += ring->el_size;
+	if (ring->rp >= (ring->base + ring->len))
+		ring->rp = ring->base;
+	/* smp update */
+	smp_wmb();
+}
+
+static bool is_valid_ring_ptr(struct mhi_ring *ring, dma_addr_t addr)
+{
+	return addr >= ring->iommu_base && addr < ring->iommu_base + ring->len;
+}
+
+int mhi_destroy_device(struct device *dev, void *data)
+{
+	struct mhi_chan *ul_chan, *dl_chan;
+	struct mhi_device *mhi_dev;
+	struct mhi_controller *mhi_cntrl;
+	enum mhi_ee_type ee = MHI_EE_MAX;
+
+	if (dev->bus != &mhi_bus_type)
+		return 0;
+
+	mhi_dev = to_mhi_device(dev);
+	mhi_cntrl = mhi_dev->mhi_cntrl;
+
+	/* Only destroy virtual devices thats attached to bus */
+	if (mhi_dev->dev_type == MHI_DEVICE_CONTROLLER)
+		return 0;
+
+	ul_chan = mhi_dev->ul_chan;
+	dl_chan = mhi_dev->dl_chan;
+
+	/*
+	 * If execution environment is specified, remove only those devices that
+	 * started in them based on ee_mask for the channels as we move on to a
+	 * different execution environment
+	 */
+	if (data)
+		ee = *(enum mhi_ee_type *)data;
+
+	/*
+	 * For the suspend and resume case, this function will get called
+	 * without mhi_unregister_controller(). Hence, we need to drop the
+	 * references to mhi_dev created for ul and dl channels. We can
+	 * be sure that there will be no instances of mhi_dev left after
+	 * this.
+	 */
+	if (ul_chan) {
+		if (ee != MHI_EE_MAX && !(ul_chan->ee_mask & BIT(ee)))
+			return 0;
+
+		put_device(&ul_chan->mhi_dev->dev);
+	}
+
+	if (dl_chan) {
+		if (ee != MHI_EE_MAX && !(dl_chan->ee_mask & BIT(ee)))
+			return 0;
+
+		put_device(&dl_chan->mhi_dev->dev);
+	}
+
+	dev_dbg(&mhi_cntrl->mhi_dev->dev, "destroy device for chan:%s\n",
+		 mhi_dev->name);
+
+	/* Notify the client and remove the device from MHI bus */
+	device_del(dev);
+	put_device(dev);
+
+	return 0;
+}
+
+void mhi_notify(struct mhi_device *mhi_dev, enum mhi_callback cb_reason)
+{
+	struct mhi_driver *mhi_drv;
+
+	if (!mhi_dev->dev.driver)
+		return;
+
+	mhi_drv = to_mhi_driver(mhi_dev->dev.driver);
+
+	if (mhi_drv->status_cb)
+		mhi_drv->status_cb(mhi_dev, cb_reason);
+}
+EXPORT_SYMBOL_GPL(mhi_notify);
+
+/* Bind MHI channels to MHI devices */
+void mhi_create_devices(struct mhi_controller *mhi_cntrl)
+{
+	struct mhi_chan *mhi_chan;
+	struct mhi_device *mhi_dev;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	int i, ret;
+
+	mhi_chan = mhi_cntrl->mhi_chan;
+	for (i = 0; i < mhi_cntrl->max_chan; i++, mhi_chan++) {
+		if (!mhi_chan->configured || mhi_chan->mhi_dev ||
+		    !(mhi_chan->ee_mask & BIT(mhi_cntrl->ee)))
+			continue;
+		mhi_dev = mhi_alloc_device(mhi_cntrl);
+		if (IS_ERR(mhi_dev))
+			return;
+
+		mhi_dev->dev_type = MHI_DEVICE_XFER;
+		switch (mhi_chan->dir) {
+		case DMA_TO_DEVICE:
+			mhi_dev->ul_chan = mhi_chan;
+			mhi_dev->ul_chan_id = mhi_chan->chan;
+			break;
+		case DMA_FROM_DEVICE:
+			/* We use dl_chan as offload channels */
+			mhi_dev->dl_chan = mhi_chan;
+			mhi_dev->dl_chan_id = mhi_chan->chan;
+			break;
+		default:
+			dev_err(dev, "Direction not supported\n");
+			put_device(&mhi_dev->dev);
+			return;
+		}
+
+		get_device(&mhi_dev->dev);
+		mhi_chan->mhi_dev = mhi_dev;
+
+		/* Check next channel if it matches */
+		if ((i + 1) < mhi_cntrl->max_chan && mhi_chan[1].configured) {
+			if (!strcmp(mhi_chan[1].name, mhi_chan->name)) {
+				i++;
+				mhi_chan++;
+				if (mhi_chan->dir == DMA_TO_DEVICE) {
+					mhi_dev->ul_chan = mhi_chan;
+					mhi_dev->ul_chan_id = mhi_chan->chan;
+				} else {
+					mhi_dev->dl_chan = mhi_chan;
+					mhi_dev->dl_chan_id = mhi_chan->chan;
+				}
+				get_device(&mhi_dev->dev);
+				mhi_chan->mhi_dev = mhi_dev;
+			}
+		}
+
+		/* Channel name is same for both UL and DL */
+		mhi_dev->name = mhi_chan->name;
+		dev_set_name(&mhi_dev->dev, "%s_%s",
+			     dev_name(mhi_cntrl->cntrl_dev),
+			     mhi_dev->name);
+
+		/* Init wakeup source if available */
+		if (mhi_dev->dl_chan && mhi_dev->dl_chan->wake_capable)
+			device_init_wakeup(&mhi_dev->dev, true);
+
+		ret = device_add(&mhi_dev->dev);
+		if (ret)
+			put_device(&mhi_dev->dev);
+	}
+}
+
+irqreturn_t mhi_irq_handler(int irq_number, void *dev)
+{
+	struct mhi_event *mhi_event = dev;
+	struct mhi_controller *mhi_cntrl = mhi_event->mhi_cntrl;
+	struct mhi_event_ctxt *er_ctxt =
+		&mhi_cntrl->mhi_ctxt->er_ctxt[mhi_event->er_index];
+	struct mhi_ring *ev_ring = &mhi_event->ring;
+	dma_addr_t ptr = er_ctxt->rp;
+	void *dev_rp;
+
+	if (!is_valid_ring_ptr(ev_ring, ptr)) {
+		dev_err(&mhi_cntrl->mhi_dev->dev,
+			"Event ring rp points outside of the event ring\n");
+		return IRQ_HANDLED;
+	}
+
+	dev_rp = mhi_to_virtual(ev_ring, ptr);
+
+	/* Only proceed if event ring has pending events */
+	if (ev_ring->rp == dev_rp)
+		return IRQ_HANDLED;
+
+	/* For client managed event ring, notify pending data */
+	if (mhi_event->cl_manage) {
+		struct mhi_chan *mhi_chan = mhi_event->mhi_chan;
+		struct mhi_device *mhi_dev = mhi_chan->mhi_dev;
+
+		if (mhi_dev)
+			mhi_notify(mhi_dev, MHI_CB_PENDING_DATA);
+	} else {
+		tasklet_schedule(&mhi_event->task);
+	}
+
+	return IRQ_HANDLED;
+}
+
+irqreturn_t mhi_intvec_threaded_handler(int irq_number, void *priv)
+{
+	struct mhi_controller *mhi_cntrl = priv;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	enum mhi_state state = MHI_STATE_MAX;
+	enum mhi_pm_state pm_state = 0;
+	enum mhi_ee_type ee = 0;
+
+	write_lock_irq(&mhi_cntrl->pm_lock);
+	if (!MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state)) {
+		write_unlock_irq(&mhi_cntrl->pm_lock);
+		goto exit_intvec;
+	}
+
+	state = mhi_get_mhi_state(mhi_cntrl);
+	ee = mhi_cntrl->ee;
+	mhi_cntrl->ee = mhi_get_exec_env(mhi_cntrl);
+	dev_dbg(dev, "local ee:%s device ee:%s dev_state:%s\n",
+		TO_MHI_EXEC_STR(mhi_cntrl->ee), TO_MHI_EXEC_STR(ee),
+		TO_MHI_STATE_STR(state));
+
+	if (state == MHI_STATE_SYS_ERR) {
+		dev_dbg(dev, "System error detected\n");
+		pm_state = mhi_tryset_pm_state(mhi_cntrl,
+					       MHI_PM_SYS_ERR_DETECT);
+	}
+	write_unlock_irq(&mhi_cntrl->pm_lock);
+
+	 /* If device supports RDDM don't bother processing SYS error */
+	if (mhi_cntrl->rddm_image) {
+		if (mhi_cntrl->ee == MHI_EE_RDDM && mhi_cntrl->ee != ee) {
+			mhi_cntrl->status_cb(mhi_cntrl, MHI_CB_EE_RDDM);
+			wake_up_all(&mhi_cntrl->state_event);
+		}
+		goto exit_intvec;
+	}
+
+	if (pm_state == MHI_PM_SYS_ERR_DETECT) {
+		wake_up_all(&mhi_cntrl->state_event);
+
+		/* For fatal errors, we let controller decide next step */
+		if (MHI_IN_PBL(ee))
+			mhi_cntrl->status_cb(mhi_cntrl, MHI_CB_FATAL_ERROR);
+		else
+			mhi_pm_sys_err_handler(mhi_cntrl);
+	}
+
+exit_intvec:
+
+	return IRQ_HANDLED;
+}
+
+irqreturn_t mhi_intvec_handler(int irq_number, void *dev)
+{
+	struct mhi_controller *mhi_cntrl = dev;
+
+	/* Wake up events waiting for state change */
+	wake_up_all(&mhi_cntrl->state_event);
+
+	return IRQ_WAKE_THREAD;
+}
+
+static void mhi_recycle_ev_ring_element(struct mhi_controller *mhi_cntrl,
+					struct mhi_ring *ring)
+{
+	dma_addr_t ctxt_wp;
+
+	/* Update the WP */
+	ring->wp += ring->el_size;
+	ctxt_wp = *ring->ctxt_wp + ring->el_size;
+
+	if (ring->wp >= (ring->base + ring->len)) {
+		ring->wp = ring->base;
+		ctxt_wp = ring->iommu_base;
+	}
+
+	*ring->ctxt_wp = ctxt_wp;
+
+	/* Update the RP */
+	ring->rp += ring->el_size;
+	if (ring->rp >= (ring->base + ring->len))
+		ring->rp = ring->base;
+
+	/* Update to all cores */
+	smp_wmb();
+}
+
+static int parse_xfer_event(struct mhi_controller *mhi_cntrl,
+			    struct mhi_tre *event,
+			    struct mhi_chan *mhi_chan)
+{
+	struct mhi_ring *buf_ring, *tre_ring;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	struct mhi_result result;
+	unsigned long flags = 0;
+	u32 ev_code;
+
+	ev_code = MHI_TRE_GET_EV_CODE(event);
+	buf_ring = &mhi_chan->buf_ring;
+	tre_ring = &mhi_chan->tre_ring;
+
+	result.transaction_status = (ev_code == MHI_EV_CC_OVERFLOW) ?
+		-EOVERFLOW : 0;
+
+	/*
+	 * If it's a DB Event then we need to grab the lock
+	 * with preemption disabled and as a write because we
+	 * have to update db register and there are chances that
+	 * another thread could be doing the same.
+	 */
+	if (ev_code >= MHI_EV_CC_OOB)
+		write_lock_irqsave(&mhi_chan->lock, flags);
+	else
+		read_lock_bh(&mhi_chan->lock);
+
+	if (mhi_chan->ch_state != MHI_CH_STATE_ENABLED)
+		goto end_process_tx_event;
+
+	switch (ev_code) {
+	case MHI_EV_CC_OVERFLOW:
+	case MHI_EV_CC_EOB:
+	case MHI_EV_CC_EOT:
+	{
+		dma_addr_t ptr = MHI_TRE_GET_EV_PTR(event);
+		struct mhi_tre *local_rp, *ev_tre;
+		void *dev_rp;
+		struct mhi_buf_info *buf_info;
+		u16 xfer_len;
+
+		if (!is_valid_ring_ptr(tre_ring, ptr)) {
+			dev_err(&mhi_cntrl->mhi_dev->dev,
+				"Event element points outside of the tre ring\n");
+			break;
+		}
+		/* Get the TRB this event points to */
+		ev_tre = mhi_to_virtual(tre_ring, ptr);
+
+		dev_rp = ev_tre + 1;
+		if (dev_rp >= (tre_ring->base + tre_ring->len))
+			dev_rp = tre_ring->base;
+
+		result.dir = mhi_chan->dir;
+
+		local_rp = tre_ring->rp;
+		while (local_rp != dev_rp) {
+			buf_info = buf_ring->rp;
+			/* If it's the last TRE, get length from the event */
+			if (local_rp == ev_tre)
+				xfer_len = MHI_TRE_GET_EV_LEN(event);
+			else
+				xfer_len = buf_info->len;
+
+			/* Unmap if it's not pre-mapped by client */
+			if (likely(!buf_info->pre_mapped))
+				mhi_cntrl->unmap_single(mhi_cntrl, buf_info);
+
+			result.buf_addr = buf_info->cb_buf;
+
+			/* truncate to buf len if xfer_len is larger */
+			result.bytes_xferd =
+				min_t(u16, xfer_len, buf_info->len);
+			mhi_del_ring_element(mhi_cntrl, buf_ring);
+			mhi_del_ring_element(mhi_cntrl, tre_ring);
+			local_rp = tre_ring->rp;
+
+			/* notify client */
+			mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
+
+			if (mhi_chan->dir == DMA_TO_DEVICE)
+				atomic_dec(&mhi_cntrl->pending_pkts);
+
+			/*
+			 * Recycle the buffer if buffer is pre-allocated,
+			 * if there is an error, not much we can do apart
+			 * from dropping the packet
+			 */
+			if (mhi_chan->pre_alloc) {
+				if (mhi_queue_buf(mhi_chan->mhi_dev,
+						  mhi_chan->dir,
+						  buf_info->cb_buf,
+						  buf_info->len, MHI_EOT)) {
+					dev_err(dev,
+						"Error recycling buffer for chan:%d\n",
+						mhi_chan->chan);
+					kfree(buf_info->cb_buf);
+				}
+			}
+		}
+		break;
+	} /* CC_EOT */
+	case MHI_EV_CC_OOB:
+	case MHI_EV_CC_DB_MODE:
+	{
+		unsigned long flags;
+
+		mhi_chan->db_cfg.db_mode = 1;
+		read_lock_irqsave(&mhi_cntrl->pm_lock, flags);
+		if (tre_ring->wp != tre_ring->rp &&
+		    MHI_DB_ACCESS_VALID(mhi_cntrl)) {
+			mhi_ring_chan_db(mhi_cntrl, mhi_chan);
+		}
+		read_unlock_irqrestore(&mhi_cntrl->pm_lock, flags);
+		break;
+	}
+	case MHI_EV_CC_BAD_TRE:
+	default:
+		dev_err(dev, "Unknown event 0x%x\n", ev_code);
+		break;
+	} /* switch(MHI_EV_READ_CODE(EV_TRB_CODE,event)) */
+
+end_process_tx_event:
+	if (ev_code >= MHI_EV_CC_OOB)
+		write_unlock_irqrestore(&mhi_chan->lock, flags);
+	else
+		read_unlock_bh(&mhi_chan->lock);
+
+	return 0;
+}
+
+static int parse_rsc_event(struct mhi_controller *mhi_cntrl,
+			   struct mhi_tre *event,
+			   struct mhi_chan *mhi_chan)
+{
+	struct mhi_ring *buf_ring, *tre_ring;
+	struct mhi_buf_info *buf_info;
+	struct mhi_result result;
+	int ev_code;
+	u32 cookie; /* offset to local descriptor */
+	u16 xfer_len;
+
+	buf_ring = &mhi_chan->buf_ring;
+	tre_ring = &mhi_chan->tre_ring;
+
+	ev_code = MHI_TRE_GET_EV_CODE(event);
+	cookie = MHI_TRE_GET_EV_COOKIE(event);
+	xfer_len = MHI_TRE_GET_EV_LEN(event);
+
+	/* Received out of bound cookie */
+	WARN_ON(cookie >= buf_ring->len);
+
+	buf_info = buf_ring->base + cookie;
+
+	result.transaction_status = (ev_code == MHI_EV_CC_OVERFLOW) ?
+		-EOVERFLOW : 0;
+
+	/* truncate to buf len if xfer_len is larger */
+	result.bytes_xferd = min_t(u16, xfer_len, buf_info->len);
+	result.buf_addr = buf_info->cb_buf;
+	result.dir = mhi_chan->dir;
+
+	read_lock_bh(&mhi_chan->lock);
+
+	if (mhi_chan->ch_state != MHI_CH_STATE_ENABLED)
+		goto end_process_rsc_event;
+
+	WARN_ON(!buf_info->used);
+
+	/* notify the client */
+	mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
+
+	/*
+	 * Note: We're arbitrarily incrementing RP even though, completion
+	 * packet we processed might not be the same one, reason we can do this
+	 * is because device guaranteed to cache descriptors in order it
+	 * receive, so even though completion event is different we can re-use
+	 * all descriptors in between.
+	 * Example:
+	 * Transfer Ring has descriptors: A, B, C, D
+	 * Last descriptor host queue is D (WP) and first descriptor
+	 * host queue is A (RP).
+	 * The completion event we just serviced is descriptor C.
+	 * Then we can safely queue descriptors to replace A, B, and C
+	 * even though host did not receive any completions.
+	 */
+	mhi_del_ring_element(mhi_cntrl, tre_ring);
+	buf_info->used = false;
+
+end_process_rsc_event:
+	read_unlock_bh(&mhi_chan->lock);
+
+	return 0;
+}
+
+static void mhi_process_cmd_completion(struct mhi_controller *mhi_cntrl,
+				       struct mhi_tre *tre)
+{
+	dma_addr_t ptr = MHI_TRE_GET_EV_PTR(tre);
+	struct mhi_cmd *cmd_ring = &mhi_cntrl->mhi_cmd[PRIMARY_CMD_RING];
+	struct mhi_ring *mhi_ring = &cmd_ring->ring;
+	struct mhi_tre *cmd_pkt;
+	struct mhi_chan *mhi_chan;
+	u32 chan;
+
+	if (!is_valid_ring_ptr(mhi_ring, ptr)) {
+		dev_err(&mhi_cntrl->mhi_dev->dev,
+			"Event element points outside of the cmd ring\n");
+		return;
+	}
+
+	cmd_pkt = mhi_to_virtual(mhi_ring, ptr);
+
+	chan = MHI_TRE_GET_CMD_CHID(cmd_pkt);
+
+	if (chan < mhi_cntrl->max_chan &&
+	    mhi_cntrl->mhi_chan[chan].configured) {
+		mhi_chan = &mhi_cntrl->mhi_chan[chan];
+		write_lock_bh(&mhi_chan->lock);
+		mhi_chan->ccs = MHI_TRE_GET_EV_CODE(tre);
+		complete(&mhi_chan->completion);
+		write_unlock_bh(&mhi_chan->lock);
+	} else {
+		dev_err(&mhi_cntrl->mhi_dev->dev,
+			"Completion packet for invalid channel ID: %d\n", chan);
+	}
+
+	mhi_del_ring_element(mhi_cntrl, mhi_ring);
+}
+
+int mhi_process_ctrl_ev_ring(struct mhi_controller *mhi_cntrl,
+			     struct mhi_event *mhi_event,
+			     u32 event_quota)
+{
+	struct mhi_tre *dev_rp, *local_rp;
+	struct mhi_ring *ev_ring = &mhi_event->ring;
+	struct mhi_event_ctxt *er_ctxt =
+		&mhi_cntrl->mhi_ctxt->er_ctxt[mhi_event->er_index];
+	struct mhi_chan *mhi_chan;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	u32 chan;
+	int count = 0;
+	dma_addr_t ptr = er_ctxt->rp;
+
+	/*
+	 * This is a quick check to avoid unnecessary event processing
+	 * in case MHI is already in error state, but it's still possible
+	 * to transition to error state while processing events
+	 */
+	if (unlikely(MHI_EVENT_ACCESS_INVALID(mhi_cntrl->pm_state)))
+		return -EIO;
+
+	if (!is_valid_ring_ptr(ev_ring, ptr)) {
+		dev_err(&mhi_cntrl->mhi_dev->dev,
+			"Event ring rp points outside of the event ring\n");
+		return -EIO;
+	}
+
+	dev_rp = mhi_to_virtual(ev_ring, ptr);
+	local_rp = ev_ring->rp;
+
+	while (dev_rp != local_rp) {
+		enum mhi_pkt_type type = MHI_TRE_GET_EV_TYPE(local_rp);
+
+		switch (type) {
+		case MHI_PKT_TYPE_BW_REQ_EVENT:
+		{
+			struct mhi_link_info *link_info;
+
+			link_info = &mhi_cntrl->mhi_link_info;
+			write_lock_irq(&mhi_cntrl->pm_lock);
+			link_info->target_link_speed =
+				MHI_TRE_GET_EV_LINKSPEED(local_rp);
+			link_info->target_link_width =
+				MHI_TRE_GET_EV_LINKWIDTH(local_rp);
+			write_unlock_irq(&mhi_cntrl->pm_lock);
+			dev_dbg(dev, "Received BW_REQ event\n");
+			mhi_cntrl->status_cb(mhi_cntrl, MHI_CB_BW_REQ);
+			break;
+		}
+		case MHI_PKT_TYPE_STATE_CHANGE_EVENT:
+		{
+			enum mhi_state new_state;
+
+			new_state = MHI_TRE_GET_EV_STATE(local_rp);
+
+			dev_dbg(dev, "State change event to state: %s\n",
+				TO_MHI_STATE_STR(new_state));
+
+			switch (new_state) {
+			case MHI_STATE_M0:
+				mhi_pm_m0_transition(mhi_cntrl);
+				break;
+			case MHI_STATE_M1:
+				mhi_pm_m1_transition(mhi_cntrl);
+				break;
+			case MHI_STATE_M3:
+				mhi_pm_m3_transition(mhi_cntrl);
+				break;
+			case MHI_STATE_SYS_ERR:
+			{
+				enum mhi_pm_state new_state;
+
+				/* skip SYS_ERROR handling if RDDM supported */
+				if (mhi_cntrl->ee == MHI_EE_RDDM ||
+				    mhi_cntrl->rddm_image)
+					break;
+
+				dev_dbg(dev, "System error detected\n");
+				write_lock_irq(&mhi_cntrl->pm_lock);
+				new_state = mhi_tryset_pm_state(mhi_cntrl,
+							MHI_PM_SYS_ERR_DETECT);
+				write_unlock_irq(&mhi_cntrl->pm_lock);
+				if (new_state == MHI_PM_SYS_ERR_DETECT)
+					mhi_pm_sys_err_handler(mhi_cntrl);
+				break;
+			}
+			default:
+				dev_err(dev, "Invalid state: %s\n",
+					TO_MHI_STATE_STR(new_state));
+			}
+
+			break;
+		}
+		case MHI_PKT_TYPE_CMD_COMPLETION_EVENT:
+			mhi_process_cmd_completion(mhi_cntrl, local_rp);
+			break;
+		case MHI_PKT_TYPE_EE_EVENT:
+		{
+			enum dev_st_transition st = DEV_ST_TRANSITION_MAX;
+			enum mhi_ee_type event = MHI_TRE_GET_EV_EXECENV(local_rp);
+
+			dev_dbg(dev, "Received EE event: %s\n",
+				TO_MHI_EXEC_STR(event));
+			switch (event) {
+			case MHI_EE_SBL:
+				st = DEV_ST_TRANSITION_SBL;
+				break;
+			case MHI_EE_WFW:
+			case MHI_EE_AMSS:
+				st = DEV_ST_TRANSITION_MISSION_MODE;
+				break;
+			case MHI_EE_RDDM:
+				mhi_cntrl->status_cb(mhi_cntrl, MHI_CB_EE_RDDM);
+				write_lock_irq(&mhi_cntrl->pm_lock);
+				mhi_cntrl->ee = event;
+				write_unlock_irq(&mhi_cntrl->pm_lock);
+				wake_up_all(&mhi_cntrl->state_event);
+				break;
+			default:
+				dev_err(dev,
+					"Unhandled EE event: 0x%x\n", type);
+			}
+			if (st != DEV_ST_TRANSITION_MAX)
+				mhi_queue_state_transition(mhi_cntrl, st);
+
+			break;
+		}
+		case MHI_PKT_TYPE_TX_EVENT:
+			chan = MHI_TRE_GET_EV_CHID(local_rp);
+
+			WARN_ON(chan >= mhi_cntrl->max_chan);
+
+			/*
+			 * Only process the event ring elements whose channel
+			 * ID is within the maximum supported range.
+			 */
+			if (chan < mhi_cntrl->max_chan) {
+				mhi_chan = &mhi_cntrl->mhi_chan[chan];
+				if (!mhi_chan->configured)
+					break;
+				parse_xfer_event(mhi_cntrl, local_rp, mhi_chan);
+				event_quota--;
+			}
+			break;
+		default:
+			dev_err(dev, "Unhandled event type: %d\n", type);
+			break;
+		}
+
+		mhi_recycle_ev_ring_element(mhi_cntrl, ev_ring);
+		local_rp = ev_ring->rp;
+
+		ptr = er_ctxt->rp;
+		if (!is_valid_ring_ptr(ev_ring, ptr)) {
+			dev_err(&mhi_cntrl->mhi_dev->dev,
+				"Event ring rp points outside of the event ring\n");
+			return -EIO;
+		}
+
+		dev_rp = mhi_to_virtual(ev_ring, ptr);
+		count++;
+	}
+
+	read_lock_bh(&mhi_cntrl->pm_lock);
+	if (likely(MHI_DB_ACCESS_VALID(mhi_cntrl)))
+		mhi_ring_er_db(mhi_event);
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+
+	return count;
+}
+
+int mhi_process_data_event_ring(struct mhi_controller *mhi_cntrl,
+				struct mhi_event *mhi_event,
+				u32 event_quota)
+{
+	struct mhi_tre *dev_rp, *local_rp;
+	struct mhi_ring *ev_ring = &mhi_event->ring;
+	struct mhi_event_ctxt *er_ctxt =
+		&mhi_cntrl->mhi_ctxt->er_ctxt[mhi_event->er_index];
+	int count = 0;
+	u32 chan;
+	struct mhi_chan *mhi_chan;
+	dma_addr_t ptr = er_ctxt->rp;
+
+	if (unlikely(MHI_EVENT_ACCESS_INVALID(mhi_cntrl->pm_state)))
+		return -EIO;
+
+	if (!is_valid_ring_ptr(ev_ring, ptr)) {
+		dev_err(&mhi_cntrl->mhi_dev->dev,
+			"Event ring rp points outside of the event ring\n");
+		return -EIO;
+	}
+
+	dev_rp = mhi_to_virtual(ev_ring, ptr);
+	local_rp = ev_ring->rp;
+
+	while (dev_rp != local_rp && event_quota > 0) {
+		enum mhi_pkt_type type = MHI_TRE_GET_EV_TYPE(local_rp);
+
+		chan = MHI_TRE_GET_EV_CHID(local_rp);
+
+		WARN_ON(chan >= mhi_cntrl->max_chan);
+
+		/*
+		 * Only process the event ring elements whose channel
+		 * ID is within the maximum supported range.
+		 */
+		if (chan < mhi_cntrl->max_chan &&
+		    mhi_cntrl->mhi_chan[chan].configured) {
+			mhi_chan = &mhi_cntrl->mhi_chan[chan];
+
+			if (likely(type == MHI_PKT_TYPE_TX_EVENT)) {
+				parse_xfer_event(mhi_cntrl, local_rp, mhi_chan);
+				event_quota--;
+			} else if (type == MHI_PKT_TYPE_RSC_TX_EVENT) {
+				parse_rsc_event(mhi_cntrl, local_rp, mhi_chan);
+				event_quota--;
+			}
+		}
+
+		mhi_recycle_ev_ring_element(mhi_cntrl, ev_ring);
+		local_rp = ev_ring->rp;
+
+		ptr = er_ctxt->rp;
+		if (!is_valid_ring_ptr(ev_ring, ptr)) {
+			dev_err(&mhi_cntrl->mhi_dev->dev,
+				"Event ring rp points outside of the event ring\n");
+			return -EIO;
+		}
+
+		dev_rp = mhi_to_virtual(ev_ring, ptr);
+		count++;
+	}
+	read_lock_bh(&mhi_cntrl->pm_lock);
+	if (likely(MHI_DB_ACCESS_VALID(mhi_cntrl)))
+		mhi_ring_er_db(mhi_event);
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+
+	return count;
+}
+
+void mhi_ev_task(unsigned long data)
+{
+	struct mhi_event *mhi_event = (struct mhi_event *)data;
+	struct mhi_controller *mhi_cntrl = mhi_event->mhi_cntrl;
+
+	/* process all pending events */
+	spin_lock_bh(&mhi_event->lock);
+	mhi_event->process_event(mhi_cntrl, mhi_event, U32_MAX);
+	spin_unlock_bh(&mhi_event->lock);
+}
+
+void mhi_ctrl_ev_task(unsigned long data)
+{
+	struct mhi_event *mhi_event = (struct mhi_event *)data;
+	struct mhi_controller *mhi_cntrl = mhi_event->mhi_cntrl;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	enum mhi_state state;
+	enum mhi_pm_state pm_state = 0;
+	int ret;
+
+	/*
+	 * We can check PM state w/o a lock here because there is no way
+	 * PM state can change from reg access valid to no access while this
+	 * thread being executed.
+	 */
+	if (!MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state)) {
+		/*
+		 * We may have a pending event but not allowed to
+		 * process it since we are probably in a suspended state,
+		 * so trigger a resume.
+		 */
+		mhi_trigger_resume(mhi_cntrl);
+
+		return;
+	}
+
+	/* Process ctrl events events */
+	ret = mhi_event->process_event(mhi_cntrl, mhi_event, U32_MAX);
+
+	/*
+	 * We received an IRQ but no events to process, maybe device went to
+	 * SYS_ERR state? Check the state to confirm.
+	 */
+	if (!ret) {
+		write_lock_irq(&mhi_cntrl->pm_lock);
+		state = mhi_get_mhi_state(mhi_cntrl);
+		if (state == MHI_STATE_SYS_ERR) {
+			dev_dbg(dev, "System error detected\n");
+			pm_state = mhi_tryset_pm_state(mhi_cntrl,
+						       MHI_PM_SYS_ERR_DETECT);
+		}
+		write_unlock_irq(&mhi_cntrl->pm_lock);
+		if (pm_state == MHI_PM_SYS_ERR_DETECT)
+			mhi_pm_sys_err_handler(mhi_cntrl);
+	}
+}
+
+static bool mhi_is_ring_full(struct mhi_controller *mhi_cntrl,
+			     struct mhi_ring *ring)
+{
+	void *tmp = ring->wp + ring->el_size;
+
+	if (tmp >= (ring->base + ring->len))
+		tmp = ring->base;
+
+	return (tmp == ring->rp);
+}
+
+int mhi_queue_skb(struct mhi_device *mhi_dev, enum dma_data_direction dir,
+		  struct sk_buff *skb, size_t len, enum mhi_flags mflags)
+{
+	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
+	struct mhi_chan *mhi_chan = (dir == DMA_TO_DEVICE) ? mhi_dev->ul_chan :
+							     mhi_dev->dl_chan;
+	struct mhi_ring *tre_ring = &mhi_chan->tre_ring;
+	struct mhi_buf_info buf_info = { };
+	int ret;
+
+	/* If MHI host pre-allocates buffers then client drivers cannot queue */
+	if (mhi_chan->pre_alloc)
+		return -EINVAL;
+
+	if (mhi_is_ring_full(mhi_cntrl, tre_ring))
+		return -ENOMEM;
+
+	read_lock_bh(&mhi_cntrl->pm_lock);
+	if (unlikely(MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state))) {
+		read_unlock_bh(&mhi_cntrl->pm_lock);
+		return -EIO;
+	}
+
+	/* we're in M3 or transitioning to M3 */
+	if (MHI_PM_IN_SUSPEND_STATE(mhi_cntrl->pm_state))
+		mhi_trigger_resume(mhi_cntrl);
+
+	/* Toggle wake to exit out of M2 */
+	mhi_cntrl->wake_toggle(mhi_cntrl);
+
+	buf_info.v_addr = skb->data;
+	buf_info.cb_buf = skb;
+	buf_info.len = len;
+
+	ret = mhi_gen_tre(mhi_cntrl, mhi_chan, &buf_info, mflags);
+	if (unlikely(ret)) {
+		read_unlock_bh(&mhi_cntrl->pm_lock);
+		return ret;
+	}
+
+	if (mhi_chan->dir == DMA_TO_DEVICE)
+		atomic_inc(&mhi_cntrl->pending_pkts);
+
+	if (likely(MHI_DB_ACCESS_VALID(mhi_cntrl))) {
+		read_lock_bh(&mhi_chan->lock);
+		mhi_ring_chan_db(mhi_cntrl, mhi_chan);
+		read_unlock_bh(&mhi_chan->lock);
+	}
+
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mhi_queue_skb);
+
+int mhi_queue_dma(struct mhi_device *mhi_dev, enum dma_data_direction dir,
+		  struct mhi_buf *mhi_buf, size_t len, enum mhi_flags mflags)
+{
+	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
+	struct mhi_chan *mhi_chan = (dir == DMA_TO_DEVICE) ? mhi_dev->ul_chan :
+							     mhi_dev->dl_chan;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	struct mhi_ring *tre_ring = &mhi_chan->tre_ring;
+	struct mhi_buf_info buf_info = { };
+	int ret;
+
+	/* If MHI host pre-allocates buffers then client drivers cannot queue */
+	if (mhi_chan->pre_alloc)
+		return -EINVAL;
+
+	if (mhi_is_ring_full(mhi_cntrl, tre_ring))
+		return -ENOMEM;
+
+	read_lock_bh(&mhi_cntrl->pm_lock);
+	if (unlikely(MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state))) {
+		dev_err(dev, "MHI is not in activate state, PM state: %s\n",
+			to_mhi_pm_state_str(mhi_cntrl->pm_state));
+		read_unlock_bh(&mhi_cntrl->pm_lock);
+
+		return -EIO;
+	}
+
+	/* we're in M3 or transitioning to M3 */
+	if (MHI_PM_IN_SUSPEND_STATE(mhi_cntrl->pm_state))
+		mhi_trigger_resume(mhi_cntrl);
+
+	/* Toggle wake to exit out of M2 */
+	mhi_cntrl->wake_toggle(mhi_cntrl);
+
+	buf_info.p_addr = mhi_buf->dma_addr;
+	buf_info.cb_buf = mhi_buf;
+	buf_info.pre_mapped = true;
+	buf_info.len = len;
+
+	ret = mhi_gen_tre(mhi_cntrl, mhi_chan, &buf_info, mflags);
+	if (unlikely(ret)) {
+		read_unlock_bh(&mhi_cntrl->pm_lock);
+		return ret;
+	}
+
+	if (mhi_chan->dir == DMA_TO_DEVICE)
+		atomic_inc(&mhi_cntrl->pending_pkts);
+
+	if (likely(MHI_DB_ACCESS_VALID(mhi_cntrl))) {
+		read_lock_bh(&mhi_chan->lock);
+		mhi_ring_chan_db(mhi_cntrl, mhi_chan);
+		read_unlock_bh(&mhi_chan->lock);
+	}
+
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mhi_queue_dma);
+
+int mhi_gen_tre(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan,
+			struct mhi_buf_info *info, enum mhi_flags flags)
+{
+	struct mhi_ring *buf_ring, *tre_ring;
+	struct mhi_tre *mhi_tre;
+	struct mhi_buf_info *buf_info;
+	int eot, eob, chain, bei;
+	int ret;
+
+	buf_ring = &mhi_chan->buf_ring;
+	tre_ring = &mhi_chan->tre_ring;
+
+	buf_info = buf_ring->wp;
+	WARN_ON(buf_info->used);
+	buf_info->pre_mapped = info->pre_mapped;
+	if (info->pre_mapped)
+		buf_info->p_addr = info->p_addr;
+	else
+		buf_info->v_addr = info->v_addr;
+	buf_info->cb_buf = info->cb_buf;
+	buf_info->wp = tre_ring->wp;
+	buf_info->dir = mhi_chan->dir;
+	buf_info->len = info->len;
+
+	if (!info->pre_mapped) {
+		ret = mhi_cntrl->map_single(mhi_cntrl, buf_info);
+		if (ret)
+			return ret;
+	}
+
+	eob = !!(flags & MHI_EOB);
+	eot = !!(flags & MHI_EOT);
+	chain = !!(flags & MHI_CHAIN);
+	bei = !!(mhi_chan->intmod);
+
+	mhi_tre = tre_ring->wp;
+	mhi_tre->ptr = MHI_TRE_DATA_PTR(buf_info->p_addr);
+	mhi_tre->dword[0] = MHI_TRE_DATA_DWORD0(info->len);
+	mhi_tre->dword[1] = MHI_TRE_DATA_DWORD1(bei, eot, eob, chain);
+
+	/* increment WP */
+	mhi_add_ring_element(mhi_cntrl, tre_ring);
+	mhi_add_ring_element(mhi_cntrl, buf_ring);
+
+	return 0;
+}
+
+int mhi_queue_buf(struct mhi_device *mhi_dev, enum dma_data_direction dir,
+		  void *buf, size_t len, enum mhi_flags mflags)
+{
+	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
+	struct mhi_chan *mhi_chan = (dir == DMA_TO_DEVICE) ? mhi_dev->ul_chan :
+							     mhi_dev->dl_chan;
+	struct mhi_ring *tre_ring;
+	struct mhi_buf_info buf_info = { };
+	unsigned long flags;
+	int ret;
+
+	/*
+	 * this check here only as a guard, it's always
+	 * possible mhi can enter error while executing rest of function,
+	 * which is not fatal so we do not need to hold pm_lock
+	 */
+	if (unlikely(MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)))
+		return -EIO;
+
+	tre_ring = &mhi_chan->tre_ring;
+	if (mhi_is_ring_full(mhi_cntrl, tre_ring))
+		return -ENOMEM;
+
+	buf_info.v_addr = buf;
+	buf_info.cb_buf = buf;
+	buf_info.len = len;
+
+	ret = mhi_gen_tre(mhi_cntrl, mhi_chan, &buf_info, mflags);
+	if (unlikely(ret))
+		return ret;
+
+	read_lock_irqsave(&mhi_cntrl->pm_lock, flags);
+
+	/* we're in M3 or transitioning to M3 */
+	if (MHI_PM_IN_SUSPEND_STATE(mhi_cntrl->pm_state))
+		mhi_trigger_resume(mhi_cntrl);
+
+	/* Toggle wake to exit out of M2 */
+	mhi_cntrl->wake_toggle(mhi_cntrl);
+
+	if (mhi_chan->dir == DMA_TO_DEVICE)
+		atomic_inc(&mhi_cntrl->pending_pkts);
+
+	if (likely(MHI_DB_ACCESS_VALID(mhi_cntrl))) {
+		unsigned long flags;
+
+		read_lock_irqsave(&mhi_chan->lock, flags);
+		mhi_ring_chan_db(mhi_cntrl, mhi_chan);
+		read_unlock_irqrestore(&mhi_chan->lock, flags);
+	}
+
+	read_unlock_irqrestore(&mhi_cntrl->pm_lock, flags);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mhi_queue_buf);
+
+int mhi_send_cmd(struct mhi_controller *mhi_cntrl,
+		 struct mhi_chan *mhi_chan,
+		 enum mhi_cmd_type cmd)
+{
+	struct mhi_tre *cmd_tre = NULL;
+	struct mhi_cmd *mhi_cmd = &mhi_cntrl->mhi_cmd[PRIMARY_CMD_RING];
+	struct mhi_ring *ring = &mhi_cmd->ring;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	int chan = 0;
+
+	if (mhi_chan)
+		chan = mhi_chan->chan;
+
+	spin_lock_bh(&mhi_cmd->lock);
+	if (!get_nr_avail_ring_elements(mhi_cntrl, ring)) {
+		spin_unlock_bh(&mhi_cmd->lock);
+		return -ENOMEM;
+	}
+
+	/* prepare the cmd tre */
+	cmd_tre = ring->wp;
+	switch (cmd) {
+	case MHI_CMD_RESET_CHAN:
+		cmd_tre->ptr = MHI_TRE_CMD_RESET_PTR;
+		cmd_tre->dword[0] = MHI_TRE_CMD_RESET_DWORD0;
+		cmd_tre->dword[1] = MHI_TRE_CMD_RESET_DWORD1(chan);
+		break;
+	case MHI_CMD_START_CHAN:
+		cmd_tre->ptr = MHI_TRE_CMD_START_PTR;
+		cmd_tre->dword[0] = MHI_TRE_CMD_START_DWORD0;
+		cmd_tre->dword[1] = MHI_TRE_CMD_START_DWORD1(chan);
+		break;
+	default:
+		dev_err(dev, "Command not supported\n");
+		break;
+	}
+
+	/* queue to hardware */
+	mhi_add_ring_element(mhi_cntrl, ring);
+	read_lock_bh(&mhi_cntrl->pm_lock);
+	if (likely(MHI_DB_ACCESS_VALID(mhi_cntrl)))
+		mhi_ring_cmd_db(mhi_cntrl, mhi_cmd);
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+	spin_unlock_bh(&mhi_cmd->lock);
+
+	return 0;
+}
+
+static void __mhi_unprepare_channel(struct mhi_controller *mhi_cntrl,
+				    struct mhi_chan *mhi_chan)
+{
+	int ret;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+
+	dev_dbg(dev, "Entered: unprepare channel:%d\n", mhi_chan->chan);
+
+	/* no more processing events for this channel */
+	mutex_lock(&mhi_chan->mutex);
+	write_lock_irq(&mhi_chan->lock);
+	if (mhi_chan->ch_state != MHI_CH_STATE_ENABLED) {
+		write_unlock_irq(&mhi_chan->lock);
+		mutex_unlock(&mhi_chan->mutex);
+		return;
+	}
+
+	mhi_chan->ch_state = MHI_CH_STATE_DISABLED;
+	write_unlock_irq(&mhi_chan->lock);
+
+	reinit_completion(&mhi_chan->completion);
+	read_lock_bh(&mhi_cntrl->pm_lock);
+	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
+		read_unlock_bh(&mhi_cntrl->pm_lock);
+		goto error_invalid_state;
+	}
+
+	mhi_cntrl->wake_toggle(mhi_cntrl);
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+
+	mhi_cntrl->runtime_get(mhi_cntrl);
+	mhi_cntrl->runtime_put(mhi_cntrl);
+	ret = mhi_send_cmd(mhi_cntrl, mhi_chan, MHI_CMD_RESET_CHAN);
+	if (ret)
+		goto error_invalid_state;
+
+	/* even if it fails we will still reset */
+	ret = wait_for_completion_timeout(&mhi_chan->completion,
+				msecs_to_jiffies(mhi_cntrl->timeout_ms));
+	if (!ret || mhi_chan->ccs != MHI_EV_CC_SUCCESS)
+		dev_err(dev,
+			"Failed to receive cmd completion, still resetting\n");
+
+error_invalid_state:
+	if (!mhi_chan->offload_ch) {
+		mhi_reset_chan(mhi_cntrl, mhi_chan);
+		mhi_deinit_chan_ctxt(mhi_cntrl, mhi_chan);
+	}
+	dev_dbg(dev, "chan:%d successfully resetted\n", mhi_chan->chan);
+	mutex_unlock(&mhi_chan->mutex);
+}
+
+int mhi_prepare_channel(struct mhi_controller *mhi_cntrl,
+			struct mhi_chan *mhi_chan)
+{
+	int ret = 0;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+
+	dev_dbg(dev, "Preparing channel: %d\n", mhi_chan->chan);
+
+	if (!(BIT(mhi_cntrl->ee) & mhi_chan->ee_mask)) {
+		dev_err(dev,
+			"Current EE: %s Required EE Mask: 0x%x for chan: %s\n",
+			TO_MHI_EXEC_STR(mhi_cntrl->ee), mhi_chan->ee_mask,
+			mhi_chan->name);
+		return -ENOTCONN;
+	}
+
+	mutex_lock(&mhi_chan->mutex);
+
+	/* If channel is not in disable state, do not allow it to start */
+	if (mhi_chan->ch_state != MHI_CH_STATE_DISABLED) {
+		ret = -EIO;
+		dev_dbg(dev, "channel: %d is not in disabled state\n",
+			mhi_chan->chan);
+		goto error_init_chan;
+	}
+
+	/* Check of client manages channel context for offload channels */
+	if (!mhi_chan->offload_ch) {
+		ret = mhi_init_chan_ctxt(mhi_cntrl, mhi_chan);
+		if (ret)
+			goto error_init_chan;
+	}
+
+	reinit_completion(&mhi_chan->completion);
+	read_lock_bh(&mhi_cntrl->pm_lock);
+	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
+		read_unlock_bh(&mhi_cntrl->pm_lock);
+		ret = -EIO;
+		goto error_pm_state;
+	}
+
+	mhi_cntrl->wake_toggle(mhi_cntrl);
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+	mhi_cntrl->runtime_get(mhi_cntrl);
+	mhi_cntrl->runtime_put(mhi_cntrl);
+
+	ret = mhi_send_cmd(mhi_cntrl, mhi_chan, MHI_CMD_START_CHAN);
+	if (ret)
+		goto error_pm_state;
+
+	ret = wait_for_completion_timeout(&mhi_chan->completion,
+				msecs_to_jiffies(mhi_cntrl->timeout_ms));
+	if (!ret || mhi_chan->ccs != MHI_EV_CC_SUCCESS) {
+		ret = -EIO;
+		goto error_pm_state;
+	}
+
+	write_lock_irq(&mhi_chan->lock);
+	mhi_chan->ch_state = MHI_CH_STATE_ENABLED;
+	write_unlock_irq(&mhi_chan->lock);
+
+	/* Pre-allocate buffer for xfer ring */
+	if (mhi_chan->pre_alloc) {
+		int nr_el = get_nr_avail_ring_elements(mhi_cntrl,
+						       &mhi_chan->tre_ring);
+		size_t len = mhi_cntrl->buffer_len;
+
+		while (nr_el--) {
+			void *buf;
+			struct mhi_buf_info info = { };
+			buf = kmalloc(len, GFP_KERNEL);
+			if (!buf) {
+				ret = -ENOMEM;
+				goto error_pre_alloc;
+			}
+
+			/* Prepare transfer descriptors */
+			info.v_addr = buf;
+			info.cb_buf = buf;
+			info.len = len;
+			ret = mhi_gen_tre(mhi_cntrl, mhi_chan, &info, MHI_EOT);
+			if (ret) {
+				kfree(buf);
+				goto error_pre_alloc;
+			}
+		}
+
+		read_lock_bh(&mhi_cntrl->pm_lock);
+		if (MHI_DB_ACCESS_VALID(mhi_cntrl)) {
+			read_lock_irq(&mhi_chan->lock);
+			mhi_ring_chan_db(mhi_cntrl, mhi_chan);
+			read_unlock_irq(&mhi_chan->lock);
+		}
+		read_unlock_bh(&mhi_cntrl->pm_lock);
+	}
+
+	mutex_unlock(&mhi_chan->mutex);
+
+	dev_dbg(dev, "Chan: %d successfully moved to start state\n",
+		mhi_chan->chan);
+
+	return 0;
+
+error_pm_state:
+	if (!mhi_chan->offload_ch)
+		mhi_deinit_chan_ctxt(mhi_cntrl, mhi_chan);
+
+error_init_chan:
+	mutex_unlock(&mhi_chan->mutex);
+
+	return ret;
+
+error_pre_alloc:
+	mutex_unlock(&mhi_chan->mutex);
+	__mhi_unprepare_channel(mhi_cntrl, mhi_chan);
+
+	return ret;
+}
+
+static void mhi_mark_stale_events(struct mhi_controller *mhi_cntrl,
+				  struct mhi_event *mhi_event,
+				  struct mhi_event_ctxt *er_ctxt,
+				  int chan)
+
+{
+	struct mhi_tre *dev_rp, *local_rp;
+	struct mhi_ring *ev_ring;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	unsigned long flags;
+	dma_addr_t ptr;
+
+	dev_dbg(dev, "Marking all events for chan: %d as stale\n", chan);
+
+	ev_ring = &mhi_event->ring;
+
+	/* mark all stale events related to channel as STALE event */
+	spin_lock_irqsave(&mhi_event->lock, flags);
+
+	ptr = er_ctxt->rp;
+	if (!is_valid_ring_ptr(ev_ring, ptr)) {
+		dev_err(&mhi_cntrl->mhi_dev->dev,
+			"Event ring rp points outside of the event ring\n");
+		dev_rp = ev_ring->rp;
+	} else {
+		dev_rp = mhi_to_virtual(ev_ring, ptr);
+	}
+
+	local_rp = ev_ring->rp;
+	while (dev_rp != local_rp) {
+		if (MHI_TRE_GET_EV_TYPE(local_rp) == MHI_PKT_TYPE_TX_EVENT &&
+		    chan == MHI_TRE_GET_EV_CHID(local_rp))
+			local_rp->dword[1] = MHI_TRE_EV_DWORD1(chan,
+					MHI_PKT_TYPE_STALE_EVENT);
+		local_rp++;
+		if (local_rp == (ev_ring->base + ev_ring->len))
+			local_rp = ev_ring->base;
+	}
+
+	dev_dbg(dev, "Finished marking events as stale events\n");
+	spin_unlock_irqrestore(&mhi_event->lock, flags);
+}
+
+static void mhi_reset_data_chan(struct mhi_controller *mhi_cntrl,
+				struct mhi_chan *mhi_chan)
+{
+	struct mhi_ring *buf_ring, *tre_ring;
+	struct mhi_result result;
+
+	/* Reset any pending buffers */
+	buf_ring = &mhi_chan->buf_ring;
+	tre_ring = &mhi_chan->tre_ring;
+	result.transaction_status = -ENOTCONN;
+	result.bytes_xferd = 0;
+	while (tre_ring->rp != tre_ring->wp) {
+		struct mhi_buf_info *buf_info = buf_ring->rp;
+
+		if (mhi_chan->dir == DMA_TO_DEVICE)
+			atomic_dec(&mhi_cntrl->pending_pkts);
+
+		if (!buf_info->pre_mapped)
+			mhi_cntrl->unmap_single(mhi_cntrl, buf_info);
+
+		mhi_del_ring_element(mhi_cntrl, buf_ring);
+		mhi_del_ring_element(mhi_cntrl, tre_ring);
+
+		if (mhi_chan->pre_alloc) {
+			kfree(buf_info->cb_buf);
+		} else {
+			result.buf_addr = buf_info->cb_buf;
+			mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
+		}
+	}
+}
+
+void mhi_reset_chan(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan)
+{
+	struct mhi_event *mhi_event;
+	struct mhi_event_ctxt *er_ctxt;
+	int chan = mhi_chan->chan;
+
+	/* Nothing to reset, client doesn't queue buffers */
+	if (mhi_chan->offload_ch)
+		return;
+
+	read_lock_bh(&mhi_cntrl->pm_lock);
+	mhi_event = &mhi_cntrl->mhi_event[mhi_chan->er_index];
+	er_ctxt = &mhi_cntrl->mhi_ctxt->er_ctxt[mhi_chan->er_index];
+
+	mhi_mark_stale_events(mhi_cntrl, mhi_event, er_ctxt, chan);
+
+	mhi_reset_data_chan(mhi_cntrl, mhi_chan);
+
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+}
+
+/* Move channel to start state */
+int mhi_prepare_for_transfer(struct mhi_device *mhi_dev)
+{
+	int ret, dir;
+	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
+	struct mhi_chan *mhi_chan;
+
+	for (dir = 0; dir < 2; dir++) {
+		mhi_chan = dir ? mhi_dev->dl_chan : mhi_dev->ul_chan;
+		if (!mhi_chan)
+			continue;
+
+		ret = mhi_prepare_channel(mhi_cntrl, mhi_chan);
+		if (ret)
+			goto error_open_chan;
+	}
+
+	return 0;
+
+error_open_chan:
+	for (--dir; dir >= 0; dir--) {
+		mhi_chan = dir ? mhi_dev->dl_chan : mhi_dev->ul_chan;
+		if (!mhi_chan)
+			continue;
+
+		__mhi_unprepare_channel(mhi_cntrl, mhi_chan);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mhi_prepare_for_transfer);
+
+void mhi_unprepare_from_transfer(struct mhi_device *mhi_dev)
+{
+	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
+	struct mhi_chan *mhi_chan;
+	int dir;
+
+	for (dir = 0; dir < 2; dir++) {
+		mhi_chan = dir ? mhi_dev->ul_chan : mhi_dev->dl_chan;
+		if (!mhi_chan)
+			continue;
+
+		__mhi_unprepare_channel(mhi_cntrl, mhi_chan);
+	}
+}
+EXPORT_SYMBOL_GPL(mhi_unprepare_from_transfer);
+
+int mhi_poll(struct mhi_device *mhi_dev, u32 budget)
+{
+	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
+	struct mhi_chan *mhi_chan = mhi_dev->dl_chan;
+	struct mhi_event *mhi_event = &mhi_cntrl->mhi_event[mhi_chan->er_index];
+	int ret;
+
+	spin_lock_bh(&mhi_event->lock);
+	ret = mhi_event->process_event(mhi_cntrl, mhi_event, budget);
+	spin_unlock_bh(&mhi_event->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mhi_poll);
diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
new file mode 100644
index 000000000000..e3df838c3c80
--- /dev/null
+++ b/drivers/bus/mhi/host/pci_generic.c
@@ -0,0 +1,345 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * MHI PCI driver - MHI over PCI controller driver
+ *
+ * This module is a generic driver for registering MHI-over-PCI devices,
+ * such as PCIe QCOM modems.
+ *
+ * Copyright (C) 2020 Linaro Ltd <loic.poulain@linaro.org>
+ */
+
+#include <linux/device.h>
+#include <linux/mhi.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+
+#define MHI_PCI_DEFAULT_BAR_NUM 0
+
+/**
+ * struct mhi_pci_dev_info - MHI PCI device specific information
+ * @config: MHI controller configuration
+ * @name: name of the PCI module
+ * @fw: firmware path (if any)
+ * @edl: emergency download mode firmware path (if any)
+ * @bar_num: PCI base address register to use for MHI MMIO register space
+ * @dma_data_width: DMA transfer word size (32 or 64 bits)
+ */
+struct mhi_pci_dev_info {
+	const struct mhi_controller_config *config;
+	const char *name;
+	const char *fw;
+	const char *edl;
+	unsigned int bar_num;
+	unsigned int dma_data_width;
+};
+
+#define MHI_CHANNEL_CONFIG_UL(ch_num, ch_name, el_count, ev_ring) \
+	{						\
+		.num = ch_num,				\
+		.name = ch_name,			\
+		.num_elements = el_count,		\
+		.event_ring = ev_ring,			\
+		.dir = DMA_TO_DEVICE,			\
+		.ee_mask = BIT(MHI_EE_AMSS),		\
+		.pollcfg = 0,				\
+		.doorbell = MHI_DB_BRST_DISABLE,	\
+		.lpm_notify = false,			\
+		.offload_channel = false,		\
+		.doorbell_mode_switch = false,		\
+	}						\
+
+#define MHI_CHANNEL_CONFIG_DL(ch_num, ch_name, el_count, ev_ring) \
+	{						\
+		.num = ch_num,				\
+		.name = ch_name,			\
+		.num_elements = el_count,		\
+		.event_ring = ev_ring,			\
+		.dir = DMA_FROM_DEVICE,			\
+		.ee_mask = BIT(MHI_EE_AMSS),		\
+		.pollcfg = 0,				\
+		.doorbell = MHI_DB_BRST_DISABLE,	\
+		.lpm_notify = false,			\
+		.offload_channel = false,		\
+		.doorbell_mode_switch = false,		\
+	}
+
+#define MHI_EVENT_CONFIG_CTRL(ev_ring)		\
+	{					\
+		.num_elements = 64,		\
+		.irq_moderation_ms = 0,		\
+		.irq = (ev_ring) + 1,		\
+		.priority = 1,			\
+		.mode = MHI_DB_BRST_DISABLE,	\
+		.data_type = MHI_ER_CTRL,	\
+		.hardware_event = false,	\
+		.client_managed = false,	\
+		.offload_channel = false,	\
+	}
+
+#define MHI_EVENT_CONFIG_DATA(ev_ring)		\
+	{					\
+		.num_elements = 128,		\
+		.irq_moderation_ms = 5,		\
+		.irq = (ev_ring) + 1,		\
+		.priority = 1,			\
+		.mode = MHI_DB_BRST_DISABLE,	\
+		.data_type = MHI_ER_DATA,	\
+		.hardware_event = false,	\
+		.client_managed = false,	\
+		.offload_channel = false,	\
+	}
+
+#define MHI_EVENT_CONFIG_HW_DATA(ev_ring, ch_num) \
+	{					\
+		.num_elements = 128,		\
+		.irq_moderation_ms = 5,		\
+		.irq = (ev_ring) + 1,		\
+		.priority = 1,			\
+		.mode = MHI_DB_BRST_DISABLE,	\
+		.data_type = MHI_ER_DATA,	\
+		.hardware_event = true,		\
+		.client_managed = false,	\
+		.offload_channel = false,	\
+		.channel = ch_num,		\
+	}
+
+static const struct mhi_channel_config modem_qcom_v1_mhi_channels[] = {
+	MHI_CHANNEL_CONFIG_UL(12, "MBIM", 4, 0),
+	MHI_CHANNEL_CONFIG_DL(13, "MBIM", 4, 0),
+	MHI_CHANNEL_CONFIG_UL(14, "QMI", 4, 0),
+	MHI_CHANNEL_CONFIG_DL(15, "QMI", 4, 0),
+	MHI_CHANNEL_CONFIG_UL(20, "IPCR", 8, 0),
+	MHI_CHANNEL_CONFIG_DL(21, "IPCR", 8, 0),
+	MHI_CHANNEL_CONFIG_UL(100, "IP_HW0", 128, 1),
+	MHI_CHANNEL_CONFIG_DL(101, "IP_HW0", 128, 2),
+};
+
+static const struct mhi_event_config modem_qcom_v1_mhi_events[] = {
+	/* first ring is control+data ring */
+	MHI_EVENT_CONFIG_CTRL(0),
+	/* Hardware channels request dedicated hardware event rings */
+	MHI_EVENT_CONFIG_HW_DATA(1, 100),
+	MHI_EVENT_CONFIG_HW_DATA(2, 101)
+};
+
+static const struct mhi_controller_config modem_qcom_v1_mhiv_config = {
+	.max_channels = 128,
+	.timeout_ms = 5000,
+	.num_channels = ARRAY_SIZE(modem_qcom_v1_mhi_channels),
+	.ch_cfg = modem_qcom_v1_mhi_channels,
+	.num_events = ARRAY_SIZE(modem_qcom_v1_mhi_events),
+	.event_cfg = modem_qcom_v1_mhi_events,
+};
+
+static const struct mhi_pci_dev_info mhi_qcom_sdx55_info = {
+	.name = "qcom-sdx55m",
+	.fw = "qcom/sdx55m/sbl1.mbn",
+	.edl = "qcom/sdx55m/edl.mbn",
+	.config = &modem_qcom_v1_mhiv_config,
+	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
+	.dma_data_width = 32
+};
+
+static const struct pci_device_id mhi_pci_id_table[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0306),
+		.driver_data = (kernel_ulong_t) &mhi_qcom_sdx55_info },
+	{  }
+};
+MODULE_DEVICE_TABLE(pci, mhi_pci_id_table);
+
+static int mhi_pci_read_reg(struct mhi_controller *mhi_cntrl,
+			    void __iomem *addr, u32 *out)
+{
+	*out = readl(addr);
+	return 0;
+}
+
+static void mhi_pci_write_reg(struct mhi_controller *mhi_cntrl,
+			      void __iomem *addr, u32 val)
+{
+	writel(val, addr);
+}
+
+static void mhi_pci_status_cb(struct mhi_controller *mhi_cntrl,
+			      enum mhi_callback cb)
+{
+	/* Nothing to do for now */
+}
+
+static int mhi_pci_claim(struct mhi_controller *mhi_cntrl,
+			 unsigned int bar_num, u64 dma_mask)
+{
+	struct pci_dev *pdev = to_pci_dev(mhi_cntrl->cntrl_dev);
+	int err;
+
+	err = pci_assign_resource(pdev, bar_num);
+	if (err)
+		return err;
+
+	err = pcim_enable_device(pdev);
+	if (err) {
+		dev_err(&pdev->dev, "failed to enable pci device: %d\n", err);
+		return err;
+	}
+
+	err = pcim_iomap_regions(pdev, 1 << bar_num, pci_name(pdev));
+	if (err) {
+		dev_err(&pdev->dev, "failed to map pci region: %d\n", err);
+		return err;
+	}
+	mhi_cntrl->regs = pcim_iomap_table(pdev)[bar_num];
+
+	err = pci_set_dma_mask(pdev, dma_mask);
+	if (err) {
+		dev_err(&pdev->dev, "Cannot set proper DMA mask\n");
+		return err;
+	}
+
+	err = pci_set_consistent_dma_mask(pdev, dma_mask);
+	if (err) {
+		dev_err(&pdev->dev, "set consistent dma mask failed\n");
+		return err;
+	}
+
+	pci_set_master(pdev);
+
+	return 0;
+}
+
+static int mhi_pci_get_irqs(struct mhi_controller *mhi_cntrl,
+			    const struct mhi_controller_config *mhi_cntrl_config)
+{
+	struct pci_dev *pdev = to_pci_dev(mhi_cntrl->cntrl_dev);
+	int nr_vectors, i;
+	int *irq;
+
+	/*
+	 * Alloc one MSI vector for BHI + one vector per event ring, ideally...
+	 * No explicit pci_free_irq_vectors required, done by pcim_release.
+	 */
+	mhi_cntrl->nr_irqs = 1 + mhi_cntrl_config->num_events;
+
+	nr_vectors = pci_alloc_irq_vectors(pdev, 1, mhi_cntrl->nr_irqs, PCI_IRQ_MSI);
+	if (nr_vectors < 0) {
+		dev_err(&pdev->dev, "Error allocating MSI vectors %d\n",
+			nr_vectors);
+		return nr_vectors;
+	}
+
+	if (nr_vectors < mhi_cntrl->nr_irqs) {
+		dev_warn(&pdev->dev, "Not enough MSI vectors (%d/%d), use shared MSI\n",
+			 nr_vectors, mhi_cntrl_config->num_events);
+	}
+
+	irq = devm_kcalloc(&pdev->dev, mhi_cntrl->nr_irqs, sizeof(int), GFP_KERNEL);
+	if (!irq)
+		return -ENOMEM;
+
+	for (i = 0; i < mhi_cntrl->nr_irqs; i++) {
+		int vector = i >= nr_vectors ? (nr_vectors - 1) : i;
+
+		irq[i] = pci_irq_vector(pdev, vector);
+	}
+
+	mhi_cntrl->irq = irq;
+
+	return 0;
+}
+
+static int mhi_pci_runtime_get(struct mhi_controller *mhi_cntrl)
+{
+	/* no PM for now */
+	return 0;
+}
+
+static void mhi_pci_runtime_put(struct mhi_controller *mhi_cntrl)
+{
+	/* no PM for now */
+}
+
+static int mhi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	const struct mhi_pci_dev_info *info = (struct mhi_pci_dev_info *) id->driver_data;
+	const struct mhi_controller_config *mhi_cntrl_config;
+	struct mhi_controller *mhi_cntrl;
+	int err;
+
+	dev_dbg(&pdev->dev, "MHI PCI device found: %s\n", info->name);
+
+	mhi_cntrl = mhi_alloc_controller();
+	if (!mhi_cntrl)
+		return -ENOMEM;
+
+	mhi_cntrl_config = info->config;
+	mhi_cntrl->cntrl_dev = &pdev->dev;
+	mhi_cntrl->iova_start = 0;
+	mhi_cntrl->iova_stop = DMA_BIT_MASK(info->dma_data_width);
+	mhi_cntrl->fw_image = info->fw;
+	mhi_cntrl->edl_image = info->edl;
+
+	mhi_cntrl->read_reg = mhi_pci_read_reg;
+	mhi_cntrl->write_reg = mhi_pci_write_reg;
+	mhi_cntrl->status_cb = mhi_pci_status_cb;
+	mhi_cntrl->runtime_get = mhi_pci_runtime_get;
+	mhi_cntrl->runtime_put = mhi_pci_runtime_put;
+
+	err = mhi_pci_claim(mhi_cntrl, info->bar_num, DMA_BIT_MASK(info->dma_data_width));
+	if (err)
+		goto err_release;
+
+	err = mhi_pci_get_irqs(mhi_cntrl, mhi_cntrl_config);
+	if (err)
+		goto err_release;
+
+	pci_set_drvdata(pdev, mhi_cntrl);
+
+	err = mhi_register_controller(mhi_cntrl, mhi_cntrl_config);
+	if (err)
+		goto err_release;
+
+	/* MHI bus does not power up the controller by default */
+	err = mhi_prepare_for_power_up(mhi_cntrl);
+	if (err) {
+		dev_err(&pdev->dev, "failed to prepare MHI controller\n");
+		goto err_unregister;
+	}
+
+	err = mhi_sync_power_up(mhi_cntrl);
+	if (err) {
+		dev_err(&pdev->dev, "failed to power up MHI controller\n");
+		goto err_unprepare;
+	}
+
+	return 0;
+
+err_unprepare:
+	mhi_unprepare_after_power_down(mhi_cntrl);
+err_unregister:
+	mhi_unregister_controller(mhi_cntrl);
+err_release:
+	mhi_free_controller(mhi_cntrl);
+
+	return err;
+}
+
+static void mhi_pci_remove(struct pci_dev *pdev)
+{
+	struct mhi_controller *mhi_cntrl = pci_get_drvdata(pdev);
+
+	mhi_power_down(mhi_cntrl, true);
+	mhi_unprepare_after_power_down(mhi_cntrl);
+	mhi_unregister_controller(mhi_cntrl);
+	mhi_free_controller(mhi_cntrl);
+}
+
+static struct pci_driver mhi_pci_driver = {
+	.name		= "mhi-pci-generic",
+	.id_table	= mhi_pci_id_table,
+	.probe		= mhi_pci_probe,
+	.remove		= mhi_pci_remove
+};
+module_pci_driver(mhi_pci_driver);
+
+MODULE_AUTHOR("Loic Poulain <loic.poulain@linaro.org>");
+MODULE_DESCRIPTION("Modem Host Interface (MHI) PCI controller driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/bus/mhi/host/pm.c b/drivers/bus/mhi/host/pm.c
new file mode 100644
index 000000000000..7d69b740b9f9
--- /dev/null
+++ b/drivers/bus/mhi/host/pm.c
@@ -0,0 +1,1157 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018-2020, The Linux Foundation. All rights reserved.
+ *
+ */
+
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/dma-direction.h>
+#include <linux/dma-mapping.h>
+#include <linux/interrupt.h>
+#include <linux/list.h>
+#include <linux/mhi.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/wait.h>
+#include "internal.h"
+
+/*
+ * Not all MHI state transitions are synchronous. Transitions like Linkdown,
+ * SYS_ERR, and shutdown can happen anytime asynchronously. This function will
+ * transition to a new state only if we're allowed to.
+ *
+ * Priority increases as we go down. For instance, from any state in L0, the
+ * transition can be made to states in L1, L2 and L3. A notable exception to
+ * this rule is state DISABLE.  From DISABLE state we can only transition to
+ * POR state. Also, while in L2 state, user cannot jump back to previous
+ * L1 or L0 states.
+ *
+ * Valid transitions:
+ * L0: DISABLE <--> POR
+ *     POR <--> POR
+ *     POR -> M0 -> M2 --> M0
+ *     POR -> FW_DL_ERR
+ *     FW_DL_ERR <--> FW_DL_ERR
+ *     M0 <--> M0
+ *     M0 -> FW_DL_ERR
+ *     M0 -> M3_ENTER -> M3 -> M3_EXIT --> M0
+ * L1: SYS_ERR_DETECT -> SYS_ERR_PROCESS --> POR
+ * L2: SHUTDOWN_PROCESS -> DISABLE
+ * L3: LD_ERR_FATAL_DETECT <--> LD_ERR_FATAL_DETECT
+ *     LD_ERR_FATAL_DETECT -> SHUTDOWN_PROCESS
+ */
+static struct mhi_pm_transitions const dev_state_transitions[] = {
+	/* L0 States */
+	{
+		MHI_PM_DISABLE,
+		MHI_PM_POR
+	},
+	{
+		MHI_PM_POR,
+		MHI_PM_POR | MHI_PM_DISABLE | MHI_PM_M0 |
+		MHI_PM_SYS_ERR_DETECT | MHI_PM_SHUTDOWN_PROCESS |
+		MHI_PM_LD_ERR_FATAL_DETECT | MHI_PM_FW_DL_ERR
+	},
+	{
+		MHI_PM_M0,
+		MHI_PM_M0 | MHI_PM_M2 | MHI_PM_M3_ENTER |
+		MHI_PM_SYS_ERR_DETECT | MHI_PM_SHUTDOWN_PROCESS |
+		MHI_PM_LD_ERR_FATAL_DETECT | MHI_PM_FW_DL_ERR
+	},
+	{
+		MHI_PM_M2,
+		MHI_PM_M0 | MHI_PM_SYS_ERR_DETECT | MHI_PM_SHUTDOWN_PROCESS |
+		MHI_PM_LD_ERR_FATAL_DETECT
+	},
+	{
+		MHI_PM_M3_ENTER,
+		MHI_PM_M3 | MHI_PM_SYS_ERR_DETECT | MHI_PM_SHUTDOWN_PROCESS |
+		MHI_PM_LD_ERR_FATAL_DETECT
+	},
+	{
+		MHI_PM_M3,
+		MHI_PM_M3_EXIT | MHI_PM_SYS_ERR_DETECT |
+		MHI_PM_SHUTDOWN_PROCESS | MHI_PM_LD_ERR_FATAL_DETECT
+	},
+	{
+		MHI_PM_M3_EXIT,
+		MHI_PM_M0 | MHI_PM_SYS_ERR_DETECT | MHI_PM_SHUTDOWN_PROCESS |
+		MHI_PM_LD_ERR_FATAL_DETECT
+	},
+	{
+		MHI_PM_FW_DL_ERR,
+		MHI_PM_FW_DL_ERR | MHI_PM_SYS_ERR_DETECT |
+		MHI_PM_SHUTDOWN_PROCESS | MHI_PM_LD_ERR_FATAL_DETECT
+	},
+	/* L1 States */
+	{
+		MHI_PM_SYS_ERR_DETECT,
+		MHI_PM_SYS_ERR_PROCESS | MHI_PM_SHUTDOWN_PROCESS |
+		MHI_PM_LD_ERR_FATAL_DETECT
+	},
+	{
+		MHI_PM_SYS_ERR_PROCESS,
+		MHI_PM_POR | MHI_PM_SHUTDOWN_PROCESS |
+		MHI_PM_LD_ERR_FATAL_DETECT
+	},
+	/* L2 States */
+	{
+		MHI_PM_SHUTDOWN_PROCESS,
+		MHI_PM_DISABLE | MHI_PM_LD_ERR_FATAL_DETECT
+	},
+	/* L3 States */
+	{
+		MHI_PM_LD_ERR_FATAL_DETECT,
+		MHI_PM_LD_ERR_FATAL_DETECT | MHI_PM_SHUTDOWN_PROCESS
+	},
+};
+
+enum mhi_pm_state __must_check mhi_tryset_pm_state(struct mhi_controller *mhi_cntrl,
+						   enum mhi_pm_state state)
+{
+	unsigned long cur_state = mhi_cntrl->pm_state;
+	int index = find_last_bit(&cur_state, 32);
+
+	if (unlikely(index >= ARRAY_SIZE(dev_state_transitions)))
+		return cur_state;
+
+	if (unlikely(dev_state_transitions[index].from_state != cur_state))
+		return cur_state;
+
+	if (unlikely(!(dev_state_transitions[index].to_states & state)))
+		return cur_state;
+
+	mhi_cntrl->pm_state = state;
+	return mhi_cntrl->pm_state;
+}
+
+void mhi_set_mhi_state(struct mhi_controller *mhi_cntrl, enum mhi_state state)
+{
+	if (state == MHI_STATE_RESET) {
+		mhi_write_reg_field(mhi_cntrl, mhi_cntrl->regs, MHICTRL,
+				    MHICTRL_RESET_MASK, MHICTRL_RESET_SHIFT, 1);
+	} else {
+		mhi_write_reg_field(mhi_cntrl, mhi_cntrl->regs, MHICTRL,
+				    MHICTRL_MHISTATE_MASK,
+				    MHICTRL_MHISTATE_SHIFT, state);
+	}
+}
+
+/* NOP for backward compatibility, host allowed to ring DB in M2 state */
+static void mhi_toggle_dev_wake_nop(struct mhi_controller *mhi_cntrl)
+{
+}
+
+static void mhi_toggle_dev_wake(struct mhi_controller *mhi_cntrl)
+{
+	mhi_cntrl->wake_get(mhi_cntrl, false);
+	mhi_cntrl->wake_put(mhi_cntrl, true);
+}
+
+/* Handle device ready state transition */
+int mhi_ready_state_transition(struct mhi_controller *mhi_cntrl)
+{
+	void __iomem *base = mhi_cntrl->regs;
+	struct mhi_event *mhi_event;
+	enum mhi_pm_state cur_state;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	u32 reset = 1, ready = 0;
+	int ret, i;
+
+	/* Wait for RESET to be cleared and READY bit to be set by the device */
+	wait_event_timeout(mhi_cntrl->state_event,
+			   MHI_PM_IN_FATAL_STATE(mhi_cntrl->pm_state) ||
+			   mhi_read_reg_field(mhi_cntrl, base, MHICTRL,
+					      MHICTRL_RESET_MASK,
+					      MHICTRL_RESET_SHIFT, &reset) ||
+			   mhi_read_reg_field(mhi_cntrl, base, MHISTATUS,
+					      MHISTATUS_READY_MASK,
+					      MHISTATUS_READY_SHIFT, &ready) ||
+			   (!reset && ready),
+			   msecs_to_jiffies(mhi_cntrl->timeout_ms));
+
+	/* Check if device entered error state */
+	if (MHI_PM_IN_FATAL_STATE(mhi_cntrl->pm_state)) {
+		dev_err(dev, "Device link is not accessible\n");
+		return -EIO;
+	}
+
+	/* Timeout if device did not transition to ready state */
+	if (reset || !ready) {
+		dev_err(dev, "Device Ready timeout\n");
+		return -ETIMEDOUT;
+	}
+
+	dev_dbg(dev, "Device in READY State\n");
+	write_lock_irq(&mhi_cntrl->pm_lock);
+	cur_state = mhi_tryset_pm_state(mhi_cntrl, MHI_PM_POR);
+	mhi_cntrl->dev_state = MHI_STATE_READY;
+	write_unlock_irq(&mhi_cntrl->pm_lock);
+
+	if (cur_state != MHI_PM_POR) {
+		dev_err(dev, "Error moving to state %s from %s\n",
+			to_mhi_pm_state_str(MHI_PM_POR),
+			to_mhi_pm_state_str(cur_state));
+		return -EIO;
+	}
+
+	read_lock_bh(&mhi_cntrl->pm_lock);
+	if (!MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state)) {
+		dev_err(dev, "Device registers not accessible\n");
+		goto error_mmio;
+	}
+
+	/* Configure MMIO registers */
+	ret = mhi_init_mmio(mhi_cntrl);
+	if (ret) {
+		dev_err(dev, "Error configuring MMIO registers\n");
+		goto error_mmio;
+	}
+
+	/* Add elements to all SW event rings */
+	mhi_event = mhi_cntrl->mhi_event;
+	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
+		struct mhi_ring *ring = &mhi_event->ring;
+
+		/* Skip if this is an offload or HW event */
+		if (mhi_event->offload_ev || mhi_event->hw_ring)
+			continue;
+
+		ring->wp = ring->base + ring->len - ring->el_size;
+		*ring->ctxt_wp = ring->iommu_base + ring->len - ring->el_size;
+		/* Update all cores */
+		smp_wmb();
+
+		/* Ring the event ring db */
+		spin_lock_irq(&mhi_event->lock);
+		mhi_ring_er_db(mhi_event);
+		spin_unlock_irq(&mhi_event->lock);
+	}
+
+	/* Set MHI to M0 state */
+	mhi_set_mhi_state(mhi_cntrl, MHI_STATE_M0);
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+
+	return 0;
+
+error_mmio:
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+
+	return -EIO;
+}
+
+int mhi_pm_m0_transition(struct mhi_controller *mhi_cntrl)
+{
+	enum mhi_pm_state cur_state;
+	struct mhi_chan *mhi_chan;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	int i;
+
+	write_lock_irq(&mhi_cntrl->pm_lock);
+	mhi_cntrl->dev_state = MHI_STATE_M0;
+	cur_state = mhi_tryset_pm_state(mhi_cntrl, MHI_PM_M0);
+	write_unlock_irq(&mhi_cntrl->pm_lock);
+	if (unlikely(cur_state != MHI_PM_M0)) {
+		dev_err(dev, "Unable to transition to M0 state\n");
+		return -EIO;
+	}
+	mhi_cntrl->M0++;
+
+	/* Wake up the device */
+	read_lock_bh(&mhi_cntrl->pm_lock);
+	mhi_cntrl->wake_get(mhi_cntrl, true);
+
+	/* Ring all event rings and CMD ring only if we're in mission mode */
+	if (MHI_IN_MISSION_MODE(mhi_cntrl->ee)) {
+		struct mhi_event *mhi_event = mhi_cntrl->mhi_event;
+		struct mhi_cmd *mhi_cmd =
+			&mhi_cntrl->mhi_cmd[PRIMARY_CMD_RING];
+
+		for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
+			if (mhi_event->offload_ev)
+				continue;
+
+			spin_lock_irq(&mhi_event->lock);
+			mhi_ring_er_db(mhi_event);
+			spin_unlock_irq(&mhi_event->lock);
+		}
+
+		/* Only ring primary cmd ring if ring is not empty */
+		spin_lock_irq(&mhi_cmd->lock);
+		if (mhi_cmd->ring.rp != mhi_cmd->ring.wp)
+			mhi_ring_cmd_db(mhi_cntrl, mhi_cmd);
+		spin_unlock_irq(&mhi_cmd->lock);
+	}
+
+	/* Ring channel DB registers */
+	mhi_chan = mhi_cntrl->mhi_chan;
+	for (i = 0; i < mhi_cntrl->max_chan; i++, mhi_chan++) {
+		struct mhi_ring *tre_ring = &mhi_chan->tre_ring;
+
+		if (mhi_chan->db_cfg.reset_req) {
+			write_lock_irq(&mhi_chan->lock);
+			mhi_chan->db_cfg.db_mode = true;
+			write_unlock_irq(&mhi_chan->lock);
+		}
+
+		read_lock_irq(&mhi_chan->lock);
+
+		/* Only ring DB if ring is not empty */
+		if (tre_ring->base && tre_ring->wp  != tre_ring->rp &&
+		    mhi_chan->ch_state == MHI_CH_STATE_ENABLED)
+			mhi_ring_chan_db(mhi_cntrl, mhi_chan);
+		read_unlock_irq(&mhi_chan->lock);
+	}
+
+	mhi_cntrl->wake_put(mhi_cntrl, false);
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+	wake_up_all(&mhi_cntrl->state_event);
+
+	return 0;
+}
+
+/*
+ * After receiving the MHI state change event from the device indicating the
+ * transition to M1 state, the host can transition the device to M2 state
+ * for keeping it in low power state.
+ */
+void mhi_pm_m1_transition(struct mhi_controller *mhi_cntrl)
+{
+	enum mhi_pm_state state;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+
+	write_lock_irq(&mhi_cntrl->pm_lock);
+	state = mhi_tryset_pm_state(mhi_cntrl, MHI_PM_M2);
+	if (state == MHI_PM_M2) {
+		mhi_set_mhi_state(mhi_cntrl, MHI_STATE_M2);
+		mhi_cntrl->dev_state = MHI_STATE_M2;
+
+		write_unlock_irq(&mhi_cntrl->pm_lock);
+
+		mhi_cntrl->M2++;
+		wake_up_all(&mhi_cntrl->state_event);
+
+		/* If there are any pending resources, exit M2 immediately */
+		if (unlikely(atomic_read(&mhi_cntrl->pending_pkts) ||
+			     atomic_read(&mhi_cntrl->dev_wake))) {
+			dev_dbg(dev,
+				"Exiting M2, pending_pkts: %d dev_wake: %d\n",
+				atomic_read(&mhi_cntrl->pending_pkts),
+				atomic_read(&mhi_cntrl->dev_wake));
+			read_lock_bh(&mhi_cntrl->pm_lock);
+			mhi_cntrl->wake_get(mhi_cntrl, true);
+			mhi_cntrl->wake_put(mhi_cntrl, true);
+			read_unlock_bh(&mhi_cntrl->pm_lock);
+		} else {
+			mhi_cntrl->status_cb(mhi_cntrl, MHI_CB_IDLE);
+		}
+	} else {
+		write_unlock_irq(&mhi_cntrl->pm_lock);
+	}
+}
+
+/* MHI M3 completion handler */
+int mhi_pm_m3_transition(struct mhi_controller *mhi_cntrl)
+{
+	enum mhi_pm_state state;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+
+	write_lock_irq(&mhi_cntrl->pm_lock);
+	mhi_cntrl->dev_state = MHI_STATE_M3;
+	state = mhi_tryset_pm_state(mhi_cntrl, MHI_PM_M3);
+	write_unlock_irq(&mhi_cntrl->pm_lock);
+	if (state != MHI_PM_M3) {
+		dev_err(dev, "Unable to transition to M3 state\n");
+		return -EIO;
+	}
+
+	mhi_cntrl->M3++;
+	wake_up_all(&mhi_cntrl->state_event);
+
+	return 0;
+}
+
+/* Handle device Mission Mode transition */
+static int mhi_pm_mission_mode_transition(struct mhi_controller *mhi_cntrl)
+{
+	struct mhi_event *mhi_event;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	enum mhi_ee_type current_ee = mhi_cntrl->ee;
+	int i, ret;
+
+	dev_dbg(dev, "Processing Mission Mode transition\n");
+
+	write_lock_irq(&mhi_cntrl->pm_lock);
+	if (MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state))
+		mhi_cntrl->ee = mhi_get_exec_env(mhi_cntrl);
+	write_unlock_irq(&mhi_cntrl->pm_lock);
+
+	if (!MHI_IN_MISSION_MODE(mhi_cntrl->ee))
+		return -EIO;
+
+	wake_up_all(&mhi_cntrl->state_event);
+
+	device_for_each_child(&mhi_cntrl->mhi_dev->dev, &current_ee,
+			      mhi_destroy_device);
+	mhi_cntrl->status_cb(mhi_cntrl, MHI_CB_EE_MISSION_MODE);
+
+	/* Force MHI to be in M0 state before continuing */
+	ret = __mhi_device_get_sync(mhi_cntrl);
+	if (ret)
+		return ret;
+
+	read_lock_bh(&mhi_cntrl->pm_lock);
+
+	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
+		ret = -EIO;
+		goto error_mission_mode;
+	}
+
+	/* Add elements to all HW event rings */
+	mhi_event = mhi_cntrl->mhi_event;
+	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
+		struct mhi_ring *ring = &mhi_event->ring;
+
+		if (mhi_event->offload_ev || !mhi_event->hw_ring)
+			continue;
+
+		ring->wp = ring->base + ring->len - ring->el_size;
+		*ring->ctxt_wp = ring->iommu_base + ring->len - ring->el_size;
+		/* Update to all cores */
+		smp_wmb();
+
+		spin_lock_irq(&mhi_event->lock);
+		if (MHI_DB_ACCESS_VALID(mhi_cntrl))
+			mhi_ring_er_db(mhi_event);
+		spin_unlock_irq(&mhi_event->lock);
+	}
+
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+
+	/*
+	 * The MHI devices are only created when the client device switches its
+	 * Execution Environment (EE) to either SBL or AMSS states
+	 */
+	mhi_create_devices(mhi_cntrl);
+
+	read_lock_bh(&mhi_cntrl->pm_lock);
+
+error_mission_mode:
+	mhi_cntrl->wake_put(mhi_cntrl, false);
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+
+	return ret;
+}
+
+/* Handle SYS_ERR and Shutdown transitions */
+static void mhi_pm_disable_transition(struct mhi_controller *mhi_cntrl,
+				      enum mhi_pm_state transition_state)
+{
+	enum mhi_pm_state cur_state, prev_state;
+	struct mhi_event *mhi_event;
+	struct mhi_cmd_ctxt *cmd_ctxt;
+	struct mhi_cmd *mhi_cmd;
+	struct mhi_event_ctxt *er_ctxt;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	int ret, i;
+
+	dev_dbg(dev, "Transitioning from PM state: %s to: %s\n",
+		to_mhi_pm_state_str(mhi_cntrl->pm_state),
+		to_mhi_pm_state_str(transition_state));
+
+	/* We must notify MHI control driver so it can clean up first */
+	if (transition_state == MHI_PM_SYS_ERR_PROCESS)
+		mhi_cntrl->status_cb(mhi_cntrl, MHI_CB_SYS_ERROR);
+
+	mutex_lock(&mhi_cntrl->pm_mutex);
+	write_lock_irq(&mhi_cntrl->pm_lock);
+	prev_state = mhi_cntrl->pm_state;
+	cur_state = mhi_tryset_pm_state(mhi_cntrl, transition_state);
+	if (cur_state == transition_state) {
+		mhi_cntrl->ee = MHI_EE_DISABLE_TRANSITION;
+		mhi_cntrl->dev_state = MHI_STATE_RESET;
+	}
+	write_unlock_irq(&mhi_cntrl->pm_lock);
+
+	/* Wake up threads waiting for state transition */
+	wake_up_all(&mhi_cntrl->state_event);
+
+	if (cur_state != transition_state) {
+		dev_err(dev, "Failed to transition to state: %s from: %s\n",
+			to_mhi_pm_state_str(transition_state),
+			to_mhi_pm_state_str(cur_state));
+		mutex_unlock(&mhi_cntrl->pm_mutex);
+		return;
+	}
+
+	/* Trigger MHI RESET so that the device will not access host memory */
+	if (MHI_REG_ACCESS_VALID(prev_state)) {
+		u32 in_reset = -1;
+		unsigned long timeout = msecs_to_jiffies(mhi_cntrl->timeout_ms);
+
+		dev_dbg(dev, "Triggering MHI Reset in device\n");
+		mhi_set_mhi_state(mhi_cntrl, MHI_STATE_RESET);
+
+		/* Wait for the reset bit to be cleared by the device */
+		ret = wait_event_timeout(mhi_cntrl->state_event,
+					 mhi_read_reg_field(mhi_cntrl,
+							    mhi_cntrl->regs,
+							    MHICTRL,
+							    MHICTRL_RESET_MASK,
+							    MHICTRL_RESET_SHIFT,
+							    &in_reset) ||
+					!in_reset, timeout);
+		if ((!ret || in_reset) && cur_state == MHI_PM_SYS_ERR_PROCESS) {
+			dev_err(dev, "Device failed to exit MHI Reset state\n");
+			mutex_unlock(&mhi_cntrl->pm_mutex);
+			return;
+		}
+
+		/*
+		 * Device will clear BHI_INTVEC as a part of RESET processing,
+		 * hence re-program it
+		 */
+		mhi_write_reg(mhi_cntrl, mhi_cntrl->bhi, BHI_INTVEC, 0);
+	}
+
+	dev_dbg(dev,
+		 "Waiting for all pending event ring processing to complete\n");
+	mhi_event = mhi_cntrl->mhi_event;
+	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
+		if (mhi_event->offload_ev)
+			continue;
+		tasklet_kill(&mhi_event->task);
+	}
+
+	/* Release lock and wait for all pending threads to complete */
+	mutex_unlock(&mhi_cntrl->pm_mutex);
+	dev_dbg(dev, "Waiting for all pending threads to complete\n");
+	wake_up_all(&mhi_cntrl->state_event);
+
+	dev_dbg(dev, "Reset all active channels and remove MHI devices\n");
+	device_for_each_child(mhi_cntrl->cntrl_dev, NULL, mhi_destroy_device);
+
+	mutex_lock(&mhi_cntrl->pm_mutex);
+
+	WARN_ON(atomic_read(&mhi_cntrl->dev_wake));
+	WARN_ON(atomic_read(&mhi_cntrl->pending_pkts));
+
+	/* Reset the ev rings and cmd rings */
+	dev_dbg(dev, "Resetting EV CTXT and CMD CTXT\n");
+	mhi_cmd = mhi_cntrl->mhi_cmd;
+	cmd_ctxt = mhi_cntrl->mhi_ctxt->cmd_ctxt;
+	for (i = 0; i < NR_OF_CMD_RINGS; i++, mhi_cmd++, cmd_ctxt++) {
+		struct mhi_ring *ring = &mhi_cmd->ring;
+
+		ring->rp = ring->base;
+		ring->wp = ring->base;
+		cmd_ctxt->rp = cmd_ctxt->rbase;
+		cmd_ctxt->wp = cmd_ctxt->rbase;
+	}
+
+	mhi_event = mhi_cntrl->mhi_event;
+	er_ctxt = mhi_cntrl->mhi_ctxt->er_ctxt;
+	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, er_ctxt++,
+		     mhi_event++) {
+		struct mhi_ring *ring = &mhi_event->ring;
+
+		/* Skip offload events */
+		if (mhi_event->offload_ev)
+			continue;
+
+		ring->rp = ring->base;
+		ring->wp = ring->base;
+		er_ctxt->rp = er_ctxt->rbase;
+		er_ctxt->wp = er_ctxt->rbase;
+	}
+
+	if (cur_state == MHI_PM_SYS_ERR_PROCESS) {
+		mhi_ready_state_transition(mhi_cntrl);
+	} else {
+		/* Move to disable state */
+		write_lock_irq(&mhi_cntrl->pm_lock);
+		cur_state = mhi_tryset_pm_state(mhi_cntrl, MHI_PM_DISABLE);
+		write_unlock_irq(&mhi_cntrl->pm_lock);
+		if (unlikely(cur_state != MHI_PM_DISABLE))
+			dev_err(dev, "Error moving from PM state: %s to: %s\n",
+				to_mhi_pm_state_str(cur_state),
+				to_mhi_pm_state_str(MHI_PM_DISABLE));
+	}
+
+	dev_dbg(dev, "Exiting with PM state: %s, MHI state: %s\n",
+		to_mhi_pm_state_str(mhi_cntrl->pm_state),
+		TO_MHI_STATE_STR(mhi_cntrl->dev_state));
+
+	mutex_unlock(&mhi_cntrl->pm_mutex);
+}
+
+/* Queue a new work item and schedule work */
+int mhi_queue_state_transition(struct mhi_controller *mhi_cntrl,
+			       enum dev_st_transition state)
+{
+	struct state_transition *item = kmalloc(sizeof(*item), GFP_ATOMIC);
+	unsigned long flags;
+
+	if (!item)
+		return -ENOMEM;
+
+	item->state = state;
+	spin_lock_irqsave(&mhi_cntrl->transition_lock, flags);
+	list_add_tail(&item->node, &mhi_cntrl->transition_list);
+	spin_unlock_irqrestore(&mhi_cntrl->transition_lock, flags);
+
+	schedule_work(&mhi_cntrl->st_worker);
+
+	return 0;
+}
+
+/* SYS_ERR worker */
+void mhi_pm_sys_err_handler(struct mhi_controller *mhi_cntrl)
+{
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+
+	/* skip if controller supports RDDM */
+	if (mhi_cntrl->rddm_image) {
+		dev_dbg(dev, "Controller supports RDDM, skip SYS_ERROR\n");
+		return;
+	}
+
+	mhi_queue_state_transition(mhi_cntrl, DEV_ST_TRANSITION_SYS_ERR);
+}
+
+/* Device State Transition worker */
+void mhi_pm_st_worker(struct work_struct *work)
+{
+	struct state_transition *itr, *tmp;
+	LIST_HEAD(head);
+	struct mhi_controller *mhi_cntrl = container_of(work,
+							struct mhi_controller,
+							st_worker);
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+
+	spin_lock_irq(&mhi_cntrl->transition_lock);
+	list_splice_tail_init(&mhi_cntrl->transition_list, &head);
+	spin_unlock_irq(&mhi_cntrl->transition_lock);
+
+	list_for_each_entry_safe(itr, tmp, &head, node) {
+		list_del(&itr->node);
+		dev_dbg(dev, "Handling state transition: %s\n",
+			TO_DEV_STATE_TRANS_STR(itr->state));
+
+		switch (itr->state) {
+		case DEV_ST_TRANSITION_PBL:
+			write_lock_irq(&mhi_cntrl->pm_lock);
+			if (MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state))
+				mhi_cntrl->ee = mhi_get_exec_env(mhi_cntrl);
+			write_unlock_irq(&mhi_cntrl->pm_lock);
+			if (MHI_IN_PBL(mhi_cntrl->ee))
+				mhi_fw_load_handler(mhi_cntrl);
+			break;
+		case DEV_ST_TRANSITION_SBL:
+			write_lock_irq(&mhi_cntrl->pm_lock);
+			mhi_cntrl->ee = MHI_EE_SBL;
+			write_unlock_irq(&mhi_cntrl->pm_lock);
+			/*
+			 * The MHI devices are only created when the client
+			 * device switches its Execution Environment (EE) to
+			 * either SBL or AMSS states
+			 */
+			mhi_create_devices(mhi_cntrl);
+			break;
+		case DEV_ST_TRANSITION_MISSION_MODE:
+			mhi_pm_mission_mode_transition(mhi_cntrl);
+			break;
+		case DEV_ST_TRANSITION_READY:
+			mhi_ready_state_transition(mhi_cntrl);
+			break;
+		case DEV_ST_TRANSITION_SYS_ERR:
+			mhi_pm_disable_transition
+				(mhi_cntrl, MHI_PM_SYS_ERR_PROCESS);
+			break;
+		case DEV_ST_TRANSITION_DISABLE:
+			mhi_pm_disable_transition
+				(mhi_cntrl, MHI_PM_SHUTDOWN_PROCESS);
+			break;
+		default:
+			break;
+		}
+		kfree(itr);
+	}
+}
+
+int mhi_pm_suspend(struct mhi_controller *mhi_cntrl)
+{
+	struct mhi_chan *itr, *tmp;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	enum mhi_pm_state new_state;
+	int ret;
+
+	if (mhi_cntrl->pm_state == MHI_PM_DISABLE)
+		return -EINVAL;
+
+	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state))
+		return -EIO;
+
+	/* Return busy if there are any pending resources */
+	if (atomic_read(&mhi_cntrl->dev_wake) ||
+	    atomic_read(&mhi_cntrl->pending_pkts))
+		return -EBUSY;
+
+	/* Take MHI out of M2 state */
+	read_lock_bh(&mhi_cntrl->pm_lock);
+	mhi_cntrl->wake_get(mhi_cntrl, false);
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+
+	ret = wait_event_timeout(mhi_cntrl->state_event,
+				 mhi_cntrl->dev_state == MHI_STATE_M0 ||
+				 mhi_cntrl->dev_state == MHI_STATE_M1 ||
+				 MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state),
+				 msecs_to_jiffies(mhi_cntrl->timeout_ms));
+
+	read_lock_bh(&mhi_cntrl->pm_lock);
+	mhi_cntrl->wake_put(mhi_cntrl, false);
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+
+	if (!ret || MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
+		dev_err(dev,
+			"Could not enter M0/M1 state");
+		return -EIO;
+	}
+
+	write_lock_irq(&mhi_cntrl->pm_lock);
+
+	if (atomic_read(&mhi_cntrl->dev_wake) ||
+	    atomic_read(&mhi_cntrl->pending_pkts)) {
+		write_unlock_irq(&mhi_cntrl->pm_lock);
+		return -EBUSY;
+	}
+
+	dev_info(dev, "Allowing M3 transition\n");
+	new_state = mhi_tryset_pm_state(mhi_cntrl, MHI_PM_M3_ENTER);
+	if (new_state != MHI_PM_M3_ENTER) {
+		write_unlock_irq(&mhi_cntrl->pm_lock);
+		dev_err(dev,
+			"Error setting to PM state: %s from: %s\n",
+			to_mhi_pm_state_str(MHI_PM_M3_ENTER),
+			to_mhi_pm_state_str(mhi_cntrl->pm_state));
+		return -EIO;
+	}
+
+	/* Set MHI to M3 and wait for completion */
+	mhi_set_mhi_state(mhi_cntrl, MHI_STATE_M3);
+	write_unlock_irq(&mhi_cntrl->pm_lock);
+	dev_info(dev, "Wait for M3 completion\n");
+
+	ret = wait_event_timeout(mhi_cntrl->state_event,
+				 mhi_cntrl->dev_state == MHI_STATE_M3 ||
+				 MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state),
+				 msecs_to_jiffies(mhi_cntrl->timeout_ms));
+
+	if (!ret || MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
+		dev_err(dev,
+			"Did not enter M3 state, MHI state: %s, PM state: %s\n",
+			TO_MHI_STATE_STR(mhi_cntrl->dev_state),
+			to_mhi_pm_state_str(mhi_cntrl->pm_state));
+		return -EIO;
+	}
+
+	/* Notify clients about entering LPM */
+	list_for_each_entry_safe(itr, tmp, &mhi_cntrl->lpm_chans, node) {
+		mutex_lock(&itr->mutex);
+		if (itr->mhi_dev)
+			mhi_notify(itr->mhi_dev, MHI_CB_LPM_ENTER);
+		mutex_unlock(&itr->mutex);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mhi_pm_suspend);
+
+int mhi_pm_resume(struct mhi_controller *mhi_cntrl)
+{
+	struct mhi_chan *itr, *tmp;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	enum mhi_pm_state cur_state;
+	int ret;
+
+	dev_info(dev, "Entered with PM state: %s, MHI state: %s\n",
+		 to_mhi_pm_state_str(mhi_cntrl->pm_state),
+		 TO_MHI_STATE_STR(mhi_cntrl->dev_state));
+
+	if (mhi_cntrl->pm_state == MHI_PM_DISABLE)
+		return 0;
+
+	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state))
+		return -EIO;
+
+	/* Notify clients about exiting LPM */
+	list_for_each_entry_safe(itr, tmp, &mhi_cntrl->lpm_chans, node) {
+		mutex_lock(&itr->mutex);
+		if (itr->mhi_dev)
+			mhi_notify(itr->mhi_dev, MHI_CB_LPM_EXIT);
+		mutex_unlock(&itr->mutex);
+	}
+
+	write_lock_irq(&mhi_cntrl->pm_lock);
+	cur_state = mhi_tryset_pm_state(mhi_cntrl, MHI_PM_M3_EXIT);
+	if (cur_state != MHI_PM_M3_EXIT) {
+		write_unlock_irq(&mhi_cntrl->pm_lock);
+		dev_info(dev,
+			 "Error setting to PM state: %s from: %s\n",
+			 to_mhi_pm_state_str(MHI_PM_M3_EXIT),
+			 to_mhi_pm_state_str(mhi_cntrl->pm_state));
+		return -EIO;
+	}
+
+	/* Set MHI to M0 and wait for completion */
+	mhi_set_mhi_state(mhi_cntrl, MHI_STATE_M0);
+	write_unlock_irq(&mhi_cntrl->pm_lock);
+
+	ret = wait_event_timeout(mhi_cntrl->state_event,
+				 mhi_cntrl->dev_state == MHI_STATE_M0 ||
+				 mhi_cntrl->dev_state == MHI_STATE_M2 ||
+				 MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state),
+				 msecs_to_jiffies(mhi_cntrl->timeout_ms));
+
+	if (!ret || MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
+		dev_err(dev,
+			"Did not enter M0 state, MHI state: %s, PM state: %s\n",
+			TO_MHI_STATE_STR(mhi_cntrl->dev_state),
+			to_mhi_pm_state_str(mhi_cntrl->pm_state));
+		return -EIO;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mhi_pm_resume);
+
+int __mhi_device_get_sync(struct mhi_controller *mhi_cntrl)
+{
+	int ret;
+
+	/* Wake up the device */
+	read_lock_bh(&mhi_cntrl->pm_lock);
+	mhi_cntrl->wake_get(mhi_cntrl, true);
+	if (MHI_PM_IN_SUSPEND_STATE(mhi_cntrl->pm_state))
+		mhi_trigger_resume(mhi_cntrl);
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+
+	ret = wait_event_timeout(mhi_cntrl->state_event,
+				 mhi_cntrl->pm_state == MHI_PM_M0 ||
+				 MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state),
+				 msecs_to_jiffies(mhi_cntrl->timeout_ms));
+
+	if (!ret || MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
+		read_lock_bh(&mhi_cntrl->pm_lock);
+		mhi_cntrl->wake_put(mhi_cntrl, false);
+		read_unlock_bh(&mhi_cntrl->pm_lock);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/* Assert device wake db */
+static void mhi_assert_dev_wake(struct mhi_controller *mhi_cntrl, bool force)
+{
+	unsigned long flags;
+
+	/*
+	 * If force flag is set, then increment the wake count value and
+	 * ring wake db
+	 */
+	if (unlikely(force)) {
+		spin_lock_irqsave(&mhi_cntrl->wlock, flags);
+		atomic_inc(&mhi_cntrl->dev_wake);
+		if (MHI_WAKE_DB_FORCE_SET_VALID(mhi_cntrl->pm_state) &&
+		    !mhi_cntrl->wake_set) {
+			mhi_write_db(mhi_cntrl, mhi_cntrl->wake_db, 1);
+			mhi_cntrl->wake_set = true;
+		}
+		spin_unlock_irqrestore(&mhi_cntrl->wlock, flags);
+	} else {
+		/*
+		 * If resources are already requested, then just increment
+		 * the wake count value and return
+		 */
+		if (likely(atomic_add_unless(&mhi_cntrl->dev_wake, 1, 0)))
+			return;
+
+		spin_lock_irqsave(&mhi_cntrl->wlock, flags);
+		if ((atomic_inc_return(&mhi_cntrl->dev_wake) == 1) &&
+		    MHI_WAKE_DB_SET_VALID(mhi_cntrl->pm_state) &&
+		    !mhi_cntrl->wake_set) {
+			mhi_write_db(mhi_cntrl, mhi_cntrl->wake_db, 1);
+			mhi_cntrl->wake_set = true;
+		}
+		spin_unlock_irqrestore(&mhi_cntrl->wlock, flags);
+	}
+}
+
+/* De-assert device wake db */
+static void mhi_deassert_dev_wake(struct mhi_controller *mhi_cntrl,
+				  bool override)
+{
+	unsigned long flags;
+
+	/*
+	 * Only continue if there is a single resource, else just decrement
+	 * and return
+	 */
+	if (likely(atomic_add_unless(&mhi_cntrl->dev_wake, -1, 1)))
+		return;
+
+	spin_lock_irqsave(&mhi_cntrl->wlock, flags);
+	if ((atomic_dec_return(&mhi_cntrl->dev_wake) == 0) &&
+	    MHI_WAKE_DB_CLEAR_VALID(mhi_cntrl->pm_state) && !override &&
+	    mhi_cntrl->wake_set) {
+		mhi_write_db(mhi_cntrl, mhi_cntrl->wake_db, 0);
+		mhi_cntrl->wake_set = false;
+	}
+	spin_unlock_irqrestore(&mhi_cntrl->wlock, flags);
+}
+
+int mhi_async_power_up(struct mhi_controller *mhi_cntrl)
+{
+	enum mhi_state state;
+	enum mhi_ee_type current_ee;
+	enum dev_st_transition next_state;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	u32 val;
+	int ret;
+
+	dev_info(dev, "Requested to power ON\n");
+
+	if (mhi_cntrl->nr_irqs < 1)
+		return -EINVAL;
+
+	/* Supply default wake routines if not provided by controller driver */
+	if (!mhi_cntrl->wake_get || !mhi_cntrl->wake_put ||
+	    !mhi_cntrl->wake_toggle) {
+		mhi_cntrl->wake_get = mhi_assert_dev_wake;
+		mhi_cntrl->wake_put = mhi_deassert_dev_wake;
+		mhi_cntrl->wake_toggle = (mhi_cntrl->db_access & MHI_PM_M2) ?
+			mhi_toggle_dev_wake_nop : mhi_toggle_dev_wake;
+	}
+
+	mutex_lock(&mhi_cntrl->pm_mutex);
+	mhi_cntrl->pm_state = MHI_PM_DISABLE;
+
+	if (!mhi_cntrl->pre_init) {
+		/* Setup device context */
+		ret = mhi_init_dev_ctxt(mhi_cntrl);
+		if (ret)
+			goto error_dev_ctxt;
+	}
+
+	ret = mhi_init_irq_setup(mhi_cntrl);
+	if (ret)
+		goto error_setup_irq;
+
+	/* Setup BHI offset & INTVEC */
+	write_lock_irq(&mhi_cntrl->pm_lock);
+	ret = mhi_read_reg(mhi_cntrl, mhi_cntrl->regs, BHIOFF, &val);
+	if (ret) {
+		write_unlock_irq(&mhi_cntrl->pm_lock);
+		goto error_bhi_offset;
+	}
+
+	mhi_cntrl->bhi = mhi_cntrl->regs + val;
+
+	/* Setup BHIE offset */
+	if (mhi_cntrl->fbc_download) {
+		ret = mhi_read_reg(mhi_cntrl, mhi_cntrl->regs, BHIEOFF, &val);
+		if (ret) {
+			write_unlock_irq(&mhi_cntrl->pm_lock);
+			dev_err(dev, "Error reading BHIE offset\n");
+			goto error_bhi_offset;
+		}
+
+		mhi_cntrl->bhie = mhi_cntrl->regs + val;
+	}
+
+	mhi_write_reg(mhi_cntrl, mhi_cntrl->bhi, BHI_INTVEC, 0);
+	mhi_cntrl->pm_state = MHI_PM_POR;
+	mhi_cntrl->ee = MHI_EE_MAX;
+	current_ee = mhi_get_exec_env(mhi_cntrl);
+	write_unlock_irq(&mhi_cntrl->pm_lock);
+
+	/* Confirm that the device is in valid exec env */
+	if (!MHI_IN_PBL(current_ee) && current_ee != MHI_EE_AMSS) {
+		dev_err(dev, "Not a valid EE for power on\n");
+		ret = -EIO;
+		goto error_bhi_offset;
+	}
+
+	state = mhi_get_mhi_state(mhi_cntrl);
+	if (state == MHI_STATE_SYS_ERR) {
+		mhi_set_mhi_state(mhi_cntrl, MHI_STATE_RESET);
+		ret = wait_event_timeout(mhi_cntrl->state_event,
+				MHI_PM_IN_FATAL_STATE(mhi_cntrl->pm_state) ||
+					mhi_read_reg_field(mhi_cntrl,
+							   mhi_cntrl->regs,
+							   MHICTRL,
+							   MHICTRL_RESET_MASK,
+							   MHICTRL_RESET_SHIFT,
+							   &val) ||
+					!val,
+				msecs_to_jiffies(mhi_cntrl->timeout_ms));
+		if (!ret) {
+			ret = -EIO;
+			dev_info(dev, "Failed to reset MHI due to syserr state\n");
+			goto error_bhi_offset;
+		}
+
+		/*
+		 * device cleares INTVEC as part of RESET processing,
+		 * re-program it
+		 */
+		mhi_write_reg(mhi_cntrl, mhi_cntrl->bhi, BHI_INTVEC, 0);
+	}
+
+	/* Transition to next state */
+	next_state = MHI_IN_PBL(current_ee) ?
+		DEV_ST_TRANSITION_PBL : DEV_ST_TRANSITION_READY;
+
+	mhi_queue_state_transition(mhi_cntrl, next_state);
+
+	mutex_unlock(&mhi_cntrl->pm_mutex);
+
+	dev_info(dev, "Power on setup success\n");
+
+	return 0;
+
+error_bhi_offset:
+	mhi_deinit_free_irq(mhi_cntrl);
+
+error_setup_irq:
+	if (!mhi_cntrl->pre_init)
+		mhi_deinit_dev_ctxt(mhi_cntrl);
+
+error_dev_ctxt:
+	mutex_unlock(&mhi_cntrl->pm_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mhi_async_power_up);
+
+void mhi_power_down(struct mhi_controller *mhi_cntrl, bool graceful)
+{
+	enum mhi_pm_state cur_state;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+
+	/* If it's not a graceful shutdown, force MHI to linkdown state */
+	if (!graceful) {
+		mutex_lock(&mhi_cntrl->pm_mutex);
+		write_lock_irq(&mhi_cntrl->pm_lock);
+		cur_state = mhi_tryset_pm_state(mhi_cntrl,
+						MHI_PM_LD_ERR_FATAL_DETECT);
+		write_unlock_irq(&mhi_cntrl->pm_lock);
+		mutex_unlock(&mhi_cntrl->pm_mutex);
+		if (cur_state != MHI_PM_LD_ERR_FATAL_DETECT)
+			dev_dbg(dev, "Failed to move to state: %s from: %s\n",
+				to_mhi_pm_state_str(MHI_PM_LD_ERR_FATAL_DETECT),
+				to_mhi_pm_state_str(mhi_cntrl->pm_state));
+	}
+
+	mhi_queue_state_transition(mhi_cntrl, DEV_ST_TRANSITION_DISABLE);
+
+	/* Wait for shutdown to complete */
+	flush_work(&mhi_cntrl->st_worker);
+
+	mhi_deinit_free_irq(mhi_cntrl);
+
+	if (!mhi_cntrl->pre_init) {
+		/* Free all allocated resources */
+		if (mhi_cntrl->fbc_image) {
+			mhi_free_bhie_table(mhi_cntrl, mhi_cntrl->fbc_image);
+			mhi_cntrl->fbc_image = NULL;
+		}
+		mhi_deinit_dev_ctxt(mhi_cntrl);
+	}
+}
+EXPORT_SYMBOL_GPL(mhi_power_down);
+
+int mhi_sync_power_up(struct mhi_controller *mhi_cntrl)
+{
+	int ret = mhi_async_power_up(mhi_cntrl);
+
+	if (ret)
+		return ret;
+
+	wait_event_timeout(mhi_cntrl->state_event,
+			   MHI_IN_MISSION_MODE(mhi_cntrl->ee) ||
+			   MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state),
+			   msecs_to_jiffies(mhi_cntrl->timeout_ms));
+
+	ret = (MHI_IN_MISSION_MODE(mhi_cntrl->ee)) ? 0 : -ETIMEDOUT;
+	if (ret)
+		mhi_power_down(mhi_cntrl, false);
+
+	return ret;
+}
+EXPORT_SYMBOL(mhi_sync_power_up);
+
+int mhi_force_rddm_mode(struct mhi_controller *mhi_cntrl)
+{
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	int ret;
+
+	/* Check if device is already in RDDM */
+	if (mhi_cntrl->ee == MHI_EE_RDDM)
+		return 0;
+
+	dev_dbg(dev, "Triggering SYS_ERR to force RDDM state\n");
+	mhi_set_mhi_state(mhi_cntrl, MHI_STATE_SYS_ERR);
+
+	/* Wait for RDDM event */
+	ret = wait_event_timeout(mhi_cntrl->state_event,
+				 mhi_cntrl->ee == MHI_EE_RDDM,
+				 msecs_to_jiffies(mhi_cntrl->timeout_ms));
+	ret = ret ? 0 : -EIO;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mhi_force_rddm_mode);
+
+void mhi_device_get(struct mhi_device *mhi_dev)
+{
+	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
+
+	mhi_dev->dev_wake++;
+	read_lock_bh(&mhi_cntrl->pm_lock);
+	if (MHI_PM_IN_SUSPEND_STATE(mhi_cntrl->pm_state))
+		mhi_trigger_resume(mhi_cntrl);
+
+	mhi_cntrl->wake_get(mhi_cntrl, true);
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+}
+EXPORT_SYMBOL_GPL(mhi_device_get);
+
+int mhi_device_get_sync(struct mhi_device *mhi_dev)
+{
+	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
+	int ret;
+
+	ret = __mhi_device_get_sync(mhi_cntrl);
+	if (!ret)
+		mhi_dev->dev_wake++;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mhi_device_get_sync);
+
+void mhi_device_put(struct mhi_device *mhi_dev)
+{
+	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
+
+	mhi_dev->dev_wake--;
+	read_lock_bh(&mhi_cntrl->pm_lock);
+	if (MHI_PM_IN_SUSPEND_STATE(mhi_cntrl->pm_state))
+		mhi_trigger_resume(mhi_cntrl);
+
+	mhi_cntrl->wake_put(mhi_cntrl, false);
+	read_unlock_bh(&mhi_cntrl->pm_lock);
+}
+EXPORT_SYMBOL_GPL(mhi_device_put);
diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index 4b1641fe30db..fcfe4d16cc14 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -2078,6 +2078,8 @@ static int sysc_reset(struct sysc *ddata)
 		sysc_val = sysc_read_sysconfig(ddata);
 		sysc_val |= sysc_mask;
 		sysc_write(ddata, sysc_offset, sysc_val);
+		/* Flush posted write */
+		sysc_val = sysc_read_sysconfig(ddata);
 	}
 
 	if (ddata->cfg.srst_udelay)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index ffd8f5601e28..e25c3387bcf8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1517,15 +1517,15 @@ static int amdgpu_cs_wait_all_fences(struct amdgpu_device *adev,
 			continue;
 
 		r = dma_fence_wait_timeout(fence, true, timeout);
+		if (r > 0 && fence->error)
+			r = fence->error;
+
 		dma_fence_put(fence);
 		if (r < 0)
 			return r;
 
 		if (r == 0)
 			break;
-
-		if (fence->error)
-			return fence->error;
 	}
 
 	memset(wait, 0, sizeof(*wait));
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 8445bb7ae06a..3b4724d60868 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2155,6 +2155,7 @@ struct amdgpu_bo_va *amdgpu_vm_bo_add(struct amdgpu_device *adev,
 	amdgpu_vm_bo_base_init(&bo_va->base, vm, bo);
 
 	bo_va->ref_count = 1;
+	bo_va->last_pt_update = dma_fence_get_stub();
 	INIT_LIST_HEAD(&bo_va->valids);
 	INIT_LIST_HEAD(&bo_va->invalids);
 
@@ -2867,7 +2868,8 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		vm->update_funcs = &amdgpu_vm_cpu_funcs;
 	else
 		vm->update_funcs = &amdgpu_vm_sdma_funcs;
-	vm->last_update = NULL;
+
+	vm->last_update = dma_fence_get_stub();
 	vm->last_unlocked = dma_fence_get_stub();
 
 	mutex_init(&vm->eviction_lock);
@@ -3042,7 +3044,7 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		vm->update_funcs = &amdgpu_vm_sdma_funcs;
 	}
 	dma_fence_put(vm->last_update);
-	vm->last_update = NULL;
+	vm->last_update = dma_fence_get_stub();
 	vm->is_compute_context = true;
 
 	if (vm->pasid) {
diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 7b69f81444eb..e40321d79898 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1010,21 +1010,21 @@ static const struct panel_desc auo_g104sn02 = {
 	},
 };
 
-static const struct drm_display_mode auo_g121ean01_mode = {
-	.clock = 66700,
-	.hdisplay = 1280,
-	.hsync_start = 1280 + 58,
-	.hsync_end = 1280 + 58 + 8,
-	.htotal = 1280 + 58 + 8 + 70,
-	.vdisplay = 800,
-	.vsync_start = 800 + 6,
-	.vsync_end = 800 + 6 + 4,
-	.vtotal = 800 + 6 + 4 + 10,
+static const struct display_timing auo_g121ean01_timing = {
+	.pixelclock = { 60000000, 74400000, 90000000 },
+	.hactive = { 1280, 1280, 1280 },
+	.hfront_porch = { 20, 50, 100 },
+	.hback_porch = { 20, 50, 100 },
+	.hsync_len = { 30, 100, 200 },
+	.vactive = { 800, 800, 800 },
+	.vfront_porch = { 2, 10, 25 },
+	.vback_porch = { 2, 10, 25 },
+	.vsync_len = { 4, 18, 50 },
 };
 
 static const struct panel_desc auo_g121ean01 = {
-	.modes = &auo_g121ean01_mode,
-	.num_modes = 1,
+	.timings = &auo_g121ean01_timing,
+	.num_timings = 1,
 	.bpc = 8,
 	.size = {
 		.width = 261,
diff --git a/drivers/gpu/drm/radeon/radeon_cs.c b/drivers/gpu/drm/radeon/radeon_cs.c
index a78b60b62caf..87a57e5588a2 100644
--- a/drivers/gpu/drm/radeon/radeon_cs.c
+++ b/drivers/gpu/drm/radeon/radeon_cs.c
@@ -271,7 +271,8 @@ int radeon_cs_parser_init(struct radeon_cs_parser *p, void *data)
 {
 	struct drm_radeon_cs *cs = data;
 	uint64_t *chunk_array_ptr;
-	unsigned size, i;
+	u64 size;
+	unsigned i;
 	u32 ring = RADEON_CS_RING_GFX;
 	s32 priority = 0;
 
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 2b658d820b80..6712d99ad80d 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -582,6 +582,7 @@
 #define USB_DEVICE_ID_UGCI_FIGHTING	0x0030
 
 #define USB_VENDOR_ID_HP		0x03f0
+#define USB_PRODUCT_ID_HP_ELITE_PRESENTER_MOUSE_464A		0x464a
 #define USB_PRODUCT_ID_HP_LOGITECH_OEM_USB_OPTICAL_MOUSE_0A4A	0x0a4a
 #define USB_PRODUCT_ID_HP_LOGITECH_OEM_USB_OPTICAL_MOUSE_0B4A	0x0b4a
 #define USB_PRODUCT_ID_HP_PIXART_OEM_USB_OPTICAL_MOUSE		0x134a
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 9f1fcbea19eb..4229e5de0674 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -96,6 +96,7 @@ static const struct hid_device_id hid_quirks[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HOLTEK_ALT, USB_DEVICE_ID_HOLTEK_ALT_KEYBOARD_A096), HID_QUIRK_NO_INIT_REPORTS },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HOLTEK_ALT, USB_DEVICE_ID_HOLTEK_ALT_KEYBOARD_A293), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_LOGITECH_OEM_USB_OPTICAL_MOUSE_0A4A), HID_QUIRK_ALWAYS_POLL },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_ELITE_PRESENTER_MOUSE_464A), HID_QUIRK_MULTI_INPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_LOGITECH_OEM_USB_OPTICAL_MOUSE_0B4A), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_PIXART_OEM_USB_OPTICAL_MOUSE), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_PIXART_OEM_USB_OPTICAL_MOUSE_094A), HID_QUIRK_ALWAYS_POLL },
diff --git a/drivers/i2c/busses/i2c-bcm-iproc.c b/drivers/i2c/busses/i2c-bcm-iproc.c
index 35baca2f62c4..a524d2cd1142 100644
--- a/drivers/i2c/busses/i2c-bcm-iproc.c
+++ b/drivers/i2c/busses/i2c-bcm-iproc.c
@@ -242,13 +242,14 @@ static inline u32 iproc_i2c_rd_reg(struct bcm_iproc_i2c_dev *iproc_i2c,
 				   u32 offset)
 {
 	u32 val;
+	unsigned long flags;
 
 	if (iproc_i2c->idm_base) {
-		spin_lock(&iproc_i2c->idm_lock);
+		spin_lock_irqsave(&iproc_i2c->idm_lock, flags);
 		writel(iproc_i2c->ape_addr_mask,
 		       iproc_i2c->idm_base + IDM_CTRL_DIRECT_OFFSET);
 		val = readl(iproc_i2c->base + offset);
-		spin_unlock(&iproc_i2c->idm_lock);
+		spin_unlock_irqrestore(&iproc_i2c->idm_lock, flags);
 	} else {
 		val = readl(iproc_i2c->base + offset);
 	}
@@ -259,12 +260,14 @@ static inline u32 iproc_i2c_rd_reg(struct bcm_iproc_i2c_dev *iproc_i2c,
 static inline void iproc_i2c_wr_reg(struct bcm_iproc_i2c_dev *iproc_i2c,
 				    u32 offset, u32 val)
 {
+	unsigned long flags;
+
 	if (iproc_i2c->idm_base) {
-		spin_lock(&iproc_i2c->idm_lock);
+		spin_lock_irqsave(&iproc_i2c->idm_lock, flags);
 		writel(iproc_i2c->ape_addr_mask,
 		       iproc_i2c->idm_base + IDM_CTRL_DIRECT_OFFSET);
 		writel(val, iproc_i2c->base + offset);
-		spin_unlock(&iproc_i2c->idm_lock);
+		spin_unlock_irqrestore(&iproc_i2c->idm_lock, flags);
 	} else {
 		writel(val, iproc_i2c->base + offset);
 	}
diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/busses/i2c-designware-master.c
index 2871cf2ee8b4..106080b25e81 100644
--- a/drivers/i2c/busses/i2c-designware-master.c
+++ b/drivers/i2c/busses/i2c-designware-master.c
@@ -432,8 +432,19 @@ i2c_dw_read(struct dw_i2c_dev *dev)
 
 			regmap_read(dev->map, DW_IC_DATA_CMD, &tmp);
 			/* Ensure length byte is a valid value */
-			if (flags & I2C_M_RECV_LEN &&
-			    tmp <= I2C_SMBUS_BLOCK_MAX && tmp > 0) {
+			if (flags & I2C_M_RECV_LEN) {
+				/*
+				 * if IC_EMPTYFIFO_HOLD_MASTER_EN is set, which cannot be
+				 * detected from the registers, the controller can be
+				 * disabled if the STOP bit is set. But it is only set
+				 * after receiving block data response length in
+				 * I2C_FUNC_SMBUS_BLOCK_DATA case. That needs to read
+				 * another byte with STOP bit set when the block data
+				 * response length is invalid to complete the transaction.
+				 */
+				if (!tmp || tmp > I2C_SMBUS_BLOCK_MAX)
+					tmp = 1;
+
 				len = i2c_dw_recv_len(dev, tmp);
 			}
 			*buf++ = tmp;
diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
index 267553386c71..2ed303aa7de3 100644
--- a/drivers/iio/Kconfig
+++ b/drivers/iio/Kconfig
@@ -70,6 +70,7 @@ config IIO_TRIGGERED_EVENT
 
 source "drivers/iio/accel/Kconfig"
 source "drivers/iio/adc/Kconfig"
+source "drivers/iio/addac/Kconfig"
 source "drivers/iio/afe/Kconfig"
 source "drivers/iio/amplifiers/Kconfig"
 source "drivers/iio/chemical/Kconfig"
diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
index 1712011c0f4a..d6690e449cce 100644
--- a/drivers/iio/Makefile
+++ b/drivers/iio/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_IIO_TRIGGERED_EVENT) += industrialio-triggered-event.o
 
 obj-y += accel/
 obj-y += adc/
+obj-y += addac/
 obj-y += afe/
 obj-y += amplifiers/
 obj-y += buffer/
diff --git a/drivers/iio/adc/stx104.c b/drivers/iio/adc/stx104.c
index 55bd2dc514e9..b658a75d4e3a 100644
--- a/drivers/iio/adc/stx104.c
+++ b/drivers/iio/adc/stx104.c
@@ -15,7 +15,9 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/mutex.h>
 #include <linux/spinlock.h>
+#include <linux/types.h>
 
 #define STX104_OUT_CHAN(chan) {				\
 	.type = IIO_VOLTAGE,				\
@@ -44,14 +46,38 @@ static unsigned int num_stx104;
 module_param_hw_array(base, uint, ioport, &num_stx104, 0);
 MODULE_PARM_DESC(base, "Apex Embedded Systems STX104 base addresses");
 
+/**
+ * struct stx104_reg - device register structure
+ * @ssr_ad:	Software Strobe Register and ADC Data
+ * @achan:	ADC Channel
+ * @dio:	Digital I/O
+ * @dac:	DAC Channels
+ * @cir_asr:	Clear Interrupts and ADC Status
+ * @acr:	ADC Control
+ * @pccr_fsh:	Pacer Clock Control and FIFO Status MSB
+ * @acfg:	ADC Configuration
+ */
+struct stx104_reg {
+	u16 ssr_ad;
+	u8 achan;
+	u8 dio;
+	u16 dac[2];
+	u8 cir_asr;
+	u8 acr;
+	u8 pccr_fsh;
+	u8 acfg;
+};
+
 /**
  * struct stx104_iio - IIO device private data structure
+ * @lock: synchronization lock to prevent I/O race conditions
  * @chan_out_states:	channels' output states
- * @base:		base port address of the IIO device
+ * @reg:		I/O address offset for the device registers
  */
 struct stx104_iio {
+	struct mutex lock;
 	unsigned int chan_out_states[STX104_NUM_OUT_CHAN];
-	unsigned int base;
+	struct stx104_reg __iomem *reg;
 };
 
 /**
@@ -64,7 +90,7 @@ struct stx104_iio {
 struct stx104_gpio {
 	struct gpio_chip chip;
 	spinlock_t lock;
-	unsigned int base;
+	u8 __iomem *base;
 	unsigned int out_state;
 };
 
@@ -72,6 +98,7 @@ static int stx104_read_raw(struct iio_dev *indio_dev,
 	struct iio_chan_spec const *chan, int *val, int *val2, long mask)
 {
 	struct stx104_iio *const priv = iio_priv(indio_dev);
+	struct stx104_reg __iomem *const reg = priv->reg;
 	unsigned int adc_config;
 	int adbu;
 	int gain;
@@ -79,7 +106,7 @@ static int stx104_read_raw(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_HARDWAREGAIN:
 		/* get gain configuration */
-		adc_config = inb(priv->base + 11);
+		adc_config = ioread8(&reg->acfg);
 		gain = adc_config & 0x3;
 
 		*val = 1 << gain;
@@ -90,25 +117,31 @@ static int stx104_read_raw(struct iio_dev *indio_dev,
 			return IIO_VAL_INT;
 		}
 
+		mutex_lock(&priv->lock);
+
 		/* select ADC channel */
-		outb(chan->channel | (chan->channel << 4), priv->base + 2);
+		iowrite8(chan->channel | (chan->channel << 4), &reg->achan);
+
+		/* trigger ADC sample capture by writing to the 8-bit
+		 * Software Strobe Register and wait for completion
+		 */
+		iowrite8(0, &reg->ssr_ad);
+		while (ioread8(&reg->cir_asr) & BIT(7));
 
-		/* trigger ADC sample capture and wait for completion */
-		outb(0, priv->base);
-		while (inb(priv->base + 8) & BIT(7));
+		*val = ioread16(&reg->ssr_ad);
 
-		*val = inw(priv->base);
+		mutex_unlock(&priv->lock);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_OFFSET:
 		/* get ADC bipolar/unipolar configuration */
-		adc_config = inb(priv->base + 11);
+		adc_config = ioread8(&reg->acfg);
 		adbu = !(adc_config & BIT(2));
 
 		*val = -32768 * adbu;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		/* get ADC bipolar/unipolar and gain configuration */
-		adc_config = inb(priv->base + 11);
+		adc_config = ioread8(&reg->acfg);
 		adbu = !(adc_config & BIT(2));
 		gain = adc_config & 0x3;
 
@@ -130,16 +163,16 @@ static int stx104_write_raw(struct iio_dev *indio_dev,
 		/* Only four gain states (x1, x2, x4, x8) */
 		switch (val) {
 		case 1:
-			outb(0, priv->base + 11);
+			iowrite8(0, &priv->reg->acfg);
 			break;
 		case 2:
-			outb(1, priv->base + 11);
+			iowrite8(1, &priv->reg->acfg);
 			break;
 		case 4:
-			outb(2, priv->base + 11);
+			iowrite8(2, &priv->reg->acfg);
 			break;
 		case 8:
-			outb(3, priv->base + 11);
+			iowrite8(3, &priv->reg->acfg);
 			break;
 		default:
 			return -EINVAL;
@@ -152,9 +185,12 @@ static int stx104_write_raw(struct iio_dev *indio_dev,
 			if ((unsigned int)val > 65535)
 				return -EINVAL;
 
+			mutex_lock(&priv->lock);
+
 			priv->chan_out_states[chan->channel] = val;
-			outw(val, priv->base + 4 + 2 * chan->channel);
+			iowrite16(val, &priv->reg->dac[chan->channel]);
 
+			mutex_unlock(&priv->lock);
 			return 0;
 		}
 		return -EINVAL;
@@ -222,7 +258,7 @@ static int stx104_gpio_get(struct gpio_chip *chip, unsigned int offset)
 	if (offset >= 4)
 		return -EINVAL;
 
-	return !!(inb(stx104gpio->base) & BIT(offset));
+	return !!(ioread8(stx104gpio->base) & BIT(offset));
 }
 
 static int stx104_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
@@ -230,7 +266,7 @@ static int stx104_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
 {
 	struct stx104_gpio *const stx104gpio = gpiochip_get_data(chip);
 
-	*bits = inb(stx104gpio->base);
+	*bits = ioread8(stx104gpio->base);
 
 	return 0;
 }
@@ -252,7 +288,7 @@ static void stx104_gpio_set(struct gpio_chip *chip, unsigned int offset,
 	else
 		stx104gpio->out_state &= ~mask;
 
-	outb(stx104gpio->out_state, stx104gpio->base);
+	iowrite8(stx104gpio->out_state, stx104gpio->base);
 
 	spin_unlock_irqrestore(&stx104gpio->lock, flags);
 }
@@ -279,7 +315,7 @@ static void stx104_gpio_set_multiple(struct gpio_chip *chip,
 
 	stx104gpio->out_state &= ~*mask;
 	stx104gpio->out_state |= *mask & *bits;
-	outb(stx104gpio->out_state, stx104gpio->base);
+	iowrite8(stx104gpio->out_state, stx104gpio->base);
 
 	spin_unlock_irqrestore(&stx104gpio->lock, flags);
 }
@@ -306,11 +342,16 @@ static int stx104_probe(struct device *dev, unsigned int id)
 		return -EBUSY;
 	}
 
+	priv = iio_priv(indio_dev);
+	priv->reg = devm_ioport_map(dev, base[id], STX104_EXTENT);
+	if (!priv->reg)
+		return -ENOMEM;
+
 	indio_dev->info = &stx104_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	/* determine if differential inputs */
-	if (inb(base[id] + 8) & BIT(5)) {
+	if (ioread8(&priv->reg->cir_asr) & BIT(5)) {
 		indio_dev->num_channels = ARRAY_SIZE(stx104_channels_diff);
 		indio_dev->channels = stx104_channels_diff;
 	} else {
@@ -320,18 +361,17 @@ static int stx104_probe(struct device *dev, unsigned int id)
 
 	indio_dev->name = dev_name(dev);
 
-	priv = iio_priv(indio_dev);
-	priv->base = base[id];
+	mutex_init(&priv->lock);
 
 	/* configure device for software trigger operation */
-	outb(0, base[id] + 9);
+	iowrite8(0, &priv->reg->acr);
 
 	/* initialize gain setting to x1 */
-	outb(0, base[id] + 11);
+	iowrite8(0, &priv->reg->acfg);
 
 	/* initialize DAC output to 0V */
-	outw(0, base[id] + 4);
-	outw(0, base[id] + 6);
+	iowrite16(0, &priv->reg->dac[0]);
+	iowrite16(0, &priv->reg->dac[1]);
 
 	stx104gpio->chip.label = dev_name(dev);
 	stx104gpio->chip.parent = dev;
@@ -346,7 +386,7 @@ static int stx104_probe(struct device *dev, unsigned int id)
 	stx104gpio->chip.get_multiple = stx104_gpio_get_multiple;
 	stx104gpio->chip.set = stx104_gpio_set;
 	stx104gpio->chip.set_multiple = stx104_gpio_set_multiple;
-	stx104gpio->base = base[id] + 3;
+	stx104gpio->base = &priv->reg->dio;
 	stx104gpio->out_state = 0x0;
 
 	spin_lock_init(&stx104gpio->lock);
diff --git a/drivers/iio/addac/Kconfig b/drivers/iio/addac/Kconfig
new file mode 100644
index 000000000000..2e64d7755d5e
--- /dev/null
+++ b/drivers/iio/addac/Kconfig
@@ -0,0 +1,8 @@
+#
+# ADC DAC drivers
+#
+# When adding new entries keep the list in alphabetical order
+
+menu "Analog to digital and digital to analog converters"
+
+endmenu
diff --git a/drivers/iio/addac/Makefile b/drivers/iio/addac/Makefile
new file mode 100644
index 000000000000..b888b9ee12da
--- /dev/null
+++ b/drivers/iio/addac/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for industrial I/O ADDAC drivers
+#
+
+# When adding new entries keep the list in alphabetical order
diff --git a/drivers/infiniband/hw/mlx5/qpc.c b/drivers/infiniband/hw/mlx5/qpc.c
index c683d7000168..9a306da7f949 100644
--- a/drivers/infiniband/hw/mlx5/qpc.c
+++ b/drivers/infiniband/hw/mlx5/qpc.c
@@ -297,8 +297,7 @@ int mlx5_core_destroy_qp(struct mlx5_ib_dev *dev, struct mlx5_core_qp *qp)
 	MLX5_SET(destroy_qp_in, in, opcode, MLX5_CMD_OP_DESTROY_QP);
 	MLX5_SET(destroy_qp_in, in, qpn, qp->qpn);
 	MLX5_SET(destroy_qp_in, in, uid, qp->uid);
-	mlx5_cmd_exec_in(dev->mdev, destroy_qp, in);
-	return 0;
+	return mlx5_cmd_exec_in(dev->mdev, destroy_qp, in);
 }
 
 int mlx5_core_set_delay_drop(struct mlx5_ib_dev *dev,
@@ -542,14 +541,14 @@ int mlx5_core_xrcd_dealloc(struct mlx5_ib_dev *dev, u32 xrcdn)
 	return mlx5_cmd_exec_in(dev->mdev, dealloc_xrcd, in);
 }
 
-static void destroy_rq_tracked(struct mlx5_ib_dev *dev, u32 rqn, u16 uid)
+static int destroy_rq_tracked(struct mlx5_ib_dev *dev, u32 rqn, u16 uid)
 {
 	u32 in[MLX5_ST_SZ_DW(destroy_rq_in)] = {};
 
 	MLX5_SET(destroy_rq_in, in, opcode, MLX5_CMD_OP_DESTROY_RQ);
 	MLX5_SET(destroy_rq_in, in, rqn, rqn);
 	MLX5_SET(destroy_rq_in, in, uid, uid);
-	mlx5_cmd_exec_in(dev->mdev, destroy_rq, in);
+	return mlx5_cmd_exec_in(dev->mdev, destroy_rq, in);
 }
 
 int mlx5_core_create_rq_tracked(struct mlx5_ib_dev *dev, u32 *in, int inlen,
@@ -580,8 +579,7 @@ int mlx5_core_destroy_rq_tracked(struct mlx5_ib_dev *dev,
 				 struct mlx5_core_qp *rq)
 {
 	destroy_resource_common(dev, rq);
-	destroy_rq_tracked(dev, rq->qpn, rq->uid);
-	return 0;
+	return destroy_rq_tracked(dev, rq->qpn, rq->uid);
 }
 
 static void destroy_sq_tracked(struct mlx5_ib_dev *dev, u32 sqn, u16 uid)
diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 8ada91bdbe4d..fc25b900cef7 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -48,7 +48,7 @@ void __iomem *mips_gic_base;
 
 static DEFINE_PER_CPU_READ_MOSTLY(unsigned long[GIC_MAX_LONGS], pcpu_masks);
 
-static DEFINE_SPINLOCK(gic_lock);
+static DEFINE_RAW_SPINLOCK(gic_lock);
 static struct irq_domain *gic_irq_domain;
 static int gic_shared_intrs;
 static unsigned int gic_cpu_pin;
@@ -209,7 +209,7 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 
 	irq = GIC_HWIRQ_TO_SHARED(d->hwirq);
 
-	spin_lock_irqsave(&gic_lock, flags);
+	raw_spin_lock_irqsave(&gic_lock, flags);
 	switch (type & IRQ_TYPE_SENSE_MASK) {
 	case IRQ_TYPE_EDGE_FALLING:
 		pol = GIC_POL_FALLING_EDGE;
@@ -249,7 +249,7 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 	else
 		irq_set_chip_handler_name_locked(d, &gic_level_irq_controller,
 						 handle_level_irq, NULL);
-	spin_unlock_irqrestore(&gic_lock, flags);
+	raw_spin_unlock_irqrestore(&gic_lock, flags);
 
 	return 0;
 }
@@ -267,7 +267,7 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *cpumask,
 		return -EINVAL;
 
 	/* Assumption : cpumask refers to a single CPU */
-	spin_lock_irqsave(&gic_lock, flags);
+	raw_spin_lock_irqsave(&gic_lock, flags);
 
 	/* Re-route this IRQ */
 	write_gic_map_vp(irq, BIT(mips_cm_vp_id(cpu)));
@@ -278,7 +278,7 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *cpumask,
 		set_bit(irq, per_cpu_ptr(pcpu_masks, cpu));
 
 	irq_data_update_effective_affinity(d, cpumask_of(cpu));
-	spin_unlock_irqrestore(&gic_lock, flags);
+	raw_spin_unlock_irqrestore(&gic_lock, flags);
 
 	return IRQ_SET_MASK_OK;
 }
@@ -356,12 +356,12 @@ static void gic_mask_local_irq_all_vpes(struct irq_data *d)
 	cd = irq_data_get_irq_chip_data(d);
 	cd->mask = false;
 
-	spin_lock_irqsave(&gic_lock, flags);
+	raw_spin_lock_irqsave(&gic_lock, flags);
 	for_each_online_cpu(cpu) {
 		write_gic_vl_other(mips_cm_vp_id(cpu));
 		write_gic_vo_rmask(BIT(intr));
 	}
-	spin_unlock_irqrestore(&gic_lock, flags);
+	raw_spin_unlock_irqrestore(&gic_lock, flags);
 }
 
 static void gic_unmask_local_irq_all_vpes(struct irq_data *d)
@@ -374,32 +374,43 @@ static void gic_unmask_local_irq_all_vpes(struct irq_data *d)
 	cd = irq_data_get_irq_chip_data(d);
 	cd->mask = true;
 
-	spin_lock_irqsave(&gic_lock, flags);
+	raw_spin_lock_irqsave(&gic_lock, flags);
 	for_each_online_cpu(cpu) {
 		write_gic_vl_other(mips_cm_vp_id(cpu));
 		write_gic_vo_smask(BIT(intr));
 	}
-	spin_unlock_irqrestore(&gic_lock, flags);
+	raw_spin_unlock_irqrestore(&gic_lock, flags);
 }
 
-static void gic_all_vpes_irq_cpu_online(struct irq_data *d)
+static void gic_all_vpes_irq_cpu_online(void)
 {
-	struct gic_all_vpes_chip_data *cd;
-	unsigned int intr;
+	static const unsigned int local_intrs[] = {
+		GIC_LOCAL_INT_TIMER,
+		GIC_LOCAL_INT_PERFCTR,
+		GIC_LOCAL_INT_FDC,
+	};
+	unsigned long flags;
+	int i;
 
-	intr = GIC_HWIRQ_TO_LOCAL(d->hwirq);
-	cd = irq_data_get_irq_chip_data(d);
+	raw_spin_lock_irqsave(&gic_lock, flags);
 
-	write_gic_vl_map(mips_gic_vx_map_reg(intr), cd->map);
-	if (cd->mask)
-		write_gic_vl_smask(BIT(intr));
+	for (i = 0; i < ARRAY_SIZE(local_intrs); i++) {
+		unsigned int intr = local_intrs[i];
+		struct gic_all_vpes_chip_data *cd;
+
+		cd = &gic_all_vpes_chip_data[intr];
+		write_gic_vl_map(mips_gic_vx_map_reg(intr), cd->map);
+		if (cd->mask)
+			write_gic_vl_smask(BIT(intr));
+	}
+
+	raw_spin_unlock_irqrestore(&gic_lock, flags);
 }
 
 static struct irq_chip gic_all_vpes_local_irq_controller = {
 	.name			= "MIPS GIC Local",
 	.irq_mask		= gic_mask_local_irq_all_vpes,
 	.irq_unmask		= gic_unmask_local_irq_all_vpes,
-	.irq_cpu_online		= gic_all_vpes_irq_cpu_online,
 };
 
 static void __gic_irq_dispatch(void)
@@ -423,11 +434,11 @@ static int gic_shared_irq_domain_map(struct irq_domain *d, unsigned int virq,
 
 	data = irq_get_irq_data(virq);
 
-	spin_lock_irqsave(&gic_lock, flags);
+	raw_spin_lock_irqsave(&gic_lock, flags);
 	write_gic_map_pin(intr, GIC_MAP_PIN_MAP_TO_PIN | gic_cpu_pin);
 	write_gic_map_vp(intr, BIT(mips_cm_vp_id(cpu)));
 	irq_data_update_effective_affinity(data, cpumask_of(cpu));
-	spin_unlock_irqrestore(&gic_lock, flags);
+	raw_spin_unlock_irqrestore(&gic_lock, flags);
 
 	return 0;
 }
@@ -480,6 +491,10 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int virq,
 	intr = GIC_HWIRQ_TO_LOCAL(hwirq);
 	map = GIC_MAP_PIN_MAP_TO_PIN | gic_cpu_pin;
 
+	/*
+	 * If adding support for more per-cpu interrupts, keep the the
+	 * array in gic_all_vpes_irq_cpu_online() in sync.
+	 */
 	switch (intr) {
 	case GIC_LOCAL_INT_TIMER:
 		/* CONFIG_MIPS_CMP workaround (see __gic_init) */
@@ -518,12 +533,12 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int virq,
 	if (!gic_local_irq_is_routable(intr))
 		return -EPERM;
 
-	spin_lock_irqsave(&gic_lock, flags);
+	raw_spin_lock_irqsave(&gic_lock, flags);
 	for_each_online_cpu(cpu) {
 		write_gic_vl_other(mips_cm_vp_id(cpu));
 		write_gic_vo_map(mips_gic_vx_map_reg(intr), map);
 	}
-	spin_unlock_irqrestore(&gic_lock, flags);
+	raw_spin_unlock_irqrestore(&gic_lock, flags);
 
 	return 0;
 }
@@ -710,8 +725,8 @@ static int gic_cpu_startup(unsigned int cpu)
 	/* Clear all local IRQ masks (ie. disable all local interrupts) */
 	write_gic_vl_rmask(~0);
 
-	/* Invoke irq_cpu_online callbacks to enable desired interrupts */
-	irq_cpu_online();
+	/* Enable desired interrupts */
+	gic_all_vpes_irq_cpu_online();
 
 	return 0;
 }
diff --git a/drivers/media/platform/mtk-vpu/mtk_vpu.c b/drivers/media/platform/mtk-vpu/mtk_vpu.c
index c62eb212cca9..e7c4b0dd588a 100644
--- a/drivers/media/platform/mtk-vpu/mtk_vpu.c
+++ b/drivers/media/platform/mtk-vpu/mtk_vpu.c
@@ -539,15 +539,17 @@ static int load_requested_vpu(struct mtk_vpu *vpu,
 int vpu_load_firmware(struct platform_device *pdev)
 {
 	struct mtk_vpu *vpu;
-	struct device *dev = &pdev->dev;
+	struct device *dev;
 	struct vpu_run *run;
 	int ret;
 
 	if (!pdev) {
-		dev_err(dev, "VPU platform device is invalid\n");
+		pr_err("VPU platform device is invalid\n");
 		return -EINVAL;
 	}
 
+	dev = &pdev->dev;
+
 	vpu = platform_get_drvdata(pdev);
 	run = &vpu->run;
 
diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 599b7317b59a..d81baf750aeb 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1980,14 +1980,14 @@ static void mmc_blk_mq_poll_completion(struct mmc_queue *mq,
 	mmc_blk_urgent_bkops(mq, mqrq);
 }
 
-static void mmc_blk_mq_dec_in_flight(struct mmc_queue *mq, struct request *req)
+static void mmc_blk_mq_dec_in_flight(struct mmc_queue *mq, enum mmc_issue_type issue_type)
 {
 	unsigned long flags;
 	bool put_card;
 
 	spin_lock_irqsave(&mq->lock, flags);
 
-	mq->in_flight[mmc_issue_type(mq, req)] -= 1;
+	mq->in_flight[issue_type] -= 1;
 
 	put_card = (mmc_tot_in_flight(mq) == 0);
 
@@ -1999,6 +1999,7 @@ static void mmc_blk_mq_dec_in_flight(struct mmc_queue *mq, struct request *req)
 
 static void mmc_blk_mq_post_req(struct mmc_queue *mq, struct request *req)
 {
+	enum mmc_issue_type issue_type = mmc_issue_type(mq, req);
 	struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
 	struct mmc_request *mrq = &mqrq->brq.mrq;
 	struct mmc_host *host = mq->card->host;
@@ -2014,7 +2015,7 @@ static void mmc_blk_mq_post_req(struct mmc_queue *mq, struct request *req)
 	else if (likely(!blk_should_fake_timeout(req->q)))
 		blk_mq_complete_request(req);
 
-	mmc_blk_mq_dec_in_flight(mq, req);
+	mmc_blk_mq_dec_in_flight(mq, issue_type);
 }
 
 void mmc_blk_mq_recovery(struct mmc_queue *mq)
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 03e2f965a96a..1f46694b2e53 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -513,6 +513,32 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 
 EXPORT_SYMBOL(mmc_alloc_host);
 
+static void devm_mmc_host_release(struct device *dev, void *res)
+{
+	mmc_free_host(*(struct mmc_host **)res);
+}
+
+struct mmc_host *devm_mmc_alloc_host(struct device *dev, int extra)
+{
+	struct mmc_host **dr, *host;
+
+	dr = devres_alloc(devm_mmc_host_release, sizeof(*dr), GFP_KERNEL);
+	if (!dr)
+		return ERR_PTR(-ENOMEM);
+
+	host = mmc_alloc_host(extra, dev);
+	if (IS_ERR(host)) {
+		devres_free(dr);
+		return host;
+	}
+
+	*dr = host;
+	devres_add(dev, dr);
+
+	return host;
+}
+EXPORT_SYMBOL(devm_mmc_alloc_host);
+
 static int mmc_validate_host_caps(struct mmc_host *host)
 {
 	if (host->caps & MMC_CAP_SDIO_IRQ && !host->ops->enable_sdio_irq) {
diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index 8c2361e66277..985079943be7 100644
--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -1413,8 +1413,8 @@ static int bcm2835_probe(struct platform_device *pdev)
 	host->max_clk = clk_get_rate(clk);
 
 	host->irq = platform_get_irq(pdev, 0);
-	if (host->irq <= 0) {
-		ret = -EINVAL;
+	if (host->irq < 0) {
+		ret = host->irq;
 		goto err;
 	}
 
diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index e89bd6f4b317..1992eea8b777 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -1122,7 +1122,7 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	struct mmc_host *mmc;
 	int ret;
 
-	mmc = mmc_alloc_host(sizeof(struct meson_host), &pdev->dev);
+	mmc = devm_mmc_alloc_host(&pdev->dev, sizeof(struct meson_host));
 	if (!mmc)
 		return -ENOMEM;
 	host = mmc_priv(mmc);
@@ -1138,46 +1138,33 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	host->vqmmc_enabled = false;
 	ret = mmc_regulator_get_supply(mmc);
 	if (ret)
-		goto free_host;
+		return ret;
 
 	ret = mmc_of_parse(mmc);
-	if (ret) {
-		if (ret != -EPROBE_DEFER)
-			dev_warn(&pdev->dev, "error parsing DT: %d\n", ret);
-		goto free_host;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "error parsing DT\n");
 
 	host->data = (struct meson_mmc_data *)
 		of_device_get_match_data(&pdev->dev);
-	if (!host->data) {
-		ret = -EINVAL;
-		goto free_host;
-	}
+	if (!host->data)
+		return -EINVAL;
 
 	ret = device_reset_optional(&pdev->dev);
-	if (ret) {
-		dev_err_probe(&pdev->dev, ret, "device reset failed\n");
-		goto free_host;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "device reset failed\n");
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	host->regs = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(host->regs)) {
-		ret = PTR_ERR(host->regs);
-		goto free_host;
-	}
+	if (IS_ERR(host->regs))
+		return PTR_ERR(host->regs);
 
 	host->irq = platform_get_irq(pdev, 0);
-	if (host->irq <= 0) {
-		ret = -EINVAL;
-		goto free_host;
-	}
+	if (host->irq < 0)
+		return host->irq;
 
 	host->pinctrl = devm_pinctrl_get(&pdev->dev);
-	if (IS_ERR(host->pinctrl)) {
-		ret = PTR_ERR(host->pinctrl);
-		goto free_host;
-	}
+	if (IS_ERR(host->pinctrl))
+		return PTR_ERR(host->pinctrl);
 
 	host->pins_clk_gate = pinctrl_lookup_state(host->pinctrl,
 						   "clk-gate");
@@ -1188,14 +1175,12 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	}
 
 	host->core_clk = devm_clk_get(&pdev->dev, "core");
-	if (IS_ERR(host->core_clk)) {
-		ret = PTR_ERR(host->core_clk);
-		goto free_host;
-	}
+	if (IS_ERR(host->core_clk))
+		return PTR_ERR(host->core_clk);
 
 	ret = clk_prepare_enable(host->core_clk);
 	if (ret)
-		goto free_host;
+		return ret;
 
 	ret = meson_mmc_clk_init(host);
 	if (ret)
@@ -1290,8 +1275,6 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	clk_disable_unprepare(host->mmc_clk);
 err_core_clk:
 	clk_disable_unprepare(host->core_clk);
-free_host:
-	mmc_free_host(mmc);
 	return ret;
 }
 
@@ -1315,7 +1298,6 @@ static int meson_mmc_remove(struct platform_device *pdev)
 	clk_disable_unprepare(host->mmc_clk);
 	clk_disable_unprepare(host->core_clk);
 
-	mmc_free_host(host->mmc);
 	return 0;
 }
 
diff --git a/drivers/mmc/host/sdhci_f_sdh30.c b/drivers/mmc/host/sdhci_f_sdh30.c
index 6c4f43e11282..7ede74bf3723 100644
--- a/drivers/mmc/host/sdhci_f_sdh30.c
+++ b/drivers/mmc/host/sdhci_f_sdh30.c
@@ -26,9 +26,16 @@ struct f_sdhost_priv {
 	bool enable_cmd_dat_delay;
 };
 
+static void *sdhci_f_sdhost_priv(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+
+	return sdhci_pltfm_priv(pltfm_host);
+}
+
 static void sdhci_f_sdh30_soft_voltage_switch(struct sdhci_host *host)
 {
-	struct f_sdhost_priv *priv = sdhci_priv(host);
+	struct f_sdhost_priv *priv = sdhci_f_sdhost_priv(host);
 	u32 ctrl = 0;
 
 	usleep_range(2500, 3000);
@@ -61,7 +68,7 @@ static unsigned int sdhci_f_sdh30_get_min_clock(struct sdhci_host *host)
 
 static void sdhci_f_sdh30_reset(struct sdhci_host *host, u8 mask)
 {
-	struct f_sdhost_priv *priv = sdhci_priv(host);
+	struct f_sdhost_priv *priv = sdhci_f_sdhost_priv(host);
 	u32 ctl;
 
 	if (sdhci_readw(host, SDHCI_CLOCK_CONTROL) == 0)
@@ -85,30 +92,32 @@ static const struct sdhci_ops sdhci_f_sdh30_ops = {
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
 };
 
+static const struct sdhci_pltfm_data sdhci_f_sdh30_pltfm_data = {
+	.ops = &sdhci_f_sdh30_ops,
+	.quirks = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC
+		| SDHCI_QUIRK_INVERTED_WRITE_PROTECT,
+	.quirks2 = SDHCI_QUIRK2_SUPPORT_SINGLE
+		|  SDHCI_QUIRK2_TUNING_WORK_AROUND,
+};
+
 static int sdhci_f_sdh30_probe(struct platform_device *pdev)
 {
 	struct sdhci_host *host;
 	struct device *dev = &pdev->dev;
-	int irq, ctrl = 0, ret = 0;
+	int ctrl = 0, ret = 0;
 	struct f_sdhost_priv *priv;
+	struct sdhci_pltfm_host *pltfm_host;
 	u32 reg = 0;
 
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return irq;
-
-	host = sdhci_alloc_host(dev, sizeof(struct f_sdhost_priv));
+	host = sdhci_pltfm_init(pdev, &sdhci_f_sdh30_pltfm_data,
+				sizeof(struct f_sdhost_priv));
 	if (IS_ERR(host))
 		return PTR_ERR(host);
 
-	priv = sdhci_priv(host);
+	pltfm_host = sdhci_priv(host);
+	priv = sdhci_pltfm_priv(pltfm_host);
 	priv->dev = dev;
 
-	host->quirks = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC |
-		       SDHCI_QUIRK_INVERTED_WRITE_PROTECT;
-	host->quirks2 = SDHCI_QUIRK2_SUPPORT_SINGLE |
-			SDHCI_QUIRK2_TUNING_WORK_AROUND;
-
 	priv->enable_cmd_dat_delay = device_property_read_bool(dev,
 						"fujitsu,cmd-dat-delay-select");
 
@@ -116,18 +125,6 @@ static int sdhci_f_sdh30_probe(struct platform_device *pdev)
 	if (ret)
 		goto err;
 
-	platform_set_drvdata(pdev, host);
-
-	host->hw_name = "f_sdh30";
-	host->ops = &sdhci_f_sdh30_ops;
-	host->irq = irq;
-
-	host->ioaddr = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(host->ioaddr)) {
-		ret = PTR_ERR(host->ioaddr);
-		goto err;
-	}
-
 	if (dev_of_node(dev)) {
 		sdhci_get_of_property(pdev);
 
@@ -182,23 +179,22 @@ static int sdhci_f_sdh30_probe(struct platform_device *pdev)
 err_clk:
 	clk_disable_unprepare(priv->clk_iface);
 err:
-	sdhci_free_host(host);
+	sdhci_pltfm_free(pdev);
+
 	return ret;
 }
 
 static int sdhci_f_sdh30_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
-	struct f_sdhost_priv *priv = sdhci_priv(host);
-
-	sdhci_remove_host(host, readl(host->ioaddr + SDHCI_INT_STATUS) ==
-			  0xffffffff);
+	struct f_sdhost_priv *priv = sdhci_f_sdhost_priv(host);
+	struct clk *clk_iface = priv->clk_iface;
+	struct clk *clk = priv->clk;
 
-	clk_disable_unprepare(priv->clk_iface);
-	clk_disable_unprepare(priv->clk);
+	sdhci_pltfm_unregister(pdev);
 
-	sdhci_free_host(host);
-	platform_set_drvdata(pdev, NULL);
+	clk_disable_unprepare(clk_iface);
+	clk_disable_unprepare(clk);
 
 	return 0;
 }
diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 9215069c6156..b834fde3f9ed 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1317,8 +1317,8 @@ static int sunxi_mmc_resource_request(struct sunxi_mmc_host *host,
 		return ret;
 
 	host->irq = platform_get_irq(pdev, 0);
-	if (host->irq <= 0) {
-		ret = -EINVAL;
+	if (host->irq < 0) {
+		ret = host->irq;
 		goto error_disable_mmc;
 	}
 
diff --git a/drivers/mmc/host/wbsd.c b/drivers/mmc/host/wbsd.c
index f3090216e0dc..6db08070b628 100644
--- a/drivers/mmc/host/wbsd.c
+++ b/drivers/mmc/host/wbsd.c
@@ -1710,8 +1710,6 @@ static int wbsd_init(struct device *dev, int base, int irq, int dma,
 
 		wbsd_release_resources(host);
 		wbsd_free_mmc(dev);
-
-		mmc_free_host(mmc);
 		return ret;
 	}
 
diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 8b2c8546f4c9..177151298d72 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -2310,6 +2310,14 @@ static void mv88e6xxx_hardware_reset(struct mv88e6xxx_chip *chip)
 
 	/* If there is a GPIO connected to the reset pin, toggle it */
 	if (gpiod) {
+		/* If the switch has just been reset and not yet completed
+		 * loading EEPROM, the reset may interrupt the I2C transaction
+		 * mid-byte, causing the first EEPROM read after the reset
+		 * from the wrong location resulting in the switch booting
+		 * to wrong mode and inoperable.
+		 */
+		mv88e6xxx_g1_wait_eeprom_done(chip);
+
 		gpiod_set_value_cansleep(gpiod, 1);
 		usleep_range(10000, 20000);
 		gpiod_set_value_cansleep(gpiod, 0);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_nvm.c b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
index 7164f4ad8120..6b1996451a4b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_nvm.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
@@ -210,11 +210,11 @@ static i40e_status i40e_read_nvm_word_srctl(struct i40e_hw *hw, u16 offset,
  * @hw: pointer to the HW structure.
  * @module_pointer: module pointer location in words from the NVM beginning
  * @offset: offset in words from module start
- * @words: number of words to write
- * @data: buffer with words to write to the Shadow RAM
+ * @words: number of words to read
+ * @data: buffer with words to read to the Shadow RAM
  * @last_command: tells the AdminQ that this is the last command
  *
- * Writes a 16 bit words buffer to the Shadow RAM using the admin command.
+ * Reads a 16 bit words buffer to the Shadow RAM using the admin command.
  **/
 static i40e_status i40e_read_nvm_aq(struct i40e_hw *hw,
 				    u8 module_pointer, u32 offset,
@@ -234,18 +234,18 @@ static i40e_status i40e_read_nvm_aq(struct i40e_hw *hw,
 	 */
 	if ((offset + words) > hw->nvm.sr_size)
 		i40e_debug(hw, I40E_DEBUG_NVM,
-			   "NVM write error: offset %d beyond Shadow RAM limit %d\n",
+			   "NVM read error: offset %d beyond Shadow RAM limit %d\n",
 			   (offset + words), hw->nvm.sr_size);
 	else if (words > I40E_SR_SECTOR_SIZE_IN_WORDS)
-		/* We can write only up to 4KB (one sector), in one AQ write */
+		/* We can read only up to 4KB (one sector), in one AQ write */
 		i40e_debug(hw, I40E_DEBUG_NVM,
-			   "NVM write fail error: tried to write %d words, limit is %d.\n",
+			   "NVM read fail error: tried to read %d words, limit is %d.\n",
 			   words, I40E_SR_SECTOR_SIZE_IN_WORDS);
 	else if (((offset + (words - 1)) / I40E_SR_SECTOR_SIZE_IN_WORDS)
 		 != (offset / I40E_SR_SECTOR_SIZE_IN_WORDS))
-		/* A single write cannot spread over two sectors */
+		/* A single read cannot spread over two sectors */
 		i40e_debug(hw, I40E_DEBUG_NVM,
-			   "NVM write error: cannot spread over two sectors in a single write offset=%d words=%d\n",
+			   "NVM read error: cannot spread over two sectors in a single read offset=%d words=%d\n",
 			   offset, words);
 	else
 		ret_code = i40e_aq_read_nvm(hw, module_pointer,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
index 44a434b1178b..80dee8c69249 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
@@ -89,7 +89,8 @@ static u64 mlx5_read_internal_timer(struct mlx5_core_dev *dev,
 
 static u64 read_internal_timer(const struct cyclecounter *cc)
 {
-	struct mlx5_clock *clock = container_of(cc, struct mlx5_clock, cycles);
+	struct mlx5_timer *timer = container_of(cc, struct mlx5_timer, cycles);
+	struct mlx5_clock *clock = container_of(timer, struct mlx5_clock, timer);
 	struct mlx5_core_dev *mdev = container_of(clock, struct mlx5_core_dev,
 						  clock);
 
@@ -100,6 +101,7 @@ static void mlx5_update_clock_info_page(struct mlx5_core_dev *mdev)
 {
 	struct mlx5_ib_clock_info *clock_info = mdev->clock_info;
 	struct mlx5_clock *clock = &mdev->clock;
+	struct mlx5_timer *timer;
 	u32 sign;
 
 	if (!clock_info)
@@ -109,10 +111,11 @@ static void mlx5_update_clock_info_page(struct mlx5_core_dev *mdev)
 	smp_store_mb(clock_info->sign,
 		     sign | MLX5_IB_CLOCK_INFO_KERNEL_UPDATING);
 
-	clock_info->cycles = clock->tc.cycle_last;
-	clock_info->mult   = clock->cycles.mult;
-	clock_info->nsec   = clock->tc.nsec;
-	clock_info->frac   = clock->tc.frac;
+	timer = &clock->timer;
+	clock_info->cycles = timer->tc.cycle_last;
+	clock_info->mult   = timer->cycles.mult;
+	clock_info->nsec   = timer->tc.nsec;
+	clock_info->frac   = timer->tc.frac;
 
 	smp_store_release(&clock_info->sign,
 			  sign + MLX5_IB_CLOCK_INFO_KERNEL_UPDATING * 2);
@@ -151,28 +154,37 @@ static void mlx5_timestamp_overflow(struct work_struct *work)
 {
 	struct delayed_work *dwork = to_delayed_work(work);
 	struct mlx5_core_dev *mdev;
+	struct mlx5_timer *timer;
 	struct mlx5_clock *clock;
 	unsigned long flags;
 
-	clock = container_of(dwork, struct mlx5_clock, overflow_work);
+	timer = container_of(dwork, struct mlx5_timer, overflow_work);
+	clock = container_of(timer, struct mlx5_clock, timer);
 	mdev = container_of(clock, struct mlx5_core_dev, clock);
+
+	if (mdev->state == MLX5_DEVICE_STATE_INTERNAL_ERROR)
+		goto out;
+
 	write_seqlock_irqsave(&clock->lock, flags);
-	timecounter_read(&clock->tc);
+	timecounter_read(&timer->tc);
 	mlx5_update_clock_info_page(mdev);
 	write_sequnlock_irqrestore(&clock->lock, flags);
-	schedule_delayed_work(&clock->overflow_work, clock->overflow_period);
+
+out:
+	schedule_delayed_work(&timer->overflow_work, timer->overflow_period);
 }
 
 static int mlx5_ptp_settime(struct ptp_clock_info *ptp, const struct timespec64 *ts)
 {
 	struct mlx5_clock *clock = container_of(ptp, struct mlx5_clock, ptp_info);
+	struct mlx5_timer *timer = &clock->timer;
 	u64 ns = timespec64_to_ns(ts);
 	struct mlx5_core_dev *mdev;
 	unsigned long flags;
 
 	mdev = container_of(clock, struct mlx5_core_dev, clock);
 	write_seqlock_irqsave(&clock->lock, flags);
-	timecounter_init(&clock->tc, &clock->cycles, ns);
+	timecounter_init(&timer->tc, &timer->cycles, ns);
 	mlx5_update_clock_info_page(mdev);
 	write_sequnlock_irqrestore(&clock->lock, flags);
 
@@ -183,6 +195,7 @@ static int mlx5_ptp_gettimex(struct ptp_clock_info *ptp, struct timespec64 *ts,
 			     struct ptp_system_timestamp *sts)
 {
 	struct mlx5_clock *clock = container_of(ptp, struct mlx5_clock, ptp_info);
+	struct mlx5_timer *timer = &clock->timer;
 	struct mlx5_core_dev *mdev;
 	unsigned long flags;
 	u64 cycles, ns;
@@ -190,7 +203,7 @@ static int mlx5_ptp_gettimex(struct ptp_clock_info *ptp, struct timespec64 *ts,
 	mdev = container_of(clock, struct mlx5_core_dev, clock);
 	write_seqlock_irqsave(&clock->lock, flags);
 	cycles = mlx5_read_internal_timer(mdev, sts);
-	ns = timecounter_cyc2time(&clock->tc, cycles);
+	ns = timecounter_cyc2time(&timer->tc, cycles);
 	write_sequnlock_irqrestore(&clock->lock, flags);
 
 	*ts = ns_to_timespec64(ns);
@@ -201,12 +214,13 @@ static int mlx5_ptp_gettimex(struct ptp_clock_info *ptp, struct timespec64 *ts,
 static int mlx5_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
 {
 	struct mlx5_clock *clock = container_of(ptp, struct mlx5_clock, ptp_info);
+	struct mlx5_timer *timer = &clock->timer;
 	struct mlx5_core_dev *mdev;
 	unsigned long flags;
 
 	mdev = container_of(clock, struct mlx5_core_dev, clock);
 	write_seqlock_irqsave(&clock->lock, flags);
-	timecounter_adjtime(&clock->tc, delta);
+	timecounter_adjtime(&timer->tc, delta);
 	mlx5_update_clock_info_page(mdev);
 	write_sequnlock_irqrestore(&clock->lock, flags);
 
@@ -216,27 +230,27 @@ static int mlx5_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
 static int mlx5_ptp_adjfreq(struct ptp_clock_info *ptp, s32 delta)
 {
 	struct mlx5_clock *clock = container_of(ptp, struct mlx5_clock, ptp_info);
+	struct mlx5_timer *timer = &clock->timer;
 	struct mlx5_core_dev *mdev;
 	unsigned long flags;
 	int neg_adj = 0;
 	u32 diff;
 	u64 adj;
 
-
 	if (delta < 0) {
 		neg_adj = 1;
 		delta = -delta;
 	}
 
-	adj = clock->nominal_c_mult;
+	adj = timer->nominal_c_mult;
 	adj *= delta;
 	diff = div_u64(adj, 1000000000ULL);
 
 	mdev = container_of(clock, struct mlx5_core_dev, clock);
 	write_seqlock_irqsave(&clock->lock, flags);
-	timecounter_read(&clock->tc);
-	clock->cycles.mult = neg_adj ? clock->nominal_c_mult - diff :
-				       clock->nominal_c_mult + diff;
+	timecounter_read(&timer->tc);
+	timer->cycles.mult = neg_adj ? timer->nominal_c_mult - diff :
+				       timer->nominal_c_mult + diff;
 	mlx5_update_clock_info_page(mdev);
 	write_sequnlock_irqrestore(&clock->lock, flags);
 
@@ -313,6 +327,7 @@ static int mlx5_perout_configure(struct ptp_clock_info *ptp,
 			container_of(ptp, struct mlx5_clock, ptp_info);
 	struct mlx5_core_dev *mdev =
 			container_of(clock, struct mlx5_core_dev, clock);
+	struct mlx5_timer *timer = &clock->timer;
 	u32 in[MLX5_ST_SZ_DW(mtpps_reg)] = {0};
 	u64 nsec_now, nsec_delta, time_stamp = 0;
 	u64 cycles_now, cycles_delta;
@@ -355,10 +370,10 @@ static int mlx5_perout_configure(struct ptp_clock_info *ptp,
 		ns = timespec64_to_ns(&ts);
 		cycles_now = mlx5_read_internal_timer(mdev, NULL);
 		write_seqlock_irqsave(&clock->lock, flags);
-		nsec_now = timecounter_cyc2time(&clock->tc, cycles_now);
+		nsec_now = timecounter_cyc2time(&timer->tc, cycles_now);
 		nsec_delta = ns - nsec_now;
-		cycles_delta = div64_u64(nsec_delta << clock->cycles.shift,
-					 clock->cycles.mult);
+		cycles_delta = div64_u64(nsec_delta << timer->cycles.shift,
+					 timer->cycles.mult);
 		write_sequnlock_irqrestore(&clock->lock, flags);
 		time_stamp = cycles_now + cycles_delta;
 		field_select = MLX5_MTPPS_FS_PIN_MODE |
@@ -541,6 +556,7 @@ static int mlx5_pps_event(struct notifier_block *nb,
 			  unsigned long type, void *data)
 {
 	struct mlx5_clock *clock = mlx5_nb_cof(nb, struct mlx5_clock, pps_nb);
+	struct mlx5_timer *timer = &clock->timer;
 	struct ptp_clock_event ptp_event;
 	u64 cycles_now, cycles_delta;
 	u64 nsec_now, nsec_delta, ns;
@@ -575,10 +591,10 @@ static int mlx5_pps_event(struct notifier_block *nb,
 		ts.tv_nsec = 0;
 		ns = timespec64_to_ns(&ts);
 		write_seqlock_irqsave(&clock->lock, flags);
-		nsec_now = timecounter_cyc2time(&clock->tc, cycles_now);
+		nsec_now = timecounter_cyc2time(&timer->tc, cycles_now);
 		nsec_delta = ns - nsec_now;
-		cycles_delta = div64_u64(nsec_delta << clock->cycles.shift,
-					 clock->cycles.mult);
+		cycles_delta = div64_u64(nsec_delta << timer->cycles.shift,
+					 timer->cycles.mult);
 		clock->pps_info.start[pin] = cycles_now + cycles_delta;
 		write_sequnlock_irqrestore(&clock->lock, flags);
 		schedule_work(&clock->pps_info.out_work);
@@ -591,29 +607,32 @@ static int mlx5_pps_event(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
-void mlx5_init_clock(struct mlx5_core_dev *mdev)
+static void mlx5_timecounter_init(struct mlx5_core_dev *mdev)
 {
 	struct mlx5_clock *clock = &mdev->clock;
-	u64 overflow_cycles;
-	u64 ns;
-	u64 frac = 0;
+	struct mlx5_timer *timer = &clock->timer;
 	u32 dev_freq;
 
 	dev_freq = MLX5_CAP_GEN(mdev, device_frequency_khz);
-	if (!dev_freq) {
-		mlx5_core_warn(mdev, "invalid device_frequency_khz, aborting HW clock init\n");
-		return;
-	}
-	seqlock_init(&clock->lock);
-	clock->cycles.read = read_internal_timer;
-	clock->cycles.shift = MLX5_CYCLES_SHIFT;
-	clock->cycles.mult = clocksource_khz2mult(dev_freq,
-						  clock->cycles.shift);
-	clock->nominal_c_mult = clock->cycles.mult;
-	clock->cycles.mask = CLOCKSOURCE_MASK(41);
-
-	timecounter_init(&clock->tc, &clock->cycles,
+	timer->cycles.read = read_internal_timer;
+	timer->cycles.shift = MLX5_CYCLES_SHIFT;
+	timer->cycles.mult = clocksource_khz2mult(dev_freq,
+						  timer->cycles.shift);
+	timer->nominal_c_mult = timer->cycles.mult;
+	timer->cycles.mask = CLOCKSOURCE_MASK(41);
+
+	timecounter_init(&timer->tc, &timer->cycles,
 			 ktime_to_ns(ktime_get_real()));
+}
+
+static void mlx5_init_overflow_period(struct mlx5_clock *clock)
+{
+	struct mlx5_core_dev *mdev = container_of(clock, struct mlx5_core_dev, clock);
+	struct mlx5_ib_clock_info *clock_info = mdev->clock_info;
+	struct mlx5_timer *timer = &clock->timer;
+	u64 overflow_cycles;
+	u64 frac = 0;
+	u64 ns;
 
 	/* Calculate period in seconds to call the overflow watchdog - to make
 	 * sure counter is checked at least twice every wrap around.
@@ -622,32 +641,63 @@ void mlx5_init_clock(struct mlx5_core_dev *mdev)
 	 * multiplied by clock multiplier where the result doesn't exceed
 	 * 64bits.
 	 */
-	overflow_cycles = div64_u64(~0ULL >> 1, clock->cycles.mult);
-	overflow_cycles = min(overflow_cycles, div_u64(clock->cycles.mask, 3));
+	overflow_cycles = div64_u64(~0ULL >> 1, timer->cycles.mult);
+	overflow_cycles = min(overflow_cycles, div_u64(timer->cycles.mask, 3));
 
-	ns = cyclecounter_cyc2ns(&clock->cycles, overflow_cycles,
+	ns = cyclecounter_cyc2ns(&timer->cycles, overflow_cycles,
 				 frac, &frac);
 	do_div(ns, NSEC_PER_SEC / HZ);
-	clock->overflow_period = ns;
+	timer->overflow_period = ns;
 
-	mdev->clock_info =
-		(struct mlx5_ib_clock_info *)get_zeroed_page(GFP_KERNEL);
-	if (mdev->clock_info) {
-		mdev->clock_info->nsec = clock->tc.nsec;
-		mdev->clock_info->cycles = clock->tc.cycle_last;
-		mdev->clock_info->mask = clock->cycles.mask;
-		mdev->clock_info->mult = clock->nominal_c_mult;
-		mdev->clock_info->shift = clock->cycles.shift;
-		mdev->clock_info->frac = clock->tc.frac;
-		mdev->clock_info->overflow_period = clock->overflow_period;
+	INIT_DELAYED_WORK(&timer->overflow_work, mlx5_timestamp_overflow);
+	if (timer->overflow_period)
+		schedule_delayed_work(&timer->overflow_work, 0);
+	else
+		mlx5_core_warn(mdev,
+			       "invalid overflow period, overflow_work is not scheduled\n");
+
+	if (clock_info)
+		clock_info->overflow_period = timer->overflow_period;
+}
+
+static void mlx5_init_clock_info(struct mlx5_core_dev *mdev)
+{
+	struct mlx5_clock *clock = &mdev->clock;
+	struct mlx5_ib_clock_info *info;
+	struct mlx5_timer *timer;
+
+	mdev->clock_info = (struct mlx5_ib_clock_info *)get_zeroed_page(GFP_KERNEL);
+	if (!mdev->clock_info) {
+		mlx5_core_warn(mdev, "Failed to allocate IB clock info page\n");
+		return;
 	}
 
+	info = mdev->clock_info;
+	timer = &clock->timer;
+
+	info->nsec = timer->tc.nsec;
+	info->cycles = timer->tc.cycle_last;
+	info->mask = timer->cycles.mask;
+	info->mult = timer->nominal_c_mult;
+	info->shift = timer->cycles.shift;
+	info->frac = timer->tc.frac;
+}
+
+void mlx5_init_clock(struct mlx5_core_dev *mdev)
+{
+	struct mlx5_clock *clock = &mdev->clock;
+
+	if (!MLX5_CAP_GEN(mdev, device_frequency_khz)) {
+		mlx5_core_warn(mdev, "invalid device_frequency_khz, aborting HW clock init\n");
+		return;
+	}
+
+	seqlock_init(&clock->lock);
+
+	mlx5_timecounter_init(mdev);
+	mlx5_init_clock_info(mdev);
+	mlx5_init_overflow_period(clock);
 	INIT_WORK(&clock->pps_info.out_work, mlx5_pps_out);
-	INIT_DELAYED_WORK(&clock->overflow_work, mlx5_timestamp_overflow);
-	if (clock->overflow_period)
-		schedule_delayed_work(&clock->overflow_work, 0);
-	else
-		mlx5_core_warn(mdev, "invalid overflow period, overflow_work is not scheduled\n");
 
 	/* Configure the PHC */
 	clock->ptp_info = mlx5_ptp_clock_info;
@@ -684,7 +734,7 @@ void mlx5_cleanup_clock(struct mlx5_core_dev *mdev)
 	}
 
 	cancel_work_sync(&clock->pps_info.out_work);
-	cancel_delayed_work_sync(&clock->overflow_work);
+	cancel_delayed_work_sync(&clock->timer.overflow_work);
 
 	if (mdev->clock_info) {
 		free_page((unsigned long)mdev->clock_info);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.h
index 31600924bdc3..6e8804ebc773 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.h
@@ -45,12 +45,13 @@ static inline int mlx5_clock_get_ptp_index(struct mlx5_core_dev *mdev)
 static inline ktime_t mlx5_timecounter_cyc2time(struct mlx5_clock *clock,
 						u64 timestamp)
 {
+	struct mlx5_timer *timer = &clock->timer;
 	unsigned int seq;
 	u64 nsec;
 
 	do {
 		seq = read_seqbegin(&clock->lock);
-		nsec = timecounter_cyc2time(&clock->tc, timestamp);
+		nsec = timecounter_cyc2time(&timer->tc, timestamp);
 	} while (read_seqretry(&clock->lock, seq));
 
 	return ns_to_ktime(nsec);
diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 4fdb970e3482..2ad15b1d7ffd 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -159,6 +159,19 @@ static struct macsec_rx_sa *macsec_rxsa_get(struct macsec_rx_sa __rcu *ptr)
 	return sa;
 }
 
+static struct macsec_rx_sa *macsec_active_rxsa_get(struct macsec_rx_sc *rx_sc)
+{
+	struct macsec_rx_sa *sa = NULL;
+	int an;
+
+	for (an = 0; an < MACSEC_NUM_AN; an++)	{
+		sa = macsec_rxsa_get(rx_sc->sa[an]);
+		if (sa)
+			break;
+	}
+	return sa;
+}
+
 static void free_rx_sc_rcu(struct rcu_head *head)
 {
 	struct macsec_rx_sc *rx_sc = container_of(head, struct macsec_rx_sc, rcu_head);
@@ -497,18 +510,28 @@ static void macsec_encrypt_finish(struct sk_buff *skb, struct net_device *dev)
 	skb->protocol = eth_hdr(skb)->h_proto;
 }
 
+static unsigned int macsec_msdu_len(struct sk_buff *skb)
+{
+	struct macsec_dev *macsec = macsec_priv(skb->dev);
+	struct macsec_secy *secy = &macsec->secy;
+	bool sci_present = macsec_skb_cb(skb)->has_sci;
+
+	return skb->len - macsec_hdr_len(sci_present) - secy->icv_len;
+}
+
 static void macsec_count_tx(struct sk_buff *skb, struct macsec_tx_sc *tx_sc,
 			    struct macsec_tx_sa *tx_sa)
 {
+	unsigned int msdu_len = macsec_msdu_len(skb);
 	struct pcpu_tx_sc_stats *txsc_stats = this_cpu_ptr(tx_sc->stats);
 
 	u64_stats_update_begin(&txsc_stats->syncp);
 	if (tx_sc->encrypt) {
-		txsc_stats->stats.OutOctetsEncrypted += skb->len;
+		txsc_stats->stats.OutOctetsEncrypted += msdu_len;
 		txsc_stats->stats.OutPktsEncrypted++;
 		this_cpu_inc(tx_sa->stats->OutPktsEncrypted);
 	} else {
-		txsc_stats->stats.OutOctetsProtected += skb->len;
+		txsc_stats->stats.OutOctetsProtected += msdu_len;
 		txsc_stats->stats.OutPktsProtected++;
 		this_cpu_inc(tx_sa->stats->OutPktsProtected);
 	}
@@ -538,9 +561,10 @@ static void macsec_encrypt_done(struct crypto_async_request *base, int err)
 	aead_request_free(macsec_skb_cb(skb)->req);
 
 	rcu_read_lock_bh();
-	macsec_encrypt_finish(skb, dev);
 	macsec_count_tx(skb, &macsec->secy.tx_sc, macsec_skb_cb(skb)->tx_sa);
-	len = skb->len;
+	/* packet is encrypted/protected so tx_bytes must be calculated */
+	len = macsec_msdu_len(skb) + 2 * ETH_ALEN;
+	macsec_encrypt_finish(skb, dev);
 	ret = dev_queue_xmit(skb);
 	count_tx(dev, ret, len);
 	rcu_read_unlock_bh();
@@ -699,6 +723,7 @@ static struct sk_buff *macsec_encrypt(struct sk_buff *skb,
 
 	macsec_skb_cb(skb)->req = req;
 	macsec_skb_cb(skb)->tx_sa = tx_sa;
+	macsec_skb_cb(skb)->has_sci = sci_present;
 	aead_request_set_callback(req, 0, macsec_encrypt_done, skb);
 
 	dev_hold(skb->dev);
@@ -740,15 +765,17 @@ static bool macsec_post_decrypt(struct sk_buff *skb, struct macsec_secy *secy, u
 		u64_stats_update_begin(&rxsc_stats->syncp);
 		rxsc_stats->stats.InPktsLate++;
 		u64_stats_update_end(&rxsc_stats->syncp);
+		DEV_STATS_INC(secy->netdev, rx_dropped);
 		return false;
 	}
 
 	if (secy->validate_frames != MACSEC_VALIDATE_DISABLED) {
+		unsigned int msdu_len = macsec_msdu_len(skb);
 		u64_stats_update_begin(&rxsc_stats->syncp);
 		if (hdr->tci_an & MACSEC_TCI_E)
-			rxsc_stats->stats.InOctetsDecrypted += skb->len;
+			rxsc_stats->stats.InOctetsDecrypted += msdu_len;
 		else
-			rxsc_stats->stats.InOctetsValidated += skb->len;
+			rxsc_stats->stats.InOctetsValidated += msdu_len;
 		u64_stats_update_end(&rxsc_stats->syncp);
 	}
 
@@ -761,6 +788,8 @@ static bool macsec_post_decrypt(struct sk_buff *skb, struct macsec_secy *secy, u
 			u64_stats_update_begin(&rxsc_stats->syncp);
 			rxsc_stats->stats.InPktsNotValid++;
 			u64_stats_update_end(&rxsc_stats->syncp);
+			this_cpu_inc(rx_sa->stats->InPktsNotValid);
+			DEV_STATS_INC(secy->netdev, rx_errors);
 			return false;
 		}
 
@@ -853,9 +882,9 @@ static void macsec_decrypt_done(struct crypto_async_request *base, int err)
 
 	macsec_finalize_skb(skb, macsec->secy.icv_len,
 			    macsec_extra_len(macsec_skb_cb(skb)->has_sci));
+	len = skb->len;
 	macsec_reset_skb(skb, macsec->secy.netdev);
 
-	len = skb->len;
 	if (gro_cells_receive(&macsec->gro_cells, skb) == NET_RX_SUCCESS)
 		count_rx(dev, len);
 
@@ -1046,6 +1075,7 @@ static enum rx_handler_result handle_not_macsec(struct sk_buff *skb)
 			u64_stats_update_begin(&secy_stats->syncp);
 			secy_stats->stats.InPktsNoTag++;
 			u64_stats_update_end(&secy_stats->syncp);
+			DEV_STATS_INC(macsec->secy.netdev, rx_dropped);
 			continue;
 		}
 
@@ -1155,6 +1185,7 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 		u64_stats_update_begin(&secy_stats->syncp);
 		secy_stats->stats.InPktsBadTag++;
 		u64_stats_update_end(&secy_stats->syncp);
+		DEV_STATS_INC(secy->netdev, rx_errors);
 		goto drop_nosa;
 	}
 
@@ -1165,11 +1196,15 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 		/* If validateFrames is Strict or the C bit in the
 		 * SecTAG is set, discard
 		 */
+		struct macsec_rx_sa *active_rx_sa = macsec_active_rxsa_get(rx_sc);
 		if (hdr->tci_an & MACSEC_TCI_C ||
 		    secy->validate_frames == MACSEC_VALIDATE_STRICT) {
 			u64_stats_update_begin(&rxsc_stats->syncp);
 			rxsc_stats->stats.InPktsNotUsingSA++;
 			u64_stats_update_end(&rxsc_stats->syncp);
+			DEV_STATS_INC(secy->netdev, rx_errors);
+			if (active_rx_sa)
+				this_cpu_inc(active_rx_sa->stats->InPktsNotUsingSA);
 			goto drop_nosa;
 		}
 
@@ -1179,6 +1214,8 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 		u64_stats_update_begin(&rxsc_stats->syncp);
 		rxsc_stats->stats.InPktsUnusedSA++;
 		u64_stats_update_end(&rxsc_stats->syncp);
+		if (active_rx_sa)
+			this_cpu_inc(active_rx_sa->stats->InPktsUnusedSA);
 		goto deliver;
 	}
 
@@ -1199,6 +1236,7 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 			u64_stats_update_begin(&rxsc_stats->syncp);
 			rxsc_stats->stats.InPktsLate++;
 			u64_stats_update_end(&rxsc_stats->syncp);
+			DEV_STATS_INC(macsec->secy.netdev, rx_dropped);
 			goto drop;
 		}
 	}
@@ -1227,6 +1265,7 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 deliver:
 	macsec_finalize_skb(skb, secy->icv_len,
 			    macsec_extra_len(macsec_skb_cb(skb)->has_sci));
+	len = skb->len;
 	macsec_reset_skb(skb, secy->netdev);
 
 	if (rx_sa)
@@ -1234,12 +1273,11 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 	macsec_rxsc_put(rx_sc);
 
 	skb_orphan(skb);
-	len = skb->len;
 	ret = gro_cells_receive(&macsec->gro_cells, skb);
 	if (ret == NET_RX_SUCCESS)
 		count_rx(dev, len);
 	else
-		macsec->secy.netdev->stats.rx_dropped++;
+		DEV_STATS_INC(macsec->secy.netdev, rx_dropped);
 
 	rcu_read_unlock();
 
@@ -1276,6 +1314,7 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 			u64_stats_update_begin(&secy_stats->syncp);
 			secy_stats->stats.InPktsNoSCI++;
 			u64_stats_update_end(&secy_stats->syncp);
+			DEV_STATS_INC(macsec->secy.netdev, rx_errors);
 			continue;
 		}
 
@@ -1294,7 +1333,7 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 			secy_stats->stats.InPktsUnknownSCI++;
 			u64_stats_update_end(&secy_stats->syncp);
 		} else {
-			macsec->secy.netdev->stats.rx_dropped++;
+			DEV_STATS_INC(macsec->secy.netdev, rx_dropped);
 		}
 	}
 
@@ -3403,21 +3442,21 @@ static netdev_tx_t macsec_start_xmit(struct sk_buff *skb,
 
 	if (!secy->operational) {
 		kfree_skb(skb);
-		dev->stats.tx_dropped++;
+		DEV_STATS_INC(dev, tx_dropped);
 		return NETDEV_TX_OK;
 	}
 
+	len = skb->len;
 	skb = macsec_encrypt(skb, dev);
 	if (IS_ERR(skb)) {
 		if (PTR_ERR(skb) != -EINPROGRESS)
-			dev->stats.tx_dropped++;
+			DEV_STATS_INC(dev, tx_dropped);
 		return NETDEV_TX_OK;
 	}
 
 	macsec_count_tx(skb, &macsec->secy.tx_sc, macsec_skb_cb(skb)->tx_sa);
 
 	macsec_encrypt_finish(skb, dev);
-	len = skb->len;
 	ret = dev_queue_xmit(skb);
 	count_tx(dev, ret, len);
 	return ret;
@@ -3646,8 +3685,9 @@ static void macsec_get_stats64(struct net_device *dev,
 
 	dev_fetch_sw_netstats(s, dev->tstats);
 
-	s->rx_dropped = dev->stats.rx_dropped;
-	s->tx_dropped = dev->stats.tx_dropped;
+	s->rx_dropped = atomic_long_read(&dev->stats.__rx_dropped);
+	s->tx_dropped = atomic_long_read(&dev->stats.__tx_dropped);
+	s->rx_errors = atomic_long_read(&dev->stats.__rx_errors);
 }
 
 static int macsec_get_iflink(const struct net_device *dev)
diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
index 0cde17bd743f..a664faa8f01f 100644
--- a/drivers/net/phy/broadcom.c
+++ b/drivers/net/phy/broadcom.c
@@ -404,6 +404,17 @@ static int bcm54xx_resume(struct phy_device *phydev)
 	return bcm54xx_config_init(phydev);
 }
 
+static int bcm54810_read_mmd(struct phy_device *phydev, int devnum, u16 regnum)
+{
+	return -EOPNOTSUPP;
+}
+
+static int bcm54810_write_mmd(struct phy_device *phydev, int devnum, u16 regnum,
+			      u16 val)
+{
+	return -EOPNOTSUPP;
+}
+
 static int bcm54811_config_init(struct phy_device *phydev)
 {
 	int err, reg;
@@ -841,6 +852,8 @@ static struct phy_driver broadcom_drivers[] = {
 	.phy_id_mask    = 0xfffffff0,
 	.name           = "Broadcom BCM54810",
 	/* PHY_GBIT_FEATURES */
+	.read_mmd	= bcm54810_read_mmd,
+	.write_mmd	= bcm54810_write_mmd,
 	.config_init    = bcm54xx_config_init,
 	.config_aneg    = bcm5481_config_aneg,
 	.ack_interrupt  = bcm_phy_ack_intr,
diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
index 36c7eae776d4..721b536ce886 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -2195,7 +2195,9 @@ static void team_setup(struct net_device *dev)
 
 	dev->hw_features = TEAM_VLAN_FEATURES |
 			   NETIF_F_HW_VLAN_CTAG_RX |
-			   NETIF_F_HW_VLAN_CTAG_FILTER;
+			   NETIF_F_HW_VLAN_CTAG_FILTER |
+			   NETIF_F_HW_VLAN_STAG_RX |
+			   NETIF_F_HW_VLAN_STAG_FILTER;
 
 	dev->hw_features |= NETIF_F_GSO_ENCAP_ALL | NETIF_F_GSO_UDP_L4;
 	dev->features |= dev->hw_features;
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 165149bcf0b1..2fd5d2b7a209 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3220,8 +3220,6 @@ static int virtnet_probe(struct virtio_device *vdev)
 		}
 	}
 
-	_virtnet_set_queues(vi, vi->curr_queue_pairs);
-
 	/* serialize netdev register + virtio_device_ready() with ndo_open() */
 	rtnl_lock();
 
@@ -3234,6 +3232,8 @@ static int virtnet_probe(struct virtio_device *vdev)
 
 	virtio_device_ready(vdev);
 
+	_virtnet_set_queues(vi, vi->curr_queue_pairs);
+
 	rtnl_unlock();
 
 	err = virtnet_cpu_notif_add(vi);
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 1222f5749bc6..a215777df96c 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -239,6 +239,7 @@
 #define EP_STATE_ENABLED	1
 
 static const unsigned int pcie_gen_freq[] = {
+	GEN1_CORE_CLK_FREQ,	/* PCI_EXP_LNKSTA_CLS == 0; undefined */
 	GEN1_CORE_CLK_FREQ,
 	GEN2_CORE_CLK_FREQ,
 	GEN3_CORE_CLK_FREQ,
@@ -470,7 +471,11 @@ static irqreturn_t tegra_pcie_ep_irq_thread(int irq, void *arg)
 
 	speed = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA) &
 		PCI_EXP_LNKSTA_CLS;
-	clk_set_rate(pcie->core_clk, pcie_gen_freq[speed - 1]);
+
+	if (speed >= ARRAY_SIZE(pcie_gen_freq))
+		speed = 0;
+
+	clk_set_rate(pcie->core_clk, pcie_gen_freq[speed]);
 
 	/* If EP doesn't advertise L1SS, just return */
 	val = dw_pcie_readl_dbi(pci, pcie->cfg_link_cap_l1sub);
@@ -973,7 +978,11 @@ static int tegra_pcie_dw_host_init(struct pcie_port *pp)
 
 	speed = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA) &
 		PCI_EXP_LNKSTA_CLS;
-	clk_set_rate(pcie->core_clk, pcie_gen_freq[speed - 1]);
+
+	if (speed >= ARRAY_SIZE(pcie_gen_freq))
+		speed = 0;
+
+	clk_set_rate(pcie->core_clk, pcie_gen_freq[speed]);
 
 	tegra_pcie_enable_interrupts(pp);
 
diff --git a/drivers/pcmcia/rsrc_nonstatic.c b/drivers/pcmcia/rsrc_nonstatic.c
index 69a6e9a5d6d2..6e90927e6576 100644
--- a/drivers/pcmcia/rsrc_nonstatic.c
+++ b/drivers/pcmcia/rsrc_nonstatic.c
@@ -1053,6 +1053,8 @@ static void nonstatic_release_resource_db(struct pcmcia_socket *s)
 		q = p->next;
 		kfree(p);
 	}
+
+	kfree(data);
 }
 
 
diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index d439afef9212..94c963462d74 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2159,12 +2159,13 @@ static void gsm_error(struct gsm_mux *gsm,
 static void gsm_cleanup_mux(struct gsm_mux *gsm, bool disc)
 {
 	int i;
-	struct gsm_dlci *dlci = gsm->dlci[0];
+	struct gsm_dlci *dlci;
 	struct gsm_msg *txq, *ntxq;
 
 	gsm->dead = true;
 	mutex_lock(&gsm->mutex);
 
+	dlci = gsm->dlci[0];
 	if (dlci) {
 		if (disc && dlci->state != DLCI_CLOSED) {
 			gsm_dlci_begin_close(dlci);
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 432a438929e6..7499954c9aa7 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3231,6 +3231,7 @@ void serial8250_init_port(struct uart_8250_port *up)
 	struct uart_port *port = &up->port;
 
 	spin_lock_init(&port->lock);
+	port->pm = NULL;
 	port->ops = &serial8250_pops;
 	port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_8250_CONSOLE);
 
diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index a4cf00756681..227fb2d32046 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1062,8 +1062,8 @@ static void lpuart_copy_rx_to_tty(struct lpuart_port *sport)
 		unsigned long sr = lpuart32_read(&sport->port, UARTSTAT);
 
 		if (sr & (UARTSTAT_PE | UARTSTAT_FE)) {
-			/* Read DR to clear the error flags */
-			lpuart32_read(&sport->port, UARTDATA);
+			/* Clear the error flags */
+			lpuart32_write(&sport->port, sr, UARTSTAT);
 
 			if (sr & UARTSTAT_PE)
 				sport->port.icount.parity++;
diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
index e3a8b6c71aa1..210c1d615082 100644
--- a/drivers/usb/cdns3/gadget.c
+++ b/drivers/usb/cdns3/gadget.c
@@ -2041,7 +2041,7 @@ int cdns3_ep_config(struct cdns3_endpoint *priv_ep, bool enable)
 	u8 mult = 0;
 	int ret;
 
-	buffering = CDNS3_EP_BUF_SIZE - 1;
+	buffering = priv_dev->ep_buf_size - 1;
 
 	cdns3_configure_dmult(priv_dev, priv_ep);
 
@@ -2060,7 +2060,7 @@ int cdns3_ep_config(struct cdns3_endpoint *priv_ep, bool enable)
 		break;
 	default:
 		ep_cfg = EP_CFG_EPTYPE(USB_ENDPOINT_XFER_ISOC);
-		mult = CDNS3_EP_ISO_HS_MULT - 1;
+		mult = priv_dev->ep_iso_burst - 1;
 		buffering = mult + 1;
 	}
 
@@ -2076,14 +2076,14 @@ int cdns3_ep_config(struct cdns3_endpoint *priv_ep, bool enable)
 		mult = 0;
 		max_packet_size = 1024;
 		if (priv_ep->type == USB_ENDPOINT_XFER_ISOC) {
-			maxburst = CDNS3_EP_ISO_SS_BURST - 1;
+			maxburst = priv_dev->ep_iso_burst - 1;
 			buffering = (mult + 1) *
 				    (maxburst + 1);
 
 			if (priv_ep->interval > 1)
 				buffering++;
 		} else {
-			maxburst = CDNS3_EP_BUF_SIZE - 1;
+			maxburst = priv_dev->ep_buf_size - 1;
 		}
 		break;
 	default:
@@ -2098,6 +2098,23 @@ int cdns3_ep_config(struct cdns3_endpoint *priv_ep, bool enable)
 	else
 		priv_ep->trb_burst_size = 16;
 
+	/*
+	 * In versions preceding DEV_VER_V2, for example, iMX8QM, there exit the bugs
+	 * in the DMA. These bugs occur when the trb_burst_size exceeds 16 and the
+	 * address is not aligned to 128 Bytes (which is a product of the 64-bit AXI
+	 * and AXI maximum burst length of 16 or 0xF+1, dma_axi_ctrl0[3:0]). This
+	 * results in data corruption when it crosses the 4K border. The corruption
+	 * specifically occurs from the position (4K - (address & 0x7F)) to 4K.
+	 *
+	 * So force trb_burst_size to 16 at such platform.
+	 */
+	if (priv_dev->dev_ver < DEV_VER_V2)
+		priv_ep->trb_burst_size = 16;
+
+	mult = min_t(u8, mult, EP_CFG_MULT_MAX);
+	buffering = min_t(u8, buffering, EP_CFG_BUFFERING_MAX);
+	maxburst = min_t(u8, maxburst, EP_CFG_MAXBURST_MAX);
+
 	/* onchip buffer is only allocated before configuration */
 	if (!priv_dev->hw_configured_flag) {
 		ret = cdns3_ep_onchip_buffer_reserve(priv_dev, buffering + 1,
@@ -2971,6 +2988,40 @@ static int cdns3_gadget_udc_stop(struct usb_gadget *gadget)
 	return 0;
 }
 
+/**
+ * cdns3_gadget_check_config - ensure cdns3 can support the USB configuration
+ * @gadget: pointer to the USB gadget
+ *
+ * Used to record the maximum number of endpoints being used in a USB composite
+ * device. (across all configurations)  This is to be used in the calculation
+ * of the TXFIFO sizes when resizing internal memory for individual endpoints.
+ * It will help ensured that the resizing logic reserves enough space for at
+ * least one max packet.
+ */
+static int cdns3_gadget_check_config(struct usb_gadget *gadget)
+{
+	struct cdns3_device *priv_dev = gadget_to_cdns3_device(gadget);
+	struct usb_ep *ep;
+	int n_in = 0;
+	int total;
+
+	list_for_each_entry(ep, &gadget->ep_list, ep_list) {
+		if (ep->claimed && (ep->address & USB_DIR_IN))
+			n_in++;
+	}
+
+	/* 2KB are reserved for EP0, 1KB for out*/
+	total = 2 + n_in + 1;
+
+	if (total > priv_dev->onchip_buffers)
+		return -ENOMEM;
+
+	priv_dev->ep_buf_size = priv_dev->ep_iso_burst =
+			(priv_dev->onchip_buffers - 2) / (n_in + 1);
+
+	return 0;
+}
+
 static const struct usb_gadget_ops cdns3_gadget_ops = {
 	.get_frame = cdns3_gadget_get_frame,
 	.wakeup = cdns3_gadget_wakeup,
@@ -2979,6 +3030,7 @@ static const struct usb_gadget_ops cdns3_gadget_ops = {
 	.udc_start = cdns3_gadget_udc_start,
 	.udc_stop = cdns3_gadget_udc_stop,
 	.match_ep = cdns3_gadget_match_ep,
+	.check_config = cdns3_gadget_check_config,
 };
 
 static void cdns3_free_all_eps(struct cdns3_device *priv_dev)
diff --git a/drivers/usb/cdns3/gadget.h b/drivers/usb/cdns3/gadget.h
index 21fa461c518e..32825477edd3 100644
--- a/drivers/usb/cdns3/gadget.h
+++ b/drivers/usb/cdns3/gadget.h
@@ -561,15 +561,18 @@ struct cdns3_usb_regs {
 /* Max burst size (used only in SS mode). */
 #define EP_CFG_MAXBURST_MASK	GENMASK(11, 8)
 #define EP_CFG_MAXBURST(p)	(((p) << 8) & EP_CFG_MAXBURST_MASK)
+#define EP_CFG_MAXBURST_MAX	15
 /* ISO max burst. */
 #define EP_CFG_MULT_MASK	GENMASK(15, 14)
 #define EP_CFG_MULT(p)		(((p) << 14) & EP_CFG_MULT_MASK)
+#define EP_CFG_MULT_MAX		2
 /* ISO max burst. */
 #define EP_CFG_MAXPKTSIZE_MASK	GENMASK(26, 16)
 #define EP_CFG_MAXPKTSIZE(p)	(((p) << 16) & EP_CFG_MAXPKTSIZE_MASK)
 /* Max number of buffered packets. */
 #define EP_CFG_BUFFERING_MASK	GENMASK(31, 27)
 #define EP_CFG_BUFFERING(p)	(((p) << 27) & EP_CFG_BUFFERING_MASK)
+#define EP_CFG_BUFFERING_MAX	15
 
 /* EP_CMD - bitmasks */
 /* Endpoint reset. */
@@ -1093,9 +1096,6 @@ struct cdns3_trb {
 #define CDNS3_ENDPOINTS_MAX_COUNT	32
 #define CDNS3_EP_ZLP_BUF_SIZE		1024
 
-#define CDNS3_EP_BUF_SIZE		4	/* KB */
-#define CDNS3_EP_ISO_HS_MULT		3
-#define CDNS3_EP_ISO_SS_BURST		3
 #define CDNS3_MAX_NUM_DESCMISS_BUF	32
 #define CDNS3_DESCMIS_BUF_SIZE		2048	/* Bytes */
 #define CDNS3_WA2_NUM_BUFFERS		128
@@ -1330,6 +1330,9 @@ struct cdns3_device {
 	/*in KB */
 	u16				onchip_buffers;
 	u16				onchip_used_size;
+
+	u16				ep_buf_size;
+	u16				ep_iso_burst;
 };
 
 void cdns3_set_register_bit(void __iomem *ptr, u32 mask);
diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
index f79845594284..4d47fe89864d 100644
--- a/drivers/usb/chipidea/ci_hdrc_imx.c
+++ b/drivers/usb/chipidea/ci_hdrc_imx.c
@@ -70,6 +70,10 @@ static const struct ci_hdrc_imx_platform_flag imx7ulp_usb_data = {
 		CI_HDRC_PMQOS,
 };
 
+static const struct ci_hdrc_imx_platform_flag imx8ulp_usb_data = {
+	.flags = CI_HDRC_SUPPORTS_RUNTIME_PM,
+};
+
 static const struct of_device_id ci_hdrc_imx_dt_ids[] = {
 	{ .compatible = "fsl,imx23-usb", .data = &imx23_usb_data},
 	{ .compatible = "fsl,imx28-usb", .data = &imx28_usb_data},
@@ -80,6 +84,7 @@ static const struct of_device_id ci_hdrc_imx_dt_ids[] = {
 	{ .compatible = "fsl,imx6ul-usb", .data = &imx6ul_usb_data},
 	{ .compatible = "fsl,imx7d-usb", .data = &imx7d_usb_data},
 	{ .compatible = "fsl,imx7ulp-usb", .data = &imx7ulp_usb_data},
+	{ .compatible = "fsl,imx8ulp-usb", .data = &imx8ulp_usb_data},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, ci_hdrc_imx_dt_ids);
diff --git a/drivers/usb/chipidea/usbmisc_imx.c b/drivers/usb/chipidea/usbmisc_imx.c
index 425b29168b4d..9b1d5c11dc34 100644
--- a/drivers/usb/chipidea/usbmisc_imx.c
+++ b/drivers/usb/chipidea/usbmisc_imx.c
@@ -135,7 +135,7 @@
 #define TXVREFTUNE0_MASK		(0xf << 20)
 
 #define MX6_USB_OTG_WAKEUP_BITS (MX6_BM_WAKEUP_ENABLE | MX6_BM_VBUS_WAKEUP | \
-				 MX6_BM_ID_WAKEUP)
+				 MX6_BM_ID_WAKEUP | MX6SX_BM_DPDM_WAKEUP_EN)
 
 struct usbmisc_ops {
 	/* It's called once when probe a usb device */
diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index ec8c43231746..3973f6c18857 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -306,7 +306,16 @@ static void dwc3_qcom_interconnect_exit(struct dwc3_qcom *qcom)
 /* Only usable in contexts where the role can not change. */
 static bool dwc3_qcom_is_host(struct dwc3_qcom *qcom)
 {
-	struct dwc3 *dwc = platform_get_drvdata(qcom->dwc3);
+	struct dwc3 *dwc;
+
+	/*
+	 * FIXME: Fix this layering violation.
+	 */
+	dwc = platform_get_drvdata(qcom->dwc3);
+
+	/* Core driver may not have probed yet. */
+	if (!dwc)
+		return false;
 
 	return dwc->xhci;
 }
diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
index 3b5a6430e241..a717b53847a8 100644
--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -917,8 +917,11 @@ static void __gs_console_push(struct gs_console *cons)
 	}
 
 	req->length = size;
+
+	spin_unlock_irq(&cons->lock);
 	if (usb_ep_queue(ep, req, GFP_ATOMIC))
 		req->length = 0;
+	spin_lock_irq(&cons->lock);
 }
 
 static void gs_console_work(struct work_struct *work)
diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index 3a3b5a03dda7..14d9d1ee16fc 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -1004,6 +1004,25 @@ int usb_gadget_ep_match_desc(struct usb_gadget *gadget,
 }
 EXPORT_SYMBOL_GPL(usb_gadget_ep_match_desc);
 
+/**
+ * usb_gadget_check_config - checks if the UDC can support the binded
+ *	configuration
+ * @gadget: controller to check the USB configuration
+ *
+ * Ensure that a UDC is able to support the requested resources by a
+ * configuration, and that there are no resource limitations, such as
+ * internal memory allocated to all requested endpoints.
+ *
+ * Returns zero on success, else a negative errno.
+ */
+int usb_gadget_check_config(struct usb_gadget *gadget)
+{
+	if (gadget->ops->check_config)
+		return gadget->ops->check_config(gadget);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(usb_gadget_check_config);
+
 /* ------------------------------------------------------------------------- */
 
 static void usb_gadget_state_work(struct work_struct *work)
diff --git a/drivers/video/fbdev/mmp/hw/mmp_ctrl.c b/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
index 061a105afb86..27c3ee5df8de 100644
--- a/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
+++ b/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
@@ -518,7 +518,9 @@ static int mmphw_probe(struct platform_device *pdev)
 		ret = -ENOENT;
 		goto failed;
 	}
-	clk_prepare_enable(ctrl->clk);
+	ret = clk_prepare_enable(ctrl->clk);
+	if (ret)
+		goto failed;
 
 	/* init global regs */
 	ctrl_set_default(ctrl);
diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index e8ef0c66e558..136f90dbad83 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -571,11 +571,9 @@ static void virtio_mmio_release_dev(struct device *_d)
 {
 	struct virtio_device *vdev =
 			container_of(_d, struct virtio_device, dev);
-	struct virtio_mmio_device *vm_dev =
-			container_of(vdev, struct virtio_mmio_device, vdev);
-	struct platform_device *pdev = vm_dev->pdev;
+	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
 
-	devm_kfree(&pdev->dev, vm_dev);
+	kfree(vm_dev);
 }
 
 /* Platform device */
@@ -586,7 +584,7 @@ static int virtio_mmio_probe(struct platform_device *pdev)
 	unsigned long magic;
 	int rc;
 
-	vm_dev = devm_kzalloc(&pdev->dev, sizeof(*vm_dev), GFP_KERNEL);
+	vm_dev = kzalloc(sizeof(*vm_dev), GFP_KERNEL);
 	if (!vm_dev)
 		return -ENOMEM;
 
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 83dca79ff042..b798586263eb 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4460,8 +4460,7 @@ int btrfs_cancel_balance(struct btrfs_fs_info *fs_info)
 		}
 	}
 
-	BUG_ON(fs_info->balance_ctl ||
-		test_bit(BTRFS_FS_BALANCE_RUNNING, &fs_info->flags));
+	ASSERT(!test_bit(BTRFS_FS_BALANCE_RUNNING, &fs_info->flags));
 	atomic_dec(&fs_info->balance_cancel_req);
 	mutex_unlock(&fs_info->balance_mutex);
 	return 0;
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 5fe85dc0e265..a56738244f3a 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -4580,9 +4580,9 @@ static int cifs_readpage_worker(struct file *file, struct page *page,
 
 io_error:
 	kunmap(page);
-	unlock_page(page);
 
 read_complete:
+	unlock_page(page);
 	return rc;
 }
 
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index e01b6a2d12d3..b61de8dab51a 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -1017,7 +1017,14 @@ static int gfs2_show_options(struct seq_file *s, struct dentry *root)
 {
 	struct gfs2_sbd *sdp = root->d_sb->s_fs_info;
 	struct gfs2_args *args = &sdp->sd_args;
-	int val;
+	unsigned int logd_secs, statfs_slow, statfs_quantum, quota_quantum;
+
+	spin_lock(&sdp->sd_tune.gt_spin);
+	logd_secs = sdp->sd_tune.gt_logd_secs;
+	quota_quantum = sdp->sd_tune.gt_quota_quantum;
+	statfs_quantum = sdp->sd_tune.gt_statfs_quantum;
+	statfs_slow = sdp->sd_tune.gt_statfs_slow;
+	spin_unlock(&sdp->sd_tune.gt_spin);
 
 	if (is_ancestor(root, sdp->sd_master_dir))
 		seq_puts(s, ",meta");
@@ -1072,17 +1079,14 @@ static int gfs2_show_options(struct seq_file *s, struct dentry *root)
 	}
 	if (args->ar_discard)
 		seq_puts(s, ",discard");
-	val = sdp->sd_tune.gt_logd_secs;
-	if (val != 30)
-		seq_printf(s, ",commit=%d", val);
-	val = sdp->sd_tune.gt_statfs_quantum;
-	if (val != 30)
-		seq_printf(s, ",statfs_quantum=%d", val);
-	else if (sdp->sd_tune.gt_statfs_slow)
+	if (logd_secs != 30)
+		seq_printf(s, ",commit=%d", logd_secs);
+	if (statfs_quantum != 30)
+		seq_printf(s, ",statfs_quantum=%d", statfs_quantum);
+	else if (statfs_slow)
 		seq_puts(s, ",statfs_quantum=0");
-	val = sdp->sd_tune.gt_quota_quantum;
-	if (val != 60)
-		seq_printf(s, ",quota_quantum=%d", val);
+	if (quota_quantum != 60)
+		seq_printf(s, ",quota_quantum=%d", quota_quantum);
 	if (args->ar_statfs_percent)
 		seq_printf(s, ",statfs_percent=%d", args->ar_statfs_percent);
 	if (args->ar_errors != GFS2_ERRORS_DEFAULT) {
diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index bd9af2be352f..cef3303d9499 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -2027,6 +2027,9 @@ dbAllocDmapLev(struct bmap * bmp,
 	if (dbFindLeaf((dmtree_t *) & dp->tree, l2nb, &leafidx))
 		return -ENOSPC;
 
+	if (leafidx < 0)
+		return -EIO;
+
 	/* determine the block number within the file system corresponding
 	 * to the leaf at which free space was found.
 	 */
diff --git a/fs/jfs/jfs_txnmgr.c b/fs/jfs/jfs_txnmgr.c
index c8ce7f1bc594..6f6a5b9203d3 100644
--- a/fs/jfs/jfs_txnmgr.c
+++ b/fs/jfs/jfs_txnmgr.c
@@ -354,6 +354,11 @@ tid_t txBegin(struct super_block *sb, int flag)
 	jfs_info("txBegin: flag = 0x%x", flag);
 	log = JFS_SBI(sb)->log;
 
+	if (!log) {
+		jfs_error(sb, "read-only filesystem\n");
+		return 0;
+	}
+
 	TXN_LOCK();
 
 	INCREMENT(TxStat.txBegin);
diff --git a/fs/jfs/namei.c b/fs/jfs/namei.c
index 7a55d14cc1af..f155ad6650bd 100644
--- a/fs/jfs/namei.c
+++ b/fs/jfs/namei.c
@@ -798,6 +798,11 @@ static int jfs_link(struct dentry *old_dentry,
 	if (rc)
 		goto out;
 
+	if (isReadOnly(ip)) {
+		jfs_error(ip->i_sb, "read-only filesystem\n");
+		return -EROFS;
+	}
+
 	tid = txBegin(ip->i_sb, 0);
 
 	mutex_lock_nested(&JFS_IP(dir)->commit_mutex, COMMIT_MUTEX_PARENT);
diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
index b208eba5d0b6..b58a0140d78d 100644
--- a/fs/overlayfs/ovl_entry.h
+++ b/fs/overlayfs/ovl_entry.h
@@ -30,6 +30,7 @@ struct ovl_sb {
 };
 
 struct ovl_layer {
+	/* ovl_free_fs() relies on @mnt being the first member! */
 	struct vfsmount *mnt;
 	/* Trap in ovl inode cache */
 	struct inode *trap;
@@ -40,6 +41,14 @@ struct ovl_layer {
 	int fsid;
 };
 
+/*
+ * ovl_free_fs() relies on @mnt being the first member when unmounting
+ * the private mounts created for each layer. Let's check both the
+ * offset and type.
+ */
+static_assert(offsetof(struct ovl_layer, mnt) == 0);
+static_assert(__same_type(typeof_member(struct ovl_layer, mnt), struct vfsmount *));
+
 struct ovl_path {
 	const struct ovl_layer *layer;
 	struct dentry *dentry;
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index ad255f8ab5c5..8d0cd68fc90a 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -557,7 +557,7 @@ static void invalidate_dquots(struct super_block *sb, int type)
 			continue;
 		/* Wait for dquot users */
 		if (atomic_read(&dquot->dq_count)) {
-			dqgrab(dquot);
+			atomic_inc(&dquot->dq_count);
 			spin_unlock(&dq_list_lock);
 			/*
 			 * Once dqput() wakes us up, we know it's time to free
@@ -2415,7 +2415,8 @@ int dquot_load_quota_sb(struct super_block *sb, int type, int format_id,
 
 	error = add_dquot_ref(sb, type);
 	if (error)
-		dquot_disable(sb, type, flags);
+		dquot_disable(sb, type,
+			      DQUOT_USAGE_ENABLED | DQUOT_LIMITS_ENABLED);
 
 	return error;
 out_fmt:
diff --git a/fs/udf/unicode.c b/fs/udf/unicode.c
index 622569007b53..2142cbd1dde2 100644
--- a/fs/udf/unicode.c
+++ b/fs/udf/unicode.c
@@ -247,7 +247,7 @@ static int udf_name_from_CS0(struct super_block *sb,
 	}
 
 	if (translate) {
-		if (str_o_len <= 2 && str_o[0] == '.' &&
+		if (str_o_len > 0 && str_o_len <= 2 && str_o[0] == '.' &&
 		    (str_o_len == 1 || str_o[1] == '.'))
 			needsCRC = 1;
 		if (needsCRC) {
diff --git a/include/dt-bindings/iio/addac/adi,ad74413r.h b/include/dt-bindings/iio/addac/adi,ad74413r.h
new file mode 100644
index 000000000000..204f92bbd79f
--- /dev/null
+++ b/include/dt-bindings/iio/addac/adi,ad74413r.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _DT_BINDINGS_ADI_AD74413R_H
+#define _DT_BINDINGS_ADI_AD74413R_H
+
+#define CH_FUNC_HIGH_IMPEDANCE			0x0
+#define CH_FUNC_VOLTAGE_OUTPUT			0x1
+#define CH_FUNC_CURRENT_OUTPUT			0x2
+#define CH_FUNC_VOLTAGE_INPUT			0x3
+#define CH_FUNC_CURRENT_INPUT_EXT_POWER		0x4
+#define CH_FUNC_CURRENT_INPUT_LOOP_POWER	0x5
+#define CH_FUNC_RESISTANCE_INPUT		0x6
+#define CH_FUNC_DIGITAL_INPUT_LOGIC		0x7
+#define CH_FUNC_DIGITAL_INPUT_LOOP_POWER	0x8
+#define CH_FUNC_CURRENT_INPUT_EXT_POWER_HART	0x9
+#define CH_FUNC_CURRENT_INPUT_LOOP_POWER_HART	0xA
+
+#define CH_FUNC_MIN	CH_FUNC_HIGH_IMPEDANCE
+#define CH_FUNC_MAX	CH_FUNC_CURRENT_INPUT_LOOP_POWER_HART
+
+#endif /* _DT_BINDINGS_ADI_AD74413R_H */
diff --git a/include/linux/iopoll.h b/include/linux/iopoll.h
index 2c8860e406bd..0417360a6db9 100644
--- a/include/linux/iopoll.h
+++ b/include/linux/iopoll.h
@@ -53,6 +53,7 @@
 		} \
 		if (__sleep_us) \
 			usleep_range((__sleep_us >> 2) + 1, __sleep_us); \
+		cpu_relax(); \
 	} \
 	(cond) ? 0 : -ETIMEDOUT; \
 })
@@ -95,6 +96,7 @@
 		} \
 		if (__delay_us) \
 			udelay(__delay_us); \
+		cpu_relax(); \
 	} \
 	(cond) ? 0 : -ETIMEDOUT; \
 })
diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index d4841e5a5f45..5d9f8c6f3d40 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -303,6 +303,7 @@ struct mhi_controller_config {
  * @rddm_size: RAM dump size that host should allocate for debugging purpose
  * @sbl_size: SBL image size downloaded through BHIe (optional)
  * @seg_len: BHIe vector size (optional)
+ * @reg_len: Length of the MHI MMIO region (required)
  * @fbc_image: Points to firmware image buffer
  * @rddm_image: Points to RAM dump buffer
  * @mhi_chan: Points to the channel configuration table
@@ -383,6 +384,7 @@ struct mhi_controller {
 	size_t rddm_size;
 	size_t sbl_size;
 	size_t seg_len;
+	size_t reg_len;
 	struct image_info *fbc_image;
 	struct image_info *rddm_image;
 	struct mhi_chan *mhi_chan;
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index ae88362216a4..4f95b98215d8 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -644,18 +644,22 @@ struct mlx5_pps {
 	u8                         enabled;
 };
 
-struct mlx5_clock {
-	struct mlx5_nb             pps_nb;
-	seqlock_t                  lock;
+struct mlx5_timer {
 	struct cyclecounter        cycles;
 	struct timecounter         tc;
-	struct hwtstamp_config     hwtstamp_config;
 	u32                        nominal_c_mult;
 	unsigned long              overflow_period;
 	struct delayed_work        overflow_work;
+};
+
+struct mlx5_clock {
+	struct mlx5_nb             pps_nb;
+	seqlock_t                  lock;
+	struct hwtstamp_config     hwtstamp_config;
 	struct ptp_clock          *ptp;
 	struct ptp_clock_info      ptp_info;
 	struct mlx5_pps            pps_info;
+	struct mlx5_timer          timer;
 };
 
 struct mlx5_dm;
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 40d7e98fc990..fb294cbb9081 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -477,6 +477,7 @@ struct mmc_host {
 struct device_node;
 
 struct mmc_host *mmc_alloc_host(int extra, struct device *);
+struct mmc_host *devm_mmc_alloc_host(struct device *dev, int extra);
 int mmc_add_host(struct mmc_host *);
 void mmc_remove_host(struct mmc_host *);
 void mmc_free_host(struct mmc_host *);
diff --git a/include/linux/objtool.h b/include/linux/objtool.h
index 662f19374bd9..d17fa7f4001d 100644
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -71,6 +71,23 @@ struct unwind_hint {
 	static void __used __section(".discard.func_stack_frame_non_standard") \
 		*__func_stack_frame_non_standard_##func = func
 
+/*
+ * STACK_FRAME_NON_STANDARD_FP() is a frame-pointer-specific function ignore
+ * for the case where a function is intentionally missing frame pointer setup,
+ * but otherwise needs objtool/ORC coverage when frame pointers are disabled.
+ */
+#ifdef CONFIG_FRAME_POINTER
+#define STACK_FRAME_NON_STANDARD_FP(func) STACK_FRAME_NON_STANDARD(func)
+#else
+#define STACK_FRAME_NON_STANDARD_FP(func)
+#endif
+
+#define ANNOTATE_NOENDBR					\
+	"986: \n\t"						\
+	".pushsection .discard.noendbr\n\t"			\
+	_ASM_PTR " 986b\n\t"					\
+	".popsection\n\t"
+
 #else /* __ASSEMBLY__ */
 
 /*
@@ -117,6 +134,13 @@ struct unwind_hint {
 	.popsection
 .endm
 
+.macro ANNOTATE_NOENDBR
+.Lhere_\@:
+	.pushsection .discard.noendbr
+	.quad	.Lhere_\@
+	.popsection
+.endm
+
 #endif /* __ASSEMBLY__ */
 
 #else /* !CONFIG_STACK_VALIDATION */
@@ -126,10 +150,14 @@ struct unwind_hint {
 #define UNWIND_HINT(sp_reg, sp_offset, type, end)	\
 	"\n\t"
 #define STACK_FRAME_NON_STANDARD(func)
+#define STACK_FRAME_NON_STANDARD_FP(func)
+#define ANNOTATE_NOENDBR
 #else
 #define ANNOTATE_INTRA_FUNCTION_CALL
 .macro UNWIND_HINT type:req sp_reg=0 sp_offset=0 end=0
 .endm
+.macro ANNOTATE_NOENDBR
+.endm
 #endif
 
 #endif /* CONFIG_STACK_VALIDATION */
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index e7351d64f11f..11df3d5b40c6 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -326,6 +326,7 @@ struct usb_gadget_ops {
 	struct usb_ep *(*match_ep)(struct usb_gadget *,
 			struct usb_endpoint_descriptor *,
 			struct usb_ss_ep_comp_descriptor *);
+	int	(*check_config)(struct usb_gadget *gadget);
 };
 
 /**
@@ -596,6 +597,7 @@ int usb_gadget_connect(struct usb_gadget *gadget);
 int usb_gadget_disconnect(struct usb_gadget *gadget);
 int usb_gadget_deactivate(struct usb_gadget *gadget);
 int usb_gadget_activate(struct usb_gadget *gadget);
+int usb_gadget_check_config(struct usb_gadget *gadget);
 #else
 static inline int usb_gadget_frame_number(struct usb_gadget *gadget)
 { return 0; }
@@ -619,6 +621,8 @@ static inline int usb_gadget_deactivate(struct usb_gadget *gadget)
 { return 0; }
 static inline int usb_gadget_activate(struct usb_gadget *gadget)
 { return 0; }
+static inline int usb_gadget_check_config(struct usb_gadget *gadget)
+{ return 0; }
 #endif /* CONFIG_USB_GADGET */
 
 /*-------------------------------------------------------------------------*/
diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index a960de68ac69..6047058d6703 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -148,6 +148,10 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
 		if (gso_type & SKB_GSO_UDP)
 			nh_off -= thlen;
 
+		/* Kernel has a special handling for GSO_BY_FRAGS. */
+		if (gso_size == GSO_BY_FRAGS)
+			return -EINVAL;
+
 		/* Too small packets are not really GSO ones. */
 		if (skb->len - nh_off > gso_size) {
 			shinfo->gso_size = gso_size;
diff --git a/include/media/v4l2-mem2mem.h b/include/media/v4l2-mem2mem.h
index 5a91b548ecc0..8d52c4506762 100644
--- a/include/media/v4l2-mem2mem.h
+++ b/include/media/v4l2-mem2mem.h
@@ -588,7 +588,14 @@ void v4l2_m2m_buf_queue(struct v4l2_m2m_ctx *m2m_ctx,
 static inline
 unsigned int v4l2_m2m_num_src_bufs_ready(struct v4l2_m2m_ctx *m2m_ctx)
 {
-	return m2m_ctx->out_q_ctx.num_rdy;
+	unsigned int num_buf_rdy;
+	unsigned long flags;
+
+	spin_lock_irqsave(&m2m_ctx->out_q_ctx.rdy_spinlock, flags);
+	num_buf_rdy = m2m_ctx->out_q_ctx.num_rdy;
+	spin_unlock_irqrestore(&m2m_ctx->out_q_ctx.rdy_spinlock, flags);
+
+	return num_buf_rdy;
 }
 
 /**
@@ -600,7 +607,14 @@ unsigned int v4l2_m2m_num_src_bufs_ready(struct v4l2_m2m_ctx *m2m_ctx)
 static inline
 unsigned int v4l2_m2m_num_dst_bufs_ready(struct v4l2_m2m_ctx *m2m_ctx)
 {
-	return m2m_ctx->cap_q_ctx.num_rdy;
+	unsigned int num_buf_rdy;
+	unsigned long flags;
+
+	spin_lock_irqsave(&m2m_ctx->cap_q_ctx.rdy_spinlock, flags);
+	num_buf_rdy = m2m_ctx->cap_q_ctx.num_rdy;
+	spin_unlock_irqrestore(&m2m_ctx->cap_q_ctx.rdy_spinlock, flags);
+
+	return num_buf_rdy;
 }
 
 /**
diff --git a/include/net/sock.h b/include/net/sock.h
index 1fb5c535537c..665e38859375 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1346,6 +1346,12 @@ static inline bool sk_has_memory_pressure(const struct sock *sk)
 	return sk->sk_prot->memory_pressure != NULL;
 }
 
+static inline bool sk_under_global_memory_pressure(const struct sock *sk)
+{
+	return sk->sk_prot->memory_pressure &&
+		!!*sk->sk_prot->memory_pressure;
+}
+
 static inline bool sk_under_memory_pressure(const struct sock *sk)
 {
 	if (!sk->sk_prot->memory_pressure)
diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
index 905c3fa005f1..5bff06199310 100644
--- a/kernel/dma/remap.c
+++ b/kernel/dma/remap.c
@@ -43,13 +43,13 @@ void *dma_common_contiguous_remap(struct page *page, size_t size,
 	void *vaddr;
 	int i;
 
-	pages = kmalloc_array(count, sizeof(struct page *), GFP_KERNEL);
+	pages = kvmalloc_array(count, sizeof(struct page *), GFP_KERNEL);
 	if (!pages)
 		return NULL;
 	for (i = 0; i < count; i++)
 		pages[i] = nth_page(page, i);
 	vaddr = vmap(pages, count, VM_DMA_COHERENT, prot);
-	kfree(pages);
+	kvfree(pages);
 
 	return vaddr;
 }
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 3b8c53264441..f8126fa0630e 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -541,6 +541,7 @@ struct trace_buffer {
 	unsigned			flags;
 	int				cpus;
 	atomic_t			record_disabled;
+	atomic_t			resizing;
 	cpumask_var_t			cpumask;
 
 	struct lock_class_key		*reader_lock_key;
@@ -2041,7 +2042,7 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 
 	/* prevent another thread from changing buffer sizes */
 	mutex_lock(&buffer->mutex);
-
+	atomic_inc(&buffer->resizing);
 
 	if (cpu_id == RING_BUFFER_ALL_CPUS) {
 		/*
@@ -2184,6 +2185,7 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 		atomic_dec(&buffer->record_disabled);
 	}
 
+	atomic_dec(&buffer->resizing);
 	mutex_unlock(&buffer->mutex);
 	return 0;
 
@@ -2204,6 +2206,7 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 		}
 	}
  out_err_unlock:
+	atomic_dec(&buffer->resizing);
 	mutex_unlock(&buffer->mutex);
 	return err;
 }
@@ -5253,6 +5256,15 @@ int ring_buffer_swap_cpu(struct trace_buffer *buffer_a,
 	if (local_read(&cpu_buffer_b->committing))
 		goto out_dec;
 
+	/*
+	 * When resize is in progress, we cannot swap it because
+	 * it will mess the state of the cpu buffer.
+	 */
+	if (atomic_read(&buffer_a->resizing))
+		goto out_dec;
+	if (atomic_read(&buffer_b->resizing))
+		goto out_dec;
+
 	buffer_a->buffers[cpu] = cpu_buffer_b;
 	buffer_b->buffers[cpu] = cpu_buffer_a;
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 7e99319bd536..167f2a19fd8a 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1882,9 +1882,10 @@ update_max_tr_single(struct trace_array *tr, struct task_struct *tsk, int cpu)
 		 * place on this CPU. We fail to record, but we reset
 		 * the max trace buffer (no one writes directly to it)
 		 * and flag that it failed.
+		 * Another reason is resize is in progress.
 		 */
 		trace_array_printk_buf(tr->max_buffer.buffer, _THIS_IP_,
-			"Failed to swap buffers due to commit in progress\n");
+			"Failed to swap buffers due to commit or resize in progress\n");
 	}
 
 	WARN_ON_ONCE(ret && ret != -EAGAIN && ret != -EBUSY);
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 41dd17390c73..b882c6519b03 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1332,9 +1332,10 @@ probe_mem_read(void *dest, void *src, size_t size)
 
 /* Note that we don't verify it, since the code does not come from user space */
 static int
-process_fetch_insn(struct fetch_insn *code, struct pt_regs *regs, void *dest,
+process_fetch_insn(struct fetch_insn *code, void *rec, void *dest,
 		   void *base)
 {
+	struct pt_regs *regs = rec;
 	unsigned long val;
 
 retry:
diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
index 29348874ebde..cf14a37dff8c 100644
--- a/kernel/trace/trace_probe_tmpl.h
+++ b/kernel/trace/trace_probe_tmpl.h
@@ -54,7 +54,7 @@ fetch_apply_bitfield(struct fetch_insn *code, void *buf)
  * If dest is NULL, don't store result and return required dynamic data size.
  */
 static int
-process_fetch_insn(struct fetch_insn *code, struct pt_regs *regs,
+process_fetch_insn(struct fetch_insn *code, void *rec,
 		   void *dest, void *base);
 static nokprobe_inline int fetch_store_strlen(unsigned long addr);
 static nokprobe_inline int
@@ -190,7 +190,7 @@ __get_data_size(struct trace_probe *tp, struct pt_regs *regs)
 
 /* Store the value of each argument */
 static nokprobe_inline void
-store_trace_args(void *data, struct trace_probe *tp, struct pt_regs *regs,
+store_trace_args(void *data, struct trace_probe *tp, void *rec,
 		 int header_size, int maxlen)
 {
 	struct probe_arg *arg;
@@ -205,12 +205,14 @@ store_trace_args(void *data, struct trace_probe *tp, struct pt_regs *regs,
 		/* Point the dynamic data area if needed */
 		if (unlikely(arg->dynamic))
 			*dl = make_data_loc(maxlen, dyndata - base);
-		ret = process_fetch_insn(arg->code, regs, dl, base);
-		if (unlikely(ret < 0 && arg->dynamic)) {
-			*dl = make_data_loc(0, dyndata - base);
-		} else {
-			dyndata += ret;
-			maxlen -= ret;
+		ret = process_fetch_insn(arg->code, rec, dl, base);
+		if (arg->dynamic) {
+			if (unlikely(ret < 0)) {
+				*dl = make_data_loc(0, dyndata - base);
+			} else {
+				dyndata += ret;
+				maxlen -= ret;
+			}
 		}
 	}
 }
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 9900d4e3808c..f6c47361c154 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -217,9 +217,10 @@ static unsigned long translate_user_vaddr(unsigned long file_offset)
 
 /* Note that we don't verify it, since the code does not come from user space */
 static int
-process_fetch_insn(struct fetch_insn *code, struct pt_regs *regs, void *dest,
+process_fetch_insn(struct fetch_insn *code, void *rec, void *dest,
 		   void *base)
 {
+	struct pt_regs *regs = rec;
 	unsigned long val;
 
 	/* 1st stage: get value from context */
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 568f0f072b3d..7b40e4737a2b 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6370,9 +6370,14 @@ static inline int l2cap_le_command_rej(struct l2cap_conn *conn,
 	if (!chan)
 		goto done;
 
+	chan = l2cap_chan_hold_unless_zero(chan);
+	if (!chan)
+		goto done;
+
 	l2cap_chan_lock(chan);
 	l2cap_chan_del(chan, ECONNREFUSED);
 	l2cap_chan_unlock(chan);
+	l2cap_chan_put(chan);
 
 done:
 	mutex_unlock(&conn->chan_lock);
diff --git a/net/core/sock.c b/net/core/sock.c
index 98f4b4a80de4..742356cfd07c 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2724,7 +2724,7 @@ void __sk_mem_reduce_allocated(struct sock *sk, int amount)
 	if (mem_cgroup_sockets_enabled && sk->sk_memcg)
 		mem_cgroup_uncharge_skmem(sk->sk_memcg, amount);
 
-	if (sk_under_memory_pressure(sk) &&
+	if (sk_under_global_memory_pressure(sk) &&
 	    (sk_memory_allocated(sk) < sk_prot_mem_limits(sk, 0)))
 		sk_leave_memory_pressure(sk);
 }
diff --git a/net/ipv4/ip_vti.c b/net/ipv4/ip_vti.c
index 84a818b09bee..90f349be4848 100644
--- a/net/ipv4/ip_vti.c
+++ b/net/ipv4/ip_vti.c
@@ -285,12 +285,12 @@ static netdev_tx_t vti_tunnel_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	switch (skb->protocol) {
 	case htons(ETH_P_IP):
-		xfrm_decode_session(skb, &fl, AF_INET);
 		memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
+		xfrm_decode_session(skb, &fl, AF_INET);
 		break;
 	case htons(ETH_P_IPV6):
-		xfrm_decode_session(skb, &fl, AF_INET6);
 		memset(IP6CB(skb), 0, sizeof(*IP6CB(skb)));
+		xfrm_decode_session(skb, &fl, AF_INET6);
 		break;
 	default:
 		goto tx_err;
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 715fdfa3e2ae..d2e07bb30164 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -582,7 +582,9 @@ void tcp_retransmit_timer(struct sock *sk)
 	    tcp_stream_is_thin(tp) &&
 	    icsk->icsk_retransmits <= TCP_THIN_LINEAR_RETRIES) {
 		icsk->icsk_backoff = 0;
-		icsk->icsk_rto = min(__tcp_set_rto(tp), TCP_RTO_MAX);
+		icsk->icsk_rto = clamp(__tcp_set_rto(tp),
+				       tcp_rto_min(sk),
+				       TCP_RTO_MAX);
 	} else {
 		/* Use normal (exponential) backoff */
 		icsk->icsk_rto = min(icsk->icsk_rto << 1, TCP_RTO_MAX);
diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index 99f2dc802e36..162ba065d476 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -567,12 +567,12 @@ vti6_tnl_xmit(struct sk_buff *skb, struct net_device *dev)
 		    vti6_addr_conflict(t, ipv6_hdr(skb)))
 			goto tx_err;
 
-		xfrm_decode_session(skb, &fl, AF_INET6);
 		memset(IP6CB(skb), 0, sizeof(*IP6CB(skb)));
+		xfrm_decode_session(skb, &fl, AF_INET6);
 		break;
 	case htons(ETH_P_IP):
-		xfrm_decode_session(skb, &fl, AF_INET);
 		memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
+		xfrm_decode_session(skb, &fl, AF_INET);
 		break;
 	default:
 		goto tx_err;
diff --git a/net/key/af_key.c b/net/key/af_key.c
index fff2bd5f03e3..f42854973ba8 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -1852,9 +1852,9 @@ static int pfkey_dump(struct sock *sk, struct sk_buff *skb, const struct sadb_ms
 	if (ext_hdrs[SADB_X_EXT_FILTER - 1]) {
 		struct sadb_x_filter *xfilter = ext_hdrs[SADB_X_EXT_FILTER - 1];
 
-		if ((xfilter->sadb_x_filter_splen >=
+		if ((xfilter->sadb_x_filter_splen >
 			(sizeof(xfrm_address_t) << 3)) ||
-		    (xfilter->sadb_x_filter_dplen >=
+		    (xfilter->sadb_x_filter_dplen >
 			(sizeof(xfrm_address_t) << 3))) {
 			mutex_unlock(&pfk->dump_lock);
 			return -EINVAL;
diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index 29ec3ef63edc..d0b64c36471d 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -1802,6 +1802,7 @@ static int
 proc_do_sync_threshold(struct ctl_table *table, int write,
 		       void *buffer, size_t *lenp, loff_t *ppos)
 {
+	struct netns_ipvs *ipvs = table->extra2;
 	int *valp = table->data;
 	int val[2];
 	int rc;
@@ -1811,6 +1812,7 @@ proc_do_sync_threshold(struct ctl_table *table, int write,
 		.mode = table->mode,
 	};
 
+	mutex_lock(&ipvs->sync_mutex);
 	memcpy(val, valp, sizeof(val));
 	rc = proc_dointvec(&tmp, write, buffer, lenp, ppos);
 	if (write) {
@@ -1820,6 +1822,7 @@ proc_do_sync_threshold(struct ctl_table *table, int write,
 		else
 			memcpy(valp, val, sizeof(val));
 	}
+	mutex_unlock(&ipvs->sync_mutex);
 	return rc;
 }
 
@@ -4077,6 +4080,7 @@ static int __net_init ip_vs_control_net_init_sysctl(struct netns_ipvs *ipvs)
 	ipvs->sysctl_sync_threshold[0] = DEFAULT_SYNC_THRESHOLD;
 	ipvs->sysctl_sync_threshold[1] = DEFAULT_SYNC_PERIOD;
 	tbl[idx].data = &ipvs->sysctl_sync_threshold;
+	tbl[idx].extra2 = ipvs;
 	tbl[idx++].maxlen = sizeof(ipvs->sysctl_sync_threshold);
 	ipvs->sysctl_sync_refresh_period = DEFAULT_SYNC_REFRESH_PERIOD;
 	tbl[idx++].data = &ipvs->sysctl_sync_refresh_period;
diff --git a/net/netfilter/nf_conntrack_proto_sctp.c b/net/netfilter/nf_conntrack_proto_sctp.c
index cec4b16170a0..21cbaf6dac33 100644
--- a/net/netfilter/nf_conntrack_proto_sctp.c
+++ b/net/netfilter/nf_conntrack_proto_sctp.c
@@ -49,8 +49,8 @@ static const unsigned int sctp_timeouts[SCTP_CONNTRACK_MAX] = {
 	[SCTP_CONNTRACK_COOKIE_WAIT]		= 3 SECS,
 	[SCTP_CONNTRACK_COOKIE_ECHOED]		= 3 SECS,
 	[SCTP_CONNTRACK_ESTABLISHED]		= 210 SECS,
-	[SCTP_CONNTRACK_SHUTDOWN_SENT]		= 300 SECS / 1000,
-	[SCTP_CONNTRACK_SHUTDOWN_RECD]		= 300 SECS / 1000,
+	[SCTP_CONNTRACK_SHUTDOWN_SENT]		= 3 SECS,
+	[SCTP_CONNTRACK_SHUTDOWN_RECD]		= 3 SECS,
 	[SCTP_CONNTRACK_SHUTDOWN_ACK_SENT]	= 3 SECS,
 	[SCTP_CONNTRACK_HEARTBEAT_SENT]		= 30 SECS,
 };
@@ -105,7 +105,7 @@ static const u8 sctp_conntracks[2][11][SCTP_CONNTRACK_MAX] = {
 	{
 /*	ORIGINAL	*/
 /*                  sNO, sCL, sCW, sCE, sES, sSS, sSR, sSA, sHS */
-/* init         */ {sCL, sCL, sCW, sCE, sES, sSS, sSR, sSA, sCW},
+/* init         */ {sCL, sCL, sCW, sCE, sES, sCL, sCL, sSA, sCW},
 /* init_ack     */ {sCL, sCL, sCW, sCE, sES, sSS, sSR, sSA, sCL},
 /* abort        */ {sCL, sCL, sCL, sCL, sCL, sCL, sCL, sCL, sCL},
 /* shutdown     */ {sCL, sCL, sCW, sCE, sSS, sSS, sSR, sSA, sCL},
diff --git a/net/netfilter/nft_dynset.c b/net/netfilter/nft_dynset.c
index 8d47782b778f..408b7f5faa5e 100644
--- a/net/netfilter/nft_dynset.c
+++ b/net/netfilter/nft_dynset.c
@@ -138,6 +138,9 @@ static int nft_dynset_init(const struct nft_ctx *ctx,
 	if (IS_ERR(set))
 		return PTR_ERR(set);
 
+	if (set->flags & NFT_SET_OBJECT)
+		return -EOPNOTSUPP;
+
 	if (set->ops->update == NULL)
 		return -EOPNOTSUPP;
 
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 3aa783a23c5f..8d941cbba5cb 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2008,6 +2008,7 @@ static ssize_t unix_stream_sendpage(struct socket *socket, struct page *page,
 
 	if (false) {
 alloc_skb:
+		spin_unlock(&other->sk_receive_queue.lock);
 		unix_state_unlock(other);
 		mutex_unlock(&unix_sk(other)->iolock);
 		newskb = sock_alloc_send_pskb(sk, 0, 0, flags & MSG_DONTWAIT,
@@ -2047,6 +2048,7 @@ static ssize_t unix_stream_sendpage(struct socket *socket, struct page *page,
 		init_scm = false;
 	}
 
+	spin_lock(&other->sk_receive_queue.lock);
 	skb = skb_peek_tail(&other->sk_receive_queue);
 	if (tail && tail == skb) {
 		skb = newskb;
@@ -2077,14 +2079,11 @@ static ssize_t unix_stream_sendpage(struct socket *socket, struct page *page,
 	refcount_add(size, &sk->sk_wmem_alloc);
 
 	if (newskb) {
-		err = unix_scm_to_skb(&scm, skb, false);
-		if (err)
-			goto err_state_unlock;
-		spin_lock(&other->sk_receive_queue.lock);
+		unix_scm_to_skb(&scm, skb, false);
 		__skb_queue_tail(&other->sk_receive_queue, newskb);
-		spin_unlock(&other->sk_receive_queue.lock);
 	}
 
+	spin_unlock(&other->sk_receive_queue.lock);
 	unix_state_unlock(other);
 	mutex_unlock(&unix_sk(other)->iolock);
 
diff --git a/net/xfrm/xfrm_compat.c b/net/xfrm/xfrm_compat.c
index 8cbf45a8bcdc..655fe4ff8621 100644
--- a/net/xfrm/xfrm_compat.c
+++ b/net/xfrm/xfrm_compat.c
@@ -108,7 +108,7 @@ static const struct nla_policy compat_policy[XFRMA_MAX+1] = {
 	[XFRMA_ALG_COMP]	= { .len = sizeof(struct xfrm_algo) },
 	[XFRMA_ENCAP]		= { .len = sizeof(struct xfrm_encap_tmpl) },
 	[XFRMA_TMPL]		= { .len = sizeof(struct xfrm_user_tmpl) },
-	[XFRMA_SEC_CTX]		= { .len = sizeof(struct xfrm_sec_ctx) },
+	[XFRMA_SEC_CTX]		= { .len = sizeof(struct xfrm_user_sec_ctx) },
 	[XFRMA_LTIME_VAL]	= { .len = sizeof(struct xfrm_lifetime_cur) },
 	[XFRMA_REPLAY_VAL]	= { .len = sizeof(struct xfrm_replay_state) },
 	[XFRMA_REPLAY_THRESH]	= { .type = NLA_U32 },
diff --git a/net/xfrm/xfrm_interface_core.c b/net/xfrm/xfrm_interface_core.c
index e4f21a692415..4eeec3367575 100644
--- a/net/xfrm/xfrm_interface_core.c
+++ b/net/xfrm/xfrm_interface_core.c
@@ -403,8 +403,8 @@ static netdev_tx_t xfrmi_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	switch (skb->protocol) {
 	case htons(ETH_P_IPV6):
-		xfrm_decode_session(skb, &fl, AF_INET6);
 		memset(IP6CB(skb), 0, sizeof(*IP6CB(skb)));
+		xfrm_decode_session(skb, &fl, AF_INET6);
 		if (!dst) {
 			fl.u.ip6.flowi6_oif = dev->ifindex;
 			fl.u.ip6.flowi6_flags |= FLOWI_FLAG_ANYSRC;
@@ -418,8 +418,8 @@ static netdev_tx_t xfrmi_xmit(struct sk_buff *skb, struct net_device *dev)
 		}
 		break;
 	case htons(ETH_P_IP):
-		xfrm_decode_session(skb, &fl, AF_INET);
 		memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
+		xfrm_decode_session(skb, &fl, AF_INET);
 		if (!dst) {
 			struct rtable *rt;
 
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index c6bf3898d1bf..8fce2e93bb3b 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -527,7 +527,7 @@ static void xfrm_update_ae_params(struct xfrm_state *x, struct nlattr **attrs,
 	struct nlattr *rt = attrs[XFRMA_REPLAY_THRESH];
 	struct nlattr *mt = attrs[XFRMA_MTIMER_THRESH];
 
-	if (re) {
+	if (re && x->replay_esn && x->preplay_esn) {
 		struct xfrm_replay_state_esn *replay_esn;
 		replay_esn = nla_data(re);
 		memcpy(x->replay_esn, replay_esn,
@@ -1062,6 +1062,15 @@ static int xfrm_dump_sa(struct sk_buff *skb, struct netlink_callback *cb)
 					 sizeof(*filter), GFP_KERNEL);
 			if (filter == NULL)
 				return -ENOMEM;
+
+			/* see addr_match(), (prefix length >> 5) << 2
+			 * will be used to compare xfrm_address_t
+			 */
+			if (filter->splen > (sizeof(xfrm_address_t) << 3) ||
+			    filter->dplen > (sizeof(xfrm_address_t) << 3)) {
+				kfree(filter);
+				return -EINVAL;
+			}
 		}
 
 		if (attrs[XFRMA_PROTO])
@@ -2728,7 +2737,7 @@ const struct nla_policy xfrma_policy[XFRMA_MAX+1] = {
 	[XFRMA_ALG_COMP]	= { .len = sizeof(struct xfrm_algo) },
 	[XFRMA_ENCAP]		= { .len = sizeof(struct xfrm_encap_tmpl) },
 	[XFRMA_TMPL]		= { .len = sizeof(struct xfrm_user_tmpl) },
-	[XFRMA_SEC_CTX]		= { .len = sizeof(struct xfrm_sec_ctx) },
+	[XFRMA_SEC_CTX]		= { .len = sizeof(struct xfrm_user_sec_ctx) },
 	[XFRMA_LTIME_VAL]	= { .len = sizeof(struct xfrm_lifetime_cur) },
 	[XFRMA_REPLAY_VAL]	= { .len = sizeof(struct xfrm_replay_state) },
 	[XFRMA_REPLAY_THRESH]	= { .type = NLA_U32 },
@@ -2748,6 +2757,7 @@ const struct nla_policy xfrma_policy[XFRMA_MAX+1] = {
 	[XFRMA_SET_MARK]	= { .type = NLA_U32 },
 	[XFRMA_SET_MARK_MASK]	= { .type = NLA_U32 },
 	[XFRMA_IF_ID]		= { .type = NLA_U32 },
+	[XFRMA_MTIMER_THRESH]   = { .type = NLA_U32 },
 };
 EXPORT_SYMBOL_GPL(xfrma_policy);
 
diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 755af0b29e75..0a5ae1e8da47 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -8,7 +8,7 @@ config IMA
 	select CRYPTO_HMAC
 	select CRYPTO_SHA1
 	select CRYPTO_HASH_INFO
-	select TCG_TPM if HAS_IOMEM && !UML
+	select TCG_TPM if HAS_IOMEM
 	select TCG_TIS if TCG_TPM && X86
 	select TCG_CRB if TCG_TPM && ACPI
 	select TCG_IBMVTPM if TCG_TPM && PPC_PSERIES
diff --git a/sound/hda/hdac_regmap.c b/sound/hda/hdac_regmap.c
index d75f31eb9d78..bf35acca5ea0 100644
--- a/sound/hda/hdac_regmap.c
+++ b/sound/hda/hdac_regmap.c
@@ -597,10 +597,9 @@ EXPORT_SYMBOL_GPL(snd_hdac_regmap_update_raw_once);
  */
 void snd_hdac_regmap_sync(struct hdac_device *codec)
 {
-	if (codec->regmap) {
-		mutex_lock(&codec->regmap_lock);
+	mutex_lock(&codec->regmap_lock);
+	if (codec->regmap)
 		regcache_sync(codec->regmap);
-		mutex_unlock(&codec->regmap_lock);
-	}
+	mutex_unlock(&codec->regmap_lock);
 }
 EXPORT_SYMBOL_GPL(snd_hdac_regmap_sync);
diff --git a/sound/pci/emu10k1/emufx.c b/sound/pci/emu10k1/emufx.c
index 4e76ed0e91d5..e17b93b25d2f 100644
--- a/sound/pci/emu10k1/emufx.c
+++ b/sound/pci/emu10k1/emufx.c
@@ -1560,14 +1560,8 @@ A_OP(icode, &ptr, iMAC0, A_GPR(var), A_GPR(var), A_GPR(vol), A_EXTIN(input))
 	gpr += 2;
 
 	/* Master volume (will be renamed later) */
-	A_OP(icode, &ptr, iMAC0, A_GPR(playback+0+SND_EMU10K1_PLAYBACK_CHANNELS), A_C_00000000, A_GPR(gpr), A_GPR(playback+0+SND_EMU10K1_PLAYBACK_CHANNELS));
-	A_OP(icode, &ptr, iMAC0, A_GPR(playback+1+SND_EMU10K1_PLAYBACK_CHANNELS), A_C_00000000, A_GPR(gpr), A_GPR(playback+1+SND_EMU10K1_PLAYBACK_CHANNELS));
-	A_OP(icode, &ptr, iMAC0, A_GPR(playback+2+SND_EMU10K1_PLAYBACK_CHANNELS), A_C_00000000, A_GPR(gpr), A_GPR(playback+2+SND_EMU10K1_PLAYBACK_CHANNELS));
-	A_OP(icode, &ptr, iMAC0, A_GPR(playback+3+SND_EMU10K1_PLAYBACK_CHANNELS), A_C_00000000, A_GPR(gpr), A_GPR(playback+3+SND_EMU10K1_PLAYBACK_CHANNELS));
-	A_OP(icode, &ptr, iMAC0, A_GPR(playback+4+SND_EMU10K1_PLAYBACK_CHANNELS), A_C_00000000, A_GPR(gpr), A_GPR(playback+4+SND_EMU10K1_PLAYBACK_CHANNELS));
-	A_OP(icode, &ptr, iMAC0, A_GPR(playback+5+SND_EMU10K1_PLAYBACK_CHANNELS), A_C_00000000, A_GPR(gpr), A_GPR(playback+5+SND_EMU10K1_PLAYBACK_CHANNELS));
-	A_OP(icode, &ptr, iMAC0, A_GPR(playback+6+SND_EMU10K1_PLAYBACK_CHANNELS), A_C_00000000, A_GPR(gpr), A_GPR(playback+6+SND_EMU10K1_PLAYBACK_CHANNELS));
-	A_OP(icode, &ptr, iMAC0, A_GPR(playback+7+SND_EMU10K1_PLAYBACK_CHANNELS), A_C_00000000, A_GPR(gpr), A_GPR(playback+7+SND_EMU10K1_PLAYBACK_CHANNELS));
+	for (z = 0; z < 8; z++)
+		A_OP(icode, &ptr, iMAC0, A_GPR(playback+z+SND_EMU10K1_PLAYBACK_CHANNELS), A_C_00000000, A_GPR(gpr), A_GPR(playback+z+SND_EMU10K1_PLAYBACK_CHANNELS));
 	snd_emu10k1_init_mono_control(&controls[nctl++], "Wave Master Playback Volume", gpr, 0);
 	gpr += 2;
 
@@ -1651,102 +1645,14 @@ A_OP(icode, &ptr, iMAC0, A_GPR(var), A_GPR(var), A_GPR(vol), A_EXTIN(input))
 			dev_dbg(emu->card->dev, "emufx.c: gpr=0x%x, tmp=0x%x\n",
 			       gpr, tmp);
 			*/
-			/* For the EMU1010: How to get 32bit values from the DSP. High 16bits into L, low 16bits into R. */
-			/* A_P16VIN(0) is delayed by one sample,
-			 * so all other A_P16VIN channels will need to also be delayed
-			 */
-			/* Left ADC in. 1 of 2 */
 			snd_emu10k1_audigy_dsp_convert_32_to_2x16( icode, &ptr, tmp, bit_shifter16, A_P16VIN(0x0), A_FXBUS2(0) );
-			/* Right ADC in 1 of 2 */
-			gpr_map[gpr++] = 0x00000000;
-			/* Delaying by one sample: instead of copying the input
-			 * value A_P16VIN to output A_FXBUS2 as in the first channel,
-			 * we use an auxiliary register, delaying the value by one
-			 * sample
-			 */
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16( icode, &ptr, tmp, bit_shifter16, A_GPR(gpr - 1), A_FXBUS2(2) );
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0x1), A_C_00000000, A_C_00000000);
-			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16( icode, &ptr, tmp, bit_shifter16, A_GPR(gpr - 1), A_FXBUS2(4) );
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0x2), A_C_00000000, A_C_00000000);
-			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16( icode, &ptr, tmp, bit_shifter16, A_GPR(gpr - 1), A_FXBUS2(6) );
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0x3), A_C_00000000, A_C_00000000);
-			/* For 96kHz mode */
-			/* Left ADC in. 2 of 2 */
-			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16( icode, &ptr, tmp, bit_shifter16, A_GPR(gpr - 1), A_FXBUS2(0x8) );
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0x4), A_C_00000000, A_C_00000000);
-			/* Right ADC in 2 of 2 */
-			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16( icode, &ptr, tmp, bit_shifter16, A_GPR(gpr - 1), A_FXBUS2(0xa) );
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0x5), A_C_00000000, A_C_00000000);
-			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16( icode, &ptr, tmp, bit_shifter16, A_GPR(gpr - 1), A_FXBUS2(0xc) );
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0x6), A_C_00000000, A_C_00000000);
-			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16( icode, &ptr, tmp, bit_shifter16, A_GPR(gpr - 1), A_FXBUS2(0xe) );
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0x7), A_C_00000000, A_C_00000000);
-			/* Pavel Hofman - we still have voices, A_FXBUS2s, and
-			 * A_P16VINs available -
-			 * let's add 8 more capture channels - total of 16
-			 */
-			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16(icode, &ptr, tmp,
-								  bit_shifter16,
-								  A_GPR(gpr - 1),
-								  A_FXBUS2(0x10));
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0x8),
-			     A_C_00000000, A_C_00000000);
-			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16(icode, &ptr, tmp,
-								  bit_shifter16,
-								  A_GPR(gpr - 1),
-								  A_FXBUS2(0x12));
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0x9),
-			     A_C_00000000, A_C_00000000);
-			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16(icode, &ptr, tmp,
-								  bit_shifter16,
-								  A_GPR(gpr - 1),
-								  A_FXBUS2(0x14));
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0xa),
-			     A_C_00000000, A_C_00000000);
-			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16(icode, &ptr, tmp,
-								  bit_shifter16,
-								  A_GPR(gpr - 1),
-								  A_FXBUS2(0x16));
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0xb),
-			     A_C_00000000, A_C_00000000);
-			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16(icode, &ptr, tmp,
-								  bit_shifter16,
-								  A_GPR(gpr - 1),
-								  A_FXBUS2(0x18));
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0xc),
-			     A_C_00000000, A_C_00000000);
-			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16(icode, &ptr, tmp,
-								  bit_shifter16,
-								  A_GPR(gpr - 1),
-								  A_FXBUS2(0x1a));
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0xd),
-			     A_C_00000000, A_C_00000000);
-			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16(icode, &ptr, tmp,
-								  bit_shifter16,
-								  A_GPR(gpr - 1),
-								  A_FXBUS2(0x1c));
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0xe),
-			     A_C_00000000, A_C_00000000);
-			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16(icode, &ptr, tmp,
-								  bit_shifter16,
-								  A_GPR(gpr - 1),
-								  A_FXBUS2(0x1e));
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0xf),
-			     A_C_00000000, A_C_00000000);
+			/* A_P16VIN(0) is delayed by one sample, so all other A_P16VIN channels
+			 * will need to also be delayed; we use an auxiliary register for that. */
+			for (z = 1; z < 0x10; z++) {
+				snd_emu10k1_audigy_dsp_convert_32_to_2x16( icode, &ptr, tmp, bit_shifter16, A_GPR(gpr), A_FXBUS2(z * 2) );
+				A_OP(icode, &ptr, iACC3, A_GPR(gpr), A_P16VIN(z), A_C_00000000, A_C_00000000);
+				gpr_map[gpr++] = 0x00000000;
+			}
 		}
 
 #if 0
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index db8593d79431..adfab80b8189 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10006,6 +10006,7 @@ static int patch_alc269(struct hda_codec *codec)
 	spec = codec->spec;
 	spec->gen.shared_mic_vref_pin = 0x18;
 	codec->power_save_node = 0;
+	spec->en_3kpull_low = true;
 
 #ifdef CONFIG_PM
 	codec->patch_ops.suspend = alc269_suspend;
@@ -10088,14 +10089,16 @@ static int patch_alc269(struct hda_codec *codec)
 		spec->shutup = alc256_shutup;
 		spec->init_hook = alc256_init;
 		spec->gen.mixer_nid = 0; /* ALC256 does not have any loopback mixer path */
-		if (codec->bus->pci->vendor == PCI_VENDOR_ID_AMD)
-			spec->en_3kpull_low = true;
+		if (codec->core.vendor_id == 0x10ec0236 &&
+		    codec->bus->pci->vendor != PCI_VENDOR_ID_AMD)
+			spec->en_3kpull_low = false;
 		break;
 	case 0x10ec0257:
 		spec->codec_variant = ALC269_TYPE_ALC257;
 		spec->shutup = alc256_shutup;
 		spec->init_hook = alc256_init;
 		spec->gen.mixer_nid = 0;
+		spec->en_3kpull_low = false;
 		break;
 	case 0x10ec0215:
 	case 0x10ec0245:
@@ -10719,6 +10722,7 @@ enum {
 	ALC897_FIXUP_HP_HSMIC_VERB,
 	ALC897_FIXUP_LENOVO_HEADSET_MODE,
 	ALC897_FIXUP_HEADSET_MIC_PIN2,
+	ALC897_FIXUP_UNIS_H3C_X500S,
 };
 
 static const struct hda_fixup alc662_fixups[] = {
@@ -11158,6 +11162,13 @@ static const struct hda_fixup alc662_fixups[] = {
 		.chained = true,
 		.chain_id = ALC897_FIXUP_LENOVO_HEADSET_MODE
 	},
+	[ALC897_FIXUP_UNIS_H3C_X500S] = {
+		.type = HDA_FIXUP_VERBS,
+		.v.verbs = (const struct hda_verb[]) {
+			{ 0x14, AC_VERB_SET_EAPD_BTLENABLE, 0 },
+			{}
+		},
+	},
 };
 
 static const struct snd_pci_quirk alc662_fixup_tbl[] = {
@@ -11319,6 +11330,7 @@ static const struct hda_model_fixup alc662_fixup_models[] = {
 	{.id = ALC662_FIXUP_USI_HEADSET_MODE, .name = "usi-headset"},
 	{.id = ALC662_FIXUP_LENOVO_MULTI_CODECS, .name = "dual-codecs"},
 	{.id = ALC669_FIXUP_ACER_ASPIRE_ETHOS, .name = "aspire-ethos"},
+	{.id = ALC897_FIXUP_UNIS_H3C_X500S, .name = "unis-h3c-x500s"},
 	{}
 };
 
diff --git a/sound/soc/codecs/rt5665.c b/sound/soc/codecs/rt5665.c
index 8a915cdce0fe..8b73c2d7f1f1 100644
--- a/sound/soc/codecs/rt5665.c
+++ b/sound/soc/codecs/rt5665.c
@@ -4472,6 +4472,8 @@ static void rt5665_remove(struct snd_soc_component *component)
 	struct rt5665_priv *rt5665 = snd_soc_component_get_drvdata(component);
 
 	regmap_write(rt5665->regmap, RT5665_RESET, 0);
+
+	regulator_bulk_disable(ARRAY_SIZE(rt5665->supplies), rt5665->supplies);
 }
 
 #ifdef CONFIG_PM
diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index f5d8f7951cfc..cbbb50ddc795 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -199,6 +199,31 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
 					SOF_RT715_DAI_ID_FIX |
 					SOF_SDW_PCH_DMIC),
 	},
+	{
+		.callback = sof_sdw_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Intel Corporation"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Meteor Lake Client Platform"),
+		},
+		.driver_data = (void *)(RT711_JD2_100K),
+	},
+	{
+		.callback = sof_sdw_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Google"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Rex"),
+		},
+		.driver_data = (void *)(SOF_SDW_PCH_DMIC),
+	},
+	/* LunarLake devices */
+	{
+		.callback = sof_sdw_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Intel Corporation"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Lunar Lake Client Platform"),
+		},
+		.driver_data = (void *)(RT711_JD2_100K),
+	},
 	{}
 };
 
diff --git a/sound/soc/meson/axg-tdm-formatter.c b/sound/soc/meson/axg-tdm-formatter.c
index cab7fa2851aa..4834cfd163c0 100644
--- a/sound/soc/meson/axg-tdm-formatter.c
+++ b/sound/soc/meson/axg-tdm-formatter.c
@@ -30,27 +30,32 @@ int axg_tdm_formatter_set_channel_masks(struct regmap *map,
 					struct axg_tdm_stream *ts,
 					unsigned int offset)
 {
-	unsigned int val, ch = ts->channels;
-	unsigned long mask;
-	int i, j;
+	unsigned int ch = ts->channels;
+	u32 val[AXG_TDM_NUM_LANES];
+	int i, j, k;
+
+	/*
+	 * We need to mimick the slot distribution used by the HW to keep the
+	 * channel placement consistent regardless of the number of channel
+	 * in the stream. This is why the odd algorithm below is used.
+	 */
+	memset(val, 0, sizeof(*val) * AXG_TDM_NUM_LANES);
 
 	/*
 	 * Distribute the channels of the stream over the available slots
-	 * of each TDM lane
+	 * of each TDM lane. We need to go over the 32 slots ...
 	 */
-	for (i = 0; i < AXG_TDM_NUM_LANES; i++) {
-		val = 0;
-		mask = ts->mask[i];
-
-		for (j = find_first_bit(&mask, 32);
-		     (j < 32) && ch;
-		     j = find_next_bit(&mask, 32, j + 1)) {
-			val |= 1 << j;
-			ch -= 1;
+	for (i = 0; (i < 32) && ch; i += 2) {
+		/* ... of all the lanes ... */
+		for (j = 0; j < AXG_TDM_NUM_LANES; j++) {
+			/* ... then distribute the channels in pairs */
+			for (k = 0; k < 2; k++) {
+				if ((BIT(i + k) & ts->mask[j]) && ch) {
+					val[j] |= BIT(i + k);
+					ch -= 1;
+				}
+			}
 		}
-
-		regmap_write(map, offset, val);
-		offset += regmap_get_reg_stride(map);
 	}
 
 	/*
@@ -63,6 +68,11 @@ int axg_tdm_formatter_set_channel_masks(struct regmap *map,
 		return -EINVAL;
 	}
 
+	for (i = 0; i < AXG_TDM_NUM_LANES; i++) {
+		regmap_write(map, offset, val[i]);
+		offset += regmap_get_reg_stride(map);
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(axg_tdm_formatter_set_channel_masks);
diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index ec74aead0844..97fe2fadcafb 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -3797,6 +3797,35 @@ AU0828_DEVICE(0x2040, 0x7270, "Hauppauge", "HVR-950Q"),
 		}
 	}
 },
+{
+	/* Advanced modes of the Mythware XA001AU.
+	 * For the standard mode, Mythware XA001AU has ID ffad:a001
+	 */
+	USB_DEVICE_VENDOR_SPEC(0xffad, 0xa001),
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+		.vendor_name = "Mythware",
+		.product_name = "XA001AU",
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_COMPOSITE,
+		.data = (const struct snd_usb_audio_quirk[]) {
+			{
+				.ifnum = 0,
+				.type = QUIRK_IGNORE_INTERFACE,
+			},
+			{
+				.ifnum = 1,
+				.type = QUIRK_AUDIO_STANDARD_INTERFACE,
+			},
+			{
+				.ifnum = 2,
+				.type = QUIRK_AUDIO_STANDARD_INTERFACE,
+			},
+			{
+				.ifnum = -1
+			}
+		}
+	}
+},
 
 #undef USB_DEVICE_VENDOR_SPEC
 #undef USB_AUDIO_DEVICE
diff --git a/tools/include/linux/objtool.h b/tools/include/linux/objtool.h
index 662f19374bd9..d17fa7f4001d 100644
--- a/tools/include/linux/objtool.h
+++ b/tools/include/linux/objtool.h
@@ -71,6 +71,23 @@ struct unwind_hint {
 	static void __used __section(".discard.func_stack_frame_non_standard") \
 		*__func_stack_frame_non_standard_##func = func
 
+/*
+ * STACK_FRAME_NON_STANDARD_FP() is a frame-pointer-specific function ignore
+ * for the case where a function is intentionally missing frame pointer setup,
+ * but otherwise needs objtool/ORC coverage when frame pointers are disabled.
+ */
+#ifdef CONFIG_FRAME_POINTER
+#define STACK_FRAME_NON_STANDARD_FP(func) STACK_FRAME_NON_STANDARD(func)
+#else
+#define STACK_FRAME_NON_STANDARD_FP(func)
+#endif
+
+#define ANNOTATE_NOENDBR					\
+	"986: \n\t"						\
+	".pushsection .discard.noendbr\n\t"			\
+	_ASM_PTR " 986b\n\t"					\
+	".popsection\n\t"
+
 #else /* __ASSEMBLY__ */
 
 /*
@@ -117,6 +134,13 @@ struct unwind_hint {
 	.popsection
 .endm
 
+.macro ANNOTATE_NOENDBR
+.Lhere_\@:
+	.pushsection .discard.noendbr
+	.quad	.Lhere_\@
+	.popsection
+.endm
+
 #endif /* __ASSEMBLY__ */
 
 #else /* !CONFIG_STACK_VALIDATION */
@@ -126,10 +150,14 @@ struct unwind_hint {
 #define UNWIND_HINT(sp_reg, sp_offset, type, end)	\
 	"\n\t"
 #define STACK_FRAME_NON_STANDARD(func)
+#define STACK_FRAME_NON_STANDARD_FP(func)
+#define ANNOTATE_NOENDBR
 #else
 #define ANNOTATE_INTRA_FUNCTION_CALL
 .macro UNWIND_HINT type:req sp_reg=0 sp_offset=0 end=0
 .endm
+.macro ANNOTATE_NOENDBR
+.endm
 #endif
 
 #endif /* CONFIG_STACK_VALIDATION */
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 5b915ebb6116..b6791e8d9ab3 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -655,5 +655,5 @@ bool arch_is_rethunk(struct symbol *sym)
 	return !strcmp(sym->name, "__x86_return_thunk") ||
 	       !strcmp(sym->name, "srso_untrain_ret") ||
 	       !strcmp(sym->name, "srso_safe_ret") ||
-	       !strcmp(sym->name, "__ret");
+	       !strcmp(sym->name, "retbleed_return_thunk");
 }
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 9a0a54194636..965c055aa808 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -369,7 +369,7 @@ static int decode_instructions(struct objtool_file *file)
 
 		if (!strcmp(sec->name, ".noinstr.text") ||
 		    !strcmp(sec->name, ".entry.text") ||
-		    !strncmp(sec->name, ".text.__x86.", 12))
+		    !strncmp(sec->name, ".text..__x86.", 13))
 			sec->noinstr = true;
 
 		for (offset = 0; offset < sec->len; offset += insn->len) {
@@ -1165,7 +1165,7 @@ static int add_jump_destinations(struct objtool_file *file)
 				continue;
 
 			/*
-			 * This is a special case for zen_untrain_ret().
+			 * This is a special case for retbleed_untrain_ret().
 			 * It jumps to __x86_return_thunk(), but objtool
 			 * can't find the thunk's starting RET
 			 * instruction, because the RET is also in the
@@ -2079,12 +2079,17 @@ static int decode_sections(struct objtool_file *file)
 	return 0;
 }
 
-static bool is_fentry_call(struct instruction *insn)
+static bool is_special_call(struct instruction *insn)
 {
-	if (insn->type == INSN_CALL &&
-	    insn->call_dest &&
-	    insn->call_dest->fentry)
-		return true;
+	if (insn->type == INSN_CALL) {
+		struct symbol *dest = insn->call_dest;
+
+		if (!dest)
+			return false;
+
+		if (dest->fentry)
+			return true;
+	}
 
 	return false;
 }
@@ -2958,7 +2963,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			if (ret)
 				return ret;
 
-			if (!no_fp && func && !is_fentry_call(insn) &&
+			if (!no_fp && func && !is_special_call(insn) &&
 			    !has_valid_stack_frame(&state)) {
 				WARN_FUNC("call without frame pointer save/setup",
 					  sec, insn->offset);
diff --git a/tools/testing/selftests/net/forwarding/mirror_gre_changes.sh b/tools/testing/selftests/net/forwarding/mirror_gre_changes.sh
index 472bd023e2a5..b501b366367f 100755
--- a/tools/testing/selftests/net/forwarding/mirror_gre_changes.sh
+++ b/tools/testing/selftests/net/forwarding/mirror_gre_changes.sh
@@ -72,7 +72,8 @@ test_span_gre_ttl()
 
 	RET=0
 
-	mirror_install $swp1 ingress $tundev "matchall $tcflags"
+	mirror_install $swp1 ingress $tundev \
+		"prot ip flower $tcflags ip_prot icmp"
 	tc filter add dev $h3 ingress pref 77 prot $prot \
 		flower ip_ttl 50 action pass
 
