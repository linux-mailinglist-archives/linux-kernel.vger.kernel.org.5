Return-Path: <linux-kernel+bounces-79105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F389861D9C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70C441C20A08
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E091C146E66;
	Fri, 23 Feb 2024 20:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PrBGB+Pt"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1916143C63;
	Fri, 23 Feb 2024 20:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708720107; cv=none; b=DQHOvE6f/z6/dUNA78PC+Ys1YpzladWmIYeQTxHyBAkLtkG1hiIv1efwidY7dFPNRDPd5B4vtx+9cGeIEYjrbAKpO5hWCbqPBmk+RjZ7DMgtxWCiE2BJdoUfoE2Wfoaoan6UbPUr1TZK+JglxBpZhNcQbYVHfSQlW5Bl2/4sncg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708720107; c=relaxed/simple;
	bh=X+QPIuS/gA9uBqcR8AeIe4WwFzeO2SwHTyFgIoUO3Ng=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MO72+QdlzBznq5YaE/Z8ssgLVJdCMRPDkBTsLSmv/nbtw3GozYUx1woXIcboSOyV06vCJxgRo83LO0b4Z9J+PaYYf/mn9PC1OV+65wyawHnLPkZtGixQXB99u8euwdN3n8LLdOTv9jgXn+jR5fZlrmkn0qW7k1JQMcUcLkSIrvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PrBGB+Pt; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708720106; x=1740256106;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=X+QPIuS/gA9uBqcR8AeIe4WwFzeO2SwHTyFgIoUO3Ng=;
  b=PrBGB+PtvMTCeIy1a0pR6logVL2JAgOg1+tBLbrx1ySsoJUkCFUEhxw/
   wJBfgElxcZhNnGaAz3MaeavyFFK8D+ztWPa/bJLEFYa5fjNQSTG1HmByF
   aTa+YUMRh5SBD5JrI7u0elWt4wIp0OakORSbKHfd52n13i29OFN3t9lnO
   3sCJ90/Njb7GZCiOqF68kriJYq/7J2jbP6RX7TUYyyLKjN8d4zaM0yZnW
   8Al7pyIOZcnD+zhTAdvhejX4kC6MS5ioWzHy88klNTVQoopGgSmDixkkx
   eAZqiloNi+RBgQxacOFWtLghZoMNhD5bsgk1N3bdz0BgyE5cLd9CxgICH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="13757930"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="13757930"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 12:28:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="937025698"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="937025698"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 23 Feb 2024 12:28:22 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id F24F934C; Fri, 23 Feb 2024 22:28:20 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>
Subject: [PATCH v1 1/1] leds: expresswire: Don't use "proxy" headers
Date: Fri, 23 Feb 2024 22:28:16 +0200
Message-ID: <20240223202816.880938-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update header inclusions to follow IWYU (Include What You Use)
principle.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/leds/leds-expresswire.c  | 3 +++
 include/linux/leds-expresswire.h | 4 +++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/leds/leds-expresswire.c b/drivers/leds/leds-expresswire.c
index 89e147b0e019..8176356aafac 100644
--- a/drivers/leds/leds-expresswire.c
+++ b/drivers/leds/leds-expresswire.c
@@ -6,7 +6,10 @@
  */
 
 #include <linux/delay.h>
+#include <linux/export.h>
 #include <linux/gpio/consumer.h>
+#include <linux/types.h>
+
 #include <linux/leds-expresswire.h>
 
 void expresswire_power_off(struct expresswire_common_props *props)
diff --git a/include/linux/leds-expresswire.h b/include/linux/leds-expresswire.h
index 3c61902ccac8..a422921f4159 100644
--- a/include/linux/leds-expresswire.h
+++ b/include/linux/leds-expresswire.h
@@ -8,7 +8,9 @@
 #ifndef _LEDS_EXPRESSWIRE_H
 #define _LEDS_EXPRESSWIRE_H
 
-#include <linux/gpio/consumer.h>
+#include <linux/types.h>
+
+struct gpio_desc;
 
 struct expresswire_timing {
 	unsigned long poweroff_us;
-- 
2.43.0.rc1.1.gbec44491f096


