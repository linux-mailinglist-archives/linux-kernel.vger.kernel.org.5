Return-Path: <linux-kernel+bounces-112871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB90887F4B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31177B212EA
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 21:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2FB18638;
	Sun, 24 Mar 2024 21:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJLuCnze"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1121433C9;
	Sun, 24 Mar 2024 21:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711316673; cv=none; b=vAIKDe9ctvX4PnBU8Cj4hz/j8ubk0PdFMAt3vbKdrikjB21rAps20bhn5NIVf5jfUrSsPk2WrgzRMrNbTeyhxgL6XAI3Iie21JTDPQnDgql6UvsBMlcZLbcIo0iRs2LvyqYjiBGAXLaJiAkC6nvk85mIoWFkZgz2567VOCz8YPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711316673; c=relaxed/simple;
	bh=2zj1KIM0IyZdVssFwbqXYgBukOlc5I412qb6cpDC4lk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CEYeCiCUWBt4XBHuLkSvW8LsbtQ0it1RozFNY7kU8IYCDEuAGO9qYSnKR2AzXnKGxC9XsTvgwzGBQLTP+Dn3ooHyz2eLw0zaMVdcRCD2kh9L5W83yqudCCpWuOTWAbktrkHMuCK4/xEwuxM0uJstNSb+p1UVt5P1rbFPxCGWqxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HJLuCnze; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-513d4559fb4so4946166e87.3;
        Sun, 24 Mar 2024 14:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711316670; x=1711921470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RiGDpRiqz1yAaTqKQT355fKcvl8VoBlGy2bAGsxu0Ks=;
        b=HJLuCnzeppJEzkeUlDsoNweG6jsFUj6e1j647AWNlx6prwFxPR7C69rChG8MfESRgI
         juLIZE9XDN6qf4tIav/MXBp6WWAMx7lCgSsLVGloUVh8yBoW/aEzNQd5gY27ejSu/S23
         HPG8/CFzTaNM+jtCqkQzsf0OdeQ2oLuH7dR73cnCFnGtRid9pehjZNZz2JwOmx4Zr2HZ
         e9UuOSD6UoUPy9PP5PYfimVMbD5RTPivlusX8KA+Hen/E4ZKFMSmlZnv9OSiybdi3FC2
         9Www0O+DY9RTXb9VwsQdqaVg1RBqjOJZhUfS0zbdIYtTiUcH3Qyvd8yVfISiEGXxZ1TD
         PZeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711316670; x=1711921470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RiGDpRiqz1yAaTqKQT355fKcvl8VoBlGy2bAGsxu0Ks=;
        b=dbGvB/iA3CK6lMBidv5w/7EOS1WjBolmHYl4e2lJKrjWqTZZ38rWHGyXTpMMUtKA5X
         MirqpC/bfHsBeNc/swx+j/WnjA1/8+U5z840CSmfACnnL0lnTOLkCMncjsQ44zbUcDFv
         yHAu4qp9IqDMEi1H4RI/G2+NRl008d/tTxuvGAcS4HqIc9qZp5i55ljrTvSXSltxzJ7R
         KjacYKgc+W4M2IFHq/AVRgMsNiU4nv4sV4Rz7HL9Xt0i1Iczlcq5uq1oQGyOV7b5J4NE
         Ai7Dw7Y+tKtjpCNR6sDhCsMH59knqt+1p+tnkVn9TVNXe29DsRPxObx3UGw8bqTuiaRB
         sAfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZ0TQyS5SOe3Vidm09r9M3iuNTYwcsn+Djt7A1s97W8zTHkLkVxJcj04Yvw/bEBtEf5ePkBGpmCCs/8bFAYlOlS6yxaGCzazdJQ6qq6cqZV7sZe6XkTAe6NlJyd5aRN5cJc7FZH6GIVyU/oBuL2HCGkzF+6Pt1CL78BEEB8kxlZpXRy3clN2NxBvl+jgZbdZV1S7PpJM9p01SFAW/XQJjMSg==
X-Gm-Message-State: AOJu0YyRgsqhGTEHR1XlTIHj+kiyxMwwQ37s1eGJwFNd8D/Ups/10R/u
	44YPt9n0tEx6MzM/A3BqkmgTt/NpA2jbCwNDb5o4RlyTAh9y12T9
X-Google-Smtp-Source: AGHT+IG9rNYUlwidGfrB8dKgKzeqnKbhSjGVr+DMFVgwBSnLAl1nBsRPWALtDB1VDlwgzLKHAtkUEQ==
X-Received: by 2002:a19:5f11:0:b0:515:99f6:2ca4 with SMTP id t17-20020a195f11000000b0051599f62ca4mr3539263lfb.36.1711316669355;
        Sun, 24 Mar 2024 14:44:29 -0700 (PDT)
