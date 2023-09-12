Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8502D79D6EB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235252AbjILQ4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbjILQ4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:56:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01128110;
        Tue, 12 Sep 2023 09:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694537769; x=1726073769;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6oK3QKUyE2J6G3j5C3mGEJEaadkE/lTt0pjP5XqCoTA=;
  b=fzqmcLdRoOJ5u+a9v/DfTM5zBsArNmuZATc+naAgBP4z17NU05lRKr60
   ej+vApyjGFfra6D4x3C+Ustujru+QMW0gerfpkN90lWBs6i1qmhmHxk3N
   zZJLYhhGYNFuoFQmQfH4z9cQ3IIMSNZ6HpXH95bqmxpIcQGyxPiDh13uD
   ttlk+3r2jlCMoRI07zKQ3YoFcge4wpXbTAf2HROb8/oylY0hjloX+ETPF
   AhxqmfNucEcX8qecZ5uFuouVGNCGjmv3rLJhPXWxV5xJW/WFcbyzAFD/1
   EZE1vsXoQdnrRu/NHLvTP1SwNArumRvJIdvY5Z6dnMI0KMDX1DnuCjeXj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="381135985"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="381135985"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 09:55:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="746968566"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="746968566"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 12 Sep 2023 09:55:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 76B6C248; Tue, 12 Sep 2023 19:55:45 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Subject: [PATCH v1 1/1] serial: 8250_aspeed_vuart: Use dev_err_probe() instead of dev_err()
Date:   Tue, 12 Sep 2023 19:55:40 +0300
Message-Id: <20230912165540.402504-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The probe process may generate EPROBE_DEFER. In this case
dev_err_probe() can still record err information. Otherwise
it may pollute logs on that occasion.

This also helps simplifing code and standardizing the error output.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_aspeed_vuart.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
index 4a9e71b2dbbc..7a4537a1d66c 100644
--- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
+++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
@@ -415,6 +415,7 @@ static int aspeed_vuart_map_irq_polarity(u32 dt)
 static int aspeed_vuart_probe(struct platform_device *pdev)
 {
 	struct of_phandle_args sirq_polarity_sense_args;
+	struct device *dev = &pdev->dev;
 	struct uart_8250_port port;
 	struct aspeed_vuart *vuart;
 	struct device_node *np;
@@ -455,9 +456,8 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
 	if (of_property_read_u32(np, "clock-frequency", &clk)) {
 		vuart->clk = devm_clk_get(&pdev->dev, NULL);
 		if (IS_ERR(vuart->clk)) {
-			dev_warn(&pdev->dev,
-				"clk or clock-frequency not defined\n");
-			rc = PTR_ERR(vuart->clk);
+			rc = dev_err_probe(dev, PTR_ERR(vuart->clk),
+					   "clk or clock-frequency not defined\n");
 			goto err_sysfs_remove;
 		}
 
@@ -533,7 +533,7 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
 
 	rc = aspeed_vuart_set_lpc_address(vuart, prop);
 	if (rc < 0) {
-		dev_err(&pdev->dev, "invalid value in aspeed,lpc-io-reg property\n");
+		dev_err_probe(dev, rc, "invalid value in aspeed,lpc-io-reg property\n");
 		goto err_clk_disable;
 	}
 
@@ -545,14 +545,14 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
 
 	rc = aspeed_vuart_set_sirq(vuart, sirq[0]);
 	if (rc < 0) {
-		dev_err(&pdev->dev, "invalid sirq number in aspeed,lpc-interrupts property\n");
+		dev_err_probe(dev, rc, "invalid sirq number in aspeed,lpc-interrupts property\n");
 		goto err_clk_disable;
 	}
 
 	sirq_polarity = aspeed_vuart_map_irq_polarity(sirq[1]);
 	if (sirq_polarity < 0) {
-		dev_err(&pdev->dev, "invalid sirq polarity in aspeed,lpc-interrupts property\n");
-		rc = sirq_polarity;
+		rc = dev_err_probe(dev, sirq_polarity,
+				   "invalid sirq polarity in aspeed,lpc-interrupts property\n");
 		goto err_clk_disable;
 	}
 
-- 
2.40.0.1.gaa8946217a0b

