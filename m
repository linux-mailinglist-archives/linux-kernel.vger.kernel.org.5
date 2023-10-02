Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E0B7B59BB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 20:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237641AbjJBRu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 13:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjJBRu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 13:50:26 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4927183
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 10:50:23 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-79fa5d9f3a2so239f.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 10:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696269022; x=1696873822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k71/w5tQzn4vicDbb9dqcU9SEKAhIvW7cb6nA8shinc=;
        b=k4eei0utiOJesXtZQ51L6fvgK/efzcOJp/15EYG7K+IaxOupBksjh7jvnDoHMvkPse
         rcWshuer51ZaVdj8Bo3ofJ0xPh92PYeKdchi1x0HmTQsy8FI04ddhVLBBrvZhCCMx+Xe
         u4Y/blSP7xA1x2oziAAFakli/jXAiNIZrDDJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696269022; x=1696873822;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k71/w5tQzn4vicDbb9dqcU9SEKAhIvW7cb6nA8shinc=;
        b=sn3CPksvIu0rc2ljEp7wz2ZKjvNdr9m6cfGArOamaN7z63hCsw0lHjUfKYq04GC5yu
         7y2QbYOFCKiZ96bD29UpDjnlUwg0AuTuMr0GC+hqodtX5/6VFwMDXgt9NJmllCvxp5S9
         iOBzpF7UCVdusaWsKAtIbh8CCUHI4W5C1+2UfQBtghJ0rU9vllc5/vr4GxMrFWEdGDZM
         Mng3MSFuA60UshCmwNRHvqAAEenytR+xXlnjz2eqJa/xR4op8umjEIB1ryGf2ErpNBd4
         ctEybsg3s3TJtcPlcGM1pfgM66JvLeCM27kUwoBIiTY2ZZ0hMxRoP8U5yYg7ej8ZA+aJ
         qZ8Q==
X-Gm-Message-State: AOJu0Ywv3+Hb4+tVB1OcqGbx9Ufn7JrCD8RWWgE73tYeLmbZEsA4EycE
        HKVzLMCTD5tke9EMgrYN8Ch/vA==
X-Google-Smtp-Source: AGHT+IEyXhGigDBdCKAGT+/IMaNGbS+k8t3ALkt9DIMUsltzdGeZnx6gsOo2/2x7u2YGnPQKl0q5+w==
X-Received: by 2002:a5d:9cd5:0:b0:794:cdd8:db3c with SMTP id w21-20020a5d9cd5000000b00794cdd8db3cmr14699347iow.17.1696269022549;
        Mon, 02 Oct 2023 10:50:22 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:63cd:2673:520:2e9])
        by smtp.gmail.com with ESMTPSA id s23-20020a02c517000000b0042b2e309f97sm6919562jam.177.2023.10.02.10.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 10:50:22 -0700 (PDT)
From:   Simon Glass <sjg@chromium.org>
To:     devicetree@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>, Tom Rini <trini@konsulko.com>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        linux-mtd@lists.infradead.org, Simon Glass <sjg@chromium.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Pratyush Yadav <ptyadav@amazon.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings: mtd: fixed-partitions: Add binman compatible
Date:   Mon,  2 Oct 2023 11:49:40 -0600
Message-ID: <20231002174948.1015223-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
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

Changes in v2:
- Drop mention of 'enhanced features' in fixed-partitions.yaml
- Mention Binman input and output properties
- Use plain partition@xxx for the node name

 .../bindings/mtd/partitions/binman.yaml       | 61 +++++++++++++++++++
 .../mtd/partitions/fixed-partitions.yaml      |  3 +
 .../bindings/mtd/partitions/partitions.yaml   |  1 +
 MAINTAINERS                                   |  5 ++
 4 files changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/binman.yaml

diff --git a/Documentation/devicetree/bindings/mtd/partitions/binman.yaml b/Documentation/devicetree/bindings/mtd/partitions/binman.yaml
new file mode 100644
index 000000000000..844f241feebf
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/partitions/binman.yaml
@@ -0,0 +1,61 @@
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
+  extensions.
+
+  Binman supports properties used as inputs to the firmware-packaging process,
+  such as those which control alignment of partitions. This binding addresses
+  these 'input' properties. For example, it is common for the 'reg' property
+  (an 'output' property) to be set by Binman, based on the alignment requested
+  in the input.
+
+  Once processing is complete, input properties have mostly served their
+  purpose, at least until the firmware is repacked later, e.g. due to a
+  firmware update. The base 'fixed-partitions' binding should provide enough
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
+        compatible = "binman", "fixed-partitions";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        partition@100000 {
+            label = "u-boot";
+            reg = <0x100000 0xf00000>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
index 331e564f29dc..85aef1572967 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
@@ -24,6 +24,9 @@ properties:
       - items:
           - const: sercomm,sc-partitions
           - const: fixed-partitions
+      - items:
+          - const: binman
+          - const: fixed-partitions
 
   "#address-cells": true
 
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
index 5f18c6ba3c3c..367c843ec348 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3517,6 +3517,11 @@ F:	Documentation/filesystems/bfs.rst
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
2.42.0.582.g8ccd20d70d-goog

