Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566AC7C53D8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 14:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbjJKM0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 08:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234838AbjJKM0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 08:26:16 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D7098
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:26:12 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3af957bd7e9so4622012b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697027172; x=1697631972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ajLtfok9CWqCwja1uJsqZOOGL/HNBxULXlTNnK81mjM=;
        b=FAUGLiu8I5xzzmo+/uGIknBc1/UyuEqH1/WopQm8Wj685g/p0wmWDMMk5CKKKFLhkq
         ZTHm59YDVYGka2FQUkYq9WGLsH357nslEHwzjjjYhx9OkZ492zMyHZVAR3r2onZQCFui
         x074uM/n0atlQap8/lM4J2Jry+5id+S1O9hJ12vMrDq8QfAXPH8A6kqG8II0eV3YG55B
         GnOOqaUEOGdVSsvC/EgeaUgvYaHeEg3LwMiybgrxD2vtrmjHYEldhsMnkVDHCnS+gW/Q
         YVfvSkOO/rPlj89BVUevoodDF9bjLW1O2YMuN6qygeEaU969Wq9fMf0V9umIqYqUg1eF
         4lDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697027172; x=1697631972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ajLtfok9CWqCwja1uJsqZOOGL/HNBxULXlTNnK81mjM=;
        b=oXP/ZKA1G9uoMCo294ApR6xf8R6f9Rgb+dtDG3daW+UcAOhBycClezsXSr+aLaDEkk
         ab+Vtzs9jRoXPnBCF73nc6I6+Zkt/P1aSWi63mX3ly1+bK0ZlQF98miuHgNxRRQQu5b9
         s9qU+dypMv+7XlCKr1RVcZKcSzfItaEW+yVrHsBZz6hv5Kb0o6XUvR2eqIeutntQ1FQZ
         Eg3GFYpKkj1eqlm7449p3qeiSjijOQCwiOMXMBAdD4l7dsnULfySTsZotGThOpaOhjhm
         ZChTBUnDQu40ykBQyBcVjKgQ7dQZlq9rB/dlH+PHpwvhhW1neF6jZI/gML0/bk8wY/q3
         E2HA==
X-Gm-Message-State: AOJu0YzZVftry0C5iQcn8NSSYhhovuY5bNRqd11mbq2HZMPF8UT4MIhc
        SRQlvJbYN92CxsGuZinueoHN
X-Google-Smtp-Source: AGHT+IGBhTb9lrUeO8oz/kYG3VT7kbp6AST3wqkX7dtoOpiNSSUjATNnt22wzJ9hL604HZpdoArbeg==
X-Received: by 2002:a05:6358:919a:b0:143:5826:dece with SMTP id j26-20020a056358919a00b001435826decemr21895407rwa.25.1697027171716;
        Wed, 11 Oct 2023 05:26:11 -0700 (PDT)
Received: from localhost.localdomain ([120.138.12.180])
        by smtp.gmail.com with ESMTPSA id a19-20020aa78653000000b0068fb8080939sm9953620pfo.65.2023.10.11.05.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 05:26:11 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        quic_nitirawa@quicinc.com, quic_narepall@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_richardp@quicinc.com,
        quic_nguyenb@quicinc.com, quic_ziqichen@quicinc.com,
        bmasney@redhat.com, krzysztof.kozlowski@linaro.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5 1/5] dt-bindings: ufs: common: add OPP table
Date:   Wed, 11 Oct 2023 17:55:39 +0530
Message-Id: <20231011122543.11922-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231011122543.11922-1-manivannan.sadhasivam@linaro.org>
References: <20231011122543.11922-1-manivannan.sadhasivam@linaro.org>
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

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Except scaling UFS and bus clocks, it's necessary to scale also the
voltages of regulators or power domain performance state levels.  Adding
Operating Performance Points table allows to adjust power domain
performance state, depending on the UFS clock speed.

OPPv2 deprecates previous property limited to clock scaling:
freq-table-hz.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../devicetree/bindings/ufs/ufs-common.yaml   | 35 +++++++++++++++++--
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/ufs/ufs-common.yaml b/Documentation/devicetree/bindings/ufs/ufs-common.yaml
index bbaee4f5f7b2..1cb022cdc349 100644
--- a/Documentation/devicetree/bindings/ufs/ufs-common.yaml
+++ b/Documentation/devicetree/bindings/ufs/ufs-common.yaml
@@ -6,6 +6,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Common properties for Universal Flash Storage (UFS) Host Controllers
 
+
 maintainers:
   - Alim Akhtar <alim.akhtar@samsung.com>
   - Avri Altman <avri.altman@wdc.com>
@@ -20,11 +21,24 @@ properties:
       items:
         - description: Minimum frequency for given clock in Hz
         - description: Maximum frequency for given clock in Hz
+    deprecated: true
     description: |
+      Preferred is operating-points-v2.
+
       Array of <min max> operating frequencies in Hz stored in the same order
-      as the clocks property. If this property is not defined or a value in the
-      array is "0" then it is assumed that the frequency is set by the parent
-      clock or a fixed rate clock source.
+      as the clocks property. If either this property or operating-points-v2 is
+      not defined or a value in the array is "0" then it is assumed that the
+      frequency is set by the parent clock or a fixed rate clock source.
+
+  operating-points-v2:
+    description:
+      Preferred over freq-table-hz.
+      If present, each OPP must contain array of frequencies stored in the same
+      order for each clock.  If clock frequency in the array is "0" then it is
+      assumed that the frequency is set by the parent clock or a fixed rate
+      clock source.
+
+  opp-table: true
 
   interrupts:
     maxItems: 1
@@ -75,8 +89,23 @@ properties:
 
 dependencies:
   freq-table-hz: [ clocks ]
+  operating-points-v2: [ clocks, clock-names ]
 
 required:
   - interrupts
 
+allOf:
+  - if:
+      required:
+        - freq-table-hz
+    then:
+      properties:
+        operating-points-v2: false
+  - if:
+      required:
+        - operating-points-v2
+    then:
+      properties:
+        freq-table-hz: false
+
 additionalProperties: true
-- 
2.25.1

