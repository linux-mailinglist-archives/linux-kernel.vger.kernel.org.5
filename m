Return-Path: <linux-kernel+bounces-15855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0905823457
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B79041C2403F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 18:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261851CF80;
	Wed,  3 Jan 2024 18:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="D3azzLP6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008BA1C6A3
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 18:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202401031812273e4fe597d4c210765d
        for <linux-kernel@vger.kernel.org>;
        Wed, 03 Jan 2024 19:12:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=3cmC6gh2SPe7FzSOGfaNeeoLbd++h96BSKYtA3JBbqk=;
 b=D3azzLP6ouYOO8GSarGpr5UJV26TBhqUSASKd9WHN7KsldU8bdeaZsIUVL0rxgg2bXTa4c
 dXUYq+Zz1XvU/x2IO9hAhFBliDs1USyYyjIVLnmoc3B0US1/eU7iiqKieGzykfs1l+Y0OBMr
 T5EPrbz2U/nGBwsAXlrl9w9LvoAQM=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Bao Cheng Su <baocheng.su@siemens.com>
Subject: [PATCH v2 5/7] arm64: dts: ti: iot2050: Factor out DP related bits
Date: Wed,  3 Jan 2024 19:12:22 +0100
Message-Id: <77b041326bf1eaa9dd0969df31ee2e168967c1cb.1704305544.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1704305544.git.jan.kiszka@siemens.com>
References: <cover.1704305544.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

There is a variant coming which does not support the Display Port. Move
all related bits into a separate dtsi so that only those variants
supporting the interface can include it.

Along that, remove a redundant clock setting from
k3-am65-iot2050-common-pg1.dtsi.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../dts/ti/k3-am65-iot2050-common-pg1.dtsi    |  5 +-
 .../boot/dts/ti/k3-am65-iot2050-common.dtsi   | 85 ----------------
 .../arm64/boot/dts/ti/k3-am65-iot2050-dp.dtsi | 98 +++++++++++++++++++
 .../dts/ti/k3-am6528-iot2050-basic-pg2.dts    |  1 +
 .../dts/ti/k3-am6548-iot2050-advanced-m2.dts  |  1 +
 .../dts/ti/k3-am6548-iot2050-advanced-pg2.dts |  1 +
 6 files changed, 102 insertions(+), 89 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am65-iot2050-dp.dtsi

diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi
index 1d1979859583..3f09d49d7dff 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi
@@ -8,10 +8,7 @@
  * Common bits of the IOT2050 Basic and Advanced variants, PG1
  */
 
-&dss {
-	assigned-clocks = <&k3_clks 67 2>;
-	assigned-clock-parents = <&k3_clks 67 5>;
-};
+#include "k3-am65-iot2050-dp.dtsi"
 
 &serdes0 {
 	status = "disabled";
diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
index 402afa4bc1b6..3ecdd63760e5 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
@@ -313,45 +313,6 @@ AM65X_IOPAD(0x02c0, PIN_OUTPUT, 0)  /* (AC8) USB1_DRVVBUS */
 		>;
 	};
 
