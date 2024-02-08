Return-Path: <linux-kernel+bounces-57542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DED3284DA86
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D1FF1C231BF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 07:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B8E69970;
	Thu,  8 Feb 2024 07:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kL6i0wT+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C5D692FB;
	Thu,  8 Feb 2024 07:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707375947; cv=none; b=iN6TttZkO3J9YWUFwQVIeI9BluWuP8o01kUtSGWSOwsxE0Ffi0mH5iG0PhYXAaCUU1dpb4Iduxj5jRR1kqrARAy/4GvmfYm6l89/26EXrgst4RwzRuTFcRRL51Pw1g7zkcsqD2DZ5LqDLEh33mAfXnVK9+VRkTwpvA1CEbH/E2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707375947; c=relaxed/simple;
	bh=7gbKKozufPEJOHyDzxPI7qDX53DOyCIXuU0VEm1kGZ4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VGBdW+Lh4FyCxpgl4Uj1nCPyD9D9u51wgX3sLELcyz1/FCyAMM5Xk8KeuRkOwlNc9UjsoWPPRHA8eHQJFB5ahXeIUt/WjNIdFHGnVQYaALR4eCzsr/dJx4TKp10nC4BX/vLmPu50NuU2MZ3wXWW70nJSiiOvllzVGr5aOzMkl5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=none smtp.mailfrom=ecsmtp.iind.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kL6i0wT+; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ecsmtp.iind.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707375946; x=1738911946;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7gbKKozufPEJOHyDzxPI7qDX53DOyCIXuU0VEm1kGZ4=;
  b=kL6i0wT+WJjP4CI6dTp7Y269z6FEo0wHueEjYYHLt1OBJRaeP5NXWhXO
   UpjkwTHf+yNpSkhAYJxIR3j2cUGfeDKSpxipCJbIzl1XVOsD29cr65LEd
   UmxuQcJQmWKgua7xs8cINJFB2B8SHQon+ibhiTm79gtA/R+RD8tHxEo3V
   MuLn7bdMuRa3DBk+ctNCWEq+vOxJTzywTJciVRoKWtURKqP9mREiWSYsp
   YWvY3UQwrCRolhc3NfdO3FubDVhbXsxcGZRJRUNo8pHFAKM+Hagy2727l
   S3oV97Vj6ICqfPG2URGbsQGfsXurPDWxkMxgEOLpZOVgDKZOAR2Ry+8I1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="12525867"
X-IronPort-AV: E=Sophos;i="6.05,252,1701158400"; 
   d="scan'208";a="12525867"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 23:05:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,252,1701158400"; 
   d="scan'208";a="1573961"
Received: from inesxmail01.iind.intel.com ([10.223.57.40])
  by fmviesa007.fm.intel.com with ESMTP; 07 Feb 2024 23:05:36 -0800
Received: from inlubt0316.iind.intel.com (inlubt0316.iind.intel.com [10.191.20.213])
	by inesxmail01.iind.intel.com (Postfix) with ESMTP id 4E8EB15B52;
	Thu,  8 Feb 2024 12:35:35 +0530 (IST)
Received: by inlubt0316.iind.intel.com (Postfix, from userid 12101951)
	id 4A9D11600100; Thu,  8 Feb 2024 12:35:35 +0530 (IST)
From: Raag Jadav <raag.jadav@intel.com>
To: u.kleine-koenig@pengutronix.de,
	jarkko.nikula@linux.intel.com,
	mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	lakshmi.sowjanya.d@intel.com
Cc: linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v2 0/5] DesignWare PWM improvements
Date: Thu,  8 Feb 2024 12:35:24 +0530
Message-Id: <20240208070529.28562-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series implements 16 channel PWM support for Intel Elkhart Lake
along with minor cleanups for DesignWare PWM driver.

Changes since v1:
- Drop redundant error check
- Provide dwc_pwm_init_one() to initialize one PWM instance
- Use dev_get_drvdata() instead of pci_get_drvdata()
- Use pm_sleep_ptr() instead of use pm_ptr()

Raag Jadav (5):
  pwm: dwc: drop redundant error check
  pwm: dwc: Add 16 channel support for Intel Elkhart Lake
  pwm: dwc: simplify error handling
  pwm: dwc: access driver_data using dev_get_drvdata()
  pwm: dwc: use pm_sleep_ptr() macro

 drivers/pwm/pwm-dwc.c | 59 ++++++++++++++++++++++++-------------------
 drivers/pwm/pwm-dwc.h |  5 ++++
 2 files changed, 38 insertions(+), 26 deletions(-)


base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
-- 
2.35.3


