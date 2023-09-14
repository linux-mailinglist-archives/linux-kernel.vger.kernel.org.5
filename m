Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89A4E7A0D10
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242005AbjINSj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241660AbjINSi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:38:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A9A2134;
        Thu, 14 Sep 2023 11:38:52 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694716731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T/Nah8LG2arspIXC5ZdMzJ+r6t3A3nzbfwJRMCSZSCk=;
        b=oxmPK29NQ4j8pd2D01o8mg+K0yOiMZnw2YnzETzatx1/wERmCu0FosstZcHkoJEyLFX0EF
        NBnn4iN/bJRAYchCphv/ylN5T85we5IOkHknSeQb4eK/Eyk6W6q7qqYGuh9lJVEZoUDcn9
        gf3F/rEY2Nbj6Hw1STCVl4kS7laZ5KCHpe3XUOlZdNyHPXtxhhOXiYBhimgDZESjHO3Vc6
        ZuKGsiuxPnZoU1TGmDqDiZZY5fQqK8joUj0zmdRPnTUnQvnJbQKk69LyIdJHMtVlIQCifm
        NJHlIqap/7M6DJNuRcbx7VLrLka0K47uqTPGEuUtbT58rBVVZb1bZy05hx2EBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694716731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T/Nah8LG2arspIXC5ZdMzJ+r6t3A3nzbfwJRMCSZSCk=;
        b=Ou4JXvI5/rF2X+xvNjTB7VuG7W/1UXFOV3B7seNGK+VIj2IC6C+6QxfRzjKVN/kAzeVGGR
        yu4a6caUgwydhoAg==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH tty v1 31/74] serial: jsm: Use port lock wrappers
Date:   Thu, 14 Sep 2023 20:43:48 +0206
Message-Id: <20230914183831.587273-32-john.ogness@linutronix.de>
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
 drivers/tty/serial/jsm/jsm_neo.c |  4 ++--
 drivers/tty/serial/jsm/jsm_tty.c | 16 ++++++++--------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/jsm/jsm_neo.c b/drivers/tty/serial/jsm/jsm_neo.c
index 0c78f66276cd..2bd640428970 100644
--- a/drivers/tty/serial/jsm/jsm_neo.c
+++ b/drivers/tty/serial/jsm/jsm_neo.c
@@ -816,9 +816,9 @@ static void neo_parse_isr(struct jsm_board *brd, u32 port)
 		/* Parse any modem signal changes */
 		jsm_dbg(INTR, &ch->ch_bd->pci_dev,
 			"MOD_STAT: sending to parse_modem_sigs\n");
-		spin_lock_irqsave(&ch->uart_port.lock, lock_flags);
+		uart_port_lock_irqsave(&ch->uart_port, &lock_flags);
 		neo_parse_modem(ch, readb(&ch->ch_neo_uart->msr));
-		spin_unlock_irqrestore(&ch->uart_port.lock, lock_flags);
+		uart_port_unlock_irqrestore(&ch->uart_port, lock_flags);
 	}
 }
 
diff --git a/drivers/tty/serial/jsm/jsm_tty.c b/drivers/tty/serial/jsm/jsm_tty.c
index 222afc270c88..ce0fef7e2c66 100644
--- a/drivers/tty/serial/jsm/jsm_tty.c
+++ b/drivers/tty/serial/jsm/jsm_tty.c
@@ -152,14 +152,14 @@ static void jsm_tty_send_xchar(struct uart_port *port, char ch)
 		container_of(port, struct jsm_channel, uart_port);
 	struct ktermios *termios;
 
-	spin_lock_irqsave(&port->lock, lock_flags);
+	uart_port_lock_irqsave(port, &lock_flags);
 	termios = &port->state->port.tty->termios;
 	if (ch == termios->c_cc[VSTART])
 		channel->ch_bd->bd_ops->send_start_character(channel);
 
 	if (ch == termios->c_cc[VSTOP])
 		channel->ch_bd->bd_ops->send_stop_character(channel);
-	spin_unlock_irqrestore(&port->lock, lock_flags);
+	uart_port_unlock_irqrestore(port, lock_flags);
 }
 
 static void jsm_tty_stop_rx(struct uart_port *port)
@@ -176,13 +176,13 @@ static void jsm_tty_break(struct uart_port *port, int break_state)
 	struct jsm_channel *channel =
 		container_of(port, struct jsm_channel, uart_port);
 
-	spin_lock_irqsave(&port->lock, lock_flags);
+	uart_port_lock_irqsave(port, &lock_flags);
 	if (break_state == -1)
 		channel->ch_bd->bd_ops->send_break(channel);
 	else
 		channel->ch_bd->bd_ops->clear_break(channel);
 
-	spin_unlock_irqrestore(&port->lock, lock_flags);
+	uart_port_unlock_irqrestore(port, lock_flags);
 }
 
 static int jsm_tty_open(struct uart_port *port)
@@ -241,7 +241,7 @@ static int jsm_tty_open(struct uart_port *port)
 	channel->ch_cached_lsr = 0;
 	channel->ch_stops_sent = 0;
 
-	spin_lock_irqsave(&port->lock, lock_flags);
+	uart_port_lock_irqsave(port, &lock_flags);
 	termios = &port->state->port.tty->termios;
 	channel->ch_c_cflag	= termios->c_cflag;
 	channel->ch_c_iflag	= termios->c_iflag;
@@ -261,7 +261,7 @@ static int jsm_tty_open(struct uart_port *port)
 	jsm_carrier(channel);
 
 	channel->ch_open_count++;
-	spin_unlock_irqrestore(&port->lock, lock_flags);
+	uart_port_unlock_irqrestore(port, lock_flags);
 
 	jsm_dbg(OPEN, &channel->ch_bd->pci_dev, "finish\n");
 	return 0;
@@ -307,7 +307,7 @@ static void jsm_tty_set_termios(struct uart_port *port,
 	struct jsm_channel *channel =
 		container_of(port, struct jsm_channel, uart_port);
 
-	spin_lock_irqsave(&port->lock, lock_flags);
+	uart_port_lock_irqsave(port, &lock_flags);
 	channel->ch_c_cflag	= termios->c_cflag;
 	channel->ch_c_iflag	= termios->c_iflag;
 	channel->ch_c_oflag	= termios->c_oflag;
@@ -317,7 +317,7 @@ static void jsm_tty_set_termios(struct uart_port *port,
 
 	channel->ch_bd->bd_ops->param(channel);
 	jsm_carrier(channel);
-	spin_unlock_irqrestore(&port->lock, lock_flags);
+	uart_port_unlock_irqrestore(port, lock_flags);
 }
 
 static const char *jsm_tty_type(struct uart_port *port)
-- 
2.39.2

