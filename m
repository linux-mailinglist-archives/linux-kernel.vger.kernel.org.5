Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59263759FB0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 22:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjGSU11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 16:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjGSU1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 16:27:00 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073282101
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 13:26:54 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fbc0609cd6so274685e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 13:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1689798412; x=1692390412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8n9PGWrazpyyy75vavVFzTL8mVkacXFK1pwOvG+Ws3w=;
        b=Wz96IyzKLn9gqicy3gPUO+K/n90h0/VHntkEIvQ5Soqz/ThjbMTjlWH04Vne3mv2Am
         sIRUB71B6W14NptGL44KWRuGSUgQ+ssP3qvu2calOUHOZLhMW191ENdbEIPK1Njsxs0Y
         QZsMB2qveve5YBPAPeB2CQcvXRoqGr1+SwibdmujtSDGRKta9BmfxDBAqVpBbHDX9edm
         SwjoHdmYqzlsCZYMoRMAdOa9jXPWNld+2s0VD91Cd0C8tBDbunumXBEqrfj3s0n8DehK
         46ARpiQk/cEP/gOf7RDk6ErDvMfPrEVZlzfkJe9HnApWa3k1nzgtS7eMdMb/ZbiUl7BY
         oV3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689798412; x=1692390412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8n9PGWrazpyyy75vavVFzTL8mVkacXFK1pwOvG+Ws3w=;
        b=L30K1H8GRoR2WpFr3FGiX23d9X9sbwu3CYEM8ub77LtqxcaWki0lhMr6ecnRH28hFr
         uMU74wsRMxhRDbXT6iEMHsa6Yb957UdssjsHewUXiNFwHHsRDuZNz33/b7CIacIlTt7b
         VfF9HmxfImY9l2A1B24isX8k8jYHsmKgYNOPUsuRfUcSkcs4QuK27DLBDeIPL5Mc6x73
         5XJ3TY/LYs/OkpJoIrNPq5VeYX3jcI9MGcjYoL12VwSLEt8wDubV8azJIdR1+O55hep3
         kihT+QJk7B7kkAAFZ2x6BnuH0g5XAmRrNDnRPBQnsv8W/jhtM01+j6UsSyM77jGgTrR4
         dgQg==
X-Gm-Message-State: ABy/qLba03uIJD/KSPeCVEb8O2cQqgCqjIOPrLY6O5Bgclis2c1pJSU6
        oz7GCd6pg+RWK9J7Mj+C5C9doQ==
X-Google-Smtp-Source: APBJJlEPXJYihTHNr6Tjai6Ckk6qil3vV0jeFvGpmTZSvk75aN3xiTI+vxU/AHx2d9+9Rkj0SfVhOw==
X-Received: by 2002:a05:600c:218e:b0:3fb:a616:76b6 with SMTP id e14-20020a05600c218e00b003fba61676b6mr2569983wme.40.1689798412434;
        Wed, 19 Jul 2023 13:26:52 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id 3-20020a05600c234300b003fc04d13242sm2432319wmq.0.2023.07.19.13.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 13:26:52 -0700 (PDT)
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
Subject: [PATCH v8 08/23] net/tcp: Add AO sign to RST packets
Date:   Wed, 19 Jul 2023 21:26:13 +0100
Message-ID: <20230719202631.472019-9-dima@arista.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230719202631.472019-1-dima@arista.com>
References: <20230719202631.472019-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
---
 include/net/tcp_ao.h |  12 +++++
 net/ipv4/tcp_ao.c    | 105 ++++++++++++++++++++++++++++++++++++++++++-
 net/ipv4/tcp_ipv4.c  |  69 ++++++++++++++++++++++------
 net/ipv6/tcp_ipv6.c  |  66 +++++++++++++++++++++------
 4 files changed, 224 insertions(+), 28 deletions(-)

diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
index e97dfdc11451..6e8567b5bbf8 100644
--- a/include/net/tcp_ao.h
+++ b/include/net/tcp_ao.h
@@ -117,12 +117,24 @@ int tcp_ao_hash_skb(unsigned short int family,
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
 				    int family, int sndid, int rcvid, u16 port);
