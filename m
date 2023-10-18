Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E717CE99F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 23:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbjJRU7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 16:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232129AbjJRU7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 16:59:00 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3FFD5E
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 13:58:47 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-4083cd3917eso9073765e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 13:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1697662725; x=1698267525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tAQr0IaTlfLoyeWMGo6Za+WZwn+RFLOxENAPFnFYpTQ=;
        b=crEcC9QIrmZUdatPeyqpEZGzDEKv2JwSdKcbBlVHH+zLDtx+xkYzAZAPcVKCOny+w4
         26mHn8VSAu/iHGjoj/QDM0E7s1kLRcqdOjbIGLvQ/2zN0oJ9hLSXckYcT168Kiz16WoH
         Uz0Ocfsq1KnHVatfTFr82tI/exBSMwVOG3dEiYnx5DETWjPSwYo09W6axfUV1T4qCDSS
         37U91Q35PcphQ/ZIePbPqm3BkFMjsrqDsJWLcq5lGerAj9u/8ggl+a3yJ4QTPxdub4W1
         CcQzpUVGdFvHDwA0Vq2rbVuHFkUGkAVKCGAvkzV/SA3u7lS83/NOeXY5hWhnL/TSlXwe
         Ii0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697662725; x=1698267525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tAQr0IaTlfLoyeWMGo6Za+WZwn+RFLOxENAPFnFYpTQ=;
        b=lVyyL3oVezvNId9u8tzkPJLH5F780Iul1v0H4Hk8qCdf5m6QtUWlOguH8kVlIXQJ2b
         KPZUrLWtoeedmTlRbeNO9SGE/AKppVAkVgdn2lRtHNm8tlSpU+ORc3cxjT7BMM45y/zp
         Axfd8LLdaQ7gsw30qVQ5LCU1m9aNdMMWSFfqgrhErd+Sm0c9gRJ23GUvDlfcJWo8boJT
         BIW+FiIg6DV7+8prlYoTFjIzTGtYB8OkwlQo7nRiujd/Z3AVTiGJhTxb6F/GdmZkMEur
         07iXTuYbL8QTj2fZGmC8bczWxtPSKywKzX+sYsJZ9VzDCkntwyNtdEF5DGk4Wj5aba2o
         CumQ==
X-Gm-Message-State: AOJu0YyzRCcG5MOMB6MdWJVIPvGt8FZpn5VP0Qa/p4HdK0sEqp8s05yG
        XfQVdtmQR4+2Vc7FNnRlHwk5Ng==
X-Google-Smtp-Source: AGHT+IGcdA7r1Qm03GzZdMcGoaAPc5e5r8vTQs8sb8nJw4rT3MMcaOEe2EXP9NmOwuJuMmIOd2oRMA==
X-Received: by 2002:a05:600c:4fc1:b0:3fe:2b8c:9f0b with SMTP id o1-20020a05600c4fc100b003fe2b8c9f0bmr338691wmq.23.1697662724930;
        Wed, 18 Oct 2023 13:58:44 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x19-20020a05600c421300b003fc16ee2864sm2569006wmh.48.2023.10.18.13.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 13:58:44 -0700 (PDT)
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
Subject: [PATCH v15 net-next 15/23] net/tcp: Add tcp_hash_fail() ratelimited logs
Date:   Wed, 18 Oct 2023 21:57:29 +0100
Message-ID: <20231018205806.322831-16-dima@arista.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231018205806.322831-1-dima@arista.com>
References: <20231018205806.322831-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
index c65408483c21..ffbcc28a89b4 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2716,12 +2716,18 @@ tcp_inbound_hash(struct sock *sk, const struct request_sock *req,
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
@@ -2738,10 +2744,14 @@ tcp_inbound_hash(struct sock *sk, const struct request_sock *req,
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
index 0c3516d1b968..4da6e3657913 100644
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
index 7ae093751e47..0d47c4891de5 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4371,7 +4371,6 @@ tcp_inbound_md5_hash(const struct sock *sk, const struct sk_buff *skb,
 	 * o MD5 hash and we're not expecting one.
 	 * o MD5 hash and its wrong.
 	 */
-	const struct tcphdr *th = tcp_hdr(skb);
 	const struct tcp_sock *tp = tcp_sk(sk);
 	struct tcp_md5sig_key *key;
 	u8 newhash[16];
@@ -4381,6 +4380,7 @@ tcp_inbound_md5_hash(const struct sock *sk, const struct sk_buff *skb,
 
 	if (!key && hash_location) {
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5UNEXPECTED);
+		tcp_hash_fail("Unexpected MD5 Hash found", family, skb, "");
 		return SKB_DROP_REASON_TCP_MD5UNEXPECTED;
 	}
 
@@ -4396,16 +4396,19 @@ tcp_inbound_md5_hash(const struct sock *sk, const struct sk_buff *skb,
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
index 7e14bcd4dfd4..f76fcb93499d 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -800,6 +800,8 @@ tcp_ao_verify_hash(const struct sock *sk, const struct sk_buff *skb,
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPAOBAD);
 		atomic64_inc(&info->counters.pkt_bad);
 		atomic64_inc(&key->pkt_bad);
+		tcp_hash_fail("AO hash wrong length", family, skb,
+			      "%u != %d", maclen, tcp_ao_maclen(key));
 		return SKB_DROP_REASON_TCP_AOFAILURE;
 	}
 
@@ -814,6 +816,7 @@ tcp_ao_verify_hash(const struct sock *sk, const struct sk_buff *skb,
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPAOBAD);
 		atomic64_inc(&info->counters.pkt_bad);
 		atomic64_inc(&key->pkt_bad);
+		tcp_hash_fail("AO hash mismatch", family, skb, "");
 		kfree(hash_buf);
 		return SKB_DROP_REASON_TCP_AOFAILURE;
 	}
@@ -841,6 +844,8 @@ tcp_inbound_ao_hash(struct sock *sk, const struct sk_buff *skb,
 	info = rcu_dereference(tcp_sk(sk)->ao_info);
 	if (!info) {
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPAOKEYNOTFOUND);
+		tcp_hash_fail("AO key not found", family, skb,
+			      "keyid: %u", aoh->keyid);
 		return SKB_DROP_REASON_TCP_AOUNEXPECTED;
 	}
 
@@ -942,6 +947,8 @@ tcp_inbound_ao_hash(struct sock *sk, const struct sk_buff *skb,
 key_not_found:
 	NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPAOKEYNOTFOUND);
 	atomic64_inc(&info->counters.key_not_found);
+	tcp_hash_fail("Requested by the peer AO key id not found",
+		      family, skb, "");
 	return SKB_DROP_REASON_TCP_AOKEYNOTFOUND;
 }
 
-- 
2.42.0

