Return-Path: <linux-kernel+bounces-91044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE108708D2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 456E0B25364
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E20A62156;
	Mon,  4 Mar 2024 17:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bvir76AW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95D761674;
	Mon,  4 Mar 2024 17:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709574974; cv=none; b=LjEQLgrTHwfeBe5pMx2Xo7AnlFLWX5GxWbBjwNk1BrFU5Eki8nr5CX+/UqVbOlsO1OOPrywzjMW9P77RZVRtMh46NaRzNDaMnOu34AafbKzLpl9tC7xqvxhEjNp1gMZtKB7zi4Uzew0n9O6n2sgIZFnRZNbuSeUapt4T5y1aq3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709574974; c=relaxed/simple;
	bh=drtzyZtOwqkOW+9tBb7Ed1tvYjSnYABhtG4eJWqnI48=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BR5/4zFIhTEM9uPATxgs+EhTXhveULTJtn+S+nPySqW6MSiTpeE75A+eSlNoEPmipxYrTEC/0tCyR6y4hOO0mAdxnaIlNJAh3ymFQ2BLGQHhSyllM7YYEr00VE0o8lM3oTkZwnQwoHUbf2KlY5vPE7hQqFG+u6I5mMAV53Ng35k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bvir76AW; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709574973; x=1741110973;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=drtzyZtOwqkOW+9tBb7Ed1tvYjSnYABhtG4eJWqnI48=;
  b=bvir76AWPweEjP+Hq9YUjuRezIw82E4yvb8gqczJJxMHuMEiGhDWiso4
   faKIeBiG6CKfMT8rFuifDrLjPnwOThlKpDpa1154+zJk1Nfo1eY/fzeuP
   qhyewiI/vpT+6KOweyE3HqPZ7dQsoxDMcN+T4y9qegZpUUoVXzRBiAbT8
   R/uDMrc+VIt0/1r7ZG4pTVgXsx/KXvtC5IW//1EOYsZ6T6ddboJCuDDFn
   z1er2htyFXk3VGz7u8zwIFegBTDXjxGUyROO+QvCDHjbbuSMDhcOlBIfQ
   Sez0ZqemRwJl/cJtKpWGzgsPwsj7VdzeprFra8hIXifme3FNJCHB7KzaK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4210405"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="4210405"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 09:56:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="937040908"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="937040908"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Mar 2024 09:56:09 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 2210415C; Mon,  4 Mar 2024 19:56:07 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Yangtao Li <frank.li@vivo.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-mmc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH v1 1/1] mmc: dw_mmc: Remove unused of_gpio.h
Date: Mon,  4 Mar 2024 19:56:06 +0200
Message-ID: <20240304175606.1200076-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_gpio.h is deprecated and subject to remove.
The driver doesn't use it, simply remove the unused header.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mmc/host/dw_mmc-exynos.c | 1 -
 drivers/mmc/host/dw_mmc.c        | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index 698408e8bad0..6dc057718d2c 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -11,7 +11,6 @@
 #include <linux/mmc/host.h>
 #include <linux/mmc/mmc.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
 
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 829af2c98a44..8e2d676b9239 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -35,7 +35,6 @@
 #include <linux/bitops.h>
 #include <linux/regulator/consumer.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/mmc/slot-gpio.h>
 
 #include "dw_mmc.h"
-- 
2.43.0.rc1.1.gbec44491f096


