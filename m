Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB1E7D403F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 21:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbjJWTYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 15:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233762AbjJWTY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 15:24:28 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251FD1BF2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 12:23:13 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-5079f3f3d7aso5811287e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 12:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1698088989; x=1698693789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5EcPvyMvZxkA/tm5aBCZ3L5YrriKsSOSNiPCBUZoqw=;
        b=E+7817jcL755IPbANif0e8XHy9cHTmblNXF78WYzgp7bPQgpuownpIPvvOfe4AHD7h
         mQvL1M0ud0UuTePGv+RxPeV2toKAa8IVosmeowra2OlhoJG3efpG5p/SySlcyv+uNtkZ
         TgRieNfuDKjj2kmTcLQ0NnHaurimmeRNrK7D1Fpw0t1GNLEinLYdDXAvmFyh7530eYiz
         9a9avepC6OQIXRcoal+UWqflaLqsSR7Zww8DfwMSr/Whhieru0NvG0VP7Vc9T7w9H5fG
         sQggg6qxpbKdXsiahp42/WiCzxuJ/BV4+yuj2NJK4S5IxFsjlJJuSPCtERx3oRKEmJUb
         I9fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698088989; x=1698693789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L5EcPvyMvZxkA/tm5aBCZ3L5YrriKsSOSNiPCBUZoqw=;
        b=mSf/duiU0MWHuq8FbueIlHa1SmiV4xr3TT57rbqkQpZWRsfLn/15ev5+/8H0cqLNhE
         XA0rcGH5LMut8Danojs1e8deY/DDWymxsFqeJnxOjO2+QBQLw0W0dDUcGvld/rOSPBnM
         0HN6x1Udti9qP7rGIC8DTK88MevPg+Bm22zJQOzD8CrZ0IySn+T87tj2Si224tTBJmuG
         NOpSpFms6SlwUZe6CRJbBX7TZgQQVMl7gEVLWF2cyASMw2excw+GrtchFqRWX3PFN2Pn
         rhcIrciB7U7EFPnDUZHbWh0odGusXrJrfPdguEv93i2VqZJ4n7hCqlS/vbH6K7EGhtUO
         O9+w==
X-Gm-Message-State: AOJu0YwnOwQoPqhDgoPOkDG03tSgLcGUSHunSt7L5q8yeJ1TORxqkudf
        y9yAj0enqGJJ13dqHDCwZ+tPZw==
X-Google-Smtp-Source: AGHT+IHCmYpDomKr88G6bZAJPe7Ir1rJjNNK1miOQpheWJdrZX02gC4xlFKAqRK1cq7een4Mug9hOQ==
X-Received: by 2002:ac2:597a:0:b0:507:9623:8ae8 with SMTP id h26-20020ac2597a000000b0050796238ae8mr7133824lfp.29.1698088988928;
        Mon, 23 Oct 2023 12:23:08 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id ay20-20020a05600c1e1400b00407460234f9sm10142088wmb.21.2023.10.23.12.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 12:23:08 -0700 (PDT)
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
Subject: [PATCH v16 net-next 22/23] net/tcp: Add TCP_AO_REPAIR
Date:   Mon, 23 Oct 2023 20:22:14 +0100
Message-ID: <20231023192217.426455-23-dima@arista.com>
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

Add TCP_AO_REPAIR setsockopt(), getsockopt(). They let a user to repair
TCP-AO ISNs/SNEs. Also let the user hack around when (tp->repair) is on
and add ao_info on a socket in any supported state.
As SNEs now can be read/written at any moment, use
WRITE_ONCE()/READ_ONCE() to set/read them.

Signed-off-by: Dmitry Safonov <dima@arista.com>
Acked-by: David Ahern <dsahern@kernel.org>
---
 include/net/tcp_ao.h     | 14 +++++++
 include/uapi/linux/tcp.h |  8 ++++
 net/ipv4/tcp.c           | 24 +++++++----
 net/ipv4/tcp_ao.c        | 90 ++++++++++++++++++++++++++++++++++++++--
 4 files changed, 125 insertions(+), 11 deletions(-)

diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
index edd6748b2cfa..a375a171ef3c 100644
--- a/include/net/tcp_ao.h
+++ b/include/net/tcp_ao.h
@@ -199,6 +199,8 @@ void tcp_ao_time_wait(struct tcp_timewait_sock *tcptw, struct tcp_sock *tp);
 bool tcp_ao_ignore_icmp(const struct sock *sk, int family, int type, int code);
 int tcp_ao_get_mkts(struct sock *sk, sockptr_t optval, sockptr_t optlen);
 int tcp_ao_get_sock_info(struct sock *sk, sockptr_t optval, sockptr_t optlen);
+int tcp_ao_get_repair(struct sock *sk, sockptr_t optval, sockptr_t optlen);
+int tcp_ao_set_repair(struct sock *sk, sockptr_t optval, unsigned int optlen);
 enum skb_drop_reason tcp_inbound_ao_hash(struct sock *sk,
 			const struct sk_buff *skb, unsigned short int family,
 			const struct request_sock *req, int l3index,
@@ -330,6 +332,18 @@ static inline int tcp_ao_get_sock_info(struct sock *sk, sockptr_t optval, sockpt
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
index be34d7c5c531..c07e9f90c084 100644
--- a/include/uapi/linux/tcp.h
+++ b/include/uapi/linux/tcp.h
@@ -133,6 +133,7 @@ enum {
 #define TCP_AO_DEL_KEY		39	/* Delete MKT */
 #define TCP_AO_INFO		40	/* Set/list TCP-AO per-socket options */
 #define TCP_AO_GET_KEYS		41	/* List MKT(s) */
+#define TCP_AO_REPAIR		42	/* Get/Set SNEs and ISNs */
 
 #define TCP_REPAIR_ON		1
 #define TCP_REPAIR_OFF		0
@@ -458,6 +459,13 @@ struct tcp_ao_getsockopt { /* getsockopt(TCP_AO_GET_KEYS) */
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
index a3107c28ea5f..6c0a7fd0bae0 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3591,20 +3591,28 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
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
@@ -4282,6 +4290,8 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 		return err;
 	}
 #endif
+	case TCP_AO_REPAIR:
+		return tcp_ao_get_repair(sk, optval, optlen);
 	case TCP_AO_GET_KEYS:
 	case TCP_AO_INFO: {
 		int err;
diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index b5ac3e73e1da..6a845e906a1d 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -1490,6 +1490,16 @@ static struct tcp_ao_info *setsockopt_ao_info(struct sock *sk)
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
 
@@ -1671,11 +1681,13 @@ static int tcp_ao_add_cmd(struct sock *sk, unsigned short int family,
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
@@ -1926,6 +1938,8 @@ static int tcp_ao_info_cmd(struct sock *sk, unsigned short int family,
 	if (IS_ERR(ao_info))
 		return PTR_ERR(ao_info);
 	if (!ao_info) {
+		if (!((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_CLOSE)))
+			return -EINVAL;
 		ao_info = tcp_ao_alloc_info(GFP_KERNEL);
 		if (!ao_info)
 			return -ENOMEM;
@@ -2308,3 +2322,71 @@ int tcp_ao_get_sock_info(struct sock *sk, sockptr_t optval, sockptr_t optlen)
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
+	if (IS_ERR_OR_NULL(ao)) {
+		rcu_read_unlock();
+		return ao ? PTR_ERR(ao) : -ENOENT;
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
2.42.0

