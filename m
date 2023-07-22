Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23DB975DC72
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 14:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjGVMRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 08:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbjGVMR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 08:17:28 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1EFE7D
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 05:17:25 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-31297125334so1706707f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 05:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690028244; x=1690633044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fzCCL/QHPaw4sOON9/9YW1a3AVPo9H/0EcWqe0BqQA4=;
        b=KcjAsxLDRfcWfgJAPvAYKOKLTmabjVf+76yuJ/5PFqX/RyyjyK25AkOObuZXuf70ZX
         E0AH66ROiDsl6quRTmowUWN2jnV2f0jdnne7uDJhFz93/MONZkj1kWbyhPgiGYj6k2K7
         i7xQ7KnbmcWg/G5Uf5+fsXFSfJ8IRg5iLfamhcg0kWIyUagVCcc6MCqKhMS5in9J5Jdv
         b3zTmr9hphV9r2JeljT6GQzC6KN5gmZ083blbEKLGq0hLZJGRjzj9gDTQwEIWfwmfnfh
         nfhB2iGVxuDy4/BYe+EArDVHrN8hoRP0315lqQEYaJsl0sD9NrKMk5lgUJ9T/rQ4M2Ca
         xRAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690028244; x=1690633044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fzCCL/QHPaw4sOON9/9YW1a3AVPo9H/0EcWqe0BqQA4=;
        b=RLxo3ANbCF32NP5Z8nkKxFIRvUQVqcxIo2DWTuu8KK3by3JaJ/NHcGxKJvGZNcVCkQ
         bYCn3ZPV6/0f6A6betN+hpFqwgiPXR9YRot0ubxTnxfnzs3aIpHHvRk9C8MuPVRIXxKp
         pmyj0V+3VNIAqRYWsrKve6i3z3l36KDvYwqpeX+Xf7M9ZNfyizV9wD5dHRSmdKPodxFd
         8ZsZkiggvN7dHhYH6Gj4I1zAbQUGMT1GNtd6BSkn1gVBtcGa1IutJXPby2pHcyk4gHeZ
         USQsjiCvNDQ2kFNKp3nUeQBsMxS/ugChpZ5dEMirgCa8DLyOOviRL98NJyGKlx8JLe2A
         vnFA==
X-Gm-Message-State: ABy/qLZ07ju6HBwD+yBjn5jQXcokVaGfGUJ5fUYTH/uhoE3eGUyVMkTH
        nOzxCsHcBfN4l9AzS3yTDBiBiA==
X-Google-Smtp-Source: APBJJlE0oYBDjM5Cil2kn3Gv/9mr3DAcy/Hpm62UVFiU8/J3IduWYs4QO3sawNZpr3DZE4lOHtlncw==
X-Received: by 2002:adf:eb03:0:b0:314:1228:c4c1 with SMTP id s3-20020adfeb03000000b003141228c4c1mr3805261wrn.23.1690028244127;
        Sat, 22 Jul 2023 05:17:24 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id h18-20020a5d5492000000b003142e438e8csm6779086wrv.26.2023.07.22.05.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jul 2023 05:17:23 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 2/3] ARM: dts: samsung: exynos4: fix camera unit addresses/ranges
Date:   Sat, 22 Jul 2023 14:17:18 +0200
Message-Id: <20230722121719.150094-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230722121719.150094-1-krzysztof.kozlowski@linaro.org>
References: <20230722121719.150094-1-krzysztof.kozlowski@linaro.org>
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

The camera node has both unit address and children within the same bus
mapping, thus needs proper ranges property to fix dtc W=1 warnings:

  Warning (unit_address_vs_reg): /soc/camera@11800000: node has a unit name, but no reg or ranges property
  Warning (simple_bus_reg): /soc/camera@11800000: missing or empty reg/ranges property

Subtract 0x11800000 from all its children nodes.  No functional impact
expected.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Move ranges after compatible
---
 arch/arm/boot/dts/samsung/exynos4.dtsi    | 26 +++++++++++------------
 arch/arm/boot/dts/samsung/exynos4x12.dtsi | 17 ++++++++-------
 2 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/arch/arm/boot/dts/samsung/exynos4.dtsi b/arch/arm/boot/dts/samsung/exynos4.dtsi
index f775b9377a38..7f981b5c0d64 100644
--- a/arch/arm/boot/dts/samsung/exynos4.dtsi
+++ b/arch/arm/boot/dts/samsung/exynos4.dtsi
@@ -203,16 +203,16 @@ dsi_0: dsi@11c80000 {
 
 		camera: camera@11800000 {
 			compatible = "samsung,fimc";
+			ranges = <0x0 0x11800000 0xa0000>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			#clock-cells = <1>;
 			clock-output-names = "cam_a_clkout", "cam_b_clkout";
-			ranges;
 
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

