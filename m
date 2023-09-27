Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608D27AF9C6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 07:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjI0FCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 01:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjI0FBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 01:01:23 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9234D1D28A;
        Tue, 26 Sep 2023 21:29:55 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id C86C680A3;
        Wed, 27 Sep 2023 04:29:51 +0000 (UTC)
Date:   Wed, 27 Sep 2023 07:29:50 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Dhruva Gole <d-gole@ti.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Udit Kumar <u-kumar1@ti.com>,
        Thomas Richard <thomas.richard@bootlin.com>
Subject: Re: [PATCH] serial: 8250_omap: Fix errors with no_console_suspend
Message-ID: <20230927042950.GB5285@atomide.com>
References: <20230926061319.15140-1-tony@atomide.com>
 <ZRLBWrjUadvGCs/y@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRLBWrjUadvGCs/y@smile.fi.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andy Shevchenko <andriy.shevchenko@intel.com> [230926 11:59]:
> Btw, how close are we to getting rid the pm_runtime_irq_safe() call?

Very close, I think still doable for v6.7 merge window.. Below is what I'm
testing with, there's one error that I've seen that may or may not be
related.

Regards,

Tony

8< ---------------------------
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
 
@@ -1500,8 +1507,6 @@ static int omap8250_probe(struct platform_device *pdev)
 	if (!of_get_available_child_count(pdev->dev.of_node))
 		pm_runtime_set_autosuspend_delay(&pdev->dev, -1);
 
-	pm_runtime_irq_safe(&pdev->dev);
-
 	pm_runtime_get_sync(&pdev->dev);
 
 	omap_serial_fill_features_erratas(&up, priv);
@@ -1740,6 +1745,7 @@ static int omap8250_runtime_suspend(struct device *dev)
 
 	priv->latency = PM_QOS_CPU_LATENCY_DEFAULT_VALUE;
 	schedule_work(&priv->qos_work);
+	atomic_set(&priv->active, 0);
 
 	return 0;
 }
@@ -1749,6 +1755,10 @@ static int omap8250_runtime_resume(struct device *dev)
 	struct omap8250_priv *priv = dev_get_drvdata(dev);
 	struct uart_8250_port *up = NULL;
 
+	/* Did the hardware wake to a device IO interrupt before a wakeirq? */
+	if (atomic_read(&priv->active))
+		return 0;
+
 	if (priv->line >= 0)
 		up = serial8250_get_port(priv->line);
 
@@ -1764,8 +1774,10 @@ static int omap8250_runtime_resume(struct device *dev)
 		spin_unlock_irq(&up->port.lock);
 	}
 
+	atomic_set(&priv->active, 1);
 	priv->latency = priv->calc_latency;
 	schedule_work(&priv->qos_work);
+
 	return 0;
 }
 
-- 
2.42.0
