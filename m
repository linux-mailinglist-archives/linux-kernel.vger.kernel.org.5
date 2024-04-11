Return-Path: <linux-kernel+bounces-141565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8A58A2008
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 22:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17BA92843C1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD0C17C9E;
	Thu, 11 Apr 2024 20:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WqZ52UBq"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E5617C6A;
	Thu, 11 Apr 2024 20:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712866688; cv=none; b=XLZGXQ1393AOv/qTPPaKbHkqFejSYJ/TOUhYgRL/l3HjgQzE9tf4prT9shmsR4keJNOKbwnkmJ+30GP02qreCNS6DV0ip5+hwqxnJKtRyqyEZz4OOV4XzsswqefTRJzNjptUALi/JpONbpZWiIw+Tn6rPvxNICEW2mSlc7eoNPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712866688; c=relaxed/simple;
	bh=Dkxz0oOJhLLiLmdJabYuZs91XvVvYDFVsDL9pIpUZ0Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JssRJ/501yRHFxB1SbINZFtkWeoJmAlK11yWgUvh1sUrTpdP22lKSdSeVFx1Wml2cdZ/hVvrDuWIPlj+jfB6h9vTjJ1wpUujXHtYbHEEwkjUquN3frAktR2G7Zh83xsh2yiOHqaOwAtqsXyXtp6QaNgY6Zw1KSmgH86QEbp3UAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WqZ52UBq; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43BKHoOc073858;
	Thu, 11 Apr 2024 15:17:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712866670;
	bh=Ny804HOoYc6ylEytgO4kim26aktoBtQvjAQvIOKhzoQ=;
	h=From:To:CC:Subject:Date;
	b=WqZ52UBqTpyjrFdP/0faL0a3VK/pOcosa+hHzgGtvNzHFEzFayhM1ST+F4mn8Metu
	 xwHDwj5shSBegOx8yel4Ld06pTj/FU6o9Yds99oNmAWt35q7+6kTznMjhizfcE23zA
	 TrrjbT9X0X/7eJdQruooXGVOCTAtujw2+ftuV5R8=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43BKHoTi016398
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 11 Apr 2024 15:17:50 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 11
 Apr 2024 15:17:49 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 11 Apr 2024 15:17:49 -0500
Received: from localhost ([10.249.131.201])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43BKHmwx115633;
	Thu, 11 Apr 2024 15:17:49 -0500
From: Bhavya Kapoor <b-kapoor@ti.com>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <b-kapoor@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <conor+dt@kernel.org>, <krzk+dt@kernel.org>, <robh@kernel.org>,
        <kristo@kernel.org>, <vigneshr@ti.com>, <nm@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-j784s4-evm: Add support for multiple CAN instances
Date: Fri, 12 Apr 2024 01:47:47 +0530
Message-ID: <20240411201747.18697-1-b-kapoor@ti.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

CAN instances 0 and 1 in the mcu domain and 16 in the main domain are
brought on the evm through headers J42, J43 and J46 respectively. Thus,
add their respective transceiver's 0, 1 and 2 dt nodes to add support
for these CAN instances.

CAN instance 4 in the main domain is brought on the evm through header
J45. The CAN High and Low lines from the SoC are routed through a mux
on the evm. The select lines need to be set for the CAN signals to
reach to its transceiver on the evm. Therefore, add transceiver 3
dt node to add support for this CAN instance.

Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
---

rebased to next-20240411

 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 107 +++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
index 81fd7afac8c5..e56901973895 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
@@ -272,6 +272,45 @@ dp0_connector_in: endpoint {
 			};
 		};
 	};
