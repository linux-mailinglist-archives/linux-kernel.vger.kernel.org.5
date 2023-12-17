Return-Path: <linux-kernel+bounces-2406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C952B815CAD
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 01:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83AE4284513
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 00:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA2E1851;
	Sun, 17 Dec 2023 00:09:55 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA841102;
	Sun, 17 Dec 2023 00:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rEej0-000651-2a;
	Sun, 17 Dec 2023 00:09:44 +0000
Date: Sun, 17 Dec 2023 00:09:41 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/7] dt-bindings: mtd: ubi-volume: allow UBI volumes to
 provide NVMEM
Message-ID: <de0bd3647ed2560074aa3528716c203b8939fe1d.1702770711.git.daniel@makrotopia.org>
References: <cover.1702770711.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1702770711.git.daniel@makrotopia.org>

UBI volumes may be used to contain NVMEM bits, typically device MAC
addresses or wireless radio calibration data.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/mtd/partitions/linux,ubi.yaml  | 10 ++++++++++
 .../devicetree/bindings/mtd/partitions/ubi-volume.yaml |  5 +++++
 2 files changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/partitions/linux,ubi.yaml b/Documentation/devicetree/bindings/mtd/partitions/linux,ubi.yaml
index 7084a1945b310..27e1ac1f252e4 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/linux,ubi.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/linux,ubi.yaml
@@ -59,6 +59,16 @@ examples:
                 ubi-volume-caldata {
                     volid = <2>;
                     volname = "rf";
+
+                    nvmem-layout {
+                        compatible = "fixed-layout";
+                        #address-cells = <1>;
+                        #size-cells = <1>;
+
+                        eeprom@0 {
+                            reg = <0x0 0x1000>;
+                        };
+                    };
                 };
             };
         };
diff --git a/Documentation/devicetree/bindings/mtd/partitions/ubi-volume.yaml b/Documentation/devicetree/bindings/mtd/partitions/ubi-volume.yaml
index c17d0caf07d97..098da3af13a26 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/ubi-volume.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/ubi-volume.yaml
@@ -24,6 +24,11 @@ properties:
     description:
       Match UBI volume ID
 
+  nvmem-layout:
+    $ref: /schemas/nvmem/layouts/nvmem-layout.yaml#
+    description:
+      This container may reference an NVMEM layout parser.
+
 anyOf:
   - required:
     - volid
-- 
2.43.0

