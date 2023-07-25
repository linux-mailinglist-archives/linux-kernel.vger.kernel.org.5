Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C584E760A71
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 08:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbjGYGl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 02:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjGYGl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 02:41:57 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44416116;
        Mon, 24 Jul 2023 23:41:55 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 36P6f7i5071057;
        Tue, 25 Jul 2023 14:41:07 +0800 (+08)
        (envelope-from Chunyan.Zhang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4R96p358q2z2K4D5v;
        Tue, 25 Jul 2023 14:39:39 +0800 (CST)
Received: from ubt.spreadtrum.com (10.0.73.70) by BJMBX02.spreadtrum.com
 (10.0.64.8) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Tue, 25 Jul
 2023 14:41:04 +0800
From:   Chunyan Zhang <chunyan.zhang@unisoc.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
CC:     <linux-serial@vger.kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH V3 1/2] serial: sprd: Assign sprd_port after initialized to avoid wrong access
Date:   Tue, 25 Jul 2023 14:40:52 +0800
Message-ID: <20230725064053.235448-1-chunyan.zhang@unisoc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.73.70]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL: SHSQR01.spreadtrum.com 36P6f7i5071057
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The global pointer 'sprd_port' may not zero when sprd_probe returns
failure, that is a risk for sprd_port to be accessed afterward, and
may lead to unexpected errors.

For example:

There are two UART ports, UART1 is used for console and configured in
kernel command line, i.e. "console=";

The UART1 probe failed and the memory allocated to sprd_port[1] was
released, but sprd_port[1] was not set to NULL;

In UART2 probe, the same virtual address was allocated to sprd_port[2],
and UART2 probe process finally will go into sprd_console_setup() to
register UART1 as console since it is configured as preferred console
(filled to console_cmdline[]), but the console parameters (sprd_port[1])
belong to UART2.

So move the sprd_port[] assignment to where the port already initialized
can avoid the above issue.

Fixes: b7396a38fb28 ("tty/serial: Add Spreadtrum sc9836-uart driver support")
Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
V3:
- Call uart_unregister_driver() only when the 'sprd_ports_num' decreases to 0;
- Add calling sprd_rx_free_buf() instread of sprd_remove() under clean_up lable. 

V2:
- Leave sprd_remove() to keep the unrelated code logic the same.
---
 drivers/tty/serial/sprd_serial.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index b58f51296ace..fc1377029021 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -1106,7 +1106,7 @@ static bool sprd_uart_is_console(struct uart_port *uport)
 static int sprd_clk_init(struct uart_port *uport)
 {
 	struct clk *clk_uart, *clk_parent;
-	struct sprd_uart_port *u = sprd_port[uport->line];
+	struct sprd_uart_port *u = container_of(uport, struct sprd_uart_port, port);
 
 	clk_uart = devm_clk_get(uport->dev, "uart");
 	if (IS_ERR(clk_uart)) {
@@ -1149,22 +1149,22 @@ static int sprd_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	struct uart_port *up;
+	struct sprd_uart_port *sport;
 	int irq;
 	int index;
 	int ret;
 
 	index = of_alias_get_id(pdev->dev.of_node, "serial");
-	if (index < 0 || index >= ARRAY_SIZE(sprd_port)) {
+	if (index < 0 || index >= UART_NR_MAX) {
 		dev_err(&pdev->dev, "got a wrong serial alias id %d\n", index);
 		return -EINVAL;
 	}
 
-	sprd_port[index] = devm_kzalloc(&pdev->dev, sizeof(*sprd_port[index]),
-					GFP_KERNEL);
-	if (!sprd_port[index])
+	sport = devm_kzalloc(&pdev->dev, sizeof(*sport), GFP_KERNEL);
+	if (!sport)
 		return -ENOMEM;
 
-	up = &sprd_port[index]->port;
+	up = &sport->port;
 	up->dev = &pdev->dev;
 	up->line = index;
 	up->type = PORT_SPRD;
@@ -1195,7 +1195,7 @@ static int sprd_probe(struct platform_device *pdev)
 	 * Allocate one dma buffer to prepare for receive transfer, in case
 	 * memory allocation failure at runtime.
 	 */
-	ret = sprd_rx_alloc_buf(sprd_port[index]);
+	ret = sprd_rx_alloc_buf(sport);
 	if (ret)
 		return ret;
 
@@ -1206,14 +1206,23 @@ static int sprd_probe(struct platform_device *pdev)
 			return ret;
 		}
 	}
+
 	sprd_ports_num++;
+	sprd_port[index] = sport;
 
 	ret = uart_add_one_port(&sprd_uart_driver, up);
 	if (ret)
-		sprd_remove(pdev);
+		goto clean_port;
 
 	platform_set_drvdata(pdev, up);
 
+	return 0;
+
+clean_port:
+	sprd_port[index] = NULL;
+	if (--sprd_ports_num == 0)
+		uart_unregister_driver(&sprd_uart_driver);
+	sprd_rx_free_buf(sport);
 	return ret;
 }
 
-- 
2.41.0

