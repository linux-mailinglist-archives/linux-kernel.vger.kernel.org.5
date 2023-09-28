Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA527B158B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 10:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjI1IEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 04:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjI1IEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 04:04:13 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0EDD092;
        Thu, 28 Sep 2023 01:04:11 -0700 (PDT)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id CB67280A6;
        Thu, 28 Sep 2023 08:04:08 +0000 (UTC)
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
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH] serial: 8250_omap: Drop pm_runtime_irq_safe()
Date:   Thu, 28 Sep 2023 11:03:56 +0300
Message-ID: <20230928080358.2693-1-tony@atomide.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's drop the use of pm_runtime_irq_safe() for 8250_omap. The use of
pm_runtime_irq_safe() is not nice as it takes a permanent usage count on
the parent device.

We can finally drop pm_runtime_irq_safe() safely as the kernel now knows
when the uart port tx is active. This changed with commit 84a9582fd203
("serial: core: Start managing serial controllers to enable runtime PM").

For serial port rx, we already use Linux generic wakeirqs for 8250_omap.

To drop pm_runtime_irq_safe(), we need to add handling for shallow idle
state where the port hardware may already be awake and an IO interrupt
happens. We also need to replace the serial8250_rpm sync calls in the
interrupt handlers with async runtime PM calls.

Note that omap8250_irq() calls omap_8250_dma_handle_irq(), so we don't
need separate runtime PM calls in omap_8250_dma_handle_irq().

While at it, let's also add the missing line break to the end of
omap8250_runtime_resume() to group the calls.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/tty/serial/8250/8250_omap.c | 30 ++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -8,6 +8,7 @@
  *
  */
 
+#include <linux/atomic.h>
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/io.h>
@@ -130,6 +131,7 @@ struct omap8250_priv {
 
 	u8 tx_trigger;
 	u8 rx_trigger;
+	atomic_t active;
 	bool is_suspending;
 	int wakeirq;
 	int wakeups_enabled;
@@ -632,14 +634,21 @@ static irqreturn_t omap8250_irq(int irq, void *dev_id)
 	unsigned int iir, lsr;
 	int ret;
 
+	pm_runtime_get_noresume(port->dev);
+
+	/* Shallow idle state wake-up to an IO interrupt? */
+	if (atomic_add_unless(&priv->active, 1, 1)) {
+		priv->latency = priv->calc_latency;
+		schedule_work(&priv->qos_work);
+	}
+
 #ifdef CONFIG_SERIAL_8250_DMA
 	if (up->dma) {
 		ret = omap_8250_dma_handle_irq(port);
-		return IRQ_RETVAL(ret);
+		goto out_runtime_put;
 	}
 #endif
 
-	serial8250_rpm_get(up);
 	lsr = serial_port_in(port, UART_LSR);
 	iir = serial_port_in(port, UART_IIR);
 	ret = serial8250_handle_irq(port, iir);
@@ -676,7 +685,9 @@ static irqreturn_t omap8250_irq(int irq, void *dev_id)
 		schedule_delayed_work(&up->overrun_backoff, delay);
 	}
 
-	serial8250_rpm_put(up);
+out_runtime_put:
+	pm_runtime_mark_last_busy(port->dev);
+	pm_runtime_put(port->dev);
 
 	return IRQ_RETVAL(ret);
 }
@@ -1270,11 +1281,8 @@ static int omap_8250_dma_handle_irq(struct uart_port *port)
 	u16 status;
 	u8 iir;
 
-	serial8250_rpm_get(up);
-
 	iir = serial_port_in(port, UART_IIR);
 	if (iir & UART_IIR_NO_INT) {
-		serial8250_rpm_put(up);
 		return IRQ_HANDLED;
 	}
 
@@ -1305,7 +1313,6 @@ static int omap_8250_dma_handle_irq(struct uart_port *port)
 
 	uart_unlock_and_check_sysrq(port);
 
-	serial8250_rpm_put(up);
 	return 1;
 }
 
@@ -1503,8 +1510,6 @@ static int omap8250_probe(struct platform_device *pdev)
 	if (!of_get_available_child_count(pdev->dev.of_node))
 		pm_runtime_set_autosuspend_delay(&pdev->dev, -1);
 
-	pm_runtime_irq_safe(&pdev->dev);
-
 	pm_runtime_get_sync(&pdev->dev);
 
 	omap_serial_fill_features_erratas(&up, priv);
@@ -1743,6 +1748,7 @@ static int omap8250_runtime_suspend(struct device *dev)
 
 	priv->latency = PM_QOS_CPU_LATENCY_DEFAULT_VALUE;
 	schedule_work(&priv->qos_work);
+	atomic_set(&priv->active, 0);
 
 	return 0;
 }
@@ -1752,6 +1758,10 @@ static int omap8250_runtime_resume(struct device *dev)
 	struct omap8250_priv *priv = dev_get_drvdata(dev);
 	struct uart_8250_port *up = NULL;
 
+	/* Did the hardware wake to a device IO interrupt before a wakeirq? */
+	if (atomic_read(&priv->active))
+		return 0;
+
 	if (priv->line >= 0)
 		up = serial8250_get_port(priv->line);
 
@@ -1767,8 +1777,10 @@ static int omap8250_runtime_resume(struct device *dev)
 		uart_port_unlock_irq(&up->port);
 	}
 
+	atomic_set(&priv->active, 1);
 	priv->latency = priv->calc_latency;
 	schedule_work(&priv->qos_work);
+
 	return 0;
 }
 
-- 
2.42.0
