Return-Path: <linux-kernel+bounces-115481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E23889BD8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA88A1F34223
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B4D22AB8B;
	Mon, 25 Mar 2024 02:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jpCtw0ks"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD171D6854;
	Sun, 24 Mar 2024 22:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320721; cv=none; b=t3LmfBDlLp1Jb12AdpOeVEle/v+3YvyAEfacNCAAbvc36XRUAav466pnJB/4scaDqFU7RP/ha63B+vLF/TpUqfpIy/2F2kEJ4QQarhmwnzArFhtoRj7SHoyy1NcmiLaT/mJbNiSzKuuAfb8gNdm6GqLWxQ/ubfAbi5KlQakxvBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320721; c=relaxed/simple;
	bh=yM+lvq+E4qsRmSZJeOX0H2d21XeXzg/bB/kuYKF4gAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WoZcY7OUvg4lp+DTs/ijZL+3VkhFrtyddIMMiL55e1QW9o2v3xhsQ2GliFT4d4wOdXkyHr6Bth5W2l6/hLYIJZY+pAdYpciwNohtM6Cc7FBNe0nmHkkPaU37onkLnEPDku9pTi2/7Ttf4Pn9M3YzKkcpqcoxtX31qeM37cBVk4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jpCtw0ks; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF5CDC43390;
	Sun, 24 Mar 2024 22:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320720;
	bh=yM+lvq+E4qsRmSZJeOX0H2d21XeXzg/bB/kuYKF4gAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jpCtw0ksEDSNj5smJLtKCuEtR6nMGLCxof5oeYFaHxUjqlqMiROA/DHiZHojViboe
	 B4YSHgDvytD/ytAGmRONyHg6a0LeNJvu3Y1OAFnrO/CDs0Te8tJUiC90KEFub219HS
	 R9TLUM6f8Ar/Qa84kLKH0gurjqucVXoIYzU0XNErnnUNepM1egK9ij1vewGNwY+W+k
	 c4kq9nVMG7fOCNYramSk2+aRYqvJEwiOQNIT73vTtGs/Y4dUsAXirK8VKY/iJi/wxq
	 ZgxxZA2fKJZFuKYkCuEWbRr3uJ9FlXOuKZEE+Sib3zLSY+v2Nkw5OA/M0KjcGrbBat
	 EH1/IbobLrOlQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 283/713] wifi: mt76: mt7925: fix connect to 80211b mode fail in 2Ghz band
Date: Sun, 24 Mar 2024 18:40:09 -0400
Message-ID: <20240324224720.1345309-284-sashal@kernel.org>
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
index 9c0e397537acf..2e52f9281ab73 100644
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


