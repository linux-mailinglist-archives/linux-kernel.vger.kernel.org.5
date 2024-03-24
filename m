Return-Path: <linux-kernel+bounces-115185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF657888DA2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BB6B1C2A198
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F131C8822;
	Mon, 25 Mar 2024 01:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t16ssajP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A33C292B6E;
	Sun, 24 Mar 2024 23:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324252; cv=none; b=puNyzbLzU+c8xcw+/oyHshDhyZKQimCvf9HknqSdO1KlieGXJ/jFIQAara/ei+i6QHYuYl5gLeu+GeBOOyyzbMqC3WlKVB6LClFSNi/CfYOlpgGDwZMZC376lYel3COIXKyaNszVcAW2zwQYh1c1uOvwVaT+u8gtrvXYStMundo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324252; c=relaxed/simple;
	bh=3ZuJ+pXQ/AnszgvSm+zgL7hh1Uz2YSr6DW2ZNTAK8NY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k9TfpNBJ2fwMz3nkEgAtd5a660D2gwyV2cl4OKYkKkssmGSEbF/Hk/N3xKTeYG9c9gVaPFMTqRnLoYgj2d/ulEPHsvXSlgW9jw8mICsESY8W9qipaV+9NqT6Fvyg2Jk2DNtXuEan4QUGWW3Ppvk2Zjlc/N835+y7nUcBm3PSoAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t16ssajP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40506C433C7;
	Sun, 24 Mar 2024 23:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324252;
	bh=3ZuJ+pXQ/AnszgvSm+zgL7hh1Uz2YSr6DW2ZNTAK8NY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t16ssajPakozxFrgqwPeksp0KmFiTDX1aSOO1HoTTklfkHqGKD7X9p+h3Q0NIhXux
	 NLcuRclQt5lLDI2+t9EBbYOdgvj/KEkEFTr8YGE5uqkf/ef6vpwD1pdSYgSSJ9cE+W
	 dls2Y5U4lYYhJUrZhYrs0qjSm+46TyWn1P7GG/XVqD6XlwDjfok2BKc7qUgP5k3rhg
	 Qf2Op0eP0qjIj+6KA/1AB2zgDmisR8xsQPd/PsIA29h/gOTwtTfzOX6jZrpJZeoR00
	 m24J5NtuX+FWJRBoDiaP0O2XyGuLy/KBxHPk4fX/b+KP0qC7x1nA0Wpnnagm9ZoF/e
	 6rRbphtbyRx8Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rahul Rameshbabu <sergeantsagara@protonmail.com>,
	Julian Calaby <julian.calaby@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 033/148] wifi: b43: Stop correct queue in DMA worker when QoS is disabled
Date: Sun, 24 Mar 2024 19:48:17 -0400
Message-ID: <20240324235012.1356413-34-sashal@kernel.org>
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

From: Rahul Rameshbabu <sergeantsagara@protonmail.com>

[ Upstream commit 581c8967d66c4961076dbbee356834e9c6777184 ]

When QoS is disabled, the queue priority value will not map to the correct
ieee80211 queue since there is only one queue. Stop queue 0 when QoS is
disabled to prevent trying to stop a non-existent queue and failing to stop
the actual queue instantiated.

Fixes: bad691946966 ("b43: avoid packet losses in the dma worker code.")
Signed-off-by: Rahul Rameshbabu <sergeantsagara@protonmail.com>
Reviewed-by: Julian Calaby <julian.calaby@gmail.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://msgid.link/20231231050300.122806-4-sergeantsagara@protonmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/broadcom/b43/main.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/broadcom/b43/main.c b/drivers/net/wireless/broadcom/b43/main.c
index 9a3563de60a77..8d50ebdbeb1e5 100644
--- a/drivers/net/wireless/broadcom/b43/main.c
+++ b/drivers/net/wireless/broadcom/b43/main.c
@@ -3626,7 +3626,7 @@ static void b43_tx_work(struct work_struct *work)
 				err = b43_dma_tx(dev, skb);
 			if (err == -ENOSPC) {
 				wl->tx_queue_stopped[queue_num] = true;
-				ieee80211_stop_queue(wl->hw, queue_num);
+				b43_stop_queue(dev, queue_num);
 				skb_queue_head(&wl->tx_queue[queue_num], skb);
 				break;
 			}
@@ -3650,6 +3650,7 @@ static void b43_op_tx(struct ieee80211_hw *hw,
 		      struct sk_buff *skb)
 {
 	struct b43_wl *wl = hw_to_b43_wl(hw);
+	u16 skb_queue_mapping;
 
 	if (unlikely(skb->len < 2 + 2 + 6)) {
 		/* Too short, this can't be a valid frame. */
@@ -3658,12 +3659,12 @@ static void b43_op_tx(struct ieee80211_hw *hw,
 	}
 	B43_WARN_ON(skb_shinfo(skb)->nr_frags);
 
-	skb_queue_tail(&wl->tx_queue[skb->queue_mapping], skb);
-	if (!wl->tx_queue_stopped[skb->queue_mapping]) {
+	skb_queue_mapping = skb_get_queue_mapping(skb);
+	skb_queue_tail(&wl->tx_queue[skb_queue_mapping], skb);
+	if (!wl->tx_queue_stopped[skb_queue_mapping])
 		ieee80211_queue_work(wl->hw, &wl->tx_work);
-	} else {
-		ieee80211_stop_queue(wl->hw, skb->queue_mapping);
-	}
+	else
+		b43_stop_queue(wl->current_dev, skb_queue_mapping);
 }
 
 static void b43_qos_params_upload(struct b43_wldev *dev,
-- 
2.43.0


