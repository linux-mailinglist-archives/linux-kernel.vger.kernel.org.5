Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4C77F8748
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 01:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbjKYAf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 19:35:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbjKYAfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 19:35:30 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E253F1BD6;
        Fri, 24 Nov 2023 16:35:32 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40b27726369so17263825e9.0;
        Fri, 24 Nov 2023 16:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700872531; x=1701477331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MHiLFw1bIGohpGtROyp7CqLCgHPbQhHjoTE9dyN6vFM=;
        b=MYNoJ++WjyUQR7oZbprPpd/W1kjoOypyR9uH45lgCFTzi8SQn8ORZEswL+5aXmm0YU
         HYgj1rAMAVESk06onBC66hcftf4FzUAfYa1Wn5t0DT3Q8Ahs5qIR0uHPGMWo5M0tk18+
         gcoGszax6yWD5xsegyn9jd3F835O4D1T71iDh4woahYsrxadYdRp7RdN4P6FpX2Xl+zH
         9kJQ32xjrqoEeUzYpa4Wr7oLnadKyk7mbJaxmJls0H2vdTO6OI/jsjuLlF+tfHblXozN
         BT2+Xpn/bEwt1PXbOAzN4roL/372ceqQvgPHkysLmigGuy3ZwrqdHqdnMQPlGfYnrrxF
         KRaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700872531; x=1701477331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MHiLFw1bIGohpGtROyp7CqLCgHPbQhHjoTE9dyN6vFM=;
        b=GqCbhCC3OYeKSRmbu6RWKsfev7ffNkNqc+CJ8sMoo9OE89697BovB540sZ/lPJeDyl
         kUgG5ybSK+VAgfBWckzBJYMzqhg1sgchWAqHV3EFCvWflvNmzwDnTCngGAhyf3Nke/og
         TsaY919vRP9tk8XLo2ZTH4IJFVO4lxOlgR4qNhP7UcVBijJZtkTIQ/i3hs+9fP2GHOwA
         2JnudrjQBP6jSDwykWzR8Sg1Q0v/GSYu49gW98vmyeacwXUCuKYEoNSdMStJvuQ487QH
         oqs2SsN6ZVt399VOVKlO9Q5NqdIV1+841UWob5sXX5JG9pIoALMzIkAyr2MjtJjKNMOX
         fQKg==
X-Gm-Message-State: AOJu0YyieQ+9hMfPNbaTTiNw0GRts3VB2DYqpeqFpC7l6HxpfmL/89AG
        yxtKf+CpsW74QjIniNTsrs4=
X-Google-Smtp-Source: AGHT+IGLc1mlt385WXqXvC6FEasxlmbyfmfpQzHK0GhuUqCYjrLEyySLW33U0gTDlILd7OygLIsynA==
X-Received: by 2002:a05:600c:5252:b0:40b:36e7:1edf with SMTP id fc18-20020a05600c525200b0040b36e71edfmr3919226wmb.26.1700872531054;
        Fri, 24 Nov 2023 16:35:31 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id u13-20020a05600c00cd00b00405718cbeadsm4268005wmm.1.2023.11.24.16.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 16:35:30 -0800 (PST)
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
        Vladimir Oltean <olteanv@gmail.com>,
        David Epping <david.epping@missinglinkelectronics.com>,
        Harini Katakam <harini.katakam@amd.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Robert Marko <robert.marko@sartura.hr>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [net-next RFC PATCH v2 09/11] dt-bindings: net: Document Qcom QCA807x PHY package
Date:   Sat, 25 Nov 2023 01:11:25 +0100
Message-Id: <20231125001127.5674-10-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231125001127.5674-1-ansuelsmth@gmail.com>
References: <20231125001127.5674-1-ansuelsmth@gmail.com>
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
 .../devicetree/bindings/net/qcom,qca807x.yaml | 148 ++++++++++++++++++
 1 file changed, 148 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/qcom,qca807x.yaml

diff --git a/Documentation/devicetree/bindings/net/qcom,qca807x.yaml b/Documentation/devicetree/bindings/net/qcom,qca807x.yaml
new file mode 100644
index 000000000000..f6f07c77a639
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/qcom,qca807x.yaml
@@ -0,0 +1,148 @@
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
+    $nodename:
+      pattern: "^ethernet-phy-package(@[a-f0-9]+)?$"
+
+  patternProperties:
+    ^ethernet-phy(@[a-f0-9]+)?$:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - ethernet-phy-id004d.d0b2
+              - ethernet-phy-id004d.d0b1
+
+      required:
+        - compatible
+
+  required:
+    - $nodename
+
+properties:
+  qcom,package-mode:
+    enum:
+      - qsgmii
+      - psgmii
+
+  qcom,tx-driver-strength:
+    enum: [140, 160, 180, 200, 220
+           240, 260, 280, 300, 320
+           400, 500, 600]
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
+    if:
+      required:
+        - gpio-controller
+    then:
+      properties:
+        leds: false
+
+    unevaluatedProperties: false
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
+        ethernet-phy-package@0 {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            reg = <0>;
+
+            qcom,package-mode = "qsgmii";
+
+            ethernet-phy@0 {
+                compatible = "ethernet-phy-id004d.d0b2";
+                reg = <0>;
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
+            ethernet-phy@1 {
+                compatible = "ethernet-phy-id004d.d0b2";
+                reg = <1>;
+            };
+
+            ethernet-phy@2 {
+                compatible = "ethernet-phy-id004d.d0b2";
+                reg = <2>;
+
+                gpio-controller;
+                #gpio-cells = <2>;
+            };
+
+            ethernet-phy@3 {
+                compatible = "ethernet-phy-id004d.d0b2";
+                reg = <3>;
+            };
+
+            ethernet-phy@4 {
+                compatible = "ethernet-phy-id004d.d0b2";
+                reg = <4>;
+            };
+        };
+    };
-- 
2.40.1

