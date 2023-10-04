Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D017B9835
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 00:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbjJDWic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 18:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239481AbjJDWhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 18:37:53 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257EF11F
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 15:37:16 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3231d67aff2so379463f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 15:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1696459034; x=1697063834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=udHaWXup9VHa0USw7DDsxy0LUrX4SRJCMR460UM1lKU=;
        b=ilObd6YfsuKWfYpDTvq1FSDIcx07vHzZCjp43njAXTl5k8h9ninQm1sR0wogXdXCP7
         C1IvVDwdohfvokMa4dP54ASiesQwCZeMudZqNKkgAISuCvqXVId+3elm89tok6xXy23g
         eJqlF0MRFHB5AGVzkFqDtjrX8C64qbkrPS7yZsBPYDIbA8VU7wihgkeIkhdVfw6e87iu
         yb0l4iTs9v4QwEQ/dLO/OlzfNC5Oh4He118NenYwExAEoSBpU3Nd5PDPcgugZz+B6f9m
         o4EtXwNsY7GTBJEu+Y6fOsmRetRIpa6scVsYwVsUwQlmoojLeAu7iCbC9BxkvuOQsp7R
         dO5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696459034; x=1697063834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=udHaWXup9VHa0USw7DDsxy0LUrX4SRJCMR460UM1lKU=;
        b=mj1xGtZSHGE5pUBhWOTJbTEiV2BKoPXsk/IAFI+h6yOEP1jNOGa+g1wRO2d6IZmkm+
         pCTE2AbD/fwCBULxnqg9gmPH2jjWrIlxCSw6lZ1ZK6MZN7jz01pTMeOPQyYIUPz8hvI3
         N39W3tmVM5FyPggG7tk3hUfVC81aA4Tg76kcXeMv9YIaGAa4VQJjQxIZ8FWQ4ZSbpH+0
         6mOErmS2lTHJvFL9VpyuhKs799ydjNfyQUHqskchBVMmS8QEDh2Qj8a9Vmk0n/9WccIH
         QreMYxNKxGH1u0Xq8eVCmYigdUu79dPwqc7eCRUTI9ZmxQl+UPvGbYS+KIkPqOn+itsq
         1cng==
X-Gm-Message-State: AOJu0YwrUcqINk+HRFUQhKkqVoIVTNmMx0PQwZpCYst0KBG2HBTOzoku
        Ee5RrH0HsaV4pAhJAXlkbdr91g==
X-Google-Smtp-Source: AGHT+IE0RbtaLDHJLZTfEU7oTxe27sH9Z8E2fLg+rzK0aPfWlHpz0XneZ/zCbUhCoj/EOMXhjOQr+g==
X-Received: by 2002:adf:e786:0:b0:321:6be7:d1be with SMTP id n6-20020adfe786000000b003216be7d1bemr3351293wrm.13.1696459034180;
        Wed, 04 Oct 2023 15:37:14 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id z11-20020a5d4d0b000000b0031ff89af0e4sm181412wrt.99.2023.10.04.15.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 15:37:13 -0700 (PDT)
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
Subject: [PATCH v13 net-next 21/23] net/tcp: Wire up l3index to TCP-AO
Date:   Wed,  4 Oct 2023 23:36:25 +0100
Message-ID: <20231004223629.166300-22-dima@arista.com>
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

Similarly how TCP_MD5SIG_FLAG_IFINDEX works for TCP-MD5,
TCP_AO_KEYF_IFINDEX is an AO-key flag that binds that MKT to a specified
by L3 ifinndex. Similarly, without this flag the key will work in
the default VRF l3index = 0 for connections.
To prevent AO-keys from overlapping, it's restricted to add key B for a
socket that has key A, which have the same sndid/rcvid and one of
the following is true:
- !(A.keyflags & TCP_AO_KEYF_IFINDEX) or !(B.keyflags & TCP_AO_KEYF_IFINDEX)
  so that any key is non-bound to a VRF
- A.l3index == B.l3index
  both want to work for the same VRF

Additionally, it's restricted to match TCP-MD5 keys for the same peer
the following way:
|--------------|--------------------|----------------|---------------|
|              | MD5 key without    |     MD5 key    |    MD5 key    |
|              |     l3index        |    l3index=0   |   l3index=N   |
|--------------|--------------------|----------------|---------------|
|  TCP-AO key  |                    |                |               |
|  without     |       reject       |    reject      |   reject      |
|  l3index     |                    |                |               |
|--------------|--------------------|----------------|---------------|
|  TCP-AO key  |                    |                |               |
|  l3index=0   |       reject       |    reject      |   allow       |
|--------------|--------------------|----------------|---------------|
|  TCP-AO key  |                    |                |               |
|  l3index=N   |       reject       |    allow       |   reject      |
|--------------|--------------------|----------------|---------------|

This is done with the help of tcp_md5_do_lookup_any_l3index() to reject
adding AO key without TCP_AO_KEYF_IFINDEX if there's TCP-MD5 in any VRF.
This is important for case where sysctl_tcp_l3mdev_accept = 1
Similarly, for TCP-AO lookups tcp_ao_do_lookup() may be used with
l3index < 0, so that __tcp_ao_key_cmp() will match TCP-AO key in any VRF.

