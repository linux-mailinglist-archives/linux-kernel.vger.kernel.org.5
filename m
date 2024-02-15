Return-Path: <linux-kernel+bounces-66629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F58855F33
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 229F8B2FFF1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2869B7869C;
	Thu, 15 Feb 2024 10:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MMtMs1Ka"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B8E78676;
	Thu, 15 Feb 2024 10:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707993056; cv=none; b=VMagfTc0Ew5nakPksKOVY8zuzq1XMzlL7wLV4Fe4GNdMZitxBLZLEB9kp+5hvCU4q9H5SuMYDO8sd+hZ2OSsdYo1vjWRLP/qNQJm8HTtg6frIGBYFgSk2L2ui+K3wrZFNU6TGrSCmSPjZw0YooHLl91yr5kE7kODV0Yl+UVBnRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707993056; c=relaxed/simple;
	bh=X3XBYSeH39W9UL+WhmjgQJcaw67vXP2YPne3ri5xV30=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=It/0I+38fIfiiO4demzQ+1oUmZ7gijMjeLPNu1cC6PUwYzId7yTvJ0jjQR5WC2JLc8TxHqbAkRpGSEeyXRQozDfUWa2xOkRBhs20aU9s5u0rvuLtZTdlO+IGSXTkkCoOvleNEOhq/X7nlleVJXPCyOwuD3aiunZKEgt29Pnv1w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=MMtMs1Ka; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41FAUhiE118487;
	Thu, 15 Feb 2024 04:30:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707993043;
	bh=RCLYdyjLpqXCtVTm+i2zoUiUHsoLMDC32kZB6gqBUaA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=MMtMs1KamfxDN+ba8hri80Pyd/dWjHMgC7Ir2wMNENmeOwCDDF1SFMr0Ds6h4ZKlM
	 ttvW6IUTjhJz2+2bfU2dZN8lHIQtiqOK9yuUsn6TQn1fvQ3bgCR5zwrEsXldd8c/rf
	 NBmVhFWOjf5w/V+lX9S7YbjktdZp41qt9Rz3m2Bc=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41FAUghK025783
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 15 Feb 2024 04:30:43 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Feb 2024 04:30:42 -0600
Received: from fllvsmtp8.itg.ti.com (10.64.41.158) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Feb 2024 04:30:42 -0600
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by fllvsmtp8.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41FAUg9Y123701;
	Thu, 15 Feb 2024 04:30:42 -0600
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 41FAUfiT031779;
	Thu, 15 Feb 2024 04:30:42 -0600
From: MD Danish Anwar <danishanwar@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
CC: Andrew Lunn <andrew@lunn.ch>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Tero
 Kristo <kristo@kernel.org>, <srk@ti.com>, <r-gunasekaran@ti.com>,
        Roger
 Quadros <rogerq@kernel.org>,
        MD Danish Anwar <danishanwar@ti.com>
Subject: [PATCH v5 2/3] arm64: dts: ti: k3-am642-evm: add ICSSG1 Ethernet support
Date: Thu, 15 Feb 2024 16:00:35 +0530
Message-ID: <20240215103036.2825096-3-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215103036.2825096-1-danishanwar@ti.com>
References: <20240215103036.2825096-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

ICSSG1 provides dual Gigabit Ethernet support with proper FW loaded.

The ICSSG1 MII0 (RGMII1) has DP83869 PHY attached to it. The ICSSG1 shares
MII1 (RGMII2) PHY DP83869 with CPSW3g and it's assigned by default to
CPSW3g. The MDIO access to MII1 (RGMII2) PHY DP83869 is controlled by MDIO
bus switch and also assigned to CPSW3g. Therefore the ICSSG1 MII1 (RGMII2)
port is kept disable and ICSSG1 is enabled in single MAC mode by
default.

