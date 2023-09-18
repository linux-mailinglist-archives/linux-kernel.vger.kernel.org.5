Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 807207A528A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 21:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjIRTBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 15:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjIRTBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 15:01:23 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DFB12C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 12:00:58 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-402c46c49f4so52103415e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 12:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1695063656; x=1695668456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JsS4DBO/4VqmKLZlouhrs54mOLOHZc8EUT47n3h7B9I=;
        b=RejKDF5nEIftKoTgAV7/gG7vzn+brTPbUtmUsGxvzx/GRr3719D3Z3bweKIyYJ49il
         GkcbPzu5lq8kzM/tUrUEjld1bCSL3UTfJNhTupJ6QcGJAy6U2fOI1qmB9/Q/SkQoSCgp
         EPPH+awCGDIggafpB3qqkc0u1BPF4ZYr4RC5ynQMwnccBkxYGNY211gw2YcwHqbGZ5Tw
         gdbdPU9lx+LDVcIqlmDAbesdZGTb8NEIWwPvwYhAFAjdNazx0bSPhEKLiXfyAk8zRCjm
         Zek7E0IFQrb98Abhe1W2DeVdoOSjIrw0qEYfLtfyZT9O7m8pcWe0jj3rsvgT2RdhSInz
         C+rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695063656; x=1695668456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JsS4DBO/4VqmKLZlouhrs54mOLOHZc8EUT47n3h7B9I=;
        b=AOBBh0+HUBqBLO0qc8FV9ouzpPN0IJD4bwlcHioQvAwWpwmK+qVG9drn+hmxp1HMz3
         GKiLUxQmbcf5hEdyoE5DRI8qxWkzUh14TPmtYPg1Brf16Q1YOotJ/i/cGlXamLEe/wc7
         VpkWgdm3hLqqlyOBqVCiIADtGyAXfGak89YonLX3XBc3EV0L3annU/yD2BhnCtW2uR/J
         F/0/zNR3Y4tjll//kDAFGZcwCKqpAbSvAl6g/aj853aGgqCByr/jxEVR79P/vcNMX/a4
         EXYeDQwz10dTjmeNrK1Z6F+ioAklKw2Q9iV0DOKaMOFJJHP+w004HvplR1gHECHglCwK
         Grtw==
X-Gm-Message-State: AOJu0YxQY4jcoaCy3l12sc0iPJz1hpx8zaQ0EM+aRlUagldWCs1MlBgA
        8jV6Mvn6gyGdI+2yw6Uke6yIyA==
X-Google-Smtp-Source: AGHT+IGTcmRdr267EajJwOKrOrjJPx3XQ9zzeJR5Osw0/SOuqrzyBLyHag/fRlHQJYj6TgK8I2ZMfw==
X-Received: by 2002:a05:600c:ad7:b0:402:f555:6523 with SMTP id c23-20020a05600c0ad700b00402f5556523mr8722584wmr.9.1695063656619;
        Mon, 18 Sep 2023 12:00:56 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id n9-20020a05600c3b8900b004047ac770d1sm10762707wms.8.2023.09.18.12.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 12:00:55 -0700 (PDT)
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
Subject: [PATCH v12 net-next 11/23] net/tcp: Sign SYN-ACK segments with TCP-AO
Date:   Mon, 18 Sep 2023 20:00:09 +0100
Message-ID: <20230918190027.613430-12-dima@arista.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230918190027.613430-1-dima@arista.com>
References: <20230918190027.613430-1-dima@arista.com>
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

Similarly to RST segments, wire SYN-ACKs to TCP-AO.
tcp_rsk_used_ao() is handy here to check if the request socket used AO
and needs a signature on the outgoing segments.

