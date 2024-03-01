Return-Path: <linux-kernel+bounces-88854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3914F86E790
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F928B25AA9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B154239ACE;
	Fri,  1 Mar 2024 17:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gTX5kZtM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C314938DE0;
	Fri,  1 Mar 2024 17:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709315055; cv=none; b=DkTlEscEBho3UBexnB2LxDxi06goGBO9j4mq9d3hmU7qGGJImBKBrga1FgkvZVgslOR6qZ9roJlfXWwgtgcpQvbrDHmVnWHNOzpptPIuA0cGdOJPXnXXJ0KjMznDMGTuJsNiM/yds+vtk9fP/4gDezKBXmHMAUuEiOxJ5NdRKng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709315055; c=relaxed/simple;
	bh=On3LuyuchIv+6vUp+3/v6/8Liy7MCKBeHemzKMyJi28=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LUMhA5g2YjDHRQMgk4Ao2clnAWWzXxAFY6fnJUKQ/H/hpuwemgm5cjwkFh6zgMEyptU66cMkENCn3zy7UR9YK84EFiCK64fQgbTL/nUpJCKMB1xfSXcW3pB8D2re7VUvsa3rsBmDwAQPjMFh+1pSl/IYhxvRlkQ1iM6YeGjMHMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gTX5kZtM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DE67C433C7;
	Fri,  1 Mar 2024 17:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709315055;
	bh=On3LuyuchIv+6vUp+3/v6/8Liy7MCKBeHemzKMyJi28=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gTX5kZtMwC4VVSieEoF7mir9xtf+ndqZvp/yHAaX6z15w5mfVk1ik37QX1YVSR3ob
	 nM/KM2Uja89196F+3ShlBYkRZTBo2JkyEFAtiWxKWbyoWfjRbgml0p5OMAXWS7LK3b
	 ATkhs5G/85kSr3drOz+uzPmQ3Fh+huT4KpYto8d/pcyASkGo6xpP26YwWShGRyM6oi
	 TEk1AdExOfvcDVikLS2VXcqTndpPc5j6KXfnp6dRneoOfNwCDKnCi3zia+JTw8pQRr
	 moKxqRAqS3OhLnVv7V8hTldoLqhIfX2YmSHutlIgIWHshmE2F6a2Y8r7R8FOKlcdFy
	 1YJDzLzVZO8/A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 01 Mar 2024 18:43:46 +0100
Subject: [PATCH net-next 3/4] mptcp: implement TCP_NOTSENT_LOWAT support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240301-upstream-net-next-20240301-mptcp-tcp_notsent_lowat-v1-3-415f0e8ed0e1@kernel.org>
References: <20240301-upstream-net-next-20240301-mptcp-tcp_notsent_lowat-v1-0-415f0e8ed0e1@kernel.org>
In-Reply-To: <20240301-upstream-net-next-20240301-mptcp-tcp_notsent_lowat-v1-0-415f0e8ed0e1@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6452; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=DylowcMwFWhiJDHcbv67N/3PhLtYSLe2QauXhTfybI0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl4hPlCVJjrsvPQRsqK81MfJXtMx2+zrnm9c51K
 BLZyx1pvvOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeIT5QAKCRD2t4JPQmmg
 c+0oD/90WrTHgoFAFhzSgNrxFEi70XeSvnQmlhuwtqV0jKUuPuofY7zNyyjRxQOQafbYgGk/M1F
 C/gi8sEfh6klQx16tbi+ptK+YX/UWnUk4cYa4bES/BWITCnF2pg74Z4hVwzka3I3E6AJmTjD064
 cNQIde751qMJaW1QPp/QngoyS5TtnqtbAvsG927RxMwrbEuEXkTSUJfI56yvMksbtc7CAfIMpc1
 QwlHeeLHlSObT4OQHMepe3QkX3HAFF9VuLL/f55yBcCYD7GEFiMQlkRAg36DGMjKZanUAkMxp4k
 AGNP7CDI2eOJXCwHSJZc0dsc2sWFDi4aTaHwK4x6eSirHXX6m1b/1oVHNxHUGC1pTAWDyhTvjtL
 uy4D71Hhy/bBdXMu5pPmraUGj7Qu0PJ++wiQGLj93L8t3+n+RrC3YCG7Rb/8cdIa/bnNdsFBomD
 XSlJI+aQXvno/b1Rs1mTN310+KxKlT6IX9K6OCxTb78T9N68R/Zq6vrOqFE4XfHUoAYJxz8g9qO
 3WAAFCLmWPDcudLvpwrZx1nLfvN77NsLE2bnX7LCx5MMlD3NIgbbHYkTVrfF6nArXds/ErSuGnV
 FHZj0MKss7czv2sX+2BECdMaLfjVgcVtueVwmHplYFQzX2lL97eFql8BNlXbrM+2emk4Dl1xQNh
 YKmQalWTOWFcyFQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

