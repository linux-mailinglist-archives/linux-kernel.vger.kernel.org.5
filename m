Return-Path: <linux-kernel+bounces-166132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC11B8B96A9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48A402851B2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8AD535B5;
	Thu,  2 May 2024 08:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="o4HlmzTJ"
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED33C46544;
	Thu,  2 May 2024 08:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714639503; cv=none; b=lYWmYmTxDnZdbZzROMEwypbkTyWYKy1ETe6L/gy4h47NdB9qkRz1aTPWYUDpX32pwDMe+8rGOkJZU6e168P8dCpbzwBbBqdK3iroFUhM75wqBtidmTtijG3C+Sj6bl52lVp/tXbUe5b2GHBhAO/kjHllAQfueYgMklPlknE3vnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714639503; c=relaxed/simple;
	bh=Ec3n3R3FZcZFT49rhjxqF95C5KQCNufioCSig6jhwoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wfe+bVR39jbqM6s/vexB5RkU9El5WtrvGMfSBea0/XPis1M1PpqKFGMsWOUsyU2HGltKy58mGmA6LSPUGEsb7NKeytYAUAktdoJXYu1JmeVLh4s2Omjt5ciqiRzk2GKlqAFsx06FtSqznDHrTQLkiToTIyZNtISw9uyQj95fZJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=o4HlmzTJ; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=fg/6cT3jAJK1vqwjodbXWEwb5gy6rm9+zRAdButCrKg=; b=o4HlmzTJ7Q/tPSMtP1IZc+P9Wp
	tWoLOdjU6+tx0eawKLIzhWXfCT+xPK4eo+JFrjxMfDM8Jq+Kcq9rfEb6qV87mi7U9ULgjxfHPOTKx
	3sf2gcyDimTjProB5VUcAj44l2/Le1bLO4e5Knc8XEre153ES9O/HdeFuQ+7xE7hXpmw=;
Received: from p54ae9c93.dip0.t-ipconnect.de ([84.174.156.147] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1s2S3h-00BKKn-2I;
	Thu, 02 May 2024 10:44:53 +0200
From: Felix Fietkau <nbd@nbd.name>
To: netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: willemdebruijn.kernel@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 net-next v5 3/6] net: add code for TCP fraglist GRO
Date: Thu,  2 May 2024 10:44:44 +0200
Message-ID: <20240502084450.44009-4-nbd@nbd.name>
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

This implements fraglist GRO similar to how it's handled in UDP, however
no functional changes are added yet. The next change adds a heuristic for
using fraglist GRO instead of regular GRO.

Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/ipv4/tcp_offload.c   | 21 +++++++++++++++++++++
 net/ipv6/tcpv6_offload.c |  9 +++++++++
 2 files changed, 30 insertions(+)

diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index affd4ed28cfe..aa7508676315 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -334,6 +334,18 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb)
 	flush |= (ntohl(th2->seq) + skb_gro_len(p)) ^ ntohl(th->seq);
 	flush |= skb_cmp_decrypted(p, skb);
 
+	if (unlikely(NAPI_GRO_CB(p)->is_flist)) {
+		flush |= (__force int)(flags ^ tcp_flag_word(th2));
+		flush |= skb->ip_summed != p->ip_summed;
+		flush |= skb->csum_level != p->csum_level;
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
@@ -400,6 +412,15 @@ INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int thoff)
 	const struct iphdr *iph = ip_hdr(skb);
 	struct tcphdr *th = tcp_hdr(skb);
 
+	if (unlikely(NAPI_GRO_CB(skb)->is_flist)) {
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
index 7180c30dbbef..575e2743e331 100644
--- a/net/ipv6/tcpv6_offload.c
+++ b/net/ipv6/tcpv6_offload.c
@@ -32,6 +32,15 @@ INDIRECT_CALLABLE_SCOPE int tcp6_gro_complete(struct sk_buff *skb, int thoff)
 	const struct ipv6hdr *iph = ipv6_hdr(skb);
 	struct tcphdr *th = tcp_hdr(skb);
 
+	if (unlikely(NAPI_GRO_CB(skb)->is_flist)) {
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


