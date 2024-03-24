Return-Path: <linux-kernel+bounces-113123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6337A8881A4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94F4E1C21C6A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A278A15CD75;
	Sun, 24 Mar 2024 22:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nVzqEYzY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C950215B112;
	Sun, 24 Mar 2024 22:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319930; cv=none; b=HhQldXkgwBeQiJnblj72qDe4LoivApr9VCJt0D6smDUBobwio7YbdZVfutZJEqA1mWWFtA2N4po1FWR6YLKBKOCvFfVuLdcsnsMrkvzOPdn6/2cckKOEJBPWcLQK41yyYqY2chD9s27sSlVNFnx1YTqfOTJW1oNlddz9/3iL4w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319930; c=relaxed/simple;
	bh=7I+eM9iiHn0jw27jBGSgNtkVizxzH2JvS6oAmHe0shc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DraWe/BeCFJtLda7CgCD2ejCC6pXN64Dm0ofKKkX/w2i8cULB4RNjxWtfs+vgb3v2LUORGy+AaFf1Ay+J/nUhIxWw33jevTLlvnQzGR0530/o6/XLu4Qc6mH5n/L2y/8ZHR8NW6y2m82/rKi0QRgeq8dnVPi1//aw1b0FvYxwT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nVzqEYzY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB12C433B1;
	Sun, 24 Mar 2024 22:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319930;
	bh=7I+eM9iiHn0jw27jBGSgNtkVizxzH2JvS6oAmHe0shc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nVzqEYzYkGSjFTXzE9jvNZBO//QeLndHQL3pgtCJukLSaXelFAb1EMPkQNBH0JWka
	 uVcdHASA1JmKfsF4srUVLRuuFIoGpA9kgwhiNB5/ZvgqZ4Am1sdJxH3kpDGrgLhD0/
	 yjQiArigdAuL80X2Kjt2/neUWLb90LApxraT23FyQSd4Lzr14pW2tZrzGVNHZ5QciQ
	 y0CdNMKSfGx/drkdGPzZs2/Mdy6QcM2qJRHSNZGsWWZ2X99ronqTQiMyQ+ViZrVeQO
	 zbLT67UPI7jATgHUbSMlcZ/V6e7JOgyuZNuO8odmDGpg7OEkKIk3TuhLVYZafrkhlu
	 rLt717eiO8EQg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hao Zhang <hao.zhang@mediatek.com>,
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 236/715] wifi: mt76: mt7925: fix mcu query command fail
Date: Sun, 24 Mar 2024 18:26:55 -0400
Message-ID: <20240324223455.1342824-237-sashal@kernel.org>
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

From: Hao Zhang <hao.zhang@mediatek.com>

[ Upstream commit 2f475cb63eb304bdbb58c9b07b0547ca6c343012 ]

Apply query command type properly to make the chip send the response back.
Otherwise, we may see the command timeout in driver side.

Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
Signed-off-by: Hao Zhang <hao.zhang@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 9a8db9b1a4f2b..4811fccbe30e8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -2850,12 +2850,16 @@ int mt7925_mcu_fill_message(struct mt76_dev *mdev, struct sk_buff *skb,
 	if (cmd & __MCU_CMD_FIELD_UNI) {
 		uni_txd = (struct mt76_connac2_mcu_uni_txd *)txd;
 		uni_txd->len = cpu_to_le16(skb->len - sizeof(uni_txd->txd));
-		uni_txd->option = MCU_CMD_UNI_EXT_ACK;
 		uni_txd->cid = cpu_to_le16(mcu_cmd);
 		uni_txd->s2d_index = MCU_S2D_H2N;
 		uni_txd->pkt_type = MCU_PKT_ID;
 		uni_txd->seq = seq;
 
+		if (cmd & __MCU_CMD_FIELD_QUERY)
+			uni_txd->option = MCU_CMD_UNI_QUERY_ACK;
+		else
+			uni_txd->option = MCU_CMD_UNI_EXT_ACK;
+
 		goto exit;
 	}
 
-- 
2.43.0


