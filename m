Return-Path: <linux-kernel+bounces-58507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FE484E74A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2F051F25B09
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DFD82D9A;
	Thu,  8 Feb 2024 18:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l1F8eMVe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA5B86AF2;
	Thu,  8 Feb 2024 18:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707415470; cv=none; b=CnTImYcMA611CxzsuVjnnQukd31Lu/IjMR1VKDPV7ghVJMvHVns6h1Ix6PDtqfP1k0fUp8LOdiXjymOG0hpxyY8T0RmbwYBdDuyJacvezJxOa6McTyFDbj5WvJDglAMwKx3WRxGeAMB35Y3UaE/d4R+B0S6CqOqBsov6AqOFL3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707415470; c=relaxed/simple;
	bh=EOoPTeNnER7i43iXou7ntTSk1e6l39fVUtsHySrh3Fo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sxCD8k/sE7AIzjrxu2JJYw8uyooKNO78UfQfmixD8U6Agr1nOLzr3Th3omF/hSg4961T3xacMd7SNsZRF5khdFyWfl2VWHJaFCnD3IUijP4tw2ZpvVPtHeF+tvRKdPd/Tq5hNR2/h5G34GthWdD0Qn8FPMBcJeDeDNDxrXIEQHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l1F8eMVe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EAFDC433B1;
	Thu,  8 Feb 2024 18:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707415469;
	bh=EOoPTeNnER7i43iXou7ntTSk1e6l39fVUtsHySrh3Fo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=l1F8eMVeUYOlgnfTDTMEH1O2giWk7wFtGNmQdlYAymbpn9WE713UNZY8ljtaxMjjS
	 FKQn+8/jsAIsSY+fq2sDx/IA6jwML3ajY2x2KonSUaaRdM8jGMoMM0y2mn7b+p9zP3
	 cPmeHIDp6C1p6h4crEa9FhoiYIixn9bdv+2ADhS0fmEoTYZhh7Y/qXxYgPKwI+4ho3
	 v574ndktvL0G8hAS92XEMyq1ahMNWupijfzJ44Z072/R4s/9kpr+uHQcCwXH9fSXIB
	 iqKRcrCEvG8SE+vF0G+ULFmFi0/zEUGL5wvkKell8FnWunudNqm8TdjYeWk/T7F7II
	 63PiboTeUjHCA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 08 Feb 2024 19:03:50 +0100
Subject: [PATCH net 2/7] mptcp: fix rcv space initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240208-upstream-net-20240202-locking-cleanup-misc-v1-2-f75cc5b97e5a@kernel.org>
References: <20240208-upstream-net-20240202-locking-cleanup-misc-v1-0-f75cc5b97e5a@kernel.org>
In-Reply-To: <20240208-upstream-net-20240202-locking-cleanup-misc-v1-0-f75cc5b97e5a@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Kishen Maloor <kishen.maloor@intel.com>, 
 Florian Westphal <fw@strlen.de>, 
 Peter Krystad <peter.krystad@linux.intel.com>, 
 Dmytro Shytyi <dmytro@shytyi.net>, 
 Benjamin Hesmans <benjamin.hesmans@tessares.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Christoph Paasch <cpaasch@apple.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=4231; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=u459/uEWds6unUKdxrBRK9kc4LzzOSdfJrTQrb3+BUo=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlxReh66G8XYWqiDsnrvH7A+T0+wCScbecigzt8
 f6bvzZYXauJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZcUXoQAKCRD2t4JPQmmg
 c8ZHD/9fQ9GFtFA+opHpLjjxDQhx+9qRdYgaO/d07oA3asjxIH0a7bEW3hF3T8zW2GchvdYjPew
 lln3UQvrNrZitHWpfXiBSmEyWQSzo3+027w0wqiCOUH/mMKDv6zHVaUMNatzrd/uxRqC1KLhbbD
 NTEn3f16j3uo6N0v5MdK2R+4t7C1OOYyBASNbfna+P5Tx2MKTXd2kbcOUtvMhT72g03a2Vfm2F8
 oB9Vt5Jp5FtzKvQrGqnUjwG1ahwoQW53U48l1bILHICl72xYWtfWyVdaV8GEgO42FPEp5TSAE8g
 sssrhYT5z5T3eMCK81q27+Nflr0YDS3dyvWx1NeZLUpJajbBqznDUoBT1mOZ+BULayyHue6S9MT
 0MzC+CvYZ33QC9zq3E9UrmYdsdM1DSU/cPEsm6ZA3t8/eo6fqHp0P7s9CZhprP/1h5jPCoWvb/k
 pH+pty8cLODZbhAMAgeBB98/6ytSuBIxvZ3AgSkyEQYEtKxDQ4m00y2xpx0VD5FO8y//cp2Kw+D
 tofIUHbqHyMVvO714CXGvZ1187d9zR9BjGrVSxNzppMwVwCb+X1VQ5jIQUUcONjv2FeN6ztwj4x
 H3BuCbO4VvsWvamW1U62Pzwg620fUXs4ZBTmw0Js67Zcjzgp5z23IsHsWg0dGKVF3frYOuc9cbB
 1vs8YAOhSNXFVZQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

