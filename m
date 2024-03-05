Return-Path: <linux-kernel+bounces-92719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 167D48724E7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE5A6285520
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197DE17582;
	Tue,  5 Mar 2024 16:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MzqsN3/h"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DE214AA8;
	Tue,  5 Mar 2024 16:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709657596; cv=none; b=pRqHWBTDMog6kotCE4G16ZdjNItXDd5b2nzxMwLUiVstOQiWZ5OLGGoEORttBLInZpV2N4NyHql6Uu5tuN2Ov1WbKLYO2PZUw2Z+LTqvVFORSEY9MyPuqYRRP+z70ptH8BiTrCPxI7B3fU27BENJ0TK87kZdeIx0JwKRiKMYPyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709657596; c=relaxed/simple;
	bh=fF6x/ulpwTNFTzp9klWdwKw9EJhQYUlQo/GNrjzse7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EkXW9f/nCPxOaWAguqZ/4YrNcNQOGvSPCRt+r1tZKvTthYXUYzbp+8AhFM0bP+FPhPSxUMvhJz2Fp6zAXLxJUVhPm9+gHkmyWbIwYRmofYuPqsQ2pIVnUaL4zGiMDSIwQus8Sjzov5m7CsHvMSuNz99/L8cYSMi73HXIu13oznw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MzqsN3/h; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709657595; x=1741193595;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fF6x/ulpwTNFTzp9klWdwKw9EJhQYUlQo/GNrjzse7o=;
  b=MzqsN3/h2C4YeKthFoNwYxf/uvySsCgiwReFC1t5E35F0dzxM1PIl33d
   HMkt+xvwhGlOW0md5C3qs81sPF6TPgFzc9TpDIrEHziFMlkhMe6QqcElh
   c+UgaTl/Eo0cir1QgU8PnmDrLufsD2G9aCBeLhazA4A3zI1ueN3383DlX
   J9TVrdhqgI0EVhoAAZg/PB9Vp3NCNmSUokVna5BsddKHP5ilT8Mi8t1lS
   yXbWRBkKGOcr2q4X/3bVBsMSRYvNyNlHgZPqa8VECpKTVuydlpBeaKio8
   Zy4jBXqmhK7cg3v0lSL6/gUpWA3FH5x1i35ZjbpE2NqZ9RCQjbi87G21K
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="7992146"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="7992146"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 08:53:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="937042728"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="937042728"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 05 Mar 2024 08:53:08 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id B89D84E9; Tue,  5 Mar 2024 18:53:07 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v1 3/3] watchdog: intel-mid_wdt: Get platform data via dev_get_platdata()
Date: Tue,  5 Mar 2024 18:52:20 +0200
Message-ID: <20240305165306.1366823-4-andriy.shevchenko@linux.intel.com>
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

Access to platform data via dev_get_platdata() getter to make code cleaner.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/watchdog/intel-mid_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/intel-mid_wdt.c b/drivers/watchdog/intel-mid_wdt.c
index 06d5d207a065..8d71f6a2236b 100644
--- a/drivers/watchdog/intel-mid_wdt.c
+++ b/drivers/watchdog/intel-mid_wdt.c
@@ -127,7 +127,7 @@ static int mid_wdt_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct watchdog_device *wdt_dev;
-	struct intel_mid_wdt_pdata *pdata = dev->platform_data;
+	struct intel_mid_wdt_pdata *pdata = dev_get_platdata(dev);
 	struct mid_wdt *mid;
 	int ret;
 
-- 
2.43.0.rc1.1.gbec44491f096


