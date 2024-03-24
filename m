Return-Path: <linux-kernel+bounces-115492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B800B889405
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C6671F2A944
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5EE157E68;
	Mon, 25 Mar 2024 02:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7oGAhKq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D971DE11A;
	Sun, 24 Mar 2024 22:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320733; cv=none; b=gs3s9Ynw6wMAP/WhYxDKwm9tIJOABj3WUiNUSh1MUSDXM5WXrIE6LauWjyWDI3YX5DBjOIvVNbpg+HyAdjnItvsnEEyf1jUgnYLynE52H27d5YqZctUj3tFPZUT/duW8QIbhrQAn5Oy3D69+TVIg8X05jDGM4MiMvjtK+zpTbg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320733; c=relaxed/simple;
	bh=p6qPeNnWXYgNp4uWdNFBa3tfwNbMNl1eH1kqn5EOHto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JU5XJUObhSgcjXzjNV8dCTywE06fZw9oE+m1oTNcYRJTNjD4f8/EinXeML3Ut3E/Y+q04vVyRFG+2bTCkpBlBQXZWCEWDbqE1gxUJKVZX/mPAbUtb3ObFpvB/84y1dAUPSMEMt1bVQcLwmkovukuYzmZrwBnYm84j9A7fuZtLnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7oGAhKq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82F02C433A6;
	Sun, 24 Mar 2024 22:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320732;
	bh=p6qPeNnWXYgNp4uWdNFBa3tfwNbMNl1eH1kqn5EOHto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R7oGAhKq71UQFwbWuKijCj26X1WA1u1Z2QXILigBr1l1laC8Dp+QYifu5duuclXKP
	 4CfP9PfdZpZXvlAaiHcBHxw8706ZkGBYOUr1Yy2lzT8gtGTjSFtaSpq2lfSIycn3KY
	 7mRSAQ+f4elDjVsvHOA/TsUYtqnASeTpvpfh7naIBBcmT/ym7sRTcKeA+e5pMHaNjm
	 NvEyOsprimh/JqbrTlDoc/Hif1zq7EDd5OOFYqAQ+7W+5hjjCcTBz9+jbg584WYfQx
	 yZt7gvxD1ORzkNO6zDwDzWeueBD22oliWew4DFHOXYAqO0h1+qHiaDelsPyGLpTPwp
	 e+fHNZJWc+enA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Benjamin Lin <benjamin-jw.lin@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 295/713] wifi: mt76: mt7996: fix incorrect interpretation of EHT MCS caps
Date: Sun, 24 Mar 2024 18:40:21 -0400
Message-ID: <20240324224720.1345309-296-sashal@kernel.org>
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

From: Benjamin Lin <benjamin-jw.lin@mediatek.com>

[ Upstream commit d52c97592f06552a4289008602b5d5b724084ba7 ]

The EHT MCS map subfield of 20 MHz-Only is not present in the EHT
capability of AP, so STA does not need to parse the subfield.
Moreover, AP should parse the subfield only if STA is 20 MHz-Only, which
can be confirmed by checking supported channel width in HE capability.

Fixes: 92aa2da9fa49 ("wifi: mt76: mt7996: enable EHT support in firmware")
Co-developed-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Benjamin Lin <benjamin-jw.lin@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 707db74f234ed..e7a7d943b168c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -1079,6 +1079,9 @@ mt7996_mcu_sta_he_6g_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
 static void
 mt7996_mcu_sta_eht_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
 {
+	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
+	struct ieee80211_vif *vif = container_of((void *)msta->vif,
+						 struct ieee80211_vif, drv_priv);
 	struct ieee80211_eht_mcs_nss_supp *mcs_map;
 	struct ieee80211_eht_cap_elem_fixed *elem;
 	struct sta_rec_eht *eht;
@@ -1098,8 +1101,17 @@ mt7996_mcu_sta_eht_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
 	eht->phy_cap = cpu_to_le64(*(u64 *)elem->phy_cap_info);
 	eht->phy_cap_ext = cpu_to_le64(elem->phy_cap_info[8]);
 
-	if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_20)
-		memcpy(eht->mcs_map_bw20, &mcs_map->only_20mhz, sizeof(eht->mcs_map_bw20));
+	if (vif->type != NL80211_IFTYPE_STATION &&
+	    (sta->deflink.he_cap.he_cap_elem.phy_cap_info[0] &
+	     (IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G |
+	      IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G |
+	      IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G |
+	      IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G)) == 0) {
+		memcpy(eht->mcs_map_bw20, &mcs_map->only_20mhz,
+		       sizeof(eht->mcs_map_bw20));
+		return;
+	}
+
 	memcpy(eht->mcs_map_bw80, &mcs_map->bw._80, sizeof(eht->mcs_map_bw80));
 	memcpy(eht->mcs_map_bw160, &mcs_map->bw._160, sizeof(eht->mcs_map_bw160));
 	memcpy(eht->mcs_map_bw320, &mcs_map->bw._320, sizeof(eht->mcs_map_bw320));
-- 
2.43.0


