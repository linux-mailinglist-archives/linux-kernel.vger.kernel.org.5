Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D5F7D0F39
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 13:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377339AbjJTL4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 07:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377216AbjJTLzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 07:55:54 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96098D41;
        Fri, 20 Oct 2023 04:55:52 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9be3b66f254so109312066b.3;
        Fri, 20 Oct 2023 04:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697802951; x=1698407751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kWj5oDx/S8VI79K/5zPzRbyb5BIBjkraIKsv8+HW9jw=;
        b=Fgs+4JHTgRlbd337hz0dkGPepyTSpCm2kqnkt7O4RMFiaadxUr7vy3Xnp2XME+FBYi
         H3abMP5etF3pSCa2lkebjAcPyTV5Eeg9I32gO8GFkKXPsfO6Z6Fowj14mPTSKHj/Ng46
         Q3NoXczDtfuBhFw1Ny8VNxam5Yh0f7CV32wvKuxxAP+DIAiD10LC87vxnMMd6EWYDy22
         +5k8h9cNyKOgXAs2J4f7U3uye+iI/3tSVQnsz2hAdNrPnxPO0KAav6Mg8CV4HDetQsIB
         doI5fJtotpLQVDYvrA5FlALgOF8Z4p0bah4gojNriLLhGgxirUPLzgf95aZK9tUmpio4
         heEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697802951; x=1698407751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kWj5oDx/S8VI79K/5zPzRbyb5BIBjkraIKsv8+HW9jw=;
        b=IF5zvGFgeGR6lUubL59xjkNhFsug1TydFqylwuDDDQHdATrNOOQYtUg9u/50KUronZ
         wGVYk14flef/OtIq+eMKhE2b2qKTMiqaEuxJECmFhRIdxQ82Hduh07lS7ZfLWiFgl7C0
         t4rRC6sSJi8KveAaT7OtHG91SnwvzWxbcI463WjJlC+pzTllJifp/u/o76KzjtGABo8a
         vewLS/0Vb7J1b5zVA9yxGNAVVJem4xEk7srl4AcyD6Wr2eN8Yokv048MHRYIOzgDiT77
         LQcVbHK65x7PqAy7P023fNMXZ1Y49ElFtI6h6simB4WgYRUKtJz9WtqyANHH6g+E82t6
         9WEQ==
X-Gm-Message-State: AOJu0YyuRGiU+yNcKyEgVJYTThkC2/jLQ68hVHnGJFNw29olJTI3F8CM
        PTEhohe1UKI6Dkq4xNiTFJ4UofeCJ+f5/Q==
X-Google-Smtp-Source: AGHT+IGWiuo+BHibTMEtAeo39fIn1N+aYYfcaD+z0tvqx6QvcOaBsN1y2R/XEe2t/wEnpaV2Lfzxgw==
X-Received: by 2002:a17:907:2d8b:b0:9c7:5a01:ffe5 with SMTP id gt11-20020a1709072d8b00b009c75a01ffe5mr983076ejc.5.1697802950999;
        Fri, 20 Oct 2023 04:55:50 -0700 (PDT)
Received: from tp.home.arpa (host-95-239-66-218.retail.telecomitalia.it. [95.239.66.218])
        by smtp.gmail.com with ESMTPSA id v21-20020a170906489500b009b928eb8dd3sm1342014ejq.163.2023.10.20.04.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 04:55:50 -0700 (PDT)
From:   Beniamino Galvani <b.galvani@gmail.com>
To:     netdev@vger.kernel.org
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Guillaume Nault <gnault@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 4/5] geneve: use generic function for tunnel IPv6 route lookup
Date:   Fri, 20 Oct 2023 13:55:28 +0200
Message-Id: <20231020115529.3344878-5-b.galvani@gmail.com>
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
geneve_get_v6_dst().

This is similar to what already done for IPv4 in commit daa2ba7ed1d1
("geneve: use generic function for tunnel IPv4 route lookup").

Suggested-by: Guillaume Nault <gnault@redhat.com>
Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
---
 drivers/net/geneve.c | 96 ++++++++++++++------------------------------
 1 file changed, 31 insertions(+), 65 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 23041eeec121..acd9c615d1f4 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -800,57 +800,6 @@ static u8 geneve_get_dsfield(struct sk_buff *skb, struct net_device *dev,
 	return dsfield;
 }
 
-#if IS_ENABLED(CONFIG_IPV6)
-static struct dst_entry *geneve_get_v6_dst(struct sk_buff *skb,
-					   struct net_device *dev,
-					   struct geneve_sock *gs6,
-					   struct flowi6 *fl6,
-					   const struct ip_tunnel_info *info,
-					   __be16 dport, __be16 sport)
-{
-	bool use_cache = ip_tunnel_dst_cache_usable(skb, info);
-	struct geneve_dev *geneve = netdev_priv(dev);
-	struct dst_entry *dst = NULL;
-	struct dst_cache *dst_cache;
-	__u8 prio;
-
-	if (!gs6)
-		return ERR_PTR(-EIO);
-
-	memset(fl6, 0, sizeof(*fl6));
-	fl6->flowi6_mark = skb->mark;
-	fl6->flowi6_proto = IPPROTO_UDP;
-	fl6->daddr = info->key.u.ipv6.dst;
-	fl6->saddr = info->key.u.ipv6.src;
-	fl6->fl6_dport = dport;
-	fl6->fl6_sport = sport;
-
-	prio = geneve_get_dsfield(skb, dev, info, &use_cache);
-	fl6->flowlabel = ip6_make_flowinfo(prio, info->key.label);
-	dst_cache = (struct dst_cache *)&info->dst_cache;
-	if (use_cache) {
-		dst = dst_cache_get_ip6(dst_cache, &fl6->saddr);
-		if (dst)
-			return dst;
-	}
-	dst = ipv6_stub->ipv6_dst_lookup_flow(geneve->net, gs6->sock->sk, fl6,
-					      NULL);
-	if (IS_ERR(dst)) {
-		netdev_dbg(dev, "no route to %pI6\n", &fl6->daddr);
-		return ERR_PTR(-ENETUNREACH);
-	}
-	if (dst->dev == dev) { /* is this necessary? */
-		netdev_dbg(dev, "circular route to %pI6\n", &fl6->daddr);
-		dst_release(dst);
-		return ERR_PTR(-ELOOP);
-	}
-
-	if (use_cache)
-		dst_cache_set_ip6(dst_cache, dst, &fl6->saddr);
-	return dst;
-}
-#endif
-
 static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 			   struct geneve_dev *geneve,
 			   const struct ip_tunnel_info *info)
