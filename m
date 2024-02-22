Return-Path: <linux-kernel+bounces-77252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D673186029A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 133111C2496F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7096548E6;
	Thu, 22 Feb 2024 19:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m/Jss5I8"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90471E874
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 19:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708629827; cv=none; b=EJ3TJ5GkHv63Qxy/vQCEFX2+d9AYvAIWOb0is5OTNriv158u/zRfTJtXhwhsRVTiDY4cOeTrqrCYlfT7/0JdC3mtPeGt59FGky6pdSd84tksZuwmnZ7evLuXXKFaKWIgX9OAkfbe69DymOguxc/QoapiUBMnrZAJd8d2fCMfW4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708629827; c=relaxed/simple;
	bh=gKo/P0bQL66mpMQ285UxKp7suX6+SFfQgZr5WjHyN6A=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=r6L1BDb/q5879J7ASrmO1jAJWam9UNNhLSTcGWFXnBELXOGfsJuz2LumHXvpgE1t3igw4plGT6VczKpPftTCn5lbuzYrbdgnQKYntptlngsyhCnX17a0aR+jenvEAGkOrytKoa/iLfun9tHK4DG8ZpI7S8yXaXvRH6g8tpLl3Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pcc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m/Jss5I8; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pcc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6089b90acddso1462577b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 11:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708629825; x=1709234625; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Rcd3xiyDExY5/l4KiLEuLxdganpWypINeNzRdzc4lE8=;
        b=m/Jss5I8tdKFsnqT4oR2aaXw48zt3OEtg9w+TZuc9gkUSa5NPh6qdpfxmm/FgonM4C
         uMqoAPQ9Nq6lZ3ix/z7X0dHNhvecmuKqci/aeQlr8YGcz7GR1a2E38dkZZAyeo+/7ooL
         tHAaqOdljmow4OuHap5yJs6uh9OooONEVRlDOUWm+aK/DnIGXBWO7lmQAVzUuarr7IFH
         8mNikNNNhcxjFihEWZF8N9NMiSBRCrlIjfDpOvUho3kfbHjaZuJGc5RLU1CP+PI/jM9d
         DDiZrUoZ+XEAZqXZMl1EocbHO+uNuSCFRpMQO1gTlsxDqadpXfl5d28/RTuyUtok3mb9
         51oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708629825; x=1709234625;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rcd3xiyDExY5/l4KiLEuLxdganpWypINeNzRdzc4lE8=;
        b=C51zpjZmplFY0maAbZJ25WP3AYI7J1mPacnMDx3svMpMh0r//kmyq4oP2Syfyezoiu
         qVEvLvyQAoPanIKfLIRVRDupuJu/SmuiLm9nnSs3uXYr1JyAQZZGLiU0fnX08Q0sBNwh
         RszVoWXnMZbdN5WN9oYOLpBevZHoJ3TQuSJ/7rrLrKrfx3T5Xh0tV4jteNcMHk2/hLPN
         Ti2KUQ+KZmZEhE1p9v9TtAaIljo6T9AKFxJG8M3NJvKGanrAJAM/dnB3dLtyekEl0DkS
         qqgNrcgXSNuiNq3noFlY14+QIB9BXu1emDn4P3piSPGKsb1YbesLAj0wWgVeXYy1YXl0
         J7kw==
X-Forwarded-Encrypted: i=1; AJvYcCWTOGNDPxvmsunw/MbBtgn8oQ37kf4jbkJYzn6WgE31Dl5+hEw1xVHS81kAaiNC6rRhY4bLF9X3qCCgbfKcOO9mRnZWA40tAbN88pB8
X-Gm-Message-State: AOJu0Yz7O+PRjkzfbW7807eAdfUobwjrX+Bpp0BwiBNWA8jkFla0XTmb
	ZDLMfXwcYgizpSGlEUxfMYb99Qqwaq1fudQFz4XLigGPXSWxNEr5mXCFTTFnFLfeKQ==
X-Google-Smtp-Source: AGHT+IHzo0vV16bgCE5M3R2Na6hfj983quOy6yIVGG4Q5IoKGE0CF3K5gfQ3L9X52uStrwORe3dfl2c=
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2d3:205:26c7:da00:ce0c:dbd5])
 (user=pcc job=sendgmr) by 2002:a81:4ecd:0:b0:607:c633:2997 with SMTP id
 c196-20020a814ecd000000b00607c6332997mr24485ywb.5.1708629824985; Thu, 22 Feb
 2024 11:23:44 -0800 (PST)
Date: Thu, 22 Feb 2024 11:23:28 -0800
Message-Id: <20240222192329.1047386-1-pcc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Subject: [PATCH] serial: Lock console when calling into driver before registration
From: Peter Collingbourne <pcc@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	John Ogness <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Peter Collingbourne <pcc@google.com>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

During the handoff from earlycon to the real console driver, we have
two separate drivers operating on the same device concurrently. In the
case of the 8250 driver these concurrent accesses cause problems due
to the driver's use of banked registers, controlled by LCR.DLAB. It is
possible for the setup(), config_port(), pm() and set_mctrl() callbacks
to set DLAB, which can cause the earlycon code that intends to access
TX to instead access DLL, leading to missed output and corruption on
the serial line due to unintended modifications to the baud rate.

