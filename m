Return-Path: <linux-kernel+bounces-57632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 381B084DBA5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0DDF1F23B5D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1055C6A8C0;
	Thu,  8 Feb 2024 08:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="H4jkpW+T"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6A76A8A0;
	Thu,  8 Feb 2024 08:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707381811; cv=none; b=FC7pbct0mkd/xFC/jd304vyD0Of4qNCy4ZADH6RbkQO4v94ZszFKMgqSqOOeEaEUt2xr4yPgvjQdvCpF1LXrSR0N933FheN5zgdb1rXiC9bWaMlIsPjjEbcvQyzx5W4vSWH6FdlRkvRnQV8+3hI1efRE86IbriqS9pudyWO2YWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707381811; c=relaxed/simple;
	bh=Bfg1oBdtSZWyL8lcck/OpMk2x5IZYqY6A91ia++vhW4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FThoh4EJq0MDGqBM54+jUT9natStXBQCoOq8dZI6KSKAnzWGaIcIwN/XRDwqEPUgMJZVHXjZQHY7NcChQrfB36W7VKGU79O0YNOBEn+4zT7kNLMi3ddErKrnJY61eD4phs5LE102ABT37VOAtjYZG/f5ljHD4ERWq5sLTwUHwWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=H4jkpW+T; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4188hKt6105070;
	Thu, 8 Feb 2024 02:43:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707381800;
	bh=CM6cjKv4l0J1fKXCqPw6lqdbgZjYConNlvuzN5ok03E=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=H4jkpW+TRMDQ/usc+d0k4BNCzGJRX/FGnzMJZ1ivhIt/PzKtspOZdmeGfKVY63MjY
	 BLBZdA3HNDNTqaMiQsmobHTL5QEICfpySH/LEEcKn9CYicMdWiQPaBQOD6XkVjCG24
	 9nCj6KahJlxCiXnlpY+Yvlyyp/CSqnqSQo5GSBPo=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4188hKk0031524
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Feb 2024 02:43:20 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Feb 2024 02:43:20 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Feb 2024 02:43:20 -0600
Received: from uda0490681.. ([10.24.69.142])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4188gshP097884;
	Thu, 8 Feb 2024 02:43:16 -0600
From: Vaishnav Achath <vaishnav.a@ti.com>
To: <vigneshr@ti.com>, <nm@ti.com>, <conor+dt@kernel.org>, <kristo@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>
CC: <j-luthra@ti.com>, <devicetree@vger.kernel.org>, <j-choudhary@ti.com>,
        <kernel@pengutronix.de>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>, <vaishnav.a@ti.com>,
        <afd@ti.com>
Subject: [PATCH v2 5/9] arm64: dts: ti: k3-j721e-sk: Model CSI2RX connector mux
Date: Thu, 8 Feb 2024 14:12:50 +0530
Message-ID: <20240208084254.295289-6-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208084254.295289-1-vaishnav.a@ti.com>
References: <20240208084254.295289-1-vaishnav.a@ti.com>
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


