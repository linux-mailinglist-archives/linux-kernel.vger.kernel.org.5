Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679C7786B69
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 11:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240563AbjHXJSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 05:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240761AbjHXJR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 05:17:59 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6611FC6;
        Thu, 24 Aug 2023 02:17:49 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fbd33a57b6so59599185e9.2;
        Thu, 24 Aug 2023 02:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692868668; x=1693473468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9au0NgNIUJ+sORn6zvleet9pRTpHTjWd9vSOrrCIA8M=;
        b=HMpn4sh0UmvvGC2TuUDDa8JsuVCp+opphYvKxHCWyprwdZlztnxs7taKLFRM5q1Nhw
         9Im1zm9LiyTga1l81vTylM1KAMmvab9TjWHvIK+O443XVwu5adxUGBV7CWOg+kjzPxB7
         MTgMTob5SFWhQQWFc9nnBVVm+knzVjK+k5pmvCO8Lw05B3BVCkvK8Ljf1A99I/czGWve
         AhZcfNibbmWYiRZS5jzpColD63yw8/Df9gETOwIS0nXaSLdL+yvRzjk1xYJjmk/WqyZo
         7Tu+pr6Zihip1NkrlSbsE5L7hc00/WuRKr7aCe6R6haocWD8etc9+7UuV2HJktEbt6tI
         T7qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692868668; x=1693473468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9au0NgNIUJ+sORn6zvleet9pRTpHTjWd9vSOrrCIA8M=;
        b=buQV5wKB9PBfJ0URzwYa9OCbHtnVBjLiCoImQUSXlSM56sWu7Okoas211rRNw9uEbs
         XExX/Cti199pfQ6/Yh0AL6xONMSXPNl9K7Yj6XRVUZzjmZCfQl/erHqoZ5C+XPL9TOcm
         XIwV9Wh8CTx2oSPRwEcqvfrSPNlRaSpFxj579vz1Vn77qhpo2VFwRRr0Jje9cdGdhrHD
         vQSjpuRTS1BxZPX98xh9bvIHGUkBOeGgdEriFw3Bp76mfxOyAlusDYjQ/YUzFxZHAyWl
         5RHjSF+99D93nU6lnOFcaq3ZoErgaXUnI6uVyAhEPIrcG1A7UgI/tEavjqE7ASWX9BHn
         OSvg==
X-Gm-Message-State: AOJu0Yw0l/gnZxCZ2Af+cdFPZPrHsXzdOese6Q8nGUdffPpo5NevLbGQ
        qWlgQxwScJQGFb4+d1A+NbY=
X-Google-Smtp-Source: AGHT+IH4REKKS4UuYIyEhAwgjwOZxhRrkYVachA9ngsJj3EJTsUc/9uz40pNbOtGhooxaYZIB6kCEg==
X-Received: by 2002:a05:600c:21d7:b0:3fe:407c:a053 with SMTP id x23-20020a05600c21d700b003fe407ca053mr11594078wmj.16.1692868667864;
        Thu, 24 Aug 2023 02:17:47 -0700 (PDT)
Received: from david-ryuzu.fritz.box (ip4d167053.dynamic.kabel-deutschland.de. [77.22.112.83])
        by smtp.googlemail.com with ESMTPSA id k8-20020a7bc408000000b003fe23b10fdfsm2022214wmi.36.2023.08.24.02.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 02:17:47 -0700 (PDT)
From:   David Wronek <davidwronek@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        cros-qcom-dts-watchers@chromium.org,
        David Wronek <davidwronek@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 1/4] dt-bindings: arm: qcom: Document SM7125 and xiaomi,joyeuse board
Date:   Thu, 24 Aug 2023 11:15:04 +0200
Message-ID: <20230824091737.75813-2-davidwronek@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824091737.75813-1-davidwronek@gmail.com>
References: <20230824091737.75813-1-davidwronek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the xiaomi,joyeuse board based on the Qualcomm SM7125 SoC.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: David Wronek <davidwronek@gmail.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index adbfaea32343..2ae320099857 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -79,6 +79,7 @@ description: |
         sm6125
         sm6350
         sm6375
+        sm7125
         sm7225
         sm8150
         sm8250
@@ -943,6 +944,11 @@ properties:
               - sony,pdx225
           - const: qcom,sm6375
 
+      - items:
+          - enum:
+              - xiaomi,joyeuse
+          - const: qcom,sm7125
+
       - items:
           - enum:
               - fairphone,fp4
@@ -1086,6 +1092,7 @@ allOf:
               - qcom,sm6115
               - qcom,sm6125
               - qcom,sm6350
+              - qcom,sm7125
               - qcom,sm7225
               - qcom,sm8150
               - qcom,sm8250
-- 
2.42.0

