Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E037FDDBD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 17:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbjK2Q5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 11:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbjK2Q5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 11:57:33 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DAD2C9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 08:57:38 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c9bd3ec4f6so113801fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 08:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1701277056; x=1701881856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xsdu422pJQjO0BqPdllEZym2Fb8ES6Mcal0EPWQmR7E=;
        b=f9KL3HCOpaCvbTPJvpOn8D0J3f1avIaNEjj+RMSuSeFUKWJAvCwHuqitcdo3qetluG
         g5HacNcFJWcDNKTuAFtv3sE+QeVR2jkC5EXJFQ7Rq633wQHwiGRTQu5ryaGLm77KmkpN
         44Vl8SmP5zgXVtzMHUNbEju9HivJ/2xZP6UE7qjYNMSODcBFIFwGeTTvvUeKKCo3YmUW
         EN85tZS/HIX9TQOGgPaoDgT3kUCD86ApRAlgpepk3b/y/nefI099bJYh3OmL2iMw7JD4
         He9igxqxABuke729glawqOj4jSQoawZLum6PpVCVCehmsAL2JKhk6ebu1dU8zt1BFaO3
         Xlhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701277056; x=1701881856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xsdu422pJQjO0BqPdllEZym2Fb8ES6Mcal0EPWQmR7E=;
        b=cr3bdOyhemJaBn7BkmH6DJs97HrI9tm/xOVPlJRpgcZ5GOUbomaiGBoDsMAf1Hp6tE
         cViU1G5Xnq5TFZ6DKYnsM3n1LoigGZg9BjqEnDH8LbSE0ubT/a5VEmbT2OOGQnmia85e
         7Wm5zc0JVoZkyfNkCqh98jZxgP2Lxuh643SKjwOXnznogI5jfDUcRWxXR7wcWTkuTo1e
         Spz9/F4y6fy6jCJpF8jWIWqxp89+E4nCPU/fhftlWVdtlIkyUBnHTOHxQR8qidlPX7Ku
         VZF9pQk/gC6/NqUMM0qSF2javN4RQJWdaPE5Fgx6Wa1ioNpvXjwEy4g1+5rYU9Nfe+y0
         ewOQ==
X-Gm-Message-State: AOJu0YxLXL9PQj+fmeGtKbYXAxVVJGQdEwuxaomzShvHN2sj26GnLlX5
        fDCsImwIxGYIg8gTOQlxqyFbUw==
X-Google-Smtp-Source: AGHT+IEBO3LAafujznmh7ddUReBPPzlczL2XBtI86mq9ciLp32HOOwqam9My6KHDcct7H9Y/uKljTw==
X-Received: by 2002:a2e:80da:0:b0:2c9:bfd4:28a5 with SMTP id r26-20020a2e80da000000b002c9bfd428a5mr1496955ljg.16.1701277056099;
        Wed, 29 Nov 2023 08:57:36 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id s20-20020a05600c45d400b003fe1fe56202sm2876823wmo.33.2023.11.29.08.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 08:57:35 -0800 (PST)
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
Subject: [PATCH v4 5/7] net/tcp: Don't add key with non-matching VRF on connected sockets
Date:   Wed, 29 Nov 2023 16:57:19 +0000
Message-ID: <20231129165721.337302-6-dima@arista.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231129165721.337302-1-dima@arista.com>
References: <20231129165721.337302-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
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
---
 net/ipv4/tcp_ao.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index bf41be6d4721..465c871786aa 100644
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

