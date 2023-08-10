Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996A6776D48
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 02:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjHJA7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 20:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjHJA7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 20:59:00 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612A61994;
        Wed,  9 Aug 2023 17:59:00 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37A0wsDD009455;
        Wed, 9 Aug 2023 19:58:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691629134;
        bh=rJ1sKVG1Ox9z+jBJFizjGnLx/clE2nXAoqEkNrD60Rg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=WWSIo7tEnIuOTnWV2OfOZ1WSXZIGF0JGrnrchZUshD9MIP+TgFijMJqYKI9tCjQPH
         YRZNMlkJYGUShAuuaubTth766dFzwC97mhEvLv92FVgED70KfLhaAlXmrkTIA/NF1w
         fNZS0wYbOjd/5N5hfB/C/xveL07/1vTWRzqHjP2w=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37A0wsJ4072661
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Aug 2023 19:58:54 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 9
 Aug 2023 19:58:53 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 9 Aug 2023 19:58:53 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37A0wr2F030688;
        Wed, 9 Aug 2023 19:58:53 -0500
From:   Hari Nagalla <hnagalla@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v2 1/5] dt-bindings: remoteproc: k3-dsp: correct optional sram properties for AM62A SoCs
Date:   Wed, 9 Aug 2023 19:58:46 -0500
Message-ID: <20230810005850.21998-2-hnagalla@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230810005850.21998-1-hnagalla@ti.com>
References: <20230810005850.21998-1-hnagalla@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The C7xv-dsp on AM62A have 32KB L1 I-cache and a 64KB L1 D-cache. It
does not have an addressable l1dram . So, remove this optional sram
property from the bindings to fix device tree build warnings.

Also set the 'memory-regions' property as optional. This is because
the remote processors can function without carveout regions.

Signed-off-by: Hari Nagalla <hnagalla@ti.com>
---
Changes since v1:
 - Corrected dsp node binding doc file to fix yamllint warnings for am62a.

 .../bindings/remoteproc/ti,k3-dsp-rproc.yaml     | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
index f16e90380df1..8dd22c57e22d 100644
--- a/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
@@ -111,7 +111,6 @@ else:
     properties:
       compatible:
         enum:
-          - ti,am62a-c7xv-dsp
           - ti,j721e-c71-dsp
           - ti,j721s2-c71-dsp
   then:
@@ -124,6 +123,20 @@ else:
         items:
           - const: l2sram
           - const: l1dram
+  else:
+    if:
+      properties:
+        compatible:
+          enum:
+            - ti,am62a-c7xv-dsp
+    then:
+      properties:
+        reg:
+          items:
+            - description: Address and Size of the L2 SRAM internal memory region
+        reg-names:
+          items:
+            - const: l2sram
 
 required:
   - compatible
@@ -135,7 +148,6 @@ required:
   - resets
   - firmware-name
   - mboxes
-  - memory-region
 
 unevaluatedProperties: false
 
-- 
2.34.1

