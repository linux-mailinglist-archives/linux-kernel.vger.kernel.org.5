Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95594775E6D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 14:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232660AbjHIMEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 08:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbjHIMEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 08:04:48 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB512101
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 05:04:44 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fe4b95c371so4958145e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 05:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691582683; x=1692187483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0aQNTlFhiryJSyL6GzmvZILIrCiHcbptR0gcja+ACew=;
        b=gkV088vSe/ZfsxGAQEGU2L1/jyc7EOIzpGEhw4Hnuyv1x5sWi4zpr3hnytt5W+Ce9m
         GHwz/IRSEce4QN58FD+h0WbdWzVN+/sgjoOa65gAlQX/JNHeCHUCZuI9P72u0qP9a5jk
         65m+2E3P0FZegHPSB5OaoZqRZ+lx9ZU//iwNdFY8Tkj0Hpu7V/mPnn/A/jH3dvTWrzIp
         1sDowkUw3cD80lXoVQ+fSszpAnsZjnDI9sG0zD/Klu0j/Y+jQi2IaKs4q4R0fQ+wwSik
         TW3A5nbfnPdB/bMoLvd9DN9k3F1TztE+fsrY7cxB/TK1oYZyBXC7y9lrwsaJjNf25vJs
         kb4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691582683; x=1692187483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0aQNTlFhiryJSyL6GzmvZILIrCiHcbptR0gcja+ACew=;
        b=JHqx9Yw5Wd0VhKFzds58GRoDE/WEWIEIlHrJG24fQSYWLCdNjP1lzL647+J4xSckXA
         6436k6kzolCi0OMxYGoqCRmvds+LEmhSrMOt2tEFP3f3ROk7vv0MmLXq9Feh/Ks/CErc
         r/MXiuhRe1MTdNO38nTMysLvzOZzSPJbrXCat+rm2WpO9bjqFQBRldMkbQfnHg9h1AeN
         +J7+eo8wgoa3XN35Z7mvZPg5oew5cfcl7pMIE77HghZyMkPvy9R5kt/03hgff4ovq+W9
         obkc3N2Ro/laVvXV0Y2zf8YT6F+0HhuOvvmWWvSeBP3V60un7TDoKFpmpJuzYQzzhNJS
         JmSw==
X-Gm-Message-State: AOJu0YwnYiNOxxsFd0CDxWS1HnvK7WTRn4vXy1eFSkBe5vNjUCSjvGSc
        KcDhik91RSCA+iufECKCGtuZ5Q==
X-Google-Smtp-Source: AGHT+IGmPq7NRnDMwHTOmOPKruMH3lPMvwH53+EaW92fyj14Qfjia5xvn5J2KeZTpdiebSmq3VzMPw==
X-Received: by 2002:a05:600c:152:b0:3fe:23ec:2494 with SMTP id w18-20020a05600c015200b003fe23ec2494mr2156847wmm.7.1691582682896;
        Wed, 09 Aug 2023 05:04:42 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id b13-20020a05600c11cd00b003fe1a96845bsm1808573wmi.2.2023.08.09.05.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 05:04:42 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, loic.poulain@linaro.org, rfoss@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bryan.odonoghue@linaro.org
Subject: [PATCH 5/7] arm64: dts: qcom: apq8016-sbc-d3-camera-mezzanine: Move default ov5640 to a standalone dts
Date:   Wed,  9 Aug 2023 13:04:30 +0100
Message-Id: <20230809120432.1036405-6-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230809120432.1036405-1-bryan.odonoghue@linaro.org>
References: <20230809120432.1036405-1-bryan.odonoghue@linaro.org>
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

At the moment we define a single ov5640 sensor in the apq8016-sbc and
disable that sensor.

The sensor mezzanine for this is a D3 Engineering Dual ov5640 mezzanine
card. Move the definition from the apq8016-sbc where it shouldn't be to a
standalone dts.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 arch/arm64/boot/dts/qcom/Makefile             |  1 +
 .../qcom/apq8016-sbc-d3-camera-mezzanine.dts  | 57 +++++++++++++++++++
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts      | 49 ----------------
 3 files changed, 58 insertions(+), 49 deletions(-)
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
index 0000000000000..6155fa92c717f
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc-d3-camera-mezzanine.dts
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2023, Linaro Ltd.
+ */
+
+/dts-v1/;
+
+#include "apq8016-sbc.dts"
+
+&camss {
+	status = "okay";
+	ports {
+		port@0 {
+			reg = <0>;
+			csiphy0_ep: endpoint {
+				data-lanes = <0 2>;
+				remote-endpoint = <&ov5640_ep>;
+				status = "okay";
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
+		/* No camera mezzanine by default */
+		status = "disabled";
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
index ddb19709a9eee..84641925f3329 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
@@ -250,55 +250,6 @@ &blsp_uart2 {
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
2.39.2

