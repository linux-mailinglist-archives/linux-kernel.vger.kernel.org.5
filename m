Return-Path: <linux-kernel+bounces-154746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B96958AE07A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71272282E81
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F4556B69;
	Tue, 23 Apr 2024 09:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="axwT2LI/"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE4756443;
	Tue, 23 Apr 2024 09:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713862850; cv=none; b=GcsixDQ8b9iwZniuoxLASoZ9y0yOC75x5OI6ss2oE8wd7+ySFOAlEDdrZd6740w+neLbdkKXV5vIWTTdwa+Yy3yPI1O6q0NreNn9bvuD9o9kgEJcm/W8Q6ZUQQ0M0uiQp0M5+cDGVJTAZl7bRvkV5CiN6rthU6FDmZiB6aLn3dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713862850; c=relaxed/simple;
	bh=AaPe4W5ATU0vKXRJA+JX8mxIfjHiFM2MGOqUcT2Zjlg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QU8pomdtvQkfAnF0BTsd1QqRpFgJaTnD+U5719sb+8qdvSnJ9M7inw+3WpwJrSNQDQw88X073JcX0mkmZ4dD3CkxgrYKeHg+e/VP2iALPEqCxCnJApV+RQc6S6Yg7I+xY1lvi6SVU4L/7/n5xKp9HLQOwJUOyYabTz0wDalEeYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=axwT2LI/; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43N90W5O102048;
	Tue, 23 Apr 2024 04:00:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713862832;
	bh=alTEvUtf7H2uqDMe4053Ta0mKCB1AIUyCEraP187CNQ=;
	h=From:To:CC:Subject:Date;
	b=axwT2LI/tuAzCylciujUpYigCqp9ppfXoGUUwYTEYGniDpt9P+PnjIRB/j38+8eQ4
	 1AeJIUAroAEpjZM0VXGiW+cmIQiKeOI2BD2bvga21d755Wqx/BA06YzVtMwATzI+eJ
	 /4pWtdNJlUh3qHYPnaYmy1UYk+MqVvA0OrQhYsJM=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43N90WeQ104439
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Apr 2024 04:00:32 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Apr 2024 04:00:32 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Apr 2024 04:00:32 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43N90Wx5093755;
	Tue, 23 Apr 2024 04:00:32 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 43N90VEh023186;
	Tue, 23 Apr 2024 04:00:31 -0500
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
Subject: [PATCH] arm64: dts: ti: k3-am642-evm-icssg1-dualemac: add overlay for mii mode
Date: Tue, 23 Apr 2024 14:30:28 +0530
Message-ID: <20240423090028.1311635-1-danishanwar@ti.com>
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
NOTE: This patch depends on [1]. Without [1] mii mode will not work for
ICSSG. Patch [1] is currently posted to net subsystem.

This patch is based on next-20240423 linux-next tag.

[1] https://lore.kernel.org/all/20240423084828.1309294-1-danishanwar@ti.com/

 arch/arm64/boot/dts/ti/Makefile               |   4 +
 .../ti/k3-am642-evm-icssg1-dualemac-mii.dtso  | 101 ++++++++++++++++++
 2 files changed, 105 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am642-evm-icssg1-dualemac-mii.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index c76b41f86527..08c974b05616 100644
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
@@ -132,6 +133,8 @@ k3-am62p5-sk-csi2-tevi-ov5640-dtbs := k3-am62p5-sk.dtb \
 	k3-am62x-sk-csi2-tevi-ov5640.dtbo
 k3-am642-evm-icssg1-dualemac-dtbs := \
 	k3-am642-evm.dtb k3-am642-evm-icssg1-dualemac.dtbo
+k3-am642-evm-icssg1-dualemac-mii-dtbs := \
+	k3-am642-evm.dtb k3-am642-evm-icssg1-dualemac-mii.dtbo
 k3-am642-tqma64xxl-mbax4xxl-sdcard-dtbs := \
 	k3-am642-tqma64xxl-mbax4xxl.dtb k3-am64-tqma64xxl-mbax4xxl-sdcard.dtbo
 k3-am642-tqma64xxl-mbax4xxl-wlan-dtbs := \
@@ -160,6 +163,7 @@ dtb- += k3-am625-beagleplay-csi2-ov5640.dtb \
 	k3-am62p5-sk-csi2-ov5640.dtb \
 	k3-am62p5-sk-csi2-tevi-ov5640.dtb \
 	k3-am642-evm-icssg1-dualemac.dtb \
+	k3-am642-evm-icssg1-dualemac-mii.dtb \
 	k3-am642-tqma64xxl-mbax4xxl-sdcard.dtb \
 	k3-am642-tqma64xxl-mbax4xxl-wlan.dtb \
 	k3-am68-sk-base-board-csi2-dual-imx219-dtbs \
diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm-icssg1-dualemac-mii.dtso b/arch/arm64/boot/dts/ti/k3-am642-evm-icssg1-dualemac-mii.dtso
new file mode 100644
index 000000000000..3081b5c64886
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm-icssg1-dualemac-mii.dtso
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0
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


