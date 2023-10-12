Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDAC7C65AC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 08:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377356AbjJLGew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 02:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347069AbjJLGev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 02:34:51 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8393FBA;
        Wed, 11 Oct 2023 23:34:48 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-538e8eca9c1so1053304a12.3;
        Wed, 11 Oct 2023 23:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697092487; x=1697697287; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5PIkgPW8JUfHwEbEXt9w8uRHHsdsSPbeRNc83sTlpWk=;
        b=chny9sPE3Nt6WNrIj7vPF2Wd1bKaelACpTyoZonEQd+g3xjJg1YxKligFtfNXHQB30
         yuixiQaeYxChIQFVMn7pAjh7nT9e4CHIKVY5c2G2cxlKZFZJNzBPepy5jEgkZdgEBrVS
         FFVEOi5U5iKXia0C6aM/AoiKJhV1hS0zrIHy/osHJ2BH49i/2BOAtbLerXXYoJOFuhCY
         iIVhg7p2qR2WqOgqMP6lKa7DVDWwpYZxM9IsQdvf1GcOj6QWWAkDcDrPu9r369ZQGCdE
         PWwB+cbqGeuZyv4hb3/p0mOwr+GiQ8Oqx08vD5hyd2zPj4F5QtRq4HCzzoxd0fzNa2Uz
         N+mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697092487; x=1697697287;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5PIkgPW8JUfHwEbEXt9w8uRHHsdsSPbeRNc83sTlpWk=;
        b=bYv8MMFNPNS4Iqu5K1a3bpN+gTWRDG7HsH15dtwFe6N7OxEepFgi2DvbuQ+bqpeigR
         9a1tXFs81Hbwbm8XFdDGRaqZ4IpfuZBuDzriPgF1nrZOoMcoEI88wqIc0b5epcsa2BnB
         avIRGZ1l3H0RvxQBMV/0gjU8czMpYyxLBXzAUzQBCJPEYxCdzOpp6Gy2JfnHYHKZiwd3
         Wt8vOKzm+9ITHpV2uPIBu5OaMky4OSptALBXZZGc7Gz3ECKQ0eJAraINvKGt0hKSU26n
         dtxIARmSi5Bku4h+z9RGBx2N/jOCSQKowbDrJ/VBt8jhz6U6t1sljdarz9tuHOVtmBkk
         nLkA==
X-Gm-Message-State: AOJu0Yxk7yPpQeDPVePXnJ6teBdA/QkkwZvhpZ3c6Ceh02RBtuDJi04D
        5JKjV0BRQcPoazDWo0jvQbw=
X-Google-Smtp-Source: AGHT+IHKoqOogbSjh+HQMlJa+qjY7oWFhk0GJ8WeueGzUD/T6m/rl4rignzsiqX1r0/rQxdMSEszfA==
X-Received: by 2002:a05:6402:5d3:b0:53d:a727:3846 with SMTP id n19-20020a05640205d300b0053da7273846mr5555830edx.20.1697092486735;
        Wed, 11 Oct 2023 23:34:46 -0700 (PDT)
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:78dc:282:cf18:8032])
        by smtp.gmail.com with ESMTPSA id dn5-20020a05640222e500b0053dd8898f75sm1629149edb.81.2023.10.11.23.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 23:34:46 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] appletalk: remove special handling code for ipddp
Date:   Thu, 12 Oct 2023 08:34:43 +0200
Message-Id: <20231012063443.22368-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 1dab47139e61 ("appletalk: remove ipddp driver") removes the
config IPDDP, there is some minor code clean-up possible in the appletalk
network layer.

Remove some code in appletalk layer after the ipddp driver is gone.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 net/appletalk/ddp.c | 36 ------------------------------------
 1 file changed, 36 deletions(-)

diff --git a/net/appletalk/ddp.c b/net/appletalk/ddp.c
index 8978fb6212ff..9ba04a69ec2a 100644
--- a/net/appletalk/ddp.c
+++ b/net/appletalk/ddp.c
@@ -1284,39 +1284,6 @@ static int atalk_getname(struct socket *sock, struct sockaddr *uaddr,
 	return err;
 }
 
-#if IS_ENABLED(CONFIG_IPDDP)
-static __inline__ int is_ip_over_ddp(struct sk_buff *skb)
-{
-	return skb->data[12] == 22;
-}
-
-static int handle_ip_over_ddp(struct sk_buff *skb)
-{
-	struct net_device *dev = __dev_get_by_name(&init_net, "ipddp0");
-	struct net_device_stats *stats;
-
-	/* This needs to be able to handle ipddp"N" devices */
-	if (!dev) {
-		kfree_skb(skb);
-		return NET_RX_DROP;
-	}
-
-	skb->protocol = htons(ETH_P_IP);
-	skb_pull(skb, 13);
-	skb->dev   = dev;
-	skb_reset_transport_header(skb);
-
-	stats = netdev_priv(dev);
-	stats->rx_packets++;
-	stats->rx_bytes += skb->len + 13;
-	return netif_rx(skb);  /* Send the SKB up to a higher place. */
-}
-#else
-/* make it easy for gcc to optimize this test out, i.e. kill the code */
-#define is_ip_over_ddp(skb) 0
-#define handle_ip_over_ddp(skb) 0
-#endif
-
 static int atalk_route_packet(struct sk_buff *skb, struct net_device *dev,
 			      struct ddpehdr *ddp, __u16 len_hops, int origlen)
 {
@@ -1480,9 +1447,6 @@ static int atalk_rcv(struct sk_buff *skb, struct net_device *dev,
 		return atalk_route_packet(skb, dev, ddp, len_hops, origlen);
 	}
 
-	/* if IP over DDP is not selected this code will be optimized out */
-	if (is_ip_over_ddp(skb))
-		return handle_ip_over_ddp(skb);
 	/*
 	 * Which socket - atalk_search_socket() looks for a *full match*
 	 * of the <net, node, port> tuple.
-- 
2.17.1

