Return-Path: <linux-kernel+bounces-61591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3E2851400
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D1441F242C9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44DBB3A294;
	Mon, 12 Feb 2024 13:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nrzq+2cL"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D463A262;
	Mon, 12 Feb 2024 13:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707742974; cv=none; b=t8X7m7avORDehlnqRQR4vxcMfHdOD8DtbEqPa9Xe8hAvE8v9BZLTG1ypxUoUOOHomKXrq1DiwDFr1nIgPaQyzUoJs11JPGFShq3rrfb1GL6PS8D3zXzxFJ3Tcn+lnrfCrzVc6xZ4jUu/9nPwrIXPLFDf6/VK9kSH8d6Rt/C/NpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707742974; c=relaxed/simple;
	bh=+iezdmJtQKUYOgzOmH1gPFOjerA7i2PM8BJI/LAdFUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WQLq/DMc/PwkyTwiQpIcwRBd9BYQeIzqbVchp4EG65o6dXahwpirfZZUio7dk5TU6TU1LFiak0J8JBphPTqTKv0b8EAHcdRtcz1lxu+VvOo8HkZf7aE7vCC+F3p8jvPQfU7gWYTixNzw0VziPyYbjH96K85HllZoXvzBzRf+W1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=none smtp.mailfrom=ecsmtp.iind.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nrzq+2cL; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ecsmtp.iind.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707742973; x=1739278973;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+iezdmJtQKUYOgzOmH1gPFOjerA7i2PM8BJI/LAdFUQ=;
  b=Nrzq+2cLkhNJvTmuayjT90GnHTGCKnyjqcwWPQ2yvMOvnaQRqI08cyLG
   LbDWgiEcUbU9wL3cpde5Rzje8T1ODWXUzvyVchp29+3KHy8RAv8IMOzoj
   ngyTMOZwqD6FedUxaojBjq3NjCoWgleF/91yZxUHTOq6wShheEfHIKqSK
   6ZFxzQO0T8XcYKugTaVaYjIHhBr9tN5hB1QOI4CKvFlATgyiBBO9i4jrF
   IEuo2E8swnpe1l/itUFohD8CEMDuySF970p7MmvrpDCCigSMY27OHNJfy
   k/xu0e6Q/gwuk87x5n45hktHi45d+lZAu0X6GJnhs9RdF2Mf0xrFAvYn0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="1594828"
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="1594828"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 05:02:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="33378386"
Received: from inesxmail01.iind.intel.com ([10.223.57.40])
  by orviesa002.jf.intel.com with ESMTP; 12 Feb 2024 05:02:50 -0800
Received: from inlubt0316.iind.intel.com (inlubt0316.iind.intel.com [10.191.20.213])
	by inesxmail01.iind.intel.com (Postfix) with ESMTP id 573FD23A66;
	Mon, 12 Feb 2024 18:32:49 +0530 (IST)
Received: by inlubt0316.iind.intel.com (Postfix, from userid 12101951)
	id 52D061600100; Mon, 12 Feb 2024 18:32:49 +0530 (IST)
From: Raag Jadav <raag.jadav@intel.com>
To: u.kleine-koenig@pengutronix.de,
	jarkko.nikula@linux.intel.com,
	mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	lakshmi.sowjanya.d@intel.com
Cc: linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v3 0/5] DesignWare PWM improvements
Date: Mon, 12 Feb 2024 18:32:42 +0530
Message-Id: <20240212130247.9985-1-raag.jadav@intel.com>
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

Changes since v2:
- Remove error code duplication from dev_err_probe()
- Update tags

Changes since v1:
- Drop redundant error check
- Provide dwc_pwm_init_one() to initialize one PWM instance
- Use dev_get_drvdata() instead of pci_get_drvdata()
- Use pm_sleep_ptr() instead of use pm_ptr()

Raag Jadav (5):
  pwm: dwc: use pm_sleep_ptr() macro
  pwm: dwc: drop redundant error check
  pwm: dwc: Add 16 channel support for Intel Elkhart Lake
  pwm: dwc: simplify error handling
  pwm: dwc: access driver_data using dev_get_drvdata()

 drivers/pwm/pwm-dwc.c | 59 ++++++++++++++++++++++++-------------------
 drivers/pwm/pwm-dwc.h |  5 ++++
 2 files changed, 38 insertions(+), 26 deletions(-)


base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
-- 
2.35.3


