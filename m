Return-Path: <linux-kernel+bounces-98645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FC9877D2B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE7E0281CB1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B6818AE8;
	Mon, 11 Mar 2024 09:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c+u7xqhI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B66179B7;
	Mon, 11 Mar 2024 09:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710150366; cv=none; b=nrtRIKVG8VlktiZgJqVNCfv/52VKot/1Q/IJge1xFXHEOeJZI6j7soSvnlTh2qWa5wR+YwgfmyACP8sofd7CbTYqstMGK9sXXJ8hf4IIfqFSXMh4H2HesHlXr5Sz7PomnYQk5PP2MS+OaUmOe+FThH/IRmE7Jv5G8nSsVPE91+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710150366; c=relaxed/simple;
	bh=+mkY7KrHMRxBKwLjX5eeMIcQrmgsR0RArxs9P1e+ZOw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dEzW+6IEcpJJZ8usaPzogoJE3/AdHZI2M3EmjnInXVpsT0lpFq9FIhzd0Btw3wIookZjgQ+ZW/Qf147O8xDIaqVclguSt80x0L5RsJYJRMoD2ULd+9ddKDBUNUab7nLIUw7JUsEtf8ziMOYSIjn8KHimsj20nP18J6pKeJoIl44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c+u7xqhI; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710150364; x=1741686364;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+mkY7KrHMRxBKwLjX5eeMIcQrmgsR0RArxs9P1e+ZOw=;
  b=c+u7xqhIi50SwZJQsA5VMkDaj4dgYRT2VjOTmj8Pydyb4PCa/N35+DZL
   xyWqV2HbbCI+fHJRVbuFRn3lXUDX93R9k9rf9kqM4+VG5dYkIKqf8Bq5/
   uPzMuAhcgt0BA1GwRw4obtxBIOnv3MZCO2X5uGHxEFxBcqXjIrRc9aQs1
   Oc7/RhHHHEScyXMPddx75fYup9w2mftOwJ+uVq/uOIg6RXmFSReIqedp+
   XR2n5SMg8/4ILST3eUcdlW/vPvs/gb4Dt/jtqjiV01K/I0N8dkTQqp0Xs
   sjaCDfyGMPTH1H9CmF75UsVbha5ly5yVXGcl1PoCZDApB6Mvel2VhS6Sf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="8622997"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="8622997"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 02:46:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="937049477"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="937049477"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 11 Mar 2024 02:46:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 2BCB6204; Mon, 11 Mar 2024 11:46:00 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: John Crispin <john@phrozen.org>,
	Sergio Paracuellos <sergio.paracuellos@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v1 1/1] MIPS: ralink: Don't use "proxy" headers
Date: Mon, 11 Mar 2024 11:45:58 +0200
Message-ID: <20240311094559.547083-1-andriy.shevchenko@linux.intel.com>
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

Fixes: 5804be061848 ("MIPS: ralink: Remove unused of_gpio.h")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202403090727.nLhljNp6-lkp@intel.com/
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/mips/ralink/timer.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/mips/ralink/timer.c b/arch/mips/ralink/timer.c
index 8b485cbe854e..54094f6e033e 100644
--- a/arch/mips/ralink/timer.c
+++ b/arch/mips/ralink/timer.c
@@ -6,10 +6,16 @@
  * Copyright (C) 2013 John Crispin <john@phrozen.org>
 */
 
-#include <linux/platform_device.h>
-#include <linux/interrupt.h>
-#include <linux/timer.h>
+#include <linux/bits.h>
 #include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/timer.h>
+#include <linux/types.h>
 
 #include <asm/mach-ralink/ralink_regs.h>
 
-- 
2.43.0.rc1.1.gbec44491f096


