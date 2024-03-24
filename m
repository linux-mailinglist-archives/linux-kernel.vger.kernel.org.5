Return-Path: <linux-kernel+bounces-115848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BCB889840
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5206529D188
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD64D37C93B;
	Mon, 25 Mar 2024 03:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="crcVQpjY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3F4145B15;
	Sun, 24 Mar 2024 23:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322014; cv=none; b=kjV8/+MIaW1HgLJSGYFhi7zCElSTKoTlHkYsGjrExzmleyqOk7wa2R2tKwj25D+rUsp+dEzCwfPQNXmHQJ6wLPjPKuwuMrhXxf0DLqyW8QaEJtUvajiYVrDVnydYGeAiLb58bCJRmaHf0I620bGBhVzGCwiDv7UjnIzuQYORVzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322014; c=relaxed/simple;
	bh=JormID0mpDAoMktOmH3B7X1mZ+zkwgsuNBGDq22flRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hcw089HhE/WTBDci73CFFPEZO/Ut7G1WCw6KuWuHRIesQDTVLwDqc9TtFGTFij96t0WyVUFjgUPXHMKtqeex1Nc7kK23raXX8PofaO/1c1kgOYyYOs5Un8xG5xKJvSl631gdyn2YH2tOZr7csesIXamgslhITDjemd+j67bIn0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=crcVQpjY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEA0DC43394;
	Sun, 24 Mar 2024 23:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322014;
	bh=JormID0mpDAoMktOmH3B7X1mZ+zkwgsuNBGDq22flRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=crcVQpjY10H6qXFoqL3nCt6nbAeg/KHKzTmVDnT4gqLFJ/WDwn1DJ0Q+AXN6HC4KB
	 +Bxr5xbeJlBzaA4jWr9IPtThfxImWUji+YySsASMISWEHRFLeX/pxPFYlG7owCt+jS
	 n0UWBoVC9jWgMqKgPoqxWnZOt15JXjJh5/ogAcUiyDgiZ3V7+T32jmqCaSuIXwwftW
	 i8Wfstm8XusuV+p77BLAfCckq9wB+8yZiFM6XlCefGW4mJnSM9/zsWMdeN2Wf89R2p
	 yCS0aCslJmc1tQCCAPAYA5rReiPMTlpqlIVSnMvDVFu2QT20YkTi5DMLi4ZBS0D52V
	 vvYNSxY5VOaLA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rahul Rameshbabu <sergeantsagara@protonmail.com>,
	Julian Calaby <julian.calaby@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 086/451] wifi: b43: Stop correct queue in DMA worker when QoS is disabled
Date: Sun, 24 Mar 2024 19:06:02 -0400
Message-ID: <20240324231207.1351418-87-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index b2539a916fd04..c75f294ca1bc9 100644
--- a/drivers/net/wireless/broadcom/b43/main.c
+++ b/drivers/net/wireless/broadcom/b43/main.c
@@ -3603,7 +3603,7 @@ static void b43_tx_work(struct work_struct *work)
 				err = b43_dma_tx(dev, skb);
 			if (err == -ENOSPC) {
 				wl->tx_queue_stopped[queue_num] = true;
-				ieee80211_stop_queue(wl->hw, queue_num);
+				b43_stop_queue(dev, queue_num);
 				skb_queue_head(&wl->tx_queue[queue_num], skb);
 				break;
 			}
@@ -3627,6 +3627,7 @@ static void b43_op_tx(struct ieee80211_hw *hw,
 		      struct sk_buff *skb)
 {
 	struct b43_wl *wl = hw_to_b43_wl(hw);
+	u16 skb_queue_mapping;
 
 	if (unlikely(skb->len < 2 + 2 + 6)) {
 		/* Too short, this can't be a valid frame. */
@@ -3635,12 +3636,12 @@ static void b43_op_tx(struct ieee80211_hw *hw,
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


