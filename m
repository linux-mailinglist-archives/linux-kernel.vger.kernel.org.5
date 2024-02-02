Return-Path: <linux-kernel+bounces-49776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7556E846F3E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C7E3293B02
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED5A145340;
	Fri,  2 Feb 2024 11:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sS35dn3G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F395145326;
	Fri,  2 Feb 2024 11:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706874025; cv=none; b=gvynJGbHpe+mP34EsSYdF87fpIJoNhK5+a2qq31ROq2hfRaR8507sT91IB9hnWcCBpLEu+18prPOTy8cxi6zhvcPLDr9uYl/A2/wnwhNO2y1G61F1SjFmtvLsLjrS8PSQaGOvNfk7JvuTTyC2b346brE2eDTjVmrjaRyMMbtsvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706874025; c=relaxed/simple;
	bh=NizLa/rzuw+1XgtkX7T+tjMOuMLxy4qTjak2ZKxBBB4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vg8rjFcehtRo5Q0zP3bPBIQPLl/R/gJM1FpNwlip1XsQSSCFzbAYMIweXzOHpeGO54HzsNTpHIowu/OCgbRaRLR/haVp0nl6gGtfL3GZRstQxRmmBcPB3Zb1Qm3vUz2/GxHhKeNfuFxlty9iscNGQf7f98acObBKQPjdMK76ddk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sS35dn3G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA57C43394;
	Fri,  2 Feb 2024 11:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706874025;
	bh=NizLa/rzuw+1XgtkX7T+tjMOuMLxy4qTjak2ZKxBBB4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sS35dn3GfZ3NAUVFNO1sYHY3vdND4ZhzohGSUBkVpIr+EiyEoQlr83u0vRcEE9nuL
	 b4H3eHuzP5nGE6KfL7fIwMZwB9CZzECFQCuUqjTFbu7i8iZkWFzYg8wfgvmAabhmOJ
	 15Nt6mnazaYbLqImE0zBlXgPt7+Z9ZN24ruEOMRop5zuIWRhFe/G4FwSDal4t/Wk/b
	 qUIxtsKvkdEyeRkjtKyaCSrFDil2FH6BVx3liO94jXBVXMUdb4+WYmp2sbnIUM1bAG
	 W1b9qLeHcDoioyDUAgoo4gcm241xouE8rS2KylQLXFdBr5qG1KmVH2Fttzf9R7/+H+
	 QxRCbSJOEg+3g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 02 Feb 2024 12:40:09 +0100
Subject: [PATCH net-next 3/5] mptcp: annotate lockless access for RX path
 fields
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240202-upstream-net-next-20240202-mptcp-annotate-lockless-access-v1-3-031d6680afdc@kernel.org>
References: <20240202-upstream-net-next-20240202-mptcp-annotate-lockless-access-v1-0-031d6680afdc@kernel.org>
In-Reply-To: <20240202-upstream-net-next-20240202-mptcp-annotate-lockless-access-v1-0-031d6680afdc@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang.tang@linux.dev>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=4841; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ZorjGDFuRUMjEvA3t02IR2AVaAgagTO7avy9WKwC/u0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlvNSeOR5zPgpyWCXq5b7TWqTECM1pKsPLCrGxZ
 MOwzP6M1SaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZbzUngAKCRD2t4JPQmmg
 cyY8EACZIVq7G5mYaqJgirKzI5pndhJk3btBITCu5Q9/hfZ2QYOWFL1Qm9ibWXjS5ivb4Hs/sGr
 SjmkkXQnnfRRAbwmZp/yttf2NRWsFVsXgHPU+TDAnSOo2tWFEBAxyKUI35DQR1MmaOo1vDM6J7P
 qo3bl+qFs1siiyNxxR5MdDq5MKx8ylieb86yl1+PH4r6x/cTXFIE6+Ag2/7lhmYT+jIrgd4ULxa
 +jfPL6LFjKXhEDM9tImO2D4FopoAt298tdPVGEXoIyXlRrWbNubWllT8l0+hP68tG0zCjU0Apu8
 5VC82anLrY5jS6/UzIbHK746r43bd5RssjV0Fh9olK4xaItQqbxcdxg3cNevN7dfdOCMvkaHoa4
 iFA7fntpctqVeXbRl8kVki9uSHndG/KDg3tI2Z/JeI5lQpCxfANHlXbEkjuiXjEKB4AG31pWw+0
 IfJNSsX+2reyL52Y5x/q4oguzTuedSBd1a9Bbe/J3cBB9E8ySU4xvP4t/x/yg9Y0fLbqtBNlbvE
 uzpcLiV55azcHwVv/KNRKVdWgACPjCEmJbvnVIOcCZ8GHeoqhdYQB6JObYp4EfhWlGJlJ6MVZ5f
 QYJjxw/x0gQQIgFRSPd+iQPPq2AchmOzSWhD8q3vX4x2kmc9jTYMme7H5s02BAdl2wu7mZZsswW
 53f7o9sny7P84Ow==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

The following fields:

 - ack_seq
 - snd_una
 - wnd_end
 - rmem_fwd_alloc

