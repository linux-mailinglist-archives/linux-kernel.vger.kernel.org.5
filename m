Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3FAF771D81
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 11:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbjHGJuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 05:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbjHGJup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 05:50:45 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58B81998
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 02:50:30 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fe5eb84dceso3008905e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 02:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1691401827; x=1692006627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBy/fPgo/hYXurWD6RnpLpdL4CrExU7MOBsmQrPWcBg=;
        b=dMTR42xfYtTt+sU0bumJxNZoyRyqDkQa9ifPRJ5EzIQPG7W4bYCJN4Yh5uzrmz1aT3
         hZX8lflQBTaCySJXplN6vG49E7bK6oueOKPM3NByNq/BMWe6cBOcu9Rr1DYWEXmzdb+B
         YeVDxGI2zbaX1m5sTlt3r8AVDPr6PipISUJtMPsk92VZiaXp9qhAhVxRX6f188Tbn4Ao
         d/YUFLhr88HaNZc+mv3Vgt2URfu1YbG2NNX2FgqnbFQ28B4hRN6e3QfXoeSFveU7ENk1
         8Pl6ka8YuY+LbPNjiHAtaMbMjdReKz1UtGel2ij9cMpA4UwRkUTF+RNbKKr/NzqR/27r
         iS3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691401827; x=1692006627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MBy/fPgo/hYXurWD6RnpLpdL4CrExU7MOBsmQrPWcBg=;
        b=NDFJCXquzo2us8ZnxnlvP32eM4l0r90Fc9k4rWw+Fu0S8J+f6ITkkOQwJiWEdDSNWu
         bQwaXW6LJLj0ZkfGoEu8T/qo1Kum/Bs7rmqiK4YatWr1Nc7YZrKwa4ahB9judBMJZMQW
         niiasezrWPqIPqdmkbghH2Y7Xj9myl3oHakgQphE8kBnjtXiy6YlPf4w8SHJnZj6miZB
         ilTzCgo1WokLGRuyvbku3VKda7Z+TChhNAtq6DoLo16Mjq2weNcR8FlE3QiGh4aso752
         hnfe3qyT2ATjZMJvG43Amm0/AYQiFSc+gEQFwItv9UGiX5yyS0T1YCdaUO1NFvq/f2cZ
         PvFw==
X-Gm-Message-State: AOJu0YzQLSVjffZnb5VXM0kIjMuFaQBAFOEMMmJiU7cWD5ZvPZ0kwg5l
        KMqi79JC3icrCCKX56VBWzisXA==
X-Google-Smtp-Source: AGHT+IHEb1gwsP/mnI/AlQiOHgdrgLDb8eFf3CjDco0QSR1f6VCNeu6WWmn4kc1FX6you796r1Vvlg==
X-Received: by 2002:a5d:5101:0:b0:317:6129:a972 with SMTP id s1-20020a5d5101000000b003176129a972mr6419596wrt.37.1691401827316;
        Mon, 07 Aug 2023 02:50:27 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:55f:21e0:9e19:4376:dea6:dbfa])
        by smtp.gmail.com with ESMTPSA id i11-20020a05600c2d8b00b003fe5228b78dsm2752429wmg.1.2023.08.07.02.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 02:50:27 -0700 (PDT)
From:   Julien Stephan <jstephan@baylibre.com>
Cc:     Phi-bang Nguyen <pnguyen@baylibre.com>,
        Julien Stephan <jstephan@baylibre.com>,
        Andy Hsieh <andy.hsieh@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Conor Dooley <conor+dt@kernel.org>,
        daoyuan huang <daoyuan.huang@mediatek.com>,
        devicetree@vger.kernel.org,
        Florian Sylvestre <fsylvestre@baylibre.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org,
        Louis Kuo <louis.kuo@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Moudy Ho <moudy.ho@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v3 3/4] dt-bindings: media: add mediatek ISP3.0 camsv
Date:   Mon,  7 Aug 2023 11:48:12 +0200
Message-ID: <20230807094940.329165-4-jstephan@baylibre.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230807094940.329165-1-jstephan@baylibre.com>
References: <20230807094940.329165-1-jstephan@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Phi-bang Nguyen <pnguyen@baylibre.com>

This adds the bindings, for the ISP3.0 camsv module embedded in
some Mediatek SoC, such as the mt8365

Signed-off-by: Phi-bang Nguyen <pnguyen@baylibre.com>
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 .../bindings/media/mediatek,mt8365-camsv.yaml | 109 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 110 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mt8365-camsv.yaml

diff --git a/Documentation/devicetree/bindings/media/mediatek,mt8365-camsv.yaml b/Documentation/devicetree/bindings/media/mediatek,mt8365-camsv.yaml
new file mode 100644
index 000000000000..097b1ab6bc72
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/mediatek,mt8365-camsv.yaml
@@ -0,0 +1,109 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (c) 2023 MediaTek, BayLibre
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/mediatek,mt8365-camsv.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek CAMSV 3.0
+
+maintainers:
+  - Laurent Pinchart <laurent.pinchart@ideasonboard.com>
+  - Julien Stephan <jstephan@baylibre.com>
+  - Andy Hsieh <andy.hsieh@mediatek.com>
+
+description:
+  The CAMSV is a set of DMA engines connected to the SENINF CSI-2
+  receivers. The number of CAMSVs depend on the SoC model.
+
+properties:
+  compatible:
+    const: mediatek,mt8365-camsv
+
+  reg:
+    items:
+      - description: camsv base
+      - description: img0 base
+      - description: tg base
+
+  interrupts:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: cam clock
+      - description: camtg clock
+      - description: camsv clock
+
+  clock-names:
+    items:
+      - const: cam
+      - const: camtg
+      - const: camsv
+
+  iommus:
+    maxItems: 1
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: connection point for camsv0
+
+    required:
+      - port@0
+
+required:
+  - compatible
+  - interrupts
+  - clocks
+  - clock-names
+  - power-domains
+  - iommus
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/clock/mediatek,mt8365-clk.h>
+    #include <dt-bindings/memory/mediatek,mt8365-larb-port.h>
+    #include <dt-bindings/power/mediatek,mt8365-power.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        camsv1: camsv@15050000 {
+            compatible = "mediatek,mt8365-camsv";
+            reg = <0 0x15050000 0 0x0040>,
+                  <0 0x15050208 0 0x0020>,
+                  <0 0x15050400 0 0x0100>;
+            interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_LOW>;
+            clocks = <&camsys CLK_CAM>,
+                     <&camsys CLK_CAMTG>,
+                     <&camsys CLK_CAMSV0>;
+            clock-names = "cam", "camtg", "camsv";
+            iommus = <&iommu M4U_PORT_CAM_IMGO>;
+            power-domains = <&spm MT8365_POWER_DOMAIN_CAM>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+                port@0 {
+                    reg = <0>;
+                    camsv1_endpoint: endpoint {
+                        remote-endpoint = <&seninf_camsv1_endpoint>;
+                    };
+                };
+            };
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index c5a97f692422..fd192d3799b5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13364,6 +13364,7 @@ M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
 M:	Julien Stephan <jstephan@baylibre.com>
 M:	Andy Hsieh <andy.hsieh@mediatek.com>
 S:	Supported
+F:	Documentation/devicetree/bindings/media/mediatek,mt8365-camsv.yaml
 F:	Documentation/devicetree/bindings/media/mediatek,mt8365-seninf.yaml
 F:	drivers/media/platform/mediatek/isp/isp_30/seninf/*
 
-- 
2.41.0

