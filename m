Return-Path: <linux-kernel+bounces-8506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9346381B8C4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B13728F288
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D077CCF9;
	Thu, 21 Dec 2023 13:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EG1rSHQg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9038A7CCE2;
	Thu, 21 Dec 2023 13:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703166059; x=1734702059;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vMiMG5i4IMeAwCIJE0Amw6vwaY6iALjWG84OggdjeGw=;
  b=EG1rSHQgH3wdK+QReq8kL+GnRP2MXSf8zSov1CqPZp14GNSS6NWvxMtt
   Nwf3gvNqU1sd+TeMTluzEw9mvW5uZ9cmBcXg+PTXi9hzG940X472C6kAz
   vLTJPvxk6aJ97kV9O70Q5wu+Y+JJ2QdmBZdnrPZXD1LxKtv0rtsLZOIdG
   z8DG+g78GMSlfgJX7atfxz+aWaBzurRKnYhmV/mTA1VebvjrsVsFmnoRw
   VuJG6YLIJjGoNrDyJpQSd4X5z2HRgoqJzqlxHdVrX+JhJnH7Rh0aTQj7j
   lr5RIG9L2aJ7hukoCsBCkXzkXw+ugJEUlye1C+/1oHYQ5N9Q4NYA/PUnw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="9446071"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="9446071"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 05:40:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="1108105180"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="1108105180"
Received: from pglc00021.png.intel.com ([10.221.207.41])
  by fmsmga005.fm.intel.com with ESMTP; 21 Dec 2023 05:40:55 -0800
From: <deepakx.nagaraju@intel.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jdavem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	mun.yew.tham@intel.com,
	Nagaraju DeepakX <deepakx.nagaraju@intel.com>,
	Andy Schevchenko <andriy.schevchenko@linux.intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH v2 3/4] net: ethernet: altera: move read write functions
Date: Thu, 21 Dec 2023 21:40:40 +0800
Message-Id: <20231221134041.27104-4-deepakx.nagaraju@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20231221134041.27104-1-deepakx.nagaraju@intel.com>
References: <20231213071112.18242-6-deepakx.nagaraju@intel.com>
 <20231221134041.27104-1-deepakx.nagaraju@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nagaraju DeepakX <deepakx.nagaraju@intel.com>

Move read write functions from altera_tse.h to altera_utils.h
so it can be shared with future altera ethernet IP's.

Signed-off-by: Nagaraju DeepakX <deepakx.nagaraju@intel.com>
Reviewed-by: Andy Schevchenko <andriy.schevchenko@linux.intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/altera/altera_tse.h      | 45 -------------------
 .../net/ethernet/altera/altera_tse_ethtool.c  |  1 +
 drivers/net/ethernet/altera/altera_utils.h    | 43 ++++++++++++++++++
 3 files changed, 44 insertions(+), 45 deletions(-)

diff --git a/drivers/net/ethernet/altera/altera_tse.h b/drivers/net/ethernet/altera/altera_tse.h
index 82f2363a45cd..4874139e7cdf 100644
--- a/drivers/net/ethernet/altera/altera_tse.h
+++ b/drivers/net/ethernet/altera/altera_tse.h
@@ -483,49 +483,4 @@ struct altera_tse_private {
  */
 void altera_tse_set_ethtool_ops(struct net_device *);

-static inline
-u32 csrrd32(void __iomem *mac, size_t offs)
-{
-	void __iomem *paddr = (void __iomem *)((uintptr_t)mac + offs);
-	return readl(paddr);
-}
-
-static inline
-u16 csrrd16(void __iomem *mac, size_t offs)
-{
-	void __iomem *paddr = (void __iomem *)((uintptr_t)mac + offs);
-	return readw(paddr);
-}
-
-static inline
-u8 csrrd8(void __iomem *mac, size_t offs)
-{
-	void __iomem *paddr = (void __iomem *)((uintptr_t)mac + offs);
-	return readb(paddr);
-}
-
-static inline
-void csrwr32(u32 val, void __iomem *mac, size_t offs)
-{
-	void __iomem *paddr = (void __iomem *)((uintptr_t)mac + offs);
-
-	writel(val, paddr);
-}
-
-static inline
-void csrwr16(u16 val, void __iomem *mac, size_t offs)
-{
-	void __iomem *paddr = (void __iomem *)((uintptr_t)mac + offs);
-
-	writew(val, paddr);
-}
-
-static inline
-void csrwr8(u8 val, void __iomem *mac, size_t offs)
-{
-	void __iomem *paddr = (void __iomem *)((uintptr_t)mac + offs);
-
-	writeb(val, paddr);
-}
-
 #endif /* __ALTERA_TSE_H__ */
diff --git a/drivers/net/ethernet/altera/altera_tse_ethtool.c b/drivers/net/ethernet/altera/altera_tse_ethtool.c
index 81313c85833e..d34373bac94a 100644
--- a/drivers/net/ethernet/altera/altera_tse_ethtool.c
+++ b/drivers/net/ethernet/altera/altera_tse_ethtool.c
@@ -22,6 +22,7 @@
 #include <linux/phy.h>

 #include "altera_tse.h"
+#include "altera_utils.h"

 #define TSE_STATS_LEN	31
 #define TSE_NUM_REGS	128
diff --git a/drivers/net/ethernet/altera/altera_utils.h b/drivers/net/ethernet/altera/altera_utils.h
index 3c2e32fb7389..c3f09c5257f7 100644
--- a/drivers/net/ethernet/altera/altera_utils.h
+++ b/drivers/net/ethernet/altera/altera_utils.h
@@ -7,6 +7,7 @@
 #define __ALTERA_UTILS_H__

 #include <linux/compiler.h>
+#include <linux/io.h>
 #include <linux/types.h>

 void tse_set_bit(void __iomem *ioaddr, size_t offs, u32 bit_mask);
@@ -14,4 +15,46 @@ void tse_clear_bit(void __iomem *ioaddr, size_t offs, u32 bit_mask);
 int tse_bit_is_set(void __iomem *ioaddr, size_t offs, u32 bit_mask);
 int tse_bit_is_clear(void __iomem *ioaddr, size_t offs, u32 bit_mask);

+static inline u32 csrrd32(void __iomem *mac, size_t offs)
+{
+	void __iomem *paddr = mac + offs;
+
+	return readl(paddr);
+}
+
+static inline u16 csrrd16(void __iomem *mac, size_t offs)
+{
+	void __iomem *paddr = mac + offs;
+
+	return readw(paddr);
+}
+
+static inline u8 csrrd8(void __iomem *mac, size_t offs)
+{
+	void __iomem *paddr = mac + offs;
+
+	return readb(paddr);
+}
+
+static inline void csrwr32(u32 val, void __iomem *mac, size_t offs)
+{
+	void __iomem *paddr = mac + offs;
+
+	writel(val, paddr);
+}
+
+static inline void csrwr16(u16 val, void __iomem *mac, size_t offs)
+{
+	void __iomem *paddr = mac + offs;
+
+	writew(val, paddr);
+}
+
+static inline void csrwr8(u8 val, void __iomem *mac, size_t offs)
+{
+	void __iomem *paddr = mac + offs;
+
+	writeb(val, paddr);
+}
+
 #endif /* __ALTERA_UTILS_H__*/
--
2.26.2


