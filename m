Return-Path: <linux-kernel+bounces-131964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D9E898E05
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFAEC1F2A8AA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89C813340A;
	Thu,  4 Apr 2024 18:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VWCF/zdE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF521311AB;
	Thu,  4 Apr 2024 18:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712255703; cv=none; b=aX5Ers2p+jk74Wxd3jCm/79hM3P2DPHepZwnZ0HefQeP/JEJ62U4TGf59JyjOv3PKiFinGKHkrwcRhiV/lEi9Cyv9cW3iBmjODb+GxRNbvLZI+tVPD8ZgRm4NPpJpZnWapfT/MVLwBiPs78PX/0zOERBYBtaHyVSrGAIQq618Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712255703; c=relaxed/simple;
	bh=/aQbPktaEsrl69j6tarT379hJHFvCIgKIzP+8upMQ/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IdosOzKl/8/UAb3yxtyDVyEa+BGy0zebolDEoWAXeNUplvHSAr03m7RuvojWrUFm0nyeIMZsu/xxR+mObUDjAY9VDNq8DvK1vEouo6ipIoe1Te4oBOJXv7nMqJLTNZ0q7LyBKeFzZHmtVCckLvDFBKNyciOkdgNTRtsMOMsQzEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VWCF/zdE; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712255702; x=1743791702;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/aQbPktaEsrl69j6tarT379hJHFvCIgKIzP+8upMQ/k=;
  b=VWCF/zdETxhtokvvTBuwv+TcrYoT1HqVwj7TMUKFAVOHaUdrBj7egh6j
   eYJ+DBF4eRK6koWZyTxhvPcNC15osd/1QQJTjr1upztIFehVKUDrtwh56
   QWA/bspK1wQMnzeEUH9rg5ul30OmS60oVrhmzj05KWB38WpY0cRf2C8jg
   yKE8fJ0lnBT6QSh8BFMzyl/rtlAekQaLyxJpBFZCuNbyjXKjWYJhu9LOQ
   qEz2VTPTbuZ9/goORKcbXxJbcbDOHgwQUzrt0D4pC5o/sIEucdKw+Zpc0
   eFBfia6aKbn8OJBCkgPRH0TUHTrImndDmR1Wt4E0lYBped2yPBXmPEiV9
   Q==;
X-CSE-ConnectionGUID: UtxODOE0RdOeCuc/H/a7KQ==
X-CSE-MsgGUID: 330fEbFBS0aZAUOAqBsfMw==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="7751318"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="7751318"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 11:34:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="937086998"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="937086998"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Apr 2024 11:34:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 89678812; Thu,  4 Apr 2024 21:34:54 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Zhang Rui <rui.zhang@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: [PATCH v2 0/4] ACPI: x86: Move x86 stuff into dedicated folder
Date: Thu,  4 Apr 2024 21:23:38 +0300
Message-ID: <20240404183448.3310449-1-andriy.shevchenko@linux.intel.com>
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

In v2:
- fixed acpi_lpss_init() stub visibility (LKP)

Andy Shevchenko (4):
  ACPI: x86: Introduce a Makefile
  ACPI: x86: Move acpi_cmos_rtc to x86 folder
  ACPI: x86: Move blacklist to x86 folder
  ACPI: x86: Move LPSS to x86 folder

 drivers/acpi/Makefile                            | 7 +------
 drivers/acpi/internal.h                          | 3 ++-
 drivers/acpi/x86/Makefile                        | 8 ++++++++
 drivers/acpi/{ => x86}/blacklist.c               | 2 +-
 drivers/acpi/{acpi_cmos_rtc.c => x86/cmos_rtc.c} | 2 +-
 drivers/acpi/{acpi_lpss.c => x86/lpss.c}         | 2 +-
 6 files changed, 14 insertions(+), 10 deletions(-)
 create mode 100644 drivers/acpi/x86/Makefile
 rename drivers/acpi/{ => x86}/blacklist.c (99%)
 rename drivers/acpi/{acpi_cmos_rtc.c => x86/cmos_rtc.c} (98%)
 rename drivers/acpi/{acpi_lpss.c => x86/lpss.c} (99%)

-- 
2.43.0.rc1.1.gbec44491f096


