Return-Path: <linux-kernel+bounces-42804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 428FE8406F1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 688DA1C2513C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FCD64CDF;
	Mon, 29 Jan 2024 13:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bNZfwVoq"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B3B664B8;
	Mon, 29 Jan 2024 13:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706534913; cv=none; b=H0KckyKK87f0ZORAkp95BjqFe1dfBssrRRiQZ+IKUaedvtrdrTY664QcYq8gZoG5QoVZD9p6bSHfVLcktH3K4oaQeZYI2ODBmmofn5BZAXr0Eak7XfxRUyRVho7aSebBbjo7D8ofWpxgcmtB+MEoszLTmpZMjS0TQOJsvm0FX3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706534913; c=relaxed/simple;
	bh=cHGpYx7pLrXkI4kU27psyajXtKlh66ypKBcO2m7U5so=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rMH0BJexOD1yW5k9N+RUakeZmeX/qW4UBRRDgL30UBaIrtKKDxrM7zXY8+egzQzY4gwm6g+X/EvswaN1RTmCczxuFpLahpQFFQ1kp8fGJ2l321v4v2/90VV3rDJZnBjPywsXEFfUf8CTN8/E3lCpVYEyV/neuEuGmPffiBU/2cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=bNZfwVoq; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40TDSMrp099437;
	Mon, 29 Jan 2024 07:28:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706534902;
	bh=pxRAtQYXyM4cN8XqY5QkA82gb4WIzyA0aGBOWzc4m8k=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=bNZfwVoqLurp4h1y5+7zwLDl90vURgn3RLVQsrcZgEz6Pnzc5aqV3NOkw4boZvqhK
	 fIaikHStk/ZdXRbqKSXF+u0a7qZUOryPSqfXUM8DxW5ZlkREadxYdaBYvZ3RUjbjy8
	 D1YZqIlOLgES7JVpXV6UBQdzmDTx+A6XG+QmInEQ=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40TDSM9p093614
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Jan 2024 07:28:22 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Jan 2024 07:28:22 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Jan 2024 07:28:22 -0600
Received: from uda0490681.dhcp.ti.com ([10.24.69.142])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40TDRg9J036720;
	Mon, 29 Jan 2024 07:28:18 -0600
From: Vaishnav Achath <vaishnav.a@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <kernel@pengutronix.de>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vaishnav.a@ti.com>, <u-kumar1@ti.com>, <j-choudhary@ti.com>,
        <j-luthra@ti.com>
Subject: [PATCH 9/9] arm64: dts: ti: k3-am69-sk: Add overlay for IMX219
Date: Mon, 29 Jan 2024 18:57:42 +0530
Message-ID: <20240129132742.1189783-10-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129132742.1189783-1-vaishnav.a@ti.com>
References: <20240129132742.1189783-1-vaishnav.a@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

RPi v2 Camera (IMX219) is an 8MP camera that can be used with SK-AM69
through the 22-pin CSI-RX connector.

Same overlay can be used across AM68 SK, TDA4VM SK boards that have a
15/22-pin FFC connector. Also enable build testing and symbols for
all the three platforms.

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
---
 arch/arm64/boot/dts/ti/Makefile               |   6 +
 .../boot/dts/ti/k3-am69-sk-csi2-imx219.dtso   | 124 ++++++++++++++++++
 2 files changed, 130 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am69-sk-csi2-imx219.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 52c1dc910308..9fc8d68f7d26 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -80,6 +80,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-j721s2-evm-pcie1-ep.dtbo
 
 # Boards with J784s4 SoC
 dtb-$(CONFIG_ARCH_K3) += k3-am69-sk.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-am69-sk-csi2-imx219.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm.dtb
 
 # Build time test only, enabled by CONFIG_OF_ALL_DTBS
@@ -105,6 +106,8 @@ k3-am642-tqma64xxl-mbax4xxl-sdcard-dtbs := \
 	k3-am642-tqma64xxl-mbax4xxl.dtb k3-am64-tqma64xxl-mbax4xxl-sdcard.dtbo
 k3-am642-tqma64xxl-mbax4xxl-wlan-dtbs := \
 	k3-am642-tqma64xxl-mbax4xxl.dtb k3-am64-tqma64xxl-mbax4xxl-wlan.dtbo
