Return-Path: <linux-kernel+bounces-116012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70ED288956C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A09F1C2F97D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D38817B515;
	Mon, 25 Mar 2024 03:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PagDRjnj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0F22745CD;
	Sun, 24 Mar 2024 23:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323337; cv=none; b=eWG8w/3nvqXHPsxbbIL0sfMGEMJrzFpgq5lvRAtLI2Wdz0MZgb21x91yBpbBopri61iAUO/teQQ91DEcm6LFdbQCwWlN2J3ABNoJakdyQwWV+pICHSi1BEyJGjv5skzsQrDEowXT3hETXRUiUvsLxhd5lHYF77y2DCrMgjEbxVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323337; c=relaxed/simple;
	bh=1uevdEvXHAOsPGA1ADrqF8fzrLL8wCgB7j2/r5OTiSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PiRcndB8LZCBYLBa2j1ebbAFd2y+2wm+ZNjELufx1ssZWgw4VyjY1zrLBQWPFpGX2836ezrqlA1S0XZKbP9cum9A1sfdJqkevfesTAKjc8eRfv/k6okHVu3kYaGRwJQAGFKRK2XH0vEyVSb5gK9Sr7N6cetYSXm21PrfWdsKyJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PagDRjnj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11F2EC43394;
	Sun, 24 Mar 2024 23:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323335;
	bh=1uevdEvXHAOsPGA1ADrqF8fzrLL8wCgB7j2/r5OTiSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PagDRjnjwqWHekpsilm8vDstIyPaVvD89udmSb9zqDYIOhlxZjY5k4zw6dDc4W5m5
	 FaSXDn5/jqcB/NvQzNCSLFOUHbws4XthCL60ASEhew9pK3+8jl63AaW8F1+CmqbYY/
	 uagsfHk03ipZFBRti9YAv+y1eyP4N1vGBv98BbsbCfyXYRK/3BSN690o2yDevxQsWz
	 vI2Bj1U35Nvr259t1EMJZGLVqpb11vXIY13QAHtIvWgJliPz5tJXgb6ItKVP770XZu
	 mDN/jd6cyDMtGO/k9WwihCq8C1Hd+cFDXCzu99DBe+OE+0e6F6g3/DyZ1bvs2cllSz
	 uQosrn33IrV9w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stefan Haberland <sth@linux.ibm.com>,
	Jan Hoeppner <hoeppner@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 036/317] s390/dasd: add autoquiesce feature
Date: Sun, 24 Mar 2024 19:30:16 -0400
Message-ID: <20240324233458.1352854-37-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Stefan Haberland <sth@linux.ibm.com>

[ Upstream commit 1cee2975bbabd89df1097c354867192106b058ea ]

Add the internal logic to check for autoquiesce triggers and handle
them.

Quiesce and resume are functions that tell Linux to stop/resume
issuing I/Os to a specific DASD.
The DASD driver allows a manual quiesce/resume via ioctl.

Autoquiesce will define an amount of triggers that will lead to
an automatic quiesce if a certain event occurs.
There is no automatic resume.

All events will be reported via DASD Extended Error Reporting (EER)
if configured.

Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Link: https://lore.kernel.org/r/20230405142017.2446986-3-sth@linux.ibm.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: c3116e62ddef ("s390/dasd: fix double module refcount decrement")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/include/uapi/asm/dasd.h |  2 ++
 drivers/s390/block/dasd.c         | 60 ++++++++++++++++++++++---------
 drivers/s390/block/dasd_eer.c     |  1 +
 drivers/s390/block/dasd_int.h     |  2 ++
 4 files changed, 48 insertions(+), 17 deletions(-)

