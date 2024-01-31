Return-Path: <linux-kernel+bounces-46194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B07D843C06
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ECA31C25E92
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EEC7866E;
	Wed, 31 Jan 2024 10:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hfKmreoZ"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2069B76919;
	Wed, 31 Jan 2024 10:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706696126; cv=none; b=eitUx+Q3k4eVtbrX1ku0EqsQ9fhKP4q4/8+Yb9dbCVv6wkPa6K9BdfT07BicBpz3SO4VYofO9pHlL/7gK0CCn3EBRSlkBunQzgf/HhWJn8nqtECHcQkPK+KL2STTPEbWwG9cfkz1PjxSA8gZqwaiW6Y0IsV/ZqlrsXp8xww7tP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706696126; c=relaxed/simple;
	bh=DH5NiegzsYQpiijOn8/YrWg0zYL9KB6NJv4gbpeVvEQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y5FB6bycUiDS8rBQydXrh5XXRyGYGCFaCdyKA5FlgDT1/i2oH68KLYzsDPxhbqfOsXXjvT7ZVtvXFODKCbpWjwnjDMS0AgtVxyhVy0V4Zc7YdpNMLCjHtDx5ZIeYCG5yzdUl0lMGtYVWgWiy3NH4eCnscukBF/WhMEqSEPEs+KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hfKmreoZ; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40VAEpUo065453;
	Wed, 31 Jan 2024 04:14:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706696091;
	bh=oqemPubLVRrgYvvfimFAejLxoKvjxzL1JVzVCjpzc9Q=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=hfKmreoZO1hN0nuNHxYFKZbiuQiKZILt9BIdoCUyzB8I9Zjyz4lETxXdka9BjkwYH
	 dAXm89GQGCy0JoI24yf/CjEXoeF+99RfKRZwvSgVMBptuzJj/8e9D0NN1Fb1XGx/AW
	 ykIJh4Xf4l1eiDkbsF8DGQOm2WBOu1qcXUyMlyE0=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40VAEoXH006848
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 31 Jan 2024 04:14:50 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jan 2024 04:14:50 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jan 2024 04:14:50 -0600
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40VAEnaV110279;
	Wed, 31 Jan 2024 04:14:50 -0600
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
        Jayesh Choudhary
	<j-choudhary@ti.com>,
        Chintan Vankar <c-vankar@ti.com>
Subject: [PATCH v4 4/6] arm64: dts: ti: k3-j784s4: Add Main CPSW2G node
Date: Wed, 31 Jan 2024 15:44:39 +0530
Message-ID: <20240131101441.1362409-5-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240131101441.1362409-1-c-vankar@ti.com>
References: <20240131101441.1362409-1-c-vankar@ti.com>
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

Add the device-tree nodes for the Main CPSW2G instance and enable it.

Add alias for the Main CPSW2G port to enable Linux to fetch MAC Address
for the port directly from U-Boot.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 49 ++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
index b74f7d3025de..be028c246c67 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
@@ -28,6 +28,7 @@ aliases {
 		i2c0 = &wkup_i2c0;
 		i2c3 = &main_i2c0;
 		ethernet0 = &mcu_cpsw_port1;
+		ethernet1 = &main_cpsw1_port1;
 	};
 
 	memory@80000000 {
@@ -280,6 +281,30 @@ &wkup_gpio0 {
 
 &main_pmx0 {
 	bootph-all;
+	main_cpsw2g_default_pins: main-cpsw2g-default-pins {
+		pinctrl-single,pins = <
+			J784S4_IOPAD(0x0b8, PIN_INPUT, 6) /* (AC34) MCASP1_ACLKX.RGMII1_RD0 */
+			J784S4_IOPAD(0x0a0, PIN_INPUT, 6) /* (AD34) MCASP0_AXR12.RGMII1_RD1 */
+			J784S4_IOPAD(0x0a4, PIN_INPUT, 6) /* (AJ36) MCASP0_AXR13.RGMII1_RD2 */
+			J784S4_IOPAD(0x0a8, PIN_INPUT, 6) /* (AF34) MCASP0_AXR14.RGMII1_RD3 */
+			J784S4_IOPAD(0x0b0, PIN_INPUT, 6) /* (AL33) MCASP1_AXR3.RGMII1_RXC */
+			J784S4_IOPAD(0x0ac, PIN_INPUT, 6) /* (AE34) MCASP0_AXR15.RGMII1_RX_CTL */
+			J784S4_IOPAD(0x08c, PIN_INPUT, 6) /* (AE35) MCASP0_AXR7.RGMII1_TD0 */
+			J784S4_IOPAD(0x090, PIN_INPUT, 6) /* (AC35) MCASP0_AXR8.RGMII1_TD1 */
+			J784S4_IOPAD(0x094, PIN_INPUT, 6) /* (AG35) MCASP0_AXR9.RGMII1_TD2 */
+			J784S4_IOPAD(0x098, PIN_INPUT, 6) /* (AH36) MCASP0_AXR10.RGMII1_TD3 */
+			J784S4_IOPAD(0x0b4, PIN_INPUT, 6) /* (AL34) MCASP1_AXR4.RGMII1_TXC */
+			J784S4_IOPAD(0x09c, PIN_INPUT, 6) /* (AF35) MCASP0_AXR11.RGMII1_TX_CTL */
+		>;
+	};
+
+	main_cpsw2g_mdio_default_pins: main-cpsw2g-mdio-default-pins {
+		pinctrl-single,pins = <
+			J784S4_IOPAD(0x0c0, PIN_INPUT, 6) /* (AD38) MCASP1_AXR0.MDIO0_MDC */
+			J784S4_IOPAD(0x0bc, PIN_INPUT, 6) /* (AD33) MCASP1_AFSX.MDIO0_MDIO */
+		>;
+	};
+	
 	main_uart8_pins_default: main-uart8-default-pins {
 		bootph-all;
 		pinctrl-single,pins = <
@@ -809,6 +834,30 @@ &mcu_cpsw_port1 {
 	phy-handle = <&mcu_phy0>;
 };
 
+&main_cpsw1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_cpsw2g_default_pins>;
+};
+
+&main_cpsw1_mdio {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_cpsw2g_mdio_default_pins>;
+
+	main_cpsw1_phy0: ethernet-phy@0 {
+		reg = <0>;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+		ti,min-output-impedance;
+	};
+};
+
+&main_cpsw1_port1 {
+	status = "okay";
+	phy-mode = "rgmii-rxid";
+	phy-handle = <&main_cpsw1_phy0>;
+};
+
 &mailbox0_cluster0 {
 	status = "okay";
 	interrupts = <436>;
-- 
2.34.1


