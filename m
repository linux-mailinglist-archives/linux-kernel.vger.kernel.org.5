Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F56758653
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 22:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjGRUzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 16:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbjGRUzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 16:55:44 -0400
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC43A1992;
        Tue, 18 Jul 2023 13:55:43 -0700 (PDT)
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by finn.localdomain with esmtp (Exim 4.93)
        (envelope-from <tharvey@gateworks.com>)
        id 1qLrjQ-007EVu-7i; Tue, 18 Jul 2023 20:55:40 +0000
From:   Tim Harvey <tharvey@gateworks.com>
To:     Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v2] arm64: dts: imx8mm: add imx8mm-venice-gw72xx-0x-rpidsi overlay for display
Date:   Tue, 18 Jul 2023 13:55:38 -0700
Message-Id: <20230718205538.4108487-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the following Raspberry Pi displays:
 - DFROBOT DRF0678 7in 800x480 TFT DSI capacitive touch
 - DFROBOT DRF0550 5in 800x480 TFT DSI capacitive touch

Both have the following hardware:
 - FocalTech FT5406 10pt touch controller (with no interrupt)
 - Powertip PH800480T013-IDF02 compatible panel
 - Toshiba TC358762 compatible DSI to DBI bridge
 - ATTINY based regulator used for backlight controller and panel enable

Support is added via a device-tree overlay. The touch controller is not
yet supported as polling mode is needed.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
v2:
 - add newline between properties and child nodes
---
 arch/arm64/boot/dts/freescale/Makefile        |  2 +
 .../imx8mm-venice-gw72xx-0x-rpidsi.dtso       | 90 +++++++++++++++++++
 2 files changed, 92 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rpidsi.dtso

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index df572cfd0931..454b07ed09fc 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -147,6 +147,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8ulp-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-11x11-evk.dtb
 
 imx8mm-venice-gw72xx-0x-imx219-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-imx219.dtbo
+imx8mm-venice-gw72xx-0x-rpidsi-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-rpidsi.dtbo
 imx8mm-venice-gw72xx-0x-rs232-rts-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-rs232-rts.dtbo
 imx8mm-venice-gw72xx-0x-rs422-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-rs422.dtbo
 imx8mm-venice-gw72xx-0x-rs485-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-rs485.dtbo
@@ -157,6 +158,7 @@ imx8mm-venice-gw73xx-0x-rs422-dtbs	:= imx8mm-venice-gw73xx-0x.dtb imx8mm-venice-
 imx8mm-venice-gw73xx-0x-rs485-dtbs	:= imx8mm-venice-gw73xx-0x.dtb imx8mm-venice-gw73xx-0x-rs485.dtbo
 
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw72xx-0x-imx219.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw72xx-0x-rpidsi.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw72xx-0x-rs232-rts.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw72xx-0x-rs422.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw72xx-0x-rs485.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rpidsi.dtso b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rpidsi.dtso
new file mode 100644
index 000000000000..e0768d408c3b
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rpidsi.dtso
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2023 Gateworks Corporation
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+
+#include "imx8mm-pinfunc.h"
+
+/dts-v1/;
+/plugin/;
+
+&{/} {
+	compatible = "gw,imx8mm-gw73xx-0x", "fsl,imx8mm";
+
+	panel {
+		compatible = "powertip,ph800480t013-idf02";
+		power-supply = <&attiny>;
+		backlight = <&attiny>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&bridge_out>;
+			};
+		};
+	};
+};
+
+&i2c3 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	attiny: regulator@45 {
+		compatible = "raspberrypi,7inch-touchscreen-panel-regulator";
+		reg = <0x45>;
+	};
+};
+
+&lcdif {
+	status = "okay";
+};
+
+&mipi_dsi {
+	samsung,burst-clock-frequency = <891000000>;
+	samsung,esc-clock-frequency = <54000000>;
+	samsung,pll-clock-frequency = <27000000>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	bridge@0 {
+		compatible = "toshiba,tc358762";
+		reg = <0>;
+		vddc-supply = <&attiny>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				bridge_in: endpoint {
+					remote-endpoint = <&dsi_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				bridge_out: endpoint {
+					remote-endpoint = <&panel_in>;
+				};
+			};
+		};
+	};
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@1 {
+			reg = <1>;
+
+			dsi_out: endpoint {
+				remote-endpoint = <&bridge_in>;
+			};
+		};
+	};
+};
-- 
2.25.1

