Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3E17CE9A6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 23:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344812AbjJRVAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 17:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235102AbjJRU7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 16:59:31 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE75194
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 13:58:56 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2c50d1b9f22so66684251fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 13:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1697662734; x=1698267534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ABsITpqDrmdixiT4z4IGPZGkOvDSrFQivG1FNx2HOkQ=;
        b=RIsrXtTXQvJtkhME0EEQYrmea9JE0cH64j8Y1Rbks+rsdkV7ycBTILV4w9+z9B8iC3
         /8kP7cCMpof13/J5FzWi7+ep4I0Maq8doM9g4DTAmaWJ5Re+fEB6o3uaJSaj2mH8tx8s
         L7fw3ecS0AOqfKjindiONGlZGoQJQR9CqEAfI9XpsDCIMlZX2WcsjN4B+ro0oLaolG6O
         QOw3Xo3yWOHyWV6+b1Ic70i1DV4cMrK3DQ4R/Qjq2RJud7kdLrz4AZtz+vE8avAB+Vbx
         pxiKObxXiILh3cr7e0lHyBzYaOeEfsqLFzvBAdYtGtU0sEzI9lxgwKUL/Fhbu1rPL31z
         wE4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697662734; x=1698267534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ABsITpqDrmdixiT4z4IGPZGkOvDSrFQivG1FNx2HOkQ=;
        b=GkYv/S7q+6auX+jrrYfbSEs/vs6LmxoaOCiKarn1Rrjz+Tw0cHmuNmoujii0MRizF7
         hWzKABJoi8cYVN1WswW6Hj6p2TIcAbGT1wm1s4dEA9sHewtuI4UAMFXVUK6WuNOHA3hn
         qQ+qvTaDBEE0YLZcTi2dBkSoEG/Wavfdd2y1bk8NwXLjgGwEtzKBBM2BqYHs7yMLt7XG
         VKD4uCa3kL5i48OS3VpJZKJloDQpvaO2XUA3VaGI9UhGY+PHv04Z0wBlK1UIyohCvOA0
         9cGQ4u8iJGdnrzMcKloK+nQWaegplHp/klTu6F/ZLdqZUj4wbJ0/U1mI+HECGFQeirQY
         PUcQ==
X-Gm-Message-State: AOJu0YxzXaG9yKshGBuJahPsdlDBL3mwig0C4njErF1JH/G/yixvzCgh
        Ip4wCnbQGqBe8rPNRoiYtbZfTA==
X-Google-Smtp-Source: AGHT+IH9yeNbIsmyDs5UHxeMp1hL3S0RN6VGQacl2Xga5If70R1mztGoT6KR1USWzRPsd7jz4XB+3A==
X-Received: by 2002:a05:651c:c5:b0:2c4:f768:c6ee with SMTP id 5-20020a05651c00c500b002c4f768c6eemr86862ljr.19.1697662734514;
        Wed, 18 Oct 2023 13:58:54 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x19-20020a05600c421300b003fc16ee2864sm2569006wmh.48.2023.10.18.13.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 13:58:53 -0700 (PDT)
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
Subject: [PATCH v15 net-next 20/23] net/tcp: Add static_key for TCP-AO
Date:   Wed, 18 Oct 2023 21:57:34 +0100
Message-ID: <20231018205806.322831-21-dima@arista.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231018205806.322831-1-dima@arista.com>
References: <20231018205806.322831-1-dima@arista.com>
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

Similarly to TCP-MD5, add a static key to TCP-AO that is patched out
when there are no keys on a machine and dynamically enabled with the
first setsockopt(TCP_AO) adds a key on any socket. The static key is as
well dynamically disabled later when the socket is destructed.

The lifetime of enabled static key here is the same as ao_info: it is
enabled on allocation, passed over from full socket to twsk and
destructed when ao_info is scheduled for destruction.

