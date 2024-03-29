Return-Path: <linux-kernel+bounces-124162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE7589133C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 06:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C21F41F21C06
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 05:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430A9405C6;
	Fri, 29 Mar 2024 05:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uu3JhR/5"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964FF3FB3E;
	Fri, 29 Mar 2024 05:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711690341; cv=none; b=XaE6vifesJFdeImDqzcpss4dNWD5uBaKFhrRpydiwm27l4NRp57pQyObXNuApo17gjmm4Ocm0GIF387L5icqr4M6Zx0AwdXDeUzvf5wEotZBEgIhV69seuH6Nwom0wWcPwO6cCNaOoKEFEyFgO/JDIbGlJc6sYuiHjtT7T8ek5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711690341; c=relaxed/simple;
	bh=Z7XnIRvj6BZN3JC4yog/6vZFCfS/zxqiBBiUIpBfzxg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sol0dd5qh7VhJv4DOoE2to6omgGH/6qGZrF82R9T81K3qXqoeBl3Np+GleEPW90YpGtCNMOBJNjEP36xoSgBfzH1M27T+PIV/bJGZGASVnXnnSdWpO9GX+x2b9b/EAKyMxSLIf9cvVYZ3FsBVwrqT+2JCCUljXY78kZfkvrfnJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=uu3JhR/5; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42T5W2XY045054;
	Fri, 29 Mar 2024 00:32:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711690322;
	bh=UJZuyuMAS4yHscUWJc3IOMfyaa+XA7CfXXH+WdaZegc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=uu3JhR/57T5Fu1tgXcSuqNFUSIYQTmVsAV12me5CxyzPd5cw3YlWLX8z8IFdoP2hq
	 qxobi6XfEyNkEZgyDN6DXN/lN6hvC0cYJaXhAKwWKJf0u675o6hNZwIArJpn1CEseO
	 IemHTY6gGktT3QSARq5SMFINmL410ezqYeEnab04=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42T5W2vj027972
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 29 Mar 2024 00:32:02 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 29
 Mar 2024 00:32:01 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 29 Mar 2024 00:32:01 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42T5W1F0028092;
	Fri, 29 Mar 2024 00:32:01 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh@kernel.org>, Tero
 Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, Nishanth
 Menon <nm@ti.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <s-vadapalli@ti.com>,
        Chintan Vankar
	<c-vankar@ti.com>
Subject: [PATCH v6 4/5] arm64: dts: ti: k3-j784s4: Add overlay to enable QSGMII mode with CPSW9G
Date: Fri, 29 Mar 2024 11:01:29 +0530
Message-ID: <20240329053130.2822129-5-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329053130.2822129-1-c-vankar@ti.com>
References: <20240329053130.2822129-1-c-vankar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Siddharth Vadapalli <s-vadapalli@ti.com>

The J7 Quad Port Add-On Ethernet Card for J784S4 EVM supports
QSGMII mode. Use the overlay to configure CPSW9G ports in QSGMII
mode with the Add-On Ethernet Card connected to the ENET Expansion
1 slot on the EVM.

Add support to reset the PHY from kernel by using gpio-hog and
gpio-reset.

Add aliases for CPSW9G ports to enable kernel to fetch MAC Addresses
directly from U-Boot.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

Link to v5:
https://lore.kernel.org/r/20240314072129.1520475-5-c-vankar@ti.com/

Changes from v5 to v6:
- Updated order of properties in Device Nodes based on
  https://docs.kernel.org/devicetree/bindings/dts-coding-style.html#order-of-properties-in-device-node

 arch/arm64/boot/dts/ti/Makefile               |   7 +-
 .../ti/k3-j784s4-evm-quad-port-eth-exp1.dtso  | 147 ++++++++++++++++++
 2 files changed, 153 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j784s4-evm-quad-port-eth-exp1.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 9a722c2473fb..f8e47278df43 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -100,6 +100,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-j722s-evm.dtb
 # Boards with J784s4 SoC
 dtb-$(CONFIG_ARCH_K3) += k3-am69-sk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm-quad-port-eth-exp1.dtbo
 
 # Build time test only, enabled by CONFIG_OF_ALL_DTBS
 k3-am625-beagleplay-csi2-ov5640-dtbs := k3-am625-beagleplay.dtb \
