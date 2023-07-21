Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACBB175D68E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 23:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjGUVcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 17:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjGUVc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 17:32:29 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E07135B7;
        Fri, 21 Jul 2023 14:32:28 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1qMxjW-0004ZI-2i;
        Fri, 21 Jul 2023 21:32:18 +0000
Date:   Fri, 21 Jul 2023 22:32:10 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Russell King <linux@armlinux.org.uk>,
        =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
        Greg Ungerer <gerg@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH net-next v4 2/9] dt-bindings: net: mediatek,net: add
 mt7988-eth binding
Message-ID: <5a333fa431562efed461ec5a987d6982db2ed620.1689974536.git.daniel@makrotopia.org>
References: <cover.1689974536.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1689974536.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce DT bindings for the MT7988 SoC to mediatek,net.yaml.
The MT7988 SoC got 3 Ethernet MACs operating at a maximum of
10 Gigabit/sec supported by 2 packet processor engines for
offloading tasks.
The first MAC is hard-wired to a built-in switch which exposes
four 1000Base-T PHYs as user ports.
It also comes with built-in 2500Base-T PHY which can be used
with the 2nd GMAC.
The 2nd and 3rd GMAC can be connected to external PHYs or provide
SFP(+) cages attached via SGMII, 1000Base-X, 2500Base-X, USXGMII,
5GBase-KR or 10GBase-KR.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 .../devicetree/bindings/net/mediatek,net.yaml | 82 +++++++++++++++++--
 1 file changed, 76 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/mediatek,net.yaml b/Documentation/devicetree/bindings/net/mediatek,net.yaml
index 38aa3d97ee234..8d3554818c377 100644
--- a/Documentation/devicetree/bindings/net/mediatek,net.yaml
+++ b/Documentation/devicetree/bindings/net/mediatek,net.yaml
@@ -24,6 +24,7 @@ properties:
       - mediatek,mt7629-eth
       - mediatek,mt7981-eth
       - mediatek,mt7986-eth
+      - mediatek,mt7988-eth
       - ralink,rt5350-eth
 
   reg:
@@ -61,6 +62,12 @@ properties:
       Phandle to the mediatek hifsys controller used to provide various clocks
       and reset to the system.
 
+  mediatek,infracfg:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the syscon node that handles the path from GMAC to
+      PHY variants.
+
   mediatek,sgmiisys:
     $ref: /schemas/types.yaml#/definitions/phandle-array
     minItems: 1
@@ -122,6 +129,8 @@ allOf:
             - const: gp1
             - const: gp2
 
+        mediatek,infracfg: false
+
         mediatek,pctl:
           $ref: /schemas/types.yaml#/definitions/phandle
           description:
@@ -152,6 +161,8 @@ allOf:
             - const: ethif
             - const: fe
 
+        mediatek,infracfg: false
+
         mediatek,wed: false
 
         mediatek,wed-pcie: false
@@ -184,6 +195,8 @@ allOf:
             - const: sgmii_ck
             - const: eth2pll
 
+        mediatek,infracfg: false
+
         mediatek,sgmiisys:
           minItems: 1
           maxItems: 1
@@ -229,12 +242,6 @@ allOf:
             - const: sgmii_ck
             - const: eth2pll
 
-        mediatek,infracfg:
-          $ref: /schemas/types.yaml#/definitions/phandle
-          description:
-            Phandle to the syscon node that handles the path from GMAC to
-            PHY variants.
-
         mediatek,sgmiisys:
           minItems: 2
           maxItems: 2
@@ -275,6 +282,8 @@ allOf:
             - const: netsys0
             - const: netsys1
 
+        mediatek,infracfg: false
+
         mediatek,sgmiisys:
           minItems: 2
           maxItems: 2
@@ -311,6 +320,67 @@ allOf:
             - const: netsys0
             - const: netsys1
 
+        mediatek,infracfg: false
+
+        mediatek,sgmiisys:
+          minItems: 2
+          maxItems: 2
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: mediatek,mt7988-eth
+    then:
+      properties:
+        interrupts:
+          minItems: 4
+
+        clocks:
+          minItems: 34
+          maxItems: 34
+
+        clock-names:
+          items:
+            - const: crypto
+            - const: fe
+            - const: gp2
+            - const: gp1
+            - const: gp3
+            - const: ethwarp_wocpu2
+            - const: ethwarp_wocpu1
+            - const: ethwarp_wocpu0
+            - const: esw
+            - const: netsys0
+            - const: netsys1
+            - const: sgmii_tx250m
+            - const: sgmii_rx250m
+            - const: sgmii2_tx250m
+            - const: sgmii2_rx250m
+            - const: top_usxgmii0_sel
+            - const: top_usxgmii1_sel
+            - const: top_sgm0_sel
+            - const: top_sgm1_sel
+            - const: top_xfi_phy0_xtal_sel
+            - const: top_xfi_phy1_xtal_sel
+            - const: top_eth_gmii_sel
+            - const: top_eth_refck_50m_sel
+            - const: top_eth_sys_200m_sel
+            - const: top_eth_sys_sel
+            - const: top_eth_xgmii_sel
+            - const: top_eth_mii_sel
+            - const: top_netsys_sel
+            - const: top_netsys_500m_sel
+            - const: top_netsys_pao_2x_sel
+            - const: top_netsys_sync_250m_sel
+            - const: top_netsys_ppefb_250m_sel
+            - const: top_netsys_warp_sel
+            - const: wocpu1
+            - const: wocpu0
+            - const: xgp1
+            - const: xgp2
+            - const: xgp3
+
         mediatek,sgmiisys:
           minItems: 2
           maxItems: 2
-- 
2.41.0
