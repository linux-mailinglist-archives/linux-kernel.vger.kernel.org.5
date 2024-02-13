Return-Path: <linux-kernel+bounces-64183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7EE853B49
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 20:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5303A1F2266B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D9660DE2;
	Tue, 13 Feb 2024 19:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c64hZ0Z6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54EF60BBA;
	Tue, 13 Feb 2024 19:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707853115; cv=none; b=fyq32k/41N3b0shE9tBrIInV7n3jYs8HK5wAq3gMwSy28qR0gy1snnQ5FlcBq04RLWWmuW+kk0JNUkJ7D16dNTKJmTGo7MKkxLPFgcbogUeCglekUc3B6iybAk1DYX+H8dta3xZb6nQdE96DJ6UtvNN95vE88LCvT4BLbCQdafY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707853115; c=relaxed/simple;
	bh=o7LkJqrD2vVgnZLqnrQyG9cxpNtR87PcZfpLb0iubAs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HB5dvi3Lir0FLgfyzgqKky7BnUD266BGdim0/N80lFx368ar5q3PQ/DEfB/I+f1YDt72WJFUhS60t54R32Er7f+ZHPbGLuWqEySn0cAz8XqYLUZp32Bgh6x5owbQhmQbuqi9mJ8YiTNJw1MnDYby0SVR/yXxHAEha6K9iqR7pug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c64hZ0Z6; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707853114; x=1739389114;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=o7LkJqrD2vVgnZLqnrQyG9cxpNtR87PcZfpLb0iubAs=;
  b=c64hZ0Z6KDWtbLqDK1EWddXRn9CYFp2NsAwfGuvCe2wMmKJgkJIpwWo4
   0bfFhnAc95ZYD62J1VXi0X7uTKBeHX5E68W3+JJ2cFYprr2JlVM+5oxqx
   VTkqbpBs6Latf7Wy/hKcAflouzzzaxZYr0e0kylZv9Au8HFk/k5jb2ztH
   HNS9yhhtohNGFaxgvsPnYbHWzE0fUSzxwl2y7KCa2eqSM/n0MrfjmTwP6
   xDlI923AZOWYndZ1SW0j0hXhEUZgxq/f4AgEHXPdsr3zAqPOPaHDp5i4G
   ya8NmTpJq2YcKt6YYqEjDmdHuxBSv+iB8flV7JLIir1aEqke0WC4yrh/e
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="24351138"
X-IronPort-AV: E=Sophos;i="6.06,158,1705392000"; 
   d="scan'208";a="24351138"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 11:38:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="935435642"
X-IronPort-AV: E=Sophos;i="6.06,158,1705392000"; 
   d="scan'208";a="935435642"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 13 Feb 2024 11:38:30 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 9006C184; Tue, 13 Feb 2024 21:38:29 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rengarajan S <rengarajan.s@microchip.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
	Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] serial: 8250_pci1xxxx: Don't use "proxy" headers
Date: Tue, 13 Feb 2024 21:38:27 +0200
Message-ID: <20240213193827.3207353-1-andriy.shevchenko@linux.intel.com>
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
 drivers/tty/serial/8250/8250_pci1xxxx.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci1xxxx.c b/drivers/tty/serial/8250/8250_pci1xxxx.c
index 356972734b29..55eada1dba56 100644
--- a/drivers/tty/serial/8250/8250_pci1xxxx.c
+++ b/drivers/tty/serial/8250/8250_pci1xxxx.c
@@ -7,23 +7,31 @@
  *  Copyright (C) 2022 Microchip Technology Inc., All Rights Reserved.
  */
 
+#include <linux/array_size.h>
 #include <linux/bitfield.h>
-#include <linux/bitops.h>
-#include <linux/delay.h>
+#include <linux/bits.h>
+#include <linux/circ_buf.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/gfp_types.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
-#include <linux/kernel.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/overflow.h>
 #include <linux/pci.h>
+#include <linux/pm.h>
 #include <linux/serial_core.h>
 #include <linux/serial_reg.h>
 #include <linux/serial_8250.h>
-#include <linux/slab.h>
+#include <linux/spinlock.h>
 #include <linux/string.h>
-#include <linux/units.h>
+#include <linux/time.h>
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
-#include <linux/8250_pci.h>
+#include <linux/types.h>
+#include <linux/units.h>
 
 #include <asm/byteorder.h>
 
-- 
2.43.0.rc1.1.gbec44491f096


