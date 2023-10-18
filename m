Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0585C7CE995
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 22:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344678AbjJRU6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 16:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232109AbjJRU6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 16:58:33 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C77FE
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 13:58:28 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-32d9d8284abso4695747f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 13:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1697662707; x=1698267507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Sk4oXcM1ia9ks6HXk9wQWBLsg/hOo4rdxCwxV3H44A=;
        b=b3apIT6My4/8K3gyuj/+cvdy/uwQYz0ZdxdAfAZeBPPCQ8O4ZVnWerbqfGbDp+8+GP
         keIK4VUfNt72Acp/6CXXdqe7tz5Hy7pMJPMDlO2aOjqoUdu4Q8u+UKp7ug2rfL77tIy6
         kdTs81WoK38Xw60zveo9YaBV6UyBnBXzk/pVnKFofHWh2TOJegUjnY7Db0Ihu0D/3HtN
         nGnDhzJKSuftlARnsrUtmSULKBhHC7TLK1nWQ660aZ9SJEN0VKrcuCnvAnYQ+VoIggKv
         C1AXcuA//t4gRJkruYQzMyXd9DVn1OMNlwiGUE2bwzilYi+TCmv2PbUaSlZv4CUj1VyE
         aSGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697662707; x=1698267507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Sk4oXcM1ia9ks6HXk9wQWBLsg/hOo4rdxCwxV3H44A=;
        b=SsoPU/QcEGIFJZmumk3hTB29Vuex2DKiIBLkN1kBW32i1lFJHe4fmUKwBHmaOhwPAj
         +Q7SuTpkoP+mYHw5S1A1auAFv4VYwbLqOMkUutcUuT+RAUMSO2p0SzaMCLRhcumnflar
         caufSzJiQoQcE+oEQ8HdnbCUpbHE2wp2mKFKyFt14fRMt3OdOnlGNCJKlVrIIA36jcQw
         gomp739+q9vUrQkT3YBgq9hB+FK0Y5YtzJbPiHmsuKLpwO+CuR51ghP0vkNJkdkEFnzE
         rbeZjEcq3llj0OT5W0UCCSCn/8hA0S/e66rIoxk6YM3tOl0QqR1dO2Bkjbdyrmn6FD+3
         ++CA==
X-Gm-Message-State: AOJu0YzDtzHFwW9lMgwIxaoMi0BINGqjNmq6koDsNAbnW0IH3KpUigQZ
        WrLz/vM/e20cvHCtG41ySnZ+OglzGO+s/X4bveQ=
X-Google-Smtp-Source: AGHT+IHfNxefjw6sKi7BODGgcbDIv82gVXlDhUEZ19rmBb60dnYdQCjjPNRa5ml5FE3ETpXq80gWZQ==
X-Received: by 2002:a05:6000:83:b0:329:6b3e:d87d with SMTP id m3-20020a056000008300b003296b3ed87dmr118955wrx.42.1697662707106;
        Wed, 18 Oct 2023 13:58:27 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x19-20020a05600c421300b003fc16ee2864sm2569006wmh.48.2023.10.18.13.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 13:58:26 -0700 (PDT)
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
Subject: [PATCH v15 net-next 06/23] net/tcp: Add TCP-AO sign to outgoing packets
Date:   Wed, 18 Oct 2023 21:57:20 +0100
Message-ID: <20231018205806.322831-7-dima@arista.com>
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

Using precalculated traffic keys, sign TCP segments as prescribed by
RFC5925. Per RFC, TCP header options are included in sign calculation:
"The TCP header, by default including options, and where the TCP
checksum and TCP-AO MAC fields are set to zero, all in network-
byte order." (5.1.3)

tcp_ao_hash_header() has exclude_options parameter to optionally exclude
TCP header from hash calculation, as described in RFC5925 (9.1), this is
needed for interaction with middleboxes that may change "some TCP
options". This is wired up to AO key flags and setsockopt() later.

Similarly to TCP-MD5 hash TCP segment fragments.

From this moment a user can start sending TCP-AO signed segments with
one of crypto ahash algorithms from supported by Linux kernel. It can
have a user-specified MAC length, to either save TCP option header space
or provide higher protection using a longer signature.
The inbound segments are not yet verified, TCP-AO option is ignored and
they are accepted.

