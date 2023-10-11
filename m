Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCB67C5E56
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 22:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376414AbjJKU0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 16:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376374AbjJKU0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 16:26:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274FD91;
        Wed, 11 Oct 2023 13:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697056007; x=1728592007;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w7GO/YmuQf/fATRgis2loCwaDUE9BWEr6AP7smZXouQ=;
  b=QkSij/IFfw5XSTitxh/Sv3qHEFL6EM+pCfhY6VvaGoXZ5afhc7Xegnbx
   ISzfZAjJLUSIirAndEa6ZMS5ShpJT6aOkkjT62xi2ON8N3JM3r88DfGHH
   iGECrvNnn0RgPUY4L459WftXiaFkbiXNr2m3+BgBhetohYKdcs+wxuDQQ
   prI5ueKYWdgg2S++ocZQ43U5Veg2UccNZfUOG4FdzW9p6p895av2aj21g
   jrF5r7NwT2pmOcOY7YI1q12O18w29t/AEigVc58TnPiQ3rjH4QKICNRaa
   KRRmWPudqtj25JpBi/xfjb37qJg+HWHtVmNtdO3eTcCM1mWHjqaZhro7k
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="3349165"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="3349165"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 13:26:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="824311018"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="824311018"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 11 Oct 2023 13:26:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 37B4E71B; Wed, 11 Oct 2023 23:26:42 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dipen Patel <dipenp@nvidia.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, timestamp@lists.linux.dev,
        linux-tegra@vger.kernel.org
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH v2 4/4] hte: tegra194: Switch to LATE_SIMPLE_DEV_PM_OPS()
Date:   Wed, 11 Oct 2023 23:26:38 +0300
Message-Id: <20231011202638.372382-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20231011202638.372382-1-andriy.shevchenko@linux.intel.com>
References: <20231011202638.372382-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SET_LATE_SYSTEM_SLEEP_PM_OPS is deprecated, replace it with
LATE_SYSTEM_SLEEP_PM_OPS() and use pm_sleep_ptr() for setting
the driver's pm routines. We can now remove the __maybe_unused
qualifier in the suspend and resume functions.

Tested-by: Dipen Patel <dipenp@nvidia.com>
Reviewed-by: Dipen Patel <dipenp@nvidia.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/20231010151709.4104747-5-andriy.shevchenko@linux.intel.com
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hte/hte-tegra194.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/hte/hte-tegra194.c b/drivers/hte/hte-tegra194.c
index cf6058193403..76e1b774c55e 100644
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
+		.pm = pm_sleep_ptr(&tegra_hte_pm),
 		.of_match_table = tegra_hte_of_match,
 	},
 };
-- 
2.40.0.1.gaa8946217a0b

