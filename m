Return-Path: <linux-kernel+bounces-115176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22246888D96
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5369D1C2989E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D903F308405;
	Mon, 25 Mar 2024 01:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mP6+/gNl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2942813C90C;
	Sun, 24 Mar 2024 23:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324235; cv=none; b=I0oEbR0PUm4ON3HT/C2ys16Spr1aDDgXlSgnmrlp91BLOkftRvCdCTB700Fh3PQvaqZDObqN9FUFlxIPSG45pPMRCe40c+rBjBt6EEL8KQCTH30IUfn9zsrPun9buv9EeaIdGU9DN5O+bx3sIDysR0AvQLAbJtGJeVdpIOxqbf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324235; c=relaxed/simple;
	bh=THPvOALJ4wvUxBHy4l+81UW2a018QyQ7BQ7O93l7i20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O7wZl0SnnARUVSgPTHvxe5PF9TZ+X7+5Qbh5KcvekLXXaH2zSqgqMMC42OcvRHjA9vxxC6dwafu6FIlmRNVURLsfqttpnHLjmQO30eKZ7gTVDL84viBpDhChmqt4gdw0QLVKihqV4AvaxuwpWH+UMYd16d3TO6jtzJZacjPimPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mP6+/gNl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 492CAC43394;
	Sun, 24 Mar 2024 23:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324233;
	bh=THPvOALJ4wvUxBHy4l+81UW2a018QyQ7BQ7O93l7i20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mP6+/gNlUHU1C+Y8v/LdI7f2Yy4aFt2Ypq/LKCemTmdYkzsBJDa1qfALKxZ16GUbE
	 TA+3KQ+vwxazi1UdKmBgTX/AXDaGUN2QnX+5eu8OgOh3bNftakNLFhasym0r0LLwVU
	 2BLHPt4Akl7pIPDhVxhEGw9Ewd9tFLonHmcauTRDZq8BQHBFQzzJ+4Zs7tMQQkZLlZ
	 jpntQvKYRP6CVb3gQXj3GBX84Pm3pzP0KMUyBKG8dyEKlYkZ0R5tgNeQFbA/saikfv
	 7w2ZmdzHKMW6zJB/eUBfvMmjjodp/+r3VZS0WW9sMHGYP6c+J8PoXoYgSDI36Iogla
	 Dnbo4wPDBDFRw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 017/148] crypto: algif_aead - Only wake up when ctx->more is zero
Date: Sun, 24 Mar 2024 19:48:01 -0400
Message-ID: <20240324235012.1356413-18-sashal@kernel.org>
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

From: Herbert Xu <herbert@gondor.apana.org.au>

[ Upstream commit f3c802a1f30013f8f723b62d7fa49eb9e991da23 ]

AEAD does not support partial requests so we must not wake up
while ctx->more is set.  In order to distinguish between the
case of no data sent yet and a zero-length request, a new init
flag has been added to ctx.

SKCIPHER has also been modified to ensure that at least a block
of data is available if there is more data to come.

Fixes: 2d97591ef43d ("crypto: af_alg - consolidation of...")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 crypto/af_alg.c         | 11 ++++++++---
 crypto/algif_aead.c     |  4 ++--
 crypto/algif_skcipher.c |  4 ++--
 include/crypto/if_alg.h |  4 +++-
 4 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/crypto/af_alg.c b/crypto/af_alg.c
index ed62632a1c355..78f041754f04f 100644
--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -648,6 +648,7 @@ void af_alg_pull_tsgl(struct sock *sk, size_t used, struct scatterlist *dst,
 
 	if (!ctx->used)
 		ctx->merge = 0;
+	ctx->init = ctx->more;
 }
 EXPORT_SYMBOL_GPL(af_alg_pull_tsgl);
 
@@ -747,9 +748,10 @@ EXPORT_SYMBOL_GPL(af_alg_wmem_wakeup);
  *
  * @sk socket of connection to user space
  * @flags If MSG_DONTWAIT is set, then only report if function would sleep
+ * @min Set to minimum request size if partial requests are allowed.
  * @return 0 when writable memory is available, < 0 upon error
  */
