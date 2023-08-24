Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 061A7786FA5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 14:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241287AbjHXMv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 08:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241108AbjHXMuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 08:50:55 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5002CD0;
        Thu, 24 Aug 2023 05:50:52 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bc63ef9959so52273475ad.2;
        Thu, 24 Aug 2023 05:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692881452; x=1693486252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WUXscSapF9yGyR5ril9a18hQD4+b8Ok8ZJpFPuWKi8s=;
        b=KSx8Ak4b1VIS6QGZC5sHaLiSi94U4eEHlRE6nxttTgYzEtAdBO4DtAiXzaED3E36TZ
         ZcEioTzigs+ojfl0fse4RG6f1SYbfYmtE7QmGQfodPAMJBBRQUikDSqYadeZ0jScqTAn
         VPWf/BcitOg6H/KzaVk3BgKIvT8tgx0KgWfgAmrh62HLZO7bzNbL4ITZ/q7UA78hrqH9
         BYQAsfPwSMgH0rlkvBLNIhkSmNjKtMafjpmOeSFUTwiJ5sezaShx07hzQ2X6Ppt9LpuU
         rB4PDSCDP03mDoArJRNQcdE9c7Z9Isgl0fga8TtKzqkfiyH/4Dee6HFKAjXWkgSy1+Ir
         mxrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692881452; x=1693486252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WUXscSapF9yGyR5ril9a18hQD4+b8Ok8ZJpFPuWKi8s=;
        b=IeMi53vipn5poQ24kBUMOXofhGXh36dZhRVewKyuasrua3KoTl0K2+TDjzw3PzEesb
         Cb3NkILlmPAQ5IQtcGKeJYMqUaOnP7OHdz6YpJM5QZsuFg5WMqPdhkeCQylvkySHHqxX
         BzPF5hqFgg8p9LF64PlQ1z4EzHxCN9bNbCLhQGE+1HfAvmIY/4NeUw+Wx539ur38/EC+
         anvNzn81u2amO4cYQihZXLUogU6BgjKY3JM2oRBKlwHaqNloC0keVjLplGE8PqQbLuo/
         lvi/vt4cxJKmR3usHbvZp8ElkB1lH0JriGqNMBJ/tQ/xNusznQjJIYwg7lHf+uCui0Zf
         AsMA==
X-Gm-Message-State: AOJu0YyoQMlqKp+dD1V3OiDX7KiCXKEf54ABR1uG17JbZHGz5CiLDZLu
        n/TnuDG/7ZKKy5TErJPVnoZXiExG5PsOdh5J
X-Google-Smtp-Source: AGHT+IFyXMoHbZwQKpothocwplbnduuSnD772GzGJmdhqm+QCGN0yBbigjTudUUHmLan3m4uRc+nmQ==
X-Received: by 2002:a17:902:c411:b0:1bf:73ec:b977 with SMTP id k17-20020a170902c41100b001bf73ecb977mr17424627plk.46.1692881451760;
        Thu, 24 Aug 2023 05:50:51 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.lan ([103.184.129.7])
        by smtp.gmail.com with ESMTPSA id 19-20020a170902c11300b001afd821c057sm12837295pli.58.2023.08.24.05.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 05:50:51 -0700 (PDT)
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
Subject: [PATCH v3 2/4] dt-bindings: net: Add Loongson-1 Ethernet Controller
Date:   Thu, 24 Aug 2023 20:50:10 +0800
Message-Id: <20230824125012.1040288-3-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230824125012.1040288-1-keguang.zhang@gmail.com>
References: <20230824125012.1040288-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
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

 .../bindings/net/loongson,ls1b-gmac.yaml      | 115 ++++++++++++++++++
 .../bindings/net/loongson,ls1c-emac.yaml      | 114 +++++++++++++++++
 2 files changed, 229 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/loongson,ls1b-gmac.yaml
 create mode 100644 Documentation/devicetree/bindings/net/loongson,ls1c-emac.yaml

diff --git a/Documentation/devicetree/bindings/net/loongson,ls1b-gmac.yaml b/Documentation/devicetree/bindings/net/loongson,ls1b-gmac.yaml
new file mode 100644
index 000000000000..f661d5b86649
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/loongson,ls1b-gmac.yaml
@@ -0,0 +1,115 @@
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
+description:
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
+    items:
+      - enum:
+          - mii
+          - rgmii-id
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
index 000000000000..1ffad41941bf
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/loongson,ls1c-emac.yaml
@@ -0,0 +1,114 @@
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
+description:
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
+    items:
+      - enum:
+          - mii
+          - rmii
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

