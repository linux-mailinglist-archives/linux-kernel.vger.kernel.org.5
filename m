Return-Path: <linux-kernel+bounces-115058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C08A9888CCD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61E6B1F29775
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39995287053;
	Mon, 25 Mar 2024 01:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kp1e62m/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE9B2888F3;
	Sun, 24 Mar 2024 23:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324029; cv=none; b=FEnLcbJop0laGC3uy1b63XJpp9TYM1wv/SIxZIpGN7311zvqkaBkPFPSU4uFAd/jwn12rn5KrvFNxmK0BHx/38l19zBihWFyZhl+Pcaj+qbp+hdst+qPB9v9YJJh4bzl63rsFh/mOHm/YC4LQEp3PziLqPT23vKDXQQsVhZlKCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324029; c=relaxed/simple;
	bh=IJFSgVV4XeProZS7rGdXSMesbyiCReEtdh/vQSyQjDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T2zSpHLDwjkijpFYdOQcOXJkBZ6ARziDJOk+Cpg2Vfg/kcwI3wL7p0wL3hZBQmyjgU2qZ/5YN7Sayj821Cb42R1R6uNpw/UYmOGTAGa8ngmAkEMA8DT9FpB4ZZwFEtf5MyCN9SkOItdX7i79WDAQC9LXKrWajvppyYJpRlpwee4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kp1e62m/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF479C43394;
	Sun, 24 Mar 2024 23:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324029;
	bh=IJFSgVV4XeProZS7rGdXSMesbyiCReEtdh/vQSyQjDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kp1e62m/RLhtiFv8ExUTccK10jxcqROb3lKQFVapZ0YJRxrDmJD/sxc1rcs+YhgpP
	 UQGWr/sh/NwabsKeNpdo9UfwmK1kYsCoGa/7fIpXzh3V3N4E397d8Sn4Iz+NurSGZy
	 43wIOkOALSboncF6iSJBNt8A2Pk/gU5QeQmrFWLvymJ+6i6+eqSFg+fVFgfu/fYZS0
	 zdeU+GiuTsF6VsjeJLKtr64qEX2QPi+Jg+hmj4WtkvUoFC2XoIzBv5zampKw9m5/J8
	 N0NeaWA73U5Bb14HxB/aSCeoqd64MxIeUIeFfbK07X/nVGz/80mWwk01+/5bTA3kov
	 sXdtf1I2ick1g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Saurav Girepunje <saurav.girepunje@gmail.com>,
	Kalle Valo <kvalo@codeaurora.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 030/183] b43: dma: Fix use true/false for bool type variable
Date: Sun, 24 Mar 2024 19:44:03 -0400
Message-ID: <20240324234638.1355609-31-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
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
index 72bf07540da39..ca671fc13116f 100644
--- a/drivers/net/wireless/broadcom/b43/dma.c
+++ b/drivers/net/wireless/broadcom/b43/dma.c
@@ -1400,7 +1400,7 @@ int b43_dma_tx(struct b43_wldev *dev, struct sk_buff *skb)
 		/* This TX ring is full. */
 		unsigned int skb_mapping = skb_get_queue_mapping(skb);
 		ieee80211_stop_queue(dev->wl->hw, skb_mapping);
-		dev->wl->tx_queue_stopped[skb_mapping] = 1;
+		dev->wl->tx_queue_stopped[skb_mapping] = true;
 		ring->stopped = true;
 		if (b43_debug(dev, B43_DBG_DMAVERBOSE)) {
 			b43dbg(dev->wl, "Stopped TX ring %d\n", ring->index);
@@ -1566,7 +1566,7 @@ void b43_dma_handle_txstatus(struct b43_wldev *dev,
 	}
 
 	if (dev->wl->tx_queue_stopped[ring->queue_prio]) {
-		dev->wl->tx_queue_stopped[ring->queue_prio] = 0;
+		dev->wl->tx_queue_stopped[ring->queue_prio] = false;
 	} else {
 		/* If the driver queue is running wake the corresponding
 		 * mac80211 queue. */
-- 
2.43.0


