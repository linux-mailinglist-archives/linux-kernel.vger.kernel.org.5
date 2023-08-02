Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B7376D53A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbjHBR2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbjHBR1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:27:49 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5D62D62
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 10:27:24 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fe1e1142caso1283835e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 10:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1690997238; x=1691602038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5GkTpmZgL+iTPA/1IPV6y6WrTqqcBQTYID/zX3CvW4=;
        b=OXUGNuW10I5LjL2kqyI7lFAuqEg0rbqE+ESz0KRcLqzzE2+x4muRGLmTjtP+jMXeWu
         0TT8VuP889RhVtL/nGWMdLZ/Ws0XOexk4iZt+wVVbJCUKqCxPTb1+vHF04//OVRWdXU6
         SPhJTIaACFrJYIwu2y1cqVfiPlPyrv3MgSs3yaYUVYlyJrbP09Xy7KIlvx9yHzDiLboC
         6J7JX2iRp9qwkYvOifJcy0y06rGVIAItR5j3tTtD+hpk2eAIHN9qK/cZAdVEZ3ILuOx0
         uY6Os56El7f0p4RT9YyOgcs5mIcv4tRdFDk8skFB/jfHLs++B3ADijqE9xxfp23ewm/U
         2Fjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690997238; x=1691602038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j5GkTpmZgL+iTPA/1IPV6y6WrTqqcBQTYID/zX3CvW4=;
        b=F5nj3jJiXunOZWV8p/n3CRuIOFZPMDs2JBaHz2u6OprPzMfjh+A5TGNSrpnYwRekw/
         Xgvxe2mJF5Bp4pj0mZmKby7X9SH0qO85RFIkoFKGNImDcIGsnSGlNBq6lXTuW9w9tFOs
         i19ssvJfKkPcO7xq2yV93Y4vUuXooyNrVkFNKtrDCBLfJGuqvIhuLkHFrbALvXi21xa+
         goBaoJrqkG1sPD8671c82TnRkzton9jS/efOHzJPNPKKZFB8lMtuGY5fvrJn15yFRF0O
         06tjMebwH1nIgDZI0c+4H5jpCe7B6mdqsqXc7WG3FBsCNTOCGynaHV4Xcm9EH1nyJWAV
         vFqg==
X-Gm-Message-State: ABy/qLY1oNoFbEb8iIvX7Fg3Zg/6+s7XN5XGbC1ZxvHh+TZsIJJL3Kvr
        c5mdpN1V2r1TVb8+QxVnlyafpw==
X-Google-Smtp-Source: APBJJlGqI44YfhIB0FeH6c0WKpZVdQ96yPx2LHj/HzTsn4DgD4AlH92O0zRr7n5umOi2WPz1WzUDuw==
X-Received: by 2002:a7b:cb86:0:b0:3fa:9538:963e with SMTP id m6-20020a7bcb86000000b003fa9538963emr5697902wmi.36.1690997237792;
        Wed, 02 Aug 2023 10:27:17 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id q5-20020a1ce905000000b003fbc0a49b57sm2221770wmc.6.2023.08.02.10.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 10:27:17 -0700 (PDT)
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
Subject: [PATCH v9 net-next 08/23] net/tcp: Add AO sign to RST packets
Date:   Wed,  2 Aug 2023 18:26:35 +0100
Message-ID: <20230802172654.1467777-9-dima@arista.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802172654.1467777-1-dima@arista.com>
References: <20230802172654.1467777-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
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
 include/net/tcp_ao.h |  12 +++++
 net/ipv4/tcp_ao.c    | 104 ++++++++++++++++++++++++++++++++++++++++++-
 net/ipv4/tcp_ipv4.c  |  69 ++++++++++++++++++++++------
 net/ipv6/tcp_ipv6.c  |  70 ++++++++++++++++++++++-------
 4 files changed, 225 insertions(+), 30 deletions(-)

diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
index e685ad9db949..67f997aabd9c 100644
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
 				    int family, int sndid, int rcvid);
+int tcp_ao_hash_hdr(unsigned short family, char *ao_hash,
+		    struct tcp_ao_key *key, const u8 *tkey,
+		    const union tcp_ao_addr *daddr,
+		    const union tcp_ao_addr *saddr,
+		    const struct tcphdr *th, u32 sne);
+int tcp_ao_prepare_reset(const struct sock *sk, struct sk_buff *skb,
+			 const struct tcp_ao_hdr *aoh, int l3index, u32 seq,
+			 struct tcp_ao_key **key, char **traffic_key,
+			 bool *allocated_traffic_key, u8 *keyid, u32 *sne);
+
 /* ipv4 specific functions */
 int tcp_v4_parse_ao(struct sock *sk, int cmd, sockptr_t optval, int optlen);
 struct tcp_ao_key *tcp_v4_ao_lookup(const struct sock *sk, struct sock *addr_sk,
diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index d10daee79fe6..81ce4fe546f2 100644
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
@@ -435,6 +495,46 @@ struct tcp_ao_key *tcp_v4_ao_lookup(const struct sock *sk, struct sock *addr_sk,
 	return tcp_ao_do_lookup(sk, addr, AF_INET, sndid, rcvid);
 }
 
+int tcp_ao_prepare_reset(const struct sock *sk, struct sk_buff *skb,
+			 const struct tcp_ao_hdr *aoh, int l3index, u32 seq,
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
index 8649ff94017f..14e1024141a0 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -657,6 +657,52 @@ void tcp_v4_send_check(struct sock *sk, struct sk_buff *skb)
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
@@ -670,28 +716,21 @@ EXPORT_SYMBOL(tcp_v4_send_check);
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
@@ -728,11 +767,15 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb)
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
index 6b943b4345a7..6f7651f26b03 100644
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
@@ -986,19 +1006,24 @@ static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb)
 {
 	const struct tcphdr *th = tcp_hdr(skb);
 	struct ipv6hdr *ipv6h = ipv6_hdr(skb);
-	u32 seq = 0, ack_seq = 0;
-	struct tcp_md5sig_key *key = NULL;
-#ifdef CONFIG_TCP_MD5SIG
 	const __u8 *md5_hash_location = NULL;
+	u32 seq = 0, ack_seq = 0, ao_sne = 0;
+	bool allocated_traffic_key = false;
+	struct tcp_md5sig_key *key = NULL;
+	struct tcp_ao_key *ao_key = NULL;
+	const struct tcp_ao_hdr *aoh;
+	char *traffic_key = NULL;
+	__be32 label = 0;
+	u32 priority = 0;
+	struct net *net;
+	u8 rcv_next = 0;
+	u32 txhash = 0;
+	int oif = 0;
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
@@ -1010,12 +1035,11 @@ static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb)
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
 
@@ -1064,6 +1088,19 @@ static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb)
 		ack_seq = ntohl(th->seq) + th->syn + th->fin + skb->len -
 			  (th->doff << 2);
 
+#ifdef CONFIG_TCP_AO
+	if (aoh) {
+		int l3index;
+
+		l3index = tcp_v6_sdif(skb) ? tcp_v6_iif_l3_slave(skb) : 0;
+		if (tcp_ao_prepare_reset(sk, skb, aoh, l3index, htonl(seq),
+					 &ao_key, &traffic_key,
+					 &allocated_traffic_key,
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