Co-developed-by: Francesco Ruggeri <fruggeri@arista.com>
Signed-off-by: Francesco Ruggeri <fruggeri@arista.com>
Co-developed-by: Salam Noureddine <noureddine@arista.com>
Signed-off-by: Salam Noureddine <noureddine@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
Acked-by: David Ahern <dsahern@kernel.org>
---
 include/net/tcp.h     |  3 ++
 include/net/tcp_ao.h  |  6 ++++
 net/ipv4/tcp_ao.c     | 22 +++++++++++++
 net/ipv4/tcp_ipv4.c   |  1 +
 net/ipv4/tcp_output.c | 72 +++++++++++++++++++++++++++++++++----------
 net/ipv6/tcp_ao.c     | 22 +++++++++++++
 net/ipv6/tcp_ipv6.c   |  1 +
 7 files changed, 111 insertions(+), 16 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 29734c882178..fae59dfa5ab4 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2179,6 +2179,9 @@ struct tcp_request_sock_ops {
 					struct request_sock *req,
 					int sndid, int rcvid);
 	int (*ao_calc_key)(struct tcp_ao_key *mkt, u8 *key, struct request_sock *sk);
+	int (*ao_synack_hash)(char *ao_hash, struct tcp_ao_key *mkt,
+			      struct request_sock *req, const struct sk_buff *skb,
+			      int hash_offset, u32 sne);
 #endif
 #ifdef CONFIG_SYN_COOKIES
 	__u32 (*cookie_init_seq)(const struct sk_buff *skb,
diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
index d26d98f1b048..c922d2e31d08 100644
--- a/include/net/tcp_ao.h
+++ b/include/net/tcp_ao.h
@@ -144,6 +144,9 @@ int tcp_ao_prepare_reset(const struct sock *sk, struct sk_buff *skb,
 int tcp_v4_parse_ao(struct sock *sk, int cmd, sockptr_t optval, int optlen);
 struct tcp_ao_key *tcp_v4_ao_lookup(const struct sock *sk, struct sock *addr_sk,
 				    int sndid, int rcvid);
+int tcp_v4_ao_synack_hash(char *ao_hash, struct tcp_ao_key *mkt,
+			  struct request_sock *req, const struct sk_buff *skb,
+			  int hash_offset, u32 sne);
 int tcp_v4_ao_calc_key_sk(struct tcp_ao_key *mkt, u8 *key,
 			  const struct sock *sk,
 			  __be32 sisn, __be32 disn, bool send);
@@ -178,6 +181,9 @@ int tcp_v6_ao_hash_skb(char *ao_hash, struct tcp_ao_key *key,
 		       const struct sock *sk, const struct sk_buff *skb,
 		       const u8 *tkey, int hash_offset, u32 sne);
 int tcp_v6_parse_ao(struct sock *sk, int cmd, sockptr_t optval, int optlen);
+int tcp_v6_ao_synack_hash(char *ao_hash, struct tcp_ao_key *ao_key,
+			  struct request_sock *req, const struct sk_buff *skb,
+			  int hash_offset, u32 sne);
 void tcp_ao_finish_connect(struct sock *sk, struct sk_buff *skb);
 void tcp_ao_connect_init(struct sock *sk);
 void tcp_ao_syncookie(struct sock *sk, const struct sk_buff *skb,
diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index b114f3d901a0..0d8ea381300b 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -568,6 +568,28 @@ int tcp_v4_ao_hash_skb(char *ao_hash, struct tcp_ao_key *key,
 			       tkey, hash_offset, sne);
 }
 
+int tcp_v4_ao_synack_hash(char *ao_hash, struct tcp_ao_key *ao_key,
+			  struct request_sock *req, const struct sk_buff *skb,
+			  int hash_offset, u32 sne)
+{
+	void *hash_buf = NULL;
+	int err;
+
+	hash_buf = kmalloc(tcp_ao_digest_size(ao_key), GFP_ATOMIC);
+	if (!hash_buf)
+		return -ENOMEM;
+
+	err = tcp_v4_ao_calc_key_rsk(ao_key, hash_buf, req);
+	if (err)
+		goto out;
+
+	err = tcp_ao_hash_skb(AF_INET, ao_hash, ao_key, req_to_sk(req), skb,
+			      hash_buf, hash_offset, sne);
+out:
+	kfree(hash_buf);
+	return err;
+}
+
 struct tcp_ao_key *tcp_v4_ao_lookup_rsk(const struct sock *sk,
 					struct request_sock *req,
 					int sndid, int rcvid)
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 26392304a99e..b0cf5dd17222 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1679,6 +1679,7 @@ const struct tcp_request_sock_ops tcp_request_sock_ipv4_ops = {
 #ifdef CONFIG_TCP_AO
 	.ao_lookup	=	tcp_v4_ao_lookup_rsk,
 	.ao_calc_key	=	tcp_v4_ao_calc_key_rsk,
+	.ao_synack_hash	=	tcp_v4_ao_synack_hash,
 #endif
 #ifdef CONFIG_SYN_COOKIES
 	.cookie_init_seq =	cookie_v4_init_sequence,
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 4dc9875975aa..42bdc1b0c68b 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -887,7 +887,7 @@ static unsigned int tcp_synack_options(const struct sock *sk,
 				       struct request_sock *req,
 				       unsigned int mss, struct sk_buff *skb,
 				       struct tcp_out_options *opts,
-				       const struct tcp_md5sig_key *md5,
+				       const struct tcp_key *key,
 				       struct tcp_fastopen_cookie *foc,
 				       enum tcp_synack_type synack_type,
 				       struct sk_buff *syn_skb)
@@ -895,8 +895,7 @@ static unsigned int tcp_synack_options(const struct sock *sk,
 	struct inet_request_sock *ireq = inet_rsk(req);
 	unsigned int remaining = MAX_TCP_OPTION_SPACE;
 
-#ifdef CONFIG_TCP_MD5SIG
-	if (md5) {
+	if (tcp_key_is_md5(key)) {
 		opts->options |= OPTION_MD5;
 		remaining -= TCPOLEN_MD5SIG_ALIGNED;
 
@@ -907,8 +906,11 @@ static unsigned int tcp_synack_options(const struct sock *sk,
 		 */
 		if (synack_type != TCP_SYNACK_COOKIE)
 			ireq->tstamp_ok &= !ireq->sack_ok;
+	} else if (tcp_key_is_ao(key)) {
+		opts->options |= OPTION_AO;
+		remaining -= tcp_ao_len(key->ao_key);
+		ireq->tstamp_ok &= !ireq->sack_ok;
 	}
-#endif
 
 	/* We always send an MSS option. */
 	opts->mss = mss;
@@ -3678,7 +3680,6 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 {
 	struct inet_request_sock *ireq = inet_rsk(req);
 	const struct tcp_sock *tp = tcp_sk(sk);
-	struct tcp_md5sig_key *md5 = NULL;
 	struct tcp_out_options opts;
 	struct tcp_key key = {};
 	struct sk_buff *skb;
@@ -3730,18 +3731,48 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 			tcp_rsk(req)->snt_synack = tcp_skb_timestamp_us(skb);
 	}
 
-#ifdef CONFIG_TCP_MD5SIG
+#if defined(CONFIG_TCP_MD5SIG) || defined(CONFIG_TCP_AO)
 	rcu_read_lock();
-	md5 = tcp_rsk(req)->af_specific->req_md5_lookup(sk, req_to_sk(req));
-	if (md5)
-		key.type = TCP_KEY_MD5;
 #endif
+	if (tcp_rsk_used_ao(req)) {
+#ifdef CONFIG_TCP_AO
+		struct tcp_ao_key *ao_key = NULL;
+		u8 maclen = tcp_rsk(req)->maclen;
+		u8 keyid = tcp_rsk(req)->ao_keyid;
+
+		ao_key = tcp_sk(sk)->af_specific->ao_lookup(sk, req_to_sk(req),
+							    keyid, -1);
+		/* If there is no matching key - avoid sending anything,
+		 * especially usigned segments. It could try harder and lookup
+		 * for another peer-matching key, but the peer has requested
+		 * ao_keyid (RFC5925 RNextKeyID), so let's keep it simple here.
+		 */
+		if (unlikely(!ao_key || tcp_ao_maclen(ao_key) != maclen)) {
+			u8 key_maclen = ao_key ? tcp_ao_maclen(ao_key) : 0;
+
+			rcu_read_unlock();
+			kfree_skb(skb);
+			net_warn_ratelimited("TCP-AO: the keyid %u with maclen %u|%u from SYN packet is not present - not sending SYNACK\n",
+					     keyid, maclen, key_maclen);
+			return NULL;
+		}
+		key.ao_key = ao_key;
+		key.type = TCP_KEY_AO;
+#endif
+	} else {
+#ifdef CONFIG_TCP_MD5SIG
+		key.md5_key = tcp_rsk(req)->af_specific->req_md5_lookup(sk,
+					req_to_sk(req));
+		if (key.md5_key)
+			key.type = TCP_KEY_MD5;
+#endif
+	}
 	skb_set_hash(skb, READ_ONCE(tcp_rsk(req)->txhash), PKT_HASH_TYPE_L4);
 	/* bpf program will be interested in the tcp_flags */
 	TCP_SKB_CB(skb)->tcp_flags = TCPHDR_SYN | TCPHDR_ACK;
-	tcp_header_size = tcp_synack_options(sk, req, mss, skb, &opts, md5,
-					     foc, synack_type,
-					     syn_skb) + sizeof(*th);
+	tcp_header_size = tcp_synack_options(sk, req, mss, skb, &opts,
+					     &key, foc, synack_type, syn_skb)
+					+ sizeof(*th);
 
 	skb_push(skb, tcp_header_size);
 	skb_reset_transport_header(skb);
@@ -3761,15 +3792,24 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 
 	/* RFC1323: The window in SYN & SYN/ACK segments is never scaled. */
 	th->window = htons(min(req->rsk_rcv_wnd, 65535U));
-	tcp_options_write(th, NULL, NULL, &opts, &key);
+	tcp_options_write(th, NULL, tcp_rsk(req), &opts, &key);
 	th->doff = (tcp_header_size >> 2);
 	TCP_INC_STATS(sock_net(sk), TCP_MIB_OUTSEGS);
 
-#ifdef CONFIG_TCP_MD5SIG
 	/* Okay, we have all we need - do the md5 hash if needed */
-	if (md5)
+	if (tcp_key_is_md5(&key)) {
+#ifdef CONFIG_TCP_MD5SIG
 		tcp_rsk(req)->af_specific->calc_md5_hash(opts.hash_location,
-					       md5, req_to_sk(req), skb);
+					key.md5_key, req_to_sk(req), skb);
+#endif
+	} else if (tcp_key_is_ao(&key)) {
+#ifdef CONFIG_TCP_AO
+		tcp_rsk(req)->af_specific->ao_synack_hash(opts.hash_location,
+					key.ao_key, req, skb,
+					opts.hash_location - (u8 *)th, 0);
+#endif
+	}
+#if defined(CONFIG_TCP_MD5SIG) || defined(CONFIG_TCP_AO)
 	rcu_read_unlock();
 #endif
 
diff --git a/net/ipv6/tcp_ao.c b/net/ipv6/tcp_ao.c
index c9a6fa84f6ce..99753e12c08c 100644
--- a/net/ipv6/tcp_ao.c
+++ b/net/ipv6/tcp_ao.c
@@ -144,3 +144,25 @@ int tcp_v6_parse_ao(struct sock *sk, int cmd,
 {
 	return tcp_parse_ao(sk, cmd, AF_INET6, optval, optlen);
 }
+
+int tcp_v6_ao_synack_hash(char *ao_hash, struct tcp_ao_key *ao_key,
+			  struct request_sock *req, const struct sk_buff *skb,
+			  int hash_offset, u32 sne)
+{
+	void *hash_buf = NULL;
+	int err;
+
+	hash_buf = kmalloc(tcp_ao_digest_size(ao_key), GFP_ATOMIC);
+	if (!hash_buf)
+		return -ENOMEM;
+
+	err = tcp_v6_ao_calc_key_rsk(ao_key, hash_buf, req);
+	if (err)
+		goto out;
+
+	err = tcp_ao_hash_skb(AF_INET6, ao_hash, ao_key, req_to_sk(req), skb,
+			      hash_buf, hash_offset, sne);
+out:
+	kfree(hash_buf);
+	return err;
+}
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index f1bb92a9ee8f..2f7e68d24559 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -838,6 +838,7 @@ const struct tcp_request_sock_ops tcp_request_sock_ipv6_ops = {
 #ifdef CONFIG_TCP_AO
 	.ao_lookup	=	tcp_v6_ao_lookup_rsk,
 	.ao_calc_key	=	tcp_v6_ao_calc_key_rsk,
+	.ao_synack_hash =	tcp_v6_ao_synack_hash,
 #endif
 #ifdef CONFIG_SYN_COOKIES
 	.cookie_init_seq =	cookie_v6_init_sequence,
-- 
2.41.0

