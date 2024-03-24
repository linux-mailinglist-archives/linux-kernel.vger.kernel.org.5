Return-Path: <linux-kernel+bounces-115485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC4C889BDE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA83D2E3C33
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A383922C663;
	Mon, 25 Mar 2024 02:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u9UsNRgT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3C81DE10D;
	Sun, 24 Mar 2024 22:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320732; cv=none; b=lTJDfB78JqPfHRsd/42U8GM90m44P9D+XTFV2/8aIQqJlHdo6yPoIZwwNMsjB3WiV0PvQFnboLGPQKsOzAIB1hgrXlm41SzbGyPnubvw9EAX+lDgSfsNWOsk5EUSuVMUDqLJ+LDUBa2mOaJEHez5A68sxR8NOZArX0/4hjFgMYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320732; c=relaxed/simple;
	bh=0pEelp3HkQmrG5hoCPA0BrUxeXlKzW8azuUFfb0Ide0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ujYI9cdlF4m5KaDr9nI566xAUk/s4pWg/jkqxF+Msv1NwN5E0jZzwYx2dNMoA/76Bv2D9BJg/iQQfVuGW+MNXhO2SJe+TdQUkwDwPud7/darTphzCTD5NUlxGjVvCJSquRxmDwAInWPMsndkQJ9202c+Q2fMsNCewgGMZQn8fqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u9UsNRgT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84595C433C7;
	Sun, 24 Mar 2024 22:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320731;
	bh=0pEelp3HkQmrG5hoCPA0BrUxeXlKzW8azuUFfb0Ide0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u9UsNRgTg0wL78HOYTY0vbunnRhNlcBn0mJKN7mC+enwyQaI/qJul5mDfu4Ul5pnr
	 EeLvQ/r/9g1WlJes5PQXOOp8XWURV6eoCeG/R5eug56sXUUQnYPgsBdK4JGyhXeUbC
	 Jv66U2ae6Cd40r7z0FewKuveB23gQjD6z596bg143vZ+quv2DzsHxuL+NmP8OO1wv7
	 V4p2C0f+hHbIFHdZSOF/Sa3AIjFSSV8qB/ebjXwL0DblrbFmA+MYDIqBNbHh5difTz
	 dCjE3Jc1z8LdST/8iTVWAJGHQFloKwON/fGy/nMzer4mWBPEic8y3I76c0SpZKo2VQ
	 Z11AcmAja+p+g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Chiu <chui-hao.chiu@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 294/713] wifi: mt76: mt7996: fix TWT issues
Date: Sun, 24 Mar 2024 18:40:20 -0400
Message-ID: <20240324224720.1345309-295-sashal@kernel.org>
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

[ Upstream commit 5c832c228f6a7ba7e900c5296ce0fb3844bafec5 ]

This patch fixes the following TWT issues:
- Change table_mask to u16 to support up to 16 TWT stations
- Reject TWT flows for duplicated establishment
- Fix possible unaligned pointer
- Remove unsupported TWT_CONTROL_WAKE_DUR_UNIT flag
- The minimum TWT duration supported by mt7996 chipsets is 64. Reply
  with TWT_SETUP_CMD_DICTATE if the min_twt_dur is smaller than 64

Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7996/mac.c   | 53 ++++++++++++++++---
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |  3 +-
 2 files changed, 47 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index cee2ede268a2d..7d33b0c8955ba 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -2461,6 +2461,34 @@ static int mt7996_mac_check_twt_req(struct ieee80211_twt_setup *twt)
 	return 0;
 }
 
+static bool
+mt7996_mac_twt_param_equal(struct mt7996_sta *msta,
+			   struct ieee80211_twt_params *twt_agrt)
+{
+	u16 type = le16_to_cpu(twt_agrt->req_type);
+	u8 exp;
+	int i;
+
+	exp = FIELD_GET(IEEE80211_TWT_REQTYPE_WAKE_INT_EXP, type);
+	for (i = 0; i < MT7996_MAX_STA_TWT_AGRT; i++) {
+		struct mt7996_twt_flow *f;
+
+		if (!(msta->twt.flowid_mask & BIT(i)))
+			continue;
+
+		f = &msta->twt.flow[i];
+		if (f->duration == twt_agrt->min_twt_dur &&
+		    f->mantissa == twt_agrt->mantissa &&
+		    f->exp == exp &&
+		    f->protection == !!(type & IEEE80211_TWT_REQTYPE_PROTECTION) &&
+		    f->flowtype == !!(type & IEEE80211_TWT_REQTYPE_FLOWTYPE) &&
+		    f->trigger == !!(type & IEEE80211_TWT_REQTYPE_TRIGGER))
+			return true;
+	}
+
+	return false;
+}
+
 void mt7996_mac_add_twt_setup(struct ieee80211_hw *hw,
 			      struct ieee80211_sta *sta,
 			      struct ieee80211_twt_setup *twt)
