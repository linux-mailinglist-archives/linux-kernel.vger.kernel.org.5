Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053C7756A85
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 19:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbjGQR37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 13:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbjGQR3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 13:29:51 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5BD171A;
        Mon, 17 Jul 2023 10:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689614965; x=1721150965;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=igrPqVNDiG+d18EW9HPDbcv/hLv1Vv/Njn91XssjJ2c=;
  b=H15w2/DWOiuPX++WaDRYPn47gSeX2+2rjKc55ej15uLxZJAc7fLtZmfr
   ak/UppvwYRl3LOr/epx5EH0nzDVXEU7AZYdUUdFfiQppvyj4pChe9m4XI
   sh1R7K+a6HLL0l08+Aga9EkDgnSDhdRtSRbgzSp4gc6tA542tG3By2CTE
   7WQXGoxDkz1/kl34f8MGqB25Jg/bUySHYh7VM3KFA31wqgQ65cWBzFxvk
   P4X+AmdCqOpzvpsmPhv5XDTAFwyPT5NpUImw6l59JaoR/5CRi9kq58SJ/
   qWChHZ7eXeoGcXNX4IJgPFw13AWIL1Bow3PM3bMSSIMsZI+PvPTie8wEM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="355926981"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="355926981"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 10:28:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="673604211"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="673604211"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 17 Jul 2023 10:28:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2D1F469F; Mon, 17 Jul 2023 20:28:40 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Balsam CHIHI <bchihi@baylibre.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Sean Wang <sean.wang@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH v2 07/10] pinctrl: mediatek: Switch to use DEFINE_NOIRQ_DEV_PM_OPS() helper
Date:   Mon, 17 Jul 2023 20:28:18 +0300
Message-Id: <20230717172821.62827-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230717172821.62827-1-andriy.shevchenko@linux.intel.com>
References: <20230717172821.62827-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since pm.h provides a helper for system no-IRQ PM callbacks,
switch the driver to use it instead of open coded variant.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 5 +----
 drivers/pinctrl/mediatek/pinctrl-paris.c      | 9 +++------
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index 665dec419e7c..2bf5082d3aa9 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -922,10 +922,7 @@ static int mtk_eint_resume(struct device *device)
 	return mtk_eint_do_resume(pctl->eint);
 }
 
-const struct dev_pm_ops mtk_eint_pm_ops = {
-	.suspend_noirq = mtk_eint_suspend,
-	.resume_noirq = mtk_eint_resume,
-};
+DEFINE_NOIRQ_DEV_PM_OPS(mtk_eint_pm_ops, mtk_eint_suspend, mtk_eint_resume);
 
 static int mtk_pctrl_build_state(struct platform_device *pdev)
 {
diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c b/drivers/pinctrl/mediatek/pinctrl-paris.c
index 33d6c3fb7908..b1cbd5bafa2e 100644
--- a/drivers/pinctrl/mediatek/pinctrl-paris.c
+++ b/drivers/pinctrl/mediatek/pinctrl-paris.c
@@ -1119,24 +1119,21 @@ int mtk_paris_pinctrl_probe(struct platform_device *pdev)
 }
 EXPORT_SYMBOL_GPL(mtk_paris_pinctrl_probe);
 
-static int mtk_paris_pinctrl_suspend(struct device *device)
+static int mtk_paris_suspend(struct device *device)
 {
 	struct mtk_pinctrl *pctl = dev_get_drvdata(device);
 
 	return mtk_eint_do_suspend(pctl->eint);
 }
 
-static int mtk_paris_pinctrl_resume(struct device *device)
+static int mtk_paris_resume(struct device *device)
 {
 	struct mtk_pinctrl *pctl = dev_get_drvdata(device);
 
 	return mtk_eint_do_resume(pctl->eint);
 }
 
-const struct dev_pm_ops mtk_paris_pinctrl_pm_ops = {
-	.suspend_noirq = mtk_paris_pinctrl_suspend,
-	.resume_noirq = mtk_paris_pinctrl_resume,
-};
+DEFINE_NOIRQ_DEV_PM_OPS(mtk_paris_pinctrl_pm_ops, mtk_paris_suspend, mtk_paris_resume);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("MediaTek Pinctrl Common Driver V2 Paris");
-- 
2.40.0.1.gaa8946217a0b

