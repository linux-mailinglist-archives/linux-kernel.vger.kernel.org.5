Return-Path: <linux-kernel+bounces-137994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C9F89EAED
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34C34B21275
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D65D515;
	Wed, 10 Apr 2024 06:34:17 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6748820300
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 06:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712730856; cv=none; b=qPlLOB2JsBCOB5+nfLdfHDG6+07diYlh42Qq8pDs6tJLZpDyXBq/4cPFgtzqOXVq3lSo9RUZFVXqFMOY3w5GJX4UxJoQrAB5Qv10t6rGKQ1U5lcDMWMwGvRZvPipJ6+d2epBcQmgtCqeQOjX/MCrGvs6CrZwBzvgtoPNuTuMWGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712730856; c=relaxed/simple;
	bh=L8qUFpUH7Renm5tiH9WqQL0bEhl/mJAzS7iP1fS8R1U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SuaIKXOp7yPo7dU3xGdQY1x8MX6czzk/q9xgJM7GvnY2piqd0+Yokrug5Najg2pH+xKSbN7TDV1uStpm+2Nv6fj5oinYj9od/765HcfGOsKUNjXYjJEOGo4CKgIbzYWgDA7pLZZ1++o89nhdzYsuv4oke5jGr3gv8CfPTWL/6iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1ruRX0-0001d0-MD; Wed, 10 Apr 2024 08:34:02 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1ruRWy-00BRRq-U5; Wed, 10 Apr 2024 08:34:00 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1ruRWy-0057ls-2k;
	Wed, 10 Apr 2024 08:34:00 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Wed, 10 Apr 2024 08:33:07 +0200
Subject: [PATCH] tls: defer close to kernel task
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240410-ktls-defer-close-v1-1-b59e6626b8e4@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAKIyFmYC/x3MwQpAQBCA4VfRnE2NtRSvIgfWLBOhHUlp393m+
 B3+/wXlIKzQZi8EvkXl2BOKPAO3DPvMKFMyGDKWbEG4XpvixJ4Duu1QRiLTlLaq7UgNpOwM7OX
 5l10f4wdE1IL9YgAAAA==
To: Boris Pismenny <borisp@nvidia.com>, 
 John Fastabend <john.fastabend@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Pavel Begunkov <asml.silence@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712730840; l=3347;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=L8qUFpUH7Renm5tiH9WqQL0bEhl/mJAzS7iP1fS8R1U=;
 b=ZWLnNgSyiZsCAzmR7gR76h5X3Eps1/swO+Yn89chwI9IWznsIqLFQWRoWpJdGL+f3VBXgiTT7
 Jiq7fXS28WAALdd6n/HyKZbwulGDbeoLWiE3Hpq0R45tvv2Rk3niDcl
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

proto->close is normally called from a userspace task which can be
interrupted by signals. When asynchronous encryption is used then KTLS
sends out the final data at close time. When a signal comes in during
close then it can happen tcp_sendmsg_locked() is interrupted by that
signal while waiting for memory in sk_stream_wait_memory() which then
returns with -ERSTARTSYS. It is not possible to recover from this situation
and the final transmit data is lost.

With this patch we defer the close operation to a kernel task which
doesn't get signals.

The described situation happens when KTLS is used in conjunction with
io_uring, as io_uring uses task_work_add() to add work to the current
userspace task.

The problem is discussed in [1] and [2] and the solution implemented in
this patch is suggested by Pavel Begunkov here [3]

[1] https://lore.kernel.org/all/20231010141932.GD3114228@pengutronix.de/
[2] https://lore.kernel.org/all/20240315100159.3898944-1-s.hauer@pengutronix.de/
[3] https://lore.kernel.org/all/bfc6afa9-501f-40b6-929a-3aa8c0298265@gmail.com

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---

Note I only need this asynchronous close for the
ctx->tx_conf == TLS_SW case. I can refactor the patch to only go
asynchronous when necessary if that's desired.
---
 net/tls/tls_main.c | 37 +++++++++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index b4674f03d71a9..b0b7e0d2f1145 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -365,16 +365,21 @@ static void tls_sk_proto_cleanup(struct sock *sk,
 	}
 }
 
-static void tls_sk_proto_close(struct sock *sk, long timeout)
+struct tls_close_work {
+	struct work_struct work;
+	struct tls_context *ctx;
+	long timeout;
+};
+
+static void deferred_close(struct work_struct *work)
 {
+	struct tls_close_work *cw = container_of(work, struct tls_close_work, work);
+	struct tls_context *ctx = cw->ctx;
+	struct sock *sk = ctx->sk;
 	struct inet_connection_sock *icsk = inet_csk(sk);
-	struct tls_context *ctx = tls_get_ctx(sk);
 	long timeo = sock_sndtimeo(sk, 0);
 	bool free_ctx;
 
-	if (ctx->tx_conf == TLS_SW)
-		tls_sw_cancel_work_tx(ctx);
-
 	lock_sock(sk);
 	free_ctx = ctx->tx_conf != TLS_HW && ctx->rx_conf != TLS_HW;
 
@@ -395,10 +400,30 @@ static void tls_sk_proto_close(struct sock *sk, long timeout)
 		tls_sw_strparser_done(ctx);
 	if (ctx->rx_conf == TLS_SW)
 		tls_sw_free_ctx_rx(ctx);
-	ctx->sk_proto->close(sk, timeout);
+	ctx->sk_proto->close(sk, cw->timeout);
 
 	if (free_ctx)
 		tls_ctx_free(sk, ctx);
+
+	kfree(cw);
+}
+
+static void tls_sk_proto_close(struct sock *sk, long timeout)
+{
+	struct tls_context *ctx = tls_get_ctx(sk);
+	struct tls_close_work *cw;
+
+	if (ctx->tx_conf == TLS_SW)
+		tls_sw_cancel_work_tx(ctx);
+
+	cw = kmalloc(sizeof(*cw), GFP_KERNEL);
+	if (!cw)
+		return;
+
+	INIT_WORK(&cw->work, deferred_close);
+	cw->timeout = timeout;
+	cw->ctx = ctx;
+	queue_work(system_unbound_wq, &cw->work);
 }
 
 static __poll_t tls_sk_poll(struct file *file, struct socket *sock,

---
base-commit: fec50db7033ea478773b159e0e2efb135270e3b7
change-id: 20240410-ktls-defer-close-002934564b09

Best regards,
-- 
Sascha Hauer <s.hauer@pengutronix.de>


