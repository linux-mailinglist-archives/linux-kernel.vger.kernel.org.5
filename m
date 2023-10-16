Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7667CA04C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 09:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbjJPHPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 03:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjJPHPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 03:15:38 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0900AD;
        Mon, 16 Oct 2023 00:15:35 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9bda758748eso382919066b.2;
        Mon, 16 Oct 2023 00:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697440534; x=1698045334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2kiZfGk8qOY0ezcTTkcNb4cILnemak8jfZ8cGRnm5dM=;
        b=KBQBjtAzR4meidgcAjt3XCvVhyRivqcLUalZoEEiOmNpIT58Gaxypf45WpGP6+dWG8
         vNHBPlw36tk8M6JryKMb21QKBMQ7G1a26CbEAQdS8YwIDAJW7SAtSnl4L6pRJfwe4sg8
         2eLRLvs4VEfkA6TwsBKGidMDzgbTVDMbATYst8JbnNWcObv5tRzac/xiyLFD7O6AcbBm
         VkL/HBZ9qi1zJaHeoTQolDSlMGk4yOR2vM3MXZZSk1s1LmTmURJAm6nAFJ3KImjjbyEW
         UChH7ez4HiPAsHCOoGgJ4Uw2eRCNd0L9op99zw1bwXSJgAjGkXN0ya5e2taSx9Rdbp0q
         gyXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697440534; x=1698045334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2kiZfGk8qOY0ezcTTkcNb4cILnemak8jfZ8cGRnm5dM=;
        b=nOD9s5iPw3yFPAE4biFvB9m3MEhdAKv4BTJ08j8IS9f6r+jQTlHNTyiUBATH6pqRTX
         nXpv74GpSe/tTaXi4uKOm6UJpSPpztp5cqB6g/SjNqbNTBgVSBXud7FxNuBuOvNxr9/h
         aGV04JTqngAiixSeZdgjxc7MJ+Z7KfjwFbRl+6OrX3/undKuz59ouI/ENPOd0Q/Zr+gC
         pJmO0G4L9qvI2YQbfKn2DMEd6OWw9j30+8XHQpX0tFWJU4y+gJ7Rw1MOhChTo5evy6Ba
         zVa3ti6LXwbRshV9NfPCQxJtJDbw7MUP4Old48H2LLcUwSyUcV5LOSCes1TJe9l5Woi/
         wlpA==
X-Gm-Message-State: AOJu0YxrsHz5eEQ0YwF66VX+QS4+SKAk3b4Lhj0BOk/elz9wtCOQEyY6
        YvIHTnc274N/LkT3gkuV/CvTt6CpypA=
X-Google-Smtp-Source: AGHT+IE60/Rl5IOSN/MTGSN+dJFax9CpjovMV6w93m20bl2Y2RC9NIQSoL3klwtwuEJiEmaIEWPTgA==
X-Received: by 2002:a17:907:94ce:b0:9bf:b8f7:1fd3 with SMTP id dn14-20020a17090794ce00b009bfb8f71fd3mr3288318ejc.45.1697440534336;
        Mon, 16 Oct 2023 00:15:34 -0700 (PDT)
Received: from tp.home.arpa (host-79-55-64-40.retail.telecomitalia.it. [79.55.64.40])
        by smtp.gmail.com with ESMTPSA id jl25-20020a17090775d900b00992e265495csm3419471ejc.212.2023.10.16.00.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 00:15:34 -0700 (PDT)
From:   Beniamino Galvani <b.galvani@gmail.com>
To:     netdev@vger.kernel.org
Cc:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Guillaume Nault <gnault@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/7] ipv4: rename and move ip_route_output_tunnel()
Date:   Mon, 16 Oct 2023 09:15:20 +0200
Message-Id: <20231016071526.2958108-2-b.galvani@gmail.com>
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

At the moment ip_route_output_tunnel() is used only by bareudp.
Ideally, other UDP tunnel implementations should use it, but to do so
the function needs to accept new parameters that are specific for UDP
tunnels, such as the ports.

Prepare for these changes by renaming the function to
udp_tunnel_dst_lookup() and move it to file
net/ipv4/udp_tunnel_core.c.

