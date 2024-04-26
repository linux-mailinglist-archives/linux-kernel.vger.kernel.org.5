Return-Path: <linux-kernel+bounces-159597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 121928B30C7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 08:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 449F21C20CB6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 06:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BA413BC28;
	Fri, 26 Apr 2024 06:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="JSGPig9Z"
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAAA13AA3E;
	Fri, 26 Apr 2024 06:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714114316; cv=none; b=pBRKh+V7PD6L5Asi0Jo3UZIVfxjJucCKXsgjpm8G6s0qu+zcqdoRSeYiNthfbKBKBCMNF7mI7z5YyjYs6Ufx3JeoXqCqhirLH81pRo7wD/fMQmF5rDNHh9YEjvf5Ztq5SSn4ZYVaS0akU5iG6Z5aIiFcSzOEDy9fgmLCTge6VL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714114316; c=relaxed/simple;
	bh=VuEbKNV4XwlPXs+jXQPrrZF3c45OJOnoayT18xqgRjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MhcvpEVI0WGWc78RWNvJ25he/E3DLH6Ml17dv20YZczNJZ1O/s0OqjZdx32zlRfYAsVdTFV7woT+NN28Jp78LeWfFCGIPvp0Ipy6h74hxPqulquFxk6zBtzsAwZPj7/u9WPRz5ZLFqAsd/gMVMlAQyKtPSfVKrxW7P8Q2tGrLS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=JSGPig9Z; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=kuFarNp67I2ntE4ihdHxeLO9vh/dXbyzjFjq3+OVjSY=; b=JSGPig9Za8M2F+Ki534JH/2Xjb
	qywuUMMyy3vPK6r1pEKJglddhqWa638b13fJ3F3Y7ToMYaaCieGAu3Qhmsr1cgXDTvvGKGIu0kzgC
	m7RHPW+AmE1rwikCEOTFIrAAzjsR6xhW/OPZY2ml0C9GSOOCo4TEAI9GCsG9XRwQuZTI=;
Received: from p54ae9c93.dip0.t-ipconnect.de ([84.174.156.147] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1s0FQx-007ltt-24;
	Fri, 26 Apr 2024 08:51:47 +0200
From: Felix Fietkau <nbd@nbd.name>
To: netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>
Cc: willemdebruijn.kernel@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 net-next v3 4/6] net: create tcp_gro_lookup helper function
Date: Fri, 26 Apr 2024 08:51:38 +0200
Message-ID: <20240426065143.4667-5-nbd@nbd.name>
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

This pulls the flow port matching out of tcp_gro_receive, so that it can be
reused for the next change, which adds the TCP fraglist GRO heuristic.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 include/net/tcp.h      |  1 +
 net/ipv4/tcp_offload.c | 41 +++++++++++++++++++++++++----------------
 2 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index ffc9371fe9de..a3f09aa44487 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2198,6 +2198,7 @@ void tcp_v4_destroy_sock(struct sock *sk);
 
 struct sk_buff *tcp_gso_segment(struct sk_buff *skb,
 				netdev_features_t features);
+struct sk_buff *tcp_gro_lookup(struct list_head *head, struct tcphdr *th);
 struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb);
 INDIRECT_CALLABLE_DECLARE(int tcp4_gro_complete(struct sk_buff *skb, int thoff));
 INDIRECT_CALLABLE_DECLARE(struct sk_buff *tcp4_gro_receive(struct list_head *head, struct sk_buff *skb));
diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index ffd6b7a4163a..3ee5a1b21976 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -243,6 +243,27 @@ struct sk_buff *tcp_gso_segment(struct sk_buff *skb,
 	return segs;
 }
 
+struct sk_buff *tcp_gro_lookup(struct list_head *head, struct tcphdr *th)
+{
+	struct tcphdr *th2;
+	struct sk_buff *p;
+
+	list_for_each_entry(p, head, list) {
+		if (!NAPI_GRO_CB(p)->same_flow)
+			continue;
+
+		th2 = tcp_hdr(p);
+		if (*(u32 *)&th->source ^ *(u32 *)&th2->source) {
+			NAPI_GRO_CB(p)->same_flow = 0;
+			continue;
+		}
+
+		return p;
+	}
+
+	return NULL;
+}
+
 struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb)
 {
 	struct sk_buff *pp = NULL;
@@ -280,24 +301,12 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb)
 	len = skb_gro_len(skb);
 	flags = tcp_flag_word(th);
 
-	list_for_each_entry(p, head, list) {
-		if (!NAPI_GRO_CB(p)->same_flow)
-			continue;
-
-		th2 = tcp_hdr(p);
-
-		if (*(u32 *)&th->source ^ *(u32 *)&th2->source) {
-			NAPI_GRO_CB(p)->same_flow = 0;
-			continue;
-		}
-
-		goto found;
-	}
-	p = NULL;
-	goto out_check_final;
+	p = tcp_gro_lookup(head, th);
+	if (!p)
+		goto out_check_final;
 
-found:
 	/* Include the IP ID check below from the inner most IP hdr */
+	th2 = tcp_hdr(p);
 	flush = NAPI_GRO_CB(p)->flush;
 	flush |= (__force int)(flags & TCP_FLAG_CWR);
 	flush |= (__force int)((flags ^ tcp_flag_word(th2)) &
-- 
2.44.0


