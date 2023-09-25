Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2227AE254
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 01:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233523AbjIYXfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 19:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjIYXfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 19:35:13 -0400
Received: from mo-csw.securemx.jp (mo-csw1800.securemx.jp [210.130.202.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556D610C;
        Mon, 25 Sep 2023 16:35:06 -0700 (PDT)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 38PNYcE63254912; Tue, 26 Sep 2023 08:34:38 +0900
X-Iguazu-Qid: 2yAamNv3Hdm5ss8ObB
X-Iguazu-QSIG: v=2; s=0; t=1695684878; q=2yAamNv3Hdm5ss8ObB; m=4CKC7fq3bEeu+oe2Km30DmtaFOJ0dzfnSYt5DXFKzJE=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1801) id 38PNYbVi3694591
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 26 Sep 2023 08:34:37 +0900
X-SA-MID: 8623330
From:   Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 1/5] dt-bindings: media: platform: visconti: Add Toshiba Visconti Video Input Interface
Date:   Tue, 26 Sep 2023 08:28:02 +0900
X-TSB-HOP2: ON
Message-Id: <20230925232806.950683-2-yuji2.ishikawa@toshiba.co.jp>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925232806.950683-1-yuji2.ishikawa@toshiba.co.jp>
References: <20230925232806.950683-1-yuji2.ishikawa@toshiba.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds the Device Tree binding documentation that allows to describe
the Video Input Interface found in Toshiba Visconti SoCs.

Signed-off-by: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
Changelog v2:
- no change

Changelog v3:
- no change

Changelog v4:
- fix style problems at the v3 patch
- remove "index" member
- update example

Changelog v5:
- no change

Changelog v6:
- add register definition of BUS-IF and MPU

Changelog v7:
- remove trailing "bindings" from commit header message
- remove trailing "Device Tree Bindings" from title
- fix text wrapping of description
- change compatible to visconti5-viif
- explicitly define allowed properties for port::endpoint

Changelog v8:
- Suggestion from Krzysztof Kozlowski
  - rename bindings description file
  - use block style array instead of inline style
  - remove clock-lane (as it is fixed at position 0)
  - update sample node's name
  - use lowercase hex for literals
- Suggestion from Laurent Pinchart
  - update description message port::description
  - remove port::endpoint::bus-type as it is fixed to <4>
  - remove port::endpoint::clock-lanes from example
  - add port::endpoint::data-lanes to required parameters list
  - fix sequence of data-lanes: <1 2 3 4> because current driver does not support data reordering
  - update port::endpoint::data-lanes::description
  - remove redundant type definition for port::endpoint::data-lanes

 .../media/toshiba,visconti5-viif.yaml         | 105 ++++++++++++++++++
 1 file changed, 105 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/toshiba,visconti5-viif.yaml

diff --git a/Documentation/devicetree/bindings/media/toshiba,visconti5-viif.yaml b/Documentation/devicetree/bindings/media/toshiba,visconti5-viif.yaml
new file mode 100644
index 000000000000..7ac1f5c5e9d5
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/toshiba,visconti5-viif.yaml
@@ -0,0 +1,105 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/toshiba,visconti5-viif.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Toshiba Visconti5 SoC Video Input Interface
+
+maintainers:
+  - Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
+
+description: |-
+  Toshiba Visconti5 SoC Video Input Interface (VIIF) receives MIPI CSI2 video
+  stream, processes the stream with image signal processors (L1ISP, L2ISP),
+  then stores pictures to main memory.
+
+properties:
+  compatible:
+    const: toshiba,visconti5-viif
+
+  reg:
+    items:
+      - description: Registers for capture control
+      - description: Registers for CSI2 receiver control
+      - description: Registers for bus interface unit control
+      - description: Registers for Memory Protection Unit
+
+  interrupts:
+    items:
+      - description: Sync Interrupt
+      - description: Status (Error) Interrupt
+      - description: CSI2 Receiver Interrupt
+      - description: L1ISP Interrupt
+
+  port:
+    $ref: /schemas/graph.yaml#/$defs/port-base
+    unevaluatedProperties: false
+    description: CSI-2 input port, with a single endpoint connected to the CSI-2 transmitter.
+
+    properties:
+      endpoint:
+        $ref: video-interfaces.yaml#
+        additionalProperties: false
+
+        required:
+          - clock-noncontinuous
+          - link-frequencies
+          - remote-endpoint
+          - data-lanes
+
+        properties:
+          data-lanes:
+            description: VIIF supports 1, 2, 3 or 4 data lanes
+            minItems: 1
+            items:
+              - const: 1
+              - const: 2
+              - const: 3
+              - const: 4
+
+          clock-noncontinuous: true
+          link-frequencies: true
+          remote-endpoint: true
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        video@1c000000 {
+            compatible = "toshiba,visconti5-viif";
+            reg = <0 0x1c000000 0 0x6000>,
+                  <0 0x1c008000 0 0x400>,
+                  <0 0x1c00e000 0 0x1000>,
+                  <0 0x2417a000 0 0x1000>;
+            interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
+
+            port {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                csi_in0: endpoint {
+                    remote-endpoint = <&imx219_out0>;
+                    data-lanes = <1 2>;
+                    clock-noncontinuous;
+                    link-frequencies = /bits/ 64 <456000000>;
+                };
+            };
+        };
+    };
-- 
2.34.1