+
+	transceiver0: can-phy0 {
+		compatible = "ti,tcan1042";
+		#phy-cells = <0>;
+		max-bitrate = <5000000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&mcu_mcan0_gpio_pins_default>;
+		standby-gpios = <&wkup_gpio0 69 GPIO_ACTIVE_HIGH>;
+	};
+
+	transceiver1: can-phy1 {
+		compatible = "ti,tcan1042";
+		#phy-cells = <0>;
+		max-bitrate = <5000000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&mcu_mcan1_gpio_pins_default>;
+		standby-gpios = <&wkup_gpio0 2 GPIO_ACTIVE_HIGH>;
+	};
+
+	transceiver2: can-phy2 {
+		/* standby pin has been grounded by default */
+		compatible = "ti,tcan1042";
+		#phy-cells = <0>;
+		max-bitrate = <5000000>;
+	};
+
+	transceiver3: can-phy3 {
+		compatible = "ti,tcan1042";
+		#phy-cells = <0>;
+		max-bitrate = <5000000>;
+		standby-gpios = <&exp2 7 GPIO_ACTIVE_HIGH>;
+		mux-states = <&mux1 1>;
+	};
+
+	mux1: mux-controller {
+		compatible = "gpio-mux";
+		#mux-state-cells = <1>;
+		mux-gpios = <&exp2 14 GPIO_ACTIVE_HIGH>;
+	};
 };
 
 &wkup_gpio0 {
@@ -336,6 +375,20 @@ J784S4_IOPAD(0x014, PIN_INPUT_PULLUP, 8) /* (AG33) MCAN14_TX.I2C4_SCL */
 			J784S4_IOPAD(0x010, PIN_INPUT_PULLUP, 8) /* (AH33) MCAN13_RX.I2C4_SDA */
 		>;
 	};
+
+	main_mcan4_pins_default: main-mcan4-default-pins {
+		pinctrl-single,pins = <
+			J784S4_IOPAD(0x088, PIN_INPUT, 0) /* (AF36) MCAN4_RX */
+			J784S4_IOPAD(0x084, PIN_OUTPUT, 0) /* (AG38) MCAN4_TX */
+		>;
+	};
+
+	main_mcan16_pins_default: main-mcan16-default-pins {
+		pinctrl-single,pins = <
+			J784S4_IOPAD(0x028, PIN_INPUT, 0) /* (AE33) MCAN16_RX */
+			J784S4_IOPAD(0x024, PIN_OUTPUT, 0) /* (AH34) MCAN16_TX */
+		>;
+	};
 };
 
 &wkup_pmx2 {
@@ -415,6 +468,32 @@ J784S4_WKUP_IOPAD(0x104, PIN_INPUT, 0) /* (U33) MCU_ADC1_AIN6 */
 			J784S4_WKUP_IOPAD(0x108, PIN_INPUT, 0) /* (Y36) MCU_ADC1_AIN7 */
 		>;
 	};
+
+	mcu_mcan0_pins_default: mcu-mcan0-default-pins {
+		pinctrl-single,pins = <
+			J784S4_WKUP_IOPAD(0x050, PIN_OUTPUT, 0) /* (K33) MCU_MCAN0_TX */
+			J784S4_WKUP_IOPAD(0x054, PIN_INPUT, 0) /* (F38) MCU_MCAN0_RX */
+		>;
+	};
+
+	mcu_mcan1_pins_default: mcu-mcan1-default-pins {
+		pinctrl-single,pins = <
+			J784S4_WKUP_IOPAD(0x068, PIN_OUTPUT, 0) /* (H35) WKUP_GPIO0_4.MCU_MCAN1_TX */
+			J784S4_WKUP_IOPAD(0x06c, PIN_INPUT, 0) /* (K36) WKUP_GPIO0_5.MCU_MCAN1_RX */
+		>;
+	};
+
+	mcu_mcan0_gpio_pins_default: mcu-mcan0-gpio-default-pins {
+		pinctrl-single,pins = <
+			J784S4_WKUP_IOPAD(0x040, PIN_INPUT, 7) /* (J38) MCU_SPI0_D1.WKUP_GPIO0_69 */
+		>;
+	};
+
+	mcu_mcan1_gpio_pins_default: mcu-mcan1-gpio-default-pins {
+		pinctrl-single,pins = <
+			J784S4_WKUP_IOPAD(0x060, PIN_INPUT, 7) /* (J35) WKUP_GPIO0_2 */
+		>;
+	};
 };
 
 &wkup_pmx1 {
@@ -1105,3 +1184,31 @@ dp0_out: endpoint {
 		};
 	};
 };
+
+&mcu_mcan0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_mcan0_pins_default>;
+	phys = <&transceiver0>;
+};
+
+&mcu_mcan1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_mcan1_pins_default>;
+	phys = <&transceiver1>;
+};
+
+&main_mcan16 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mcan16_pins_default>;
+	phys = <&transceiver2>;
+};
+
+&main_mcan4 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mcan4_pins_default>;
+	phys = <&transceiver3>;
+};
-- 
2.40.1


