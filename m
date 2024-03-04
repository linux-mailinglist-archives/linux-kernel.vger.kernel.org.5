Return-Path: <linux-kernel+bounces-90341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A2186FDEB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 099591F219CF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1AA3219FF;
	Mon,  4 Mar 2024 09:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KMyzprIR"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E2022EE9;
	Mon,  4 Mar 2024 09:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709545610; cv=none; b=ZF7AK8KTbTYYRo8yGXpT3fXTagYIJ1qD4JAx0mK0p5TYanhFQF3q4IwRcN5ZJY6vLqOx48fk1L4/hey4DeS7D0i0Zr8vnREpohVSQwG+VR2f5ds0CbIgKnQDo80Hb8+9qW4s3W8jmt/Gp7tyUB3l+aq4c88QW4gDj7W7EaURQd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709545610; c=relaxed/simple;
	bh=GaG3ObaB0qeVflpuF54KvjopVGszqbKkABfFXosbmzY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=siqvhWpiNfzoDbq+R/majrwVAb3dcWzprM6sc5Q6PZ9MfTpNB4tAU4V5u84LJ3q0z92r3kBMSrea6uV+0G8+MjmMW1TBSOlrztsN93MtxCYsAJpDIAoXxjupJ/sXWZS73qvKvSAEzSiUwgX1XmkbMcto8PgK4To8OTbTwg4nsQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KMyzprIR; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4249k4O5077008;
	Mon, 4 Mar 2024 03:46:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1709545564;
	bh=mslq3oEcDFjb5NrDfM4TJEgZ5rKZf6BLkDDUk9nnFi4=;
	h=From:To:CC:Subject:Date;
	b=KMyzprIRZGUDe9TqJL469AQzwpeLmp5CN71/X+I85ZtD2c0mHPXGRV8zhLOI/m9M9
	 czVx/N9MTe0YionudDR1CTDRUmA/2J9vzZRS9nJasAgFkafZ8ovQx6bkKhh7mknINr
	 KcuzBQZGa3tSEUGmfR1f8Ho4jEXuyo09m/+nlvE0=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4249k4Ze092163
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 4 Mar 2024 03:46:04 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 4
 Mar 2024 03:46:04 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 4 Mar 2024 03:46:04 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4249k0RC128695;
	Mon, 4 Mar 2024 03:46:01 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <afd@ti.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-j7200-evm: Add overlay for PCIE1 Endpoint Mode
Date: Mon, 4 Mar 2024 15:15:59 +0530
Message-ID: <20240304094559.76406-1-s-vadapalli@ti.com>
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

Add overlay to enable the PCIE1 instance of PCIe on J7200-EVM in
Endpoint mode of operation.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

This patch is based on linux-next tagged next-20240304.

Regards,
Siddharth.

 arch/arm64/boot/dts/ti/Makefile               |  5 ++
 .../boot/dts/ti/k3-j7200-evm-pcie1-ep.dtso    | 53 +++++++++++++++++++
 2 files changed, 58 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j7200-evm-pcie1-ep.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 9a722c2473fb..0c04db76fd05 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -76,6 +76,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am654-pcie-usb3.dtbo
 # Boards with J7200 SoC
 k3-j7200-evm-dtbs := k3-j7200-common-proc-board.dtb k3-j7200-evm-quad-port-eth-exp.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-j7200-evm.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-j7200-evm-pcie1-ep.dtbo
 
 # Boards with J721e SoC
 k3-j721e-evm-dtbs := k3-j721e-common-proc-board.dtb k3-j721e-evm-quad-port-eth-exp.dtbo
@@ -139,6 +140,8 @@ k3-am68-sk-base-board-csi2-dual-imx219-dtbs := k3-am68-sk-base-board.dtb \
 	k3-j721e-sk-csi2-dual-imx219.dtbo
 k3-am69-sk-csi2-dual-imx219-dtbs := k3-am69-sk.dtb \
 	k3-j721e-sk-csi2-dual-imx219.dtbo
+k3-j7200-evm-pcie1-ep-dtbs := k3-j7200-common-proc-board.dtb \
+	k3-j7200-evm-pcie1-ep.dtbo
 k3-j721e-evm-pcie0-ep-dtbs := k3-j721e-common-proc-board.dtb \
 	k3-j721e-evm-pcie0-ep.dtbo
 k3-j721e-sk-csi2-dual-imx219-dtbs := k3-j721e-sk.dtb \
@@ -163,6 +166,7 @@ dtb- += k3-am625-beagleplay-csi2-ov5640.dtb \
 	k3-am642-tqma64xxl-mbax4xxl-wlan.dtb \
 	k3-am68-sk-base-board-csi2-dual-imx219-dtbs \
 	k3-am69-sk-csi2-dual-imx219-dtbs \
+	k3-j7200-evm-pcie1-ep.dtbo \
 	k3-j721e-evm-pcie0-ep.dtb \
 	k3-j721e-sk-csi2-dual-imx219-dtbs \
 	k3-j721s2-evm-pcie1-ep.dtb
@@ -178,6 +182,7 @@ DTC_FLAGS_k3-am642-tqma64xxl-mbax4xxl += -@
 DTC_FLAGS_k3-am6548-iot2050-advanced-m2 += -@
 DTC_FLAGS_k3-am68-sk-base-board += -@
 DTC_FLAGS_k3-am69-sk += -@
+DTC_FLAGS_k3-j7200-common-proc-board += -@
 DTC_FLAGS_k3-j721e-common-proc-board += -@
 DTC_FLAGS_k3-j721e-sk += -@
 DTC_FLAGS_k3-j721s2-common-proc-board += -@
diff --git a/arch/arm64/boot/dts/ti/k3-j7200-evm-pcie1-ep.dtso b/arch/arm64/boot/dts/ti/k3-j7200-evm-pcie1-ep.dtso
new file mode 100644
index 000000000000..ee30b10d1a75
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-j7200-evm-pcie1-ep.dtso
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/**
+ * DT Overlay for enabling PCIE1 instance in Endpoint Configuration with the
+ * J7 common processor board.
+ *
+ * J7 Common Processor Board Product Link: https://www.ti.com/tool/J721EXCPXEVM
+ *
+ * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/soc/ti,sci_pm_domain.h>
+
+#include "k3-pinctrl.h"
+
+/*
+ * Since Root Complex and Endpoint modes are mutually exclusive
+ * disable Root Complex mode.
+ */
+&pcie1_rc {
+	status = "disabled";
+};
+
+&cbass_main {
+	#address-cells = <2>;
+	#size-cells = <2>;
+	interrupt-parent = <&gic500>;
+
+	pcie1_ep: pcie-ep@2910000 {
+		compatible = "ti,j7200-pcie-ep", "ti,j721e-pcie-ep";
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
+		clocks = <&k3_clks 240 6>;
+		clock-names = "fck";
+		max-functions = /bits/ 8 <6>;
+		max-virtual-functions = /bits/ 8 <4 4 4 4 0 0>;
+		dma-coherent;
+		phys = <&serdes0_pcie_link>;
+		phy-names = "pcie-phy";
+	};
+};
-- 
2.34.1


