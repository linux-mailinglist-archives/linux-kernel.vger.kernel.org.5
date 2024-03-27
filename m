Return-Path: <linux-kernel+bounces-121901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DAB88EF2C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C613EB22ADF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB0614E2F8;
	Wed, 27 Mar 2024 19:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TfjkrigF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A0614D45F;
	Wed, 27 Mar 2024 19:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711567908; cv=none; b=tlLbF9V56VfdQWfbhdOHXKe8F37EC4IQ12WEGQfXerxxrurtdinHpFUe+CDKoxs1qHYVsgdelHnXH1m/jjxfW+m1K/n9osrd3eFvPoNJX4Bsebg/AjLoc7Wmw3QPTxGOAkBkAxhEaYwoNZLgNQ6W+nab8IicpbALF4Y3FB19qMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711567908; c=relaxed/simple;
	bh=szcPeNpPGwcpTv/vYr7M/HOPTxqfODzCAhPTU5Lf2p8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J2FWhpTe+RH1jXhzjIeRTyJt29NB+CWvJgG/GJVB2VCcEWed7soCl2CePxmk9C3BUVqkfzSJKpKSaBJjrYy759SFw0Fr/PmVMabgrHH0VMRmQ7vNVU8piI6mKQBvXIh8D8I3N8P5w4MupqttAXzdDc/QehDQLb7D7jpGm/WEwnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TfjkrigF; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711567906; x=1743103906;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=szcPeNpPGwcpTv/vYr7M/HOPTxqfODzCAhPTU5Lf2p8=;
  b=TfjkrigF67j7HTPhFvjep4uHHFFHai8UvJi0UwcBk7EK4FfrYc3SLf6N
   6MbzxyCSVlSVGNp2lyWFfrIhTtRTcRMS7nklg8WLDqZiqAk4tks9nOrtn
   Xh3XZ845Sx4v/GItCfAzw3DIheLbzNya6bry2Pk9CICpAzF2hlHcwGe/A
   vue09EzlVPMWnfDQHFrZrmYWExohAMqaO7Lgfztb6u0RBqHWCkZL9/4yb
   ai6BPytBPYzcidcCqSyId6XslC7KjfiPUEv68EBaeKfToM/mlJOg1BzHY
   ntbulodjIl73DPtxe7/RTHNZz+hyLn3nYFNY/fUd4yJ20L95/zftcog47
   A==;
X-CSE-ConnectionGUID: SZeVmNAQQLGZmLzLQHYksQ==
X-CSE-MsgGUID: zKy3ztoYSQ23/RMnlhPg4g==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="24187276"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="24187276"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 12:31:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="937075022"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="937075022"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 27 Mar 2024 12:31:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 85059284; Wed, 27 Mar 2024 21:31:42 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH v2 1/9] spi: pxa2xx: Narrow the Kconfig option visibility
Date: Wed, 27 Mar 2024 21:29:20 +0200
Message-ID: <20240327193138.2385910-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240327193138.2385910-1-andriy.shevchenko@linux.intel.com>
References: <20240327193138.2385910-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PCI || ACPI dependency is the historical part of the x86 support.
Narrow the Kconfig option visibility by limiting this dependency to x86.

The drop of x86 for PCI case had happened in the commit 2b49ebda39d6
("spi/pxa2xx: allow building on a 64-bit kernel"), while the ACPI
was specifically added for Intel Lynx Point in the commit a3496855d9f1
("spi/pxa2xx: add support for Lynxpoint SPI controllers").

Note that X86 covers both 32- and 64-bit variants.

Suggested-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 26ba34a4100b..c1bb1895009c 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -817,7 +817,7 @@ config SPI_PPC4xx
 
 config SPI_PXA2XX
 	tristate "PXA2xx SSP SPI master"
-	depends on ARCH_PXA || ARCH_MMP || PCI || ACPI || COMPILE_TEST
+	depends on ARCH_PXA || ARCH_MMP || (X86 && (PCI || ACPI)) || COMPILE_TEST
 	select PXA_SSP if ARCH_PXA || ARCH_MMP
 	help
 	  This enables using a PXA2xx or Sodaville SSP port as a SPI master
-- 
2.43.0.rc1.1.gbec44491f096


