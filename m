Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0577F199B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 18:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbjKTRSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 12:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjKTRSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 12:18:08 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885D0BA;
        Mon, 20 Nov 2023 09:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700500684; x=1732036684;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UC5hPVWUnGTOtRCW9QVVFZlDvGId3Mtjmo1Ght7VoyE=;
  b=FPo5yJrUKJVfAzyGp9enSsHaWqFl6fp9inMNmxgnqcUNw+PuLEs5cUQt
   XLNXnlW+a047pH+AEiewjTqIOQ1J43ddt3/mhwUMk36EaTL1T15n4Jr6r
   NCDv/1O1LKmj9+aP1GAhZSpvNHJyNxvx/hL6SKGLkDFF5eJXTjNieQ1y/
   yA0fLf76EaBMAk8u89H1Osl1Gqs26OJiLv6aSy47jpIi0WoZStyX9Yiix
   bNsapBvTQzivo/tBJQcaquLwNTEPVFcDNNhKUwX1KeB0BfsUefZynMcNB
   4+JWutKojxqedGmAM/GEm1pC9Gpyh2z/QkUr+DWfmaDLG6VnEUelwSZw5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="391443956"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="391443956"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 09:18:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="836782614"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="836782614"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 20 Nov 2023 09:18:01 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 09F946B; Mon, 20 Nov 2023 19:17:59 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Sean Wang <sean.wang@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v3 1/1] pinctrl: mediatek: Switch to use no-IRQ PM helpers
Date:   Mon, 20 Nov 2023 19:15:31 +0200
Message-ID: <20231120171754.1665539-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since pm.h provides a helper for system no-IRQ PM callbacks,
switch the driver to use it instead of open coded variant.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

v3:
- used EXPORT_... helper and pm_sleep_ptr() (Paul)
- dropped renaming (Paul, Angelo, Jonathan)

 drivers/pinctrl/mediatek/pinctrl-mt2701.c     | 2 +-
 drivers/pinctrl/mediatek/pinctrl-mt2712.c     | 2 +-
 drivers/pinctrl/mediatek/pinctrl-mt6795.c     | 2 +-
 drivers/pinctrl/mediatek/pinctrl-mt8167.c     | 2 +-
 drivers/pinctrl/mediatek/pinctrl-mt8173.c     | 2 +-
 drivers/pinctrl/mediatek/pinctrl-mt8183.c     | 2 +-
 drivers/pinctrl/mediatek/pinctrl-mt8186.c     | 2 +-
 drivers/pinctrl/mediatek/pinctrl-mt8188.c     | 2 +-
 drivers/pinctrl/mediatek/pinctrl-mt8192.c     | 2 +-
 drivers/pinctrl/mediatek/pinctrl-mt8195.c     | 2 +-
 drivers/pinctrl/mediatek/pinctrl-mt8365.c     | 2 +-
 drivers/pinctrl/mediatek/pinctrl-mt8516.c     | 2 +-
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 5 ++---
 drivers/pinctrl/mediatek/pinctrl-paris.c      | 5 ++---
 14 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt2701.c b/drivers/pinctrl/mediatek/pinctrl-mt2701.c
