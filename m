Return-Path: <linux-kernel+bounces-154798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 758C78AE12C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24F09285F53
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0696F5A7AE;
	Tue, 23 Apr 2024 09:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="Xh3/4D0B"
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E0B1E863;
	Tue, 23 Apr 2024 09:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713865301; cv=none; b=Oh+DMLME6r4IY4sVYmayGk16AspmkoVdctBgQbNADD4q8E1CUUrGMJnu3emZq71Zt5wEYrChIYJx/9b1grmluIihz/DwsBc3OjZeEWnitP9JQmhgSCQUMv76iTOZjyODmkR9HLmQECNjYQimqd13yky/oK8PrcO0sfSqRb9YvtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713865301; c=relaxed/simple;
	bh=wb2gGxMz/+9M/fu8LK5AA0KiG+HzE1MoorNuamhvWuk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oLGm7aY9w/HnENE+vLZxTmwQIvYfgesJute5HY5T9jFZjoLEnq0NL7AACpeq308+Dh0uzDPMagtfpIvKCouu2ZLWyBY3G+aJM/ROfgACshQse5SFiCv2/0sgZzzmPS68hEnogBAznJHQX8i31EP579737tH0Itwj67O9MA4xMZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=Xh3/4D0B; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=+3kf4tnbxRPHO2i5PbtOTYevq1L+iHw94A4K7v9Pm5k=; b=Xh3/4D0BNY1Z9aADi/bBROWfMi
	oFXiQxizW+2DJ5o8+7SqeGLzBESZvo2v2gsVXYtnpKdHlF5V2WU+o/Ubc1DcWl0m/jLKAtEteAjLl
	JLt2J8iSjtqtkUy1PigWfZ80Yl6RYEEQdrWPYBgV6DW68Gcp8qEJC8BTg5Ja1xJ7SwJY=;
Received: from p54ae9c93.dip0.t-ipconnect.de ([84.174.156.147] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1rzCeT-005zvG-0C;
	Tue, 23 Apr 2024 11:41:25 +0200
From: Felix Fietkau <nbd@nbd.name>
To: netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [RFC] net: add TCP fraglist GRO support
Date: Tue, 23 Apr 2024 11:41:15 +0200
Message-ID: <20240423094117.93206-1-nbd@nbd.name>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When forwarding TCP after GRO, software segmentation is very expensive,
especially when the checksum needs to be recalculated.
One case where that's currently unavoidable is when routing packets over
PPPoE. Performance improves significantly when using fraglist GRO
implemented in the same way as for UDP.

Here's a measurement of running 2 TCP streams through a MediaTek MT7622
device (2-core Cortex-A53), which runs NAT with flow offload enabled from
one ethernet port to PPPoE on another ethernet port + cake qdisc set to
1Gbps.

rx-gro-list off: 630 Mbit/s, CPU 35% idle
rx-gro-list on:  770 Mbit/s, CPU 40% idle

Signe-off-by: Felix Fietkau <nbd@nbd.name>
---
 include/net/gro.h        |   1 +
 include/net/tcp.h        |   3 +-
 net/core/gro.c           |  27 ++++++++
 net/ipv4/tcp_offload.c   | 143 ++++++++++++++++++++++++++++++++++++++-
 net/ipv4/udp_offload.c   |  27 --------
 net/ipv6/tcpv6_offload.c |  58 +++++++++++++++-
 6 files changed, 228 insertions(+), 31 deletions(-)

diff --git a/include/net/gro.h b/include/net/gro.h
index 50f1e403dbbb..ca8e4b3de044 100644
--- a/include/net/gro.h
+++ b/include/net/gro.h
@@ -429,6 +429,7 @@ static inline __wsum ip6_gro_compute_pseudo(const struct sk_buff *skb,
 }
 
 int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb);
