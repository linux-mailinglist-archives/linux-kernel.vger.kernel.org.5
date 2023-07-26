Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF92763638
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 14:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233472AbjGZMXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 08:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbjGZMXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 08:23:42 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001C21BF6;
        Wed, 26 Jul 2023 05:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690374213; x=1721910213;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=J/b6oqoHFRqvTcNW79wrv9kVaPoIxwuRld8Ml1S2Zdc=;
  b=B7XZw8XaT1mGhj5nZ9Wrk0Xj6veQ8XZIq+h8jgazRRj1+09l8sxAqZlc
   bFvko/xPEKbuDZKywg/dm7OZJuDbywVvLyY8OE9wwVHMNKUiWBJWykyOL
   2jPvxFL+FgWmJBVlqWbB+bCo9i6Gnb+w3+OKPlyWfNGmt6Nnt1A4zLEdg
   mWe2zhSL6dak+dcA/WBDI5v99dJx+H7+7zy7S9d4L4TzxfF8VH18ZfL4+
   rBuih8e8O1KhUITDrrPBM4wT2D8rcQ/elkpcuJEkSwuM4ncz49j8oZ/9c
   kcmCep6qVzdpz/VgRrjEt34zFVkrtMs3dNYAqySXBVS9Ssg0WFUFIOW5P
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="434265920"
X-IronPort-AV: E=Sophos;i="6.01,232,1684825200"; 
   d="scan'208";a="434265920"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 05:23:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="761629553"
X-IronPort-AV: E=Sophos;i="6.01,232,1684825200"; 
   d="scan'208";a="761629553"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 26 Jul 2023 05:23:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 86CB912B; Wed, 26 Jul 2023 15:23:39 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] serial: core: Simplify uart_get_rs485_mode()
Date:   Wed, 26 Jul 2023 15:23:35 +0300
Message-Id: <20230726122335.14187-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify uart_get_rs485_mode() by using temporary variable for
the GPIO descriptor. With that, use proper type for the flags
of the GPIO descriptor.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/serial_core.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 831d033611e6..1eab3abd955a 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3565,9 +3565,10 @@ int uart_get_rs485_mode(struct uart_port *port)
 {
 	struct serial_rs485 *rs485conf = &port->rs485;
 	struct device *dev = port->dev;
+	enum gpiod_flags dflags;
+	struct gpio_desc *desc;
 	u32 rs485_delay[2];
 	int ret;
-	int rx_during_tx_gpio_flag;
 
 	ret = device_property_read_u32_array(dev, "rs485-rts-delay",
 					     rs485_delay, 2);
@@ -3606,26 +3607,19 @@ int uart_get_rs485_mode(struct uart_port *port)
 	 * bus participants enable it, no communication is possible at all.
 	 * Works fine for short cables and users may enable for longer cables.
 	 */
-	port->rs485_term_gpio = devm_gpiod_get_optional(dev, "rs485-term",
-							GPIOD_OUT_LOW);
-	if (IS_ERR(port->rs485_term_gpio)) {
-		ret = PTR_ERR(port->rs485_term_gpio);
-		port->rs485_term_gpio = NULL;
-		return dev_err_probe(dev, ret, "Cannot get rs485-term-gpios\n");
-	}
+	desc = devm_gpiod_get_optional(dev, "rs485-term", GPIOD_OUT_LOW);
+	if (IS_ERR(desc))
+		return dev_err_probe(dev, PTR_ERR(desc), "Cannot get rs485-term-gpios\n");
+	port->rs485_term_gpio = desc;
 	if (port->rs485_term_gpio)
 		port->rs485_supported.flags |= SER_RS485_TERMINATE_BUS;
 
-	rx_during_tx_gpio_flag = (rs485conf->flags & SER_RS485_RX_DURING_TX) ?
-				 GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
-	port->rs485_rx_during_tx_gpio = devm_gpiod_get_optional(dev,
-								"rs485-rx-during-tx",
-								rx_during_tx_gpio_flag);
-	if (IS_ERR(port->rs485_rx_during_tx_gpio)) {
-		ret = PTR_ERR(port->rs485_rx_during_tx_gpio);
-		port->rs485_rx_during_tx_gpio = NULL;
-		return dev_err_probe(dev, ret, "Cannot get rs485-rx-during-tx-gpios\n");
-	}
+	dflags = (rs485conf->flags & SER_RS485_RX_DURING_TX) ?
+		 GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
+	desc = devm_gpiod_get_optional(dev, "rs485-rx-during-tx", dflags);
+	if (IS_ERR(desc))
+		return dev_err_probe(dev, PTR_ERR(desc), "Cannot get rs485-rx-during-tx-gpios\n");
+	port->rs485_rx_during_tx_gpio = desc;
 
 	return 0;
 }
-- 
2.40.0.1.gaa8946217a0b

