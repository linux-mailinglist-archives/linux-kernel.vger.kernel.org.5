Return-Path: <linux-kernel+bounces-4598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 355E3817FCD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 03:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D82E0283A2F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 02:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B141FDD;
	Tue, 19 Dec 2023 02:32:18 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F358AD44;
	Tue, 19 Dec 2023 02:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rFPtp-0008HM-3B;
	Tue, 19 Dec 2023 02:32:03 +0000
Date: Tue, 19 Dec 2023 02:32:00 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>, linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 1/7] dt-bindings: mtd: add basic bindings for UBI
Message-ID: <cfb173849a10f186d4395f3aba2508ed42356ee1.1702952891.git.daniel@makrotopia.org>
References: <cover.1702952891.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1702952891.git.daniel@makrotopia.org>

Add basic bindings for UBI devices and volumes.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/mtd/partitions/linux,ubi.yaml    | 65 +++++++++++++++++++
 .../bindings/mtd/partitions/ubi-volume.yaml   | 35 ++++++++++
 2 files changed, 100 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/linux,ubi.yaml
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/ubi-volume.yaml

diff --git a/Documentation/devicetree/bindings/mtd/partitions/linux,ubi.yaml b/Documentation/devicetree/bindings/mtd/partitions/linux,ubi.yaml
new file mode 100644
index 0000000000000..7084a1945b310
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/partitions/linux,ubi.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/partitions/linux,ubi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Unsorted Block Images
+
+description: |
+  UBI ("Unsorted Block Images") is a volume management system for raw
+  flash devices which manages multiple logical volumes on a single
+  physical flash device and spreads the I/O load (i.e wear-leveling)
+  across the whole flash chip.
+
+maintainers:
+  - Daniel Golle <daniel@makrotopia.org>
+
+allOf:
+  - $ref: partition.yaml#
+
+properties:
+  compatible:
+    const: linux,ubi
+
+  volumes:
+    type: object
+    description: UBI Volumes
+
+    patternProperties:
+      "^ubi-volume-.*$":
+        $ref: /schemas/mtd/partitions/ubi-volume.yaml#
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
+    partitions {
+        compatible = "fixed-partitions";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        partition@0 {
+            reg = <0x0 0x100000>;
+            label = "bootloader";
+            read-only;
+        };
+
+        partition@100000 {
+            reg = <0x100000 0x1ff00000>;
+            label = "ubi";
+            compatible = "linux,ubi";
+
+            volumes {
+                ubi-volume-caldata {
+                    volid = <2>;
+                    volname = "rf";
+                };
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/mtd/partitions/ubi-volume.yaml b/Documentation/devicetree/bindings/mtd/partitions/ubi-volume.yaml
new file mode 100644
index 0000000000000..1e3f04dedc01d
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/partitions/ubi-volume.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/partitions/ubi-volume.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: UBI volume
+
+description: |
+  This binding describes a single UBI volume. Volumes can be matches either
+  by their ID or their name, or both.
+
+maintainers:
+  - Daniel Golle <daniel@makrotopia.org>
+
+properties:
+  volid:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Match UBI volume ID
+
+  volname:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      Match UBI volume ID
+
+anyOf:
+  - required:
+      - volid
+
+  - required:
+      - volname
+
+# This is a generic file other binding inherit from and extend
+additionalProperties: true
-- 
2.43.0

