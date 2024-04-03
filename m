Return-Path: <linux-kernel+bounces-130179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2B1897504
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7EE5B26D29
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568F914EC75;
	Wed,  3 Apr 2024 16:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="G5s5ivjj"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264BC14E2EC;
	Wed,  3 Apr 2024 16:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712160966; cv=none; b=HollmTZO0HY2zHjR3fxmqWa7w2Yqx1LroKPx2Hv4Z3yQRa/tUNAbYwOlGcWrjfXrjAhLXkCHyLrdR6sLyYK5bBRjyGpvyiQTR6IR+O1NL2lng9V5f3AvItCAGBOfXlOpiJvbkDVYpFYf17ttTnBoluQnkQFk9xdDH2DVO4IG95Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712160966; c=relaxed/simple;
	bh=M+3CjUZ881noPC4LnDT6qdcIjDl/+0y3ohESlrlgTN0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=SjXLW78Q2Z/rB9Tmvgkp0twabuE45OuXP+iowVqJ2xVxhQc8mUWDeZessUzcxJlj9NSg9TYf79e49mJLlYBxc6H17cx+S33Wq5Y+iX2j5D2Gaa/5Aiak/Lio1grmITFlPFXuhONQEImwHyk8Fu5f/8gWM5TTcsOIR0wjSBR7hJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=G5s5ivjj; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from apais-vm1.0synte4vioeebbvidf5q0vz2ua.xx.internal.cloudapp.net (unknown [52.183.86.224])
	by linux.microsoft.com (Postfix) with ESMTPSA id B259A20E8CB5;
	Wed,  3 Apr 2024 09:16:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B259A20E8CB5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1712160963;
	bh=Tf2nIFKxgJxLTCRd914GjPZBAC1OqxjFGGnqY5ExrYQ=;
	h=From:To:Cc:Subject:Date:From;
	b=G5s5ivjjp1CskgcLtuxPjzN3x1zIpBqxUv7c4pVdEPmfvhAD0abSVRaN627hZ0bQp
	 NmgW5MnNhnNCLlP7plkjMSWk8WWg8zvegCySX/uUxoKtUxmPKSziZ/CXslAN8rMn6g
	 e4JOs3pAJaja3GB7Wb98ljXuhrhTuDKCsh0+9Nm8=
From: Allen Pais <apais@linux.microsoft.com>
To: linux-kernel@vger.kernel.org
Cc: tj@kernel.org,
	keescook@chromium.org,
	gregkh@linuxfoundation.org,
	richard.genoud@gmail.com,
	jirislaby@kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH] tty: Convert from tasklet to BH workqueue
Date: Wed,  3 Apr 2024 16:15:59 +0000
Message-Id: <20240403161559.19970-1-apais@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The only generic interface to execute asynchronously in the BH context is
tasklet; however, it's marked deprecated and has some design flaws. To
replace tasklets, BH workqueue support was recently added. A BH workqueue
behaves similarly to regular workqueues except that the queued work items
are executed in the BH context.

This patch converts drivers/tty/* from tasklet to BH workqueue.

Based on the work done by Tejun Heo <tj@kernel.org>
Branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-6.10

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/tty/ipwireless/hardware.c | 15 +++---
 drivers/tty/serial/atmel_serial.c | 79 ++++++++++++++++---------------
 drivers/tty/serial/timbuart.c     | 19 ++++----
 drivers/tty/vt/keyboard.c         | 34 ++++++-------
 4 files changed, 76 insertions(+), 71 deletions(-)

diff --git a/drivers/tty/ipwireless/hardware.c b/drivers/tty/ipwireless/hardware.c
index 001ec318a918..a8bf3bd8f23a 100644
--- a/drivers/tty/ipwireless/hardware.c
+++ b/drivers/tty/ipwireless/hardware.c
@@ -22,6 +22,7 @@
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/slab.h>
+#include <linux/workqueue.h>
 
 #include "hardware.h"
 #include "setup_protocol.h"
@@ -275,7 +276,7 @@ struct ipw_hardware {
 	unsigned int control_lines[NL_NUM_OF_ADDRESSES];
 	struct ipw_rx_packet *packet_assembler[NL_NUM_OF_ADDRESSES];
 
-	struct tasklet_struct tasklet;
+	struct work_struct work;
 
 	/* The handle for the network layer, for the sending of events to it. */
 	struct ipw_network *network;
