Return-Path: <linux-kernel+bounces-158383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E328B1F0B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49F491F24ABD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A2C1272CB;
	Thu, 25 Apr 2024 10:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OS2WGmJq"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8538126F02;
	Thu, 25 Apr 2024 10:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714040452; cv=none; b=uVoYZO0nqJXOcFyMpiGm2UawqUKV/6GhdAUxfEKBytAKWCSb9TjaJzMbUGtaWyu7Xve7raNcwnWTNqDP8M3YqD92hDNdgJx0yeQgy3Hx3WNxeL5qptiwvSR5p0fJHIsT1e2SzKRd8YdqPzO/CXNR+mByQD2zWk0VUtJ8EQ1JPrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714040452; c=relaxed/simple;
	bh=vuHXorPy6YtF2cDUTngs8FJ6VxYtlfsvKMpKbQE7f30=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kED3+zyD3r4/IuY8TcEbA39gC0CxBPiIY3Wv3Pbjuys25v22uAOoOOK6H5O3KdoZTH4Dl4+s0XW6dLWjHZao1MmW8oiSxIgNvjH1MvgILJzeyW0cUkFdnBlAD5Sps4oZeatSUSQBFg9yG6R1Xe+Xm6mRVWVe26YOq2YkSubdgAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OS2WGmJq; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43PAKjFo122860;
	Thu, 25 Apr 2024 05:20:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714040445;
	bh=KA0nu5NQ1a/+4LHWjpLd7xA6ZjPq0ef69CqsU9ADrKQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=OS2WGmJqrP8SWyL1gv774NNTyHD8KhGQbdBZinziQ/7b13QUhG3FWQnJgsDE72OBf
	 TohCwm51s4nBrW5JApR7EZFjTheoLzKz5gzcqXjIjanlxtgKP9kNkXU//Dnu3gof8X
	 ipkvJT9y/H/rBV89SFr/rg3GuVuGvI/rhfBMQCrg=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43PAKjqT090579
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 25 Apr 2024 05:20:45 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 25
 Apr 2024 05:20:44 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 25 Apr 2024 05:20:44 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43PAKhSI002423;
	Thu, 25 Apr 2024 05:20:43 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Tero Kristo
	<kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon
	<nm@ti.com>,
        <s-vadapalli@ti.com>, <srk@ti.com>, <danishanwar@ti.com>,
        <r-gunasekaran@ti.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Chintan Vankar <c-vankar@ti.com>
Subject: [PATCH v2 2/2] arm64: dts: ti: k3-am62a7: Add overlay for second CPSW3G Port
Date: Thu, 25 Apr 2024 15:50:38 +0530
Message-ID: <20240425102038.1995252-3-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425102038.1995252-1-c-vankar@ti.com>
References: <20240425102038.1995252-1-c-vankar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Siddharth Vadapalli <s-vadapalli@ti.com>

The SK-Ethernet-DC01 Add-On Ethernet Card for AM62A7-SK board supports
RGMII mode.

Add overlay to enable the second CPSW3G port in RGMII-RXID mode with the
Add-On Ethernet Card.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

Link to v1:
https://lore.kernel.org/r/20230424111945.3865240-3-s-vadapalli@ti.com/

Changes from v1 to v2:
- Since support for device tree overlays for am62a7-sk is already enabled
  by commit "635ed9715194", it is removed from this series.

 arch/arm64/boot/dts/ti/Makefile               |  3 +
 .../dts/ti/k3-am62a7-sk-ethernet-dc01.dtso    | 61 +++++++++++++++++++
 2 files changed, 64 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62a7-sk-ethernet-dc01.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index c76b41f86527..8c55e46d9f98 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -27,6 +27,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am62-lp-sk.dtb
 
 # Boards with AM62Ax SoC
 dtb-$(CONFIG_ARCH_K3) += k3-am62a7-sk.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-am62a7-sk-ethernet-dc01.dtbo
 
 # Boards with AM62Px SoC
 dtb-$(CONFIG_ARCH_K3) += k3-am62p5-sk.dtb
