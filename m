Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B79457BEECB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 01:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379024AbjJIXIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 19:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379031AbjJIXIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 19:08:05 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50173111
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 16:07:46 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-405524e6768so49282285e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 16:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1696892865; x=1697497665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PksnGJwelVWFWIB6MvGjOGjzK25iPLq1FRKqRp+ndxA=;
        b=YP1AtS/wG6W8nO2DAIltTeKS/h0vgS4UOq8+cMR9i9+AXlBkWkUfyzNLnVIHRm3+b8
         i7mtLewFD9Byj+X4aekCiL/lerB3P2efkUkNOLSmq1Altux/7JSBQISqR6bP2WC8YVwT
         +3YhKfMqRuL0caQORIn0szSTszfFw+vTzTIY3M89w1FBS/qNfiktbDTV9Kyk8hZz5lls
         mwbV+WZM+Bl0j1kjFVV+GpyUjUq1rWNBFOLkkWJo8iD1+wNFW5/3x/jhs1rDpdcCrqYT
         d8oMXHbfZk4EkFsU/iHvE8zi9JLqDq9+UHH9Act4j3T4y9AEYqTrve/Nb2qS1Eo1/ZT+
         1/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696892865; x=1697497665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PksnGJwelVWFWIB6MvGjOGjzK25iPLq1FRKqRp+ndxA=;
        b=gAicN4l2/TdmBdFs1KDRZ5N+4uok7DWGZ9L0n0tW98vn7k0CwuZW0sc/LKDdjAYUb5
         72Dbe14MOus8N7/beWlvygcmYtZrTKzpsvoxShWanaPZrk04FumrQ+RUJVZo+7KxfjZc
         DYX/FS7iytGNqjHyjLqM0onK0SVE/0QDzZ8s5Vj1T4bSUvRhJQhtowsqVpIX+U0chwPZ
         2ycuJmP8OuhcGItAGl/5mfRmK5nxf83ewfbGCabIaHuilH/EclfdolPCajm5UxXX8Oce
         9m7BXFqASbFhhHwe23Yq0SQff4qWdO+BTPWZCZwBrPpsPBNXqeZ4PizWbVuMwp0RpB9Y
         2W3g==
X-Gm-Message-State: AOJu0YyGTAsIJq5jnxXDNnsmO5/HLTo72WExbkxzsEL695pe8T3nud59
        X5Qg4ODHUSCPFchkqARaELDu9Q==
X-Google-Smtp-Source: AGHT+IESb91nebGsZJ4fK5fVIWCajPomB0J96NLHNd81MWll1Hcd3CQDkh3hGgJyDZvlEwgrDo8JEw==
X-Received: by 2002:a05:600c:21d1:b0:405:1c14:9227 with SMTP id x17-20020a05600c21d100b004051c149227mr14925977wmj.33.1696892865212;
        Mon, 09 Oct 2023 16:07:45 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id t24-20020a7bc3d8000000b004042dbb8925sm14592104wmj.38.2023.10.09.16.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 16:07:44 -0700 (PDT)
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
Subject: [PATCH v14 net-next 10/23] net/tcp: Wire TCP-AO to request sockets
Date:   Tue, 10 Oct 2023 00:07:01 +0100
Message-ID: <20231009230722.76268-11-dima@arista.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009230722.76268-1-dima@arista.com>
References: <20231009230722.76268-1-dima@arista.com>
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

Now when the new request socket is created from the listening socket,
it's recorded what MKT was used by the peer. tcp_rsk_used_ao() is
a new helper for checking if TCP-AO option was used to create the
request socket.
tcp_ao_copy_all_matching() will copy all keys that match the peer on the
request socket, as well as preparing them for the usage (creating
traffic keys).

Co-developed-by: Francesco Ruggeri <fruggeri@arista.com>
Signed-off-by: Francesco Ruggeri <fruggeri@arista.com>
Co-developed-by: Salam Noureddine <noureddine@arista.com>
Signed-off-by: Salam Noureddine <noureddine@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
Acked-by: David Ahern <dsahern@kernel.org>
---
 include/linux/tcp.h      |  18 +++
 include/net/tcp.h        |   6 +
 include/net/tcp_ao.h     |  24 ++++
 net/ipv4/syncookies.c    |   2 +
 net/ipv4/tcp_ao.c        | 237 ++++++++++++++++++++++++++++++++++++++-
 net/ipv4/tcp_input.c     |  15 +++
 net/ipv4/tcp_ipv4.c      |  66 +++++++++--
 net/ipv4/tcp_minisocks.c |  10 ++
 net/ipv4/tcp_output.c    |  37 +++---
 net/ipv6/syncookies.c    |   2 +
 net/ipv6/tcp_ao.c        |  38 ++++++-
 net/ipv6/tcp_ipv6.c      |  73 ++++++++++--
 12 files changed, 491 insertions(+), 37 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 51458219be4e..1d9b8e04a4ee 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -165,6 +165,11 @@ struct tcp_request_sock {
 						  * after data-in-SYN.
 						  */
 	u8				syn_tos;
+#ifdef CONFIG_TCP_AO
+	u8				ao_keyid;
+	u8				ao_rcv_next;
+	u8				maclen;
+#endif
 };
 
 static inline struct tcp_request_sock *tcp_rsk(const struct request_sock *req)
@@ -172,6 +177,19 @@ static inline struct tcp_request_sock *tcp_rsk(const struct request_sock *req)
 	return (struct tcp_request_sock *)req;
 }
 
