Return-Path: <linux-kernel+bounces-161119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 296758B4760
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 20:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0AFCB219E6
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 18:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED205145B05;
	Sat, 27 Apr 2024 18:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="WW8EEfZS"
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEDA1772F;
	Sat, 27 Apr 2024 18:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714242197; cv=none; b=ps2VBClmiZj9BScZhzI1ig9vLFS/nhFE3mAmll5CCyWK4mYHzUYP6H4k9N+bIE2DOspX5+zL6Ony41EqhJJ6sqm3giecBV8pZi27b7o4KzJahej0ChmEZtQZrUyUbJ1+IfbFCwzC4fAiGhDM5DdH40hdcPJTq7PSBlDtEDdnrKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714242197; c=relaxed/simple;
	bh=YmEyf6SItFd5CxZHd4mM08KlmULEDODxPglVfQj0qOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F2InsdzOFwynvovgIxvE3ropwfWxXswqQkZV6jM4GVu2sWzt0u03gQYSzFuIqxc0bom4gsRf8Bh6qmSjg7jyrDbbYuphWvAZf9InJtjt3yR2s3sGV4ns/I+cbSpYzrw54shPLJqGGisDnefIVcSjmr4jQhX/00+DJTJAAOlXzEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=WW8EEfZS; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Cq8n8jrG14bmuzs7U9Y1DCj9OT+YXwhjK7j49hc1cBM=; b=WW8EEfZSpI8MhLpcAVmByhNtbP
	2QUdLf7si37LXRwNGKqyjbbQYVFmwx2PBMsfe31ZELt46A75VS31C1hHJbvkUWh1am2Epe2o2KPGi
	npvKlDARWfk/klqh0gQQHff11nwLbyfT2fehrcKzTpuznqRVu+U7+YwEIfCPOnWBehEc=;
Received: from p54ae9c93.dip0.t-ipconnect.de ([84.174.156.147] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1s0mhX-008hH3-0g;
	Sat, 27 Apr 2024 20:23:07 +0200
From: Felix Fietkau <nbd@nbd.name>
To: netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>
Cc: willemdebruijn.kernel@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 net-next v4 1/6] net: move skb_gro_receive_list from udp to core
Date: Sat, 27 Apr 2024 20:22:57 +0200
Message-ID: <20240427182305.24461-2-nbd@nbd.name>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240427182305.24461-1-nbd@nbd.name>
References: <20240427182305.24461-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This helper function will be used for TCP fraglist GRO support

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


