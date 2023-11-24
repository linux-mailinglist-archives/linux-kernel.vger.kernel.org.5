Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438FF7F8505
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 21:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346115AbjKXUDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 15:03:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbjKXUDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 15:03:01 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5741707
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 12:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700856186; x=1732392186;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G09mUvl/RQNAtAzlY9grLZnLKlc0fBxbF/IUfivypek=;
  b=dyb/UG6Js2b10cWn8vw+J/07KoGvstf/iuXiC+vp1uXNe2HhTBEs2Bdn
   UmBEROvzYzn0X+ASokZuy8ZT7xV7PEqH2+T2DuvFCUrF8ChhFFZd9E21t
   rhE/TgkBHYGUiMCs/mWirTydfs43E35j7U0Z5HBbXiKr1+AfH8yj2stSd
   Ek2bIvAFxxQ0sqBJr2k/X5q1mDMJt/1nXfga4tlRexBW2AL6iM8W73uZ6
   /Y9Bg2E6XNrD6WVnQlZNmKFnq+DdeV2/x2meeks+sUwoNeaY1qfAwMeXk
   Rap/dfImmnxD0ZP6e6GjbU7DD/0KALP0JfClbSELdipGudXI3E/t0Gwb8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="396366606"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="396366606"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 12:03:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="833763308"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="833763308"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 24 Nov 2023 12:03:04 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 944791A7; Fri, 24 Nov 2023 22:03:03 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee@kernel.org>
Subject: [PATCH v1 1/5] mfd: intel-lpss: Revert "Add missing check for platform_get_resource"
Date:   Fri, 24 Nov 2023 21:31:24 +0200
Message-ID: <20231124200258.3682979-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20231124200258.3682979-1-andriy.shevchenko@linux.intel.com>
References: <20231124200258.3682979-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit d918e0d5824495a75d00b879118b098fcab36fdb.

The commit in question does not fix anything and only introduces
a duplication in the code. The main intel_lpss_probe() performs
all necessary checks.

While at it and in order of avoiding similar patches to come, add
a comment.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/intel-lpss-acpi.c | 4 +---
 drivers/mfd/intel-lpss-pci.c  | 1 +
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/intel-lpss-acpi.c b/drivers/mfd/intel-lpss-acpi.c
index 5184fd1a5df1..52ffc0d9c23f 100644
--- a/drivers/mfd/intel-lpss-acpi.c
+++ b/drivers/mfd/intel-lpss-acpi.c
@@ -182,10 +182,8 @@ static int intel_lpss_acpi_probe(struct platform_device *pdev)
 	if (!info)
 		return -ENOMEM;
 
+	/* No need to check mem and irq here as intel_lpss_probe() does it for us */
 	info->mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!info->mem)
-		return -ENODEV;
-
 	info->irq = platform_get_irq(pdev, 0);
 
 	ret = intel_lpss_probe(&pdev->dev, info);
diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
index cf56cd3a40ee..709b0fb4419d 100644
--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -46,6 +46,7 @@ static int intel_lpss_pci_probe(struct pci_dev *pdev,
 	if (!info)
 		return -ENOMEM;
 
+	/* No need to check mem and irq here as intel_lpss_probe() does it for us */
 	info->mem = pci_resource_n(pdev, 0);
 	info->irq = pci_irq_vector(pdev, 0);
 
-- 
2.43.0.rc1.1.gbec44491f096

