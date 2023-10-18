Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 266117CD2BA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 05:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjJRDiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 23:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjJRDh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 23:37:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE9BFE;
        Tue, 17 Oct 2023 20:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697600275; x=1729136275;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=P1Y4r0Us5zf2Vwf6/V8LkQboWRZ55cSVjIX4qdzVeSk=;
  b=IrcPtQlbJZ8pAL03p86V+Dfn9/gMhorF7rrp1NyThg4UXtlP/4B59jw/
   lTxfBvdxHWWt9XsL2WfdQ6NQJ49g2FykuosHny50lp2htmyq1MKyPcZAN
   T/AxZT0iahqcwr+UzRXrif2EliF083C5wnO4O7Ou8GHBx82bdZ5RFiBRk
   VyBplv97pN+CBsjTq8C37/HeYbPLQOGza2SVuwVoEsZgCmMeiNr3WMHgq
   mE2ImF2njNb2kfshLTwzl0Q/NchKgmNaveFbHLQJw78s81Z5C96n1P/GE
   ZAOWWPuZXrzhCyQHvpwvcJEEGGJSzAzIpi6wdYd4odQcuHoPF3T8rKdk/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="384808946"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="384808946"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 20:37:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="822264440"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="822264440"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 17 Oct 2023 20:37:53 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E2A0E130; Wed, 18 Oct 2023 06:37:51 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
        linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] fbdev: omapfb: Do not shadow error code from platform_get_irq()
Date:   Wed, 18 Oct 2023 06:37:50 +0300
Message-Id: <20231018033750.1123859-1-andriy.shevchenko@linux.intel.com>
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

There is no point in shadowing the error codes from platform_get_irq().
Refactor omapfb_do_probe() accordingly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/video/fbdev/omap/omapfb_main.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/video/fbdev/omap/omapfb_main.c b/drivers/video/fbdev/omap/omapfb_main.c
index 42c96f1cfc93..631076bf71f9 100644
--- a/drivers/video/fbdev/omap/omapfb_main.c
+++ b/drivers/video/fbdev/omap/omapfb_main.c
@@ -1643,17 +1643,16 @@ static int omapfb_do_probe(struct platform_device *pdev,
 		r = -ENOMEM;
 		goto cleanup;
 	}
-	fbdev->int_irq = platform_get_irq(pdev, 0);
-	if (fbdev->int_irq < 0) {
-		r = -ENXIO;
+
+	r = platform_get_irq(pdev, 0);
+	if (r < 0)
 		goto cleanup;
-	}
+	fbdev->int_irq = r;
 
-	fbdev->ext_irq = platform_get_irq(pdev, 1);
-	if (fbdev->ext_irq < 0) {
-		r = -ENXIO;
+	r = platform_get_irq(pdev, 1);
+	if (r < 0)
 		goto cleanup;
-	}
+	fbdev->ext_irq = r;
 
 	init_state++;
 
-- 
2.40.0.1.gaa8946217a0b

