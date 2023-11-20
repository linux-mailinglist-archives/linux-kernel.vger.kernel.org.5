Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2027F1623
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbjKTOrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:47:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233857AbjKTOrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:47:06 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8108CD5C;
        Mon, 20 Nov 2023 06:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700491618; x=1732027618;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8rCle8cWkE3/d7d+mu+uOd9fDb+OZ2qXOelghp6Npg8=;
  b=LgEc+I8njd85ZahsD+YPLGoMyfHZWeZEVstGHJmNF00dWFU/OPpYZtas
   4cJUHXkTOaJNF7k/pJb6/cAskvKv3OXY6/ke60bn451gDYwWZhkKM2yzB
   +Lae21TmwOOnV4GYvsG6I4JmNNqV6pondGlP2VyGOr9J08IZh+QRBCItn
   FKsMEa3ack8o0b7A5sOYpne2rsDPRjTqKJMu+2B8UHvxDYkB+uxV30ZCo
   QNgcLOE2oinPl7D0iV/8sFs2WqgdVO2HlIKJqwZILT0108EykWjA2R2sd
   9tbRJ0Th1Q/Rt5LvMHwDYDS8GUXzB4tO30vrTiB3ivD8tpnF5XQwhWmNE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="382017084"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="382017084"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 06:46:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="832291656"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="832291656"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 20 Nov 2023 06:46:54 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 31DB16C8; Mon, 20 Nov 2023 16:46:45 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jan Dabros <jsd@semihalf.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v4 21/24] i2c: designware: Use pci_get_drvdata()
Date:   Mon, 20 Nov 2023 16:42:03 +0200
Message-ID: <20231120144641.1660574-22-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20231120144641.1660574-1-andriy.shevchenko@linux.intel.com>
References: <20231120144641.1660574-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the wrapper function for getting the driver data using pci_dev
instead of using dev_get_drvdata() with &pdev->dev, so we can directly
pass a struct pci_dev. This is a purely cosmetic change.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/busses/i2c-designware-pcidrv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
index 2c7bc7dc8e44..211d8279b05e 100644
--- a/drivers/i2c/busses/i2c-designware-pcidrv.c
+++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
@@ -102,7 +102,7 @@ static u32 mfld_get_clk_rate_khz(struct dw_i2c_dev *dev)
 
 static int mfld_setup(struct pci_dev *pdev, struct dw_pci_controller *c)
 {
-	struct dw_i2c_dev *dev = dev_get_drvdata(&pdev->dev);
+	struct dw_i2c_dev *dev = pci_get_drvdata(pdev);
 
 	switch (pdev->device) {
 	case 0x0817:
@@ -152,7 +152,7 @@ static u32 navi_amd_get_clk_rate_khz(struct dw_i2c_dev *dev)
 
 static int navi_amd_setup(struct pci_dev *pdev, struct dw_pci_controller *c)
 {
-	struct dw_i2c_dev *dev = dev_get_drvdata(&pdev->dev);
+	struct dw_i2c_dev *dev = pci_get_drvdata(pdev);
 
 	dev->flags |= MODEL_AMD_NAVI_GPU;
 	dev->timings.bus_freq_hz = I2C_MAX_STANDARD_MODE_FREQ;
-- 
2.43.0.rc1.1.gbec44491f096

