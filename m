Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A4F78FE70
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 15:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349806AbjIANk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 09:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345703AbjIANkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 09:40:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830E710D5;
        Fri,  1 Sep 2023 06:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693575649; x=1725111649;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Mv+2R+CB8kcm+yZnicFdMrFySQSWpkEyMVfWLVjf3aw=;
  b=e9S4mVWXDFAZBlBLRk8cGB54gFde2lSiM5U4C1PjM7eIQnyk6oo3R0CV
   WAoVZ+eq/M2SUKJuJJ9zsvZ6FbfFsJa+6wTYs1JtZVR+0x+VtuVhtUjXl
   zuZ3olCikiKXhJosQ8O/IslEm3It6kmdDJs98+TPVFXxL1PL6/Ov2Rts2
   fOlKTm6aHhb1Kt/S8mqyUprGnsifQuS00eoM2ilJT/k4E5TTcjPwHUawl
   IIjjGEoiE4H9KkobuNc+L8Qk7i46Rr1X0yVRP6CdtizTsPG+X8/ECU6hg
   k/rdmVRygnOLx6oCHtS2+Ou0oo8BH+yMlXfViOouVNhlPIyLrzamDSJ3x
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="366447074"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="366447074"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 06:40:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="1070754506"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="1070754506"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 01 Sep 2023 06:40:45 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2E61679F; Fri,  1 Sep 2023 16:40:44 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 04/10] gpio: pca953x: Split pca953x_restore_context() and pca953x_save_context()
Date:   Fri,  1 Sep 2023 16:40:35 +0300
Message-Id: <20230901134041.1165562-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230901134041.1165562-1-andriy.shevchenko@linux.intel.com>
References: <20230901134041.1165562-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split regcache handling to the respective helpers. It will allow to
have further refactoring with ease.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-pca953x.c | 44 ++++++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 15 deletions(-)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index 4249ec350ace..71d87d570a2b 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -1182,9 +1182,9 @@ static int pca953x_probe(struct i2c_client *client)
 }
 
 #ifdef CONFIG_PM_SLEEP
-static int pca953x_regcache_sync(struct device *dev)
+static int pca953x_regcache_sync(struct pca953x_chip *chip)
 {
-	struct pca953x_chip *chip = dev_get_drvdata(dev);
+	struct device *dev = &chip->client->dev;
 	int ret;
 	u8 regaddr;
 
@@ -1231,13 +1231,37 @@ static int pca953x_regcache_sync(struct device *dev)
 	return 0;
 }
 
-static int pca953x_suspend(struct device *dev)
+static int pca953x_restore_context(struct pca953x_chip *chip)
 {
-	struct pca953x_chip *chip = dev_get_drvdata(dev);
+	int ret;
 
+	mutex_lock(&chip->i2c_lock);
+
+	regcache_cache_only(chip->regmap, false);
+	regcache_mark_dirty(chip->regmap);
+	ret = pca953x_regcache_sync(chip);
+	if (ret) {
+		mutex_unlock(&chip->i2c_lock);
+		return ret;
+	}
+
+	ret = regcache_sync(chip->regmap);
+	mutex_unlock(&chip->i2c_lock);
+	return ret;
+}
+
+static void pca953x_save_context(struct pca953x_chip *chip)
+{
 	mutex_lock(&chip->i2c_lock);
 	regcache_cache_only(chip->regmap, true);
 	mutex_unlock(&chip->i2c_lock);
+}
+
+static int pca953x_suspend(struct device *dev)
+{
+	struct pca953x_chip *chip = dev_get_drvdata(dev);
+
+	pca953x_save_context(chip);
 
 	if (atomic_read(&chip->wakeup_path))
 		device_set_wakeup_path(dev);
@@ -1260,17 +1284,7 @@ static int pca953x_resume(struct device *dev)
 		}
 	}
 
-	mutex_lock(&chip->i2c_lock);
-	regcache_cache_only(chip->regmap, false);
-	regcache_mark_dirty(chip->regmap);
-	ret = pca953x_regcache_sync(dev);
-	if (ret) {
-		mutex_unlock(&chip->i2c_lock);
-		return ret;
-	}
-
-	ret = regcache_sync(chip->regmap);
-	mutex_unlock(&chip->i2c_lock);
+	ret = pca953x_restore_context(chip);
 	if (ret) {
 		dev_err(dev, "Failed to restore register map: %d\n", ret);
 		return ret;
-- 
2.40.0.1.gaa8946217a0b

