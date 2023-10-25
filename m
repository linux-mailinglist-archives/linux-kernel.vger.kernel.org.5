Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAC97D65E4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 10:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbjJYI42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 04:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbjJYI4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 04:56:25 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 25 Oct 2023 01:56:21 PDT
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com [207.54.90.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6948129;
        Wed, 25 Oct 2023 01:56:21 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="116857370"
X-IronPort-AV: E=Sophos;i="6.03,250,1694703600"; 
   d="scan'208";a="116857370"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 17:55:16 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
        by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id ED401D9DA6;
        Wed, 25 Oct 2023 17:55:13 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
        by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 25CB528E18;
        Wed, 25 Oct 2023 17:55:13 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
        by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 9D1D71E9CB7;
        Wed, 25 Oct 2023 17:55:12 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.226.45])
        by edo.cn.fujitsu.com (Postfix) with ESMTP id B560E1A0070;
        Wed, 25 Oct 2023 16:55:11 +0800 (CST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dan.j.williams@intel.com,
        linux-cxl@vger.kernel.org
Cc:     dave.jiang@intel.com, Jonathan.Cameron@huawei.com,
        fan.ni@samsung.com, linux-kernel@vger.kernel.org,
        Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH] cxl/region: Fix cxl_region_rwsem lock held when returning to user space
Date:   Wed, 25 Oct 2023 16:54:50 +0800
Message-ID: <20231025085450.2514906-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27956.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27956.006
X-TMASE-Result: 10--4.190000-10.000000
X-TMASE-MatchedRID: 1Eu80e4q/YTU2//X4sLSxR1kSRHxj+Z5jkDrBOJwwnRU0vVJesIjQDSg
        hb/pcAwyDsw5NBgZqd05FeaVnwctxVdvtTbdcIRVupDIC9422DruZ8ZuWMHQFcC5DTEMxpeQfiq
        1gj2xET8vYRhsicUjm84WYLmQfXYmSSOWVJeuO1AURSScn+QSXpjDMT0TyDk5+gtHj7OwNO25V9
        z3vqk3KvBRmyhQxZi3IbDJrgrtvXK/+8BaAUFJX2CXm9pxxigKAbN3VNSL6ABSCEZ94phmrkPsa
        ltbXLYI+/pKeoesceTuBxK2U00v/YaT7FRqp0wPAcQrAfBh69vBRLFeH6OJSCTDD+DBjuEw
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

goto out to release cxl_region_rwsem. Fix below warning:
================================================
WARNING: lock held when returning to user space!
6.6.0-rc3-lizhijian+ #213 Not tainted
------------------------------------------------
cxl/673 is leaving the kernel with locks still held!
1 lock held by cxl/673:
 #0: ffffffffa013b9d0 (cxl_region_rwsem){++++}-{3:3}, at: commit_store+0x7d/0x3e0 [cxl_core]

Fixes: d1257d098a5a ("cxl/region: Move cache invalidation before region teardown, and before setup")
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/cxl/core/region.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 6d63b8798c29..18da77f8f22b 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -294,7 +294,7 @@ static ssize_t commit_store(struct device *dev, struct device_attribute *attr,
 	 */
 	rc = cxl_region_invalidate_memregion(cxlr);
 	if (rc)
-		return rc;
+		goto out;
 
 	if (commit) {
 		rc = cxl_region_decode_commit(cxlr);
-- 
2.29.2

