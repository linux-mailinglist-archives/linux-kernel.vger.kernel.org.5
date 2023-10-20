Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF4C7D0F3A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 13:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377291AbjJTL4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 07:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377277AbjJTLzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 07:55:53 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD795D51;
        Fri, 20 Oct 2023 04:55:51 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9c3aec5f326so394230466b.1;
        Fri, 20 Oct 2023 04:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697802950; x=1698407750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+AZ5ktdIxmIZ0T//vBhcoP9HGHOtenHtQrb+zrnkeE8=;
        b=P9IsK8s0TPjcnGMWqdxYPaZRTDjZI7zYj+DqWjNqznJpxkMmjbjfAH8yM6HmNniROU
         z81FP4CLImQjpNGYYNKsbDn+6eoMYhFCaKw6BqKX7LCPFgQh7HI6ynSW2lstFVzr0VJX
         jTZ5zh+xqYrGk6/3Vfu1brQZG/1jg8SkxJeGqyuCuqe8o23WDN1gP319q8uooZfiQy1M
         v9llCdQWm659ZG5FzL6Mwwn7LQsKiKMmP6gddlb18A3qLBplRMHaH3gok0oEdlhnaqDo
         9tcGZX6D4LB3nlylsITnDvK+iJcYv7rf7wJc6GZ5oWIX4jlH9JEtZ4QHb69C1g7j2FTa
         s9Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697802950; x=1698407750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+AZ5ktdIxmIZ0T//vBhcoP9HGHOtenHtQrb+zrnkeE8=;
        b=t7jRRBZYRL6xgtL5wXBL504HmVqn1e0+vQH0sVshfaAcXGOb1stqQoQmc0iivdT0KQ
         aj4wnVzoNAGqkb2ATLeMLUuVFQfKy6WLxd16IHCf+PiAWN2d9wbfGo4VVY7EgPHg5WNu
         j5i2caY6weHkBHdyl/8MYM9tN/9M7JQTJmATTN9RLM6Ft8ksZ8FC4VYlKV/Kr8Re5oWY
         bUQTwHJsGCXEj7oOgkNjqIJh5yiXjR4hpg1SkYy3+Zk5BpB+AXcQkAN72jXIvVOo40LK
         2yCVoEB74V2t7Abdg2z8jxr+DRJRrg6JIUQ4QdJGhpKuSuRCUXwomJPvNq/+SI8L3Qh3
         s+QA==
X-Gm-Message-State: AOJu0YwCluYHCcZIiNS+hNf/eGZUpZ8HFmDEoZogHklvE9jUPMuKytO7
        QOwGKVeidi2yZAQ0c84d1XiggfITgGOAxQ==
X-Google-Smtp-Source: AGHT+IG/LQK2PjfUAih+Cmlbsti+riWldSkcSTZ+NZYrOpRaoVmXlB2n8qBG4EXuvoJFTYS+HTq/Hg==
X-Received: by 2002:a17:906:c14d:b0:9a9:f0e6:904e with SMTP id dp13-20020a170906c14d00b009a9f0e6904emr1274727ejc.16.1697802950144;
        Fri, 20 Oct 2023 04:55:50 -0700 (PDT)
Received: from tp.home.arpa (host-95-239-66-218.retail.telecomitalia.it. [95.239.66.218])
        by smtp.gmail.com with ESMTPSA id v21-20020a170906489500b009b928eb8dd3sm1342014ejq.163.2023.10.20.04.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 04:55:49 -0700 (PDT)
From:   Beniamino Galvani <b.galvani@gmail.com>
To:     netdev@vger.kernel.org
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Guillaume Nault <gnault@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/5] ipv6: add new arguments to udp_tunnel6_dst_lookup()
Date:   Fri, 20 Oct 2023 13:55:27 +0200
Message-Id: <20231020115529.3344878-4-b.galvani@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231020115529.3344878-1-b.galvani@gmail.com>
References: <20231020115529.3344878-1-b.galvani@gmail.com>
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

This is similar to what already done for IPv4 in commit 72fc68c6356b
("ipv4: add new arguments to udp_tunnel_dst_lookup()").

Suggested-by: Guillaume Nault <gnault@redhat.com>
Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
---
 drivers/net/bareudp.c     | 10 +++++++---
 include/net/udp_tunnel.h  |  7 ++++---
 net/ipv6/ip6_udp_tunnel.c | 33 ++++++++++++++++++---------------
 3 files changed, 29 insertions(+), 21 deletions(-)

diff --git a/drivers/net/bareudp.c b/drivers/net/bareudp.c
index 9eb5e11c09b4..9c11a0d0273b 100644
--- a/drivers/net/bareudp.c
+++ b/drivers/net/bareudp.c
@@ -371,8 +371,10 @@ static int bareudp6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	if (!sock)
 		return -ESHUTDOWN;
 
-	dst = udp_tunnel6_dst_lookup(skb, dev, bareudp->net, sock, &saddr, info,
-				     use_cache);
+	dst = udp_tunnel6_dst_lookup(skb, dev, bareudp->net, sock, 0, &saddr,
+				     key, 0, 0, key->tos,
+				     use_cache ?
+				     (struct dst_cache *) &info->dst_cache : NULL);
 	if (IS_ERR(dst))
 		return PTR_ERR(dst);
 
