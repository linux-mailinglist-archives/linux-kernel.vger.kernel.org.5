Return-Path: <linux-kernel+bounces-58508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D66EA84E755
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADBB1B27ED9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E3C127B51;
	Thu,  8 Feb 2024 18:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XgTGszmx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26AA1272D0;
	Thu,  8 Feb 2024 18:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707415473; cv=none; b=DFOTLBnaELzmalUXhQaba24NkPcs2eeu13GpFT30PE0N/EONLX9fbFZqNeuyjVW5g7NDCgwFATyxTWmFNV7P1uTUwS/mTGLTTRj+fG6PdLaCuDC2UT8LuKCyoflar8vGp328En2A2k34ndy/+hFNIXvyZDEy4SzlzivlwJaUz1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707415473; c=relaxed/simple;
	bh=yHJvs4che6WyhYHzxH8wT4v6HXxxwDmE2feB06/a0QY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZjdbcoLH/sI9CqBMT0MHRx50sftmfYjbbWSsZ4ERbd4FOeBd3zznCA8TLmHsWCn8B+VF8O+mbnX2u95CC5IRtXh0gK0rmBpCBV9VTCsqrGiHCOuUM3s2mScRQ5lNr5lneFgWX0l7AQMXmknY0YFbX0Wv3S+dpjpVKQB7RvfY8hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XgTGszmx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA1A0C43390;
	Thu,  8 Feb 2024 18:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707415473;
	bh=yHJvs4che6WyhYHzxH8wT4v6HXxxwDmE2feB06/a0QY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XgTGszmxQE3Wk32I7duZggjSPhqW9GNMht/S90Hhce0HOgMMHTmCh5iagf56vS/RQ
	 lsZwnH+UjSh+9IT3ANTzDVZlhgnzBh9zs9XiOoknlEZklSFA7SjGWUOJZZVm6VrhC3
	 gkSlatMe561yStwVPFXfsmaPDASjbNC3vOtwoaAudkjDLZZi+oME5s5VAYZNn83MCM
	 DkFRtvUtsjld5/Ifxyh0KsqB+UJ5WMgOQJ9hQKAbxNkka6TMaS5xQrL7R1w1pjEfUs
	 ufGPyojuVBURq4kQe5Mzs3oLsIAVxjFFLNdOZ+rxa3oVyfpDdXBAwnnBzffx3Dz4t6
	 KnGsKJJV74ueQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 08 Feb 2024 19:03:51 +0100
Subject: [PATCH net 3/7] mptcp: fix more tx path fields initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240208-upstream-net-20240202-locking-cleanup-misc-v1-3-f75cc5b97e5a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2392; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=BH9JwtYC2RN/3BDjjpe9vHZJy5WVFOfYRfxZhvGrfHM=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlxRehoTpOkhQagMNL0KqONyCoHfQC3+GgB+o7X
 hLmr9ahZ5KJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZcUXoQAKCRD2t4JPQmmg
 c6QsD/9+sUDZ1mdnC9h189TtEe7cUCxjSjCf2hgQZ6q5p9UWmq8m/CkIkxsyi0S37ONi2QSE/sq
 kDVg0zfgcA3HnVdGJYZ219wpOWcSTT5O6TPAot3vre7gzOFtIiiHXK0QfpuhTquTQC697z4IUIh
 LhBpYK6uoDZH6ezQje3PKwddcA5v3XGtCQgEfUJRfn8+pbhFcZzsUZlyxhHFHRsO1hQJohYZon8
 CRfdsk8BXLvyJODr6zpN/A/BzxJYk1eOFfn1TegSKHGVYBJ/QxKT34uxw8l5p5AHojkvp8BP5yW
 t2ozFgG4qcKOp/28LzMPCmszncJKvXWLluI03czeiu5GefBw7tVkEFZr1NMBZvIPoDDoa5Hw+5S
 s/p1mQ0EWqp0Dg5d8SrzfwghkRUkyPWMYWTAat2oy7Eo+RF3cqVFmvM5sDl/yY8ILm12GRQoEbd
 y7LIUzCl1MK0VjhFlsoyY5MBUYSy+20awY7muTWX6mGnO1VP5cmrmC91f2NVeU4douFSbNY2VC6
 f0c9FAcFIZawV9V/+42VCGL5bGoEMfjW3a1We+e7mvY4EcK84Vnkku/uJjN7OepjpGXd2PWEO/s
 xbtAsNle5kH1n0seFi6FOenAvNeAyHS+ob2ee8F9JJNZHvkdemZCbKjJxcoSwyq6NOC16S1NbvC
 knAdu5d97NpXbfw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

The 'msk->write_seq' and 'msk->snd_nxt' are always updated under
the msk socket lock, except at MPC handshake completiont time.

Builds-up on the previous commit to move such init under the relevant
lock.

There are no known problems caused by the potential race, the
primary goal is consistency.

Fixes: 6d0060f600ad ("mptcp: Write MPTCP DSS headers to outgoing data packets")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c |  6 ++----
 net/mptcp/subflow.c  | 13 +++++++++++--
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7632eafb683b..8cb6a873dae9 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3478,10 +3478,8 @@ void mptcp_finish_connect(struct sock *ssk)
 	 * accessing the field below
 	 */
 	WRITE_ONCE(msk->local_key, subflow->local_key);
-	WRITE_ONCE(msk->write_seq, subflow->idsn + 1);
-	WRITE_ONCE(msk->snd_nxt, msk->write_seq);
-	WRITE_ONCE(msk->snd_una, msk->write_seq);
-	WRITE_ONCE(msk->wnd_end, msk->snd_nxt + tcp_sk(ssk)->snd_wnd);
+	WRITE_ONCE(msk->snd_una, subflow->idsn + 1);
+	WRITE_ONCE(msk->wnd_end, subflow->idsn + 1 + tcp_sk(ssk)->snd_wnd);
 
 	mptcp_pm_new_connection(msk, ssk, 0);
 }
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 56b2ac2f2f22..c2df34ebcf28 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -421,12 +421,21 @@ static bool subflow_use_different_dport(struct mptcp_sock *msk, const struct soc
 
 void __mptcp_sync_state(struct sock *sk, int state)
 {
+	struct mptcp_subflow_context *subflow;
 	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct sock *ssk = msk->first;
 
-	__mptcp_propagate_sndbuf(sk, msk->first);
+	subflow = mptcp_subflow_ctx(ssk);
+	__mptcp_propagate_sndbuf(sk, ssk);
 	if (!msk->rcvspace_init)
-		mptcp_rcv_space_init(msk, msk->first);
+		mptcp_rcv_space_init(msk, ssk);
+
 	if (sk->sk_state == TCP_SYN_SENT) {
+		/* subflow->idsn is always available is TCP_SYN_SENT state,
+		 * even for the FASTOPEN scenarios
+		 */
+		WRITE_ONCE(msk->write_seq, subflow->idsn + 1);
+		WRITE_ONCE(msk->snd_nxt, msk->write_seq);
 		mptcp_set_state(sk, state);
 		sk->sk_state_change(sk);
 	}

-- 
2.43.0


