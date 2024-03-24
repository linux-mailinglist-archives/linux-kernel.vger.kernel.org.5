Return-Path: <linux-kernel+bounces-115482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E8B889400
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 684551C2ECAF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A09422AB91;
	Mon, 25 Mar 2024 02:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L7r5RXKd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FFE1DE13A;
	Sun, 24 Mar 2024 22:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320736; cv=none; b=GmwH8/6SwhEjao36+34OYeT+yN0gJFeIOHcQeiZkLxBd0o7+A52Qd9DeDFROM5Xq8xmmUfAqnUXV7cfMwoE5J2SCR1OKUVBmmaoNKuIJI9ZGtxUyQir1XxWuDum9hEkEzAFXqDcEMoePkSXj7u2iygG862ms+iGS4SEnCc3GS8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320736; c=relaxed/simple;
	bh=neKTN06HKftInWaXkvQA3oNgLOGcIpYH0s7hLEhEuzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B5t2IahKbk91pKXwAOgndRfQLqOCFeiUJE6nKGpLIFtXLJGezlpLGTk9WR1c92kI4geMWUzzDhUeF9aDtD5Y8naTz5/bDgDyhB+rfRML4YuYU8D3yBG5M9YtP2Af3hYDELDc/HZTrs5i6mmaICB/pvOgH5WEcfFKju+dKqBK5AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L7r5RXKd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C949C433C7;
	Sun, 24 Mar 2024 22:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320735;
	bh=neKTN06HKftInWaXkvQA3oNgLOGcIpYH0s7hLEhEuzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L7r5RXKduF7BNQloErQs8ZqNaA1BE9VVc0iLZ80B+AjSCMMAP3FJmBAHKJd+j4Zgs
	 ZOEqCWx61adxYuIgX/N8WWaPxSpq62weJMZ44tpvxpczY2lmkOqOnTFoY5CWol7p7B
	 foOE2AX2t+veHp54VpKJvW8nLrT6q3B8Cw5TJrLSmOqyE9xMI3zkoe8cIitJ28X1rD
	 BPUtnN/HgWt87ktZOG5/72+xV1PLNOF1HQX10K4359hK1IlH867d5Z9CIdIXcUuSl4
	 TCI6nUO7fI99Cy5Gb2Cobzx/WdyoPrw9szY0PmCBJHQmcOc2lXuSbMGaX0oHoISbbc
	 A3Ar9Qe349iVQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Benjamin Lin <benjamin-jw.lin@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 298/713] wifi: mt76: mt7996: fix HIF_TXD_V2_1 value
Date: Sun, 24 Mar 2024 18:40:24 -0400
Message-ID: <20240324224720.1345309-299-sashal@kernel.org>
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
index 1d75bf23a02d4..f8b61df15fcb1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -297,7 +297,7 @@ static void mt7996_mac_init_basic_rates(struct mt7996_dev *dev)
 
 void mt7996_mac_init(struct mt7996_dev *dev)
 {
-#define HIF_TXD_V2_1	4
+#define HIF_TXD_V2_1	0x21
 	int i;
 
 	mt76_clear(dev, MT_MDP_DCR2, MT_MDP_DCR2_RX_TRANS_SHORT);
-- 
2.43.0


