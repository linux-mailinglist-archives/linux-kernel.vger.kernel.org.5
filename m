Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B0776D549
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbjHBR3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233675AbjHBR2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:28:05 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3273C13
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 10:27:38 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fbea14700bso984245e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 10:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1690997255; x=1691602055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fyxJvHd8ra0wzS3P1RMC8FvSCpooTvH2mSECr+AhuVQ=;
        b=f8ya2G2wEOw3mK6UIGcJz1vO93q/DQMccJXVBYSLub7W6KJ2JDSenkekCQMSyQagZj
         Bn4DPyf2DYrx2u8THsonIEXWV4Y7B+J2SIO7kDiVVaPoishqEeyzM0sR9r2ETlvOrqjE
         OlEwTzaJm1Ea5fqxgP1X6jmHHZL/ezJGhaGFafmiJ9dz/mKQFeVcfW2KkbA7gx5nRg48
         uACpN9sTDTqu1e8MvoAcUL2uCn4bFsZdB7jnDqfbfXmMgCN0PQMfJ4mbI2ZOWXVdBGuG
         9itoX/EXW6E0WDZ5o/rxpwhkqaYb8ThSLONr2j91NCXeUo6QajnVqbJi8p0g/XKd0613
         wPPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690997255; x=1691602055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fyxJvHd8ra0wzS3P1RMC8FvSCpooTvH2mSECr+AhuVQ=;
        b=aSsIVZxnMpxBM7+Cdf3KNgJrB6FDk6ozABzirewqGCSDPm/Yz3yr2XXf2ocL9KUYB4
         ZB1f5cW6aMiXmk1CEhjTYS6D9akBPHE5aBPr1AmL0WVIH9hNugchzkIkWPyvV9Z9Btqt
         pLArNu4xUM6T76PtzBoU9vJwS9oBtnsKp1xgvAg4UN0aE+KxtsrQVLs/U+oawq3EVI2v
         giwO5K7ex3l+AY1te7A7mHPHuWjmMatyh6pk6kOAmB9Zm1/apbBfFXFBNAgu/p/zUZmq
         +MzHnA90vXAH8+YcaQP7zZjGTisXkqsML7VdKWsdMDExFjTDhV5Vrp9CzIeEg6akYk48
         n9cA==
X-Gm-Message-State: ABy/qLY0eDDU1nDYasJ7OZtj78WM+hr7nQ4Oy/p6hTpWxTojvgXyf3W2
        AzrUJ3xqIVuOzg60ltK4R1PzkQ==
X-Google-Smtp-Source: APBJJlEbvY3o840VkvxYGK6SZCo1IAcNBLKPwZNNlDbinoTY9dUYT5kX+aA6oFG332874t6MzZKaQg==
X-Received: by 2002:a7b:c316:0:b0:3fe:1923:2c3 with SMTP id k22-20020a7bc316000000b003fe192302c3mr5331437wmj.30.1690997255287;
        Wed, 02 Aug 2023 10:27:35 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id q5-20020a1ce905000000b003fbc0a49b57sm2221770wmc.6.2023.08.02.10.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 10:27:34 -0700 (PDT)
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
Subject: [PATCH v9 net-next 18/23] net/tcp: Add TCP-AO getsockopt()s
Date:   Wed,  2 Aug 2023 18:26:45 +0100
Message-ID: <20230802172654.1467777-19-dima@arista.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802172654.1467777-1-dima@arista.com>
References: <20230802172654.1467777-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce getsockopt(TCP_AO_GET_KEYS) that lets a user get TCP-AO keys
and their properties from a socket. The user can provide a filter
to match the specific key to be dumped or ::get_all = 1 may be
used to dump all keys in one syscall.

Add another getsockopt(TCP_AO_INFO) for providing per-socket/per-ao_info
stats: packet counters, Current_key/RNext_key and flags like
::ao_required and ::accept_icmps.

