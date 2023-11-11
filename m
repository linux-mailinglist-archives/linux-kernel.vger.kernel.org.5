Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919B27E8CB1
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 21:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjKKUte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 15:49:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjKKUta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 15:49:30 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEB72D73
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 12:49:27 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40790b0a224so23886145e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 12:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699735766; x=1700340566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dw1ndMUKXNlOHoymKchXozvXFQJ/Nc6du3K0pUpN4dE=;
        b=Knht1UNnnReKyyOUyIxQYPEiqrYAMZTAS8ABU8k4wryRg2P4WLUuVSYQNs9qCbmClg
         eodUBLtzMI84C+U9JtcgWq0JjAiriuUP851fx/jSXZxIw3JjyIKi/CP7IuwNqzN5PQIf
         WPk0njd+uzxtoHA2p660/JL5MLihqyRlkunZlIsWLU4FFWEMOtm75+6ouHcIyeN/a4z7
         OcKQ8tEqiVAv6PiJBu9MOQzvXXSAVekfNtZHbDwwWTsEaka54hRYcf1KHpwWuaSTv5mp
         VoXCBBZCxC6taKZq9rv2lEGozfAP/B9dJJaG9chVBfcb4irhpG1Wqfifz0dHoHeD+Sd9
         o96A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699735766; x=1700340566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dw1ndMUKXNlOHoymKchXozvXFQJ/Nc6du3K0pUpN4dE=;
        b=XaDnfxv95QdZWXq4FERwuXQXQ6IEyX3VI4fyzWae75GAIe7STPB/aFkqdPPI433heH
         CFDLMz00OLG4QN+tIeHEIlzikMU+prsl3NcawgCXxadaANlZidGQc1YWFsqhgaMYbw69
         ZY2G1VJcpmafSn+BYmKEpESgzjxXySjg4F/Ar0CxQWmoyYcKi+eWM9cPlwo9qw12MTSx
         WmAOq1JJddShnXN/Ba8zqetroArLqHfJ4sx/hsw8CEpyfpflVwe3mE4Q8C1x37clbtno
         xPqKjKkmpopYCBx3fqmtbKy05/hWIJKq0znZBscbdDnQ0+cdHGHpBCJHuHiGqteB9LGz
         j+OA==
X-Gm-Message-State: AOJu0YxI2ZfgwUvgmRmcqgkdw95ntCe9/b0o4ytXDhYJVe/2S0jBx3YA
        j7aZaTpbua/I7w6qp++1GA79Lg==
X-Google-Smtp-Source: AGHT+IHwyADDQ32c2vAVYWbY0ldc5G22Q5ofdEvFs0Khl5+4IjTJkGO1Xg5TMvnTF2kdHAE5FFay9g==
X-Received: by 2002:a05:600c:4689:b0:408:37aa:4766 with SMTP id p9-20020a05600c468900b0040837aa4766mr2219387wmo.5.1699735766179;
        Sat, 11 Nov 2023 12:49:26 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600c198900b00407752bd834sm3121226wmq.1.2023.11.11.12.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 12:49:25 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 2/3] dt-bindings: mailbox: qcom,apcs-kpss-global: use fallbacks
Date:   Sat, 11 Nov 2023 21:49:15 +0100
Message-Id: <20231111204916.35835-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231111204916.35835-1-krzysztof.kozlowski@linaro.org>
References: <20231111204916.35835-1-krzysztof.kozlowski@linaro.org>
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

Rework the compatibles and group devices which have similar interface
(same from Linux driver point of view) as compatible.  This allows
smaller of_device_id table in the Linux driver and smaller
allOf:if:then: constraints.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../mailbox/qcom,apcs-kpss-global.yaml        | 61 +++++++++++++------
 1 file changed, 43 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
index a22c8640dc0e..79eb523b8436 100644
--- a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
+++ b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
@@ -23,6 +23,24 @@ properties:
               - qcom,ipq8074-apcs-apps-global
               - qcom,ipq9574-apcs-apps-global
           - const: qcom,ipq6018-apcs-apps-global
