Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DADE7D675E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 11:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234883AbjJYJqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 05:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234684AbjJYJqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 05:46:32 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03A030CB;
        Wed, 25 Oct 2023 02:45:33 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-5406c099cebso4414128a12.2;
        Wed, 25 Oct 2023 02:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698227132; x=1698831932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8Pt5phfixaXvNlB8r+PBZ9jiHHg7LS+G7hf/4wtAiQ8=;
        b=nkw5UGfQ317l2jaIgUkJ5QMXvDxJjlRMwjjYh22P2FtNqROvAMKfVZDypnEMd+Tli3
         yZsqpArpS2LC4nDaGoTCLrlZY9cYv8vD2rEGoZBorbq3wLbJL0zuqe9E/cuxALv530cI
         7eLE8AgDF2+nq6eKlH9qM4OrG5zzu/Zf3iBYjMk947n1RU/PU8uXaD/V1zU4gicHRk8m
         ZZO90roW6jH5XBUPDZSTWzbo1dvmKSP9OvjjUxrIyMHyYiUxuxeusf+ZEDAsYopg/yuK
         SeXz/+SfGo3QGqwI4Og10O4CcxcXcSBs9Myg2M82+9U1PCWXCxyYB6kNJrXftqseNCMH
         9mVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698227132; x=1698831932;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Pt5phfixaXvNlB8r+PBZ9jiHHg7LS+G7hf/4wtAiQ8=;
        b=rtmjgSXofNfvIwyyJa+gPNynU4uIHpY727rAe8E3WMZrk785ZdwOpNQS3JfNDvgyaM
         mImhFW23JlfcsSLsCIrF/a3o2F49zobva9WoIN+iJWg1SPrfjDDJjAMJv1WoDgedJ4/u
         G5yzUEeP4vFNVBzTSVlBhpEJqKcF6y5OQMDtD6a+3v0NcaashCbFkp0VxeRWRm2rPW7Q
         RHMZw0l4+G4EoP/7vCaKKosP4Rk5d1MpNFaS15kf0zyC/p3F1u+Y9izjKUoHa/rBLr9M
         yGk5zuP+2E2r8Do2JmQ3QcjAw8jpjmHi0vTRM+NCvw3dVLKl9Z6Sy1I/1Jcbjf1kfR/u
         x46Q==
X-Gm-Message-State: AOJu0YwjVeopZi6MM3btvJWF+VBaChprUZ/uQR2XLC2WXsf4MRZ2zjKX
        tiWdwq0Tawj5LTubA8Ahztx2ItHyK2M=
X-Google-Smtp-Source: AGHT+IEJJFWpa/GIfSnQN1JJCFiP8/YkShYQ9373CxIpiir0JCn/cBfwu/bGvw4K6IveHwUZQY9KbQ==
X-Received: by 2002:a05:6402:3593:b0:53f:bab5:864b with SMTP id y19-20020a056402359300b0053fbab5864bmr12231040edc.16.1698227131555;
        Wed, 25 Oct 2023 02:45:31 -0700 (PDT)
Received: from tp.home.arpa (host-95-232-81-37.retail.telecomitalia.it. [95.232.81.37])
        by smtp.gmail.com with ESMTPSA id ch28-20020a0564021bdc00b0053ff311f388sm7706488edb.23.2023.10.25.02.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 02:45:31 -0700 (PDT)
From:   Beniamino Galvani <b.galvani@gmail.com>
To:     netdev@vger.kernel.org
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Guillaume Nault <gnault@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next] bareudp: use ports to lookup route
Date:   Wed, 25 Oct 2023 11:44:41 +0200
Message-ID: <20231025094441.417464-1-b.galvani@gmail.com>
X-Mailer: git-send-email 2.41.0
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

The source and destination ports should be taken into account when
determining the route destination; they can affect the result, for
example in case there are routing rules defined.

Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
---
 drivers/net/bareudp.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/net/bareudp.c b/drivers/net/bareudp.c
index 9c11a0d0273b..31377bb1cc97 100644
--- a/drivers/net/bareudp.c
+++ b/drivers/net/bareudp.c
@@ -306,8 +306,11 @@ static int bareudp_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	if (!sock)
 		return -ESHUTDOWN;
 
