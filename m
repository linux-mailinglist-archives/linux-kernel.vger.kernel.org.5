Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B0E7F6B88
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 05:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbjKXE6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 23:58:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjKXE6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 23:58:02 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316B9D72;
        Thu, 23 Nov 2023 20:58:09 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AO4w3gl043223;
        Thu, 23 Nov 2023 22:58:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1700801883;
        bh=PbWoR+x8jS1n5qKzMhtUnqnJ8AmjrNrmPpkl+xNXAj0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Wu4+LgRJzTvx1KSNAmx5HALdO2MhUq1DnY4dpEFsr/i5Q5O5YleLEACTd/aB8lhQG
         fmZczljRlWo5PIgMwPAC784fkc06OAQb1gqlJ2XEVWboIK3qTrug13bsonK6Ehixkc
         wNyY9YkfT8qMK7VukCHbHM+GHiMeXN9W2ISwl4/8=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AO4w35k076500
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Nov 2023 22:58:03 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 23
 Nov 2023 22:58:03 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 23 Nov 2023 22:58:03 -0600
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AO4vo8i004756;
        Thu, 23 Nov 2023 22:58:00 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 3/4] dt-bindings: dma: ti: k3-pktdma: Describe cfg register regions
Date:   Fri, 24 Nov 2023 10:27:21 +0530
Message-ID: <20231124045722.191817-4-vigneshr@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124045722.191817-1-vigneshr@ti.com>
References: <20231124045722.191817-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Packet DMA (PKTDMA) module on K3 SoCs have ring cfg, TX and RX channel
cfg and RX flow cfg register regions which are usually configured by a
Device Management firmware. But certain entities such as bootloader
(like U-Boot) may have to access them directly. Describe this region in
the binding documentation for completeness of module description.

Keep the binding compatible with existing DTS files by requiring first
four regions to be present at least.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 .../devicetree/bindings/dma/ti/k3-pktdma.yaml | 20 +++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/ti/k3-pktdma.yaml b/Documentation/devicetree/bindings/dma/ti/k3-pktdma.yaml
index 3580b08f65c6..11e064c02994 100644
--- a/Documentation/devicetree/bindings/dma/ti/k3-pktdma.yaml
+++ b/Documentation/devicetree/bindings/dma/ti/k3-pktdma.yaml
@@ -45,18 +45,28 @@ properties:
       The second cell is the ASEL value for the channel
 
   reg:
+    minItems: 4
     items:
       - description: Packet DMA Control /Status Registers region
       - description: RX Channel Realtime Registers region
       - description: TX Channel Realtime Registers region
       - description: Ring Realtime Registers region
+      - description: Ring Configuration Registers region
+      - description: TX Configuration Registers region
+      - description: RX Configuration Registers region
+      - description: RX Flow Configuration Registers region
 
   reg-names:
+    minItems: 4
     items:
       - const: gcfg
       - const: rchanrt
       - const: tchanrt
       - const: ringrt
+      - const: ring
+      - const: tchan
+      - const: rchan
+      - const: rflow
 
   msi-parent: true
 
@@ -140,8 +150,14 @@ examples:
                 reg = <0x0 0x485c0000 0x0 0x100>,
                       <0x0 0x4a800000 0x0 0x20000>,
                       <0x0 0x4aa00000 0x0 0x40000>,
-                      <0x0 0x4b800000 0x0 0x400000>;
-                reg-names = "gcfg", "rchanrt", "tchanrt", "ringrt";
+                      <0x0 0x4b800000 0x0 0x400000>,
+                      <0x0 0x485e0000 0x0 0x20000>,
+                      <0x0 0x484a0000 0x0 0x4000>,
+                      <0x0 0x484c0000 0x0 0x2000>,
+                      <0x0 0x48430000 0x0 0x4000>;
+                reg-names = "gcfg", "rchanrt", "tchanrt", "ringrt",
+                            "ring", "tchan", "rchan", "rflow";
+
                 msi-parent = <&inta_main_dmss>;
                 #dma-cells = <2>;
 
-- 
2.43.0

