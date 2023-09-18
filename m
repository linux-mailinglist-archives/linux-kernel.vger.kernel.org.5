Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2796C7A528E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 21:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjIRTCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 15:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjIRTBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 15:01:25 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0908318D
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 12:01:01 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-401b393ddd2so55371635e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 12:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1695063660; x=1695668460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ofnd9o8HAlZpDpDBZepUDiINn+iAEq0Yrtm7L10GAM0=;
        b=gi7e1UAVGn12CACCTmQeEiZLPdhVmqdLyuOajEhUdbRA7GMYx5lLjwShAc5JJDAGj0
         Zm5VQokc4QvO4RIpUoYlRVc6hqeXqRWeQiQFQcFYiln3iMD4EGT2m9byjBq+mD0jWnAx
         Nk3UIWs0ZgjW8mAN7hBhlTrbz4agkSJY2lFfOPQhzsIsrvvQslQqLleEt60Gu11tBnNG
         ZY0AGmPO1Jm1cQqla/rgFGCIfbBrI1mk5bntUc3IUOKxwOYGACuEyND5mV3c3mqXDpY6
         vadb7+Oou4xMJuybew2LA+QOaj3j7aQW6ri3j43l+YCx/bhxrbBG3j7d+3AQCh5XvzSZ
         mbEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695063660; x=1695668460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ofnd9o8HAlZpDpDBZepUDiINn+iAEq0Yrtm7L10GAM0=;
        b=lK5KlBN407tibHk2+4nVgUn/F67Ta9Ua4tCxXlKY1gIWMgDCfnK8sTO+rjM7iREatW
         FVgHhmbvahKB6vzUskH5ec6ti8w5T6Hz8iyI25P/lJAjmQxtj3mQ6MDlInMS7l1dgJsm
         Z+ENssg2sXlcqY8h8yOWosYhbPNjPCJb0MPTIuqFmcysXWUHrpvkzxVYed0TgeNDyi3k
         0GNSEvjjJQ5HrzXMdaOZS9tE4Ig7KFzU+1UPO/Gx5fqlyNeHKxhbe5j4x8ZdqWj/xTa9
         HOJcswFEbsvMHnf4wHy3AJPCjAROAkSZ+GFtjxG7cqZDEp89z6LUgh6JoQ4fjD3eQK5E
         JEzQ==
X-Gm-Message-State: AOJu0YzsgJpAEcVxxK2ZtdbEa1Vep0TLx7kwcmtpOyLQhhmDUqJwK9Xd
        LC19vn9YKy8J9Tu6PeFbzkgGJQ==
X-Google-Smtp-Source: AGHT+IFd7GJ3+H2UcUs4H7I/0Hva8TODmG6bqztXIiSNatW/aV+dWb7HLsgtE3MTk6zKb2TzaCaMew==
X-Received: by 2002:a1c:7419:0:b0:403:b6bc:d90d with SMTP id p25-20020a1c7419000000b00403b6bcd90dmr8401755wmc.20.1695063660297;
        Mon, 18 Sep 2023 12:01:00 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id n9-20020a05600c3b8900b004047ac770d1sm10762707wms.8.2023.09.18.12.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 12:00:59 -0700 (PDT)
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
Subject: [PATCH v12 net-next 13/23] net/tcp: Add TCP-AO segments counters
Date:   Mon, 18 Sep 2023 20:00:11 +0100
Message-ID: <20230918190027.613430-14-dima@arista.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230918190027.613430-1-dima@arista.com>
References: <20230918190027.613430-1-dima@arista.com>
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

Introduce segment counters that are useful for troubleshooting/debugging
as well as for writing tests.
Now there are global snmp counters as well as per-socket and per-key.

