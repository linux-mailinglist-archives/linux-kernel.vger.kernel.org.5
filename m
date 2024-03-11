Return-Path: <linux-kernel+bounces-99326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 013EF8786A0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 832C11F23667
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3195254F86;
	Mon, 11 Mar 2024 17:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XiG36f2B"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4083F4DA1A
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 17:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710179290; cv=none; b=BaBIRX6aS+Z/iZ2sTvMS2gr19keJLr5jpapT3xdvRP9rCRvm+U22J9JDbsYmryFz0vpZKqebGPnQnm5+oMb4kukkakWUuVoyMWoXIB0PvPtuutS0HKJ6nwmsBl3s1c6z2WkRa02Lpk+NbceiIgFvsZZ5VRja9NYCb0r1rvq38eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710179290; c=relaxed/simple;
	bh=01dw+5Io0u3q/4zdg6iAbSQK8g6cxaowyqpEGd8nGJQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i0MMTxEmboeBdoDzKFYO5gWT1wBUFHfC923p9a9O9uk7mNbJ974k9UkY8aEFDb2Efl3M97cmYOvv3KZjsuvk3la7qK8JD/8aO4hACUg+9Fr2Ujj7dS6SvZDalacGVv5ivRJfP1npsSvzjemE2RWufTVe9WzTzpcAe4Kdhn5p6x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XiG36f2B; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56847d9b002so2549982a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 10:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710179285; x=1710784085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9jC9WGBSGgScxGKsd54B5wH+Py7gDoT3kyXwvtBbZIA=;
        b=XiG36f2BKie2puqQGksQL1XrH7DdK4YHPvAEeSQ/B7t7r5hgTaVMNxBcFEKFNGXdFB
         qRVkGT+xsHmXI3bqNHAzt0h9N7+qkBBO/Y02mBu9bf9SRgVR1fLZvnYkFJ9kwRAFZsN6
         Z+2etweqfb61np6s6oCG/Lbd/gMS3mWW/rAnr44/HhHLFDrsVa78U7F0TVQBs95Y5yFQ
         yFT7N7pPX9zwkMrrJ4pvsO3RzSKwYYncbApe57BKLxXWjpuVEZq20ku3NmAnyjIYv5kF
         BL3iS3NLy2eYOXB/HjNVBOs11qBcR6Nv50wUZ+q8zPpLfKOip5rgfb4xzGat0925pb+y
         3fqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710179285; x=1710784085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9jC9WGBSGgScxGKsd54B5wH+Py7gDoT3kyXwvtBbZIA=;
        b=MvoEEV9HJxM/gJh6q+8KMSvV5g26bkJtobSShaMeHGhjXQU1NLFcnbmEXb3sUPOeKk
         6MUu6pPRSEvzZQKYuVbbWZU2yQLojSeuC3y5gAq1xlqyC/ojr6ItCXzwwhCAGGVJsL93
         r0IbBnI2yUX1hvV0T/K+hQMSZfH9BvZqHcmDAOYBCjdlnf+Uv4r09JXYg6lmQEFwPYNK
         NVawoW7gO9RAj8+DFQdR6MQRqRkmxLSf9cwcLQJwoPggqBME0a6+Bdsn8Homz+GvOvja
         JAzcah6WO6DlZ3ivihA82O3o56+yhxFpMZx0/5L1AKTM0jmqgzpPXHPtXejx+pAUO2X+
         Md4w==
X-Forwarded-Encrypted: i=1; AJvYcCUUyzC6hKlIXvk69eJbHO2hSigHp9U5BeO8iSGtmOYfpi+VCC75BOn6f+VSKQ/mSU1W75QEs37iPUsWABq+ASdgsZWPPbT6Vgnqxd39
X-Gm-Message-State: AOJu0Yzkjc29XeoL/9Bnf1km4RkK/HsJezdWIS1XuI2gztM3VRePPOC3
	suEBL2tf0GKIf3VVqgLF9YESliBQIdfJGOw5fOcKeee2Bm1iw0uc
X-Google-Smtp-Source: AGHT+IGBmrhuYv0ZQ/+hV8IFSH69K/s7pWbTS4iV97QN/TGK2BOH7pCt6S8uFNKgNHoWEhwKcDZYzw==
X-Received: by 2002:a50:ccc1:0:b0:568:93f:36c6 with SMTP id b1-20020a50ccc1000000b00568093f36c6mr4761702edj.22.1710179285540;
        Mon, 11 Mar 2024 10:48:05 -0700 (PDT)
Received: from localhost.localdomain (89-76-44-138.dynamic.chello.pl. [89.76.44.138])
        by smtp.gmail.com with ESMTPSA id r24-20020aa7d158000000b00568525ab2e8sm1757060edo.55.2024.03.11.10.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 10:48:05 -0700 (PDT)
From: Kamil Kasperski <ressetkk@gmail.com>
To: wens@csie.org,
	jernej.skrabec@gmail.com,
	samuel@sholland.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Kamil Kasperski <ressetkk@gmail.com>
