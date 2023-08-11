Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 338327793A4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 17:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjHKP7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 11:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236734AbjHKP67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 11:58:59 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81D230EE
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 08:58:54 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-317b31203c7so1925466f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 08:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1691769533; x=1692374333;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LSGODcFr9OATSyqQxuKOktFKCDDLoEhYtD7jcorRxls=;
        b=Ns1lteFxpGDVHRr38JDPYc+60Nzl7xP/gf0ZKPsOMwq34jdrCKfZ/cwPk/wmPUz4sS
         4B0ebU8RTUNR/NLt23mZ+jTb2pmqeRacpKRP1Bbver0Yy0LlTNvzg/13mW3x9NB5Wkq6
         maFLwHCC9lVe6FM7zhXGEi4pxAuOOSmZri/uYjdvRjK2/0Aor+r0q4muwwnVHvqlhuRJ
         fCPYJtvJhrgsHNxhRA4r0ywV7MrSTxZTiV5vWC0kR1dP4RvW2VQmc3owz7jn42NyeCr8
         ESM/YU2HagKdfe6mjsOx8oPYUL/LMLexoi0mib6FD+g3nWBb+fojKsCSSS16Gr3xYToU
         8qMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691769533; x=1692374333;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LSGODcFr9OATSyqQxuKOktFKCDDLoEhYtD7jcorRxls=;
        b=ENy5EnCxuBJEOUEyeKyLUVtXeMKWrrOOu7D5OBLDBQNQeeYg0Cv322CMcQfqOMy5Hg
         iFUxzFPgryfzXiCqAzV44oe8gdVaoelJpaOHnWrc5TyJabpXrGDUoGa+K0KKVTQlWzSc
         2UHK8Ko/AfsqwaH0tpTslKeN9EtBUvxr/TMIXSoiuuHWrbaoFtX9opbDj2piuAorFbHr
         A5IwhvtEXT9Ikvz70RXRZOjqhU70yT3c3ZyMfLshGDYqpJEONQMfVBCLnsGnOkdo4gLt
         NzBcy/wDbnGeLjBoLU8E3Z4qtgTEXLtp5cC6Pf6ZxaSle3hzLL0eJgPGt5bGtf9v9spV
         Mjlg==
X-Gm-Message-State: AOJu0YxhdA59oJfayWeKLHn/3IcSSMAbvRgfRgG8N78P70G8fUCjQ5eR
        pPAjuAs6sHC3+lIGzGRV+9nb8g==
X-Google-Smtp-Source: AGHT+IHSAIG9FO2b3p/44Qi1wGiiMXTS2x9PQYOlWgfnoC2epewlMwfPHnzUFVs635sk0DrPmdvg2Q==
X-Received: by 2002:a5d:5742:0:b0:319:57c0:19f7 with SMTP id q2-20020a5d5742000000b0031957c019f7mr1881075wrw.7.1691769533171;
        Fri, 11 Aug 2023 08:58:53 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id m12-20020a5d4a0c000000b00317e9c05d35sm5834308wrq.85.2023.08.11.08.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 08:58:52 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Fri, 11 Aug 2023 17:57:25 +0200
