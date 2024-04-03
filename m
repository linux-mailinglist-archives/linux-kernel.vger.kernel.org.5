Return-Path: <linux-kernel+bounces-130244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A998975DF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83B3D1C27AE6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936B71534F7;
	Wed,  3 Apr 2024 17:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ST3bhbqQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7103C1514D2;
	Wed,  3 Apr 2024 17:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712163791; cv=none; b=ahSVsZbk9dgm0laHB1GGtoi1g2ACTlBWMCj0FWTKKk+bFCQ6vPQ066saLk/J7wBMjMR9TBLorcbIiFSzpUNwVbAajOgNMwgBS2mLKPzNyK1RQH6F1fjArqW4XBbzYymB4NjVud7BDqQc3wEP+ufVT22R89UaeszBV01gpcm6HZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712163791; c=relaxed/simple;
	bh=85DPr1M713nmUHHni9kf5oNPao5iIopZ0TF1O8A9FAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uA2QDGqkIp0RNmMgjE1uTpSgZl0521FQDc+IsqRu3fC18WOUbImhfviI27k6TkHie63+GB+g7H4Mn18xkYTzhVkVkT6BvVxnyT/aK/AnNoBH63APTSFiV63TFUBzRP+Ws/64RGNH66Swh6zOCZCeAevOGxSfhe5ZUQ+K6xbS2us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ST3bhbqQ; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712163790; x=1743699790;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=85DPr1M713nmUHHni9kf5oNPao5iIopZ0TF1O8A9FAM=;
  b=ST3bhbqQDsL+voOVfcuaZuFKSEuRhsCq6r4vWyY4rDD/tbxymdyjBLsG
   Db8pTPlzZhl8ZwMIDKoiL7kFzwefBvGqkNw9M7EAPbxBVU+buIrwxWqxj
   R9e1VHfZI5dpeFaw6JEn6qfWnFnaddkdbkp3LxwNc8JHUGNIabv8dh8Bi
   LTFnP6nOc7bRU9bAAAOkagHSRpZJ2DdWDoCYgBD9zlnZlUsBbCXMwr4c6
   Y7KboLzI88jltAmB/AoVaO250khwhKUsWI3VY8iMpUh3CdnPrzLJZPb8k
   a/o/iS7JCSqe4N+llMs9tajPIUoI1E7QjWwmhUieOHFQLpIAlV1ieJadZ
   g==;
X-CSE-ConnectionGUID: Pz9hPN2jT+e8BuEMO1r87w==
X-CSE-MsgGUID: NrW6AjtRR923fIwZd2mQfA==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="18861490"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="18861490"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 10:03:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="937085334"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="937085334"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 03 Apr 2024 10:03:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id F2051F4; Wed,  3 Apr 2024 20:03:04 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Zhang Rui <rui.zhang@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: [PATCH v1 1/4] ACPI: x86: Introduce a Makefile
Date: Wed,  3 Apr 2024 19:54:35 +0300
Message-ID: <20240403170302.1073841-2-andriy.shevchenko@linux.intel.com>
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

There will be more modules coming here, so, introduce a separate
Makefile and include it in parent one via obj-$(CONFIG_X86).

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/Makefile     | 4 +---
 drivers/acpi/x86/Makefile | 4 ++++
 2 files changed, 5 insertions(+), 3 deletions(-)
 create mode 100644 drivers/acpi/x86/Makefile

diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index d69d5444acdb..0db88aab309f 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -56,9 +56,6 @@ acpi-y				+= evged.o
 acpi-y				+= sysfs.o
 acpi-y				+= property.o
 acpi-$(CONFIG_X86)		+= acpi_cmos_rtc.o
-acpi-$(CONFIG_X86)		+= x86/apple.o
-acpi-$(CONFIG_X86)		+= x86/utils.o
-acpi-$(CONFIG_X86)		+= x86/s2idle.o
 acpi-$(CONFIG_DEBUG_FS)		+= debugfs.o
 acpi-y				+= acpi_lpat.o
 acpi-$(CONFIG_ACPI_FPDT)	+= acpi_fpdt.o
@@ -133,3 +130,4 @@ obj-$(CONFIG_ARM64)		+= arm64/
 obj-$(CONFIG_ACPI_VIOT)		+= viot.o
 
 obj-$(CONFIG_RISCV)		+= riscv/
+obj-$(CONFIG_X86)		+= x86/
diff --git a/drivers/acpi/x86/Makefile b/drivers/acpi/x86/Makefile
new file mode 100644
index 000000000000..bd17dd2c2c5b
--- /dev/null
+++ b/drivers/acpi/x86/Makefile
@@ -0,0 +1,4 @@
+obj-$(CONFIG_ACPI)	+= acpi-x86.o
+acpi-x86-y		+= apple.o
+acpi-x86-y		+= s2idle.o
+acpi-x86-y		+= utils.o
-- 
2.43.0.rc1.1.gbec44491f096


