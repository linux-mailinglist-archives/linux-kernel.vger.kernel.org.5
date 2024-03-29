Return-Path: <linux-kernel+bounces-124158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2042891334
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 06:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2101E1C22F1E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 05:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBB53D0AD;
	Fri, 29 Mar 2024 05:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Tr0+KTI0"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56538494;
	Fri, 29 Mar 2024 05:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711690330; cv=none; b=labxcLdD+bXISNxMh1MwzsNbhX+pIh8SkX/8LuFmTmo+C9xx817PTmNs2N/TQ49bbN7vaJbAI/iUFSM+7C5PwMGzE27q0WoDLqnAfTCunGgz/Et/nYgg5XnmdBDxoSeBN9xNA+KPaR2njAKu+Io+muNo4OwfU0/XzV3b1LQ9cWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711690330; c=relaxed/simple;
	bh=iwZ7XlpgGAiHCYKvCILLLUkkpUPwYVKiIne5ZYGzUiI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eQ7CqYen+M0CiLutP76jwaIjLaRXyZuyp98crivd5ffKAN0r5mencUcCWeiwy/r7tPIQXDKEcPtb7qsMy3cUcK+IJxsLztfTXWwN6OZ+M2VZgfxXJcumLMLddI5Wem61TTX6QZjx+WCcs61txQ8860tzoqu9rSnNHRZOXLoMLKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Tr0+KTI0; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42T5W0F4085225;
	Fri, 29 Mar 2024 00:32:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711690320;
	bh=Gep6ZlMCV1MuvJRowBdZmIjw9g/6y0plhY5O6rrOiHw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Tr0+KTI0SCwr96O030D0gb8TohUot59sTI7IFdjsyyqISWip6OsWDEj/KSFdAyBog
	 LukCQsXm+EFsCMWGILmWTSmq8mRL3BxsnBiU2jXPJDbM942kzwg9KIQD+oWCJdCMIO
	 jiiE9Z1ihuwfWrjl7oITHhReNNnCeXwA8Lq27Z8E=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42T5W0HR033937
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 29 Mar 2024 00:32:00 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 29
 Mar 2024 00:31:59 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 29 Mar 2024 00:31:58 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42T5Vw7K108679;
	Fri, 29 Mar 2024 00:31:58 -0500
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
Subject: [PATCH v6 2/5] arm64: dts: ti: k3-j784s4-main: Add CPSW2G and CPSW9G nodes
Date: Fri, 29 Mar 2024 11:01:27 +0530
Message-ID: <20240329053130.2822129-3-c-vankar@ti.com>
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

J784S4 SoC has MAIN CPSW2G and CPSW9G instances of the CPSW
Ethernet Switch. CPSW2G has 1 external port and 1 host port
while CPSW9G has 8 external ports and 1 host port.

Add device-tree nodes for MAIN CPSW2G and CPSW9G and disable
them by default. MAIN CPSW2G will be enabled in the board file
while device-tree overlays will be used to enable CPSW9G.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

Link to v5:
https://lore.kernel.org/r/20240314072129.1520475-3-c-vankar@ti.com/

Changes from v5 to v6:
- Updated order of properties in Device Nodes based on
  https://docs.kernel.org/devicetree/bindings/dts-coding-style.html#order-of-properties-in-device-node

 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 187 +++++++++++++++++++++
 1 file changed, 187 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
