Return-Path: <linux-kernel+bounces-114192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1EE888902
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92D4CB2188C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EEF24CB44;
	Sun, 24 Mar 2024 23:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tWaBatws"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2FF1514C6;
	Sun, 24 Mar 2024 23:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321526; cv=none; b=aMuQBZbmSc8NiuAeUIBfojYrz7zOTlNI5+8QLwUJCGeNC0Md5i+ahfCm9txAyYDceP9a7AM8lkeCZzFUPxexzTmShtqZup9UuK7N9UtdO3uKGhhHgjAV27ZyqCXqJHbt3dei0WtTJZnYaRt/EgoUhvVvvumouuaByPwBdgyDmbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321526; c=relaxed/simple;
	bh=slLq5ObvRkrF/vc8IVPcQgi3EKnkUlzKMWzIv72UzuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S5F3rX9ur8a93nzeS66wQ6lpsm77k7RbMsMVVqiQtJKt/bzD5++lFIVASzqEO1/4cEGxIQFl8Bz+sA9O67hjf3ZA+hLmCrGqr/ojMFMz/dsLh6DigCbm85JIYfECyDhIepOz6X6kYkLx4+LNfDN9zGpU9f4lq51Y6EYnTS3znO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tWaBatws; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA1A0C433C7;
	Sun, 24 Mar 2024 23:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321526;
	bh=slLq5ObvRkrF/vc8IVPcQgi3EKnkUlzKMWzIv72UzuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tWaBatws6w6AXb55OgM8s9/O+5crA1QOoPlrveu1c2DqSaIJYgAWFLasfc5nwryum
	 9vpjjz2f0AaYx6AFweCvZjrDCG1zKEVkoJ525gSe/IaoyGiVevfOk9yFqefuPAwxjW
	 drM2vVILw+8uZycfwb2BXnBdanCNBo+wX1D7kHNKqIgeFF5qYOj0uoPmJNj50vYUM6
	 JA71J8H08fl70lhPewGvyyrpz+t8NurMeLQnOjThzjpiO0HW+fAsW1aZHQYx64TswS
	 OB90QHkykeNiFTKL4CyOLDG3aLIojK51gnQcg7lR/Kx/aFIjY1K1TWqbWuP0DXqv16
	 EPit23OOo9vZQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Benjamin Lin <benjamin-jw.lin@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 253/638] wifi: mt76: mt7996: fix incorrect interpretation of EHT MCS caps
Date: Sun, 24 Mar 2024 18:54:50 -0400
Message-ID: <20240324230116.1348576-254-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index 7575d3506ea4e..650c43cb899f7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -1005,6 +1005,9 @@ mt7996_mcu_sta_he_6g_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
 static void
 mt7996_mcu_sta_eht_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
 {
+	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
+	struct ieee80211_vif *vif = container_of((void *)msta->vif,
+						 struct ieee80211_vif, drv_priv);
 	struct ieee80211_eht_mcs_nss_supp *mcs_map;
 	struct ieee80211_eht_cap_elem_fixed *elem;
 	struct sta_rec_eht *eht;
@@ -1024,8 +1027,17 @@ mt7996_mcu_sta_eht_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
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


