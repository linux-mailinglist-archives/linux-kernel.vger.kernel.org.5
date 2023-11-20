Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F8A7F0C83
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 08:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbjKTHJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 02:09:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjKTHJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 02:09:19 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CE990
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 23:09:15 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-a0039ea30e0so5661066b.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 23:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700464154; x=1701068954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JUN834VVYK8twG3IjVN0msVN67LU5krCVdfvSAdrwLI=;
        b=Hg3I7frsuLENJtX+y9x9+s7jWtb7aqcQhiXaJh4XTMCMTyq8SzWijI7ylw/rMgDh6Y
         TksFm7BlZaeLvXDcW6oUxEYIQ1ZRmolmUAEW4xvZkOOjW2dEmXOC/S7/UldcM34OKC1B
         sUgjv7z1RV/wq2P702pq9lQN9VMhCND7jafnQBUe6F1csyR2edYW8/tdg6L8RqsN88J3
         L5Wz0RvjsMmTklYMZcuDvbmvlLwtlzPHK+Y+P8Td/6luybJWKIxUn6gUotWQc0Q8r79t
         GdA5aq5Ax5XFFfcb2N8VaW1lq5ZzXHIcHUFcYrcW6Zb0t4aKrJ0pbFtSg4/2bbJFOav0
         sOHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700464154; x=1701068954;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JUN834VVYK8twG3IjVN0msVN67LU5krCVdfvSAdrwLI=;
        b=NIy3/nqq6iVIH6h865Gd03cFd9FjzugMvIwOhKvqJCaXvnTqGH3KWSY+yUH9fnM6cH
         lhByXBBIZp7oBZmas0TyfyIPsrxZWc/OePDsbzcODlE2CPkoUpmT9JAxf4v21BtobkgA
         9+MSoDRuGXjlRciueF2oWTtdPZKB/pzTiJTvP7AcWKK+7Dyfz9KPDGCSUnTXS/KmsI9G
         VqKaIR7JD1wRcURLtFVt+GoSYJz/bDhzyRGjIW4Ke0xm9G9rbxtOKa1wycO6ZHNJHLOh
         mNNh7/VbIrKcGTweUbfLSABW8HA0Bdgw867LoOAki+3zHIMq7iDwhT8xe4BplvVtM2TZ
         A9nw==
X-Gm-Message-State: AOJu0YwXcNOwlGD3cM5TfUSgWHroZJ2Xc9TGbm2BaxcHqNhe+FZu4Ppz
        bQ1wZeECezdArL4SmSHuhUOTXA==
X-Google-Smtp-Source: AGHT+IHD/fU6exyVMz9nsgS1Ig6AMjkjbTGjfVno4m2blpUBrKjRBDPq4opvk3Uukz62fuDYhrwh0w==
X-Received: by 2002:a17:907:3c10:b0:9fe:5d39:41c1 with SMTP id gh16-20020a1709073c1000b009fe5d3941c1mr1408033ejc.52.1700464154360;
        Sun, 19 Nov 2023 23:09:14 -0800 (PST)
Received: from krzk-bin.. ([178.197.222.11])
        by smtp.gmail.com with ESMTPSA id d2-20020a170906640200b0099bd7b26639sm3570500ejm.6.2023.11.19.23.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 23:09:13 -0800 (PST)
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
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 1/2] dt-bindings: PCI: qcom: adjust iommu-map for different SoC
Date:   Mon, 20 Nov 2023 08:09:09 +0100
Message-Id: <20231120070910.16697-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

The PCIe controller on SDX55 has five entries in its iommu-map, MSM8998
has one and SDM845 has sixteen, so allow wider number of items to fix
dtbs_check warnings like:

  qcom-sdx55-mtp.dtb: pcie@1c00000: iommu-map: [[0, 21, 512, 1], [256, 21, 513, 1],
    [512, 21, 514, 1], [768, 21, 515, 1], [1024, 21, 516, 1]] is too long

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Add Acs/Rb.
---
 Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 8bfae8eb79a3..14d25e8a18e4 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -62,7 +62,8 @@ properties:
     maxItems: 8
 
   iommu-map:
-    maxItems: 2
+    minItems: 1
+    maxItems: 16
 
   # Common definitions for clocks, clock-names and reset.
   # Platform constraints are described later.
-- 
2.34.1

