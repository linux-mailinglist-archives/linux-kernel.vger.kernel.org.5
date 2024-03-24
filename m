Return-Path: <linux-kernel+bounces-114954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 282788892C0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D775E29EA44
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEA82DC9DD;
	Mon, 25 Mar 2024 00:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMErRSM5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798D221F9EE;
	Sun, 24 Mar 2024 23:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323669; cv=none; b=XVqOdc8G6t6q7axV6+aO5GFF0co/jr8+ATHjYUXoaJqJ8AvC02k6UIBU17CrbfSg4Sil5v9FR2nExb3pBAbL1y/DrprFIPIKXCEiPH80RiWUDkYS/tF9kLNTVhiCHZfyupz8q0tVlXwr8MboW0/MfPibYtlnZMgHm/HN7iwub08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323669; c=relaxed/simple;
	bh=KJVDxpizcfGR7aOIB8U3FFHOvETVfc+6GQRhnboy+Eo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mv3ttl7L49vo7OgL5LzsBw49EDY+YoUDhnk++ck4wkW/6nVNJlhNIJqHDI5RjpUR9qEPDUsr93R9r5dB6RTCYMwJEJkSlOv1gsUFGz7Qo/YRrDncs9BQJtxx+kB7+h+HGmpTq+Xxm5O5UstpHaL9MdPU4emjEqK/De4SLb5q1nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMErRSM5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EB82C433F1;
	Sun, 24 Mar 2024 23:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323669;
	bh=KJVDxpizcfGR7aOIB8U3FFHOvETVfc+6GQRhnboy+Eo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NMErRSM5Ne9OuuMOf0pP8NDOWFH1b/fxq8uH8A30voQxFCvHjIK3q31rOPnH+kDgI
	 W+XXBVHthh46rwXCF9AvQ3szR2FL4LRrYG+Q3cNkcdkds/1+KbMDX5H7ee1tLzHwx7
	 RvUeHhSaBPTqdPxqpeYyhsGR0G9QPQ08Za4PsWuUQz5+BQp0JldXDY5VSYbhvYZNK/
	 N4zRtlWZqioCTN8GMr7uHbfDtc0MOVnSdSozdhQ+SESnEOFUm7FrkcfaQq+Pn+nKwZ
	 xM/Z8s1hB8PuqLwvpIGtjWk/sDfflAE/9BCJqi8sYy6dKrJjyb1rVsNSNTfMNJuXVU
	 5Wgl2IHlxH1Sg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rahul Rameshbabu <sergeantsagara@protonmail.com>,
	Julian Calaby <julian.calaby@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 041/238] wifi: b43: Stop/wake correct queue in PIO Tx path when QoS is disabled
Date: Sun, 24 Mar 2024 19:37:09 -0400
Message-ID: <20240324234027.1354210-42-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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
index 8c28a9250cd19..cc19b589fa70d 100644
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


