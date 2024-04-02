Return-Path: <linux-kernel+bounces-128616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA7B895D18
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A5BD1C237B4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175E315E5D0;
	Tue,  2 Apr 2024 19:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T24ua1GC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABEA15DBD8;
	Tue,  2 Apr 2024 19:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712087601; cv=none; b=d2YI3xUd6hR7W5EjRFmCjIhPB5jFeUYp0b4QimKiY++BqOjttPC2fChCMQ3460Sepklev98aaKJ9AgG64HnzX4V1+gxKOhqqeJlHxZx8N8nzSka9we5nUi9h+IGgLgPch0P7qoak9zTraIdqThrL9mXq2Ezh/+H30UIlwVNa3fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712087601; c=relaxed/simple;
	bh=mra41kMuk7qyT6e9ANIRzG0FF/EgvI0Upn/qCusbz8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fMZ26EsMYCwQERYxoUXrjxK2TKrBLxq+BadMg6I7FGwabYS6T2MF9xqY1JweP6qKHOyj4EujSHh/S4T34F75R11QqN/jtouS1KzqRP3s3Hrg977eAWyZ4I5fUZgfWfMVUyY0nyTzd5AnHPUwqCF/8/xUpR0wtRH9Bt775fUD4ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T24ua1GC; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712087600; x=1743623600;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mra41kMuk7qyT6e9ANIRzG0FF/EgvI0Upn/qCusbz8c=;
  b=T24ua1GC9H2L/T+WS+XEl0uZMqTzGpsfszxnv+6kJdm29NnvI9uuO9C0
   ppKnEtqDCYM7oo3s3B/ZWQux8x3Skrj21A4kIFJVrVCj4T5oiemfaAQMk
   78wpqKV783q4gDRhWMd+e9znv8wdr+0Jw9j+Gyjni5aLO+hFKPqQmuGEY
   jymKvWVVZ8oGPnuzmcE9GjwNeS5V56eZfzUVGlLU5f7+1vyY04CGojxMR
   Dr8UCe3zx6XDMHN+Z68t7+JdWzBak/5e3pCMvac1XXHMKXiXUi9u9dhwl
   pe28ysbaT134HZaFLKqzBWuZ5itr4W/zXYSVaEmBZZGJiKM2MFz6deGf1
   Q==;
X-CSE-ConnectionGUID: 8H6AbVopRSS/x/Vi53UiIg==
X-CSE-MsgGUID: 5l6uttkbQBGRBzDDpmf53A==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7151026"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="7151026"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 12:53:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="937083791"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="937083791"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 02 Apr 2024 12:53:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 163426F5; Tue,  2 Apr 2024 22:53:10 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hugo@hugovil.com>
Subject: [PATCH v2 09/16] serial: max3100: Remove duplicating irq field
Date: Tue,  2 Apr 2024 22:50:36 +0300
Message-ID: <20240402195306.269276-10-andriy.shevchenko@linux.intel.com>
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

The struct uart_port has a copy of the IRQ that is also stored
in the private data structure. Remove the duplication in the latter
one.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/max3100.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index bd3f281969e3..85899ef010e9 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -93,8 +93,6 @@ struct max3100_port {
 #define MAX3100_7BIT 4
 	int rx_enabled;	        /* if we should rx chars */
 
-	int irq;		/* irq assigned to the max3100 */
-
 	int minor;		/* minor number */
 	int loopback_commit;	/* need to change loopback */
 	int loopback;		/* 1 if we are in loopback mode */
@@ -550,8 +548,8 @@ static void max3100_shutdown(struct uart_port *port)
 		destroy_workqueue(s->workqueue);
 		s->workqueue = NULL;
 	}
-	if (s->irq)
-		free_irq(s->irq, s);
+	if (port->irq)
+		free_irq(port->irq, s);
 
 	/* set shutdown mode to save power */
 	max3100_sr(s, MAX3100_WC | MAX3100_SHDN, &rx);
@@ -563,6 +561,7 @@ static int max3100_startup(struct uart_port *port)
 					      struct max3100_port,
 					      port);
 	char b[12];
+	int ret;
 
 	dev_dbg(&s->spi->dev, "%s\n", __func__);
 
@@ -585,10 +584,10 @@ static int max3100_startup(struct uart_port *port)
 	}
 	INIT_WORK(&s->work, max3100_work);
 
-	if (request_irq(s->irq, max3100_irq,
-			IRQF_TRIGGER_FALLING, "max3100", s) < 0) {
-		dev_warn(&s->spi->dev, "cannot allocate irq %d\n", s->irq);
-		s->irq = 0;
+	ret = request_irq(port->irq, max3100_irq, IRQF_TRIGGER_FALLING, "max3100", s);
+	if (ret < 0) {
+		dev_warn(&s->spi->dev, "cannot allocate irq %d\n", port->irq);
+		port->irq = 0;
 		destroy_workqueue(s->workqueue);
 		s->workqueue = NULL;
 		return -EBUSY;
@@ -744,14 +743,13 @@ static int max3100_probe(struct spi_device *spi)
 		return -ENOMEM;
 	}
 	max3100s[i]->spi = spi;
-	max3100s[i]->irq = spi->irq;
 	spin_lock_init(&max3100s[i]->conf_lock);
 	spi_set_drvdata(spi, max3100s[i]);
 	max3100s[i]->minor = i;
 	timer_setup(&max3100s[i]->timer, max3100_timeout, 0);
 
 	dev_dbg(&spi->dev, "%s: adding port %d\n", __func__, i);
-	max3100s[i]->port.irq = max3100s[i]->irq;
+	max3100s[i]->port.irq = spi->irq;
 	max3100s[i]->port.fifosize = 16;
 	max3100s[i]->port.ops = &max3100_ops;
 	max3100s[i]->port.flags = UPF_SKIP_TEST | UPF_BOOT_AUTOCONF;
@@ -815,7 +813,7 @@ static int max3100_suspend(struct device *dev)
 
 	dev_dbg(&s->spi->dev, "%s\n", __func__);
 
-	disable_irq(s->irq);
+	disable_irq(s->port.irq);
 
 	s->suspending = 1;
 	uart_suspend_port(&max3100_uart_driver, &s->port);
@@ -834,7 +832,7 @@ static int max3100_resume(struct device *dev)
 	uart_resume_port(&max3100_uart_driver, &s->port);
 	s->suspending = 0;
 
-	enable_irq(s->irq);
+	enable_irq(s->port.irq);
 
 	s->conf_commit = 1;
 	if (s->workqueue)
-- 
2.43.0.rc1.1.gbec44491f096


