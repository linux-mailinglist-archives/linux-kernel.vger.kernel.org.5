Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CEF0806F29
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377919AbjLFLxR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Dec 2023 06:53:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377867AbjLFLxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:53:00 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC83826AF;
        Wed,  6 Dec 2023 03:52:22 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 3F79C24E311;
        Wed,  6 Dec 2023 19:52:21 +0800 (CST)
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 6 Dec
 2023 19:52:21 +0800
Received: from jsia-virtual-machine.localdomain (175.136.135.142) by
 EXMBX066.cuchost.com (172.16.6.66) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Wed, 6 Dec 2023 19:52:14 +0800
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
Subject: [PATCH v1 16/16] riscv: dts: starfive: jh8100: Add clocks and resets nodes
Date:   Wed, 6 Dec 2023 19:50:00 +0800
Message-ID: <20231206115000.295825-17-jeeheng.sia@starfivetech.com>
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

Add SYSCRG/SYSCRG-NE/SYSCRG-NW/SYSCRG-SW/AONCRG clock and reset
nodes for JH8100 RISC-V SoC.

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
---
 arch/riscv/boot/dts/starfive/jh8100-clk.dtsi | 180 +++++++++++++++++++
 arch/riscv/boot/dts/starfive/jh8100.dtsi     | 115 ++++++++++++
 2 files changed, 295 insertions(+)
 create mode 100644 arch/riscv/boot/dts/starfive/jh8100-clk.dtsi

diff --git a/arch/riscv/boot/dts/starfive/jh8100-clk.dtsi b/arch/riscv/boot/dts/starfive/jh8100-clk.dtsi
new file mode 100644
index 000000000000..27ba249f523e
--- /dev/null
+++ b/arch/riscv/boot/dts/starfive/jh8100-clk.dtsi
@@ -0,0 +1,180 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2023 StarFive Technology Co., Ltd.
+ */
+
+/ {
+	clk_osc: clk_osc {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+	};
+
+	clk_i2srx_bclk_ext: clk_i2srx_bclk_ext {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <12288000>;
+	};
+
+	clk_i2srx_lrck_ext: clk_i2srx_lrck_ext {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <192000>;
+	};
+
+	clk_mclk_ext: clk_mclk_ext {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <49152000>;
+	};
+	/* sys-ne */
+	clk_usb3_tap_tck_ext: clk_usb3_tap_tck_ext {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+	};
+
+	clk_glb_ext_clk: clk_glb_ext_clk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <30000000>;
+	};
+
+	clk_usb1_tap_tck_ext: clk_usb1_tap_tck_ext {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+	};
+
+	clk_usb2_tap_tck_ext: clk_usb2_tap_tck_ext {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+	};
+
+	clk_i2s_tscko: clk_i2s_tscko {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <12800000>;
+	};
+
+	clk_typec_tap_tck_ext: clk_typec_tap_tck_ext {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+	};
+
+	clk_spi_in0_ext: clk_spi_in0_ext {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+	};
+
+	clk_spi_in1_ext: clk_spi_in1_ext {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+	};
+
+	clk_spi_in2_ext: clk_spi_in2_ext {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+	};
+
+	clk_i2stx_bclk_ext: clk_i2stx_bclk_ext {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <12288000>;
+	};
+
+	clk_i2stx_lrck_ext: clk_i2stx_lrck_ext {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <192000>;
+	};
+	/* sys-nw */
+	clk_dvp_ext: clk_dvp_ext {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <150000000>;
+	};
+
+	clk_isp_dphy_tap_tck_ext: clk_isp_dphy_tap_tck_ext {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+	};
+
+	clk_vout_mipi_dphy_tap_tck_ext: clk_vout_mipi_dphy_tap_tck_ext {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+	};
+
+	clk_vout_edp_tap_tck_ext: clk_vout_edp_tap_tck_ext {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+	};
+
+	clk_rtc: clk_rtc {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+	};
+	/* aon */
+	clk_gmac0_rmii_func: clk_gmac0_rmii_func {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <50000000>;
+	};
+
+	clk_gmac0_rgmii_func: clk_gmac0_rgmii_func {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <125000000>;
+	};
+
+	clk_aon50: clk_aon50 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <50000000>;
+	};
+
+	clk_aon125: clk_aon125 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <125000000>;
+	};
+
+	clk_aon2000: clk_aon2000 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <2000000000>;
+	};
+
+	clk_aon200: clk_aon200 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <200000000>;
+	};
+
+	clk_aon667: clk_isp_aon667 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <667000000>;
+	};
+
+	clk_i3c_ext: clk_i3c_ext {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <12500000>;
+	};
+
+	clk_espi_ext: clk_espi_ext {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <60000000>;
+	};
+};
diff --git a/arch/riscv/boot/dts/starfive/jh8100.dtsi b/arch/riscv/boot/dts/starfive/jh8100.dtsi
index f26aff5c1ddf..9863c61324a0 100644
--- a/arch/riscv/boot/dts/starfive/jh8100.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh8100.dtsi
@@ -4,6 +4,9 @@
  */
 
 /dts-v1/;
