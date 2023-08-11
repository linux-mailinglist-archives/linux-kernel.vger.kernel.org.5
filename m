Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4040477939B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 17:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236715AbjHKP64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 11:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236689AbjHKP6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 11:58:46 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F95C30D2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 08:58:46 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-31759e6a4a1so1781905f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 08:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1691769525; x=1692374325;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EwluUaIaFp8xw9bbqeJza0dSEd7d6Y+8KVbDaj+RAU4=;
        b=RPmoWFEUY34CsBWB1T3YgIpK7QheQyy4afzp1jWMob8P8SIQRh71QllzXtbBnu5ypi
         8hFjDnYvAwUeOjangHtczaddwuBagCWIlcyDbCax8XLaMVpJp1lNqfcGtxwBpJXY0lK3
         x/bHsUOPFYsvmYLaZv/jhe5on7mnv2jPxhfHlWoO+fxC2jYt0v2XeQeXY+kFM68ChsRJ
         dCVBBTvuHcHF1dj0TGHrwyqkhkZmqmy16SCK1qseyFHU0T8LXOkR/m9oClhuK93fAde3
         bTA348TQfYgGgX+cKiXtf1EF6CgXK/Q6HNB7BCuJCHCEHpLjNZPduLRaWcPWN/Mslx+0
         TKtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691769525; x=1692374325;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EwluUaIaFp8xw9bbqeJza0dSEd7d6Y+8KVbDaj+RAU4=;
        b=FaJA3EK0kNwr8Em22OdlkU5qSSV6LN3pj61yLWcVH9G+W3f2OKv7sGNODxnnOpDRXI
         PGGSbx+cVHA/OKhW/+SarV+6s8MUmDZW7TnrEqi/58fM+3AqyPa6UUCoH8pQUkwZxQAJ
         LgdTK75+z0IfSxHA/D7u+VaNEAAwkkvF+7A0Csv9qccVx7cpwGvupmnF7iUFsAMWj4VY
         +RQS3b4he0LkAjbkRonwIgeZ45L/EqvtIexO43tfWXDqqk7dYV6JGlmLYaBvyHDAI4Pv
         ONObr+2F1ynIT4NSLXYOIjPNJn9E91PrO4Vaoqs5z/97wgRAtQLy9LR5CcTX13fj74ye
         Ivcw==
X-Gm-Message-State: AOJu0YwD87KSL2gm08HNjSrMrz5lJ5cb0LoRoy6Xv5qYs+v9aSBQcXdf
        23RWS7UpyrONcDKaqTpJI1aEKQ==
X-Google-Smtp-Source: AGHT+IHBz37I7lskQLuIvJ9UxsVV8epJemJB05nNf6IU/WnHy8VNp7xJ65qSymo4pOT8HF3AvfIVnA==
X-Received: by 2002:adf:f042:0:b0:317:15f5:a1ca with SMTP id t2-20020adff042000000b0031715f5a1camr1780613wro.10.1691769524854;
        Fri, 11 Aug 2023 08:58:44 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id m12-20020a5d4a0c000000b00317e9c05d35sm5834308wrq.85.2023.08.11.08.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 08:58:44 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Fri, 11 Aug 2023 17:57:17 +0200
Subject: [PATCH net-next 04/14] net: factor out inet{,6}_bind_sk helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230811-upstream-net-next-20230811-mptcp-get-rid-of-msk-subflow-v1-4-36183269ade8@tessares.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3806;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=BsYDUl/DUbLVHU4Xpb77aTgJyY+cTGBHLN6ctIYlp+g=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBk1lqvcGmbN1LPAIgSii681NHqkjqbG/PqT7qgh
 uX2O1Pdu8GJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZNZarwAKCRD2t4JPQmmg
 c9kDD/9Rkt0oclO8gRzT4WMkWSflZ5DKPreOTVjGK2jDzc+Ey2XwhTDLf34/LzizqyAiyyReo9I
 RA4Kqa4wLste8hiIZmf69CR8WpBwgjmK4k8S9Awwi4g1Iy/21RbOtqxwcf4HprWrOJhQ/iC363F
 TKTDGI8YHuSd9TJFB8c1YEz3aNvuD67F4n1KJ8x9V7jRqnSUCUKAFShc0KC5I5dqi86QAvV7sud
 uPL7+fyUb70hhV3GJMrojHPgQROlTC8fQYTLV4bs2Yf52728rCx/zMS2MbvNxWkCYB310cAnDj+
 2hqxDhyHP6Y0pvsCs4zpXEfq1q9RW52HlM5WBA74Nru9OaLhSQsI7YIiWu09GSIJMFzV0U825vv
 09F5P85g/Bo0Lp5lwmKHp20P98IHU5VYzxbd5uaQB1JU9iHX/CDD9w6lWZKScdgfhVk9NMto7S2
 zeP15nQrGFzajLSffRNsofkuRKu9DUhvMRSdxdkbTGBHR4Q0qjlvEF4VYgTs1LeZq6+tXwnPT1r
 Z+Fynw1LmFa+TBv+KsTKA5SUcjPZ5pP3KsBAvVK0H1k7zSQiGM8v4UhTHrcjUxLYkzeIjM22I4Z
 OxTcbrUNPVKhAJ48mQcQlyx1tL9hONyS1Aiqtcwhm2lkNjEJ0qRLWu+aXtu2sJamxLPglVCaMZV
 p8BNC20K7enjzJg==
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

