Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04037E9CE1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 14:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbjKMNQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 08:16:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbjKMNQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 08:16:20 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5FF1724;
        Mon, 13 Nov 2023 05:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699881377; x=1731417377;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=cVMB2JEbcvllLrApb7yUV501OiVQ89spuRHP1dIfQB0=;
  b=MHj9hizDydxhMqNLgi0oM0+3rCZP+2ddYOI83bNt52QA3M9PK+1IcC38
   2QOdpTIb+l7lPIPrJGNdtWz+QlzKrMy8yF6O7LBXd2kioUu3SvRwR6PlU
   1muyvej7YuVkmsSOaxH+SiekOPMP8sOaHV8T3jAAlP8sjcjcATLOqnc3b
   TM7AFSoGm/rMKIUeaFojxQqPhlglTqq2tA43RXCDO182VqOWq5mB9/JoX
   qJcjY3WxcNrvbpcHFeAl4nSX9lVmsaTD/3yqyeqpDOOoYdm2zGlPar2R8
   6Xng2+wDNxKO9Zx+T8jUkRP4QJcj2W97hTsVpu5bC2t1KBX4uuU7OEBXh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="454726910"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="454726910"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 05:16:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="5649403"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmviesa002.fm.intel.com with ESMTP; 13 Nov 2023 05:16:14 -0800
From:   Raag Jadav <raag.jadav@intel.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl,
        mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1 2/3] gpio: elkhartlake: reuse pm_ops from Intel Tangier driver
Date:   Mon, 13 Nov 2023 18:45:59 +0530
Message-Id: <20231113131600.10828-3-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231113131600.10828-1-raag.jadav@intel.com>
References: <20231113131600.10828-1-raag.jadav@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reuse tng_gpio_pm_ops from Intel Tangier driver instead of calling
them through a local copy.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/gpio/gpio-elkhartlake.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/gpio/gpio-elkhartlake.c b/drivers/gpio/gpio-elkhartlake.c
index a9c8b16215be..887c0fe99d39 100644
--- a/drivers/gpio/gpio-elkhartlake.c
+++ b/drivers/gpio/gpio-elkhartlake.c
@@ -55,18 +55,6 @@ static int ehl_gpio_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int ehl_gpio_suspend(struct device *dev)
-{
-	return tng_gpio_suspend(dev);
-}
-
-static int ehl_gpio_resume(struct device *dev)
-{
-	return tng_gpio_resume(dev);
-}
-
-static DEFINE_SIMPLE_DEV_PM_OPS(ehl_gpio_pm_ops, ehl_gpio_suspend, ehl_gpio_resume);
-
 static const struct platform_device_id ehl_gpio_ids[] = {
 	{ "gpio-elkhartlake" },
 	{ }
@@ -76,7 +64,7 @@ MODULE_DEVICE_TABLE(platform, ehl_gpio_ids);
 static struct platform_driver ehl_gpio_driver = {
 	.driver	= {
 		.name	= "gpio-elkhartlake",
-		.pm	= pm_sleep_ptr(&ehl_gpio_pm_ops),
+		.pm	= pm_sleep_ptr(&tng_gpio_pm_ops),
 	},
 	.probe		= ehl_gpio_probe,
 	.id_table	= ehl_gpio_ids,
-- 
2.17.1