are protected by the data lock end accessed lockless in a few
spots. Ensure ONCE annotation for write (under such lock) and for
lockless read.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c  |  6 +++---
 net/mptcp/protocol.c | 19 +++++++++++--------
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 9b31a0a06265..801a3525230d 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1030,7 +1030,7 @@ u64 __mptcp_expand_seq(u64 old_seq, u64 cur_seq)
 static void __mptcp_snd_una_update(struct mptcp_sock *msk, u64 new_snd_una)
 {
 	msk->bytes_acked += new_snd_una - msk->snd_una;
-	msk->snd_una = new_snd_una;
+	WRITE_ONCE(msk->snd_una, new_snd_una);
 }
 
 static void ack_update_msk(struct mptcp_sock *msk,
@@ -1057,7 +1057,7 @@ static void ack_update_msk(struct mptcp_sock *msk,
 	new_wnd_end = new_snd_una + tcp_sk(ssk)->snd_wnd;
 
 	if (after64(new_wnd_end, msk->wnd_end))
-		msk->wnd_end = new_wnd_end;
+		WRITE_ONCE(msk->wnd_end, new_wnd_end);
 
 	/* this assumes mptcp_incoming_options() is invoked after tcp_ack() */
 	if (after64(msk->wnd_end, snd_nxt))
@@ -1071,7 +1071,7 @@ static void ack_update_msk(struct mptcp_sock *msk,
 
 	trace_ack_update_msk(mp_opt->data_ack,
 			     old_snd_una, new_snd_una,
-			     new_wnd_end, msk->wnd_end);
+			     new_wnd_end, READ_ONCE(msk->wnd_end));
 }
 
 bool mptcp_update_rcv_data_fin(struct mptcp_sock *msk, u64 data_fin_seq, bool use_64bit)
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b1c24ac3630f..90804e7fb7f6 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -410,6 +410,7 @@ static void mptcp_close_wake_up(struct sock *sk)
 		sk_wake_async(sk, SOCK_WAKE_WAITD, POLL_IN);
 }
 
+/* called under the msk socket lock */
 static bool mptcp_pending_data_fin_ack(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
@@ -441,16 +442,17 @@ static void mptcp_check_data_fin_ack(struct sock *sk)
 	}
 }
 
+/* can be called with no lock acquired */
 static bool mptcp_pending_data_fin(struct sock *sk, u64 *seq)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
 	if (READ_ONCE(msk->rcv_data_fin) &&
-	    ((1 << sk->sk_state) &
+	    ((1 << inet_sk_state_load(sk)) &
 	     (TCPF_ESTABLISHED | TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2))) {
 		u64 rcv_data_fin_seq = READ_ONCE(msk->rcv_data_fin_seq);
 
-		if (msk->ack_seq == rcv_data_fin_seq) {
+		if (READ_ONCE(msk->ack_seq) == rcv_data_fin_seq) {
 			if (seq)
 				*seq = rcv_data_fin_seq;
 
@@ -748,7 +750,7 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
 			__skb_queue_tail(&sk->sk_receive_queue, skb);
 		}
 		msk->bytes_received += end_seq - msk->ack_seq;
-		msk->ack_seq = end_seq;
+		WRITE_ONCE(msk->ack_seq, end_seq);
 		moved = true;
 	}
 	return moved;
@@ -985,6 +987,7 @@ static void dfrag_clear(struct sock *sk, struct mptcp_data_frag *dfrag)
 	put_page(dfrag->page);
 }
 
+/* called under both the msk socket lock and the data lock */
 static void __mptcp_clean_una(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
@@ -2110,7 +2113,7 @@ static unsigned int mptcp_inq_hint(const struct sock *sk)
 
 	skb = skb_peek(&msk->receive_queue);
 	if (skb) {
-		u64 hint_val = msk->ack_seq - MPTCP_SKB_CB(skb)->map_seq;
+		u64 hint_val = READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;
 
 		if (hint_val >= INT_MAX)
 			return INT_MAX;
@@ -2754,7 +2757,7 @@ static void __mptcp_init_sock(struct sock *sk)
 	__skb_queue_head_init(&msk->receive_queue);
 	msk->out_of_order_queue = RB_ROOT;
 	msk->first_pending = NULL;
-	msk->rmem_fwd_alloc = 0;
+	WRITE_ONCE(msk->rmem_fwd_alloc, 0);
 	WRITE_ONCE(msk->rmem_released, 0);
 	msk->timer_ival = TCP_RTO_MIN;
 	msk->scaling_ratio = TCP_DEFAULT_SCALING_RATIO;
@@ -2970,7 +2973,7 @@ static void __mptcp_destroy_sock(struct sock *sk)
 
 	sk->sk_prot->destroy(sk);
 
-	WARN_ON_ONCE(msk->rmem_fwd_alloc);
+	WARN_ON_ONCE(READ_ONCE(msk->rmem_fwd_alloc));
 	WARN_ON_ONCE(msk->rmem_released);
 	sk_stream_kill_queues(sk);
 	xfrm_sk_free_policy(sk);
@@ -3204,8 +3207,8 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 
 	WRITE_ONCE(msk->write_seq, subflow_req->idsn + 1);
 	WRITE_ONCE(msk->snd_nxt, msk->write_seq);
-	msk->snd_una = msk->write_seq;
-	msk->wnd_end = msk->snd_nxt + req->rsk_rcv_wnd;
+	WRITE_ONCE(msk->snd_una, msk->write_seq);
+	WRITE_ONCE(msk->wnd_end, msk->snd_nxt + req->rsk_rcv_wnd);
 	msk->setsockopt_seq = mptcp_sk(sk)->setsockopt_seq;
 	mptcp_init_sched(msk, mptcp_sk(sk)->sched);
 

-- 
2.43.0