Subject: [PATCH net-next 12/14] mptcp: change the mpc check helper to
 return a sk
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230811-upstream-net-next-20230811-mptcp-get-rid-of-msk-subflow-v1-12-36183269ade8@tessares.net>
References: <20230811-upstream-net-next-20230811-mptcp-get-rid-of-msk-subflow-v1-0-36183269ade8@tessares.net>
In-Reply-To: <20230811-upstream-net-next-20230811-mptcp-get-rid-of-msk-subflow-v1-0-36183269ade8@tessares.net>
To:     mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=10012;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=5FIAPyMt3vXexcaCp5hS8RO0kYDOfcIUe8e+GVkbMIM=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBk1lqvEIUdoYbsI/k9HD+UAvGip1BHaH0nZMrnK
 M38NGK6mkaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZNZarwAKCRD2t4JPQmmg
 cxNXEACaIW71/uXxptgFXdcZuPe5B6cj2DPTZ7da9NeA1HhobPG9XGyFbJRt6lYh7CP+DoUxDrU
 kIB3bMZjZM/g3ljiPvnyGbNBOAg96iZKCvdh4XxkqvHKoIK5IApq/MD4FPK6G0Z2Jpmdv2rI4PB
 hzB14paKlxVV5aqiSiaQNhEoT5L8w1tg/6ZADRLfMkdv2az3ZnFDPrXZ1+AjlBTB6pVtvQXXhsF
 /JZQ0O0kzQZRBNVIKhF1jW6Qmp/oXP3w+TvfM9RFIYbJbdILcpt1cwV6KGdKnTWMni9h/6OOg1F
 eAg1hXQXZJ/wCU6B/Yoq+56E4qz+mL1ZXlxJuX8O0HiHNjakXvwlqp9CuHb4b1i71rTkhgQT44R
 /26+Ha9fXQV7qph/+O3Vcc+bpHJzsPd7GFzqkj2Cw0K1JHoCq7j+gNGtjO59T//MXJMig3dYmKH
 QPnnVV4Q0mhN/CYsfkCeQTzW51NrnkgeybU4gB91QfxhPQoF0jkUqszrU9rQ57Fno8z4CuVVGYs
 hh6YCjB3xnqIp/BzJoV7fe1Hl0JQugFHClZ/IizWAd5R6D60KVQCSkq/SXS2Y6dfT1XiGnHatH+
 WDuEAQHv/bzgsanN6X9rUTXksrKtTYms66SKvK70PKM0gyVlu8MTPOiS+6k3gwEIW1Qs5h4KCnZ
 woES6Jm4M95XQ8g==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Abeni <pabeni@redhat.com>

After the previous patch the __mptcp_nmpc_socket helper is used
only to ensure that the MPTCP socket is a suitable status - that
is, the mptcp capable handshake is not started yet.

Change the return value to the relevant subflow sock, to finally
remove the last references to first subflow socket in the MPTCP stack.

As a bonus, we can get rid of a few local variables in different
functions.

No functional change intended.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/pm_netlink.c |  8 +++-----
 net/mptcp/protocol.c   | 40 +++++++++++++++-------------------------
 net/mptcp/protocol.h   |  2 +-
 net/mptcp/sockopt.c    | 43 +++++++++++++++++++------------------------
 4 files changed, 38 insertions(+), 55 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index ae36155ff128..c75d9d88a053 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1007,7 +1007,6 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 	int addrlen = sizeof(struct sockaddr_in);
 	struct sockaddr_storage addr;
 	struct sock *newsk, *ssk;
-	struct socket *ssock;
 	int backlog = 1024;
 	int err;
 
@@ -1033,17 +1032,16 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 				      &mptcp_keys[is_ipv6]);
 
 	lock_sock(newsk);
-	ssock = __mptcp_nmpc_socket(mptcp_sk(newsk));
+	ssk = __mptcp_nmpc_sk(mptcp_sk(newsk));
 	release_sock(newsk);
-	if (IS_ERR(ssock))
-		return PTR_ERR(ssock);
+	if (IS_ERR(ssk))
+		return PTR_ERR(ssk);
 
 	mptcp_info2sockaddr(&entry->addr, &addr, entry->addr.family);
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 	if (entry->addr.family == AF_INET6)
 		addrlen = sizeof(struct sockaddr_in6);
 #endif
-	ssk = mptcp_sk(newsk)->first;
 	if (ssk->sk_family == AF_INET)
 		err = inet_bind_sk(ssk, (struct sockaddr *)&addr, addrlen);
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e5ebd170d316..fafa83ee4a72 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -109,7 +109,7 @@ static int __mptcp_socket_create(struct mptcp_sock *msk)
 /* If the MPC handshake is not started, returns the first subflow,
  * eventually allocating it.
  */
