Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF608032D9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344030AbjLDMd7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 4 Dec 2023 07:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235483AbjLDMd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:33:26 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0923A196;
        Mon,  4 Dec 2023 04:33:24 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id AB67124E24C;
        Mon,  4 Dec 2023 20:33:17 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 4 Dec
 2023 20:33:17 +0800
Received: from xiaofei.localdomain (180.164.60.184) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 4 Dec
 2023 20:33:17 +0800
From:   Keith Zhao <keith.zhao@starfivetech.com>
To:     Keith Zhao <keith.zhao@starfivetech.com>,
        <devicetree@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
CC:     <mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <william.qiu@starfivetech.com>, <xingyu.wu@starfivetech.com>,
        <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <palmer@dabbelt.com>, <p.zabel@pengutronix.de>,
        <shengyang.chen@starfivetech.com>, <jack.zhu@starfivetech.com>,
        <changhuang.liang@starfivetech.com>,
        <maarten.lankhorst@linux.intel.com>, <suijingfeng@loongson.cn>
Subject: [v3 2/6] riscv: dts: starfive: jh7110: display subsystem
Date:   Mon, 4 Dec 2023 20:33:11 +0800
Message-ID: <20231204123315.28456-3-keith.zhao@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231204123315.28456-1-keith.zhao@starfivetech.com>
References: <20231204123315.28456-1-keith.zhao@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [180.164.60.184]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the dc controller and hdmi node for the Starfive JH7110 SoC.

Signed-off-by: Keith Zhao <keith.zhao@starfivetech.com>
---
 .../jh7110-starfive-visionfive-2.dtsi         | 134 ++++++++++++++++++
 arch/riscv/boot/dts/starfive/jh7110.dtsi      |  49 +++++++
 2 files changed, 183 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
index b89e9791efa7..6e387e0138c0 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
@@ -35,6 +35,25 @@ memory@40000000 {
 		reg = <0x0 0x40000000 0x1 0x0>;
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		/* vout applies for space from this CMA
+		 * Without this CMA reservation,
+		 * vout may not work properly.
+		 */
+		linux,cma {
+			compatible = "shared-dma-pool";
+			reusable;
+			size = <0x0 0x20000000>;
+			alignment = <0x0 0x1000>;
+			alloc-ranges = <0x0 0x70000000 0x0 0x20000000>;
+			linux,cma-default;
+		};
+	};
+
 	gpio-restart {
 		compatible = "gpio-restart";
 		gpios = <&sysgpio 35 GPIO_ACTIVE_HIGH>;
@@ -69,6 +88,68 @@ codec {
 	};
 };
 
+&dc8200 {
+	status = "okay";
+
+	crtc_out: ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		dc_out0: port@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			dc_out_dpi0: endpoint@0 {
+				reg = <0>;
+				remote-endpoint = <&hdmi_enc>;
+			};
+
+		};
+
+		dc_out1: port@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			dc_out_dpi1: endpoint@1 {
+				reg = <1>;
+				remote-endpoint = <&dsi_enc>;
+			};
+
+		};
+	};
+};
+
+&display {
+	status = "okay";
+	ports = <&crtc_out>;
+};
+
+&dsi_encoder {
+	status = "okay";
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		/* input */
+		enc_in: port@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+			dsi_enc:endpoint@0 {
+				reg = <0>;
+				remote-endpoint = <&dc_out_dpi1>;
+			};
+		};
+		/* output */
+		enc_out: port@1 {
+			reg = <1>;
+			/*need add a remote-endpoint to dsi bridge*/
+		};
+	};
+};
+
 &dvp_clk {
 	clock-frequency = <74250000>;
 };
@@ -89,6 +170,21 @@ &gmac1_rmii_refin {
 	clock-frequency = <50000000>;
 };
 
+&hdmi {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&hdmi_pins>;
+
+	hdmi_in: port {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		hdmi_enc: endpoint@0 {
+			reg = <0>;
+			remote-endpoint = <&dc_out_dpi0>;
+		};
+	};
+};
+
 &hdmitx0_pixelclk {
 	clock-frequency = <297000000>;
 };
