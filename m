Return-Path: <linux-kernel+bounces-7880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE94D81AEA4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 07:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F162F1C224ED
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 06:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE66BA29;
	Thu, 21 Dec 2023 06:09:51 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CE8AD58;
	Thu, 21 Dec 2023 06:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 33DD31A0230;
	Thu, 21 Dec 2023 07:04:28 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id EDD721A014A;
	Thu, 21 Dec 2023 07:04:27 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 70AC21802201;
	Thu, 21 Dec 2023 14:04:26 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: imx8mm-evk: Add PDM micphone sound card support
Date: Thu, 21 Dec 2023 13:23:07 +0800
Message-Id: <1703136188-7222-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add PDM micphone sound card support, configure the pinmux.

This sound card supports recording sound from PDM micphone
and convert the PDM format data to PCM data.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
index b53104ed8919..9679786dac51 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
@@ -151,6 +151,18 @@ simple-audio-card,codec {
 			clocks = <&clk IMX8MM_CLK_SAI3_ROOT>;
 		};
 	};
+
+	sound-micfil {
+		compatible = "fsl,imx-audio-card";
+		model = "micfil-audio";
+		pri-dai-link {
+			link-name = "micfil hifi";
+			format = "i2s";
+			cpu {
+				sound-dai = <&micfil>;
+			};
+		};
+	};
 };
 
 &A53_0 {
@@ -434,6 +446,16 @@ &lcdif {
 	status = "okay";
 };
 
+&micfil {
+	#sound-dai-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pdm>;
+	assigned-clocks = <&clk IMX8MM_CLK_PDM>;
+	assigned-clock-parents = <&clk IMX8MM_AUDIO_PLL1_OUT>;
+	assigned-clock-rates = <196608000>;
+	status = "okay";
+};
+
 &mipi_csi {
 	status = "okay";
 
@@ -636,6 +658,18 @@ MX8MM_IOMUXC_GPIO1_IO05_GPIO1_IO5       0x41
 		>;
 	};
 
+	pinctrl_pdm: pdmgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI5_MCLK_SAI5_MCLK        0xd6
+			MX8MM_IOMUXC_SAI5_RXC_PDM_CLK           0xd6
+			MX8MM_IOMUXC_SAI5_RXFS_SAI5_RX_SYNC     0xd6
+			MX8MM_IOMUXC_SAI5_RXD0_PDM_DATA0        0xd6
+			MX8MM_IOMUXC_SAI5_RXD1_PDM_DATA1        0xd6
+			MX8MM_IOMUXC_SAI5_RXD2_PDM_DATA2        0xd6
+			MX8MM_IOMUXC_SAI5_RXD3_PDM_DATA3        0xd6
+		>;
+	};
+
 	pinctrl_pmic: pmicirqgrp {
 		fsl,pins = <
 			MX8MM_IOMUXC_GPIO1_IO03_GPIO1_IO3		0x141
-- 
2.34.1


