Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43FE87D53F7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 16:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343755AbjJXO0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 10:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343524AbjJXO0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 10:26:40 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF44CC4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 07:26:37 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-7789923612dso313208685a.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 07:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1698157597; x=1698762397; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BV4wMKpDzQBLCaMJ5oNzkZGgqGs5udbKvGwD/DtKxNQ=;
        b=dZB6VbgPHgNvjBc0pN5AmGnFLRwM2WmCYVx2EvyijbbQUKr1lksGj6N8PkVjoYlosj
         z2mOwdGquZVJTCZunem+skxub6J5RtfzpA0woDNYE4Qd6JGGd6zlDMAzRi0l2tATNpji
         vGsQginhjxJNeAjpBUUEczZqzOjTuukwMrOU9RxA4JejpEZo1GE8g0tLNzzoIYBLzGnP
         4UOAPd9tfkrvpa561Pp+rfWEXQftmsSH3tiM+ZgTT+qv9DQsczj8/gUmKUjrZwWcaIu5
         jmt3ZZP9OUoJMnqjG+VeCoh9Qkjam2w8BMl6cQeLAQ8BFxx4gilPCrWZ8+Lfo++J6Za2
         U8Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698157597; x=1698762397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BV4wMKpDzQBLCaMJ5oNzkZGgqGs5udbKvGwD/DtKxNQ=;
        b=Csg7uwCpb/t/M0I2Ya86KKg2mQWLQ5ekAkiINN+e/FgPhdn2VO0THiI60r/yfXwZsE
         bVJgg3I+UKXpYZ3pHfmtaYCPusX4fFU8sssNCXF3xZpybBN/vVti4UzxZ0JLjTz9Mfwe
         XLSnNjlOWAsnnWkGYGjECMlCztCM1dgkEiyfnSp2z6hbw+nqFqPUN3FaawyRGGf53Zv1
         +2M0rarfvF220wZoXRtWNcS8AP1FKmUpN5WFDMB4xlJkOCT8u6lKDwA8bVCc4HHoNJcK
         ZtPxE92ZxYqryPvEuash7+EXLToPZ2myl9opomMemz/xV+6rPR81pUKitSxsGYPaK5nZ
         WdCg==
X-Gm-Message-State: AOJu0Yx2pCjLYrengxnZVfqpXbXwupz568Q8WUMty75ONcoDVmUOe+Ip
        MLSMR731Z0pkVhMOMnE8qMSUEg==
X-Google-Smtp-Source: AGHT+IEZ6PsopxjSad0KhLBGpzGV2/A96V2EbayO1PiYjUOLyPkKSpdVO8BjYzWpDu8a0BZwJMasng==
X-Received: by 2002:a05:620a:3d12:b0:770:9e5b:e1e7 with SMTP id tq18-20020a05620a3d1200b007709e5be1e7mr10492122qkn.62.1698157596942;
        Tue, 24 Oct 2023 07:26:36 -0700 (PDT)
Received: from debian.debian ([140.141.197.139])
        by smtp.gmail.com with ESMTPSA id y5-20020a37e305000000b0076d25b11b62sm3482629qki.38.2023.10.24.07.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 07:26:36 -0700 (PDT)
Date:   Tue, 24 Oct 2023 07:26:33 -0700
From:   Yan Zhai <yan@cloudflare.com>
To:     netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Aya Levin <ayal@nvidia.com>,
        Tariq Toukan <tariqt@nvidia.com>, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com, Florian Westphal <fw@strlen.de>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Alexander H Duyck <alexander.duyck@gmail.com>
Subject: [PATCH v5 net-next 1/3] ipv6: drop feature RTAX_FEATURE_ALLFRAG
Message-ID: <d78e44dcd9968a252143ffe78460446476a472a1.1698156966.git.yan@cloudflare.com>
References: <cover.1698156966.git.yan@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1698156966.git.yan@cloudflare.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RTAX_FEATURE_ALLFRAG was added before the first git commit:

https://www.mail-archive.com/bk-commits-head@vger.kernel.org/msg03399.html

The feature would send packets to the fragmentation path if a box
receives a PMTU value with less than 1280 byte. However, since commit
9d289715eb5c ("ipv6: stop sending PTB packets for MTU < 1280"), such
message would be simply discarded. The feature flag is neither supported
in iproute2 utility. In theory one can still manipulate it with direct
netlink message, but it is not ideal because it was based on obsoleted
guidance of RFC-2460 (replaced by RFC-8200).

The feature would always test false at the moment, so remove related
code or mark them as unused.

Signed-off-by: Yan Zhai <yan@cloudflare.com>
Reviewed-by: Florian Westphal <fw@strlen.de>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
V4 -> V5: removed a unused macro instead of adding "unused" comment
V3 -> V4: cleaned up all RTAX_FEATURE_ALLFRAG code, rather than just
drop the check at IPv6 output.

