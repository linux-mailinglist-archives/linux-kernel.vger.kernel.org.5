Return-Path: <linux-kernel+bounces-131366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4968986C7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D86EC1F22DFD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8928285279;
	Thu,  4 Apr 2024 12:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xrv3c56q"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E4B6A005;
	Thu,  4 Apr 2024 12:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712232542; cv=none; b=tCy4TaXG2KM2skDbTIAkeofgg71CtyEfvDfDCvdWR9fSi9ZJbmMyFrLaYRIn9uITe+E9nmwe8MN19w3FhZ+L6xlq/VW73/LPCSmPxKpelaYy815sLDEmbcSFljGpJp70wVErx7x/ISfGhxrFun4MVbr+m8NbWtc/d9WGpaHRPfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712232542; c=relaxed/simple;
	bh=iDPQ2vVkxpAwDuDwOEgx6CmC+oACC23Hj4S4yh3efDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pJD/+63FXV37n7hHmoxVEzMaVia1Qu2GCUVhIWOI+Z0kWAZ6TOlHffXNOO4wY2CLgrgEGZwpK9Dv03MbhvEWe6TWmGN78rvijBSgWNC2uLkZzOKvZPfLGuaz6cncC6fUJKMYz+XF+G+zOvsdeSVW2f2eh9R47aJ6CWaDiM3ID8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xrv3c56q; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712232541; x=1743768541;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iDPQ2vVkxpAwDuDwOEgx6CmC+oACC23Hj4S4yh3efDU=;
  b=Xrv3c56qUTE1yl0F5KT5HghTfTb5nusybTN/9x6hj0xezbf3CU2TmjYw
   Nnm3zUU59RAlOz/hRx5gBGMsywudK7MfJaGiqm58zGo+g0EmvW40maasH
   CJ1pYoNCawA/tzgQL0G6GTYCuyDfpoox8RIBdKWOJcCQR2gThNclui7N2
   cXo1sqB+anQuRGWcx01bcKxigQ4aDA8D1wkT1O1TECqlBoCs0J8soUcWD
   5bFghhpQ9DTBtA8Ee7EjiydQJXrtCWy5CwqDnwur8OnAz4X4T/Pr0XX1J
   LtsW/oFz9EckvLWr8zIGzLPBkt3O81yIFcuLZnhPt+WwxIDkye4RkXLIs
   Q==;
X-CSE-ConnectionGUID: 9mY35rnbQDez+k/mDbKV6Q==
X-CSE-MsgGUID: PAaM0nMBS+2FUrAKqVw/9g==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="18240566"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="18240566"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 05:09:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="937086418"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="937086418"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Apr 2024 05:08:58 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 8270E3E5; Thu,  4 Apr 2024 15:08:57 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 2/2] ACPI: LPSS: Remove nested ifdeffery for CONFIG_PM
Date: Thu,  4 Apr 2024 15:06:59 +0300
Message-ID: <20240404120856.4109303-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240404120856.4109303-1-andriy.shevchenko@linux.intel.com>
References: <20240404120856.4109303-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no need to have the ifdef CONFIG_PM to be nested.
The second and so on will obviously become a no-op.

Remove redundant nested ifdeffery.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/acpi_lpss.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 8e01792228d1..a3d2d94be5c0 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -887,10 +887,8 @@ static int acpi_lpss_activate(struct device *dev)
 	if (pdata->dev_desc->flags & (LPSS_SAVE_CTX | LPSS_SAVE_CTX_ONCE))
 		lpss_deassert_reset(pdata);
 
-#ifdef CONFIG_PM
 	if (pdata->dev_desc->flags & LPSS_SAVE_CTX_ONCE)
 		acpi_lpss_save_ctx(dev, pdata);
-#endif
 
 	return 0;
 }
-- 
2.43.0.rc1.1.gbec44491f096


