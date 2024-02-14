Return-Path: <linux-kernel+bounces-65498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B35F854DD9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3A911F229EE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B9C5FF07;
	Wed, 14 Feb 2024 16:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IF/oiU2m"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AA25C8FC;
	Wed, 14 Feb 2024 16:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707927362; cv=none; b=TJnoWdWK8IulI8tn292FEPARPhabNy6r3X6vsKjyxQX8FjmFSnOkgY92DCtfX6HsHCTZKyOpQ4zO4HK8kKP6B9Qmtj+gyzFX8hgZx5T8Nd41ksWNzAZDFaERr8PPvcccofp+ZZPfL06rKraD2z19Ebq4acEMxmgRtTP6mNOEBfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707927362; c=relaxed/simple;
	bh=1LEv6Ova+Z8khqle7qgHTwMJAqi9FazSaL1UQ9aqt4o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ash99T1gHATD+TvZeVwFuYojc9Ph08ZGStn5lxqklUcX8e289Sy+/p48PIUp3u1aEquBht8qBr824j0KnNpMB/VJIv9JoQXMFrwTuvCrtNrdCdQXZ7FTDqfWspcbPnTShorbVc+ibrKrahF7z5xCOf0Y3sCzXlti+6XI71XlWQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IF/oiU2m; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707927360; x=1739463360;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1LEv6Ova+Z8khqle7qgHTwMJAqi9FazSaL1UQ9aqt4o=;
  b=IF/oiU2mPc6LFmtgy6syJW3B8L7Bn7fn5hL/o/MMz7R4qUJzMHz74IYA
   SAwsed8droajK8RNDLrtmbTEbK8QxJpGSCJfljdxAFPsZC1K1ShuS25pU
   XdtxXn+dTVSnGmtea8rZNXXLrYJEsqASem0RKCxNNGCJe+mlo5BHD1SBl
   WZ9I+N4+IwbBrlmd4zJklzgBARg51P3qXqBaczgO8C+Nckl2rjIOxTk/9
   DBfqKQgEDwPRrXgtHmcTOipvbHIs0AX37AB3aGjBkY3Axl5DUGZV95/a3
   q8SRmL0fHXYowCa6/gJD8RhufkCd+Ypd0iRkHU75wUzXbn5UllGNECsmB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="27427899"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="27427899"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 08:15:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="935617078"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="935617078"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 14 Feb 2024 08:15:57 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id C3928204; Wed, 14 Feb 2024 18:15:56 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 1/1] serial: 8250_of: Drop quirk fot NPCM from 8250_port
Date: Wed, 14 Feb 2024 18:14:23 +0200
Message-ID: <20240214161423.3452705-1-andriy.shevchenko@linux.intel.com>
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
 drivers/tty/serial/8250/8250_of.c   | 38 +++++++++++++++++++++++++++++
 drivers/tty/serial/8250/8250_port.c | 24 ------------------
 2 files changed, 38 insertions(+), 24 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index 34f17a9785e7..dc9792f919db 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -5,6 +5,7 @@
  *    Copyright (C) 2006 Arnd Bergmann <arnd@arndb.de>, IBM Corp.
  */
 #include <linux/console.h>
+#include <linux/math.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/serial_core.h>
@@ -25,6 +26,36 @@ struct of_serial_info {
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
@@ -167,6 +198,13 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 		if (ret)
 			goto err_pmruntime;
 		break;
+	case PORT_NPCM:
+		ret = npcm_setup(port);
+		if (ret)
+			goto err_pmruntime;
+		break;
+	default:
+		break;
 	}
 
 	if (IS_REACHABLE(CONFIG_SERIAL_8250_FSL) &&
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index d59dc219c899..1942e57089dd 100644
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
2.43.0.rc1.1.gbec44491f096


