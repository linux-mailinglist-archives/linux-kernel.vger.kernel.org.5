Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4860771D73
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 11:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjHGJuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 05:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjHGJuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 05:50:11 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D462199E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 02:50:01 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fe4ad22eb0so26304825e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 02:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1691401799; x=1692006599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hozU9zGuihMyLO4oaDd3zuznBlhpACn7i/jJjMASzyk=;
        b=fb3fFGmIAWrKY7oWVXJKUXfG6fPwkovCPyhb6hqE70y5uWovspzojgvw6MoXD7sANS
         TSKHXO3U4MNPViCPY/ITMB/koAEfCmqPjIPt6Rsa3QvRG0zpnPaEwW6/ZZ3rZD1LxrEH
         8trYrLCXQAGFLnFY2fPyYbaZ/l2gCejaEVV3SGSo6Gm1ogqsKuUO8sXTOxDAy/BQmRhG
         q9qOXrAx6ECeO5MEWTAkv1KEn06/dN1JYgjOmn4DUql11IUSAicO3V2gCfpd1OGrwEws
         AUGZzvO4o3N4+3Q9LLFV0mZYGHJJNoQWkEb8dV7dHcR3QrD6+YOeNuPCCjlS+agnGHJy
         PSeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691401799; x=1692006599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hozU9zGuihMyLO4oaDd3zuznBlhpACn7i/jJjMASzyk=;
        b=ZrrG0F3MakojcCvFgFh5tAS6lHbwXs8WhzPFqBhC9SdCF5qzTNsAKx+PfT7RpgM24B
         Kzl4QFqJ3042WLUYly/8PWaryfrt+uJSkqflrFQLCBg2K1ML8hqoHnunCYw6GV2PcIro
         tLHMqO+Fc031UgcTSdhwBGnQ4R1C2dUqWQoqVes3/xGo7rpoI0KXOufNueQhkUv9LEdI
         hR9g+oV6xrf1Flrd7hcKQi0I5Dt4diucttn5WbIs8cQAG4TgkqPNqYZQHIHp9YiaU620
         opvPrY1NiEA6RHQHCNexekpjEvIDoIw0EJR783k+D/6nLqDF3cdMt9dklyWMT5YFqmp+
         M+3A==
X-Gm-Message-State: AOJu0Yx9ylqoh25cd1W7UFnSo0ymT+S4smpPfoc1fak/X0DEyJgKvVh+
        jfyl+KxPLZIVXwxngvoMopRN6A==
X-Google-Smtp-Source: AGHT+IGIY5+VxSlweqbcvOPzdSxJyb8qRscT8BgfVIF3bbg/RdpxJK4oGCC1oYoYYKku9pVgAwWjBw==
X-Received: by 2002:a05:600c:20f:b0:3f8:c70e:7ed1 with SMTP id 15-20020a05600c020f00b003f8c70e7ed1mr7188839wmi.20.1691401799168;
        Mon, 07 Aug 2023 02:49:59 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:55f:21e0:9e19:4376:dea6:dbfa])
        by smtp.gmail.com with ESMTPSA id i11-20020a05600c2d8b00b003fe5228b78dsm2752429wmg.1.2023.08.07.02.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 02:49:58 -0700 (PDT)
From:   Julien Stephan <jstephan@baylibre.com>
Cc:     Louis Kuo <louis.kuo@mediatek.com>,
        Phi-Bang Nguyen <pnguyen@baylibre.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
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
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Moudy Ho <moudy.ho@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v3 1/4] dt-bindings: media: add mediatek ISP3.0 sensor interface
Date:   Mon,  7 Aug 2023 11:48:10 +0200
Message-ID: <20230807094940.329165-2-jstephan@baylibre.com>
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

From: Louis Kuo <louis.kuo@mediatek.com>

This adds the bindings, for the mediatek ISP3.0 SENINF module embedded in
some Mediatek SoC, such as the mt8365

Signed-off-by: Louis Kuo <louis.kuo@mediatek.com>
Signed-off-by: Phi-Bang Nguyen <pnguyen@baylibre.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 .../media/mediatek,mt8365-seninf.yaml         | 259 ++++++++++++++++++
 MAINTAINERS                                   |   7 +
 2 files changed, 266 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mt8365-seninf.yaml