Signed-off-by: Dmitry Safonov <dima@arista.com>
Acked-by: David Ahern <dsahern@kernel.org>
---
 include/net/tcp.h     |  11 +--
 include/net/tcp_ao.h  |  18 ++---
 net/ipv4/syncookies.c |   6 +-
 net/ipv4/tcp_ao.c     | 170 +++++++++++++++++++++++++++++++-----------
 net/ipv4/tcp_ipv4.c   |  10 ++-
 net/ipv6/syncookies.c |   5 +-
 net/ipv6/tcp_ao.c     |  21 +++---
 net/ipv6/tcp_ipv6.c   |  15 +++-
 8 files changed, 177 insertions(+), 79 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 5215f4ff4a1c..69870a81f0cf 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2677,7 +2677,7 @@ static inline int tcp_parse_auth_options(const struct tcphdr *th,
 }
 
 static inline bool tcp_ao_required(struct sock *sk, const void *saddr,
-				   int family, bool stat_inc)
+				   int family, int l3index, bool stat_inc)
 {
 #ifdef CONFIG_TCP_AO
 	struct tcp_ao_info *ao_info;
@@ -2691,7 +2691,7 @@ static inline bool tcp_ao_required(struct sock *sk, const void *saddr,
 	if (!ao_info)
 		return false;
 
-	ao_key = tcp_ao_do_lookup(sk, saddr, family, -1, -1);
+	ao_key = tcp_ao_do_lookup(sk, l3index, saddr, family, -1, -1);
 	if (ao_info->ao_required || ao_key) {
 		if (stat_inc) {
 			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPAOREQUIRED);
@@ -2744,21 +2744,22 @@ tcp_inbound_hash(struct sock *sk, const struct request_sock *req,
 		 * the last key is impossible to remove, so there's
 		 * always at least one current_key.
 		 */
-		if (tcp_ao_required(sk, saddr, family, true)) {
+		if (tcp_ao_required(sk, saddr, family, l3index, true)) {
 			tcp_hash_fail("AO hash is required, but not found",
 					family, skb, "L3 index %d", l3index);
 			return SKB_DROP_REASON_TCP_AONOTFOUND;
 		}
 		if (unlikely(tcp_md5_do_lookup(sk, l3index, saddr, family))) {
 			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5NOTFOUND);
-			tcp_hash_fail("MD5 Hash not found", family, skb, "");
+			tcp_hash_fail("MD5 Hash not found",
+				      family, skb, "L3 index %d", l3index);
 			return SKB_DROP_REASON_TCP_MD5NOTFOUND;
 		}
 		return SKB_NOT_DROPPED_YET;
 	}
 
 	if (aoh)
-		return tcp_inbound_ao_hash(sk, skb, family, req, aoh);
+		return tcp_inbound_ao_hash(sk, skb, family, req, l3index, aoh);
 
 	return tcp_inbound_md5_hash(sk, skb, saddr, daddr, family,
 				    l3index, md5_location);
diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
index ba5b8c409e99..4de921989749 100644
--- a/include/net/tcp_ao.h
+++ b/include/net/tcp_ao.h
@@ -33,6 +33,7 @@ struct tcp_ao_key {
 	u8			key[TCP_AO_MAXKEYLEN] __tcp_ao_key_align;
 	unsigned int		tcp_sigpool_id;
 	unsigned int		digest_size;
+	int			l3index;
 	u8			prefixlen;
 	u8			family;
 	u8			keylen;
@@ -200,10 +201,10 @@ int tcp_ao_get_mkts(struct sock *sk, sockptr_t optval, sockptr_t optlen);
 int tcp_ao_get_sock_info(struct sock *sk, sockptr_t optval, sockptr_t optlen);
 enum skb_drop_reason tcp_inbound_ao_hash(struct sock *sk,
 			const struct sk_buff *skb, unsigned short int family,
-			const struct request_sock *req,
+			const struct request_sock *req, int l3index,
 			const struct tcp_ao_hdr *aoh);
 u32 tcp_ao_compute_sne(u32 next_sne, u32 next_seq, u32 seq);
-struct tcp_ao_key *tcp_ao_do_lookup(const struct sock *sk,
+struct tcp_ao_key *tcp_ao_do_lookup(const struct sock *sk, int l3index,
 				    const union tcp_ao_addr *addr,
 				    int family, int sndid, int rcvid);
 int tcp_ao_hash_hdr(unsigned short family, char *ao_hash,
@@ -245,9 +246,6 @@ int tcp_v6_ao_calc_key_sk(struct tcp_ao_key *mkt, u8 *key,
 			  __be32 disn, bool send);
 int tcp_v6_ao_calc_key_rsk(struct tcp_ao_key *mkt, u8 *key,
 			   struct request_sock *req);
-struct tcp_ao_key *tcp_v6_ao_do_lookup(const struct sock *sk,
-				       const struct in6_addr *addr,
-				       int sndid, int rcvid);
 struct tcp_ao_key *tcp_v6_ao_lookup(const struct sock *sk,
 				    struct sock *addr_sk, int sndid, int rcvid);
 struct tcp_ao_key *tcp_v6_ao_lookup_rsk(const struct sock *sk,
@@ -265,7 +263,7 @@ void tcp_ao_finish_connect(struct sock *sk, struct sk_buff *skb);
 void tcp_ao_connect_init(struct sock *sk);
 void tcp_ao_syncookie(struct sock *sk, const struct sk_buff *skb,
 		      struct tcp_request_sock *treq,
-		      unsigned short int family);
+		      unsigned short int family, int l3index);
 #else /* CONFIG_TCP_AO */
 
 static inline int tcp_ao_transmit_skb(struct sock *sk, struct sk_buff *skb,
@@ -277,7 +275,7 @@ static inline int tcp_ao_transmit_skb(struct sock *sk, struct sk_buff *skb,
 
 static inline void tcp_ao_syncookie(struct sock *sk, const struct sk_buff *skb,
 				    struct tcp_request_sock *treq,
-				    unsigned short int family)
+				    unsigned short int family, int l3index)
 {
 }
 
@@ -288,13 +286,15 @@ static inline bool tcp_ao_ignore_icmp(const struct sock *sk, int type, int code)
 
 static inline enum skb_drop_reason tcp_inbound_ao_hash(struct sock *sk,
 		const struct sk_buff *skb, unsigned short int family,
-		const struct request_sock *req, const struct tcp_ao_hdr *aoh)
+		const struct request_sock *req, int l3index,
+		const struct tcp_ao_hdr *aoh)
 {
 	return SKB_NOT_DROPPED_YET;
 }
 
 static inline struct tcp_ao_key *tcp_ao_do_lookup(const struct sock *sk,
-		const union tcp_ao_addr *addr, int family, int sndid, int rcvid)
+		int l3index, const union tcp_ao_addr *addr,
+		int family, int sndid, int rcvid)
 {
 	return NULL;
 }
diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index 23fca22bc992..40b7f4c659f8 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -338,6 +338,7 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	__u8 rcv_wscale;
 	struct flowi4 fl4;
 	u32 tsoff = 0;
+	int l3index;
 
 	if (!READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_syncookies) ||
 	    !th->ack || th->rst)
@@ -394,13 +395,14 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	treq->snt_synack	= 0;
 	treq->tfo_listener	= false;
 
-	tcp_ao_syncookie(sk, skb, treq, AF_INET);
-
 	if (IS_ENABLED(CONFIG_SMC))
 		ireq->smc_ok = 0;
 
 	ireq->ir_iif = inet_request_bound_dev_if(sk, skb);
 
+	l3index = l3mdev_master_ifindex_by_index(sock_net(sk), ireq->ir_iif);
+	tcp_ao_syncookie(sk, skb, treq, AF_INET, l3index);
+
 	/* We throwed the options of the initial SYN away, so we hope
 	 * the ACK carries the same options again (see RFC1122 4.2.3.8)
 	 */
diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index 9e8016157a37..31ed648559d4 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -136,7 +136,7 @@ static int ipv4_prefix_cmp(const struct in_addr *addr1,
 	return memcmp(&a1, &a2, sizeof(a1));
 }
 
-static int __tcp_ao_key_cmp(const struct tcp_ao_key *key,
+static int __tcp_ao_key_cmp(const struct tcp_ao_key *key, int l3index,
 			    const union tcp_ao_addr *addr, u8 prefixlen,
 			    int family, int sndid, int rcvid)
 {
@@ -144,6 +144,10 @@ static int __tcp_ao_key_cmp(const struct tcp_ao_key *key,
 		return (key->sndid > sndid) ? 1 : -1;
 	if (rcvid >= 0 && key->rcvid != rcvid)
 		return (key->rcvid > rcvid) ? 1 : -1;
+	if (l3index >= 0 && (key->keyflags & TCP_AO_KEYF_IFINDEX)) {
+		if (key->l3index != l3index)
+			return (key->l3index > l3index) ? 1 : -1;
+	}
 
 	if (family == AF_UNSPEC)
 		return 0;
@@ -168,7 +172,7 @@ static int __tcp_ao_key_cmp(const struct tcp_ao_key *key,
 	return -1;
 }
 
-static int tcp_ao_key_cmp(const struct tcp_ao_key *key,
+static int tcp_ao_key_cmp(const struct tcp_ao_key *key, int l3index,
 			  const union tcp_ao_addr *addr, u8 prefixlen,
 			  int family, int sndid, int rcvid)
 {
@@ -176,14 +180,16 @@ static int tcp_ao_key_cmp(const struct tcp_ao_key *key,
 	if (family == AF_INET6 && ipv6_addr_v4mapped(&addr->a6)) {
 		__be32 addr4 = addr->a6.s6_addr32[3];
 
-		return __tcp_ao_key_cmp(key, (union tcp_ao_addr *)&addr4,
+		return __tcp_ao_key_cmp(key, l3index,
+					(union tcp_ao_addr *)&addr4,
 					prefixlen, AF_INET, sndid, rcvid);
 	}
 #endif
-	return __tcp_ao_key_cmp(key, addr, prefixlen, family, sndid, rcvid);
+	return __tcp_ao_key_cmp(key, l3index, addr,
+				prefixlen, family, sndid, rcvid);
 }
 
-static struct tcp_ao_key *__tcp_ao_do_lookup(const struct sock *sk,
+static struct tcp_ao_key *__tcp_ao_do_lookup(const struct sock *sk, int l3index,
 		const union tcp_ao_addr *addr, int family, u8 prefix,
 		int sndid, int rcvid)
 {
@@ -201,17 +207,18 @@ static struct tcp_ao_key *__tcp_ao_do_lookup(const struct sock *sk,
 	hlist_for_each_entry_rcu(key, &ao->head, node) {
 		u8 prefixlen = min(prefix, key->prefixlen);
 
-		if (!tcp_ao_key_cmp(key, addr, prefixlen, family, sndid, rcvid))
+		if (!tcp_ao_key_cmp(key, l3index, addr, prefixlen,
+				    family, sndid, rcvid))
 			return key;
 	}
 	return NULL;
 }
 
-struct tcp_ao_key *tcp_ao_do_lookup(const struct sock *sk,
+struct tcp_ao_key *tcp_ao_do_lookup(const struct sock *sk, int l3index,
 				    const union tcp_ao_addr *addr,
 				    int family, int sndid, int rcvid)
 {
-	return __tcp_ao_do_lookup(sk, addr, family, U8_MAX, sndid, rcvid);
+	return __tcp_ao_do_lookup(sk, l3index, addr, family, U8_MAX, sndid, rcvid);
 }
 
 static struct tcp_ao_info *tcp_ao_alloc_info(gfp_t flags)
@@ -677,18 +684,22 @@ struct tcp_ao_key *tcp_v4_ao_lookup_rsk(const struct sock *sk,
 					struct request_sock *req,
 					int sndid, int rcvid)
 {
-	union tcp_ao_addr *addr =
-			(union tcp_ao_addr *)&inet_rsk(req)->ir_rmt_addr;
+	struct inet_request_sock *ireq = inet_rsk(req);
+	union tcp_ao_addr *addr = (union tcp_ao_addr *)&ireq->ir_rmt_addr;
+	int l3index;
 
-	return tcp_ao_do_lookup(sk, addr, AF_INET, sndid, rcvid);
+	l3index = l3mdev_master_ifindex_by_index(sock_net(sk), ireq->ir_iif);
+	return tcp_ao_do_lookup(sk, l3index, addr, AF_INET, sndid, rcvid);
 }
 
 struct tcp_ao_key *tcp_v4_ao_lookup(const struct sock *sk, struct sock *addr_sk,
 				    int sndid, int rcvid)
 {
+	int l3index = l3mdev_master_ifindex_by_index(sock_net(sk),
+						     addr_sk->sk_bound_dev_if);
 	union tcp_ao_addr *addr = (union tcp_ao_addr *)&addr_sk->sk_daddr;
 
-	return tcp_ao_do_lookup(sk, addr, AF_INET, sndid, rcvid);
+	return tcp_ao_do_lookup(sk, l3index, addr, AF_INET, sndid, rcvid);
 }
 
 int tcp_ao_prepare_reset(const struct sock *sk, struct sk_buff *skb,
@@ -738,7 +749,8 @@ int tcp_ao_prepare_reset(const struct sock *sk, struct sk_buff *skb,
 		ao_info = rcu_dereference(tcp_sk(sk)->ao_info);
 		if (!ao_info)
 			return -ENOENT;
-		*key = tcp_ao_do_lookup(sk, addr, family, -1, aoh->rnext_keyid);
+		*key = tcp_ao_do_lookup(sk, l3index, addr, family,
+					-1, aoh->rnext_keyid);
 		if (!*key)
 			return -ENOENT;
 		*traffic_key = kmalloc(tcp_ao_digest_size(*key), GFP_ATOMIC);
@@ -814,24 +826,26 @@ int tcp_ao_transmit_skb(struct sock *sk, struct sk_buff *skb,
 
 static struct tcp_ao_key *tcp_ao_inbound_lookup(unsigned short int family,
 		const struct sock *sk, const struct sk_buff *skb,
-		int sndid, int rcvid)
+		int sndid, int rcvid, int l3index)
 {
 	if (family == AF_INET) {
 		const struct iphdr *iph = ip_hdr(skb);
 
-		return tcp_ao_do_lookup(sk, (union tcp_ao_addr *)&iph->saddr,
-				AF_INET, sndid, rcvid);
+		return tcp_ao_do_lookup(sk, l3index,
+					(union tcp_ao_addr *)&iph->saddr,
+					AF_INET, sndid, rcvid);
 	} else {
 		const struct ipv6hdr *iph = ipv6_hdr(skb);
 
-		return tcp_ao_do_lookup(sk, (union tcp_ao_addr *)&iph->saddr,
-				AF_INET6, sndid, rcvid);
+		return tcp_ao_do_lookup(sk, l3index,
+					(union tcp_ao_addr *)&iph->saddr,
+					AF_INET6, sndid, rcvid);
 	}
 }
 
 void tcp_ao_syncookie(struct sock *sk, const struct sk_buff *skb,
 		      struct tcp_request_sock *treq,
-		      unsigned short int family)
+		      unsigned short int family, int l3index)
 {
 	const struct tcphdr *th = tcp_hdr(skb);
 	const struct tcp_ao_hdr *aoh;
@@ -842,7 +856,7 @@ void tcp_ao_syncookie(struct sock *sk, const struct sk_buff *skb,
 	if (tcp_parse_auth_options(th, NULL, &aoh) || !aoh)
 		return;
 
-	key = tcp_ao_inbound_lookup(family, sk, skb, -1, aoh->keyid);
+	key = tcp_ao_inbound_lookup(family, sk, skb, -1, aoh->keyid, l3index);
 	if (!key)
 		/* Key not found, continue without TCP-AO */
 		return;
@@ -856,7 +870,7 @@ static enum skb_drop_reason
 tcp_ao_verify_hash(const struct sock *sk, const struct sk_buff *skb,
 		   unsigned short int family, struct tcp_ao_info *info,
 		   const struct tcp_ao_hdr *aoh, struct tcp_ao_key *key,
-		   u8 *traffic_key, u8 *phash, u32 sne)
+		   u8 *traffic_key, u8 *phash, u32 sne, int l3index)
 {
 	u8 maclen = aoh->length - sizeof(struct tcp_ao_hdr);
 	const struct tcphdr *th = tcp_hdr(skb);
@@ -867,7 +881,8 @@ tcp_ao_verify_hash(const struct sock *sk, const struct sk_buff *skb,
 		atomic64_inc(&info->counters.pkt_bad);
 		atomic64_inc(&key->pkt_bad);
 		tcp_hash_fail("AO hash wrong length", family, skb,
-			      "%u != %d", maclen, tcp_ao_maclen(key));
+			      "%u != %d L3index: %d", maclen,
+			      tcp_ao_maclen(key), l3index);
 		return SKB_DROP_REASON_TCP_AOFAILURE;
 	}
 
@@ -882,7 +897,8 @@ tcp_ao_verify_hash(const struct sock *sk, const struct sk_buff *skb,
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPAOBAD);
 		atomic64_inc(&info->counters.pkt_bad);
 		atomic64_inc(&key->pkt_bad);
-		tcp_hash_fail("AO hash mismatch", family, skb, "");
+		tcp_hash_fail("AO hash mismatch", family, skb,
+			      "L3index: %d", l3index);
 		kfree(hash_buf);
 		return SKB_DROP_REASON_TCP_AOFAILURE;
 	}
@@ -896,7 +912,7 @@ tcp_ao_verify_hash(const struct sock *sk, const struct sk_buff *skb,
 enum skb_drop_reason
 tcp_inbound_ao_hash(struct sock *sk, const struct sk_buff *skb,
 		    unsigned short int family, const struct request_sock *req,
-		    const struct tcp_ao_hdr *aoh)
+		    int l3index, const struct tcp_ao_hdr *aoh)
 {
 	const struct tcphdr *th = tcp_hdr(skb);
 	u8 *phash = (u8 *)(aoh + 1); /* hash goes just after the header */
@@ -911,7 +927,7 @@ tcp_inbound_ao_hash(struct sock *sk, const struct sk_buff *skb,
 	if (!info) {
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPAOKEYNOTFOUND);
 		tcp_hash_fail("AO key not found", family, skb,
-			      "keyid: %u", aoh->keyid);
+			      "keyid: %u L3index: %d", aoh->keyid, l3index);
 		return SKB_DROP_REASON_TCP_AOUNEXPECTED;
 	}
 
@@ -945,7 +961,7 @@ tcp_inbound_ao_hash(struct sock *sk, const struct sk_buff *skb,
 		/* Established socket, traffic key are cached */
 		traffic_key = rcv_other_key(key);
 		err = tcp_ao_verify_hash(sk, skb, family, info, aoh, key,
-					 traffic_key, phash, sne);
+					 traffic_key, phash, sne, l3index);
 		if (err)
 			return err;
 		current_key = READ_ONCE(info->current_key);
@@ -966,7 +982,7 @@ tcp_inbound_ao_hash(struct sock *sk, const struct sk_buff *skb,
 	 * - request sockets would race on those key pointers
 	 * - tcp_ao_del_cmd() allows async key removal
 	 */
-	key = tcp_ao_inbound_lookup(family, sk, skb, -1, aoh->keyid);
+	key = tcp_ao_inbound_lookup(family, sk, skb, -1, aoh->keyid, l3index);
 	if (!key)
 		goto key_not_found;
 
@@ -1006,7 +1022,7 @@ tcp_inbound_ao_hash(struct sock *sk, const struct sk_buff *skb,
 		return SKB_DROP_REASON_NOT_SPECIFIED;
 	tcp_ao_calc_key_skb(key, traffic_key, skb, sisn, disn, family);
 	ret = tcp_ao_verify_hash(sk, skb, family, info, aoh, key,
-				 traffic_key, phash, sne);
+				 traffic_key, phash, sne, l3index);
 	kfree(traffic_key);
 	return ret;
 
@@ -1014,7 +1030,7 @@ tcp_inbound_ao_hash(struct sock *sk, const struct sk_buff *skb,
 	NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPAOKEYNOTFOUND);
 	atomic64_inc(&info->counters.key_not_found);
 	tcp_hash_fail("Requested by the peer AO key id not found",
-		      family, skb, "");
+		      family, skb, "L3index: %d", l3index);
 	return SKB_DROP_REASON_TCP_AOKEYNOTFOUND;
 }
 
@@ -1042,7 +1058,7 @@ void tcp_ao_connect_init(struct sock *sk)
 	struct tcp_ao_info *ao_info;
 	union tcp_ao_addr *addr;
 	struct tcp_ao_key *key;
-	int family;
+	int family, l3index;
 
 	ao_info = rcu_dereference_protected(tp->ao_info,
 					    lockdep_sock_is_held(sk));
@@ -1059,9 +1075,11 @@ void tcp_ao_connect_init(struct sock *sk)
 #endif
 	else
 		return;
+	l3index = l3mdev_master_ifindex_by_index(sock_net(sk),
+						 sk->sk_bound_dev_if);
 
 	hlist_for_each_entry_rcu(key, &ao_info->head, node) {
-		if (!tcp_ao_key_cmp(key, addr, key->prefixlen, family, -1, -1))
+		if (!tcp_ao_key_cmp(key, l3index, addr, key->prefixlen, family, -1, -1))
 			continue;
 
 		if (key == ao_info->current_key)
@@ -1131,9 +1149,9 @@ int tcp_ao_copy_all_matching(const struct sock *sk, struct sock *newsk,
 	struct tcp_ao_key *key, *new_key, *first_key;
 	struct tcp_ao_info *new_ao, *ao;
 	struct hlist_node *key_head;
+	int l3index, ret = -ENOMEM;
 	union tcp_ao_addr *addr;
 	bool match = false;
-	int ret = -ENOMEM;
 
 	ao = rcu_dereference(tcp_sk(sk)->ao_info);
 	if (!ao)
@@ -1161,9 +1179,11 @@ int tcp_ao_copy_all_matching(const struct sock *sk, struct sock *newsk,
 		ret = -EAFNOSUPPORT;
 		goto free_ao;
 	}
+	l3index = l3mdev_master_ifindex_by_index(sock_net(newsk),
+						 newsk->sk_bound_dev_if);
 
 	hlist_for_each_entry_rcu(key, &ao->head, node) {
-		if (tcp_ao_key_cmp(key, addr, key->prefixlen, family, -1, -1))
+		if (tcp_ao_key_cmp(key, l3index, addr, key->prefixlen, family, -1, -1))
 			continue;
 
 		new_key = tcp_ao_copy_key(newsk, key);
@@ -1467,7 +1487,8 @@ static struct tcp_ao_info *setsockopt_ao_info(struct sock *sk)
 	return ERR_PTR(-ESOCKTNOSUPPORT);
 }
 
-#define TCP_AO_KEYF_ALL		(TCP_AO_KEYF_EXCLUDE_OPT)
+#define TCP_AO_KEYF_ALL (TCP_AO_KEYF_IFINDEX | TCP_AO_KEYF_EXCLUDE_OPT)
+#define TCP_AO_GET_KEYF_VALID	(TCP_AO_KEYF_IFINDEX)
 
 static struct tcp_ao_key *tcp_ao_key_alloc(struct sock *sk,
 					   struct tcp_ao_add *cmd)
@@ -1531,8 +1552,8 @@ static int tcp_ao_add_cmd(struct sock *sk, unsigned short int family,
 	union tcp_ao_addr *addr;
 	struct tcp_ao_key *key;
 	struct tcp_ao_add cmd;
+	int ret, l3index = 0;
 	bool first = false;
-	int ret;
 
 	if (optlen < sizeof(cmd))
 		return -EINVAL;
@@ -1562,9 +1583,46 @@ static int tcp_ao_add_cmd(struct sock *sk, unsigned short int family,
 			return -EINVAL;
 	}
 
+	if (cmd.ifindex && !(cmd.keyflags & TCP_AO_KEYF_IFINDEX))
+		return -EINVAL;
+
+	/* For cmd.tcp_ifindex = 0 the key will apply to the default VRF */
+	if (cmd.keyflags & TCP_AO_KEYF_IFINDEX && cmd.ifindex) {
+		int bound_dev_if = READ_ONCE(sk->sk_bound_dev_if);
+		struct net_device *dev;
+
+		rcu_read_lock();
+		dev = dev_get_by_index_rcu(sock_net(sk), cmd.ifindex);
+		if (dev && netif_is_l3_master(dev))
+			l3index = dev->ifindex;
+		rcu_read_unlock();
+
+		if (!dev || !l3index)
+			return -EINVAL;
+
+		/* It's still possible to bind after adding keys or even
+		 * re-bind to a different dev (with CAP_NET_RAW).
+		 * So, no reason to return error here, rather try to be
+		 * nice and warn the user.
+		 */
+		if (bound_dev_if && bound_dev_if != cmd.ifindex)
+			net_warn_ratelimited("AO key ifindex %d != sk bound ifindex %d\n",
+					     cmd.ifindex, bound_dev_if);
+	}
+
 	/* Don't allow keys for peers that have a matching TCP-MD5 key */
-	if (tcp_md5_do_lookup_any_l3index(sk, addr, family))
-		return -EKEYREJECTED;
+	if (cmd.keyflags & TCP_AO_KEYF_IFINDEX) {
+		/* Non-_exact version of tcp_md5_do_lookup() will
+		 * as well match keys that aren't bound to a specific VRF
+		 * (that will make them match AO key with
+		 * sysctl_tcp_l3dev_accept = 1
+		 */
+		if (tcp_md5_do_lookup(sk, l3index, addr, family))
+			return -EKEYREJECTED;
+	} else {
+		if (tcp_md5_do_lookup_any_l3index(sk, addr, family))
+			return -EKEYREJECTED;
+	}
 
 	ao_info = setsockopt_ao_info(sk);
 	if (IS_ERR(ao_info))
@@ -1581,10 +1639,9 @@ static int tcp_ao_add_cmd(struct sock *sk, unsigned short int family,
 		 * > The IDs of MKTs MUST NOT overlap where their
 		 * > TCP connection identifiers overlap.
 		 */
-		if (__tcp_ao_do_lookup(sk, addr, family,
-				       cmd.prefix, -1, cmd.rcvid))
+		if (__tcp_ao_do_lookup(sk, l3index, addr, family, cmd.prefix, -1, cmd.rcvid))
 			return -EEXIST;
-		if (__tcp_ao_do_lookup(sk, addr, family,
+		if (__tcp_ao_do_lookup(sk, l3index, addr, family,
 				       cmd.prefix, cmd.sndid, -1))
 			return -EEXIST;
 	}
@@ -1603,6 +1660,7 @@ static int tcp_ao_add_cmd(struct sock *sk, unsigned short int family,
 	key->keyflags	= cmd.keyflags;
 	key->sndid	= cmd.sndid;
 	key->rcvid	= cmd.rcvid;
+	key->l3index	= l3index;
 	atomic64_set(&key->pkt_good, 0);
 	atomic64_set(&key->pkt_bad, 0);
 
@@ -1691,17 +1749,17 @@ static int tcp_ao_delete_key(struct sock *sk, struct tcp_ao_info *ao_info,
 	return err;
 }
 
+#define TCP_AO_DEL_KEYF_ALL (TCP_AO_KEYF_IFINDEX)
 static int tcp_ao_del_cmd(struct sock *sk, unsigned short int family,
 			  sockptr_t optval, int optlen)
 {
 	struct tcp_ao_key *key, *new_current = NULL, *new_rnext = NULL;
+	int err, addr_len, l3index = 0;
 	struct tcp_ao_info *ao_info;
 	union tcp_ao_addr *addr;
 	struct tcp_ao_del cmd;
-	int addr_len;
 	__u8 prefix;
 	u16 port;
-	int err;
 
 	if (optlen < sizeof(cmd))
 		return -EINVAL;
@@ -1718,6 +1776,17 @@ static int tcp_ao_del_cmd(struct sock *sk, unsigned short int family,
 			return -EINVAL;
 	}
 
+	if (cmd.keyflags & ~TCP_AO_DEL_KEYF_ALL)
+		return -EINVAL;
+
+	/* No sanity check for TCP_AO_KEYF_IFINDEX as if a VRF
+	 * was destroyed, there still should be a way to delete keys,
+	 * that were bound to that l3intf. So, fail late at lookup stage
+	 * if there is no key for that ifindex.
+	 */
+	if (cmd.ifindex && !(cmd.keyflags & TCP_AO_KEYF_IFINDEX))
+		return -EINVAL;
+
 	ao_info = setsockopt_ao_info(sk);
 	if (IS_ERR(ao_info))
 		return PTR_ERR(ao_info);
@@ -1785,6 +1854,13 @@ static int tcp_ao_del_cmd(struct sock *sk, unsigned short int family,
 		    memcmp(addr, &key->addr, addr_len))
 			continue;
 
+		if ((cmd.keyflags & TCP_AO_KEYF_IFINDEX) !=
+		    (key->keyflags & TCP_AO_KEYF_IFINDEX))
+			continue;
+
+		if (key->l3index != l3index)
+			continue;
+
 		if (key == new_current || key == new_rnext)
 			continue;
 
@@ -1970,10 +2046,10 @@ static int tcp_ao_copy_mkts_to_user(struct tcp_ao_info *ao_info,
 	struct tcp_ao_key *key, *current_key;
 	bool do_address_matching = true;
 	union tcp_ao_addr *addr = NULL;
+	int err, l3index, user_len;
 	unsigned int max_keys;	/* maximum number of keys to copy to user */
 	size_t out_offset = 0;
 	size_t bytes_to_write;	/* number of bytes to write to user level */
-	int err, user_len;
 	u32 matched_keys;	/* keys from ao_info matched so far */
 	int optlen_out;
 	__be16 port = 0;
@@ -1992,11 +2068,16 @@ static int tcp_ao_copy_mkts_to_user(struct tcp_ao_info *ao_info,
 
 	if (opt_in.pkt_good || opt_in.pkt_bad)
 		return -EINVAL;
+	if (opt_in.keyflags & ~TCP_AO_GET_KEYF_VALID)
+		return -EINVAL;
+	if (opt_in.ifindex && !(opt_in.keyflags & TCP_AO_KEYF_IFINDEX))
+		return -EINVAL;
 
 	if (opt_in.reserved != 0)
 		return -EINVAL;
 
 	max_keys = opt_in.nkeys;
+	l3index = (opt_in.keyflags & TCP_AO_KEYF_IFINDEX) ? opt_in.ifindex : -1;
 
 	if (opt_in.get_all || opt_in.is_current || opt_in.is_rnext) {
 		if (opt_in.get_all && (opt_in.is_current || opt_in.is_rnext))
@@ -2098,7 +2179,7 @@ static int tcp_ao_copy_mkts_to_user(struct tcp_ao_info *ao_info,
 			continue;
 		}
 
-		if (tcp_ao_key_cmp(key, addr, opt_in.prefix,
+		if (tcp_ao_key_cmp(key, l3index, addr, opt_in.prefix,
 				   opt_in.addr.ss_family,
 				   opt_in.sndid, opt_in.rcvid) != 0)
 			continue;
@@ -2131,6 +2212,7 @@ static int tcp_ao_copy_mkts_to_user(struct tcp_ao_info *ao_info,
 		opt_out.nkeys = 0;
 		opt_out.maclen = key->maclen;
 		opt_out.keylen = key->keylen;
+		opt_out.ifindex = key->l3index;
 		opt_out.pkt_good = atomic64_read(&key->pkt_good);
 		opt_out.pkt_bad = atomic64_read(&key->pkt_bad);
 		memcpy(&opt_out.key, key->key, key->keylen);
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index cb314a28010f..0a670b47a282 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1086,6 +1086,7 @@ static void tcp_v4_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
 	    tcp_rsk_used_ao(req)) {
 		const union tcp_md5_addr *addr;
 		const struct tcp_ao_hdr *aoh;
+		int l3index;
 
 		/* Invalid TCP option size or twice included auth */
 		if (tcp_parse_auth_options(tcp_hdr(skb), NULL, &aoh))
@@ -1094,11 +1095,12 @@ static void tcp_v4_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
 			return;
 
 		addr = (union tcp_md5_addr *)&ip_hdr(skb)->saddr;
-		key.ao_key = tcp_ao_do_lookup(sk, addr, AF_INET,
+		l3index = tcp_v4_sdif(skb) ? inet_iif(skb) : 0;
+		key.ao_key = tcp_ao_do_lookup(sk, l3index, addr, AF_INET,
 					      aoh->rnext_keyid, -1);
 		if (unlikely(!key.ao_key)) {
 			/* Send ACK with any matching MKT for the peer */
-			key.ao_key = tcp_ao_do_lookup(sk, addr, AF_INET, -1, -1);
+			key.ao_key = tcp_ao_do_lookup(sk, l3index, addr, AF_INET, -1, -1);
 			/* Matching key disappeared (user removed the key?)
 			 * let the handshake timeout.
 			 */
@@ -1492,6 +1494,7 @@ static int tcp_v4_parse_md5_keys(struct sock *sk, int optname,
 	const union tcp_md5_addr *addr;
 	u8 prefixlen = 32;
 	int l3index = 0;
+	bool l3flag;
 	u8 flags;
 
 	if (optlen < sizeof(cmd))
@@ -1504,6 +1507,7 @@ static int tcp_v4_parse_md5_keys(struct sock *sk, int optname,
 		return -EINVAL;
 
 	flags = cmd.tcpm_flags & TCP_MD5SIG_FLAG_IFINDEX;
+	l3flag = cmd.tcpm_flags & TCP_MD5SIG_FLAG_IFINDEX;
 
 	if (optname == TCP_MD5SIG_EXT &&
 	    cmd.tcpm_flags & TCP_MD5SIG_FLAG_PREFIX) {
@@ -1541,7 +1545,7 @@ static int tcp_v4_parse_md5_keys(struct sock *sk, int optname,
 	/* Don't allow keys for peers that have a matching TCP-AO key.
 	 * See the comment in tcp_ao_add_cmd()
 	 */
-	if (tcp_ao_required(sk, addr, AF_INET, false))
+	if (tcp_ao_required(sk, addr, AF_INET, l3flag ? l3index : -1, false))
 		return -EKEYREJECTED;
 
 	return tcp_md5_do_add(sk, addr, AF_INET, prefixlen, l3index, flags,
diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
index ad7a8caa7b2a..500f6ed3b8cf 100644
--- a/net/ipv6/syncookies.c
+++ b/net/ipv6/syncookies.c
@@ -140,6 +140,7 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 	struct dst_entry *dst;
 	__u8 rcv_wscale;
 	u32 tsoff = 0;
+	int l3index;
 
 	if (!READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_syncookies) ||
 	    !th->ack || th->rst)
@@ -214,7 +215,9 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 	treq->snt_isn = cookie;
 	treq->ts_off = 0;
 	treq->txhash = net_tx_rndhash();
-	tcp_ao_syncookie(sk, skb, treq, AF_INET6);
+
+	l3index = l3mdev_master_ifindex_by_index(sock_net(sk), ireq->ir_iif);
+	tcp_ao_syncookie(sk, skb, treq, AF_INET6, l3index);
 
 	if (IS_ENABLED(CONFIG_SMC))
 		ireq->smc_ok = 0;
diff --git a/net/ipv6/tcp_ao.c b/net/ipv6/tcp_ao.c
index 8b04611c9078..3c09ac26206e 100644
--- a/net/ipv6/tcp_ao.c
+++ b/net/ipv6/tcp_ao.c
@@ -87,30 +87,29 @@ int tcp_v6_ao_calc_key_rsk(struct tcp_ao_key *mkt, u8 *key,
 			htonl(tcp_rsk(req)->rcv_isn));
 }
 
-struct tcp_ao_key *tcp_v6_ao_do_lookup(const struct sock *sk,
-				       const struct in6_addr *addr,
-				       int sndid, int rcvid)
-{
-	return tcp_ao_do_lookup(sk, (union tcp_ao_addr *)addr, AF_INET6,
-				sndid, rcvid);
-}
-
 struct tcp_ao_key *tcp_v6_ao_lookup(const struct sock *sk,
 				    struct sock *addr_sk,
 				    int sndid, int rcvid)
 {
+	int l3index = l3mdev_master_ifindex_by_index(sock_net(sk),
+						     addr_sk->sk_bound_dev_if);
 	struct in6_addr *addr = &addr_sk->sk_v6_daddr;
 
-	return tcp_v6_ao_do_lookup(sk, addr, sndid, rcvid);
+	return tcp_ao_do_lookup(sk, l3index, (union tcp_ao_addr *)addr,
+				AF_INET6, sndid, rcvid);
 }
 
 struct tcp_ao_key *tcp_v6_ao_lookup_rsk(const struct sock *sk,
 					struct request_sock *req,
 					int sndid, int rcvid)
 {
-	struct in6_addr *addr = &inet_rsk(req)->ir_v6_rmt_addr;
+	struct inet_request_sock *ireq = inet_rsk(req);
+	struct in6_addr *addr = &ireq->ir_v6_rmt_addr;
+	int l3index;
 
-	return tcp_v6_ao_do_lookup(sk, addr, sndid, rcvid);
+	l3index = l3mdev_master_ifindex_by_index(sock_net(sk), ireq->ir_iif);
+	return tcp_ao_do_lookup(sk, l3index, (union tcp_ao_addr *)addr,
+				AF_INET6, sndid, rcvid);
 }
 
 int tcp_v6_ao_hash_pseudoheader(struct tcp_sigpool *hp,
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index e71708dc011c..d3c95dbfb207 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -609,6 +609,7 @@ static int tcp_v6_parse_md5_keys(struct sock *sk, int optname,
 	union tcp_ao_addr *addr;
 	int l3index = 0;
 	u8 prefixlen;
+	bool l3flag;
 	u8 flags;
 
 	if (optlen < sizeof(cmd))
@@ -621,6 +622,7 @@ static int tcp_v6_parse_md5_keys(struct sock *sk, int optname,
 		return -EINVAL;
 
 	flags = cmd.tcpm_flags & TCP_MD5SIG_FLAG_IFINDEX;
+	l3flag = cmd.tcpm_flags & TCP_MD5SIG_FLAG_IFINDEX;
 
 	if (optname == TCP_MD5SIG_EXT &&
 	    cmd.tcpm_flags & TCP_MD5SIG_FLAG_PREFIX) {
@@ -667,7 +669,8 @@ static int tcp_v6_parse_md5_keys(struct sock *sk, int optname,
 		/* Don't allow keys for peers that have a matching TCP-AO key.
 		 * See the comment in tcp_ao_add_cmd()
 		 */
-		if (tcp_ao_required(sk, addr, AF_INET, false))
+		if (tcp_ao_required(sk, addr, AF_INET,
+				    l3flag ? l3index : -1, false))
 			return -EKEYREJECTED;
 		return tcp_md5_do_add(sk, addr,
 				      AF_INET, prefixlen, l3index, flags,
@@ -679,7 +682,7 @@ static int tcp_v6_parse_md5_keys(struct sock *sk, int optname,
 	/* Don't allow keys for peers that have a matching TCP-AO key.
 	 * See the comment in tcp_ao_add_cmd()
 	 */
-	if (tcp_ao_required(sk, addr, AF_INET6, false))
+	if (tcp_ao_required(sk, addr, AF_INET6, l3flag ? l3index : -1, false))
 		return -EKEYREJECTED;
 
 	return tcp_md5_do_add(sk, addr, AF_INET6, prefixlen, l3index, flags,
@@ -1217,10 +1220,14 @@ static void tcp_v6_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
 			return;
 		if (!aoh)
 			return;
-		key.ao_key = tcp_v6_ao_do_lookup(sk, addr, aoh->rnext_keyid, -1);
+		key.ao_key = tcp_ao_do_lookup(sk, l3index,
+					      (union tcp_ao_addr *)addr,
+					      AF_INET6, aoh->rnext_keyid, -1);
 		if (unlikely(!key.ao_key)) {
 			/* Send ACK with any matching MKT for the peer */
-			key.ao_key = tcp_v6_ao_do_lookup(sk, addr, -1, -1);
+			key.ao_key = tcp_ao_do_lookup(sk, l3index,
+						      (union tcp_ao_addr *)addr,
+						      AF_INET6, -1, -1);
 			/* Matching key disappeared (user removed the key?)
 			 * let the handshake timeout.
 			 */
-- 
2.42.0

