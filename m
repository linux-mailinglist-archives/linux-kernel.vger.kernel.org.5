Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8270A7BD529
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 10:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234446AbjJII01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 04:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234426AbjJII0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 04:26:18 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9478DA6;
        Mon,  9 Oct 2023 01:26:16 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-533c8f8f91dso7398395a12.0;
        Mon, 09 Oct 2023 01:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696839975; x=1697444775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Os97uJkJsOrtu1p2tFHU0znx2hLK/XLtOzuWt/ufDjM=;
        b=N3C5cU4FqpPgupmpRkwNj5ye1+wZkBcGTYetrNx9WkZAK1rYqbfawkHSqdwMG3K3RE
         HkOV3SgJPON0/i1cHwG7pFCzUcx3S/WKceLLH43UI1oDMG3dBcXkj+yMei01/+hunRdD
         hs1UdetnOUmNjWmrM+DnVT45fBan0bk0zQROlkGLMQbqwUj8lTAbMIfvKWgSD8H44uTm
         AcbSXtS8A1aOW+kNsZSJmRHCjOLeOOTfzLFAX5swsXm62v64PngZ1doLerdJy3NbgKU3
         8QdscxLFnC/I39c6JTXXLzs6XazU6jhToJhKkyc2MXH469UHNM/b5HKGYtXKK74TvjTB
         r9yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696839975; x=1697444775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Os97uJkJsOrtu1p2tFHU0znx2hLK/XLtOzuWt/ufDjM=;
        b=EVsmCwv5AcMl7le+N4QQXhshl1lWW47VcJXpU0qxXkHWnPwQ6Go18ctBHbp2SlFo5m
         9oMZ6hi4O1A+5aXhu3t44cODxaTb1QBCjWLvzlnEymRk3BIXbDwzH0llHLK1Bbql9EgQ
         lnRy8OM+q6+hlsAhjTQ7moSpKu2g3vWN33cDlBqcWr/Un47CsoOQvASVxYjmxTbiQ0x3
         RdLlsdx1BXCLpSKYhST21nreWLcMNmYSBRuhI3MsyuxXxM1XNDJJz1Me5J8lLOB8qNBr
         b2xUiSQpWf/XOtXlHZN3gDXJV9qfuLaMPdDclaokI4LuO5BiDROpRH0qGDvMW4vYvPYo
         rWJQ==
X-Gm-Message-State: AOJu0YyR9e3QgcSzrmdS95Cspyct93mVM5o1tvQ9B36FPX4fig4iT0ut
        JGon9GPqEqT0DI6/6kss+xCliLxNSIg=
X-Google-Smtp-Source: AGHT+IHVbSbHzTw0t3kXZPAeQfB7tNuAcPJxTru1b461a2301Jo93Irw/iY8dgHDGybRmc8CO3hxng==
X-Received: by 2002:aa7:c746:0:b0:52a:38c3:1b49 with SMTP id c6-20020aa7c746000000b0052a38c31b49mr11361653eds.40.1696839974917;
        Mon, 09 Oct 2023 01:26:14 -0700 (PDT)
Received: from tp.home.arpa (host-79-24-102-58.retail.telecomitalia.it. [79.24.102.58])
        by smtp.gmail.com with ESMTPSA id p22-20020a05640210d600b00530a9488623sm5844810edu.46.2023.10.09.01.26.14
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
Subject: [PATCH net-next 2/7] ipv4: remove "proto" argument from udp_tunnel_dst_lookup()
Date:   Mon,  9 Oct 2023 10:20:54 +0200
Message-Id: <20231009082059.2500217-3-b.galvani@gmail.com>
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

The function is now UDP-specific, the protocol is always IPPROTO_UDP.

Suggested-by: Guillaume Nault <gnault@redhat.com>
Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
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

