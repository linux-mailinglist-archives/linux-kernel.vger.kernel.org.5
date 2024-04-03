Return-Path: <linux-kernel+bounces-130285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FD7897726
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23646B2F2C6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39801156C42;
	Wed,  3 Apr 2024 17:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ApsnYwXF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDE4153566;
	Wed,  3 Apr 2024 17:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164642; cv=none; b=i1q7caSZH6TwOPZjWNI5nH/VuJbJjDJKX0Dh9200ZnuJEEscW4vfSobjk6oxtZwNoWD0/YbKVR/Ek4QZK7Lyw/aJQbmDx7OSW92CHDY4wBOag0P/RmpHbDvFpovK2eHKHIlSbhWsLd55o0yPohBDoZqGU3sYATuV2aatduCfl74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164642; c=relaxed/simple;
	bh=ndJUG13AxsRqCLAMfV020HMo0gLnUMLYmOet4DTZZMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uJUyHDN/vpm6+sOc3p75XUSlzQMBP6kWKgT7vu4NV5jkDUm9py200NxsdG08PH55OY+9xqmR4f57pLpLyKIl89uwAdMEaB2JYFp/e6KHo3pGyAeWlTo37I9RbmCpXQXSv524Xd49mN59YWwB4exXKrlQvw/qTvlhj1CgfbJhYhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ApsnYwXF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56200C43390;
	Wed,  3 Apr 2024 17:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712164642;
	bh=ndJUG13AxsRqCLAMfV020HMo0gLnUMLYmOet4DTZZMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ApsnYwXFtepbNOEPrShIAm7n+MZcYO1/7Yg0zYrfGBTkEG3rqE9Ui2UkHu66zWT/M
	 i9vwpU5SKCLUHtNozkoy5msBxg8G1pXzIY2KAk8PMeVDlw+PlT04SMyAJCfdm4+mi6
	 EBTkeaPP44/rTo16D7n/QOcyFs7F4NjMsE5EkwC5WD5RwmOePUCU5brJh+O5MIHKCm
	 U1TKjCZnimgyB6h+lKJu+JbbQK0VZmfNe9N3ofne+dLeFQQQHpfEMCpKl+yNGuV+s4
	 slYts/0ixcI0OudkMpoYqFbY2sMTc6+pE9QSa+q9WK+mi0LY89zUnnh7wCWJqvO0uE
	 /Wd2k4EwlnCvA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	jirislaby@kernel.org,
	andi.shyti@linux.intel.com,
	u.kleine-koenig@pengutronix.de,
	john.ogness@linutronix.de,
	florian.fainelli@broadcom.com,
	tony@atomide.com,
	tglx@linutronix.de,
	justin.chen@broadcom.com,
	fancer.lancer@gmail.com,
	linux-serial@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 11/28] serial: 8250_of: Drop quirk fot NPCM from 8250_port
Date: Wed,  3 Apr 2024 13:16:13 -0400
Message-ID: <20240403171656.335224-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403171656.335224-1-sashal@kernel.org>
References: <20240403171656.335224-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.3
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit cd0eb354d441488feed6685adbeb1acd45db1b8d ]

We are not supposed to spread quirks in 8250_port module especially
when we have a separate driver for the hardware in question.

Move quirk from generic module to the driver that uses it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/r/20240215145029.581389-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/8250/8250_of.c   | 44 +++++++++++++++++++++++++++--
 drivers/tty/serial/8250/8250_port.c | 24 ----------------
 2 files changed, 42 insertions(+), 26 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index 34f17a9785e79..9dcc17e332690 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -4,7 +4,10 @@
  *
  *    Copyright (C) 2006 Arnd Bergmann <arnd@arndb.de>, IBM Corp.
  */
+
+#include <linux/bits.h>
 #include <linux/console.h>
+#include <linux/math.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/serial_core.h>
@@ -25,6 +28,36 @@ struct of_serial_info {
 	int line;
 };
 
