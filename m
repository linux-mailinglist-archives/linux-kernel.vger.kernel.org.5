Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66AF75CEBA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 18:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbjGUQXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 12:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232888AbjGUQWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 12:22:53 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C466144B0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 09:20:07 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fbc54cab6fso17939455e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 09:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1689956403; x=1690561203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u2iLFkSQ6CjrDnYeYY043iBnw60X+7/VaETIj3JEyss=;
        b=El0iJNi5DVrpcV6mGntoHVWuGWPHIDiviZnRORiiwv6Lka15KnJIqCYa+4jEExsUCK
         zIwZrYrfbsXJAiqVSGSQOW1QjuzzAbb6Wy7bg9HOWs06x9gxauKf83fo3N1FR6ERfgqj
         9cNOnWgSE6XVoF4pPG/3szx9AsKJg2qS/ei/5fSquty77i2DyhehzXLS/bNElRxlO2n/
         +BmTFFvn/yWn+6chmTbbCsI5ARRhyimU4epZNBZgBwMijHFo3E9j6U/irMTZi1RwB3/n
         B9pelSF+jhlwcEnZMDbxJMoj8FZR5aDdXiUsQJv4+/5y+mYd5c6PbW2E+dMUpBuQ+8Ja
         yHGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689956403; x=1690561203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u2iLFkSQ6CjrDnYeYY043iBnw60X+7/VaETIj3JEyss=;
        b=a6EBlT50lK46jDp2/Uwf4h9Txxa97qAzl0vKH2p3WXjOtIBIRWlHSo7fM4KghDB+sk
         x1ReiJFyCqdyzJRJC/nJXqU2j71VII23GOkfLJAV47fpbLtvqS4e3vG+FjQTspslYetm
         yLELJKT/PTW/9ySsl76kA858joSGNAv8Om8jObVNB9b3ka6ToJEqYb/0qE6x8X2eJyFP
         YDAYLBMvLvQ+v2aAGbAnp2rrJMwWhXGt6PJNND+rIAVfwwOMAwZR3RprZ6VurNZzntPs
         Bk/OgHv/4Vpp7KOpIhjs0WZl57F+2tKCnMgUOrIWJTpJYoBBjwFRjRJY7fc78Fhxva6M
         R2zA==
X-Gm-Message-State: ABy/qLYyKy9fcr9/N/+dA3pcMgqDWLkL4K3SlsPSKyeH8Yolbeu/hCXw
        DYcKRkfKaCcHGmPZJGScQUjZ3w==
X-Google-Smtp-Source: APBJJlGTxdbtPop5GJmBYywl7xWK/6Hyod2P53eG+8n2Q1YLP0gk6NGoCZK/Cmzv05hO9VtB7X7iZg==
X-Received: by 2002:a05:600c:2258:b0:3fb:fef9:cdcd with SMTP id a24-20020a05600c225800b003fbfef9cdcdmr1841459wmm.22.1689956402909;
        Fri, 21 Jul 2023 09:20:02 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id l19-20020a7bc453000000b003fbc681c8d1sm6390210wmi.36.2023.07.21.09.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 09:20:02 -0700 (PDT)
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
Subject: [PATCH v8.1 net-next 22/23] net/tcp: Add TCP_AO_REPAIR
Date:   Fri, 21 Jul 2023 17:19:13 +0100
Message-ID: <20230721161916.542667-23-dima@arista.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721161916.542667-1-dima@arista.com>
References: <20230721161916.542667-1-dima@arista.com>
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

Add TCP_AO_REPAIR setsockopt(), getsockopt(). They let a user to repair
TCP-AO ISNs/SNEs. Also let the user hack around when (tp->repair) is on
and add ao_info on a socket in any supported state.
As SNEs now can be read/written at any moment, use
WRITE_ONCE()/READ_ONCE() to set/read them.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 include/net/tcp_ao.h     | 14 ++++++
 include/uapi/linux/tcp.h |  8 ++++
 net/ipv4/tcp.c           | 24 ++++++++---
 net/ipv4/tcp_ao.c        | 92 ++++++++++++++++++++++++++++++++++++++--
 4 files changed, 127 insertions(+), 11 deletions(-)

diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
index b56b49a98266..0027f4b4683d 100644
--- a/include/net/tcp_ao.h
+++ b/include/net/tcp_ao.h
@@ -196,6 +196,8 @@ void tcp_ao_time_wait(struct tcp_timewait_sock *tcptw, struct tcp_sock *tp);
 bool tcp_ao_ignore_icmp(struct sock *sk, int type, int code);
 int tcp_ao_get_mkts(struct sock *sk, sockptr_t optval, sockptr_t optlen);
 int tcp_ao_get_sock_info(struct sock *sk, sockptr_t optval, sockptr_t optlen);
