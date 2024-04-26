Return-Path: <linux-kernel+bounces-159594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E988B30C1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 08:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 003ED1F24149
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 06:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B558913AD12;
	Fri, 26 Apr 2024 06:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="q7Fc99Mp"
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD8A13AA2B;
	Fri, 26 Apr 2024 06:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714114315; cv=none; b=NnWhySunLUC9g3EKdSunHeuWdZoDk5afpPzJw2iLeb/DhaiNBHwgXCYh4rClmXCfDT5rYHXYyu8sTq0iiF3bOrIieFITlEzt89AxxtugfEa8hOMUAYtWTE8ZGvapSUU/aBAcfxR7XMkIfTvnf5e08c/YksUGjaz96GRj6r3wjhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714114315; c=relaxed/simple;
	bh=gC+fCg5cz12fZc/PuhyH/jEzDll18Gv/XQabXEaQBoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=atgTjMxYe0fZ8oEXNtfcMVaDQqLBmPFyFQ9M8ubtxkW5YfGnsC49iIpLQjqdrViQwKG0kOPFs9bLPu5a81XaYcqbpGGdAf4sx7ukGEBV121bzQnYJdtcrIjvqKvg7rC08jcpRoQxApOmCgBY7BMcWHS0Xj9cAcKCrEFFO+Ugcps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=q7Fc99Mp; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=0KhOWxd59asjecYDzN7/r5pbN5b2cJi5bmFWlIpb04M=; b=q7Fc99MpiF1Eqzcxlv+7LPwVr4
	1mlW+CtuXagRp/h01wEtsYcYu3REBcYw4ctAADBf6QpWaK0tF+krFiCaNjCBvB1a3lj28VU7WGR6T
	R9Pmd53J5crqcLTz8RDSzv36Q4xylHvnOQoXMxN6aoXiEI6/4r4fjq7ih3dtoaX7h+2g=;
Received: from p54ae9c93.dip0.t-ipconnect.de ([84.174.156.147] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1s0FQw-007ltt-2w;
	Fri, 26 Apr 2024 08:51:46 +0200
From: Felix Fietkau <nbd@nbd.name>
To: netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: willemdebruijn.kernel@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 net-next v3 3/6] net: add code for TCP fraglist GRO
Date: Fri, 26 Apr 2024 08:51:37 +0200
Message-ID: <20240426065143.4667-4-nbd@nbd.name>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240426065143.4667-1-nbd@nbd.name>
References: <20240426065143.4667-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This implements fraglist GRO similar to how it's handled in UDP, however
no functional changes are added yet. The next change adds a heuristic for
using fraglist GRO instead of regular GRO.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/ipv4/tcp_offload.c   | 22 ++++++++++++++++++++++
 net/ipv6/tcpv6_offload.c |  9 +++++++++
 2 files changed, 31 insertions(+)

diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index c493e95e09a5..ffd6b7a4163a 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -332,6 +332,19 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb)
 	flush |= (ntohl(th2->seq) + skb_gro_len(p)) ^ ntohl(th->seq);
 	flush |= skb_cmp_decrypted(p, skb);
 
+	if (NAPI_GRO_CB(p)->is_flist) {
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
@@ -398,6 +411,15 @@ INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int thoff)
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
 
diff --git a/net/ipv6/tcpv6_offload.c b/net/ipv6/tcpv6_offload.c
index b3b8e1f6b92a..c97d55cf036f 100644
--- a/net/ipv6/tcpv6_offload.c
+++ b/net/ipv6/tcpv6_offload.c
@@ -32,6 +32,15 @@ INDIRECT_CALLABLE_SCOPE int tcp6_gro_complete(struct sk_buff *skb, int thoff)
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
-- 
2.44.0


