Return-Path: <linux-kernel+bounces-157438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E138B11AC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FB312871C2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B057E16DED7;
	Wed, 24 Apr 2024 18:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="bIUvkJ0V"
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0B916D9BE;
	Wed, 24 Apr 2024 18:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713981910; cv=none; b=EyVeiayBI4OavG5UIg1vOPDOQ6qHPyIlhhpttKV/an2yS1z9n7ShHr1ZGCfDe1PNy/AiQsfbqsJcnDnentdYG8WhVIpMMkOYyTKUyZ4A2L9V0J62SitkONlm3d76ooLk7XPZ2ci+UHlgUswdE0wMFnSFpArNNQ5bWDRNm5SgAmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713981910; c=relaxed/simple;
	bh=09c7uP1ORdbCFiEPT2xKyCC6xooD2nv5BIgHym+HUj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K3s1JoivTN3I5wyn7cArumTZpbeTNAF5o+SaDikyIndOosHQfRJX/t5vx9ZAVda543luKo4/kSzeVJQbUwk93+ZsMYrd6ogTyvGh8v58SuKUKsgtDfcQ/64wJMkqV0yUkY5eyBv288rFjfSk7MsZh6hYNacmMlM29PfPzq9ZlDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=bIUvkJ0V; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=mptlG2kbHgQHXt+1cYb67vWWHauxjwdCKy7YK+knXSQ=; b=bIUvkJ0VbdATezSoXnbZMuqXih
	cPqVkkI1fAa9vJb8qjNzgcY2O/ckAfNP/sZlKwtBE5H25WA6BkU9pHKJdaLGLTjawbxejJEgOGCvn
	GUYPqBA84Q434MDvgz/NtuuuIDs0YoF0o1MoTsaegWx6x/Md4O80m0mTO5vLgGo4hhCA=;
Received: from p200300daa70d8400593e4be1bb3506c9.dip0.t-ipconnect.de ([2003:da:a70d:8400:593e:4be1:bb35:6c9] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1rzgzO-006rUX-2A;
	Wed, 24 Apr 2024 20:05:02 +0200
From: Felix Fietkau <nbd@nbd.name>
To: netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>
Cc: willemdebruijn.kernel@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/4] net: add code for TCP fraglist GRO
Date: Wed, 24 Apr 2024 20:04:55 +0200
Message-ID: <20240424180458.56211-4-nbd@nbd.name>
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

This implements fraglist GRO similar to how it's handled in UDP, however
no functional changes are added yet. The next change adds a heuristic for
using fraglist GRO instead of regular GRO.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 include/net/tcp.h        |  3 ++-
 net/ipv4/tcp_offload.c   | 29 +++++++++++++++++++++++++++--
 net/ipv6/tcpv6_offload.c | 11 ++++++++++-
 3 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index b935e1ae4caf..875cda53a7c9 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2194,7 +2194,8 @@ void tcp_v4_destroy_sock(struct sock *sk);
 
 struct sk_buff *tcp_gso_segment(struct sk_buff *skb,
 				netdev_features_t features);
-struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb);
+struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb,
+				bool fraglist);
 INDIRECT_CALLABLE_DECLARE(int tcp4_gro_complete(struct sk_buff *skb, int thoff));
 INDIRECT_CALLABLE_DECLARE(struct sk_buff *tcp4_gro_receive(struct list_head *head, struct sk_buff *skb));
 INDIRECT_CALLABLE_DECLARE(int tcp6_gro_complete(struct sk_buff *skb, int thoff));
diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index 06dbb2e2b2f3..6294e7a5c099 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -252,7 +252,8 @@ struct sk_buff *tcp_gso_segment(struct sk_buff *skb,
 	return segs;
 }
 
-struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb)
+struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb,
+				bool fraglist)
 {
 	struct sk_buff *pp = NULL;
 	struct sk_buff *p;
@@ -289,6 +290,7 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb)
 	len = skb_gro_len(skb);
 	flags = tcp_flag_word(th);
 
+	NAPI_GRO_CB(skb)->is_flist = fraglist;
 	list_for_each_entry(p, head, list) {
 		if (!NAPI_GRO_CB(p)->same_flow)
 			continue;
@@ -308,6 +310,7 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb)
 found:
 	/* Include the IP ID check below from the inner most IP hdr */
 	flush = NAPI_GRO_CB(p)->flush;
+	flush |= fraglist != NAPI_GRO_CB(p)->is_flist;
 	flush |= (__force int)(flags & TCP_FLAG_CWR);
 	flush |= (__force int)((flags ^ tcp_flag_word(th2)) &
 		  ~(TCP_FLAG_CWR | TCP_FLAG_FIN | TCP_FLAG_PSH));
@@ -341,6 +344,19 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb)
 	flush |= (ntohl(th2->seq) + skb_gro_len(p)) ^ ntohl(th->seq);
 	flush |= skb_cmp_decrypted(p, skb);
 
+	if (fraglist) {
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
@@ -399,7 +415,7 @@ struct sk_buff *tcp4_gro_receive(struct list_head *head, struct sk_buff *skb)
 		return NULL;
 	}
 
-	return tcp_gro_receive(head, skb);
+	return tcp_gro_receive(head, skb, false);
 }
 
 INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int thoff)
@@ -407,6 +423,15 @@ INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int thoff)
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
index 12fe79cb2c10..239588557dc4 100644
--- a/net/ipv6/tcpv6_offload.c
+++ b/net/ipv6/tcpv6_offload.c
@@ -24,7 +24,7 @@ struct sk_buff *tcp6_gro_receive(struct list_head *head, struct sk_buff *skb)
 		return NULL;
 	}
 
-	return tcp_gro_receive(head, skb);
+	return tcp_gro_receive(head, skb, false);
 }
 
 INDIRECT_CALLABLE_SCOPE int tcp6_gro_complete(struct sk_buff *skb, int thoff)
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


