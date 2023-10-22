Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D817D2468
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 18:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbjJVQVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 12:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbjJVQVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 12:21:21 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A73C10C1;
        Sun, 22 Oct 2023 09:21:16 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-66d0252578aso15194016d6.0;
        Sun, 22 Oct 2023 09:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697991675; x=1698596475; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L9nmUOkKfIxBe7DzbH5F4LEDHwA5kfNEZqtAsWyLPwU=;
        b=Xn7NapXwronFR0XjGUojZsSQxowyVQvV5VkrJxAeajK5YTCkdxohvU7gmFhEe8b3PH
         64jWUubER+FxSmmW4fAf3LW+9cNbAxjpYJtwLuT9jntJzIA3x5nHQflnqPGjUPfcWMKH
         exmfLVTf3v8YaXcoBkadHbq4fgtfFeNxHIe+kZdg0gWjGGclfvT5ngnz+gSXvNa26485
         BZQnr/CLFmoPbpspMshG2c8uCutvKopzka0VXDmrwui6Slaf4IEI5uk2jMfgiGwQki+k
         3hTvFp8CN8wQPYfeaQqfLJjRgVrigaN55oqnqjAxsmTP7O71Mg6bJPExkpE5SitseFo2
         ZhXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697991675; x=1698596475;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9nmUOkKfIxBe7DzbH5F4LEDHwA5kfNEZqtAsWyLPwU=;
        b=OaL15dKX9qMuKlrnhybdbocUOAtTLb2IFUg2ElalWqvDz+efpbZTlWCI+UmEez/Psj
         u3xW33OxIaflS6m+PXBCY4Dm88W888H6NH4kmVbfwSi7wT0Q4LVJYnzbaNIwN+Xv7//d
         715z1JdDLpNZtbs8DA6VOSnCHzIpqBBWqWJVUNcNIoQPxsC2ousKI2K7Obwxe03RQjAU
         YHsmNCGwgF9HfAIyy2Pok3zkQu9SzfieRZzCjSpcTao+Ear/ObY+zomrydMQ4TsAe9p1
         TrMNwmS2e1B1RorLiq4w1YYjpHAY3C89t4WaikznZG7ZsmBpISlFDudHXJdCTIt0KH0w
         9sVw==
X-Gm-Message-State: AOJu0Yy7V59PJ2YCYetF2ed4ty4hnrqNzERFPF5TUn7rUyPKAkHMIL0d
        L2BOI2WJ1oSOuXIdXw7o9oqPqNRmmKUEaEdw
X-Google-Smtp-Source: AGHT+IHLO1LSxjJmfXaqwDlW3NSplIpBnFh9w0CryYe+5riYYQGv1IrFMtcDPSTtJYNGFSH0IEvGyw==
X-Received: by 2002:ad4:594d:0:b0:668:ecf4:d9b7 with SMTP id eo13-20020ad4594d000000b00668ecf4d9b7mr7258114qvb.8.1697991675021;
        Sun, 22 Oct 2023 09:21:15 -0700 (PDT)
Received: from localhost ([2601:8c:502:14f0:d6de:9959:3c29:509b])
        by smtp.gmail.com with ESMTPSA id v2-20020a0ccd82000000b0065afa998364sm2260717qvm.95.2023.10.22.09.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 09:21:14 -0700 (PDT)
Date:   Sun, 22 Oct 2023 12:21:14 -0400
From:   Oliver Crumrine <ozlinuxc@gmail.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     davem@davemloft.n
Subject: [PATCH net-next 13/17] Change some instances of cork to a pointer
Message-ID: <94dac142f2e312e2f3bc7926d5752a1059075d89.1697989543.git.ozlinuxc@gmail.com>
References: <cover.1697989543.git.ozlinuxc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697989543.git.ozlinuxc@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes a few instances of cork to a pointer in accordance with the
previous patches

Signed-off-by: Oliver Crumrine <ozlinuxc@gmail.com>
---
 net/ipv4/udp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index f39b9c844580..51b64024124b 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -981,7 +981,7 @@ int udp_push_pending_frames(struct sock *sk)
 {
 	struct udp_sock  *up = udp_sk(sk);
 	struct inet_sock *inet = inet_sk(sk);
-	struct flowi4 *fl4 = &inet->cork.fl.u.ip4;
+	struct flowi4 *fl4 = &inet->cork->fl.u.ip4;
 	struct sk_buff *skb;
 	int err = 0;
 
@@ -989,7 +989,7 @@ int udp_push_pending_frames(struct sock *sk)
 	if (!skb)
 		goto out;
 
-	err = udp_send_skb(skb, fl4, &inet->cork.base);
+	err = udp_send_skb(skb, fl4, &inet->cork->base);
 
 out:
 	up->len = 0;
@@ -1068,7 +1068,7 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 	getfrag = is_udplite ? udplite_getfrag : ip_generic_getfrag;
 
-	fl4 = &inet->cork.fl.u.ip4;
+	fl4 = &inet->cork->fl.u.ip4;
 	if (up->pending) {
 		/*
 		 * There are pending frames.
@@ -1260,7 +1260,7 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	/*
 	 *	Now cork the socket to pend data.
 	 */
-	fl4 = &inet->cork.fl.u.ip4;
+	fl4 = &inet->cork->fl.u.ip4;
 	fl4->daddr = daddr;
 	fl4->saddr = saddr;
 	fl4->fl4_dport = dport;
-- 
2.42.0

