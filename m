Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6971E7BEED4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 01:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379103AbjJIXJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 19:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379116AbjJIXIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 19:08:31 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D2FD78
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 16:08:00 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-323168869daso5001493f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 16:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1696892874; x=1697497674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K/z9C+eNFh70ZHorEzwi02LofZkKUM4z/UqzzQErSOs=;
        b=g0v1Nqif1XjFACWi8DGYLtuDSx7l8+H3gKnHiaz54T5zqXr+Q2zp+PJM+k60+BBntG
         87XrhK/UleMCoeulH8Hnwwa5r2Y5XTWV9zGRsd1hggiSZwQHtg4O6nII5io4qAmpqMQj
         GuHaeXNY6CLgJDg064a/K2JlhsBEA6bifD+DjeNYxxBCWJTxKrqlmeJ6+riUifnf6OP3
         COOUqX/nITGb+z9c+VpEaRwatquLdj6yse5wJIGd/3D5HLnI59vEZHBNCbiJsPj/yVCU
         PVpeyas2ipQem6gJMLaDpqP13oKHlEaetGCeV3EA9lEHSDxmCcuUGktqNb1JkW499BKt
         BCNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696892874; x=1697497674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K/z9C+eNFh70ZHorEzwi02LofZkKUM4z/UqzzQErSOs=;
        b=jMhwy8ryWjDannj27Ux5o22yaYQnGd8UEfi2wviF1pvaID/PvTCQ1zNO+8YnpkJuvV
         +22UUshNr02U2G/t4+rqqRO4vU7QKL2Y6ssZN1w+N09mAXyFcozbEyABM7gYdMJrGQ9M
         zBr7D2UNYjBhqotEcElKtzVOb2sIZ/lL9Vj/PmTxwaa8zhwtPtm+TqTi2x5MeEMqKJXc
         Je0pZWX4Pcd2oiXNF7zzsvv9siYRRuJinTsVaQdbRMAsydLWbU8haLupPCBzc75ey15a
         IyJw+wlgVOoxwistrGfcorfd5yu7SuPGQgrPyQigxY7u9nM8C6wVA4JxvincOKxjHs8G
         8O/Q==
X-Gm-Message-State: AOJu0Yw5/3oOxuHIXBnZWkh+lGbFNJeXDWRKRq3Fbuzt0+qdsXcwoMFo
        tQZYQaPZxU/rdCKvaX9IblYptA==
X-Google-Smtp-Source: AGHT+IF17lQivaLsV4X6c4UETB5HjYZ0vVeimweXGNf8wiSy85pJoPT7Z9DfOL9FE9QSc2fMuEBDuA==
X-Received: by 2002:a5d:4149:0:b0:31f:eb8d:481f with SMTP id c9-20020a5d4149000000b0031feb8d481fmr15561122wrq.29.1696892874016;
        Mon, 09 Oct 2023 16:07:54 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id t24-20020a7bc3d8000000b004042dbb8925sm14592104wmj.38.2023.10.09.16.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 16:07:53 -0700 (PDT)
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
Subject: [PATCH v14 net-next 16/23] net/tcp: Ignore specific ICMPs for TCP-AO connections
Date:   Tue, 10 Oct 2023 00:07:07 +0100
Message-ID: <20231009230722.76268-17-dima@arista.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009230722.76268-1-dima@arista.com>
References: <20231009230722.76268-1-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similarly to IPsec, RFC5925 prescribes:
  ">> A TCP-AO implementation MUST default to ignore incoming ICMPv4
  messages of Type 3 (destination unreachable), Codes 2-4 (protocol
  unreachable, port unreachable, and fragmentation needed -- ’hard
  errors’), and ICMPv6 Type 1 (destination unreachable), Code 1
  (administratively prohibited) and Code 4 (port unreachable) intended
  for connections in synchronized states (ESTABLISHED, FIN-WAIT-1, FIN-
  WAIT-2, CLOSE-WAIT, CLOSING, LAST-ACK, TIME-WAIT) that match MKTs."

