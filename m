Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8401F7803C7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 04:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357227AbjHRCZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 22:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357217AbjHRCZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 22:25:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC8635BD
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 19:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692325510; x=1723861510;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QN52vqdWy+67Db96mJmygJPjiM7xcFWPIYI8W1GEhao=;
  b=Hyd8RWAFr5Toy85kB1wxTz4gxE0YdKzMOuBgq94teXDOwhypb+n8SeBI
   504DvEWV5dgFr+JvF25DJVztjfO9e+AF1PFp5Ecp20olrYa+k7Pzv3nJU
   OxNMvhM4aYaHVvlj6JRK04s5t3uFz8TU3i+xHd+AkTntlZ3n+zME/iMlF
   pnxG5cbe55gHoQKJiUggl+GBKe5eIxM35BNvKQR9o4QLB1pHqVQqjE8gV
   hbC3K5LXuxlLwUi0vVLwiMihM9OgJeSbvIOGZ530VLC+7+VEEKAioHZY3
   92SbhaQDVOcybYptnDefpVhSl5o4pWmsLCXOXC1fRIyrMyOcfBJgzi12G
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="459346194"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="459346194"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 19:25:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="804959209"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="804959209"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.117])
  by fmsmga004.fm.intel.com with ESMTP; 17 Aug 2023 19:25:06 -0700
From:   kah.jing.lee@intel.com
To:     dinguyen@kernel.org
Cc:     linux-kernel@vger.kernel.org, tien.sung.ang@intel.com,
        Kah Jing Lee <kah.jing.lee@intel.com>
Subject: [PATCH v2] drivers: firmware: stratix10-rsu: Fix max_retry counter value
Date:   Fri, 18 Aug 2023 10:22:06 +0800
Message-Id: <2e377a400eb0b6395b1a5ff58651add94972745f.1692325277.git.kah.jing.lee@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kah Jing Lee <kah.jing.lee@intel.com>

Fix the max_retry value because the value is truncated at scnprintf format
specifier, with added hex symbol and newline.
Update scnprintf and sprintf with sysfs_emit to ensure no overflow.

Signed-off-by: Kah Jing Lee <kah.jing.lee@intel.com>
---
v2:
- Update scnprintf and sprintf with sysfs_emit to ensure no overflow.
---
 drivers/firmware/stratix10-rsu.c | 33 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/firmware/stratix10-rsu.c b/drivers/firmware/stratix10-rsu.c
