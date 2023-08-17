Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB8077F2DB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 11:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349343AbjHQJM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 05:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349358AbjHQJMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:12:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FD02724
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 02:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692263547; x=1723799547;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LRoMtuGF0pkyK9z7msHYzYu+DILKdSA/czqBIBIDqUg=;
  b=Za7QM2fIykareSfDdtvGrJXvVxtOr6CbOFn1i33oiys+PnKwQko9GfiG
   RoIWFVclRUM07GTdXjVc3y/ZY3nGgkIST1+jr5hIQmXMjnHt4qo5jbroQ
   pHhXt3psihjw7rAtC1ZwejEBeIndkFOPLYCC4fWUjRM6z2r4qUyvI+ej9
   hKUpvQ+bAmIkylYYaLKCAZWcdqwtSbzCeV13ltd2z2viFP4buLueErXjp
   iKMiw7mQA/q913bKvDvfkzTQmQ2V/h+Drnqt7my6ZYnnNchFA+Qj3Yyjn
   ph6jz2HDooRhm20UpnBQ3flzrsxUtjufI4xQUD0e3PaBLyr890kJrhDZl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="459113626"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="459113626"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 02:12:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="769549271"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="769549271"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 17 Aug 2023 02:12:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 99A19D87; Thu, 17 Aug 2023 12:12:23 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] driver core: Return proper error code when dev_set_name() fails
Date:   Thu, 17 Aug 2023 12:12:21 +0300
Message-Id: <20230817091221.463721-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Whe device_add() tries to assign a device name with help of
dev_set_name() the error path explicitly uses -EINVAL, while
the function may return something different.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/core.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 3afb7710ccb5..1a1aecabd5ce 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3528,18 +3528,17 @@ int device_add(struct device *dev)
 	 * the name, and force the use of dev_name()
 	 */
 	if (dev->init_name) {
-		dev_set_name(dev, "%s", dev->init_name);
+		error = dev_set_name(dev, "%s", dev->init_name);
 		dev->init_name = NULL;
 	}
 
+	if (dev_name(dev))
+		error = 0;
 	/* subsystems can specify simple device enumeration */
-	if (!dev_name(dev) && dev->bus && dev->bus->dev_name)
-		dev_set_name(dev, "%s%u", dev->bus->dev_name, dev->id);
-
-	if (!dev_name(dev)) {
-		error = -EINVAL;
+	else if (dev->bus && dev->bus->dev_name)
+		error = dev_set_name(dev, "%s%u", dev->bus->dev_name, dev->id);
+	if (error)
 		goto name_error;
-	}
 
 	pr_debug("device: '%s': %s\n", dev_name(dev), __func__);
 
-- 
2.40.0.1.gaa8946217a0b

