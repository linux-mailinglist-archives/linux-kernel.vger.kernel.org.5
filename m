Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA17576D537
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbjHBR2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbjHBR1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:27:50 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB09630E5
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 10:27:24 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fbea14706eso992185e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 10:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1690997240; x=1691602040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pkqrkZZVEVMZ/t33Ejq/LUymDHE6B9LdRNtsfoOJ+88=;
        b=GrKK/6rVD/pSzuylUWB/8UNV4Y+IWe2Zp4k13lSg/itm2h538TYi5BLv/bVdKt7pmH
         dwzkM97RmxU4D1wdMZzcp7hNE9bC2y2sDghs112tjGPtyEU4o6QeJe7i2Fp6Irc5EMRQ
         GdAfW/vdETnsA1a1glmXedMrp9uUVVjJYOyQIM/guZ8xzNI1CiWA+69u5xzHi2zLoTR9
         DeMpFEG4X/anNg7OgTIcRtSZ0f6exl2qs60T3NfVtzc1UQhLtceEhI2dbThnKrnpwd/Y
         +pizYjWM7LdUpk7Ggk5zrZN5WooWorBXIYTS5Ef4VQ1bmKBExJeKayAg8Xocd1POUy44
         4AWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690997240; x=1691602040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pkqrkZZVEVMZ/t33Ejq/LUymDHE6B9LdRNtsfoOJ+88=;
        b=EwWZYD/ogZ/v5F5EVHvS4nozaW+TA663y+c62I/vXLooJx9qw4fdv7BG6z/wQHPpyo
         XLswGxfbfq0mi069ahT+Okm6Z5PQIxPizvUgFp5MUFPqmOqdkIFkYPYO4sIHMghgF3dA
         paCqp/Ltl/qucdb8XLu3ZynC+V1EOmDcxv8iCtPiHq5ttGA6Yfjy/BO71WglVNEJJtDW
         cRnzdFm9Eukh4+mGEm8nIE2BEor7ox9YpimbfWHx16gAC/f2TcddSbwq8EuQXRarG1RF
         CwVmsT6o9PKVHhQw/nzi1Pa+wUL87/2bzCTt7WUnEeOjFAiRmRRPS3TjGzOfdnHfBi3l
         qQdQ==
X-Gm-Message-State: ABy/qLbqqA8IjErMzn0VECkpnyKMNfZ1St9DitkAMjT/wi/3EpTxzuW/
        tS34pZCixdHuyKFVSUu70Xmcgw==
X-Google-Smtp-Source: APBJJlENuwlgNNp2vQjIRLSY8VXV70Z5AM8SdE0NlbR2q9GCo1SsikNHo4nd5zRWof4s9QJHRJuVBA==
X-Received: by 2002:a7b:ce0f:0:b0:3fe:22a9:907 with SMTP id m15-20020a7bce0f000000b003fe22a90907mr5474697wmc.20.1690997239571;
        Wed, 02 Aug 2023 10:27:19 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id q5-20020a1ce905000000b003fbc0a49b57sm2221770wmc.6.2023.08.02.10.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 10:27:19 -0700 (PDT)
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
        Salam Noureddine <noureddine@arista.com>,
        "Tetreault, Francois" <ftetreau@ciena.com>, netdev@vger.kernel.org
Subject: [PATCH v9 net-next 09/23] net/tcp: Add TCP-AO sign to twsk
Date:   Wed,  2 Aug 2023 18:26:36 +0100
Message-ID: <20230802172654.1467777-10-dima@arista.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802172654.1467777-1-dima@arista.com>
References: <20230802172654.1467777-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for sockets in time-wait state.
ao_info as well as all keys are inherited on transition to time-wait
socket. The lifetime of ao_info is now protected by ref counter, so
that tcp_ao_destroy_sock() will destruct it only when the last user is
gone.

