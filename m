Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01E178D8FE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbjH3Sb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244686AbjH3NnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 09:43:05 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1393EA4;
        Wed, 30 Aug 2023 06:43:03 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c1e3a4a06fso20986105ad.3;
        Wed, 30 Aug 2023 06:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693402982; x=1694007782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ItK58ZERlprQfWi7Rw1Xc+3SvWmEiPXawNp7IWBkfM=;
        b=FK6uGIYCmfhTpdsQLrXk7lYb5JCfvorIB3sSoNKP2u7S7GUbhU8ouweFVvbgLdkF1U
         9CsqA4j2+GdpFgazq4Eod8qgGR2iUXJeyHuCE4yg7QT0wT4QW2PjJspsvgMpMHOAf0sD
         ucH+v51Zy7HSE/Oid6id4BIyHtSRfP8LLUg767UYI6xBTlC/1vRQoEiJZI/OGWNw7JWC
         weQwdrmUyIUFcQHp5DYiEpJq1TwPZX5o1FobyZIkD4hKe9wS3YPlLHRLd7Y6LOS5nv8X
         huYazoxZjrbngqczAELGDcv1VCBsQK7GN5RGFK0hMqlt48wpZo9kdslVOqO8S7YHEeEI
         bs9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693402982; x=1694007782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ItK58ZERlprQfWi7Rw1Xc+3SvWmEiPXawNp7IWBkfM=;
        b=eMk7eEDppwvf2d+uVF6P5LNKJoP43eoY7ODig7+T/3JFzQlaBtVxm2J2O1pS3w4awU
         y6IeWFYyA48Pzc9wnIYFILwtVUEOX3FvC45fxfkF0oOU103kHdZorGyFcYpU79elHaNJ
         eTF3Hbt1xgc++GgB8hd6223RD5ODZQNy8pXTOPAUZRvzxfg1Az+TVm3w4YykZl0SxJ4O
         Ca2nDytdLLTSE/VhUZc2wh7SlH1xz3Tk5jjIRPLFCeEkciFEXq0qkUdI5uhMzyJxzh9j
         lvf7FV3d1/DDzs43WLDijbuwnFqVVEQnO5WnYyMeY1XFR7BRT3HOg+ckvYhmdarAtcK4
         lG9g==
X-Gm-Message-State: AOJu0YycjEcFQxjWv8oJ6LGP5n3RTNxfeOCfRJsi+HWeS5f+SVzQxFOS
        sAklbRtGl0wnWyvf86yoWD/Hh+KxLuQ7jwYh
X-Google-Smtp-Source: AGHT+IF1rdtWek9HyaQrG+F4oXo8P1Ok9UNJw67NeujqtOe46AZclR88y7ES7gbN+7xx6yErUBZmNA==
X-Received: by 2002:a17:902:7481:b0:1bb:e74b:39ff with SMTP id h1-20020a170902748100b001bbe74b39ffmr2095299pll.0.1693402982133;
        Wed, 30 Aug 2023 06:43:02 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.lan ([103.184.129.7])
        by smtp.gmail.com with ESMTPSA id a11-20020a170902eccb00b001b86dd825e7sm11042280plh.108.2023.08.30.06.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 06:43:01 -0700 (PDT)
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
        Keguang Zhang <keguang.zhang@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 2/4] dt-bindings: net: Add Loongson-1 Ethernet Controller
Date:   Wed, 30 Aug 2023 21:42:39 +0800
Message-Id: <20230830134241.506464-3-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230830134241.506464-1-keguang.zhang@gmail.com>
References: <20230830134241.506464-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding document for Loongson-1 Ethernet controller.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
V3 -> V4: Add "|" to description part
          Amend "phy-mode" property
