Return-Path: <linux-kernel+bounces-59064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C233184F0B3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 08:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 407C31F24CAC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 07:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13E5657B0;
	Fri,  9 Feb 2024 07:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="HlA4c95i"
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD296664D4
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 07:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707463414; cv=none; b=q07RtVle4Txk9J+YmtEt45e7O2lXqARnBhqucqrU5phHPvlRujKTwCc6C8BmAM1XWYKbhJh+btUUWNuCAbGXn6nG2+AupTDWluT9+m27lNJ7jNaE6THMl0663GZAUJ5Q49AcKvIW/3ETdW2dZHb+IwnqZ1IdjJATys2pjr/gMaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707463414; c=relaxed/simple;
	bh=L0FczDEbw4UaG0pJ8Luisp89Gy3FL6JBjqe5xqlezMU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FaYsNkYWKOChTvV6PgHKqJK13zgnZ3V13UG5MY1NmsMVN2mwdH+RFhglewg2Eh/MTr5lhHvhseUtt7Gb1DZwqGd8g7tH0XKNxhJAtvVfyyiz4MlXTdVV10wpV9pLGTBBvgo1X1x3EWLImncsxu3Ayevs1jhrqnge/Gys9VV0Olw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=HlA4c95i; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2024020907232409d83f193e723e34b1
        for <linux-kernel@vger.kernel.org>;
        Fri, 09 Feb 2024 08:23:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=5/DszRcEDhwx8BDDHsLkDSGrgDGQoCtxEx27Zayh05s=;
 b=HlA4c95i3Jp7Jq4CgYIsj5NIT5hUfpkKeugYaqYTag770X0yIR4jiig39/iAPzC6jlxqhI
 ZXQRz4sOT+GMT6AOQnlvxLH6utnv0XTOExGdU/ldMVe7BHyg32LhtX2AmIOhFYQ89a9zmkNY
 AKg5TkP2HIwLYuRMd44hmlLnpr3aQ=;
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
Subject: [PATCH v3 5/7] arm64: dts: ti: iot2050: Factor out DP related bits
Date: Fri,  9 Feb 2024 08:23:19 +0100
Message-Id: <3397d917d7c97f7aec05bc5f65eef3a6fe843650.1707463401.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1707463401.git.jan.kiszka@siemens.com>
References: <cover.1707463401.git.jan.kiszka@siemens.com>
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
index 3ba81866599e..bffc9e251289 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
@@ -318,45 +318,6 @@ AM65X_IOPAD(0x02c0, PIN_OUTPUT, 0)  /* (AC8) USB1_DRVVBUS */
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
@@ -493,32 +454,6 @@ &main_i2c3 {
 
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
@@ -617,26 +552,6 @@ seboot-backup@e80000 {
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


