Return-Path: <linux-kernel+bounces-79065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E02C861D03
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DABFEB25C3F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657D514DFC4;
	Fri, 23 Feb 2024 19:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DdTrt5gM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9B114CAA5
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 19:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708717884; cv=none; b=FGl4hk7nPBkJq0dTkXte0D3E1B9abpjOhS8clo2dJgt+eG72hn3AXazLtZScNDzQ8AfWGyh/iQF8N2swVHn7sEvGABjMaYwUydJ4YUl/mcT2SgqsDr1JI9nihxYhY6d9ilgq86I4of6QQqylkaweQTp+kPcNE9Oaw7pkyvReDuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708717884; c=relaxed/simple;
	bh=a9fjCoKlNy7EqqwDnIhus04TAUmuVLHwGiBZ5ufchNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jN+oLCjiGpKxYQsW/TPGb0X0o2uXBIgkbhaiAznubnXURm5r/Cq6u2kP8t7sopAVFHGKORkrnJBZI0OlPmQ48LWnDxTprlUZZSUtWLD5lU9/69apgNrCSG3i/Qe5jN3Cf+d8KDcQE9lHsV+f6VlRKdV+DjfmVnILLyvWR5GEZBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DdTrt5gM; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708717883; x=1740253883;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a9fjCoKlNy7EqqwDnIhus04TAUmuVLHwGiBZ5ufchNE=;
  b=DdTrt5gM5sUZoK6aLgExcHZIltaDXOTr4XYtJpAEvggWx1bkTOplL1e+
   oFRzVjj0y8Hu2EdRRrEGieFe4RpC3oq+WkMkA1O4MOLGgY8nd1Qu3AlCZ
   3mKMm0+1j5YPJfgBEp/LilaRaqffaqiFWI0kYbRFK3D75boxieJUBtytu
   rWizjc7iSyba5JX83Hxw5vC9gGFVIQEudd7NBWdY1cqywPCKa84uHV9da
   cReRjV3wEZGy6OLIiUCvtSBJTdXMMuUAhyHsBrzNAwwwbILQ+B/Hyz8zp
   Hrppo9OLgLYuWWWCxXKsJ1p86NAKO+kSLxhH1fOWsXH81mN5BNB33o2nn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="6837340"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="6837340"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 11:51:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="937025656"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="937025656"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 23 Feb 2024 11:51:17 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id C7BAB8D2; Fri, 23 Feb 2024 21:51:14 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>
Subject: [PATCH v1 5/6] mfd: kempld: Drop duplicate NULL check in ->exit()
Date: Fri, 23 Feb 2024 21:49:54 +0200
Message-ID: <20240223195113.880121-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240223195113.880121-1-andriy.shevchenko@linux.intel.com>
References: <20240223195113.880121-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since platform_device_unregister() is NULL-aware, we don't need
to duplicate this check. Remove it and fold the rest of the code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/kempld-core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mfd/kempld-core.c b/drivers/mfd/kempld-core.c
index c3bc61dcd098..30b8408c094e 100644
--- a/drivers/mfd/kempld-core.c
+++ b/drivers/mfd/kempld-core.c
@@ -895,9 +895,7 @@ static int __init kempld_init(void)
 
 static void __exit kempld_exit(void)
 {
-	if (kempld_pdev)
-		platform_device_unregister(kempld_pdev);
-
+	platform_device_unregister(kempld_pdev);
 	platform_driver_unregister(&kempld_driver);
 }
 
-- 
2.43.0.rc1.1.gbec44491f096


