Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117A0756A86
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 19:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbjGQRaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 13:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbjGQR3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 13:29:51 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92544171B;
        Mon, 17 Jul 2023 10:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689614965; x=1721150965;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G+AngK5QVe4Gm3zAHe5kaHFbmfMaO7Hp6mv7Fr5FR+E=;
  b=mphqTspQvNZ2Wo9YVLa1ercLgpX7hksdMKjRqe8Yh90GBuMzWVOzRqR5
   uDjY6A3eyN7itaWXSlFzfZhKopDgb0CExLE3v55Exo83n5igmGpe2iiGu
   tAgE5OHvdZbRFLbhNfup/KFLSNWruNldgExaayfgPFFsguL+RhuZs/RA+
   yqeGIaNBBvndkMb7o9mbHKyVpnx9GWu7Iv993zftIKHuT8GCzKPNbId09
   N2naplm5N1hSbgbNnquIL5evFNlmsvNknytBayxDTTwXmdXHbLmH6zhyL
   qa6Pxn7iM3D9LO/wcwo6qmw4y4kwzwCoW0pzkUlUiKpeII9qWYbFOkCqW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="350854507"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="350854507"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 10:28:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="813426657"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="813426657"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Jul 2023 10:28:33 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 023C6516; Mon, 17 Jul 2023 20:28:39 +0300 (EEST)
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
Subject: [PATCH v2 03/10] pinctrl: cherryview: Switch to use DEFINE_NOIRQ_DEV_PM_OPS() helper
Date:   Mon, 17 Jul 2023 20:28:14 +0300
Message-Id: <20230717172821.62827-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230717172821.62827-1-andriy.shevchenko@linux.intel.com>
References: <20230717172821.62827-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
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
 drivers/pinctrl/intel/pinctrl-cherryview.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-cherryview.c b/drivers/pinctrl/intel/pinctrl-cherryview.c
index eee0f9bc3d32..7a2fc9fe175d 100644
--- a/drivers/pinctrl/intel/pinctrl-cherryview.c
+++ b/drivers/pinctrl/intel/pinctrl-cherryview.c
@@ -1793,7 +1793,6 @@ static int chv_pinctrl_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int chv_pinctrl_suspend_noirq(struct device *dev)
 {
 	struct intel_pinctrl *pctrl = dev_get_drvdata(dev);
@@ -1877,12 +1876,8 @@ static int chv_pinctrl_resume_noirq(struct device *dev)
 
 	return 0;
 }
-#endif
 
-static const struct dev_pm_ops chv_pinctrl_pm_ops = {
-	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(chv_pinctrl_suspend_noirq,
-				      chv_pinctrl_resume_noirq)
-};
+static DEFINE_NOIRQ_DEV_PM_OPS(chv_pinctrl_pm_ops, chv_pinctrl_suspend_noirq, chv_pinctrl_resume_noirq);
 
 static const struct acpi_device_id chv_pinctrl_acpi_match[] = {
 	{ "INT33FF", (kernel_ulong_t)chv_soc_data },
@@ -1895,7 +1890,7 @@ static struct platform_driver chv_pinctrl_driver = {
 	.remove = chv_pinctrl_remove,
 	.driver = {
 		.name = "cherryview-pinctrl",
-		.pm = &chv_pinctrl_pm_ops,
+		.pm = pm_sleep_ptr(&chv_pinctrl_pm_ops),
 		.acpi_match_table = chv_pinctrl_acpi_match,
 	},
 };
-- 
2.40.0.1.gaa8946217a0b

