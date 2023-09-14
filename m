Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D69AC7A02F1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 13:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236988AbjINLpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 07:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235161AbjINLpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 07:45:16 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE799B;
        Thu, 14 Sep 2023 04:45:12 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bdf4752c3cso6319715ad.2;
        Thu, 14 Sep 2023 04:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694691911; x=1695296711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pYIitMx9g3MKpxiS3F1EWy6vcHj1Wu+TNRC6xmRdLjk=;
        b=IZBzX8ZidbxoFreVJap+2hqnscH2X31MkgLhfxAs3zhdTh4Tzl+huHFpaWY6tSPgU8
         bRWojsV9gQrf0OEhq+xuZAElZ3IeBralyyQRMVCsSnAfHlpkFfOxcnOGRvo55BjYnH0Y
         KqAPodxKoYFgj4cUOCPnuFA02rZvPOxfLkOhT8TP2WeqvQCFT7U2CgGEziqkgsZHlCNR
         REq8TAwJc/YoBFqbDxI2K0H2WKFBXMknyM+L79hmpiLlm7YvNP/qYJKUyZmU/lwCnBVO
         EfK0h5zUmEyD2ZG9PdqS8lSDrGqdwSa0V1SEXCg+S61LMawjFHnSi0Zhfaihd0gg2KRc
         YL7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694691911; x=1695296711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pYIitMx9g3MKpxiS3F1EWy6vcHj1Wu+TNRC6xmRdLjk=;
        b=lj19pUlEg0X7p7CyPkVZsaYXzwtUV4cYP4kN3hfHRf657vRef53z1KRnf83Mol2MM4
         +iZ81AbQxZ4gNeh/WVTpKR8MeCpyTagM5BkxVon/mE2W2Yb5XxYtALwYcP5t3YuoVBjG
         /nvdfFL43Q1ghcl0LMH/P0n9Z6DHVUYgd1E/ewjtEqwmU3f5x4tgJDZ4GVyD5ez1CLq9
         bBaA7PyzGok3zhRC9UIkbj5CG3mqnnEr056FtzkXkvOsvAEk5Nx7TSQiaXXaY4mQQ8/Q
         fdc4Q/XfS1IXI2Dj10PrPuanwlOnOAwZFn1nCTX+yZlOO9BENWNPFMcTfkGA/Q12dnve
         qZfg==
X-Gm-Message-State: AOJu0YzhWrV4CiXPAYva8VNE4bl4UOOJhakpdR4GEsBTPMRnqhQPgine
        50rTYHn1CZ6obe3nYFd7Uo8oYVrD/lWUmg==
X-Google-Smtp-Source: AGHT+IEeuLsJdRCBypNKfaXJMua48b0JwNy+CJ8LJDQvgu1jV8UPq4iXOSAghw93jn98+c0wMFnpdw==
X-Received: by 2002:a17:902:7242:b0:1c1:f27e:a55a with SMTP id c2-20020a170902724200b001c1f27ea55amr5022262pll.46.1694691911280;
        Thu, 14 Sep 2023 04:45:11 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.lan ([103.184.129.7])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902748c00b001b9cea4e8a2sm1388570pll.293.2023.09.14.04.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 04:45:10 -0700 (PDT)
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
Subject: [PATCH v5 2/3] dt-bindings: net: Add Loongson-1 Ethernet Controller
Date:   Thu, 14 Sep 2023 19:44:34 +0800
Message-Id: <20230914114435.481900-3-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230914114435.481900-1-keguang.zhang@gmail.com>
References: <20230914114435.481900-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding document for Loongson-1 Ethernet controller.
And modify MAINTAINERS to add a new F: entry for
Loongson1 dt-binding documents.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
V4 -> V5: Add a new F: entry for Loongson1 dt-binding documents
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
 MAINTAINERS                                   |   1 +
 3 files changed, 228 insertions(+)
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
diff --git a/MAINTAINERS b/MAINTAINERS
index fa7487b7729b..e514b53fb225 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14379,6 +14379,7 @@ MIPS/LOONGSON1 ARCHITECTURE
 M:	Keguang Zhang <keguang.zhang@gmail.com>
 L:	linux-mips@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/*/loongson,ls1*.yaml
 F:	arch/mips/include/asm/mach-loongson32/
 F:	arch/mips/loongson32/
 F:	drivers/*/*loongson1*
-- 
2.39.2