+int skb_gro_receive_list(struct sk_buff *p, struct sk_buff *skb);
 
 /* Pass the currently batched GRO_NORMAL SKBs up to the stack. */
 static inline void gro_normal_list(struct napi_struct *napi)
diff --git a/include/net/tcp.h b/include/net/tcp.h
index b935e1ae4caf..875cda53a7c9 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2194,7 +2194,8 @@ void tcp_v4_destroy_sock(struct sock *sk);
 
 struct sk_buff *tcp_gso_segment(struct sk_buff *skb,
 				netdev_features_t features);
-struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb);
+struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb,
+				bool fraglist);
 INDIRECT_CALLABLE_DECLARE(int tcp4_gro_complete(struct sk_buff *skb, int thoff));
 INDIRECT_CALLABLE_DECLARE(struct sk_buff *tcp4_gro_receive(struct list_head *head, struct sk_buff *skb));
 INDIRECT_CALLABLE_DECLARE(int tcp6_gro_complete(struct sk_buff *skb, int thoff));
diff --git a/net/core/gro.c b/net/core/gro.c
index 2459ab697f7f..268c6c826d09 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -231,6 +231,33 @@ int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb)
 	return 0;
 }
 
+int skb_gro_receive_list(struct sk_buff *p, struct sk_buff *skb)
+{
+	if (unlikely(p->len + skb->len >= 65536))
+		return -E2BIG;
+
+	if (NAPI_GRO_CB(p)->last == p)
+		skb_shinfo(p)->frag_list = skb;
+	else
+		NAPI_GRO_CB(p)->last->next = skb;
+
+	skb_pull(skb, skb_gro_offset(skb));
+
+	NAPI_GRO_CB(p)->last = skb;
+	NAPI_GRO_CB(p)->count++;
+	p->data_len += skb->len;
+
+	/* sk ownership - if any - completely transferred to the aggregated packet */
+	skb->destructor = NULL;
+	skb->sk = NULL;
+	p->truesize += skb->truesize;
+	p->len += skb->len;
+
+	NAPI_GRO_CB(skb)->same_flow = 1;
+
+	return 0;
+}
+
 
 static void napi_gro_complete(struct napi_struct *napi, struct sk_buff *skb)
 {
diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index fab0973f995b..4f6e40a30b0c 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -28,6 +28,74 @@ static void tcp_gso_tstamp(struct sk_buff *skb, unsigned int ts_seq,
 	}
 }
 