-	dss_vout1_pins_default: dss-vout1-default-pins {
-		pinctrl-single,pins = <
-			AM65X_IOPAD(0x0000, PIN_OUTPUT, 1)  /* VOUT1_DATA0 */
-			AM65X_IOPAD(0x0004, PIN_OUTPUT, 1)  /* VOUT1_DATA1 */
-			AM65X_IOPAD(0x0008, PIN_OUTPUT, 1)  /* VOUT1_DATA2 */
-			AM65X_IOPAD(0x000c, PIN_OUTPUT, 1)  /* VOUT1_DATA3 */
-			AM65X_IOPAD(0x0010, PIN_OUTPUT, 1)  /* VOUT1_DATA4 */
-			AM65X_IOPAD(0x0014, PIN_OUTPUT, 1)  /* VOUT1_DATA5 */
-			AM65X_IOPAD(0x0018, PIN_OUTPUT, 1)  /* VOUT1_DATA6 */
-			AM65X_IOPAD(0x001c, PIN_OUTPUT, 1)  /* VOUT1_DATA7 */
-			AM65X_IOPAD(0x0020, PIN_OUTPUT, 1)  /* VOUT1_DATA8 */
-			AM65X_IOPAD(0x0024, PIN_OUTPUT, 1)  /* VOUT1_DATA9 */
-			AM65X_IOPAD(0x0028, PIN_OUTPUT, 1)  /* VOUT1_DATA10 */
-			AM65X_IOPAD(0x002c, PIN_OUTPUT, 1)  /* VOUT1_DATA11 */
-			AM65X_IOPAD(0x0030, PIN_OUTPUT, 1)  /* VOUT1_DATA12 */
-			AM65X_IOPAD(0x0034, PIN_OUTPUT, 1)  /* VOUT1_DATA13 */
-			AM65X_IOPAD(0x0038, PIN_OUTPUT, 1)  /* VOUT1_DATA14 */
-			AM65X_IOPAD(0x003c, PIN_OUTPUT, 1)  /* VOUT1_DATA15 */
-			AM65X_IOPAD(0x0040, PIN_OUTPUT, 1)  /* VOUT1_DATA16 */
-			AM65X_IOPAD(0x0044, PIN_OUTPUT, 1)  /* VOUT1_DATA17 */
-			AM65X_IOPAD(0x0048, PIN_OUTPUT, 1)  /* VOUT1_DATA18 */
-			AM65X_IOPAD(0x004c, PIN_OUTPUT, 1)  /* VOUT1_DATA19 */
-			AM65X_IOPAD(0x0050, PIN_OUTPUT, 1)  /* VOUT1_DATA20 */
-			AM65X_IOPAD(0x0054, PIN_OUTPUT, 1)  /* VOUT1_DATA21 */
-			AM65X_IOPAD(0x0058, PIN_OUTPUT, 1)  /* VOUT1_DATA22 */
-			AM65X_IOPAD(0x005c, PIN_OUTPUT, 1)  /* VOUT1_DATA23 */
-			AM65X_IOPAD(0x0060, PIN_OUTPUT, 1)  /* VOUT1_VSYNC */
-			AM65X_IOPAD(0x0064, PIN_OUTPUT, 1)  /* VOUT1_HSYNC */
-			AM65X_IOPAD(0x0068, PIN_OUTPUT, 1)  /* VOUT1_PCLK */
-			AM65X_IOPAD(0x006c, PIN_OUTPUT, 1)  /* VOUT1_DE */
-		>;
-	};
-
-	dp_pins_default: dp-default-pins {
-		pinctrl-single,pins = <
-			AM65X_IOPAD(0x0078, PIN_OUTPUT, 7)  /* (AF18) DP rst_n */
-		>;
-	};
-
 	main_i2c2_pins_default: main-i2c2-default-pins {
 		pinctrl-single,pins = <
 			AM65X_IOPAD(0x0074, PIN_INPUT,  5)  /* (T27) I2C2_SCL */
@@ -488,32 +449,6 @@ &main_i2c3 {
 
 	#address-cells = <1>;
 	#size-cells = <0>;
-
-	edp-bridge@f {
-		compatible = "toshiba,tc358767";
-		reg = <0x0f>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&dp_pins_default>;
-		reset-gpios = <&main_gpio0 30 GPIO_ACTIVE_HIGH>;
-
-		clock-names = "ref";
-		clocks = <&dp_refclk>;
-
-		toshiba,hpd-pin = <0>;
-
-		ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			port@1 {
-				reg = <1>;
-
-				bridge_in: endpoint {
-					remote-endpoint = <&dpi_out>;
-				};
-			};
-		};
-	};
 };
 
 &mcu_cpsw {
@@ -611,26 +546,6 @@ seboot-backup@e80000 {
 	};
 };
 
