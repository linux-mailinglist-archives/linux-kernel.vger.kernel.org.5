Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A00762EF3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 09:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbjGZH6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 03:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233109AbjGZH6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 03:58:04 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5267A83
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 00:49:46 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-99bc02890c1so77656466b.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 00:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690357784; x=1690962584;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CrsD2ku3FYUSbEYLd18QefccXrMIMs58LNZUmwrbrKY=;
        b=b9Uk0NppRr+rkGY9TslqqUwqX6vqJDpM4jhJBfGUSzLvxZnEIwzaoGwJiYgcmrXew3
         gCGW1ypQiqlOeTUcniQ7x2O13WIZIKaBXdRkayMCqXQ0udjcHpNZ3XaBmPqpSmN4S0YM
         hKxo8LHz06XW+8m/uV8NLI1b9dAc1qCU3LtzpZlJ28Z0CFdnjY2SR1OB6NwLydSPy5hf
         asT2WvruZJU+oECM3PPeZJ5vslpjdz0fSNVjiDWQ8MoCSk8G+PsRRXGJx6onQnUEeH9v
         ZueNevR4DAWbUpalLL3xn5dQqbuSRctg/nqqAUlUx/WJ8qGtW5hLgwR7LS4l1USMIk01
         9aOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690357784; x=1690962584;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CrsD2ku3FYUSbEYLd18QefccXrMIMs58LNZUmwrbrKY=;
        b=aQp1TV7GYbNYMpPXPsOMkRcS7Y4V+0770DTMC8T3pn/+6MPhz7rGRn3V5LhwQS/JPq
         QnJISjQMmGUk8tasu/AAZ0a4wiFWqH7NgU6DxY3gyq1n+7tED6dKzmh0Ma5WFe88RqD6
         n2mtd7ci7HKgdT562s9Fde5qPMMolS0UF7W1dWKfcdtgQZpJOxM/l2HT+3wZJt9UeEsR
         kAO4wjQw7MQxO6k48eCVUb/+3JO75L52Wx+MQvO5gEE/eItoKxmDIpMKvChTuWzrBt/y
         wVtp+qEDaMvFVigLAVdNTuOwN7Lo0iR6rv3ZicZfNI4d+qR39j6SRg5FoQpcqrQWhyp2
         QTEw==
X-Gm-Message-State: ABy/qLa9IFZJonh88wiWQ0WWQUUtRUlWWJOLWfqmRu38Mas8XIk++Bc2
        SMFMgbau1CyzuDJBtdCpDyxb9Q==
X-Google-Smtp-Source: APBJJlE5SEYnQwUx8wsx9vWg+u+oTmQFY4q7UYsSYWFVWyKkbwKNrfwAMB+kXD4rA1nSu4piS0iYgw==
X-Received: by 2002:a17:906:51db:b0:99b:4956:e4e3 with SMTP id v27-20020a17090651db00b0099b4956e4e3mr1032988ejk.8.1690357784438;
        Wed, 26 Jul 2023 00:49:44 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id qh1-20020a170906eca100b0099bc8bd9066sm360455ejb.150.2023.07.26.00.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 00:49:43 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Saravanan Sekar <sravanhome@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Robin Gong <yibin.gong@nxp.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Pascal Paillet <p.paillet@foss.st.com>,
        - <patches@opensource.cirrus.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v2] regulator: dt-bindings: add missing unevaluatedProperties for each regulator
Date:   Wed, 26 Jul 2023 09:49:40 +0200
Message-Id: <20230726074940.121040-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each regulator node, which references common regulator.yaml schema,
should disallow additional or unevaluated properties.  Otherwise
mistakes in properties will go unnoticed.

Reported-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Closes: https://git.codelinaro.org/linaro/qcomlt/kernel/-/commit/1c8aeef8a6e84520b77f0c270d99c8bf692c5933
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Changes in v2:
1. Rebase, drop patches from work-in-progress branch
---
 Documentation/devicetree/bindings/regulator/mps,mp5416.yaml   | 2 ++
 Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml  | 2 ++
 Documentation/devicetree/bindings/regulator/pfuze100.yaml     | 4 ++++
 .../devicetree/bindings/regulator/qcom,rpmh-regulator.yaml    | 2 ++
 .../devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml | 1 +
 .../bindings/regulator/richtek,rt4831-regulator.yaml          | 1 +
 .../bindings/regulator/richtek,rtmv20-regulator.yaml          | 1 +
 .../bindings/regulator/richtek,rtq6752-regulator.yaml         | 1 +
 .../devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml    | 2 +-
 Documentation/devicetree/bindings/regulator/wlf,arizona.yaml  | 2 ++
 10 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/regulator/mps,mp5416.yaml b/Documentation/devicetree/bindings/regulator/mps,mp5416.yaml
index 2e720d152890..0221397eb51e 100644
--- a/Documentation/devicetree/bindings/regulator/mps,mp5416.yaml
+++ b/Documentation/devicetree/bindings/regulator/mps,mp5416.yaml
@@ -29,10 +29,12 @@ properties:
     patternProperties:
       "^buck[1-4]$":
         $ref: regulator.yaml#
+        unevaluatedProperties: false
         type: object
 
       "^ldo[1-4]$":
         $ref: regulator.yaml#
+        unevaluatedProperties: false
         type: object
 
     additionalProperties: false