+int tcp_ao_get_repair(struct sock *sk, sockptr_t optval, sockptr_t optlen);
+int tcp_ao_set_repair(struct sock *sk, sockptr_t optval, unsigned int optlen);
 enum skb_drop_reason tcp_inbound_ao_hash(struct sock *sk,
 			const struct sk_buff *skb, unsigned short int family,
 			const struct request_sock *req, int l3index,
@@ -317,6 +319,18 @@ static inline int tcp_ao_get_sock_info(struct sock *sk, sockptr_t optval, sockpt
 {
 	return -ENOPROTOOPT;
 }
+
+static inline int tcp_ao_get_repair(struct sock *sk,
+				    sockptr_t optval, sockptr_t optlen)
+{
+	return -ENOPROTOOPT;
+}
+
+static inline int tcp_ao_set_repair(struct sock *sk,
+				    sockptr_t optval, unsigned int optlen)
+{
+	return -ENOPROTOOPT;
+}
 #endif
 
 #if defined(CONFIG_TCP_MD5SIG) || defined(CONFIG_TCP_AO)
diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
index 979ff960fddb..624198fa170d 100644
--- a/include/uapi/linux/tcp.h
+++ b/include/uapi/linux/tcp.h
@@ -133,6 +133,7 @@ enum {
 #define TCP_AO_DEL_KEY		39	/* Delete MKT */
 #define TCP_AO_INFO		40	/* Set/list TCP-AO per-socket options */
 #define TCP_AO_GET_KEYS		41	/* List MKT(s) */
+#define TCP_AO_REPAIR		42	/* Get/Set SNEs and ISNs */
 
 #define TCP_REPAIR_ON		1
 #define TCP_REPAIR_OFF		0
@@ -445,6 +446,13 @@ struct tcp_ao_getsockopt { /* getsockopt(TCP_AO_GET_KEYS) */
 	__u64	pkt_bad;		/* out: segments that failed verification */
 } __attribute__((aligned(8)));
 
+struct tcp_ao_repair { /* {s,g}etsockopt(TCP_AO_REPAIR) */
+	__be32			snt_isn;
+	__be32			rcv_isn;
+	__u32			snd_sne;
+	__u32			rcv_sne;
+} __attribute__((aligned(8)));
+
 /* setsockopt(fd, IPPROTO_TCP, TCP_ZEROCOPY_RECEIVE, ...) */
 
 #define TCP_RECEIVE_ZEROCOPY_FLAG_TLB_CLEAN_HINT 0x1
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 82506300da6c..95c9d3c9134e 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3608,20 +3608,28 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 		__tcp_sock_set_quickack(sk, val);
 		break;
 
+	case TCP_AO_REPAIR:
+		err = tcp_ao_set_repair(sk, optval, optlen);
+		break;
 #ifdef CONFIG_TCP_AO
 	case TCP_AO_ADD_KEY:
 	case TCP_AO_DEL_KEY:
 	case TCP_AO_INFO: {
 		/* If this is the first TCP-AO setsockopt() on the socket,
-		 * sk_state has to be LISTEN or CLOSE
+		 * sk_state has to be LISTEN or CLOSE. Allow TCP_REPAIR
+		 * in any state.
 		 */
-		if (((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_CLOSE)) ||
-		    rcu_dereference_protected(tcp_sk(sk)->ao_info,
+		if ((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_CLOSE))
+			goto ao_parse;
+		if (rcu_dereference_protected(tcp_sk(sk)->ao_info,
 					      lockdep_sock_is_held(sk)))
-			err = tp->af_specific->ao_parse(sk, optname, optval,
-							optlen);
-		else
-			err = -EISCONN;
+			goto ao_parse;
+		if (tp->repair)
+			goto ao_parse;
+		err = -EISCONN;
+		break;
+ao_parse:
+		err = tp->af_specific->ao_parse(sk, optname, optval, optlen);
 		break;
 	}
 #endif
@@ -4289,6 +4297,8 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 		return err;
 	}
 #endif
+	case TCP_AO_REPAIR:
+		return tcp_ao_get_repair(sk, optval, optlen);
 	case TCP_AO_GET_KEYS:
 	case TCP_AO_INFO: {
 		int err;
diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index 3490b590bff0..70ff7822f57a 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -1463,6 +1463,16 @@ static struct tcp_ao_info *setsockopt_ao_info(struct sock *sk)
 	return ERR_PTR(-ESOCKTNOSUPPORT);
 }
 
+static struct tcp_ao_info *getsockopt_ao_info(struct sock *sk)
+{
+	if (sk_fullsock(sk))
+		return rcu_dereference(tcp_sk(sk)->ao_info);
+	else if (sk->sk_state == TCP_TIME_WAIT)
+		return rcu_dereference(tcp_twsk(sk)->ao_info);
+
+	return ERR_PTR(-ESOCKTNOSUPPORT);
+}
+
 #define TCP_AO_KEYF_ALL (TCP_AO_KEYF_IFINDEX | TCP_AO_KEYF_EXCLUDE_OPT)
 #define TCP_AO_GET_KEYF_VALID	(TCP_AO_KEYF_IFINDEX)
 
@@ -1647,11 +1657,13 @@ static int tcp_ao_add_cmd(struct sock *sk, unsigned short int family,
 	if (ret < 0)
 		goto err_free_sock;
 
-	/* Change this condition if we allow adding keys in states
-	 * like close_wait, syn_sent or fin_wait...
-	 */
-	if (sk->sk_state == TCP_ESTABLISHED)
+	if (!((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_CLOSE))) {
 		tcp_ao_cache_traffic_keys(sk, ao_info, key);
+		if (first) {
+			ao_info->current_key = key;
+			ao_info->rnext_key = key;
+		}
+	}
 
 	tcp_ao_link_mkt(ao_info, key);
 	if (first) {
@@ -1899,6 +1911,8 @@ static int tcp_ao_info_cmd(struct sock *sk, unsigned short int family,
 	if (IS_ERR(ao_info))
 		return PTR_ERR(ao_info);
 	if (!ao_info) {
+		if (!((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_CLOSE)))
+			return -EINVAL;
 		ao_info = tcp_ao_alloc_info(GFP_KERNEL);
 		if (!ao_info)
 			return -ENOMEM;
@@ -2281,3 +2295,73 @@ int tcp_ao_get_sock_info(struct sock *sk, sockptr_t optval, sockptr_t optlen)
 	return 0;
 }
 
+int tcp_ao_set_repair(struct sock *sk, sockptr_t optval, unsigned int optlen)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+	struct tcp_ao_repair cmd;
+	struct tcp_ao_key *key;
+	struct tcp_ao_info *ao;
+	int err;
+
+	if (optlen < sizeof(cmd))
+		return -EINVAL;
+
+	err = copy_struct_from_sockptr(&cmd, sizeof(cmd), optval, optlen);
+	if (err)
+		return err;
+
+	if (!tp->repair)
+		return -EPERM;
+
+	ao = setsockopt_ao_info(sk);
+	if (IS_ERR(ao))
+		return PTR_ERR(ao);
+	if (!ao)
+		return -ENOENT;
+
+	WRITE_ONCE(ao->lisn, cmd.snt_isn);
+	WRITE_ONCE(ao->risn, cmd.rcv_isn);
+	WRITE_ONCE(ao->snd_sne, cmd.snd_sne);
+	WRITE_ONCE(ao->rcv_sne, cmd.rcv_sne);
+
+	hlist_for_each_entry_rcu(key, &ao->head, node)
+		tcp_ao_cache_traffic_keys(sk, ao, key);
+
+	return 0;
+}
+
+int tcp_ao_get_repair(struct sock *sk, sockptr_t optval, sockptr_t optlen)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+	struct tcp_ao_repair opt;
+	struct tcp_ao_info *ao;
+	int len;
+
+	if (copy_from_sockptr(&len, optlen, sizeof(int)))
+		return -EFAULT;
+
+	if (len <= 0)
+		return -EINVAL;
+
+	if (!tp->repair)
+		return -EPERM;
+
+	rcu_read_lock();
+	ao = getsockopt_ao_info(sk);
+	if (IS_ERR(ao))
+		return PTR_ERR(ao);
+	if (!ao) {
+		rcu_read_unlock();
+		return -ENOENT;
+	}
+
+	opt.snt_isn	= ao->lisn;
+	opt.rcv_isn	= ao->risn;
+	opt.snd_sne	= READ_ONCE(ao->snd_sne);
+	opt.rcv_sne	= READ_ONCE(ao->rcv_sne);
+	rcu_read_unlock();
+
+	if (copy_to_sockptr(optval, &opt, min_t(int, len, sizeof(opt))))
+		return -EFAULT;
+	return 0;
+}
-- 
2.41.0

