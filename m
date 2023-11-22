Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC677F4B6E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 16:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344673AbjKVPpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 10:45:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344472AbjKVPob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:44:31 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2E1D72;
        Wed, 22 Nov 2023 07:43:00 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AMFgqKW031041;
        Wed, 22 Nov 2023 09:42:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1700667772;
        bh=pFduLlydOwKar9BVb8D513PZ/AG8sYpzIvIkHf6BHxQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=EibEm12uKf5xmX8rhPG2NwQu6LHW4DKNRvU6xUJu45zvqu+ncNCGWPDTyNo0aJZGh
         i2YSWHSYzbRD8i1ZgPKDAxojH7sDaLhqp7dqAn8YqNcYf9lfK5Kh0NYO97vRYhxmxu
         wVYAOPKQdkbuR31WoCSK9BeGh+4E/AD6PJyG53M0=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AMFgq8R012010
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Nov 2023 09:42:52 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 22
 Nov 2023 09:42:52 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 22 Nov 2023 09:42:52 -0600
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AMFggJn046973;
        Wed, 22 Nov 2023 09:42:49 -0600
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
Subject: [PATCH v2 2/4] dt-bindings: dma: ti: k3-bcdma: Describe cfg register regions
Date:   Wed, 22 Nov 2023 21:12:36 +0530
Message-ID: <20231122154238.815781-3-vigneshr@ti.com>
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

Block copy DMA(BCDMA)module on K3 SoCs have ring, BCHAN, TX and RX
channel cfg register regions which are usually configured by a Device
Management firmware. But certain entities such as bootloader (like
U-Boot) may have to access them directly. Describe this region in the
binding documentation for completeness of module description.

Keep the binding compatible with existing DTS files by requiring first
five regions to be present at least.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 .../devicetree/bindings/dma/ti/k3-bcdma.yaml  | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml b/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
index b5444800b036..b9a0ce347368 100644
--- a/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
+++ b/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
@@ -155,20 +155,30 @@ allOf:
     then:
       properties:
         reg:
+          minItems: 5
           items:
             - description: BCDMA Control /Status Registers region
             - description: Block Copy Channel Realtime Registers region
             - description: RX Channel Realtime Registers region
             - description: TX Channel Realtime Registers region
             - description: Ring Realtime Registers region
+            - description: Ring Configuration Registers region
+            - description: TX Channel Configuration Registers region
+            - description: RX Channel Configuration Registers region
+            - description: Block Copy Channel Configuration Registers region
 
         reg-names:
+          minItems: 5
           items:
             - const: gcfg
             - const: bchanrt
             - const: rchanrt
             - const: tchanrt
             - const: ringrt
+            - const: ring
+            - const: tchan
+            - const: rchan
+            - const: bchan
 
       required:
         - ti,sci-rm-range-bchan
@@ -224,8 +234,13 @@ examples:
                       <0x0 0x4c000000 0x0 0x20000>,
                       <0x0 0x4a820000 0x0 0x20000>,
                       <0x0 0x4aa40000 0x0 0x20000>,
-                      <0x0 0x4bc00000 0x0 0x100000>;
-                reg-names = "gcfg", "bchanrt", "rchanrt", "tchanrt", "ringrt";
+                      <0x0 0x4bc00000 0x0 0x100000>,
+                      <0x0 0x48600000 0x0 0x8000>,
+                      <0x0 0x484a4000 0x0 0x2000>,
+                      <0x0 0x484c2000 0x0 0x2000>,
+                      <0x0 0x48420000 0x0 0x2000>;
+                reg-names = "gcfg", "bchanrt", "rchanrt", "tchanrt", "ringrt",
+                            "ring", "tchan", "rchan", "bchan";
                 msi-parent = <&inta_main_dmss>;
                 #dma-cells = <3>;
 
-- 
2.42.0

