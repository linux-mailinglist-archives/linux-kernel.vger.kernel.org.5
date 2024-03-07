Return-Path: <linux-kernel+bounces-95752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5647187520A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 081AA1F26E18
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C3A12FB3E;
	Thu,  7 Mar 2024 14:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="brYIkjx0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D6C12E1D1
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 14:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709822214; cv=none; b=ZWQsGs0s3ddOLB7Lza3jifip8sWYktrhbtiFe0k3e/bZH9P4m/B8R2C4QU1+Y+5ibLQMdAUOAJUdR2J/2rc4SbEBLlKGQPv5QqJVjopdF6Pp9tIiC+Zeyv2+4ZRR/1dcofTXZ6HK73dFQbN3NS3gKX6znpnfq34Ctsz7pQ6T6YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709822214; c=relaxed/simple;
	bh=SpbU5y5jpGRsktvmR80O+qDRedvzwa1iegimEO+Vkgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t1rwrM2VSMEPvWcX5FKp2w5IovZCirtwXkxNTBNsaPKb3SP/GaZ4k/Z3n9kdyxkamaJlqFTgz9fzgvkIZW/DeKjWKOdPEl1vQi8tTqwJGfHr77/mFu0nm5jLZbqTNIqlJ5IIN+IijPbA2QdK0tlxxRrROmGZ8XBJmT3EiJj3nfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=brYIkjx0; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709822213; x=1741358213;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SpbU5y5jpGRsktvmR80O+qDRedvzwa1iegimEO+Vkgc=;
  b=brYIkjx0+HGXBdkbZHRcIxrvMta8Odti92TCalZ6V9m7qdm4O6jio/4S
   2sQSFWqAEBO09637Sb9jzkuIEV2PiDWAwbnRl2HX9FNalkoXFtJetKoOF
   txo2OM23O2DuzimRFSALxRwfQoHVvj+uTVWVLKXf2a71ysydw6gDde6bQ
   2XiWAtpBkJAKk0SHLsogKlESUNhcGJMKOZmdQOAKb93fYtfRuqNhR03vz
   GVXn4hBSVuiDDTjvV8dkLAn21TeUh221+8e+gFtT7bazfMxgBgZkDWIvO
   mJS/s8ARTMfHgcJthm0w9P6HHiYFGNvL+z2r2JnHnVj6Q3Gfei9olX8GQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4348220"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="4348220"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 06:36:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="937046244"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="937046244"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Mar 2024 06:36:49 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 2FE3374C; Thu,  7 Mar 2024 16:36:46 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 5/5] w1: gpio: Don't use "proxy" headers
Date: Thu,  7 Mar 2024 16:35:51 +0200
Message-ID: <20240307143644.3787260-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240307143644.3787260-1-andriy.shevchenko@linux.intel.com>
References: <20240307143644.3787260-1-andriy.shevchenko@linux.intel.com>
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
 drivers/w1/masters/w1-gpio.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/w1/masters/w1-gpio.c b/drivers/w1/masters/w1-gpio.c
index 8fd9fedd8c56..a39fa8bf866a 100644
--- a/drivers/w1/masters/w1-gpio.c
+++ b/drivers/w1/masters/w1-gpio.c
@@ -5,15 +5,15 @@
  * Copyright (C) 2007 Ville Syrjala <syrjala@sci.fi>
  */
 
-#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
-#include <linux/slab.h>
-#include <linux/gpio/consumer.h>
-#include <linux/err.h>
-#include <linux/delay.h>
+#include <linux/types.h>
 
 #include <linux/w1.h>
 
-- 
2.43.0.rc1.1.gbec44491f096


