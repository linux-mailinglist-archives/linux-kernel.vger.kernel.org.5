Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAEA6810B14
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 08:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbjLMHLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 02:11:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjLMHLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 02:11:31 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA778AD;
        Tue, 12 Dec 2023 23:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702451497; x=1733987497;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iRYMqNrXpASNSJnnd3fLhZI1BbmDICDIkbjwXeUvc5w=;
  b=EBczVnXuDkxWV8iClo7SDRiKLUbehE0FSDV5f5Fm4PJLVDmb/86t50AS
   0yHKmPEEFFSev9MwT8BY3m/zO+9w0ZmAg7Rd5PI40GnfhcNM+HeAnkeHO
   mcbCu49E5vFxwNy4ltteiFYonHm5R0alGbH39i4yCIBuNgimdG3RENOt2
   nOMo80pBLrUpR6TVc9bRXagl6GDOfSo/hOJmBZ4fXzWP8c9xlonkf06pP
   eccPIy0CYz3aNQCI5CyPYFE+FeOgnn7uvCWJ3K4Afu/nATIQd1GNKNGpC
   Mizr+ilVLpyAEq+IPxP+gOChBvMg9XTKkohLb5R8h9Q+Tj78y89fJkWa/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="481126118"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="481126118"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 23:11:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="767109274"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="767109274"
Received: from pglc00021.png.intel.com ([10.221.207.41])
  by orsmga007.jf.intel.com with ESMTP; 12 Dec 2023 23:11:34 -0800
From:   <deepakx.nagaraju@intel.com>
To:     joyce.ooi@intel.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, Nagaraju DeepakX <deepakx.nagaraju@intel.com>,
        Andy Schevchenko <andriy.schevchenko@linux.intel.com>
Subject: [PATCH 3/5] net: ethernet: altera: move read write functions
Date:   Wed, 13 Dec 2023 15:11:10 +0800
Message-Id: <20231213071112.18242-4-deepakx.nagaraju@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20231213071112.18242-1-deepakx.nagaraju@intel.com>
References: <20231213071112.18242-1-deepakx.nagaraju@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nagaraju DeepakX <deepakx.nagaraju@intel.com>

Move read write functions from altera_tse.h to altera_utils.h
so it can be shared with future altera ethernet IP's.

Signed-off-by: Nagaraju DeepakX <deepakx.nagaraju@intel.com>
Reviewed-by: Andy Schevchenko <andriy.schevchenko@linux.intel.com>
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

