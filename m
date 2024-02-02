Return-Path: <linux-kernel+bounces-49775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9E4846F3B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32ED01F20EF4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9013014462C;
	Fri,  2 Feb 2024 11:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NHx07HdA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E1B144618;
	Fri,  2 Feb 2024 11:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706874022; cv=none; b=HwB9GWf+HAfFiXQ3DcSre06Ob/gHE9TjWx5MEVHPYQvCk+wbPpQcQIsf+jVHEeMy/+1og24TKyK8XhOlzzvsVqmPVbeCWXwQ7vOO/ZvE+11ucAKkkm5sVrx8q5764zrsn84c6EoUNz5cO/9VQM4i2LeciCU829cjvJMJ/TRumy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706874022; c=relaxed/simple;
	bh=jbBx8q1vG4VmSQFPNppoUAvomZ9X9DzfrEVGbLhs1RE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IxxKGwH8e8utSoVcNl7dwEyZw22OiOyrVJWvt2zwhja7UGBSvDfhd9C35/Ev/Ytn6GuB0AwEzeeu73SVt6LzbHvnWDVS0LwPLP01A+5cXsdTeaL4sf2lJCMOH2FwAIs+3O+7M+qTwB+x07JicIoosT/j7las/DvEqRsnyC+1GKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NHx07HdA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B01DC433C7;
	Fri,  2 Feb 2024 11:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706874022;
	bh=jbBx8q1vG4VmSQFPNppoUAvomZ9X9DzfrEVGbLhs1RE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NHx07HdA0txkz6Kg4jcglbOKmsnMJQ58xdfY9vQ097HoD2lqfWhNU++A6LQ9hvPDr
	 PmgKyEkHh1COawu82I/+1FfMoQcLTXslltY6yU9BEiuFjq9iSw8pCgPEeBXj9/y2g9
	 aAybpsJy3SlwTCCTEkH8sJwhSDIu9RVgdQ20H/YCddHdiz6zFgqU/sMGFKcXuQhaic
	 9TkHtwER4oQf5GoGDRPaRVP9B03kpfgMhwT56jyYZ282TJQzU9YVNfzUbtwzZwJ4/b
	 p56c3GeDu0lydQH6LdOIt7tL5Kr+GkYscYbEenA/P7OX22/biLGCqvOEW772fha6wA
	 2HzjsbtrPD0yA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 02 Feb 2024 12:40:08 +0100
Subject: [PATCH net-next 2/5] mptcp: annotate lockless access for the tx
 path
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240202-upstream-net-next-20240202-mptcp-annotate-lockless-access-v1-2-031d6680afdc@kernel.org>
References: <20240202-upstream-net-next-20240202-mptcp-annotate-lockless-access-v1-0-031d6680afdc@kernel.org>
In-Reply-To: <20240202-upstream-net-next-20240202-mptcp-annotate-lockless-access-v1-0-031d6680afdc@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang.tang@linux.dev>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3573; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=7J0ps97A16g4/waL3hRAHqtfG/mCa7C1N2tO1Q3wljs=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlvNSeEHAGjdHYf9+bhXUw0e25/bnvtwTgQPzCO
 hD8NwuWSW+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZbzUngAKCRD2t4JPQmmg
 c2nrD/4rw4BSU4iHidYCavNrIGDXx87gVG23+vvfoUKu8HzUhssJai6lFM7HKzLL6nBbp0P/AYf
 Kk9XjZ/I9jq+gq3SmH3Unbdbb2a4CcQC1UmWy6Zm0tmmsj9tx/wWSSxCLAMxYYqJC1ay8rnb53N
 a2x/7hr6aoND1O/tqqskqXA50X/flbmCSUAneFYNAN4X1YENXB3pkIB/guybBgS2uE4fN9kdXON
 lP2zfKajD75+Oy2PXA2YM4Icswx7skiaaTPlv02ipfRoX7Uu3wRqDxuCm0DKsU+sIXHBOfDr2wc
 gRZcxRo7jE46xw3152JW6kjwVPf+D+pxjOas4PThmZoXwzo7QCmDCdVsk/1KC0u0AdCDJEMb/9A
 QvrkvvlCtek1dw2G/ywdxq2ZhoYf9YUO7IYyLZnFl/OzlBdwNLq3jPlZQ5Ew4AR/xJLXVNmNj6A
 ainP8gh97rpFenzS7OFAbkb1TyTne5KI9GhuO8YAbQ1TQgfDTXrTBsbx589TPeI03imb0Ycsh6f
 TtoYh6cjsdEK1vhkeL5bSrebmIv/J9joQ2xT0aharoSYV8wbIsfJ//TCbokpZh7t+aph70LuSqU
 OOOwywjBp3QGFl73cCGinUkAzWJ5qf1udzZW/XZseXb2D9JVRWqsLkjrrDH4LzF0aGeHdd3zIOk
 IG/KyuQMKV9qCjQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

