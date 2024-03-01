Return-Path: <linux-kernel+bounces-88853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF0486E78C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 437831C252F2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DA11B7FD;
	Fri,  1 Mar 2024 17:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6irTJYs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDCD28389;
	Fri,  1 Mar 2024 17:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709315053; cv=none; b=WlSKbMgsitMqILxFUuW8Zv1qGoPWx9K8+sERxK7XAUkj/TJYYDpVzgiThuplQxJBsRv0hr4yESoHRhN4w8cUGqQZqZzXL47yKACjeT4NG6Yn+kWXDJW8NHIZK8xxHZlJhBV41SaiYys0E5swNLf7jc9v+qeoOCcnJf4fo1Er49g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709315053; c=relaxed/simple;
	bh=G4kAB8OZ4MXCOBDWMFPMABLVdbV5Sbsejmq3eie/oIU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IZiaFzzhaaN/qKC/lFgEKcZgtDOxsyc8J3UGvL6+XNEmMXrHXubz8X7um4KGFJCgwYinobJ028GzUrU5t827aY9yqCMATGeAG24lNwNDtdsR6LzvdD7mZmkfGOiEgCTc0IROLJQ3EhW2tmkNTFqvz2bkGrwTdhjkyNVrFXxsJZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6irTJYs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0946C433F1;
	Fri,  1 Mar 2024 17:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709315052;
	bh=G4kAB8OZ4MXCOBDWMFPMABLVdbV5Sbsejmq3eie/oIU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=g6irTJYsG0b1tftibIKmtpbKQSaVOC6edt9F0Gh4EBRb6L61mta5ykc3wHFcSJHOt
	 /zFXXm1SwL2xfZrjY3V0mQI2BNlHkJ02WgEJAHSS8yVholtMCZ2DMcnvfEtodYemUF
	 zAMmf0l2VkSsSoIuhslQxpr7D8uq1h6T10eCT+hHPpCajn3Y04eoq83blnhFVW2NGh
	 oPaL+BDGQUi06hi1SdNCtZGP6x8lWzVM79s0oL3/suf7Z5jOSgcwXpN2RzG0cEedk7
	 6c6zV1r41RWO4/5EBu7qCCnt/ZWFIScA+HWgV7tLh/zEr9uKEP+bJbhqkzRHx9YVRx
	 1Zqby5PaxjRqA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 01 Mar 2024 18:43:45 +0100
Subject: [PATCH net-next 2/4] mptcp: avoid some duplicate code in socket
 option handling
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240301-upstream-net-next-20240301-mptcp-tcp_notsent_lowat-v1-2-415f0e8ed0e1@kernel.org>
References: <20240301-upstream-net-next-20240301-mptcp-tcp_notsent_lowat-v1-0-415f0e8ed0e1@kernel.org>
In-Reply-To: <20240301-upstream-net-next-20240301-mptcp-tcp_notsent_lowat-v1-0-415f0e8ed0e1@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1525; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=IwTtMaxyL6SadOk3ggccjuN2dObjnXMFlizaf9po/Wg=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl4hPlUHL6w2XO8GVf5jqnDctIoZ1udQhRC431z
 Tk1U6TC1P+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeIT5QAKCRD2t4JPQmmg
 c32uD/9zGka6Yv9dpXPEI6gmxJNd1lT7LUCuHuISOAwZPPtRx5ducsTozslymNZpaD37awTOQf4
 0H9nybMJgpk3L8pKWXOxarezbtaDtpkU5iRqCAJGyTqxEzZy6aT2quD0OK5PaZpLVvTe0pNIrpY
 L+Abifgo+I9pSoKXLXGUqZahC87khx871/a3CgemfsA+CaXNsUTGDlJqsm9f8U7khQn4MUYLHrA
 mbQDANMoZnRhRbLolqMlE3ctTTMM1SMygwsnCge/cfBzEjSHzf1/i8Vd5E8gZTAvcFazFXs+GI1
 CaVRgmevHH/idjnCrvmK27wqw0eevbEvqaE5UPooXbkkAHcUq2MVS6+JxrUN6kf/DEIBd/FXNa7
 nnf6zCVb4Jgq4QS/yq42u1bMbFc6xPwWmbj7Jbf5Vtq/pN0+PikB5avJBr6L4IqB2yYymINoFKx
 QLTyEpSpEbWP238mHxnwAa4A5y6xCE4C8o2dQA7tYHwFZSUIA0l+Wmu620ITU8+dMOwgMsu1dit
 tBWzLV9w1JjM8x+MOmmMNiajYDG+11iSwlJb1XWaRqNlrNfMaBPMjZBiVJKwES8UjtFT6CKMI6m
 cZNF6WVXZBwO3Ld6aqNAEnlzTRSDe+akEMYlcCdm4UwtDJdWzkaxcWeuRwWoD7lyQdOelCUHJDJ
 AizY525FFU8ZRQA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

The mptcp_get_int_option() helper is needless open-coded in a
couple of places, replace the duplicate code with the helper
call.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/sockopt.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index da37e4541a5d..ac37f6c5e2ed 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -629,13 +629,11 @@ static int mptcp_setsockopt_sol_tcp_cork(struct mptcp_sock *msk, sockptr_t optva
 {
 	struct mptcp_subflow_context *subflow;
 	struct sock *sk = (struct sock *)msk;
-	int val;
+	int val, ret;
 
-	if (optlen < sizeof(int))
-		return -EINVAL;
-
-	if (copy_from_sockptr(&val, optval, sizeof(val)))
-		return -EFAULT;
+	ret = mptcp_get_int_option(msk, optval, optlen, &val);
+	if (ret)
+		return ret;
 
 	lock_sock(sk);
 	sockopt_seq_inc(msk);
@@ -659,13 +657,11 @@ static int mptcp_setsockopt_sol_tcp_nodelay(struct mptcp_sock *msk, sockptr_t op
 {
 	struct mptcp_subflow_context *subflow;
 	struct sock *sk = (struct sock *)msk;
-	int val;
+	int val, ret;
 
-	if (optlen < sizeof(int))
-		return -EINVAL;
-
-	if (copy_from_sockptr(&val, optval, sizeof(val)))
-		return -EFAULT;
+	ret = mptcp_get_int_option(msk, optval, optlen, &val);
+	if (ret)
+		return ret;
 
 	lock_sock(sk);
 	sockopt_seq_inc(msk);

-- 
2.43.0


