Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3D97D405A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 21:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjJWTf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 15:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbjJWTXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 15:23:46 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0DC19A1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 12:23:06 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b95d5ee18dso58019271fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 12:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1698088981; x=1698693781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ogTBmilbYwjvOrqdvd5xSwoqZq6DdeNin62x3XORTDI=;
        b=kQ/oA2c7+lJu16nLRNPBd6K7m3iD2AF/FR/7lGKR4GLQK1CY/KOOdcwBgGA7SrMGCm
         QE1geKLtiQcvvreWIv5zyyTFL3ltvE1wpjwuOy9+xCvhwnBg7pFFlJ1ypJbw+P69DxwZ
         50ZIy/+iSn+XGd0loC3rm9P7G+RbLq8xpo8gTEQCGf6+HjB0ASA3d93CtPt1+3Armyuy
         tRa/ZEAIaLJr0h1rbEwjTtQwz41UlUO1M/INogQpmwCiMh2UPAvBhi9zTRuaDaGzTVdP
         et9KvUYGyfNX8FSbcVyAt/SiICxH681CuJyTEtX974OV91WiyUDhQKL5802GE3EtbF/u
         CqIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698088981; x=1698693781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ogTBmilbYwjvOrqdvd5xSwoqZq6DdeNin62x3XORTDI=;
        b=M7c+R+sFh0OwX0s3q64dvT5TVdwDVv3PZaD/INKaMK7MeX6u34LaJm46rsAwLMEJ01
         uAc157dO6gUpFZsUFoPwzeqAqwJL/jcB4uA4run5yVsgic/wMf2xYUq42Mkou10hLmaA
         wvzwdGvcmVF/PDItTkH+43bCYezRDTYcuL4VJA9z1cK4Dkrcb8GTa7ih3HE5/vSnH45K
         xikK+sPQLyfWmKc8ciEn6UXy/ceRcx7rP6L5mdsIYeA8/cE9rhatkN97CpUTXfdRiHHy
         oRwhHi4yM1gZYxI2YsD/RmrucsjCcIS8qjYIrbyxUEx0b5DvhEQZYAJYZIo0eEilKTbE
         ecyw==
X-Gm-Message-State: AOJu0YylJBzyrJ1rx5Dm4OKR1VM+aENMz+8w0/804bBpkdnOdnBNjpO5
        Fc9Q4JRD61Nwp2kCCtuWveqjRA==
X-Google-Smtp-Source: AGHT+IHo31C7RttI/jxIhlzj1sRbyqW0Zwl90WeX6JpgRwTXaeLlPlXhjdQwD+fUNdo28IsIGLiOew==
X-Received: by 2002:a05:651c:1503:b0:2c5:1f20:926c with SMTP id e3-20020a05651c150300b002c51f20926cmr7676700ljf.11.1698088980794;
        Mon, 23 Oct 2023 12:23:00 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id ay20-20020a05600c1e1400b00407460234f9sm10142088wmb.21.2023.10.23.12.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 12:23:00 -0700 (PDT)
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
Subject: [PATCH v16 net-next 18/23] net/tcp: Add TCP-AO getsockopt()s
Date:   Mon, 23 Oct 2023 20:22:10 +0100
Message-ID: <20231023192217.426455-19-dima@arista.com>
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
index a9d38b9e8bcb..061c358a3c8a 100644
--- a/include/net/tcp_ao.h
+++ b/include/net/tcp_ao.h
@@ -194,6 +194,8 @@ int tcp_ao_calc_traffic_key(struct tcp_ao_key *mkt, u8 *key, void *ctx,
 void tcp_ao_destroy_sock(struct sock *sk, bool twsk);
 void tcp_ao_time_wait(struct tcp_timewait_sock *tcptw, struct tcp_sock *tp);
 bool tcp_ao_ignore_icmp(const struct sock *sk, int family, int type, int code);
+int tcp_ao_get_mkts(struct sock *sk, sockptr_t optval, sockptr_t optlen);
+int tcp_ao_get_sock_info(struct sock *sk, sockptr_t optval, sockptr_t optlen);
 enum skb_drop_reason tcp_inbound_ao_hash(struct sock *sk,
 			const struct sk_buff *skb, unsigned short int family,
 			const struct request_sock *req,
@@ -316,6 +318,16 @@ static inline void tcp_ao_time_wait(struct tcp_timewait_sock *tcptw,
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
index 320aab010f9a..201b3cbd6020 100644
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
@@ -405,21 +406,55 @@ struct tcp_ao_del { /* setsockopt(TCP_AO_DEL_KEY) */
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
index 8594a4bf764e..a3107c28ea5f 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4282,6 +4282,19 @@ int do_tcp_getsockopt(struct sock *sk, int level,
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
index 10cc6be4d537..cbc1ee0f5b9a 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -1894,3 +1894,298 @@ int tcp_v4_parse_ao(struct sock *sk, int cmd, sockptr_t optval, int optlen)
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
2.42.0

