Return-Path: <linux-kernel+bounces-158763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FFA8B249C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2016F1F22222
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F75414A638;
	Thu, 25 Apr 2024 15:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="Ky/Jx7hq"
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D9114A60F;
	Thu, 25 Apr 2024 15:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714057487; cv=none; b=uLImoN/8swyBlW5D7djPERjPc5PzVT6NSU/NVDBb6o6hpNIX5uTMsX59CJ40kZvJ5aL4ZeJc2lBbQ1PkZ+Yy40xbx/j2GvenM08wjjnvU3+LQDCC9CmKhLjpdA0HIG+SHlfmL2BnaOScm7lJX1N/cwun48LeVMmLTCeL992pAo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714057487; c=relaxed/simple;
	bh=XsA6Bnr8udqzeHufN8JZoBZbGc3WJ80AoizI6yylbuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oKurWv9KsY0GQ8Wor+gusZRIoo4cn9qm4ZHY4Xct3ohraat6gEa49Xx4hRYCIP5Yks7XPZlMkbClfuuaM4XmUxgKvScGKdaomlDGYpyABbGdA3xvkcVZbq78nEKOA7pys7XwZI+3qRQyGRa/QFaMFmV0f+kuQLmvzZD4lCxYamc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=Ky/Jx7hq; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=wDFTRuolUQKGuq6Mg9SzkOokphKxwcPDD4Ndi/IBkwo=; b=Ky/Jx7hqkUc8zhPIc95YJXTS8z
	k2wz/kW885k2/baIr1PkPBq+RpNmzIa8x7axVNO0GZr1ZGC/wHyFH0eeyc262yFt5x1F4AsVqioJm
	mjdTFpa/FLTJqaBJbLNAEfGBvcTTkrOwGx3E/S6CBrxwWV20uAhQ9jd+rX+0d0UbmYRw=;
Received: from p54ae9c93.dip0.t-ipconnect.de ([84.174.156.147] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1s00eK-007MWz-23;
	Thu, 25 Apr 2024 17:04:36 +0200
From: Felix Fietkau <nbd@nbd.name>
To: netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: willemdebruijn.kernel@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 net-next v2 4/4] net: add heuristic for enabling TCP fraglist GRO
Date: Thu, 25 Apr 2024 17:04:27 +0200
Message-ID: <20240425150432.44142-5-nbd@nbd.name>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240425150432.44142-1-nbd@nbd.name>
References: <20240425150432.44142-1-nbd@nbd.name>
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

When NETIF_F_GRO_FRAGLIST is enabled, perform a lookup for an established
socket in the same netns as the receiving device. While this may not
cover all relevant use cases in multi-netns configurations, it should be
good enough for most configurations that need this.

Here's a measurement of running 2 TCP streams through a MediaTek MT7622
device (2-core Cortex-A53), which runs NAT with flow offload enabled from
one ethernet port to PPPoE on another ethernet port + cake qdisc set to
1Gbps.

rx-gro-list off: 630 Mbit/s, CPU 35% idle
rx-gro-list on:  770 Mbit/s, CPU 40% idle

Signe-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/ipv4/tcp_offload.c   | 56 ++++++++++++++++++++++++++++++++++++++
 net/ipv6/tcpv6_offload.c | 59 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 115 insertions(+)

diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index 68157130c264..fc836ca084dd 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -396,6 +396,60 @@ void tcp_gro_complete(struct sk_buff *skb)
 }
 EXPORT_SYMBOL(tcp_gro_complete);
 
