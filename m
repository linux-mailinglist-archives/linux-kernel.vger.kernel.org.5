Return-Path: <linux-kernel+bounces-88855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C32186E78F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C163D1F27EBB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F27239FEB;
	Fri,  1 Mar 2024 17:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+0SQCYO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3F339AF8;
	Fri,  1 Mar 2024 17:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709315058; cv=none; b=u3Wr4B8CwQWAwsmHsCRr2mNsMaN4NxjHDaBXvIoKI5jY2rLMgbohhLEBIB1Pimj10ioORApwsQ68wAvDk8hMM8binm3tKH8W915f7iZJ06z7wXE+NWIZ9fi3B7pNZHV48cY+RtCnZ0j1ZVt6EEvtlWrBRXSIe1oUOmj/tITwaWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709315058; c=relaxed/simple;
	bh=EdDtedg5CZVRBqB3FVjkepFcu7D4qjE49o9Ec5jvrkM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LLsVxBeSGitQsh2ktqPa3m+GJ49gVvcLFiMiRiwAfBk8YqBp6zRrm/qqobIkna25tBY26KlOs3EWT+IXmgtoYVl0ldnmCrqeXSK75c5dMwJwC2B5MkJ1HNXsfPtDbXa7pQKR7X+WyQAMhCuhN+Sjl/u4m+NWNM4EmLOc4WpHOkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+0SQCYO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1945C43394;
	Fri,  1 Mar 2024 17:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709315057;
	bh=EdDtedg5CZVRBqB3FVjkepFcu7D4qjE49o9Ec5jvrkM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=U+0SQCYOW2Fqxz64HPq0sjdCWZEYhrkEWIt0/Agtsr3QHKLuV2FyeXzaLLONCXssw
	 yAAeF3r1yKAX+THjQHy4AKoWO2/8zApeGkDaWcS2C2T2PEoj61bkUin3iGBGG/bkVP
	 fRdAL44UnSYX6fiIxgCZMu1Rk9gmL9BRl6mCWsu4Ci62R8pw6SL7aXaqPQxHScVAn3
	 U7PRtfOI/oDQ0jzRjcWCL9tVnKPpxcv7svaAKtZpQM2Yo7LHY016LEYulr36peBHyn
	 Kbz0xuFHXuwANR5J62blx4x1rGhtI2FhpHkKoemjpkD8pv88FruM/EgdYCIKnRhzUs
	 kOuY8l2mUMN/w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 01 Mar 2024 18:43:47 +0100
Subject: [PATCH net-next 4/4] mptcp: cleanup SOL_TCP handling
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240301-upstream-net-next-20240301-mptcp-tcp_notsent_lowat-v1-4-415f0e8ed0e1@kernel.org>
References: <20240301-upstream-net-next-20240301-mptcp-tcp_notsent_lowat-v1-0-415f0e8ed0e1@kernel.org>
In-Reply-To: <20240301-upstream-net-next-20240301-mptcp-tcp_notsent_lowat-v1-0-415f0e8ed0e1@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4108; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=JOhIkA1LLYA8cGzrNasgxXO6BcQPIlXJLYVTAJAF5uE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl4hPlZzS9ixLKjsUkekt8wgU9lZeee8d4BgCjg
 GS/R9Hs8uaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeIT5QAKCRD2t4JPQmmg
 c5lmD/9sHqCD959Q30Wnmmxl/tk4DCC/yXJjSphpIt4NGK/jNXVeS9Xy3sXR3Rxv77l/oGa8AX+
 6cBZ61OYVCfZyBGG8C23TEKje189vY6geqp6A1Bv3qAaq7spQ80rNEUdtfOOFJlIDZ8EbiRZqw+
 zWE9hGuEwNLZqEVvAR4pgPFDj7dG9NMVtILgi+T0rR539uYwp/1UFjGB2bqKertAY4D3riqKmjh
 JGLdU23eDtl2jZsPXZQcGvU/kodiO5ovABWY3D7nBvIcK+azJ/qx9eIxD0Cj2Mlx9bEtWpOj5WQ
 GVck/w/syaJjkUfCEYK4eW+HAHtnptyLv8/BGf/epFLd4ezAZ9QTFN5DZoe7Wufq6CV1lhAhJLt
 BY/YmiMVQ/s90SodCGibd8mqalo8iVxmqu9+fuGaH9ucgHct76DYTNYKy0r1UjsrBdfIxQSkes+
 CBvrmXJHx/eMQP1LIKTPKloX99ND95FiAZQPeUEhsfZTpXB7TaJnDbgDbPmXzpsuCEyK/jZ4QQG
 lt0XTy5s4YJ1RWY0+ch5fib8PhDItjoUf8CGo1/mRQ+tiuMCMSoCgAgIv3KM7l9jD+gO41OthVY
 FLSWOGqysrrY8hvueESkPfVNDzFoOD5d5wm5A+FCE6eYWhguWsdunrjT1VBBj6sNuNcCU5I0946
 x1jxsFrGCJyh5Qw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

