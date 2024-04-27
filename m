Return-Path: <linux-kernel+bounces-161120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D21768B4761
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 20:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 612C02823CD
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 18:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E529145B36;
	Sat, 27 Apr 2024 18:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="OIV25w+t"
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9724213C83D;
	Sat, 27 Apr 2024 18:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714242197; cv=none; b=bH0VHRys/odjiK/dp0T/mlvKeg0WFOW73wfWdjYSFGtSae82KPxhX4I0jmg7uaYRYW1KWJprQBPT4I0LIuXEFrd/NbdWupBjyY9c17ZOwmbSgBjSrm16JgRP/7bDTwz/JwlzkNLRtebLJhlNfxZbtlYrZEZv8PX4+E7a2ZigTOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714242197; c=relaxed/simple;
	bh=ox9NAfeFhrqPjBwzkXsYvR/UGk8/bElDUx9v+3/w7Vw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NTDb7KB2ofgEsPSIDCmuHP8N8GjqPrXlvkR5MF3vkxLNzWBFV6GNyl0BxVUbEzT0i6Pbk4BqVT+3n8lYww/AWH2BFl4PTpbBknjFvyEX/pEQK11atpBzavx59ewsjGSnuuSIM5xwsyup4NL46lmP1sh2lWXm+ZhZXjSEB9aBMz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=OIV25w+t; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=BSttFQg1nonWcp0gKuSSH24BV2EZe3joxZU+Ft51YOw=; b=OIV25w+tBz7y+OrOsQVxMO0krw
	Kfw0sViqFFwW/Nikt6kW7CKijfuHF7RDen1rCGZixtgsQoay80bNH6tUp7lJUcqE8BU4+B1oDY2NJ
	kB9QSi6wzqpLfDTDQwoT2sB3JypUMwSCpyYtRXs16m5qNhuvnvUhGlX0r5/aIIXqbyxg=;
Received: from p54ae9c93.dip0.t-ipconnect.de ([84.174.156.147] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1s0mhZ-008hH3-1B;
	Sat, 27 Apr 2024 20:23:09 +0200
From: Felix Fietkau <nbd@nbd.name>
To: netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>
Cc: willemdebruijn.kernel@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 net-next v4 4/6] net: create tcp_gro_lookup helper function
Date: Sat, 27 Apr 2024 20:23:00 +0200
Message-ID: <20240427182305.24461-5-nbd@nbd.name>
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

This pulls the flow port matching out of tcp_gro_receive, so that it can be
reused for the next change, which adds the TCP fraglist GRO heuristic.

Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 include/net/tcp.h      |  1 +
 net/ipv4/tcp_offload.c | 41 +++++++++++++++++++++++++----------------
 2 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index a9eb21251195..9f08ecab26e0 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2199,6 +2199,7 @@ void tcp_v4_destroy_sock(struct sock *sk);
 
 struct sk_buff *tcp_gso_segment(struct sk_buff *skb,
 				netdev_features_t features);
+struct sk_buff *tcp_gro_lookup(struct list_head *head, struct tcphdr *th);
 struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb);
 INDIRECT_CALLABLE_DECLARE(int tcp4_gro_complete(struct sk_buff *skb, int thoff));
 INDIRECT_CALLABLE_DECLARE(struct sk_buff *tcp4_gro_receive(struct list_head *head, struct sk_buff *skb));
diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index aa7508676315..4a194a9d36cd 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -245,6 +245,27 @@ struct sk_buff *tcp_gso_segment(struct sk_buff *skb,
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
@@ -282,24 +303,12 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb)
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


