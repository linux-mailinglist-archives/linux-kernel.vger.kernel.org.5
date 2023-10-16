Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F239A7CA050
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 09:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjJPHPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 03:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbjJPHPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 03:15:38 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F0ADC;
        Mon, 16 Oct 2023 00:15:37 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9b95622c620so724937266b.0;
        Mon, 16 Oct 2023 00:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697440535; x=1698045335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ac6XV9VFbfIO3SXyeEIuccANTPUbAeTZfeIr99C0LYQ=;
        b=HP91WgZFPNORsJaNhGPb0fuoN4IgTH2XTYycuBm8aF+OiwmJhvpz3Wb5QL4ZXj1lz9
         x5BjCE9c4yKSbtll27Y5O8glsk1v3S5sL074fvzqA8mejXaKP9m7pPiqbm/qj41iTdwu
         g74gwvZoybXyQyXob0W+fQZdU8ikjXaBEYU56UW2IEkbJrLeNmAdg18JbzwvAw1n1+KW
         A0Q328cdGzi5T1QC//x3/O1fGxHPZuxo8/n5VDcAayNBb71UHCh9/IaV3/JF6Kq+Jd+P
         2rX5Q8nRb5DALvb5MYXe2xdd+fo0bfiul1uU5Ub0IwjCpmCWslV13FUpoS/LCJE1RKOn
         I4Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697440535; x=1698045335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ac6XV9VFbfIO3SXyeEIuccANTPUbAeTZfeIr99C0LYQ=;
        b=w93gGcOdS7Ep0oJMqSYTizjzrM1UHjO7Qe5hmIoCuAPjY03s/ZY3iZOhQFGAI63ivG
         HsnxHjXzKBknzKpfuVBA9hp6vt9l91Zf3T1aC1M86Qa3mqgqFygHD+C0W0MI9gIUP1Se
         99JsRC5pSOZfuHyWkqA6ffBCnTz4zq8rSXYZe+oBjyf1INZzGluOQ+U1faFJgCn1bNvi
         iJD6dS9UyRYxLcaz0eKD+fcTmqQyVLLeLVX+Bs8qkTmYhcKBbuJDJFqlEfqyrcEulHPQ
         sIFUFHqGRfx2vJJ7YJSEBc50IiUU+kgb95Fmev3nMS4cMMpLzJsZQcLDK5Ecve89zYzg
         TPTw==
X-Gm-Message-State: AOJu0YzsXWGZVwABQoob3ojOT9td0wONgOjCv5uQSAPY4Kh508hKz7Sr
        YWd2HoDL1/r0vtFCwg5ghKggoutg9e4=
X-Google-Smtp-Source: AGHT+IE1WCYL6rU6JenKgmDevj200yR17KsP08PwSJfxfRw6ZgwEUF78zzn82C8+L9R3WlxS0+jkFg==
X-Received: by 2002:a17:907:86ab:b0:9bf:2bf:65f3 with SMTP id qa43-20020a17090786ab00b009bf02bf65f3mr4317622ejc.7.1697440535659;
        Mon, 16 Oct 2023 00:15:35 -0700 (PDT)
Received: from tp.home.arpa (host-79-55-64-40.retail.telecomitalia.it. [79.55.64.40])
        by smtp.gmail.com with ESMTPSA id jl25-20020a17090775d900b00992e265495csm3419471ejc.212.2023.10.16.00.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 00:15:35 -0700 (PDT)
From:   Beniamino Galvani <b.galvani@gmail.com>
To:     netdev@vger.kernel.org
Cc:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Guillaume Nault <gnault@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 3/7] ipv4: add new arguments to udp_tunnel_dst_lookup()
Date:   Mon, 16 Oct 2023 09:15:22 +0200
Message-Id: <20231016071526.2958108-4-b.galvani@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231016071526.2958108-1-b.galvani@gmail.com>
References: <20231016071526.2958108-1-b.galvani@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want to make the function more generic so that it can be used by
other UDP tunnel implementations such as geneve and vxlan. To do that,
add the following arguments:

 - source and destination UDP port;
 - ifindex of the output interface, needed by vxlan;
 - the tos, because in some cases it is not taken from struct
   ip_tunnel_info (for example, when it's inherited from the inner
   packet);
 - the dst cache, because not all tunnel types (e.g. vxlan) want to
   use the one from struct ip_tunnel_info.

With these parameters, the function no longer needs the full struct
ip_tunnel_info as argument and we can pass only the relevant part of
it (struct ip_tunnel_key).

Suggested-by: Guillaume Nault <gnault@redhat.com>
Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
---
 drivers/net/bareudp.c      | 11 +++++++----
 include/net/udp_tunnel.h   |  8 +++++---
 net/ipv4/udp_tunnel_core.c | 26 +++++++++++++-------------
 3 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/net/bareudp.c b/drivers/net/bareudp.c
