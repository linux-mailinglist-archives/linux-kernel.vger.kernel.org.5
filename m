Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 455087EB19C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 15:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbjKNOJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 09:09:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbjKNOI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 09:08:59 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F80DCA;
        Tue, 14 Nov 2023 06:08:55 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-32fdd0774d9so3472625f8f.2;
        Tue, 14 Nov 2023 06:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699970933; x=1700575733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Tc7XrSkK7w4+I5dQBa4j17MImXGcSr0mvF8eFfDQy4=;
        b=cH+xGDkIFHyTpjN/SfhhHv6iO6aqbVX/T+xn/S3iqk1RX6dJLhgnx2PlewDcum5RYY
         ErCjYTLYj+ABs7kixRJLRupTd1z6+Py8vUUOozRWvUpzBElL7/rTsn2h5Uwl7y/1s6Dy
         bptb7+SQQnLOGuJl5V6sqwq20EInfhycNPOmODNKV8RpDkJ9myzYoKB1GG2ElvOkRK3n
         wmNLFLIY6ZFJWs/VaYfAh5cohntjd0OfvVUNc9KoTyxNpY3NPpQonJMlu7qlRBi4hc2l
         D8P7/d2T+/Tuwhz8T1DFQiyRSX78DkX6QinAqq4p46b14PFIcNxAgBYeSZmnIFhjT6Uk
         xtqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699970933; x=1700575733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Tc7XrSkK7w4+I5dQBa4j17MImXGcSr0mvF8eFfDQy4=;
        b=dqEH+xZgLEiY4sJItN9Jzq2Tbkqd1lxzz0ZAI8khBPlMqky9gXDvaswsbv3JpAI/Lo
         u/15QjLdH3L1Zkm9Fou+FuhQOQeB4xZaY6mWdMh7JMirrMuM+UHdMEFc+OnjO2V0GxnL
         mGdUEYFcuQCmIwnCJNnwmPsmjZgcKcaDB0cs3TPuaHN6ECwOR9uG/91Phmi7xcI5PhV3
         X87vtLIGgoMHMph75EJKuoousBkqWQpFT7RTyqP9YT4ChiPfcGZpBMyLwLTpB1p7cjP1
         ybb6/vzYLKWW5ZA5IXFkaxTVsgLphXTnzZyVu214LqRQScMKDQVdVI5BFjOS/ZkDrU8W
         nWEQ==
X-Gm-Message-State: AOJu0YyJAf5LDAWeRCL/E1jIEavl2hxJUijD/oaUmbf0UgJt7wBKZonl
        oLtCnRfqDxQGrWGFjHcIBuA=
X-Google-Smtp-Source: AGHT+IGjGNKlLg8kjVTxYFgwMLeDrIwsbQzWHVWIHd+5sPtjpTD6sD3tOwk7M53RjX42/kYJVFj2kg==
X-Received: by 2002:a5d:64ee:0:b0:32f:7fe4:45f2 with SMTP id g14-20020a5d64ee000000b0032f7fe445f2mr9035004wri.4.1699970933084;
        Tue, 14 Nov 2023 06:08:53 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id q2-20020adf9dc2000000b0032db4825495sm8014603wre.22.2023.11.14.06.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 06:08:52 -0800 (PST)
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
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Rob Herring <robh@kernel.org>
Subject: [net-next PATCH v8 4/4] dt-bindings: Document Marvell Aquantia PHY
Date:   Tue, 14 Nov 2023 15:08:44 +0100
Message-Id: <20231114140844.9596-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231114140844.9596-1-ansuelsmth@gmail.com>
References: <20231114140844.9596-1-ansuelsmth@gmail.com>
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

Document bindings for Marvell Aquantia PHY.

The Marvell Aquantia PHY require a firmware to work correctly and there
at least 3 way to load this firmware.

Describe all the different way and document the binding "firmware-name"
to load the PHY firmware from userspace.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes v8:
- Out of RFC
Changes v7:
- Add Acked-by tag
Changes v6:
- Add Reviewed-by tag
- Drop comments in dts examples
- Improve commit title
- Fix wrong reg in example
Changes v5:
- Drop extra entry not related to HW description
Changes v3:
- Make DT description more OS agnostic
- Use custom select to fix dtbs checks
Changes v2:
- Add DT patch

 .../bindings/net/marvell,aquantia.yaml        | 116 ++++++++++++++++++
 1 file changed, 116 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/marvell,aquantia.yaml

diff --git a/Documentation/devicetree/bindings/net/marvell,aquantia.yaml b/Documentation/devicetree/bindings/net/marvell,aquantia.yaml
new file mode 100644
index 000000000000..9854fab4c4db
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/marvell,aquantia.yaml
@@ -0,0 +1,116 @@
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
+    - Attached SPI flash directly to the PHY with the firmware. The PHY
+      will self load the firmware in the presence of this configuration.
+    - Read from a dedicated partition on system NAND declared in an
+      NVMEM cell, and loaded to the PHY using its mailbox interface.
+    - Manually provided firmware loaded from a file in the filesystem.
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
+            compatible = "ethernet-phy-id31c3.1c12",
+                         "ethernet-phy-ieee802.3-c45";
+
+            reg = <0>;
+            firmware-name = "AQR-G4_v5.4.C-AQR_CIG_WF-1945_0x8_ID44776_VER1630.cld";
+        };
+
+        ethernet-phy@1 {
+            compatible = "ethernet-phy-id31c3.1c12",
+                         "ethernet-phy-ieee802.3-c45";
+
+            reg = <1>;
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

