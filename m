Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412467D4FF6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 14:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233892AbjJXMlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 08:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbjJXMlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 08:41:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BA890;
        Tue, 24 Oct 2023 05:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698151281; x=1729687281;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Nem6qrCq+0poVCw5HdXcByXmMdoy6+KHsYkGPkm5hkI=;
  b=bJGqpbEQpmuDdyhrIVKqlLxF1+bG1Gb+EJfJbv0TVvmYR5TQO2aaluHV
   +tzrS3jDiJCRnnMecvwXxgjVIcwQ1Mwgf9WNPAWzUydn+bKCY3PR5tBs1
   m5cFR7Qdsm6xJOzru4KbezSa3srLDJ5Op+7p25E17vyn62bBeoJBPe/Uu
   uqT7ZvlCbZacx3PFC9juQQ27UQly6YCYiNPFZ+ZcN0jawT6GwSIZGkleJ
   kk095WOnRlMv2JwSs1dYhoebLsIExgPXJkULrpTxAOq7KKr/Oy1MHUNzy
   MFEfHj35jzwxkpWuCbSIv+B2VEM6mdhAQP6uIixmKzXcJQ/WZcz4TKB8q
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="389894161"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="389894161"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 05:41:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="1089822129"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="1089822129"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 24 Oct 2023 05:41:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5DF5E9CE; Tue, 24 Oct 2023 15:41:17 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH v1 2/3] serdev: Simplify devm_serdev_device_open() function
Date:   Tue, 24 Oct 2023 15:41:14 +0300
Message-Id: <20231024124115.3598090-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20231024124115.3598090-1-andriy.shevchenko@linux.intel.com>
References: <20231024124115.3598090-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_add_action_or_reset() instead of devres_alloc() and
devres_add(), which works the same. This will simplify the
code. There is no functional changes.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serdev/core.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index e46448efc48d..6a1e75f98f16 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -187,30 +187,20 @@ void serdev_device_close(struct serdev_device *serdev)
 }
 EXPORT_SYMBOL_GPL(serdev_device_close);
 
-static void devm_serdev_device_release(struct device *dev, void *dr)
+static void devm_serdev_device_close(void *serdev)
 {
-	serdev_device_close(*(struct serdev_device **)dr);
+	serdev_device_close(serdev);
 }
 
 int devm_serdev_device_open(struct device *dev, struct serdev_device *serdev)
 {
-	struct serdev_device **dr;
 	int ret;
 
-	dr = devres_alloc(devm_serdev_device_release, sizeof(*dr), GFP_KERNEL);
-	if (!dr)
-		return -ENOMEM;
-
 	ret = serdev_device_open(serdev);
-	if (ret) {
-		devres_free(dr);
+	if (ret)
 		return ret;
-	}
 
-	*dr = serdev;
-	devres_add(dev, dr);
-
-	return 0;
+	return devm_add_action_or_reset(dev, devm_serdev_device_close, serdev);
 }
 EXPORT_SYMBOL_GPL(devm_serdev_device_open);
 
-- 
2.40.0.1.gaa8946217a0b

