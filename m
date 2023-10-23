Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4896A7D4040
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 21:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjJWTZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 15:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbjJWTYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 15:24:53 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27061BC0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 12:23:08 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-4083740f92dso30482205e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 12:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1698088984; x=1698693784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Z5Vx8wsuYApYg+k2HPemPqD4zXPQfaLOK27W0kQOf8=;
        b=DADgZLlHTm+5ehmQ6erOyj8N+sZm7w3By9IdDS2spVbIkEM4A35b8xJwjzNGRXfUqx
         ODjNUfW3Klo6QxmjgvpSk26fcOSx9evP+FmSF19oJr3/Sve2Q2RGyGYTgN8A6wK8x0wz
         Lvq/Qgxa2R0ebF8tnbgLYMw2sqd7PNkkcTaK7aPQzYBe12/5xhS9Xj+i77XdYyCP8j6t
         5oTHgoEq9RB4fY0Rk8yJ5B3d+JjNYH3J/1u7pSQNqg7xn+5K6DFt6ySGPsXrnUt8C1Vh
         mcr+BOqIWtR8ellUJofdj5B/FGRbI8JN12gQNSBo1xOH633StaMdPsuHg4YVaDoyOUWP
         UIEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698088984; x=1698693784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Z5Vx8wsuYApYg+k2HPemPqD4zXPQfaLOK27W0kQOf8=;
        b=P7G8znzZk29ehtEiNPZiHt/GxPKPgWzWhDiWyjSfXWl4Zdyn1DFSK1kbSzHapNHBc4
         jGTVWc8voBAdWac1f6zFcjXeU3zbs3K400PbXMDf4dAz/9jBJymrurvxPRpZoBAldRy7
         Zz4eMAPnPEo7lu3jn2geAqwRaFVc0zqtv8bl6zD2bU6OnDM/YnTH/u5gze5yuO5XV6Fo
         uskRF0XPwv/chGSGNv+rnOmbJIHsE9VuBKlsrdj1ic4wZAFxTeb4D8piHYeYOAlpv5rj
         3SLAfqh97yhCLfdk25yfOQShoV1WC22mU4Pqb0VVERrNYWniR3NUQBM+wSQX6pdDwM1v
         JqbQ==
X-Gm-Message-State: AOJu0YzvD7GtlTH9332GNUhE8p3r9jrmTZSGL1P/W3qk1s52zu5Fmkdf
        l2lYhnpneUyZdx9T/03DK5XTPg==
X-Google-Smtp-Source: AGHT+IHPcP2t4eV+0sTVz7RWhIQUHOX8vJVOn0cU8TLqSg37K+ajr+PS0n6+Ykc30GngMq/5fkJAGA==
X-Received: by 2002:a05:600c:a07:b0:405:3251:47a1 with SMTP id z7-20020a05600c0a0700b00405325147a1mr7360481wmp.40.1698088984548;
        Mon, 23 Oct 2023 12:23:04 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id ay20-20020a05600c1e1400b00407460234f9sm10142088wmb.21.2023.10.23.12.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 12:23:04 -0700 (PDT)
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
Subject: [PATCH v16 net-next 20/23] net/tcp: Add static_key for TCP-AO
Date:   Mon, 23 Oct 2023 20:22:12 +0100
Message-ID: <20231023192217.426455-21-dima@arista.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023192217.426455-1-dima@arista.com>
References: <20231023192217.426455-1-dima@arista.com>
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
index c93ac6cc12c4..1635f0859ab5 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2286,14 +2286,18 @@ static inline void tcp_get_current_key(const struct sock *sk,
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
@@ -2322,7 +2326,8 @@ static inline bool tcp_key_is_md5(const struct tcp_key *key)
 static inline bool tcp_key_is_ao(const struct tcp_key *key)
 {
 #ifdef CONFIG_TCP_AO
-	if (key->type == TCP_KEY_AO)
+	if (static_branch_unlikely(&tcp_ao_needed.key) &&
+	    key->type == TCP_KEY_AO)
 		return true;
 #endif
 	return false;
@@ -2716,6 +2721,9 @@ static inline bool tcp_ao_required(struct sock *sk, const void *saddr,
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
index 8132577bdfba..232b20e2643c 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3571,41 +3571,55 @@ static inline bool tcp_may_update_window(const struct tcp_sock *tp,
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
index 8f98c58e2689..18c5595e3814 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1024,18 +1024,20 @@ static void tcp_v4_timewait_ack(struct sock *sk, struct sk_buff *skb)
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
@@ -1081,7 +1083,8 @@ static void tcp_v4_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
 					     tcp_sk(sk)->snd_nxt;
 
 #ifdef CONFIG_TCP_AO
-	if (tcp_rsk_used_ao(req)) {
+	if (static_branch_unlikely(&tcp_ao_needed.key) &&
+	    tcp_rsk_used_ao(req)) {
 		const union tcp_md5_addr *addr;
 		const struct tcp_ao_hdr *aoh;
 
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 2b8e87429e24..40af0a1a228d 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1154,17 +1154,19 @@ static void tcp_v6_timewait_ack(struct sock *sk, struct sk_buff *skb)
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
@@ -1206,7 +1208,8 @@ static void tcp_v6_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
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

