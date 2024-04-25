Return-Path: <linux-kernel+bounces-158761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CD28B2498
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7387F1C20D05
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743F014C587;
	Thu, 25 Apr 2024 15:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="hD/VSJRx"
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30C314A622;
	Thu, 25 Apr 2024 15:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714057487; cv=none; b=XvoWXxTzEjOWs87GjZa362eV5JSWDiBBp9junGmkOw35aj0Sw8iyXit0TdNiE0K/JWkH3tQ2MllygrE5CTKqvsmRJEJYi8gSID7F7Dpvczh+X/1qTtKHVhIpxsZnLsW3PQwYTOfHAIZOVnyqACe9O/GfGDOvvwn2TkgY/GLpOWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714057487; c=relaxed/simple;
	bh=xkbQXKmazw6w+kcLk9VywCo7DsNUfS8mDLITIh/5LOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gqf8onIMNIrW0FrXusWSQZIc6WPK8QPNLerlN+EHAQte33OqQ7NFw2i9PC1CiRZyHgFgSKA9Q234v2t7wfof4qBrKIIQ0pcZiomaTmKmQkCylkgqCttMkmMbPdfucWz1o7hv1Uo/P0EyGiZkRAXP6PDSbr72W5B+sJaL10skFpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=hD/VSJRx; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=OCIv8NKbFSIrG2P/zL2p2VLnmoGImlU9tFnH2NRB5co=; b=hD/VSJRxFi2x3P2U7Hb1223zqU
	JnPovQAdw3HKPO9fTbcwZ0nk1aDrSZuNmr9mKQmOi+BXllFAJt1K/XOxI+Zyh6gFcVjgGqi5SnkH+
	EWW/DgeQp1jB4PCOuRTnAApKzygRdd28FLTTSRFAC8Lp6ifi4prz7VoRRBY1bDxMMR5M=;
Received: from p54ae9c93.dip0.t-ipconnect.de ([84.174.156.147] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1s00eJ-007MWz-0K;
	Thu, 25 Apr 2024 17:04:35 +0200
From: Felix Fietkau <nbd@nbd.name>
To: netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: willemdebruijn.kernel@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 net-next v2 2/5] net: add support for segmenting TCP fraglist GSO packets
Date: Thu, 25 Apr 2024 17:04:25 +0200
Message-ID: <20240425150432.44142-3-nbd@nbd.name>
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

Preparation for adding TCP fraglist GRO support. It expects packets to be
combined in a similar way as UDP fraglist GSO packets.
For IPv4 packets, NAT is handled in the same way as UDP fraglist GSO.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/ipv4/tcp_offload.c   | 69 ++++++++++++++++++++++++++++++++++++++++
 net/ipv6/tcpv6_offload.c |  3 ++
 2 files changed, 72 insertions(+)

diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index fab0973f995b..e455f884190c 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -28,6 +28,72 @@ static void tcp_gso_tstamp(struct sk_buff *skb, unsigned int ts_seq,
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
+	inet_proto_csum_replace4(&th->check, seg, *oldip, *newip, true);
+	inet_proto_csum_replace2(&th->check, seg, *oldport, *newport, false);
+	*oldport = *newport;
+
+	csum_replace4(&iph->check, *oldip, *newip);
+	*oldip = *newip;
+}
+
+static struct sk_buff *__tcpv4_gso_segment_list_csum(struct sk_buff *segs)
+{
+	struct sk_buff *seg;
+	struct tcphdr *th, *th2;
+	struct iphdr *iph, *iph2;
+	__be32 flags, flags2;
+
+	seg = segs;
+	th = tcp_hdr(seg);
+	iph = ip_hdr(seg);
+	flags = tcp_flag_word(th);
+	flags2 = tcp_flag_word(tcp_hdr(seg->next));
+
+	if ((tcp_hdr(seg)->dest == tcp_hdr(seg->next)->dest) &&
+	    (tcp_hdr(seg)->source == tcp_hdr(seg->next)->source) &&
+	    (ip_hdr(seg)->daddr == ip_hdr(seg->next)->daddr) &&
+	    (ip_hdr(seg)->saddr == ip_hdr(seg->next)->saddr) &&
+	    (flags == flags2))
+		return segs;
+
+	while ((seg = seg->next)) {
+		th2 = tcp_hdr(seg);
+		iph2 = ip_hdr(seg);
+
+		__tcpv4_gso_segment_csum(seg,
+					 &iph2->saddr, &iph->saddr,
+					 &th2->source, &th->source);
+		__tcpv4_gso_segment_csum(seg,
+					 &iph2->daddr, &iph->daddr,
+					 &th2->dest, &th->dest);
+	}
+
+	return segs;
+}
+
+static struct sk_buff *__tcp4_gso_segment_list(struct sk_buff *skb,
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
@@ -37,6 +103,9 @@ static struct sk_buff *tcp4_gso_segment(struct sk_buff *skb,
 	if (!pskb_may_pull(skb, sizeof(struct tcphdr)))
 		return ERR_PTR(-EINVAL);
 
+	if (skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST)
+		return __tcp4_gso_segment_list(skb, features);
+
 	if (unlikely(skb->ip_summed != CHECKSUM_PARTIAL)) {
 		const struct iphdr *iph = ip_hdr(skb);
 		struct tcphdr *th = tcp_hdr(skb);
diff --git a/net/ipv6/tcpv6_offload.c b/net/ipv6/tcpv6_offload.c
index 4b07d1e6c952..b3b8e1f6b92a 100644
--- a/net/ipv6/tcpv6_offload.c
+++ b/net/ipv6/tcpv6_offload.c
@@ -51,6 +51,9 @@ static struct sk_buff *tcp6_gso_segment(struct sk_buff *skb,
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