@@ -145,6 +146,8 @@ k3-j721e-sk-csi2-dual-imx219-dtbs := k3-j721e-sk.dtb \
 	k3-j721e-sk-csi2-dual-imx219.dtbo
 k3-j721s2-evm-pcie1-ep-dtbs := k3-j721s2-common-proc-board.dtb \
 	k3-j721s2-evm-pcie1-ep.dtbo
+k3-j784s4-evm-quad-port-eth-exp1-dtbs := k3-j784s4-evm.dtb \
+	k3-j784s4-evm-quad-port-eth-exp1.dtbo
 dtb- += k3-am625-beagleplay-csi2-ov5640.dtb \
 	k3-am625-beagleplay-csi2-tevi-ov5640.dtb \
 	k3-am625-sk-csi2-imx219.dtb \
@@ -165,7 +168,8 @@ dtb- += k3-am625-beagleplay-csi2-ov5640.dtb \
 	k3-am69-sk-csi2-dual-imx219-dtbs \
 	k3-j721e-evm-pcie0-ep.dtb \
 	k3-j721e-sk-csi2-dual-imx219-dtbs \
-	k3-j721s2-evm-pcie1-ep.dtb
+	k3-j721s2-evm-pcie1-ep.dtb \
+	k3-j784s4-evm-quad-port-eth-exp1.dtb
 
 # Enable support for device-tree overlays
 DTC_FLAGS_k3-am625-beagleplay += -@
@@ -181,3 +185,4 @@ DTC_FLAGS_k3-am69-sk += -@
 DTC_FLAGS_k3-j721e-common-proc-board += -@
 DTC_FLAGS_k3-j721e-sk += -@
 DTC_FLAGS_k3-j721s2-common-proc-board += -@
