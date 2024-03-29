Return-Path: <linux-kernel+bounces-125200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B216189220B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 18:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 678B4288110
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 17:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F43A137C38;
	Fri, 29 Mar 2024 17:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="clBmNzVr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22991369A4;
	Fri, 29 Mar 2024 17:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711731646; cv=none; b=CF0C36p+NjgYobo0ff1vqF9KW41FiFg3qXchlP1SkO19fWm4kgHWYgaKC+lqzM54WUvdX0KLKmAZMW79hzw659yRb8mLKw8NLpl53sgyHZUC4gNArwX6iaRq/9OBBEHxOm0Tpk1cbXyNjFs8cLCNOTsw7dPMsfx/Jng+4kNUx1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711731646; c=relaxed/simple;
	bh=WeazQOW8wdRtFlvcL7dquXjhXH5BZ+2tlYJx7xq4fYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NyFcQ2czxyryTfuhg3M4GwlKZLMvOeNih5bfnblrlCVxSyLymklW4RwEHQCNOi4jCskVPaea5yXj1yNNKYeMpVPd/uzxaVDylBRbxeXiLi+ynwf3h+RYPo4czXsJANKSSCgH3VJYvwo8l23pi6AejRJmNqhz1VsnS1EeUfh+/N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=clBmNzVr; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711731645; x=1743267645;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WeazQOW8wdRtFlvcL7dquXjhXH5BZ+2tlYJx7xq4fYk=;
  b=clBmNzVrqSq2uTJAlEqkcyM/sxSeDlXc66C7r5V0lDS6VDY0Pe3xfc0z
   4IMSWgt6m5ZyHz92WY5YWwuL+6Wz1OZyc834R1cisVvSIoZduIr8gd3qC
   aSCzVCVLE4MipwZcpK6bFJwTYzD4Su9L7MHNp9e8IBALG7OFsVO76+j/o
   54MnF9zO4kNam0lEWtsVXnTgDxOtYZMnbCP+I/I6wi749nqfdClp+EuGS
   uz6K95Sy4Zyx3ymgihb3n2sEx17Ay2kCFX36Muw7bE2RBDpiIoS4LqU/r
   ARlmE3pfPGeyXonvjj6UxgvgkO0nxS9lCOp8ITaWQaI4AcYSOqDoUIg/J
   w==;
X-CSE-ConnectionGUID: 0ETOfJjmQPC6Ct/S41zHHQ==
X-CSE-MsgGUID: B/CLeIGPSbewe3DOtgEe1Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="18367623"
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="18367623"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 10:00:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="48231990"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa001.fm.intel.com with ESMTP; 29 Mar 2024 10:00:41 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Dmitry Safonov <0x7f454c46@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/2] netdev_queues: fix -Wshadow / Sparse shadow warnings throughout the file
Date: Fri, 29 Mar 2024 18:00:00 +0100
Message-ID: <20240329170000.3241460-3-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240329170000.3241460-1-aleksander.lobakin@intel.com>
References: <20240329170000.3241460-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the following spam coming from <net/netdev_queues.h> when building
with W=12 and/or C=1:

Clang:

drivers/net/ethernet/intel/idpf/idpf_txrx.c:1992:9: warning: declaration shadows a local variable [-Wshadow]
 1992 |         return netif_txq_maybe_stop(nq, IDPF_DESC_UNUSED(tx_q), size, size);
      |                ^
/include/net/netdev_queues.h:137:11: note: expanded from macro 'netif_txq_maybe_stop'
  137 |                         _res = netif_txq_try_stop(txq, get_desc, start_thrs); \
      |                                ^
/include/net/netdev_queues.h:92:7: note: expanded from macro 'netif_txq_try_stop'
   92 |                 int _res;                                               \
      |                     ^
drivers/net/ethernet/intel/idpf/idpf_txrx.c:1992:9: note: previous declaration is here
/include/net/netdev_queues.h:133:7: note: expanded from macro 'netif_txq_maybe_stop'
  133 |                 int _res;                                               \
      |                     ^

Sparse:

drivers/net/ethernet/intel/idpf/idpf_txrx.c:1992:16: warning: symbol '_res' shadows an earlier one
drivers/net/ethernet/intel/idpf/idpf_txrx.c:1992:16: originally declared here

