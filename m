Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F9A7CE9B1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 23:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbjJRVGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 17:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344786AbjJRU6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 16:58:53 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7702E134
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 13:58:34 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40572aeb673so67447315e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 13:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1697662713; x=1698267513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I9euFW5Un2DPYeOa2jDoQ4RKi4y1MOb35uVZppq/kXE=;
        b=GpDNJxd7nE4T6U54aDkFZoSvnN9z/NjQ6Jg+y+3Xh+3xGLKOAWD1sddKhF4/1EBx6G
         AJqwMEoW2k1lHdIA+j7i7pi0zvekW7774cVsmBl1cVsRpWUFcIF6fMBXDyZnVyGN4MT0
         RgtLhGDmjrO/eeQPvh/zUnsT8kT4D6PBVjeFZgZNz3ybgcHa1EtpR+fnpL0KuEEtO1oM
         nx9cJ+EVlQ9ArFNx7N8Sznp3Vflmxh2N5G2YvvjBP5vOxBPDZf0oYZG1zcpru2SuUtYs
         GDwsq8U650dZ1ILYsLP8i3VIVBIg46Ihn8uTAB0Hg1dYFUiaej/jgd4yGUvUVd21DyTC
         i5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697662713; x=1698267513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I9euFW5Un2DPYeOa2jDoQ4RKi4y1MOb35uVZppq/kXE=;
        b=kir8Ga0XKOPEvRHghHIcqIQvEu+E1WJwhbk2qtxtzwS8GBpI7LDTTXh+eIAn4zsYBC
         wDblzdqFbw0RSnU8JhYxp15Gi+eeQI6r/MVu8HSBHg+L+RYCURLls9y4iDKfcoEkyVq4
         DUfQK2O4wQ6MXxKnxqIEyfpSyveKSjEOaFV9MtK03qdWem2lppg3SLEh16LWcu+WbCkh
         9Vw5cHUB2p0hB2bC5WiWQITlia2RfTYVdpdEQe2XejDN1h7Z6OLB2CVKHdoasK54PwF0
         BCPXKQP4PJ1WDe4VfAVuiifiljsy6j0WHNOHGfGWvSsl9TVkMAiBqBQLGvlzeotr3qie
         L0zQ==
X-Gm-Message-State: AOJu0YzqQUmU0ze/9GgVHg9gpkKXXAnXr9lkaXE0SKCxvejLqsNg8UCv
        p5r2QRF3dNNR1SgEC6CzQub3PA==
X-Google-Smtp-Source: AGHT+IFmF/1ghMMAh+5l9HfGEFHeDcduc4cfa00D9QQsBKRHO9bsZctmLKAfoIhoTi44X/MTEDObZg==
X-Received: by 2002:a05:600c:a46:b0:401:cb45:3fb8 with SMTP id c6-20020a05600c0a4600b00401cb453fb8mr358215wmq.38.1697662712842;
        Wed, 18 Oct 2023 13:58:32 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x19-20020a05600c421300b003fc16ee2864sm2569006wmh.48.2023.10.18.13.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 13:58:32 -0700 (PDT)
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
Subject: [PATCH v15 net-next 09/23] net/tcp: Add TCP-AO sign to twsk
Date:   Wed, 18 Oct 2023 21:57:23 +0100
Message-ID: <20231018205806.322831-10-dima@arista.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231018205806.322831-1-dima@arista.com>
References: <20231018205806.322831-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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
 include/net/tcp_ao.h     | 11 ++++-
 net/ipv4/tcp_ao.c        | 49 +++++++++++++++++----
 net/ipv4/tcp_ipv4.c      | 92 +++++++++++++++++++++++++++++++---------
 net/ipv4/tcp_minisocks.c |  4 +-
 net/ipv4/tcp_output.c    |  2 +-
 net/ipv6/tcp_ipv6.c      | 72 ++++++++++++++++++++++---------
 7 files changed, 183 insertions(+), 50 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index c38778b0baa0..51458219be4e 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -512,6 +512,9 @@ struct tcp_timewait_sock {
 #ifdef CONFIG_TCP_MD5SIG
 	struct tcp_md5sig_key	  *tw_md5_key;
 #endif
+#ifdef CONFIG_TCP_AO
+	struct tcp_ao_info	__rcu *ao_info;
+#endif
 };
 
 static inline struct tcp_timewait_sock *tcp_twsk(const struct sock *sk)
diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
index 629ab0365b83..971d7edcda9c 100644
--- a/include/net/tcp_ao.h
+++ b/include/net/tcp_ao.h
@@ -85,6 +85,7 @@ struct tcp_ao_info {
 				__unused	:31;
 	__be32			lisn;
 	__be32			risn;
+	refcount_t		refcnt;		/* Protects twsk destruction */
 	struct rcu_head		rcu;
 };
 
@@ -124,7 +125,8 @@ struct tcp_ao_key *tcp_ao_established_key(struct tcp_ao_info *ao,
 					  int sndid, int rcvid);
 int tcp_ao_calc_traffic_key(struct tcp_ao_key *mkt, u8 *key, void *ctx,
 			    unsigned int len, struct tcp_sigpool *hp);
-void tcp_ao_destroy_sock(struct sock *sk);
+void tcp_ao_destroy_sock(struct sock *sk, bool twsk);
+void tcp_ao_time_wait(struct tcp_timewait_sock *tcptw, struct tcp_sock *tp);
 struct tcp_ao_key *tcp_ao_do_lookup(const struct sock *sk,
 				    const union tcp_ao_addr *addr,
 				    int family, int sndid, int rcvid);
@@ -182,7 +184,7 @@ static inline struct tcp_ao_key *tcp_ao_do_lookup(const struct sock *sk,
 	return NULL;
 }
 
-static inline void tcp_ao_destroy_sock(struct sock *sk)
+static inline void tcp_ao_destroy_sock(struct sock *sk, bool twsk)
 {
 }
 
@@ -194,6 +196,11 @@ static inline void tcp_ao_finish_connect(struct sock *sk, struct sk_buff *skb)
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
index 78ebb3e43575..ca14195157c8 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -159,6 +159,7 @@ static struct tcp_ao_info *tcp_ao_alloc_info(gfp_t flags)
 	if (!ao)
 		return NULL;
 	INIT_HLIST_HEAD(&ao->head);
+	refcount_set(&ao->refcnt, 1);
 
 	return ao;
 }
