Return-Path: <linux-kernel+bounces-67107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2642C85668B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DC7D1F27CC1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6DB132488;
	Thu, 15 Feb 2024 14:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JCTZ/IsK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447BB132484;
	Thu, 15 Feb 2024 14:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708008637; cv=none; b=UfNT8xo5O4NSEwpEVajYRjvlMlc43/8I6lIPSXuSHsrg2kkHikv4kkvJugaG+uk7ATF0pUBksDJE8S9gV2yKy3gqTf2V04xVf3g9hxYKrZcKcMYYwkh0wVovglTUr4I35SC57ccEX7puw0G4+PWEhQYKhiO3hF+EOvH42Jdnmf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708008637; c=relaxed/simple;
	bh=2UTMt4kij+AbeHSuCqQx7s5uiRsL4iwwHL/UJl/dr60=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dw7eIuqT3kXXD9qQsWNtJvFwDTPhVdQuz73rd9vosX9KoPzGJqDXFxpoA3fbiHyUxDbitBtF9UrCIcY4GZcCXBXkWbbCUMI4QbHxBew2eJ7TCahxGB52pzazsPau3nRMJnhzSzQyFBJrNykchLFpkHWn+CCEJUD6UYmlqt80LzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JCTZ/IsK; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708008635; x=1739544635;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2UTMt4kij+AbeHSuCqQx7s5uiRsL4iwwHL/UJl/dr60=;
  b=JCTZ/IsKvKi+wN3+DTz3Rgijnbh+AP+wbcDsRhjfFMYc1rx3gGSJ0sTr
   Wm8EX4kBL9D7pZWXIc5aftC27yPL8kyQzbKV1jf9psvCtLWjV2ZjwRA8L
   385fiTGlAop+irGkxfdA9Y82tUXfZHGhBQk9OBdzU/AuHfOQite5Gn1jz
   87rWBS3gfszbMOkHHnuEXHhDOltZty+K29NyEw8dCRfI6hhndlplrmaik
   cyjIZU5KT7nYMtoascjZrIuSJx4SMf9VlZc0nYB920RoGSdqMp1RilGbL
   g3gb2+kEOKAUwuA/pPPJnWwVJrOQVznPU7WTGz4CV+pjIGaDR2zVD6FUj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="1968850"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="1968850"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 06:50:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="935676901"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="935676901"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 15 Feb 2024 06:50:32 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 706C620B; Thu, 15 Feb 2024 16:50:31 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v2 1/1] serial: 8250_of: Drop quirk fot NPCM from 8250_port
Date: Thu, 15 Feb 2024 16:50:08 +0200
Message-ID: <20240215145029.581389-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We are not supposed to spread quirks in 8250_port module especially
when we have a separate driver for the hardware in question.

Move quirk from generic module to the driver that uses it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: added missing bits.h, reworked error handling in a switch-case
 drivers/tty/serial/8250/8250_of.c   | 44 +++++++++++++++++++++++++++--
 drivers/tty/serial/8250/8250_port.c | 24 ----------------
 2 files changed, 42 insertions(+), 26 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index 34f17a9785e7..9dcc17e33269 100644
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
index 175a0b07589c..2699ccf5bfce 100644
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
@@ -2206,15 +2202,6 @@ int serial8250_do_startup(struct uart_port *port)
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
@@ -2508,15 +2495,6 @@ static void serial8250_shutdown(struct uart_port *port)
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
@@ -2561,8 +2539,6 @@ static unsigned int serial8250_do_get_divisor(struct uart_port *port,
 		quot = 0x8001;
 	else if (magic_multiplier && baud >= port->uartclk / 12)
 		quot = 0x8002;
-	else if (up->port.type == PORT_NPCM)
-		quot = npcm_get_divisor(up, baud);
 	else
 		quot = uart_get_divisor(port, baud);
 
-- 
2.43.0.rc1.1.gbec44491f096


