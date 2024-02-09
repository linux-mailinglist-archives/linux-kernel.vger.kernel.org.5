Return-Path: <linux-kernel+bounces-59574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C465484F92D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 662861F23445
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152137EEFC;
	Fri,  9 Feb 2024 16:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HN67/GcG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24577BB08
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 16:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707494624; cv=none; b=iivLV2e+B8ERMwaIDSSUVxncK0B1XOf5LmvK7hujm43iila+YBHRNVlRr3B9y8qHyj3Io+hD9+VTON7WgPUzO6BoUJ/Eu/jjcZ9oxHfsmSAXyzGDL7unPCAjNbHdV4L/O5lvKMjdu7k5aj5KVQ5nsNTtF8lU+50eyEk9e0U+OSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707494624; c=relaxed/simple;
	bh=rwEsgngaV9IDPY5c2M3rnBWaSuyjqeEB7+v3YF0TYSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aqsM3k+lIkiXrvr9uq9k3p7knDEl7KG5Wlrh8mmaj522M3ZXBHy/lY/XeaJnjBQWz3UjkdZMqoXChkHBnbxvdBW6gGj/m3e/MoDaI5ROGooOZ56VhNPIXl4ohOkkbiNvBc76PQU1FfWHDjG+jkxBaQtdMdovWLd8f2tfdAYiWus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HN67/GcG; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707494623; x=1739030623;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rwEsgngaV9IDPY5c2M3rnBWaSuyjqeEB7+v3YF0TYSY=;
  b=HN67/GcGiSrph1/H5Z0oJfN5kPLDBU1my0dHm/iCDnbHWxKYJytIQ/bQ
   bu51FvuohZUPyFxPXzkzmsrC20zFr0S+I3puUHVluawEVfWBTwvedfuv8
   cUtvf9KBYpZWhTv1L5dz42NANY5FL3RXLrMVCllAxoVg9XK2H1yIvEG6H
   3DqfCpZaaj7coW/aUfFkep5vrfqTxe37IxSv5TEOAmv/7BPHDERodr9P3
   Mp2hHxRzPlcAdGKpLBBVwawy8BJ6/qi66E8Nvag+NErHzTVmwFo9jBjBX
   5mejw4TbILO6sA+LFhK7yuPY6yZwT4A5FB5j+Fn8rmnILoH8vDju7csta
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="4432022"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="4432022"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 08:03:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="934459659"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="934459659"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 09 Feb 2024 08:03:37 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 9AAE3161; Fri,  9 Feb 2024 18:03:36 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Subject: [PATCH v1 2/2] phy: ti: tusb1210: Define device IDs
Date: Fri,  9 Feb 2024 18:02:15 +0200
Message-ID: <20240209160334.2304230-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240209160334.2304230-1-andriy.shevchenko@linux.intel.com>
References: <20240209160334.2304230-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define device IDs since some of them are being used more than once.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/phy/ti/phy-tusb1210.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/ti/phy-tusb1210.c b/drivers/phy/ti/phy-tusb1210.c
index 7232b104a62d..13cd614e12a1 100644
--- a/drivers/phy/ti/phy-tusb1210.c
+++ b/drivers/phy/ti/phy-tusb1210.c
@@ -17,6 +17,10 @@
 #include <linux/property.h>
 #include <linux/workqueue.h>
 
+#define TI_VENDOR_ID		0x0451
+#define TI_DEVICE_TUSB1210	0x1507
+#define TI_DEVICE_TUSB1211	0x1508
+
 #define TUSB1211_POWER_CONTROL				0x3d
 #define TUSB1211_POWER_CONTROL_SET			0x3e
 #define TUSB1211_POWER_CONTROL_CLEAR			0x3f
@@ -436,7 +440,7 @@ static void tusb1210_probe_charger_detect(struct tusb1210 *tusb)
 	if (!device_property_read_bool(dev->parent, "linux,phy_charger_detect"))
 		return;
 
-	if (ulpi->id.product != 0x1508) {
+	if (ulpi->id.product != TI_DEVICE_TUSB1211) {
 		dev_err(dev, "error charger detection is only supported on the TUSB1211\n");
 		return;
 	}
@@ -562,11 +566,9 @@ static void tusb1210_remove(struct ulpi *ulpi)
 	tusb1210_remove_charger_detect(tusb);
 }
 
-#define TI_VENDOR_ID 0x0451
-
 static const struct ulpi_device_id tusb1210_ulpi_id[] = {
-	{ TI_VENDOR_ID, 0x1507, },  /* TUSB1210 */
-	{ TI_VENDOR_ID, 0x1508, },  /* TUSB1211 */
+	{ TI_VENDOR_ID, TI_DEVICE_TUSB1210 },
+	{ TI_VENDOR_ID, TI_DEVICE_TUSB1211 },
 	{ },
 };
 MODULE_DEVICE_TABLE(ulpi, tusb1210_ulpi_id);
-- 
2.43.0.rc1.1.gbec44491f096


