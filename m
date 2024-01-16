Return-Path: <linux-kernel+bounces-27819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3617182F659
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C13CD1F23546
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3DD2E645;
	Tue, 16 Jan 2024 19:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IpdHV8Bh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EA22E62F;
	Tue, 16 Jan 2024 19:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434276; cv=none; b=kSjjJo4QJNxzzObYMwz3xyuf6ZMkwi/b0wgAoNXGrxALMeSspDXIUWMYh5QQeJU5Adw7jJhTnvYT5Oe2F7NtmZWF4fNmbTfYZ5xJjsBN4tn8vXm/PaZd6zWKy6bYdyGPWEMT4FD3a8aBMUuUlRIcWa7kShnXlxr0NC5fI3+Xm6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434276; c=relaxed/simple;
	bh=2wSd7Pw557To/U/qMdiCZPjLJb0oe6gIifgwpckOdBM=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=mbpL+9cJVtaaLDkYrU22ph3X8avaB9S7LwAE4A2rbEqIL+9c6y2XGy27L8WAvj5bUQL7Fg3mKlDqqXUIYPT2aY3Qfqv9x2NydnDTNDZgfDAfaQDq6q7/MCFzP+3DNVntmmk9Wo64w9KctQaLixeEP8jl7h7n8mbq/GziolZCMcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IpdHV8Bh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FEF8C43394;
	Tue, 16 Jan 2024 19:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434276;
	bh=2wSd7Pw557To/U/qMdiCZPjLJb0oe6gIifgwpckOdBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IpdHV8BhVrFFt/+Wb55pBI5LD+FDj2oc2cDsAp1YT2gitXzRl8jeRdHPkA3UF/CaA
	 zGUwHD1rXBrkv5SCPkMO2zrUqztqTnJWNZc/+f6nQ5Nm3zbD7wQV8ytLIQ8HGCiN6C
	 6Q6vrNd0921uFL4r7/vbfmnDiOz4yG43GDlpZJzz+c3EHU8K0TV8Fq4VMoEl5dAcFg
	 +zor2JTxZfWp0Jc8AFqXztT4paJ2XRlybK4z5rcBM22kGaTErRy/969K9tFFlkNURj
	 YbGeXJ/UK3n/6ZKLOljoWbQ+aorwkyQ1Ueyt3UDcfHTq+NnVlGE73wJ8vC7UqiBtDb
	 /HLDXXjUq8JdA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: MeiChia Chiu <meichia.chiu@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	kvalo@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-wireless@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.7 048/108] wifi: mt76: connac: fix EHT phy mode check
Date: Tue, 16 Jan 2024 14:39:14 -0500
Message-ID: <20240116194225.250921-48-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194225.250921-1-sashal@kernel.org>
References: <20240116194225.250921-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
Content-Transfer-Encoding: 8bit

From: MeiChia Chiu <meichia.chiu@mediatek.com>

[ Upstream commit 2c2f50bf6407e1fd43a1a257916aeaa5ffdacd6c ]

Add a BSS eht_support check before returning EHT phy mode. Without this
patch, there might be an inconsistency where the softmac layer thinks
the BSS is in HE mode, while the FW thinks it is in EHT mode.

Signed-off-by: MeiChia Chiu <meichia.chiu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index ae6bf3c968df..b475555097ff 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -1359,7 +1359,7 @@ u8 mt76_connac_get_phy_mode_ext(struct mt76_phy *phy, struct ieee80211_vif *vif,
 	sband = phy->hw->wiphy->bands[band];
 	eht_cap = ieee80211_get_eht_iftype_cap(sband, vif->type);
 
-	if (!eht_cap || !eht_cap->has_eht)
+	if (!eht_cap || !eht_cap->has_eht || !vif->bss_conf.eht_support)
 		return mode;
 
 	switch (band) {
-- 
2.43.0