@@ -336,6 +432,40 @@ spi_dev0: spi@0 {
 };
 
 &sysgpio {
+	hdmi_pins: hdmi-0 {
+		hdmi-cec-pins {
+			pinmux = <GPIOMUX(14, GPOUT_SYS_HDMI_CEC_SDA,
+					     GPOEN_SYS_HDMI_CEC_SDA,
+					     GPI_SYS_HDMI_CEC_SDA)>;
+			input-enable;
+			bias-pull-up;
+		};
+
+		hdmi-hpd-pins {
+			pinmux = <GPIOMUX(15, GPOUT_HIGH,
+					     GPOEN_ENABLE,
+					     GPI_SYS_HDMI_HPD)>;
+			input-enable;
+			bias-disable; /* external pull-up */
+		};
+
+		hdmi-scl-pins {
+			pinmux = <GPIOMUX(0, GPOUT_SYS_HDMI_DDC_SCL,
+					     GPOEN_SYS_HDMI_DDC_SCL,
+					     GPI_SYS_HDMI_DDC_SCL)>;
+			input-enable;
+			bias-pull-up;
+		};
+
+		hdmi-sda-pins {
+			pinmux = <GPIOMUX(1, GPOUT_SYS_HDMI_DDC_SDA,
+					     GPOEN_SYS_HDMI_DDC_SDA,
+					     GPI_SYS_HDMI_DDC_SDA)>;
+			input-enable;
+			bias-pull-up;
+		};
+	};
+
 	i2c0_pins: i2c0-0 {
 		i2c-pins {
 			pinmux = <GPIOMUX(57, GPOUT_LOW,
@@ -642,3 +772,7 @@ &U74_3 {
 &U74_4 {
 	cpu-supply = <&vdd_cpu>;
 };
+
+&voutcrg {
+	status = "okay";
+};
diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
index 45213cdf50dc..df51b9407328 100644
--- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
@@ -344,6 +344,24 @@ tdm_ext: tdm-ext-clock {
 		#clock-cells = <0>;
 	};
 
+	display: display-subsystem {
+		compatible = "starfive,display-subsystem";
+
+		clocks = <&syscrg JH7110_SYSCLK_NOC_BUS_DISP_AXI>,
+			<&voutcrg JH7110_VOUTCLK_DC8200_CORE>,
+			<&voutcrg JH7110_VOUTCLK_DC8200_AXI>,
+			<&voutcrg JH7110_VOUTCLK_DC8200_AHB>;
+		clock-names = "noc_bus", "dc_core", "axi_core", "ahb";
+		resets = <&voutcrg JH7110_VOUTRST_DC8200_AXI>,
+			 <&voutcrg JH7110_VOUTRST_DC8200_AHB>,
+			 <&voutcrg JH7110_VOUTRST_DC8200_CORE>;
+		reset-names = "axi","ahb", "core";
+	};
+
+	dsi_encoder: dsi_encoder {
+		compatible = "starfive,dsi-encoder";
+		starfive,syscon = <&vout_syscon 0x8 0x08>;
+	};
 	soc {
 		compatible = "simple-bus";
 		interrupt-parent = <&plic>;
@@ -1121,6 +1139,37 @@ ispcrg: clock-controller@19810000 {
 			power-domains = <&pwrc JH7110_PD_ISP>;
 		};
 
+		dc8200: lcd-controller@29400000 {
+			compatible = "starfive,jh7110-dc8200";
+			reg = <0x0 0x29400000 0x0 0x100>,
+			      <0x0 0x29400800 0x0 0x2000>;
+			interrupts = <95>;
+			clocks = <&voutcrg JH7110_VOUTCLK_DC8200_PIX0>,
+				<&voutcrg JH7110_VOUTCLK_DC8200_PIX1>,
+				<&hdmitx0_pixelclk>,
+				<&voutcrg JH7110_VOUTCLK_DC8200_PIX>;
+			clock-names = "channel0", "channel1",
+				      "hdmi_tx", "dc_parent";
+		};
+
+		hdmi: hdmi@29590000 {
+			compatible = "starfive,jh7110-inno-hdmi";
+			reg = <0x0 0x29590000 0x0 0x4000>;
+			interrupts = <99>;
+
+			clocks = <&voutcrg JH7110_VOUTCLK_HDMI_TX_SYS>,
+				 <&voutcrg JH7110_VOUTCLK_HDMI_TX_MCLK>,
+				 <&voutcrg JH7110_VOUTCLK_HDMI_TX_BCLK>;
+			clock-names = "sysclk", "mclk", "bclk";
+			resets = <&voutcrg JH7110_VOUTRST_HDMI_TX_HDMI>;
+			#sound-dai-cells = <0>;
+		};
+
+		vout_syscon: syscon@295b0000 {
+			compatible = "starfive,jh7110-vout-syscon", "syscon";
+			reg = <0 0x295b0000 0 0x90>;
+		};
+
 		voutcrg: clock-controller@295c0000 {
 			compatible = "starfive,jh7110-voutcrg";
 			reg = <0x0 0x295c0000 0x0 0x10000>;
-- 
2.34.1

