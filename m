Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D55756A6C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 19:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjGQR3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 13:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjGQR33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 13:29:29 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFBAE48;
        Mon, 17 Jul 2023 10:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689614948; x=1721150948;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+WE9l4V5dtMjJdCXNd232uoiygpPg04F9L0LRHChi5o=;
  b=jv6dZsgGNco3F3Nsmgw6MOSTqMaX60eMKEuTA14GPWgmtXSG1GWMZB1U
   dGOe0ScbrrRo1wukHhXvIUF2hLI0qRtZclc6juO0xRzM9rHtzcoUYBHmQ
   0FIfEKh77CnJPfs0StJa0Palmr80ZaqbWYMfc+8CMV28pVsJeUEdZzFqP
   hrARNIzutLmsWo/HINwDOwo5mUrxs0z1P2cvepzBP5AvM/fGk4x8MTBtp
   nGMIzDsLmg3CK5o7nzfymV4qlcrT2Cs1HvTKmQHv5JdGuwGFalOF+pXep
   COveNSBZXz0YmbwhRtSw32Rxk0RjS/nZrSkd9ujD9J/qz410YeHLAzkjA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="429752446"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="429752446"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 10:28:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="793320386"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="793320386"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 17 Jul 2023 10:28:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 447A2718; Mon, 17 Jul 2023 20:28:40 +0300 (EEST)
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
Subject: [PATCH v2 09/10] pinctrl: renesas: Switch to use DEFINE_NOIRQ_DEV_PM_OPS() helper
Date:   Mon, 17 Jul 2023 20:28:20 +0300
Message-Id: <20230717172821.62827-10-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230717172821.62827-1-andriy.shevchenko@linux.intel.com>
References: <20230717172821.62827-1-andriy.shevchenko@linux.intel.com>
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
 drivers/pinctrl/renesas/core.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/pinctrl/renesas/core.c b/drivers/pinctrl/renesas/core.c
index 0c8d081da6a8..34232b016960 100644
--- a/drivers/pinctrl/renesas/core.c
+++ b/drivers/pinctrl/renesas/core.c
@@ -649,7 +649,7 @@ static const struct of_device_id sh_pfc_of_table[] = {
 };
 #endif
 
-#if defined(CONFIG_PM_SLEEP) && defined(CONFIG_ARM_PSCI_FW)
+#if defined(CONFIG_ARM_PSCI_FW)
 static void sh_pfc_nop_reg(struct sh_pfc *pfc, u32 reg, unsigned int idx)
 {
 }
@@ -732,15 +732,13 @@ static int sh_pfc_resume_noirq(struct device *dev)
 		sh_pfc_walk_regs(pfc, sh_pfc_restore_reg);
 	return 0;
 }
-
-static const struct dev_pm_ops sh_pfc_pm  = {
-	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(sh_pfc_suspend_noirq, sh_pfc_resume_noirq)
-};
-#define DEV_PM_OPS	&sh_pfc_pm
 #else
 static int sh_pfc_suspend_init(struct sh_pfc *pfc) { return 0; }
-#define DEV_PM_OPS	NULL
-#endif /* CONFIG_PM_SLEEP && CONFIG_ARM_PSCI_FW */
+static int sh_pfc_suspend_noirq(struct device *dev) { return 0; }
+static int sh_pfc_resume_noirq(struct device *dev) { return 0; }
+#endif	/* CONFIG_ARM_PSCI_FW */
+
+static DEFINE_NOIRQ_DEV_PM_OPS(sh_pfc_pm, sh_pfc_suspend_noirq, sh_pfc_resume_noirq);
 
 #ifdef DEBUG
 #define SH_PFC_MAX_REGS		300
@@ -1418,7 +1416,7 @@ static struct platform_driver sh_pfc_driver = {
 	.driver		= {
 		.name	= DRV_NAME,
 		.of_match_table = of_match_ptr(sh_pfc_of_table),
-		.pm     = DEV_PM_OPS,
+		.pm	= pm_sleep_ptr(&sh_pfc_pm),
 	},
 };
 
-- 
2.40.0.1.gaa8946217a0b