A selftest (later in patch series) verifies that this attack is not
possible in this TCP-AO implementation.

Co-developed-by: Francesco Ruggeri <fruggeri@arista.com>
Signed-off-by: Francesco Ruggeri <fruggeri@arista.com>
Co-developed-by: Salam Noureddine <noureddine@arista.com>
Signed-off-by: Salam Noureddine <noureddine@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
Acked-by: David Ahern <dsahern@kernel.org>
---
 include/net/tcp_ao.h      | 10 ++++++-
 include/uapi/linux/snmp.h |  1 +
 include/uapi/linux/tcp.h  |  4 ++-
 net/ipv4/proc.c           |  1 +
 net/ipv4/tcp_ao.c         | 58 +++++++++++++++++++++++++++++++++++++++
 net/ipv4/tcp_ipv4.c       |  7 +++++
 net/ipv6/tcp_ipv6.c       |  7 +++++
 7 files changed, 86 insertions(+), 2 deletions(-)

diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
index 8c315c3f31da..eec38e9e6380 100644
--- a/include/net/tcp_ao.h
+++ b/include/net/tcp_ao.h
@@ -24,6 +24,7 @@ struct tcp_ao_counters {
 	atomic64_t	pkt_bad;
 	atomic64_t	key_not_found;
 	atomic64_t	ao_required;
+	atomic64_t	dropped_icmp;
 };
 
 struct tcp_ao_key {
@@ -92,7 +93,8 @@ struct tcp_ao_info {
 	struct tcp_ao_key	*rnext_key;
 	struct tcp_ao_counters	counters;
 	u32			ao_required	:1,
-				__unused	:31;
+				accept_icmps	:1,
+				__unused	:30;
 	__be32			lisn;
 	__be32			risn;
 	/* Sequence Number Extension (SNE) are upper 4 bytes for SEQ,
@@ -191,6 +193,7 @@ int tcp_ao_calc_traffic_key(struct tcp_ao_key *mkt, u8 *key, void *ctx,
 			    unsigned int len, struct tcp_sigpool *hp);
 void tcp_ao_destroy_sock(struct sock *sk, bool twsk);
 void tcp_ao_time_wait(struct tcp_timewait_sock *tcptw, struct tcp_sock *tp);
+bool tcp_ao_ignore_icmp(const struct sock *sk, int type, int code);
 enum skb_drop_reason tcp_inbound_ao_hash(struct sock *sk,
 			const struct sk_buff *skb, unsigned short int family,
 			const struct request_sock *req,
@@ -274,6 +277,11 @@ static inline void tcp_ao_syncookie(struct sock *sk, const struct sk_buff *skb,
 {
 }
 
+static inline bool tcp_ao_ignore_icmp(const struct sock *sk, int type, int code)
+{
+	return false;
+}
+
 static inline enum skb_drop_reason tcp_inbound_ao_hash(struct sock *sk,
 		const struct sk_buff *skb, unsigned short int family,
 		const struct request_sock *req, const struct tcp_ao_hdr *aoh)
diff --git a/include/uapi/linux/snmp.h b/include/uapi/linux/snmp.h
index 06ddf4cd295c..47a6b47da66f 100644
--- a/include/uapi/linux/snmp.h
+++ b/include/uapi/linux/snmp.h
@@ -300,6 +300,7 @@ enum
 	LINUX_MIB_TCPAOBAD,			/* TCPAOBad */
 	LINUX_MIB_TCPAOKEYNOTFOUND,		/* TCPAOKeyNotFound */
 	LINUX_MIB_TCPAOGOOD,			/* TCPAOGood */
+	LINUX_MIB_TCPAODROPPEDICMPS,		/* TCPAODroppedIcmps */
 	__LINUX_MIB_MAX
 };
 
diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
index 62543f7c5523..e4ddca6178ca 100644
--- a/include/uapi/linux/tcp.h
+++ b/include/uapi/linux/tcp.h
@@ -404,7 +404,8 @@ struct tcp_ao_info_opt { /* setsockopt(TCP_AO_INFO) */
 		set_rnext	:1,	/* corresponding ::rnext */
 		ao_required	:1,	/* don't accept non-AO connects */
 		set_counters	:1,	/* set/clear ::pkt_* counters */
-		reserved	:28;	/* must be 0 */
+		accept_icmps	:1,	/* accept incoming ICMPs */
+		reserved	:27;	/* must be 0 */
 	__u16	reserved2;		/* padding, must be 0 */
 	__u8	current_key;		/* KeyID to set as Current_key */
 	__u8	rnext;			/* KeyID to set as Rnext_key */
@@ -412,6 +413,7 @@ struct tcp_ao_info_opt { /* setsockopt(TCP_AO_INFO) */
 	__u64	pkt_bad;		/* failed verification */
 	__u64	pkt_key_not_found;	/* could not find a key to verify */
 	__u64	pkt_ao_required;	/* segments missing TCP-AO sign */
+	__u64	pkt_dropped_icmp;	/* ICMPs that were ignored */
 } __attribute__((aligned(8)));
 
 /* setsockopt(fd, IPPROTO_TCP, TCP_ZEROCOPY_RECEIVE, ...) */
diff --git a/net/ipv4/proc.c b/net/ipv4/proc.c
index 3f643cd29cfe..5d3c9c96773e 100644
--- a/net/ipv4/proc.c
+++ b/net/ipv4/proc.c
@@ -302,6 +302,7 @@ static const struct snmp_mib snmp4_net_list[] = {
 	SNMP_MIB_ITEM("TCPAOBad", LINUX_MIB_TCPAOBAD),
 	SNMP_MIB_ITEM("TCPAOKeyNotFound", LINUX_MIB_TCPAOKEYNOTFOUND),
 	SNMP_MIB_ITEM("TCPAOGood", LINUX_MIB_TCPAOGOOD),
+	SNMP_MIB_ITEM("TCPAODroppedIcmps", LINUX_MIB_TCPAODROPPEDICMPS),
 	SNMP_MIB_SENTINEL
 };
 
diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index 801174c17853..168073cd1c89 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -15,6 +15,7 @@
 
 #include <net/tcp.h>
 #include <net/ipv6.h>
+#include <net/icmp.h>
 
 int tcp_ao_calc_traffic_key(struct tcp_ao_key *mkt, u8 *key, void *ctx,
 			    unsigned int len, struct tcp_sigpool *hp)
@@ -44,6 +45,60 @@ int tcp_ao_calc_traffic_key(struct tcp_ao_key *mkt, u8 *key, void *ctx,
 	return 1;
 }
 
+bool tcp_ao_ignore_icmp(const struct sock *sk, int type, int code)
+{
+	bool ignore_icmp = false;
+	struct tcp_ao_info *ao;
+
+	/* RFC5925, 7.8:
+	 * >> A TCP-AO implementation MUST default to ignore incoming ICMPv4
+	 * messages of Type 3 (destination unreachable), Codes 2-4 (protocol
+	 * unreachable, port unreachable, and fragmentation needed -- ’hard
+	 * errors’), and ICMPv6 Type 1 (destination unreachable), Code 1
+	 * (administratively prohibited) and Code 4 (port unreachable) intended
+	 * for connections in synchronized states (ESTABLISHED, FIN-WAIT-1, FIN-
+	 * WAIT-2, CLOSE-WAIT, CLOSING, LAST-ACK, TIME-WAIT) that match MKTs.
+	 */
+	if (READ_ONCE(sk->sk_family) == AF_INET) {
+		if (type != ICMP_DEST_UNREACH)
+			return false;
+		if (code < ICMP_PROT_UNREACH || code > ICMP_FRAG_NEEDED)
+			return false;
+	} else {
+		if (type != ICMPV6_DEST_UNREACH)
+			return false;
+		if (code != ICMPV6_ADM_PROHIBITED && code != ICMPV6_PORT_UNREACH)
+			return false;
+	}
+
+	rcu_read_lock();
+	switch (sk->sk_state) {
+	case TCP_TIME_WAIT:
+		ao = rcu_dereference(tcp_twsk(sk)->ao_info);
+		break;
+	case TCP_SYN_SENT:
+	case TCP_SYN_RECV:
+	case TCP_LISTEN:
+	case TCP_NEW_SYN_RECV:
+		/* RFC5925 specifies to ignore ICMPs *only* on connections
+		 * in synchronized states.
+		 */
+		rcu_read_unlock();
+		return false;
+	default:
+		ao = rcu_dereference(tcp_sk(sk)->ao_info);
+	}
+
+	if (ao && !ao->accept_icmps) {
+		ignore_icmp = true;
+		__NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPAODROPPEDICMPS);
+		atomic64_inc(&ao->counters.dropped_icmp);
+	}
+	rcu_read_unlock();
+
+	return ignore_icmp;
+}
+
 /* Optimized version of tcp_ao_do_lookup(): only for sockets for which
  * it's known that the keys in ao_info are matching peer's
  * family/address/VRF/etc.
@@ -1083,6 +1138,7 @@ int tcp_ao_copy_all_matching(const struct sock *sk, struct sock *newsk,
 	new_ao->lisn = htonl(tcp_rsk(req)->snt_isn);
 	new_ao->risn = htonl(tcp_rsk(req)->rcv_isn);
 	new_ao->ao_required = ao->ao_required;
+	new_ao->accept_icmps = ao->accept_icmps;
 
 	if (family == AF_INET) {
 		addr = (union tcp_ao_addr *)&newsk->sk_daddr;
@@ -1789,9 +1845,11 @@ static int tcp_ao_info_cmd(struct sock *sk, unsigned short int family,
 		atomic64_set(&ao_info->counters.pkt_bad, cmd.pkt_bad);
 		atomic64_set(&ao_info->counters.key_not_found, cmd.pkt_key_not_found);
 		atomic64_set(&ao_info->counters.ao_required, cmd.pkt_ao_required);
+		atomic64_set(&ao_info->counters.dropped_icmp, cmd.pkt_dropped_icmp);
 	}
 
 	ao_info->ao_required = cmd.ao_required;
+	ao_info->accept_icmps = cmd.accept_icmps;
 	if (new_current)
 		WRITE_ONCE(ao_info->current_key, new_current);
 	if (new_rnext)
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 48fb81a8a712..772fc6347302 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -493,6 +493,8 @@ int tcp_v4_err(struct sk_buff *skb, u32 info)
 		return -ENOENT;
 	}
 	if (sk->sk_state == TCP_TIME_WAIT) {
+		/* To increase the counter of ignored icmps for TCP-AO */
+		tcp_ao_ignore_icmp(sk, type, code);
 		inet_twsk_put(inet_twsk(sk));
 		return 0;
 	}
