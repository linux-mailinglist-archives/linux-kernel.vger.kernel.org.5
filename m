Return-Path: <linux-kernel+bounces-57541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F3A84DA84
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 285A21F22FDD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 07:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6613369308;
	Thu,  8 Feb 2024 07:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SjCddDfX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F393D692F6;
	Thu,  8 Feb 2024 07:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707375945; cv=none; b=pzIAWHQajeG4wXAb4qtG8PimNbgf287Y8sjMhSIwSM3gzUwu2kbIFVRjzgFgS0D0ITNCR1HPJMI3GbuZsAU7FEEBUmlD/e5JkY9pB0V4qYvaXTjfEQTvUxzkgfup7L5H5RMgxiMbVZdRmdlIcvYqNkzwsP8KvvejPqLHqyhx1EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707375945; c=relaxed/simple;
	bh=UklEqiVSLKZ/zAaY5ylL2DI/IQCa0RUwP7vNXq+RS9Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kr/D+BHNC+knueXjsuFofNqwtesqZ2VOIInnX5A958avMcnoLcwmyvmvF7ogTWYO76zHYiW3lTfwCIxRjJsS8bRka2vdppUz95NaLRYhYZ/0yheR4QZDbJxz3K6vZIlRTvlnMre+ZG/1lmnVb5E5974F2+rJFFoDDwUYmj1N94M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=none smtp.mailfrom=ecsmtp.iind.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SjCddDfX; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ecsmtp.iind.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707375944; x=1738911944;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UklEqiVSLKZ/zAaY5ylL2DI/IQCa0RUwP7vNXq+RS9Q=;
  b=SjCddDfXk6nOAtNuN85vo3n+MoUCbgARG6x0GgtQBigzSlPwT6jDvewz
   UDeiIz2paRKpYGjXDaSzKUbmbO9OCsnabT15P8D3CA58Q9ZMMqQGgyCOO
   8CWFNubX7DHIq/Wj2k1qIebddJrT42f+ZHW0mVwZrbsLVbjashVMOYsdb
   ipfltEGAtre4Zg6Nez3Z7a6612Gh4XejQaLkwygwqDGKVoRdOmh1ndL3n
   GWTjh9jQTkbvPWAuUPriHha8Xm98qwQywZa0zrJlPLwpA3wxnghP4Q3nj
   XZ2SrH4tjMaGVO70r5OCU2HYALqNtJpg6gX9Ac6dGXpWWl6SowJ69CC4t
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="12525864"
X-IronPort-AV: E=Sophos;i="6.05,252,1701158400"; 
   d="scan'208";a="12525864"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 23:05:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,252,1701158400"; 
   d="scan'208";a="1573958"
Received: from inesxmail01.iind.intel.com ([10.223.57.40])
  by fmviesa007.fm.intel.com with ESMTP; 07 Feb 2024 23:05:36 -0800
Received: from inlubt0316.iind.intel.com (inlubt0316.iind.intel.com [10.191.20.213])
	by inesxmail01.iind.intel.com (Postfix) with ESMTP id 5557C1862E;
	Thu,  8 Feb 2024 12:35:35 +0530 (IST)
Received: by inlubt0316.iind.intel.com (Postfix, from userid 12101951)
	id 54E051600100; Thu,  8 Feb 2024 12:35:35 +0530 (IST)
From: Raag Jadav <raag.jadav@intel.com>
To: u.kleine-koenig@pengutronix.de,
	jarkko.nikula@linux.intel.com,
	mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	lakshmi.sowjanya.d@intel.com
Cc: linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v2 4/5] pwm: dwc: access driver_data using dev_get_drvdata()
Date: Thu,  8 Feb 2024 12:35:28 +0530
Message-Id: <20240208070529.28562-5-raag.jadav@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240208070529.28562-1-raag.jadav@intel.com>
References: <20240208070529.28562-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we're setting driver_data using dev_set_drvdata(), we can use
dev_get_drvdata() for accessing it.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/pwm/pwm-dwc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
index e1e3c62ecc56..cc5bba977f47 100644
--- a/drivers/pwm/pwm-dwc.c
+++ b/drivers/pwm/pwm-dwc.c
@@ -82,8 +82,7 @@ static void dwc_pwm_remove(struct pci_dev *pci)
 
 static int dwc_pwm_suspend(struct device *dev)
 {
-	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
-	struct dwc_pwm *dwc = pci_get_drvdata(pdev);
+	struct dwc_pwm *dwc = dev_get_drvdata(dev);
 	int i;
 
 	for (i = 0; i < DWC_TIMERS_TOTAL; i++) {
@@ -102,8 +101,7 @@ static int dwc_pwm_suspend(struct device *dev)
 
 static int dwc_pwm_resume(struct device *dev)
 {
-	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
-	struct dwc_pwm *dwc = pci_get_drvdata(pdev);
+	struct dwc_pwm *dwc = dev_get_drvdata(dev);
 	int i;
 
 	for (i = 0; i < DWC_TIMERS_TOTAL; i++) {
-- 
2.35.3


