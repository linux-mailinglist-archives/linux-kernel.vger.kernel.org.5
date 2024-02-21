Return-Path: <linux-kernel+bounces-75365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A87785E745
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 399301C21E5A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBDD86126;
	Wed, 21 Feb 2024 19:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mqOjbfKL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7A583A06;
	Wed, 21 Feb 2024 19:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708543733; cv=none; b=N4VMuWzQRxvRdFMsC9jfTaQaPtOjruP0dK3Gq7zeOlLUjPcHANI9kkPrF66vUybhSxEF2npH7FoV1I5sWRafTB5T3G1alszhiMBtF9TO1BscIduoo/QP1Ndn02RjPMJbAT7I9aw4R1gftcZzyvcd3FACzesoOd/+s6lDZTSU7MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708543733; c=relaxed/simple;
	bh=OCG/9QBJk/VuCn1UQ4bcO6gfWP+ArN9q7qEDy/bgmow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gWw8uI9xDiBwvf2C6axxe3hJB81gGhqPlJRFn8E2oT6xh4/5GKxrh/CbjPbW8jz11MHXZgRdsiSfgQRnmeVQtYMmza6GUfjkjC1ibVzMbTl/ogp9V6tR+mQqnwNaCwV1TCUWd+UIvXdEuA5KMHZkE3LGU46r1xey9ihRBgCIem4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mqOjbfKL; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708543732; x=1740079732;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OCG/9QBJk/VuCn1UQ4bcO6gfWP+ArN9q7qEDy/bgmow=;
  b=mqOjbfKLNkbdgFwQRMWRUbN7hDvGe1od73w7rVzLiMP1GaxO7gGrRVsH
   ix+y3Z6mDz7AtzDb7CWXKHUZEMMYJ6aGQHgivSZuvteOIQ5/+NWeFM2p+
   QnHFa5tkHrAPcnWXlWoXYTtI2IqfsYYXfkpWDs9DhZ9Q++ktoeyoVO/KM
   LPtwoKBLtpE+HC6mxk90uU77fT8nO3+FGNfdNXc1s0Md28pbIlfv8yX4u
   r5Zp1yQGVtI09xSzoMtzikd/nNama2K5eIRPzlt88j+MHsZkbd6BOy9ii
   BwAoJzt+xHdkJ5Cjqg+v2cGxG9cO/Pl5oe2Ys2sDsDgq8oytfsY/s7AHn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="25191396"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="25191396"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 11:28:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="936692316"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="936692316"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 21 Feb 2024 11:28:49 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id DC92D2A0; Wed, 21 Feb 2024 21:28:47 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] gpiolib: Fix the error path order in gpiochip_add_data_with_key()
Date: Wed, 21 Feb 2024 21:28:46 +0200
Message-ID: <20240221192846.4156888-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After shuffling the code, error path wasn't updated correctly.
Fix it here.

Fixes: ba5c5effe02c ("gpio: initialize descriptor SRCU structure before adding OF-based chips")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 4b4812bbcafd..1706edb3ee3f 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1056,6 +1056,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	gpiochip_irqchip_free_valid_mask(gc);
 err_remove_acpi_chip:
 	acpi_gpiochip_remove(gc);
+	gpiochip_remove_pin_ranges(gc);
 err_remove_of_chip:
 	gpiochip_free_hogs(gc);
 	of_gpiochip_remove(gc);
@@ -1063,7 +1064,6 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	for (i = 0; i < gdev->ngpio; i++)
 		cleanup_srcu_struct(&gdev->descs[i].srcu);
 err_free_gpiochip_mask:
-	gpiochip_remove_pin_ranges(gc);
 	gpiochip_free_valid_mask(gc);
 err_cleanup_gdev_srcu:
 	cleanup_srcu_struct(&gdev->srcu);
-- 
2.43.0.rc1.1.gbec44491f096


