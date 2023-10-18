Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDB97CE984
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 22:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbjJRU6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 16:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbjJRU6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 16:58:30 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD337122
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 13:58:26 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4083740f92dso14484695e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 13:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1697662705; x=1698267505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r4V+l3xtejHMbemOnAxxByKE/b22oGTrfOSZpabMLIU=;
        b=PtHJ62YQ8HaSEg+oEa4o4qPZJ6x0o/iRs1fhzqM9Xnykx0cwNElcGtFM+ClZ/aCo7m
         u0vj+bPUYqiP7KWH6M38wrtr9u99WnKLX9wFwRFwhJ80v6bwX8M7OUMxIP8HT2cpr1fO
         mHaSLUbcLlbVxHZLQfry/VFg5ufebNoLvz8SRRPmRrusb8dUupDH4QbjhUnpOn6kl6A/
         KMip3T7OjtN96H8U6lDQOJWFW2OzjSJkdmP/K5lhJAj3P4UTWgfhUoW5wNb6f2Tx7ir4
         IUURlXZ/z9+fXK8YvEY/VdN5mf16OgxKYLD8DxPfNumWzdxpXaXzXulYYzi3fCbO1siu
         +gXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697662705; x=1698267505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r4V+l3xtejHMbemOnAxxByKE/b22oGTrfOSZpabMLIU=;
        b=d2lEiGawp4E6tYojki4xkh/sbRY78LHiIe7OPz8V6J/G29zX7Wvwk1HQUAyO10CHlq
         ZWsSjhphYZ071a9gtd5emzWeIvd5TPOida+QQesHY0W23nUyj2jZwLM6PmyydVQncc8/
         FOWiFwLX6sls5CE3XKCwmdzfHNZ+ypF6j4qWsaO7U6MTD2pOSKChcORNoYXrj81LWIub
         gpcMMW+lr4O9oRuLAKfzW8CDNhR7qXtINBtuyfEwbd2AwBy1JAGYC1qsePBSgwsnGfTE
         ypVpXa26cZlYGtqOzxEacPAxITPBjbXEylP3QGgHad3bP+eDCtUfNinhL6Ud6aEYR2gQ
         Kb4Q==
X-Gm-Message-State: AOJu0Yy1520JsSJ6MhqD9m0M0nWHNqeOk0Sdn9ZdCqCUq0Hx5mCapZM/
        WY8tUbkpkwjfid6ordOSrYwmow==
X-Google-Smtp-Source: AGHT+IFNZqJFjekVgx/Ubh1aLdLLzb3iHPgqJNZhr4lfZBfdI/kI4AH95AqaY9LyOSvIOma1Sp80lQ==
X-Received: by 2002:a05:600c:3b8e:b0:408:3c8a:65ec with SMTP id n14-20020a05600c3b8e00b004083c8a65ecmr379110wms.8.1697662704962;
        Wed, 18 Oct 2023 13:58:24 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x19-20020a05600c421300b003fc16ee2864sm2569006wmh.48.2023.10.18.13.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 13:58:24 -0700 (PDT)
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
Subject: [PATCH v15 net-next 05/23] net/tcp: Calculate TCP-AO traffic keys
Date:   Wed, 18 Oct 2023 21:57:19 +0100
Message-ID: <20231018205806.322831-6-dima@arista.com>
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
 include/net/tcp_ao.h  |  51 ++++++++++-
 net/ipv4/tcp_ao.c     | 206 ++++++++++++++++++++++++++++++++++++++++++
 net/ipv4/tcp_input.c  |   2 +
 net/ipv4/tcp_ipv4.c   |   1 +
 net/ipv4/tcp_output.c |   2 +
 net/ipv6/tcp_ao.c     |  50 ++++++++++
 net/ipv6/tcp_ipv6.c   |   1 +
 8 files changed, 314 insertions(+), 2 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index ae70b3c7df9a..4eb4bdb8df91 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2165,6 +2165,9 @@ struct tcp_sock_af_ops {
 	struct tcp_ao_key *(*ao_lookup)(const struct sock *sk,
 					struct sock *addr_sk,
 					int sndid, int rcvid);
+	int (*ao_calc_key_sk)(struct tcp_ao_key *mkt, u8 *key,
+			      const struct sock *sk,
+			      __be32 sisn, __be32 disn, bool send);
 #endif
 };
 
diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
index 3c7f576376f9..b021a811511b 100644
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
@@ -99,11 +123,22 @@ struct tcp_ao_key *tcp_ao_do_lookup(const struct sock *sk,
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
+void tcp_ao_established(struct sock *sk);
+void tcp_ao_finish_connect(struct sock *sk, struct sk_buff *skb);
+void tcp_ao_connect_init(struct sock *sk);
+
+#else /* CONFIG_TCP_AO */
+
 static inline struct tcp_ao_key *tcp_ao_do_lookup(const struct sock *sk,
 		const union tcp_ao_addr *addr, int family, int sndid, int rcvid)
 {
@@ -113,6 +148,18 @@ static inline struct tcp_ao_key *tcp_ao_do_lookup(const struct sock *sk,
 static inline void tcp_ao_destroy_sock(struct sock *sk)
 {
 }
+
+static inline void tcp_ao_established(struct sock *sk)
+{
+}
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
index ee23356101f4..e478341fc336 100644
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
@@ -177,6 +270,113 @@ struct tcp_ao_key *tcp_v4_ao_lookup(const struct sock *sk, struct sock *addr_sk,
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
+		atomic_sub(tcp_ao_sizeof_key(key), &sk->sk_omem_alloc);
+		call_rcu(&key->rcu, tcp_ao_key_free_rcu);
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
+		/* Can't happen: tcp_connect() verifies that there's
+		 * at least one tcp-ao key that matches the remote peer.
+		 */
+		WARN_ON_ONCE(1);
+		rcu_assign_pointer(tp->ao_info, NULL);
+		kfree(ao_info);
+	}
+}
+
+void tcp_ao_established(struct sock *sk)
+{
+	struct tcp_ao_info *ao;
+	struct tcp_ao_key *key;
+
+	ao = rcu_dereference_protected(tcp_sk(sk)->ao_info,
+				       lockdep_sock_is_held(sk));
+	if (!ao)
+		return;
+
+	hlist_for_each_entry_rcu(key, &ao->head, node)
+		tcp_ao_cache_traffic_keys(sk, ao, key);
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
+	WRITE_ONCE(ao->risn, tcp_hdr(skb)->seq);
+
+	hlist_for_each_entry_rcu(key, &ao->head, node)
+		tcp_ao_cache_traffic_keys(sk, ao, key);
+}
+
 static bool tcp_ao_can_set_current_rnext(struct sock *sk)
 {
 	/* There aren't current/rnext keys on TCP_LISTEN sockets */
@@ -558,6 +758,12 @@ static int tcp_ao_add_cmd(struct sock *sk, unsigned short int family,
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
index ab87f0285b72..ae221023440b 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6145,6 +6145,7 @@ void tcp_finish_connect(struct sock *sk, struct sk_buff *skb)
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct inet_connection_sock *icsk = inet_csk(sk);
 
+	tcp_ao_finish_connect(sk, skb);
 	tcp_set_state(sk, TCP_ESTABLISHED);
 	icsk->icsk_ack.lrcvtime = tcp_jiffies32;
 
@@ -6642,6 +6643,7 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 					  skb);
 			WRITE_ONCE(tp->copied_seq, tp->rcv_nxt);
 		}
+		tcp_ao_established(sk);
 		smp_mb();
 		tcp_set_state(sk, TCP_ESTABLISHED);
 		sk->sk_state_change(sk);
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 6d538ca860e8..e7f5e7ad282e 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2286,6 +2286,7 @@ static const struct tcp_sock_af_ops tcp_sock_ipv4_specific = {
 #ifdef CONFIG_TCP_AO
 	.ao_lookup		= tcp_v4_ao_lookup,
 	.ao_parse		= tcp_v4_parse_ao,
+	.ao_calc_key_sk		= tcp_v4_ao_calc_key_sk,
 #endif
 };
 #endif
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 910e19bb2799..a091a3bb60e3 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3750,6 +3750,8 @@ static void tcp_connect_init(struct sock *sk)
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
index 2cdbead6fd65..36e9da8980a1 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1921,6 +1921,7 @@ static const struct tcp_sock_af_ops tcp_sock_ipv6_specific = {
 #ifdef CONFIG_TCP_AO
 	.ao_lookup	=	tcp_v6_ao_lookup,
 	.ao_parse	=	tcp_v6_parse_ao,
+	.ao_calc_key_sk	=	tcp_v6_ao_calc_key_sk,
 #endif
 };
 #endif
-- 
2.42.0

