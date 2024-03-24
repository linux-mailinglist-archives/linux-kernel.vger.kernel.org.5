Return-Path: <linux-kernel+bounces-115487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A169A889BE3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 416F81F356CA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DF122E14B;
	Mon, 25 Mar 2024 02:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rb7kMcQS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C53126F1D;
	Sun, 24 Mar 2024 22:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320724; cv=none; b=LHvhAYvJsLCkP0LnLOgBWyo+47cUBz6pWnRpfbBxiLVMzWdxhbkD9VCzKBgynakJFTKjRiQAx9U3X+ba1nuB6Rd+QcA9ECyMMuVg2f5A1twy3dVwsIMb7UthzDE2ZFoCXP7GHs0zDEne+seecDGAmE0qHUkl4njToV6Oy7Rrqio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320724; c=relaxed/simple;
	bh=Hi662W5k7dEdKM5NinxtbD2nAiYb2fccj97q+xO9/VU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sQbXD9kjyp7JpD5r0h2lRBU5RWSn5ybuaplT+tl0j+Tm1Kvm6nGFtGskS1K4/sO6BHqahL+6bH6KHtPbGShRa+iDPC7uOvgjjJJNF4rS4Mlnann1CGrIE/o6cB7sFZe0UenHb8N069SGxpPecm7r/o3Sesx1OU92eaepTwL4hsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rb7kMcQS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0BC1C43390;
	Sun, 24 Mar 2024 22:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320723;
	bh=Hi662W5k7dEdKM5NinxtbD2nAiYb2fccj97q+xO9/VU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rb7kMcQSQUa8MDYFRz/aykKR1UfYCNLhyoz363PFPL8BOKh9JjS5KiGYlTV+SFutx
	 UGJC7kqCT/LjaJwFXYH4mGV0cTJDOznFcahRKGHuEYObXCL6QiN8gpb25YrtYdokf1
	 eO5SKAqr0uq09pQm3QMFc2JXw5Wr0v3qzADsbfuWlMguxxemd6yMj5c0qO7uDr99t9
	 W7Lrxplh0iUBB9a01Yk1fmyDNQNGv2sGV3r3n2GI3LnaA2iarh981bXNceF2VDcxYy
	 js8NQqjBHEElWMCM0WfRZBmDSENRhdLC/yKnhGA2rfjpn5H2+XJqRNKBW3DLE3Uink
	 qW68n+6ed+YTQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 286/713] wifi: mt76: mt7925: fix wmm queue mapping
Date: Sun, 24 Mar 2024 18:40:12 -0400
Message-ID: <20240324224720.1345309-287-sashal@kernel.org>
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

[ Upstream commit 9d89edb576e385267f40193bd3776157101a504a ]

Firmware uses access class index (ACI) for wmm parameters update,
so convert mac80211 queue to ACI in mt7925_conf_tx().

Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7925/main.c  | 21 ++++++++++++++++++-
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   |  2 +-
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index aa918b9b0469f..b6aa792e5511f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1274,6 +1274,25 @@ mt7925_channel_switch_beacon(struct ieee80211_hw *hw,
 	mt792x_mutex_release(dev);
 }
 
+static int
+mt7925_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+	       unsigned int link_id, u16 queue,
+	       const struct ieee80211_tx_queue_params *params)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	static const u8 mq_to_aci[] = {
+		    [IEEE80211_AC_VO] = 3,
+		    [IEEE80211_AC_VI] = 2,
+		    [IEEE80211_AC_BE] = 0,
+		    [IEEE80211_AC_BK] = 1,
+	};
+
+	/* firmware uses access class index */
+	mvif->queue_params[mq_to_aci[queue]] = *params;
+
+	return 0;
+}
+
 static int
 mt7925_start_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		struct ieee80211_bss_conf *link_conf)
@@ -1397,7 +1416,7 @@ const struct ieee80211_ops mt7925_ops = {
 	.add_interface = mt7925_add_interface,
 	.remove_interface = mt792x_remove_interface,
 	.config = mt7925_config,
-	.conf_tx = mt792x_conf_tx,
+	.conf_tx = mt7925_conf_tx,
 	.configure_filter = mt7925_configure_filter,
 	.bss_info_changed = mt7925_bss_info_changed,
 	.start_ap = mt7925_start_ap,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 8474b6d215dc3..b21fe015a701b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -895,7 +895,7 @@ int mt7925_mcu_set_tx(struct mt792x_dev *dev, struct ieee80211_vif *vif)
 
 		e = (struct edca *)tlv;
 		e->set = WMM_PARAM_SET;
-		e->queue = ac + mvif->mt76.wmm_idx * MT76_CONNAC_MAX_WMM_SETS;
+		e->queue = ac;
 		e->aifs = q->aifs;
 		e->txop = cpu_to_le16(q->txop);
 
-- 
2.43.0


