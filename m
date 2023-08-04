Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCEC677034F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 16:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbjHDOjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 10:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjHDOjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 10:39:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE5F46B2;
        Fri,  4 Aug 2023 07:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691159952; x=1722695952;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C+abYiF6wNXvU9smtguynoZRdwPpMDNeO7w58qCuOuc=;
  b=mV2csy/kDtGEGU2W1/LM6YhOA7NhRWf3t2pBP0GXHELsYO9UD9eO/GI6
   +KWlp4Y1nmKIIvRFLsOkjpqNIsTbb3ZhiHo4Cot/sboYvUQu5lb/PCQGr
   ifw+Oh3MMqmnKu5q9SqAuKIlupn5p17dWH6SuwM2BEbVp2wDEVT6Tbad5
   AueW4Vpl0u7oKdnxNO4aT3KkyDnvsAbJsvJsy6QzBKWBtso8Z4Qv9htNM
   VlKr92RmOrxFUowuox+E4uFgjBMvgwZQiPl8eajI7/WPha2Le9xGxd3pH
   qduYLr4c9B/4oBq41/xy3TOiGKLH8F27NYCtWEqIeHqClQ6BHdeBY1zAG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="436487304"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="436487304"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 07:39:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="795444755"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="795444755"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 04 Aug 2023 07:39:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 84A24BAB; Fri,  4 Aug 2023 17:39:14 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-hardening@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tero Kristo <kristo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v2 2/4] driver core: Replace kstrdup() + strreplace() with kstrdup_and_replace()
Date:   Fri,  4 Aug 2023 17:39:08 +0300
Message-Id: <20230804143910.15504-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230804143910.15504-1-andriy.shevchenko@linux.intel.com>
References: <20230804143910.15504-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace open coded functionality of kstrdup_and_replace() with a call.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 46d1d78c5beb..704ba73e1459 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -17,7 +17,6 @@
 #include <linux/kstrtox.h>
 #include <linux/module.h>
 #include <linux/slab.h>
-#include <linux/string.h>
 #include <linux/kdev_t.h>
 #include <linux/notifier.h>
 #include <linux/of.h>
@@ -28,6 +27,7 @@
 #include <linux/netdevice.h>
 #include <linux/sched/signal.h>
 #include <linux/sched/mm.h>
+#include <linux/string_helpers.h>
 #include <linux/swiotlb.h>
 #include <linux/sysfs.h>
 #include <linux/dma-map-ops.h> /* for dma_default_coherent */
@@ -3908,10 +3908,9 @@ const char *device_get_devnode(const struct device *dev,
 		return dev_name(dev);
 
 	/* replace '!' in the name with '/' */
-	s = kstrdup(dev_name(dev), GFP_KERNEL);
+	s = kstrdup_and_replace(dev_name(dev), '!', '/', GFP_KERNEL);
 	if (!s)
 		return NULL;
-	strreplace(s, '!', '/');
 	return *tmp = s;
 }
 
-- 
2.40.0.1.gaa8946217a0b

