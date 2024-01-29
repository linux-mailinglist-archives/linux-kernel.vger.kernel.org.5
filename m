Return-Path: <linux-kernel+bounces-42800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A398406E9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54DCC1C232DC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE1F65BC9;
	Mon, 29 Jan 2024 13:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TH66M8aT"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7B9657D6;
	Mon, 29 Jan 2024 13:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706534895; cv=none; b=j6Pg3Px9rO6lp1vpxKfbrSe6DbbjSyI2FlT0fU0nHsGX3Us7ZMYfMSHTJ5ZqaLw/gqIagKeGuk5Ju5qdpjpcVAbSpqAk5F73VR2vFX6XD6zrq3JJlsSZWQvbbzmXYwHYafsyaXhiiFtsZ793sSCqcmLi7Osua1iBPhDDn+u+1Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706534895; c=relaxed/simple;
	bh=VuVPliekWwmt+9SJI8lBABu6PmNHMZjrnmXnsVX6XLA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sPyBO2uADCtmiT4AD0uW+TC56UGthH3iHnfE8BmJ5oYikLHlmPq6zgRWNKibpIYtpMO93FrgGkBh6UYGU2Dvd7XStUgDFM0Zxg7Iy3oxnmg0GMfVaWkVRirZs0U1ehqgm1mtbpHJ8zgnCZi6Q+dN9VYj13VZ0alVZnkBhqVoqJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=TH66M8aT; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40TDS6cC121887;
	Mon, 29 Jan 2024 07:28:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706534887;
	bh=IgWBdogY6EoIsZfBsUtUXLHq1/oH12SplQ9w+sfCd9U=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=TH66M8aTvN7hIwEtPNM6J9lhiE641fFP6RMyYkSCX5jcsp72l32rqWFythTd1UFqx
	 BzhA4UKYkgBlNQWvCf5PKFC/KXt1tBDjjM508YdGuCnE/ovCnm41YzO4ryfdwhz6jM
	 ylLPI96eKBLvZBAoG7DPHT4dpGuKq9OOv4we+8G0=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40TDS6IL027062
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Jan 2024 07:28:06 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Jan 2024 07:28:06 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Jan 2024 07:28:06 -0600
Received: from uda0490681.dhcp.ti.com ([10.24.69.142])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40TDRg9F036720;
	Mon, 29 Jan 2024 07:28:02 -0600
From: Vaishnav Achath <vaishnav.a@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <kernel@pengutronix.de>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vaishnav.a@ti.com>, <u-kumar1@ti.com>, <j-choudhary@ti.com>,
        <j-luthra@ti.com>
Subject: [PATCH 5/9] arm64: dts: ti: k3-j721e-sk: Model CSI2RX connector mux
Date: Mon, 29 Jan 2024 18:57:38 +0530
Message-ID: <20240129132742.1189783-6-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129132742.1189783-1-vaishnav.a@ti.com>
References: <20240129132742.1189783-1-vaishnav.a@ti.com>
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

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
index 188dfe291a32..4c9c27380d4f 100644
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


