Return-Path: <linux-kernel+bounces-128608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8A3895D08
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52FC528621E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DED015CD64;
	Tue,  2 Apr 2024 19:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NxigBuYs"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C56715B96A;
	Tue,  2 Apr 2024 19:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712087595; cv=none; b=PPlsb+OS1Bz6ibCO38R5/8vwf5a+G4Q1mmU5zZ8pF6gJa+qc9RLNoCauIYQriYsCAkE2lMHVJoZB4fNpQZ8l+k/mASmuZeOl3EAy69lfKtM+Pe7miJoIEtVxsWehHemlkBwO5D6uysJAEwMdPe4eZYKdtT/WqaGt9po15smDWdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712087595; c=relaxed/simple;
	bh=1UzMmpdJ3SyH/zn8EcKQjxnq5OJVXRSw4sEYO55O31c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FLHjTKxehULA3+5L9nmfwWHkXDBzySPDhJWRW3Ten9uWvoUTHDZmmUub13Wdla7+/fOfuK1DRU/9P+9kQOTcZGea8bg6D95KJqkNlYnh/EKb0DU/vJnmJ+LPJZIshLoUuuqwj53mNOvnh6nck3YqU4MrYcLOHBes+86Tf0LdWeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NxigBuYs; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712087594; x=1743623594;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1UzMmpdJ3SyH/zn8EcKQjxnq5OJVXRSw4sEYO55O31c=;
  b=NxigBuYs/KhhLDd99ZK1ij3qrZp3GxRQthng8XKsGclOwa2AWHrH6NwH
   LY4LcNpUIvNVls/5LfFhLFlBpIlWB/8V8qos3zEBYMcaFPCL1y1Nv+oh7
   iGjpdgQVZuMEHbbJ614zYTKM8LI9x6GPSPqny8zOlAlYDm/ZEJq3qORnR
   +uNzsCJqDbvtko+UEIrwX4IV6jZewIoZcLdhQzSFd9vKpd7CNQZZzPI7d
   bTGyiZQV2u5qPtx4prY7aALaAwiqjQt+xCUGQFyhGelEefUr3zaVfbeTD
   qZVsBbBHGmin2YxI0ltgsQX6FwdOBgmLgwAPcxAZ7+O92nHJcUPBs06A5
   A==;
X-CSE-ConnectionGUID: qA3a4RotSDORZNgf9VvLpw==
X-CSE-MsgGUID: dSTH3/2ASRK6DUSxNkWeDA==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7150988"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="7150988"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 12:53:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="937083782"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="937083782"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 02 Apr 2024 12:53:10 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id D746957D; Tue,  2 Apr 2024 22:53:09 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hugo@hugovil.com>
Subject: [PATCH v2 04/16] serial: max3100: Make struct plat_max3100 local
Date: Tue,  2 Apr 2024 22:50:31 +0300
Message-ID: <20240402195306.269276-5-andriy.shevchenko@linux.intel.com>
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

There is no user of the struct plat_max3100 outside the driver.
Inline its contents into the driver. While at it, drop outdated
example in the comment.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/max3100.c   | 38 +++++++++++++--------------
 include/linux/serial_max3100.h | 48 ----------------------------------
 2 files changed, 18 insertions(+), 68 deletions(-)
 delete mode 100644 include/linux/serial_max3100.h

diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index 3d2b83d6ab51..031803a5da58 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- *
  *  Copyright (C) 2008 Christian Pellegrin <chripell@evolware.org>
  *
  * Notes: the MAX3100 doesn't provide an interrupt on CTS so we have
@@ -8,24 +7,6 @@
  * writing conf clears FIFO buffer and we cannot have this interrupt
  * always asking us for attention.
  *
- * Example platform data:
-
- static struct plat_max3100 max3100_plat_data = {
- .loopback = 0,
- .crystal = 0,
- .poll_time = 100,
- };
-
- static struct spi_board_info spi_board_info[] = {
- {
- .modalias	= "max3100",
- .platform_data	= &max3100_plat_data,
- .irq		= IRQ_EINT12,
- .max_speed_hz	= 5*1000*1000,
- .chip_select	= 0,
- },
- };
-
  * The initial minor number is 209 in the low-density serial port:
  * mknod /dev/ttyMAX0 c 204 209
  */
@@ -49,7 +30,24 @@
 
 #include <asm/unaligned.h>
 
-#include <linux/serial_max3100.h>
+/**
+ * struct plat_max3100 - MAX3100 SPI UART platform data
+ * @loopback:            force MAX3100 in loopback
+ * @crystal:             1 for 3.6864 Mhz, 0 for 1.8432
+ * @max3100_hw_suspend:  MAX3100 has a shutdown pin. This is a hook
+ *                       called on suspend and resume to activate it.
+ * @poll_time:           poll time for CTS signal in ms, 0 disables (so no hw
+ *                       flow ctrl is possible but you have less CPU usage)
+ *
+ * You should use this structure in your machine description to specify
+ * how the MAX3100 is connected.
+ */
+struct plat_max3100 {
+	int loopback;
+	int crystal;
+	void (*max3100_hw_suspend) (int suspend);
+	int poll_time;
+};
 
 #define MAX3100_C    (1<<14)
 #define MAX3100_D    (0<<14)
diff --git a/include/linux/serial_max3100.h b/include/linux/serial_max3100.h
deleted file mode 100644
index befd55c08a7c..000000000000
--- a/include/linux/serial_max3100.h
+++ /dev/null
@@ -1,48 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- *
- *  Copyright (C) 2007 Christian Pellegrin
- */
-
-
-#ifndef _LINUX_SERIAL_MAX3100_H
-#define _LINUX_SERIAL_MAX3100_H 1
-
-
-/**
- * struct plat_max3100 - MAX3100 SPI UART platform data
- * @loopback:            force MAX3100 in loopback
- * @crystal:             1 for 3.6864 Mhz, 0 for 1.8432
- * @max3100_hw_suspend:  MAX3100 has a shutdown pin. This is a hook
- *                       called on suspend and resume to activate it.
- * @poll_time:           poll time for CTS signal in ms, 0 disables (so no hw
- *                       flow ctrl is possible but you have less CPU usage)
- *
- * You should use this structure in your machine description to specify
- * how the MAX3100 is connected. Example:
- *
- * static struct plat_max3100 max3100_plat_data = {
- *  .loopback = 0,
- *  .crystal = 0,
- *  .poll_time = 100,
- * };
- *
- * static struct spi_board_info spi_board_info[] = {
- * {
- *  .modalias	= "max3100",
- *  .platform_data	= &max3100_plat_data,
- *  .irq		= IRQ_EINT12,
- *  .max_speed_hz	= 5*1000*1000,
- *  .chip_select	= 0,
- * },
- * };
- *
- **/
-struct plat_max3100 {
-	int loopback;
-	int crystal;
-	void (*max3100_hw_suspend) (int suspend);
-	int poll_time;
-};
-
-#endif
-- 
2.43.0.rc1.1.gbec44491f096


