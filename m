Return-Path: <linux-kernel+bounces-131961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9A8898DFF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B27FA1F22599
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97639130AD7;
	Thu,  4 Apr 2024 18:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g0zSGxVT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398EE134AC;
	Thu,  4 Apr 2024 18:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712255699; cv=none; b=VrerFfWQUIxk5Z96MPUm7VUHtbW5vvsVo/MKqQHD6CDk1nY65NzGgf3aDq2mbwFS1gpNJDlO1cG7fctjLqFMsf+1Bc/7ROh//pKvcae8zbiav6TKrw0cSddrpGSZ9DWUhDsKo0quOeu/i9IlK10cVk3CI8Oa8UD5vhLr2llFiRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712255699; c=relaxed/simple;
	bh=MhZT0gDEz6dvyjIkYHf74rwRRynWUz9nECCDuK5y9/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JGfAb8Ak1JNEgzFdz6l4LjJiwFKb4BmNz9S+eBQ2PlI7lLn4FjyBWL/Ms0uEVV3WVmj6WT1jsTV30fzDGLLwOVUkA3GB3o7pC9fVW7iR3b3oMELVIxBMAovrixrw2+KsyjGMKQtETgNveik4/3YM0BW3UUq4ogLlkdTnGFpa8jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g0zSGxVT; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712255698; x=1743791698;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MhZT0gDEz6dvyjIkYHf74rwRRynWUz9nECCDuK5y9/Y=;
  b=g0zSGxVT8zo7vv8Mn7KEQP7wE/7ld+iw7BLf5MOdu0aHGD9n5dWKvyvA
   NW0OlyF5uTKkilvYmfbyoW19dz9hrLKH2PEWiSDaLLX51iQ9eDJUjQdoo
   wqBrqpVRmbzAt5LfUmNBRdW/zHih0C7WxlgTEKzJSlvUqs6PxkZlgfRUL
   2f0kA8UFHbv5dYLkRaSK2ULwLqf//rT5HW25Sz1SAOngtm8DBvUa5fibI
   3w2k5szQTn0kR81phCHM8gVT/hQebrYhEFWHlRR0SUPcapmiCGcGvjpDe
   m4FYqzVu2k8MJWP0solovN0iefJBDoQzSITfQVMmkPgh1iFen+Ehx9IBo
   w==;
X-CSE-ConnectionGUID: +986DB1BQeGkisbpfgQCOg==
X-CSE-MsgGUID: t3ZOTuXJQpWyUL3v009n/Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="7751314"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="7751314"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 11:34:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="937086992"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="937086992"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Apr 2024 11:34:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id A82D4B56; Thu,  4 Apr 2024 21:34:54 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Zhang Rui <rui.zhang@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: [PATCH v2 2/4] ACPI: x86: Move acpi_cmos_rtc to x86 folder
Date: Thu,  4 Apr 2024 21:23:40 +0300
Message-ID: <20240404183448.3310449-3-andriy.shevchenko@linux.intel.com>
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

acpi_cmos_rtc is built solely for x86, move it to the respective folder.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/Makefile                            | 1 -
 drivers/acpi/x86/Makefile                        | 1 +
 drivers/acpi/{acpi_cmos_rtc.c => x86/cmos_rtc.c} | 2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename drivers/acpi/{acpi_cmos_rtc.c => x86/cmos_rtc.c} (98%)

diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 0db88aab309f..413c18e2bf61 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -55,7 +55,6 @@ acpi-y				+= event.o
 acpi-y				+= evged.o
 acpi-y				+= sysfs.o
 acpi-y				+= property.o
-acpi-$(CONFIG_X86)		+= acpi_cmos_rtc.o
 acpi-$(CONFIG_DEBUG_FS)		+= debugfs.o
 acpi-y				+= acpi_lpat.o
 acpi-$(CONFIG_ACPI_FPDT)	+= acpi_fpdt.o
diff --git a/drivers/acpi/x86/Makefile b/drivers/acpi/x86/Makefile
index bd17dd2c2c5b..b97b1bcf8404 100644
--- a/drivers/acpi/x86/Makefile
+++ b/drivers/acpi/x86/Makefile
@@ -1,4 +1,5 @@
 obj-$(CONFIG_ACPI)	+= acpi-x86.o
 acpi-x86-y		+= apple.o
+acpi-x86-y		+= cmos_rtc.o
 acpi-x86-y		+= s2idle.o
 acpi-x86-y		+= utils.o
diff --git a/drivers/acpi/acpi_cmos_rtc.c b/drivers/acpi/x86/cmos_rtc.c
similarity index 98%
rename from drivers/acpi/acpi_cmos_rtc.c
rename to drivers/acpi/x86/cmos_rtc.c
index 9b55d1593d16..51643ff6fe5f 100644
--- a/drivers/acpi/acpi_cmos_rtc.c
+++ b/drivers/acpi/x86/cmos_rtc.c
@@ -15,7 +15,7 @@
 #include <linux/module.h>
 #include <linux/mc146818rtc.h>
 
-#include "internal.h"
+#include "../internal.h"
 
 static const struct acpi_device_id acpi_cmos_rtc_ids[] = {
 	{ "PNP0B00" },
-- 
2.43.0.rc1.1.gbec44491f096


