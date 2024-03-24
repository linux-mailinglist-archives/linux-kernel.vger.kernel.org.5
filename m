Return-Path: <linux-kernel+bounces-115486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6091D889BDF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BE3D2E42CD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9568B22C671;
	Mon, 25 Mar 2024 02:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNblo+vR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AD086AEE;
	Sun, 24 Mar 2024 22:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320723; cv=none; b=qKOl4+Ej7E14/dcJq3YewyMi/gOHxmy+weHV/HzCginCdYlWPlm+t2sw6ZH9E6Yog5drbE+zj7RNywJNwB6KV4Ta/iLLol3JknuT67GE6jPahoY6kpe07K1NMGgqKwXkgtRE8ITtcEiTxo+j17CHEg6NRruVlTlRTVUO9dtGvsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320723; c=relaxed/simple;
	bh=hOu54R0CvjRNb00hBid0gj+TQQnq3KD9I1H5Vd8dGLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FOi+gWHO9Br2PUv6PlAZjFxjvy+63Pbzyrn+hPgTJA1pjRAcaubLxCvL8nIMEe2f2DsmC8WLMpHdaq/OvV2xSrGwWNLXBsZd6gkheOnWYwVWIKhWzpX4eVZmg9QV4YGu6R9HAUc7zfxgUh87dEPoPpRabq5sL+iXLQ4fJgZxC7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNblo+vR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF8CFC433C7;
	Sun, 24 Mar 2024 22:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320722;
	bh=hOu54R0CvjRNb00hBid0gj+TQQnq3KD9I1H5Vd8dGLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fNblo+vRE7ajKnkS8LD9HzhyP/AZuA3tEiLzrKmsFH9fnCa9Ubiaw7OP2HZgK1+3t
	 yQu+rmCnlsBkeYdsYaioFEUtGiLF3JzdUTTYBZ0T27Ph8HTjTdOzVSCENyr2HrPE7H
	 /XQ7vuch54UchbE3K0YCKal6FBdVS0eo5qrh4xGMXsMM9Ck3TworJ7XfyDbuM9gduK
	 /Nry2gXigg+qXGyFpkOWp9fHBSbtk4jb38NYmoMubhEPEZ4AtlfiiOmn84UocxmopM
	 KIfrpB8O6jTf+cMEQktjWQsAnFYkaD6VPnWW+Vcq4TMDbkHJipEGV9ffzYzR1K0IV4
	 3EwRebPqDEtHA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hao Zhang <hao.zhang@mediatek.com>,
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 285/713] wifi: mt76: mt7925: fix mcu query command fail
Date: Sun, 24 Mar 2024 18:40:11 -0400
Message-ID: <20240324224720.1345309-286-sashal@kernel.org>
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
index 322198b20c0d3..8474b6d215dc3 100644
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


