Return-Path: <linux-kernel+bounces-57636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9A784DBAB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33FB21F2465B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3241E6BB30;
	Thu,  8 Feb 2024 08:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GghG1HcG"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A776BB57;
	Thu,  8 Feb 2024 08:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707381818; cv=none; b=lK0XzisAzCE1gBBJjJZ/pd9S7QuPBqDbCAWlKnarM9K+nhKKryt4qoCrNZs4mcTdGVKUQavHdgzAta7MvHT/hE2R9YaHncj3BnhJHdkNuGJMky5bObn51PsRPDoV+ii6ax8K/PernOhY/uuEgc+HSDE5ElVVuopyiAr8UYWx+0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707381818; c=relaxed/simple;
	bh=jRCTiqMoOM2vBas9oi0LctCdNgqdqnnIfm+t3mOLsPQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FkkJC7Yw6lzpSA2YmO9dcfrrpQ/qQod0Jf6ofEi+Ia77p2qPdT4ETFXWSvVVKFqM/fDYim5ZZ/cFiHDvndPDXiH+ntbr+7x5pSJRMpwc+sDDjAsMkM5lGXmi2YK4p/Z4g6WGfEMae9ug+0XzmScjZz25e2/K/6cy17f+nZjPEb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GghG1HcG; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4188h4pT020564;
	Thu, 8 Feb 2024 02:43:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707381784;
	bh=MBTaZvVU6myFQ58971FQ6KtPWCe15bi6ZmCInBGSJjs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=GghG1HcGBnyc1FcmzLuqM5w/qgZtjHPiX82fNo6FI1xK0sinvJlC7GyV3SHyhMVJi
	 VfYgL/JD+J642RuCa0by2tl2D4QdCo2Ck2DNlp2Ns4qzC6IRtQmOLagfBZga3XvTf9
	 Xyk0tbB5fC2Vnoyr9XBgB/tDmqvkCUM8NFk+X2GE=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4188h4SY031265
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Feb 2024 02:43:04 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Feb 2024 02:43:03 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Feb 2024 02:43:03 -0600
Received: from uda0490681.. ([10.24.69.142])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4188gshL097884;
	Thu, 8 Feb 2024 02:42:59 -0600
From: Vaishnav Achath <vaishnav.a@ti.com>
To: <vigneshr@ti.com>, <nm@ti.com>, <conor+dt@kernel.org>, <kristo@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>
CC: <j-luthra@ti.com>, <devicetree@vger.kernel.org>, <j-choudhary@ti.com>,
        <kernel@pengutronix.de>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>, <vaishnav.a@ti.com>,
        <afd@ti.com>
Subject: [PATCH v2 1/9] arm64: dts: ti: k3-j721s2-common-proc-board: Enable camera peripherals
Date: Thu, 8 Feb 2024 14:12:46 +0530
Message-ID: <20240208084254.295289-2-vaishnav.a@ti.com>
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

CSI cameras are controlled using I2C. On J721S2 Common Processor Board,
this is routed to I2C-5, so enable the instance and the TCA6408
GPIO expander on the bus.

Common Processor Board schematics: https://www.ti.com/lit/zip/sprr411
J721S2 SoM schematics: https://www.ti.com/lit/zip/sprr439

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
---

V1->V2: Update commit message with schematics.

 .../dts/ti/k3-j721s2-common-proc-board.dts    | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
index 361365bb5523..5631735c9b7a 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
@@ -147,6 +147,13 @@ J721S2_IOPAD(0x060, PIN_INPUT_PULLUP, 13) /* (AC27) MCASP2_AXR1.I2C3_SDA */
 		>;
 	};
 
+	main_i2c5_pins_default: main-i2c5-default-pins {
+		pinctrl-single,pins = <
+			J721S2_IOPAD(0x01c, PIN_INPUT, 8) /* (Y24) MCAN15_TX.I2C5_SCL */
+			J721S2_IOPAD(0x018, PIN_INPUT, 8) /* (W23) MCAN14_RX.I2C5_SDA */
+		>;
+	};
+
 	main_mmc1_pins_default: main-mmc1-default-pins {
 		pinctrl-single,pins = <
 			J721S2_IOPAD(0x104, PIN_INPUT, 0) /* (P23) MMC1_CLK */
@@ -356,6 +363,24 @@ exp2: gpio@22 {
 	};
 };
 
+&main_i2c5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c5_pins_default>;
+	clock-frequency = <400000>;
+	status = "okay";
+
+	exp5: gpio@20 {
+		compatible = "ti,tca6408";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names = "CSI2_EXP_RSTZ", "CSI2_EXP_A_GPIO0",
+				  "CSI2_EXP_A_GPIO1", "CSI2_EXP_A_GPIO2",
+				  "CSI2_EXP_B_GPIO1", "CSI2_EXP_B_GPIO2",
+				  "CSI2_EXP_B_GPIO3", "CSI2_EXP_B_GPIO4";
+	};
+};
+
 &main_sdhci0 {
 	/* eMMC */
 	status = "okay";
-- 
2.34.1