diff --git a/Documentation/devicetree/bindings/media/mediatek,mt8365-seninf.yaml b/Documentation/devicetree/bindings/media/mediatek,mt8365-seninf.yaml
new file mode 100644
index 000000000000..0a7b7d949df7
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/mediatek,mt8365-seninf.yaml
@@ -0,0 +1,259 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (c) 2023 MediaTek, BayLibre
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/mediatek,mt8365-seninf.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek Sensor Interface 3.0
+
+maintainers:
+  - Laurent Pinchart <laurent.pinchart@ideasonboard.com>
+  - Julien Stephan <jstephan@baylibre.com>
+  - Andy Hsieh <andy.hsieh@mediatek.com>
+
+description:
+  The ISP3.0 SENINF is the CSI-2 and parallel camera sensor interface found in
+  multiple MediaTek SoCs. It can support up to three physical CSI-2
+  input ports, configured in DPHY (2 or 4 data lanes) or CPHY depending on the soc.
+  On the output side, SENINF can be connected either to CAMSV instance or
+  to the internal ISP. CAMSV is used to bypass the internal ISP processing
+  in order to connect either an external ISP, or a sensor (RAW, YUV).
+
+properties:
+  compatible:
+    const: mediatek,mt8365-seninf
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Seninf camsys clock
+      - description: Seninf top mux clock
+
+  clock-names:
+    items:
+      - const: camsys
+      - const: top_mux
+
+  phys:
+    minItems: 1
+    maxItems: 4
+    description:
+      phandle to the PHYs connected to CSI0/A, CSI1, CSI2 and CSI0B
+
+  phy-names:
+    minItems: 1
+    items:
+      - const: csi0
+      - const: csi1
+      - const: csi2
+      - const: csi0b
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        description: CSI0 or CSI0A port
+
+        properties:
+          endpoint:
+            $ref: video-interfaces.yaml#
+            unevaluatedProperties: false
+
+            properties:
+              clock-lanes:
+                maxItems: 1
+              data-lanes:
+                minItems: 1
+                maxItems: 4
+
+      port@1:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        description: CSI1 port
+
+        properties:
+          endpoint:
+            $ref: video-interfaces.yaml#
+            unevaluatedProperties: false
+
+            properties:
+              clock-lanes:
+                maxItems: 1
+              data-lanes:
+                minItems: 1
+                maxItems: 4
+
+      port@2:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        description: CSI2 port
+
+        properties:
+          endpoint:
+            $ref: video-interfaces.yaml#
+            unevaluatedProperties: false
+
+            properties:
+              clock-lanes:
+                maxItems: 1
+              data-lanes:
+                minItems: 1
+                maxItems: 4
+
+      port@3:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        description: CSI0B port
+
+        properties:
+          endpoint:
+            $ref: video-interfaces.yaml#
+            unevaluatedProperties: false
+
+            properties:
+              clock-lanes:
+                maxItems: 1
+              data-lanes:
+                minItems: 1
+                maxItems: 2
+
+      port@4:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: connection point for cam0
+
+      port@5:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: connection point for cam1
+
+      port@6:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: connection point for camsv0
+
+      port@7:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: connection point for camsv1
+
+      port@8:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: connection point for camsv2
+
+      port@9:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: connection point for camsv3
+
+    required:
+      - port@0
+      - port@1
+      - port@2
+      - port@3
+      - port@4
+      - port@5
+      - port@6
+      - port@7
+      - port@8
+      - port@9
+
+required:
+  - compatible
+  - interrupts
+  - clocks
+  - clock-names
+  - power-domains
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mediatek,mt8365-clk.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/phy/phy.h>
+    #include <dt-bindings/power/mediatek,mt8365-power.h>
+
+    soc {
+          #address-cells = <2>;
+          #size-cells = <2>;
+
+          seninf: seninf@15040000 {
+                compatible = "mediatek,mt8365-seninf";
+                reg = <0 0x15040000 0 0x6000>;
+                interrupts = <GIC_SPI 210 IRQ_TYPE_LEVEL_LOW>;
+                clocks = <&camsys CLK_CAM_SENIF>,
+                         <&topckgen CLK_TOP_SENIF_SEL>;
+                clock-names = "camsys", "top_mux";
+
+                power-domains = <&spm MT8365_POWER_DOMAIN_CAM>;
+
+                phys = <&mipi_csi0 PHY_TYPE_DPHY>;
+                phy-names = "csi0";
+
+                ports {
+                      #address-cells = <1>;
+                      #size-cells = <0>;
+
+                      port@0 {
+                            reg = <0>;
+                            seninf_in1: endpoint {
+                              clock-lanes = <2>;
+                              data-lanes = <1 3 0 4>;
+                              remote-endpoint = <&isp1_out>;
+                            };
+                      };
+
+                      port@1 {
+                          reg = <1>;
+                      };
+
+                      port@2 {
+                            reg = <2>;
+                      };
+
+                      port@3 {
+                            reg = <3>;
+                      };
+
+                      port@4 {
+                            reg = <4>;
+                            seninf_camsv1_endpoint: endpoint {
+                                remote-endpoint = <&camsv1_endpoint>;
+                            };
+                      };
+
+                      port@5 {
+                            reg = <5>;
+                      };
+
+                      port@6 {
+                            reg = <6>;
+                      };
+
+                      port@7 {
+                            reg = <7>;
+                      };
+
+                      port@8 {
+                            reg = <8>;
+                      };
+
+                      port@9 {
+                            reg = <9>;
+                      };
+
+                };
+          };
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index f14c1807067e..2997ec387cc0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13359,6 +13359,13 @@ M:	Sean Wang <sean.wang@mediatek.com>
 S:	Maintained
 F:	drivers/char/hw_random/mtk-rng.c
 
+MEDIATEK ISP3.0 DRIVER
+M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
+M:	Julien Stephan <jstephan@baylibre.com>
+M:	Andy Hsieh <andy.hsieh@mediatek.com>
+S:	Supported
+F:	Documentation/devicetree/bindings/media/mediatek,mt8365-seninf.yaml
+
 MEDIATEK SMI DRIVER
 M:	Yong Wu <yong.wu@mediatek.com>
 L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
-- 
2.41.0

