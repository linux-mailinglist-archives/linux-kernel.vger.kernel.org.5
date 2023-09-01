Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0628B78FE76
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 15:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349828AbjIANlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 09:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349792AbjIANky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 09:40:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A841DE4C;
        Fri,  1 Sep 2023 06:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693575651; x=1725111651;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+33bqCDF5uOYXY98UJQ56l828bdx6zq0e0aD3aeaQRg=;
  b=bc9xVI2AUttv2M+ncoX1ufKmUHbtwLE2EZFNYpAVoviau6R1+Wjg/U4/
   14a3XhbQweICh0vWghITEdXGhN0RfZYt6Oj47GKLcblCNPcr8wOVzbk4D
   8cIW8V+CwHutOutGQEhIMdxqxLds2JjtxshJHh+K6iUOEOz1MT+7zkjGb
   ysbvdTKX3nZ/biA1FWrXQycZ4I8IRCneIW1oZ3O+uyHUlhe0lUTRXjxHZ
   eB6W3vk9QM74ga76HdobwQUtMigJrGtLpak0z4IFLyCFzdXiumYDS346l
   jW5cnsPbOlHLnPavNxmt1VM1a5YVJfYkpPsgv7ROKFA34GQ8MGCs0n5Ua
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="373617942"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="373617942"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 06:40:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="986684300"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="986684300"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 01 Sep 2023 06:40:48 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5B9A4892; Fri,  1 Sep 2023 16:40:44 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 09/10] gpio: pca953x: Get rid of useless goto label
Date:   Fri,  1 Sep 2023 16:40:40 +0300
Message-Id: <20230901134041.1165562-9-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230901134041.1165562-1-andriy.shevchenko@linux.intel.com>
References: <20230901134041.1165562-1-andriy.shevchenko@linux.intel.com>
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

In a few functions goto label is useless as there are no locking,
no nothing that may justify its usage. Get rid of it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-pca953x.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index bf27e2d920f7..16f5e3043bf0 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -988,20 +988,18 @@ static int device_pca95xx_init(struct pca953x_chip *chip)
 	ret = regcache_sync_region(chip->regmap, regaddr,
 				   regaddr + NBANK(chip) - 1);
 	if (ret)
-		goto out;
+		return ret;
 
 	regaddr = chip->recalc_addr(chip, chip->regs->direction, 0);
 	ret = regcache_sync_region(chip->regmap, regaddr,
 				   regaddr + NBANK(chip) - 1);
 	if (ret)
-		goto out;
+		return ret;
 
 	/* clear polarity inversion */
 	bitmap_zero(val, MAX_LINE);
 
-	ret = pca953x_write_regs(chip, chip->regs->invert, val);
-out:
-	return ret;
+	return pca953x_write_regs(chip, chip->regs->invert, val);
 }
 
 static int device_pca957x_init(struct pca953x_chip *chip)
@@ -1012,19 +1010,13 @@ static int device_pca957x_init(struct pca953x_chip *chip)
 
 	ret = device_pca95xx_init(chip);
 	if (ret)
-		goto out;
+		return ret;
 
 	/* To enable register 6, 7 to control pull up and pull down */
 	for (i = 0; i < NBANK(chip); i++)
 		bitmap_set_value8(val, 0x02, i * BANK_SZ);
 
-	ret = pca953x_write_regs(chip, PCA957X_BKEN, val);
-	if (ret)
-		goto out;
-
-	return 0;
-out:
-	return ret;
+	return pca953x_write_regs(chip, PCA957X_BKEN, val);
 }
 
 static void pca953x_disable_regulator(void *reg)
@@ -1262,12 +1254,10 @@ static int pca953x_resume(struct device *dev)
 	}
 
 	ret = pca953x_restore_context(chip);
-	if (ret) {
+	if (ret)
 		dev_err(dev, "Failed to restore register map: %d\n", ret);
-		return ret;
-	}
 
-	return 0;
+	return ret;
 }
 
 static DEFINE_SIMPLE_DEV_PM_OPS(pca953x_pm_ops, pca953x_suspend, pca953x_resume);
-- 
2.40.0.1.gaa8946217a0b

