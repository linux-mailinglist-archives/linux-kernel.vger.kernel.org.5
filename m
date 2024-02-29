Return-Path: <linux-kernel+bounces-86959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F5586CD95
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 541911F2309B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC703157E9E;
	Thu, 29 Feb 2024 15:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hlpnsrw3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E287315697B;
	Thu, 29 Feb 2024 15:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221754; cv=none; b=pkqNRxLzUm7EqkWXgd+autiJPgebSrZfd0DybCDxYB1LvPmBK1T56nn88WTXuMNZo6A46PWaC+wZXMXMPB46f7sVeg4V89b9WgP7daEg+WplCb05axfGwDx0DQymdRwe6u7pASi8QUhbC1fjQHWlrtp6mvQlJsOQMmc1II0ThXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221754; c=relaxed/simple;
	bh=9qydeZ7dVGJrZhYf5SEPFF/yp8kpRzWIKk8rEXwn+Ec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZOpzSxVWwYoMR2E2wX6ohZhHm5OlpYt7NEGbIr2kJ4IZc3GPemgugdMXDdoybCRr00iEVqgHXvRvhbUoZkU6pZVY5ITyLywr6QBbVhdB6pnVoD++P8NUDWVYhgOVq+4dF/PZVLsXLaIbmby3mFxofAUTD31fmbFrXk0MCHbfXNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hlpnsrw3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 157B0C433C7;
	Thu, 29 Feb 2024 15:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709221753;
	bh=9qydeZ7dVGJrZhYf5SEPFF/yp8kpRzWIKk8rEXwn+Ec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hlpnsrw3jTlexkwNCRD5wkL+o26sGTWE3XQlB4R5y2ud0g6M/FdaBhv2aIOmdNwQ5
	 Ba4NaJuX5hNYAbTcxkAumCvNg4noGIl723UvUv8Hv2/A6M6/4d4oKqf4ZRtKDVayrG
	 K/a3y1EQCPpjUSWnmzCNjKQz22stJNr3ZiJ0r7WM23UTWgSZE15csJ6CKkPpLPEnuL
	 ttk2y0BygGkDxHziJ3hVYR9+yhN30lLQP3TXihcGjKmpU2fEj/ag6yWgrGU3zBgGrS
	 DkDNwXnxms5FG40sm6g3SoN93ldZyjsHJhevqZikMIwmvLjSAWEFr3GANbIfBheNaz
	 JNwwu9mT1qb7Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 11/26] net: tls: factor out tls_*crypt_async_wait()
Date: Thu, 29 Feb 2024 10:48:30 -0500
Message-ID: <20240229154851.2849367-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229154851.2849367-1-sashal@kernel.org>
References: <20240229154851.2849367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.6
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit c57ca512f3b68ddcd62bda9cc24a8f5584ab01b1 ]

Factor out waiting for async encrypt and decrypt to finish.
There are already multiple copies and a subsequent fix will
need more. No functional changes.

Note that crypto_wait_req() returns wait->err

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/tls/tls_sw.c | 96 +++++++++++++++++++++++-------------------------
 1 file changed, 45 insertions(+), 51 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 31e8a94dfc111..6a73714f34cc4 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -230,6 +230,20 @@ static void tls_decrypt_done(void *data, int err)
 	spin_unlock_bh(&ctx->decrypt_compl_lock);
 }
 
+static int tls_decrypt_async_wait(struct tls_sw_context_rx *ctx)
+{
+	int pending;
+
+	spin_lock_bh(&ctx->decrypt_compl_lock);
+	reinit_completion(&ctx->async_wait.completion);
+	pending = atomic_read(&ctx->decrypt_pending);
+	spin_unlock_bh(&ctx->decrypt_compl_lock);
+	if (pending)
+		crypto_wait_req(-EINPROGRESS, &ctx->async_wait);
+
+	return ctx->async_wait.err;
+}
+
 static int tls_do_decryption(struct sock *sk,
 			     struct scatterlist *sgin,
 			     struct scatterlist *sgout,
@@ -495,6 +509,28 @@ static void tls_encrypt_done(void *data, int err)
 		schedule_delayed_work(&ctx->tx_work.work, 1);
 }
 
