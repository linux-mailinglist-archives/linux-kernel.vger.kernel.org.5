Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAD07ACB74
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 20:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjIXSjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 14:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjIXSjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 14:39:33 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35D1FF
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 11:39:25 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-405361bb9f7so49184395e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 11:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695580764; x=1696185564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V4QGZskn2DYaZcH0HwU/BgdBem2G2usiIalK5gqegVI=;
        b=o797mJQMXgJn22qDa7N/KuvzuT2rlXT44CfSNqoDs1iHtYhbebKTZmIjsFVA4G7COa
         OJvzhbg1K835mqp6avAdEVdIWpfYDOxofAwqIn2DDX6eryAgDehnhr6E1HJReziPzG4R
         8xw0/CPnvgdwnGHyzCuNmr2c/qsdUM7XeQ6diT+QlHO/0hZqyaANJlx6t/ZRgqquNhs4
         YGeH0JrhVyxeB0OAFLZNpBb5AGlJ6KeogHeYQdG447r4/gv8PQGuEFG6QWWOfkLxKdPX
         DklYv95NjNdjoen6FBcrZJv3l1+MyQefxl0PYlyfm5LggudjJiHlJOIe9bxHfCMFsD6V
         ZHCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695580764; x=1696185564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V4QGZskn2DYaZcH0HwU/BgdBem2G2usiIalK5gqegVI=;
        b=PfJ/dUFRTnKmBmCfOzHBMMJcNbHuw5GXp3vmALCwbYIuHedLtt3DjCTmSRbXkbM96r
         PVXm94eoQApgG2Ifqsh2ANovORG4CY8LfUaJ6ID6pakV/eN91SzqRb0/XF8TqA6QqXOm
         4ZvvR3WMNxUcHYDbL1fk4m3N84qADJ6hS95DFp1zO9H/Txd6CaabWBaBkBEubeSIlcSF
         449/DIEUYxVOURTc6MuN4RU18nNP/CsVDfpe290aPxoznaKtT0EA4HGgygrgs6f3u9uB
         8TJS5hsSNxi25EjpXv/+V3ykDgF7g/6qnNQAiqbY1ak5wJnXDkZQaGASZxsYIK4opdaV
         zJkA==
X-Gm-Message-State: AOJu0YyF9ubyR7yukz/hLvBTKBhiej+YTJ9fndIM3NWx+gpqmPXhx4vn
        cE7xkfsgDi6zJypGfC5rMQU7RA==
X-Google-Smtp-Source: AGHT+IEfxrMEzlSC+hdQp0TL0iJHbNZcOyk6Pqd6RnD8uZLMsi/XQAjZkCT/yxAqug8YWxpALmprIQ==
X-Received: by 2002:a1c:7904:0:b0:403:787:e878 with SMTP id l4-20020a1c7904000000b004030787e878mr3908479wme.21.1695580763418;
        Sun, 24 Sep 2023 11:39:23 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.100])
        by smtp.gmail.com with ESMTPSA id v20-20020a05600c215400b00401b242e2e6sm7570446wml.47.2023.09.24.11.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 11:39:23 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RESEND PATCH 4/4] ARM: dts: qcom: ipq8064: move keys and leds out of soc node
Date:   Sun, 24 Sep 2023 20:39:14 +0200
Message-Id: <20230924183914.51414-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230924183914.51414-1-krzysztof.kozlowski@linaro.org>
References: <20230924183914.51414-1-krzysztof.kozlowski@linaro.org>
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

GPIO keys and LEDs are not part of the SoC, so move them to top-level to
fix dtbs_check warnings like:

  qcom-ipq8064-rb3011.dtb: soc: gpio-keys: {'compatible': ['gpio-keys'], ... should not be valid under {'type': 'object'}
        from schema $id: http://devicetree.org/schemas/simple-bus.yaml#

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../arm/boot/dts/qcom/qcom-ipq8064-rb3011.dts |  55 ++++----
 arch/arm/boot/dts/qcom/qcom-ipq8064-v1.0.dtsi | 122 +++++++++---------
 2 files changed, 88 insertions(+), 89 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-ipq8064-rb3011.dts b/arch/arm/boot/dts/qcom/qcom-ipq8064-rb3011.dts
index 1796ded31d17..12e806adcda8 100644
--- a/arch/arm/boot/dts/qcom/qcom-ipq8064-rb3011.dts
+++ b/arch/arm/boot/dts/qcom/qcom-ipq8064-rb3011.dts
@@ -20,6 +20,33 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-0 = <&buttons_pins>;
+		pinctrl-names = "default";
+
+		button {
+			label = "reset";
+			linux,code = <KEY_RESTART>;
+			gpios = <&qcom_pinmux 66 GPIO_ACTIVE_LOW>;
+			linux,input-type = <1>;
+			debounce-interval = <60>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-0 = <&leds_pins>;
+		pinctrl-names = "default";
+
+		led-0 {
+			label = "rb3011:green:user";
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&qcom_pinmux 33 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+	};
+
 	memory@42000000 {
 		reg = <0x42000000 0x3e000000>;
 		device_type = "memory";
@@ -302,34 +329,6 @@ partition@0 {
 				};
 			};
 		};
-
-		gpio-keys {
-			compatible = "gpio-keys";
-			pinctrl-0 = <&buttons_pins>;
-			pinctrl-names = "default";
-
-			button {
-				label = "reset";
-				linux,code = <KEY_RESTART>;
-				gpios = <&qcom_pinmux 66 GPIO_ACTIVE_LOW>;
-				linux,input-type = <1>;
-				debounce-interval = <60>;
-			};
-		};
-
-		leds {
-			compatible = "gpio-leds";
-			pinctrl-0 = <&leds_pins>;
-			pinctrl-names = "default";
-
-			led-0 {
-				label = "rb3011:green:user";
-				color = <LED_COLOR_ID_GREEN>;
-				gpios = <&qcom_pinmux 33 GPIO_ACTIVE_HIGH>;
-				default-state = "off";
-			};
-		};
-
 	};
 };
 