Co-developed-by: Francesco Ruggeri <fruggeri@arista.com>
Signed-off-by: Francesco Ruggeri <fruggeri@arista.com>
Co-developed-by: Salam Noureddine <noureddine@arista.com>
Signed-off-by: Salam Noureddine <noureddine@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
Acked-by: David Ahern <dsahern@kernel.org>
---
 include/net/tcp.h     |  64 ++++++++++++++
 include/net/tcp_ao.h  |  23 +++++
 net/ipv4/tcp_ao.c     | 199 ++++++++++++++++++++++++++++++++++++++++++
 net/ipv4/tcp_ipv4.c   |   1 +
 net/ipv4/tcp_output.c | 112 ++++++++++++++++--------
 net/ipv6/tcp_ao.c     |  28 ++++++
 net/ipv6/tcp_ipv6.c   |   2 +
 7 files changed, 391 insertions(+), 38 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 4eb4bdb8df91..f7cfbd5e9b8c 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -187,6 +187,7 @@ static_assert((1 << ATO_BITS) > TCP_DELACK_MAX);
 #define TCPOPT_SACK             5       /* SACK Block */
 #define TCPOPT_TIMESTAMP	8	/* Better RTT estimations/PAWS */
 #define TCPOPT_MD5SIG		19	/* MD5 Signature (RFC2385) */
+#define TCPOPT_AO		29	/* Authentication Option (RFC5925) */
 #define TCPOPT_MPTCP		30	/* Multipath TCP (RFC6824) */
 #define TCPOPT_FASTOPEN		34	/* Fast open (RFC7413) */
 #define TCPOPT_EXP		254	/* Experimental */
@@ -2168,6 +2169,9 @@ struct tcp_sock_af_ops {
 	int (*ao_calc_key_sk)(struct tcp_ao_key *mkt, u8 *key,
 			      const struct sock *sk,
 			      __be32 sisn, __be32 disn, bool send);
+	int (*calc_ao_hash)(char *location, struct tcp_ao_key *ao,
+			    const struct sock *sk, const struct sk_buff *skb,
+			    const u8 *tkey, int hash_offset, u32 sne);
 #endif
 };
 
@@ -2221,6 +2225,66 @@ static inline __u32 cookie_init_sequence(const struct tcp_request_sock_ops *ops,
 }
 #endif
 
+struct tcp_key {
+	union {
+		struct tcp_ao_key *ao_key;
+		struct tcp_md5sig_key *md5_key;
+	};
+	enum {
+		TCP_KEY_NONE = 0,
+		TCP_KEY_MD5,
+		TCP_KEY_AO,
+	} type;
+};
+
+static inline void tcp_get_current_key(const struct sock *sk,
+				       struct tcp_key *out)
+{
+#if defined(CONFIG_TCP_AO) || defined(CONFIG_TCP_MD5SIG)
+	const struct tcp_sock *tp = tcp_sk(sk);
+#endif
+#ifdef CONFIG_TCP_AO
+	struct tcp_ao_info *ao;
+
+	ao = rcu_dereference_protected(tp->ao_info, lockdep_sock_is_held(sk));
+	if (ao) {
+		out->ao_key = READ_ONCE(ao->current_key);
+		out->type = TCP_KEY_AO;
+		return;
+	}
+#endif
+#ifdef CONFIG_TCP_MD5SIG
+	if (static_branch_unlikely(&tcp_md5_needed.key) &&
+	    rcu_access_pointer(tp->md5sig_info)) {
+		out->md5_key = tp->af_specific->md5_lookup(sk, sk);
+		if (out->md5_key) {
+			out->type = TCP_KEY_MD5;
+			return;
+		}
+	}
+#endif
+	out->type = TCP_KEY_NONE;
+}
+
+static inline bool tcp_key_is_md5(const struct tcp_key *key)
+{
+#ifdef CONFIG_TCP_MD5SIG
+	if (static_branch_unlikely(&tcp_md5_needed.key) &&
+	    key->type == TCP_KEY_MD5)
+		return true;
+#endif
+	return false;
+}
+
+static inline bool tcp_key_is_ao(const struct tcp_key *key)
+{
+#ifdef CONFIG_TCP_AO
+	if (key->type == TCP_KEY_AO)
+		return true;
+#endif
+	return false;
+}
+
 int tcpv4_offload_init(void);
 
 void tcp_v4_init(void);
diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
index b021a811511b..0b86bc05d8cf 100644
--- a/include/net/tcp_ao.h
+++ b/include/net/tcp_ao.h
@@ -111,6 +111,13 @@ struct tcp6_ao_context {
 
 struct tcp_sigpool;
 
+int tcp_ao_transmit_skb(struct sock *sk, struct sk_buff *skb,
+			struct tcp_ao_key *key, struct tcphdr *th,
+			__u8 *hash_location);
+int tcp_ao_hash_skb(unsigned short int family,
+		    char *ao_hash, struct tcp_ao_key *key,
+		    const struct sock *sk, const struct sk_buff *skb,
+		    const u8 *tkey, int hash_offset, u32 sne);
 int tcp_parse_ao(struct sock *sk, int cmd, unsigned short int family,
 		 sockptr_t optval, int optlen);
 int tcp_ao_calc_traffic_key(struct tcp_ao_key *mkt, u8 *key, void *ctx,
@@ -126,12 +133,21 @@ struct tcp_ao_key *tcp_v4_ao_lookup(const struct sock *sk, struct sock *addr_sk,
 int tcp_v4_ao_calc_key_sk(struct tcp_ao_key *mkt, u8 *key,
 			  const struct sock *sk,
 			  __be32 sisn, __be32 disn, bool send);
+int tcp_v4_ao_hash_skb(char *ao_hash, struct tcp_ao_key *key,
+		       const struct sock *sk, const struct sk_buff *skb,
+		       const u8 *tkey, int hash_offset, u32 sne);
 /* ipv6 specific functions */
+int tcp_v6_ao_hash_pseudoheader(struct tcp_sigpool *hp,
+				const struct in6_addr *daddr,
+				const struct in6_addr *saddr, int nbytes);
 int tcp_v6_ao_calc_key_sk(struct tcp_ao_key *mkt, u8 *key,
 			  const struct sock *sk, __be32 sisn,
 			  __be32 disn, bool send);
 struct tcp_ao_key *tcp_v6_ao_lookup(const struct sock *sk,
 				    struct sock *addr_sk, int sndid, int rcvid);
+int tcp_v6_ao_hash_skb(char *ao_hash, struct tcp_ao_key *key,
+		       const struct sock *sk, const struct sk_buff *skb,
+		       const u8 *tkey, int hash_offset, u32 sne);
 int tcp_v6_parse_ao(struct sock *sk, int cmd, sockptr_t optval, int optlen);
 void tcp_ao_established(struct sock *sk);
 void tcp_ao_finish_connect(struct sock *sk, struct sk_buff *skb);
@@ -139,6 +155,13 @@ void tcp_ao_connect_init(struct sock *sk);
 
 #else /* CONFIG_TCP_AO */
 
+static inline int tcp_ao_transmit_skb(struct sock *sk, struct sk_buff *skb,
+				      struct tcp_ao_key *key, struct tcphdr *th,
+				      __u8 *hash_location)
+{
+	return 0;
+}
+
 static inline struct tcp_ao_key *tcp_ao_do_lookup(const struct sock *sk,
 		const union tcp_ao_addr *addr, int family, int sndid, int rcvid)
 {
diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index e478341fc336..007f29a2531f 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -262,6 +262,171 @@ static int tcp_ao_calc_key_sk(struct tcp_ao_key *mkt, u8 *key,
 		return -EOPNOTSUPP;
 }
 
+static int tcp_v4_ao_hash_pseudoheader(struct tcp_sigpool *hp,
+				       __be32 daddr, __be32 saddr,
+				       int nbytes)
+{
+	struct tcp4_pseudohdr *bp;
+	struct scatterlist sg;
+
+	bp = hp->scratch;
+	bp->saddr = saddr;
+	bp->daddr = daddr;
+	bp->pad = 0;
+	bp->protocol = IPPROTO_TCP;
+	bp->len = cpu_to_be16(nbytes);
+
+	sg_init_one(&sg, bp, sizeof(*bp));
+	ahash_request_set_crypt(hp->req, &sg, NULL, sizeof(*bp));
+	return crypto_ahash_update(hp->req);
+}
+
+static int tcp_ao_hash_pseudoheader(unsigned short int family,
+				    const struct sock *sk,
+				    const struct sk_buff *skb,
+				    struct tcp_sigpool *hp, int nbytes)
+{
+	const struct tcphdr *th = tcp_hdr(skb);
+
+	/* TODO: Can we rely on checksum being zero to mean outbound pkt? */
+	if (!th->check) {
+		if (family == AF_INET)
+			return tcp_v4_ao_hash_pseudoheader(hp, sk->sk_daddr,
+					sk->sk_rcv_saddr, skb->len);
+#if IS_ENABLED(CONFIG_IPV6)
+		else if (family == AF_INET6)
+			return tcp_v6_ao_hash_pseudoheader(hp, &sk->sk_v6_daddr,
+					&sk->sk_v6_rcv_saddr, skb->len);
+#endif
+		else
+			return -EAFNOSUPPORT;
+	}
+
+	if (family == AF_INET) {
+		const struct iphdr *iph = ip_hdr(skb);
+
+		return tcp_v4_ao_hash_pseudoheader(hp, iph->daddr,
+				iph->saddr, skb->len);
+#if IS_ENABLED(CONFIG_IPV6)
+	} else if (family == AF_INET6) {
+		const struct ipv6hdr *iph = ipv6_hdr(skb);
+
+		return tcp_v6_ao_hash_pseudoheader(hp, &iph->daddr,
+				&iph->saddr, skb->len);
+#endif
+	}
+	return -EAFNOSUPPORT;
+}
+
+/* tcp_ao_hash_sne(struct tcp_sigpool *hp)
+ * @hp	- used for hashing
+ * @sne - sne value
+ */
+static int tcp_ao_hash_sne(struct tcp_sigpool *hp, u32 sne)
+{
+	struct scatterlist sg;
+	__be32 *bp;
+
+	bp = (__be32 *)hp->scratch;
+	*bp = htonl(sne);
+
+	sg_init_one(&sg, bp, sizeof(*bp));
+	ahash_request_set_crypt(hp->req, &sg, NULL, sizeof(*bp));
+	return crypto_ahash_update(hp->req);
+}
+
+static int tcp_ao_hash_header(struct tcp_sigpool *hp,
+			      const struct tcphdr *th,
+			      bool exclude_options, u8 *hash,
+			      int hash_offset, int hash_len)
+{
+	int err, len = th->doff << 2;
+	struct scatterlist sg;
+	u8 *hdr = hp->scratch;
+
+	/* We are not allowed to change tcphdr, make a local copy */
+	if (exclude_options) {
+		len = sizeof(*th) + sizeof(struct tcp_ao_hdr) + hash_len;
+		memcpy(hdr, th, sizeof(*th));
+		memcpy(hdr + sizeof(*th),
+		       (u8 *)th + hash_offset - sizeof(struct tcp_ao_hdr),
+		       sizeof(struct tcp_ao_hdr));
+		memset(hdr + sizeof(*th) + sizeof(struct tcp_ao_hdr),
+		       0, hash_len);
+		((struct tcphdr *)hdr)->check = 0;
+	} else {
+		len = th->doff << 2;
+		memcpy(hdr, th, len);
+		/* zero out tcp-ao hash */
+		((struct tcphdr *)hdr)->check = 0;
+		memset(hdr + hash_offset, 0, hash_len);
+	}
+
+	sg_init_one(&sg, hdr, len);
+	ahash_request_set_crypt(hp->req, &sg, NULL, len);
+	err = crypto_ahash_update(hp->req);
+	WARN_ON_ONCE(err != 0);
+	return err;
+}
+
+int tcp_ao_hash_skb(unsigned short int family,
+		    char *ao_hash, struct tcp_ao_key *key,
+		    const struct sock *sk, const struct sk_buff *skb,
+		    const u8 *tkey, int hash_offset, u32 sne)
+{
+	const struct tcphdr *th = tcp_hdr(skb);
+	int tkey_len = tcp_ao_digest_size(key);
+	struct tcp_sigpool hp;
+	void *hash_buf = NULL;
+
+	hash_buf = kmalloc(tkey_len, GFP_ATOMIC);
+	if (!hash_buf)
+		goto clear_hash_noput;
+
+	if (tcp_sigpool_start(key->tcp_sigpool_id, &hp))
+		goto clear_hash_noput;
+
+	if (crypto_ahash_setkey(crypto_ahash_reqtfm(hp.req), tkey, tkey_len))
+		goto clear_hash;
+
+	/* For now use sha1 by default. Depends on alg in tcp_ao_key */
+	if (crypto_ahash_init(hp.req))
+		goto clear_hash;
+
+	if (tcp_ao_hash_sne(&hp, sne))
+		goto clear_hash;
+	if (tcp_ao_hash_pseudoheader(family, sk, skb, &hp, skb->len))
+		goto clear_hash;
+	if (tcp_ao_hash_header(&hp, th, false,
+			       ao_hash, hash_offset, tcp_ao_maclen(key)))
+		goto clear_hash;
+	if (tcp_sigpool_hash_skb_data(&hp, skb, th->doff << 2))
+		goto clear_hash;
+	ahash_request_set_crypt(hp.req, NULL, hash_buf, 0);
+	if (crypto_ahash_final(hp.req))
+		goto clear_hash;
+
+	memcpy(ao_hash, hash_buf, tcp_ao_maclen(key));
+	tcp_sigpool_end(&hp);
+	kfree(hash_buf);
+	return 0;
+
+clear_hash:
+	tcp_sigpool_end(&hp);
+clear_hash_noput:
+	memset(ao_hash, 0, tcp_ao_maclen(key));
+	kfree(hash_buf);
+	return 1;
+}
+
+int tcp_v4_ao_hash_skb(char *ao_hash, struct tcp_ao_key *key,
+		       const struct sock *sk, const struct sk_buff *skb,
+		       const u8 *tkey, int hash_offset, u32 sne)
+{
+	return tcp_ao_hash_skb(AF_INET, ao_hash, key, sk, skb,
+			       tkey, hash_offset, sne);
+}
+
 struct tcp_ao_key *tcp_v4_ao_lookup(const struct sock *sk, struct sock *addr_sk,
 				    int sndid, int rcvid)
 {
@@ -270,6 +435,40 @@ struct tcp_ao_key *tcp_v4_ao_lookup(const struct sock *sk, struct sock *addr_sk,
 	return tcp_ao_do_lookup(sk, addr, AF_INET, sndid, rcvid);
 }
 
+int tcp_ao_transmit_skb(struct sock *sk, struct sk_buff *skb,
+			struct tcp_ao_key *key, struct tcphdr *th,
+			__u8 *hash_location)
+{
+	struct tcp_skb_cb *tcb = TCP_SKB_CB(skb);
+	struct tcp_sock *tp = tcp_sk(sk);
+	struct tcp_ao_info *ao;
+	void *tkey_buf = NULL;
+	u8 *traffic_key;
+
+	ao = rcu_dereference_protected(tcp_sk(sk)->ao_info,
+				       lockdep_sock_is_held(sk));
+	traffic_key = snd_other_key(key);
+	if (unlikely(tcb->tcp_flags & TCPHDR_SYN)) {
+		__be32 disn;
+
+		if (!(tcb->tcp_flags & TCPHDR_ACK)) {
+			disn = 0;
+			tkey_buf = kmalloc(tcp_ao_digest_size(key), GFP_ATOMIC);
+			if (!tkey_buf)
+				return -ENOMEM;
+			traffic_key = tkey_buf;
+		} else {
+			disn = ao->risn;
+		}
+		tp->af_specific->ao_calc_key_sk(key, traffic_key,
+						sk, ao->lisn, disn, true);
+	}
+	tp->af_specific->calc_ao_hash(hash_location, key, sk, skb, traffic_key,
+				      hash_location - (u8 *)th, 0);
+	kfree(tkey_buf);
+	return 0;
+}
+
 static int tcp_ao_cache_traffic_keys(const struct sock *sk,
 				     struct tcp_ao_info *ao,
 				     struct tcp_ao_key *ao_key)
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index e7f5e7ad282e..000d98b58018 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2285,6 +2285,7 @@ static const struct tcp_sock_af_ops tcp_sock_ipv4_specific = {
 #endif
 #ifdef CONFIG_TCP_AO
 	.ao_lookup		= tcp_v4_ao_lookup,
+	.calc_ao_hash		= tcp_v4_ao_hash_skb,
 	.ao_parse		= tcp_v4_parse_ao,
 	.ao_calc_key_sk		= tcp_v4_ao_calc_key_sk,
 #endif
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index a091a3bb60e3..81263182b2ad 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -422,6 +422,7 @@ static inline bool tcp_urg_mode(const struct tcp_sock *tp)
 #define OPTION_FAST_OPEN_COOKIE	BIT(8)
 #define OPTION_SMC		BIT(9)
 #define OPTION_MPTCP		BIT(10)
+#define OPTION_AO		BIT(11)
 
 static void smc_options_write(__be32 *ptr, u16 *options)
 {
@@ -614,19 +615,43 @@ static void bpf_skops_write_hdr_opt(struct sock *sk, struct sk_buff *skb,
  * (but it may well be that other scenarios fail similarly).
  */
 static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
-			      struct tcp_out_options *opts)
+			      struct tcp_out_options *opts,
+			      struct tcp_key *key)
 {
 	__be32 *ptr = (__be32 *)(th + 1);
 	u16 options = opts->options;	/* mungable copy */
 
-	if (unlikely(OPTION_MD5 & options)) {
+	if (tcp_key_is_md5(key)) {
 		*ptr++ = htonl((TCPOPT_NOP << 24) | (TCPOPT_NOP << 16) |
 			       (TCPOPT_MD5SIG << 8) | TCPOLEN_MD5SIG);
 		/* overload cookie hash location */
 		opts->hash_location = (__u8 *)ptr;
 		ptr += 4;
-	}
+	} else if (tcp_key_is_ao(key)) {
+#ifdef CONFIG_TCP_AO
+		struct tcp_ao_key *rnext_key;
+		struct tcp_ao_info *ao_info;
+		u8 maclen;
 
+		ao_info = rcu_dereference_check(tp->ao_info,
+				lockdep_sock_is_held(&tp->inet_conn.icsk_inet.sk));
+		rnext_key = READ_ONCE(ao_info->rnext_key);
+		if (WARN_ON_ONCE(!rnext_key))
+			goto out_ao;
+		maclen = tcp_ao_maclen(key->ao_key);
+		*ptr++ = htonl((TCPOPT_AO << 24) |
+				(tcp_ao_len(key->ao_key) << 16) |
+				(key->ao_key->sndid << 8) |
+				(rnext_key->rcvid));
+		opts->hash_location = (__u8 *)ptr;
+		ptr += maclen / sizeof(*ptr);
+		if (unlikely(maclen % sizeof(*ptr))) {
+			memset(ptr, TCPOPT_NOP, sizeof(*ptr));
+			ptr++;
+		}
+out_ao:
+#endif
+	}
 	if (unlikely(opts->mss)) {
 		*ptr++ = htonl((TCPOPT_MSS << 24) |
 			       (TCPOLEN_MSS << 16) |
@@ -767,23 +792,25 @@ static void mptcp_set_option_cond(const struct request_sock *req,
  */
 static unsigned int tcp_syn_options(struct sock *sk, struct sk_buff *skb,
 				struct tcp_out_options *opts,
-				struct tcp_md5sig_key **md5)
+				struct tcp_key *key)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	unsigned int remaining = MAX_TCP_OPTION_SPACE;
 	struct tcp_fastopen_request *fastopen = tp->fastopen_req;
+	bool timestamps;
 
-	*md5 = NULL;
-#ifdef CONFIG_TCP_MD5SIG
-	if (static_branch_unlikely(&tcp_md5_needed.key) &&
-	    rcu_access_pointer(tp->md5sig_info)) {
-		*md5 = tp->af_specific->md5_lookup(sk, sk);
-		if (*md5) {
-			opts->options |= OPTION_MD5;
-			remaining -= TCPOLEN_MD5SIG_ALIGNED;
+	/* Better than switch (key.type) as it has static branches */
+	if (tcp_key_is_md5(key)) {
+		timestamps = false;
+		opts->options |= OPTION_MD5;
+		remaining -= TCPOLEN_MD5SIG_ALIGNED;
+	} else {
+		timestamps = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_timestamps);
+		if (tcp_key_is_ao(key)) {
+			opts->options |= OPTION_AO;
+			remaining -= tcp_ao_len(key->ao_key);
 		}
 	}
-#endif
 
 	/* We always get an MSS option.  The option bytes which will be seen in
 	 * normal data packets should timestamps be used, must be in the MSS
@@ -797,7 +824,7 @@ static unsigned int tcp_syn_options(struct sock *sk, struct sk_buff *skb,
 	opts->mss = tcp_advertise_mss(sk);
 	remaining -= TCPOLEN_MSS_ALIGNED;
 
-	if (likely(READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_timestamps) && !*md5)) {
+	if (likely(timestamps)) {
 		opts->options |= OPTION_TS;
 		opts->tsval = tcp_skb_timestamp(skb) + tp->tsoffset;
 		opts->tsecr = tp->rx_opt.ts_recent;
@@ -921,7 +948,7 @@ static unsigned int tcp_synack_options(const struct sock *sk,
  */
 static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb,
 					struct tcp_out_options *opts,
-					struct tcp_md5sig_key **md5)
+					struct tcp_key *key)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	unsigned int size = 0;
@@ -929,17 +956,14 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
 
 	opts->options = 0;
 
-	*md5 = NULL;
-#ifdef CONFIG_TCP_MD5SIG
-	if (static_branch_unlikely(&tcp_md5_needed.key) &&
-	    rcu_access_pointer(tp->md5sig_info)) {
-		*md5 = tp->af_specific->md5_lookup(sk, sk);
-		if (*md5) {
-			opts->options |= OPTION_MD5;
-			size += TCPOLEN_MD5SIG_ALIGNED;
-		}
+	/* Better than switch (key.type) as it has static branches */
+	if (tcp_key_is_md5(key)) {
+		opts->options |= OPTION_MD5;
+		size += TCPOLEN_MD5SIG_ALIGNED;
+	} else if (tcp_key_is_ao(key)) {
+		opts->options |= OPTION_AO;
+		size += tcp_ao_len(key->ao_key);
 	}
-#endif
 
 	if (likely(tp->rx_opt.tstamp_ok)) {
 		opts->options |= OPTION_TS;
@@ -1243,7 +1267,7 @@ static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb,
 	struct tcp_out_options opts;
 	unsigned int tcp_options_size, tcp_header_size;
 	struct sk_buff *oskb = NULL;
-	struct tcp_md5sig_key *md5;
+	struct tcp_key key;
 	struct tcphdr *th;
 	u64 prior_wstamp;
 	int err;
@@ -1275,11 +1299,11 @@ static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb,
 	tcb = TCP_SKB_CB(skb);
 	memset(&opts, 0, sizeof(opts));
 
+	tcp_get_current_key(sk, &key);
 	if (unlikely(tcb->tcp_flags & TCPHDR_SYN)) {
-		tcp_options_size = tcp_syn_options(sk, skb, &opts, &md5);
+		tcp_options_size = tcp_syn_options(sk, skb, &opts, &key);
 	} else {
-		tcp_options_size = tcp_established_options(sk, skb, &opts,
-							   &md5);
+		tcp_options_size = tcp_established_options(sk, skb, &opts, &key);
 		/* Force a PSH flag on all (GSO) packets to expedite GRO flush
 		 * at receiver : This slightly improve GRO performance.
 		 * Note that we do not force the PSH flag for non GSO packets,
@@ -1360,16 +1384,25 @@ static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb,
 		th->window	= htons(min(tp->rcv_wnd, 65535U));
 	}
 
-	tcp_options_write(th, tp, &opts);
+	tcp_options_write(th, tp, &opts, &key);
 
+	if (tcp_key_is_md5(&key)) {
 #ifdef CONFIG_TCP_MD5SIG
-	/* Calculate the MD5 hash, as we have all we need now */
-	if (md5) {
+		/* Calculate the MD5 hash, as we have all we need now */
 		sk_gso_disable(sk);
 		tp->af_specific->calc_md5_hash(opts.hash_location,
-					       md5, sk, skb);
-	}
+					       key.md5_key, sk, skb);
 #endif
+	} else if (tcp_key_is_ao(&key)) {
+		int err;
+
+		err = tcp_ao_transmit_skb(sk, skb, key.ao_key, th,
+					  opts.hash_location);
+		if (err) {
+			kfree_skb_reason(skb, SKB_DROP_REASON_NOT_SPECIFIED);
+			return -ENOMEM;
+		}
+	}
 
 	/* BPF prog is the last one writing header option */
 	bpf_skops_write_hdr_opt(sk, skb, NULL, NULL, 0, &opts);
@@ -1820,7 +1853,7 @@ unsigned int tcp_current_mss(struct sock *sk)
 	u32 mss_now;
 	unsigned int header_len;
 	struct tcp_out_options opts;
-	struct tcp_md5sig_key *md5;
+	struct tcp_key key;
 
 	mss_now = tp->mss_cache;
 
@@ -1829,8 +1862,8 @@ unsigned int tcp_current_mss(struct sock *sk)
 		if (mtu != inet_csk(sk)->icsk_pmtu_cookie)
 			mss_now = tcp_sync_mss(sk, mtu);
 	}
-
-	header_len = tcp_established_options(sk, NULL, &opts, &md5) +
+	tcp_get_current_key(sk, &key);
+	header_len = tcp_established_options(sk, NULL, &opts, &key) +
 		     sizeof(struct tcphdr);
 	/* The mss_cache is sized based on tp->tcp_header_len, which assumes
 	 * some common options. If this is an odd packet (because we have SACK
@@ -3616,6 +3649,7 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 	const struct tcp_sock *tp = tcp_sk(sk);
 	struct tcp_md5sig_key *md5 = NULL;
 	struct tcp_out_options opts;
+	struct tcp_key key = {};
 	struct sk_buff *skb;
 	int tcp_header_size;
 	struct tcphdr *th;
@@ -3668,6 +3702,8 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 #ifdef CONFIG_TCP_MD5SIG
 	rcu_read_lock();
 	md5 = tcp_rsk(req)->af_specific->req_md5_lookup(sk, req_to_sk(req));
+	if (md5)
+		key.type = TCP_KEY_MD5;
 #endif
 	skb_set_hash(skb, READ_ONCE(tcp_rsk(req)->txhash), PKT_HASH_TYPE_L4);
 	/* bpf program will be interested in the tcp_flags */
@@ -3694,7 +3730,7 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 
 	/* RFC1323: The window in SYN & SYN/ACK segments is never scaled. */
 	th->window = htons(min(req->rsk_rcv_wnd, 65535U));
-	tcp_options_write(th, NULL, &opts);
+	tcp_options_write(th, NULL, &opts, &key);
 	th->doff = (tcp_header_size >> 2);
 	TCP_INC_STATS(sock_net(sk), TCP_MIB_OUTSEGS);
 
diff --git a/net/ipv6/tcp_ao.c b/net/ipv6/tcp_ao.c
index 9ab594fadbd9..d08735b6f3c5 100644
--- a/net/ipv6/tcp_ao.c
+++ b/net/ipv6/tcp_ao.c
@@ -7,6 +7,7 @@
  *		Francesco Ruggeri <fruggeri@arista.com>
  *		Salam Noureddine <noureddine@arista.com>
  */
+#include <crypto/hash.h>
 #include <linux/tcp.h>
 
 #include <net/tcp.h>
@@ -79,6 +80,33 @@ struct tcp_ao_key *tcp_v6_ao_lookup(const struct sock *sk,
 	return tcp_v6_ao_do_lookup(sk, addr, sndid, rcvid);
 }
 
+int tcp_v6_ao_hash_pseudoheader(struct tcp_sigpool *hp,
+				const struct in6_addr *daddr,
+				const struct in6_addr *saddr, int nbytes)
+{
+	struct tcp6_pseudohdr *bp;
+	struct scatterlist sg;
+
+	bp = hp->scratch;
+	/* 1. TCP pseudo-header (RFC2460) */
+	bp->saddr = *saddr;
+	bp->daddr = *daddr;
+	bp->len = cpu_to_be32(nbytes);
+	bp->protocol = cpu_to_be32(IPPROTO_TCP);
+
+	sg_init_one(&sg, bp, sizeof(*bp));
+	ahash_request_set_crypt(hp->req, &sg, NULL, sizeof(*bp));
+	return crypto_ahash_update(hp->req);
+}
+
+int tcp_v6_ao_hash_skb(char *ao_hash, struct tcp_ao_key *key,
+		       const struct sock *sk, const struct sk_buff *skb,
+		       const u8 *tkey, int hash_offset, u32 sne)
+{
+	return tcp_ao_hash_skb(AF_INET6, ao_hash, key, sk, skb, tkey,
+			hash_offset, sne);
+}
+
 int tcp_v6_parse_ao(struct sock *sk, int cmd,
 		    sockptr_t optval, int optlen)
 {
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 36e9da8980a1..f35a4ec7b419 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1920,6 +1920,7 @@ static const struct tcp_sock_af_ops tcp_sock_ipv6_specific = {
 #endif
 #ifdef CONFIG_TCP_AO
 	.ao_lookup	=	tcp_v6_ao_lookup,
+	.calc_ao_hash	=	tcp_v6_ao_hash_skb,
 	.ao_parse	=	tcp_v6_parse_ao,
 	.ao_calc_key_sk	=	tcp_v6_ao_calc_key_sk,
 #endif
@@ -1953,6 +1954,7 @@ static const struct tcp_sock_af_ops tcp_sock_ipv6_mapped_specific = {
 #endif
 #ifdef CONFIG_TCP_AO
 	.ao_lookup	=	tcp_v6_ao_lookup,
+	.calc_ao_hash	=	tcp_v4_ao_hash_skb,
 	.ao_parse	=	tcp_v6_parse_ao,
 #endif
 };
-- 
2.42.0

