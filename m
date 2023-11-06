Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035537E2FF1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 23:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbjKFWjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 17:39:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233166AbjKFWjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 17:39:18 -0500
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80ABD57;
        Mon,  6 Nov 2023 14:39:15 -0800 (PST)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1r08FI-0004vV-2h;
        Mon, 06 Nov 2023 22:39:00 +0000
Date:   Mon, 6 Nov 2023 22:38:53 +0000
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
Subject: [PATCH 1/2] wifi: mt76: mt7915: fix EEPROM offset of TSSI flag on
 MT7981
Message-ID: <58c999ad9fd073183bec5532fe62782b7d4be0d5.1699310162.git.daniel@makrotopia.org>
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

From: StanleyYP Wang <StanleyYP.Wang@mediatek.com>

The offset of the TSSI flag on the EEPROM of MT7981 devices was wrong.
Set the correct offset instead.

Fixes: 6bad146d162e ("wifi: mt76: mt7915: add support for MT7981")
Signed-off-by: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h
index f3e56817d36e9..adc26a222823b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h
@@ -144,7 +144,8 @@ static inline bool
 mt7915_tssi_enabled(struct mt7915_dev *dev, enum nl80211_band band)
 {
 	u8 *eep = dev->mt76.eeprom.data;
-	u8 val = eep[MT_EE_WIFI_CONF + 7];
+	u8 offs = is_mt7981(&dev->mt76) ? 8 : 7;
+	u8 val = eep[MT_EE_WIFI_CONF + offs];
 
 	if (band == NL80211_BAND_2GHZ)
 		return val & MT_EE_WIFI_CONF7_TSSI0_2G;
-- 
2.42.0