Suggested-by: Guillaume Nault <gnault@redhat.com>
Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
---
 drivers/net/bareudp.c      |  8 +++----
 include/net/route.h        |  6 -----
 include/net/udp_tunnel.h   |  6 +++++
 net/ipv4/route.c           | 48 --------------------------------------
 net/ipv4/udp_tunnel_core.c | 48 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 58 insertions(+), 58 deletions(-)

diff --git a/drivers/net/bareudp.c b/drivers/net/bareudp.c
index 683203f87ae2..63fc32fa1af5 100644
--- a/drivers/net/bareudp.c
+++ b/drivers/net/bareudp.c
@@ -306,8 +306,8 @@ static int bareudp_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	if (!sock)
 		return -ESHUTDOWN;
 
-	rt = ip_route_output_tunnel(skb, dev, bareudp->net, &saddr, info,
-				    IPPROTO_UDP, use_cache);
+	rt = udp_tunnel_dst_lookup(skb, dev, bareudp->net, &saddr, info,
+				   IPPROTO_UDP, use_cache);
 
 	if (IS_ERR(rt))
 		return PTR_ERR(rt);
@@ -483,8 +483,8 @@ static int bareudp_fill_metadata_dst(struct net_device *dev,
 		struct rtable *rt;
 		__be32 saddr;
 
-		rt = ip_route_output_tunnel(skb, dev, bareudp->net, &saddr,
-					    info, IPPROTO_UDP, use_cache);
+		rt = udp_tunnel_dst_lookup(skb, dev, bareudp->net, &saddr,
+					   info, IPPROTO_UDP, use_cache);
 		if (IS_ERR(rt))
 			return PTR_ERR(rt);
 
diff --git a/include/net/route.h b/include/net/route.h
index 5c248a8e3d0e..980ab474eabd 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -136,12 +136,6 @@ static inline struct rtable *__ip_route_output_key(struct net *net,
 
 struct rtable *ip_route_output_flow(struct net *, struct flowi4 *flp,
 				    const struct sock *sk);
-struct rtable *ip_route_output_tunnel(struct sk_buff *skb,
-				      struct net_device *dev,
-				      struct net *net, __be32 *saddr,
-				      const struct ip_tunnel_info *info,
-				      u8 protocol, bool use_cache);
-
 struct dst_entry *ipv4_blackhole_route(struct net *net,
 				       struct dst_entry *dst_orig);
 
diff --git a/include/net/udp_tunnel.h b/include/net/udp_tunnel.h
index 21ba0a25f936..11e810ca5088 100644
--- a/include/net/udp_tunnel.h
+++ b/include/net/udp_tunnel.h
@@ -162,6 +162,12 @@ int udp_tunnel6_xmit_skb(struct dst_entry *dst, struct sock *sk,
 
 void udp_tunnel_sock_release(struct socket *sock);
 
+struct rtable *udp_tunnel_dst_lookup(struct sk_buff *skb,
+				     struct net_device *dev,
+				     struct net *net, __be32 *saddr,
+				     const struct ip_tunnel_info *info,
+				     u8 protocol, bool use_cache);
+
 struct metadata_dst *udp_tun_rx_dst(struct sk_buff *skb, unsigned short family,
 				    __be16 flags, __be64 tunnel_id,
 				    int md_size);
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index e2bf4602b559..3290a4442b4a 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2885,54 +2885,6 @@ struct rtable *ip_route_output_flow(struct net *net, struct flowi4 *flp4,
 }
 EXPORT_SYMBOL_GPL(ip_route_output_flow);
 
-struct rtable *ip_route_output_tunnel(struct sk_buff *skb,
-				      struct net_device *dev,
-				      struct net *net, __be32 *saddr,
-				      const struct ip_tunnel_info *info,
-				      u8 protocol, bool use_cache)
-{
-#ifdef CONFIG_DST_CACHE
-	struct dst_cache *dst_cache;
-#endif
-	struct rtable *rt = NULL;
-	struct flowi4 fl4;
-	__u8 tos;
-
-#ifdef CONFIG_DST_CACHE
-	dst_cache = (struct dst_cache *)&info->dst_cache;
-	if (use_cache) {
-		rt = dst_cache_get_ip4(dst_cache, saddr);
-		if (rt)
-			return rt;
-	}
-#endif
-	memset(&fl4, 0, sizeof(fl4));
-	fl4.flowi4_mark = skb->mark;
-	fl4.flowi4_proto = protocol;
-	fl4.daddr = info->key.u.ipv4.dst;
-	fl4.saddr = info->key.u.ipv4.src;
-	tos = info->key.tos;
-	fl4.flowi4_tos = RT_TOS(tos);
-
-	rt = ip_route_output_key(net, &fl4);
-	if (IS_ERR(rt)) {
-		netdev_dbg(dev, "no route to %pI4\n", &fl4.daddr);
-		return ERR_PTR(-ENETUNREACH);
-	}
-	if (rt->dst.dev == dev) { /* is this necessary? */
-		netdev_dbg(dev, "circular route to %pI4\n", &fl4.daddr);
-		ip_rt_put(rt);
-		return ERR_PTR(-ELOOP);
-	}
-#ifdef CONFIG_DST_CACHE
-	if (use_cache)
-		dst_cache_set_ip4(dst_cache, &rt->dst, fl4.saddr);
-#endif
-	*saddr = fl4.saddr;
-	return rt;
-}
-EXPORT_SYMBOL_GPL(ip_route_output_tunnel);
-
 /* called with rcu_read_lock held */
 static int rt_fill_info(struct net *net, __be32 dst, __be32 src,
 			struct rtable *rt, u32 table_id, struct flowi4 *fl4,
diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
index 1e7e4aecdc48..96f93f92b6ce 100644
--- a/net/ipv4/udp_tunnel_core.c
+++ b/net/ipv4/udp_tunnel_core.c
@@ -204,4 +204,52 @@ struct metadata_dst *udp_tun_rx_dst(struct sk_buff *skb,  unsigned short family,
 }
 EXPORT_SYMBOL_GPL(udp_tun_rx_dst);
 
+struct rtable *udp_tunnel_dst_lookup(struct sk_buff *skb,
+				     struct net_device *dev,
+				     struct net *net, __be32 *saddr,
+				     const struct ip_tunnel_info *info,
+				     u8 protocol, bool use_cache)
+{
+#ifdef CONFIG_DST_CACHE
+	struct dst_cache *dst_cache;
+#endif
+	struct rtable *rt = NULL;
+	struct flowi4 fl4;
+	__u8 tos;
+
+#ifdef CONFIG_DST_CACHE
+	dst_cache = (struct dst_cache *)&info->dst_cache;
+	if (use_cache) {
+		rt = dst_cache_get_ip4(dst_cache, saddr);
+		if (rt)
+			return rt;
+	}
+#endif
+	memset(&fl4, 0, sizeof(fl4));
+	fl4.flowi4_mark = skb->mark;
+	fl4.flowi4_proto = protocol;
+	fl4.daddr = info->key.u.ipv4.dst;
+	fl4.saddr = info->key.u.ipv4.src;
+	tos = info->key.tos;
+	fl4.flowi4_tos = RT_TOS(tos);
+
+	rt = ip_route_output_key(net, &fl4);
+	if (IS_ERR(rt)) {
+		netdev_dbg(dev, "no route to %pI4\n", &fl4.daddr);
+		return ERR_PTR(-ENETUNREACH);
+	}
+	if (rt->dst.dev == dev) { /* is this necessary? */
+		netdev_dbg(dev, "circular route to %pI4\n", &fl4.daddr);
+		ip_rt_put(rt);
+		return ERR_PTR(-ELOOP);
+	}
+#ifdef CONFIG_DST_CACHE
+	if (use_cache)
+		dst_cache_set_ip4(dst_cache, &rt->dst, fl4.saddr);
+#endif
+	*saddr = fl4.saddr;
+	return rt;
+}
+EXPORT_SYMBOL_GPL(udp_tunnel_dst_lookup);
+
 MODULE_LICENSE("GPL");
-- 
2.40.1

