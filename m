Return-Path: <linux-kernel+bounces-102928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F175487B885
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 08:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BDF82823F2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB6D5F460;
	Thu, 14 Mar 2024 07:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OXpS/5Ko"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADB55E224;
	Thu, 14 Mar 2024 07:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710400919; cv=none; b=nbqoZAopfT2dOxwHZ4SK8/uq2HoOg4bHerBzEHcAB3P7qWFoKCPeqi5RVyC1lvXMR7AZKMp2c4fi0vAuHqkhdGLl7+sy2UGNBKod85EKYprFSzxjh098hvdeOXLLY+PIdsgKAOjDOh8LiiOrhyh2ZopZydBfXKqkCoCR2QX+/Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710400919; c=relaxed/simple;
	bh=UcBcGukgguSoA+8PNtQc1UjtJFCatvGk6EJx682SMsM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sFID3fUSMTUW6YGpmqm+ae/oIismUDefuZvzJT8UYB2mp//lK7ZC5ahzC+98IFiuv3Hx1x8RI2j1IZgXAYtpjY+pQ4E0n8FEenvtTsEA83MFaPsuFBBL8XUAUdYeQWqybc35Mtir1r824T6Tx9C/Zdg9ojHO/Psi3dog7VrEuCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OXpS/5Ko; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42E7LeOq065182;
	Thu, 14 Mar 2024 02:21:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1710400900;
	bh=EKTarbR5ODKlrx6YKTvE9DTK3VZbyWvX/vtA06anwgE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=OXpS/5KoZJcavatc86sT7k7ykAC1bE410nXv4hu0QFxAn5zxSt3nu/Z7CjVkZDP0g
	 Bdhsf9v9nLcQCzmMs9s5bJlC6/A6ZrCwdverVo591YqalFkrNCk33aFMYXGea/ROGP
	 m27TDZxBaXpQ9MsC8Y06RJpyUOALaZlPyMiAAgo0=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42E7LeUg031098
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 14 Mar 2024 02:21:40 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 14
 Mar 2024 02:21:39 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 14 Mar 2024 02:21:39 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42E7LcVN120617;
	Thu, 14 Mar 2024 02:21:39 -0500
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
        <srk@ti.com>, <r-gunasekaran@ti.com>, <danishanwar@ti.com>,
        Chintan Vankar
	<c-vankar@ti.com>
Subject: [PATCH v5 5/5] arm64: dts: ti: k3-j784s4: Add overlay for dual port USXGMII mode
Date: Thu, 14 Mar 2024 12:51:29 +0530
Message-ID: <20240314072129.1520475-6-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240314072129.1520475-1-c-vankar@ti.com>
References: <20240314072129.1520475-1-c-vankar@ti.com>
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

The CPSW9G instance of the CPSW Ethernet Switch supports USXGMII mode
with MAC Ports 1 and 2 of the instance, which are connected to ENET
Expansion 1 and ENET Expansion 2 slots on the EVM respectively, through
the Serdes2 instance of the SERDES.

Enable CPSW9G MAC Ports 1 and 2 in fixed-link configuration USXGMII mode
at 5 Gbps each.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---
 arch/arm64/boot/dts/ti/Makefile               |  6 +-
 .../ti/k3-j784s4-evm-usxgmii-exp1-exp2.dtso   | 81 +++++++++++++++++++
 2 files changed, 86 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j784s4-evm-usxgmii-exp1-exp2.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index f8e47278df43..2d798ef415e4 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -101,6 +101,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-j722s-evm.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am69-sk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm-quad-port-eth-exp1.dtbo
+dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm-usxgmii-exp1-exp2.dtbo
 
 # Build time test only, enabled by CONFIG_OF_ALL_DTBS
 k3-am625-beagleplay-csi2-ov5640-dtbs := k3-am625-beagleplay.dtb \
@@ -148,6 +149,8 @@ k3-j721s2-evm-pcie1-ep-dtbs := k3-j721s2-common-proc-board.dtb \
 	k3-j721s2-evm-pcie1-ep.dtbo
 k3-j784s4-evm-quad-port-eth-exp1-dtbs := k3-j784s4-evm.dtb \
 	k3-j784s4-evm-quad-port-eth-exp1.dtbo
