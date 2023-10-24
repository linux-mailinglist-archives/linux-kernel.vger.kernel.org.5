Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B1A7D4590
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 04:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbjJXCfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 22:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbjJXCfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 22:35:43 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C155310CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 19:35:36 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-41cc535cd5cso25474431cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 19:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1698114936; x=1698719736; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PKCfFTctINsmr0NVINSOxPjj3BaFxpxN7lJJJNdp9c8=;
        b=BFLScDwTEr6QzcRuvCY5DWx9r1BhGYAvODy4EziPobaoQK4ghKYI/biHgDjwwm83OP
         h6jdOxNygtZzYKcKtXOtIN0t5uaX9++9+tSshRB4EggecGmTsRgVOQ1DIpAP5b+OwBrq
         hXODtU4Xd5/bT+0GKqorfqqJvEPfJxglbogtRHZxeEjTsQxohlyHEPMVzJRWVev9o+HM
         DJrEVPxLxunNXVLrgvAkssFHMgnHCaGz77crj1EgtIRGc85aYHDb5ENrHXNnP9ex/E1Z
         dWz87ua8w2zt/LvwKB72JDVcZ3nIzDztw6Sws6kAxGnAwM4tvyfcatcJ+6W5tF7s6Bgj
         74DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698114936; x=1698719736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PKCfFTctINsmr0NVINSOxPjj3BaFxpxN7lJJJNdp9c8=;
        b=rBw3Q7wia0ly3ymHxB88C+iHLmQqeHLyno3DkoPU2g1AuMTUxD7s8MY5O5CWhIRMXR
         GQwdpRiCoB7aufaF1ckPJl/gryL4h6Nrud59Sox8gOGETCU+TEO9I51YopkxzyITvKyA
         brIcy+66fqlo101Vd48E7mt/f7vkyGAt2AECzEUz9cZaGCzVWDKKAXiypEs5jxHGY8Ks
         My5au6HHBnAnN3pjt3VNdmY9jzDPdE90qekjlBJyWwwTFx7MH4H5QO4V8ovU5asALz40
         JesnwSFiPXtAfOCZbmrMzhOQZQtkcAXWo3ztgfATawywgwCobwBlG1FtIczBatfBKKok
         OfJA==
X-Gm-Message-State: AOJu0Yx5W1RVedCQBDL9NBhpU4hls4TsV7b/h6O9yobfswmsN14XjibE
        ayYp+Ym3kez+9TG6jDMALulIRQ==
X-Google-Smtp-Source: AGHT+IGLQf5wDDE9ASY9v5Epd/4/zSZPQxEtDVBOB13XvEMesiBo3RkNeoRHN2FlrQCN3AAhTaALig==
X-Received: by 2002:a05:622a:15cb:b0:418:bdf:f4b with SMTP id d11-20020a05622a15cb00b004180bdf0f4bmr13680615qty.6.1698114935795;
        Mon, 23 Oct 2023 19:35:35 -0700 (PDT)
Received: from debian.debian ([140.141.197.139])
        by smtp.gmail.com with ESMTPSA id f1-20020a05622a1a0100b0041cc25a75e5sm3188759qtb.77.2023.10.23.19.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 19:35:35 -0700 (PDT)
Date:   Mon, 23 Oct 2023 19:35:34 -0700
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
Subject: [PATCH v4 net-next 1/3] ipv6: drop feature RTAX_FEATURE_ALLFRAG
Message-ID: <a79fe77d7308f7e6de7a019f23a509b84cbacd79.1698114636.git.yan@cloudflare.com>
References: <cover.1698114636.git.yan@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1698114636.git.yan@cloudflare.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
---
V3 -> V4: cleaned up all RTAX_FEATURE_ALLFRAG code, rather than just
drop the check at IPv6 output.

---
 include/net/dst.h                  |  7 -------
 include/net/inet_connection_sock.h |  1 -
 include/net/inet_sock.h            |  2 +-
 include/uapi/linux/rtnetlink.h     |  2 +-
 net/ipv4/tcp_output.c              | 20 +-------------------
 net/ipv6/ip6_output.c              | 15 ++-------------
 net/ipv6/tcp_ipv6.c                |  1 -
 net/ipv6/xfrm6_output.c            |  2 +-
 net/mptcp/subflow.c                |  1 -
 9 files changed, 6 insertions(+), 45 deletions(-)

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
index 98e11958cdff..dedbc757b688 100644
--- a/include/net/inet_sock.h
+++ b/include/net/inet_sock.h
@@ -244,7 +244,7 @@ struct inet_sock {
 };
 
 #define IPCORK_OPT	1	/* ip-options has been held in ipcork.opt */
-#define IPCORK_ALLFRAG	2	/* always fragment (for ipv6 for now) */
+#define IPCORK_ALLFRAG	2	/* (unused) always fragment (for ipv6 for now) */
 
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


