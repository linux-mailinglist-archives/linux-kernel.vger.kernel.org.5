Return-Path: <linux-kernel+bounces-137302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7243C89E025
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E47E289E6C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33F313E022;
	Tue,  9 Apr 2024 16:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E/AGiVxy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A2F13D8BC
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 16:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712679333; cv=none; b=YmTp2xfdv7NwAZ7sFbaUEGroNIc0xZTi9dRowhNbXF/wrXh5ciB+RZIJVkwVrffwDxK6jl/A7yLQICsRY683+TIXXcvWBb6y3464VjFMSzCVZhHHNiNYWKTGdmZouAkbCy1BbkRnyC18RJpmxhB68jpZgLX0zdD8Oh3dl9xXxAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712679333; c=relaxed/simple;
	bh=b4fCKCw4KL7PbHeE+vnyKU7Pc8Sf0251fOlV3UrBpq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JtfBPSx/VfiToAzIePSTQ2oLqTFqcbQUpKz7QdiY0Y884x4XtJw/t2uk+YPYtJrrBjXR1tAWSF+F0tYGMY835WilzfQqbkQ7FjILaXR9wJBDAgkU1GFNx02L9TEStLiDtujOmdTVMgqHRZ9n7ESlT3aIbGdDuR9pwum4CB9sARQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E/AGiVxy; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712679331; x=1744215331;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b4fCKCw4KL7PbHeE+vnyKU7Pc8Sf0251fOlV3UrBpq8=;
  b=E/AGiVxyzKFOvT1YFa3PCsHxeMpgSqpiHY8nwee5Ya9QYnHM4qPwVCpb
   jzNVk6oP+kLTSM+6Owr60Xb7cWtQLgm0e3LmV8URSToFqrfWex1mqDIhQ
   nTLtmqv/sVY7D8gnsh2JSxALk/8oeuiAjvPRrWeDVrR7hPYj/JDHh9b3q
   xfKVJXq/cZZKhkwk0Anes1vLegXugo8VXq8jeiupfNDpSxEVrlj5zW0Yt
   qjkfdDDfJJn1ZiXsSZ8NlXm+xCaVruDSHJjxRle3BB+G2sL/OQkUh5HaF
   XYQsau7FFqAXK7y3CgmpHPvMl4aKeGyFF0wOvR+bttN7SeSolnl5Hp81/
   w==;
X-CSE-ConnectionGUID: ThVPNEkuSGq2+tMhapCV8g==
X-CSE-MsgGUID: MuklJyHpTPSdYJCRKNaVvw==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="33409813"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="33409813"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 09:15:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="937093591"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="937093591"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 09 Apr 2024 09:15:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id A0B4A193; Tue,  9 Apr 2024 19:15:25 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v1 1/2] auxdisplay: charlcd: Add missing MODULE_DESCRIPTION()
Date: Tue,  9 Apr 2024 19:14:44 +0300
Message-ID: <20240409161523.935384-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240409161523.935384-1-andriy.shevchenko@linux.intel.com>
References: <20240409161523.935384-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The modpost script is not happy

  WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/auxdisplay/charlcd.o

because there is a missing module description.

Add it to the module.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/auxdisplay/charlcd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index 6d309e4971b6..5df019720c56 100644
--- a/drivers/auxdisplay/charlcd.c
+++ b/drivers/auxdisplay/charlcd.c
@@ -678,4 +678,5 @@ int charlcd_unregister(struct charlcd *lcd)
 }
 EXPORT_SYMBOL_GPL(charlcd_unregister);
 
+MODULE_DESCRIPTION("Character LCD core support");
 MODULE_LICENSE("GPL");
-- 
2.43.0.rc1.1.gbec44491f096


