Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B977E9211
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 19:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbjKLSoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 13:44:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjKLSoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 13:44:15 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9E52715
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 10:44:12 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5a82f176860so43129807b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 10:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699814651; x=1700419451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=URm3aBGEZMYGVmdKlbcPoF6bMYnpimYDfI0RPBYPF7w=;
        b=WMc4lO62eNuSZz7H0clD9HSE76T1Z3yTuGe4NrquHhf7/s8MOesgtzwkYFGXb27574
         aMW3Ty1grYzNewu2HemsomxnefE/yYswPZyf0P63dDRRiNl6UZEMW36cInOBEiV6UBG1
         6D1btRMp54zFyPiTX5T0BRMS+gDUrbKKQ6pE93SDoiCkhCL1cKU0psn3jdiTbDMvcuh4
         VJhDU6Qgn5QwXL/+PGX/kkZV++0u0h8JJSmxXTUpU9adKrMKRrErncW7OLW5FmxD5Aax
         smlojtHBdxXQFHu7LNLAkeaRJgyqO/FTyAgCbY3AOfwJXGYtZtmYixZkozaFmev6z5Sv
         Yvqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699814651; x=1700419451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=URm3aBGEZMYGVmdKlbcPoF6bMYnpimYDfI0RPBYPF7w=;
        b=f9UDKJ7wMVobGPILaSPQBnNE+hDlSnqk3CwsplFNGjeSBzuQfaFffU11yxhoWfxETP
         ZdHMNClYUrqvUBXJotH/lVPTzSz/KNDcry1mebtkrjONPDiDXyN+nbDR0Nk9/vw1nESi
         gvdelu1/wgcErydxTDEEVEjyju2ogRGd8X0noAT+9SkLqJ9e5GIyZHh/kE6aB+jV6pYS
         7lL8y7Y/BXf1n7skP17+awxQH9SE1+r/Egezo4BFXuXnRsQA2y5tRXVsdmia9MCZ6KV9
         ikUqLWawYZYuXPconACoz4+2V8KakjmF5LT7HF92o76r+tLlmczHuA6b/iXd5iD4/Dn/
         MUGw==
X-Gm-Message-State: AOJu0YxsnSWhPU+kC5739+Qe6wnGZfihPif4VL3sKe3en6vEWD2ejdA7
        4dKGKIlcDuIoLzZJT1hsLdU5FA==
X-Google-Smtp-Source: AGHT+IEMgeqW+UHzIGW9S0MzgXOGTEehvymLNXsNHGrBqS79/kki9bEegn1CH2pjln/EBoRJFDgiAQ==
X-Received: by 2002:a81:8704:0:b0:59f:519e:3e9a with SMTP id x4-20020a818704000000b0059f519e3e9amr6022964ywf.20.1699814651559;
        Sun, 12 Nov 2023 10:44:11 -0800 (PST)
Received: from krzk-bin.. ([12.161.6.170])
        by smtp.gmail.com with ESMTPSA id u63-20020a0deb42000000b005b3f6c1b5edsm1308938ywe.80.2023.11.12.10.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Nov 2023 10:44:11 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Inki Dae <inki.dae@samsung.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/5] dt-bindings: gpu: samsung: re-order entries to match coding convention
Date:   Sun, 12 Nov 2023 19:44:00 +0100
Message-Id: <20231112184403.3449-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231112184403.3449-1-krzysztof.kozlowski@linaro.org>
References: <20231112184403.3449-1-krzysztof.kozlowski@linaro.org>
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

The Devicetree bindings coding convention, as used in most of the files
and expressed in Documentation/devicetree/bindings/example-schema.yaml,
expects "allOf:" block with if-statements after "required:" block.

Re-order few schemas to match the convention to avoid repeating review
comments for new patches using existing code as template.  No functional
changes.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/gpu/samsung-g2d.yaml  | 53 +++++++++--------
 .../bindings/gpu/samsung-scaler.yaml          | 59 +++++++++----------
 2 files changed, 56 insertions(+), 56 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpu/samsung-g2d.yaml b/Documentation/devicetree/bindings/gpu/samsung-g2d.yaml
index e7daae862578..b6951acc7643 100644
--- a/Documentation/devicetree/bindings/gpu/samsung-g2d.yaml
+++ b/Documentation/devicetree/bindings/gpu/samsung-g2d.yaml
@@ -27,32 +27,6 @@ properties:
   iommus: {}
   power-domains: {}
 
-if:
-  properties:
-    compatible:
-      contains:
-        const: samsung,exynos5250-g2d
-
-then:
-  properties:
-    clocks:
-      items:
-        - description: fimg2d clock
-    clock-names:
-      items:
-        - const: fimg2d
-
-else:
-  properties:
-    clocks:
-      items:
-        - description: sclk_fimg2d clock
-        - description: fimg2d clock
-    clock-names:
-      items:
-        - const: sclk_fimg2d
-        - const: fimg2d
-
 required:
   - compatible
   - reg
@@ -60,6 +34,33 @@ required:
   - clocks
   - clock-names
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos5250-g2d
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: fimg2d clock
+        clock-names:
+          items:
+            - const: fimg2d
+
+    else:
+      properties:
+        clocks:
+          items:
+            - description: sclk_fimg2d clock
+            - description: fimg2d clock
+        clock-names:
+          items:
+            - const: sclk_fimg2d
+            - const: fimg2d
+
 additionalProperties: false
 
 examples:
diff --git a/Documentation/devicetree/bindings/gpu/samsung-scaler.yaml b/Documentation/devicetree/bindings/gpu/samsung-scaler.yaml
index 5317ac64426a..97d86a002a90 100644
--- a/Documentation/devicetree/bindings/gpu/samsung-scaler.yaml
+++ b/Documentation/devicetree/bindings/gpu/samsung-scaler.yaml
@@ -26,36 +26,6 @@ properties:
   iommus: {}
   power-domains: {}
 
-if:
-  properties:
-    compatible:
-      contains:
-        const: samsung,exynos5420-scaler
-
-then:
-  properties:
-    clocks:
-      items:
-        - description: mscl clock
-
-    clock-names:
-      items:
-        - const: mscl
-
-else:
-  properties:
-    clocks:
-      items:
-        - description: pclk clock
-        - description: aclk clock
-        - description: aclk_xiu clock
-
-    clock-names:
-      items:
-        - const: pclk
-        - const: aclk
-        - const: aclk_xiu
-
 required:
   - compatible
   - reg
@@ -63,6 +33,35 @@ required:
   - clocks
   - clock-names
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos5420-scaler
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: mscl clock
+        clock-names:
+          items:
+            - const: mscl
+
+    else:
+      properties:
+        clocks:
+          items:
+            - description: pclk clock
+            - description: aclk clock
+            - description: aclk_xiu clock
+        clock-names:
+          items:
+            - const: pclk
+            - const: aclk
+            - const: aclk_xiu
+
 additionalProperties: false
 
 examples:
-- 
2.34.1

