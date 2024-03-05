Return-Path: <linux-kernel+bounces-92667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 333E28723E9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAD38B23868
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301261292C6;
	Tue,  5 Mar 2024 16:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="go59IfRZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26177128383;
	Tue,  5 Mar 2024 16:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709655347; cv=none; b=fVjzhU0w+howPyTyuSM5Xx8JF6s68UKSTuy6ZM7gLr7h8twFSWXJWqJ/f3jWiG+KjZZMzyxvdIeSpYDziLxmvQb/HR4a2GRZ+MSr4WKjnO1fLUNorbnCuRSvg/RiDVondpEUikdEDmJ9/B9d8gUvFACaV6OiQcN1IUHnUiv3Zq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709655347; c=relaxed/simple;
	bh=l6LaCb/u3B0wAwXgHTEg1l2ac9pj3w5Wmrdnf+Il8fQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NQfJIRxT9WvdTqlyO73nYuqbo6iON1bfuYe5vzity0rzwSHudbHQEWrnxB+itnzrZdS78Li2clddeS9AJfVHljCayuudw28i7e3mmsQBExTpNM56Otwes1SLudu0wP7bVFqJ2nGPudGGIvS5QAUWZbQNZiBip1TneoXjpsrpokg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=go59IfRZ; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709655346; x=1741191346;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l6LaCb/u3B0wAwXgHTEg1l2ac9pj3w5Wmrdnf+Il8fQ=;
  b=go59IfRZgvQ6Xe7E2O1DuBcxEDj7NXL7l6hyH/pmk+L+Wtnd8yP78Cc1
   1R4Imd1Ow34WGHZOfyIZnIo8k6Kt1cMhL93xGOlsdOI5KLVo41HZm/7Ma
   sT5J/9gTXH7F32Q6XmjAupnWqffoOQuArEaGYiA+3r4tJVmYM0pOhf+0T
   DFJLO8+LrIitKKvSDNPWnyto4q4NAX/0b1O3n6s8JG2UnOXt820OjtfOa
   duB8IrX6Qf7BqhIXAotQyWkaERcp0UMKqLnROHlcoLQxxZAcUr00CcAjB
   PXS2FA/3SiO0gmv6v/e5Zosae9LB5+H8Y553crckRzItNuzqN/bjpVQE6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4078451"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="4078451"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 08:15:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="937042664"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="937042664"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 05 Mar 2024 08:15:41 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 8C61112B; Tue,  5 Mar 2024 18:15:40 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>,
	Julian Winkler <julian.winkler1@web.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v1 1/2] platform/x86: intel_scu_wdt: Remove unused intel-mid.h
Date: Tue,  5 Mar 2024 18:14:58 +0200
Message-ID: <20240305161539.1364717-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240305161539.1364717-1-andriy.shevchenko@linux.intel.com>
References: <20240305161539.1364717-1-andriy.shevchenko@linux.intel.com>
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
 drivers/platform/x86/intel_scu_wdt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/platform/x86/intel_scu_wdt.c b/drivers/platform/x86/intel_scu_wdt.c
index c2479777a1d6..a5031a25632e 100644
--- a/drivers/platform/x86/intel_scu_wdt.c
+++ b/drivers/platform/x86/intel_scu_wdt.c
@@ -13,7 +13,6 @@
 
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
-#include <asm/intel-mid.h>
 #include <asm/io_apic.h>
 #include <asm/hw_irq.h>
 
-- 
2.43.0.rc1.1.gbec44491f096


