Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347977FFDD0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 22:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376989AbjK3VsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 16:48:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjK3VsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 16:48:04 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765D210F9;
        Thu, 30 Nov 2023 13:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701380891; x=1732916891;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P2DaoEX+ZlxmopknKJDRlfJ7mGZUxT8s3MGZif/juAM=;
  b=Yx131qEH+jZ9MomQ1j9NUWA2bsrF27AlBptcUyFf1q1l9JFHmKRM253r
   uXHKBXYrU2VFRMhbSncVGnSl1xfHfvhV9W1pDyJ5MA5NUddixBPvciefN
   cldvxEctFprFN/hlR2esq+lLLpoIol5VPe9N3W3hQM74opxiu48QOPNam
   lH8VpbAhmWocv5o+ydS25ApFL54emQmkNzcG8PMeCSKlkOs3WkzM7uDdw
   6HxPQzURHlBT4gdd/l/6Fe8qx2bCl5YDIWerPiEZEsCNtKse3WVXEi2cc
   zLco8fee76qol8kurJZ2cQ2uVIGAAJjTZ+jxuBuv8/iQTVe2PxU/3Cj86
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="399942"
X-IronPort-AV: E=Sophos;i="6.04,240,1695711600"; 
   d="scan'208";a="399942"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 13:48:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="860334604"
X-IronPort-AV: E=Sophos;i="6.04,240,1695711600"; 
   d="scan'208";a="860334604"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Nov 2023 13:48:09 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 1/5] platform/x86/intel/tpmi: Don't create devices for disabled features
Date:   Thu, 30 Nov 2023 13:47:47 -0800
Message-Id: <20231130214751.3100418-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231130214751.3100418-1-srinivas.pandruvada@linux.intel.com>
References: <20231130214751.3100418-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If some TPMI features are disabled, don't create auxiliary devices. In
this way feature drivers will not load.

While creating auxiliary devices, call tpmi_read_feature_status() to
check feature state and return if the feature is disabled without
creating a device.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
v2
- Add comment for returning -EOPNOTSUPP

 drivers/platform/x86/intel/tpmi.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/tpmi.c b/drivers/platform/x86/intel/tpmi.c
index c89aa4d14bea..868067ff966e 100644
--- a/drivers/platform/x86/intel/tpmi.c
+++ b/drivers/platform/x86/intel/tpmi.c
@@ -604,9 +604,21 @@ static int tpmi_create_device(struct intel_tpmi_info *tpmi_info,
 	struct intel_vsec_device *vsec_dev = tpmi_info->vsec_dev;
 	char feature_id_name[TPMI_FEATURE_NAME_LEN];
 	struct intel_vsec_device *feature_vsec_dev;
+	struct tpmi_feature_state feature_state;
 	struct resource *res, *tmp;
 	const char *name;
-	int i;
+	int i, ret;
+
+	ret = tpmi_read_feature_status(tpmi_info, pfs->pfs_header.tpmi_id, &feature_state);
+	if (ret)
+		return ret;
+
+	/*
+	 * If not enabled, continue to look at other features in the PFS, so return -EOPNOTSUPP.
+	 * This will not cause failure of loading of this driver.
+	 */
+	if (!feature_state.enabled)
+		return -EOPNOTSUPP;
 
 	name = intel_tpmi_name(pfs->pfs_header.tpmi_id);
 	if (!name)
-- 
2.41.0

