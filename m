Return-Path: <linux-kernel+bounces-91063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 177F887091D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C04881F21351
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB9762144;
	Mon,  4 Mar 2024 18:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bh2IjlNI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573F262141
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 18:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709575715; cv=none; b=YzkEcCPGQ5Tl+yqpT3kBMprjO+4j74bHL4JqPcMc8a5ntyelPhouH6+7mM81vwjwOcjEdZLQSglAbPCCnBhbI21mK0SGC6TvfVtlNURQNrPIe2nug+8yUB73/2gRgu4r70vplQEigxxRqc7OcOJmtSiSUAN2x/QZkr3SqL+fgtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709575715; c=relaxed/simple;
	bh=gvMDpb519wOKHrPH0B1aX0Q4gY4/wAoliTS5gT+P3ks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qm6oKqmNkTo4q+PSe+Kp6iulbYBt11doLjOVJ7LMzVygdCRZAjDu3P38JttEiyOD7BAgQ0x0uBTtnAQpnnHETVNRpvhAWSiz5twDsxWXW1G8ssEKZsuqM2RgagEKlLnTIDiDYaq+Aw2kSkqjGf1wJTWqhvP/L4Wz8S2GuyFzvYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bh2IjlNI; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709575715; x=1741111715;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gvMDpb519wOKHrPH0B1aX0Q4gY4/wAoliTS5gT+P3ks=;
  b=Bh2IjlNI5EGZiUhYytjRvb9vvwk+NXh/IkR4XaZwOjLAcwlbRngZ6ajk
   cTDbNgMh8V+qVmwrPAD1OdDoT16a6XUv2/G46/EtZQ8GqdG7kzQJ/X6tU
   2EJ2+dbcGGVsrXLcvizdHWreBMpG2il6A28/nS/ghfq47EGKzeajNghnM
   PrHY0txbfLLq0K1ARHK1A0n+Pfrh8RLB/7I+e7uO4i/kx1b2HDQ1YTJct
   DzfmX/1PSQvtgnjb2L860geYnV2dP4H5gM8Qsm2VMPEesTYd7bN7cAQ1d
   L2DZkZuW6reT+eOeg3Nfw2/SqEp71JoL76JCcNv3yOrU3nOdn4+ZdCXsV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="7855731"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="7855731"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 10:08:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="937040919"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="937040919"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Mar 2024 10:08:31 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id BB2EA15C; Mon,  4 Mar 2024 20:08:30 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: John Stultz <jstultz@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v1 1/1] misc: hisi_hikey_usb: Remove unused of_gpio.h
Date: Mon,  4 Mar 2024 20:08:29 +0200
Message-ID: <20240304180829.1201726-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_gpio.h is deprecated and subject to remove.
The driver doesn't use it, simply remove the unused header.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/misc/hisi_hikey_usb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/misc/hisi_hikey_usb.c b/drivers/misc/hisi_hikey_usb.c
index 2165ec35a343..42e12f11ae6e 100644
--- a/drivers/misc/hisi_hikey_usb.c
+++ b/drivers/misc/hisi_hikey_usb.c
@@ -14,7 +14,6 @@
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/notifier.h>
-#include <linux/of_gpio.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
 #include <linux/regulator/consumer.h>
-- 
2.43.0.rc1.1.gbec44491f096


