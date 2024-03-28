Return-Path: <linux-kernel+bounces-113126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 425308881AB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED465280EFA
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5EC57320;
	Sun, 24 Mar 2024 22:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="daXBnEyx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9471515D5C5;
	Sun, 24 Mar 2024 22:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319933; cv=none; b=k5hGt6FQ1rSrZ1rYSd55UglK2+ImucHgdtiME1IVXNC55gk9PGMwops4xIiYNMvkrQ27rXQrUuGERgjx11A31hE4yNNvcHUqrGELZiMpbSU6xhEaYcZCfU4+KyhS4C0amulW8eV5iFeKvkj79jscqcLf0/tVJ7DZHLROPWBIUwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319933; c=relaxed/simple;
	bh=DR2C44Fi0XU0W7xJIVmvRT0pMyW8nb72FrIO2GwpCKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=urux4HWlGTQjL/X8OfLvhtOBPeXR/9DDvWoP3rw/IkTzQ8r9VK6qMK187ei/JTqbt5BYO/eK4LfIFKQ4OGqWozzBMW/dyY9lTLbb4sJC+x53MXwzQIDHzhzVC4gPRx/duJEEjFEYGKio+/r+fG1FwLVDw8X7uYW5VXAmjdzNtIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=daXBnEyx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC735C433C7;
	Sun, 24 Mar 2024 22:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319933;
	bh=DR2C44Fi0XU0W7xJIVmvRT0pMyW8nb72FrIO2GwpCKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=daXBnEyxGNSy/JgSvoXf4I3Laa/NUiUby7HwAP/pBQ8MM0jpSegvyL4HDbeD99KuJ
	 JezjnvqQgZikD3u6V5xe+OwjLRAa6rMokqKv311X7enr/CwsDejCnR0pZUa6Ppri2V
	 Kg1nqPOxaa447sbGAWz69oHIW9rSs8mHBJH2AE3c4hTiYlEjFNyHKlJ1tkL9rVy7uJ
	 4+r1JfTkb045EPRaTHGspEn6KTLDo3paRaJB/WvvuURUVmodXNRTHsWyUksR34a3i3
	 ugwnxfdSaeYGroQQDLpBkm9h1LYjBm+coEghKDnbpyTuklFEhBgSh0ROVTSq1GfZcd
	 zZLl66CPj+ZQw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 239/715] wifi: mt76: mt7925: fix WoW failed in encrypted mode
Date: Sun, 24 Mar 2024 18:26:58 -0400
Message-ID: <20240324223455.1342824-240-sashal@kernel.org>
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

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

[ Upstream commit 47916693ec7cd1b283ffa7554fc48ff4eec2daa1 ]

