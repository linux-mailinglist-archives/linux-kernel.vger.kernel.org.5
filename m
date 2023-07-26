Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A154E762C86
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 09:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbjGZHFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 03:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbjGZHE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 03:04:56 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BFDE7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 00:03:07 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99454855de1so928014766b.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 00:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690354986; x=1690959786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uPWxFIx+eV9yOy/t+ypJOxNFnBZqIeaWUT3Uk3u7b0w=;
        b=jhY4qWmBpASsQ4Brt/XHHdRzER4JN4HBZdhy8bo/yKjMPiGr+Cz/R50Q92uI6qIuVn
         alVohXyoVBuOXGDAt+cD52pqY4tRFa7BQ531YtEIaul7JmxzY56hJlz4K/o/jGUAAPCh
         v3x+1e7Lpr7mwgGQAu4JSiOoDvzVgX9gH7izBQcPTyxVT+1X6gdbu6wnAIotNQzX5yH8
         4L+KOCbD4YHoSEEENp+P1veWaFmckSsbO3SI6OaVTeLNkOlkUO59tz/QUOTX9YzKAAoi
         LbtOsjP1VUsd/7+53DdDC8CiXLgFOFCYUKDKLYtxCBAehCuNF0y1VsULh7y7pLE2M05s
         Xvsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690354986; x=1690959786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uPWxFIx+eV9yOy/t+ypJOxNFnBZqIeaWUT3Uk3u7b0w=;
        b=KtjLygRnWE+jfGNgp+kRHERQmWAT/GlndFmRVy45zDrpCoZTD3Ow6W4qd/EU8gekb6
         UvdNhNEDVSEHj8op7NgCegNVFTM9b2vAfM4kmUvAs7ivkEUyuSOQ1bQFP3JebRTxjkwd
         8cpqEX6O6dB2MO5xkL15TuEDM8FNpZn+WJYgdPTWedUV15Id+A4X/rjjhkNEW+Bd0dbY
         ZoolrdgfWB+LyvLrz1dRtStFUX4VsMhECwLfUyvbQSF0vhqhDehqlJxieMqQYOtHGoJ8
         FXl2tKVn036kT5XtTamcIcaH9q4elCtc/kDAmEsJ5h/L44QaF3JtIQ+eYGOO68MpgFMA
         pXFA==
X-Gm-Message-State: ABy/qLbbN0ahM858iIwQhyotCBUvz0oD2U5lbHTipQZMH0OYKRdOgyeB
        gZm+Jp608oZhHFOLQxEXWKYN0g==
X-Google-Smtp-Source: APBJJlEALNwIfdTN8ahxsx/3TJhhk+UZYZH2bIfYYtHSZE90KjnGtCI1ykUm/qDvTautVxLr8TMJFA==
X-Received: by 2002:a17:906:1097:b0:997:eac2:65e0 with SMTP id u23-20020a170906109700b00997eac265e0mr911677eju.73.1690354986024;
        Wed, 26 Jul 2023 00:03:06 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id c21-20020a170906341500b00992b2c55c67sm9249923ejb.156.2023.07.26.00.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 00:03:05 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] ARM: dts: marvell: dove: drop incorrect reg in fixed regulators
Date:   Wed, 26 Jul 2023 09:02:54 +0200
Message-Id: <20230726070254.103661-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726070254.103661-1-krzysztof.kozlowski@linaro.org>
References: <20230726070254.103661-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed regulators are not in some bus and bindings do not allow a "reg"
property.  Move them out of "regulators" node to top-level.

  dove-cubox.dtb: regulator@1: Unevaluated properties are not allowed ('reg' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/marvell/dove-cm-a510.dtsi | 18 +++++--------
 arch/arm/boot/dts/marvell/dove-cubox.dts    | 29 ++++++++-------------
 arch/arm/boot/dts/marvell/dove-d3plug.dts   | 29 ++++++++-------------
 arch/arm/boot/dts/marvell/dove-sbc-a510.dts | 28 +++++++++-----------
 4 files changed, 41 insertions(+), 63 deletions(-)

diff --git a/arch/arm/boot/dts/marvell/dove-cm-a510.dtsi b/arch/arm/boot/dts/marvell/dove-cm-a510.dtsi
index 1082fdfbfe60..621cb145a8f6 100644
--- a/arch/arm/boot/dts/marvell/dove-cm-a510.dtsi
+++ b/arch/arm/boot/dts/marvell/dove-cm-a510.dtsi
@@ -108,18 +108,12 @@ led-system {
 		};
 	};
 
