Return-Path: <linux-kernel+bounces-130272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7990F89762B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1925B1F2AC56
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE4E1552E4;
	Wed,  3 Apr 2024 17:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KxMLpN5Q"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED643153569;
	Wed,  3 Apr 2024 17:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164562; cv=none; b=m4C84p8v6N55ZdFgnbSl3+ULLkvVuQ7nawCqRtiSwaX0D93rzVuSqKypk49AAx6++X25UxhHChcemFG0gIAzszeH6XDagQcLACoC4/F1FeXZyRGcEQhKcgTX7ahndUkr89hwyxdiFF8fomZaRL34RPQUTEuJj41JuLtWcGnt7Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164562; c=relaxed/simple;
	bh=dyERZVOSJSZL7gNINQU4nunPESAJfDiycIFf2QpXnwI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rq+/bWgkORqdGQx5xSVHPPnHiUrjw2xuOVnpYWGgaQjE1J2i+yna4pdjwVyMGARNEBob+XqDodSEQK5CPgB+bc19TgCrtmKwOfYZKAdk3qKpdCYVs2JhG/8zWQsUzcGhYrL4vjo9qdXccJfgu8oFPcLwFONa/b/V9u5BXBobTTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KxMLpN5Q; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712164561; x=1743700561;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dyERZVOSJSZL7gNINQU4nunPESAJfDiycIFf2QpXnwI=;
  b=KxMLpN5QR8IgNvlBjPWb6R/DzeqqUPFPzGP/kjceDISh20yKcvtNbaA4
   J3ydN34lGau1j1djb/3+YoWcotROckALjfhrQJi8Vb++aK5FNzI3/SBLV
   Mw5f9K8Wxl+JhtI+HMo2UT52SQTQI62smq/uu4aG0tLW1RUjV9Wxcb9SZ
   kDBKIN8GbD2UYRWzmifPrV3HMedpCZkKsMkRwZQImdtUibNAl5uZ+oipu
   FjQXsMJpLKoeF7Dn/A1a7EZPiXPTSmwKxVzpo3CS6HPZuwGDsrnEUAcmx
   4/8Kw9tP01Lx5BRKZ1PqBw5tBc2D5LNSo79lkdgw0upWoEsQw/16ti+Wf
   g==;
X-CSE-ConnectionGUID: HD4lNnqjSuaTdYeM34M8og==
X-CSE-MsgGUID: LAoULxiyQyuOuCoJ2sMMTw==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="18863570"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="18863570"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 10:15:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="937085341"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="937085341"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 03 Apr 2024 10:15:54 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 88BB9192; Wed,  3 Apr 2024 20:15:53 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 0/5] spi: pxa2xx: Cleanup (part 2)
Date: Wed,  3 Apr 2024 20:06:34 +0300
Message-ID: <20240403171550.1074644-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Here is the additional cleanup of the driver based on the fact of
the linux/spi/pxa2xx_spi.h being a local (to drivers/spi/) header.
This means it's based on top of "spi: pxa2xx: Drop linux/spi/pxa2xx_spi.h"
(20240327193138.2385910-1-andriy.shevchenko@linux.intel.com).

Andy Shevchenko (5):
  spi: pxa2xx: Move number of CS pins validation out of condition
  spi: pxa2xx: Drop struct pxa2xx_spi_chip
  spi: pxa2xx: Remove DMA parameters from struct chip_data
  spi: pxa2xx: Remove timeout field from struct chip_data
  spi: pxa2xx: Don't provide struct chip_data for others

 drivers/spi/spi-pxa2xx-dma.c | 27 +----------
 drivers/spi/spi-pxa2xx.c     | 92 +++++++++---------------------------
 drivers/spi/spi-pxa2xx.h     | 31 ------------
 3 files changed, 25 insertions(+), 125 deletions(-)

-- 
2.43.0.rc1.1.gbec44491f096


