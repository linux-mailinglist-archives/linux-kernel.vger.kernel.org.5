Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE8537793A3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 17:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236782AbjHKP7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 11:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236716AbjHKP6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 11:58:55 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5BF30DD
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 08:58:51 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fbea14706eso18726295e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 08:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1691769530; x=1692374330;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8p7hz56BvINY3bYnl+8763aXFv1bqlZKj1UXcfxTM+A=;
        b=a1cUMQYvxGodmKZuN0U3paq8749qJLSolfZfU9LZW7mhsN12u/vcKYlNfVEvpeKua/
         RSmJgd1SNHQdt4lIQsjrfenFY/IX2BrdTWGD9BQ80j3g4WZXiX6YQj6gNAsjrvPGxjes
         Ufmxo0b5XJenWZ4KJy/ajW8xU1VBSu9ujiwUAnGHkMiQw1VKWzyrxvlPjAVgRhPZpQwB
         7aI+LtZOe2SUU61zO8ayLhK9z8ypD6Dw92oKbTg3/Tz9zf0rPFFTAT3sSuyEhIrJ5yyj
         E9sVzAsk3NTtBt5FEUTwRnB+1Hv5aujTj6AcCwU2IQrpWI3xPO/BYBbDQhzvpFMouPB7
         PtcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691769530; x=1692374330;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8p7hz56BvINY3bYnl+8763aXFv1bqlZKj1UXcfxTM+A=;
        b=NAeN6RzjHPBCqYFOXuFsbkImONrsBvyw4ZA86iqoZYVUTuK0l+QB92K+I57GheI+A/
         ZrZYMGibFWLkrakI4Pqy+B1tq9HrfVMoLnxeLZt+Jj2EjKwzLQR8iJH5NHFHD64gD67h
         u3m3bnUMW5kJg3jEuOCNByf1pucoKzcw4eoShP5ZUfUItbhGHbfNhn2zKRrCoLE8KEJW
         +sVYpZ++4LZDlYvm6aX5bszFbj/ibAYEuJpYYF4CdTDTihIP8/zsHhOLEIuXS4t71pey
         IbckARitN1F0kHa9HLU8C2o9uFvPP4nomZ0qUSPFdc35+CAlVXQBcP4Imc7o6OMKYsDf
         /oJg==
X-Gm-Message-State: AOJu0YyVKCJcSowEqRKVLkI46kbrdvswASmqrXkIOCW5HadJghT632QW
        vG00JTUtaCu/G3nCkvKZb3gATg==
X-Google-Smtp-Source: AGHT+IHuN2kBxo5vJotiYC5W0zdFQwerKWvpkbHQuZiEAiyVgP6xmAYbwPwozJl7J+DOCN6OUJ7+mw==
X-Received: by 2002:adf:db02:0:b0:317:6262:87af with SMTP id s2-20020adfdb02000000b00317626287afmr1780157wri.16.1691769530265;
        Fri, 11 Aug 2023 08:58:50 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id m12-20020a5d4a0c000000b00317e9c05d35sm5834308wrq.85.2023.08.11.08.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 08:58:49 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Fri, 11 Aug 2023 17:57:22 +0200
Subject: [PATCH net-next 09/14] mptcp: avoid unneeded indirection in
 mptcp_stream_accept()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230811-upstream-net-next-20230811-mptcp-get-rid-of-msk-subflow-v1-9-36183269ade8@tessares.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3045;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=ezLN5rJDn0TKO1JLa8QX3XwohNG5LslqBliGtaEoxsw=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBk1lqv/lFxB/q1xOo6Csx0Xdq2xu9hotDvV06g3
 sPqycFbHI6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZNZarwAKCRD2t4JPQmmg
 c282D/0YBufkFft2xSGrrVTQKpXzWqy831F4wJMr0YYiSFFjo6t89EoMlCfqAA6Hi7PhgT8zjre
 lZ7XLHyFEoqT0kcRbZkRecPf6ufbznmbi0DSXRLLtW1T5yZCx+MSgGL+nddqIr+j7d5p8JLYWIC
 Uj9v5uObKodFM3Zc9KlK/aqJ0Wlti5is16ableDYRk+6u7QzLJVt6UUOgiAgDs3mNA/VCHoysOU
 78L2m/REztuWfSsDwmNcl4dEsNn6nLfxo6uUJALQOR6NEVtrrhy8zBiWjBWGGS4swP7++luhdhN
 mUpnMYiCzxyx4rACw7tho5c5ruF+IrFkDBgwrm5B6s9FrvsC+ZqX//AB2dIbKVOXJSdjBOqwrVO
 JDLQBk06QM8GZiZVzI5+UZCfgsZwI3TTlRZJk1LrrxYCnSpLtvBOp6srC1V33iqUFaaqmESfHgn
 PgPRj4tqPwo/n53/etr+/FGO3B3HvatVudlgHJffISYDreLC44waaztHUMOFs4JraTim70bq5UE
 4qCXED30ysbD0zbBVYxnMFYFmmkH2Ig2niuukH761p5M86YFa9lrS8Ae0CwsSosY35YYfw3H9+1
 wH2Z9UUn5XiW//D8W7VJVz0Y9ACfBHxuBioJy5pqdJluWqf5E5Lr1rvE09vbUjkSd1pmOgzOEOI
 pJJ2zxuw4QcPZhQ==
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