@@ -123,6 +124,8 @@ k3-am62a7-sk-csi2-ov5640-dtbs := k3-am62a7-sk.dtb \
 	k3-am62x-sk-csi2-ov5640.dtbo
 k3-am62a7-sk-csi2-tevi-ov5640-dtbs := k3-am62a7-sk.dtb \
 	k3-am62x-sk-csi2-tevi-ov5640.dtbo
+k3-am62a7-sk-ethernet-dc01-dtbs := k3-am62a7-sk.dtb \
+	k3-am62a7-sk-ethernet-dc01.dtbo
 k3-am62a7-sk-hdmi-audio-dtbs := k3-am62a7-sk.dtb k3-am62x-sk-hdmi-audio.dtbo
 k3-am62p5-sk-csi2-imx219-dtbs := k3-am62p5-sk.dtb \
 	k3-am62x-sk-csi2-imx219.dtbo
diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk-ethernet-dc01.dtso b/arch/arm64/boot/dts/ti/k3-am62a7-sk-ethernet-dc01.dtso
new file mode 100644
index 000000000000..f6d5a089a717
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk-ethernet-dc01.dtso
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0
+/**
+ * DT Overlay for second CPSW3G port in RGMII mode using SK-ETHERNET-DC01
+ * Add-On Daughtercard with AM62A7-SK.
+ *
+ * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/net/ti-dp83867.h>
+#include "k3-pinctrl.h"
+
+&{/} {
+	aliases {
+		ethernet1 = "/bus@f0000/ethernet@8000000/ethernet-ports/port@2";
+	};
+};
+
+&cpsw3g {
+	pinctrl-0 = <&main_rgmii1_pins_default>, <&main_rgmii2_pins_default>;
+};
+
+&cpsw_port2 {
+	status = "okay";
+	phy-mode = "rgmii-rxid";
+	phy-handle = <&cpsw3g_phy1>;
+};
+
+&cpsw3g_mdio {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	cpsw3g_phy1: ethernet-phy@1 {
+		reg = <1>;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+		ti,min-output-impedance;
+	};
+};
+
+&main_pmx0 {
+	main_rgmii2_pins_default: main-rgmii2-default-pins {
+		pinctrl-single,pins = <
+			AM62AX_IOPAD(0x0184, PIN_INPUT, 0) /* (AA21) RGMII2_RD0 */
+			AM62AX_IOPAD(0x0188, PIN_INPUT, 0) /* (Y20) RGMII2_RD1 */
+			AM62AX_IOPAD(0x018c, PIN_INPUT, 0) /* (AB21) RGMII2_RD2 */
+			AM62AX_IOPAD(0x0190, PIN_INPUT, 0) /* (AB20) RGMII2_RD3 */
+			AM62AX_IOPAD(0x0180, PIN_INPUT, 0) /* (AA20) RGMII2_RXC */
+			AM62AX_IOPAD(0x017c, PIN_INPUT, 0) /* (W18) RGMII2_RX_CTL */
+			AM62AX_IOPAD(0x016c, PIN_INPUT, 0) /* (AA19) RGMII2_TD0 */
+			AM62AX_IOPAD(0x0170, PIN_INPUT, 0) /* (Y18) RGMII2_TD1 */
+			AM62AX_IOPAD(0x0174, PIN_INPUT, 0) /* (AA18) RGMII2_TD2 */
+			AM62AX_IOPAD(0x0178, PIN_INPUT, 0) /* (W17) RGMII2_TD3 */
+			AM62AX_IOPAD(0x0168, PIN_INPUT, 0) /* (AB19) RGMII2_TXC */
+			AM62AX_IOPAD(0x0164, PIN_INPUT, 0) /* (Y19) RGMII2_TX_CTL */
+		>;
+	};
+};
-- 
2.34.1