mptcp_rcv_space_init() is supposed to happen under the msk socket
lock, but active msk socket does that without such protection.

Leverage the existing mptcp_propagate_state() helper to that extent.
We need to ensure mptcp_rcv_space_init will happen before
mptcp_rcv_space_adjust(), and the release_cb does not assure that:
explicitly check for such condition.

While at it, move the wnd_end initialization out of mptcp_rcv_space_init(),
it never belonged there.

Note that the race does not produce ill effect in practice, but
change allows cleaning-up and defying better the locking model.

Fixes: a6b118febbab ("mptcp: add receive buffer auto-tuning")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 10 ++++++----
 net/mptcp/protocol.h |  3 ++-
 net/mptcp/subflow.c  |  4 ++--
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2111819016af..7632eafb683b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1963,6 +1963,9 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 	if (copied <= 0)
 		return;
 
+	if (!msk->rcvspace_init)
+		mptcp_rcv_space_init(msk, msk->first);
+
 	msk->rcvq_space.copied += copied;
 
 	mstamp = div_u64(tcp_clock_ns(), NSEC_PER_USEC);
@@ -3160,6 +3163,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	msk->bytes_received = 0;
 	msk->bytes_sent = 0;
 	msk->bytes_retrans = 0;
+	msk->rcvspace_init = 0;
 
 	WRITE_ONCE(sk->sk_shutdown, 0);
 	sk_error_report(sk);
@@ -3247,6 +3251,7 @@ void mptcp_rcv_space_init(struct mptcp_sock *msk, const struct sock *ssk)
 {
 	const struct tcp_sock *tp = tcp_sk(ssk);
 
+	msk->rcvspace_init = 1;
 	msk->rcvq_space.copied = 0;
 	msk->rcvq_space.rtt_us = 0;
 
@@ -3257,8 +3262,6 @@ void mptcp_rcv_space_init(struct mptcp_sock *msk, const struct sock *ssk)
 				      TCP_INIT_CWND * tp->advmss);
 	if (msk->rcvq_space.space == 0)
 		msk->rcvq_space.space = TCP_INIT_CWND * TCP_MSS_DEFAULT;
-
-	WRITE_ONCE(msk->wnd_end, msk->snd_nxt + tcp_sk(ssk)->snd_wnd);
 }
 
 void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags)
@@ -3478,10 +3481,9 @@ void mptcp_finish_connect(struct sock *ssk)
 	WRITE_ONCE(msk->write_seq, subflow->idsn + 1);
 	WRITE_ONCE(msk->snd_nxt, msk->write_seq);
 	WRITE_ONCE(msk->snd_una, msk->write_seq);
+	WRITE_ONCE(msk->wnd_end, msk->snd_nxt + tcp_sk(ssk)->snd_wnd);
 
 	mptcp_pm_new_connection(msk, ssk, 0);
-
-	mptcp_rcv_space_init(msk, ssk);
 }
 
 void mptcp_sock_graft(struct sock *sk, struct socket *parent)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index b905f1868298..9f5ee82e3473 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -304,7 +304,8 @@ struct mptcp_sock {
 			nodelay:1,
 			fastopening:1,
 			in_accept_queue:1,
-			free_first:1;
+			free_first:1,
+			rcvspace_init:1;
 	struct work_struct work;
 	struct sk_buff  *ooo_last_skb;
 	struct rb_root  out_of_order_queue;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 0dcb721c89d1..56b2ac2f2f22 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -424,6 +424,8 @@ void __mptcp_sync_state(struct sock *sk, int state)
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
 	__mptcp_propagate_sndbuf(sk, msk->first);
+	if (!msk->rcvspace_init)
+		mptcp_rcv_space_init(msk, msk->first);
 	if (sk->sk_state == TCP_SYN_SENT) {
 		mptcp_set_state(sk, state);
 		sk->sk_state_change(sk);
@@ -545,7 +547,6 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 		}
 	} else if (mptcp_check_fallback(sk)) {
 fallback:
-		mptcp_rcv_space_init(msk, sk);
 		mptcp_propagate_state(parent, sk);
 	}
 	return;
@@ -1744,7 +1745,6 @@ static void subflow_state_change(struct sock *sk)
 	msk = mptcp_sk(parent);
 	if (subflow_simultaneous_connect(sk)) {
 		mptcp_do_fallback(sk);
-		mptcp_rcv_space_init(msk, sk);
 		pr_fallback(msk);
 		subflow->conn_finished = 1;
 		mptcp_propagate_state(parent, sk);

-- 
2.43.0