index 5fb377c1668b..6b1c7122b0fb 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt2701.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt2701.c
@@ -533,7 +533,7 @@ static struct platform_driver mtk_pinctrl_driver = {
 	.driver = {
 		.name = "mediatek-mt2701-pinctrl",
 		.of_match_table = mt2701_pctrl_match,
-		.pm = &mtk_eint_pm_ops,
+		.pm = pm_sleep_ptr(&mtk_eint_pm_ops),
 	},
 };
 
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt2712.c b/drivers/pinctrl/mediatek/pinctrl-mt2712.c
index 8a6daa0db54b..bb7394ae252b 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt2712.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt2712.c
@@ -581,7 +581,7 @@ static struct platform_driver mtk_pinctrl_driver = {
 	.driver = {
 		.name = "mediatek-mt2712-pinctrl",
 		.of_match_table = mt2712_pctrl_match,
-		.pm = &mtk_eint_pm_ops,
+		.pm = pm_sleep_ptr(&mtk_eint_pm_ops),
 	},
 };
 
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt6795.c b/drivers/pinctrl/mediatek/pinctrl-mt6795.c
index 01e855ccd4dd..ee3ae3d2fa7e 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt6795.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt6795.c
@@ -612,7 +612,7 @@ static struct platform_driver mt6795_pinctrl_driver = {
 	.driver = {
 		.name = "mt6795-pinctrl",
 		.of_match_table = mt6795_pctrl_match,
-		.pm = &mtk_paris_pinctrl_pm_ops,
+		.pm = pm_sleep_ptr(&mtk_paris_pinctrl_pm_ops),
 	},
 	.probe = mtk_paris_pinctrl_probe,
 };
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8167.c b/drivers/pinctrl/mediatek/pinctrl-mt8167.c
index ba7f30c3296f..143c26622272 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8167.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8167.c
@@ -334,7 +334,7 @@ static struct platform_driver mtk_pinctrl_driver = {
 	.driver = {
 		.name = "mediatek-mt8167-pinctrl",
 		.of_match_table = mt8167_pctrl_match,
-		.pm = &mtk_eint_pm_ops,
+		.pm = pm_sleep_ptr(&mtk_eint_pm_ops),
 	},
 };
 
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8173.c b/drivers/pinctrl/mediatek/pinctrl-mt8173.c
index 455eec018f93..b214deeafbf1 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8173.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8173.c
@@ -347,7 +347,7 @@ static struct platform_driver mtk_pinctrl_driver = {
 	.driver = {
 		.name = "mediatek-mt8173-pinctrl",
 		.of_match_table = mt8173_pctrl_match,
-		.pm = &mtk_eint_pm_ops,
+		.pm = pm_sleep_ptr(&mtk_eint_pm_ops),
 	},
 };
 
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8183.c b/drivers/pinctrl/mediatek/pinctrl-mt8183.c
index ddc48b725c22..93e482c6b5fd 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8183.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8183.c
@@ -576,7 +576,7 @@ static struct platform_driver mt8183_pinctrl_driver = {
 	.driver = {
 		.name = "mt8183-pinctrl",
 		.of_match_table = mt8183_pinctrl_of_match,
-		.pm = &mtk_paris_pinctrl_pm_ops,
+		.pm = pm_sleep_ptr(&mtk_paris_pinctrl_pm_ops),
 	},
 	.probe = mtk_paris_pinctrl_probe,
 };
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8186.c b/drivers/pinctrl/mediatek/pinctrl-mt8186.c
index a02f7c326970..7be591591cce 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8186.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8186.c
@@ -1255,7 +1255,7 @@ static struct platform_driver mt8186_pinctrl_driver = {
 	.driver = {
 		.name = "mt8186-pinctrl",
 		.of_match_table = mt8186_pinctrl_of_match,
-		.pm = &mtk_paris_pinctrl_pm_ops,
+		.pm = pm_sleep_ptr(&mtk_paris_pinctrl_pm_ops),
 	},
 	.probe = mtk_paris_pinctrl_probe,
 };
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8188.c b/drivers/pinctrl/mediatek/pinctrl-mt8188.c
index c067e043e619..3975e99d9cf4 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8188.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8188.c
@@ -1658,7 +1658,7 @@ static struct platform_driver mt8188_pinctrl_driver = {
 	.driver = {
 		.name = "mt8188-pinctrl",
 		.of_match_table = mt8188_pinctrl_of_match,
-		.pm = &mtk_paris_pinctrl_pm_ops
+		.pm = pm_sleep_ptr(&mtk_paris_pinctrl_pm_ops)
 	},
 	.probe = mtk_paris_pinctrl_probe,
 };
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8192.c b/drivers/pinctrl/mediatek/pinctrl-mt8192.c
index dee1b3aefd36..e3a76381f7f4 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8192.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8192.c
@@ -1420,7 +1420,7 @@ static struct platform_driver mt8192_pinctrl_driver = {
 	.driver = {
 		.name = "mt8192-pinctrl",
 		.of_match_table = mt8192_pinctrl_of_match,
-		.pm = &mtk_paris_pinctrl_pm_ops,
+		.pm = pm_sleep_ptr(&mtk_paris_pinctrl_pm_ops),
 	},
 	.probe = mtk_paris_pinctrl_probe,
 };
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8195.c b/drivers/pinctrl/mediatek/pinctrl-mt8195.c
index 09c4dcef9338..83345c52b2fa 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8195.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8195.c
@@ -968,7 +968,7 @@ static struct platform_driver mt8195_pinctrl_driver = {
 	.driver = {
 		.name = "mt8195-pinctrl",
 		.of_match_table = mt8195_pinctrl_of_match,
-		.pm = &mtk_paris_pinctrl_pm_ops,
+		.pm = pm_sleep_ptr(&mtk_paris_pinctrl_pm_ops),
 	},
 	.probe = mtk_paris_pinctrl_probe,
 };
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8365.c b/drivers/pinctrl/mediatek/pinctrl-mt8365.c
index 1db04bbdb423..e3e0d66cfbbf 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8365.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8365.c
@@ -484,7 +484,7 @@ static struct platform_driver mtk_pinctrl_driver = {
 	.driver = {
 		.name = "mediatek-mt8365-pinctrl",
 		.of_match_table = mt8365_pctrl_match,
-		.pm = &mtk_eint_pm_ops,
+		.pm = pm_sleep_ptr(&mtk_eint_pm_ops),
 	},
 };
 
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8516.c b/drivers/pinctrl/mediatek/pinctrl-mt8516.c
index 950275c47122..abda75d4354e 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8516.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8516.c
@@ -334,7 +334,7 @@ static struct platform_driver mtk_pinctrl_driver = {
 	.driver = {
 		.name = "mediatek-mt8516-pinctrl",
 		.of_match_table = mt8516_pctrl_match,
-		.pm = &mtk_eint_pm_ops,
+		.pm = pm_sleep_ptr(&mtk_eint_pm_ops),
 	},
 };
 
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index e79d66a04194..66381e67a5e5 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -914,9 +914,8 @@ static int mtk_eint_resume(struct device *device)
 	return mtk_eint_do_resume(pctl->eint);
 }
 
