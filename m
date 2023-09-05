Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2208E7932A8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 01:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243462AbjIEXc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 19:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241325AbjIEXcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 19:32:23 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D58E6A;
        Tue,  5 Sep 2023 16:31:54 -0700 (PDT)
Received: from pyrite.hamster-moth.ts.net (h175-177-042-159.catv02.itscom.jp [175.177.42.159])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id DA7631ACC;
        Wed,  6 Sep 2023 01:30:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1693956626;
        bh=BPO71p8AqRtLtS8dabPfc4dQV/aaP8xfQttAS5gWd7c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IOAK2S+NZRbIIi66BiWObcgJFTvKoLqvxI7qdpTiSWVIWh13Q2iiQcuBTmrNuuObI
         GOi4HfwTJph8yqtQ5c9Hr2Afn7IWuZBv9D8U6V//UdCw0L1cz0WcKuFnHXFohbeeXf
         slkKIil4/wN2wO4ydU6Ri8opR0lD1L+7fnwB02OU=
From:   Paul Elder <paul.elder@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     Paul Elder <paul.elder@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 3/3] arm64: dts: mediatek: mt8365-pumpkin: Add overlays for thp7312 cameras
Date:   Wed,  6 Sep 2023 08:31:18 +0900
Message-Id: <20230905233118.183140-4-paul.elder@ideasonboard.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230905233118.183140-1-paul.elder@ideasonboard.com>
References: <20230905233118.183140-1-paul.elder@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add overlays for the Pumpkin i350 to support THP7312 cameras.

Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
---
 arch/arm64/boot/dts/mediatek/Makefile         |  4 +
 .../mt8365-pumpkin-common-thp7312.dtsi        | 23 ++++++
 .../mt8365-pumpkin-csi0-thp7312-imx258.dtso   | 73 +++++++++++++++++++
 .../mt8365-pumpkin-csi1-thp7312-imx258.dtso   | 73 +++++++++++++++++++
 4 files changed, 173 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8365-pumpkin-common-thp7312.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8365-pumpkin-csi0-thp7312-imx258.dtso
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8365-pumpkin-csi1-thp7312-imx258.dtso

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index 20570bc40de8..ceaf24105001 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -56,4 +56,8 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8365-evk.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8365-pumpkin.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8516-pumpkin.dtb
 
+mtk-mt8365-pumpkin-dtbs := mt8365-pumpkin.dtb mt8365-pumpkin-csi0-thp7312-imx258.dtbo
+mtk-mt8365-pumpkin-dtbs := mt8365-pumpkin.dtb mt8365-pumpkin-csi1-thp7312-imx258.dtbo
 mtk-mt8365-pumpkin-dtbs := mt8365-pumpkin.dtb mt8365-pumpkin-ethernet-usb.dtbo
