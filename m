Return-Path: <linux-kernel+bounces-66463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3A8855D0D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B17328BFAF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0419914012;
	Thu, 15 Feb 2024 08:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wRPnb62B"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A521BDE0;
	Thu, 15 Feb 2024 08:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707987366; cv=none; b=uGTZW4CukfDAuJSbHLK+hvRiIog/k8Pyseovrd3oI3fq+MpPc9La5gbIiqcWUhj4Lc2b/KsRM9MXw7Qt3crLTQ8wme92iS834EvcfzUQD4X/B1XTwHBcZsfbfEqEWBagbZ31xDgcu6ac76qL74oZALBIDy860NlKwRwCv2dLEUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707987366; c=relaxed/simple;
	bh=wNv4a6Md8eOgqP+Ve8O8gkO4YdqeO12NW2BZ0s1DMMo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CzlCN0WrIUNScJ6iMloDjAiV/yn3f7zRNYqJvDy+fQGdJJ2M5bxcTchRXvvg491O+tEiySmOx/CgmbXacLDM13x3UGZwwXvvokYeccrfABLO5QLmCZNlNvNqaB/ilJm+cEaka7QXhqOwYV34N7Wc+VapODA2VIDzrijx3H05POQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wRPnb62B; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41F8trCe076934;
	Thu, 15 Feb 2024 02:55:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707987353;
	bh=qS7ma5QtwgNFRPziAmeuyTE5bj091f6X4+AXhzup8IM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=wRPnb62Bj+cgrYp+FMtjlc0/MvwHru+8BwgdKn/NAKfv04EOrc41bAqwkYlxR59mp
	 zvd3NJya3KmyNqD1I0RxcRRqagKnte2hJxuHec/K8jGWsZ7xXcwOZoWYmhWysHdbRw
	 UyfiPWa8Razxv5R5iwa7oyDPpoVqsKTbsDjxNVMY=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41F8tr6K060027
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 15 Feb 2024 02:55:53 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Feb 2024 02:55:52 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Feb 2024 02:55:52 -0600
Received: from uda0490681.. ([10.24.69.142])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41F8tJ7q008333;
	Thu, 15 Feb 2024 02:55:48 -0600
From: Vaishnav Achath <vaishnav.a@ti.com>
To: <vigneshr@ti.com>, <nm@ti.com>, <conor+dt@kernel.org>, <kristo@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>
CC: <j-luthra@ti.com>, <devicetree@vger.kernel.org>, <j-choudhary@ti.com>,
        <kernel@pengutronix.de>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>, <vaishnav.a@ti.com>,
        <afd@ti.com>
Subject: [PATCH v4 7/9] arm64: dts: ti: k3-j721s2-main: Add CSI2RX capture nodes
Date: Thu, 15 Feb 2024 14:25:16 +0530
Message-ID: <20240215085518.552692-8-vaishnav.a@ti.com>
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

J721S2 has two CSI2RX capture subsystem featuring Cadence CSI2RX,
DPHY and TI's pixel grabbing wrapper. Add nodes for the same and
keep them disabled by default. J721S2 uses a dedicated BCDMA instance
for CSI-RX traffic, so enable that as well.

J721S2 TRM (Section 12.7 Camera Subsystem):
	https://www.ti.com/lit/zip/spruj28

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
Reviewed-by: Jai Luthra <j-luthra@ti.com>
---

V2->V3: Fix order of properties as per dts coding style.
V1->V2: Update commit message with TRM.

 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 123 ++++++++++++++++++++-
 1 file changed, 122 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
index dcaa4da0d678..9063aa609993 100644
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
+		reg = <0x00 0x04500000 0x00 0x1000>;
+		ranges;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		dmas = <&main_bcdma_csi 0 0x4940 0>;
+		dma-names = "rx0";
+		power-domains = <&k3_pds 38 TI_SCI_PD_EXCLUSIVE>;
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
+		reg = <0x00 0x04510000 0x00 0x1000>;
+		ranges;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		dmas = <&main_bcdma_csi 0 0x4960 0>;
+		dma-names = "rx0";
+		power-domains = <&k3_pds 39 TI_SCI_PD_EXCLUSIVE>;
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


