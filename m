Return-Path: <linux-kernel+bounces-119660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C036D88CBAF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F19C71C3A742
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4AFE1292C7;
	Tue, 26 Mar 2024 18:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H8GMemLf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834128662A;
	Tue, 26 Mar 2024 18:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711476644; cv=none; b=UN4dXKTb82wJ4v58OP/IHZNL/6oCF8tXM78d7gao7+Tzpa7dIQfxLWqDi032D+orqXwi4s1MZ+WUXzm5u85qyZb8lkrQJsaUlk6LY3pDpScr1g8c2xJeSdIh7JdoIoZNGAlf+HW6XzG/PGbsv0/0WiG8oRcIJIKM57iCr7BBAV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711476644; c=relaxed/simple;
	bh=kZ6a9T0dNBuKKdOYe4rTeQVlWUgy3Put+CwhdI3cS/s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I8rKU2D4ASxs46kon9G+aKgVM96fkcc67ltdh5j7kp5hEZsBXicfK54WG96UG2TkDSPAAP1DRVYRSyDpwNFxGOyB7bSEWrYv11soQ41LTLf3zv4+mQ8CbnM08AgQju56bLo7j/EhpNN+tkYrrL5Jhu2+6nnKawAnTjw7hkk8LFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H8GMemLf; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711476642; x=1743012642;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kZ6a9T0dNBuKKdOYe4rTeQVlWUgy3Put+CwhdI3cS/s=;
  b=H8GMemLfsSehpKxn4WgtMa6k6tic4TM9Ps7sVSgR27WK86GPhGQoTXie
   afid1ENe1lb3lxiEIACv/pK9LmofrSSroYaix+vOlboLok/AtzSFesThw
   VUXFt5lfK8KrC+lqwoRd3fJieJOePJHlvlKjEHCJhW+/qjyghjkDJPfh0
   dKPr8wzwAcDR1wS+D4As8WJT7vHvaIbGEG8BGnfsC5pL5zw0XRn4XWzhM
   /SSv2nUcMEItoXf+8eAlw+8HBOF8z8fUM99qzRmvOzliRMrHi1BUZeOA4
   +A1bvqZYhLV3hP0/Mvh8kUaiqwB/jQM75Nu6vbn69P/KMXjTSYFc1Xso3
   w==;
X-CSE-ConnectionGUID: OgSP28rdS4apnX7gyzBcqg==
X-CSE-MsgGUID: ejC9wCQyRWGLM2eRGVfeMA==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="10325683"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="10325683"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 11:10:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="937072935"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="937072935"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 26 Mar 2024 11:10:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id C251A284; Tue, 26 Mar 2024 20:10:34 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v1 00/10] spi: pxa2xx: Drop linux/spi/pxa2xx_spi.h
Date: Tue, 26 Mar 2024 20:07:50 +0200
Message-ID: <20240326181027.1418989-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
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

Cc: Arnd Bergmann <arnd@arndb.de>

Andy Shevchenko (10):
  spi: pxa2xx: Drop ACPI_PTR() and of_match_ptr()
  spi: pxa2xx: Keep PXA*_SSP types together
  spi: pxa2xx: Switch to use dev_err_probe()
  spi: pxa2xx: Extract pxa2xx_spi_init_ssp() helper
  spi: pxa2xx: Skip SSP initialization if it's done elsewhere
  spi: pxa2xx: Allow number of chip select pins to be read from property
  spi: pxa2xx: Provide num-cs for Sharp PDAs via device properties
  spi: pxa2xx: Move contents of linux/spi/pxa2xx_spi.h to a local one
  spi: pxa2xx: Remove outdated documentation
  spi: pxa2xx: Don't use "proxy" headers

 Documentation/spi/pxa2xx.rst   | 208 ---------------------------------
 arch/arm/mach-pxa/spitz.c      |  25 ++--
 drivers/spi/Kconfig            |   2 +-
 drivers/spi/spi-pxa2xx-dma.c   |  11 +-
 drivers/spi/spi-pxa2xx-pci.c   |  10 +-
 drivers/spi/spi-pxa2xx.c       | 118 +++++++++++--------
 drivers/spi/spi-pxa2xx.h       |  39 ++++++-
 include/linux/pxa2xx_ssp.h     |   2 +-
 include/linux/spi/pxa2xx_spi.h |  48 --------
 9 files changed, 140 insertions(+), 323 deletions(-)
 delete mode 100644 Documentation/spi/pxa2xx.rst
 delete mode 100644 include/linux/spi/pxa2xx_spi.h

-- 
2.43.0.rc1.1.gbec44491f096


