Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 983E9806F1B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377859AbjLFLwY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Dec 2023 06:52:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377830AbjLFLv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:51:57 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E6DD51;
        Wed,  6 Dec 2023 03:51:28 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 9324524E2DC;
        Wed,  6 Dec 2023 19:51:26 +0800 (CST)
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 6 Dec
 2023 19:51:26 +0800
Received: from jsia-virtual-machine.localdomain (175.136.135.142) by
 EXMBX066.cuchost.com (172.16.6.66) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Wed, 6 Dec 2023 19:51:19 +0800
From:   Sia Jee Heng <jeeheng.sia@starfivetech.com>
To:     <kernel@esmil.dk>, <conor@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <p.zabel@pengutronix.de>, <emil.renner.berthing@canonical.com>,
        <hal.feng@starfivetech.com>, <xingyu.wu@starfivetech.com>
CC:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <jeeheng.sia@starfivetech.com>, <leyfoon.tan@starfivetech.com>
Subject: [PATCH v1 09/16] dt-bindings: clock: Add StarFive JH8100 System-North-East clock and reset generator
Date:   Wed, 6 Dec 2023 19:49:53 +0800
Message-ID: <20231206115000.295825-10-jeeheng.sia@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206115000.295825-1-jeeheng.sia@starfivetech.com>
References: <20231206115000.295825-1-jeeheng.sia@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [175.136.135.142]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX066.cuchost.com
 (172.16.6.66)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for the System-North-East clock and reset generator
(SYSCRG-NE) on JH8100 SoC.

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
---
 .../clock/starfive,jh8100-syscrg-ne.yaml      | 158 ++++++++++++++++
 .../dt-bindings/clock/starfive,jh8100-crg.h   | 179 ++++++++++++++++++
 .../dt-bindings/reset/starfive,jh8100-crg.h   |  61 ++++++
 3 files changed, 398 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh8100-syscrg-ne.yaml

