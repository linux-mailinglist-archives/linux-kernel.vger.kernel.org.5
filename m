Return-Path: <linux-kernel+bounces-58509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C96DE84E750
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE7301C272DA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6533412839B;
	Thu,  8 Feb 2024 18:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="htSrZhK+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475B5128370;
	Thu,  8 Feb 2024 18:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707415477; cv=none; b=i0ublDuiRgGX0QUJ6w21UD2ofHHL84AfHe+Q+mwAiIRubnr6Jgrh8EOUq6ZGNel6M43k3NOj15t3yp4Q1wSI5+DmatduVFFsv0phuFO7xOXcl79DXF9PyW2Fuj9G/qqd96wm9MZcI+Wd1IZgtprgMPyWSa45EAF0kMbk9EdSdSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707415477; c=relaxed/simple;
	bh=B1tpBpXayfv5C4oprtq3aWGfISdNpEH0s3KkYlXv0Sw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DjHb/8kwslhysyG6hO3fI7H8JbZ0e2l+ROJvjMe6M523aKiheJ1uX/NpjNn80msHyvrOPkulxCQKiotyYYurT6sSDRL4oKrNmm5bUSQp+0heS9T3qTskJv5uTbtwOPQHH3QXzA/BUdS7E2AvM4BWQpA75ahNS/SVKVWfhl9o66I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=htSrZhK+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD07EC43141;
	Thu,  8 Feb 2024 18:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707415477;
	bh=B1tpBpXayfv5C4oprtq3aWGfISdNpEH0s3KkYlXv0Sw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=htSrZhK+EtWBFCu0hz+Y+TgNYG5/0v0aWvvrXeZ9e2ja4D/mms7icHR2nf+dJe9P2
	 fEBR3e0so03OpHNeAynxXIYZRIpkRCUSfwwpyZpnrKExde06W/UPuvbDKDrKIsseZ9
	 izHvD7r65Dw6VDSrZcOI4sp9hhBLjbFVhh1eQLTg2yxJsFpncTPhAXV3bkhuxHT1Cn
	 LFQbjwrZESGA47VCPwkKWckHMZLkk/ttaQ043+zQH5E5X/T+j30JPFVjoymG6rNObl
	 bDjJMjKAlpXVIHhjq2O5OUTKYda280CQl0oq8RLFyKb4G49Bip/e8uDnxvU85ybdU+
	 hHWxuAJF1Xwqg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 08 Feb 2024 19:03:52 +0100
Subject: [PATCH net 4/7] mptcp: corner case locking for rx path fields
 initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240208-upstream-net-20240202-locking-cleanup-misc-v1-4-f75cc5b97e5a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10427; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=g0Rw4HDgt4Q54yco1/zI46zEx1HU/dDMukldMNg3NEA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlxRehXO9RcQy3GoVM7sF5g2ZeamRGhQnQUBe/g
 ix2f8nSFaCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZcUXoQAKCRD2t4JPQmmg
 c7/UD/9Dk4T6iEx+rbCfwt7OBN99/BeeKn5R499gV2z1y+5jjMQB+pl8XiHhSxG7v2df1wxKsyD
 sXA4JbKblzdMCvY/GzO/Xf/3TG1xdBj5xKY6EWbJkECEg2ln02vbewhqGdRBXmAMWCMPpjk+uiz
 0NmRVWNE9I8E320+7ayfK3E8ojbURpR4xm0ZgNdQIpJGSeN4gu13aVx6IW4wwUrrqkY30kYR0dB
 si8XouRhGSZWnmGUb4Hxp+hCX7OxBH85R5GMTdtcav+vdcUVkOG2WfmsRh1ddE+iACwi6Dkzo69
 Vn0H2dj26co/oHBt1WhQABF0KsyS9OTp1VcG7DqU+bhPrRM6bF8YP/710F0wIUOZe9SbZ8oAZin
 ubiPueUqPmPuIT2G+nBlPx0XD1EeHkriv3If+lwjbd/2+SYD7WBx19kaArfwF2PBoBI0kDhoer9
 FYRoZpzqSZ4yh+4bJr7hsaJIJ6KQP6nmY8YyGb7DA7GrQR9P55Gdd0hllaD5/xleauPW5qYTSYT
 kmgGJhI+eBaYUrK1TMP5qmkEm9kQAmdNxz/7PwIoNjhA9JF/ZdDLIgC/HnzYjHjcLaat9FbTmRo
 3cpdJArRTMz2q7G5/rbWm70L6QcYgygejeIegHsKeSGP2k7NjCdCJUy7GBVIyxwZuf1+IsfqRuC
 Raz348oDvPYW55w==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

