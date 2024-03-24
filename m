Return-Path: <linux-kernel+bounces-113121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB3A8881A0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 513301F20D44
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5DE15B98D;
	Sun, 24 Mar 2024 22:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+zoR5dS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C215715AACA;
	Sun, 24 Mar 2024 22:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319928; cv=none; b=OzjQURk3Zsjy7LQkdSE8OyYy3xMCaiRxHW76Jmmdd+DejJps52GNHlqd7KdU/o4CJfAmh+8PK+2cW0vfZO1NFzQKfwWycNt7tINV4o7NYH3y2q79x9krHybzMplbR/c1LmFAGGQ/XxZuPHRRsTXKoCwHaR5JvXqvPOIhmJ/SuFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319928; c=relaxed/simple;
	bh=RNYsYuQKgUBgQGFFaVdlUzbMpqamsaKv3m/Dft4PQXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P9+IKDv4m8K3vE/gLjVc/sFQQBRm3Ly3B1h4eJzkX53f/U6SI2r+jYPgTrWZNf6SUNwNMrFqf2vQrrbBm6TkrpRbBoAAUPCBY5xKh7bHfMS5teqSJKy08azkravzsbJ8Jo99zFLQkXzCJREsrad4opeVBdxj6bZoi6V/KdXXeeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+zoR5dS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 048D8C433A6;
	Sun, 24 Mar 2024 22:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319928;
	bh=RNYsYuQKgUBgQGFFaVdlUzbMpqamsaKv3m/Dft4PQXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l+zoR5dSzIkKJT5LlqBkU2+DhpD2Xu14mhADozLGipDe9zdoXPbMirFJJnLJ5rhtG
	 mIuPvfLQzYccMRCll07HAKnyKlwkWzJ8y4aPqtJuREu6+EB7uM+WEAmlHGJxwPnutg
	 DIKI0rc7aMBa+rkJ0oHb1HjD4FbnRhLFyJksoItFHKvllf1hg/GHeOtbjcvWEMRiRZ
	 U6xlyni1Jqkytf+wypFTnBdTaJYDSIh6uJMto2yL39OF6feuTNexzqZpwgh9mwDNiQ
	 8X2/ZMZkLlZrfItcUSREdX3g6f97cxxJW8sGHN9qwOcOSF50FqQ1wUfWyWH5FIQCul
	 0FII9aBb4rB7Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 234/715] wifi: mt76: mt7925: fix connect to 80211b mode fail in 2Ghz band
Date: Sun, 24 Mar 2024 18:26:53 -0400
Message-ID: <20240324223455.1342824-235-sashal@kernel.org>
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

[ Upstream commit 479146078a21ff2015cdd4e0467cba0559911915 ]

Driver should setting correct phy mode to firmware when in legacy mode.

Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index c5fd7116929b7..1fc9ecb96bc43 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1460,12 +1460,10 @@ mt7925_mcu_sta_phy_tlv(struct sk_buff *skb,
 	struct tlv *tlv;
 	u8 af = 0, mm = 0;
 
-	if (!sta->deflink.ht_cap.ht_supported && !sta->deflink.he_6ghz_capa.capa)
-		return;
-
 	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_PHY, sizeof(*phy));
 	phy = (struct sta_rec_phy *)tlv;
 	phy->phy_type = mt76_connac_get_phy_mode_v2(mvif->phy->mt76, vif, chandef->chan->band, sta);
+	phy->basic_rate = cpu_to_le16((u16)vif->bss_conf.basic_rates);
 	if (sta->deflink.ht_cap.ht_supported) {
 		af = sta->deflink.ht_cap.ampdu_factor;
 		mm = sta->deflink.ht_cap.ampdu_density;
-- 
2.43.0