Reviewed-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am642-evm.dts | 95 +++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
index 5c546ae76d3e..daa925106856 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
@@ -32,6 +32,7 @@ aliases {
 		mmc1 = &sdhci1;
 		ethernet0 = &cpsw_port1;
 		ethernet1 = &cpsw_port2;
+		ethernet2 = &icssg1_emac0;
 	};
 
 	memory@80000000 {
@@ -229,6 +230,64 @@ transceiver2: can-phy1 {
 		max-bitrate = <5000000>;
 		standby-gpios = <&exp1 9 GPIO_ACTIVE_HIGH>;
 	};
+
+	icssg1_eth: icssg1-eth {
+		compatible = "ti,am642-icssg-prueth";
+		pinctrl-names = "default";
+		pinctrl-0 = <&icssg1_rgmii1_pins_default>;
+		sram = <&oc_sram>;
+		ti,prus = <&pru1_0>, <&rtu1_0>, <&tx_pru1_0>, <&pru1_1>, <&rtu1_1>, <&tx_pru1_1>;
+		firmware-name = "ti-pruss/am64x-sr2-pru0-prueth-fw.elf",
+				"ti-pruss/am64x-sr2-rtu0-prueth-fw.elf",
+				"ti-pruss/am64x-sr2-txpru0-prueth-fw.elf",
+				"ti-pruss/am64x-sr2-pru1-prueth-fw.elf",
+				"ti-pruss/am64x-sr2-rtu1-prueth-fw.elf",
+				"ti-pruss/am64x-sr2-txpru1-prueth-fw.elf";
+
+		ti,pruss-gp-mux-sel = <2>,	/* MII mode */
+				      <2>,
+				      <2>,
+				      <2>,	/* MII mode */
+				      <2>,
+				      <2>;
+		ti,mii-g-rt = <&icssg1_mii_g_rt>;
+		ti,mii-rt = <&icssg1_mii_rt>;
+		ti,iep = <&icssg1_iep0>,  <&icssg1_iep1>;
+		interrupt-parent = <&icssg1_intc>;
+		interrupts = <24 0 2>, <25 1 3>;
+		interrupt-names = "tx_ts0", "tx_ts1";
+		dmas = <&main_pktdma 0xc200 15>, /* egress slice 0 */
+		       <&main_pktdma 0xc201 15>, /* egress slice 0 */
+		       <&main_pktdma 0xc202 15>, /* egress slice 0 */
+		       <&main_pktdma 0xc203 15>, /* egress slice 0 */
+		       <&main_pktdma 0xc204 15>, /* egress slice 1 */
+		       <&main_pktdma 0xc205 15>, /* egress slice 1 */
+		       <&main_pktdma 0xc206 15>, /* egress slice 1 */
+		       <&main_pktdma 0xc207 15>, /* egress slice 1 */
+		       <&main_pktdma 0x4200 15>, /* ingress slice 0 */
+		       <&main_pktdma 0x4201 15>; /* ingress slice 1 */
+		dma-names = "tx0-0", "tx0-1", "tx0-2", "tx0-3",
+			    "tx1-0", "tx1-1", "tx1-2", "tx1-3",
+			    "rx0", "rx1";
+
+		ethernet-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			icssg1_emac0: port@0 {
+				reg = <0>;
+				phy-handle = <&icssg1_phy1>;
+				phy-mode = "rgmii-id";
+				/* Filled in by bootloader */
+				local-mac-address = [00 00 00 00 00 00];
+			};
+			icssg1_emac1: port@1 {
+				reg = <1>;
+				/* Filled in by bootloader */
+				local-mac-address = [00 00 00 00 00 00];
+				status = "disabled";
+			};
+		};
+	};
 };
 
 &main_pmx0 {
@@ -383,6 +442,30 @@ ddr_vtt_pins_default: ddr-vtt-default-pins {
 			AM64X_IOPAD(0x0030, PIN_OUTPUT_PULLUP, 7) /* (L18) OSPI0_CSN1.GPIO0_12 */
 		>;
 	};
+
+	icssg1_mdio1_pins_default: icssg1-mdio1-default-pins {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x015c, PIN_OUTPUT, 0) /* (Y6) PRG1_MDIO0_MDC */
+			AM64X_IOPAD(0x0158, PIN_INPUT, 0) /* (AA6) PRG1_MDIO0_MDIO */
+		>;
+	};
+
+	icssg1_rgmii1_pins_default: icssg1-rgmii1-default-pins{
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x00b8, PIN_INPUT, 2) /* (Y7) PRG1_PRU0_GPO0.PRG1_RGMII1_RD0 */
+			AM64X_IOPAD(0x00bc, PIN_INPUT, 2) /* (U8) PRG1_PRU0_GPO1.PRG1_RGMII1_RD1 */
+			AM64X_IOPAD(0x00c0, PIN_INPUT, 2) /* (W8) PRG1_PRU0_GPO2.PRG1_RGMII1_RD2 */
+			AM64X_IOPAD(0x00c4, PIN_INPUT, 2) /* (V8) PRG1_PRU0_GPO3.PRG1_RGMII1_RD3 */
+			AM64X_IOPAD(0x00d0, PIN_INPUT, 2) /* (AA7) PRG1_PRU0_GPO6.PRG1_RGMII1_RXC */
+			AM64X_IOPAD(0x00c8, PIN_INPUT, 2) /* (Y8) PRG1_PRU0_GPO4.PRG1_RGMII1_RX_CTL */
+			AM64X_IOPAD(0x00e4, PIN_INPUT, 2) /* (AA8) PRG1_PRU0_GPO11.PRG1_RGMII1_TD0 */
+			AM64X_IOPAD(0x00e8, PIN_INPUT, 2) /* (U9) PRG1_PRU0_GPO12.PRG1_RGMII1_TD1 */
+			AM64X_IOPAD(0x00ec, PIN_INPUT, 2) /* (W9) PRG1_PRU0_GPO13.PRG1_RGMII1_TD2 */
+			AM64X_IOPAD(0x00f0, PIN_INPUT, 2) /* (AA9) PRG1_PRU0_GPO14.PRG1_RGMII1_TD3 */
+			AM64X_IOPAD(0x00f8, PIN_INPUT, 2) /* (V9) PRG1_PRU0_GPO16.PRG1_RGMII1_TXC */
+			AM64X_IOPAD(0x00f4, PIN_INPUT, 2) /* (Y9) PRG1_PRU0_GPO15.PRG1_RGMII1_TX_CTL */
+		>;
+	};
 };
 
 &main_uart0 {
@@ -725,3 +808,15 @@ &main_mcan1 {
 	pinctrl-0 = <&main_mcan1_pins_default>;
 	phys = <&transceiver2>;
 };
+
+&icssg1_mdio {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&icssg1_mdio1_pins_default>;
+
+	icssg1_phy1: ethernet-phy@f {
+		reg = <0xf>;
+		tx-internal-delay-ps = <250>;
+		rx-internal-delay-ps = <2000>;
+	};
+};
-- 
2.34.1


