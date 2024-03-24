Return-Path: <linux-kernel+bounces-115480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9970889BD1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A7021F2AD76
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E424229D9A;
	Mon, 25 Mar 2024 02:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GICIdG/9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE251DE100;
	Sun, 24 Mar 2024 22:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320731; cv=none; b=o5+0fpcYJnHHzeqgvRyhD9clS2BlCipVvRGW47HwtvXVogy54wt9BvO9S52kFY5LBnWwZDBa4i8q3nGF9kBYG+ovanYOWKfI6qR4KgO7/8lXW5EtSaguUv5m9IKWKTfLOFRGPCXmYNpe6xPJr+SgrwJDt1rLvq7wYs1E7PiDPHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320731; c=relaxed/simple;
	bh=NRY+7Tj0qGy+7ZmIHN94EIlHoI0r19i0s2wSgIv4I9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MAZEda2xIBpcHc6PZHLrYTf81J0+ZGSVeMnDh1H9SRS/3/fL0NthP/C7RrDgD8k7vWD5MenRdZEvJz1T7DgVylO3H2u32wWxKUTIaERXA7WpTqrrNklywibHtOyVTEFS15BKqs/ffizipVYKL0pSBpklzTQxFFdYK2CsNs8b0J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GICIdG/9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D7A1C43394;
	Sun, 24 Mar 2024 22:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320730;
	bh=NRY+7Tj0qGy+7ZmIHN94EIlHoI0r19i0s2wSgIv4I9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GICIdG/99OHfQOHq80nVtF3o3aYUP8D7L9AbE6JooTshVuc2H9EWktQsbBUcgE9HE
	 ySHg+17jN5hRUQO3MERY4eohCNrwPXdepLU/vmFXaT6nRNCMuvfo1D/JZixJGXYby+
	 wi01flfeg2krXvlq613tTKf6poOVFLiqQ7e9oy/X60QmHeoHIqukHZodKRrAiToAwy
	 Daz72rbkZTzGvjyZsIrA3zwlnmnKEafwZN76Vs4tKoQIGGPkVVL8g6fjKT0AE+M3JS
	 +EyH74W9toVy4BW6zc2igDJGXqBfhVJMkerJoCEW1bgxNHDCh7kMXsbrM98pdAnRrI
	 LK+PZAlW779wA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Chiu <chui-hao.chiu@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 293/713] wifi: mt76: mt7996: check txs format before getting skb by pid
Date: Sun, 24 Mar 2024 18:40:19 -0400
Message-ID: <20240324224720.1345309-294-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Peter Chiu <chui-hao.chiu@mediatek.com>

[ Upstream commit 9c9c25f1dcdd98fffda564d2073f26219c84a2c3 ]

The PPDU TXS does not include the error bit so it cannot use to report
status to mac80211. This patch fixes issue that STA wrongly detects if AP
is still alive.

Fixes: 2569ea5326e2 ("wifi: mt76: mt7996: enable PPDU-TxS to host")
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7996/mac.c   | 23 +++++++++++--------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index fa3001e59a364..cee2ede268a2d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1178,25 +1178,28 @@ mt7996_mac_add_txs_skb(struct mt7996_dev *dev, struct mt76_wcid *wcid,
 	struct ieee80211_tx_info *info;
 	struct sk_buff_head list;
 	struct rate_info rate = {};
-	struct sk_buff *skb;
+	struct sk_buff *skb = NULL;
 	bool cck = false;
 	u32 txrate, txs, mode, stbc;
 
 	txs = le32_to_cpu(txs_data[0]);
 
 	mt76_tx_status_lock(mdev, &list);
-	skb = mt76_tx_status_skb_get(mdev, wcid, pid, &list);
 
-	if (skb) {
-		info = IEEE80211_SKB_CB(skb);
-		if (!(txs & MT_TXS0_ACK_ERROR_MASK))
-			info->flags |= IEEE80211_TX_STAT_ACK;
+	/* only report MPDU TXS */
+	if (le32_get_bits(txs_data[0], MT_TXS0_TXS_FORMAT) == 0) {
+		skb = mt76_tx_status_skb_get(mdev, wcid, pid, &list);
+		if (skb) {
+			info = IEEE80211_SKB_CB(skb);
+			if (!(txs & MT_TXS0_ACK_ERROR_MASK))
+				info->flags |= IEEE80211_TX_STAT_ACK;
 
-		info->status.ampdu_len = 1;
-		info->status.ampdu_ack_len =
-			!!(info->flags & IEEE80211_TX_STAT_ACK);
+			info->status.ampdu_len = 1;
+			info->status.ampdu_ack_len =
+				!!(info->flags & IEEE80211_TX_STAT_ACK);
 
-		info->status.rates[0].idx = -1;
+			info->status.rates[0].idx = -1;
+		}
 	}
 
 	if (mtk_wed_device_active(&dev->mt76.mmio.wed) && wcid->sta) {
-- 
2.43.0


