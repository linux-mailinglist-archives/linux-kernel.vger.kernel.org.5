Return-Path: <linux-kernel+bounces-8954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC79581BE7E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 782F5283C97
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3F265193;
	Thu, 21 Dec 2023 18:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NRSvr9xw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C636518B;
	Thu, 21 Dec 2023 18:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703184631; x=1734720631;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6lqfECsnx9YNGz7mNu1P1q5RcYfS8nYI6pc/nxTM7UQ=;
  b=NRSvr9xwu8uUsCJvIuUNMSq4vmzVfwdjoepfVThM+cj1amxFYXz1HfN4
   aeGC0pFU0JNpOqZJu3snBaAIwYrRsY4Nhccg90CsH+07tC4mQV/NBdfiJ
   QyEOTYO0FyfXRDDos3biRWv+ktHvIiu220Xdla3tN9f13bb8OArZgoLMh
   eGW2nRaGFFrB5wXKXLd2kWYBu12kB1fEqGICz5xm95FsvMskLDNPQFjX/
   XjX8U8qPFQJF5wu4q2+RZ7r+j80cRgSH9CsP4fmmZmlMzUU5PBLELdIg8
   MILUq2Yp3fLFw2dnPLCar6VdLmL4yimdGQZboNThB1DKE1ntADzlqlC7s
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="462463230"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="462463230"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 10:50:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="920407804"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="920407804"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 21 Dec 2023 10:50:28 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 93260B8; Thu, 21 Dec 2023 19:55:28 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] gpiolib: cdev: Split line_get_debounce_period() and use
Date: Thu, 21 Dec 2023 19:55:27 +0200
Message-ID: <20231221175527.2814506-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of repeating the same code and reduce possible miss
of READ_ONCE(), split line_get_debounce_period() heler out
and use in the existing cases.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-cdev.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 744734405912..c573820d5722 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -651,6 +651,16 @@ static struct line *supinfo_find(struct gpio_desc *desc)
 	return NULL;
 }
 
+static unsigned int line_get_debounce_period(struct line *line)
+{
+	return READ_ONCE(line->debounce_period_us);
+}
+
+static inline bool line_has_supinfo(struct line *line)
+{
+	return line_get_debounce_period(line);
+}
+
 static void supinfo_to_lineinfo(struct gpio_desc *desc,
 				struct gpio_v2_line_info *info)
 {
@@ -665,15 +675,10 @@ static void supinfo_to_lineinfo(struct gpio_desc *desc,
 
 	attr = &info->attrs[info->num_attrs];
 	attr->id = GPIO_V2_LINE_ATTR_ID_DEBOUNCE;
-	attr->debounce_period_us = READ_ONCE(line->debounce_period_us);
+	attr->debounce_period_us = line_get_debounce_period(line);
 	info->num_attrs++;
 }
 
-static inline bool line_has_supinfo(struct line *line)
-{
-	return READ_ONCE(line->debounce_period_us);
-}
-
 /*
  * Checks line_has_supinfo() before and after the change to avoid unnecessary
  * supinfo_tree access.
@@ -846,7 +851,7 @@ static enum hte_return process_hw_ts(struct hte_ts_data *ts, void *p)
 		line->total_discard_seq++;
 		line->last_seqno = ts->seq;
 		mod_delayed_work(system_wq, &line->work,
-		  usecs_to_jiffies(READ_ONCE(line->debounce_period_us)));
+				 usecs_to_jiffies(line_get_debounce_period(line)));
 	} else {
 		if (unlikely(ts->seq < line->line_seqno))
 			return HTE_CB_HANDLED;
@@ -987,7 +992,7 @@ static irqreturn_t debounce_irq_handler(int irq, void *p)
 	struct line *line = p;
 
 	mod_delayed_work(system_wq, &line->work,
-		usecs_to_jiffies(READ_ONCE(line->debounce_period_us)));
+			 usecs_to_jiffies(line_get_debounce_period(line)));
 
 	return IRQ_HANDLED;
 }
@@ -1215,7 +1220,7 @@ static int edge_detector_update(struct line *line,
 			gpio_v2_line_config_debounce_period(lc, line_idx);
 
 	if ((active_edflags == edflags) &&
-	    (READ_ONCE(line->debounce_period_us) == debounce_period_us))
+	    (line_get_debounce_period(line) == debounce_period_us))
 		return 0;
 
 	/* sw debounced and still will be...*/
-- 
2.43.0.rc1.1.gbec44491f096


