Return-Path: <linux-kernel+bounces-58511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 422AE84E758
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED7AF28484A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D474129A79;
	Thu,  8 Feb 2024 18:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJ27hc0d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EDE1292EC;
	Thu,  8 Feb 2024 18:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707415485; cv=none; b=KPddzjQ9qLFm6mOdizzamKBqfFAPqmLJ/D+i09BcFwrSY6dWAatJGLiOVOPdMjeGn/v4UBP8YklX3cM/mbqpLuUNDEP2zg5io0UOaxGfXglspBGnbjRaaGdNV6Fmwd1Zs6/HcxRa+gsyjF75Uldwb4C5Wq8AaohivkkXISLSMVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707415485; c=relaxed/simple;
	bh=r/gq3pLyzLbtSrMv4ZRs7gB0vsiao3xcDTWrjPKBybM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JV4pVzIrsauPmu2wpge6m13ZQqoNEXSQofozYaveGd01ahFtwMWsyIxB7xl+x65UfugUM51zEO0FifEk+XZKJ8amA2q+QEFdzd/afTkGpugNRsmZq0HO+EfZk6dN9fd3j+TejRb34CIkHYPvwmEq9+qrKovx4DpXOA9DK4Wr/uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJ27hc0d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5119CC43394;
	Thu,  8 Feb 2024 18:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707415484;
	bh=r/gq3pLyzLbtSrMv4ZRs7gB0vsiao3xcDTWrjPKBybM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jJ27hc0dnYocwuK2M0zn/x1HALa/GNyyY8Kasu3+DrzFHISxYGgGDQOff01tANjE0
	 MWhJijoM8gleA8DIKr+LzkNxSPdTSJXRD8YAQJCqGIv9wYZ1VVq1PTKKmVv3gIonwz
	 qIr1prV4iWsteLjzETfXYFRMB5Dkvv6yZFgj6d+dN97rqKy2gi/jguoc8+ErOfuFHz
	 BRAQdpVxhY5uCq4IAxkglctiaRuorLYz/h5qcbAA1eqSVDZGKksGDniCt5f5y9C3PR
	 xF3eWg42+J+/M68Y5mBUiXyzsVyZZ6BZhYbRnbNk6Q5bswFUoAWbneJE4RPNaoikxW
	 qnknJdEtcDJMw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 08 Feb 2024 19:03:54 +0100
Subject: [PATCH net 6/7] mptcp: really cope with fastopen race
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240208-upstream-net-20240202-locking-cleanup-misc-v1-6-f75cc5b97e5a@kernel.org>
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
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org, 
 syzbot+c53d4d3ddb327e80bc51@syzkaller.appspotmail.com
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1482; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=7St1EIuD4jOroFFmBmJJjLJG0zQDFjSrZU1TgGoBZ4o=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlxReiZsjM2YLGYloOqWhio7IaFMr8gh9SGHTh9
 n0LbilZceSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZcUXogAKCRD2t4JPQmmg
 cxqpEACWaUxiGKk/u59y1R0CdAfyxBluBLO1aeH3adsgZAUA/wmZSNGz7P8/zoIee+LKtyE2nhT
 AhWxtkEngjcO+UmlPcJu9U3aZ0ttDzWVzWEuFbbFpTb53+C8hTLrwpfWwAWSq9DDH7bkVdtc2fn
 6sKhwVAtvO5b8IA3ItNq5CKPUTAsIkNPS5mbV/hOMh91Y2277W+PNQ3CM+AJz27S2anN9fwC7uD
 BkFw+fkarBzQ+8vm4FzYSPO7wx9PDMkrwIAjq52gB3AJLztDDqujKpvu98BCzNTi0s1YHhPzzgj
 740TEiNvhJ+t/s9WskPrfalQvURvFk9y/EG5+W3RbivJmWUi80gC10AnBpnwHj9lXCoWROH4ZRE
 vsh3yLh81sH240xu295ZAr09c38nzMh+8SYZkuNuOSwXfsO8UiL/VxDR2k3WroZGEthiMGuBegA
 6EVwrC3w+zG5NnSqwlhwhvpgkzNQd7K3p9DgG7xFI1RForcjDI3lO+VYvlZgus+OE3I2pkoIbdU
 5Z1aRVHRc0A08bSiA7Zkd/IUstbkOzBrTcmFb2z4UIGhbX/ykC/ebZhthJAH6WR9SpXZtZIlj+k
 SuOjmZN4Zs/nx2XWBlyyFiLT5IwencUfMMgNaurHMHJdNhYtTT6Os5un4yBXM3byvkdwylLMJY+
 ss//RAXVz4qPFzg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

Fastopen and PM-trigger subflow shutdown can race, as reported by
syzkaller.

In my first attempt to close such race, I missed the fact that
the subflow status can change again before the subflow_state_change
callback is invoked.

Address the issue additionally copying with all the states directly
reachable from TCP_FIN_WAIT1.

Fixes: 1e777f39b4d7 ("mptcp: add MSG_FASTOPEN sendmsg flag support")
Fixes: 4fd19a307016 ("mptcp: fix inconsistent state on fastopen race")
Cc: stable@vger.kernel.org
Reported-by: syzbot+c53d4d3ddb327e80bc51@syzkaller.appspotmail.com
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/458
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index fefcbf585411..ed50f2015dc3 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1129,7 +1129,8 @@ static inline bool subflow_simultaneous_connect(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 
-	return (1 << sk->sk_state) & (TCPF_ESTABLISHED | TCPF_FIN_WAIT1) &&
+	return (1 << sk->sk_state) &
+	       (TCPF_ESTABLISHED | TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2 | TCPF_CLOSING) &&
 	       is_active_ssk(subflow) &&
 	       !subflow->conn_finished;
 }

-- 
2.43.0


