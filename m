Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454E67BEEF7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 01:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379121AbjJIXL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 19:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379095AbjJIXLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 19:11:54 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C4010EC
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 16:08:08 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40572aeb6d0so47925225e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 16:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1696892878; x=1697497678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f8/tbOtzLwzXjPoSok4+tQw2t+A47VbB70M6WtqpG8s=;
        b=ICVc22FIlFMAWLUw4qbBDfn92xsPtiQ0Yx0+hpDIy1pYpxOXYjUDQvBazdBprTSvC3
         OiOYOzzqo3hXDsL1h6hGU9sA6sbeWyJQt5PTFV4y44aoB1zyZUGqYnBMCSSvTGNA9qT1
         q3qlsWrDLH3jE9/Iszkkyt3HKurwfqvbR82pYdk1UuuXOWvtqrIPgOC6BBnMqN+lNoSA
         mZfOF4bx6QUI4b8y1SyST9ybI927mg6Q2euPsLsvZnKLKUiTYQRxRHQvMpB/si4ieK/t
         B6fvU2TGghvXzEG9KMEzKif/Ixhyk/pw/fA65ZMwKykJ/cvr3nyfhTPlMYoyiqGf5mWP
         3PHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696892878; x=1697497678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f8/tbOtzLwzXjPoSok4+tQw2t+A47VbB70M6WtqpG8s=;
        b=iTy8d1K+3gJ2KgPUhxU1iBwycgUS0WOZjyaeStQPUG4e3qOgNFvGdNF5D6k7l5LSZS
         UlIeBxGdFK4wTyzhPR/XKHvFCxCjg3YL1qUklybYtm/D479hA4ouy0vOKlGtIDFYwi4g
         /H3GWKVbpXJMmIz/2r4e4cL9NdQ6+Ih/tksqaBMwr5GdwnqRhGPosyRlcicuNoYjqAk0
         sw1GCfpnZmLVhj/YqgZTRfxTwjKxJlhbJWAmW5xU9MgW3bCaGxBIMpsZwn9u3QL52Aev
         +wuBXC4cP7dptIXYqF5a6WG//2R1SBssVdmamKqbrp1Ot3F9arQdC+bdx7+ZO0DfvGNm
         ExAQ==
X-Gm-Message-State: AOJu0YwrOq7S+55JX2LRdsyM2aQU5UDwb6sBbi3m+a5Gu1XWJBp5Q8A6
        vKfz0Vgx/VEUaHPUGHEAl8u+EQ==
X-Google-Smtp-Source: AGHT+IGwlwErEU5cufp/EskcT4SKGtmnSl96MGutTiAu9QARWyVsuRGmzMTF1q7VMBS8UvqF8iPsDA==
X-Received: by 2002:a1c:4c13:0:b0:406:7d74:a29b with SMTP id z19-20020a1c4c13000000b004067d74a29bmr14494053wmf.13.1696892878562;
        Mon, 09 Oct 2023 16:07:58 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id t24-20020a7bc3d8000000b004042dbb8925sm14592104wmj.38.2023.10.09.16.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 16:07:58 -0700 (PDT)
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
        Simon Horman <simon.horman@corigine.com>,
        "Tetreault, Francois" <ftetreau@ciena.com>, netdev@vger.kernel.org
Subject: [PATCH v14 net-next 19/23] net/tcp: Allow asynchronous delete for TCP-AO keys (MKTs)
Date:   Tue, 10 Oct 2023 00:07:10 +0100
Message-ID: <20231009230722.76268-20-dima@arista.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009230722.76268-1-dima@arista.com>
References: <20231009230722.76268-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
index a411aef00318..25d62ecb9532 100644
--- a/include/uapi/linux/tcp.h
+++ b/include/uapi/linux/tcp.h
@@ -395,7 +395,8 @@ struct tcp_ao_del { /* setsockopt(TCP_AO_DEL_KEY) */
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
index 5962df17ecbe..afd5943a9972 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -1625,7 +1625,7 @@ static int tcp_ao_add_cmd(struct sock *sk, unsigned short int family,
 }
 
 static int tcp_ao_delete_key(struct sock *sk, struct tcp_ao_info *ao_info,
-			     struct tcp_ao_key *key,
+			     bool del_async, struct tcp_ao_key *key,
 			     struct tcp_ao_key *new_current,
 			     struct tcp_ao_key *new_rnext)
 {
@@ -1633,11 +1633,24 @@ static int tcp_ao_delete_key(struct sock *sk, struct tcp_ao_info *ao_info,
 
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
@@ -1708,6 +1721,8 @@ static int tcp_ao_del_cmd(struct sock *sk, unsigned short int family,
 		if (!new_rnext)
 			return -ENOENT;
 	}
+	if (cmd.del_async && sk->sk_state != TCP_LISTEN)
+		return -EINVAL;
 
 	if (family == AF_INET) {
 		struct sockaddr_in *sin = (struct sockaddr_in *)&cmd.addr;
@@ -1755,8 +1770,8 @@ static int tcp_ao_del_cmd(struct sock *sk, unsigned short int family,
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

