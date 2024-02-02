Return-Path: <linux-kernel+bounces-49778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FAA846F42
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6D29294B29
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2129D145B1B;
	Fri,  2 Feb 2024 11:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vR66BzAo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F41145B03;
	Fri,  2 Feb 2024 11:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706874028; cv=none; b=XIxOOOjUOT5HmG7qBsXbKAxfrq13gc0x8QyJUh43F+JOkM0yNmFsxdsmasfA7zLd+mWIP6glg0x1/1Xid5C6zvTZavs8/BPKyVEi8wX7IFUSrGQaWGVTyukpTWRjfccIc/LCzrvXY+w8Lmeyc3npOUscOY5pPxD5acvYNus9ZhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706874028; c=relaxed/simple;
	bh=GP9eXw8XviQI7I0KXeWcmDow825AoLoWnedltmWdRbg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M8vzfys1KNqUPnO7xlzUVTNy5hegBvBoVrisAECSccRzFzGeHFdCnuS4OlkuYRSq/BTcgQc0Tb/dAkNVOA1CmzFTmfN5y7XngUfuCpd6WrpPcNHYlAIugPvR3s2mjdfYqRm7oDzlnSOTw5N1MaKcpZdbr2vdIHJWHEZEshznI0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vR66BzAo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B3E3C433B1;
	Fri,  2 Feb 2024 11:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706874027;
	bh=GP9eXw8XviQI7I0KXeWcmDow825AoLoWnedltmWdRbg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=vR66BzAoA4FosnObRO94TlFpWdDcv7xzJZr4vhg0mO9RM8UjS1AbjbHXSbz8a8QtZ
	 BhEWtso9AeuvvSGBNJ+/+PexFh62MFCm1nUc+RlFpZBvIvOl2JGcsjZt3nrRyqMVgZ
	 D6j91IZL7SDAbmqCSDG26skA4nL29/eE8XkPMAMQDuuSOuIR9aisQfOPgljpEoHn0I
	 uNW2i2NVSw4bxs8p9HkxdQkmZOZr9nht2Mk5oytVq89qBJ66Q6X7KEVXIJ+18ylAp0
	 A7pTCthFh7NngkE4+kRfc0k4TEJ+QUnZlIhaC/qupPI0cK3h7wY9Br2ocWV4Gn4PIE
	 1wW8Z9biWhiVg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 02 Feb 2024 12:40:10 +0100
Subject: [PATCH net-next 4/5] mptcp: annotate lockless access for token
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240202-upstream-net-next-20240202-mptcp-annotate-lockless-access-v1-4-031d6680afdc@kernel.org>
References: <20240202-upstream-net-next-20240202-mptcp-annotate-lockless-access-v1-0-031d6680afdc@kernel.org>
In-Reply-To: <20240202-upstream-net-next-20240202-mptcp-annotate-lockless-access-v1-0-031d6680afdc@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang.tang@linux.dev>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3367; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=jKtAxP0DW7aZKLSgEet2dMJtl4rlzc/BQZ56tk1mhM4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlvNSe/zN+qxEADlW9fazl/W/zNsj2KuYaPoDWZ
 uvr5FB9OPWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZbzUngAKCRD2t4JPQmmg
 c/x/D/9UTks+dD6xEfEuQzCbr0tb6px9mkKufMkQzQlIuX/Xyq8I3HUjWpycoqf/rJ2L05udR0r
 Jf8StKWhEAiX0KgZ5Ge7QPreVq9i6EtuXz9LgP2VAPu9ppvTwOo9X5zwu/3jQIPX/8QwbI6U+8C
 4hwoGdT8XL8q7BS1tEErVMCxpWOOHTize/JWqk2a6Gxwxk6P17Mgkk08cTP0UKeqpuUiKVrXBm6
 dzTz/VH/hB1frnYiUXaF/Evj8Mo3yDz/2Q7MsPdHAThbD5ajhyDCgvcY0qEW4VhxGLILikPXaSh
 PtJx+W/9gxITlok1GLfwZm7NaB3OjtvGRtoc+/bO8RmVCp4Ufu/EBLbHXRvOCqMngbNfX2uJIsS
 cAz0YhozWo6t4An7XN56N2UhyFlgMy6mmvyfFZkp7h/bIQY10JmrOSzy8GGJlqLqqTByiucU/IY
 r5c6uzVL3sJWUCXWtu36+m2HfWYKhT2K0R9Qsu5cxU9Fwpw8sOOzxbWnFKWiCSczCg+FiD4lLG3
 wutdHdGKZmVwnyctzyKAKavUWBYWtDZQSVz5bGS52OtX/mttO2951WequvGPl08LhS9B3eoasXl
 2bwf4UW8ubsaN7ncqHXWYZY1sh79HTCz1esoujsSAN+DFA4NzB0NZ47h3yj7OvjYgzJWucShXof
 ZWAZ8xnO0YbKLpA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

