Return-Path: <linux-kernel+bounces-166131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA75B8B96A5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CD4F2850CD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83F247A57;
	Thu,  2 May 2024 08:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="oGb4qsUl"
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9135D46525;
	Thu,  2 May 2024 08:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714639503; cv=none; b=LKyatSNkCW4HeV6/BOmQTumjT2Aot7jfYoBa9IRsGzEWqkoTchK1P8Q9dxn7fHyH3uj8nzoGjYoSdMtkwl6TlPQYikI0R6z97frk4ezjggh3vXVC3tw8+gm8eU0QblQ630HH4Ycg+HJsnXhHy1QK+lwWIUUXE6KosoyHs011ib4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714639503; c=relaxed/simple;
	bh=Z2IXMCDg2WGF6g/b+b8hoQ/vakbIALNU7+GZl0p6OqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b92tElOLnAEP0Wr3UM0vn5ycSSxWJv8r2bICHslfixJfVfWBjAX6jIb+5YvzaSLFPWTwWnwA2JfmA33KqgMPVQlLf5PRqm0rtJZsodg0nSYEltlMF+Qf/np7efAqvR34ZyujbFeT0M4ZaZNiFaH4ui1+iumEOkrO02+kHFCJti0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=oGb4qsUl; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ucBFctV4yvQkEZT4G46tkfmHw4p+c5I3e3Kf1G9tARg=; b=oGb4qsUldRMkxkeOpYhRQ6C5B4
	/oXOzNFAhDuaYJfHvQWBPmhnqwXDKQFr5GBzMF8TyKzWJpU4jaaJsLqJzXo+CcUuzGwLhB6t+85tf
	QREfRy3xjishW3+bzahQ29BuCJKz4tFGpNeLDfSsA8UBXdKh02kXyA1UjSr9iCMaJyUA=;
Received: from p54ae9c93.dip0.t-ipconnect.de ([84.174.156.147] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1s2S3g-00BKKn-0h;
	Thu, 02 May 2024 10:44:52 +0200
From: Felix Fietkau <nbd@nbd.name>
To: netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>
Cc: willemdebruijn.kernel@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 net-next v5 1/6] net: move skb_gro_receive_list from udp to core
Date: Thu,  2 May 2024 10:44:42 +0200
Message-ID: <20240502084450.44009-2-nbd@nbd.name>
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

This helper function will be used for TCP fraglist GRO support

Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 include/net/gro.h      |  1 +
 net/core/gro.c         | 27 +++++++++++++++++++++++++++
 net/ipv4/udp_offload.c | 27 ---------------------------
 3 files changed, 28 insertions(+), 27 deletions(-)

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
-- 
2.44.0


