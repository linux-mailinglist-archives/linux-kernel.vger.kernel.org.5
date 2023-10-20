Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA967D0F32
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 13:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377297AbjJTLzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 07:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377172AbjJTLzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 07:55:52 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C291A4;
        Fri, 20 Oct 2023 04:55:50 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9bdf5829000so115266966b.0;
        Fri, 20 Oct 2023 04:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697802949; x=1698407749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LJaq2EZd8Vvzu5pwf4n3wyGJ15uytfaOKajlHE8rtbc=;
        b=lPCqcA97rdWCqxfKR3YIo06CE03BvkWabXPmI46iqWHXHq10r17ex84wWU43XFzF4Z
         TBEH23XB86VO1MnrDqSRYEEoSxkcHwAJf0RFbzEwAUR7WjrZZiwYXA56SMteUhrMPLo4
         qk0SEwzRt0XW9sxnSu21BQGCEEa2BQVGEqHbLZKjKY2td6BxUj/7l6xvPmz3xBbyPVrC
         KQ21i4jNv6tDAJlzI8A8wDxWtRhhyz7/9rCpJ5l+Cii6RsdaisYyT0DId+NB3H+M6VOn
         aEAUtqxwNUu+CcvXD0trUtifeLGeER6iI0AyOfZzJU4lqyBOH2uQ/CkCDe4NIXqXCxKY
         aAEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697802949; x=1698407749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LJaq2EZd8Vvzu5pwf4n3wyGJ15uytfaOKajlHE8rtbc=;
        b=NN8P/jzAIfALxJBBFu0dU27TYaji1K6ddTrMO+BZ22KfUZFCIKJuxkyhfj/LBvcxNI
         WSP8PAVXvRiVTjv6NjghyFw4EX7Q701vBuhKEkqSvShiHUJO3TsDKPqtTl21kx+Qzhox
         omyelFovIgMB9dMnrEMtAir1YdtbUJhU9ukzcI770l4HQbF8hnCLRW9NOxpCtr46khZU
         8UMj2fSPoFzU0oZBTd9Ig9M3iG4/ZHbteA/t6VHFc1PnymN7mKIYXUiquzjORSe4Estr
         JRVje9LHx9kIsBUQ+0Bhby5+ipFvep15qWvXRDXIgGoX/gwNlkutIf/bjHUtEcLuR0N8
         Bu2A==
X-Gm-Message-State: AOJu0YzCVIkqe4psan2Cl/G3Zn9iTyfgokzV5F56MfnRvvsgQsYcDVYB
        mkgZWy5yk69d6G1u1RGQeU6blM+b3LQkrQ==
X-Google-Smtp-Source: AGHT+IF68nYXdfN14OvlpSZ8dKhEnaeTP081JrfHwfsIdkKCSTXCf+r4cSehaRRr9pGDnmJJyFwxPA==
X-Received: by 2002:a17:907:6e91:b0:9a1:f81f:d0d5 with SMTP id sh17-20020a1709076e9100b009a1f81fd0d5mr1432843ejc.54.1697802948512;
        Fri, 20 Oct 2023 04:55:48 -0700 (PDT)
Received: from tp.home.arpa (host-95-239-66-218.retail.telecomitalia.it. [95.239.66.218])
        by smtp.gmail.com with ESMTPSA id v21-20020a170906489500b009b928eb8dd3sm1342014ejq.163.2023.10.20.04.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 04:55:48 -0700 (PDT)
From:   Beniamino Galvani <b.galvani@gmail.com>
To:     netdev@vger.kernel.org
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Guillaume Nault <gnault@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/5] ipv6: rename and move ip6_dst_lookup_tunnel()
Date:   Fri, 20 Oct 2023 13:55:25 +0200
Message-Id: <20231020115529.3344878-2-b.galvani@gmail.com>
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

At the moment ip6_dst_lookup_tunnel() is used only by bareudp.
Ideally, other UDP tunnel implementations should use it, but to do so
the function needs to accept new parameters that are specific for UDP
tunnels, such as the ports.

Prepare for these changes by renaming the function to
udp_tunnel6_dst_lookup() and move it to file
net/ipv6/ip6_udp_tunnel.c.

This is similar to what already done for IPv4 in commit bf3fcbf7e7a0
("ipv4: rename and move ip_route_output_tunnel()").

Suggested-by: Guillaume Nault <gnault@redhat.com>
Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
---
 drivers/net/bareudp.c     | 10 +++---
 include/net/ipv6.h        |  6 ----
 include/net/udp_tunnel.h  |  7 ++++
 net/ipv6/ip6_output.c     | 68 --------------------------------------
 net/ipv6/ip6_udp_tunnel.c | 69 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 81 insertions(+), 79 deletions(-)

