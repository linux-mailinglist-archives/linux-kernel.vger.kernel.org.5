Return-Path: <linux-kernel+bounces-128264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB64895876
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 563C21F25036
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637D4134403;
	Tue,  2 Apr 2024 15:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OKapIKiQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2178135A5F;
	Tue,  2 Apr 2024 15:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712072553; cv=none; b=Y4nDYodjeak1CP5l5EcijGDejX4AW0arD+pZjRaPnWcYLm5gQNB9aYmw89bJhdj/MfJjN+3wGC4D93k/dJxvBcfiK5GLFX7JIlEvZDc3oeXagu5rxKJPp7UmXDIgSkYbq05n3pDeQn5MGfoy/Hrdin0FA5yzBwQznsQyab1ihAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712072553; c=relaxed/simple;
	bh=nPKJLyGWUAo20JnttXNN/dLtu3GQiMS1v2MSYR4PCTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aQpbJm+Ha4znPlem90KV4UwTj9g+413U3ifV3M/jq+HTjUnrsgMX3cYRsYJzvTIPNVvK4HJV8K1tejV34GVBkFpdn6X9SkvD2ZXVGT7vBt5h6VYg0Ns6N/opjkKFxyl9nSO3qPcI9pBHj470xdWVtgKMlw+oFoXwPzR1TttelKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OKapIKiQ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712072551; x=1743608551;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nPKJLyGWUAo20JnttXNN/dLtu3GQiMS1v2MSYR4PCTE=;
  b=OKapIKiQnpaAzPbdKpkNg23I+AwZWYh0aiEeTU34pkTkzFZNNzFLrVxF
   fCI2ys43UeC8gHkwSNZpPxP0UcScsvK953ZgSGz0cqZA7fkQGXFM7NxiE
   +QHTQ0WsMpq/ihWbze+pZxsfe7Cl3/372kvA3j/e3civzyJASKJj6zm4J
   xyfmcFVwDz8K6l3B0qUOGMApeYv2+mFYy3/7qpsm/vP8DINrtZhizBG25
   /uQDMQs1XAhMGgTvsv2D9BwymP3KAwWdYTIWr3SNbxuTrMeMm+uVzqT+V
   I7RHIe8Byn6gxChvVGvPF+xDHLybGDa2VdQEcQ5Nsqx27FqReoxo/iHQ1
   Q==;
X-CSE-ConnectionGUID: t/I/g15RQIyG/oH2ePlKPg==
X-CSE-MsgGUID: eGlWa7aJS4mL1ofe6KwveQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="17870089"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="17870089"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 08:42:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="937083648"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="937083648"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 02 Apr 2024 08:42:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id C8ED716A6; Tue,  2 Apr 2024 18:42:20 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 14/16] serial: max3100: Remove unneeded forward declaration
Date: Tue,  2 Apr 2024 18:38:20 +0300
Message-ID: <20240402154219.3583679-15-andriy.shevchenko@linux.intel.com>
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

There is no code using max3100_work() before the definition of it.
Remove unneeded forward declaration.

While at it, move max3100_dowork() and max3100_timeout() down in
the code to be after actual max3100_work() implementation.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/max3100.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index 19b05992a9ac..e63ac027b4f3 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -150,22 +150,6 @@ static void max3100_calc_parity(struct max3100_port *s, u16 *c)
 		*c |= max3100_do_parity(s, *c) << 8;
 }
 
-static void max3100_work(struct work_struct *w);
-
-static void max3100_dowork(struct max3100_port *s)
-{
-	if (!s->force_end_work && !freezing(current) && !s->suspending)
-		queue_work(s->workqueue, &s->work);
-}
-
-static void max3100_timeout(struct timer_list *t)
-{
-	struct max3100_port *s = from_timer(s, t, timer);
-
-	max3100_dowork(s);
-	mod_timer(&s->timer, jiffies + uart_poll_timeout(&s->port));
-}
-
 static int max3100_sr(struct max3100_port *s, u16 tx, u16 *rx)
 {
 	struct spi_message message;
@@ -313,6 +297,20 @@ static void max3100_work(struct work_struct *w)
 		tty_flip_buffer_push(&s->port.state->port);
 }
 
+static void max3100_dowork(struct max3100_port *s)
+{
+	if (!s->force_end_work && !freezing(current) && !s->suspending)
+		queue_work(s->workqueue, &s->work);
+}
+
+static void max3100_timeout(struct timer_list *t)
+{
+	struct max3100_port *s = from_timer(s, t, timer);
+
+	max3100_dowork(s);
+	mod_timer(&s->timer, jiffies + uart_poll_timeout(&s->port));
+}
+
 static irqreturn_t max3100_irq(int irqno, void *dev_id)
 {
 	struct max3100_port *s = dev_id;
-- 
2.43.0.rc1.1.gbec44491f096


