Return-Path: <linux-kernel+bounces-115184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D70888DA1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77DF71C2A95A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51464309BB5;
	Mon, 25 Mar 2024 01:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jj/aBrbo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5995B292B67;
	Sun, 24 Mar 2024 23:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324251; cv=none; b=hdi60BpbwZJM1V+pS1EwxEOuCbXWU+ZawlZI07tokioJ3nRyZlw5XM0GiFAJoLdqFZN1jDofrocz8m34JN7k90Ixiicn/+VgfQTaSsZTGwQxWAxTNVYUlPakr7hseA/OQme9D+hnoLbyPDUkMLa4o6057U4ieV6fqhOa9cYqSt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324251; c=relaxed/simple;
	bh=EhBvnKGSZLniY1L5nfRKi85l59tR4Iws3UV+tHLHoqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=naCxsJRUndb2gC9QtBzilWlpv/tXiyIjB+P8HB83M9VO0Lo4uJi25YyyMoUM704Z/LAChCPoqrLVWyBPiZp8JVn8KcDLkew8ltMcktUeKKSXu5SFKki1oC63eLxWVAXz3K6zeAEhXrwv/YZlYHNU+wMsHdLgeW39Ml76tLeVSJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jj/aBrbo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 584D2C43394;
	Sun, 24 Mar 2024 23:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324251;
	bh=EhBvnKGSZLniY1L5nfRKi85l59tR4Iws3UV+tHLHoqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jj/aBrboeiTw8PmEiDxwc13yysHoR4wQ2YF8ESYD/4KoLUsAh/8Kzu7WK7sCwJfT8
	 /P4tcICIMGCPwC9wDA9+M8DhNJc0yVejVdyRUo0/pJC84oBI1PF4VDhWdOsQZQe6ZG
	 GQNf28UEe60NsewKCTgiU0qAcOz3HFcregIOd9TJgb53XsZA27x5DVXwBtulqSQIId
	 L1tPa9cvQBoDdSDntenB4ETBccZdEbBi2J9mDYR57bFWpw6fDBr8CN/f/RcaGXasJX
	 0RqeE+FfQL9zdkNndk/9KSygBqDKUCmah+a97AAtKBa7pFoYFaXMRdFr5txdWZM4Oz
	 O7kohuxxjiPRg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Saurav Girepunje <saurav.girepunje@gmail.com>,
	Kalle Valo <kvalo@codeaurora.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 032/148] b43: main: Fix use true/false for bool type
Date: Sun, 24 Mar 2024 19:48:16 -0400
Message-ID: <20240324235012.1356413-33-sashal@kernel.org>
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
index 8a226a9d755e2..9a3563de60a77 100644
--- a/drivers/net/wireless/broadcom/b43/main.c
+++ b/drivers/net/wireless/broadcom/b43/main.c
@@ -3625,7 +3625,7 @@ static void b43_tx_work(struct work_struct *work)
 			else
 				err = b43_dma_tx(dev, skb);
 			if (err == -ENOSPC) {
-				wl->tx_queue_stopped[queue_num] = 1;
+				wl->tx_queue_stopped[queue_num] = true;
 				ieee80211_stop_queue(wl->hw, queue_num);
 				skb_queue_head(&wl->tx_queue[queue_num], skb);
 				break;
@@ -3636,7 +3636,7 @@ static void b43_tx_work(struct work_struct *work)
 		}
 
 		if (!err)
-			wl->tx_queue_stopped[queue_num] = 0;
+			wl->tx_queue_stopped[queue_num] = false;
 	}
 
 #if B43_DEBUG
@@ -5630,7 +5630,7 @@ static struct b43_wl *b43_wireless_init(struct b43_bus_dev *dev)
 	/* Initialize queues and flags. */
 	for (queue_num = 0; queue_num < B43_QOS_QUEUE_NUM; queue_num++) {
 		skb_queue_head_init(&wl->tx_queue[queue_num]);
-		wl->tx_queue_stopped[queue_num] = 0;
+		wl->tx_queue_stopped[queue_num] = false;
 	}
 
 	snprintf(chip_name, ARRAY_SIZE(chip_name),
-- 
2.43.0


