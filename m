Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0DA6808A16
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 15:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443195AbjLGORO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 09:17:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443163AbjLGORD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 09:17:03 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A21810E3;
        Thu,  7 Dec 2023 06:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701958629; x=1733494629;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q38yLLuUJH4FuWZg9mrUTuIVLb3sq2MM35t95SeLH1M=;
  b=JnuG5nlntXngNT+GJyGcA/e1gIucOyVFekM455KfsmqqAuQezUhfAWd8
   JapPOORBdPaDwO0dwK2IAvsQcS4WnsAkHph6U6O6nxsklVEbCxV89wTEY
   GfN4qQ1DPSjYC/yLZx+gorT2Lu/0dYmxvxqIICvLQWFeF0TAA8NLiATGn
   3OS5DNe8EtSabiJs0ACeL2cmRgxogufTrMLuawLZ/AmnGqerVwDsKJ6HD
   y2/+VoqrjJvDMwbHEAMLt5m3M3cHGgx6sXJFJNT2Ct5fJYIVbFXCJUChs
   /pnoeIPuzWv3SWOHAi5aWrzLcOR1mlsmuJnZ/IKCkDcrqIW+GdzN3JOBF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="460726066"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="460726066"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 06:17:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="862490629"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="862490629"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Dec 2023 06:17:03 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8EC66648; Thu,  7 Dec 2023 16:17:02 +0200 (EET)
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
Subject: [PATCH v5 02/24] i2c: designware: Fix reset call order in dw_i2c_plat_probe()
Date:   Thu,  7 Dec 2023 16:13:42 +0200
Message-ID: <20231207141653.2785124-3-andriy.shevchenko@linux.intel.com>
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

We should not mix managed calls with non-managed. This will break
the calls order at the error path and ->remove() stages. Fix this
by wrapping reset control to become managed one.

With that start checking the rerurn code from reset_control_deassert()
as it may fail and calling assertion in that scenario is not always
a good idea.

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
Tested-by: Serge Semin <fancer.lancer@gmail.com>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Link: https://lore.kernel.org/r/20231120144641.1660574-3-andriy.shevchenko@linux.intel.com
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 62 +++++++++++----------
 1 file changed, 34 insertions(+), 28 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index fd3cd65f9c88..648fb84e574d 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -285,6 +285,28 @@ static void i2c_dw_remove_lock_support(struct dw_i2c_dev *dev)
 		i2c_dw_semaphore_cb_table[dev->semaphore_idx].remove(dev);
 }
 
+static void dw_i2c_plat_assert_reset(void *data)
+{
+	struct dw_i2c_dev *dev = data;
+
+	reset_control_assert(dev->rst);
+}
+
+static int dw_i2c_plat_get_reset(struct dw_i2c_dev *dev)
+{
+	int ret;
+
+	dev->rst = devm_reset_control_get_optional_exclusive(dev->dev, NULL);
+	if (IS_ERR(dev->rst))
+		return PTR_ERR(dev->rst);
+
+	ret = reset_control_deassert(dev->rst);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(dev->dev, dw_i2c_plat_assert_reset, dev);
+}
+
 static int dw_i2c_plat_probe(struct platform_device *pdev)
 {
 	struct i2c_adapter *adap;
@@ -312,11 +334,9 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	dev->rst = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
-	if (IS_ERR(dev->rst))
-		return PTR_ERR(dev->rst);
-
-	reset_control_deassert(dev->rst);
+	ret = dw_i2c_plat_get_reset(dev);
+	if (ret)
+		return ret;
 
 	t = &dev->timings;
 	i2c_parse_fw_timings(&pdev->dev, t, false);
@@ -331,30 +351,26 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 
 	ret = i2c_dw_validate_speed(dev);
 	if (ret)
-		goto exit_reset;
+		return ret;
 
 	ret = i2c_dw_probe_lock_support(dev);
 	if (ret)
-		goto exit_reset;
+		return ret;
 
 	i2c_dw_configure(dev);
 
 	/* Optional interface clock */
 	dev->pclk = devm_clk_get_optional(&pdev->dev, "pclk");
-	if (IS_ERR(dev->pclk)) {
-		ret = PTR_ERR(dev->pclk);
-		goto exit_reset;
-	}
+	if (IS_ERR(dev->pclk))
+		return PTR_ERR(dev->pclk);
 
 	dev->clk = devm_clk_get_optional(&pdev->dev, NULL);
-	if (IS_ERR(dev->clk)) {
-		ret = PTR_ERR(dev->clk);
-		goto exit_reset;
-	}
+	if (IS_ERR(dev->clk))
+		return PTR_ERR(dev->clk);
 
 	ret = i2c_dw_prepare_clk(dev, true);
 	if (ret)
-		goto exit_reset;
+		return ret;
 
 	if (dev->clk) {
 		u64 clk_khz;
@@ -395,17 +411,9 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 
 	ret = dw_i2c_plat_pm_setup(dev);
 	if (ret)
-		goto exit_reset;
+		return ret;
 
-	ret = i2c_dw_probe(dev);
-	if (ret)
-		goto exit_reset;
-
-	return ret;
-
-exit_reset:
-	reset_control_assert(dev->rst);
-	return ret;
+	return i2c_dw_probe(dev);
 }
 
 static void dw_i2c_plat_remove(struct platform_device *pdev)
@@ -422,8 +430,6 @@ static void dw_i2c_plat_remove(struct platform_device *pdev)
 	pm_runtime_put_sync(&pdev->dev);
 
 	i2c_dw_remove_lock_support(dev);
-
-	reset_control_assert(dev->rst);
 }
 
 static int dw_i2c_plat_prepare(struct device *dev)
-- 
2.43.0.rc1.1.gbec44491f096

