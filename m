Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0486D7D5045
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 14:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234481AbjJXMue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 08:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234405AbjJXMuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 08:50:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72870D79;
        Tue, 24 Oct 2023 05:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698151819; x=1729687819;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=knR7ls1kB5KT3RFeC+htrjrkzsMRNbLQDuFhEdcYC3I=;
  b=fKKAwqvxkCUp65mrkvSjley4uzLtMycVd9EwR53AZT3JP8yhSPGRGbY1
   x8ZMnebWVwgWRDjnZiZC5Os6ZQrwj0HdfRMlTKfdeuWbZAqoVt5k0XwLW
   MEDWU3ocqCZ8EjSC03EPfrj8Stst4pyLZ7Kg7uV0vBV+G58r7Uqpo3eUf
   XJwCvC9cpM+On5+JBrXk2VLCsLIs3XYPzI6cQJACkmeGffc+aagnp2rzs
   8lqZb+vSnc4JTTfDeUCo8jTOeb+6fKfQNMwERPelkqZ16qgfoPgEx9fxz
   oiikxgPhhnjGf3CugPyNxNjySFIJfqhB+0RzU+PiXfa8et29Z/RizNC90
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="418172703"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="418172703"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 05:50:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="875061014"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="875061014"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 24 Oct 2023 05:50:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5AD9681C; Tue, 24 Oct 2023 15:41:17 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH v1 1/3] serdev: Make use of device_set_node()
Date:   Tue, 24 Oct 2023 15:41:13 +0300
Message-Id: <20231024124115.3598090-2-andriy.shevchenko@linux.intel.com>
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

Use device_set_node() instead of assigning ctrl->dev.of_node
directly because it also sets the firmware node.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serdev/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index e7d663901c07..e46448efc48d 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -15,9 +15,11 @@
 #include <linux/of_device.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
+#include <linux/property.h>
 #include <linux/sched.h>
 #include <linux/serdev.h>
 #include <linux/slab.h>
+
 #include <linux/platform_data/x86/apple.h>
 
 static bool is_registered;
@@ -510,7 +512,7 @@ struct serdev_controller *serdev_controller_alloc(struct device *parent,
 	ctrl->dev.type = &serdev_ctrl_type;
 	ctrl->dev.bus = &serdev_bus_type;
 	ctrl->dev.parent = parent;
-	ctrl->dev.of_node = parent->of_node;
+	device_set_node(&ctrl->dev, dev_fwnode(parent));
 	serdev_controller_set_drvdata(ctrl, &ctrl[1]);
 
 	dev_set_name(&ctrl->dev, "serial%d", id);
-- 
2.40.0.1.gaa8946217a0b

