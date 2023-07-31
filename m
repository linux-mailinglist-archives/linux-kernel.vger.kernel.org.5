Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960F976956E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 14:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbjGaMCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 08:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjGaMCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 08:02:19 -0400
Received: from mgamail.intel.com (unknown [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0486E118
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 05:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690804938; x=1722340938;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TxVEE+RDmFPfYpBZxp/lPsIAG0lDwzsaVJF72iXWIhc=;
  b=U8epYWkYNzyV4nMmvis6LZDBQaAdLPOGK5mNXNseJj5mcypDgh5IJsGv
   9xWEF0eO8GU+idwvvSqm9Cr7EloZxtf0vBJFtjcbGtnHyb5EgzmQ0ETPT
   RPGL81ljDQvc5WueAJvEZzCfcI+GImF4+bHyCAjBn500fRE7Z82bWkoOt
   Cexa+JTmYLpHdJfK0ExL8ON5IQpHUFtLnXq+d04P9G25iBCjJ//1HpDVy
   DWqkR/GHCd1J7o3WcX2F0UzBr2lsveQR1h6RZCgoBHV/sUNiImHaOweUm
   Ho6YmJlTUyIDbfOqACFdPxsdhwKhoGolidzlr22q47b+h12yieDeAiqOv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="348597402"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="348597402"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 05:02:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="852009165"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="852009165"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 05:02:14 -0700
From:   Alexander Usyskin <alexander.usyskin@intel.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tomas Winkler <tomas.winkler@intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
Subject: [PATCH v2] mtd: fix use-after-free in mtd release
Date:   Mon, 31 Jul 2023 14:58:36 +0300
Message-Id: <20230731115836.542747-1-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I case of partition device_unregister() in mtd_device_release()
calls mtd_release() which frees mtd_info structure for partition.
All code after device_unregister in mtd_device_release thus
uses already freed memory.

Move part of code to mtd_release() and restict mtd->dev cleanup
to non-partion object.
For partition object such cleanup have no sense as partition
mtd_info is removed.

Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
Fixes: 19bfa9ebebb5 ("mtd: use refcount to prevent corruption")
Reviewed-by: Tomas Winkler <tomas.winkler@intel.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---

V2: Fix commit messsge wording

---
 drivers/mtd/mtdcore.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 2466ea466466..46f15f676491 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -93,6 +93,9 @@ static void mtd_release(struct device *dev)
 	struct mtd_info *mtd = dev_get_drvdata(dev);
 	dev_t index = MTD_DEVT(mtd->index);
 
+	idr_remove(&mtd_idr, mtd->index);
+	of_node_put(mtd_get_of_node(mtd));
+
 	if (mtd_is_partition(mtd))
 		release_mtd_partition(mtd);
 
@@ -103,6 +106,7 @@ static void mtd_release(struct device *dev)
 static void mtd_device_release(struct kref *kref)
 {
 	struct mtd_info *mtd = container_of(kref, struct mtd_info, refcnt);
+	bool is_partition = mtd_is_partition(mtd);
 
 	debugfs_remove_recursive(mtd->dbg.dfs_dir);
 
@@ -111,11 +115,13 @@ static void mtd_device_release(struct kref *kref)
 
 	device_unregister(&mtd->dev);
 
-	/* Clear dev so mtd can be safely re-registered later if desired */
-	memset(&mtd->dev, 0, sizeof(mtd->dev));
-
-	idr_remove(&mtd_idr, mtd->index);
-	of_node_put(mtd_get_of_node(mtd));
+	/*
+	 *  Clear dev so mtd can be safely re-registered later if desired.
+	 *  Should not be done for partition,
+	 *  as it was already destroyed in device_unregister().
+	 */
+	if (!is_partition)
+		memset(&mtd->dev, 0, sizeof(mtd->dev));
 
 	module_put(THIS_MODULE);
 }
-- 
2.34.1