diff --git a/drivers/net/bareudp.c b/drivers/net/bareudp.c
index 47a9c2a5583c..9a0a1a9f6cfe 100644
--- a/drivers/net/bareudp.c
+++ b/drivers/net/bareudp.c
@@ -371,8 +371,8 @@ static int bareudp6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	if (!sock)
 		return -ESHUTDOWN;
 
-	dst = ip6_dst_lookup_tunnel(skb, dev, bareudp->net, sock, &saddr, info,
-				    IPPROTO_UDP, use_cache);
+	dst = udp_tunnel6_dst_lookup(skb, dev, bareudp->net, sock, &saddr, info,
+				     IPPROTO_UDP, use_cache);
 	if (IS_ERR(dst))
 		return PTR_ERR(dst);
 
@@ -498,9 +498,9 @@ static int bareudp_fill_metadata_dst(struct net_device *dev,
 		struct in6_addr saddr;
 		struct socket *sock = rcu_dereference(bareudp->sock);
 
-		dst = ip6_dst_lookup_tunnel(skb, dev, bareudp->net, sock,
-					    &saddr, info, IPPROTO_UDP,
-					    use_cache);
+		dst = udp_tunnel6_dst_lookup(skb, dev, bareudp->net, sock,
+					     &saddr, info, IPPROTO_UDP,
+					     use_cache);
 		if (IS_ERR(dst))
 			return PTR_ERR(dst);
 
diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index b3444c8a6f74..78d38dd88aba 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -1133,12 +1133,6 @@ struct dst_entry *ip6_dst_lookup_flow(struct net *net, const struct sock *sk, st
 struct dst_entry *ip6_sk_dst_lookup_flow(struct sock *sk, struct flowi6 *fl6,
 					 const struct in6_addr *final_dst,
 					 bool connected);
-struct dst_entry *ip6_dst_lookup_tunnel(struct sk_buff *skb,
-					struct net_device *dev,
-					struct net *net, struct socket *sock,
-					struct in6_addr *saddr,
-					const struct ip_tunnel_info *info,
-					u8 protocol, bool use_cache);
 struct dst_entry *ip6_blackhole_route(struct net *net,
 				      struct dst_entry *orig_dst);
 
diff --git a/include/net/udp_tunnel.h b/include/net/udp_tunnel.h
index 4d0578fab01a..1dac296d8449 100644
--- a/include/net/udp_tunnel.h
+++ b/include/net/udp_tunnel.h
@@ -169,6 +169,13 @@ struct rtable *udp_tunnel_dst_lookup(struct sk_buff *skb,
 				     const struct ip_tunnel_key *key,
 				     __be16 sport, __be16 dport, u8 tos,
 				     struct dst_cache *dst_cache);
+struct dst_entry *udp_tunnel6_dst_lookup(struct sk_buff *skb,
+					 struct net_device *dev,
+					 struct net *net,
+					 struct socket *sock,
+					 struct in6_addr *saddr,
+					 const struct ip_tunnel_info *info,
+					 u8 protocol, bool use_cache);
 
 struct metadata_dst *udp_tun_rx_dst(struct sk_buff *skb, unsigned short family,
 				    __be16 flags, __be64 tunnel_id,
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index a471c7e91761..6df8b13d4595 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1281,74 +1281,6 @@ struct dst_entry *ip6_sk_dst_lookup_flow(struct sock *sk, struct flowi6 *fl6,
 }
 EXPORT_SYMBOL_GPL(ip6_sk_dst_lookup_flow);
 
-/**
- *      ip6_dst_lookup_tunnel - perform route lookup on tunnel
- *      @skb: Packet for which lookup is done
- *      @dev: Tunnel device
- *      @net: Network namespace of tunnel device
- *      @sock: Socket which provides route info
- *      @saddr: Memory to store the src ip address
- *      @info: Tunnel information
- *      @protocol: IP protocol
- *      @use_cache: Flag to enable cache usage
- *      This function performs a route lookup on a tunnel
- *
- *      It returns a valid dst pointer and stores src address to be used in
- *      tunnel in param saddr on success, else a pointer encoded error code.
- */
-
-struct dst_entry *ip6_dst_lookup_tunnel(struct sk_buff *skb,
-					struct net_device *dev,
-					struct net *net,
-					struct socket *sock,
-					struct in6_addr *saddr,
-					const struct ip_tunnel_info *info,
-					u8 protocol,
-					bool use_cache)
-{
-	struct dst_entry *dst = NULL;
-#ifdef CONFIG_DST_CACHE
-	struct dst_cache *dst_cache;
-#endif
-	struct flowi6 fl6;
-	__u8 prio;
-
-#ifdef CONFIG_DST_CACHE
-	dst_cache = (struct dst_cache *)&info->dst_cache;
-	if (use_cache) {
-		dst = dst_cache_get_ip6(dst_cache, saddr);
-		if (dst)
-			return dst;
-	}
-#endif
-	memset(&fl6, 0, sizeof(fl6));
-	fl6.flowi6_mark = skb->mark;
-	fl6.flowi6_proto = protocol;
-	fl6.daddr = info->key.u.ipv6.dst;
-	fl6.saddr = info->key.u.ipv6.src;
-	prio = info->key.tos;
-	fl6.flowlabel = ip6_make_flowinfo(prio, info->key.label);
-
-	dst = ipv6_stub->ipv6_dst_lookup_flow(net, sock->sk, &fl6,
-					      NULL);
-	if (IS_ERR(dst)) {
-		netdev_dbg(dev, "no route to %pI6\n", &fl6.daddr);
-		return ERR_PTR(-ENETUNREACH);
-	}
-	if (dst->dev == dev) { /* is this necessary? */
-		netdev_dbg(dev, "circular route to %pI6\n", &fl6.daddr);
-		dst_release(dst);
-		return ERR_PTR(-ELOOP);
-	}
-#ifdef CONFIG_DST_CACHE
-	if (use_cache)
-		dst_cache_set_ip6(dst_cache, dst, &fl6.saddr);
-#endif
-	*saddr = fl6.saddr;
-	return dst;
-}
-EXPORT_SYMBOL_GPL(ip6_dst_lookup_tunnel);
-
 static inline struct ipv6_opt_hdr *ip6_opt_dup(struct ipv6_opt_hdr *src,
 					       gfp_t gfp)
 {
diff --git a/net/ipv6/ip6_udp_tunnel.c b/net/ipv6/ip6_udp_tunnel.c
index 70d38705c92f..fc122abf6b75 100644
--- a/net/ipv6/ip6_udp_tunnel.c
+++ b/net/ipv6/ip6_udp_tunnel.c
@@ -1,3 +1,4 @@
+
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/module.h>
 #include <linux/errno.h>
@@ -112,4 +113,72 @@ int udp_tunnel6_xmit_skb(struct dst_entry *dst, struct sock *sk,
 }
 EXPORT_SYMBOL_GPL(udp_tunnel6_xmit_skb);
 
+/**
+ *      udp_tunnel6_dst_lookup - perform route lookup on UDP tunnel
+ *      @skb: Packet for which lookup is done
+ *      @dev: Tunnel device
+ *      @net: Network namespace of tunnel device
+ *      @sock: Socket which provides route info
+ *      @saddr: Memory to store the src ip address
+ *      @info: Tunnel information
+ *      @protocol: IP protocol
+ *      @use_cache: Flag to enable cache usage
+ *      This function performs a route lookup on a UDP tunnel
+ *
+ *      It returns a valid dst pointer and stores src address to be used in
+ *      tunnel in param saddr on success, else a pointer encoded error code.
+ */
+
+struct dst_entry *udp_tunnel6_dst_lookup(struct sk_buff *skb,
+					 struct net_device *dev,
+					 struct net *net,
+					 struct socket *sock,
+					 struct in6_addr *saddr,
+					 const struct ip_tunnel_info *info,
+					 u8 protocol,
+					 bool use_cache)
+{
+	struct dst_entry *dst = NULL;
+#ifdef CONFIG_DST_CACHE
+	struct dst_cache *dst_cache;
+#endif
+	struct flowi6 fl6;
+	__u8 prio;
+
+#ifdef CONFIG_DST_CACHE
+	dst_cache = (struct dst_cache *)&info->dst_cache;
+	if (use_cache) {
+		dst = dst_cache_get_ip6(dst_cache, saddr);
+		if (dst)
+			return dst;
+	}
+#endif
+	memset(&fl6, 0, sizeof(fl6));
+	fl6.flowi6_mark = skb->mark;
+	fl6.flowi6_proto = protocol;
+	fl6.daddr = info->key.u.ipv6.dst;
+	fl6.saddr = info->key.u.ipv6.src;
+	prio = info->key.tos;
+	fl6.flowlabel = ip6_make_flowinfo(prio, info->key.label);
+
+	dst = ipv6_stub->ipv6_dst_lookup_flow(net, sock->sk, &fl6,
+					      NULL);
+	if (IS_ERR(dst)) {
+		netdev_dbg(dev, "no route to %pI6\n", &fl6.daddr);
+		return ERR_PTR(-ENETUNREACH);
+	}
+	if (dst->dev == dev) { /* is this necessary? */
+		netdev_dbg(dev, "circular route to %pI6\n", &fl6.daddr);
+		dst_release(dst);
+		return ERR_PTR(-ELOOP);
+	}
+#ifdef CONFIG_DST_CACHE
+	if (use_cache)
+		dst_cache_set_ip6(dst_cache, dst, &fl6.saddr);
+#endif
+	*saddr = fl6.saddr;
+	return dst;
+}
+EXPORT_SYMBOL_GPL(udp_tunnel6_dst_lookup);
+
 MODULE_LICENSE("GPL");
-- 
2.40.1

