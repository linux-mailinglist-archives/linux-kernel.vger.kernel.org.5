Return-Path: <linux-kernel+bounces-65621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53927854F7F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07D6B1F2369D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA3160ECF;
	Wed, 14 Feb 2024 17:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nAaAs3/K"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6189A60BA5;
	Wed, 14 Feb 2024 17:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707930655; cv=none; b=g0Q+diDJFjnP2W2GSTiwoUt0k/BLyAQ1liPR7tGVlz3i5wNgg0nl3QnkYKHITZUdLJwXIQf6t9cJ20SwHqhp26N1DkTmmiGq8we+TR7Un4Hy3pvO0C/3eLOsFRrNzGP7lb7JEXe29irE7HljniT/AdC1Ts7MbXiz3Ue8Z497dmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707930655; c=relaxed/simple;
	bh=kUiZbiEMkh/Xz3+hmq1lLEQ7AxDT02YREhPln3pQnvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=donvmMCErqWbOAci3x9+XweYAvRtX1R6Au4uQRsZsEZmmi7LFTdQPmZQEBvZoatMArKKz4TuK+wwzmPppLNeMS3iTF6BfBDi3oo+FjLkx5hK8AlR8MtYTWhpDMC9qYOFmMwR/BbZbS8502ARs5ggLsxuHQI6TRGbt+BgFdPZlf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nAaAs3/K; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707930655; x=1739466655;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kUiZbiEMkh/Xz3+hmq1lLEQ7AxDT02YREhPln3pQnvs=;
  b=nAaAs3/Ky88yt1uqfJVfCufWYYnvlsVSCtBbwakDfuFpvsAdZ5W1SNoE
   veubS1Pr0Icuo0vrTOflqGo6q27AQ+pdgJ0fQzUJilDDmvGpX9SoCCICn
   f6QReehPW4Gj7mXjSDixiDg9qnigmTeoCKkCSDqLoUL27HnB0a1oL1L0O
   P/99hd45ZDRizIBp0TxLWqH7FArx/uh78w2yc3iFziDkX+X8MCN0lwppO
   OKgLMrrSOXP5kzas9sRQHLaSSbpiEAaCXbVkldmHJuxFAWvTJV3ug7cm9
   lr4sAoCsivnwO5Rqv/kdPnXeNgNYDIS905lg6vzXMILSvMzfjK+gPkris
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="24458026"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="24458026"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 09:10:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="935617217"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="935617217"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 14 Feb 2024 09:10:49 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id B5BE926D; Wed, 14 Feb 2024 19:10:48 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/5] serial: 8250_exar: Use generic function to set firmware node
Date: Wed, 14 Feb 2024 19:09:35 +0200
Message-ID: <20240214171044.3551032-3-andriy.shevchenko@linux.intel.com>
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

Use generic function to set firmware node instead of ACPI specific one.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_exar.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 32a56ce626b5..7dfb995ec927 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -6,12 +6,12 @@
  *
  *  Copyright (C) 2017 Sudip Mukherjee, All Rights Reserved.
  */
-#include <linux/acpi.h>
 #include <linux/dmi.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/platform_device.h>
 #include <linux/property.h>
 #include <linux/serial_core.h>
 #include <linux/serial_reg.h>
@@ -375,7 +375,7 @@ static struct platform_device *__xr17v35x_register_gpio(struct pci_dev *pcidev,
 		return NULL;
 
 	pdev->dev.parent = &pcidev->dev;
-	ACPI_COMPANION_SET(&pdev->dev, ACPI_COMPANION(&pcidev->dev));
+	device_set_node(&pdev->dev, dev_fwnode(&pcidev->dev));
 
 	if (device_add_software_node(&pdev->dev, node) < 0 ||
 	    platform_device_add(pdev) < 0) {
-- 
2.43.0.rc1.1.gbec44491f096


