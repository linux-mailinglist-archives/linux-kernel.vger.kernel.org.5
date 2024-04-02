Return-Path: <linux-kernel+bounces-128259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D72789586A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2247FB251E9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A811353E4;
	Tue,  2 Apr 2024 15:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WiJg5Kp8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF01134403;
	Tue,  2 Apr 2024 15:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712072549; cv=none; b=ahc0AehTt7ahvJYu3BUdM2R9q6ZT4ze64JunxKTpJ0svkssL80FCTWJ0Z9X/lQhO6tqeGcqNbOlUiPtxUNwamfqNlDbounwx7pko9Sww9lhY0XWamfnCfs1q1qBzzwn9CtEhGiXD53ow2Na/+SLM37lP/oU0EFLW8pXP9uxUVvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712072549; c=relaxed/simple;
	bh=y43cM1loEB/xdiC5XlfYWF8K/xbUbOlgMRJmmCex1Yc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eop3Pb4yBAEfuFMMvsap4NrF5MtR2U9alYIx0Fy6vJ363itpbhEEp1rZzfAPbSow7avZmuGBql0RhpS+du1TrZ/HL5e680BqLSS/3s8+Nzz4+X/R2PX9Rqk7+zd8MjY6qssGWh+VOBylxkSTJO0j+jtGCyfPd2YZIOVCe+lo7Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WiJg5Kp8; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712072548; x=1743608548;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y43cM1loEB/xdiC5XlfYWF8K/xbUbOlgMRJmmCex1Yc=;
  b=WiJg5Kp8+pMN4zwvQ6iQqzQjYtDq4SNlG02RGUCLdzpbKNCkEf9NTRZY
   xJ6Fqx1upEsCdgk2ShTq6l0Kaqu2oFwluZauJU5ZBffhzKqffAmjaom9J
   dzpC8lp5bgsjmyHBtheA1ojXlbwoihiiZE4Dkdw5C51sTKMrf1Hzos5fH
   DxD0dCXzz8nXj03ydSeY3NwP94wp5i2njok+0XUktNvh7mIwwwfgl6grN
   WSWAAprIGL/ZnAAI0TtTMpiFtb8MABsYxSaqK0oasdOHsL6hIvdcgZ3RV
   su6opBvXyscbu9rp811KALTeBLMueI84qUanJDM/l3mWrZ0PDnIp4xIu1
   A==;
X-CSE-ConnectionGUID: 6mPP2k/7TyeP3TEZnTcXjA==
X-CSE-MsgGUID: 4LrL9gv6QTuNZCCojaH1Xg==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="17870065"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="17870065"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 08:42:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="937083640"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="937083640"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 02 Apr 2024 08:42:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 6FECB6F5; Tue,  2 Apr 2024 18:42:20 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 06/16] serial: max3100: Replace custom polling timeout with standard one
Date: Tue,  2 Apr 2024 18:38:12 +0300
Message-ID: <20240402154219.3583679-7-andriy.shevchenko@linux.intel.com>
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

Serial core provides a standard timeout for polling modem state.
Use it instead of a custom approach.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/max3100.c | 25 +++++--------------------
 1 file changed, 5 insertions(+), 20 deletions(-)

diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index 0931d7be9c62..d4f0ea97a698 100644
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
@@ -768,9 +756,6 @@ static int max3100_probe(struct spi_device *spi)
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


