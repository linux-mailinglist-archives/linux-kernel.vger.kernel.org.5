Return-Path: <linux-kernel+bounces-83155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B87F868F9C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5FB3B269ED
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB40A13A258;
	Tue, 27 Feb 2024 12:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Z92COB6n"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF0754BFC;
	Tue, 27 Feb 2024 12:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709035407; cv=none; b=joFTdaEpwifWrx11x0/73WgiTwIx1FM5/Lp6QnCVqGNyLOtDxLheyP5HRhrFsXQfAV8gHqCnplKYGFyG7QVD8+XGc0R5HNiDdHaxOU7e8ru0hZX3KRgw5j/YfJQk4pApjlPxv4rxRhjqAhhuXp4Uv1ZNzZ98fruiJSZ0D8OlIfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709035407; c=relaxed/simple;
	bh=GsH6izNXdbmxh8NNvIFbshbJYlnz8b95wx2R16E4C6w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ny7AffIawM8hWipvSHDVc1HBJnr/5v46l440mMa5ZkZHpgCzcBGKLO9y0VS9eiFbUIX7i2eZIJuVTh59vDb7ZM2bZn+XPFyjyRltvY57XGA7zNYSiumiyQnu5dbT/GconsXGF9frFTPTycFFTJ7xVAcEnxJEPGjBIdZLH9l9gNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Z92COB6n; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41RC3CEL049078;
	Tue, 27 Feb 2024 06:03:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1709035392;
	bh=MssOyU05YccTT8c6vbdsyXfwRvVXA7CqNRglTs3bjvQ=;
	h=From:To:CC:Subject:Date;
	b=Z92COB6n0fCKZlbejmoKFLEYucab64Y8iyi1ShAfLUZZhc6IuVAshyqlD40BvyW7b
	 2eBlqv6ynKGAfwlrtES14VOq+UQfN5Dv3CSKoDsSGfu2tS3X2FgCJnkvoRV+NADQsC
	 ySh2gLfPIN7lpr1PFA0Z1UX05Q1p4lpYAbqTHMio=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41RC3ClR000687
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 27 Feb 2024 06:03:12 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 27
 Feb 2024 06:03:11 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 27 Feb 2024 06:03:11 -0600
Received: from localhost (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com [172.24.227.177])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41RC3AkV090058;
	Tue, 27 Feb 2024 06:03:11 -0600
From: Jayesh Choudhary <j-choudhary@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <tomi.valkeinen@ideasonboard.com>
CC: <kristo@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <r-ravikumar@ti.com>,
        <j-choudhary@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-j721e: Add overlay for J721E Infotainment Expansion Board
Date: Tue, 27 Feb 2024 17:33:10 +0530
Message-ID: <20240227120310.661579-1-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Tomi Valkeinen <tomi.valkeinen@ti.com>

J721E common processor board can be interfaced with the infotainment
expansion board[0] to enable the following audio/video interfaces in
addition to the peripherals provided by the common processor board:
- Two Audio codecs each with three Stereo Inputs and four Stereo Outputs
- Audio input over FPD Link III
- Digital Audio Interface TX/RX
- HDMI/FPD LINK III Display out
- LI/OV Camera input

Add support for TFP410 HDMI bridge located on the Infotainment Expansion
Board (connected to J46 & J51).
Add a HDMI connector node and connect the endpoints as below:
DSS => TFP410 bridge => HDMI connector
Also add the pinmux data and board muxes for DPI.

[0]: <https://www.ti.com/lit/ug/spruit0a/spruit0a.pdf>

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
[j-choudhary@ti.com: minor cleanup]
Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---

Testing log:
<https://gist.github.com/Jayesh2000/c4164ba006dbddc9bbcb851d40e3c306>

Patch is based on:
<https://git.ti.com/cgit/ti-linux-kernel/ti-upstream-tools/commit/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board-infotainment.dtso?id=da742e7e0043555c6705ea75dcda55c1d29a0520>

 arch/arm64/boot/dts/ti/Makefile               |   4 +
 ...-j721e-common-proc-board-infotainment.dtso | 164 ++++++++++++++++++
 2 files changed, 168 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-common-proc-board-infotainment.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 9843b7656725..b570c4bd3379 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -78,6 +78,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-j721e-evm-gesi-exp-board.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-j721e-evm-pcie0-ep.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-j721e-sk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-j721e-sk-csi2-dual-imx219.dtbo
+dtb-$(CONFIG_ARCH_K3) += k3-j721e-common-proc-board-infotainment.dtbo
 
 # Boards with J721s2 SoC
 dtb-$(CONFIG_ARCH_K3) += k3-am68-sk-base-board.dtb
