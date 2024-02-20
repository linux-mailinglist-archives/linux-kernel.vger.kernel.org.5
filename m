Return-Path: <linux-kernel+bounces-72852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAA285B982
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5494284DC7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10B1657AA;
	Tue, 20 Feb 2024 10:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pWxHRG1w"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFC436AF9;
	Tue, 20 Feb 2024 10:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708426219; cv=none; b=A+NVphEVpjYRti9z6sRKXB36P3hIa4wlKq2jOin2EUr0W+8nuEINo/H9IrtIy5UCZv50TZ44jvwTW5pZ8AWFpT1JgTbsfL6M/IroleH7cG9KDy6U6z18TfqKJSpUi0G6shlKgkBE817ExPMcqRxO0nlnCSIa1i2LQDehDmkAE+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708426219; c=relaxed/simple;
	bh=PVebVozWoa/PAo9loZJChZrJxtFO7WgfreChaECuNbw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NfQHJpNIS31aFOLcoDGP4IVPfBSvC1HiClGDGOpq8AQ7MTfde4whJ2gtkwZZ0siPy+DYmJoI73xWTX8tWujoS/oYAJZQ172gSTXbiqDd3T5cLR42DVYQl+5UjMRGwdYxMl9rtQrGLxwFKoup9YpxqDodjhyvOrH7FqpO0ujdR4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=pWxHRG1w; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41KAoBuV034941;
	Tue, 20 Feb 2024 04:50:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708426211;
	bh=QXZ73JTTX/zdchsdeR2TnxIpFTrtTuU8Uz9+cq87qCM=;
	h=From:To:CC:Subject:Date;
	b=pWxHRG1wyswFo4QItfHfdlZrR34o5fCdh3Koum+NrKy9AQbbNGaFBh8NKUtStKmKs
	 z32qugNScMDpoFoosKRcy3ctBLwXNBdFzHTqkOhUpTYRq3JimxMcOTIlw1t3yqRd22
	 A5cvu7JS2mIGcY6UhZGfHdKc06q0wITK+AmyQDPg=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41KAoBrC009179
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 20 Feb 2024 04:50:11 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 20
 Feb 2024 04:50:11 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 20 Feb 2024 04:50:11 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41KAo7Rd101122;
	Tue, 20 Feb 2024 04:50:08 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-j721e-evm-pcie0-ep: Extend overlay for PCIE1 in EP Mode
Date: Tue, 20 Feb 2024 16:20:06 +0530
Message-ID: <20240220105006.1056824-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Update the existing overlay which configures PCIE0 instance of PCIe on
J721E-EVM in Endpoint mode of operation, in order to configure PCIE1
instance of PCIe as well in Endpoint mode of operation. Hence, change the
name of the overlay to reflect its updated functionality.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

This patch is based on linux-next tagged next-20240220.

Regards,
Siddharth.

 arch/arm64/boot/dts/ti/Makefile               |  8 ++---
 ....dtso => k3-j721e-evm-pcie0-pcie1-ep.dtso} | 30 +++++++++++++++++--
 2 files changed, 32 insertions(+), 6 deletions(-)
 rename arch/arm64/boot/dts/ti/{k3-j721e-evm-pcie0-ep.dtso => k3-j721e-evm-pcie0-pcie1-ep.dtso} (60%)

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index d601c52ab181..c7c9508e3980 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -75,7 +75,7 @@ k3-j721e-evm-dtbs := k3-j721e-common-proc-board.dtb k3-j721e-evm-quad-port-eth-e
 dtb-$(CONFIG_ARCH_K3) += k3-j721e-beagleboneai64.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-j721e-evm.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-j721e-evm-gesi-exp-board.dtbo
-dtb-$(CONFIG_ARCH_K3) += k3-j721e-evm-pcie0-ep.dtbo
+dtb-$(CONFIG_ARCH_K3) += k3-j721e-evm-pcie0-pcie1-ep.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-j721e-sk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-j721e-sk-csi2-dual-imx219.dtbo
 
