Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A87805DFB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 19:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbjLESq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 13:46:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbjLESqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 13:46:12 -0500
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FE31A1;
        Tue,  5 Dec 2023 10:46:17 -0800 (PST)
Received: from francesco-nb.corp.toradex.com (31-10-206-125.static.upc.ch [31.10.206.125])
        by mail11.truemail.it (Postfix) with ESMTPA id 28A0E20284;
        Tue,  5 Dec 2023 19:46:13 +0100 (CET)
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Joao Paulo Goncalves <joao.goncalves@toradex.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v3 1/3] arm64: dts: ti: verdin-am62: improve spi1 chip-select pinctrl
Date:   Tue,  5 Dec 2023 19:46:03 +0100
Message-Id: <20231205184605.35225-2-francesco@dolcini.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231205184605.35225-1-francesco@dolcini.it>
References: <20231205184605.35225-1-francesco@dolcini.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joao Paulo Goncalves <joao.goncalves@toradex.com>

Verdin SPI_1 interface has a dedicated hardware controlled chip select
that is currently configured in the same pinctrl group as MISO/MOSI/CLK,
however it is possible that it can be used only as a standard GPIO be it
a chip select or not.

To maximize flexibility and avoid duplication in the carrier board dts
files move the SPI_1 CS in a dedicated pinctrl and also adds an
additional pinctrl to simplify using SPI_1 CS as a GPIO.

Signed-off-by: Joao Paulo Goncalves <joao.goncalves@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
index 5db52f237253..6a06724b6d16 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
@@ -233,6 +233,13 @@ AM62X_IOPAD(0x0018, PIN_INPUT, 7) /* (F24) OSPI0_D3.GPIO0_6 */ /* SODIMM 62 */
 		>;
 	};
 
+	/* Verdin SPI_1 CS as GPIO */
+	pinctrl_qspi1_io4_gpio: main-gpio0-7-default-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x001c, PIN_INPUT, 7) /* (J23) OSPI0_D4.GPIO0_7 */ /* SODIMM 202 */
+		>;
+	};
+
 	/* Verdin QSPI_1_CS# as GPIO (conflict with Verdin QSPI_1 interface) */
 	pinctrl_qspi1_cs_gpio: main-gpio0-11-default-pins {
 		pinctrl-single,pins = <
@@ -599,12 +606,18 @@ AM62X_IOPAD(0x164, PIN_OUTPUT, 0) /* (AA19) RGMII2_TX_CTL */ /* SODIMM 211 */
 	pinctrl_spi1: main-spi1-default-pins {
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x0020, PIN_INPUT, 1) /* (J25) OSPI0_D5.SPI1_CLK */ /* SODIMM 196 */
-			AM62X_IOPAD(0x001c, PIN_INPUT, 1) /* (J23) OSPI0_D4.SPI1_CS0 */ /* SODIMM 202 */
 			AM62X_IOPAD(0x0024, PIN_INPUT, 1) /* (H25) OSPI0_D6.SPI1_D0  */ /* SODIMM 200 */
 			AM62X_IOPAD(0x0028, PIN_INPUT, 1) /* (J22) OSPI0_D7.SPI1_D1  */ /* SODIMM 198 */
 		>;
 	};
 
+	/* Verdin SPI_1 CS */
+	pinctrl_spi1_cs0: main-spi1-cs0-default-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x001c, PIN_INPUT, 1) /* (J23) OSPI0_D4.SPI1_CS0 */ /* SODIMM 202 */
+		>;
+	};
+
 	/* ETH_25MHz_CLK */
 	pinctrl_eth_clock: main-system-clkout0-default-pins {
 		pinctrl-single,pins = <
@@ -1278,7 +1291,7 @@ &main_mcan0 {
 /* Verdin SPI_1 */
 &main_spi1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_spi1>;
+	pinctrl-0 = <&pinctrl_spi1>, <&pinctrl_spi1_cs0>;
 	ti,pindir-d0-out-d1-in;
 	status = "disabled";
 };
-- 
2.25.1