+k3-j784s4-evm-usxgmii-exp1-exp2.dtbs := k3-j784s4-evm.dtb \
+	k3-j784s4-evm-usxgmii-exp1-exp2.dtbo
 dtb- += k3-am625-beagleplay-csi2-ov5640.dtb \
 	k3-am625-beagleplay-csi2-tevi-ov5640.dtb \
 	k3-am625-sk-csi2-imx219.dtb \
@@ -169,7 +172,8 @@ dtb- += k3-am625-beagleplay-csi2-ov5640.dtb \
 	k3-j721e-evm-pcie0-ep.dtb \
 	k3-j721e-sk-csi2-dual-imx219-dtbs \
 	k3-j721s2-evm-pcie1-ep.dtb \
-	k3-j784s4-evm-quad-port-eth-exp1.dtb
+	k3-j784s4-evm-quad-port-eth-exp1.dtb \
+	k3-j784s4-evm-usxgmii-exp1-exp2.dtb
 
 # Enable support for device-tree overlays
 DTC_FLAGS_k3-am625-beagleplay += -@
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm-usxgmii-exp1-exp2.dtso b/arch/arm64/boot/dts/ti/k3-j784s4-evm-usxgmii-exp1-exp2.dtso
new file mode 100644
index 000000000000..b8e7fed6105a
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm-usxgmii-exp1-exp2.dtso
@@ -0,0 +1,81 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
+/**
+ * DT Overlay for CPSW9G in dual port fixed-link USXGMII mode using ENET-1
+ * and ENET-2 Expansion slots of J784S4 EVM.
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
+#include "k3-serdes.h"
+
+&{/} {
+	aliases {
+		ethernet1 = "/bus@100000/ethernet@c000000/ethernet-ports/port@1";
+		ethernet2 = "/bus@100000/ethernet@c000000/ethernet-ports/port@2";
+		ethernet3 = "/bus@100000/ethernet@c200000/ethernet-ports/port@1";
+	};
+};
+
+&main_cpsw0 {
+	status = "okay";
+	pinctrl-names = "default";
+};
+
+&main_cpsw0_port1 {
+	status = "okay";
+	phy-mode = "usxgmii";
+	mac-address = [00 00 00 00 00 00];
+	phys = <&cpsw0_phy_gmii_sel 1>, <&serdes2_usxgmii_link>;
+	phy-names = "mac", "serdes";
+	fixed-link {
+		speed = <5000>;
+		full-duplex;
+	};
+};
+
+&main_cpsw0_port2 {
+	status = "okay";
+	phy-mode = "usxgmii";
+	mac-address = [00 00 00 00 00 00];
+	phys = <&cpsw0_phy_gmii_sel 2>, <&serdes2_usxgmii_link>;
+	phy-names = "mac", "serdes";
+	fixed-link {
+		speed = <5000>;
+		full-duplex;
+	};
+};
+
+&serdes_wiz2 {
+	status = "okay";
+	assigned-clock-parents = <&k3_clks 406 9>; /* Use 156.25 MHz clock for USXGMII */
+};
+
+&serdes2 {
+	status = "okay";
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	serdes2_usxgmii_link: phy@2 {
+		reg = <2>;
+		cdns,num-lanes = <2>;
+		#phy-cells = <0>;
+		cdns,phy-type = <PHY_TYPE_USXGMII>;
+		resets = <&serdes_wiz2 3>, <&serdes_wiz2 4>;
+	};
+};
+
+&serdes_ln_ctrl {
+	idle-states = <J784S4_SERDES0_LANE0_PCIE1_LANE0>, <J784S4_SERDES0_LANE1_PCIE1_LANE1>,
+		      <J784S4_SERDES0_LANE2_IP3_UNUSED>, <J784S4_SERDES0_LANE3_USB>,
+		      <J784S4_SERDES1_LANE0_PCIE0_LANE0>, <J784S4_SERDES1_LANE1_PCIE0_LANE1>,
+		      <J784S4_SERDES1_LANE2_PCIE0_LANE2>, <J784S4_SERDES1_LANE3_PCIE0_LANE3>,
+		      <J784S4_SERDES2_LANE0_IP2_UNUSED>, <J784S4_SERDES2_LANE1_IP2_UNUSED>,
+		      <J784S4_SERDES2_LANE2_QSGMII_LANE1>, <J784S4_SERDES2_LANE3_QSGMII_LANE2>;
+};
-- 
2.34.1


