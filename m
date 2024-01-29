Return-Path: <linux-kernel+bounces-42802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA638406ED
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21AD8290ECE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA1D664A4;
	Mon, 29 Jan 2024 13:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Azt8SNRs"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C82A664AA;
	Mon, 29 Jan 2024 13:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706534904; cv=none; b=edx+81j9sJXTC5SKQ1el4OA4Lo+4YhH95wE7CKAbbAX9r0u9yLjbxyFpTT1EzhZEPG9OMyZuTSfUeCydzd93ux8yc8znAxgaOqMHe00I+WgMpPn8fFNFkV6IVlG+IaNfV9dd7LLIJxle09rMZ4z2NOMu/ViAiiF4V0Cvx5uokr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706534904; c=relaxed/simple;
	bh=jPgDNf2MzDNn1dyJzg+Fo86r1AlG8BSHuvRBBtCytm4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QVC2QagHYXrb8PkPaJ2szwfDKNxOdHFo1rNfW4e7+eaJV6w6x7Vs2JuZXHKyGuKyI08WRWx8lHVUD2tiJl9OKlWr6S/l756RPHFwaxXxLfdRi2z8rVt2LAY/7ppR3ioXDVtIGQzWu4R48KXxYMh/OhJbSx+wEjm0e7BEtAutXDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Azt8SNRs; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40TDSEI3128904;
	Mon, 29 Jan 2024 07:28:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706534894;
	bh=CtK5DDKAwxBSMayVb0zF3W5qFmxZRGr2cf5lurTOD94=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Azt8SNRsG4zakWiCZSFaC9841K92jbDBcGv8OWFwVaGispFJxf5gVepMJxW6Su2RB
	 4GHWscMnimRVLSaOCFSpa+yPcXZbsk217RNpA+a9WBFCRlFkgWcbIsKAlvFEqcGvae
	 ajSJmJ00AVFJs4BCjZKQIqa+2o4Ewf2QwPegTfTE=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40TDSEqQ027218
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Jan 2024 07:28:14 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Jan 2024 07:28:14 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Jan 2024 07:28:14 -0600
Received: from uda0490681.dhcp.ti.com ([10.24.69.142])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40TDRg9H036720;
	Mon, 29 Jan 2024 07:28:10 -0600
From: Vaishnav Achath <vaishnav.a@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <kernel@pengutronix.de>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vaishnav.a@ti.com>, <u-kumar1@ti.com>, <j-choudhary@ti.com>,
        <j-luthra@ti.com>
Subject: [PATCH 7/9] arm64: dts: ti: k3-j721s2-main: Add CSI2RX capture nodes
Date: Mon, 29 Jan 2024 18:57:40 +0530
Message-ID: <20240129132742.1189783-8-vaishnav.a@ti.com>
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

J721S2 has two CSI2RX capture subsystem featuring Cadence CSI2RX,
DPHY and TI's pixel grabbing wrapper. Add nodes for the same and
keep them disabled by default. J721S2 uses a dedicated BCDMA instance
for CSI-RX traffic, so enable that as well.

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
---

Depends on https://lore.kernel.org/all/20240125111449.855876-1-vaishnav.a@ti.com/

 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 123 ++++++++++++++++++++-
 1 file changed, 122 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
index ea7f2b2ab165..f9f9ffffb0a7 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
@@ -1122,7 +1122,6 @@ main_bcdma_csi: dma-controller@311a0000 {
 			ti,sci-dev-id = <225>;
 			ti,sci-rm-range-rchan = <0x21>;
 			ti,sci-rm-range-tchan = <0x22>;
-			status = "disabled";
 		};
 
 		cpts@310d0000 {
@@ -1233,6 +1232,128 @@ usb0: usb@6000000 {
 		};
 	};
 
+	ti_csi2rx0: ticsi2rx@4500000 {
+		compatible = "ti,j721e-csi2rx-shim";
+		dmas = <&main_bcdma_csi 0 0x4940 0>;
+		dma-names = "rx0";
+		reg = <0x00 0x04500000 0x00 0x1000>;
+		power-domains = <&k3_pds 38 TI_SCI_PD_EXCLUSIVE>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		status = "disabled";
+
+		cdns_csi2rx0: csi-bridge@4504000 {
+			compatible = "ti,j721e-csi2rx", "cdns,csi2rx";
+			reg = <0x00 0x04504000 0x00 0x1000>;
+			clocks = <&k3_clks 38 3>, <&k3_clks 38 1>, <&k3_clks 38 3>,
+				<&k3_clks 38 3>, <&k3_clks 38 4>, <&k3_clks 38 4>;
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
+		power-domains = <&k3_pds 39 TI_SCI_PD_EXCLUSIVE>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		status = "disabled";
+
+		cdns_csi2rx1: csi-bridge@4514000 {
+			compatible = "ti,j721e-csi2rx", "cdns,csi2rx";
+			reg = <0x00 0x04514000 0x00 0x1000>;
+			clocks = <&k3_clks 39 3>, <&k3_clks 39 1>, <&k3_clks 39 3>,
+				<&k3_clks 39 3>, <&k3_clks 39 4>, <&k3_clks 39 4>;
+			clock-names = "sys_clk", "p_clk", "pixel_if0_clk",
+				"pixel_if1_clk", "pixel_if2_clk", "pixel_if3_clk";
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
+		reg = <0x00 0x04580000 0x00 0x1100>;
+		#phy-cells = <0>;
+		power-domains = <&k3_pds 152 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	dphy1: phy@4590000 {
+		compatible = "cdns,dphy-rx";
+		reg = <0x00 0x04590000 0x00 0x1100>;
+		#phy-cells = <0>;
+		power-domains = <&k3_pds 153 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
 	serdes_wiz0: wiz@5060000 {
 		compatible = "ti,j721s2-wiz-10g";
 		#address-cells = <1>;
-- 
2.34.1


