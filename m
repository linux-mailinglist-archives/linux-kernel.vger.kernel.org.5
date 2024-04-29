Return-Path: <linux-kernel+bounces-162033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A081C8B54E7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E4941F22320
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911B128398;
	Mon, 29 Apr 2024 10:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="V3fUA3PH"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227BB2C85F;
	Mon, 29 Apr 2024 10:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714385874; cv=none; b=i5k0YoGcjKwpFa+htUjrilCsAsBIPxo8Zer/Piqf98NKcxHwTmCaKs0P4EroHtFS7rmXZ17vRiTleCEADBxow6RQ5V1SarXmIZxaOBEOQTSeIb4tNcDTRSX+qPfGGEJGWCqlIzf9li2gqILDEVi/n3lRU00X7DW5GMLdAe9DEGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714385874; c=relaxed/simple;
	bh=80PY6jL4DQo7PY+vtJwC9gF0O1nUV5FFyvCVjuO3buE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TO778epHQHvIydrnZuh0RH/+i7cWccZ4MxOaW02NrK0IoyHymLUV5Jb8FbjuO4sA3rCeamIxb9ngfuBEL9uMYUUPztc6uDXUEf2pMaWwK55QseH+xztCAoJtJv135OaNhRympuOIzGz8wIDtPYocqImDaZ2L2WBaevI71iGXxBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=V3fUA3PH; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43TAHjjR126980;
	Mon, 29 Apr 2024 05:17:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714385865;
	bh=Px2f67gMOFMB3tes57EilRrghU4XcLaNrfLnMFzKEEo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=V3fUA3PHLY6+6yHYnxNAvQ0FjzqCGnWp3okDYkMU9nEHaMiTvVnVpYGlUOn6Hrzu5
	 7G3mlyslNxFXbJ5UBtMrCJR/H6u7+9oboTb7vy7GWUm6mHMEQqURaiqwzgVzv+o+1m
	 agcL6dW2Hkldv6Ffqa/R2YmEEswdKN9Yr3kAJk5I=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43TAHjuW017124
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Apr 2024 05:17:45 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Apr 2024 05:17:44 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Apr 2024 05:17:45 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43TAHis5103097;
	Mon, 29 Apr 2024 05:17:44 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Tero Kristo
	<kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon
	<nm@ti.com>,
        <s-vadapalli@ti.com>, <danishanwar@ti.com>, <r-gunasekaran@ti.com>,
        <srk@ti.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Chintan Vankar <c-vankar@ti.com>
Subject: [PATCH v3 2/2] arm64: dts: ti: k3-am62a7: Add overlay for second CPSW3G Port
Date: Mon, 29 Apr 2024 15:47:39 +0530
Message-ID: <20240429101739.2770090-3-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240429101739.2770090-1-c-vankar@ti.com>
References: <20240429101739.2770090-1-c-vankar@ti.com>
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

Link to v2:
https://lore.kernel.org/r/20240425102038.1995252-3-c-vankar@ti.com/

Changes from v2 to v3:
- Updated SPDX-License-Identifier and "pinctrl-0" property in "cpsw3g"
  node in "k3-am62a7-sk-ethernet-dc01.dtso" as suggested by Ravi.

 arch/arm64/boot/dts/ti/Makefile               |  3 +
 .../dts/ti/k3-am62a7-sk-ethernet-dc01.dtso    | 62 +++++++++++++++++++
 2 files changed, 65 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62a7-sk-ethernet-dc01.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 48fb19a523bd..b4bc5712b1a4 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -27,6 +27,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am62-lp-sk.dtb
 
 # Boards with AM62Ax SoC
 dtb-$(CONFIG_ARCH_K3) += k3-am62a7-sk.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-am62a7-sk-ethernet-dc01.dtbo
 
 # Boards with AM62Px SoC
 dtb-$(CONFIG_ARCH_K3) += k3-am62p5-sk.dtb
@@ -125,6 +126,8 @@ k3-am62a7-sk-csi2-ov5640-dtbs := k3-am62a7-sk.dtb \
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
index 000000000000..ed73d9a80379
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk-ethernet-dc01.dtso
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
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
+	pinctrl-0 = <&main_rgmii1_pins_default>,
+		    <&main_rgmii2_pins_default>;
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