index 6af67cac6bde..47a9c2a5583c 100644
--- a/drivers/net/bareudp.c
+++ b/drivers/net/bareudp.c
@@ -306,8 +306,10 @@ static int bareudp_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	if (!sock)
 		return -ESHUTDOWN;
 
-	rt = udp_tunnel_dst_lookup(skb, dev, bareudp->net, &saddr, info,
-				   use_cache);
+	rt = udp_tunnel_dst_lookup(skb, dev, bareudp->net, 0, &saddr, &info->key,
+				   0, 0, key->tos,
+				   use_cache ?
+				   (struct dst_cache *)&info->dst_cache : NULL);
 
 	if (IS_ERR(rt))
 		return PTR_ERR(rt);
@@ -483,8 +485,9 @@ static int bareudp_fill_metadata_dst(struct net_device *dev,
 		struct rtable *rt;
 		__be32 saddr;
 
-		rt = udp_tunnel_dst_lookup(skb, dev, bareudp->net, &saddr,
-					   info, use_cache);
+		rt = udp_tunnel_dst_lookup(skb, dev, bareudp->net, 0, &saddr,
+					   &info->key, 0, 0, info->key.tos,
+					   use_cache ? &info->dst_cache : NULL);
 		if (IS_ERR(rt))
 			return PTR_ERR(rt);
 
diff --git a/include/net/udp_tunnel.h b/include/net/udp_tunnel.h
index 8f110dbd3784..4d0578fab01a 100644
--- a/include/net/udp_tunnel.h
+++ b/include/net/udp_tunnel.h
@@ -164,9 +164,11 @@ void udp_tunnel_sock_release(struct socket *sock);
 
 struct rtable *udp_tunnel_dst_lookup(struct sk_buff *skb,
 				     struct net_device *dev,
-				     struct net *net, __be32 *saddr,
-				     const struct ip_tunnel_info *info,
-				     bool use_cache);
+				     struct net *net, int oif,
+				     __be32 *saddr,
+				     const struct ip_tunnel_key *key,
+				     __be16 sport, __be16 dport, u8 tos,
+				     struct dst_cache *dst_cache);
 
 struct metadata_dst *udp_tun_rx_dst(struct sk_buff *skb, unsigned short family,
 				    __be16 flags, __be64 tunnel_id,
diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
index 9b0cfd72d5fd..494685e82856 100644
--- a/net/ipv4/udp_tunnel_core.c
+++ b/net/ipv4/udp_tunnel_core.c
@@ -206,31 +206,31 @@ EXPORT_SYMBOL_GPL(udp_tun_rx_dst);
 
 struct rtable *udp_tunnel_dst_lookup(struct sk_buff *skb,
 				     struct net_device *dev,
-				     struct net *net, __be32 *saddr,
-				     const struct ip_tunnel_info *info,
-				     bool use_cache)
+				     struct net *net, int oif,
+				     __be32 *saddr,
+				     const struct ip_tunnel_key *key,
+				     __be16 sport, __be16 dport, u8 tos,
+				     struct dst_cache *dst_cache)
 {
-#ifdef CONFIG_DST_CACHE
-	struct dst_cache *dst_cache;
-#endif
 	struct rtable *rt = NULL;
 	struct flowi4 fl4;
-	__u8 tos;
 
 #ifdef CONFIG_DST_CACHE
-	dst_cache = (struct dst_cache *)&info->dst_cache;
-	if (use_cache) {
+	if (dst_cache) {
 		rt = dst_cache_get_ip4(dst_cache, saddr);
 		if (rt)
 			return rt;
 	}
 #endif
+
 	memset(&fl4, 0, sizeof(fl4));
 	fl4.flowi4_mark = skb->mark;
 	fl4.flowi4_proto = IPPROTO_UDP;
-	fl4.daddr = info->key.u.ipv4.dst;
-	fl4.saddr = info->key.u.ipv4.src;
-	tos = info->key.tos;
+	fl4.flowi4_oif = oif;
+	fl4.daddr = key->u.ipv4.dst;
+	fl4.saddr = key->u.ipv4.src;
+	fl4.fl4_dport = dport;
+	fl4.fl4_sport = sport;
 	fl4.flowi4_tos = RT_TOS(tos);
 
 	rt = ip_route_output_key(net, &fl4);
@@ -244,7 +244,7 @@ struct rtable *udp_tunnel_dst_lookup(struct sk_buff *skb,
 		return ERR_PTR(-ELOOP);
 	}
 #ifdef CONFIG_DST_CACHE
-	if (use_cache)
+	if (dst_cache)
 		dst_cache_set_ip4(dst_cache, &rt->dst, fl4.saddr);
 #endif
 	*saddr = fl4.saddr;
-- 
2.40.1

