Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A800D7E2A6F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 17:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbjKFQyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 11:54:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbjKFQyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 11:54:47 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4150DB8;
        Mon,  6 Nov 2023 08:54:44 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-32faea0fa1fso2585436f8f.1;
        Mon, 06 Nov 2023 08:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699289683; x=1699894483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lD7BF13nupmFvfWy4paCof/Bi2m3Fd/JhAxIizO404M=;
        b=nnVAHXCkLq6SA/I3UbJJZ0KXQXnjmUyidvKKVSsbQPs1BW8FzrfybMqXt+ia3okBFq
         CqZQdrf8heHaRohRVV0GkKklc7+XbC0ZwwYOPu39gi0VMuQKBHU5/IbXvvcpOyEr0n5o
         DYkua4ZPXZo+5XYFsVtsGMz1DVR9SXZ8jpQ46QWmzecWainm7gme5Y0z7p0dzGX9dsOS
         v6cOPGzrL1c0wHuZj/9SetrLse1cxXpo65ymunx15W6gHR7kjsajaCiwmaOcxoMY8bJF
         s9ie8aoplKdCAQGP3YW2G91k4vrQKRXKsOe6bsTpv+HsRJ9BFJpzMPxVhJJMQHobCQbx
         xo5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699289683; x=1699894483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lD7BF13nupmFvfWy4paCof/Bi2m3Fd/JhAxIizO404M=;
        b=ryv8Luahsjvnm7kOxMtfk629z6KbcRERtFFPvmbihtWnwOh0Kv0rbPoHneV7oXJvuT
         ya1EGoeSb3PVr+8VmBVPBS8hGUf04/92QNBDay+cNnaxp7r23H8x9fTonMIBQHvYy83K
         AndMU4Wo4rABSBsojpq8WQGN64TuXuYImUMkc9muMpQSz6wBNkhzeyIBkhCH6gHa3ydE
         QYNp/fDGBmplGM2Fty9l/9WQQQXR0Ff4rMzmXFeskwIzGr5hQmBl+R2Pq6Cmiwdxcxwo
         XIZCCpH4ACojZnOoJ4BzoDEtmuKLFlAToC2nNf0LFriSN0EACpwGvV0EQKKCiGY4Xkje
         VEDw==
X-Gm-Message-State: AOJu0YxBYDsSzKLiuGGK32CaFScTPp6jqAnObYNpOeL3OIfz62mCr4zT
        0QTwf5Z9JOvEQQXwAzdog6w=
X-Google-Smtp-Source: AGHT+IHn0RisOW2Jmasm+TqhRJnsbqc00LBKcebtXQBWJQmR+PwsNFqHH4ifjLcVKWHa17TDn6cZqg==
X-Received: by 2002:a5d:6d04:0:b0:32f:7d50:62f8 with SMTP id e4-20020a5d6d04000000b0032f7d5062f8mr97970wrq.3.1699289682467;
        Mon, 06 Nov 2023 08:54:42 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id a11-20020a05600c348b00b0040813e14b49sm13182044wmq.30.2023.11.06.08.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 08:54:42 -0800 (PST)
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
Subject: [net-next RFC PATCH v5 4/4] dt-bindings: Document bindings for Marvell Aquantia PHY
Date:   Mon,  6 Nov 2023 17:54:33 +0100
Message-Id: <20231106165433.2746-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231106165433.2746-1-ansuelsmth@gmail.com>
References: <20231106165433.2746-1-ansuelsmth@gmail.com>
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
---
Changes v5:
- Drop extra entry not related to HW description
Changes v3:
- Make DT description more OS agnostic
- Use custom select to fix dtbs checks
Changes v2:
- Add DT patch

 .../bindings/net/marvell,aquantia.yaml        | 123 ++++++++++++++++++
 1 file changed, 123 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/marvell,aquantia.yaml

diff --git a/Documentation/devicetree/bindings/net/marvell,aquantia.yaml b/Documentation/devicetree/bindings/net/marvell,aquantia.yaml
new file mode 100644
index 000000000000..7106c5bdf73c
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/marvell,aquantia.yaml
@@ -0,0 +1,123 @@
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
+    - Dedicated partition on system NAND with firmware in it. NVMEM
+      subsystem will be used and the declared NVMEM cell will load
+      the firmware to the PHY using the PHY mailbox interface.
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

