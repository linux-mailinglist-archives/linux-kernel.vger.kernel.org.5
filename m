Return-Path: <linux-kernel+bounces-115183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA473889346
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84F1E296E59
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AF5309B96;
	Mon, 25 Mar 2024 01:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eDU4ByJS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328BC22BC16;
	Sun, 24 Mar 2024 23:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324250; cv=none; b=f1K2tCL23HzsBlF+vWloacF6VGRcgYy0P4VWJL50qXV2D3P1t13M02ScxHHPp+QqzfjJvY/0exUFhF4cK5W1u+L92WlaaYimIA+GBLpoNG7Zp8UPTCHBn/rGtsGH3zOT5kqFy7M0rQugi6pa6Ld+XXWN3FLZqWCgpoihynBF2ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324250; c=relaxed/simple;
	bh=5z5T5U+rc/bIpLonhsBzQWnhc990gxEqPP+rxRuF7gU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RGpbY5H130kWMYQbbxT5N7LP0lKzqbieG3n9Vs4BpCV5z7Pl+0s89GLGGxqan4xWnSgjyt9Zlx3i9j4gflUkXuaaPxaohTD5hFVNhXBGebsdbVbT9+sCLS7KT45L0PfR44oZqGuKrbpNDua6g4Ifl/XOCKkarTjshCeo113Szws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eDU4ByJS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 547C0C433C7;
	Sun, 24 Mar 2024 23:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324250;
	bh=5z5T5U+rc/bIpLonhsBzQWnhc990gxEqPP+rxRuF7gU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eDU4ByJSiaqxFXDA2FMKC2wYiV/tdX4lFedwZexGVYxLcQ4xyDPDKZBX5JegDENup
	 JCz7L6IpQHEimL4dhalte/bF5nAjRLQ7YkduEiQazZNh01tElmBtUxuXfl7YvBUgZJ
	 vtGa2fMeHq/fYxLNR7K2xGU/h+l29NGuC3iL1Lv+LwJs9BgCuXoPHj2a4F+vnO6GFS
	 19jCN28LRKVHXYOiKtdxld1Ht6o2IvZq4X40D4gTP+M4vQ2z0A1lKDg23KE6I5fY8Q
	 9+fO2xD88sJcsjYsYTmyotldW90ouSkJguG8/xtPq+xVjiGgZ4/MgzA3m4l5qmV+gw
	 pXpiewryUBLQA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rahul Rameshbabu <sergeantsagara@protonmail.com>,
	Julian Calaby <julian.calaby@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 031/148] wifi: b43: Stop/wake correct queue in PIO Tx path when QoS is disabled
Date: Sun, 24 Mar 2024 19:48:15 -0400
Message-ID: <20240324235012.1356413-32-sashal@kernel.org>
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

[ Upstream commit 77135a38f6c2f950d2306ac3d37cbb407e6243f2 ]

When QoS is disabled, the queue priority value will not map to the correct
ieee80211 queue since there is only one queue. Stop/wake queue 0 when QoS
is disabled to prevent trying to stop/wake a non-existent queue and failing
to stop/wake the actual queue instantiated.

Fixes: 5100d5ac81b9 ("b43: Add PIO support for PCMCIA devices")
Signed-off-by: Rahul Rameshbabu <sergeantsagara@protonmail.com>
Reviewed-by: Julian Calaby <julian.calaby@gmail.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://msgid.link/20231231050300.122806-3-sergeantsagara@protonmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/broadcom/b43/pio.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/broadcom/b43/pio.c b/drivers/net/wireless/broadcom/b43/pio.c
index a4ff5e2a42b95..b5126edcdc803 100644
--- a/drivers/net/wireless/broadcom/b43/pio.c
+++ b/drivers/net/wireless/broadcom/b43/pio.c
@@ -538,7 +538,7 @@ int b43_pio_tx(struct b43_wldev *dev, struct sk_buff *skb)
 	if (total_len > (q->buffer_size - q->buffer_used)) {
 		/* Not enough memory on the queue. */
 		err = -EBUSY;
-		ieee80211_stop_queue(dev->wl->hw, skb_get_queue_mapping(skb));
+		b43_stop_queue(dev, skb_get_queue_mapping(skb));
 		q->stopped = true;
 		goto out;
 	}
@@ -565,7 +565,7 @@ int b43_pio_tx(struct b43_wldev *dev, struct sk_buff *skb)
 	if (((q->buffer_size - q->buffer_used) < roundup(2 + 2 + 6, 4)) ||
 	    (q->free_packet_slots == 0)) {
 		/* The queue is full. */
-		ieee80211_stop_queue(dev->wl->hw, skb_get_queue_mapping(skb));
+		b43_stop_queue(dev, skb_get_queue_mapping(skb));
 		q->stopped = true;
 	}
 
@@ -600,7 +600,7 @@ void b43_pio_handle_txstatus(struct b43_wldev *dev,
 	list_add(&pack->list, &q->packets_list);
 
 	if (q->stopped) {
-		ieee80211_wake_queue(dev->wl->hw, q->queue_prio);
+		b43_wake_queue(dev, q->queue_prio);
 		q->stopped = false;
 	}
 }
-- 
2.43.0


