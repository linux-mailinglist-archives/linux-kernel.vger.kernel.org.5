Return-Path: <linux-kernel+bounces-75990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A71885F1AA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 07:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B852A1F2218C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 06:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFD517743;
	Thu, 22 Feb 2024 06:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lZIlHU1K"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91A6F9D3;
	Thu, 22 Feb 2024 06:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708585072; cv=none; b=VRYNrf1rd1d7Wk0y8Ju8viYYKYpWbl4YG04oyJb0jzdKZM1zUxn3WmKbWLnnkLCLCbUZMkqvn7qttOXqW2AjxVfG2EEbW6mbM6oAAT0J9YwF+Zyyy8yAGPqdPYaRd2ioEPNVxvAMhdzlX7Q++MxF2v8IBJ2kIIaMpzYwiQsnXEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708585072; c=relaxed/simple;
	bh=5DEkXjGvXDnANyo7eQxKMhMG5Zc1ZiNtexSzo+CiAnw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G8u39mjQJkDuCAabmMCMzoQKpJgbWuYuHo1m8yOlR6KkqAhewbLSt0Ct1ijcCSVuAEFHMIRCAEf+JiBBcrO8lrrmFUDt/kbh2gPJ8Rv6lWLA59jZ3iij8o3O/bzx+3nXxBbDKHJB7SJ5VJt3870EzyY+ZRr9TR8Jg1p8t67stc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lZIlHU1K; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41M6vb0q033547;
	Thu, 22 Feb 2024 00:57:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708585057;
	bh=vhLZ4cmtwGubeFOFWmaVcaBuxgPjC9KZqjRHO+yixfk=;
	h=From:To:CC:Subject:Date;
	b=lZIlHU1KYi39HMvyHH3egyZ4zTFFkF2+IFP2h9uZw7Q3nxFHoKtdV5qSE2YoVeLZl
	 3KQtI1Szfi3lV6aaZ4kyJxrnGF6JHqQwY4amyxzZfzhSftajIi87o9nW82br6U26hM
	 hRLQtmMmo4zSCK2DQuGBBlUeX7xlOEORNJUzsFsY=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41M6vbej019068
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 22 Feb 2024 00:57:37 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 22
 Feb 2024 00:57:37 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 22 Feb 2024 00:57:37 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41M6vXbk104128;
	Thu, 22 Feb 2024 00:57:34 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <afd@ti.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH v2] arm64: dts: ti: k3-j721e-evm: Add overlay for PCIE1 Endpoint Mode
Date: Thu, 22 Feb 2024 12:27:33 +0530
Message-ID: <20240222065733.1213434-1-s-vadapalli@ti.com>
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

Add overlay to enable the PCIE1 instance of PCIe on J721E-EVM in Endpoint
mode of operation. Additionally, in order to support both PCIE0 and PCIE1
in Endpoint Mode of operation, enable applying device-tree overlays on
"k3-j721e-evm-pcie0-ep.dtb", thereby allowing the overlay for PCIE1 in
Endpoint mode to be applied on the aforementioned DTB.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

This patch is based on linux-next tagged next-20240221.
The v1 of this patch is at:
https://lore.kernel.org/r/20240220105006.1056824-1-s-vadapalli@ti.com/
Changes since v1:
- Created a new overlay for PCIE1 based on Andrew's suggestion at:
  https://lore.kernel.org/r/415ee6d4-fe26-4582-80f3-9b503d308fdf@ti.com/
- Updated Makefile to allow applying overlay on
  "k3-j721e-evm-pcie0-ep.dtb"

Regards,
Siddharth.

 arch/arm64/boot/dts/ti/Makefile               |  5 ++
 .../boot/dts/ti/k3-j721e-evm-pcie1-ep.dtso    | 53 +++++++++++++++++++
 2 files changed, 58 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-evm-pcie1-ep.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index d601c52ab181..d8a5db6db490 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -76,6 +76,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-j721e-beagleboneai64.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-j721e-evm.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-j721e-evm-gesi-exp-board.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-j721e-evm-pcie0-ep.dtbo
+dtb-$(CONFIG_ARCH_K3) += k3-j721e-evm-pcie1-ep.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-j721e-sk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-j721e-sk-csi2-dual-imx219.dtbo
 
@@ -128,6 +129,8 @@ k3-am69-sk-csi2-dual-imx219-dtbs := k3-am69-sk.dtb \
 	k3-j721e-sk-csi2-dual-imx219.dtbo
 k3-j721e-evm-pcie0-ep-dtbs := k3-j721e-common-proc-board.dtb \
 	k3-j721e-evm-pcie0-ep.dtbo
+k3-j721e-evm-pcie1-ep-dtbs := k3-j721e-common-proc-board.dtb \
+	k3-j721e-evm-pcie1-ep.dtbo
 k3-j721e-sk-csi2-dual-imx219-dtbs := k3-j721e-sk.dtb \
 	k3-j721e-sk-csi2-dual-imx219.dtbo
 k3-j721s2-evm-pcie1-ep-dtbs := k3-j721s2-common-proc-board.dtb \
@@ -148,6 +151,7 @@ dtb- += k3-am625-beagleplay-csi2-ov5640.dtb \
 	k3-am68-sk-base-board-csi2-dual-imx219-dtbs \
 	k3-am69-sk-csi2-dual-imx219-dtbs \
 	k3-j721e-evm-pcie0-ep.dtb \
+	k3-j721e-evm-pcie1-ep.dtb \
 	k3-j721e-sk-csi2-dual-imx219-dtbs \
 	k3-j721s2-evm-pcie1-ep.dtb
 
@@ -162,5 +166,6 @@ DTC_FLAGS_k3-am6548-iot2050-advanced-m2 += -@
 DTC_FLAGS_k3-am68-sk-base-board += -@
 DTC_FLAGS_k3-am69-sk += -@
 DTC_FLAGS_k3-j721e-common-proc-board += -@
+DTC_FLAGS_k3-j721e-evm-pcie0-ep += -@
 DTC_FLAGS_k3-j721e-sk += -@
 DTC_FLAGS_k3-j721s2-common-proc-board += -@
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-evm-pcie1-ep.dtso b/arch/arm64/boot/dts/ti/k3-j721e-evm-pcie1-ep.dtso
new file mode 100644
index 000000000000..b1d579e577ab
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-j721e-evm-pcie1-ep.dtso
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
+};
-- 
2.34.1