+static void __tcpv4_gso_segment_csum(struct sk_buff *seg,
+				     __be32 *oldip, __be32 *newip,
+				     __be16 *oldport, __be16 *newport)
+{
+	struct tcphdr *th;
+	struct iphdr *iph;
+
+	if (*oldip == *newip && *oldport == *newport)
+		return;
+
+	th = tcp_hdr(seg);
+	iph = ip_hdr(seg);
+
+	if (th->check) {
+		inet_proto_csum_replace4(&th->check, seg, *oldip, *newip,
+					 true);
+		inet_proto_csum_replace2(&th->check, seg, *oldport, *newport,
+					 false);
+		if (!th->check)
+			th->check = CSUM_MANGLED_0;
+	}
+	*oldport = *newport;
+
+	csum_replace4(&iph->check, *oldip, *newip);
+	*oldip = *newip;
+}
+
+static struct sk_buff *__tcpv4_gso_segment_list_csum(struct sk_buff *segs)
+{
+	struct sk_buff *seg;
+	struct tcphdr *uh, *uh2;
+	struct iphdr *iph, *iph2;
+
+	seg = segs;
+	uh = tcp_hdr(seg);
+	iph = ip_hdr(seg);
+
+	if ((tcp_hdr(seg)->dest == tcp_hdr(seg->next)->dest) &&
+	    (tcp_hdr(seg)->source == tcp_hdr(seg->next)->source) &&
+	    (ip_hdr(seg)->daddr == ip_hdr(seg->next)->daddr) &&
+	    (ip_hdr(seg)->saddr == ip_hdr(seg->next)->saddr))
+		return segs;
+
+	while ((seg = seg->next)) {
+		uh2 = tcp_hdr(seg);
+		iph2 = ip_hdr(seg);
+
+		__tcpv4_gso_segment_csum(seg,
+					 &iph2->saddr, &iph->saddr,
+					 &uh2->source, &uh->source);
+		__tcpv4_gso_segment_csum(seg,
+					 &iph2->daddr, &iph->daddr,
+					 &uh2->dest, &uh->dest);
+	}
+
+	return segs;
+}
+
+static struct sk_buff *__tcp_gso_segment_list(struct sk_buff *skb,
+					      netdev_features_t features)
+{
+	skb = skb_segment_list(skb, features, skb_mac_header_len(skb));
+	if (IS_ERR(skb))
+		return skb;
+
+	return __tcpv4_gso_segment_list_csum(skb);
+}
+
 static struct sk_buff *tcp4_gso_segment(struct sk_buff *skb,
 					netdev_features_t features)
 {
@@ -37,6 +105,9 @@ static struct sk_buff *tcp4_gso_segment(struct sk_buff *skb,
 	if (!pskb_may_pull(skb, sizeof(struct tcphdr)))
 		return ERR_PTR(-EINVAL);
 
+	if (skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST)
+		return __tcp_gso_segment_list(skb, features);
+
 	if (unlikely(skb->ip_summed != CHECKSUM_PARTIAL)) {
 		const struct iphdr *iph = ip_hdr(skb);
 		struct tcphdr *th = tcp_hdr(skb);
@@ -178,7 +249,8 @@ struct sk_buff *tcp_gso_segment(struct sk_buff *skb,
 	return segs;
 }
 
-struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb)
+struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb,
+				bool fraglist)
 {
 	struct sk_buff *pp = NULL;
 	struct sk_buff *p;
@@ -215,6 +287,7 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb)
 	len = skb_gro_len(skb);
 	flags = tcp_flag_word(th);
 
+	NAPI_GRO_CB(skb)->is_flist = fraglist;
 	list_for_each_entry(p, head, list) {
 		if (!NAPI_GRO_CB(p)->same_flow)
 			continue;
@@ -234,6 +307,7 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb)
 found:
 	/* Include the IP ID check below from the inner most IP hdr */
 	flush = NAPI_GRO_CB(p)->flush;
+	flush |= fraglist != NAPI_GRO_CB(p)->is_flist;
 	flush |= (__force int)(flags & TCP_FLAG_CWR);
 	flush |= (__force int)((flags ^ tcp_flag_word(th2)) &
 		  ~(TCP_FLAG_CWR | TCP_FLAG_FIN | TCP_FLAG_PSH));
@@ -267,6 +341,19 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb)
 	flush |= (ntohl(th2->seq) + skb_gro_len(p)) ^ ntohl(th->seq);
 	flush |= skb_cmp_decrypted(p, skb);
 
+	if (fraglist) {
+		flush |= (__force int)(flags ^ tcp_flag_word(th2));
+		flush |= skb->ip_summed != p->ip_summed;
+		flush |= skb->csum_level != p->csum_level;
+		flush |= !pskb_may_pull(skb, skb_gro_offset(skb));
+		flush |= NAPI_GRO_CB(p)->count >= 64;
+
+		if (flush || skb_gro_receive_list(p, skb))
+			mss = 1;
+
+		goto out_check_final;
+	}
+
 	if (flush || skb_gro_receive(p, skb)) {
 		mss = 1;
 		goto out_check_final;
@@ -314,6 +401,49 @@ void tcp_gro_complete(struct sk_buff *skb)
 }
 EXPORT_SYMBOL(tcp_gro_complete);
 
