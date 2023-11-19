Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83517F0649
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 14:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjKSNFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 08:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbjKSNFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 08:05:10 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A298FD45;
        Sun, 19 Nov 2023 05:05:00 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-507a29c7eefso5041296e87.1;
        Sun, 19 Nov 2023 05:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700399099; x=1701003899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZoMsaRCdrwzQIgA4pCYsDBIzIpTKt2NvoS4IbctX9k=;
        b=Q4akB+SC1U1iozb3dRxWPAN7khvcifHhZBDZtquVT0TIacqI/SBjiq3n2t2i07Lghz
         KrpEkcRmJ36yMTwSwo7SJhm6ZJB8NxmkaI8RGSP+I1YzN7CEnTQpq3SXxtv9ht0nmGBx
         7stWpYiVdf2r8PWOsj1dOMN1A5W6Z8+UBHqp64OfRoGglbcSPPF18R1xmn7utL6nje4y
         M7IrL5UYhdnd89QuamJUPgql+YW+OSRm5v3WrKHsmdCxG4OXWsfAwm9VxcS/ndSRGyTb
         xj5AH/v4CUSXuxghWFEBsPGdiZDLag8QyFXsqDQnsgVXV76TProjc3KAxizpgPJDEyQL
         1G/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700399099; x=1701003899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YZoMsaRCdrwzQIgA4pCYsDBIzIpTKt2NvoS4IbctX9k=;
        b=E7P9Dp411/QBDdJxTw8OFR2VEZIDxeYikxeVp5nX/4JwqmC/T+yYRHrvReUvwis6cB
         EUEqM3mRJO+GXucfLgUt2ERvxFq+IcBxDt8bUNdSAU+ci+SE12KVXF4mBwH1OlYjcGJf
         2BSDpr6dg3NanEDE72WDvGLsLaoMrsqkrTmCvwqX9XbBo1fUoX7cUvL2H0J7xwDgzm6E
         u0j6v1sdHqvuMMCpXGVkmYDddImjpJUpumujMYutgx8O9gYW7xx6Wrbq1K4SQ5wX1h8X
         55c7yr9jO8Y55lzh6w9cvzEDLJnq97tcfdJis0/HF+AjDxeaJiPGvOfpCjqK9vDKONJB
         G9yA==
X-Gm-Message-State: AOJu0Yyv4ZG0QGqLVKbh2rKcN+NZaKKl1+JF6PemM4iG3Py7o6K2iDF4
        oK6kZdbMMdr5mVbWGftJNw==
X-Google-Smtp-Source: AGHT+IFM7L62fT2HxJg7ttHyaEqv4FrEgsAF5QE/0DhVscMChbLCIWZlM9L3YQDBy86/KX2TgStsCw==
X-Received: by 2002:ac2:5e81:0:b0:507:b14f:e3bc with SMTP id b1-20020ac25e81000000b00507b14fe3bcmr3437685lfq.33.1700399098722;
        Sun, 19 Nov 2023 05:04:58 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:7017:f42c:e243:8c57])
        by smtp.gmail.com with ESMTPSA id n8-20020a1709062bc800b009dd8473559dsm2827866ejg.110.2023.11.19.05.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 05:04:58 -0800 (PST)
From:   Alex Bee <knaerzche@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v2 3/3] ARM: dts: Add Geniatech XPI-3128 RK3128 board
Date:   Sun, 19 Nov 2023 14:03:55 +0100
Message-ID: <20231119130351.112261-8-knaerzche@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231119130351.112261-2-knaerzche@gmail.com>
References: <20231119130351.112261-2-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

XPI-3128 is RK3128 based SBC form Geniatec in RPi form factor

Specs:
- Rockchip RK3128
- 512MB/1 GB DDR3 DRAM
- 8/16 GB eMMC
- TF card slot
- 100 MBit ethernet / RJ45 (TI DP83848C phy)
- optional Marvell 88W8897 (USB version)
- 3 x USB host (onboard GL852G hub connected to SoC ehci host)
- 1 x USB otg
- 1 x Type-C (solely for powering the board)
- HDMI 1.4 out
- ADC button
- IR receiver
- Artasie AM1805 RTC
- 40 pin header

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 arch/arm/boot/dts/rockchip/Makefile           |   1 +
 .../arm/boot/dts/rockchip/rk3128-xpi-3128.dts | 397 ++++++++++++++++++
 2 files changed, 398 insertions(+)
 create mode 100644 arch/arm/boot/dts/rockchip/rk3128-xpi-3128.dts

diff --git a/arch/arm/boot/dts/rockchip/Makefile b/arch/arm/boot/dts/rockchip/Makefile
index 0f46e18fe275..58868cf0510b 100644
--- a/arch/arm/boot/dts/rockchip/Makefile
+++ b/arch/arm/boot/dts/rockchip/Makefile
@@ -10,6 +10,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += \
 	rk3066a-mk808.dtb \
 	rk3066a-rayeager.dtb \
 	rk3128-evb.dtb \