Co-developed-by: Francesco Ruggeri <fruggeri@arista.com>
Signed-off-by: Francesco Ruggeri <fruggeri@arista.com>
Co-developed-by: Salam Noureddine <noureddine@arista.com>
Signed-off-by: Salam Noureddine <noureddine@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
Acked-by: David Ahern <dsahern@kernel.org>
---
 include/linux/tcp.h      |  3 ++
 include/net/tcp_ao.h     | 13 +++++++--
 net/ipv4/tcp_ao.c        | 48 +++++++++++++++++++++++++------
 net/ipv4/tcp_ipv4.c      | 61 ++++++++++++++++++++++++++++++++++++----
 net/ipv4/tcp_minisocks.c |  4 ++-
 net/ipv4/tcp_output.c    |  2 +-
 net/ipv6/tcp_ipv6.c      | 41 ++++++++++++++++++++++++---
 7 files changed, 149 insertions(+), 23 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 9eb15e798c32..0cfa8dbf9159 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -502,6 +502,9 @@ struct tcp_timewait_sock {
 #ifdef CONFIG_TCP_MD5SIG
 	struct tcp_md5sig_key	  *tw_md5_key;
 #endif
+#ifdef CONFIG_TCP_AO
+	struct tcp_ao_info	__rcu *ao_info;
+#endif
 };
 
 static inline struct tcp_timewait_sock *tcp_twsk(const struct sock *sk)
diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
index 67f997aabd9c..ab9163bae48d 100644
--- a/include/net/tcp_ao.h
+++ b/include/net/tcp_ao.h
@@ -85,6 +85,7 @@ struct tcp_ao_info {
 				__unused	:31;
 	__be32			lisn;
 	__be32			risn;
+	atomic_t		refcnt;		/* Protects twsk destruction */
 	struct rcu_head		rcu;
 };
 
@@ -121,7 +122,8 @@ struct tcp_ao_key *tcp_ao_established_key(struct tcp_ao_info *ao,
 					  int sndid, int rcvid);
 int tcp_ao_calc_traffic_key(struct tcp_ao_key *mkt, u8 *key, void *ctx,
 			    unsigned int len, struct tcp_sigpool *hp);
-void tcp_ao_destroy_sock(struct sock *sk);
+void tcp_ao_destroy_sock(struct sock *sk, bool twsk);
+void tcp_ao_time_wait(struct tcp_timewait_sock *tcptw, struct tcp_sock *tp);
 struct tcp_ao_key *tcp_ao_do_lookup(const struct sock *sk,
 				    const union tcp_ao_addr *addr,
 				    int family, int sndid, int rcvid);
@@ -131,7 +133,7 @@ int tcp_ao_hash_hdr(unsigned short family, char *ao_hash,
 		    const union tcp_ao_addr *saddr,
 		    const struct tcphdr *th, u32 sne);
 int tcp_ao_prepare_reset(const struct sock *sk, struct sk_buff *skb,
-			 const struct tcp_ao_hdr *aoh, int l3index, u32 seq,
+			 const struct tcp_ao_hdr *aoh, int l3index, __be32 seq,
 			 struct tcp_ao_key **key, char **traffic_key,
 			 bool *allocated_traffic_key, u8 *keyid, u32 *sne);
 
@@ -171,7 +173,7 @@ static inline struct tcp_ao_key *tcp_ao_do_lookup(const struct sock *sk,
 	return NULL;
 }
 
-static inline void tcp_ao_destroy_sock(struct sock *sk)
+static inline void tcp_ao_destroy_sock(struct sock *sk, bool twsk)
 {
 }
 
@@ -179,6 +181,11 @@ static inline void tcp_ao_finish_connect(struct sock *sk, struct sk_buff *skb)
 {
 }
 
+static inline void tcp_ao_time_wait(struct tcp_timewait_sock *tcptw,
+				    struct tcp_sock *tp)
+{
+}
+
 static inline void tcp_ao_connect_init(struct sock *sk)
 {
 }
diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index 81ce4fe546f2..93072a5ada5c 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -159,6 +159,7 @@ static struct tcp_ao_info *tcp_ao_alloc_info(gfp_t flags)
 	if (!ao)
 		return NULL;
 	INIT_HLIST_HEAD(&ao->head);
+	atomic_set(&ao->refcnt, 1);
 
 	return ao;
 }
@@ -176,27 +177,54 @@ static void tcp_ao_key_free_rcu(struct rcu_head *head)
 	kfree(key);
 }
 
-void tcp_ao_destroy_sock(struct sock *sk)
+void tcp_ao_destroy_sock(struct sock *sk, bool twsk)
 {
 	struct tcp_ao_info *ao;
 	struct tcp_ao_key *key;
 	struct hlist_node *n;
 
-	ao = rcu_dereference_protected(tcp_sk(sk)->ao_info, 1);
-	tcp_sk(sk)->ao_info = NULL;
+	if (twsk) {
+		ao = rcu_dereference_protected(tcp_twsk(sk)->ao_info, 1);
+		tcp_twsk(sk)->ao_info = NULL;
+	} else {
+		ao = rcu_dereference_protected(tcp_sk(sk)->ao_info, 1);
+		tcp_sk(sk)->ao_info = NULL;
+	}
 
-	if (!ao)
+	if (!ao || !atomic_dec_and_test(&ao->refcnt))
 		return;
 
 	hlist_for_each_entry_safe(key, n, &ao->head, node) {
 		hlist_del_rcu(&key->node);
-		atomic_sub(tcp_ao_sizeof_key(key), &sk->sk_omem_alloc);
+		if (!twsk)
+			atomic_sub(tcp_ao_sizeof_key(key), &sk->sk_omem_alloc);
 		call_rcu(&key->rcu, tcp_ao_key_free_rcu);
 	}
 
 	kfree_rcu(ao, rcu);
 }
 
