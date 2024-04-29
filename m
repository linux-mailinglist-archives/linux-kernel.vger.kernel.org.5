Return-Path: <linux-kernel+bounces-161991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1968B5448
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6BAD281A28
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85917286AE;
	Mon, 29 Apr 2024 09:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JhPTvqGU"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD67317C60;
	Mon, 29 Apr 2024 09:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714382980; cv=none; b=iamogWT8S5mwlJzHXbvvHOKjw7TNixvVSMbpDvz/2TjgmiqhAoXyAHlm6QOPXylszWZU8jwWqD/8IIIAgOcOFqFnrEQx/TYFGpK6nChHzTfckCsNxOnM3a84jY47XufhBCEMaVB6Yd0U4BljBrWYiUzG8QYCBCKE2U+rjtM+k2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714382980; c=relaxed/simple;
	bh=uSdxRzJFml3nCo76HAUg3DSxjX0UoERQLwTqM3FlGMI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TuTyX53Pp7uVDhqu+9ZPyeLLhYxhusJRKHnWj4kPMAmbOGwcGIQXmmwZ4yr+VXKxDy1BmGLgn/fl8WTAXEsQaefB7naGLyxdSx+LYKuiR6diekAR50CGt6jCARzS8v6h9hkUbD/tsFvjSxWqjdK7fCBU6oex5y13kr0ThfESR6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=JhPTvqGU; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43T9TM3M043203;
	Mon, 29 Apr 2024 04:29:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714382962;
	bh=FK6SYIgTwTmZUuVtGZyXbYiIG/QDRVtYkXsYn7IPvUQ=;
	h=From:To:CC:Subject:Date;
	b=JhPTvqGUp4ZFgzEhcU5dwy22f9YJSuD8tjHmIQqcpG3MtV63b4gT3YSyO4JcnNdsr
	 1TBssUrax6RiYEU/HypCJywgMkID9WzptBnQagkvLrB8ubZVd/ktDJL46c4oPTEtk8
	 MpvtuGEw1lqiZEBjcqxItiJL1pzcGTtE+0IxsSX8=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43T9TMiP008968
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Apr 2024 04:29:22 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Apr 2024 04:29:22 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Apr 2024 04:29:22 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43T9TMfK001599;
	Mon, 29 Apr 2024 04:29:22 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 43T9TL0U017042;
	Mon, 29 Apr 2024 04:29:22 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
CC: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, <srk@ti.com>, <r-gunasekaran@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        MD
 Danish Anwar <danishanwar@ti.com>
Subject: [PATCH v2] arm64: dts: ti: k3-am642-evm-icssg1-dualemac: add overlay for mii mode
Date: Mon, 29 Apr 2024 14:59:19 +0530
Message-ID: <20240429092919.657629-1-danishanwar@ti.com>
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

Add device tree overlay to enable both ICSSG1 ports available on AM64x-EVM
in MII mode.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
This is v2 of the series v1 [1]
Changes from v1 to v2:
*) Rebased the patch on next-20240429 linux-next tag.
*) Added "GPL-2.0-only OR MIT" in the license as pointed out by
   Ravi Gunasekaran <r-gunasekaran@ti.com>

[1] https://lore.kernel.org/all/20240423090028.1311635-1-danishanwar@ti.com/

 arch/arm64/boot/dts/ti/Makefile               |   4 +
 .../ti/k3-am642-evm-icssg1-dualemac-mii.dtso  | 101 ++++++++++++++++++
 2 files changed, 105 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am642-evm-icssg1-dualemac-mii.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 48fb19a523bd..f35f8af23264 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -44,6 +44,7 @@ k3-am642-hummingboard-t-usb3-dtbs := \
 	k3-am642-hummingboard-t.dtb k3-am642-hummingboard-t-usb3.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am642-evm.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-evm-icssg1-dualemac.dtbo
