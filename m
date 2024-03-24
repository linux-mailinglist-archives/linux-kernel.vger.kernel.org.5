Return-Path: <linux-kernel+bounces-113648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA0F8885D8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55F4F28C6F7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483D01DA149;
	Sun, 24 Mar 2024 22:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t1HB7jlP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3891D5F97;
	Sun, 24 Mar 2024 22:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320574; cv=none; b=EGzk6+H1VUKbZ4vg0dOJ9Aap34QH8JwXiSuRpzqhZsGbApQVEdPDMX6PewdvtfCUntmKLF5sgU8RBvo5B+km/w1b+p6y5eb/Z+5lI1EwjmSwoMy1ElxV0QdslLY6/7P9Qpmd1uIwz0NjCQGeD03hvq8Q8jhd6VBmnXY/zpL1sd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320574; c=relaxed/simple;
	bh=5WtQM2tX+LYOhsFO7UKkhfKkpfG6hezjSSD2zr4H3Qo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mr917uXp9V4HnxQFI/PiXkVI4LAJuTG+R7Y0xns7BKg5cXDD+Btq7w9W/ql+zQzuTYVrx3wxOwpzLFtGqkquH78d9aTL3PFLKexnTrFogpfYKQujqvFLV8yJugZcKMnQsiroPhUT4NknrOToD4v2Vdm+KD71Ok+k7kq5v6xAuME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t1HB7jlP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1A78C43394;
	Sun, 24 Mar 2024 22:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320572;
	bh=5WtQM2tX+LYOhsFO7UKkhfKkpfG6hezjSSD2zr4H3Qo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t1HB7jlPsbKBZMyHM4GtGdBOEIQxGx6n6rLMu/iynKuFJwyffeJembVfsp4eifgI0
	 m7ipX+fkSeFIp5eO8LeCkxA3PUv4GwlJ4YTaaKjc9zNKREF5Bp0oHA2vzQ5G0Hvy3a
	 SqxHL4fvcB63cnnwg3yE03Sacz6n+/WMpBr6q0v0Gcb5rgIBctqRtTcYMPNB9CmQwQ
	 20ZVLOfF1ofIAtsWRi9eBJY5zoglQUHgbGe3a3ZNCylNoQWv2W503zRJYGY7mRmeFy
	 UrRcLEKdPXFJnNy4RT021hh/IDhZSXweI01iWeQOJ6JyzCPRb3iBvgOBLqScvjnEUv
	 +mlSJ6HI1dV1g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rahul Rameshbabu <sergeantsagara@protonmail.com>,
	Julian Calaby <julian.calaby@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 133/713] wifi: b43: Stop/wake correct queue in PIO Tx path when QoS is disabled
Date: Sun, 24 Mar 2024 18:37:39 -0400
Message-ID: <20240324224720.1345309-134-sashal@kernel.org>
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
index 0cf70fdb60a6a..e41f2f5b4c266 100644
--- a/drivers/net/wireless/broadcom/b43/pio.c
+++ b/drivers/net/wireless/broadcom/b43/pio.c
@@ -525,7 +525,7 @@ int b43_pio_tx(struct b43_wldev *dev, struct sk_buff *skb)
 	if (total_len > (q->buffer_size - q->buffer_used)) {
 		/* Not enough memory on the queue. */
 		err = -EBUSY;
-		ieee80211_stop_queue(dev->wl->hw, skb_get_queue_mapping(skb));
+		b43_stop_queue(dev, skb_get_queue_mapping(skb));
 		q->stopped = true;
 		goto out;
 	}
@@ -552,7 +552,7 @@ int b43_pio_tx(struct b43_wldev *dev, struct sk_buff *skb)
 	if (((q->buffer_size - q->buffer_used) < roundup(2 + 2 + 6, 4)) ||
 	    (q->free_packet_slots == 0)) {
 		/* The queue is full. */
-		ieee80211_stop_queue(dev->wl->hw, skb_get_queue_mapping(skb));
+		b43_stop_queue(dev, skb_get_queue_mapping(skb));
 		q->stopped = true;
 	}
 
@@ -587,7 +587,7 @@ void b43_pio_handle_txstatus(struct b43_wldev *dev,
 	list_add(&pack->list, &q->packets_list);
 
 	if (q->stopped) {
-		ieee80211_wake_queue(dev->wl->hw, q->queue_prio);
+		b43_wake_queue(dev, q->queue_prio);
 		q->stopped = false;
 	}
 }
-- 
2.43.0


