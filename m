Return-Path: <linux-kernel+bounces-137412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7682A89E1B2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 018511F22FE4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323EF156861;
	Tue,  9 Apr 2024 17:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ALcy4sCu"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D894C85;
	Tue,  9 Apr 2024 17:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712684470; cv=none; b=kO8ywqx5CWyMBZI8ovitFxR9gdiKwZfP5FdK7QH0u8JmWOXzGFo3PRrtDyZnxiyHDzpUOzrxIJejw/pCYgTp+53peN9ms4D95XufBEA4zn3l01dOJxa54ouGdTe//75W7G+tHo2gySHi7HYiGuNeksk0AvLtbXygxwXOS4agQeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712684470; c=relaxed/simple;
	bh=XZWEMUAl0dN7TYQOj1m3nXStPmhxnvopLLCppGIaYWg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mh29cG95kW8RfW7ONxIPS28r5gUzFByjstjdJicMDh6zW7e6JYF0JhuHNHXpKXBC0fc9jjuWLEJqfibI6TOP8H5wHP13IhHqzLCThYGxWAgDSkwogtc8wFc1f9x4lwAv4hET8bZ/8fMORk04lxLErDhFH5Yl1pn197LcF9TlgJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ALcy4sCu; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712684469; x=1744220469;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XZWEMUAl0dN7TYQOj1m3nXStPmhxnvopLLCppGIaYWg=;
  b=ALcy4sCudXLeDkFtk+hX9cEMdYl/wU6AN/D+eIVvP5+y0hYo9y3H2VOk
   MvHsi3rcB57B0EtXmOeE8rIS0TqgkB8jLdpfDSRVJpzu0Upr0pb6ZBzrY
   mLsezzehopA6IvRvGDXNMQePeajxFg9N3Oqi1NBE8YTg6gtl+OR+5Qq4B
   buqTtoPdfDehjAh13j+k9Vaadd20Uy2uK/6wiryvEs/DN//bgUMZOdRqB
   8TifjJAUIgTnXwEmwj3xlZ1/3H9GkbUjLmTZXv4tTGjS62oO3CJ6NPltU
   wTvmjU1h6hM60Vj4JSDPOgX1j/62kfxvYaqNtduAfeiqajFEbFvVG0RIl
   w==;
X-CSE-ConnectionGUID: OtgvYccTQ42hPrNeQmbYkg==
X-CSE-MsgGUID: QPe4dMhORTqTAzZc2BCcbA==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="11856112"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="11856112"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 10:41:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="937093674"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="937093674"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 09 Apr 2024 10:41:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 9E73712C; Tue,  9 Apr 2024 20:41:05 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] serial: core: Extract uart_alloc_xmit_buf() and uart_free_xmit_buf()
Date: Tue,  9 Apr 2024 20:40:57 +0300
Message-ID: <20240409174057.1104262-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After conversion to the kfifo, it becomes possible to extract two helper
functions for better maintenance and code deduplication. Do it here.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/serial_core.c | 98 ++++++++++++++++++--------------
 1 file changed, 54 insertions(+), 44 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index dd6cf525d98d..ba2d6065fe02 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -243,25 +243,12 @@ static void uart_change_line_settings(struct tty_struct *tty, struct uart_state
 	uart_port_unlock_irq(uport);
 }
 
-/*
- * Startup the port.  This will be called once per open.  All calls
- * will be serialised by the per-port mutex.
- */
-static int uart_port_startup(struct tty_struct *tty, struct uart_state *state,
-			     bool init_hw)
+static int uart_alloc_xmit_buf(struct tty_port *port)
 {
-	struct uart_port *uport = uart_port_check(state);
+	struct uart_state *state = container_of(port, struct uart_state, port);
+	struct uart_port *uport;
 	unsigned long flags;
 	unsigned long page;
-	int retval = 0;
-
-	if (uport->type == PORT_UNKNOWN)
-		return 1;
-
-	/*
-	 * Make sure the device is in D0 state.
-	 */
-	uart_change_pm(state, UART_PM_STATE_ON);
 
 	/*
 	 * Initialise and allocate the transmit and temporary
@@ -271,7 +258,7 @@ static int uart_port_startup(struct tty_struct *tty, struct uart_state *state,
 	if (!page)
 		return -ENOMEM;
 
-	uart_port_lock(state, flags);
+	uport = uart_port_lock(state, flags);
 	if (!state->port.xmit_buf) {
 		state->port.xmit_buf = (unsigned char *)page;
 		kfifo_init(&state->port.xmit_fifo, state->port.xmit_buf,
@@ -281,11 +268,58 @@ static int uart_port_startup(struct tty_struct *tty, struct uart_state *state,
 		uart_port_unlock(uport, flags);
 		/*
 		 * Do not free() the page under the port lock, see
-		 * uart_shutdown().
+		 * uart_free_xmit_buf().
 		 */
 		free_page(page);
 	}
 
