Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64C37ADFCB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 21:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbjIYTqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 15:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233314AbjIYTqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 15:46:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6AB103;
        Mon, 25 Sep 2023 12:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695671160; x=1727207160;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2v8jYLR4xvloEc3DBYqiOZSD43EbqJMRtEb7xJauReg=;
  b=AqdOnqS3PkRMvDlmcJiUAO/R3UdC7OC6sH2ypiBYC7w2FenjLIuMR+uV
   fUyjMBHb7CkvgapZDfVXh5feYJD45DP7FtDDx7yEuduFFKqh52p+Cb7dO
   uSmO46TwUqZ9Wg2YmL4o4G+v4d7uqZqF697XuHaEX/kFhBsebXxw3kMWr
   1EUzRuk+6S+9R+lRiBTus0Ue2jTT2l8OcQxNwhyvyDiKRBlb4G3VUIA5c
   ThC0nw7ASnFSqFOU//+nFKX+QJmSGvwu5eyX4suFHmAQSFO0mC+X6znB6
   3S1p/apP86KUSw4PrcSldRRaGl09wra9uk7a2eNjLdEUI2lXwJmEKhl6e
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="380233034"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="380233034"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 12:45:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="814114295"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="814114295"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by fmsmga008.fm.intel.com with ESMTP; 25 Sep 2023 12:45:56 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 1/3] platform/x86: ISST: Use fuse enabled mask instead of allowed levels
Date:   Mon, 25 Sep 2023 12:45:53 -0700
Message-Id: <20230925194555.966743-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230925194555.966743-1-srinivas.pandruvada@linux.intel.com>
References: <20230925194555.966743-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allowed level mask is a mask of levels, which are currently allowed
to dynamically switch. But even dynamic switching is not allowed,
user should be able to check all parameters for selection via BIOS.

So when passing the level mask for display to user space, use fuse
enabled mask, which has all levels.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
index 37f17e229419..48465636aadb 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
@@ -712,7 +712,7 @@ static int isst_if_get_perf_level(void __user *argp)
 		return -EINVAL;
 
 	perf_level.max_level = power_domain_info->max_level;
-	perf_level.level_mask = power_domain_info->pp_header.allowed_level_mask;
+	perf_level.level_mask = power_domain_info->pp_header.level_en_mask;
 	perf_level.feature_rev = power_domain_info->pp_header.feature_rev;
 	_read_pp_info("current_level", perf_level.current_level, SST_PP_STATUS_OFFSET,
 		      SST_PP_LEVEL_START, SST_PP_LEVEL_WIDTH, SST_MUL_FACTOR_NONE)
-- 
2.41.0

