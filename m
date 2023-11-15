Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658767E8B2C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 15:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjKKOUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 09:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjKKOUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 09:20:13 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8A92D77
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 06:20:10 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9becde9ea7bso835676266b.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 06:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699712408; x=1700317208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JA5Nkvzxmv6waoHDPDTREWJStX6OwLvfiQxW2MCYDcw=;
        b=QStNDfEzI2aT5TOWfQd+PxYiQeDmqDSzC8tzgDP4dhlum50RJBRxNX0gi6+rAusx/P
         whIsngMlw/ckA9MFhZCQoGmVpek8hHfdwB4cpxP01vGRcHCo1nuPIojZp4eqJhuf6OIH
         gaTARXo9INXhi+oE/RoZIxRWr47aQpkyGki2rjhE0o3h2PYWaodaqUMgLuTHm2hdF1Z6
         IimMWD8YCWUmyBtuwM8gIX8CIy0bH/fYwl/S977bnoykXkRBaCq1ZimWaFnb4V5ex4eh
         lepytkBqx1dqkooaKUeZpRg8ARL7ojGKyjCIrMZxn1SuSCNTSNmcVqOhb96X2zXq5u9+
         I4TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699712408; x=1700317208;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JA5Nkvzxmv6waoHDPDTREWJStX6OwLvfiQxW2MCYDcw=;
        b=mvwAGXbsJwXSsI5ByhJXklY3SobjyL0yNXNBpDOjOg2L3mc/S5q+WOeUXN1p8cvfoH
         isUpTVivgypEvviNjT31mog6jt2Tte+buP6AgVc01aaI9+cBaRhg6gAPCjiau3OlyWFS
         uIch+M1h01xxFT5HZbx31uD+5IG6UDWhTX92ElkpRt9mj7X4vf4vz6WVdDdrzJZ0ZQNw
         2VYGclMuJ/dJemHhM1WYUVYMGcSLRZa3aiJmqW6sIMT1XRV4dtWSygdRdlMZd9JWYYfh
         gXf5gAz1oJkOgiYgF0AlT2eP1QkmAMe+5fE44ZdMrgf4rttEipk3x0DbuXp6uaaEFUyA
         i48A==
X-Gm-Message-State: AOJu0Yy2+p8I0fnwImI4CWWcM7tVJ3bvxNL4MMmldwMdrhU27vBwFLF+
        Eq4tTdFOm9XE86iloANKvo7YjQ==
X-Google-Smtp-Source: AGHT+IGtbeP7+4JYvN4uMG6ZHD2gLZqCG1nqHU+QMwNuFtqK/5Swfy4XnFEUyGdXouPKYfwHzmaGfA==
X-Received: by 2002:a17:906:c1d6:b0:9ba:b5:cba6 with SMTP id bw22-20020a170906c1d600b009ba00b5cba6mr1805887ejb.14.1699712408679;
        Sat, 11 Nov 2023 06:20:08 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id dc3-20020a170906c7c300b009b947f81c4asm1123864ejb.155.2023.11.11.06.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 06:20:08 -0800 (PST)
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
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: PCI: qcom: Correct reset-names property
Date:   Sat, 11 Nov 2023 15:20:06 +0100
Message-Id: <20231111142006.51883-1-krzysztof.kozlowski@linaro.org>
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

There is no "resets-names" property, but "reset-names".

Fixes: 075a9d55932e ("dt-bindings: PCI: qcom: Convert to YAML")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index eadba38171e1..8bfae8eb79a3 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -88,7 +88,7 @@ properties:
     minItems: 1
     maxItems: 12
 
-  resets-names:
+  reset-names:
     minItems: 1
     maxItems: 12
 
-- 
2.34.1

