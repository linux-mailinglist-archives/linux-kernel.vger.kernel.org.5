Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C411E76549B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 15:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233440AbjG0NJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 09:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232922AbjG0NJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 09:09:17 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFD12122
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 06:09:16 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fbd33a57b6so10296335e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 06:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1690463354; x=1691068154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aPehuvtMfYeyvR/xEBwAtpjZIX/eTDZZOcRrVJDqGI8=;
        b=ZWuFMebNoiV/9Gd2C+Hzy0y1hSw3YB5QA9MFHo5dkkpylLLG4LfWOyR2FnaiCEJKBD
         IsWEUup9AHjYUUnG2mT4ULhO3yvl+KpMM8RO55qx0TT3sfKjoeuMJD7jTXekhitkpELa
         dTKofEl7PG24s3hYjRQAeCHbC/sDCChYGZcx+A0UYwsU4aN+/nVuml1po6T00rwYB4HY
         Y3GwPk0OLvUVkcAaNBdDATEXOw42+inSWkTLr9uRS+yOxdc4S9gddYqCI2LMQ2PoFmId
         nNv4j1ek+iDVUd839PLe0yKwyXahihByQlgwCmGOYDepXNSwK/4RpfbQ2YYkvhCu67Zj
         9AZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690463354; x=1691068154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aPehuvtMfYeyvR/xEBwAtpjZIX/eTDZZOcRrVJDqGI8=;
        b=UjS+TwjCkSAS6EJ9c+R97kWs2rCN/b214voR/1Ge4TER9Ob6Y3n88x+2+sDrr9hJBb
         cQvfcoMyVM6gHGm4UfjR8j2LC6wCw3Kbv29xQpyNGzk8oJOFL2vg4xbuV5Y+7l4v9EZa
         Jq2d+ER39v2aSa1usoJEJl6892Xts8smC5q3jEUoNB8+woHB8nJFQYnzuvhXiGLFGKZk
         h4vAPgJuC5Pw2E5zraDJSw2fP6rKX6w9mEuNK04sitWDskrXPPh3OjFwj2Sr4Zuiz9Ic
         3mlyn5YT4VN/cFtBIh6jLyY5Evq1PqVnd4EBnb69e4+mF01xSBW9Hu8tS0RlgrPxdQ86
         Th5g==
X-Gm-Message-State: ABy/qLbJ5QbQOT3sUvOiQrPsNNDFh7W0SOPq0p+OKh1vohv9AZdy+O1d
        b+BC6ejnWELtva8tUcK5r7a13g==
X-Google-Smtp-Source: APBJJlFWV/QXfKHUwZ7txBFv316HnqLZXmrSdUXrF6/2IFZld/xPZHKzTLYCzCnrjN3LuFa3A3PQDQ==
X-Received: by 2002:a05:600c:d5:b0:3fd:4880:2aa5 with SMTP id u21-20020a05600c00d500b003fd48802aa5mr1887222wmm.28.1690463354578;
        Thu, 27 Jul 2023 06:09:14 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:28d:66d0:4512:80d4:6b13:bb70])
        by smtp.gmail.com with ESMTPSA id h14-20020a05600c260e00b003fbca942499sm4698042wma.14.2023.07.27.06.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 06:09:14 -0700 (PDT)
From:   Esteban Blanc <eblanc@baylibre.com>
To:     nm@ti.com, vigneshr@ti.com, kristo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, u-kumar1@ti.com, eblanc@baylibre.com,
        jneanne@baylibre.com, aseketeli@baylibre.com, jpanis@baylibre.com
Subject: [PATCH v4 5/6] arm64: dts: ti: k3-j784s4-evm: Add support for TPS6594 PMIC
Date:   Thu, 27 Jul 2023 15:09:07 +0200
Message-ID: <20230727130908.10656-6-eblanc@baylibre.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230727130908.10656-1-eblanc@baylibre.com>
References: <20230727130908.10656-1-eblanc@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jerome Neanne <jneanne@baylibre.com>

This patch adds support for TPS6593 PMIC on wkup I2C0 bus.
This device provides regulators (bucks and LDOs), but also
GPIOs, a RTC, a watchdog, an ESM (Error Signal Monitor)
which monitors the SoC error output signal, and a PFSM
(Pre-configurable Finite State Machine) which manages the
operational modes of the PMIC.

Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 104 +++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
index 430b8a2c5df5..c37a94ac98cf 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
@@ -251,6 +251,10 @@ vdd_sd_dv: regulator-TLV71033 {
 	};
 };
 
+&wkup_gpio0 {
+	status = "okay";
+};
+
 &main_pmx0 {
 	main_uart8_pins_default: main-uart8-default-pins {
 		pinctrl-single,pins = <
@@ -365,6 +369,17 @@ J784S4_WKUP_IOPAD(0x170, PIN_INPUT, 0) /* (Y36) MCU_ADC1_AIN7 */
 	};
 };
 
+&wkup_pmx1 {
+	status = "okay";
+
+	pmic_irq_pins_default: pmic-irq-pins-default {
+		pinctrl-single,pins = <
+			/* (G33) MCU_OSPI1_CSn1.WKUP_GPIO0_39 */
+			J784S4_WKUP_IOPAD(0x28, PIN_INPUT, 7)
+		>;
+	};
+};
+
 &wkup_pmx0 {
 	mcu_fss0_ospi0_pins_default: mcu-fss0-ospi0-default-pins {
 		pinctrl-single,pins = <
@@ -416,6 +431,95 @@ eeprom@50 {
 		compatible = "atmel,24c256";
 		reg = <0x50>;
 	};
+
+	tps659413: pmic@48 {
+		compatible = "ti,tps6594-q1";
+		reg = <0x48>;
+		system-power-controller;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pmic_irq_pins_default>;
+		interrupt-parent = <&wkup_gpio0>;
+		interrupts = <39 IRQ_TYPE_EDGE_FALLING>;
+		ti,primary-pmic;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		buck12-supply = <&vsys_3v3>;
+		buck3-supply = <&vsys_3v3>;
+		buck4-supply = <&vsys_3v3>;
+		buck5-supply = <&vsys_3v3>;
+		ldo1-supply = <&vsys_3v3>;
+		ldo2-supply = <&vsys_3v3>;
+		ldo3-supply = <&vsys_3v3>;
+		ldo4-supply = <&vsys_3v3>;
+
+		regulators {
+			bucka12: buck12 {
+				regulator-name = "vdd_ddr_1v1";
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			bucka3: buck3 {
+				regulator-name = "vdd_ram_0v85";
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <850000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			bucka4: buck4 {
+				regulator-name = "vdd_io_1v8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			bucka5: buck5 {
+				regulator-name = "vdd_mcu_0v85";
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <850000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldoa1: ldo1 {
+				regulator-name = "vdd_mcuio_1v8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldoa2: ldo2 {
+				regulator-name = "vdd_mcuio_3v3";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldoa3: ldo3 {
+				regulator-name = "vds_dll_0v8";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldoa4: ldo4 {
+				regulator-name = "vda_mcu_1v8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
 };
 
 &mcu_uart0 {
-- 
2.38.5

