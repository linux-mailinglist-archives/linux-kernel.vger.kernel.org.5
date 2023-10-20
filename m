Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65B27D0F38
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 13:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377295AbjJTLz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 07:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377255AbjJTLzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 07:55:53 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD93D4C;
        Fri, 20 Oct 2023 04:55:50 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-98377c5d53eso114549466b.0;
        Fri, 20 Oct 2023 04:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697802949; x=1698407749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0KmtVFbWzplAw+DN7VSv0tLTduS4IgtLHBkgos/qD5o=;
        b=StImGmkem5m8rrsjcMA+ra3GkMVm9Zd3EhcKncY9WmccXhXpkLK6LaeTrUHWCkFR+y
         pc1VtDQkNlpI4kHocLBC0mbo180WgtHrr77vY1QB8FAEAx8bjQ1e7kf9s4iXPwUQBbxI
         gLzSgbwJtv6TcyiGGAYvX8qcQL6JkP4lcy2po0bYeDYzcIWnrZ0vNuTmqtMgMAV56ZBt
         +WyuZjJ+frdl6FdntZiwU9bJb+l+YdvgF6Lw1JnkS7fqsAuRjcyjqKE4YWSSryPXFUW5
         CJnxnzRWJC30P5ZlXmXFBpZssD0Ke4YRGGNzYikmFmrcF4TmL5jPKfnMG9CuRwKjIjG0
         S1FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697802949; x=1698407749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0KmtVFbWzplAw+DN7VSv0tLTduS4IgtLHBkgos/qD5o=;
        b=tXx0poAjfTzhGcR0my6h86PAHZeF1tQu97b2D01fIzRGGJCeqJbMkRNKe79MkU85fg
         Mb2HtLye5JFcbjW2Zf+4rowu2JYQtzf74Z8kpvgK5v0o+ptHCB6k0RlfZV7rqLLVcpNy
         U3i984wXBDL0dczrdJOO8LnR71pv5LXbzlym4rI2CTVN8R6MlFpxxznlaSWgATJlOrVe
         v/rU3UbT+xY4g8h/v46t/qjIzlA3Wrok1PxhZHE8haACerNrk7xdSzeQ0jF0Ht51F6Dj
         d9qKL/jIBxR4ACu3J2gm+KnyL/DptC6ako9GhP0/3ua1zkKhQA5qVijLBy+3rZyGWyu2
         pWLA==
X-Gm-Message-State: AOJu0YzNruPchcMN+n/EFkHsApi13ZNfxYz4aTStVlnoWktv/W+5IJGJ
        EPJSNSwgiFfxS8jFI9UwQjONXtNERnUThg==
X-Google-Smtp-Source: AGHT+IGVcQBTH98uCK/zjTmDdZOn/3s4Sc2VQ0aDMYMmIDUn2iqBUFr7LfiPbXXISD54pRZAiT7H/g==
X-Received: by 2002:a17:906:9c83:b0:9b2:b691:9b5f with SMTP id fj3-20020a1709069c8300b009b2b6919b5fmr1135159ejc.41.1697802949331;
        Fri, 20 Oct 2023 04:55:49 -0700 (PDT)
Received: from tp.home.arpa (host-95-239-66-218.retail.telecomitalia.it. [95.239.66.218])
        by smtp.gmail.com with ESMTPSA id v21-20020a170906489500b009b928eb8dd3sm1342014ejq.163.2023.10.20.04.55.48
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
Subject: [PATCH net-next 2/5] ipv6: remove "proto" argument from udp_tunnel6_dst_lookup()
Date:   Fri, 20 Oct 2023 13:55:26 +0200
Message-Id: <20231020115529.3344878-3-b.galvani@gmail.com>
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

The function is now UDP-specific, the protocol is always IPPROTO_UDP.

This is similar to what already done for IPv4 in commit 78f3655adcb5
("ipv4: remove "proto" argument from udp_tunnel_dst_lookup()").

Suggested-by: Guillaume Nault <gnault@redhat.com>
Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
---
 drivers/net/bareudp.c     | 5 ++---
 include/net/udp_tunnel.h  | 2 +-
 net/ipv6/ip6_udp_tunnel.c | 4 +---
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/bareudp.c b/drivers/net/bareudp.c
index 9a0a1a9f6cfe..9eb5e11c09b4 100644
--- a/drivers/net/bareudp.c
+++ b/drivers/net/bareudp.c
@@ -372,7 +372,7 @@ static int bareudp6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 		return -ESHUTDOWN;
 
 	dst = udp_tunnel6_dst_lookup(skb, dev, bareudp->net, sock, &saddr, info,
-				     IPPROTO_UDP, use_cache);
+				     use_cache);
 	if (IS_ERR(dst))
 		return PTR_ERR(dst);
 
@@ -499,8 +499,7 @@ static int bareudp_fill_metadata_dst(struct net_device *dev,
 		struct socket *sock = rcu_dereference(bareudp->sock);
 
 		dst = udp_tunnel6_dst_lookup(skb, dev, bareudp->net, sock,
-					     &saddr, info, IPPROTO_UDP,
-					     use_cache);
+					     &saddr, info, use_cache);
 		if (IS_ERR(dst))
 			return PTR_ERR(dst);
 
diff --git a/include/net/udp_tunnel.h b/include/net/udp_tunnel.h
index 1dac296d8449..583867643bd1 100644
--- a/include/net/udp_tunnel.h
+++ b/include/net/udp_tunnel.h
@@ -175,7 +175,7 @@ struct dst_entry *udp_tunnel6_dst_lookup(struct sk_buff *skb,
 					 struct socket *sock,
 					 struct in6_addr *saddr,
 					 const struct ip_tunnel_info *info,
-					 u8 protocol, bool use_cache);
+					 bool use_cache);
 
 struct metadata_dst *udp_tun_rx_dst(struct sk_buff *skb, unsigned short family,
 				    __be16 flags, __be64 tunnel_id,
diff --git a/net/ipv6/ip6_udp_tunnel.c b/net/ipv6/ip6_udp_tunnel.c
index fc122abf6b75..b9c906518ce2 100644
--- a/net/ipv6/ip6_udp_tunnel.c
+++ b/net/ipv6/ip6_udp_tunnel.c
@@ -121,7 +121,6 @@ EXPORT_SYMBOL_GPL(udp_tunnel6_xmit_skb);
  *      @sock: Socket which provides route info
  *      @saddr: Memory to store the src ip address
  *      @info: Tunnel information
- *      @protocol: IP protocol
  *      @use_cache: Flag to enable cache usage
  *      This function performs a route lookup on a UDP tunnel
  *
@@ -135,7 +134,6 @@ struct dst_entry *udp_tunnel6_dst_lookup(struct sk_buff *skb,
 					 struct socket *sock,
 					 struct in6_addr *saddr,
 					 const struct ip_tunnel_info *info,
-					 u8 protocol,
 					 bool use_cache)
 {
 	struct dst_entry *dst = NULL;
@@ -155,7 +153,7 @@ struct dst_entry *udp_tunnel6_dst_lookup(struct sk_buff *skb,
 #endif
 	memset(&fl6, 0, sizeof(fl6));
 	fl6.flowi6_mark = skb->mark;
-	fl6.flowi6_proto = protocol;
+	fl6.flowi6_proto = IPPROTO_UDP;
 	fl6.daddr = info->key.u.ipv6.dst;
 	fl6.saddr = info->key.u.ipv6.src;
 	prio = info->key.tos;
-- 
2.40.1

