Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68FE57BB5C1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 12:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbjJFK6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 06:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbjJFK6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 06:58:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B43DDE;
        Fri,  6 Oct 2023 03:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696589889; x=1728125889;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=6MLMXL4M6BDsSXjfE8vIxvogcxwlXrYT4iShqFi4veI=;
  b=gLt7BjcQ7ti0yWSGBPQUmkX95Vqp2HkXomr7Z4H0WoO0vm4VY2r8ubTN
   I+0N7QfID++arH2a1wrf/rEO+U/3FjFsl2qg4h5J8JpSfGhOicchlUOQ4
   bDf29M+vsLd8D8BAC7kqgZCFtiUxjYqUb/ROMv2bU7kJpTfGPNfPjEcL2
   G6VgEy058vf3PcquLFuMDOPsilAwpt9NiVe3Lkd8+Kv3M+0Ga94PyhTtK
   B5ROYvSqYAXW1UnZr+XUQ4ZUvIEygHbETdy38g+Z1pcDNt01trrupTB9w
   H2y7LGZQYsFqPZBNYAsasuxUIG02KvmjsTtot/YogCAS1Ao7ftF7fLFe5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="447915549"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="447915549"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 03:58:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="728807796"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="728807796"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 06 Oct 2023 03:58:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 86801430; Fri,  6 Oct 2023 13:58:05 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] mmc: sdhci-pltfm: Make driver OF independent
Date:   Fri,  6 Oct 2023 13:58:03 +0300
Message-Id: <20231006105803.3374241-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20231006105803.3374241-1-andriy.shevchenko@linux.intel.com>
References: <20231006105803.3374241-1-andriy.shevchenko@linux.intel.com>
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

Since we have device_is_compatible() API, drop OF dependency
in the driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mmc/host/sdhci-pltfm.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 4d1a703a5bdb..62753d72198a 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -19,7 +19,6 @@
 #include <linux/err.h>
 #include <linux/module.h>
 #include <linux/property.h>
-#include <linux/of.h>
 #ifdef CONFIG_PPC
 #include <asm/machdep.h>
 #endif
@@ -56,19 +55,16 @@ static bool sdhci_wp_inverted(struct device *dev)
 
 static void sdhci_get_compatibility(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct sdhci_host *host = platform_get_drvdata(pdev);
-	struct device_node *np = pdev->dev.of_node;
 
-	if (!np)
-		return;
-
-	if (of_device_is_compatible(np, "fsl,p2020-rev1-esdhc"))
+	if (device_is_compatible(dev, "fsl,p2020-rev1-esdhc"))
 		host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
 
-	if (of_device_is_compatible(np, "fsl,p2020-esdhc") ||
-	    of_device_is_compatible(np, "fsl,p1010-esdhc") ||
-	    of_device_is_compatible(np, "fsl,t4240-esdhc") ||
-	    of_device_is_compatible(np, "fsl,mpc8536-esdhc"))
+	if (device_is_compatible(dev, "fsl,p2020-esdhc") ||
+	    device_is_compatible(dev, "fsl,p1010-esdhc") ||
+	    device_is_compatible(dev, "fsl,t4240-esdhc") ||
+	    device_is_compatible(dev, "fsl,mpc8536-esdhc"))
 		host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
 }
 
-- 
2.40.0.1.gaa8946217a0b

