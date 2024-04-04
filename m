Return-Path: <linux-kernel+bounces-131932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20876898DAA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAE941F23177
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96A112FB1E;
	Thu,  4 Apr 2024 18:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LPsbJF67"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71374CA62;
	Thu,  4 Apr 2024 18:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712253757; cv=none; b=inqWb1VY5Wp/BbHg1LNOb2Im5WWIUp+8pqWvzg3VFNIvTxle9NcM1rmot4bQr7Sq6ouN0mmQ0M6sCEIskIZdxzZPKz1UfpErEMRypm11YPm5QGGM2VNyMZFIKE/Th0z4O31bCpvyyxHeQ0YKyzCp7uvXrVFg8gBZv7ap5Ek1Jik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712253757; c=relaxed/simple;
	bh=U2c+qIpXhAALPU+biYo/I5snEWFplTVnaPPS/o1WEO0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WQ03FkS8OazqJtAq4PFxEr/mVM8mfivIdd+oVEM9Ty184VdyK/kv3LhklUvAeNohAgzZTqORDLXC3bylDJ4s2T75E1bz08Z4ulXayar1+Zt20jwTqjeox3I9f3M6Ahm0eRHzKrZfcQh6VP2sF2viI5+LqtR7TKchFol4GY1TEBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LPsbJF67; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712253756; x=1743789756;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=U2c+qIpXhAALPU+biYo/I5snEWFplTVnaPPS/o1WEO0=;
  b=LPsbJF677ntKaXGkolOAkqCBH3fgLiIeDDqOyPpH6tnWoHi/5zLzBPEh
   CDc4m79Td6Kk+22U51tyfXFzNwgU8kN3/zUVBXXjd23BvGtCxzBoeq/Zs
   RbgkV7nRFELVttgnXfRWklAvONNcPQFebEGS8dXr7CSLTeHbjwyDh3U1W
   Q4pEe0u3+PxdN8d8HVoJhDCTW1fCnbW/ZjtRzw0961ox2sfBhgfF8FJT0
   QRrBSjzp/qd9lOVvEasRfHe/vYh8qfDB9zp4j5gQsmwp6k33JjJL5UfyL
   GIKivhcfITL8bP/JBtoToBtly7yyFpxlNC8SCyq1j3WxcVdKutFEoYrr4
   A==;
X-CSE-ConnectionGUID: 8YMd+qvMQQ6MsyJaVkh0IQ==
X-CSE-MsgGUID: PgjUBkvDTDOp6xceXLU6BQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="7657569"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="7657569"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 11:02:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="937086940"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="937086940"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Apr 2024 11:02:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id C4EB5812; Thu,  4 Apr 2024 21:02:31 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v1 1/1] ata: ahci_platform: Don't use "proxy" headers
Date: Thu,  4 Apr 2024 21:02:30 +0300
Message-ID: <20240404180230.2470407-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update header inclusions to follow IWYU (Include What You Use)
principle.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/ata/ahci_platform.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 81fc63f6b008..7d7b1e9c4932 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -8,16 +8,16 @@
  *   Anton Vorontsov <avorontsov@ru.mvista.com>
  */
 
-#include <linux/kernel.h>
+#include <linux/ahci_platform.h>
+#include <linux/err.h>
+#include <linux/libata.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/pm.h>
-#include <linux/device.h>
-#include <linux/platform_device.h>
-#include <linux/property.h>
-#include <linux/libata.h>
-#include <linux/ahci_platform.h>
 #include <linux/pci_ids.h>
+#include <linux/platform_device.h>
+#include <linux/pm.h>
+#include <linux/property.h>
+
 #include "ahci.h"
 
 #define DRV_NAME "ahci"
-- 
2.43.0.rc1.1.gbec44491f096


