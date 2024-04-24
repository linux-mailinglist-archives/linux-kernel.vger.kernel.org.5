Return-Path: <linux-kernel+bounces-157437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 208898B11AB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C3BC1F27BFC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855F816DECF;
	Wed, 24 Apr 2024 18:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="knt0vgFr"
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533B216D4E5;
	Wed, 24 Apr 2024 18:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713981909; cv=none; b=Wqi+hWvB8FAKgWi8xBqs2p1o4MepKTIIwMJ3oxLYxQ91ff+SQlTsspbYKhXN/KmhhSH1s0c3hCIZ6icNQf8ae2ulIoNyv1W3jOf8FzNe5t9QDF2R1X+Gc3C/f8tarC5nF8sQtJilm0cB1i5zJWNCu9p44Q033cV1Tk+mAR1fOhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713981909; c=relaxed/simple;
	bh=7cYcqFWyS5ILf8FSC42LtAhAyiCrjlIaapO4c6lZXBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EgkgCNBReznkgdLkpS6xi9GdTc1RiRk9MDzSapKaXf0wCs68vHAm9D0xcXAXeYq7Iy9QeQQazoGinZb/9yG2S18uAUSmpyT9qNorAv6ibZFOZaN1vvra+pS8FL1b4M1Hd2kl+54gXO+jzUY04l8z4MAMwhPQUAS1EKX3hnhK2z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=knt0vgFr; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=EI1eLVntxcTn53NTpTv6PcIFtjylSdx6l7qTZk+FoL4=; b=knt0vgFr4/irmYJquuO7mvbZFs
	Ah1taKuRKDqS0CTaMNoDmf1QWlJYfo64r8HqF/a/rJVJg5TZRTqAV9vJEQjVNoK0MX5exu/UWdPOp
	vf0wsikEF4tRECCtYcYnP/VSSaiGmrqJAJRCSFQoYEReDLLzGYsfQS1sTR1CfU2Jml5g=;
Received: from p200300daa70d8400593e4be1bb3506c9.dip0.t-ipconnect.de ([2003:da:a70d:8400:593e:4be1:bb35:6c9] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1rzgzN-006rUX-04;
	Wed, 24 Apr 2024 20:05:01 +0200
From: Felix Fietkau <nbd@nbd.name>
To: netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: willemdebruijn.kernel@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/4] net: add support for segmenting TCP fraglist GSO packets
Date: Wed, 24 Apr 2024 20:04:54 +0200
Message-ID: <20240424180458.56211-3-nbd@nbd.name>
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

Preparation for adding TCP fraglist GRO support. It expects packets to be
combined in a similar way as UDP fraglist GSO packets.
One difference is the fact that this code assumes that the TCP flags of
all packets have the same value. This allows simple handling of flags
mutations. For IPv4 packets, NAT is handled in the same way as UDP
fraglist GSO.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/ipv4/tcp_offload.c   | 74 ++++++++++++++++++++++++++++++++++++++++
 net/ipv6/tcpv6_offload.c | 37 ++++++++++++++++++++
 2 files changed, 111 insertions(+)

diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index fab0973f995b..06dbb2e2b2f3 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -28,6 +28,77 @@ static void tcp_gso_tstamp(struct sk_buff *skb, unsigned int ts_seq,
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
+		if (flags == flags2)
+			continue;
+
+		inet_proto_csum_replace4(&th2->check, seg, flags2, flags, false);
+		tcp_flag_word(th2) = flags;
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
@@ -37,6 +108,9 @@ static struct sk_buff *tcp4_gso_segment(struct sk_buff *skb,
 	if (!pskb_may_pull(skb, sizeof(struct tcphdr)))
 		return ERR_PTR(-EINVAL);
 
+	if (skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST)
+		return __tcp_gso_segment_list(skb, features);
+
 	if (unlikely(skb->ip_summed != CHECKSUM_PARTIAL)) {
 		const struct iphdr *iph = ip_hdr(skb);
 		struct tcphdr *th = tcp_hdr(skb);
diff --git a/net/ipv6/tcpv6_offload.c b/net/ipv6/tcpv6_offload.c
index 4b07d1e6c952..12fe79cb2c10 100644
--- a/net/ipv6/tcpv6_offload.c
+++ b/net/ipv6/tcpv6_offload.c
@@ -40,6 +40,40 @@ INDIRECT_CALLABLE_SCOPE int tcp6_gro_complete(struct sk_buff *skb, int thoff)
 	return 0;
 }
 
+static struct sk_buff *__tcpv6_gso_segment_list_csum(struct sk_buff *segs)
+{
+	struct tcphdr *th, *th2;
+	__be32 flags, flags2;
+	struct sk_buff *seg;
+
+	seg = segs;
+	th = tcp_hdr(seg);
+	flags = tcp_flag_word(th);
+	flags2 = tcp_flag_word(tcp_hdr(seg->next));
+
+	if (flags == flags2)
+		return segs;
+
+	while ((seg = seg->next)) {
+		th2 = tcp_hdr(seg);
+
+		inet_proto_csum_replace4(&th2->check, seg, flags2, flags, false);
+		tcp_flag_word(th2) = flags;
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
+	return __tcpv6_gso_segment_list_csum(skb);
+}
+
 static struct sk_buff *tcp6_gso_segment(struct sk_buff *skb,
 					netdev_features_t features)
 {
@@ -51,6 +85,9 @@ static struct sk_buff *tcp6_gso_segment(struct sk_buff *skb,
 	if (!pskb_may_pull(skb, sizeof(*th)))
 		return ERR_PTR(-EINVAL);
 
+	if (skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST)
+		return __tcp_gso_segment_list(skb, features);
+
 	if (unlikely(skb->ip_summed != CHECKSUM_PARTIAL)) {
 		const struct ipv6hdr *ipv6h = ipv6_hdr(skb);
 		struct tcphdr *th = tcp_hdr(skb);
-- 
2.44.0