@@ -126,8 +126,8 @@ k3-am68-sk-base-board-csi2-dual-imx219-dtbs := k3-am68-sk-base-board.dtb \
 	k3-j721e-sk-csi2-dual-imx219.dtbo
 k3-am69-sk-csi2-dual-imx219-dtbs := k3-am69-sk.dtb \
 	k3-j721e-sk-csi2-dual-imx219.dtbo
-k3-j721e-evm-pcie0-ep-dtbs := k3-j721e-common-proc-board.dtb \
-	k3-j721e-evm-pcie0-ep.dtbo
+k3-j721e-evm-pcie0-pcie1-ep-dtbs := k3-j721e-common-proc-board.dtb \
+	k3-j721e-evm-pcie0-pcie1-ep.dtbo
 k3-j721e-sk-csi2-dual-imx219-dtbs := k3-j721e-sk.dtb \
 	k3-j721e-sk-csi2-dual-imx219.dtbo
 k3-j721s2-evm-pcie1-ep-dtbs := k3-j721s2-common-proc-board.dtb \
@@ -147,7 +147,7 @@ dtb- += k3-am625-beagleplay-csi2-ov5640.dtb \
 	k3-am642-tqma64xxl-mbax4xxl-wlan.dtb \
 	k3-am68-sk-base-board-csi2-dual-imx219-dtbs \
 	k3-am69-sk-csi2-dual-imx219-dtbs \
-	k3-j721e-evm-pcie0-ep.dtb \
+	k3-j721e-evm-pcie0-pcie1-ep.dtb \
 	k3-j721e-sk-csi2-dual-imx219-dtbs \
 	k3-j721s2-evm-pcie1-ep.dtb
 
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-evm-pcie0-ep.dtso b/arch/arm64/boot/dts/ti/k3-j721e-evm-pcie0-pcie1-ep.dtso
similarity index 60%
rename from arch/arm64/boot/dts/ti/k3-j721e-evm-pcie0-ep.dtso
rename to arch/arm64/boot/dts/ti/k3-j721e-evm-pcie0-pcie1-ep.dtso
index 4062709d6579..5eaf304e3102 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-evm-pcie0-ep.dtso
+++ b/arch/arm64/boot/dts/ti/k3-j721e-evm-pcie0-pcie1-ep.dtso
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only OR MIT
 /**
- * DT Overlay for enabling PCIE0 instance in Endpoint Configuration with the
- * J7 common processor board.
+ * DT Overlay for enabling PCIE0 and PCIE1 instances in Endpoint Configuration
+ * with the J7 common processor board.
  *
  * J7 Common Processor Board Product Link: https://www.ti.com/tool/J721EXCPXEVM
  *
@@ -24,6 +24,10 @@ &pcie0_rc {
 	status = "disabled";
 };
 
+&pcie1_rc {
+	status = "disabled";
+};
+
 &cbass_main {
 	#address-cells = <2>;
 	#size-cells = <2>;
@@ -50,4 +54,26 @@ pcie0_ep: pcie-ep@2900000 {
 		phys = <&serdes0_pcie_link>;
 		phy-names = "pcie-phy";
 	};
+
+	pcie1_ep: pcie-ep@2910000 {
+		compatible = "ti,j721e-pcie-ep";
+		reg = <0x00 0x02910000 0x00 0x1000>,
+		      <0x00 0x02917000 0x00 0x400>,
+		      <0x00 0x0d800000 0x00 0x00800000>,
+		      <0x00 0x18000000 0x00 0x08000000>;
+		reg-names = "intd_cfg", "user_cfg", "reg", "mem";
+		interrupt-names = "link_state";
+		interrupts = <GIC_SPI 330 IRQ_TYPE_EDGE_RISING>;
+		ti,syscon-pcie-ctrl = <&scm_conf 0x4074>;
+		max-link-speed = <3>;
+		num-lanes = <2>;
+		power-domains = <&k3_pds 240 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 240 1>;
+		clock-names = "fck";
+		max-functions = /bits/ 8 <6>;
+		max-virtual-functions = /bits/ 8 <4 4 4 4 0 0>;
+		dma-coherent;
+		phys = <&serdes1_pcie_link>;
+		phy-names = "pcie-phy";
+	};
 };
-- 
2.34.1


