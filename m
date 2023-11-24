Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D067F708B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 10:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345420AbjKXJvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 04:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345394AbjKXJvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 04:51:04 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADB61724
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 01:51:09 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-a02cc476581so229069366b.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 01:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700819468; x=1701424268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bO+PPdyDN5MVT3V2+fuH2AeOA9fKKd0jMaVaXqc75fI=;
        b=MORr+MAvaYFyX+4ZviKp3KTakIX4YuFrdkLHM9Kz/4NdFDBhV/Zr1M/eOZKKO4iCec
         eHJWcg1m+zx4c441pslXNWw448gxesj1xeAnXD8NmzLWN4rsGSBWWZFc2guvvyyU8iHF
         x884L10j6+uvqZ0XF0A+xp2OifCsYHaMzM37jGd+J/YCdx77VbY5VeYDDfsNe/KaQwVp
         pTLeme5+BM9SpGGa11g40hdqI2OLd8RABOnPngxREE1RDL8MXhfRsBIOFR9+fZXq97lM
         +QAAAUz06PDui21BhTeBDGUfnNS0zFQe8fiADSvmM1ro+iNjLYag9Bdrgr2CELLhelCm
         gUSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700819468; x=1701424268;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bO+PPdyDN5MVT3V2+fuH2AeOA9fKKd0jMaVaXqc75fI=;
        b=slh+fgrKKt9YbvE1LKuHKhk0WUXn76q2lZ2e81hEZaY5m0iUxrClrWYCEXHPj6PG1Q
         gskSKK+saIe5m7I3ha193SAGux5cGpddXBp7ZGh1sTMcVGuh/pM4+vAxxuaNy/1LwmrL
         c6CTBDiFm9dfl5Ax+dQkzoLwSTJldf3dErXNI4ZrYqZMfCoj8bkAvuh41umZd/anKeZy
         EZxnOD1pGqHWA+t/7RZSSAGeugAgU2xg8nM9EL5K8qNZhjxb5nHGkX/130TX6gOttwkL
         5k6rb/yH6fFy/Dc8XL4cGhjPDZBj0y1sDvbS1svAAQBimWdpmC34QSB+o54yytqwKJoz
         rS0Q==
X-Gm-Message-State: AOJu0Yw4FmcaScIKNYhvtdnY+Ojp7gvqd/DJyyB7w8kOzccV9Rp4vDQn
        M/uA8UAYap9nnZuunFOp9Eq56Q==
X-Google-Smtp-Source: AGHT+IFJ6NNm5jMphkfEqEfKowJBGmxKJBwxw0riIN+3giKUvN7gFPZR63pGljQvjW7DVoLsMI7k0A==
X-Received: by 2002:a17:906:39c9:b0:9f3:18f8:475b with SMTP id i9-20020a17090639c900b009f318f8475bmr1629556eje.62.1700819468239;
        Fri, 24 Nov 2023 01:51:08 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.100])
        by smtp.gmail.com with ESMTPSA id ga10-20020a170906b84a00b009fd0102f71asm1860789ejb.176.2023.11.24.01.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 01:51:07 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Li Yang <leoyang.li@nxp.com>, Stefan Agner <stefan@agner.ch>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] ARM: dts: nxp: minor whitespace cleanup around '='
Date:   Fri, 24 Nov 2023 10:51:03 +0100
Message-Id: <20231124095104.58772-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DTS code coding style expects exactly one space before and after '='
sign.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/nxp/imx/imx53-cx9020.dts             | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6dl-b105pv2.dts           | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6dl-b105v2.dts            | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6dl-b125pv2.dts           | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6dl-b125v2.dts            | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6dl-b155v2.dts            | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6q-var-mx6customboard.dts | 4 ++--
 arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi          | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-emcon-avari.dtsi     | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-skov-cpu-revc.dtsi   | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi                 | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6sx.dtsi                  | 8 ++++----
 arch/arm/boot/dts/nxp/imx/imx6ul.dtsi                  | 2 +-
 arch/arm/boot/dts/nxp/imx/imx7d-meerkat96.dts          | 2 +-
 arch/arm/boot/dts/nxp/imx/imx7d-smegw01.dts            | 2 +-
 arch/arm/boot/dts/nxp/lpc/lpc18xx.dtsi                 | 2 +-
 arch/arm/boot/dts/nxp/ls/ls1021a.dtsi                  | 2 +-
 arch/arm/boot/dts/nxp/vf/vf-colibri-eval-v3.dtsi       | 2 +-
 arch/arm/boot/dts/nxp/vf/vf610-bk4.dts                 | 4 ++--
 arch/arm/boot/dts/nxp/vf/vf610-zii-dev-rev-b.dts       | 6 +++---
 20 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx53-cx9020.dts b/arch/arm/boot/dts/nxp/imx/imx53-cx9020.dts
