Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D800B7A5283
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 21:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjIRTBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 15:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjIRTBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 15:01:02 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C1B119
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 12:00:47 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3ff1c397405so52794755e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 12:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1695063646; x=1695668446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/KqfEjXPeuB2YCjPEzXtf2MCjnvhIA27JZkEJ2brlw=;
        b=GSTtYO5rU7nIExuLeWGR2QG6YfwjADvnH8OqwqhSRGrz8h63Kb58u4FjmsKg5tNs64
         fJ/kKJqD7ESkQ7m27JSmJub9Dv9DdPscmTc6ErUWDn/tgg9u3d7h4BR4Xl7ymHzaF0uB
         jWdA9syVgcWBwEblDkw7ePTnCyTeWu86wtqE7ZH/KL6VIUgiawxMU2y1k61pqB4vOwiX
         BNA/nv6wetuE2ISPXVTobMAr8JC9j9gjQTyE3uXpS3JzHfRGROlk06AP/BRwf73AqP2U
         1ToO9MVsj/TCFHyCi30A2l0Bfv85Jop5x3GDCRBQJRPYu7Xg4NQynOAGal8c8IGbB81L
         1fWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695063646; x=1695668446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t/KqfEjXPeuB2YCjPEzXtf2MCjnvhIA27JZkEJ2brlw=;
        b=i3XxH1CCyYIPuR1WVQcUGmXK9AK0r7RzBC3wqtXvcCse2JLM/YABjT8ti87zqsREFO
         J6oHIPFft+SgkhwIWPcOfUMdLFlWAwyD5NeIJxgrq7kf+6f/ob6XzruxvNPF20WBEW3+
         HmQp2fXEG8o1NjBvjChABobzRrEBO5fY79riOX6XmRcDm890QGdp4I6VFzU7aWOutDBY
         XCEQbICaJRG2ndyKNVRTbdbMMM3X1kyI83L9If3VFCv91+gPEfnQtv/jPpQhT+h4IZhG
         7BvCKlVwj8Hc9gFZPdL0uZg3mm4u6HIiaSrbW59zGF0dRwJlcqeLZjY1rmhfsDtt/iv1
         P7pQ==
X-Gm-Message-State: AOJu0YwRWyXEwZoZmbSGq973gyPBVoQQhyJv3LarsCNMhS1urVDdhPQJ
        8H7pWKWtCfsUb0ra+akha723qA==
X-Google-Smtp-Source: AGHT+IH5TPgLrDZomZln+AcPM3LWx5j4NSIc98jfrQeOfl1dxNMFyLtO6qM44fcxA+gh60IMT6wIqg==
X-Received: by 2002:a7b:ca4a:0:b0:401:c297:affb with SMTP id m10-20020a7bca4a000000b00401c297affbmr9152881wml.37.1695063645189;
        Mon, 18 Sep 2023 12:00:45 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id n9-20020a05600c3b8900b004047ac770d1sm10762707wms.8.2023.09.18.12.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 12:00:44 -0700 (PDT)
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
Subject: [PATCH v12 net-next 05/23] net/tcp: Calculate TCP-AO traffic keys
Date:   Mon, 18 Sep 2023 20:00:03 +0100
Message-ID: <20230918190027.613430-6-dima@arista.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230918190027.613430-1-dima@arista.com>
References: <20230918190027.613430-1-dima@arista.com>
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

Add traffic key calculation the way it's described in RFC5926.
Wire it up to tcp_finish_connect() and cache the new keys straight away
on already established TCP connections.

Co-developed-by: Francesco Ruggeri <fruggeri@arista.com>
Signed-off-by: Francesco Ruggeri <fruggeri@arista.com>
Co-developed-by: Salam Noureddine <noureddine@arista.com>
Signed-off-by: Salam Noureddine <noureddine@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
Acked-by: David Ahern <dsahern@kernel.org>
---
 include/net/tcp.h     |   3 +
 include/net/tcp_ao.h  |  46 +++++++++-
 net/ipv4/tcp_ao.c     | 190 ++++++++++++++++++++++++++++++++++++++++++
 net/ipv4/tcp_input.c  |   1 +
 net/ipv4/tcp_ipv4.c   |   1 +
 net/ipv4/tcp_output.c |   2 +
 net/ipv6/tcp_ao.c     |  50 +++++++++++
 net/ipv6/tcp_ipv6.c   |   1 +
 8 files changed, 292 insertions(+), 2 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index b1e69f346364..45df08b5ad28 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2155,6 +2155,9 @@ struct tcp_sock_af_ops {
 	struct tcp_ao_key *(*ao_lookup)(const struct sock *sk,
 					struct sock *addr_sk,
 					int sndid, int rcvid);
+	int (*ao_calc_key_sk)(struct tcp_ao_key *mkt, u8 *key,
+			      const struct sock *sk,
+			      __be32 sisn, __be32 disn, bool send);
 #endif
 };
 
diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
index 3c7f576376f9..7e0ce45d9934 100644
--- a/include/net/tcp_ao.h
+++ b/include/net/tcp_ao.h
@@ -89,8 +89,32 @@ struct tcp_ao_info {
 };
 
 #ifdef CONFIG_TCP_AO
+/* TCP-AO structures and functions */
+
+struct tcp4_ao_context {
+	__be32		saddr;
+	__be32		daddr;
+	__be16		sport;
+	__be16		dport;
+	__be32		sisn;
+	__be32		disn;
+};
+
+struct tcp6_ao_context {
+	struct in6_addr	saddr;
+	struct in6_addr	daddr;
+	__be16		sport;
+	__be16		dport;
+	__be32		sisn;
+	__be32		disn;
+};
+
+struct tcp_sigpool;
+
 int tcp_parse_ao(struct sock *sk, int cmd, unsigned short int family,
 		 sockptr_t optval, int optlen);
+int tcp_ao_calc_traffic_key(struct tcp_ao_key *mkt, u8 *key, void *ctx,
+			    unsigned int len, struct tcp_sigpool *hp);
 void tcp_ao_destroy_sock(struct sock *sk);
 struct tcp_ao_key *tcp_ao_do_lookup(const struct sock *sk,
 				    const union tcp_ao_addr *addr,
@@ -99,11 +123,21 @@ struct tcp_ao_key *tcp_ao_do_lookup(const struct sock *sk,
 int tcp_v4_parse_ao(struct sock *sk, int cmd, sockptr_t optval, int optlen);
 struct tcp_ao_key *tcp_v4_ao_lookup(const struct sock *sk, struct sock *addr_sk,
 				    int sndid, int rcvid);
+int tcp_v4_ao_calc_key_sk(struct tcp_ao_key *mkt, u8 *key,
+			  const struct sock *sk,
+			  __be32 sisn, __be32 disn, bool send);
 /* ipv6 specific functions */
-int tcp_v6_parse_ao(struct sock *sk, int cmd, sockptr_t optval, int optlen);
+int tcp_v6_ao_calc_key_sk(struct tcp_ao_key *mkt, u8 *key,
+			  const struct sock *sk, __be32 sisn,
+			  __be32 disn, bool send);
 struct tcp_ao_key *tcp_v6_ao_lookup(const struct sock *sk,
 				    struct sock *addr_sk, int sndid, int rcvid);
-#else
+int tcp_v6_parse_ao(struct sock *sk, int cmd, sockptr_t optval, int optlen);
+void tcp_ao_finish_connect(struct sock *sk, struct sk_buff *skb);
+void tcp_ao_connect_init(struct sock *sk);
+
+#else /* CONFIG_TCP_AO */
+
 static inline struct tcp_ao_key *tcp_ao_do_lookup(const struct sock *sk,
 		const union tcp_ao_addr *addr, int family, int sndid, int rcvid)
 {
@@ -113,6 +147,14 @@ static inline struct tcp_ao_key *tcp_ao_do_lookup(const struct sock *sk,
 static inline void tcp_ao_destroy_sock(struct sock *sk)
 {
 }
+
+static inline void tcp_ao_finish_connect(struct sock *sk, struct sk_buff *skb)
+{
+}
+
+static inline void tcp_ao_connect_init(struct sock *sk)
+{
+}
 #endif
 
 #endif /* _TCP_AO_H */
diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index 0a530076abdc..fc7a6aa1936e 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -16,6 +16,34 @@
 #include <net/tcp.h>
 #include <net/ipv6.h>
 
+int tcp_ao_calc_traffic_key(struct tcp_ao_key *mkt, u8 *key, void *ctx,
+			    unsigned int len, struct tcp_sigpool *hp)
+{
+	struct scatterlist sg;
+	int ret;
+
+	if (crypto_ahash_setkey(crypto_ahash_reqtfm(hp->req),
+				mkt->key, mkt->keylen))
+		goto clear_hash;
+
+	ret = crypto_ahash_init(hp->req);
+	if (ret)
+		goto clear_hash;
+
+	sg_init_one(&sg, ctx, len);
+	ahash_request_set_crypt(hp->req, &sg, key, len);
+	crypto_ahash_update(hp->req);
+
+	ret = crypto_ahash_final(hp->req);
+	if (ret)
+		goto clear_hash;
+
+	return 0;
+clear_hash:
+	memset(key, 0, tcp_ao_digest_size(mkt));
+	return 1;
+}
+
 /* Optimized version of tcp_ao_do_lookup(): only for sockets for which
  * it's known that the keys in ao_info are matching peer's
  * family/address/VRF/etc.
@@ -169,6 +197,71 @@ void tcp_ao_destroy_sock(struct sock *sk)
 	kfree_rcu(ao, rcu);
 }
 
+/* 4 tuple and ISNs are expected in NBO */
+static int tcp_v4_ao_calc_key(struct tcp_ao_key *mkt, u8 *key,
+			      __be32 saddr, __be32 daddr,
+			      __be16 sport, __be16 dport,
+			      __be32 sisn,  __be32 disn)
+{
+	/* See RFC5926 3.1.1 */
+	struct kdf_input_block {
+		u8                      counter;
+		u8                      label[6];
+		struct tcp4_ao_context	ctx;
+		__be16                  outlen;
+	} __packed * tmp;
+	struct tcp_sigpool hp;
+	int err;
+
+	err = tcp_sigpool_start(mkt->tcp_sigpool_id, &hp);
+	if (err)
+		return err;
+
+	tmp = hp.scratch;
+	tmp->counter	= 1;
+	memcpy(tmp->label, "TCP-AO", 6);
+	tmp->ctx.saddr	= saddr;
+	tmp->ctx.daddr	= daddr;
+	tmp->ctx.sport	= sport;
+	tmp->ctx.dport	= dport;
+	tmp->ctx.sisn	= sisn;
+	tmp->ctx.disn	= disn;
+	tmp->outlen	= htons(tcp_ao_digest_size(mkt) * 8); /* in bits */
+
+	err = tcp_ao_calc_traffic_key(mkt, key, tmp, sizeof(*tmp), &hp);
+	tcp_sigpool_end(&hp);
+
+	return err;
+}
+
+int tcp_v4_ao_calc_key_sk(struct tcp_ao_key *mkt, u8 *key,
+			  const struct sock *sk,
+			  __be32 sisn, __be32 disn, bool send)
+{
+	if (send)
+		return tcp_v4_ao_calc_key(mkt, key, sk->sk_rcv_saddr,
+					  sk->sk_daddr, htons(sk->sk_num),
+					  sk->sk_dport, sisn, disn);
+	else
+		return tcp_v4_ao_calc_key(mkt, key, sk->sk_daddr,
+					  sk->sk_rcv_saddr, sk->sk_dport,
+					  htons(sk->sk_num), disn, sisn);
+}
+
+static int tcp_ao_calc_key_sk(struct tcp_ao_key *mkt, u8 *key,
+			      const struct sock *sk,
+			      __be32 sisn, __be32 disn, bool send)
+{
+	if (mkt->family == AF_INET)
+		return tcp_v4_ao_calc_key_sk(mkt, key, sk, sisn, disn, send);
+#if IS_ENABLED(CONFIG_IPV6)
+	else if (mkt->family == AF_INET6)
+		return tcp_v6_ao_calc_key_sk(mkt, key, sk, sisn, disn, send);
+#endif
+	else
+		return -EOPNOTSUPP;
+}
+
 struct tcp_ao_key *tcp_v4_ao_lookup(const struct sock *sk, struct sock *addr_sk,
 				    int sndid, int rcvid)
 {
@@ -177,6 +270,97 @@ struct tcp_ao_key *tcp_v4_ao_lookup(const struct sock *sk, struct sock *addr_sk,
 	return tcp_ao_do_lookup(sk, addr, AF_INET, sndid, rcvid);
 }
 
+static int tcp_ao_cache_traffic_keys(const struct sock *sk,
+				     struct tcp_ao_info *ao,
+				     struct tcp_ao_key *ao_key)
+{
+	u8 *traffic_key = snd_other_key(ao_key);
+	int ret;
+
+	ret = tcp_ao_calc_key_sk(ao_key, traffic_key, sk,
+				 ao->lisn, ao->risn, true);
+	if (ret)
+		return ret;
+
+	traffic_key = rcv_other_key(ao_key);
+	ret = tcp_ao_calc_key_sk(ao_key, traffic_key, sk,
+				 ao->lisn, ao->risn, false);
+	return ret;
+}
+
+void tcp_ao_connect_init(struct sock *sk)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+	struct tcp_ao_info *ao_info;
+	union tcp_ao_addr *addr;
+	struct tcp_ao_key *key;
+	int family;
+
+	ao_info = rcu_dereference_protected(tp->ao_info,
+					    lockdep_sock_is_held(sk));
+	if (!ao_info)
+		return;
+
+	/* Remove all keys that don't match the peer */
+	family = sk->sk_family;
+	if (family == AF_INET)
+		addr = (union tcp_ao_addr *)&sk->sk_daddr;
+#if IS_ENABLED(CONFIG_IPV6)
+	else if (family == AF_INET6)
+		addr = (union tcp_ao_addr *)&sk->sk_v6_daddr;
+#endif
+	else
+		return;
+
+	hlist_for_each_entry_rcu(key, &ao_info->head, node) {
+		if (!tcp_ao_key_cmp(key, addr, key->prefixlen, family, -1, -1))
+			continue;
+
+		if (key == ao_info->current_key)
+			ao_info->current_key = NULL;
+		if (key == ao_info->rnext_key)
+			ao_info->rnext_key = NULL;
+		hlist_del_rcu(&key->node);
+		tcp_sigpool_release(key->tcp_sigpool_id);
+		atomic_sub(tcp_ao_sizeof_key(key), &sk->sk_omem_alloc);
+		kfree_rcu(key, rcu);
+	}
+
+	key = tp->af_specific->ao_lookup(sk, sk, -1, -1);
+	if (key) {
+		/* if current_key or rnext_key were not provided,
+		 * use the first key matching the peer
+		 */
+		if (!ao_info->current_key)
+			ao_info->current_key = key;
+		if (!ao_info->rnext_key)
+			ao_info->rnext_key = key;
+		tp->tcp_header_len += tcp_ao_len(key);
+
+		ao_info->lisn = htonl(tp->write_seq);
+	} else {
+		/* TODO: probably, it should fail to connect() here */
+		rcu_assign_pointer(tp->ao_info, NULL);
+		kfree(ao_info);
+	}
+}
+
+void tcp_ao_finish_connect(struct sock *sk, struct sk_buff *skb)
+{
+	struct tcp_ao_info *ao;
+	struct tcp_ao_key *key;
+
+	ao = rcu_dereference_protected(tcp_sk(sk)->ao_info,
+				       lockdep_sock_is_held(sk));
+	if (!ao)
+		return;
+
+	ao->risn = tcp_hdr(skb)->seq;
+
+	hlist_for_each_entry_rcu(key, &ao->head, node)
+		tcp_ao_cache_traffic_keys(sk, ao, key);
+}
+
 static bool tcp_ao_can_set_current_rnext(struct sock *sk)
 {
 	/* There aren't current/rnext keys on TCP_LISTEN sockets */
@@ -558,6 +742,12 @@ static int tcp_ao_add_cmd(struct sock *sk, unsigned short int family,
 	if (ret < 0)
 		goto err_free_sock;
 
+	/* Change this condition if we allow adding keys in states
+	 * like close_wait, syn_sent or fin_wait...
+	 */
+	if (sk->sk_state == TCP_ESTABLISHED)
+		tcp_ao_cache_traffic_keys(sk, ao_info, key);
+
 	tcp_ao_link_mkt(ao_info, key);
 	if (first) {
 		sk_gso_disable(sk);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 584825ddd0a0..96d684644eec 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6109,6 +6109,7 @@ void tcp_finish_connect(struct sock *sk, struct sk_buff *skb)
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct inet_connection_sock *icsk = inet_csk(sk);
 
+	tcp_ao_finish_connect(sk, skb);
 	tcp_set_state(sk, TCP_ESTABLISHED);
 	icsk->icsk_ack.lrcvtime = tcp_jiffies32;
 
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index f07ba6858c5d..e317fb7f34b0 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2285,6 +2285,7 @@ static const struct tcp_sock_af_ops tcp_sock_ipv4_specific = {
 #ifdef CONFIG_TCP_AO
 	.ao_lookup		= tcp_v4_ao_lookup,
 	.ao_parse		= tcp_v4_parse_ao,
+	.ao_calc_key_sk		= tcp_v4_ao_calc_key_sk,
 #endif
 };
 #endif
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 4891ff45c0b4..1aff773dd740 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3749,6 +3749,8 @@ static void tcp_connect_init(struct sock *sk)
 	if (READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_timestamps))
 		tp->tcp_header_len += TCPOLEN_TSTAMP_ALIGNED;
 
+	tcp_ao_connect_init(sk);
+
 	/* If user gave his TCP_MAXSEG, record it to clamp */
 	if (tp->rx_opt.user_mss)
 		tp->rx_opt.mss_clamp = tp->rx_opt.user_mss;
diff --git a/net/ipv6/tcp_ao.c b/net/ipv6/tcp_ao.c
index 0640acaee67b..9ab594fadbd9 100644
--- a/net/ipv6/tcp_ao.c
+++ b/net/ipv6/tcp_ao.c
@@ -12,6 +12,56 @@
 #include <net/tcp.h>
 #include <net/ipv6.h>
 
+static int tcp_v6_ao_calc_key(struct tcp_ao_key *mkt, u8 *key,
+			      const struct in6_addr *saddr,
+			      const struct in6_addr *daddr,
+			      __be16 sport, __be16 dport,
+			      __be32 sisn, __be32 disn)
+{
+	struct kdf_input_block {
+		u8			counter;
+		u8			label[6];
+		struct tcp6_ao_context	ctx;
+		__be16			outlen;
+	} __packed * tmp;
+	struct tcp_sigpool hp;
+	int err;
+
+	err = tcp_sigpool_start(mkt->tcp_sigpool_id, &hp);
+	if (err)
+		return err;
+
+	tmp = hp.scratch;
+	tmp->counter	= 1;
+	memcpy(tmp->label, "TCP-AO", 6);
+	tmp->ctx.saddr	= *saddr;
+	tmp->ctx.daddr	= *daddr;
+	tmp->ctx.sport	= sport;
+	tmp->ctx.dport	= dport;
+	tmp->ctx.sisn	= sisn;
+	tmp->ctx.disn	= disn;
+	tmp->outlen	= htons(tcp_ao_digest_size(mkt) * 8); /* in bits */
+
+	err = tcp_ao_calc_traffic_key(mkt, key, tmp, sizeof(*tmp), &hp);
+	tcp_sigpool_end(&hp);
+
+	return err;
+}
+
+int tcp_v6_ao_calc_key_sk(struct tcp_ao_key *mkt, u8 *key,
+			  const struct sock *sk, __be32 sisn,
+			  __be32 disn, bool send)
+{
+	if (send)
+		return tcp_v6_ao_calc_key(mkt, key, &sk->sk_v6_rcv_saddr,
+					  &sk->sk_v6_daddr, htons(sk->sk_num),
+					  sk->sk_dport, sisn, disn);
+	else
+		return tcp_v6_ao_calc_key(mkt, key, &sk->sk_v6_daddr,
+					  &sk->sk_v6_rcv_saddr, sk->sk_dport,
+					  htons(sk->sk_num), disn, sisn);
+}
+
 static struct tcp_ao_key *tcp_v6_ao_do_lookup(const struct sock *sk,
 					      const struct in6_addr *addr,
 					      int sndid, int rcvid)
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 1fa7d7c2e254..9bf199aa00a2 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1917,6 +1917,7 @@ static const struct tcp_sock_af_ops tcp_sock_ipv6_specific = {
 #ifdef CONFIG_TCP_AO
 	.ao_lookup	=	tcp_v6_ao_lookup,
 	.ao_parse	=	tcp_v6_parse_ao,
+	.ao_calc_key_sk	=	tcp_v6_ao_calc_key_sk,
 #endif
 };
 #endif
-- 
2.41.0