We are going to remove the first subflow socket soon, so avoid
the additional indirection at accept() time. Instead access
directly the first subflow sock, and update mptcp_accept() to
operate on it. This allows dropping a duplicated check in
mptcp_accept().

No functional changes intended.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/protocol.c | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e89d1bf44f77..e5ebd170d316 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3174,25 +3174,17 @@ void mptcp_rcv_space_init(struct mptcp_sock *msk, const struct sock *ssk)
 	WRITE_ONCE(msk->wnd_end, msk->snd_nxt + tcp_sk(ssk)->snd_wnd);
 }
 
-static struct sock *mptcp_accept(struct sock *sk, int flags, int *err,
+static struct sock *mptcp_accept(struct sock *ssk, int flags, int *err,
 				 bool kern)
 {
-	struct mptcp_sock *msk = mptcp_sk(sk);
-	struct socket *listener;
 	struct sock *newsk;
 
-	listener = READ_ONCE(msk->subflow);
-	if (WARN_ON_ONCE(!listener)) {
-		*err = -EINVAL;
-		return NULL;
-	}
-
-	pr_debug("msk=%p, listener=%p", msk, mptcp_subflow_ctx(listener->sk));
-	newsk = inet_csk_accept(listener->sk, flags, err, kern);
+	pr_debug("ssk=%p, listener=%p", ssk, mptcp_subflow_ctx(ssk));
+	newsk = inet_csk_accept(ssk, flags, err, kern);
 	if (!newsk)
 		return NULL;
 
-	pr_debug("msk=%p, subflow is mptcp=%d", msk, sk_is_mptcp(newsk));
+	pr_debug("newsk=%p, subflow is mptcp=%d", newsk, sk_is_mptcp(newsk));
 	if (sk_is_mptcp(newsk)) {
 		struct mptcp_subflow_context *subflow;
 		struct sock *new_mptcp_sock;
@@ -3209,9 +3201,9 @@ static struct sock *mptcp_accept(struct sock *sk, int flags, int *err,
 		}
 
 		newsk = new_mptcp_sock;
-		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPCAPABLEPASSIVEACK);
+		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_MPCAPABLEPASSIVEACK);
 	} else {
-		MPTCP_INC_STATS(sock_net(sk),
+		MPTCP_INC_STATS(sock_net(ssk),
 				MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK);
 	}
 
@@ -3761,8 +3753,7 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 			       int flags, bool kern)
 {
 	struct mptcp_sock *msk = mptcp_sk(sock->sk);
-	struct socket *ssock;
-	struct sock *newsk;
+	struct sock *ssk, *newsk;
 	int err;
 
 	pr_debug("msk=%p", msk);
@@ -3770,11 +3761,11 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 	/* Buggy applications can call accept on socket states other then LISTEN
 	 * but no need to allocate the first subflow just to error out.
 	 */
-	ssock = READ_ONCE(msk->subflow);
-	if (!ssock)
+	ssk = READ_ONCE(msk->first);
+	if (!ssk)
 		return -EINVAL;
 
-	newsk = mptcp_accept(sock->sk, flags, &err, kern);
+	newsk = mptcp_accept(ssk, flags, &err, kern);
 	if (!newsk)
 		return err;
 

-- 
2.40.1

