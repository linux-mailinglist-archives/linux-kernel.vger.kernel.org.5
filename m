Return-Path: <linux-kernel+bounces-54647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1741A84B1EF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C17182868CF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5D812DD89;
	Tue,  6 Feb 2024 10:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Doe73gYQ"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C6F12D157;
	Tue,  6 Feb 2024 10:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707213993; cv=none; b=UMwU5EEx9QteYQHtmrLR8SjBImZbD0z8bZzLKjmS7YpvT5ucmiyw0/UFnl3ndNsagRVKPfMR4ozEn+J6ORg0aAOGEJDIx+YdRbalHHH2+bBKYl6KgVLsLFZZubCsKzw9MlUzzpb+Is6mhzcRY7iVGqMhpR9zvKhiNNzUinEYygY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707213993; c=relaxed/simple;
	bh=BPWC43usjSThc3IEABHx4nRO7PdGF0hvNQGZktVrz6c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l3hU3xiUbXkjEQy+ruDLLgw/twm6S5gSvP22hD+XEsdN/xjlt1yAPVKphQOwV1Dr5lTGWV9eKlyp9eiQld1OkmSABaXIZbOvdW+U5xebq0pjtIpM8H9PQHMcNvKONSUnJJ47q6vk2nRNmL/Q88DCUhl4Sk0TtHk9II49UM/k980=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Doe73gYQ; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 416A6O8j106871;
	Tue, 6 Feb 2024 04:06:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707213984;
	bh=lGhdZq8s4SjIXv+gN1KaqW3LZuS8EExOGSe7YHxMR80=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Doe73gYQhLrrwUJvMHVmyO9z1cumTTL+8h2LdlKIN7bcNKf2J63O6keU4p8fMoUll
	 UqHiPeCvN1xGY+HV0XQ6xZt6AdsbYXfYO55qTNLL1FVMAilbadIBfkvOhmtcCVTMN+
	 yNdTZcrmpJuNfwYm80XtQKECYXKQTXqPOR9KwkOE=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 416A6OAg065411
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Feb 2024 04:06:24 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Feb 2024 04:06:24 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Feb 2024 04:06:24 -0600
Received: from uda0490681.. ([10.24.69.142])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 416A68qv054893;
	Tue, 6 Feb 2024 04:06:21 -0600
From: Vaishnav Achath <vaishnav.a@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <conor+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <kristo@kernel.org>,
        <robh+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>, <vaishnav.a@ti.com>,
        <j-choudhary@ti.com>
Subject: [PATCH v2 3/3] arm64: dts: ti: Add support for TI J722S Evaluation Module
Date: Tue, 6 Feb 2024 15:36:08 +0530
Message-ID: <20240206100608.127702-4-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206100608.127702-1-vaishnav.a@ti.com>
References: <20240206100608.127702-1-vaishnav.a@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add basic support for the J722S EVM with UART console and
MMC SD as rootfs.

Schematics are available at:
	https://www.ti.com/lit/zip/sprr495

Co-developed-by: Jayesh Choudhary <j-choudhary@ti.com>
Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
---

V1->V2:
  * Address feedback from Nishanth to reuse from AM62P5 dtsi.
  * Remove bootph-all from root nodes.
  * Change License to GPL-2.0-only OR MIT as followed for other
    K3 files.
  * Add label for reserved_memory node.

 arch/arm64/boot/dts/ti/Makefile         |   3 +
 arch/arm64/boot/dts/ti/k3-j722s-evm.dts | 251 ++++++++++++++++++++++++
 2 files changed, 254 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j722s-evm.dts

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 52c1dc910308..ecd11f444e81 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -78,6 +78,9 @@ k3-j721s2-evm-dtbs := k3-j721s2-common-proc-board.dtb k3-j721s2-evm-gesi-exp-boa
 dtb-$(CONFIG_ARCH_K3) += k3-j721s2-evm.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-j721s2-evm-pcie1-ep.dtbo
 
+# Boards with J722s SoC
+dtb-$(CONFIG_ARCH_K3) += k3-j722s-evm.dtb
+
 # Boards with J784s4 SoC
 dtb-$(CONFIG_ARCH_K3) += k3-am69-sk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm.dtb
diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
new file mode 100644
index 000000000000..b4f2fee53a97
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
@@ -0,0 +1,251 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Device Tree file for the J722S EVM
+ * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
+ *
+ * Schematics: https://www.ti.com/lit/zip/sprr495
+ */
+
+/dts-v1/;
+
+#include "k3-j722s.dtsi"
+
+/ {
+	compatible = "ti,j722s-evm", "ti,j722s";
+	model = "Texas Instruments J722S EVM";
+
+	aliases {
+		serial0 = &wkup_uart0;
+		serial2 = &main_uart0;
+		mmc0 = &sdhci0;
+		mmc1 = &sdhci1;
+	};
+
+	chosen {
+		stdout-path = &main_uart0;
+	};
+
+	memory@80000000 {
+		/* 8G RAM */
+		reg = <0x00000000 0x80000000 0x00000000 0x80000000>,
+		      <0x00000008 0x80000000 0x00000001 0x80000000>;
+		device_type = "memory";
+		bootph-pre-ram;
+	};
+
+	reserved_memory: reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		secure_tfa_ddr: tfa@9e780000 {
+			reg = <0x00 0x9e780000 0x00 0x80000>;
+			no-map;
+		};
+
+		secure_ddr: optee@9e800000 {
+			reg = <0x00 0x9e800000 0x00 0x01800000>;
+			no-map;
+		};
+
+		wkup_r5fss0_core0_memory_region: r5f-memory@a0100000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa0100000 0x00 0xf00000>;
+			no-map;
+		};
+
+	};
+
+	vmain_pd: regulator-0 {
+		/* TPS65988 PD CONTROLLER OUTPUT */
+		compatible = "regulator-fixed";
+		regulator-name = "vmain_pd";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+		regulator-boot-on;
+		bootph-all;
+	};
+
+	vsys_5v0: regulator-vsys5v0 {
+		/* Output of LM5140 */
+		compatible = "regulator-fixed";
+		regulator-name = "vsys_5v0";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vmain_pd>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vdd_mmc1: regulator-mmc1 {
+		/* TPS22918DBVR */
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_mmc1";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		enable-active-high;
+		gpio = <&exp1 15 GPIO_ACTIVE_HIGH>;
+		bootph-all;
+	};
+
+	vdd_sd_dv: regulator-TLV71033 {
+		compatible = "regulator-gpio";
+		regulator-name = "tlv71033";
+		pinctrl-names = "default";
+		pinctrl-0 = <&vdd_sd_dv_pins_default>;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		vin-supply = <&vsys_5v0>;
+		gpios = <&main_gpio0 70 GPIO_ACTIVE_HIGH>;
+		states = <1800000 0x0>,
+			 <3300000 0x1>;
+	};
+
+	vsys_io_1v8: regulator-vsys-io-1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "vsys_io_1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vsys_io_1v2: regulator-vsys-io-1v2 {
+		compatible = "regulator-fixed";
+		regulator-name = "vsys_io_1v2";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+};
+
+&main_pmx0 {
+
+	main_i2c0_pins_default: main-i2c0-default-pins {
+		pinctrl-single,pins = <
+			J722S_IOPAD(0x01e0, PIN_INPUT_PULLUP, 0) /* (D23) I2C0_SCL */
+			J722S_IOPAD(0x01e4, PIN_INPUT_PULLUP, 0) /* (B22) I2C0_SDA */
+		>;
+		bootph-all;
+	};
+
+	main_uart0_pins_default: main-uart0-default-pins {
+		pinctrl-single,pins = <
+			J722S_IOPAD(0x01c8, PIN_INPUT, 0)	/* (A22) UART0_RXD */
+			J722S_IOPAD(0x01cc, PIN_OUTPUT, 0)	/* (B22) UART0_TXD */
+		>;
+		bootph-all;
+	};
+
+	vdd_sd_dv_pins_default: vdd-sd-dv-default-pins {
+		pinctrl-single,pins = <
+			J722S_IOPAD(0x0120, PIN_INPUT, 7) /* (F27) MMC2_CMD.GPIO0_70 */
+		>;
+		bootph-all;
+	};
+
+	main_mmc1_pins_default: main-mmc1-default-pins {
+		pinctrl-single,pins = <
+			J722S_IOPAD(0x023c, PIN_INPUT, 0) /* (H22) MMC1_CMD */
+			J722S_IOPAD(0x0234, PIN_OUTPUT, 0) /* (H24) MMC1_CLK */
+			J722S_IOPAD(0x0230, PIN_INPUT, 0) /* (H23) MMC1_DAT0 */
+			J722S_IOPAD(0x022c, PIN_INPUT_PULLUP, 0) /* (H20) MMC1_DAT1 */
+			J722S_IOPAD(0x0228, PIN_INPUT_PULLUP, 0) /* (J23) MMC1_DAT2 */
+			J722S_IOPAD(0x0224, PIN_INPUT_PULLUP, 0) /* (H25) MMC1_DAT3 */
+			J722S_IOPAD(0x0240, PIN_INPUT, 0) /* (B24) MMC1_SDCD */
+		>;
+		bootph-all;
+	};
+};
+
+&main_gpio1 {
+	status = "okay";
+};
+
+&main_uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_uart0_pins_default>;
+	status = "okay";
+	bootph-all;
+};
+
+&mcu_pmx0 {
+
+	wkup_uart0_pins_default: wkup-uart0-default-pins {
+		pinctrl-single,pins = <
+			J722S_MCU_IOPAD(0x02c, PIN_INPUT, 0)	/* (C7) WKUP_UART0_CTSn */
+			J722S_MCU_IOPAD(0x030, PIN_OUTPUT, 0)	/* (C6) WKUP_UART0_RTSn */
+			J722S_MCU_IOPAD(0x024, PIN_INPUT, 0)	/* (D8) WKUP_UART0_RXD */
+			J722S_MCU_IOPAD(0x028, PIN_OUTPUT, 0)	/* (D7) WKUP_UART0_TXD */
+		>;
+		bootph-all;
+	};
+
+	wkup_i2c0_pins_default: wkup-i2c0-default-pins {
+		pinctrl-single,pins = <
+			J722S_MCU_IOPAD(0x04c, PIN_INPUT_PULLUP, 0)	/* (C7) WKUP_I2C0_SCL */
+			J722S_MCU_IOPAD(0x050, PIN_INPUT_PULLUP, 0)	/* (C6) WKUP_I2C1_SDA */
+		>;
+		bootph-all;
+	};
+};
+
+&wkup_uart0 {
+	/* WKUP UART0 is used by Device Manager firmware */
+	pinctrl-names = "default";
+	pinctrl-0 = <&wkup_uart0_pins_default>;
+	status = "reserved";
+	bootph-all;
+};
+
+&wkup_i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&wkup_i2c0_pins_default>;
+	clock-frequency = <400000>;
+	status = "okay";
+	bootph-all;
+};
+
+&main_i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c0_pins_default>;
+	clock-frequency = <400000>;
+	status = "okay";
+	bootph-all;
+
+	exp1: gpio@23 {
+		compatible = "ti,tca6424";
+		reg = <0x23>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names = "TRC_MUX_SEL", "OSPI/ONAND_MUX_SEL",
+				  "MCASP1_FET_SEL", "CTRL_PM_I2C_OE#",
+				  "CSI_VIO_SEL", "USB2.0_MUX_SEL",
+				  "CSI01_MUX_SEL_2", "CSI23_MUX_SEL_2",
+				  "LMK1_OE1", "LMK1_OE0",
+				  "LMK2_OE0", "LMK2_OE1",
+				  "GPIO_RGMII1_RST#", "GPIO_AUD_RSTn",
+				  "GPIO_eMMC_RSTn", "GPIO_uSD_PWR_EN",
+				  "USER_LED2", "MCAN0_STB",
+				  "PCIe0_1L_RC_RSTz", "PCIe0_1L_PRSNT#",
+				  "ENET1_EXP_SPARE2", "ENET1_EXP_PWRDN",
+				  "PD_I2ENET1_I2CMUX_SELC_IRQ", "ENET1_EXP_RESETZ";
+	};
+};
+
+&sdhci1 {
+	/* SD/MMC */
+	vmmc-supply = <&vdd_mmc1>;
+	vqmmc-supply = <&vdd_sd_dv>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mmc1_pins_default>;
+	ti,driver-strength-ohm = <50>;
+	disable-wp;
+	no-1-8-v;
+	status = "okay";
+	bootph-all;
+};
-- 
2.34.1