+k3-am69-sk-csi2-imx219-dtbs := k3-am69-sk.dtb \
+	k3-am69-sk-csi2-imx219.dtbo
 k3-j721e-evm-pcie0-ep-dtbs := k3-j721e-common-proc-board.dtb \
 	k3-j721e-evm-pcie0-ep.dtbo
 k3-j721s2-evm-pcie1-ep-dtbs := k3-j721s2-common-proc-board.dtb \
@@ -130,5 +133,8 @@ DTC_FLAGS_k3-am62-lp-sk += -@
 DTC_FLAGS_k3-am62a7-sk += -@
 DTC_FLAGS_k3-am642-tqma64xxl-mbax4xxl += -@
 DTC_FLAGS_k3-am6548-iot2050-advanced-m2 += -@
+DTC_FLAGS_k3-am68-sk-base-board += -@
+DTC_FLAGS_k3-am69-sk += -@
 DTC_FLAGS_k3-j721e-common-proc-board += -@
 DTC_FLAGS_k3-j721s2-common-proc-board += -@
+DTC_FLAGS_k3-j721e-sk += -@
diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk-csi2-imx219.dtso b/arch/arm64/boot/dts/ti/k3-am69-sk-csi2-imx219.dtso
new file mode 100644
index 000000000000..4cd1d8d5004a
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am69-sk-csi2-imx219.dtso
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: GPL-2.0
+/**
+ * DT Overlay for RPi Camera V2.1 (Sony IMX219) interfaced with CSI2 on AM68-SK board.
+ * https://datasheets.raspberrypi.org/camera/camera-v2-schematic.pdf
+ *
+ * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include "k3-pinctrl.h"
+
+&{/} {
+	clk_imx219_fixed: imx219-xclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+	};
+};
+
+&csi_mux {
+	idle-state = <1>;
+};
+
+/* CAM0 I2C */
+&cam0_i2c {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	imx219_0: imx219_0@10 {
+		compatible = "sony,imx219";
+		reg = <0x10>;
+
+		clocks = <&clk_imx219_fixed>;
+		clock-names = "xclk";
+
+		port {
+			csi2_cam0: endpoint {
+				remote-endpoint = <&csi2rx0_in_sensor>;
+				link-frequencies = /bits/ 64 <456000000>;
+				clock-lanes = <0>;
+				data-lanes = <1 2>;
+			};
+		};
+	};
+};
+
+/* CAM1 I2C */
+&cam1_i2c {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	imx219_1: imx219_1@10 {
+		compatible = "sony,imx219";
+		reg = <0x10>;
+
+		clocks = <&clk_imx219_fixed>;
+		clock-names = "xclk";
+
+		port {
+			csi2_cam1: endpoint {
+				remote-endpoint = <&csi2rx1_in_sensor>;
+				link-frequencies = /bits/ 64 <456000000>;
+				clock-lanes = <0>;
+				data-lanes = <1 2>;
+			};
+		};
+	};
+};
+
+
+&cdns_csi2rx0 {
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		csi0_port0: port@0 {
+			reg = <0>;
+			status = "okay";
+
+			csi2rx0_in_sensor: endpoint {
+				remote-endpoint = <&csi2_cam0>;
+				bus-type = <4>; /* CSI2 DPHY. */
+				clock-lanes = <0>;
+				data-lanes = <1 2>;
+			};
+		};
+	};
+};
+
+&dphy0 {
+	status = "okay";
+};
+
+&ti_csi2rx0 {
+	status = "okay";
+};
+
+&cdns_csi2rx1 {
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		csi1_port0: port@0 {
+			reg = <0>;
+			status = "okay";
+
+			csi2rx1_in_sensor: endpoint {
+				remote-endpoint = <&csi2_cam1>;
+				bus-type = <4>; /* CSI2 DPHY. */
+				clock-lanes = <0>;
+				data-lanes = <1 2>;
+			};
+		};
+	};
+};
+
+&dphy1 {
+	status = "okay";
+};
+
+&ti_csi2rx1 {
+	status = "okay";
+};
\ No newline at end of file
-- 
2.34.1


