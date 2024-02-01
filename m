Return-Path: <linux-kernel+bounces-48179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 828FA845847
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A9DC28DD6A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B734A5CDFA;
	Thu,  1 Feb 2024 12:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DYO1FWOY"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD88D5338E;
	Thu,  1 Feb 2024 12:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706792113; cv=none; b=gTSX9SLzqONQzADCDFByIVFf10Eamyy+HWRbYvMZsZCgpbVmB35OCqdnNLhlo9D+XyafVqmG6yFnQOZ+lMMid9jAzjtzXsOposCEgNr8xkDr4jixsbA/kmYO2jE8tXUYUVf8h3pnPcnhgDSriVrnRxcbaVC02+xhQGavB/mK9uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706792113; c=relaxed/simple;
	bh=nMXrimNiXNgwsxKsgEdDdFyfIjwVgI99zTL2+O7FGXQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P2UQ+zdzNjMylKw57UxqvkH+wd8AxGHe3WKm+DXAomTnXX9V1AuGzyv5FlWjaApvVzd9clpsM+5JyHysF2mPUZwXHGv32b2Dr69tp3RwE8WXrUWzEhXMnYBvcmmNYYGsJio2IFeCj5mIPQLsLbQY95dgjW3JIEWJ74ry1QHCxaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DYO1FWOY; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 411CsuRZ101307;
	Thu, 1 Feb 2024 06:54:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706792096;
	bh=I9C8j80OYqB8fkbojgDA76Rz4b12KcYaW0of1v1Lxp0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=DYO1FWOYw1dyfIdtk9XLXjatOY5hUqs9I5xfTSnK7yySbDN3Dqh0JrYn38U3RICSo
	 9KJ0+42x9DPYCt9YV5Rp4pIjQXAeoTCQjm6GMiIMxm1757Iu3PRvbLNPD+IcfnUPv+
	 loTG9abvjwiOcedBfCaZtZsfdq7+jJY+DunF26vE=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 411Csumr107731
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 1 Feb 2024 06:54:56 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Feb 2024 06:54:56 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Feb 2024 06:54:56 -0600
Received: from localhost (uda0496377.dhcp.ti.com [10.24.69.150])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 411Cstam064963;
	Thu, 1 Feb 2024 06:54:56 -0600
From: Aradhya Bhatia <a-bhatia1@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List
	<linux-kernel@vger.kernel.org>,
        Linux ARM Kernel List
	<linux-arm-kernel@lists.infradead.org>,
        Tomi Valkeinen
	<tomi.valkeinen@ideasonboard.com>,
        Devarsh Thakkar <devarsht@ti.com>, Jai
 Luthra <j-luthra@ti.com>,
        Aradhya Bhatia <a-bhatia1@ti.com>
Subject: [PATCH 2/3] arm64: dts: ti: k3-am62a7-sk: Add HDMI support
Date: Thu, 1 Feb 2024 18:24:51 +0530
Message-ID: <20240201125452.1920623-3-a-bhatia1@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240201125452.1920623-1-a-bhatia1@ti.com>
References: <20240201125452.1920623-1-a-bhatia1@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The DSS outputs DPI signals via its second video port (VP2). The DPI
output from DSS is 24 bits (RGB888) and is forwarded to an HDMI
transmitter (SIL9022) on the board.

Add pinmux info for DSS DPI output.

Add DT nodes for SIL9022 HDMI transmitter (TX), and the HDMI connector
on the AM62A7-SK platforms.

Additionally, connect the output of DSS (VP2) with input of the HDMI TX,
and the output of HDMI TX to the input of the HDMI connector.

Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 92 +++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
index 7b7142586295..c9eb2a9aef39 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
@@ -132,6 +132,18 @@ tlv320_mclk: clk-0 {
 		clock-frequency = <12288000>;
 	};
 
