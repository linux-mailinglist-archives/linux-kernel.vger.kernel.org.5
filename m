Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C77E774892
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbjHHTfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236376AbjHHTfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:35:24 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DC87D797;
        Tue,  8 Aug 2023 10:23:12 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3784jYY6092030;
        Mon, 7 Aug 2023 23:45:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691469934;
        bh=e1qpTh7OgoPv/Lc8NJeUn0X/U4gQfp0Iaxx1TIJy1g8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=hfZ5LmzWkaBZ1+Ol/ywTGzAwwcZWy4oBvMLlyAz5c4ujSLooblbjvVOx7TRkVVrgR
         80ndbpIMLf/yPi6v+yPYWyi+gCkNLmAlPbMv1IaE828a6+7KXCI+XN3teRkr+7tiLZ
         UD1AzhvHKSfYAuQKJnsIftj68W7OBNPFMNA0hXg4=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3784jYY8073747
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Aug 2023 23:45:34 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 7
 Aug 2023 23:45:33 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 7 Aug 2023 23:45:33 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3784jXcH098630;
        Mon, 7 Aug 2023 23:45:33 -0500
From:   Hari Nagalla <hnagalla@ti.com>
To:     <andersson@kernel.org>, <mathieu.poirier@linaro.org>,
        <p.zabel@pengutronix.de>, <martyn.welch@collabora.com>,
        <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v5 1/5] dt-bindings: remoteproc: k3-m4f: Add K3 AM64x SoCs
Date:   Mon, 7 Aug 2023 23:45:25 -0500
Message-ID: <20230808044529.25925-2-hnagalla@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230808044529.25925-1-hnagalla@ti.com>
References: <20230808044529.25925-1-hnagalla@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

K3 AM64x SoC has a Cortex M4F subsystem in the MCU voltage domain.
The remote processor's life cycle management and IPC mechanisms are
similar across the R5F and M4F cores from remote processor driver
point of view. However, there are subtle differences in image loading
and starting the M4F subsystems.

The YAML binding document provides the various node properties to be
configured by the consumers of the M4F subsystem.

Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
Signed-off-by: Hari Nagalla <hnagalla@ti.com>
---
Changes since v1:
 - Spelling corrections
 - Corrected to pass DT checks

Changes since v2:
 - Missed spelling correction to commit message

Changes since v3:
 - Removed unnecessary descriptions and used generic memory region names
 - Made mboxes and memory-region optional
 - Removed unrelated items from examples

Changes since v4:
 - Rebased to the latest kernel-next tree
 - Added optional sram memory region for m4f device node

 .../bindings/remoteproc/ti,k3-m4f-rproc.yaml  | 136 ++++++++++++++++++
 1 file changed, 136 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.yaml
new file mode 100644
index 000000000000..21b7f14d9dc4
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.yaml
@@ -0,0 +1,136 @@
+# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/remoteproc/ti,k3-m4f-rproc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI K3 M4F processor subsystems
+
+maintainers:
+  - Hari Nagalla <hnagalla@ti.com>
+  - Mathieu Poirier <mathieu.poirier@linaro.org>
+
+description: |
+  Some K3 family SoCs have Arm Cortex M4F cores. AM64x is a SoC in K3
+  family with a M4F core. Typically safety oriented applications may use
+  the M4F core in isolation without an IPC. Where as some industrial and
+  home automation applications, may use the M4F core as a remote processor
+  with IPC communications.
+
+$ref: /schemas/arm/keystone/ti,k3-sci-common.yaml#
+
+properties:
+
+  compatible:
+    enum:
+      - ti,am64-m4fss
+
+  power-domains:
+    maxItems: 1
+
+  "#address-cells":
+    const: 2
+
+  "#size-cells":
+    const: 2
+
+  reg:
+    items:
+      - description: IRAM internal memory region
+      - description: DRAM internal memory region
+
+  reg-names:
+    items:
+      - const: iram
+      - const: dram
+
+  resets:
+    maxItems: 1
+
+  firmware-name:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: Name of firmware to load for the M4F core
+
+  mboxes:
+    description: |
+      Mailbox specifier denoting the sub-mailbox, to be used for communication
+      with the remote processor. This property should match with the
+      sub-mailbox node used in the firmware image.
+    maxItems: 2
+
+  memory-region:
+    description: |
+      phandle to the reserved memory nodes to be associated with the
+      remoteproc device. The reserved memory nodes should be carveout nodes,
+      and should be defined with a "no-map" property as per the bindings in
+      Documentation/devicetree/bindings/reserved-memory/reserved-memory.yaml
+      Optional memory regions available for firmware specific purposes.
+    maxItems: 8
+    items:
+      - description: regions used for DMA allocations like vrings, vring buffers
+                     and memory dedicated to firmware's specific purposes.
+    additionalItems: true
+
+  sram:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    minItems: 1
+    maxItems: 4
+    items:
+      maxItems: 4
+    description: |
+      phandles to one or more reserved on-chip SRAM regions. The regions
+      should be defined as child nodes of the respective SRAM node, and
+      should be defined as per the generic bindings in,
+      Documentation/devicetree/bindings/sram/sram.yaml
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - ti,sci
+  - ti,sci-dev-id
+  - ti,sci-proc-ids
+  - resets
+  - firmware-name
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    reserved-memory {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        mcu_m4fss_dma_memory_region: m4f-dma-memory@9cb00000 {
+            compatible = "shared-dma-pool";
+            reg = <0x00 0x9cb00000 0x00 0x100000>;
+            no-map;
+        };
+
+        mcu_m4fss_memory_region: m4f-memory@9cc00000 {
+            compatible = "shared-dma-pool";
+            reg = <0x00 0x9cc00000 0x00 0xe00000>;
+            no-map;
+        };
+    };
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        remoteproc@5000000 {
+            compatible = "ti,am64-m4fss";
+            reg = <0x00 0x5000000 0x00 0x30000>,
+                  <0x00 0x5040000 0x00 0x10000>;
+            reg-names = "iram", "dram";
+            ti,sci = <&dmsc>;
+            ti,sci-dev-id = <9>;
+            ti,sci-proc-ids = <0x18 0xff>;
+            resets = <&k3_reset 9 1>;
+            firmware-name = "am62-mcu-m4f0_0-fw";
+            mboxes = <&mailbox0_cluster0>, <&mbox_m4_0>;
+            memory-region = <&mcu_m4fss_dma_memory_region>,
+                            <&mcu_m4fss_memory_region>;
+            sram = <&oc_sram>;
+         };
+    };
-- 
2.34.1

