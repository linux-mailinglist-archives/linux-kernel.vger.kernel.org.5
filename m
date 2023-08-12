Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7970977A0BB
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 17:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbjHLPMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 11:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbjHLPMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 11:12:18 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A761BFC;
        Sat, 12 Aug 2023 08:12:21 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-268030e1be7so1607102a91.3;
        Sat, 12 Aug 2023 08:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691853140; x=1692457940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3/iziWyfIEDBODF3dYR9bJqy9Xme/VXIWSVPfKLpUtA=;
        b=f0FDJcqWXwa9fv7btMtVYtLAWsARkk1yBVb2Xptl+LO2npbaQLZwocoTxp719dfNSN
         1yMT6l2qhenTuBfx2YGlK2PoNtGsBTHF5WmMdcawWRl3r7u1Iy+xaDeodHhxRVpEh+qm
         P4MfsLL9+FkzeMv3QxyGCt3wXLaJzd4Zs8TY5HNGlA0/sErSZN+PIHPxdyeL2y4q4g42
         XgMFR2fG5Dep6y/swBCgmyv6nTBz03Z+EXY3d0HCV60AIfvEW8mmmTjUbPvluvUuKZd2
         XtqyFo0fMhkJtnqq25BVB3NYDslt+Y91Dx25PgeEuLAWREoH7reHCaNzJDBmyFezqtXV
         3Muw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691853140; x=1692457940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3/iziWyfIEDBODF3dYR9bJqy9Xme/VXIWSVPfKLpUtA=;
        b=BNWQxtuDPKUwZsfk+jNMf9rGMCSZ7/Xnz6j+eTkKxh2axidFye2Yo9wRr6f3UhnJPo
         gD5o6CEJ6eNp6T4LqiFhc4TjAAd1+ljmEpwAe+zL8dfz1s7tHDI0LJq63y1wnB4zcyRj
         NvLTJbEV0salzEg+RYA/GAng1HB8zZpztqt9OvO9rFjkH/xZS0ZwX5GY0JxXH2vtW/Ch
         4J+yLVgMyqB1Sil02yVimuMidwJrFKw06o0u9e4fK9Tx1DTshqmuMwBnEx9h+MRTBc9x
         B128ouP7rIAEjtWsy0OZI7cWmtft5ucTUftHk11qMznQU8KnkkwPbCDU9hKGACVe2fie
         jOqQ==
X-Gm-Message-State: AOJu0YyfNsBmRGijHG8VyL2+yLZ7O4XnPcispWXu+K4QcNIk5knOPy+Y
        6c8FRdFkMt1BHWQmU03Ba7FbjPjCb3JIM79C
X-Google-Smtp-Source: AGHT+IEEXNH13zLswghnUouJ6Io1nSFnOQ8dENneyU8Wne2HfffGwtswOnHsjzvgFRqbcKL+b3pRNQ==
X-Received: by 2002:a17:90a:4304:b0:26b:9e2:1298 with SMTP id q4-20020a17090a430400b0026b09e21298mr2715618pjg.11.1691853140458;
        Sat, 12 Aug 2023 08:12:20 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.. ([38.114.108.131])
        by smtp.gmail.com with ESMTPSA id 17-20020a17090a195100b0026b41363887sm1040927pjh.27.2023.08.12.08.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 08:12:20 -0700 (PDT)
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
Subject: [PATCH 3/5] dt-bindings: net: Add Loongson-1 DWMAC glue layer
Date:   Sat, 12 Aug 2023 23:11:33 +0800
Message-Id: <20230812151135.1028780-4-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230812151135.1028780-1-keguang.zhang@gmail.com>
References: <20230812151135.1028780-1-keguang.zhang@gmail.com>
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
 .../bindings/net/loongson,ls1x-dwmac.yaml     | 98 +++++++++++++++++++
 .../devicetree/bindings/net/snps,dwmac.yaml   |  2 +
 2 files changed, 100 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/loongson,ls1x-dwmac.yaml

diff --git a/Documentation/devicetree/bindings/net/loongson,ls1x-dwmac.yaml b/Documentation/devicetree/bindings/net/loongson,ls1x-dwmac.yaml
new file mode 100644
index 000000000000..150799460599
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
+    const: stmmaceth
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    const: macirq
+
+  syscon:
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
+  - phy-handle
+  - phy-mode
+  - syscon
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
+        phy-handle = <&phy0>;
+        phy-mode = "mii";
+
+        snps,pbl = <1>;
+        syscon = <&syscon>;
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
diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index ddf9522a5dc2..e1a956cf171e 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -66,6 +66,8 @@ properties:
         - ingenic,x2000-mac
         - loongson,ls2k-dwmac
         - loongson,ls7a-dwmac
+        - loongson,ls1b-dwmac
+        - loongson,ls1c-dwmac
         - qcom,qcs404-ethqos
         - qcom,sa8775p-ethqos
         - qcom,sc8280xp-ethqos
-- 
2.39.2

