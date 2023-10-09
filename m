Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6CF7BD526
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 10:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234444AbjJII0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 04:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234425AbjJII0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 04:26:18 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0062A3;
        Mon,  9 Oct 2023 01:26:15 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9ba081173a3so345776966b.1;
        Mon, 09 Oct 2023 01:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696839974; x=1697444774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Opywzopv/cnUh7Yw86K3XXL6gpkdH/O5UwAJEnT8/MY=;
        b=AioNfOgHKfpjl+LngYXQPJE+fwxO1DTyFXQbylQUl6TMxs29TkCGz4hkTcC2rL1XLQ
         gVGytWeC0Yu05XaUilVrP4RhayKZwFEkXPHPT9PTSSg2TR1Yzah+38mxH9FIb/+mcKr3
         v7Y/yFrVURCJFoo6ZFkRRULlvdD2edKfhbaDkB0xqgnZtZ44z75vvgZMnAhkcoJXpr6L
         QgIzJGFq3tAbLDXjQ0J9kuJkAFdCW4w6zdrd2wI/uS3UtoT9xjjBeRmRF4g0rIzQBqwL
         DggccEqfKyOu+8eYZ3LUE5LAWQ9lg5NoFguvZMzxkGZ85Y34gj2kyK15b1cEmZ1p0JpQ
         09Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696839974; x=1697444774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Opywzopv/cnUh7Yw86K3XXL6gpkdH/O5UwAJEnT8/MY=;
        b=Fzv5ufWa1zdogVBsAywIfiDFU0CN35HfERUtCMULNUA8VUM87Erl3v+FFmRpkUDFB4
         d2avSzb5vyjkH4XMM4w0RZBtXZk+9VdClw9xOmOqDysU4gaLxBNIMTfnwAjQCJzSZXRR
         Dcgpd6Nww4Rr8/TMsw4i4RgXGt+cbCADK7rlhEqbQaZTUU7nly7sTVeGBrKFnicoSdvN
         FiQKLl9CYZyqhCpou0vyPY5GG6QFdazq+lYo276f4FDTSwJw2t4MngqZuB0BVaqMWrA8
         F8/i0zGptWhKGZ7QDMRk4le+VPlu+8c/KJXtiT/m7M4UetqC+Um0OhTL/IgumvwMCweS
         h3Ag==
X-Gm-Message-State: AOJu0YyK16HSFkXly6RaPCa47UyxQDOvXz4T9ZhINybtq0u4Zz5zbvpc
        0YfdRqpLAkh4qsQDAN4DwkW6uWxgW8g=
X-Google-Smtp-Source: AGHT+IHKQ+URUWHDu65yyUqVpyP8fZ8v2rTvsID+c3SvKSQOU2A35ogl6EU1qLjeoRao1ZMEkIwMAw==
X-Received: by 2002:a17:906:305a:b0:9ae:5487:c71c with SMTP id d26-20020a170906305a00b009ae5487c71cmr12804086ejd.49.1696839974220;
        Mon, 09 Oct 2023 01:26:14 -0700 (PDT)
Received: from tp.home.arpa (host-79-24-102-58.retail.telecomitalia.it. [79.24.102.58])
        by smtp.gmail.com with ESMTPSA id p22-20020a05640210d600b00530a9488623sm5844810edu.46.2023.10.09.01.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 01:26:14 -0700 (PDT)
From:   Beniamino Galvani <b.galvani@gmail.com>
To:     netdev@vger.kernel.org
Cc:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Guillaume Nault <gnault@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/7] ipv4: rename and move ip_route_output_tunnel()
Date:   Mon,  9 Oct 2023 10:20:53 +0200
Message-Id: <20231009082059.2500217-2-b.galvani@gmail.com>
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

At the moment ip_route_output_tunnel() is used only by bareudp.
Ideally, other UDP tunnel implementations should use it, but to do so
the function needs to accept new parameters that are specific for UDP
tunnels, such as the ports.

Prepare for these changes by renaming the function to
udp_tunnel_dst_lookup() and move it to file
net/ipv4/udp_tunnel_core.c.

Suggested-by: Guillaume Nault <gnault@redhat.com>
Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
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

