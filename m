Return-Path: <linux-kernel+bounces-158896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 737138B266B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF9B61F224E4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CC214D428;
	Thu, 25 Apr 2024 16:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNBZ5yxw"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C684614D457;
	Thu, 25 Apr 2024 16:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714062519; cv=none; b=PN786RswB3QCWE7rRC8h0NwZLLlO3Y+3iL9dFQXYkFBqPCEEzl+xnYORl0R1gDcj5yiC0pccWO0jbGB7JxZTw65JBGu8xPwCFaa+3LPVAUZGHTLh8nuy0wUvhnjhWMn9gyhSYnCctHoHAyT4BhRoCQuIxb0VZArBKK/9OSNCJAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714062519; c=relaxed/simple;
	bh=RUIGo7rrh1WHFdfnH99LObdmfmbbrpfNeZvt1s0l3qA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mAnMJwmQ+a3t1Kp+5yFIToRiWABxYiIZVO6lvFMTTQa4wkomLkQadFSnjK8hPcPZaLDfvMKgYVw0RNd71JH6f7E6Wx8YnXifNRz1SPdvNg/4k6b1i224wFqdCWbqUKqmfpSXqHvLkoCfIgmyqcJNaxZVHDoAQ88ZmR8NIHeR0hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hNBZ5yxw; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7de85f29cb0so50946339f.0;
        Thu, 25 Apr 2024 09:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714062517; x=1714667317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2dqtyb0PS5quZ/3VvB6lffJvG9bs8V8Nd0153Xnf+Xw=;
        b=hNBZ5yxwt5X9MuJeI2Qy/CJIaLyE2Tz2rxAGo3jfeLVnfc7P3A+2c89ks//M3n1FTR
         kSHk1JkkL3AokpOR28WK4EAYzF5U/s6DbZBDtyVVmBcXoekP05wwqvQhbQGFBI3Hr0tJ
         yEVjbNHwRi9EI+xaK59CJHZzKXWRbU2OfV9snW33m/rxl8YESUKjnDgMoKWC54G8JcUw
         E/MzMUvpT7W+pt6K4oL8hq1nu3uoWIa3scpKdK5lXpg2jo5qX4u5Ck++EDa5jzQH1VZM
         V2+aa5PWKUOX9pMbQp5f8N1+XJfjOtFt/tQAZGrXjB024rA5ACJr9JThia8PQlNa/oi6
         6Olg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714062517; x=1714667317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2dqtyb0PS5quZ/3VvB6lffJvG9bs8V8Nd0153Xnf+Xw=;
        b=wVZgP/AfVx+373VC3+I3G8EZ8rVnBgWq5QbRS+1TDNzF6wV6S7LtRtJv8u2BeyMv7v
         YrmIOlRIv7MIXJgmZx4nR6XCHjipMygZQXcSViLPr5Q5sCfGax+e98EvSITAfYR+lQ8V
         RCl1yRSRGdpdrNEC1xMIseb8U2cjPirfmiqgdrjU9DzCSMxmHNgHUK9zGLXyCDh8sLGj
         Gc69DBiJwjpKxmzMsw00akgk7a2dOce8L3tSyCznUcFgbGbBlsHh/bgb6yXRZPjwZ9U8
         Bfps6EA8YdF9sxS4HrF2ssfpDgigvIoI1Md3Dj498u63FIaVHFe9FDLmaOeeyPzCFwZO
         Fl4g==
X-Forwarded-Encrypted: i=1; AJvYcCW8u07FLLBM+E6pBFShdG7z9n0rd56rYqfaD5dNT9yNjfRM/UkCDsJK/eatM9Ygras7G8ZeZILrw+R9iIp4QnUsCqeTpskNU4D5lWCTHaY6CmBG69opJSogoxli8Y8bwoBYuYQ3hFIyHQ==
X-Gm-Message-State: AOJu0Yy0NKFDr7kPOXR/5LMyupm1gx2XPBLhhxIymfgyF9xLl1GMbQ/4
	YmF6lEmfR7iQX7B5pDdRu7P4hx0o3axrmic3VOPK9tiuYcGKs4CoGIofmg==
