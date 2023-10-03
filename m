Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3F37B63F5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 10:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239375AbjJCIW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 04:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239372AbjJCIWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 04:22:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75BEAF;
        Tue,  3 Oct 2023 01:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696321372; x=1727857372;
  h=from:to:cc:subject:date:message-id;
  bh=CZDG8lgnwmj3tAR3Z3r1zjSPzOX1qNebxv8h+uGc48I=;
  b=Ejze0m9hbB36CkHs2yRnl1DQqNa3xSfVcwibOebTEiGf9ay43qBIy8Sf
   NbX7dOzZ65qKb4WtuF90J1wu5Qb2KSkrsz6WFjgokbIn9vXKLYzbWxXgt
   RNYVRw9fEoGqYNH8qWwr8p0uochiYHg86UjEMOgrDNxZRlQ3LnidQ756c
   BiUvPatvQtynoAs9addrmBAg7pU28tuExduk/u43+yFaGLEClYIjuSvDU
   52EHvysLOHW7oErl6WudE1Ft9GU9GkkrcFNGfDa9qeiJMXpMyg+y5vBED
   UAlAa3iF8YXu3Y86fRSXgweqGDPS5BemqeTzaIIQdflplChXDhMKJe+kz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="469095958"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="469095958"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 01:22:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="786021353"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="786021353"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by orsmga001.jf.intel.com with ESMTP; 03 Oct 2023 01:22:49 -0700
From:   Raag Jadav <raag.jadav@intel.com>
To:     rafael@kernel.org, len.brown@intel.com, linus.walleij@linaro.org,
        mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com
Cc:     linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1] ACPI: LPSS: drop BayTrail and Lynxpoint pinctrl HIDs
Date:   Tue,  3 Oct 2023 13:52:33 +0530
Message-Id: <20231003082233.30118-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Platform devices are now created by ACPI core on device enumeration
on acpi_bus_scan() -> acpi_bus_attach() path after commit 48459340b92b
("ACPI / scan: use platform bus type by default for _HID enumeration").
No need to create them from LPSS unless we explicitly need to set
acpi_lpss_pm_domain for them.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/acpi/acpi_lpss.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 539e700de4d2..d54cd42c1280 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -368,7 +368,6 @@ static const struct acpi_device_id acpi_lpss_device_ids[] = {
 	{ "INT33C4", LPSS_ADDR(lpt_uart_dev_desc) },
 	{ "INT33C5", LPSS_ADDR(lpt_uart_dev_desc) },
 	{ "INT33C6", LPSS_ADDR(lpt_sdio_dev_desc) },
-	{ "INT33C7", },
 
 	/* BayTrail LPSS devices */
 	{ "80860F09", LPSS_ADDR(byt_pwm_dev_desc) },
@@ -376,8 +375,6 @@ static const struct acpi_device_id acpi_lpss_device_ids[] = {
 	{ "80860F0E", LPSS_ADDR(byt_spi_dev_desc) },
 	{ "80860F14", LPSS_ADDR(byt_sdio_dev_desc) },
 	{ "80860F41", LPSS_ADDR(byt_i2c_dev_desc) },
-	{ "INT33B2", },
-	{ "INT33FC", },
 
 	/* Braswell LPSS devices */
 	{ "80862286", LPSS_ADDR(lpss_dma_desc) },
@@ -396,7 +393,6 @@ static const struct acpi_device_id acpi_lpss_device_ids[] = {
 	{ "INT3434", LPSS_ADDR(lpt_uart_dev_desc) },
 	{ "INT3435", LPSS_ADDR(lpt_uart_dev_desc) },
 	{ "INT3436", LPSS_ADDR(lpt_sdio_dev_desc) },
-	{ "INT3437", },
 
 	/* Wildcat Point LPSS devices */
 	{ "INT3438", LPSS_ADDR(lpt_spi_dev_desc) },
@@ -657,10 +653,9 @@ static int acpi_lpss_create_device(struct acpi_device *adev,
 	int ret;
 
 	dev_desc = (const struct lpss_device_desc *)id->driver_data;
-	if (!dev_desc) {
-		pdev = acpi_create_platform_device(adev, NULL);
-		return IS_ERR_OR_NULL(pdev) ? PTR_ERR(pdev) : 1;
-	}
+	if (!dev_desc)
+		return -EINVAL;
+
 	pdata = kzalloc(sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
 		return -ENOMEM;
-- 
2.17.1

