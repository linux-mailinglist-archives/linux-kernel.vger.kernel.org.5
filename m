Return-Path: <linux-kernel+bounces-58062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 787A384E0BE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E10F21F24314
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C746763E9;
	Thu,  8 Feb 2024 12:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MsDzYFh0"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE9D78B7B;
	Thu,  8 Feb 2024 12:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707395604; cv=none; b=mBPJB7Te3OEpqMGN+EOJP3yTYYSWBN+YA7ZRrPzKI8yfGzOlUXMEGh1qwV62QoouojGQN1gWDElD+0sN2kDgAUpI+Xzlpl8aiQq9qcah6DK7my+hvNsWp0r6OFvvEzX/Wnk54h7PM9epnxEoVtrqaRmOYFlkueO6LLxy2zj1LSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707395604; c=relaxed/simple;
	bh=if2Yf35BO9OeU4MFzJIT5yTHrLgwmipiuRUhoYR6/tk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fL+8svd/GEptJtfrwrFLiT5iaRRyAjPiAnHU7bf7gt3bniGSQH0oCVWaulYm6Q/KJPuiM0rurGs44N4afQTFFQfkXnrk85DVi214lKZe2N54829No9cQSaCaLM3BoJFf6kj086BQY7PkpX29qNzgszXaPE2sTr87kYNCIVaqsQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=MsDzYFh0; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 418CXCeZ070511;
	Thu, 8 Feb 2024 06:33:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707395592;
	bh=azd/OUCMOHOC7Oo4OnCOZv54A9ymh0I80CZsSSIelDU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=MsDzYFh090TeU2G5KK7TLWT8odrO6qmgXi0TjhPX4HCTzqZEc6iUNeC+tIxDNtiyG
	 ksOd2hMXUSHvNY3y7my7UuP99GI/eXvtSfbjN9gNu98Bx5P9gLeOnxc2v0Y8WG8TYR
	 F1LotIQELx7GRuwHJUjaip9QXenTdHjkLM5qBRgQ=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 418CXChS026695
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Feb 2024 06:33:12 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Feb 2024 06:33:12 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Feb 2024 06:33:12 -0600
Received: from uda0490681.. ([10.24.69.142])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 418CWY1P074789;
	Thu, 8 Feb 2024 06:33:08 -0600
From: Vaishnav Achath <vaishnav.a@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <kernel@pengutronix.de>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vaishnav.a@ti.com>, <u-kumar1@ti.com>, <j-choudhary@ti.com>,
        <j-luthra@ti.com>, <afd@ti.com>
Subject: [PATCH v3 8/9] arm64: dts: ti: k3-j784s4-main: Add CSI2RX capture nodes
Date: Thu, 8 Feb 2024 18:02:32 +0530
Message-ID: <20240208123233.391115-9-vaishnav.a@ti.com>
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

J784S4 has three CSI2RX capture subsystem featuring Cadence CSI2RX,
DPHY and TI's pixel grabbing wrapper. Add nodes for the same and
keep them disabled by default. J784S4 uses a dedicated BCDMA instance
for CSI-RX traffic, so enable that as well.

J784S4 TRM (Section 12.7 Camera Subsystem):
	https://www.ti.com/lit/zip/spruj52

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
---

V2->V3: Fix order of properties as per dts coding style.
V1->V2: Update commit message with TRM.

 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 183 ++++++++++++++++++++-
 1 file changed, 182 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
index 3cb964982792..42e4ca1d0b65 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
@@ -662,6 +662,188 @@ main_i2c6: i2c@2060000 {
 		status = "disabled";
 	};
 
+	ti_csi2rx0: ticsi2rx@4500000 {
+		compatible = "ti,j721e-csi2rx-shim";
+		reg = <0x00 0x04500000 0x00 0x00001000>;
+		ranges;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		dmas = <&main_bcdma_csi 0 0x4940 0>;
+		dma-names = "rx0";
+		power-domains = <&k3_pds 72 TI_SCI_PD_EXCLUSIVE>;
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
+		reg = <0x00 0x04510000 0x00 0x1000>;
+		ranges;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		dmas = <&main_bcdma_csi 0 0x4960 0>;
+		dma-names = "rx0";
+		power-domains = <&k3_pds 73 TI_SCI_PD_EXCLUSIVE>;
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
+		reg = <0x00 0x04520000 0x00 0x00001000>;
+		ranges;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		dmas = <&main_bcdma_csi 0 0x4980 0>;
+		dma-names = "rx0";
+		power-domains = <&k3_pds 74 TI_SCI_PD_EXCLUSIVE>;
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