X-Google-Smtp-Source: AGHT+IE6ZkrdkE3qU+2AfxqtxdNz86RAfHkPRIl9KTu4N75qh/CCQuQqIYu7VPGTjmwiYtXf3qfatg==
X-Received: by 2002:a05:6602:4f0e:b0:7d0:d84d:9e13 with SMTP id gl14-20020a0566024f0e00b007d0d84d9e13mr162340iob.19.1714062516733;
        Thu, 25 Apr 2024 09:28:36 -0700 (PDT)
Received: from hestia.. (208-107-161-31-static.midco.net. [208.107.161.31])
        by smtp.gmail.com with ESMTPSA id g21-20020a056602151500b007da63ce9a48sm3386171iow.49.2024.04.25.09.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 09:28:36 -0700 (PDT)
From: Robert Nelson <robertcnelson@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Robert Nelson <robertcnelson@gmail.com>,
	Andrew Davis <afd@ti.com>,
	Nishanth Menon <nm@ti.com>,
	Jared McArthur <j-mcarthur@ti.com>,
	Jason Kridner <jkridner@beagleboard.org>,
	Deepak Khatri <lorforlinux@beagleboard.org>,
	Drew Fustini <drew@beagleboard.org>
Subject: [PATCH v2 2/2] arm64: dts: ti: Add k3-am67a-beagley-ai
Date: Thu, 25 Apr 2024 11:28:29 -0500
Message-Id: <20240425162829.2370614-2-robertcnelson@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240425162829.2370614-1-robertcnelson@gmail.com>
References: <20240425162829.2370614-1-robertcnelson@gmail.com>
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
CC: Andrew Davis <afd@ti.com>
CC: Nishanth Menon <nm@ti.com>
CC: Jared McArthur <j-mcarthur@ti.com>
CC: Jason Kridner <jkridner@beagleboard.org>
CC: Deepak Khatri <lorforlinux@beagleboard.org>
CC: Drew Fustini <drew@beagleboard.org>
---
Changes since v1:
 - fixed incorrect vdd-3v3-sd-pins-default name
 - updated hdmi VDD_1V2 regulator for production pcb
 - switched device tree name from k3-j722s-beagley-ai to k3-am67a-beagley-ai
 - removed cpsw_port2 node
 - enable UHS support for MMCSD
---
 arch/arm64/boot/dts/ti/Makefile               |   1 +
 .../arm64/boot/dts/ti/k3-am67a-beagley-ai.dts | 369 ++++++++++++++++++
 2 files changed, 370 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am67a-beagley-ai.dts

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 9a722c2473fb..a61e8902a23d 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -95,6 +95,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-j721s2-evm.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-j721s2-evm-pcie1-ep.dtbo
 
 # Boards with J722s SoC
+dtb-$(CONFIG_ARCH_K3) += k3-am67a-beagley-ai.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-j722s-evm.dtb
 
 # Boards with J784s4 SoC
diff --git a/arch/arm64/boot/dts/ti/k3-am67a-beagley-ai.dts b/arch/arm64/boot/dts/ti/k3-am67a-beagley-ai.dts
new file mode 100644
index 000000000000..cffa1c9ba00d
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am67a-beagley-ai.dts
@@ -0,0 +1,369 @@
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
+	compatible = "beagle,am67a-beagley-ai", "ti,j722s";
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
+	vdd_3v3_sd_pins_default: vdd-3v3-sd-default-pins {
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
+	status = "okay";
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
+				/* Regulator is left as is unused */
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
+				regulator-name = "VDD_1V2";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
+				regulator-boot-on;
+				regulator-always-on;
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
+	status = "okay";
+	bootph-all;
+};
-- 
2.39.2


