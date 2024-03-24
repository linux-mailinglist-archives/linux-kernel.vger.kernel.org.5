Return-Path: <linux-kernel+bounces-115182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBA0889345
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D07C81F27E84
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D0D1C9EDA;
	Mon, 25 Mar 2024 01:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQ+r9d05"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F912922BF;
	Sun, 24 Mar 2024 23:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324248; cv=none; b=l8W0hPD5ZgiO56JkKdk22wV/i6VuON9gSySRO8+hMvM+fcbA6mnoYaM/vaF6ldD7ZD1eUtbJGqEw6V/RbsLXHCJECCYFCZ9EwonWQczBuvNz7Abzv+C92XV9Wh3xye/tW5Tz+Beti5Y1pvOsknQIx3ami/Mn+g0EQwIRZ2P1JAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324248; c=relaxed/simple;
	bh=smshtFHAwlVcTOQX9VhkAJrOCcm3yVbANEIS75plS4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AD/45oBV2GomjwcRK1QgucrSHDDiGhbVQQWl0lVzb7WWdJrTxSl6MdKqv8Yr8N6ULIq+4Y9snov0IDGd55KukyVlqIC/2qe5XXy30CyFxPCTv1IrFrgL+773wb7se2p+L1CzdRMGA3bi4R0s75b7MH5DPlJUSYghsPV8hcQsvaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQ+r9d05; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 500B5C43390;
	Sun, 24 Mar 2024 23:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324247;
	bh=smshtFHAwlVcTOQX9VhkAJrOCcm3yVbANEIS75plS4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DQ+r9d05rrL2NeNrkKsEyy07w5EZBopIRyelaCBTwC7flMe5gIB8FLshuiUjU0FRq
	 99nMCFbJltrTvaL61IDzdj/qI47YX4bk0wjFL4ceQGvALF00pjgjiZN8HBeNeCaK/X
	 Ia09rqPuWUGt/YnzQg7Fz27G2tP7mIo0Hpz0Z0upJlq+v8/VEQY1pB7nnmpp2xdEfD
	 36VcstCSDNnBCWZ3Py9OrauCF+xl8Zu2LURK4CJ1R3EswH01U4uOPRWcAop45WaIUZ
	 N0D8fnOAE5qwhwUjO4sEkW+96ZJUmZFrWEeha8E2JojLKcm0967HpMQVZ1L9GDuFPs
	 sjrHa5Xct9C2Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Saurav Girepunje <saurav.girepunje@gmail.com>,
	Kalle Valo <kvalo@codeaurora.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 029/148] b43: dma: Fix use true/false for bool type variable
Date: Sun, 24 Mar 2024 19:48:13 -0400
Message-ID: <20240324235012.1356413-30-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Saurav Girepunje <saurav.girepunje@gmail.com>

[ Upstream commit a9160bb35ad9ada8428a4d48426f7fc128db40cc ]

use true/false for bool type variables assignment.

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Stable-dep-of: 9636951e4468 ("wifi: b43: Stop/wake correct queue in DMA Tx path when QoS is disabled")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/broadcom/b43/dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/b43/dma.c b/drivers/net/wireless/broadcom/b43/dma.c
index 06139835055fa..cd809d5e46791 100644
--- a/drivers/net/wireless/broadcom/b43/dma.c
+++ b/drivers/net/wireless/broadcom/b43/dma.c
@@ -1462,7 +1462,7 @@ int b43_dma_tx(struct b43_wldev *dev, struct sk_buff *skb)
 		/* This TX ring is full. */
 		unsigned int skb_mapping = skb_get_queue_mapping(skb);
 		ieee80211_stop_queue(dev->wl->hw, skb_mapping);
-		dev->wl->tx_queue_stopped[skb_mapping] = 1;
+		dev->wl->tx_queue_stopped[skb_mapping] = true;
 		ring->stopped = true;
 		if (b43_debug(dev, B43_DBG_DMAVERBOSE)) {
 			b43dbg(dev->wl, "Stopped TX ring %d\n", ring->index);
@@ -1628,7 +1628,7 @@ void b43_dma_handle_txstatus(struct b43_wldev *dev,
 	}
 
 	if (dev->wl->tx_queue_stopped[ring->queue_prio]) {
-		dev->wl->tx_queue_stopped[ring->queue_prio] = 0;
+		dev->wl->tx_queue_stopped[ring->queue_prio] = false;
 	} else {
 		/* If the driver queue is running wake the corresponding
 		 * mac80211 queue. */
-- 
2.43.0


