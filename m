Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71AD979C7AA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbjILHG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbjILHGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:06:14 -0400
Received: from out-228.mta1.migadu.com (out-228.mta1.migadu.com [95.215.58.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1D8E78
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:06:10 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1694502369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=MFojP+VTFmF9qBLP1AthdxD+vEZ5K370QDnHiNcw7DI=;
        b=OpLGnB1ZGzwGaUuwG/vw4UzvSqw1z5K7Q/sWS6WDnbATUG6TT5+mDuQvVmaTfGVKKnADry
        h2P0/tGmusIjCVL7XSbJ3GqHBBMcDUCqGtGLxp94OeGMoaOGRRaIwMWEhJG5YPKwPNG3wD
        gvwBYdFKPlnSfiD9Sjr/Dz8leMniQmM=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, horms@kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH net-next v2] net/core: Export dev_core_stats_rx_dropped_inc sets
Date:   Tue, 12 Sep 2023 15:05:53 +0800
Message-Id: <20230912070553.1008686-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although there is a kfree_skb_reason() helper function that can be used
to find the reason for dropped packets, but most callers didn't increase
one of rx_dropped, tx_dropped, rx_nohandler and rx_otherhost_dropped.

For the users, people are more concerned about why the dropped in ip
is increasing. So we can export dev_core_stats_rx_dropped_inc sets,
which users would trace them know why rx_dropped is increasing.

Export dev_core_stats_{rx_dropped, tx_dropped, rx_nohandler,
rx_otherhost_dropped}_inc for trace. Also, move dev_core_stats()
and netdev_core_stats_alloc() to dev.c, as they are not called
externally.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
v2: use __cold instead of inline in dev_core_stats().
v1: https://lore.kernel.org/netdev/20230911082016.3694700-1-yajun.deng@linux.dev/
---
 include/linux/netdevice.h | 32 +++++---------------------------
 net/core/dev.c            | 32 ++++++++++++++++++++++++++++++--
 2 files changed, 35 insertions(+), 29 deletions(-)

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
index ccff2b6ef958..b04751635fb6 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10475,7 +10475,7 @@ void netdev_stats_to_stats64(struct rtnl_link_stats64 *stats64,
 }
 EXPORT_SYMBOL(netdev_stats_to_stats64);
 
-struct net_device_core_stats __percpu *netdev_core_stats_alloc(struct net_device *dev)
+static struct net_device_core_stats __percpu *netdev_core_stats_alloc(struct net_device *dev)
 {
 	struct net_device_core_stats __percpu *p;
 
@@ -10488,7 +10488,35 @@ struct net_device_core_stats __percpu *netdev_core_stats_alloc(struct net_device
 	/* This READ_ONCE() pairs with the cmpxchg() above */
 	return READ_ONCE(dev->core_stats);
 }
-EXPORT_SYMBOL(netdev_core_stats_alloc);
+
+static __cold struct net_device_core_stats __percpu *dev_core_stats(struct net_device *dev)
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
+
+#undef DEV_CORE_STATS_INC
 
 /**
  *	dev_get_stats	- get network device statistics
-- 
2.25.1

