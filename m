Return-Path: <linux-kernel+bounces-42803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 701DB8406EF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CBCE2912A8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AB366B21;
	Mon, 29 Jan 2024 13:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gTi4/1v4"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2560C664D2;
	Mon, 29 Jan 2024 13:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706534908; cv=none; b=GXwEO0mfkwnwlOPy1XtzEvSwt6Dyaax3mob0pjeF+OgSPz/wB3pMaJPK1FHdNG9nVU24vB2Lnid283T6347c/eIxBY57JxGJGA8jjDeOORwDE58jSyjr0S4s5QDdQ2SQsnuSoEW6wiq2rA1D5W2N+uBmcvrgRmLyscewTIjhhvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706534908; c=relaxed/simple;
	bh=eVUHInxiODUYtyWT9k/HVdGbtzScxqt7/tPESxwlYoQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SIDoppslMGVEz1r5NbRY99TDaAAyxdZaz8OCj6eF5KdQ8Ca1hgAVRpsUSTQPdymaYKbpJ42E+Ou9/D5CJg22/mXMdg7iYWC3N1GrJARpK202agTq88hSsZ2G7isBcjvCUS28bhqfjHIFA+3gEGO+EjEvXsfWzDOLOLVQz6bRfMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=gTi4/1v4; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40TDSIr9128911;
	Mon, 29 Jan 2024 07:28:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706534898;
	bh=zgetJR1lh/mzD3OQJmaOrXLtboFXSxCuOAUDrLFxWyk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=gTi4/1v4Rf+tJG6ZhC8XofkM+N3J/ppj6MCZ2yJVk9b3y50rOyKC9Mayqk+0n/ysx
	 6MMFoaacinA43CbQMAXwkgJcWg3hXnlu89IrC+M4R50l3ehDpZbnYZs9puuk0BFhvm
	 K64W6vNA7eNJSNNwZy3r/97Uiiy35+lueITZtG4w=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40TDSIr8027477
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Jan 2024 07:28:18 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Jan 2024 07:28:18 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Jan 2024 07:28:18 -0600
Received: from uda0490681.dhcp.ti.com ([10.24.69.142])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40TDRg9I036720;
	Mon, 29 Jan 2024 07:28:14 -0600
From: Vaishnav Achath <vaishnav.a@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <kernel@pengutronix.de>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vaishnav.a@ti.com>, <u-kumar1@ti.com>, <j-choudhary@ti.com>,
        <j-luthra@ti.com>
Subject: [PATCH 8/9] arm64: dts: ti: k3-j784s4-main: Add CSI2RX capture nodes
Date: Mon, 29 Jan 2024 18:57:41 +0530
Message-ID: <20240129132742.1189783-9-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129132742.1189783-1-vaishnav.a@ti.com>
References: <20240129132742.1189783-1-vaishnav.a@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

J784S4 has three CSI2RX capture subsystem featuring Cadence CSI2RX,
DPHY and TI's pixel grabbing wrapper. Add nodes for the same and
keep them disabled by default. J784S4 uses a dedicated BCDMA instance
for CSI-RX traffic, so enable that as well.

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 183 ++++++++++++++++++++-
 1 file changed, 182 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
index f2b720ed1e4f..aa890eb456f5 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
@@ -662,6 +662,188 @@ main_i2c6: i2c@2060000 {
 		status = "disabled";
 	};
 
