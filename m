Return-Path: <linux-kernel+bounces-44374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B4B842115
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D2C91C276B5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B0565BD4;
	Tue, 30 Jan 2024 10:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tbWT3Gsn"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2234A60DCB;
	Tue, 30 Jan 2024 10:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706610064; cv=none; b=Ym6YK3XY/9qHg2amlUgVoDmQgZJI0mXqXheqS+bONfV9TmCSr/GOvWfMOAavUlchPm/rIw73hPkzrq3rPP8rpPsO2IuOsrQLKnX9m9GMm4o3zcO9zhqNCDB/y5/Fjq6gmrqWu5P+utoTCIo0gNaZPwXECcuHZcQSE6NhBGpaqII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706610064; c=relaxed/simple;
	bh=vk+ZJi4fIM6CcYRiuC+wYAKqqIvdK/4Q4UzYq1kb3WU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=laI5QKaLpo/hzacYG6Vk8iB9M5V6erQWrJZYYxyv1q9ns/mbTQziMNk4Cb4pUdDoChs//voL5EashS45HEytOfXGxP2krMgUmjhu9pUIOZfuKXLvoDo3mOuneAPG77Cf0480nuSmrVlfGWKuAWZnjlix8ywyk/nPWMCsmFrp+qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tbWT3Gsn; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40UAKoQg037532;
	Tue, 30 Jan 2024 04:20:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706610050;
	bh=7KtrsNB3Qo53QsHHGjsvqWeZjt3XmDHwVLvllgU1U2U=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=tbWT3GsnyP6tMj8hknqIyMgeIQXCeFe8FCer8fu6gZb3Q3xqKw7CagQ55MiCK1k7S
	 NRK+ZI8IbodDhgWxTL8wPi26+JngyzNvRT7VCbD7qB7yMP1DsUJVQQ8AgII+hrY92r
	 hZyhMzkLMog9Kpze8EhnvpW5hzsIBrHpLWYR1ZNA=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40UAKoeG102454
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Jan 2024 04:20:50 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Jan 2024 04:20:50 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Jan 2024 04:20:50 -0600
Received: from localhost (a0498981-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.216])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40UAKnnh048061;
	Tue, 30 Jan 2024 04:20:49 -0600
From: Bhavya Kapoor <b-kapoor@ti.com>
To: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <b-kapoor@ti.com>
Subject: [PATCH 3/3] arm64: dts: ti: k3-j7200: Add support for multiple CAN instances
Date: Tue, 30 Jan 2024 15:50:44 +0530
Message-ID: <20240130102044.120483-4-b-kapoor@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240130102044.120483-1-b-kapoor@ti.com>
References: <20240130102044.120483-1-b-kapoor@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

CAN instances 0 and 1 in the mcu domain are brought on the common
processor board through headers J30 and J31 respectively. Thus, add
their respective transceivers 1 and 2 dt nodes to add support for
these CAN instances.

CAN instance 3 in the main domain is brought on the common
processor board through header J27. The CAN High and Low lines
from the SoC are routed through a mux on the SoM. The select lines need
to be set for the CAN signals to get connected to the transceiver 3 on
the common processor board. Therefore, add transceiver dt nodes to add
support for this CAN instance.

Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
---
 .../dts/ti/k3-j7200-common-proc-board.dts     | 83 +++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
index cee2b4b0eb87..63b03dc326fa 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
@@ -88,6 +88,34 @@ vdd_sd_dv: gpio-regulator-TLV71033 {
 		states = <1800000 0x0>,
 			 <3300000 0x1>;
 	};
