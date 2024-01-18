Return-Path: <linux-kernel+bounces-29979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 498EA831622
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 10:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DA39289121
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C527424B37;
	Thu, 18 Jan 2024 09:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xeLI7ZLC"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6EE22F06;
	Thu, 18 Jan 2024 09:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705571142; cv=none; b=SAQSY79BQf/MlJuAs2IoiiNLGCV+4vldm/TNd1fhiaRCpgvQB9yYdOf9UmAu1VuEfwm8ZvXYJPMRv8yCcGxE53lLMYT8UUgNv936IpWWMS46e8lD0jh5Y9zm2OXpQ/lPVcLIE9Ar8nHPNMJJ682GMLlIEBFA5UudG4jjfTC9HPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705571142; c=relaxed/simple;
	bh=c5GlTcVsIcPhCRJCpqIoAGFuw7rgWBqy6nAzdAEPXVU=;
	h=Received:DKIM-Signature:Received:Received:Received:Received:From:
	 To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-EXCLAIMER-MD-CONFIG; b=SfqlOKQ8vVAF1/O2QB62uDQr+OFYPyRwGcwkY/EWwk5mbx2bm1nbiUKJkxX4Y0vzvw72sX7RrpboYy8xIx4VkIZgfvQIudri5AM7Q4j7wRpwwSzt5FYYtmTT3DH0FKjg0aHkvyqCe1gMXiJDPKshBJa6KIoyeDPvZazdJJqwG+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=xeLI7ZLC; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40I9jY3u092000;
	Thu, 18 Jan 2024 03:45:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1705571134;
	bh=GCYtRKqYRCQZAdxhPg4iYh8uQa4d3MRruLSrphd47nY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=xeLI7ZLCQLIv+S/uWt7CilxJZzSXkPWC6JqiFCv9p1BAf4tgObxSbbmog5Vo76sHO
	 MQjZkVOSnivMv9HFmzC5vixjHaBcf3kX/tCr8O5A/1vCOEPE9WIA7gwwM4Q2ae5nKw
	 b4rd+8CSRaQsbX6EYwP4ME5gFV17eDtH9c2oNTPs=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40I9jYpX015399
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 18 Jan 2024 03:45:34 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 18
 Jan 2024 03:45:33 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 18 Jan 2024 03:45:33 -0600
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40I9jWPj002480;
	Thu, 18 Jan 2024 03:45:33 -0600
From: Chintan Vankar <c-vankar@ti.com>
To: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Tero
 Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, Nishanth
 Menon <nm@ti.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <afd@ti.com>, <srk@ti.com>,
        <s-vadapalli@ti.com>, <r-gunasekaran@ti.com>, <c-vankar@ti.com>,
        <danishanwar@ti.com>, <tony@atomide.com>
Subject: [PATCH v2 5/5] arm64: dts: ti: k3-j784s4: Add overlay for dual port USXGMII mode
Date: Thu, 18 Jan 2024 15:14:54 +0530
Message-ID: <20240118094454.2656734-6-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118094454.2656734-1-c-vankar@ti.com>
References: <20240118094454.2656734-1-c-vankar@ti.com>
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
 .../ti/k3-j784s4-evm-usxgmii-exp1-exp2.dtso   | 73 +++++++++++++++++++
 2 files changed, 78 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j784s4-evm-usxgmii-exp1-exp2.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 836bc197d932..97be325235dc 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -82,6 +82,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-j721s2-evm-pcie1-ep.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am69-sk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm-quad-port-eth-exp1.dtbo
+dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm-usxgmii-exp1-exp2.dtbo
 
 # Build time test only, enabled by CONFIG_OF_ALL_DTBS
 k3-am625-beagleplay-csi2-ov5640-dtbs := k3-am625-beagleplay.dtb \
@@ -112,6 +113,8 @@ k3-j721s2-evm-pcie1-ep-dtbs := k3-j721s2-common-proc-board.dtb \
 	k3-j721s2-evm-pcie1-ep.dtbo
 k3-j784s4-evm-quad-port-eth-exp1-dtbs := k3-j784s4-evm.dtb \
 	k3-j784s4-evm-quad-port-eth-exp1.dtbo
+k3-j784s4-evm-usxgmii-exp1-exp2.dtbs := k3-j784s4-evm.dtb \
+	k3-j784s4-evm-usxgmii-exp1-exp2.dtbo
 dtb- += k3-am625-beagleplay-csi2-ov5640.dtb \
 	k3-am625-beagleplay-csi2-tevi-ov5640.dtb \
 	k3-am625-sk-csi2-imx219.dtb \
@@ -125,7 +128,8 @@ dtb- += k3-am625-beagleplay-csi2-ov5640.dtb \
 	k3-am642-tqma64xxl-mbax4xxl-wlan.dtb \
 	k3-j721e-evm-pcie0-ep.dtb \
 	k3-j721s2-evm-pcie1-ep.dtb \
-	k3-j784s4-evm-quad-port-eth-exp1.dtb
+	k3-j784s4-evm-quad-port-eth-exp1.dtb \
+	k3-j784s4-evm-usxgmii-exp1-exp2.dtb
 
 # Enable support for device-tree overlays
 DTC_FLAGS_k3-am625-beagleplay += -@
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm-usxgmii-exp1-exp2.dtso b/arch/arm64/boot/dts/ti/k3-j784s4-evm-usxgmii-exp1-exp2.dtso
new file mode 100644
index 000000000000..e51381f0a265
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm-usxgmii-exp1-exp2.dtso
@@ -0,0 +1,73 @@
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


