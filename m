Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21E327BC4C3
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 07:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233897AbjJGFGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 01:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233675AbjJGFGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 01:06:43 -0400
Received: from out-207.mta1.migadu.com (out-207.mta1.migadu.com [IPv6:2001:41d0:203:375::cf])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0252BF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 22:06:40 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696655199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=q7I3d9LwjafU5Kv12eU37aaf8qZaT/OjOVOphwidH2Y=;
        b=QvEOrQlhdKmpbmzesqy3Qzfk18HpjUCqpVfC2Qd5xNkN+I/tGZMybjRDTXE50F/ZLECqcg
        Tw//uSdQORQPNXsUcPAo10ISuHPuhYdKt1rpXAvAwfNiaFHMZv7YMAlUv+zQ17weCYWoU8
        l4S+si4z35nG0b08FnXFpkU9iM1xPn0=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yajun Deng <yajun.deng@linux.dev>,
        Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: [PATCH net-next v7] net/core: Introduce netdev_core_stats_inc()
Date:   Sat,  7 Oct 2023 13:06:21 +0800
Message-Id: <20231007050621.1706331-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although there is a kfree_skb_reason() helper function that can be used to
find the reason why this skb is dropped, but most callers didn't increase
one of rx_dropped, tx_dropped, rx_nohandler and rx_otherhost_dropped.

For the users, people are more concerned about why the dropped in ip
is increasing.

Introduce netdev_core_stats_inc() for trace the caller of
dev_core_stats_*_inc(). Also, add __code to netdev_core_stats_alloc(), as
it's called unlinkly.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
v7: use WRITE_ONCE and READ_ONCE instead of '++'
v6: merge netdev_core_stats and netdev_core_stats_inc together
v5: Access the per cpu pointer before reach the relevant offset.
v4: Introduce netdev_core_stats_inc() instead of export dev_core_stats_*_inc()
v3: __cold should be added to the netdev_core_stats_alloc().
v2: use __cold instead of inline in dev_core_stats().
v1: https://lore.kernel.org/netdev/20230911082016.3694700-1-yajun.deng@linux.dev/
---
 include/linux/netdevice.h | 21 ++++-----------------
 net/core/dev.c            | 20 ++++++++++++++++++--
 2 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index e070a4540fba..11d704bfec9b 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4002,32 +4002,19 @@ static __always_inline bool __is_skb_forwardable(const struct net_device *dev,
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
+void netdev_core_stats_inc(struct net_device *dev, u32 offset);
 
 #define DEV_CORE_STATS_INC(FIELD)						\
 static inline void dev_core_stats_##FIELD##_inc(struct net_device *dev)		\
 {										\
-	struct net_device_core_stats __percpu *p;				\
-										\
-	p = dev_core_stats(dev);						\
-	if (p)									\
-		this_cpu_inc(p->FIELD);						\
+	netdev_core_stats_inc(dev,						\
+			offsetof(struct net_device_core_stats, FIELD));		\
 }
 DEV_CORE_STATS_INC(rx_dropped)
 DEV_CORE_STATS_INC(tx_dropped)
 DEV_CORE_STATS_INC(rx_nohandler)
 DEV_CORE_STATS_INC(rx_otherhost_dropped)
+#undef DEV_CORE_STATS_INC
 
 static __always_inline int ____dev_forward_skb(struct net_device *dev,
 					       struct sk_buff *skb,
diff --git a/net/core/dev.c b/net/core/dev.c
index 606a366cc209..a38ea90771f5 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10497,7 +10497,8 @@ void netdev_stats_to_stats64(struct rtnl_link_stats64 *stats64,
 }
 EXPORT_SYMBOL(netdev_stats_to_stats64);
 
-struct net_device_core_stats __percpu *netdev_core_stats_alloc(struct net_device *dev)
+static __cold struct net_device_core_stats __percpu *netdev_core_stats_alloc(
+		struct net_device *dev)
 {
 	struct net_device_core_stats __percpu *p;
 
@@ -10510,7 +10511,22 @@ struct net_device_core_stats __percpu *netdev_core_stats_alloc(struct net_device
 	/* This READ_ONCE() pairs with the cmpxchg() above */
 	return READ_ONCE(dev->core_stats);
 }
-EXPORT_SYMBOL(netdev_core_stats_alloc);
+
+void netdev_core_stats_inc(struct net_device *dev, u32 offset)
+{
+	/* This READ_ONCE() pairs with the write in netdev_core_stats_alloc() */
+	struct net_device_core_stats __percpu *p = READ_ONCE(dev->core_stats);
+	unsigned long *field;
+
+	if (unlikely(!p))
+		p = netdev_core_stats_alloc(dev);
+
+	if (p) {
+		field = (unsigned long *)((void *)this_cpu_ptr(p) + offset);
+		WRITE_ONCE(*field, READ_ONCE(*field) + 1);
+	}
+}
+EXPORT_SYMBOL_GPL(netdev_core_stats_inc);
 
 /**
  *	dev_get_stats	- get network device statistics
-- 
2.25.1

