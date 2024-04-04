Return-Path: <linux-kernel+bounces-131965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFCD898E07
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8030C1F2AF75
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699441339B1;
	Thu,  4 Apr 2024 18:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kR0/QCx9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0BF131BDA;
	Thu,  4 Apr 2024 18:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712255703; cv=none; b=YwSz8L/6twm0rdcWkibmCyv4nJR9Wf7EQSSeBypMfSPtxZGYu35j4mbPGal6dMg39V3r0ILCLl1dOWCt+cclZYTg3SCOyqv5DxLr7ttDOxiTIctBQTW11BnExSwzCtwHdggiDEUdohuTfpNZl1Ht+W1RKp96QV3M0Vjqsqz37rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712255703; c=relaxed/simple;
	bh=gGIP0VcmWVeb4FjGcfVs8G6gKQwv5j8GvxXyZ+Ab4dY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eZWEomQuVMRWyIZv8rdYpwToHWkLMsWXPWgep4OgpfAdWo1dE9clHNefADQ6ORj34lzGNKrDURcZXuPNKvpDWviWu1gHDkxLBP1N/N57ILJyTDg88QS3rWeW2XPrfHHLjPVQlJX5y54hv1sTV/KauOVmooiDNZEYJzaTTzOn+U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kR0/QCx9; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712255702; x=1743791702;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gGIP0VcmWVeb4FjGcfVs8G6gKQwv5j8GvxXyZ+Ab4dY=;
  b=kR0/QCx9PhXt6n+Hx00fdn1zaOMTBLZP9qP0PO1t3nWyzacQUFm5Wsh+
   zsPPPXjgaSTIw6bvT5a+peQ/hGjI6XVmHPf2KeDf1qImiVrPUwRsbW7+z
   hhq1QwXBFND0vIksoiBgN8RF4TCjP5IGOrTu/vnOJ6tO0SDMaSrLYaHr6
   l1G0hHzYiu+XuDwGs/JcY1Miqj83K+233YzR6loVkoTdUyxDQm5iohfme
   AmxuQSWYEEu+BmFxTXiOmeMhZNwZVCc4zjgvQptVCBRAj0fWm0slZoxZ7
   AE/Z8QHVnK7wUYVR3RQqiiyN4pjFmJddeOjNBIwrkmBCQivgy7LAsxoph
   w==;
X-CSE-ConnectionGUID: l53S2XOaSC+HuQ5Mhx4gfg==
X-CSE-MsgGUID: 9FLdbH+7STq1i0YMTQMxYw==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="7751320"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="7751320"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 11:34:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="937086996"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="937086996"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Apr 2024 11:34:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id C0711CB3; Thu,  4 Apr 2024 21:34:54 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Zhang Rui <rui.zhang@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: [PATCH v2 4/4] ACPI: x86: Move LPSS to x86 folder
Date: Thu,  4 Apr 2024 21:23:42 +0300
Message-ID: <20240404183448.3310449-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240404183448.3310449-1-andriy.shevchenko@linux.intel.com>
References: <20240404183448.3310449-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LPSS is built solely for x86, move it to the respective folder.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/Makefile                    | 1 -
 drivers/acpi/internal.h                  | 3 ++-
 drivers/acpi/x86/Makefile                | 1 +
 drivers/acpi/{acpi_lpss.c => x86/lpss.c} | 2 +-
 4 files changed, 4 insertions(+), 3 deletions(-)
 rename drivers/acpi/{acpi_lpss.c => x86/lpss.c} (99%)

diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 6f4187a34f41..39ea5cfa8326 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -45,7 +45,6 @@ acpi-y				+= ec.o
 acpi-$(CONFIG_ACPI_DOCK)	+= dock.o
 acpi-$(CONFIG_PCI)		+= pci_root.o pci_link.o pci_irq.o
 obj-$(CONFIG_ACPI_MCFG)		+= pci_mcfg.o
-acpi-$(CONFIG_PCI)		+= acpi_lpss.o
 acpi-y				+= acpi_apd.o
 acpi-y				+= acpi_platform.o
 acpi-y				+= acpi_pnp.o
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index ca72a0dc5715..60c483836756 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -69,7 +69,8 @@ void acpi_debugfs_init(void);
 #else
 static inline void acpi_debugfs_init(void) { return; }
 #endif
-#ifdef CONFIG_PCI
+
+#if defined(CONFIG_X86) && defined(CONFIG_PCI)
 void acpi_lpss_init(void);
 #else
 static inline void acpi_lpss_init(void) {}
diff --git a/drivers/acpi/x86/Makefile b/drivers/acpi/x86/Makefile
index 1f3c5fa84f9e..63c99509ed9d 100644
--- a/drivers/acpi/x86/Makefile
+++ b/drivers/acpi/x86/Makefile
@@ -1,6 +1,7 @@
 obj-$(CONFIG_ACPI)	+= acpi-x86.o
 acpi-x86-y		+= apple.o
 acpi-x86-y		+= cmos_rtc.o
+acpi-x86-$(CONFIG_PCI)	+= lpss.o
 acpi-x86-y		+= s2idle.o
 acpi-x86-y		+= utils.o
 
diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/x86/lpss.c
similarity index 99%
rename from drivers/acpi/acpi_lpss.c
rename to drivers/acpi/x86/lpss.c
index a3d2d94be5c0..148e29c2c526 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/x86/lpss.c
@@ -25,7 +25,7 @@
 #include <linux/suspend.h>
 #include <linux/delay.h>
 
-#include "internal.h"
+#include "../internal.h"
 
 #ifdef CONFIG_X86_INTEL_LPSS
 
-- 
2.43.0.rc1.1.gbec44491f096


