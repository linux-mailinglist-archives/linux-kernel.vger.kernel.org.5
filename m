Return-Path: <linux-kernel+bounces-85635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 511C286B881
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDF80285368
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808855E073;
	Wed, 28 Feb 2024 19:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e0+9yYap"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFB85E061;
	Wed, 28 Feb 2024 19:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709149598; cv=none; b=XthgfscUPcz1mFFAg368GRQlMLmJUv5SX9jH2DxaYrA28AZwiJjks444MVhm5SIcIPAZjkWs+RsLz2Bmlnb4juNcE9z7r0VVTnnk2ZjxRIgsWcP4RASzF0uOJ1O4y1FqjjK1YzmKIXNk2mpx5yPTS1ebiV6eIxGLxDv5HiXoJek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709149598; c=relaxed/simple;
	bh=B8cB0QnIPUowOgUL1pi+u6srQ+WF28YcOhJoR7HcGCY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qGRuYiEvzGmeXgq02XNYBnEML3XEbWj7cA4fE/7Gzrq92yz5Mv0+tDLwiwOKT5LgfozZ+uvKdGocpYg4oiV/wcAP2bfHK+sHmHLTewEWTUA97PjOUuxy54GvdC5DelOgPSTQrR5Gkea4hNBbJa84apjtaLAzXYrS0yJzyIeFoCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e0+9yYap; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709149597; x=1740685597;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=B8cB0QnIPUowOgUL1pi+u6srQ+WF28YcOhJoR7HcGCY=;
  b=e0+9yYapyXRmWVRiXK5vHZz+MeZkyVMCDKrYwKbkS9GGQR0ctygdzU0q
   DVgpXZyRP5z5PPdT3GhNTqDF4NU/EJsu0KErG2n70+LcSqLAjANNgzilW
   LYHtxEya1P9uGD+EnKQdH2WBkABOSuligH95zjzQt3Yj2Ar7FBYyIYVLY
   gx048oHuLrUBH8dn76sSWHJvrhXE/jwA2khpsmLmdl2cI9A9WHGNtdAym
   VDKLrCDsFSC5YA3pTVSGI7aKwFgaQsCj4oFJ8J4y4YyoAeil0sCLHj6Na
   DOncLm23KmTvtdoLgcLAoolB4unFmb5s/hPeez0nJvl77/W79LjHeuMA2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="14991935"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="14991935"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 11:46:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="937034610"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="937034610"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 28 Feb 2024 11:46:34 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 6DD241C5; Wed, 28 Feb 2024 21:46:33 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] spi: stm32-qspi: Replace of_gpio.h by proper one
Date: Wed, 28 Feb 2024 21:46:32 +0200
Message-ID: <20240228194632.3606563-1-andriy.shevchenko@linux.intel.com>
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
 drivers/spi/spi-stm32-qspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index 385832030459..f1e922fd362a 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -8,13 +8,13 @@
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
 #include <linux/errno.h>
+#include <linux/gpio/consumer.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/pm_runtime.h>
 #include <linux/platform_device.h>
-- 
2.43.0.rc1.1.gbec44491f096


