Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9AB76A41A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 00:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbjGaWXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 18:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjGaWXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 18:23:54 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4549812B;
        Mon, 31 Jul 2023 15:23:53 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1qQbIe-0002Rs-10;
        Mon, 31 Jul 2023 22:23:37 +0000
Date:   Mon, 31 Jul 2023 23:23:16 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH net-next v3 1/2] dt-bindings: mt76: support setting per-band
 MAC address
Message-ID: <d3130584b64309da28a04826100643ff6239f9ca.1690841657.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce support for setting individual per-band MAC addresses using
NVMEM cells by adding a 'bands' object with enumerated child nodes
representing the 2.4 GHz, 5 GHz and 6 GHz bands.

In case it is defined, call of_get_mac_address for the per-band child
node, otherwise try with of_get_mac_address on the main device node and
fall back to a random address like it used to be.

While at it, add MAC address related properties also for the main node.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
Changes since v2:
 * drop items list with only a single item

Changes since v1:
 * add dt-bindings

 .../bindings/net/wireless/mediatek,mt76.yaml  | 58 ++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
index 252207adbc54c..7eafed53da1de 100644
--- a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
@@ -37,6 +37,12 @@ properties:
     description:
       MT7986 should contain 3 regions consys, dcm, and sku, in this order.
 
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
   interrupts:
     maxItems: 1
 
@@ -72,13 +78,23 @@ properties:
 
   ieee80211-freq-limit: true
 
+  address: true
+
+  local-mac-address: true
+
+  mac-address: true
+
   nvmem-cells:
+    minItems: 1
     items:
       - description: NVMEM cell with EEPROM
+      - description: NVMEM cell with the MAC address
 
   nvmem-cell-names:
+    minItems: 1
     items:
       - const: eeprom
+      - const: mac-address
 
   mediatek,eeprom-data:
     $ref: /schemas/types.yaml#/definitions/uint32-array
@@ -213,6 +229,29 @@ properties:
                     description:
                       Half-dBm power delta for different numbers of antennas
 
+patternProperties:
+  '^band@[0-2]+$':
+    type: object
+    additionalProperties: false
+    properties:
+      reg:
+        maxItems: 1
+
+      address: true
+      local-mac-address: true
+      mac-address: true
+
+      nvmem-cells:
+        description: NVMEM cell with the MAC address
+
+      nvmem-cell-names:
+        const: mac-address
+
+    required:
+      - reg
+
+    unevaluatedProperties: false
+
 required:
   - compatible
   - reg
@@ -225,10 +264,13 @@ examples:
       #address-cells = <3>;
       #size-cells = <2>;
       wifi@0,0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
         compatible = "mediatek,mt76";
         reg = <0x0000 0 0 0 0>;
         ieee80211-freq-limit = <5000000 6000000>;
-        mediatek,mtd-eeprom = <&factory 0x8000>;
+        nvmem-cells = <&factory_eeprom>;
+        nvmem-cell-names = "eeprom";
         big-endian;
 
         led {
@@ -257,6 +299,20 @@ examples:
              };
           };
         };
+
+        band@0 {
+          /* 2.4 GHz */
+          reg = <0>;
+          nvmem-cells = <&macaddr 0x4>;
+          nvmem-cell-names = "mac-address";
+        };
+
+        band@1 {
+          /* 5 GHz */
+          reg = <1>;
+          nvmem-cells = <&macaddr 0xa>;
+          nvmem-cell-names = "mac-address";
+        };
       };
     };
 
-- 
2.41.0
