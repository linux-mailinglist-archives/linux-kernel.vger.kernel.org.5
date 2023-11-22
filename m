Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302B37F4BAB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 16:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344638AbjKVPyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 10:54:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235243AbjKVPya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:54:30 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1229B170E;
        Wed, 22 Nov 2023 07:43:01 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AMFgtjC031052;
        Wed, 22 Nov 2023 09:42:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1700667775;
        bh=/hLXqNq2lxfuDYMurFDuU/pVsd2mCXJXYqLfaS+P+zU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=qdGp1tEfNQRWLytU3ht3tqcSh+oDaOdB7wJev8podPQ9/jadNoQjNOI9ajCfcdMlO
         Z8kjfj2dD2gw2DNCWGkMXFHVCFIqm0UbQEt2pcyMf7AL6zzCvRDM1i3wM1Kv9A0DRQ
         hK/C7tlxCxoIE3ac3CKAw4ja0+n5+BsZFaQrPzsM=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AMFgtgM086025
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Nov 2023 09:42:55 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 22
 Nov 2023 09:42:55 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 22 Nov 2023 09:42:55 -0600
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AMFggJo046973;
        Wed, 22 Nov 2023 09:42:52 -0600
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
Subject: [PATCH v2 3/4] dt-bindings: dma: ti: k3-pktdma: Describe cfg register regions
Date:   Wed, 22 Nov 2023 21:12:37 +0530
Message-ID: <20231122154238.815781-4-vigneshr@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231122154238.815781-1-vigneshr@ti.com>
References: <20231122154238.815781-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
2.42.0

