Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C447F73B4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 13:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345066AbjKXMXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 07:23:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbjKXMXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 07:23:10 -0500
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA04D71
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 04:23:15 -0800 (PST)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 3AOCN5bb035990;
        Fri, 24 Nov 2023 20:23:05 +0800 (+08)
        (envelope-from Xuewen.Yan@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4ScDWm2myJz2K25CP;
        Fri, 24 Nov 2023 20:17:40 +0800 (CST)
Received: from BJ10918NBW01.spreadtrum.com (10.0.73.73) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Fri, 24 Nov 2023 20:23:03 +0800
From:   Xuewen Yan <xuewen.yan@unisoc.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <ilpo.jarvinen@linux.intel.com>, <tony@atomide.com>,
        <john.ogness@linutronix.de>
CC:     <tglx@linutronix.de>, <andriy.shevchenko@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <ke.wang@unisoc.com>, <xuewen.yan94@gmail.com>
Subject: [RFC PATCH] serial: core: Use pm_runtime_get_sync() in uart_start()
Date:   Fri, 24 Nov 2023 20:22:58 +0800
Message-ID: <20231124122258.1050-1-xuewen.yan@unisoc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.73.73]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 3AOCN5bb035990
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 84a9582fd203("serial: core: Start managing serial controllers to enable runtime PM")
use the pm_runtime_get() after uart_port_lock() which would close the irq and disable preement.
At this time,  pm_runtime_get may cause the following two problems:

(1) deadlock in try_to_wake_up:

uart_write()
uart_port_lock() <<< get lock
__uart_start
__pm_runtime_resume
rpm_resume
queue_work_on
try_to_wake_up
_printk
uart_console_write
...
uart_port_lock() <<< wait forever

(2) scheduling while atomic:
uart_write()
uart_port_lock() <<< get lock
__uart_start
__pm_runtime_resume
rpm_resume
chedule() << sleep

So let us use pm_runtime_get_sync() to prevent these.

Fixes: 84a9582fd203 ("serial: core: Start managing serial controllers to enable runtime PM")
Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
---
 drivers/tty/serial/serial_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index f1348a509552..902f7ed35f4d 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -145,7 +145,7 @@ static void __uart_start(struct uart_state *state)
 	port_dev = port->port_dev;
 
 	/* Increment the runtime PM usage count for the active check below */
-	err = pm_runtime_get(&port_dev->dev);
+	err = pm_runtime_get_sync(&port_dev->dev);
 	if (err < 0 && err != -EINPROGRESS) {
 		pm_runtime_put_noidle(&port_dev->dev);
 		return;
@@ -159,7 +159,7 @@ static void __uart_start(struct uart_state *state)
 	if (!pm_runtime_enabled(port->dev) || pm_runtime_active(port->dev))
 		port->ops->start_tx(port);
 	pm_runtime_mark_last_busy(&port_dev->dev);
-	pm_runtime_put_autosuspend(&port_dev->dev);
+	pm_runtime_put_sync_autosuspend(&port_dev->dev);
 }
 
 static void uart_start(struct tty_struct *tty)
-- 
2.25.1

