Return-Path: <linux-kernel+bounces-66462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F24855D0C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4CA41C21F76
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9911BC57;
	Thu, 15 Feb 2024 08:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rlxAKeC8"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5588D1BC3A;
	Thu, 15 Feb 2024 08:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707987358; cv=none; b=nf8Z6F8D3d2iGlXGRy+WSyVLEH4VkPTglt2vnqW0KPANW5XN1+bSuTPU9rUDfkhmKuL3ATa21PHBhUBJcjreNvLJovjfoD9NkXaeOs/WxKyUjiN5ZY4wVlZ92HmAuvdmlNbBpHVD4+1Liwzfl7oOx8svaM07+SV0KM4887pUw5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707987358; c=relaxed/simple;
	bh=2LuzAj83T0Ukw1lY+n18b5eU1N5KKNiKZLnAXjo+tUw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q1DQdJ1T3Zc9pblO3stSEtdztKru/bxtWJ7tA+IVf3hUTV3fOkkci4e+GwQ4wCs6bKjVV/bPoUm87yZy738ijr25bb4XIQJn01hR+exfCJZxylx45MEtOfWavxtlbThXc4UrGYVdMj1T+tz332S8DuNObngF28BvQ/d8knHVpd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rlxAKeC8; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41F8tmvc069361;
	Thu, 15 Feb 2024 02:55:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707987348;
	bh=hle8B4wOVmCnu+NYK66b75xWUwcEbuBSDmVLCNAJScI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=rlxAKeC85VYJe8tY7WGT23mD307aoEbJXP84Rl3Cf+yAsMO948nvpgd8jupgujbb1
	 D8rHaOXcKLTGHKQwimNxZ9+MXKPZ9xDR4o1DoRnBtxOZX9VdkS+C+YLveINmtt72jh
	 5PhHX5jD6BlVW+kA/77p7rwOk/vMGSZnL4qCBI1A=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41F8tmtn059755
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 15 Feb 2024 02:55:48 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Feb 2024 02:55:48 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Feb 2024 02:55:48 -0600
Received: from uda0490681.. ([10.24.69.142])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41F8tJ7p008333;
	Thu, 15 Feb 2024 02:55:44 -0600
From: Vaishnav Achath <vaishnav.a@ti.com>
To: <vigneshr@ti.com>, <nm@ti.com>, <conor+dt@kernel.org>, <kristo@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>
CC: <j-luthra@ti.com>, <devicetree@vger.kernel.org>, <j-choudhary@ti.com>,
        <kernel@pengutronix.de>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>, <vaishnav.a@ti.com>,
        <afd@ti.com>
Subject: [PATCH v4 6/9] arm64: dts: ti: k3-j721e-main: Add CSI2RX capture nodes
Date: Thu, 15 Feb 2024 14:25:15 +0530
Message-ID: <20240215085518.552692-7-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215085518.552692-1-vaishnav.a@ti.com>
References: <20240215085518.552692-1-vaishnav.a@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

J721E has two CSI2RX capture subsystem featuring Cadence CSI2RX,
DPHY and TI's pixel grabbing wrapper. Add nodes for the same and
keep them disabled by default.

J721E TRM (Section 12.7 Camera Subsystem):
	https://www.ti.com/lit/zip/spruil1

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
Reviewed-by: Jai Luthra <j-luthra@ti.com>
---

V2->V3: Fix order of properties as per dts coding style.
V1->V2: Update commit message with TRM.

 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 122 ++++++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index 062a6fca5a31..841752d20de1 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -572,6 +572,128 @@ main_timerio_output: pinctrl@104280 {
 		pinctrl-single,function-mask = <0x0000001f>;
 	};
 
+	ti_csi2rx0: ticsi2rx@4500000 {
+		compatible = "ti,j721e-csi2rx-shim";
+		reg = <0x0 0x4500000 0x0 0x1000>;
+		ranges;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		dmas = <&main_udmap 0x4940>;
+		dma-names = "rx0";
+		power-domains = <&k3_pds 26 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+
+		cdns_csi2rx0: csi-bridge@4504000 {
+			compatible = "ti,j721e-csi2rx", "cdns,csi2rx";
+			reg = <0x0 0x4504000 0x0 0x1000>;
+			clocks = <&k3_clks 26 2>, <&k3_clks 26 0>, <&k3_clks 26 2>,
+				<&k3_clks 26 2>, <&k3_clks 26 3>, <&k3_clks 26 3>;
+			clock-names = "sys_clk", "p_clk", "pixel_if0_clk",
+				"pixel_if1_clk", "pixel_if2_clk", "pixel_if3_clk";
+			phys = <&dphy0>;
+			phy-names = "dphy";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				csi0_port0: port@0 {
+					reg = <0>;
+					status = "disabled";
+				};
+
+				csi0_port1: port@1 {
+					reg = <1>;
+					status = "disabled";
+				};
+
+				csi0_port2: port@2 {
+					reg = <2>;
+					status = "disabled";
+				};
+
+				csi0_port3: port@3 {
+					reg = <3>;
+					status = "disabled";
+				};
+
+				csi0_port4: port@4 {
+					reg = <4>;
+					status = "disabled";
+				};
+			};
+		};
+	};
+
+	ti_csi2rx1: ticsi2rx@4510000 {
+		compatible = "ti,j721e-csi2rx-shim";
+		reg = <0x0 0x4510000 0x0 0x1000>;
+		ranges;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		dmas = <&main_udmap 0x4960>;
+		dma-names = "rx0";
+		power-domains = <&k3_pds 27 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+
+		cdns_csi2rx1: csi-bridge@4514000 {
+			compatible = "ti,j721e-csi2rx", "cdns,csi2rx";
+			reg = <0x0 0x4514000 0x0 0x1000>;
+			clocks = <&k3_clks 27 2>, <&k3_clks 27 0>, <&k3_clks 27 2>,
+				 <&k3_clks 27 2>, <&k3_clks 27 3>, <&k3_clks 27 3>;
+			clock-names = "sys_clk", "p_clk", "pixel_if0_clk",
+				      "pixel_if1_clk", "pixel_if2_clk", "pixel_if3_clk";
+			phys = <&dphy1>;
+			phy-names = "dphy";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				csi1_port0: port@0 {
+					reg = <0>;
+					status = "disabled";
+				};
+
+				csi1_port1: port@1 {
+					reg = <1>;
+					status = "disabled";
+				};
+
+				csi1_port2: port@2 {
+					reg = <2>;
+					status = "disabled";
+				};
+
+				csi1_port3: port@3 {
+					reg = <3>;
+					status = "disabled";
+				};
+
+				csi1_port4: port@4 {
+					reg = <4>;
+					status = "disabled";
+				};
+			};
+		};
+	};
+
+	dphy0: phy@4580000 {
+		compatible = "cdns,dphy-rx";
+		reg = <0x0 0x4580000 0x0 0x1100>;
+		#phy-cells = <0>;
+		power-domains = <&k3_pds 147 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	dphy1: phy@4590000 {
+		compatible = "cdns,dphy-rx";
+		reg = <0x0 0x4590000 0x0 0x1100>;
+		#phy-cells = <0>;
+		power-domains = <&k3_pds 148 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
 	serdes_wiz0: wiz@5000000 {
 		compatible = "ti,j721e-wiz-16g";
 		#address-cells = <1>;
-- 
2.34.1


