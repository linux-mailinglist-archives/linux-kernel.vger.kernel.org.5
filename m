Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA25E803DF8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 20:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233837AbjLDTBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 14:01:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbjLDTA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 14:00:56 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D58A107
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 11:01:02 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-a00cbb83c80so661355566b.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 11:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1701716461; x=1702321261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZ0D/wyA9hkFzwdAxUoMggZbpJ8bxr4KljB1d44II90=;
        b=g+XrIukvP0kRCHm1wfbmqM8r0VQVu6xuEBcmVoF30BWysxs/NXepuTJ4VWFsM5KQbG
         whlC6LZMhvoNdi2k3CacicYWvF0WUQxWAIC0bKC1ThkjIkeq+qaoRWiawNzIXXByV8QX
         cXhk+nztqP6KPLMBU0az8sMelaisZxb5TSwVgc1k4UbXTjv8sSrU/rvzJMrnissiIncD
         nHphrmgqi1tLeymm7x5onw2Y6e6OTmcCsX9Ed/7+09cThzsWgEkjmqOnGhtG/aCo5408
         vsM0MbgPm7NKUEgvS/KRWxQMosh2lJNaQ87NpG/sRFbNqzZF9bcYouMjCgBFgv4Y0K5F
         NXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701716461; x=1702321261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NZ0D/wyA9hkFzwdAxUoMggZbpJ8bxr4KljB1d44II90=;
        b=a2FXLgC8GL/80Zf7+NmN4KaQ+kkC2YZH+ILn77H9IoBwH3/aLPIglNym7jjGfyoXVc
         iVbiujlpdkoCwzChZ5+f4h67S1Awv0P6vbIdJ/uX6gj3bc89zSNeatKj/JRcl60ov4hG
         dSuhWJaxKjZQjX3HZ9u1CdetE78JyzPkHotXJEBJG62xbLBTrFtUUN4lLn74F0Xq+XJW
         PiTX9mgU4iSyWSRMA1yleYQkWMGL+aYAN/XiRNM5LZY4J2RUnc02KiYlyJDpZUjn0a89
         2IgPiJh8omYMEzZzBaU6AkYU7Q9sxzOWs8W07Ll5Ht5DemUXDIP8vsBNHp/8WvIPBqpW
         C8QQ==
X-Gm-Message-State: AOJu0YwUi6N8YtnSvPuFEP8SZCdHX2k32u3LR3wj3iAcOfs6/TeUhXBV
        bLYb9y6/xSXvCTOQtXaGtq8Eew==
X-Google-Smtp-Source: AGHT+IEc7vGGV71ZVxCXlwrJR73WOT9vS/GY8jEInO10aGkvo+/egFEHgnMpiVqeaedADYMg7gZqdg==
X-Received: by 2002:a17:906:220f:b0:a00:2686:6b42 with SMTP id s15-20020a170906220f00b00a0026866b42mr2988048ejs.10.1701716460982;
        Mon, 04 Dec 2023 11:01:00 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id dx9-20020a170906a84900b009fbc655335dsm5577614ejb.27.2023.12.04.11.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 11:00:59 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Francesco Ruggeri <fruggeri05@gmail.com>,
        Salam Noureddine <noureddine@arista.com>,
        Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH v5 4/5] net/tcp: Don't add key with non-matching VRF on connected sockets
Date:   Mon,  4 Dec 2023 19:00:43 +0000
Message-ID: <20231204190044.450107-5-dima@arista.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231204190044.450107-1-dima@arista.com>
References: <20231204190044.450107-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the connection was established, don't allow adding TCP-AO keys that
don't match the peer. Currently, there are checks for ip-address
matching, but L3 index check is missing. Add it to restrict userspace
shooting itself somewhere.

Yet, nothing restricts the CAP_NET_RAW user from trying to shoot
themselves by performing setsockopt(SO_BINDTODEVICE) or
setsockopt(SO_BINDTOIFINDEX) over an established TCP-AO connection.
So, this is just "minimum effort" to potentially save someone's
debugging time, rather than a full restriction on doing weird things.

Fixes: 248411b8cb89 ("net/tcp: Wire up l3index to TCP-AO")
Signed-off-by: Dmitry Safonov <dima@arista.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_ao.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index c8be1d526eac..18dacfef7a07 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -1608,6 +1608,15 @@ static int tcp_ao_add_cmd(struct sock *sk, unsigned short int family,
 		if (!dev || !l3index)
 			return -EINVAL;
 
+		if (!bound_dev_if || bound_dev_if != cmd.ifindex) {
+			/* tcp_ao_established_key() doesn't expect having
+			 * non peer-matching key on an established TCP-AO
+			 * connection.
+			 */
+			if (!((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_CLOSE)))
+				return -EINVAL;
+		}
+
 		/* It's still possible to bind after adding keys or even
 		 * re-bind to a different dev (with CAP_NET_RAW).
 		 * So, no reason to return error here, rather try to be
-- 
2.43.0

