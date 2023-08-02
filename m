Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE5D76D531
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbjHBR2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbjHBR1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:27:34 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BEE6E70
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 10:27:12 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3176a439606so41091f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 10:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1690997230; x=1691602030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YGp+Hw8lDqJz2J5xphkQeeHDV2PiOtWFtlDCJWgj86k=;
        b=iKcyrBh2ry1JbPyydUy39bUoQ/eupjfzuDvvRJ6geeVhIhlmGA/GVkyYyW8cJu+3zR
         eCFw4ZkeMIrN5opijLETTcZ3umcb6J7BtiNiWSoDFdoMDTnvjq93VP2VaEnwdr++jUQJ
         /X0WEdkN2V4rfTrxxFxgDNoy0lvudlZEDlgXrdqz55gmXquXZT6D9sGAN/ST6zYphv1/
         g4QMQReaTBO3EBa+sbMWchGDoo1NuYmAaHJ3gCAXySKx7cYxi97gfIGTe4s2umRPpBm8
         c/3rfpN4QaLt4P08mGnS0Ubbwz+enlR6z/VjA0mrk0VT2PRuJZVgB6xze6Nkc9AWGNFx
         oykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690997230; x=1691602030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YGp+Hw8lDqJz2J5xphkQeeHDV2PiOtWFtlDCJWgj86k=;
        b=kPWRU3Pn9+hphodvFQ7a+/mjdk67L77jAsmXxBxQtjPD4PygQLqgPamQhEutsfFdMY
         wcD5kmiVOKf3jpL4+F/I73VZmEN5yX+EckxcvnRgc1tJsoe6bVY5YRFrmrjSeQslFcPr
         uQ2iEamgf8kQud6/jX8AciZdGdvVshD19HkgHZaKLu78I0pGnFccJaAS+Cvj4zlp+oTC
         gWFv/DxBdDMYCB8a6CR297VeLc+ZZ/EdHG1MUGIAkXpdTU4ggCcLPsZFwLoIvxruONc3
         t2H4uwscQ09ineE/CTj4ozGlAYtDmj8Tei5yvS8xThPyWapbEHsEN0mNkqU5pRwpmfKU
         osXA==
X-Gm-Message-State: ABy/qLaKaCU0KCuWbW6nT5nv+CS1LF1ndVgk7GwLP92KskTcSVQaIOC0
        EW7V482XdO86J8NffRtgIigc7g==
X-Google-Smtp-Source: APBJJlHGX/5VAm9y7R5om0f7vTDpES6CsoXuQoHD02p1O2NRWviNf+Hwo4uH4auwLxVOhgz+HDfWhQ==
X-Received: by 2002:adf:e60e:0:b0:313:fe1b:f444 with SMTP id p14-20020adfe60e000000b00313fe1bf444mr5259042wrm.68.1690997230495;
        Wed, 02 Aug 2023 10:27:10 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id q5-20020a1ce905000000b003fbc0a49b57sm2221770wmc.6.2023.08.02.10.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 10:27:09 -0700 (PDT)
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
Subject: [PATCH v9 net-next 04/23] net/tcp: Prevent TCP-MD5 with TCP-AO being set
Date:   Wed,  2 Aug 2023 18:26:31 +0100
Message-ID: <20230802172654.1467777-5-dima@arista.com>
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

Be as conservative as possible: if there is TCP-MD5 key for a given peer
regardless of L3 interface - don't allow setting TCP-AO key for the same
peer. According to RFC5925, TCP-AO is supposed to replace TCP-MD5 and
there can't be any switch between both on any connected tuple.
Later it can be relaxed, if there's a use, but in the beginning restrict
any intersection.

Note: it's still should be possible to set both TCP-MD5 and TCP-AO keys
on a listening socket for *different* peers.

