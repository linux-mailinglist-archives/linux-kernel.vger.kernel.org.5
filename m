Return-Path: <linux-kernel+bounces-131368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A773A8986CC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54C481F23519
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9001E86636;
	Thu,  4 Apr 2024 12:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N8gXI+P0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6278527B;
	Thu,  4 Apr 2024 12:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712232544; cv=none; b=lG2tKy0oZzqTsnQwAGh2usCL0hrqGsSPSNXVHgZyYCBdnxDCh3pMJsSe75beiwmVwfV1fT5AHiMRsIXiGY3X4bHpX8BJUDWybjW1nVN+VCA9ykPdU2KWBuoDYUL2a4KrVJjaA9brfqrLn42+HVhzw+TrHIKo3AancgoHReQghsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712232544; c=relaxed/simple;
	bh=/D4uMFIkhTDyJK8HO5ZeD9TQWsYFezpRYZfKGXv8hRU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WUNUNqCsQtKR0RYb0oKOtsnZ/obBFWREqjeFG9x0nsxrtBzI7kHZI01Zs+kLNtqn0MQGopS/easeFOE+S4vnemCawiFA9P2Bfsg83v0/moc+2Me2BYbN9fD2EgTu1oB17MR2yMxXcd2cRUFcaaI9Bh9LHF2ihGqOHziTq+YkmzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N8gXI+P0; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712232544; x=1743768544;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/D4uMFIkhTDyJK8HO5ZeD9TQWsYFezpRYZfKGXv8hRU=;
  b=N8gXI+P0WHFuW2WtiGvSHmHA6MqSML0DZ0UK8e8pJFYJj6+wwJwGh7kI
   +d8D8owec4jvxlzWkMeXAGfCKPFKvbETjNZBY3iZM4g6RG38m73OEpQC9
   LInZlFKNC6Bz9ftNvu54xHmIslWM8WcdIhKBGGeAeoTWNSpTBqBYa8vzx
   /C9saOJdzM/ZLQtblWb0Uv34Nm5GS5W4NEnXNxdkrJEkbVN6HWsnPR/lx
   DPNqIn9F/QvYI3lsdie/YR0n6fT2vw3AMpyP48o6tIGtMSVKQ2mAC8/c1
   zs7qVnaIjPUq/alpReCZVpNOkcCdjwKq6AE+IEEVz2csRSXwUfpFeG6NJ
   g==;
X-CSE-ConnectionGUID: rZ8tOAxJTp64r8YCKI2WUQ==
X-CSE-MsgGUID: atAaa0V4RQuhm/UM79zQJg==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="18240562"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="18240562"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 05:09:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="937086417"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="937086417"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Apr 2024 05:08:58 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 6BE5A193; Thu,  4 Apr 2024 15:08:57 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 0/2] ACPI: LPSS: Prepare for SPI code cleanup
Date: Thu,  4 Apr 2024 15:06:57 +0300
Message-ID: <20240404120856.4109303-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An ad-hoc cleanup followed by preparation for SPI code cleaning.
The latter will be done in the next kernel cycle to avoid conflicts.

This patch series should go before
https://lore.kernel.org/linux-acpi/20240403170302.1073841-1-andriy.shevchenko@linux.intel.com/

In v2:
- added Fixes tag to the first patch (Rafael)
- reordered to get Fixes first in the series
- v1: 20240402152952.3578659-1-andriy.shevchenko@linux.intel.com

Andy Shevchenko (2):
  ACPI: LPSS: Advertise number of chip selects via property
  ACPI: LPSS: Remove nested ifdeffery for CONFIG_PM

 drivers/acpi/acpi_lpss.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

-- 
2.43.0.rc1.1.gbec44491f096


