Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8AB7A474C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 12:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241151AbjIRKix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 06:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235450AbjIRKih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 06:38:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4074D109;
        Mon, 18 Sep 2023 03:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695033431; x=1726569431;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jvF05ZTLBstvl63wDmGAA6rnzjrQhXRDGowW7TeWuiU=;
  b=Za8LOWUPJeCRH1B/ASlqrRfpg37OsAHh9dnQhuwhmPkqvF5/TVUkmjFW
   9P0xO+J3P7JxRjE+DJS6KQZkI76D/JN+JwQAatJBSfRw2dPwOZ9JZOn3X
   C+fnFggO+uCH5UM4+TlMhSDqtfdZ7Vv15muHAWjcblef/okKrIJAF1TJ+
   xP6DUH5dW9Sme7crUkHAOHUcdaH0zmhC1ebFPMr3JBGEMArMTWSho2Plx
   U6hKLRRI1Lj2NrNs8PX1+kCzFFd99mUfBQfm+2UIZAb3knt1z5KquvMC1
   9T1KRVCA30NQlhZu2+VTVHvskHbOpvocl5gC2gCDTUZRSeYhiQttQlpqI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="383443451"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="383443451"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 03:37:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="739082840"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="739082840"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 18 Sep 2023 03:36:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DB5D318E; Mon, 18 Sep 2023 13:36:53 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/1] serial: 8250_bcm7271: Use dev_err_probe() instead of dev_err()
Date:   Mon, 18 Sep 2023 13:36:48 +0300
Message-Id: <20230918103648.1185663-1-andriy.shevchenko@linux.intel.com>
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

Make the error messages format unified by switching to use
dev_err_probe() where it makes sense.

This also helps simplifing the code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: added missing assignment (Christophe)
 drivers/tty/serial/8250/8250_bcm7271.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_bcm7271.c b/drivers/tty/serial/8250/8250_bcm7271.c
index aa5aff046756..5c6c8929581a 100644
--- a/drivers/tty/serial/8250/8250_bcm7271.c
+++ b/drivers/tty/serial/8250/8250_bcm7271.c
@@ -984,10 +984,9 @@ static int brcmuart_probe(struct platform_device *pdev)
 	}
 
 	/* We should have just the uart base registers or all the registers */
-	if (x != 1 && x != REGS_MAX) {
-		dev_warn(dev, "%s registers not specified\n", reg_names[x]);
-		return -EINVAL;
-	}
+	if (x != 1 && x != REGS_MAX)
+		return dev_err_probe(dev, -EINVAL, "%s registers not specified\n",
+				     reg_names[x]);
 
 	/* if the DMA registers were specified, try to enable DMA */
 	if (x > REGS_DMA_RX) {
@@ -1034,8 +1033,7 @@ static int brcmuart_probe(struct platform_device *pdev)
 	}
 
 	if (clk_rate == 0) {
-		dev_err(dev, "clock-frequency or clk not defined\n");
-		ret = -EINVAL;
+		ret = dev_err_probe(dev, -EINVAL, "clock-frequency or clk not defined\n");
 		goto err_clk_disable;
 	}
 
@@ -1093,7 +1091,7 @@ static int brcmuart_probe(struct platform_device *pdev)
 
 	ret = serial8250_register_8250_port(&up);
 	if (ret < 0) {
-		dev_err(dev, "unable to register 8250 port\n");
+		dev_err_probe(dev, ret, "unable to register 8250 port\n");
 		goto err;
 	}
 	priv->line = ret;
@@ -1102,14 +1100,13 @@ static int brcmuart_probe(struct platform_device *pdev)
 	if (priv->dma_enabled) {
 		dma_irq = platform_get_irq_byname(pdev,  "dma");
 		if (dma_irq < 0) {
-			ret = dma_irq;
-			dev_err(dev, "no IRQ resource info\n");
+			ret = dev_err_probe(dev, dma_irq, "no IRQ resource info\n");
 			goto err1;
 		}
 		ret = devm_request_irq(dev, dma_irq, brcmuart_isr,
 				IRQF_SHARED, "uart DMA irq", &new_port->port);
 		if (ret) {
-			dev_err(dev, "unable to register IRQ handler\n");
+			dev_err_probe(dev, ret, "unable to register IRQ handler\n");
 			goto err1;
 		}
 	}
-- 
2.40.0.1.gaa8946217a0b

