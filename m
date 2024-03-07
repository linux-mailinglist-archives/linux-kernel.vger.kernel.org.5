Return-Path: <linux-kernel+bounces-95867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6225987544A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93B1A1C23684
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EEC130AC9;
	Thu,  7 Mar 2024 16:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OZ9RHlb+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6DB12FB33;
	Thu,  7 Mar 2024 16:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709829464; cv=none; b=qR6Cnou9jkVK4NgT+dZAvASROqODosH5DTlZjfanMC1GskEZ879gVTaIhbJVGDXg/2jdNsHCqPixr/QGeoCaZgxWtyY2vOQh/Kfgy6+ScAfb9YpU56F0qtdWUVWtGH32o5iFSyYaVnL/ax2bWss1vnHeA1piiIj3TafwQge9FzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709829464; c=relaxed/simple;
	bh=mDh+JZ3LDF/K67NUz+jUaNK4jTIkQl0icjPjmPpIjY0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pfreP/dvAeiDD1/w0eI7cuo60CexM6obhfva2L1RreIwBUdDzUFiIT/mrnz/JfVY9yhNVNMPotMlMAypbmKWWQp+Ads1jC4oJ/zF8IRDdpS4CtTIMZwqB8x88A/le35BGJ4Xa29d7PsVniyoNPOMNky8nJ9f9ak791XHwLpfcWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OZ9RHlb+; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709829462; x=1741365462;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mDh+JZ3LDF/K67NUz+jUaNK4jTIkQl0icjPjmPpIjY0=;
  b=OZ9RHlb+Q4fY1m/g4FO/BeE+iflG+RJuyR6cXTSwmHsgryXhmRhIJWb1
   TiZmoyjzMWURivNrDA+J5AdYhzydYVUletcJr+59G7ctF8ptqmEDWN7Kr
   dVbhFL6IBE6E0LNQ3kXMQaovXRm/TA7HAQXUya08mPVAjFHBD6lG+s4Qa
   iV0n6tr5+zonyEtqgBhj3ZjnybhYjJMs/6RuYun5Uuc6t2DIvSZcNRJvL
   1x+n6ZBtT3IeFbog1ccj7Aqbx8KUVfgGmxRcKx9wgvrMJeFXxH8faP1ii
   yjvgGu0wFI6lq1CxZ+zoSIyimpiFYoXI6dkaieVKbiY/nG1t2plK+fRkD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="15940823"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="15940823"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 08:37:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="937046389"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="937046389"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Mar 2024 08:37:37 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id B77293C0; Thu,  7 Mar 2024 18:37:36 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Liam Girdwood <liam.r.girdwood@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v1 1/1] ASoC: Intel: catpt: Carefully use PCI bitwise constants
Date: Thu,  7 Mar 2024 18:37:34 +0200
Message-ID: <20240307163734.3852754-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PM constants for PCI devices are defined with bitwise annotation.
When used as is, sparse complains about that:

  .../catpt/dsp.c:390:9: warning: restricted pci_power_t degrades to integer
  .../catpt/dsp.c:414:9: warning: restricted pci_power_t degrades to integer

Force them to be u32 in the driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/soc/intel/catpt/dsp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/catpt/dsp.c b/sound/soc/intel/catpt/dsp.c
index 346bec000306..5454c6d9ab5b 100644
--- a/sound/soc/intel/catpt/dsp.c
+++ b/sound/soc/intel/catpt/dsp.c
@@ -387,7 +387,7 @@ int catpt_dsp_power_down(struct catpt_dev *cdev)
 	mask = cdev->spec->d3srampgd_bit | cdev->spec->d3pgd_bit;
 	catpt_updatel_pci(cdev, VDRTCTL0, mask, cdev->spec->d3pgd_bit);
 
-	catpt_updatel_pci(cdev, PMCS, PCI_PM_CTRL_STATE_MASK, PCI_D3hot);
+	catpt_updatel_pci(cdev, PMCS, PCI_PM_CTRL_STATE_MASK, (__force u32)PCI_D3hot);
 	/* give hw time to drop off */
 	udelay(50);
 
@@ -411,7 +411,7 @@ int catpt_dsp_power_up(struct catpt_dev *cdev)
 	val = mask & (~CATPT_VDRTCTL2_DTCGE);
 	catpt_updatel_pci(cdev, VDRTCTL2, mask, val);
 
-	catpt_updatel_pci(cdev, PMCS, PCI_PM_CTRL_STATE_MASK, PCI_D0);
+	catpt_updatel_pci(cdev, PMCS, PCI_PM_CTRL_STATE_MASK, (__force u32)PCI_D0);
 
 	/* SRAM power gating none */
 	mask = cdev->spec->d3srampgd_bit | cdev->spec->d3pgd_bit;
-- 
2.43.0.rc1.1.gbec44491f096


