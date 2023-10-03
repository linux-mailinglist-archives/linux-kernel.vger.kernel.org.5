Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645467B7151
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 20:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240813AbjJCStc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 14:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232185AbjJCSt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 14:49:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4FEB0;
        Tue,  3 Oct 2023 11:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696358962; x=1727894962;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tHSeNTya9+mTDl4DHH37n15KCaDe9pZn/vwT9v6EpB4=;
  b=mSO29+RVGrjWxFY9It48AR/nIKnjTDoXXEbzpG8rR4qaEmMBktjt/DS+
   tDG44bzeVrxSEkWrpperk3N/gsaEraJax+BITM1pAQefQ3QEd8R6WYb73
   HxYaVUEuqKkk9S3GUh7o3zJc9Th7KkXbwHb99zexYoPNzLjcZo2j10aiU
   lFdq3DG7fPAT9EwPYnDIPl65CaXQlApnwdThxsuHafe4VDvUOfkbcHiPA
   Ye++/8L3EG40e6CnJwh+HiJXNTet+UYmYgWArj6/A6ne+brxOpqmd/dFs
   NGeIhXJGRScQnhiyS/04N1BWRQBigtLY7gh4FWMPvgVdh+fk9eqm+I8Uh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="363221961"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="363221961"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 11:49:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="700814545"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="700814545"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by orsmga003.jf.intel.com with ESMTP; 03 Oct 2023 11:49:20 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 3/3] platform/x86/intel-uncore-freq: Ignore minor version change
Date:   Tue,  3 Oct 2023 11:49:16 -0700
Message-Id: <20231003184916.1860084-4-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231003184916.1860084-1-srinivas.pandruvada@linux.intel.com>
References: <20231003184916.1860084-1-srinivas.pandruvada@linux.intel.com>
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

The hardware definition of every TPMI feature contains a major and minor
version. When there is a change in the MMIO offset or change in the
definition of a field, hardware will change major version. For addition
of new fields without modifying existing MMIO offsets or fields, only the
minor version is changed.

Driver is developed to support uncore frequency control (UFS) for a major
and minor version. If the hardware changes major version, since offsets
and definitions are changed, driver cannot continue to provide UFS
interface to users. Driver can still function with minor version change
as it will just miss the new functionality added by the hardware.

The current implementation logs information message and skips adding
uncore sysfs entry for a resource for any version mismatch. Check major
and minor version mismatch for every valid resource and fail on any major
version mismatch by logging an error message. A valid resource has a
version which is not 0xFF.

If there is mismatch with the minor version, continue with a log message.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
v2
- Commit description and header change
- Change log levels exit on any major version mismatch

 .../uncore-frequency/uncore-frequency-tpmi.c   | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
index 7d0a67f8b517..4fb790552c47 100644
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
@@ -28,7 +28,8 @@
 
 #include "uncore-frequency-common.h"
 
-#define	UNCORE_HEADER_VERSION		1
+#define	UNCORE_MAJOR_VERSION		0
+#define	UNCORE_MINOR_VERSION		1
 #define UNCORE_HEADER_INDEX		0
 #define UNCORE_FABRIC_CLUSTER_OFFSET	8
 
@@ -302,12 +303,21 @@ static int uncore_probe(struct auxiliary_device *auxdev, const struct auxiliary_
 		/* Check for version and skip this resource if there is mismatch */
 		header = readq(pd_info->uncore_base);
 		pd_info->ufs_header_ver = header & UNCORE_VERSION_MASK;
-		if (pd_info->ufs_header_ver != UNCORE_HEADER_VERSION) {
-			dev_info(&auxdev->dev, "Uncore: Unsupported version:%d\n",
-				pd_info->ufs_header_ver);
+
+		if (pd_info->ufs_header_ver == TPMI_VERSION_INVALID)
 			continue;
+
+		if (TPMI_MAJOR_VERSION(pd_info->ufs_header_ver) != UNCORE_MAJOR_VERSION) {
+			dev_err(&auxdev->dev, "Uncore: Unsupported major version:%lx\n",
+				TPMI_MAJOR_VERSION(pd_info->ufs_header_ver));
+			ret = -ENODEV;
+			goto remove_clusters;
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

