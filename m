Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F5D7F14DE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 14:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbjKTNwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 08:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233448AbjKTNvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 08:51:42 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42EB010F2;
        Mon, 20 Nov 2023 05:51:33 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4083f613275so17334675e9.2;
        Mon, 20 Nov 2023 05:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700488291; x=1701093091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4oWbW7U8hDbK7k3dW8cQqnctME3Rpq10CqBR82g551s=;
        b=CzzUKVvmkp5BfeDYesxJl1FL4w+Ld41Uvsk5nB2hPADF7Ge85QruVFbx1twhJmSgeX
         QSInIKpAo5xdDnnhWz3ey5LgYginkJvC6sNiGxGXlwjYYMHun2WOp4fwUo/f34CgIA7q
         orcaIzGoeF9brek8CDaWlWI5G+B+hVwmM0lK5waaZd4gts+EvslyHP06BD23fdAM9I4S
         3cmnikIEUZ19yu7ldoZ0xMmwVhtKlv3APVx1/FVdp17bD7R1eImu0K7Kzk58gMq89Sn3
         kEkLw9jYLilD5oAf+pfBPSm1b/hWdmJqHDvFQ6saTrzrecp0PRNeUlwwQG65bfdocf/P
         b6Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700488291; x=1701093091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4oWbW7U8hDbK7k3dW8cQqnctME3Rpq10CqBR82g551s=;
        b=tFOPECHW6aRuwCFNl7KZJhQewIfJwz+heV3+Awyw6JIhnpee0MSCXwo/pPzb0XxXgo
         w+RXZvciMkcPAjVSmPDNLpnVwV6PlJlLn/LivIjm0gAQiEBuXs/sXITDv4ClmwBLpUC9
         evPElXSNvUnQeYJ5T0zpM1L8VxC1nnECvtcGJ60KK/efbGbZLWUg0Y7SqIQ252dwBi4h
         IviD/hmf5eKSd5eZaRoAVx1qZ/FDs08zagDl3MlrsrLL1DcDr9IzJeqM7sTjQH2TSz7g
         pf6E6GLskaKz1pvawh104luIzawf3TjcEQLtXjJ8vEpjG2iH1rLof4Wd77uxNj7SUIdx
         824g==
X-Gm-Message-State: AOJu0YzCpiMFh7mNJZEty3AhohMmwrwh7PuXx6sAUYapHcTYL0OCtpnM
        Bc3meee2qjGCJ3eJpbLluPo=
X-Google-Smtp-Source: AGHT+IGXDhVPZ/LrxiUSncChlDmbdW69CX3+FivEfcaF6fIFK68I+CV58V07sZTeNeA90QyJl9UMSg==
X-Received: by 2002:a05:600c:4ed2:b0:405:4a78:a890 with SMTP id g18-20020a05600c4ed200b004054a78a890mr5843086wmq.8.1700488291376;
        Mon, 20 Nov 2023 05:51:31 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id j33-20020a05600c1c2100b0040772934b12sm18205846wms.7.2023.11.20.05.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 05:51:31 -0800 (PST)
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
Subject: [net-next RFC PATCH 12/14] dt-bindings: net: Document Qcom QCA807x PHY package
Date:   Mon, 20 Nov 2023 14:50:39 +0100
Message-Id: <20231120135041.15259-13-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231120135041.15259-1-ansuelsmth@gmail.com>
References: <20231120135041.15259-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document Qcom QCA807x PHY package.

Qualcomm QCA807X Ethernet PHY is PHY package of 2 or 5
IEEE 802.3 clause 22 compliant 10BASE-Te, 100BASE-TX and
1000BASE-T PHY-s.

Document the required property to make the PHY package correctly
configure and work.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../devicetree/bindings/net/qcom,qca807x.yaml | 143 ++++++++++++++++++
 1 file changed, 143 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/qcom,qca807x.yaml

diff --git a/Documentation/devicetree/bindings/net/qcom,qca807x.yaml b/Documentation/devicetree/bindings/net/qcom,qca807x.yaml
new file mode 100644
index 000000000000..c2d59068d015
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/qcom,qca807x.yaml
@@ -0,0 +1,143 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/qcom,qca807x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm QCA807X Ethernet PHY
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+  - Robert Marko <robert.marko@sartura.hr>
+
+description: |
+  Qualcomm QCA807X Ethernet PHY is PHY package of 2 or 5
+  IEEE 802.3 clause 22 compliant 10BASE-Te, 100BASE-TX and
+  1000BASE-T PHY-s.
+
+  They feature 2 SerDes, one for PSGMII or QSGMII connection with
+  MAC, while second one is SGMII for connection to MAC or fiber.
+
+  Both models have a combo port that supports 1000BASE-X and
+  100BASE-FX fiber.
+
+  Each PHY inside of QCA807x series has 4 digitally controlled
+  output only pins that natively drive LED-s for up to 2 attached
+  LEDs. Some vendor also use these 4 output for GPIO usage without
+  attaching LEDs.
+
+  Note that output pins can be set to drive LEDs OR GPIO, mixed
+  definition are not accepted.
+
+allOf:
+  - $ref: ethernet-phy-package.yaml#
+
+select:
+  properties:
+    compatible:
+      contains:
+        const: ethernet-phy-package
+  patternProperties:
+    ^ethernet-phy(@[a-f0-9]+)?$:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - ethernet-phy-id004d.d0b2
+              - ethernet-phy-id004d.d0b1
+  required:
+    - compatible
+
+properties:
+  global-phys:
+    maxItems: 2
+
+  global-phy-names:
+    items:
+      - const: combo
+      - const: pqsgmii
+
+  phy-connection-type:
+    enum:
+      - qsgmii
+      - psgmii
+
+patternProperties:
+  ^ethernet-phy(@[a-f0-9]+)?$:
+    $ref: /schemas/net/ethernet-phy.yaml#
+
+    properties:
+      gpio-controller:
+        description: set the output lines as GPIO instead of LEDs
+        type: boolean
+
+      '#gpio-cells':
+        description: number of GPIO cells for the PHY
+        const: 2
+
+    dependencies:
+      gpio-controller: ['#gpio-cells']
+
+    unevaluatedProperties: false
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/leds/common.h>
+
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethernet-phy-package {
+            compatible = "ethernet-phy-package";
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            global-phys = <&qca8075_4>, <&qca8075_psgmii>;
+            global-phy-names = "combo", "pqsgmii";
+
+            qca8075_1: ethernet-phy@1 {
+                compatible = "ethernet-phy-id004d.d0b2";
+                reg = <1>;
+
+                leds {
+                    #address-cells = <1>;
+                    #size-cells = <0>;
+
+                    led@0 {
+                        reg = <0>;
+                        color = <LED_COLOR_ID_GREEN>;
+                        function = LED_FUNCTION_LAN;
+                        default-state = "keep";
+                    };
+                };
+            };
+
+            qca8075_2: ethernet-phy@2 {
+                compatible = "ethernet-phy-id004d.d0b2";
+                reg = <2>;
+
+                gpio-controller;
+                #gpio-cells = <2>;
+            };
+
+            qca8075_3: ethernet-phy@3 {
+                compatible = "ethernet-phy-id004d.d0b2";
+                reg = <3>;
+            };
+
+            qca8075_4: ethernet-phy@4 {
+                compatible = "ethernet-phy-id004d.d0b2";
+                reg = <4>;
+            };
+
+            qca8075_pqsgmii: ethernet-phy@5 {
+                reg = <5>;
+            };
+        };
+    };
-- 
2.40.1