+      - items:
+          - enum:
+              - qcom,qcs404-apcs-apps-global
+          - const: qcom,msm8916-apcs-kpss-global
+          - const: syscon
+      - items:
+          - enum:
+              - qcom,msm8976-apcs-kpss-global
+          - const: qcom,msm8994-apcs-kpss-global
+          - const: syscon
+      - items:
+          - enum:
+              - qcom,msm8998-apcs-hmss-global
+              - qcom,sdm660-apcs-hmss-global
+              - qcom,sm4250-apcs-hmss-global
+              - qcom,sm6115-apcs-hmss-global
+              - qcom,sm6125-apcs-hmss-global
+          - const: qcom,msm8994-apcs-kpss-global
       - items:
           - enum:
               - qcom,sc7180-apss-shared
@@ -34,21 +52,14 @@ properties:
               - qcom,msm8916-apcs-kpss-global
               - qcom,msm8939-apcs-kpss-global
               - qcom,msm8953-apcs-kpss-global
-              - qcom,msm8976-apcs-kpss-global
               - qcom,msm8994-apcs-kpss-global
-              - qcom,qcs404-apcs-apps-global
               - qcom,sdx55-apcs-gcc
           - const: syscon
       - enum:
           - qcom,ipq6018-apcs-apps-global
           - qcom,msm8996-apcs-hmss-global
-          - qcom,msm8998-apcs-hmss-global
           - qcom,qcm2290-apcs-hmss-global
-          - qcom,sdm660-apcs-hmss-global
           - qcom,sdm845-apss-shared
-          - qcom,sm4250-apcs-hmss-global
-          - qcom,sm6115-apcs-hmss-global
-          - qcom,sm6125-apcs-hmss-global
 
   reg:
     maxItems: 1
@@ -79,10 +90,9 @@ allOf:
   - if:
       properties:
         compatible:
-          enum:
-            - qcom,msm8916-apcs-kpss-global
-            - qcom,msm8939-apcs-kpss-global
-            - qcom,qcs404-apcs-apps-global
+          contains:
+            enum:
+              - qcom,msm8916-apcs-kpss-global
     then:
       properties:
         clocks:
@@ -94,6 +104,25 @@ allOf:
             - const: pll
             - const: aux
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,msm8939-apcs-kpss-global
+    then:
+      properties:
+        clocks:
+          items:
+            - description: primary pll parent of the clock driver
+            - description: auxiliary parent
+            - description: reference clock
+        clock-names:
+          items:
+            - const: pll
+            - const: aux
+            - const: ref
+
   - if:
       properties:
         compatible:
@@ -112,6 +141,7 @@ allOf:
             - const: ref
             - const: pll
             - const: aux
+
   - if:
       properties:
         compatible:
@@ -136,16 +166,10 @@ allOf:
         compatible:
           enum:
             - qcom,msm8953-apcs-kpss-global
-            - qcom,msm8976-apcs-kpss-global
             - qcom,msm8994-apcs-kpss-global
             - qcom,msm8996-apcs-hmss-global
-            - qcom,msm8998-apcs-hmss-global
             - qcom,qcm2290-apcs-hmss-global
-            - qcom,sdm660-apcs-hmss-global
             - qcom,sdm845-apss-shared
-            - qcom,sm4250-apcs-hmss-global
-            - qcom,sm6115-apcs-hmss-global
-            - qcom,sm6125-apcs-hmss-global
     then:
       properties:
         clocks: false
@@ -191,7 +215,8 @@ examples:
     #define GCC_APSS_AHB_CLK_SRC  1
     #define GCC_GPLL0_AO_OUT_MAIN 123
     apcs: mailbox@b011000 {
-        compatible = "qcom,qcs404-apcs-apps-global", "syscon";
+        compatible = "qcom,qcs404-apcs-apps-global",
+                     "qcom,msm8916-apcs-kpss-global", "syscon";
         reg = <0x0b011000 0x1000>;
         #mbox-cells = <1>;
         clocks = <&apcs_hfpll>, <&gcc GCC_GPLL0_AO_OUT_MAIN>;
-- 
2.34.1

