Return-Path: <linux-kernel+bounces-58506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF3784E747
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 753571F25611
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98E086AC7;
	Thu,  8 Feb 2024 18:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pjY24xFu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191377EF0C;
	Thu,  8 Feb 2024 18:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707415467; cv=none; b=WYkh4tyLmxkaE3vpQ+xgJMvfNrQR4cSRy5aT6UANiLfbXz194yBqLhbgB9XzyU/J5/35xJJi/t3xudJQHfmu1/6I6LWHS/c59Ua30gsmERe/b0fC/JVxI+vIYMqH78f8BWWm/UxxJvq17rEVUiDAtDUQHu6752Ql19eddF09GMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707415467; c=relaxed/simple;
	bh=aCkDCXwukiBM5j5kejbQN2B8zljH82fF79qIsFgXzX4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZDy1Uum7HY7B0qPTVjhBEJ+yiDJiHczWh/m1eYVfTtokP2y2lLBS/fEGjuf4ksO5DYGPArO6FgHWVnxKJT0S5+2hYi8q1h1ptEomtGE6ACsoBOBTNAFEvgZCzQOPHy/je4GbGvoITFQ5OimgSbQNvYRElbNc1afDdsR0OOOaPvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pjY24xFu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F27C43399;
	Thu,  8 Feb 2024 18:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707415465;
	bh=aCkDCXwukiBM5j5kejbQN2B8zljH82fF79qIsFgXzX4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pjY24xFu5QFgFKifBfG38/ntMpu0Ur8UUbSe1VEC8CHTfbHrdhmAMNErDKuCPSCKS
	 APOTtShusS/XEmzKA8L1HVZJ63di5hFgd87KBrHRTKFgGWnICywPOcD8LMWN82v1SG
	 zcnuIwK/CLql/2N2zcAEgRdT38Z96hxJNkqKj33xf/OK1SIO7/b/2aYcHb+L8BQGPz
	 Lt5mU/11n/rKaXxf559r2us+mLxvlytjfEt0AiAibT6AL/x1H0WgIMC+760+lBk2xT
	 xW0bfXPqT8VwhaSDd4bac6qfzURqd2bxZpPZb0FG9J8Vxy2bqiGycwz3GgW9y0BHAB
	 528p1DvrtJqNQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 08 Feb 2024 19:03:49 +0100
Subject: [PATCH net 1/7] mptcp: drop the push_pending field
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240208-upstream-net-20240202-locking-cleanup-misc-v1-1-f75cc5b97e5a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2836; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=HEDW7t9+sgzNCTV35HeaMf5YyIAJ9ktNnQ5iSir6dlM=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlxRehSt3z1Z3KCCwjZLMPz6FGmixn5dnhvqtlU
 zvLUCOt2+6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZcUXoQAKCRD2t4JPQmmg
 c0/HEADl4pEhwaSENKVzRBXH7QSm67bmWcAFJhCjxhkHieOzw4l5UJctY7QkbO/ybGekG9AUzEw
 fRCb13mCzt795fiGeWBgSNx65swXRnkD4M/UvAMsDRDaxZPUi79NHBpEUqipCav+aFygp8iEdTm
 wmZrfWFQjP3NZVRlU77RJbH5LMk8BUwT1xzSHFBaY54im9o8XBmnujHZfDglWLVNbtv4WbjRn4/
 9lR5lZhEt4iZom8J7GpS9UEx8Sg4eMDrImHxYUCLHV7YkcUEkeoX1duFsNBb1gtyBFm0+sSyvNt
 s+zrGY708M4yteyrNCJdNNnodh02DCtoCvPMRYDNDY+PMbEcp+FqFBPvH7BA0ZAGO6COijp+W8i
 p1AqZI0fi+Txj5BN1pylGsxc080z9M9Fx1FeEhEWRbaqsQulCJ2M+V81nQYuXyiOpXHu0ZaF8et
 IaJjfqxoCZhYKZbaEsrO/isNKLJji0HlXiHvGAQzj/8kvjY3l4K0sUIcJTvYzSOO7I8pfpnoA6m
 gZ8fNiin9+1B3ZIkiNzPHFTtMQ89daStKGqUbzuPDrPQkOjlEc2OltAp3nU7zKlaJEhw5wxkmNx
 loj/ETz1jTzDrKMicuYM4Gahxsh8csazEdqrEwZqYdXERZDJylzkpQyCq9AKEgb1F8iDmUUsTgw
 8gZ+RuHJ6yvaVTg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

Such field is there to avoid acquiring the data lock in a few spots,
but it adds complexity to the already non trivial locking schema.

All the relevant call sites (mptcp-level re-injection, set socket
options), are slow-path, drop such field in favor of 'cb_flags', adding
the relevant locking.

This patch could be seen as an improvement, instead of a fix. But it
simplifies the next patch. The 'Fixes' tag has been added to help having
this series backported to stable.

Fixes: e9d09baca676 ("mptcp: avoid atomic bit manipulation when possible")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 12 ++++++------
 net/mptcp/protocol.h |  1 -
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 028e8b473626..2111819016af 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1505,8 +1505,11 @@ static void mptcp_update_post_push(struct mptcp_sock *msk,
 
 void mptcp_check_and_set_pending(struct sock *sk)
 {
-	if (mptcp_send_head(sk))
-		mptcp_sk(sk)->push_pending |= BIT(MPTCP_PUSH_PENDING);
+	if (mptcp_send_head(sk)) {
+		mptcp_data_lock(sk);
+		mptcp_sk(sk)->cb_flags |= BIT(MPTCP_PUSH_PENDING);
+		mptcp_data_unlock(sk);
+	}
 }
 
 static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
@@ -3142,7 +3145,6 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	mptcp_destroy_common(msk, MPTCP_CF_FASTCLOSE);
 	WRITE_ONCE(msk->flags, 0);
 	msk->cb_flags = 0;
-	msk->push_pending = 0;
 	msk->recovery = false;
 	msk->can_ack = false;
 	msk->fully_established = false;
@@ -3330,8 +3332,7 @@ static void mptcp_release_cb(struct sock *sk)
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
 	for (;;) {
-		unsigned long flags = (msk->cb_flags & MPTCP_FLAGS_PROCESS_CTX_NEED) |
-				      msk->push_pending;
+		unsigned long flags = (msk->cb_flags & MPTCP_FLAGS_PROCESS_CTX_NEED);
 		struct list_head join_list;
 
 		if (!flags)
@@ -3347,7 +3348,6 @@ static void mptcp_release_cb(struct sock *sk)
 		 *    datapath acquires the msk socket spinlock while helding
 		 *    the subflow socket lock
 		 */
-		msk->push_pending = 0;
 		msk->cb_flags &= ~flags;
 		spin_unlock_bh(&sk->sk_lock.slock);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3517f2d24a22..b905f1868298 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -286,7 +286,6 @@ struct mptcp_sock {
 	int		rmem_released;
 	unsigned long	flags;
 	unsigned long	cb_flags;
-	unsigned long	push_pending;
 	bool		recovery;		/* closing subflow write queue reinjected */
 	bool		can_ack;
 	bool		fully_established;

-- 
2.43.0