Received: from bhlegrsu.conti.de ([2a02:908:2525:6ea0::2043])
        by smtp.googlemail.com with ESMTPSA id w17-20020a170906385100b00a46d8e5a031sm2327542ejc.209.2024.03.24.14.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 14:44:29 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: 
Cc: Wadim Mueller <wafgo01@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Chester Lin <chester62515@gmail.com>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Matthias Brugger <mbrugger@suse.com>,
	NXP S32 Linux Team <s32@nxp.com>,
	Tim Harvey <tharvey@gateworks.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Marek Vasut <marex@denx.de>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	Matthias Schiffer <matthias.schiffer@tq-group.com>,
	Stefan Wahren <stefan.wahren@chargebyte.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philippe Schenker <philippe.schenker@toradex.com>,
	Josua Mayer <josua@solid-run.com>,
	Li Yang <leoyang.li@nxp.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v4 4/4] arm64: dts: S32G3: Introduce device tree for S32G-VNP-RDB3
Date: Sun, 24 Mar 2024 22:43:26 +0100
Message-Id: <20240324214329.29988-5-wafgo01@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240324214329.29988-1-wafgo01@gmail.com>
References: <20240324214329.29988-1-wafgo01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds device tree support for the NXP S32G3-based
S32G-VNP-RDB3 Board [1].

The S32G3 features an 8-core ARM Cortex-A53 based SoC developed by NXP.

The device tree files are derived from the official NXP downstream
Linux tree [2].

This addition encompasses a limited selection of peripherals that
are upstream-supported. Apart from the ARM System Modules
(GIC, Generic Timer, etc.), the following IPs have been validated:

    * UART: fsl-linflexuart
    * SDHC: fsl-imx-esdhc

Clock settings for the chip rely on ATF Firmware [3].
Pin control integration into the device tree is pending and currently
relies on Firmware/U-Boot settings [4].

These changes were validated using BSP39 Firmware/U-Boot from NXP [5].

The modifications enable booting the official Ubuntu 22.04 from NXP on
the RDB3 with default settings from the SD card and eMMC.

[1] https://www.nxp.com/design/design-center/designs/s32g3-vehicle-networking-reference-design:S32G-VNP-RDB3
[2] https://github.com/nxp-auto-linux/linux
[3] https://github.com/nxp-auto-linux/arm-trusted-firmware
[4] https://github.com/nxp-auto-linux/u-boot
[5] https://github.com/nxp-auto-linux/auto_yocto_bsp

Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
---
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 arch/arm64/boot/dts/freescale/s32g3.dtsi      | 233 ++++++++++++++++++
 .../boot/dts/freescale/s32g399a-rdb3.dts      |  45 ++++
 3 files changed, 279 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/s32g3.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 2cb0212b63c6..e701008dbc7b 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -252,3 +252,4 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mp-venice-gw74xx-rpidsi.dtb
 dtb-$(CONFIG_ARCH_S32) += s32g274a-evb.dtb
 dtb-$(CONFIG_ARCH_S32) += s32g274a-rdb2.dtb
 dtb-$(CONFIG_ARCH_S32) += s32v234-evb.dtb
