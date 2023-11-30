Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49477FE605
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 02:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344006AbjK3BdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 20:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343996AbjK3Bc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 20:32:59 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F83C10C3;
        Wed, 29 Nov 2023 17:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701307986; x=1732843986;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=J/LRvfhiMq4LbhQzlNk2y450X4xdxFuUPAYrPIbDPDA=;
  b=IE/6iYqxSwZvVTlu8EF484WyQ7gNscDRgPvsYxmmEJZXuYtyTLCLhWoP
   pPS/GzC3qySRGwmZLfpirIr16rRiFf56EKA+1PsdbbnhezbFCcqZWhOvI
   AA+G2lsO2F8Zm5G3gjMew0etQFjJRks7lz2qf3/6A1me3HM0OjFwCx6Sl
   wYvDAAn9FbmN06cG7mJHBNpChw27tB6U6ZO/3WpkCa4LfM+IE9nt4GBcx
   KvGHLzBGJwYqsEl+N5nae64SEP+b/iz8neUujZwlPePttHxUmhEYbDUVG
   /Iup1u/UR6KBqJ/UU492mayoABEDsf2MCO0/ZHvy1NLsXAiAA9d+l3VC4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="131549"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="131549"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 17:33:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="1016467449"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="1016467449"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.213.173.40])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 17:33:04 -0800
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Wed, 29 Nov 2023 17:33:03 -0800
Subject: [PATCH v2 1/2] cxl/cdat: Handle cdat table build errors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231117-fix-cdat-cs-v2-1-715399976d4d@intel.com>
References: <20231117-fix-cdat-cs-v2-0-715399976d4d@intel.com>
In-Reply-To: <20231117-fix-cdat-cs-v2-0-715399976d4d@intel.com>
To:     Jonathan Cameron <jonathan.cameron@huawei.com>,
        Fan Ni <nifan.cxl@gmail.com>
Cc:     Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        Huai-Cheng Kuo <hchkuo@avery-design.com.tw>
X-Mailer: b4 0.13-dev-c6835
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701307983; l=1103;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=J/LRvfhiMq4LbhQzlNk2y450X4xdxFuUPAYrPIbDPDA=;
 b=LtEnHMx26EnkkJq65L/SvzLr4Hj3z5Mb8duGdIrZoyJdc/S8OJYd3ZNjfyRpQJeyI4uYzVa2Y
 A4d5IYEL7RMCh9Rap5TLxg+Fbv7sxnJURcHRY/OAiePYzeUivnJLN9l
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The callback for building CDAT tables may return negative error codes.
This was previously unhandled and will result in potentially huge
allocations later on in ct3_build_cdat()

Detect the negative error code and defer cdat building.

Fixes: f5ee7413d592 ("hw/mem/cxl-type3: Add CXL CDAT Data Object Exchange")
Cc: Huai-Cheng Kuo <hchkuo@avery-design.com.tw>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 hw/cxl/cxl-cdat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-cdat.c b/hw/cxl/cxl-cdat.c
index 639a2db3e17b..24829cf2428d 100644
--- a/hw/cxl/cxl-cdat.c
+++ b/hw/cxl/cxl-cdat.c
@@ -63,7 +63,7 @@ static void ct3_build_cdat(CDATObject *cdat, Error **errp)
     cdat->built_buf_len = cdat->build_cdat_table(&cdat->built_buf,
                                                  cdat->private);
 
-    if (!cdat->built_buf_len) {
+    if (cdat->built_buf_len <= 0) {
         /* Build later as not all data available yet */
         cdat->to_update = true;
         return;

-- 
2.42.0

