Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5CD79277F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236588AbjIEQDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353493AbjIEGYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 02:24:42 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DB6191;
        Mon,  4 Sep 2023 23:24:38 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bee82fad0fso12107555ad.2;
        Mon, 04 Sep 2023 23:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693895078; x=1694499878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tgPxtoZNb7d2yFvEYd9XD+RxqO3GDREIKuCKzOPCBOU=;
        b=D28LwVUCNj0kJLHDFXzNCOdJHcgsbCAkija3qnpdWreZ+3SJuSYydQvKGc+YWItlyR
         4S2uchJtKZ3fPhSoGkJ/FKMcvwMdpDz70pwUU1kj9wutRoTY4KrV9+zcxSuYd6354Haa
         RYhls7D+Z2rheqWUrDHuGLbvfZD0bbkykc2oSUiOdIvS6hqy1/q1I6eEO7mKHctuhqgW
         TC1G3K6DzTm9sfOqVZjj7byl53G/5Qx0XSq/wMeyv8uOheLKvx6C32ZiDOXg7vyxn93F
         IZpQAPDy6+PX1enjDp3joSsD+TZ7xf1J5zKtjoI3Tv3pCWTrS9vCjQpJVaCFB1V8TT8D
         WymA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693895078; x=1694499878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tgPxtoZNb7d2yFvEYd9XD+RxqO3GDREIKuCKzOPCBOU=;
        b=E59uJZZSOvOlFA1bbjJHAYkE2Gagv+tUFH80o0CtifCgmpYP7FjNThPmyfUwd13act
         kQjyezhanuUhjAUYxTrrqAzyVgmBykhSr8OI+uO9TkNynOYhuylmuvF8kUbsI2XUMmSO
         BYWrCELZvva4c+oK12EFWFmLdsVlzxO6p7Udn+ObRXSlst090WDOYCnPshB4+bwKRmi4
         7dhWKVKpqe+Zk6ztx1/ZZJWHCBrHgm2eODP+HM8oMnWfL8Hsrbsz552LlbpSV+Jngzm9
         xTPDXK8QkyZGSzpOGXxlCwEDOnD7R3BJ9tKyBglADyfTmVyCt/aVMjo1bdIphj2aeU+K
         Mfkw==
X-Gm-Message-State: AOJu0Yztqlo87vsHimTtA2CAkMIkOP8Gsi6IDax/vJmRbY1ioJLwrJhx
        N8WqSHdSM4WFyRUpK2L7xoo=
X-Google-Smtp-Source: AGHT+IFm0nWQ1HLUwpTafEoE36bgB0rFu4+ZEzJADlm47chpF6kQmUKqA0TP1RJ7sr3h/tk+WBjNYQ==
X-Received: by 2002:a17:902:f807:b0:1b9:e937:9763 with SMTP id ix7-20020a170902f80700b001b9e9379763mr9422259plb.12.1693895078377;
        Mon, 04 Sep 2023 23:24:38 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id e18-20020a17090301d200b001bd41b70b60sm8526721plh.45.2023.09.04.23.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 23:24:38 -0700 (PDT)
From:   Peter Yin <peteryin.openbmc@gmail.com>
To:     patrick@stwcx.xyz, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     peter.yin@quantatw.com, Peter Yin <peteryin.openbmc@gmail.com>
Subject: [PATCH v8 1/2] ARM: dts: aspeed: Minerva: Add Facebook Minerva (AST2600) BMC
Date:   Tue,  5 Sep 2023 14:22:21 +0800
Message-Id: <20230905062223.774871-2-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230905062223.774871-1-peteryin.openbmc@gmail.com>
References: <20230905062223.774871-1-peteryin.openbmc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,WEIRD_QUOTING
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add linux device tree entry related to Minerva
specific devices connected to BMC SoC.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../aspeed/aspeed-bmc-facebook-minerva.dts    | 377 ++++++++++++++++++
 2 files changed, 378 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts

diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
index 23cbc7203a8e..b1da302dbcd6 100644
--- a/arch/arm/boot/dts/aspeed/Makefile
+++ b/arch/arm/boot/dts/aspeed/Makefile
@@ -19,6 +19,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-facebook-fuji.dtb \
 	aspeed-bmc-facebook-galaxy100.dtb \
 	aspeed-bmc-facebook-greatlakes.dtb \
