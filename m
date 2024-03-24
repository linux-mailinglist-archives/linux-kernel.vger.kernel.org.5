Return-Path: <linux-kernel+bounces-115429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F345889B86
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04BE929C2C6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8355A20DD58;
	Mon, 25 Mar 2024 02:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSoyfKQX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8CC1DD2AC;
	Sun, 24 Mar 2024 22:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320728; cv=none; b=aenp9Zw85k8znafOppwfPHOT7emKaqrRqloxAXwmFvS25AMWPzBID3sEVkDPqqNVL5joWk4dVVIht9gcnziL747PPy+bZz0UMFa6v+IFSLIQQ0luKC+h3wsX5RoT4QiMkdDnWtM5RRIGjiKSNl5om/A7yFUyKjJBktcFABWuuks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320728; c=relaxed/simple;
	bh=cWdscHCae5ZFuXtoirel5HNtlh1wLRIoVOpG2BJ26fM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IMUPXYwg76BiDQOoaGybJWyGgZOq9g28QF4LVQOjiC2zVAerxrR/xu3cqt7xt3+kMZeqPs5KmE0jX1MpUhIkwbjPxAha23eIAimKOZld0CnJd+ncDxiKMjSooGXzDwWCsb74T1cQjVFRlKeiGUjCekBho1Ii/ScWrRFwMNS1d1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSoyfKQX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 810F8C43394;
	Sun, 24 Mar 2024 22:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320728;
	bh=cWdscHCae5ZFuXtoirel5HNtlh1wLRIoVOpG2BJ26fM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cSoyfKQXbct7ce6YMnO1rxOZABSo2/+v4jjsaHiqX3TaUzROm+FY1MxcqkhQDwG0U
	 nWrwmWfa6k3TRkcIbI//wTKp5ekUJmMBtKfKsEuwbzKEHCIWSPSOJs9hqmp66o1yOT
	 lz4/45MNPgeiNNH35IJ1BnfrgDrpmodVeOZEwgYtuWjTYzz5De++xfLmMKGdC0P3lZ
	 3koN6Pqp8JcTSboPSDDTLiEPGri8vFEBxFCQUc1Eka+54RCYUD7zynlWKLZrTGMYP+
	 RdAGbANQaYGVMslpR9eqPqxaYUA/cYlyzSTfz/ok5Eg/fx243v9b0fE3H4yTurG5Vk
	 Sc7J9Ab/woI8A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
	Deren Wu <deren.wu@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 291/713] wifi: mt76: mt7925: add support to set ifs time by mcu command
Date: Sun, 24 Mar 2024 18:40:17 -0400
Message-ID: <20240324224720.1345309-292-sashal@kernel.org>
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
index 09b53cec750b3..6f0b18ae313de 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -712,7 +712,7 @@ static void mt7925_bss_info_changed(struct ieee80211_hw *hw,
 
 		if (slottime != phy->slottime) {
 			phy->slottime = slottime;
-			mt792x_mac_set_timeing(phy);
+			mt7925_mcu_set_timing(phy, vif);
 		}
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 28b871e552f0c..8e72012472874 100644
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


