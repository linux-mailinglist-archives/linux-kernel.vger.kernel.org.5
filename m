Return-Path: <linux-kernel+bounces-148367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A46F8A818F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1999B1F22A08
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF3313CAAE;
	Wed, 17 Apr 2024 11:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jvkAJeqs"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A3913C818;
	Wed, 17 Apr 2024 11:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713351827; cv=none; b=EvDFf32k5sRdV8DnVZAhv6qkYEEH9nkXwxZ3UCpyiumNeKKARFsX64fesM1YgzkT7aLiYbSfAISuQZEv8rC9RX6+/YvDVLquAVJyPXJdNTwyX+6BS12VEr7sQxWPI8NfVB7pgh7xiiOYO432/evNG5HdTkgeznJpy9moxrrCoaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713351827; c=relaxed/simple;
	bh=Un/v+3ceg/m/J3d1mkGogWHxRRHXdsqzlAA5EocCvbI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=egHnFDagNeO2HEcyK+4TSgPHUREp/0ExGVpvXwjpf9tMkhtRbS+g5EDg2sNa5oo+NmsBo5VyHKsfK7+oaPUC5dw7DBG9Xj4DNGL2WO/FxSy8dQX5QGapmnIhCmETQml3hOwdiKEaeDMCK355PtCMmrn89yDRH4pCc9vJw6TWxdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jvkAJeqs; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713351827; x=1744887827;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Un/v+3ceg/m/J3d1mkGogWHxRRHXdsqzlAA5EocCvbI=;
  b=jvkAJeqsC4CrIcqQt7QVSgOBEQObMz8Q+Y4cBig8dosMXsnFUUblgYnp
   kq3m5AOfWHf4XPc4UlQtzhAq4U24THuFZ2Kv17Hz/GhNixJOULl8Zbvnl
   EdvNRmOn6MgdEGTNFA69eNCKlffXqbeKGe52R9AuZx+TgwPO/WWw0rsjF
   RhgIpyLx4u3+ZfOJm33riReBoLDJ5NoVVH9Y2KsaUMRPWr1g9GMkQTcIe
   JvBgpZPQRCghsvInceW4YfeU15Zpam5NxOcj0zk44EPJzrklY3cp9aF3c
   hfQkuHbFUXPOah2IrKffdTWcNaCj3Be77pN0S8iM3vMR+/6JUKs5ini05
   Q==;
X-CSE-ConnectionGUID: L53KU+OpTvek7FMy1i7qsA==
X-CSE-MsgGUID: 9Xoy4kRDQRGWScKOdLAnyg==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="8698131"
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="8698131"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 04:03:40 -0700
X-CSE-ConnectionGUID: br7yEYewTtyT0LTP/jlsCg==
X-CSE-MsgGUID: mz2pYH88SXqfV3KHc5Crag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="22653273"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 17 Apr 2024 04:03:37 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 4771C491; Wed, 17 Apr 2024 14:03:36 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 0/9] spi: pxa2xx: Drop linux/spi/pxa2xx_spi.h
Date: Wed, 17 Apr 2024 13:54:27 +0300
Message-ID: <20240417110334.2671228-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As Arnd suggested we may drop linux/spi/pxa2xx_spi.h as most of
its content is being used solely internally to SPI subsystem
(PXA2xx drivers). Hence this refactoring series with the additional
win of getting rid of legacy documentation.

Note, that we have the only user of a single plain integer field
in the entire kernel for that. Switching to software nodes does not
diminish any of type checking as we only pass an integer.

On top of that it includes the previously sent "spi: pxa2xx: Cleanup
(part 2)" series that makes effort to clean up even more things.

Changelog v3:
- added new patches that were previously sent separately
  (20240403171550.1074644-1-andriy.shevchenko@linux.intel.com)
- extended cover letter a bit to explain that the replacement is
  not worse than the current approach
- v2: 20240327193138.2385910-1-andriy.shevchenko@linux.intel.com

Changelog v2:
- dropped applied patches
- added patch to amend dependencies (Mark)
- amended the second patch accordingly (Mark)
- elaborated purpose of the patch 6 in the commit message (Mark)
- v1: 20240326181027.1418989-1-andriy.shevchenko@linux.intel.com

Cc: Arnd Bergmann <arnd@arndb.de>

Andy Shevchenko (9):
  spi: pxa2xx: Allow number of chip select pins to be read from property
  spi: pxa2xx: Provide num-cs for Sharp PDAs via device properties
  spi: pxa2xx: Move contents of linux/spi/pxa2xx_spi.h to a local one
  spi: pxa2xx: Remove outdated documentation
  spi: pxa2xx: Don't use "proxy" headers
  spi: pxa2xx: Drop struct pxa2xx_spi_chip
  spi: pxa2xx: Remove DMA parameters from struct chip_data
  spi: pxa2xx: Remove timeout field from struct chip_data
  spi: pxa2xx: Don't provide struct chip_data for others

 Documentation/spi/pxa2xx.rst   | 208 ---------------------------------
 arch/arm/mach-pxa/spitz.c      |  25 ++--
 drivers/spi/Kconfig            |   3 +-
 drivers/spi/spi-pxa2xx-dma.c   |  38 ++----
 drivers/spi/spi-pxa2xx-pci.c   |  10 +-
 drivers/spi/spi-pxa2xx.c       |  94 +++++----------
 drivers/spi/spi-pxa2xx.h       |  42 +++----
 include/linux/spi/pxa2xx_spi.h |  48 --------
 8 files changed, 87 insertions(+), 381 deletions(-)
 delete mode 100644 Documentation/spi/pxa2xx.rst
 delete mode 100644 include/linux/spi/pxa2xx_spi.h

-- 
2.43.0.rc1.1336.g36b5255a03ac