V2 -> V3: Split the DT-schema file into loongson,ls1b-gmac.yaml
          and loongson,ls1c-emac.yaml (suggested by Serge Semin)
          Change the compatibles to loongson,ls1b-gmac and loongson,ls1c-emac
          Rename loongson,dwmac-syscon to loongson,ls1-syscon
          Amend the title
          Add description
          Add Reviewed-by tag from Krzysztof Kozlowski(Sorry! I'm not sure)
V1 -> V2: Fix "clock-names" and "interrupt-names" property
          Rename the syscon property to "loongson,dwmac-syscon"
          Drop "phy-handle" and "phy-mode" requirement
          Revert adding loongson,ls1b-dwmac/loongson,ls1c-dwmac
          to snps,dwmac.yaml

 .../bindings/net/loongson,ls1b-gmac.yaml      | 114 ++++++++++++++++++
 .../bindings/net/loongson,ls1c-emac.yaml      | 113 +++++++++++++++++
 2 files changed, 227 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/loongson,ls1b-gmac.yaml
 create mode 100644 Documentation/devicetree/bindings/net/loongson,ls1c-emac.yaml

diff --git a/Documentation/devicetree/bindings/net/loongson,ls1b-gmac.yaml b/Documentation/devicetree/bindings/net/loongson,ls1b-gmac.yaml
new file mode 100644
index 000000000000..c4f3224bad38
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/loongson,ls1b-gmac.yaml
@@ -0,0 +1,114 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/loongson,ls1b-gmac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Loongson-1B Gigabit Ethernet MAC Controller
+
+maintainers:
+  - Keguang Zhang <keguang.zhang@gmail.com>
+
+description: |
+  Loongson-1B Gigabit Ethernet MAC Controller is based on
+  Synopsys DesignWare MAC (version 3.50a).
+
+  Main features
+  - Dual 10/100/1000Mbps GMAC controllers
+  - Full-duplex operation (IEEE 802.3x flow control automatic transmission)
+  - Half-duplex operation (CSMA/CD Protocol and back-pressure support)
+  - RX Checksum Offload
+  - TX Checksum insertion
+  - MII interface
+  - RGMII interface
+
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - loongson,ls1b-gmac
+  required:
+    - compatible
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - loongson,ls1b-gmac
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
+  loongson,ls1-syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the syscon containing some extra configurations
+      including PHY interface mode.
+
+  phy-mode:
+    enum:
+      - mii
+      - rgmii-id
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+  - interrupt-names
+  - loongson,ls1-syscon
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
+        compatible = "loongson,ls1b-gmac", "snps,dwmac-3.50a";
+        reg = <0x1fe10000 0x10000>;
+
+        clocks = <&clkc LS1X_CLKID_AHB>;
+        clock-names = "stmmaceth";
+
+        interrupt-parent = <&intc1>;
+        interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "macirq";
+
+        loongson,ls1-syscon = <&syscon>;
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
diff --git a/Documentation/devicetree/bindings/net/loongson,ls1c-emac.yaml b/Documentation/devicetree/bindings/net/loongson,ls1c-emac.yaml
new file mode 100644
index 000000000000..99001b940b83
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/loongson,ls1c-emac.yaml
@@ -0,0 +1,113 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/loongson,ls1c-emac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Loongson-1C Ethernet MAC Controller
+
+maintainers:
+  - Keguang Zhang <keguang.zhang@gmail.com>
+
+description: |
+  Loongson-1C Ethernet MAC Controller is based on
+  Synopsys DesignWare MAC (version 3.50a).
+
+  Main features
+  - 10/100Mbps
+  - Full-duplex operation (IEEE 802.3x flow control automatic transmission)
+  - Half-duplex operation (CSMA/CD Protocol and back-pressure support)
+  - IEEE 802.1Q VLAN tag detection for reception frames
+  - MII interface
+  - RMII interface
+
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - loongson,ls1c-emac
+  required:
+    - compatible
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - loongson,ls1c-emac
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
+  loongson,ls1-syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the syscon containing some extra configurations
+      including PHY interface mode.
+
+  phy-mode:
+    enum:
+      - mii
+      - rmii
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+  - interrupt-names
+  - loongson,ls1-syscon
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
+    emac: ethernet@1fe10000 {
+        compatible = "loongson,ls1c-emac", "snps,dwmac-3.50a";
+        reg = <0x1fe10000 0x10000>;
+
+        clocks = <&clkc LS1X_CLKID_AHB>;
+        clock-names = "stmmaceth";
+
+        interrupt-parent = <&intc1>;
+        interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "macirq";
+
+        loongson,ls1-syscon = <&syscon>;
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
+            phy0: ethernet-phy@13 {
+                reg = <0x13>;
+            };
+        };
+    };
-- 
2.39.2

