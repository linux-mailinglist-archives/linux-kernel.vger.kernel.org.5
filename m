Return-Path: <linux-kernel+bounces-113124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D7A8881A6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04B6D1F21697
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F6F15D5B2;
	Sun, 24 Mar 2024 22:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jv2BgYB1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FCD15CD79;
	Sun, 24 Mar 2024 22:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319931; cv=none; b=KgOCWX3CmcO81535LbZFf2v84c4nQb3NpQfPrm0hQcipPEHd17HpSQF9+NkIBu2jKWOpQWSNnOZSNnxAoIOiRYmAXg2DgcqFOl2TluYIKTx+6yuSLXZr1UXmhS/bc7TrCMNNvphBJWJd1pYU6yiVFddHLLHQBxap9fmKI9w3Q0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319931; c=relaxed/simple;
	bh=UeK/A54gDnmHHZB4cJGUlqGjX029xfIIdbAYLn/yJ6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cv4O6lBWQSxcv4tpFn4pfkgkQ8tYQDdn48B4vcn18ujEtdDAFl2CDAG/ZmQptTk5t4vuBhy/o47ZksetT250BKWlRrGk4S224U5+7Olj+HqHRWBi8uwwer4v9dAHSX2XHBue3tnEQwraMs5L+O0uauDtI91pVGMIpKk3zLATwxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jv2BgYB1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F130DC43390;
	Sun, 24 Mar 2024 22:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319931;
	bh=UeK/A54gDnmHHZB4cJGUlqGjX029xfIIdbAYLn/yJ6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jv2BgYB1hALUG18UketgwSCyJsQDuJCULnV1EW2M5buX+KjNiQdGnP8K4S7UTegdr
	 Pkd1RCuqgEH2nbSZdYS0XGbCaFdZp50jr+0ofF0QP2AHnjZK0zEOQ8IPwtSbWq6Jft
	 ZJ1M4nWXUVVrxK9l7F7ecZhzvzsAKXEaXwnPt1IRHKyzERpFREU8oAT4g9gT5q2Fe3
	 yqa0H6JdO1wNXxeSjBsaQBjU+RWoyc5sjTdkgMQ5LayWcnX4p+nzV1E13Yo6HJ/5IF
	 xy5xz+jrlRaM4UhMD39lJ1ESly+anlifiXQj09nui837JUywWAxIyL2jB2+MhlMW5Y
	 Ks5UuCiFLUwjg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 237/715] wifi: mt76: mt7925: fix wmm queue mapping
Date: Sun, 24 Mar 2024 18:26:56 -0400
Message-ID: <20240324223455.1342824-238-sashal@kernel.org>
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
index 125a1be3cb64c..5671e08dec654 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1273,6 +1273,25 @@ mt7925_channel_switch_beacon(struct ieee80211_hw *hw,
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
@@ -1396,7 +1415,7 @@ const struct ieee80211_ops mt7925_ops = {
 	.add_interface = mt7925_add_interface,
 	.remove_interface = mt792x_remove_interface,
 	.config = mt7925_config,
-	.conf_tx = mt792x_conf_tx,
+	.conf_tx = mt7925_conf_tx,
 	.configure_filter = mt7925_configure_filter,
 	.bss_info_changed = mt7925_bss_info_changed,
 	.start_ap = mt7925_start_ap,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 4811fccbe30e8..0299045b4b833 100644
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


