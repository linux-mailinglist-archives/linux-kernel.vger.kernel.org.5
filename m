Return-Path: <linux-kernel+bounces-113122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 352548881A2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2E5028258C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A183B15CD56;
	Sun, 24 Mar 2024 22:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2GDAEI7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD03215B997;
	Sun, 24 Mar 2024 22:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319929; cv=none; b=QP7U9Ns/18wiZLzVyW8Kuo1NovEnrV+S8RvNMjFYmY801L/feWZVFHia/usNexF89xAJUYhnLPCdnFSfu+qQUuKQqhL9pZVrAOwRFhbi4sAXob0V3iLsrCg8cR7VAvvcrzPPlFPbSfXpfeWmx4xqy7GZzuHn3Wcq9pYpxYYPWqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319929; c=relaxed/simple;
	bh=n/QDKm2Is9NtqPda8nZ0fr078Cx7AGlR/QVlfMhzCj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hqp3a8noVwMuhv/ynAYbex4pdCERXz0hc1CgqRDsN2koxEADlPoBFNySYi/ldF+3MLA5JkbhlKoFS9objB6KQU/6m7TLbucM31zGL/ZsnYOa41hC+F43sfrLdxp08EVxF2TT65N/0kgxXBu5uUzpFOiiDhqDGDs79rd5oRvenbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2GDAEI7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7BE0C43390;
	Sun, 24 Mar 2024 22:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319929;
	bh=n/QDKm2Is9NtqPda8nZ0fr078Cx7AGlR/QVlfMhzCj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O2GDAEI7lDpIO4gdItRrM9+3KsvtfQwhZAic+U5DqmTpDIZKnrNXl3b7CKnk1094e
	 ajsF+XfrCiKz+hGbLvFB793vvY2R0VfVlJUC+PM9AET2kJz9Ba3aO3Yc2slqvSzdIO
	 B4Pg01xzxh+XWstTSgUOf3a0i72tEE+VyAEBuUBxrkNxfvDZrdONfL0pnMXyxaI+wR
	 lChIX5mHp1G/YjrMw+HduaE85LNO6t2EQMXgYvzGGl5YtMDE3uolB1wMgpUfdGucjf
	 Yk+iFjf/AVGz27+iHN23UCBhqutrthfClpVsRyNLS2BPzQYSEJ1SqidWN4JAyAtc5l
	 XR0r5PRjSJV/A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "rong.yan" <rong.yan@mediatek.com>,
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 235/715] wifi: mt76: mt7925: fix SAP no beacon issue in 5Ghz and 6Ghz band
Date: Sun, 24 Mar 2024 18:26:54 -0400
Message-ID: <20240324223455.1342824-236-sashal@kernel.org>
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

From: "rong.yan" <rong.yan@mediatek.com>

[ Upstream commit 243cecc857735344473ea33a713cd5c2ec1fe347 ]

Driver should configure basic rate and phy mode for SAP mode.

Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
Signed-off-by: rong.yan <rong.yan@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.h    |  3 +++
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c     | 13 ++++++++++---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.h     |  3 ++-
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index ae6d0179727df..db96ddbeb9e70 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -935,6 +935,9 @@ enum {
 	PHY_TYPE_INDEX_NUM
 };
 
+#define HR_DSSS_ERP_BASIC_RATE			GENMASK(3, 0)
+#define OFDM_BASIC_RATE				(BIT(6) | BIT(8) | BIT(10))
+
 #define PHY_TYPE_BIT_HR_DSSS			BIT(PHY_TYPE_HR_DSSS_INDEX)
 #define PHY_TYPE_BIT_ERP			BIT(PHY_TYPE_ERP_INDEX)
 #define PHY_TYPE_BIT_OFDM			BIT(PHY_TYPE_OFDM_INDEX)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 1fc9ecb96bc43..9a8db9b1a4f2b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -2047,9 +2047,9 @@ mt7925_mcu_bss_basic_tlv(struct sk_buff *skb,
 	struct cfg80211_chan_def *chandef = ctx ? &ctx->def : &phy->chandef;
 	enum nl80211_band band = chandef->chan->band;
 	struct mt76_connac_bss_basic_tlv *basic_req;
-	u8 idx, basic_phy;
 	struct tlv *tlv;
 	int conn_type;
+	u8 idx;
 
 	tlv = mt76_connac_mcu_add_tlv(skb, UNI_BSS_INFO_BASIC, sizeof(*basic_req));
 	basic_req = (struct mt76_connac_bss_basic_tlv *)tlv;
@@ -2060,8 +2060,10 @@ mt7925_mcu_bss_basic_tlv(struct sk_buff *skb,
 
 	basic_req->phymode_ext = mt7925_get_phy_mode_ext(phy, vif, band, sta);
 
-	basic_phy = mt76_connac_get_phy_mode_v2(phy, vif, band, sta);
-	basic_req->nonht_basic_phy = cpu_to_le16(basic_phy);
+	if (band == NL80211_BAND_2GHZ)
+		basic_req->nonht_basic_phy = cpu_to_le16(PHY_TYPE_ERP_INDEX);
+	else
+		basic_req->nonht_basic_phy = cpu_to_le16(PHY_TYPE_OFDM_INDEX);
 
 	memcpy(basic_req->bssid, vif->bss_conf.bssid, ETH_ALEN);
 	basic_req->phymode = mt76_connac_get_phy_mode(phy, vif, band, sta);
@@ -2165,6 +2167,11 @@ mt7925_mcu_bss_bmc_tlv(struct sk_buff *skb, struct mt792x_phy *phy,
 
 	bmc = (struct bss_rate_tlv *)tlv;
 
+	if (band == NL80211_BAND_2GHZ)
+		bmc->basic_rate = cpu_to_le16(HR_DSSS_ERP_BASIC_RATE);
+	else
+		bmc->basic_rate = cpu_to_le16(OFDM_BASIC_RATE);
+
 	bmc->short_preamble = (band == NL80211_BAND_2GHZ);
 	bmc->bc_fixed_rate = idx;
 	bmc->mc_fixed_rate = idx;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
index 3c41e21303b1f..0218fd2a0eb01 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
@@ -334,7 +334,8 @@ struct bss_req_hdr {
 struct bss_rate_tlv {
 	__le16 tag;
 	__le16 len;
-	u8 __rsv1[4];
+	u8 __rsv1[2];
+	__le16 basic_rate;
 	__le16 bc_trans;
 	__le16 mc_trans;
 	u8 short_preamble;
-- 
2.43.0


