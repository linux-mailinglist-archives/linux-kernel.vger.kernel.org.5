Return-Path: <linux-kernel+bounces-95465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9B0874DF1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF243B25CBE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C802512C538;
	Thu,  7 Mar 2024 11:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i50N1bMK"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A503F12BF12;
	Thu,  7 Mar 2024 11:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709811907; cv=none; b=n/xT++Yt5SJFhgHoQVG0bJWjRlUq1wrnJv29T8rR0TVj8YWXhYn8WXvop2KLTNYxWs7OIFcGzH3KBZlY6Yk/UI9l/auZFIm2rNaOOeF5YpBlM5I7HiQFN1roCbQyWfjdgKDM7KKK6Bo+g9IvWWKtL7fR5mDbFP8tzahaDre6qpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709811907; c=relaxed/simple;
	bh=Uz/d15BowkJGiCLvoCJ6IObAUDP4Wu2EcBiVQo+Kf1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R0qbnZQugXrQ3UlTIYXjK3OBpG5TV2hQkDIGccuA9WsxeIHxgrVIFyHmEimAe5yX7n4qPdG95GU2rgsFp9HVEQjYLGAmGwNpLMHfNeZfHgqkHzNn7L2GH9igbvdbOrsenHIVWqcAHW3E5zc/xIEK3JtCeYsxOuBCk6kphSzB0cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i50N1bMK; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709811906; x=1741347906;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Uz/d15BowkJGiCLvoCJ6IObAUDP4Wu2EcBiVQo+Kf1Y=;
  b=i50N1bMKJz5+qy/QTfyKwMmXpeUD9rgf/QPfbGd8flZUyiQ5n+hwYJcH
   Rg5XFuNTjvLsN55PTdaKxsre9hBPir62dwMedAl9Gmpwe/9kUN5nne1x0
   meSaMFIB41QlzZdAl/Pgb8QuItaaZyJDWs7j0U1AKxlvU2S20rMIbwFdj
   c5u+M0EI097bGYnaTKNwWn4t3hh6VITKILRaNT9OmV9ZXmSLvFfsg54BJ
   k1Qe4AsIvfY30IMke55q8yX5WfYU9zite4Kc4YB1qaupeAOrsgKRMuNxi
   MOvpIBrOPCcZBGiblhlkuMbSTSvdjKN6uLghydXvbqNmfgQYaWiF+Oj8k
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="15120075"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="15120075"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 03:45:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="937045883"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="937045883"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Mar 2024 03:45:02 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 5E9DA193; Thu,  7 Mar 2024 13:45:01 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Wenchao Chen <wenchao.chen@unisoc.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] mmc: sdhci-sprd: Remove unused of_gpio.h
Date: Thu,  7 Mar 2024 13:45:00 +0200
Message-ID: <20240307114500.3643489-1-andriy.shevchenko@linux.intel.com>
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
 drivers/mmc/host/sdhci-sprd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index bed57a1c64b5..685b1c648901 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -13,7 +13,6 @@
 #include <linux/mmc/mmc.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
-- 
2.43.0.rc1.1.gbec44491f096


