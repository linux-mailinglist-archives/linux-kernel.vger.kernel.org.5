Return-Path: <linux-kernel+bounces-166134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 903328B96AA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C140F1C21C53
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC1754279;
	Thu,  2 May 2024 08:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="sb9+NG8k"
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C53646B83;
	Thu,  2 May 2024 08:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714639504; cv=none; b=qwRpBIg4fyBhmis9xSCvcXdeQbgEyBoa/a8Gz7hgL9WFZumTaTLK8kRXbLNBeoXbZKZWSZm8FM7u6W/6mBVRgIUO3rT3NrqMJaMUwzitPgfTnCiLMtXK8V2rXoINJQdF+uNETTBt8vrYSP1JgbkdKyjTL1wbG4cteKCmAlWePtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714639504; c=relaxed/simple;
	bh=5EX44/CTYL2OsIgll7KF256jTOnGWBaAbNv1JhU4GIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=muGB/tcUH4CgaVHBaVpl9gSJbxXTWA2awhJFx2WhFXODEYQGPmNQF0gGirRdFJrukVLoWDH7iGVlYfLvXcFgwB7UZZAQoeWikD25CZgc4FHPxj5cfBb3ORVENos3RgchCWNcqKvMKqFI20yGWjKctzaYbPOT6juIL3yroyIFAE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=sb9+NG8k; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=wQkdKbexqFJvvMsjapxWvuM2aI3ZZOB65mkuF3E4zl0=; b=sb9+NG8kf2DRSCg8QlJObQq2oj
	tKTYdw717GAd/wWsRTHDfr4pYeBqHfmEva/YlNZ/AfxeH8sujWKPhqyUKX9uupVIlKibp1fAzvOpd
	ikdoBVlzylSPr2dRKGHjh9nOm91TXoDFN67Hje99ng/KrjHRG39/wOjmRmHuzZ1cJg8k=;
Received: from p54ae9c93.dip0.t-ipconnect.de ([84.174.156.147] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1s2S3k-00BKKn-0O;
	Thu, 02 May 2024 10:44:56 +0200
From: Felix Fietkau <nbd@nbd.name>
To: netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: willemdebruijn.kernel@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 net-next v5 6/6] net: add heuristic for enabling TCP fraglist GRO
Date: Thu,  2 May 2024 10:44:47 +0200
Message-ID: <20240502084450.44009-7-nbd@nbd.name>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240502084450.44009-1-nbd@nbd.name>
References: <20240502084450.44009-1-nbd@nbd.name>
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

Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/ipv4/tcp_offload.c   | 32 ++++++++++++++++++++++++++++++++
 net/ipv6/tcpv6_offload.c | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index 87ae9808e260..c90704befd7b 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -407,6 +407,36 @@ void tcp_gro_complete(struct sk_buff *skb)
 }
 EXPORT_SYMBOL(tcp_gro_complete);
 
+static void tcp4_check_fraglist_gro(struct list_head *head, struct sk_buff *skb,
+				    struct tcphdr *th)
+{
+	const struct iphdr *iph;
+	struct sk_buff *p;
+	struct sock *sk;
+	struct net *net;
+	int iif, sdif;
+
+	if (likely(!(skb->dev->features & NETIF_F_GRO_FRAGLIST)))
+		return;
+
+	p = tcp_gro_lookup(head, th);
+	if (p) {
+		NAPI_GRO_CB(skb)->is_flist = NAPI_GRO_CB(p)->is_flist;
+		return;
+	}
+
+	inet_get_iif_sdif(skb, &iif, &sdif);
+	iph = skb_gro_network_header(skb);
+	net = dev_net(skb->dev);
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
@@ -422,6 +452,8 @@ struct sk_buff *tcp4_gro_receive(struct list_head *head, struct sk_buff *skb)
 	if (!th)
 		goto flush;
 
+	tcp4_check_fraglist_gro(head, skb, th);
+
 	return tcp_gro_receive(head, skb, th);
 
 flush:
diff --git a/net/ipv6/tcpv6_offload.c b/net/ipv6/tcpv6_offload.c
index e73a4f74fd96..d59f58cbd306 100644
--- a/net/ipv6/tcpv6_offload.c
+++ b/net/ipv6/tcpv6_offload.c
@@ -7,12 +7,45 @@
  */
 #include <linux/indirect_call_wrapper.h>
 #include <linux/skbuff.h>
+#include <net/inet6_hashtables.h>
 #include <net/gro.h>
 #include <net/protocol.h>
 #include <net/tcp.h>
 #include <net/ip6_checksum.h>
 #include "ip6_offload.h"
 
+static void tcp6_check_fraglist_gro(struct list_head *head, struct sk_buff *skb,
+				    struct tcphdr *th)
+{
+#if IS_ENABLED(CONFIG_IPV6)
+	const struct ipv6hdr *hdr;
+	struct sk_buff *p;
+	struct sock *sk;
+	struct net *net;
+	int iif, sdif;
+
+	if (likely(!(skb->dev->features & NETIF_F_GRO_FRAGLIST)))
+		return;
+
+	p = tcp_gro_lookup(head, th);
+	if (p) {
+		NAPI_GRO_CB(skb)->is_flist = NAPI_GRO_CB(p)->is_flist;
+		return;
+	}
+
+	inet6_get_iif_sdif(skb, &iif, &sdif);
+	hdr = skb_gro_network_header(skb);
+	net = dev_net(skb->dev);
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
@@ -28,6 +61,8 @@ struct sk_buff *tcp6_gro_receive(struct list_head *head, struct sk_buff *skb)
 	if (!th)
 		goto flush;
 
+	tcp6_check_fraglist_gro(head, skb, th);
+
 	return tcp_gro_receive(head, skb, th);
 
 flush:
-- 
2.44.0


