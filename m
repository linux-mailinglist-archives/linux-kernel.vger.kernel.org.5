Return-Path: <linux-kernel+bounces-130243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF468975DE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF8AA1C27A9B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6392D152506;
	Wed,  3 Apr 2024 17:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HNmvHER6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20486152500;
	Wed,  3 Apr 2024 17:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712163791; cv=none; b=hUdgnIAWAZQtKPoywgEvamVSnr0nk8d1N0bn4zmCGpi/uoNQ2a2qY38wZeDaealBPJOAjPMfl+OWwZiBvmglm4+O9L5FxWJ33gl38o+xo8pFKvRw4VqU34wdnkDxrfpQ/fJ8exbB0XBzFVbNCIudou+AHCQ3RFu2zPHT0OJTQug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712163791; c=relaxed/simple;
	bh=MhZT0gDEz6dvyjIkYHf74rwRRynWUz9nECCDuK5y9/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lm8xtviHdHuRLaMy50koN8D6gbvn2zdUH8bu1acKDK+3i8S8Dt+z8p0p1vmMUjDZkwl8c92PFbfQdzRURPb72EmzMbqq8l/KJDIz0m4D5duj6Cps2/2mTZQiqkLk348yZYKy+EqrS7K6wwp5JTmF6f3BXngX31oHyeLFXHTxTsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HNmvHER6; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712163790; x=1743699790;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MhZT0gDEz6dvyjIkYHf74rwRRynWUz9nECCDuK5y9/Y=;
  b=HNmvHER6ltHOXpYzUl81nxq2eOax/AWkCcFwZjcZfOrUKaqhf3u0vRZC
   tGF5sTPHZ3GBMn05JFb3FdAf25aAaGzwifTv0T7eFyf129XOBuw4UfTmu
   RDObHIVncsUma1VVPKoU5QFVEPcTpLYtpUoDwd4pidHSHpE3WVgSvFGze
   kJ83OpXqZY5WZI8SCMc8o9YF0d1ngRq37Qk3czfdM0LkmidsgWAe+O40I
   gTqUmjwUl91qkDajPXRC5qttozctwC/GMq0OhnnRGRPTkq0he9TvlnMgN
   n67eqyAH9FdGl3bZnpRvUW/K1N3EjbKAFcVVGPK+oIvRLbp7MxdJ8oBEb
   g==;
X-CSE-ConnectionGUID: o5wAKWnZTEyUg9rydM4NPw==
X-CSE-MsgGUID: MEWzRE76QI6J3VCcdKQVDA==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="18861488"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="18861488"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 10:03:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="937085330"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="937085330"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 03 Apr 2024 10:03:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 0970D57D; Wed,  3 Apr 2024 20:03:05 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Zhang Rui <rui.zhang@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: [PATCH v1 2/4] ACPI: x86: Move acpi_cmos_rtc to x86 folder
Date: Wed,  3 Apr 2024 19:54:36 +0300
Message-ID: <20240403170302.1073841-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240403170302.1073841-1-andriy.shevchenko@linux.intel.com>
References: <20240403170302.1073841-1-andriy.shevchenko@linux.intel.com>
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


