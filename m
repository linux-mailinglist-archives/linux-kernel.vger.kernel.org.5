Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC41676D54B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbjHBR3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233733AbjHBR2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:28:07 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDD43AB1
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 10:27:41 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fb4146e8fcso866765e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 10:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1690997259; x=1691602059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0VkWLLbFOMdgX3//vCiGhsq4HWyieVY0WWn7M0ZehJM=;
        b=FU5+KdH/zbgnZZOesp8pjIsc7mBZtJakfUvGIOsa32u/8AchIiNa4YnKDqyEcwa8gh
         GdkqLmHwzqYqh1th7vYNOJlSijNJ9oVNRnEj6wB+M0mqvxEUjleXrUEGjNjG8AowPVWZ
         NCKzKfoT++39lrMp5PCC5VV72a3JnaE4Ni1tBfB5ZMGoMNhWbLhqd1MgF1h3pz3cay/R
         n+r7Pyq51tT87GZ2E8AKc90k7B0uPWXb3x2+gwDZmyeRoxmpthfGh54I07W8iFbXYgkw
         Lu1cl09wHB6W8KsmbY7/kl6p0MY7TnIau+/5DlrLg18KBon92lcXMfLTSWqDOyjpKwY5
         TwAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690997259; x=1691602059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0VkWLLbFOMdgX3//vCiGhsq4HWyieVY0WWn7M0ZehJM=;
        b=GMPMo5QlbsBgaSICajl5m5KzLd73N6ZS45zUZtVUbYWSBoVxfrH/Hbgf65Y+4G2rqn
         cdAAKtdZB5CRXf9r+3Eq6+y5vb/oJG1AZwUiPkkJoakb6sEVSoIX68Wo+5qVYK6RHynD
         xtE790/cXQVaIc0dpJkQPulolydGzmvsh3WHvr3YCTNwJvV/Du76hcKKWKhkKj2QSeAB
         6Z0kbankxc+dcRI4w1sB5QGZ62Bw6IP05le1UAjFtvSaVzNET1hK/GSinThNU09WJLfi
         lzocqTdCFUKNVuM3DoLLSIaRg+CxTmHu2jq1eRvxMr/Bqpshb8j8TmYft8Hb76VyhTWu
         dtnw==
X-Gm-Message-State: ABy/qLY6TopXxp5cuHUiCURKdg/VTo7fUWqnO4E8GCSe3jRlfOJzekyl
        9KQIgSXct5j4ukrn1RyZct5bBg==
X-Google-Smtp-Source: APBJJlGJIJnwiCkcF21GYG4C1P9cvYRVz/L5Bgf78O5AdDasmA0DX7KGPxM8bs4bM4A8t8Rg4oWb8A==
X-Received: by 2002:a1c:4b17:0:b0:3fb:c060:9698 with SMTP id y23-20020a1c4b17000000b003fbc0609698mr6108651wma.5.1690997259114;
        Wed, 02 Aug 2023 10:27:39 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id q5-20020a1ce905000000b003fbc0a49b57sm2221770wmc.6.2023.08.02.10.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 10:27:38 -0700 (PDT)
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
Subject: [PATCH v9 net-next 20/23] net/tcp: Add static_key for TCP-AO
Date:   Wed,  2 Aug 2023 18:26:47 +0100
Message-ID: <20230802172654.1467777-21-dima@arista.com>
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
index 85e0f0b50261..b90ef7090dd6 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2612,6 +2612,9 @@ static inline bool tcp_ao_required(struct sock *sk, const void *saddr,
 	struct tcp_ao_info *ao_info;
 	struct tcp_ao_key *ao_key;
 
+	if (!static_branch_unlikely(&tcp_ao_needed.key))
+		return false;
+
 	ao_info = rcu_dereference_check(tcp_sk(sk)->ao_info,
 					lockdep_sock_is_held(sk));
 	if (!ao_info)
diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
index bd616e070eda..63cfbbc620a2 100644
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
index afe509bb1d16..0cdc6c327a5f 100644
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
@@ -50,6 +52,9 @@ bool tcp_ao_ignore_icmp(struct sock *sk, int type, int code)
 	bool ignore_icmp = false;
 	struct tcp_ao_info *ao;
 
+	if (!static_branch_unlikely(&tcp_ao_needed.key))
+		return false;
+
 	/* RFC5925, 7.8:
 	 * >> A TCP-AO implementation MUST default to ignore incoming ICMPv4
 	 * messages of Type 3 (destination unreachable), Codes 2-4 (protocol
@@ -188,6 +193,9 @@ static struct tcp_ao_key *__tcp_ao_do_lookup(const struct sock *sk,
 	struct tcp_ao_key *key;
 	struct tcp_ao_info *ao;
 
+	if (!static_branch_unlikely(&tcp_ao_needed.key))
+		return NULL;
+
 	ao = rcu_dereference_check(tcp_sk(sk)->ao_info,
 				   lockdep_sock_is_held(sk));
 	if (!ao)
@@ -279,6 +287,7 @@ void tcp_ao_destroy_sock(struct sock *sk, bool twsk)
 	}
 
 	kfree_rcu(ao, rcu);
+	static_branch_slow_dec_deferred(&tcp_ao_needed);
 }
 
 void tcp_ao_time_wait(struct tcp_timewait_sock *tcptw, struct tcp_sock *tp)
@@ -1133,6 +1142,11 @@ int tcp_ao_copy_all_matching(const struct sock *sk, struct sock *newsk,
 		goto free_and_exit;
 	}
 
+	if (!static_key_fast_inc_not_disabled(&tcp_ao_needed.key.key)) {
+		ret = -EUSERS;
+		goto free_and_exit;
+	}
+
 	key_head = rcu_dereference(hlist_first_rcu(&new_ao->head));
 	first_key = hlist_entry_safe(key_head, struct tcp_ao_key, node);
 
@@ -1560,6 +1574,10 @@ static int tcp_ao_add_cmd(struct sock *sk, unsigned short int family,
 
 	tcp_ao_link_mkt(ao_info, key);
 	if (first) {
+		if (!static_branch_inc(&tcp_ao_needed.key)) {
+			ret = -EUSERS;
+			goto err_free_sock;
+		}
 		sk_gso_disable(sk);
 		rcu_assign_pointer(tcp_sk(sk)->ao_info, ao_info);
 	}
@@ -1828,6 +1846,10 @@ static int tcp_ao_info_cmd(struct sock *sk, unsigned short int family,
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
index 4b37e82ab612..777f5f5f721d 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3528,41 +3528,55 @@ static inline bool tcp_may_update_window(const struct tcp_sock *tp,
 		(ack_seq == tp->snd_wl1 && nwin > tp->snd_wnd);
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

