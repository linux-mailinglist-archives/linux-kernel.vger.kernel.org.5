Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C804777677
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 13:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233587AbjHJLGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 07:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbjHJLGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 07:06:05 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67D1211B;
        Thu, 10 Aug 2023 04:06:02 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37AB5tO7088044;
        Thu, 10 Aug 2023 06:05:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691665555;
        bh=PVflcmV5/EUDy1cuZfknvEy0uj9dMjDS8ydBn356VLo=;
        h=From:To:CC:Subject:Date;
        b=tKogjRQYsipTbS79UiNIQjJUS31SfM2UJb82yJj/qYkp85l610+udEwB3IDS557vZ
         7aTK7bKU4UhYnMZDrTLI0jsSd7Pd9CFP7EVrGEpWJxQzu7BRwQqsagkOazFqB0Keq4
         KMTrgUBm0iBLpYvgSORgaohirHc9qnp00nd1rD5I=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37AB5t2W049300
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Aug 2023 06:05:55 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 10
 Aug 2023 06:05:55 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 10 Aug 2023 06:05:55 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37AB5txa041652;
        Thu, 10 Aug 2023 06:05:55 -0500
From:   Hari Nagalla <hnagalla@ti.com>
To:     <andersson@kernel.org>, <mathieu.poirier@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <s-anna@ti.com>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH] dt-bindings: remoteproc: k3-dsp: correct optional sram properties for AM62A SoCs
Date:   Thu, 10 Aug 2023 06:05:45 -0500
Message-ID: <20230810110545.11644-1-hnagalla@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

