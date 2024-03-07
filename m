Return-Path: <linux-kernel+bounces-95520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8592D874ECB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B43F91C21A60
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FCB12A167;
	Thu,  7 Mar 2024 12:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IyV5mjcO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F393782891;
	Thu,  7 Mar 2024 12:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709813958; cv=none; b=muYLZan/6hTR83yIIEhTeEMeSAv7dhIMARyo3DOcBPQcjhbQWBDHAvGow8jRPcBOL/qyLiyCjUfGbwNMOzTzuNEKJge28nzuabAoEAevH4IHx9wZllve+IfBcfu7YFMip3ownf6JFpmt2AlUhziRbUe7rNTAMSznocHNeNfZ9P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709813958; c=relaxed/simple;
	bh=/+IFJS/KcSf7DigBEvxed/q/2MkAOrk0j7DkIz+cw78=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KR5t1vBdFyNqjxHmIfdweDuMRlX3Ka264z/ckVoBvdP4OG2hMs8GT0EFWsBKamXrDOgCJnKUUuvrhnS8ewUlZTOLVfOaUZ9haBZgL4nmpQRrAA3YHfLs22N4rnYYsa58yY5OQXCnv9pgt1ShaL1ryWfLIbu2i4h42Af8YJ2pjz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IyV5mjcO; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709813957; x=1741349957;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/+IFJS/KcSf7DigBEvxed/q/2MkAOrk0j7DkIz+cw78=;
  b=IyV5mjcOx+DY33afnUgopBNTdYCTmpLcWOZJNI1Ao3Nx3kP/WDmtRg1m
   wtEF7X+cv1v/aLn8XTK2el75A7iXJbWfhtgAnTrPVH2ZQ/IE3VNtzORCb
   NA4Kg0Di6LJU26heAFXomFrmpDn5eNK9w6SD2E9FwDdY4SHV8wMLCgEmt
   XKj3M3b6TaaUVLRV/fqtuCR7KGUt5YAoq/PN8RW8s9KElZDH/IQEhmxh8
   PUIY+pPNY9Gwp6/Hqssz6SOiOMkszIO4nJ3M+XXWJIq9cHk8pZ5Me4haF
   vgvzPLEkV6fMaBj4yG/n1B1TevUlnm2d6/qyPO/EdsBwwUpuHyjePMfsH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="4342809"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="4342809"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 04:19:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="937045962"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="937045962"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Mar 2024 04:19:14 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 370B9193; Thu,  7 Mar 2024 14:19:13 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ben Dooks <ben-linux@fluff.org>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] mmc: sdhci-s3c: Replace deprecated of_get_named_gpio()
Date: Thu,  7 Mar 2024 14:19:12 +0200
Message-ID: <20240307121912.3676850-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It seems the of_get_named_gpio() is solely used to check
if the GPIO is present in DT as the function can return 0
if and only if it's present and it becomes in the global
number space 0. But this quite likely shows that the code
wasn't ever been tested on the systems when no GPIO is provided.
In any case, the proper test is just to call of_property_present()
without any attempts in requesting GPIO (as we haven't saved the
number or descriptor anywhere in the code).

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mmc/host/sdhci-s3c.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 0e8a8ac14e56..6493b0edba34 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -17,10 +17,8 @@
 #include <linux/slab.h>
 #include <linux/clk.h>
 #include <linux/io.h>
-#include <linux/gpio.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
 
@@ -446,7 +444,7 @@ static int sdhci_s3c_parse_dt(struct device *dev,
 		return 0;
 	}
 
-	if (of_get_named_gpio(node, "cd-gpios", 0))
+	if (of_property_present(node, "cd-gpios"))
 		return 0;
 
 	/* assuming internal card detect that will be configured by pinctrl */
-- 
2.43.0.rc1.1.gbec44491f096


