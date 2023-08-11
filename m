Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8AD7799D2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 23:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235401AbjHKVoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 17:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236971AbjHKVoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 17:44:20 -0400
Received: from out-64.mta0.migadu.com (out-64.mta0.migadu.com [IPv6:2001:41d0:1004:224b::40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3523B2D79
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 14:44:17 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ansari.sh; s=key1;
        t=1691789881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9ri9A8Q1CUKvXJeb8nJA1u5zoIHBVlDIsMSRftNYEOA=;
        b=S1uE7nQqH3/VZfwWyk97EoG1z2uwQIzKeuSKqDkp6B6/FEZelpuvzkjgX4sB9jvyLwfhL6
        jbChXQ/Xkl6+u0yXKgfxU5OhH2foyTPfUbjdPBY4azQ6DxZfj7cNyWuj4dGDZss0QS4pbv
        3+g/Xo+S+acXvSjMhRPQHIdEubS9Dxg=
From:   Rayyan Ansari <rayyan@ansari.sh>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Rayyan Ansari <rayyan@ansari.sh>,
        Dominik Kobinski <dominikkobinski314@gmail.com>,
        Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>,
        Jack Matthews <jm5112356@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 2/7] ARM: dts: qcom: add common device tree for MSM8x26-based Lumia phones
Date:   Fri, 11 Aug 2023 22:35:19 +0100
Message-ID: <20230811213728.23726-3-rayyan@ansari.sh>
In-Reply-To: <20230811213728.23726-1-rayyan@ansari.sh>
References: <20230811213728.23726-1-rayyan@ansari.sh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a common device tree for Lumias based on the Qualcomm MSM8x26
family of chipsets.

Currently supports:
- Framebuffer
- Touchscreen
- Keys
- Regulators
- MMC
- USB
- UART

Co-authored-by: Dominik Kobinski <dominikkobinski314@gmail.com>
Co-authored-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
Co-authored-by: Jack Matthews <jm5112356@gmail.com>
Signed-off-by: Dominik Kobinski <dominikkobinski314@gmail.com>
Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
Signed-off-by: Jack Matthews <jm5112356@gmail.com>
Signed-off-by: Rayyan Ansari <rayyan@ansari.sh>
---
 .../qcom/qcom-msm8226-microsoft-common.dtsi   | 332 ++++++++++++++++++
 1 file changed, 332 insertions(+)
 create mode 100644 arch/arm/boot/dts/qcom/qcom-msm8226-microsoft-common.dtsi

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8226-microsoft-common.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8226-microsoft-common.dtsi
new file mode 100644
index 000000000000..b49ccf867964
--- /dev/null
+++ b/arch/arm/boot/dts/qcom/qcom-msm8226-microsoft-common.dtsi
@@ -0,0 +1,332 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Common Board Device Tree for Microsoft MSM8x26-based Lumias
+ *
+ * Copyright (c) 2023, Jack Matthews <jm5112356@gmail.com>
+ * Copyright (c) 2023, Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
+ * Copyright (c) 2023, Dominik Kobinski <dominikkobinski314@gmail.com>
+ * Copyright (c) 2023, Rayyan Ansari <rayyan@ansari.sh>
+ */
+
+#include "qcom-msm8226.dtsi"
+#include "qcom-pm8226.dtsi"
+#include <dt-bindings/input/input.h>
+
+/*
+ * Delete all generic (msm8226.dtsi) reserved
+ * memory mappings which are different on these devices.
+ */
+/delete-node/ &smem_region;
+
+/ {
+	aliases {
+		mmc0 = &sdhc_1; /* eMMC */
+		mmc1 = &sdhc_2; /* microSD */
+		display0 = &framebuffer0;
+	};
+
+	chosen {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		stdout-path = "display0";
+
+		framebuffer0: framebuffer@3200000 {
+			compatible = "simple-framebuffer";
+			reg = <0x3200000 0x800000>;
+			format = "a8r8g8b8";
+			width = <720>;
+			height = <1280>;
+			stride = <(720 * 4)>;
+
+			clocks = <&mmcc MDSS_AHB_CLK>,
+				 <&mmcc MDSS_AXI_CLK>,
+				 <&mmcc MDSS_BYTE0_CLK>,
+				 <&mmcc MDSS_MDP_CLK>,
+				 <&mmcc MDSS_PCLK0_CLK>,
+				 <&mmcc MDSS_VSYNC_CLK>;
+			power-domains = <&mmcc MDSS_GDSC>;
+		};
+	};
+
+	gpio_keys: gpio-keys {
+		compatible = "gpio-keys";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&gpio_keys_active>;
+
+		label = "GPIO Buttons";
+
+		volume-up {
+			label = "Volume Up";
+			gpios = <&tlmm 106 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEUP>;
+		};
+	};
+
+	/*
+	 * This device being a WP platform has a different
+	 * memory layout than other Android based devices.
+	 * This smem memory region is directly copied from
+	 * the original UEFI firmware.
+	 */
+	reserved-memory {
+		ranges;
+
+		smem_region: smem@fa00000 {
+			reg = <0xfa00000 0x100000>;
+			no-map;
+		};
+
+		display_reserved: framebuffer@3200000 {
+			reg = <0x3200000 0x800000>;
+			no-map;
+		};
+	};
+};
+
+&blsp1_i2c5 {
+	status = "okay";
+
+	touchscreen@4b {
+		compatible = "syna,rmi4-i2c";
+		reg = <0x4b>;
+
+		interrupts-extended = <&tlmm 17 IRQ_TYPE_EDGE_FALLING>;
+		vdd-supply = <&pm8226_l15>;
+		vio-supply = <&pm8226_l6>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&touchscreen_on>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		rmi4-f01@1 {
+			reg = <0x01>;
+			syna,nosleep-mode = <1>;
+		};
+
+		rmi4-f11@11 {
+			reg = <0x11>;
+			syna,sensor-type = <1>;
+		};
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
+	pm8226-regulators {
+		compatible = "qcom,rpm-pm8226-regulators";
+
+		/* These values were taken from the original firmware DSDT */
+		pm8226_s1: s1 {
+			regulator-min-microvolt = <1050000>;
+			regulator-max-microvolt = <1050000>;
+		};
+
+		pm8226_s3: s3 {
+			regulator-min-microvolt = <1300000>;
+			regulator-max-microvolt = <1300000>;
+		};
+
+		pm8226_s4: s4 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2100000>;
+		};
+
+		pm8226_s5: s5 {
+			regulator-min-microvolt = <1150000>;
+			regulator-max-microvolt = <1150000>;
+		};
+
+		pm8226_l3: l3 {
+			regulator-min-microvolt = <750000>;
+			regulator-max-microvolt = <1150000>;
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
+			regulator-always-on;
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
+			regulator-min-microvolt = <2850000>;
+			regulator-max-microvolt = <2850000>;
+		};
+
+		pm8226_l16: l16 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3000000>;
+		};
+
+		pm8226_l17: l17 {
+			regulator-min-microvolt = <2950000>;
+			regulator-max-microvolt = <2950000>;
+			regulator-system-load = <200000>;
+			regulator-allow-set-load;
+		};
+
+		pm8226_l18: l18 {
+			regulator-min-microvolt = <2950000>;
+			regulator-max-microvolt = <2950000>;
+			regulator-system-load = <200000>;
+			regulator-allow-set-load;
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
+			regulator-min-microvolt = <1850000>;
+			regulator-max-microvolt = <2950000>;
+		};
+
+		pm8226_l22: l22 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8226_l23: l23 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8226_l24: l24 {
+			regulator-min-microvolt = <1300000>;
+			regulator-max-microvolt = <1300000>;
+		};
+
+		pm8226_l25: l25 {
+			regulator-min-microvolt = <1775000>;
+			regulator-max-microvolt = <2075000>;
+		};
+
+		pm8226_l27: l27 {
+			regulator-min-microvolt = <2050000>;
+			regulator-max-microvolt = <2050000>;
+		};
+
+		pm8226_l28: l28 {
+			regulator-min-microvolt = <2000000>;
+			regulator-max-microvolt = <3000000>;
+		};
+	};
+};
+
+&sdhc_1 {
+	vmmc-supply = <&pm8226_l17>;
+	vqmmc-supply = <&pm8226_l6>;
+
+	status = "okay";
+};
+
+&sdhc_2 {
+	vmmc-supply = <&pm8226_l18>;
+	vqmmc-supply = <&pm8226_l21>;
+
+	status = "okay";
+};
+
+&usb {
+	extcon = <&smbb>;
+	dr_mode = "peripheral";
+
+	status = "okay";
+};
+
+&usb_hs_phy {
+	extcon = <&smbb>;
+	v1p8-supply = <&pm8226_l10>;
+	v3p3-supply = <&pm8226_l20>;
+};
+
+&tlmm {
+	gpio_keys_active: gpio-keys-active {
+		pins = "gpio106", "gpio107", "gpio108";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+
+	touchscreen_on: touchscreen-on {
+		irq {
+			pins = "gpio17";
+			function = "gpio";
+
+			drive-strength = <8>;
+			bias-pull-up;
+			input-enable;
+		};
+
+		reset {
+			pins = "gpio16";
+			function = "gpio";
+
+			drive-strength = <8>;
+			bias-disable;
+			output-high;
+		};
+	};
+};
-- 
2.41.0

