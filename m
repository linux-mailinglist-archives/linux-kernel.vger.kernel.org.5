Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE2A7793A1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 17:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236776AbjHKP7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 11:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236717AbjHKP6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 11:58:55 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B0330E2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 08:58:52 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-317b31203c7so1925431f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 08:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1691769531; x=1692374331;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JwrGlqlP8zy3xXA0Lb/3kVoPgUx6S4wahN68TVcAYEQ=;
        b=TkGxEa8dAStkiM49LVmgJ3jR4c3XDLmu00M5xmgIHyo6D7mpxSimlm3wTJ3CS7gxNu
         61d6qt610XAioK9CRnwlPzJqGvTE8yWUs3SYRoqOjUYWPRhGMcgfHUD/J1C/UchyGLvF
         FPAPd3SVA6hrxFS3EYxo638MzgVoOFAv9mXW/vC81ZZqXdlrUqr9fv/4qzXOTIcP2yrP
         2CMiPNNv/YR8xoyYET+pLGPCHvZNxbHGgoDorqTPL7I54Kk1OLkw/lj0mJ8D5HNTy25j
         N6J8M0M/cikW5nR0talBWo0QPmO3LrKnuru+oe+fLpner+KT9IYfIEItbvkAQriDq6cY
         Xzfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691769531; x=1692374331;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JwrGlqlP8zy3xXA0Lb/3kVoPgUx6S4wahN68TVcAYEQ=;
        b=lZ4pHcLLs1RnkqcbRRikJFqidsrZx+FywUaOZPhd1rVurLDkSG7WER5PLVasO7rrg+
         JtGj7vN8Uk3CHtgPshVkqZOMVkrR66YrAZxksZG4wm7nKd7kLGM2oAI8a5fXjsX6anSN
         /RDElhHxm+wUTS1dcHl540QZ4BWfvb4DPGcDVH72O4nmKW8f/slOBor0hduqg1KbB7Km
         yBbcGPFGLuWafq0qNV4OhopR0U0sSBGDCqvXPF2hsdkS5Rm/JPc6l29lOzUZnxUvVIzv
         x5EMeTRLj9IPdfe7ca2GMpwJaB6S/KtDCZmgRjmLZBvxrDK7G9W1y6uGfnpCz1oCXakx
         Q9ag==
X-Gm-Message-State: AOJu0Yxz7qpJvMS/ofI+uoJancWu05RQP+/yJ7sZgnEsXks8T0DijrIJ
        EnQFxOfBBlZunqhcpbH64m+Svw==
X-Google-Smtp-Source: AGHT+IFJvLhnrsMjucsD45KsPbAk74xTiu5ctAqDiqb2OIrHPfC/OoVCjzXmxl3NujWNQzzuaT+12Q==
X-Received: by 2002:a5d:40ce:0:b0:317:4d79:1e45 with SMTP id b14-20020a5d40ce000000b003174d791e45mr1756196wrq.15.1691769531158;
        Fri, 11 Aug 2023 08:58:51 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id m12-20020a5d4a0c000000b00317e9c05d35sm5834308wrq.85.2023.08.11.08.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 08:58:50 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Fri, 11 Aug 2023 17:57:23 +0200
Subject: [PATCH net-next 10/14] mptcp: avoid additional indirection in
 sockopt
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230811-upstream-net-next-20230811-mptcp-get-rid-of-msk-subflow-v1-10-36183269ade8@tessares.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3734;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=K7Cpw3bUrIQ1S7TwFyAgFflx+80UQhfgWAmuSbjF5r0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBk1lqvQ4Qy9NxZorSk6UHkZ3Aip/F03UNbG6MtU
 BNDH6LXkDaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZNZarwAKCRD2t4JPQmmg
 c11OD/90ZhRggDinf+VJ9ze2snCh8sxAHT3osOY0tSEOW5XL9QSsQfrygLx9LGDNMYMJ/evOU/v
 vxxmWM9J2RYCR66Ihi0Qqxtsulf/v2bMi9TtbGdvneTxyIfOlEtVAmmPmlZdBLw529/RiTI3wj0
 wYQxytcKOMq2sVxBkL8VUXgXbvvwhgnzXX3ooTTiaAu4Rm/bqCXWxLecOnXfSN2vDc4+LrCBJz8
 jPq4akOusmYqvBT0mc7zPw46AMyU3DYhLUmtCvcxQfyoykgPSe6F8RUxA8G/esE6Lldp5jlzGTa
 084tnztrobEugEOhkChqxji7jUyUnJvx1G7Tx2KVbpKNiCACmX0XX2RcCMgexevqL2HN2o8DPAS
 /HiLpGk/91JQxkqOMwxvrrF6n6nCp6XJ+Scrrp6Uu9KS3W3jWu9qBAF3jspNrl6lkex3bvqfiLV
 CicghVwEs2ggnF7dhTENjjDJ23AsUcdiYN7dNT95i2qYkUfpWAfDMq69+hUeA+9c2zqv2+/idq8
 Ynoxbz/5cKHVGueKv/XJSnqaVLCcc288UgYOElMnzcreyAijt8TFDzxPtJQO5KN+Ug9CfP6q76o
 gGZqDDwDC8B1dsf/cjnz4seJSSI/GjZ/Ws4DR92gkWDUBtU40O+KkjWC8WEkirYuNg0wMbN9MFZ
 DQsB9DrXeyUk87A==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Abeni <pabeni@redhat.com>

