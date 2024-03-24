Return-Path: <linux-kernel+bounces-114097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECE3888863
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A80C28A44E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E57915F3EE;
	Sun, 24 Mar 2024 23:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LnNDgdjk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70FF200A3C;
	Sun, 24 Mar 2024 23:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321392; cv=none; b=M8cDIA2VDJoZjhLgHL8S9o4XabPrGMwQb3q7G8u+nIdfvskK5rhDux2nkVLzFUAOG+4H0dmf6BX3SJv3Iib9yrgvwceZaJZTuDquhGoXr2hwEtuHFgpmip4JtgwJhFsG3qUa2mdbQlLc008x8pGV0cza883RslERuZGJJ+MCip4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321392; c=relaxed/simple;
	bh=KJVDxpizcfGR7aOIB8U3FFHOvETVfc+6GQRhnboy+Eo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PIPLLeFndB5/OISPlIHMsgCecbO3FbkdkFdBUz3wee77hpVXqMqa0Y6MCSsxkcd0vi2E0/QM2HcZkX5Y3oKmou7JS2y+dTMHC+pwP9pKQ9jEyPoDbpcuxU2f2S9kC2thkXYKK8OdVj9Bgs44Qm6cukuKTrBOl1u68fMr1OWgxX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LnNDgdjk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B7C8C433C7;
	Sun, 24 Mar 2024 23:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321391;
	bh=KJVDxpizcfGR7aOIB8U3FFHOvETVfc+6GQRhnboy+Eo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LnNDgdjkvHHhuODKJwxEo9Riu9qnwA1BolLKRllrGVy/f675kXfZVh4V7V/RfhIJt
	 Sqpd9DjlblIGLW08EdrIu2/Ff67aoCvW3EFon2rg8HiInM4W8Z0n1gRUVEbs+E27BL
	 fpGsSgGFqTR9B4T1I+ES8cswPqCVwMf4/Rg29aNwM6Pq7TcEpk+69JqFK1F20WdzKY
	 3/RZIexg21r7FvITDdhHhZ8bDXvjdQV1XvW5MCBBF8DLsmDHBRjGdRWxDAnXuR7RZW
	 bxwGSfztX9CWbfYpRlM1fLVR/5ojbBfV9aBsTboZw2I+iPaU1uZkWM8vaTcyuR35Pm
	 Jq+HFttoue4Cw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rahul Rameshbabu <sergeantsagara@protonmail.com>,
	Julian Calaby <julian.calaby@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 115/638] wifi: b43: Stop/wake correct queue in PIO Tx path when QoS is disabled
Date: Sun, 24 Mar 2024 18:52:32 -0400
Message-ID: <20240324230116.1348576-116-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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