+#include <dt-bindings/clock/starfive,jh8100-crg.h>
+#include <dt-bindings/reset/starfive,jh8100-crg.h>
+#include "jh8100-clk.dtsi"
 
 / {
 	compatible = "starfive,jh8100";
@@ -357,6 +360,104 @@ uart4: serial@121a0000  {
 			status = "disabled";
 		};
 
+		syscrg_ne: syscrg_ne@12320000 {
+			compatible = "starfive,jh8100-syscrg-ne";
+			reg = <0x0 0x12320000 0x0 0x10000>;
+			clocks = <&clk_osc>, <&syscrg SYSCRG_CLK_AXI_400>,
+				 <&syscrg SYSCRG_CLK_VOUT_ROOT0>,
+				 <&syscrg SYSCRG_CLK_VOUT_ROOT1>,
+				 <&syscrg SYSCRG_CLK_USB_WRAP_480>,
+				 <&syscrg SYSCRG_CLK_USB_WRAP_625>,
+				 <&syscrg SYSCRG_CLK_USB_WRAP_240>,
+				 <&syscrg SYSCRG_CLK_USB_WRAP_60>,
+				 <&syscrg SYSCRG_CLK_USB_WRAP_156P25>,
+				 <&syscrg SYSCRG_CLK_USB_WRAP_312P5>,
+				 <&syscrg SYSCRG_CLK_USB_125M>,
+				 <&syscrg_nw SYSCRG_NW_CLK_GPIO_100>,
+				 <&syscrg SYSCRG_CLK_PERH_ROOT>, <&syscrg SYSCRG_CLK_MCLK>,
+				 <&syscrg SYSCRG_CLK_PERH_ROOT_PREOSC>,
+				 <&syscrg SYSCRG_CLK_AHB0>,
+				 <&syscrg SYSCRG_CLK_APB_BUS_PER1>,
+				 <&syscrg SYSCRG_CLK_APB_BUS_PER2>,
+				 <&syscrg SYSCRG_CLK_APB_BUS_PER3>,
+				 <&syscrg SYSCRG_CLK_APB_BUS_PER5>,
+				 <&syscrg SYSCRG_CLK_VENC_ROOT>,
+				 <&syscrg SYSCRG_CLK_SPI_CORE_100>,
+				 <&clk_glb_ext_clk>, <&clk_usb3_tap_tck_ext>,
+				 <&clk_usb1_tap_tck_ext>, <&clk_usb2_tap_tck_ext>,
+				 <&clk_typec_tap_tck_ext>, <&clk_spi_in0_ext>,
+				 <&clk_spi_in1_ext>, <&clk_i2stx_bclk_ext>, <&clk_i2stx_lrck_ext>;
+			clock-names = "clk_osc", "sys_clk_axi_400",
+				      "sys_clk_vout_root0", "sys_clk_vout_root1",
+				      "sys_clk_usb_wrap_480", "sys_clk_usb_wrap_625",
+				      "sys_clk_usb_wrap_240", "sys_clk_usb_wrap_60",
+				      "sys_clk_usb_wrap_156p25", "sys_clk_usb_wrap_312p5",
+				      "sys_clk_usb_125m", "sys_nw_clk_gpio_100",
+				      "sys_clk_perh_root", "sys_clk_mclk",
+				      "sys_clk_perh_root_preosc", "sys_clk_ahb0",
+				      "sys_clk_apb_bus_per1", "sys_clk_apb_bus_per2",
+				      "sys_clk_apb_bus_per3", "sys_clk_apb_bus_per5",
+				      "sys_clk_venc_root", "sys_clk_spi_core_100",
+				      "clk_glb_ext_clk", "clk_usb3_tap_tck_ext",
+				      "clk_usb1_tap_tck_ext", "clk_usb2_tap_tck_ext",
+				      "clk_typec_tap_tck_ext", "clk_spi_in0_ext",
+				      "clk_spi_in1_ext", "clk_i2stx_bclk_ext",
+				      "clk_i2stx_lrck_ext";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
+		syscrg_nw: syscrg_nw@123c0000 {
+			compatible = "starfive,jh8100-syscrg-nw";
+			reg = <0x0 0x123c0000 0x0 0x10000>;
+			clocks = <&clk_osc>, <&syscrg SYSCRG_CLK_APB_BUS>,
+				 <&syscrg SYSCRG_CLK_ISP_2X>, <&syscrg SYSCRG_CLK_ISP_AXI>,
+				 <&syscrg SYSCRG_CLK_VOUT_ROOT0>, <&syscrg SYSCRG_CLK_VOUT_ROOT1>,
+				 <&syscrg SYSCRG_CLK_VOUT_SCAN_ATS>,
+				 <&syscrg SYSCRG_CLK_VOUT_DC_CORE>, <&syscrg SYSCRG_CLK_VOUT_AXI>,
+				 <&syscrg SYSCRG_CLK_AXI_400>, <&syscrg SYSCRG_CLK_AXI_200>,
+				 <&syscrg SYSCRG_CLK_PERH_ROOT_PREOSC>,
+				 <&clk_dvp_ext>, <&clk_isp_dphy_tap_tck_ext>,
+				 <&clk_glb_ext_clk>, <&clk_i2s_tscko>,
+				 <&clk_vout_mipi_dphy_tap_tck_ext>, <&clk_vout_edp_tap_tck_ext>,
+				 <&clk_spi_in2_ext>;
+			clock-names = "clk_osc", "sys_clk_apb_bus",
+				      "sys_clk_isp_2x", "sys_clk_isp_axi",
+				      "sys_clk_vout_root0", "sys_clk_vout_root1",
+				      "sys_clk_vout_scan_ats", "sys_clk_vout_dc_core",
+				      "sys_clk_vout_axi", "sys_clk_axi_400",
+				      "sys_clk_axi_200", "sys_clk_perh_root_preosc", "clk_dvp_ext",
+				      "clk_isp_dphy_tap_tck_ext", "clk_glb_ext_clk",
+				      "clk_i2s_tscko", "clk_vout_mipi_dphy_tap_tck_ext",
+				      "clk_vout_edp_tap_tck_ext", "clk_spi_in2_ext";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
+		syscrg: syscrg@126d0000 {
+			compatible = "starfive,jh8100-syscrg";
+			reg = <0x0 0x126d0000 0x0 0x10000>;
+			clocks = <&clk_osc>, <&clk_i2srx_bclk_ext>,
+				 <&clk_i2srx_lrck_ext>, <&clk_mclk_ext>;
+			clock-names = "clk_osc", "clk_i2srx_bclk_ext",
+				      "clk_i2srx_lrck_ext", "clk_mclk_ext";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
+		syscrg_sw: syscrg_sw@12720000 {
+			compatible = "starfive,jh8100-syscrg-sw";
+			reg = <0x0 0x12720000 0x0 0x10000>;
+			clocks = <&syscrg SYSCRG_CLK_APB_BUS>,
+				 <&syscrg SYSCRG_CLK_VDEC_ROOT>,
+				 <&syscrg SYSCRG_CLK_FLEXNOC1>;
+			clock-names = "sys_clk_apb_bus",
+				      "sys_clk_vdec_root",
+				      "sys_clk_flexnoc1";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
 		uart5: serial@127d0000  {
 			compatible = "starfive,jh8100-uart", "cdns,uart-r1p8";
 			reg = <0x0 0x127d0000 0x0 0x10000>;
@@ -374,5 +475,19 @@ uart6: serial@127e0000  {
 			interrupts = <73>;
 			status = "disabled";
 		};
+
+		aoncrg: aoncrg@1f310000 {
+			compatible = "starfive,jh8100-aoncrg";
+			reg = <0x0 0x1f310000 0x0 0x10000>;
+			clocks = <&clk_osc>, <&clk_gmac0_rmii_func>,
+				 <&clk_gmac0_rgmii_func>, <&clk_aon125>,
+				 <&clk_aon2000>, <&clk_aon200>,
+				 <&clk_aon667>, <&clk_rtc>;
+			clock-names = "clk_osc", "clk_gmac0_rmii_func", "clk_gmac0_rgmii_func",
+				      "clk_aon125", "clk_aon2000", "clk_aon200",
+				      "clk_aon667", "clk_rtc";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
 	};
 };
-- 
2.34.1