diff --git a/Documentation/devicetree/bindings/clock/starfive,jh8100-syscrg-ne.yaml b/Documentation/devicetree/bindings/clock/starfive,jh8100-syscrg-ne.yaml
new file mode 100644
index 000000000000..e9c1156489b2
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/starfive,jh8100-syscrg-ne.yaml
@@ -0,0 +1,158 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/starfive,jh8100-syscrg-ne.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JH8100 System-North-East Clock and Reset Generator
+
+maintainers:
+  - Sia Jee Heng <jeeheng.sia@starfivetech.com>
+
+properties:
+  compatible:
+    const: starfive,jh8100-syscrg-ne
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Main Oscillator (24 MHz)
+      - description: AXI_400 clock from SYSCRG
+      - description: VOUT_ROOT0 clock from SYSCRG
+      - description: VOUT_ROOT1 clock from SYSCRG
+      - description: USB_WRAP_480 clock from SYSCRG
+      - description: USB_WRAP_625 clock from SYSCRG
+      - description: USB_WRAP_240 clock from SYSCRG
+      - description: USB_WRAP_60 clock from SYSCRG
+      - description: USB_WRAP_156P25 clock from SYSCRG
+      - description: USB_WRAP_312P5 clock from SYSCRG
+      - description: USB_125M clock from SYSCRG
+      - description: GPIO_100 clock from SYSCRG_NW
+      - description: PERH_ROOT clock from SYSCRG
+      - description: Master clock from SYSCRG
+      - description: PERH_ROOT_PREOSC clock from SYSCRG
+      - description: AHB0 clock from SYSCRG
+      - description: APB_BUS_PER1 clock from SYSCRG
+      - description: APB_BUS PER2 clock from SYSCRG
+      - description: APB_BUS_PER3 clock from SYSCRG
+      - description: APB_BUS_PER5 clock from SYSCRG
+      - description: VENC_ROOT clock from SYSCRG
+      - description: SPI_CORE_100 clock from SYSCRG
+      - description: External global clock
+      - description: External USB3_TAP_TCK clock
+      - description: External USB1_TAP_TCK clock
+      - description: External USB2_TAP_TCK clock
+      - description: External TYPEC_TAP_TCK clock
+      - description: External SPI_IN0 clock
+      - description: External SPI_IN1 clock
+      - description: External I2STX_BCLK clock
+      - description: External I2STX_LRCK clock
+
+  clock-names:
+    items:
+      - const: clk_osc
+      - const: sys_clk_axi_400
+      - const: sys_clk_vout_root0
+      - const: sys_clk_vout_root1
+      - const: sys_clk_usb_wrap_480
+      - const: sys_clk_usb_wrap_625
+      - const: sys_clk_usb_wrap_240
+      - const: sys_clk_usb_wrap_60
+      - const: sys_clk_usb_wrap_156p25
+      - const: sys_clk_usb_wrap_312p5
+      - const: sys_clk_usb_125m
+      - const: sys_nw_clk_gpio_100
+      - const: sys_clk_perh_root
+      - const: sys_clk_mclk
+      - const: sys_clk_perh_root_preosc
+      - const: sys_clk_ahb0
+      - const: sys_clk_apb_bus_per1
+      - const: sys_clk_apb_bus_per2
+      - const: sys_clk_apb_bus_per3
+      - const: sys_clk_apb_bus_per5
+      - const: sys_clk_venc_root
+      - const: sys_clk_spi_core_100
+      - const: clk_glb_ext_clk
+      - const: clk_usb3_tap_tck_ext
+      - const: clk_usb1_tap_tck_ext
+      - const: clk_usb2_tap_tck_ext
+      - const: clk_typec_tap_tck_ext
+      - const: clk_spi_in0_ext
+      - const: clk_spi_in1_ext
+      - const: clk_i2stx_bclk_ext
+      - const: clk_i2stx_lrck_ext
+
+  '#clock-cells':
+    const: 1
+    description:
+      See <dt-bindings/clock/starfive,jh8100-crg.h> for valid indices.
+
+  '#reset-cells':
+    const: 1
+    description:
+      See <dt-bindings/reset/starfive-jh8100-crg.h> for valid indices.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - '#clock-cells'
+  - '#reset-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/starfive,jh8100-crg.h>
+
+    clock-controller@12320000 {
+            compatible = "starfive,jh8100-syscrg-ne";
+            reg = <0x12320000 0x10000>;
+            clocks = <&clk_osc>, <&syscrg SYSCRG_CLK_AXI_400>,
+                     <&syscrg SYSCRG_CLK_VOUT_ROOT0>,
+                     <&syscrg SYSCRG_CLK_VOUT_ROOT1>,
+                     <&syscrg SYSCRG_CLK_USB_WRAP_480>,
+                     <&syscrg SYSCRG_CLK_USB_WRAP_625>,
+                     <&syscrg SYSCRG_CLK_USB_WRAP_240>,
+                     <&syscrg SYSCRG_CLK_USB_WRAP_60>,
+                     <&syscrg SYSCRG_CLK_USB_WRAP_156P25>,
+                     <&syscrg SYSCRG_CLK_USB_WRAP_312P5>,
+                     <&syscrg SYSCRG_CLK_USB_125M>,
+                     <&syscrg_nw SYSCRG_NW_CLK_GPIO_100>,
+                     <&syscrg SYSCRG_CLK_PERH_ROOT>,
+                     <&syscrg SYSCRG_CLK_MCLK>,
+                     <&syscrg SYSCRG_CLK_PERH_ROOT_PREOSC>,
+                     <&syscrg SYSCRG_CLK_AHB0>,
+                     <&syscrg SYSCRG_CLK_APB_BUS_PER1>,
+                     <&syscrg SYSCRG_CLK_APB_BUS_PER2>,
+                     <&syscrg SYSCRG_CLK_APB_BUS_PER3>,
+                     <&syscrg SYSCRG_CLK_APB_BUS_PER5>,
+                     <&syscrg SYSCRG_CLK_VENC_ROOT>,
+                     <&syscrg SYSCRG_CLK_SPI_CORE_100>,
+                     <&clk_glb_ext_clk>, <&clk_usb3_tap_tck_ext>,
+                     <&clk_usb1_tap_tck_ext>, <&clk_usb2_tap_tck_ext>,
+                     <&clk_typec_tap_tck_ext>, <&clk_spi_in0_ext>,
+                     <&clk_spi_in1_ext>, <&clk_i2stx_bclk_ext>,
+                     <&clk_i2stx_lrck_ext>;
+            clock-names = "clk_osc", "sys_clk_axi_400",
+                          "sys_clk_vout_root0", "sys_clk_vout_root1",
+                          "sys_clk_usb_wrap_480", "sys_clk_usb_wrap_625",
+                          "sys_clk_usb_wrap_240", "sys_clk_usb_wrap_60",
+                          "sys_clk_usb_wrap_156p25", "sys_clk_usb_wrap_312p5",
+                          "sys_clk_usb_125m", "sys_nw_clk_gpio_100",
+                          "sys_clk_perh_root", "sys_clk_mclk",
+                          "sys_clk_perh_root_preosc",
+                          "sys_clk_ahb0", "sys_clk_apb_bus_per1",
+                          "sys_clk_apb_bus_per2", "sys_clk_apb_bus_per3",
+                          "sys_clk_apb_bus_per5", "sys_clk_venc_root",
+                          "sys_clk_spi_core_100", "clk_glb_ext_clk",
+                          "clk_usb3_tap_tck_ext", "clk_usb1_tap_tck_ext",
+                          "clk_usb2_tap_tck_ext", "clk_typec_tap_tck_ext",
+                          "clk_spi_in0_ext", "clk_spi_in1_ext",
+                          "clk_i2stx_bclk_ext", "clk_i2stx_lrck_ext";
+            #clock-cells = <1>;
+            #reset-cells = <1>;
+    };
diff --git a/include/dt-bindings/clock/starfive,jh8100-crg.h b/include/dt-bindings/clock/starfive,jh8100-crg.h
index 8417455c2409..b30ccd16a802 100644
--- a/include/dt-bindings/clock/starfive,jh8100-crg.h
+++ b/include/dt-bindings/clock/starfive,jh8100-crg.h
@@ -165,4 +165,183 @@
 #define SYSCRG_NW_CLK_UART6_ICG_EN					40
 
 #define SYSCRG_NW_CLK_END						41