Use __UNIQUE_ID() in all of the macros which declare local variables.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/netdev_queues.h | 54 +++++++++++++++++++++++++++----------
 1 file changed, 40 insertions(+), 14 deletions(-)

diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
index 1ec408585373..317d6bfe32c7 100644
--- a/include/net/netdev_queues.h
+++ b/include/net/netdev_queues.h
@@ -87,14 +87,14 @@ struct netdev_stat_ops {
  * be updated before invoking the macros.
  */
 
-#define netif_txq_try_stop(txq, get_desc, start_thrs)			\
+#define _netif_txq_try_stop(txq, get_desc, start_thrs, _res)		\
 	({								\
 		int _res;						\
 									\
 		netif_tx_stop_queue(txq);				\
 		/* Producer index and stop bit must be visible		\
 		 * to consumer before we recheck.			\
-		 * Pairs with a barrier in __netif_txq_completed_wake(). \
+		 * Pairs with a barrier in ___netif_txq_completed_wake(). \
 		 */							\
 		smp_mb__after_atomic();					\
 									\
@@ -107,16 +107,20 @@ struct netdev_stat_ops {
 			_res = -1;					\
 		}							\
 		_res;							\
-	})								\
+	})
+#define netif_txq_try_stop(txq, get_desc, start_thrs)			\
+	_netif_txq_try_stop(txq, get_desc, start_thrs,			\
+			    __UNIQUE_ID(res_))
 
 /**
- * netif_txq_maybe_stop() - locklessly stop a Tx queue, if needed
+ * _netif_txq_maybe_stop() - locklessly stop a Tx queue, if needed
  * @txq:	struct netdev_queue to stop/start
  * @get_desc:	get current number of free descriptors (see requirements below!)
  * @stop_thrs:	minimal number of available descriptors for queue to be left
  *		enabled
  * @start_thrs:	minimal number of descriptors to re-enable the queue, can be
  *		equal to @stop_thrs or higher to avoid frequent waking
+ * @_res: __UNIQUE_ID() to avoid variable name clash
  *
  * All arguments may be evaluated multiple times, beware of side effects.
  * @get_desc must be a formula or a function call, it must always
@@ -128,7 +132,8 @@ struct netdev_stat_ops {
  *	 1 if the queue was left enabled
  *	-1 if the queue was re-enabled (raced with waking)
  */
-#define netif_txq_maybe_stop(txq, get_desc, stop_thrs, start_thrs)	\
+#define _netif_txq_maybe_stop(txq, get_desc, stop_thrs, start_thrs,	\
+			      _res)					\
 	({								\
 		int _res;						\
 									\
@@ -136,7 +141,10 @@ struct netdev_stat_ops {
 		if (unlikely(get_desc < stop_thrs))			\
 			_res = netif_txq_try_stop(txq, get_desc, start_thrs); \
 		_res;							\
-	})								\
+	})
+#define netif_txq_maybe_stop(txq, get_desc, stop_thrs, start_thrs)	\
+	_netif_txq_maybe_stop(txq, get_desc, stop_thrs, start_thrs,	\
+			      __UNIQUE_ID(res_))
 
 /* Variant of netdev_tx_completed_queue() which guarantees smp_mb() if
  * @bytes != 0, regardless of kernel config.
@@ -152,7 +160,7 @@ netdev_txq_completed_mb(struct netdev_queue *dev_queue,
 }
 
 /**
- * __netif_txq_completed_wake() - locklessly wake a Tx queue, if needed
+ * ___netif_txq_completed_wake() - locklessly wake a Tx queue, if needed
  * @txq:	struct netdev_queue to stop/start
  * @pkts:	number of packets completed
  * @bytes:	number of bytes completed
@@ -160,6 +168,7 @@ netdev_txq_completed_mb(struct netdev_queue *dev_queue,
  * @start_thrs:	minimal number of descriptors to re-enable the queue
  * @down_cond:	down condition, predicate indicating that the queue should
  *		not be woken up even if descriptors are available
+ * @_res: __UNIQUE_ID() to avoid variable name clash
  *
  * All arguments may be evaluated multiple times.
  * @get_desc must be a formula or a function call, it must always
@@ -171,15 +180,15 @@ netdev_txq_completed_mb(struct netdev_queue *dev_queue,
  *	 1 if the queue was already enabled (or disabled but @down_cond is true)
  *	-1 if the queue was left unchanged (@start_thrs not reached)
  */
