Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F75079C2AB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237491AbjILCXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237215AbjILCXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:23:24 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5D713AF12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 18:47:17 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99c1d03e124so628453266b.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 18:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1694483236; x=1695088036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LBCs9GrljB/d271+d8dZbdlIHkK+9yQX+LQGkQ3IMdE=;
        b=NahwtDG0UD8HmuO2vNhXxsUKZKkI9QfeVNEbbgTqUPsEbDlT+CTGdeizlyJb+7K9Nw
         Qj4uqHtOVlaM2YXjjsuBqOUM1P8DGoukPRexWrovwxC37cQvWP/u+21l0CkWZR7kCle5
         8Am5/pLzXPlyy2rASMhjkhp71RM1oEsS7jLj7n6EZL3tMdTWMwhjQ8B6bL4tItCg2zgK
         FLdkv4iKomkxO4C7MzBviE7VER8f8zys4PtIFOU5l48zd+ML99Aiz03bkZE1skQkyO2M
         bKvz2gxUV73jzNL9+orqe4asiJNI4mlOShAIhSoKWaNkdgtAEXOh1OSjW6FYdnQbE4d3
         fGXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694483236; x=1695088036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LBCs9GrljB/d271+d8dZbdlIHkK+9yQX+LQGkQ3IMdE=;
        b=E9x0uc1pT7eKle5a5G24h2AIP2Gw83ckPKpVo6xAFuaNJO4PeNC4Ll61SMNbYpWbBO
         OoSU1jGFSU7ehGogjDkX89F1N6ygZvmPXhpf9ACZpSEPpH1RPB9XovdD9PaRR3DiadFb
         nrIj8yjX5pKfFRK+7MXVx9NwW6aGPYsb6fagjNdF2X8ko4oFoYSXvX/Ckin/ZMSGSfki
         +D6SxjQF0HFlXKh9GefXtliHnjaIRgLjZGk/AffyDMXdnArXWE0kpVJr37IrX8UoOKEt
         2p5GPLFRW1GwfA8XrwFCpwb8DiuhCgL++Z22yjhevwAPol8SWxpoiZtdZAzdwoopeYFO
         mtZA==
X-Gm-Message-State: AOJu0Yzj9gParBuS28KRsGV0ejwrGOZhnIgG7yW/kbRZ39cNfs5If6Rh
        FFQAeR0K/65UtLEzGwbNpy0mivm7eLhrcDJXCc0=
X-Google-Smtp-Source: AGHT+IFYupHTFh5woc8QBUpXS11rzTn+NeEuJmUUL/sZXL43C04GtjDkn8MrbdsL0dBOAqqGOo7jng==
X-Received: by 2002:a05:600c:d5:b0:402:8c7b:ceea with SMTP id u21-20020a05600c00d500b004028c7bceeamr8894362wmm.30.1694466255213;
        Mon, 11 Sep 2023 14:04:15 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id z20-20020a1c4c14000000b00402e942561fsm14261699wmf.38.2023.09.11.14.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 14:04:14 -0700 (PDT)
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
Subject: [PATCH v11 net-next 11/23] net/tcp: Sign SYN-ACK segments with TCP-AO
Date:   Mon, 11 Sep 2023 22:03:31 +0100
Message-ID: <20230911210346.301750-12-dima@arista.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911210346.301750-1-dima@arista.com>
References: <20230911210346.301750-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 include/net/tcp.h     |  3 +++
 include/net/tcp_ao.h  |  6 +++++
 net/ipv4/tcp_ao.c     | 22 +++++++++++++++++
 net/ipv4/tcp_ipv4.c   |  1 +
 net/ipv4/tcp_output.c | 57 ++++++++++++++++++++++++++++++++++++++-----
 net/ipv6/tcp_ao.c     | 22 +++++++++++++++++
 net/ipv6/tcp_ipv6.c   |  1 +
 7 files changed, 106 insertions(+), 6 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 5daa2e98e6a3..56f4180443c7 100644
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
index 9a4ffcc965f3..c40da33d988b 100644
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
index 44c97e6ddd50..c9d6decef443 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -900,6 +900,7 @@ static unsigned int tcp_synack_options(const struct sock *sk,
 				       unsigned int mss, struct sk_buff *skb,
 				       struct tcp_out_options *opts,
 				       const struct tcp_md5sig_key *md5,
+				       const struct tcp_ao_key *ao,
 				       struct tcp_fastopen_cookie *foc,
 				       enum tcp_synack_type synack_type,
 				       struct sk_buff *syn_skb)
@@ -921,6 +922,14 @@ static unsigned int tcp_synack_options(const struct sock *sk,
 			ireq->tstamp_ok &= !ireq->sack_ok;
 	}
 #endif
+#ifdef CONFIG_TCP_AO
+	if (ao) {
+		opts->options |= OPTION_AO;
+		remaining -= tcp_ao_len(ao);
+		ireq->tstamp_ok &= !ireq->sack_ok;
+	}
+#endif
+	WARN_ON_ONCE(md5 && ao);
 
 	/* We always send an MSS option. */
 	opts->mss = mss;
@@ -3727,6 +3736,7 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 	struct inet_request_sock *ireq = inet_rsk(req);
 	const struct tcp_sock *tp = tcp_sk(sk);
 	struct tcp_md5sig_key *md5 = NULL;
+	struct tcp_ao_key *ao_key = NULL;
 	struct tcp_out_options opts;
 	struct sk_buff *skb;
 	int tcp_header_size;
@@ -3777,16 +3787,43 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
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
 	skb_set_hash(skb, READ_ONCE(tcp_rsk(req)->txhash), PKT_HASH_TYPE_L4);
 	/* bpf program will be interested in the tcp_flags */
 	TCP_SKB_CB(skb)->tcp_flags = TCPHDR_SYN | TCPHDR_ACK;
 	tcp_header_size = tcp_synack_options(sk, req, mss, skb, &opts, md5,
-					     foc, synack_type,
-					     syn_skb) + sizeof(*th);
+					     ao_key, foc, synack_type, syn_skb)
+					+ sizeof(*th);
 
 	skb_push(skb, tcp_header_size);
 	skb_reset_transport_header(skb);
@@ -3806,7 +3843,7 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 
 	/* RFC1323: The window in SYN & SYN/ACK segments is never scaled. */
 	th->window = htons(min(req->rsk_rcv_wnd, 65535U));
-	tcp_options_write(th, NULL, NULL, &opts, NULL);
+	tcp_options_write(th, NULL, tcp_rsk(req), &opts, ao_key);
 	th->doff = (tcp_header_size >> 2);
 	TCP_INC_STATS(sock_net(sk), TCP_MIB_OUTSEGS);
 
@@ -3814,7 +3851,15 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
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
index c060cd964f91..f57617d2921a 100644
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