+void tcp_ao_time_wait(struct tcp_timewait_sock *tcptw, struct tcp_sock *tp)
+{
+	struct tcp_ao_info *ao_info = rcu_dereference_protected(tp->ao_info, 1);
+
+	if (ao_info) {
+		struct tcp_ao_key *key;
+		struct hlist_node *n;
+		int omem = 0;
+
+		hlist_for_each_entry_safe(key, n, &ao_info->head, node) {
+			omem += tcp_ao_sizeof_key(key);
+		}
+
+		atomic_inc(&ao_info->refcnt);
+		atomic_sub(omem, &(((struct sock *)tp)->sk_omem_alloc));
+		rcu_assign_pointer(tcptw->ao_info, ao_info);
+	} else {
+		tcptw->ao_info = NULL;
+	}
+}
+
 /* 4 tuple and ISNs are expected in NBO */
 static int tcp_v4_ao_calc_key(struct tcp_ao_key *mkt, u8 *key,
 			      __be32 saddr, __be32 daddr,
@@ -496,7 +524,7 @@ struct tcp_ao_key *tcp_v4_ao_lookup(const struct sock *sk, struct sock *addr_sk,
 }
 
 int tcp_ao_prepare_reset(const struct sock *sk, struct sk_buff *skb,
-			 const struct tcp_ao_hdr *aoh, int l3index, u32 seq,
+			 const struct tcp_ao_hdr *aoh, int l3index, __be32 seq,
 			 struct tcp_ao_key **key, char **traffic_key,
 			 bool *allocated_traffic_key, u8 *keyid, u32 *sne)
 {
@@ -519,8 +547,9 @@ int tcp_ao_prepare_reset(const struct sock *sk, struct sk_buff *skb,
 		struct tcp_ao_key *rnext_key;
 
 		if (sk->sk_state == TCP_TIME_WAIT)
-			return -1;
-		ao_info = rcu_dereference(tcp_sk(sk)->ao_info);
+			ao_info = rcu_dereference(tcp_twsk(sk)->ao_info);
+		else
+			ao_info = rcu_dereference(tcp_sk(sk)->ao_info);
 		if (!ao_info)
 			return -ENOENT;
 
@@ -862,6 +891,9 @@ static struct tcp_ao_info *setsockopt_ao_info(struct sock *sk)
 	if (sk_fullsock(sk)) {
 		return rcu_dereference_protected(tcp_sk(sk)->ao_info,
 						 lockdep_sock_is_held(sk));
+	} else if (sk->sk_state == TCP_TIME_WAIT) {
+		return rcu_dereference_protected(tcp_twsk(sk)->ao_info,
+						 lockdep_sock_is_held(sk));
 	}
 	return ERR_PTR(-ESOCKTNOSUPPORT);
 }
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 14e1024141a0..a9f69107b9be 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -912,16 +912,16 @@ static void tcp_v4_send_ack(const struct sock *sk,
 			    struct sk_buff *skb, u32 seq, u32 ack,
 			    u32 win, u32 tsval, u32 tsecr, int oif,
 			    struct tcp_md5sig_key *key,
+			    struct tcp_ao_key *ao_key,
+			    u8 *traffic_key,
+			    u8 rcv_next,
+			    u32 ao_sne,
 			    int reply_flags, u8 tos, u32 txhash)
 {
 	const struct tcphdr *th = tcp_hdr(skb);
 	struct {
 		struct tcphdr th;
-		__be32 opt[(TCPOLEN_TSTAMP_ALIGNED >> 2)
-#ifdef CONFIG_TCP_MD5SIG
-			   + (TCPOLEN_MD5SIG_ALIGNED >> 2)
-#endif
-			];
+		__be32 opt[(MAX_TCP_OPTION_SPACE  >> 2)];
 	} rep;
 	struct net *net = sock_net(sk);
 	struct ip_reply_arg arg;
@@ -966,6 +966,24 @@ static void tcp_v4_send_ack(const struct sock *sk,
 				    key, ip_hdr(skb)->saddr,
 				    ip_hdr(skb)->daddr, &rep.th);
 	}
+#endif
+#ifdef CONFIG_TCP_AO
+	if (ao_key) {
+		int offset = (tsecr) ? 3 : 0;
+
+		rep.opt[offset++] = htonl((TCPOPT_AO << 24) |
+					  (tcp_ao_len(ao_key) << 16) |
+					  (ao_key->sndid << 8) | rcv_next);
+		arg.iov[0].iov_len += round_up(tcp_ao_len(ao_key), 4);
+		rep.th.doff = arg.iov[0].iov_len / 4;
+
+		tcp_ao_hash_hdr(AF_INET, (char *)&rep.opt[offset],
+				ao_key, traffic_key,
+				(union tcp_ao_addr *)&ip_hdr(skb)->saddr,
+				(union tcp_ao_addr *)&ip_hdr(skb)->daddr,
+				&rep.th, ao_sne);
+	}
+	WARN_ON_ONCE(key && ao_key);
 #endif
 	arg.flags = reply_flags;
 	arg.csum = csum_tcpudp_nofold(ip_hdr(skb)->daddr,
@@ -999,6 +1017,32 @@ static void tcp_v4_timewait_ack(struct sock *sk, struct sk_buff *skb)
 {
 	struct inet_timewait_sock *tw = inet_twsk(sk);
 	struct tcp_timewait_sock *tcptw = tcp_twsk(sk);
+	struct tcp_ao_key *ao_key = NULL;
+	u8 *traffic_key = NULL;
+	u8 rcv_next = 0;
+	u32 ao_sne = 0;
+#ifdef CONFIG_TCP_AO
+	struct tcp_ao_info *ao_info;
+
+	/* FIXME: the segment to-be-acked is not verified yet */
+	ao_info = rcu_dereference(tcptw->ao_info);
+	if (ao_info) {
+		const struct tcp_ao_hdr *aoh;
+
+		if (tcp_parse_auth_options(tcp_hdr(skb), NULL, &aoh))
+			goto out; /* something is wrong with the sign */
+
+		if (aoh)
+			ao_key = tcp_ao_established_key(ao_info, aoh->rnext_keyid, -1);
+	}
+	if (ao_key) {
+		struct tcp_ao_key *rnext_key;
+
+		traffic_key = snd_other_key(ao_key);
+		rnext_key = READ_ONCE(ao_info->rnext_key);
+		rcv_next = rnext_key->rcvid;
+	}
+#endif
 
 	tcp_v4_send_ack(sk, skb,
 			tcptw->tw_snd_nxt, tcptw->tw_rcv_nxt,
@@ -1007,11 +1051,15 @@ static void tcp_v4_timewait_ack(struct sock *sk, struct sk_buff *skb)
 			tcptw->tw_ts_recent,
 			tw->tw_bound_dev_if,
 			tcp_twsk_md5_key(tcptw),
+			ao_key, traffic_key, rcv_next, ao_sne,
 			tw->tw_transparent ? IP_REPLY_ARG_NOSRCCHECK : 0,
 			tw->tw_tos,
 			tw->tw_txhash
 			);
 
+#ifdef CONFIG_TCP_AO
+out:
+#endif
 	inet_twsk_put(tw);
 }
 
@@ -1041,6 +1089,7 @@ static void tcp_v4_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
 			READ_ONCE(req->ts_recent),
 			0,
 			tcp_md5_do_lookup(sk, l3index, addr, AF_INET),
+			NULL, NULL, 0, 0,
 			inet_rsk(req)->no_srccheck ? IP_REPLY_ARG_NOSRCCHECK : 0,
 			ip_hdr(skb)->tos,
 			READ_ONCE(tcp_rsk(req)->txhash));
@@ -2402,7 +2451,7 @@ void tcp_v4_destroy_sock(struct sock *sk)
 		rcu_assign_pointer(tp->md5sig_info, NULL);
 	}
 #endif
-	tcp_ao_destroy_sock(sk);
+	tcp_ao_destroy_sock(sk, false);
 
 	/* Clean up a referenced TCP bind bucket. */
 	if (inet_csk(sk)->icsk_bind_hash)
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 5616b6a34bee..3033f3187079 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -279,7 +279,7 @@ static void tcp_time_wait_init(struct sock *sk, struct tcp_timewait_sock *tcptw)
 void tcp_time_wait(struct sock *sk, int state, int timeo)
 {
 	const struct inet_connection_sock *icsk = inet_csk(sk);
-	const struct tcp_sock *tp = tcp_sk(sk);
+	struct tcp_sock *tp = tcp_sk(sk);
 	struct net *net = sock_net(sk);
 	struct inet_timewait_sock *tw;
 
@@ -316,6 +316,7 @@ void tcp_time_wait(struct sock *sk, int state, int timeo)
 #endif
 
 		tcp_time_wait_init(sk, tcptw);
+		tcp_ao_time_wait(tcptw, tp);
 
 		/* Get the TIME_WAIT timeout firing. */
 		if (timeo < rto)
@@ -370,6 +371,7 @@ void tcp_twsk_destructor(struct sock *sk)
 			call_rcu(&twsk->tw_md5_key->rcu, tcp_md5_twsk_free_rcu);
 	}
 #endif
+	tcp_ao_destroy_sock(sk, true);
 }
 EXPORT_SYMBOL_GPL(tcp_twsk_destructor);
 
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index a234c43727b2..f2d7671af811 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -4050,7 +4050,7 @@ int tcp_connect(struct sock *sk)
 		 * then free up ao_info if allocated.
 		 */
 		if (needs_md5) {
-			tcp_ao_destroy_sock(sk);
+			tcp_ao_destroy_sock(sk, false);
 		} else if (needs_ao) {
 			tcp_clear_md5_list(sk);
 			kfree(rcu_replace_pointer(tp->md5sig_info, NULL,
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 6f7651f26b03..9cb3fc40e682 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1137,24 +1137,57 @@ static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb)
 static void tcp_v6_send_ack(const struct sock *sk, struct sk_buff *skb, u32 seq,
 			    u32 ack, u32 win, u32 tsval, u32 tsecr, int oif,
 			    struct tcp_md5sig_key *key, u8 tclass,
-			    __be32 label, u32 priority, u32 txhash)
+			    __be32 label, u32 priority, u32 txhash,
+			    struct tcp_ao_key *ao_key, char *tkey,
+			    u8 rcv_next, u32 ao_sne)
 {
 	tcp_v6_send_response(sk, skb, seq, ack, win, tsval, tsecr, oif, key, 0,
-			     tclass, label, priority, txhash, NULL, NULL, 0, 0);
+			     tclass, label, priority, txhash,
+			     ao_key, tkey, rcv_next, ao_sne);
 }
 
 static void tcp_v6_timewait_ack(struct sock *sk, struct sk_buff *skb)
 {
 	struct inet_timewait_sock *tw = inet_twsk(sk);
 	struct tcp_timewait_sock *tcptw = tcp_twsk(sk);
+	struct tcp_ao_key *ao_key = NULL;
+	u8 *traffic_key = NULL;
+	u8 rcv_next = 0;
+	u32 ao_sne = 0;
+#ifdef CONFIG_TCP_AO
+	struct tcp_ao_info *ao_info;
+
+	/* FIXME: the segment to-be-acked is not verified yet */
+	ao_info = rcu_dereference(tcptw->ao_info);
+	if (ao_info) {
+		const struct tcp_ao_hdr *aoh;
+
+		/* Invalid TCP option size or twice included auth */
+		if (tcp_parse_auth_options(tcp_hdr(skb), NULL, &aoh))
+			goto out;
+		if (aoh)
+			ao_key = tcp_ao_established_key(ao_info, aoh->rnext_keyid, -1);
+	}
+	if (ao_key) {
+		struct tcp_ao_key *rnext_key;
+
+		traffic_key = snd_other_key(ao_key);
+		/* rcv_next switches to our rcv_next */
+		rnext_key = READ_ONCE(ao_info->rnext_key);
+		rcv_next = rnext_key->rcvid;
+	}
+#endif
 
 	tcp_v6_send_ack(sk, skb, tcptw->tw_snd_nxt, tcptw->tw_rcv_nxt,
 			tcptw->tw_rcv_wnd >> tw->tw_rcv_wscale,
 			tcp_time_stamp_raw() + tcptw->tw_ts_offset,
 			tcptw->tw_ts_recent, tw->tw_bound_dev_if, tcp_twsk_md5_key(tcptw),
 			tw->tw_tclass, cpu_to_be32(tw->tw_flowlabel), tw->tw_priority,
-			tw->tw_txhash);
+			tw->tw_txhash, ao_key, traffic_key, rcv_next, ao_sne);
 
+#ifdef CONFIG_TCP_AO
+out:
+#endif
 	inet_twsk_put(tw);
 }
 
@@ -1181,7 +1214,7 @@ static void tcp_v6_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
 			READ_ONCE(req->ts_recent), sk->sk_bound_dev_if,
 			tcp_v6_md5_do_lookup(sk, &ipv6_hdr(skb)->saddr, l3index),
 			ipv6_get_dsfield(ipv6_hdr(skb)), 0, sk->sk_priority,
-			READ_ONCE(tcp_rsk(req)->txhash));
+			READ_ONCE(tcp_rsk(req)->txhash), NULL, NULL, 0, 0);
 }
 
 
-- 
2.41.0