Co-developed-by: Francesco Ruggeri <fruggeri@arista.com>
Signed-off-by: Francesco Ruggeri <fruggeri@arista.com>
Co-developed-by: Salam Noureddine <noureddine@arista.com>
Signed-off-by: Salam Noureddine <noureddine@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
Acked-by: David Ahern <dsahern@kernel.org>
---
 include/net/tcp.h     | 43 +++++++++++++++++++++++++++++++++++++--
 include/net/tcp_ao.h  | 13 ++++++++++++
 net/ipv4/tcp_ao.c     | 47 +++++++++++++++++++++++++++++++++++++++++++
 net/ipv4/tcp_ipv4.c   | 14 ++++++++++---
 net/ipv4/tcp_output.c | 47 +++++++++++++++++++++++++++++++++++++++++++
 net/ipv6/tcp_ao.c     | 17 ++++++++++++++++
 net/ipv6/tcp_ipv6.c   | 26 ++++++++++++++++++++----
 7 files changed, 198 insertions(+), 9 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 6161e6bde100..b1c0dcfd45e8 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1741,6 +1741,7 @@ int tcp_md5_key_copy(struct sock *sk, const union tcp_md5_addr *addr,
 
 int tcp_md5_do_del(struct sock *sk, const union tcp_md5_addr *addr,
 		   int family, u8 prefixlen, int l3index, u8 flags);
+void tcp_clear_md5_list(struct sock *sk);
 struct tcp_md5sig_key *tcp_v4_md5_lookup(const struct sock *sk,
 					 const struct sock *addr_sk);
 
@@ -1749,14 +1750,23 @@ struct tcp_md5sig_key *tcp_v4_md5_lookup(const struct sock *sk,
 extern struct static_key_false_deferred tcp_md5_needed;
 struct tcp_md5sig_key *__tcp_md5_do_lookup(const struct sock *sk, int l3index,
 					   const union tcp_md5_addr *addr,
-					   int family);
+					   int family, bool any_l3index);
 static inline struct tcp_md5sig_key *
 tcp_md5_do_lookup(const struct sock *sk, int l3index,
 		  const union tcp_md5_addr *addr, int family)
 {
 	if (!static_branch_unlikely(&tcp_md5_needed.key))
 		return NULL;
-	return __tcp_md5_do_lookup(sk, l3index, addr, family);
+	return __tcp_md5_do_lookup(sk, l3index, addr, family, false);
+}
+
+static inline struct tcp_md5sig_key *
+tcp_md5_do_lookup_any_l3index(const struct sock *sk,
+			      const union tcp_md5_addr *addr, int family)
+{
+	if (!static_branch_unlikely(&tcp_md5_needed.key))
+		return NULL;
+	return __tcp_md5_do_lookup(sk, 0, addr, family, true);
 }
 
 enum skb_drop_reason
@@ -1774,6 +1784,13 @@ tcp_md5_do_lookup(const struct sock *sk, int l3index,
 	return NULL;
 }
 
+static inline struct tcp_md5sig_key *
+tcp_md5_do_lookup_any_l3index(const struct sock *sk,
+			      const union tcp_md5_addr *addr, int family)
+{
+	return NULL;
+}
+
 static inline enum skb_drop_reason
 tcp_inbound_md5_hash(const struct sock *sk, const struct sk_buff *skb,
 		     const void *saddr, const void *daddr,
@@ -2136,6 +2153,9 @@ struct tcp_sock_af_ops {
 #endif
 #ifdef CONFIG_TCP_AO
 	int (*ao_parse)(struct sock *sk, int optname, sockptr_t optval, int optlen);
+	struct tcp_ao_key *(*ao_lookup)(const struct sock *sk,
+					struct sock *addr_sk,
+					int sndid, int rcvid);
 #endif
 };
 
@@ -2547,4 +2567,23 @@ static inline u64 tcp_transmit_time(const struct sock *sk)
 	return 0;
 }
 
+static inline bool tcp_ao_required(struct sock *sk, const void *saddr,
+				   int family)
+{
+#ifdef CONFIG_TCP_AO
+	struct tcp_ao_info *ao_info;
+	struct tcp_ao_key *ao_key;
+
+	ao_info = rcu_dereference_check(tcp_sk(sk)->ao_info,
+					lockdep_sock_is_held(sk));
+	if (!ao_info)
+		return false;
+
+	ao_key = tcp_ao_do_lookup(sk, saddr, family, -1, -1);
+	if (ao_info->ao_required || ao_key)
+		return true;
+#endif
+	return false;
+}
+
 #endif	/* _TCP_H */
diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
index a81e40fd255a..3c7f576376f9 100644
--- a/include/net/tcp_ao.h
+++ b/include/net/tcp_ao.h
@@ -92,11 +92,24 @@ struct tcp_ao_info {
 int tcp_parse_ao(struct sock *sk, int cmd, unsigned short int family,
 		 sockptr_t optval, int optlen);
 void tcp_ao_destroy_sock(struct sock *sk);
+struct tcp_ao_key *tcp_ao_do_lookup(const struct sock *sk,
+				    const union tcp_ao_addr *addr,
+				    int family, int sndid, int rcvid);
 /* ipv4 specific functions */
 int tcp_v4_parse_ao(struct sock *sk, int cmd, sockptr_t optval, int optlen);
+struct tcp_ao_key *tcp_v4_ao_lookup(const struct sock *sk, struct sock *addr_sk,
+				    int sndid, int rcvid);
 /* ipv6 specific functions */
 int tcp_v6_parse_ao(struct sock *sk, int cmd, sockptr_t optval, int optlen);
+struct tcp_ao_key *tcp_v6_ao_lookup(const struct sock *sk,
+				    struct sock *addr_sk, int sndid, int rcvid);
 #else
+static inline struct tcp_ao_key *tcp_ao_do_lookup(const struct sock *sk,
+		const union tcp_ao_addr *addr, int family, int sndid, int rcvid)
+{
+	return NULL;
+}
+
 static inline void tcp_ao_destroy_sock(struct sock *sk)
 {
 }
diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index 9121f1eeb224..0a530076abdc 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -116,6 +116,13 @@ static struct tcp_ao_key *__tcp_ao_do_lookup(const struct sock *sk,
 	return NULL;
 }
 
+struct tcp_ao_key *tcp_ao_do_lookup(const struct sock *sk,
+				    const union tcp_ao_addr *addr,
+				    int family, int sndid, int rcvid)
+{
+	return __tcp_ao_do_lookup(sk, addr, family, U8_MAX, sndid, rcvid);
+}
+
 static struct tcp_ao_info *tcp_ao_alloc_info(gfp_t flags)
 {
 	struct tcp_ao_info *ao;
@@ -162,6 +169,14 @@ void tcp_ao_destroy_sock(struct sock *sk)
 	kfree_rcu(ao, rcu);
 }
 
+struct tcp_ao_key *tcp_v4_ao_lookup(const struct sock *sk, struct sock *addr_sk,
+				    int sndid, int rcvid)
+{
+	union tcp_ao_addr *addr = (union tcp_ao_addr *)&addr_sk->sk_daddr;
+
+	return tcp_ao_do_lookup(sk, addr, AF_INET, sndid, rcvid);
+}
+
 static bool tcp_ao_can_set_current_rnext(struct sock *sk)
 {
 	/* There aren't current/rnext keys on TCP_LISTEN sockets */
@@ -497,6 +512,10 @@ static int tcp_ao_add_cmd(struct sock *sk, unsigned short int family,
 			return -EINVAL;
 	}
 
+	/* Don't allow keys for peers that have a matching TCP-MD5 key */
+	if (tcp_md5_do_lookup_any_l3index(sk, addr, family))
+		return -EKEYREJECTED;
+
 	ao_info = setsockopt_ao_info(sk);
 	if (IS_ERR(ao_info))
 		return PTR_ERR(ao_info);
@@ -698,6 +717,31 @@ static int tcp_ao_del_cmd(struct sock *sk, unsigned short int family,
 	return -ENOENT;
 }
 
+/* cmd.ao_required makes a socket TCP-AO only.
+ * Don't allow any md5 keys for any l3intf on the socket together with it.
+ * Restricting it early in setsockopt() removes a check for
+ * ao_info->ao_required on inbound tcp segment fast-path.
+ */
+static int tcp_ao_required_verify(struct sock *sk)
+{
+#ifdef CONFIG_TCP_MD5SIG
+	const struct tcp_md5sig_info *md5sig;
+
+	if (!static_branch_unlikely(&tcp_md5_needed.key))
+		return 0;
+
+	md5sig = rcu_dereference_check(tcp_sk(sk)->md5sig_info,
+				       lockdep_sock_is_held(sk));
+	if (!md5sig)
+		return 0;
+
+	if (rcu_dereference_check(hlist_first_rcu(&md5sig->head),
+				  lockdep_sock_is_held(sk)))
+		return 1;
+#endif
+	return 0;
+}
+
 static int tcp_ao_info_cmd(struct sock *sk, unsigned short int family,
 			   sockptr_t optval, int optlen)
 {
@@ -732,6 +776,9 @@ static int tcp_ao_info_cmd(struct sock *sk, unsigned short int family,
 		first = true;
 	}
 
+	if (cmd.ao_required && tcp_ao_required_verify(sk))
+		return -EKEYREJECTED;
+
 	/* For sockets in TCP_CLOSED it's possible set keys that aren't
 	 * matching the future peer (address/port/VRF/etc),
 	 * tcp_ao_connect_init() will choose a correct matching MKT
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index c05f30fe5101..bc6a9d0c8410 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1081,7 +1081,7 @@ static bool better_md5_match(struct tcp_md5sig_key *old, struct tcp_md5sig_key *
 /* Find the Key structure for an address.  */
 struct tcp_md5sig_key *__tcp_md5_do_lookup(const struct sock *sk, int l3index,
 					   const union tcp_md5_addr *addr,
-					   int family)
+					   int family, bool any_l3index)
 {
 	const struct tcp_sock *tp = tcp_sk(sk);
 	struct tcp_md5sig_key *key;
@@ -1100,7 +1100,8 @@ struct tcp_md5sig_key *__tcp_md5_do_lookup(const struct sock *sk, int l3index,
 				 lockdep_sock_is_held(sk)) {
 		if (key->family != family)
 			continue;
-		if (key->flags & TCP_MD5SIG_FLAG_IFINDEX && key->l3index != l3index)
+		if (!any_l3index && key->flags & TCP_MD5SIG_FLAG_IFINDEX &&
+		    key->l3index != l3index)
 			continue;
 		if (family == AF_INET) {
 			mask = inet_make_mask(key->prefixlen);
@@ -1312,7 +1313,7 @@ int tcp_md5_do_del(struct sock *sk, const union tcp_md5_addr *addr, int family,
 }
 EXPORT_SYMBOL(tcp_md5_do_del);
 
-static void tcp_clear_md5_list(struct sock *sk)
+void tcp_clear_md5_list(struct sock *sk)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct tcp_md5sig_key *key;
@@ -1382,6 +1383,12 @@ static int tcp_v4_parse_md5_keys(struct sock *sk, int optname,
 	if (cmd.tcpm_keylen > TCP_MD5SIG_MAXKEYLEN)
 		return -EINVAL;
 
+	/* Don't allow keys for peers that have a matching TCP-AO key.
+	 * See the comment in tcp_ao_add_cmd()
+	 */
+	if (tcp_ao_required(sk, addr, AF_INET))
+		return -EKEYREJECTED;
+
 	return tcp_md5_do_add(sk, addr, AF_INET, prefixlen, l3index, flags,
 			      cmd.tcpm_key, cmd.tcpm_keylen);
 }
@@ -2277,6 +2284,7 @@ static const struct tcp_sock_af_ops tcp_sock_ipv4_specific = {
 	.md5_parse		= tcp_v4_parse_md5_keys,
 #endif
 #ifdef CONFIG_TCP_AO
+	.ao_lookup		= tcp_v4_ao_lookup,
 	.ao_parse		= tcp_v4_parse_ao,
 #endif
 };
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 51d8638d4b4c..82526df74839 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3928,6 +3928,53 @@ int tcp_connect(struct sock *sk)
 
 	tcp_call_bpf(sk, BPF_SOCK_OPS_TCP_CONNECT_CB, 0, NULL);
 
+#if defined(CONFIG_TCP_MD5SIG) && defined(CONFIG_TCP_AO)
+	/* Has to be checked late, after setting daddr/saddr/ops.
+	 * Return error if the peer has both a md5 and a tcp-ao key
+	 * configured as this is ambiguous.
+	 */
+	if (unlikely(rcu_dereference_protected(tp->md5sig_info,
+					       lockdep_sock_is_held(sk)))) {
+		bool needs_ao = !!tp->af_specific->ao_lookup(sk, sk, -1, -1);
+		bool needs_md5 = !!tp->af_specific->md5_lookup(sk, sk);
+		struct tcp_ao_info *ao_info;
+
+		ao_info = rcu_dereference_check(tp->ao_info,
+						lockdep_sock_is_held(sk));
+		if (ao_info) {
+			/* This is an extra check: tcp_ao_required() in
+			 * tcp_v{4,6}_parse_md5_keys() should prevent adding
+			 * md5 keys on ao_required socket.
+			 */
+			needs_ao |= ao_info->ao_required;
+			WARN_ON_ONCE(ao_info->ao_required && needs_md5);
+		}
+		if (needs_md5 && needs_ao)
+			return -EKEYREJECTED;
+
+		/* If we have a matching md5 key and no matching tcp-ao key
+		 * then free up ao_info if allocated.
+		 */
+		if (needs_md5) {
+			tcp_ao_destroy_sock(sk);
+		} else if (needs_ao) {
+			tcp_clear_md5_list(sk);
+			kfree(rcu_replace_pointer(tp->md5sig_info, NULL,
+						  lockdep_sock_is_held(sk)));
+		}
+	}
+#endif
+#ifdef CONFIG_TCP_AO
+	if (unlikely(rcu_dereference_protected(tp->ao_info,
+					       lockdep_sock_is_held(sk)))) {
+		/* Don't allow connecting if ao is configured but no
+		 * matching key is found.
+		 */
+		if (!tp->af_specific->ao_lookup(sk, sk, -1, -1))
+			return -EKEYREJECTED;
+	}
+#endif
+
 	if (inet_csk(sk)->icsk_af_ops->rebuild_header(sk))
 		return -EHOSTUNREACH; /* Routing failure or similar. */
 
diff --git a/net/ipv6/tcp_ao.c b/net/ipv6/tcp_ao.c
index 049ddbabe049..0640acaee67b 100644
--- a/net/ipv6/tcp_ao.c
+++ b/net/ipv6/tcp_ao.c
@@ -12,6 +12,23 @@
 #include <net/tcp.h>
 #include <net/ipv6.h>
 
+static struct tcp_ao_key *tcp_v6_ao_do_lookup(const struct sock *sk,
+					      const struct in6_addr *addr,
+					      int sndid, int rcvid)
+{
+	return tcp_ao_do_lookup(sk, (union tcp_ao_addr *)addr, AF_INET6,
+				sndid, rcvid);
+}
+
+struct tcp_ao_key *tcp_v6_ao_lookup(const struct sock *sk,
+				    struct sock *addr_sk,
+				    int sndid, int rcvid)
+{
+	struct in6_addr *addr = &addr_sk->sk_v6_daddr;
+
+	return tcp_v6_ao_do_lookup(sk, addr, sndid, rcvid);
+}
+
 int tcp_v6_parse_ao(struct sock *sk, int cmd,
 		    sockptr_t optval, int optlen)
 {
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 20c5f91e5451..cdce953a8652 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -599,6 +599,7 @@ static int tcp_v6_parse_md5_keys(struct sock *sk, int optname,
 {
 	struct tcp_md5sig cmd;
 	struct sockaddr_in6 *sin6 = (struct sockaddr_in6 *)&cmd.tcpm_addr;
+	union tcp_ao_addr *addr;
 	int l3index = 0;
 	u8 prefixlen;
 	u8 flags;
@@ -653,13 +654,28 @@ static int tcp_v6_parse_md5_keys(struct sock *sk, int optname,
 	if (cmd.tcpm_keylen > TCP_MD5SIG_MAXKEYLEN)
 		return -EINVAL;
 
-	if (ipv6_addr_v4mapped(&sin6->sin6_addr))
-		return tcp_md5_do_add(sk, (union tcp_md5_addr *)&sin6->sin6_addr.s6_addr32[3],
+	if (ipv6_addr_v4mapped(&sin6->sin6_addr)) {
+		addr = (union tcp_md5_addr *)&sin6->sin6_addr.s6_addr32[3];
+
+		/* Don't allow keys for peers that have a matching TCP-AO key.
+		 * See the comment in tcp_ao_add_cmd()
+		 */
+		if (tcp_ao_required(sk, addr, AF_INET))
+			return -EKEYREJECTED;
+		return tcp_md5_do_add(sk, addr,
 				      AF_INET, prefixlen, l3index, flags,
 				      cmd.tcpm_key, cmd.tcpm_keylen);
+	}
 
-	return tcp_md5_do_add(sk, (union tcp_md5_addr *)&sin6->sin6_addr,
-			      AF_INET6, prefixlen, l3index, flags,
+	addr = (union tcp_md5_addr *)&sin6->sin6_addr;
+
+	/* Don't allow keys for peers that have a matching TCP-AO key.
+	 * See the comment in tcp_ao_add_cmd()
+	 */
+	if (tcp_ao_required(sk, addr, AF_INET6))
+		return -EKEYREJECTED;
+
+	return tcp_md5_do_add(sk, addr, AF_INET6, prefixlen, l3index, flags,
 			      cmd.tcpm_key, cmd.tcpm_keylen);
 }
 
@@ -1899,6 +1915,7 @@ static const struct tcp_sock_af_ops tcp_sock_ipv6_specific = {
 	.md5_parse	=	tcp_v6_parse_md5_keys,
 #endif
 #ifdef CONFIG_TCP_AO
+	.ao_lookup	=	tcp_v6_ao_lookup,
 	.ao_parse	=	tcp_v6_parse_ao,
 #endif
 };
@@ -1930,6 +1947,7 @@ static const struct tcp_sock_af_ops tcp_sock_ipv6_mapped_specific = {
 	.md5_parse	=	tcp_v6_parse_md5_keys,
 #endif
 #ifdef CONFIG_TCP_AO
+	.ao_lookup	=	tcp_v6_ao_lookup,
 	.ao_parse	=	tcp_v6_parse_ao,
 #endif
 };
-- 
2.41.0

