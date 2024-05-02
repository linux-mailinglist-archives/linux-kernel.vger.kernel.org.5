Return-Path: <linux-kernel+bounces-165986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7C48B9446
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 07:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04679283506
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 05:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA4922087;
	Thu,  2 May 2024 05:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DIYXVYCc"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C49421105;
	Thu,  2 May 2024 05:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714628196; cv=none; b=Y5aPZ6ObndTjIi6CNXlEj1jilIis3YheYiQCW+qQUTKQGYjTwi8Yv5wBiKJAlqPuG69uYiifdM3jqlW21XBNxY3pRpZUWdGDGz2M8YDni2lg2ibHES443cONlLjdjptvECNcrit4xCtNH+2YFP0JXG4YXHtBtiqQWixbAIYqD9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714628196; c=relaxed/simple;
	bh=b6p3h9R08l6RUQOVwBgkHposxfl/iosCOGYdjVW0UrM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kZT/2iaJHEExs066sn4I0qhG5KLlUOeclqymbaWo57Sp1JKFBO8/kkAONolLAf/9GwFjmTPpk9wNA6dL+s4IrkI/GFFOg74vIbUEE5rAFGyIfEON6OA38+/bnlsz8VsT+jki/6xkT82JBo+4N8ag3yq7gr3PN6JciuA8m4ABpqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DIYXVYCc; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4425aNFG036008;
	Thu, 2 May 2024 00:36:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714628184;
	bh=t8ipY56w1GPaT6ok6zMCiO/D5h5VuiWyd327+TpJjb8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=DIYXVYCckE4F2GPBN0h/AQfHi/PE5RjtIGU9DoOcsmxjXLabE2Z9ZU8OaF7xBS+t1
	 A8bP3oQJl+XDEs/rjRRPcKO/MFrEGynTfa0gXtl5nFlBY2YHyOs0L9Jrk9LDIjWJJb
	 /0pgpc7qFpdYPBggCO3v+MNQSuJ89qXt3Yv5n7Vg=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4425aNb6061283
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 2 May 2024 00:36:23 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 2
 May 2024 00:36:23 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 2 May 2024 00:36:23 -0500
Received: from uda0500640.dal.design.ti.com (uda0500640.dhcp.ti.com [172.24.227.88])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4425aGCi027413;
	Thu, 2 May 2024 00:36:20 -0500
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <srk@ti.com>, <rogerq@kernel.org>,
        <r-gunasekaran@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] arm64: dts: ti: k3-j784s4-main: Add support for USB
Date: Thu, 2 May 2024 11:06:14 +0530
Message-ID: <20240502053615.29514-2-r-gunasekaran@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240502053615.29514-1-r-gunasekaran@ti.com>
References: <20240502053615.29514-1-r-gunasekaran@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Matt Ranostay <mranostay@ti.com>

Add support for the USB 3.0 controller

Signed-off-by: Matt Ranostay <mranostay@ti.com>
Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
index 6a4554c6c9c1..51cdd0b56a6f 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
@@ -75,6 +75,13 @@
 				      <J784S4_SERDES4_LANE2_EDP_LANE2>,
 				      <J784S4_SERDES4_LANE3_EDP_LANE3>;
 		};
+
+		usb_serdes_mux: mux-controller@4000 {
+			compatible = "reg-mux";
+			reg = <0x4000 0x4>;
+			#mux-control-cells = <1>;
+			mux-reg-masks = <0x0 0x8000000>; /* USB0 to SERDES0 lane 3 mux */
+		};
 	};
 
 	gic500: interrupt-controller@1800000 {
@@ -568,6 +575,38 @@
 		status = "disabled";
 	};
 
+	usbss0: cdns-usb@4104000 {
+		bootph-all;
+		compatible = "ti,j721e-usb";
+		reg = <0x00 0x4104000 0x00 0x100>;
+		dma-coherent;
+		power-domains = <&k3_pds 398 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 398 21>, <&k3_clks 398 2>;
+		clock-names = "ref", "lpm";
+		assigned-clocks = <&k3_clks 398 21>;    /* USB2_REFCLK */
+		assigned-clock-parents = <&k3_clks 398 22>; /* HFOSC0 */
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		status = "disabled"; /* Needs lane config */
+
+		usb0: usb@6000000 {
+			bootph-all;
+			compatible = "cdns,usb3";
+			reg = <0x00 0x6000000 0x00 0x10000>,
+			      <0x00 0x6010000 0x00 0x10000>,
+			      <0x00 0x6020000 0x00 0x10000>;
+			reg-names = "otg", "xhci", "dev";
+			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,  /* irq.0 */
+				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>, /* irq.6 */
+				     <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>; /* otgirq.0 */
+			interrupt-names = "host",
+					  "peripheral",
+					  "otg";
+		};
+	};
+
 	main_i2c0: i2c@2000000 {
 		compatible = "ti,j721e-i2c", "ti,omap4-i2c";
 		reg = <0x00 0x02000000 0x00 0x100>;
-- 
2.17.1


