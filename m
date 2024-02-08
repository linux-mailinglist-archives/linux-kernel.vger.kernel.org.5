Return-Path: <linux-kernel+bounces-57730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C384E84DCC9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B9D61F25E4D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715C26E2D9;
	Thu,  8 Feb 2024 09:22:14 +0000 (UTC)
Received: from esa1.ltts.com (unknown [118.185.121.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13E26DCF0;
	Thu,  8 Feb 2024 09:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.185.121.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707384134; cv=none; b=BzgkJG1Opx2DjZkyy0us8w59RR2fytTc/MFboSQOmG19ZuMukGwW8Sq+tiPxA3sFT4poc4Z1xR9uGs37TA3uVhl8hhtqmbgFzd4rKJETUu0E0Q+rlRvCZ0eU6NcvRHahahOpVDT91TUXjCLFeM2lnaogX5xr299Ht1S1xI4DT6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707384134; c=relaxed/simple;
	bh=kgd5rZlmo0eQ4+URWAldLJfV0Lypdy0Upba1rC9o8CM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I3WTi55uVmgL9pt52w56tjYj086pkiG7cH7PKQTKws0cUd3WUywUEWZQmYMUKbI9uZmdInwEzKBvCDp8R4PTLRF27VeD1noIFtDqHNnDWhEpXXxPJRl5SQGS8awZw/hxk0ZYUsEMCbdHADUhjW35O0m3wLYiekaldghi4qjOPi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com; spf=pass smtp.mailfrom=ltts.com; arc=none smtp.client-ip=118.185.121.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ltts.com
IronPort-SDR: rU+DpzZ/1CEGLV2wzYkbY8STYN9oEHrTewE4f0EaDxszeTn4TIr5poME84qz1IdchsEREtE6Eu
 G6L12kpHNPjg==
Received: from unknown (HELO localhost.localdomain) ([192.168.34.55])
  by esa1.ltts.com with ESMTP; 08 Feb 2024 14:52:08 +0530
From: Bhargav Raviprakash <bhargav.r@ltts.com>
To: linux-kernel@vger.kernel.org
Cc: m.nirmaladevi@ltts.com,
	nm@ti.com,
	vigneshr@ti.com,
	kristo@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	Bhargav Raviprakash <bhargav.r@ltts.com>
Subject: [PATCH v1 13/13] arch: arm64: dts: ti: k3-am62p5-sk: Add TPS65224 PMIC support in AM62P dts
Date: Thu,  8 Feb 2024 14:51:53 +0530
Message-Id: <20240208092153.1207321-1-bhargav.r@ltts.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for TPS65224 PMIC in device tree of AM62P EVM. Adds
regulator configuration, pinmux configurations and pmic device nodes.

Signed-off-by: Bhargav Raviprakash <bhargav.r@ltts.com>
---
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts | 95 +++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
index 1773c05f7..5d8e4321b 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
@@ -112,6 +112,16 @@ vddshv_sdio: regulator-3 {
 		bootph-all;
 	};
 
+	vcc_3v3_main: regulator-4 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_3v3_main";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vmain_pd>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
@@ -580,6 +590,12 @@ &main_uart1 {
 &mcu_pmx0 {
 	bootph-all;
 
+	pmic_irq_pins_default: pmic-irq-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_MCU_IOPAD(0x000, PIN_INPUT, 7) /* (B10) MCU_GPIO0_0 */
+		>;
+	};
+
 	wkup_uart0_pins_default: wkup-uart0-default-pins {
 		pinctrl-single,pins = <
 			AM62PX_MCU_IOPAD(0x02c, PIN_INPUT, 0)	/* (C7) WKUP_UART0_CTSn */
@@ -589,6 +605,13 @@ AM62PX_MCU_IOPAD(0x028, PIN_OUTPUT, 0)	/* (D7) WKUP_UART0_TXD */
 		>;
 		bootph-all;
 	};
+
+	wkup_i2c0_pins_default: wkup-i2c0-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_MCU_IOPAD(0x04c, PIN_INPUT, 0) /* (A13) WKUP_I2C0_SCL */
+			AM62PX_MCU_IOPAD(0x050, PIN_INPUT, 0) /* (C11) WKUP_I2C0_SDA */
+		>;
+	};
 };
 
 &wkup_uart0 {
@@ -599,6 +622,78 @@ &wkup_uart0 {
 	bootph-all;
 };
 
+&wkup_i2c0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&wkup_i2c0_pins_default>;
+	clock-frequency = <400000>;
+
+	tps65224: pmic@48 {
+		compatible = "ti,tps65224-q1";
+		reg = <0x48>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pmic_irq_pins_default>;
+		interrupt-parent = <&mcu_gpio0>;
+		interrupts = <0 IRQ_TYPE_EDGE_FALLING>;
+		ti,primary-pmic;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		buck12-supply = <&vcc_3v3_main>;
+		buck3-supply = <&vcc_3v3_main>;
+		buck4-supply = <&vcc_3v3_main>;
+
+		ldo1-supply = <&vcc_3v3_main>;
+		ldo2-supply = <&vcc_3v3_main>;
+		ldo3-supply = <&vcc1v8_sys>;
+
+		regulators {
+			vcc_core: buck12 {
+				regulator-name = "vcc_core_buck12";
+				regulator-min-microvolt = <715000>;
+				regulator-max-microvolt = <895000>;
+				regulator-always-on;
+			};
+
+			vcc1v8_sys: buck3 {
+				regulator-name = "vcc1v8_sys_buck3";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+			};
+
+			vcc1v1: buck4 {
+				regulator-name = "vcc1v1_buck4";
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-always-on;
+			};
+
+			vdda1v8: ldo1 {
+				regulator-name = "vdda1v8_ldo1";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+			};
+
+			dvdd3v3: ldo2 {
+				regulator-name = "dvdd3v3_ldo2";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vcc_0v85: ldo3 {
+				regulator-name = "vcc_0v85_ldo3";
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <850000>;
+				regulator-always-on;
+			};
+		};
+	};
+};
+
 /* mcu_gpio0 and mcu_gpio_intr are reserved for mcu firmware usage */
 &mcu_gpio0 {
 	status = "reserved";
-- 
2.25.1


