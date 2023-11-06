Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9467E2FF3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 23:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbjKFWjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 17:39:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbjKFWjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 17:39:49 -0500
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CE81BF;
        Mon,  6 Nov 2023 14:39:46 -0800 (PST)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1r08Fu-0004w8-1M;
        Mon, 06 Nov 2023 22:39:38 +0000
Date:   Mon, 6 Nov 2023 22:39:31 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Kalle Valo <kvalo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Daniel Golle <daniel@makrotopia.org>,
        StanleyYP Wang <StanleyYP.Wang@mediatek.com>,
        Peter Chiu <chui-hao.chiu@mediatek.com>,
        Howard Hsu <howard-yh.hsu@mediatek.com>,
        Rany Hany <rany_hany@riseup.net>,
        Simon Horman <horms@kernel.org>,
        Alexander Couzens <lynxis@fe80.eu>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 2/2] wifi: mt76: mt7915: also MT7981 is 3T3R but nss2 on 5
 GHz band
Message-ID: <3e43ce8ae3dc80d02a4393e0d28de2fbf7e938db.1699310162.git.daniel@makrotopia.org>
References: <58c999ad9fd073183bec5532fe62782b7d4be0d5.1699310162.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58c999ad9fd073183bec5532fe62782b7d4be0d5.1699310162.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: StanleyYP Wang <StanleyYP.Wang@mediatek.com>

Just like MT7916 also MT7981 can handle 3T3R DBDC frontend and should
hence be included in the corresponding conditional expression in the
driver. Add it.

Fixes: 6bad146d162e ("wifi: mt76: mt7915: add support for MT7981")
Signed-off-by: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/wireless/mediatek/mt76/mt7915/main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 8ebbf186fab23..e667de50ece23 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -1045,8 +1045,9 @@ mt7915_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
 
 	phy->mt76->antenna_mask = tx_ant;
 
-	/* handle a variant of mt7916 which has 3T3R but nss2 on 5 GHz band */
-	if (is_mt7916(&dev->mt76) && band && hweight8(tx_ant) == max_nss)
+	/* handle a variant of mt7916/mt7981 which has 3T3R but nss2 on 5 GHz band */
+	if ((is_mt7916(&dev->mt76) || is_mt7981(&dev->mt76)) &&
+	    band && hweight8(tx_ant) == max_nss)
 		phy->mt76->chainmask = (dev->chainmask >> chainshift) << chainshift;
 	else
 		phy->mt76->chainmask = tx_ant << (chainshift * band);
-- 
2.42.0

