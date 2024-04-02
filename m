Return-Path: <linux-kernel+bounces-128262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF87895872
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78DE3287690
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0CE13665E;
	Tue,  2 Apr 2024 15:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UeRUa8P4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBB7131751;
	Tue,  2 Apr 2024 15:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712072551; cv=none; b=BlxG7RyMBMqafxi/CkHXxMZQWmzWNMn1FgELfDXEy+rrOoSlt4sGgsBs356PaeZi87QHzL82fgJPTPMsN/uGcwCI5kVXk9eE8XiOFLv9b5qrhE9zEUFq5MqaZk/sQBxyNzl+mJqMYtR/ksq5KdiHjWlF6gbfduXz2kwR+GEGAdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712072551; c=relaxed/simple;
	bh=gZ3z+6SQpyMoP20wO/5WkHibYBkOqQM1QKvat7X5mw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YMP3kMj7GCvkt1FhcwCBgquTZRd23LSA8tebMUfP71zsvYbn6qfjPb62OysmCrgcKq9i0QcanhaFuWFEj/cT5+7G907Vx08nSXOdsCX1M113YmoJ2IjP3bcLYPeYi0jIqsU9xrqbmuvtJJ1aGUQOhaIYN46XGyJcxAtl55GStp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UeRUa8P4; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712072550; x=1743608550;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gZ3z+6SQpyMoP20wO/5WkHibYBkOqQM1QKvat7X5mw8=;
  b=UeRUa8P4UkEpvQY7odQfZfeujORDmEyOaZ2C3YxBmobeoq4pEwyuoLvM
   iD9vGYG5YwFm5o0/sAHT7NGUzGXIEXI7DDTkdhIVnc/ytbGd5J5GpjFmN
   euX7mWtQdTMMBrJ6BTY1N4s+OFTO5r3jPckr/tP3oh2HoU3Ni0YgKUqc6
   b6huvMPqU28FGHaAUh6JamaWSuy1lYLelbtqj19TkVUUGI1ir250pICpw
   S8FRGl8vLJ9/nNqYLQ83VTpOisceiQa+74ZEURaa9wMSlKxcEvPieZ7fn
   2h+oHpHdrT0zE5fmSZoFF1XG2YDhGLph1XaAZuKrnN+cQdgn3kBuTAHIW
   g==;
X-CSE-ConnectionGUID: qSzzTXDuQ7iDEYwjUv3n0A==
X-CSE-MsgGUID: nRQOhCvLSOG6LQjpP171EA==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="17870076"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="17870076"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 08:42:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="937083643"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="937083643"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 02 Apr 2024 08:42:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 97A93C74; Tue,  2 Apr 2024 18:42:20 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 09/16] serial: max3100: Remove duplicating irq field
Date: Tue,  2 Apr 2024 18:38:15 +0300
Message-ID: <20240402154219.3583679-10-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240402154219.3583679-1-andriy.shevchenko@linux.intel.com>
References: <20240402154219.3583679-1-andriy.shevchenko@linux.intel.com>
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
index e5a1a9171047..e7963382bbb6 100644
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
@@ -743,14 +742,13 @@ static int max3100_probe(struct spi_device *spi)
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
@@ -814,7 +812,7 @@ static int max3100_suspend(struct device *dev)
 
 	dev_dbg(&s->spi->dev, "%s\n", __func__);
 
-	disable_irq(s->irq);
+	disable_irq(s->port.irq);
 
 	s->suspending = 1;
 	uart_suspend_port(&max3100_uart_driver, &s->port);
@@ -833,7 +831,7 @@ static int max3100_resume(struct device *dev)
 	uart_resume_port(&max3100_uart_driver, &s->port);
 	s->suspending = 0;
 
-	enable_irq(s->irq);
+	enable_irq(s->port.irq);
 
 	s->conf_commit = 1;
 	if (s->workqueue)
-- 
2.43.0.rc1.1.gbec44491f096


