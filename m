Return-Path: <linux-kernel+bounces-157326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CF18B0FD3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF54EB240CA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B513116D302;
	Wed, 24 Apr 2024 16:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LsHbQj9x"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F3E224E8;
	Wed, 24 Apr 2024 16:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713976280; cv=none; b=IUpHZHVUYa2aUmR14auDXM8zuaIzc0betKPvTIgivZuNXNKiLKwK58j0DOeq4UGE9ZBHsqfo27WF7FNjpOi6TXSsEVsx+kyeMmXj9oDXqIr9kLatzvRCE4R1qN5U/1GOKUUwo2aUAEKEDi/u4PhpFhz080gxsTEydPVJ1qUp1IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713976280; c=relaxed/simple;
	bh=AixDQM4dDKFPHO6uEtoMxrZDHaRr3b5n0FKmUADE5Io=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V3paXINUNaEfzTspqWqun40T6p3PZqb6Nz1Nh+0CQn7VgJHshvG+OFizOkjPl92tIvwozfQ5lhYX4Wn1LtEKlV9fvNdW88Q14RGRo7INl3KHgeL0D9te2bXd+BGzOsL9WhX3XzOVnSur99err7YfbfVSbrGqwvEhG2qwaJoVFhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LsHbQj9x; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3499f1bed15so706708f8f.1;
        Wed, 24 Apr 2024 09:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713976277; x=1714581077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7QuT4BeObJFe8wvayWogyBHFHRkrc8hy/BfvFL8inxQ=;
        b=LsHbQj9xRWofHpLuC4B3f0Gik2LjCLB3e4jdICmvob08wQyQMnbVeUuSqhkxsx/7tY
         Vajhbrgry2/RHmFzi0SEYQe/976/0R1EOwgcpa2GfLN/GFnCvL5xiW4CNLklBfqXgTKt
         O71AAytY3fRv8FtCQbvnN1INvrEaeSMbgRVMLq1dmO7lAbdwcZAach0HPyY0uTAa9huj
         FIQZDEcIhD4G/TCxySH+CDnM3cAkLKJTo3rgePbwxhsujP7KuIB4pzCXEKVNJ52jr4Mq
         62wCPFnK9mubq10obk5X2Y9IuMdQ4nbq7AwrGuZKCmUIlEYNQHeSaTYYLaB01WpJyTsu
         a4dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713976277; x=1714581077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7QuT4BeObJFe8wvayWogyBHFHRkrc8hy/BfvFL8inxQ=;
        b=Vy4lsK0aH4Z/8jyFKRgVo8j1XV1h+w1H64j0mauvTcTaw/txmPs1a5qffCyQWZ0NlI
         C5VIIIMXDDyt7pDmwtQ2zQ72FXDZlYmt9pTmkJiBaMwonJmWZFA2Sr6lLX1XU7PMptoD
         g68VzqRvuHRPZYU8lThUXPE24lGbeQef/UfVjbEnid+Yhfw0hEe2v4F6DUzo/dPL9LSN
         KY7Bh8XvKCKBgdPktcXxrw2qXWHCWnNK5lOc7tisLHJtKW5cz6kL8+lvQHkhLzUqu8lG
         5RVCkbcpjI6FbSobth4dNDIG1YzJYW6cwP3oXc9x43Zmba4wmHEgPs6jc1q5x6g5Rc5E
         7G2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXtyRJcF4xQmBosZIwXy2Gschv/eFKO3/ePS27eu5RvxNFfG+41gk+N9PtVSNgaI2xkdqFTu0m1BgzVCIiDXHSpa9U6TkcjFhBmnRfp77cTEK1t5HgdWTGhge3eVK7kXJWgIwsZ
X-Gm-Message-State: AOJu0YxJ+UksoGxvdLpM6X/SIYhe2kKj7iGDa3Y0nqo9wBBo4WRZmN35
	kjSW04QjYO2UE5c6OY8AJADwoBk8TCR1aMS3OXlnYU7I8f+LvV6o
X-Google-Smtp-Source: AGHT+IG8C+Z8Ltvhw5M0S2QqoAssT/yk7DfzwknfhzDlPhkP/e8g2apIHIWBqgVbvPGWkCAMwYzHdQ==
X-Received: by 2002:adf:e808:0:b0:347:9199:e972 with SMTP id o8-20020adfe808000000b003479199e972mr155566wrm.9.1713976277203;
        Wed, 24 Apr 2024 09:31:17 -0700 (PDT)