@@ -499,7 +501,9 @@ static int bareudp_fill_metadata_dst(struct net_device *dev,
 		struct socket *sock = rcu_dereference(bareudp->sock);
 
 		dst = udp_tunnel6_dst_lookup(skb, dev, bareudp->net, sock,
-					     &saddr, info, use_cache);
+					     0, &saddr, &info->key,
+					     0, 0, info->key.tos,
+					     use_cache ? &info->dst_cache : NULL);
 		if (IS_ERR(dst))
 			return PTR_ERR(dst);
 
diff --git a/include/net/udp_tunnel.h b/include/net/udp_tunnel.h
index 583867643bd1..d716214fe03d 100644
--- a/include/net/udp_tunnel.h
+++ b/include/net/udp_tunnel.h
@@ -172,10 +172,11 @@ struct rtable *udp_tunnel_dst_lookup(struct sk_buff *skb,
 struct dst_entry *udp_tunnel6_dst_lookup(struct sk_buff *skb,
 					 struct net_device *dev,
 					 struct net *net,
-					 struct socket *sock,
+					 struct socket *sock, int oif,
 					 struct in6_addr *saddr,
-					 const struct ip_tunnel_info *info,
-					 bool use_cache);
+					 const struct ip_tunnel_key *key,
+					 __be16 sport, __be16 dport, u8 dsfield,
+					 struct dst_cache *dst_cache);
 
 struct metadata_dst *udp_tun_rx_dst(struct sk_buff *skb, unsigned short family,
 				    __be16 flags, __be64 tunnel_id,
diff --git a/net/ipv6/ip6_udp_tunnel.c b/net/ipv6/ip6_udp_tunnel.c
index b9c906518ce2..a7bf0327b380 100644
--- a/net/ipv6/ip6_udp_tunnel.c
+++ b/net/ipv6/ip6_udp_tunnel.c
@@ -119,9 +119,13 @@ EXPORT_SYMBOL_GPL(udp_tunnel6_xmit_skb);
  *      @dev: Tunnel device
  *      @net: Network namespace of tunnel device
  *      @sock: Socket which provides route info
+ *      @oif: Index of the output interface
  *      @saddr: Memory to store the src ip address
- *      @info: Tunnel information
- *      @use_cache: Flag to enable cache usage
+ *      @key: Tunnel information
+ *      @sport: UDP source port
+ *      @dport: UDP destination port
+ *      @dsfield: The traffic class field
+ *      @dst_cache: The dst cache to use for lookup
  *      This function performs a route lookup on a UDP tunnel
  *
  *      It returns a valid dst pointer and stores src address to be used in
@@ -132,20 +136,17 @@ struct dst_entry *udp_tunnel6_dst_lookup(struct sk_buff *skb,
 					 struct net_device *dev,
 					 struct net *net,
 					 struct socket *sock,
+					 int oif,
 					 struct in6_addr *saddr,
-					 const struct ip_tunnel_info *info,
-					 bool use_cache)
+					 const struct ip_tunnel_key *key,
+					 __be16 sport, __be16 dport, u8 dsfield,
+					 struct dst_cache *dst_cache)
 {
 	struct dst_entry *dst = NULL;
-#ifdef CONFIG_DST_CACHE
-	struct dst_cache *dst_cache;
-#endif
 	struct flowi6 fl6;
-	__u8 prio;
 
 #ifdef CONFIG_DST_CACHE
-	dst_cache = (struct dst_cache *)&info->dst_cache;
-	if (use_cache) {
+	if (dst_cache) {
 		dst = dst_cache_get_ip6(dst_cache, saddr);
 		if (dst)
 			return dst;
@@ -154,10 +155,12 @@ struct dst_entry *udp_tunnel6_dst_lookup(struct sk_buff *skb,
 	memset(&fl6, 0, sizeof(fl6));
 	fl6.flowi6_mark = skb->mark;
 	fl6.flowi6_proto = IPPROTO_UDP;
-	fl6.daddr = info->key.u.ipv6.dst;
-	fl6.saddr = info->key.u.ipv6.src;
-	prio = info->key.tos;
-	fl6.flowlabel = ip6_make_flowinfo(prio, info->key.label);
+	fl6.flowi6_oif = oif;
+	fl6.daddr = key->u.ipv6.dst;
+	fl6.saddr = key->u.ipv6.src;
+	fl6.fl6_sport = sport;
+	fl6.fl6_dport = dport;
+	fl6.flowlabel = ip6_make_flowinfo(dsfield, key->label);
 
 	dst = ipv6_stub->ipv6_dst_lookup_flow(net, sock->sk, &fl6,
 					      NULL);
@@ -171,7 +174,7 @@ struct dst_entry *udp_tunnel6_dst_lookup(struct sk_buff *skb,
 		return ERR_PTR(-ELOOP);
 	}
 #ifdef CONFIG_DST_CACHE
-	if (use_cache)
+	if (dst_cache)
 		dst_cache_set_ip6(dst_cache, dst, &fl6.saddr);
 #endif
 	*saddr = fl6.saddr;
-- 
2.40.1

