Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0BB97D0F3B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 13:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377389AbjJTL4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 07:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377294AbjJTLz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 07:55:56 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE43C1BF;
        Fri, 20 Oct 2023 04:55:53 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9c603e2354fso159060166b.1;
        Fri, 20 Oct 2023 04:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697802952; x=1698407752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=70UyLOondynQ9UoUBHNCV+hwoRw2E4n6LYozqYQifYc=;
        b=aii8k1vjHZGisANWo1RRAcxjrIWta2KRpCOxVW2oGGc4xxSn9L6qVSeGuMirDJ961x
         LhW1huUSE/PtwvIu0kqDHKBu2OZYMVllw/XCAaoaVjrm6XlxWpUkpT5LMVo/Jo5eXLud
         W4TMuJEvdG16g2i8VYNNEaLsVKlbvmUQp/WsQWDND7ciVYRK46nGGvuj8Lp1HSBGLQTD
         TUDJygo2X+x0QIi0Ezz8/ISzNLeAXPcwXdagZOr5R284F9OAM0LPLTKk4HxohctrqiCS
         tdUZBKdIDRF7MA2NZvYSlORCMX2WheCyhFrpRWXLqvC+1D+A5H2lHNxbsubtEO9gYlCr
         FgTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697802952; x=1698407752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=70UyLOondynQ9UoUBHNCV+hwoRw2E4n6LYozqYQifYc=;
        b=ZOJMdNYhUAlOSeXlW85LHtUs8kwlBjssh0sSUrkJXE+a7gsEERkJL6g1dzJvAK53Ur
         TUTy11OX34mxsQ9vEIvKrvh7ZQo+DYVcEKZR3Ea3SiaWXNIwSYJQtYRh4t+U8IrgrjKr
         au5vEk6dnVOPeC7GwVSS6th8B3wSchMM7ik7HIV95kpRqSlP3nRRBUfPJnL1rbPU722/
         9PLgVQyqLvi1JNKGWTudvljrApvG5GGMQDwfbVWGyX+rK/6+uqfnngoMA/QJQxrREpan
         EuzuxFQFBI2zOPdzn/QbMW1evMt0WCKoA7ogAT+/01kUDx9IUzD6hAkxKdQeiRWW8JEB
         9V8A==
X-Gm-Message-State: AOJu0Yx08kEJScdy5HTZc2jTOAxyxus4kP2kB4qht3WIJVhysGtiUi65
        bQWW2wY6nlM6Mo93Yq+ZWY8TTRA3HH9WLw==
X-Google-Smtp-Source: AGHT+IHlwrkZ7lOpoBia6Qx8zJ6+ZowQKfdb9FM+RBV3/5EcV5sbt7LEmsLZnZYR6jimtqlBOjEXaA==
X-Received: by 2002:a17:907:3e1c:b0:9b2:bcea:e517 with SMTP id hp28-20020a1709073e1c00b009b2bceae517mr1617344ejc.10.1697802951953;
        Fri, 20 Oct 2023 04:55:51 -0700 (PDT)
Received: from tp.home.arpa (host-95-239-66-218.retail.telecomitalia.it. [95.239.66.218])
        by smtp.gmail.com with ESMTPSA id v21-20020a170906489500b009b928eb8dd3sm1342014ejq.163.2023.10.20.04.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 04:55:51 -0700 (PDT)
From:   Beniamino Galvani <b.galvani@gmail.com>
To:     netdev@vger.kernel.org
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Guillaume Nault <gnault@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 5/5] vxlan: use generic function for tunnel IPv6 route lookup
Date:   Fri, 20 Oct 2023 13:55:29 +0200
Message-Id: <20231020115529.3344878-6-b.galvani@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231020115529.3344878-1-b.galvani@gmail.com>
References: <20231020115529.3344878-1-b.galvani@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The route lookup can be done now via generic function
udp_tunnel6_dst_lookup() to replace the custom implementation in
vxlan6_get_route().

This is similar to what already done for IPv4 in commit 6f19b2c136d9
("vxlan: use generic function for tunnel IPv4 route lookup").

