Return-Path: <linux-kernel+bounces-124161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6FB89133B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 06:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13B5C1F21C05
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 05:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073BA3FE2B;
	Fri, 29 Mar 2024 05:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="E+YY8P3k"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964CD3FB3D;
	Fri, 29 Mar 2024 05:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711690341; cv=none; b=DASuxXkT1SDEDKv9wWMJxDjeC0mgz7iHMC1jlp6van07mogZ/jJAr3zMiyHs4/ms/VwMZTZxRobn/PRQErOKq/Gc2zmLvqKCzKpRTEJmu9HQcIQFzJsjoCVfGeSw0GnrJlkAaaQnRIV3OFVcGoP0C5iZPEvLX597yVgFWcOqquE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711690341; c=relaxed/simple;
	bh=N+JnkHKrXRUXNOdmrSFKueguXFm3sigLPI1H/bcOUEc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n7gG6x/iQ1Res1XeXXG8YLOXhlWzx1owymChCbN8gnrFlXPkwb0LAh2g6NbQ3r2U4G9ehbste2fW4PYX9A4h3AhHLsSfXmK/i61OMssypkHU8KpBReWICtuN5KTCa1y5DrzDMw8zzyJX2mj+13kuhXI6v8sR0fzjRsQW0s2xgpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=E+YY8P3k; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42T5W0DM045042;
	Fri, 29 Mar 2024 00:32:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711690320;
	bh=ml7ZeKumI0uUKVfDLgLQbraBPQiZKHuA4RFTS1UL4ms=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=E+YY8P3kKfEHFnR0KQwrpZ/k9NAEDHFl64X3EY53VlvvYA5xEGcpnnvWETnK1S9WM
	 vesCvUy4EZIFwKnCXSsLqpgbpn8Va2jC7ubw+hhTUBrTb6kphaWwXvmm+R8FdrCiWo
	 s2c58YdipE2X8aRC0vARMQYsArilbdz+Q4QgxAyI=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42T5W0cB027911
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 29 Mar 2024 00:32:00 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 29
 Mar 2024 00:32:00 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 29 Mar 2024 00:32:00 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42T5VxOI108697;
	Fri, 29 Mar 2024 00:32:00 -0500
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
        Jayesh
 Choudhary <j-choudhary@ti.com>,
        Chintan Vankar <c-vankar@ti.com>
Subject: [PATCH v6 3/5] arm64: dts: ti: k3-j784s4-evm: Enable Main CPSW2G node and add aliases for it
Date: Fri, 29 Mar 2024 11:01:28 +0530
Message-ID: <20240329053130.2822129-4-c-vankar@ti.com>
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

Enable MAIN CPSW2G and add alias for it to enable Linux to fetch
MAC Address for the port directly from U-Boot.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

Link to v5:
https://lore.kernel.org/r/20240314072129.1520475-4-c-vankar@ti.com/

Changes from v5 to v6:
- Updated order of properties in Device Nodes based on
  https://docs.kernel.org/devicetree/bindings/dts-coding-style.html#order-of-properties-in-device-node

 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 50 ++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
index 1f390c22844e..637c8223b561 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
@@ -28,6 +28,7 @@ aliases {
 		i2c0 = &wkup_i2c0;
 		i2c3 = &main_i2c0;
 		ethernet0 = &mcu_cpsw_port1;
+		ethernet1 = &main_cpsw1_port1;
 	};
 
 	memory@80000000 {
@@ -281,6 +282,30 @@ &wkup_gpio0 {
 
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
@@ -833,6 +858,31 @@ &mcu_cpsw_port1 {
 	phy-handle = <&mcu_phy0>;
 };
 
+&main_cpsw1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_cpsw2g_default_pins>;
+	status = "okay";
+};
+
+&main_cpsw1_mdio {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_cpsw2g_mdio_default_pins>;
+	status = "okay";
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
+	phy-mode = "rgmii-rxid";
+	phy-handle = <&main_cpsw1_phy0>;
+	status = "okay";
+};
+
 &mailbox0_cluster0 {
 	status = "okay";
 	interrupts = <436>;
-- 
2.34.1


