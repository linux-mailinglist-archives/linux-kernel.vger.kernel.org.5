Return-Path: <linux-kernel+bounces-123456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9D28908E4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 906471C2BA72
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B8F1386BD;
	Thu, 28 Mar 2024 19:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYL2Yyc0"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BDA1386A2;
	Thu, 28 Mar 2024 19:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711653134; cv=none; b=KdyJiMtCNfVZ0UXqJS/e0iYnuWQj2/M+YyGb3j2L3PjNg6VIsgM/CfbvxHZOHqVkO96snbFWr5BhGdqgr8j/15U9niIYXWotkOTmHZSEDev2hpdylhPsl3qkr9AOE8MJboViA23TmZSO1j8LweFNYYhK0HQ/MlY147soCIwn0RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711653134; c=relaxed/simple;
	bh=4Vsyk4TFiGLglk1w8fEyiBWW8LBe9CzA4gQvWndnFnk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dWyR8CHAQnLAWrKq44FhOJdUohZ8JQbH9hP2tK0h4rcJxioGt8b+QLzALrwXLbMkcIkaFtXVtGKe8KbVWkcKB8LL2HsvkjN8c/wsvboUdZWYZiHrRp/ZlrFUGyqhV1fmGkXYdhyJFIKcAbCX8IarrDG69PTTUD1nFYMsdCpq+kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NYL2Yyc0; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7cc0e0dba0fso43415739f.3;
        Thu, 28 Mar 2024 12:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711653132; x=1712257932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ukZCJ4uc+MB5kyzOOj5g81tjbIKBTXypfbc2rD62QME=;
        b=NYL2Yyc0NCo5ZvKFaV1AbPU0Kghos67Z5cAchHHnbleXR8xx0ayJvpObDf9dZ5S3Kw
         dal4dlXWAdvCmroHEw8yWEEmndWoq/0Xgclhi+g7oa29DeHX8MCwqBhQArLkSHvyVkQ9
         E2LuHW8sZXb1wh0A4PVLIZb17M3ZqrIjeii3iIp7QqiFF8FLTn1PrAQQumDGvLU/1YEu
         jJ+bESxG/DgC7/ZadOLvTyKgHYvG9I8FZirnakhaqvl5j/KvoBi+d0fsIJ5BzGd8S8/i
         B8LsY/ohc1757yIowfcqoCQdJM8gX6h0oUJhQj4+hURt/sDyWTztsvFn3bmvf+pfR3Le
         P/jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711653132; x=1712257932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ukZCJ4uc+MB5kyzOOj5g81tjbIKBTXypfbc2rD62QME=;
        b=qroypXRAnX/L2DSNYtcWBAPtE/x/7vQpq6qHHkO9A224fXpR3rQlCAVNOY7Li0qehu
         OdAOKa5UAPDQR1Q6mT7GhlaGAW5YCiA4B6ja2Y3FKQeHGT0PEoOHit/hPYTuvDY3hv1Q
         x69yQKzYLA2e5BqXuCkIrUBFBQIQX8bdLIpuuOhtWG5kGKLYh2QXaqaN9id5HbTP3BO9
         cKNsv3xPPGTU4so8DWJ8r45riXRWNV2Gv1bE2IXwgyKb30PtwTHs+aKKJTdG2hV/DU6t
         mCxTanOmX7Fy+aO333o0PzPT3x1lhVJ6qv/1lbvD9cvFTc5+4LRc+CQHohfHt1jiCInm
         uBfA==
X-Forwarded-Encrypted: i=1; AJvYcCUfnFE0D63WCjI/nu+AaRzdS9N4CIl3wbpBcgOajHFcD+/7f9OWb47i0hhH8hTHyNiu0IDrjX9ugvHAJAO5X2M9BMnoSLGKDE9L63H5qLEsUzi6ScOQrvOU/6acqnjR4jXmDidYe5H3Vw==
X-Gm-Message-State: AOJu0YybFVrt6ccOM2Dkm3FixLx32LzNemJ56KueSHJBBuT59XwNidFP
	AKG6IQgn7+km1b47066837PO0hVPUlJck7N9U2yTsJRW9/+g3ouZ
X-Google-Smtp-Source: AGHT+IFnQhOawrJU7MYLGLrAKeVYV0fOW7fowi/yhXyfiK5uSz22gMU+u4Q1ieJWYGh4NUUqPKUnFQ==
X-Received: by 2002:a92:ca87:0:b0:365:1d57:6da0 with SMTP id t7-20020a92ca87000000b003651d576da0mr4131685ilo.26.1711653132036;
        Thu, 28 Mar 2024 12:12:12 -0700 (PDT)
