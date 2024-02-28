Return-Path: <linux-kernel+bounces-85631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AB086B873
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05DE71C25241
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033616FD1B;
	Wed, 28 Feb 2024 19:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ADJfufli"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0BD6FD07;
	Wed, 28 Feb 2024 19:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709149223; cv=none; b=eTESubK7owVlzpL9iRZcI9emSdnJZfNT1ZAG6K34c5WrmCRx1WqTl0YnE4+DrxjIiyj9dFJzGafKL1yLtUUEBbRJR9qMXbfWvWCsnyFPetexayUBUOD6mB9sISeIzB1pXH6eg59nUjSYcMvyBvbv7iPIB4np4QU5WzF/eBGy3Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709149223; c=relaxed/simple;
	bh=5igh6jadtpYhcr9xZW3xd+hXMitCSDT77jGc5mLZUco=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dkr1BfrNG8e1Va+Zhdw3BBCqZ7vYsMSalG293hSTuRF5fNttscm6JxyL/1ZquzYsXpPvJbbyxxRjqXOjwlDSbfBRzK+XjDhIyhGSmrla8dKXgO9/7cAzrdKSLK0d/qETvzJl0LTquoxUOYF/exS2qEKgEYy/Q8QQe/Iu0SfgNI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ADJfufli; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709149222; x=1740685222;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5igh6jadtpYhcr9xZW3xd+hXMitCSDT77jGc5mLZUco=;
  b=ADJfufliDtGqLpiK2vOEoG+94L8BjMz3d224xheequBX9IXm2b7airdE
   5qumYa/ItSMXGpssblbi78OZ/BvyhqNwx6n7ZZI79ATZTpmG4ur3Th794
   vT10tYKfKhKxYhX/KtEe3v/SY4XNASkXGyztKa0Zr3FlXAdwTWcW6J9zW
   zEVNqI2+nEZJAPjYztFFYRygpV2tn6p8LBdeqCMe4AtqEVy7v9oZMXBWx
   7BHZhVFe+LzVkRYJtT1mBVpvsBcWlFVNskOY7HeeQ5muxew4BNRK3ot4w
   zGK82FgWTyk84OvQyrIzE/YuWoyv9oWjJCYnXtY4DogozCqeR1j035/iL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="14991352"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="14991352"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 11:40:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="937034609"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="937034609"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 28 Feb 2024 11:40:19 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 51E201C5; Wed, 28 Feb 2024 21:40:18 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Yang Yingliang <yangyingliang@huawei.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] spi: oc-tiny: Replace of_gpio.h by proper one
Date: Wed, 28 Feb 2024 21:40:15 +0200
Message-ID: <20240228194015.3605928-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_gpio.h is deprecated and subject to remove.
The driver doesn't use it directly, replace it
with what is really being used.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pic32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pic32.c b/drivers/spi/spi-pic32.c
index f55b38c577e4..709edb70ad7d 100644
--- a/drivers/spi/spi-pic32.c
+++ b/drivers/spi/spi-pic32.c
@@ -11,13 +11,13 @@
 #include <linux/delay.h>
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
+#include <linux/gpio/consumer.h>
 #include <linux/highmem.h>
 #include <linux/module.h>
 #include <linux/io.h>
 #include <linux/interrupt.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
-#include <linux/of_gpio.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
-- 
2.43.0.rc1.1.gbec44491f096


