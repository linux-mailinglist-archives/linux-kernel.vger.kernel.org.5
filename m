Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55664759FB8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 22:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjGSU2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 16:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbjGSU1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 16:27:40 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DAF1FDF
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 13:27:03 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fd18b1d924so294475e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 13:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1689798421; x=1692390421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DX5FjPWmZGf+2MXiyV1rmCdmCyjiwzaLtY3n3xKT29A=;
        b=MlqX1OQG4tjiqlC43oNoAm4I5FAwFo9kDug0cHUsSjPIc+Fn6zGT1f/HiYtkQWJh63
         ZJFWCCWqEN82/MeU+diyNqSs7ork+L6KFTfqvZR/YpfC8DeoFa6rhb5fLOUO7xKMHxtp
         TXBZqwUXaDIx4r7E6kQ5HXySwJpTBvVeAAd2hAH4yg8o1xZAnI/3yv6piAMwvEacEtit
         PhTPTjCKjBXBb+d4yDzkq+8NLS7nNd3zbQI2uLP6dsIbB5PQv2qQeaanXu2W8EJ84Gg4
         OiY2+K5YcoKDF9HrUcxwZ1bQCF0FJAcgC1eLmof5/sE6ecN0+SQKio+GfIVxlzUNaPeF
         i9kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689798421; x=1692390421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DX5FjPWmZGf+2MXiyV1rmCdmCyjiwzaLtY3n3xKT29A=;
        b=KNGhRB0DDylxVQJX0LvFnU/HLN+gKWJXC2dqWteo3nn26gJnU2YH+K/VL7YPa1o7ka
         mFCHlSuijDBQ0SUPvn8xABkktzLwuNEvhMVGryJttzXVenpJmIpmCJHwmlYxWgTmT6aP
         CJarbnZSc4BoH5FnTPg2pMyPAEx4AKjhxvS8GjZuLOrpoliU2AzccphcKVfdFP+Tpxlm
         b4XWoRAFdAo5lw2tG3GAe+N3szy0/zSrIRMNRPJuoBaVXFJoxrcVHzw5Zb5yc1O74pGG
         KBeuSRgmrClNLTeTaPpfKzHOoM+GFz/sJNbBWbftfh4GgoOlq62jr3jERdHOJeDnwHOX
         lM2Q==
X-Gm-Message-State: ABy/qLaVzjEDxqRTVHCbq/cxJh/MxX1B5EUJ6jjLaztXHu9Z7JhTomvQ
        ekn2VqWJ1yaOrlPu8iCtA/mqIg==
