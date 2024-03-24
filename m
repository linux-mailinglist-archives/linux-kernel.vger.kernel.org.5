Return-Path: <linux-kernel+bounces-113129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4E68881B0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEFEC1C21C0F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB04A15F304;
	Sun, 24 Mar 2024 22:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9vAb1ga"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D5C57324;
	Sun, 24 Mar 2024 22:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319936; cv=none; b=CbZCzYqqf4etak3ad6EDrkfiP7NW3YleTk5xLqPLzjiMLBZ5ES1vpWu4fA2DSgZLKnS4HUbnJiHLorEO+FxbFoB0/tee7LqCSkx2ooj5hszIn0dsyHA3JBFqOsXwDq8vd5qMtkdZPvYUN6za+Ae+0Vz009bZXmFa0ppeqlGTvqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319936; c=relaxed/simple;
	bh=PkrDQnjEjY2i83EVqHK2QJp/nO8YXFzDnIBB6hMF2DY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TOgH+XVbM6L2jXGPwv7DtYwDkq8QcA/PFK2jFGnpJ9dBEs08pkzOhh5His+R+4HCqGeHM3trI11nUROs7pR9cxOcsKzw3tzvW+FkLoM0w6cmGzauc4KjadM43ALCpHmzT1ye1UfFbS62QnniruCFu6nS3l7o7F1owO23qj6kOeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9vAb1ga; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8FC5C43390;
	Sun, 24 Mar 2024 22:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319936;
	bh=PkrDQnjEjY2i83EVqHK2QJp/nO8YXFzDnIBB6hMF2DY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C9vAb1gao7tm3VXnujT58rWcpbpFZLAcvNiByL+tDDPvJ5VoMLRLAsI5mAs5gmXUg
	 pZk+U5FBaz0tHwNLVQNCeTiP4o8X1VitbUIuEbiJ9/rhBlmHyFl8EE1x70SlOjqsEu
	 x+zz1jbeeiddqXdvs45az85rSthSxg3/e0a+YNCuovJuma8/8gLRi9Sv2P+l+NqFb+
	 WrrTl+1V4TEWWXPFJ5DG3Nvr1L4mSljcoaHQEAd4wZ7vK+VbGIoWmnulah+5+xnIBm
	 6OVxXPXEO/Vxow4i28vJ85gDRIs9Yj8WZlABOJEOacJ8etiD4UIA+vh9I2quShprYK
	 eS0i5Wcbxfz3Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
	Deren Wu <deren.wu@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 242/715] wifi: mt76: mt7925: add support to set ifs time by mcu command
Date: Sun, 24 Mar 2024 18:27:01 -0400
Message-ID: <20240324223455.1342824-243-sashal@kernel.org>
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

[ Upstream commit 8536ef0aeae1177c4a59b043d4b1c41ddaa9df2a ]

There's a race between driver and fw on some tx/rx control registers
when setting ifs, which will cause accidental hw queue pause problems.
Avoid this by setting ifs time with bss_info mcu command.

Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7925/main.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 33 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7925/mcu.h   | 19 +++++++++++
 3 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index c74ba9642fc8d..6179798a8845a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -711,7 +711,7 @@ static void mt7925_bss_info_changed(struct ieee80211_hw *hw,
 
 		if (slottime != phy->slottime) {
 			phy->slottime = slottime;
-			mt792x_mac_set_timeing(phy);
+			mt7925_mcu_set_timing(phy, vif);
 		}
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 932ecf38672c4..e1dd89a7a79ca 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -2244,6 +2244,38 @@ mt7925_mcu_bss_color_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 		vif->bss_conf.he_bss_color.color : 0;
 }
 
+static void
+mt7925_mcu_bss_ifs_tlv(struct sk_buff *skb, struct ieee80211_vif *vif)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct mt792x_phy *phy = mvif->phy;
+	struct bss_ifs_time_tlv *ifs_time;
+	struct tlv *tlv;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, UNI_BSS_INFO_IFS_TIME, sizeof(*ifs_time));
+	ifs_time = (struct bss_ifs_time_tlv *)tlv;
+	ifs_time->slot_valid = true;
+	ifs_time->slot_time = cpu_to_le16(phy->slottime);
+}
+
+int mt7925_mcu_set_timing(struct mt792x_phy *phy,
+			  struct ieee80211_vif *vif)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct mt792x_dev *dev = phy->dev;
+	struct sk_buff *skb;
+
+	skb = __mt7925_mcu_alloc_bss_req(&dev->mt76, &mvif->mt76,
+					 MT7925_BSS_UPDATE_MAX_SIZE);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	mt7925_mcu_bss_ifs_tlv(skb, vif);
+
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				     MCU_UNI_CMD(BSS_INFO_UPDATE), true);
+}
+
 int mt7925_mcu_add_bss_info(struct mt792x_phy *phy,
 			    struct ieee80211_chanctx_conf *ctx,
 			    struct ieee80211_vif *vif,
@@ -2268,6 +2300,7 @@ int mt7925_mcu_add_bss_info(struct mt792x_phy *phy,
 	mt7925_mcu_bss_bmc_tlv(skb, phy, ctx, vif, sta);
 	mt7925_mcu_bss_qos_tlv(skb, vif);
 	mt7925_mcu_bss_mld_tlv(skb, vif, sta);
+	mt7925_mcu_bss_ifs_tlv(skb, vif);
 
 	if (vif->bss_conf.he_support) {
 		mt7925_mcu_bss_he_tlv(skb, vif, phy);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
index 9fce054e50657..2cf39276118eb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
@@ -440,6 +440,22 @@ struct sta_rec_mld {
 	} __packed link[2];
 } __packed;
 
+struct bss_ifs_time_tlv {
+	__le16 tag;
+	__le16 len;
+	u8 slot_valid;
+	u8 sifs_valid;
+	u8 rifs_valid;
+	u8 eifs_valid;
+	__le16 slot_time;
+	__le16 sifs_time;
+	__le16 rifs_time;
+	__le16 eifs_time;
+	u8 eifs_cck_valid;
+	u8 rsv;
+	__le16 eifs_cck_time;
+} __packed;
+
 #define MT7925_STA_UPDATE_MAX_SIZE	(sizeof(struct sta_req_hdr) +		\
 					 sizeof(struct sta_rec_basic) +		\
 					 sizeof(struct sta_rec_bf) +		\
@@ -467,6 +483,7 @@ struct sta_rec_mld {
 					 sizeof(struct bss_mld_tlv) +			\
 					 sizeof(struct bss_info_uni_he) +		\
 					 sizeof(struct bss_info_uni_bss_color) +	\
+					 sizeof(struct bss_ifs_time_tlv) +		\
 					 sizeof(struct tlv))
 
 #define MT_CONNAC3_SKU_POWER_LIMIT      449
@@ -564,6 +581,8 @@ int mt7925_mcu_add_bss_info(struct mt792x_phy *phy,
 			    struct ieee80211_vif *vif,
 			    struct ieee80211_sta *sta,
 			    int enable);
+int mt7925_mcu_set_timing(struct mt792x_phy *phy,
+			  struct ieee80211_vif *vif);
 int mt7925_mcu_set_deep_sleep(struct mt792x_dev *dev, bool enable);
 int mt7925_mcu_set_channel_domain(struct mt76_phy *phy);
 int mt7925_mcu_set_radio_en(struct mt792x_phy *phy, bool enable);
-- 
2.43.0