+	sport = udp_flow_src_port(bareudp->net, skb,
+				  bareudp->sport_min, USHRT_MAX,
+				  true);
 	rt = udp_tunnel_dst_lookup(skb, dev, bareudp->net, 0, &saddr, &info->key,
-				   0, 0, key->tos,
+				   sport, bareudp->port, key->tos,
 				   use_cache ?
 				   (struct dst_cache *)&info->dst_cache : NULL);
 
@@ -317,9 +320,6 @@ static int bareudp_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	skb_tunnel_check_pmtu(skb, &rt->dst,
 			      BAREUDP_IPV4_HLEN + info->options_len, false);
 
-	sport = udp_flow_src_port(bareudp->net, skb,
-				  bareudp->sport_min, USHRT_MAX,
-				  true);
 	tos = ip_tunnel_ecn_encap(key->tos, ip_hdr(skb), skb);
 	ttl = key->ttl;
 	df = key->tun_flags & TUNNEL_DONT_FRAGMENT ? htons(IP_DF) : 0;
@@ -371,8 +371,11 @@ static int bareudp6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	if (!sock)
 		return -ESHUTDOWN;
 
+	sport = udp_flow_src_port(bareudp->net, skb,
+				  bareudp->sport_min, USHRT_MAX,
+				  true);
 	dst = udp_tunnel6_dst_lookup(skb, dev, bareudp->net, sock, 0, &saddr,
-				     key, 0, 0, key->tos,
+				     key, sport, bareudp->port, key->tos,
 				     use_cache ?
 				     (struct dst_cache *) &info->dst_cache : NULL);
 	if (IS_ERR(dst))
@@ -381,9 +384,6 @@ static int bareudp6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	skb_tunnel_check_pmtu(skb, dst, BAREUDP_IPV6_HLEN + info->options_len,
 			      false);
 
-	sport = udp_flow_src_port(bareudp->net, skb,
-				  bareudp->sport_min, USHRT_MAX,
-				  true);
 	prio = ip_tunnel_ecn_encap(key->tos, ip_hdr(skb), skb);
 	ttl = key->ttl;
 
@@ -480,15 +480,20 @@ static int bareudp_fill_metadata_dst(struct net_device *dev,
 	struct ip_tunnel_info *info = skb_tunnel_info(skb);
 	struct bareudp_dev *bareudp = netdev_priv(dev);
 	bool use_cache;
+	__be16 sport;
 
 	use_cache = ip_tunnel_dst_cache_usable(skb, info);
+	sport = udp_flow_src_port(bareudp->net, skb,
+				  bareudp->sport_min, USHRT_MAX,
+				  true);
 
 	if (!ipv6_mod_enabled() || ip_tunnel_info_af(info) == AF_INET) {
 		struct rtable *rt;
 		__be32 saddr;
 
 		rt = udp_tunnel_dst_lookup(skb, dev, bareudp->net, 0, &saddr,
-					   &info->key, 0, 0, info->key.tos,
+					   &info->key, sport, bareudp->port,
+					   info->key.tos,
 					   use_cache ? &info->dst_cache : NULL);
 		if (IS_ERR(rt))
 			return PTR_ERR(rt);
@@ -502,7 +507,7 @@ static int bareudp_fill_metadata_dst(struct net_device *dev,
 
 		dst = udp_tunnel6_dst_lookup(skb, dev, bareudp->net, sock,
 					     0, &saddr, &info->key,
-					     0, 0, info->key.tos,
+					     sport, bareudp->port, info->key.tos,
 					     use_cache ? &info->dst_cache : NULL);
 		if (IS_ERR(dst))
 			return PTR_ERR(dst);
@@ -513,9 +518,7 @@ static int bareudp_fill_metadata_dst(struct net_device *dev,
 		return -EINVAL;
 	}
 
-	info->key.tp_src = udp_flow_src_port(bareudp->net, skb,
-					     bareudp->sport_min,
-			USHRT_MAX, true);
+	info->key.tp_src = sport;
 	info->key.tp_dst = bareudp->port;
 	return 0;
 }
-- 
2.41.0

