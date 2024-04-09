Return-Path: <linux-kernel+bounces-137126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C85EA89DD46
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB9091C20D4E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D0E135410;
	Tue,  9 Apr 2024 14:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dpYKW9jC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3E11311BB;
	Tue,  9 Apr 2024 14:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712674057; cv=none; b=m8Xi29A4tQFkMu58i/JhGDCjHQxxg8trd4p8jwzlDt3zEIVSaqGBEG0aO/KfPZis1om3x51O+byzkhkDELl5BSlg6Pml7sbd0CDTGsB/5eWl67rPLpqg/niRFqWeR7wbuTah8bUgAttIEXobqdJh8QiLs1XRb1yvhuavPplGfLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712674057; c=relaxed/simple;
	bh=g0TObzXZAJf9fT1d6X4ImoYo9aLCppDtNsERfaj9vNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BpbuTLRbs+he6Ff8DXtx8wMZSXAVWGW4v2C7evkTYdSe8p6tl5rcqOeh/b1TB/enJ2IFt1hsnwLYhxC9rZhUMSBpPHM2SMVGti/E8zHoYANslrhLPVimUk71BJN9+/UbnsFzTBJxeFYCU6NTVF1CbdzVm8ShpVC74HYuhaqujdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dpYKW9jC; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712674056; x=1744210056;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g0TObzXZAJf9fT1d6X4ImoYo9aLCppDtNsERfaj9vNs=;
  b=dpYKW9jCsBOv/YYxVLrvvPY7LFL0utEFHcz+nvcdbWVrPvqmoLuPm5ne
   Skej2/syzDhfs8oQPZaFsJiGI0yHEz+IB0FlpY0pgZg8MLNBTrjwpJ1Au
   Qwd5psCo68wWBcorLgfUQnxZNi4qet38GVcJDB/SAwWEIWWgEj7GWmSyI
   P86X1zys+aV1v61pkt4y/N4OIM6kHYS8/VUWMZYzdqMQYdUOmcydzg/J0
   nBAOXv/Wp3mJAAm4Rw/b676dtXLo3f30j2EU3seSkhzND/XUZXvTUz+wK
   Vpj8qhTp3EpDj7Evp49mkohEPn+RmTEPaKhj2FPUeZBVkl0r+MaCxxt4Y
   A==;
X-CSE-ConnectionGUID: ehiOM+FAQFiery9ZLUSQOw==
X-CSE-MsgGUID: pja6vvTlTEO67Gj9YSMgsQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="7905545"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="7905545"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 07:47:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="937093490"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="937093490"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 09 Apr 2024 07:47:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 72413A70; Tue,  9 Apr 2024 17:47:27 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: [PATCH v3 7/8] serial: max3100: Extract to_max3100_port() helper macro
Date: Tue,  9 Apr 2024 17:45:54 +0300
Message-ID: <20240409144721.638326-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240409144721.638326-1-andriy.shevchenko@linux.intel.com>
References: <20240409144721.638326-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of using container_of() explicitly, introduce a helper macro.
This saves a lot of lines of code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/max3100.c | 67 ++++++++++--------------------------
 1 file changed, 19 insertions(+), 48 deletions(-)

diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index db543eaa39c8..4e7cd037cfc2 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -16,6 +16,7 @@
 /* 4 MAX3100s should be enough for everyone */
 #define MAX_MAX3100 4
 
+#include <linux/container_of.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/device.h>
@@ -110,6 +111,8 @@ struct max3100_port {
 	struct timer_list	timer;
 };
 
+#define to_max3100_port(port)	container_of(port, struct max3100_port, port)
+
 static struct max3100_port *max3100s[MAX_MAX3100]; /* the chips */
 static DEFINE_MUTEX(max3100s_lock);		   /* race on probe */
 