Add support for such socket option storing the user-space provided
value in a new msk field, and using such data to implement the
_mptcp_stream_memory_free() helper, similar to the TCP one.

To avoid adding more indirect calls in the fast path, open-code
a variant of sk_stream_memory_free() in mptcp_sendmsg() and add
direct calls to the mptcp stream memory free helper where possible.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/464
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 39 ++++++++++++++++++++++++++++++++++-----
 net/mptcp/protocol.h | 28 +++++++++++++++++++++++++++-
 net/mptcp/sockopt.c  | 12 ++++++++++++
 3 files changed, 73 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a3d79e9d0694..99367c40de0d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1762,6 +1762,30 @@ static int do_copy_data_nocache(struct sock *sk, int copy,
 	return 0;
 }
 
+/* open-code sk_stream_memory_free() plus sent limit computation to
+ * avoid indirect calls in fast-path.
+ * Called under the msk socket lock, so we can avoid a bunch of ONCE
+ * annotations.
+ */
+static u32 mptcp_send_limit(const struct sock *sk)
+{
+	const struct mptcp_sock *msk = mptcp_sk(sk);
+	u32 limit, not_sent;
+
+	if (sk->sk_wmem_queued >= READ_ONCE(sk->sk_sndbuf))
+		return 0;
+
+	limit = mptcp_notsent_lowat(sk);
+	if (limit == UINT_MAX)
+		return UINT_MAX;
+
+	not_sent = msk->write_seq - msk->snd_nxt;
+	if (not_sent >= limit)
+		return 0;
+
+	return limit - not_sent;
+}
+
 static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
@@ -1806,6 +1830,12 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		struct mptcp_data_frag *dfrag;
 		bool dfrag_collapsed;
 		size_t psize, offset;
+		u32 copy_limit;
+
+		/* ensure fitting the notsent_lowat() constraint */
+		copy_limit = mptcp_send_limit(sk);
+		if (!copy_limit)
+			goto wait_for_memory;
 
 		/* reuse tail pfrag, if possible, or carve a new one from the
 		 * page allocator
@@ -1813,9 +1843,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		dfrag = mptcp_pending_tail(sk);
 		dfrag_collapsed = mptcp_frag_can_collapse_to(msk, pfrag, dfrag);
 		if (!dfrag_collapsed) {
-			if (!sk_stream_memory_free(sk))
-				goto wait_for_memory;
-
 			if (!mptcp_page_frag_refill(sk, pfrag))
 				goto wait_for_memory;
 
@@ -1830,6 +1857,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		offset = dfrag->offset + dfrag->data_len;
 		psize = pfrag->size - offset;
 		psize = min_t(size_t, psize, msg_data_left(msg));
+		psize = min_t(size_t, psize, copy_limit);
 		total_ts = psize + frag_truesize;
 
 		if (!sk_wmem_schedule(sk, total_ts))
@@ -3760,6 +3788,7 @@ static struct proto mptcp_prot = {
 	.unhash		= mptcp_unhash,
 	.get_port	= mptcp_get_port,
 	.forward_alloc_get	= mptcp_forward_alloc_get,
+	.stream_memory_free	= mptcp_stream_memory_free,
 	.sockets_allocated	= &mptcp_sockets_allocated,
 
 	.memory_allocated	= &tcp_memory_allocated,
@@ -3933,12 +3962,12 @@ static __poll_t mptcp_check_writeable(struct mptcp_sock *msk)
 {
 	struct sock *sk = (struct sock *)msk;
 
-	if (sk_stream_is_writeable(sk))
+	if (__mptcp_stream_is_writeable(sk, 1))
 		return EPOLLOUT | EPOLLWRNORM;
 
 	set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
 	smp_mb__after_atomic(); /* NOSPACE is changed by mptcp_write_space() */
