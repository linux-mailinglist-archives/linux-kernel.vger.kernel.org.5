Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF9C37793A6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 17:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236806AbjHKP7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 11:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236751AbjHKP7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 11:59:00 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A55830E5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 08:58:57 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3090d3e9c92so1898081f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 08:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1691769536; x=1692374336;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t+XgaLGpUVP+G9qnOB0ZNXJDWKPyu+7aNgrOOBV4CXs=;
        b=Wge3t0yMVuay4tm8zdBQ9VyeL6OLJAnYtN8V9iwiqU8TvRM5ND9ERv/8i2Y0FArvFQ
         tyG+3O1nerD6rcqBCbg2Yxi/GEjlgN0VeHNCzZWoK8KmI2UeXphNC4ct39rAWNHhOq6n
         g3MxOHl1F/R3iVZaFvULiNeXrTd5HPlV4+zO97TksYClBrDGyBmm4kRFzTQccpHZLLyG
         jXFYRE99H23TempgCoan3vs01e8+KRWka4tBP479RADB9zjrIIFJ64LnP/2iwPPymaWX
         OkJg6VAAsx3QO7crW4QlH020KhacJUh6CmeEv8xlivqVhmJYQ7RUE1o45BE134rD1wev
         Scgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691769536; x=1692374336;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t+XgaLGpUVP+G9qnOB0ZNXJDWKPyu+7aNgrOOBV4CXs=;
        b=Xk2ncjNSLBbJG4x+w/eAoEnJ32BrbqsaNeeOkVI5fGe2KPX8V3miUV9rp1zN8qZVPu
         2+iLzNNg8t3KrFaqn72/6SW0Im4tvbcKlNSBOqPa9diivfyp+xUlip6qB/Sf9yxVlIHM
         9vJ3R5SJFZLtmyNnooL/Mj1bcZ4SXG2ZuW2kvU+RtaXUY8tkjskSDyoqAFwpQZydUudh
         C/ph1xQPRwICZFxuWcu0oMc+Xs3w9yJO/PvLFC6gMuo9Wk18FKsHiHwY226S3Dt8dsC3
         2rCs9hgWbC6xsW7vdxoykiPF+kDr+KVAJxZT4dwkTiYBq065NXJXtuwmRX/0dvWineA1
         vdOg==
X-Gm-Message-State: AOJu0YxcaypUJd/uQVqTNKVQmJB+3DUlYfJZ8ZBD8DfwAMCA7N/35HA2
        oNU0XxBycwYl3F34trdeo9sXjA==
X-Google-Smtp-Source: AGHT+IH+uijgDdhfb4MCBOghDLHl+5AuYsKXMZMFSQo58jr8ReplmmJKvjmkcb9cb2D4E1oZaQweCQ==
X-Received: by 2002:adf:dccd:0:b0:317:5a9b:fcec with SMTP id x13-20020adfdccd000000b003175a9bfcecmr1553679wrm.14.1691769536025;
        Fri, 11 Aug 2023 08:58:56 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id m12-20020a5d4a0c000000b00317e9c05d35sm5834308wrq.85.2023.08.11.08.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 08:58:55 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Fri, 11 Aug 2023 17:57:27 +0200
Subject: [PATCH net-next 14/14] mptcp: Remove unnecessary test for
 __mptcp_init_sock()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230811-upstream-net-next-20230811-mptcp-get-rid-of-msk-subflow-v1-14-36183269ade8@tessares.net>
References: <20230811-upstream-net-next-20230811-mptcp-get-rid-of-msk-subflow-v1-0-36183269ade8@tessares.net>
In-Reply-To: <20230811-upstream-net-next-20230811-mptcp-get-rid-of-msk-subflow-v1-0-36183269ade8@tessares.net>
To:     mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Kuniyuki Iwashima <kuniyu@amazon.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1657;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=9eUzQsTH9C4lw0Wrk8AIKRJ6c0bqe3QPvYFbn9S2V3Q=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBk1lqwU7yF3k2xiGkkBmwynf1c4Z1lknA9Khwon
 buB7uDg15eJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZNZasAAKCRD2t4JPQmmg
 c53oD/9Cm0tzdEzZtSh2bD4u/FrbdFha+H7oI7jW05zlpsFeQAA3EQLy5H58wxt8lTY6tbB3ENZ
 MHZa6zrGYtWnVl3BEO8/JPEa1wSXa2BT+Ke/fk2NRWhHV8w/7w426oiEurwvMZgpU2U/l6rlpFi
 3vRvAO8KgA1CDraah31q+rj0LD40A//lSUC5rcG/XtrqIduqvyo/Mb0+sqQ66guhuzAPYRGj1Qk
 3A0OAwr9kMd6ie34lrH4wle2YQnZku78y5+KjTPgKR3/m+tdn4AtwdqvsGHZsxjwRf9GwgUeXsU
 jkwWJSEN5bHVOChix6B/qGM8ziHaGa+Icc23/wR1ZMBRfhzD6i5NuljgtALxngwomGPkaMHZUCy
 7pgM497BTMGffB7C7NPkHSuYmykvz+xAlJgcTLgLL83dweYf6NoFvRgie/vjHwBc4m+MooOJhZy
 jdGsO7K8gEB94e6a34UTYdtZAtiyUABk/qr2KYHzdU4zdOT05/7V14EJZRXdR8ZT8CakcEBP7XG
 fJdRjfUt7lnMcpGT5hKYMGqP8ZSmkTY4SN+j7kE0/8jNzYkifmuiSgp773MGvtbrDf0ONREBNBL
 Hr6lp1QGjLPxsdtKiHaEbI4NW5pl3ZmwlvQ5wKs80e9cM2+PJFX6+1Dn20Xdx8e3wrDIPF8dXbk
 eqm6CsASm8so4Og==
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

From: Kuniyuki Iwashima <kuniyu@amazon.com>

__mptcp_init_sock() always returns 0 because mptcp_init_sock() used
to return the value directly.

But after commit 18b683bff89d ("mptcp: queue data for mptcp level
retransmission"), __mptcp_init_sock() need not return value anymore.

Let's remove the unnecessary test for __mptcp_init_sock() and make
it return void.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/protocol.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e715771ded7c..6ea0a1da8068 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2649,7 +2649,7 @@ static void mptcp_worker(struct work_struct *work)
 	sock_put(sk);
 }
 
-static int __mptcp_init_sock(struct sock *sk)
+static void __mptcp_init_sock(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
@@ -2676,8 +2676,6 @@ static int __mptcp_init_sock(struct sock *sk)
 	/* re-use the csk retrans timer for MPTCP-level retrans */
 	timer_setup(&msk->sk.icsk_retransmit_timer, mptcp_retransmit_timer, 0);
 	timer_setup(&sk->sk_timer, mptcp_timeout_timer, 0);
-
-	return 0;
 }
 
 static void mptcp_ca_reset(struct sock *sk)
@@ -2695,11 +2693,8 @@ static void mptcp_ca_reset(struct sock *sk)
 static int mptcp_init_sock(struct sock *sk)
 {
 	struct net *net = sock_net(sk);
-	int ret;
 
-	ret = __mptcp_init_sock(sk);
-	if (ret)
-		return ret;
+	__mptcp_init_sock(sk);
 
 	if (!mptcp_is_enabled(net))
 		return -ENOPROTOOPT;

-- 
2.40.1