@@ -320,9 +323,7 @@ static irqreturn_t max3100_irq(int irqno, void *dev_id)
 
 static void max3100_enable_ms(struct uart_port *port)
 {
-	struct max3100_port *s = container_of(port,
-					      struct max3100_port,
-					      port);
+	struct max3100_port *s = to_max3100_port(port);
 
 	mod_timer(&s->timer, jiffies);
 	dev_dbg(&s->spi->dev, "%s\n", __func__);
@@ -330,9 +331,7 @@ static void max3100_enable_ms(struct uart_port *port)
 
 static void max3100_start_tx(struct uart_port *port)
 {
-	struct max3100_port *s = container_of(port,
-					      struct max3100_port,
-					      port);
+	struct max3100_port *s = to_max3100_port(port);
 
 	dev_dbg(&s->spi->dev, "%s\n", __func__);
 
@@ -341,9 +340,7 @@ static void max3100_start_tx(struct uart_port *port)
 
 static void max3100_stop_rx(struct uart_port *port)
 {
-	struct max3100_port *s = container_of(port,
-					      struct max3100_port,
-					      port);
+	struct max3100_port *s = to_max3100_port(port);
 
 	dev_dbg(&s->spi->dev, "%s\n", __func__);
 
@@ -357,9 +354,7 @@ static void max3100_stop_rx(struct uart_port *port)
 
 static unsigned int max3100_tx_empty(struct uart_port *port)
 {
-	struct max3100_port *s = container_of(port,
-					      struct max3100_port,
-					      port);
+	struct max3100_port *s = to_max3100_port(port);
 
 	dev_dbg(&s->spi->dev, "%s\n", __func__);
 
@@ -370,9 +365,7 @@ static unsigned int max3100_tx_empty(struct uart_port *port)
 
 static unsigned int max3100_get_mctrl(struct uart_port *port)
 {
-	struct max3100_port *s = container_of(port,
-					      struct max3100_port,
-					      port);
+	struct max3100_port *s = to_max3100_port(port);
 
 	dev_dbg(&s->spi->dev, "%s\n", __func__);
 
@@ -384,9 +377,7 @@ static unsigned int max3100_get_mctrl(struct uart_port *port)
 
 static void max3100_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
-	struct max3100_port *s = container_of(port,
-					      struct max3100_port,
-					      port);
+	struct max3100_port *s = to_max3100_port(port);
 	int loopback, rts;
 
 	dev_dbg(&s->spi->dev, "%s\n", __func__);
@@ -412,9 +403,7 @@ static void
 max3100_set_termios(struct uart_port *port, struct ktermios *termios,
 		    const struct ktermios *old)
 {
-	struct max3100_port *s = container_of(port,
-					      struct max3100_port,
-					      port);
+	struct max3100_port *s = to_max3100_port(port);
 	unsigned int baud = port->uartclk / 16;
 	unsigned int baud230400 = (baud == 230400) ? 1 : 0;
 	unsigned cflag;
@@ -530,9 +519,7 @@ max3100_set_termios(struct uart_port *port, struct ktermios *termios,
 
 static void max3100_shutdown(struct uart_port *port)
 {
-	struct max3100_port *s = container_of(port,
-					      struct max3100_port,
-					      port);
+	struct max3100_port *s = to_max3100_port(port);
 	u16 rx;
 
 	dev_dbg(&s->spi->dev, "%s\n", __func__);
@@ -557,9 +544,7 @@ static void max3100_shutdown(struct uart_port *port)
 
 static int max3100_startup(struct uart_port *port)
 {
-	struct max3100_port *s = container_of(port,
-					      struct max3100_port,
-					      port);
+	struct max3100_port *s = to_max3100_port(port);
 	char b[12];
 	int ret;
 
@@ -605,9 +590,7 @@ static int max3100_startup(struct uart_port *port)
 
 static const char *max3100_type(struct uart_port *port)
 {
-	struct max3100_port *s = container_of(port,
-					      struct max3100_port,
-					      port);
+	struct max3100_port *s = to_max3100_port(port);
 
 	dev_dbg(&s->spi->dev, "%s\n", __func__);
 
@@ -616,18 +599,14 @@ static const char *max3100_type(struct uart_port *port)
 
 static void max3100_release_port(struct uart_port *port)
 {
-	struct max3100_port *s = container_of(port,
-					      struct max3100_port,
-					      port);
+	struct max3100_port *s = to_max3100_port(port);
 
 	dev_dbg(&s->spi->dev, "%s\n", __func__);
 }
 
 static void max3100_config_port(struct uart_port *port, int flags)
 {
-	struct max3100_port *s = container_of(port,
-					      struct max3100_port,
-					      port);
+	struct max3100_port *s = to_max3100_port(port);
 
 	dev_dbg(&s->spi->dev, "%s\n", __func__);
 
@@ -638,9 +617,7 @@ static void max3100_config_port(struct uart_port *port, int flags)
 static int max3100_verify_port(struct uart_port *port,
 			       struct serial_struct *ser)
 {
-	struct max3100_port *s = container_of(port,
-					      struct max3100_port,
-					      port);
+	struct max3100_port *s = to_max3100_port(port);
 	int ret = -EINVAL;
 
 	dev_dbg(&s->spi->dev, "%s\n", __func__);
@@ -652,18 +629,14 @@ static int max3100_verify_port(struct uart_port *port,
 
 static void max3100_stop_tx(struct uart_port *port)
 {
-	struct max3100_port *s = container_of(port,
-					      struct max3100_port,
-					      port);
+	struct max3100_port *s = to_max3100_port(port);
 
 	dev_dbg(&s->spi->dev, "%s\n", __func__);
 }
 
 static int max3100_request_port(struct uart_port *port)
 {
-	struct max3100_port *s = container_of(port,
-					      struct max3100_port,
-					      port);
+	struct max3100_port *s = to_max3100_port(port);
 
 	dev_dbg(&s->spi->dev, "%s\n", __func__);
 	return 0;
@@ -671,9 +644,7 @@ static int max3100_request_port(struct uart_port *port)
 
 static void max3100_break_ctl(struct uart_port *port, int break_state)
 {
-	struct max3100_port *s = container_of(port,
-					      struct max3100_port,
-					      port);
+	struct max3100_port *s = to_max3100_port(port);
 
 	dev_dbg(&s->spi->dev, "%s\n", __func__);
 }
-- 
2.43.0.rc1.1.gbec44491f096


