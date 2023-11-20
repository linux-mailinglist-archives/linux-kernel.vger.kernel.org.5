Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93C957F0C85
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 08:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbjKTHJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 02:09:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjKTHJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 02:09:22 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8754A4
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 23:09:18 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-548d1f8b38bso349182a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 23:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700464157; x=1701068957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6laP/QeQ8ZkNdY+I7g66zga8GNt1LoZIWkuM0YaBrIE=;
        b=LaRHv4HACu2w7RpKBmj9nr5IR1qElkq6oW4JgK0ak/Ox/R0qfvBi29cyOuKI9ODN4W
         0DIb90S4QxZdG25nuJXsOBH6INWLL/eweOGyQmdWkzf2S4svJ/q3XPXU8OV3+uERPbUF
         ejOhTOGk5Tc92yw9mOBFSvQ2ixIG1MpmgvMISrcyosWfOQm/zHi88/YWVm0cTZAiS1fV
         dhtO1CfztH5ffxc3JhIfZhj6VQ65ZTMs6APE0NIhHiIwQYko2HlS8AVl07b03Z6ajKM7
         l2c0a/2jizysm5CixxeGacRYYbbEmclK/M6wN6ZL3IniQxAMfiBjmYM6Dftb5callqvG
         MWQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700464157; x=1701068957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6laP/QeQ8ZkNdY+I7g66zga8GNt1LoZIWkuM0YaBrIE=;
        b=ESwaaF8CdpU4XjqHhT+vfjno5YeqtEK553DYeWhmnM1VI2Rt5c6RRQEHZV11rgWw3f
         zoaehq4oJ1fWUz8OEWPRRWopTAnOyj2ePj/8Rw97qVdZB8s5A+CNPtK7nSyiDvlKrzlL
         PZuq+1+kmbE1m5aFWgOkGSISjGhV/VpM9jaM2qtFvliz8qKSPbreAVXb3Nj5/Fng8cpf
         AkwwSoBMTRRoXEqw567HAQ4AzhLmEOPvYUQmV5l6M7X9bxkYPGmPtgTEU/OZTdNcm34m
         HaOvbJnJIPn/+5Jb7E3H3F0aEKahw2RVbTaCik4GCCSxpQK0SAC1/sUjUECuE15lHOiy
         xcLA==
X-Gm-Message-State: AOJu0Yz1ru0Nc0vG9H/2kAyf9dlcXEWIU2FPxn9fPp8J6QBIYUHqr+65
        Yt6U62YQO7Y5HnvGvu1l1ytg8g==
X-Google-Smtp-Source: AGHT+IGnSpGLDhGj8nPBUxiGsT/wU1tVvYfXN3TxpwhKJ+R5n5vOwx8YbFTgOFcBuhLAy8fmL2wVLw==
X-Received: by 2002:a17:907:29d7:b0:9df:4232:5276 with SMTP id ev23-20020a17090729d700b009df42325276mr4154859ejc.76.1700464157199;
        Sun, 19 Nov 2023 23:09:17 -0800 (PST)
Received: from krzk-bin.. ([178.197.222.11])
        by smtp.gmail.com with ESMTPSA id d2-20020a170906640200b0099bd7b26639sm3570500ejm.6.2023.11.19.23.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 23:09:16 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 2/2] dt-bindings: PCI: qcom: correct clocks for SC8180x and SM8150
Date:   Mon, 20 Nov 2023 08:09:10 +0100
Message-Id: <20231120070910.16697-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231120070910.16697-1-krzysztof.kozlowski@linaro.org>
References: <20231120070910.16697-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PCI node in Qualcomm SC8180x DTS has 8 clocks, while one on SM8150 has 7
clocks:

  sc8180x-primus.dtb: pci@1c00000: 'oneOf' conditional failed, one must be fixed:
    ['pipe', 'aux', 'cfg', 'bus_master', 'bus_slave', 'slave_q2a', 'ref', 'tbu'] is too short

  sm8150-hdk.dtb: pci@1c00000: 'oneOf' conditional failed, one must be fixed:
    ['pipe', 'aux', 'cfg', 'bus_master', 'bus_slave', 'slave_q2a', 'tbu'] is too short

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Add Acs/Rb.
2. Correct error message for sm8150.
---
 .../devicetree/bindings/pci/qcom,pcie.yaml    | 58 ++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 14d25e8a18e4..4c993ea97d7c 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -479,6 +479,35 @@ allOf:
           items:
             - const: pci # PCIe core reset
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pcie-sc8180x
+    then:
+      oneOf:
+        - properties:
+            clocks:
+              minItems: 8
+              maxItems: 8
+            clock-names:
+              items:
+                - const: pipe # PIPE clock
+                - const: aux # Auxiliary clock
+                - const: cfg # Configuration clock
+                - const: bus_master # Master AXI clock
+                - const: bus_slave # Slave AXI clock
+                - const: slave_q2a # Slave Q2A clock
+                - const: ref # REFERENCE clock
+                - const: tbu # PCIe TBU clock
+      properties:
+        resets:
+          maxItems: 1
+        reset-names:
+          items:
+            - const: pci # PCIe core reset
+
   - if:
       properties:
         compatible:
@@ -527,8 +556,35 @@ allOf:
         compatible:
           contains:
             enum:
-              - qcom,pcie-sc8180x
               - qcom,pcie-sm8150
+    then:
+      oneOf:
+        - properties:
+            clocks:
+              minItems: 7
+              maxItems: 7
+            clock-names:
+              items:
+                - const: pipe # PIPE clock
+                - const: aux # Auxiliary clock
+                - const: cfg # Configuration clock
+                - const: bus_master # Master AXI clock
+                - const: bus_slave # Slave AXI clock
+                - const: slave_q2a # Slave Q2A clock
+                - const: tbu # PCIe TBU clock
+      properties:
+        resets:
+          maxItems: 1
+        reset-names:
+          items:
+            - const: pci # PCIe core reset
+
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
               - qcom,pcie-sm8250
     then:
       oneOf:
-- 
2.34.1