+dtb-$(CONFIG_ARCH_K3) += k3-am642-evm-icssg1-dualemac-mii.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am642-hummingboard-t.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-hummingboard-t-pcie.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-hummingboard-t-usb3.dtb
@@ -134,6 +135,8 @@ k3-am62p5-sk-csi2-tevi-ov5640-dtbs := k3-am62p5-sk.dtb \
 	k3-am62x-sk-csi2-tevi-ov5640.dtbo
 k3-am642-evm-icssg1-dualemac-dtbs := \
 	k3-am642-evm.dtb k3-am642-evm-icssg1-dualemac.dtbo
+k3-am642-evm-icssg1-dualemac-mii-dtbs := \
+	k3-am642-evm.dtb k3-am642-evm-icssg1-dualemac-mii.dtbo
 k3-am642-phyboard-electra-gpio-fan-dtbs := \
 	k3-am642-phyboard-electra-rdk.dtb k3-am642-phyboard-electra-gpio-fan.dtbo
 k3-am642-tqma64xxl-mbax4xxl-sdcard-dtbs := \
@@ -168,6 +171,7 @@ dtb- += k3-am625-beagleplay-csi2-ov5640.dtb \
 	k3-am62p5-sk-csi2-ov5640.dtb \
 	k3-am62p5-sk-csi2-tevi-ov5640.dtb \
 	k3-am642-evm-icssg1-dualemac.dtb \
+	k3-am642-evm-icssg1-dualemac-mii.dtb \
 	k3-am642-tqma64xxl-mbax4xxl-sdcard.dtb \
 	k3-am642-tqma64xxl-mbax4xxl-wlan.dtb \
 	k3-am68-sk-base-board-csi2-dual-imx219-dtbs \
diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm-icssg1-dualemac-mii.dtso b/arch/arm64/boot/dts/ti/k3-am642-evm-icssg1-dualemac-mii.dtso
new file mode 100644
index 000000000000..423d6027278d
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm-icssg1-dualemac-mii.dtso
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/**
+ * DT overlay for enabling both ICSSG1 port on AM642 EVM in MII mode
+ *
+ * Copyright (C) 2020-2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+/dts-v1/;
+/plugin/;
+#include <dt-bindings/gpio/gpio.h>
+#include "k3-pinctrl.h"
+
+&{/} {
+	aliases {
+		ethernet1 = "/icssg1-eth/ethernet-ports/port@1";
+	};
+
+	mdio-mux-2 {
+		compatible = "mdio-mux-multiplexer";
+		mux-controls = <&mdio_mux>;
+		mdio-parent-bus = <&icssg1_mdio>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		mdio@0 {
+			reg = <0x0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			icssg1_phy2: ethernet-phy@3 {
+				reg = <3>;
+			};
+		};
+	};
+};
+
+&main_pmx0 {
+	icssg1_mii1_pins_default: icssg1-mii1-default-pins {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x00f8, PIN_INPUT, 1) /* (V9) PRG1_PRU0_GPO16.PR1_MII_MT0_CLK */
+			AM64X_IOPAD(0x00f4, PIN_OUTPUT, 0) /* (Y9) PRG1_PRU0_GPO15.PR1_MII0_TXEN */
+			AM64X_IOPAD(0x00f0, PIN_OUTPUT, 0) /* (AA9) PRG1_PRU0_GPO14.PR1_MII0_TXD3 */
+			AM64X_IOPAD(0x00ec, PIN_OUTPUT, 0) /* (W9) PRG1_PRU0_GPO13.PR1_MII0_TXD2 */
+			AM64X_IOPAD(0x00e8, PIN_OUTPUT, 0) /* (U9) PRG1_PRU0_GPO12.PR1_MII0_TXD1 */
+			AM64X_IOPAD(0x00e4, PIN_OUTPUT, 0) /* (AA8) PRG1_PRU0_GPO11.PR1_MII0_TXD0 */
+			AM64X_IOPAD(0x00c8, PIN_INPUT, 1) /* (Y8) PRG1_PRU0_GPO4.PR1_MII0_RXDV */
+			AM64X_IOPAD(0x00d0, PIN_INPUT, 1) /* (AA7) PRG1_PRU0_GPO6.PR1_MII_MR0_CLK */
+			AM64X_IOPAD(0x00c4, PIN_INPUT, 1) /* (V8) PRG1_PRU0_GPO3.PR1_MII0_RXD3 */
+			AM64X_IOPAD(0x00c0, PIN_INPUT, 1) /* (W8) PRG1_PRU0_GPO2.PR1_MII0_RXD2 */
+			AM64X_IOPAD(0x00cc, PIN_INPUT, 1) /* (V13) PRG1_PRU0_GPO5.PR1_MII0_RXER */
+			AM64X_IOPAD(0x00bc, PIN_INPUT, 1) /* (U8) PRG1_PRU0_GPO1.PR1_MII0_RXD1 */
+			AM64X_IOPAD(0x00b8, PIN_INPUT, 1) /* (Y7) PRG1_PRU0_GPO0.PR1_MII0_RXD0 */
+			AM64X_IOPAD(0x00d8, PIN_INPUT, 1) /* (W13) PRG1_PRU0_GPO8.PR1_MII0_RXLINK */
+		>;
+	};
+
+	icssg1_mii2_pins_default: icssg1-mii2-default-pins {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x0148, PIN_INPUT, 1) /* (Y10) PRG1_PRU1_GPO16.PR1_MII_MT1_CLK */
+			AM64X_IOPAD(0x0144, PIN_OUTPUT, 0) /* (Y11) PRG1_PRU1_GPO15.PR1_MII1_TXEN */
+			AM64X_IOPAD(0x0140, PIN_OUTPUT, 0) /* (AA11) PRG1_PRU1_GPO14.PR1_MII1_TXD3 */
+			AM64X_IOPAD(0x013c, PIN_OUTPUT, 0) /* (U10) PRG1_PRU1_GPO13.PR1_MII1_TXD2 */
+			AM64X_IOPAD(0x0138, PIN_OUTPUT, 0) /* (V10) PRG1_PRU1_GPO12.PR1_MII1_TXD1 */
+			AM64X_IOPAD(0x0134, PIN_OUTPUT, 0) /* (AA10) PRG1_PRU1_GPO11.PR1_MII1_TXD0 */
+			AM64X_IOPAD(0x0118, PIN_INPUT, 1) /* (W12) PRG1_PRU1_GPO4.PR1_MII1_RXDV */
+			AM64X_IOPAD(0x0120, PIN_INPUT, 1) /* (U11) PRG1_PRU1_GPO6.PR1_MII_MR1_CLK */
+			AM64X_IOPAD(0x0114, PIN_INPUT, 1) /* (Y12) PRG1_PRU1_GPO3.PR1_MII1_RXD3 */
+			AM64X_IOPAD(0x0110, PIN_INPUT, 1) /* (AA12) PRG1_PRU1_GPO2.PR1_MII1_RXD2 */
+			AM64X_IOPAD(0x011c, PIN_INPUT, 1) /* (AA13) PRG1_PRU1_GPO5.PR1_MII1_RXER */
+			AM64X_IOPAD(0x010c, PIN_INPUT, 1) /* (V11) PRG1_PRU1_GPO1.PR1_MII1_RXD1 */
+			AM64X_IOPAD(0x0108, PIN_INPUT, 1) /* (W11) PRG1_PRU1_GPO0.PR1_MII1_RXD0 */
+			AM64X_IOPAD(0x0128, PIN_INPUT, 1) /* (U12) PRG1_PRU1_GPO8.PR1_MII1_RXLINK */
+		>;
+	};
+};
+
+&cpsw3g {
+	pinctrl-0 = <&rgmii1_pins_default>;
+};
+
+&cpsw_port2 {
+	status = "disabled";
+};
+
+&mdio_mux_1 {
+	status = "disabled";
+};
+
+&icssg1_eth {
+	pinctrl-0 = <&icssg1_mii1_pins_default &icssg1_mii2_pins_default>;
+};
+
+&icssg1_emac0 {
+	phy-mode = "mii";
+};
+
+&icssg1_emac1 {
+	status = "okay";
+	phy-handle = <&icssg1_phy2>;
+	phy-mode = "mii";
+};
-- 
2.34.1


