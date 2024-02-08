Return-Path: <linux-kernel+bounces-58060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD01784E0B9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E18C2877A8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F070278B44;
	Thu,  8 Feb 2024 12:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HXx8JDz/"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E004763E3;
	Thu,  8 Feb 2024 12:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707395593; cv=none; b=QL6ZbCY+elyPFkTw2MkCFuLxOM/R1z6U+aWjvKFFjxbGZ87QFFMByxeyiTvQVmo7mjXFMGgYaSqbde9otrHK4gXGl8rAPh9mlHpQTvghqUoCLwHyeSgDVNJCY76TzT6EW9+HqfiuOQ02NCSyRRfC4FSRpxmN6+VEe3gHKMAMEk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707395593; c=relaxed/simple;
	bh=O5VB/1AdaK5TqXXBO/TwdKGw69+R+Xw6j2ZsiknLezU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WlibSE7i0WoooRfbZjaSVqn1d7Ojm2jG3J1NrbiEKIsZCtEA2uvytGVUA4q6g6xGfpHNSARdF3E8keNxpYOShM6VLm9nrw9J2KtE8moCMLINI1SptgzqDYoxw9P0dMbGajRgbCx333VeSKkna8yzXSxH9KJxIf1rFuBqON5Cbys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HXx8JDz/; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 418CX4KU031133;
	Thu, 8 Feb 2024 06:33:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707395584;
	bh=hCCOXa05ODAH1a822OcuHgt/RJjrEsz2rIxEHyk9pHc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=HXx8JDz/NXt6cezG1zIscgcfws5oLYPtRdO8D25nJ34uOXHr30kwAEUUouW58dE/L
	 Rd9iMR7f4pLCzFkfcHjwgE+4SnNfP/ynP7Hjh1I2RwzLzMTU9r1ArWama2kIleu+BK
	 JEBXXJYdNFYVQz2yRoCP7SWYE8vNwzEg71ExStsc=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 418CX45r026504
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Feb 2024 06:33:04 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Feb 2024 06:33:04 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Feb 2024 06:33:03 -0600
Received: from uda0490681.. ([10.24.69.142])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 418CWY1N074789;
	Thu, 8 Feb 2024 06:33:00 -0600
From: Vaishnav Achath <vaishnav.a@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <kernel@pengutronix.de>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vaishnav.a@ti.com>, <u-kumar1@ti.com>, <j-choudhary@ti.com>,
        <j-luthra@ti.com>, <afd@ti.com>
Subject: [PATCH v3 6/9] arm64: dts: ti: k3-j721e-main: Add CSI2RX capture nodes
Date: Thu, 8 Feb 2024 18:02:30 +0530
Message-ID: <20240208123233.391115-7-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208123233.391115-1-vaishnav.a@ti.com>
References: <20240208123233.391115-1-vaishnav.a@ti.com>
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


