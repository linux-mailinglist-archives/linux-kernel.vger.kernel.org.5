Return-Path: <linux-kernel+bounces-144589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DBE8A4828
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 615811F21D43
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 06:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61F62206E;
	Mon, 15 Apr 2024 06:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="J2i6IY6D"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219EC208CE;
	Mon, 15 Apr 2024 06:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713162858; cv=none; b=bpgy2I6MUL0zY3P5mwq0+2Gx1esK3VXh1/8h1yA15v7kcoFUoilG+I0YxwXVM1svOwhSibVmrix6HKVp25KD0I9ZOWz1m1MjKvT6UlWFUNnna3uJ9EPGJdslnbGQ4l6fPIz3IxWLnoPRKx77IG3f5y0c2MPpidwy419+dFPnswk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713162858; c=relaxed/simple;
	bh=eHhio57cAFSXqNMMzzj+Ywwvd1sJtj4D1p17YZffUQ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=khFK7Ldy4i2hzfIuxmf8QHR0S79vhggNxPOAfAF785G+mpkrDY8mFdI/tonLwu+BS8fO2qjM2JpJ8BrZN2JG3tSL7GcMP8g6+1oL/QlE8GRhfsMeeUDPXct/pmXkey5054sK6mNEjfhIaXmCRsDXb0XtZZhoci6PuYsDZ74IZqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=J2i6IY6D; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43F6Xwkp126565;
	Mon, 15 Apr 2024 01:33:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713162838;
	bh=oiwLY4zNrac1qa9B4AIdqA3PZD7EqIQr+bV0zRFnc8Q=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=J2i6IY6Dzuhbuv+cCuBQ0ET6TpMBLCiE7TxXUzAz2+PneptuEp71nrP+as9CEHt06
	 +a0b7K3X0lBuRn/Z+oVrVM1CeEpVr0nPCVOh78sLCwi+fd5azy2CyaRw8clim/9TmM
	 tsTSdX7YjIyixNQ4zcHUiU9CP/RjKLHAT6NyNUPs=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43F6Xwec049392
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 15 Apr 2024 01:33:58 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 15
 Apr 2024 01:33:57 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 15 Apr 2024 01:33:57 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.18])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43F6Xide065992;
	Mon, 15 Apr 2024 01:33:54 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        Udit Kumar
	<u-kumar1@ti.com>
Subject: [PATCH 3/4] arm64: dts: ti: k3-j7200: Arranging pin mux in order
Date: Mon, 15 Apr 2024 12:03:28 +0530
Message-ID: <20240415063329.3286600-4-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240415063329.3286600-1-u-kumar1@ti.com>
References: <20240415063329.3286600-1-u-kumar1@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Arranging pin mux in order of main_pmx0/1, wkup_pmx0/1/2/3.

Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
 .../dts/ti/k3-j7200-common-proc-board.dts     | 132 +++++++++---------
 arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi   |  31 ++--
 2 files changed, 82 insertions(+), 81 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
index 6593c5da82c0..c53f31fff8d6 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
@@ -118,6 +118,72 @@ transceiver3: can-phy3 {
 	};
 };
 
