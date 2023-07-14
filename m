Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9351A753647
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235820AbjGNJSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235801AbjGNJSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:18:21 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1952D51;
        Fri, 14 Jul 2023 02:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689326298; x=1720862298;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zN+eDH4bSonahOLd7oZfC6x/CMBxwEXOjKeHROeGChE=;
  b=MCARfTwUMLBcCdiH7djCuTtadkbhmKboMsBdn2zWSFV+QkPQRm8P5fGQ
   b1V8mc9jZ8mesR9GgKUMjHcZYxzlrXqfpT7j/il4JCQo8UxNcP0YYq/mO
   tY5fc7NhbZNtFP6+m/HMXl1MzSZ+DUbzeBYzdUffy03LJxcM5x/7FS/ZY
   1+RCY0Rz7Hm6PozBmPgTiHJV0pI16y1sBeRPBXul0AoUr8nlKfJpfq7Yj
   l/xrXShiytF/aQULn8m9NlmDd/gFj/qro/M/e4PxFPyQ4id0c25iQPJKw
   dODWp2Azc6tR3o2DB6BYYNuBl+1hmSd8GXie9iENRPTePdXttdINJghXa
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="365468998"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="365468998"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 02:17:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="716281742"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="716281742"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 14 Jul 2023 02:17:44 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 93C71385; Fri, 14 Jul 2023 12:17:50 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v4 2/4] spi: Kill spi_add_device_locked()
Date:   Fri, 14 Jul 2023 12:17:46 +0300
Message-Id: <20230714091748.89681-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230714091748.89681-1-andriy.shevchenko@linux.intel.com>
References: <20230714091748.89681-1-andriy.shevchenko@linux.intel.com>
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

Now, spi_add_device_locked() has just a line on top of __spi_add_device().
Besides that, it has a single caller. So, just kill it and embed its parts
into the caller.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 8e70f4183e62..05f702339182 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -708,14 +708,6 @@ int spi_add_device(struct spi_device *spi)
 }
 EXPORT_SYMBOL_GPL(spi_add_device);
 
-static int spi_add_device_locked(struct spi_device *spi)
-{
-	struct spi_controller *ctlr = spi->controller;
-
-	WARN_ON(!mutex_is_locked(&ctlr->add_lock));
-	return __spi_add_device(spi);
-}
-
 /**
  * spi_new_device - instantiate one new SPI device
  * @ctlr: Controller to which device is connected
@@ -2417,11 +2409,12 @@ static void of_register_spi_devices(struct spi_controller *ctlr) { }
 struct spi_device *spi_new_ancillary_device(struct spi_device *spi,
 					     u8 chip_select)
 {
+	struct spi_controller *ctlr = spi->controller;
 	struct spi_device *ancillary;
 	int rc = 0;
 
 	/* Alloc an spi_device */
-	ancillary = spi_alloc_device(spi->controller);
+	ancillary = spi_alloc_device(ctlr);
 	if (!ancillary) {
 		rc = -ENOMEM;
 		goto err_out;
@@ -2436,8 +2429,10 @@ struct spi_device *spi_new_ancillary_device(struct spi_device *spi,
 	ancillary->max_speed_hz = spi->max_speed_hz;
 	ancillary->mode = spi->mode;
 
+	WARN_ON(!mutex_is_locked(&ctlr->add_lock));
+
 	/* Register the new device */
-	rc = spi_add_device_locked(ancillary);
+	rc = __spi_add_device(ancillary);
 	if (rc) {
 		dev_err(&spi->dev, "failed to register ancillary device\n");
 		goto err_out;
-- 
2.40.0.1.gaa8946217a0b

