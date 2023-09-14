Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D38747A0D47
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242011AbjINSmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242002AbjINSj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:39:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB585271F;
        Thu, 14 Sep 2023 11:39:04 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694716743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+c8y3mlqvYbhVAUPi/vCATaSfboaR23i1Jls/9e1aPg=;
        b=Q681URTXCotnINxNsfU6XBYt6o0sruv6ZRxfFKZDlOJZUE1kstHevpliVOdpphOxGJ2uOs
        W0eLSK+EM61uowY9acpG0ezSua0bWlyO8jHgFicVk5SsB/7dAIr32VUcHuA9Lb/7pDB8oA
        fwaorOtNBNY1XJl8K3WaOP1+q4exjIMphMggX7wlKIRHYbb+fzK2K8FAVIKO/CxFxXL7+R
        jtx5jU7tH12Vl6jHU0eiAMIBjtfYn/3fGvXf76dPr7hBRx5CXWEkeQHM7qP4jcunb00L5I
        m53H5XyoUco7+6cUPFriXnBt+y/JjNZOA4O4i85FX5u2U8HSHgxBeJDt4hHLzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694716743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+c8y3mlqvYbhVAUPi/vCATaSfboaR23i1Jls/9e1aPg=;
        b=oBmFRAFo6f9CalCedMFjJJUCCnHj86cDkknErjH64gqJGpKTameG0KfjSs+fpostkVlTPA
        jwr2NDsLNTzbd8Dg==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Tony Lindgren <tony@atomide.com>,
        Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH tty v1 57/74] serial: core: Use port lock wrappers
Date:   Thu, 14 Sep 2023 20:44:14 +0206
Message-Id: <20230914183831.587273-58-john.ogness@linutronix.de>
In-Reply-To: <20230914183831.587273-1-john.ogness@linutronix.de>
References: <20230914183831.587273-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

When a serial port is used for kernel console output, then all
modifications to the UART registers which are done from other contexts,
e.g. getty, termios, are interference points for the kernel console.

So far this has been ignored and the printk output is based on the
principle of hope. The rework of the console infrastructure which aims to
support threaded and atomic consoles, requires to mark sections which
modify the UART registers as unsafe. This allows the atomic write function
to make informed decisions and eventually to restore operational state. It
also allows to prevent the regular UART code from modifying UART registers
while printk output is in progress.

All modifications of UART registers are guarded by the UART port lock,
which provides an obvious synchronization point with the console
infrastructure.

To avoid adding this functionality to all UART drivers, wrap the
spin_[un]lock*() invocations for uart_port::lock into helper functions
which just contain the spin_[un]lock*() invocations for now. In a
subsequent step these helpers will gain the console synchronization
mechanisms.

Converted with coccinelle. No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/tty/serial/serial_core.c | 88 ++++++++++++++++----------------
 drivers/tty/serial/serial_port.c |  4 +-
 2 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 7bdc21d5e13b..b32bbd7aa3d3 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -79,7 +79,7 @@ static inline void uart_port_deref(struct uart_port *uport)
 	({								\
 		struct uart_port *__uport = uart_port_ref(state);	\
 		if (__uport)						\
-			spin_lock_irqsave(&__uport->lock, flags);	\
+			uart_port_lock_irqsave(__uport, &flags);	\
 		__uport;						\
 	})
 
@@ -87,7 +87,7 @@ static inline void uart_port_deref(struct uart_port *uport)
 	({								\
 		struct uart_port *__uport = uport;			\
 		if (__uport) {						\
-			spin_unlock_irqrestore(&__uport->lock, flags);	\
+			uart_port_unlock_irqrestore(__uport, flags);	\
 			uart_port_deref(__uport);			\
 		}							\
 	})
