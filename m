Return-Path: <linux-kernel+bounces-95906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A68408754CE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D63451C21DA9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5BA130AF6;
	Thu,  7 Mar 2024 17:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CQs8Etcl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C2312FF70;
	Thu,  7 Mar 2024 17:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709831089; cv=none; b=XV9WLEdRp8//ZAJiGaszxF/hDhwpLwfuXz3hEmmsQmIlnQWPyE6gAKJ6WSaRbh2Uoka13bF+hW66+jcZI3OFEkp5eGAZ79smFMYu9+zCihbOk2b5zYV2yEvWJLvfkY3mBBjeFZJlX/uS46uEuRN1A1l3q4YzVJYspVCQ3ulcQls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709831089; c=relaxed/simple;
	bh=d5h4kxnC4gBSEdY31qlOBXqdv3M4Wv0YWmCTsRTCDA0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rXNgdfOhTlF+ncclDChB6+mFVwelRIpwhiJQnTqxJX+msB9kyKrzTyuRv9J6VCn6gcWfeGm+59CEWpKDY5WQ3AWQxA2U87lRR3Bnqt0kRYHVCj0NynK5zTL1jYigq9B+SdkSFN2glSDZ0gtAIIuE+KnH1SRJYfq8/AbU4/eKThk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CQs8Etcl; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709831088; x=1741367088;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=d5h4kxnC4gBSEdY31qlOBXqdv3M4Wv0YWmCTsRTCDA0=;
  b=CQs8EtclHlbxXXoSuBHBFA20o8LIXcnNsGzdcpkm/gXZ3Xb7FmcIfMyS
   deJE4rq+CcWTSWpHqSYz1/d/ZD+X8h2xOUtYqTKEIgMNOKT19Cm/1HRQu
   lvErKRP8FMWlvmRHhcjRMU3sxrEkzgtEaACIQofXogXuhcVgZyqUCfgaK
   OyhhGjg0t8G+RgoEBb2i5T8ax1vqEXR5K44ZVh78zdRYz2eb8M+IckE3q
   KbWByqfF3+x/fe7VwoBUNCe7uLFC0AHl2Nq7iv00q2+g0Q655PbsJB5aQ
   AL2nPlatEQN0XAaBPSpEgsBqsp7uLWGzIwRcNqf7ea5xFCbFfzXVPEcZZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4392402"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="4392402"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 09:04:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="937046410"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="937046410"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Mar 2024 09:04:43 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 56CDC128; Thu,  7 Mar 2024 19:04:42 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Cc: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 0/3] spi: pxa2xx: Clean up linux/spi/pxa2xx_spi.h
Date: Thu,  7 Mar 2024 19:03:14 +0200
Message-ID: <20240307170441.3884452-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A couple of cleanups against linux/spi/pxa2xx_spi.h.

In v2:
- preserved a comment (Arnd)
- added tag (Arnd)
- added new patch to avoid using unneeded header in soc/pxa/ssp.c

Andy Shevchenko (3):
  spi: pxa2xx: Kill pxa2xx_set_spi_info()
  spi: pxa2xx: Make num_chipselect 8-bit in the struct
    pxa2xx_spi_controller
  spi: pxa2xx: Use proper SSP header in soc/pxa/ssp.c

 arch/arm/mach-pxa/devices.c    | 18 ------------------
 arch/arm/mach-pxa/spitz.c      | 14 +++++++++++++-
 drivers/soc/pxa/ssp.c          |  2 +-
 include/linux/spi/pxa2xx_spi.h | 10 +---------
 4 files changed, 15 insertions(+), 29 deletions(-)

-- 
2.43.0.rc1.1.gbec44491f096


