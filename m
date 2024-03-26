Return-Path: <linux-kernel+bounces-119658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFBE88CBAB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E85F81F84008
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6AD126F1E;
	Tue, 26 Mar 2024 18:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VocGc7kT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D795580C1F;
	Tue, 26 Mar 2024 18:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711476642; cv=none; b=hT5+cmfYiW1sbNp/qDGfPwf97+S7qLT9AcHcmtPVtZodBta2NmdSex9azOx1q8TRMn3ZRN2CkBbPwndt5qijOfpeggBxWhbR7XK6mkuL9ZbZ84dG+yqYQOTC9DU6AceDgKnkxTmfqINoR2NkG/IIfuYUkJGjfu8MC8XOb1PUfNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711476642; c=relaxed/simple;
	bh=bYPfMHs5lY0w8l6frpxhtmlny9EfNHrvPYL21MRIbXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AMMKrO8Ed+m8RIAwigQiVRXtV7uovJAt4np52KTiqh0w4UN5ykMsPrkIimXoZCk0vf9XuNBCefoAueJzREfNeRki5HVR+6qO7hBmK9JFCb+4FevZDHzsE1EqcKA16IUVYwM4cYXKDxolM1RSk98ca83cTtbey6NrA8x1aXHOcZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VocGc7kT; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711476641; x=1743012641;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bYPfMHs5lY0w8l6frpxhtmlny9EfNHrvPYL21MRIbXo=;
  b=VocGc7kTTj/iKYa5CYu6t/Nnu4/boVlz5cYmUd2NGUuGgCdaMcHrI1UN
   Lp1hvlydpoc4YxesGZIqLgkeVSItIw/hx8KPr0hxL2UvmDQq3dy4yUH+4
   eJCmaiwhnPhnK+TFWhmP/RsQWR0A7Ee4dDJEPa/BQHk7hytGTm3gzq3ve
   vs+fLsNsWSJUDo2hTqffs8oz84800JX02DQSTcImHiZ/aBjvKcV+VkynI
   VgzgpRL0x5H9c2VGzZhU9Jw94JK40Sbkds+A8RbrVg/iSSOQGx0jtTlLZ
   RLgz8/1qE48F+bs7W40CiC+KqRVmznEPxVs1uouX8bxxtnJnp7cufyo3Y
   A==;
X-CSE-ConnectionGUID: dTOrASGyQYyOh4Uxrf+dKA==
X-CSE-MsgGUID: wxzcGi2TTLynS2Y2NgLofQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="10325668"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="10325668"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 11:10:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="937072937"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="937072937"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 26 Mar 2024 11:10:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id D096F161; Tue, 26 Mar 2024 20:10:34 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH v1 01/10] spi: pxa2xx: Drop ACPI_PTR() and of_match_ptr()
Date: Tue, 26 Mar 2024 20:07:51 +0200
Message-ID: <20240326181027.1418989-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240326181027.1418989-1-andriy.shevchenko@linux.intel.com>
References: <20240326181027.1418989-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop rather useless use of ACPI_PTR() and of_match_ptr().
It also removes the necessity to be dependent on ACPI and
of.h inclusion.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/Kconfig      | 2 +-
 drivers/spi/spi-pxa2xx.c | 9 +++------
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index bc7021da2fe9..7cf86b034083 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -817,7 +817,7 @@ config SPI_PPC4xx
 
 config SPI_PXA2XX
 	tristate "PXA2xx SSP SPI master"
-	depends on ARCH_PXA || ARCH_MMP || PCI || ACPI || COMPILE_TEST
+	depends on ARCH_PXA || ARCH_MMP || PCI || COMPILE_TEST
 	select PXA_SSP if ARCH_PXA || ARCH_MMP
 	help
 	  This enables using a PXA2xx or Sodaville SSP port as a SPI master
diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 6c2a14418972..2c39d3ff498e 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -19,7 +19,6 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
-#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
@@ -1730,7 +1729,6 @@ static const struct dev_pm_ops pxa2xx_spi_pm_ops = {
 	RUNTIME_PM_OPS(pxa2xx_spi_runtime_suspend, pxa2xx_spi_runtime_resume, NULL)
 };
 
-#ifdef CONFIG_ACPI
 static const struct acpi_device_id pxa2xx_spi_acpi_match[] = {
 	{ "80860F0E", LPSS_BYT_SSP },
 	{ "8086228E", LPSS_BSW_SSP },
@@ -1741,9 +1739,8 @@ static const struct acpi_device_id pxa2xx_spi_acpi_match[] = {
 	{}
 };
 MODULE_DEVICE_TABLE(acpi, pxa2xx_spi_acpi_match);
-#endif
 
-static const struct of_device_id pxa2xx_spi_of_match[] __maybe_unused = {
+static const struct of_device_id pxa2xx_spi_of_match[] = {
 	{ .compatible = "marvell,mmp2-ssp", .data = (void *)MMP2_SSP },
 	{}
 };
@@ -1753,8 +1750,8 @@ static struct platform_driver driver = {
 	.driver = {
 		.name	= "pxa2xx-spi",
 		.pm	= pm_ptr(&pxa2xx_spi_pm_ops),
-		.acpi_match_table = ACPI_PTR(pxa2xx_spi_acpi_match),
-		.of_match_table = of_match_ptr(pxa2xx_spi_of_match),
+		.acpi_match_table = pxa2xx_spi_acpi_match,
+		.of_match_table = pxa2xx_spi_of_match,
 	},
 	.probe = pxa2xx_spi_probe,
 	.remove_new = pxa2xx_spi_remove,
-- 
2.43.0.rc1.1.gbec44491f096