index b67c37460a73..7dfa43d25d38 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
@@ -48,6 +48,19 @@ scm_conf: bus@100000 {
 		#size-cells = <1>;
 		ranges = <0x00 0x00 0x00100000 0x1c000>;
 
+		cpsw1_phy_gmii_sel: phy@4034 {
+			compatible = "ti,am654-phy-gmii-sel";
+			reg = <0x4034 0x4>;
+			#phy-cells = <1>;
+		};
+
+		cpsw0_phy_gmii_sel: phy@4044 {
+			compatible = "ti,j784s4-cpsw9g-phy-gmii-sel";
+			reg = <0x4044 0x20>;
+			#phy-cells = <1>;
+			ti,qsgmii-main-ports = <7>, <7>;
+		};
+
 		serdes_ln_ctrl: mux-controller@4080 {
 			compatible = "reg-mux";
 			reg = <0x00004080 0x30>;
@@ -1439,6 +1452,180 @@ cpts@310d0000 {
 		};
 	};
 
+	main_cpsw0: ethernet@c000000 {
+		compatible = "ti,j784s4-cpswxg-nuss";
+		reg = <0x00 0xc000000 0x00 0x200000>;
+		reg-names = "cpsw_nuss";
+		ranges = <0x00 0x00 0x00 0xc000000 0x00 0x200000>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		dma-coherent;
+		clocks = <&k3_clks 64 0>;
+		clock-names = "fck";
+		power-domains = <&k3_pds 64 TI_SCI_PD_EXCLUSIVE>;
+
+		dmas = <&main_udmap 0xca00>,
+		       <&main_udmap 0xca01>,
+		       <&main_udmap 0xca02>,
+		       <&main_udmap 0xca03>,
+		       <&main_udmap 0xca04>,
+		       <&main_udmap 0xca05>,
+		       <&main_udmap 0xca06>,
+		       <&main_udmap 0xca07>,
+		       <&main_udmap 0x4a00>;
+		dma-names = "tx0", "tx1", "tx2", "tx3",
+			    "tx4", "tx5", "tx6", "tx7",
+			    "rx";
+
+		status = "disabled";
+
+		ethernet-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			main_cpsw0_port1: port@1 {
+				reg = <1>;
+				label = "port1";
+				ti,mac-only;
+				status = "disabled";
+			};
+
+			main_cpsw0_port2: port@2 {
+				reg = <2>;
+				label = "port2";
+				ti,mac-only;
+				status = "disabled";
+			};
+
+			main_cpsw0_port3: port@3 {
+				reg = <3>;
+				label = "port3";
+				ti,mac-only;
+				status = "disabled";
+			};
+
+			main_cpsw0_port4: port@4 {
+				reg = <4>;
+				label = "port4";
+				ti,mac-only;
+				status = "disabled";
+			};
+
+			main_cpsw0_port5: port@5 {
+				reg = <5>;
+				label = "port5";
+				ti,mac-only;
+				status = "disabled";
+			};
+
+			main_cpsw0_port6: port@6 {
+				reg = <6>;
+				label = "port6";
+				ti,mac-only;
+				status = "disabled";
+			};
+
+			main_cpsw0_port7: port@7 {
+				reg = <7>;
+				label = "port7";
+				ti,mac-only;
+				status = "disabled";
+			};
+
+			main_cpsw0_port8: port@8 {
+				reg = <8>;
+				label = "port8";
+				ti,mac-only;
+				status = "disabled";
+			};
+		};
+
+		main_cpsw0_mdio: mdio@f00 {
+			compatible = "ti,cpsw-mdio","ti,davinci_mdio";
+			reg = <0x00 0xf00 0x00 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&k3_clks 64 0>;
+			clock-names = "fck";
+			bus_freq = <1000000>;
+			status = "disabled";
+		};
+
+		cpts@3d000 {
+			compatible = "ti,am65-cpts";
+			reg = <0x00 0x3d000 0x00 0x400>;
+			clocks = <&k3_clks 64 3>;
+			clock-names = "cpts";
+			interrupts-extended = <&gic500 GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "cpts";
+			ti,cpts-ext-ts-inputs = <4>;
+			ti,cpts-periodic-outputs = <2>;
+		};
+	};
+
+	main_cpsw1: ethernet@c200000 {
+		compatible = "ti,j721e-cpsw-nuss";
+		reg = <0x00 0xc200000 0x00 0x200000>;
+		reg-names = "cpsw_nuss";
+		ranges = <0x00 0x00 0x00 0xc200000 0x00 0x200000>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		dma-coherent;
+		clocks = <&k3_clks 62 0>;
+		clock-names = "fck";
+		power-domains = <&k3_pds 62 TI_SCI_PD_EXCLUSIVE>;
+
+		dmas = <&main_udmap 0xc640>,
+			<&main_udmap 0xc641>,
+			<&main_udmap 0xc642>,
+			<&main_udmap 0xc643>,
+			<&main_udmap 0xc644>,
+			<&main_udmap 0xc645>,
+			<&main_udmap 0xc646>,
+			<&main_udmap 0xc647>,
+			<&main_udmap 0x4640>;
+		dma-names = "tx0", "tx1", "tx2", "tx3",
+				"tx4", "tx5", "tx6", "tx7",
+				"rx";
+
+		status = "disabled";
+
+		ethernet-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			main_cpsw1_port1: port@1 {
+				reg = <1>;
+				label = "port1";
+				phys = <&cpsw1_phy_gmii_sel 1>;
+				ti,mac-only;
+				status = "disabled";
+			};
+		};
+
+		main_cpsw1_mdio: mdio@f00 {
+			compatible = "ti,cpsw-mdio", "ti,davinci_mdio";
+			reg = <0x00 0xf00 0x00 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&k3_clks 62 0>;
+			clock-names = "fck";
+			bus_freq = <1000000>;
+			status = "disabled";
+		};
+
+		cpts@3d000 {
+			compatible = "ti,am65-cpts";
+			reg = <0x00 0x3d000 0x00 0x400>;
+			clocks = <&k3_clks 62 3>;
+			clock-names = "cpts";
+			interrupts-extended = <&gic500 GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "cpts";
+			ti,cpts-ext-ts-inputs = <4>;
+			ti,cpts-periodic-outputs = <2>;
+		};
+	};
+
 	main_mcan0: can@2701000 {
 		compatible = "bosch,m_can";
 		reg = <0x00 0x02701000 0x00 0x200>,
-- 
2.34.1


