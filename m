Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD98F80DACB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 20:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344676AbjLKTXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 14:23:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjLKTXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 14:23:46 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A206FCF;
        Mon, 11 Dec 2023 11:23:51 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40c2bb872e2so44963955e9.3;
        Mon, 11 Dec 2023 11:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702322630; x=1702927430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0tu3fg1/rS/+bYOcrvks/nBcdytZNwbzNp186x5K+04=;
        b=AIE9IMlmzE0JirVeS7ZYw+hkHOVkw/WytTuf2ThkdqP+F+Uhju/pmsauD7auFreEcr
         eXbF8Wk3Av/xaCkg0WwMiZ0ZEAmuMKA1F9talkFM2xX3Q0m0bHNCBPAmVqczyk3iYFdY
         xrBM2JmFguIqjXJLvuPAoJzSvgyDt1l+QkhIFgaVjBJ5EW8g+0L/I61u1hF/luZauR3f
         zj4icCiEim8YfQ0MPxomOiY+HkekFYZXEYfLC3a8qCyfOFx9SGi2wzEFYmeWbkMyEYj1
         C+ZST+7sPJBAjN3+/IwCJaI9K/xKR2Xp0H5aLBcuh2+LYAoCm82UwxQAaZvG0KN4Jlb+
         N/jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702322630; x=1702927430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0tu3fg1/rS/+bYOcrvks/nBcdytZNwbzNp186x5K+04=;
        b=qd7HevFtxk7F+i8Fy5KR3BY9xud0ZYVtJcok2nXUWD+qndQ5Iu0pKYs6oIuFrEDQkF
         uQFKbdYjzQDLTI/9pt6Fm6ANFxLPeZnsKHg3iwS4lw2u5RGzcrMZKgirdiipQi1I0jNA
         mL7y4JbfyLoB9DL7RXt/p3Nb5/K8w2sk6wK4fuBxM9MHa4E7l3dpTG87xer+Y5TQn9Uj
         EVl8jqXn5Au8TP4OflinctiiKoNBn/MDhfBIeNH2jqXvxjFxJNltZ2SjgVOJ8B/8J/ts
         tV8IJhmCOomQnfp8fSSK5nTRi0zJy0jMs7HPwYRgAXVzZkU2lq0OTqBIDNYSEPg/sPCt
         kltQ==
X-Gm-Message-State: AOJu0Yz1ctQjhxb0bMOuyP9pmwREn5PK2WqZ5okGFychm+CBAG9E3BYR
        fvUQBjFviVr1ZpqzGImGN2A=
X-Google-Smtp-Source: AGHT+IE4pEvyhN1PLvE5n0ISF8j0xJx6F272hJXp74r92/8qMW5tbhqUw8yYMqcxHHEeuFuqMmYoPA==
X-Received: by 2002:a05:600c:3217:b0:40c:246c:bd88 with SMTP id r23-20020a05600c321700b0040c246cbd88mr1214054wmp.343.1702322629834;
        Mon, 11 Dec 2023 11:23:49 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id d16-20020a5d4f90000000b0033349bccac6sm9325197wru.1.2023.12.11.11.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 11:23:49 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [net-next RFC PATCH v2 3/4] dt-bindings: net: Document QCA808x PHYs
Date:   Mon, 11 Dec 2023 20:23:17 +0100
Message-Id: <20231211192318.16450-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231211192318.16450-1-ansuelsmth@gmail.com>
References: <20231211192318.16450-1-ansuelsmth@gmail.com>
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

Add Documentation for QCA808x PHYs for the additional LED configuration
for this PHY.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v2:
- Fix License warning from checkpatch
- Drop redundant Description phrase
- Improve commit tile
- Drop special property (generalized)

 .../devicetree/bindings/net/qca,qca808x.yaml  | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/qca,qca808x.yaml

diff --git a/Documentation/devicetree/bindings/net/qca,qca808x.yaml b/Documentation/devicetree/bindings/net/qca,qca808x.yaml
new file mode 100644
index 000000000000..ec8b31324df5
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/qca,qca808x.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/qca,qca808x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Atheros QCA808X PHY
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+description:
+  QCA808X PHYs can have up to 3 LEDs attached.
+  All 3 LEDs are disabled by default.
+  2 LEDs have dedicated pins with the 3rd LED having the
+  double function of Interrupt LEDs/GPIO or additional LED.
+
+  By default this special PIN is set to LED function.
+
+allOf:
+  - $ref: ethernet-phy.yaml#
+
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - ethernet-phy-id004d.d101
+  required:
+    - compatible
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
+        ethernet-phy@0 {
+            compatible = "ethernet-phy-id004d.d101";
+            reg = <0>;
+
+            leds {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                led@0 {
+                    reg = <0>;
+                    color = <LED_COLOR_ID_GREEN>;
+                    function = LED_FUNCTION_WAN;
+                    default-state = "keep";
+                };
+            };
+        };
+    };
-- 
2.40.1

