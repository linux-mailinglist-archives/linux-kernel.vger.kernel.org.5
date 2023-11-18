Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5116E7F0323
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 23:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjKRWi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 17:38:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjKRWi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 17:38:26 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D5E126
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 14:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1700347101;
        bh=PGCzfevR9xMe5rAURH419b9upIWyhRKrkq9vE/g9uT4=;
        h=Message-ID:Subject:From:To:Date:From;
        b=FT/VF7pJ8TLC3NcjmniiC1wliurXKOOBXktLNn5AN3JgCUOioJGHaWNiWvddX5XJg
         d5TdHyMt/76ExIl42rDrpSMxB9EV0nYjpECtwANuNwJ8BYaStzYqXW9/1BZ7eB7qzV
         cFY0LMZjSJlc8+C6LyckvidoYmxdeuUjvJnKKrQs=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id DFE971286803;
        Sat, 18 Nov 2023 17:38:21 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id KLNOn9_QqHbY; Sat, 18 Nov 2023 17:38:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1700347101;
        bh=PGCzfevR9xMe5rAURH419b9upIWyhRKrkq9vE/g9uT4=;
        h=Message-ID:Subject:From:To:Date:From;
        b=FT/VF7pJ8TLC3NcjmniiC1wliurXKOOBXktLNn5AN3JgCUOioJGHaWNiWvddX5XJg
         d5TdHyMt/76ExIl42rDrpSMxB9EV0nYjpECtwANuNwJ8BYaStzYqXW9/1BZ7eB7qzV
         cFY0LMZjSJlc8+C6LyckvidoYmxdeuUjvJnKKrQs=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 43F5712867C5;
        Sat, 18 Nov 2023 17:38:21 -0500 (EST)
Message-ID: <040ce44df0bf702e4968a903d9ed06b82907a235.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 6.7-rc1
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Sat, 18 Nov 2023 17:38:19 -0500
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

7 small fixes, 6 in drivers and one in sd.  The sd fix is so large
because it changes a struct pointer to a struct but otherwise is fairly
simple.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Dan Carpenter (2):
      scsi: scsi_debug: Delete some bogus error checking
      scsi: scsi_debug: Fix some bugs in sdebug_error_write()

Mike Christie (1):
      scsi: sd: Fix sshdr use in sd_suspend_common()

Naomi Chu (1):
      scsi: ufs: core: Expand MCQ queue slot to DeviceQueueDepth + 1

Neil Armstrong (1):
      scsi: ufs: qcom-ufs: dt-bindings: Document the SM8650 UFS Controller

Peter Wang (1):
      scsi: ufs: core: Fix racing issue between ufshcd_mcq_abort() and ISR

Quinn Tran (1):
      scsi: qla2xxx: Fix system crash due to bad pointer access

And the diffstat

 .../devicetree/bindings/ufs/qcom,ufs.yaml          |  2 +
 drivers/scsi/qla2xxx/qla_os.c                      | 12 ++++-
 drivers/scsi/scsi_debug.c                          |  9 +---
 drivers/scsi/sd.c                                  | 53 ++++++++++------------
 drivers/ufs/core/ufs-mcq.c                         |  5 +-
 5 files changed, 40 insertions(+), 41 deletions(-)

With full diff below.

James

---

diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
index 462ead5a1cec..2cf3d016db42 100644
--- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
+++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
@@ -36,6 +36,7 @@ properties:
           - qcom,sm8350-ufshc
           - qcom,sm8450-ufshc
           - qcom,sm8550-ufshc
+          - qcom,sm8650-ufshc
       - const: qcom,ufshc
       - const: jedec,ufs-2.0
 
@@ -122,6 +123,7 @@ allOf:
               - qcom,sm8350-ufshc
               - qcom,sm8450-ufshc
               - qcom,sm8550-ufshc
+              - qcom,sm8650-ufshc
     then:
       properties:
         clocks:
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 32d1e73e46ee..03348f605c2e 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -1837,8 +1837,16 @@ static void qla2x00_abort_srb(struct qla_qpair *qp, srb_t *sp, const int res,
 		}
 
 		spin_lock_irqsave(qp->qp_lock_ptr, *flags);
