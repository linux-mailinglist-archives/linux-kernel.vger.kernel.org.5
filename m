Return-Path: <linux-kernel+bounces-130242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6BE8975DB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 838D61F293F1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8687152DFA;
	Wed,  3 Apr 2024 17:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gmyhAYwV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FA91411FD;
	Wed,  3 Apr 2024 17:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712163790; cv=none; b=PDM0pqRURgdm2dPh6zOouLAvKIIPAD9BWVSyIE8xUwHecG/K1o5ySYjmp3LO4SW5KGuJIG935R3GCywA+W9SFMM38IMX4b28BesccB10nVKCFV+YTH17EOrxHZkKAPI9HjHDd7I32NtyfIJhgbs2Q44JNIZNBKoYiIj5kDz+l6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712163790; c=relaxed/simple;
	bh=LdNs8VOby8bDx1XcYP9bF2KiEG2zVFeFUbQ0GcT6uEs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h/gQ4dbrKm1GSzb8OoIX3mDgNGhi46LaQTPOmcrtT0mzU4fEZvBdJ7OHGIUbINqFPAOp1PSYZY098Vgz3XU58AVfy+a8nLhqdM+HYnwsuXAHki6IAyOUERsOU/lweCVwb33R/kPMPAki0urhZ+VrcD3a+tX8Bi1Xhk0hiXOxMuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gmyhAYwV; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712163789; x=1743699789;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LdNs8VOby8bDx1XcYP9bF2KiEG2zVFeFUbQ0GcT6uEs=;
  b=gmyhAYwVO3tSbug+aBBYWueYjB1KyYLpNInlL8n3x2BEVK5vcw37YtHT
   wyjaHoK+EW+A5ZREh3UP6l/PDR/sqQ6wuceMnVE4kiSPzvrpf0iWYklFg
   u1qkTY8dJZcCStR3/MLNKfJAPfHGy868z4u8Sxjm0UgdeEW0E0qbuYIcu
   /52A600/yKH9aTy42SAgJCKTiXzJyTlZ3sDCSGTEI9yeHAlSf29JJmW4G
   3+oAWOUNrbFbNYImNUjlRZcawNmewtrA3doAtzKUUhQP4bqcYiEs7mrL6
   aFlg8INDDmEAbFr1fyfrUYjEPpUufSLV7KheUlvx+HWNkzFB5ld6e5qkl
   g==;
X-CSE-ConnectionGUID: +swq/hKdT7iCCw8Q06O8Jw==
X-CSE-MsgGUID: bHpFys3bTEKp3PnN8N6Crg==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="18861486"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="18861486"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 10:03:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="937085328"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="937085328"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 03 Apr 2024 10:03:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id E4421192; Wed,  3 Apr 2024 20:03:04 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Zhang Rui <rui.zhang@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: [PATCH v1 0/4] ACPI: x86: Move x86 stuff into dedicated folder
Date: Wed,  3 Apr 2024 19:54:34 +0300
Message-ID: <20240403170302.1073841-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move x86 related modules (which are solely for x86) to the dedicated
folder.

Note, there are more modules, but they are related to tables and
potentially might be used for other architectures in the future.
Hence touched only non-table related code.

Andy Shevchenko (4):
  ACPI: x86: Introduce a Makefile
  ACPI: x86: Move acpi_cmos_rtc to x86 folder
  ACPI: x86: Move blacklist to x86 folder
  ACPI: x86: Move LPSS to x86 folder

 drivers/acpi/Makefile                            | 7 +------
 drivers/acpi/x86/Makefile                        | 8 ++++++++
 drivers/acpi/{ => x86}/blacklist.c               | 2 +-
 drivers/acpi/{acpi_cmos_rtc.c => x86/cmos_rtc.c} | 2 +-
 drivers/acpi/{acpi_lpss.c => x86/lpss.c}         | 2 +-
 5 files changed, 12 insertions(+), 9 deletions(-)
 create mode 100644 drivers/acpi/x86/Makefile
 rename drivers/acpi/{ => x86}/blacklist.c (99%)
 rename drivers/acpi/{acpi_cmos_rtc.c => x86/cmos_rtc.c} (98%)
 rename drivers/acpi/{acpi_lpss.c => x86/lpss.c} (99%)

-- 
2.43.0.rc1.1.gbec44491f096


