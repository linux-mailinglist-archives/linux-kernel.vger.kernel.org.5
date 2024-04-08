Return-Path: <linux-kernel+bounces-136004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0202789CED0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 01:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B264B284088
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 23:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D88C1487C5;
	Mon,  8 Apr 2024 23:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mXCvlBh/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F219B38DD9;
	Mon,  8 Apr 2024 23:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712618261; cv=none; b=kF20FLohT5PIs4odAbTWaML1wIAUsoZaZgKWbNzL9nlJHCfQ8n1vVIOfLP/6L35BoxfYDQb5JMxqgHl0xVPRK1oJoMZ+rEE4ZHRJr2cEcElOEcZwpOc5Kfx0TtxPNPq2ryyoHZEA26foA87p1N1hDfssDqyu7QVxuoxIRMcqYN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712618261; c=relaxed/simple;
	bh=OZrzEFdKvPOSNSciBqI9vzb5cQOAqSfgD21/jOJfMKk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c/9oNcxMyjwVA4TUDEtUUNSBCvuu2I65oeZep1jfcznW0BGgyeqHr4VC3S4Gxuz0jqrXCJ8DuGWjpOm1QBm/QJIJpwo5P3FbdnLituFakB+kQlXH7YRuJ93aazSaU4eY4HYAtNrPjUuh4k3C4re3QxqxSzDEnX5LTkph12KyOgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mXCvlBh/; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712618260; x=1744154260;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OZrzEFdKvPOSNSciBqI9vzb5cQOAqSfgD21/jOJfMKk=;
  b=mXCvlBh/oijWL0CD8eO9l1Z8ucmzYgi06OQJl+qgBkuNjDiRag8Jhro/
   Tg8I8fiZKqAMzLUH6pQmc+ZNGS8XK69ZpbaAn9cHPV3Saa+4nMJBNaZ5q
   93OIkfCd5Eq9Wi8rQP/7q365wGIBLjFqhHnu7BOf6gKciEgDVH5rBALon
   yjUwLs/yaz5+cK0hfT5HAt8FiT15h8KCSqW9eupoz0FwRdYZc7Ii7cO1B
   FfMVn26cumzlgbIFE7KXRwtr38QDhIch39e1GAY0fRzRYmuR0xJ7U6Ldx
   QR2ogDFcsHzS9pSF8l2jHLxWDNKQA9lEdknpExD6LWooPgQdS9hbxQpBN
   Q==;
X-CSE-ConnectionGUID: n6hfu70uTPyX+Zke5SZbDQ==
X-CSE-MsgGUID: YDGSvRaCQTCpIcvTxTi62g==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="7831107"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="7831107"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 16:17:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="937092374"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="937092374"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 08 Apr 2024 16:17:34 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id BDB2312C; Tue,  9 Apr 2024 02:17:33 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Kent Gibson <warthog618@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Kalle Valo <kvalo@kernel.org>,
	Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH v2 0/2] gpiolib: Fix gpio_lookup_flags mess and add Return sections
Date: Tue,  9 Apr 2024 02:12:49 +0300
Message-ID: <20240408231727.396452-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While reviewing another patch I have realised that enum
gpio_lookup_flags messes up with GPIO_* flags definitions.
Hence the first patch fix. Second one is an updated version
of adding Return sections to the kernel-doc.

The series is made in assumption that the patches will land in this
order, but if applied separately, e.g., one to for-current and one to
for-next branches, no conflicts should appear.

In v2:
- new patch 1
- replaces error-code by errno (Randy)
- added tags to patch 2 (Randy)

Andy Shevchenko (2):
  gpiolib: Fix a mess with the GPIO_* flags
  gpiolib: Update the kernel documentation - add Return sections

 drivers/gpio/gpiolib-acpi.c                   |  22 ++-
 drivers/gpio/gpiolib-cdev.c                   |   8 +-
 drivers/gpio/gpiolib-devres.c                 |  44 ++++-
 drivers/gpio/gpiolib-legacy.c                 |   3 +
 drivers/gpio/gpiolib-of.c                     |  53 ++++--
 drivers/gpio/gpiolib-swnode.c                 |   4 +-
 drivers/gpio/gpiolib-sysfs.c                  |   6 +-
 drivers/gpio/gpiolib.c                        | 165 ++++++++++++++----
 .../broadcom/brcm80211/brcmsmac/led.c         |   2 +-
 include/linux/gpio/driver.h                   |   3 +-
 include/linux/gpio/machine.h                  |  20 +--
 11 files changed, 245 insertions(+), 85 deletions(-)

-- 
2.43.0.rc1.1.gbec44491f096


