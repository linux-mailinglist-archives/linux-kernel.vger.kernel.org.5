Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C467B9825
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 00:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241195AbjJDWhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 18:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239879AbjJDWhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 18:37:18 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3C8102
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 15:36:58 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-406618d080eso3034925e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 15:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1696459017; x=1697063817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XlHZVH34I5UuIVm6WneWxfbxFwgNvatz2BDYdkj5ZTY=;
        b=Hr95XqJ8e0YP4ZKYUWaerjHYehVj1tHQRQewqgsNh6P0nKx3V8JdDhdrFulL5/9JkS
         VpOpsWz1hrtqIeJ/iPKsj9QT5yRWdFaycuQgH8HaWQzyqN/lvjBOaChRdiuw0c/8DC0U
         KSu+WgRX5qPziLK0w2Lq2M4+aqT5JL4OCoQEX97H8uDCX8yyY67cWk6jSZBodCEnLN3S
         j56ws1kfBDAVTOrQYeejogxqa5E6v6NcA7AUzDRcrsNLopgIjiucpgimQcAVDpcG4Fkt
         MDYoqIo70I47yfu2zyVNJycA+FuNlq7/5AeXr+kYxYXdpXeJNgGdLOtJKGIC8LKgCIbV
         FeOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696459017; x=1697063817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XlHZVH34I5UuIVm6WneWxfbxFwgNvatz2BDYdkj5ZTY=;
        b=kj7S/khWGcNpImX7jPAsrSOlnnaglIJZmPBfRPJliPQcCjP15SleHPUuycMQyYLTk+
         AYiwuiq7W7PymtMqywKYx405smOaXrcKRZhZkHPzfbaGw/gnCh3iIvYwbVtABLbL311m
         heGJwF9p5Oh55gcnMtxlvQFL94aej3VmFLAPIjB26vNQvLlxjCDJKZvWZ6q9zTm5Dr01
         +Cshi9sxUlunPgcl+EXSlKMiAGoFYLY9NhqiT+qkVA9Nyy/j6LgvXppB3bYzlZgifCg3
         yIowcMLMYhiakHGoL9ftplTfN0AjjFTr1YxR/aXAVU+PnMcS4epAxzGwxruyZl5yyjQW
         j+uQ==
X-Gm-Message-State: AOJu0Yyt1y1uwIhQLr0ATRqwjVToCa5bHMOEvL+YtzKR0UgqH06OlLVN
        ohrweFwSobEC0qeDFGCbA8aotw==
X-Google-Smtp-Source: AGHT+IHoCvGqgtDNafNUHojuy5gPEhgGjEqiyWIbCSsb1T3Z4FU0FipqJrXFHMLEONP7HT/dHbz/OA==
X-Received: by 2002:adf:f182:0:b0:321:589b:bcb5 with SMTP id h2-20020adff182000000b00321589bbcb5mr3468518wro.57.1696459016845;
        Wed, 04 Oct 2023 15:36:56 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id z11-20020a5d4d0b000000b0031ff89af0e4sm181412wrt.99.2023.10.04.15.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 15:36:56 -0700 (PDT)
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
Subject: [PATCH v13 net-next 11/23] net/tcp: Sign SYN-ACK segments with TCP-AO
Date:   Wed,  4 Oct 2023 23:36:15 +0100
Message-ID: <20231004223629.166300-12-dima@arista.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004223629.166300-1-dima@arista.com>
References: <20231004223629.166300-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
index 7cb8c75cb98b..e2e4e09fb608 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2181,6 +2181,9 @@ struct tcp_request_sock_ops {
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
index d04b17971c3c..56c2e34ad7d2 100644
--- a/include/net/tcp_ao.h
+++ b/include/net/tcp_ao.h
@@ -147,6 +147,9 @@ int tcp_ao_prepare_reset(const struct sock *sk, struct sk_buff *skb,
 int tcp_v4_parse_ao(struct sock *sk, int cmd, sockptr_t optval, int optlen);
 struct tcp_ao_key *tcp_v4_ao_lookup(const struct sock *sk, struct sock *addr_sk,
 				    int sndid, int rcvid);
+int tcp_v4_ao_synack_hash(char *ao_hash, struct tcp_ao_key *mkt,
+			  struct request_sock *req, const struct sk_buff *skb,
+			  int hash_offset, u32 sne);
 int tcp_v4_ao_calc_key_sk(struct tcp_ao_key *mkt, u8 *key,
 			  const struct sock *sk,
 			  __be32 sisn, __be32 disn, bool send);
@@ -181,6 +184,9 @@ int tcp_v6_ao_hash_skb(char *ao_hash, struct tcp_ao_key *key,
 		       const struct sock *sk, const struct sk_buff *skb,
 		       const u8 *tkey, int hash_offset, u32 sne);
 int tcp_v6_parse_ao(struct sock *sk, int cmd, sockptr_t optval, int optlen);
+int tcp_v6_ao_synack_hash(char *ao_hash, struct tcp_ao_key *ao_key,
+			  struct request_sock *req, const struct sk_buff *skb,
+			  int hash_offset, u32 sne);
 void tcp_ao_established(struct sock *sk);
 void tcp_ao_finish_connect(struct sock *sk, struct sk_buff *skb);
 void tcp_ao_connect_init(struct sock *sk);
diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index c8006b0cbb8a..0102d0662fca 100644
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
index c332a86c22c5..b4d26d893f9d 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1680,6 +1680,7 @@ const struct tcp_request_sock_ops tcp_request_sock_ipv4_ops = {
 #ifdef CONFIG_TCP_AO
 	.ao_lookup	=	tcp_v4_ao_lookup_rsk,
 	.ao_calc_key	=	tcp_v4_ao_calc_key_rsk,
+	.ao_synack_hash	=	tcp_v4_ao_synack_hash,
 #endif
 #ifdef CONFIG_SYN_COOKIES
 	.cookie_init_seq =	cookie_v4_init_sequence,
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 5d2937a3e0d8..eb0db93291c1 100644
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
@@ -3656,7 +3658,6 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 {
 	struct inet_request_sock *ireq = inet_rsk(req);
 	const struct tcp_sock *tp = tcp_sk(sk);
-	struct tcp_md5sig_key *md5 = NULL;
 	struct tcp_out_options opts;
 	struct tcp_key key = {};
 	struct sk_buff *skb;
@@ -3708,18 +3709,48 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
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
@@ -3739,15 +3770,24 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 
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
index b5396e379c35..38d784236168 100644
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
2.42.0

