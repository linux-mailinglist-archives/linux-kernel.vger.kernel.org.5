Return-Path: <linux-kernel+bounces-113120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5456C88819F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D837CB21B54
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E458F15B978;
	Sun, 24 Mar 2024 22:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oviC+T9+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A05715B119;
	Sun, 24 Mar 2024 22:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319928; cv=none; b=j+g/30etb1kdZm8VOYe9+z/23J2Rc4y3NnoDTjpw6UIuCLKA1vs6tAScYaaOOGg2enZoIII94gwGn88F9Pe0XuSSW2JZ1FLkpxkw/LmwJ4SIniUGBMAXYv67qJA543K2yl62COda9OQAFkj+SwPS5/8DEROPA7dN4gtKl72zRbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319928; c=relaxed/simple;
	bh=4HXVmvJJAi7+alimoqiVvNXc6ec3CXY1JNDIKUw8Mp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gJkwIWP+tHLtfiEE/fRB9KuwKxAVJLYyyk8k5a88XI1s6rLmLuIj/BtuUkiwX/bBoUK+op0bqw4tzs5H7DFaznN4fwPoiqq3O7dKMhT187ukkPdMz8+Or0RNdTr+OMFVz2XhTLPXhSIsLYOXf/ybUAQJj9/sEICZmLvRWGumGp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oviC+T9+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17069C43390;
	Sun, 24 Mar 2024 22:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319927;
	bh=4HXVmvJJAi7+alimoqiVvNXc6ec3CXY1JNDIKUw8Mp8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oviC+T9+V44Hr3NMX2CF6YR3B+kK/vNRvI7dIeX2idfzUIPKEk4q3ZNHwDKxPZ2dQ
	 pJujiLnoPisTYssWzVmNLKEtTwsWdK68AFAdO1zE7GgoTqTPjI/TlR7IBwskXkQBgl
	 4f+gxJJBWMt7cWGbFu49EAl737nTGPIyOK5NfRcDZXr52kWxEoDF594CHYLb+U/WYN
	 7uYP2tim1fI188dPT5ZzsSRCNPsXv3dMtsMApEabPPFNkcpSmb0j74/b7OTL1DHMpV
	 VqX1yrI26SLke0nnQ/Q8XYms9jo/ZgAuYasvxWYmpEbxZ11yzteUTQu2SRIZiiUx+s
	 r6+oBOIk1ld9w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	"Sujuan Chen" <sujuan.chen@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 233/715] wifi: mt76: mt7996: fix fw loading timeout
Date: Sun, 24 Mar 2024 18:26:52 -0400
Message-ID: <20240324223455.1342824-234-sashal@kernel.org>
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

From: Lorenzo Bianconi <lorenzo@kernel.org>

[ Upstream commit 030d2e287a902b44ef45e660cf1d73af23fe7d2e ]

Fix the following firmware loading error due to a wrong dma register
configuration if wed is disabled.

[    8.245881] mt7996e_hif 0001:01:00.0: assign IRQ: got 128
[    8.251308] mt7996e_hif 0001:01:00.0: enabling device (0000 -> 0002)
[    8.257674] mt7996e_hif 0001:01:00.0: enabling bus mastering
[    8.263488] mt7996e 0000:01:00.0: assign IRQ: got 126
[    8.268537] mt7996e 0000:01:00.0: enabling device (0000 -> 0002)
[    8.274551] mt7996e 0000:01:00.0: enabling bus mastering
[   28.648773] mt7996e 0000:01:00.0: Message 00000010 (seq 1) timeout
[   28.654959] mt7996e 0000:01:00.0: Failed to get patch semaphore
[   29.661033] mt7996e: probe of 0000:01:00.0 failed with error -11

Suggested-by: "Sujuan Chen" <sujuan.chen@mediatek.com>
Fixes: 4920a3a1285f ("wifi: mt76: mt7996: set DMA mask to 36 bits for boards with more than 4GB of RAM")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/dma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/dma.c b/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
index 483ad81b6eec6..fe37110e66875 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
@@ -237,7 +237,8 @@ void mt7996_dma_start(struct mt7996_dev *dev, bool reset, bool wed_reset)
 				 MT_WFDMA0_GLO_CFG_TX_DMA_EN |
 				 MT_WFDMA0_GLO_CFG_RX_DMA_EN |
 				 MT_WFDMA0_GLO_CFG_OMIT_TX_INFO |
-				 MT_WFDMA0_GLO_CFG_OMIT_RX_INFO_PFET2);
+				 MT_WFDMA0_GLO_CFG_OMIT_RX_INFO_PFET2 |
+				 MT_WFDMA0_GLO_CFG_EXT_EN);
 
 		if (dev->hif2)
 			mt76_set(dev, MT_WFDMA0_GLO_CFG + hif1_ofs,
-- 
2.43.0