+static void tcp4_check_fraglist_gro(struct list_head *head, struct sk_buff *skb)
+{
+	const struct iphdr *iph = skb_gro_network_header(skb);
+	struct net *net = dev_net(skb->dev);
+	unsigned int off, hlen, thlen;
+	struct tcphdr *th, *th2;
+	struct sk_buff *p;
+	struct sock *sk;
+	int iif, sdif;
+
+	if (!(skb->dev->features & NETIF_F_GRO_FRAGLIST))
+		return;
+
+	off = skb_gro_offset(skb);
+	hlen = off + sizeof(*th);
+	th = skb_gro_header(skb, hlen, off);
+	if (unlikely(!th))
+		return;
+
+	thlen = th->doff * 4;
+	if (thlen < sizeof(*th))
+		return;
+
+	hlen = off + thlen;
+	if (!skb_gro_may_pull(skb, hlen)) {
+		th = skb_gro_header_slow(skb, hlen, off);
+		if (unlikely(!th))
+			return;
+	}
+
+	list_for_each_entry(p, head, list) {
+		if (!NAPI_GRO_CB(p)->same_flow)
+			continue;
+
+		th2 = tcp_hdr(p);
+		if (*(u32 *)&th->source ^ *(u32 *)&th2->source) {
+			NAPI_GRO_CB(p)->same_flow = 0;
+			continue;
+		}
+
+		NAPI_GRO_CB(skb)->is_flist = NAPI_GRO_CB(p)->is_flist;
+		return;
+	}
+
+	inet_get_iif_sdif(skb, &iif, &sdif);
+	sk = __inet_lookup_established(net, net->ipv4.tcp_death_row.hashinfo,
+				       iph->saddr, th->source,
+				       iph->daddr, ntohs(th->dest),
+				       iif, sdif);
+	NAPI_GRO_CB(skb)->is_flist = !sk;
+	if (sk)
+		sock_put(sk);
+}
+
 INDIRECT_CALLABLE_SCOPE
 struct sk_buff *tcp4_gro_receive(struct list_head *head, struct sk_buff *skb)
 {
@@ -407,6 +461,8 @@ struct sk_buff *tcp4_gro_receive(struct list_head *head, struct sk_buff *skb)
 		return NULL;
 	}
 
+	tcp4_check_fraglist_gro(head, skb);
+
 	return tcp_gro_receive(head, skb);
 }
 
diff --git a/net/ipv6/tcpv6_offload.c b/net/ipv6/tcpv6_offload.c
index c97d55cf036f..dffeef080889 100644
--- a/net/ipv6/tcpv6_offload.c
+++ b/net/ipv6/tcpv6_offload.c
@@ -7,12 +7,69 @@
  */
 #include <linux/indirect_call_wrapper.h>
 #include <linux/skbuff.h>
+#include <net/inet6_hashtables.h>
 #include <net/gro.h>
 #include <net/protocol.h>
 #include <net/tcp.h>
 #include <net/ip6_checksum.h>
 #include "ip6_offload.h"
 
+static void tcp6_check_fraglist_gro(struct list_head *head, struct sk_buff *skb)
+{
+#if IS_ENABLED(CONFIG_IPV6)
+	const struct ipv6hdr *hdr = skb_gro_network_header(skb);
+	struct net *net = dev_net(skb->dev);
+	unsigned int off, hlen, thlen;
+	struct tcphdr *th, *th2;
+	struct sk_buff *p;
+	struct sock *sk;
+	int iif, sdif;
+
+	if (!(skb->dev->features & NETIF_F_GRO_FRAGLIST))
+		return;
+
+	off = skb_gro_offset(skb);
+	hlen = off + sizeof(*th);
+	th = skb_gro_header(skb, hlen, off);
+	if (unlikely(!th))
+		return;
+
+	thlen = th->doff * 4;
+	if (thlen < sizeof(*th))
+		return;
+
+	hlen = off + thlen;
+	if (!skb_gro_may_pull(skb, hlen)) {
+		th = skb_gro_header_slow(skb, hlen, off);
+		if (unlikely(!th))
+			return;
+	}
+
+	list_for_each_entry(p, head, list) {
+		if (!NAPI_GRO_CB(p)->same_flow)
+			continue;
+
+		th2 = tcp_hdr(p);
+		if (*(u32 *)&th->source ^ *(u32 *)&th2->source) {
+			NAPI_GRO_CB(p)->same_flow = 0;
+			continue;
+		}
+
+		NAPI_GRO_CB(skb)->is_flist = NAPI_GRO_CB(p)->is_flist;
+		return;
+	}
+
+	inet6_get_iif_sdif(skb, &iif, &sdif);
+	sk = __inet6_lookup_established(net, net->ipv4.tcp_death_row.hashinfo,
+					&hdr->saddr, th->source,
+					&hdr->daddr, ntohs(th->dest),
+					iif, sdif);
+	NAPI_GRO_CB(skb)->is_flist = !sk;
+	if (sk)
+		sock_put(sk);
+#endif /* IS_ENABLED(CONFIG_IPV6) */
+}
+
 INDIRECT_CALLABLE_SCOPE
 struct sk_buff *tcp6_gro_receive(struct list_head *head, struct sk_buff *skb)
 {
@@ -24,6 +81,8 @@ struct sk_buff *tcp6_gro_receive(struct list_head *head, struct sk_buff *skb)
 		return NULL;
 	}
 
+	tcp6_check_fraglist_gro(head, skb);
+
 	return tcp_gro_receive(head, skb);
 }
 
-- 
2.44.0


