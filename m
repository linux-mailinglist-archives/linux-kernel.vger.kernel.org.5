Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4737BD52F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 10:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234488AbjJII0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 04:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234437AbjJII0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 04:26:21 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410968F;
        Mon,  9 Oct 2023 01:26:19 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-53627feca49so7026448a12.1;
        Mon, 09 Oct 2023 01:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696839977; x=1697444777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n0AxUwpswyDtB5yjnz9mIbeKoD0NUiZwXlK+ltnPKKo=;
        b=dxHMO/OBd86X8swbyWv1UwZAsnVkgeaUHcaOJEJA9+d5Vuvy7dhX+AeQBrEsWqBdst
         a/8yZFxAREg3UWnJmL6mGN2TH9UtMG6sdqNu/r3a3025JtSFA456aTUflCnlzhyfRjS2
         SBeAwBSLSFwc1sxt0rdfKV4xeE9LKEx24zJdGiNKeLd1JZtH15peVPDTbqou//+0T9cY
         Q1ijohN/PN5EgX+9ax67Zcaln4W9aLjTWYjuvvZMUiPkNVzX5InpKn3OFvpV4juSRQZ9
         t4CPiG9Pci4mqNSNnCzQmXzxbpkb3D0YUMSWSEEeXf2LQCDTNxrm2v5ZRL4Gc28zKCBZ
         VUSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696839977; x=1697444777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n0AxUwpswyDtB5yjnz9mIbeKoD0NUiZwXlK+ltnPKKo=;
        b=TN4y/EWSDG8CKW6I5yPmW3MTkC2BDg3Zff4zHMAdAGyg/1BeUr3BuXeVEGgs4KJMtj
         abIy1u60B98dKYG2wBz0xFRRjh8bnXM6Ey3LyHKeSEkYFC+i3dJk4wC3HAaCKzgZECxT
         GN/X9MFe0S0KW72A68v0cJ/7E4KhWwKymsmH9MuHqAN6hPd4OqPWrveIq6YjrfzOD2Cg
         aZXBbCnDZffNn3+0PusZODrD7SU1M5nSODSxPLOT5fnd4fg/oXAMTdLlkkr96jqJVFbg
         +rC+7W/tqPKd/b7xWbmQSyDMCQaYIt9DMWO5HiNrrtdE3s7z/mk7ONvcbxQlJQIPpou/
         x3Yw==
X-Gm-Message-State: AOJu0Yz9/TsrkSDn4NYdcBUH29xG+IgakITaongdEcOQNXJTFfWWmlDn
        dDR7qoK6OLa4W2WZVCir/rW97Ue/okA=
X-Google-Smtp-Source: AGHT+IH/5ttIGxaK75UhSvVL6xyF2eq3UmszhLyNTcZan2CCYR9O0RD5ppPEN+L+uPD/PB29lQL54g==
X-Received: by 2002:aa7:d503:0:b0:538:ae5:6138 with SMTP id y3-20020aa7d503000000b005380ae56138mr14404566edq.34.1696839977674;
        Mon, 09 Oct 2023 01:26:17 -0700 (PDT)
Received: from tp.home.arpa (host-79-24-102-58.retail.telecomitalia.it. [79.24.102.58])
        by smtp.gmail.com with ESMTPSA id p22-20020a05640210d600b00530a9488623sm5844810edu.46.2023.10.09.01.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 01:26:17 -0700 (PDT)
From:   Beniamino Galvani <b.galvani@gmail.com>
To:     netdev@vger.kernel.org
Cc:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Guillaume Nault <gnault@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 6/7] geneve: use generic function for tunnel IPv4 route lookup
Date:   Mon,  9 Oct 2023 10:20:58 +0200
Message-Id: <20231009082059.2500217-7-b.galvani@gmail.com>
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
udp_tunnel_dst_lookup() to replace the custom implementation in
geneve_get_v4_rt().

Suggested-by: Guillaume Nault <gnault@redhat.com>
Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
---
 drivers/net/geneve.c | 98 +++++++++++++++-----------------------------
 1 file changed, 32 insertions(+), 66 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 572c3e36b209..23041eeec121 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -800,58 +800,6 @@ static u8 geneve_get_dsfield(struct sk_buff *skb, struct net_device *dev,
 	return dsfield;
 }
 
