Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5426F79C337
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240361AbjILCnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239726AbjILCnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:43:20 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FBF1A4BC7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 19:08:20 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b962535808so87175251fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 19:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1694484498; x=1695089298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0XeIaI6JMPz6gB9/VfArwDM94E4pYdDqW8l1BPHNLuQ=;
        b=Oe4av6r+3fzYlZDjcO+AmRNZ8YQm93c8R+XSuCKHUG0+hSgJguoCZAEnEmt6pSvOMa
         NJfxtXTZB0P1dbTEhzYvVZathEhnvvZC6aAUXx5pUPMoT+rKxDrXYvIOFaWFsZIqPSOB
         B4sU+ncNGKVaoxMG4+X1pJydldTLgqHXrvi/S1uFzSFPQ6ezs6H2pqnkW1HksbHhgZOG
         EfPMQEW7uAfvcylyHlyhVaSyu3Kohi+nuJwMi/D14jSTvS50Tls+YKPBlfYxy2p45QbJ
         3tU9UVQdZe6QyPeNiYCVMj9/uc3o+Uu+k67IrlDts2Jw6RSgqwa7QGqLWk8aFnOQsrHs
         /Ojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694484498; x=1695089298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0XeIaI6JMPz6gB9/VfArwDM94E4pYdDqW8l1BPHNLuQ=;
        b=vuedcM2Zz6J3fP8KVynbu4hohB4H+cbO0GAyCKuZRI/37qUcWcejnMKXHHtK0i0e40
         ZsS8ln/fQauH0O6Z5isNzZPI9pihPdGkNjINBGXs1R6BccCqO+740IZfYgGzhg+xOXnV
         hd98wQvwMbwNv/GHa6l9RTTvHqHjB0vx4ItKdljV9x7+keEokoSHy/Jv7nv9m8Sv38JJ
         bnmTazzfiAIP1Qt3mDxjlD8sYOVl07z9p0LsqqZU220woPb+VBZBfqfTgTppFfKUPXov
         QJq6BiKF9ceZTvKD46vvmGRRAKSwW3OrwlUQqI5dfqE7n5DJWSrcC+day79a1NAElkVZ
         Qbng==
X-Gm-Message-State: AOJu0YwA4myOiDW92rqENSaIme2Q9AebhTQKHobEI8tSkv/bPpF/V9CH
        een1UrITeFunanTcKbNxIYKo2RaBGvnQkpmaoT8=
X-Google-Smtp-Source: AGHT+IGUZ+PGvG1xvoQqkzl3PnUxMyLnxw7TBXnqz4vG27IY9mGbsSFmxY4ICgvn6pJaUcTCWpxt0Q==
X-Received: by 2002:a05:600c:2946:b0:3f9:c82e:9d87 with SMTP id n6-20020a05600c294600b003f9c82e9d87mr9188152wmd.13.1694466245650;
        Mon, 11 Sep 2023 14:04:05 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id z20-20020a1c4c14000000b00402e942561fsm14261699wmf.38.2023.09.11.14.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 14:04:05 -0700 (PDT)
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
Subject: [PATCH v11 net-next 06/23] net/tcp: Add TCP-AO sign to outgoing packets
Date:   Mon, 11 Sep 2023 22:03:26 +0100
Message-ID: <20230911210346.301750-7-dima@arista.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911210346.301750-1-dima@arista.com>
References: <20230911210346.301750-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 include/net/tcp.h     |   4 +
 include/net/tcp_ao.h  |  13 ++++
 net/ipv4/tcp_ao.c     | 165 ++++++++++++++++++++++++++++++++++++++++++
 net/ipv4/tcp_ipv4.c   |   1 +
 net/ipv4/tcp_output.c | 111 +++++++++++++++++++++++++---
 net/ipv6/tcp_ao.c     |  28 +++++++
 net/ipv6/tcp_ipv6.c   |   2 +
 7 files changed, 315 insertions(+), 9 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 45df08b5ad28..9d6da2e19dd9 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -185,6 +185,7 @@ void tcp_time_wait(struct sock *sk, int state, int timeo);
 #define TCPOPT_SACK             5       /* SACK Block */
 #define TCPOPT_TIMESTAMP	8	/* Better RTT estimations/PAWS */
 #define TCPOPT_MD5SIG		19	/* MD5 Signature (RFC2385) */
