Return-Path: <linux-kernel+bounces-106571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FD787F076
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0A452835E4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 19:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B045F5730B;
	Mon, 18 Mar 2024 19:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dVfYLCC8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E7456755;
	Mon, 18 Mar 2024 19:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710790458; cv=none; b=icgir2XucK9V7zv3ANS0j3n8wTmElGa/qvYjx7klD0l+perAClfseLgITtsmtO2feYA0vre5aJWvDwhV4wiezuWY0OscGz50SiBFjyA0VJKHWCZ3ElGvE48Z6d8lxFPQseTtAs6oqVZox8cmWJ0+kWTVp/1ZYI2Se14eZDQkHE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710790458; c=relaxed/simple;
	bh=WAqvSCeWKnQz/3u9XZbC3se4rVNmhg3scOEQtWkbPig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mwYDBEn51XKdvmWUVNLnLmdFcnXz7+XASQ8u366KxuMYCi00mUXDbJCw9JaGeqqRlVBLoNtRrs7ffGlZYZ7vNzdkhN1gq8lc4zR/zLJTMfuTSOoNy7w2+Yj95aTfWXStMaGFv0cmCb7Mo3dhhLJ2ze/BXeFTA3191DKhYD7CjvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dVfYLCC8; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710790456; x=1742326456;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WAqvSCeWKnQz/3u9XZbC3se4rVNmhg3scOEQtWkbPig=;
  b=dVfYLCC8WFKwkakaQ54OFlUEdQuthYpqu4VWNnIUFZIaaXdJR12Hc0oE
   p5x/IXrnqmTSK/df5AI1wmsBeiBKZajulrVCN3Jk2Emo2Ix1xcCfB5DW9
   Qjozq64F2fDiGJXjAaavR1cj+ctMP/kX1v2jQnLtFzuSdkU8EVzVVQC6y
   mSeM7qVXvrNWsZZsEKxAHTwThvgONQI2gidnNef4Rvov8nK6GrFEUNeSj
   uI12NRZiwIhwjddNNvWqdIwluPYE/02neLMR4tJY69Irb1y20/OCB1Bcl
   MhTJe0w713Oo/1xx8BSkIZoVsEqCRCnbsIB48NIHN2LQFkrCvs4JtJRZp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="16774609"
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="16774609"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 12:34:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="937060631"
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="937060631"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 18 Mar 2024 12:34:12 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id D9A20815; Mon, 18 Mar 2024 21:34:11 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v1 1/1] can: mcp251x: Fix up includes
Date: Mon, 18 Mar 2024 21:34:10 +0200
Message-ID: <20240318193410.178163-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This driver is including the legacy GPIO header <linux/gpio.h>
but the only thing it is using from that header is the wrong
define for GPIOF_DIR_OUT.

Fix it up by using GPIO_LINE_DIRECTION_* macros respectively.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/net/can/spi/mcp251x.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index 79c4bab5f724..643974b3f329 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -28,7 +28,6 @@
 #include <linux/device.h>
 #include <linux/ethtool.h>
 #include <linux/freezer.h>
-#include <linux/gpio.h>
 #include <linux/gpio/driver.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -482,9 +481,9 @@ static int mcp251x_gpio_get_direction(struct gpio_chip *chip,
 				      unsigned int offset)
 {
 	if (mcp251x_gpio_is_input(offset))
-		return GPIOF_DIR_IN;
+		return GPIO_LINE_DIRECTION_IN;
 
-	return GPIOF_DIR_OUT;
+	return GPIO_LINE_DIRECTION_OUT;
 }
 
 static int mcp251x_gpio_get(struct gpio_chip *chip, unsigned int offset)
-- 
2.43.0.rc1.1.gbec44491f096