Most MPTCP-level related fields are under the mptcp data lock
protection, but are written one-off without such lock at MPC
complete time, both for the client and the server

Leverage the mptcp_propagate_state() infrastructure to move such
initialization under the proper lock client-wise.

The server side critical init steps are done by
mptcp_subflow_fully_established(): ensure the caller properly held the
relevant lock, and avoid acquiring the same lock in the nested scopes.

There are no real potential races, as write access to such fields
is implicitly serialized by the MPTCP state machine; the primary
goal is consistency.

Fixes: d22f4988ffec ("mptcp: process MP_CAPABLE data option")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/fastopen.c |  6 ++----
 net/mptcp/options.c  |  9 +++++----
 net/mptcp/protocol.c |  9 ++++++---
 net/mptcp/protocol.h |  9 +++++----
 net/mptcp/subflow.c  | 56 ++++++++++++++++++++++++++++++----------------------
 5 files changed, 50 insertions(+), 39 deletions(-)

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index 74698582a285..ad28da655f8b 100644
--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -59,13 +59,12 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
 	mptcp_data_unlock(sk);
 }
 
-void mptcp_fastopen_gen_msk_ackseq(struct mptcp_sock *msk, struct mptcp_subflow_context *subflow,
-				   const struct mptcp_options_received *mp_opt)
+void __mptcp_fastopen_gen_msk_ackseq(struct mptcp_sock *msk, struct mptcp_subflow_context *subflow,
+				     const struct mptcp_options_received *mp_opt)
 {
 	struct sock *sk = (struct sock *)msk;
 	struct sk_buff *skb;
 
-	mptcp_data_lock(sk);
 	skb = skb_peek_tail(&sk->sk_receive_queue);
 	if (skb) {
 		WARN_ON_ONCE(MPTCP_SKB_CB(skb)->end_seq);
@@ -77,5 +76,4 @@ void mptcp_fastopen_gen_msk_ackseq(struct mptcp_sock *msk, struct mptcp_subflow_
 	}
 
 	pr_debug("msk=%p ack_seq=%llx", msk, msk->ack_seq);
-	mptcp_data_unlock(sk);
 }
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index d2527d189a79..e3e96a49f922 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -962,9 +962,7 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 		/* subflows are fully established as soon as we get any
 		 * additional ack, including ADD_ADDR.
 		 */
-		subflow->fully_established = 1;
-		WRITE_ONCE(msk->fully_established, true);
-		goto check_notify;
+		goto set_fully_established;
 	}
 
 	/* If the first established packet does not contain MP_CAPABLE + data
@@ -986,7 +984,10 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 set_fully_established:
 	if (unlikely(!READ_ONCE(msk->pm.server_side)))
 		pr_warn_once("bogus mpc option on established client sk");
-	mptcp_subflow_fully_established(subflow, mp_opt);
+
+	mptcp_data_lock((struct sock *)msk);
+	__mptcp_subflow_fully_established(msk, subflow, mp_opt);
+	mptcp_data_unlock((struct sock *)msk);
 
 check_notify:
 	/* if the subflow is not already linked into the conn_list, we can't
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 8cb6a873dae9..8ef2927ebca2 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3186,6 +3186,7 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 {
 	struct mptcp_subflow_request_sock *subflow_req = mptcp_subflow_rsk(req);
 	struct sock *nsk = sk_clone_lock(sk, GFP_ATOMIC);
+	struct mptcp_subflow_context *subflow;
 	struct mptcp_sock *msk;
 
 	if (!nsk)
@@ -3226,7 +3227,8 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 
 	/* The msk maintain a ref to each subflow in the connections list */
 	WRITE_ONCE(msk->first, ssk);
