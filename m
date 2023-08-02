Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46CFC76D542
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbjHBR3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbjHBR2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:28:01 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9665D35BB
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 10:27:34 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fe1a17f983so985515e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 10:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1690997250; x=1691602050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7lKd7+TcTfrlL29ke6rvn+ktPGtCOArYP+hd7EaQtmY=;
        b=Tujs5615j8HhkOBkDIA2b3YkXuncmNrnN3em/KXSi01Z4rv2nqUzp6ltKvui7ORwWX
         xO8G/9j6lit/h9UlcsyVYSVqbfsyW8wci9JrNrn686OTZc3MyDSV+DAPtar+JA2xKkMp
         2wh3JWu2YSghGtswSSbHZKJTF72pF43ILO95eqcIElRTu7Lv+I1lnEy4vdBiDvRBiKtR
         a1VCUfsbXMQMWIj+HGiiX0pdNw1m0Bkf/N6bPsh3mhTwZLPj7iKL8JNchvEqRezUWM0b
         x+vvOsBG2USQIcK5J2GUzhbgdjjOsqA9ZmYsv0IQWOoTOXlDKx1zSCo2MagaT36fDOho
         SyRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690997250; x=1691602050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7lKd7+TcTfrlL29ke6rvn+ktPGtCOArYP+hd7EaQtmY=;
        b=DuiyrsNr89lQg/Vgi5d98iy8uHI4poKfN/3AEUTWbjVPvCNT8o9i3tXke8mRNsUQND
         0U/o3NwttkXMLaf9rdAHvi845kQ5uiBsoChk5G5ddxxh45NAT5pZo6Du/3lSTfeCyQJb
         Z6b9eR1hdhBKRPmy0XwNTIHGqv9diLYYx7euBovQPM2+dvKUZO8NFCYoBoxXofCHypo4
         LSiZOLjFGJEGMYg+5vPw67lbZpLimFvjV3CQD5mCT3EiuTBbjxMY0plPQp7OQwJiVSpL
         z/KrGfE3wRgR60f3l+7qiiyZCHLPv6gk/WuFvZNkAs3zMHGQDd3kfRByVYBeirxbWLVq
         LrWA==
X-Gm-Message-State: ABy/qLYck7K5ySGdI04nh+MGwW/qZdmVrVWDV1jf1vPLbexXqEJLWkQ2
        pJqlV5tWt3CIr8xsNwKRPixVog==
X-Google-Smtp-Source: APBJJlFmOP4N9+o79ixJruM2/piuQYPjSZ++47iQl+/xq7bMr8R+zQqNYIFSxUW1Zw96GKS57y567g==
X-Received: by 2002:a7b:c84d:0:b0:3fb:ab56:a66c with SMTP id c13-20020a7bc84d000000b003fbab56a66cmr5071900wml.10.1690997250007;
        Wed, 02 Aug 2023 10:27:30 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id q5-20020a1ce905000000b003fbc0a49b57sm2221770wmc.6.2023.08.02.10.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 10:27:29 -0700 (PDT)
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
Subject: [PATCH v9 net-next 15/23] net/tcp: Add tcp_hash_fail() ratelimited logs
Date:   Wed,  2 Aug 2023 18:26:42 +0100
Message-ID: <20230802172654.1467777-16-dima@arista.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802172654.1467777-1-dima@arista.com>
References: <20230802172654.1467777-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a helper for logging connection-detailed messages for failed TCP
hash verification (both MD5 and AO).

