Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F6379C2A8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237380AbjILCWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235801AbjILCV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:21:57 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42F4161263
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 18:45:32 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-31427ddd3fbso4772734f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 18:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1694483131; x=1695087931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GupC7voHRJj5BwYpmyculQw3S+0sXKYYh1pK7zudlg4=;
        b=Sx1PvQ5rbjKa97IwPo5yz4eoc9DZsnMHnCJmS6LUeHNNkIxkZQEg0G3k5TwI73kChG
         nWGRPJXMF2su6KbkQOSSwnOIDSDScprOij/RrsKBVtDMy63VQAJ1jNbDiIj0RDZMWK5B
         okXYNdCrsqqfkDQw1cy7uieunGvFDXzyZXX3nfK47T3LAYbeaNaQOHYk/VLpwmxrUzdu
         dqsYOT9cgJeulhb70VcfKLCEjk9ex5ais+SRkJ6sOV520LZ61IIKf4EdGWsP4rqsnWpW
         VJ0kuKHuRWlW46Uso5EkNd6BNguvz8QurUimzVxFn51+JdqjIL14Q7A6nrkYdvYKx4pb
         K4cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694483131; x=1695087931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GupC7voHRJj5BwYpmyculQw3S+0sXKYYh1pK7zudlg4=;
        b=hngEXp7jaZ80UJ0iE0hV08Q7VsvAlSz1+tFzCRP8zFqOLjVTF06GXWh273g74XR3sw
         M/k9ik5kQ5jEtLjoCCPes4EUNu6vCYlClzLkDOPv6QHdnNg/T8AFNudBASJmCIHRXHj/
         5Sh8O/BDiNfP+7Qy6x+jp4ug7c4Boy1e2JHEARx7WH33lpXleexOiqdGUbf6B5PTJpEl
         uKZessapkToucVnHzZWIEiHDc/XhTq3pft2jfbUm8JUzy0TmBnbt23fDhYpJfHVb23lN
         BTpTL+ZLqns9CL0qO+WHrteUmaymnfRdEeYSYvipptgJXfq8/oXIIbUe7bkZpppqBe0S
         UStw==
X-Gm-Message-State: AOJu0YxUZ6NgUnvzCHtEUQ2f9WKFtqfXeubLGOG5QMJ67z4sCe4vI/rG
        owJl6fS6S2ANKPyZ6LGi+vZH7rT+QkLLQYiepQs=
X-Google-Smtp-Source: AGHT+IEbvNZsQwqvkJHH1HayQF3cAA5oOwxVxzDO9gZt/4Z1E+lnSu17TM9l/tmGGefnqQ1ax7DZQQ==
X-Received: by 2002:a1c:7917:0:b0:402:e68f:8898 with SMTP id l23-20020a1c7917000000b00402e68f8898mr8724677wme.0.1694466271877;
        Mon, 11 Sep 2023 14:04:31 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id z20-20020a1c4c14000000b00402e942561fsm14261699wmf.38.2023.09.11.14.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 14:04:31 -0700 (PDT)
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
Subject: [PATCH v11 net-next 20/23] net/tcp: Add static_key for TCP-AO
Date:   Mon, 11 Sep 2023 22:03:40 +0100
Message-ID: <20230911210346.301750-21-dima@arista.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911210346.301750-1-dima@arista.com>
References: <20230911210346.301750-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 include/net/tcp.h    |  3 +++
 include/net/tcp_ao.h |  2 ++
 net/ipv4/tcp_ao.c    | 22 +++++++++++++++++++++
 net/ipv4/tcp_input.c | 46 +++++++++++++++++++++++++++++---------------
 4 files changed, 57 insertions(+), 16 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index ac5f96f0ce19..fa100e4f2cde 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2611,6 +2611,9 @@ static inline bool tcp_ao_required(struct sock *sk, const void *saddr,
 	struct tcp_ao_info *ao_info;
 	struct tcp_ao_key *ao_key;
 
+	if (!static_branch_unlikely(&tcp_ao_needed.key))
+		return false;
+
 	ao_info = rcu_dereference_check(tcp_sk(sk)->ao_info,
 					lockdep_sock_is_held(sk));
 	if (!ao_info)
diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
index 09cf9d216b3a..b97e1b3c6448 100644
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
index c5bde089916d..24fd8772deea 100644
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
@@ -50,6 +52,9 @@ bool tcp_ao_ignore_icmp(const struct sock *sk, int type, int code)
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
@@ -1129,6 +1138,11 @@ int tcp_ao_copy_all_matching(const struct sock *sk, struct sock *newsk,
 		goto free_and_exit;
 	}
 
+	if (!static_key_fast_inc_not_disabled(&tcp_ao_needed.key.key)) {
+		ret = -EUSERS;
+		goto free_and_exit;
+	}
+
 	key_head = rcu_dereference(hlist_first_rcu(&new_ao->head));
 	first_key = hlist_entry_safe(key_head, struct tcp_ao_key, node);
 
@@ -1556,6 +1570,10 @@ static int tcp_ao_add_cmd(struct sock *sk, unsigned short int family,
 
 	tcp_ao_link_mkt(ao_info, key);
 	if (first) {
+		if (!static_branch_inc(&tcp_ao_needed.key)) {
+			ret = -EUSERS;
+			goto err_free_sock;
+		}
 		sk_gso_disable(sk);
 		rcu_assign_pointer(tcp_sk(sk)->ao_info, ao_info);
 	}
@@ -1824,6 +1842,10 @@ static int tcp_ao_info_cmd(struct sock *sk, unsigned short int family,
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
index 1e9e423bb718..414c49d37390 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3528,41 +3528,55 @@ static inline bool tcp_may_update_window(const struct tcp_sock *tp,
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
 
-- 
2.41.0

