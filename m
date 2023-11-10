Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D217E821E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 20:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344252AbjKJTBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:01:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235960AbjKJTAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:00:53 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6028E1DF61;
        Fri, 10 Nov 2023 10:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699640658; x=1731176658;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XYkHs7aZvf3egWebqSD+gvG236t4GW5jLlJ3MZImh9A=;
  b=it9/+yVVYyBy/PrYEI2uQKo5R9TLjBAICtpovst4vTXyT2SEgJsqTqV2
   dskota8ZhMFJrzuBTVqoccEQaRrfxe3F01Lf3WjXCjFkTpgf5HiOyiPNN
   QVwVhMZ1/B/A4R6ryfSCpmZSJ1YyBoQ2tyoYiI4r52klyNdpTcyHVSRGX
   ciWxyIET6cRb9c5Uikwga2dCCTMC2IU4ar89zPMOnjYmxZ+0lFDKx2c/W
   qr4YD2iHR7eU8hvLjho/jJOB3eMv1/mTTbpBbF28aXe9ByB8Z1NVLR35Y
   sl/q3ui/x/8GcMVSJNJOu+L/PeS4hRtVomeAGQSOTBVvA/bjPaKOghinV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="375251887"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="375251887"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 10:23:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="798663739"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="798663739"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 10 Nov 2023 10:23:08 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 57E4414F; Fri, 10 Nov 2023 20:23:07 +0200 (EET)
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
Subject: [PATCH v3 01/25] i2c: designware: Delete adapter before disabling in i2c_dw_pci_remove()
Date:   Fri, 10 Nov 2023 20:11:21 +0200
Message-ID: <20231110182304.3894319-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20231110182304.3894319-1-andriy.shevchenko@linux.intel.com>
References: <20231110182304.3894319-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Make i2c_dw_pci_remove() to be aligned with dw_i2c_plat_remove() on
the sequence of the ceasing I²C operations.

Fixes: 18dbdda89f5c ("i2c-designware: Add runtime power management support")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/busses/i2c-designware-pcidrv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
index 61d7a27aa070..35d35d7c8e23 100644
--- a/drivers/i2c/busses/i2c-designware-pcidrv.c
+++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
@@ -354,11 +354,13 @@ static void i2c_dw_pci_remove(struct pci_dev *pdev)
 {
 	struct dw_i2c_dev *dev = pci_get_drvdata(pdev);
 
+	i2c_del_adapter(&dev->adapter);
+
 	dev->disable(dev);
+
 	pm_runtime_forbid(&pdev->dev);
 	pm_runtime_get_noresume(&pdev->dev);
 
-	i2c_del_adapter(&dev->adapter);
 	devm_free_irq(&pdev->dev, dev->irq, dev);
 	pci_free_irq_vectors(pdev);
 }
-- 
2.43.0.rc1.1.gbec44491f096