@@ -179,12 +179,12 @@ uart_update_mctrl(struct uart_port *port, unsigned int set, unsigned int clear)
 	unsigned long flags;
 	unsigned int old;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 	old = port->mctrl;
 	port->mctrl = (old & ~clear) | set;
 	if (old != port->mctrl && !(port->rs485.flags & SER_RS485_ENABLED))
 		port->ops->set_mctrl(port, port->mctrl);
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 #define uart_set_mctrl(port, set)	uart_update_mctrl(port, set, 0)
@@ -219,7 +219,7 @@ static void uart_change_line_settings(struct tty_struct *tty, struct uart_state
 	/*
 	 * Set modem status enables based on termios cflag
 	 */
-	spin_lock_irq(&uport->lock);
+	uart_port_lock_irq(uport);
 	if (termios->c_cflag & CRTSCTS)
 		uport->status |= UPSTAT_CTS_ENABLE;
 	else
@@ -240,7 +240,7 @@ static void uart_change_line_settings(struct tty_struct *tty, struct uart_state
 		else
 			__uart_start(state);
 	}
-	spin_unlock_irq(&uport->lock);
+	uart_port_unlock_irq(uport);
 }
 
 /*
@@ -702,11 +702,11 @@ static void uart_send_xchar(struct tty_struct *tty, char ch)
 	if (port->ops->send_xchar)
 		port->ops->send_xchar(port, ch);
 	else {
-		spin_lock_irqsave(&port->lock, flags);
+		uart_port_lock_irqsave(port, &flags);
 		port->x_char = ch;
 		if (ch)
 			port->ops->start_tx(port);
-		spin_unlock_irqrestore(&port->lock, flags);
+		uart_port_unlock_irqrestore(port, flags);
 	}
 	uart_port_deref(port);
 }
@@ -1085,9 +1085,9 @@ static int uart_tiocmget(struct tty_struct *tty)
 
 	if (!tty_io_error(tty)) {
 		result = uport->mctrl;
-		spin_lock_irq(&uport->lock);
+		uart_port_lock_irq(uport);
 		result |= uport->ops->get_mctrl(uport);
-		spin_unlock_irq(&uport->lock);
+		uart_port_unlock_irq(uport);
 	}
 out:
 	mutex_unlock(&port->mutex);
@@ -1223,16 +1223,16 @@ static int uart_wait_modem_status(struct uart_state *state, unsigned long arg)
 	uport = uart_port_ref(state);
 	if (!uport)
 		return -EIO;
-	spin_lock_irq(&uport->lock);
+	uart_port_lock_irq(uport);
 	memcpy(&cprev, &uport->icount, sizeof(struct uart_icount));
 	uart_enable_ms(uport);
-	spin_unlock_irq(&uport->lock);
+	uart_port_unlock_irq(uport);
 
 	add_wait_queue(&port->delta_msr_wait, &wait);
 	for (;;) {
-		spin_lock_irq(&uport->lock);
+		uart_port_lock_irq(uport);
 		memcpy(&cnow, &uport->icount, sizeof(struct uart_icount));
-		spin_unlock_irq(&uport->lock);
+		uart_port_unlock_irq(uport);
 
 		set_current_state(TASK_INTERRUPTIBLE);
 
@@ -1277,9 +1277,9 @@ static int uart_get_icount(struct tty_struct *tty,
 	uport = uart_port_ref(state);
 	if (!uport)
 		return -EIO;
-	spin_lock_irq(&uport->lock);
+	uart_port_lock_irq(uport);
 	memcpy(&cnow, &uport->icount, sizeof(struct uart_icount));
-	spin_unlock_irq(&uport->lock);
+	uart_port_unlock_irq(uport);
 	uart_port_deref(uport);
 
 	icount->cts         = cnow.cts;
@@ -1422,9 +1422,9 @@ static int uart_get_rs485_config(struct uart_port *port,
 	unsigned long flags;
 	struct serial_rs485 aux;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 	aux = port->rs485;
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	if (copy_to_user(rs485, &aux, sizeof(aux)))
 		return -EFAULT;
@@ -1451,7 +1451,7 @@ static int uart_set_rs485_config(struct tty_struct *tty, struct uart_port *port,
 	uart_sanitize_serial_rs485(port, &rs485);
 	uart_set_rs485_termination(port, &rs485);
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 	ret = port->rs485_config(port, &tty->termios, &rs485);
 	if (!ret) {
 		port->rs485 = rs485;
@@ -1460,7 +1460,7 @@ static int uart_set_rs485_config(struct tty_struct *tty, struct uart_port *port,
 		if (!(rs485.flags & SER_RS485_ENABLED))
 			port->ops->set_mctrl(port, port->mctrl);
 	}
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 	if (ret)
 		return ret;
 
@@ -1479,9 +1479,9 @@ static int uart_get_iso7816_config(struct uart_port *port,
 	if (!port->iso7816_config)
 		return -ENOTTY;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 	aux = port->iso7816;
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	if (copy_to_user(iso7816, &aux, sizeof(aux)))
 		return -EFAULT;
@@ -1510,9 +1510,9 @@ static int uart_set_iso7816_config(struct uart_port *port,
 		if (iso7816.reserved[i])
 			return -EINVAL;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 	ret = port->iso7816_config(port, &iso7816);
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 	if (ret)
 		return ret;
 
@@ -1729,9 +1729,9 @@ static void uart_tty_port_shutdown(struct tty_port *port)
 	if (WARN(!uport, "detached port still initialized!\n"))
 		return;
 
-	spin_lock_irq(&uport->lock);
+	uart_port_lock_irq(uport);
 	uport->ops->stop_rx(uport);
-	spin_unlock_irq(&uport->lock);
+	uart_port_unlock_irq(uport);
 
 	uart_port_shutdown(port);
 
@@ -1745,10 +1745,10 @@ static void uart_tty_port_shutdown(struct tty_port *port)
 	/*
 	 * Free the transmit buffer.
 	 */
