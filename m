Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261177E9217
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 19:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbjKLSpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 13:45:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjKLSp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 13:45:29 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3E22715
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 10:45:26 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5a7afd45199so44211227b3.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 10:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699814726; x=1700419526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=au8K9WY/iUombJX3p1nFVf4VIUhW2X2Wokmw1tQzis4=;
        b=vBsApbXSF55+Ekkg08U1ZfSni7V0cBDupDRPMLBnVSEZnxAzWo1LmpKf+PzAlV+ALn
         QQ3h8ox7r5l3Ve6O9nNNQnE6xO3/4TpzMK7nfvS21y2Jc8CJ4uCglQCkOC22CE69okVw
         xGyiI6oRL5uWsuAho+lP8mDhoBlQf86AGAVl6/GinluI8NOaBWCmTRpY2mLUgotQmCLe
         XbZ7WbxW565ZrVrISigVU8MQGNyZN1XJNS5D0R2Eb9Nyw3QpUtDnSiniv1OWDlqe+rbh
         +mBdCp+M5Sj2rN1Cdb8/+OFB6mYPwxdc0UVmSbozt+JCLFWHmjFjVPcv7t1qxK1zKwj4
         5u7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699814726; x=1700419526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=au8K9WY/iUombJX3p1nFVf4VIUhW2X2Wokmw1tQzis4=;
        b=rBVWhuvxvK+h7nkC9c7vq9skcYvJlDKt9I0NUPGsFCY+Mu6/r8NrJ70Q0Xr8LFTPCM
         OurqjWnqQ3+0uSh9f24OssQK4+6Nrbqis3joSbgdQYoAVDlXDkevPwmcL0qQSWLG1uQG
         2Z6geprP/vj2axwZYlnQrV4u/yk9NzgsGcTG9XUJvjqteiKHh2M24YsoO1+T1RcSTWRb
         Psr5+zKINz/wRKJvJGWsqmTsM0wmJrhyXnKnlAb2INa+Fag3Jede4oJIrBiQF0Zc5/Kg
         TYXv7FKy8hAe8brjQSBsG3LRRNIbitiH6Vw5comckYfHNPs1l3n1OgTBwhzFPoHwijBI
         s4Fw==
X-Gm-Message-State: AOJu0Yzs2W0P6E323HQj293Yw8nOPKRqcV3Yi5HI6ikFOrAVJaZPepeA
        drJ9imy5lSsT17zRfC5EsdMMLw==
X-Google-Smtp-Source: AGHT+IF2udF2fwlU8PET8WHgbCKxefUzJrVDCjzQhTvpy1I45HhFrhD+hAOgyXZZdHCtBcEhLIyDSA==
X-Received: by 2002:a0d:d781:0:b0:5a7:d9e6:8fc6 with SMTP id z123-20020a0dd781000000b005a7d9e68fc6mr5142491ywd.39.1699814725807;
        Sun, 12 Nov 2023 10:45:25 -0800 (PST)
Received: from krzk-bin.. ([12.161.6.170])
        by smtp.gmail.com with ESMTPSA id u63-20020a0deb42000000b005b3f6c1b5edsm1309473ywe.80.2023.11.12.10.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Nov 2023 10:45:25 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: iommu: arm,smmu: document clocks for the SM8350 GPU SMMU
Date:   Sun, 12 Nov 2023 19:45:22 +0100
Message-Id: <20231112184522.3759-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Document the clocks for Qualcomm SM8350 Adreno GPU SMMU, already used in
DTS:

  sm8350-hdk.dtb: iommu@3da0000: clock-names: False schema does not allow ['bus', 'iface', 'ahb', 'hlos1_vote_gpu_smmu', 'cx_gmu', 'hub_cx_int', 'hub_aon']

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/iommu/arm,smmu.yaml   | 25 ++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 54c333ddf916..14dc54b0e7b3 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -429,6 +429,30 @@ allOf:
             - description: interface clock required to access smmu's registers
                 through the TCU's programming interface.
 
+  - if:
+      properties:
+        compatible:
+          items:
+            - enum:
+                - qcom,sm8350-smmu-500
+            - const: qcom,adreno-smmu
+            - const: qcom,smmu-500
+            - const: arm,mmu-500
+    then:
+      properties:
+        clock-names:
+          items:
+            - const: bus
+            - const: iface
+            - const: ahb
+            - const: hlos1_vote_gpu_smmu
+            - const: cx_gmu
+            - const: hub_cx_int
+            - const: hub_aon
+        clocks:
+          minItems: 7
+          maxItems: 7
+
   - if:
       properties:
         compatible:
@@ -472,7 +496,6 @@ allOf:
               - qcom,sdx65-smmu-500
               - qcom,sm6350-smmu-500
               - qcom,sm6375-smmu-500
-              - qcom,sm8350-smmu-500
               - qcom,sm8450-smmu-500
               - qcom,sm8550-smmu-500
     then:
-- 
2.34.1

