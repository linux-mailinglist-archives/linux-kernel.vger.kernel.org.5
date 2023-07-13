Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B92F75260C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbjGMPEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbjGMPEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:04:30 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A01106
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 08:04:29 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-98df3dea907so120526366b.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 08:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1689260668; x=1691852668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J0qTvBf5FgaTyQcfbl+e1xRZRJHDSVi0KUDZ9vhIQHg=;
        b=4VNzRyteYrFfKexzB8Qn3VbI/bFDU4Kbe4VCy941Q3FmJcywE04PS//wnYk82YJRO/
         fblUk8CEjBGspi5ROwN2cN/mi//wecUfx04FbbjDK0c4Lurm0EJHU639KPMhk+6HNUre
         /LmmSjbTpYsyPyrWZXTjKV5E7YyRYyD8HQFsci9vkjD9a/U/YfDl9FihdflLMEzMT0lZ
         Ws+c2K/5Pxs7k0g1j8CLlIkXldxa/Aa4b8oJbyjbixem46i/hfM7n6PCFOrFKGXH+R8Q
         M6X4ZnBoC1fVBOtk6dSlr+QX9q0gkGTf3Adi09kYYxgsEVDTsQnoYqLCR4unc79PJ1wy
         rz/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689260668; x=1691852668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J0qTvBf5FgaTyQcfbl+e1xRZRJHDSVi0KUDZ9vhIQHg=;
        b=cSiu3IsELC+IZQ7/WEfOqyMRnVU4eC6idpC473SqN5HMDeBo9O2O5muk8h57VqeJBx
         pSZjPxVGMzKW2jqLKFoSf3/ahKL6K0jDuKv2KR1idNkA4iIGo9riOG7BP+eI9kDEN6TJ
         pRbmYi8Gg7d6h5vIXWE67rI/HGPuy5rPUxjQ4BJ7F9Vh2BkJju8NCJqAVxPcWkrm68Vz
         svI5EDw8vVUthZ2Hubkf0OAT1Vs1maO7Y679tBHQGLBs9ymKdb1r0brUGn9mBxt3LrGK
         NNXFWFp84+JGaOdpXW2FKZWXLdsaNwYNOwrqS3/+nV6KLftuNxxcD7QfBIHBtoOHjlSw
         tvtw==
X-Gm-Message-State: ABy/qLYzlXWijIFFt0Yo+YQwTsH9U+Zi7fVf4LEOu2GYAc8ggwP9Le30
        Gyl11wE8pnHZQsvV98dAeRAkhQ==
X-Google-Smtp-Source: APBJJlGmB6PaFatY8+84gJNEQfODAH4Hsrd1Jkh+iEMF5Q8ud/aawSFeHhlV64SUdDYXtjlA8AoMZA==
X-Received: by 2002:a17:906:224a:b0:991:caa8:fc3a with SMTP id 10-20020a170906224a00b00991caa8fc3amr1704354ejr.72.1689260667614;
        Thu, 13 Jul 2023 08:04:27 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a247:82fa:1d6d:d215:e7c4:dd5e])
        by smtp.gmail.com with ESMTPSA id cd26-20020a170906b35a00b009929c39d5c4sm4102939ejb.36.2023.07.13.08.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 08:04:27 -0700 (PDT)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Fabien Parent <parent.f@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH v7 1/8] dt-bindings: power: Add MT8365 power domains
Date:   Thu, 13 Jul 2023 17:04:07 +0200
Message-Id: <20230713150414.891893-2-msp@baylibre.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230713150414.891893-1-msp@baylibre.com>
References: <20230713150414.891893-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabien Parent <fparent@baylibre.com>

Add power domains dt-bindings for MT8365.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
Tested-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 .../power/mediatek,power-controller.yaml      |  6 ++++++
 .../dt-bindings/power/mediatek,mt8365-power.h | 19 +++++++++++++++++++
 2 files changed, 25 insertions(+)
 create mode 100644 include/dt-bindings/power/mediatek,mt8365-power.h

diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
index c9acef80f452..8985e2df8a56 100644
--- a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
+++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
@@ -31,6 +31,7 @@ properties:
       - mediatek,mt8188-power-controller
       - mediatek,mt8192-power-controller
       - mediatek,mt8195-power-controller
+      - mediatek,mt8365-power-controller
 
   '#power-domain-cells':
     const: 1
@@ -88,6 +89,7 @@ $defs:
               "include/dt-bindings/power/mediatek,mt8188-power.h" - for MT8188 type power domain.
               "include/dt-bindings/power/mt8192-power.h" - for MT8192 type power domain.
               "include/dt-bindings/power/mt8195-power.h" - for MT8195 type power domain.
+              "include/dt-bindings/power/mediatek,mt8365-power.h" - for MT8365 type power domain.
         maxItems: 1
 
       clocks:
@@ -115,6 +117,10 @@ $defs:
         $ref: /schemas/types.yaml#/definitions/phandle
         description: phandle to the device containing the INFRACFG register range.
 
+      mediatek,infracfg-nao:
+        $ref: /schemas/types.yaml#/definitions/phandle
+        description: phandle to the device containing the INFRACFG-NAO register range.
+
       mediatek,smi:
         $ref: /schemas/types.yaml#/definitions/phandle
         description: phandle to the device containing the SMI register range.
diff --git a/include/dt-bindings/power/mediatek,mt8365-power.h b/include/dt-bindings/power/mediatek,mt8365-power.h
new file mode 100644
index 000000000000..e6cfd0ec7871
--- /dev/null
+++ b/include/dt-bindings/power/mediatek,mt8365-power.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ */
+
+#ifndef _DT_BINDINGS_POWER_MT8365_POWER_H
+#define _DT_BINDINGS_POWER_MT8365_POWER_H
+
+#define MT8365_POWER_DOMAIN_MM		0
+#define MT8365_POWER_DOMAIN_CONN	1
+#define MT8365_POWER_DOMAIN_MFG		2
+#define MT8365_POWER_DOMAIN_AUDIO	3
+#define MT8365_POWER_DOMAIN_CAM		4
+#define MT8365_POWER_DOMAIN_DSP		5
+#define MT8365_POWER_DOMAIN_VDEC	6
+#define MT8365_POWER_DOMAIN_VENC	7
+#define MT8365_POWER_DOMAIN_APU		8
+
+#endif /* _DT_BINDINGS_POWER_MT8365_POWER_H */
-- 
2.40.1