+int tcp_ao_hash_hdr(unsigned short family, char *ao_hash,
+		struct tcp_ao_key *key, const u8 *tkey,
+		const union tcp_ao_addr *daddr,
+		const union tcp_ao_addr *saddr,
+		const struct tcphdr *th, u32 sne);
+int tcp_ao_prepare_reset(const struct sock *sk, struct sk_buff *skb,
+			 const struct tcp_ao_hdr *aoh, int l3index, u32 seq,
+			 struct tcp_ao_key **key, char **traffic_key,
+			 bool *allocated_traffic_key, u8 *keyid, u32 *sne);
+
 /* ipv4 specific functions */
 int tcp_v4_parse_ao(struct sock *sk, int optname, sockptr_t optval, int optlen);
 struct tcp_ao_key *tcp_v4_ao_lookup(const struct sock *sk, struct sock *addr_sk,
diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index 3ff7b1efacfa..b8b2e9caa096 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -48,8 +48,8 @@ int tcp_ao_calc_traffic_key(struct tcp_ao_key *mkt, u8 *key, void *ctx,
  * it's known that the keys in ao_info are matching peer's
  * family/address/port/VRF/etc.
  */
-static struct tcp_ao_key *tcp_ao_established_key(struct tcp_ao_info *ao,
-						 int sndid, int rcvid)
+struct tcp_ao_key *tcp_ao_established_key(struct tcp_ao_info *ao,
+					  int sndid, int rcvid)
 {
 	struct tcp_ao_key *key;
 
@@ -371,6 +371,66 @@ static int tcp_ao_hash_header(struct tcp_sigpool *hp,
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
@@ -437,6 +497,47 @@ struct tcp_ao_key *tcp_v4_ao_lookup(const struct sock *sk, struct sock *addr_sk,
 	return tcp_ao_do_lookup(sk, addr, AF_INET, sndid, rcvid, 0);
 }
 
+int tcp_ao_prepare_reset(const struct sock *sk, struct sk_buff *skb,
+			 const struct tcp_ao_hdr *aoh, int l3index, u32 seq,
+			 struct tcp_ao_key **key, char **traffic_key,
+			 bool *allocated_traffic_key, u8 *keyid, u32 *sne)
+{
+	const struct tcphdr *th = tcp_hdr(skb);
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
+	if ((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_NEW_SYN_RECV)) {
+		return -1;
+	} else {
+		struct tcp_ao_key *rnext_key;
+
+		if (sk->sk_state == TCP_TIME_WAIT)
+			return -1;
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
 static int tcp_ao_cache_traffic_keys(const struct sock *sk,
 				     struct tcp_ao_info *ao,
 				     struct tcp_ao_key *ao_key)
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 30a27323d10f..9bde22c2690d 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -655,6 +655,52 @@ void tcp_v4_send_check(struct sock *sk, struct sk_buff *skb)
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
+	if (tcp_ao_prepare_reset(sk, skb, aoh, l3index, reply->seq,
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
@@ -668,28 +714,21 @@ EXPORT_SYMBOL(tcp_v4_send_check);
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
 	struct tcp_md5sig_key *key = NULL;
-	const __u8 *md5_hash_location = NULL;
 	unsigned char newhash[16];
-	int genhash;
 	struct sock *sk1 = NULL;
+	int genhash;
 #endif
 	u64 transmit_time = 0;
 	struct sock *ctl_sk;
@@ -726,11 +765,15 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb)
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
index de86686274b0..9bd28493b4b1 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -854,7 +854,9 @@ const struct tcp_request_sock_ops tcp_request_sock_ipv6_ops = {
 static void tcp_v6_send_response(const struct sock *sk, struct sk_buff *skb, u32 seq,
 				 u32 ack, u32 win, u32 tsval, u32 tsecr,
 				 int oif, struct tcp_md5sig_key *key, int rst,
-				 u8 tclass, __be32 label, u32 priority, u32 txhash)
+				 u8 tclass, __be32 label, u32 priority, u32 txhash,
+				 struct tcp_ao_key *ao_key, char *tkey,
+				 u8 rcv_next, u32 ao_sne)
 {
 	const struct tcphdr *th = tcp_hdr(skb);
 	struct tcphdr *t1;
@@ -873,6 +875,13 @@ static void tcp_v6_send_response(const struct sock *sk, struct sk_buff *skb, u32
 	if (key)
 		tot_len += TCPOLEN_MD5SIG_ALIGNED;
 #endif
+#ifdef CONFIG_TCP_AO
+	if (ao_key)
+		tot_len += tcp_ao_len(ao_key);
+#endif
+#if defined(CONFIG_TCP_MD5SIG) && defined(CONFIG_TCP_AO)
+	WARN_ON_ONCE(key && ao_key);
+#endif
 
 #ifdef CONFIG_MPTCP
 	if (rst && !key) {
@@ -924,6 +933,17 @@ static void tcp_v6_send_response(const struct sock *sk, struct sk_buff *skb, u32
 				    &ipv6_hdr(skb)->daddr, t1);
 	}
 #endif
+#ifdef CONFIG_TCP_AO
+	if (ao_key) {
+		*topt++ = htonl((TCPOPT_AO << 24) | (tcp_ao_len(ao_key) << 16) |
+				(ao_key->sndid << 8) | (rcv_next));
+
+		tcp_ao_hash_hdr(AF_INET6, (char *)topt, ao_key, tkey,
+				(union tcp_ao_addr *)&ipv6_hdr(skb)->saddr,
+				(union tcp_ao_addr *)&ipv6_hdr(skb)->daddr,
+				t1, ao_sne);
+	}
+#endif
 
 	memset(&fl6, 0, sizeof(fl6));
 	fl6.daddr = ipv6_hdr(skb)->saddr;
@@ -988,17 +1008,23 @@ static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb)
 	struct ipv6hdr *ipv6h = ipv6_hdr(skb);
 	u32 seq = 0, ack_seq = 0;
 	struct tcp_md5sig_key *key = NULL;
-#ifdef CONFIG_TCP_MD5SIG
+	__be32 label = 0;
+	u32 priority = 0;
+	struct net *net;
+	struct tcp_ao_key *ao_key = NULL;
+	u8 rcv_next = 0;
+	u32 ao_sne = 0;
+	u32 txhash = 0;
+	int oif = 0;
 	const __u8 *md5_hash_location = NULL;
+	const struct tcp_ao_hdr *aoh;
+	char *traffic_key = NULL;
+	bool allocated_traffic_key = false;
+#ifdef CONFIG_TCP_MD5SIG
 	unsigned char newhash[16];
 	int genhash;
 	struct sock *sk1 = NULL;
 #endif
-	__be32 label = 0;
-	u32 priority = 0;
-	struct net *net;
-	u32 txhash = 0;
-	int oif = 0;
 
 	if (th->rst)
 		return;
@@ -1010,12 +1036,11 @@ static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb)
 		return;
 
 	net = sk ? sock_net(sk) : dev_net(skb_dst(skb)->dev);
-#ifdef CONFIG_TCP_MD5SIG
 	/* Invalid TCP option size or twice included auth */
-	if (tcp_parse_auth_options(th, &md5_hash_location, NULL))
+	if (tcp_parse_auth_options(th, &md5_hash_location, &aoh))
 		return;
-
 	rcu_read_lock();
+#ifdef CONFIG_TCP_MD5SIG
 	if (sk && sk_fullsock(sk)) {
 		int l3index;
 
@@ -1064,6 +1089,18 @@ static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb)
 		ack_seq = ntohl(th->seq) + th->syn + th->fin + skb->len -
 			  (th->doff << 2);
 
+#ifdef CONFIG_TCP_AO
+	if (aoh) {
+		int l3index;
+
+		l3index = tcp_v6_sdif(skb) ? tcp_v6_iif_l3_slave(skb) : 0;
+		if (tcp_ao_prepare_reset(sk, skb, aoh, l3index, seq, &ao_key,
+					 &traffic_key, &allocated_traffic_key,
+					 &rcv_next, &ao_sne))
+			goto out;
+	}
+#endif
+
 	if (sk) {
 		oif = sk->sk_bound_dev_if;
 		if (sk_fullsock(sk)) {
@@ -1086,10 +1123,13 @@ static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb)
 	}
 
 	tcp_v6_send_response(sk, skb, seq, ack_seq, 0, 0, 0, oif, key, 1,
-			     ipv6_get_dsfield(ipv6h), label, priority, txhash);
+			     ipv6_get_dsfield(ipv6h), label, priority, txhash,
+			     ao_key, traffic_key, rcv_next, ao_sne);
 
-#ifdef CONFIG_TCP_MD5SIG
+#if defined(CONFIG_TCP_MD5SIG) || defined(CONFIG_TCP_AO)
 out:
+	if (allocated_traffic_key)
+		kfree(traffic_key);
 	rcu_read_unlock();
 #endif
 }
@@ -1100,7 +1140,7 @@ static void tcp_v6_send_ack(const struct sock *sk, struct sk_buff *skb, u32 seq,
 			    __be32 label, u32 priority, u32 txhash)
 {
 	tcp_v6_send_response(sk, skb, seq, ack, win, tsval, tsecr, oif, key, 0,
-			     tclass, label, priority, txhash);
+			     tclass, label, priority, txhash, NULL, NULL, 0, 0);
 }
 
 static void tcp_v6_timewait_ack(struct sock *sk, struct sk_buff *skb)
-- 
2.41.0

