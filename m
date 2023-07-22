Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1508175DC37
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 13:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjGVL5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 07:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjGVL46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 07:56:58 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2953C2B
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 04:56:34 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fbc63c2e84so25411245e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 04:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690026990; x=1690631790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6BvHivSL4TDsPp7ApJR35zlm9ILz6CqpbagGc7qFaLk=;
        b=rwK5YtBhXJhDWAb2vCcDDqlmV0/wgV6wW3CkjjLP/Efg8NiMuJs64b5CzGliZzf2LM
         M29ArF7YkYgjxLVayRO/iqYdjQCpXS+9zMuzYw/COWkhLRkm+/bMKoCc3GaNZjK08z5t
         gMlBqNsSDmi8B4zp7kkEkv2sxuvL7pL/v5oL2gKGvEeo4ZoYN9wL9bf8ESgfiFm+Avuu
         BGuTPMtpe+kxaFAJnJ2g/6Ov/RnUs2Uw/lHKQ2Z6LF/w9M/EeJQL+3XLA46MJQj9dt7x
         BcDtk4MQuhc7MJ68b3vxZ32ai+NPTXprthDTu0TD6Sc9/5jM+I9gmfnZRAcUowCevbG7
         nWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690026990; x=1690631790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6BvHivSL4TDsPp7ApJR35zlm9ILz6CqpbagGc7qFaLk=;
        b=HZySEEuDNpnEd4GOczlczuQMjI6gfhwl34pJ9oIaKCXPXmewzvtxmMBmL3HFAc0f17
         OdZtGE+ZXUsN1gz7V0t8h2pnAlLXQ4nAAyoTr42K9DBtAUngTiN7gEYiQoasrgqs15gh
         ZhMfyMazDtumTDSm81vlZrfD1aGTvtqa4qC5YNxh6wX5CF5OUmfrghQcXYmg1eQiCvXW
         jxhI9DF05JnBMQpJqkqIV7ZBmTBq1kR0wwl9eWOnDqMR32+wq3mDMS7p2693OzNoxXJU
         wNYH9ILEsJKDGdlpBcfQTnO81hpdDlTZPp2V9li5i949fCb/tzZxU9n44LKjOy17LYud
         dTbQ==
X-Gm-Message-State: ABy/qLYIiYLeiu53ijuFXNFFos0wlZpPNWL2mVZ8qwstW8TkYdwBrS6U
        yxxPg0+B8CmTNrRuiGUua/W0hg==
X-Google-Smtp-Source: APBJJlE+WIYolOHapba/dlLU7JGvwghdvgQ1Avc9/xLrghjzn22beGDZFwyI4mQYj8tMEgIpmLdthA==
X-Received: by 2002:a5d:5223:0:b0:314:34f3:aa2 with SMTP id i3-20020a5d5223000000b0031434f30aa2mr3977681wra.13.1690026990523;
        Sat, 22 Jul 2023 04:56:30 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id f18-20020a7bc8d2000000b003fc01189b0dsm5242365wml.42.2023.07.22.04.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jul 2023 04:56:29 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] ARM: dts: samsung: exynos4: fix camera unit addresses/ranges
Date:   Sat, 22 Jul 2023 13:56:18 +0200
Message-Id: <20230722115618.140002-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230722115618.140002-1-krzysztof.kozlowski@linaro.org>
References: <20230722115618.140002-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The camera node has both unit address and children within the same bus
mapping, thus needs proper ranges property to fix dtc W=1 warnings:

  Warning (unit_address_vs_reg): /soc/camera@11800000: node has a unit name, but no reg or ranges property
  Warning (simple_bus_reg): /soc/camera@11800000: missing or empty reg/ranges property

Subtract 0x11800000 from all its children nodes.  No functional impact
expected.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/samsung/exynos4.dtsi    | 26 +++++++++++------------
 arch/arm/boot/dts/samsung/exynos4x12.dtsi | 17 ++++++++-------
 2 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/arch/arm/boot/dts/samsung/exynos4.dtsi b/arch/arm/boot/dts/samsung/exynos4.dtsi
