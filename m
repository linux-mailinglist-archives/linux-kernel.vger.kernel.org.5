Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6805C762C96
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 09:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbjGZHGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 03:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjGZHFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 03:05:42 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E8349E4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 00:03:39 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5221f193817so5676933a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 00:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690355017; x=1690959817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F4NEIl0PF0jWLTgC3MG7VZaECShTTB2BR5eqLLfzHn0=;
        b=fJBgXQ+8eV+aY5RpuuTg+SXdJ82OameqMpnOM06NXyGaJkQa7LSY8oytbkt9cvaZuL
         XRBu2MGH9aKCYb1L7h//H8eFqvXRjdrTHzhO3820qwDp6MuJcia5+t5M9ixdWfOlxjYW
         /SAH6L8ADxt7NnHTemHkeh3n0shIfBOT23sOoxVY/rXTkSx7zhHKWuz5mv22Geq+iW4E
         ICpM7lTYjJeeGifNGSJ48vLLXbVedBeaO1Cu/xfTldupF0JYmiaXca6hrnRX79onNPRG
         G0iZVJt5rZ4p1+HuN5vH597gr1udFu+8mwANey/g9Hs8/ZZEzA10A1r/yra1NOeHHZto
         urqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690355017; x=1690959817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F4NEIl0PF0jWLTgC3MG7VZaECShTTB2BR5eqLLfzHn0=;
        b=MBCMMYi+KOZVyXxcxx7o8PMRE+22nqNAePFKb+YoJ4EIUbXNpXYJNMSDWwIRk/k2fy
         KRnxkdm1Bf5zA55eAIjpqYJnM5UYyc/qEF/WO5l6hNQcz5HgyJLhhc8ErBSABbQgSYTf
         OOVssf+riorIG0kJjKryZfR6D44EwR+YlCH+tMULU0l9J8oHrF/qvPyQqKPicU1cG4vQ
         gO6Tb79XuvDJ/fpkGdAPbDaxqggqjkPcU2eNq60B04+SgFJ0gbsahN/NWPzdp6F4jhYz
         xx76uy/+ngGXOjMph2Ykl98DjxXnttKBYoYA6tdNSAl8FJ6CY1ba9mimNWS8t3UgIiTA
         aQ8w==
X-Gm-Message-State: ABy/qLbIuEB1xd1cQ+R7oS3FCH6dirud1AUeSEyE1xXDMi5LfdRhQSW8
        LaVxwqt5ODFkvt9UwwSz0nnPQA==
X-Google-Smtp-Source: APBJJlHK9AaezVXLCEASRuLyz474dcZIyZkKzKbObKu8+M+Dcd8Ek/phvOVZNz3xG5x+7GxIQyVoKw==
X-Received: by 2002:aa7:c901:0:b0:522:4766:6990 with SMTP id b1-20020aa7c901000000b0052247666990mr810358edt.6.1690355017598;
        Wed, 26 Jul 2023 00:03:37 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id dy16-20020a05640231f000b005224f840130sm1572003edb.60.2023.07.26.00.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 00:03:37 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 6/8] ARM: dts: imx25: drop incorrect reg in fixed regulators
Date:   Wed, 26 Jul 2023 09:03:20 +0200
Message-Id: <20230726070322.103871-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726070322.103871-1-krzysztof.kozlowski@linaro.org>
References: <20230726070322.103871-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed regulators are not in some bus and bindings do not allow a "reg"
property.  Move them out of "regulators" node to top-level.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 ...25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts | 25 +++-----
 arch/arm/boot/dts/nxp/imx/imx25-karo-tx25.dts | 21 +++----
 arch/arm/boot/dts/nxp/imx/imx25-pdk.dts       | 62 ++++++++-----------
 3 files changed, 42 insertions(+), 66 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts b/arch/arm/boot/dts/nxp/imx/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts
index 7d4301b22b90..fc8a502fc957 100644
--- a/arch/arm/boot/dts/nxp/imx/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts
@@ -30,22 +30,15 @@ qvga_timings: 320x240 {
 		};
 	};
 
-	regulators {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		reg_lcd_3v3: regulator@0 {
-			compatible = "regulator-fixed";
-			reg = <0>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_reg_lcd_3v3>;
-			regulator-name = "lcd-3v3";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			gpio = <&gpio1 26 GPIO_ACTIVE_HIGH>;
-			enable-active-high;
-		};
+	reg_lcd_3v3: regulator-0 {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_lcd_3v3>;
+		regulator-name = "lcd-3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio1 26 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
 	};
 };
 
diff --git a/arch/arm/boot/dts/nxp/imx/imx25-karo-tx25.dts b/arch/arm/boot/dts/nxp/imx/imx25-karo-tx25.dts
index 57d5ade5aa46..458b94d3d4ed 100644
--- a/arch/arm/boot/dts/nxp/imx/imx25-karo-tx25.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx25-karo-tx25.dts
@@ -14,20 +14,13 @@ chosen {
 		stdout-path = &uart1;
 	};
 
-	regulators {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		reg_fec_phy: regulator@0 {
-			compatible = "regulator-fixed";
-			reg = <0>;
-			regulator-name = "fec-phy";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			gpio = <&gpio4 9 0>;
-			enable-active-high;
-		};
+	reg_fec_phy: regulator-0 {
+		compatible = "regulator-fixed";
+		regulator-name = "fec-phy";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio4 9 0>;
+		enable-active-high;
 	};
 
 	memory@80000000 {
diff --git a/arch/arm/boot/dts/nxp/imx/imx25-pdk.dts b/arch/arm/boot/dts/nxp/imx/imx25-pdk.dts
index fb66884d8a2f..04f4b127a172 100644
--- a/arch/arm/boot/dts/nxp/imx/imx25-pdk.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx25-pdk.dts
@@ -16,45 +16,35 @@ memory@80000000 {
 		reg = <0x80000000 0x4000000>;
 	};
 
-	regulators {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
+	reg_fec_3v3: regulator-0 {
+		compatible = "regulator-fixed";
+		regulator-name = "fec-3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio2 3 0>;
+		enable-active-high;
+	};
 
-		reg_fec_3v3: regulator@0 {
-			compatible = "regulator-fixed";
-			reg = <0>;
-			regulator-name = "fec-3v3";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			gpio = <&gpio2 3 0>;
-			enable-active-high;
-		};
+	reg_2p5v: regulator-1 {
+		compatible = "regulator-fixed";
+		regulator-name = "2P5V";
+		regulator-min-microvolt = <2500000>;
+		regulator-max-microvolt = <2500000>;
+	};
 
-		reg_2p5v: regulator@1 {
-			compatible = "regulator-fixed";
-			reg = <1>;
-			regulator-name = "2P5V";
-			regulator-min-microvolt = <2500000>;
-			regulator-max-microvolt = <2500000>;
-		};
+	reg_3p3v: regulator-2 {
+		compatible = "regulator-fixed";
+		regulator-name = "3P3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
 
-		reg_3p3v: regulator@2 {
-			compatible = "regulator-fixed";
-			reg = <2>;
-			regulator-name = "3P3V";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-		};
-
-		reg_can_3v3: regulator@3 {
-			compatible = "regulator-fixed";
-			reg = <3>;
-			regulator-name = "can-3v3";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			gpio = <&gpio4 6 0>;
-		};
+	reg_can_3v3: regulator-3 {
+		compatible = "regulator-fixed";
+		regulator-name = "can-3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio4 6 0>;
 	};
 
 	sound {
-- 
2.34.1