+	aspeed-bmc-facebook-minerva.dtb \
 	aspeed-bmc-facebook-minipack.dtb \
 	aspeed-bmc-facebook-tiogapass.dtb \
 	aspeed-bmc-facebook-wedge40.dtb \
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
new file mode 100644
index 000000000000..0bf4e4a7a16c
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -0,0 +1,377 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2023 Facebook Inc.
+/dts-v1/;
+
+#include "aspeed-g6.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
+#include <dt-bindings/i2c/i2c.h>
+
+/ {
+	model = "Facebook Minerva";
+	compatible = "facebook,minerva-bmc", "aspeed,ast2600";
+
+	aliases {
+		serial0 = &uart1;
+		serial4 = &uart5;
+	};
+
+	chosen {
+		stdout-path = &uart5;
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x80000000>;
+	};
+
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3>,
+			<&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
+			<&adc1 2>;
+	};
+};
+
+// HOST BIOS Debug
+&uart1 {
+	status = "okay";
+};
+
+// SOL Host Console
+&uart2 {
+	status = "okay";
+	pinctrl-0 = <>;
+};
+
+// SOL BMC Console
+&uart4 {
+	status = "okay";
+	pinctrl-0 = <>;
+};
+
+// BMC Debug Console
+&uart5 {
+	status = "okay";
+};
+
+//MTIA
+&uart6 {
+	status = "okay";
+};
+
+&uart_routing {
+	status = "okay";
+};
+
+&vuart1 {
+	status = "okay";
+	virtual;
+	port=<0x3e8>;
+	sirq = <7>;
+	sirq-polarity = <0>;
+	dma-mode;
+	dma-channel = <12>;
+};
+
+&wdt1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdtrst1_default>;
+	aspeed,reset-type = "soc";
+	aspeed,external-signal;
+	aspeed,ext-push-pull;
+	aspeed,ext-active-high;
+	aspeed,ext-pulse-duration = <256>;
+};
+
+&mac3 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rmii4_default>;
+	no-hw-checksum;
+	use-ncsi;
+	ncsi-ctrl,start-redo-probe;
+	ncsi-ctrl,no-channel-monitor;
+	mlx,multi-host;
+	ncsi-package = <1>;
+	ncsi-channel = <1>;
+	ncsi-rexmit = <1>;
+	ncsi-timeout = <2>;
+};
+
+&rtc {
+	status = "okay";
+};
+
+&fmc {
+	status = "okay";
+
+	flash@0 {
+		status = "okay";
+		m25p,fast-read;
+		label = "bmc";
+		spi-max-frequency = <50000000>;
+#include "openbmc-flash-layout-128.dtsi"
+	};
+
+	flash@1 {
+		status = "okay";
+		m25p,fast-read;
+		label = "alt-bmc";
+		spi-max-frequency = <50000000>;
+	};
+};
+
+//BIOS Flash
+&spi2 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi2_default>;
+
+	flash@0 {
+		status = "okay";
+		m25p,fast-read;
+		label = "pnor";
+		spi-max-frequency = <12000000>;
+		spi-tx-bus-width = <2>;
+		spi-rx-bus-width = <2>;
+	};
+};
+
+&kcs2 {
+	status = "okay";
+	aspeed,lpc-io-reg = <0xca8>;
+};
+
+&kcs3 {
+	status = "okay";
+	aspeed,lpc-io-reg = <0xca2>;
+};
+
+&lpc_snoop {
+	status = "okay";
+	snoop-ports = <0x80>;
+};
+
+&peci0 {
+	status = "okay";
+	clock-frequency = <1000000>;
+};
+
+&i2c0 {
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+
+	tmp75@4B {
+		compatible = "ti,tmp75";
+		reg = <0x4B>;
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
+// To Debug card
+&i2c14 {
+	status = "okay";
+	multi-master;
+
+	ipmb@10 {
+		compatible = "ipmb-dev";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+		i2c-protocol;
+	};
+};
+
+&i2c15 {
+	status = "okay";
+
+	// SCM FRU
+	eeprom@50 {
+		compatible = "atmel,24c64";
+		reg = <0x50>;
+	};
+	// BSM FRU
+	eeprom@56 {
+		compatible = "atmel,24c64";
+		reg = <0x56>;
+	};
+};
+
+&adc0 {
+	ref_voltage = <2500>;
+	status = "okay";
+	pinctrl-0 = <&pinctrl_adc0_default &pinctrl_adc1_default
+		&pinctrl_adc2_default &pinctrl_adc3_default
+		&pinctrl_adc4_default &pinctrl_adc5_default
+		&pinctrl_adc6_default &pinctrl_adc7_default>;
+};
+
+&adc1 {
+	ref_voltage = <2500>;
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_adc10_default>;
+};
+
+&jtag1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_jtagm_default>;
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&gpio0 {
+	pinctrl-names = "default";
+	gpio-line-names =
+	/*A0-A7*/	"","","","","","","","",
+	/*B0-B7*/	"","","","","","FM_ID_LED_N","","",
+	/*C0-C7*/	"","","","","","","","",
+	/*D0-D7*/	"","","SOL_UART_SET","","","","","",
+	/*E0-E7*/	"","","","","","","","",
+	/*F0-F7*/	"","","","","","","","",
+	/*G0-G7*/	"","","","","","","","",
+	/*H0-H7*/	"","","","","","","","",
+	/*I0-I7*/	"","","","","","","","",
+	/*J0-J7*/	"","","","","","","","",
+	/*K0-K7*/	"","","","","","","","",
+	/*L0-L7*/	"","","","","","","","",
+	/*M0-M7*/	"","","","","","","","",
+	/*N0-N7*/	"LED_POSTCODE_0","LED_POSTCODE_1",
+			"LED_POSTCODE_2","LED_POSTCODE_3",
+			"LED_POSTCODE_4","LED_POSTCODE_5",
+			"LED_POSTCODE_6","LED_POSTCODE_7",
+	/*O0-O7*/	"","","","","","","","",
+	/*P0-P7*/	"FP_SYS_PWRBTN_IN_N","BMC_SYS_PWRBTN_OUT_N",
+			"FP_RST_BTN_IN_N","","","","","",
+	/*Q0-Q7*/	"","","","","","","","",
+	/*R0-R7*/	"","","","","","","","",
+	/*S0-S7*/	"","","","","","","","",
+	/*T0-T7*/	"","","","","","","","",
+	/*U0-U7*/	"","","","","","","","",
+	/*V0-V7*/	"","","","","","","","",
+	/*W0-W7*/	"","","","","","","","",
+	/*X0-X7*/	"","","","","","","","",
+	/*Y0-Y7*/	"","","","","","","","",
+	/*Z0-Z7*/	"","","","","","","","";
+};
+
+&sgpiom0 {
+	status = "okay";
+	max-ngpios = <128>;
+	ngpios = <128>;
+	bus-frequency = <2000000>;
+	gpio-line-names =
+	/*in - out - in - out */
+	/*A0-A3 line 0-7*/
+	"","","","","","ENABLE_SENSORS","","",
+	/*A4-A7 line 8-15*/
+	"","","","","","","","",
+	/*B0-B3 line 16-23*/
+	"","","","","","BMC_RST_BTN_OUT_N","","",
+	/*B4-B7 line 24-31*/
+	"","","","","","","","",
+	/*C0-C3 line 32-39*/
+	"","","","","","","","",
+	/*C4-C7 line 40-47*/
+	"","","","","","","","",
+	/*D0-D3 line 48-55*/
+	"","","","","","","","",
+	/*D4-D7 line 56-63*/
+	"","","","","","","","",
+	/*E0-E3 line 64-71*/
+	"","","","","","","","",
+	/*E4-E7 line 72-79*/
+	"","","","","","","","",
+	/*F0-F3 line 80-87*/
+	"","","","","","","","",
+	/*F4-F7 line 88-95*/
+	"","","","","","","","",
+	/*G0-G3 line 96-103*/
+	"","","","","","","","",
+	/*G4-G7 line 104-111*/
+	"","","","","","","","",
+	/*H0-H3 line 112-119*/
+	"","","","","PLD_SYS_POWER_GOOD","","","",
+	/*H4-H7 line 120-127*/
+	"","","","","","","","",
+	/*I0-I3 line 128-135*/
+	"","","","","","","","",
+	/*I4-I7 line 136-143*/
+	"","","","","","","","",
+	/*J0-J3 line 144-151*/
+	"","","PLD_BIOS_POST_CMPLT_N","","","","","",
+	/*J4-J7 line 152-159*/
+	"","","","","","","","",
+	/*K0-K3 line 160-167*/
+	"","","","","","","","",
+	/*K4-K7 line 168-175*/
+	"","","","","","","","",
+	/*L0-L3 line 176-183*/
+	"","","","","","","","",
+	/*L4-L7 line 184-191*/
+	"","","","","","","","",
+	/*M0-M3 line 192-199*/
+	"","","","","","","","",
+	/*M4-M7 line 200-207*/
+	"","","","","","","","",
+	/*N0-N3 line 208-215*/
+	"","","","","","","","",
+	/*N4-N7 line 216-223*/
+	"","","","","","","","",
+	/*O0-O3 line 224-231*/
+	"","","","","","","","",
+	/*O4-O7 line 232-239*/
+	"","","","","","","","",
+	/*P0-P3 line 240-247*/
+	"","","","","","","","",
+	/*P4-P7 line 248-255*/
+	"","","","","","","","";
+};
-- 
2.25.1

