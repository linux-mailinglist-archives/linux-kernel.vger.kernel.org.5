Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED34E7F2374
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 03:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbjKUCBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 21:01:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbjKUCBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 21:01:32 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778E6E8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 18:01:28 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40839652b97so19540455e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 18:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1700532087; x=1701136887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yb/w+BKw85BILJP8CTg75niZjZVcbAJYfunsL97APOE=;
        b=TYkx5l5HsPBsUxmethudoPU7KItkL6Z9NbWPNmRDNR2pNDYb6J60Tkwn6HqGhmaC7z
         xP+PYJ8qvTY3R78qTa7IkP5NvASc7cQTwFW+b2Dw1MikmusEOyg/KsD4FJToWSxgnbJ3
         tcBUPfJWPe3uSECiyqljJIRoYa+lGZ0cNIsSp/00GqTTiENcXvfXo7i9tcCr96DqLbuW
         VoZ5NLlbeXNIQgW7A16Yua+K/BwfsKwzEaqp8eJcZ1USLEQKAIQZrj4rymtnRJ0WHnXo
         Kbw1ABYzEkL/GbqW65tKGak+HgORJaqx63J1Y7C9n8X2vHclhflswHuQfGus2etuDWja
         CUcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700532087; x=1701136887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yb/w+BKw85BILJP8CTg75niZjZVcbAJYfunsL97APOE=;
        b=b0nHnNkJNGzaMWG2zWmgDpN+/4C97U+IoGwT2GMeTjC029vg+3OdUiCnL0SL+UPIzD
         JRP+SPzN4sccKv8srE5cT92gemD3hhA8munKQiuKsof7xqL0ABbpKDcmffpCkLVCOBVB
         pZSIjcIS253cclssrarPAvD1ZMU3jYp35mvVa1ygOo3oVOpIdjn20HgrkASE+q/9wQsJ
         SwBzR9LFUzWtf6v6pMW7QPyxhyar/a0ADk3yaNKbNuHNzJjiBedCKs2FtF+XcGol5zPN
         XHJM5G1J+YCO9ugMB4Wdg58J6R5E14aygyAjFFmLbvWDrdozNdCVScA8mt4WhMu0hG3H
         cpaA==
X-Gm-Message-State: AOJu0YyRcb9LAQCuRsq6SuKaZB5/m+islP+5QB+n0vsgmGbFTe7Ou1qj
        v4gwhFRUsSrNLU9KYqUieDrMMw==
X-Google-Smtp-Source: AGHT+IEVaDa9ATxoPYSGDjhsp5Kzj85OQPWhli+6R2u4dfdYhQZgJKQrddrShkTsXOzgbH54ov/2qw==
X-Received: by 2002:adf:f0d1:0:b0:317:4ef8:1659 with SMTP id x17-20020adff0d1000000b003174ef81659mr5885838wro.28.1700532087011;
        Mon, 20 Nov 2023 18:01:27 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id c13-20020a056000184d00b00332cb846f21sm2617105wri.27.2023.11.20.18.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 18:01:26 -0800 (PST)
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
Subject: [PATCH 6/7] net/tcp: ACCESS_ONCE() on snd/rcv SNEs
Date:   Tue, 21 Nov 2023 02:01:10 +0000
Message-ID: <20231121020111.1143180-7-dima@arista.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231121020111.1143180-1-dima@arista.com>
References: <20231121020111.1143180-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SNEs need READ_ONCE()/WRITE_ONCE() for access as they can be written and
read at the same time.

This is actually a shame: I planned to send it in TCP-AO patches, but
it seems I've chosen a wrong commit to git-commit-fixup some time ago.
It ended up in a commit that adds a selftest. Human factor.

Fixes: 64382c71a557 ("net/tcp: Add TCP-AO SNE support")
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 net/ipv4/tcp_ao.c    | 4 ++--
 net/ipv4/tcp_input.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index 122ff58168ee..9b7f1970c2e9 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -956,8 +956,8 @@ tcp_inbound_ao_hash(struct sock *sk, const struct sk_buff *skb,
 		if (unlikely(th->syn && !th->ack))
 			goto verify_hash;
 
-		sne = tcp_ao_compute_sne(info->rcv_sne, tcp_sk(sk)->rcv_nxt,
-					 ntohl(th->seq));
+		sne = tcp_ao_compute_sne(READ_ONCE(info->rcv_sne),
+					 tcp_sk(sk)->rcv_nxt, ntohl(th->seq));
 		/* Established socket, traffic key are cached */
 		traffic_key = rcv_other_key(key);
 		err = tcp_ao_verify_hash(sk, skb, family, info, aoh, key,
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index bcb55d98004c..78896c8be0d4 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3583,7 +3583,7 @@ static void tcp_snd_sne_update(struct tcp_sock *tp, u32 ack)
 	ao = rcu_dereference_protected(tp->ao_info,
 				       lockdep_sock_is_held((struct sock *)tp));
 	if (ao && ack < tp->snd_una)
-		ao->snd_sne++;
+		WRITE_ONCE(ao->snd_sne, ao->snd_sne + 1);
 #endif
 }
 
@@ -3609,7 +3609,7 @@ static void tcp_rcv_sne_update(struct tcp_sock *tp, u32 seq)
 	ao = rcu_dereference_protected(tp->ao_info,
 				       lockdep_sock_is_held((struct sock *)tp));
 	if (ao && seq < tp->rcv_nxt)
-		ao->rcv_sne++;
+		WRITE_ONCE(ao->rcv_sne, ao->rcv_sne + 1);
 #endif
 }
 
-- 
2.42.0

