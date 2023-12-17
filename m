Return-Path: <linux-kernel+bounces-2846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 645978162C5
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 23:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF9CAB21A0D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 22:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A87D49F7C;
	Sun, 17 Dec 2023 22:19:31 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1264AF76;
	Sun, 17 Dec 2023 22:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rEzTm-0001ah-2E;
	Sun, 17 Dec 2023 22:19:23 +0000
Date: Sun, 17 Dec 2023 22:19:21 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>, linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/7] dt-bindings: mtd: add basic bindings for UBI
Message-ID: <4fb8e00ec2c558e4a59a98dcf8035adac73d7a20.1702850093.git.daniel@makrotopia.org>
References: <cover.1702850093.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1702850093.git.daniel@makrotopia.org>

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
index 0000000000000..c17d0caf07d97
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
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    description:
+      Match UBI volume ID
+
+  volname:
+    $ref: "/schemas/types.yaml#/definitions/string"
+    description:
+      Match UBI volume ID
+
+anyOf:
+  - required:
+    - volid
+
+  - required:
+    - volname
+
+# This is a generic file other binding inherit from and extend
+additionalProperties: true
-- 
2.43.0

