Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9E07D0BF6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 11:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376779AbjJTJe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 05:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376760AbjJTJew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 05:34:52 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id EABE7D6A;
        Fri, 20 Oct 2023 02:34:48 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 4E2316057E9B6;
        Fri, 20 Oct 2023 17:34:43 +0800 (CST)
X-MD-Sfrom: yunchuan@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Wu Yunchuan <yunchuan@nfschina.com>
To:     nbd@nbd.name, lorenzo@kernel.org, ryder.lee@mediatek.com,
        shayne.chen@mediatek.com, sean.wang@mediatek.com, kvalo@kernel.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com
Cc:     Wu Yunchuan <yunchuan@nfschina.com>, Bo.Jiao@mediatek.com,
        horms@kernel.org, sujuan.chen@mediatek.com,
        chui-hao.chiu@mediatek.com, howard-yh.hsu@mediatek.com,
        deren.wu@mediatek.com, quan.zhou@mediatek.com,
        yn.chen@mediatek.com, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel-janitors@vger.kernel.org
Subject: [PATCH wireless-next 2/2] wifi: mt76: Remove unnecessary (void*) conversions
Date:   Fri, 20 Oct 2023 17:34:32 +0800
Message-Id: <20231020093432.214001-2-yunchuan@nfschina.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231020093432.214001-1-yunchuan@nfschina.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need cast (void *) to (struct mt7615_phy *).

Signed-off-by: Wu Yunchuan <yunchuan@nfschina.com>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c | 4 ++--
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 2 +-
 drivers/net/wireless/mediatek/mt76/mt792x_mac.c | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 2 +-
 7 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 955974a82180..ae34d019e588 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -453,7 +453,7 @@ mt7615_mcu_scan_event(struct mt7615_dev *dev, struct sk_buff *skb)
 	else
 		mphy = &dev->mt76.phy;
 
-	phy = (struct mt7615_phy *)mphy->priv;
+	phy = mphy->priv;
 
 	spin_lock_bh(&dev->mt76.lock);
 	__skb_queue_tail(&phy->scan_event_list, skb);
@@ -481,7 +481,7 @@ mt7615_mcu_roc_event(struct mt7615_dev *dev, struct sk_buff *skb)
 
 	ieee80211_ready_on_channel(mphy->hw);
 
-	phy = (struct mt7615_phy *)mphy->priv;
+	phy = mphy->priv;
 	phy->roc_grant = true;
 	wake_up(&phy->roc_wait);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 2222fb9aa103..f12008244db3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1247,7 +1247,7 @@ mt7915_phy_get_nf(struct mt7915_phy *phy, int idx)
 
 void mt7915_update_channel(struct mt76_phy *mphy)
 {
-	struct mt7915_phy *phy = (struct mt7915_phy *)mphy->priv;
+	struct mt7915_phy *phy = mphy->priv;
 	struct mt76_channel_state *state = mphy->chan_state;
 	int nf;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index b22f06d4411a..c67c4f6ca2aa 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -269,7 +269,7 @@ mt7915_mcu_rx_thermal_notify(struct mt7915_dev *dev, struct sk_buff *skb)
 	    dev->mt76.phys[MT_BAND1])
 		mphy = dev->mt76.phys[MT_BAND1];
 
-	phy = (struct mt7915_phy *)mphy->priv;
+	phy = mphy->priv;
 	phy->throttle_state = t->ctrl.duty.duty_cycle;
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 63f3d4a5c9aa..a02ce5554687 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -160,7 +160,7 @@ static void
 mt7921_mcu_scan_event(struct mt792x_dev *dev, struct sk_buff *skb)
 {
 	struct mt76_phy *mphy = &dev->mt76.phy;
-	struct mt792x_phy *phy = (struct mt792x_phy *)mphy->priv;
+	struct mt792x_phy *phy = mphy->priv;
 
 	spin_lock_bh(&dev->mt76.lock);
 	__skb_queue_tail(&phy->scan_event_list, skb);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 9c0e397537ac..c5fd7116929b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -345,7 +345,7 @@ static void
 mt7925_mcu_scan_event(struct mt792x_dev *dev, struct sk_buff *skb)
 {
 	struct mt76_phy *mphy = &dev->mt76.phy;
-	struct mt792x_phy *phy = (struct mt792x_phy *)mphy->priv;
+	struct mt792x_phy *phy = mphy->priv;
 
 	spin_lock_bh(&dev->mt76.lock);
 	__skb_queue_tail(&phy->scan_event_list, skb);
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_mac.c b/drivers/net/wireless/mediatek/mt76/mt792x_mac.c
index 5d1f8229fdc1..eb29434abee1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_mac.c
@@ -223,7 +223,7 @@ static void
 mt792x_phy_update_channel(struct mt76_phy *mphy, int idx)
 {
 	struct mt792x_dev *dev = container_of(mphy->dev, struct mt792x_dev, mt76);
-	struct mt792x_phy *phy = (struct mt792x_phy *)mphy->priv;
+	struct mt792x_phy *phy = mphy->priv;
 	struct mt76_channel_state *state;
 	u64 busy_time, tx_time, rx_time, obss_time;
 	int nf;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 04540833485f..1130c25a0965 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1525,7 +1525,7 @@ mt7996_phy_get_nf(struct mt7996_phy *phy, u8 band_idx)
 
 void mt7996_update_channel(struct mt76_phy *mphy)
 {
-	struct mt7996_phy *phy = (struct mt7996_phy *)mphy->priv;
+	struct mt7996_phy *phy = mphy->priv;
 	struct mt76_channel_state *state = mphy->chan_state;
 	int nf;
 
-- 
2.30.2