@@ -506,6 +508,11 @@ int tcp_v4_err(struct sk_buff *skb, u32 info)
 		return 0;
 	}
 
+	if (tcp_ao_ignore_icmp(sk, type, code)) {
+		sock_put(sk);
+		return 0;
+	}
+
 	bh_lock_sock(sk);
 	/* If too many ICMPs get dropped on busy
 	 * servers this needs to be solved differently.
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 25911302d5e3..b604c870c493 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -395,6 +395,8 @@ static int tcp_v6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 	}
 
 	if (sk->sk_state == TCP_TIME_WAIT) {
+		/* To increase the counter of ignored icmps for TCP-AO */
+		tcp_ao_ignore_icmp(sk, type, code);
 		inet_twsk_put(inet_twsk(sk));
 		return 0;
 	}
@@ -405,6 +407,11 @@ static int tcp_v6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 		return 0;
 	}
 
+	if (tcp_ao_ignore_icmp(sk, type, code)) {
+		sock_put(sk);
+		return 0;
+	}
+
 	bh_lock_sock(sk);
 	if (sock_owned_by_user(sk) && type != ICMPV6_PKT_TOOBIG)
 		__NET_INC_STATS(net, LINUX_MIB_LOCKDROPPEDICMPS);
-- 
2.42.0