---
 include/net/dst.h                  |  7 -------
 include/net/inet_connection_sock.h |  1 -
 include/net/inet_sock.h            |  1 -
 include/uapi/linux/rtnetlink.h     |  2 +-
 net/ipv4/tcp_output.c              | 20 +-------------------
 net/ipv6/ip6_output.c              | 15 ++-------------
 net/ipv6/tcp_ipv6.c                |  1 -
 net/ipv6/xfrm6_output.c            |  2 +-
 net/mptcp/subflow.c                |  1 -
 9 files changed, 5 insertions(+), 45 deletions(-)

diff --git a/include/net/dst.h b/include/net/dst.h
index f8b8599a0600..f5dfc8fb7b37 100644
--- a/include/net/dst.h
+++ b/include/net/dst.h
@@ -222,13 +222,6 @@ static inline unsigned long dst_metric_rtt(const struct dst_entry *dst, int metr
 	return msecs_to_jiffies(dst_metric(dst, metric));
 }
 
-static inline u32
-dst_allfrag(const struct dst_entry *dst)
-{
-	int ret = dst_feature(dst,  RTAX_FEATURE_ALLFRAG);
-	return ret;
-}
-
 static inline int
 dst_metric_locked(const struct dst_entry *dst, int metric)
 {
diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index 086d1193c9ef..d0a2f827d5f2 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -44,7 +44,6 @@ struct inet_connection_sock_af_ops {
 				      struct request_sock *req_unhash,
 				      bool *own_req);
 	u16	    net_header_len;
-	u16	    net_frag_header_len;
 	u16	    sockaddr_len;
 	int	    (*setsockopt)(struct sock *sk, int level, int optname,
 				  sockptr_t optval, unsigned int optlen);
diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
index 98e11958cdff..74db6d97cae1 100644
--- a/include/net/inet_sock.h
+++ b/include/net/inet_sock.h
@@ -244,7 +244,6 @@ struct inet_sock {
 };
 
 #define IPCORK_OPT	1	/* ip-options has been held in ipcork.opt */
-#define IPCORK_ALLFRAG	2	/* always fragment (for ipv6 for now) */
 
 enum {
 	INET_FLAGS_PKTINFO	= 0,
diff --git a/include/uapi/linux/rtnetlink.h b/include/uapi/linux/rtnetlink.h
index aa2482a0614a..3b687d20c9ed 100644
--- a/include/uapi/linux/rtnetlink.h
+++ b/include/uapi/linux/rtnetlink.h
@@ -505,7 +505,7 @@ enum {
 #define RTAX_FEATURE_ECN		(1 << 0)
 #define RTAX_FEATURE_SACK		(1 << 1) /* unused */
 #define RTAX_FEATURE_TIMESTAMP		(1 << 2) /* unused */
-#define RTAX_FEATURE_ALLFRAG		(1 << 3)
+#define RTAX_FEATURE_ALLFRAG		(1 << 3) /* unused */
 #define RTAX_FEATURE_TCP_USEC_TS	(1 << 4)
 
 #define RTAX_FEATURE_MASK	(RTAX_FEATURE_ECN |		\
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 2866ccbccde0..ca4d7594efd4 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1698,14 +1698,6 @@ static inline int __tcp_mtu_to_mss(struct sock *sk, int pmtu)
 	 */
 	mss_now = pmtu - icsk->icsk_af_ops->net_header_len - sizeof(struct tcphdr);
 
-	/* IPv6 adds a frag_hdr in case RTAX_FEATURE_ALLFRAG is set */
-	if (icsk->icsk_af_ops->net_frag_header_len) {
-		const struct dst_entry *dst = __sk_dst_get(sk);
-
-		if (dst && dst_allfrag(dst))
-			mss_now -= icsk->icsk_af_ops->net_frag_header_len;
-	}
-
 	/* Clamp it (mss_clamp does not include tcp options) */
 	if (mss_now > tp->rx_opt.mss_clamp)
 		mss_now = tp->rx_opt.mss_clamp;
@@ -1733,21 +1725,11 @@ int tcp_mss_to_mtu(struct sock *sk, int mss)
 {
 	const struct tcp_sock *tp = tcp_sk(sk);
 	const struct inet_connection_sock *icsk = inet_csk(sk);
-	int mtu;
 
-	mtu = mss +
+	return mss +
 	      tp->tcp_header_len +
 	      icsk->icsk_ext_hdr_len +
 	      icsk->icsk_af_ops->net_header_len;
-
-	/* IPv6 adds a frag_hdr in case RTAX_FEATURE_ALLFRAG is set */
-	if (icsk->icsk_af_ops->net_frag_header_len) {
-		const struct dst_entry *dst = __sk_dst_get(sk);
-
-		if (dst && dst_allfrag(dst))
-			mtu += icsk->icsk_af_ops->net_frag_header_len;
-	}
-	return mtu;
 }
 EXPORT_SYMBOL(tcp_mss_to_mtu);
 
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 3c7de89d6755..86efd901ee5a 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -191,7 +191,6 @@ static int __ip6_finish_output(struct net *net, struct sock *sk, struct sk_buff
 		return ip6_finish_output_gso_slowpath_drop(net, sk, skb, mtu);
 
 	if ((skb->len > mtu && !skb_is_gso(skb)) ||
-	    dst_allfrag(skb_dst(skb)) ||
 	    (IP6CB(skb)->frag_max_size && skb->len > IP6CB(skb)->frag_max_size))
 		return ip6_fragment(net, sk, skb, ip6_finish_output2);
 	else
@@ -1017,9 +1016,6 @@ int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 	return err;
 
 fail_toobig:
-	if (skb->sk && dst_allfrag(skb_dst(skb)))
-		sk_gso_disable(skb->sk);
-
 	icmpv6_send(skb, ICMPV6_PKT_TOOBIG, 0, mtu);
 	err = -EMSGSIZE;
 
@@ -1384,10 +1380,7 @@ static int ip6_setup_cork(struct sock *sk, struct inet_cork_full *cork,
 	cork->base.mark = ipc6->sockc.mark;
 	sock_tx_timestamp(sk, ipc6->sockc.tsflags, &cork->base.tx_flags);
 
-	if (dst_allfrag(xfrm_dst_path(&rt->dst)))
-		cork->base.flags |= IPCORK_ALLFRAG;
 	cork->base.length = 0;
-
 	cork->base.transmit_time = ipc6->sockc.transmit_time;
 
 	return 0;
@@ -1444,8 +1437,6 @@ static int __ip6_append_data(struct sock *sk,
 
 	headersize = sizeof(struct ipv6hdr) +
 		     (opt ? opt->opt_flen + opt->opt_nflen : 0) +
-		     (dst_allfrag(&rt->dst) ?
-		      sizeof(struct frag_hdr) : 0) +
 		     rt->rt6i_nfheader_len;
 
 	if (mtu <= fragheaderlen ||
@@ -1555,7 +1546,7 @@ static int __ip6_append_data(struct sock *sk,
 
 	while (length > 0) {
 		/* Check if the remaining data fits into current packet. */
-		copy = (cork->length <= mtu && !(cork->flags & IPCORK_ALLFRAG) ? mtu : maxfraglen) - skb->len;
+		copy = (cork->length <= mtu ? mtu : maxfraglen) - skb->len;
 		if (copy < length)
 			copy = maxfraglen - skb->len;
 
@@ -1586,7 +1577,7 @@ static int __ip6_append_data(struct sock *sk,
 			 */
 			datalen = length + fraggap;
 
-			if (datalen > (cork->length <= mtu && !(cork->flags & IPCORK_ALLFRAG) ? mtu : maxfraglen) - fragheaderlen)
+			if (datalen > (cork->length <= mtu ? mtu : maxfraglen) - fragheaderlen)
 				datalen = maxfraglen - fragheaderlen - rt->dst.trailer_len;
 			fraglen = datalen + fragheaderlen;
 			pagedlen = 0;
@@ -1835,7 +1826,6 @@ static void ip6_cork_steal_dst(struct sk_buff *skb, struct inet_cork_full *cork)
 	struct dst_entry *dst = cork->base.dst;
 
 	cork->base.dst = NULL;
-	cork->base.flags &= ~IPCORK_ALLFRAG;
 	skb_dst_set(skb, dst);
 }
 
@@ -1856,7 +1846,6 @@ static void ip6_cork_release(struct inet_cork_full *cork,
 	if (cork->base.dst) {
 		dst_release(cork->base.dst);
 		cork->base.dst = NULL;
-		cork->base.flags &= ~IPCORK_ALLFRAG;
 	}
 }
 
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 0c8a14ba104f..dc27988512a6 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1895,7 +1895,6 @@ const struct inet_connection_sock_af_ops ipv6_specific = {
 	.conn_request	   = tcp_v6_conn_request,
 	.syn_recv_sock	   = tcp_v6_syn_recv_sock,
 	.net_header_len	   = sizeof(struct ipv6hdr),
-	.net_frag_header_len = sizeof(struct frag_hdr),
 	.setsockopt	   = ipv6_setsockopt,
 	.getsockopt	   = ipv6_getsockopt,
 	.addr2sockaddr	   = inet6_csk_addr2sockaddr,
diff --git a/net/ipv6/xfrm6_output.c b/net/ipv6/xfrm6_output.c
index ad07904642ca..5f7b1fdbffe6 100644
--- a/net/ipv6/xfrm6_output.c
+++ b/net/ipv6/xfrm6_output.c
@@ -95,7 +95,7 @@ static int __xfrm6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 		return -EMSGSIZE;
 	}
 
-	if (toobig || dst_allfrag(skb_dst(skb)))
+	if (toobig)
 		return ip6_fragment(net, sk, skb,
 				    __xfrm6_output_finish);
 
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 9c1f8d1d63d2..7064543b534d 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -2044,7 +2044,6 @@ void __init mptcp_subflow_init(void)
 	subflow_v6m_specific.send_check = ipv4_specific.send_check;
 	subflow_v6m_specific.net_header_len = ipv4_specific.net_header_len;
 	subflow_v6m_specific.mtu_reduced = ipv4_specific.mtu_reduced;
-	subflow_v6m_specific.net_frag_header_len = 0;
 	subflow_v6m_specific.rebuild_header = subflow_rebuild_header;
 
 	tcpv6_prot_override = tcpv6_prot;
-- 
2.30.2


