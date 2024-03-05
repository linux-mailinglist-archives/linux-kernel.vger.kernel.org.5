Return-Path: <linux-kernel+bounces-92781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5898725ED
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BD271C21768
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC9F175B1;
	Tue,  5 Mar 2024 17:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RNxCVre5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11C117565;
	Tue,  5 Mar 2024 17:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709660980; cv=none; b=gTSHfKj8tjzT+AAbHYo69OaqzY7cmGOaCzNiqhjVyLh8du6aAklAR9pSy9EJZaK1fp367qwkSERswd6WCqMciLyO8btSkYqDv68kD9Rg4YkJs/UW63YZHL1lzfOy9o14Xfh/i7nlKnJ8t2S4bx61iI1eCzZUfHipRoZ56j0p+7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709660980; c=relaxed/simple;
	bh=CM6w5v/94UBYk5+XLsqdJrfk2UXwpgxCl68ULYV3MTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WRIPFTvW37MPHayn6u9pbUmQOXZdeUDQlgrBbueripGG2ajDqoCYxfisjLe+JyTg0qVPlnlc/z3tniMVyMO+tahNrb9i1ZTM1U3PMquzTrA6H4Tc6ymvD278tIvwjr/1dB//i8NrkwLBWxKKE2724ewAOL+V0FfYS5FQRB/iVAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RNxCVre5; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709660978; x=1741196978;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CM6w5v/94UBYk5+XLsqdJrfk2UXwpgxCl68ULYV3MTg=;
  b=RNxCVre504JefksvhY6f6UaVFM3LtmhxIU7HJ2zSoJMO6D2tbG14Qzq+
   GTzkIQWPnm0w0tRC5uyJB4DPH/0PchWKlEWLSCgOR0tbDw8XSPapzDRYK
   PSmrxQTs+Zec6B0Fi4PV8Rib4VMgD3vRPE7PlEEQ7b6B27g8/ogSMPWD+
   VGE8g+UhxIUzsN0IccmrQlj8+sKab/kRMD2gH4oaPOPK95f5Wy2doo13u
   Lt4oobdbh/DSFNQQX95Nx/pC5kACm0J4DguD8AvM3pfeSylYY9jEQ+Hpu
   yGeVBfDEpfqUOqCVwpMTBXut68dYTdw8bZx9Qief2lNxV7JQRKbNE0J6p
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="4092442"
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="4092442"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 09:49:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="937042795"
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="937042795"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 05 Mar 2024 09:49:36 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 2F23A1A6; Tue,  5 Mar 2024 19:49:35 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>
Subject: [PATCH v1 1/5] media: ir-spi: Don't use "proxy" headers
Date: Tue,  5 Mar 2024 19:48:26 +0200
Message-ID: <20240305174933.1370708-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240305174933.1370708-1-andriy.shevchenko@linux.intel.com>
References: <20240305174933.1370708-1-andriy.shevchenko@linux.intel.com>
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
 drivers/media/rc/ir-spi.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/media/rc/ir-spi.c b/drivers/media/rc/ir-spi.c
index bbc81bed4f90..28437a35b7ba 100644
--- a/drivers/media/rc/ir-spi.c
+++ b/drivers/media/rc/ir-spi.c
@@ -4,13 +4,18 @@
 // Copyright (c) 2016 Samsung Electronics Co., Ltd.
 // Copyright (c) Andi Shyti <andi@etezian.org>
 
-#include <linux/delay.h>
-#include <linux/fs.h>
+#include <linux/bits.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/math.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/mutex.h>
-#include <linux/of_gpio.h>
+#include <linux/of.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
+#include <linux/string.h>
+#include <linux/types.h>
+
 #include <media/rc-core.h>
 
 #define IR_SPI_DRIVER_NAME		"ir-spi"
-- 
2.43.0.rc1.1.gbec44491f096


