Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E427D1D7B
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 16:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbjJUOba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 10:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbjJUOb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 10:31:27 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833C0D6B
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 07:31:21 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3226cc3e324so1395995f8f.3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 07:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aceart.de; s=google; t=1697898680; x=1698503480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vEdsvcnRCtzaJRF8/fcLniBSlcoD/EU26r1797EAi0g=;
        b=UuOBPDWXRi5RdcbEmkl7pKjDLq/7Xpe5WV3to8O5lqNk7Yqekq0+kgQo4/pnSyrfV0
         R8vSjZj88ilsuVYmDmlDmZNnu5wpbjSdEGii8sjVc8D2JlBgWH/F67bbl0gYSYDr2tou
         iIpHzvWgvSgvE+MtOoEttd8+Hljjarw5xDou8sgMHP/cnkWMHezXoEdfLeiMRs3vGDUJ
         GyEp/yRheTYyVK8+KwNMpTYbIxFBhtM5pTH/NVkvAnAwFyVmOWwT4d23ru3nXKL6Rfw1
         Itj0h2V2u+v1wKb/In8D+pZwPASPDdJzZQzUcDzic1kMN8417T1BXqnSjCV3w1r6yi8m
         Mx1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697898680; x=1698503480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vEdsvcnRCtzaJRF8/fcLniBSlcoD/EU26r1797EAi0g=;
        b=Tnz7uhLztBj3KszBlx1Gad+qMIFdiOHb7ePwhwoDXnkRvFm86l0TgtjpPpNCWP+ihB
         +6LuuubTt9sIU3DNMVQXeiZFLNqGGYKQBjzI/WcDPj0YtGPu78JzlrSeOl6QtuAg02DY
         G1h2aIGEA6anVQZW2VOJAHIc1A1BHiZYeDcpAZRzwPIksL+58byk1BdEPioST+OUNVb9
         dnRP40992WtwxYFj1FVoYFzgmsYrH4dYPLzq/0lm7959rKDdf/F3PnKmp7X5sGlv9caK
         oBEMZ4c8oCSueouInPrrSH5PeVrWsmq2p7MTjg27tdOusLTrUwEfCb4l++okpSjDuV++
         QiWA==
X-Gm-Message-State: AOJu0YyCIkOVg7fGrhsiH8LTFXN0pZ/AFw5WFJ1ZAWQm7sO97s5slAl/
        p61+cLGspihlsXE52FKNlTyivAEOlnW+J59/XI/hRyn3
X-Google-Smtp-Source: AGHT+IEXvFAzkZ7YvjWvEMB1Qn0ukiDRTVTG7SBdY0dCn1jAaGuuAayvcAUZkuUPg2AgXobK/sLQRw==
X-Received: by 2002:a5d:670c:0:b0:32d:82b4:1957 with SMTP id o12-20020a5d670c000000b0032d82b41957mr3697249wru.40.1697898679753;
        Sat, 21 Oct 2023 07:31:19 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8070:d89:b820:87f5:4b33:b582:39f3])
        by smtp.gmail.com with ESMTPSA id u3-20020a5d5143000000b003296b488961sm3793917wrt.31.2023.10.21.07.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 07:31:19 -0700 (PDT)
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
Date:   Sat, 21 Oct 2023 16:30:25 +0200
Message-ID: <20231021143025.77088-2-lukas.walter@aceart.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231021143025.77088-1-lukas.walter@aceart.de>
References: <20231021143025.77088-1-lukas.walter@aceart.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
- Sensors (accelerometer and proximity)
- Vibrator
- Touchscreen

Signed-off-by: Raymond Hackley <raymondhackley@protonmail.com>
Signed-off-by: Lukas Walter <lukas.walter@aceart.de>
---
Changes in v2:
- Switch Signed-off-by order
- Specify reserved-memory region usage
---
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../boot/dts/qcom/msm8939-huawei-kiwi.dts     | 242 ++++++++++++++++++
 2 files changed, 243 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8939-huawei-kiwi.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index d6cb840b7050..1b3057c1a68d 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -45,6 +45,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-thwc-uf896.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-thwc-ufi001c.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-wingtech-wt88047.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-yiming-uz801v3.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= msm8939-huawei-kiwi.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8939-longcheer-l9100.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8939-samsung-a7.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8939-sony-xperia-kanuti-tulip.dtb
diff --git a/arch/arm64/boot/dts/qcom/msm8939-huawei-kiwi.dts b/arch/arm64/boot/dts/qcom/msm8939-huawei-kiwi.dts
new file mode 100644
index 000000000000..3cec51891aed
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8939-huawei-kiwi.dts
@@ -0,0 +1,242 @@
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
+		qseecom_mem: qseecom@84a00000 {
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
+&wcnss_mem {
+	status = "okay";
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