@@ -967,7 +916,8 @@ static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	struct geneve_sock *gs6 = rcu_dereference(geneve->sock6);
 	const struct ip_tunnel_key *key = &info->key;
 	struct dst_entry *dst = NULL;
-	struct flowi6 fl6;
+	struct in6_addr saddr;
+	bool use_cache;
 	__u8 prio, ttl;
 	__be16 sport;
 	int err;
@@ -975,9 +925,18 @@ static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	if (!pskb_inet_may_pull(skb))
 		return -EINVAL;
 
+	if (!gs6)
+		return -EIO;
+
+	use_cache = ip_tunnel_dst_cache_usable(skb, info);
+	prio = geneve_get_dsfield(skb, dev, info, &use_cache);
 	sport = udp_flow_src_port(geneve->net, skb, 1, USHRT_MAX, true);
-	dst = geneve_get_v6_dst(skb, dev, gs6, &fl6, info,
-				geneve->cfg.info.key.tp_dst, sport);
+
+	dst = udp_tunnel6_dst_lookup(skb, dev, geneve->net, gs6->sock, 0,
+				     &saddr, key, sport,
+				     geneve->cfg.info.key.tp_dst, prio,
+				     use_cache ?
+				     (struct dst_cache *)&info->dst_cache : NULL);
 	if (IS_ERR(dst))
 		return PTR_ERR(dst);
 
@@ -999,8 +958,8 @@ static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 				return -ENOMEM;
 			}
 
-			unclone->key.u.ipv6.dst = fl6.saddr;
-			unclone->key.u.ipv6.src = fl6.daddr;
+			unclone->key.u.ipv6.dst = saddr;
+			unclone->key.u.ipv6.src = info->key.u.ipv6.dst;
 		}
 
 		if (!pskb_may_pull(skb, ETH_HLEN)) {
@@ -1014,12 +973,10 @@ static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 		return -EMSGSIZE;
 	}
 
+	prio = ip_tunnel_ecn_encap(prio, ip_hdr(skb), skb);
 	if (geneve->cfg.collect_md) {
-		prio = ip_tunnel_ecn_encap(key->tos, ip_hdr(skb), skb);
 		ttl = key->ttl;
 	} else {
-		prio = ip_tunnel_ecn_encap(ip6_tclass(fl6.flowlabel),
-					   ip_hdr(skb), skb);
 		if (geneve->cfg.ttl_inherit)
 			ttl = ip_tunnel_get_ttl(ip_hdr(skb), skb);
 		else
@@ -1032,7 +989,7 @@ static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 		return err;
 
 	udp_tunnel6_xmit_skb(dst, gs6->sock->sk, skb, dev,
-			     &fl6.saddr, &fl6.daddr, prio, ttl,
+			     &saddr, &key->u.ipv6.dst, prio, ttl,
 			     info->key.label, sport, geneve->cfg.info.key.tp_dst,
 			     !(info->key.tun_flags & TUNNEL_CSUM));
 	return 0;
@@ -1126,19 +1083,28 @@ static int geneve_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb)
 #if IS_ENABLED(CONFIG_IPV6)
 	} else if (ip_tunnel_info_af(info) == AF_INET6) {
 		struct dst_entry *dst;
-		struct flowi6 fl6;
-
 		struct geneve_sock *gs6 = rcu_dereference(geneve->sock6);
+		struct in6_addr saddr;
+		bool use_cache;
+		u8 prio;
+
+		if (!gs6)
+			return -EIO;
+
+		use_cache = ip_tunnel_dst_cache_usable(skb, info);
+		prio = geneve_get_dsfield(skb, dev, info, &use_cache);
 		sport = udp_flow_src_port(geneve->net, skb,
 					  1, USHRT_MAX, true);
 
-		dst = geneve_get_v6_dst(skb, dev, gs6, &fl6, info,
-					geneve->cfg.info.key.tp_dst, sport);
+		dst = udp_tunnel6_dst_lookup(skb, dev, geneve->net, gs6->sock, 0,
+					     &saddr, &info->key, sport,
+					     geneve->cfg.info.key.tp_dst, prio,
+					     use_cache ? &info->dst_cache : NULL);
 		if (IS_ERR(dst))
 			return PTR_ERR(dst);
 
 		dst_release(dst);
-		info->key.u.ipv6.src = fl6.saddr;
+		info->key.u.ipv6.src = saddr;
 #endif
 	} else {
 		return -EINVAL;
-- 
2.40.1

