Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1EB779396
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 17:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236682AbjHKP6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 11:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236675AbjHKP6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 11:58:44 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA9730D4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 08:58:43 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-317b31203c7so1925250f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 08:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1691769522; x=1692374322;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k5X9dCBbAfU6DjT+NDvr2dXxeO/cfwiJDXtpifKgXlA=;
        b=AfNHOQJ2nkB4iLHU0XVMtVVb1UTnxAlXjmudsfmcOaORZaxOvRzrr6koOLBpjL69QQ
         tt9xfEhLwbWEL3B7zOiiJ3zwChgyoycobsJf7svUsEVpCMgPOLnp3DPZtSoOnpVwxKDb
         18FBd+zzEuVvYjyW1rujienvRQtSWWwKZMXGN6ZfK7/X3GRIsk4s6KKUq6Iiy26aWt6H
         gmoTwFWF9zbFCXa8wxuWHRN2D6xzLGJg8vmjzlFdVyvV9h2whRtMfhHnzPBSyY7yLkO4
         6CnTY9+d+D8b4YjvYmH8zjFo2tLhlqIO41WsVPYxWAyBdtCH2il3OvT08DS2+ywhFiiG
         HYtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691769522; x=1692374322;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k5X9dCBbAfU6DjT+NDvr2dXxeO/cfwiJDXtpifKgXlA=;
        b=T502YaQVzrOWXsiRuAh0IJAa7bWB3jibeRcmfrjuD3/TzwRvfg8fIjIXBTsVE55xbk
         Ffak6PyXhpwSqd1KqDq9dhsJvIEyB885fhzt+fi6laz2ZwV9g6VnuSl5DXfQ7ygtoTi3
         nSKRIzGrq49yIgh1kPfJuhQCuTOe7DphLkl8X/SIdN6vctvXmYyqvh1HyydrjjxZ+dYZ
         a0TieOn8VIGdtLo2umGTrTPRN5CWCKdJEtU/7WTgyNhW3IfC+vIiHU4uzA5n7qUFONuy
         dxsX6DtXi07c1C9OySkcZu6iF1qOjx76TUqILzMr2aKnRLVv1/TxWxvKgmkqK9GdozFK
         bHUA==
X-Gm-Message-State: AOJu0YymESycpd20e5Q1l58y3kMhQAhXnmqED/CD8t7vci7vPspxblhY
        16AqyNDQtFYo8qLzFfu8PgwZkg==
X-Google-Smtp-Source: AGHT+IGSD4ePtHDWsMuK7XQNepQL96MNQFK7TtCmw2t1Syvy1CL8jN95/AgxPjnyyfqTQtK9EQ0vVw==
X-Received: by 2002:adf:fc0f:0:b0:314:3a3d:5d1f with SMTP id i15-20020adffc0f000000b003143a3d5d1fmr1851910wrr.19.1691769521953;
        Fri, 11 Aug 2023 08:58:41 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id m12-20020a5d4a0c000000b00317e9c05d35sm5834308wrq.85.2023.08.11.08.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 08:58:41 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Fri, 11 Aug 2023 17:57:14 +0200
Subject: [PATCH net-next 01/14] mptcp: avoid unneeded mptcp_token_destroy()
 calls
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230811-upstream-net-next-20230811-mptcp-get-rid-of-msk-subflow-v1-1-36183269ade8@tessares.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1720;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=gXoRie7DLKf3vWVejVmTZfC//Kg+jCDe1+Txjp6fEyI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBk1lqv+r3KsHtF8v8Wo26pcmdkgVeFoZMKt2vnr
 HOE8E3VCBeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZNZarwAKCRD2t4JPQmmg
 c5hhD/0c8KK8DF9+DihPAJVsBCw7OJK4Qsqj2v1GgkbmoYkVV/vFyweuzcYBNmZTwHt0Su6nykO
 yTlwWPLLzZhhIAXBOXbC3XB7d2jkyS3h2pqF/9NcTWo8weFJ8uSMbNlAe7PnjeMAIpzPkJrEK8H
 4YkzZK9+ntc2MMMzT73WfsF5iC+FruQYPx/OhwC6yAEVeJ23v5qxEJJojrDZJN+x51fFdQdJNF/
 QvsWBAWSLqAXLxy+4Ds9b8q8FMkIXKXIaws85ymRXZ/94L20W9rPdHHljK1Ek1hYlHbD8LJNcxO
 No80OBKqkrAXLp3LEsaADiPDGyDQSMeaWkRjFZlSj7dybAooRafbK8PZ1Da3GUJsR3Iv8cbj+9O
 cjhYtxdA6xrGd7MsTFO2pwlVGHp3NCJQyIyqoQFgpjflevMdPrfX/1kA0i/dioxVacgWg8/5uLO
 5S0HrjyyGNyngounFXMI4f4Lsouhe0X+DgUcSLMUqyEb+Dpt3XyyIh+nZDOFc9Ivvi1pzkGYovL
 fLLChmmsbzNCGm4exod+n3UvNvo6upaYtM9NJqaT8A7u8XfsWA9bbICQ2IVtU1htskbe1U0L1Bn
 Qyhhfb59KB54aTJX647M05snl4oFlidlaSmSjVcMZKw2963aE61PrSJtRdVXw2g/wzH2L6b4HFU
 8k5iDsBxKuQShNg==
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

The MPTCP protocol currently clears the msk token both at connect() and
listen() time. That is needed to deal with failing connect() calls that
can create a new token while leaving the sk in TCP_CLOSE,SS_UNCONNECTED
status and thus allowing later connect() and/or listen() calls.

Let's deal with such failures explicitly, cleaning the token in a timely
manner and avoid the confusing early mptcp_token_destroy().

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/protocol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 48e649fe2360..abb310548c37 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3594,7 +3594,6 @@ static int mptcp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 	if (IS_ERR(ssock))
 		return PTR_ERR(ssock);
 
-	mptcp_token_destroy(msk);
 	inet_sk_state_store(sk, TCP_SYN_SENT);
 	subflow = mptcp_subflow_ctx(ssock->sk);
 #ifdef CONFIG_TCP_MD5SIG
@@ -3624,6 +3623,8 @@ static int mptcp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 	 * subflow_finish_connect()
 	 */
 	if (unlikely(err && err != -EINPROGRESS)) {
+		/* avoid leaving a dangling token in an unconnected socket */
+		mptcp_token_destroy(msk);
 		inet_sk_state_store(sk, inet_sk_state_load(ssock->sk));
 		return err;
 	}
@@ -3713,7 +3714,6 @@ static int mptcp_listen(struct socket *sock, int backlog)
 		goto unlock;
 	}
 
-	mptcp_token_destroy(msk);
 	inet_sk_state_store(sk, TCP_LISTEN);
 	sock_set_flag(sk, SOCK_RCU_FREE);
 

-- 
2.40.1

