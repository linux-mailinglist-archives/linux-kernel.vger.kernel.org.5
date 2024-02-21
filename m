Return-Path: <linux-kernel+bounces-75376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE9785E762
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B28D1C22AA7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3F886641;
	Wed, 21 Feb 2024 19:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LkWCgejR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C126A82D9B;
	Wed, 21 Feb 2024 19:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708544214; cv=none; b=jrwzNC7Fy+eu48926a9s6nGhRayt+fZozqFI5oNHvykbC6tQgJxYTuzuPwRfAF7LHqR/A+6Sbfesf8mIG3qPLx/MoU/k5Ul8sWdWi+RziChP+/OoT0xQCsiWAEb8znmcG7gFDVz5PgAi8b01TuGAS1dgwH9HRYBKgB4nMbJt4TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708544214; c=relaxed/simple;
	bh=zLZx7XTpA+GzodcHyHuHe6VoqkIpFjTFDogIv3yWIms=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z27ZWhjCMCyeDYlkETBcbd2rYtOpA2P9Z9uzLA/Lb1EtcIgI500oMBeQWtAriyEuJSCkTwKI0z40KDM6YHLhT6fKVWYdyYr1e0Giwm8L0CixWOY+UNHfO0nZ0m9QpltTyb8/C8BMFfjUC0Cc11uHoc/LuJDB717b7KuutspsjKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LkWCgejR; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708544213; x=1740080213;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zLZx7XTpA+GzodcHyHuHe6VoqkIpFjTFDogIv3yWIms=;
  b=LkWCgejRcOvcsttvIO3x8uG0/rTiNq4RhP3GuPwx67v0Kxu5zyVqx9th
   ohjxoclGkwdfcYCvfIMZYbJtFoLcYoBIjFxY2aLqcuHb6vqcZ3JCNwhWy
   auC4Lm+PlnOcXWxdsEpfBmc6uUJ1mFaCCH52IxlMmfSH7wSVC3n2LTLrY
   9OKSdxh+IaMRTYon9j2OfwUy+qs2kp08GpPtma1d0MoVKsJ1Y8/ySSirv
   93MNG2lAlkppR6+b2LV5MmO0FAoHkkoTRlC/W+LQ8EPb8mX6HJ3vJXDeh
   8EXIf/d/S/kwwqi7ebS2d1HQTVb+BrFTt6Z4F/6pTzZ1jYTboSp79hyaf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="25192459"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="25192459"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 11:36:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="936693497"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="936693497"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 21 Feb 2024 11:36:49 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id BDF941FD; Wed, 21 Feb 2024 21:36:48 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] gpiolib: Deduplicate cleanup for-loop in gpiochip_add_data_with_key()
Date: Wed, 21 Feb 2024 21:36:47 +0200
Message-ID: <20240221193647.13777-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no need to repeat for-loop twice in the error path in
gpiochip_add_data_with_key(). Deduplicate it. While at it,
rename loop variable to be more specific and avoid ambguity.

It also properly unwinds the SRCU, i.e. in reversed order of allocating.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 1706edb3ee3f..60fa7816c799 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -861,7 +861,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 			       struct lock_class_key *request_key)
 {
 	struct gpio_device *gdev;
-	unsigned int i, j;
+	unsigned int desc_index;
 	int base = 0;
 	int ret = 0;
 
@@ -965,8 +965,8 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 		}
 	}
 
-	for (i = 0; i < gc->ngpio; i++)
-		gdev->descs[i].gdev = gdev;
+	for (desc_index = 0; desc_index < gc->ngpio; desc_index++)
+		gdev->descs[desc_index].gdev = gdev;
 
 	BLOCKING_INIT_NOTIFIER_HEAD(&gdev->line_state_notifier);
 	BLOCKING_INIT_NOTIFIER_HEAD(&gdev->device_notifier);
@@ -992,19 +992,16 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	if (ret)
 		goto err_cleanup_gdev_srcu;
 
-	for (i = 0; i < gc->ngpio; i++) {
-		struct gpio_desc *desc = &gdev->descs[i];
+	for (desc_index = 0; desc_index < gc->ngpio; desc_index++) {
+		struct gpio_desc *desc = &gdev->descs[desc_index];
 
 		ret = init_srcu_struct(&desc->srcu);
-		if (ret) {
-			for (j = 0; j < i; j++)
-				cleanup_srcu_struct(&gdev->descs[j].srcu);
-			goto err_free_gpiochip_mask;
-		}
+		if (ret)
+			goto err_cleanup_desc_srcu;
 
-		if (gc->get_direction && gpiochip_line_is_valid(gc, i)) {
+		if (gc->get_direction && gpiochip_line_is_valid(gc, desc_index)) {
 			assign_bit(FLAG_IS_OUT,
-				   &desc->flags, !gc->get_direction(gc, i));
+				   &desc->flags, !gc->get_direction(gc, desc_index));
 		} else {
 			assign_bit(FLAG_IS_OUT,
 				   &desc->flags, !gc->direction_input);
@@ -1061,9 +1058,8 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	gpiochip_free_hogs(gc);
 	of_gpiochip_remove(gc);
 err_cleanup_desc_srcu:
-	for (i = 0; i < gdev->ngpio; i++)
-		cleanup_srcu_struct(&gdev->descs[i].srcu);
-err_free_gpiochip_mask:
+	while (desc_index--)
+		cleanup_srcu_struct(&gdev->descs[desc_index].srcu);
 	gpiochip_free_valid_mask(gc);
 err_cleanup_gdev_srcu:
 	cleanup_srcu_struct(&gdev->srcu);
-- 
2.43.0.rc1.1.gbec44491f096


