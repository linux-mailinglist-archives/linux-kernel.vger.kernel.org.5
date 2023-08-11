Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D335E7784F2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 03:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbjHKBhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 21:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbjHKBhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 21:37:10 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F052D5F;
        Thu, 10 Aug 2023 18:37:09 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1qUH5K-00053b-0T;
        Fri, 11 Aug 2023 01:37:02 +0000
Date:   Fri, 11 Aug 2023 02:36:55 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Golle <daniel@makrotopia.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/8] dt-bindings: mtd: nvmem-cells: add support for UBI
 volumes
Message-ID: <7df4543f5dacef006bd7067117cf959b59842d69.1691717480.git.daniel@makrotopia.org>
References: <cover.1691717480.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1691717480.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UBI volumes may be used to contain NVMEM bits, typically device MAC
addresses or wireless radio calibration data.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 .../devicetree/bindings/mtd/partitions/linux,ubi.yaml        | 3 ++-
 .../devicetree/bindings/mtd/partitions/nvmem-cells.yaml      | 5 ++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/partitions/linux,ubi.yaml b/Documentation/devicetree/bindings/mtd/partitions/linux,ubi.yaml
index a06c1666d5184..e834441fe5e6a 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/linux,ubi.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/linux,ubi.yaml
@@ -56,9 +56,10 @@ examples:
             compatible = "linux,ubi";
 
             volumes {
-                ubi-volume-caldata {
+                wifi_caldata: ubi-volume-caldata {
                     volume-id = <2>;
                     volume-name = "rf";
+                    compatible = "nvmem-cells";
                 };
             };
         };
diff --git a/Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml b/Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml
index 5474d63268dc5..b92a0b35df094 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml
@@ -17,9 +17,12 @@ maintainers:
   - Ansuel Smith <ansuelsmth@gmail.com>
 
 allOf:
-  - $ref: /schemas/mtd/partitions/partition.yaml#
   - $ref: /schemas/nvmem/nvmem.yaml#
 
+oneOf:
+  - $ref: /schemas/mtd/partitions/partition.yaml#
+  - $ref: /schemas/mtd/partitions/ubi-volume.yaml#
+
 properties:
   compatible:
     const: nvmem-cells
-- 
2.41.0