+&main_pmx0 {
+	main_uart0_pins_default: main-uart0-default-pins {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0xb0, PIN_INPUT, 0) /* (T16) UART0_RXD */
+			J721E_IOPAD(0xb4, PIN_OUTPUT, 0) /* (T17) UART0_TXD */
+			J721E_IOPAD(0xc0, PIN_INPUT, 2) /* (W3) SPI0_CS0.UART0_CTSn */
+			J721E_IOPAD(0xc4, PIN_OUTPUT, 2) /* (U5) SPI0_CS1.UART0_RTSn */
+		>;
+	};
+
+	main_uart1_pins_default: main-uart1-default-pins {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0xb8, PIN_INPUT, 0) /* (T18) UART1_RXD */
+			J721E_IOPAD(0xbc, PIN_OUTPUT, 0) /* (T20) UART1_TXD */
+		>;
+	};
+
+	main_uart3_pins_default: main-uart3-default-pins {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x60, PIN_INPUT, 11) /* (T15) MCAN8_TX.UART3_CTSn */
+			J721E_IOPAD(0x30, PIN_OUTPUT, 11) /* (Y18) MCAN2_TX.UART3_RXD */
+		>;
+	};
+
+	main_i2c1_pins_default: main-i2c1-default-pins {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0xdc, PIN_INPUT_PULLUP, 3) /* (U3) ECAP0_IN_APWM_OUT.I2C1_SCL */
+			J721E_IOPAD(0xe0, PIN_INPUT_PULLUP, 3) /* (T3) EXT_REFCLK1.I2C1_SDA */
+		>;
+	};
+
+	main_mmc1_pins_default: main-mmc1-default-pins {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x104, PIN_INPUT, 0) /* (M20) MMC1_CMD */
+			J721E_IOPAD(0x100, PIN_INPUT, 0) /* (P21) MMC1_CLK */
+			J721E_IOPAD(0xfc, PIN_INPUT, 0) /* (P25) MMC1_CLKLB */
+			J721E_IOPAD(0xf8, PIN_INPUT, 0) /* (M19) MMC1_DAT0 */
+			J721E_IOPAD(0xf4, PIN_INPUT, 0) /* (N21) MMC1_DAT1 */
+			J721E_IOPAD(0xf0, PIN_INPUT, 0) /* (N20) MMC1_DAT2 */
+			J721E_IOPAD(0xec, PIN_INPUT, 0) /* (N19) MMC1_DAT3 */
+			J721E_IOPAD(0xe4, PIN_INPUT, 8) /* (V1) TIMER_IO0.MMC1_SDCD */
+		>;
+	};
+
+	vdd_sd_dv_pins_default: vdd-sd-dv-default-pins {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0xd0, PIN_OUTPUT, 7) /* (T5) SPI0_D1.GPIO0_55 */
+		>;
+	};
+
+	main_mcan3_pins_default: main-mcan3-default-pins {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x3c, PIN_INPUT, 0) /* (W16) MCAN3_RX */
+			J721E_IOPAD(0x38, PIN_OUTPUT, 0) /* (Y21) MCAN3_TX */
+		>;
+	};
+};
+
+&main_pmx1 {
+	main_usbss0_pins_default: main-usbss0-default-pins {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x04, PIN_OUTPUT, 0) /* (T4) USB0_DRVVBUS */
+		>;
+	};
+};
+
 &wkup_pmx0 {
 };
 
@@ -196,72 +262,6 @@ J721E_WKUP_IOPAD(0x60, PIN_INPUT, 7) /* (D14) WKUP_GPIO0_2 */
 	};
 };
 