The token field is manipulated under the msk socket lock
and accessed lockless in a few spots, add proper ONCE annotation

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c         |  2 +-
 net/mptcp/pm_netlink.c | 10 +++++-----
 net/mptcp/protocol.c   |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 4ae19113b8eb..53e0b08b1123 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -77,7 +77,7 @@ void mptcp_pm_new_connection(struct mptcp_sock *msk, const struct sock *ssk, int
 {
 	struct mptcp_pm_data *pm = &msk->pm;
 
-	pr_debug("msk=%p, token=%u side=%d", msk, msk->token, server_side);
+	pr_debug("msk=%p, token=%u side=%d", msk, READ_ONCE(msk->token), server_side);
 
 	WRITE_ONCE(pm->server_side, server_side);
 	mptcp_event(MPTCP_EVENT_CREATED, msk, ssk, GFP_ATOMIC);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 287a60381eae..d9ad45959219 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1997,7 +1997,7 @@ static int mptcp_event_put_token_and_ssk(struct sk_buff *skb,
 	const struct mptcp_subflow_context *sf;
 	u8 sk_err;
 
-	if (nla_put_u32(skb, MPTCP_ATTR_TOKEN, msk->token))
+	if (nla_put_u32(skb, MPTCP_ATTR_TOKEN, READ_ONCE(msk->token)))
 		return -EMSGSIZE;
 
 	if (mptcp_event_add_subflow(skb, ssk))
@@ -2055,7 +2055,7 @@ static int mptcp_event_created(struct sk_buff *skb,
 			       const struct mptcp_sock *msk,
 			       const struct sock *ssk)
 {
-	int err = nla_put_u32(skb, MPTCP_ATTR_TOKEN, msk->token);
+	int err = nla_put_u32(skb, MPTCP_ATTR_TOKEN, READ_ONCE(msk->token));
 
 	if (err)
 		return err;
@@ -2083,7 +2083,7 @@ void mptcp_event_addr_removed(const struct mptcp_sock *msk, uint8_t id)
 	if (!nlh)
 		goto nla_put_failure;
 
-	if (nla_put_u32(skb, MPTCP_ATTR_TOKEN, msk->token))
+	if (nla_put_u32(skb, MPTCP_ATTR_TOKEN, READ_ONCE(msk->token)))
 		goto nla_put_failure;
 
 	if (nla_put_u8(skb, MPTCP_ATTR_REM_ID, id))
@@ -2118,7 +2118,7 @@ void mptcp_event_addr_announced(const struct sock *ssk,
 	if (!nlh)
 		goto nla_put_failure;
 
-	if (nla_put_u32(skb, MPTCP_ATTR_TOKEN, msk->token))
+	if (nla_put_u32(skb, MPTCP_ATTR_TOKEN, READ_ONCE(msk->token)))
 		goto nla_put_failure;
 
 	if (nla_put_u8(skb, MPTCP_ATTR_REM_ID, info->id))
@@ -2234,7 +2234,7 @@ void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
 			goto nla_put_failure;
 		break;
 	case MPTCP_EVENT_CLOSED:
-		if (nla_put_u32(skb, MPTCP_ATTR_TOKEN, msk->token) < 0)
+		if (nla_put_u32(skb, MPTCP_ATTR_TOKEN, READ_ONCE(msk->token)) < 0)
 			goto nla_put_failure;
 		break;
 	case MPTCP_EVENT_ANNOUNCED:
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 90804e7fb7f6..4478ddd3b5fa 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3199,7 +3199,7 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 
 	msk = mptcp_sk(nsk);
 	WRITE_ONCE(msk->local_key, subflow_req->local_key);
-	msk->token = subflow_req->token;
+	WRITE_ONCE(msk->token, subflow_req->token);
 	msk->in_accept_queue = 1;
 	WRITE_ONCE(msk->fully_established, false);
 	if (mp_opt->suboptions & OPTION_MPTCP_CSUMREQD)

-- 
2.43.0


