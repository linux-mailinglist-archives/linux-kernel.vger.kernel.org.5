Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6577F14B7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 14:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbjKTNv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 08:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbjKTNvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 08:51:20 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCEA116;
        Mon, 20 Nov 2023 05:51:16 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4084de32db5so19083985e9.0;
        Mon, 20 Nov 2023 05:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700488275; x=1701093075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mDe+pQVEhH3Sr9b4984YEcBYZXzy8ixz3G1rWEEdZm8=;
        b=G9XHnbFtyXO/Q9ohweCu+fSUhIFx9cm7Ka51CQ21tkCLQwZl//z0nhWiaYaQmPwkBm
         TpjQJB/fSOO+shR7YHd7qyWdgcLfRc3PDUYQtjW8T2u9CapDnKje552Xc/xfBP82jmCP
         a4oOLWlfpTDCGTj91bhakUjy8DO22Spc8arm9j5xdfPThEmxZRCtAJzklGJvOS/hbbXg
         6B+v/MyKLz16RBcpw0HlK32w9MddlGDvzsIyCtlyKzoy8bZlkkNI+idefexwcLBhunjN
         UCf/i8Upbd4S7hrV8pgS/A8veQt3MCxm+0mjdOmdF03Jzz4GRUIMLWVIHd9ua4DP+Sdz
         SZUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700488275; x=1701093075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mDe+pQVEhH3Sr9b4984YEcBYZXzy8ixz3G1rWEEdZm8=;
        b=BOAx2JpRIXlZJe6Siujm0q9rA5+cK8fcb0oebvrSsNgAHQI6AMeqxaE3vCJsrPPkXu
         tGBcLvmxGv3wlvdt45PcUA3W2wZHMClXyK5qK3KQHKuIEH+E6iUGAZusiUuI1rf37OBi
         W/7uTRIqSRjsDVHBK8gQ8k39RVnrmlxW3jpC4rI4ppIyB7Bd2gzW7aV9YHoUxDM12Oil
         CzemwA3a1E1dZD/XCQ1JYkPPFaK3769GLvNcOLoIQvCDZxOppphmLtf6lrfksVxGFd5c
         Z5jc5GCGaMa5Oi7ckEOnhnDWB51YOhjbGzKewa9S3nl2DSAgu/C3Geqdak+Zwy35X8MK
         YD3Q==
X-Gm-Message-State: AOJu0YxREjsbdmwv4FWLZ+oxwIiKgmd9m79sYhKKYdlRY3F/zgRZuRTJ
        V5DQW/HR7zr03mpGtvMW7pE=
X-Google-Smtp-Source: AGHT+IHVHnzgf8EEZJbwbHrD1fJrQtGhYDQUh/AnVfNHdAOlAXGB/wAsBqejt0p1a7rxHshO7e2S9w==
X-Received: by 2002:a05:600c:5248:b0:408:3ab3:a029 with SMTP id fc8-20020a05600c524800b004083ab3a029mr6210181wmb.38.1700488274368;
        Mon, 20 Nov 2023 05:51:14 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id j33-20020a05600c1c2100b0040772934b12sm18205846wms.7.2023.11.20.05.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 05:51:14 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Qingfang Deng <dqfext@gmail.com>,
        SkyLake Huang <SkyLake.Huang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        David Epping <david.epping@missinglinkelectronics.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Harini Katakam <harini.katakam@amd.com>,
        Simon Horman <horms@kernel.org>,
        Robert Marko <robert.marko@sartura.hr>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [net-next RFC PATCH 02/14] dt-bindings: net: move PHY modes to common PHY mode types definition
Date:   Mon, 20 Nov 2023 14:50:29 +0100
Message-Id: <20231120135041.15259-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231120135041.15259-1-ansuelsmth@gmail.com>
References: <20231120135041.15259-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move PHY modes from ethernet-controller schema to dedicated common PHY
mode types definition. This is needed to have a centralized place to
define PHY interface mode and permit usage and reference of these modes
in other schemas.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../bindings/net/ethernet-controller.yaml     |  47 +------
 .../bindings/net/ethernet-phy-mode-types.yaml | 132 ++++++++++++++++++
 2 files changed, 133 insertions(+), 46 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/ethernet-phy-mode-types.yaml

diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.yaml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
index 9f6a5ccbcefe..40c1daff2a48 100644
--- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
@@ -55,55 +55,10 @@ properties:
     const: mac-address
 
   phy-connection-type:
+    $ref: /schemas/net/ethernet-phy-mode-types.yaml#definitions/phy-connection-type
     description:
       Specifies interface type between the Ethernet device and a physical
       layer (PHY) device.
-    enum:
-      # There is not a standard bus between the MAC and the PHY,
-      # something proprietary is being used to embed the PHY in the
-      # MAC.
-      - internal
-      - mii
-      - gmii
-      - sgmii
-      - psgmii
-      - qsgmii
-      - qusgmii
-      - tbi
-      - rev-mii
-      - rmii
-      - rev-rmii
-      - moca
-
-      # RX and TX delays are added by the MAC when required
-      - rgmii
-
-      # RGMII with internal RX and TX delays provided by the PHY,
-      # the MAC should not add the RX or TX delays in this case
-      - rgmii-id
-
-      # RGMII with internal RX delay provided by the PHY, the MAC
-      # should not add an RX delay in this case
-      - rgmii-rxid
-
-      # RGMII with internal TX delay provided by the PHY, the MAC
-      # should not add an TX delay in this case
-      - rgmii-txid
-      - rtbi
-      - smii
-      - xgmii
-      - trgmii
-      - 1000base-x
-      - 2500base-x
-      - 5gbase-r
-      - rxaui
-      - xaui
-
-      # 10GBASE-KR, XFI, SFI
-      - 10gbase-kr
-      - usxgmii
-      - 10gbase-r
-      - 25gbase-r
 
   phy-mode:
     $ref: "#/properties/phy-connection-type"
diff --git a/Documentation/devicetree/bindings/net/ethernet-phy-mode-types.yaml b/Documentation/devicetree/bindings/net/ethernet-phy-mode-types.yaml
new file mode 100644
index 000000000000..6d15743b4ffa
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/ethernet-phy-mode-types.yaml
@@ -0,0 +1,132 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/ethernet-phy-mode-types.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ethernet PHY Common Mode Types
+
+maintainers:
+  - David S. Miller <davem@davemloft.net>
+
+definitions:
+  phy-connection-type:
+    # const: "internal"
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/string
+      - oneOf:
+        # There is not a standard bus between the MAC and the PHY,
+        # something proprietary is being used to embed the PHY in the
+        # MAC.
+        - items:
+            - type: string
+              const: internal
+        - items:
+            - type: string
+              const: mii
+        - items:
+            - type: string
+              const: gmii
+        - items:
+            - type: string
+              const: sgmii
+        - items:
+            - type: string
+              const: psgmii
+        - items:
+            - type: string
+              const: qsgmii
+        - items:
+            - type: string
+              const: qusgmii
+        - items:
+            - type: string
+              const: tbi
+        - items:
+            - type: string
+              const: rev-mii
+        - items:
+            - type: string
+              const: rmii
+        - items:
+            - type: string
+              const: rev-rmii
+        - items:
+            - type: string
+              const: moca
+
+        # RX and TX delays are added by the MAC when required
+        - items:
+            - type: string
+              const: rgmii
+
+        # RGMII with internal RX and TX delays provided by the PHY,
+        # the MAC should not add the RX or TX delays in this case
+        - items:
+            - type: string
+              const: rgmii-id
+
+        # RGMII with internal RX delay provided by the PHY, the MAC
+        # should not add an RX delay in this case
+        - items:
+            - type: string
+              const: rgmii-rxid
+
+        # RGMII with internal TX delay provided by the PHY, the MAC
+        # should not add an TX delay in this case
+        - items:
+            - type: string
+              const: rgmii-txid
+
+        - items:
+            - type: string
+              const: rtbi
+
+        - items:
+            - type: string
+              const: smii
+
+        - items:
+            - type: string
+              const: xgmii
+
+        - items:
+            - type: string
+              const: trgmii
+
+        - items:
+            - type: string
+              const: 1000base-x
+
+        - items:
+            - type: string
+              const: 2500base-x
+
+        - items:
+            - type: string
+              const: 5gbase-r
+
+        - items:
+            - type: string
+              const: rxaui
+
+        - items:
+            - type: string
+              const: xaui
+
+        # 10GBASE-KR, XFI, SFI
+        - items:
+            - type: string
+              const: 10gbase-kr
+
+        - items:
+            - type: string
+              const: usxgmii
+
+        - items:
+            - type: string
+              const: 10gbase-r
+
+        - items:
+            - type: string
+              const: 25gbase-r
-- 
2.40.1

