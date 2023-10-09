Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87AD47BEB4F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 22:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234583AbjJIUKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 16:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234540AbjJIUKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 16:10:16 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF176C6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 13:10:14 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-7a2bfd584f0so228361739f.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 13:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696882214; x=1697487014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lAmVpfxtEjWeqhBym/9INAYp/SD9oxrd9k5tq3qUHeQ=;
        b=JH1Fn6ny5INYVBlReSKe9b7xcV7o1yCCSfFFVlBJIbKU3p/IOA3VQhk+MQW7Ay2pRc
         My8Clpli5yhbm8Rx30skIrkGxhfFRHDd7L6YUvBuUjetsX1EFsOATRdi8qAkiu2l1toR
         1rk4jm8ds3djQlEBPRMtpQPNJ0dpK6cC6Z2sQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696882214; x=1697487014;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lAmVpfxtEjWeqhBym/9INAYp/SD9oxrd9k5tq3qUHeQ=;
        b=G4H12s84+zTNBtLAPLJbjBiCtOeR07ggASbdy9PYmGtm5AOOo7nWeOa1u5slagcPZL
         AG1/Xs74b1Lmqopb9Y4QBlbeNRqLYMNBijT+EXPQnElEENFIK6cRkBKI9RWRoXud5lQY
         t05oeEDPg1iRVEZYwjMTTIsxUs2wkasBwh3m/08w6n6CwJVYsUAfM59WrShBOY9my6qk
         TBs4kfUCOohxX5WRZsDThQCsLvMMlBe6+BvANOs3BKxySryMov6G3QYwYm4/Ls2g6KK+
         u7Hb9yp5nITUXeTfpVuwY6KJD9sT8Q1CEnRZjgnlA7IfDzrrxXWWhqWXJK7YTISRInor
         Lotg==
X-Gm-Message-State: AOJu0YxIuRQ9aswDTxxSxShAOz8r3cbcVcqLEqxWrpwfRk1x7BfelHRT
        vpKJxDBZVWUfuzmwblIWk2PlfQ==
X-Google-Smtp-Source: AGHT+IEc78qKmsK3z3pBpfOOUCuOy8RtzjBD6hP1npQ7FM26pD8BJKzMdWruP1pUj+ATY1tOV0y9WQ==
X-Received: by 2002:a6b:f209:0:b0:79f:9574:b93c with SMTP id q9-20020a6bf209000000b0079f9574b93cmr16364103ioh.0.1696882214221;
        Mon, 09 Oct 2023 13:10:14 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:138c:cf57:c18d:20f5])
        by smtp.gmail.com with ESMTPSA id q21-20020a02a315000000b0042b2df337ccsm2215294jai.76.2023.10.09.13.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 13:10:13 -0700 (PDT)
From:   Simon Glass <sjg@chromium.org>
To:     devicetree@vger.kernel.org
Cc:     U-Boot Mailing List <u-boot@lists.denx.de>,
        linux-mtd@lists.infradead.org, Michael Walle <mwalle@kernel.org>,
        Tom Rini <trini@konsulko.com>, Rob Herring <robh@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Simon Glass <sjg@chromium.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dhruva Gole <d-gole@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] dt-bindings: mtd: fixed-partitions: Add binman compatible
Date:   Mon,  9 Oct 2023 14:09:59 -0600
Message-ID: <20231009201005.1964794-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a compatible string for binman, so we can extend fixed-partitions
in various ways.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Drop fixed-partition additional compatible string
- Drop fixed-partitions from the example
- Mention use of compatible instead of label

Changes in v2:
- Drop mention of 'enhanced features' in fixed-partitions.yaml
- Mention Binman input and output properties
- Use plain partition@xxx for the node name

 .../bindings/mtd/partitions/binman.yaml       | 63 +++++++++++++++++++
 .../bindings/mtd/partitions/partitions.yaml   |  1 +
 MAINTAINERS                                   |  5 ++
 3 files changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/binman.yaml

diff --git a/Documentation/devicetree/bindings/mtd/partitions/binman.yaml b/Documentation/devicetree/bindings/mtd/partitions/binman.yaml
new file mode 100644
index 000000000000..7d6c8bd738f5
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/partitions/binman.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2023 Google LLC
+
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/partitions/binman.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Binman firmware layout
+
+maintainers:
+  - Simon Glass <sjg@chromium.org>
+
+select: false
+
+description: |
+  The binman node provides a layout for firmware, used when packaging firmware
+  from multiple projects. It is based on fixed-partitions, with some
+  extensions, but uses 'compatible' to indicate the contents of the node, to
+  avoid perturbing or confusing existing installations which use 'label' for a
+  particular purpose.
+
+  Binman supports properties used as inputs to the firmware-packaging process,
+  such as those which control alignment of partitions. This binding addresses
+  these 'input' properties. For example, it is common for the 'reg' property
+  (an 'output' property) to be set by Binman, based on the alignment requested
+  in the input.
+
+  Once processing is complete, input properties have mostly served their
+  purpose, at least until the firmware is repacked later, e.g. due to a
+  firmware update. The 'fixed-partitions' binding should provide enough
+  information to read the firmware at runtime, including decompression if
+  needed.
+
+  Documentation for Binman is available at:
+
+  https://u-boot.readthedocs.io/en/latest/develop/package/binman.html
+
+  with the current image-description format at:
+
+  https://u-boot.readthedocs.io/en/latest/develop/package/binman.html#image-description-format
+
+allOf:
+  - $ref: /schemas/mtd/partitions/fixed-partitions.yaml#
+
+properties:
+  compatible:
+    const: binman
+
+additionalProperties: false
+
+examples:
+  - |
+    partitions {
+        compatible = "binman";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        partition@100000 {
+            label = "u-boot";
+            reg = <0x100000 0xf00000>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
index 1dda2c80747b..849fd15d085c 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
@@ -15,6 +15,7 @@ maintainers:
 
 oneOf:
   - $ref: arm,arm-firmware-suite.yaml
+  - $ref: binman.yaml
   - $ref: brcm,bcm4908-partitions.yaml
   - $ref: brcm,bcm947xx-cfe-partitions.yaml
   - $ref: fixed-partitions.yaml
diff --git a/MAINTAINERS b/MAINTAINERS
index c934244acc31..ebc8158fe67d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3536,6 +3536,11 @@ F:	Documentation/filesystems/bfs.rst
 F:	fs/bfs/
 F:	include/uapi/linux/bfs_fs.h
 
+BINMAN
+M:	Simon Glass <sjg@chromium.org>
+S:	Supported
+F:	Documentation/devicetree/bindings/mtd/partitions/binman*
+
 BITMAP API
 M:	Yury Norov <yury.norov@gmail.com>
 R:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
-- 
2.42.0.609.gbb76f46606-goog

