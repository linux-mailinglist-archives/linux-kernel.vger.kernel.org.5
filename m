Return-Path: <linux-kernel+bounces-79064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A56861D02
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F34B1C24824
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716B4149390;
	Fri, 23 Feb 2024 19:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DZjlJvMp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555451F600
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 19:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708717883; cv=none; b=M2pfkTJS/ts66wSZyRdGeH7Dsk0QmMLzyS7enlxLMR3UJ5bOeJg62pJcva6K9q43BJV7CRMKOpibTTaFWSW5FsbIr+DIcXWpBh6P3AsthOrHU2znrCpX+0gGj5Qx4mR7wAbynw29cmTCbwQJU1IcE/j+CgBCYXVGHOkdBoAvyxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708717883; c=relaxed/simple;
	bh=3FltV39b/2p9W6TJ/uXFx7JU9OLaxSUoPbI0iGl341g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DAq5pcJ/Aah0VmWKRLW6uDCkHiCeWleKehH6q++W2NY3BxXufZgzWzI6HoieKMHWErFkhePoOJPyZSJq1a0ClL8lBHLOir/ZaTbXALwj6cSBO7JzThAqHEa1Xp0QzM4kbzWNzLR/s06mmnmydn8uOPgcQ5U6Drn8Qhb89+ocSMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DZjlJvMp; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708717882; x=1740253882;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3FltV39b/2p9W6TJ/uXFx7JU9OLaxSUoPbI0iGl341g=;
  b=DZjlJvMp25obSDOoJZJZY3CYp098UyPBOO1L7h73++JUD3ss5R0aircT
   sLO86HyqBBP+A80DnvCK63ymkU9WZM9gPE6J8/Z7hJWxeNg0PkI/94YCR
   SchXPhRBj3GgtMWzhxpL1grnUnrEe6SNcaM07GduOuLgOykvIBGAjeJ+H
   wEHDgFr6DOmD5KR94mGTygDWC78Qr/g/jI2evDdbZQH91xgwOAJMFXSN/
   f+Ha/WFHjDjoMJtvYxo5zL7UqG54Ooo0dL5ZUbQOPLfDLBmbopfEbwcSD
   ty/fUO89MjAehT4L2lRRGtXsuLMNqFzx22ZWp5qqYsHz/CuyqXC6omYUb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="6837338"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="6837338"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 11:51:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="937025655"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="937025655"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 23 Feb 2024 11:51:17 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id D42DD8E7; Fri, 23 Feb 2024 21:51:14 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>
Subject: [PATCH v1 6/6] mfd: kempld: Remove dead code
Date: Fri, 23 Feb 2024 21:49:55 +0200
Message-ID: <20240223195113.880121-7-andriy.shevchenko@linux.intel.com>
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

scnprintf() never returns negative value, drop the respective dead code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/kempld-core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/kempld-core.c b/drivers/mfd/kempld-core.c
index 30b8408c094e..ce7d52a62e51 100644
--- a/drivers/mfd/kempld-core.c
+++ b/drivers/mfd/kempld-core.c
@@ -294,11 +294,8 @@ static int kempld_get_info(struct kempld_device_data *pld)
 	else
 		minor = (pld->info.minor - 10) + 'A';
 
-	ret = scnprintf(pld->info.version, sizeof(pld->info.version),
-			"P%X%c%c.%04X", pld->info.number, major, minor,
-			pld->info.buildnr);
-	if (ret < 0)
-		return ret;
+	scnprintf(pld->info.version, sizeof(pld->info.version), "P%X%c%c.%04X",
+		  pld->info.number, major, minor, pld->info.buildnr);
 
 	return 0;
 }
-- 
2.43.0.rc1.1.gbec44491f096