-	list_add(&mptcp_subflow_ctx(ssk)->node, &msk->conn_list);
+	subflow = mptcp_subflow_ctx(ssk);
+	list_add(&subflow->node, &msk->conn_list);
 	sock_hold(ssk);
 
 	/* new mpc subflow takes ownership of the newly
@@ -3241,6 +3243,9 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 	__mptcp_propagate_sndbuf(nsk, ssk);
 
 	mptcp_rcv_space_init(msk, ssk);
+
+	if (mp_opt->suboptions & OPTION_MPTCP_MPC_ACK)
+		__mptcp_subflow_fully_established(msk, subflow, mp_opt);
 	bh_unlock_sock(nsk);
 
 	/* note: the newly allocated socket refcount is 2 now */
@@ -3478,8 +3483,6 @@ void mptcp_finish_connect(struct sock *ssk)
 	 * accessing the field below
 	 */
 	WRITE_ONCE(msk->local_key, subflow->local_key);
-	WRITE_ONCE(msk->snd_una, subflow->idsn + 1);
-	WRITE_ONCE(msk->wnd_end, subflow->idsn + 1 + tcp_sk(ssk)->snd_wnd);
 
 	mptcp_pm_new_connection(msk, ssk, 0);
 }
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 9f5ee82e3473..fefcbf585411 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -622,8 +622,9 @@ unsigned int mptcp_stale_loss_cnt(const struct net *net);
 unsigned int mptcp_close_timeout(const struct sock *sk);
 int mptcp_get_pm_type(const struct net *net);
 const char *mptcp_get_scheduler(const struct net *net);
-void mptcp_subflow_fully_established(struct mptcp_subflow_context *subflow,
-				     const struct mptcp_options_received *mp_opt);
+void __mptcp_subflow_fully_established(struct mptcp_sock *msk,
+				       struct mptcp_subflow_context *subflow,
+				       const struct mptcp_options_received *mp_opt);
 bool __mptcp_retransmit_pending_data(struct sock *sk);
 void mptcp_check_and_set_pending(struct sock *sk);
 void __mptcp_push_pending(struct sock *sk, unsigned int flags);
@@ -952,8 +953,8 @@ void mptcp_event_pm_listener(const struct sock *ssk,
 			     enum mptcp_event_type event);
 bool mptcp_userspace_pm_active(const struct mptcp_sock *msk);
 
-void mptcp_fastopen_gen_msk_ackseq(struct mptcp_sock *msk, struct mptcp_subflow_context *subflow,
-				   const struct mptcp_options_received *mp_opt);
+void __mptcp_fastopen_gen_msk_ackseq(struct mptcp_sock *msk, struct mptcp_subflow_context *subflow,
+				     const struct mptcp_options_received *mp_opt);
 void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subflow,
 					      struct request_sock *req);
 
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index c2df34ebcf28..c34ecadee120 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -441,20 +441,6 @@ void __mptcp_sync_state(struct sock *sk, int state)
 	}
 }
 
-static void mptcp_propagate_state(struct sock *sk, struct sock *ssk)
-{
-	struct mptcp_sock *msk = mptcp_sk(sk);
-
-	mptcp_data_lock(sk);
-	if (!sock_owned_by_user(sk)) {
-		__mptcp_sync_state(sk, ssk->sk_state);
-	} else {
-		msk->pending_state = ssk->sk_state;
-		__set_bit(MPTCP_SYNC_STATE, &msk->cb_flags);
-	}
-	mptcp_data_unlock(sk);
-}
-
 static void subflow_set_remote_key(struct mptcp_sock *msk,
 				   struct mptcp_subflow_context *subflow,
 				   const struct mptcp_options_received *mp_opt)
