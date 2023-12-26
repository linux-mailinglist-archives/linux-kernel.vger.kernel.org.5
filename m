Return-Path: <linux-kernel+bounces-11497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 629ED81E744
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 13:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A92A282FB4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 12:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7943B4F1E1;
	Tue, 26 Dec 2023 12:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQuLPQYQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA85C4EB4C;
	Tue, 26 Dec 2023 12:10:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3A2BC433C8;
	Tue, 26 Dec 2023 12:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703592657;
	bh=9K3RAxwtnbgt4T42ampHD1OD/JlH35Ygy2iCSPJlHoE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nQuLPQYQj0rJddca9UNwEtVFa9Gfe3ZywepzqjizFZ9yBP8IN9wvcebRcVwB/OItz
	 R6BLs3SKYwlhuqWP3ADKRy+rWNnUlLtezLThB0d3BWtpB5Kk8UP4DEHzII8yvdwgah
	 KnJhjCJ8rK3YSxyyDOEm+Cx+H5GX8gRM28VyygQh8XdJPY343/+dHGimqMqH+kkv7w
	 e9D3ZL7s1O49Ft3+xtyLQSLosGkD4BRgJ8SU+hMbggrgSYPOb0U5rEkWHrsrmLKKHe
	 DgVmezxBKjstYXDeOJt+MAPIQ4zvHN/nf2lwci/6UeQd22e0uhvJ1ybXw2ivd0U+l2
	 ITEQEVdSvvd8g==
From: Matthieu Baerts <matttbe@kernel.org>
Date: Tue, 26 Dec 2023 13:10:18 +0100
Subject: [PATCH net 2/2] mptcp: prevent tcp diag from closing listener
 subflows
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231226-upstream-net-20231226-mptcp-prevent-warn-v1-2-1404dcc431ea@kernel.org>
References: <20231226-upstream-net-20231226-mptcp-prevent-warn-v1-0-1404dcc431ea@kernel.org>
In-Reply-To: <20231226-upstream-net-20231226-mptcp-prevent-warn-v1-0-1404dcc431ea@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang.tang@linux.dev>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Matthieu Baerts <matttbe@kernel.org>, stable@vger.kernel.org, 
 syzbot+5a01c3a666e726bc8752@syzkaller.appspotmail.com
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2384; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=HDp1Le2S0oz86KqWx/YgeMDwAfEXRM0g+e1uupHk7kU=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlisLJiW/jUMiX4knlvoEDr/Uu+rv4Yuf4zi62F
 gnxOCaCU0aJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZYrCyQAKCRD2t4JPQmmg
 cyKzD/9qtiKMJx5LbFlpxD6kdM8LYanxi9aYr7uyauIbafSh7dLy8U0aVLOAPMe1CKRp6hmD+HN
 B3xIhkOuFu0vqvNpir8m+GaxyQKXYRNNns3atZriKmGeBnZDPQj9UYNtDvMbrEopK9rpo5DpsNr
 voq4n45obKfYjkdeCyi0DIZbR2EIp5FgAscRZW0iXltYkE5NTVjzw1WfJ02wd9528MUEn+OsKIC
 OQf2QVLsUx0HpV8beQY9CgGnYmpKYh66Pkb6yfqpaWuygfmnVEZWYgn5dIX7hE5SlcsSK2jyThO
 XS0ydvNJEYTW9Ss5oCMRyzp3G5HkmL1oS9JZnKjeLKfMmWd4efecGRk0VO5aAAC62MDCjNK38pH
 vRmuFFDhsWu8sBZA+GTCzEDHhbt5vnntHIS1f48m6pZ/4QVsSrnawH0cMXAaoSmc7K7C8tgeln1
 lG8q5hXMD7Y95VT082MLzSWR297qqC3c1dd6t2mXLsGuxg/+GeKYGKP+sIh8T86FHTS+THOsf4Y
 gQshxwrO4hzkWof8yjXfO1eNUCHVWe8TjK3QGnhrr5y58WvAgOk6ScCVWAp5yjsZsrojhS9LTpr
 kIw3l2BKrB1DIqX6L9rbj6LXQt1cw9wAtnKjvuc0RnngRx03+P1nV8lvzQ8tpfeflnUdvbrXwkO
 mHsycIOs+16SUrQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

The MPTCP protocol does not expect that any other entity could change
the first subflow status when such socket is listening.
Unfortunately the TCP diag interface allows aborting any TCP socket,
including MPTCP listeners subflows. As reported by syzbot, that trigger
a WARN() and could lead to later bigger trouble.

The MPTCP protocol needs to do some MPTCP-level cleanup actions to
properly shutdown the listener. To keep the fix simple, prevent
entirely the diag interface from stopping such listeners.

We could refine the diag callback in a later, larger patch targeting
net-next.

Fixes: 57fc0f1ceaa4 ("mptcp: ensure listener is unhashed before updating the sk status")
Cc: stable@vger.kernel.org
Reported-by: <syzbot+5a01c3a666e726bc8752@syzkaller.appspotmail.com>
Closes: https://lore.kernel.org/netdev/0000000000004f4579060c68431b@google.com/
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
---
 net/mptcp/subflow.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 6d7684c35e93..852b3f4af000 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1982,6 +1982,17 @@ static void tcp_release_cb_override(struct sock *ssk)
 	tcp_release_cb(ssk);
 }
 
+static int tcp_abort_override(struct sock *ssk, int err)
+{
+	/* closing a listener subflow requires a great deal of care.
+	 * keep it simple and just prevent such operation
+	 */
+	if (inet_sk_state_load(ssk) == TCP_LISTEN)
+		return -EINVAL;
+
+	return tcp_abort(ssk, err);
+}
+
 static struct tcp_ulp_ops subflow_ulp_ops __read_mostly = {
 	.name		= "mptcp",
 	.owner		= THIS_MODULE,
@@ -2026,6 +2037,7 @@ void __init mptcp_subflow_init(void)
 
 	tcp_prot_override = tcp_prot;
 	tcp_prot_override.release_cb = tcp_release_cb_override;
+	tcp_prot_override.diag_destroy = tcp_abort_override;
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 	/* In struct mptcp_subflow_request_sock, we assume the TCP request sock
@@ -2061,6 +2073,7 @@ void __init mptcp_subflow_init(void)
 
 	tcpv6_prot_override = tcpv6_prot;
 	tcpv6_prot_override.release_cb = tcp_release_cb_override;
+	tcpv6_prot_override.diag_destroy = tcp_abort_override;
 #endif
 
 	mptcp_diag_subflow_init(&subflow_ulp_ops);

-- 
2.43.0


