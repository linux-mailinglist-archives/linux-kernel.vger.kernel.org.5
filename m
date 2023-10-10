Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E3B7C002E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 17:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbjJJPRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 11:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbjJJPRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 11:17:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F780B0;
        Tue, 10 Oct 2023 08:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696951035; x=1728487035;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b+eQ/uwdz+URzIJFW2ABqaZbfeJbxTuJSgGGfs7US3E=;
  b=LsU22sFTfH8FUie4sWiAbw/3z91MMYKZPy5IxgvFFZLr4QYBFQNrdViS
   VOC7a0gTtM6F33qpsnY17vr0oZPBte9ig6DnKrdLighZTSLvKT3Z/UR4D
   9ucQdg09FGp3mjMGSbDKdErP61Ld4RRR0yZbvRJ3bDKzObfuC91/vTzTJ
   2a6Vc/946DuDI3oBAEB+138JSzq2jpr1rTSRwaW8uCUbXQDRDyOiZzn5t
   gtiGdq0peMJmLvXhcE5HY8sHxjUSpQ9h3OD/9c1eiylrSs3FzdX3SByND
   uoDGIKhpMg3YT7Tgi/uMFE/nPrrlVt9vlTpE5gHpFsoD5uG06JCDwS034
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="363771580"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="363771580"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 08:17:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="823812775"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="823812775"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 10 Oct 2023 08:17:11 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 524C671B; Tue, 10 Oct 2023 18:17:10 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dipen Patel <dipenp@nvidia.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, timestamp@lists.linux.dev,
        linux-tegra@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH v1 4/4] hte: tegra194: Switch to LATE_SIMPLE_DEV_PM_OPS()
Date:   Tue, 10 Oct 2023 18:17:09 +0300
Message-Id: <20231010151709.4104747-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20231010151709.4104747-1-andriy.shevchenko@linux.intel.com>
References: <20231010151709.4104747-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SET_LATE_SYSTEM_SLEEP_PM_OPS is deprecated, replace it with
LATE_SYSTEM_SLEEP_PM_OPS() and use pm_sleep_ptr() for setting
the driver's pm routines. We can now remove the __maybe_unused
qualifier in the suspend and resume functions.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hte/hte-tegra194.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/hte/hte-tegra194.c b/drivers/hte/hte-tegra194.c
index 30ef1750a9fa..30fa7c0a555e 100644
--- a/drivers/hte/hte-tegra194.c
+++ b/drivers/hte/hte-tegra194.c
@@ -815,7 +815,7 @@ static int tegra_hte_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __maybe_unused tegra_hte_resume_early(struct device *dev)
+static int tegra_hte_resume_early(struct device *dev)
 {
 	u32 i;
 	struct tegra_hte_soc *gs = dev_get_drvdata(dev);
@@ -836,7 +836,7 @@ static int __maybe_unused tegra_hte_resume_early(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused tegra_hte_suspend_late(struct device *dev)
+static int tegra_hte_suspend_late(struct device *dev)
 {
 	u32 i;
 	struct tegra_hte_soc *gs = dev_get_drvdata(dev);
@@ -856,15 +856,14 @@ static int __maybe_unused tegra_hte_suspend_late(struct device *dev)
 }
 
 static const struct dev_pm_ops tegra_hte_pm = {
-	SET_LATE_SYSTEM_SLEEP_PM_OPS(tegra_hte_suspend_late,
-				     tegra_hte_resume_early)
+	LATE_SYSTEM_SLEEP_PM_OPS(tegra_hte_suspend_late, tegra_hte_resume_early)
 };
 
 static struct platform_driver tegra_hte_driver = {
 	.probe = tegra_hte_probe,
 	.driver = {
 		.name = "tegra_hte",
-		.pm = &tegra_hte_pm,
+		.pm = pm_slee_ptr(&tegra_hte_pm),
 		.of_match_table = tegra_hte_of_match,
 	},
 };
-- 
2.40.0.1.gaa8946217a0b

