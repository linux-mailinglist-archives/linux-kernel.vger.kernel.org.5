Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418C4790A99
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 04:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235589AbjICCwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 22:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbjICCwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 22:52:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8749E186;
        Sat,  2 Sep 2023 19:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693709558; x=1725245558;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=zqyXNb+xEyrrtyKE9UchbnAugfiW3FoObXQ1vbuMsYk=;
  b=c8oYB91ylfYurdzfB+NB8kHB+4bu1HbYh3V+Cy41zsWNS6h4Ti2QtzXl
   kZIdT8pWl4NWBmp5WKu/TqvuILNc+WuY83jqhHC8tV/yp44xDOciPdVod
   oe10Tzv/YobuPFfsZ7mCxV44JVBhXhyfmwkKzqonD9u/7ycM7WXupJpJm
   nBW9TmI3of18FbbjJ1UuJplUvYoeLFxP2CUMZtUwg2JdI5mQCHKMAf0fb
   WaVJ2YXUCDZUzbj0l604vZLx0NrW0n9c/Eo41LBkSAsOyqI7jiIGMl2RB
   34omT1dzDPTEHPl8CFVaX4Aefl10uC4rL1cZf3xhjhx91VSzsozy9D/Oy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10821"; a="407417570"
X-IronPort-AV: E=Sophos;i="6.02,223,1688454000"; 
   d="scan'208";a="407417570"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2023 19:52:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10821"; a="855172775"
X-IronPort-AV: E=Sophos;i="6.02,223,1688454000"; 
   d="scan'208";a="855172775"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.209.188.150])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2023 19:52:37 -0700
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Sat, 02 Sep 2023 19:52:26 -0700
Subject: [PATCH] cxl/hdm: Debug, use decoder name function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230902-use-decoder-name-v1-1-06374ed7a400@intel.com>
X-B4-Tracking: v=1; b=H4sIAOn082QC/x2NQQ7CMAwEv1L5jKWQqAf4CuLgJEvrQ1NkA0Kq+
 ndSjqPZ0W7kMIXTddjI8FHXtXU4nwYqs7QJrLUzxRBTuITIbwdXlLXCuMkCjjmLhJTKmEA9y9I
 X2aSV+QgX8RfsEE/DQ7//r9t933/vqLTQewAAAA==
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Navneet Singh <navneet.singh@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Fan Ni <fan.ni@samsung.com>, Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.13-dev-c6835
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693709556; l=1258;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=zqyXNb+xEyrrtyKE9UchbnAugfiW3FoObXQ1vbuMsYk=;
 b=/ypefwMRvycsCYqNTsahjyTvXxGSeyYsMYKuSKZ2t/pUFjSfYzAqfb042xWc71k6iDvoymPfo
 pGD7VUXKLklCWvvHE8+RMRR2eBOQjxHw/nY5edtdX5jGhpJmdXg6Zoi
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The decoder enum has a name conversion function defined now.

Use that instead of open coding.

Suggested-by: Navneet Singh <navneet.singh@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
Changes:
[iweiny: split out from DCD series]
https://lore.kernel.org/r/20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com
---
 drivers/cxl/core/hdm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 4449b34a80cc..4fa49923eac0 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -530,8 +530,7 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
 
 	if (size > avail) {
 		dev_dbg(dev, "%pa exceeds available %s capacity: %pa\n", &size,
-			cxled->mode == CXL_DECODER_RAM ? "ram" : "pmem",
-			&avail);
+			cxl_decoder_mode_name(cxled->mode), &avail);
 		rc = -ENOSPC;
 		goto out;
 	}

---
base-commit: 1c59d383390f970b891b503b7f79b63a02db2ec5
change-id: 20230902-use-decoder-name-2bbaa033c53e

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>