-	spin_lock_irq(&uport->lock);
+	uart_port_lock_irq(uport);
 	buf = state->xmit.buf;
 	state->xmit.buf = NULL;
-	spin_unlock_irq(&uport->lock);
+	uart_port_unlock_irq(uport);
 
 	free_page((unsigned long)buf);
 
@@ -1891,10 +1891,10 @@ static bool uart_carrier_raised(struct tty_port *port)
 	 */
 	if (WARN_ON(!uport))
 		return true;
-	spin_lock_irq(&uport->lock);
+	uart_port_lock_irq(uport);
 	uart_enable_ms(uport);
 	mctrl = uport->ops->get_mctrl(uport);
-	spin_unlock_irq(&uport->lock);
+	uart_port_unlock_irq(uport);
 	uart_port_deref(uport);
 
 	return mctrl & TIOCM_CAR;
@@ -2011,9 +2011,9 @@ static void uart_line_info(struct seq_file *m, struct uart_driver *drv, int i)
 		pm_state = state->pm_state;
 		if (pm_state != UART_PM_STATE_ON)
 			uart_change_pm(state, UART_PM_STATE_ON);
-		spin_lock_irq(&uport->lock);
+		uart_port_lock_irq(uport);
 		status = uport->ops->get_mctrl(uport);
-		spin_unlock_irq(&uport->lock);
+		uart_port_unlock_irq(uport);
 		if (pm_state != UART_PM_STATE_ON)
 			uart_change_pm(state, pm_state);
 
@@ -2352,9 +2352,9 @@ int uart_suspend_port(struct uart_driver *drv, struct uart_port *uport)
 	 */
 	if (!console_suspend_enabled && uart_console(uport)) {
 		if (uport->ops->start_rx) {
-			spin_lock_irq(&uport->lock);
+			uart_port_lock_irq(uport);
 			uport->ops->stop_rx(uport);
-			spin_unlock_irq(&uport->lock);
+			uart_port_unlock_irq(uport);
 		}
 		goto unlock;
 	}
