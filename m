Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49EB79A5E4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 10:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234367AbjIKIUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 04:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjIKIUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 04:20:42 -0400
Received: from out-216.mta1.migadu.com (out-216.mta1.migadu.com [95.215.58.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18379BB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 01:20:37 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1694420436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=w8KgKH+XjJLXOnaYRASDb5V6iMHBTszQ5jP3aUDJPyM=;
        b=GDg0wedFWadWwg2xEaAmtg9r1uKbJBgDY3VuvBno+uV/us+TU+Tybz0KzEK8T5xLHRyM0G
        sn5ysv8xw9YFLGSxuvaZFhKQrIyWAWnjITVN2FTSMpmgBMRssfGpMLmranpvZXpvV/oTG8
        mW9Gq3w7upw/hJnUq8YZITIoGDihbDQ=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, horms@kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH] net/core: Export dev_core_stats_rx_dropped_inc sets
Date:   Mon, 11 Sep 2023 16:20:16 +0800
Message-Id: <20230911082016.3694700-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although there is a kfree_skb_reason() helper function that can be used
to find the reason for dropped packets, but most callers didn't increase
one of rx_dropped, tx_dropped, rx_nohandler and rx_otherhost_dropped.

For the users, people are more concerned about why the dropped in ifconfig
is increasing. So we can export dev_core_stats_rx_dropped_inc sets,
which users would trace them know why rx_dropped is increasing.

Export dev_core_stats_{rx_dropped, tx_dropped, rx_nohandler,
rx_otherhost_dropped}_inc for trace. Also, move dev_core_stats()
and netdev_core_stats_alloc() in dev.c, because they are not called
externally.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 include/linux/netdevice.h | 32 +++++---------------------------
 net/core/dev.c            | 30 ++++++++++++++++++++++++++++--
 2 files changed, 33 insertions(+), 29 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 0896aaa91dd7..879b01c85ba4 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3954,6 +3954,11 @@ int dev_forward_skb_nomtu(struct net_device *dev, struct sk_buff *skb);
 bool is_skb_forwardable(const struct net_device *dev,
 			const struct sk_buff *skb);
 
+void dev_core_stats_rx_dropped_inc(struct net_device *dev);
+void dev_core_stats_tx_dropped_inc(struct net_device *dev);
+void dev_core_stats_rx_nohandler_inc(struct net_device *dev);
+void dev_core_stats_rx_otherhost_dropped_inc(struct net_device *dev);
+
 static __always_inline bool __is_skb_forwardable(const struct net_device *dev,
 						 const struct sk_buff *skb,
 						 const bool check_mtu)
@@ -3980,33 +3985,6 @@ static __always_inline bool __is_skb_forwardable(const struct net_device *dev,
 	return false;
 }
 
-struct net_device_core_stats __percpu *netdev_core_stats_alloc(struct net_device *dev);
-
-static inline struct net_device_core_stats __percpu *dev_core_stats(struct net_device *dev)
-{
-	/* This READ_ONCE() pairs with the write in netdev_core_stats_alloc() */
-	struct net_device_core_stats __percpu *p = READ_ONCE(dev->core_stats);
-
-	if (likely(p))
-		return p;
-
-	return netdev_core_stats_alloc(dev);
-}
-
-#define DEV_CORE_STATS_INC(FIELD)						\
-static inline void dev_core_stats_##FIELD##_inc(struct net_device *dev)		\
-{										\
-	struct net_device_core_stats __percpu *p;				\
-										\
-	p = dev_core_stats(dev);						\
-	if (p)									\
-		this_cpu_inc(p->FIELD);						\
-}
-DEV_CORE_STATS_INC(rx_dropped)
-DEV_CORE_STATS_INC(tx_dropped)
-DEV_CORE_STATS_INC(rx_nohandler)
-DEV_CORE_STATS_INC(rx_otherhost_dropped)
-
 static __always_inline int ____dev_forward_skb(struct net_device *dev,
 					       struct sk_buff *skb,
 					       const bool check_mtu)
diff --git a/net/core/dev.c b/net/core/dev.c
index ccff2b6ef958..32ba730405b4 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10475,7 +10475,7 @@ void netdev_stats_to_stats64(struct rtnl_link_stats64 *stats64,
 }
 EXPORT_SYMBOL(netdev_stats_to_stats64);
 
-struct net_device_core_stats __percpu *netdev_core_stats_alloc(struct net_device *dev)
+static struct net_device_core_stats __percpu *netdev_core_stats_alloc(struct net_device *dev)
 {
 	struct net_device_core_stats __percpu *p;
 
@@ -10488,7 +10488,33 @@ struct net_device_core_stats __percpu *netdev_core_stats_alloc(struct net_device
 	/* This READ_ONCE() pairs with the cmpxchg() above */
 	return READ_ONCE(dev->core_stats);
 }
-EXPORT_SYMBOL(netdev_core_stats_alloc);
+
+static inline struct net_device_core_stats __percpu *dev_core_stats(struct net_device *dev)
+{
+	/* This READ_ONCE() pairs with the write in netdev_core_stats_alloc() */
+	struct net_device_core_stats __percpu *p = READ_ONCE(dev->core_stats);
+
+	if (likely(p))
+		return p;
+
+	return netdev_core_stats_alloc(dev);
+}
+
+#define DEV_CORE_STATS_INC(FIELD)				\
+void dev_core_stats_##FIELD##_inc(struct net_device *dev)	\
+{								\
+	struct net_device_core_stats __percpu *p;		\
+								\
+	p = dev_core_stats(dev);				\
+	if (p)							\
+		this_cpu_inc(p->FIELD);				\
+}								\
+EXPORT_SYMBOL(dev_core_stats_##FIELD##_inc)
+
+DEV_CORE_STATS_INC(rx_dropped);
+DEV_CORE_STATS_INC(tx_dropped);
+DEV_CORE_STATS_INC(rx_nohandler);
+DEV_CORE_STATS_INC(rx_otherhost_dropped);
 
 /**
  *	dev_get_stats	- get network device statistics
-- 
2.25.1

