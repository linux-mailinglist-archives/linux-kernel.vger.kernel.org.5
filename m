Return-Path: <linux-kernel+bounces-71542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6105285A6E2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EC1E280F17
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B345F3984D;
	Mon, 19 Feb 2024 15:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OckLUJsP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541DB3770C;
	Mon, 19 Feb 2024 15:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708355196; cv=none; b=u5BKMC2evDkBaH0AKfCFLPSL3CCVWl5XhZsLqJhiW1nxXdEs7kzGv1PxH9h36cFPYWig3VASPFxgyJw3/zG4oah4OntVkJC+29KJxj9E3fCuldWZawGj4pVQ0FIYHL3mNgVMLhTqqqphnruiJKziAGGyef5xs1B2NN85pln6AVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708355196; c=relaxed/simple;
	bh=1O2LCsHcutszivKQ7ugn2zdlp1ZqgFp0cxdBQ8mkIts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sm5rOqyFly8fFFqkMEREVmpgyuDNwPX1QfZgL4jzZ1wbcq5YxtOVrwhqMnFQQDP3SduZe9V2ni3fMtKVsSdAQdFWkan8EXNlnPYoMKbZrmHi9O+om4Azo4FPYEe+DVkkhc4WmaVyw3CRDey2h3vfeladAaNQ1EnbMZ+CErzw/ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OckLUJsP; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708355194; x=1739891194;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1O2LCsHcutszivKQ7ugn2zdlp1ZqgFp0cxdBQ8mkIts=;
  b=OckLUJsPov4WkVhIXveZTO9AzLvZ2gX7wYVwI3seJyEvJTcRtTAyHyEA
   DI0E5UnC4AYMhSximBisuKKf1bTy2UGROhcvf2N/LmFL/TDB3IcwfPn4+
   G65pMuHY0dBWg0BICbfluO4Qw20y8mQBv0eKLPidC/zLa4s5E/Weu1gQc
   AqUxCtV1vlAH/pN5QCoBwGIhy5nA71GK5QEKBRssvseX8RQPVZdXMgwPX
   P+WCKTmHor++UC6DifXPg9vhWuijvEu8U6k6vTlMUWiK5sSrhHPkYk8mr
   amaGZu0b+mptl6byAmp1+9wCsRlZk9eroieQeuEpH73Yw0Pho7TO9+QZx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="2543773"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="2543773"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 07:06:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="936302989"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="936302989"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 19 Feb 2024 07:06:30 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 09D433C7; Mon, 19 Feb 2024 17:06:29 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v2 4/7] serial: 8250_exar: Use generic function to set firmware node
Date: Mon, 19 Feb 2024 17:05:00 +0200
Message-ID: <20240219150627.2101198-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240219150627.2101198-1-andriy.shevchenko@linux.intel.com>
References: <20240219150627.2101198-1-andriy.shevchenko@linux.intel.com>
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
index c7afa06a420e..2a0c1f7e87f5 100644
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
@@ -363,7 +363,7 @@ static struct platform_device *__xr17v35x_register_gpio(struct pci_dev *pcidev,
 		return NULL;
 
 	pdev->dev.parent = &pcidev->dev;
-	ACPI_COMPANION_SET(&pdev->dev, ACPI_COMPANION(&pcidev->dev));
+	device_set_node(&pdev->dev, dev_fwnode(&pcidev->dev));
 
 	if (device_add_software_node(&pdev->dev, node) < 0 ||
 	    platform_device_add(pdev) < 0) {
-- 
2.43.0.rc1.1.gbec44491f096