@@ -2369,7 +2369,7 @@ int uart_suspend_port(struct uart_driver *drv, struct uart_port *uport)
 		tty_port_set_suspended(port, true);
 		tty_port_set_initialized(port, false);
 
-		spin_lock_irq(&uport->lock);
+		uart_port_lock_irq(uport);
 		ops->stop_tx(uport);
 		if (!(uport->rs485.flags & SER_RS485_ENABLED))
 			ops->set_mctrl(uport, 0);
@@ -2377,7 +2377,7 @@ int uart_suspend_port(struct uart_driver *drv, struct uart_port *uport)
 		mctrl = uport->mctrl;
 		uport->mctrl = 0;
 		ops->stop_rx(uport);
-		spin_unlock_irq(&uport->lock);
+		uart_port_unlock_irq(uport);
 
 		/*
 		 * Wait for the transmitter to empty.
@@ -2449,9 +2449,9 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
 			uart_change_pm(state, UART_PM_STATE_ON);
 		uport->ops->set_termios(uport, &termios, NULL);
 		if (!console_suspend_enabled && uport->ops->start_rx) {
-			spin_lock_irq(&uport->lock);
+			uart_port_lock_irq(uport);
 			uport->ops->start_rx(uport);
-			spin_unlock_irq(&uport->lock);
+			uart_port_unlock_irq(uport);
 		}
 		if (console_suspend_enabled)
 			console_start(uport->cons);
@@ -2462,10 +2462,10 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
 		int ret;
 
 		uart_change_pm(state, UART_PM_STATE_ON);
-		spin_lock_irq(&uport->lock);
+		uart_port_lock_irq(uport);
 		if (!(uport->rs485.flags & SER_RS485_ENABLED))
 			ops->set_mctrl(uport, 0);
-		spin_unlock_irq(&uport->lock);
+		uart_port_unlock_irq(uport);
 		if (console_suspend_enabled || !uart_console(uport)) {
 			/* Protected by port mutex for now */
 			struct tty_struct *tty = port->tty;
@@ -2474,13 +2474,13 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
 			if (ret == 0) {
 				if (tty)
 					uart_change_line_settings(tty, state, NULL);
-				spin_lock_irq(&uport->lock);
+				uart_port_lock_irq(uport);
 				if (!(uport->rs485.flags & SER_RS485_ENABLED))
 					ops->set_mctrl(uport, uport->mctrl);
 				else
 					uart_rs485_config(uport);
 				ops->start_tx(uport);
-				spin_unlock_irq(&uport->lock);
+				uart_port_unlock_irq(uport);
 				tty_port_set_initialized(port, true);
 			} else {
 				/*
@@ -2583,13 +2583,13 @@ uart_configure_port(struct uart_driver *drv, struct uart_state *state,
 		 * keep the DTR setting that is set in uart_set_options()
 		 * We probably don't need a spinlock around this, but
 		 */
-		spin_lock_irqsave(&port->lock, flags);
+		uart_port_lock_irqsave(port, &flags);
 		port->mctrl &= TIOCM_DTR;
 		if (!(port->rs485.flags & SER_RS485_ENABLED))
 			port->ops->set_mctrl(port, port->mctrl);
 		else
 			uart_rs485_config(port);
-		spin_unlock_irqrestore(&port->lock, flags);
+		uart_port_unlock_irqrestore(port, flags);
 
 		/*
 		 * If this driver supports console, and it hasn't been
diff --git a/drivers/tty/serial/serial_port.c b/drivers/tty/serial/serial_port.c
index 862423237007..88975a4df306 100644
--- a/drivers/tty/serial/serial_port.c
+++ b/drivers/tty/serial/serial_port.c
@@ -35,10 +35,10 @@ static int serial_port_runtime_resume(struct device *dev)
 		goto out;
 
 	/* Flush any pending TX for the port */
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 	if (__serial_port_busy(port))
 		port->ops->start_tx(port);
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 out:
 	pm_runtime_mark_last_busy(dev);
-- 
2.39.2