The mptcp-level TX path info (write_seq, bytes_sent, snd_nxt) are under
the msk socket lock protection, and are accessed lockless in a few spots.

Always mark the write operations with WRITE_ONCE, read operations
outside the lock with READ_ONCE and drop the annotation for read
under such lock.

To simplify the annotations move mptcp_pending_data_fin_ack() from
__mptcp_data_acked() to __mptcp_clean_una(), under the msk socket
lock, where such call would belong.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c  |  2 +-
 net/mptcp/protocol.c | 15 +++++++--------
 net/mptcp/protocol.h |  2 +-
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 5e2b130d8680..9b31a0a06265 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1060,7 +1060,7 @@ static void ack_update_msk(struct mptcp_sock *msk,
 		msk->wnd_end = new_wnd_end;
 
 	/* this assumes mptcp_incoming_options() is invoked after tcp_ack() */
-	if (after64(msk->wnd_end, READ_ONCE(msk->snd_nxt)))
+	if (after64(msk->wnd_end, snd_nxt))
 		__mptcp_check_push(sk, ssk);
 
 	if (after64(new_snd_una, old_snd_una)) {
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 874f019c5093..b1c24ac3630f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1033,13 +1033,15 @@ static void __mptcp_clean_una(struct sock *sk)
 		msk->recovery = false;
 
 out:
-	if (snd_una == READ_ONCE(msk->snd_nxt) &&
-	    snd_una == READ_ONCE(msk->write_seq)) {
+	if (snd_una == msk->snd_nxt && snd_una == msk->write_seq) {
 		if (mptcp_rtx_timer_pending(sk) && !mptcp_data_fin_enabled(msk))
 			mptcp_stop_rtx_timer(sk);
 	} else {
 		mptcp_reset_rtx_timer(sk);
 	}
+
+	if (mptcp_pending_data_fin_ack(sk))
+		mptcp_schedule_work(sk);
 }
 
 static void __mptcp_clean_una_wakeup(struct sock *sk)
@@ -1499,7 +1501,7 @@ static void mptcp_update_post_push(struct mptcp_sock *msk,
 	 */
 	if (likely(after64(snd_nxt_new, msk->snd_nxt))) {
 		msk->bytes_sent += snd_nxt_new - msk->snd_nxt;
-		msk->snd_nxt = snd_nxt_new;
+		WRITE_ONCE(msk->snd_nxt, snd_nxt_new);
 	}
 }
 
@@ -3200,8 +3202,8 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 	if (mp_opt->suboptions & OPTION_MPTCP_CSUMREQD)
 		WRITE_ONCE(msk->csum_enabled, true);
 
-	msk->write_seq = subflow_req->idsn + 1;
-	msk->snd_nxt = msk->write_seq;
+	WRITE_ONCE(msk->write_seq, subflow_req->idsn + 1);
+	WRITE_ONCE(msk->snd_nxt, msk->write_seq);
 	msk->snd_una = msk->write_seq;
 	msk->wnd_end = msk->snd_nxt + req->rsk_rcv_wnd;
 	msk->setsockopt_seq = mptcp_sk(sk)->setsockopt_seq;
@@ -3303,9 +3305,6 @@ void __mptcp_data_acked(struct sock *sk)
 		__mptcp_clean_una(sk);
 	else
 		__set_bit(MPTCP_CLEAN_UNA, &mptcp_sk(sk)->cb_flags);
-
-	if (mptcp_pending_data_fin_ack(sk))
-		mptcp_schedule_work(sk);
 }
 
 void __mptcp_check_push(struct sock *sk, struct sock *ssk)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 13b8cf8ec704..421dede93e2b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -402,7 +402,7 @@ static inline struct mptcp_data_frag *mptcp_rtx_head(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
-	if (msk->snd_una == READ_ONCE(msk->snd_nxt))
+	if (msk->snd_una == msk->snd_nxt)
 		return NULL;
 
 	return list_first_entry_or_null(&msk->rtx_queue, struct mptcp_data_frag, list);

-- 
2.43.0


