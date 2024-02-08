Return-Path: <linux-kernel+bounces-58063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBFD84E0C0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 499091C24F60
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAA779942;
	Thu,  8 Feb 2024 12:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aNoHhLTh"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D680A79926;
	Thu,  8 Feb 2024 12:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707395606; cv=none; b=EzKWFmxTvQB06qHvJgExEqNkS1eckTYp1FU3fH89mxrKFcdd6mBSBUQiKDj7i9tyeENjWLpsViwR4zXYtTO2RzNt7TimpjL+rPI1BVY2DdrjiHVGgd4GW0jvVzVGVkMueAlu+8C1JqVBIbjd9k4nwsHqIXTPMj5QHZwpcX1yQZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707395606; c=relaxed/simple;
	bh=eNTcIObMf/q45FYvwmDqKsuA2sHLvYtXbCyfb+wVdkk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mfD8o6yizzphUR1xQUIE30uudc76T5F4YoZ7WtZ+Zq0aGydsKNcM4oCVqdUD8o9NAOepxaVB5AyNtdanxIQ1QyrGvkL36YClI/NreQQm/v9cnrrDdRMWvgyMsHzkncR6wYkqSSa0SYyc8ShXEs5RrYUgJEyogc0NpBcyx/LhCbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=aNoHhLTh; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 418CXHOH070537;
	Thu, 8 Feb 2024 06:33:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707395597;
	bh=1IZI7B5jRtA0PzruzWX7lCDktTKGOjR+xwqH1FgjTcQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=aNoHhLThTw5bTb+VhrTVv+x2zhoNOaNHHVSnwjoDFwQL5Orkfc16QzF5QWgkK1mPT
	 Yaw8RSs6GNKK2nOt7yqpGRyHGLBZxcXfjpkl3I1VB8aJ7TG9ESGr8IgAxf5nhCvJS9
	 ctugaja40BC0jEP3CRw/uPG9wge1PGeE2U653b7M=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 418CXHcx014010
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Feb 2024 06:33:17 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Feb 2024 06:33:16 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Feb 2024 06:33:16 -0600
Received: from uda0490681.. ([10.24.69.142])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 418CWY1Q074789;
	Thu, 8 Feb 2024 06:33:12 -0600
From: Vaishnav Achath <vaishnav.a@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <kernel@pengutronix.de>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vaishnav.a@ti.com>, <u-kumar1@ti.com>, <j-choudhary@ti.com>,
        <j-luthra@ti.com>, <afd@ti.com>
Subject: [PATCH v3 9/9] arm64: dts: ti: k3-j721e-sk: Add overlay for IMX219
Date: Thu, 8 Feb 2024 18:02:33 +0530
Message-ID: <20240208123233.391115-10-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208123233.391115-1-vaishnav.a@ti.com>
References: <20240208123233.391115-1-vaishnav.a@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

RPi v2 Camera (IMX219) is an 8MP camera that can be used with SK-AM69,
J721E SK, and AM68 SK through the 22-pin CSI-RX connector.

Add a reference overlay for dual IMX219 RPI camera v2 modules
which can be used across AM68 SK, AM69 SK, TDA4VM SK boards
that have a 15/22-pin FFC connector. Also enable build testing
and symbols for all the three platforms.

Reviewed-by: Jai Luthra <j-luthra@ti.com>
Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
---

V1->V2:
 * Rename overlays to indicate first platform (j721e-sk) supported
   and dual camera.
 * Add missed build test, fix missing newline.

 arch/arm64/boot/dts/ti/Makefile               |  13 ++
 .../dts/ti/k3-j721e-sk-csi2-dual-imx219.dtso  | 125 ++++++++++++++++++
 2 files changed, 138 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-sk-csi2-dual-imx219.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 4a570dffb638..e019efd3ce94 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -69,6 +69,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-j721e-evm.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-j721e-evm-gesi-exp-board.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-j721e-evm-pcie0-ep.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-j721e-sk.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-j721e-sk-csi2-dual-imx219.dtbo
 
 # Boards with J721s2 SoC
 dtb-$(CONFIG_ARCH_K3) += k3-am68-sk-base-board.dtb
@@ -106,8 +107,14 @@ k3-am642-tqma64xxl-mbax4xxl-sdcard-dtbs := \
 	k3-am642-tqma64xxl-mbax4xxl.dtb k3-am64-tqma64xxl-mbax4xxl-sdcard.dtbo
 k3-am642-tqma64xxl-mbax4xxl-wlan-dtbs := \
 	k3-am642-tqma64xxl-mbax4xxl.dtb k3-am64-tqma64xxl-mbax4xxl-wlan.dtbo
+k3-am68-sk-base-board-csi2-dual-imx219-dtbs := k3-am68-sk-base-board.dtb \
+	k3-j721e-sk-csi2-dual-imx219.dtbo
+k3-am69-sk-csi2-dual-imx219-dtbs := k3-am69-sk.dtb \
+	k3-j721e-sk-csi2-dual-imx219.dtbo
 k3-j721e-evm-pcie0-ep-dtbs := k3-j721e-common-proc-board.dtb \
 	k3-j721e-evm-pcie0-ep.dtbo
+k3-j721e-sk-csi2-dual-imx219-dtbs := k3-j721e-sk.dtb \
+	k3-j721e-sk-csi2-dual-imx219.dtbo
 k3-j721s2-evm-pcie1-ep-dtbs := k3-j721s2-common-proc-board.dtb \
 	k3-j721s2-evm-pcie1-ep.dtbo
 dtb- += k3-am625-beagleplay-csi2-ov5640.dtb \
@@ -122,7 +129,10 @@ dtb- += k3-am625-beagleplay-csi2-ov5640.dtb \
 	k3-am62a7-sk-hdmi-audio.dtb \
 	k3-am642-tqma64xxl-mbax4xxl-sdcard.dtb \
 	k3-am642-tqma64xxl-mbax4xxl-wlan.dtb \
+	k3-am68-sk-base-board-csi2-dual-imx219-dtbs \
+	k3-am69-sk-csi2-dual-imx219-dtbs \
 	k3-j721e-evm-pcie0-ep.dtb \
+	k3-j721e-sk-csi2-dual-imx219-dtbs \
 	k3-j721s2-evm-pcie1-ep.dtb
 
 # Enable support for device-tree overlays
@@ -132,5 +142,8 @@ DTC_FLAGS_k3-am62-lp-sk += -@
 DTC_FLAGS_k3-am62a7-sk += -@
 DTC_FLAGS_k3-am642-tqma64xxl-mbax4xxl += -@
 DTC_FLAGS_k3-am6548-iot2050-advanced-m2 += -@
+DTC_FLAGS_k3-am68-sk-base-board += -@
+DTC_FLAGS_k3-am69-sk += -@
 DTC_FLAGS_k3-j721e-common-proc-board += -@
+DTC_FLAGS_k3-j721e-sk += -@
 DTC_FLAGS_k3-j721s2-common-proc-board += -@
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk-csi2-dual-imx219.dtso b/arch/arm64/boot/dts/ti/k3-j721e-sk-csi2-dual-imx219.dtso
new file mode 100644
index 000000000000..65d7cefb6063
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-j721e-sk-csi2-dual-imx219.dtso
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/**
+ * DT Overlay for dual RPi Camera V2.1 (Sony IMX219) interfaced with CSI2
+ * on J721E SK, AM68 SK or AM69-SK board.
+ * https://datasheets.raspberrypi.org/camera/camera-v2-schematic.pdf
+ *
+ * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
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
-- 
2.34.1


