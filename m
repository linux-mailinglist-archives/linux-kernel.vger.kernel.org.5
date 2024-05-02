Return-Path: <linux-kernel+bounces-166133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DB18B96AB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94E6F1C21252
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE11F54646;
	Thu,  2 May 2024 08:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="ZADqazz9"
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406964655F;
	Thu,  2 May 2024 08:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714639504; cv=none; b=dk24hXMf/nOlNbGvzC7M5vkDmwnro6fCeAaxQj35RJooxWk8SUb3qHdumwdTedkn+AVx1g1lVVVn8Xbs5eD7CeX24vJXXYnmoa9H9rdN5GIV5+KT/0IwjKLpY3P8pNZK6Zc49I5A35/WPWE0tR/2K2xY3WM+IPvCzA4CkXrS12k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714639504; c=relaxed/simple;
	bh=v00X4mi1QPHASjXDB1BqcufjMuYUrjWt9eIQHw9CO04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SA2IP82fwahRn/kBKMV1Wd2HST3kcwdmpo1ZlgqTpsYU6zYk970MNMt6rwbN51wwzz23MeHDhmRQd336qAJnL/4AjK89fE2GwF4goj15bs82eVTdwNf8eUe6s7Q+AXAwTPPWiHWeGtZZBWMnISuydgWsvt4kXIBPd6Yy1ICFlQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=ZADqazz9; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=dITqPmiMLPj0X8efqXc4rgGYL4SH3v8L9fqRS39+8H0=; b=ZADqazz91RPknCSIV3yOjA7r2m
	aWTRkXD+pbpnDuInM4yPTZroyVPrFVNVEMNErDwU8VHQ2Oh/uOwU9Z+bKk1082bE0+7Vl77eLhnDd
	0rP3h09kN/0xedO3c1jWnWlwtrB2oCCh42ASID++AmS9p6E5hSTGqRtCB5JJsnKPIBkc=;
Received: from p54ae9c93.dip0.t-ipconnect.de ([84.174.156.147] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1s2S3j-00BKKn-0u;
	Thu, 02 May 2024 10:44:55 +0200
From: Felix Fietkau <nbd@nbd.name>
To: netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>
Cc: willemdebruijn.kernel@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 net-next v5 5/6] net: create tcp_gro_header_pull helper function
Date: Thu,  2 May 2024 10:44:46 +0200
Message-ID: <20240502084450.44009-6-nbd@nbd.name>
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

Pull the code out of tcp_gro_receive in order to access the tcp header
from tcp4/6_gro_receive.

Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 include/net/tcp.h        |  4 ++-
 net/ipv4/tcp_offload.c   | 55 +++++++++++++++++++++++++---------------
 net/ipv6/tcpv6_offload.c | 18 +++++++++----
 3 files changed, 50 insertions(+), 27 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 9f08ecab26e0..bf392c1fbadc 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2199,8 +2199,10 @@ void tcp_v4_destroy_sock(struct sock *sk);
 
 struct sk_buff *tcp_gso_segment(struct sk_buff *skb,
 				netdev_features_t features);
+struct tcphdr *tcp_gro_pull_header(struct sk_buff *skb);
 struct sk_buff *tcp_gro_lookup(struct list_head *head, struct tcphdr *th);
-struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb);
+struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb,
+				struct tcphdr *th);
 INDIRECT_CALLABLE_DECLARE(int tcp4_gro_complete(struct sk_buff *skb, int thoff));
 INDIRECT_CALLABLE_DECLARE(struct sk_buff *tcp4_gro_receive(struct list_head *head, struct sk_buff *skb));
 INDIRECT_CALLABLE_DECLARE(int tcp6_gro_complete(struct sk_buff *skb, int thoff));
diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index 4a194a9d36cd..87ae9808e260 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -266,40 +266,46 @@ struct sk_buff *tcp_gro_lookup(struct list_head *head, struct tcphdr *th)
 	return NULL;
 }
 
-struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb)
+struct tcphdr *tcp_gro_pull_header(struct sk_buff *skb)
 {
-	struct sk_buff *pp = NULL;
-	struct sk_buff *p;
+	unsigned int thlen, hlen, off;
 	struct tcphdr *th;
-	struct tcphdr *th2;
-	unsigned int len;
-	unsigned int thlen;
-	__be32 flags;
-	unsigned int mss = 1;
-	unsigned int hlen;
-	unsigned int off;
-	int flush = 1;
-	int i;
 
 	off = skb_gro_offset(skb);
 	hlen = off + sizeof(*th);
 	th = skb_gro_header(skb, hlen, off);
 	if (unlikely(!th))
-		goto out;
+		return NULL;
 
 	thlen = th->doff * 4;
 	if (thlen < sizeof(*th))
-		goto out;
+		return NULL;
 
 	hlen = off + thlen;
 	if (!skb_gro_may_pull(skb, hlen)) {
 		th = skb_gro_header_slow(skb, hlen, off);
 		if (unlikely(!th))
-			goto out;
+			return NULL;
 	}
 
 	skb_gro_pull(skb, thlen);
 
+	return th;
+}
+
+struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb,
+				struct tcphdr *th)
+{
+	unsigned int thlen = th->doff * 4;
+	struct sk_buff *pp = NULL;
+	struct sk_buff *p;
+	struct tcphdr *th2;
+	unsigned int len;
+	__be32 flags;
+	unsigned int mss = 1;
+	int flush = 1;
+	int i;
+
 	len = skb_gro_len(skb);
 	flags = tcp_flag_word(th);
 
@@ -376,7 +382,6 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb)
 	if (p && (!NAPI_GRO_CB(skb)->same_flow || flush))
 		pp = p;
 
-out:
 	NAPI_GRO_CB(skb)->flush |= (flush != 0);
 
 	return pp;
@@ -405,15 +410,23 @@ EXPORT_SYMBOL(tcp_gro_complete);
 INDIRECT_CALLABLE_SCOPE
 struct sk_buff *tcp4_gro_receive(struct list_head *head, struct sk_buff *skb)
 {
+	struct tcphdr *th;
+
 	/* Don't bother verifying checksum if we're going to flush anyway. */
 	if (!NAPI_GRO_CB(skb)->flush &&
 	    skb_gro_checksum_validate(skb, IPPROTO_TCP,
-				      inet_gro_compute_pseudo)) {
-		NAPI_GRO_CB(skb)->flush = 1;
-		return NULL;
-	}
+				      inet_gro_compute_pseudo))
+		goto flush;
+
+	th = tcp_gro_pull_header(skb);
+	if (!th)
+		goto flush;
 
-	return tcp_gro_receive(head, skb);
+	return tcp_gro_receive(head, skb, th);
+
+flush:
+	NAPI_GRO_CB(skb)->flush = 1;
+	return NULL;
 }
 
 INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int thoff)
diff --git a/net/ipv6/tcpv6_offload.c b/net/ipv6/tcpv6_offload.c
index 575e2743e331..e73a4f74fd96 100644
--- a/net/ipv6/tcpv6_offload.c
+++ b/net/ipv6/tcpv6_offload.c
@@ -16,15 +16,23 @@
 INDIRECT_CALLABLE_SCOPE
 struct sk_buff *tcp6_gro_receive(struct list_head *head, struct sk_buff *skb)
 {
+	struct tcphdr *th;
+
 	/* Don't bother verifying checksum if we're going to flush anyway. */
 	if (!NAPI_GRO_CB(skb)->flush &&
 	    skb_gro_checksum_validate(skb, IPPROTO_TCP,
-				      ip6_gro_compute_pseudo)) {
-		NAPI_GRO_CB(skb)->flush = 1;
-		return NULL;
-	}
+				      ip6_gro_compute_pseudo))
+		goto flush;
+
+	th = tcp_gro_pull_header(skb);
+	if (!th)
+		goto flush;
+
+	return tcp_gro_receive(head, skb, th);
 
-	return tcp_gro_receive(head, skb);
+flush:
+	NAPI_GRO_CB(skb)->flush = 1;
+	return NULL;
 }
 
 INDIRECT_CALLABLE_SCOPE int tcp6_gro_complete(struct sk_buff *skb, int thoff)
-- 
2.44.0


