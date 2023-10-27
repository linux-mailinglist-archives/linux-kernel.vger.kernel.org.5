Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D67F7D9A10
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 15:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346054AbjJ0Ng1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 09:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235012AbjJ0NgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 09:36:02 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 27 Oct 2023 06:35:45 PDT
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E631732
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 06:35:44 -0700 (PDT)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202310271334402cded1989dcfe7233f
        for <linux-kernel@vger.kernel.org>;
        Fri, 27 Oct 2023 15:34:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=TMUuKmCwAN/dQq9rxwIHqvrEpoAvyHud+zwVSEPvl/Q=;
 b=bXjKmsYFnMA6kD0zsdOpqo5nOwhqPzSsOlnDAB5ExpUolGAc/zr6nxJ9ntl71Dp9o1n4DO
 Bro9ozakRHG0SRQ68YG17THpEQNLxBT7vK1OFFG0w76gAnoMwrkYcrc16rPVzjVR50Tr81pn
 lzGiZfUfrmFqcgL+i4Y1OQiRggz1s=;
From:   Jan Kiszka <jan.kiszka@siemens.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Bao Cheng Su <baocheng.su@siemens.com>,
        Benedikt Niedermayr <benedikt.niedermayr@siemens.com>
Subject: [PATCH 3/7] arm64: dts: ti: iot2050: Definitions for runtime pinmuxing
Date:   Fri, 27 Oct 2023 15:34:34 +0200
Message-Id: <4ecdf2fbe8c8a99e95743c78c63205548bb97a04.1698413678.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1698413678.git.jan.kiszka@siemens.com>
References: <cover.1698413678.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benedikt Niedermayr <benedikt.niedermayr@siemens.com>

Add multiple device tree nodes in order to support
runtime pinmuxing via debugfs.

All nodes are added to the pinctrl device node,
since they are now belonging to multiple interfaces now.

Note: Pinconf is also handled by debugfs-pinmux. This is possible since
pinconf and pinmux accessing the same 32-Bit register and setting the
function mask to 32-Bit allows writes to the whole register.

Signed-off-by: Benedikt Niedermayr <benedikt.niedermayr@siemens.com>
---
 .../boot/dts/ti/k3-am65-iot2050-common.dtsi   | 663 +++++++++++++++++-
 .../dts/ti/k3-am6548-iot2050-advanced-m2.dts  |   4 +-
 2 files changed, 628 insertions(+), 39 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