In particular, for setup() we have:

univ8250_console_setup()
-> serial8250_console_setup()
-> uart_set_options()
-> serial8250_set_termios()
-> serial8250_do_set_termios()
-> serial8250_do_set_divisor()

For config_port() we have:

serial8250_config_port()
-> autoconfig()

For pm() we have:

serial8250_pm()
-> serial8250_do_pm()
-> serial8250_set_sleep()

For set_mctrl() we have (for some devices):

serial8250_set_mctrl()
-> omap8250_set_mctrl()
-> __omap8250_set_mctrl()

To avoid such problems, let's make it so that the console is locked
during pre-registration calls to these callbacks, which will prevent
the earlycon driver from running concurrently.

Remove the partial solution to this problem in the 8250 driver
that locked the console only during autoconfig_irq(), as this would
result in a deadlock with the new approach. The console continues
to be locked during autoconfig_irq() because it can only be called
through uart_configure_port().

Although this patch introduces more locking than strictly necessary
(and in particular it also locks during the call to rs485_config()
which is not affected by this issue as far as I can tell), it follows
the principle that it is the responsibility of the generic console
code to manage the earlycon handoff by ensuring that earlycon and real
console driver code cannot run concurrently, and not the individual
drivers.

Signed-off-by: Peter Collingbourne <pcc@google.com>
Link: https://linux-review.googlesource.com/id/I7cf8124dcebf8618e6b2ee543fa5b25532de55d8
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
---
 drivers/tty/serial/8250/8250_port.c |  6 ------
 drivers/tty/serial/serial_core.c    | 10 ++++++++++
 kernel/printk/printk.c              | 20 +++++++++++++++++---
 3 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 8ca061d3bbb9..1d65055dde27 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1329,9 +1329,6 @@ static void autoconfig_irq(struct uart_8250_port *up)
 		inb_p(ICP);
 	}
 
-	if (uart_console(port))
-		console_lock();
-
 	/* forget possible initially masked and pending IRQ */
 	probe_irq_off(probe_irq_on());
 	save_mcr = serial8250_in_MCR(up);
@@ -1371,9 +1368,6 @@ static void autoconfig_irq(struct uart_8250_port *up)
 	if (port->flags & UPF_FOURPORT)
 		outb_p(save_ICP, ICP);
 
-	if (uart_console(port))
-		console_unlock();
-
 	port->irq = (irq > 0) ? irq : 0;
 }
 
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index d6a58a9e072a..128aa0e0ae24 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2608,7 +2608,11 @@ uart_configure_port(struct uart_driver *drv, struct uart_state *state,
 			port->type = PORT_UNKNOWN;
 			flags |= UART_CONFIG_TYPE;
 		}
+		if (uart_console(port))
+			console_lock();
 		port->ops->config_port(port, flags);
+		if (uart_console(port))
+			console_unlock();
 	}
 
 	if (port->type != PORT_UNKNOWN) {
@@ -2616,6 +2620,9 @@ uart_configure_port(struct uart_driver *drv, struct uart_state *state,
 
 		uart_report_port(drv, port);
 
+		if (uart_console(port))
+			console_lock();
+
 		/* Power up port for set_mctrl() */
 		uart_change_pm(state, UART_PM_STATE_ON);
 
@@ -2632,6 +2639,9 @@ uart_configure_port(struct uart_driver *drv, struct uart_state *state,
 
 		uart_rs485_config(port);
 
+		if (uart_console(port))
+			console_unlock();
+
 		/*
 		 * If this driver supports console, and it hasn't been
 		 * successfully registered yet, try to re-register it.
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index f2444b581e16..db69545e6250 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3263,6 +3263,20 @@ static int __init keep_bootcon_setup(char *str)
 
 early_param("keep_bootcon", keep_bootcon_setup);
 
+static int console_call_setup(struct console *newcon, char *options)
+{
+	int err;
+
+	if (!newcon->setup)
+		return 0;
+
+	console_lock();
+	err = newcon->setup(newcon, options);
+	console_unlock();
+
+	return err;
+}
+
 /*
  * This is called by register_console() to try to match
  * the newly registered console with any of the ones selected
@@ -3298,8 +3312,8 @@ static int try_enable_preferred_console(struct console *newcon,
 			if (_braille_register_console(newcon, c))
 				return 0;
 
-			if (newcon->setup &&
-			    (err = newcon->setup(newcon, c->options)) != 0)
+			err = console_call_setup(newcon, c->options);
+			if (err != 0)
 				return err;
 		}
 		newcon->flags |= CON_ENABLED;
@@ -3325,7 +3339,7 @@ static void try_enable_default_console(struct console *newcon)
 	if (newcon->index < 0)
 		newcon->index = 0;
 
-	if (newcon->setup && newcon->setup(newcon, NULL) != 0)
+	if (console_call_setup(newcon, NULL) != 0)
 		return;
 
 	newcon->flags |= CON_ENABLED;
-- 
2.44.0.rc1.240.g4c46232300-goog


