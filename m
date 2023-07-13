Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B803575167F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 04:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233484AbjGMCuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 22:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbjGMCuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 22:50:20 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B518310EC;
        Wed, 12 Jul 2023 19:50:19 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1qJmPJ-0005jB-0P;
        Thu, 13 Jul 2023 02:50:17 +0000
Date:   Thu, 13 Jul 2023 03:50:04 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Kalle Valo <kvalo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        John Crispin <john@phrozen.org>
Subject: [PATCH] wifi: mt76: support per-band MAC addresses from OF child
 nodes
Message-ID: <ZK9mXE00xEHZV4fi@makrotopia.org>
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
 drivers/net/wireless/mediatek/mt76/eeprom.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/eeprom.c b/drivers/net/wireless/mediatek/mt76/eeprom.c
index dce851d42e083..90ee138843a55 100644
--- a/drivers/net/wireless/mediatek/mt76/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/eeprom.c
@@ -106,7 +106,20 @@ void
 mt76_eeprom_override(struct mt76_phy *phy)
 {
 	struct mt76_dev *dev = phy->dev;
-	struct device_node *np = dev->dev->of_node;
+	struct device_node *child_np, *np = dev->dev->of_node;
+	u32 reg;
+	int ret;
+
+	for_each_child_of_node(np, child_np) {
+		ret = of_property_read_u32(child_np, "reg", &reg);
+		if (ret)
+			continue;
+
+		if (reg == phy->band_idx) {
+			np = child_np;
+			break;
+		}
+	}
 
 	of_get_mac_address(np, phy->macaddr);
 
-- 
2.41.0

