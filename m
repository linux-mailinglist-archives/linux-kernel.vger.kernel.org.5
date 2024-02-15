Return-Path: <linux-kernel+bounces-66461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D217C855D1A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D820B2FB78
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C9D1B972;
	Thu, 15 Feb 2024 08:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="df8q64KX"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B261B966;
	Thu, 15 Feb 2024 08:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707987354; cv=none; b=YLO+3E+ZTmoNAzqmxofv763r3PigGQUhjTBskZViHmH6YNNQ7TtZ309LF+2C5cA+c/y7jkpuAKKoLKF3xpLoe3SZN4YQ38gjhdVyvJqd2MnU4Xgcvm5GRPEIfiyLjstk6dm9gurqDarJDXa9Vls9wzNjEGtMV5A4padu0KSo1/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707987354; c=relaxed/simple;
	bh=9R3RlAEkv5tEnvMbUFpbKdtp8NCsxDjpOTdVVZNIGXg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qHO6YRbob+Jccjx+WKSJ7gYXFr9hhLlDUNjm13PkcOsgPdaH7FpVYNy0PIm2H6jW1esLkwe+OfVHowqzeo+KVqGO+qULDSKhEraN49BLFI3PuKXZ4u0y9yjnAe2q/P0s4JbE2SpsQswcMKPVuh6YZnIAE6+uI08YrUFk6N66rnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=df8q64KX; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41F8tiF7069239;
	Thu, 15 Feb 2024 02:55:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707987344;
	bh=WftwmOV6VJghVZe5M9HH30MtAUbPXmvOMWm7w3lYE+c=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=df8q64KXHgMSy360SY5t+N7EFLDv1JnhhnGPXCuA3xqKGnX1JbI/8jd0U+dunlkNX
	 7gZ0tONmDq7/wohkoHiA0udJO8lEReS1cO7QVV9wSEHri/wmWwythqNB5/qCSil0p6
	 quko885R6YvS0JMUkYAN8gG99QWy9bh0CmMiku1w=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41F8tidM005058
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 15 Feb 2024 02:55:44 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Feb 2024 02:55:44 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Feb 2024 02:55:44 -0600
Received: from uda0490681.. ([10.24.69.142])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41F8tJ7o008333;
	Thu, 15 Feb 2024 02:55:40 -0600
From: Vaishnav Achath <vaishnav.a@ti.com>
To: <vigneshr@ti.com>, <nm@ti.com>, <conor+dt@kernel.org>, <kristo@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>
CC: <j-luthra@ti.com>, <devicetree@vger.kernel.org>, <j-choudhary@ti.com>,
        <kernel@pengutronix.de>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>, <vaishnav.a@ti.com>,
        <afd@ti.com>
Subject: [PATCH v4 5/9] arm64: dts: ti: k3-j721e-sk: Model CSI2RX connector mux
Date: Thu, 15 Feb 2024 14:25:14 +0530
Message-ID: <20240215085518.552692-6-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215085518.552692-1-vaishnav.a@ti.com>
References: <20240215085518.552692-1-vaishnav.a@ti.com>
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
Reviewed-by: Jai Luthra <j-luthra@ti.com>
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


