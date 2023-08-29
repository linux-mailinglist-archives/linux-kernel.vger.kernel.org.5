Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D879A78BDC9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 07:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235642AbjH2FYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 01:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235635AbjH2FXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 01:23:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405E4199;
        Mon, 28 Aug 2023 22:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693286630; x=1724822630;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=e+UEGBFvflCilnFRLPXzL1BIxt/SwaAJDlJZyXVRCU4=;
  b=ia7dSFtcQGah66SLgbC+NN1d6i6qrrlmDGTtNStjQdq/iGwGED121POl
   N5IkLtF6/T3ZqUEaKl4utQa/N+DEJjnfsp5Up4GXkjIu3pUq0D04X7OB6
   smaj+GU3Uv8FjMx8v1inpPljjuXmbGjEXqKFpbHRF4BSp9QogYOXY0z92
   hzLKflbTcUEnIVub8lqHNX/Z0Qs5H3Pw6er0opSua8s/URZNwo/EHqSVS
   uwE2ArJyxcaKjAy7zfyORPc9+WkDD9mW53HK6ZvuXUkzy92sQTU/Y/pln
   dORh5Gl7F0qdkHYVun1nUy6n+p1m2+0Ar5JASaA1SEkGUqAadr7Okk+Te
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="441625157"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="441625157"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 22:23:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="738556292"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="738556292"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.212.37.183])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 22:23:31 -0700
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Mon, 28 Aug 2023 22:20:52 -0700
Subject: [PATCH RFC v2 01/18] cxl/hdm: Debug, use decoder name function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230604-dcd-type2-upstream-v2-1-f740c47e7916@intel.com>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
In-Reply-To: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.13-dev-c6835
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693286607; l=875;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=e+UEGBFvflCilnFRLPXzL1BIxt/SwaAJDlJZyXVRCU4=;
 b=ndAvGjnZcDm+e2/5yUeL3cdkv1P0q8Ie8hUanJCUyRRFpxhTz82VutYuJgPTqq7SoQa7i3ThD
 2Idk86K/HcgANLPWWO+wnE80e323W9jk9du3i1AvKY6y/5zEohbxns5
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The decoder enum has a name conversion function defined now.

Use that instead of open coding.

Suggested-by: Navneet Singh <navneet.singh@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for v2:
[iweiny: new patch, split out]
---
 drivers/cxl/core/hdm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index b01a77b67511..a254f79dd4e8 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -550,8 +550,7 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
 
 	if (size > avail) {
 		dev_dbg(dev, "%pa exceeds available %s capacity: %pa\n", &size,
-			cxled->mode == CXL_DECODER_RAM ? "ram" : "pmem",
-			&avail);
+			cxl_decoder_mode_name(cxled->mode), &avail);
 		rc = -ENOSPC;
 		goto out;
 	}

-- 
2.41.0

