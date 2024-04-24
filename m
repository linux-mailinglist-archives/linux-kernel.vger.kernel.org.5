Return-Path: <linux-kernel+bounces-157439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3688B11AE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 916AD1C24741
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8212816E89C;
	Wed, 24 Apr 2024 18:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="k/ZjWole"
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4401316D9D9;
	Wed, 24 Apr 2024 18:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713981910; cv=none; b=iYJYnlpBb2RzXIlDonR0kj0t+iIN/aD3m9VaDJJIoII7dNhBSloh/ZOL7cosnzAbdxLnr7QgKKiFBtgtoXt7sz/lkY2k/LpV5y++MpjHgs+0flYuqPQz8Zvqq89MvGjfKwb1DY29yBhdVeLEE8R5kcx8dSfmY3XaVzeLO9/9kCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713981910; c=relaxed/simple;
	bh=koRc4LMtG9MduWD+18W71wTDcAdZFuQSmz/k0s0PY7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p/acoDZf0YUItHA9RDk4vKDpNAqqCu9xq86ALAFPnOMllidFoQnfkoVO7rAq5zNvEgL13e4E03gRHaArMGW6Xifvl2CwaKEmJjoa7xgdL7i8wdsIY3WZQnUqhjn+CSk/A20KPf/kubFCaJ5OXTln1xueK4beaC0hKl+E1hbL8gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=k/ZjWole; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=pea9y4EsSmtuSay+TRktXrd0LL/ZcJS+6ZAWLAVY6k4=; b=k/ZjWolehXdgCwLDZXcctnK8JK
	ZRjBTCHXfWZFiUtco9JgLg0mTR6/iwEQ/JyR6dz5tudk0pXB1QJFrQi5x2FIV/yaurzJns+IJcC0t
	I93jhizNI6uqeEtiu2el8PI/TN+bua+RhuG80Xqng+IOnqrjEplwzGlzwrS59uxT8zfU=;
Received: from p200300daa70d8400593e4be1bb3506c9.dip0.t-ipconnect.de ([2003:da:a70d:8400:593e:4be1:bb35:6c9] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1rzgzP-006rUX-1U;
	Wed, 24 Apr 2024 20:05:03 +0200
From: Felix Fietkau <nbd@nbd.name>
To: netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: willemdebruijn.kernel@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 4/4] net: add heuristic for enabling TCP fraglist GRO
Date: Wed, 24 Apr 2024 20:04:56 +0200
Message-ID: <20240424180458.56211-5-nbd@nbd.name>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240424180458.56211-1-nbd@nbd.name>
References: <20240424180458.56211-1-nbd@nbd.name>
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
 net/ipv4/tcp_offload.c   | 45 ++++++++++++++++++++++++++++++++++++++-
 net/ipv6/tcpv6_offload.c | 46 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 89 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index 6294e7a5c099..f987e2d8423a 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -404,6 +404,49 @@ void tcp_gro_complete(struct sk_buff *skb)
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
@@ -415,7 +458,7 @@ struct sk_buff *tcp4_gro_receive(struct list_head *head, struct sk_buff *skb)
 		return NULL;
 	}
 
-	return tcp_gro_receive(head, skb, false);
+	return tcp_gro_receive(head, skb, tcp4_check_fraglist_gro(skb));
 }
 
 INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int thoff)
diff --git a/net/ipv6/tcpv6_offload.c b/net/ipv6/tcpv6_offload.c
index 239588557dc4..c214f5cfe595 100644
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
 
-	return tcp_gro_receive(head, skb, false);
+	return tcp_gro_receive(head, skb, tcp6_check_fraglist_gro(skb));
 }
 
 INDIRECT_CALLABLE_SCOPE int tcp6_gro_complete(struct sk_buff *skb, int thoff)
-- 
2.44.0


