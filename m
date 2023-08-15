Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B3F77C77F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 08:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234840AbjHOGJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 02:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235068AbjHOGI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 02:08:59 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383F819A3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 23:07:48 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fe27849e6aso7902587e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 23:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692079666; x=1692684466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KVnFJiMRFz78ILhOUZDeG2BsOXYQ6IIoucdYjDSoZck=;
        b=ux9EU2te+pnF27RxeJooc1JFE42D9LgEkZ2ZnZNaRNmMU/MdYm5I/WOjXN5wWc5XJw
         KxiiRwiTeEWBCMn4tCdMZRpoqxR4efsO3S4SUIkpEdE3mzWTcmnjgKjpXPICQeMkEkYv
         RV3yqfbn07fxqkCs6gtgVbG7c4svgBnGAxOe0PaLP4lswOmJh5SHRxIGw2K9oF/qqdw4
         kskGGJ2MDI03gV7dMi/CGWHvS+rvLb61oyzlfTUSQtzR1ZfTTvlbyIpPCwCF2Ip0yw41
         xKzFqxq0dXXKw9TBDlkT0XzEiUiRFrBejBitXo6mT3UameP3IJHKmRdbOT6Ohywv/pnD
         3fHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692079666; x=1692684466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KVnFJiMRFz78ILhOUZDeG2BsOXYQ6IIoucdYjDSoZck=;
        b=PTn61nHUcSJkFg6s0DOUTpdUtP4MhpcAiWVyK+ktBZ8IKH/iv8l7wHol7PCehlR9Vu
         3Bv1xLdgDECBFB0JbE/1yJw95+XtazP6laSnnrkWWou46sH6pYaTNfnyqnBDmG06H3dp
         knifytmV++mBD6/hJ3SDEOpyqs4npxEw9pm9arZefInsOERkmjh6zdWJRAG78TyEp+R9
         pDFP6772ipJ+Iyvz4vT8I23AlBaABk8PRRLwNOU+hoH+VjvNTekMOvyVqLAX/+DXj/7X
         39EtbmN+x+Bl49BEnHPsG9nz1K2l5OUpZNo+zGQbxO+buCkb+CYWPvYTZvqMuUiBG62o
         Is8w==
X-Gm-Message-State: AOJu0YxjcNiBi670fbU0hqL7zZXa4Lz5bocBFCU6jGaC3ZuaLAKe5Sk5
        mAkgkBT4J4Yum/Q5YNIqJk2YQw==
X-Google-Smtp-Source: AGHT+IEU8GZRCKc+uj+gjwiht9Ao/Ja/R6voPLEfx7IHejJ8qPJgWiAfPI7J2oLEh5VRT/2VcidT2w==
X-Received: by 2002:a05:6512:304d:b0:4ff:74e2:4268 with SMTP id b13-20020a056512304d00b004ff74e24268mr5037814lfb.56.1692079666243;
        Mon, 14 Aug 2023 23:07:46 -0700 (PDT)
Received: from krzk-bin.. ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id gw4-20020a170906f14400b00993b381f808sm6528093ejb.38.2023.08.14.23.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 23:07:45 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 2/3] media: dt-bindings: samsung,fimc: correct unit addresses in DTS example
Date:   Tue, 15 Aug 2023 08:07:38 +0200
Message-Id: <20230815060739.30160-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230815060739.30160-1-krzysztof.kozlowski@linaro.org>
References: <20230815060739.30160-1-krzysztof.kozlowski@linaro.org>
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

The camera node's ranges property and unit addresses of its children
were not correct.  If camera is @11800000, then its fimc child is @0.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v3:
1. None

Changes in v2:
1. Add Ab tag.
---
 .../bindings/media/samsung,fimc.yaml          | 22 +++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/samsung,fimc.yaml b/Documentation/devicetree/bindings/media/samsung,fimc.yaml
index 530a08f5d3fe..88b176d594e2 100644
--- a/Documentation/devicetree/bindings/media/samsung,fimc.yaml
+++ b/Documentation/devicetree/bindings/media/samsung,fimc.yaml
@@ -117,7 +117,7 @@ examples:
         #clock-cells = <1>;
         #address-cells = <1>;
         #size-cells = <1>;
-        ranges = <0x0 0x0 0x18000000>;
+        ranges = <0x0 0x0 0xba1000>;
 
         clocks = <&clock CLK_SCLK_CAM0>, <&clock CLK_SCLK_CAM1>,
                  <&clock CLK_PIXELASYNCM0>, <&clock CLK_PIXELASYNCM1>;
@@ -132,9 +132,9 @@ examples:
         pinctrl-0 = <&cam_port_a_clk_active &cam_port_b_clk_active>;
         pinctrl-names = "default";
 
-        fimc@11800000 {
+        fimc@0 {
             compatible = "samsung,exynos4212-fimc";
-            reg = <0x11800000 0x1000>;
+            reg = <0x00000000 0x1000>;
             interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
             clocks = <&clock CLK_FIMC0>,
                      <&clock CLK_SCLK_FIMC0>;
@@ -151,9 +151,9 @@ examples:
 
         /* ... FIMC 1-3 */
 
-        csis@11880000 {
+        csis@80000 {
             compatible = "samsung,exynos4210-csis";
-            reg = <0x11880000 0x4000>;
+            reg = <0x00080000 0x4000>;
             interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
             clocks = <&clock CLK_CSIS0>,
                      <&clock CLK_SCLK_CSIS0>;
@@ -186,9 +186,9 @@ examples:
 
         /* ... CSIS 1 */
 
-        fimc-lite@12390000 {
+        fimc-lite@b90000 {
               compatible = "samsung,exynos4212-fimc-lite";
-              reg = <0x12390000 0x1000>;
+              reg = <0xb90000 0x1000>;
               interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
               power-domains = <&pd_isp>;
               clocks = <&isp_clock CLK_ISP_FIMC_LITE0>;
@@ -198,9 +198,9 @@ examples:
 
         /* ... FIMC-LITE 1 */
 
-        fimc-is@12000000 {
+        fimc-is@800000 {
             compatible = "samsung,exynos4212-fimc-is";
-            reg = <0x12000000 0x260000>;
+            reg = <0x00800000 0x260000>;
             interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>,
                          <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
             clocks = <&isp_clock CLK_ISP_FIMC_LITE0>,
@@ -242,9 +242,9 @@ examples:
             #size-cells = <1>;
             ranges;
 
-            i2c-isp@12140000 {
+            i2c-isp@940000 {
                 compatible = "samsung,exynos4212-i2c-isp";
-                reg = <0x12140000 0x100>;
+                reg = <0x00940000 0x100>;
                 clocks = <&isp_clock CLK_ISP_I2C1_ISP>;
                 clock-names = "i2c_isp";
                 pinctrl-0 = <&fimc_is_i2c1>;
-- 
2.34.1