Subject: [PATCH 3/3] dts: arm64: sunxi: add initial dts for T95 AXP313 tv box
Date: Mon, 11 Mar 2024 18:47:50 +0100
Message-Id: <20240311174750.6428-4-ressetkk@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311174750.6428-1-ressetkk@gmail.com>
References: <20240311174750.6428-1-ressetkk@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

T95 is a most commonly known for being a box with a pre-installed malware.
It uses Allwinner H616 and comes with eMMC and DDR3 memory.

Those TV boxes usually come with common hardware:
- Allwinner H616 SoC
- 2/4 GB DDR3 SDRAM (Hynix H5TQ2G43BFR)
- 16/32/64 GB eMMC
- microSD slot
- AXP305 or AXP313 PMIC depending on board revision
- 3.5mm A/V output
- HDMI port
- 2x USB 2.0 ports
- 100M ETH using Internal PHY
- 7-segment display
- DC 5V barrel jack port

The board contains holes hor UART header wired to &uart0.
From the DRAM specification its operation voltage is 1.5V.

Signed-off-by: Kamil Kasperski <ressetkk@gmail.com>
---
 arch/arm64/boot/dts/allwinner/Makefile        |   1 +
 .../dts/allwinner/sun50i-h616-t95-axp313.dts  | 138 ++++++++++++++++++
 2 files changed, 139 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-t95-axp313.dts

diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
index 21149b346a60..183dcdea40ad 100644
--- a/arch/arm64/boot/dts/allwinner/Makefile
+++ b/arch/arm64/boot/dts/allwinner/Makefile
@@ -43,6 +43,7 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-bigtreetech-cb1-manta.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-bigtreetech-pi.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-orangepi-zero2.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-x96-mate.dtb
+dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-t95-axp313.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h618-longanpi-3h.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h618-orangepi-zero2w.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h618-orangepi-zero3.dtb
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-t95-axp313.dts b/arch/arm64/boot/dts/allwinner/sun50i-h616-t95-axp313.dts
new file mode 100644
index 000000000000..830a8815e675
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-t95-axp313.dts
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2024 Kamil Kasperski <ressetkk@gmail.com>
+ */
+
+/dts-v1/;
+
+#include "sun50i-h616.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	model = "T95 5G (AXP313)";
+	compatible = "t95,t95-axp313", "allwinner,sun50i-h616";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	reg_vcc5v: vcc5v {
+		/* board wide 5V supply directly from the DC input */
+		compatible = "regulator-fixed";
+		regulator-name = "vcc-5v";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&ehci2 {
+	status = "okay";
+};
+
+&ir {
+	status = "okay";
+};
+
+&mmc0 {
+	broken-cd;
+	vmmc-supply = <&reg_dldo1>;
+	status = "okay";
+};
+
+&mmc2 {
+	vmmc-supply = <&reg_dldo1>;
+	bus-width = <8>;
+	non-removable;
+	cap-mmc-hw-reset;
+	status = "okay";
+};
+
+&ohci0 {
+	status = "okay";
+};
+
+&ohci2 {
+	status = "okay";
+};
+
+&r_i2c {
+	status = "okay";
+
+	axp313: pmic@36 {
+		compatible = "x-powers,axp313a";
+		reg = <0x36>;
+		#interrupt-cells = <1>;
+		interrupt-controller;
+		interrupt-parent = <&pio>;
+		interrupts = <2 9 IRQ_TYPE_LEVEL_LOW>;	/* PC9 */
+
+		vin1-supply = <&reg_vcc5v>;
+		vin2-supply = <&reg_vcc5v>;
+		vin3-supply = <&reg_vcc5v>;
+
+		regulators {
+			/* Supplies VCC-PLL, so needs to be always on. */
+			reg_aldo1: aldo1 {
+				regulator-always-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc1v8";
+			};
+
+			/* Supplies VCC-IO, so needs to be always on. */
+			reg_dldo1: dldo1 {
+				regulator-always-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc3v3";
+			};
+
+			reg_dcdc1: dcdc1 {
+				regulator-always-on;
+				regulator-min-microvolt = <810000>;
+				regulator-max-microvolt = <990000>;
+				regulator-name = "vdd-gpu-sys";
+			};
+
+			reg_dcdc2: dcdc2 {
+				regulator-always-on;
+				regulator-min-microvolt = <810000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-name = "vdd-cpu";
+			};
+
+			reg_dcdc3: dcdc3 {
+				regulator-always-on;
+				regulator-min-microvolt = <1500000>;
+				regulator-max-microvolt = <1500000>;
+				regulator-name = "vdd-dram";
+			};
+		};
+	};
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_ph_pins>;
+	status = "okay";
+};
+
+&usbotg {
+	dr_mode = "host";	/* USB A type receptable */
+	status = "okay";
+};
+
+&usbphy {
+	status = "okay";
+};
-- 
2.34.1