Received: from localhost ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id b15-20020a5d4b8f000000b0034b5dc8259dsm5256088wrt.57.2024.04.24.09.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 09:31:17 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	willemdebruijn.kernel@gmail.com,
	alobakin@pm.me,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net v3 1/2] net: gro: fix udp bad offset in socket lookup by adding {inner_}network_offset to napi_gro_cb
Date: Wed, 24 Apr 2024 18:30:44 +0200
Message-Id: <20240424163045.123528-2-richardbgobert@gmail.com>
In-Reply-To: <20240424163045.123528-1-richardbgobert@gmail.com>
References: <20240424163045.123528-1-richardbgobert@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commits a602456 ("udp: Add GRO functions to UDP socket") and 57c67ff ("udp:
additional GRO support") introduce incorrect usage of {ip,ipv6}_hdr in the
complete phase of gro. The functions always return skb->network_header,
which in the case of encapsulated packets at the gro complete phase, is
always set to the innermost L3 of the packet. That means that calling
{ip,ipv6}_hdr for skbs which completed the GRO receive phase (both in
gro_list and *_gro_complete) when parsing an encapsulated packet's _outer_
L3/L4 may return an unexpected value.

This incorrect usage leads to a bug in GRO's UDP socket lookup.
udp{4,6}_lib_lookup_skb functions use ip_hdr/ipv6_hdr respectively. These
*_hdr functions return network_header which will point to the innermost L3,
resulting in the wrong offset being used in __udp{4,6}_lib_lookup with
encapsulated packets.

This patch adds network_offset and inner_network_offset to napi_gro_cb, and
makes sure both are set correctly.

To fix the issue, network_offsets union is used inside napi_gro_cb, in
which both the outer and the inner network offsets are saved.

Reproduction example:

Endpoint configuration example (fou + local address bind)

    # ip fou add port 6666 ipproto 4
    # ip link add name tun1 type ipip remote 2.2.2.1 local 2.2.2.2 encap fou encap-dport 5555 encap-sport 6666 mode ipip
    # ip link set tun1 up
    # ip a add 1.1.1.2/24 dev tun1

Netperf TCP_STREAM result on net-next before patch is applied:

net-next main, GRO enabled:
    $ netperf -H 1.1.1.2 -t TCP_STREAM -l 5
    Recv   Send    Send
    Socket Socket  Message  Elapsed
    Size   Size    Size     Time     Throughput
    bytes  bytes   bytes    secs.    10^6bits/sec

    131072  16384  16384    5.28        2.37

net-next main, GRO disabled:
    $ netperf -H 1.1.1.2 -t TCP_STREAM -l 5
    Recv   Send    Send
    Socket Socket  Message  Elapsed
    Size   Size    Size     Time     Throughput
    bytes  bytes   bytes    secs.    10^6bits/sec

    131072  16384  16384    5.01     2745.06

patch applied, GRO enabled:
    $ netperf -H 1.1.1.2 -t TCP_STREAM -l 5
    Recv   Send    Send
    Socket Socket  Message  Elapsed
    Size   Size    Size     Time     Throughput
    bytes  bytes   bytes    secs.    10^6bits/sec

    131072  16384  16384    5.01     2877.38

Fixes: 57c67ff4bd92 ("udp: additional GRO support")
Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
---
 include/net/gro.h        | 18 ++++++++++++++++--
 net/8021q/vlan_core.c    |  2 ++
 net/core/gro.c           |  1 +
 net/ipv4/af_inet.c       |  5 +----
 net/ipv4/tcp_offload.c   |  3 ++-
 net/ipv4/udp.c           |  3 ++-
 net/ipv4/udp_offload.c   |  3 ++-
 net/ipv6/ip6_offload.c   |  6 +++---
 net/ipv6/tcpv6_offload.c |  3 ++-
 net/ipv6/udp.c           |  3 ++-
 net/ipv6/udp_offload.c   |  3 ++-
 11 files changed, 35 insertions(+), 15 deletions(-)

diff --git a/include/net/gro.h b/include/net/gro.h
index 50f1e403dbbb..1faff23b66e8 100644
--- a/include/net/gro.h
+++ b/include/net/gro.h
@@ -87,6 +87,15 @@ struct napi_gro_cb {
 
 	/* used to support CHECKSUM_COMPLETE for tunneling protocols */
 	__wsum	csum;
+
+	/* L3 offsets */
+	union {
+		struct {
+			u16 network_offset;
+			u16 inner_network_offset;
+		};
+		u16 network_offsets[2];
+	};
 };
 
 #define NAPI_GRO_CB(skb) ((struct napi_gro_cb *)(skb)->cb)
@@ -172,12 +181,17 @@ static inline void *skb_gro_header(struct sk_buff *skb, unsigned int hlen,
 	return ptr;
 }
 
+static inline int skb_gro_network_offset(const struct sk_buff *skb)
+{
+	return NAPI_GRO_CB(skb)->network_offsets[NAPI_GRO_CB(skb)->encap_mark];
+}
+
 static inline void *skb_gro_network_header(const struct sk_buff *skb)
 {
 	if (skb_gro_may_pull(skb, skb_gro_offset(skb)))
-		return skb_gro_header_fast(skb, skb_network_offset(skb));
+		return skb_gro_header_fast(skb, skb_gro_network_offset(skb));
 
-	return skb_network_header(skb);
+	return skb->data + skb_gro_network_offset(skb);
 }
 
 static inline __wsum inet_gro_compute_pseudo(const struct sk_buff *skb,
diff --git a/net/8021q/vlan_core.c b/net/8021q/vlan_core.c
index f00158234505..9404dd551dfd 100644
--- a/net/8021q/vlan_core.c
+++ b/net/8021q/vlan_core.c
@@ -478,6 +478,8 @@ static struct sk_buff *vlan_gro_receive(struct list_head *head,
 	if (unlikely(!vhdr))
 		goto out;
 
+	NAPI_GRO_CB(skb)->network_offsets[NAPI_GRO_CB(skb)->encap_mark] = hlen;
+
 	type = vhdr->h_vlan_encapsulated_proto;
 
 	ptype = gro_find_receive_by_type(type);
diff --git a/net/core/gro.c b/net/core/gro.c
index 83f35d99a682..c7901253a1a8 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -371,6 +371,7 @@ static inline void skb_gro_reset_offset(struct sk_buff *skb, u32 nhoff)
 	const skb_frag_t *frag0;
 	unsigned int headlen;
 
+	NAPI_GRO_CB(skb)->network_offset = 0;
 	NAPI_GRO_CB(skb)->data_offset = 0;
 	headlen = skb_headlen(skb);
 	NAPI_GRO_CB(skb)->frag0 = skb->data;
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 55bd72997b31..2daf635ab99e 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1568,10 +1568,7 @@ struct sk_buff *inet_gro_receive(struct list_head *head, struct sk_buff *skb)
 
 	NAPI_GRO_CB(skb)->is_atomic = !!(iph->frag_off & htons(IP_DF));
 	NAPI_GRO_CB(skb)->flush |= flush;
-	skb_set_network_header(skb, off);
-	/* The above will be needed by the transport layer if there is one
-	 * immediately following this IP hdr.
-	 */
+	NAPI_GRO_CB(skb)->inner_network_offset = off;
 
 	/* Note : No need to call skb_gro_postpull_rcsum() here,
 	 * as we already checked checksum over ipv4 header was 0
diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index ebe4722bb020..be8ddf6da88c 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -332,7 +332,8 @@ struct sk_buff *tcp4_gro_receive(struct list_head *head, struct sk_buff *skb)
 
 INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int thoff)
 {
-	const struct iphdr *iph = ip_hdr(skb);
+	const u16 offset = NAPI_GRO_CB(skb)->network_offsets[skb->encapsulation];
+	const struct iphdr *iph = (struct iphdr *)(skb->data + offset);
 	struct tcphdr *th = tcp_hdr(skb);
 
 	th->check = ~tcp_v4_check(skb->len - thoff, iph->saddr,
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index c02bf011d4a6..1399fce82b3f 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -532,7 +532,8 @@ static inline struct sock *__udp4_lib_lookup_skb(struct sk_buff *skb,
 struct sock *udp4_lib_lookup_skb(const struct sk_buff *skb,
 				 __be16 sport, __be16 dport)
 {
-	const struct iphdr *iph = ip_hdr(skb);
+	const u16 offset = NAPI_GRO_CB(skb)->network_offsets[skb->encapsulation];
+	const struct iphdr *iph = (struct iphdr *)(skb->data + offset);
 	struct net *net = dev_net(skb->dev);
 	int iif, sdif;
 
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 3498dd1d0694..fd29d21d579c 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -718,7 +718,8 @@ EXPORT_SYMBOL(udp_gro_complete);
 
 INDIRECT_CALLABLE_SCOPE int udp4_gro_complete(struct sk_buff *skb, int nhoff)
 {
-	const struct iphdr *iph = ip_hdr(skb);
+	const u16 offset = NAPI_GRO_CB(skb)->network_offsets[skb->encapsulation];
+	const struct iphdr *iph = (struct iphdr *)(skb->data + offset);
 	struct udphdr *uh = (struct udphdr *)(skb->data + nhoff);
 
 	/* do fraglist only if there is no outer UDP encap (or we already processed it) */
diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index b41e35af69ea..5d6b875a4638 100644
--- a/net/ipv6/ip6_offload.c
+++ b/net/ipv6/ip6_offload.c
@@ -67,7 +67,7 @@ static int ipv6_gro_pull_exthdrs(struct sk_buff *skb, int off, int proto)
 		off += len;
 	}
 
-	skb_gro_pull(skb, off - skb_network_offset(skb));
+	skb_gro_pull(skb, off - skb_gro_network_offset(skb));
 	return proto;
 }
 
@@ -236,7 +236,7 @@ INDIRECT_CALLABLE_SCOPE struct sk_buff *ipv6_gro_receive(struct list_head *head,
 	if (unlikely(!iph))
 		goto out;
 
-	skb_set_network_header(skb, off);
+	NAPI_GRO_CB(skb)->inner_network_offset = off;
 
 	flush += ntohs(iph->payload_len) != skb->len - hlen;
 
@@ -259,7 +259,7 @@ INDIRECT_CALLABLE_SCOPE struct sk_buff *ipv6_gro_receive(struct list_head *head,
 	NAPI_GRO_CB(skb)->proto = proto;
 
 	flush--;
-	nlen = skb_network_header_len(skb);
+	nlen = skb_gro_offset(skb) - off;
 
 	list_for_each_entry(p, head, list) {
 		const struct ipv6hdr *iph2;
diff --git a/net/ipv6/tcpv6_offload.c b/net/ipv6/tcpv6_offload.c
index 4b07d1e6c952..e70d60e0f86f 100644
--- a/net/ipv6/tcpv6_offload.c
+++ b/net/ipv6/tcpv6_offload.c
@@ -29,7 +29,8 @@ struct sk_buff *tcp6_gro_receive(struct list_head *head, struct sk_buff *skb)
 
 INDIRECT_CALLABLE_SCOPE int tcp6_gro_complete(struct sk_buff *skb, int thoff)
 {
-	const struct ipv6hdr *iph = ipv6_hdr(skb);
+	const u16 offset = NAPI_GRO_CB(skb)->network_offsets[skb->encapsulation];
+	const struct ipv6hdr *iph = (struct ipv6hdr *)(skb->data + offset);
 	struct tcphdr *th = tcp_hdr(skb);
 
 	th->check = ~tcp_v6_check(skb->len - thoff, &iph->saddr,
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 8b1dd7f51249..f7880e306410 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -272,7 +272,8 @@ static struct sock *__udp6_lib_lookup_skb(struct sk_buff *skb,
 struct sock *udp6_lib_lookup_skb(const struct sk_buff *skb,
 				 __be16 sport, __be16 dport)
 {
-	const struct ipv6hdr *iph = ipv6_hdr(skb);
+	const u16 offset = NAPI_GRO_CB(skb)->network_offsets[skb->encapsulation];
+	const struct ipv6hdr *iph = (struct ipv6hdr *)(skb->data + offset);
 	struct net *net = dev_net(skb->dev);
 	int iif, sdif;
 
diff --git a/net/ipv6/udp_offload.c b/net/ipv6/udp_offload.c
index bbd347de00b4..b41152dd4246 100644
--- a/net/ipv6/udp_offload.c
+++ b/net/ipv6/udp_offload.c
@@ -164,7 +164,8 @@ struct sk_buff *udp6_gro_receive(struct list_head *head, struct sk_buff *skb)
 
 INDIRECT_CALLABLE_SCOPE int udp6_gro_complete(struct sk_buff *skb, int nhoff)
 {
-	const struct ipv6hdr *ipv6h = ipv6_hdr(skb);
+	const u16 offset = NAPI_GRO_CB(skb)->network_offsets[skb->encapsulation];
+	const struct ipv6hdr *ipv6h = (struct ipv6hdr *)(skb->data + offset);
 	struct udphdr *uh = (struct udphdr *)(skb->data + nhoff);
 
 	/* do fraglist only if there is no outer UDP encap (or we already processed it) */
-- 
2.36.1


