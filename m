Return-Path: <linux-kernel+bounces-61115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E7C850D79
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 07:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11365B22D18
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 06:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9468830;
	Mon, 12 Feb 2024 06:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fw1F03iR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F6B6FD5;
	Mon, 12 Feb 2024 06:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707718258; cv=none; b=hzv9Mozidj/BP5F7epX9+lWZmhQyLVHUPxw3QFZzW/KS8Y3SfiG0yZRvpcDiecDTJzZMzyuS1zT5VyN5cQ5M7fkGveMr+19f1W7imGdhqTOwfOeJcR+tV+wSLVrCdwP8/Wgtj8OuU6FGwNx7hoRRjY2svOjyvdjt98ZwCCNRiHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707718258; c=relaxed/simple;
	bh=newBKw0c8jig6ktCcY0jjtH6UsmB7dIdqXuaHfTPnS0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rNro4diyjwIV2M5Zbcxb5AHImO9vRt96G3Udhe20l2llodAU3lJGUh/J8z8ic/mRlm+43m3Ddujhe88WRSz/7j6e0oXfZLFuIAX1OmcFEyL2ipcYueO/yyIwwif7AYG5iVALvg1vfxsBq+y7xIAGeaRPStwWemUsW/d2mUuDXwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=none smtp.mailfrom=ecsmtp.iind.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fw1F03iR; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ecsmtp.iind.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707718257; x=1739254257;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=newBKw0c8jig6ktCcY0jjtH6UsmB7dIdqXuaHfTPnS0=;
  b=fw1F03iRxs3nkjBIVBP/yeZ7bJzpXInJ9xTHDdLYrJpKw90LP8D6hk76
   srbPKQ2qEBkx9Er1H9yDy8JPiVrAvEj52UBeM1ODutaUWWP0JaeDQMGf3
   eKzzlxTyTUZtSv9s9bIN17z7nCpooyBQ16WmCP6Fxr9wQfyReGdK3L1X/
   5K/h/LGln7JXf5ITbA0ZkaxbBS8GnHWO9aDKGcguZer1ziC/OEhO3OaWW
   +T8szVknqfFl1sMxe2S7BYu4RoclR9KZzbONQNkFb0z4iUE86pPnUA66J
   jpuuU+uaBop4R1O6Y3qJJStVlG/4QCntI+K3YJDs3AMrx35UtA3WA1Aln
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="1833039"
X-IronPort-AV: E=Sophos;i="6.05,262,1701158400"; 
   d="scan'208";a="1833039"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2024 22:10:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,262,1701158400"; 
   d="scan'208";a="33574485"
Received: from inesxmail01.iind.intel.com ([10.223.57.40])
  by fmviesa001.fm.intel.com with ESMTP; 11 Feb 2024 22:10:40 -0800
Received: from inlubt0316.iind.intel.com (inlubt0316.iind.intel.com [10.191.20.213])
	by inesxmail01.iind.intel.com (Postfix) with ESMTP id 557C21CAE8;
	Mon, 12 Feb 2024 11:40:39 +0530 (IST)
Received: by inlubt0316.iind.intel.com (Postfix, from userid 12101951)
	id 512F41600100; Mon, 12 Feb 2024 11:40:39 +0530 (IST)
From: Raag Jadav <raag.jadav@intel.com>
To: u.kleine-koenig@pengutronix.de,
	jarkko.nikula@linux.intel.com,
	mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com
Cc: linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1 0/2] LPSS PWM cleanups
Date: Mon, 12 Feb 2024 11:40:35 +0530
Message-Id: <20240212061037.4271-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series implements minor cleanups for LPSS PWM driver.

Raag Jadav (2):
  pwm: lpss: use devm_pm_runtime_enable() helper
  pwm: lpss: drop redundant runtime PM handles

 drivers/pwm/pwm-lpss-pci.c      | 22 ----------------------
 drivers/pwm/pwm-lpss-platform.c | 10 +---------
 2 files changed, 1 insertion(+), 31 deletions(-)

-- 
2.35.3


