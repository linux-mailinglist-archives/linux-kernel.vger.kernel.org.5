Return-Path: <linux-kernel+bounces-113131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E500F8881B4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 225ED1C21D7C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629F815E5A4;
	Sun, 24 Mar 2024 22:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLnh3kk8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909A8160860;
	Sun, 24 Mar 2024 22:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319938; cv=none; b=OvixyPlYMtxThPnJQ7g4/AjzbSdXwNvKvdkmQ8I2s5JRtHFw7+knFHRVFFXgujLqCLy1iRR29oomxOkTdKwJakL7U57lcLvD+f7YEP0WuFcBgJrAlQ5E2XD9MeDSY9FY6S2PN2PERiJAzGAhY7w19X4z/gFOnDvq/xD9FTrHU6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319938; c=relaxed/simple;
	bh=jmipEGN2Qr/7Qt+ZoRYcn6UJow5481zKKbSe0sa1dF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=scjDqDHn30qq7NhFYvIkqBHdhBqZtlmC/soc9jAiZQMBAHfdD/zbNlAV42egTPrQK+ZFDb4+luisdcWAf7xcOF/EN4/IlSZfrJm0z013URsBktUsvWIsX36oxDezRSKsQ3asdVKdcP/I42pSVM8t4EFKQ4x9iRWLDzMdSw7jPtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLnh3kk8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9AC5C433A6;
	Sun, 24 Mar 2024 22:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319938;
	bh=jmipEGN2Qr/7Qt+ZoRYcn6UJow5481zKKbSe0sa1dF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jLnh3kk8Ue9pfJTk3gQHWld4JY1w0vsbFiP6Lgy6GBDj/5Oh07dKsLS0OOss2WHdk
	 xgrXjl6chZIGIrxRJKIh/osRzJWwjKttOEJIloe2TQa66F5aowB41hLd7avNo+0ILH
	 iFL2kJFfbaRbMd5ptQLlyX4BEJYyFBP9cmxJaK8ibuE3ALjE6gFM2edCJDuYJlfXTJ
	 G9uCLqvxKYbq98U8zVIUShtmyArb5kW0jLVigPY1xhHyBQX5N3j8u0Z19dVNfVN7Z/
	 5GLWouHJHXe0wegDveUR7EzX4op8BbBdPoRhFTVMtHGu7r/SxwiP0Zq3pk5XdAmamI
	 8OkSTWe09vtfQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Chiu <chui-hao.chiu@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 244/715] wifi: mt76: mt7996: check txs format before getting skb by pid
Date: Sun, 24 Mar 2024 18:27:03 -0400
Message-ID: <20240324223455.1342824-245-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index 53258488d49f3..a8414fbb07c82 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1188,25 +1188,28 @@ mt7996_mac_add_txs_skb(struct mt7996_dev *dev, struct mt76_wcid *wcid,
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


