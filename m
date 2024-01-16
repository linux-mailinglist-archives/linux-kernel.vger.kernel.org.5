Return-Path: <linux-kernel+bounces-27955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F1682F84C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D4901C24E39
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D2324B43;
	Tue, 16 Jan 2024 19:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHxiU8fZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F21524B41;
	Tue, 16 Jan 2024 19:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434678; cv=none; b=G981qUMPMowo1hZlsjeG0XjP0q7pfQgzz7im/TmwdIhTbD/nJ6h8URgYxclwpTn06v3TKR7WJiKC/VIOu1AmVArolTV/GrdQCtWAQ+YgXIdJ8FJVIBlcuMNbWdhLsRgC3ZI2KAQc4ODAb5SqZ7ZwxCO6NeD7lvyJO7usCcN9GTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434678; c=relaxed/simple;
	bh=QbtDIgq36wGYPjbNL99cbfZ0a3/J5QTkywmWt95A8NI=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=M1y905Ia3O0dylv4XMd8w0c6Kv/jvH5+QbHCE2GJV1QpgjsWt1bLPaAORzm+U9G27kr8KXrBYZoEP/+qTzb20OAba/P7tTz6Pv/XbAa37UJcwJAuTHcOL/uk+Zcnmthd21lVBnaZKgdaBRt1C16JJZwpAkjdmddAE7Xr1Mt7k8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHxiU8fZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9398DC433C7;
	Tue, 16 Jan 2024 19:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434678;
	bh=QbtDIgq36wGYPjbNL99cbfZ0a3/J5QTkywmWt95A8NI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hHxiU8fZlJRbMqKsx9gvXIEg1eeN2TsNf7muaX31P0ZzbU3ulPAKx1C/ZFwZEheiv
	 OVXgJXyiWTYC/1Fs10V0B7gYz6lcHCr0KhQZKPgzndyH9RIS4aGVi+N48C3yGPpFM3
	 4kY+KQcIMjhpPwlkHoMbeqz1TbXW6tVltjrPbRpyJNC87ZxZZ+BohBmBqmV3KOXRNG
	 KhUz/ZvEGOWsO5an46f5/LYp0fFtLjuv6d5ZCD+clNoMAjLO5g7rLg99EkWIw5Uq4n
	 ZCoPpa9l29Y5nbcdzlHFLV0A24dFCrLR8OiQ+Cgkts2V8Qw5s3rsEpSSXGB0opOfJH
	 fOVL5Lcbz7w2g==
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
Subject: [PATCH AUTOSEL 6.6 047/104] wifi: mt76: connac: fix EHT phy mode check
Date: Tue, 16 Jan 2024 14:46:13 -0500
Message-ID: <20240116194908.253437-47-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194908.253437-1-sashal@kernel.org>
References: <20240116194908.253437-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
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
index 8274a57e1f0f..dc4fbab1e1b7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -1347,7 +1347,7 @@ u8 mt76_connac_get_phy_mode_ext(struct mt76_phy *phy, struct ieee80211_vif *vif,
 	sband = phy->hw->wiphy->bands[band];
 	eht_cap = ieee80211_get_eht_iftype_cap(sband, vif->type);
 
-	if (!eht_cap || !eht_cap->has_eht)
+	if (!eht_cap || !eht_cap->has_eht || !vif->bss_conf.eht_support)
 		return mode;
 
 	switch (band) {
-- 
2.43.0


