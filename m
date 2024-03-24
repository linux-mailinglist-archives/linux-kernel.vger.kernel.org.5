Return-Path: <linux-kernel+bounces-113732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AD688864E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 317971C252EA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06A7148835;
	Sun, 24 Mar 2024 22:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EPz6L2tF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629B21DE12D;
	Sun, 24 Mar 2024 22:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320735; cv=none; b=eESqqD6xA4P1s5EO+2QJ5UjrNj+gJfXYxvgNPwxJUWbvI+WCmTE44w6n6ilLTUU4F+vWprwwhFEmRIiNUSiTB9OGOVI0sSrdGK2RkVqtV2s78JtqaTcL9OT6qjLTSLfjNr5eRjDEXmPG/+eYy5lrRu6H5+Kmk00rs5aHHAitNoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320735; c=relaxed/simple;
	bh=iZsxdmPJt5i3niPi+PdZmVKu1y2Ej9SipBlgIi6hUDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GPqadzMBTHAuNw4Yuwcrhe3rzuy+JTWVl/UGOO1pAJIezbG3KaMae8wGBW1EJdkVLikTIi3hT2DhgR5BBbgX/bvKUWooVlu+eUtMvWuv0pLrNg8jH/cHjGaTJTQGLnk+tqY3zdu5tSWD3V9UUD72HupR4E/4wvYGnBOESif3QLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EPz6L2tF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B80AC433F1;
	Sun, 24 Mar 2024 22:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320734;
	bh=iZsxdmPJt5i3niPi+PdZmVKu1y2Ej9SipBlgIi6hUDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EPz6L2tFUGpRcAWci7H4f0kkc3yxgB2yR2cPAR5vfSC/Zj4tyHeqZnn8plXxYiLcS
	 NXdKmf9ymCAyGGrbtsx1Nsk7sFMvpDeX4VvUbEB815LcnPWt60wF8VYt27bXm+EnaK
	 940IkBqFwhw4mXPVSF2AVzAoYf33NcBb7PDsgGweuKXnG6CTZW+iBbwjLB9R1uE6jr
	 /JAdvejTfNOHRpmDy13aVUFdvaRzL0oB1GBCxqtIT7hTupa7HEODjDBMdltOy1Lkcd
	 W20gEkIt6T+PjDvdQaViXBVuvJS2h1Fq21JEmwX1WK9znDloMzVpQhfaJFENvi7+aY
	 Jp4hBiIcnW/Pg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: StanleyYP Wang <StanleyYP.Wang@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 297/713] wifi: mt76: mt7996: fix efuse reading issue
Date: Sun, 24 Mar 2024 18:40:23 -0400
Message-ID: <20240324224720.1345309-298-sashal@kernel.org>
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
index e7a7d943b168c..0586f5bd4164f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -3426,7 +3426,7 @@ int mt7996_mcu_get_eeprom(struct mt7996_dev *dev, u32 offset)
 		u32 addr = le32_to_cpu(*(__le32 *)(skb->data + 12));
 		u8 *buf = (u8 *)dev->mt76.eeprom.data + addr;
 
-		skb_pull(skb, 64);
+		skb_pull(skb, 48);
 		memcpy(buf, skb->data, MT7996_EEPROM_BLOCK_SIZE);
 	}
 
-- 
2.43.0


