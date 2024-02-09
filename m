Return-Path: <linux-kernel+bounces-59683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B5E84FA4F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE4D81F218AD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A721F7B3FC;
	Fri,  9 Feb 2024 16:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XY7ea7rr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382AC73161;
	Fri,  9 Feb 2024 16:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707497694; cv=none; b=LdhddoK/Dj4Hbg+K7vls1JGLMDP+dW5Xw66ibYI409uU24C9erODe+zf7aBmAK+nHPSdTM9ZE/Rvx+iYcW4YfUnEur4ey7EkafA/yxBKbE1/H+0c73Bqr52IKVi4UseIoSAZbEqTrPDF6p7mx0tBhEwV1l+edeD6yNdBpeBiOpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707497694; c=relaxed/simple;
	bh=WfRAAkeXez9LEbGkpAe+Iqt0ZatDxojyrKv6NiWBNuk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aRuamVCMpoFrTh/Kgq2D7Pk92f5te+WGtVgKBZvir14hOHM3U0qjD0kD2G9XACL3ZidWhto9o3nRhNn1wN5nz4CUyZzdTLsg8OrnggM7zV41FGaXy8k+e5CgtZrFFxx446Rgahn5nJAPy/KkVGx9vsnAamgryTD9uJaNohM4Svk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XY7ea7rr; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707497693; x=1739033693;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WfRAAkeXez9LEbGkpAe+Iqt0ZatDxojyrKv6NiWBNuk=;
  b=XY7ea7rrnhpaXP4JnM138APCDNAE1J6VIr5IJEt6GxRzJrqQV6NmnDI9
   +gGnx2hKoOi0WjaJD6hV4Hmg+dnuC+cXp1KGTMlEOQ7g1JLnZOQPAIJR7
   W3xLmMXn6La2QeAwfySzVj/AlaFRryGXLKAdcbQYUMHMYIszgOxeQR0Gz
   tcVoPvuBaCF2h+o4p+S4WfMOPZIFKI9R9DQKDBp3G19LEDd1pUrhYvf6m
   R7HpXnKOAqsx2UQGzVPzw6ueu9J65T6av3hki/bVlH/6ls6NUd8vRpzZt
   7aiuusgr5Eyl6ZU9kJJoqiUVHnEkZ2uS5Ee5QKyf8V03S6GswmpcB5mjW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="1320790"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="1320790"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 08:54:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="934474274"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="934474274"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 09 Feb 2024 08:54:26 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 71E6C159; Fri,  9 Feb 2024 18:54:25 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 1/1] spi: gpio: Follow renaming of SPI "master" to "controller"
Date: Fri,  9 Feb 2024 18:54:23 +0200
Message-ID: <20240209165423.2305493-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In commit 8caab75fd2c2 ("spi: Generalize SPI "master" to "controller"")
some functions and struct members were renamed. Recent work by Uwe
completes this renaming. However, there are plenty of leftovers in
the comments and in-code documentation. Update them as well.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/spi/spi_gpio.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/spi/spi_gpio.h b/include/linux/spi/spi_gpio.h
index 9e7e83d8645b..5f0e1407917a 100644
--- a/include/linux/spi/spi_gpio.h
+++ b/include/linux/spi/spi_gpio.h
@@ -15,8 +15,8 @@
  */
 
 /**
- * struct spi_gpio_platform_data - parameter for bitbanged SPI master
- * @num_chipselect: how many slaves to allow
+ * struct spi_gpio_platform_data - parameter for bitbanged SPI host controller
+ * @num_chipselect: how many target devices to allow
  */
 struct spi_gpio_platform_data {
 	u16		num_chipselect;
-- 
2.43.0.rc1.1.gbec44491f096


