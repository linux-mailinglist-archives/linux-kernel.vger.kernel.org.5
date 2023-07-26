Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 621E2762C04
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 08:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjGZG4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 02:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbjGZG4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 02:56:43 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B182269E
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 23:56:39 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99454855de1so927207966b.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 23:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690354598; x=1690959398;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VE6+jh1jGUDgaLwcXDZ0os/y7GlAJU39aNPtfSV+1yo=;
        b=DHBj1FEjGaYp/Unf+8NglucgrXB+rymFE9M8XTUjKySAEXgskGmsYryeSW+0pX7xxo
         cwHUnIV+5Q5pduXUYSwiDJJ1UeaUI4BhbtU/ALRTZhEtR5DaiCSQtYwYBhAP4XQ3dDHG
         azu8QhudxkXwielBX7Rh4/pNjww2wONds1p4UZX3s5fb04gpjMfE2WPhZ2xRdKBr3G5d
         wLSY/WC0/XSDFp84bmd9/fP4ufx2iW+gcIkMXZOlfcQXPZ9W001Yp4clXdyCB2K9CPSn
         Fpf+gsIoyyi5TUWxDGT00frL3t6i2ilfX5aD2g6WLwQ34py7Imv8bpqyOHVR6NaVeHN1
         8w1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690354598; x=1690959398;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VE6+jh1jGUDgaLwcXDZ0os/y7GlAJU39aNPtfSV+1yo=;
        b=Gbjrn6T0qnRtiC5iawm66vRjzFDkRKYz6q7SBo48gSs0Q4HJOpjDzOBp/6nGCPWlJB
         6G1O6AHbi0+zVtrqh6gfV8IUKWfabmpfH1jDwZbiD49/gZTx9bHQJvq7S9MyZDCLCQk1
         132B8Y/3EcYB7/RsZWujOT6CpYhiGNMrwA+Tpt2EQ9LvIk2RQfSzrNjq3bKl4r8LVYr9
         LS/B0Bn162bO6V9Vb+QrxmXuJtnXMwFqvOChizmjI7ctl3+fWhZYVJhEjdkuEq9uToVb
         8l5VRXLooM/o/gVoYYIO/SkskGd5FDaqGzvxRacQZxnfq9P/fO1l+fO8Yz/Z1DM6FC00
         wH8g==
X-Gm-Message-State: ABy/qLYlhHVFEDrR5rY21In5IDaFYrDL+H4ZrdkEuaBRstc8jKurNWeO
        LIi18bP+saQ6Ox+xpHzGY9wCYw==
X-Google-Smtp-Source: APBJJlGNYjvyE/hElqZcn3uKrdmqb/bxloAZSpyKBbz0w5XL2KjMYRDbrdc51M+UVn8A0j71TIFfOA==
X-Received: by 2002:a17:906:74d8:b0:993:ffcb:ad4e with SMTP id z24-20020a17090674d800b00993ffcbad4emr982634ejl.13.1690354597852;
        Tue, 25 Jul 2023 23:56:37 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id gs18-20020a170906f19200b00993150e5325sm9178420ejb.60.2023.07.25.23.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 23:56:37 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        pascal Paillet <p.paillet@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/2] dt-bindings: mfd: st,stpmic1: Merge patterns for nodes
Date:   Wed, 26 Jul 2023 08:56:32 +0200
Message-Id: <20230726065633.74924-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Properties should be described only once, thus having separate pattern
for children just to specify the $ref to regulator.yaml is not correct.
It also makes impossible to finish it with
additional/unevaluatedProperties:false to restrict allowed properties in
regulator node.

Merge the patterns, so each regulator subnode has regulator.yaml $ref,
additional properties and ends with additionalProperties:false.  This
points to missing regulator-min/max-microvolt in LDO4 node.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v3:
1. Add regulator-min/max-microvolt in ldo4

Changes in v2:
1. Merge the entries instead of duplicating regulator properties.
---
 .../devicetree/bindings/mfd/st,stpmic1.yaml          | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml b/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml
index 97c61097f9e2..b17ebeb0a42f 100644
--- a/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml
+++ b/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml
@@ -106,6 +106,7 @@ properties:
         const: st,stpmic1-regulators
 
       ldo3:
+        $ref: /schemas/regulator/regulator.yaml
         type: object
 
         properties:
@@ -128,6 +129,7 @@ properties:
         additionalProperties: false
 
       ldo4:
+        $ref: /schemas/regulator/regulator.yaml
         type: object
 
         properties:
@@ -142,11 +144,14 @@ properties:
           regulator-name: true
           regulator-boot-on: true
           regulator-always-on: true
+          regulator-min-microvolt: true
+          regulator-max-microvolt: true
           regulator-over-current-protection: true
 
         additionalProperties: false
 
       vref_ddr:
+        $ref: /schemas/regulator/regulator.yaml
         type: object
 
         properties:
@@ -165,6 +170,7 @@ properties:
         additionalProperties: false
 
       boost:
+        $ref: /schemas/regulator/regulator.yaml
         type: object
 
         properties:
@@ -187,10 +193,8 @@ properties:
       "^(buck[1-4]|ldo[1-6]|vref_ddr|boost|pwr_sw[1-2])-supply$":
         description: STPMIC1 voltage regulators supplies
 
-      "^(buck[1-4]|ldo[1-6]|boost|vref_ddr|pwr_sw[1-2])$":
-        $ref: ../regulator/regulator.yaml
-
       "^ldo[1-2,5-6]$":
+        $ref: /schemas/regulator/regulator.yaml
         type: object
 
         properties:
@@ -213,6 +217,7 @@ properties:
         additionalProperties: false
 
       "^buck[1-4]$":
+        $ref: /schemas/regulator/regulator.yaml
         type: object
 
         properties:
@@ -237,6 +242,7 @@ properties:
         additionalProperties: false
 
       "^pwr_sw[1-2]$":
+        $ref: /schemas/regulator/regulator.yaml
         type: object
 
         properties:
-- 
2.34.1