-	regulators {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		wifi_power: regulator@1 {
-			compatible = "regulator-fixed";
-			regulator-name = "WiFi Power";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			gpio = <&gpio2 7 GPIO_ACTIVE_HIGH>;
-		};
+	wifi_power: regulator-1 {
+		compatible = "regulator-fixed";
+		regulator-name = "WiFi Power";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio2 7 GPIO_ACTIVE_HIGH>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/marvell/dove-cubox.dts b/arch/arm/boot/dts/marvell/dove-cubox.dts
index dbba0c8cdab1..bfde99486a87 100644
--- a/arch/arm/boot/dts/marvell/dove-cubox.dts
+++ b/arch/arm/boot/dts/marvell/dove-cubox.dts
@@ -28,24 +28,17 @@ led-power {
 		};
 	};
 
-	regulators {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		usb_power: regulator@1 {
-			compatible = "regulator-fixed";
-			reg = <1>;
-			regulator-name = "USB Power";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			enable-active-high;
-			regulator-always-on;
-			regulator-boot-on;
-			gpio = <&gpio0 1 0>;
-			pinctrl-0 = <&pmx_gpio_1>;
-			pinctrl-names = "default";
-		};
+	usb_power: regulator-1 {
+		compatible = "regulator-fixed";
+		regulator-name = "USB Power";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+		regulator-always-on;
+		regulator-boot-on;
+		gpio = <&gpio0 1 0>;
+		pinctrl-0 = <&pmx_gpio_1>;
+		pinctrl-names = "default";
 	};
 
 	clocks {
diff --git a/arch/arm/boot/dts/marvell/dove-d3plug.dts b/arch/arm/boot/dts/marvell/dove-d3plug.dts
index 5aa5d4a7d51d..a451fd576990 100644
--- a/arch/arm/boot/dts/marvell/dove-d3plug.dts
+++ b/arch/arm/boot/dts/marvell/dove-d3plug.dts
@@ -37,24 +37,17 @@ led-status {
 		};
 	};
 
-	regulators {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		usb_power: regulator@1 {
-			compatible = "regulator-fixed";
-			reg = <1>;
-			regulator-name = "USB Power";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			enable-active-high;
-			regulator-always-on;
-			regulator-boot-on;
-			gpio = <&gpio0 8 0>;
-			pinctrl-0 = <&pmx_gpio_8>;
-			pinctrl-names = "default";
-		};
+	usb_power: regulator-1 {
+		compatible = "regulator-fixed";
+		regulator-name = "USB Power";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+		regulator-always-on;
+		regulator-boot-on;
+		gpio = <&gpio0 8 0>;
+		pinctrl-0 = <&pmx_gpio_8>;
+		pinctrl-names = "default";
 	};
 };
 
diff --git a/arch/arm/boot/dts/marvell/dove-sbc-a510.dts b/arch/arm/boot/dts/marvell/dove-sbc-a510.dts
index df021f9b0117..8585ee5533bf 100644
--- a/arch/arm/boot/dts/marvell/dove-sbc-a510.dts
+++ b/arch/arm/boot/dts/marvell/dove-sbc-a510.dts
@@ -76,22 +76,20 @@ chosen {
 		stdout-path = &uart0;
 	};
 
-	regulators {
-		usb0_power: regulator@2 {
-			compatible = "regulator-fixed";
-			regulator-name = "USB Power";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			gpio = <&gpio_ext 0 GPIO_ACTIVE_HIGH>;
-		};
+	usb0_power: regulator-2 {
+		compatible = "regulator-fixed";
+		regulator-name = "USB Power";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio_ext 0 GPIO_ACTIVE_HIGH>;
+	};
 
-		mmc_power: regulator@3 {
-			compatible = "regulator-fixed";
-			regulator-name = "MMC Power";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			gpio = <&gpio_ext 13 GPIO_ACTIVE_HIGH>;
-		};
+	mmc_power: regulator-3 {
+		compatible = "regulator-fixed";
+		regulator-name = "MMC Power";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio_ext 13 GPIO_ACTIVE_HIGH>;
 	};
 };
 
-- 
2.34.1

