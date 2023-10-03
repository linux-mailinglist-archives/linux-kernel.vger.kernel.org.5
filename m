Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4B47B6BA9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 16:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240160AbjJCOcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 10:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240153AbjJCOcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:32:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5F5D8;
        Tue,  3 Oct 2023 07:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696343517; x=1727879517;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MrutWpDigz5A/IURa0udL0kvZh91MzC6na2F+b9d5E8=;
  b=Y/raqYmaQlaaMAArtlRzh9m3U9v3Th8/w9Tqd9MFycVi8/0p+OUSHKNb
   hUYfXaJXrd8Hh6LMFDB8KKZ4Rw4c3QBGuvzPgw6TcaJ3vfsSA0QsLtCDs
   bOVFGQqsMG6jSVik6RhBHvGDhtyl7a+a34jb+kwd05NQbjVGOtCpR9pgB
   cfwvlywA+6UV3svVVldEaRTSYkEv92QvlvaJ+gSlwcwDxl6GoDiDzSH3y
   SxTMifu1D3WTGD2KLnRmPWyC87NyG4TdqEjBAkzuD21zpcLRH/7Z/W95E
   V7SK4xQuqtlZ55/IOHJOyuMaVOLo2TrhNd4CZYExHryBRfcNtSPP1axmW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="447051990"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="447051990"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 07:12:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="821269137"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="821269137"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 03 Oct 2023 07:12:45 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7882D18A0; Tue,  3 Oct 2023 17:12:44 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 1/1] serial: 8250_bcm7271: Use devm_clk_get_optional_enabled()
Date:   Tue,  3 Oct 2023 17:12:41 +0300
Message-Id: <20231003141241.3071687-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_clk_get_optional_enabled() to simplify the code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_bcm7271.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_bcm7271.c b/drivers/tty/serial/8250/8250_bcm7271.c
index 1a853a08654a..e6d1688feeb4 100644
--- a/drivers/tty/serial/8250/8250_bcm7271.c
+++ b/drivers/tty/serial/8250/8250_bcm7271.c
@@ -1015,26 +1015,22 @@ static int brcmuart_probe(struct platform_device *pdev)
 	of_property_read_u32(np, "clock-frequency", &clk_rate);
 
 	/* See if a Baud clock has been specified */
-	baud_mux_clk = devm_clk_get(dev, "sw_baud");
-	if (IS_ERR(baud_mux_clk)) {
-		if (PTR_ERR(baud_mux_clk) == -EPROBE_DEFER) {
-			ret = -EPROBE_DEFER;
-			goto release_dma;
-		}
-		dev_dbg(dev, "BAUD MUX clock not specified\n");
-	} else {
+	baud_mux_clk = devm_clk_get_optional_enabled(dev, "sw_baud");
+	if (IS_ERR(baud_mux_clk))
+		goto release_dma;
+	if (baud_mux_clk) {
 		dev_dbg(dev, "BAUD MUX clock found\n");
-		ret = clk_prepare_enable(baud_mux_clk);
-		if (ret)
-			goto release_dma;
+
 		priv->baud_mux_clk = baud_mux_clk;
 		init_real_clk_rates(dev, priv);
 		clk_rate = priv->default_mux_rate;
+	} else {
+		dev_dbg(dev, "BAUD MUX clock not specified\n");
 	}
 
 	if (clk_rate == 0) {
 		ret = dev_err_probe(dev, -EINVAL, "clock-frequency or clk not defined\n");
-		goto err_clk_disable;
+		goto release_dma;
 	}
 
 	dev_dbg(dev, "DMA is %senabled\n", priv->dma_enabled ? "" : "not ");
@@ -1118,8 +1114,6 @@ static int brcmuart_probe(struct platform_device *pdev)
 	serial8250_unregister_port(priv->line);
 err:
 	brcmuart_free_bufs(dev, priv);
-err_clk_disable:
-	clk_disable_unprepare(baud_mux_clk);
 release_dma:
 	if (priv->dma_enabled)
 		brcmuart_arbitration(priv, 0);
@@ -1134,7 +1128,6 @@ static int brcmuart_remove(struct platform_device *pdev)
 	hrtimer_cancel(&priv->hrt);
 	serial8250_unregister_port(priv->line);
 	brcmuart_free_bufs(&pdev->dev, priv);
-	clk_disable_unprepare(priv->baud_mux_clk);
 	if (priv->dma_enabled)
 		brcmuart_arbitration(priv, 0);
 	return 0;
-- 
2.40.0.1.gaa8946217a0b