The mptcp protocol maintains an additional socket just to easily
invoke a few stream operations on the first subflow. One of
them is bind().

Factor out the helpers operating directly on the struct sock, to
allow get rid of the above dependency in the next patch without
duplicating the existing code.

No functional changes intended.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Acked-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 include/net/inet_common.h |  1 +
 include/net/ipv6.h        |  1 +
 net/ipv4/af_inet.c        |  8 ++++++--
 net/ipv6/af_inet6.c       | 10 +++++++---
 4 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/include/net/inet_common.h b/include/net/inet_common.h
index b86b8e21de7f..8e97de700991 100644
--- a/include/net/inet_common.h
+++ b/include/net/inet_common.h
@@ -42,6 +42,7 @@ int inet_shutdown(struct socket *sock, int how);
 int inet_listen(struct socket *sock, int backlog);
 void inet_sock_destruct(struct sock *sk);
 int inet_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len);
+int inet_bind_sk(struct sock *sk, struct sockaddr *uaddr, int addr_len);
 /* Don't allocate port at this moment, defer to connect. */
 #define BIND_FORCE_ADDRESS_NO_PORT	(1 << 0)
 /* Grab and release socket lock. */
diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 2acc4c808d45..22643ffc2df8 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -1216,6 +1216,7 @@ void inet6_cleanup_sock(struct sock *sk);
 void inet6_sock_destruct(struct sock *sk);
 int inet6_release(struct socket *sock);
 int inet6_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len);
+int inet6_bind_sk(struct sock *sk, struct sockaddr *uaddr, int addr_len);
 int inet6_getname(struct socket *sock, struct sockaddr *uaddr,
 		  int peer);
 int inet6_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg);
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 9b2ca2fcc5a1..2fd23437c1d2 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -431,9 +431,8 @@ int inet_release(struct socket *sock)
 }
 EXPORT_SYMBOL(inet_release);
 
-int inet_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
+int inet_bind_sk(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 {
-	struct sock *sk = sock->sk;
 	u32 flags = BIND_WITH_LOCK;
 	int err;
 
@@ -454,6 +453,11 @@ int inet_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
 
 	return __inet_bind(sk, uaddr, addr_len, flags);
 }
+
+int inet_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
+{
+	return inet_bind_sk(sock->sk, uaddr, addr_len);
+}
 EXPORT_SYMBOL(inet_bind);
 
 int __inet_bind(struct sock *sk, struct sockaddr *uaddr, int addr_len,
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 9f9c4b838664..3ec0359d5c1f 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -435,10 +435,8 @@ static int __inet6_bind(struct sock *sk, struct sockaddr *uaddr, int addr_len,
 	goto out;
 }
 
-/* bind for INET6 API */
-int inet6_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
+int inet6_bind_sk(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 {
-	struct sock *sk = sock->sk;
 	u32 flags = BIND_WITH_LOCK;
 	const struct proto *prot;
 	int err = 0;
@@ -462,6 +460,12 @@ int inet6_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
 
 	return __inet6_bind(sk, uaddr, addr_len, flags);
 }
+
+/* bind for INET6 API */
+int inet6_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
+{
+	return inet6_bind_sk(sock->sk, uaddr, addr_len);
+}
 EXPORT_SYMBOL(inet6_bind);
 
 int inet6_release(struct socket *sock)

-- 
2.40.1

