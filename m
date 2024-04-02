Return-Path: <linux-kernel+bounces-128258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 931FB895868
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BE25B24EE3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231B2134CEC;
	Tue,  2 Apr 2024 15:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E8dGIuV/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C0B13342C;
	Tue,  2 Apr 2024 15:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712072549; cv=none; b=ATQQuVJaZLKC1es2MsX/sIVKUD3pR+0NvZW9c5GFhVnsnZaRb2ckx9PqDa0lFDpxg0SAkyVVMGH/pt71WF+RlQw1FCvp2UxHBG7lNKzJqhVhpXK1w65aYp8z6tfbkXPi3JVIjHMYkUC+uw4MQCnOjcJ6sxsu7tmHLGr3E9imCHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712072549; c=relaxed/simple;
	bh=zZMOnIzQZrnHgzBuQ7c9CjMUprZPaXtN+6HEIt6BE4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EuYf1RuqVnoC9g8J9Oikh57tAzYhqDfbJskHZbCO8T2pqMlPlkbVzhD4ZPxNtXPd+1GGkBNV+JtujVBKlbXiXraOUNfbetHHj0bff4MbDENSrYKKpSGgu/MhXub+UanDznttuQN9zwaFdbOjeFZZY5WU2YaNtEcryAuM3tm9/yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E8dGIuV/; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712072547; x=1743608547;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zZMOnIzQZrnHgzBuQ7c9CjMUprZPaXtN+6HEIt6BE4I=;
  b=E8dGIuV/9jofqMGmcRo3NGIWzb84QvbcjUo+Y2REbupUQMqC+4kW3232
   jC8qgalj5oBJ5LxV2Y0rHnW1BVLrthixXXVEtt/UftvMwvVUqqy0BEIjA
   j8ijLoDvH00ltKifqCvr1QyBJye9YVPM+2Ob8RfktwUh5hvIwEP+FgBE2
   G/f2w+WtjEGwPUtcGFXsiSw1gXhqgyrXnXgRTFrjr2XalGxawP0wryfNo
   kKepPDYMga9w1jC2jDj/3pGdAPdWX3WQm3l53vCsznUZQti2nPBOwJ0cd
   VC8SbPd7SmYwUOM8ztn+ZNeVAYSq5+Xwvh/mQj7eFjSlvNruvbzOpX8ah
   w==;
X-CSE-ConnectionGUID: gbSlrTjuSjqRmi5ar21O/A==
X-CSE-MsgGUID: vpcGwvtYRCW+krWR5TrSJA==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="17870061"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="17870061"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 08:42:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="937083639"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="937083639"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 02 Apr 2024 08:42:21 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 5600357D; Tue,  2 Apr 2024 18:42:20 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 04/16] serial: max3100: Make struct plat_max3100 local
Date: Tue,  2 Apr 2024 18:38:10 +0300
Message-ID: <20240402154219.3583679-5-andriy.shevchenko@linux.intel.com>
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
index 3c68b8e1a226..f30050248130 100644
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


