Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A650779052
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 15:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbjHKNHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 09:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236335AbjHKNHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 09:07:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43894202;
        Fri, 11 Aug 2023 06:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691759221; x=1723295221;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cELYaecOpOxwmlY9lj9HXHEoAv/KTQp9fFm7cY/4i5Y=;
  b=FeY+hahdjiL6EDuqj1XtV0InCN98yjkZjRTDdwXgYRwfHwQTzDXer+sy
   IgCZYr08U3RyIajKbKuo7zsW6nyrh1NrkV6YlpZY3rdkir6zFlzl9SHZ6
   N6zfPzw3ZqepUCMCe4qZ64snArdXjsTjOhwL/tYran6OWrec2f0W5R/vw
   wyBx6eBxTaLJBzSdql5ki3GolPTrOKE2D3acnrfZrZP+SDM0q55bFG8ZO
   Imc07DSjSr5vx+vcvmpGd9Z1Ix753MZt7zJHnXFv2gaZOpjd3CLTBDPdX
   ytPQ4o5um4pBNch+41QNbDhlxWjvle2mmUrQzwYHZLf1LKssvL8jkmHQC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="361812743"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="361812743"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 06:06:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="709535330"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="709535330"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.51.13])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 06:05:57 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Yangtao Li <frank.li@vivo.com>
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Kamal Dasu <kamal.dasu@broadcom.com>,
        Al Cooper <alcooperx@gmail.com>,
        Michal Simek <michal.simek@amd.com>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Brian Norris <briannorris@chromium.org>,
        Ye Xingchen <ye.xingchen@zte.com.cn>,
        Brad Larson <blarson@amd.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
        Swati Agarwal <swati.agarwal@amd.com>,
        Andy Tang <andy.tang@nxp.com>,
        Georgii Kruglov <georgy.kruglov@yandex.ru>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Doug Brown <doug@schmorgal.com>,
        Li Zetao <lizetao1@huawei.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 13/16] mmc: sdhci-pxav2: Use sdhci_pltfm_remove()
Date:   Fri, 11 Aug 2023 16:03:48 +0300
Message-Id: <20230811130351.7038-14-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230811130351.7038-1-adrian.hunter@intel.com>
References: <20230811130351.7038-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use sdhci_pltfm_remove() instead of sdhci_pltfm_unregister() so that
devm_clk_get_enabled() can be used for pltfm_host->clk.

This has the side effect that the order of operations on the error path
and remove path is not the same as it was before, but should be safe
nevertheless.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pxav2.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
index a0c8470e9214..b75cbea88b40 100644
--- a/drivers/mmc/host/sdhci-pxav2.c
+++ b/drivers/mmc/host/sdhci-pxav2.c
@@ -268,26 +268,21 @@ static int sdhci_pxav2_probe(struct platform_device *pdev)
 	pltfm_host = sdhci_priv(host);
 	pxav2_host = sdhci_pltfm_priv(pltfm_host);
 
-	clk = devm_clk_get(dev, "io");
-	if (IS_ERR(clk) && PTR_ERR(clk) != -EPROBE_DEFER)
-		clk = devm_clk_get(dev, NULL);
+	clk = devm_clk_get_optional_enabled(dev, "io");
+	if (!clk)
+		clk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(clk)) {
 		ret = PTR_ERR(clk);
 		dev_err_probe(dev, ret, "failed to get io clock\n");
 		goto free;
 	}
 	pltfm_host->clk = clk;
-	ret = clk_prepare_enable(clk);
-	if (ret) {
-		dev_err(dev, "failed to enable io clock\n");
-		goto free;
-	}
 
 	clk_core = devm_clk_get_optional_enabled(dev, "core");
 	if (IS_ERR(clk_core)) {
 		ret = PTR_ERR(clk_core);
 		dev_err_probe(dev, ret, "failed to enable core clock\n");
-		goto disable_clk;
+		goto free;
 	}
 
 	host->quirks = SDHCI_QUIRK_BROKEN_ADMA
@@ -339,12 +334,10 @@ static int sdhci_pxav2_probe(struct platform_device *pdev)
 
 	ret = sdhci_add_host(host);
 	if (ret)
-		goto disable_clk;
+		goto free;
 
 	return 0;
 
-disable_clk:
-	clk_disable_unprepare(clk);
 free:
 	sdhci_pltfm_free(pdev);
 	return ret;
@@ -358,7 +351,7 @@ static struct platform_driver sdhci_pxav2_driver = {
 		.pm	= &sdhci_pltfm_pmops,
 	},
 	.probe		= sdhci_pxav2_probe,
-	.remove_new	= sdhci_pltfm_unregister,
+	.remove_new	= sdhci_pltfm_remove,
 };
 
 module_platform_driver(sdhci_pxav2_driver);
-- 
2.34.1

