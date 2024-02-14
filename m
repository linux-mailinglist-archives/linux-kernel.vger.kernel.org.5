Return-Path: <linux-kernel+bounces-65623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E083854F86
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF0E91F29DBB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19E6612EE;
	Wed, 14 Feb 2024 17:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lwVTDd3L"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6ED60DD7;
	Wed, 14 Feb 2024 17:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707930657; cv=none; b=dmfXkG4c8Bijn7QRZbR0OQ/QIpA5CU+slWN4fUksXnQbi3Iyg4wzSad9B4OT2rr+CMjOBgkVQPfw1cKpICXZMD9CAlGtTT2mMU1iMKh7f+ZatKVurgvR9MWykwCpSY3i4ioI83V2GBxLUyxEXqmPjp0OByMtaisrSx2eJVN947I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707930657; c=relaxed/simple;
	bh=cWneu4cGadnP43AtfM005VSnasQf0LJKmBQueS3iyM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VDCX1cReGgi/JWzaJe7xWgi03QFNdWcsQS7FHoiQZC2SH6J5NW/9EJTAlPTsqYakc0gF2ZvkLipcANqmsimWkBU5tyQMsaqDVs/fYAFKPFOmcjhTCVeM1Ps+XBvGX+Un/nSot+AXyXeZPuum5s6JIHCGZdYjrO3ox3loQzeP3DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lwVTDd3L; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707930656; x=1739466656;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cWneu4cGadnP43AtfM005VSnasQf0LJKmBQueS3iyM0=;
  b=lwVTDd3L01cP5pIsqSOlhggcwtfyQMNKyN3xpayznZXYpx5n4kw/Y9go
   6ly/VQnMNlX28+bSrtYZuwUTxgRDYGRZ4XeLp4fo5b9CxL48Ub0einC1M
   GNKp6kVEvqhd3JNmcD2BuRQrjy+Kd6SdCAt7NPkRB4kORcF+6/Z1VRCxN
   kMgf5Jd4fa4hOn8ItgWIeDqpn4wWp0jrdSlkye6kpUY3QREl5+bBLJFLz
   bMW9fmqQsLikGMC9XSbtEcuKK9kDYdHc7bP5poG3N4KqlHqdmYGOM6I4g
   98oFO4M69YBBrvrrpunOoPfbFX2iRUQ4K+CjG9XRRBfySonqbWw6w0MMy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="24458033"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="24458033"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 09:10:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="935617219"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="935617219"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 14 Feb 2024 09:10:52 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id CF7E9338; Wed, 14 Feb 2024 19:10:48 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 5/5] serial: 8250_exar: Don't use "proxy" headers
Date: Wed, 14 Feb 2024 19:09:38 +0200
Message-ID: <20240214171044.3551032-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240214171044.3551032-1-andriy.shevchenko@linux.intel.com>
References: <20240214171044.3551032-1-andriy.shevchenko@linux.intel.com>
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
 drivers/tty/serial/8250/8250_exar.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 3913b8a99161..0afd33a9cf0d 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -6,20 +6,24 @@
  *
  *  Copyright (C) 2017 Sudip Mukherjee, All Rights Reserved.
  */
+#include <linux/bits.h>
+#include <linux/delay.h>
+#include <linux/device.h>
 #include <linux/dmi.h>
+#include <linux/interrupt.h>
 #include <linux/io.h>
-#include <linux/kernel.h>
+#include <linux/math.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/property.h>
+#include <linux/string.h>
+#include <linux/types.h>
+
+#include <linux/serial_8250.h>
 #include <linux/serial_core.h>
 #include <linux/serial_reg.h>
-#include <linux/slab.h>
-#include <linux/string.h>
-#include <linux/tty.h>
-#include <linux/delay.h>
 
 #include <asm/byteorder.h>
 
-- 
2.43.0.rc1.1.gbec44491f096


