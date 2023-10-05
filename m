Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDCF17BA013
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235054AbjJEOcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234300AbjJEObZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:31:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF0328114;
        Thu,  5 Oct 2023 06:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696513497; x=1728049497;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5SpEVemSirx21NVTF+jU5S1sEv0Gnxk/3NfB/f1IUz4=;
  b=aQKUx/FTxmgbepNPNIG/kWF8sBDNepyMMmRnsReYPUs1iCTyRG9KGhr/
   aW8ULEpE6gdquYw5Y4uDf83OEE5ceWBBWuoXUg8dCvplOUou7YG3J5Kzf
   7T5RKx7EA567zpFvPkYy/uQNEpH+HiLwv01Iax42iHKiaWRv0CqrElMDO
   08x+2gqpWSfauslQ7sThhZ077OVlCJOgX5X1G1DbWq+58aYiLz2aT8F/X
   vsgT0TIRwLYYzy4gvryPh8vHhDvNJ8LfCH01Ld8jwwfP4cJhSCqNekDuT
   1cJeWXuOCUoGEKdMDpDqbydzKUaTskjXdXW2R+ue/oJerBuh5U2izDYMy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="447665974"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="447665974"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 05:45:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="1083010888"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="1083010888"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 05 Oct 2023 05:45:53 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0AC6C35A; Thu,  5 Oct 2023 15:45:51 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/1] serial: 8250_bcm7271: Use devm_clk_get_optional_enabled()
Date:   Thu,  5 Oct 2023 15:45:50 +0300
Message-Id: <20231005124550.3607234-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_clk_get_optional_enabled() to simplify the code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: fixed the returned value (Andi)
 drivers/tty/serial/8250/8250_bcm7271.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_bcm7271.c b/drivers/tty/serial/8250/8250_bcm7271.c
index 1a853a08654a..55dea2539c47 100644
--- a/drivers/tty/serial/8250/8250_bcm7271.c
+++ b/drivers/tty/serial/8250/8250_bcm7271.c
@@ -1015,26 +1015,23 @@ static int brcmuart_probe(struct platform_device *pdev)
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
+	ret = PTR_ERR_OR_ZERO(baud_mux_clk);
+	if (ret)
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
@@ -1118,8 +1115,6 @@ static int brcmuart_probe(struct platform_device *pdev)
 	serial8250_unregister_port(priv->line);
 err:
 	brcmuart_free_bufs(dev, priv);
-err_clk_disable:
-	clk_disable_unprepare(baud_mux_clk);
 release_dma:
 	if (priv->dma_enabled)
 		brcmuart_arbitration(priv, 0);
@@ -1134,7 +1129,6 @@ static int brcmuart_remove(struct platform_device *pdev)
 	hrtimer_cancel(&priv->hrt);
 	serial8250_unregister_port(priv->line);
 	brcmuart_free_bufs(&pdev->dev, priv);
-	clk_disable_unprepare(priv->baud_mux_clk);
 	if (priv->dma_enabled)
 		brcmuart_arbitration(priv, 0);
 	return 0;
-- 
2.40.0.1.gaa8946217a0b

