Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC13780A189
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 11:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573635AbjLHKwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 05:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573559AbjLHKwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 05:52:01 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4DB10C2
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 02:52:07 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-a1c7d8f89a5so257851966b.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 02:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702032726; x=1702637526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RN5mp7wTS0ZL9oWDzM8c7WSR4Kqr0x4UsxjvnOwJZ54=;
        b=TTRXK3UezIiAx6CURgAyfKdfnAWG79eP5axjv9MqgTiiRvp6GpE4cgm2gYMVt3FsMF
         bSmyw34J1GSDpK7XsjbjPyLyCYTK8BVNlyodMla1LF2EtQldSF8mSikKI/R3W+YGm66z
         Q/HrBCRY4m/6nieSk5cqhggdfhHe4jMYeAtyYEHlKP5LrcjHwpKduQfGJvpqoohXYp0D
         4Yfi7IcR+bo5aHBv7Gkm9LvtXzb7A0T2mG4KGJ00PORrQTWnN3xxXYYuyTSBzPbThQzh
         vY1QVDpDDFVjFEH1QT0UBS1yOEhAh2k1u0I2/kwcbR50wGHqP+JDv8UBaGpKP011qYQN
         UVRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702032726; x=1702637526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RN5mp7wTS0ZL9oWDzM8c7WSR4Kqr0x4UsxjvnOwJZ54=;
        b=sqfwmWMFEn/ZxrdOxvFjNpY36nfc+NxBE4+Bwj0YptNVwmRM/AEXa/my82WUp7Fhuw
         Vk+YsQEvN9FjVRdEn8DlxYDPO819rlMZdPPIzWme9/MrCI7KK9iSY1g+KYmY1UhzgufU
         EPZc1stllkFLSYYiavchwWWwib6SwY0uEuuHb6ZEYmHoRprioje6lMPIVMcHqFUbtXIK
         LRxEyY1aB0QwenVjXGyItaeBRP45uxOsJrKFbVZppDR2QdXOlySYFG+LWYxhXB2Juam5
         G3aa9XvORL4/UsDLfu09yBlIpjwhe27TkGWnXRhB5x3NoETfdi/CjVb26WRZw/vd55mo
         F0ew==
X-Gm-Message-State: AOJu0Yy5kvn/u5IJ+DTidT34kI7y9OCGt8pXQkpgHq/TmFM4sjI+Dn7G
        yim8veREa6Ec1eDlVSXm4Ugfiw==
X-Google-Smtp-Source: AGHT+IFa3yE/mQVHSrkLKmIRUVYN9Uw84CyOj2njdjyXU/h65hwehtnmy3fIse4e3d36lkIR9h7FOg==
X-Received: by 2002:a17:906:560c:b0:a19:a1ba:da51 with SMTP id f12-20020a170906560c00b00a19a1bada51mr2668011ejq.120.1702032725770;
        Fri, 08 Dec 2023 02:52:05 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id tx17-20020a1709078e9100b00a1b75e0e061sm849976ejc.130.2023.12.08.02.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 02:52:05 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 3/4] dt-bindings: PCI: qcom: correct clocks for SM8150
Date:   Fri,  8 Dec 2023 11:51:54 +0100
Message-Id: <20231208105155.36097-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208105155.36097-1-krzysztof.kozlowski@linaro.org>
References: <20231208105155.36097-1-krzysztof.kozlowski@linaro.org>
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

PCI node in Qualcomm SM8150 should have exactly 8 clocks, including the
ref clock.

Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Please take the patch via PCI tree.

Changes in v3:
1. New patch: Split from sc8180x change.
2. Add refclk as explained here:
   https://lore.kernel.org/all/20231121065440.GB3315@thinkpad/
---
 .../devicetree/bindings/pci/qcom,pcie.yaml    | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 5214bf7a9045..a93ab3b54066 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -559,6 +559,32 @@ allOf:
           contains:
             enum:
               - qcom,pcie-sm8150
+    then:
+      properties:
+        clocks:
+          minItems: 8
+          maxItems: 8
+        clock-names:
+          items:
+            - const: pipe # PIPE clock
+            - const: aux # Auxiliary clock
+            - const: cfg # Configuration clock
+            - const: bus_master # Master AXI clock
+            - const: bus_slave # Slave AXI clock
+            - const: slave_q2a # Slave Q2A clock
+            - const: tbu # PCIe TBU clock
+            - const: ref # REFERENCE clock
+        resets:
+          maxItems: 1
+        reset-names:
+          items:
+            - const: pci # PCIe core reset
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

