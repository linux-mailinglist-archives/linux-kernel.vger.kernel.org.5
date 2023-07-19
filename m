Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E2C759FB3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 22:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjGSU1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 16:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbjGSU1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 16:27:37 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B679E171E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 13:26:59 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fbc0314a7bso16162e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 13:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1689798417; x=1692390417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vjmwQ8AscONeBKgiVpy3eAOaVVrTlRfgA2v4Vhyy6mE=;
        b=EMMGz4WkRYJdwufvVUVXEk1toGQaqqOGq7I4pdEkMj+wzUlmm3440fRH2P/2FppKeM
         O+x1Oyx/sqzWBmooW3QcLKxjLcL6XgbSgc94ajtgbaXVWjdvr+R4zG6tmngGCMC+2sDT
         5/RsO1Q8SZhnHh2Z02wHN7bSTHas4nvyRuu7kJ8nRfdK8kovbwz5rnNM55jlN1+bd0e9
         OFvXf3yR/khY0NtV6kEsgpaDwgBSWdVPkyopKFJwnzs7K31Gsv+oFzuswilORIxLo82f
         4/1oqYC+5v8wAwq6Hx+Tez2D5eY0zzq2/gbcG5t5ZHRjqF9NA4d+s3q2nE31up7yEua4
         E50w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689798417; x=1692390417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vjmwQ8AscONeBKgiVpy3eAOaVVrTlRfgA2v4Vhyy6mE=;
        b=ZD7BeAR2IM7BH8Zmt+kMqya+ZvSru/VeJn0mSreoAVecOaUgs+VmhnMmxCpQhjKylY
         fUDcC8uGceOcHYoJ69Qw8Fh5dfnZlY3ktgtTg2bkN9gerFIMYEePA71LyZKGTQaXgkzw
         sR62JC6YiMZRNVBeZ3+97kTAct/2vRYZU8xvsks3CcbBpCKAYBQhZdRivtOqhx8Vd7MI
         eXAvLwX3sUPofc5MMUWo+ZhYG6p5+GYuHMMYUqdU46BdkrR3+KgR8lYXiIxtWgUzVm5L
         AeXOzCZh8lW0MDIrjhxZIzUzs3lgi0Jcn2mJWgbqcTz5jIdFEkH3UkhE7+UBv9HN+njW
         glFQ==
X-Gm-Message-State: ABy/qLbcrHIn4Ci+TmUYD5Xy3SJBvD0bnS8y7eAv8ohzDD6E66dGJqdF
        lgaFvR+DaLQRVb15BMSFgEj31A==
X-Google-Smtp-Source: APBJJlGjYdol5PbqOEXjqtyo0RkiajoJdfLeYfpO2r7YvwqpY83R5JQ38taFRByiX3vpikzgJTigwQ==
X-Received: by 2002:ac2:5049:0:b0:4fb:744e:17db with SMTP id a9-20020ac25049000000b004fb744e17dbmr112802lfm.1.1689798417550;
        Wed, 19 Jul 2023 13:26:57 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id 3-20020a05600c234300b003fc04d13242sm2432319wmq.0.2023.07.19.13.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 13:26:56 -0700 (PDT)
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
Subject: [PATCH v8 11/23] net/tcp: Sign SYN-ACK segments with TCP-AO
Date:   Wed, 19 Jul 2023 21:26:16 +0100
Message-ID: <20230719202631.472019-12-dima@arista.com>
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

Similarly to RST segments, wire SYN-ACKs to TCP-AO.
tcp_rsk_used_ao() is handy here to check if the request socket used AO
and needs a signature on the outgoing segments.