Co-developed-by: Francesco Ruggeri <fruggeri@arista.com>
Signed-off-by: Francesco Ruggeri <fruggeri@arista.com>
Co-developed-by: Salam Noureddine <noureddine@arista.com>
Signed-off-by: Salam Noureddine <noureddine@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
Acked-by: David Ahern <dsahern@kernel.org>
---
 include/net/dropreason-core.h | 15 +++++++++++----
 include/net/tcp.h             | 15 +++++++++++----
 include/net/tcp_ao.h          | 10 ++++++++++
 include/uapi/linux/snmp.h     |  4 ++++
 include/uapi/linux/tcp.h      |  8 +++++++-
 net/ipv4/proc.c               |  4 ++++
 net/ipv4/tcp_ao.c             | 30 +++++++++++++++++++++++++++---
 net/ipv4/tcp_ipv4.c           |  2 +-
 net/ipv6/tcp_ipv6.c           |  4 ++--
 9 files changed, 77 insertions(+), 15 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index a01e1860fe25..efb6ea5ffb1e 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -167,17 +167,24 @@ enum skb_drop_reason {
 	 */
 	SKB_DROP_REASON_TCP_MD5FAILURE,
 	/**
-	 * @SKB_DROP_REASON_TCP_AONOTFOUND: no TCP-AO hash and one was expected
+	 * @SKB_DROP_REASON_TCP_AONOTFOUND: no TCP-AO hash and one was expected,
+	 * corresponding to LINUX_MIB_TCPAOREQUIRED
 	 */
 	SKB_DROP_REASON_TCP_AONOTFOUND,
 	/**
 	 * @SKB_DROP_REASON_TCP_AOUNEXPECTED: TCP-AO hash is present and it
-	 * was not expected.
+	 * was not expected, corresponding to LINUX_MIB_TCPAOKEYNOTFOUND
 	 */
 	SKB_DROP_REASON_TCP_AOUNEXPECTED,
-	/** @SKB_DROP_REASON_TCP_AOKEYNOTFOUND: TCP-AO key is unknown */
+	/**
+	 * @SKB_DROP_REASON_TCP_AOKEYNOTFOUND: TCP-AO key is unknown,
+	 * corresponding to LINUX_MIB_TCPAOKEYNOTFOUND
+	 */
 	SKB_DROP_REASON_TCP_AOKEYNOTFOUND,
-	/** @SKB_DROP_REASON_TCP_AOFAILURE: TCP-AO hash is wrong */
+	/**
+	 * @SKB_DROP_REASON_TCP_AOFAILURE: TCP-AO hash is wrong,
+	 * corresponding to LINUX_MIB_TCPAOBAD
+	 */
 	SKB_DROP_REASON_TCP_AOFAILURE,
 	/**
 	 * @SKB_DROP_REASON_SOCKET_BACKLOG: failed to add skb to socket backlog (
diff --git a/include/net/tcp.h b/include/net/tcp.h
index d73d55cae974..93b850091cba 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2670,7 +2670,7 @@ static inline int tcp_parse_auth_options(const struct tcphdr *th,
 }
 
 static inline bool tcp_ao_required(struct sock *sk, const void *saddr,
-				   int family)
+				   int family, bool stat_inc)
 {
 #ifdef CONFIG_TCP_AO
 	struct tcp_ao_info *ao_info;
@@ -2682,8 +2682,13 @@ static inline bool tcp_ao_required(struct sock *sk, const void *saddr,
 		return false;
 
 	ao_key = tcp_ao_do_lookup(sk, saddr, family, -1, -1);
-	if (ao_info->ao_required || ao_key)
+	if (ao_info->ao_required || ao_key) {
+		if (stat_inc) {
+			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPAOREQUIRED);
+			atomic64_inc(&ao_info->counters.ao_required);
+		}
 		return true;
+	}
 #endif
 	return false;
 }
@@ -2705,8 +2710,10 @@ tcp_inbound_hash(struct sock *sk, const struct request_sock *req,
 		return SKB_DROP_REASON_TCP_AUTH_HDR;
 
 	if (req) {
-		if (tcp_rsk_used_ao(req) != !!aoh)
+		if (tcp_rsk_used_ao(req) != !!aoh) {
+			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPAOBAD);
 			return SKB_DROP_REASON_TCP_AOFAILURE;
+		}
 	}
 
 	/* sdif set, means packet ingressed via a device
@@ -2721,7 +2728,7 @@ tcp_inbound_hash(struct sock *sk, const struct request_sock *req,
 		 * the last key is impossible to remove, so there's
 		 * always at least one current_key.
 		 */
-		if (tcp_ao_required(sk, saddr, family))
+		if (tcp_ao_required(sk, saddr, family, true))
 			return SKB_DROP_REASON_TCP_AONOTFOUND;
 		if (unlikely(tcp_md5_do_lookup(sk, l3index, saddr, family))) {
 			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5NOTFOUND);
diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
index 135635203bd7..ec9a247f58cb 100644
--- a/include/net/tcp_ao.h
+++ b/include/net/tcp_ao.h
@@ -19,6 +19,13 @@ struct tcp_ao_hdr {
 	u8	rnext_keyid;
 };
 
+struct tcp_ao_counters {
+	atomic64_t	pkt_good;
+	atomic64_t	pkt_bad;
+	atomic64_t	key_not_found;
+	atomic64_t	ao_required;
+};
+
 struct tcp_ao_key {
 	struct hlist_node	node;
 	union tcp_ao_addr	addr;
@@ -33,6 +40,8 @@ struct tcp_ao_key {
 	u8			rcvid;
 	u8			maclen;
 	struct rcu_head		rcu;
+	atomic64_t		pkt_good;
+	atomic64_t		pkt_bad;
 	u8			traffic_keys[];
 };
 
@@ -81,6 +90,7 @@ struct tcp_ao_info {
 	 */
 	struct tcp_ao_key	*current_key;
 	struct tcp_ao_key	*rnext_key;
+	struct tcp_ao_counters	counters;
 	u32			ao_required	:1,
 				__unused	:31;
 	__be32			lisn;
diff --git a/include/uapi/linux/snmp.h b/include/uapi/linux/snmp.h
index 26f33a4c253d..06ddf4cd295c 100644
--- a/include/uapi/linux/snmp.h
+++ b/include/uapi/linux/snmp.h
@@ -296,6 +296,10 @@ enum
 	LINUX_MIB_TCPMIGRATEREQSUCCESS,		/* TCPMigrateReqSuccess */
 	LINUX_MIB_TCPMIGRATEREQFAILURE,		/* TCPMigrateReqFailure */
 	LINUX_MIB_TCPPLBREHASH,			/* TCPPLBRehash */
+	LINUX_MIB_TCPAOREQUIRED,		/* TCPAORequired */
+	LINUX_MIB_TCPAOBAD,			/* TCPAOBad */
+	LINUX_MIB_TCPAOKEYNOTFOUND,		/* TCPAOKeyNotFound */
+	LINUX_MIB_TCPAOGOOD,			/* TCPAOGood */
 	__LINUX_MIB_MAX
 };
 
diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
index 8285300f95c9..62543f7c5523 100644
--- a/include/uapi/linux/tcp.h
+++ b/include/uapi/linux/tcp.h
@@ -403,9 +403,15 @@ struct tcp_ao_info_opt { /* setsockopt(TCP_AO_INFO) */
 	__u32   set_current	:1,	/* corresponding ::current_key */
 		set_rnext	:1,	/* corresponding ::rnext */
 		ao_required	:1,	/* don't accept non-AO connects */
-		reserved	:29;	/* must be 0 */
+		set_counters	:1,	/* set/clear ::pkt_* counters */
+		reserved	:28;	/* must be 0 */
+	__u16	reserved2;		/* padding, must be 0 */
 	__u8	current_key;		/* KeyID to set as Current_key */
 	__u8	rnext;			/* KeyID to set as Rnext_key */
+	__u64	pkt_good;		/* verified segments */
+	__u64	pkt_bad;		/* failed verification */
+	__u64	pkt_key_not_found;	/* could not find a key to verify */
+	__u64	pkt_ao_required;	/* segments missing TCP-AO sign */
 } __attribute__((aligned(8)));
 
 /* setsockopt(fd, IPPROTO_TCP, TCP_ZEROCOPY_RECEIVE, ...) */
diff --git a/net/ipv4/proc.c b/net/ipv4/proc.c
index eaf1d3113b62..3f643cd29cfe 100644
--- a/net/ipv4/proc.c
+++ b/net/ipv4/proc.c
@@ -298,6 +298,10 @@ static const struct snmp_mib snmp4_net_list[] = {
 	SNMP_MIB_ITEM("TCPMigrateReqSuccess", LINUX_MIB_TCPMIGRATEREQSUCCESS),
 	SNMP_MIB_ITEM("TCPMigrateReqFailure", LINUX_MIB_TCPMIGRATEREQFAILURE),
 	SNMP_MIB_ITEM("TCPPLBRehash", LINUX_MIB_TCPPLBREHASH),
+	SNMP_MIB_ITEM("TCPAORequired", LINUX_MIB_TCPAOREQUIRED),
+	SNMP_MIB_ITEM("TCPAOBad", LINUX_MIB_TCPAOBAD),
+	SNMP_MIB_ITEM("TCPAOKeyNotFound", LINUX_MIB_TCPAOKEYNOTFOUND),
+	SNMP_MIB_ITEM("TCPAOGood", LINUX_MIB_TCPAOGOOD),
 	SNMP_MIB_SENTINEL
 };
 
diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index 4bcbf2d3fe79..ec636a8ecf33 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -182,6 +182,8 @@ static struct tcp_ao_key *tcp_ao_copy_key(struct sock *sk,
 	*new_key = *key;
 	INIT_HLIST_NODE(&new_key->node);
 	tcp_sigpool_get(new_key->tcp_sigpool_id);
+	atomic64_set(&new_key->pkt_good, 0);
+	atomic64_set(&new_key->pkt_bad, 0);
 
 	return new_key;
 }
@@ -738,8 +740,12 @@ tcp_ao_verify_hash(const struct sock *sk, const struct sk_buff *skb,
 	const struct tcphdr *th = tcp_hdr(skb);
 	void *hash_buf = NULL;
 
-	if (maclen != tcp_ao_maclen(key))
+	if (maclen != tcp_ao_maclen(key)) {
+		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPAOBAD);
+		atomic64_inc(&info->counters.pkt_bad);
+		atomic64_inc(&key->pkt_bad);
 		return SKB_DROP_REASON_TCP_AOFAILURE;
+	}
 
 	hash_buf = kmalloc(tcp_ao_digest_size(key), GFP_ATOMIC);
 	if (!hash_buf)
@@ -749,9 +755,15 @@ tcp_ao_verify_hash(const struct sock *sk, const struct sk_buff *skb,
 	tcp_ao_hash_skb(family, hash_buf, key, sk, skb, traffic_key,
 			(phash - (u8 *)th), sne);
 	if (memcmp(phash, hash_buf, maclen)) {
+		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPAOBAD);
+		atomic64_inc(&info->counters.pkt_bad);
+		atomic64_inc(&key->pkt_bad);
 		kfree(hash_buf);
 		return SKB_DROP_REASON_TCP_AOFAILURE;
 	}
+	NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPAOGOOD);
+	atomic64_inc(&info->counters.pkt_good);
+	atomic64_inc(&key->pkt_good);
 	kfree(hash_buf);
 	return SKB_NOT_DROPPED_YET;
 }