@@ -1006,9 +1007,9 @@ static int send_pending_packet(struct ipw_hardware *hw, int priority_limit)
 /*
  * Send and receive all queued packets.
  */
-static void ipwireless_do_tasklet(struct tasklet_struct *t)
+static void ipwireless_do_work(struct work_struct *t)
 {
-	struct ipw_hardware *hw = from_tasklet(hw, t, tasklet);
+	struct ipw_hardware *hw = from_work(hw, t, work);
 	unsigned long flags;
 
 	spin_lock_irqsave(&hw->lock, flags);
@@ -1084,7 +1085,7 @@ static irqreturn_t ipwireless_handle_v1_interrupt(int irq,
 		}
 		if (ack != 0) {
 			outw(ack, hw->base_port + IOIR);
-			tasklet_schedule(&hw->tasklet);
+			queue_work(system_bh_wq, &hw->work);
 		}
 		return IRQ_HANDLED;
 	}
@@ -1189,7 +1190,7 @@ static irqreturn_t ipwireless_handle_v2_v3_interrupt(int irq,
 	acknowledge_pcmcia_interrupt(hw);
 
 	if (tx || rx)
-		tasklet_schedule(&hw->tasklet);
+		queue_work(system_bh_wq, &hw->work);
 	else if (!rx_repeat) {
 		if (hw->memreg_tx == &hw->memory_info_regs->memreg_tx_new) {
 			if (hw->serial_number_detected)
@@ -1635,7 +1636,7 @@ struct ipw_hardware *ipwireless_hardware_create(void)
 	INIT_LIST_HEAD(&hw->rx_queue);
 	INIT_LIST_HEAD(&hw->rx_pool);
 	spin_lock_init(&hw->lock);
-	tasklet_setup(&hw->tasklet, ipwireless_do_tasklet);
+	INIT_WORK(&hw->work, ipwireless_do_work);
 	INIT_WORK(&hw->work_rx, ipw_receive_data_work);
 	timer_setup(&hw->setup_timer, ipwireless_setup_timer, 0);
 
@@ -1703,7 +1704,7 @@ static void ipwireless_setup_timer(struct timer_list *t)
 			hw->to_setup = 1;
 			hw->tx_ready = 1;
 			spin_unlock_irqrestore(&hw->lock, flags);
-			tasklet_schedule(&hw->tasklet);
+			queue_work(system_bh_wq, &hw->work);
 		}
 
 		mod_timer(&hw->setup_timer,
diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 85667f709515..09e5fa1c56b6 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -50,6 +50,7 @@
 #define ATMEL_RTS_LOW_OFFSET	20
 
 #include <linux/serial_core.h>
+#include <linux/workqueue.h>
 
 #include "serial_mctrl_gpio.h"
 #include "atmel_serial.h"
@@ -134,8 +135,8 @@ struct atmel_uart_port {
 	dma_cookie_t			cookie_rx;
 	struct scatterlist		sg_tx;
 	struct scatterlist		sg_rx;
-	struct tasklet_struct	tasklet_rx;
-	struct tasklet_struct	tasklet_tx;
+	struct work_struct		work_rx;
+	struct work_struct		work_tx;
 	atomic_t		tasklet_shutdown;
 	unsigned int		irq_status_prev;
 	unsigned int		tx_len;
@@ -282,11 +283,11 @@ static bool atmel_use_fifo(struct uart_port *port)
 	return atmel_port->fifo_size;
 }
 
-static void atmel_tasklet_schedule(struct atmel_uart_port *atmel_port,
-				   struct tasklet_struct *t)
+static void atmel_queue_work(struct atmel_uart_port *atmel_port,
+				   struct work_struct *t)
 {
-	if (!atomic_read(&atmel_port->tasklet_shutdown))
-		tasklet_schedule(t);
+	if (!atomic_read(&atmel_port->work_shutdown))
+		queue_work(system_bh_wq, t);
 }
 
 /* Enable or disable the rs485 support */
@@ -821,11 +822,11 @@ static void atmel_rx_chars(struct uart_port *port)
 		status = atmel_uart_readl(port, ATMEL_US_CSR);
 	}
 
-	atmel_tasklet_schedule(atmel_port, &atmel_port->tasklet_rx);
+	atmel_queue_work(atmel_port, &atmel_port->work_rx);
 }
 
 /*
- * Transmit characters (called from tasklet with TXRDY interrupt
+ * Transmit characters (called from workqueue with TXRDY interrupt
  * disabled)
  */
 static void atmel_tx_chars(struct uart_port *port)
@@ -882,7 +883,7 @@ static void atmel_complete_tx_dma(void *arg)
 	 * remaining data from the beginning of xmit->buf to xmit->head.
 	 */
 	if (!uart_circ_empty(xmit))
-		atmel_tasklet_schedule(atmel_port, &atmel_port->tasklet_tx);
+		atmel_queue_work(atmel_port, &atmel_port->work_tx);
 	else if (atmel_uart_is_half_duplex(port)) {
 		/*
 		 * DMA done, re-enable TXEMPTY and signal that we can stop
@@ -914,7 +915,7 @@ static void atmel_release_tx_dma(struct uart_port *port)
 }
 
 /*
- * Called from tasklet with TXRDY interrupt is disabled.
+ * Called from workqueue with TXRDY interrupt is disabled.
  */
 static void atmel_tx_dma(struct uart_port *port)
 {
@@ -1082,7 +1083,7 @@ static void atmel_complete_rx_dma(void *arg)
 	struct uart_port *port = arg;
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
 
-	atmel_tasklet_schedule(atmel_port, &atmel_port->tasklet_rx);
+	atmel_queue_work(atmel_port, &atmel_port->work_rx);
 }
 
 static void atmel_release_rx_dma(struct uart_port *port)
@@ -1118,11 +1119,11 @@ static void atmel_rx_from_dma(struct uart_port *port)
 	dmastat = dmaengine_tx_status(chan,
 				atmel_port->cookie_rx,
 				&state);
-	/* Restart a new tasklet if DMA status is error */
+	/* Queue a new work if DMA status is error */
 	if (dmastat == DMA_ERROR) {
-		dev_dbg(port->dev, "Get residue error, restart tasklet\n");
+		dev_dbg(port->dev, "Get residue error, restart work\n");
 		atmel_uart_writel(port, ATMEL_US_IER, ATMEL_US_TIMEOUT);
-		atmel_tasklet_schedule(atmel_port, &atmel_port->tasklet_rx);
+		atmel_queue_work(atmel_port, &atmel_port->work_rx);
 		return;
 	}
 
@@ -1288,7 +1289,7 @@ static void atmel_uart_timer_callback(struct timer_list *t)
 	struct uart_port *port = &atmel_port->uart;
 
 	if (!atomic_read(&atmel_port->tasklet_shutdown)) {
-		tasklet_schedule(&atmel_port->tasklet_rx);
+		queue_work(system_bh_wq, &atmel_port->tasklet_rx);
 		mod_timer(&atmel_port->uart_timer,
 			  jiffies + uart_poll_timeout(port));
 	}
@@ -1304,7 +1305,7 @@ atmel_handle_receive(struct uart_port *port, unsigned int pending)
 
 	if (atmel_use_pdc_rx(port)) {
 		/*
-		 * PDC receive. Just schedule the tasklet and let it
+		 * PDC receive. Just schedule the task and let it
 		 * figure out the details.
 		 *
 		 * TODO: We're not handling error flags correctly at
@@ -1313,8 +1314,8 @@ atmel_handle_receive(struct uart_port *port, unsigned int pending)
 		if (pending & (ATMEL_US_ENDRX | ATMEL_US_TIMEOUT)) {
 			atmel_uart_writel(port, ATMEL_US_IDR,
 					  (ATMEL_US_ENDRX | ATMEL_US_TIMEOUT));
-			atmel_tasklet_schedule(atmel_port,
-					       &atmel_port->tasklet_rx);
+			atmel_queue_work(atmel_port,
+					       &atmel_port->work_rx);
 		}
 
 		if (pending & (ATMEL_US_RXBRK | ATMEL_US_OVRE |
@@ -1326,8 +1327,8 @@ atmel_handle_receive(struct uart_port *port, unsigned int pending)
 		if (pending & ATMEL_US_TIMEOUT) {
 			atmel_uart_writel(port, ATMEL_US_IDR,
 					  ATMEL_US_TIMEOUT);
-			atmel_tasklet_schedule(atmel_port,
-					       &atmel_port->tasklet_rx);
+			atmel_queue_work(atmel_port,
+					       &atmel_port->work_rx);
 		}
 	}
 
@@ -1367,7 +1368,7 @@ atmel_handle_transmit(struct uart_port *port, unsigned int pending)
 			atmel_start_rx(port);
 		}
 
-		atmel_tasklet_schedule(atmel_port, &atmel_port->tasklet_tx);
+		atmel_queue_work(atmel_port, &atmel_port->work_tx);
 	}
 }
 
@@ -1454,7 +1455,7 @@ static void atmel_release_tx_pdc(struct uart_port *port)
 }
 
 /*
- * Called from tasklet with ENDTX and TXBUFE interrupts disabled.
+ * Called from workqueue with ENDTX and TXBUFE interrupts disabled.
  */
 static void atmel_tx_pdc(struct uart_port *port)
 {
@@ -1710,12 +1711,12 @@ static int atmel_prepare_rx_pdc(struct uart_port *port)
 }
 
 /*
- * tasklet handling tty stuff outside the interrupt handler.
+ * task handling tty stuff outside the interrupt handler.
  */
-static void atmel_tasklet_rx_func(struct tasklet_struct *t)
+static void atmel_work_rx_func(struct work_struct *t)
 {
-	struct atmel_uart_port *atmel_port = from_tasklet(atmel_port, t,
-							  tasklet_rx);
+	struct atmel_uart_port *atmel_port = from_work(atmel_port, t,
+							  work_rx);
 	struct uart_port *port = &atmel_port->uart;
 
 	/* The interrupt handler does not take the lock */
@@ -1724,10 +1725,10 @@ static void atmel_tasklet_rx_func(struct tasklet_struct *t)
 	uart_port_unlock(port);
 }
 
-static void atmel_tasklet_tx_func(struct tasklet_struct *t)
+static void atmel_work_tx_func(struct work_struct *t)
 {
-	struct atmel_uart_port *atmel_port = from_tasklet(atmel_port, t,
-							  tasklet_tx);
+	struct atmel_uart_port *atmel_port = from_work(atmel_port, t,
+							  work_tx);
 	struct uart_port *port = &atmel_port->uart;
 
 	/* The interrupt handler does not take the lock */
@@ -1906,8 +1907,8 @@ static int atmel_startup(struct uart_port *port)
 	}
 
 	atomic_set(&atmel_port->tasklet_shutdown, 0);
-	tasklet_setup(&atmel_port->tasklet_rx, atmel_tasklet_rx_func);
-	tasklet_setup(&atmel_port->tasklet_tx, atmel_tasklet_tx_func);
+	INIT_WORK(&atmel_port->tasklet_rx, atmel_work_rx_func);
+	INIT_WORK(&atmel_port->tasklet_tx, atmel_work_tx_func);
 
 	/*
 	 * Initialize DMA (if necessary)
@@ -1953,7 +1954,7 @@ static int atmel_startup(struct uart_port *port)
 		atmel_uart_writel(port, ATMEL_US_FMR, fmr);
 	}
 
-	/* Save current CSR for comparison in atmel_tasklet_func() */
+	/* Save current CSR for comparison in atmel_work_func() */
 	atmel_port->irq_status_prev = atmel_uart_readl(port, ATMEL_US_CSR);
 
 	/*
@@ -2036,11 +2037,11 @@ static void atmel_shutdown(struct uart_port *port)
 	/* Disable interrupts at device level */
 	atmel_uart_writel(port, ATMEL_US_IDR, -1);
 
-	/* Prevent spurious interrupts from scheduling the tasklet */
+	/* Prevent spurious interrupts from scheduling the task */
 	atomic_inc(&atmel_port->tasklet_shutdown);
 
 	/*
-	 * Prevent any tasklets being scheduled during
+	 * Prevent any tasks being scheduled during
 	 * cleanup
 	 */
 	del_timer_sync(&atmel_port->uart_timer);
@@ -2049,11 +2050,11 @@ static void atmel_shutdown(struct uart_port *port)
 	synchronize_irq(port->irq);
 
 	/*
-	 * Clear out any scheduled tasklets before
+	 * Clear out any scheduled tasks before
 	 * we destroy the buffers
 	 */
-	tasklet_kill(&atmel_port->tasklet_rx);
-	tasklet_kill(&atmel_port->tasklet_tx);
+	cancel_work_sync(&atmel_port->work_rx);
+	cancel_work_sync(&atmel_port->work_tx);
 
 	/*
 	 * Ensure everything is stopped and
@@ -3014,8 +3015,8 @@ static void atmel_serial_remove(struct platform_device *pdev)
 	struct uart_port *port = platform_get_drvdata(pdev);
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
 
-	tasklet_kill(&atmel_port->tasklet_rx);
-	tasklet_kill(&atmel_port->tasklet_tx);
+	cancel_work_sync(&atmel_port->tasklet_rx);
+	cancel_work_sync(&atmel_port->tasklet_tx);
 
 	device_init_wakeup(&pdev->dev, 0);
 
diff --git a/drivers/tty/serial/timbuart.c b/drivers/tty/serial/timbuart.c
index 4bc89a9b380a..7ac55e35e061 100644
--- a/drivers/tty/serial/timbuart.c
+++ b/drivers/tty/serial/timbuart.c
@@ -18,12 +18,13 @@
 #include <linux/ioport.h>
 #include <linux/slab.h>
 #include <linux/module.h>
+#include <linux/workqueue.h>
 
 #include "timbuart.h"
 
 struct timbuart_port {
 	struct uart_port	port;
-	struct tasklet_struct	tasklet;
+	struct work_struct	work;
 	int			usedma;
 	u32			last_ier;
 	struct platform_device  *dev;
@@ -55,8 +56,8 @@ static void timbuart_start_tx(struct uart_port *port)
 	struct timbuart_port *uart =
 		container_of(port, struct timbuart_port, port);
 
-	/* do not transfer anything here -> fire off the tasklet */
-	tasklet_schedule(&uart->tasklet);
+	/* do not transfer anything here -> fire off the task */
+	queue_work(system_bh_wq, &uart->work);
 }
 
 static unsigned int timbuart_tx_empty(struct uart_port *port)
@@ -169,9 +170,9 @@ static void timbuart_handle_rx_port(struct uart_port *port, u32 isr, u32 *ier)
 	dev_dbg(port->dev, "%s - leaving\n", __func__);
 }
 
-static void timbuart_tasklet(struct tasklet_struct *t)
+static void timbuart_work(struct work_struct *t)
 {
-	struct timbuart_port *uart = from_tasklet(uart, t, tasklet);
+	struct timbuart_port *uart = from_work(uart, t, work);
 	u32 isr, ier = 0;
 
 	uart_port_lock(&uart->port);
@@ -350,11 +351,11 @@ static irqreturn_t timbuart_handleinterrupt(int irq, void *devid)
 	if (ioread8(uart->port.membase + TIMBUART_IPR)) {
 		uart->last_ier = ioread32(uart->port.membase + TIMBUART_IER);
 
-		/* disable interrupts, the tasklet enables them again */
+		/* disable interrupts, the task enables them again */
 		iowrite32(0, uart->port.membase + TIMBUART_IER);
 
 		/* fire off bottom half */
-		tasklet_schedule(&uart->tasklet);
+		queue_work(system_bh_wq, &uart->work);
 
 		return IRQ_HANDLED;
 	} else
@@ -448,7 +449,7 @@ static int timbuart_probe(struct platform_device *dev)
 	}
 	uart->port.irq = irq;
 
-	tasklet_setup(&uart->tasklet, timbuart_tasklet);
+	INIT_WORK(&uart->work, timbuart_work);
 
 	err = uart_register_driver(&timbuart_driver);
 	if (err)
@@ -477,7 +478,7 @@ static void timbuart_remove(struct platform_device *dev)
 {
 	struct timbuart_port *uart = platform_get_drvdata(dev);
 
-	tasklet_kill(&uart->tasklet);
+	cancel_work_sync(&uart->work);
 	uart_remove_one_port(&timbuart_driver, &uart->port);
 	uart_unregister_driver(&timbuart_driver);
 	kfree(uart);
diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index a2116e135a82..81943bed2063 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -46,6 +46,7 @@
 #include <linux/tty.h>
 #include <linux/uaccess.h>
 #include <linux/vt_kern.h>
+#include <linux/workqueue.h>
 
 #include <asm/irq_regs.h>
 
@@ -131,8 +132,8 @@ static const unsigned char max_vals[] = {
 
 static const int NR_TYPES = ARRAY_SIZE(max_vals);
 
-static void kbd_bh(struct tasklet_struct *unused);
-static DECLARE_TASKLET_DISABLED(keyboard_tasklet, kbd_bh);
+static void kbd_bh(struct work_struct *unused);
+static DECLARE_WORK(keyboard_work, kbd_bh);
 
 static struct input_handler kbd_handler;
 static DEFINE_SPINLOCK(kbd_event_lock);
@@ -379,7 +380,7 @@ static void to_utf8(struct vc_data *vc, uint c)
 /* FIXME: review locking for vt.c callers */
 static void set_leds(void)
 {
-	tasklet_schedule(&keyboard_tasklet);
+	queue_work(system_bh_wq, &keyboard_work);
 }
 
 /*
@@ -1031,12 +1032,12 @@ static int kbd_led_trigger_activate(struct led_classdev *cdev)
 	struct kbd_led_trigger *trigger =
 		container_of(cdev->trigger, struct kbd_led_trigger, trigger);
 
-	tasklet_disable(&keyboard_tasklet);
+	disable_work_sync(&keyboard_work);
 	if (ledstate != -1U)
 		led_trigger_event(&trigger->trigger,
 				  ledstate & trigger->mask ?
 					LED_FULL : LED_OFF);
-	tasklet_enable(&keyboard_tasklet);
+	enable_and_queue_work(system_bh_wq, &keyboard_work);
 
 	return 0;
 }
@@ -1247,12 +1248,13 @@ void vt_kbd_con_stop(unsigned int console)
 }
 
 /*
- * This is the tasklet that updates LED state of LEDs using standard
- * keyboard triggers. The reason we use tasklet is that we need to
- * handle the scenario when keyboard handler is not registered yet
- * but we already getting updates from the VT to update led state.
+ * This is the task that updates LED state of LEDs using standard
+ * keyboard triggers. The reason we use workqueue is that we need
+ * to handle the scenario when keyboard handler is not registered
+ * yet but we already getting updates from the VT to update led
+ * state.
  */
-static void kbd_bh(struct tasklet_struct *unused)
+static void kbd_bh(struct work_struct *unused)
 {
 	unsigned int leds;
 	unsigned long flags;
@@ -1544,7 +1546,7 @@ static void kbd_event(struct input_handle *handle, unsigned int event_type,
 
 	spin_unlock(&kbd_event_lock);
 
-	tasklet_schedule(&keyboard_tasklet);
+	queue_work(system_bh_wq, &keyboard_work);
 	do_poke_blanked_console = 1;
 	schedule_console_callback();
 }
@@ -1616,12 +1618,12 @@ static void kbd_disconnect(struct input_handle *handle)
  */
 static void kbd_start(struct input_handle *handle)
 {
-	tasklet_disable(&keyboard_tasklet);
+	disable_work_sync(&keyboard_work);
 
 	if (ledstate != -1U)
 		kbd_update_leds_helper(handle, &ledstate);
 
-	tasklet_enable(&keyboard_tasklet);
+	enable_and_queue_work(system_bh_wq, &keyboard_work);
 }
 
 static const struct input_device_id kbd_ids[] = {
@@ -1671,8 +1673,8 @@ int __init kbd_init(void)
 	if (error)
 		return error;
 
-	tasklet_enable(&keyboard_tasklet);
-	tasklet_schedule(&keyboard_tasklet);
+	enable_and_queue_work(system_bh_wq, &keyboard_work);
+	queue_work(system_bh_wq, &keyboard_work);
 
 	return 0;
 }
@@ -2233,7 +2235,7 @@ void vt_reset_keyboard(unsigned int console)
 	kb->ledmode = LED_SHOW_FLAGS;
 	kb->ledflagstate = kb->default_ledflagstate;
 	spin_unlock(&led_lock);
-	/* do not do set_leds here because this causes an endless tasklet loop
+	/* do not do set_leds here because this causes an endless loop
 	   when the keyboard hasn't been initialized yet */
 	spin_unlock_irqrestore(&kbd_event_lock, flags);
 }
-- 
2.17.1


