Return-Path: <linux-kernel+bounces-92717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6CE8724E4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEAA41C22752
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3B4DDAE;
	Tue,  5 Mar 2024 16:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HGS3aQFb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D962FD2E6;
	Tue,  5 Mar 2024 16:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709657594; cv=none; b=WnskS5xtbgNJ5rgLfJw9d/3YkG5Sr/1Wx7kYbIZ7HPMgvn5DT8wmNoaYJLejAEe5271oPGdnwV3B6CwQyrlrmekglWHpaZpFuUh7npnBhnfbtLc52JRt4RP99ykKmp0McwtDe4RrmOX9rmjTLKwgg3MhBrVIlGpndxLG3Ym+xNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709657594; c=relaxed/simple;
	bh=LebP59pVzvf6mGQ4wjdC68Z5qKPE1ig+GgCUG7F6czs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i7KIt7NgX+8dZY9SB2g/ZjWXvYWbe4Sr+UohdeianY7CFcp+hifZPIhT9DWJU4bOcSbN+ccl1bRM/hOJBF+s2cKwaJz4u2wnyAxoeB2UQiQcfd8FusIo4yVK9f9S1U1zFBJBgQBKGCP42MZ+ft7vp75ZmLK+wD/mymZ5FqrI5D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HGS3aQFb; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709657593; x=1741193593;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LebP59pVzvf6mGQ4wjdC68Z5qKPE1ig+GgCUG7F6czs=;
  b=HGS3aQFbzrOB4weP0YojUUcgDRACCWrQ+ViQVXMe5hNoWj6G6J8SOyC3
   qvi5tIvufqcBKD8H5ORQfxaDJnxb7J1iaHKZkRnwaJe2NIg3s3RYKpQLN
   XewwTewRsC1u2w4buA5hDeayaLVrgmciNmPPFaGzySKZW+ufHLDfKPnrU
   rm5Dut5+uuxsaB23eSzq75KoLnQOYUPhCm0G1lkg5eCoIDxy+iquEAGC1
   u2n6NIksmndFoQKtxzWhzyIJ0F3mAEL+vdR47mzyr4pQIWMxbQ4Lzmjrx
   D0vBpnM2yetfo4G1DSxfalpr6Rx7QLMB6hC2cU62ljsXFHLRoMmNzPba3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="7992138"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="7992138"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 08:53:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="937042726"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="937042726"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 05 Mar 2024 08:53:08 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id B16023F1; Tue,  5 Mar 2024 18:53:07 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v1 2/3] watchdog: intel-mid_wdt: Don't use "proxy" headers
Date: Tue,  5 Mar 2024 18:52:19 +0200
Message-ID: <20240305165306.1366823-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240305165306.1366823-1-andriy.shevchenko@linux.intel.com>
References: <20240305165306.1366823-1-andriy.shevchenko@linux.intel.com>
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
 drivers/watchdog/intel-mid_wdt.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/intel-mid_wdt.c b/drivers/watchdog/intel-mid_wdt.c
index b41c45582aa4..06d5d207a065 100644
--- a/drivers/watchdog/intel-mid_wdt.c
+++ b/drivers/watchdog/intel-mid_wdt.c
@@ -9,11 +9,17 @@
  *      Contact: David Cohen <david.a.cohen@linux.intel.com>
  */
 
+#include <linux/bitops.h>
+#include <linux/device.h>
+#include <linux/errno.h>
 #include <linux/interrupt.h>
+#include <linux/math.h>
 #include <linux/module.h>
-#include <linux/nmi.h>
+#include <linux/panic.h>
 #include <linux/platform_device.h>
+#include <linux/types.h>
 #include <linux/watchdog.h>
+
 #include <linux/platform_data/intel-mid_wdt.h>
 
 #include <asm/intel_scu_ipc.h>
-- 
2.43.0.rc1.1.gbec44491f096