+static inline bool tcp_rsk_used_ao(const struct request_sock *req)
+{
+	/* The real length of MAC is saved in the request socket,
+	 * signing anything with zero-length makes no sense, so here is
+	 * a little hack..
+	 */
+#ifndef CONFIG_TCP_AO
+	return false;
+#else
+	return tcp_rsk(req)->maclen != 0;
+#endif
+}
+
 #define TCP_RMEM_TO_WIN_SCALE 8
 
 struct tcp_sock {
diff --git a/include/net/tcp.h b/include/net/tcp.h
index dc74908ffa5a..13657b70d5d7 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2178,6 +2178,12 @@ struct tcp_request_sock_ops {
 					  const struct sock *sk,
 					  const struct sk_buff *skb);
 #endif
+#ifdef CONFIG_TCP_AO
+	struct tcp_ao_key *(*ao_lookup)(const struct sock *sk,
+					struct request_sock *req,
+					int sndid, int rcvid);
+	int (*ao_calc_key)(struct tcp_ao_key *mkt, u8 *key, struct request_sock *sk);
+#endif
 #ifdef CONFIG_SYN_COOKIES
 	__u32 (*cookie_init_seq)(const struct sk_buff *skb,
 				 __u16 *mss);
diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
index af2caf7e76fc..d04b17971c3c 100644
--- a/include/net/tcp_ao.h
+++ b/include/net/tcp_ao.h
@@ -123,6 +123,9 @@ int tcp_parse_ao(struct sock *sk, int cmd, unsigned short int family,
 		 sockptr_t optval, int optlen);
 struct tcp_ao_key *tcp_ao_established_key(struct tcp_ao_info *ao,
 					  int sndid, int rcvid);
+int tcp_ao_copy_all_matching(const struct sock *sk, struct sock *newsk,
+			     struct request_sock *req, struct sk_buff *skb,
+			     int family);
 int tcp_ao_calc_traffic_key(struct tcp_ao_key *mkt, u8 *key, void *ctx,
 			    unsigned int len, struct tcp_sigpool *hp);
 void tcp_ao_destroy_sock(struct sock *sk, bool twsk);
@@ -147,6 +150,11 @@ struct tcp_ao_key *tcp_v4_ao_lookup(const struct sock *sk, struct sock *addr_sk,
 int tcp_v4_ao_calc_key_sk(struct tcp_ao_key *mkt, u8 *key,
 			  const struct sock *sk,
 			  __be32 sisn, __be32 disn, bool send);
+int tcp_v4_ao_calc_key_rsk(struct tcp_ao_key *mkt, u8 *key,
+			   struct request_sock *req);
+struct tcp_ao_key *tcp_v4_ao_lookup_rsk(const struct sock *sk,
+					struct request_sock *req,
+					int sndid, int rcvid);
 int tcp_v4_ao_hash_skb(char *ao_hash, struct tcp_ao_key *key,
 		       const struct sock *sk, const struct sk_buff *skb,
 		       const u8 *tkey, int hash_offset, u32 sne);
@@ -154,11 +162,21 @@ int tcp_v4_ao_hash_skb(char *ao_hash, struct tcp_ao_key *key,
 int tcp_v6_ao_hash_pseudoheader(struct tcp_sigpool *hp,
 				const struct in6_addr *daddr,
 				const struct in6_addr *saddr, int nbytes);
+int tcp_v6_ao_calc_key_skb(struct tcp_ao_key *mkt, u8 *key,
+			   const struct sk_buff *skb, __be32 sisn, __be32 disn);
 int tcp_v6_ao_calc_key_sk(struct tcp_ao_key *mkt, u8 *key,
 			  const struct sock *sk, __be32 sisn,
 			  __be32 disn, bool send);
+int tcp_v6_ao_calc_key_rsk(struct tcp_ao_key *mkt, u8 *key,
+			   struct request_sock *req);
+struct tcp_ao_key *tcp_v6_ao_do_lookup(const struct sock *sk,
+				       const struct in6_addr *addr,
+				       int sndid, int rcvid);
 struct tcp_ao_key *tcp_v6_ao_lookup(const struct sock *sk,
 				    struct sock *addr_sk, int sndid, int rcvid);
+struct tcp_ao_key *tcp_v6_ao_lookup_rsk(const struct sock *sk,
+					struct request_sock *req,
+					int sndid, int rcvid);
 int tcp_v6_ao_hash_skb(char *ao_hash, struct tcp_ao_key *key,
 		       const struct sock *sk, const struct sk_buff *skb,
 		       const u8 *tkey, int hash_offset, u32 sne);
@@ -178,6 +196,12 @@ static inline int tcp_ao_transmit_skb(struct sock *sk, struct sk_buff *skb,
 	return 0;
 }
 
+static inline void tcp_ao_syncookie(struct sock *sk, const struct sk_buff *skb,
+				    struct tcp_request_sock *treq,
+				    unsigned short int family)
+{
+}
+
 static inline struct tcp_ao_key *tcp_ao_do_lookup(const struct sock *sk,
 		const union tcp_ao_addr *addr, int family, int sndid, int rcvid)
 {
diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index dc478a0574cb..23fca22bc992 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -394,6 +394,8 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	treq->snt_synack	= 0;
 	treq->tfo_listener	= false;
 
+	tcp_ao_syncookie(sk, skb, treq, AF_INET);
+
 	if (IS_ENABLED(CONFIG_SMC))
 		ireq->smc_ok = 0;
 
diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index 00d21f6242de..c8006b0cbb8a 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -169,6 +169,23 @@ static void tcp_ao_link_mkt(struct tcp_ao_info *ao, struct tcp_ao_key *mkt)
 	hlist_add_head_rcu(&mkt->node, &ao->head);
 }
 
+static struct tcp_ao_key *tcp_ao_copy_key(struct sock *sk,
+					  struct tcp_ao_key *key)
+{
+	struct tcp_ao_key *new_key;
+
+	new_key = sock_kmalloc(sk, tcp_ao_sizeof_key(key),
+			       GFP_ATOMIC);
+	if (!new_key)
+		return NULL;
+
+	*new_key = *key;
+	INIT_HLIST_NODE(&new_key->node);
+	tcp_sigpool_get(new_key->tcp_sigpool_id);
+
+	return new_key;
+}
+
 static void tcp_ao_key_free_rcu(struct rcu_head *head)
 {
 	struct tcp_ao_key *key = container_of(head, struct tcp_ao_key, rcu);
@@ -290,6 +307,42 @@ static int tcp_ao_calc_key_sk(struct tcp_ao_key *mkt, u8 *key,
 		return -EOPNOTSUPP;
 }
 
+int tcp_v4_ao_calc_key_rsk(struct tcp_ao_key *mkt, u8 *key,
+			   struct request_sock *req)
+{
+	struct inet_request_sock *ireq = inet_rsk(req);
+
+	return tcp_v4_ao_calc_key(mkt, key,
+				  ireq->ir_loc_addr, ireq->ir_rmt_addr,
+				  htons(ireq->ir_num), ireq->ir_rmt_port,
+				  htonl(tcp_rsk(req)->snt_isn),
+				  htonl(tcp_rsk(req)->rcv_isn));
+}
+
+static int tcp_v4_ao_calc_key_skb(struct tcp_ao_key *mkt, u8 *key,
+				  const struct sk_buff *skb,
+				  __be32 sisn, __be32 disn)
+{
+	const struct iphdr *iph = ip_hdr(skb);
+	const struct tcphdr *th = tcp_hdr(skb);
+
+	return tcp_v4_ao_calc_key(mkt, key, iph->saddr, iph->daddr,
+				  th->source, th->dest, sisn, disn);
+}
+
+static int tcp_ao_calc_key_skb(struct tcp_ao_key *mkt, u8 *key,
+			       const struct sk_buff *skb,
+			       __be32 sisn, __be32 disn, int family)
+{
+	if (family == AF_INET)
+		return tcp_v4_ao_calc_key_skb(mkt, key, skb, sisn, disn);
+#if IS_ENABLED(CONFIG_IPV6)
+	else if (family == AF_INET6)
+		return tcp_v6_ao_calc_key_skb(mkt, key, skb, sisn, disn);
+#endif
+	return -EAFNOSUPPORT;
+}
+
 static int tcp_v4_ao_hash_pseudoheader(struct tcp_sigpool *hp,
 				       __be32 daddr, __be32 saddr,
 				       int nbytes)
@@ -515,6 +568,16 @@ int tcp_v4_ao_hash_skb(char *ao_hash, struct tcp_ao_key *key,
 			       tkey, hash_offset, sne);
 }
 
+struct tcp_ao_key *tcp_v4_ao_lookup_rsk(const struct sock *sk,
+					struct request_sock *req,
+					int sndid, int rcvid)
+{
+	union tcp_ao_addr *addr =
+			(union tcp_ao_addr *)&inet_rsk(req)->ir_rmt_addr;
+
+	return tcp_ao_do_lookup(sk, addr, AF_INET, sndid, rcvid);
+}
+
 struct tcp_ao_key *tcp_v4_ao_lookup(const struct sock *sk, struct sock *addr_sk,
 				    int sndid, int rcvid)
 {
@@ -528,6 +591,7 @@ int tcp_ao_prepare_reset(const struct sock *sk, struct sk_buff *skb,
 			 struct tcp_ao_key **key, char **traffic_key,
 			 bool *allocated_traffic_key, u8 *keyid, u32 *sne)
 {
+	const struct tcphdr *th = tcp_hdr(skb);
 	struct tcp_ao_info *ao_info;
 
 	*allocated_traffic_key = false;
@@ -542,7 +606,44 @@ int tcp_ao_prepare_reset(const struct sock *sk, struct sk_buff *skb,
 		return -ENOTCONN;
 
 	if ((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_NEW_SYN_RECV)) {
-		return -1;
+		union tcp_ao_addr *addr;
+		unsigned int family = READ_ONCE(sk->sk_family);
+		__be32 disn, sisn;
+
+		if (sk->sk_state == TCP_NEW_SYN_RECV) {
+			struct request_sock *req = inet_reqsk(sk);
+
+			sisn = htonl(tcp_rsk(req)->rcv_isn);
+			disn = htonl(tcp_rsk(req)->snt_isn);
+			*sne = 0;
+		} else {
+			sisn = th->seq;
+			disn = 0;
+		}
+		if (IS_ENABLED(CONFIG_IPV6) && sk->sk_family == AF_INET6)
+			addr = (union tcp_md5_addr *)&ipv6_hdr(skb)->saddr;
+		else
+			addr = (union tcp_md5_addr *)&ip_hdr(skb)->saddr;
+#if IS_ENABLED(CONFIG_IPV6)
+		if (family == AF_INET6 && ipv6_addr_v4mapped(&sk->sk_v6_daddr))
+			family = AF_INET;
+#endif
+
+		sk = sk_const_to_full_sk(sk);
+		ao_info = rcu_dereference(tcp_sk(sk)->ao_info);
+		if (!ao_info)
+			return -ENOENT;
+		*key = tcp_ao_do_lookup(sk, addr, family, -1, aoh->rnext_keyid);
+		if (!*key)
+			return -ENOENT;
+		*traffic_key = kmalloc(tcp_ao_digest_size(*key), GFP_ATOMIC);
+		if (!*traffic_key)
+			return -ENOMEM;
+		*allocated_traffic_key = true;
+		if (tcp_ao_calc_key_skb(*key, *traffic_key, skb,
+					sisn, disn, family))
+			return -1;
+		*keyid = (*key)->rcvid;
 	} else {
 		struct tcp_ao_key *rnext_key;
 
@@ -598,6 +699,46 @@ int tcp_ao_transmit_skb(struct sock *sk, struct sk_buff *skb,
 	return 0;
 }
 
+static struct tcp_ao_key *tcp_ao_inbound_lookup(unsigned short int family,
+		const struct sock *sk, const struct sk_buff *skb,
+		int sndid, int rcvid)
+{
+	if (family == AF_INET) {
+		const struct iphdr *iph = ip_hdr(skb);
+
+		return tcp_ao_do_lookup(sk, (union tcp_ao_addr *)&iph->saddr,
+				AF_INET, sndid, rcvid);
+	} else {
+		const struct ipv6hdr *iph = ipv6_hdr(skb);
+
+		return tcp_ao_do_lookup(sk, (union tcp_ao_addr *)&iph->saddr,
+				AF_INET6, sndid, rcvid);
+	}
+}
+
+void tcp_ao_syncookie(struct sock *sk, const struct sk_buff *skb,
+		      struct tcp_request_sock *treq,
+		      unsigned short int family)
+{
+	const struct tcphdr *th = tcp_hdr(skb);
+	const struct tcp_ao_hdr *aoh;
+	struct tcp_ao_key *key;
+
+	treq->maclen = 0;
+
+	if (tcp_parse_auth_options(th, NULL, &aoh) || !aoh)
+		return;
+
+	key = tcp_ao_inbound_lookup(family, sk, skb, -1, aoh->keyid);
+	if (!key)
+		/* Key not found, continue without TCP-AO */
+		return;
+
+	treq->ao_rcv_next = aoh->keyid;
+	treq->ao_keyid = aoh->rnext_keyid;
+	treq->maclen = tcp_ao_maclen(key);
+}
+
 static int tcp_ao_cache_traffic_keys(const struct sock *sk,
 				     struct tcp_ao_info *ao,
 				     struct tcp_ao_key *ao_key)
@@ -702,6 +843,100 @@ void tcp_ao_finish_connect(struct sock *sk, struct sk_buff *skb)
 		tcp_ao_cache_traffic_keys(sk, ao, key);
 }
 
+int tcp_ao_copy_all_matching(const struct sock *sk, struct sock *newsk,
+			     struct request_sock *req, struct sk_buff *skb,
+			     int family)
+{
+	struct tcp_ao_key *key, *new_key, *first_key;
+	struct tcp_ao_info *new_ao, *ao;
+	struct hlist_node *key_head;
+	union tcp_ao_addr *addr;
+	bool match = false;
+	int ret = -ENOMEM;
+
+	ao = rcu_dereference(tcp_sk(sk)->ao_info);
+	if (!ao)
+		return 0;
+
+	/* New socket without TCP-AO on it */
+	if (!tcp_rsk_used_ao(req))
+		return 0;
+
+	new_ao = tcp_ao_alloc_info(GFP_ATOMIC);
+	if (!new_ao)
+		return -ENOMEM;
+	new_ao->lisn = htonl(tcp_rsk(req)->snt_isn);
+	new_ao->risn = htonl(tcp_rsk(req)->rcv_isn);
+	new_ao->ao_required = ao->ao_required;
+
+	if (family == AF_INET) {
+		addr = (union tcp_ao_addr *)&newsk->sk_daddr;
+#if IS_ENABLED(CONFIG_IPV6)
+	} else if (family == AF_INET6) {
+		addr = (union tcp_ao_addr *)&newsk->sk_v6_daddr;
+#endif
+	} else {
+		ret = -EAFNOSUPPORT;
+		goto free_ao;
+	}
+
+	hlist_for_each_entry_rcu(key, &ao->head, node) {
+		if (tcp_ao_key_cmp(key, addr, key->prefixlen, family, -1, -1))
+			continue;
+
+		new_key = tcp_ao_copy_key(newsk, key);
+		if (!new_key)
+			goto free_and_exit;
+
+		tcp_ao_cache_traffic_keys(newsk, new_ao, new_key);
+		tcp_ao_link_mkt(new_ao, new_key);
+		match = true;
+	}
+
+	if (!match) {
+		/* RFC5925 (7.4.1) specifies that the TCP-AO status
+		 * of a connection is determined on the initial SYN.
+		 * At this point the connection was TCP-AO enabled, so
+		 * it can't switch to being unsigned if peer's key
+		 * disappears on the listening socket.
+		 */
+		ret = -EKEYREJECTED;
+		goto free_and_exit;
+	}
+
+	key_head = rcu_dereference(hlist_first_rcu(&new_ao->head));
+	first_key = hlist_entry_safe(key_head, struct tcp_ao_key, node);
+
+	key = tcp_ao_established_key(new_ao, tcp_rsk(req)->ao_keyid, -1);
+	if (key)
+		new_ao->current_key = key;
+	else
+		new_ao->current_key = first_key;
+
+	/* set rnext_key */
+	key = tcp_ao_established_key(new_ao, -1, tcp_rsk(req)->ao_rcv_next);
+	if (key)
+		new_ao->rnext_key = key;
+	else
+		new_ao->rnext_key = first_key;
+
+	sk_gso_disable(newsk);
+	rcu_assign_pointer(tcp_sk(newsk)->ao_info, new_ao);
+
+	return 0;
+
+free_and_exit:
+	hlist_for_each_entry_safe(key, key_head, &new_ao->head, node) {
+		hlist_del(&key->node);
+		tcp_sigpool_release(key->tcp_sigpool_id);
+		atomic_sub(tcp_ao_sizeof_key(key), &newsk->sk_omem_alloc);
+		kfree_sensitive(key);
+	}
+free_ao:
+	kfree(new_ao);
+	return ret;
+}
+
 static bool tcp_ao_can_set_current_rnext(struct sock *sk)
 {
 	/* There aren't current/rnext keys on TCP_LISTEN sockets */
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 5407ef0c1c04..520776714591 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -7016,6 +7016,10 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 	struct flowi fl;
 	u8 syncookies;
 
+#ifdef CONFIG_TCP_AO
+	const struct tcp_ao_hdr *aoh;
+#endif
+
 	syncookies = READ_ONCE(net->ipv4.sysctl_tcp_syncookies);
 
 	/* TW buckets are converted to open requests without
@@ -7101,6 +7105,17 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 			inet_rsk(req)->ecn_ok = 0;
 	}
 
+#ifdef CONFIG_TCP_AO
+	if (tcp_parse_auth_options(tcp_hdr(skb), NULL, &aoh))
+		goto drop_and_release; /* Invalid TCP options */
+	if (aoh) {
+		tcp_rsk(req)->maclen = aoh->length - sizeof(struct tcp_ao_hdr);
+		tcp_rsk(req)->ao_rcv_next = aoh->keyid;
+		tcp_rsk(req)->ao_keyid = aoh->rnext_keyid;
+	} else {
+		tcp_rsk(req)->maclen = 0;
+	}
+#endif
 	tcp_rsk(req)->snt_isn = isn;
 	tcp_rsk(req)->txhash = net_tx_rndhash();
 	tcp_rsk(req)->syn_tos = TCP_SKB_CB(skb)->ip_dsfield;
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index d98a943a4206..c332a86c22c5 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1071,13 +1071,47 @@ static void tcp_v4_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
 	u32 seq = (sk->sk_state == TCP_LISTEN) ? tcp_rsk(req)->snt_isn + 1 :
 					     tcp_sk(sk)->snd_nxt;
 
-	/* RFC 7323 2.3
-	 * The window field (SEG.WND) of every outgoing segment, with the
-	 * exception of <SYN> segments, MUST be right-shifted by
-	 * Rcv.Wind.Shift bits:
-	 */
+#ifdef CONFIG_TCP_AO
+	if (tcp_rsk_used_ao(req)) {
+		const union tcp_md5_addr *addr;
+		const struct tcp_ao_hdr *aoh;
+
+		/* Invalid TCP option size or twice included auth */
+		if (tcp_parse_auth_options(tcp_hdr(skb), NULL, &aoh))
+			return;
+		if (!aoh)
+			return;
+
+		addr = (union tcp_md5_addr *)&ip_hdr(skb)->saddr;
+		key.ao_key = tcp_ao_do_lookup(sk, addr, AF_INET,
+					      aoh->rnext_keyid, -1);
+		if (unlikely(!key.ao_key)) {
+			/* Send ACK with any matching MKT for the peer */
+			key.ao_key = tcp_ao_do_lookup(sk, addr, AF_INET, -1, -1);
+			/* Matching key disappeared (user removed the key?)
+			 * let the handshake timeout.
+			 */
+			if (!key.ao_key) {
+				net_info_ratelimited("TCP-AO key for (%pI4, %d)->(%pI4, %d) suddenly disappeared, won't ACK new connection\n",
+						     addr,
+						     ntohs(tcp_hdr(skb)->source),
+						     &ip_hdr(skb)->daddr,
+						     ntohs(tcp_hdr(skb)->dest));
+				return;
+			}
+		}
+		key.traffic_key = kmalloc(tcp_ao_digest_size(key.ao_key), GFP_ATOMIC);
+		if (!key.traffic_key)
+			return;
+
+		key.type = TCP_KEY_AO;
+		key.rcv_next = aoh->keyid;
+		tcp_v4_ao_calc_key_rsk(key.ao_key, key.traffic_key, req);
+#else
+	if (0) {
+#endif
 #ifdef CONFIG_TCP_MD5SIG
-	if (static_branch_unlikely(&tcp_md5_needed.key)) {
+	} else if (static_branch_unlikely(&tcp_md5_needed.key)) {
 		const union tcp_md5_addr *addr;
 		int l3index;
 
@@ -1086,8 +1120,14 @@ static void tcp_v4_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
 		key.md5_key = tcp_md5_do_lookup(sk, l3index, addr, AF_INET);
 		if (key.md5_key)
 			key.type = TCP_KEY_MD5;
-	}
 #endif
+	}
+
+	/* RFC 7323 2.3
+	 * The window field (SEG.WND) of every outgoing segment, with the
+	 * exception of <SYN> segments, MUST be right-shifted by
+	 * Rcv.Wind.Shift bits:
+	 */
 	tcp_v4_send_ack(sk, skb, seq,
 			tcp_rsk(req)->rcv_nxt,
 			req->rsk_rcv_wnd >> inet_rsk(req)->rcv_wscale,
@@ -1097,6 +1137,8 @@ static void tcp_v4_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
 			inet_rsk(req)->no_srccheck ? IP_REPLY_ARG_NOSRCCHECK : 0,
 			ip_hdr(skb)->tos,
 			READ_ONCE(tcp_rsk(req)->txhash));
+	if (tcp_key_is_ao(&key))
+		kfree(key.traffic_key);
 }
 
 /*
@@ -1635,6 +1677,10 @@ const struct tcp_request_sock_ops tcp_request_sock_ipv4_ops = {
 	.req_md5_lookup	=	tcp_v4_md5_lookup,
 	.calc_md5_hash	=	tcp_v4_md5_hash_skb,
 #endif
+#ifdef CONFIG_TCP_AO
+	.ao_lookup	=	tcp_v4_ao_lookup_rsk,
+	.ao_calc_key	=	tcp_v4_ao_calc_key_rsk,
+#endif
 #ifdef CONFIG_SYN_COOKIES
 	.cookie_init_seq =	cookie_v4_init_sequence,
 #endif
@@ -1736,12 +1782,16 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
 	/* Copy over the MD5 key from the original socket */
 	addr = (union tcp_md5_addr *)&newinet->inet_daddr;
 	key = tcp_md5_do_lookup(sk, l3index, addr, AF_INET);
-	if (key) {
+	if (key && !tcp_rsk_used_ao(req)) {
 		if (tcp_md5_key_copy(newsk, addr, AF_INET, 32, l3index, key))
 			goto put_and_exit;
 		sk_gso_disable(newsk);
 	}
 #endif
+#ifdef CONFIG_TCP_AO
+	if (tcp_ao_copy_all_matching(sk, newsk, req, skb, AF_INET))
+		goto put_and_exit; /* OOM, release back memory */
+#endif
 
 	if (__inet_inherit_port(sk, newsk) < 0)
 		goto put_and_exit;
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index c60a84526733..a6ece0edf4d7 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -505,6 +505,9 @@ struct sock *tcp_create_openreq_child(const struct sock *sk,
 	const struct tcp_sock *oldtp;
 	struct tcp_sock *newtp;
 	u32 seq;
+#ifdef CONFIG_TCP_AO
+	struct tcp_ao_key *ao_key;
+#endif
 
 	if (!newsk)
 		return NULL;
@@ -585,6 +588,13 @@ struct sock *tcp_create_openreq_child(const struct sock *sk,
 #ifdef CONFIG_TCP_MD5SIG
 	newtp->md5sig_info = NULL;	/*XXX*/
 #endif
+#ifdef CONFIG_TCP_AO
+	newtp->ao_info = NULL;
+	ao_key = treq->af_specific->ao_lookup(sk, req,
+				tcp_rsk(req)->ao_keyid, -1);
+	if (ao_key)
+		newtp->tcp_header_len += tcp_ao_len(ao_key);
+ #endif
 	if (skb->len >= TCP_MSS_DEFAULT + newtp->tcp_header_len)
 		newicsk->icsk_ack.last_seg_size = skb->len - newtp->tcp_header_len;
 	newtp->rx_opt.mss_clamp = req->mss;
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index edd3e8665c1b..4984e654be65 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -615,6 +615,7 @@ static void bpf_skops_write_hdr_opt(struct sock *sk, struct sk_buff *skb,
  * (but it may well be that other scenarios fail similarly).
  */
 static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
+			      const struct tcp_request_sock *tcprsk,
 			      struct tcp_out_options *opts,
 			      struct tcp_key *key)
 {
@@ -629,20 +630,28 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
 		ptr += 4;
 	} else if (tcp_key_is_ao(key)) {
 #ifdef CONFIG_TCP_AO
-		struct tcp_ao_key *rnext_key;
-		struct tcp_ao_info *ao_info;
-		u8 maclen;
+		u8 maclen = tcp_ao_maclen(key->ao_key);
 
-		ao_info = rcu_dereference_check(tp->ao_info,
+		if (tcprsk) {
+			u8 aolen = maclen + sizeof(struct tcp_ao_hdr);
+
+			*ptr++ = htonl((TCPOPT_AO << 24) | (aolen << 16) |
+				       (tcprsk->ao_keyid << 8) |
+				       (tcprsk->ao_rcv_next));
+		} else {
+			struct tcp_ao_key *rnext_key;
+			struct tcp_ao_info *ao_info;
+
+			ao_info = rcu_dereference_check(tp->ao_info,
 				lockdep_sock_is_held(&tp->inet_conn.icsk_inet.sk));
-		rnext_key = READ_ONCE(ao_info->rnext_key);
-		if (WARN_ON_ONCE(!rnext_key))
-			goto out_ao;
-		maclen = tcp_ao_maclen(key->ao_key);
-		*ptr++ = htonl((TCPOPT_AO << 24) |
-				(tcp_ao_len(key->ao_key) << 16) |
-				(key->ao_key->sndid << 8) |
-				(rnext_key->rcvid));
+			rnext_key = READ_ONCE(ao_info->rnext_key);
+			if (WARN_ON_ONCE(!rnext_key))
+				goto out_ao;
+			*ptr++ = htonl((TCPOPT_AO << 24) |
+				       (tcp_ao_len(key->ao_key) << 16) |
+				       (key->ao_key->sndid << 8) |
+				       (rnext_key->rcvid));
+		}
 		opts->hash_location = (__u8 *)ptr;
 		ptr += maclen / sizeof(*ptr);
 		if (unlikely(maclen % sizeof(*ptr))) {
@@ -1384,7 +1393,7 @@ static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb,
 		th->window	= htons(min(tp->rcv_wnd, 65535U));
 	}
 
-	tcp_options_write(th, tp, &opts, &key);
+	tcp_options_write(th, tp, NULL, &opts, &key);
 
 	if (tcp_key_is_md5(&key)) {
 #ifdef CONFIG_TCP_MD5SIG
@@ -3729,7 +3738,7 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 
 	/* RFC1323: The window in SYN & SYN/ACK segments is never scaled. */
 	th->window = htons(min(req->rsk_rcv_wnd, 65535U));
-	tcp_options_write(th, NULL, &opts, &key);
+	tcp_options_write(th, NULL, NULL, &opts, &key);
 	th->doff = (tcp_header_size >> 2);
 	TCP_INC_STATS(sock_net(sk), TCP_MIB_OUTSEGS);
 
diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
index 5014aa663452..ad7a8caa7b2a 100644
--- a/net/ipv6/syncookies.c
+++ b/net/ipv6/syncookies.c
@@ -214,6 +214,8 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 	treq->snt_isn = cookie;
 	treq->ts_off = 0;
 	treq->txhash = net_tx_rndhash();
+	tcp_ao_syncookie(sk, skb, treq, AF_INET6);
+
 	if (IS_ENABLED(CONFIG_SMC))
 		ireq->smc_ok = 0;
 
diff --git a/net/ipv6/tcp_ao.c b/net/ipv6/tcp_ao.c
index d08735b6f3c5..c9a6fa84f6ce 100644
--- a/net/ipv6/tcp_ao.c
+++ b/net/ipv6/tcp_ao.c
@@ -49,6 +49,17 @@ static int tcp_v6_ao_calc_key(struct tcp_ao_key *mkt, u8 *key,
 	return err;
 }
 
+int tcp_v6_ao_calc_key_skb(struct tcp_ao_key *mkt, u8 *key,
+			   const struct sk_buff *skb,
+			   __be32 sisn, __be32 disn)
+{
+       const struct ipv6hdr *iph = ipv6_hdr(skb);
+       const struct tcphdr *th = tcp_hdr(skb);
+
+       return tcp_v6_ao_calc_key(mkt, key, &iph->saddr, &iph->daddr,
+				 th->source, th->dest, sisn, disn);
+}
+
 int tcp_v6_ao_calc_key_sk(struct tcp_ao_key *mkt, u8 *key,
 			  const struct sock *sk, __be32 sisn,
 			  __be32 disn, bool send)
@@ -63,9 +74,21 @@ int tcp_v6_ao_calc_key_sk(struct tcp_ao_key *mkt, u8 *key,
 					  htons(sk->sk_num), disn, sisn);
 }
 
-static struct tcp_ao_key *tcp_v6_ao_do_lookup(const struct sock *sk,
-					      const struct in6_addr *addr,
-					      int sndid, int rcvid)
+int tcp_v6_ao_calc_key_rsk(struct tcp_ao_key *mkt, u8 *key,
+			   struct request_sock *req)
+{
+	struct inet_request_sock *ireq = inet_rsk(req);
+
+	return tcp_v6_ao_calc_key(mkt, key,
+			&ireq->ir_v6_loc_addr, &ireq->ir_v6_rmt_addr,
+			htons(ireq->ir_num), ireq->ir_rmt_port,
+			htonl(tcp_rsk(req)->snt_isn),
+			htonl(tcp_rsk(req)->rcv_isn));
+}
+
+struct tcp_ao_key *tcp_v6_ao_do_lookup(const struct sock *sk,
+				       const struct in6_addr *addr,
+				       int sndid, int rcvid)
 {
 	return tcp_ao_do_lookup(sk, (union tcp_ao_addr *)addr, AF_INET6,
 				sndid, rcvid);
@@ -80,6 +103,15 @@ struct tcp_ao_key *tcp_v6_ao_lookup(const struct sock *sk,
 	return tcp_v6_ao_do_lookup(sk, addr, sndid, rcvid);
 }
 
+struct tcp_ao_key *tcp_v6_ao_lookup_rsk(const struct sock *sk,
+					struct request_sock *req,
+					int sndid, int rcvid)
+{
+	struct in6_addr *addr = &inet_rsk(req)->ir_v6_rmt_addr;
+
+	return tcp_v6_ao_do_lookup(sk, addr, sndid, rcvid);
+}
+
 int tcp_v6_ao_hash_pseudoheader(struct tcp_sigpool *hp,
 				const struct in6_addr *daddr,
 				const struct in6_addr *saddr, int nbytes)
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 7a871b774730..7d8dcbfe09ea 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -835,6 +835,10 @@ const struct tcp_request_sock_ops tcp_request_sock_ipv6_ops = {
 	.req_md5_lookup	=	tcp_v6_md5_lookup,
 	.calc_md5_hash	=	tcp_v6_md5_hash_skb,
 #endif
+#ifdef CONFIG_TCP_AO
+	.ao_lookup	=	tcp_v6_ao_lookup_rsk,
+	.ao_calc_key	=	tcp_v6_ao_calc_key_rsk,
+#endif
 #ifdef CONFIG_SYN_COOKIES
 	.cookie_init_seq =	cookie_v6_init_sequence,
 #endif
@@ -1189,16 +1193,54 @@ static void tcp_v6_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
 {
 	struct tcp_key key = {};
 
+#ifdef CONFIG_TCP_AO
+	if (tcp_rsk_used_ao(req)) {
+		const struct in6_addr *addr = &ipv6_hdr(skb)->saddr;
+		const struct tcp_ao_hdr *aoh;
+		int l3index;
+
+		l3index = tcp_v6_sdif(skb) ? tcp_v6_iif_l3_slave(skb) : 0;
+		/* Invalid TCP option size or twice included auth */
+		if (tcp_parse_auth_options(tcp_hdr(skb), NULL, &aoh))
+			return;
+		if (!aoh)
+			return;
+		key.ao_key = tcp_v6_ao_do_lookup(sk, addr, aoh->rnext_keyid, -1);
+		if (unlikely(!key.ao_key)) {
+			/* Send ACK with any matching MKT for the peer */
+			key.ao_key = tcp_v6_ao_do_lookup(sk, addr, -1, -1);
+			/* Matching key disappeared (user removed the key?)
+			 * let the handshake timeout.
+			 */
+			if (!key.ao_key) {
+				net_info_ratelimited("TCP-AO key for (%pI6, %d)->(%pI6, %d) suddenly disappeared, won't ACK new connection\n",
+						     addr,
+						     ntohs(tcp_hdr(skb)->source),
+						     &ipv6_hdr(skb)->daddr,
+						     ntohs(tcp_hdr(skb)->dest));
+				return;
+			}
+		}
+		key.traffic_key = kmalloc(tcp_ao_digest_size(key.ao_key), GFP_ATOMIC);
+		if (!key.traffic_key)
+			return;
+
+		key.type = TCP_KEY_AO;
+		key.rcv_next = aoh->keyid;
+		tcp_v6_ao_calc_key_rsk(key.ao_key, key.traffic_key, req);
+#else
+	if (0) {
+#endif
 #ifdef CONFIG_TCP_MD5SIG
-	if (static_branch_unlikely(&tcp_md5_needed.key)) {
+	} else if (static_branch_unlikely(&tcp_md5_needed.key)) {
 		int l3index = tcp_v6_sdif(skb) ? tcp_v6_iif_l3_slave(skb) : 0;
 
 		key.md5_key = tcp_v6_md5_do_lookup(sk, &ipv6_hdr(skb)->saddr,
 						   l3index);
 		if (key.md5_key)
 			key.type = TCP_KEY_MD5;
-	}
 #endif
+	}
 
 	/* sk->sk_state == TCP_LISTEN -> for regular TCP_SYN_RECV
 	 * sk->sk_state == TCP_SYN_RECV -> for Fast Open.
@@ -1217,6 +1259,8 @@ static void tcp_v6_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
 			&key, ipv6_get_dsfield(ipv6_hdr(skb)), 0,
 			READ_ONCE(sk->sk_priority),
 			READ_ONCE(tcp_rsk(req)->txhash));
+	if (tcp_key_is_ao(&key))
+		kfree(key.traffic_key);
 }
 
 
@@ -1446,19 +1490,26 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
 #ifdef CONFIG_TCP_MD5SIG
 	l3index = l3mdev_master_ifindex_by_index(sock_net(sk), ireq->ir_iif);
 
-	/* Copy over the MD5 key from the original socket */
-	key = tcp_v6_md5_do_lookup(sk, &newsk->sk_v6_daddr, l3index);
-	if (key) {
-		const union tcp_md5_addr *addr;
+	if (!tcp_rsk_used_ao(req)) {
+		/* Copy over the MD5 key from the original socket */
+		key = tcp_v6_md5_do_lookup(sk, &newsk->sk_v6_daddr, l3index);
+		if (key) {
+			const union tcp_md5_addr *addr;
 
-		addr = (union tcp_md5_addr *)&newsk->sk_v6_daddr;
-		if (tcp_md5_key_copy(newsk, addr, AF_INET6, 128, l3index, key)) {
-			inet_csk_prepare_forced_close(newsk);
-			tcp_done(newsk);
-			goto out;
+			addr = (union tcp_md5_addr *)&newsk->sk_v6_daddr;
+			if (tcp_md5_key_copy(newsk, addr, AF_INET6, 128, l3index, key)) {
+				inet_csk_prepare_forced_close(newsk);
+				tcp_done(newsk);
+				goto out;
+			}
 		}
 	}
 #endif
+#ifdef CONFIG_TCP_AO
+	/* Copy over tcp_ao_info if any */
+	if (tcp_ao_copy_all_matching(sk, newsk, req, skb, AF_INET6))
+		goto out; /* OOM */
+#endif
 
 	if (__inet_inherit_port(sk, newsk) < 0) {
 		inet_csk_prepare_forced_close(newsk);
-- 
2.42.0

