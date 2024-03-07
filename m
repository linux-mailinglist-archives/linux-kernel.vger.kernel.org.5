Return-Path: <linux-kernel+bounces-95414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5190874D59
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C4031F25BE6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E881292F9;
	Thu,  7 Mar 2024 11:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OZ3uKtaj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1C112882C;
	Thu,  7 Mar 2024 11:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709810715; cv=none; b=HLW72eZt3HhfT+LHBALOqlJE/pPoJm9BgAPNCw8czUXYVHBrqJtEqfq7jIB74aLqHk1XETJrPqX6sfgQ98qQ7E4Oq4Iv/VOumYm2xCZFdrsIcz7v5nwftLObeYCqBuZG5QOiL5d2/dOPSrT34vHBPlBtmYC02XSUdj9BkgAEbAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709810715; c=relaxed/simple;
	bh=Z4HVVWAlFYg3PWtT3chRrGJgGum707BJPs2HUlzA5Uo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FYuKks+0k2Ho/Z2hQZnUIDL7ECWgN8UDT143yJQ0y4KzDASGDm/l/LwPBCOhaqzOLGKOr3oMt7fhXvsMmL4GFAdF/gYTJg5ibatGew907aliwqf82RdUxnc/LjZjnCjUZQjy9t1W0+P8vayhvTnXScOCTcuAgnCcK5liQ3S8eT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OZ3uKtaj; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709810713; x=1741346713;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Z4HVVWAlFYg3PWtT3chRrGJgGum707BJPs2HUlzA5Uo=;
  b=OZ3uKtajGN23jUk3HUKlwXYxUqn4/aYaFNIHPKFuSSJ7DAm8M7ErWZ5j
   CpnGeaj4A8Yk8jan+YaaWNwecsew5Pi889WQrPcwgAe6poRDP5EP/mnLd
   v2i1ezWQDFz3k5ExnmqmHuXm55yQGUArdIZslF+JwOHCDC7GyIaPJKatK
   V002GCUZcxlRXtUlMBRJuzBlVjEA3GCdNWBS/xbsRPwJDBFBTyLjd+Eaf
   0CXaLYmF3gfvVsXSAK7450iKhEVCwNXkAl3o1Lig0fs4rQXzulC2P3qop
   qgVfT51YPD3P4Gos4zkQWEin5Ptrat454AYcW7fJssav5sCYT5PWLS79M
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="5059845"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="5059845"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 03:25:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="937045837"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="937045837"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Mar 2024 03:25:11 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 4F3BA193; Thu,  7 Mar 2024 13:25:10 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] usb: gadget/snps_udc_plat: Remove unused of_gpio.h
Date: Thu,  7 Mar 2024 13:25:09 +0200
Message-ID: <20240307112509.3627937-1-andriy.shevchenko@linux.intel.com>
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
 drivers/usb/gadget/udc/snps_udc_plat.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/snps_udc_plat.c b/drivers/usb/gadget/udc/snps_udc_plat.c
index 547af2ed9e5e..ba5a06690507 100644
--- a/drivers/usb/gadget/udc/snps_udc_plat.c
+++ b/drivers/usb/gadget/udc/snps_udc_plat.c
@@ -8,7 +8,6 @@
 #include <linux/extcon.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
-#include <linux/of_gpio.h>
 #include <linux/platform_device.h>
 #include <linux/phy/phy.h>
 #include <linux/module.h>
-- 
2.43.0.rc1.1.gbec44491f096