index 055d23a9aee7..0814f5665a59 100644
--- a/arch/arm/boot/dts/nxp/imx/imx53-cx9020.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx53-cx9020.dts
@@ -22,7 +22,7 @@ memory@70000000 {
 	};
 
 	display-0 {
-		#address-cells =<1>;
+		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "fsl,imx-parallel-display";
 		interface-pix-fmt = "rgb24";
diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-b105pv2.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-b105pv2.dts
index 7d4ae113c381..63cdf24eb397 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-b105pv2.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-b105pv2.dts
@@ -22,7 +22,7 @@ touchscreen@41 {
 		compatible = "ilitek,ili251x";
 		reg = <0x41>;
 		pinctrl-names = "default";
-		pinctrl-0 =<&pinctrl_q7_gpio0>;
+		pinctrl-0 = <&pinctrl_q7_gpio0>;
 		interrupt-parent = <&gpio5>;
 		interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
 		reset-gpios = <&tca6424a 21 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-b105v2.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-b105v2.dts
index 9c5938e16d99..2e75d700efdb 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-b105v2.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-b105v2.dts
@@ -22,7 +22,7 @@ touchscreen@41 {
 		compatible = "ilitek,ili251x";
 		reg = <0x41>;
 		pinctrl-names = "default";
-		pinctrl-0 =<&pinctrl_q7_gpio0>;
+		pinctrl-0 = <&pinctrl_q7_gpio0>;
 		interrupt-parent = <&gpio5>;
 		interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
 		reset-gpios = <&tca6424a 21 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-b125pv2.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-b125pv2.dts
index 01df7cffcef2..94625d5d5918 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-b125pv2.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-b125pv2.dts
@@ -22,7 +22,7 @@ touchscreen@2a {
 		compatible = "eeti,exc80h60";
 		reg = <0x2a>;
 		pinctrl-names = "default";
-		pinctrl-0 =<&pinctrl_q7_gpio0>;
+		pinctrl-0 = <&pinctrl_q7_gpio0>;
 		interrupt-parent = <&gpio5>;
 		interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
 		reset-gpios = <&tca6424a 21 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-b125v2.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-b125v2.dts
index a015453daf10..b3cfa8110ade 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-b125v2.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-b125v2.dts
@@ -22,7 +22,7 @@ touchscreen@2a {
 		compatible = "eeti,exc80h60";
 		reg = <0x2a>;
 		pinctrl-names = "default";
-		pinctrl-0 =<&pinctrl_q7_gpio0>;
+		pinctrl-0 = <&pinctrl_q7_gpio0>;
 		interrupt-parent = <&gpio5>;
 		interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
 		reset-gpios = <&tca6424a 21 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-b155v2.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-b155v2.dts
index b71ee6b79208..7edc788bcb8f 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-b155v2.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-b155v2.dts
@@ -22,7 +22,7 @@ touchscreen@2a {
 		compatible = "eeti,exc80h84";
 		reg = <0x2a>;
 		pinctrl-names = "default";
-		pinctrl-0 =<&pinctrl_q7_gpio0>;
+		pinctrl-0 = <&pinctrl_q7_gpio0>;
 		interrupt-parent = <&gpio5>;
 		interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
 		touchscreen-inverted-x;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-var-mx6customboard.dts b/arch/arm/boot/dts/nxp/imx/imx6q-var-mx6customboard.dts
index 6f9d094dd6d0..18a620832a2a 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-var-mx6customboard.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-var-mx6customboard.dts
@@ -16,7 +16,7 @@ / {
 	compatible = "variscite,mx6customboard", "variscite,var-som-imx6q", "fsl,imx6q";
 
 	panel0: lvds-panel0 {
-		compatible =  "panel-lvds";
+		compatible = "panel-lvds";
 		backlight = <&backlight_lvds>;
 		width-mm = <152>;
 		height-mm = <91>;
@@ -43,7 +43,7 @@ panel_in_lvds0: endpoint {
 	};
 
 	panel1: lvds-panel1 {
-		compatible =  "panel-lvds";
+		compatible = "panel-lvds";
 		width-mm = <152>;
 		height-mm = <91>;
 		data-mapping = "jeida-18";
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi
index 4cc965277c52..c07e0fcdc81b 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi
@@ -166,7 +166,7 @@ reg_usb_host_vbus_hub: regulator-usb-host-vbus-hub {
 	reg_usb_host_vbus: regulator-usb-host-vbus {
 		compatible = "regulator-fixed";
 		enable-active-high;
-		gpio =  <&gpio1 0 GPIO_ACTIVE_HIGH>;
+		gpio = <&gpio1 0 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_regulator_usbh_pwr>;
 		regulator-max-microvolt = <5000000>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-emcon-avari.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-emcon-avari.dtsi
index f1a41c76729c..5587069b6052 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-emcon-avari.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-emcon-avari.dtsi
@@ -54,7 +54,7 @@ reg_usb_otg: reg-otgvbus {
 	clk_codec: clock-codec {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
-		clock-frequency  = <12000000>;
+		clock-frequency = <12000000>;
 	};
 
 	sound {
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-skov-cpu-revc.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-skov-cpu-revc.dtsi
index b81799d7076a..596b3bb3ddd1 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-skov-cpu-revc.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-skov-cpu-revc.dtsi
@@ -25,7 +25,7 @@ adc_ts: adc@0 {
 		compatible = "ti,tsc2046e-adc";
 		reg = <0>;
 		pinctrl-0 = <&pinctrl_touch>;
-		pinctrl-names ="default";
+		pinctrl-names = "default";
 		spi-max-frequency = <1000000>;
 		interrupts-extended = <&gpio3 19 IRQ_TYPE_LEVEL_LOW>;
 		#io-channel-cells = <1>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi
index bda182edc589..81142c523fa8 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi
@@ -475,7 +475,7 @@ asrc: asrc@2034000 {
 						<&sdma 20 23 1>, <&sdma 21 23 1>, <&sdma 22 23 1>;
 					dma-names = "rxa", "rxb", "rxc",
 							"txa", "txb", "txc";
-					fsl,asrc-rate  = <48000>;
+					fsl,asrc-rate = <48000>;
 					fsl,asrc-width = <16>;
 					status = "okay";
 				};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6sx.dtsi b/arch/arm/boot/dts/nxp/imx/imx6sx.dtsi
index f6b35923ad83..df3a375f0a3e 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6sx.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6sx.dtsi
@@ -418,7 +418,7 @@ asrc: asrc@2034000 {
 					       <&sdma 21 23 1>, <&sdma 22 23 1>;
 					dma-names = "rxa", "rxb", "rxc",
 						    "txa", "txb", "txc";
-					fsl,asrc-rate  = <48000>;
+					fsl,asrc-rate = <48000>;
 					fsl,asrc-width = <16>;
 					status = "okay";
 				};
@@ -1010,7 +1010,7 @@ usdhc1: mmc@2190000 {
 				clock-names = "ipg", "ahb", "per";
 				bus-width = <4>;
 				fsl,tuning-start-tap = <20>;
-				fsl,tuning-step= <2>;
+				fsl,tuning-step = <2>;
 				status = "disabled";
 			};
 
@@ -1024,7 +1024,7 @@ usdhc2: mmc@2194000 {
 				clock-names = "ipg", "ahb", "per";
 				bus-width = <4>;
 				fsl,tuning-start-tap = <20>;
-				fsl,tuning-step= <2>;
+				fsl,tuning-step = <2>;
 				status = "disabled";
 			};
 
@@ -1038,7 +1038,7 @@ usdhc3: mmc@2198000 {
 				clock-names = "ipg", "ahb", "per";
 				bus-width = <4>;
 				fsl,tuning-start-tap = <20>;
-				fsl,tuning-step= <2>;
+				fsl,tuning-step = <2>;
 				status = "disabled";
 			};
 
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul.dtsi
index 3b87d980e9f4..a27a7554c2e7 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul.dtsi
@@ -364,7 +364,7 @@ asrc: asrc@2034000 {
 						<&sdma 20 23 1>, <&sdma 21 23 1>, <&sdma 22 23 1>;
 					dma-names = "rxa", "rxb", "rxc",
 						    "txa", "txb", "txc";
-					fsl,asrc-rate  = <48000>;
+					fsl,asrc-rate = <48000>;
 					fsl,asrc-width = <16>;
 					status = "okay";
 				};
diff --git a/arch/arm/boot/dts/nxp/imx/imx7d-meerkat96.dts b/arch/arm/boot/dts/nxp/imx/imx7d-meerkat96.dts
index dd8003bd1fc0..f0fda15f3020 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7d-meerkat96.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx7d-meerkat96.dts
@@ -212,7 +212,7 @@ &usdhc3 {
 	keep-power-in-suspend;
 	wakeup-source;
 	vmmc-supply = <&reg_wlreg_on>;
-	vqmmc-supply =<&reg_3p3v>;
+	vqmmc-supply = <&reg_3p3v>;
 	status = "okay";
 
 	brcmf: wifi@1 {
diff --git a/arch/arm/boot/dts/nxp/imx/imx7d-smegw01.dts b/arch/arm/boot/dts/nxp/imx/imx7d-smegw01.dts
index 85b97b5f64e7..7ed27c7ad726 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7d-smegw01.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx7d-smegw01.dts
@@ -149,7 +149,7 @@ &fec2 {
 
 &i2c2 {
 	pinctrl-names = "default";
-	pinctrl-0 =<&pinctrl_i2c2>;
+	pinctrl-0 = <&pinctrl_i2c2>;
 	clock-frequency = <100000>;
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/nxp/lpc/lpc18xx.dtsi b/arch/arm/boot/dts/nxp/lpc/lpc18xx.dtsi
index 9cf09c183b85..6dd73290f0c6 100644
--- a/arch/arm/boot/dts/nxp/lpc/lpc18xx.dtsi
+++ b/arch/arm/boot/dts/nxp/lpc/lpc18xx.dtsi
@@ -74,7 +74,7 @@ soc {
 		sct_pwm: pwm@40000000 {
 			compatible = "nxp,lpc1850-sct-pwm";
 			reg = <0x40000000 0x1000>;
-			clocks =<&ccu1 CLK_CPU_SCT>;
+			clocks = <&ccu1 CLK_CPU_SCT>;
 			clock-names = "pwm";
 			resets = <&rgu 37>;
 			#pwm-cells = <3>;
diff --git a/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi b/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
index 49c78c84cd5d..d471cc5efa94 100644
--- a/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
+++ b/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
@@ -112,7 +112,7 @@ msi1: msi-controller@1570e00 {
 			compatible = "fsl,ls1021a-msi";
 			reg = <0x0 0x1570e00 0x0 0x8>;
 			msi-controller;
-			interrupts =  <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		msi2: msi-controller@1570e08 {
diff --git a/arch/arm/boot/dts/nxp/vf/vf-colibri-eval-v3.dtsi b/arch/arm/boot/dts/nxp/vf/vf-colibri-eval-v3.dtsi
index 14c411f146f5..5a19da9313ae 100644
--- a/arch/arm/boot/dts/nxp/vf/vf-colibri-eval-v3.dtsi
+++ b/arch/arm/boot/dts/nxp/vf/vf-colibri-eval-v3.dtsi
@@ -55,7 +55,7 @@ &bl {
 	brightness-levels = <0 4 8 16 32 64 128 255>;
 	default-brightness-level = <6>;
 	power-supply = <&reg_3v3>;
-	status  = "okay";
+	status = "okay";
 };
 
 &dcu0 {
diff --git a/arch/arm/boot/dts/nxp/vf/vf610-bk4.dts b/arch/arm/boot/dts/nxp/vf/vf610-bk4.dts
index e4f691d601cc..722182f5fd17 100644
--- a/arch/arm/boot/dts/nxp/vf/vf610-bk4.dts
+++ b/arch/arm/boot/dts/nxp/vf/vf610-bk4.dts
@@ -68,7 +68,7 @@ spi {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		/* PTD12 ->RPIO[91] */
-		sck-gpios  = <&gpio2 27 GPIO_ACTIVE_LOW>;
+		sck-gpios = <&gpio2 27 GPIO_ACTIVE_LOW>;
 		/* PTD10 ->RPIO[89] */
 		miso-gpios = <&gpio2 25 GPIO_ACTIVE_HIGH>;
 		num-chipselects = <0>;
@@ -79,7 +79,7 @@ gpio@0 {
 			gpio-controller;
 			#gpio-cells = <2>;
 			/* PTB18 -> RGPIO[40] */
-			load-gpios  = <&gpio1 8 GPIO_ACTIVE_LOW>;
+			load-gpios = <&gpio1 8 GPIO_ACTIVE_LOW>;
 			spi-max-frequency = <100000>;
 		};
 	};
diff --git a/arch/arm/boot/dts/nxp/vf/vf610-zii-dev-rev-b.dts b/arch/arm/boot/dts/nxp/vf/vf610-zii-dev-rev-b.dts
index 16b4e06c4efa..b0ed68af0546 100644
--- a/arch/arm/boot/dts/nxp/vf/vf610-zii-dev-rev-b.dts
+++ b/arch/arm/boot/dts/nxp/vf/vf610-zii-dev-rev-b.dts
@@ -294,11 +294,11 @@ spi-0 {
 		pinctrl-names = "default";
 		#address-cells = <1>;
 		#size-cells = <0>;
-		sck-gpios  = <&gpio1 12 GPIO_ACTIVE_HIGH>;
+		sck-gpios = <&gpio1 12 GPIO_ACTIVE_HIGH>;
 		mosi-gpios = <&gpio1 11 GPIO_ACTIVE_HIGH>;
 		miso-gpios = <&gpio1 10 GPIO_ACTIVE_HIGH>;
-		cs-gpios  = <&gpio1  9 GPIO_ACTIVE_LOW
-			     &gpio1  8 GPIO_ACTIVE_HIGH>;
+		cs-gpios = <&gpio1 9 GPIO_ACTIVE_LOW
+			    &gpio1 8 GPIO_ACTIVE_HIGH>;
 		num-chipselects = <2>;
 
 		flash@0 {
-- 
2.34.1