When in suspend mode, WoW (Wake-on-WLAN) fails to wake the system remotely
due to incorrect encryption mode settings. For the new mt7925 chipset, the
old STA_REC_KEY_V2 command will send incorrect parameters to the firmware.
Therefore, STA_REC_KEY_V3 has been introduced as a replacement for it.

Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  1 +
 .../net/wireless/mediatek/mt76/mt7925/main.c  |  3 +-
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 86 ++++++++++---------
 .../net/wireless/mediatek/mt76/mt7925/mcu.h   | 70 +++++++++++----
 4 files changed, 103 insertions(+), 57 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index db96ddbeb9e70..657a4d1f856b2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -808,6 +808,7 @@ enum {
 	STA_REC_MLD = 0x20,
 	STA_REC_EHT = 0x22,
 	STA_REC_PN_INFO = 0x26,
+	STA_REC_KEY_V3 = 0x27,
 	STA_REC_HDRT = 0x28,
 	STA_REC_HDR_TRANS = 0x2B,
 	STA_REC_MAX_NUM
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 5671e08dec654..c74ba9642fc8d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -359,6 +359,7 @@ mt7925_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	mvif->sta.wcid.phy_idx = mvif->mt76.band_idx;
 	mvif->sta.wcid.hw_key_idx = -1;
 	mvif->sta.wcid.tx_info |= MT_WCID_TX_INFO_SET;
+	mvif->sta.vif = mvif;
 	mt76_wcid_init(&mvif->sta.wcid);
 
 	mt7925_mac_wtbl_update(dev, idx,
@@ -526,7 +527,7 @@ static int mt7925_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	if (cmd == SET_KEY && !mvif->mt76.cipher) {
 		struct mt792x_phy *phy = mt792x_hw_phy(hw);
 
-		mvif->mt76.cipher = mt76_connac_mcu_get_cipher(key->cipher);
+		mvif->mt76.cipher = mt7925_mcu_get_cipher(key->cipher);
 		mt7925_mcu_add_bss_info(phy, mvif->mt76.ctx, vif, sta, true);
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 0299045b4b833..8c3233182083f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -921,61 +921,67 @@ mt7925_mcu_sta_key_tlv(struct mt76_wcid *wcid,
 		       struct ieee80211_key_conf *key,
 		       enum set_key_cmd cmd)
 {
+	struct mt792x_sta *msta = container_of(wcid, struct mt792x_sta, wcid);
 	struct sta_rec_sec_uni *sec;
+	struct mt792x_vif *mvif = msta->vif;
+	struct ieee80211_sta *sta;
+	struct ieee80211_vif *vif;
 	struct tlv *tlv;
 
-	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_KEY_V2, sizeof(*sec));
+	sta = msta == &mvif->sta ?
+		      NULL :
+		      container_of((void *)msta, struct ieee80211_sta, drv_priv);
+	vif = container_of((void *)mvif, struct ieee80211_vif, drv_priv);
+
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_KEY_V3, sizeof(*sec));
 	sec = (struct sta_rec_sec_uni *)tlv;
-	sec->add = cmd;
+	sec->bss_idx = mvif->mt76.idx;
+	sec->is_authenticator = 0;
+	sec->mgmt_prot = 0;
+	sec->wlan_idx = (u8)wcid->idx;
+
+	if (sta) {
+		sec->tx_key = 1;
+		sec->key_type = 1;
+		memcpy(sec->peer_addr, sta->addr, ETH_ALEN);
+	} else {
+		memcpy(sec->peer_addr, vif->bss_conf.bssid, ETH_ALEN);
+	}
 
 	if (cmd == SET_KEY) {
-		struct sec_key_uni *sec_key;
 		u8 cipher;
 
-		cipher = mt76_connac_mcu_get_cipher(key->cipher);
-		if (cipher == MCU_CIPHER_NONE)
+		sec->add = 1;
+		cipher = mt7925_mcu_get_cipher(key->cipher);
+		if (cipher == CONNAC3_CIPHER_NONE)
 			return -EOPNOTSUPP;
 
-		sec_key = &sec->key[0];
-		sec_key->cipher_len = sizeof(*sec_key);
-
-		if (cipher == MCU_CIPHER_BIP_CMAC_128) {
-			sec_key->wlan_idx = cpu_to_le16(wcid->idx);
-			sec_key->cipher_id = MCU_CIPHER_AES_CCMP;
-			sec_key->key_id = sta_key_conf->keyidx;
-			sec_key->key_len = 16;
-			memcpy(sec_key->key, sta_key_conf->key, 16);
-
-			sec_key = &sec->key[1];
-			sec_key->wlan_idx = cpu_to_le16(wcid->idx);
-			sec_key->cipher_id = MCU_CIPHER_BIP_CMAC_128;
-			sec_key->cipher_len = sizeof(*sec_key);
-			sec_key->key_len = 16;
-			memcpy(sec_key->key, key->key, 16);
-			sec->n_cipher = 2;
+		if (cipher == CONNAC3_CIPHER_BIP_CMAC_128) {
+			sec->cipher_id = CONNAC3_CIPHER_BIP_CMAC_128;
+			sec->key_id = sta_key_conf->keyidx;
+			sec->key_len = 32;
+			memcpy(sec->key, sta_key_conf->key, 16);
+			memcpy(sec->key + 16, key->key, 16);
 		} else {
-			sec_key->wlan_idx = cpu_to_le16(wcid->idx);
-			sec_key->cipher_id = cipher;
-			sec_key->key_id = key->keyidx;
-			sec_key->key_len = key->keylen;
-			memcpy(sec_key->key, key->key, key->keylen);
+			sec->cipher_id = cipher;
+			sec->key_id = key->keyidx;
+			sec->key_len = key->keylen;
+			memcpy(sec->key, key->key, key->keylen);
 
-			if (cipher == MCU_CIPHER_TKIP) {
+			if (cipher == CONNAC3_CIPHER_TKIP) {
 				/* Rx/Tx MIC keys are swapped */
-				memcpy(sec_key->key + 16, key->key + 24, 8);
-				memcpy(sec_key->key + 24, key->key + 16, 8);
+				memcpy(sec->key + 16, key->key + 24, 8);
+				memcpy(sec->key + 24, key->key + 16, 8);
 			}
 
 			/* store key_conf for BIP batch update */
-			if (cipher == MCU_CIPHER_AES_CCMP) {
+			if (cipher == CONNAC3_CIPHER_AES_CCMP) {
 				memcpy(sta_key_conf->key, key->key, key->keylen);
 				sta_key_conf->keyidx = key->keyidx;
 			}
-
-			sec->n_cipher = 1;
 		}
 	} else {
-		sec->n_cipher = 0;
+		sec->add = 0;
 	}
 
 	return 0;
@@ -2122,21 +2128,21 @@ mt7925_mcu_bss_sec_tlv(struct sk_buff *skb, struct ieee80211_vif *vif)
 	sec = (struct bss_sec_tlv *)tlv;
 
 	switch (mvif->cipher) {
-	case MCU_CIPHER_GCMP_256:
-	case MCU_CIPHER_GCMP:
+	case CONNAC3_CIPHER_GCMP_256:
+	case CONNAC3_CIPHER_GCMP:
 		sec->mode = MODE_WPA3_SAE;
 		sec->status = 8;
 		break;
-	case MCU_CIPHER_AES_CCMP:
+	case CONNAC3_CIPHER_AES_CCMP:
 		sec->mode = MODE_WPA2_PSK;
 		sec->status = 6;
 		break;
-	case MCU_CIPHER_TKIP:
+	case CONNAC3_CIPHER_TKIP:
 		sec->mode = MODE_WPA2_PSK;
 		sec->status = 4;
 		break;
-	case MCU_CIPHER_WEP104:
-	case MCU_CIPHER_WEP40:
+	case CONNAC3_CIPHER_WEP104:
+	case CONNAC3_CIPHER_WEP40:
 		sec->mode = MODE_SHARED;
 		sec->status = 0;
 		break;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
index 0218fd2a0eb01..9fce054e50657 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
@@ -159,6 +159,20 @@ enum {
 	UNI_EVENT_SCAN_DONE_NLO = 3,
 };
 
+enum connac3_mcu_cipher_type {
+	CONNAC3_CIPHER_NONE = 0,
+	CONNAC3_CIPHER_WEP40 = 1,
+	CONNAC3_CIPHER_TKIP = 2,
+	CONNAC3_CIPHER_AES_CCMP = 4,
+	CONNAC3_CIPHER_WEP104 = 5,
+	CONNAC3_CIPHER_BIP_CMAC_128 = 6,
+	CONNAC3_CIPHER_WEP128 = 7,
+	CONNAC3_CIPHER_WAPI = 8,
+	CONNAC3_CIPHER_CCMP_256 = 10,
+	CONNAC3_CIPHER_GCMP = 11,
+	CONNAC3_CIPHER_GCMP_256 = 12,
+};
+
 struct mt7925_mcu_scan_chinfo_event {
 	u8 nr_chan;
 	u8 alpha2[3];
@@ -383,25 +397,22 @@ struct sta_rec_eht {
 	u8 _rsv2[3];
 } __packed;
 
-struct sec_key_uni {
-	__le16 wlan_idx;
-	u8 mgmt_prot;
-	u8 cipher_id;
-	u8 cipher_len;
-	u8 key_id;
-	u8 key_len;
-	u8 need_resp;
-	u8 key[32];
-} __packed;
-
 struct sta_rec_sec_uni {
 	__le16 tag;
 	__le16 len;
 	u8 add;
-	u8 n_cipher;
-	u8 rsv[2];
-
-	struct sec_key_uni key[2];
+	u8 tx_key;
+	u8 key_type;
+	u8 is_authenticator;
+	u8 peer_addr[6];
+	u8 bss_idx;
+	u8 cipher_id;
+	u8 key_id;
+	u8 key_len;
+	u8 wlan_idx;
+	u8 mgmt_prot;
+	u8 key[32];
+	u8 key_rsc[16];
 } __packed;
 
 struct sta_rec_hdr_trans {
@@ -441,7 +452,7 @@ struct sta_rec_mld {
 					 sizeof(struct sta_rec_bfee) +		\
 					 sizeof(struct sta_rec_phy) +		\
 					 sizeof(struct sta_rec_ra) +		\
-					 sizeof(struct sta_rec_sec) +		\
+					 sizeof(struct sta_rec_sec_uni) +   \
 					 sizeof(struct sta_rec_ra_fixed) +	\
 					 sizeof(struct sta_rec_he_6g_capa) +	\
 					 sizeof(struct sta_rec_eht) +		\
@@ -510,6 +521,33 @@ struct mt7925_wow_pattern_tlv {
 	u8 rsv[4];
 } __packed;
 
+static inline enum connac3_mcu_cipher_type
+mt7925_mcu_get_cipher(int cipher)
+{
+	switch (cipher) {
+	case WLAN_CIPHER_SUITE_WEP40:
+		return CONNAC3_CIPHER_WEP40;
+	case WLAN_CIPHER_SUITE_WEP104:
+		return CONNAC3_CIPHER_WEP104;
+	case WLAN_CIPHER_SUITE_TKIP:
+		return CONNAC3_CIPHER_TKIP;
+	case WLAN_CIPHER_SUITE_AES_CMAC:
+		return CONNAC3_CIPHER_BIP_CMAC_128;
+	case WLAN_CIPHER_SUITE_CCMP:
+		return CONNAC3_CIPHER_AES_CCMP;
+	case WLAN_CIPHER_SUITE_CCMP_256:
+		return CONNAC3_CIPHER_CCMP_256;
+	case WLAN_CIPHER_SUITE_GCMP:
+		return CONNAC3_CIPHER_GCMP;
+	case WLAN_CIPHER_SUITE_GCMP_256:
+		return CONNAC3_CIPHER_GCMP_256;
+	case WLAN_CIPHER_SUITE_SMS4:
+		return CONNAC3_CIPHER_WAPI;
+	default:
+		return CONNAC3_CIPHER_NONE;
+	}
+}
+
 int mt7925_mcu_set_dbdc(struct mt76_phy *phy);
 int mt7925_mcu_hw_scan(struct mt76_phy *phy, struct ieee80211_vif *vif,
 		       struct ieee80211_scan_request *scan_req);
-- 
2.43.0


