Return-Path: <linux-kernel+bounces-67078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B118565DD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11007287AFC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11261131E3D;
	Thu, 15 Feb 2024 14:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R9Uqj+pU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D9012FB33
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 14:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708006985; cv=none; b=uGALnp+f1c4hBaQu0et8dWfu4ypKz5rCWYdn17aWryleorTs54el28hCA1+U27yAW0Nn+8R7pf1LcQqSXHHnQZ61Hg164QGK3y0NOPWIBsvpqIFSTo5hymgQp/CX1+NC6MsY5UJ18Xd0g0x1f3uPlIlo7WP/pWRn0vHfpYseJ4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708006985; c=relaxed/simple;
	bh=2RVMz33IPphnSIv42/mrBHY11d1m9VH2c0zn+MbagJA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YVW59tfs5n3aOhZtOWt06l1nna/9nrxQVvCGhK7eQMSLLBIe0tpIX+3iHfljTeVDY3Q7ctKcp31+HTRXzpgA9an9EWhmig4O+G0j36WNhi/u/lB5fy0IStnNVvdmxup0wth76G/UR3stb4Jxh+zO2bVEO7J2hZD4nuRA6loY7mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R9Uqj+pU; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708006983; x=1739542983;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2RVMz33IPphnSIv42/mrBHY11d1m9VH2c0zn+MbagJA=;
  b=R9Uqj+pUOjoweyb+DbRcFlTWC97LGfSnOkqcx7BkPlYEsQKw2bYzdNFn
   uDxz8126h0f6DyAoPIU5WWU8U9mC2PiDhDpy4Bn8W8CqgJ3kxRQ5Fpw3A
   flTHUJ+o9dnojazE95UN6OLCWW4fJwQc9TTUaz70t624X4WeH9ggVXaKy
   ARzYRjFyvK+wQFuXJYDLPzO4aVvq+uzYbRDkH3PsTEoJXBgZNIpGayvto
   OyeLKdjYVM2djsGynyAqVJG+7KSIEXDakW83AnecXxqftHSfXPMsyo3bb
   8p5AtaR87JhIZy6jjEcQUVMUEyKeC5BTcN4QbMPy2Ees3PcjbRXv7K6iz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="24560147"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="24560147"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 06:23:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="935673858"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="935673858"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 15 Feb 2024 06:22:57 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 4654D20B; Thu, 15 Feb 2024 16:22:56 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Steven Rostedt (Google)" <rostedt@goodmis.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] seq_buf: Don't use "proxy" headers
Date: Thu, 15 Feb 2024 16:22:55 +0200
Message-ID: <20240215142255.400264-1-andriy.shevchenko@linux.intel.com>
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
 include/linux/seq_buf.h |  5 ++++-
 lib/seq_buf.c           | 14 ++++++++++++--
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/include/linux/seq_buf.h b/include/linux/seq_buf.h
index c44f4b47b945..07b26e751060 100644
--- a/include/linux/seq_buf.h
+++ b/include/linux/seq_buf.h
@@ -2,7 +2,10 @@
 #ifndef _LINUX_SEQ_BUF_H
 #define _LINUX_SEQ_BUF_H
 
-#include <linux/fs.h>
+#include <linux/bug.h>
+#include <linux/minmax.h>
+#include <linux/seq_file.h>
+#include <linux/types.h>
 
 /*
  * Trace sequences are used to allow a function to call several other functions
diff --git a/lib/seq_buf.c b/lib/seq_buf.c
index 010c730ca7fc..dfbfdc497d85 100644
--- a/lib/seq_buf.c
+++ b/lib/seq_buf.c
@@ -13,9 +13,19 @@
  * seq_buf_init() more than once to reset the seq_buf to start
  * from scratch.
  */
-#include <linux/uaccess.h>
-#include <linux/seq_file.h>
+
+#include <linux/bug.h>
+#include <linux/err.h>
+#include <linux/export.h>
+#include <linux/hex.h>
+#include <linux/minmax.h>
+#include <linux/printk.h>
 #include <linux/seq_buf.h>
+#include <linux/seq_file.h>
+#include <linux/sprintf.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <linux/uaccess.h>
 
 /**
  * seq_buf_can_fit - can the new data fit in the current buffer?
-- 
2.43.0.rc1.1.gbec44491f096


