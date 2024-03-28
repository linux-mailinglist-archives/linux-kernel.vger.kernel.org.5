Return-Path: <linux-kernel+bounces-115488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95310889BDB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7FA81C2B857
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0658322EAB6;
	Mon, 25 Mar 2024 02:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VV8RfCOt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873991DD2A3;
	Sun, 24 Mar 2024 22:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320725; cv=none; b=Ui/7xwZ1CTmCXjZmprK+LpYwnteArOT6s9zpffR4lyp8kDE8oe5IOLL3LNE39LOOp81AW4ApeDl/lGQLpSUw3oYbawYzSO70PtuKJ/G58YelHw8loyzttFct6jLSxzUtMppLTNr2YAzqe5pwzmQh5zzapXs63isD2l/Ltjt7NKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320725; c=relaxed/simple;
	bh=Oh+4jfDgnatDgtHnJwMl1kYlxhW04OFzI/P3BLozgdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sqZq7bRRB9L1L4mdLC4NPb2uOkE0DIRPjJzddIfqDkMFznbMOFggYaTc9utMq3VH/LOa6o0wEGAZoVJgnIe0p/ouOJzCSGKytkzdcDpsAiEbut5daojKOOKLjEdY+Vbmzud1+1H8JX3OpN5euOgEgzUaf2gAhZQwcH6rI25tF2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VV8RfCOt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E82C433F1;
	Sun, 24 Mar 2024 22:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320724;
	bh=Oh+4jfDgnatDgtHnJwMl1kYlxhW04OFzI/P3BLozgdM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VV8RfCOtPu8MDH1QVjKWSaW2sX7Pqm98nErGeTlzyugDo23vJhRIBokGF/2Gugq8y
	 u9e7R1mdyTmngQLZi9ckPfHlV/AWgAtqotOUxowl/2nYqQn0+aiIrOvLGevrwksvRQ
	 d80ENak9isIQnJo25FaonDjlJkK378PQYEoeDlOgJ9n2q+JNsXvWc1tIcpdc9UpxNO
	 rjJQMT+yweCljqbtW5Pz9dNMqEjuZL9JXTjV7WGFIMCZczJ8wT42dPgYn2Q0zH4Yi7
	 AhRNvWbjqdzLOdHYDzVGk3z3J2MLZckpdPTYWPUBJFE3GyywbtiyM40iHhbHFX/Rbi
	 McwxH3cFWczyg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Allen Ye <allen.ye@mediatek.com>,
	Rudra Shahi <rudra.shahi@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 287/713] wifi: mt76: connac: add beacon protection support for mt7996
Date: Sun, 24 Mar 2024 18:40:13 -0400
Message-ID: <20240324224720.1345309-288-sashal@kernel.org>
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

From: Allen Ye <allen.ye@mediatek.com>

[ Upstream commit eb80e02b2c03141460749d3800126e2cdb674c9e ]

Implement beacon protection feature for mt7996 chipsets, and also do
some cleanup on the set key routine.

Co-developed-by: Rudra Shahi <rudra.shahi@mediatek.com>
Signed-off-by: Rudra Shahi <rudra.shahi@mediatek.com>
Signed-off-by: Allen Ye <allen.ye@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Stable-dep-of: 47916693ec7c ("wifi: mt76: mt7925: fix WoW failed in encrypted mode")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  24 +++
 .../net/wireless/mediatek/mt76/mt7996/main.c  |  12 +-
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   | 139 +++++++++++++-----
 .../net/wireless/mediatek/mt76/mt7996/mcu.h   |  17 +++
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |   3 +-
 5 files changed, 153 insertions(+), 42 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index c2241b068635f..cc6cdbc664290 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -416,6 +416,14 @@ struct sta_rec_he_6g_capa {
 	u8 rsv[2];
 } __packed;
 
