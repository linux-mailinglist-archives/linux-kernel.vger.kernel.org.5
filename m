Return-Path: <linux-kernel+bounces-141401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3B28A1DC5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF7EF2891CF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2251754FBB;
	Thu, 11 Apr 2024 17:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CDyejZbC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C430D535D9;
	Thu, 11 Apr 2024 17:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712856405; cv=none; b=AQRza/lm69jZWxgKExSoo6iuqAPv7rffxRomty9ZDNjzybj+n+/jM9FM1v5Hytdgj1nhlxovfHSGCjNoLEqLxUgUgX5SLKPQ89PlOaKsRnKMyxaUzwGRYLAVknlWKMhEVW/fuIcB1Umx2g7jdg7EVSiyHFrnmI78aNL5TEIGdeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712856405; c=relaxed/simple;
	bh=rb4Rwfv5xHnQdtI+SSu0ajaicwDU38E72wab/KYC78w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KR2qB5EJF5GQZ+PFzKn+U8I6yLQAbgIWyGCTAMVQA/Q7YUqqz8dIf8po0EFUhhGe+/Y7gHBGvGlu89JwJqgRTuwZs2ZxPnJGzqjbd6k1s3GsdS65pTGmz1LoGJIcy2q34jYxsIZF7/AtNb8GrrE2dBOMkvpYYLJhU8tjXJPL3Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CDyejZbC; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712856404; x=1744392404;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rb4Rwfv5xHnQdtI+SSu0ajaicwDU38E72wab/KYC78w=;
  b=CDyejZbCvLFiFmOLVt9/RkTrbxuYqiJP72FFAZ2zOGCogQv076JnnPNg
   1L9Z7KrjtLv5i1zGmm1EsRLwOzE3lZ29yPClI1qMqzRMSH7YhO4TPeIDh
   I3SKhTQuk2J6lRg48rOmUyH7GN+MMOLxDV1ZIKgTeAVzB1waXqvo31Hgi
   Sqy5zuwXsH+7jxNK0mIN0ODQu9eqX9ZLOFu1MzDqSRKv7vryuLxJNdU3P
   5/8++PXiXtkWWKrMCG3RSs3/FCPA3Tuxh14G3pxBuo27sgZQDGDNH9FiG
   /z/peF8fiVH904gBUXKS2cx7qyFfUQBilHKdA9Te6prFbNncHAWPqNuge
   A==;
X-CSE-ConnectionGUID: mQTJ7LqGRnCJl1C1YPR7xg==
X-CSE-MsgGUID: 3AhjIcm2SzKPeD+XY0VtGA==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="18845025"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="18845025"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 10:26:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="937097278"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="937097278"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 11 Apr 2024 10:26:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id E99FC194; Thu, 11 Apr 2024 20:26:33 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	David Thompson <davthompson@nvidia.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Patrick Rudolph <patrick.rudolph@9elements.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: [PATCH v1 0/4] gpiolib: acpi: Use con_id in acpi_dev_gpio_irq_get_by()
Date: Thu, 11 Apr 2024 20:22:28 +0300
Message-ID: <20240411172540.4122581-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use con_id instead of property in the acpi_dev_gpio_irq_get_by().
It will be aligned with other GPIO library functions.

Assumed to go via my GPIO ACPI library tree follwoed by GPIO subsystem.

Andy Shevchenko (4):
  gpiolib: acpi: Extract __acpi_find_gpio() helper
  gpiolib: acpi: Simplify error handling in __acpi_find_gpio()
  gpiolib: acpi: Move acpi_can_fallback_to_crs() out of
    __acpi_find_gpio()
  gpiolib: acpi: Pass con_id instead of property into
    acpi_dev_gpio_irq_get_by()

 drivers/gpio/gpio-pca953x.c                   |  2 +-
 drivers/gpio/gpiolib-acpi.c                   | 52 +++++++++++--------
 .../mellanox/mlxbf_gige/mlxbf_gige_main.c     |  2 +-
 drivers/pinctrl/pinctrl-cy8c95x0.c            |  2 +-
 include/linux/acpi.h                          |  8 +--
 5 files changed, 37 insertions(+), 29 deletions(-)

-- 
2.43.0.rc1.1336.g36b5255a03ac