Received: from hestia.. (208-107-161-31-dynamic.midco.net. [208.107.161.31])
        by smtp.gmail.com with ESMTPSA id e13-20020a056e0204ad00b003685ea08fb3sm590301ils.73.2024.03.28.12.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 12:12:11 -0700 (PDT)
From: Robert Nelson <robertcnelson@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Robert Nelson <robertcnelson@gmail.com>,
	Nishanth Menon <nm@ti.com>,
	Jared McArthur <j-mcarthur@ti.com>,
	Jason Kridner <jkridner@beagleboard.org>,
	Deepak Khatri <lorforlinux@beagleboard.org>
Subject: [PATCH 2/2] arm64: dts: ti: Add k3-j722s-beagley-ai
Date: Thu, 28 Mar 2024 14:12:05 -0500
Message-Id: <20240328191205.82295-2-robertcnelson@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240328191205.82295-1-robertcnelson@gmail.com>
References: <20240328191205.82295-1-robertcnelson@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BeagleBoard.org BeagleY-AI is an easy to use, affordable open source
hardware single board computer based on the Texas Instruments AM67A,
which features a quad-core 64-bit Arm CPU subsystem, 2 general-purpose
digital-signal-processors (DSP) and matrix-multiply-accelerators (MMA),
GPU, vision and deep learning accelerators, and multiple Arm Cortex-R5
cores for low-power, low-latency GPIO control.

https://beagley-ai.org/
https://openbeagle.org/beagley-ai/beagley-ai

Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
CC: Nishanth Menon <nm@ti.com>
CC: Jared McArthur <j-mcarthur@ti.com>
CC: Jason Kridner <jkridner@beagleboard.org>
CC: Deepak Khatri <lorforlinux@beagleboard.org>
---
 arch/arm64/boot/dts/ti/Makefile               |   1 +
 .../arm64/boot/dts/ti/k3-j722s-beagley-ai.dts | 373 ++++++++++++++++++
 2 files changed, 374 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j722s-beagley-ai.dts

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 9a722c2473fb..c76b41f86527 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -95,6 +95,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-j721s2-evm.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-j721s2-evm-pcie1-ep.dtbo
 
 # Boards with J722s SoC
+dtb-$(CONFIG_ARCH_K3) += k3-j722s-beagley-ai.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-j722s-evm.dtb
 
 # Boards with J784s4 SoC
