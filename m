Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207FC7519C5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 09:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234281AbjGMHXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 03:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234234AbjGMHWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:22:54 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C8F1BEC
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 00:22:51 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3159da54e95so490462f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 00:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689232969; x=1691824969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9VhVRS/5dxN4m8eKpWEVuk9vUu8h4ihVl/JzGPAbAAs=;
        b=YRtDouko0xvR5DDrRgCV2tJp3+AIdmP0rf1SwCO9ET8Bz7ysdxLMKnmDQ7D+nw6G/W
         oOBm3PkScVXGT7vP7FvtWkIuHcjxhinUP8EanPs2bb53zD17RLbBlDEF8WWwQJEUruN9
         sbSVmsP+wiLSXwt1EimlDWBwJKjCU1aviyLr9mm1abHX756BP6yYotsSYTKJdZPogMcx
         bROgcLMU24V8efnLbIRGXtz28fopYwezvaDyBWpixnr2MlQ4Xf20uRyrimwA4RZn91I5
         ush5E7mUQm2ZtSUIi/uxc0+tUwRCDjtb2CIzHnkzRHGGUlmnRex7kJV/bQ0KDPrG5vcr
         Ps6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689232969; x=1691824969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9VhVRS/5dxN4m8eKpWEVuk9vUu8h4ihVl/JzGPAbAAs=;
        b=k8VY1z+K/yvwZiUgLD4vSr83fzAhRKsDgvordlS7uW7Y2HYM573YMVtXXW0uZx/Oxt
         kh6Qk1Ue6Wlrw4yg8XTsYU6YuyULTtGfy87C4LxeZb8FEiyUTtqTPFlI4d4oUXrylAgh
         fDPIxBJa7LhJtySDhMLaTA7qcm7fas8RMaWBQeIG/cQ0SFwrKwp4qBJsbn97hQij7FQ+
         qCZH+B6pQQexZRAEkjsBfeFo5UcVG9fP1M1utRdD6AKVlePwwsrio2KnaTJcJ0BLQnmD
         SFg92LMWtEEo4wVl9i+ZOa48VQbP1gLOuFXzMqFd/V1+uw4qGneDnFcCEpr0MD4SPeyC
         r0WA==
X-Gm-Message-State: ABy/qLaIX7SsfERqbrPnR1sBsOcRM4sWALqtuc4/YNta/q56RHcKvIC3
        Vs63dfsSdmKwbyFwMFL1XrGyMw==
X-Google-Smtp-Source: APBJJlGXmaGmc6ytTc/C0bMcfckruKjPSCP9a/zag9EMsee880YCKNYTabMsaIQM2YV0vpe29X6Jmg==
X-Received: by 2002:a5d:4d4c:0:b0:314:53a4:42a5 with SMTP id a12-20020a5d4d4c000000b0031453a442a5mr715341wru.51.1689232969501;
        Thu, 13 Jul 2023 00:22:49 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id w16-20020a5d6810000000b003144b50034esm7071384wru.110.2023.07.13.00.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 00:22:48 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [RESEND PATCH v2 1/4] dt-bindings: remoteproc: qcom,pas: correct memory-region constraints
Date:   Thu, 13 Jul 2023 09:22:39 +0200
Message-Id: <20230713072242.11268-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230713072242.11268-1-krzysztof.kozlowski@linaro.org>
References: <20230713072242.11268-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm PAS devices expect exactly one memory region, not many.  Also,
the memory-region is now defined in device specific binding, not in
qcom,pas-common.yaml, thus also require it in the same place.

Fixes: cee616c68846 ("dt-bindings: remoteproc: qcom: adsp: move memory-region and firmware-name out of pas-common")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Following dtbs_check errors are expected (not related):
 - qcom,halt-regs:0: [142] is too short
 - clocks: [[24, 222], [24, 223], [24, 157], [16], [24, 229], [24, 224], [24, 225], [27, 2], [27, 8]] is too short
 - 'px-supply' is a required property
---
 Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml    | 1 +
 .../devicetree/bindings/remoteproc/qcom,pas-common.yaml        | 1 -
 .../devicetree/bindings/remoteproc/qcom,qcs404-pas.yaml        | 3 ++-
 .../devicetree/bindings/remoteproc/qcom,sc7180-pas.yaml        | 3 ++-
 .../devicetree/bindings/remoteproc/qcom,sc8180x-pas.yaml       | 3 ++-
 .../devicetree/bindings/remoteproc/qcom,sc8280xp-pas.yaml      | 3 ++-
 .../devicetree/bindings/remoteproc/qcom,sdx55-pas.yaml         | 3 ++-
 .../devicetree/bindings/remoteproc/qcom,sm6350-pas.yaml        | 3 ++-
 .../devicetree/bindings/remoteproc/qcom,sm8150-pas.yaml        | 3 ++-
 .../devicetree/bindings/remoteproc/qcom,sm8350-pas.yaml        | 3 ++-
 10 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
index 643ee787a81f..b571efe6d550 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
@@ -46,6 +46,7 @@ properties:
 
 required:
   - compatible
