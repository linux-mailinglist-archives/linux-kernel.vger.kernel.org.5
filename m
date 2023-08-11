Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C240D779B9D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 01:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237323AbjHKXsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 19:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237305AbjHKXrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 19:47:53 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BBFC2127
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 16:47:49 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fe2ba3e260so22788055e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 16:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691797668; x=1692402468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W167HSXeLgix5KQaWJtxib0EFybUcA+r/u3yHNgwj3g=;
        b=g8gc2agGr9PxEzzwT3MHXV4C64QGRVvB82FtN/pAfvVPwlrycQgWarLurH0YhTIdE5
         re9t8nwT0gR3l3syO/9KiTaKIEGaG0FeId+SDbTIK4XIWGE0HFsL8gu5PGyGlwZctCBo
         +GQMbJk2D+l1bFoGvy4IyEcwfLAxmZtbGUiRN1LX3HopgscZ+M6PbxDU4DDpa9MK63w5
         8JdmotLAZ6lIGwpZmVyFSH/+/mqoWdmbDvHyLFnkJ6iZ4cCVq1cUjmWJnDJ2U7tpU4Q3
         bFhw3XyvGSROBACv8XfrOIpI2Q7J0Pv9HPSl4dGWAWTqqj7xOEIzCBmsrc6wOt1XyeEA
         E7eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691797668; x=1692402468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W167HSXeLgix5KQaWJtxib0EFybUcA+r/u3yHNgwj3g=;
        b=AtRkY+6bX9eZh1DiY552Lt9TrNUJnnG/l0gi/wXp3Jme+zdmMIj1Pu6O6yIOg/p+su
         QQ8FJStj9FNIUJ8wlDq86nA54P/0IrWmLyvhc3lDoJFKcvCBD0DuiiBz7ommMG+Kwa/w
         76qJ5QT23m2QzSJuAEGxJwEwCnSY7BaPwYtpA96EvUgDlV2wsDd6lxUcNoIzMzVE56YT
         +C2EcFuU6ILliwXqso4/lhdq58XdQRGjduwCbqOy/+M38S9SSMc1lEPpKOysiMLvKq9V
         QHaf7r2xE8ckCmAguBDuJuwNUrw2OgNgr8AGXD1wy1ON8BCjmFiwAAwRAdIT3k/rRBld
         kfOg==
X-Gm-Message-State: AOJu0YzE6VZz3XXABEVGvBIij1G+m/o95w4KuwISNhrowJXFRHwqBK5n
        qw4Ctq3X5ZqV+FUXCNA5yWJfy9xdDVfbTg59whI=
X-Google-Smtp-Source: AGHT+IHxoLyl4MJH6fXnEYrq2oJJi+Ufg8ONR6xZI+HMUUjzo3xWBwoc0YLV4jEkERuthQXoBnltVg==
X-Received: by 2002:a05:600c:2315:b0:3fe:687a:abad with SMTP id 21-20020a05600c231500b003fe687aabadmr2585514wmo.20.1691797668224;
        Fri, 11 Aug 2023 16:47:48 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id 20-20020a05600c025400b003fa98908014sm9599051wmj.8.2023.08.11.16.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 16:47:47 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bryan.odonoghue@linaro.org
Subject: [PATCH v3 6/7] arm64: dts: qcom: apq8016-sbc-d3-camera-mezzanine: Move default ov5640 to a standalone dts
Date:   Sat, 12 Aug 2023 00:47:37 +0100
Message-ID: <20230811234738.2859417-7-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230811234738.2859417-1-bryan.odonoghue@linaro.org>
References: <20230811234738.2859417-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the moment we define a single ov5640 sensor in the apq8016-sbc and
disable that sensor.

The sensor mezzanine for this is a D3 Engineering Dual ov5640 mezzanine
card. Move the definition from the apq8016-sbc where it shouldn't be to a
standalone dts.

Enables the sensor by default, as we are adding a standalone mezzanine
structure.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/Makefile             |  1 +
 .../qcom/apq8016-sbc-d3-camera-mezzanine.dts  | 81 +++++++++++++++++++
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts      | 73 -----------------
 3 files changed, 82 insertions(+), 73 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/apq8016-sbc-d3-camera-mezzanine.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index f15548dbfa56e..19016765ba4c6 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_ARCH_QCOM)	+= apq8016-sbc.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= apq8016-sbc-d3-camera-mezzanine.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= apq8039-t2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= apq8094-sony-xperia-kitakami-karin_windy.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-db820c.dtb
diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc-d3-camera-mezzanine.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc-d3-camera-mezzanine.dts
new file mode 100644
index 0000000000000..c08b4be5cc7ee
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc-d3-camera-mezzanine.dts
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2015, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023, Linaro Ltd.
+ */
+
+/dts-v1/;
+
+#include "apq8016-sbc.dts"
+
+/ {
+	camera_vdddo_1v8: camera-vdddo-1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "camera_vdddo";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+	};
+
+	camera_vdda_2v8: camera-vdda-2v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "camera_vdda";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+		regulator-always-on;
+	};
+
+	camera_vddd_1v5: camera-vddd-1v5 {
+		compatible = "regulator-fixed";
+		regulator-name = "camera_vddd";
+		regulator-min-microvolt = <1500000>;
+		regulator-max-microvolt = <1500000>;
+		regulator-always-on;
+	};
+};
+
+&camss {
+	status = "okay";
+
+	ports {
+		port@0 {
+			reg = <0>;
+			csiphy0_ep: endpoint {
+				data-lanes = <0 2>;
+				remote-endpoint = <&ov5640_ep>;
+			};
+		};
+	};
+};
+
+&cci {
+	status = "okay";
+};
+
+&cci_i2c0 {
+	camera_rear@3b {
+		compatible = "ovti,ov5640";
+		reg = <0x3b>;
+
+		powerdown-gpios = <&tlmm 34 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&tlmm 35 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&camera_rear_default>;
+
+		clocks = <&gcc GCC_CAMSS_MCLK0_CLK>;
+		clock-names = "xclk";
+		assigned-clocks = <&gcc GCC_CAMSS_MCLK0_CLK>;
+		assigned-clock-rates = <23880000>;
+
+		DOVDD-supply = <&camera_vdddo_1v8>;
+		AVDD-supply = <&camera_vdda_2v8>;
+		DVDD-supply = <&camera_vddd_1v5>;
+
+		port {
+			ov5640_ep: endpoint {
+				data-lanes = <1 2>;
+				remote-endpoint = <&csiphy0_ep>;
+			};
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
index ddb19709a9eee..c3cd08aa5c85b 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
@@ -34,30 +34,6 @@ chosen {
 		stdout-path = "serial0";
 	};
 
-	camera_vdddo_1v8: camera-vdddo-1v8 {
-		compatible = "regulator-fixed";
-		regulator-name = "camera_vdddo";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		regulator-always-on;
-	};
-
-	camera_vdda_2v8: camera-vdda-2v8 {
-		compatible = "regulator-fixed";
-		regulator-name = "camera_vdda";
-		regulator-min-microvolt = <2800000>;
-		regulator-max-microvolt = <2800000>;
-		regulator-always-on;
-	};
-
-	camera_vddd_1v5: camera-vddd-1v5 {
-		compatible = "regulator-fixed";
-		regulator-name = "camera_vddd";
-		regulator-min-microvolt = <1500000>;
-		regulator-max-microvolt = <1500000>;
-		regulator-always-on;
-	};
-
 	reserved-memory {
 		ramoops@bff00000 {
 			compatible = "ramoops";
@@ -250,55 +226,6 @@ &blsp_uart2 {
 	label = "LS-UART1";
 };
 
-&camss {
-	status = "okay";
-	ports {
-		port@0 {
-			reg = <0>;
-			csiphy0_ep: endpoint {
-				data-lanes = <0 2>;
-				remote-endpoint = <&ov5640_ep>;
-				status = "okay";
-			};
-		};
-	};
-};
-
-&cci {
-	status = "okay";
-};
-
-&cci_i2c0 {
-	camera_rear@3b {
-		compatible = "ovti,ov5640";
-		reg = <0x3b>;
-
-		powerdown-gpios = <&tlmm 34 GPIO_ACTIVE_HIGH>;
-		reset-gpios = <&tlmm 35 GPIO_ACTIVE_LOW>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&camera_rear_default>;
-
-		clocks = <&gcc GCC_CAMSS_MCLK0_CLK>;
-		clock-names = "xclk";
-		assigned-clocks = <&gcc GCC_CAMSS_MCLK0_CLK>;
-		assigned-clock-rates = <23880000>;
-
-		DOVDD-supply = <&camera_vdddo_1v8>;
-		AVDD-supply = <&camera_vdda_2v8>;
-		DVDD-supply = <&camera_vddd_1v5>;
-
-		/* No camera mezzanine by default */
-		status = "disabled";
-
-		port {
-			ov5640_ep: endpoint {
-				data-lanes = <1 2>;
-				remote-endpoint = <&csiphy0_ep>;
-			};
-		};
-	};
-};
-
 &lpass {
 	status = "okay";
 };
-- 
2.41.0

