Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545027BEEBF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 01:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379002AbjJIXHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 19:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378984AbjJIXHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 19:07:42 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2716AB0
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 16:07:39 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-405524e6769so30331875e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 16:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1696892857; x=1697497657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EVzwDagNnx+C1oE84o8tdwincI7tSgZAuYSrRyZbL1I=;
        b=RdDXc/JP48otQQjSuhgPs0GHsP8QyDWpl7PYROH+iYxp38ATSC3vEDgq6X+bwreOO+
         M5mJErb6LyWzYYzSJS1pXhlBFpm03RNeYisP4+bVxjZGBwTMwZwAzS1vDaW1ndWrHOqO
         I2c1grToJPq6Y1aKOnSyYxRtHJFwIa7Hxkvd9vkaB4lkm8psEvdJp6BZeypmbaxxZ/TC
         Ng3YVEOck+Y0eTcOMPdTpoxGe3qx2Loa82PCqHnG4jZo21/nVXPATfnP+yms9sL0oKB0
         9U74GTJ/HL0yXTboqSWPpQKksy8nPnDgxGh0uqQVj9B/ms1l9RV1lKJs7kx4fOmKuTe8
         GNoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696892857; x=1697497657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EVzwDagNnx+C1oE84o8tdwincI7tSgZAuYSrRyZbL1I=;
        b=OPUNXlcO/Y1MsiRGEOM9lsWfcFmdQ8UWqqh0//DsTM6UVjT6YGehUQia1lfKY1lYM8
         bGkHt+BU5UYNcEQJwZdbC8QrqihG3owtVMq5kaFqyuOBe2kI8umwC2kiBjTbaxGtfBif
         ba7rHf9aGGsS1I5jc2xw9IHmtitWrx/IIx/MuXVePunNdjlqtM7Zb8b/z9mGak16E7SH
         LiizMy6YcRmJvZOporkDqFiJaq9oe4wKPogRVJ91LVcKYRxZL3q23B6yXLR1VfP6pK5S
         +FPt2T5h215pjw4Sg/pIh1z8eya9xDjq+EqXlrvij3D3TpGncyyOChMLw+mGaw/QrAqW
         r0jQ==
X-Gm-Message-State: AOJu0YyJC0sz6GJ6ySTVqCa0n17gNB1lbUgqJnZuF1YgtvJV3jU0Opa8
        86CxJiN57rgO+celvoDhFzKVrg==
X-Google-Smtp-Source: AGHT+IEFRErStMLzPekBZo/V4l9Ld0N52FuLl5Fdutw6m4mkg+3e0/JONmhoTRE8CmqIvASRkhohdw==
X-Received: by 2002:a05:600c:5189:b0:406:5a14:5c1e with SMTP id fa9-20020a05600c518900b004065a145c1emr10958345wmb.1.1696892857485;
        Mon, 09 Oct 2023 16:07:37 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id t24-20020a7bc3d8000000b004042dbb8925sm14592104wmj.38.2023.10.09.16.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 16:07:37 -0700 (PDT)
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
Subject: [PATCH v14 net-next 05/23] net/tcp: Calculate TCP-AO traffic keys
Date:   Tue, 10 Oct 2023 00:06:56 +0100
Message-ID: <20231009230722.76268-6-dima@arista.com>
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
 net/ipv4/tcp_ao.c     | 203 ++++++++++++++++++++++++++++++++++++++++++
 net/ipv4/tcp_input.c  |   2 +
 net/ipv4/tcp_ipv4.c   |   1 +
 net/ipv4/tcp_output.c |   2 +
 net/ipv6/tcp_ao.c     |  50 +++++++++++
 net/ipv6/tcp_ipv6.c   |   1 +
 8 files changed, 311 insertions(+), 2 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index d3d175b86272..1a03cbd919a0 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2159,6 +2159,9 @@ struct tcp_sock_af_ops {
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
index ee23356101f4..8e3aa82e649e 100644
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
@@ -177,6 +270,110 @@ struct tcp_ao_key *tcp_v4_ao_lookup(const struct sock *sk, struct sock *addr_sk,
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
+		/* TODO: probably, it should fail to connect() here */
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
@@ -558,6 +755,12 @@ static int tcp_ao_add_cmd(struct sock *sk, unsigned short int family,
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
index 4b8f2e74d71d..e46cff718d29 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6122,6 +6122,7 @@ void tcp_finish_connect(struct sock *sk, struct sk_buff *skb)
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct inet_connection_sock *icsk = inet_csk(sk);
 
+	tcp_ao_finish_connect(sk, skb);
 	tcp_set_state(sk, TCP_ESTABLISHED);
 	icsk->icsk_ack.lrcvtime = tcp_jiffies32;
 
@@ -6619,6 +6620,7 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 					  skb);
 			WRITE_ONCE(tp->copied_seq, tp->rcv_nxt);
 		}
+		tcp_ao_established(sk);
 		smp_mb();
 		tcp_set_state(sk, TCP_ESTABLISHED);
 		sk->sk_state_change(sk);
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index c92b92cbc3b8..b77cbe1047b3 100644
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
index bf83340fbd2c..4ebab9c8ad33 100644
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
index d9644f956db9..645fe82866c6 100644
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