+	hdmi0: connector-hdmi {
+		compatible = "hdmi-connector";
+		label = "hdmi";
+		type = "a";
+
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&sii9022_out>;
+			};
+		};
+	};
+
 	codec_audio: sound {
 		compatible = "simple-audio-card";
 		simple-audio-card,name = "AM62Ax-SKEVM";
@@ -181,6 +193,39 @@ &wkup_uart0 {
 };
 
 &main_pmx0 {
+	main_dss0_pins_default: main-dss0-default-pins {
+		pinctrl-single,pins = <
+			AM62AX_IOPAD(0x100, PIN_OUTPUT, 0) /* (V17) VOUT0_VSYNC */
+			AM62AX_IOPAD(0x0f8, PIN_OUTPUT, 0) /* (T18) VOUT0_HSYNC */
+			AM62AX_IOPAD(0x104, PIN_OUTPUT, 0) /* (AA22) VOUT0_PCLK */
+			AM62AX_IOPAD(0x0fc, PIN_OUTPUT, 0) /* (U17) VOUT0_DE */
+			AM62AX_IOPAD(0x0b8, PIN_OUTPUT, 0) /* (U22) VOUT0_DATA0 */
+			AM62AX_IOPAD(0x0bc, PIN_OUTPUT, 0) /* (U21) VOUT0_DATA1 */
+			AM62AX_IOPAD(0x0c0, PIN_OUTPUT, 0) /* (U20) VOUT0_DATA2 */
+			AM62AX_IOPAD(0x0c4, PIN_OUTPUT, 0) /* (U19) VOUT0_DATA3 */
+			AM62AX_IOPAD(0x0c8, PIN_OUTPUT, 0) /* (T19) VOUT0_DATA4 */
+			AM62AX_IOPAD(0x0cc, PIN_OUTPUT, 0) /* (U18) VOUT0_DATA5 */
+			AM62AX_IOPAD(0x0d0, PIN_OUTPUT, 0) /* (V22) VOUT0_DATA6 */
+			AM62AX_IOPAD(0x0d4, PIN_OUTPUT, 0) /* (V21) VOUT0_DATA7 */
+			AM62AX_IOPAD(0x0d8, PIN_OUTPUT, 0) /* (V19) VOUT0_DATA8 */
+			AM62AX_IOPAD(0x0dc, PIN_OUTPUT, 0) /* (V18) VOUT0_DATA9 */
+			AM62AX_IOPAD(0x0e0, PIN_OUTPUT, 0) /* (W22) VOUT0_DATA10 */
+			AM62AX_IOPAD(0x0e4, PIN_OUTPUT, 0) /* (W21) VOUT0_DATA11 */
+			AM62AX_IOPAD(0x0e8, PIN_OUTPUT, 0) /* (W20) VOUT0_DATA12 */
+			AM62AX_IOPAD(0x0ec, PIN_OUTPUT, 0) /* (W19) VOUT0_DATA13 */
+			AM62AX_IOPAD(0x0f0, PIN_OUTPUT, 0) /* (Y21) VOUT0_DATA14 */
+			AM62AX_IOPAD(0x0f4, PIN_OUTPUT, 0) /* (Y22) VOUT0_DATA15 */
+			AM62AX_IOPAD(0x05c, PIN_OUTPUT, 1) /* (P22) GPMC0_AD8.VOUT0_DATA16 */
+			AM62AX_IOPAD(0x060, PIN_OUTPUT, 1) /* (R19) GPMC0_AD9.VOUT0_DATA17 */
+			AM62AX_IOPAD(0x064, PIN_OUTPUT, 1) /* (R20) GPMC0_AD10.VOUT0_DATA18 */
+			AM62AX_IOPAD(0x068, PIN_OUTPUT, 1) /* (R22) GPMC0_AD11.VOUT0_DATA19 */
+			AM62AX_IOPAD(0x06c, PIN_OUTPUT, 1) /* (T22) GPMC0_AD12.VOUT0_DATA20 */
+			AM62AX_IOPAD(0x070, PIN_OUTPUT, 1) /* (R21) GPMC0_AD13.VOUT0_DATA21 */
+			AM62AX_IOPAD(0x074, PIN_OUTPUT, 1) /* (T20) GPMC0_AD14.VOUT0_DATA22 */
+			AM62AX_IOPAD(0x078, PIN_OUTPUT, 1) /* (T21) GPMC0_AD15.VOUT0_DATA23 */
+		>;
+	};
+
 	main_uart0_pins_default: main-uart0-default-pins {
 		pinctrl-single,pins = <
 			AM62AX_IOPAD(0x1c8, PIN_INPUT, 0) /* (E14) UART0_RXD */
@@ -466,6 +511,36 @@ exp2: gpio@23 {
 				  "CSI_EN", "AUTO_100M_1000M_CONFIG",
 				  "CSI_VLDO_SEL", "SoC_WLAN_SDIO_RST";
 	};
+
+	sii9022: bridge-hdmi@3b {
+		compatible = "sil,sii9022";
+		reg = <0x3b>;
+		interrupt-parent = <&exp1>;
+		interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
+		#sound-dai-cells = <0>;
+		sil,i2s-data-lanes = < 0 >;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				sii9022_in: endpoint {
+					remote-endpoint = <&dpi1_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				sii9022_out: endpoint {
+					remote-endpoint = <&hdmi_connector_in>;
+				};
+			};
+		};
+	};
 };
 
 &main_i2c2 {
@@ -583,3 +658,20 @@ &mcasp1 {
 	tx-num-evt = <32>;
 	rx-num-evt = <32>;
 };
+
+&dss {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_dss0_pins_default>;
+};
+
+&dss_ports {
+	/* VP2: DPI Output */
+	port@1 {
+		reg = <1>;
+
+		dpi1_out: endpoint {
+			remote-endpoint = <&sii9022_in>;
+		};
+	};
+};
-- 
2.34.1