Co-developed-by: Francesco Ruggeri <fruggeri@arista.com>
Signed-off-by: Francesco Ruggeri <fruggeri@arista.com>
Co-developed-by: Salam Noureddine <noureddine@arista.com>
Signed-off-by: Salam Noureddine <noureddine@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
Acked-by: David Ahern <dsahern@kernel.org>
---
 include/net/tcp_ao.h     |  12 ++
 include/uapi/linux/tcp.h |  63 +++++++--
 net/ipv4/tcp.c           |  13 ++
 net/ipv4/tcp_ao.c        | 295 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 369 insertions(+), 14 deletions(-)

diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
index 94fde002b638..bd616e070eda 100644
--- a/include/net/tcp_ao.h
+++ b/include/net/tcp_ao.h
@@ -192,6 +192,8 @@ int tcp_ao_calc_traffic_key(struct tcp_ao_key *mkt, u8 *key, void *ctx,
 void tcp_ao_destroy_sock(struct sock *sk, bool twsk);
 void tcp_ao_time_wait(struct tcp_timewait_sock *tcptw, struct tcp_sock *tp);
 bool tcp_ao_ignore_icmp(struct sock *sk, int type, int code);
+int tcp_ao_get_mkts(struct sock *sk, sockptr_t optval, sockptr_t optlen);
+int tcp_ao_get_sock_info(struct sock *sk, sockptr_t optval, sockptr_t optlen);
 enum skb_drop_reason tcp_inbound_ao_hash(struct sock *sk,
 			const struct sk_buff *skb, unsigned short int family,
 			const struct request_sock *req,
@@ -301,6 +303,16 @@ static inline void tcp_ao_time_wait(struct tcp_timewait_sock *tcptw,
 static inline void tcp_ao_connect_init(struct sock *sk)
 {
 }
+
+static inline int tcp_ao_get_mkts(struct sock *sk, sockptr_t optval, sockptr_t optlen)
+{
+	return -ENOPROTOOPT;
+}
+
+static inline int tcp_ao_get_sock_info(struct sock *sk, sockptr_t optval, sockptr_t optlen)
+{
+	return -ENOPROTOOPT;
+}
 #endif
 
 #if defined(CONFIG_TCP_MD5SIG) || defined(CONFIG_TCP_AO)
diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
index 3275ade3293a..1109093bbb24 100644
--- a/include/uapi/linux/tcp.h
+++ b/include/uapi/linux/tcp.h
@@ -131,7 +131,8 @@ enum {
 
 #define TCP_AO_ADD_KEY		38	/* Add/Set MKT */
 #define TCP_AO_DEL_KEY		39	/* Delete MKT */
-#define TCP_AO_INFO		40	/* Modify TCP-AO per-socket options */
+#define TCP_AO_INFO		40	/* Set/list TCP-AO per-socket options */
+#define TCP_AO_GET_KEYS		41	/* List MKT(s) */
 
 #define TCP_REPAIR_ON		1
 #define TCP_REPAIR_OFF		0
@@ -392,21 +393,55 @@ struct tcp_ao_del { /* setsockopt(TCP_AO_DEL_KEY) */
 	__u8	keyflags;		/* see TCP_AO_KEYF_ */
 } __attribute__((aligned(8)));
 
-struct tcp_ao_info_opt { /* setsockopt(TCP_AO_INFO) */
-	__u32   set_current	:1,	/* corresponding ::current_key */
-		set_rnext	:1,	/* corresponding ::rnext */
-		ao_required	:1,	/* don't accept non-AO connects */
-		set_counters	:1,	/* set/clear ::pkt_* counters */
-		accept_icmps	:1,	/* accept incoming ICMPs */
+struct tcp_ao_info_opt { /* setsockopt(TCP_AO_INFO), getsockopt(TCP_AO_INFO) */
+	/* Here 'in' is for setsockopt(), 'out' is for getsockopt() */
+	__u32   set_current	:1,	/* in/out: corresponding ::current_key */
+		set_rnext	:1,	/* in/out: corresponding ::rnext */
+		ao_required	:1,	/* in/out: don't accept non-AO connects */
+		set_counters	:1,	/* in: set/clear ::pkt_* counters */
+		accept_icmps	:1,	/* in/out: accept incoming ICMPs */
 		reserved	:27;	/* must be 0 */
 	__u16	reserved2;		/* padding, must be 0 */
-	__u8	current_key;		/* KeyID to set as Current_key */
-	__u8	rnext;			/* KeyID to set as Rnext_key */
-	__u64	pkt_good;		/* verified segments */
-	__u64	pkt_bad;		/* failed verification */
-	__u64	pkt_key_not_found;	/* could not find a key to verify */
-	__u64	pkt_ao_required;	/* segments missing TCP-AO sign */
-	__u64	pkt_dropped_icmp;	/* ICMPs that were ignored */
+	__u8	current_key;		/* in/out: KeyID of Current_key */
+	__u8	rnext;			/* in/out: keyid of RNext_key */
+	__u64	pkt_good;		/* in/out: verified segments */
+	__u64	pkt_bad;		/* in/out: failed verification */
+	__u64	pkt_key_not_found;	/* in/out: could not find a key to verify */
+	__u64	pkt_ao_required;	/* in/out: segments missing TCP-AO sign */
+	__u64	pkt_dropped_icmp;	/* in/out: ICMPs that were ignored */
+} __attribute__((aligned(8)));
+
+struct tcp_ao_getsockopt { /* getsockopt(TCP_AO_GET_KEYS) */
+	struct __kernel_sockaddr_storage addr;	/* in/out: dump keys for peer
+						 * with this address/prefix
+						 */
+	char	alg_name[64];		/* out: crypto hash algorithm */
+	__u8	key[TCP_AO_MAXKEYLEN];
+	__u32	nkeys;			/* in: size of the userspace buffer
+					 * @optval, measured in @optlen - the
+					 * sizeof(struct tcp_ao_getsockopt)
+					 * out: number of keys that matched
+					 */
+	__u16   is_current	:1,	/* in: match and dump Current_key,
+					 * out: the dumped key is Current_key
+					 */
+
+		is_rnext	:1,	/* in: match and dump RNext_key,
+					 * out: the dumped key is RNext_key
+					 */
+		get_all		:1,	/* in: dump all keys */
+		reserved	:13;	/* padding, must be 0 */
+	__u8	sndid;			/* in/out: dump keys with SendID */
+	__u8	rcvid;			/* in/out: dump keys with RecvID */
+	__u8	prefix;			/* in/out: dump keys with address/prefix */
+	__u8	maclen;			/* out: key's length of authentication
+					 * code (hash)
+					 */
+	__u8	keyflags;		/* in/out: see TCP_AO_KEYF_ */
+	__u8	keylen;			/* out: length of ::key */
+	__s32	ifindex;		/* in/out: L3 dev index for VRF */
+	__u64	pkt_good;		/* out: verified segments */
+	__u64	pkt_bad;		/* out: segments that failed verification */
 } __attribute__((aligned(8)));
 
 /* setsockopt(fd, IPPROTO_TCP, TCP_ZEROCOPY_RECEIVE, ...) */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index c9c183550a96..a8208162847d 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4289,6 +4289,19 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 		return err;
 	}
 #endif
+	case TCP_AO_GET_KEYS:
+	case TCP_AO_INFO: {
+		int err;
+
+		sockopt_lock_sock(sk);
+		if (optname == TCP_AO_GET_KEYS)
+			err = tcp_ao_get_mkts(sk, optval, optlen);
+		else
+			err = tcp_ao_get_sock_info(sk, optval, optlen);
+		sockopt_release_sock(sk);
+
+		return err;
+	}
 	default:
 		return -ENOPROTOOPT;
 	}
diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index 0d10b437b0f9..1f7d5f192e1d 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -1847,3 +1847,298 @@ int tcp_v4_parse_ao(struct sock *sk, int cmd, sockptr_t optval, int optlen)
 	return tcp_parse_ao(sk, cmd, AF_INET, optval, optlen);
 }
 
+/* tcp_ao_copy_mkts_to_user(ao_info, optval, optlen)
+ *
+ * @ao_info:	struct tcp_ao_info on the socket that
+ *		socket getsockopt(TCP_AO_GET_KEYS) is executed on
+ * @optval:	pointer to array of tcp_ao_getsockopt structures in user space.
+ *		Must be != NULL.
+ * @optlen:	pointer to size of tcp_ao_getsockopt structure.
+ *		Must be != NULL.
+ *
+ * Return value: 0 on success, a negative error number otherwise.
+ *
+ * optval points to an array of tcp_ao_getsockopt structures in user space.
+ * optval[0] is used as both input and output to getsockopt. It determines
+ * which keys are returned by the kernel.
+ * optval[0].nkeys is the size of the array in user space. On return it contains
+ * the number of keys matching the search criteria.
+ * If tcp_ao_getsockopt::get_all is set, then all keys in the socket are
+ * returned, otherwise only keys matching <addr, prefix, sndid, rcvid>
+ * in optval[0] are returned.
+ * optlen is also used as both input and output. The user provides the size
+ * of struct tcp_ao_getsockopt in user space, and the kernel returns the size
+ * of the structure in kernel space.
+ * The size of struct tcp_ao_getsockopt may differ between user and kernel.
+ * There are three cases to consider:
+ *  * If usize == ksize, then keys are copied verbatim.
+ *  * If usize < ksize, then the userspace has passed an old struct to a
+ *    newer kernel. The rest of the trailing bytes in optval[0]
+ *    (ksize - usize) are interpreted as 0 by the kernel.
+ *  * If usize > ksize, then the userspace has passed a new struct to an
+ *    older kernel. The trailing bytes unknown to the kernel (usize - ksize)
+ *    are checked to ensure they are zeroed, otherwise -E2BIG is returned.
+ * On return the kernel fills in min(usize, ksize) in each entry of the array.
+ * The layout of the fields in the user and kernel structures is expected to
+ * be the same (including in the 32bit vs 64bit case).
+ */
+static int tcp_ao_copy_mkts_to_user(struct tcp_ao_info *ao_info,
+				    sockptr_t optval, sockptr_t optlen)
+{
+	struct tcp_ao_getsockopt opt_in, opt_out;
+	struct tcp_ao_key *key, *current_key;
+	bool do_address_matching = true;
+	union tcp_ao_addr *addr = NULL;
+	unsigned int max_keys;	/* maximum number of keys to copy to user */
+	size_t out_offset = 0;
+	size_t bytes_to_write;	/* number of bytes to write to user level */
+	int err, user_len;
+	u32 matched_keys;	/* keys from ao_info matched so far */
+	int optlen_out;
+	__be16 port = 0;
+
+	if (copy_from_sockptr(&user_len, optlen, sizeof(int)))
+		return -EFAULT;
+
+	if (user_len <= 0)
+		return -EINVAL;
+
+	memset(&opt_in, 0, sizeof(struct tcp_ao_getsockopt));
+	err = copy_struct_from_sockptr(&opt_in, sizeof(opt_in),
+				       optval, user_len);
+	if (err < 0)
+		return err;
+
+	if (opt_in.pkt_good || opt_in.pkt_bad)
+		return -EINVAL;
+
+	if (opt_in.reserved != 0)
+		return -EINVAL;
+
+	max_keys = opt_in.nkeys;
+
+	if (opt_in.get_all || opt_in.is_current || opt_in.is_rnext) {
+		if (opt_in.get_all && (opt_in.is_current || opt_in.is_rnext))
+			return -EINVAL;
+		do_address_matching = false;
+	}
+
+	switch (opt_in.addr.ss_family) {
+	case AF_INET: {
+		struct sockaddr_in *sin;
+		__be32 mask;
+
+		sin = (struct sockaddr_in *)&opt_in.addr;
+		port = sin->sin_port;
+		addr = (union tcp_ao_addr *)&sin->sin_addr;
+
+		if (opt_in.prefix > 32)
+			return -EINVAL;
+
+		if (ntohl(sin->sin_addr.s_addr) == INADDR_ANY &&
+		    opt_in.prefix != 0)
+			return -EINVAL;
+
+		mask = inet_make_mask(opt_in.prefix);
+		if (sin->sin_addr.s_addr & ~mask)
+			return -EINVAL;
+
+		break;
+	}
+	case AF_INET6: {
+		struct sockaddr_in6 *sin6;
+		struct in6_addr *addr6;
+
+		sin6 = (struct sockaddr_in6 *)&opt_in.addr;
+		addr = (union tcp_ao_addr *)&sin6->sin6_addr;
+		addr6 = &sin6->sin6_addr;
+		port = sin6->sin6_port;
+
+		/* We don't have to change family and @addr here if
+		 * ipv6_addr_v4mapped() like in key adding:
+		 * tcp_ao_key_cmp() does it. Do the sanity checks though.
+		 */
+		if (opt_in.prefix != 0) {
+			if (ipv6_addr_v4mapped(addr6)) {
+				__be32 mask, addr4 = addr6->s6_addr32[3];
+
+				if (opt_in.prefix > 32 ||
+				    ntohl(addr4) == INADDR_ANY)
+					return -EINVAL;
+				mask = inet_make_mask(opt_in.prefix);
+				if (addr4 & ~mask)
+					return -EINVAL;
+			} else {
+				struct in6_addr pfx;
+
+				if (ipv6_addr_any(addr6) ||
+				    opt_in.prefix > 128)
+					return -EINVAL;
+
+				ipv6_addr_prefix(&pfx, addr6, opt_in.prefix);
+				if (ipv6_addr_cmp(&pfx, addr6))
+					return -EINVAL;
+			}
+		} else if (!ipv6_addr_any(addr6)) {
+			return -EINVAL;
+		}
+		break;
+	}
+	case 0:
+		if (!do_address_matching)
+			break;
+		fallthrough;
+	default:
+		return -EAFNOSUPPORT;
+	}
+
+	if (!do_address_matching) {
+		/* We could just ignore those, but let's do stricter checks */
+		if (addr || port)
+			return -EINVAL;
+		if (opt_in.prefix || opt_in.sndid || opt_in.rcvid)
+			return -EINVAL;
+	}
+
+	bytes_to_write = min_t(int, user_len, sizeof(struct tcp_ao_getsockopt));
+	matched_keys = 0;
+	/* May change in RX, while we're dumping, pre-fetch it */
+	current_key = READ_ONCE(ao_info->current_key);
+
+	hlist_for_each_entry_rcu(key, &ao_info->head, node) {
+		if (opt_in.get_all)
+			goto match;
+
+		if (opt_in.is_current || opt_in.is_rnext) {
+			if (opt_in.is_current && key == current_key)
+				goto match;
+			if (opt_in.is_rnext && key == ao_info->rnext_key)
+				goto match;
+			continue;
+		}
+
+		if (tcp_ao_key_cmp(key, addr, opt_in.prefix,
+				   opt_in.addr.ss_family,
+				   opt_in.sndid, opt_in.rcvid) != 0)
+			continue;
+match:
+		matched_keys++;
+		if (matched_keys > max_keys)
+			continue;
+
+		memset(&opt_out, 0, sizeof(struct tcp_ao_getsockopt));
+
+		if (key->family == AF_INET) {
+			struct sockaddr_in *sin_out = (struct sockaddr_in *)&opt_out.addr;
+
+			sin_out->sin_family = key->family;
+			sin_out->sin_port = 0;
+			memcpy(&sin_out->sin_addr, &key->addr, sizeof(struct in_addr));
+		} else {
+			struct sockaddr_in6 *sin6_out = (struct sockaddr_in6 *)&opt_out.addr;
+
+			sin6_out->sin6_family = key->family;
+			sin6_out->sin6_port = 0;
+			memcpy(&sin6_out->sin6_addr, &key->addr, sizeof(struct in6_addr));
+		}
+		opt_out.sndid = key->sndid;
+		opt_out.rcvid = key->rcvid;
+		opt_out.prefix = key->prefixlen;
+		opt_out.keyflags = key->keyflags;
+		opt_out.is_current = (key == current_key);
+		opt_out.is_rnext = (key == ao_info->rnext_key);
+		opt_out.nkeys = 0;
+		opt_out.maclen = key->maclen;
+		opt_out.keylen = key->keylen;
+		opt_out.pkt_good = atomic64_read(&key->pkt_good);
+		opt_out.pkt_bad = atomic64_read(&key->pkt_bad);
+		memcpy(&opt_out.key, key->key, key->keylen);
+		tcp_sigpool_algo(key->tcp_sigpool_id, opt_out.alg_name, 64);
+
+		/* Copy key to user */
+		if (copy_to_sockptr_offset(optval, out_offset,
+					   &opt_out, bytes_to_write))
+			return -EFAULT;
+		out_offset += user_len;
+	}
+
+	optlen_out = (int)sizeof(struct tcp_ao_getsockopt);
+	if (copy_to_sockptr(optlen, &optlen_out, sizeof(int)))
+		return -EFAULT;
+
+	out_offset = offsetof(struct tcp_ao_getsockopt, nkeys);
+	if (copy_to_sockptr_offset(optval, out_offset,
+				   &matched_keys, sizeof(u32)))
+		return -EFAULT;
+
+	return 0;
+}
+
+int tcp_ao_get_mkts(struct sock *sk, sockptr_t optval, sockptr_t optlen)
+{
+	struct tcp_ao_info *ao_info;
+
+	ao_info = setsockopt_ao_info(sk);
+	if (IS_ERR(ao_info))
+		return PTR_ERR(ao_info);
+	if (!ao_info)
+		return -ENOENT;
+
+	return tcp_ao_copy_mkts_to_user(ao_info, optval, optlen);
+}
+
+int tcp_ao_get_sock_info(struct sock *sk, sockptr_t optval, sockptr_t optlen)
+{
+	struct tcp_ao_info_opt out, in = {};
+	struct tcp_ao_key *current_key;
+	struct tcp_ao_info *ao;
+	int err, len;
+
+	if (copy_from_sockptr(&len, optlen, sizeof(int)))
+		return -EFAULT;
+
+	if (len <= 0)
+		return -EINVAL;
+
+	/* Copying this "in" only to check ::reserved, ::reserved2,
+	 * that may be needed to extend (struct tcp_ao_info_opt) and
+	 * what getsockopt() provides in future.
+	 */
+	err = copy_struct_from_sockptr(&in, sizeof(in), optval, len);
+	if (err)
+		return err;
+
+	if (in.reserved != 0 || in.reserved2 != 0)
+		return -EINVAL;
+
+	ao = setsockopt_ao_info(sk);
+	if (IS_ERR(ao))
+		return PTR_ERR(ao);
+	if (!ao)
+		return -ENOENT;
+
+	memset(&out, 0, sizeof(out));
+	out.ao_required		= ao->ao_required;
+	out.accept_icmps	= ao->accept_icmps;
+	out.pkt_good		= atomic64_read(&ao->counters.pkt_good);
+	out.pkt_bad		= atomic64_read(&ao->counters.pkt_bad);
+	out.pkt_key_not_found	= atomic64_read(&ao->counters.key_not_found);
+	out.pkt_ao_required	= atomic64_read(&ao->counters.ao_required);
+	out.pkt_dropped_icmp	= atomic64_read(&ao->counters.dropped_icmp);
+
+	current_key = READ_ONCE(ao->current_key);
+	if (current_key) {
+		out.set_current = 1;
+		out.current_key = current_key->sndid;
+	}
+	if (ao->rnext_key) {
+		out.set_rnext = 1;
+		out.rnext = ao->rnext_key->rcvid;
+	}
+
+	if (copy_to_sockptr(optval, &out, min_t(int, len, sizeof(out))))
+		return -EFAULT;
+
+	return 0;
+}
+
-- 
2.41.0

