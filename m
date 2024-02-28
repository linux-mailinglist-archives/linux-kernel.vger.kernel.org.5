Return-Path: <linux-kernel+bounces-85321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CECC886B42C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B866281314
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FAA615D5D5;
	Wed, 28 Feb 2024 16:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IjvtbXn9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746CE15B98B;
	Wed, 28 Feb 2024 16:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709136460; cv=none; b=BrKTy96pXjgiT2MHDMzBTpdmsBbkKAr4FktT9VKxFh5R07CmacAu0yYtjPMYEROWxhg/pO7nq4xvuKOezW1doKgYZLX0t/7olPZYRaHjPqfNZBXylabTO/w6VS2F59Yg5hvsuBFFXSTkEKYkVzwqCd3+Umcp51CwUINS0NKfUJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709136460; c=relaxed/simple;
	bh=GdUbV1NGoO5EFJmeAqLlDDgJzYkjRPcGGbPikMTrOuk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b0IPhSTnH39sla1MMV93uLJeO5cn9pRxJREvfUwI3yxFwSMripTbdh8VeXoUkf2nGOaDq6h3oQE695T3hb3E1bNDmk7dPksDEasFU5uI7CRrJir+PQ0oTp72jSkK0CYt4aQG/nMZTr9LpXx4ICbkzlrupIMdZQ9kParBnWezLMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IjvtbXn9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8746C433C7;
	Wed, 28 Feb 2024 16:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709136459;
	bh=GdUbV1NGoO5EFJmeAqLlDDgJzYkjRPcGGbPikMTrOuk=;
	h=From:To:Cc:Subject:Date:From;
	b=IjvtbXn9OIoPe9Zco0Mr3HF5gXrsyY29g6QuTIhVhLvnTokyeeiNb0sJLMeaKSN2B
	 Rx/MkVsP/53qUL7WG4NED611I01o6ZEJBYYeW6C/yijAMQdL/d2D0L1/jcwcht2aBf
	 Q6TNB+Nz9i66axzLbqkoG8VVMEaZWS0tYvM61T4EnRfTI5udDELbb2V4gqDmUxVN1c
	 gZ2xhk7O4HtRug47spGO6iTceRWcXRaUnjQdic2CL01wh9LhJmR1QdpDtA7zw19jx0
	 DS93j8vta8rPRRQ9WziZilZ1nOH52eV0I+SSdv9u+LgvIP7l/IAO9XNxe3NrhJfr5I
	 fPcgoW35Xsf5A==
From: Arnd Bergmann <arnd@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Breno Leitao <leitao@debian.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Simon Horman <horms@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Christian Marangi <ansuelsmth@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] net: bql: fix building with BQL disabled
Date: Wed, 28 Feb 2024 17:06:56 +0100
Message-Id: <20240228160732.1662287-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

It is now possible to disable BQL, but that causes the cpsw driver to break:

drivers/net/ethernet/ti/am65-cpsw-nuss.c:297:28: error: no member named 'dql' in 'struct netdev_queue'
  297 |                    dql_avail(&netif_txq->dql),

There is already a helper function in net/sch_generic.h that could
be used to help here. Move its implementation into the common
linux/netdevice.h along with the other bql interfaces and change
both users over to the new interface.

Fixes: ea7f3cfaa588 ("net: bql: allow the config to be disabled")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: merge the two identical implementations
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c |  2 +-
 include/linux/netdevice.h                | 10 ++++++++++
 include/net/sch_generic.h                |  7 +------
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 9d2f4ac783e4..2939a21ca74f 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -294,7 +294,7 @@ static void am65_cpsw_nuss_ndo_host_tx_timeout(struct net_device *ndev,
 		   txqueue,
 		   netif_tx_queue_stopped(netif_txq),
 		   jiffies_to_msecs(jiffies - trans_start),
-		   dql_avail(&netif_txq->dql),
+		   netdev_queue_dql_avail(netif_txq),
 		   k3_cppi_desc_pool_avail(tx_chn->desc_pool));
 
 	if (netif_tx_queue_stopped(netif_txq)) {
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 4236debc79a7..cd6fdc2e6948 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3493,6 +3493,16 @@ static inline void netdev_queue_set_dql_min_limit(struct netdev_queue *dev_queue
 #endif
 }
 
+static inline int netdev_queue_dql_avail(const struct netdev_queue *txq)
+{
+#ifdef CONFIG_BQL
+	/* Non-BQL migrated drivers will return 0, too. */
+	return dql_avail(&txq->dql);
+#else
+	return 0;
+#endif
+}
+
 /**
  *	netdev_txq_bql_enqueue_prefetchw - prefetch bql data for write
  *	@dev_queue: pointer to transmit queue
diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 934fdb977551..cefe0c4bdae3 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -238,12 +238,7 @@ static inline bool qdisc_may_bulk(const struct Qdisc *qdisc)
 
 static inline int qdisc_avail_bulklimit(const struct netdev_queue *txq)
 {
-#ifdef CONFIG_BQL
-	/* Non-BQL migrated drivers will return 0, too. */
-	return dql_avail(&txq->dql);
-#else
-	return 0;
-#endif
+	return netdev_queue_dql_avail(txq);
 }
 
 struct Qdisc_class_ops {
-- 
2.39.2


