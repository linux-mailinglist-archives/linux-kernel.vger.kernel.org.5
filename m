Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6C67CA056
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 09:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbjJPHQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 03:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbjJPHPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 03:15:43 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32130C5;
        Mon, 16 Oct 2023 00:15:40 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9b95622c620so724950066b.0;
        Mon, 16 Oct 2023 00:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697440538; x=1698045338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+piV4V+155N0PYjpX7WLcNDOIPRKVVrWUBBzKuXjFtg=;
        b=GiwSbH9nVLo4+lkj77+zqwWKvh2wFkcRklgSEmXSCHin1IEIWGkYMOnb2sd2aBsxOT
         re+r0vxLOYr8uFy6LzwPj7ywHBw0s7WGQ7uCCW4MPTg+K+HYX4KsoB22PUG+1UxUmXXg
         6XZBvZvZPQnCp/Wgi+aX9EofCZnX+W9BL7p5NK5ZDiokyzzfbcju5FBXaWs3RqdpYjzg
         x58cO3jPdPTeO1R6LXwnTqGixezV/wh8Y6tELC9OZ9dFXkZy9h6UTjApC0VSHjffkS69
         7NW8t+BGH6jljG9x4f+VOEi5j5c0EiHpl1aJnEkTger1vVC9x70Ko58oYzX/WKqSOg/q
         /CAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697440538; x=1698045338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+piV4V+155N0PYjpX7WLcNDOIPRKVVrWUBBzKuXjFtg=;
        b=fL72DRnC4isvtHGX6HYYj6pIxR0GZ8TMaR1ayRYDzhfAicbzDZ7O1qEJtDJqRFhWid
         8mdowdxtlT8f91ZJ292opbJh/zZWX+rLcMLFuPTPvDweJtujqYUrRUaUxi/raCaiCS34
         xCDn5QUl3yWg5o99xlf/Hl72JWCE49tO1hxO3p8toudQBkbXW44Mu/ggIJd1dSJbYL3P
         6Z31a1VewodH1JIBoOkXKKLzZZdQVsHJvUVse9aTiVZXQC8nPfMuiTssGxQlRY7l+jZO
         +LbeWCR6qEo4hdP8Ocd/ulr5d70pQBanpicFZWdNmSPaoZxzxCQuqNDgagoXRljIoE52
         s0EQ==
X-Gm-Message-State: AOJu0YxDVinfGMvKabKHJpHwTQ4xGSBY1s6owm5BgvSUDUHOU1jt4fd7
        bgOtphx9Wl9TjGIvDGd7YFPphevzjsI=
X-Google-Smtp-Source: AGHT+IE0FBAmVG1OJuFZ+frDZkx36Un+ZacvONLv6wZR8MG89JwwI6ksIlfWXGTaPOQWf1pMs3SaJg==
X-Received: by 2002:a17:906:1d4:b0:9bd:7f40:caa5 with SMTP id 20-20020a17090601d400b009bd7f40caa5mr11482508ejj.77.1697440538422;
        Mon, 16 Oct 2023 00:15:38 -0700 (PDT)
Received: from tp.home.arpa (host-79-55-64-40.retail.telecomitalia.it. [79.55.64.40])
        by smtp.gmail.com with ESMTPSA id jl25-20020a17090775d900b00992e265495csm3419471ejc.212.2023.10.16.00.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 00:15:38 -0700 (PDT)
From:   Beniamino Galvani <b.galvani@gmail.com>
To:     netdev@vger.kernel.org
Cc:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Guillaume Nault <gnault@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 7/7] vxlan: use generic function for tunnel IPv4 route lookup
Date:   Mon, 16 Oct 2023 09:15:26 +0200
Message-Id: <20231016071526.2958108-8-b.galvani@gmail.com>
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

The route lookup can be done now via generic function
udp_tunnel_dst_lookup() to replace the custom implementations in
vxlan_get_route().

Note that this patch only touches IPv4, while IPv6 still uses
vxlan6_get_route(). After IPv6 route lookup gets converted as well,
vxlan_xmit_one() can be simplified by removing local variables that
will be passed via "struct ip_tunnel_key", such as remote_ip,
local_ip, flow_flags, label.

Suggested-by: Guillaume Nault <gnault@redhat.com>
Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
---
 drivers/net/vxlan/vxlan_core.c | 114 ++++++++++++---------------------
 1 file changed, 41 insertions(+), 73 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index ece377b1b6bd..6f7d45e3cfa2 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2215,57 +2215,6 @@ static int vxlan_build_skb(struct sk_buff *skb, struct dst_entry *dst,
 	return 0;
 }
 