@@ -771,8 +783,10 @@ tcp_inbound_ao_hash(struct sock *sk, const struct sk_buff *skb,
 	u32 sne = 0;
 
 	info = rcu_dereference(tcp_sk(sk)->ao_info);
-	if (!info)
+	if (!info) {
+		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPAOKEYNOTFOUND);
 		return SKB_DROP_REASON_TCP_AOUNEXPECTED;
+	}
 
 	if (unlikely(th->syn)) {
 		sisn = th->seq;
@@ -868,6 +882,8 @@ tcp_inbound_ao_hash(struct sock *sk, const struct sk_buff *skb,
 	return ret;
 
 key_not_found:
+	NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPAOKEYNOTFOUND);
+	atomic64_inc(&info->counters.key_not_found);
 	return SKB_DROP_REASON_TCP_AOKEYNOTFOUND;
 }
 
@@ -1435,6 +1451,8 @@ static int tcp_ao_add_cmd(struct sock *sk, unsigned short int family,
 	key->keyflags	= cmd.keyflags;
 	key->sndid	= cmd.sndid;
 	key->rcvid	= cmd.rcvid;
+	atomic64_set(&key->pkt_good, 0);
+	atomic64_set(&key->pkt_bad, 0);
 
 	ret = tcp_ao_parse_crypto(&cmd, key);
 	if (ret < 0)
@@ -1651,7 +1669,7 @@ static int tcp_ao_info_cmd(struct sock *sk, unsigned short int family,
 			return -EINVAL;
 	}
 
-	if (cmd.reserved != 0)
+	if (cmd.reserved != 0 || cmd.reserved2 != 0)
 		return -EINVAL;
 
 	ao_info = setsockopt_ao_info(sk);
@@ -1686,6 +1704,12 @@ static int tcp_ao_info_cmd(struct sock *sk, unsigned short int family,
 			goto out;
 		}
 	}