X-Google-Smtp-Source: APBJJlHaX0jt7hrguS4XdpBRjhUCyZ8ChgH1AN1RM0UHkdIN5ofnHpU2+46baRUSS930KGIxDNk6OQ==
X-Received: by 2002:a05:600c:2195:b0:3fb:e573:4171 with SMTP id e21-20020a05600c219500b003fbe5734171mr281472wme.40.1689798421141;
        Wed, 19 Jul 2023 13:27:01 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id 3-20020a05600c234300b003fc04d13242sm2432319wmq.0.2023.07.19.13.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 13:27:00 -0700 (PDT)
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
Subject: [PATCH v8 13/23] net/tcp: Add TCP-AO segments counters
Date:   Wed, 19 Jul 2023 21:26:18 +0100
Message-ID: <20230719202631.472019-14-dima@arista.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230719202631.472019-1-dima@arista.com>
References: <20230719202631.472019-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index 0ff272d3b680..44ac4ebd8513 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -165,17 +165,24 @@ enum skb_drop_reason {
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
index 67b46787c3dd..646aebc682f8 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2574,7 +2574,7 @@ static inline int tcp_parse_auth_options(const struct tcphdr *th,
 }
 
 static inline bool tcp_ao_required(struct sock *sk, const void *saddr,
-				   int family)
+				   int family, bool stat_inc)
 {
 #ifdef CONFIG_TCP_AO
 	struct tcp_ao_info *ao_info;
@@ -2586,8 +2586,13 @@ static inline bool tcp_ao_required(struct sock *sk, const void *saddr,
 		return false;
 
 	ao_key = tcp_ao_do_lookup(sk, saddr, family, -1, -1, 0);
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
@@ -2609,8 +2614,10 @@ tcp_inbound_hash(struct sock *sk, const struct request_sock *req,
 		return SKB_DROP_REASON_TCP_AUTH_HDR;
 
 	if (req) {
-		if (tcp_rsk_used_ao(req) != !!aoh)
+		if (tcp_rsk_used_ao(req) != !!aoh) {
+			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPAOBAD);
 			return SKB_DROP_REASON_TCP_AOFAILURE;
+		}
 	}
 
 	/* sdif set, means packet ingressed via a device
@@ -2625,7 +2632,7 @@ tcp_inbound_hash(struct sock *sk, const struct request_sock *req,
 		 * the last key is impossible to remove, so there's
 		 * always at least one current_key.
 		 */
-		if (tcp_ao_required(sk, saddr, family))
+		if (tcp_ao_required(sk, saddr, family, true))
 			return SKB_DROP_REASON_TCP_AONOTFOUND;
 		if (unlikely(tcp_md5_do_lookup(sk, l3index, saddr, family))) {
 			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5NOTFOUND);
diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
index 1b7ca7bf93a3..0a02098bddeb 100644
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
@@ -34,6 +41,8 @@ struct tcp_ao_key {
 	u8			rcvid;
 	u8			maclen;
 	struct rcu_head		rcu;
+	atomic64_t		pkt_good;
+	atomic64_t		pkt_bad;
 	u8			traffic_keys[];
 };
 
@@ -82,6 +91,7 @@ struct tcp_ao_info {
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
index 250e0ce2cc38..3fe0612ec59a 100644
--- a/include/uapi/linux/tcp.h
+++ b/include/uapi/linux/tcp.h
@@ -391,9 +391,15 @@ struct tcp_ao_info_opt { /* setsockopt(TCP_AO_INFO) */
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
index 073be1680818..5ab66928a952 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -184,6 +184,8 @@ static struct tcp_ao_key *tcp_ao_copy_key(struct sock *sk,
 	*new_key = *key;
 	INIT_HLIST_NODE(&new_key->node);
 	tcp_sigpool_get(new_key->tcp_sigpool_id);
+	atomic64_set(&new_key->pkt_good, 0);
+	atomic64_set(&new_key->pkt_bad, 0);
 
 	return new_key;
 }
@@ -745,8 +747,12 @@ tcp_ao_verify_hash(const struct sock *sk, const struct sk_buff *skb,
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
@@ -756,9 +762,15 @@ tcp_ao_verify_hash(const struct sock *sk, const struct sk_buff *skb,
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
@@ -778,8 +790,10 @@ tcp_inbound_ao_hash(struct sock *sk, const struct sk_buff *skb,
 	u32 sne = 0;
 
 	info = rcu_dereference(tcp_sk(sk)->ao_info);
-	if (!info)
+	if (!info) {
+		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPAOKEYNOTFOUND);
 		return SKB_DROP_REASON_TCP_AOUNEXPECTED;
+	}
 
 	if (unlikely(th->syn)) {
 		sisn = th->seq;
@@ -875,6 +889,8 @@ tcp_inbound_ao_hash(struct sock *sk, const struct sk_buff *skb,
 	return ret;
 
 key_not_found:
+	NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPAOKEYNOTFOUND);
+	atomic64_inc(&info->counters.key_not_found);
 	return SKB_DROP_REASON_TCP_AOKEYNOTFOUND;
 }
 
@@ -1460,6 +1476,8 @@ static int tcp_ao_add_cmd(struct sock *sk, unsigned short int family,
 	key->keyflags	= cmd.keyflags;
 	key->sndid	= cmd.sndid;
 	key->rcvid	= cmd.rcvid;
+	atomic64_set(&key->pkt_good, 0);
+	atomic64_set(&key->pkt_bad, 0);
 
 	ret = tcp_ao_parse_crypto(&cmd, key);
 	if (ret < 0)
@@ -1673,7 +1691,7 @@ static int tcp_ao_info_cmd(struct sock *sk, unsigned short int family,
 			return -EINVAL;
 	}
 
-	if (cmd.reserved != 0)
+	if (cmd.reserved != 0 || cmd.reserved2 != 0)
 		return -EINVAL;
 
 	ao_info = setsockopt_ao_info(sk);
@@ -1708,6 +1726,12 @@ static int tcp_ao_info_cmd(struct sock *sk, unsigned short int family,
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
index a10a5011c60f..e0a76d69bed8 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1525,7 +1525,7 @@ static int tcp_v4_parse_md5_keys(struct sock *sk, int optname,
 	/* Don't allow keys for peers that have a matching TCP-AO key.
 	 * See the comment in tcp_ao_add_cmd()
 	 */
-	if (tcp_ao_required(sk, addr, AF_INET))
+	if (tcp_ao_required(sk, addr, AF_INET, false))
 		return -EKEYREJECTED;
 
 	return tcp_md5_do_add(sk, addr, AF_INET, prefixlen, l3index, flags,
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 026e2d49706a..47537fa0df02 100644
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

