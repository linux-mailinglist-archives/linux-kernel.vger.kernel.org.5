Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB8077E019
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 13:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244445AbjHPLOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 07:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244106AbjHPLNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 07:13:48 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99078E40;
        Wed, 16 Aug 2023 04:13:47 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3a412653335so4753913b6e.1;
        Wed, 16 Aug 2023 04:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692184426; x=1692789226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eY8kZ4eK5YIGKyTtQTf6aWVK8SyC/JpmCdjMfNKZmx0=;
        b=lfQ6GpJ4NFcIljhwEgFCU8ohpMgZnJAr4SwUtWG1fNHZHK1FvvC3kSclpw98bv8q3w
         usgQqJ/LtlZ5THn24bHVa+TRoeWCi3CHZ77gsz6EM7mtJu9EVZok0WS0YbudcUpH0ztT
         EUliPlyFTWmSqDlOl8bWWYURHPqUaALmQdJvOvJoWXG24f+j8d9ekWU93rwDb6Y5tXY3
         bnvgo1KQtNQ1EXVsQH2uVp/i4AoCoqB5QrioIrNP9vyX4PWVwYn/lgcdMPQLCGZ+WcQL
         RS/hT+TEzdrIt6jPcOrcQMYrYNWg/2mMnR2jFuIJpOi+sphuyJIzNuUVYzsYeREtci+8
         xrxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692184426; x=1692789226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eY8kZ4eK5YIGKyTtQTf6aWVK8SyC/JpmCdjMfNKZmx0=;
        b=GbcXwTPH3fw+6XaisG9qdsj5y3akPpeA8IFQaeWqwDom2vIkyxgkp9sPER7jKgKz1/
         pGc9OiC1Vu4/HgtaDPJnhPaoBX9yUgNAlFcUft3SIyeQ53zgXO/JOIUWlqV+A7pv75Y8
         9oz2EP4Bl7kXqXJtiO8TdVtZbh570iVaCz5SUrO6AQMiFHRuEPUrwM5MZLANxsABn+b9
         vF8jRkAByGvJoSqNF1wVGR31wiSHm/ldf4rezbx7C76jOV2LQoLQsA34YecBYlP3HMS6
         onRF0OPx4Q9d7aAjhCngZew3DGguje0BzKVGq+XjkaYnLA31QyLFkBS9tI2jWvaVUZFu
         xlug==
X-Gm-Message-State: AOJu0YxJ6GWGY3+quQ0lYdAhSm2PYbpJ7DHa518DIqAgs6cff6SXaBZN
        vB77CenmkJKQVJsRvns3Er36E/DvDV7mSOOi
X-Google-Smtp-Source: AGHT+IFtNVqola0L7NRwZI+SnDJY+qmciey+S8mI5MeQ2DioVcESMDTnr3DjLWxNNQCcZFJEellvWw==
X-Received: by 2002:a05:6808:1897:b0:3a7:146d:85b9 with SMTP id bi23-20020a056808189700b003a7146d85b9mr2101909oib.39.1692184426492;
        Wed, 16 Aug 2023 04:13:46 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.. ([38.114.108.131])
        by smtp.gmail.com with ESMTPSA id r8-20020a638f48000000b00563e1ef0491sm11750627pgn.8.2023.08.16.04.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 04:13:46 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH v2 2/4] dt-bindings: net: Add Loongson-1 DWMAC glue layer
Date:   Wed, 16 Aug 2023 19:13:08 +0800
Message-Id: <20230816111310.1656224-3-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230816111310.1656224-1-keguang.zhang@gmail.com>
References: <20230816111310.1656224-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding document for Loongson-1 DWMAC glue layer.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
V1 -> V2: Fix "clock-names" and "interrupt-names" property
          Rename the syscon property to "loongson,dwmac-syscon"
          Drop "phy-handle" and "phy-mode" requirement
          Revert adding loongson,ls1b-dwmac/loongson,ls1c-dwmac
          to snps,dwmac.yaml

 .../bindings/net/loongson,ls1x-dwmac.yaml     | 98 +++++++++++++++++++
 1 file changed, 98 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/loongson,ls1x-dwmac.yaml

diff --git a/Documentation/devicetree/bindings/net/loongson,ls1x-dwmac.yaml b/Documentation/devicetree/bindings/net/loongson,ls1x-dwmac.yaml
new file mode 100644
index 000000000000..cf5477450e29
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/loongson,ls1x-dwmac.yaml
@@ -0,0 +1,98 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/loongson,ls1x-dwmac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Loongson-1 DWMAC glue layer
+
+maintainers:
+  - Keguang Zhang <keguang.zhang@gmail.com>
+
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - loongson,ls1b-dwmac
+          - loongson,ls1c-dwmac
+  required:
+    - compatible
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - loongson,ls1b-dwmac
+          - loongson,ls1c-dwmac
+      - const: snps,dwmac-3.50a
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: stmmaceth
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    items:
+      - const: macirq
+
+  loongson,dwmac-syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the syscon containing some extra configurations
+      including PHY interface mode.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+  - interrupt-names
+  - loongson,dwmac-syscon
+
+allOf:
+  - $ref: snps,dwmac.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/loongson,ls1x-clk.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    gmac0: ethernet@1fe10000 {
+        compatible = "loongson,ls1b-dwmac", "snps,dwmac-3.50a";
+        reg = <0x1fe10000 0x10000>;
+
+        clocks = <&clkc LS1X_CLKID_AHB>;
+        clock-names = "stmmaceth";
+
+        interrupt-parent = <&intc1>;
+        interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "macirq";
+
+        loongson,dwmac-syscon = <&syscon>;
+
+        phy-handle = <&phy0>;
+        phy-mode = "mii";
+        snps,pbl = <1>;
+
+        mdio {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            compatible = "snps,dwmac-mdio";
+
+            phy0: ethernet-phy@0 {
+                reg = <0x0>;
+            };
+        };
+    };
-- 
2.39.2

