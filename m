Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7CE57BD52B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 10:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234461AbjJII0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 04:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234412AbjJII0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 04:26:19 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856CDAB;
        Mon,  9 Oct 2023 01:26:17 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-536b39daec1so7218314a12.2;
        Mon, 09 Oct 2023 01:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696839975; x=1697444775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EyObhFDaQNlftjPmA42QI8DJSxQ8P2np8YChl5TvP6A=;
        b=fcf95qotundpBmuGOPoRZNN+LI8HrEkKwl3IgridkWnZlyPEaSiL37npkotqWcO5BY
         LgljhpECnJ+fuB5dj2ZYeY7fYZGLVXmWslYiF7U25VzPqAzUfXn6Xgp9yLsYvTjkau08
         +DsSTIiGeaJTroxsoS8ypMpcVO9LEKz4II/DSZ9yAG1mEb2MvkBEWYI1j93HAVGuSaCG
         plMf/v6WCp+mQnUXnQslvAuAO7UlJlUY/pF4je/+0yAHcDdjgFt+Tl5l3P/2Oo20/vFW
         6Mv1e1sDw/a8GNqLtmfVb+BA2zWRmEbNdcPGaKeW4Gc/P/juaQ4jyaAoG30cpWBULyPW
         wfCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696839975; x=1697444775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EyObhFDaQNlftjPmA42QI8DJSxQ8P2np8YChl5TvP6A=;
        b=wMGtkBuGKHooslv3PUN0QBl3Nms7L0+Kop3nsiuyb2pI8IDbEJvFqoktW03yaY6uhv
         L11TMT2z4jl3zcAAjwXroCNiYYJRNf6jRfXhiN1srtAJ3nd+GRJErhm9KqMU2hpNWpJX
         tmlBzFiwJrP6HgVaInH2GnCktPmeUkj/hDUE9TO4cHtbW4mKxxrooB8svHmL+WwcKF1L
         koKE/8joplBx64yerzoVO9Q0mtALvBcikFclKvg6vEgljoqy6WBwMHoie00AS8VbQSzl
         NUdbyvNzpvfQm0keskixmge+6rvn9IAZy6ZtGqjBUbDuq6b/IdMB7xPBYLWzY6MIN188
         IwIg==
X-Gm-Message-State: AOJu0Yx0Ust0qbHjZVqwk6vHzBXVXu46lcogNbXk+1Tj/MYc0R/vNEEr
        CNvfXO+x/Nx/N/o25815vRvM3RnI9+0=
X-Google-Smtp-Source: AGHT+IFT9vlPZ1jcLtiVVmYWzThL5CE+T6YV6iD1UjZv2n6KHxKuwBDo/UcVqlhwwDyJoRmEm8F2CA==
X-Received: by 2002:aa7:d902:0:b0:52c:9f89:4447 with SMTP id a2-20020aa7d902000000b0052c9f894447mr12963676edr.4.1696839975523;
        Mon, 09 Oct 2023 01:26:15 -0700 (PDT)
Received: from tp.home.arpa (host-79-24-102-58.retail.telecomitalia.it. [79.24.102.58])
        by smtp.gmail.com with ESMTPSA id p22-20020a05640210d600b00530a9488623sm5844810edu.46.2023.10.09.01.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 01:26:15 -0700 (PDT)
From:   Beniamino Galvani <b.galvani@gmail.com>
To:     netdev@vger.kernel.org
Cc:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Guillaume Nault <gnault@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/7] ipv4: add new arguments to udp_tunnel_dst_lookup()
Date:   Mon,  9 Oct 2023 10:20:55 +0200
Message-Id: <20231009082059.2500217-4-b.galvani@gmail.com>
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