-		if (ret_cmd && blk_mq_request_started(scsi_cmd_to_rq(cmd)))
-			sp->done(sp, res);
+		switch (sp->type) {
+		case SRB_SCSI_CMD:
+			if (ret_cmd && blk_mq_request_started(scsi_cmd_to_rq(cmd)))
+				sp->done(sp, res);
+			break;
+		default:
+			if (ret_cmd)
+				sp->done(sp, res);
+			break;
+		}
 	} else {
 		sp->done(sp, res);
 	}
diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 67922e2c4c19..6d8218a44122 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -1019,7 +1019,7 @@ static ssize_t sdebug_error_write(struct file *file, const char __user *ubuf,
 	struct sdebug_err_inject *inject;
 	struct scsi_device *sdev = (struct scsi_device *)file->f_inode->i_private;
 
-	buf = kmalloc(count, GFP_KERNEL);
+	buf = kzalloc(count + 1, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
@@ -1132,7 +1132,6 @@ static const struct file_operations sdebug_target_reset_fail_fops = {
 static int sdebug_target_alloc(struct scsi_target *starget)
 {
 	struct sdebug_target_info *targetip;
-	struct dentry *dentry;
 
 	targetip = kzalloc(sizeof(struct sdebug_target_info), GFP_KERNEL);
 	if (!targetip)
@@ -1140,15 +1139,9 @@ static int sdebug_target_alloc(struct scsi_target *starget)
 
 	targetip->debugfs_entry = debugfs_create_dir(dev_name(&starget->dev),
 				sdebug_debugfs_root);
-	if (IS_ERR_OR_NULL(targetip->debugfs_entry))
-		pr_info("%s: failed to create debugfs directory for target %s\n",
-			__func__, dev_name(&starget->dev));
 
 	debugfs_create_file("fail_reset", 0600, targetip->debugfs_entry, starget,
 				&sdebug_target_reset_fail_fops);
-	if (IS_ERR_OR_NULL(dentry))
-		pr_info("%s: failed to create fail_reset file for target %s\n",
-			__func__, dev_name(&starget->dev));
 
 	starget->hostdata = targetip;
 
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 530918cbfce2..fa00dd503cbf 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1643,24 +1643,21 @@ static unsigned int sd_check_events(struct gendisk *disk, unsigned int clearing)
 	return disk_changed ? DISK_EVENT_MEDIA_CHANGE : 0;
 }
 
-static int sd_sync_cache(struct scsi_disk *sdkp, struct scsi_sense_hdr *sshdr)
+static int sd_sync_cache(struct scsi_disk *sdkp)
 {
 	int retries, res;
 	struct scsi_device *sdp = sdkp->device;
 	const int timeout = sdp->request_queue->rq_timeout
 		* SD_FLUSH_TIMEOUT_MULTIPLIER;
-	struct scsi_sense_hdr my_sshdr;
+	struct scsi_sense_hdr sshdr;
 	const struct scsi_exec_args exec_args = {
 		.req_flags = BLK_MQ_REQ_PM,
-		/* caller might not be interested in sense, but we need it */
-		.sshdr = sshdr ? : &my_sshdr,
+		.sshdr = &sshdr,
 	};
 
 	if (!scsi_device_online(sdp))
 		return -ENODEV;
 
-	sshdr = exec_args.sshdr;
-
 	for (retries = 3; retries > 0; --retries) {
 		unsigned char cmd[16] = { 0 };
 
@@ -1685,15 +1682,23 @@ static int sd_sync_cache(struct scsi_disk *sdkp, struct scsi_sense_hdr *sshdr)
 			return res;
 
 		if (scsi_status_is_check_condition(res) &&
-		    scsi_sense_valid(sshdr)) {
-			sd_print_sense_hdr(sdkp, sshdr);
+		    scsi_sense_valid(&sshdr)) {
+			sd_print_sense_hdr(sdkp, &sshdr);
 
 			/* we need to evaluate the error return  */
-			if (sshdr->asc == 0x3a ||	/* medium not present */
-			    sshdr->asc == 0x20 ||	/* invalid command */
-			    (sshdr->asc == 0x74 && sshdr->ascq == 0x71))	/* drive is password locked */
+			if (sshdr.asc == 0x3a ||	/* medium not present */
+			    sshdr.asc == 0x20 ||	/* invalid command */
+			    (sshdr.asc == 0x74 && sshdr.ascq == 0x71))	/* drive is password locked */
 				/* this is no error here */
 				return 0;
+			/*
+			 * This drive doesn't support sync and there's not much
+			 * we can do because this is called during shutdown
+			 * or suspend so just return success so those operations
+			 * can proceed.
+			 */
+			if (sshdr.sense_key == ILLEGAL_REQUEST)
+				return 0;
 		}
 
 		switch (host_byte(res)) {
@@ -3853,7 +3858,7 @@ static void sd_shutdown(struct device *dev)
 
 	if (sdkp->WCE && sdkp->media_present) {
 		sd_printk(KERN_NOTICE, sdkp, "Synchronizing SCSI cache\n");
-		sd_sync_cache(sdkp, NULL);
+		sd_sync_cache(sdkp);
 	}
 
 	if ((system_state != SYSTEM_RESTART &&
@@ -3874,7 +3879,6 @@ static inline bool sd_do_start_stop(struct scsi_device *sdev, bool runtime)
 static int sd_suspend_common(struct device *dev, bool runtime)
 {
 	struct scsi_disk *sdkp = dev_get_drvdata(dev);
-	struct scsi_sense_hdr sshdr;
 	int ret = 0;
 
 	if (!sdkp)	/* E.g.: runtime suspend following sd_remove() */
@@ -3883,24 +3887,13 @@ static int sd_suspend_common(struct device *dev, bool runtime)
 	if (sdkp->WCE && sdkp->media_present) {
 		if (!sdkp->device->silence_suspend)
 			sd_printk(KERN_NOTICE, sdkp, "Synchronizing SCSI cache\n");
-		ret = sd_sync_cache(sdkp, &sshdr);
-
-		if (ret) {
-			/* ignore OFFLINE device */
-			if (ret == -ENODEV)
-				return 0;
-
-			if (!scsi_sense_valid(&sshdr) ||
-			    sshdr.sense_key != ILLEGAL_REQUEST)
-				return ret;
+		ret = sd_sync_cache(sdkp);
+		/* ignore OFFLINE device */
+		if (ret == -ENODEV)
+			return 0;
 
-			/*
-			 * sshdr.sense_key == ILLEGAL_REQUEST means this drive
-			 * doesn't support sync. There's not much to do and
-			 * suspend shouldn't fail.
-			 */
-			ret = 0;
-		}
+		if (ret)
+			return ret;
 	}
 
 	if (sd_do_start_stop(sdkp->device, runtime)) {
diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index 2ba8ec254dce..0787456c2b89 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -436,7 +436,7 @@ int ufshcd_mcq_init(struct ufs_hba *hba)
 
 	for (i = 0; i < hba->nr_hw_queues; i++) {
 		hwq = &hba->uhq[i];
-		hwq->max_entries = hba->nutrs;
+		hwq->max_entries = hba->nutrs + 1;
 		spin_lock_init(&hwq->sq_lock);
 		spin_lock_init(&hwq->cq_lock);
 		mutex_init(&hwq->sq_mutex);
@@ -630,6 +630,7 @@ int ufshcd_mcq_abort(struct scsi_cmnd *cmd)
 	int tag = scsi_cmd_to_rq(cmd)->tag;
 	struct ufshcd_lrb *lrbp = &hba->lrb[tag];
 	struct ufs_hw_queue *hwq;
+	unsigned long flags;
 	int err = FAILED;
 
 	if (!ufshcd_cmd_inflight(lrbp->cmd)) {
@@ -670,8 +671,10 @@ int ufshcd_mcq_abort(struct scsi_cmnd *cmd)
 	}
 
 	err = SUCCESS;
+	spin_lock_irqsave(&hwq->cq_lock, flags);
 	if (ufshcd_cmd_inflight(lrbp->cmd))
 		ufshcd_release_scsi_cmd(hba, lrbp);
+	spin_unlock_irqrestore(&hwq->cq_lock, flags);
 
 out:
 	return err;