-int af_alg_wait_for_data(struct sock *sk, unsigned flags)
+int af_alg_wait_for_data(struct sock *sk, unsigned flags, unsigned min)
 {
 	DEFINE_WAIT_FUNC(wait, woken_wake_function);
 	struct alg_sock *ask = alg_sk(sk);
@@ -767,7 +769,9 @@ int af_alg_wait_for_data(struct sock *sk, unsigned flags)
 		if (signal_pending(current))
 			break;
 		timeout = MAX_SCHEDULE_TIMEOUT;
-		if (sk_wait_event(sk, &timeout, (ctx->used || !ctx->more),
+		if (sk_wait_event(sk, &timeout,
+				  ctx->init && (!ctx->more ||
+						(min && ctx->used >= min)),
 				  &wait)) {
 			err = 0;
 			break;
@@ -856,7 +860,7 @@ int af_alg_sendmsg(struct socket *sock, struct msghdr *msg, size_t size,
 	}
 
 	lock_sock(sk);
-	if (!ctx->more && ctx->used) {
+	if (ctx->init && (init || !ctx->more)) {
 		err = -EINVAL;
 		goto unlock;
 	}
@@ -867,6 +871,7 @@ int af_alg_sendmsg(struct socket *sock, struct msghdr *msg, size_t size,
 			memcpy(ctx->iv, con.iv->iv, ivsize);
 
 		ctx->aead_assoclen = con.aead_assoclen;
+		ctx->init = true;
 	}
 
 	while (size) {
diff --git a/crypto/algif_aead.c b/crypto/algif_aead.c
index 4cb2b12175490..63ba443b23157 100644
--- a/crypto/algif_aead.c
+++ b/crypto/algif_aead.c
@@ -110,8 +110,8 @@ static int _aead_recvmsg(struct socket *sock, struct msghdr *msg,
 	size_t usedpages = 0;		/* [in]  RX bufs to be used from user */
 	size_t processed = 0;		/* [in]  TX bufs to be consumed */
 
-	if (!ctx->used) {
-		err = af_alg_wait_for_data(sk, flags);
+	if (!ctx->init || ctx->more) {
+		err = af_alg_wait_for_data(sk, flags, 0);
 		if (err)
 			return err;
 	}
diff --git a/crypto/algif_skcipher.c b/crypto/algif_skcipher.c
index af08fc18a4926..6cfdbe71a2ce3 100644
--- a/crypto/algif_skcipher.c
+++ b/crypto/algif_skcipher.c
@@ -65,8 +65,8 @@ static int _skcipher_recvmsg(struct socket *sock, struct msghdr *msg,
 	int err = 0;
 	size_t len = 0;
 
-	if (!ctx->used) {
-		err = af_alg_wait_for_data(sk, flags);
+	if (!ctx->init || (ctx->more && ctx->used < bs)) {
+		err = af_alg_wait_for_data(sk, flags, bs);
 		if (err)
 			return err;
 	}
diff --git a/include/crypto/if_alg.h b/include/crypto/if_alg.h
index f0c83a7bd078b..69fc69973269e 100644
--- a/include/crypto/if_alg.h
+++ b/include/crypto/if_alg.h
@@ -140,6 +140,7 @@ struct af_alg_async_req {
  *			SG?
  * @enc:		Cryptographic operation to be performed when
  *			recvmsg is invoked.
+ * @init:		True if metadata has been sent.
  * @len:		Length of memory allocated for this data structure.
  * @inflight:		Non-zero when AIO requests are in flight.
  */
@@ -157,6 +158,7 @@ struct af_alg_ctx {
 	bool more;
 	bool merge;
 	bool enc;
+	bool init;
 
 	unsigned int len;
 
@@ -234,7 +236,7 @@ unsigned int af_alg_count_tsgl(struct sock *sk, size_t bytes, size_t offset);
 void af_alg_pull_tsgl(struct sock *sk, size_t used, struct scatterlist *dst,
 		      size_t dst_offset);
 void af_alg_wmem_wakeup(struct sock *sk);
-int af_alg_wait_for_data(struct sock *sk, unsigned flags);
+int af_alg_wait_for_data(struct sock *sk, unsigned flags, unsigned min);
 int af_alg_sendmsg(struct socket *sock, struct msghdr *msg, size_t size,
 		   unsigned int ivsize);
 ssize_t af_alg_sendpage(struct socket *sock, struct page *page,
-- 
2.43.0


