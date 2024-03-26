Return-Path: <linux-kernel+bounces-118882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1A688C098
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D2B7B24886
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA64555798;
	Tue, 26 Mar 2024 11:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QyjpaUl2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0454DA19;
	Tue, 26 Mar 2024 11:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711452302; cv=none; b=iKVuTF4PASPGZMyoHd50VoPGvkXyoC80MfNsfs9xV2Lf3H+9y1IK+BYi6aPGqLnuT78J+bYLoT1819V5MIeYEE+C467yT2TfPK0xUiDO8UfHO+7y/d7z72F/Wm7Hi1U0iEXmEez1mFhRV1Sn83nJDpF81lstLPOllg8Bearq7to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711452302; c=relaxed/simple;
	bh=BRfFcL2AKU3VjXbghGHPDx9Ti/o9n8Vnr1hs7D5oKJA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=D0BFE96y9UFEXe/L1sEJBzhJE7Akgg4gjPYHUh5+JkYJC1rTkfvApR3bQmp5SWb39JvTFKN5JKxYDgfDhhSN6TcWK+zQcAuhtGVl9sVWDHwF4D6BEbKlw5m+H/7WlI3aOnqC5xvL8RGeknqL8PuRy+J3xJ/H8IXFV/BWCfsjTQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QyjpaUl2; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711452301; x=1742988301;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BRfFcL2AKU3VjXbghGHPDx9Ti/o9n8Vnr1hs7D5oKJA=;
  b=QyjpaUl2xHAsG7qL4RmiWVn4+Ce6IODLwA19nHcLw5PLqPIS4IVX+T/c
   1O6RsSi+dDr0J/NptP31sxT/BqjomApfZY/PRXJiWaSSJltFLSm6zudsA
   3Vr5svM84MU3YJB4DduJEt4brUlLFG+KBVXz6WSwhCotdlzshn5LSLY9F
   MVPEX2HhK486OdWkufQyAjNbvewptaIsHA26AHJKzSeeR+V3HicYucxFR
   yRkcNWr4QyoSNR6jK/Of5OlsnNxtdSdRnZd1rhbdpEgvHhUziM4sKJXbw
   wOpOvPj+eozwumLvvuo0zWvgHbQvkMR46uX1MaINnnPwcC+Vwsn0sSuyt
   g==;
X-CSE-ConnectionGUID: gHLEE5zETMW/sMeaDerKog==
X-CSE-MsgGUID: LJaRzS4ZQWKHNT/DS30IrA==
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6627084"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="6627084"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 04:25:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="20592627"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.20])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 04:24:57 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: "David E . Box" <david.e.box@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	platform-driver-x86@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	kernel test robot <lkp@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 1/1] cleanup: Fix sparse complaining about passing iomem ptr to no_free_ptr()
Date: Tue, 26 Mar 2024 13:24:47 +0200
Message-Id: <20240326112448.29332-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Calling no_free_ptr() for an __iomem pointer results in sparse
complaining about the types:
	sparse: warning: incorrect type in argument 1 (different address spaces)
	sparse:    expected void const volatile *val
	sparse:    got void [noderef] __iomem *__val
(The example from drivers/platform/x86/intel/pmc/core_ssram.c:277).

The problem is caused by the signature of __must_check_fn() added in
the commit 85be6d842447 ("cleanup: Make no_free_ptr() __must_check") to
enforce return value is always used.

Use __force to allow both iomem and non-iomem pointers to be given for
no_free_ptr().

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202403050547.qnZtuNlN-lkp@intel.com/
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 include/linux/cleanup.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index c2d09bc4f976..4f4d709c3967 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -73,7 +73,7 @@ const volatile void * __must_check_fn(const volatile void *val)
 { return val; }
 
 #define no_free_ptr(p) \
-	((typeof(p)) __must_check_fn(__get_and_null_ptr(p)))
+	((typeof(p)) __must_check_fn((__force const volatile void *)__get_and_null_ptr(p)))
 
 #define return_ptr(p)	return no_free_ptr(p)
 
-- 
2.39.2


