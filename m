Return-Path: <linux-kernel+bounces-57633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDB284DBA6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF7CB284371
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A676A8D2;
	Thu,  8 Feb 2024 08:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ODsLE5yD"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACE86A8A9;
	Thu,  8 Feb 2024 08:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707381811; cv=none; b=GSrDquuCm6ReosBwzlY7ElS85236ioKKEl6gb67q9lpvcD9XfBZ2EAQKinQ08oX309UosZ6kuf101ne1eniwfz0Bb1Syz+QTZ47fLu7vETaZ+FNTaKWj35Mry8x21DxlR5fv2DNEvKeVwjh7cWTq+VYuNpIlopCbKz5ReDAxQFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707381811; c=relaxed/simple;
	bh=+aNi52R66tEkJ5qtEomMdixTK7yA8vNGdrZlpkthNQg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YpNY5FxHsspcKJEw/WjlGZVuNW87l/rllbFtEOOdnDAHQoSBJJ+2jfzSQgJlfVMUQYYfGbhx9irEik+Rxfsa3M7M3is+9vqhl7bOgZbG9D7g3h7O+12+Uu2AxcY930/9FDNoa3XOyGFaopIMnYwM6f8C8hpNIlONbAZpHfzrTxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ODsLE5yD; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4188h8Sf105044;
	Thu, 8 Feb 2024 02:43:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707381788;
	bh=Ja71EasRRzr/RjhKuh+9EXL1qoKYEN0T/N6Ly83yc8U=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ODsLE5yD2VIloyK3sD5T26gzJLjxC6TloC3BUGjtdWsU0+mirkwFUVYDruOnTJsin
	 +eCVDRshGosOfqgXtPG4bcgsRxOGm2925Y7EAgGKmuHXp+Sep06kDBAgpMS3UcHqT5
	 nQA/KLHbf4ZOgC1/xOj+sxfkntKNFWji6tQ81WxI=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4188h8Pc031335
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Feb 2024 02:43:08 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Feb 2024 02:43:07 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Feb 2024 02:43:07 -0600
Received: from uda0490681.. ([10.24.69.142])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4188gshM097884;
	Thu, 8 Feb 2024 02:43:04 -0600
From: Vaishnav Achath <vaishnav.a@ti.com>
To: <vigneshr@ti.com>, <nm@ti.com>, <conor+dt@kernel.org>, <kristo@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>
CC: <j-luthra@ti.com>, <devicetree@vger.kernel.org>, <j-choudhary@ti.com>,
        <kernel@pengutronix.de>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>, <vaishnav.a@ti.com>,
        <afd@ti.com>
Subject: [PATCH v2 2/9] arm64: dts: ti: k3-j784s4-evm: Enable camera peripherals
Date: Thu, 8 Feb 2024 14:12:47 +0530
Message-ID: <20240208084254.295289-3-vaishnav.a@ti.com>
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

CSI cameras are controlled using I2C. On J784S4 EVM, this is routed
to I2C-5, so enable the instance and the TCA6408 GPIO expander
on the bus.

J784S4 EVM schematics: https://www.ti.com/lit/zip/sprr458

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
---

V1->V2: Update commit message with schematics.

 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 25 ++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
index 57e7cb8ea2b8..bb2558b68381 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
@@ -297,6 +297,13 @@ J784S4_IOPAD(0x0e4, PIN_INPUT_PULLUP, 0) /* (AP37) I2C0_SDA */
 		>;
 	};
 
+	main_i2c5_pins_default: main-i2c5-default-pins {
+		pinctrl-single,pins = <
+			J784S4_IOPAD(0x01c, PIN_INPUT, 8) /* (AG34) MCAN15_TX.I2C5_SCL */
+			J784S4_IOPAD(0x018, PIN_INPUT, 8) /* (AK36) MCAN14_RX.I2C5_SDA */
+		>;
+	};
+
 	main_mmc1_pins_default: main-mmc1-default-pins {
 		bootph-all;
 		pinctrl-single,pins = <
@@ -761,6 +768,24 @@ exp2: gpio@22 {
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
+				  "CSI2_EXP_A_GPIO1", "CSI2_EXP_A_GPIO3",
+				  "CSI2_EXP_B_GPIO1", "CSI2_EXP_B_GPIO2",
+				  "CSI2_EXP_B_GPIO3", "CSI2_EXP_B_GPIO4";
+	};
+};
+
 &main_sdhci0 {
 	bootph-all;
 	/* eMMC */
-- 
2.34.1


