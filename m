Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D51D7D362A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 14:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbjJWMN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 08:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjJWMNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 08:13:52 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB4DF9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 05:13:50 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1qutoa-00029G-MB; Mon, 23 Oct 2023 14:13:48 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1qutoZ-003ho9-Rt; Mon, 23 Oct 2023 14:13:47 +0200
Received: from sha by dude02.red.stw.pengutronix.de with local (Exim 4.96)
        (envelope-from <sha@pengutronix.de>)
        id 1qutoZ-00HCDW-2Z;
        Mon, 23 Oct 2023 14:13:47 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH] net: Do not break out of sk_stream_wait_memory() with TIF_NOTIFY_SIGNAL
Date:   Mon, 23 Oct 2023 14:13:46 +0200
Message-Id: <20231023121346.4098160-1-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It can happen that a socket sends the remaining data at close() time.
With io_uring and KTLS it can happen that sk_stream_wait_memory() bails
out with -512 (-ERESTARTSYS) because TIF_NOTIFY_SIGNAL is set for the
current task. This flag has been set in io_req_normal_work_add() by
calling task_work_add().

It seems signal_pending() is too broad, so this patch replaces it with
task_sigpending(), thus ignoring the TIF_NOTIFY_SIGNAL flag.

A discussion of this issue can be found at
https://lore.kernel.org/20231010141932.GD3114228@pengutronix.de

Suggested-by: Jens Axboe <axboe@kernel.dk>
Fixes: 12db8b690010c ("entry: Add support for TIF_NOTIFY_SIGNAL")
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

