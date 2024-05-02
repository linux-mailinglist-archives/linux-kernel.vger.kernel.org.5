Return-Path: <linux-kernel+bounces-166181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 713048B973F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30CFA281D7D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3AC5476B;
	Thu,  2 May 2024 09:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bdKMVfKE"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C9D524D4;
	Thu,  2 May 2024 09:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714641049; cv=none; b=bz3SL4AnUtLGLxfnYYRFKQrB4CTiMgJb8eBdJj/rF/jL8EM4lJ0RX6ad6PVYuypuc1lN7icczOt0Mp606rxwEG+lSn2MVndwVhxPgll62GYu61TvhMzgO9Q2EdXZ3yYFuu+gP4ptvYDD73NWZl+XOX6I3PLz09Btp4jGihARK8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714641049; c=relaxed/simple;
	bh=yqetJrjP1VDFufCLlMINAgyf2WEgRKYUuVUtEc6TglE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lDEN1EJcxnauUlE74M2KIonTpRVYuoV2mkfv8SflIxXEyZLIsb2XpD4G9/3RbwhVcSj/iNAlhH2gl1GRoLZHKTa29UAZ9rhJPPVSRG2Z9tBHx8dXZp4xPg0n8YPQYVhOjCeSNyhAltHk3ALn7lSo1Yu1MXO+mwqAbuVM+nvo2uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=bdKMVfKE; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4429AeGI038129;
	Thu, 2 May 2024 04:10:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714641040;
	bh=plseDu9BMtLwpB/moD9OK1O6n/wABbwUQhRAx1bWHN8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=bdKMVfKEGY6XgdTdz9zOIb2G37/OCW/er3CGh8mNyKfuM3Z1Anvk6tFZu8JltA4rC
	 TpeIHwvLLMV13kmxrFhXjir1JMQ3fJXmgW+P1WqdzSpLFq8tCuY+MsusPYon2TidqQ
	 vgYv/PtMriM04dBQFGBY84NKL+FEvimAZoAwXNMA=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4429AeO2107805
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 2 May 2024 04:10:40 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 2
 May 2024 04:10:39 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 2 May 2024 04:10:39 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4429AcE8009046;
	Thu, 2 May 2024 04:10:39 -0500
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
        Jayesh Choudhary
	<j-choudhary@ti.com>,
        Chintan Vankar <c-vankar@ti.com>
Subject: [PATCH v7 3/5] arm64: dts: ti: k3-j784s4-evm: Enable Main CPSW2G node and add aliases for it
Date: Thu, 2 May 2024 14:40:00 +0530
Message-ID: <20240502091002.3659435-4-c-vankar@ti.com>
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

Enable MAIN CPSW2G and add alias for it to enable Linux to fetch
MAC Address for the port directly from U-Boot.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

Link to v6:
https://lore.kernel.org/r/20240329053130.2822129-4-c-vankar@ti.com/

Changes from v6 to v7:
- No changes.

 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 50 ++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
index 2fe6a582ceab..bc5c22383105 100644
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


