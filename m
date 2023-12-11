Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A747580CF33
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344214AbjLKPNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 10:13:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344092AbjLKPM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:12:56 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5443E11F;
        Mon, 11 Dec 2023 07:12:53 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 29B90E000F;
        Mon, 11 Dec 2023 15:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1702307572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YFRNTXiHpB5q4OBf51HMQ0MXG7WMAPuA7YrMIImpGe0=;
        b=eH/hVFqXLeGU/34uyK7mc9EgkXkva33CrQszVtV40e1/5u6zGyGh9h36e4GlExYnIYOOHh
        +FEJ1Q7arcqVy235e191ce9lFPMVqL302sckpRP2VeKq7Y9d9WFAsh9mBxRC82//Ef7t0x
        AbRDSZmDH8bl8BhgULMlAkSLZNByGPttTtIxJc7poOMK3XuErAyfjYaN7GAumSJtRmjUu+
        PB3e6PZSdQP3ctZgagW5pPmILOl/EVMhN+3Er7BTjn0QFEWILCfLmQ1p1ETYt2a7NPcbAT
        5+b4qBtrDNqT6EUmLDIH71QbQF3tzOle1vR7RX+xk/LkFxO5e383G23QUMe8Kw==
From:   Romain Gantois <romain.gantois@bootlin.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Romain Gantois <romain.gantois@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-efi@vger.kernel.org
Subject: [RFC PATCH 6/6] dt-bindings: mtd: add GPT partition bindings
Date:   Mon, 11 Dec 2023 16:12:42 +0100
Message-ID: <20231211151244.289349-7-romain.gantois@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211151244.289349-1-romain.gantois@bootlin.com>
References: <20231211151244.289349-1-romain.gantois@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: romain.gantois@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow parsing GPT layouts on MTD devices.

Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 .../bindings/mtd/partitions/gpt.yaml          | 41 +++++++++++++++++++
 .../bindings/mtd/partitions/partitions.yaml   |  1 +
 2 files changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/gpt.yaml

diff --git a/Documentation/devicetree/bindings/mtd/partitions/gpt.yaml b/Documentation/devicetree/bindings/mtd/partitions/gpt.yaml
new file mode 100644
index 000000000000..3c538562e3e5
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/partitions/gpt.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/partitions/gpt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: GUID Partition Table (GPT)
+
+description: The GPT format is commonly used on block devices to describe a
+partitioning scheme. It mainly consists of a Legacy or Protective MBR for
+backwards compatibility, a primary GPT header with an array of Partition Table
+Entries, and a backup header with a backup array of PTEs. This partition table
+format can be used on MTD devices, specifically NOR flash devices, since NAND
+flashes are susceptible to bad blocks which could easily corrupt the GPT layout.
+Logical Block Addresses (LBAs) are defined to target 512-byte blocks.
+
+maintainers:
+  - Romain Gantois <romain.gantois@bootlin.com>
+
+select: false
+
+properties:
+  compatible:
+    const: gpt
+
+  '#address-cells': false
+
+  '#size-cells': false
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    flash@0 {
+      partitions {
+        compatible = "gpt";
+      };
+    };
diff --git a/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
index 1dda2c80747b..f2b1565d5d0a 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
@@ -18,6 +18,7 @@ oneOf:
   - $ref: brcm,bcm4908-partitions.yaml
   - $ref: brcm,bcm947xx-cfe-partitions.yaml
   - $ref: fixed-partitions.yaml
+  - $ref: gpt.yaml
   - $ref: linksys,ns-partitions.yaml
   - $ref: qcom,smem-part.yaml
   - $ref: redboot-fis.yaml
-- 
2.43.0

