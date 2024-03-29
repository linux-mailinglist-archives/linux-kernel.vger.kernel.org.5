Return-Path: <linux-kernel+bounces-124524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D52389194F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00445B24639
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D77A1465B9;
	Fri, 29 Mar 2024 12:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5snKhEE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD0B14601F;
	Fri, 29 Mar 2024 12:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715302; cv=none; b=MbXTYi5O3di8gjti7Zn7qRtt1ahXlW6WsFeWYAUJsiOuEpqVXsDz14sKOojF+uTZFBzSAHOkYz/CJaBB4G/qQhJNDvUGFjmOgt+QkTGf3N1iEAjq5O79ie2OS7agQoRIqjlDhUDU4MNMG7+IU/UCRoTY6yRlU5xFf+nZwV4C91M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715302; c=relaxed/simple;
	bh=jynmpQ+qq4mMAdefWa+kWyANDOVCxQSgDNakmtIj/GI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=flg/UKSUM1kevPr4mEVKCaYeezmsF98nMOL8NPyaVLpdWbqWau8YkGG7qenIEFIPPeSNbIACsYZ/BnvzUybHcXS9H0O1+Y1wItZvZxI6fWF8vlrAXoHO9jDtBvtyVTn5kICHSzcvRhx3znWnvlx9hea3ytyTUQ4Votlp/SxwsEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5snKhEE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E7C2C43609;
	Fri, 29 Mar 2024 12:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715302;
	bh=jynmpQ+qq4mMAdefWa+kWyANDOVCxQSgDNakmtIj/GI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X5snKhEEcT/WGxEkE01izFAsMrheMdWO9htbyEXeUf9yJm0G1TEC/HnHebTTmGvCv
	 R0+8O4mwhHxT1PYjEnVz9TicMkJWsLI9NLFXV+XGs5EWxGOtkG4VYuQyRLkWfv6E0f
	 08xqZFIFpGG/ooFECK3Dn2+dc3cU4LLoq4R7werOGc4C48puyZjhJ+Ur5dsAK+dUeQ
	 jJiyMLSJI9LSfWmcfLHjy1phdCzGRHj57rtyAhX9iHe7S7l+WbrbbD3EI0iwmhgsdY
	 s6CGoAEdL+D/fcAQKZLqY5qORekiMaLwoGZaQ8dsIR+5vO9SgWritvRScV5uLKQUyS
	 5TYXgc1lvkXSw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Chiu <chui-hao.chiu@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	kvalo@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	yi-chia.hsieh@mediatek.com,
	Bo.Jiao@mediatek.com,
	benjamin-jw.lin@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.8 43/68] wifi: mt76: mt7996: disable AMSDU for non-data frames
Date: Fri, 29 Mar 2024 08:25:39 -0400
Message-ID: <20240329122652.3082296-43-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122652.3082296-1-sashal@kernel.org>
References: <20240329122652.3082296-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
Content-Transfer-Encoding: 8bit

From: Peter Chiu <chui-hao.chiu@mediatek.com>

[ Upstream commit 5d5edc09197cd8c705b42a73cdf8ba03db53c033 ]

Disable AMSDU for non-data frames to prevent TX token leak issues.

Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 53258488d49f3..b5b8b163f94df 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -732,6 +732,9 @@ mt7996_mac_write_txwi_8023(struct mt7996_dev *dev, __le32 *txwi,
 	      FIELD_PREP(MT_TXD2_SUB_TYPE, fc_stype);
 
 	txwi[2] |= cpu_to_le32(val);
+
+	if (wcid->amsdu)
+		txwi[3] |= cpu_to_le32(MT_TXD3_HW_AMSDU);
 }
 
 static void
@@ -862,8 +865,6 @@ void mt7996_mac_write_txwi(struct mt7996_dev *dev, __le32 *txwi,
 		val |= MT_TXD3_PROTECT_FRAME;
 	if (info->flags & IEEE80211_TX_CTL_NO_ACK)
 		val |= MT_TXD3_NO_ACK;
-	if (wcid->amsdu)
-		val |= MT_TXD3_HW_AMSDU;
 
 	txwi[3] = cpu_to_le32(val);
 	txwi[4] = 0;
-- 
2.43.0


