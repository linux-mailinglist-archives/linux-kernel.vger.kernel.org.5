Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915CC756A72
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 19:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjGQR3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 13:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbjGQR3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 13:29:31 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA86E55;
        Mon, 17 Jul 2023 10:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689614949; x=1721150949;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0/SbCMKprSAfQ28hQngw9HD0K6kiWmLO1+VHlEipr8A=;
  b=NUzdG726O6hieiU68km/gA2xM1nOWjiZFhPs6yoGSdsZcMXF4MHy1yhr
   XGcszn0BvDqw57/DqPRdv6ObC+O9lodjmW8xKfy8hOAYs2/kg3C6tdDyT
   IXjWOMUajR4iH6DskqP3iyqLVNmjcYFAVimTugGvh0lI3PpQooKacq/EF
   tflsz65ZkaZMS20UnS2ghkRDxlY5GWZHcVRZujDLXVnZOUBAdJg4rC2Pl
   vrpIPGzkBS41BNSpUlBVLRUj3QsSKMqBmgcNPlRRalh0YtdCBLQ9xvoCF
   cwWDuqCNV/Z2O0lAAWXe/Iwqg41LmLcr0c8rPMJKNzXiUIWg8LEo4snLi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="355926961"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="355926961"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 10:28:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="673604209"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="673604209"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 17 Jul 2023 10:28:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 17FD1604; Mon, 17 Jul 2023 20:28:40 +0300 (EEST)
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
Subject: [PATCH v2 05/10] pinctrl: lynxpoint: Make use of pm_ptr()
Date:   Mon, 17 Jul 2023 20:28:16 +0300
Message-Id: <20230717172821.62827-6-andriy.shevchenko@linux.intel.com>
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

Cleaning up the driver to use pm_ptr() and *_PM_OPS() macros that
make it simpler and allows the compiler to remove those functions
if built without CONFIG_PM and CONFIG_PM_SLEEP support.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-lynxpoint.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-lynxpoint.c b/drivers/pinctrl/intel/pinctrl-lynxpoint.c
index cdace55aaeac..50d92bf80e20 100644
--- a/drivers/pinctrl/intel/pinctrl-lynxpoint.c
+++ b/drivers/pinctrl/intel/pinctrl-lynxpoint.c
@@ -948,9 +948,8 @@ static int lp_gpio_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops lp_gpio_pm_ops = {
-	.runtime_suspend = lp_gpio_runtime_suspend,
-	.runtime_resume = lp_gpio_runtime_resume,
-	.resume = lp_gpio_resume,
+	SYSTEM_SLEEP_PM_OPS(NULL, lp_gpio_resume)
+	RUNTIME_PM_OPS(lp_gpio_runtime_suspend, lp_gpio_runtime_resume, NULL)
 };
 
 static const struct acpi_device_id lynxpoint_gpio_acpi_match[] = {
@@ -965,7 +964,7 @@ static struct platform_driver lp_gpio_driver = {
 	.remove         = lp_gpio_remove,
 	.driver         = {
 		.name   = "lp_gpio",
-		.pm	= &lp_gpio_pm_ops,
+		.pm	= pm_ptr(&lp_gpio_pm_ops),
 		.acpi_match_table = lynxpoint_gpio_acpi_match,
 	},
 };
-- 
2.40.0.1.gaa8946217a0b