+dtb-$(CONFIG_ARCH_S32) += s32g399a-rdb3.dtb
diff --git a/arch/arm64/boot/dts/freescale/s32g3.dtsi b/arch/arm64/boot/dts/freescale/s32g3.dtsi
new file mode 100644
index 000000000000..c1b08992754b
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/s32g3.dtsi
@@ -0,0 +1,233 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright 2021-2023 NXP
+ *
+ * Authors: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
+ *          Ciprian Costea <ciprianmarian.costea@nxp.com>
+ *          Andra-Teodora Ilie <andra.ilie@nxp.com>
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	compatible = "nxp,s32g3";
+	interrupt-parent = <&gic>;
+	#address-cells = <0x02>;
+	#size-cells = <0x02>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&cpu0>;
+				};
+
+				core1 {
+					cpu = <&cpu1>;
+				};
+
+				core2 {
+					cpu = <&cpu2>;
+				};
+
+				core3 {
+					cpu = <&cpu3>;
+				};
+			};
+
+			cluster1 {
+				core0 {
+					cpu = <&cpu4>;
+				};
+
+				core1 {
+					cpu = <&cpu5>;
+				};
+
+				core2 {
+					cpu = <&cpu6>;
+				};
+
+				core3 {
+					cpu = <&cpu7>;
+				};
+			};
+		};
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x0>;
+			enable-method = "psci";
+			clocks = <&dfs 0>;
+		};
+
+		cpu1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x1>;
+			enable-method = "psci";
+			clocks = <&dfs 0>;
+		};
+
+		cpu2: cpu@2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x2>;
+			enable-method = "psci";
+			clocks = <&dfs 0>;
+		};
+
+		cpu3: cpu@3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x3>;
+			enable-method = "psci";
+			clocks = <&dfs 0>;
+		};
+
+		cpu4: cpu@100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x100>;
+			enable-method = "psci";
+			clocks = <&dfs 0>;
+		};
+
+		cpu5: cpu@101 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x101>;
+			enable-method = "psci";
+			clocks = <&dfs 0>;
+		};
+
+		cpu6: cpu@102 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x102>;
+			enable-method = "psci";
+			clocks = <&dfs 0>;
+		};
+
+		cpu7: cpu@103 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x103>;
+			enable-method = "psci";
+			clocks = <&dfs 0>;
+		};
+	};
+
+	firmware {
+		scmi: scmi {
+			compatible = "arm,scmi-smc";
+			shmem = <&scmi_shmem>;
+			arm,smc-id = <0xc20000fe>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			dfs: protocol@13 {
+				reg = <0x13>;
+				#clock-cells = <1>;
+			};
+
+			clks: protocol@14 {
+				reg = <0x14>;
+				#clock-cells = <1>;
+			};
+		};
+
+		psci: psci {
+			compatible = "arm,psci-1.0";
+			method = "smc";
+		};
+	};
+
+
+	pmu {
+		compatible = "arm,cortex-a53-pmu";
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	reserved-memory  {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		scmi_shmem: shm@d0000000 {
+			compatible = "arm,scmi-shmem";
+			reg = <0x0 0xd0000000 0x0 0x80>;
+			no-map;
+		};
+	};
+
+	soc@0 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0 0 0x80000000>;
+
+		uart0: serial@401c8000 {
+			compatible = "nxp,s32g3-linflexuart",
+				     "fsl,s32v234-linflexuart";
+			reg = <0x401c8000 0x3000>;
+			interrupts = <GIC_SPI 82 IRQ_TYPE_EDGE_RISING>;
+			status = "disabled";
+		};
+
+		uart1: serial@401cc000 {
+			compatible = "nxp,s32g3-linflexuart",
+				     "fsl,s32v234-linflexuart";
+			reg = <0x401cc000 0x3000>;
+			interrupts = <GIC_SPI 83 IRQ_TYPE_EDGE_RISING>;
+			status = "disabled";
+		};
+
+		uart2: serial@402bc000 {
+			compatible = "nxp,s32g3-linflexuart",
+				     "fsl,s32v234-linflexuart";
+			reg = <0x402bc000 0x3000>;
+			interrupts = <GIC_SPI 84 IRQ_TYPE_EDGE_RISING>;
+			status = "disabled";
+		};
+
+		usdhc0: mmc@402f0000 {
+			compatible = "nxp,s32g3-usdhc",
+				     "nxp,s32g2-usdhc";
+			reg = <0x402f0000 0x1000>;
+			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks 32>,
+				 <&clks 31>,
+				 <&clks 33>;
+			clock-names = "ipg", "ahb", "per";
+			status = "disabled";
+		};
+
+		gic: interrupt-controller@50800000 {
+			compatible = "arm,gic-v3";
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			reg = <0x50800000 0x10000>,
+			      <0x50900000 0x200000>,
+			      <0x50400000 0x2000>,
+			      <0x50410000 0x2000>,
+			      <0x50420000 0x2000>;
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>, /* sec-phys */
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>, /* phys */
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>, /* virt */
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>, /* hyp-phys */
+			     <GIC_PPI 12 IRQ_TYPE_LEVEL_LOW>; /* hyp-virt */
+		arm,no-tick-in-suspend;
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts b/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts
new file mode 100644
index 000000000000..9d674819876e
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright 2021-2023 NXP
+ *
+ * NXP S32G3 Reference Design Board 3 (S32G-VNP-RDB3)
+ */
+
+/dts-v1/;
+
+#include "s32g3.dtsi"
+
+/ {
+	model = "NXP S32G3 Reference Design Board 3 (S32G-VNP-RDB3)";
+	compatible = "nxp,s32g399a-rdb3", "nxp,s32g3";
+
+	aliases {
+		mmc0 = &usdhc0;
+		serial0 = &uart0;
+		serial1 = &uart1;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	/* 4GiB RAM */
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0 0x80000000>,
+		      <0x8 0x80000000 0 0x80000000>;
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&usdhc0 {
+	bus-width = <8>;
+	status = "okay";
+};
-- 
2.25.1