+	return 0;
+}
+
+static void uart_free_xmit_buf(struct tty_port *port)
+{
+	struct uart_state *state = container_of(port, struct uart_state, port);
+	struct uart_port *uport;
+	unsigned long flags;
+	char *xmit_buf;
+
+	/*
+	 * Do not free() the transmit buffer page under the port lock since
+	 * this can create various circular locking scenarios. For instance,
+	 * console driver may need to allocate/free a debug object, which
+	 * can end up in printk() recursion.
+	 */
+	uport = uart_port_lock(state, flags);
+	xmit_buf = port->xmit_buf;
+	port->xmit_buf = NULL;
+	INIT_KFIFO(port->xmit_fifo);
+	uart_port_unlock(uport, flags);
+
+	free_page((unsigned long)xmit_buf);
+}
+
+/*
+ * Startup the port.  This will be called once per open.  All calls
+ * will be serialised by the per-port mutex.
+ */
+static int uart_port_startup(struct tty_struct *tty, struct uart_state *state,
+			     bool init_hw)
+{
+	struct uart_port *uport = uart_port_check(state);
+	int retval;
+
+	if (uport->type == PORT_UNKNOWN)
+		return 1;
+
+	/*
+	 * Make sure the device is in D0 state.
+	 */
+	uart_change_pm(state, UART_PM_STATE_ON);
+
+	retval = uart_alloc_xmit_buf(&state->port);
+	if (retval)
+		return retval;
+
 	retval = uport->ops->startup(uport);
 	if (retval == 0) {
 		if (uart_console(uport) && uport->cons->cflag) {
@@ -347,8 +381,6 @@ static void uart_shutdown(struct tty_struct *tty, struct uart_state *state)
 {
 	struct uart_port *uport = uart_port_check(state);
 	struct tty_port *port = &state->port;
-	unsigned long flags;
-	char *xmit_buf = NULL;
 
 	/*
 	 * Set the TTY IO error marker
@@ -381,19 +413,7 @@ static void uart_shutdown(struct tty_struct *tty, struct uart_state *state)
 	 */
 	tty_port_set_suspended(port, false);
 
-	/*
-	 * Do not free() the transmit buffer page under the port lock since
-	 * this can create various circular locking scenarios. For instance,
-	 * console driver may need to allocate/free a debug object, which
-	 * can endup in printk() recursion.
-	 */
-	uart_port_lock(state, flags);
-	xmit_buf = port->xmit_buf;
-	port->xmit_buf = NULL;
-	INIT_KFIFO(port->xmit_fifo);
-	uart_port_unlock(uport, flags);
-
-	free_page((unsigned long)xmit_buf);
+	uart_free_xmit_buf(port);
 }
 
 /**
@@ -1747,7 +1767,6 @@ static void uart_tty_port_shutdown(struct tty_port *port)
 {
 	struct uart_state *state = container_of(port, struct uart_state, port);
 	struct uart_port *uport = uart_port_check(state);
-	char *buf;
 
 	/*
 	 * At this point, we stop accepting input.  To do this, we
@@ -1769,16 +1788,7 @@ static void uart_tty_port_shutdown(struct tty_port *port)
 	 */
 	tty_port_set_suspended(port, false);
 
-	/*
-	 * Free the transmit buffer.
-	 */
-	uart_port_lock_irq(uport);
-	buf = port->xmit_buf;
-	port->xmit_buf = NULL;
-	INIT_KFIFO(port->xmit_fifo);
-	uart_port_unlock_irq(uport);
-
-	free_page((unsigned long)buf);
+	uart_free_xmit_buf(port);
 
 	uart_change_pm(state, UART_PM_STATE_OFF);
 }
-- 
2.43.0.rc1.1.gbec44491f096


