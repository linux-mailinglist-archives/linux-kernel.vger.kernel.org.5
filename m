Return-Path: <linux-kernel+bounces-158760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 557818B2496
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72B6BB28CCC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D492914BF9B;
	Thu, 25 Apr 2024 15:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="SEuX8jlN"
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B191D12AAC6;
	Thu, 25 Apr 2024 15:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714057486; cv=none; b=rfH5DaHz05ypdZcp8RHjXgyXeBze2yBHkSS1uRQ1+Y1zgsez3DxrHcif28bjLZYqnWrUJ2y5imnatwMR/P8stKW2hwXh0FTSmsh0XN2Z8bTCl2Es9F4z28tqtN8Rb9uEaxX6hpQhMmm0N/0f05losjOk3iLdO9OUgnkznrabA7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714057486; c=relaxed/simple;
	bh=8NeEE50o/WAF7alz523Mftf7uWVPcr6hQyPB9rlVopU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c0x2Sr9g5+bnmv9S2IECV1XyOBDMqR6Ds5QjrY9FUUZbm9BlS5WEtHFGYVdE9ozt6nFxKyN+VL7JIo6qEoEUPIFsqbRsV4pYEtR7b7N/ktC4YNPeIZmiGpVC8W5nao3x46pa1IQtNotpQDiraNNi1UHdvzayiP9j0gvLDhGr+0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=SEuX8jlN; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=tDIhibAnoiRO2OlDgF5FLoNbCcri4UG1OGQ0HjCzYwU=; b=SEuX8jlNPizloEeHmgbL72blD/
	KXHENMhshaTigm/P3jaU3S48aytd4QCqnG2q+RdKy/ycPQfPTL22qQOTtJHp0xiiSkhbfoFeC/ryA
	9fJQ3R8TLPX9LELIn/Kf2iG4wCQ7AA8Skx54vRikvV9GwKNWlZm9Ph+l2Bd+HH5JovDM=;
Received: from p54ae9c93.dip0.t-ipconnect.de ([84.174.156.147] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1s00eJ-007MWz-2k;
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
Subject: [PATCH v2 net-next v2 3/5] net: add code for TCP fraglist GRO
Date: Thu, 25 Apr 2024 17:04:26 +0200
Message-ID: <20240425150432.44142-4-nbd@nbd.name>
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

This implements fraglist GRO similar to how it's handled in UDP, however
no functional changes are added yet. The next change adds a heuristic for
using fraglist GRO instead of regular GRO.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/ipv4/tcp_offload.c   | 22 ++++++++++++++++++++++
 net/ipv6/tcpv6_offload.c |  9 +++++++++
 2 files changed, 31 insertions(+)

diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index e455f884190c..68157130c264 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -336,6 +336,19 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb)
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
@@ -402,6 +415,15 @@ INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int thoff)
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