-struct socket *__mptcp_nmpc_socket(struct mptcp_sock *msk)
+struct sock *__mptcp_nmpc_sk(struct mptcp_sock *msk)
 {
 	struct sock *sk = (struct sock *)msk;
 	int ret;
@@ -117,10 +117,7 @@ struct socket *__mptcp_nmpc_socket(struct mptcp_sock *msk)
 	if (!((1 << sk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN)))
 		return ERR_PTR(-EINVAL);
 
-	if (!msk->subflow) {
-		if (msk->first)
-			return ERR_PTR(-EINVAL);
-
+	if (!msk->first) {
 		ret = __mptcp_socket_create(msk);
 		if (ret)
 			return ERR_PTR(ret);
@@ -128,7 +125,7 @@ struct socket *__mptcp_nmpc_socket(struct mptcp_sock *msk)
 		mptcp_sockopt_sync(msk, msk->first);
 	}
 
-	return msk->subflow;
+	return msk->first;
 }
 
 static void mptcp_drop(struct sock *sk, struct sk_buff *skb)
@@ -1643,7 +1640,6 @@ static int mptcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
 {
 	unsigned int saved_flags = msg->msg_flags;
 	struct mptcp_sock *msk = mptcp_sk(sk);
-	struct socket *ssock;
 	struct sock *ssk;
 	int ret;
 
@@ -1654,9 +1650,9 @@ static int mptcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
 	 * fastopen attempt, no need to check for additional subflow status.
 	 */
 	if (msg->msg_flags & MSG_FASTOPEN) {
-		ssock = __mptcp_nmpc_socket(msk);
-		if (IS_ERR(ssock))
-			return PTR_ERR(ssock);
+		ssk = __mptcp_nmpc_sk(msk);
+		if (IS_ERR(ssk))
+			return PTR_ERR(ssk);
 	}
 	if (!msk->first)
 		return -EINVAL;
@@ -3577,16 +3573,14 @@ static int mptcp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 {
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_sock *msk = mptcp_sk(sk);
-	struct socket *ssock;
 	int err = -EINVAL;
 	struct sock *ssk;
 
-	ssock = __mptcp_nmpc_socket(msk);
-	if (IS_ERR(ssock))
-		return PTR_ERR(ssock);
+	ssk = __mptcp_nmpc_sk(msk);
+	if (IS_ERR(ssk))
+		return PTR_ERR(ssk);
 
 	inet_sk_state_store(sk, TCP_SYN_SENT);
-	ssk = msk->first;
 	subflow = mptcp_subflow_ctx(ssk);
 #ifdef CONFIG_TCP_MD5SIG
 	/* no MPTCP if MD5SIG is enabled on this socket or we may run out of
@@ -3682,17 +3676,15 @@ static int mptcp_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
 {
 	struct mptcp_sock *msk = mptcp_sk(sock->sk);
 	struct sock *ssk, *sk = sock->sk;
-	struct socket *ssock;
 	int err = -EINVAL;
 
 	lock_sock(sk);
-	ssock = __mptcp_nmpc_socket(msk);
-	if (IS_ERR(ssock)) {
-		err = PTR_ERR(ssock);
+	ssk = __mptcp_nmpc_sk(msk);
+	if (IS_ERR(ssk)) {
+		err = PTR_ERR(ssk);
 		goto unlock;
 	}
 
-	ssk = msk->first;
 	if (sk->sk_family == AF_INET)
 		err = inet_bind_sk(ssk, uaddr, addr_len);
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
@@ -3711,7 +3703,6 @@ static int mptcp_listen(struct socket *sock, int backlog)
 {
 	struct mptcp_sock *msk = mptcp_sk(sock->sk);
 	struct sock *sk = sock->sk;
-	struct socket *ssock;
 	struct sock *ssk;
 	int err;
 
@@ -3723,13 +3714,12 @@ static int mptcp_listen(struct socket *sock, int backlog)
 	if (sock->state != SS_UNCONNECTED || sock->type != SOCK_STREAM)
 		goto unlock;
 
-	ssock = __mptcp_nmpc_socket(msk);
-	if (IS_ERR(ssock)) {
-		err = PTR_ERR(ssock);
+	ssk = __mptcp_nmpc_sk(msk);
+	if (IS_ERR(ssk)) {
+		err = PTR_ERR(ssk);
 		goto unlock;
 	}
 
-	ssk = msk->first;
 	inet_sk_state_store(sk, TCP_LISTEN);
 	sock_set_flag(sk, SOCK_RCU_FREE);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 79fc5cdb67bc..dccc96dc2d6b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -640,7 +640,7 @@ void __mptcp_subflow_send_ack(struct sock *ssk);
 void mptcp_subflow_reset(struct sock *ssk);
 void mptcp_subflow_queue_clean(struct sock *sk, struct sock *ssk);
 void mptcp_sock_graft(struct sock *sk, struct socket *parent);
-struct socket *__mptcp_nmpc_socket(struct mptcp_sock *msk);
+struct sock *__mptcp_nmpc_sk(struct mptcp_sock *msk);
 bool __mptcp_close(struct sock *sk, long timeout);
 void mptcp_cancel_work(struct sock *sk);
 void __mptcp_unaccepted_force_close(struct sock *sk);
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 6661852f8d97..21bc46acbe38 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -292,7 +292,6 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 				       sockptr_t optval, unsigned int optlen)
 {
 	struct sock *sk = (struct sock *)msk;
-	struct socket *ssock;
 	struct sock *ssk;
 	int ret;
 
@@ -302,13 +301,12 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 	case SO_BINDTODEVICE:
 	case SO_BINDTOIFINDEX:
 		lock_sock(sk);
-		ssock = __mptcp_nmpc_socket(msk);
-		if (IS_ERR(ssock)) {
+		ssk = __mptcp_nmpc_sk(msk);
+		if (IS_ERR(ssk)) {
 			release_sock(sk);
-			return PTR_ERR(ssock);
+			return PTR_ERR(ssk);
 		}
 
-		ssk = msk->first;
 		ret = sk_setsockopt(ssk, SOL_SOCKET, optname, optval, optlen);
 		if (ret == 0) {
 			if (optname == SO_REUSEPORT)
@@ -392,7 +390,6 @@ static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
 {
 	struct sock *sk = (struct sock *)msk;
 	int ret = -EOPNOTSUPP;
-	struct socket *ssock;
 	struct sock *ssk;
 
 	switch (optname) {
@@ -400,13 +397,12 @@ static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
 	case IPV6_TRANSPARENT:
 	case IPV6_FREEBIND:
 		lock_sock(sk);
-		ssock = __mptcp_nmpc_socket(msk);
-		if (IS_ERR(ssock)) {
+		ssk = __mptcp_nmpc_sk(msk);
+		if (IS_ERR(ssk)) {
 			release_sock(sk);
-			return PTR_ERR(ssock);
+			return PTR_ERR(ssk);
 		}
 
-		ssk = msk->first;
 		ret = tcp_setsockopt(ssk, SOL_IPV6, optname, optval, optlen);
 		if (ret != 0) {
 			release_sock(sk);
@@ -689,7 +685,7 @@ static int mptcp_setsockopt_sol_ip_set_transparent(struct mptcp_sock *msk, int o
 {
 	struct sock *sk = (struct sock *)msk;
 	struct inet_sock *issk;
-	struct socket *ssock;
+	struct sock *ssk;
 	int err;
 
 	err = ip_setsockopt(sk, SOL_IP, optname, optval, optlen);
@@ -698,13 +694,13 @@ static int mptcp_setsockopt_sol_ip_set_transparent(struct mptcp_sock *msk, int o
 
 	lock_sock(sk);
 
-	ssock = __mptcp_nmpc_socket(msk);
-	if (IS_ERR(ssock)) {
+	ssk = __mptcp_nmpc_sk(msk);
+	if (IS_ERR(ssk)) {
 		release_sock(sk);
-		return PTR_ERR(ssock);
+		return PTR_ERR(ssk);
 	}
 
-	issk = inet_sk(msk->first);
+	issk = inet_sk(ssk);
 
 	switch (optname) {
 	case IP_FREEBIND:
@@ -767,18 +763,18 @@ static int mptcp_setsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
 					  sockptr_t optval, unsigned int optlen)
 {
 	struct sock *sk = (struct sock *)msk;
-	struct socket *sock;
+	struct sock *ssk;
 	int ret;
 
 	/* Limit to first subflow, before the connection establishment */
 	lock_sock(sk);
-	sock = __mptcp_nmpc_socket(msk);
-	if (IS_ERR(sock)) {
-		ret = PTR_ERR(sock);
+	ssk = __mptcp_nmpc_sk(msk);
+	if (IS_ERR(ssk)) {
+		ret = PTR_ERR(ssk);
 		goto unlock;
 	}
 
-	ret = tcp_setsockopt(sock->sk, level, optname, optval, optlen);
+	ret = tcp_setsockopt(ssk, level, optname, optval, optlen);
 
 unlock:
 	release_sock(sk);
@@ -868,7 +864,6 @@ static int mptcp_getsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
 					  char __user *optval, int __user *optlen)
 {
 	struct sock *sk = (struct sock *)msk;
-	struct socket *ssock;
 	struct sock *ssk;
 	int ret;
 
@@ -879,9 +874,9 @@ static int mptcp_getsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
 		goto out;
 	}
 
-	ssock = __mptcp_nmpc_socket(msk);
-	if (IS_ERR(ssock)) {
-		ret = PTR_ERR(ssock);
+	ssk = __mptcp_nmpc_sk(msk);
+	if (IS_ERR(ssk)) {
+		ret = PTR_ERR(ssk);
 		goto out;
 	}
 

-- 
2.40.1

