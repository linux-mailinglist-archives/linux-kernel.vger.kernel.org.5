Return-Path: <linux-kernel+bounces-72400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D26685B2D1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6085B1C22166
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916B159155;
	Tue, 20 Feb 2024 06:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YGuZLU47"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F0758AAA;
	Tue, 20 Feb 2024 06:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708409908; cv=none; b=SJKDrpt+ozUKP5TWdMWJgxcZlFti/lerrEVuBdC/k3LjpnAhFndPrTjBs66c8GOw413RTf1TEfMCv1dbAJXsK591AsqKYXZGXNM5smHyOFF4L1ZT2gimnv9y0KyoYbgxipw9z5gZ4zekgN2tp6r40f3HSFqcmLhnTGISaXSesVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708409908; c=relaxed/simple;
	bh=1otlUFNCIJX/oyo61dusJEUzo2/iZlp/BV1ClIrSGtU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=LvxVwQIAfIPI/X4PLeZSfi01LHiUs/baDoWIaDIAuxYNVYT8kZZ+PbrNCQnhRdGkPKKwFGuoOboLf8XY+y4nO28bqZFvhPcvztgU0GKX8flkxSVpfuEsIbPkjSDXsmvmCvXYJ644gYSSEsXf2FfSm1neMkIR98VYcDE7qdYaSHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YGuZLU47; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41K6IGpB128547;
	Tue, 20 Feb 2024 00:18:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708409896;
	bh=zFnxQI7K8zbZ4WLsQct1k4LhVjlP+SEye5vpCjICWCo=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=YGuZLU474p128o7GNQ7t6JhU7X3bPkJC8mJbQIsjTJZpiIFjxFTJPKSv96eLhzprZ
	 94WFB09xZkAwKtSxb7R6gumNtW9anOs1lde+5jbeaefqrjO+SxCU7R/wou5EYg/loU
	 tSv3HzBcgoADlMTpdTKfb/rcFXC4Et9tQUykuHxY=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41K6IGbY017855
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 20 Feb 2024 00:18:16 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 20
 Feb 2024 00:18:16 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 20 Feb 2024 00:18:15 -0600
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.217])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41K6IFUc120947;
	Tue, 20 Feb 2024 00:18:15 -0600
From: Jai Luthra <j-luthra@ti.com>
Date: Tue, 20 Feb 2024 11:48:04 +0530
Subject: [PATCH v2 3/4] arm64: dts: ti: k3-am62p: Add nodes for CSI-RX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240220-am62p_csi-v2-3-3e71d9945571@ti.com>
References: <20240220-am62p_csi-v2-0-3e71d9945571@ti.com>
In-Reply-To: <20240220-am62p_csi-v2-0-3e71d9945571@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Andrew Davis <afd@ti.com>,
        Bryan Brattlof <bb@ti.com>, Dhruva Gole <d-gole@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Vaishnav Achath <vaishnav.a@ti.com>,
        Devarsh
 Thakkar <devarsht@ti.com>, Aradhya Bhatia <a-bhatia1@ti.com>,
        Jai Luthra
	<j-luthra@ti.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2382; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=1otlUFNCIJX/oyo61dusJEUzo2/iZlp/BV1ClIrSGtU=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBl1EQgWM7k6jHq/OCXh2YEyP0xfe+tWoZGqoU1O
 qdRn3hZvCGJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZdREIAAKCRBD3pH5JJpx
 RTNPEAC4jt7KaRvu1Eco0kd+95uazDnj2iuaa1ywvPIaAaAsbfoejFtIqQwjA25xrUz2dv1NMZ7
 oC3M+jZlqovOulLAPeYcSfkn1knhgPVjL+OVmMnzmyr1gGNklUpLbz34dzSIt/pNVclL9kV7sYS
 d5xblbxV7ZbySZmd7VCsu0DRw5JJim6wm8EhFxc4f+vcKt3OAMFHN68aKgDOEjB+yTJkvafn2Eb
 ouVPLJyzXPUb2Rtf6GxxoQMcJQEOZri3uIs+N7Un+JJdMY2NMGvHLg1gzDEJVTgEUx9zLrIKZji
 mYipcaKbsxI1ThqMprlzOGA5gA4YjPt6UT5zL7cyBLBD+rc6Pk8Skfl3aR6yVpfngiy7qr/B9ne
 dgQDjNTELndMgbDHgoEFb1/22q4aVoxPlIWlfi4uEYb4Mz8+anE0QaT2yROVE62VoVoPQg5bPfG
 AGK28FOpLbLBGD7tqBSopnCkO+xgnwhxeADDWHlpe6UgofBbPavgS4wuRuKRrrY114wGtMe4JkO
 l1h5A/rGwz2WxZJ8hwxBS8fg2AoqSdg3QQgOsCmC1Pxxtc5sd/ZMzVFuiTUeWVmMfu6MRoxozbE
 lzjCv80IjSleZwhpPlL7NfLbTbbF1h59mCX8g16rjMHnRdn3w+CsWMVziwV3i9VASahDlgsVQ34
 rtjUpC3rlBpydqg==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

AM62P supports image capture via the MIPI CSI-2 protocol, it uses three
IPs to achieve this: Cadence DPHY, Cadence CSI-RX, and TI's pixelgrabber
wrapper on top. Add nodes for these IPs in the devicetree, and keep them
disabled here, so these may be enabled by the sensor overlays.

Reviewed-by: Vaishnav Achath <vaishnav.a@ti.com>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi | 61 +++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
index fb328774879c..3f271e7710d8 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
@@ -966,4 +966,65 @@ mcasp2: audio-controller@2b20000 {
 		power-domains = <&k3_pds 192 TI_SCI_PD_EXCLUSIVE>;
 		status = "disabled";
 	};
+
+	ti_csi2rx0: ticsi2rx@30102000 {
+		compatible = "ti,j721e-csi2rx-shim";
+		reg = <0x00 0x30102000 0x00 0x1000>;
+		ranges;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		dmas = <&main_bcdma_csi 0 0x5000 0>;
+		dma-names = "rx0";
+		power-domains = <&k3_pds 182 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+
+		cdns_csi2rx0: csi-bridge@30101000 {
+			compatible = "ti,j721e-csi2rx", "cdns,csi2rx";
+			reg = <0x00 0x30101000 0x00 0x1000>;
+			clocks = <&k3_clks 182 0>, <&k3_clks 182 3>, <&k3_clks 182 0>,
+				<&k3_clks 182 0>, <&k3_clks 182 4>, <&k3_clks 182 4>;
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
+	dphy0: phy@30110000 {
+		compatible = "cdns,dphy-rx";
+		reg = <0x00 0x30110000 0x00 0x1100>;
+		#phy-cells = <0>;
+		power-domains = <&k3_pds 185 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
 };

-- 
2.43.0


