Return-Path: <linux-kernel+bounces-113135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D33E8881BC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C12701F217CD
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6373784D18;
	Sun, 24 Mar 2024 22:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ox5T8wlA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D7016FF5D;
	Sun, 24 Mar 2024 22:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319942; cv=none; b=HEFREiziFlK5oM1SnD+6QvIxRkZR3Dwo4QCwdswfvDpU3BQnrkV2p1UmtuwQgpRdRIkScUJBlsDvMnmR9MKtEu6ktu+ao02cEyjvPxWu6TORzQwo8cbiqrP2w+Na065XJjO8x+QGuK9moMz3lcMp0SPAAFcYWnpiujPJtC/hohM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319942; c=relaxed/simple;
	bh=xM4m3mZYXN/V90A7kAeayvG5Mdp5nbzjpe3S7nwJfrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kbEgjBkO3CUuYonxk6MWWNlRHFn5qWqN18JX5tkUT2de1TKA/8C1ku7aaLKN+tPTxaqzc/Bp6Ri4PfeEnDvF4ZUjNcBc+3XkyVrsuZm69HFtqEgzwMBBx8XDa7UGbbDMRGir+P6mY+aHetRo8r3qL22wBDUreh+T0bcbI9pFaF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ox5T8wlA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4A6FC433F1;
	Sun, 24 Mar 2024 22:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319942;
	bh=xM4m3mZYXN/V90A7kAeayvG5Mdp5nbzjpe3S7nwJfrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ox5T8wlAG90H6AAtRc8Vg1AP2E/Ioxd82J8iu3QvQ6Op3g+tv0Ceyyda563IwVy4D
	 bezG3lLgFf2yUUeuKRHatj5IDxJoMqrQM+Ktf6jQJG6N1u2pyyNolyLI7sX3d2MVNP
	 igv5DpsBUT/B20VvaJYxnKKBbQSShDvedYFlORLVtiS3OrXJO7i9jI0dyTwjLqFHNY
	 syky4kepiKBJpFOnhoASJmDX5eR+lz7hclPY/kC0XktnxyjBW/xufX+rbbq+TtC2co
	 0Dwc8axo/Ftpwxv0nNWB2wjRADo5YU/EN274SG+ZeokYDaqq/t7lFrOtpveVmMwpdo
	 VFbQDtmRJhLmg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: StanleyYP Wang <StanleyYP.Wang@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 248/715] wifi: mt76: mt7996: fix efuse reading issue
Date: Sun, 24 Mar 2024 18:27:07 -0400
Message-ID: <20240324223455.1342824-249-sashal@kernel.org>
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

From: StanleyYP Wang <StanleyYP.Wang@mediatek.com>

[ Upstream commit d3ad99be7cc2d174126d908addd6bea2b157aa75 ]

The efuse data starts from the 48th bytes instead of 64th bytes in the
returned event skb.

Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Signed-off-by: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 66351c19dbe41..9e70b960086ac 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -3551,7 +3551,7 @@ int mt7996_mcu_get_eeprom(struct mt7996_dev *dev, u32 offset)
 		u32 addr = le32_to_cpu(*(__le32 *)(skb->data + 12));
 		u8 *buf = (u8 *)dev->mt76.eeprom.data + addr;
 
-		skb_pull(skb, 64);
+		skb_pull(skb, 48);
 		memcpy(buf, skb->data, MT7996_EEPROM_BLOCK_SIZE);
 	}
 
-- 
2.43.0


