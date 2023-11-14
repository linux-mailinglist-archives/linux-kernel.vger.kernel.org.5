Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6107EAEE7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 12:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbjKNL2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 06:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbjKNL2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 06:28:32 -0500
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2673219E;
        Tue, 14 Nov 2023 03:28:28 -0800 (PST)
Received: from hatter.bewilderbeest.net (unknown [IPv6:2602:61:7e5d:5300::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 99FA5E44;
        Tue, 14 Nov 2023 03:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1699961307;
        bh=X2zOJOFR8T5ZGFwJIRFatms9U0JZPZQvGV7tJ2TpVco=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ez8YfTFgG9v0NsKa98F5EPsDJCRHtqaqbiJ0Xe3M2YeIylTlEmu/XQ9xyd2VS9bwz
         qFl8xlmG5sTM3eIp9oLjawHjMGx+ltCNMVWZSKAhVpqgykezotaN4mEhN/S3rvLoPi
         dRob1G+BzK6FonYcK2P5mzdK7yej/BExFWJruJQA=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>
Cc:     Zev Weiss <zev@bewilderbeest.net>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Subject: [PATCH 2/2] ARM: dts: aspeed: Add ASRock SPC621D8HM3 BMC
Date:   Tue, 14 Nov 2023 03:28:22 -0800
Message-ID: <20231114112819.28572-6-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231114112819.28572-4-zev@bewilderbeest.net>
References: <20231114112819.28572-4-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a Xeon board broadly similar (aside from CPU vendor) to the
already-support romed8hm3 (half-width, single-socket, ast2500).  It
doesn't require anything terribly special for OpenBMC support, so this
device-tree should provide everything necessary for basic
functionality with it.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../aspeed/aspeed-bmc-asrock-spc621d8hm3.dts  | 316 ++++++++++++++++++
 2 files changed, 317 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-spc621d8hm3.dts

diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
index d3ac20e316d0..2df0a2e88df7 100644
--- a/arch/arm/boot/dts/aspeed/Makefile
+++ b/arch/arm/boot/dts/aspeed/Makefile
@@ -10,6 +10,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-arm-stardragon4800-rep2.dtb \
 	aspeed-bmc-asrock-e3c246d4i.dtb \
 	aspeed-bmc-asrock-romed8hm3.dtb \
+	aspeed-bmc-asrock-spc621d8hm3.dtb \
 	aspeed-bmc-bytedance-g220a.dtb \
 	aspeed-bmc-delta-ahe50dc.dtb \
 	aspeed-bmc-facebook-bletchley.dtb \
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-spc621d8hm3.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-spc621d8hm3.dts
new file mode 100644
index 000000000000..95b440d90f56
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-spc621d8hm3.dts
@@ -0,0 +1,316 @@
+// SPDX-License-Identifier: GPL-2.0+
+/dts-v1/;
+
+#include "aspeed-g5.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
+#include <dt-bindings/i2c/i2c.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/{
+	model = "ASRock SPC621D8HM3 BMC";
+	compatible = "asrock,spc621d8hm3-bmc", "aspeed,ast2500";
+
+	aliases {
+		serial4 = &uart5;
+
+		i2c20 = &i2c1mux0ch0;
+		i2c21 = &i2c1mux0ch1;
+	};
+
+	chosen {
+		stdout-path = &uart5;
+		bootargs = "console=tty0 console=ttyS4,115200 earlycon";
+	};
+
+	memory@80000000 {
+		reg = <0x80000000 0x20000000>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		heartbeat {
+			gpios = <&gpio ASPEED_GPIO(H, 6) GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "timer";
+		};
+
+		system-fault {
+			gpios = <&gpio ASPEED_GPIO(Z, 2) GPIO_ACTIVE_LOW>;
+			panic-indicator;
+		};
+	};
+
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&adc 0>, <&adc 1>, <&adc 2>, <&adc 3>,
+			<&adc 4>, <&adc 5>, <&adc 6>, <&adc 7>,
+			<&adc 8>, <&adc 9>, <&adc 10>, <&adc 11>,
+			<&adc 12>, <&adc 13>, <&adc 14>, <&adc 15>;
+	};
+};
+
+&fmc {
+	status = "okay";
+	flash@0 {
+		status = "okay";
+		m25p,fast-read;
+		label = "bmc";
+		spi-max-frequency = <50000000>; /* 50 MHz */
+#include "openbmc-flash-layout-64.dtsi"
+	};
+};
+
+&uart5 {
+	status = "okay";
+};
+
+&vuart {
+	status = "okay";
+	aspeed,lpc-io-reg = <0x2f8>;
+	aspeed,lpc-interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&mac0 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rgmii1_default &pinctrl_mdio1_default>;
+
+	nvmem-cells = <&eth0_macaddress>;
+	nvmem-cell-names = "mac-address";
+};
+
+&i2c0 {
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+
+	/* hardware monitor/thermal sensor */
+	temperature-sensor@29 {
+		compatible = "nuvoton,nct7802";
+		reg = <0x29>;
+	};
+
+	/* motherboard temp sensor (TMP1, near BMC) */
+	temperature-sensor@4c {
+		compatible = "nuvoton,w83773g";
+		reg = <0x4c>;
+	};
+
+	/* motherboard FRU eeprom */
+	eeprom@50 {
+		compatible = "st,24c128", "atmel,24c128";
+		reg = <0x50>;
+		pagesize = <16>;
+
+		eth0_macaddress: macaddress@3f80 {
+			reg = <0x3f80 6>;
+		};
+	};
+
+	/* M.2 slot smbus mux */
+	i2c-mux@71 {
+		compatible = "nxp,pca9545";
+		reg = <0x71>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		i2c1mux0ch0: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		i2c1mux0ch1: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+	};
+};
+
+&i2c2 {
+	status = "okay";
+};
+
+&i2c3 {
+	status = "okay";
+};
+
+&i2c4 {
+	status = "okay";
+};
+
+&i2c5 {
+	status = "okay";
+};
+
+&i2c6 {
+	status = "okay";
+};
+
+&i2c7 {
+	status = "okay";
+};
+
+&i2c8 {
+	status = "okay";
+};
+
+&i2c9 {
+	status = "okay";
+};
+
+&i2c10 {
+	status = "okay";
+};
+
+&i2c11 {
+	status = "okay";
+};
+
+&i2c12 {
+	status = "okay";
+};
+
+&i2c13 {
+	status = "okay";
+};
+
+&video {
+	status = "okay";
+};
+
+&vhub {
+	status = "okay";
+};
+
+&lpc_ctrl {
+	status = "okay";
+};
+
+&lpc_snoop {
+	status = "okay";
+	snoop-ports = <0x80>;
+};
+
+&kcs3 {
+	status = "okay";
+	aspeed,lpc-io-reg = <0xca2>;
+};
+
+&peci0 {
+	status = "okay";
+};
+
+&pwm_tacho {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm0_default
+		&pinctrl_pwm2_default
+		&pinctrl_pwm3_default
+		&pinctrl_pwm4_default>;
+
+	fan@0 {
+		reg = <0x00>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x00>;
+	};
+
+	fan@2 {
+		reg = <0x02>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x02>;
+	};
+
+	fan@3 {
+		reg = <0x03>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x03>;
+	};
+
+	fan@4 {
+		reg = <0x04>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x04>;
+	};
+};
+
+&gpio {
+	status = "okay";
+	gpio-line-names =
+		/*  A */ "LOCATORLED_STATUS_N", "LOCATORBTN_N",
+			"BMC_READY_N", "FM_SPD_DDRCPU_LVLSHFT_EN",
+			"", "", "", "",
+		/*  B */ "NODE_ID_1", "NODE_ID_2", "PSU_FAN_FAIL_N", "",
+			"", "", "", "GPIO_RST",
+		/*  C */ "", "", "", "", "", "", "", "",
+		/*  D */ "FP_PWR_BTN_MUX_N", "FM_BMC_PWRBTN_OUT_N",
+			"FP_RST_BTN_N", "RST_BMC_RSTBTN_OUT_N",
+			"NMI_BTN_N", "BMC_NMI",
+			"", "",
+		/*  E */ "", "", "", "FM_ME_RCVR_N", "", "", "", "",
+		/*  F */ "BMC_SMB_SEL_N", "FM_CPU2_DISABLE_COD_N",
+			"FM_REMOTE_DEBUG_BMC_EN", "FM_CPU_ERR0_LVT3_EN",
+			"FM_CPU_ERR1_LVT3_EN", "FM_CPU_ERR2_LVT3_EN",
+			"FM_MEM_THERM_EVENT_CPU1_LVT3_N", "FM_MEM_THERM_EVENT_CPU2_LVT3_N",
+		/*  G */ "HWM_BAT_EN", "", "BMC_PHYRST_N", "FM_BIOS_SPI_BMC_CTRL",
+			"BMC_ALERT1_N", "BMC_ALERT2_N", "BMC_ALERT3_N", "IRQ_SML0_ALERT_N",
+		/*  H */ "BMC_SMB_PRESENT_1_N", "FM_PCH_CORE_VID_0", "FM_PCH_CORE_VID_1", "",
+			"FM_MFG_MODE", "BMC_RTCRST", "BMC_HB_LED_N", "BMC_CASEOPEN",
+		/*  I */ "IRQ_PVDDQ_ABCD_CPU1_VRHOT_LVC3_N", "IRQ_PVDDQ_ABCD_CPU2_VRHOT_LVC3_N",
+			"IRQ_PVDDQ_EFGH_CPU1_VRHOT_LVC3_N", "IRQ_PVDDQ_EFGH_CPU2_VRHOT_LVC3_N",
+			"", "", "", "",
+		/*  J */ "", "", "", "", "", "", "", "",
+		/*  K */ "", "", "", "", "", "", "", "",
+		/*  L */ "", "", "", "", "", "", "", "",
+		/*  M */ "FM_PVCCIN_CPU1_PWR_IN_ALERT_N", "FM_PVCCIN_CPU2_PWR_IN_ALERT_N",
+			"IRQ_PVCCIN_CPU1_VRHOT_LVC3_N", "IRQ_PVCCIN_CPU2_VRHOT_LVC3_N",
+			"FM_CPU1_PROCHOT_BMC_LVC3_N", "",
+			"FM_CPU1_MEMHOT_OUT_N", "FM_CPU2_MEMHOT_OUT_N",
+		/*  N */ "", "", "", "", "", "", "", "",
+		/*  O */ "", "", "", "", "", "", "", "",
+		/*  P */ "", "", "", "", "", "", "", "",
+		/*  Q */ "", "", "", "", "", "", "RST_GLB_RST_WARN_N", "PCIE_WAKE_N",
+		/*  R */ "", "", "FM_BMC_SUSACK_N", "FM_BMC_EUP_LOT6_N",
+			"", "FM_BMC_PCH_SCI_LPC_N", "", "",
+		/*  S */ "FM_DBP_PRESENT_N", "FM_CPU2_SKTOCC_LCT3_N",
+			"FM_CPU1_FIVR_FAULT_LVT3", "FM_CPU2_FIVR_FAULT_LVT3",
+			 "", "", "", "",
+		/*  T */ "", "", "", "", "", "", "", "",
+		/*  U */ "", "", "", "", "", "", "", "",
+		/*  V */ "", "", "", "", "", "", "", "",
+		/*  W */ "", "", "", "", "", "", "", "",
+		/*  X */ "", "", "", "", "", "", "", "",
+		/*  Y */ "FM_SLPS3_N", "FM_SLPS4_N", "", "FM_BMC_ONCTL_N_PLD",
+			"", "", "", "",
+		/*  Z */ "FM_CPU_MSMI_CATERR_LVT3_N", "", "SYSTEM_FAULT_LED_N", "BMC_THROTTLE_N",
+			"", "", "", "",
+		/* AA */ "FM_CPU1_THERMTRIP_LATCH_LVT3_N", "FM_CPU2_THERMTRIP_LATCH_LVT3_N",
+			"FM_BIOS_POST_COMPLT_N", "DBP_BMC_SYSPWROK",
+			"", "IRQ_SML0_ALERT_MUX_N",
+			"IRQ_SMI_ACTIVE_N", "IRQ_NMI_EVENT_N",
+		/* AB */ "FM_PCH_BMC_THERMTRIP_N", "PWRGD_SYS_PWROK",
+			"ME_OVERRIDE", "IRQ_BMC_PCH_SMI_LPC_N",
+			"", "", "", "",
+		/* AC */ "", "", "", "", "", "", "", "";
+};
+
+&adc {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_adc0_default /* 3VSB */
+		&pinctrl_adc1_default	   /* 5VSB */
+		&pinctrl_adc2_default	   /* CPU1 */
+		&pinctrl_adc3_default	   /* NC */
+		&pinctrl_adc4_default	   /* VCCMABCD */
+		&pinctrl_adc5_default	   /* VCCMEFGH */
+		&pinctrl_adc6_default	   /* NC */
+		&pinctrl_adc7_default	   /* NC */
+		&pinctrl_adc8_default	   /* PVNN_PCH */
+		&pinctrl_adc9_default	   /* 1P05PCH */
+		&pinctrl_adc10_default	   /* 1P8PCH */
+		&pinctrl_adc11_default	   /* BAT */
+		&pinctrl_adc12_default	   /* 3V */
+		&pinctrl_adc13_default	   /* 5V */
+		&pinctrl_adc14_default	   /* 12V */
+		&pinctrl_adc15_default>;   /* GND */
+};
-- 
2.42.0