Most TCP-level socket options get an integer from user space, and
set the corresponding field under the msk-level socket lock.

Reduce the code duplication moving such operations in the common code.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/sockopt.c | 75 +++++++++++++++++++++--------------------------------
 1 file changed, 30 insertions(+), 45 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 1b38dac70719..dcd1c76d2a3b 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -624,18 +624,11 @@ static int mptcp_setsockopt_sol_tcp_congestion(struct mptcp_sock *msk, sockptr_t
 	return ret;
 }
 
-static int mptcp_setsockopt_sol_tcp_cork(struct mptcp_sock *msk, sockptr_t optval,
-					 unsigned int optlen)
+static int __mptcp_setsockopt_sol_tcp_cork(struct mptcp_sock *msk, int val)
 {
 	struct mptcp_subflow_context *subflow;
 	struct sock *sk = (struct sock *)msk;
-	int val, ret;
 
-	ret = mptcp_get_int_option(msk, optval, optlen, &val);
-	if (ret)
-		return ret;
-
-	lock_sock(sk);
 	sockopt_seq_inc(msk);
 	msk->cork = !!val;
 	mptcp_for_each_subflow(msk, subflow) {
@@ -647,23 +640,15 @@ static int mptcp_setsockopt_sol_tcp_cork(struct mptcp_sock *msk, sockptr_t optva
 	}
 	if (!val)
 		mptcp_check_and_set_pending(sk);
-	release_sock(sk);
 
 	return 0;
 }
 
-static int mptcp_setsockopt_sol_tcp_nodelay(struct mptcp_sock *msk, sockptr_t optval,
-					    unsigned int optlen)
+static int __mptcp_setsockopt_sol_tcp_nodelay(struct mptcp_sock *msk, int val)
 {
 	struct mptcp_subflow_context *subflow;
 	struct sock *sk = (struct sock *)msk;
-	int val, ret;
 
-	ret = mptcp_get_int_option(msk, optval, optlen, &val);
-	if (ret)
-		return ret;
-
-	lock_sock(sk);
 	sockopt_seq_inc(msk);
 	msk->nodelay = !!val;
 	mptcp_for_each_subflow(msk, subflow) {
@@ -675,8 +660,6 @@ static int mptcp_setsockopt_sol_tcp_nodelay(struct mptcp_sock *msk, sockptr_t op
 	}
 	if (val)
 		mptcp_check_and_set_pending(sk);
-	release_sock(sk);
-
 	return 0;
 }
 
@@ -799,35 +782,10 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 	int ret, val;
 
 	switch (optname) {
-	case TCP_INQ:
-		ret = mptcp_get_int_option(msk, optval, optlen, &val);
-		if (ret)
-			return ret;
-		if (val < 0 || val > 1)
-			return -EINVAL;
-
-		lock_sock(sk);
-		msk->recvmsg_inq = !!val;
-		release_sock(sk);
-		return 0;
 	case TCP_ULP:
 		return -EOPNOTSUPP;
-	case TCP_NOTSENT_LOWAT:
-		ret = mptcp_get_int_option(msk, optval, optlen, &val);
-		if (ret)
-			return ret;
-
-		lock_sock(sk);
-		WRITE_ONCE(msk->notsent_lowat, val);
-		mptcp_write_space(sk);
-		release_sock(sk);
-		return 0;
 	case TCP_CONGESTION:
 		return mptcp_setsockopt_sol_tcp_congestion(msk, optval, optlen);
-	case TCP_CORK:
-		return mptcp_setsockopt_sol_tcp_cork(msk, optval, optlen);
-	case TCP_NODELAY:
-		return mptcp_setsockopt_sol_tcp_nodelay(msk, optval, optlen);
 	case TCP_DEFER_ACCEPT:
 		/* See tcp.c: TCP_DEFER_ACCEPT does not fail */
 		mptcp_setsockopt_first_sf_only(msk, SOL_TCP, optname, optval, optlen);
@@ -840,7 +798,34 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 						      optval, optlen);
 	}
 
-	return -EOPNOTSUPP;
+	ret = mptcp_get_int_option(msk, optval, optlen, &val);
+	if (ret)
+		return ret;
+
+	lock_sock(sk);
+	switch (optname) {
+	case TCP_INQ:
+		if (val < 0 || val > 1)
+			ret = -EINVAL;
+		else
+			msk->recvmsg_inq = !!val;
+		break;
+	case TCP_NOTSENT_LOWAT:
+		WRITE_ONCE(msk->notsent_lowat, val);
+		mptcp_write_space(sk);
+		break;
+	case TCP_CORK:
+		ret = __mptcp_setsockopt_sol_tcp_cork(msk, val);
+		break;
+	case TCP_NODELAY:
+		ret = __mptcp_setsockopt_sol_tcp_nodelay(msk, val);
+		break;
+	default:
+		ret = -ENOPROTOOPT;
+	}
+
+	release_sock(sk);
+	return ret;
 }
 
 int mptcp_setsockopt(struct sock *sk, int level, int optname,

-- 
2.43.0


