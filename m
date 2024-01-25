Return-Path: <linux-kernel+bounces-38361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 016F983BE4E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F9041F286DA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5631CF9C;
	Thu, 25 Jan 2024 10:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yRqAt+1U"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17F21CAAB;
	Thu, 25 Jan 2024 10:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706177158; cv=none; b=BESgfjhCW1PIioJUhjfiLS6we8kIYlRUx7HN2JewVXFAzlIszTHNTLu3zNLVcyK1pVEUuez227DwcIED1ogY+qUZaeIfQi1iNEhqK8SZg758BGlPvAn9xN2BFgpFRrRVo3q92/EJt4Pk5ecjnYdIQNpAQIiyCSLCaP3Kx8PDte4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706177158; c=relaxed/simple;
	bh=c1uva+z+y5hGlOHeBCl0K3AuvNbbYB78TXAsQlTHMzw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nRL41WD1/c/jDoWIIRtDwrBEUH5FaBLhR03XONx6XsCp1n2Ar4+W4MrWpAT3HJHozzzxYrhq4RxdlC+ekWIEZPBZaQJE7XCOrp5D3H0w665BDEzV4cN8Ke/7FizsxGxpTSLqWytOIjRFyMbtwhnZFDLaNV48yK0jdX1lW++w1lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=yRqAt+1U; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40PA5GV0082170;
	Thu, 25 Jan 2024 04:05:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706177116;
	bh=zSS6F8ZL7Y/5nL1xWFoL6nxBS7JhsnNIJXNGpKQAMg0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=yRqAt+1U9Pp6oLxot2tfxuWImQ4dDIkZjL//q28HMoYCfG3hjpqHEfaP7YTAPIbJ6
	 Ke586PFprWYh0Xe7UqCLTQ0BNYlljMu0FrJnY4fdKjc6KjlihQqXwDqjFXrJYBgmTN
	 T/jRqxTi59nHllXiPC5GMJ9wAqCMmSj6NJQgDKwc=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40PA5GIQ122720
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 25 Jan 2024 04:05:16 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 25
 Jan 2024 04:05:16 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 25 Jan 2024 04:05:16 -0600
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40PA5FYo005082;
	Thu, 25 Jan 2024 04:05:16 -0600
From: Chintan Vankar <c-vankar@ti.com>
To: Andrew Davis <afd@ti.com>, Peter Rosin <peda@axentia.se>,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Tero
 Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, Nishanth
 Menon <nm@ti.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>, <r-gunasekaran@ti.com>, <danishanwar@ti.com>,
        Chintan Vankar
	<c-vankar@ti.com>
Subject: [PATCH v3 2/5] arm64: dts: ti: k3-j784s4-main: Add CPSW2G and CPSW9G nodes
Date: Thu, 25 Jan 2024 15:34:58 +0530
Message-ID: <20240125100501.4137977-3-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125100501.4137977-1-c-vankar@ti.com>
References: <20240125100501.4137977-1-c-vankar@ti.com>
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

J784S4 SoC has a 9 port Ethernet Switch instance with 8 external
ports and 1 host port, referred to as CPSW9G.

Add device-tree nodes for CPSW9G and disable it by default.
Device-tree overlays will be used to enable it.

Add device-tree nodes for Main CPSW2G nodes and disable it
by default.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 182 +++++++++++++++++++++
 1 file changed, 182 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
index 56c8eaad6324..89578b449450 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
@@ -47,6 +47,19 @@ scm_conf: bus@100000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0x00 0x00 0x00100000 0x1c000>;
+		
+		cpsw1_phy_gmii_sel: phy@4034 {
+			compatible = "ti,am654-phy-gmii-sel";
+			reg = <0x4034 0x4>;
+			#phy-cells = <1>;
+		};
+
+		cpsw0_phy_gmii_sel: phy@4044 {
+			compatible = "ti,j784s4-cpsw9g-phy-gmii-sel";
+			ti,qsgmii-main-ports = <7>, <7>;
+			reg = <0x4044 0x20>;
+			#phy-cells = <1>;
+		};
 
 		serdes_ln_ctrl: mux-controller@4080 {
 			compatible = "reg-mux";
@@ -1242,6 +1255,175 @@ cpts@310d0000 {
 		};
 	};
 
+	main_cpsw0: ethernet@c000000 {
+		compatible = "ti,j784s4-cpswxg-nuss";
+		reg = <0x00 0xc000000 0x00 0x200000>;
+		reg-names = "cpsw_nuss";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges = <0x00 0x00 0x00 0xc000000 0x00 0x200000>;
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
+				status = "disabled";
+			};
+
+			main_cpsw0_port6: port@6 {
+				reg = <6>;
+				label = "port6";
+				status = "disabled";
+			};
+
+			main_cpsw0_port7: port@7 {
+				reg = <7>;
+				label = "port7";
+				status = "disabled";
+			};
+
+			main_cpsw0_port8: port@8 {
+				reg = <8>;
+				label = "port8";
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
+		#address-cells = <2>;
+		#size-cells = <2>;
+		reg = <0x00 0xc200000 0x00 0x200000>;
+		reg-names = "cpsw_nuss";
+		ranges = <0x00 0x00 0x00 0xc200000 0x00 0x200000>;
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


