Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791B17DF58D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 16:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344109AbjKBPBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 11:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjKBPBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 11:01:20 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD59B19A;
        Thu,  2 Nov 2023 08:01:14 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-4083ac51d8aso7952675e9.2;
        Thu, 02 Nov 2023 08:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698937273; x=1699542073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yjqMreabRsDRLtUlqL50Lj0Jf1Dc8tKq0A0FqOYk3vI=;
        b=TttEmsxMvK5+GPzFXabFceaz/QsyYWbpIxKlLRwMdcC/BRPmz//Tv56W96nmZwrODE
         rR3vBIdFVA2S89ydd3RBdaEwo3HCCKT9jupjtjplSYGoOFFcGEH0htN6jeRAGjstf7gl
         e+LX2S0nOolC4hLtEVmNRkFdZhLMWPjf26FAkEizOM1B+AGUZn2ICCfRRknmS/GpHsqN
         q9jLn6K+FpH8+hb0jlDRw+F/UE5puDvF4w84ry8lJSFHQIGzCTqOxPMvohd7d7uzc71N
         zSFK3qnyXHrSitql2MstTAFPMyyw/V1sGvgCyjZpC0rieq7GukFyzxtvw8Lid9oKWFoa
         gHxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698937273; x=1699542073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yjqMreabRsDRLtUlqL50Lj0Jf1Dc8tKq0A0FqOYk3vI=;
        b=sIHwkyLMAU71suaIig7P4Dn2V1u483cPhaDn3FgkzvsF7d51A/885E+R0AbUFF3I3F
         G8ZLw15YJeg+BI1p85p0RLgUndOOOjSDNfJ65y5HNTAziGCX/EAaY9EUBfEdGDgvFZgF
         7JjuK4QBGvqVu2ZoBncWKAlF2Zgfs7/jTIiba6fWh6WKoPUnkoHhIEy2GCNsT4dV6Hhu
         WFkR1oMpxlrYlrs2DraPfcTIepBv6AIIIIOhsfrPSbxqrLY9GPHNH4pty3OuHV/tTQMZ
         pjafRdRF6FcGZgPQhNNCl76djCONGxFHltIl/AMBGT1tc2NglVHkr9iqPSxVctdr42R6
         lv5g==
X-Gm-Message-State: AOJu0YxWU3c+LDBz+6s+47PDt6VgIQuMsrQFYuQNchXYbMV2Xjrp8jJP
        M3LUycwrIZR1kHvhcRX+oiw=
X-Google-Smtp-Source: AGHT+IGZKjrDa8RVJiFx8Yu7fGNuwAdECwzrX7tDnU5cyYtmKvaAcHpkPDmHp6CGfUjEIjQ24cyP5w==
X-Received: by 2002:a05:600c:310d:b0:405:3dee:3515 with SMTP id g13-20020a05600c310d00b004053dee3515mr17339953wmo.27.1698937272911;
        Thu, 02 Nov 2023 08:01:12 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id j15-20020a05600c130f00b003fbe4cecc3bsm3131007wmf.16.2023.11.02.08.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 08:01:08 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Robert Marko <robimarko@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [net-next RFC PATCH v3 4/4] dt-bindings: Document bindings for Marvell Aquantia PHY
Date:   Thu,  2 Nov 2023 16:00:32 +0100
Message-Id: <20231102150032.10740-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231102150032.10740-1-ansuelsmth@gmail.com>
References: <20231102150032.10740-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document bindings for Marvell Aquantia PHY.

The Marvell Aquantia PHY require a firmware to work correctly and there
at least 3 way to load this firmware.

Describe all the different way and document the binding "firmware-name"
to load the PHY firmware from userspace.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v3:
- Make DT description more OS agnostic
- Use custom select to fix dtbs checks
Changes v2:
- Add DT patch

 .../bindings/net/marvell,aquantia.yaml        | 126 ++++++++++++++++++
 1 file changed, 126 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/marvell,aquantia.yaml

diff --git a/Documentation/devicetree/bindings/net/marvell,aquantia.yaml b/Documentation/devicetree/bindings/net/marvell,aquantia.yaml
new file mode 100644
index 000000000000..d43cf28a4d61
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/marvell,aquantia.yaml
@@ -0,0 +1,126 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/marvell,aquantia.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell Aquantia Ethernet PHY
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+description: |
+  Marvell Aquantia Ethernet PHY require a firmware to be loaded to actually
+  work.
+
+  This can be done and is implemented by OEM in 3 different way:
+    - Attached SPI directly to the PHY with the firmware. The PHY will
+      self load the firmware in the presence of this configuration.
+    - Dedicated partition on system NAND with firmware in it. NVMEM
+      subsystem will be used and the declared NVMEM cell will load
+      the firmware to the PHY using the PHY mailbox interface.
+    - Manually provided firmware loaded from a file in the filesystem.
+
+  If declared, NVMEM will always take priority over filesystem provided
+  firmware.
+
+allOf:
+  - $ref: ethernet-phy.yaml#
+
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - ethernet-phy-id03a1.b445
+          - ethernet-phy-id03a1.b460
+          - ethernet-phy-id03a1.b4a2
+          - ethernet-phy-id03a1.b4d0
+          - ethernet-phy-id03a1.b4e0
+          - ethernet-phy-id03a1.b5c2
+          - ethernet-phy-id03a1.b4b0
+          - ethernet-phy-id03a1.b662
+          - ethernet-phy-id03a1.b712
+          - ethernet-phy-id31c3.1c12
+  required:
+    - compatible
+
+properties:
+  reg:
+    maxItems: 1
+
+  firmware-name:
+    description: specify the name of PHY firmware to load
+
+  nvmem-cells:
+    description: phandle to the firmware nvmem cell
+    maxItems: 1
+
+  nvmem-cell-names:
+    const: firmware
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethernet-phy@0 {
+            /*  Only needed to make DT lint tools work. Do not copy/paste
+             *  into real DTS files.
+             */
+            compatible = "ethernet-phy-id31c3.1c12",
+                         "ethernet-phy-ieee802.3-c45";
+
+            reg = <0>;
+            firmware-name = "AQR-G4_v5.4.C-AQR_CIG_WF-1945_0x8_ID44776_VER1630.cld";
+        };
+
+        ethernet-phy@1 {
+            /*  Only needed to make DT lint tools work. Do not copy/paste
+             *  into real DTS files.
+             */
+            compatible = "ethernet-phy-id31c3.1c12",
+                         "ethernet-phy-ieee802.3-c45";
+
+            reg = <0>;
+            nvmem-cells = <&aqr_fw>;
+            nvmem-cell-names = "firmware";
+        };
+    };
+
+    flash {
+        compatible = "jedec,spi-nor";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        partitions {
+            compatible = "fixed-partitions";
+            #address-cells = <1>;
+            #size-cells = <1>;
+
+            /* ... */
+
+            partition@650000 {
+                compatible = "nvmem-cells";
+                label = "0:ethphyfw";
+                reg = <0x650000 0x80000>;
+                read-only;
+                #address-cells = <1>;
+                #size-cells = <1>;
+
+                aqr_fw: aqr_fw@0 {
+                    reg = <0x0 0x5f42a>;
+                };
+            };
+
+            /* ... */
+
+        };
+    };
-- 
2.40.1

