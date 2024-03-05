Return-Path: <linux-kernel+bounces-92716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D772B8724E1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10391B245DF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A72DDAD;
	Tue,  5 Mar 2024 16:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c/kChBKQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3DCC8CE;
	Tue,  5 Mar 2024 16:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709657592; cv=none; b=hZ10NFyVBMgUmm3IrSp9Qo9LA0s4EbxdXj0GiEYl/NA1MGnKeiqRwrHl7SOZJ+YliZHdbLlYY5YZ3LnX9/sRu9c+nciFQy3m9I77Y7X9VAAh9TcLGfpaPMMec67iA1sUqyOidVtIG34650pRm9jszDuQK44xLXFn5Kh7UI772PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709657592; c=relaxed/simple;
	bh=8wBeUlZOEVjXChYznBbLSzV2No/jKhNzLoQNz64g650=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=peS9pnkkHgRUB/eI59KcGgAJ0o9v7EJst16skppv7EfqEKfXDS1WPecoNQbRGz83/ShVNGDLTY4XZ7QdHiH6bJTJmhEWbG9xQsyc2ZnMEvhTKriZK2PmvTaxm7hlMO2K54aDFnbOogS1/+nAUOTvtNIQIAnE69YGfJmvLD4G608=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c/kChBKQ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709657591; x=1741193591;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8wBeUlZOEVjXChYznBbLSzV2No/jKhNzLoQNz64g650=;
  b=c/kChBKQzLdYQNX6FWCmWAGmj1r4xm7zgCAsMYkDxFJDVzBs6HtsP609
   lHGDtddN7B2WhbKJT8Pjk61I7gq0S5f2DvB95V7nVsP0B1hjbm9L125ed
   uNSrsXIExo6gtETs/ToYU+jLWXOBZEsojqszIoTJdEAZLUSwd88nk/3kk
   YamKf00waA4n6eafdWNxWi97qUFuDxOWT3lOCY+oEEWSwSY6sTFMFcZMk
   PVPOIzbSPUPXvJMxGiSjIkrNb/q3mJ5huDFvdw/MEZvou2n9pXS6wtUXg
   pdK1kUVZAyAzhWWRIRkA3qx6RY5FiF2PXK/8hoLY2ql4F7rmETVtPQJCb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="7992134"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="7992134"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 08:53:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="937042725"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="937042725"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 05 Mar 2024 08:53:08 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id A279112B; Tue,  5 Mar 2024 18:53:07 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v1 1/3] watchdog: intel-mid_wdt: Remove unused intel-mid.h
Date: Tue,  5 Mar 2024 18:52:18 +0200
Message-ID: <20240305165306.1366823-2-andriy.shevchenko@linux.intel.com>
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

intel-mid.h is providing some core parts of the South Complex PM,
which are usually are not used by individual drivers. In particular,
this driver doesn't use it, so simply remove the unused header.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/watchdog/intel-mid_wdt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/watchdog/intel-mid_wdt.c b/drivers/watchdog/intel-mid_wdt.c
index fb7fae750181..b41c45582aa4 100644
--- a/drivers/watchdog/intel-mid_wdt.c
+++ b/drivers/watchdog/intel-mid_wdt.c
@@ -17,7 +17,6 @@
 #include <linux/platform_data/intel-mid_wdt.h>
 
 #include <asm/intel_scu_ipc.h>
-#include <asm/intel-mid.h>
 
 #define IPC_WATCHDOG 0xf8
 
-- 
2.43.0.rc1.1.gbec44491f096


