Return-Path: <linux-kernel+bounces-128622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE30A895D26
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8420D288EF6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B303A15E5B1;
	Tue,  2 Apr 2024 19:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QO92byj2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D7315E7F1;
	Tue,  2 Apr 2024 19:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712087605; cv=none; b=LLNRtl1RNcMoAk1UDqZlZYABdmo4wMingXzF/Zct9NigyyMm00Z5fV9ZIFinWaeskwVb0c3vuUAubJStILAxYsTcPM7sRtWH+2gUCals8LsA4Ms4DqwBoAHKebeh+/i6J+44ZQ0Dn1qED/Fb3vM8yYkU/gdRfKi24N++9LqPsjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712087605; c=relaxed/simple;
	bh=UttHAm7kWJDBQbIbN+5DgAfqZ8GVuR4A1O6eAxQAjBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LUOhuirbpHclcN98mAdQrvCYNNqJZuAVG93MQj8VfSV8DWwqZGfDg+b3Rnx94iNCwv6lMyxZkzwIJSGoZWKjLyaPdUukYYNbniZ3cGKW6Vfob9BpmPV15uh6B91Nsj6ZjBGP8IaoYZ+zf1yKRS83bNgI/VZ+VqoON9w2EThP7l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QO92byj2; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712087603; x=1743623603;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UttHAm7kWJDBQbIbN+5DgAfqZ8GVuR4A1O6eAxQAjBk=;
  b=QO92byj2qgFkJfKJy3gPp1CibF3RdZQc1jjUUN0YjQXTJn1s6fmtal/X
   SSGb5P6u5w5QxmqxIOzFUbSq8/zHqANKxhTj4Z0MPXGbfDOhlGhmvFpbn
   gEDKnudfH71/XJqHGYnWw7ujp3dQdXOiHgjUAwvx1uk9H+Vf2K887pvkc
   9y4dlIUxko/WQvAzG2H4j1K/IlDJRr218O9Yguq+3VIJg7XlGAEUf/tbX
   wkn5sDETGCKGi8DUhvtxZ/21Qnn8jZMyI+/LfWykbSICvbafovQJdIuQE
   adjvZ1MEUDtJ6AaBacYOq8EcWPeGajW3IGpbtdndnQWDjzCo12HO9QEFf
   w==;
X-CSE-ConnectionGUID: HW/lzEAeS1S/AmWmqrpghA==
X-CSE-MsgGUID: +q5wFLDoRCy/xOTmy/h5Kg==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7151042"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="7151042"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 12:53:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="937083795"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="937083795"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 02 Apr 2024 12:53:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 4336515BC; Tue,  2 Apr 2024 22:53:10 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hugo@hugovil.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: [PATCH v2 13/16] serial: max3100: Extract to_max3100_port() helper macro
Date: Tue,  2 Apr 2024 22:50:40 +0300
Message-ID: <20240402195306.269276-14-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240402195306.269276-1-andriy.shevchenko@linux.intel.com>
References: <20240402195306.269276-1-andriy.shevchenko@linux.intel.com>
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
index 55f0421515a8..b068175ef9c3 100644
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
 
@@ -322,9 +325,7 @@ static irqreturn_t max3100_irq(int irqno, void *dev_id)
 
 static void max3100_enable_ms(struct uart_port *port)
 {
-	struct max3100_port *s = container_of(port,
-					      struct max3100_port,
-					      port);
+	struct max3100_port *s = to_max3100_port(port);
 
 	mod_timer(&s->timer, jiffies);
 	dev_dbg(&s->spi->dev, "%s\n", __func__);
@@ -332,9 +333,7 @@ static void max3100_enable_ms(struct uart_port *port)
 
 static void max3100_start_tx(struct uart_port *port)
 {
-	struct max3100_port *s = container_of(port,
-					      struct max3100_port,
-					      port);
+	struct max3100_port *s = to_max3100_port(port);
 
 	dev_dbg(&s->spi->dev, "%s\n", __func__);
 
@@ -343,9 +342,7 @@ static void max3100_start_tx(struct uart_port *port)
 
 static void max3100_stop_rx(struct uart_port *port)
 {
-	struct max3100_port *s = container_of(port,
-					      struct max3100_port,
-					      port);
+	struct max3100_port *s = to_max3100_port(port);
 
 	dev_dbg(&s->spi->dev, "%s\n", __func__);
 
@@ -359,9 +356,7 @@ static void max3100_stop_rx(struct uart_port *port)
 
 static unsigned int max3100_tx_empty(struct uart_port *port)
 {
-	struct max3100_port *s = container_of(port,
-					      struct max3100_port,
-					      port);
+	struct max3100_port *s = to_max3100_port(port);
 
 	dev_dbg(&s->spi->dev, "%s\n", __func__);
 
@@ -372,9 +367,7 @@ static unsigned int max3100_tx_empty(struct uart_port *port)
 
 static unsigned int max3100_get_mctrl(struct uart_port *port)
 {
-	struct max3100_port *s = container_of(port,
-					      struct max3100_port,
-					      port);
+	struct max3100_port *s = to_max3100_port(port);
 
 	dev_dbg(&s->spi->dev, "%s\n", __func__);
 
@@ -386,9 +379,7 @@ static unsigned int max3100_get_mctrl(struct uart_port *port)
 
 static void max3100_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
-	struct max3100_port *s = container_of(port,
-					      struct max3100_port,
-					      port);
+	struct max3100_port *s = to_max3100_port(port);
 	int loopback, rts;
 
 	dev_dbg(&s->spi->dev, "%s\n", __func__);
@@ -414,9 +405,7 @@ static void
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
@@ -532,9 +521,7 @@ max3100_set_termios(struct uart_port *port, struct ktermios *termios,
 
 static void max3100_shutdown(struct uart_port *port)
 {
-	struct max3100_port *s = container_of(port,
-					      struct max3100_port,
-					      port);
+	struct max3100_port *s = to_max3100_port(port);
 	u16 rx;
 
 	dev_dbg(&s->spi->dev, "%s\n", __func__);
@@ -559,9 +546,7 @@ static void max3100_shutdown(struct uart_port *port)
 
 static int max3100_startup(struct uart_port *port)
 {
-	struct max3100_port *s = container_of(port,
-					      struct max3100_port,
-					      port);
+	struct max3100_port *s = to_max3100_port(port);
 	char b[12];
 	int ret;
 
@@ -607,9 +592,7 @@ static int max3100_startup(struct uart_port *port)
 
 static const char *max3100_type(struct uart_port *port)
 {
-	struct max3100_port *s = container_of(port,
-					      struct max3100_port,
-					      port);
+	struct max3100_port *s = to_max3100_port(port);
 
 	dev_dbg(&s->spi->dev, "%s\n", __func__);
 
@@ -618,18 +601,14 @@ static const char *max3100_type(struct uart_port *port)
 
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
 
@@ -640,9 +619,7 @@ static void max3100_config_port(struct uart_port *port, int flags)
 static int max3100_verify_port(struct uart_port *port,
 			       struct serial_struct *ser)
 {
-	struct max3100_port *s = container_of(port,
-					      struct max3100_port,
-					      port);
+	struct max3100_port *s = to_max3100_port(port);
 	int ret = -EINVAL;
 
 	dev_dbg(&s->spi->dev, "%s\n", __func__);
@@ -654,18 +631,14 @@ static int max3100_verify_port(struct uart_port *port,
 
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
@@ -673,9 +646,7 @@ static int max3100_request_port(struct uart_port *port)
 
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