+	if (cmd.set_counters) {
+		atomic64_set(&ao_info->counters.pkt_good, cmd.pkt_good);
+		atomic64_set(&ao_info->counters.pkt_bad, cmd.pkt_bad);
+		atomic64_set(&ao_info->counters.key_not_found, cmd.pkt_key_not_found);
+		atomic64_set(&ao_info->counters.ao_required, cmd.pkt_ao_required);
+	}
 
 	ao_info->ao_required = cmd.ao_required;
 	if (new_current)
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index c1cada96b2da..c00c5573937f 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1529,7 +1529,7 @@ static int tcp_v4_parse_md5_keys(struct sock *sk, int optname,
 	/* Don't allow keys for peers that have a matching TCP-AO key.
 	 * See the comment in tcp_ao_add_cmd()
 	 */
-	if (tcp_ao_required(sk, addr, AF_INET))
+	if (tcp_ao_required(sk, addr, AF_INET, false))
 		return -EKEYREJECTED;
 
 	return tcp_md5_do_add(sk, addr, AF_INET, prefixlen, l3index, flags,
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 237f5cf0caf8..ba5130e0cb92 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -660,7 +660,7 @@ static int tcp_v6_parse_md5_keys(struct sock *sk, int optname,
 		/* Don't allow keys for peers that have a matching TCP-AO key.
 		 * See the comment in tcp_ao_add_cmd()
 		 */
-		if (tcp_ao_required(sk, addr, AF_INET))
+		if (tcp_ao_required(sk, addr, AF_INET, false))
 			return -EKEYREJECTED;
 		return tcp_md5_do_add(sk, addr,
 				      AF_INET, prefixlen, l3index, flags,
@@ -672,7 +672,7 @@ static int tcp_v6_parse_md5_keys(struct sock *sk, int optname,
 	/* Don't allow keys for peers that have a matching TCP-AO key.
 	 * See the comment in tcp_ao_add_cmd()
 	 */
-	if (tcp_ao_required(sk, addr, AF_INET6))
+	if (tcp_ao_required(sk, addr, AF_INET6, false))
 		return -EKEYREJECTED;
 
 	return tcp_md5_do_add(sk, addr, AF_INET6, prefixlen, l3index, flags,
-- 
2.41.0

