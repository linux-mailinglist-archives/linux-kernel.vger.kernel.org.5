Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B058D7ADFC0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 21:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbjIYTn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 15:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbjIYTn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 15:43:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20BF107;
        Mon, 25 Sep 2023 12:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695671029; x=1727207029;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FzGXYJzua9BF2gVVYPV7cyhWIVoAmAwcBTCIDmW0JcQ=;
  b=lebiT1f1DOewuSPXL3eh+6gT1GRQ/E0Wig2GfvVQxODyBDv2f4qnZBiI
   s+aYM1ZcdzsRw/Y6OVoeGROMvaky2lTxyu5hzbYzufoSDWoHImYTbZA8l
   ihE/awRPaFLjJZRw1mofh0PEqAtcNodb1Hulj+IpJxS4ULcN9rOnWn2h8
   lkGAY4c5cDyTfXWbP3SjrIqDy2IW2kyc5fdfudDsM4eYffJoncDd3bDKp
   OVugdeXbUGoZ1fYdCs8siLgsBnezIPkrThApfw3+A34EULjIdGHELzmnC
   VbQkhcK6+NPy2WUwYBtpkjy0Yx2Ok/xElPFN63nU89r+NVTLh35Xk3GDa
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="360743073"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="360743073"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 12:43:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="872194751"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="872194751"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by orsmga004.jf.intel.com with ESMTP; 25 Sep 2023 12:43:39 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 3/3] platform/x86/intel-uncore-freq: Check major minor version
Date:   Mon, 25 Sep 2023 12:43:38 -0700
Message-Id: <20230925194338.966639-4-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230925194338.966639-1-srinivas.pandruvada@linux.intel.com>
References: <20230925194338.966639-1-srinivas.pandruvada@linux.intel.com>
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

Parse major and minor version number from the version field. If there
is a mismatch for major version, exit from further processing for that
domain.

If there is mismatch in minor version, driver continue to process with
an error message. Minor version change doesn't change offsets and bit
structures of TPMI fields.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../uncore-frequency/uncore-frequency-tpmi.c    | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
index 7d0a67f8b517..4d63ee6bc6d2 100644
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
@@ -28,7 +28,8 @@
 
 #include "uncore-frequency-common.h"
 
-#define	UNCORE_HEADER_VERSION		1
+#define	UNCORE_MAJOR_VERSION		0
+#define	UNCORE_MINOR_VERSION		1
 #define UNCORE_HEADER_INDEX		0
 #define UNCORE_FABRIC_CLUSTER_OFFSET	8
 
@@ -302,12 +303,20 @@ static int uncore_probe(struct auxiliary_device *auxdev, const struct auxiliary_
 		/* Check for version and skip this resource if there is mismatch */
 		header = readq(pd_info->uncore_base);
 		pd_info->ufs_header_ver = header & UNCORE_VERSION_MASK;
-		if (pd_info->ufs_header_ver != UNCORE_HEADER_VERSION) {
-			dev_info(&auxdev->dev, "Uncore: Unsupported version:%d\n",
-				pd_info->ufs_header_ver);
+
+		if (pd_info->ufs_header_ver == TPMI_VERSION_INVALID)
+			continue;
+
+		if (TPMI_MAJOR_VERSION(pd_info->ufs_header_ver) != UNCORE_MAJOR_VERSION) {
+			dev_info(&auxdev->dev, "Uncore: Unsupported major version:%lx\n",
+				 TPMI_MAJOR_VERSION(pd_info->ufs_header_ver));
 			continue;
 		}
 
+		if (TPMI_MINOR_VERSION(pd_info->ufs_header_ver) != UNCORE_MINOR_VERSION)
+			dev_info(&auxdev->dev, "Uncore: Ignore: Unsupported minor version:%lx\n",
+				 TPMI_MINOR_VERSION(pd_info->ufs_header_ver));
+
 		/* Get Cluster ID Mask */
 		cluster_mask = FIELD_GET(UNCORE_LOCAL_FABRIC_CLUSTER_ID_MASK, header);
 		if (!cluster_mask) {
-- 
2.41.0

