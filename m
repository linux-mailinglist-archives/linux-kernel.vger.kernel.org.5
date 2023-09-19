Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4257A6BE0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 21:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbjISTzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 15:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232969AbjISTzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 15:55:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F2A8F;
        Tue, 19 Sep 2023 12:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695153318; x=1726689318;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DFA50JlbPD1C+XZyUEPuNcXRs2n33eHh/bGli2cYqQ0=;
  b=aa9pFF2dnsFWYpQrP3GGbxGyFvW8sUhWk1tbLhSoVvtfCuPs41rGxREM
   Jh9X1IRHNJ4JrODBYC9+mQvJzv8NipD2p5OqDJXp5lJrc0JEuaSRayEpU
   ot88nzETS71jOA1Fe9AKbF2b42dGk0WxLHz+I2SqqVN/FnNxcgr4UPNY5
   5iOpZP9o3fGmqzfV1PBvLSSFIZM4atU+lx+ADHlyDrjrNUuN1GKY4kkfF
   0dD56Gv6MFPipnbRA89GKJLVULLlNU92xJw8Q7VO9OK9wWEGbBwPNH+eX
   xEROOs8jp98eqthUezlw8h3CviO0ts6toh3bXPDZr5Iz+Unoe3mC3r3cj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="383874583"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="383874583"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 12:55:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="746355061"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="746355061"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 19 Sep 2023 12:55:15 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6E09645B; Tue, 19 Sep 2023 22:55:14 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andi Shyti <andi.shyti@linux.intel.com>
Subject: [PATCH v1 1/1] serial: 8250_dw: Use devm_clk_get_optional_enabled()
Date:   Tue, 19 Sep 2023 22:55:13 +0300
Message-Id: <20230919195513.3197930-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_clk_get_optional_enabled() to simplify the code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dw.c | 27 +++------------------------
 1 file changed, 3 insertions(+), 24 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index f4cafca1a7da..bdd7ed282061 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -498,11 +498,6 @@ static void dw8250_quirks(struct uart_port *p, struct dw8250_data *data)
 	}
 }
 
-static void dw8250_clk_disable_unprepare(void *data)
-{
-	clk_disable_unprepare(data);
-}
-
 static void dw8250_reset_control_assert(void *data)
 {
 	reset_control_assert(data);
@@ -598,23 +593,15 @@ static int dw8250_probe(struct platform_device *pdev)
 	device_property_read_u32(dev, "clock-frequency", &p->uartclk);
 
 	/* If there is separate baudclk, get the rate from it. */
-	data->clk = devm_clk_get_optional(dev, "baudclk");
+	data->clk = devm_clk_get_optional_enabled(dev, "baudclk");
 	if (data->clk == NULL)
-		data->clk = devm_clk_get_optional(dev, NULL);
+		data->clk = devm_clk_get_optional_enabled(dev, NULL);
 	if (IS_ERR(data->clk))
 		return PTR_ERR(data->clk);
 
 	INIT_WORK(&data->clk_work, dw8250_clk_work_cb);
 	data->clk_notifier.notifier_call = dw8250_clk_notifier_cb;
 
-	err = clk_prepare_enable(data->clk);
-	if (err)
-		return dev_err_probe(dev, err, "could not enable optional baudclk\n");
-
-	err = devm_add_action_or_reset(dev, dw8250_clk_disable_unprepare, data->clk);
-	if (err)
-		return err;
-
 	if (data->clk)
 		p->uartclk = clk_get_rate(data->clk);
 
@@ -622,18 +609,10 @@ static int dw8250_probe(struct platform_device *pdev)
 	if (!p->uartclk)
 		return dev_err_probe(dev, -EINVAL, "clock rate not defined\n");
 
-	data->pclk = devm_clk_get_optional(dev, "apb_pclk");
+	data->pclk = devm_clk_get_optional_enabled(dev, "apb_pclk");
 	if (IS_ERR(data->pclk))
 		return PTR_ERR(data->pclk);
 
-	err = clk_prepare_enable(data->pclk);
-	if (err)
-		return dev_err_probe(dev, err, "could not enable apb_pclk\n");
-
-	err = devm_add_action_or_reset(dev, dw8250_clk_disable_unprepare, data->pclk);
-	if (err)
-		return err;
-
 	data->rst = devm_reset_control_get_optional_exclusive(dev, NULL);
 	if (IS_ERR(data->rst))
 		return PTR_ERR(data->rst);
-- 
2.40.0.1.gaa8946217a0b

