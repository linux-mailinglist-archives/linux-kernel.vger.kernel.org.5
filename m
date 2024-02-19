Return-Path: <linux-kernel+bounces-71547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4188B85A6EC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF7F9285579
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40883D96C;
	Mon, 19 Feb 2024 15:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WE/GeHz/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675343A8FB;
	Mon, 19 Feb 2024 15:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708355200; cv=none; b=MxFdzfZd/7hMYgWWP+YVc2QC7SWZ7NLZRdCy+j2jp0drlgLu5BjAVoJ4cWaX4W2MHZzKiml/zwDncLy3pY7mBf9NwlBjHK/jbSH0cMZWywvRa61B9GP+ffINx5DFYsM9S1DtThhdXtc+X7cJ0EPzdIZhPC0Bb2LB6NGi3poArJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708355200; c=relaxed/simple;
	bh=z+Ws30rfAliHI0b46QssEAM2g90mM8I8G/D4OgscpxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z8BxXs9qt8O2Z2XJRBoRPkPXT9ogKWLsf0brkXtZiNiWP/2vsQ7+cBe1WUd9Ec012exT4JLS8HQOZg0NlnF0Tx+Ubja6eB2Ov6y7hdCGMKXZod6/qQPTejz9D4K398o6ubplp6V2CLWgum3srgAUzbVOvqwtGHIkDOrWJ88AT9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WE/GeHz/; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708355198; x=1739891198;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z+Ws30rfAliHI0b46QssEAM2g90mM8I8G/D4OgscpxM=;
  b=WE/GeHz/V/u0/+UoSyfjEerK74UNtM5leEoYjsOOCSEQ74eMr68titx+
   dTY+h8SAhUzk/h44QlwsFvDWJ8YgTNJXOxe13BQb6zJWf1gclowvtLMC/
   FbNB6QQ7fFwedbfRYByriSMj7YY3dahhBRltui4W4kiB2lbhVRZKTz1II
   XRIobB1OpfCL79aiDWSmANuAMb0xI2TAe66qL8GYG1LC+sHN+XP/d6Fkv
   uR4TFexIT+Lwl9KsSVP4lshH6063ChkFnAUyeAMg9Di7Z3RPxDsn/6ezc
   fqtgBPxuC7GX/dpIJ9oMlBh+yJbwXN/y90qaOrq+VjAtToeanjUVcQlL4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="2543809"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="2543809"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 07:06:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="936302995"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="936302995"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 19 Feb 2024 07:06:32 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 2130445B; Mon, 19 Feb 2024 17:06:29 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v2 5/7] serial: 8250_exar: switch to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Mon, 19 Feb 2024 17:05:01 +0200
Message-ID: <20240219150627.2101198-6-andriy.shevchenko@linux.intel.com>
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

SIMPLE_DEV_PM_OPS() is deprecated, replace it with DEFINE_SIMPLE_DEV_PM_OPS()
and use pm_sleep_ptr() for setting the driver's PM routines. We can now
remove the __maybe_unused qualifier in the suspend and resume functions.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_exar.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 2a0c1f7e87f5..53c5ff49e83c 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
+#include <linux/pm.h>
 #include <linux/property.h>
 #include <linux/serial_core.h>
 #include <linux/serial_reg.h>
@@ -746,7 +747,7 @@ static void exar_pci_remove(struct pci_dev *pcidev)
 		priv->board->exit(pcidev);
 }
 
-static int __maybe_unused exar_suspend(struct device *dev)
+static int exar_suspend(struct device *dev)
 {
 	struct exar8250 *priv = dev_get_drvdata(dev);
 	unsigned int i;
@@ -758,7 +759,7 @@ static int __maybe_unused exar_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused exar_resume(struct device *dev)
+static int exar_resume(struct device *dev)
 {
 	struct exar8250 *priv = dev_get_drvdata(dev);
 	unsigned int i;
@@ -772,7 +773,7 @@ static int __maybe_unused exar_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(exar_pci_pm, exar_suspend, exar_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(exar_pci_pm, exar_suspend, exar_resume);
 
 static const struct exar8250_board pbn_fastcom335_2 = {
 	.num_ports	= 2,
@@ -922,7 +923,7 @@ static struct pci_driver exar_pci_driver = {
 	.probe		= exar_pci_probe,
 	.remove		= exar_pci_remove,
 	.driver         = {
-		.pm     = &exar_pci_pm,
+		.pm     = pm_sleep_ptr(&exar_pci_pm),
 	},
 	.id_table	= exar_pci_tbl,
 };
-- 
2.43.0.rc1.1.gbec44491f096