+static bool tcp4_check_fraglist_gro(struct sk_buff *skb)
+{
+	const struct iphdr *iph = skb_gro_network_header(skb);
+	struct net *net = dev_net(skb->dev);
+	unsigned int off, hlen, thlen;
+	struct tcphdr *th;
+	struct sock *sk;
+	int iif, sdif;
+
+	if (!(skb->dev->features & NETIF_F_GRO_FRAGLIST))
+		return false;
+
+	inet_get_iif_sdif(skb, &iif, &sdif);
+
+	off = skb_gro_offset(skb);
+	hlen = off + sizeof(*th);
+	th = skb_gro_header(skb, hlen, off);
+	if (unlikely(!th))
+		return false;
+
+	thlen = th->doff * 4;
+	if (thlen < sizeof(*th))
+		return false;
+
+	hlen = off + thlen;
+	if (!skb_gro_may_pull(skb, hlen)) {
+		th = skb_gro_header_slow(skb, hlen, off);
+		if (unlikely(!th))
+			return false;
+	}
+
+	sk = __inet_lookup_established(net, net->ipv4.tcp_death_row.hashinfo,
+				       iph->saddr, th->source,
+				       iph->daddr, ntohs(th->dest),
+				       iif, sdif);
+	if (!sk)
+		return true;
+
+	sock_put(sk);
+
+	return false;
+}
+
 INDIRECT_CALLABLE_SCOPE
 struct sk_buff *tcp4_gro_receive(struct list_head *head, struct sk_buff *skb)
 {
@@ -325,7 +455,7 @@ struct sk_buff *tcp4_gro_receive(struct list_head *head, struct sk_buff *skb)
 		return NULL;
 	}
 
-	return tcp_gro_receive(head, skb);
+	return tcp_gro_receive(head, skb, tcp4_check_fraglist_gro(skb));
 }
 
 INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int thoff)
@@ -333,6 +463,15 @@ INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int thoff)
 	const struct iphdr *iph = ip_hdr(skb);
 	struct tcphdr *th = tcp_hdr(skb);
 
+	if (NAPI_GRO_CB(skb)->is_flist) {
+		skb_shinfo(skb)->gso_type |= SKB_GSO_FRAGLIST | SKB_GSO_TCPV4;
+		skb_shinfo(skb)->gso_segs = NAPI_GRO_CB(skb)->count;
+
+		__skb_incr_checksum_unnecessary(skb);
+
+		return 0;
+	}
+
 	th->check = ~tcp_v4_check(skb->len - thoff, iph->saddr,
 				  iph->daddr, 0);
 
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 3498dd1d0694..a3cd546a1aea 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -433,33 +433,6 @@ static struct sk_buff *udp4_ufo_fragment(struct sk_buff *skb,
 	return segs;
 }
 