+#define TCPOPT_AO		29	/* Authentication Option (RFC5925) */
 #define TCPOPT_MPTCP		30	/* Multipath TCP (RFC6824) */
 #define TCPOPT_FASTOPEN		34	/* Fast open (RFC7413) */
 #define TCPOPT_EXP		254	/* Experimental */
@@ -2158,6 +2159,9 @@ struct tcp_sock_af_ops {
 	int (*ao_calc_key_sk)(struct tcp_ao_key *mkt, u8 *key,
 			      const struct sock *sk,
 			      __be32 sisn, __be32 disn, bool send);
+	int (*calc_ao_hash)(char *location, struct tcp_ao_key *ao,
+			    const struct sock *sk, const struct sk_buff *skb,
+			    const u8 *tkey, int hash_offset, u32 sne);
 #endif
 };
 
diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
index 7e0ce45d9934..cd85d292f78e 100644
--- a/include/net/tcp_ao.h
+++ b/include/net/tcp_ao.h
@@ -111,6 +111,10 @@ struct tcp6_ao_context {
 
 struct tcp_sigpool;
 
+int tcp_ao_hash_skb(unsigned short int family,
+		    char *ao_hash, struct tcp_ao_key *key,
+		    const struct sock *sk, const struct sk_buff *skb,
+		    const u8 *tkey, int hash_offset, u32 sne);
 int tcp_parse_ao(struct sock *sk, int cmd, unsigned short int family,
 		 sockptr_t optval, int optlen);
 int tcp_ao_calc_traffic_key(struct tcp_ao_key *mkt, u8 *key, void *ctx,
@@ -126,12 +130,21 @@ struct tcp_ao_key *tcp_v4_ao_lookup(const struct sock *sk, struct sock *addr_sk,
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
 void tcp_ao_finish_connect(struct sock *sk, struct sk_buff *skb);
 void tcp_ao_connect_init(struct sock *sk);
diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index fc7a6aa1936e..d10daee79fe6 100644
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
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index d63970b3d375..ed26676735a5 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2284,6 +2284,7 @@ static const struct tcp_sock_af_ops tcp_sock_ipv4_specific = {
 #endif
 #ifdef CONFIG_TCP_AO
 	.ao_lookup		= tcp_v4_ao_lookup,
+	.calc_ao_hash		= tcp_v4_ao_hash_skb,
 	.ao_parse		= tcp_v4_parse_ao,
 	.ao_calc_key_sk		= tcp_v4_ao_calc_key_sk,
 #endif
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 705eeb623269..01424b82845a 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -423,6 +423,7 @@ static inline bool tcp_urg_mode(const struct tcp_sock *tp)
 #define OPTION_FAST_OPEN_COOKIE	BIT(8)
 #define OPTION_SMC		BIT(9)
 #define OPTION_MPTCP		BIT(10)
+#define OPTION_AO		BIT(11)
 
 static void smc_options_write(__be32 *ptr, u16 *options)
 {
@@ -615,7 +616,8 @@ static void bpf_skops_write_hdr_opt(struct sock *sk, struct sk_buff *skb,
  * (but it may well be that other scenarios fail similarly).
  */
 static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
-			      struct tcp_out_options *opts)
+			      struct tcp_out_options *opts,
+			      struct tcp_ao_key *ao_key)
 {
 	__be32 *ptr = (__be32 *)(th + 1);
 	u16 options = opts->options;	/* mungable copy */
@@ -627,7 +629,33 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
 		opts->hash_location = (__u8 *)ptr;
 		ptr += 4;
 	}
+#ifdef CONFIG_TCP_AO
+	if (unlikely(OPTION_AO & options)) {
+		struct tcp_ao_key *rnext_key;
+		struct tcp_ao_info *ao_info;
+		u8 maclen;
 
+		if (WARN_ON_ONCE(!ao_key))
+			goto out_ao;
+		ao_info = rcu_dereference_check(tp->ao_info,
+				lockdep_sock_is_held(&tp->inet_conn.icsk_inet.sk));
+		rnext_key = READ_ONCE(ao_info->rnext_key);
+		if (WARN_ON_ONCE(!rnext_key))
+			goto out_ao;
+		maclen = tcp_ao_maclen(ao_key);
+		*ptr++ = htonl((TCPOPT_AO << 24) |
+				(tcp_ao_len(ao_key) << 16) |
+				(ao_key->sndid << 8) |
+				(rnext_key->rcvid));
+		opts->hash_location = (__u8 *)ptr;
+		ptr += maclen / sizeof(*ptr);
+		if (unlikely(maclen % sizeof(*ptr))) {
+			memset(ptr, TCPOPT_NOP, sizeof(*ptr));
+			ptr++;
+		}
+	}
+out_ao:
+#endif
 	if (unlikely(opts->mss)) {
 		*ptr++ = htonl((TCPOPT_MSS << 24) |
 			       (TCPOLEN_MSS << 16) |
@@ -768,7 +796,8 @@ static void mptcp_set_option_cond(const struct request_sock *req,
  */
 static unsigned int tcp_syn_options(struct sock *sk, struct sk_buff *skb,
 				struct tcp_out_options *opts,
-				struct tcp_md5sig_key **md5)
+				struct tcp_md5sig_key **md5,
+				struct tcp_ao_key *ao_key)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	unsigned int remaining = MAX_TCP_OPTION_SPACE;
@@ -785,6 +814,12 @@ static unsigned int tcp_syn_options(struct sock *sk, struct sk_buff *skb,
 		}
 	}
 #endif
+#ifdef CONFIG_TCP_AO
+	if (ao_key) {
+		opts->options |= OPTION_AO;
+		remaining -= tcp_ao_len(ao_key);
+	}
+#endif
 
 	/* We always get an MSS option.  The option bytes which will be seen in
 	 * normal data packets should timestamps be used, must be in the MSS
@@ -922,7 +957,8 @@ static unsigned int tcp_synack_options(const struct sock *sk,
  */
 static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb,
 					struct tcp_out_options *opts,
-					struct tcp_md5sig_key **md5)
+					struct tcp_md5sig_key **md5,
+					struct tcp_ao_key *ao_key)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	unsigned int size = 0;
@@ -941,6 +977,12 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
 		}
 	}
 #endif
+#ifdef CONFIG_TCP_AO
+	if (ao_key) {
+		opts->options |= OPTION_AO;
+		size += tcp_ao_len(ao_key);
+	}
+#endif
 
 	if (likely(tp->rx_opt.tstamp_ok)) {
 		opts->options |= OPTION_TS;
@@ -1245,6 +1287,7 @@ static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb,
 			      int clone_it, gfp_t gfp_mask, u32 rcv_nxt)
 {
 	const struct inet_connection_sock *icsk = inet_csk(sk);
+	struct tcp_ao_key *ao_key = NULL;
 	struct inet_sock *inet;
 	struct tcp_sock *tp;
 	struct tcp_skb_cb *tcb;
@@ -1252,6 +1295,9 @@ static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb,
 	unsigned int tcp_options_size, tcp_header_size;
 	struct sk_buff *oskb = NULL;
 	struct tcp_md5sig_key *md5;
+#ifdef CONFIG_TCP_AO
+	struct tcp_ao_info *ao;
+#endif
 	struct tcphdr *th;
 	u64 prior_wstamp;
 	int err;
@@ -1283,11 +1329,17 @@ static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb,
 	tcb = TCP_SKB_CB(skb);
 	memset(&opts, 0, sizeof(opts));
 
+#ifdef CONFIG_TCP_AO
+	ao = rcu_dereference_protected(tcp_sk(sk)->ao_info,
+				       lockdep_sock_is_held(sk));
+	if (ao)
+		ao_key = READ_ONCE(ao->current_key);
+#endif
 	if (unlikely(tcb->tcp_flags & TCPHDR_SYN)) {
-		tcp_options_size = tcp_syn_options(sk, skb, &opts, &md5);
+		tcp_options_size = tcp_syn_options(sk, skb, &opts, &md5, ao_key);
 	} else {
 		tcp_options_size = tcp_established_options(sk, skb, &opts,
-							   &md5);
+							   &md5, ao_key);
 		/* Force a PSH flag on all (GSO) packets to expedite GRO flush
 		 * at receiver : This slightly improve GRO performance.
 		 * Note that we do not force the PSH flag for non GSO packets,
@@ -1368,7 +1420,7 @@ static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb,
 		th->window	= htons(min(tp->rcv_wnd, 65535U));
 	}
 
-	tcp_options_write(th, tp, &opts);
+	tcp_options_write(th, tp, &opts, ao_key);
 
 #ifdef CONFIG_TCP_MD5SIG
 	/* Calculate the MD5 hash, as we have all we need now */
@@ -1378,6 +1430,34 @@ static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb,
 					       md5, sk, skb);
 	}
 #endif