+
+/* SYSCRG_NE_CLK */
+#define SYSCRG_NE_CLK_FLEXNOC_DMASLV					0
+#define SYSCRG_NE_CLK_MAILBOX_APB					1
+#define SYSCRG_NE_CLK_SR5_TIMER0_APB					2
+#define SYSCRG_NE_CLK_SR5_TIMER0_CH0					3
+#define SYSCRG_NE_CLK_SR5_TIMER0_CH1					4
+#define SYSCRG_NE_CLK_SR5_TIMER0_CH2					5
+#define SYSCRG_NE_CLK_SR5_TIMER0_CH3					6
+#define SYSCRG_NE_CLK_SR5_TIMER1_APB					7
+#define SYSCRG_NE_CLK_SR5_TIMER1_CH0					8
+#define SYSCRG_NE_CLK_SR5_TIMER1_CH1					9
+#define SYSCRG_NE_CLK_SR5_TIMER1_CH2					10
+#define SYSCRG_NE_CLK_SR5_TIMER1_CH3					11
+#define SYSCRG_NE_CLK_USB3_CMN_SCAN_PLL					12
+#define SYSCRG_NE_CLK_USB3_CMN_SCAN_SER					13
+#define SYSCRG_NE_CLK_USB3_PIPE_IN_SCAN					14
+#define SYSCRG_NE_CLK_USB3_SCAN_PIPE					15
+#define SYSCRG_NE_CLK_USB3_SCAN_PSM					16
+#define SYSCRG_NE_CLK_USB3_SCAN_REF					17
+#define SYSCRG_NE_CLK_USB3_USB2_SCAN					18
+#define SYSCRG_NE_CLK_USB3_HSCLK					19
+#define SYSCRG_NE_CLK_USB3_HSSICLK					20
+#define SYSCRG_NE_CLK_USB3_SIECLK					21
+#define SYSCRG_NE_CLK_USB3_XCVR_SCAN_PLL				22
+#define SYSCRG_NE_CLK_USB3_XCVR_SCAN_SER				23
+#define SYSCRG_NE_CLK_USB3_TAP_TCK					24
+#define SYSCRG_NE_CLK_USB1_CMN_SCAN_PLL					25
+#define SYSCRG_NE_CLK_USB1_CMN_SCAN_SER					26
+#define SYSCRG_NE_CLK_USB1_PIPE_IN_SCAN					27
+#define SYSCRG_NE_CLK_USB1_SCAN_PIPE					28
+#define SYSCRG_NE_CLK_USB1_SCAN_PSM					29
+#define SYSCRG_NE_CLK_USB1_SCAN_REF					30
+#define SYSCRG_NE_CLK_USB1_USB2_SCAN					31
+#define SYSCRG_NE_CLK_USB1_HSCLK					32
+#define SYSCRG_NE_CLK_USB1_HSSICLK					33
+#define SYSCRG_NE_CLK_USB1_SIECLK					34
+#define SYSCRG_NE_CLK_USB1_XCVR_SCAN_PLL				35
+#define SYSCRG_NE_CLK_USB1_XCVR_SCAN_SER				36
+#define SYSCRG_NE_CLK_USB1_TAP_TCK					37
+#define SYSCRG_NE_CLK_USB2_CMN_SCAN_PLL					38
+#define SYSCRG_NE_CLK_USB2_CMN_SCAN_SER					39
+#define SYSCRG_NE_CLK_USB2_PIPE_IN_SCAN					40
+#define SYSCRG_NE_CLK_USB2_SCAN_PIPE					41
+#define SYSCRG_NE_CLK_USB2_SCAN_PSM					42
+#define SYSCRG_NE_CLK_USB2_SCAN_REF					43
+#define SYSCRG_NE_CLK_USB2_USB2_SCAN					44
+#define SYSCRG_NE_CLK_USB2_HSCLK					45
+#define SYSCRG_NE_CLK_USB2_HSSICLK					46
+#define SYSCRG_NE_CLK_USB2_SIECLK					47
+#define SYSCRG_NE_CLK_USB2_XCVR_SCAN_PLL				48
+#define SYSCRG_NE_CLK_USB2_XCVR_SCAN_SER				49
+#define SYSCRG_NE_CLK_USB2_TAP_TCK					50
+#define SYSCRG_NE_CLK_TYPEC_PIPE_DIV_SCAN				51
+#define SYSCRG_NE_CLK_TYPEC_CMN_SCAN_PLL				52
+#define SYSCRG_NE_CLK_TYPEC_CMN_SCAN_SER				53
+#define SYSCRG_NE_CLK_TYPEC_SCAN_PIPE					54
+#define SYSCRG_NE_CLK_TYPEC_SCAN_PSM					55
+#define SYSCRG_NE_CLK_TYPEC_SCAN_REF					56
+#define SYSCRG_NE_CLK_TYPEC_USB2_SCAN					57
+#define SYSCRG_NE_CLK_TYPEC_HSCLK					58
+#define SYSCRG_NE_CLK_TYPEC_HSSICLK					59
+#define SYSCRG_NE_CLK_TYPEC_SIECLK					60
+#define SYSCRG_NE_CLK_TYPEC_VID0					61
+#define SYSCRG_NE_CLK_TYPEC_VID1					62
+#define SYSCRG_NE_CLK_TYPEC_XCVR_SCAN_PLL0				63
+#define SYSCRG_NE_CLK_TYPEC_XCVR_SCAN_PLL1				64
+#define SYSCRG_NE_CLK_TYPEC_XCVR_SCAN_PLL2				65
+#define SYSCRG_NE_CLK_TYPEC_XCVR_SCAN_PLL3				66
+#define SYSCRG_NE_CLK_TYPEC_XCVR_SCAN_SER0				67
+#define SYSCRG_NE_CLK_TYPEC_XCVR_SCAN_SER1				68
+#define SYSCRG_NE_CLK_TYPEC_XCVR_SCAN_SER2				69
+#define SYSCRG_NE_CLK_TYPEC_XCVR_SCAN_SER3				70
+#define SYSCRG_NE_CLK_TYPEC_TAP_TCK					71
+#define SYSCRG_NE_CLK_VENC_AXI						72
+#define SYSCRG_NE_CLK_VC9000LE_AXI					73
+#define SYSCRG_NE_CLK_VC9000LE_APB					74
+#define SYSCRG_NE_CLK_VC9000LE_CORECLK					75
+#define SYSCRG_NE_CLK_INT_CTRL_APB					76
+#define SYSCRG_NE_CLK_PWM_8CH_APB					77
+#define SYSCRG_NE_CLK_WDT_APB						78
+#define SYSCRG_NE_CLK_WDT						79
+#define SYSCRG_NE_CLK_SPI0_APB						80
+#define SYSCRG_NE_CLK_SPI0_CORE						81
+#define SYSCRG_NE_CLK_SPI0_SCLK_IN					82
+#define SYSCRG_NE_CLK_SPI1_APB						83
+#define SYSCRG_NE_CLK_SPI1_CORE						84
+#define SYSCRG_NE_CLK_SPI1_SCLK_IN					85
+#define SYSCRG_NE_CLK_I2C0_APB						86
+#define SYSCRG_NE_CLK_I2C1_APB						87
+#define SYSCRG_NE_CLK_I2C2_APB						88
+#define SYSCRG_NE_CLK_I2C3_APB						89
+#define SYSCRG_NE_CLK_I2C4_APB						90
+#define SYSCRG_NE_CLK_I2C5_APB						91
+#define SYSCRG_NE_CLK_UART0_APB						92
+#define SYSCRG_NE_CLK_UART0_CORE					93
+#define SYSCRG_NE_CLK_UART1_CORE_PREOSC					94
+#define SYSCRG_NE_CLK_UART1_APB						95
+#define SYSCRG_NE_CLK_UART1_CORE					96
+#define SYSCRG_NE_CLK_UART2_CORE_PREOSC					97
+#define SYSCRG_NE_CLK_UART2_APB						98
+#define SYSCRG_NE_CLK_UART2_CORE					99
+#define SYSCRG_NE_CLK_UART3_CORE_PREOSC					100
+#define SYSCRG_NE_CLK_UART3_APB						101
+#define SYSCRG_NE_CLK_UART3_CORE					102
+#define SYSCRG_NE_CLK_UART4_CORE_PREOSC					103
+#define SYSCRG_NE_CLK_UART4_APB						104
+#define SYSCRG_NE_CLK_UART4_CORE					105
+#define SYSCRG_NE_CLK_I2S0_BCLK						106
+#define SYSCRG_NE_CLK_I2S0_LRCK						107
+#define SYSCRG_NE_CLK_I2S0_APB						108
+#define SYSCRG_NE_CLK_I2S0						109
+#define SYSCRG_NE_CLK_I2S0_N						110
+#define SYSCRG_NE_CLK_I2S0_BCLK_TX					111
+#define SYSCRG_NE_CLK_I2S0_LRCK_TX					112
+#define SYSCRG_NE_CLK_I2S0_BCLK_RX					113
+#define SYSCRG_NE_CLK_I2S0_LRCK_RX					114
+#define SYSCRG_NE_CLK_I2S1_BCLK						115
+#define SYSCRG_NE_CLK_I2S1_LRCK						116
+#define SYSCRG_NE_CLK_I2S1_APB						117
+#define SYSCRG_NE_CLK_I2S1						118
+#define SYSCRG_NE_CLK_I2S1_N						119
+#define SYSCRG_NE_CLK_I2S1_BCLK_TX					120
+#define SYSCRG_NE_CLK_I2S1_LRCK_TX					121
+#define SYSCRG_NE_CLK_I2S1_BCLK_RX					122
+#define SYSCRG_NE_CLK_I2S1_LRCK_RX					123
+#define SYSCRG_NE_CLK_I2S2_BCLK						124
+#define SYSCRG_NE_CLK_I2S2_LRCK						125
+#define SYSCRG_NE_CLK_I2S2_APB						126
+#define SYSCRG_NE_CLK_I2S2						127
+#define SYSCRG_NE_CLK_I2S2_N						128
+#define SYSCRG_NE_CLK_I2S2_BCLK_TX					129
+#define SYSCRG_NE_CLK_I2S2_LRCK_TX					130
+#define SYSCRG_NE_CLK_I2S2_BCLK_RX					131
+#define SYSCRG_NE_CLK_I2S2_LRCK_RX					132
+#define SYSCRG_NE_CLK_I2S3_BCLK						133
+#define SYSCRG_NE_CLK_I2S3_LRCK						134
+#define SYSCRG_NE_CLK_I2S0_STEREO_APB					135
+#define SYSCRG_NE_CLK_I2S0_STEREO					136
+#define SYSCRG_NE_CLK_I2S0_STEREO_N					137
+#define SYSCRG_NE_CLK_I2S0_STEREO_BCLK_TX				138
+#define SYSCRG_NE_CLK_I2S0_STEREO_LRCK_TX				139
+#define SYSCRG_NE_CLK_I2S0_STEREO_BCLK_RX_ICG				140
+#define SYSCRG_NE_CLK_I2S0_STEREO_LRCK_RX				141
+#define SYSCRG_NE_CLK_PDM_4MIC_DMIC					142
+#define SYSCRG_NE_CLK_PDM_4MIC_APB					143
+#define SYSCRG_NE_CLK_PDM_4MIC_SCAN					144
+#define SYSCRG_NE_CLK_CAN0_CTRL_PCLK					145
+#define SYSCRG_NE_CLK_CAN0_CTRL						146
+#define SYSCRG_NE_CLK_CAN0_CTRL_TIMER					147
+#define SYSCRG_NE_CLK_CAN1_CTRL_PCLK					148
+#define SYSCRG_NE_CLK_CAN1_CTRL						149
+#define SYSCRG_NE_CLK_CAN1_CTRL_TIMER					150
+#define SYSCRG_NE_CLK_SMBUS0_APB					151
+#define SYSCRG_NE_CLK_SMBUS0_CORE					152
+#define SYSCRG_NE_CLK_IOMUX_EAST_PCLK					153
+#define SYSCRG_NE_CLK_USB3_ICG_EN					154
+#define SYSCRG_NE_CLK_USB1_ICG_EN					155
+#define SYSCRG_NE_CLK_USB2_ICG_EN					156
+#define SYSCRG_NE_CLK_USBC_ICG_EN					157
+#define SYSCRG_NE_CLK_VENC_ICG_EN					158
+#define SYSCRG_NE_CLK_WDT0_ICG_EN					159
+#define SYSCRG_NE_CLK_SPI0_ICG_EN					160
+#define SYSCRG_NE_CLK_SPI1_ICG_EN					161
+#define SYSCRG_NE_CLK_UART0_ICG_EN					162
+#define SYSCRG_NE_CLK_UART1_ICG_EN					163
+#define SYSCRG_NE_CLK_UART2_ICG_EN					164
+#define SYSCRG_NE_CLK_UART3_ICG_EN					165
+#define SYSCRG_NE_CLK_UART4_ICG_EN					166
+#define SYSCRG_NE_CLK_I2S0_ICG_EN					167
+#define SYSCRG_NE_CLK_I2S1_ICG_EN					168
+#define SYSCRG_NE_CLK_I2S2_ICG_EN					169
+#define SYSCRG_NE_CLK_I2S_STEREO_ICG_EN					170
+#define SYSCRG_NE_CLK_PDM_4MIC_ICG_EN					171
+#define SYSCRG_NE_CLK_CAN0_ICG_EN					172
+#define SYSCRG_NE_CLK_CAN1_ICG_EN					173
+#define SYSCRG_NE_CLK_SMBUS0_ICG_EN					174
+
+#define SYSCRG_NE_CLK_END						175
 #endif /* __DT_BINDINGS_CLOCK_STARFIVE_JH8100_H__ */
