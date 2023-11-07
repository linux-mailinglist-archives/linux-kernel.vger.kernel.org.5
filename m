Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4977E3BB2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234096AbjKGMI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:08:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234079AbjKGMIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:08:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D82170B;
        Tue,  7 Nov 2023 04:08:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4469FC433C9;
        Tue,  7 Nov 2023 12:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699358881;
        bh=YTyv8HJFV07JTyfEcbnVeoTNlm0GOpkdppOSK7jQbjc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ac/X6xfWt0oQPG5YEXB19Fzr3YVwYAk20xouHyThRLditKwPLkqtDPOJzXmVzyJZ/
         bUGZXruu8LCo9T9QLBlo/WKs3i0+nPzpOLNXc8B2Xzk5kIx9YC4Q6mRIWzdX4JF5Vw
         u5ABYNQv9sboPTnh843T4CxnNA+CBHGpmeFQz0lIwmNa7n6x9nmRg0r2ULGwHiNavi
         o+CK3mq858NPMo6xDkxNIROak4m3MPXoJpGEBWgKZS2aXzuQd2matuWOiu0p1phJyK
         6L91KjXPtLrf4f4I0iOLr32TxeBdr9QaBs7DYexWAq9iJD2rL8Oxn5jRB1qmVsGTS9
         m3Ee/DEqz/xNA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     StanleyYP Wang <StanleyYP.Wang@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Felix Fietkau <nbd@nbd.name>, Sasha Levin <sashal@kernel.org>,
        lorenzo@kernel.org, ryder.lee@mediatek.com, kvalo@kernel.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        chui-hao.chiu@mediatek.com, meichia.chiu@mediatek.com,
        howard-yh.hsu@mediatek.com, linux-wireless@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 15/31] wifi: mt76: get rid of false alamrs of tx emission issues
Date:   Tue,  7 Nov 2023 07:06:02 -0500
Message-ID: <20231107120704.3756327-15-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107120704.3756327-1-sashal@kernel.org>
References: <20231107120704.3756327-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: StanleyYP Wang <StanleyYP.Wang@mediatek.com>

[ Upstream commit 413f05d68d11981f5984b49214d3a5a0d88079b1 ]

When the set_chan_info command is set with CH_SWITCH_NORMAL reason,
even if the action is UNI_CHANNEL_RX_PATH, it'll still generate some
unexpected tones, which might confuse DFS CAC tests that there are some
tone leakages. To get rid of these kinds of false alarms, always bypass
DPD calibration when IEEE80211_CONF_IDLE is set.

Reviewed-by: Evelyn Tsai <evelyn.tsai@mediatek.com>
Signed-off-by: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 6 +++---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 50ae7bf3af91c..b8bc7a885b108 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2725,10 +2725,10 @@ int mt7915_mcu_set_chan_info(struct mt7915_phy *phy, int cmd)
 	if (mt76_connac_spe_idx(phy->mt76->antenna_mask))
 		req.tx_path_num = fls(phy->mt76->antenna_mask);
 
-	if (cmd == MCU_EXT_CMD(SET_RX_PATH) ||
-	    dev->mt76.hw->conf.flags & IEEE80211_CONF_MONITOR)
+	if (dev->mt76.hw->conf.flags & IEEE80211_CONF_MONITOR)
 		req.switch_reason = CH_SWITCH_NORMAL;
-	else if (phy->mt76->hw->conf.flags & IEEE80211_CONF_OFFCHANNEL)
+	else if (phy->mt76->hw->conf.flags & IEEE80211_CONF_OFFCHANNEL ||
+		 phy->mt76->hw->conf.flags & IEEE80211_CONF_IDLE)
 		req.switch_reason = CH_SWITCH_SCAN_BYPASS_DPD;
 	else if (!cfg80211_reg_can_beacon(phy->mt76->hw->wiphy, chandef,
 					  NL80211_IFTYPE_AP))
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 4a30db49ef33f..a9bd7e0d93595 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -2960,10 +2960,10 @@ int mt7996_mcu_set_chan_info(struct mt7996_phy *phy, u16 tag)
 		.channel_band = ch_band[chandef->chan->band],
 	};
 
-	if (tag == UNI_CHANNEL_RX_PATH ||
-	    dev->mt76.hw->conf.flags & IEEE80211_CONF_MONITOR)
+	if (dev->mt76.hw->conf.flags & IEEE80211_CONF_MONITOR)
 		req.switch_reason = CH_SWITCH_NORMAL;
-	else if (phy->mt76->hw->conf.flags & IEEE80211_CONF_OFFCHANNEL)
+	else if (phy->mt76->hw->conf.flags & IEEE80211_CONF_OFFCHANNEL ||
+		 phy->mt76->hw->conf.flags & IEEE80211_CONF_IDLE)
 		req.switch_reason = CH_SWITCH_SCAN_BYPASS_DPD;
 	else if (!cfg80211_reg_can_beacon(phy->mt76->hw->wiphy, chandef,
 					  NL80211_IFTYPE_AP))
-- 
2.42.0

