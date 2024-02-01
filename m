Return-Path: <linux-kernel+bounces-48194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FBF845877
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4115D28DD9A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE858665F;
	Thu,  1 Feb 2024 13:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xGbukezs"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004145B67F;
	Thu,  1 Feb 2024 13:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706792842; cv=none; b=SDV4wduDRq1b+y8CXq9tn15HluGUgKpEbWS3qm+GOBeMMyPLIlt0W43wJg6vEC6L6xxqXg+67Dl2MfU8CQhqzX4Z0yVchSkUfWDuv4TFA2/EkXvcX3ofkQyx71Cr+WqLEcXDCxDkt/4KnpPIICqHCUDqHgvAff2fGt9s/KvvC5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706792842; c=relaxed/simple;
	bh=5ghTK3wJlbTR8AXSwps2iXRCuqJEWnnANC2exXFGf0I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=LwCYXYgUSek7KRhpgDENvkfUJmTV/mxgPkmIygNPV8BcBg/Womnv/YANwGmVhZhki+7L9izW0h9dqDz88eTUDWG6kVHczMmJlfPjLVY+WUC02kqIrliUh2EiB5/8p89Zjb4uXhaiHyKEp3Nz7NklAVPb/NsK8p7Lej4ViKzQG3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=xGbukezs; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 411D7CRF104580;
	Thu, 1 Feb 2024 07:07:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706792832;
	bh=vbpfH3xzkJyVZB9YSWkN/xzm8Bq9Yd74LY2NszD7sNU=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=xGbukezs6P0MRWmru8PQGqhrAWEqG/Mgs4mucJgDSWO/VTIBPgYmJ30ZhwBVp1kKH
	 xKepApviDJArEHcjUCx8l6STvjOe4N2QKdbBz/lErldm7A/sYvsSQFXgzsnZs6Cq1U
	 fl7x6PlWI/zt8kSQb+YD8YXQIqYUKs00/GITiMOA=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 411D7CVm031182
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 1 Feb 2024 07:07:12 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Feb 2024 07:07:12 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Feb 2024 07:07:12 -0600
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.217])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 411D7Bff083003;
	Thu, 1 Feb 2024 07:07:12 -0600
From: Jai Luthra <j-luthra@ti.com>
Date: Thu, 1 Feb 2024 18:37:02 +0530
Subject: [PATCH 3/4] arm64: dts: ti: k3-am62p: Add nodes for CSI-RX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240201-am62p_csi-v1-3-c83bb9eaeb49@ti.com>
References: <20240201-am62p_csi-v1-0-c83bb9eaeb49@ti.com>
In-Reply-To: <20240201-am62p_csi-v1-0-c83bb9eaeb49@ti.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2254; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=5ghTK3wJlbTR8AXSwps2iXRCuqJEWnnANC2exXFGf0I=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBlu5d48mmOGzRlUpK7Pm3DwOBiwK5TL2cQ3YTM2
 KoLLVrg/jyJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZbuXeAAKCRBD3pH5JJpx
 Rbx1D/0bnymt14c5io0bDOTDTr/4Dt78knbq3oA+vOMKclGclw3sn8rqFlVLAodPxJT0iycMnta
 6a/EXx3mMVSASyfoA1dwg4f/c+YAg3V2MK3emuxzTF5BuOxwXsgeuw12GSVOwLTrvo7w0SDssCc
 8lk6U4Ok2Fe4UOE45+LkzTVulLFteLhcjrWAAFuO9ULZA5c8C0rfdwsOldszA8dssSpmeQM/NaH
 lwI4XgLX/RVyh8Sjovlpfr7ehUP/Iz3cz2kR56AJTrYsm+zSs1msDyBfcUaax9QnGgvbtwn+OdG
 4PYD0L38yei96bHwOb3QhDnrdJtNq4AyI3mfceRrwkK07kDjM2W2HG/oob9l2tCTH2vfnvYPtiN
 yx0FgH1gxvGdcTyhMUvwnPE4+4b7kQ3uWH76wZVTyeYnPB0S7kt4FKf5Y+fydnfiWRMw8QQ6Cxd
 FiRhrgZcStkkhL92jUMRtc+qwcn4qBRYOfuhX6GAaEHWpB5b/ies93+3YirQwjv7ZXMHt4ZOC5L
 powTOzGf1stABjJdcwg34uQ2TrrISgdAua+9PPt7hjQO8wa61R+U7odUqQtlE8ivuAnx26I8WH6
 0tVEuSx3EqgkPfDnAUFJhN9gGfTjQcDe6oc0U0TkCUY+okbg2DJky5SaDUgRUCsmCH9Hbv5o6BV
 7A4aHga31+erlaQ==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

AM62P supports image capture via the MIPI CSI-2 protocol, it uses three
IPs to achieve this: Cadence DPHY, Cadence CSI-RX, and TI's pixelgrabber
wrapper on top. Enable all of these IPs in the devicetree.

Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi | 61 +++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
index 57ec4ef334e4..fdd835a04327 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
@@ -928,4 +928,65 @@ mcasp2: audio-controller@2b20000 {
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


