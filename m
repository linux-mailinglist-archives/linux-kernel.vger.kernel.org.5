Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268C7808A53
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 15:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443363AbjLGOSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 09:18:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443263AbjLGOR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 09:17:27 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3191984;
        Thu,  7 Dec 2023 06:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701958641; x=1733494641;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WJ1rxXVXDzBVp2HN1Gt4y0DtNM1+XTEkCo3uuSfLvrk=;
  b=I/eSBbxgGETdQ7YEYuBm8JfrUrtyIGgXUyR3QKcS+VZwnLy1QfIs6vNB
   4K+uRiSt39NU/2YgGFeBFrokvBbwkiCWHvwxpHf/kEIkf3qhB5hrXBRUN
   MraGnxt3LpxpmFOXZSeXojprHRuK/f9K/iqI4+4qjsu+9WQTpEOCpJJMM
   zjRr+kTDfZguxZD5KbFs6tqt461tju/4es2Wv/WEQJfYcah+h+TvUEQgI
   BDnxNI/m9v+Rtk9sRkOyeNAxhZHV6G4o4lvzRJeB0foQqtjmnLQRuzoJp
   hB8ONVI7tRlclovwxK16/s5D29tZKR+zPwgSNuoDHEO2FQCzY102cc2GR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="460726202"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="460726202"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 06:17:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="889756102"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="889756102"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 07 Dec 2023 06:17:11 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6773CCC9; Thu,  7 Dec 2023 16:17:03 +0200 (EET)
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
Subject: [PATCH v5 20/24] i2c: designware: Propagate firmware node
Date:   Thu,  7 Dec 2023 16:14:00 +0200
Message-ID: <20231207141653.2785124-21-andriy.shevchenko@linux.intel.com>
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

Propagate firmware node by using a specific API call, i.e. device_set_node().

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
Tested-by: Serge Semin <fancer.lancer@gmail.com>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Link: https://lore.kernel.org/r/20231120144641.1660574-21-andriy.shevchenko@linux.intel.com
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/busses/i2c-designware-common.c  | 2 ++
 drivers/i2c/busses/i2c-designware-pcidrv.c  | 2 --
 drivers/i2c/busses/i2c-designware-platdrv.c | 3 ---
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
index 1d213bc0bbfa..45ced3354eef 100644
--- a/drivers/i2c/busses/i2c-designware-common.c
+++ b/drivers/i2c/busses/i2c-designware-common.c
@@ -716,6 +716,8 @@ EXPORT_SYMBOL_GPL(i2c_dw_disable);
 
 int i2c_dw_probe(struct dw_i2c_dev *dev)
 {
+	device_set_node(&dev->adapter.dev, dev_fwnode(dev->dev));
+
 	switch (dev->mode) {
 	case DW_IC_SLAVE:
 		return i2c_dw_probe_slave(dev);
diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
index df47ba04c9ee..2c7bc7dc8e44 100644
--- a/drivers/i2c/busses/i2c-designware-pcidrv.c
+++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
@@ -9,7 +9,6 @@
  * Copyright (C) 2009 Provigent Ltd.
  * Copyright (C) 2011, 2015, 2016 Intel Corporation.
  */
-#include <linux/acpi.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/errno.h>
@@ -273,7 +272,6 @@ static int i2c_dw_pci_probe(struct pci_dev *pdev,
 	adap = &dev->adapter;
 	adap->owner = THIS_MODULE;
 	adap->class = 0;
-	ACPI_COMPANION_SET(&adap->dev, ACPI_COMPANION(&pdev->dev));
 	adap->nr = controller->bus_num;
 
 	r = i2c_dw_probe(dev);
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index d9a64006a3d6..1b76f721bf81 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -8,7 +8,6 @@
  * Copyright (C) 2007 MontaVista Software Inc.
  * Copyright (C) 2009 Provigent Ltd.
  */
-#include <linux/acpi.h>
 #include <linux/clk-provider.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
@@ -305,8 +304,6 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	adap->owner = THIS_MODULE;
 	adap->class = dmi_check_system(dw_i2c_hwmon_class_dmi) ?
 					I2C_CLASS_HWMON : I2C_CLASS_DEPRECATED;
-	ACPI_COMPANION_SET(&adap->dev, ACPI_COMPANION(&pdev->dev));
-	adap->dev.of_node = pdev->dev.of_node;
 	adap->nr = -1;
 
 	if (dev->flags & ACCESS_NO_IRQ_SUSPEND) {
-- 
2.43.0.rc1.1.gbec44491f096