-&dss {
-	pinctrl-names = "default";
-	pinctrl-0 = <&dss_vout1_pins_default>;
-
-	assigned-clocks = <&k3_clks 67 2>;
-	assigned-clock-parents = <&k3_clks 67 5>;
-};
-
-&dss_ports {
-	#address-cells = <1>;
-	#size-cells = <0>;
-	port@1 {
-		reg = <1>;
-
-		dpi_out: endpoint {
-			remote-endpoint = <&bridge_in>;
-		};
-	};
-};
-
 &pcie1_rc {
 	status = "okay";
 	pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-dp.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-dp.dtsi
new file mode 100644
index 000000000000..07a0ea872f5b
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-dp.dtsi
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) Siemens AG, 2024
+ *
+ * Authors:
+ *   Jan Kiszka <jan.kiszka@siemens.com>
+ *
+ * Common bits for IOT2050 variants with Display Port
+ */
+
+&main_pmx0 {
+	dss_vout1_pins_default: dss-vout1-default-pins {
+		pinctrl-single,pins = <
+			AM65X_IOPAD(0x0000, PIN_OUTPUT, 1)  /* VOUT1_DATA0 */
+			AM65X_IOPAD(0x0004, PIN_OUTPUT, 1)  /* VOUT1_DATA1 */
+			AM65X_IOPAD(0x0008, PIN_OUTPUT, 1)  /* VOUT1_DATA2 */
+			AM65X_IOPAD(0x000c, PIN_OUTPUT, 1)  /* VOUT1_DATA3 */
+			AM65X_IOPAD(0x0010, PIN_OUTPUT, 1)  /* VOUT1_DATA4 */
+			AM65X_IOPAD(0x0014, PIN_OUTPUT, 1)  /* VOUT1_DATA5 */
+			AM65X_IOPAD(0x0018, PIN_OUTPUT, 1)  /* VOUT1_DATA6 */
+			AM65X_IOPAD(0x001c, PIN_OUTPUT, 1)  /* VOUT1_DATA7 */
+			AM65X_IOPAD(0x0020, PIN_OUTPUT, 1)  /* VOUT1_DATA8 */
+			AM65X_IOPAD(0x0024, PIN_OUTPUT, 1)  /* VOUT1_DATA9 */
+			AM65X_IOPAD(0x0028, PIN_OUTPUT, 1)  /* VOUT1_DATA10 */
+			AM65X_IOPAD(0x002c, PIN_OUTPUT, 1)  /* VOUT1_DATA11 */
+			AM65X_IOPAD(0x0030, PIN_OUTPUT, 1)  /* VOUT1_DATA12 */
+			AM65X_IOPAD(0x0034, PIN_OUTPUT, 1)  /* VOUT1_DATA13 */
+			AM65X_IOPAD(0x0038, PIN_OUTPUT, 1)  /* VOUT1_DATA14 */
+			AM65X_IOPAD(0x003c, PIN_OUTPUT, 1)  /* VOUT1_DATA15 */
+			AM65X_IOPAD(0x0040, PIN_OUTPUT, 1)  /* VOUT1_DATA16 */
+			AM65X_IOPAD(0x0044, PIN_OUTPUT, 1)  /* VOUT1_DATA17 */
+			AM65X_IOPAD(0x0048, PIN_OUTPUT, 1)  /* VOUT1_DATA18 */
+			AM65X_IOPAD(0x004c, PIN_OUTPUT, 1)  /* VOUT1_DATA19 */
+			AM65X_IOPAD(0x0050, PIN_OUTPUT, 1)  /* VOUT1_DATA20 */
+			AM65X_IOPAD(0x0054, PIN_OUTPUT, 1)  /* VOUT1_DATA21 */
+			AM65X_IOPAD(0x0058, PIN_OUTPUT, 1)  /* VOUT1_DATA22 */
+			AM65X_IOPAD(0x005c, PIN_OUTPUT, 1)  /* VOUT1_DATA23 */
+			AM65X_IOPAD(0x0060, PIN_OUTPUT, 1)  /* VOUT1_VSYNC */
+			AM65X_IOPAD(0x0064, PIN_OUTPUT, 1)  /* VOUT1_HSYNC */
+			AM65X_IOPAD(0x0068, PIN_OUTPUT, 1)  /* VOUT1_PCLK */
+			AM65X_IOPAD(0x006c, PIN_OUTPUT, 1)  /* VOUT1_DE */
+		>;
+	};
+
+	dp_pins_default: dp-default-pins {
+		pinctrl-single,pins = <
+			AM65X_IOPAD(0x0078, PIN_OUTPUT, 7)  /* (AF18) DP rst_n */
+		>;
+	};
+};
+
+&main_i2c3 {
+	edp-bridge@f {
+		compatible = "toshiba,tc358767";
+		reg = <0x0f>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&dp_pins_default>;
+		reset-gpios = <&main_gpio0 30 GPIO_ACTIVE_HIGH>;
+
+		clock-names = "ref";
+		clocks = <&dp_refclk>;
+
+		toshiba,hpd-pin = <0>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@1 {
+				reg = <1>;
+
+				bridge_in: endpoint {
+					remote-endpoint = <&dpi_out>;
+				};
+			};
+		};
+	};
+};
+
+&dss {
+	pinctrl-names = "default";
+	pinctrl-0 = <&dss_vout1_pins_default>;
+
+	assigned-clocks = <&k3_clks 67 2>;
+	assigned-clock-parents = <&k3_clks 67 5>;
+};
+
+&dss_ports {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	port@1 {
+		reg = <1>;
+
+		dpi_out: endpoint {
+			remote-endpoint = <&bridge_in>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dts b/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dts
index 8be3370d3de1..cba0c3d46263 100644
--- a/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dts
+++ b/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dts
@@ -17,6 +17,7 @@
 
 #include "k3-am6528-iot2050-basic-common.dtsi"
 #include "k3-am65-iot2050-common-pg2.dtsi"
+#include "k3-am65-iot2050-dp.dtsi"
 #include "k3-am65-iot2050-usb3.dtsi"
 
 / {
diff --git a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2.dts b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2.dts
index 38623501a14f..484a31a64cff 100644
--- a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2.dts
+++ b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2.dts
@@ -16,6 +16,7 @@
 #include "k3-am6548-iot2050-advanced-common.dtsi"
 #include "k3-am65-iot2050-common-pg2.dtsi"
 #include "k3-am65-iot2050-arduino-connector.dtsi"
+#include "k3-am65-iot2050-dp.dtsi"
 
 / {
 	compatible = "siemens,iot2050-advanced-m2", "ti,am654";
diff --git a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dts b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dts
index b6e878a31c27..9e1ebfea3f8f 100644
--- a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dts
+++ b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dts
@@ -18,6 +18,7 @@
 #include "k3-am6548-iot2050-advanced-common.dtsi"
 #include "k3-am65-iot2050-common-pg2.dtsi"
 #include "k3-am65-iot2050-arduino-connector.dtsi"
+#include "k3-am65-iot2050-dp.dtsi"
 #include "k3-am65-iot2050-usb3.dtsi"
 
 / {
-- 
2.35.3


