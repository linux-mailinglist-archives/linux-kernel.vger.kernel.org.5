Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1146D7CE998
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 23:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbjJRU67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 16:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344718AbjJRU6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 16:58:53 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96564121
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 13:58:32 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4083ac51d8aso10828775e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 13:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1697662711; x=1698267511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yVhtwvY8ruidozKMxosPJMVTvj+6Y7TCnuvFuZyLEKQ=;
        b=YOb3n7/hf1HfNpfZUT2FpS68trwfq9lZ4If7+tMdXlRehfy73nqZ2nwqm24JdPy0G5
         1lD2nFchCkpM0qUNUXq7R30yjj1kUUJ7miALQPLxFe12M8cIYboZV+dBf5gYQza//RSw
         Ul78492NKD0/jNViyGDVu5pJR/0Oes6E62NZGrmVHYa5MjzDTmp5DlkqhKwb8ob4H3fe
         D2CmHJXK6m7LPTX50QwUzT5IME04tB5C6arQirCzvMVmasoJBO19yw7+INEea0i5LXp2
         +IPy1AjNmJXqqFqSatdQbHQXZ4dn6SdEsmB3W8LL1TvoVOzjZ4a9Oxk3rDyYaXJLRj7x
         ihIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697662711; x=1698267511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yVhtwvY8ruidozKMxosPJMVTvj+6Y7TCnuvFuZyLEKQ=;
        b=SyGiR3HbirhBlux1+J6cX3cn8gKCu6REk03arqfzrl+DRZqh3ndPbp6FBlgU9HNarb
         DGJiX5UKEsuBlH6x/BZ2JFCixO9MEh4dbRza5kIKxGKduVlqdrJxzezBS5Bj4nl1LWZV
         yzXrLR66NxOmD8gha8p5VEdBTjCD1WnuYkZDTMBEM8GCVkhuuPgALXpqCKnIe/XHdQ+W
         q1lGigGqhDIHriIt4EhgosgiGkPnmr/PWPy5oOjQ0QPSnLIr8+MgyEWw+3XcgIiN4ceb
         d/vZE5A7qgjBbdFPSabcimcWyN3Q/JMpipEd8eRfl3aGEkpJn3YTrB7Za1+OcvouANXy
         IxHw==
X-Gm-Message-State: AOJu0Yz9RkJh/ypF5S4JpDHgH0b7wFvvKxWU9+BkGa3P/QcuPHyO1zJq
        HvdmV9cUkn68z7fzMnpVZj2R90HQcAmagPcrUbY=
X-Google-Smtp-Source: AGHT+IG8fRs4BWDrxjOs3GBve6y60cAW1UtadiJ2hgs9jsgJB6IK365qqzncz0Z+m9nsPJ/du41BLA==
X-Received: by 2002:a05:600c:3788:b0:402:98cd:a3e9 with SMTP id o8-20020a05600c378800b0040298cda3e9mr325677wmr.32.1697662710998;
        Wed, 18 Oct 2023 13:58:30 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x19-20020a05600c421300b003fc16ee2864sm2569006wmh.48.2023.10.18.13.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 13:58:30 -0700 (PDT)
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
Subject: [PATCH v15 net-next 08/23] net/tcp: Add AO sign to RST packets
Date:   Wed, 18 Oct 2023 21:57:22 +0100
Message-ID: <20231018205806.322831-9-dima@arista.com>
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

Wire up sending resets to TCP-AO hashing.

