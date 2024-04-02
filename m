Return-Path: <linux-kernel+bounces-128620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BD8895D21
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AA5B289A74
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2937615EFAF;
	Tue,  2 Apr 2024 19:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OcjN0hj+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB89715E7FA;
	Tue,  2 Apr 2024 19:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712087604; cv=none; b=HvxswKZl7syH6m98fETL5BaobYREKcXKeAdTbRAODN0NTOq3yyUU+Ky0eT1R5m1F4WQfXOAhBOx41U9ZAA3gMV1aEJL6sZHeAXLLDc9jBe90K6vOOalcICr9DRZ1TlZ/53qOWCN1OAquN7SOwipXVJL6KLc/qUicF0qApW3RepU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712087604; c=relaxed/simple;
	bh=+tCR8Q6qrQLWWhfMOEUZuihnpFyj0j83V98VFK52xIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R1jQwJWeluN9UR9VynzSKifHc2+maZwyeNIlcZ6oo9yK62aJpTHLQ8IKpX8waNKv2pKAfO4bVjNKmES4yOaUaLisASC/7y555OVn1bdXrt3c/7AqmJ6NNkwM3PPMDo2tG59dLtYUqtAxzswm3dqVwJS8ZrBaf3+CKKaIfkz4np0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OcjN0hj+; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712087603; x=1743623603;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+tCR8Q6qrQLWWhfMOEUZuihnpFyj0j83V98VFK52xIc=;
  b=OcjN0hj+PLRTIE0XhZ7xk5zF6zJtL9KNDgUUGt97tHtQlhazepzRkE3c
   uVzqm3486CpBkpdxgbHvlCOdYrg1I0hHATIQupKJzM3IR5cAFFeS7xx2s
   cwM8kNNcEm/cOxkMG8xRPcVmiqeIA3534/wuw4ca3JSjenLHD6RwO+caS
   3mWx5DV6jzB/DIj4R/kxCKoFXeygg1eqv15Dmni0yQHrJay/6QQ6TeUKc
   xdzuPxoXWmghh9jLvFMXiMIzlITavvVKJukoWj/UZib8RnrsmDlrRUeJk
   RPYE7FMRC1aXWWOoPTE3a6TaxewbQauPgIoTPwlIhJYYzmz0nsVjP+FjJ
   Q==;
X-CSE-ConnectionGUID: Ak2GAdJtTZe7XxNZs25lVA==
X-CSE-MsgGUID: qPbBct4jTqmIsp6j/qBzFg==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7151041"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="7151041"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 12:53:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="937083789"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="937083789"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 02 Apr 2024 12:53:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id E6E9C6CB; Tue,  2 Apr 2024 22:53:09 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hugo@hugovil.com>
Subject: [PATCH v2 06/16] serial: max3100: Replace custom polling timeout with standard one
Date: Tue,  2 Apr 2024 22:50:33 +0300
Message-ID: <20240402195306.269276-7-andriy.shevchenko@linux.intel.com>
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

Serial core provides a standard timeout for polling modem state.
Use it instead of a custom approach.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/max3100.c | 25 +++++--------------------
 1 file changed, 5 insertions(+), 20 deletions(-)

diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index c31e4a96cc72..6dc20e4ec078 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -34,8 +34,6 @@
  * struct plat_max3100 - MAX3100 SPI UART platform data
  * @loopback:            force MAX3100 in loopback
  * @crystal:             1 for 3.6864 Mhz, 0 for 1.8432
- * @poll_time:           poll time for CTS signal in ms, 0 disables (so no hw
- *                       flow ctrl is possible but you have less CPU usage)
  *
  * You should use this structure in your machine description to specify
  * how the MAX3100 is connected.
@@ -43,7 +41,6 @@
 struct plat_max3100 {
 	int loopback;
 	int crystal;
-	int poll_time;
 };
 
 #define MAX3100_C    (1<<14)
@@ -122,9 +119,6 @@ struct max3100_port {
 	/* need to know we are suspending to avoid deadlock on workqueue */
 	int suspending;
 
-	/* poll time (in ms) for ctrl lines */
-	int poll_time;
-	/* and its timer */
 	struct timer_list	timer;
 };
 
@@ -177,10 +171,8 @@ static void max3100_timeout(struct timer_list *t)
 {
 	struct max3100_port *s = from_timer(s, t, timer);
 
-	if (s->port.state) {
-		max3100_dowork(s);
-		mod_timer(&s->timer, jiffies + s->poll_time);
-	}
+	max3100_dowork(s);
+	mod_timer(&s->timer, jiffies + uart_poll_timeout(&s->port));
 }
 
 static int max3100_sr(struct max3100_port *s, u16 tx, u16 *rx)
@@ -342,8 +334,7 @@ static void max3100_enable_ms(struct uart_port *port)
 					      struct max3100_port,
 					      port);
 
-	if (s->poll_time > 0)
-		mod_timer(&s->timer, jiffies);
+	mod_timer(&s->timer, jiffies);
 	dev_dbg(&s->spi->dev, "%s\n", __func__);
 }
 
@@ -526,9 +517,7 @@ max3100_set_termios(struct uart_port *port, struct ktermios *termios,
 			MAX3100_STATUS_PE | MAX3100_STATUS_FE |
 			MAX3100_STATUS_OE;
 
-	if (s->poll_time > 0)
-		del_timer_sync(&s->timer);
-
+	del_timer_sync(&s->timer);
 	uart_update_timeout(port, termios->c_cflag, baud);
 
 	spin_lock(&s->conf_lock);
@@ -556,8 +545,7 @@ static void max3100_shutdown(struct uart_port *port)
 
 	s->force_end_work = 1;
 
-	if (s->poll_time > 0)
-		del_timer_sync(&s->timer);
+	del_timer_sync(&s->timer);
 
 	if (s->workqueue) {
 		destroy_workqueue(s->workqueue);
@@ -769,9 +757,6 @@ static int max3100_probe(struct spi_device *spi)
 	pdata = dev_get_platdata(&spi->dev);
 	max3100s[i]->crystal = pdata->crystal;
 	max3100s[i]->loopback = pdata->loopback;
-	max3100s[i]->poll_time = msecs_to_jiffies(pdata->poll_time);
-	if (pdata->poll_time > 0 && max3100s[i]->poll_time == 0)
-		max3100s[i]->poll_time = 1;
 	max3100s[i]->minor = i;
 	timer_setup(&max3100s[i]->timer, max3100_timeout, 0);
 
-- 
2.43.0.rc1.1.gbec44491f096