diff --git a/arch/arm/boot/dts/qcom/qcom-ipq8064-v1.0.dtsi b/arch/arm/boot/dts/qcom/qcom-ipq8064-v1.0.dtsi
index 17f65e140e02..49de9752632f 100644
--- a/arch/arm/boot/dts/qcom/qcom-ipq8064-v1.0.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-ipq8064-v1.0.dtsi
@@ -14,6 +14,67 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-0 = <&buttons_pins>;
+		pinctrl-names = "default";
+
+		button-1 {
+			label = "reset";
+			linux,code = <KEY_RESTART>;
+			gpios = <&qcom_pinmux 54 GPIO_ACTIVE_LOW>;
+			linux,input-type = <1>;
+			debounce-interval = <60>;
+		};
+		button-2 {
+			label = "wps";
+			linux,code = <KEY_WPS_BUTTON>;
+			gpios = <&qcom_pinmux 65 GPIO_ACTIVE_LOW>;
+			linux,input-type = <1>;
+			debounce-interval = <60>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-0 = <&leds_pins>;
+		pinctrl-names = "default";
+
+		led-0 {
+			label = "led_usb1";
+			gpios = <&qcom_pinmux 7 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "usbdev";
+			default-state = "off";
+		};
+
+		led-1 {
+			label = "led_usb3";
+			gpios = <&qcom_pinmux 8 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "usbdev";
+			default-state = "off";
+		};
+
+		led-2 {
+			label = "status_led_fail";
+			function = LED_FUNCTION_STATUS;
+			gpios = <&qcom_pinmux 9 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		led-3 {
+			label = "sata_led";
+			gpios = <&qcom_pinmux 26 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		led-4 {
+			label = "status_led_pass";
+			function = LED_FUNCTION_STATUS;
+			gpios = <&qcom_pinmux 53 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+	};
+
 	soc {
 		gsbi@16300000 {
 			qcom,mode = <GSBI_PROT_I2C_UART>;
@@ -64,66 +125,5 @@ sata@29000000 {
 			ports-implemented = <0x1>;
 			status = "okay";
 		};
-
-		gpio-keys {
-			compatible = "gpio-keys";
-			pinctrl-0 = <&buttons_pins>;
-			pinctrl-names = "default";
-
-			button-1 {
-				label = "reset";
-				linux,code = <KEY_RESTART>;
-				gpios = <&qcom_pinmux 54 GPIO_ACTIVE_LOW>;
-				linux,input-type = <1>;
-				debounce-interval = <60>;
-			};
-			button-2 {
-				label = "wps";
-				linux,code = <KEY_WPS_BUTTON>;
-				gpios = <&qcom_pinmux 65 GPIO_ACTIVE_LOW>;
-				linux,input-type = <1>;
-				debounce-interval = <60>;
-			};
-		};
-
-		leds {
-			compatible = "gpio-leds";
-			pinctrl-0 = <&leds_pins>;
-			pinctrl-names = "default";
-
-			led-0 {
-				label = "led_usb1";
-				gpios = <&qcom_pinmux 7 GPIO_ACTIVE_HIGH>;
-				linux,default-trigger = "usbdev";
-				default-state = "off";
-			};
-
-			led-1 {
-				label = "led_usb3";
-				gpios = <&qcom_pinmux 8 GPIO_ACTIVE_HIGH>;
-				linux,default-trigger = "usbdev";
-				default-state = "off";
-			};
-
-			led-2 {
-				label = "status_led_fail";
-				function = LED_FUNCTION_STATUS;
-				gpios = <&qcom_pinmux 9 GPIO_ACTIVE_HIGH>;
-				default-state = "off";
-			};
-
-			led-3 {
-				label = "sata_led";
-				gpios = <&qcom_pinmux 26 GPIO_ACTIVE_HIGH>;
-				default-state = "off";
-			};
-
-			led-4 {
-				label = "status_led_pass";
-				function = LED_FUNCTION_STATUS;
-				gpios = <&qcom_pinmux 53 GPIO_ACTIVE_HIGH>;
-				default-state = "off";
-			};
-		};
 	};
 };
-- 
2.34.1

