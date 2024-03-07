Return-Path: <linux-kernel+bounces-95848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A9B8753F6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D50881F220BB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CBF12F398;
	Thu,  7 Mar 2024 16:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nTqvSR7Q"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597EB1F5FF;
	Thu,  7 Mar 2024 16:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709827942; cv=none; b=jt5xkgYUA8RBpn7IE/2o1ky1RA+Que+4HbFFlsWjeF0z1RtBVCTzXXIWz7ZPwf2FF71NH7n3JxYeTa3GexUpXt9x7OaYEVBmDWbjsXO+mwCCXtykQoyhYUTw4W9pcfuBeahmUizJ9L6y9UW4fHFiB9o9S5VMoYDKhWSHABh9qmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709827942; c=relaxed/simple;
	bh=r5lF4R027hE6kPwnV5+dRR8ZDFuW3d4BtkJP0xcjCbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LBt9D6gxx9a/GTOjCWCoMycg0JuxRrfH0mE09FtX2goGj1s7kq8dHbFZV32zOyVM3qRpnJJuxm2NMUoReWbkqgNDTQtpOT1r3w8rxhTOPE5UX0YlFCakpYfQff7SEC/t0V41PyZFvVhVDHhEsMXhyRfK59aPqs50Lk3ZeELpyrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nTqvSR7Q; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709827941; x=1741363941;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=r5lF4R027hE6kPwnV5+dRR8ZDFuW3d4BtkJP0xcjCbQ=;
  b=nTqvSR7QNmiKbwxPdmzWnfR14JPOmbde1cJ9/2r77fkZ6pmI7Eo1XOOj
   EZ3igTS64sVUgluzt0NzzmpK55sbU48ARptoK4VB4OmMu60hO385f5sJs
   yKabADzCm9rlbnn+3zTwtGKGUAIgzOAfJDyAVhVcB2hGu1L+IQ8d/4qnP
   Zlnia2DAFJal12fbF5xpvmFafz8jFKWPtIniS1aRs+pgYk9nyOr5PJsGG
   GCkXBXgurpsshrheDNAU8DWarPicjxOGFYPdzkAFa07z0NNmBwUEnZQX8
   pGo5945z71wJSysap+ljlLKWfvkQARnkzFEe+T+0KhB6pXZgP6l5a1Bdc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="15936834"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="15936834"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 08:12:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="937046347"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="937046347"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Mar 2024 08:12:18 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 242553C0; Thu,  7 Mar 2024 18:12:17 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 1/1] spi: gpio: Make num_chipselect 8-bit in the struct pxa2xx_spi_controller
Date: Thu,  7 Mar 2024 18:12:16 +0200
Message-ID: <20240307161216.3825968-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no use for whole 16-bit for the number of chip select pins.
Drop it to 8 bits.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/spi/spi_gpio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/spi/spi_gpio.h b/include/linux/spi/spi_gpio.h
index 5f0e1407917a..30f29df811a4 100644
--- a/include/linux/spi/spi_gpio.h
+++ b/include/linux/spi/spi_gpio.h
@@ -19,7 +19,7 @@
  * @num_chipselect: how many target devices to allow
  */
 struct spi_gpio_platform_data {
-	u16		num_chipselect;
+	u8	num_chipselect;
 };
 
 #endif /* __LINUX_SPI_GPIO_H */
-- 
2.43.0.rc1.1.gbec44491f096


