Return-Path: <linux-kernel+bounces-65619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C21D9854F7D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 700A71F22BD9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CA160DE1;
	Wed, 14 Feb 2024 17:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EzwMNcYx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D5F6087C;
	Wed, 14 Feb 2024 17:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707930655; cv=none; b=cfikmelu81OGadJSceyyUNxQ+mgO//6jtn/NI3u4QJjuQcKMCaO9G4S6p8Ha+tt2w1VKO97CHM9AhQTehIXU20IfKn0wUg8jGjAsjCzdU3BdDBuIRDxxj/MgUuh3DYP9T6e9ha2ToZ0opUb/r89co2jsLkBZ0Kr+0I3z83H65mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707930655; c=relaxed/simple;
	bh=lh/6QP+fLjWx7NnRnuGXCG0uePmFC6Mmb21smh0lUm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KDq/szPi6ApbeqK9Gglc3t1++gEtKstOzLZc9XMPsw1KHWtDSX9C38BDaL+isA1HJAKQOHTBJAyz+ryYVxmPIvBdAXNVgkKmlyhQcdVCq4sAucoSTmmUJzTgC3LpPY/NIez67wrOnI85uP0ua+8QDRbOInSDMkY1lZwM5sZRjNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EzwMNcYx; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707930654; x=1739466654;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lh/6QP+fLjWx7NnRnuGXCG0uePmFC6Mmb21smh0lUm4=;
  b=EzwMNcYxXHO12VzOFfLoLm3P6TmNQyy4XzYCQ7eg/Dlyo3vy61iw7UMM
   MATd7EVwwKKDYkUf3tbosClxHNiLLI38z2l/DBpzfiDYn/EGkm4ZZASJy
   7fihBGH6tocPhWVYybXtuW1eEDZLeRKGPCj8t13E9nnnnQ6GzKfdMAdMu
   ytjMH/zCvmrSxEut8GLT/2olvmRbuvShjcDCHzN0m3+bPFTpV9gEwD4C0
   QX/GGVFav5rO5oiv1h3lmEOmSY+vSqiQb9IYmG7eXZZaGRCOT48Au6psr
   N0CS5BONn/vq58L86RUdVKuzJ4c4C2ModabF+pVRfshg3JozjdL+i2PID
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="24458020"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="24458020"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 09:10:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="935617214"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="935617214"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 14 Feb 2024 09:10:49 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id BE3FC2DC; Wed, 14 Feb 2024 19:10:48 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/5] serial: 8250_exar: switch to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Wed, 14 Feb 2024 19:09:36 +0200
Message-ID: <20240214171044.3551032-4-andriy.shevchenko@linux.intel.com>
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

SIMPLE_DEV_PM_OPS() is deprecated, replace it with DEFINE_SIMPLE_DEV_PM_OPS()
and use pm_sleep_ptr() for setting the driver's PM routines. We can now
remove the __maybe_unused qualifier in the suspend and resume functions.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_exar.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 7dfb995ec927..fa750c586b1f 100644
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
@@ -757,7 +758,7 @@ static void exar_pci_remove(struct pci_dev *pcidev)
 		priv->board->exit(pcidev);
 }
 
-static int __maybe_unused exar_suspend(struct device *dev)
+static int exar_suspend(struct device *dev)
 {
 	struct pci_dev *pcidev = to_pci_dev(dev);
 	struct exar8250 *priv = pci_get_drvdata(pcidev);
@@ -774,7 +775,7 @@ static int __maybe_unused exar_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused exar_resume(struct device *dev)
+static int exar_resume(struct device *dev)
 {
 	struct exar8250 *priv = dev_get_drvdata(dev);
 	unsigned int i;
@@ -788,7 +789,7 @@ static int __maybe_unused exar_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(exar_pci_pm, exar_suspend, exar_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(exar_pci_pm, exar_suspend, exar_resume);
 
 static const struct exar8250_board pbn_fastcom335_2 = {
 	.num_ports	= 2,
@@ -938,7 +939,7 @@ static struct pci_driver exar_pci_driver = {
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


