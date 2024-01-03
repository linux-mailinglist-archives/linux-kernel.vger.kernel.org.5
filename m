Return-Path: <linux-kernel+bounces-15853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E602823452
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50D0E1C23F6C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 18:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5075A1CA96;
	Wed,  3 Jan 2024 18:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="aB51HCgg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF45D1C698
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 18:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20240103181227fabd985ac71e50af22
        for <linux-kernel@vger.kernel.org>;
        Wed, 03 Jan 2024 19:12:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=UsB2q7UTNVWkhSlQ0b0abrpeXuTMKXjbbt56rKrEWgE=;
 b=aB51HCggmHjkYM5lEkIJ1q+PH0UDVw00wRA9fRTBgNsgoiakDtcaiLO0aqf3tolfSYYXrS
 sLB+dlzucwPLAPNQo7P4fTG2NQxxtfAQJbHx0ceGFICGtAntKdAGVUTLVcKS1Vca5JM5AT5J
 VBF2ESnDtLsiYrVar38PYaqpVqqDQ=;
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
Subject: [PATCH v2 4/7] arm64: dts: ti: iot2050: Factor out enabling of USB3 support
Date: Wed,  3 Jan 2024 19:12:21 +0100
Message-Id: <a1c5028e94ca7ee8a3e55702f4fc2d26d10805a6.1704305544.git.jan.kiszka@siemens.com>
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

Already simplifies the existing code by avoid the switch back in the m2
variant to what k3-am65-main.dtsi provided as base.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../dts/ti/k3-am65-iot2050-common-pg2.dtsi    | 18 -------------
 .../boot/dts/ti/k3-am65-iot2050-usb3.dtsi     | 27 +++++++++++++++++++
 .../dts/ti/k3-am6528-iot2050-basic-pg2.dts    |  1 +
 .../dts/ti/k3-am6548-iot2050-advanced-m2.dts  | 13 ---------
 .../dts/ti/k3-am6548-iot2050-advanced-pg2.dts |  1 +
 5 files changed, 29 insertions(+), 31 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am65-iot2050-usb3.dtsi

diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg2.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg2.dtsi
index 42adb8815f38..93d966b67d8d 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg2.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg2.dtsi
@@ -38,21 +38,3 @@ &dss {
 	/* Workaround needed to get DP clock of 154Mhz */
 	assigned-clocks = <&k3_clks 67 0>;
 };
-
-&serdes0 {
-	assigned-clocks = <&k3_clks 153 4>, <&serdes0 AM654_SERDES_CMU_REFCLK>;
-	assigned-clock-parents = <&k3_clks 153 7>, <&k3_clks 153 4>;
-};
-
-&dwc3_0 {
-	assigned-clock-parents = <&k3_clks 151 4>,  /* set REF_CLK to 20MHz i.e. PER0_PLL/48 */
-				 <&k3_clks 151 8>;  /* set PIPE3_TXB_CLK to WIZ8B2M4VSB */
-	phys = <&serdes0 PHY_TYPE_USB3 0>;
-	phy-names = "usb3-phy";
-};
-
-&usb0 {
-	maximum-speed = "super-speed";
-	snps,dis-u1-entry-quirk;
-	snps,dis-u2-entry-quirk;
-};
diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-usb3.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-usb3.dtsi
new file mode 100644
index 000000000000..3f5fe4c38ebc
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-usb3.dtsi
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) Siemens AG, 2024
+ *
+ * Authors:
+ *   Jan Kiszka <jan.kiszka@siemens.com>
+ *
+ * Common bits for IOT2050 variants with USB3 support
+ */
+
+&serdes0 {
+	assigned-clocks = <&k3_clks 153 4>, <&serdes0 AM654_SERDES_CMU_REFCLK>;
+	assigned-clock-parents = <&k3_clks 153 7>, <&k3_clks 153 4>;
+};
+
+&dwc3_0 {
+	assigned-clock-parents = <&k3_clks 151 4>,  /* set REF_CLK to 20MHz i.e. PER0_PLL/48 */
+				 <&k3_clks 151 8>;  /* set PIPE3_TXB_CLK to WIZ8B2M4VSB */
+	phys = <&serdes0 PHY_TYPE_USB3 0>;
+	phy-names = "usb3-phy";
+};
+
+&usb0 {
+	maximum-speed = "super-speed";
+	snps,dis-u1-entry-quirk;
+	snps,dis-u2-entry-quirk;
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dts b/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dts
index c62549a4b436..8be3370d3de1 100644
--- a/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dts
+++ b/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dts
@@ -17,6 +17,7 @@
 
 #include "k3-am6528-iot2050-basic-common.dtsi"
 #include "k3-am65-iot2050-common-pg2.dtsi"
+#include "k3-am65-iot2050-usb3.dtsi"
 
 / {
 	compatible = "siemens,iot2050-basic-pg2", "ti,am654";
diff --git a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2.dts b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2.dts
index 2401cbe2b66c..38623501a14f 100644
--- a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2.dts
+++ b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2.dts
@@ -92,16 +92,3 @@ &pcie0_rc {
 &pcie1_rc {
 	status = "disabled";
 };
-
-&dwc3_0 {
-	assigned-clock-parents = <&k3_clks 151 4>,  /* set REF_CLK to 20MHz i.e. PER0_PLL/48 */
-				 <&k3_clks 151 9>;  /* set PIPE3_TXB_CLK to CLK_12M_RC/256 (for HS only) */
-	/delete-property/ phys;
-	/delete-property/ phy-names;
-};
-
-&usb0 {
-	maximum-speed = "high-speed";
-	/delete-property/ snps,dis-u1-entry-quirk;
-	/delete-property/ snps,dis-u2-entry-quirk;
-};
diff --git a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dts b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dts
index c1205feef54e..b6e878a31c27 100644
--- a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dts
+++ b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dts
@@ -18,6 +18,7 @@
 #include "k3-am6548-iot2050-advanced-common.dtsi"
 #include "k3-am65-iot2050-common-pg2.dtsi"
 #include "k3-am65-iot2050-arduino-connector.dtsi"
+#include "k3-am65-iot2050-usb3.dtsi"
 
 / {
 	compatible = "siemens,iot2050-advanced-pg2", "ti,am654";
-- 
2.35.3


