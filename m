Return-Path: <linux-kernel+bounces-67257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 471258568B8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 050AF290E22
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DAC11353EE;
	Thu, 15 Feb 2024 16:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AvvRB9ip"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12015134CDD;
	Thu, 15 Feb 2024 16:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708012965; cv=none; b=n4QffQSPGyT9xO/96rst4auUuW8iY55SZVQD+P/QORNOqzkLXQsJbyYDONgjUUrGLga3cXJf39ZjhZp/BOWra6UvQWStUMxZS2/OskqVDBLpePezr/qpxom1BBNNnEiKm19SjqKYpJOvd8r9def0GGxWpKTLG0yzj+6KrU0O5jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708012965; c=relaxed/simple;
	bh=ge/zuWB1BjZSun2O80x3sHKgvzwxKxsHTgxhF2+KWu8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WFcaeIqNmSp5ZUlgM5lkG5STL53/ScE4tSPsnXtmeHNKmN+lUEPziHkf4YAvrUElSsGQcNxxlDKnvxkjLOtZ0HWXXsjG0U+JyrQAQlLyob9QrvIs1sf3EaTe4nIIAMi4SsHaP9iOYYO88NQie541afqbGzExwfGCKcfTGUeYR5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AvvRB9ip; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708012965; x=1739548965;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ge/zuWB1BjZSun2O80x3sHKgvzwxKxsHTgxhF2+KWu8=;
  b=AvvRB9ipm2VovBhACaqhXNciyHsepHb41AXcPSPGv9LrvQAnruXGP7cW
   H+xROfhSo423E+WHmQeJwHcTQNBoB3JQp1kNckuLU5Asd7HLYmHSHz706
   rHTFvutW8yL8lRE+/iH9jPmXdhSPr+H/6X6B/tO0zOy7OQkNNu7JOQ3pC
   LgqETMu+azO1QV1ucKfFMJerwIVpL5oz7WLfZmMXPjZZCkU77JmQcIlLV
   wAxffkxjhLZMtFCl2WUVfMCLd/9w5+x3KqGa40WCK00COZvvQH4mYMW3z
   /wxeAqQSLdJgdqcBhPaTqYDCtRq+nvXBufovhurMTD7mab43V/gr2yUal
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="19525816"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="19525816"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 08:02:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="935684857"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="935684857"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 15 Feb 2024 08:02:37 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id DBD95204; Thu, 15 Feb 2024 18:02:35 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Al Cooper <alcooperx@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] serial: 8250_bcm7271: Replace custom unit definitions
Date: Thu, 15 Feb 2024 18:02:34 +0200
Message-ID: <20240215160234.653305-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace custom unit definitions that are available via units.h.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_bcm7271.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_bcm7271.c b/drivers/tty/serial/8250/8250_bcm7271.c
index 504c4c020857..1532fa2e8ec4 100644
--- a/drivers/tty/serial/8250/8250_bcm7271.c
+++ b/drivers/tty/serial/8250/8250_bcm7271.c
@@ -22,6 +22,7 @@
 #include <linux/delay.h>
 #include <linux/clk.h>
 #include <linux/debugfs.h>
+#include <linux/units.h>
 
 #include "8250.h"
 
@@ -187,21 +188,19 @@
 #define TX_BUF_SIZE 4096
 #define RX_BUF_SIZE 4096
 #define RX_BUFS_COUNT 2
-#define KHZ    1000
-#define MHZ(x) ((x) * KHZ * KHZ)
 
 static const u32 brcmstb_rate_table[] = {
-	MHZ(81),
-	MHZ(108),
-	MHZ(64),		/* Actually 64285715 for some chips */
-	MHZ(48),
+	81 * HZ_PER_MHZ,
+	108 * HZ_PER_MHZ,
+	64 * HZ_PER_MHZ,		/* Actually 64285715 for some chips */
+	48 * HZ_PER_MHZ,
 };
 
 static const u32 brcmstb_rate_table_7278[] = {
-	MHZ(81),
-	MHZ(108),
+	81 * HZ_PER_MHZ,
+	108 * HZ_PER_MHZ,
 	0,
-	MHZ(48),
+	48 * HZ_PER_MHZ,
 };
 
 struct brcmuart_priv {
-- 
2.43.0.rc1.1.gbec44491f096


