Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E267812019
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 21:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442370AbjLMUiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 15:38:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjLMUiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 15:38:02 -0500
Received: from smtprelay04.ispgateway.de (smtprelay04.ispgateway.de [80.67.31.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB679C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 12:38:07 -0800 (PST)
Received: from [92.206.191.209] (helo=note-book.lan)
        by smtprelay04.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96.1)
        (envelope-from <git@apitzsch.eu>)
        id 1rDVw3-0004Kq-1w;
        Wed, 13 Dec 2023 21:34:27 +0100
From:   =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
Date:   Wed, 13 Dec 2023 21:33:58 +0100
Subject: [PATCH 2/2] ARM: dts: qcom: msm8926-motorola-peregrine: Add
 initial device tree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231213-peregrine-v1-2-5229e21bca3f@apitzsch.eu>
References: <20231213-peregrine-v1-0-5229e21bca3f@apitzsch.eu>
In-Reply-To: <20231213-peregrine-v1-0-5229e21bca3f@apitzsch.eu>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
X-Mailer: b4 0.12.4
X-Df-Sender: YW5kcmVAYXBpdHpzY2guZXU=
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SBL_CSS,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This dts adds support for Motorola Moto G 4G released in 2013.

Add a device tree with initial support for:

- GPIO keys
- Hall sensor
- SDHCI
- Vibrator

Signed-off-by: André Apitzsch <git@apitzsch.eu>
---
 arch/arm/boot/dts/qcom/Makefile                    |   1 +
 .../dts/qcom/qcom-msm8926-motorola-peregrine.dts   | 297 +++++++++++++++++++++
 2 files changed, 298 insertions(+)

diff --git a/arch/arm/boot/dts/qcom/Makefile b/arch/arm/boot/dts/qcom/Makefile
index 0cb272f4fa45..9cc1e14e6cd0 100644
--- a/arch/arm/boot/dts/qcom/Makefile
+++ b/arch/arm/boot/dts/qcom/Makefile
@@ -35,6 +35,7 @@ dtb-$(CONFIG_ARCH_QCOM) += \
 	qcom-msm8926-htc-memul.dtb \
 	qcom-msm8926-microsoft-superman-lte.dtb \
 	qcom-msm8926-microsoft-tesla.dtb \
+	qcom-msm8926-motorola-peregrine.dtb \
 	qcom-msm8960-cdp.dtb \
 	qcom-msm8960-samsung-expressatt.dtb \
 	qcom-msm8974-lge-nexus5-hammerhead.dtb \
diff --git a/arch/arm/boot/dts/qcom/qcom-msm8926-motorola-peregrine.dts b/arch/arm/boot/dts/qcom/qcom-msm8926-motorola-peregrine.dts
new file mode 100644
index 000000000000..3c5256120502
--- /dev/null
+++ b/arch/arm/boot/dts/qcom/qcom-msm8926-motorola-peregrine.dts
@@ -0,0 +1,297 @@
+// SPDX-License-Identifier: BSD-3-Clause
+
+/dts-v1/;
+
+#include "qcom-msm8226.dtsi"
+#include "pm8226.dtsi"
+
+/delete-node/ &smem_region;
+
+/ {
+	model = "Motorola Moto G 4G";
+	compatible = "motorola,peregrine", "qcom,msm8926", "qcom,msm8226";
+	chassis-type = "handset";
+
+	aliases {
+		mmc0 = &sdhc_1; /* SDC1 eMMC slot */
+		mmc1 = &sdhc_2; /* SDC2 SD card slot */
+	};
+
+	chosen {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		framebuffer0: framebuffer@3200000 {
+			compatible = "simple-framebuffer";
+			reg = <0x03200000 0x800000>;
+			width = <720>;
+			height = <1280>;
+			stride = <(720 * 3)>;
+			format = "r8g8b8";
+		};
+	};
+
+	gpio-hall-sensor {
+		compatible = "gpio-keys";
+
+		label = "GPIO Hall Effect Sensor";
+
+		event-hall-sensor {
+			label = "Hall Effect Sensor";
+			gpios = <&tlmm 51 GPIO_ACTIVE_LOW>;
+			linux,input-type = <EV_SW>;
+			linux,code = <SW_LID>;
+			linux,can-disable;
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		key-volume-up {
+			label = "Volume Up";
+			gpios = <&tlmm 106 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEUP>;
+			debounce-interval = <15>;
+		};
+	};
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		framebuffer@3200000 {
+			reg = <0x03200000 0x800000>;
+			no-map;
+		};
+
+		smem_region: smem@fa00000 {
+			reg = <0x0fa00000 0x100000>;
+			no-map;
+		};
+	};
+};
+
+&blsp1_i2c3 {
+	status = "okay";
+
+	sensor@48 {
+		compatible = "ti,tmp108";
+		reg = <0x48>;
+	};
+};
+
+&blsp1_uart3 {
+	status = "okay";
+};
+
+&pm8226_resin {
+	linux,code = <KEY_VOLUMEDOWN>;
+	status = "okay";
+};
+
+&pm8226_vib {
+	status = "okay";
+};
+
+&rpm_requests {
+	regulators {
+		compatible = "qcom,rpm-pm8226-regulators";
+
+		pm8226_s3: s3 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1300000>;
+		};
+
+		pm8226_s4: s4 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2200000>;
+		};
+
+		pm8226_s5: s5 {
+			regulator-min-microvolt = <1150000>;
+			regulator-max-microvolt = <1150000>;
+		};
+
+		pm8226_l1: l1 {
+			regulator-min-microvolt = <1225000>;
+			regulator-max-microvolt = <1225000>;
+		};
+
+		pm8226_l2: l2 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
+
+		pm8226_l3: l3 {
+			regulator-min-microvolt = <750000>;
+			regulator-max-microvolt = <1337500>;
+		};
+
+		pm8226_l4: l4 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
+
+		pm8226_l5: l5 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
+
+		pm8226_l6: l6 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-allow-set-load;
+		};
+
+		pm8226_l7: l7 {
+			regulator-min-microvolt = <1850000>;
+			regulator-max-microvolt = <1850000>;
+		};
+
+		pm8226_l8: l8 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8226_l9: l9 {
+			regulator-min-microvolt = <2050000>;
+			regulator-max-microvolt = <2050000>;
+		};
+
+		pm8226_l10: l10 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8226_l12: l12 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8226_l14: l14 {
+			regulator-min-microvolt = <2750000>;
+			regulator-max-microvolt = <2750000>;
+		};
+
+		pm8226_l15: l15 {
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2800000>;
+		};
+
+		pm8226_l16: l16 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3350000>;
+		};
+
+		pm8226_l17: l17 {
+			regulator-min-microvolt = <2950000>;
+			regulator-max-microvolt = <2950000>;
+		};
+
+		pm8226_l18: l18 {
+			regulator-min-microvolt = <2950000>;
+			regulator-max-microvolt = <2950000>;
+		};
+
+		pm8226_l19: l19 {
+			regulator-min-microvolt = <2850000>;
+			regulator-max-microvolt = <2850000>;
+		};
+
+		pm8226_l20: l20 {
+			regulator-min-microvolt = <3075000>;
+			regulator-max-microvolt = <3075000>;
+		};
+
+		pm8226_l21: l21 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2950000>;
+			regulator-allow-set-load;
+		};
+
+		pm8226_l22: l22 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2950000>;
+		};
+
+		pm8226_l23: l23 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2950000>;
+		};
+
+		pm8226_l24: l24 {
+			regulator-min-microvolt = <1300000>;
+			regulator-max-microvolt = <1350000>;
+		};
+
+		pm8226_l25: l25 {
+			regulator-min-microvolt = <1775000>;
+			regulator-max-microvolt = <2125000>;
+		};
+
+		pm8226_l26: l26 {
+			regulator-min-microvolt = <1225000>;
+			regulator-max-microvolt = <1225000>;
+		};
+
+		pm8226_l27: l27 {
+			regulator-min-microvolt = <2050000>;
+			regulator-max-microvolt = <2050000>;
+		};
+
+		pm8226_l28: l28 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3400000>;
+			regulator-boot-on;
+		};
+
+		pm8226_lvs1: lvs1 {
+			/* Pull-up for I2C lines */
+			regulator-always-on;
+		};
+	};
+};
+
+&sdhc_1 {
+	vmmc-supply = <&pm8226_l17>;
+	vqmmc-supply = <&pm8226_l6>;
+
+	bus-width = <8>;
+	non-removable;
+
+	status = "okay";
+};
+
+&sdhc_2 {
+	vmmc-supply = <&pm8226_l18>;
+	vqmmc-supply = <&pm8226_l21>;
+
+	bus-width = <4>;
+	cd-gpios = <&tlmm 115 GPIO_ACTIVE_HIGH>;
+
+	status = "okay";
+};
+
+&smbb {
+	qcom,fast-charge-safe-current = <2000000>;
+	qcom,fast-charge-current-limit = <1900000>;
+	qcom,fast-charge-safe-voltage = <4400000>;
+	qcom,minimum-input-voltage = <4300000>;
+
+	status = "okay";
+};
+
+&usb {
+	extcon = <&smbb>;
+	dr_mode = "peripheral";
+	status = "okay";
+};
+
+&usb_hs_phy {
+	extcon = <&smbb>;
+	v1p8-supply = <&pm8226_l10>;
+	v3p3-supply = <&pm8226_l20>;
+};

-- 
2.43.0