@@ -2472,8 +2500,7 @@ void mt7996_mac_add_twt_setup(struct ieee80211_hw *hw,
 	enum ieee80211_twt_setup_cmd sta_setup_cmd;
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
 	struct mt7996_twt_flow *flow;
-	int flowid, table_id;
-	u8 exp;
+	u8 flowid, table_id, exp;
 
 	if (mt7996_mac_check_twt_req(twt))
 		goto out;
@@ -2486,9 +2513,19 @@ void mt7996_mac_add_twt_setup(struct ieee80211_hw *hw,
 	if (hweight8(msta->twt.flowid_mask) == ARRAY_SIZE(msta->twt.flow))
 		goto unlock;
 
+	if (twt_agrt->min_twt_dur < MT7996_MIN_TWT_DUR) {
+		setup_cmd = TWT_SETUP_CMD_DICTATE;
+		twt_agrt->min_twt_dur = MT7996_MIN_TWT_DUR;
+		goto unlock;
+	}
+
+	if (mt7996_mac_twt_param_equal(msta, twt_agrt))
+		goto unlock;
+
 	flowid = ffs(~msta->twt.flowid_mask) - 1;
-	le16p_replace_bits(&twt_agrt->req_type, flowid,
-			   IEEE80211_TWT_REQTYPE_FLOWID);
+	twt_agrt->req_type &= ~cpu_to_le16(IEEE80211_TWT_REQTYPE_FLOWID);
+	twt_agrt->req_type |= le16_encode_bits(flowid,
+					       IEEE80211_TWT_REQTYPE_FLOWID);
 
 	table_id = ffs(~dev->twt.table_mask) - 1;
 	exp = FIELD_GET(IEEE80211_TWT_REQTYPE_WAKE_INT_EXP, req_type);
@@ -2535,10 +2572,10 @@ void mt7996_mac_add_twt_setup(struct ieee80211_hw *hw,
 unlock:
 	mutex_unlock(&dev->mt76.mutex);
 out:
-	le16p_replace_bits(&twt_agrt->req_type, setup_cmd,
-			   IEEE80211_TWT_REQTYPE_SETUP_CMD);
-	twt->control = (twt->control & IEEE80211_TWT_CONTROL_WAKE_DUR_UNIT) |
-		       (twt->control & IEEE80211_TWT_CONTROL_RX_DISABLED);
+	twt_agrt->req_type &= ~cpu_to_le16(IEEE80211_TWT_REQTYPE_SETUP_CMD);
+	twt_agrt->req_type |=
+		le16_encode_bits(setup_cmd, IEEE80211_TWT_REQTYPE_SETUP_CMD);
+	twt->control = twt->control & IEEE80211_TWT_CONTROL_RX_DISABLED;
 }
 
 void mt7996_mac_twt_teardown_flow(struct mt7996_dev *dev,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 3434ca50d3181..6733ee9744d9b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -43,6 +43,7 @@
 
 #define MT7996_MAX_TWT_AGRT		16
 #define MT7996_MAX_STA_TWT_AGRT		8
+#define MT7996_MIN_TWT_DUR		64
 #define MT7996_MAX_QUEUE		(__MT_RXQ_MAX +	__MT_MCUQ_MAX + 3)
 
 /* NOTE: used to map mt76_rates. idx may change if firmware expands table */
@@ -236,7 +237,7 @@ struct mt7996_dev {
 	struct rchan *relay_fwlog;
 
 	struct {
-		u8 table_mask;
+		u16 table_mask;
 		u8 n_agrt;
 	} twt;
 
-- 
2.43.0


