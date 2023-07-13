Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3BE7516B2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 05:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233560AbjGMDUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 23:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233500AbjGMDT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 23:19:59 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524AF1FEE;
        Wed, 12 Jul 2023 20:19:56 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 36D3JLrk061809;
        Thu, 13 Jul 2023 11:19:21 +0800 (+08)
        (envelope-from Chunyan.Zhang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4R1fvF2cfYz2M4K4c;
        Thu, 13 Jul 2023 11:18:17 +0800 (CST)
Received: from ubt.spreadtrum.com (10.0.73.70) by BJMBX02.spreadtrum.com
 (10.0.64.8) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Thu, 13 Jul
 2023 11:19:19 +0800
From:   Chunyan Zhang <chunyan.zhang@unisoc.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
CC:     <linux-serial@vger.kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 2/2] serial: sprd: Fix DMA buffer leak issue
Date:   Thu, 13 Jul 2023 11:19:04 +0800
Message-ID: <20230713031904.12106-2-chunyan.zhang@unisoc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230713031904.12106-1-chunyan.zhang@unisoc.com>
References: <20230713031904.12106-1-chunyan.zhang@unisoc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.73.70]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL: SHSQR01.spreadtrum.com 36D3JLrk061809
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Release DMA buffer when _probe() returns failure to avoid memory leak,
also set rx_dma.virt to NULL after being freed.

Fixes: f4487db58eb7 ("serial: sprd: Add DMA mode support")
Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
V2:
- Added Baolin's Reviewed-by;
- Add setting rx_dma.virt to NULL after being freed.
---
 drivers/tty/serial/sprd_serial.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index 11de338a6122..29d89751b3bb 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -364,7 +364,7 @@ static void sprd_rx_free_buf(struct sprd_uart_port *sp)
 	if (sp->rx_dma.virt)
 		dma_free_coherent(sp->port.dev, SPRD_UART_RX_SIZE,
 				  sp->rx_dma.virt, sp->rx_dma.phys_addr);
-
+	sp->rx_dma.virt = NULL;
 }
 
 static int sprd_rx_dma_config(struct uart_port *port, u32 burst)
@@ -1203,7 +1203,7 @@ static int sprd_probe(struct platform_device *pdev)
 		ret = uart_register_driver(&sprd_uart_driver);
 		if (ret < 0) {
 			pr_err("Failed to register SPRD-UART driver\n");
-			return ret;
+			goto free_rx_buf;
 		}
 	}
 	sprd_ports_num++;
@@ -1222,7 +1222,8 @@ static int sprd_probe(struct platform_device *pdev)
 	sprd_port[index] = NULL;
 	sprd_ports_num--;
 	uart_unregister_driver(&sprd_uart_driver);
-	sprd_remove(pdev);
+free_rx_buf:
+	sprd_rx_free_buf(sport);
 	return ret;
 }
 
-- 
2.41.0

