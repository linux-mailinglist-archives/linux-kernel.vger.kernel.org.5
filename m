Return-Path: <linux-kernel+bounces-96138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A52587578D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23CF01C22068
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6266113A249;
	Thu,  7 Mar 2024 19:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AvId9bzG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E0A139566;
	Thu,  7 Mar 2024 19:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709841066; cv=none; b=Sl+zoOcIQDe1gzPUJw9zhHDd+AvwP3hL5O5gMSMAlahb9ejlXUEx8FphMBFPNIpchDAT2CiAOvLK/h8/n9rBrrcr3RPS2T/4ffDZ3QdJ/qJG2QHlOq5CdryNlxrA8yok89hkXJw5jhuSCyItVkn5A8UYESMpGPM14BbQOC379Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709841066; c=relaxed/simple;
	bh=4cdULCcytkLeYBiX0rgShPW1BjHtNu+TjxHj/QfFLg4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=re5wSY7Ds1zo2AI7klx1MlS89GIfn00r+W2O8GBcGh1Jn5rtb3CGTFaa2y/qTHLBV9UmyaRs1CHbzSLy57zuRwTCp+phveADiHeX357da/yG9OaeWWe0OGMxeR/xri5USqy7Se41+SkAP5xDAsE0ETWgPNBFlbOCxax/w1WdnJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AvId9bzG; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709841065; x=1741377065;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4cdULCcytkLeYBiX0rgShPW1BjHtNu+TjxHj/QfFLg4=;
  b=AvId9bzGib9DoD1/LRgmMDFX8CiE7FiuuYqO6GU2+Xr5dcIk4efsuhlv
   zgYVkik8Z8lgFpy2JkS76KkLChkGDGfZh87FXzKLMG5UHxNcXzwy79IgU
   Rf4vuZQJu8fkJRT/zTCbQ22tWERcex7Rw0P8oSgam5wSnuP/JOsEZqscl
   e51dJzJRa6r11siXBNC31EilPNKQW9DYaFtnxQxRoRGaNPCucMhV+KPIo
   MesEV0l3JfVG4Yj39DAnSBFdnmAohKtbb1yP8xRdEi7jQIpLRlKnlwJuA
   q0FfIwRUat+38KAbEL0WENaQvPkp3bo7+rec+HrhAlWvfrHcGciQjtWHB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4457068"
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; 
   d="scan'208";a="4457068"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 11:51:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="937046515"
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; 
   d="scan'208";a="937046515"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Mar 2024 11:50:59 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id EF780128; Thu,  7 Mar 2024 21:50:57 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Mark Brown <broonie@kernel.org>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH v3 0/3] spi: pxa2xx: Clean up linux/spi/pxa2xx_spi.h
Date: Thu,  7 Mar 2024 21:47:44 +0200
Message-ID: <20240307195056.4059864-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A couple of cleanups against linux/spi/pxa2xx_spi.h.

I'm sending this as v3 to land in the SPI subsystem. Meanwhile I'm
preparing an update to make linux/spi/pxa2xx_spi.h private to the
subsystem (PXA2xx driver). But the second part will be presented later
on (likely after v6.9-rc1). That said, this can be routed either via
SoC tree or SPI, up to respective maintainers.

In v3:
- fixed compilation error
- updated documentation file as well

In v2:
- preserved a comment (Arnd)
- added tag (Arnd)
- added new patch to avoid using unneeded header in soc/pxa/ssp.c

Andy Shevchenko (3):
  spi: pxa2xx: Kill pxa2xx_set_spi_info()
  spi: pxa2xx: Make num_chipselect 8-bit in the struct
    pxa2xx_spi_controller
  spi: pxa2xx: Use proper SSP header in soc/pxa/ssp.c

 Documentation/spi/pxa2xx.rst   |  2 +-
 arch/arm/mach-pxa/devices.c    | 18 ------------------
 arch/arm/mach-pxa/spitz.c      | 14 +++++++++++++-
 drivers/soc/pxa/ssp.c          |  2 +-
 include/linux/spi/pxa2xx_spi.h | 10 +---------
 5 files changed, 16 insertions(+), 30 deletions(-)

-- 
2.43.0.rc1.1.gbec44491f096


