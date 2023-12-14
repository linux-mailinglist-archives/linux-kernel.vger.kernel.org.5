Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D684812B29
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 10:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235634AbjLNJLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 04:11:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjLNJLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 04:11:18 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFACA112
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 01:11:24 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-67efd2cde42so3499336d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 01:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702545084; x=1703149884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6IaFDod8qWxr8WQM1D5UKzpQIEJXDdQljMHqbalXZ3w=;
        b=v6GugAjacGMiysiqS+LvRSW+534dEbJV6uHyAugGIE3J4a2fD2qKUvmXi04JZWnclW
         rj376tfm7dAFf8L33GlDdRFkKO8UZ1gZ+MugIppmlLtbfJprQgKUHgfI9W80XZV162Ea
         n+hocNHTpgsM1k+JorocrToecA/7nb4DLTWSkcDqbDMJIKFUhgXUlmXnkUSOv+D/XU0a
         cKxU1p+20cSUQ5jYGZactHgJGhtLlr0fMpKx/m8jB9w0zm62xHnYlJE9YU+DmOrZGsuM
         XNiqqX0eOjGtsf+BB9HWX4+2FS3xn2PtrPGfFqSwahfP410C3iqruHDYXm9lDF1OohE7
         br1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702545084; x=1703149884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6IaFDod8qWxr8WQM1D5UKzpQIEJXDdQljMHqbalXZ3w=;
        b=wXDduGxfhMmfLGSciDS6mnoGgCOoRYNrtRkV5jrPjuzpKpY29BQZPGQTziLhHyC7od
         xxuIis4gPK7+kAKRdDLX1tHpcFW8zQnE0v74t5NwgkbDuYh9IzMxeqgi8OI56r7iclJg
         JKp5PyH/0z7qTUQ+nL0w28m4q/T8auBtCTf0I1ecXUlwsPZ7yPEEfG1u8RDfayk4kPt0
         URAC2Q7gufnrCVbsv/gcdljK7+qE8cfGB5fWw3nhWDqrVFSlFTfQitCrh6K6pzZl0p7M
         WgIfAOvP65uOPo0OyS6tvwr04wCMtcR7MYXVd8KGU3K1mf16/Q8DUv9LhUib1sDhcgOJ
         Y05A==
X-Gm-Message-State: AOJu0Ywv7p424KcJCQAsBo1IbdiZbXKozDAjZgsYDSaWPIXLSi2haSAt
        CRYOjrZPrdONLvB4+eeJ9IYE
X-Google-Smtp-Source: AGHT+IFWS5tXUoDuwKS0Y+S8DpQ1nM36WsP8DhgZT5a4e5se0ymj9dUim0tvEitMjyqjox+W7p/Ugg==
X-Received: by 2002:ad4:5dec:0:b0:67a:568e:5b10 with SMTP id jn12-20020ad45dec000000b0067a568e5b10mr15074701qvb.20.1702545083823;
        Thu, 14 Dec 2023 01:11:23 -0800 (PST)
Received: from localhost.localdomain ([117.213.102.12])
        by smtp.gmail.com with ESMTPSA id qt13-20020a05620a8a0d00b0077d75164ef9sm5144119qkn.124.2023.12.14.01.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 01:11:23 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 01/16] dt-bindings: phy: qmp-ufs: Fix PHY clocks
Date:   Thu, 14 Dec 2023 14:40:46 +0530
Message-Id: <20231214091101.45713-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231214091101.45713-1-manivannan.sadhasivam@linaro.org>
References: <20231214091101.45713-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All QMP UFS PHYs except MSM8996 require 3 clocks:

* ref - 19.2MHz reference clock from RPMh
* ref_aux - Auxiliary reference clock from GCC
* qref - QREF clock from GCC or TCSR (since SM8550)

MSM8996 only requires 'ref' and 'qref' clocks. Hence, fix the binding to
reflect the actual clock topology.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../phy/qcom,sc8280xp-qmp-ufs-phy.yaml        | 47 +++++++++----------
 1 file changed, 21 insertions(+), 26 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
index f3a3296c811c..800f11b29dcd 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
@@ -37,15 +37,12 @@ properties:
     maxItems: 1
 
   clocks:
-    minItems: 1
+    minItems: 2
     maxItems: 3
 
   clock-names:
-    minItems: 1
-    items:
-      - const: ref
-      - const: ref_aux
-      - const: qref
+    minItems: 2
+    maxItems: 3
 
   power-domains:
     maxItems: 1
@@ -85,22 +82,9 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,msm8998-qmp-ufs-phy
               - qcom,sa8775p-qmp-ufs-phy
               - qcom,sc7280-qmp-ufs-phy
-              - qcom,sm8450-qmp-ufs-phy
-    then:
-      properties:
-        clocks:
-          minItems: 3
-        clock-names:
-          minItems: 3
-
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,msm8998-qmp-ufs-phy
               - qcom,sc8180x-qmp-ufs-phy
               - qcom,sc8280xp-qmp-ufs-phy
               - qcom,sdm845-qmp-ufs-phy
@@ -111,13 +95,18 @@ allOf:
               - qcom,sm8150-qmp-ufs-phy
               - qcom,sm8250-qmp-ufs-phy
               - qcom,sm8350-qmp-ufs-phy
+              - qcom,sm8450-qmp-ufs-phy
               - qcom,sm8550-qmp-ufs-phy
     then:
       properties:
         clocks:
-          maxItems: 2
+          minItems: 3
+          maxItems: 3
         clock-names:
-          maxItems: 2
+          items:
+            - const: ref
+            - const: ref_aux
+            - const: qref
 
   - if:
       properties:
@@ -128,22 +117,28 @@ allOf:
     then:
       properties:
         clocks:
-          maxItems: 1
+          minItems: 2
+          maxItems: 2
         clock-names:
-          maxItems: 1
+          items:
+            - const: ref
+            - const: qref
 
 additionalProperties: false
 
 examples:
   - |
     #include <dt-bindings/clock/qcom,gcc-sc8280xp.h>
+    #include <dt-bindings/clock/qcom,rpmh.h>
 
     ufs_mem_phy: phy@1d87000 {
         compatible = "qcom,sc8280xp-qmp-ufs-phy";
         reg = <0x01d87000 0x1000>;
 
-        clocks = <&gcc GCC_UFS_REF_CLKREF_CLK>, <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
-        clock-names = "ref", "ref_aux";
+        clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_UFS_PHY_PHY_AUX_CLK>,
+                 <&gcc GCC_UFS_REF_CLKREF_CLK>;
+
+        clock-names = "ref", "ref_aux", "qref";
 
         power-domains = <&gcc UFS_PHY_GDSC>;
 
-- 
2.25.1

