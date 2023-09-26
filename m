Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09CEF7AE598
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 08:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233733AbjIZGNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 02:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233717AbjIZGNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 02:13:50 -0400
Received: from muru.com (unknown [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A5B82E9;
        Mon, 25 Sep 2023 23:13:40 -0700 (PDT)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 155DA80E2;
        Tue, 26 Sep 2023 06:13:22 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Udit Kumar <u-kumar1@ti.com>,
        Thomas Richard <thomas.richard@bootlin.com>
Subject: [PATCH] serial: 8250_omap: Fix errors with no_console_suspend
Date:   Tue, 26 Sep 2023 09:13:17 +0300
Message-ID: <20230926061319.15140-1-tony@atomide.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_NONE,T_SPF_HELO_TEMPERROR
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We now get errors on system suspend if no_console_suspend is set as
reported by Thomas. The errors started with commit 20a41a62618d ("serial:
8250_omap: Use force_suspend and resume for system suspend").

Let's fix the issue by checking for console_suspend_enabled in the system
suspend and resume path.

Note that with this fix the checks for console_suspend_enabled in
omap8250_runtime_suspend() become useless. We now keep runtime PM usage
count for an attached kernel console starting with commit bedb404e91bb
("serial: 8250_port: Don't use power management for kernel console").

Fixes: 20a41a62618d ("serial: 8250_omap: Use force_suspend and resume for system suspend")
Cc: Udit Kumar <u-kumar1@ti.com>
Reported-by: Thomas Richard <thomas.richard@bootlin.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/tty/serial/8250/8250_omap.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1617,7 +1617,7 @@ static int omap8250_suspend(struct device *dev)
 {
 	struct omap8250_priv *priv = dev_get_drvdata(dev);
 	struct uart_8250_port *up = serial8250_get_port(priv->line);
-	int err;
+	int err = 0;
 
 	serial8250_suspend_port(priv->line);
 
@@ -1627,7 +1627,8 @@ static int omap8250_suspend(struct device *dev)
 	if (!device_may_wakeup(dev))
 		priv->wer = 0;
 	serial_out(up, UART_OMAP_WER, priv->wer);
-	err = pm_runtime_force_suspend(dev);
+	if (uart_console(&up->port) && console_suspend_enabled)
+		err = pm_runtime_force_suspend(dev);
 	flush_work(&priv->qos_work);
 
 	return err;
@@ -1636,11 +1637,15 @@ static int omap8250_suspend(struct device *dev)
 static int omap8250_resume(struct device *dev)
 {
 	struct omap8250_priv *priv = dev_get_drvdata(dev);
+	struct uart_8250_port *up = serial8250_get_port(priv->line);
 	int err;
 
-	err = pm_runtime_force_resume(dev);
-	if (err)
-		return err;
+	if (uart_console(&up->port) && console_suspend_enabled) {
+		err = pm_runtime_force_resume(dev);
+		if (err)
+			return err;
+	}
+
 	serial8250_resume_port(priv->line);
 	/* Paired with pm_runtime_resume_and_get() in omap8250_suspend() */
 	pm_runtime_mark_last_busy(dev);
@@ -1717,16 +1722,6 @@ static int omap8250_runtime_suspend(struct device *dev)
 
 	if (priv->line >= 0)
 		up = serial8250_get_port(priv->line);
-	/*
-	 * When using 'no_console_suspend', the console UART must not be
-	 * suspended. Since driver suspend is managed by runtime suspend,
-	 * preventing runtime suspend (by returning error) will keep device
-	 * active during suspend.
-	 */
-	if (priv->is_suspending && !console_suspend_enabled) {
-		if (up && uart_console(&up->port))
-			return -EBUSY;
-	}
 
 	if (priv->habit & UART_ERRATA_CLOCK_DISABLE) {
 		int ret;
-- 
2.42.0