-#define __netif_txq_completed_wake(txq, pkts, bytes,			\
-				   get_desc, start_thrs, down_cond)	\
+#define ___netif_txq_completed_wake(txq, pkts, bytes, get_desc,		\
+				    start_thrs, down_cond, _res)	\
 	({								\
 		int _res;						\
 									\
 		/* Report to BQL and piggy back on its barrier.		\
 		 * Barrier makes sure that anybody stopping the queue	\
 		 * after this point sees the new consumer index.	\
-		 * Pairs with barrier in netif_txq_try_stop().		\
+		 * Pairs with barrier in _netif_txq_try_stop().		\
 		 */							\
 		netdev_txq_completed_mb(txq, pkts, bytes);		\
 									\
@@ -194,30 +203,43 @@ netdev_txq_completed_mb(struct netdev_queue *dev_queue,
 		}							\
 		_res;							\
 	})
+#define __netif_txq_completed_wake(txq, pkts, bytes, get_desc,		\
+				   start_thrs, down_cond)		\
+	___netif_txq_completed_wake(txq, pkts, bytes, get_desc,		\
+				    start_thrs, down_cond,		\
+				    __UNIQUE_ID(res_))
 
 #define netif_txq_completed_wake(txq, pkts, bytes, get_desc, start_thrs) \
 	__netif_txq_completed_wake(txq, pkts, bytes, get_desc, start_thrs, false)
 
 /* subqueue variants follow */
 
-#define netif_subqueue_try_stop(dev, idx, get_desc, start_thrs)		\
+#define _netif_subqueue_try_stop(dev, idx, get_desc, start_thrs, txq)	\
 	({								\
 		struct netdev_queue *txq;				\
 									\
 		txq = netdev_get_tx_queue(dev, idx);			\
 		netif_txq_try_stop(txq, get_desc, start_thrs);		\
 	})
+#define netif_subqueue_try_stop(dev, idx, get_desc, start_thrs)		\
+	_netif_subqueue_try_stop(dev, idx, get_desc, start_thrs,	\
+				 __UNIQUE_ID(txq_))
 
-#define netif_subqueue_maybe_stop(dev, idx, get_desc, stop_thrs, start_thrs) \
+#define _netif_subqueue_maybe_stop(dev, idx, get_desc, stop_thrs,	\
+				   start_thrs, txq)			\
 	({								\
 		struct netdev_queue *txq;				\
 									\
 		txq = netdev_get_tx_queue(dev, idx);			\
 		netif_txq_maybe_stop(txq, get_desc, stop_thrs, start_thrs); \
 	})
+#define netif_subqueue_maybe_stop(dev, idx, get_desc, stop_thrs,	\
+				  start_thrs)				\
+	_netif_subqueue_maybe_stop(dev, idx, get_desc, stop_thrs,	\
+				   start_thrs, __UNIQUE_ID(txq_))
 
-#define netif_subqueue_completed_wake(dev, idx, pkts, bytes,		\
-				      get_desc, start_thrs)		\
+#define _netif_subqueue_completed_wake(dev, idx, pkts, bytes, get_desc,	\
+				       start_thrs, txq)			\
 	({								\
 		struct netdev_queue *txq;				\
 									\
@@ -225,5 +247,9 @@ netdev_txq_completed_mb(struct netdev_queue *dev_queue,
 		netif_txq_completed_wake(txq, pkts, bytes,		\
 					 get_desc, start_thrs);		\
 	})
+#define netif_subqueue_completed_wake(dev, idx, pkts, bytes, get_desc,	\
+				      start_thrs)			\
+	_netif_subqueue_completed_wake(dev, idx, pkts, bytes, get_desc,	\
+				       start_thrs, __UNIQUE_ID(txq_))
 
 #endif
-- 
2.44.0


