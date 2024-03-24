Return-Path: <linux-kernel+bounces-114752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 998738890F9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F10F299AD9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2BA13D2BA;
	Mon, 25 Mar 2024 00:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmoNW9w0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A4D2745D8;
	Sun, 24 Mar 2024 23:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323338; cv=none; b=Z6ozjCr8n4Zy+5VXD8EjP3rYEh73+UwMzvxMEdZd/HyRnIlXY3T8ydzopn4QOyzj4rPn2vDGiOkl7IjhzN3+B3+YH0sNMDzifaJGw2AXeYqLxyU1vJj2ppQ4uqNNPVwmdRYqPFF9e2rf7oJzBPXNE+QZpiJZxAPjsENHJs/4M8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323338; c=relaxed/simple;
	bh=r6eqhgNkcb6EWkbMq2RF9hCEaxcmYhz8AHP6dwZcsOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jm/qmC3oOTQdeuUO1CV+9IRrY3PvAdTnwyWj7XHNRz0HVtZUKJV4tloVeNfBr7OGg23HW6fGNVKlnVKrIisCcvCObWPW1Qfrv2wHMoGWM/4rutYDbT/WNoTjc3ICjbSdPH2wGyTiU6ZrYgghA1UbG9S93JyF+RileMLdZeZe3E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmoNW9w0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B34BC433C7;
	Sun, 24 Mar 2024 23:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323336;
	bh=r6eqhgNkcb6EWkbMq2RF9hCEaxcmYhz8AHP6dwZcsOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bmoNW9w0JIS07CvdoDSrDxDla1HlezC4KuHUTMRQNwjLZX8bgrrl3n9o+jY4BJwe3
	 Pg+Mm7xO+ZcOQ6a9PiOWncBxyrcc3stTgNt5WNH2zCvdvyFUWvOr8EhuufhiQ2z33E
	 YiJPxhttFAVbl/hv6EDJt/2rH9hcEW2z4hyrVm8xeJX9XaVp/TBUIXxz/vcd8heXz5
	 7hf66JKCydaaz6gxY+7+P3zBoM85x0i8RfrRi2ae3nmlnqOV8y4E8hDG0U8gD3Q3jf
	 pBjQrxkBUBzbdWOIC05ND2gsj069B907RhTHtMxPOOEMhIkgw7FtCk89vQfHrfjMBB
	 oQE1KT5ne5Fkw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Jan=20H=C3=B6ppner?= <hoeppner@linux.ibm.com>,
	Stefan Haberland <sth@linux.ibm.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 037/317] s390/dasd: Use dev_*() for device log messages
Date: Sun, 24 Mar 2024 19:30:17 -0400
Message-ID: <20240324233458.1352854-38-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Jan Höppner <hoeppner@linux.ibm.com>

[ Upstream commit 79ae56fc475869d636071f66d9e4ef2a3819eee6 ]

All log messages in dasd.c use the printk variants of pr_*(). They all
add the name of the affected device manually to the log message.
This can be simplified by using the dev_*() variants of printk, which
include the device information and make a separate call to dev_name()
unnecessary.

The KMSG_COMPONENT and the pr_fmt() definition can be dropped. Note that
this removes the "dasd: " prefix from the one pr_info() call in
dasd_init(). However, the log message already provides all relevant
information.

Signed-off-by: Jan Höppner <hoeppner@linux.ibm.com>
Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Link: https://lore.kernel.org/r/20240208164248.540985-10-sth@linux.ibm.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: c3116e62ddef ("s390/dasd: fix double module refcount decrement")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/block/dasd.c | 50 +++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 26 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index c45b6f3780ebd..f13f76fe3f2e2 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -8,9 +8,6 @@
  * Copyright IBM Corp. 1999, 2009
  */
 
-#define KMSG_COMPONENT "dasd"
-#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
-
 #include <linux/kmod.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -3451,8 +3448,7 @@ static void dasd_generic_auto_online(void *data, async_cookie_t cookie)
 
 	ret = ccw_device_set_online(cdev);
 	if (ret)
-		pr_warn("%s: Setting the DASD online failed with rc=%d\n",
-			dev_name(&cdev->dev), ret);
+		dev_warn(&cdev->dev, "Setting the DASD online failed with rc=%d\n", ret);
 }
 
 /*
@@ -3539,8 +3535,11 @@ int dasd_generic_set_online(struct ccw_device *cdev,
 {
 	struct dasd_discipline *discipline;
 	struct dasd_device *device;
+	struct device *dev;
 	int rc;
 
+	dev = &cdev->dev;
+
 	/* first online clears initial online feature flag */
 	dasd_set_feature(cdev, DASD_FEATURE_INITIAL_ONLINE, 0);
 	device = dasd_create_device(cdev);
