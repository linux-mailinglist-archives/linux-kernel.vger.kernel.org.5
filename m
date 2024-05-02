Return-Path: <linux-kernel+bounces-166183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 146A68B9744
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D5232818DA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E971656B77;
	Thu,  2 May 2024 09:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="iKW2iQT+"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E8755C2A;
	Thu,  2 May 2024 09:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714641053; cv=none; b=uu3pAiEYUD1B6H39CmA5KBG20NsiBazohZUZdocjHxDA6U5xI63OCWWW2BCs+nHycrQZI6X/eXHPQuK2AH+oI8eobv7NJaMu1/ys+W1ZfhKLnpW1RDFWl1zs+nopOoH+X5BlimFMx0BImjAN59AyP1j9gFBa0IG6Qww7tEqkY9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714641053; c=relaxed/simple;
	bh=NbSwkCB185nI3eTg5sxgZWTeysIpxJc7+qjeNnuKNHc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GM1PFu0imXmmAkYpepqDJRV0cdPybwAQvwwWQpYEOzpKVWPzgfNE2Vg9thptxWMLb3NsguKha+/TbJD5MbjL3xMt1tt1LiWHp8LMF51YIEGClwrfzCzYzl9ABsrioKue2JAza/njHWO7rM6shnF2QYKpNJNymW4+9iNqBBxoIjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=iKW2iQT+; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4429Afpk120795;
	Thu, 2 May 2024 04:10:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714641041;
	bh=kYXDB+R2gtFLvDZr/KPh+wZWmTqWjtCzNhI0OzYNovI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=iKW2iQT+Nk3ratVtPepsf/g0j9D7zqUukj2Do+EDB6EhHtEgU78ChNkNsJz2WQhK2
	 QP+LaT62gWwnWBnp22milyya1GO44jaVhG0tAToLdVCcqUi/apkvPOsU7hC5lS5wq5
	 yNoawFIMceuIaiFGWJr+NxPsyrZaTb/zAjQITMUI=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4429AfBv113500
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 2 May 2024 04:10:41 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 2
 May 2024 04:10:41 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 2 May 2024 04:10:41 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4429AeSP007726;
	Thu, 2 May 2024 04:10:40 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Tero Kristo
	<kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon
	<nm@ti.com>,
        <s-vadapalli@ti.com>, <danishanwar@ti.com>, <r-gunasekaran@ti.com>,
        <srk@ti.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Chintan Vankar <c-vankar@ti.com>
Subject: [PATCH v7 4/5] arm64: dts: ti: k3-j784s4: Add overlay to enable QSGMII mode with CPSW9G
Date: Thu, 2 May 2024 14:40:01 +0530
Message-ID: <20240502091002.3659435-5-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502091002.3659435-1-c-vankar@ti.com>
References: <20240502091002.3659435-1-c-vankar@ti.com>
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

Link to v6:
https://lore.kernel.org/r/20240329053130.2822129-5-c-vankar@ti.com/

Changes from v6 to v7:
- No changes.

 arch/arm64/boot/dts/ti/Makefile               |   7 +-
 .../ti/k3-j784s4-evm-quad-port-eth-exp1.dtso  | 147 ++++++++++++++++++
 2 files changed, 153 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j784s4-evm-quad-port-eth-exp1.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 2c327cc320cf..bb3ca0d17788 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -101,6 +101,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-j722s-evm.dtb
 # Boards with J784s4 SoC
 dtb-$(CONFIG_ARCH_K3) += k3-am69-sk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm-quad-port-eth-exp1.dtbo
 
 # Build time test only, enabled by CONFIG_OF_ALL_DTBS
 k3-am625-beagleplay-csi2-ov5640-dtbs := k3-am625-beagleplay.dtb \
@@ -148,6 +149,8 @@ k3-j721e-sk-csi2-dual-imx219-dtbs := k3-j721e-sk.dtb \
 	k3-j721e-sk-csi2-dual-imx219.dtbo
 k3-j721s2-evm-pcie1-ep-dtbs := k3-j721s2-common-proc-board.dtb \
 	k3-j721s2-evm-pcie1-ep.dtbo
+k3-j784s4-evm-quad-port-eth-exp1-dtbs := k3-j784s4-evm.dtb \
+	k3-j784s4-evm-quad-port-eth-exp1.dtbo
 dtb- += k3-am625-beagleplay-csi2-ov5640.dtb \
 	k3-am625-beagleplay-csi2-tevi-ov5640.dtb \
 	k3-am625-sk-csi2-imx219.dtb \
@@ -168,7 +171,8 @@ dtb- += k3-am625-beagleplay-csi2-ov5640.dtb \
 	k3-am69-sk-csi2-dual-imx219.dtb \
 	k3-j721e-evm-pcie0-ep.dtb \
 	k3-j721e-sk-csi2-dual-imx219.dtb \
-	k3-j721s2-evm-pcie1-ep.dtb
+	k3-j721s2-evm-pcie1-ep.dtb \
+	k3-j784s4-evm-quad-port-eth-exp1.dtb
 
 # Enable support for device-tree overlays
 DTC_FLAGS_k3-am625-beagleplay += -@
@@ -186,3 +190,4 @@ DTC_FLAGS_k3-am69-sk += -@
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