-const struct dev_pm_ops mtk_eint_pm_ops = {
-	.suspend_noirq = mtk_eint_suspend,
-	.resume_noirq = mtk_eint_resume,
+EXPORT_GPL_DEV_PM_OPS(mtk_eint_pm_ops) = {
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(mtk_eint_suspend, mtk_eint_resume)
 };
 
 static int mtk_pctrl_build_state(struct platform_device *pdev)
diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c b/drivers/pinctrl/mediatek/pinctrl-paris.c
index 6392f1e05d02..780fdca6bc81 100644
--- a/drivers/pinctrl/mediatek/pinctrl-paris.c
+++ b/drivers/pinctrl/mediatek/pinctrl-paris.c
@@ -1131,9 +1131,8 @@ static int mtk_paris_pinctrl_resume(struct device *device)
 	return mtk_eint_do_resume(pctl->eint);
 }
 
-const struct dev_pm_ops mtk_paris_pinctrl_pm_ops = {
-	.suspend_noirq = mtk_paris_pinctrl_suspend,
-	.resume_noirq = mtk_paris_pinctrl_resume,
+EXPORT_GPL_DEV_PM_OPS(mtk_paris_pinctrl_pm_ops) = {
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(mtk_paris_pinctrl_suspend, mtk_paris_pinctrl_resume)
 };
 
 MODULE_LICENSE("GPL v2");
-- 
2.43.0.rc1.1.gbec44491f096

