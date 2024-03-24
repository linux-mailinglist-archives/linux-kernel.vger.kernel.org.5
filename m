Return-Path: <linux-kernel+bounces-114194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17ADC888904
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C68FF282A87
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18F924CB66;
	Sun, 24 Mar 2024 23:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMxCwyDa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DD71514DA;
	Sun, 24 Mar 2024 23:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321529; cv=none; b=GGKtjAX6UQhKYw8L1gG8U+ysr8lHWJx3epk953IGKBD1rDMx1SyjRU2TwxEN6wn2HCpeW4UTycguaJlWQYIS6f68GQW8FyhH8l41vovdTZjsyuou0rDIMgiAg2MF7kTAh6qt2xcUofvFzkMvK3N9cbjffCVwf/TZXXQTo7DSa2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321529; c=relaxed/simple;
	bh=gG4NPeaHHJJjbHXioBGh7gKVMITJeUNeahrHehClb3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WYkGo1Q6miM9DHO3a7QZPIzJXenPYX5iXaTURUDpsfmdH1E5Fw+kU0KYmQpI0teEzQ4sAN20tbRPQwJcmgfvcfzAFB1RmXnZo+fJv9VhBnfGNRLCBGOZEt45hICKPzCLhWJ9xyw3afzvTCXBMTuP3qI3YOXcelgaPk2USXVxlwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMxCwyDa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E10FFC433C7;
	Sun, 24 Mar 2024 23:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321528;
	bh=gG4NPeaHHJJjbHXioBGh7gKVMITJeUNeahrHehClb3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EMxCwyDaB6l8KERJ0ozR1tITGGx8y0IcMBZXfMqtZ6Dre/7yWJKmRCsv7Mn4sUDj+
	 mLiNftG6hGhfovf4nWkvBnqzaFV1H/JBGqNn1XxehBj95I23eXalQ0FCjoG/24kmdJ
	 Q3R2zoL537Zi+QlL1Fpomj4eeO3fIwj5t8AN/bssd7IZq0Evym1ddb6xLMCHsMZEfo
	 oTadtazCIpS39D/da0muHThjg+J6lqBpJ3ZezG0i1zTdeCVYK6xNigbCfFXELOLypf
	 xeOtidrgDM7BYzdHXuaRQhVjpy1gTokMvO5eoUaxdUh3k5/jBUI64sZIU9UyOVCHPU
	 zPCPzIcvoNM+A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: StanleyYP Wang <StanleyYP.Wang@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 255/638] wifi: mt76: mt7996: fix efuse reading issue
Date: Sun, 24 Mar 2024 18:54:52 -0400
Message-ID: <20240324230116.1348576-256-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index 650c43cb899f7..b4ea7d0a7f5a0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -3100,7 +3100,7 @@ int mt7996_mcu_get_eeprom(struct mt7996_dev *dev, u32 offset)
 		u32 addr = le32_to_cpu(*(__le32 *)(skb->data + 12));
 		u8 *buf = (u8 *)dev->mt76.eeprom.data + addr;
 
-		skb_pull(skb, 64);
+		skb_pull(skb, 48);
 		memcpy(buf, skb->data, MT7996_EEPROM_BLOCK_SIZE);
 	}
 
-- 
2.43.0


