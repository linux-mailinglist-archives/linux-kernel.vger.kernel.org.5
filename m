Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A4180A17F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 11:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573623AbjLHKwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 05:52:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235879AbjLHKwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 05:52:00 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6448F171C
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 02:52:05 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-a00f67f120aso249243566b.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 02:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702032724; x=1702637524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TAfB7XP9qswfZDmppuZfzA/p4yR5CeCNI9dzwHD6WP4=;
        b=EWpUv5Fzt18xugwIn2mWF5ktL1004rnxGtKahBcRghb/hJvFh5kOlr9ecEIzN32/A6
         WVDxeOkDAWBHFRGb8AXp1Vvvs4tGfr02G+zZnEbSrlV/DJB3ubM5mUzw/UwSwI5Qebau
         VW0Q2kEnU7dqt/KL6vN8WwlN9mluY0pVw+xvqIy+HpxNhanp7M3JceRMtxwrU1lXfNq2
         egaNVk68E0ZqihF93hxLSZlTtepmnZoTuiH8SrCIBL2owkIo59TxpBokOw9B74MK3IGG
         0qq8xO/2j9bHkV3kS74NRXNBpe/Dck/AuO2D/9EL3AAFCbrEagGpU2lssxP8KfSd6mKn
         XwUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702032724; x=1702637524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TAfB7XP9qswfZDmppuZfzA/p4yR5CeCNI9dzwHD6WP4=;
        b=Ym+gJPn4l3gJ4RuZqT4PMmbvoYjnIl9FtCSJpNuwKpcgm+M4dhqc15+q7Q+i+gzCYI
         +BgPfn8ZpLtPjd+FMiTm6a72Zc4ujkT1GTukbtpuEZdYRKxNGdQ0giQ9skFx1Glm0wFm
         7/z9+H8i6516st+VtkZ23RnNEDYCKOE/RLWghYNLhyxUs4KnhJmo7eQ/6MofXaKkRWOh
         YRSxsn2cvqXYFD2vPLdkOjoZjrIII/12ehzTU2U5Iu43gYaqE4XKBqldVdQhVsZVQ9tQ
         mMEerXgWX6DPFAXEzV4flXFY7uXIchxbYUyQtCB3FAtTDS3GI70XTXH9ak5IgCgOGisZ
         wvhw==
X-Gm-Message-State: AOJu0Yxm4Hv9SR/ri/m/2PFhrBLRPGivqoLD9vxWQgpYRlAW5BwI9Ty0
        fn9lvqw26JYpBfESTErQI4S92Q==
X-Google-Smtp-Source: AGHT+IHQWFvI3cUlx05L62in4j7p7qC1FH/YrW2thF2CuQ0R9iAKMY25cPEvsPV2B+Moh/dQko+f6Q==
X-Received: by 2002:a17:906:f88f:b0:a19:a19b:55e7 with SMTP id lg15-20020a170906f88f00b00a19a19b55e7mr2336374ejb.119.1702032723901;
        Fri, 08 Dec 2023 02:52:03 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id tx17-20020a1709078e9100b00a1b75e0e061sm849976ejc.130.2023.12.08.02.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 02:52:03 -0800 (PST)
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
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 2/4] dt-bindings: PCI: qcom: correct clocks for SC8180x
Date:   Fri,  8 Dec 2023 11:51:53 +0100
Message-Id: <20231208105155.36097-2-krzysztof.kozlowski@linaro.org>
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

PCI node in Qualcomm SC8180x DTS has 8 clocks:

  sc8180x-primus.dtb: pci@1c00000: 'oneOf' conditional failed, one must be fixed:
    ['pipe', 'aux', 'cfg', 'bus_master', 'bus_slave', 'slave_q2a', 'ref', 'tbu'] is too short

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Please take the patch via PCI tree.

Changes in v3:
1. Split from sm8150 change. Due to split/changes around sm8150, drop
   Mani's Rb tag.
2. Drop unneeded oneOf for clocks.

Changes in v2:
1. Add Acs/Rb.
2. Correct error message for sm8150.
---
 .../devicetree/bindings/pci/qcom,pcie.yaml    | 28 ++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 5056da499f04..5214bf7a9045 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -483,6 +483,33 @@ allOf:
           items:
             - const: pci # PCIe core reset
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pcie-sc8180x
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
+            - const: ref # REFERENCE clock
+            - const: tbu # PCIe TBU clock
+        resets:
+          maxItems: 1
+        reset-names:
+          items:
+            - const: pci # PCIe core reset
+
   - if:
       properties:
         compatible:
@@ -531,7 +558,6 @@ allOf:
         compatible:
           contains:
             enum:
-              - qcom,pcie-sc8180x
               - qcom,pcie-sm8150
               - qcom,pcie-sm8250
     then:
-- 
2.34.1

