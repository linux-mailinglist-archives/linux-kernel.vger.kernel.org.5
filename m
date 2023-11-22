Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1509F7F4BAC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 16:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344536AbjKVPyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 10:54:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344607AbjKVPyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:54:41 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08B3D59;
        Wed, 22 Nov 2023 07:43:10 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AMFgwNT087457;
        Wed, 22 Nov 2023 09:42:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1700667778;
        bh=4X/PvSxMuHjPWRg0qb+oBQwISSlm8v2omhy8IE/35FY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=pygKJ9tTdjq+1eoCdBnRRl8UwLSqfXpQGUWDFNhQ9Ok4X36/B1k2qpJJ4xTk1KguG
         0hWgxDa83o4xmO+yb3ZtHWRvnfh3r/rh4ZMMKLay/089D76VDAJGYRQH12PGNRx19A
         eoIAt3LusCnbFLXPCpqz++NX2CtTr2OZZoBIT1Yk=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AMFgwcw012052
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Nov 2023 09:42:58 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 22
 Nov 2023 09:42:58 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 22 Nov 2023 09:42:58 -0600
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AMFggJp046973;
        Wed, 22 Nov 2023 09:42:55 -0600
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
Subject: [PATCH v2 4/4] dt-bindings: dma: ti: k3-udma: Describe cfg register regions
Date:   Wed, 22 Nov 2023 21:12:38 +0530
Message-ID: <20231122154238.815781-5-vigneshr@ti.com>
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

Unified DMA (UDMA) module on K3 SoCs have TX and RX channel cfg and RX
flow cfg register regions which are usually configured by a Device
Management firmware. But certain entities such as bootloader (like
U-Boot) may have to access them directly. Describe this region in the
binding documentation for completeness of module description.

Keep the binding compatible with existing DTS files by requiring first
four regions to be present at least.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 .../devicetree/bindings/dma/ti/k3-udma.yaml       | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/ti/k3-udma.yaml b/Documentation/devicetree/bindings/dma/ti/k3-udma.yaml
index ded588bd079a..b18cf2bfdb5b 100644
--- a/Documentation/devicetree/bindings/dma/ti/k3-udma.yaml
+++ b/Documentation/devicetree/bindings/dma/ti/k3-udma.yaml
@@ -69,16 +69,24 @@ properties:
       - ti,j721e-navss-mcu-udmap
 
   reg:
+    minItems: 3
     items:
       - description: UDMA-P Control /Status Registers region
       - description: RX Channel Realtime Registers region
       - description: TX Channel Realtime Registers region
+      - description: TX Configuration Registers region
+      - description: RX Configuration Registers region
+      - description: RX Flow Configuration Registers region
 
   reg-names:
+    minItems: 3
     items:
       - const: gcfg
       - const: rchanrt
       - const: tchanrt
+      - const: tchan
+      - const: rchan
+      - const: rflow
 
   msi-parent: true
 
@@ -161,8 +169,11 @@ examples:
                 compatible = "ti,am654-navss-main-udmap";
                 reg = <0x0 0x31150000 0x0 0x100>,
                       <0x0 0x34000000 0x0 0x100000>,
-                      <0x0 0x35000000 0x0 0x100000>;
-                reg-names = "gcfg", "rchanrt", "tchanrt";
+                      <0x0 0x35000000 0x0 0x100000>,
+                      <0x0 0x30b00000 0x0 0x20000>,
+                      <0x0 0x30c00000 0x0 0x8000>,
+                      <0x0 0x30d00000 0x0 0x4000>;
+                reg-names = "gcfg", "rchanrt", "tchanrt", "tchan", "rchan", "rflow";
                 #dma-cells = <1>;
 
                 ti,ringacc = <&ringacc>;
-- 
2.42.0

