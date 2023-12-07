Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3757808A1D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 15:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443246AbjLGORZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 09:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443174AbjLGORG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 09:17:06 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9920A10DC;
        Thu,  7 Dec 2023 06:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701958631; x=1733494631;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AeyrvLyVIbJMMr8GvR6wVfdfP/hfJvA+/Lw69Ew1POU=;
  b=V/aSUf+AmuslQw9/hehzHn50aSU0eCsgXwMaI3+Tu2yjDBm7g1Y8GFTO
   nSbUoRSxf5LPfNzLrqWxwhyyjxPHSr+AQuLNiRjsMXwfc8Pn1u19j/+D9
   P+WL99PVBYB74y5AVI21IWqXl4QS7QVF3RHpzBSgDSGzd7duO2aojGVM3
   SEvNFvixrx3XDMFY0v651K1BgZOmGcaIGPm0FqLiBq51jQVWcJe4OCJyB
   UTjbm72C33cVNYfWUOsN2CpIA5k+psCa5vpQroX28SEwAzL9kxCqitirt
   ysmqVFqS02VKACh+ZF1qZeSKARCyf/vJ3XOnas+zT9XAqT3jVqFtDKfZD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="460726103"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="460726103"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 06:17:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="889756077"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="889756077"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 07 Dec 2023 06:17:07 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D9391892; Thu,  7 Dec 2023 16:17:02 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jan Dabros <jsd@semihalf.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH v5 08/24] i2c: designware: Replace MODULE_ALIAS() with MODULE_DEVICE_TABLE()
Date:   Thu,  7 Dec 2023 16:13:48 +0200
Message-ID: <20231207141653.2785124-9-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20231207141653.2785124-1-andriy.shevchenko@linux.intel.com>
References: <20231207141653.2785124-1-andriy.shevchenko@linux.intel.com>
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

As Krzysztof Kozlowski pointed out the better is to use
MODULE_DEVICE_TABLE() as it will be consistent with the content
of the real ID table of the platform devices.

While at it, drop unneeded and unused module alias in PCI glue
driver as PCI already has its own ID table and automatic loading
should just work.

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Tested-by: Serge Semin <fancer.lancer@gmail.com>
Link: https://lore.kernel.org/r/20231120144641.1660574-9-andriy.shevchenko@linux.intel.com
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/busses/i2c-designware-pcidrv.c  | 2 --
 drivers/i2c/busses/i2c-designware-platdrv.c | 8 ++++++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
index ed2f9e7ba5d3..35eba432bd08 100644
--- a/drivers/i2c/busses/i2c-designware-pcidrv.c
+++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
@@ -416,8 +416,6 @@ static struct pci_driver dw_i2c_driver = {
 };
 module_pci_driver(dw_i2c_driver);
 
-/* Work with hotplug and coldplug */
-MODULE_ALIAS("i2c_designware-pci");
 MODULE_AUTHOR("Baruch Siach <baruch@tkos.co.il>");
 MODULE_DESCRIPTION("Synopsys DesignWare PCI I2C bus adapter");
 MODULE_LICENSE("GPL");
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 4b5e58e1ce5b..5d8427ccc9b4 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -486,8 +486,11 @@ static const struct dev_pm_ops dw_i2c_dev_pm_ops = {
 	RUNTIME_PM_OPS(dw_i2c_plat_runtime_suspend, dw_i2c_plat_runtime_resume, NULL)
 };
 
-/* Work with hotplug and coldplug */
-MODULE_ALIAS("platform:i2c_designware");
+static const struct platform_device_id dw_i2c_platform_ids[] = {
+	{ "i2c_designware" },
+	{}
+};
+MODULE_DEVICE_TABLE(platform, dw_i2c_platform_ids);
 
 static struct platform_driver dw_i2c_driver = {
 	.probe = dw_i2c_plat_probe,
@@ -498,6 +501,7 @@ static struct platform_driver dw_i2c_driver = {
 		.acpi_match_table = ACPI_PTR(dw_i2c_acpi_match),
 		.pm	= pm_ptr(&dw_i2c_dev_pm_ops),
 	},
+	.id_table = dw_i2c_platform_ids,
 };
 
 static int __init dw_i2c_init_driver(void)
-- 
2.43.0.rc1.1.gbec44491f096

