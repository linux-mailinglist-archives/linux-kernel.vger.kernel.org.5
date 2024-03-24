Return-Path: <linux-kernel+bounces-115489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87773889BDD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B942E1C2D19D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3385022EAC7;
	Mon, 25 Mar 2024 02:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s2oUMfzl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B521DD2AB;
	Sun, 24 Mar 2024 22:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320726; cv=none; b=aon/NMBMKxHNlkb61kHS8TPcyjXO3LBGzchIQQMA+W20d9T7coxwM7dD1DiYSw+FMWjuDJHJl0hQHWdqfdhQ6gnEYGP6542gVKvz5USib5QoblomYRveAMYym8NtUPtg0jhtxsWUfzNgOJkg1RYSt01pa3v60ewGohp51Hyx9JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320726; c=relaxed/simple;
	bh=ZqHYJmWbjAaWX7RMHrG6rxMCX1+c2Hs/9yWUkPKYsSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lVgrdxzWPSIbfwxDdTy8pAV+pDgp9wGVD6ov9JHAEILVYizmfdMJRCcHEPpywbFhPfjZDiLMwS8Bxgi8bEwsufP7wMd33eSd0PsXQtzBvjN8pCeTZr5bEHt+h7KXbPKPW/xm0p5TiR1Y1q0S+1HcpaBZRQEhglCAOlBQPpKgc+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s2oUMfzl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96FE3C43399;
	Sun, 24 Mar 2024 22:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320726;
	bh=ZqHYJmWbjAaWX7RMHrG6rxMCX1+c2Hs/9yWUkPKYsSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s2oUMfzlsaUDxApqjwD2waZRo+nGDcSX68VH9WJz7gq53bQTie5J83uBB5DysXKuU
	 F+Ik6uKURqUWWNGQQcJcxkzk24yLez67AmzAUYTQOtqe8WyhRr3s0YvcoRYDE3AcWv
	 +JuFbidjOyQNqGc2yX5TNweFXsTc2PghtAhSqRanY1dpqXiKfc0pIOZ5AA5VdVvlBv
	 4UqgytJai5e6KmluKlI2NUJRq1ZK69gwRdw0y2CyADqw+6vbEa0EPiqKfz5Wb8QL3B
	 Vjl79PbnJ6+gClbZWobK/wyL/5UAyYhSgZKrZmnc1Zbz9wwBzjLTzVn9GGmAY7x/2Q
	 aknmVCwTWxDRA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 289/713] wifi: mt76: mt7925: fix the wrong header translation config
Date: Sun, 24 Mar 2024 18:40:15 -0400
Message-ID: <20240324224720.1345309-290-sashal@kernel.org>
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

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

[ Upstream commit d8cf7e1344727b80b4ec3dc17ca520238d55a88d ]

The header translation config should set to broadcast and unicast
cases correctly, not only unicast case. And also remove the cmds
of wtbl (wlan table) series, because these MCU commands have
already been replaced by other commands in mt7925.

Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 32 +++++--------------
 1 file changed, 8 insertions(+), 24 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index bafd6ec72ef24..28b871e552f0c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -814,6 +814,7 @@ mt7925_mcu_sta_hdr_trans_tlv(struct sk_buff *skb,
 			     struct ieee80211_vif *vif,
 			     struct ieee80211_sta *sta)
 {
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct sta_rec_hdr_trans *hdr_trans;
 	struct mt76_wcid *wcid;
 	struct tlv *tlv;
@@ -827,7 +828,11 @@ mt7925_mcu_sta_hdr_trans_tlv(struct sk_buff *skb,
 	else
 		hdr_trans->from_ds = true;
 
-	wcid = (struct mt76_wcid *)sta->drv_priv;
+	if (sta)
+		wcid = (struct mt76_wcid *)sta->drv_priv;
+	else
+		wcid = &mvif->sta.wcid;
+
 	if (!wcid)
 		return;
 
@@ -1577,8 +1582,6 @@ mt7925_mcu_sta_cmd(struct mt76_phy *phy,
 {
 	struct mt76_vif *mvif = (struct mt76_vif *)info->vif->drv_priv;
 	struct mt76_dev *dev = phy->dev;
-	struct wtbl_req_hdr *wtbl_hdr;
-	struct tlv *sta_wtbl;
 	struct sk_buff *skb;
 
 	skb = __mt76_connac_mcu_alloc_sta_req(dev, mvif, info->wcid,
@@ -1602,30 +1605,11 @@ mt7925_mcu_sta_cmd(struct mt76_phy *phy,
 		mt7925_mcu_sta_state_v2_tlv(phy, skb, info->sta,
 					    info->vif, info->rcpi,
 					    info->state);
-		mt7925_mcu_sta_hdr_trans_tlv(skb, info->vif, info->sta);
 		mt7925_mcu_sta_mld_tlv(skb, info->vif, info->sta);
 	}
 
-	sta_wtbl = mt76_connac_mcu_add_tlv(skb, STA_REC_WTBL,
-					   sizeof(struct tlv));
-
-	wtbl_hdr = mt76_connac_mcu_alloc_wtbl_req(dev, info->wcid,
-						  WTBL_RESET_AND_SET,
-						  sta_wtbl, &skb);
-	if (IS_ERR(wtbl_hdr))
-		return PTR_ERR(wtbl_hdr);
-
-	if (info->enable) {
-		mt76_connac_mcu_wtbl_generic_tlv(dev, skb, info->vif,
-						 info->sta, sta_wtbl,
-						 wtbl_hdr);
-		mt76_connac_mcu_wtbl_hdr_trans_tlv(skb, info->vif, info->wcid,
-						   sta_wtbl, wtbl_hdr);
-		if (info->sta)
-			mt76_connac_mcu_wtbl_ht_tlv(dev, skb, info->sta,
-						    sta_wtbl, wtbl_hdr,
-						    true, true);
-	}
+	if (info->enable)
+		mt7925_mcu_sta_hdr_trans_tlv(skb, info->vif, info->sta);
 
 	return mt76_mcu_skb_send_msg(dev, skb, info->cmd, true);
 }
-- 
2.43.0


