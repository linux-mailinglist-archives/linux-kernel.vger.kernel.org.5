Return-Path: <linux-kernel+bounces-19221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E04B8269F7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36E2F283B22
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 08:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE2EDDCD;
	Mon,  8 Jan 2024 08:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="dT6Z9Tj8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD71DDCF;
	Mon,  8 Jan 2024 08:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BA0DBC00F4;
	Mon,  8 Jan 2024 09:51:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1704703875; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=oeyirk30VzrJwXs/jPqp36nZYKhhaMWlQBYYBY4oDRg=;
	b=dT6Z9Tj8rXvxOSxZcRTAlHvCdHt4QhOVjFnuomBrKVqb35FVLrEX2b73AcSTSWgmCqBwD8
	1xyZbvgaL9Q6CYW8MbfkNuAAlXo/KbR1hiN8dX+hd8pfajJDBXAD03FHPxC0yzYCa9fv6M
	n8MgKB+PrB5hmiUNSpmAJ7BoPilWvSXotD/7/EUnkMBR82dWzlmHexiDXjpsltV30gikwU
	Ck4WZKVHzuC44tKO9N7D8a/xXrIQ4NaHJRcPta0buJIv/42VGLldgk5U+jvXKiiqcCEIo6
	LcSogElLqAXW7aQG7RIg9VfuuevCLz2mv2IwqBgE5yQNMFd90vv4C2GhneJAYQ==
From: Frieder Schrempf <frieder@fris.de>
To: Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v4 03/12] arm64: dts: imx8mm-kontron: Disable pullups for onboard UART signals on BL OSM-S board
Date: Mon,  8 Jan 2024 09:49:00 +0100
Message-ID: <20240108084945.75356-4-frieder@fris.de>
In-Reply-To: <20240108084945.75356-1-frieder@fris.de>
References: <20240108084945.75356-1-frieder@fris.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Frieder Schrempf <frieder.schrempf@kontron.de>

These signals are actively driven by the SoC or by the onboard
transceiver. There's no need to enable the internal pull resistors
and due to silicon errata ERR050080 let's disable the internal ones
to prevent any unwanted behavior in case they wear out.

Fixes: de9618e84f76 ("arm64: dts: Add support for Kontron SL/BL i.MX8MM OSM-S")
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
Changes for v3:
* none

Changes for v2:
* none
---
 .../dts/freescale/imx8mm-kontron-bl-osm-s.dts    | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dts b/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dts
index 0730c22e5b6b9..1dd03ef0a7835 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dts
@@ -313,19 +313,19 @@ MX8MM_IOMUXC_SAI5_MCLK_GPIO3_IO25		0x19
 
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
-			MX8MM_IOMUXC_SAI2_RXC_UART1_DCE_RX		0x140
-			MX8MM_IOMUXC_SAI2_RXFS_UART1_DCE_TX		0x140
-			MX8MM_IOMUXC_SAI2_RXD0_UART1_DCE_RTS_B		0x140
-			MX8MM_IOMUXC_SAI2_TXFS_UART1_DCE_CTS_B		0x140
+			MX8MM_IOMUXC_SAI2_RXC_UART1_DCE_RX		0x0
+			MX8MM_IOMUXC_SAI2_RXFS_UART1_DCE_TX		0x0
+			MX8MM_IOMUXC_SAI2_RXD0_UART1_DCE_RTS_B		0x0
+			MX8MM_IOMUXC_SAI2_TXFS_UART1_DCE_CTS_B		0x0
 		>;
 	};
 
 	pinctrl_uart2: uart2grp {
 		fsl,pins = <
-			MX8MM_IOMUXC_SAI3_TXFS_UART2_DCE_RX		0x140
-			MX8MM_IOMUXC_SAI3_TXC_UART2_DCE_TX		0x140
-			MX8MM_IOMUXC_SAI3_RXD_UART2_DCE_RTS_B		0x140
-			MX8MM_IOMUXC_SAI3_RXC_UART2_DCE_CTS_B		0x140
+			MX8MM_IOMUXC_SAI3_TXFS_UART2_DCE_RX		0x0
+			MX8MM_IOMUXC_SAI3_TXC_UART2_DCE_TX		0x0
+			MX8MM_IOMUXC_SAI3_RXD_UART2_DCE_RTS_B		0x0
+			MX8MM_IOMUXC_SAI3_RXC_UART2_DCE_CTS_B		0x0
 		>;
 	};
 
-- 
2.43.0