+
+	transceiver1: can-phy1 {
+		compatible = "ti,tcan1043";
+		#phy-cells = <0>;
+		max-bitrate = <5000000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&mcu_mcan0_gpio_pins_default>;
+		standby-gpios = <&wkup_gpio0 58 GPIO_ACTIVE_LOW>;
+		enable-gpios = <&wkup_gpio0 0 GPIO_ACTIVE_HIGH>;
+	};
+
+	transceiver2: can-phy2 {
+		compatible = "ti,tcan1042";
+		#phy-cells = <0>;
+		max-bitrate = <5000000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&mcu_mcan1_gpio_pins_default>;
+		standby-gpios = <&wkup_gpio0 2 GPIO_ACTIVE_HIGH>;
+	};
+
+	transceiver3: can-phy3 {
+		compatible = "ti,tcan1043";
+		#phy-cells = <0>;
+		max-bitrate = <5000000>;
+		standby-gpios = <&exp2 7 GPIO_ACTIVE_LOW>;
+		enable-gpios = <&exp2 6 GPIO_ACTIVE_HIGH>;
+		mux-states = <&mux0 1>;
+	};
 };
 
 &wkup_pmx0 {
@@ -138,6 +166,33 @@ J721E_WKUP_IOPAD(0x0034, PIN_OUTPUT, 0) /* (L1) MCU_MDIO0_MDC */
 			J721E_WKUP_IOPAD(0x0030, PIN_INPUT, 0) /* (L4) MCU_MDIO0_MDIO */
 		>;
 	};
+
+	mcu_mcan0_pins_default: mcu-mcan0-default-pins {
+		pinctrl-single,pins = <
+			J721E_WKUP_IOPAD(0x54, PIN_INPUT, 0) /* (A17) MCU_MCAN0_RX */
+			J721E_WKUP_IOPAD(0x50, PIN_OUTPUT, 0) /* (A16) MCU_MCAN0_TX */
+		>;
+	};
+
+	mcu_mcan1_pins_default: mcu-mcan1-default-pins {
+		pinctrl-single,pins = <
+			J721E_WKUP_IOPAD(0x6c, PIN_INPUT, 0) /* (B16) WKUP_GPIO0_5.MCU_MCAN1_RX */
+			J721E_WKUP_IOPAD(0x68, PIN_OUTPUT, 0) /* (D13) WKUP_GPIO0_4.MCU_MCAN1_TX */
+		>;
+	};
+
+	mcu_mcan0_gpio_pins_default: mcu-mcan0-gpio-default-pins {
+		pinctrl-single,pins = <
+			J721E_WKUP_IOPAD(0x58, PIN_INPUT, 7) /* (B18) WKUP_GPIO0_0 */
+			J721E_WKUP_IOPAD(0x40, PIN_INPUT, 7) /* (B17) MCU_SPI0_D1 */
+		>;
+	};
+
+	mcu_mcan1_gpio_pins_default: mcu-mcan1-gpio-default-pins {
+		pinctrl-single,pins = <
+			J721E_WKUP_IOPAD(0x60, PIN_INPUT, 7) /* (D14) WKUP_GPIO0_2 */
+		>;
+	};
 };
 
 &main_pmx0 {
@@ -189,6 +244,13 @@ vdd_sd_dv_pins_default: vdd-sd-dv-default-pins {
 			J721E_IOPAD(0xd0, PIN_OUTPUT, 7) /* (T5) SPI0_D1.GPIO0_55 */
 		>;
 	};
+
+	main_mcan3_pins_default: main-mcan3-default-pins {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x3c, PIN_INPUT, 0) /* (W16) MCAN3_RX */
+			J721E_IOPAD(0x38, PIN_OUTPUT, 0) /* (Y21) MCAN3_TX */
+		>;
+	};
 };
 
 &main_pmx1 {
@@ -394,3 +456,24 @@ &pcie1_ep {
 	num-lanes = <2>;
 	status = "disabled";
 };
+
+&mcu_mcan0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_mcan0_pins_default>;
+	phys = <&transceiver1>;
+};
+
+&mcu_mcan1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_mcan1_pins_default>;
+	phys = <&transceiver2>;
+};
+
+&main_mcan3 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mcan3_pins_default>;
+	phys = <&transceiver3>;
+};
-- 
2.34.1