Co-developed-by: Francesco Ruggeri <fruggeri@arista.com>
Signed-off-by: Francesco Ruggeri <fruggeri@arista.com>
Co-developed-by: Salam Noureddine <noureddine@arista.com>
Signed-off-by: Salam Noureddine <noureddine@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
Acked-by: David Ahern <dsahern@kernel.org>
---
 include/net/tcp.h    |   7 ++-
 include/net/tcp_ao.h |  12 +++++
 net/ipv4/tcp_ao.c    | 103 ++++++++++++++++++++++++++++++++++++++++++-
 net/ipv4/tcp_ipv4.c  |  69 +++++++++++++++++++++++------
 net/ipv6/tcp_ipv6.c  |  98 ++++++++++++++++++++++++++++------------
 5 files changed, 246 insertions(+), 43 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 40618ba459ab..3acfd690158d 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2226,7 +2226,12 @@ static inline __u32 cookie_init_sequence(const struct tcp_request_sock_ops *ops,
 
 struct tcp_key {
 	union {
-		struct tcp_ao_key *ao_key;
+		struct {
+			struct tcp_ao_key *ao_key;
+			char *traffic_key;
+			u32 sne;
+			u8 rcv_next;
+		};
 		struct tcp_md5sig_key *md5_key;
 	};
 	enum {
diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
index fdd2f5091b98..629ab0365b83 100644
--- a/include/net/tcp_ao.h
+++ b/include/net/tcp_ao.h
@@ -120,12 +120,24 @@ int tcp_ao_hash_skb(unsigned short int family,
 		    const u8 *tkey, int hash_offset, u32 sne);
 int tcp_parse_ao(struct sock *sk, int cmd, unsigned short int family,
 		 sockptr_t optval, int optlen);
+struct tcp_ao_key *tcp_ao_established_key(struct tcp_ao_info *ao,
+					  int sndid, int rcvid);
 int tcp_ao_calc_traffic_key(struct tcp_ao_key *mkt, u8 *key, void *ctx,
 			    unsigned int len, struct tcp_sigpool *hp);
 void tcp_ao_destroy_sock(struct sock *sk);
 struct tcp_ao_key *tcp_ao_do_lookup(const struct sock *sk,
 				    const union tcp_ao_addr *addr,
 				    int family, int sndid, int rcvid);
+int tcp_ao_hash_hdr(unsigned short family, char *ao_hash,
+		    struct tcp_ao_key *key, const u8 *tkey,
+		    const union tcp_ao_addr *daddr,
+		    const union tcp_ao_addr *saddr,
+		    const struct tcphdr *th, u32 sne);
+int tcp_ao_prepare_reset(const struct sock *sk, struct sk_buff *skb,
+			 const struct tcp_ao_hdr *aoh, int l3index,
+			 struct tcp_ao_key **key, char **traffic_key,
+			 bool *allocated_traffic_key, u8 *keyid, u32 *sne);
+
 /* ipv4 specific functions */
 int tcp_v4_parse_ao(struct sock *sk, int cmd, sockptr_t optval, int optlen);
 struct tcp_ao_key *tcp_v4_ao_lookup(const struct sock *sk, struct sock *addr_sk,
diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index 007f29a2531f..78ebb3e43575 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -48,8 +48,8 @@ int tcp_ao_calc_traffic_key(struct tcp_ao_key *mkt, u8 *key, void *ctx,
  * it's known that the keys in ao_info are matching peer's
  * family/address/VRF/etc.
  */
-static struct tcp_ao_key *tcp_ao_established_key(struct tcp_ao_info *ao,
-						 int sndid, int rcvid)
+struct tcp_ao_key *tcp_ao_established_key(struct tcp_ao_info *ao,
+					  int sndid, int rcvid)
 {
 	struct tcp_ao_key *key;
 
@@ -369,6 +369,66 @@ static int tcp_ao_hash_header(struct tcp_sigpool *hp,
 	return err;
 }
 
+int tcp_ao_hash_hdr(unsigned short int family, char *ao_hash,
+		    struct tcp_ao_key *key, const u8 *tkey,
+		    const union tcp_ao_addr *daddr,
+		    const union tcp_ao_addr *saddr,
+		    const struct tcphdr *th, u32 sne)
+{
+	int tkey_len = tcp_ao_digest_size(key);
+	int hash_offset = ao_hash - (char *)th;
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
+	if (crypto_ahash_init(hp.req))
+		goto clear_hash;
+
+	if (tcp_ao_hash_sne(&hp, sne))
+		goto clear_hash;
+	if (family == AF_INET) {
+		if (tcp_v4_ao_hash_pseudoheader(&hp, daddr->a4.s_addr,
+						saddr->a4.s_addr, th->doff * 4))
+			goto clear_hash;
+#if IS_ENABLED(CONFIG_IPV6)
+	} else if (family == AF_INET6) {
+		if (tcp_v6_ao_hash_pseudoheader(&hp, &daddr->a6,
+						&saddr->a6, th->doff * 4))
+			goto clear_hash;
+#endif
+	} else {
+		WARN_ON_ONCE(1);
+		goto clear_hash;
+	}
+	if (tcp_ao_hash_header(&hp, th, false,
+			       ao_hash, hash_offset, tcp_ao_maclen(key)))
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
 int tcp_ao_hash_skb(unsigned short int family,
 		    char *ao_hash, struct tcp_ao_key *key,
 		    const struct sock *sk, const struct sk_buff *skb,
@@ -435,6 +495,45 @@ struct tcp_ao_key *tcp_v4_ao_lookup(const struct sock *sk, struct sock *addr_sk,
 	return tcp_ao_do_lookup(sk, addr, AF_INET, sndid, rcvid);
 }
 
+int tcp_ao_prepare_reset(const struct sock *sk, struct sk_buff *skb,
+			 const struct tcp_ao_hdr *aoh, int l3index,
+			 struct tcp_ao_key **key, char **traffic_key,
+			 bool *allocated_traffic_key, u8 *keyid, u32 *sne)
+{
+	struct tcp_ao_info *ao_info;
+
+	*allocated_traffic_key = false;
+	/* If there's no socket - than initial sisn/disn are unknown.
+	 * Drop the segment. RFC5925 (7.7) advises to require graceful
+	 * restart [RFC4724]. Alternatively, the RFC5925 advises to
+	 * save/restore traffic keys before/after reboot.
+	 * Linux TCP-AO support provides TCP_AO_ADD_KEY and TCP_AO_REPAIR
+	 * options to restore a socket post-reboot.
+	 */
+	if (!sk)
+		return -ENOTCONN;
+
+	if ((1 << sk->sk_state) &
+	    (TCPF_LISTEN | TCPF_NEW_SYN_RECV | TCPF_TIME_WAIT)) {
+		return -1;
+	} else {
+		struct tcp_ao_key *rnext_key;
+
+		ao_info = rcu_dereference(tcp_sk(sk)->ao_info);
+		if (!ao_info)
+			return -ENOENT;
+
+		*key = tcp_ao_established_key(ao_info, aoh->rnext_keyid, -1);
+		if (!*key)
+			return -ENOENT;
+		*traffic_key = snd_other_key(*key);
+		rnext_key = READ_ONCE(ao_info->rnext_key);
+		*keyid = rnext_key->rcvid;
+		*sne = 0;
+	}
+	return 0;
+}
+
 int tcp_ao_transmit_skb(struct sock *sk, struct sk_buff *skb,
 			struct tcp_ao_key *key, struct tcphdr *th,
 			__u8 *hash_location)
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 350d9b6ffa70..b1a603384ecf 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -656,6 +656,52 @@ void tcp_v4_send_check(struct sock *sk, struct sk_buff *skb)
 }
 EXPORT_SYMBOL(tcp_v4_send_check);
 
+#define REPLY_OPTIONS_LEN      (MAX_TCP_OPTION_SPACE / sizeof(__be32))
+
+static bool tcp_v4_ao_sign_reset(const struct sock *sk, struct sk_buff *skb,
+				 const struct tcp_ao_hdr *aoh,
+				 struct ip_reply_arg *arg, struct tcphdr *reply,
+				 __be32 reply_options[REPLY_OPTIONS_LEN])
+{
+#ifdef CONFIG_TCP_AO
+	int sdif = tcp_v4_sdif(skb);
+	int dif = inet_iif(skb);
+	int l3index = sdif ? dif : 0;
+	bool allocated_traffic_key;
+	struct tcp_ao_key *key;
+	char *traffic_key;
+	bool drop = true;
+	u32 ao_sne = 0;
+	u8 keyid;
+
+	rcu_read_lock();
+	if (tcp_ao_prepare_reset(sk, skb, aoh, l3index,
+				 &key, &traffic_key, &allocated_traffic_key,
+				 &keyid, &ao_sne))
+		goto out;
+
+	reply_options[0] = htonl((TCPOPT_AO << 24) | (tcp_ao_len(key) << 16) |
+				 (aoh->rnext_keyid << 8) | keyid);
+	arg->iov[0].iov_len += round_up(tcp_ao_len(key), 4);
+	reply->doff = arg->iov[0].iov_len / 4;
+
+	if (tcp_ao_hash_hdr(AF_INET, (char *)&reply_options[1],
+			    key, traffic_key,
+			    (union tcp_ao_addr *)&ip_hdr(skb)->saddr,
+			    (union tcp_ao_addr *)&ip_hdr(skb)->daddr,
+			    reply, ao_sne))
+		goto out;
+	drop = false;
+out:
+	rcu_read_unlock();
+	if (allocated_traffic_key)
+		kfree(traffic_key);
+	return drop;
+#else
+	return true;
+#endif
+}
+
 /*
  *	This routine will send an RST to the other tcp.
  *
@@ -669,28 +715,21 @@ EXPORT_SYMBOL(tcp_v4_send_check);
  *	Exception: precedence violation. We do not implement it in any case.
  */
 
-#ifdef CONFIG_TCP_AO
-#define OPTION_BYTES MAX_TCP_OPTION_SPACE
-#elif defined(CONFIG_TCP_MD5SIG)
-#define OPTION_BYTES TCPOLEN_MD5SIG_ALIGNED
-#else
-#define OPTION_BYTES sizeof(__be32)
-#endif
-
 static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb)
 {
 	const struct tcphdr *th = tcp_hdr(skb);
 	struct {
 		struct tcphdr th;
-		__be32 opt[OPTION_BYTES / sizeof(__be32)];
+		__be32 opt[REPLY_OPTIONS_LEN];
 	} rep;
+	const __u8 *md5_hash_location = NULL;
+	const struct tcp_ao_hdr *aoh;
 	struct ip_reply_arg arg;
 #ifdef CONFIG_TCP_MD5SIG
-	const __u8 *md5_hash_location = NULL;
 	struct tcp_md5sig_key *key = NULL;
 	unsigned char newhash[16];
-	int genhash;
 	struct sock *sk1 = NULL;
+	int genhash;
 #endif
 	u64 transmit_time = 0;
 	struct sock *ctl_sk;
@@ -727,11 +766,15 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb)
 	arg.iov[0].iov_len  = sizeof(rep.th);
 
 	net = sk ? sock_net(sk) : dev_net(skb_dst(skb)->dev);
-#ifdef CONFIG_TCP_MD5SIG
+
 	/* Invalid TCP option size or twice included auth */
-	if (tcp_parse_auth_options(tcp_hdr(skb), &md5_hash_location, NULL))
+	if (tcp_parse_auth_options(tcp_hdr(skb), &md5_hash_location, &aoh))
 		return;
 
+	if (aoh && tcp_v4_ao_sign_reset(sk, skb, aoh, &arg, &rep.th, rep.opt))
+		return;
+
+#ifdef CONFIG_TCP_MD5SIG
 	rcu_read_lock();
 	if (sk && sk_fullsock(sk)) {
 		const union tcp_md5_addr *addr;
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 6a70bfb682b5..f65508066bef 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -853,8 +853,8 @@ const struct tcp_request_sock_ops tcp_request_sock_ipv6_ops = {
 
 static void tcp_v6_send_response(const struct sock *sk, struct sk_buff *skb, u32 seq,
 				 u32 ack, u32 win, u32 tsval, u32 tsecr,
-				 int oif, struct tcp_md5sig_key *key, int rst,
-				 u8 tclass, __be32 label, u32 priority, u32 txhash)
+				 int oif, int rst, u8 tclass, __be32 label,
+				 u32 priority, u32 txhash, struct tcp_key *key)
 {
 	const struct tcphdr *th = tcp_hdr(skb);
 	struct tcphdr *t1;
@@ -869,13 +869,13 @@ static void tcp_v6_send_response(const struct sock *sk, struct sk_buff *skb, u32
 
 	if (tsecr)
 		tot_len += TCPOLEN_TSTAMP_ALIGNED;
-#ifdef CONFIG_TCP_MD5SIG
-	if (key)
+	if (tcp_key_is_md5(key))
 		tot_len += TCPOLEN_MD5SIG_ALIGNED;
-#endif
+	if (tcp_key_is_ao(key))
+		tot_len += tcp_ao_len(key->ao_key);
 
 #ifdef CONFIG_MPTCP
-	if (rst && !key) {
+	if (rst && !tcp_key_is_md5(key)) {
 		mrst = mptcp_reset_option(skb);
 
 		if (mrst)
@@ -916,14 +916,28 @@ static void tcp_v6_send_response(const struct sock *sk, struct sk_buff *skb, u32
 		*topt++ = mrst;
 
 #ifdef CONFIG_TCP_MD5SIG
-	if (key) {
+	if (tcp_key_is_md5(key)) {
 		*topt++ = htonl((TCPOPT_NOP << 24) | (TCPOPT_NOP << 16) |
 				(TCPOPT_MD5SIG << 8) | TCPOLEN_MD5SIG);
-		tcp_v6_md5_hash_hdr((__u8 *)topt, key,
+		tcp_v6_md5_hash_hdr((__u8 *)topt, key->md5_key,
 				    &ipv6_hdr(skb)->saddr,
 				    &ipv6_hdr(skb)->daddr, t1);
 	}
 #endif
+#ifdef CONFIG_TCP_AO
+	if (tcp_key_is_ao(key)) {
+		*topt++ = htonl((TCPOPT_AO << 24) |
+				(tcp_ao_len(key->ao_key) << 16) |
+				(key->ao_key->sndid << 8) |
+				(key->rcv_next));
+
+		tcp_ao_hash_hdr(AF_INET6, (char *)topt, key->ao_key,
+				key->traffic_key,
+				(union tcp_ao_addr *)&ipv6_hdr(skb)->saddr,
+				(union tcp_ao_addr *)&ipv6_hdr(skb)->daddr,
+				t1, key->sne);
+	}
+#endif
 
 	memset(&fl6, 0, sizeof(fl6));
 	fl6.daddr = ipv6_hdr(skb)->saddr;
@@ -986,19 +1000,23 @@ static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb)
 {
 	const struct tcphdr *th = tcp_hdr(skb);
 	struct ipv6hdr *ipv6h = ipv6_hdr(skb);
-	u32 seq = 0, ack_seq = 0;
-	struct tcp_md5sig_key *key = NULL;
-#ifdef CONFIG_TCP_MD5SIG
 	const __u8 *md5_hash_location = NULL;
-	unsigned char newhash[16];
-	int genhash;
-	struct sock *sk1 = NULL;
+#if defined(CONFIG_TCP_MD5SIG) || defined(CONFIG_TCP_AO)
+	bool allocated_traffic_key = false;
 #endif
+	const struct tcp_ao_hdr *aoh;
+	struct tcp_key key = {};
+	u32 seq = 0, ack_seq = 0;
 	__be32 label = 0;
 	u32 priority = 0;
 	struct net *net;
 	u32 txhash = 0;
 	int oif = 0;
+#ifdef CONFIG_TCP_MD5SIG
+	unsigned char newhash[16];
+	int genhash;
+	struct sock *sk1 = NULL;
+#endif
 
 	if (th->rst)
 		return;
@@ -1010,12 +1028,13 @@ static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb)
 		return;
 
 	net = sk ? sock_net(sk) : dev_net(skb_dst(skb)->dev);
-#ifdef CONFIG_TCP_MD5SIG
 	/* Invalid TCP option size or twice included auth */
-	if (tcp_parse_auth_options(th, &md5_hash_location, NULL))
+	if (tcp_parse_auth_options(th, &md5_hash_location, &aoh))
 		return;
-
+#if defined(CONFIG_TCP_MD5SIG) || defined(CONFIG_TCP_AO)
 	rcu_read_lock();
+#endif
+#ifdef CONFIG_TCP_MD5SIG
 	if (sk && sk_fullsock(sk)) {
 		int l3index;
 
@@ -1023,7 +1042,9 @@ static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb)
 		 * in an L3 domain and inet_iif is set to it.
 		 */
 		l3index = tcp_v6_sdif(skb) ? tcp_v6_iif_l3_slave(skb) : 0;
-		key = tcp_v6_md5_do_lookup(sk, &ipv6h->saddr, l3index);
+		key.md5_key = tcp_v6_md5_do_lookup(sk, &ipv6h->saddr, l3index);
+		if (key.md5_key)
+			key.type = TCP_KEY_MD5;
 	} else if (md5_hash_location) {
 		int dif = tcp_v6_iif_l3_slave(skb);
 		int sdif = tcp_v6_sdif(skb);
@@ -1048,11 +1069,12 @@ static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb)
 		 */
 		l3index = tcp_v6_sdif(skb) ? dif : 0;
 
-		key = tcp_v6_md5_do_lookup(sk1, &ipv6h->saddr, l3index);
-		if (!key)
+		key.md5_key = tcp_v6_md5_do_lookup(sk1, &ipv6h->saddr, l3index);
+		if (!key.md5_key)
 			goto out;
+		key.type = TCP_KEY_MD5;
 
-		genhash = tcp_v6_md5_hash_skb(newhash, key, NULL, skb);
+		genhash = tcp_v6_md5_hash_skb(newhash, key.md5_key, NULL, skb);
 		if (genhash || memcmp(md5_hash_location, newhash, 16) != 0)
 			goto out;
 	}
@@ -1064,6 +1086,20 @@ static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb)
 		ack_seq = ntohl(th->seq) + th->syn + th->fin + skb->len -
 			  (th->doff << 2);
 
+#ifdef CONFIG_TCP_AO
+	if (aoh) {
+		int l3index;
+
+		l3index = tcp_v6_sdif(skb) ? tcp_v6_iif_l3_slave(skb) : 0;
+		if (tcp_ao_prepare_reset(sk, skb, aoh, l3index,
+					 &key.ao_key, &key.traffic_key,
+					 &allocated_traffic_key,
+					 &key.rcv_next, &key.sne))
+			goto out;
+		key.type = TCP_KEY_AO;
+	}
+#endif
+
 	if (sk) {
 		oif = sk->sk_bound_dev_if;
 		if (sk_fullsock(sk)) {
@@ -1083,22 +1119,30 @@ static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb)
 			label = ip6_flowlabel(ipv6h);
 	}
 
-	tcp_v6_send_response(sk, skb, seq, ack_seq, 0, 0, 0, oif, key, 1,
-			     ipv6_get_dsfield(ipv6h), label, priority, txhash);
+	tcp_v6_send_response(sk, skb, seq, ack_seq, 0, 0, 0, oif, 1,
+			     ipv6_get_dsfield(ipv6h), label, priority, txhash,
+			     &key);
 
-#ifdef CONFIG_TCP_MD5SIG
+#if defined(CONFIG_TCP_MD5SIG) || defined(CONFIG_TCP_AO)
 out:
+	if (allocated_traffic_key)
+		kfree(key.traffic_key);
 	rcu_read_unlock();
 #endif
 }
 
 static void tcp_v6_send_ack(const struct sock *sk, struct sk_buff *skb, u32 seq,
 			    u32 ack, u32 win, u32 tsval, u32 tsecr, int oif,
-			    struct tcp_md5sig_key *key, u8 tclass,
+			    struct tcp_md5sig_key *md5_key, u8 tclass,
 			    __be32 label, u32 priority, u32 txhash)
 {
-	tcp_v6_send_response(sk, skb, seq, ack, win, tsval, tsecr, oif, key, 0,
-			     tclass, label, priority, txhash);
+	struct tcp_key key = {
+				.md5_key = md5_key,
+				.type = md5_key ? TCP_KEY_MD5 : TCP_KEY_NONE,
+	};
+
+	tcp_v6_send_response(sk, skb, seq, ack, win, tsval, tsecr, oif, 0,
+			     tclass, label, priority, txhash, &key);
 }
 
 static void tcp_v6_timewait_ack(struct sock *sk, struct sk_buff *skb)
-- 
2.42.0

