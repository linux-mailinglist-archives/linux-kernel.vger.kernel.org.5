Return-Path: <linux-kernel+bounces-166136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE94F8B96AF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30315B2266B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DA95674D;
	Thu,  2 May 2024 08:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="dDIlppcj"
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFA74D5BD;
	Thu,  2 May 2024 08:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714639505; cv=none; b=mw4fwBRcdVOz/3GOzmUL7BIU+Zq9FgBeMS6jHmEAWEsEdq0a9fZOt1cFeOvHlbwruj46VvDlwNws4Z0p4sGPComZ0yNrbYIyF6StGsa5ymnpcVZroaHOsU0kD6IfzzyjrwMImEpVHKWPFhHxgbqaHBLLrtcaNFagsbwYXInlYno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714639505; c=relaxed/simple;
	bh=em95ThCxyRDDBjSTJDqTAFCT1a5qtEljt9DPevZNmjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oVfLR3Aw65gu4+FmIGpd4R9fZNi5hftcEk9HLVfi79yZk6p7IjxtzPGlif7cqsU5Liiwp+4r+1ey1rX668nhwgVfvKJJ5qAz3BSDvHEcZUOVcQ5bVvonovpfn0TA/xlaWfUB8bAByg+qgVHjMJMRYlSDzMfzSy9mNX6JRwt4GcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=dDIlppcj; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ClxvxZbCCOupReIkBBj/RqjhghV22QirKfocqVO5EBo=; b=dDIlppcjXom0blgcUvN0bpCdHU
	XaVwoil79CsD2lbRS5Ob5CKxDeQTIDCNg/CkZcjJF8se3h2nzRDE2Hbe8tcfXro6NPnfIzmfe4enV
	w43KgA2ZlIOC1oVe2Nrk1dfMZDklJNcTTvlZrQNck025kh4C253gxviBd/AvMVpa8ryE=;
Received: from p54ae9c93.dip0.t-ipconnect.de ([84.174.156.147] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1s2S3i-00BKKn-1O;
	Thu, 02 May 2024 10:44:54 +0200
From: Felix Fietkau <nbd@nbd.name>
To: netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>
Cc: willemdebruijn.kernel@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 net-next v5 4/6] net: create tcp_gro_lookup helper function
Date: Thu,  2 May 2024 10:44:45 +0200
Message-ID: <20240502084450.44009-5-nbd@nbd.name>
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

This pulls the flow port matching out of tcp_gro_receive, so that it can be
reused for the next change, which adds the TCP fraglist GRO heuristic.

Acked-by: Paolo Abeni <pabeni@redhat.com>
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