diff --git a/arch/arm64/boot/dts/ti/k3-j722s-beagley-ai.dts b/arch/arm64/boot/dts/ti/k3-j722s-beagley-ai.dts
new file mode 100644
index 000000000000..a6e5a4243bef
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-j722s-beagley-ai.dts
@@ -0,0 +1,373 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * https://beagley-ai.org/
+ *
+ * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2024 Robert Nelson, BeagleBoard.org Foundation
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/net/ti-dp83867.h>
+#include "k3-j722s.dtsi"
+
+/ {
+	compatible = "beagle,j722s-beagley-ai", "ti,j722s";
+	model = "BeagleBoard.org BeagleY-AI";
+
+	aliases {
+		serial0 = &wkup_uart0;
+		serial2 = &main_uart0;
+		mmc0 = &sdhci1;
+	};
+
+	chosen {
+		stdout-path = &main_uart0;
+	};
+
+	memory@80000000 {
+		/* 4G RAM */
+		reg = <0x00000000 0x80000000 0x00000000 0x80000000>,
+		      <0x00000008 0x80000000 0x00000000 0x80000000>;
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
+	vsys_5v0: regulator-1 {
+		compatible = "regulator-fixed";
+		regulator-name = "vsys_5v0";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+		regulator-boot-on;
+		bootph-all;
+	};
+
+	vdd_3v3: regulator-2 {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vsys_5v0>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vdd_mmc1: regulator-mmc1 {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_mmc1";
+		pinctrl-names = "default";
+		pinctrl-0 = <&vdd_3v3_sd_pins_default>;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		enable-active-high;
+		gpio = <&main_gpio1 50 GPIO_ACTIVE_HIGH>;
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
+		gpios = <&main_gpio1 49 GPIO_ACTIVE_HIGH>;
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
+			J722S_IOPAD(0x0244, PIN_OUTPUT, 7) /* (A24) MMC1_SDWP.GPIO1_49 */
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
+
+	mdio_pins_default: mdio-default-pins {
+		pinctrl-single,pins = <
+			J722S_IOPAD(0x0160, PIN_OUTPUT, 0) /* (AC24) MDIO0_MDC */
+			J722S_IOPAD(0x015c, PIN_INPUT, 0) /* (AD25) MDIO0_MDIO */
+		>;
+	};
+
+	rgmii1_pins_default: rgmii1-default-pins {
+		pinctrl-single,pins = <
+			J722S_IOPAD(0x014c, PIN_INPUT, 0) /* (AC25) RGMII1_RD0 */
+			J722S_IOPAD(0x0150, PIN_INPUT, 0) /* (AD27) RGMII1_RD1 */
+			J722S_IOPAD(0x0154, PIN_INPUT, 0) /* (AE24) RGMII1_RD2 */
+			J722S_IOPAD(0x0158, PIN_INPUT, 0) /* (AE26) RGMII1_RD3 */
+			J722S_IOPAD(0x0148, PIN_INPUT, 0) /* (AE27) RGMII1_RXC */
+			J722S_IOPAD(0x0144, PIN_INPUT, 0) /* (AD23) RGMII1_RX_CTL */
+			J722S_IOPAD(0x0134, PIN_OUTPUT, 0) /* (AF27) RGMII1_TD0 */
+			J722S_IOPAD(0x0138, PIN_OUTPUT, 0) /* (AE23) RGMII1_TD1 */
+			J722S_IOPAD(0x013c, PIN_OUTPUT, 0) /* (AG25) RGMII1_TD2 */
+			J722S_IOPAD(0x0140, PIN_OUTPUT, 0) /* (AF24) RGMII1_TD3 */
+			J722S_IOPAD(0x0130, PIN_OUTPUT, 0) /* (AG26) RGMII1_TXC */
+			J722S_IOPAD(0x012c, PIN_OUTPUT, 0) /* (AF25) RGMII1_TX_CTL */
+		>;
+	};
+
+	pmic_irq_pins_default: pmic-irq-default-pins {
+		pinctrl-single,pins = <
+			J722S_IOPAD(0x01f4, PIN_INPUT_PULLUP, 0) /* (B23) EXTINTn */
+		>;
+	};
+
+	vdd_3v3_sd_pins_default: vdd-3v3-sd-pins-default {
+		pinctrl-single,pins = <
+			J722S_IOPAD(0x0254, PIN_OUTPUT, 7) /* (E25) USB0_DRVVBUS.GPIO1_50 */
+		>;
+	};
+};
+
+&cpsw3g {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&rgmii1_pins_default>, <&gbe_pmx_obsclk>;
+
+	assigned-clocks = <&k3_clks 227 0>;
+	assigned-clock-parents = <&k3_clks 227 6>;
+};
+
+&cpsw3g_mdio {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mdio_pins_default>;
+
+	cpsw3g_phy0: ethernet-phy@0 {
+		reg = <0>;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+		ti,min-output-impedance;
+	};
+};
+
+&cpsw_port1 {
+	phy-mode = "rgmii-rxid";
+	phy-handle = <&cpsw3g_phy0>;
+};
+
+&cpsw_port2 {
+	status = "disabled";
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
+
+	gbe_pmx_obsclk: gbe-pmx-obsclk-default-pins {
+		pinctrl-single,pins = <
+			J722S_MCU_IOPAD(0x0004, PIN_OUTPUT, 1) /* (A10) MCU_SPI0_CS1.MCU_OBSCLK0 */
+		>;
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
+
+	tps65219: pmic@30 {
+		bootph-all;
+		compatible = "ti,tps65219";
+		reg = <0x30>;
+		buck1-supply = <&vsys_5v0>;
+		buck2-supply = <&vsys_5v0>;
+		buck3-supply = <&vsys_5v0>;
+		ldo1-supply = <&vdd_3v3>;
+		ldo3-supply = <&vdd_3v3>;
+		ldo4-supply = <&vdd_3v3>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&pmic_irq_pins_default>;
+		interrupt-parent = <&gic500>;
+		interrupts = <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+
+		system-power-controller;
+		ti,power-button;
+
+		regulators {
+			buck1_reg: buck1 {
+				regulator-name = "VDD_3V3";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck2_reg: buck2 {
+				regulator-name = "VDD_1V8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck3_reg: buck3 {
+				regulator-name = "VDD_1V1";
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo1_reg: ldo1 {
+				regulator-name = "VDDSHV5_SDIO";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-allow-bypass;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo2_reg: ldo2 {
+				//Regulator is left as is unused.
+			};
+
+			ldo3_reg: ldo3 {
+				regulator-name = "VDDA_PHY_1V8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo4_reg: ldo4 {
+				regulator-name = "VDDA_PLL_1V8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
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
2.39.2


