Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B3B7BB5C0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 12:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbjJFK6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 06:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbjJFK6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 06:58:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B252DB;
        Fri,  6 Oct 2023 03:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696589889; x=1728125889;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xHrblxy5LJz/0z88RZl5mzsZZ2ICJvk7WRsbXXPcjSk=;
  b=eLfRYWCV3bGI9irzossFRI9/pg/VNjFK9yV54VSiSlbq7GbosVmYoMF0
   NYeCA7aTc8HLUYOe7QPebB05miOkvZAlYW7vKcTXUF4xeUj4z5bY9IaOJ
   ViJL+cfyluUPt19JuP0J+E/Bzz14oIPiG9n09Q6uBjtBAkXdoc57oSrZy
   nx0yPvJjhINCu/I2mtsCwkOMyaEtCbBbVEe28P9XHt4yM9T/lmJj/eT71
   FaaAHwMFOr5tnFBBqaZmGN97EDfXImPgeAuTKT1FWUM/ulDCEZ/Iyfu9j
   8XWlcWgdKo25EWBk5LUcLkeLEdGiiPsUOr7sH6M2GgXGp8Uyn9rjbXXy7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="363082468"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="363082468"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 03:58:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="875906267"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="875906267"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 06 Oct 2023 03:58:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5C8934F4; Fri,  6 Oct 2023 13:58:05 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] mmc: sdhci-pltfm: Drop unnecessary error messages in sdhci_pltfm_init()
Date:   Fri,  6 Oct 2023 13:58:02 +0300
Message-Id: <20231006105803.3374241-1-andriy.shevchenko@linux.intel.com>
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

The devm_platform_ioremap_resource() and platform_get_irq() print
the error messages themselves and our "failed" one brings no value
and just noise. Refactor code to avoid those noisy error messages.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mmc/host/sdhci-pltfm.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index a72e123a585d..4d1a703a5bdb 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -115,26 +115,21 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
 {
 	struct sdhci_host *host;
 	void __iomem *ioaddr;
-	int irq, ret;
+	int irq;
 
 	ioaddr = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(ioaddr)) {
-		ret = PTR_ERR(ioaddr);
-		goto err;
-	}
+	if (IS_ERR(ioaddr))
+		return ERR_CAST(ioaddr);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		ret = irq;
-		goto err;
-	}
+	if (irq < 0)
+		return ERR_PTR(irq);
 
 	host = sdhci_alloc_host(&pdev->dev,
 		sizeof(struct sdhci_pltfm_host) + priv_size);
-
 	if (IS_ERR(host)) {
-		ret = PTR_ERR(host);
-		goto err;
+		dev_err(&pdev->dev, "%s failed %pe\n", __func__, host);
+		return ERR_CAST(host);
 	}
 
 	host->ioaddr = ioaddr;
@@ -152,9 +147,6 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
 	platform_set_drvdata(pdev, host);
 
 	return host;
-err:
-	dev_err(&pdev->dev, "%s failed %d\n", __func__, ret);
-	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(sdhci_pltfm_init);
 
-- 
2.40.0.1.gaa8946217a0b