+
+dtb-$(CONFIG_ARCH_MEDIATEK) += mtk-mt8365-pumpkin.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt8365-pumpkin-common-thp7312.dtsi b/arch/arm64/boot/dts/mediatek/mt8365-pumpkin-common-thp7312.dtsi
new file mode 100644
index 000000000000..478697552617
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8365-pumpkin-common-thp7312.dtsi
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 Ideas on Board
+ * Author: Paul Elder <paul.elder@ideasonboard.com>
+ */
+
+/dts-v1/;
+/plugin/;
+
+&{/} {
+	vsys_v4p2: regulator@0 {
+		compatible = "regulator-fixed";
+		regulator-name = "vsys-v4p2";
+		regulator-min-microvolt = <4200000>;
+		regulator-max-microvolt = <4200000>;
+	};
+
+	camera61_clk: cam_clk24m {
+		compatible = "fixed-clock";
+		clock-frequency = <24000000>;
+		#clock-cells = <0>;
+	};
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8365-pumpkin-csi0-thp7312-imx258.dtso b/arch/arm64/boot/dts/mediatek/mt8365-pumpkin-csi0-thp7312-imx258.dtso
new file mode 100644
index 000000000000..740d14a19d75
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8365-pumpkin-csi0-thp7312-imx258.dtso
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 Ideas on Board
+ * Author: Paul Elder <paul.elder@ideasonboard.com>
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/mt8365-pinfunc.h>
+#include "mt8365-pumpkin-common-thp7312.dtsi"
+
+&i2c3 {
+	camera@61 {
+		compatible = "thine,thp7312";
+		reg = <0x61>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&cam0_pins_default>;
+		reset-gpios = <&pio 118 GPIO_ACTIVE_LOW>;
+		clocks = <&camera61_clk>;
+
+		vddcore-supply = <&vsys_v4p2>;
+		vhtermrx-supply = <&vsys_v4p2>;
+		vddtx-supply = <&vsys_v4p2>;
+		vddhost-supply = <&vsys_v4p2>;
+		vddcmos-supply = <&vsys_v4p2>;
+		vddgpio_0-supply = <&vsys_v4p2>;
+		vddgpio_1-supply = <&vsys_v4p2>;
+		DOVDD-supply = <&vsys_v4p2>;
+		AVDD-supply = <&vsys_v4p2>;
+		DVDD-supply = <&vsys_v4p2>;
+
+		orientation = <0>;
+		rotation = <0>;
+
+		thine,rx,data-lanes = <4 1 3 2>;
+
+		port {
+			isp1_out: endpoint {
+				remote-endpoint = <&seninf_in1>;
+				data-lanes = <4 2 1 3>;
+			};
+		};
+	};
+};
+
+&pio {
+	cam0_pins_default: cam0_pins_default {
+		pins_rst {
+			pinmux = <MT8365_PIN_118_DMIC0_DAT0__FUNC_GPIO118>;
+		};
+	};
+};
+
+&seninf {
+	status = "okay";
+
+	ports {
+		port@0 {
+			seninf_in1: endpoint {
+				remote-endpoint = <&isp1_out>;
+				clock-lanes = <2>;
+				data-lanes = <1 3 0 4>;
+			};
+		};
+	};
+};
+
+&camsv1 {
+	status = "okay";
+};
+
+&mipi_csi0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8365-pumpkin-csi1-thp7312-imx258.dtso b/arch/arm64/boot/dts/mediatek/mt8365-pumpkin-csi1-thp7312-imx258.dtso
new file mode 100644
index 000000000000..2ebe4e9b56fa
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8365-pumpkin-csi1-thp7312-imx258.dtso
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 Ideas on Board
+ * Author: Paul Elder <paul.elder@ideasonboard.com>
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/mt8365-pinfunc.h>
+#include "mt8365-pumpkin-common-thp7312.dtsi"
+
+&i2c2 {
+	camera@61 {
+		compatible = "thine,thp7312";
+		reg = <0x61>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&cam1_pins_default>;
+		reset-gpios = <&pio 119 GPIO_ACTIVE_LOW>;
+		clocks = <&camera61_clk>;
+
+		vddcore-supply = <&vsys_v4p2>;
+		vhtermrx-supply = <&vsys_v4p2>;
+		vddtx-supply = <&vsys_v4p2>;
+		vddhost-supply = <&vsys_v4p2>;
+		vddcmos-supply = <&vsys_v4p2>;
+		vddgpio_0-supply = <&vsys_v4p2>;
+		vddgpio_1-supply = <&vsys_v4p2>;
+		DOVDD-supply = <&vsys_v4p2>;
+		AVDD-supply = <&vsys_v4p2>;
+		DVDD-supply = <&vsys_v4p2>;
+
+		orientation = <0>;
+		rotation = <0>;
+
+		thine,rx,data-lanes = <4 1 3 2>;
+
+		port {
+			isp2_out: endpoint {
+				remote-endpoint = <&seninf_in2>;
+				data-lanes = <4 2 1 3>;
+			};
+		};
+	};
+};
+
+&pio {
+	cam1_pins_default: cam1_pins_default {
+		pins_rst {
+			pinmux = <MT8365_PIN_119_DMIC0_DAT1__FUNC_GPIO119>;
+		};
+	};
+};
+
+&seninf {
+	status = "okay";
+
+	ports {
+		port@1 {
+			seninf_in2: endpoint {
+				remote-endpoint = <&isp2_out>;
+				clock-lanes = <2>;
+				data-lanes = <1 3 0 4>;
+			};
+		};
+	};
+};
+
+&camsv2 {
+	status = "okay";
+};
+
+&mipi_csi1 {
+	status = "okay";
+};
-- 
2.39.2