-&main_pmx0 {
-	main_uart0_pins_default: main-uart0-default-pins {
-		pinctrl-single,pins = <
-			J721E_IOPAD(0xb0, PIN_INPUT, 0) /* (T16) UART0_RXD */
-			J721E_IOPAD(0xb4, PIN_OUTPUT, 0) /* (T17) UART0_TXD */
-			J721E_IOPAD(0xc0, PIN_INPUT, 2) /* (W3) SPI0_CS0.UART0_CTSn */
-			J721E_IOPAD(0xc4, PIN_OUTPUT, 2) /* (U5) SPI0_CS1.UART0_RTSn */
-		>;
-	};
-
-	main_uart1_pins_default: main-uart1-default-pins {
-		pinctrl-single,pins = <
-			J721E_IOPAD(0xb8, PIN_INPUT, 0) /* (T18) UART1_RXD */
-			J721E_IOPAD(0xbc, PIN_INPUT, 0) /* (T20) UART1_TXD */
-		>;
-	};
-
-	main_uart3_pins_default: main-uart3-default-pins {
-		pinctrl-single,pins = <
-			J721E_IOPAD(0x60, PIN_INPUT, 11) /* (T15) MCAN8_TX.UART3_CTSn */
-			J721E_IOPAD(0x30, PIN_INPUT, 11) /* (Y18) MCAN2_TX.UART3_RXD */
-		>;
-	};
-
-	main_i2c1_pins_default: main-i2c1-default-pins {
-		pinctrl-single,pins = <
-			J721E_IOPAD(0xdc, PIN_INPUT_PULLUP, 3) /* (U3) ECAP0_IN_APWM_OUT.I2C1_SCL */
-			J721E_IOPAD(0xe0, PIN_INPUT_PULLUP, 3) /* (T3) EXT_REFCLK1.I2C1_SDA */
-		>;
-	};
-
-	main_mmc1_pins_default: main-mmc1-default-pins {
-		pinctrl-single,pins = <
-			J721E_IOPAD(0x104, PIN_INPUT, 0) /* (M20) MMC1_CMD */
-			J721E_IOPAD(0x100, PIN_INPUT, 0) /* (P21) MMC1_CLK */
-			J721E_IOPAD(0xfc, PIN_INPUT, 0) /* (P25) MMC1_CLKLB */
-			J721E_IOPAD(0xf8, PIN_INPUT, 0) /* (M19) MMC1_DAT0 */
-			J721E_IOPAD(0xf4, PIN_INPUT, 0) /* (N21) MMC1_DAT1 */
-			J721E_IOPAD(0xf0, PIN_INPUT, 0) /* (N20) MMC1_DAT2 */
-			J721E_IOPAD(0xec, PIN_INPUT, 0) /* (N19) MMC1_DAT3 */
-			J721E_IOPAD(0xe4, PIN_INPUT, 8) /* (V1) TIMER_IO0.MMC1_SDCD */
-		>;
-	};
-
-	vdd_sd_dv_pins_default: vdd-sd-dv-default-pins {
-		pinctrl-single,pins = <
-			J721E_IOPAD(0xd0, PIN_OUTPUT, 7) /* (T5) SPI0_D1.GPIO0_55 */
-		>;
-	};
-
-	main_mcan3_pins_default: main-mcan3-default-pins {
-		pinctrl-single,pins = <
-			J721E_IOPAD(0x3c, PIN_INPUT, 0) /* (W16) MCAN3_RX */
-			J721E_IOPAD(0x38, PIN_OUTPUT, 0) /* (Y21) MCAN3_TX */
-		>;
-	};
-};
-
-&main_pmx1 {
-	main_usbss0_pins_default: main-usbss0-default-pins {
-		pinctrl-single,pins = <
-			J721E_IOPAD(0x04, PIN_OUTPUT, 0) /* (T4) USB0_DRVVBUS */
-		>;
-	};
-};
-
 &wkup_uart0 {
 	/* Wakeup UART is used by System firmware */
 	status = "reserved";
diff --git a/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
index 7e6a584ac6f0..d9eddc5191b1 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
@@ -103,6 +103,22 @@ transceiver0: can-phy0 {
 	};
 };
 
+&main_pmx0 {
+	main_i2c0_pins_default: main-i2c0-default-pins {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0xd4, PIN_INPUT_PULLUP, 0) /* (V3) I2C0_SCL */
+			J721E_IOPAD(0xd8, PIN_INPUT_PULLUP, 0) /* (W2) I2C0_SDA */
+		>;
+	};
+
+	main_mcan0_pins_default: main-mcan0-default-pins {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x24, PIN_INPUT, 0) /* (V20) MCAN0_RX */
+			J721E_IOPAD(0x20, PIN_OUTPUT, 0) /* (V18) MCAN0_TX */
+		>;
+	};
+};
+
 &wkup_pmx0 {
 	mcu_fss0_hpb0_pins_default: mcu-fss0-hpb0-default-pins {
 		pinctrl-single,pins = <
@@ -156,21 +172,6 @@ J721E_WKUP_IOPAD(0x01c, PIN_INPUT, 7) /* (E18) WKUP_GPIO0_84 */
 	};
 };
 
-&main_pmx0 {
-	main_i2c0_pins_default: main-i2c0-default-pins {
-		pinctrl-single,pins = <
-			J721E_IOPAD(0xd4, PIN_INPUT_PULLUP, 0) /* (V3) I2C0_SCL */
-			J721E_IOPAD(0xd8, PIN_INPUT_PULLUP, 0) /* (W2) I2C0_SDA */
-		>;
-	};
-
-	main_mcan0_pins_default: main-mcan0-default-pins {
-		pinctrl-single,pins = <
-			J721E_IOPAD(0x24, PIN_INPUT, 0) /* (V20) MCAN0_RX */
-			J721E_IOPAD(0x20, PIN_OUTPUT, 0) /* (V18) MCAN0_TX */
-		>;
-	};
-};
 
 &hbmc {
 	/* OSPI and HBMC are muxed inside FSS, Bootloader will enable
-- 
2.34.1


