Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23AA7779047
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 15:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236479AbjHKNG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 09:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235403AbjHKNGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 09:06:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F524497;
        Fri, 11 Aug 2023 06:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691759165; x=1723295165;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4Wpr+H06t2fMqc96D3gA9qTHa+iJJfudU7PaCZYhRrM=;
  b=PUesNx0rYr7q3Bt2Tr8hyCK7DN/52cIiO4zrY4Wm5j9GWReJFjnhGmy2
   mDUL0pSyUcoOaaGEMFM2Upuu5EFAA+DiNswJkjUhHSSWm3+cWu2y3CkCH
   TMquO4HS81Vvh44glde7syCAkdd4Iv8GYgZcB3ExSMUaA5gAU5bZY35cv
   dE2nx0p0VjcNodLi7qEG/6Bbd1KO4p6IRs0lsogVMZb4vex4g+G4qEbHu
   B3OXoRFA5keVHcQhVymi1nB300S53d7baftwvlKHiUdGIkwGE/5NmlFR/
   A4r76KfEn9+zv8jiwfBpUUrg93GXdzWIx5pN8p7SXxPkLXvuir0VzUeWh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="361812144"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="361812144"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 06:05:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="709535255"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="709535255"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.51.13])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 06:05:12 -0700
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
Subject: [PATCH 08/16] mmc: sdhci-of-arasan: Use sdhci_pltfm_remove()
Date:   Fri, 11 Aug 2023 16:03:43 +0300
Message-Id: <20230811130351.7038-9-adrian.hunter@intel.com>
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

Use sdhci_pltfm_remove() instead of sdhci_pltfm_unregister() because
sdhci_pltfm_unregister() is going to be removed.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 15025af326a2..5edd024347bd 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -2022,6 +2022,7 @@ static void sdhci_arasan_remove(struct platform_device *pdev)
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
 	struct clk *clk_ahb = sdhci_arasan->clk_ahb;
+	struct clk *clk_xin = pltfm_host->clk;
 
 	if (!IS_ERR(sdhci_arasan->phy)) {
 		if (sdhci_arasan->is_phy_on)
@@ -2031,8 +2032,9 @@ static void sdhci_arasan_remove(struct platform_device *pdev)
 
 	sdhci_arasan_unregister_sdclk(&pdev->dev);
 
-	sdhci_pltfm_unregister(pdev);
+	sdhci_pltfm_remove(pdev);
 
+	clk_disable_unprepare(clk_xin);
 	clk_disable_unprepare(clk_ahb);
 }
 
-- 
2.34.1

