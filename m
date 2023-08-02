Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129A076CA0D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 11:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234204AbjHBJ6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 05:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233809AbjHBJ6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 05:58:13 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15271E64
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 02:58:09 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6871923041fso760101b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 02:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quanta-corp-partner-google-com.20221208.gappssmtp.com; s=20221208; t=1690970288; x=1691575088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cjkPYhWVu4F4RI0ztkLP0H8g77PDU6mQ50uygT3LeOM=;
        b=OjygBGI4eSe3dJCrJam/mXrtVueXhbSlH6TQrMxomOEahjLN2qXieHUtZ0wsAmh/xL
         Y1YetkLAPQ150hVonlX2Bv4AcfbkTJ4opzWbfaZmF8expNZz1xkWwh9jaudOqd8zUjC+
         tMxGEkUyH06ShvLIKDiPLeENMz6OUyEBSaWHDfWOzPZwgtEVL0MytgwPdz08Axoa5m+s
         FdCVGQmmWM4D4/V/vvAO7VWMFQBt7aswTevDh33+JR0P3+OWpeAD7eyQ1xacLVyIHS6R
         We/bICUA9YTZ3BatAXnC4DljyeAHnsfXLb/5ul5KUyV1N6ck4lXgW6mINwABaT+odPC3
         bQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690970288; x=1691575088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cjkPYhWVu4F4RI0ztkLP0H8g77PDU6mQ50uygT3LeOM=;
        b=V3expJN1N0UrqR7dJPaG/h9a3Fv3yuebX55KDnDkArEEKRPUJxbfhX+DbWgZtJ3YoK
         bvejvfNEBtMD8c1/fG6K9ENYANkYCZD2i+4nCYn3SZoIqRehAoGPSYZl5P6IwGhiiOFS
         l+y1EIjYHFVaPuwjH75nMNvhPfTx3p0nuD0Vgz2zzo+rVO1mvCmVUPUE2gRfE8F382eu
         TWzgxbHehX9ArpXyOaziUE53eHhWQ3vRUkBuRWkPI6diWhyvYDMm278yRuBHCSu3XBOd
         i2UdSP/9GNvPtg7dDTnM7WkhBiszii2b9IXKnfgWaEGn1sL9bn7eLut4XwGz5+cfvyhR
         tgog==
X-Gm-Message-State: ABy/qLb4TSZfxJJNa8Gk80qlZkrmxiXxTkgJ9u542G+CPs9fmslJopLq
        odhHO1sfzJgFPUW0LrAnEU7qNBDuAj6Ha8X+4GYo0A==
X-Google-Smtp-Source: APBJJlETqe7KoKOGs9ZfBjrTtqJvbZbTOuPj/mOXQ0UACs7MlfobPK+KIKVpWETldR3I2p0/Xcegaw==
X-Received: by 2002:a05:6a00:2312:b0:67f:ff0a:1bbb with SMTP id h18-20020a056a00231200b0067fff0a1bbbmr14817414pfh.1.1690970288309;
        Wed, 02 Aug 2023 02:58:08 -0700 (PDT)
Received: from liang-Predator-PH517-52.. (60-250-232-247.hinet-ip.hinet.net. [60.250.232.247])
        by smtp.gmail.com with ESMTPSA id m11-20020aa7900b000000b00686f048bb9dsm10742544pfo.74.2023.08.02.02.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 02:58:07 -0700 (PDT)
From:   Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     dianders@chromium.org,
        Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: arm: qcom: add sc7180-lazor board bindings
Date:   Wed,  2 Aug 2023 17:57:51 +0800
Message-Id: <20230802175628.1.I7a950de49ec24b957e90d7fe7abd5f2f5f2e24c3@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230802095753.13644-1-sheng-liang.pan@quanta.corp-partner.google.com>
References: <20230802095753.13644-1-sheng-liang.pan@quanta.corp-partner.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce more sc7180-lazor sku and board version configuration,
add no-eSIM SKU 10 for Lazor, no-eSIM SKU 15 and 18 for Limozeen,
add new board version 10 for audio codec ALC5682i-VS.

Signed-off-by: Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
---

 .../devicetree/bindings/arm/qcom.yaml         | 43 ++++++++++++++++---
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 450f616774e0..e0efc80a72e1 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -460,7 +460,7 @@ properties:
           - const: google,lazor-rev2
           - const: qcom,sc7180
 
-      - description: Acer Chromebook Spin 513 (rev3 - 8)
+      - description: Acer Chromebook Spin 513 (rev3 - 9)
         items:
           - const: google,lazor-rev3
           - const: google,lazor-rev4
