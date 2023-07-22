Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2CA75DC29
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 13:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjGVLzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 07:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjGVLzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 07:55:05 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E875B3586
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 04:54:49 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-316feb137a7so2380629f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 04:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690026888; x=1690631688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XSFvde0MCghYMGJ+cTysg5G2vmHEvabjCrJg5MGa8zU=;
        b=AJ0wW0mfEILVh321hQFNqbf7/MSRnMvsPEoBV/23yswWtY6gfHV77Js/MUkz2pUgZ9
         SOuya4zd+jdxBQ6S9qMnutxMXM0x7xSdCrheVvaNnHfMhKSUcm7ZRK7m0xPcJS7aXJnf
         g5TrwQw89oXuOmRBE1CKYYl4hc+qt+EbnGVONO4X4jwiUtkPtmevXQO7OxiDI3m47wm4
         Ggkz7fYlXwHitlq//b73pg/YYPgKgqeeylcgsIwvkuA7nwByirO/Fef05NbsIB7vD3HH
         Yd6m0D1mdhO1XyyBQVihMIMoGDJcAg7osKFOTEwhcc7Rt6DX9Xzj6aYwiVPW/XpBtYpa
         x0KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690026888; x=1690631688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XSFvde0MCghYMGJ+cTysg5G2vmHEvabjCrJg5MGa8zU=;
        b=WGiNkvzJr9y1qCE50lrcbbHzpNkuMXt+wciS/RGk/wadIbcYBmYtuFq9es7K8MYwcz
         /jpqC7ecMpV3ZDWi1Gy5/vRoC0B2AL8tGVb+YJrYh2f7WcthxxQvG2r2SQGtM0bzft60
         f81Q4m2KKsqTcgcXX76fo8EiGecz8rsMui1hh+PXuIbXOcJfDmfhcmXiKO0vTS5fvNcq
         2balm9s3qO2bLmJaPQNr+PoU2je4P1EMSlhrpkGKuamr+0cx+orYKbUv/k4KIu+p8u2V
         pxAKFHTtq7yISb8FSH6BPhbe6tIi0NiANNdYQ2y1SrAqRy1vlUe1/uUv3hAGHt9l6MaU
         yF/g==
X-Gm-Message-State: ABy/qLazLZlYiz68ozEJjCaG6wTSvxq1QA6fNMPOYrV+tgxMl8ORkTiM
        CnAWpJ5yHyb+ucPtEcKi0lJyMQ==
X-Google-Smtp-Source: APBJJlF0yz9uTMrzF4wv7INQUV+nxRdzqO+OAi0W/JQtvnrWjafHc+cNBgjgrQ9tygnsAonn9T5KRw==
X-Received: by 2002:adf:f592:0:b0:314:13e2:2f6c with SMTP id f18-20020adff592000000b0031413e22f6cmr3604699wro.58.1690026888105;
        Sat, 22 Jul 2023 04:54:48 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id o8-20020adfeac8000000b003143b7449ffsm6726496wrn.25.2023.07.22.04.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jul 2023 04:54:47 -0700 (PDT)
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
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/3] media: dt-bindings: samsung,fimc: correct unit addresses in DTS example
Date:   Sat, 22 Jul 2023 13:54:40 +0200
Message-Id: <20230722115441.139628-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230722115441.139628-1-krzysztof.kozlowski@linaro.org>
References: <20230722115441.139628-1-krzysztof.kozlowski@linaro.org>
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

The camera node's ranges property and unit addresses of its children
were not correct.  If camera is @11800000, then its fimc child is @0.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