@@ -3553,11 +3552,10 @@ int dasd_generic_set_online(struct ccw_device *cdev,
 			/* Try to load the required module. */
 			rc = request_module(DASD_DIAG_MOD);
 			if (rc) {
-				pr_warn("%s Setting the DASD online failed "
-					"because the required module %s "
-					"could not be loaded (rc=%d)\n",
-					dev_name(&cdev->dev), DASD_DIAG_MOD,
-					rc);
+				dev_warn(dev, "Setting the DASD online failed "
+					 "because the required module %s "
+					 "could not be loaded (rc=%d)\n",
+					 DASD_DIAG_MOD, rc);
 				dasd_delete_device(device);
 				return -ENODEV;
 			}
@@ -3565,8 +3563,7 @@ int dasd_generic_set_online(struct ccw_device *cdev,
 		/* Module init could have failed, so check again here after
 		 * request_module(). */
 		if (!dasd_diag_discipline_pointer) {
-			pr_warn("%s Setting the DASD online failed because of missing DIAG discipline\n",
-				dev_name(&cdev->dev));
+			dev_warn(dev, "Setting the DASD online failed because of missing DIAG discipline\n");
 			dasd_delete_device(device);
 			return -ENODEV;
 		}
@@ -3587,8 +3584,8 @@ int dasd_generic_set_online(struct ccw_device *cdev,
 	/* check_device will allocate block device if necessary */
 	rc = discipline->check_device(device);
 	if (rc) {
-		pr_warn("%s Setting the DASD online with discipline %s failed with rc=%i\n",
-			dev_name(&cdev->dev), discipline->name, rc);
+		dev_warn(dev, "Setting the DASD online with discipline %s failed with rc=%i\n",
+			 discipline->name, rc);
 		module_put(discipline->owner);
 		module_put(base_discipline->owner);
 		dasd_delete_device(device);
@@ -3597,16 +3594,15 @@ int dasd_generic_set_online(struct ccw_device *cdev,
 
 	dasd_set_target_state(device, DASD_STATE_ONLINE);
 	if (device->state <= DASD_STATE_KNOWN) {
-		pr_warn("%s Setting the DASD online failed because of a missing discipline\n",
-			dev_name(&cdev->dev));
+		dev_warn(dev, "Setting the DASD online failed because of a missing discipline\n");
 		rc = -ENODEV;
 		dasd_set_target_state(device, DASD_STATE_NEW);
 		if (device->block)
 			dasd_free_block(device->block);
 		dasd_delete_device(device);
-	} else
-		pr_debug("dasd_generic device %s found\n",
-				dev_name(&cdev->dev));
+	} else {
+		dev_dbg(dev, "dasd_generic device found\n");
+	}
 
 	wait_event(dasd_init_waitq, _wait_for_device(device));
 
@@ -3617,10 +3613,13 @@ EXPORT_SYMBOL_GPL(dasd_generic_set_online);
 
 int dasd_generic_set_offline(struct ccw_device *cdev)
 {
+	int max_count, open_count, rc;
 	struct dasd_device *device;
 	struct dasd_block *block;
-	int max_count, open_count, rc;
 	unsigned long flags;
+	struct device *dev;
+
+	dev = &cdev->dev;
 
 	rc = 0;
 	spin_lock_irqsave(get_ccwdev_lock(cdev), flags);
@@ -3641,11 +3640,10 @@ int dasd_generic_set_offline(struct ccw_device *cdev)
 		open_count = atomic_read(&device->block->open_count);
 		if (open_count > max_count) {
 			if (open_count > 0)
-				pr_warn("%s: The DASD cannot be set offline with open count %i\n",
-					dev_name(&cdev->dev), open_count);
+				dev_warn(dev, "The DASD cannot be set offline with open count %i\n",
+					 open_count);
 			else
-				pr_warn("%s: The DASD cannot be set offline while it is in use\n",
-					dev_name(&cdev->dev));
+				dev_warn(dev, "The DASD cannot be set offline while it is in use\n");
 			rc = -EBUSY;
 			goto out_err;
 		}
@@ -4008,8 +4006,8 @@ static int dasd_handle_autoquiesce(struct dasd_device *device,
 	if (dasd_eer_enabled(device))
 		dasd_eer_write(device, NULL, DASD_EER_AUTOQUIESCE);
 
-	pr_info("%s: The DASD has been put in the quiesce state\n",
-		dev_name(&device->cdev->dev));
+	dev_info(&device->cdev->dev,
+		 "The DASD has been put in the quiesce state\n");
 	dasd_device_set_stop_bits(device, DASD_STOPPED_QUIESCE);
 
 	if (device->features & DASD_FEATURE_REQUEUEQUIESCE)
-- 
2.43.0


