Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4867E8326
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 20:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344613AbjKJTv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:51:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236400AbjKJTvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:51:44 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD31F10CF58;
        Fri, 10 Nov 2023 10:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699640689; x=1731176689;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t7lpDMY5V8q2UqFLVQ4gPKw1ojL0XlQrxXHVcB/Bxww=;
  b=SwkxtQL8CFadVmHTI95ig1Lveo5bjqw67zdR9Q4gaj5q/iLYxMhRqX0F
   iwaD9GC0cpSsVaTPY1LIUnvBi/RgwR7jPbCTfqyMOYXPxqaNr+R86Y7eJ
   VcOB89u9aKUnJTn2s8jDnXLWv3/XS+6oQtWmZOTn/9NYOZT8XuxPGb5bX
   vQ6m+h3pXJ9s2q+/SL0BiEyJ9s/wvsT9hjqKR120z9LLUOs1151RN5CjP
   P++2WUKnnDYa0w4KdcVWZyJBxs0hDEXE0dJT/VSH+JCKtI+h2KqaoNRly
   y9/AaAqihEnYP7Wl0eq4hiZgdxaZXujd/IcveAqWDPozc3QCDX1eDpRNH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="375251928"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="375251928"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 10:23:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="798663749"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="798663749"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 10 Nov 2023 10:23:12 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C9A58835; Fri, 10 Nov 2023 20:23:07 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jan Dabros <jsd@semihalf.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 10/25] i2c: designware: Unify terminator in device ID tables
Date:   Fri, 10 Nov 2023 20:11:30 +0200
Message-ID: <20231110182304.3894319-11-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20231110182304.3894319-1-andriy.shevchenko@linux.intel.com>
References: <20231110182304.3894319-1-andriy.shevchenko@linux.intel.com>
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

Make the terminator entry look the same in all device ID tables.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/busses/i2c-designware-pcidrv.c  | 2 +-
 drivers/i2c/busses/i2c-designware-platdrv.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
index db642e0aa61f..7f04dc33e6f7 100644
--- a/drivers/i2c/busses/i2c-designware-pcidrv.c
+++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
@@ -402,7 +402,7 @@ static const struct pci_device_id i2c_designware_pci_ids[] = {
 	{ PCI_VDEVICE(ATI,  0x73c4), navi_amd },
 	{ PCI_VDEVICE(ATI,  0x7444), navi_amd },
 	{ PCI_VDEVICE(ATI,  0x7464), navi_amd },
-	{ 0,}
+	{}
 };
 MODULE_DEVICE_TABLE(pci, i2c_designware_pci_ids);
 
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 5d8427ccc9b4..018c353a456a 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -57,7 +57,7 @@ static const struct acpi_device_id dw_i2c_acpi_match[] = {
 	{ "HISI02A2", 0 },
 	{ "HISI02A3", 0 },
 	{ "HYGO0010", ACCESS_INTR_MASK },
-	{ }
+	{}
 };
 MODULE_DEVICE_TABLE(acpi, dw_i2c_acpi_match);
 #endif
@@ -153,7 +153,7 @@ static const struct of_device_id dw_i2c_of_match[] = {
 	{ .compatible = "snps,designware-i2c", },
 	{ .compatible = "mscc,ocelot-i2c", .data = (void *)MODEL_MSCC_OCELOT },
 	{ .compatible = "baikal,bt1-sys-i2c", .data = (void *)MODEL_BAIKAL_BT1 },
-	{},
+	{}
 };
 MODULE_DEVICE_TABLE(of, dw_i2c_of_match);
 #else
-- 
2.43.0.rc1.1.gbec44491f096