index fc39ae0f9587..74c4accff4b7 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
@@ -114,6 +114,425 @@ dp_refclk: clock {
 };
 
 &wkup_pmx0 {
+	pinctrl-names =
+	"default",
+	"d0-uart0-rxd",  "d0-gpio",  "d0-gpio-pullup",  "d0-gpio-pulldown",
+	"d1-uart0-txd",  "d1-gpio",  "d1-gpio-pullup",  "d1-gpio-pulldown",
+	"d2-uart0-ctsn", "d2-gpio",  "d2-gpio-pullup",  "d2-gpio-pulldown",
+	"d3-uart0-rtsn", "d3-gpio",  "d3-gpio-pullup",  "d3-gpio-pulldown",
+	"d10-spi0-cs0",  "d10-gpio", "d10-gpio-pullup", "d10-gpio-pulldown",
+	"d11-spi0-d0",   "d11-gpio", "d11-gpio-pullup", "d11-gpio-pulldown",
+	"d12-spi0-d1",   "d12-gpio", "d12-gpio-pullup", "d12-gpio-pulldown",
+	"d13-spi0-clk",  "d13-gpio", "d13-gpio-pullup", "d13-gpio-pulldown",
+	"a0-gpio", "a0-gpio-pullup", "a0-gpio-pulldown",
+	"a1-gpio", "a1-gpio-pullup", "a1-gpio-pulldown",
+	"a2-gpio", "a2-gpio-pullup", "a2-gpio-pulldown",
+	"a3-gpio", "a3-gpio-pullup", "a3-gpio-pulldown",
+	"a4-gpio", "a4-gpio-pullup", "a4-gpio-pulldown",
+	"a5-gpio", "a5-gpio-pullup", "a5-gpio-pulldown";
+
+	pinctrl-0 = <&d0_uart0_rxd>;
+	pinctrl-1 = <&d0_uart0_rxd>;
+	pinctrl-2 = <&d0_gpio>;
+	pinctrl-3 = <&d0_gpio_pullup>;
+	pinctrl-4 = <&d0_gpio_pulldown>;
+	pinctrl-5 = <&d1_uart0_txd>;
+	pinctrl-6 = <&d1_gpio>;
+	pinctrl-7 = <&d1_gpio_pullup>;
+	pinctrl-8 = <&d1_gpio_pulldown>;
+	pinctrl-9 = <&d2_uart0_ctsn>;
+	pinctrl-10 = <&d2_gpio>;
+	pinctrl-11 = <&d2_gpio_pullup>;
+	pinctrl-12 = <&d2_gpio_pulldown>;
+	pinctrl-13 = <&d3_uart0_rtsn>;
+	pinctrl-14 = <&d3_gpio>;
+	pinctrl-15 = <&d3_gpio_pullup>;
+	pinctrl-16 = <&d3_gpio_pulldown>;
+	pinctrl-17 = <&d10_spi0_cs0>;
+	pinctrl-18 = <&d10_gpio>;
+	pinctrl-19 = <&d10_gpio_pullup>;
+	pinctrl-20 = <&d10_gpio_pulldown>;
+	pinctrl-21 = <&d11_spi0_d0>;
+	pinctrl-22 = <&d11_gpio>;
+	pinctrl-23 = <&d11_gpio_pullup>;
+	pinctrl-24 = <&d11_gpio_pulldown>;
+	pinctrl-25 = <&d12_spi0_d1>;
+	pinctrl-26 = <&d12_gpio>;
+	pinctrl-27 = <&d12_gpio_pullup>;
+	pinctrl-28 = <&d12_gpio_pulldown>;
+	pinctrl-29 = <&d13_spi0_clk>;
+	pinctrl-30 = <&d13_gpio>;
+	pinctrl-31 = <&d13_gpio_pullup>;
+	pinctrl-32 = <&d13_gpio_pulldown>;
+	pinctrl-33 = <&a0_gpio>;
+	pinctrl-34 = <&a0_gpio_pullup>;
+	pinctrl-35 = <&a0_gpio_pulldown>;
+	pinctrl-36 = <&a1_gpio>;
+	pinctrl-37 = <&a1_gpio_pullup>;
+	pinctrl-38 = <&a1_gpio_pulldown>;
+	pinctrl-39 = <&a2_gpio>;
+	pinctrl-40 = <&a2_gpio_pullup>;
+	pinctrl-41 = <&a2_gpio_pulldown>;
+	pinctrl-42 = <&a3_gpio>;
+	pinctrl-43 = <&a3_gpio_pullup>;
+	pinctrl-44 = <&a3_gpio_pulldown>;
+	pinctrl-45 = <&a4_gpio>;
+	pinctrl-46 = <&a4_gpio_pullup>;
+	pinctrl-47 = <&a4_gpio_pulldown>;
+	pinctrl-48 = <&a5_gpio>;
+	pinctrl-49 = <&a5_gpio_pullup>;
+	pinctrl-50 = <&a5_gpio_pulldown>;
+
+	d0_uart0_rxd: d0-uart0-rxd {
+		pinctrl-single,pins = <
+			/* (P4) MCU_UART0_RXD */
+			AM65X_WKUP_IOPAD(0x0044, PIN_INPUT, 4)
+		>;
+	};
+
+	d0_gpio: d0-gpio {
+		pinctrl-single,pins = <
+			/* (P4) WKUP_GPIO0_29 */
+			AM65X_WKUP_IOPAD(0x0044, PIN_INPUT, 7)
+		>;
+	};
+
+	d0_gpio_pullup: d0-gpio-pullup {
+		pinctrl-single,pins = <
+			/* (P4) WKUP_GPIO0_29 */
+			AM65X_WKUP_IOPAD(0x0044, PIN_INPUT_PULLUP, 7)
+		>;
+	};
+
+	d0_gpio_pulldown: d0-gpio-pulldown {
+		pinctrl-single,pins = <
+			/* (P4) WKUP_GPIO0_29 */
+			AM65X_WKUP_IOPAD(0x0044, PIN_INPUT_PULLDOWN, 7)
+		>;
+	};
+
+	d1_uart0_txd: d1-uart0-txd {
+		pinctrl-single,pins = <
+			/* (P5) MCU_UART0_TXD */
+			AM65X_WKUP_IOPAD(0x0048, PIN_OUTPUT, 4)
+		>;
+	};
+
+	d1_gpio: d1-gpio {
+		pinctrl-single,pins = <
+			/* (P5) WKUP_GPIO0_30 */
+			AM65X_WKUP_IOPAD(0x0048, PIN_INPUT, 7)
+		>;
+	};
+
+	d1_gpio_pullup: d1-gpio-pullup {
+		pinctrl-single,pins = <
+			/* (P5) WKUP_GPIO0_30 */
+			AM65X_WKUP_IOPAD(0x0048, PIN_INPUT, 7)
+		>;
+	};
+
+	d1_gpio_pulldown: d1-gpio-pulldown {
+		pinctrl-single,pins = <
+			/* (P5) WKUP_GPIO0_30 */
+			AM65X_WKUP_IOPAD(0x0048, PIN_INPUT_PULLDOWN, 7)
+		>;
+	};
+
+	d2_uart0_ctsn: d2-uart0-ctsn {
+		pinctrl-single,pins = <
+			/* (P1) MCU_UART0_CTSn */
+			AM65X_WKUP_IOPAD(0x004C, PIN_INPUT, 4)
+		>;
+	};
+
+	d2_gpio: d2-gpio {
+		pinctrl-single,pins = <
+			/* (P5) WKUP_GPIO0_31 */
+			AM65X_WKUP_IOPAD(0x004C, PIN_INPUT, 7)
+		>;
+	};
+
+	d2_gpio_pullup: d2-gpio-pullup {
+		pinctrl-single,pins = <
+			/* (P5) WKUP_GPIO0_31 */
+			AM65X_WKUP_IOPAD(0x004C, PIN_INPUT, 7)
+		>;
+	};
+
+	d2_gpio_pulldown: d2-gpio-pulldown {
+		pinctrl-single,pins = <
+			/* (P5) WKUP_GPIO0_31 */
+			AM65X_WKUP_IOPAD(0x004C, PIN_INPUT_PULLDOWN, 7)
+		>;
+	};
+
+	d3_uart0_rtsn: d3-uart0-rtsn {
+		pinctrl-single,pins = <
+			/* (N3) MCU_UART0_RTSn */
+			AM65X_WKUP_IOPAD(0x0054, PIN_OUTPUT, 4)
+		>;
+	};
+
+	d3_gpio: d3-gpio {
+		pinctrl-single,pins = <
+			/* (N3) WKUP_GPIO0_33 */
+			AM65X_WKUP_IOPAD(0x0054, PIN_INPUT, 7)
+		>;
+	};
+
+	d3_gpio_pullup: d3-gpio-pullup {
+		pinctrl-single,pins = <
+			/* (N3) WKUP_GPIO0_33 */
+			AM65X_WKUP_IOPAD(0x0054, PIN_INPUT, 7)
+		>;
+	};
+
+	d3_gpio_pulldown: d3-gpio-pulldown {
+		pinctrl-single,pins = <
+			/* (N3) WKUP_GPIO0_33 */
+			AM65X_WKUP_IOPAD(0x0054, PIN_INPUT_PULLDOWN, 7)
+		>;
+	};
+
+	d10_spi0_cs0: d10-spi0-cs0 {
+		pinctrl-single,pins = <
+			/* (Y4) MCU_SPI0_CS0 */
+			AM65X_WKUP_IOPAD(0x009c, PIN_OUTPUT, 0)
+		>;
+	};
+
+	d10_gpio: d10-gpio {
+		pinctrl-single,pins = <
+			/* (Y4) WKUP_GPIO0_51 */
+			AM65X_WKUP_IOPAD(0x009c, PIN_INPUT, 7)
+		>;
+	};
+
+	d10_gpio_pullup: d10-gpio-pullup {
+		pinctrl-single,pins = <
+			/* (Y4) WKUP_GPIO0_51 */
+			AM65X_WKUP_IOPAD(0x009c, PIN_INPUT, 7)
+		>;
+	};
+
+	d10_gpio_pulldown: d10-gpio-pulldown {
+		pinctrl-single,pins = <
+			/* (Y4) WKUP_GPIO0_51 */
+			AM65X_WKUP_IOPAD(0x009c, PIN_INPUT_PULLDOWN, 7)
+		>;
+	};
+
+	d11_spi0_d0: d11-spi0-d0 {
+		pinctrl-single,pins = <
+			/* (Y3) MCU_SPI0_D0 */
+			AM65X_WKUP_IOPAD(0x0094, PIN_INPUT, 0)
+		>;
+	};
+
+	d11_gpio: d11-gpio {
+		pinctrl-single,pins = <
+			/* (Y3) WKUP_GPIO0_49 */
+			AM65X_WKUP_IOPAD(0x0094, PIN_INPUT, 7)
+		>;
+	};
+
+	d11_gpio_pullup: d11-gpio-pullup {
+		pinctrl-single,pins = <
+			/* (Y3) WKUP_GPIO0_49 */
+			AM65X_WKUP_IOPAD(0x0094, PIN_INPUT, 7)
+		>;
+	};
+
+	d11_gpio_pulldown: d11-gpio-pulldown {
+		pinctrl-single,pins = <
+			/* (Y3) WKUP_GPIO0_49 */
+			AM65X_WKUP_IOPAD(0x0094, PIN_INPUT_PULLDOWN, 7)
+		>;
+	};
+
+	d12_spi0_d1: d12-spi0-d1 {
+		pinctrl-single,pins = <
+			/* (Y2) MCU_SPI0_D1 */
+			AM65X_WKUP_IOPAD(0x0098, PIN_INPUT, 0)
+		>;
+	};
+
+	d12_gpio: d12-gpio {
+		pinctrl-single,pins = <
+			/* (Y2) WKUP_GPIO0_50 */
+			AM65X_WKUP_IOPAD(0x0098, PIN_INPUT, 7)
+		>;
+	};
+
+	d12_gpio_pullup: d12-gpio-pullup {
+		pinctrl-single,pins = <
+			/* (Y2) WKUP_GPIO0_50 */
+			AM65X_WKUP_IOPAD(0x0098, PIN_INPUT, 7)
+		>;
+	};
+
+	d12_gpio_pulldown: d12-gpio-pulldown {
+		pinctrl-single,pins = <
+			/* (Y2) WKUP_GPIO0_50 */
+			AM65X_WKUP_IOPAD(0x0098, PIN_INPUT_PULLDOWN, 7)
+		>;
+	};
+
+	d13_spi0_clk: d13-spi0-clk {
+		pinctrl-single,pins = <
+			/* (Y1) MCU_SPI0_CLK */
+			AM65X_WKUP_IOPAD(0x0090, PIN_INPUT, 0)
+		>;
+	};
+
+	d13_gpio: d13-gpio {
+		pinctrl-single,pins = <
+			/* (Y1) WKUP_GPIO0_48 */
+			AM65X_WKUP_IOPAD(0x0090, PIN_INPUT, 7)
+		>;
+	};
+
+	d13_gpio_pullup: d13-gpio-pullup {
+		pinctrl-single,pins = <
+			/* (Y1) WKUP_GPIO0_48 */
+			AM65X_WKUP_IOPAD(0x0090, PIN_INPUT, 7)
+		>;
+	};
+
+	d13_gpio_pulldown: d13-gpio-pulldown {
+		pinctrl-single,pins = <
+			/* (Y1) WKUP_GPIO0_48 */
+			AM65X_WKUP_IOPAD(0x0090, PIN_INPUT_PULLDOWN, 7)
+		>;
+	};
+
+	a0_gpio: a0-gpio {
+		pinctrl-single,pins = <
+			/* (L6) WKUP_GPIO0_45 */
+			AM65X_WKUP_IOPAD(0x0084, PIN_INPUT, 7)
+		>;
+	};
+
+	a0_gpio_pullup: a0-gpio-pullup {
+		pinctrl-single,pins = <
+			/* (L6) WKUP_GPIO0_45 */
+			AM65X_WKUP_IOPAD(0x0084, PIN_INPUT, 7)
+		>;
+	};
+
+	a0_gpio_pulldown: a0-gpio-pulldown {
+		pinctrl-single,pins = <
+			/* (L6) WKUP_GPIO0_45 */
+			AM65X_WKUP_IOPAD(0x0084, PIN_INPUT_PULLDOWN, 7)
+		>;
+	};
+
+	a1_gpio: a1-gpio {
+		pinctrl-single,pins = <
+			/* (M6) WKUP_GPIO0_44 */
+			AM65X_WKUP_IOPAD(0x0080, PIN_INPUT, 7)
+		>;
+	};
+
+	a1_gpio_pullup: a1-gpio-pullup {
+		pinctrl-single,pins = <
+			/* (M6) WKUP_GPIO0_44 */
+			AM65X_WKUP_IOPAD(0x0080, PIN_INPUT, 7)
+		>;
+	};
+
+	a1_gpio_pulldown: a1-gpio-pulldown {
+		pinctrl-single,pins = <
+			/* (M6) WKUP_GPIO0_44 */
+			AM65X_WKUP_IOPAD(0x0080, PIN_INPUT_PULLDOWN, 7)
+		>;
+	};
+
+	a2_gpio: a2-gpio {
+		pinctrl-single,pins = <
+			/* (L5) WKUP_GPIO0_43 */
+			AM65X_WKUP_IOPAD(0x007C, PIN_INPUT, 7)
+		>;
+	};
+
+	a2_gpio_pullup: a2-gpio-pullup {
+		pinctrl-single,pins = <
+			/* (L5) WKUP_GPIO0_43 */
+			AM65X_WKUP_IOPAD(0x007C, PIN_INPUT, 7)
+		>;
+	};
+
+	a2_gpio_pulldown: a2-gpio-pulldown {
+		pinctrl-single,pins = <
+			/* (L5) WKUP_GPIO0_43 */
+			AM65X_WKUP_IOPAD(0x007C, PIN_INPUT_PULLDOWN, 7)
+		>;
+	};
+
+	a3_gpio: a3-gpio {
+		pinctrl-single,pins = <
+			/* (M5) WKUP_GPIO0_39 */
+			AM65X_WKUP_IOPAD(0x006C, PIN_INPUT, 7)
+		>;
+	};
+
+	a3_gpio_pullup: a3-gpio-pullup {
+		pinctrl-single,pins = <
+			/* (M5) WKUP_GPIO0_39 */
+			AM65X_WKUP_IOPAD(0x006C, PIN_INPUT, 7)
+		>;
+	};
+
+	a3_gpio_pulldown: a3-gpio-pulldown {
+		pinctrl-single,pins = <
+			/* (M5) WKUP_GPIO0_39 */
+			AM65X_WKUP_IOPAD(0x006C, PIN_INPUT_PULLDOWN, 7)
+		>;
+	};
+
+	a4_gpio: a4-gpio {
+		pinctrl-single,pins = <
+			/* (L2) WKUP_GPIO0_42 */
+			AM65X_WKUP_IOPAD(0x0078, PIN_INPUT, 7)
+		>;
+	};
+
+	a4_gpio_pullup: a4-gpio-pullup {
+		pinctrl-single,pins = <
+			/* (L2) WKUP_GPIO0_42 */
+			AM65X_WKUP_IOPAD(0x0078, PIN_INPUT, 7)
+		>;
+	};
+
+	a4_gpio_pulldown: a4-gpio-pulldown {
+		pinctrl-single,pins = <
+			/* (L2) WKUP_GPIO0_42 */
+			AM65X_WKUP_IOPAD(0x0078, PIN_INPUT_PULLDOWN, 7)
+		>;
+	};
+
+	a5_gpio: a5-gpio {
+		pinctrl-single,pins = <
+			/* (N5) WKUP_GPIO0_35 */
+			AM65X_WKUP_IOPAD(0x005C, PIN_INPUT, 7)
+		>;
+	};
+
+	a5_gpio_pullup: a5-gpio-pullup {
+		pinctrl-single,pins = <
+			/* (N5) WKUP_GPIO0_35 */
+			AM65X_WKUP_IOPAD(0x005C, PIN_INPUT_PULLUP, 7)
+		>;
+	};
+
+	a5_gpio_pulldown: a5-gpio-pulldown {
+		pinctrl-single,pins = <
+			/* (N5) WKUP_GPIO0_35 */
+			AM65X_WKUP_IOPAD(0x005C, PIN_INPUT_PULLDOWN, 7)
+		>;
+	};
+
 	wkup_i2c0_pins_default: wkup-i2c0-default-pins {
 		pinctrl-single,pins = <
 			/* (AC7) WKUP_I2C0_SCL */
@@ -146,23 +565,6 @@ AM65X_WKUP_IOPAD(0x0034, PIN_INPUT,  7)
 		>;
 	};
 
-	arduino_uart_pins_default: arduino-uart-default-pins {
-		pinctrl-single,pins = <
-			/* (P4) MCU_UART0_RXD */
-			AM65X_WKUP_IOPAD(0x0044, PIN_INPUT,  4)
-			/* (P5) MCU_UART0_TXD */
-			AM65X_WKUP_IOPAD(0x0048, PIN_OUTPUT, 4)
-		>;
-	};
-
-	arduino_io_d2_to_d3_pins_default: arduino-io-d2-to-d3-default-pins {
-		pinctrl-single,pins = <
-			/* (P1) WKUP_GPIO0_31 */
-			AM65X_WKUP_IOPAD(0x004C, PIN_OUTPUT, 7)
-			/* (N3) WKUP_GPIO0_33 */
-			AM65X_WKUP_IOPAD(0x0054, PIN_OUTPUT, 7)
-		>;
-	};
 
 	arduino_io_oe_pins_default: arduino-io-oe-default-pins {
 		pinctrl-single,pins = <
@@ -242,6 +644,214 @@ AM65X_WKUP_IOPAD(0x003C, PIN_OUTPUT, 7)
 };
 
 &main_pmx0 {
+	pinctrl-names =
+		"default",
+		"d4-ehrpwm0-a", "d4-gpio", "d4-gpio-pullup", "d4-gpio-pulldown",
+		"d5-ehrpwm1-a", "d5-gpio", "d5-gpio-pullup", "d5-gpio-pulldown",
+		"d6-ehrpwm2-a", "d6-gpio", "d6-gpio-pullup", "d6-gpio-pulldown",
+		"d7-ehrpwm3-a", "d7-gpio", "d7-gpio-pullup", "d7-gpio-pulldown",
+		"d8-ehrpwm4-a", "d8-gpio", "d8-gpio-pullup", "d8-gpio-pulldown",
+		"d9-ehrpwm5-a", "d9-gpio", "d9-gpio-pullup", "d9-gpio-pulldown";
+
+	pinctrl-0 = <&d4_ehrpwm0_a>;
+	pinctrl-1 = <&d4_ehrpwm0_a>;
+	pinctrl-2 = <&d4_gpio>;
+	pinctrl-3 = <&d4_gpio_pullup>;
+	pinctrl-4 = <&d4_gpio_pulldown>;
+
+	pinctrl-5 = <&d5_ehrpwm1_a>;
+	pinctrl-6 = <&d5_gpio>;
+	pinctrl-7 = <&d5_gpio_pullup>;
+	pinctrl-8 = <&d5_gpio_pulldown>;
+
+	pinctrl-9 = <&d6_ehrpwm2_a>;
+	pinctrl-10 = <&d6_gpio>;
+	pinctrl-11 = <&d6_gpio_pullup>;
+	pinctrl-12 = <&d6_gpio_pulldown>;
+
+	pinctrl-13 = <&d7_ehrpwm3_a>;
+	pinctrl-14 = <&d7_gpio>;
+	pinctrl-15 = <&d7_gpio_pullup>;
+	pinctrl-16 = <&d7_gpio_pulldown>;
+
+	pinctrl-17 = <&d8_ehrpwm4_a>;
+	pinctrl-18 = <&d8_gpio>;
+	pinctrl-19 = <&d8_gpio_pullup>;
+	pinctrl-20 = <&d8_gpio_pulldown>;
+
+	pinctrl-21 = <&d9_ehrpwm5_a>;
+	pinctrl-22 = <&d9_gpio>;
+	pinctrl-23 = <&d9_gpio_pullup>;
+	pinctrl-24 = <&d9_gpio_pulldown>;
+
+	d4_ehrpwm0_a: d4-ehrpwm0-a {
+		pinctrl-single,pins = <
+			/* (AG18) EHRPWM0_A */
+			AM65X_IOPAD(0x0084, PIN_OUTPUT, 5)
+		>;
+	};
+
+	d4_gpio: d4-gpio {
+		pinctrl-single,pins = <
+			/* (AG18) GPIO0_33 */
+			AM65X_IOPAD(0x0084, PIN_INPUT, 7)
+		>;
+	};
+
+	d4_gpio_pullup: d4-gpio-pullup {
+		pinctrl-single,pins = <
+			/* (AG18) GPIO0_33 */
+			AM65X_IOPAD(0x0084, PIN_INPUT_PULLUP, 7)
+		>;
+	};
+
+	d4_gpio_pulldown: d4-gpio-pulldown {
+		pinctrl-single,pins = <
+			/* (AG18) GPIO0_33 */
+			AM65X_IOPAD(0x0084, PIN_INPUT_PULLDOWN, 7)
+		>;
+	};
+
+	d5_ehrpwm1_a: d5-ehrpwm1-a {
+		pinctrl-single,pins = <
+			/* (AF17) EHRPWM1_A */
+			AM65X_IOPAD(0x008C, PIN_OUTPUT, 5)
+		>;
+	};
+
+	d5_gpio: d5-gpio {
+		pinctrl-single,pins = <
+			/* (AF17) GPIO0_35 */
+			AM65X_IOPAD(0x008C, PIN_INPUT, 7)
+		>;
+	};
+
+	d5_gpio_pullup: d5-gpio-pullup {
+		pinctrl-single,pins = <
+			/* (AF17) GPIO0_35 */
+			AM65X_IOPAD(0x008C, PIN_INPUT_PULLUP, 7)
+		>;
+	};
+
+	d5_gpio_pulldown: d5-gpio-pulldown {
+		pinctrl-single,pins = <
+			/* (AF17) GPIO0_35 */
+			AM65X_IOPAD(0x008C, PIN_INPUT_PULLDOWN, 7)
+		>;
+	};
+
+	d6_ehrpwm2_a: d6-ehrpwm2-a {
+		pinctrl-single,pins = <
+			/* (AH16) EHRPWM2_A */
+			AM65X_IOPAD(0x0098, PIN_OUTPUT, 5)
+		>;
+	};
+
+	d6_gpio: d6-gpio {
+		pinctrl-single,pins = <
+			/* (AH16) GPIO0_38 */
+			AM65X_IOPAD(0x0098, PIN_INPUT, 7)
+		>;
+	};
+
+	d6_gpio_pullup: d6-gpio-pullup {
+		pinctrl-single,pins = <
+			/* (AH16) GPIO0_38 */
+			AM65X_IOPAD(0x0098, PIN_INPUT_PULLUP, 7)
+		>;
+	};
+
+	d6_gpio_pulldown: d6-gpio-pulldown {
+		pinctrl-single,pins = <
+			/* (AH16) GPIO0_38 */
+			AM65X_IOPAD(0x0098, PIN_INPUT_PULLDOWN, 7)
+		>;
+	};
+
+	d7_ehrpwm3_a: d7-ehrpwm3-a {
+		pinctrl-single,pins = <
+			/* (AH15) EHRPWM3_A */
+			AM65X_IOPAD(0x00AC, PIN_OUTPUT, 5)
+		>;
+	};
+
+	d7_gpio: d7-gpio {
+		pinctrl-single,pins = <
+			/* (AH15) GPIO0_43 */
+			AM65X_IOPAD(0x00AC, PIN_INPUT, 7)
+		>;
+	};
+
+	d7_gpio_pullup: d7-gpio-pullup {
+		pinctrl-single,pins = <
+			/* (AH15) GPIO0_43 */
+			AM65X_IOPAD(0x00AC, PIN_INPUT_PULLUP, 7)
+		>;
+	};
+
+	d7_gpio_pulldown: d7-gpio-pulldown {
+		pinctrl-single,pins = <
+			/* (AH15) GPIO0_43 */
+			AM65X_IOPAD(0x00AC, PIN_INPUT_PULLDOWN, 7)
+		>;
+	};
+
+	d8_ehrpwm4_a: d8-ehrpwm4-a {
+		pinctrl-single,pins = <
+			/* (AG15) EHRPWM4_A */
+			AM65X_IOPAD(0x00C0, PIN_OUTPUT, 5)
+		>;
+	};
+
+	d8_gpio: d8-gpio {
+		pinctrl-single,pins = <
+			/* (AG15) GPIO0_48 */
+			AM65X_IOPAD(0x00C0, PIN_INPUT, 7)
+		>;
+	};
+
+	d8_gpio_pullup: d8-gpio-pullup {
+		pinctrl-single,pins = <
+			/* (AG15) GPIO0_48 */
+			AM65X_IOPAD(0x00C0, PIN_INPUT_PULLUP, 7)
+		>;
+	};
+
+	d8_gpio_pulldown: d8-gpio-pulldown {
+		pinctrl-single,pins = <
+			/* (AG15) GPIO0_48 */
+			AM65X_IOPAD(0x00C0, PIN_INPUT_PULLDOWN, 7)
+		>;
+	};
+
+	d9_ehrpwm5_a: d9-ehrpwm5-a {
+		pinctrl-single,pins = <
+			/* (AD15) EHRPWM5_A */
+			AM65X_IOPAD(0x00CC, PIN_OUTPUT, 5)
+		>;
+	};
+
+	d9_gpio: d9-gpio {
+		pinctrl-single,pins = <
+			/* (AD15) GPIO0_51 */
+			AM65X_IOPAD(0x00CC, PIN_INPUT, 7)
+		>;
+	};
+
+	d9_gpio_pullup: d9-gpio-pullup {
+		pinctrl-single,pins = <
+			/* (AD15) GPIO0_51 */
+			AM65X_IOPAD(0x00CC, PIN_INPUT_PULLUP, 7)
+		>;
+	};
+
+	d9_gpio_pulldown: d9-gpio-pulldown {
+		pinctrl-single,pins = <
+			/* (AD15) GPIO0_51 */
+			AM65X_IOPAD(0x00CC, PIN_INPUT_PULLDOWN, 7)
+		>;
+	};
+
 	main_uart1_pins_default: main-uart1-default-pins {
 		pinctrl-single,pins = <
 			AM65X_IOPAD(0x0174, PIN_INPUT,  6)  /* (AE23) UART1_RXD */
@@ -283,17 +893,6 @@ AM65X_IOPAD(0x02c0, PIN_OUTPUT, 0)  /* (AC8) USB1_DRVVBUS */
 		>;
 	};
 
-	arduino_io_d4_to_d9_pins_default: arduino-io-d4-to-d9-default-pins {
-		pinctrl-single,pins = <
-			AM65X_IOPAD(0x0084, PIN_OUTPUT, 7)  /* (AG18) GPIO0_33 */
-			AM65X_IOPAD(0x008C, PIN_OUTPUT, 7)  /* (AF17) GPIO0_35 */
-			AM65X_IOPAD(0x0098, PIN_OUTPUT, 7)  /* (AH16) GPIO0_38 */
-			AM65X_IOPAD(0x00AC, PIN_OUTPUT, 7)  /* (AH15) GPIO0_43 */
-			AM65X_IOPAD(0x00C0, PIN_OUTPUT, 7)  /* (AG15) GPIO0_48 */
-			AM65X_IOPAD(0x00CC, PIN_OUTPUT, 7)  /* (AD15) GPIO0_51 */
-		>;
-	};
-
 	dss_vout1_pins_default: dss-vout1-default-pins {
 		pinctrl-single,pins = <
 			AM65X_IOPAD(0x0000, PIN_OUTPUT, 1)  /* VOUT1_DATA0 */
@@ -370,13 +969,9 @@ &main_uart1 {
 
 &mcu_uart0 {
 	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&arduino_uart_pins_default>;
 };
 
 &main_gpio0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&arduino_io_d4_to_d9_pins_default>;
 	gpio-line-names =
 		"main_gpio0-base", "", "", "", "", "", "", "", "", "",
 		"", "", "", "", "", "", "", "", "", "",
@@ -389,7 +984,6 @@ &main_gpio0 {
 &wkup_gpio0 {
 	pinctrl-names = "default";
 	pinctrl-0 =
-		<&arduino_io_d2_to_d3_pins_default>,
 		<&arduino_i2c_aio_switch_pins_default>,
 		<&arduino_io_oe_pins_default>,
 		<&push_button_pins_default>,
@@ -572,9 +1166,6 @@ &usb1 {
 
 &mcu_spi0 {
 	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&mcu_spi0_pins_default>;
-
 	#address-cells = <1>;
 	#size-cells = <0>;
 	ti,pindir-d0-out-d1-in;
diff --git a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2.dts b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2.dts
index 774eb14ac907..8301c35c31b3 100644
--- a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2.dts
+++ b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2.dts
@@ -66,9 +66,7 @@ AM65X_IOPAD(0x001c, PIN_INPUT_PULLUP, 7)  /* (C23) GPIO1_89 */
 
 &main_gpio0 {
 	pinctrl-names = "default";
-	pinctrl-0 =
-		<&main_m2_pcie_mux_control>,
-		<&arduino_io_d4_to_d9_pins_default>;
+	pinctrl-0 = <&main_m2_pcie_mux_control>;
 };
 
 &main_gpio1 {
-- 
2.35.3