+	ti_csi2rx0: ticsi2rx@4500000 {
+		compatible = "ti,j721e-csi2rx-shim";
+		dmas = <&main_bcdma_csi 0 0x4940 0>;
+		dma-names = "rx0";
+		reg = <0x00 0x04500000 0x00 0x00001000>;
+		power-domains = <&k3_pds 72 TI_SCI_PD_EXCLUSIVE>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		status = "disabled";
+
+		cdns_csi2rx0: csi-bridge@4504000 {
+			compatible = "ti,j721e-csi2rx", "cdns,csi2rx";
+			reg = <0x00 0x04504000 0x00 0x00001000>;
+			clocks = <&k3_clks 72 2>, <&k3_clks 72 0>, <&k3_clks 72 2>,
+				<&k3_clks 72 2>, <&k3_clks 72 3>, <&k3_clks 72 3>;
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
+		dmas = <&main_bcdma_csi 0 0x4960 0>;
+		dma-names = "rx0";
+		reg = <0x00 0x04510000 0x00 0x1000>;
+		power-domains = <&k3_pds 73 TI_SCI_PD_EXCLUSIVE>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		status = "disabled";
+
+		cdns_csi2rx1: csi-bridge@4514000 {
+			compatible = "ti,j721e-csi2rx", "cdns,csi2rx";
+			reg = <0x00 0x04514000 0x00 0x00001000>;
+			clocks = <&k3_clks 73 2>, <&k3_clks 73 0>, <&k3_clks 73 2>,
+				<&k3_clks 73 2>, <&k3_clks 73 3>, <&k3_clks 73 3>;
+			clock-names = "sys_clk", "p_clk", "pixel_if0_clk",
+				"pixel_if1_clk", "pixel_if2_clk", "pixel_if3_clk";
+			phys = <&dphy1>;
+			phy-names = "dphy";
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
+	ti_csi2rx2: ticsi2rx@4520000 {
+		compatible = "ti,j721e-csi2rx-shim";
+		dmas = <&main_bcdma_csi 0 0x4980 0>;
+		dma-names = "rx0";
+		reg = <0x00 0x04520000 0x00 0x00001000>;
+		power-domains = <&k3_pds 74 TI_SCI_PD_EXCLUSIVE>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		status = "disabled";
+
+		cdns_csi2rx2: csi-bridge@4524000 {
+			compatible = "ti,j721e-csi2rx", "cdns,csi2rx";
+			reg = <0x00 0x04524000 0x00 0x00001000>;
+			clocks = <&k3_clks 74 2>, <&k3_clks 74 0>, <&k3_clks 74 2>,
+				<&k3_clks 74 2>, <&k3_clks 74 3>, <&k3_clks 74 3>;
+			clock-names = "sys_clk", "p_clk", "pixel_if0_clk",
+				"pixel_if1_clk", "pixel_if2_clk", "pixel_if3_clk";
+			phys = <&dphy2>;
+			phy-names = "dphy";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				csi2_port0: port@0 {
+					reg = <0>;
+					status = "disabled";
+				};
+
+				csi2_port1: port@1 {
+					reg = <1>;
+					status = "disabled";
+				};
+
+				csi2_port2: port@2 {
+					reg = <2>;
+					status = "disabled";
+				};
+
+				csi2_port3: port@3 {
+					reg = <3>;
+					status = "disabled";
+				};
+
+				csi2_port4: port@4 {
+					reg = <4>;
+					status = "disabled";
+				};
+			};
+		};
+	};
+
+	dphy0: phy@4580000 {
+		compatible = "cdns,dphy-rx";
+		reg = <0x00 0x04580000 0x00 0x00001100>;
+		#phy-cells = <0>;
+		power-domains = <&k3_pds 212 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	dphy1: phy@4590000 {
+		compatible = "cdns,dphy-rx";
+		reg = <0x00 0x04590000 0x00 0x00001100>;
+		#phy-cells = <0>;
+		power-domains = <&k3_pds 213 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	dphy2: phy@45a0000 {
+		compatible = "cdns,dphy-rx";
+		reg = <0x00 0x045a0000 0x00 0x00001100>;
+		#phy-cells = <0>;
+		power-domains = <&k3_pds 214 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
 	main_sdhci0: mmc@4f80000 {
 		compatible = "ti,j721e-sdhci-8bit";
 		reg = <0x00 0x04f80000 0x00 0x1000>,
@@ -1224,7 +1406,6 @@ main_bcdma_csi: dma-controller@311a0000 {
 			ti,sci-dev-id = <281>;
 			ti,sci-rm-range-rchan = <0x21>;
 			ti,sci-rm-range-tchan = <0x22>;
-			status = "disabled";
 		};
 
 		cpts@310d0000 {
-- 
2.34.1