-static struct rtable *vxlan_get_route(struct vxlan_dev *vxlan, struct net_device *dev,
-				      struct vxlan_sock *sock4,
-				      struct sk_buff *skb, int oif, u8 tos,
-				      __be32 daddr, __be32 *saddr, __be16 dport, __be16 sport,
-				      __u8 flow_flags, struct dst_cache *dst_cache,
-				      const struct ip_tunnel_info *info)
-{
-	bool use_cache = ip_tunnel_dst_cache_usable(skb, info);
-	struct rtable *rt = NULL;
-	struct flowi4 fl4;
-
-	if (!sock4)
-		return ERR_PTR(-EIO);
-
-	if (tos && !info)
-		use_cache = false;
-	if (use_cache) {
-		rt = dst_cache_get_ip4(dst_cache, saddr);
-		if (rt)
-			return rt;
-	}
-
-	memset(&fl4, 0, sizeof(fl4));
-	fl4.flowi4_oif = oif;
-	fl4.flowi4_tos = RT_TOS(tos);
-	fl4.flowi4_mark = skb->mark;
-	fl4.flowi4_proto = IPPROTO_UDP;
-	fl4.daddr = daddr;
-	fl4.saddr = *saddr;
-	fl4.fl4_dport = dport;
-	fl4.fl4_sport = sport;
-	fl4.flowi4_flags = flow_flags;
-
-	rt = ip_route_output_key(vxlan->net, &fl4);
-	if (!IS_ERR(rt)) {
-		if (rt->dst.dev == dev) {
-			netdev_dbg(dev, "circular route to %pI4\n", &daddr);
-			ip_rt_put(rt);
-			return ERR_PTR(-ELOOP);
-		}
-
-		*saddr = fl4.saddr;
-		if (use_cache)
-			dst_cache_set_ip4(dst_cache, &rt->dst, fl4.saddr);
-	} else {
-		netdev_dbg(dev, "no route to %pI4\n", &daddr);
-		return ERR_PTR(-ENETUNREACH);
-	}
-	return rt;
-}
-
 #if IS_ENABLED(CONFIG_IPV6)
 static struct dst_entry *vxlan6_get_route(struct vxlan_dev *vxlan,
 					  struct net_device *dev,
@@ -2418,30 +2367,38 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 {
 	struct dst_cache *dst_cache;
 	struct ip_tunnel_info *info;
+	struct ip_tunnel_key *pkey;
+	struct ip_tunnel_key key;
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	const struct iphdr *old_iph = ip_hdr(skb);
 	union vxlan_addr *dst;
-	union vxlan_addr remote_ip, local_ip;
+	union vxlan_addr remote_ip;
 	struct vxlan_metadata _md;
 	struct vxlan_metadata *md = &_md;
 	unsigned int pkt_len = skb->len;
 	__be16 src_port = 0, dst_port;
 	struct dst_entry *ndst = NULL;
-	__u8 tos, ttl, flow_flags = 0;
+	__u8 tos, ttl;
 	int ifindex;
 	int err;
 	u32 flags = vxlan->cfg.flags;
+	bool use_cache;
 	bool udp_sum = false;
 	bool xnet = !net_eq(vxlan->net, dev_net(vxlan->dev));
 	__be32 vni = 0;
 #if IS_ENABLED(CONFIG_IPV6)
+	union vxlan_addr local_ip;
 	__be32 label;
 #endif
 
 	info = skb_tunnel_info(skb);
+	use_cache = ip_tunnel_dst_cache_usable(skb, info);
 
 	if (rdst) {
 		dst = &rdst->remote_ip;
+		memset(&key, 0, sizeof(key));
+		pkey = &key;
+
 		if (vxlan_addr_any(dst)) {
 			if (did_rsc) {
 				/* short-circuited back to local bridge */
@@ -2455,7 +2412,15 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 		dst_port = rdst->remote_port ? rdst->remote_port : vxlan->cfg.dst_port;
 		vni = (rdst->remote_vni) ? : default_vni;
 		ifindex = rdst->remote_ifindex;
-		local_ip = vxlan->cfg.saddr;
+
+		if (dst->sa.sa_family == AF_INET) {
+			key.u.ipv4.src = vxlan->cfg.saddr.sin.sin_addr.s_addr;
+			key.u.ipv4.dst = rdst->remote_ip.sin.sin_addr.s_addr;
+		} else {
+			key.u.ipv6.src = vxlan->cfg.saddr.sin6.sin6_addr;
+			key.u.ipv6.dst = rdst->remote_ip.sin6.sin6_addr;
+		}
+
 		dst_cache = &rdst->dst_cache;
 		md->gbp = skb->mark;
 		if (flags & VXLAN_F_TTL_INHERIT) {
@@ -2469,12 +2434,15 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 		tos = vxlan->cfg.tos;
 		if (tos == 1)
 			tos = ip_tunnel_get_dsfield(old_iph, skb);
+		if (tos && !info)
+			use_cache = false;
 
 		if (dst->sa.sa_family == AF_INET)
 			udp_sum = !(flags & VXLAN_F_UDP_ZERO_CSUM_TX);
 		else
 			udp_sum = !(flags & VXLAN_F_UDP_ZERO_CSUM6_TX);
 #if IS_ENABLED(CONFIG_IPV6)
+		local_ip = vxlan->cfg.saddr;
 		label = vxlan->cfg.label;
 #endif
 	} else {
@@ -2486,14 +2454,15 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 		remote_ip.sa.sa_family = ip_tunnel_info_af(info);
 		if (remote_ip.sa.sa_family == AF_INET) {
 			remote_ip.sin.sin_addr.s_addr = info->key.u.ipv4.dst;
-			local_ip.sin.sin_addr.s_addr = info->key.u.ipv4.src;
 		} else {
 			remote_ip.sin6.sin6_addr = info->key.u.ipv6.dst;
+#if IS_ENABLED(CONFIG_IPV6)
 			local_ip.sin6.sin6_addr = info->key.u.ipv6.src;
+#endif
 		}
 		dst = &remote_ip;
+		pkey = &info->key;
 		dst_port = info->key.tp_dst ? : vxlan->cfg.dst_port;
-		flow_flags = info->key.flow_flags;
 		vni = tunnel_id_to_key32(info->key.tun_id);
 		ifindex = 0;
 		dst_cache = &info->dst_cache;
@@ -2517,15 +2486,14 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 		struct vxlan_sock *sock4 = rcu_dereference(vxlan->vn4_sock);
 		struct rtable *rt;
 		__be16 df = 0;
+		__be32 saddr;
 
 		if (!ifindex)
 			ifindex = sock4->sock->sk->sk_bound_dev_if;
 
-		rt = vxlan_get_route(vxlan, dev, sock4, skb, ifindex, tos,
-				     dst->sin.sin_addr.s_addr,
-				     &local_ip.sin.sin_addr.s_addr,
-				     dst_port, src_port, flow_flags,
-				     dst_cache, info);
+		rt = udp_tunnel_dst_lookup(skb, dev, vxlan->net, ifindex,
+					   &saddr, pkey, src_port, dst_port,
+					   tos, use_cache ? dst_cache : NULL);
 		if (IS_ERR(rt)) {
 			err = PTR_ERR(rt);
 			goto tx_error;
@@ -2561,16 +2529,13 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 		} else if (err) {
 			if (info) {
 				struct ip_tunnel_info *unclone;
-				struct in_addr src, dst;
 
 				unclone = skb_tunnel_info_unclone(skb);
 				if (unlikely(!unclone))
 					goto tx_error;
 
-				src = remote_ip.sin.sin_addr;
-				dst = local_ip.sin.sin_addr;
-				unclone->key.u.ipv4.src = src.s_addr;
-				unclone->key.u.ipv4.dst = dst.s_addr;
+				unclone->key.u.ipv4.src = pkey->u.ipv4.dst;
+				unclone->key.u.ipv4.dst = saddr;
 			}
 			vxlan_encap_bypass(skb, vxlan, vxlan, vni, false);
 			dst_release(ndst);
@@ -2584,8 +2549,8 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 		if (err < 0)
 			goto tx_error;
 
-		udp_tunnel_xmit_skb(rt, sock4->sock->sk, skb, local_ip.sin.sin_addr.s_addr,
-				    dst->sin.sin_addr.s_addr, tos, ttl, df,
+		udp_tunnel_xmit_skb(rt, sock4->sock->sk, skb, saddr,
+				    pkey->u.ipv4.dst, tos, ttl, df,
 				    src_port, dst_port, xnet, !udp_sum);
 #if IS_ENABLED(CONFIG_IPV6)
 	} else {
@@ -3286,11 +3251,14 @@ static int vxlan_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb)
 		struct vxlan_sock *sock4 = rcu_dereference(vxlan->vn4_sock);
 		struct rtable *rt;
 
-		rt = vxlan_get_route(vxlan, dev, sock4, skb, 0, info->key.tos,
-				     info->key.u.ipv4.dst,
-				     &info->key.u.ipv4.src, dport, sport,
-				     info->key.flow_flags, &info->dst_cache,
-				     info);
+		if (!sock4)
+			return -EIO;
+
+		rt = udp_tunnel_dst_lookup(skb, dev, vxlan->net, 0,
+					   &info->key.u.ipv4.src,
+					   &info->key,
+					   sport, dport, info->key.tos,
+					   &info->dst_cache);
 		if (IS_ERR(rt))
 			return PTR_ERR(rt);
 		ip_rt_put(rt);
-- 
2.40.1