@@ -176,27 +177,54 @@ static void tcp_ao_key_free_rcu(struct rcu_head *head)
 	kfree_sensitive(key);
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
+	if (!ao || !refcount_dec_and_test(&ao->refcnt))
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
+		refcount_inc(&ao_info->refcnt);
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
@@ -513,13 +541,15 @@ int tcp_ao_prepare_reset(const struct sock *sk, struct sk_buff *skb,
 	if (!sk)
 		return -ENOTCONN;
 
-	if ((1 << sk->sk_state) &
-	    (TCPF_LISTEN | TCPF_NEW_SYN_RECV | TCPF_TIME_WAIT)) {
+	if ((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_NEW_SYN_RECV)) {
 		return -1;
 	} else {
 		struct tcp_ao_key *rnext_key;
 
-		ao_info = rcu_dereference(tcp_sk(sk)->ao_info);
+		if (sk->sk_state == TCP_TIME_WAIT)
+			ao_info = rcu_dereference(tcp_twsk(sk)->ao_info);
+		else
+			ao_info = rcu_dereference(tcp_sk(sk)->ao_info);
 		if (!ao_info)
 			return -ENOENT;
 
@@ -911,6 +941,9 @@ static struct tcp_ao_info *setsockopt_ao_info(struct sock *sk)
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
index b1a603384ecf..751b7c516e35 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -910,17 +910,13 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb)
 static void tcp_v4_send_ack(const struct sock *sk,
 			    struct sk_buff *skb, u32 seq, u32 ack,
 			    u32 win, u32 tsval, u32 tsecr, int oif,
-			    struct tcp_md5sig_key *key,
+			    struct tcp_key *key,
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
@@ -951,7 +947,7 @@ static void tcp_v4_send_ack(const struct sock *sk,
 	rep.th.window  = htons(win);
 
 #ifdef CONFIG_TCP_MD5SIG
-	if (key) {
+	if (tcp_key_is_md5(key)) {
 		int offset = (tsecr) ? 3 : 0;
 
 		rep.opt[offset++] = htonl((TCPOPT_NOP << 24) |
@@ -962,9 +958,27 @@ static void tcp_v4_send_ack(const struct sock *sk,
 		rep.th.doff = arg.iov[0].iov_len/4;
 
 		tcp_v4_md5_hash_hdr((__u8 *) &rep.opt[offset],
-				    key, ip_hdr(skb)->saddr,
+				    key->md5_key, ip_hdr(skb)->saddr,
 				    ip_hdr(skb)->daddr, &rep.th);
 	}
+#endif
+#ifdef CONFIG_TCP_AO
+	if (tcp_key_is_ao(key)) {
+		int offset = (tsecr) ? 3 : 0;
+
+		rep.opt[offset++] = htonl((TCPOPT_AO << 24) |
+					  (tcp_ao_len(key->ao_key) << 16) |
+					  (key->ao_key->sndid << 8) |
+					  key->rcv_next);
+		arg.iov[0].iov_len += round_up(tcp_ao_len(key->ao_key), 4);
+		rep.th.doff = arg.iov[0].iov_len / 4;
+
+		tcp_ao_hash_hdr(AF_INET, (char *)&rep.opt[offset],
+				key->ao_key, key->traffic_key,
+				(union tcp_ao_addr *)&ip_hdr(skb)->saddr,
+				(union tcp_ao_addr *)&ip_hdr(skb)->daddr,
+				&rep.th, key->sne);
+	}
 #endif
 	arg.flags = reply_flags;
 	arg.csum = csum_tcpudp_nofold(ip_hdr(skb)->daddr,
@@ -998,18 +1012,50 @@ static void tcp_v4_timewait_ack(struct sock *sk, struct sk_buff *skb)
 {
 	struct inet_timewait_sock *tw = inet_twsk(sk);
 	struct tcp_timewait_sock *tcptw = tcp_twsk(sk);
+	struct tcp_key key = {};
+#ifdef CONFIG_TCP_AO
+	struct tcp_ao_info *ao_info;
+
+	/* FIXME: the segment to-be-acked is not verified yet */
+	ao_info = rcu_dereference(tcptw->ao_info);
+	if (ao_info) {
+		const struct tcp_ao_hdr *aoh;
+
+		if (tcp_parse_auth_options(tcp_hdr(skb), NULL, &aoh)) {
+			inet_twsk_put(tw);
+			return;
+		}
+
+		if (aoh)
+			key.ao_key = tcp_ao_established_key(ao_info, aoh->rnext_keyid, -1);
+	}
+	if (key.ao_key) {
+		struct tcp_ao_key *rnext_key;
+
+		key.traffic_key = snd_other_key(key.ao_key);
+		rnext_key = READ_ONCE(ao_info->rnext_key);
+		key.rcv_next = rnext_key->rcvid;
+		key.type = TCP_KEY_AO;
+#else
+	if (0) {
+#endif
+#ifdef CONFIG_TCP_MD5SIG
+	} else if (static_branch_unlikely(&tcp_md5_needed.key)) {
+		key.md5_key = tcp_twsk_md5_key(tcptw);
+		if (key.md5_key)
+			key.type = TCP_KEY_MD5;
+#endif
+	}
 
 	tcp_v4_send_ack(sk, skb,
 			tcptw->tw_snd_nxt, tcptw->tw_rcv_nxt,
 			tcptw->tw_rcv_wnd >> tw->tw_rcv_wscale,
 			tcp_time_stamp_raw() + tcptw->tw_ts_offset,
 			tcptw->tw_ts_recent,
-			tw->tw_bound_dev_if,
-			tcp_twsk_md5_key(tcptw),
+			tw->tw_bound_dev_if, &key,
 			tw->tw_transparent ? IP_REPLY_ARG_NOSRCCHECK : 0,
 			tw->tw_tos,
-			tw->tw_txhash
-			);
+			tw->tw_txhash);
 
 	inet_twsk_put(tw);
 }
@@ -1017,8 +1063,7 @@ static void tcp_v4_timewait_ack(struct sock *sk, struct sk_buff *skb)
 static void tcp_v4_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
 				  struct request_sock *req)
 {
-	const union tcp_md5_addr *addr;
-	int l3index;
+	struct tcp_key key = {};
 
 	/* sk->sk_state == TCP_LISTEN -> for regular TCP_SYN_RECV
 	 * sk->sk_state == TCP_SYN_RECV -> for Fast Open.
@@ -1031,15 +1076,24 @@ static void tcp_v4_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
 	 * exception of <SYN> segments, MUST be right-shifted by
 	 * Rcv.Wind.Shift bits:
 	 */
-	addr = (union tcp_md5_addr *)&ip_hdr(skb)->saddr;
-	l3index = tcp_v4_sdif(skb) ? inet_iif(skb) : 0;
+#ifdef CONFIG_TCP_MD5SIG
+	if (static_branch_unlikely(&tcp_md5_needed.key)) {
+		const union tcp_md5_addr *addr;
+		int l3index;
+
+		addr = (union tcp_md5_addr *)&ip_hdr(skb)->saddr;
+		l3index = tcp_v4_sdif(skb) ? inet_iif(skb) : 0;
+		key.md5_key = tcp_md5_do_lookup(sk, l3index, addr, AF_INET);
+		if (key.md5_key)
+			key.type = TCP_KEY_MD5;
+	}
+#endif
 	tcp_v4_send_ack(sk, skb, seq,
 			tcp_rsk(req)->rcv_nxt,
 			req->rsk_rcv_wnd >> inet_rsk(req)->rcv_wscale,
 			tcp_time_stamp_raw() + tcp_rsk(req)->ts_off,
 			READ_ONCE(req->ts_recent),
-			0,
-			tcp_md5_do_lookup(sk, l3index, addr, AF_INET),
+			0, &key,
 			inet_rsk(req)->no_srccheck ? IP_REPLY_ARG_NOSRCCHECK : 0,
 			ip_hdr(skb)->tos,
 			READ_ONCE(tcp_rsk(req)->txhash));
@@ -2402,7 +2456,7 @@ void tcp_v4_destroy_sock(struct sock *sk)
 		rcu_assign_pointer(tp->md5sig_info, NULL);
 	}
 #endif
-	tcp_ao_destroy_sock(sk);
+	tcp_ao_destroy_sock(sk, false);
 
 	/* Clean up a referenced TCP bind bucket. */
 	if (inet_csk(sk)->icsk_bind_hash)
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 37aff812ca18..c60a84526733 100644
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
 
@@ -315,6 +315,7 @@ void tcp_time_wait(struct sock *sk, int state, int timeo)
 #endif
 
 		tcp_time_wait_init(sk, tcptw);
+		tcp_ao_time_wait(tcptw, tp);
 
 		/* Get the TIME_WAIT timeout firing. */
 		if (timeo < rto)
@@ -369,6 +370,7 @@ void tcp_twsk_destructor(struct sock *sk)
 			call_rcu(&twsk->tw_md5_key->rcu, tcp_md5_twsk_free_rcu);
 	}
 #endif
+	tcp_ao_destroy_sock(sk, true);
 }
 EXPORT_SYMBOL_GPL(tcp_twsk_destructor);
 
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 81263182b2ad..bec9a4204367 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3998,7 +3998,7 @@ int tcp_connect(struct sock *sk)
 		 * then free up ao_info if allocated.
 		 */
 		if (needs_md5) {
-			tcp_ao_destroy_sock(sk);
+			tcp_ao_destroy_sock(sk, false);
 		} else if (needs_ao) {
 			tcp_clear_md5_list(sk);
 			kfree(rcu_replace_pointer(tp->md5sig_info, NULL,
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index f65508066bef..d0d7d2a4aec5 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -777,13 +777,6 @@ static int tcp_v6_md5_hash_skb(char *md5_hash,
 	memset(md5_hash, 0, 16);
 	return 1;
 }
-#else /* CONFIG_TCP_MD5SIG */
-static struct tcp_md5sig_key *tcp_v6_md5_do_lookup(const struct sock *sk,
-						   const struct in6_addr *addr,
-						   int l3index)
-{
-	return NULL;
-}
 #endif
 
 static void tcp_v6_init_req(struct request_sock *req,
@@ -1133,39 +1126,81 @@ static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb)
 
 static void tcp_v6_send_ack(const struct sock *sk, struct sk_buff *skb, u32 seq,
 			    u32 ack, u32 win, u32 tsval, u32 tsecr, int oif,
-			    struct tcp_md5sig_key *md5_key, u8 tclass,
+			    struct tcp_key *key, u8 tclass,
 			    __be32 label, u32 priority, u32 txhash)
 {
-	struct tcp_key key = {
-				.md5_key = md5_key,
-				.type = md5_key ? TCP_KEY_MD5 : TCP_KEY_NONE,
-	};
-
 	tcp_v6_send_response(sk, skb, seq, ack, win, tsval, tsecr, oif, 0,
-			     tclass, label, priority, txhash, &key);
+			     tclass, label, priority, txhash, key);
 }
 
 static void tcp_v6_timewait_ack(struct sock *sk, struct sk_buff *skb)
 {
 	struct inet_timewait_sock *tw = inet_twsk(sk);
 	struct tcp_timewait_sock *tcptw = tcp_twsk(sk);
+	struct tcp_key key = {};
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
+		if (aoh) {
+			key.ao_key = tcp_ao_established_key(ao_info,
+							    aoh->rnext_keyid, -1);
+		}
+	}
+	if (key.ao_key) {
+		struct tcp_ao_key *rnext_key;
+
+		key.traffic_key = snd_other_key(key.ao_key);
+		/* rcv_next switches to our rcv_next */
+		rnext_key = READ_ONCE(ao_info->rnext_key);
+		key.rcv_next = rnext_key->rcvid;
+		key.type = TCP_KEY_AO;
+#else
+	if (0) {
+#endif
+#ifdef CONFIG_TCP_MD5SIG
+	} else if (static_branch_unlikely(&tcp_md5_needed.key)) {
+		key.md5_key = tcp_twsk_md5_key(tcptw);
+		if (key.md5_key)
+			key.type = TCP_KEY_MD5;
+#endif
+	}
 
 	tcp_v6_send_ack(sk, skb, tcptw->tw_snd_nxt, tcptw->tw_rcv_nxt,
 			tcptw->tw_rcv_wnd >> tw->tw_rcv_wscale,
 			tcp_time_stamp_raw() + tcptw->tw_ts_offset,
-			tcptw->tw_ts_recent, tw->tw_bound_dev_if, tcp_twsk_md5_key(tcptw),
+			tcptw->tw_ts_recent, tw->tw_bound_dev_if, &key,
 			tw->tw_tclass, cpu_to_be32(tw->tw_flowlabel), tw->tw_priority,
 			tw->tw_txhash);
 
+#ifdef CONFIG_TCP_AO
+out:
+#endif
 	inet_twsk_put(tw);
 }
 
 static void tcp_v6_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
 				  struct request_sock *req)
 {
-	int l3index;
+	struct tcp_key key = {};
 
-	l3index = tcp_v6_sdif(skb) ? tcp_v6_iif_l3_slave(skb) : 0;
+#ifdef CONFIG_TCP_MD5SIG
+	if (static_branch_unlikely(&tcp_md5_needed.key)) {
+		int l3index = tcp_v6_sdif(skb) ? tcp_v6_iif_l3_slave(skb) : 0;
+
+		key.md5_key = tcp_v6_md5_do_lookup(sk, &ipv6_hdr(skb)->saddr,
+						   l3index);
+		if (key.md5_key)
+			key.type = TCP_KEY_MD5;
+	}
+#endif
 
 	/* sk->sk_state == TCP_LISTEN -> for regular TCP_SYN_RECV
 	 * sk->sk_state == TCP_SYN_RECV -> for Fast Open.
@@ -1181,8 +1216,7 @@ static void tcp_v6_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
 			req->rsk_rcv_wnd >> inet_rsk(req)->rcv_wscale,
 			tcp_time_stamp_raw() + tcp_rsk(req)->ts_off,
 			READ_ONCE(req->ts_recent), sk->sk_bound_dev_if,
-			tcp_v6_md5_do_lookup(sk, &ipv6_hdr(skb)->saddr, l3index),
-			ipv6_get_dsfield(ipv6_hdr(skb)), 0,
+			&key, ipv6_get_dsfield(ipv6_hdr(skb)), 0,
 			READ_ONCE(sk->sk_priority),
 			READ_ONCE(tcp_rsk(req)->txhash));
 }
-- 
2.42.0

