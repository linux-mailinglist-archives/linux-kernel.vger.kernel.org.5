Return-Path: <linux-kernel+bounces-115055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50257889447
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88E49B2DBDC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EC413E3F3;
	Mon, 25 Mar 2024 01:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OhVzIajT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677D9288917;
	Sun, 24 Mar 2024 23:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324033; cv=none; b=T/dYX6sm2dBNvmGhFqqv7AtFDACpArmwYFKB1uT+RWZYn060LoVbPtFv6hEjFdO919X/JpmGwfkLgLHQhw1kyZpep6q04/HPj2InrgY/rbTAm2Lhq9r5q+Xeq/o9QuCgyeDft1S+eBs8gV77Y586ohPhklqnxMK4bSWsb7w5A/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324033; c=relaxed/simple;
	bh=1DPcpeBDnF2xH8ZQfHSXct1kQm/M4ZIPnjfT2U2xWzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DK+IoucNyX1OSaAC+LljtWc6JaJMHYLzm4hs+uoqxp1zer9ea5NqD0nhAKqxDDLkjzjXCoj+WiSBFyhccLsNhwfKAcYn+uxAyrlWr1OzCIOTrGBokvmFKy/lr7GGcm8X4oXsREMfW/xbfSdbqGq0LkagdsorbctjO4CH/jr7VQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OhVzIajT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A47F9C43394;
	Sun, 24 Mar 2024 23:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324032;
	bh=1DPcpeBDnF2xH8ZQfHSXct1kQm/M4ZIPnjfT2U2xWzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OhVzIajT+tK6k/lrs3Xu69FFBLd49nRLp9ND6C7M6WnEzcNjBDfA8ZL/TUW77rcfS
	 vvFjNhz2CwoahQRmyvenRP4eCAzLg5DGGSwvduHjTApUEV5F3ULSy3SvesHkQP6HLq
	 eBHYlweYuJChBPLI5MMlJcLW1Lcl4qKb+R7heXDT50lOyEDEW6f4OEwSnU+9ppykOz
	 CBbbZ9EZgijLfF8TBWt3DctIfqH2Cn9opadaKclD8dlBaAvxCuWprlnZB/h4+sYWol
	 Ivyr+4XtVmljRtgzWf0+ggiKh+pOKTk+it6j4c90wTyXtPJPj9og/jUj0gT5ct20Ej
	 664HdCBa6xRDA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Saurav Girepunje <saurav.girepunje@gmail.com>,
	Kalle Valo <kvalo@codeaurora.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 033/183] b43: main: Fix use true/false for bool type
Date: Sun, 24 Mar 2024 19:44:06 -0400
Message-ID: <20240324234638.1355609-34-sashal@kernel.org>
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

[ Upstream commit 6db774c1725059f98e4fce97f878688248584be5 ]

use true/false on bool type variable assignment.

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Stable-dep-of: 581c8967d66c ("wifi: b43: Stop correct queue in DMA worker when QoS is disabled")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/broadcom/b43/main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/broadcom/b43/main.c b/drivers/net/wireless/broadcom/b43/main.c
index 3432dfe1ddb47..3ad94dad2d89b 100644
--- a/drivers/net/wireless/broadcom/b43/main.c
+++ b/drivers/net/wireless/broadcom/b43/main.c
@@ -3600,7 +3600,7 @@ static void b43_tx_work(struct work_struct *work)
 			else
 				err = b43_dma_tx(dev, skb);
 			if (err == -ENOSPC) {
-				wl->tx_queue_stopped[queue_num] = 1;
+				wl->tx_queue_stopped[queue_num] = true;
 				ieee80211_stop_queue(wl->hw, queue_num);
 				skb_queue_head(&wl->tx_queue[queue_num], skb);
 				break;
@@ -3611,7 +3611,7 @@ static void b43_tx_work(struct work_struct *work)
 		}
 
 		if (!err)
-			wl->tx_queue_stopped[queue_num] = 0;
+			wl->tx_queue_stopped[queue_num] = false;
 	}
 
 #if B43_DEBUG
@@ -5603,7 +5603,7 @@ static struct b43_wl *b43_wireless_init(struct b43_bus_dev *dev)
 	/* Initialize queues and flags. */
 	for (queue_num = 0; queue_num < B43_QOS_QUEUE_NUM; queue_num++) {
 		skb_queue_head_init(&wl->tx_queue[queue_num]);
-		wl->tx_queue_stopped[queue_num] = 0;
+		wl->tx_queue_stopped[queue_num] = false;
 	}
 
 	snprintf(chip_name, ARRAY_SIZE(chip_name),
-- 
2.43.0


