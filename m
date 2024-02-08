Return-Path: <linux-kernel+bounces-58061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D325484E0BB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49BF01F241FD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F3A763E1;
	Thu,  8 Feb 2024 12:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KfkoLSPz"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24DE149E05;
	Thu,  8 Feb 2024 12:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707395599; cv=none; b=B2mRqSgvSBwAZm8238u4P8/gIih0TGii5SUTHq6c8GwgjWbzrEui/F0W00sNDXyX0fEPuyz+5H99sIMhlDdid/PNXzK622NktwIGoYqaCFUfOPw9PYnvL+lGx+XHQeDepRPXjOtWh8fUpgcogx/cq6r3LvbHODdRKKUYeSznokI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707395599; c=relaxed/simple;
	bh=mAWoh6BF9B+rIm5cKFNoqxI35ZASjqn5q1cyy+zfZ1w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lwR5revFD81vJIECDRzAdxqDA0i1GYpw+yy2ZCk3YvwsQWHq4mfaDQCRaB0uh0QtA2cbFboEdexPzaay3CIXPs6p6j5zIc5uSxx0YaRGEHf4jymScXwG8rTz3xYrWNSuhSp2MbmqF8+gEjwRodpu3CJZXY3+rZd+LcPOmekQKJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KfkoLSPz; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 418CX8Tn070492;
	Thu, 8 Feb 2024 06:33:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707395588;
	bh=SezGYvVqaTZi8rOGSq6FDX4XCW47BmkK/lXjcWRkYb0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=KfkoLSPzBRRv28Hh9fyMT116O7NoEVTxWYDmNjD+4dT0LwDpeeSlDB7HQ9/mgx6Hy
	 nL6wPctmc2B0himtR/RtYIRFi5IvV700U5cWlOYsgHQJ2lQaBOrTZXYc1FDkESxcAV
	 Ghq3W9vU1q4tlNKFWBKW+IqsJBXkFffQpqBtWkCU=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 418CX8IP006403
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Feb 2024 06:33:08 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Feb 2024 06:33:08 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Feb 2024 06:33:08 -0600
Received: from uda0490681.. ([10.24.69.142])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 418CWY1O074789;
	Thu, 8 Feb 2024 06:33:04 -0600
From: Vaishnav Achath <vaishnav.a@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <kernel@pengutronix.de>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vaishnav.a@ti.com>, <u-kumar1@ti.com>, <j-choudhary@ti.com>,
        <j-luthra@ti.com>, <afd@ti.com>
Subject: [PATCH v3 7/9] arm64: dts: ti: k3-j721s2-main: Add CSI2RX capture nodes
Date: Thu, 8 Feb 2024 18:02:31 +0530
Message-ID: <20240208123233.391115-8-vaishnav.a@ti.com>
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

J721S2 has two CSI2RX capture subsystem featuring Cadence CSI2RX,
DPHY and TI's pixel grabbing wrapper. Add nodes for the same and
keep them disabled by default. J721S2 uses a dedicated BCDMA instance
for CSI-RX traffic, so enable that as well.

J721S2 TRM (Section 12.7 Camera Subsystem):
	https://www.ti.com/lit/zip/spruj28

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
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


