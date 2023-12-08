Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE49880A17D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 11:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573617AbjLHKwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 05:52:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbjLHKv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 05:51:59 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F531734
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 02:52:03 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-54dcfca54e0so2239574a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 02:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702032722; x=1702637522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=11veHRxQhePRmTa5CrJ3aUmZgsLlL/GI3AnVt9qonDk=;
        b=NbuRrBrTa3g7wYBGRmnyliJ0l2qBse6XpnP/d4+rlSS3MzgMC85XNu9b+wCu6TWgXT
         imtUQObgZw9O8jkWCioJ0DJf6tn9lRZ1i3XpcmnehOtl+nqmIzAJ8QHH8n/OGDZ6T32i
         z5qHrxaq5ddfRyzJJiC3EcIl/acbrL1dLjhZiX9G98xXh2ywznkmj2cDxJMOvOi+5yPR
         UYuNS9mYoX0MFALjnKiVL3KedAUzGmaItX4/0M7iKXLaEmdQTY4eqBma07Zgp/OkO8wO
         OW0rx5sIyzOAP02MSo0uJJlC7AYEWu+HGYC7Mf2G7OONEtFN9BYoKyH2RGRgCDuFElUO
         ZDQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702032722; x=1702637522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=11veHRxQhePRmTa5CrJ3aUmZgsLlL/GI3AnVt9qonDk=;
        b=TVgMb9c8whWZT5JHVgy1s+o4yOGFs+DzJpAaZ43L1P5P7/3wlDo++bHaMBB4MI/Qpt
         bM+N6CdVOo3mWgr2DuT1nZd51fOO+DkJ0YGr2sFa/lBAQ0O41kRa1kHBWeqtvtmCnuRM
         7sFfhTMkwVnxdFlF7xydIipYegUIbDbMZ6iWeKuLFWrUi2uAXlaT6EmDJAmuTny3TL6m
         hkb2rLj5B0jpU6RaZVjUmfxUx3UCE5yMFuvGeOtGb+KUp75guP2bb90aqwbM6HN7Nlwj
         yvKJHe1nTTHFuHMSaf2zKAGF7uRrZNhL33DCd8KZKwxPab2W1BaM/4r2q0vh7mB2WQpm
         /MgA==
X-Gm-Message-State: AOJu0YxFtKtHJgbTXYlNLrJtCkWSQ7685jrs3lDaZQAhY4Cdzx8Iu6CD
        uqq5y9GD9/rUXexBOMzGtf71pA==
X-Google-Smtp-Source: AGHT+IFy/oY2zqBZqwRcRdiTxU/NBEEy892xMZAtSwzJby17iOVNew42umLhhA8HnKertNw0LYCfyw==
X-Received: by 2002:a17:907:9518:b0:a1c:cd3b:4c2a with SMTP id ew24-20020a170907951800b00a1ccd3b4c2amr2129103ejc.72.1702032722112;
        Fri, 08 Dec 2023 02:52:02 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id tx17-20020a1709078e9100b00a1b75e0e061sm849976ejc.130.2023.12.08.02.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 02:52:01 -0800 (PST)
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
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 1/4] dt-bindings: PCI: qcom: adjust iommu-map for different SoC
Date:   Fri,  8 Dec 2023 11:51:52 +0100
Message-Id: <20231208105155.36097-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

The PCIe controller on SDX55 has five entries in its iommu-map, MSM8998
has one and SDM845 has sixteen, so allow wider number of items to fix
dtbs_check warnings like:

  qcom-sdx55-mtp.dtb: pcie@1c00000: iommu-map: [[0, 21, 512, 1], [256, 21, 513, 1],
    [512, 21, 514, 1], [768, 21, 515, 1], [1024, 21, 516, 1]] is too long

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Please take the patch via PCI tree.

Changes in v3:
1. None

Changes in v2:
1. Add Acs/Rb.
---
 Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 9dbc07dfd48f..5056da499f04 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -66,7 +66,8 @@ properties:
     maxItems: 8
 
   iommu-map:
-    maxItems: 2
+    minItems: 1
+    maxItems: 16
 
   # Common definitions for clocks, clock-names and reset.
   # Platform constraints are described later.
-- 
2.34.1

