Return-Path: <linux-kernel+bounces-115780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 804E7889687
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2CC71F31E6E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37ABE36F33A;
	Mon, 25 Mar 2024 03:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+/Z+oix"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2918114534B;
	Sun, 24 Mar 2024 23:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321988; cv=none; b=s5U5D3Wni7xn6vdJiRSnrULVP+oKkBUOhHiFf8HoXtWrItBD1HI6ZtwDUMO0o4Gn5obcSsIyNSZy38DeK2GhgDuJoGeVoM5nWFOvReEOPc8JuZr7hyrXZnJrOy2xeP6s2Fto4jvmVmyrBzh//Lke/dJfxb65F9xtkwMbFLKZrzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321988; c=relaxed/simple;
	bh=34bApgzD1XsXXwOukHHNmjEwD2ZKLb9YHfbMMVWunV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gF/wSwS15QVfSlpY27t3SzF9U9OPIHGln7btsXt9oI9/7Bi+ye8/1BhsyPu7Zf8DsDIIDUjmTjo3i9A93JVcGsK+5sZ/06rDv9hmZar1U8rZusFHaacg9YHShWYpuxrWKM09Bvlmi8IzxPMpB1mTbbHgk+DPMwhUPUPD/Gr2T/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+/Z+oix; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A83C433C7;
	Sun, 24 Mar 2024 23:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321988;
	bh=34bApgzD1XsXXwOukHHNmjEwD2ZKLb9YHfbMMVWunV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e+/Z+oixhuGU5pK/FexurY/sun6A+xkLgYWlGSeuBqdfVXlCXqMgy2aZlxBYemp/T
	 tq3OjoKGIE4T5bLKjrVK1V5uqgWevlkinzOE5/SIBCgL68T8J/1mKm0ZC4X4Z5fmNJ
	 IittJKjeaCXVUe8okqNnU6UXCblSmPlMH5KkiQR9Wyd9nqlM8DaRLlMn70NrC9Y23t
	 Qva3upKRS50SGujDEmMuLW7WGLTk5h3swr35N1Zh+4KF7WSl9sUjaRjWO95ZP/mjOn
	 g8lcsMBmHhITxc284wP+z+h06i35u137FcWrSdBq/ykBD7SOgim7DqPXHJxI+pXuH7
	 yJL+DolZ9AKvw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stefan Haberland <sth@linux.ibm.com>,
	Jan Hoeppner <hoeppner@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 060/451] s390/dasd: add autoquiesce feature
Date: Sun, 24 Mar 2024 19:05:36 -0400
Message-ID: <20240324231207.1351418-61-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index 93d1ccd3304c7..9c49c3d67cd56 100644
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
index f207de4a87a0f..2f6976671496f 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -73,7 +73,8 @@ static void dasd_profile_init(struct dasd_profile *, struct dentry *);
 static void dasd_profile_exit(struct dasd_profile *);
 static void dasd_hosts_init(struct dentry *, struct dasd_device *);
 static void dasd_hosts_exit(struct dasd_device *);
-
+static int dasd_handle_autoquiesce(struct dasd_device *, struct dasd_ccw_req *,
+				   unsigned int);
 /*
  * SECTION: Operations on the device structure.
  */
@@ -2327,7 +2328,7 @@ static int _dasd_sleep_on(struct dasd_ccw_req *maincqr, int interruptible)
 		/* Non-temporary stop condition will trigger fail fast */
 		if (device->stopped & ~DASD_STOPPED_PENDING &&
 		    test_bit(DASD_CQR_FLAGS_FAILFAST, &cqr->flags) &&
-		    (!dasd_eer_enabled(device))) {
+		    !dasd_eer_enabled(device) && device->aq_mask == 0) {
 			cqr->status = DASD_CQR_FAILED;
 			cqr->intrc = -ENOLINK;
 			continue;
@@ -2803,20 +2804,18 @@ static void __dasd_process_block_ccw_queue(struct dasd_block *block,
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
@@ -2858,7 +2857,7 @@ static void __dasd_block_start_head(struct dasd_block *block)
 		/* Non-temporary stop condition will trigger fail fast */
 		if (block->base->stopped & ~DASD_STOPPED_PENDING &&
 		    test_bit(DASD_CQR_FLAGS_FAILFAST, &cqr->flags) &&
-		    (!dasd_eer_enabled(block->base))) {
+		    !dasd_eer_enabled(block->base) && block->base->aq_mask == 0) {
 			cqr->status = DASD_CQR_FAILED;
 			cqr->intrc = -ENOLINK;
 			dasd_schedule_block_bh(block);
@@ -3682,8 +3681,8 @@ int dasd_generic_last_path_gone(struct dasd_device *device)
 	dev_warn(&device->cdev->dev, "No operational channel path is left "
 		 "for the device\n");
 	DBF_DEV_EVENT(DBF_WARNING, device, "%s", "last path gone");
-	/* First of all call extended error reporting. */
-	dasd_eer_write(device, NULL, DASD_EER_NOPATH);
+	/* First call extended error reporting and check for autoquiesce. */
+	dasd_handle_autoquiesce(device, NULL, DASD_EER_NOPATH);
 
 	if (device->state < DASD_STATE_BASIC)
 		return 0;
@@ -3815,7 +3814,8 @@ void dasd_generic_path_event(struct ccw_device *cdev, int *path_event)
 			 "No verified channel paths remain for the device\n");
 		DBF_DEV_EVENT(DBF_WARNING, device,
 			      "%s", "last verified path gone");
-		dasd_eer_write(device, NULL, DASD_EER_NOPATH);
+		/* First call extended error reporting and check for autoquiesce. */
+		dasd_handle_autoquiesce(device, NULL, DASD_EER_NOPATH);
 		dasd_device_set_stop_bits(device,
 					  DASD_STOPPED_DC_WAIT);
 	}
@@ -3837,7 +3837,8 @@ EXPORT_SYMBOL_GPL(dasd_generic_verify_path);
 void dasd_generic_space_exhaust(struct dasd_device *device,
 				struct dasd_ccw_req *cqr)
 {
-	dasd_eer_write(device, NULL, DASD_EER_NOSPC);
+	/* First call extended error reporting and check for autoquiesce. */
+	dasd_handle_autoquiesce(device, NULL, DASD_EER_NOSPC);
 
 	if (device->state < DASD_STATE_BASIC)
 		return;
@@ -3931,6 +3932,31 @@ void dasd_schedule_requeue(struct dasd_device *device)
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
index d4d31cd11d261..d16c699b9ac6d 100644
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
index f50932518f83a..00bcd177264ac 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -464,6 +464,7 @@ extern struct dasd_discipline *dasd_diag_discipline_pointer;
 #define DASD_EER_STATECHANGE 3
 #define DASD_EER_PPRCSUSPEND 4
 #define DASD_EER_NOSPC	     5
+#define DASD_EER_AUTOQUIESCE 31
 
 /* DASD path handling */
 
@@ -641,6 +642,7 @@ struct dasd_device {
 	struct dasd_format_entry format_entry;
 	struct kset *paths_info;
 	struct dasd_copy_relation *copy;
+	unsigned long aq_mask;
 };
 
 struct dasd_block {
-- 
2.43.0


