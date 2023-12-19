Return-Path: <linux-kernel+bounces-5500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6116D818B67
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 917891C24103
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1345F1F617;
	Tue, 19 Dec 2023 15:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A2OYLjFC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D831CAA3
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 15:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703000417; x=1734536417;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iRILNP2tcTEDM7uYBHUSnLYvZeaP/4j8jrxcWfireyU=;
  b=A2OYLjFCef7AvAIkTQlGg+vdC+4sa5k3KSneXT0C3rm3rSRlMaOKVY30
   SbBLneDeDaZGjFGjJNBEsP8oBsm5OfygGIQb+XodcBVMZF2UsDE4RMBgl
   exsWc5ePQzW3xz+vbnHjey35COgc181nQYphleC/BPO2IrhKYPWIe0j/w
   pryPv05fQLVExtTz4coG75+DoVz4gUoROpR0rYw6t4JRHJYwj3AGVra+l
   Xw+6GNPmrGngaFZolB067jZoRV/ZHeDbjpJ0L7Cn9UeTOJXqUD+5t61zt
   +br6E6ucLUwfWyfF6Rhu3p+6shpsCutRfXcXZt4zf4XTPm7fSqh8dco60
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="2506290"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="2506290"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 07:40:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="899407781"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="899407781"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 19 Dec 2023 07:40:15 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id B851923A; Tue, 19 Dec 2023 17:40:13 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] regulator: Reuse LINEAR_RANGE() in REGULATOR_LINEAR_RANGE()
Date: Tue, 19 Dec 2023 17:40:12 +0200
Message-ID: <20231219154012.2478688-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

REGULATOR_LINEAR_RANGE() repeats what LINEAR_RANGE() provides.
Deduplicate the former by using the latter. No functional change
intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/regulator/driver.h | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 4b7eceb3828b..22a07c0900a4 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -51,12 +51,7 @@ enum regulator_detection_severity {
 
 /* Initialize struct linear_range for regulators */
 #define REGULATOR_LINEAR_RANGE(_min_uV, _min_sel, _max_sel, _step_uV)	\
-{									\
-	.min		= _min_uV,					\
-	.min_sel	= _min_sel,					\
-	.max_sel	= _max_sel,					\
-	.step		= _step_uV,					\
-}
+	LINEAR_RANGE(_min_uV, _min_sel, _max_sel, _step_uV)
 
 /**
  * struct regulator_ops - regulator operations.
-- 
2.43.0.rc1.1.gbec44491f096


