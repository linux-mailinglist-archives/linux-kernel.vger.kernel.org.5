Return-Path: <linux-kernel+bounces-70677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D5F859B0D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 04:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E85411C2146F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 03:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACF979E3;
	Mon, 19 Feb 2024 03:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S3qZ/KjM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F44B522F;
	Mon, 19 Feb 2024 03:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708313938; cv=none; b=ImVx7hB+g8QUBPDbk316xJTxte5PdK9QcPG6fhl2HvxpBv2UctsoUHy/+lFbvyjQdLaFkB7o7EV303gyRzQzLCNylplQEs1NU3OeHSiERQRNbGLdPf2yM5SCBeNurKphSFzBSFOkSDJsLaILGFgEHRuFcvAAR63iWetb71caMjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708313938; c=relaxed/simple;
	bh=IkdZYrQjnIqZ6yKY1yhUCGON0Z800X0TwXOZPrbf4fM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y5cpo+B2MOfJmw8EQsqJjHlAsNnZb2xuu++g5wb33lAR3Hth/BG+v5Dd3SUXINXtYrbftAnfPl0B4cy1l1tGsPxR/8Z0Y4LcOqRdBUMbha3PvmUAEXUwYqyLy9aNa+selDJY9AvwKM1Jkdn9YwwhYPBnkoD1lnQACjUhTIcnT6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=none smtp.mailfrom=ecsmtp.iind.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S3qZ/KjM; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ecsmtp.iind.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708313937; x=1739849937;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IkdZYrQjnIqZ6yKY1yhUCGON0Z800X0TwXOZPrbf4fM=;
  b=S3qZ/KjMjzEQmnjmBRw3GVZYwpyNNQ8PLrdPqZRUFZ4tRJc9yQ8wmVTP
   RVGfugEQv/+E5CK0u5krDzVN1F2M0CrD2M1vlxbzKLUfM0c5fwvugC6Mt
   /mJWZ03fPI/bgWLsJlyUPRZHp+D+OKeM+XFwegUSeDZlDqyaSRi8GDZyy
   1WBI5+0xYkBxpSdUnUnGvbKAoG6JdIyOjhJ5vcq60hBrU1dcShcX0vwNz
   cmkEi60CnmVBuYRKuJFHBayWN3Oqun2EBUCfysdhVoIfmTL4W7orjz67s
   +zyEqPWKWUlIGusRS+XkszDvhW9mEv+3CpfWTlAqvunPve/KEkaG3Ge4w
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="24838176"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="24838176"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 19:38:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="4281845"
Received: from inesxmail01.iind.intel.com ([10.223.57.40])
  by fmviesa007.fm.intel.com with ESMTP; 18 Feb 2024 19:38:47 -0800
Received: from inlubt0316.iind.intel.com (inlubt0316.iind.intel.com [10.191.20.213])
	by inesxmail01.iind.intel.com (Postfix) with ESMTP id C533471912;
	Mon, 19 Feb 2024 09:08:45 +0530 (IST)
Received: by inlubt0316.iind.intel.com (Postfix, from userid 12101951)
	id C16F51600100; Mon, 19 Feb 2024 09:08:45 +0530 (IST)
From: Raag Jadav <raag.jadav@intel.com>
To: u.kleine-koenig@pengutronix.de,
	jarkko.nikula@linux.intel.com,
	mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	lakshmi.sowjanya.d@intel.com
Cc: linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v4 0/4] DesignWare PWM improvements
Date: Mon, 19 Feb 2024 09:08:31 +0530
Message-Id: <20240219033835.11369-1-raag.jadav@intel.com>
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

Changes since v3:
- Fix PM regression
- Add comment for removed error check
- Drop accepted patches
- Update tags

Changes since v2:
- Remove error code duplication from dev_err_probe()
- Update tags

Changes since v1:
- Drop redundant error check
- Provide dwc_pwm_init_one() to initialize one PWM instance
- Use dev_get_drvdata() instead of pci_get_drvdata()
- Use pm_sleep_ptr() instead of use pm_ptr()

Raag Jadav (4):
  pwm: dwc: Fix PM regression
  pwm: dwc: drop redundant error check
  pwm: dwc: Add 16 channel support for Intel Elkhart Lake
  pwm: dwc: simplify error handling

 drivers/pwm/pwm-dwc.c | 58 +++++++++++++++++++++++++++----------------
 drivers/pwm/pwm-dwc.h |  5 ++++
 2 files changed, 41 insertions(+), 22 deletions(-)


base-commit: 191fba33d814a855ac6a29d2c26a46fbe88d55b4
-- 
2.35.3