@@ -132,6 +133,8 @@ k3-am68-sk-base-board-csi2-dual-imx219-dtbs := k3-am68-sk-base-board.dtb \
 	k3-j721e-sk-csi2-dual-imx219.dtbo
 k3-am69-sk-csi2-dual-imx219-dtbs := k3-am69-sk.dtb \
 	k3-j721e-sk-csi2-dual-imx219.dtbo
+k3-j721e-common-proc-board-infotainment-dtbs := k3-j721e-common-proc-board.dtb \
+	k3-j721e-common-proc-board-infotainment.dtbo
 k3-j721e-evm-pcie0-ep-dtbs := k3-j721e-common-proc-board.dtb \
 	k3-j721e-evm-pcie0-ep.dtbo
 k3-j721e-sk-csi2-dual-imx219-dtbs := k3-j721e-sk.dtb \
@@ -156,6 +159,7 @@ dtb- += k3-am625-beagleplay-csi2-ov5640.dtb \
 	k3-am642-tqma64xxl-mbax4xxl-wlan.dtb \
 	k3-am68-sk-base-board-csi2-dual-imx219-dtbs \
 	k3-am69-sk-csi2-dual-imx219-dtbs \
+	k3-j721e-common-proc-board-infotainment.dtb \
 	k3-j721e-evm-pcie0-ep.dtb \
 	k3-j721e-sk-csi2-dual-imx219-dtbs \
 	k3-j721s2-evm-pcie1-ep.dtb
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board-infotainment.dtso b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board-infotainment.dtso
new file mode 100644
index 000000000000..65a7e54f0884
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board-infotainment.dtso
@@ -0,0 +1,164 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Infotainment Expansion Board for j721e-evm
+ * User Guide: <https://www.ti.com/lit/ug/spruit0a/spruit0a.pdf>
+ *
+ * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+#include "k3-pinctrl.h"
+
+&{/} {
+	hdmi-connector {
+		compatible = "hdmi-connector";
+		label = "hdmi";
+		type = "a";
+		ddc-i2c-bus = <&main_i2c1>;
+		digital;
+		/* P12 - HDMI_HPD */
+		hpd-gpios = <&exp6 10 GPIO_ACTIVE_HIGH>;
+
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&tfp410_out>;
+			};
+		};
+	};
+
+	dvi-bridge {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "ti,tfp410";
+		/* P10 - HDMI_PDn */
+		powerdown-gpios = <&exp6 8 GPIO_ACTIVE_LOW>;
+
+		port@0 {
+			reg = <0>;
+
+			tfp410_in: endpoint {
+				remote-endpoint = <&dpi_out0>;
+				pclk-sample = <1>;
+			};
+		};
+
+		port@1 {
+			reg = <1>;
+
+			tfp410_out: endpoint {
+				remote-endpoint =
+					<&hdmi_connector_in>;
+			};
+		};
+	};
+};
+
+&main_pmx0 {
+	main_i2c1_exp6_pins_default: main-i2c1-exp6-default-pins {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x264, PIN_INPUT, 7) /* (T29) MMC2_DAT2.GPIO1_24 */
+		>;
+	};
+
+	dss_vout0_pins_default: dss-vout0-default-pins {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x58, PIN_OUTPUT, 10) /* (AE22) PRG1_PRU1_GPO0.VOUT0_DATA0 */
+			J721E_IOPAD(0x5c, PIN_OUTPUT, 10) /* (AG23) PRG1_PRU1_GPO1.VOUT0_DATA1 */
+			J721E_IOPAD(0x60, PIN_OUTPUT, 10) /* (AF23) PRG1_PRU1_GPO2.VOUT0_DATA2 */
+			J721E_IOPAD(0x64, PIN_OUTPUT, 10) /* (AD23) PRG1_PRU1_GPO3.VOUT0_DATA3 */
+			J721E_IOPAD(0x68, PIN_OUTPUT, 10) /* (AH24) PRG1_PRU1_GPO4.VOUT0_DATA4 */
+			J721E_IOPAD(0x6c, PIN_OUTPUT, 10) /* (AG21) PRG1_PRU1_GPO5.VOUT0_DATA5 */
+			J721E_IOPAD(0x70, PIN_OUTPUT, 10) /* (AE23) PRG1_PRU1_GPO6.VOUT0_DATA6 */
+			J721E_IOPAD(0x74, PIN_OUTPUT, 10) /* (AC21) PRG1_PRU1_GPO7.VOUT0_DATA7 */
+			J721E_IOPAD(0x78, PIN_OUTPUT, 10) /* (Y23)  PRG1_PRU1_GPO8.VOUT0_DATA8 */
+			J721E_IOPAD(0x7c, PIN_OUTPUT, 10) /* (AF21) PRG1_PRU1_GPO9.VOUT0_DATA9 */
+			J721E_IOPAD(0x80, PIN_OUTPUT, 10) /* (AB23) PRG1_PRU1_GPO10.VOUT0_DATA10 */
+			J721E_IOPAD(0x84, PIN_OUTPUT, 10) /* (AJ25) PRG1_PRU1_GPO11.VOUT0_DATA11 */
+			J721E_IOPAD(0x88, PIN_OUTPUT, 10) /* (AH25) PRG1_PRU1_GPO12.VOUT0_DATA12 */
+			J721E_IOPAD(0x8c, PIN_OUTPUT, 10) /* (AG25) PRG1_PRU1_GPO13.VOUT0_DATA13 */
+			J721E_IOPAD(0x90, PIN_OUTPUT, 10) /* (AH26) PRG1_PRU1_GPO14.VOUT0_DATA14 */
+			J721E_IOPAD(0x94, PIN_OUTPUT, 10) /* (AJ27) PRG1_PRU1_GPO15.VOUT0_DATA15 */
+			J721E_IOPAD(0x30, PIN_OUTPUT, 10) /* (AF24) PRG1_PRU0_GPO11.VOUT0_DATA16 */
+			J721E_IOPAD(0x34, PIN_OUTPUT, 10) /* (AJ24) PRG1_PRU0_GPO12.VOUT0_DATA17 */
+			J721E_IOPAD(0x38, PIN_OUTPUT, 10) /* (AG24) PRG1_PRU0_GPO13.VOUT0_DATA18 */
+			J721E_IOPAD(0x3c, PIN_OUTPUT, 10) /* (AD24) PRG1_PRU0_GPO14.VOUT0_DATA19 */
+			J721E_IOPAD(0x40, PIN_OUTPUT, 10) /* (AC24) PRG1_PRU0_GPO15.VOUT0_DATA20 */
+			J721E_IOPAD(0x44, PIN_OUTPUT, 10) /* (AE24) PRG1_PRU0_GPO16.VOUT0_DATA21 */
+			J721E_IOPAD(0x24, PIN_OUTPUT, 10) /* (AJ20) PRG1_PRU0_GPO8.VOUT0_DATA22 */
+			J721E_IOPAD(0x28, PIN_OUTPUT, 10) /* (AG20) PRG1_PRU0_GPO9.VOUT0_DATA23 */
+			J721E_IOPAD(0x9c, PIN_OUTPUT, 10) /* (AC22) PRG1_PRU1_GPO17.VOUT0_DE */
+			J721E_IOPAD(0x98, PIN_OUTPUT, 10) /* (AJ26) PRG1_PRU1_GPO16.VOUT0_HSYNC */
+			J721E_IOPAD(0xa4, PIN_OUTPUT, 10) /* (AH22) PRG1_PRU1_GPO19.VOUT0_PCLK */
+			J721E_IOPAD(0xa0, PIN_OUTPUT, 10) /* (AJ22) PRG1_PRU1_GPO18.VOUT0_VSYNC */
+		>;
+	};
+};
+
+&exp1 {
+	p14-hog {
+		/* P14 - VINOUT_MUX_SEL0 */
+		gpio-hog;
+		gpios = <12 GPIO_ACTIVE_HIGH>;
+		output-low;
+		line-name = "VINOUT_MUX_SEL0";
+	};
+
+	p15-hog {
+		/* P15 - VINOUT_MUX_SEL1 */
+		gpio-hog;
+		gpios = <13 GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "VINOUT_MUX_SEL1";
+	};
+};
+
+&main_i2c1 {
+	/* i2c1 is used for DVI DDC, so we need to use 100kHz */
+	clock-frequency = <100000>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	exp6: gpio@21 {
+		compatible = "ti,tca6416";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&main_i2c1_exp6_pins_default>;
+		interrupt-parent = <&main_gpio1>;
+		interrupts = <24 IRQ_TYPE_EDGE_FALLING>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+
+		p11-hog {
+			/* P11 - HDMI_DDC_OE */
+			gpio-hog;
+			gpios = <9 GPIO_ACTIVE_HIGH>;
+			output-high;
+			line-name = "HDMI_DDC_OE";
+		};
+	};
+};
+
+&dss {
+	pinctrl-names = "default";
+	pinctrl-0 = <&dss_vout0_pins_default>;
+};
+
+&dss_ports {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	port@1 {
+		reg = <1>;
+
+		dpi_out0: endpoint {
+			remote-endpoint = <&tfp410_in>;
+		};
+	};
+};
-- 
2.25.1


