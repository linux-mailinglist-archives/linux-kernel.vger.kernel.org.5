Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E917D405B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 21:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjJWTgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 15:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233677AbjJWTXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 15:23:50 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543B119B9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 12:23:07 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4083f613272so31358255e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 12:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1698088983; x=1698693783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yFuTyTJaPxOlc+JRRqn8TS1+jZrCOoj8k+Va4Di7hSE=;
        b=UbS5Tx/FTwa44h+qaKvnKCeSPT2M013EBqImC5t66Y52QoAXzy2r19gCcxpMfu5QLz
         J8guOTXOagpwEsNAForVAYKrU4bG6xJTbBc++vay8XjTJgCSUf4m1EgmTfII9RRX8UWx
         oW8QL0+7Wexy5Z8jj9NIAFu+8+VUjKaCQoGox4IhW24OdoqK9EwjMyAYtoqOE5a8NmbO
         lEzNDPZ7ry9F26KPKR4bAS3WqFkMF7fyG9UwNlsiGrQXpPtPxurHjd+WxLDGWRi2amBo
         YrTE1bqyz3KKUpjzg/FElTpKvMjpWFYopaYQFf4YMT0ekqAsKBGdeySVS8U7dfnW9k9P
         kdcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698088983; x=1698693783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yFuTyTJaPxOlc+JRRqn8TS1+jZrCOoj8k+Va4Di7hSE=;
        b=I63Ayip7GIydDw09hhbWhbluMbEKiDEZNyFYLB37V7OgAjclc72etiNtKSpn/Mnhlm
         +s7TmfyHVJgF9fldstkxttmHRt0XJ25ZsJbtw8BIGlLJLg83H2oaaRs282slMx7ALXyw
         3D9OQtxNdfT1mo/6i/oVVNYKFfHc/BiIMhzEkPxBPKvVI0lMVjoSMVMWV8EsLB6JE+kV
         jMBLqfAup+enNq34ob7ZUMQtCnbsmneXvFaCoo3G4d3Q/lZsao3SjA6vqxQyRwMphhem
         vvA2hPsDmNQRpNTJsT4M2ejS8YerroOw1CnoD37VDAbjMllxPQkkGSXOLfTMNReFBh10
         uJTQ==
X-Gm-Message-State: AOJu0Yx9cvVllQqAU0ANCTdICeJKrlBIB27Hh13VRPPzgW3qVsIbifmV
        Zi97VUGBKRTgwpZNOkpzGI4uwg==
X-Google-Smtp-Source: AGHT+IEkU0UE2UV/2QCpyBRM6SL5/HKL1bS4Te14BiGK1Bmcb3ihENmREHJjFOK7cgl57ufzdVdTcA==
X-Received: by 2002:a05:600c:4748:b0:409:325:e499 with SMTP id w8-20020a05600c474800b004090325e499mr2352197wmo.32.1698088982727;
        Mon, 23 Oct 2023 12:23:02 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id ay20-20020a05600c1e1400b00407460234f9sm10142088wmb.21.2023.10.23.12.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 12:23:02 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Bob Gilligan <gilligan@arista.com>,
        Dan Carpenter <error27@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Donald Cassidy <dcassidy@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Francesco Ruggeri <fruggeri05@gmail.com>,
        "Gaillardetz, Dominik" <dgaillar@ciena.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Ivan Delalande <colona@arista.com>,
        Leonard Crestez <cdleonard@gmail.com>,
        "Nassiri, Mohammad" <mnassiri@ciena.com>,
        Salam Noureddine <noureddine@arista.com>,
        Simon Horman <horms@kernel.org>,
        "Tetreault, Francois" <ftetreau@ciena.com>, netdev@vger.kernel.org
Subject: [PATCH v16 net-next 19/23] net/tcp: Allow asynchronous delete for TCP-AO keys (MKTs)
Date:   Mon, 23 Oct 2023 20:22:11 +0100
Message-ID: <20231023192217.426455-20-dima@arista.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023192217.426455-1-dima@arista.com>
References: <20231023192217.426455-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete becomes very, very fast - almost free, but after setsockopt()
syscall returns, the key is still alive until next RCU grace period.
Which is fine for listen sockets as userspace needs to be aware of
setsockopt(TCP_AO) and accept() race and resolve it with verification
by getsockopt() after TCP connection was accepted.

