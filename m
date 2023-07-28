Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2138176621B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 04:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbjG1Cvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 22:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjG1Cvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 22:51:38 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D4B2686;
        Thu, 27 Jul 2023 19:51:32 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1qPDZc-000096-2m;
        Fri, 28 Jul 2023 02:51:24 +0000
Date:   Fri, 28 Jul 2023 03:51:16 +0100
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
Subject: [PATCH v2 2/2] wifi: mt76: support per-band MAC addresses from OF
 child nodes
Message-ID: <4958730e4f88b91442fa96365785d467fad502de.1690512516.git.daniel@makrotopia.org>
References: <6e9cfac5758dd06429fadf6c1c70c569c86f3a95.1690512516.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e9cfac5758dd06429fadf6c1c70c569c86f3a95.1690512516.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With dual-band-dual-congruent front-ends which appear as two independent
radios it is desirable to assign a per-band MAC address from device-tree,
eg. using nvmem-cells.
Support specifying MAC-address related properties in band-specific child
nodes, e.g.
        mt7915@0,0 {
                reg = <0x0000 0 0 0 0>;
                #addr-cells = <1>;
                #size-cells = <0>;

                band@0 {
                        /* 2.4 GHz */
                        reg = <0>;
                        nvmem-cells = <&macaddr 2>;
                        nvmem-cell-names = "mac-address";
                };

                band@1 {
                        /* 5 GHz */
                        reg = <1>;
                        nvmem-cells = <&macaddr 3>;
                        nvmem-cell-names = "mac-address";
                };
        };

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/wireless/mediatek/mt76/eeprom.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/eeprom.c b/drivers/net/wireless/mediatek/mt76/eeprom.c
index 36564930aef12..c2b3386cada1c 100644
--- a/drivers/net/wireless/mediatek/mt76/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/eeprom.c
@@ -161,9 +161,25 @@ void
 mt76_eeprom_override(struct mt76_phy *phy)
 {
 	struct mt76_dev *dev = phy->dev;
-	struct device_node *np = dev->dev->of_node;
+	struct device_node *np = dev->dev->of_node, *band_np;
+	bool found_mac = false;
+	u32 reg;
+	int ret;
+
+	for_each_child_of_node(np, band_np) {
+		ret = of_property_read_u32(band_np, "reg", &reg);
+		if (ret)
+			continue;
+
+		if (reg == phy->band_idx) {
+			found_mac = !of_get_mac_address(band_np, phy->macaddr);
+			of_node_put(band_np);
+			break;
+		}
+	}
 
-	of_get_mac_address(np, phy->macaddr);
+	if (!found_mac)
+		of_get_mac_address(np, phy->macaddr);
 
 	if (!is_valid_ether_addr(phy->macaddr)) {
 		eth_random_addr(phy->macaddr);
-- 
2.41.0
