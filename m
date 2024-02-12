Return-Path: <linux-kernel+bounces-61113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CF7850D75
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 07:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79C471C221A1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 06:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0930C7462;
	Mon, 12 Feb 2024 06:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kxuo9xJw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9B96FAD;
	Mon, 12 Feb 2024 06:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707718256; cv=none; b=nRYMMM39jRnRuk9P/wy1LwNToBA6Fn/DHbOuLIgAEmye7VegRpE1UEVK1ffFW1DgFBE9RWYtIVRVGMmuTcTaYYYPIeGaotiYzd6doPT8iLrJfIpmCJzyaGKw7kkUOVc2zhd5amsb22c08cOw97GZgP7mjR0NkDqweoZNc1oqofc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707718256; c=relaxed/simple;
	bh=kFsYgesT2OuI7NyKvUcKDZ7z+d8fMM9cVlbYxuZzWg4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aGLmtC3wi0zU/DP3M7GwYD0ou2uCmNRLLaR0+CGA1y1wpVTLQILnVU7CmCBxB7TEAcI2Yqn616jGuYJad/FJ/Caqx/Eha6tqq6xPCKmsQw0xrW8fLVwy6++6rSJQ/ezQ1ktwGqhD27wmiS1eMk77RzYuwZhmN1j9YlOj6W1T0WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=none smtp.mailfrom=ecsmtp.iind.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kxuo9xJw; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ecsmtp.iind.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707718255; x=1739254255;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kFsYgesT2OuI7NyKvUcKDZ7z+d8fMM9cVlbYxuZzWg4=;
  b=kxuo9xJwWhuvS8JlH54MXkU8WFN6+oxjsnBcWob/otlfieUxEXlQDF1d
   8ZTUKuBH1PlPMX3zT7BlOBV1xan04LTd88bmyz5d23s0Vc5tOupZQIbK2
   94DVpxgbQrFkob6tPml0FfT/o+6FvliFfZE7cBYr6E6ZotEJAoKVW4G7x
   KVAVFbyzt6yW311wOXhLyD1ZbyThY8D1scZBuvFrwrSS2vxyxyfwA0WBV
   s5xjQ7ToWfZGqtWBiSW1qhNiueIoNrD15U/qkgLYKnG0UYn6gnZoxyr/d
   +ShGdPLkj+NzG4MZKExAnreC3MS5AjrpzHYq1ihlS7DSoWSahi6vdtKwt
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="1833044"
X-IronPort-AV: E=Sophos;i="6.05,262,1701158400"; 
   d="scan'208";a="1833044"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2024 22:10:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,262,1701158400"; 
   d="scan'208";a="33574489"
Received: from inesxmail01.iind.intel.com ([10.223.57.40])
  by fmviesa001.fm.intel.com with ESMTP; 11 Feb 2024 22:10:40 -0800
Received: from inlubt0316.iind.intel.com (inlubt0316.iind.intel.com [10.191.20.213])
	by inesxmail01.iind.intel.com (Postfix) with ESMTP id 581291CAEA;
	Mon, 12 Feb 2024 11:40:39 +0530 (IST)
Received: by inlubt0316.iind.intel.com (Postfix, from userid 12101951)
	id 55F891600102; Mon, 12 Feb 2024 11:40:39 +0530 (IST)
From: Raag Jadav <raag.jadav@intel.com>
To: u.kleine-koenig@pengutronix.de,
	jarkko.nikula@linux.intel.com,
	mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com
Cc: linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1 2/2] pwm: lpss: drop redundant runtime PM handles
Date: Mon, 12 Feb 2024 11:40:37 +0530
Message-Id: <20240212061037.4271-3-raag.jadav@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240212061037.4271-1-raag.jadav@intel.com>
References: <20240212061037.4271-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We no longer need empty runtime PM handles for PCI devices after commit
c5eb1190074c ("PCI / PM: Allow runtime PM without callback functions").
Drop them and let PCI core take care of power state transitions.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pwm/pwm-lpss-pci.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/drivers/pwm/pwm-lpss-pci.c b/drivers/pwm/pwm-lpss-pci.c
index b4134bee2863..51efe37e23fe 100644
--- a/drivers/pwm/pwm-lpss-pci.c
+++ b/drivers/pwm/pwm-lpss-pci.c
@@ -48,25 +48,6 @@ static void pwm_lpss_remove_pci(struct pci_dev *pdev)
 	pm_runtime_get_sync(&pdev->dev);
 }
 
-static int pwm_lpss_runtime_suspend_pci(struct device *dev)
-{
-	/*
-	 * The PCI core will handle transition to D3 automatically. We only
-	 * need to provide runtime PM hooks for that to happen.
-	 */
-	return 0;
-}
-
-static int pwm_lpss_runtime_resume_pci(struct device *dev)
-{
-	return 0;
-}
-
-static DEFINE_RUNTIME_DEV_PM_OPS(pwm_lpss_pci_pm,
-				 pwm_lpss_runtime_suspend_pci,
-				 pwm_lpss_runtime_resume_pci,
-				 NULL);
-
 static const struct pci_device_id pwm_lpss_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x0ac8), (unsigned long)&pwm_lpss_bxt_info},
 	{ PCI_VDEVICE(INTEL, 0x0f08), (unsigned long)&pwm_lpss_byt_info},
@@ -86,9 +67,6 @@ static struct pci_driver pwm_lpss_driver_pci = {
 	.id_table = pwm_lpss_pci_ids,
 	.probe = pwm_lpss_probe_pci,
 	.remove = pwm_lpss_remove_pci,
-	.driver = {
-		.pm = pm_ptr(&pwm_lpss_pci_pm),
-	},
 };
 module_pci_driver(pwm_lpss_driver_pci);
 
-- 
2.35.3


