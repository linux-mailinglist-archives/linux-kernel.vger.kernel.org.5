Return-Path: <linux-kernel+bounces-96136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 627AE875789
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19B931F23E72
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C76613956B;
	Thu,  7 Mar 2024 19:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B2mNFUWW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CA4137C56;
	Thu,  7 Mar 2024 19:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709841064; cv=none; b=KXCR4uLyvGLiPGxLFS058PSgjNvKfx59foPGhFH/tSRH2aMRmK1i0dB5vSo+eJTWRddcG5T4wtcNCyNcgn278vsMXxLmS9kCSmzm/rBVTJaWB285xQmpqlmPIv9pplvC5MaZotCJ9Q7ucaz5fzemOE1NASfzr+MZ0ui2kIEI54E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709841064; c=relaxed/simple;
	bh=MvxOQpEMNaOWjzxyVQp/CL/dEEEmFaDsVhleVV905Oo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CPcLSr/dOA3kTTgc42mML4NrDSF5JcjfBvVQl2PDqvk+8zrBEya5/8ouKzIM1cIKkteehfY9jxA2h3YtSiPv1vIQKiI0K9i6ga3hO/i+QwErEWx/VSMc95NMGRQyklseoVnSn7m1BanjO/idy1Pf+SdbTeRj3t3wEtbvkMzHVpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B2mNFUWW; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709841062; x=1741377062;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MvxOQpEMNaOWjzxyVQp/CL/dEEEmFaDsVhleVV905Oo=;
  b=B2mNFUWW1o1fgvH8lIjkO6xfXvZIh/Y1//sk6L2HDhDAfOegprlFEVPc
   7siGV7xUqOZqXZ1ufSAtSzPadAenedME+2XuA5+233RA5laeiBqW7lQ6j
   r4EgaxzUhh5NHRlp0CKZ3ESjNjRoCU84yHUKCyExD7Rq4YPoAQuMeh+c0
   AH8+BaeZlFZtCGGja9EX2H8LCW53gb1udk2TlLWqIhva/boQf3dq6Fodg
   q10K6vFNmsPaLW1FIddjNOdJpT/Layc/efvsme0FVZAnfgzoLO/8WqHSu
   vokQ1yfaaoOqOsXFjkxCPmWudK2TK3eCeLzmWNhITGt6MkzGwhJBkjznK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4457042"
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; 
   d="scan'208";a="4457042"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 11:51:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="937046513"
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; 
   d="scan'208";a="937046513"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Mar 2024 11:50:59 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 164B3152; Thu,  7 Mar 2024 21:50:58 +0200 (EET)
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
Subject: [PATCH v3 2/3] spi: pxa2xx: Make num_chipselect 8-bit in the struct pxa2xx_spi_controller
Date: Thu,  7 Mar 2024 21:47:46 +0200
Message-ID: <20240307195056.4059864-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240307195056.4059864-1-andriy.shevchenko@linux.intel.com>
References: <20240307195056.4059864-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no use for whole 16-bit for the number of chip select pins.
Drop it to 8 bits.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 Documentation/spi/pxa2xx.rst   | 2 +-
 include/linux/spi/pxa2xx_spi.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/spi/pxa2xx.rst b/Documentation/spi/pxa2xx.rst
index 19479b801826..0997d8eaf190 100644
--- a/Documentation/spi/pxa2xx.rst
+++ b/Documentation/spi/pxa2xx.rst
@@ -24,7 +24,7 @@ arch/.../mach-*/board-*.c as a "platform device". The host controller configurat
 is passed to the driver via a table found in include/linux/spi/pxa2xx_spi.h::
 
   struct pxa2xx_spi_controller {
-	u16 num_chipselect;
+	u8 num_chipselect;
 	u8 enable_dma;
 	...
   };
diff --git a/include/linux/spi/pxa2xx_spi.h b/include/linux/spi/pxa2xx_spi.h
index 56aba2f737b1..e5a4a045fb67 100644
--- a/include/linux/spi/pxa2xx_spi.h
+++ b/include/linux/spi/pxa2xx_spi.h
@@ -17,7 +17,7 @@ struct dma_chan;
  * (resides in device.platform_data).
  */
 struct pxa2xx_spi_controller {
-	u16 num_chipselect;
+	u8 num_chipselect;
 	u8 enable_dma;
 	u8 dma_burst_size;
 	bool is_target;
-- 
2.43.0.rc1.1.gbec44491f096