-static int skb_gro_receive_list(struct sk_buff *p, struct sk_buff *skb)
-{
-	if (unlikely(p->len + skb->len >= 65536))
-		return -E2BIG;
-
-	if (NAPI_GRO_CB(p)->last == p)
-		skb_shinfo(p)->frag_list = skb;
-	else
-		NAPI_GRO_CB(p)->last->next = skb;
-
-	skb_pull(skb, skb_gro_offset(skb));
-
-	NAPI_GRO_CB(p)->last = skb;
-	NAPI_GRO_CB(p)->count++;
-	p->data_len += skb->len;
-
-	/* sk ownership - if any - completely transferred to the aggregated packet */
-	skb->destructor = NULL;
-	skb->sk = NULL;
-	p->truesize += skb->truesize;
-	p->len += skb->len;
-
-	NAPI_GRO_CB(skb)->same_flow = 1;
-
-	return 0;
-}
-
 
 #define UDP_GRO_CNT_MAX 64
 static struct sk_buff *udp_gro_receive_segment(struct list_head *head,
diff --git a/net/ipv6/tcpv6_offload.c b/net/ipv6/tcpv6_offload.c
index 4b07d1e6c952..7c82532d8aa7 100644
--- a/net/ipv6/tcpv6_offload.c
+++ b/net/ipv6/tcpv6_offload.c
@@ -7,12 +7,56 @@
  */
 #include <linux/indirect_call_wrapper.h>
 #include <linux/skbuff.h>
+#include <net/inet6_hashtables.h>
 #include <net/gro.h>
 #include <net/protocol.h>
 #include <net/tcp.h>
 #include <net/ip6_checksum.h>
 #include "ip6_offload.h"
 
+static bool tcp6_check_fraglist_gro(struct sk_buff *skb)
+{
+	const struct ipv6hdr *hdr = skb_gro_network_header(skb);
+	struct net *net = dev_net(skb->dev);
+	unsigned int off, hlen, thlen;
+	struct tcphdr *th;
+	struct sock *sk;
+	int iif, sdif;
+
+	if (!(skb->dev->features & NETIF_F_GRO_FRAGLIST))
+		return false;
+
+	inet6_get_iif_sdif(skb, &iif, &sdif);
+
+	off = skb_gro_offset(skb);
+	hlen = off + sizeof(*th);
+	th = skb_gro_header(skb, hlen, off);
+	if (unlikely(!th))
+		return false;
+
+	thlen = th->doff * 4;
+	if (thlen < sizeof(*th))
+		return false;
+
+	hlen = off + thlen;
+	if (!skb_gro_may_pull(skb, hlen)) {
+		th = skb_gro_header_slow(skb, hlen, off);
+		if (unlikely(!th))
+			return false;
+	}
+
+	sk = __inet6_lookup_established(net, net->ipv4.tcp_death_row.hashinfo,
+					&hdr->saddr, th->source,
+					&hdr->daddr, ntohs(th->dest),
+					iif, sdif);
+	if (!sk)
+		return true;
+
+	sock_put(sk);
+
+	return false;
+}
+
 INDIRECT_CALLABLE_SCOPE
 struct sk_buff *tcp6_gro_receive(struct list_head *head, struct sk_buff *skb)
 {
@@ -24,7 +68,7 @@ struct sk_buff *tcp6_gro_receive(struct list_head *head, struct sk_buff *skb)
 		return NULL;
 	}
 
-	return tcp_gro_receive(head, skb);
+	return tcp_gro_receive(head, skb, tcp6_check_fraglist_gro(skb));
 }
 
 INDIRECT_CALLABLE_SCOPE int tcp6_gro_complete(struct sk_buff *skb, int thoff)
@@ -32,6 +76,15 @@ INDIRECT_CALLABLE_SCOPE int tcp6_gro_complete(struct sk_buff *skb, int thoff)
 	const struct ipv6hdr *iph = ipv6_hdr(skb);
 	struct tcphdr *th = tcp_hdr(skb);
 
+	if (NAPI_GRO_CB(skb)->is_flist) {
+		skb_shinfo(skb)->gso_type |= SKB_GSO_FRAGLIST | SKB_GSO_TCPV6;
+		skb_shinfo(skb)->gso_segs = NAPI_GRO_CB(skb)->count;
+
+		__skb_incr_checksum_unnecessary(skb);
+
+		return 0;
+	}
+
 	th->check = ~tcp_v6_check(skb->len - thoff, &iph->saddr,
 				  &iph->daddr, 0);
 	skb_shinfo(skb)->gso_type |= SKB_GSO_TCPV6;
@@ -51,6 +104,9 @@ static struct sk_buff *tcp6_gso_segment(struct sk_buff *skb,
 	if (!pskb_may_pull(skb, sizeof(*th)))
 		return ERR_PTR(-EINVAL);
 
+	if (skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST)
+		return skb_segment_list(skb, features, skb_mac_header_len(skb));
+
 	if (unlikely(skb->ip_summed != CHECKSUM_PARTIAL)) {
 		const struct ipv6hdr *ipv6h = ipv6_hdr(skb);
 		struct tcphdr *th = tcp_hdr(skb);
-- 
2.44.0


