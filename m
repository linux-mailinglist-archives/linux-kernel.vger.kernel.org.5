Return-Path: <linux-kernel+bounces-113739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2175788865A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 524E91C2552D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F991494B9;
	Sun, 24 Mar 2024 22:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bdXQPofB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF1F126F3E;
	Sun, 24 Mar 2024 22:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320742; cv=none; b=pCW1QECqSnuQt1YYEt9jgw0IeUnFm+MfXv/AHJ0bozb2rikJ4cMxa6e0flw5WBZd4MbT+DB5rbbSwpb6BdwMbe1hQzTcfvqrdiWwHlhSxH+Qzs6+X/8YnPpcUN1wrBizeweiy+qBkohNFV7dWht8/hD7mVmrIaetRYVOAzOqfGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320742; c=relaxed/simple;
	bh=DEC3DToOjlvv/6yVq+ThedLbsWTQe1fADO01HVYUtXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tEWEKpjC+HcgSdvH9T19rLA90ypQ8s7GyT4uwWtmvdZOKEtediTgfz2FtdyaBvkDVQT7fDvegWAKwr/K0dKqxmKvvUIX2mawm/GYtEAmAEMJ3KJGfqfF5QxAS+Dj05txD6Y/2TWWidwuYAnZDTgim/aDYCKAbE9WvuBR3hvtlhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bdXQPofB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F6DC433F1;
	Sun, 24 Mar 2024 22:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320741;
	bh=DEC3DToOjlvv/6yVq+ThedLbsWTQe1fADO01HVYUtXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bdXQPofB4FuUz1AtZqWkTWD0yFBYf6BX5IXD1gdxBMTKuehD3gNuMqF9dqXRNCE58
	 6N6LGrqg+lLCTeCPEebwal0tUUQPEemGU8J/TgQx3Z39kVHlBhD6G3LnGQogm7Lh2Q
	 NV3ZaNEKeBIu02k5oR1QfcT5YPcdP9ZyD37EizRp1HNSfa0QDHc93ZJqPXxBmiL5Z8
	 gEzm0c2VAHK79H6Bk5KGmcz4KDB9VY5fQ3RerUzvSlc3ak14HubSRXA1srewGR0eC/
	 hwOTXhB2MVHfS3enIj3jyUVihsfqrNHz15j/8fu1WdWytcgIEBraguco3wIR/mLnTW
	 X1+gj1orXFvlA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 304/713] wifi: mt76: fix the issue of missing txpwr settings from ch153 to ch177
Date: Sun, 24 Mar 2024 18:40:30 -0400
Message-ID: <20240324224720.1345309-305-sashal@kernel.org>
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

[ Upstream commit e9a46175a79fbc591c48d433020444b8fa2750ee ]

Because the number of channels to be configured is calculated using the %,
and it results in 0 when there's an exact division, this leads to some
channels not having their tx power configured.

Fixes: 7801da338856 ("wifi: mt76: mt7921: enable set txpower for UNII-4")
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index b475555097ff2..633f56210563c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -2100,7 +2100,7 @@ mt76_connac_mcu_rate_txpower_band(struct mt76_phy *phy,
 		int j, msg_len, num_ch;
 		struct sk_buff *skb;
 
-		num_ch = i == batch_size - 1 ? n_chan % batch_len : batch_len;
+		num_ch = i == batch_size - 1 ? n_chan - i * batch_len : batch_len;
 		msg_len = sizeof(tx_power_tlv) + num_ch * sizeof(sku_tlbv);
 		skb = mt76_mcu_msg_alloc(dev, NULL, msg_len);
 		if (!skb) {
-- 
2.43.0