Co-developed-by: Francesco Ruggeri <fruggeri@arista.com>
Signed-off-by: Francesco Ruggeri <fruggeri@arista.com>
Co-developed-by: Salam Noureddine <noureddine@arista.com>
Signed-off-by: Salam Noureddine <noureddine@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
Acked-by: David Ahern <dsahern@kernel.org>
---
 include/net/tcp.h    | 14 ++++++++++++--
 include/net/tcp_ao.h | 29 +++++++++++++++++++++++++++++
 net/ipv4/tcp.c       | 23 +++++++++++++----------
 net/ipv4/tcp_ao.c    |  7 +++++++
 4 files changed, 61 insertions(+), 12 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index a71e6a6f5192..85e0f0b50261 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2642,12 +2642,18 @@ tcp_inbound_hash(struct sock *sk, const struct request_sock *req,
 	int l3index;
 
 	/* Invalid option or two times meet any of auth options */
-	if (tcp_parse_auth_options(th, &md5_location, &aoh))
+	if (tcp_parse_auth_options(th, &md5_location, &aoh)) {
+		tcp_hash_fail("TCP segment has incorrect auth options set",
+			      family, skb, "");
 		return SKB_DROP_REASON_TCP_AUTH_HDR;
+	}
 
 	if (req) {
 		if (tcp_rsk_used_ao(req) != !!aoh) {
 			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPAOBAD);
+			tcp_hash_fail("TCP connection can't start/end using TCP-AO",
+				      family, skb, "%s",
+				      !aoh ? "missing AO" : "AO signed");
 			return SKB_DROP_REASON_TCP_AOFAILURE;
 		}
 	}
@@ -2664,10 +2670,14 @@ tcp_inbound_hash(struct sock *sk, const struct request_sock *req,
 		 * the last key is impossible to remove, so there's
 		 * always at least one current_key.
 		 */
-		if (tcp_ao_required(sk, saddr, family, true))
+		if (tcp_ao_required(sk, saddr, family, true)) {
+			tcp_hash_fail("AO hash is required, but not found",
+					family, skb, "L3 index %d", l3index);
 			return SKB_DROP_REASON_TCP_AONOTFOUND;
+		}
 		if (unlikely(tcp_md5_do_lookup(sk, l3index, saddr, family))) {
 			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5NOTFOUND);
+			tcp_hash_fail("MD5 Hash not found", family, skb, "");
 			return SKB_DROP_REASON_TCP_MD5NOTFOUND;
 		}
 		return SKB_NOT_DROPPED_YET;
diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
index d295ea1b6cb7..986e8dcbb150 100644
--- a/include/net/tcp_ao.h
+++ b/include/net/tcp_ao.h
@@ -118,6 +118,35 @@ struct tcp_ao_info {
 	struct rcu_head		rcu;
 };
 