+#ifdef CONFIG_TCP_AO
+	if (ao) {
+		u8 *traffic_key;
+		void *tkey_buf = NULL;
+		__be32 disn;
+
+		sk_gso_disable(sk);
+		if (unlikely(tcb->tcp_flags & TCPHDR_SYN)) {
+			if (tcb->tcp_flags & TCPHDR_ACK)
+				disn = ao->risn;
+			else
+				disn = 0;
+
+			tkey_buf = kmalloc(tcp_ao_digest_size(ao_key), GFP_ATOMIC);
+			if (!tkey_buf)
+				return -ENOMEM;
+			traffic_key = tkey_buf;
+			tp->af_specific->ao_calc_key_sk(ao_key, traffic_key,
+							sk, ao->lisn, disn, true);
+		} else {
+			traffic_key = snd_other_key(ao_key);
+		}
+		tp->af_specific->calc_ao_hash(opts.hash_location, ao_key, sk, skb,
+					      traffic_key,
+					      opts.hash_location - (u8 *)th, 0);
+		kfree(tkey_buf);
+	}
+#endif
 
 	/* BPF prog is the last one writing header option */
 	bpf_skops_write_hdr_opt(sk, skb, NULL, NULL, 0, &opts);
@@ -1825,10 +1905,14 @@ unsigned int tcp_current_mss(struct sock *sk)
 {
 	const struct tcp_sock *tp = tcp_sk(sk);
 	const struct dst_entry *dst = __sk_dst_get(sk);
+	struct tcp_ao_key *ao_key = NULL;
 	u32 mss_now;
 	unsigned int header_len;
 	struct tcp_out_options opts;
 	struct tcp_md5sig_key *md5;
+#ifdef CONFIG_TCP_AO
+	struct tcp_ao_info *ao_info;
+#endif
 
 	mss_now = tp->mss_cache;
 
@@ -1837,8 +1921,17 @@ unsigned int tcp_current_mss(struct sock *sk)
 		if (mtu != inet_csk(sk)->icsk_pmtu_cookie)
 			mss_now = tcp_sync_mss(sk, mtu);
 	}
