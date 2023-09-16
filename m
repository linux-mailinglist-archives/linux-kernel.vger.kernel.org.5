Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2AA7A30B3
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 15:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239317AbjIPNm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 09:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238064AbjIPNmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 09:42:14 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE921B9
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 06:42:08 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-402d499580dso33020685e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 06:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aceart.de; s=google; t=1694871726; x=1695476526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s0I8BJSJSrTtLmXJmST4e4bGFxlH1XXWk8PPdm7U7Gg=;
        b=WhtKFFu/eBi0je+J7DUmP5fqKL8Tmty1vmoZLt1y1KCbqaG1Sn0PhQdzBx++qAjRL7
         We+KwyIRbJQQ8FK7czYPY7LlCn3nYf00EhUA9/xswTzQp2nm8freLre8K9QbvWN3/sgY
         z1+obSS2u6pS4KDolk3miLCB8hjI8SBQ2/H3/GLrFdVR3Tk0HkJ/uupxCHJYf3Db4BPB
         b8lyGnEMFYB+JcxjtILLW9vfe1QDSCRwgxk/OKBi82WrAeH6jjkhV1DiSP+mV0xTNgyN
         p/x8vK9CEHUhkQZDl+ORtbFmVNM2kFQ/sRr81nK/2ZNHVh/kjbkTJQvnL93oHWbiPXX1
         ylrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694871726; x=1695476526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s0I8BJSJSrTtLmXJmST4e4bGFxlH1XXWk8PPdm7U7Gg=;
        b=cBcnsDEC9iRmPoAkztCyNPRb1DP/rY2durO1DU1XGytCUN42g/mQUh546+/sku1xZv
         HELpTy2FReUIfXtitSuxCB0+R8XT5ruCAG9kgBwGxGMbUDnZZPvxZTT2hKn7PvqbVUtl
         3xyLlvl1d2aXLDhtZGvJwPiMOKefLG8SRfn8W/M2Pp3cnHkaXZ0LYcybgXgG85dFjPhb
         84MKmE0Fhf3zhiV+lJq8dKbZ3QOqZKx/T531HxyURL2+zL8JdvtCL1BZNQbYp0LwsopD
         mpy+iGxX32KTjdosleTKI8P7YCzvsK/Le5Y1rFhYFq5OD9rCW1lk7BbzHxG6lOmOMUJM
         ko3g==
X-Gm-Message-State: AOJu0YzONQlD+W8E60cVBlxVM7jVWwy1v0uzhlLytCqCGTjhWtWMLq3o
        sppLP5wPkRm3PD6byFiqbf/ccA==
X-Google-Smtp-Source: AGHT+IELZqvkNVTmJMDr3SU0R3hrtymCvVzj/I4wfPIbQWyXKCLSTxr5HVR7XLjBaNJN+6WFp4BgDA==
X-Received: by 2002:a1c:7706:0:b0:401:2ee0:754a with SMTP id t6-20020a1c7706000000b004012ee0754amr4059600wmi.13.1694871726672;
        Sat, 16 Sep 2023 06:42:06 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8070:d84:9160:acd3:26fc:724e:a2dd])
        by smtp.gmail.com with ESMTPSA id f13-20020a5d568d000000b0031fd849e797sm7144278wrv.105.2023.09.16.06.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Sep 2023 06:42:06 -0700 (PDT)
From:   Lukas Walter <lukas.walter@aceart.de>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Lukas Walter <lukas.walter@aceart.de>,
        Raymond Hackley <raymondhackley@protonmail.com>
Subject: [PATCH 2/2] arm64: dts: qcom: msm8939-huawei-kiwi: Add initial device tree
Date:   Sat, 16 Sep 2023 15:41:47 +0200
Message-ID: <20230916134147.163764-2-lukas.walter@aceart.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230916134147.163764-1-lukas.walter@aceart.de>
References: <20230916134147.163764-1-lukas.walter@aceart.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This dts adds support for Huawei Honor 5X / GR5 (2016) smartphone
released in 2015.

Add device tree with initial support for:

- GPIO keys
- Hall sensor
- SDHCI (internal and external storage)
- WCNSS (BT/WIFI)
- Sensors (accelerometer, proximity and gyroscope)
- Vibrator
- Touchscreen

Signed-off-by: Lukas Walter <lukas.walter@aceart.de>
Signed-off-by: Raymond Hackley <raymondhackley@protonmail.com>
---
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../boot/dts/qcom/msm8939-huawei-kiwi.dts     | 238 ++++++++++++++++++
 2 files changed, 239 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8939-huawei-kiwi.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 2cca20563a1d..be9781c8e693 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -41,6 +41,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-thwc-uf896.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-thwc-ufi001c.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-wingtech-wt88047.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-yiming-uz801v3.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= msm8939-huawei-kiwi.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8939-samsung-a7.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8939-sony-xperia-kanuti-tulip.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-motorola-potter.dtb