Suggested-by: Guillaume Nault <gnault@redhat.com>
Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
---
 drivers/net/vxlan/vxlan_core.c | 136 ++++++++-------------------------
 1 file changed, 30 insertions(+), 106 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 6f7d45e3cfa2..7b526ae16ed0 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2215,63 +2215,6 @@ static int vxlan_build_skb(struct sk_buff *skb, struct dst_entry *dst,
 	return 0;
 }
 
-#if IS_ENABLED(CONFIG_IPV6)
-static struct dst_entry *vxlan6_get_route(struct vxlan_dev *vxlan,
-					  struct net_device *dev,
-					  struct vxlan_sock *sock6,
-					  struct sk_buff *skb, int oif, u8 tos,
-					  __be32 label,
-					  const struct in6_addr *daddr,
-					  struct in6_addr *saddr,
-					  __be16 dport, __be16 sport,
-					  struct dst_cache *dst_cache,
-					  const struct ip_tunnel_info *info)
-{
-	bool use_cache = ip_tunnel_dst_cache_usable(skb, info);
-	struct dst_entry *ndst;
-	struct flowi6 fl6;
-
-	if (!sock6)
-		return ERR_PTR(-EIO);
-
-	if (tos && !info)
-		use_cache = false;
-	if (use_cache) {
-		ndst = dst_cache_get_ip6(dst_cache, saddr);
-		if (ndst)
-			return ndst;
-	}
-
-	memset(&fl6, 0, sizeof(fl6));
-	fl6.flowi6_oif = oif;
-	fl6.daddr = *daddr;
-	fl6.saddr = *saddr;
-	fl6.flowlabel = ip6_make_flowinfo(tos, label);
-	fl6.flowi6_mark = skb->mark;
-	fl6.flowi6_proto = IPPROTO_UDP;
-	fl6.fl6_dport = dport;
-	fl6.fl6_sport = sport;
-
-	ndst = ipv6_stub->ipv6_dst_lookup_flow(vxlan->net, sock6->sock->sk,
-					       &fl6, NULL);
-	if (IS_ERR(ndst)) {
-		netdev_dbg(dev, "no route to %pI6\n", daddr);
-		return ERR_PTR(-ENETUNREACH);
-	}
-
-	if (unlikely(ndst->dev == dev)) {
-		netdev_dbg(dev, "circular route to %pI6\n", daddr);
-		dst_release(ndst);
-		return ERR_PTR(-ELOOP);
-	}
-
-	*saddr = fl6.saddr;
-	if (use_cache)
-		dst_cache_set_ip6(dst_cache, ndst, saddr);
-	return ndst;
-}
-#endif
-
 /* Bypass encapsulation if the destination is local */
 static void vxlan_encap_bypass(struct sk_buff *skb, struct vxlan_dev *src_vxlan,
 			       struct vxlan_dev *dst_vxlan, __be32 vni,
@@ -2325,7 +2268,7 @@ static void vxlan_encap_bypass(struct sk_buff *skb, struct vxlan_dev *src_vxlan,
 
 static int encap_bypass_if_local(struct sk_buff *skb, struct net_device *dev,
 				 struct vxlan_dev *vxlan,
-				 union vxlan_addr *daddr,
+				 int addr_family,
 				 __be16 dst_port, int dst_ifindex, __be32 vni,
 				 struct dst_entry *dst,
 				 u32 rt_flags)
@@ -2345,7 +2288,7 @@ static int encap_bypass_if_local(struct sk_buff *skb, struct net_device *dev,
 
 		dst_release(dst);
 		dst_vxlan = vxlan_find_vni(vxlan->net, dst_ifindex, vni,
-					   daddr->sa.sa_family, dst_port,
+					   addr_family, dst_port,
 					   vxlan->cfg.flags);
 		if (!dst_vxlan) {
 			dev->stats.tx_errors++;
@@ -2371,13 +2314,12 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 	struct ip_tunnel_key key;
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	const struct iphdr *old_iph = ip_hdr(skb);
-	union vxlan_addr *dst;
-	union vxlan_addr remote_ip;
 	struct vxlan_metadata _md;
 	struct vxlan_metadata *md = &_md;
 	unsigned int pkt_len = skb->len;
 	__be16 src_port = 0, dst_port;
 	struct dst_entry *ndst = NULL;
+	int addr_family;
 	__u8 tos, ttl;
 	int ifindex;
 	int err;
@@ -2386,20 +2328,15 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 	bool udp_sum = false;
 	bool xnet = !net_eq(vxlan->net, dev_net(vxlan->dev));
 	__be32 vni = 0;
-#if IS_ENABLED(CONFIG_IPV6)
-	union vxlan_addr local_ip;
-	__be32 label;
-#endif
 
 	info = skb_tunnel_info(skb);
 	use_cache = ip_tunnel_dst_cache_usable(skb, info);
 
 	if (rdst) {
-		dst = &rdst->remote_ip;
 		memset(&key, 0, sizeof(key));
 		pkey = &key;
 
-		if (vxlan_addr_any(dst)) {
+		if (vxlan_addr_any(&rdst->remote_ip)) {
 			if (did_rsc) {
 				/* short-circuited back to local bridge */
 				vxlan_encap_bypass(skb, vxlan, vxlan,
@@ -2409,11 +2346,12 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 			goto drop;
 		}
 
+		addr_family = vxlan->cfg.saddr.sa.sa_family;
 		dst_port = rdst->remote_port ? rdst->remote_port : vxlan->cfg.dst_port;
 		vni = (rdst->remote_vni) ? : default_vni;
 		ifindex = rdst->remote_ifindex;
 
-		if (dst->sa.sa_family == AF_INET) {
+		if (addr_family == AF_INET) {
 			key.u.ipv4.src = vxlan->cfg.saddr.sin.sin_addr.s_addr;
 			key.u.ipv4.dst = rdst->remote_ip.sin.sin_addr.s_addr;
 		} else {
@@ -2427,23 +2365,21 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 			ttl = ip_tunnel_get_ttl(old_iph, skb);
 		} else {
 			ttl = vxlan->cfg.ttl;
-			if (!ttl && vxlan_addr_multicast(dst))
+			if (!ttl && vxlan_addr_multicast(&rdst->remote_ip))
 				ttl = 1;
 		}
-
 		tos = vxlan->cfg.tos;
 		if (tos == 1)
 			tos = ip_tunnel_get_dsfield(old_iph, skb);
 		if (tos && !info)
 			use_cache = false;
 
-		if (dst->sa.sa_family == AF_INET)
+		if (addr_family == AF_INET)
 			udp_sum = !(flags & VXLAN_F_UDP_ZERO_CSUM_TX);
 		else
 			udp_sum = !(flags & VXLAN_F_UDP_ZERO_CSUM6_TX);
 #if IS_ENABLED(CONFIG_IPV6)
-		local_ip = vxlan->cfg.saddr;
-		label = vxlan->cfg.label;
+		key.label = vxlan->cfg.label;
 #endif
 	} else {
 		if (!info) {
@@ -2451,17 +2387,8 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 				  dev->name);
 			goto drop;
 		}
-		remote_ip.sa.sa_family = ip_tunnel_info_af(info);
-		if (remote_ip.sa.sa_family == AF_INET) {
-			remote_ip.sin.sin_addr.s_addr = info->key.u.ipv4.dst;
-		} else {
-			remote_ip.sin6.sin6_addr = info->key.u.ipv6.dst;
-#if IS_ENABLED(CONFIG_IPV6)
-			local_ip.sin6.sin6_addr = info->key.u.ipv6.src;
-#endif
-		}
-		dst = &remote_ip;
 		pkey = &info->key;
+		addr_family = ip_tunnel_info_af(info);
 		dst_port = info->key.tp_dst ? : vxlan->cfg.dst_port;
 		vni = tunnel_id_to_key32(info->key.tun_id);
 		ifindex = 0;
@@ -2473,16 +2400,13 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 		}
 		ttl = info->key.ttl;
 		tos = info->key.tos;
-#if IS_ENABLED(CONFIG_IPV6)
-		label = info->key.label;
-#endif
 		udp_sum = !!(info->key.tun_flags & TUNNEL_CSUM);
 	}
 	src_port = udp_flow_src_port(dev_net(dev), skb, vxlan->cfg.port_min,
 				     vxlan->cfg.port_max, true);
 
 	rcu_read_lock();
-	if (dst->sa.sa_family == AF_INET) {
+	if (addr_family == AF_INET) {
 		struct vxlan_sock *sock4 = rcu_dereference(vxlan->vn4_sock);
 		struct rtable *rt;
 		__be16 df = 0;
@@ -2501,7 +2425,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 
 		if (!info) {
 			/* Bypass encapsulation if the destination is local */
-			err = encap_bypass_if_local(skb, dev, vxlan, dst,
+			err = encap_bypass_if_local(skb, dev, vxlan, AF_INET,
 						    dst_port, ifindex, vni,
 						    &rt->dst, rt->rt_flags);
 			if (err)
@@ -2555,15 +2479,15 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 #if IS_ENABLED(CONFIG_IPV6)
 	} else {
 		struct vxlan_sock *sock6 = rcu_dereference(vxlan->vn6_sock);
+		struct in6_addr saddr;
 
 		if (!ifindex)
 			ifindex = sock6->sock->sk->sk_bound_dev_if;
 
-		ndst = vxlan6_get_route(vxlan, dev, sock6, skb, ifindex, tos,
-					label, &dst->sin6.sin6_addr,
-					&local_ip.sin6.sin6_addr,
-					dst_port, src_port,
-					dst_cache, info);
+		ndst = udp_tunnel6_dst_lookup(skb, dev, vxlan->net, sock6->sock,
+					      ifindex, &saddr, pkey,
+					      src_port, dst_port, tos,
+					      use_cache ? dst_cache : NULL);
 		if (IS_ERR(ndst)) {
 			err = PTR_ERR(ndst);
 			ndst = NULL;
@@ -2573,7 +2497,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 		if (!info) {
 			u32 rt6i_flags = ((struct rt6_info *)ndst)->rt6i_flags;
 
-			err = encap_bypass_if_local(skb, dev, vxlan, dst,
+			err = encap_bypass_if_local(skb, dev, vxlan, AF_INET6,
 						    dst_port, ifindex, vni,
 						    ndst, rt6i_flags);
 			if (err)
@@ -2588,16 +2512,13 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 		} else if (err) {
 			if (info) {
 				struct ip_tunnel_info *unclone;
-				struct in6_addr src, dst;
 
 				unclone = skb_tunnel_info_unclone(skb);
 				if (unlikely(!unclone))
 					goto tx_error;
 
-				src = remote_ip.sin6.sin6_addr;
-				dst = local_ip.sin6.sin6_addr;
-				unclone->key.u.ipv6.src = src;
-				unclone->key.u.ipv6.dst = dst;
+				unclone->key.u.ipv6.src = pkey->u.ipv6.dst;
+				unclone->key.u.ipv6.dst = saddr;
 			}
 
 			vxlan_encap_bypass(skb, vxlan, vxlan, vni, false);
@@ -2614,9 +2535,8 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 			goto tx_error;
 
 		udp_tunnel6_xmit_skb(ndst, sock6->sock->sk, skb, dev,
-				     &local_ip.sin6.sin6_addr,
-				     &dst->sin6.sin6_addr, tos, ttl,
-				     label, src_port, dst_port, !udp_sum);
+				     &saddr, &pkey->u.ipv6.dst, tos, ttl,
+				     pkey->label, src_port, dst_port, !udp_sum);
 #endif
 	}
 	vxlan_vnifilter_count(vxlan, vni, NULL, VXLAN_VNI_STATS_TX, pkt_len);
@@ -3267,10 +3187,14 @@ static int vxlan_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb)
 		struct vxlan_sock *sock6 = rcu_dereference(vxlan->vn6_sock);
 		struct dst_entry *ndst;
 
-		ndst = vxlan6_get_route(vxlan, dev, sock6, skb, 0, info->key.tos,
-					info->key.label, &info->key.u.ipv6.dst,
-					&info->key.u.ipv6.src, dport, sport,
-					&info->dst_cache, info);
+		if (!sock6)
+			return -EIO;
+
+		ndst = udp_tunnel6_dst_lookup(skb, dev, vxlan->net, sock6->sock,
+					      0, &info->key.u.ipv6.src,
+					      &info->key,
+					      sport, dport, info->key.tos,
+					      &info->dst_cache);
 		if (IS_ERR(ndst))
 			return PTR_ERR(ndst);
 		dst_release(ndst);
-- 
2.40.1

