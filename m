Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86FA57BD531
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 10:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234473AbjJII0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 04:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234381AbjJII0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 04:26:23 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3061C6;
        Mon,  9 Oct 2023 01:26:19 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-523100882f2so6873234a12.2;
        Mon, 09 Oct 2023 01:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696839978; x=1697444778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0s72RvFaniS1wfJfHEoKR77J7vnemSkLaDM40NAQW2o=;
        b=FPfTd4+GRXgspQ3JqMupsmFfN2ShR/ex+awMbXDeWhuOWVwTRbR1wg9QvrkEaz5al2
         RlcSU4fXx93CV/lmTy7plcej+v1nvaJbH9sv2tF4WwfWgUqPkImgXuE1Ye5q2aLaBqyB
         /poYEDodrA+mhDF9ozhCNSek4+h8DfsegUbJKZCpNQl4rtL5UCWZyiM/NmW8i9dnC5sB
         s+fQciwN5MRBuz5a5UmBjMAN35NVQPzd0QM/aJYf+BLsuUX9pEdwuMcaTIgE4XyYH5w2
         AX8KTXgi6dX0l/yd9exrsSOJFezW9s81pq6AoG/lJQX+3HnI8iLHP6Dbx80IbIA92uN1
         4tLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696839978; x=1697444778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0s72RvFaniS1wfJfHEoKR77J7vnemSkLaDM40NAQW2o=;
        b=poFkYWc2jiofF3jKhYo95ZdV+jLLZEfhQF9WrQYHDqoo9cmeoGC1f9m8qvNr2Lh6Vd
         a/A8EobOLVM7SJjBEtVX6APYef6NvNrqtps+bcxm8Qf/eMC9C0b4NcN+HRK1x0uG3bD6
         JpfOg9S4Pd7WAf5CaQr498koOS+cMWli0AatlHvTPqrJcGQFt3GWep8UDNuQTMnpMEhk
         D411n8bXUcHLdakWrx/1MyFCFH8wqSjzWYODzzAStb3w0t0EL9D+ekn9LJ2I/R/yn7Xa
         n6LLZD94Nap223dwOv/1dPPI0OkSR61xTfcXZlzPoaYFJKecW2x8Yk0G8R8dfOihp4JZ
         KFhw==
X-Gm-Message-State: AOJu0Yz8Xwaq3JXIgeC03zDgBKdUi19NZEN3mZngCcnD5YbyfVY37sIq
        j97acqeRQaU7Yll99Woc82Po102DE6E=
X-Google-Smtp-Source: AGHT+IGz4lnMXkPUjcJhuJkK/48YNj8mmmLRaYwQnfMeRbn2qj6bKzFMeuQNlPU7LGxs5OX3vvil0Q==
X-Received: by 2002:aa7:cf92:0:b0:523:102f:3ce1 with SMTP id z18-20020aa7cf92000000b00523102f3ce1mr12742705edx.10.1696839978291;
        Mon, 09 Oct 2023 01:26:18 -0700 (PDT)
Received: from tp.home.arpa (host-79-24-102-58.retail.telecomitalia.it. [79.24.102.58])
        by smtp.gmail.com with ESMTPSA id p22-20020a05640210d600b00530a9488623sm5844810edu.46.2023.10.09.01.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 01:26:18 -0700 (PDT)
From:   Beniamino Galvani <b.galvani@gmail.com>
To:     netdev@vger.kernel.org
Cc:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Guillaume Nault <gnault@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 7/7] vxlan: use generic function for tunnel IPv4 route lookup
Date:   Mon,  9 Oct 2023 10:20:59 +0200
Message-Id: <20231009082059.2500217-8-b.galvani@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231009082059.2500217-1-b.galvani@gmail.com>
References: <20231009082059.2500217-1-b.galvani@gmail.com>
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
 drivers/net/vxlan/vxlan_core.c | 103 +++++++++++----------------------
 1 file changed, 35 insertions(+), 68 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 5b5597073b00..a37a84fae64e 100644
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
@@ -2418,6 +2367,8 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 {
 	struct dst_cache *dst_cache;
 	struct ip_tunnel_info *info;
+	struct ip_tunnel_key *pkey;
+	struct ip_tunnel_key key;
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	const struct iphdr *old_iph = ip_hdr(skb);
 	union vxlan_addr *dst;
@@ -2431,6 +2382,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 	int ifindex;
 	int err;
 	u32 flags = vxlan->cfg.flags;
+	bool use_cache;
 	bool udp_sum = false;
 	bool xnet = !net_eq(vxlan->net, dev_net(vxlan->dev));
 	__be32 vni = 0;
@@ -2439,9 +2391,13 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
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
@@ -2456,6 +2412,15 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 		vni = (rdst->remote_vni) ? : default_vni;
 		ifindex = rdst->remote_ifindex;
 		local_ip = vxlan->cfg.saddr;
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
@@ -2469,6 +2434,8 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 		tos = vxlan->cfg.tos;
 		if (tos == 1)
 			tos = ip_tunnel_get_dsfield(old_iph, skb);
+		if (tos && !info)
+			use_cache = false;
 
 		if (dst->sa.sa_family == AF_INET)
 			udp_sum = !(flags & VXLAN_F_UDP_ZERO_CSUM_TX);
@@ -2492,6 +2459,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 			local_ip.sin6.sin6_addr = info->key.u.ipv6.src;
 		}
 		dst = &remote_ip;
+		pkey = &info->key;
 		dst_port = info->key.tp_dst ? : vxlan->cfg.dst_port;
 		flow_flags = info->key.flow_flags;
 		vni = tunnel_id_to_key32(info->key.tun_id);
@@ -2517,15 +2485,14 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
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
@@ -2561,16 +2528,13 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
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
@@ -2584,8 +2548,8 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 		if (err < 0)
 			goto tx_error;
 
-		udp_tunnel_xmit_skb(rt, sock4->sock->sk, skb, local_ip.sin.sin_addr.s_addr,
-				    dst->sin.sin_addr.s_addr, tos, ttl, df,
+		udp_tunnel_xmit_skb(rt, sock4->sock->sk, skb, saddr,
+				    pkey->u.ipv4.dst, tos, ttl, df,
 				    src_port, dst_port, xnet, !udp_sum);
 #if IS_ENABLED(CONFIG_IPV6)
 	} else {
@@ -3100,11 +3064,14 @@ static int vxlan_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb)
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

