Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0E27CA04B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 09:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232133AbjJPHPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 03:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbjJPHPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 03:15:38 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83091C5;
        Mon, 16 Oct 2023 00:15:36 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso663224466b.1;
        Mon, 16 Oct 2023 00:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697440535; x=1698045335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SmzPwfhHrT5qD+jCIe7+id9G3Mg11DsmsTmAf398zoQ=;
        b=b5whRmFCZHMHKG1q0M3r9zSzsFpsXl/rHTM+s42mSRAf9jmde91rjff2jGw+zKForp
         +n1IpB9UTlswvdg7qN/r934aD02d4pNc5A1i7pSdIEaLrg/KsuMjxTkWNW2+3odxu7hS
         yVIVn4MoOJHsG8tZoQX9gwVuzDWRG/RnTqBZfhMRfjOUDByZti0oy3I1RGN3i6Bitati
         wOLkT34hp6OI3Ua40GAsllfSpz4PRYkahckz5R7Ko+jvvqb991V/rayYBp/lyYs5IBrQ
         FQbZ+w8UHk00G68umrqjaUdr9gT+ldkAXL2pDJbV0/aZOXFNSmGhmpbNwAEePl3LCfUX
         ezpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697440535; x=1698045335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SmzPwfhHrT5qD+jCIe7+id9G3Mg11DsmsTmAf398zoQ=;
        b=wtnSDW1B0PAS1HlA4eW0Vz4mOVAj/V36ki++6HiMIBWDlyD8Zu4JxwnQ0qWX2sAvyT
         UsFc4tVpDZ37u6M1lgKys58EMVBDB1Pvvg1BlM0skzBYAD3MhUmlbnLi1viTypN8qXTX
         lzLgwyltW5p+WldY8+WGjw+i2iCNCMAwpiQUR47y/mN1FiKCMqwOYlSYEle0BmsarF6k
         rHK2h6mAv+bKT1Y6sgFA/+v7y41+9di5I1O0m/kwpipetmVRGpZoPZsrL9gnWQ8+Yt5E
         cynqupt1iSZg1mFTRFJpvMTAKO43kGQ/2uMVKqC3wlyh2yrR+YgWdF7ILhtqGaPSUObD
         WSag==
X-Gm-Message-State: AOJu0YyKjJnWmoS2/MVjgMXlnzRerqlLs9z3IhUSK/0ddSwx8D7GE+2s
        tj32dwimAoQFKXBBLPiJuN8r33b2shU=
X-Google-Smtp-Source: AGHT+IGtiL3iEYSsCE8EwG3lr1L2HPIlZb1Z6fRRxOMvhlkOECko7rhNIZgSQwlQHBL4MDnYK/VshQ==
X-Received: by 2002:a17:907:9724:b0:9ae:50e3:7e40 with SMTP id jg36-20020a170907972400b009ae50e37e40mr35770353ejc.52.1697440535009;
        Mon, 16 Oct 2023 00:15:35 -0700 (PDT)
Received: from tp.home.arpa (host-79-55-64-40.retail.telecomitalia.it. [79.55.64.40])
        by smtp.gmail.com with ESMTPSA id jl25-20020a17090775d900b00992e265495csm3419471ejc.212.2023.10.16.00.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 00:15:34 -0700 (PDT)
From:   Beniamino Galvani <b.galvani@gmail.com>
To:     netdev@vger.kernel.org
Cc:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Guillaume Nault <gnault@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 2/7] ipv4: remove "proto" argument from udp_tunnel_dst_lookup()
Date:   Mon, 16 Oct 2023 09:15:21 +0200
Message-Id: <20231016071526.2958108-3-b.galvani@gmail.com>
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

The function is now UDP-specific, the protocol is always IPPROTO_UDP.

Suggested-by: Guillaume Nault <gnault@redhat.com>
Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
---
 drivers/net/bareudp.c      | 4 ++--
 include/net/udp_tunnel.h   | 2 +-
 net/ipv4/udp_tunnel_core.c | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/bareudp.c b/drivers/net/bareudp.c
index 63fc32fa1af5..6af67cac6bde 100644
--- a/drivers/net/bareudp.c
+++ b/drivers/net/bareudp.c
@@ -307,7 +307,7 @@ static int bareudp_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 		return -ESHUTDOWN;
 
 	rt = udp_tunnel_dst_lookup(skb, dev, bareudp->net, &saddr, info,
-				   IPPROTO_UDP, use_cache);
+				   use_cache);
 
 	if (IS_ERR(rt))
 		return PTR_ERR(rt);
@@ -484,7 +484,7 @@ static int bareudp_fill_metadata_dst(struct net_device *dev,
 		__be32 saddr;
 
 		rt = udp_tunnel_dst_lookup(skb, dev, bareudp->net, &saddr,
-					   info, IPPROTO_UDP, use_cache);
+					   info, use_cache);
 		if (IS_ERR(rt))
 			return PTR_ERR(rt);
 
diff --git a/include/net/udp_tunnel.h b/include/net/udp_tunnel.h
index 11e810ca5088..8f110dbd3784 100644
--- a/include/net/udp_tunnel.h
+++ b/include/net/udp_tunnel.h
@@ -166,7 +166,7 @@ struct rtable *udp_tunnel_dst_lookup(struct sk_buff *skb,
 				     struct net_device *dev,
 				     struct net *net, __be32 *saddr,
 				     const struct ip_tunnel_info *info,
-				     u8 protocol, bool use_cache);
+				     bool use_cache);
 
 struct metadata_dst *udp_tun_rx_dst(struct sk_buff *skb, unsigned short family,
 				    __be16 flags, __be64 tunnel_id,
diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
index 96f93f92b6ce..9b0cfd72d5fd 100644
--- a/net/ipv4/udp_tunnel_core.c
+++ b/net/ipv4/udp_tunnel_core.c
@@ -208,7 +208,7 @@ struct rtable *udp_tunnel_dst_lookup(struct sk_buff *skb,
 				     struct net_device *dev,
 				     struct net *net, __be32 *saddr,
 				     const struct ip_tunnel_info *info,
-				     u8 protocol, bool use_cache)
+				     bool use_cache)
 {
 #ifdef CONFIG_DST_CACHE
 	struct dst_cache *dst_cache;
@@ -227,7 +227,7 @@ struct rtable *udp_tunnel_dst_lookup(struct sk_buff *skb,
 #endif
 	memset(&fl4, 0, sizeof(fl4));
 	fl4.flowi4_mark = skb->mark;
-	fl4.flowi4_proto = protocol;
+	fl4.flowi4_proto = IPPROTO_UDP;
 	fl4.daddr = info->key.u.ipv4.dst;
 	fl4.saddr = info->key.u.ipv4.src;
 	tos = info->key.tos;
-- 
2.40.1