index e51c95f8d445..c3e3d6b092a2 100644
--- a/drivers/firmware/stratix10-rsu.c
+++ b/drivers/firmware/stratix10-rsu.c
@@ -328,7 +328,7 @@ static ssize_t current_image_show(struct device *dev,
 	if (!priv)
 		return -ENODEV;
 
-	return sprintf(buf, "0x%08lx\n", priv->status.current_image);
+	return sysfs_emit(buf, "0x%08lx\n", priv->status.current_image);
 }
 
 static ssize_t fail_image_show(struct device *dev,
@@ -339,7 +339,7 @@ static ssize_t fail_image_show(struct device *dev,
 	if (!priv)
 		return -ENODEV;
 
-	return sprintf(buf, "0x%08lx\n", priv->status.fail_image);
+	return sysfs_emit(buf, "0x%08lx\n", priv->status.fail_image);
 }
 
 static ssize_t version_show(struct device *dev, struct device_attribute *attr,
@@ -350,7 +350,7 @@ static ssize_t version_show(struct device *dev, struct device_attribute *attr,
 	if (!priv)
 		return -ENODEV;
 
-	return sprintf(buf, "0x%08x\n", priv->status.version);
+	return sysfs_emit(buf, "0x%08x\n", priv->status.version);
 }
 
 static ssize_t state_show(struct device *dev, struct device_attribute *attr,
@@ -361,7 +361,7 @@ static ssize_t state_show(struct device *dev, struct device_attribute *attr,
 	if (!priv)
 		return -ENODEV;
 
-	return sprintf(buf, "0x%08x\n", priv->status.state);
+	return sysfs_emit(buf, "0x%08x\n", priv->status.state);
 }
 
 static ssize_t error_location_show(struct device *dev,
@@ -372,7 +372,7 @@ static ssize_t error_location_show(struct device *dev,
 	if (!priv)
 		return -ENODEV;
 
-	return sprintf(buf, "0x%08x\n", priv->status.error_location);
+	return sysfs_emit(buf, "0x%08x\n", priv->status.error_location);
 }
 
 static ssize_t error_details_show(struct device *dev,
@@ -383,7 +383,7 @@ static ssize_t error_details_show(struct device *dev,
 	if (!priv)
 		return -ENODEV;
 
-	return sprintf(buf, "0x%08x\n", priv->status.error_details);
+	return sysfs_emit(buf, "0x%08x\n", priv->status.error_details);
 }
 
 static ssize_t retry_counter_show(struct device *dev,
@@ -394,7 +394,7 @@ static ssize_t retry_counter_show(struct device *dev,
 	if (!priv)
 		return -ENODEV;
 
-	return sprintf(buf, "0x%08x\n", priv->retry_counter);
+	return sysfs_emit(buf, "0x%08x\n", priv->retry_counter);
 }
 
 static ssize_t max_retry_show(struct device *dev,
@@ -405,8 +405,7 @@ static ssize_t max_retry_show(struct device *dev,
 	if (!priv)
 		return -ENODEV;
 
-	return scnprintf(buf, sizeof(priv->max_retry),
-			 "0x%08x\n", priv->max_retry);
+	return sysfs_emit(buf, PAGE_SIZE, "0x%08x\n", priv->max_retry);
 }
 
 static ssize_t dcmf0_show(struct device *dev,
@@ -417,7 +416,7 @@ static ssize_t dcmf0_show(struct device *dev,
 	if (!priv)
 		return -ENODEV;
 
-	return sprintf(buf, "0x%08x\n", priv->dcmf_version.dcmf0);
+	return sysfs_emit(buf, "0x%08x\n", priv->dcmf_version.dcmf0);
 }
 
 static ssize_t dcmf1_show(struct device *dev,
@@ -428,7 +427,7 @@ static ssize_t dcmf1_show(struct device *dev,
 	if (!priv)
 		return -ENODEV;
 
-	return sprintf(buf, "0x%08x\n", priv->dcmf_version.dcmf1);
+	return sysfs_emit(buf, "0x%08x\n", priv->dcmf_version.dcmf1);
 }
 
 static ssize_t dcmf2_show(struct device *dev,
@@ -439,7 +438,7 @@ static ssize_t dcmf2_show(struct device *dev,
 	if (!priv)
 		return -ENODEV;
 
-	return sprintf(buf, "0x%08x\n", priv->dcmf_version.dcmf2);
+	return sysfs_emit(buf, "0x%08x\n", priv->dcmf_version.dcmf2);
 }
 
 static ssize_t dcmf3_show(struct device *dev,
@@ -450,7 +449,7 @@ static ssize_t dcmf3_show(struct device *dev,
 	if (!priv)
 		return -ENODEV;
 
-	return sprintf(buf, "0x%08x\n", priv->dcmf_version.dcmf3);
+	return sysfs_emit(buf, "0x%08x\n", priv->dcmf_version.dcmf3);
 }
 
 static ssize_t dcmf0_status_show(struct device *dev,
@@ -464,7 +463,7 @@ static ssize_t dcmf0_status_show(struct device *dev,
 	if (priv->dcmf_status.dcmf0 == INVALID_DCMF_STATUS)
 		return -EIO;
 
-	return sprintf(buf, "0x%08x\n", priv->dcmf_status.dcmf0);
+	return sysfs_emit(buf, "0x%08x\n", priv->dcmf_status.dcmf0);
 }
 
 static ssize_t dcmf1_status_show(struct device *dev,
@@ -478,7 +477,7 @@ static ssize_t dcmf1_status_show(struct device *dev,
 	if (priv->dcmf_status.dcmf1 == INVALID_DCMF_STATUS)
 		return -EIO;
 
-	return sprintf(buf, "0x%08x\n", priv->dcmf_status.dcmf1);
+	return sysfs_emit(buf, "0x%08x\n", priv->dcmf_status.dcmf1);
 }
 
 static ssize_t dcmf2_status_show(struct device *dev,
@@ -492,7 +491,7 @@ static ssize_t dcmf2_status_show(struct device *dev,
 	if (priv->dcmf_status.dcmf2 == INVALID_DCMF_STATUS)
 		return -EIO;
 
-	return sprintf(buf, "0x%08x\n", priv->dcmf_status.dcmf2);
+	return sysfs_emit(buf, "0x%08x\n", priv->dcmf_status.dcmf2);
 }
 
 static ssize_t dcmf3_status_show(struct device *dev,
@@ -506,7 +505,7 @@ static ssize_t dcmf3_status_show(struct device *dev,
 	if (priv->dcmf_status.dcmf3 == INVALID_DCMF_STATUS)
 		return -EIO;
 
-	return sprintf(buf, "0x%08x\n", priv->dcmf_status.dcmf3);
+	return sysfs_emit(buf, "0x%08x\n", priv->dcmf_status.dcmf3);
 }
 static ssize_t reboot_image_store(struct device *dev,
 				  struct device_attribute *attr,

base-commit: c1a515d3c0270628df8ae5f5118ba859b85464a2
-- 
2.25.1

