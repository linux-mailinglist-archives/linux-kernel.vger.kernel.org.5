Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0497A6BDC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 21:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbjISTzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 15:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbjISTzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 15:55:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C078F;
        Tue, 19 Sep 2023 12:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695153298; x=1726689298;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Bepkwmn/REb0biKQxCPTgmoT59eVotqTB0kTZUaw9lM=;
  b=d3fUji3fHZsSwfN9lc7Kftc3oSBGNvPjH69U615F31lzjvpF+pjfU56e
   ZQFrJbpeSLh5pNu45pDsTq5Gt8eV2ihDz86rjJAY9gwn8uLsf+/jOOx/T
   7HQiPFHJR1NDeixqK1xPjYTc6agw31na7DcRwhkNz8aQY2oEHTb7fRPmT
   DydXjzO+HV2f9t4sL+QuIrjrQ9ZiAzX3ByVhlcdneQJKH8yXqx+QMTvdk
   hOE5rRphHGLt4MuMaJ1wYuWQm2qti7OvU2HVwyaqNjWB4+Nx3f93DZboK
   JUWAe55+ZSmyUmtTatLNZWaAFCPiAwsxlBZ0cJnsu5y6vEB/4UVVW+mBb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="383874532"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="383874532"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 12:54:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="746354996"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="746354996"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 19 Sep 2023 12:54:54 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9473545B; Tue, 19 Sep 2023 22:54:53 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Andi Shyti <andi.shyti@linux.intel.com>
Subject: [PATCH v1 1/1] serial: 8250_aspeed_vuart: Use devm_clk_get_enabled()
Date:   Tue, 19 Sep 2023 22:54:50 +0300
Message-Id: <20230919195450.3197881-1-andriy.shevchenko@linux.intel.com>
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

Use devm_clk_get_enabled() to simplify the code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
---
 drivers/tty/serial/8250/8250_aspeed_vuart.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
index 7a4537a1d66c..270b3a710eb6 100644
--- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
+++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
@@ -34,7 +34,6 @@
 
 struct aspeed_vuart {
 	struct device		*dev;
-	struct clk		*clk;
 	int			line;
 	struct timer_list	unthrottle_timer;
 	struct uart_8250_port	*port;
@@ -422,6 +421,7 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
 	struct resource *res;
 	u32 clk, prop, sirq[2];
 	int rc, sirq_polarity;
+	struct clk *vclk;
 
 	np = pdev->dev.of_node;
 
@@ -454,18 +454,13 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
 		return rc;
 
 	if (of_property_read_u32(np, "clock-frequency", &clk)) {
-		vuart->clk = devm_clk_get(&pdev->dev, NULL);
-		if (IS_ERR(vuart->clk)) {
-			rc = dev_err_probe(dev, PTR_ERR(vuart->clk),
-					   "clk or clock-frequency not defined\n");
+		vclk = devm_clk_get_enabled(dev, NULL);
+		if (IS_ERR(vclk)) {
+			rc = dev_err_probe(dev, PTR_ERR(vclk), "clk or clock-frequency not defined\n");
 			goto err_sysfs_remove;
 		}
 
-		rc = clk_prepare_enable(vuart->clk);
-		if (rc < 0)
-			goto err_sysfs_remove;
-
-		clk = clk_get_rate(vuart->clk);
+		clk = clk_get_rate(vclk);
 	}
 
 	/* If current-speed was set, then try not to change it. */
@@ -565,7 +560,6 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
 	return 0;
 
 err_clk_disable:
-	clk_disable_unprepare(vuart->clk);
 	irq_dispose_mapping(port.port.irq);
 err_sysfs_remove:
 	sysfs_remove_group(&vuart->dev->kobj, &aspeed_vuart_attr_group);
@@ -580,7 +574,6 @@ static int aspeed_vuart_remove(struct platform_device *pdev)
 	aspeed_vuart_set_enabled(vuart, false);
 	serial8250_unregister_port(vuart->line);
 	sysfs_remove_group(&vuart->dev->kobj, &aspeed_vuart_attr_group);
-	clk_disable_unprepare(vuart->clk);
 
 	return 0;
 }
-- 
2.40.0.1.gaa8946217a0b