diff --git a/include/dt-bindings/reset/starfive,jh8100-crg.h b/include/dt-bindings/reset/starfive,jh8100-crg.h
index 8c3a858bdf6a..7626da648686 100644
--- a/include/dt-bindings/reset/starfive,jh8100-crg.h
+++ b/include/dt-bindings/reset/starfive,jh8100-crg.h
@@ -35,4 +35,65 @@
 #define SYSCRG_NW_RSTN_MERAK1_TVSENSOR				9
 
 #define SYSCRG_NW_RESET_NR_RESETS				10
+
+/*
+ * syscrg_ne: assert0
+ */
+#define SYSCRG_NE_RSTN_PRESETN					0
+#define SYSCRG_NE_RSTN_USB3_APB					1
+#define SYSCRG_NE_RSTN_USB3_TORR_PHY				2
+#define SYSCRG_NE_RSTN_USB3_CONFIG				3
+#define SYSCRG_NE_RSTN_USB1_APB					4
+#define SYSCRG_NE_RSTN_USB1_TORRENT_PHY				5
+#define SYSCRG_NE_RSTN_USB1_CONFIG				6
+#define SYSCRG_NE_RSTN_USB2_APB					7
+#define SYSCRG_NE_RSTN_USB2_TORRENT_PHY				8
+#define SYSCRG_NE_RSTN_USB2_CONFIG				9
+#define SYSCRG_NE_RSTN_USBC_APB					10
+#define SYSCRG_NE_RSTN_USBC_CONFIG				11
+#define SYSCRG_NE_RSTN_VC9000LE					12
+#define SYSCRG_NE_RSTN_INT_CTRL_APB				13
+#define SYSCRG_NE_RSTN_PWM_8CH_APB				14
+#define SYSCRG_NE_RSTN_WDT0					15
+#define SYSCRG_NE_RSTN_SPI0					16
+#define SYSCRG_NE_RSTN_SPI1					17
+#define SYSCRG_NE_RSTN_I2C0					18
+#define SYSCRG_NE_RSTN_I2C1					19
+#define SYSCRG_NE_RSTN_I2C2					20
+#define SYSCRG_NE_RSTN_I2C3					21
+#define SYSCRG_NE_RSTN_I2C4					22
+#define SYSCRG_NE_RSTN_I2C5					23
+#define SYSCRG_NE_RSTN_UART0					24
+#define SYSCRG_NE_RSTN_UART1					25
+#define SYSCRG_NE_RSTN_UART2					26
+#define SYSCRG_NE_RSTN_UART3					27
+#define SYSCRG_NE_RSTN_UART4					28
+#define SYSCRG_NE_RSTN_MAILBOX_PRESETN				29
+#define SYSCRG_NE_RSTN_TIMER0_APB				30
+#define SYSCRG_NE_RSTN_TIMER0_CH0				31
+
+/*
+ * syscrg_ne: assert1
+ */
+
+#define SYSCRG_NE_RSTN_TIMER0_CH1				32
+#define SYSCRG_NE_RSTN_TIMER0_CH2				33
+#define SYSCRG_NE_RSTN_TIMER0_CH3				34
+#define SYSCRG_NE_RSTN_TIMER1_APB				35
+#define SYSCRG_NE_RSTN_TIMER1_CH0				36
+#define SYSCRG_NE_RSTN_TIMER1_CH1				37
+#define SYSCRG_NE_RSTN_TIMER1_CH2				38
+#define SYSCRG_NE_RSTN_TIMER1_CH3				39
+#define SYSCRG_NE_RSTN_I2S0_RSTN_APB				40
+#define SYSCRG_NE_RSTN_I2S1_RSTN_APB				41
+#define SYSCRG_NE_RSTN_I2S2_RSTN_APB				42
+#define SYSCRG_NE_RSTN_I2S0_STEREO_APB				43
+#define SYSCRG_NE_RSTN_PDM					44
+#define SYSCRG_NE_RSTN_CAN0					45
+#define SYSCRG_NE_RSTN_CAN1					46
+#define SYSCRG_NE_RSTN_SMBUS0					47
+#define SYSCRG_NE_RSTN_SYS_IOMUX_E				48
+#define SYSCRG_NE_RSTN_DUBHE_TVSENSOR				49
+
+#define SYSCRG_NE_RESET_NR_RESETS				50
 #endif /* __DT_BINDINGS_RESET_STARFIVE_JH8100_H__ */
-- 
2.34.1

