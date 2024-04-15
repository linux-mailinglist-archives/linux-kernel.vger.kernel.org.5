Return-Path: <linux-kernel+bounces-145736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6168A5A2E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 20:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A966284165
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933D2155A24;
	Mon, 15 Apr 2024 18:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FKWiYra+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759E61552E6;
	Mon, 15 Apr 2024 18:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713206882; cv=none; b=dR8budsNBNnXSE/MbepXWW06zcHS7G2tSrUmWWXwbVGScxN66ogcupmK4LwLInj8YE4YKPkfg9Zfv6ZIkmJSe9ALbcaMSmrf3csK0SAXAHxDnSOzM6L/1Kwvo/eB46TrdXAjJKqNj+GoPddfxNPSXjPPQSorQeBZenyWWEg4cHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713206882; c=relaxed/simple;
	bh=V3m2W2N1q6fqgiRRtQEa9dZvynEBfFxKofTaSjGXGNc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SKrylD6/zP+LcJEytBTGl4OAGpyAzeCcdEzKrfP3TH34IepyVxadgL2mWjyxXHg8l4KQCF7tNP1hxrMCXPCyFG+q4aNXL4Osi+sRl5ppRNyPpgwxO+kMvIZDyKI5nUBHNlo56fTNaNOiP6U6I2fnFi0MqCMR0XC16RyY38sZkvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FKWiYra+; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713206882; x=1744742882;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=V3m2W2N1q6fqgiRRtQEa9dZvynEBfFxKofTaSjGXGNc=;
  b=FKWiYra+KO1C4J8lG/zpyaZ/UlD1xhbF3y/HXhJQiDatrg6zT9f+ACEN
   8eJybtOBpKvW/+l5oxRWEuEUquW8ZTNARgWTrn2U+0qGSkITp0RryuOHE
   fKZqot1Ih6I3s6eBexqOQTZdtrORShRK5qh8WVxL8G+aDRwxOKriPZl+V
   1Ds1T1dul5Cltepuz1GEZBsu64ek6oEeHO2CQJ49zBrWxtB4cskg6mkax
   6gkBzftVFqwoc+Mm+oHuefGyt6Tticp+HNZSUBIlpb6XX3ZxZ4jRjjBEL
   R5KBWQICVtzI9xEXGoF1igcgBkwJP8ofCuFQlV3UthlUQqnypwZ85EqvI
   w==;
X-CSE-ConnectionGUID: t5orEL73T7mkQZ9y6j+Gyg==
X-CSE-MsgGUID: wysn4T3ZS6qKupK4lUQ1fg==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="8735439"
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="8735439"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 11:48:01 -0700
X-CSE-ConnectionGUID: tYH85ddMR8eBZ7YGa0i3wQ==
X-CSE-MsgGUID: gP5LuKE0Q1ynbPbzMNLSZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="59441422"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 15 Apr 2024 11:48:00 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 2FB70483; Mon, 15 Apr 2024 21:47:58 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] spi: Consistently use BIT for cs_index_mask (part 2)
Date: Mon, 15 Apr 2024 21:47:57 +0300
Message-ID: <20240415184757.1198149-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For some reason the commit 1209c5566f9b ("spi: Consistently use BIT
for cs_index_mask") missed one place to change, do it here to finish
the job.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index a2f01116ba09..6eb8583f5e40 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -822,14 +822,10 @@ struct spi_device *spi_new_device(struct spi_controller *ctlr,
 	proxy->controller_data = chip->controller_data;
 	proxy->controller_state = NULL;
 	/*
-	 * spi->chip_select[i] gives the corresponding physical CS for logical CS i
-	 * logical CS number is represented by setting the ith bit in spi->cs_index_mask
-	 * So, for example, if spi->cs_index_mask = 0x01 then logical CS number is 0 and
-	 * spi->chip_select[0] will give the physical CS.
-	 * By default spi->chip_select[0] will hold the physical CS number so, set
-	 * spi->cs_index_mask as 0x01.
+	 * By default spi->chip_select[0] will hold the physical CS number,
+	 * so set bit 0 in spi->cs_index_mask.
 	 */
-	proxy->cs_index_mask = 0x01;
+	proxy->cs_index_mask = BIT(0);
 
 	if (chip->swnode) {
 		status = device_add_software_node(&proxy->dev, chip->swnode);
-- 
2.43.0.rc1.1336.g36b5255a03ac


