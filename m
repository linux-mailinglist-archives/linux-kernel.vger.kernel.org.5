Return-Path: <linux-kernel+bounces-115655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B31E0889D6B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB778BA0766
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F357207E85;
	Mon, 25 Mar 2024 02:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pkv6PfLV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07CE1514E1;
	Sun, 24 Mar 2024 23:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321530; cv=none; b=or+YRr3azBydzHSWTZpJBw8OR0XWxZN01nHpLGF7CgiepjeXih8GkLfDFORuDGNdQKz2MeCtkVjGHRhjoIsnIPZB5A7/sjJW+jc8GP4XniIGiaksTjy/nPny0cSSGT9SvpqCImfp+1x1hj3pa5oybhy8FaeWKhY7EZYN1TgEpBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321530; c=relaxed/simple;
	bh=sOnFWM7/W5GNbO/a/LDuUceaCzlQt2n5kgO6W1Y1mog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mEDNvL9h7lVpB+X0+9yjq2r+W0PdY87Nksm9zxNGNLy9VCYc2DcIJORmKUa/PgGHkfz31yVqzUjD1N+BZ1zadvx2gRxEnq4uqKoWwzOR8owSKbkV7WX1NXBrn3vNEerb7Yc0jXZ+2uE8OaGZUUpjJqqsG9N3yDZS4HujZ8LyR/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pkv6PfLV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9331C43390;
	Sun, 24 Mar 2024 23:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321529;
	bh=sOnFWM7/W5GNbO/a/LDuUceaCzlQt2n5kgO6W1Y1mog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pkv6PfLVIkag/SAd217v5yBVWyh1/zccGRLX5UlvSqFDBUnjsaCjwys4iSlWhLEAT
	 OliafYusjXi3Asc78xAyF+x6fnnoSibfNHYuZl1fDdtEfpNu1uN0mrWzsg+msxBk7D
	 /PIG/shOAmR+7hiDIkVwQNXl9y+9oMM3gNSV+ESvMA5CLukFvlmAqvSEPhFidz0PXi
	 CmuuZkgiv7Xvrr4MV021QrMF2UOc/QdXmMFWyTWQlrOx5UTjiIl35Ds0fXlzhVeMIu
	 e0ayvco0ATrU7uFW0D8Uq5C7nmknvCVGls5wx+GcwavqQPcNi1i8NfXp6g1J3hVmDn
	 ID32u2xUh50aw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Benjamin Lin <benjamin-jw.lin@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 256/638] wifi: mt76: mt7996: fix HIF_TXD_V2_1 value
Date: Sun, 24 Mar 2024 18:54:53 -0400
Message-ID: <20240324230116.1348576-257-sashal@kernel.org>
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

From: Benjamin Lin <benjamin-jw.lin@mediatek.com>

[ Upstream commit de8882775156682ba358afc82cb575c92cf3d092 ]

Sync the value of HIF_TXD_V2_1 with firmware to let it correctly fill
TXD values for HW path.

Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Signed-off-by: Benjamin Lin <benjamin-jw.lin@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index e843d40df5bb4..2016ed9197fe3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -276,7 +276,7 @@ static void mt7996_mac_init_basic_rates(struct mt7996_dev *dev)
 
 void mt7996_mac_init(struct mt7996_dev *dev)
 {
-#define HIF_TXD_V2_1	4
+#define HIF_TXD_V2_1	0x21
 	int i;
 
 	mt76_clear(dev, MT_MDP_DCR2, MT_MDP_DCR2_RX_TRANS_SHORT);
-- 
2.43.0