diff --git a/arch/arm64/boot/dts/qcom/msm8939-huawei-kiwi.dts b/arch/arm64/boot/dts/qcom/msm8939-huawei-kiwi.dts
new file mode 100644
index 000000000000..19bd95233774
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8939-huawei-kiwi.dts
@@ -0,0 +1,238 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/dts-v1/;
+
+#include "msm8939-pm8916.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	model = "Huawei Honor 5X / GR5 (2016)";
+	compatible = "huawei,kiwi", "qcom,msm8939";
+	chassis-type = "handset";
+
+	aliases {
+		mmc0 = &sdhc_1; /* SDC1 eMMC slot */
+		mmc1 = &sdhc_2; /* SDC2 SD card slot */
+		serial0 = &blsp_uart2;
+	};
+
+	chosen {
+		stdout-path = "serial0";
+	};
+
+	reserved-memory {
+		reserved@84a00000 {
+			reg = <0x0 0x84a00000 0x0 0x1600000>;
+			no-map;
+		};
+	};
+
+	gpio-hall-sensor {
+		compatible = "gpio-keys";
+
+		pinctrl-0 = <&gpio_hall_sensor_default>;
+		pinctrl-names = "default";
+
+		label = "GPIO Hall Effect Sensor";
+
+		event-hall-sensor {
+			label = "Hall Effect Sensor";
+			gpios = <&tlmm 69 GPIO_ACTIVE_LOW>;
+			linux,input-type = <EV_SW>;
+			linux,code = <SW_LID>;
+			linux,can-disable;
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		pinctrl-0 = <&gpio_keys_default>;
+		pinctrl-names = "default";
+
+		label = "GPIO Buttons";
+
+		button-volume-up {
+			label = "Volume Up";
+			gpios = <&tlmm 107 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEUP>;
+		};
+	};
+
+	usb_id: usb-id {
+		compatible = "linux,extcon-usb-gpio";
+		id-gpios = <&tlmm 110 GPIO_ACTIVE_HIGH>;
+		pinctrl-0 = <&usb_id_default>;
+		pinctrl-names = "default";
+	};
+};
+
+&blsp_i2c2 {
+	status = "okay";
+
+	accelerometer@1e {
+		compatible = "kionix,kx023-1025";
+		reg = <0x1e>;
+
+		vdd-supply = <&pm8916_l17>;
+		vddio-supply = <&pm8916_l6>;
+		pinctrl-0 = <&accel_int_default>;
+		pinctrl-names = "default";
+		mount-matrix = "-1", "0", "0",
+			       "0", "1", "0",
+			       "0", "0", "1";
+	};
+
+	proximity@39 {
+		compatible = "avago,apds9930";
+		reg = <0x39>;
+
+		interrupt-parent = <&tlmm>;
+		interrupts = <113 IRQ_TYPE_EDGE_FALLING>;
+
+		vdd-supply = <&pm8916_l17>;
+		vddio-supply = <&pm8916_l6>;
+
+		led-max-microamp = <25000>;
+		amstaos,proximity-diodes = <0>;
+
+		pinctrl-0 = <&prox_irq_default>;
+		pinctrl-names = "default";
+	};
+};
+
+&blsp_i2c5 {
+	status = "okay";
+
+	touchscreen@1c {
+		compatible = "cypress,tt21000";
+
+		reg = <0x1c>;
+		interrupt-parent = <&tlmm>;
+		interrupts = <13 IRQ_TYPE_EDGE_FALLING>;
+
+		reset-gpios = <&tlmm 12 GPIO_ACTIVE_LOW>;
+
+		/*
+		 * NOTE: vdd is not directly supplied by pm8916_l16, it seems to be a
+		 * fixed regulator that is automatically enabled by pm8916_l16.
+		 */
+		vdd-supply = <&pm8916_l16>;
+		vddio-supply = <&pm8916_l16>;
+
+		pinctrl-0 = <&touchscreen_default>;
+		pinctrl-names = "default";
+	};
+};
+
+&blsp_uart2 {
+	status = "okay";
+};
+
+&pm8916_l8 {
+	regulator-min-microvolt = <2950000>;
+	regulator-max-microvolt = <2950000>;
+};
+
+&pm8916_resin {
+	linux,code = <KEY_VOLUMEDOWN>;
+	status = "okay";
+};
+
+&pm8916_rpm_regulators {
+	pm8916_l16: l16 {
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	pm8916_l17: l17 {
+		regulator-min-microvolt = <2850000>;
+		regulator-max-microvolt = <2850000>;
+	};
+};
+
+&pm8916_vib {
+	status = "okay";
+};
+
+&sdhc_1 {
+	status = "okay";
+};
+
+&sdhc_2 {
+	pinctrl-0 = <&sdc2_default &sdc2_cd_default>;
+	pinctrl-1 = <&sdc2_sleep &sdc2_cd_default>;
+	pinctrl-names = "default", "sleep";
+
+	cd-gpios = <&tlmm 38 GPIO_ACTIVE_HIGH>;
+
+	status = "okay";
+};
+
+&usb {
+	extcon = <&usb_id>, <&usb_id>;
+	status = "okay";
+};
+
+&usb_hs_phy {
+	extcon = <&usb_id>;
+};
+
+&wcnss {
+	status = "okay";
+};
+
+&wcnss_iris {
+	compatible = "qcom,wcn3620";
+};
+
+&tlmm {
+	accel_int_default: accel-int-default-state {
+		pins = "gpio115";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	gpio_hall_sensor_default: gpio-hall-sensor-default-state {
+		pins = "gpio69";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	gpio_keys_default: gpio-keys-default-state {
+		pins = "gpio107";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+
+	prox_irq_default: prox-irq-default-state {
+		pins = "gpio113";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	sdc2_cd_default: sdc2-cd-default-state {
+		pins = "gpio38";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	touchscreen_default: touchscreen-default-state {
+		pins = "gpio12", "gpio13";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	usb_id_default: usb-id-default-state {
+		pins = "gpio110";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-pull-up;
+	};
+};
-- 
2.42.0