+#define tcp_hash_fail(msg, family, skb, fmt, ...)			\
+do {									\
+	const struct tcphdr *th = tcp_hdr(skb);				\
+	char hdr_flags[5] = {};						\
+	char *f = hdr_flags;						\
+									\
+	if (th->fin)							\
+		*f++ = 'F';						\
+	if (th->syn)							\
+		*f++ = 'S';						\
+	if (th->rst)							\
+		*f++ = 'R';						\
+	if (th->ack)							\
+		*f++ = 'A';						\
+	if (f != hdr_flags)						\
+		*f = ' ';						\
+	if ((family) == AF_INET) {					\
+		net_info_ratelimited("%s for (%pI4, %d)->(%pI4, %d) %s" fmt "\n", \
+				msg, &ip_hdr(skb)->saddr, ntohs(th->source), \
+				&ip_hdr(skb)->daddr, ntohs(th->dest),	\
+				hdr_flags, ##__VA_ARGS__);		\
+	} else {							\
+		net_info_ratelimited("%s for [%pI6c]:%u->[%pI6c]:%u %s" fmt "\n", \
+				msg, &ipv6_hdr(skb)->saddr, ntohs(th->source), \
+				&ipv6_hdr(skb)->daddr, ntohs(th->dest),	\
+				hdr_flags, ##__VA_ARGS__);		\
+	}								\
+} while (0)
+
 #ifdef CONFIG_TCP_AO
 /* TCP-AO structures and functions */
 
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index c62eafe74f49..c9c183550a96 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4382,7 +4382,6 @@ tcp_inbound_md5_hash(const struct sock *sk, const struct sk_buff *skb,
 	 * o MD5 hash and we're not expecting one.
 	 * o MD5 hash and its wrong.
 	 */
-	const struct tcphdr *th = tcp_hdr(skb);
 	const struct tcp_sock *tp = tcp_sk(sk);
 	struct tcp_md5sig_key *key;
 	u8 newhash[16];
@@ -4392,6 +4391,7 @@ tcp_inbound_md5_hash(const struct sock *sk, const struct sk_buff *skb,
 
 	if (!key && hash_location) {
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5UNEXPECTED);
+		tcp_hash_fail("Unexpected MD5 Hash found", family, skb, "");
 		return SKB_DROP_REASON_TCP_MD5UNEXPECTED;
 	}
 
@@ -4407,16 +4407,19 @@ tcp_inbound_md5_hash(const struct sock *sk, const struct sk_buff *skb,
 	if (genhash || memcmp(hash_location, newhash, 16) != 0) {
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5FAILURE);
 		if (family == AF_INET) {
-			net_info_ratelimited("MD5 Hash failed for (%pI4, %d)->(%pI4, %d)%s L3 index %d\n",
-					saddr, ntohs(th->source),
-					daddr, ntohs(th->dest),
-					genhash ? " tcp_v4_calc_md5_hash failed"
-					: "", l3index);
+			tcp_hash_fail("MD5 Hash failed", AF_INET, skb, "%s L3 index %d",
+				      genhash ? "tcp_v4_calc_md5_hash failed"
+				      : "", l3index);
 		} else {
-			net_info_ratelimited("MD5 Hash %s for [%pI6c]:%u->[%pI6c]:%u L3 index %d\n",
-					genhash ? "failed" : "mismatch",
-					saddr, ntohs(th->source),
-					daddr, ntohs(th->dest), l3index);
+			if (genhash) {
+				tcp_hash_fail("MD5 Hash failed",
+					      AF_INET6, skb, "L3 index %d",
+					      l3index);
+			} else {
+				tcp_hash_fail("MD5 Hash mismatch",
+					      AF_INET6, skb, "L3 index %d",
+					      l3index);
+			}
 		}
 		return SKB_DROP_REASON_TCP_MD5FAILURE;
 	}
diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index 21a711bf6921..226dcefb426a 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -765,6 +765,8 @@ tcp_ao_verify_hash(const struct sock *sk, const struct sk_buff *skb,
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPAOBAD);
 		atomic64_inc(&info->counters.pkt_bad);
 		atomic64_inc(&key->pkt_bad);
+		tcp_hash_fail("AO hash wrong length", family, skb,
+			      "%u != %d", maclen, tcp_ao_maclen(key));
 		return SKB_DROP_REASON_TCP_AOFAILURE;
 	}
 
@@ -779,6 +781,7 @@ tcp_ao_verify_hash(const struct sock *sk, const struct sk_buff *skb,
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPAOBAD);
 		atomic64_inc(&info->counters.pkt_bad);
 		atomic64_inc(&key->pkt_bad);
+		tcp_hash_fail("AO hash mismatch", family, skb, "");
 		kfree(hash_buf);
 		return SKB_DROP_REASON_TCP_AOFAILURE;
 	}
@@ -806,6 +809,8 @@ tcp_inbound_ao_hash(struct sock *sk, const struct sk_buff *skb,
 	info = rcu_dereference(tcp_sk(sk)->ao_info);
 	if (!info) {
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPAOKEYNOTFOUND);
+		tcp_hash_fail("AO key not found", family, skb,
+			      "keyid: %u", aoh->keyid);
 		return SKB_DROP_REASON_TCP_AOUNEXPECTED;
 	}
 
@@ -908,6 +913,8 @@ tcp_inbound_ao_hash(struct sock *sk, const struct sk_buff *skb,
 key_not_found:
 	NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPAOKEYNOTFOUND);
 	atomic64_inc(&info->counters.key_not_found);
+	tcp_hash_fail("Requested by the peer AO key id not found",
+		      family, skb, "");
 	return SKB_DROP_REASON_TCP_AOKEYNOTFOUND;
 }
 
-- 
2.41.0