+struct sta_rec_pn_info {
+	__le16 tag;
+	__le16 len;
+	u8 pn[6];
+	u8 tsc_type;
+	u8 rsv;
+} __packed;
+
 struct sec_key {
 	u8 cipher_id;
 	u8 cipher_len;
@@ -768,6 +776,7 @@ struct wtbl_raw {
 					 sizeof(struct sta_rec_sec) +	\
 					 sizeof(struct sta_rec_ra_fixed) + \
 					 sizeof(struct sta_rec_he_6g_capa) + \
+					 sizeof(struct sta_rec_pn_info) + \
 					 sizeof(struct tlv) +		\
 					 MT76_CONNAC_WTBL_UPDATE_MAX_SIZE)
 
@@ -798,6 +807,7 @@ enum {
 	STA_REC_HE_V2 = 0x19,
 	STA_REC_MLD = 0x20,
 	STA_REC_EHT = 0x22,
+	STA_REC_PN_INFO = 0x26,
 	STA_REC_HDRT = 0x28,
 	STA_REC_HDR_TRANS = 0x2B,
 	STA_REC_MAX_NUM
@@ -1091,6 +1101,13 @@ enum mcu_cipher_type {
 	MCU_CIPHER_GCMP_256,
 	MCU_CIPHER_WAPI,
 	MCU_CIPHER_BIP_CMAC_128,
+	MCU_CIPHER_BIP_CMAC_256,
+	MCU_CIPHER_BCN_PROT_CMAC_128,
+	MCU_CIPHER_BCN_PROT_CMAC_256,
+	MCU_CIPHER_BCN_PROT_GMAC_128,
+	MCU_CIPHER_BCN_PROT_GMAC_256,
+	MCU_CIPHER_BIP_GMAC_128,
+	MCU_CIPHER_BIP_GMAC_256,
 };
 
 enum {
@@ -1310,6 +1327,7 @@ enum {
 	UNI_BSS_INFO_RATE = 11,
 	UNI_BSS_INFO_QBSS = 15,
 	UNI_BSS_INFO_SEC = 16,
+	UNI_BSS_INFO_BCN_PROT = 17,
 	UNI_BSS_INFO_TXCMD = 18,
 	UNI_BSS_INFO_UAPSD = 19,
 	UNI_BSS_INFO_PS = 21,
@@ -1771,6 +1789,12 @@ mt76_connac_mcu_get_cipher(int cipher)
 		return MCU_CIPHER_GCMP;
 	case WLAN_CIPHER_SUITE_GCMP_256:
 		return MCU_CIPHER_GCMP_256;
+	case WLAN_CIPHER_SUITE_BIP_GMAC_128:
+		return MCU_CIPHER_BIP_GMAC_128;
+	case WLAN_CIPHER_SUITE_BIP_GMAC_256:
+		return MCU_CIPHER_BIP_GMAC_256;
+	case WLAN_CIPHER_SUITE_BIP_CMAC_256:
+		return MCU_CIPHER_BIP_CMAC_256;
 	case WLAN_CIPHER_SUITE_SMS4:
 		return MCU_CIPHER_WAPI;
 	default:
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 09c7a28a3d511..482a8f7d75d7a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -342,6 +342,8 @@ static int mt7996_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	case WLAN_CIPHER_SUITE_GCMP:
 	case WLAN_CIPHER_SUITE_GCMP_256:
 	case WLAN_CIPHER_SUITE_SMS4:
+	case WLAN_CIPHER_SUITE_BIP_GMAC_128:
+	case WLAN_CIPHER_SUITE_BIP_GMAC_256:
 		break;
 	case WLAN_CIPHER_SUITE_WEP40:
 	case WLAN_CIPHER_SUITE_WEP104:
@@ -365,9 +367,13 @@ static int mt7996_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	}
 
 	mt76_wcid_key_setup(&dev->mt76, wcid, key);
-	err = mt7996_mcu_add_key(&dev->mt76, vif, &msta->bip,
-				 key, MCU_WMWA_UNI_CMD(STA_REC_UPDATE),
-				 &msta->wcid, cmd);
+
+	if (key->keyidx == 6 || key->keyidx == 7)
+		err = mt7996_mcu_bcn_prot_enable(dev, vif, key);
+	else
+		err = mt7996_mcu_add_key(&dev->mt76, vif, key,
+					 MCU_WMWA_UNI_CMD(STA_REC_UPDATE),
+					 &msta->wcid, cmd);
 out:
 	mutex_unlock(&dev->mt76.mutex);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index bf917beb94396..707db74f234ed 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -2058,7 +2058,6 @@ int mt7996_mcu_add_sta(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 
 static int
 mt7996_mcu_sta_key_tlv(struct mt76_wcid *wcid,
-		       struct mt76_connac_sta_key_conf *sta_key_conf,
 		       struct sk_buff *skb,
 		       struct ieee80211_key_conf *key,
 		       enum set_key_cmd cmd)
@@ -2079,43 +2078,22 @@ mt7996_mcu_sta_key_tlv(struct mt76_wcid *wcid,
 			return -EOPNOTSUPP;
 
 		sec_key = &sec->key[0];
+		sec_key->wlan_idx = cpu_to_le16(wcid->idx);
+		sec_key->mgmt_prot = 0;
+		sec_key->cipher_id = cipher;
 		sec_key->cipher_len = sizeof(*sec_key);
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
-		} else {
-			sec_key->wlan_idx = cpu_to_le16(wcid->idx);
-			sec_key->cipher_id = cipher;
-			sec_key->key_id = key->keyidx;
-			sec_key->key_len = key->keylen;
-			memcpy(sec_key->key, key->key, key->keylen);
-
-			if (cipher == MCU_CIPHER_TKIP) {
-				/* Rx/Tx MIC keys are swapped */
-				memcpy(sec_key->key + 16, key->key + 24, 8);
-				memcpy(sec_key->key + 24, key->key + 16, 8);
-			}
-
-			/* store key_conf for BIP batch update */
-			if (cipher == MCU_CIPHER_AES_CCMP) {
-				memcpy(sta_key_conf->key, key->key, key->keylen);
-				sta_key_conf->keyidx = key->keyidx;
-			}
-
-			sec->n_cipher = 1;
+		sec_key->key_id = key->keyidx;
+		sec_key->key_len = key->keylen;
+		sec_key->need_resp = 0;
+		memcpy(sec_key->key, key->key, key->keylen);
+
+		if (cipher == MCU_CIPHER_TKIP) {
+			/* Rx/Tx MIC keys are swapped */
+			memcpy(sec_key->key + 16, key->key + 24, 8);
+			memcpy(sec_key->key + 24, key->key + 16, 8);
 		}
+
+		sec->n_cipher = 1;
 	} else {
 		sec->n_cipher = 0;
 	}
@@ -2124,7 +2102,6 @@ mt7996_mcu_sta_key_tlv(struct mt76_wcid *wcid,
 }
 
 int mt7996_mcu_add_key(struct mt76_dev *dev, struct ieee80211_vif *vif,
-		       struct mt76_connac_sta_key_conf *sta_key_conf,
 		       struct ieee80211_key_conf *key, int mcu_cmd,
 		       struct mt76_wcid *wcid, enum set_key_cmd cmd)
 {
@@ -2137,13 +2114,99 @@ int mt7996_mcu_add_key(struct mt76_dev *dev, struct ieee80211_vif *vif,
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
-	ret = mt7996_mcu_sta_key_tlv(wcid, sta_key_conf, skb, key, cmd);
+	ret = mt7996_mcu_sta_key_tlv(wcid, skb, key, cmd);
 	if (ret)
 		return ret;
 
 	return mt76_mcu_skb_send_msg(dev, skb, mcu_cmd, true);
 }
 
+static int mt7996_mcu_get_pn(struct mt7996_dev *dev, struct ieee80211_vif *vif,
+			     u8 *pn)
+{
+#define TSC_TYPE_BIGTK_PN 2
+	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	struct sta_rec_pn_info *pn_info;
+	struct sk_buff *skb, *rskb;
+	struct tlv *tlv;
+	int ret;
+
+	skb = mt76_connac_mcu_alloc_sta_req(&dev->mt76, &mvif->mt76, &mvif->sta.wcid);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_PN_INFO, sizeof(*pn_info));
+	pn_info = (struct sta_rec_pn_info *)tlv;
+
+	pn_info->tsc_type = TSC_TYPE_BIGTK_PN;
+	ret = mt76_mcu_skb_send_and_get_msg(&dev->mt76, skb,
+					    MCU_WM_UNI_CMD_QUERY(STA_REC_UPDATE),
+					    true, &rskb);
+	if (ret)
+		return ret;
+
+	skb_pull(rskb, 4);
+
+	pn_info = (struct sta_rec_pn_info *)rskb->data;
+	if (le16_to_cpu(pn_info->tag) == STA_REC_PN_INFO)
+		memcpy(pn, pn_info->pn, 6);
+
+	dev_kfree_skb(rskb);
+	return 0;
+}
+
+int mt7996_mcu_bcn_prot_enable(struct mt7996_dev *dev, struct ieee80211_vif *vif,
+			       struct ieee80211_key_conf *key)
+{
+	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	struct mt7996_mcu_bcn_prot_tlv *bcn_prot;
+	struct sk_buff *skb;
+	struct tlv *tlv;
+	u8 pn[6] = {};
+	int len = sizeof(struct bss_req_hdr) +
+		  sizeof(struct mt7996_mcu_bcn_prot_tlv);
+	int ret;
+
+	skb = __mt7996_mcu_alloc_bss_req(&dev->mt76, &mvif->mt76, len);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	tlv = mt76_connac_mcu_add_tlv(skb, UNI_BSS_INFO_BCN_PROT, sizeof(*bcn_prot));
+
+	bcn_prot = (struct mt7996_mcu_bcn_prot_tlv *)tlv;
+
+	ret = mt7996_mcu_get_pn(dev, vif, pn);
+	if (ret) {
+		dev_kfree_skb(skb);
+		return ret;
+	}
+
+	switch (key->cipher) {
+	case WLAN_CIPHER_SUITE_AES_CMAC:
+		bcn_prot->cipher_id = MCU_CIPHER_BCN_PROT_CMAC_128;
+		break;
+	case WLAN_CIPHER_SUITE_BIP_GMAC_128:
+		bcn_prot->cipher_id = MCU_CIPHER_BCN_PROT_GMAC_128;
+		break;
+	case WLAN_CIPHER_SUITE_BIP_GMAC_256:
+		bcn_prot->cipher_id = MCU_CIPHER_BCN_PROT_GMAC_256;
+		break;
+	case WLAN_CIPHER_SUITE_BIP_CMAC_256:
+	default:
+		dev_err(dev->mt76.dev, "Not supported Bigtk Cipher\n");
+		dev_kfree_skb(skb);
+		return -EOPNOTSUPP;
+	}
+
+	pn[0]++;
+	memcpy(bcn_prot->pn, pn, 6);
+	bcn_prot->enable = BP_SW_MODE;
+	memcpy(bcn_prot->key, key->key, WLAN_MAX_KEY_LEN);
+	bcn_prot->key_id = key->keyidx;
+
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				     MCU_WMWA_UNI_CMD(BSS_INFO_UPDATE), true);
+}
 int mt7996_mcu_add_dev_info(struct mt7996_phy *phy,
 			    struct ieee80211_vif *vif, bool enable)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
index 9300cd8eeb76b..32ce57c8c4e6b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
@@ -250,6 +250,23 @@ struct bss_rate_tlv {
 	u8 __rsv2[9];
 } __packed;
 
+enum {
+	BP_DISABLE,
+	BP_SW_MODE,
+	BP_HW_MODE,
+};
+
+struct mt7996_mcu_bcn_prot_tlv {
+	__le16 tag;
+	__le16 len;
+	u8 pn[6];
+	u8 enable;
+	u8 cipher_id;
+	u8 key[WLAN_MAX_KEY_LEN];
+	u8 key_id;
+	u8 __rsv[3];
+} __packed;
+
 struct bss_ra_tlv {
 	__le16 tag;
 	__le16 len;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index e53cf6a3704c4..3434ca50d3181 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -485,9 +485,10 @@ int mt7996_init_debugfs(struct mt7996_phy *phy);
 void mt7996_debugfs_rx_fw_monitor(struct mt7996_dev *dev, const void *data, int len);
 bool mt7996_debugfs_rx_log(struct mt7996_dev *dev, const void *data, int len);
 int mt7996_mcu_add_key(struct mt76_dev *dev, struct ieee80211_vif *vif,
-		       struct mt76_connac_sta_key_conf *sta_key_conf,
 		       struct ieee80211_key_conf *key, int mcu_cmd,
 		       struct mt76_wcid *wcid, enum set_key_cmd cmd);
+int mt7996_mcu_bcn_prot_enable(struct mt7996_dev *dev, struct ieee80211_vif *vif,
+			       struct ieee80211_key_conf *key);
 int mt7996_mcu_wtbl_update_hdr_trans(struct mt7996_dev *dev,
 				     struct ieee80211_vif *vif,
 				     struct ieee80211_sta *sta);
-- 
2.43.0