The mptcp sockopt infrastructure unneedly uses the first subflow
socket struct in a few spots. We are going to remove such field
soon, so use directly the first subflow sock instead.

No functional changes intended.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/sockopt.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index a3f1fe810cc9..6661852f8d97 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -293,6 +293,7 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 {
 	struct sock *sk = (struct sock *)msk;
 	struct socket *ssock;
+	struct sock *ssk;
 	int ret;
 
 	switch (optname) {
@@ -307,16 +308,17 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 			return PTR_ERR(ssock);
 		}
 
-		ret = sock_setsockopt(ssock, SOL_SOCKET, optname, optval, optlen);
+		ssk = msk->first;
+		ret = sk_setsockopt(ssk, SOL_SOCKET, optname, optval, optlen);
 		if (ret == 0) {
 			if (optname == SO_REUSEPORT)
-				sk->sk_reuseport = ssock->sk->sk_reuseport;
+				sk->sk_reuseport = ssk->sk_reuseport;
 			else if (optname == SO_REUSEADDR)
-				sk->sk_reuse = ssock->sk->sk_reuse;
+				sk->sk_reuse = ssk->sk_reuse;
 			else if (optname == SO_BINDTODEVICE)
-				sk->sk_bound_dev_if = ssock->sk->sk_bound_dev_if;
+				sk->sk_bound_dev_if = ssk->sk_bound_dev_if;
 			else if (optname == SO_BINDTOIFINDEX)
-				sk->sk_bound_dev_if = ssock->sk->sk_bound_dev_if;
+				sk->sk_bound_dev_if = ssk->sk_bound_dev_if;
 		}
 		release_sock(sk);
 		return ret;
@@ -391,6 +393,7 @@ static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
 	struct sock *sk = (struct sock *)msk;
 	int ret = -EOPNOTSUPP;
 	struct socket *ssock;
+	struct sock *ssk;
 
 	switch (optname) {
 	case IPV6_V6ONLY:
@@ -403,7 +406,8 @@ static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
 			return PTR_ERR(ssock);
 		}
 
-		ret = tcp_setsockopt(ssock->sk, SOL_IPV6, optname, optval, optlen);
+		ssk = msk->first;
+		ret = tcp_setsockopt(ssk, SOL_IPV6, optname, optval, optlen);
 		if (ret != 0) {
 			release_sock(sk);
 			return ret;
@@ -413,13 +417,13 @@ static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
 
 		switch (optname) {
 		case IPV6_V6ONLY:
-			sk->sk_ipv6only = ssock->sk->sk_ipv6only;
+			sk->sk_ipv6only = ssk->sk_ipv6only;
 			break;
 		case IPV6_TRANSPARENT:
-			inet_sk(sk)->transparent = inet_sk(ssock->sk)->transparent;
+			inet_sk(sk)->transparent = inet_sk(ssk)->transparent;
 			break;
 		case IPV6_FREEBIND:
-			inet_sk(sk)->freebind = inet_sk(ssock->sk)->freebind;
+			inet_sk(sk)->freebind = inet_sk(ssk)->freebind;
 			break;
 		}
 
@@ -700,7 +704,7 @@ static int mptcp_setsockopt_sol_ip_set_transparent(struct mptcp_sock *msk, int o
 		return PTR_ERR(ssock);
 	}
 
-	issk = inet_sk(ssock->sk);
+	issk = inet_sk(msk->first);
 
 	switch (optname) {
 	case IP_FREEBIND:
@@ -865,8 +869,8 @@ static int mptcp_getsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
 {
 	struct sock *sk = (struct sock *)msk;
 	struct socket *ssock;
-	int ret;
 	struct sock *ssk;
+	int ret;
 
 	lock_sock(sk);
 	ssk = msk->first;
@@ -881,7 +885,7 @@ static int mptcp_getsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
 		goto out;
 	}
 
-	ret = tcp_getsockopt(ssock->sk, level, optname, optval, optlen);
+	ret = tcp_getsockopt(ssk, level, optname, optval, optlen);
 
 out:
 	release_sock(sk);

-- 
2.40.1

