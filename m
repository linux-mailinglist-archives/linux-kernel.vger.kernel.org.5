Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC3178EB3A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 13:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343875AbjHaLAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 07:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239916AbjHaLAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 07:00:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6BECF4;
        Thu, 31 Aug 2023 04:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693479608; x=1725015608;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SyJa4QtxsQ8hoWxOvEBCGRxK721NTdhdG5pHdV6yRPU=;
  b=ZK59Nfa8mz4tLMlYqa/4wsjMnAk8zJdmxWU4mKbGrWyFimEF0xEsefkl
   BotbMch5jROCiN2nFCYxBHPmfcT6c563dAxfMPTpnthR9gHlQYjs1nQEb
   Yg7uy5/8r1kd8ppMc+hczhTZNJx1Go9Vrs6sc6EuAb+SQ+kODJnBRyNuj
   o0pzSKykCcebzqN7mQAygpi1C9B32y50yQqLw6h9xqAMkZQhJxl9ARgK8
   9fVzqrEdRiiWx6B8dpC3yCq3h9eIQX10XcTSVZjTS5o6re3sZ9N/l5JUV
   zGVdIbyDjHEhAY3jO6KLlUeOi6icvHMUGaUOvIqOVMG/gwlYwBgel3nNL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="442264173"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="442264173"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 04:00:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="986189956"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="986189956"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 31 Aug 2023 04:00:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 188813E3; Thu, 31 Aug 2023 14:00:04 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Harald Freudenberger <freude@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/2] s390/zcrypt: Utilize dev_set_name() ability to use a formatted string
Date:   Thu, 31 Aug 2023 14:00:00 +0300
Message-Id: <20230831110000.24279-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230831110000.24279-1-andriy.shevchenko@linux.intel.com>
References: <20230831110000.24279-1-andriy.shevchenko@linux.intel.com>
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

With the dev_set_name() prototype it's not obvious that it takes
a formatted string as a parameter. Use its facility instead of
duplicating the same with strncpy()/snprintf() calls.

With this, also prevent return error code to be shadowed.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/s390/crypto/zcrypt_api.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
index 6b99f7dd0643..ce04caa7913f 100644
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -366,7 +366,6 @@ static int zcdn_create(const char *name)
 {
 	dev_t devt;
 	int i, rc = 0;
-	char nodename[ZCDN_MAX_NAME];
 	struct zcdn_device *zcdndev;
 
 	if (mutex_lock_interruptible(&ap_perms_mutex))
@@ -407,14 +406,11 @@ static int zcdn_create(const char *name)
 	zcdndev->device.devt = devt;
 	zcdndev->device.groups = zcdn_dev_attr_groups;
 	if (name[0])
-		strncpy(nodename, name, sizeof(nodename));
+		rc = dev_set_name(&zcdndev->device, "%s", name);
 	else
-		snprintf(nodename, sizeof(nodename),
-			 ZCRYPT_NAME "_%d", (int)MINOR(devt));
-	nodename[sizeof(nodename) - 1] = '\0';
-	if (dev_set_name(&zcdndev->device, nodename)) {
+		rc = dev_set_name(&zcdndev->device, ZCRYPT_NAME "_%d", (int)MINOR(devt));
+	if (rc) {
 		kfree(zcdndev);
-		rc = -EINVAL;
 		goto unlockout;
 	}
 	rc = device_register(&zcdndev->device);
-- 
2.40.0.1.gaa8946217a0b