+	rk3128-xpi-3128.dtb \
 	rk3188-bqedison2qc.dtb \
 	rk3188-px3-evb.dtb \
 	rk3188-radxarock.dtb \
diff --git a/arch/arm/boot/dts/rockchip/rk3128-xpi-3128.dts b/arch/arm/boot/dts/rockchip/rk3128-xpi-3128.dts
new file mode 100644
index 000000000000..61b9f069c8a2
--- /dev/null
+++ b/arch/arm/boot/dts/rockchip/rk3128-xpi-3128.dts
@@ -0,0 +1,397 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+/dts-v1/;
+
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+#include "rk3128.dtsi"
+
+/ {
+	model = "Geniatech XPI-3128";
+	compatible = "geniatech,xpi-3128", "rockchip,rk3128";
+
+	aliases {
+		gpio0 = &gpio0;
+		gpio1 = &gpio1;
+		gpio2 = &gpio2;
+		gpio3 = &gpio3;
+		mmc0 = &emmc;
+		mmc1 = &sdmmc;
+		serial0 = &uart1;
+	};
+
+	memory@60000000 {
+		device_type = "memory";
+		reg = <0x60000000 0x40000000>;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	adc-keys {
+		compatible = "adc-keys";
+		io-channels = <&saradc 1>;
+		io-channel-names = "buttons";
+		keyup-threshold-microvolt = <3300000>;
+
+		button-recovery {
+			label = "Recovery";
+			linux,code = <KEY_VENDOR>;
+			press-threshold-microvolt = <0>;
+		};
+	};
+
+	dc_5v: dc-5v-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "DC_5V";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	/*
+	 * This is a vbus-supply, which also supplies the GL852G usb hub,
+	 * thus has to be always-on
+	 */
+	host_pwr_5v: host-pwr-5v-regulator {
+		compatible = "regulator-fixed";
+		gpio = <&gpio3 RK_PC4 GPIO_ACTIVE_HIGH>;
+		startup-delay-us = <1500>;
+		regulator-name = "HOST_PWR_5V";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&dc_5v>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&host_drv>;
+		enable-active-high;
+		regulator-always-on;
+	};
+
+	ir-receiver {
+		compatible = "gpio-ir-receiver";
+		gpios = <&gpio3 RK_PD2 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&ir_int>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-power {
+			gpios = <&gpio0 RK_PD2 GPIO_ACTIVE_HIGH>;
+			function = LED_FUNCTION_POWER;
+			color = <LED_COLOR_ID_BLUE>;
+			default-state = "on";
+			pinctrl-names = "default";
+			pinctrl-0 = <&power_led>;
+		};
+
+		led-spd {
+			gpios = <&gpio3 RK_PB3 GPIO_ACTIVE_LOW>;
+			function = LED_FUNCTION_LAN;
+			color = <LED_COLOR_ID_GREEN>;
+			/*
+			 * currently not allowed to be set as per
+			 * https://www.kernel.org/doc/Documentation/devicetree/bindings/leds/common.yaml
+			 * and needs to set in userspace:
+			 *
+			 * linux,default-trigger = "netdev";
+			 */
+			pinctrl-names = "default";
+			pinctrl-0 = <&spd_led>;
+		};
+	};
+
+	mcu3v3: mcu3v3-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "MCU3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc_io>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vcc_ddr: vcc-ddr-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_DDR";
+		regulator-min-microvolt = <1500000>;
+		regulator-max-microvolt = <1500000>;
+		vin-supply = <&vcc_sys>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vcc_io: vcc-io-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_IO";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc_sys>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vcc_lan: vcc-lan-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_LAN";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc_io>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vcc_sd: vcc-sd-regulator {
+		compatible = "regulator-fixed";
+		gpio = <&gpio1 RK_PB6 GPIO_ACTIVE_LOW>;
+		startup-delay-us = <500>;
+		regulator-name = "VCC_SD";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc_io>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&sdmmc_pwren>;
+	};
+
+	vcc_sys: vcc-sys-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_SYS";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&dc_5v>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vcc33_hdmi: vcc33-hdmi-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC33_HDMI";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcca_33>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vcca_33: vcca-33-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "VCCA_33";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc_sys>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vdd_11: vdd-11-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "VDD_11";
+		regulator-min-microvolt = <1100000>;
+		regulator-max-microvolt = <1100000>;
+		vin-supply = <&vcc_sys>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vdd11_hdmi: vdd11-hdmi-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "VDD11_HDMI";
+		regulator-min-microvolt = <1100000>;
+		regulator-max-microvolt = <1100000>;
+		vin-supply = <&vdd_11>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vdd_arm: vdd-arm-regulator {
+		compatible = "pwm-regulator";
+		regulator-name = "VDD_ARM";
+		pwms = <&pwm1 0 25000 1>;
+		pwm-supply = <&vcc_sys>;
+		regulator-min-microvolt = <900000>;
+		regulator-max-microvolt = <1400000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	/*
+	 * As per schematics vdd_log is minimum 900 mV, maximum 1400 mV.
+	 * Since there are HW blocks in PD_LOGIC (which are all driven by
+	 * this supply), that either do not have a driver at all or the
+	 * driver does not implement regulator support we have to make
+	 * sure here that the voltage never drops below 1050 mV.
+	 */
+	vdd_log: vdd-log-regulator {
+		compatible = "pwm-regulator";
+		regulator-name = "VDD_LOG";
+		pwms = <&pwm2 0 25000 1>;
+		pwm-dutycycle-range = <30 100>;
+		pwm-supply = <&vcc_sys>;
+		regulator-min-microvolt = <1050000>;
+		regulator-max-microvolt = <1400000>;
+		regulator-ramp-delay = <4000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+};
+
+&cpu0 {
+	cpu-supply = <&vdd_arm>;
+};
+
+&emmc {
+	bus-width = <8>;
+	vmmc-supply = <&vcc_io>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&emmc_clk &emmc_cmd &emmc_bus8>;
+	cap-mmc-highspeed;
+	mmc-ddr-3_3v;
+	no-sd;
+	no-sdio;
+	status = "okay";
+};
+
+&gpio0 {
+	gpio-line-names = /* GPIO0 A0-A7 */
+			  "", "", "HEADER_5", "HEADER_3",
+			  "", "", "", "",
+			  /* GPIO0 B0-B7 */
+			  "HEADER_22", "HEADER_23", "", "HEADER_19",
+			  "HEADER_26", "HEADER_21", "HEADER_24", "",
+			  /* GPIO0 C0-C7 */
+			  "", "HEADER_18", "", "",
+			  "", "", "", "",
+			  /* GPIO0 D0-D7 */
+			  "HEADER_36", "", "", "",
+			  "", "", "HEADER_13", "";
+};
+
+&gpio1 {
+	gpio-line-names = /* GPIO1 A0-A7 */
+			  "HEADER_7", "HEADER_35", "HEADER_33", "HEADER_37",
+			  "HEADER_40", "HEADER_38", "", "",
+			  /* GPIO1 B0-B7 */
+			  "HEADER_11", "", "", "HEADER_29",
+			  "HEADER_31", "", "", "",
+			  /* GPIO1 C0-C7 */
+			  "", "", "", "",
+			  "", "", "", "",
+			  /* GPIO1 D0-D7 */
+			  "", "", "", "",
+			  "", "", "", "";
+};
+
+&gpio2 {
+	gpio-line-names = /* GPIO2 A0-A7 */
+			  "", "", "", "",
+			  "", "", "", "",
+			  /* GPIO2 B0-B7 */
+			  "", "", "", "",
+			  "", "", "", "",
+			  /* GPIO2 C0-C7 */
+			  "", "", "", "",
+			  "HEADER_27", "", "", "",
+			  /* GPIO2 D0-D7 */
+			  "", "", "HEADER_8", "HEADER_10",
+			  "", "", "", "";
+};
+
+&gpio3 {
+	gpio-line-names = /* GPIO3 A0-A7 */
+			  "", "", "", "",
+			  "", "", "", "",
+			  /* GPIO3 B0-B7 */
+			  "", "", "", "",
+			  "", "", "", "",
+			  /* GPIO3 C0-C7 */
+			  "", "HEADER_32", "", "",
+			  "", "", "", "HEADER_12",
+			  /* GPIO3 D0-D7 */
+			  "", "", "", "HEADER_15",
+			  "", "", "", "";
+};
+
+&pinctrl {
+	dp83848c {
+		dp83848c_rst: dp83848c-rst {
+			rockchip,pins = <2 RK_PD0 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	ir-receiver {
+		ir_int: ir-int {
+			rockchip,pins = <3 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	leds {
+		power_led: power-led {
+			rockchip,pins = <0 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		spd_led: spd-led {
+			rockchip,pins = <3 RK_PB3 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	usb2 {
+		host_drv: host-drv {
+			rockchip,pins = <3 RK_PC4 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
+
+&pwm1 {
+	status = "okay";
+};
+
+&pwm2 {
+	status = "okay";
+};
+
+&saradc {
+	vref-supply = <&vcc_io>;
+	status = "okay";
+};
+
+&sdmmc {
+	bus-width = <4>;
+	vmmc-supply = <&vcc_sd>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdmmc_bus4 &sdmmc_clk &sdmmc_cmd &sdmmc_det>;
+	disable-wp;
+	cap-sd-highspeed;
+	no-mmc;
+	no-sdio;
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&usb_host_ehci {
+	status = "okay";
+};
+
+&usb_otg {
+	vusb_a-supply = <&vcc_io>;
+	vusb_d-supply = <&vdd_11>;
+	status = "okay";
+};
+
+&usb2phy {
+	status = "okay";
+};
+
+&usb2phy_host {
+	status = "okay";
+};
+
+&usb2phy_otg {
+	status = "okay";
+};
-- 
2.42.0