-	if (sk_stream_is_writeable(sk))
+	if (__mptcp_stream_is_writeable(sk, 1))
 		return EPOLLOUT | EPOLLWRNORM;
 
 	return 0;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f0c634e843e6..7cb502260dea 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -307,6 +307,7 @@ struct mptcp_sock {
 			in_accept_queue:1,
 			free_first:1,
 			rcvspace_init:1;
+	u32		notsent_lowat;
 	struct work_struct work;
 	struct sk_buff  *ooo_last_skb;
 	struct rb_root  out_of_order_queue;
@@ -807,11 +808,36 @@ static inline bool mptcp_data_fin_enabled(const struct mptcp_sock *msk)
 	       READ_ONCE(msk->write_seq) == READ_ONCE(msk->snd_nxt);
 }
 
+static inline u32 mptcp_notsent_lowat(const struct sock *sk)
+{
+	struct net *net = sock_net(sk);
+	u32 val;
+
+	val = READ_ONCE(mptcp_sk(sk)->notsent_lowat);
+	return val ?: READ_ONCE(net->ipv4.sysctl_tcp_notsent_lowat);
+}
+
+static inline bool mptcp_stream_memory_free(const struct sock *sk, int wake)
+{
+	const struct mptcp_sock *msk = mptcp_sk(sk);
+	u32 notsent_bytes;
+
+	notsent_bytes = READ_ONCE(msk->write_seq) - READ_ONCE(msk->snd_nxt);
+	return (notsent_bytes << wake) < mptcp_notsent_lowat(sk);
+}
+
+static inline bool __mptcp_stream_is_writeable(const struct sock *sk, int wake)
+{
+	return mptcp_stream_memory_free(sk, wake) &&
+	       __sk_stream_is_writeable(sk, wake);
+}
+
 static inline void mptcp_write_space(struct sock *sk)
 {
 	/* pairs with memory barrier in mptcp_poll */
 	smp_mb();
-	sk_stream_write_space(sk);
+	if (mptcp_stream_memory_free(sk, 1))
+		sk_stream_write_space(sk);
 }
 
 static inline void __mptcp_sync_sndbuf(struct sock *sk)
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index ac37f6c5e2ed..1b38dac70719 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -812,6 +812,16 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 		return 0;
 	case TCP_ULP:
 		return -EOPNOTSUPP;
+	case TCP_NOTSENT_LOWAT:
+		ret = mptcp_get_int_option(msk, optval, optlen, &val);
+		if (ret)
+			return ret;
+
+		lock_sock(sk);
+		WRITE_ONCE(msk->notsent_lowat, val);
+		mptcp_write_space(sk);
+		release_sock(sk);
+		return 0;
 	case TCP_CONGESTION:
 		return mptcp_setsockopt_sol_tcp_congestion(msk, optval, optlen);
 	case TCP_CORK:
@@ -1345,6 +1355,8 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 		return mptcp_put_int_option(msk, optval, optlen, msk->cork);
 	case TCP_NODELAY:
 		return mptcp_put_int_option(msk, optval, optlen, msk->nodelay);
+	case TCP_NOTSENT_LOWAT:
+		return mptcp_put_int_option(msk, optval, optlen, msk->notsent_lowat);
 	}
 	return -EOPNOTSUPP;
 }

-- 
2.43.0


