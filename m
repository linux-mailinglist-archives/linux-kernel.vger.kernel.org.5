Return-Path: <linux-kernel+bounces-121904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FC588EF33
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74E551C33D7B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73387152DFC;
	Wed, 27 Mar 2024 19:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fYfd1Mzi"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FA3152181;
	Wed, 27 Mar 2024 19:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711567911; cv=none; b=hOEvzhYpO0OUkisITRq4U38CdphwQiiJGB9SYAm9SAaoJtr98Ytnc4iGkujpyz7o2PqIvxw6t2vM17ZY+m6U8msMf01H5hJFN9gflNSXf+cia8BoidGYqbpIzCqqq9NyMdPUzgLd2Hic8H1KQEF8eXUJM94/CneqgXiPUgxWn+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711567911; c=relaxed/simple;
	bh=Qbjf0DNC7olff9ITntNRPlYpx0Wby/w7Z09ZkKCcvww=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XuWwK8zeyBhoMWUZuBhuRqHhmJJD9HRl77CMnwgZRwC6rMsq38s4N0g1ZpB2JnPDvBATrbQkXAsAgKN6yJsR5DVMn8Zp8ukh8hf3gljtUQyFM123LUKGI4CNjWNNATEt6FWr5P00dm1HQTS5cjARrZvw+cFPFQ6f3P/ECSVZWf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fYfd1Mzi; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711567909; x=1743103909;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Qbjf0DNC7olff9ITntNRPlYpx0Wby/w7Z09ZkKCcvww=;
  b=fYfd1MzilQ8Uey/zmIFpGj5MQsmSCw4QxAPgq2hSgkTbD/zeX74fXych
   buT95lb4aujKUgZrB3VteHz9dpNkXRyR2faa2n0nMaMEU/Znr7nTEmNVG
   Yw68PAHZMubasUOBSc51klsWLU/m05lKx5lnpcgoYJyH5jIZgHI5l6c+Y
   +BMyKTUx+eZB15lA/GT/yw4h85Jb4SnMvtjRNCF1FfBcEuEYMs2CGuvPF
   Rp5NzKr+J1peC+5IJquxYNMoVaNEAWe1gwh/a7KAGd2GC5D8yWnEcM0Qy
   1HcEe92J+CANJFjLpfcy43yt3JxNmR5Yzfhxbje1aBGT15VhMAoVluIkq
   A==;
X-CSE-ConnectionGUID: 62b7d4BRQgax9mUaoQpErA==
X-CSE-MsgGUID: 09BGy2SNQEOYLyBuS6cA8A==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="24187311"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="24187311"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 12:31:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="937075023"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="937075023"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 27 Mar 2024 12:31:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 761F32CA; Wed, 27 Mar 2024 21:31:42 +0200 (EET)
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
Subject: [PATCH v2 0/9] spi: pxa2xx: Drop linux/spi/pxa2xx_spi.h
Date: Wed, 27 Mar 2024 21:29:19 +0200
Message-ID: <20240327193138.2385910-1-andriy.shevchenko@linux.intel.com>
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

Changelog v2:
- dropped applied patches
- added patch to amend dependencies (Mark)
- amended the second patch accordingly (Mark)
- elaborated purpose of the patch 6 in the commit message (Mark)

Cc: Arnd Bergmann <arnd@arndb.de>

Andy Shevchenko (9):
  spi: pxa2xx: Narrow the Kconfig option visibility
  spi: pxa2xx: Drop ACPI_PTR() and of_match_ptr()
  spi: pxa2xx: Extract pxa2xx_spi_init_ssp() helper
  spi: pxa2xx: Skip SSP initialization if it's done elsewhere
  spi: pxa2xx: Allow number of chip select pins to be read from property
  spi: pxa2xx: Provide num-cs for Sharp PDAs via device properties
  spi: pxa2xx: Move contents of linux/spi/pxa2xx_spi.h to a local one
  spi: pxa2xx: Remove outdated documentation
  spi: pxa2xx: Don't use "proxy" headers

 Documentation/spi/pxa2xx.rst   | 208 ---------------------------------
 arch/arm/mach-pxa/spitz.c      |  25 ++--
 drivers/spi/Kconfig            |   5 +-
 drivers/spi/spi-pxa2xx-dma.c   |  11 +-
 drivers/spi/spi-pxa2xx-pci.c   |  10 +-
 drivers/spi/spi-pxa2xx.c       |  99 ++++++++++------
 drivers/spi/spi-pxa2xx.h       |  39 ++++++-
 include/linux/spi/pxa2xx_spi.h |  48 --------
 8 files changed, 133 insertions(+), 312 deletions(-)
 delete mode 100644 Documentation/spi/pxa2xx.rst
 delete mode 100644 include/linux/spi/pxa2xx_spi.h

-- 
2.43.0.rc1.1.gbec44491f096