-
-	header_len = tcp_established_options(sk, NULL, &opts, &md5) +
+#ifdef CONFIG_TCP_AO
+	ao_info = rcu_dereference_check(tp->ao_info, lockdep_sock_is_held(sk));
+	if (ao_info)
+		/* TODO: verify if we can access current_key or we need to pass
+		 * it from every caller of tcp_current_mss instead. The reason
+		 * is that the current_key pointer can change asynchronously
+		 * from the rx path.
+		 */
+		ao_key = READ_ONCE(ao_info->current_key);
+#endif
+	header_len = tcp_established_options(sk, NULL, &opts, &md5, ao_key) +
 		     sizeof(struct tcphdr);
 	/* The mss_cache is sized based on tp->tcp_header_len, which assumes
 	 * some common options. If this is an odd packet (because we have SACK
@@ -3700,7 +3793,7 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 
 	/* RFC1323: The window in SYN & SYN/ACK segments is never scaled. */
 	th->window = htons(min(req->rsk_rcv_wnd, 65535U));
-	tcp_options_write(th, NULL, &opts);
+	tcp_options_write(th, NULL, &opts, NULL);
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
index 70a3f12a94a5..146b586839f5 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1917,6 +1917,7 @@ static const struct tcp_sock_af_ops tcp_sock_ipv6_specific = {
 #endif
 #ifdef CONFIG_TCP_AO
 	.ao_lookup	=	tcp_v6_ao_lookup,
+	.calc_ao_hash	=	tcp_v6_ao_hash_skb,
 	.ao_parse	=	tcp_v6_parse_ao,
 	.ao_calc_key_sk	=	tcp_v6_ao_calc_key_sk,
 #endif
@@ -1950,6 +1951,7 @@ static const struct tcp_sock_af_ops tcp_sock_ipv6_mapped_specific = {
 #endif
 #ifdef CONFIG_TCP_AO
 	.ao_lookup	=	tcp_v6_ao_lookup,
+	.calc_ao_hash	=	tcp_v4_ao_hash_skb,
 	.ao_parse	=	tcp_v6_parse_ao,
 #endif
 };
-- 
2.41.0