+DTC_FLAGS_k3-j784s4-evm += -@
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm-quad-port-eth-exp1.dtso b/arch/arm64/boot/dts/ti/k3-j784s4-evm-quad-port-eth-exp1.dtso
new file mode 100644
index 000000000000..dcd2c7c39ec3
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm-quad-port-eth-exp1.dtso
@@ -0,0 +1,147 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
+/**
+ * DT Overlay for CPSW9G in QSGMII mode using J7 Quad Port ETH EXP Add-On Ethernet Card with
+ * J784S4 EVM. The Add-On Ethernet Card has to be connected to ENET Expansion 1 slot on the
+ * board.
+ *
+ * Product Datasheet: https://www.ti.com/lit/ug/spruj74/spruj74.pdf
+ *
+ * Link to QSGMII Daughtercard: https://www.ti.com/tool/J721EXENETXPANEVM
+ *
+ * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/phy/phy-cadence.h>
+#include <dt-bindings/phy/phy.h>
+
+#include "k3-pinctrl.h"
+#include "k3-serdes.h"
+
+&{/} {
+	aliases {
+		ethernet1 = "/bus@100000/ethernet@c000000/ethernet-ports/port@5";
+		ethernet2 = "/bus@100000/ethernet@c000000/ethernet-ports/port@6";
+		ethernet3 = "/bus@100000/ethernet@c000000/ethernet-ports/port@7";
+		ethernet4 = "/bus@100000/ethernet@c000000/ethernet-ports/port@8";
+		ethernet5 = "/bus@100000/ethernet@c200000/ethernet-ports/port@1";
+	};
+};
+
+&main_cpsw0 {
+	status = "okay";
+};
+
+&main_cpsw0_port5 {
+	phy-handle = <&cpsw9g_phy1>;
+	phy-mode = "qsgmii";
+	mac-address = [00 00 00 00 00 00];
+	phys = <&cpsw0_phy_gmii_sel 5>, <&serdes2_qsgmii_link>;
+	phy-names = "mac", "serdes";
+	status = "okay";
+};
+
+&main_cpsw0_port6 {
+	phy-handle = <&cpsw9g_phy2>;
+	phy-mode = "qsgmii";
+	mac-address = [00 00 00 00 00 00];
+	phys = <&cpsw0_phy_gmii_sel 6>, <&serdes2_qsgmii_link>;
+	phy-names = "mac", "serdes";
+	status = "okay";
+};
+
+&main_cpsw0_port7 {
+	phy-handle = <&cpsw9g_phy0>;
+	phy-mode = "qsgmii";
+	mac-address = [00 00 00 00 00 00];
+	phys = <&cpsw0_phy_gmii_sel 7>, <&serdes2_qsgmii_link>;
+	phy-names = "mac", "serdes";
+	status = "okay";
+};
+
+&main_cpsw0_port8 {
+	phy-handle = <&cpsw9g_phy3>;
+	phy-mode = "qsgmii";
+	mac-address = [00 00 00 00 00 00];
+	phys = <&cpsw0_phy_gmii_sel 8>, <&serdes2_qsgmii_link>;
+	phy-names = "mac", "serdes";
+	status = "okay";
+};
+
+&main_cpsw0_mdio {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mdio0_default_pins>;
+	bus_freq = <1000000>;
+	reset-gpios = <&exp2 17 GPIO_ACTIVE_LOW>;
+	reset-post-delay-us = <120000>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	cpsw9g_phy0: ethernet-phy@16 {
+		reg = <16>;
+	};
+	cpsw9g_phy1: ethernet-phy@17 {
+		reg = <17>;
+	};
+	cpsw9g_phy2: ethernet-phy@18 {
+		reg = <18>;
+	};
+	cpsw9g_phy3: ethernet-phy@19 {
+		reg = <19>;
+	};
+};
+
+&exp2 {
+	/* Power-up ENET1 EXPANDER PHY. */
+	qsgmii-line-hog {
+		gpio-hog;
+		gpios = <16 GPIO_ACTIVE_HIGH>;
+		output-low;
+	};
+
+	/* Toggle MUX2 for MDIO lines */
+	mux-sel-hog {
+		gpio-hog;
+		gpios = <13 GPIO_ACTIVE_HIGH>, <14 GPIO_ACTIVE_HIGH>, <15 GPIO_ACTIVE_HIGH>;
+		output-high;
+	};
+};
+
+&main_pmx0 {
+	mdio0_default_pins: mdio0-default-pins {
+		pinctrl-single,pins = <
+			J784S4_IOPAD(0x05c, PIN_INPUT, 4) /* (AC36) MCASP2_AXR0.MDIO1_MDIO */
+			J784S4_IOPAD(0x058, PIN_INPUT, 4) /* (AE37) MCASP2_AFSX.MDIO1_MDC */
+		>;
+	};
+};
+
+&serdes_ln_ctrl {
+	idle-states = <J784S4_SERDES0_LANE0_PCIE1_LANE0>, <J784S4_SERDES0_LANE1_PCIE1_LANE1>,
+		      <J784S4_SERDES0_LANE2_IP3_UNUSED>, <J784S4_SERDES0_LANE3_USB>,
+		      <J784S4_SERDES1_LANE0_PCIE0_LANE0>, <J784S4_SERDES1_LANE1_PCIE0_LANE1>,
+		      <J784S4_SERDES1_LANE2_PCIE0_LANE2>, <J784S4_SERDES1_LANE3_PCIE0_LANE3>,
+		      <J784S4_SERDES2_LANE0_QSGMII_LANE5>, <J784S4_SERDES2_LANE1_QSGMII_LANE6>,
+		      <J784S4_SERDES2_LANE2_QSGMII_LANE7>, <J784S4_SERDES2_LANE3_QSGMII_LANE8>;
+};
+
+&serdes_wiz2 {
+	status = "okay";
+};
+
+&serdes2 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+	serdes2_qsgmii_link: phy@0 {
+		reg = <2>;
+		cdns,num-lanes = <1>;
+		#phy-cells = <0>;
+		cdns,phy-type = <PHY_TYPE_QSGMII>;
+		resets = <&serdes_wiz2 3>;
+	};
+};
-- 
2.34.1