Co-developed-by: Francesco Ruggeri <fruggeri@arista.com>
Signed-off-by: Francesco Ruggeri <fruggeri@arista.com>
Co-developed-by: Salam Noureddine <noureddine@arista.com>
Signed-off-by: Salam Noureddine <noureddine@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 include/net/tcp.h     |  4 ++++
 include/net/tcp_ao.h  |  6 ++++++
 net/ipv4/tcp_ao.c     | 22 ++++++++++++++++++++
 net/ipv4/tcp_ipv4.c   |  1 +
 net/ipv4/tcp_output.c | 48 +++++++++++++++++++++++++++++++++++++------
 net/ipv6/tcp_ao.c     | 22 ++++++++++++++++++++
 net/ipv6/tcp_ipv6.c   |  1 +
 7 files changed, 98 insertions(+), 6 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 37ee218fe09c..77896df7952e 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2146,6 +2146,10 @@ struct tcp_request_sock_ops {
 					       int sndid, int rcvid);
 	int			(*ao_calc_key)(struct tcp_ao_key *mkt, u8 *key,
 						struct request_sock *sk);
+	int		(*ao_synack_hash)(char *ao_hash, struct tcp_ao_key *mkt,
+					  struct request_sock *req,
+					  const struct sk_buff *skb,
+					  int hash_offset, u32 sne);
 #endif
 #ifdef CONFIG_SYN_COOKIES
 	__u32 (*cookie_init_seq)(const struct sk_buff *skb,
diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
index b63c4f2c36ea..4979c993973f 100644
--- a/include/net/tcp_ao.h
+++ b/include/net/tcp_ao.h
@@ -144,6 +144,9 @@ int tcp_ao_prepare_reset(const struct sock *sk, struct sk_buff *skb,
 int tcp_v4_parse_ao(struct sock *sk, int optname, sockptr_t optval, int optlen);
 struct tcp_ao_key *tcp_v4_ao_lookup(const struct sock *sk, struct sock *addr_sk,
 				    int sndid, int rcvid);
+int tcp_v4_ao_synack_hash(char *ao_hash, struct tcp_ao_key *mkt,
+			  struct request_sock *req, const struct sk_buff *skb,
+			  int hash_offset, u32 sne);
 int tcp_v4_ao_calc_key_sk(struct tcp_ao_key *mkt, u8 *key,
 			  const struct sock *sk,
 			  __be32 sisn, __be32 disn, bool send);
@@ -178,6 +181,9 @@ int tcp_v6_ao_hash_skb(char *ao_hash, struct tcp_ao_key *key,
 		       const u8 *tkey, int hash_offset, u32 sne);
 int tcp_v6_parse_ao(struct sock *sk, int cmd,
 		    sockptr_t optval, int optlen);
+int tcp_v6_ao_synack_hash(char *ao_hash, struct tcp_ao_key *ao_key,
+			  struct request_sock *req, const struct sk_buff *skb,
+			  int hash_offset, u32 sne);
 void tcp_ao_finish_connect(struct sock *sk, struct sk_buff *skb);
 void tcp_ao_connect_init(struct sock *sk);
 void tcp_ao_syncookie(struct sock *sk, const struct sk_buff *skb,
diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index be9349239139..0233cf363de9 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -546,6 +546,28 @@ int tcp_v4_ao_hash_skb(char *ao_hash, struct tcp_ao_key *key,
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
index 57513de663ef..43a5de1b14fa 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1675,6 +1675,7 @@ const struct tcp_request_sock_ops tcp_request_sock_ipv4_ops = {
 #ifdef CONFIG_TCP_AO
 	.ao_lookup	=	tcp_v4_ao_lookup_rsk,
 	.ao_calc_key	=	tcp_v4_ao_calc_key_rsk,
+	.ao_synack_hash	=	tcp_v4_ao_synack_hash,
 #endif
 #ifdef CONFIG_SYN_COOKIES
 	.cookie_init_seq =	cookie_v4_init_sequence,
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index f8296851e820..106eb962db38 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3722,6 +3722,7 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 	struct inet_request_sock *ireq = inet_rsk(req);
 	const struct tcp_sock *tp = tcp_sk(sk);
 	struct tcp_md5sig_key *md5 = NULL;
+	struct tcp_ao_key *ao_key = NULL;
 	struct tcp_out_options opts;
 	struct sk_buff *skb;
 	int tcp_header_size;
@@ -3772,16 +3773,43 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 			tcp_rsk(req)->snt_synack = tcp_skb_timestamp_us(skb);
 	}
 
-#ifdef CONFIG_TCP_MD5SIG
+#if defined(CONFIG_TCP_MD5SIG) || defined(CONFIG_TCP_AO)
 	rcu_read_lock();
-	md5 = tcp_rsk(req)->af_specific->req_md5_lookup(sk, req_to_sk(req));
 #endif
+	if (tcp_rsk_used_ao(req)) {
+#ifdef CONFIG_TCP_AO
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
+			rcu_read_unlock();
+			skb_dst_drop(skb);
+			kfree_skb(skb);
+			net_warn_ratelimited("TCP-AO: the keyid %u with maclen %u|%u from SYN packet is not present - not sending SYNACK\n",
+					     keyid, maclen,
+					     ao_key ? tcp_ao_maclen(ao_key) : 0);
+			return NULL;
+		}
+#endif
+	} else {
+#ifdef CONFIG_TCP_MD5SIG
+		md5 = tcp_rsk(req)->af_specific->req_md5_lookup(sk,
+								req_to_sk(req));
+#endif
+	}
 	skb_set_hash(skb, tcp_rsk(req)->txhash, PKT_HASH_TYPE_L4);
 	/* bpf program will be interested in the tcp_flags */
 	TCP_SKB_CB(skb)->tcp_flags = TCPHDR_SYN | TCPHDR_ACK;
 	tcp_header_size = tcp_synack_options(sk, req, mss, skb, &opts, md5,
-					     NULL, foc, synack_type,
-					     syn_skb) + sizeof(*th);
+					     ao_key, foc, synack_type, syn_skb)
+					+ sizeof(*th);
 
 	skb_push(skb, tcp_header_size);
 	skb_reset_transport_header(skb);
@@ -3801,7 +3829,7 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 
 	/* RFC1323: The window in SYN & SYN/ACK segments is never scaled. */
 	th->window = htons(min(req->rsk_rcv_wnd, 65535U));
-	tcp_options_write(th, NULL, NULL, &opts, NULL);
+	tcp_options_write(th, NULL, tcp_rsk(req), &opts, ao_key);
 	th->doff = (tcp_header_size >> 2);
 	TCP_INC_STATS(sock_net(sk), TCP_MIB_OUTSEGS);
 
@@ -3809,7 +3837,15 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 	/* Okay, we have all we need - do the md5 hash if needed */
 	if (md5)
 		tcp_rsk(req)->af_specific->calc_md5_hash(opts.hash_location,
-					       md5, req_to_sk(req), skb);
+					md5, req_to_sk(req), skb);
+#endif
+#ifdef CONFIG_TCP_AO
+	if (ao_key)
+		tcp_rsk(req)->af_specific->ao_synack_hash(opts.hash_location,
+					ao_key, req, skb,
+					opts.hash_location - (u8 *)th, 0);
+#endif
+#if defined(CONFIG_TCP_MD5SIG) || defined(CONFIG_TCP_AO)
 	rcu_read_unlock();
 #endif
 
diff --git a/net/ipv6/tcp_ao.c b/net/ipv6/tcp_ao.c
index 65fa52f8c2e3..ec320781bc5c 100644
--- a/net/ipv6/tcp_ao.c
+++ b/net/ipv6/tcp_ao.c
@@ -133,3 +133,25 @@ int tcp_v6_parse_ao(struct sock *sk, int cmd,
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
index 367fa10c5e4d..1ef428d9f052 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -845,6 +845,7 @@ const struct tcp_request_sock_ops tcp_request_sock_ipv6_ops = {
 #ifdef CONFIG_TCP_AO
 	.ao_lookup	=	tcp_v6_ao_lookup_rsk,
 	.ao_calc_key	=	tcp_v6_ao_calc_key_rsk,
+	.ao_synack_hash =	tcp_v6_ao_synack_hash,
 #endif
 #ifdef CONFIG_SYN_COOKIES
 	.cookie_init_seq =	cookie_v6_init_sequence,
-- 
2.41.0