+static int tls_encrypt_async_wait(struct tls_sw_context_tx *ctx)
+{
+	int pending;
+
+	spin_lock_bh(&ctx->encrypt_compl_lock);
+	ctx->async_notify = true;
+
+	pending = atomic_read(&ctx->encrypt_pending);
+	spin_unlock_bh(&ctx->encrypt_compl_lock);
+	if (pending)
+		crypto_wait_req(-EINPROGRESS, &ctx->async_wait);
+	else
+		reinit_completion(&ctx->async_wait.completion);
+
+	/* There can be no concurrent accesses, since we have no
+	 * pending encrypt operations
+	 */
+	WRITE_ONCE(ctx->async_notify, false);
+
+	return ctx->async_wait.err;
+}
+
 static int tls_do_encryption(struct sock *sk,
 			     struct tls_context *tls_ctx,
 			     struct tls_sw_context_tx *ctx,
@@ -984,7 +1020,6 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 	int num_zc = 0;
 	int orig_size;
 	int ret = 0;
-	int pending;
 
 	if (!eor && (msg->msg_flags & MSG_EOR))
 		return -EINVAL;
@@ -1163,24 +1198,12 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 	if (!num_async) {
 		goto send_end;
 	} else if (num_zc) {
-		/* Wait for pending encryptions to get completed */
-		spin_lock_bh(&ctx->encrypt_compl_lock);
-		ctx->async_notify = true;
-
-		pending = atomic_read(&ctx->encrypt_pending);
-		spin_unlock_bh(&ctx->encrypt_compl_lock);
-		if (pending)
-			crypto_wait_req(-EINPROGRESS, &ctx->async_wait);
-		else
-			reinit_completion(&ctx->async_wait.completion);
-
-		/* There can be no concurrent accesses, since we have no
-		 * pending encrypt operations
-		 */
-		WRITE_ONCE(ctx->async_notify, false);
+		int err;
 
-		if (ctx->async_wait.err) {
-			ret = ctx->async_wait.err;
+		/* Wait for pending encryptions to get completed */
+		err = tls_encrypt_async_wait(ctx);
+		if (err) {
+			ret = err;
 			copied = 0;
 		}
 	}
@@ -1229,7 +1252,6 @@ void tls_sw_splice_eof(struct socket *sock)
 	ssize_t copied = 0;
 	bool retrying = false;
 	int ret = 0;
-	int pending;
 
 	if (!ctx->open_rec)
 		return;
@@ -1264,22 +1286,7 @@ void tls_sw_splice_eof(struct socket *sock)
 	}
 
 	/* Wait for pending encryptions to get completed */
-	spin_lock_bh(&ctx->encrypt_compl_lock);
-	ctx->async_notify = true;
-
-	pending = atomic_read(&ctx->encrypt_pending);
-	spin_unlock_bh(&ctx->encrypt_compl_lock);
-	if (pending)
-		crypto_wait_req(-EINPROGRESS, &ctx->async_wait);
-	else
-		reinit_completion(&ctx->async_wait.completion);
-
-	/* There can be no concurrent accesses, since we have no pending
-	 * encrypt operations
-	 */
-	WRITE_ONCE(ctx->async_notify, false);
-
-	if (ctx->async_wait.err)
+	if (tls_encrypt_async_wait(ctx))
 		goto unlock;
 
 	/* Transmit if any encryptions have completed */
@@ -2109,16 +2116,10 @@ int tls_sw_recvmsg(struct sock *sk,
 
 recv_end:
 	if (async) {
-		int ret, pending;
+		int ret;
 
 		/* Wait for all previously submitted records to be decrypted */
-		spin_lock_bh(&ctx->decrypt_compl_lock);
-		reinit_completion(&ctx->async_wait.completion);
-		pending = atomic_read(&ctx->decrypt_pending);
-		spin_unlock_bh(&ctx->decrypt_compl_lock);
-		ret = 0;
-		if (pending)
-			ret = crypto_wait_req(-EINPROGRESS, &ctx->async_wait);
+		ret = tls_decrypt_async_wait(ctx);
 		__skb_queue_purge(&ctx->async_hold);
 
 		if (ret) {
@@ -2435,16 +2436,9 @@ void tls_sw_release_resources_tx(struct sock *sk)
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
 	struct tls_sw_context_tx *ctx = tls_sw_ctx_tx(tls_ctx);
 	struct tls_rec *rec, *tmp;
-	int pending;
 
 	/* Wait for any pending async encryptions to complete */
-	spin_lock_bh(&ctx->encrypt_compl_lock);
-	ctx->async_notify = true;
-	pending = atomic_read(&ctx->encrypt_pending);
-	spin_unlock_bh(&ctx->encrypt_compl_lock);
-
-	if (pending)
-		crypto_wait_req(-EINPROGRESS, &ctx->async_wait);
+	tls_encrypt_async_wait(ctx);
 
 	tls_tx_records(sk, -1);
 
-- 
2.43.0