diff --git a/arch/s390/include/uapi/asm/dasd.h b/arch/s390/include/uapi/asm/dasd.h
index 9ec86fae99805..188d17fc5f0c1 100644
--- a/arch/s390/include/uapi/asm/dasd.h
+++ b/arch/s390/include/uapi/asm/dasd.h
@@ -78,6 +78,7 @@ typedef struct dasd_information2_t {
  * 0x040: give access to raw eckd data
  * 0x080: enable discard support
  * 0x100: enable autodisable for IFCC errors (default)
+ * 0x200: enable requeue of all requests on autoquiesce
  */
 #define DASD_FEATURE_READONLY	      0x001
 #define DASD_FEATURE_USEDIAG	      0x002
@@ -88,6 +89,7 @@ typedef struct dasd_information2_t {
 #define DASD_FEATURE_USERAW	      0x040
 #define DASD_FEATURE_DISCARD	      0x080
 #define DASD_FEATURE_PATH_AUTODISABLE 0x100
+#define DASD_FEATURE_REQUEUEQUIESCE   0x200
 #define DASD_FEATURE_DEFAULT	      DASD_FEATURE_PATH_AUTODISABLE
 
 #define DASD_PARTN_BITS 2
diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index dc73b20e7424f..c45b6f3780ebd 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -84,7 +84,8 @@ static void dasd_profile_init(struct dasd_profile *, struct dentry *);
 static void dasd_profile_exit(struct dasd_profile *);
 static void dasd_hosts_init(struct dentry *, struct dasd_device *);
 static void dasd_hosts_exit(struct dasd_device *);
-
+static int dasd_handle_autoquiesce(struct dasd_device *, struct dasd_ccw_req *,
+				   unsigned int);
 /*
  * SECTION: Operations on the device structure.
  */
@@ -2349,7 +2350,7 @@ static int _dasd_sleep_on(struct dasd_ccw_req *maincqr, int interruptible)
 		/* Non-temporary stop condition will trigger fail fast */
 		if (device->stopped & ~DASD_STOPPED_PENDING &&
 		    test_bit(DASD_CQR_FLAGS_FAILFAST, &cqr->flags) &&
-		    (!dasd_eer_enabled(device))) {
+		    !dasd_eer_enabled(device) && device->aq_mask == 0) {
 			cqr->status = DASD_CQR_FAILED;
 			cqr->intrc = -ENOLINK;
 			continue;
@@ -2825,20 +2826,18 @@ static void __dasd_process_block_ccw_queue(struct dasd_block *block,
 			dasd_log_sense(cqr, &cqr->irb);
 		}
 
-		/* First of all call extended error reporting. */
-		if (dasd_eer_enabled(base) &&
-		    cqr->status == DASD_CQR_FAILED) {
-			dasd_eer_write(base, cqr, DASD_EER_FATALERROR);
-
-			/* restart request  */
+		/*
+		 * First call extended error reporting and check for autoquiesce
+		 */
+		spin_lock_irqsave(get_ccwdev_lock(base->cdev), flags);
+		if (cqr->status == DASD_CQR_FAILED &&
+		    dasd_handle_autoquiesce(base, cqr, DASD_EER_FATALERROR)) {
 			cqr->status = DASD_CQR_FILLED;
 			cqr->retries = 255;
-			spin_lock_irqsave(get_ccwdev_lock(base->cdev), flags);
-			dasd_device_set_stop_bits(base, DASD_STOPPED_QUIESCE);
-			spin_unlock_irqrestore(get_ccwdev_lock(base->cdev),
-					       flags);
+			spin_unlock_irqrestore(get_ccwdev_lock(base->cdev), flags);
 			goto restart;
 		}
+		spin_unlock_irqrestore(get_ccwdev_lock(base->cdev), flags);
 
 		/* Process finished ERP request. */
 		if (cqr->refers) {
@@ -2880,7 +2879,7 @@ static void __dasd_block_start_head(struct dasd_block *block)
 		/* Non-temporary stop condition will trigger fail fast */
 		if (block->base->stopped & ~DASD_STOPPED_PENDING &&
 		    test_bit(DASD_CQR_FLAGS_FAILFAST, &cqr->flags) &&
-		    (!dasd_eer_enabled(block->base))) {
+		    !dasd_eer_enabled(block->base) && block->base->aq_mask == 0) {
 			cqr->status = DASD_CQR_FAILED;
 			cqr->intrc = -ENOLINK;
 			dasd_schedule_block_bh(block);
@@ -3743,8 +3742,8 @@ int dasd_generic_last_path_gone(struct dasd_device *device)
 	dev_warn(&device->cdev->dev, "No operational channel path is left "
 		 "for the device\n");
 	DBF_DEV_EVENT(DBF_WARNING, device, "%s", "last path gone");
-	/* First of all call extended error reporting. */
-	dasd_eer_write(device, NULL, DASD_EER_NOPATH);
+	/* First call extended error reporting and check for autoquiesce. */
+	dasd_handle_autoquiesce(device, NULL, DASD_EER_NOPATH);
 
 	if (device->state < DASD_STATE_BASIC)
 		return 0;
@@ -3877,7 +3876,8 @@ void dasd_generic_path_event(struct ccw_device *cdev, int *path_event)
 			 "No verified channel paths remain for the device\n");
 		DBF_DEV_EVENT(DBF_WARNING, device,
 			      "%s", "last verified path gone");
-		dasd_eer_write(device, NULL, DASD_EER_NOPATH);
+		/* First call extended error reporting and check for autoquiesce. */
+		dasd_handle_autoquiesce(device, NULL, DASD_EER_NOPATH);
 		dasd_device_set_stop_bits(device,
 					  DASD_STOPPED_DC_WAIT);
 	}
@@ -3899,7 +3899,8 @@ EXPORT_SYMBOL_GPL(dasd_generic_verify_path);
 void dasd_generic_space_exhaust(struct dasd_device *device,
 				struct dasd_ccw_req *cqr)
 {
-	dasd_eer_write(device, NULL, DASD_EER_NOSPC);
+	/* First call extended error reporting and check for autoquiesce. */
+	dasd_handle_autoquiesce(device, NULL, DASD_EER_NOSPC);
 
 	if (device->state < DASD_STATE_BASIC)
 		return;
@@ -3992,6 +3993,31 @@ void dasd_schedule_requeue(struct dasd_device *device)
 }
 EXPORT_SYMBOL(dasd_schedule_requeue);
 
+static int dasd_handle_autoquiesce(struct dasd_device *device,
+				   struct dasd_ccw_req *cqr,
+				   unsigned int reason)
+{
+	/* in any case write eer message with reason */
+	if (dasd_eer_enabled(device))
+		dasd_eer_write(device, cqr, reason);
+
+	if (!test_bit(reason, &device->aq_mask))
+		return 0;
+
+	/* notify eer about autoquiesce */
+	if (dasd_eer_enabled(device))
+		dasd_eer_write(device, NULL, DASD_EER_AUTOQUIESCE);
+
+	pr_info("%s: The DASD has been put in the quiesce state\n",
+		dev_name(&device->cdev->dev));
+	dasd_device_set_stop_bits(device, DASD_STOPPED_QUIESCE);
+
+	if (device->features & DASD_FEATURE_REQUEUEQUIESCE)
+		dasd_schedule_requeue(device);
+
+	return 1;
+}
+
 static struct dasd_ccw_req *dasd_generic_build_rdc(struct dasd_device *device,
 						   int rdc_buffer_size,
 						   int magic)
diff --git a/drivers/s390/block/dasd_eer.c b/drivers/s390/block/dasd_eer.c
index 5ae64af9ccea3..22338033e6bfb 100644
--- a/drivers/s390/block/dasd_eer.c
+++ b/drivers/s390/block/dasd_eer.c
@@ -387,6 +387,7 @@ void dasd_eer_write(struct dasd_device *device, struct dasd_ccw_req *cqr,
 		break;
 	case DASD_EER_NOPATH:
 	case DASD_EER_NOSPC:
+	case DASD_EER_AUTOQUIESCE:
 		dasd_eer_write_standard_trigger(device, NULL, id);
 		break;
 	case DASD_EER_STATECHANGE:
diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index d743d1d2b38e9..744e14a81cc48 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -459,6 +459,7 @@ extern struct dasd_discipline *dasd_diag_discipline_pointer;
 #define DASD_EER_STATECHANGE 3
 #define DASD_EER_PPRCSUSPEND 4
 #define DASD_EER_NOSPC	     5
+#define DASD_EER_AUTOQUIESCE 31
 
 /* DASD path handling */
 
@@ -636,6 +637,7 @@ struct dasd_device {
 	struct dasd_format_entry format_entry;
 	struct kset *paths_info;
 	struct dasd_copy_relation *copy;
+	unsigned long aq_mask;
 };
 
 struct dasd_block {
-- 
2.43.0


