Return-Path: <linux-kernel+bounces-139284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC08B8A00EB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 21:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F7B2285F92
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1969181B83;
	Wed, 10 Apr 2024 19:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tbb4NYiF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B76F180A96;
	Wed, 10 Apr 2024 19:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712778984; cv=none; b=bUByOkjYUqPc/4Fn4sUoYMV4DMumr+/xff72WhEkdIRUnDTwAakAYR6VKAvuLrFYFxkLwQQAt/9APK/R0TIAfVPlSbo3o2mwe/VYrztVrkmdsmZ7dj9+RW8xKiAnXzkdpQOZSV1lK2aS0gg83jxjP+eUOIB9Gefwj6Bfi+Lkfo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712778984; c=relaxed/simple;
	bh=HDmfIFwQ+hlYZsGIqivrXso2mlG5zsDbTcZEPsSPLno=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ngZy9IGTL+uEr+1CY5wDXExnTHrmedg3/YmgfileMxzE6JfEU2WK7BPn5afnPD8Pzalsjfkt/Ra9IOnf2CYasUoA0FRSJCc+/bxElBYgA1poYgiXLGHi2cVHzne1TUAr4uWWwwpMHd3rcVrjzt3v6B8B9HuWNH+N5O09Dke5oKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tbb4NYiF; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712778983; x=1744314983;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HDmfIFwQ+hlYZsGIqivrXso2mlG5zsDbTcZEPsSPLno=;
  b=Tbb4NYiFwZ11rFWHzffEI3lt5Q1WAo7GzuYI1ulMl/qPPlArHo2qfyTo
   PS/iPTiC5p83Lebhbj+RHmj4AjdRMZWYXoNsCA7rY0QF4R//MDYDN0B2N
   3Xd3YWbYkKyQJLEG5H7Qooi+ol1GdI+FASns16CsBvNIeRfTSEBElJrdv
   ri2eOZMJQ1tXxhCotNd8Hb/J8izfUgNRkViprj0vUfsREE5eRX6iG6jCs
   JkqN+WVxneVlwgNzQNmtT7sUA1OXkbLOMoDEDxUsA0fNV9t/YThXDxcWY
   oWUHlw6HOaw0yPmjH87aAsHZn5y4pZhwHci1gKQ53Hha5XX2+DgfBeX8j
   w==;
X-CSE-ConnectionGUID: OW3iufsWQdu/KKRkIshi3A==
X-CSE-MsgGUID: TLrQVCd4RuKU2tXnl0DWhQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8729375"
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="8729375"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 12:56:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="937095424"
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="937095424"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 10 Apr 2024 12:56:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id C1D312A4; Wed, 10 Apr 2024 22:56:19 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v1 1/1] mmc: slot-gpio: Use irq_handler_t type
Date: Wed, 10 Apr 2024 22:56:18 +0300
Message-ID: <20240410195618.1632778-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The irq_handler_t is already defined globally, let's use it
in slot-gpio code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mmc/core/slot-gpio.c  | 5 ++---
 include/linux/mmc/slot-gpio.h | 5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
index 39f45c2b6de8..8e4750558101 100644
--- a/drivers/mmc/core/slot-gpio.c
+++ b/drivers/mmc/core/slot-gpio.c
@@ -19,7 +19,7 @@
 struct mmc_gpio {
 	struct gpio_desc *ro_gpio;
 	struct gpio_desc *cd_gpio;
-	irqreturn_t (*cd_gpio_isr)(int irq, void *dev_id);
+	irq_handler_t cd_gpio_isr;
 	char *ro_label;
 	char *cd_label;
 	u32 cd_debounce_delay_ms;
@@ -162,8 +162,7 @@ EXPORT_SYMBOL(mmc_gpio_set_cd_wake);
 /* Register an alternate interrupt service routine for
  * the card-detect GPIO.
  */
-void mmc_gpio_set_cd_isr(struct mmc_host *host,
-			 irqreturn_t (*isr)(int irq, void *dev_id))
+void mmc_gpio_set_cd_isr(struct mmc_host *host, irq_handler_t isr)
 {
 	struct mmc_gpio *ctx = host->slot.handler_priv;
 
diff --git a/include/linux/mmc/slot-gpio.h b/include/linux/mmc/slot-gpio.h
index 5d3d15e97868..3e4d4836a2bb 100644
--- a/include/linux/mmc/slot-gpio.h
+++ b/include/linux/mmc/slot-gpio.h
@@ -8,8 +8,8 @@
 #ifndef MMC_SLOT_GPIO_H
 #define MMC_SLOT_GPIO_H
 
+#include <linux/interrupt.h>
 #include <linux/types.h>
-#include <linux/irqreturn.h>
 
 struct mmc_host;
 
@@ -21,8 +21,7 @@ int mmc_gpiod_request_cd(struct mmc_host *host, const char *con_id,
 			 unsigned int debounce);
 int mmc_gpiod_request_ro(struct mmc_host *host, const char *con_id,
 			 unsigned int idx, unsigned int debounce);
-void mmc_gpio_set_cd_isr(struct mmc_host *host,
-			 irqreturn_t (*isr)(int irq, void *dev_id));
+void mmc_gpio_set_cd_isr(struct mmc_host *host, irq_handler_t isr);
 int mmc_gpio_set_cd_wake(struct mmc_host *host, bool on);
 void mmc_gpiod_request_cd_irq(struct mmc_host *host);
 bool mmc_can_gpio_cd(struct mmc_host *host);
-- 
2.43.0.rc1.1336.g36b5255a03ac


