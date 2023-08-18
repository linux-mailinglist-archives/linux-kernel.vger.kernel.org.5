Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED94780448
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 05:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357491AbjHRDQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 23:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357539AbjHRDQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 23:16:17 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E1330E6;
        Thu, 17 Aug 2023 20:16:15 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 37I3FmmH046282;
        Fri, 18 Aug 2023 11:15:48 +0800 (+08)
        (envelope-from Wenhua.Lin@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx06.spreadtrum.com [10.0.1.11])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4RRn5B5lddz2Q25wW;
        Fri, 18 Aug 2023 11:13:34 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx06.spreadtrum.com
 (10.0.1.11) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Fri, 18 Aug
 2023 11:15:46 +0800
From:   Wenhua Lin <Wenhua.Lin@unisoc.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        wenhua lin <wenhua.lin1994@gmail.com>,
        Wenhua Lin <Wenhua.Lin@unisoc.com>,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>,
        Zhirong Qiu <zhirong.qiu@unisoc.com>,
        Zhaochen Su <Zhaochen.Su@unisoc.com>
Subject: [PATCH] tty/serial: Cancel work queue before closing uart
Date:   Fri, 18 Aug 2023 11:15:32 +0800
Message-ID: <20230818031532.15591-1-Wenhua.Lin@unisoc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.2.29]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 shmbx06.spreadtrum.com (10.0.1.11)
X-MAIL: SHSQR01.spreadtrum.com 37I3FmmH046282
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the system constantly sleeps and wankes up, plugging and unplugging
the USB will probalility trigger a kernel crash problem. The reason is
that at this time, the system entered deep and turned off uart, and the
abnormal behavior of plugging and upplugging the USB triggered the read
data process of uart, causing access to uart to hang. The final solution
we came up with is to cancel the work queue before shutting down uart
, while ensuring that there is no uart business.

Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
---
 drivers/tty/serial/sprd_serial.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index b58f51296ace..eddff4360155 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -20,6 +20,7 @@
 #include <linux/slab.h>
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
+#include "../tty.h"
 
 /* device name */
 #define UART_NR_MAX		8
@@ -1221,7 +1222,10 @@ static int sprd_probe(struct platform_device *pdev)
 static int sprd_suspend(struct device *dev)
 {
 	struct sprd_uart_port *sup = dev_get_drvdata(dev);
+	struct uart_port *uport = &sup->port;
+	struct tty_port *tty = &uport->state->port;
 
+	tty_buffer_cancel_work(tty);
 	uart_suspend_port(&sprd_uart_driver, &sup->port);
 
 	return 0;
-- 
2.17.1