@@ -468,6 +468,7 @@ properties:
           - const: google,lazor-rev6
           - const: google,lazor-rev7
           - const: google,lazor-rev8
+          - const: google,lazor-rev9
           - const: qcom,sc7180
 
       - description: Acer Chromebook Spin 513 (newest rev)
@@ -481,7 +482,7 @@ properties:
           - const: google,lazor-rev2-sku2
           - const: qcom,sc7180
 
-      - description: Acer Chromebook Spin 513 with KB Backlight (rev3 - 8)
+      - description: Acer Chromebook Spin 513 with KB Backlight (rev3 - 9)
         items:
           - const: google,lazor-rev3-sku2
           - const: google,lazor-rev4-sku2
@@ -489,6 +490,7 @@ properties:
           - const: google,lazor-rev6-sku2
           - const: google,lazor-rev7-sku2
           - const: google,lazor-rev8-sku2
+          - const: google,lazor-rev9-sku2
           - const: qcom,sc7180
 
       - description: Acer Chromebook Spin 513 with KB Backlight (newest rev)
@@ -502,7 +504,7 @@ properties:
           - const: google,lazor-rev2-sku0
           - const: qcom,sc7180
 
-      - description: Acer Chromebook Spin 513 with LTE (rev3 - 8)
+      - description: Acer Chromebook Spin 513 with LTE (rev3 - 9)
         items:
           - const: google,lazor-rev3-sku0
           - const: google,lazor-rev4-sku0
@@ -510,6 +512,7 @@ properties:
           - const: google,lazor-rev6-sku0
           - const: google,lazor-rev7-sku0
           - const: google,lazor-rev8-sku0
+          - const: google,lazor-rev9-sku0
           - const: qcom,sc7180
 
       - description: Acer Chromebook Spin 513 with LTE (newest rev)
@@ -517,13 +520,24 @@ properties:
           - const: google,lazor-sku0
           - const: qcom,sc7180
 
-      - description: Acer Chromebook 511 (rev4 - rev8)
+      - description: Acer Chromebook Spin 513 with LTE no-esim (rev9)
+        items:
+          - const: google,lazor-rev9-sku10
+          - const: qcom,sc7180
+
+      - description: Acer Chromebook Spin 513 with LTE no-esim (newest rev)
+        items:
+          - const: google,lazor-sku10
+          - const: qcom,sc7180
+
+      - description: Acer Chromebook 511 (rev4 - rev9)
         items:
           - const: google,lazor-rev4-sku4
           - const: google,lazor-rev5-sku4
           - const: google,lazor-rev6-sku4
           - const: google,lazor-rev7-sku4
           - const: google,lazor-rev8-sku4
+          - const: google,lazor-rev9-sku4
           - const: qcom,sc7180
 
       - description: Acer Chromebook 511 (newest rev)
@@ -536,13 +550,14 @@ properties:
           - const: google,lazor-rev4-sku5
           - const: qcom,sc7180
 
-      - description: Acer Chromebook 511 without Touchscreen (rev5 - rev8)
+      - description: Acer Chromebook 511 without Touchscreen (rev5 - rev9)
         items:
           - const: google,lazor-rev5-sku5
           - const: google,lazor-rev5-sku6
           - const: google,lazor-rev6-sku6
           - const: google,lazor-rev7-sku6
           - const: google,lazor-rev8-sku6
+          - const: google,lazor-rev9-sku6
           - const: qcom,sc7180
 
       - description: Acer Chromebook 511 without Touchscreen (newest rev)
@@ -550,6 +565,24 @@ properties:
           - const: google,lazor-sku6
           - const: qcom,sc7180
 
+      - description: Acer Chromebook 511 no-esim (rev9)
+        items:
+          - const: google,lazor-rev9-sku15
+          - const: qcom,sc7180
+
+      - description: Acer Chromebook 511 no-esim(newest rev)
+        items:
+          - const: google,lazor-sku15
+
+      - description: Acer Chromebook 511 without Touchscreen no-esim (rev9)
+        items:
+          - const: google,lazor-rev9-sku18
+          - const: qcom,sc7180
+
+      - description: Acer Chromebook 511 without Touchscreen no-esim(newest rev)
+        items:
+          - const: google,lazor-sku18
+
       - description: Google Mrbland with AUO panel (rev0)
         items:
           - const: google,mrbland-rev0-sku0
-- 
2.34.1

