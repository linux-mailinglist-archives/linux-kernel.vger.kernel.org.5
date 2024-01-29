Return-Path: <linux-kernel+bounces-42797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 032B38406E3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 355FC1C20849
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD76464CFD;
	Mon, 29 Jan 2024 13:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TglEwKbk"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812A564CF2;
	Mon, 29 Jan 2024 13:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706534888; cv=none; b=iFwiQqNUy17hvQpmT+SyhmfXyq52tWI6nZqULrO1A0NYnkBCvpPpnlGqGFg2ACeL0o6++Hyni+WSpGXMTFAHnh44c3CExBNmvKRkMqUD51R2u9j9W71aZY6+lXvrAQEa230gZn4AVJCvCrOO7sXf2kL4lAjZJgah9xHIB8WksoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706534888; c=relaxed/simple;
	bh=PzRum05WJBEAtfVXlzNTexT85/oHBqxSDdfjfjRkYtQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kSwQ7+xViro5ySv5MMqkMwb097Bc2mBFB+784VnwRVv1GKmSZl1z46dAzLKhXbqWn+I2JQDh+9iM7DTnjWpJMCG7/laF9jGWy40QvM69zcfmeD4a97LORexzRNkDoy8v75t9X34RTGCP4s/yHUsDK0CS9r5u+39qWRijb4pABGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=TglEwKbk; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40TDRtt7061327;
	Mon, 29 Jan 2024 07:27:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706534875;
	bh=7u2ok9UCDcp3lm7iyhIbUl0GMnjjDzcynRjIwuMcowc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=TglEwKbk+5j9+kjN4vXvSEQ0CJQ5NUbUDgLnt586JNWjz52lypMau3umQyB5lw4Dc
	 2UThm6NyZgO6/4OEbRob5sMvuojkprAxLKKIUcOB9DmHKcsTZ0ejzPp7mV2HNw7EQj
	 HivxD7/GjjnS+x1Yk9InQ8tejiQwcW/+N9i0jGRk=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40TDRtoX000919
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Jan 2024 07:27:55 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Jan 2024 07:27:54 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Jan 2024 07:27:54 -0600
Received: from uda0490681.dhcp.ti.com ([10.24.69.142])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40TDRg9C036720;
	Mon, 29 Jan 2024 07:27:51 -0600
From: Vaishnav Achath <vaishnav.a@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <kernel@pengutronix.de>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vaishnav.a@ti.com>, <u-kumar1@ti.com>, <j-choudhary@ti.com>,
        <j-luthra@ti.com>
Subject: [PATCH 2/9] arm64: dts: ti: k3-j784s4-evm: Enable camera peripherals
Date: Mon, 29 Jan 2024 18:57:35 +0530
Message-ID: <20240129132742.1189783-3-vaishnav.a@ti.com>
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

CSI cameras are controlled using I2C. On J784S4 EVM, this is routed
to I2C-5, so enable the instance and the TCA6408 GPIO expander
on the bus.

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 25 ++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
index f34b92acc56d..52fd7071ffd7 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
@@ -296,6 +296,13 @@ J784S4_IOPAD(0x0e4, PIN_INPUT_PULLUP, 0) /* (AP37) I2C0_SDA */
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
@@ -760,6 +767,24 @@ exp2: gpio@22 {
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