The benchmark results (on non-loaded box, worse with more RCU work pending):
> ok 33    Worst case delete    16384 keys: min=5ms max=10ms mean=6.93904ms stddev=0.263421
> ok 34        Add a new key    16384 keys: min=1ms max=4ms mean=2.17751ms stddev=0.147564
> ok 35 Remove random-search    16384 keys: min=5ms max=10ms mean=6.50243ms stddev=0.254999
> ok 36         Remove async    16384 keys: min=0ms max=0ms mean=0.0296107ms stddev=0.0172078

Co-developed-by: Francesco Ruggeri <fruggeri@arista.com>
Signed-off-by: Francesco Ruggeri <fruggeri@arista.com>
Co-developed-by: Salam Noureddine <noureddine@arista.com>
Signed-off-by: Salam Noureddine <noureddine@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
Acked-by: David Ahern <dsahern@kernel.org>
---
 include/uapi/linux/tcp.h |  3 ++-
 net/ipv4/tcp_ao.c        | 21 ++++++++++++++++++---
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
index 201b3cbd6020..be34d7c5c531 100644
--- a/include/uapi/linux/tcp.h
+++ b/include/uapi/linux/tcp.h
@@ -396,7 +396,8 @@ struct tcp_ao_del { /* setsockopt(TCP_AO_DEL_KEY) */
 	__s32	ifindex;		/* L3 dev index for VRF */
 	__u32   set_current	:1,	/* corresponding ::current_key */
 		set_rnext	:1,	/* corresponding ::rnext */
-		reserved	:30;	/* must be 0 */
+		del_async	:1,	/* only valid for listen sockets */
+		reserved	:29;	/* must be 0 */
 	__u16	reserved2;		/* padding, must be 0 */
 	__u8	prefix;			/* peer's address prefix */
 	__u8	sndid;			/* SendID for outgoing segments */
diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index cbc1ee0f5b9a..acbeb635fe29 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -1628,7 +1628,7 @@ static int tcp_ao_add_cmd(struct sock *sk, unsigned short int family,
 }
 
 static int tcp_ao_delete_key(struct sock *sk, struct tcp_ao_info *ao_info,
-			     struct tcp_ao_key *key,
+			     bool del_async, struct tcp_ao_key *key,
 			     struct tcp_ao_key *new_current,
 			     struct tcp_ao_key *new_rnext)
 {
@@ -1636,11 +1636,24 @@ static int tcp_ao_delete_key(struct sock *sk, struct tcp_ao_info *ao_info,
 
 	hlist_del_rcu(&key->node);
 
+	/* Support for async delete on listening sockets: as they don't
+	 * need current_key/rnext_key maintaining, we don't need to check
+	 * them and we can just free all resources in RCU fashion.
+	 */
+	if (del_async) {
+		atomic_sub(tcp_ao_sizeof_key(key), &sk->sk_omem_alloc);
+		call_rcu(&key->rcu, tcp_ao_key_free_rcu);
+		return 0;
+	}
+
 	/* At this moment another CPU could have looked this key up
 	 * while it was unlinked from the list. Wait for RCU grace period,
 	 * after which the key is off-list and can't be looked up again;
 	 * the rx path [just before RCU came] might have used it and set it
 	 * as current_key (very unlikely).
+	 * Free the key with next RCU grace period (in case it was
+	 * current_key before tcp_ao_current_rnext() might have
+	 * changed it in forced-delete).
 	 */
 	synchronize_rcu();
 	if (new_current)
@@ -1711,6 +1724,8 @@ static int tcp_ao_del_cmd(struct sock *sk, unsigned short int family,
 		if (!new_rnext)
 			return -ENOENT;
 	}
+	if (cmd.del_async && sk->sk_state != TCP_LISTEN)
+		return -EINVAL;
 
 	if (family == AF_INET) {
 		struct sockaddr_in *sin = (struct sockaddr_in *)&cmd.addr;
@@ -1758,8 +1773,8 @@ static int tcp_ao_del_cmd(struct sock *sk, unsigned short int family,
 		if (key == new_current || key == new_rnext)
 			continue;
 
-		return tcp_ao_delete_key(sk, ao_info, key,
-					  new_current, new_rnext);
+		return tcp_ao_delete_key(sk, ao_info, cmd.del_async, key,
+					 new_current, new_rnext);
 	}
 	return -ENOENT;
 }
-- 
2.42.0

