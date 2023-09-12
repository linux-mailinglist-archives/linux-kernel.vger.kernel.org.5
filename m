Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA3D79D6EE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237198AbjILQ4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233867AbjILQ4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:56:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0046E110;
        Tue, 12 Sep 2023 09:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694537770; x=1726073770;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+MaNNJGCKYl5eg+q9uVCoghWL58VMuP9LdwrcSXnJzc=;
  b=Nc2cdbc9G4X0Iy2mOsUaOTsPJQkodn1okyb+vflwuj/JkF+7ZRtbILVP
   zEM6kLQJNioyJiO9DUi3TgO0UWMgRglzBRpPIlWuS8x4ALgZrPd8mBJVa
   sx7LEFeI/imW/JryT+XuKaQglntMns53ojdMXrTLI/sEovyKCCDKU2W8b
   QwzC02h01VWp7zlnfOpAHTOQ2VNHzJqyuShCzVTISYm4hJ6/tmB0EbCLl
   EEOf55aXv+8Wcxh0G4G+aPUi7oQv73C0hjAJLN5eHj6fjkAdlgRNimKJK
   7/ZpAsBpcH6BxSipqIkINemTmx1z2bJGu6f5wJr5M59f4htNYKYzE+CHV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="381136009"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="381136009"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 09:55:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="693561252"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="693561252"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 12 Sep 2023 09:55:54 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2915F248; Tue, 12 Sep 2023 19:55:53 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 1/1] serial: 8250_bcm7271: Use dev_err_probe() instead of dev_err()
Date:   Tue, 12 Sep 2023 19:55:50 +0300
Message-Id: <20230912165550.402540-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the error messages format unified by switching to use
dev_err_probe() where it makes sense.

This also helps simplifing the code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_bcm7271.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_bcm7271.c b/drivers/tty/serial/8250/8250_bcm7271.c
index aa5aff046756..51c3eca8673c 100644
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
+			dev_err_probe(dev, dma_irq, "no IRQ resource info\n");
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