@@ -476,6 +462,31 @@ static void subflow_set_remote_key(struct mptcp_sock *msk,
 	atomic64_set(&msk->rcv_wnd_sent, subflow->iasn);
 }
 
+static void mptcp_propagate_state(struct sock *sk, struct sock *ssk,
+				  struct mptcp_subflow_context *subflow,
+				  const struct mptcp_options_received *mp_opt)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+
+	mptcp_data_lock(sk);
+	if (mp_opt) {
+		/* Options are available only in the non fallback cases
+		 * avoid updating rx path fields otherwise
+		 */
+		WRITE_ONCE(msk->snd_una, subflow->idsn + 1);
+		WRITE_ONCE(msk->wnd_end, subflow->idsn + 1 + tcp_sk(ssk)->snd_wnd);
+		subflow_set_remote_key(msk, subflow, mp_opt);
+	}
+
+	if (!sock_owned_by_user(sk)) {
+		__mptcp_sync_state(sk, ssk->sk_state);
+	} else {
+		msk->pending_state = ssk->sk_state;
+		__set_bit(MPTCP_SYNC_STATE, &msk->cb_flags);
+	}
+	mptcp_data_unlock(sk);
+}
+
 static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
@@ -510,10 +521,9 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 		if (mp_opt.deny_join_id0)
 			WRITE_ONCE(msk->pm.remote_deny_join_id0, true);
 		subflow->mp_capable = 1;
-		subflow_set_remote_key(msk, subflow, &mp_opt);
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPCAPABLEACTIVEACK);
 		mptcp_finish_connect(sk);
-		mptcp_propagate_state(parent, sk);
+		mptcp_propagate_state(parent, sk, subflow, &mp_opt);
 	} else if (subflow->request_join) {
 		u8 hmac[SHA256_DIGEST_SIZE];
 
@@ -556,7 +566,7 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 		}
 	} else if (mptcp_check_fallback(sk)) {
 fallback:
-		mptcp_propagate_state(parent, sk);
+		mptcp_propagate_state(parent, sk, subflow, NULL);
 	}
 	return;
 
@@ -741,17 +751,16 @@ void mptcp_subflow_drop_ctx(struct sock *ssk)
 	kfree_rcu(ctx, rcu);
 }
 
-void mptcp_subflow_fully_established(struct mptcp_subflow_context *subflow,
-				     const struct mptcp_options_received *mp_opt)
+void __mptcp_subflow_fully_established(struct mptcp_sock *msk,
+				       struct mptcp_subflow_context *subflow,
+				       const struct mptcp_options_received *mp_opt)
 {
-	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
-
 	subflow_set_remote_key(msk, subflow, mp_opt);
 	subflow->fully_established = 1;
 	WRITE_ONCE(msk->fully_established, true);
 
 	if (subflow->is_mptfo)
-		mptcp_fastopen_gen_msk_ackseq(msk, subflow, mp_opt);
+		__mptcp_fastopen_gen_msk_ackseq(msk, subflow, mp_opt);
 }
 
 static struct sock *subflow_syn_recv_sock(const struct sock *sk,
@@ -844,7 +853,6 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 			 * mpc option
 			 */
 			if (mp_opt.suboptions & OPTION_MPTCP_MPC_ACK) {
-				mptcp_subflow_fully_established(ctx, &mp_opt);
 				mptcp_pm_fully_established(owner, child);
 				ctx->pm_notified = 1;
 			}
@@ -1756,7 +1764,7 @@ static void subflow_state_change(struct sock *sk)
 		mptcp_do_fallback(sk);
 		pr_fallback(msk);
 		subflow->conn_finished = 1;
-		mptcp_propagate_state(parent, sk);
+		mptcp_propagate_state(parent, sk, subflow, NULL);
 	}
 
 	/* as recvmsg() does not acquire the subflow socket for ssk selection

-- 
2.43.0


