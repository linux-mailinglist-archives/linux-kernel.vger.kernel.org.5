Return-Path: <linux-kernel+bounces-113629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9720E8885C7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 472CB289F9D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C2E1D5646;
	Sun, 24 Mar 2024 22:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aK+fWdrc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A491D1D7E;
	Sun, 24 Mar 2024 22:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320535; cv=none; b=g7PsNVuHwK818wTH0NMxQ4JHZHzX94Eo0c6qWPBDMkGcnhL26E9I33mRD5YMLy1fLHpmNSTiu3ZQ9qxhaeKW59aRaVsbZyQ0oJhHh6RH6tUwLeftP5ZkDKLvW7+1qe0E4ORUJ9bm7tKuj/GDD937wvRTMVGiUL548QexEStJxfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320535; c=relaxed/simple;
	bh=adxVTphVLidzk8t0vX9goEcOrzMopwtUizQK40x+Yfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EBHuY17yiVI0kc1QzIa8cJvp5/jpQOAPqHQvNBEmdDdtubCXTVIjX+w2gI/WNcHRHbADr2D/RGkYATVncK1D+aGzjrdWweshtBryBdA0jtu4s+dvzFxOVziC85uTxqdxiPjBGkBTaJAMRcSKHb3EBHSbHWITouJcsClGOWfaISQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aK+fWdrc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5215C43390;
	Sun, 24 Mar 2024 22:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320534;
	bh=adxVTphVLidzk8t0vX9goEcOrzMopwtUizQK40x+Yfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aK+fWdrcUc3KHE0D/HBFvJG5Jxzgha3l41TVTiCPrYfcLx3pgJpNfexx2yGuRnM5v
	 iesrA8Zybl/hsRl5y8ujUrHXkLwCHx+jizdJzzbOTLimS2vko5ARDjUDm+SGwiP+Ma
	 79C0oELbhfT1bp8OvckE2GyFH8r815rqCz2zuui5XX+Z/+3w5v2NdPBHLGKYeG/2q0
	 iINs/aONCE6f506EB2f1IMZvGyVZeFMXKLMTCvinrX/VwcZme3FZ5bEgrHvLgrydmr
	 VjJcQnQ7BR6TnOuRD97C8VnqOYaY7qgOzKef7tRrTMnFhdS35pJWVrPDfAFXI98j9F
	 GU0cBpvZaOJrg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Jan=20H=C3=B6ppner?= <hoeppner@linux.ibm.com>,
	Stefan Haberland <sth@linux.ibm.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 096/713] s390/dasd: Use dev_*() for device log messages
Date: Sun, 24 Mar 2024 18:37:02 -0400
Message-ID: <20240324224720.1345309-97-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index 833cfab7d8776..0eac1ae4f4acb 100644
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
@@ -3408,8 +3405,7 @@ static void dasd_generic_auto_online(void *data, async_cookie_t cookie)
 
 	ret = ccw_device_set_online(cdev);
 	if (ret)
-		pr_warn("%s: Setting the DASD online failed with rc=%d\n",
-			dev_name(&cdev->dev), ret);
+		dev_warn(&cdev->dev, "Setting the DASD online failed with rc=%d\n", ret);
 }
 
 /*
@@ -3496,8 +3492,11 @@ int dasd_generic_set_online(struct ccw_device *cdev,
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
@@ -3510,11 +3509,10 @@ int dasd_generic_set_online(struct ccw_device *cdev,
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
@@ -3522,8 +3520,7 @@ int dasd_generic_set_online(struct ccw_device *cdev,
 		/* Module init could have failed, so check again here after
 		 * request_module(). */
 		if (!dasd_diag_discipline_pointer) {
-			pr_warn("%s Setting the DASD online failed because of missing DIAG discipline\n",
-				dev_name(&cdev->dev));
+			dev_warn(dev, "Setting the DASD online failed because of missing DIAG discipline\n");
 			dasd_delete_device(device);
 			return -ENODEV;
 		}
@@ -3544,8 +3541,8 @@ int dasd_generic_set_online(struct ccw_device *cdev,
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
@@ -3554,16 +3551,15 @@ int dasd_generic_set_online(struct ccw_device *cdev,
 
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
 
@@ -3574,10 +3570,13 @@ EXPORT_SYMBOL_GPL(dasd_generic_set_online);
 
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
@@ -3598,11 +3597,10 @@ int dasd_generic_set_offline(struct ccw_device *cdev)
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
@@ -3962,8 +3960,8 @@ static int dasd_handle_autoquiesce(struct dasd_device *device,
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


