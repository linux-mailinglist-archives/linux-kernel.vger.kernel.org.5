Return-Path: <linux-kernel+bounces-91009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6088870868
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76EE8B25E9F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B82612FD;
	Mon,  4 Mar 2024 17:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WpqcYSUe"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C351EB2D;
	Mon,  4 Mar 2024 17:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709573818; cv=none; b=J+yUOSWKbJb0YBwyHQNezIL4V+q+u0XKJoP+6HzaOceOFi7m1mEhwNJ+uCXCSOnfMXhg/hZ8OAW7HCC1/2Er8naNEF3PRgcvVa7lDefK/VL2EKCe2tO/mQZ6u3ZUzo6kYJBRBAUvMb1SI1kFYN2hGn+y6dSdZuiw7Pn2kd5MdQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709573818; c=relaxed/simple;
	bh=+zRC9k4FeLLggfyxfSuH2+QwyCyfaApzEENTTaBSX48=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JEk+yG0enn3CfA4fVjbRI/DDIKacOMkfruzy4VhU+GLhzZcG/n9sRETZA/nWHJGgPCQn8d+Pb5DnsA8I9L3anqXvAXhsLbg0MFTvViFv/IX4dwW0RhQV/H20vPfPBIvFNKf4MNZUaPMOAZ9qSdLf/172CfEztugfJSHVbsI8/yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WpqcYSUe; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709573817; x=1741109817;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+zRC9k4FeLLggfyxfSuH2+QwyCyfaApzEENTTaBSX48=;
  b=WpqcYSUe+Ve4z7iFmvBhOEIbihbT40pJFueYeO0CQKUchz+L//DlOLWN
   O2B6TDWJQxq/NyePJO7aiqrP6sX4z7lU3rFihU56o2Cbt3+O8YFvXQMph
   wyIdMSW31azD/HxMP/QgCJ9lXtS9zxSN6Kqe8LeBnewShu6IYjfSj+StZ
   KeEf+dazlBgcEMEJ1/e78rqX+ahEuxrWF9g7INnwLNNUn65GXFM+EDkNX
   LYGDazFlzB1zPx+m5+7zE79wVJ7nlaM86RujMV/MxbtNSdJF+TUJgD7wq
   2z1iWcH6VTKxjWxuybXxv1z0ARw18GYvM/x06xKFDtetA41rxYr/GHGAN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4207278"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="4207278"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 09:36:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="937040902"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="937040902"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Mar 2024 09:36:32 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 3AB9815C; Mon,  4 Mar 2024 19:36:31 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/1] gpiolib: Deduplicate cleanup for-loop in gpiochip_add_data_with_key()
Date: Mon,  4 Mar 2024 19:35:33 +0200
Message-ID: <20240304173630.1150382-1-andriy.shevchenko@linux.intel.com>
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
v2: rebased on top of the latest fixes for GPIO library (Bart)
 drivers/gpio/gpiolib.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index e2e583b40207..ce94e37bcbee 100644
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
 err_remove_of_chip:
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