Signed-off-by: Dmitry Safonov <dima@arista.com>
Acked-by: David Ahern <dsahern@kernel.org>
---
 include/net/tcp.h    | 24 +++++++++++++++--------
 include/net/tcp_ao.h |  2 ++
 net/ipv4/tcp_ao.c    | 22 +++++++++++++++++++++
 net/ipv4/tcp_input.c | 46 +++++++++++++++++++++++++++++---------------
 net/ipv4/tcp_ipv4.c  | 25 +++++++++++++-----------
 net/ipv6/tcp_ipv6.c  | 25 +++++++++++++-----------
 6 files changed, 98 insertions(+), 46 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index ffbcc28a89b4..942628c3566a 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2256,14 +2256,18 @@ static inline void tcp_get_current_key(const struct sock *sk,
 #if defined(CONFIG_TCP_AO) || defined(CONFIG_TCP_MD5SIG)
 	const struct tcp_sock *tp = tcp_sk(sk);
 #endif
-#ifdef CONFIG_TCP_AO
-	struct tcp_ao_info *ao;
 
-	ao = rcu_dereference_protected(tp->ao_info, lockdep_sock_is_held(sk));
-	if (ao) {
-		out->ao_key = READ_ONCE(ao->current_key);
-		out->type = TCP_KEY_AO;
-		return;
+#ifdef CONFIG_TCP_AO
+	if (static_branch_unlikely(&tcp_ao_needed.key)) {
+		struct tcp_ao_info *ao;
+
+		ao = rcu_dereference_protected(tp->ao_info,
+					       lockdep_sock_is_held(sk));
+		if (ao) {
+			out->ao_key = READ_ONCE(ao->current_key);
+			out->type = TCP_KEY_AO;
+			return;
+		}
 	}
 #endif
 #ifdef CONFIG_TCP_MD5SIG
@@ -2292,7 +2296,8 @@ static inline bool tcp_key_is_md5(const struct tcp_key *key)
 static inline bool tcp_key_is_ao(const struct tcp_key *key)
 {
 #ifdef CONFIG_TCP_AO
-	if (key->type == TCP_KEY_AO)
+	if (static_branch_unlikely(&tcp_ao_needed.key) &&
+	    key->type == TCP_KEY_AO)
 		return true;
 #endif
 	return false;
@@ -2686,6 +2691,9 @@ static inline bool tcp_ao_required(struct sock *sk, const void *saddr,
 	struct tcp_ao_info *ao_info;
 	struct tcp_ao_key *ao_key;
 
+	if (!static_branch_unlikely(&tcp_ao_needed.key))
+		return false;
+
 	ao_info = rcu_dereference_check(tcp_sk(sk)->ao_info,
 					lockdep_sock_is_held(sk));
 	if (!ao_info)
diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
index 061c358a3c8a..a38408072ea8 100644
--- a/include/net/tcp_ao.h
+++ b/include/net/tcp_ao.h
@@ -151,6 +151,8 @@ do {									\
 
 #ifdef CONFIG_TCP_AO
 /* TCP-AO structures and functions */
+#include <linux/jump_label.h>
+extern struct static_key_false_deferred tcp_ao_needed;
 
 struct tcp4_ao_context {
 	__be32		saddr;
diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index acbeb635fe29..ffce8ca60ff2 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -17,6 +17,8 @@
 #include <net/ipv6.h>
 #include <net/icmp.h>
 
+DEFINE_STATIC_KEY_DEFERRED_FALSE(tcp_ao_needed, HZ);
+
 int tcp_ao_calc_traffic_key(struct tcp_ao_key *mkt, u8 *key, void *ctx,
 			    unsigned int len, struct tcp_sigpool *hp)
 {
@@ -50,6 +52,9 @@ bool tcp_ao_ignore_icmp(const struct sock *sk, int family, int type, int code)
 	bool ignore_icmp = false;
 	struct tcp_ao_info *ao;
 
+	if (!static_branch_unlikely(&tcp_ao_needed.key))
+		return false;
+
 	/* RFC5925, 7.8:
 	 * >> A TCP-AO implementation MUST default to ignore incoming ICMPv4
 	 * messages of Type 3 (destination unreachable), Codes 2-4 (protocol
@@ -185,6 +190,9 @@ static struct tcp_ao_key *__tcp_ao_do_lookup(const struct sock *sk,
 	struct tcp_ao_key *key;
 	struct tcp_ao_info *ao;
 
+	if (!static_branch_unlikely(&tcp_ao_needed.key))
+		return NULL;
+
 	ao = rcu_dereference_check(tcp_sk(sk)->ao_info,
 				   lockdep_sock_is_held(sk));
 	if (!ao)
@@ -276,6 +284,7 @@ void tcp_ao_destroy_sock(struct sock *sk, bool twsk)
 	}
 
 	kfree_rcu(ao, rcu);
+	static_branch_slow_dec_deferred(&tcp_ao_needed);
 }
 
 void tcp_ao_time_wait(struct tcp_timewait_sock *tcptw, struct tcp_sock *tp)
@@ -1180,6 +1189,11 @@ int tcp_ao_copy_all_matching(const struct sock *sk, struct sock *newsk,
 		goto free_and_exit;
 	}
 
+	if (!static_key_fast_inc_not_disabled(&tcp_ao_needed.key.key)) {
+		ret = -EUSERS;
+		goto free_and_exit;
+	}
+
 	key_head = rcu_dereference(hlist_first_rcu(&new_ao->head));
 	first_key = hlist_entry_safe(key_head, struct tcp_ao_key, node);
 
@@ -1607,6 +1621,10 @@ static int tcp_ao_add_cmd(struct sock *sk, unsigned short int family,
 
 	tcp_ao_link_mkt(ao_info, key);
 	if (first) {
+		if (!static_branch_inc(&tcp_ao_needed.key)) {
+			ret = -EUSERS;
+			goto err_free_sock;
+		}
 		sk_gso_disable(sk);
 		rcu_assign_pointer(tcp_sk(sk)->ao_info, ao_info);
 	}
@@ -1875,6 +1893,10 @@ static int tcp_ao_info_cmd(struct sock *sk, unsigned short int family,
 	if (new_rnext)
 		WRITE_ONCE(ao_info->rnext_key, new_rnext);
 	if (first) {
+		if (!static_branch_inc(&tcp_ao_needed.key)) {
+			err = -EUSERS;
+			goto out;
+		}
 		sk_gso_disable(sk);
 		rcu_assign_pointer(tcp_sk(sk)->ao_info, ao_info);
 	}
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 17584ac9f553..6a7da1cacbbd 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3566,41 +3566,55 @@ static inline bool tcp_may_update_window(const struct tcp_sock *tp,
 		(ack_seq == tp->snd_wl1 && (nwin > tp->snd_wnd || !nwin));
 }
 
-/* If we update tp->snd_una, also update tp->bytes_acked */
-static void tcp_snd_una_update(struct tcp_sock *tp, u32 ack)
+static void tcp_snd_sne_update(struct tcp_sock *tp, u32 ack)
 {
-	u32 delta = ack - tp->snd_una;
 #ifdef CONFIG_TCP_AO
 	struct tcp_ao_info *ao;
-#endif
 
-	sock_owned_by_me((struct sock *)tp);
-	tp->bytes_acked += delta;
-#ifdef CONFIG_TCP_AO
+	if (!static_branch_unlikely(&tcp_ao_needed.key))
+		return;
+
 	ao = rcu_dereference_protected(tp->ao_info,
 				       lockdep_sock_is_held((struct sock *)tp));
 	if (ao && ack < tp->snd_una)
 		ao->snd_sne++;
 #endif
+}
+
+/* If we update tp->snd_una, also update tp->bytes_acked */
+static void tcp_snd_una_update(struct tcp_sock *tp, u32 ack)
+{
+	u32 delta = ack - tp->snd_una;
+
+	sock_owned_by_me((struct sock *)tp);
+	tp->bytes_acked += delta;
+	tcp_snd_sne_update(tp, ack);
 	tp->snd_una = ack;
 }
 
+static void tcp_rcv_sne_update(struct tcp_sock *tp, u32 seq)
+{
+#ifdef CONFIG_TCP_AO
+	struct tcp_ao_info *ao;
+
+	if (!static_branch_unlikely(&tcp_ao_needed.key))
+		return;
+
+	ao = rcu_dereference_protected(tp->ao_info,
+				       lockdep_sock_is_held((struct sock *)tp));
+	if (ao && seq < tp->rcv_nxt)
+		ao->rcv_sne++;
+#endif
+}
+
 /* If we update tp->rcv_nxt, also update tp->bytes_received */
 static void tcp_rcv_nxt_update(struct tcp_sock *tp, u32 seq)
 {
 	u32 delta = seq - tp->rcv_nxt;
-#ifdef CONFIG_TCP_AO
-	struct tcp_ao_info *ao;
-#endif
 
 	sock_owned_by_me((struct sock *)tp);
 	tp->bytes_received += delta;
-#ifdef CONFIG_TCP_AO
-	ao = rcu_dereference_protected(tp->ao_info,
-				       lockdep_sock_is_held((struct sock *)tp));
-	if (ao && seq < tp->rcv_nxt)
-		ao->rcv_sne++;
-#endif
+	tcp_rcv_sne_update(tp, seq);
 	WRITE_ONCE(tp->rcv_nxt, seq);
 }
 
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 8e2306f48d22..4bef91cd3996 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1023,18 +1023,20 @@ static void tcp_v4_timewait_ack(struct sock *sk, struct sk_buff *skb)
 #ifdef CONFIG_TCP_AO
 	struct tcp_ao_info *ao_info;
 
-	/* FIXME: the segment to-be-acked is not verified yet */
-	ao_info = rcu_dereference(tcptw->ao_info);
-	if (ao_info) {
-		const struct tcp_ao_hdr *aoh;
+	if (static_branch_unlikely(&tcp_ao_needed.key)) {
+		/* FIXME: the segment to-be-acked is not verified yet */
+		ao_info = rcu_dereference(tcptw->ao_info);
+		if (ao_info) {
+			const struct tcp_ao_hdr *aoh;
 
-		if (tcp_parse_auth_options(tcp_hdr(skb), NULL, &aoh)) {
-			inet_twsk_put(tw);
-			return;
+			if (tcp_parse_auth_options(tcp_hdr(skb), NULL, &aoh)) {
+				inet_twsk_put(tw);
+				return;
+			}
+
+			if (aoh)
+				key.ao_key = tcp_ao_established_key(ao_info, aoh->rnext_keyid, -1);
 		}
-
-		if (aoh)
-			key.ao_key = tcp_ao_established_key(ao_info, aoh->rnext_keyid, -1);
 	}
 	if (key.ao_key) {
 		struct tcp_ao_key *rnext_key;
@@ -1080,7 +1082,8 @@ static void tcp_v4_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
 					     tcp_sk(sk)->snd_nxt;
 
 #ifdef CONFIG_TCP_AO
-	if (tcp_rsk_used_ao(req)) {
+	if (static_branch_unlikely(&tcp_ao_needed.key) &&
+	    tcp_rsk_used_ao(req)) {
 		const union tcp_md5_addr *addr;
 		const struct tcp_ao_hdr *aoh;
 
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index cfaf7436d63e..4c9723dc1e66 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1153,17 +1153,19 @@ static void tcp_v6_timewait_ack(struct sock *sk, struct sk_buff *skb)
 #ifdef CONFIG_TCP_AO
 	struct tcp_ao_info *ao_info;
 
-	/* FIXME: the segment to-be-acked is not verified yet */
-	ao_info = rcu_dereference(tcptw->ao_info);
-	if (ao_info) {
-		const struct tcp_ao_hdr *aoh;
+	if (static_branch_unlikely(&tcp_ao_needed.key)) {
 
-		/* Invalid TCP option size or twice included auth */
-		if (tcp_parse_auth_options(tcp_hdr(skb), NULL, &aoh))
-			goto out;
-		if (aoh) {
-			key.ao_key = tcp_ao_established_key(ao_info,
-							    aoh->rnext_keyid, -1);
+		/* FIXME: the segment to-be-acked is not verified yet */
+		ao_info = rcu_dereference(tcptw->ao_info);
+		if (ao_info) {
+			const struct tcp_ao_hdr *aoh;
+
+			/* Invalid TCP option size or twice included auth */
+			if (tcp_parse_auth_options(tcp_hdr(skb), NULL, &aoh))
+				goto out;
+			if (aoh)
+				key.ao_key = tcp_ao_established_key(ao_info,
+						aoh->rnext_keyid, -1);
 		}
 	}
 	if (key.ao_key) {
@@ -1205,7 +1207,8 @@ static void tcp_v6_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
 	struct tcp_key key = {};
 
 #ifdef CONFIG_TCP_AO
-	if (tcp_rsk_used_ao(req)) {
+	if (static_branch_unlikely(&tcp_ao_needed.key) &&
+	    tcp_rsk_used_ao(req)) {
 		const struct in6_addr *addr = &ipv6_hdr(skb)->saddr;
 		const struct tcp_ao_hdr *aoh;
 		int l3index;
-- 
2.42.0