-static struct rtable *geneve_get_v4_rt(struct sk_buff *skb,
-				       struct net_device *dev,
-				       struct geneve_sock *gs4,
-				       struct flowi4 *fl4,
-				       const struct ip_tunnel_info *info,
-				       __be16 dport, __be16 sport,
-				       __u8 *full_tos)
-{
-	bool use_cache = ip_tunnel_dst_cache_usable(skb, info);
-	struct geneve_dev *geneve = netdev_priv(dev);
-	struct dst_cache *dst_cache;
-	struct rtable *rt = NULL;
-	__u8 tos;
-
-	if (!gs4)
-		return ERR_PTR(-EIO);
-
-	memset(fl4, 0, sizeof(*fl4));
-	fl4->flowi4_mark = skb->mark;
-	fl4->flowi4_proto = IPPROTO_UDP;
-	fl4->daddr = info->key.u.ipv4.dst;
-	fl4->saddr = info->key.u.ipv4.src;
-	fl4->fl4_dport = dport;
-	fl4->fl4_sport = sport;
-	fl4->flowi4_flags = info->key.flow_flags;
-
-	tos = geneve_get_dsfield(skb, dev, info, &use_cache);
-	fl4->flowi4_tos = RT_TOS(tos);
-	if (full_tos)
-		*full_tos = tos;
-
-	dst_cache = (struct dst_cache *)&info->dst_cache;
-	if (use_cache) {
-		rt = dst_cache_get_ip4(dst_cache, &fl4->saddr);
-		if (rt)
-			return rt;
-	}
-	rt = ip_route_output_key(geneve->net, fl4);
-	if (IS_ERR(rt)) {
-		netdev_dbg(dev, "no route to %pI4\n", &fl4->daddr);
-		return ERR_PTR(-ENETUNREACH);
-	}
-	if (rt->dst.dev == dev) { /* is this necessary? */
-		netdev_dbg(dev, "circular route to %pI4\n", &fl4->daddr);
-		ip_rt_put(rt);
-		return ERR_PTR(-ELOOP);
-	}
-	if (use_cache)
-		dst_cache_set_ip4(dst_cache, &rt->dst, fl4->saddr);
-	return rt;
-}
-
 #if IS_ENABLED(CONFIG_IPV6)
 static struct dst_entry *geneve_get_v6_dst(struct sk_buff *skb,
 					   struct net_device *dev,
@@ -911,19 +859,28 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	struct geneve_sock *gs4 = rcu_dereference(geneve->sock4);
 	const struct ip_tunnel_key *key = &info->key;
 	struct rtable *rt;
-	struct flowi4 fl4;
-	__u8 full_tos;
+	bool use_cache;
 	__u8 tos, ttl;
 	__be16 df = 0;
+	__be32 saddr;
 	__be16 sport;
 	int err;
 
 	if (!pskb_inet_may_pull(skb))
 		return -EINVAL;
 
+	if (!gs4)
+		return -EIO;
+
+	use_cache = ip_tunnel_dst_cache_usable(skb, info);
+	tos = geneve_get_dsfield(skb, dev, info, &use_cache);
 	sport = udp_flow_src_port(geneve->net, skb, 1, USHRT_MAX, true);
-	rt = geneve_get_v4_rt(skb, dev, gs4, &fl4, info,
-			      geneve->cfg.info.key.tp_dst, sport, &full_tos);
+
+	rt = udp_tunnel_dst_lookup(skb, dev, geneve->net, 0, &saddr,
+				   &info->key,
+				   sport, geneve->cfg.info.key.tp_dst, tos,
+				   use_cache ?
+				   (struct dst_cache *)&info->dst_cache : NULL);
 	if (IS_ERR(rt))
 		return PTR_ERR(rt);
 
@@ -946,8 +903,8 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 				return -ENOMEM;
 			}
 
-			unclone->key.u.ipv4.dst = fl4.saddr;
-			unclone->key.u.ipv4.src = fl4.daddr;
+			unclone->key.u.ipv4.dst = saddr;
+			unclone->key.u.ipv4.src = info->key.u.ipv4.dst;
 		}
 
 		if (!pskb_may_pull(skb, ETH_HLEN)) {
@@ -961,13 +918,12 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 		return -EMSGSIZE;
 	}
 
+	tos = ip_tunnel_ecn_encap(tos, ip_hdr(skb), skb);
 	if (geneve->cfg.collect_md) {
-		tos = ip_tunnel_ecn_encap(key->tos, ip_hdr(skb), skb);
 		ttl = key->ttl;
 
 		df = key->tun_flags & TUNNEL_DONT_FRAGMENT ? htons(IP_DF) : 0;
 	} else {
-		tos = ip_tunnel_ecn_encap(full_tos, ip_hdr(skb), skb);
 		if (geneve->cfg.ttl_inherit)
 			ttl = ip_tunnel_get_ttl(ip_hdr(skb), skb);
 		else
@@ -995,7 +951,7 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	if (unlikely(err))
 		return err;
 
-	udp_tunnel_xmit_skb(rt, gs4->sock->sk, skb, fl4.saddr, fl4.daddr,
+	udp_tunnel_xmit_skb(rt, gs4->sock->sk, skb, saddr, info->key.u.ipv4.dst,
 			    tos, ttl, df, sport, geneve->cfg.info.key.tp_dst,
 			    !net_eq(geneve->net, dev_net(geneve->dev)),
 			    !(info->key.tun_flags & TUNNEL_CSUM));
@@ -1144,19 +1100,29 @@ static int geneve_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb)
 
 	if (ip_tunnel_info_af(info) == AF_INET) {
 		struct rtable *rt;
-		struct flowi4 fl4;
-
 		struct geneve_sock *gs4 = rcu_dereference(geneve->sock4);
+		bool use_cache;
+		__be32 saddr;
+		u8 tos;
+
+		if (!gs4)
+			return -EIO;
+
+		use_cache = ip_tunnel_dst_cache_usable(skb, info);
+		tos = geneve_get_dsfield(skb, dev, info, &use_cache);
 		sport = udp_flow_src_port(geneve->net, skb,
 					  1, USHRT_MAX, true);
 
-		rt = geneve_get_v4_rt(skb, dev, gs4, &fl4, info,
-				      geneve->cfg.info.key.tp_dst, sport, NULL);
+		rt = udp_tunnel_dst_lookup(skb, dev, geneve->net, 0, &saddr,
+					   &info->key,
+					   sport, geneve->cfg.info.key.tp_dst,
+					   tos,
+					   use_cache ? &info->dst_cache : NULL);
 		if (IS_ERR(rt))
 			return PTR_ERR(rt);
 
 		ip_rt_put(rt);
-		info->key.u.ipv4.src = fl4.saddr;
+		info->key.u.ipv4.src = saddr;
 #if IS_ENABLED(CONFIG_IPV6)
 	} else if (ip_tunnel_info_af(info) == AF_INET6) {
 		struct dst_entry *dst;
-- 
2.40.1

