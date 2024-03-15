Return-Path: <linux-kernel+bounces-104240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6A287CB11
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B07301C20909
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1615718E06;
	Fri, 15 Mar 2024 10:02:11 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675DA18B04
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 10:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710496930; cv=none; b=A3sQzA5gTRKUUgHRRLwz0II96PUVItfJ0FgbT934vgIKkL+ly8EYr8nbQlx7WXzECZUtOHMEyzbjSXitgcS/sJJf4c23qXYyv7//vPq+EGUKr5iutIKm1Rde9B+Hu7D5ji0qdkabGu815+LIJ4XONEi/mARQPY+gW876KHng3+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710496930; c=relaxed/simple;
	bh=svVdf8i4uzpl1k5sx6TWTgbPeE2Du1GRD2jg8IdsSlA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OkKElEpOKT5v2TPkk/MD50/QJHJupeu3laL5QZzLuezz0daBw5LkRGEOl5DQS9V9L0EBZGWQiGJe0zjkFSmfmqd037OaBI58Hbjg1u9wUhbWYsnYeVYx1UTZtKGV/Gc17NijOw68A5EUN6jxbd3lRoZx5fW/3zc+txlACwkP8T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1rl4O0-0005Zj-Mq; Fri, 15 Mar 2024 11:02:00 +0100
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1rl4O0-006Tj8-47; Fri, 15 Mar 2024 11:02:00 +0100
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1rl4O0-00GMJ8-03;
	Fri, 15 Mar 2024 11:02:00 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
To: netdev@vger.kernel.org
Cc: kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	io-uring@vger.kernel.org,
	Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH] net: Do not break out of sk_stream_wait_memory() with TIF_NOTIFY_SIGNAL
Date: Fri, 15 Mar 2024 11:01:59 +0100
Message-Id: <20240315100159.3898944-1-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

It can happen that a socket sends the remaining data at close() time.
With io_uring and KTLS it can happen that sk_stream_wait_memory() bails
out with -512 (-ERESTARTSYS) because TIF_NOTIFY_SIGNAL is set for the
current task. This flag has been set in io_req_normal_work_add() by
calling task_work_add().

This patch replaces signal_pending() with task_sigpending(), thus ignoring
the TIF_NOTIFY_SIGNAL flag.

A discussion of this issue can be found at
https://lore.kernel.org/20231010141932.GD3114228@pengutronix.de

Suggested-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 net/core/stream.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/core/stream.c b/net/core/stream.c
index 96fbcb9bbb30a..e9e17b48e0122 100644
--- a/net/core/stream.c
+++ b/net/core/stream.c
@@ -67,7 +67,7 @@ int sk_stream_wait_connect(struct sock *sk, long *timeo_p)
 			return -EPIPE;
 		if (!*timeo_p)
 			return -EAGAIN;
-		if (signal_pending(tsk))
+		if (task_sigpending(tsk))
 			return sock_intr_errno(*timeo_p);
 
 		add_wait_queue(sk_sleep(sk), &wait);
@@ -103,7 +103,7 @@ void sk_stream_wait_close(struct sock *sk, long timeout)
 		do {
 			if (sk_wait_event(sk, &timeout, !sk_stream_closing(sk), &wait))
 				break;
-		} while (!signal_pending(current) && timeout);
+		} while (!task_sigpending(current) && timeout);
 
 		remove_wait_queue(sk_sleep(sk), &wait);
 	}
@@ -134,7 +134,7 @@ int sk_stream_wait_memory(struct sock *sk, long *timeo_p)
 			goto do_error;
 		if (!*timeo_p)
 			goto do_eagain;
-		if (signal_pending(current))
+		if (task_sigpending(current))
 			goto do_interrupted;
 		sk_clear_bit(SOCKWQ_ASYNC_NOSPACE, sk);
 		if (sk_stream_memory_free(sk) && !vm_wait)
-- 
2.39.2