+  - memory-region
 
 unevaluatedProperties: false
 
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
index 171ef85de193..63a82e7a8bf8 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
@@ -82,7 +82,6 @@ required:
   - clock-names
   - interrupts
   - interrupt-names
-  - memory-region
   - qcom,smem-states
   - qcom,smem-state-names
 
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,qcs404-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,qcs404-pas.yaml
index 5efa0e5c0439..eb868a7ff4cd 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,qcs404-pas.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,qcs404-pas.yaml
@@ -42,7 +42,7 @@ properties:
   smd-edge: false
 
   memory-region:
-    minItems: 1
+    maxItems: 1
     description: Reference to the reserved-memory for the Hexagon core
 
   firmware-name:
@@ -52,6 +52,7 @@ properties:
 required:
   - compatible
   - reg
+  - memory-region
 
 allOf:
   - $ref: /schemas/remoteproc/qcom,pas-common.yaml#
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-pas.yaml
index 5cefd2c58593..689d5d535331 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-pas.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-pas.yaml
@@ -51,7 +51,7 @@ properties:
       - const: mss
 
   memory-region:
-    minItems: 1
+    maxItems: 1
     description: Reference to the reserved-memory for the Hexagon core
 
   qcom,qmp:
@@ -67,6 +67,7 @@ properties:
 required:
   - compatible
   - reg
+  - memory-region
 
 allOf:
   - $ref: /schemas/remoteproc/qcom,pas-common.yaml#
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sc8180x-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sc8180x-pas.yaml
index c1f8dd8d0e4c..4744a37b2b5d 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sc8180x-pas.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc8180x-pas.yaml
@@ -38,7 +38,7 @@ properties:
   smd-edge: false
 
   memory-region:
-    minItems: 1
+    maxItems: 1
     description: Reference to the reserved-memory for the Hexagon core
 
   firmware-name:
@@ -48,6 +48,7 @@ properties:
 required:
   - compatible
   - reg
+  - memory-region
 
 allOf:
   - $ref: /schemas/remoteproc/qcom,pas-common.yaml#
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sc8280xp-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sc8280xp-pas.yaml
index f6fbc531dc28..96d53baf6e00 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sc8280xp-pas.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc8280xp-pas.yaml
@@ -38,7 +38,7 @@ properties:
   smd-edge: false
 
   memory-region:
-    minItems: 1
+    maxItems: 1
     description: Reference to the reserved-memory for the Hexagon core
 
   firmware-name:
@@ -48,6 +48,7 @@ properties:
 required:
   - compatible
   - reg
+  - memory-region
 
 allOf:
   - $ref: /schemas/remoteproc/qcom,pas-common.yaml#
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sdx55-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sdx55-pas.yaml
index c66e298462c7..5d463272165f 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sdx55-pas.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sdx55-pas.yaml
@@ -46,7 +46,7 @@ properties:
       - const: mss
 
   memory-region:
-    minItems: 1
+    maxItems: 1
     description: Reference to the reserved-memory for the Hexagon core
 
   qcom,qmp:
@@ -62,6 +62,7 @@ properties:
 required:
   - compatible
   - reg
+  - memory-region
 
 allOf:
   - $ref: /schemas/remoteproc/qcom,pas-common.yaml#
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sm6350-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sm6350-pas.yaml
index fee02fa800b5..f7e40fb166da 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sm6350-pas.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm6350-pas.yaml
@@ -36,7 +36,7 @@ properties:
     description: Reference to the AOSS side-channel message RAM.
 
   memory-region:
-    minItems: 1
+    maxItems: 1
     description: Reference to the reserved-memory for the Hexagon core
 
   smd-edge: false
@@ -48,6 +48,7 @@ properties:
 required:
   - compatible
   - reg
+  - memory-region
 
 allOf:
   - $ref: /schemas/remoteproc/qcom,pas-common.yaml#
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sm8150-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sm8150-pas.yaml
index 2c085ac2c3fb..238c6e5e67c5 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sm8150-pas.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm8150-pas.yaml
@@ -40,7 +40,7 @@ properties:
     description: Reference to the AOSS side-channel message RAM.
 
   memory-region:
-    minItems: 1
+    maxItems: 1
     description: Reference to the reserved-memory for the Hexagon core
 
   smd-edge: false
@@ -52,6 +52,7 @@ properties:
 required:
   - compatible
   - reg
+  - memory-region
 
 allOf:
   - $ref: /schemas/remoteproc/qcom,pas-common.yaml#
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sm8350-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sm8350-pas.yaml
index af24f9a3cdf1..4394dfd2d8e6 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sm8350-pas.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm8350-pas.yaml
@@ -43,7 +43,7 @@ properties:
   smd-edge: false
 
   memory-region:
-    minItems: 1
+    maxItems: 1
     description: Reference to the reserved-memory for the Hexagon core
 
   firmware-name:
@@ -53,6 +53,7 @@ properties:
 required:
   - compatible
   - reg
+  - memory-region
 
 allOf:
   - $ref: /schemas/remoteproc/qcom,pas-common.yaml#
-- 
2.34.1

