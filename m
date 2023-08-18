Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBB0780CA0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 15:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377198AbjHRNhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 09:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377257AbjHRNhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 09:37:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94B63AB6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 06:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692365819; x=1723901819;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SH8TH2elwv8+g3h0dmJ4VP57WBG4oBy8q2bZhx1FJlY=;
  b=YtIXim3VLoJXb62P7j5Xle1fk3khamKzwvACoL8XqqWnvaNUN3OFpeKZ
   UiMFBU6MDJSsa/HLK+2cCbNZT3PjlXv87cKpAg9lNpy52R/DS4eDza5WH
   dvoIburi09+7hqppZXGmUm2LQuXFZTNEZpeTX765J2XlZTYbiWXiOhdGG
   mjL9xhsBKJ9ByBn8jksrTOrn9Qot0K3a5DPp4ByxQOizSMGCRbzDH4m5v
   BcVeXrsi7s369XWTCi7lF+BQq7fQZ5D7mQIJsCGraFLb7QkCnbOShRoqG
   zqxLEmyHZCSL8ZYYFpPizC9gxh7UbjXTntWbfJfoUx9k6ltplP4Go5pYG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="372003043"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="372003043"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 06:36:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="800472506"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="800472506"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 18 Aug 2023 06:36:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A5ECBDE4; Fri, 18 Aug 2023 16:36:56 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] driver core: Call in reversed order in device_platform_notify_remove()
Date:   Fri, 18 Aug 2023 16:36:54 +0300
Message-Id: <20230818133654.767986-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's logically correct to call the removal notifiers in the reversed order
as it might be dependent to each other. Luckily, platform_notify_remove()
currently is not used and the others have no dependency use, but theoretically
it's still possible.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 3afb7710ccb5..edcf0a2ccee4 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2306,12 +2306,12 @@ static void device_platform_notify(struct device *dev)
 
 static void device_platform_notify_remove(struct device *dev)
 {
-	acpi_device_notify_remove(dev);
-
-	software_node_notify_remove(dev);
-
 	if (platform_notify_remove)
 		platform_notify_remove(dev);
+
+	software_node_notify_remove(dev);
+
+	acpi_device_notify_remove(dev);
 }
 
 /**
-- 
2.40.0.1.gaa8946217a0b