index f775b9377a38..f557ea48c795 100644
--- a/arch/arm/boot/dts/samsung/exynos4.dtsi
+++ b/arch/arm/boot/dts/samsung/exynos4.dtsi
@@ -208,11 +208,11 @@ camera: camera@11800000 {
 			#size-cells = <1>;
 			#clock-cells = <1>;
 			clock-output-names = "cam_a_clkout", "cam_b_clkout";
-			ranges;
+			ranges = <0x0 0x11800000 0xa0000>;
 
-			fimc_0: fimc@11800000 {
+			fimc_0: fimc@0 {
 				compatible = "samsung,exynos4210-fimc";
-				reg = <0x11800000 0x1000>;
+				reg = <0x0 0x1000>;
 				interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clock CLK_FIMC0>,
 					 <&clock CLK_SCLK_FIMC0>;
@@ -223,9 +223,9 @@ fimc_0: fimc@11800000 {
 				status = "disabled";
 			};
 
-			fimc_1: fimc@11810000 {
+			fimc_1: fimc@10000 {
 				compatible = "samsung,exynos4210-fimc";
-				reg = <0x11810000 0x1000>;
+				reg = <0x00010000 0x1000>;
 				interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clock CLK_FIMC1>,
 					 <&clock CLK_SCLK_FIMC1>;
@@ -236,9 +236,9 @@ fimc_1: fimc@11810000 {
 				status = "disabled";
 			};
 
-			fimc_2: fimc@11820000 {
+			fimc_2: fimc@20000 {
 				compatible = "samsung,exynos4210-fimc";
-				reg = <0x11820000 0x1000>;
+				reg = <0x00020000 0x1000>;
 				interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clock CLK_FIMC2>,
 					 <&clock CLK_SCLK_FIMC2>;
@@ -249,9 +249,9 @@ fimc_2: fimc@11820000 {
 				status = "disabled";
 			};
 
-			fimc_3: fimc@11830000 {
+			fimc_3: fimc@30000 {
 				compatible = "samsung,exynos4210-fimc";
-				reg = <0x11830000 0x1000>;
+				reg = <0x00030000 0x1000>;
 				interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clock CLK_FIMC3>,
 					 <&clock CLK_SCLK_FIMC3>;
@@ -262,9 +262,9 @@ fimc_3: fimc@11830000 {
 				status = "disabled";
 			};
 
-			csis_0: csis@11880000 {
+			csis_0: csis@80000 {
 				compatible = "samsung,exynos4210-csis";
-				reg = <0x11880000 0x4000>;
+				reg = <0x00080000 0x4000>;
 				interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clock CLK_CSIS0>,
 					 <&clock CLK_SCLK_CSIS0>;
@@ -278,9 +278,9 @@ csis_0: csis@11880000 {
 				#size-cells = <0>;
 			};
 
-			csis_1: csis@11890000 {
+			csis_1: csis@90000 {
 				compatible = "samsung,exynos4210-csis";
-				reg = <0x11890000 0x4000>;
+				reg = <0x00090000 0x4000>;
 				interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clock CLK_CSIS1>,
 					 <&clock CLK_SCLK_CSIS1>;
diff --git a/arch/arm/boot/dts/samsung/exynos4x12.dtsi b/arch/arm/boot/dts/samsung/exynos4x12.dtsi
index 4524c1e6bb2f..b4b5e769145b 100644
--- a/arch/arm/boot/dts/samsung/exynos4x12.dtsi
+++ b/arch/arm/boot/dts/samsung/exynos4x12.dtsi
@@ -451,14 +451,15 @@ &combiner {
 };
 
 &camera {
+	ranges = <0x0 0x11800000 0xba1000>;
 	clocks = <&clock CLK_SCLK_CAM0>, <&clock CLK_SCLK_CAM1>,
 		 <&clock CLK_PIXELASYNCM0>, <&clock CLK_PIXELASYNCM1>;
 	clock-names = "sclk_cam0", "sclk_cam1", "pxl_async0", "pxl_async1";
 
 	/* fimc_[0-3] are configured outside, under phandles */
-	fimc_lite_0: fimc-lite@12390000 {
+	fimc_lite_0: fimc-lite@b90000 {
 		compatible = "samsung,exynos4212-fimc-lite";
-		reg = <0x12390000 0x1000>;
+		reg = <0x00b90000 0x1000>;
 		interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
 		power-domains = <&pd_isp>;
 		clocks = <&isp_clock CLK_ISP_FIMC_LITE0>;
@@ -467,9 +468,9 @@ fimc_lite_0: fimc-lite@12390000 {
 		status = "disabled";
 	};
 
-	fimc_lite_1: fimc-lite@123a0000 {
+	fimc_lite_1: fimc-lite@ba0000 {
 		compatible = "samsung,exynos4212-fimc-lite";
-		reg = <0x123a0000 0x1000>;
+		reg = <0x00ba0000 0x1000>;
 		interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
 		power-domains = <&pd_isp>;
 		clocks = <&isp_clock CLK_ISP_FIMC_LITE1>;
@@ -478,9 +479,9 @@ fimc_lite_1: fimc-lite@123a0000 {
 		status = "disabled";
 	};
 
-	fimc_is: fimc-is@12000000 {
+	fimc_is: fimc-is@800000 {
 		compatible = "samsung,exynos4212-fimc-is";
-		reg = <0x12000000 0x260000>;
+		reg = <0x00800000 0x260000>;
 		interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
 		power-domains = <&pd_isp>;
@@ -522,9 +523,9 @@ fimc_is: fimc-is@12000000 {
 		ranges;
 		status = "disabled";
 
-		i2c1_isp: i2c-isp@12140000 {
+		i2c1_isp: i2c-isp@940000 {
 			compatible = "samsung,exynos4212-i2c-isp";
-			reg = <0x12140000 0x100>;
+			reg = <0x00940000 0x100>;
 			clocks = <&isp_clock CLK_ISP_I2C1_ISP>;
 			clock-names = "i2c_isp";
 			#address-cells = <1>;
-- 
2.34.1

