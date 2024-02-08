Return-Path: <linux-kernel+bounces-58059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFB084E0B7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B156B242C1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D0876C61;
	Thu,  8 Feb 2024 12:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FzsTaQP1"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3700C76417;
	Thu,  8 Feb 2024 12:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707395589; cv=none; b=ld5LtikUGjZ/nRqA0YmMCr3JT680jAyetD43X1uV9Ec5OGWp8c5e+dNM9d/HR23eDv7V+mAyB5AbtQtsBVOiAemMYnzc3OmBBlA04HLRRPhvrT18W+HqdIMmM1M+IzOU80N+NDmQgJjHZwk/AYdjbRyMEnTJ2sSipM4cgqAPVRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707395589; c=relaxed/simple;
	bh=Why4EhsxOt20QhCY6d+vHjxblvfPLXy6lz/IxktAIUU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z3QKmfUtCErgiRfZtesWAmh2stXcVv2jFNYp2DoI8CM77Pw89KHdu9IDOLmmjnCQjfeLqpJHQAyOzPtcVJR5FSXQ+/9CmXmyEZuM0kAzaxzHrGhGk/lzPoSZE3dZhdwrUOfSMjqKvfpYm+r9EkptLNBu+UdlGdv8SKxS3R1rN5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FzsTaQP1; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 418CX0Bx070508;
	Thu, 8 Feb 2024 06:33:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707395580;
	bh=DKc02HWWYR0dDZx5Q7Pl0JplrS5pqsrVKOK5fBskcAI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=FzsTaQP1MXADdEkV0hyTkR6HTGk6sGMwKftJKBI1mBm7NhtMnhtrUqlTnuX8iIGuH
	 V326lF5HBzpsHCk0X9o13NvKbA+Tp/bsCQnGmJjAChmf1F1FJH3ybPV5adc5c9XvnK
	 /tmg42sUvwlo5bbXQkrGUgRqnMUIIil3IOa1xGYE=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 418CX07J013667
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Feb 2024 06:33:00 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Feb 2024 06:32:59 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Feb 2024 06:32:59 -0600
Received: from uda0490681.. ([10.24.69.142])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 418CWY1M074789;
	Thu, 8 Feb 2024 06:32:56 -0600
From: Vaishnav Achath <vaishnav.a@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <kernel@pengutronix.de>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vaishnav.a@ti.com>, <u-kumar1@ti.com>, <j-choudhary@ti.com>,
        <j-luthra@ti.com>, <afd@ti.com>
Subject: [PATCH v3 5/9] arm64: dts: ti: k3-j721e-sk: Model CSI2RX connector mux
Date: Thu, 8 Feb 2024 18:02:29 +0530
Message-ID: <20240208123233.391115-6-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208123233.391115-1-vaishnav.a@ti.com>
References: <20240208123233.391115-1-vaishnav.a@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

J721E SK has the CSI2RX routed to a MIPI CSI connector and to 15-pin
RPi camera connector through an analog mux with GPIO control, model that
so that an overlay can control the mux state according to connected
cameras. Also provide labels to the I2C mux bus instances so that a
generic overlay can be used across multiple platforms.

J721E SK schematics: https://www.ti.com/lit/zip/sprr438

Reviewed-by: Jai Luthra <j-luthra@ti.com>
Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
---

V1->V2: Update commit message with schematics.

 arch/arm64/boot/dts/ti/k3-j721e-sk.dts | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
index 6950b1ff124f..5dbc85bc5038 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
@@ -286,6 +286,15 @@ tfp410_out: endpoint {
 			};
 		};
 	};
+
+	csi_mux: mux-controller {
+		compatible = "gpio-mux";
+		#mux-state-cells = <1>;
+		mux-gpios = <&main_gpio0 88 GPIO_ACTIVE_HIGH>;
+		idle-state = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&main_csi_mux_sel_pins_default>;
+	};
 };
 
 &main_pmx0 {
@@ -352,6 +361,12 @@ J721E_IOPAD(0x214, PIN_OUTPUT, 4) /* (V4) MCAN1_TX.USB1_DRVVBUS */
 		>;
 	};
 
+	main_csi_mux_sel_pins_default: main-csi-mux-sel-default-pins {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x164, PIN_OUTPUT, 7) /* (V29) RGMII5_TD2 */
+		>;
+	};
+
 	dp0_pins_default: dp0-default-pins {
 		pinctrl-single,pins = <
 			J721E_IOPAD(0x1c4, PIN_INPUT, 5) /* SPI0_CS1.DP0_HPD */
@@ -858,14 +873,14 @@ i2c-mux@70 {
 		reg = <0x70>;
 
 		/* CSI0 I2C */
-		i2c@0 {
+		cam0_i2c: i2c@0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
 		};
 
 		/* CSI1 I2C */
-		i2c@1 {
+		cam1_i2c: i2c@1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <1>;
-- 
2.34.1