+/* Nuvoton NPCM timeout register */
+#define UART_NPCM_TOR          7
+#define UART_NPCM_TOIE         BIT(7)  /* Timeout Interrupt Enable */
+
+static int npcm_startup(struct uart_port *port)
+{
+	/*
+	 * Nuvoton calls the scratch register 'UART_TOR' (timeout
+	 * register). Enable it, and set TIOC (timeout interrupt
+	 * comparator) to be 0x20 for correct operation.
+	 */
+	serial_port_out(port, UART_NPCM_TOR, UART_NPCM_TOIE | 0x20);
+
+	return serial8250_do_startup(port);
+}
+
+/* Nuvoton NPCM UARTs have a custom divisor calculation */
+static unsigned int npcm_get_divisor(struct uart_port *port, unsigned int baud,
+				     unsigned int *frac)
+{
+	return DIV_ROUND_CLOSEST(port->uartclk, 16 * baud + 2) - 2;
+}
+
+static int npcm_setup(struct uart_port *port)
+{
+	port->get_divisor = npcm_get_divisor;
+	port->startup = npcm_startup;
+	return 0;
+}
+
 /*
  * Fill a struct uart_port for a given device node
  */
@@ -164,10 +197,17 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 	switch (type) {
 	case PORT_RT2880:
 		ret = rt288x_setup(port);
-		if (ret)
-			goto err_pmruntime;
+		break;
+	case PORT_NPCM:
+		ret = npcm_setup(port);
+		break;
+	default:
+		/* Nothing to do */
+		ret = 0;
 		break;
 	}
+	if (ret)
+		goto err_pmruntime;
 
 	if (IS_REACHABLE(CONFIG_SERIAL_8250_FSL) &&
 	    (of_device_is_compatible(np, "fsl,ns16550") ||
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 8ca061d3bbb92..4164f8650476d 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -38,10 +38,6 @@
 
 #include "8250.h"
 
-/* Nuvoton NPCM timeout register */
-#define UART_NPCM_TOR          7
-#define UART_NPCM_TOIE         BIT(7)  /* Timeout Interrupt Enable */
-
 /*
  * Debugging.
  */
@@ -2235,15 +2231,6 @@ int serial8250_do_startup(struct uart_port *port)
 				UART_DA830_PWREMU_MGMT_FREE);
 	}
 
-	if (port->type == PORT_NPCM) {
-		/*
-		 * Nuvoton calls the scratch register 'UART_TOR' (timeout
-		 * register). Enable it, and set TIOC (timeout interrupt
-		 * comparator) to be 0x20 for correct operation.
-		 */
-		serial_port_out(port, UART_NPCM_TOR, UART_NPCM_TOIE | 0x20);
-	}
-
 #ifdef CONFIG_SERIAL_8250_RSA
 	/*
 	 * If this is an RSA port, see if we can kick it up to the
@@ -2545,15 +2532,6 @@ static void serial8250_shutdown(struct uart_port *port)
 		serial8250_do_shutdown(port);
 }
 
-/* Nuvoton NPCM UARTs have a custom divisor calculation */
-static unsigned int npcm_get_divisor(struct uart_8250_port *up,
-		unsigned int baud)
-{
-	struct uart_port *port = &up->port;
-
-	return DIV_ROUND_CLOSEST(port->uartclk, 16 * baud + 2) - 2;
-}
-
 static unsigned int serial8250_do_get_divisor(struct uart_port *port,
 					      unsigned int baud,
 					      unsigned int *frac)
@@ -2598,8 +2576,6 @@ static unsigned int serial8250_do_get_divisor(struct uart_port *port,
 		quot = 0x8001;
 	else if (magic_multiplier && baud >= port->uartclk / 12)
 		quot = 0x8002;
-	else if (up->port.type == PORT_NPCM)
-		quot = npcm_get_divisor(up, baud);
 	else
 		quot = uart_get_divisor(port, baud);
 
-- 
2.43.0


