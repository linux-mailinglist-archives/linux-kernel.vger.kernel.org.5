Return-Path: <linux-kernel+bounces-92666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FB68723E6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 494321C2155B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BF0128805;
	Tue,  5 Mar 2024 16:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lXn+H1fD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE535C608;
	Tue,  5 Mar 2024 16:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709655346; cv=none; b=EvJMUiyyUSqFV322TRG2ktCJAG+0Ct5gM3ourNkMPp2jj2kpGdWiYU+rmYGAFFAVf4rA+Ri3+rwjvWsvcYrPJ5KC0TfdPerOrYsU9/Gy9tlJJQbs66sPIqsgR7+uIu3e3luZemNGyIvZGSLSHpM81MAMd+PnzLN9e+2KiX7RcGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709655346; c=relaxed/simple;
	bh=7iL6/qluOYylVMxHhAr53mvaSG026z/mn/LlDAoQfIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZLZF5FJ6WFuKolnMBKSj48c7CDjjL4e6iidR7QYxSALHSuc7dbo+MCSsjNgHwCHJEfl8jbtGcsZOWpaL1sD+gznKGho7yQ023cbIkLhJTOhhaPSMphoUfsGMnSwkW9D7KFJoQJbFIbCYNqQBgBv2qsAk7MgM9Jk8HwNmRk5e0yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lXn+H1fD; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709655345; x=1741191345;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7iL6/qluOYylVMxHhAr53mvaSG026z/mn/LlDAoQfIA=;
  b=lXn+H1fDGOm5X1v0JqBeB8F59KMYBx5zTTdmOsK8uFtWpG3FskeHHBvb
   Zh3YSd8q5K4BQ91BPuVoM50lSTLXSqEi7FEGSklFRyxcjybRhz5NWTg+O
   BgNm1stWjnTv6NQnwevf2i4SMOv4UkUlNlT68l1H0P2zkOCJUHQc2Cgo4
   RwOXLl4QklFKbdO5qUujuHkpIrbg1RfEOI0nWmc1L9Sp/uRHYP1PXZ44P
   mOhsBUawLFHoUJzEZUPZwUAoj7bUgj1ENHhn2FdQrdcpBJ71eNaKdz/0v
   hW7p6PkblTMXGBrFu1zyOTJPxfAaJNBB1oJLrXwmrGZE5ds6VF+H74Z09
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4078446"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="4078446"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 08:15:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="937042663"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="937042663"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 05 Mar 2024 08:15:41 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 9B6453C0; Tue,  5 Mar 2024 18:15:40 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>,
	Julian Winkler <julian.winkler1@web.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v1 2/2] platform/x86: intel_scu_pcidrv: Remove unused intel-mid.h
Date: Tue,  5 Mar 2024 18:14:59 +0200
Message-ID: <20240305161539.1364717-3-andriy.shevchenko@linux.intel.com>
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
 drivers/platform/x86/intel_scu_pcidrv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/platform/x86/intel_scu_pcidrv.c b/drivers/platform/x86/intel_scu_pcidrv.c
index d904fad499aa..dbf0310448da 100644
--- a/drivers/platform/x86/intel_scu_pcidrv.c
+++ b/drivers/platform/x86/intel_scu_pcidrv.c
@@ -11,7 +11,6 @@
 #include <linux/init.h>
 #include <linux/pci.h>
 
-#include <asm/intel-mid.h>
 #include <asm/intel_scu_ipc.h>
 
 static int intel_scu_pci_probe(struct pci_dev *pdev,
-- 
2.43.0.rc1.1.gbec44491f096


