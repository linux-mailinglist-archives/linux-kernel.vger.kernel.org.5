Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59520772535
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbjHGNNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbjHGNNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:13:09 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20AECA
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:13:03 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-31781e15a0cso3553748f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 06:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691413982; x=1692018782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ucHNhqP919T+93NL2V3Ir/+jeAbz5Mj5YOR6x5XuKY0=;
        b=U8Av5idF1F3qpkb7EOcg5U2a5TWux3EAl06PbO7wRvesI16uQC61IbqFolk6CuYFEs
         2ZdI6e0u4dyGJNIHMoFIWLp3+im66Rajokm69rj68xZIqx1XXybcRH9F2a/Q0mOEHb6M
         1QWiEAFoxhCQzA7XravONhNtcMR0MslGesEcPsGxFzMDAI+jOJWWUQx8E3kqHMcWynh0
         BpOn9f/lao7Dw7kAmulGupF088me1UBK3qIHZDDwwoWpMzdI9L26xSWij0vL/q7FMAtp
         NT6bsRpS/g9Wz2Lz5F957u26fkdAQVqU+gLv9vKzSidVBzNsnLcARGM7GozzG1t3mUiE
         hY8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691413982; x=1692018782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ucHNhqP919T+93NL2V3Ir/+jeAbz5Mj5YOR6x5XuKY0=;
        b=hTB72wsyixSsmbYfUSbN2ofJvm+tCgfo6N777KgzSKxZdLRqK7zNg/PnWYC0Piqn+N
         7chUyTskw6BhTAk+hzzrmL8EyfiNJ1Tph+15FEekyVlEHx15l7Fxd4NT+VfrSgU3q5nJ
         IbG61IQh+Y+6TIvVfkfqEbIV3NQuLOHUx/x4TG8kXWwdwF31DmtXFjQrhxemXfN/Pevc
         ZfBSW7/+g0aovl3F0gp0mokKYv/1/3Pr4dPIMk9tonLoxC0Y4d9Jx6PTTYLH/r0jexsY
         FW5BrJWAIGlDW3iQvC6qWtgQANYQBBvclOdWN1bFxwRXBRXy6kteXme/xPW4IfvvRw8c
         5bkA==
X-Gm-Message-State: AOJu0YwXRf+HqVGbKF84fuEq/bsQkLsLmjZNTLyBnbfvXJsCaMgrNZ7Z
        9q+1qhrz9suB59osw09AEA0ejw==
X-Google-Smtp-Source: AGHT+IGFjbFOL5PhCqFxXyGVveJ5lAB/2KN5DbkDsg4+vOLyTBNw0J8jNreyWKLyYN7zEVvUceOLMA==
X-Received: by 2002:a5d:680e:0:b0:317:4ef8:1659 with SMTP id w14-20020a5d680e000000b003174ef81659mr5210186wru.28.1691413982495;
        Mon, 07 Aug 2023 06:13:02 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id j9-20020a5d4489000000b0031411b7087dsm10618428wrq.20.2023.08.07.06.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 06:13:01 -0700 (PDT)
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
Subject: [PATCH v2 2/3] media: dt-bindings: samsung,fimc: correct unit addresses in DTS example
Date:   Mon,  7 Aug 2023 15:12:55 +0200
Message-Id: <20230807131256.254243-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807131256.254243-1-krzysztof.kozlowski@linaro.org>
References: <20230807131256.254243-1-krzysztof.kozlowski@linaro.org>
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

The camera node's ranges property and unit addresses of its children
were not correct.  If camera is @11800000, then its fimc child is @0.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

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