diff --git a/Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml b/Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml
index 019c60942efc..6de5b027f990 100644
--- a/Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml
+++ b/Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml
@@ -38,11 +38,13 @@ properties:
       ldortc:
         type: object
         $ref: regulator.yaml#
+        unevaluatedProperties: false
 
     patternProperties:
       "^ldo[1-4]$":
         type: object
         $ref: regulator.yaml#
+        unevaluatedProperties: false
 
       "^buck[1-4]$":
         type: object
diff --git a/Documentation/devicetree/bindings/regulator/pfuze100.yaml b/Documentation/devicetree/bindings/regulator/pfuze100.yaml
index e384e4953f0a..0eda44752cdd 100644
--- a/Documentation/devicetree/bindings/regulator/pfuze100.yaml
+++ b/Documentation/devicetree/bindings/regulator/pfuze100.yaml
@@ -68,18 +68,22 @@ properties:
       "^sw([1-4]|[1-4][a-c]|[1-4][a-c][a-c])$":
         $ref: regulator.yaml#
         type: object
+        unevaluatedProperties: false
 
       "^vgen[1-6]$":
         $ref: regulator.yaml#
         type: object
+        unevaluatedProperties: false
 
       "^vldo[1-4]$":
         $ref: regulator.yaml#
         type: object
+        unevaluatedProperties: false
 
       "^(vsnvs|vref|vrefddr|swbst|coin|v33|vccsd)$":
         $ref: regulator.yaml#
         type: object
+        unevaluatedProperties: false
 
     additionalProperties: false
 
diff --git a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
index 72b533c3761a..e758093365bc 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
@@ -111,6 +111,7 @@ properties:
   bob:
     type: object
     $ref: regulator.yaml#
+    unevaluatedProperties: false
     description: BOB regulator node.
     dependencies:
       regulator-allow-set-load: [ regulator-allowed-modes ]
@@ -119,6 +120,7 @@ patternProperties:
   "^(smps|ldo|lvs|bob)[0-9]+$":
     type: object
     $ref: regulator.yaml#
+    unevaluatedProperties: false
     description: smps/ldo regulator nodes(s).
     dependencies:
       regulator-allow-set-load: [ regulator-allowed-modes ]
diff --git a/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml
index a8ca8e0b27f8..9ea8ac0786ac 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml
@@ -110,6 +110,7 @@ patternProperties:
   "^((s|l|lvs|5vs)[0-9]*)|(boost-bypass)|(bob)$":
     description: List of regulators and its properties
     $ref: regulator.yaml#
+    unevaluatedProperties: false
 
 additionalProperties: false
 
diff --git a/Documentation/devicetree/bindings/regulator/richtek,rt4831-regulator.yaml b/Documentation/devicetree/bindings/regulator/richtek,rt4831-regulator.yaml
index d9c23333e157..cd06e957b9db 100644
--- a/Documentation/devicetree/bindings/regulator/richtek,rt4831-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/richtek,rt4831-regulator.yaml
@@ -29,6 +29,7 @@ patternProperties:
   "^DSV(LCM|P|N)$":
     type: object
     $ref: regulator.yaml#
+    unevaluatedProperties: false
     description:
       Properties for single Display Bias Voltage regulator.
 
diff --git a/Documentation/devicetree/bindings/regulator/richtek,rtmv20-regulator.yaml b/Documentation/devicetree/bindings/regulator/richtek,rtmv20-regulator.yaml
index 446ec5127d1f..fec3d396ca50 100644
--- a/Documentation/devicetree/bindings/regulator/richtek,rtmv20-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/richtek,rtmv20-regulator.yaml
@@ -121,6 +121,7 @@ properties:
     description: load switch current regulator description.
     type: object
     $ref: regulator.yaml#
+    unevaluatedProperties: false
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/regulator/richtek,rtq6752-regulator.yaml b/Documentation/devicetree/bindings/regulator/richtek,rtq6752-regulator.yaml
index e6e5a9a7d940..ef62c618de67 100644
--- a/Documentation/devicetree/bindings/regulator/richtek,rtq6752-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/richtek,rtq6752-regulator.yaml
@@ -35,6 +35,7 @@ properties:
       "^(p|n)avdd$":
         type: object
         $ref: regulator.yaml#
+        unevaluatedProperties: false
         description: |
           regulator description for pavdd and navdd.
 
diff --git a/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml b/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml
index 7d53cfa2c288..c9586d277f41 100644
--- a/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml
+++ b/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml
@@ -25,8 +25,8 @@ properties:
 patternProperties:
   "^(reg11|reg18|usb33)$":
     type: object
-
     $ref: regulator.yaml#
+    unevaluatedProperties: false
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/regulator/wlf,arizona.yaml b/Documentation/devicetree/bindings/regulator/wlf,arizona.yaml
index 011819c10988..11e378648b3f 100644
--- a/Documentation/devicetree/bindings/regulator/wlf,arizona.yaml
+++ b/Documentation/devicetree/bindings/regulator/wlf,arizona.yaml
@@ -29,11 +29,13 @@ properties:
       Initial data for the LDO1 regulator.
     $ref: regulator.yaml#
     type: object
+    unevaluatedProperties: false
 
   micvdd:
     description:
       Initial data for the MICVDD regulator.
     $ref: regulator.yaml#
     type: object
+    unevaluatedProperties: false
 
 additionalProperties: true
-- 
2.34.1

