Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69F67FFC6F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 21:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376711AbjK3U2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 15:28:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjK3U2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 15:28:30 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F7B10FF;
        Thu, 30 Nov 2023 12:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1701376114;
        bh=h309xXu2AysR4RABR++0kkIEHwY0IMWt9+lOUwuKroc=;
        h=Message-ID:Subject:From:To:Date:From;
        b=HjCDzUdQ1jMBM43jHrwZ/FPzrWSrpPDBMdFksXPsqLgcCEgZHujsLLfxNzAJpNLdo
         2JD865HkLPAUjeMsiMqin375X2EC3UOJhJaNGZHb/Qj71Z5yZxOGkhJUHy11uXn3ZW
         EmhTpDjOJZkQHAVqk7Y3EjFd9u8HzxM6080b2X6s=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 18A23128711F;
        Thu, 30 Nov 2023 15:28:34 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id 16WYGNpV01Ju; Thu, 30 Nov 2023 15:28:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1701376113;
        bh=h309xXu2AysR4RABR++0kkIEHwY0IMWt9+lOUwuKroc=;
        h=Message-ID:Subject:From:To:Date:From;
        b=Qv7AdGnkNBVIGgpdGPP/B6pGx6knSkqjZ0o7IRPA4Fh5yzka4cBPPak4R6YrtEezO
         kq1tUQQSinOZKWYzNKra4cEuO8DLKJAQgQQ9M736bSp62ccAtqVFQtgsDCkL44DJJ2
         RArdEYUY8IKHwO0bWQVQJBGLFFRbkFNUSuh+s3t8=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 145741286906;
        Thu, 30 Nov 2023 15:28:33 -0500 (EST)
Message-ID: <ba9a6adb96ce110b1a74c6161fa58415049d5ef6.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 6.7-rc3
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Thu, 30 Nov 2023 15:28:27 -0500
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

3 small fixes, one in drivers.  The core changes are to the internal
representation of flags in scsi_devices which removes space wasting
bools in favour of single bit flags and to add a flag to force a
runtime resume which is used by ATA devices.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Damien Le Moal (2):
      scsi: sd: Fix system start for ATA devices
      scsi: Change SCSI device boolean fields to single bit flags

Peter Wang (1):
      scsi: ufs: core: Clear cmd if abort succeeds in MCQ mode

And the diffstat:

 drivers/ata/libata-scsi.c  |  9 +++++++--
 drivers/firewire/sbp2.c    |  6 +++---
 drivers/scsi/sd.c          |  9 ++++++++-
 drivers/ufs/core/ufshcd.c  | 13 +++++++++++++
 include/scsi/scsi_device.h | 12 +++++++++---
 5 files changed, 40 insertions(+), 9 deletions(-)

With full diff below

James

---

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index c10ff8985203..0a0f483124c3 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1055,9 +1055,14 @@ int ata_scsi_dev_config(struct scsi_device *sdev, struct ata_device *dev)
 		 * Ask the sd driver to issue START STOP UNIT on runtime suspend
 		 * and resume and shutdown only. For system level suspend/resume,
 		 * devices power state is handled directly by libata EH.
+		 * Given that disks are always spun up on system resume, also
+		 * make sure that the sd driver forces runtime suspended disks
+		 * to be resumed to correctly reflect the power state of the
+		 * device.
 		 */
-		sdev->manage_runtime_start_stop = true;
-		sdev->manage_shutdown = true;
+		sdev->manage_runtime_start_stop = 1;
+		sdev->manage_shutdown = 1;
+		sdev->force_runtime_start_on_system_start = 1;
 	}
 
 	/*
diff --git a/drivers/firewire/sbp2.c b/drivers/firewire/sbp2.c
index 7edf2c95282f..e779d866022b 100644
--- a/drivers/firewire/sbp2.c
+++ b/drivers/firewire/sbp2.c
@@ -1519,9 +1519,9 @@ static int sbp2_scsi_slave_configure(struct scsi_device *sdev)
 	sdev->use_10_for_rw = 1;
 
 	if (sbp2_param_exclusive_login) {
-		sdev->manage_system_start_stop = true;
-		sdev->manage_runtime_start_stop = true;
-		sdev->manage_shutdown = true;
+		sdev->manage_system_start_stop = 1;
+		sdev->manage_runtime_start_stop = 1;
+		sdev->manage_shutdown = 1;
 	}
 
 	if (sdev->type == TYPE_ROM)
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index fa00dd503cbf..542a4bbb21bc 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3949,8 +3949,15 @@ static int sd_resume(struct device *dev, bool runtime)
 
 static int sd_resume_system(struct device *dev)
 {
-	if (pm_runtime_suspended(dev))
+	if (pm_runtime_suspended(dev)) {
+		struct scsi_disk *sdkp = dev_get_drvdata(dev);
+		struct scsi_device *sdp = sdkp ? sdkp->device : NULL;
+
+		if (sdp && sdp->force_runtime_start_on_system_start)
+			pm_request_resume(dev);
+
 		return 0;
+	}
 
 	return sd_resume(dev, false);
 }
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 8b1031fb0a44..bce0d2a9a7f3 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -6444,11 +6444,24 @@ static bool ufshcd_abort_one(struct request *rq, void *priv)
 	struct scsi_device *sdev = cmd->device;
 	struct Scsi_Host *shost = sdev->host;
 	struct ufs_hba *hba = shost_priv(shost);
+	struct ufshcd_lrb *lrbp = &hba->lrb[tag];
+	struct ufs_hw_queue *hwq;
+	unsigned long flags;
 
 	*ret = ufshcd_try_to_abort_task(hba, tag);
 	dev_err(hba->dev, "Aborting tag %d / CDB %#02x %s\n", tag,
 		hba->lrb[tag].cmd ? hba->lrb[tag].cmd->cmnd[0] : -1,
 		*ret ? "failed" : "succeeded");
+
+	/* Release cmd in MCQ mode if abort succeeds */
+	if (is_mcq_enabled(hba) && (*ret == 0)) {
+		hwq = ufshcd_mcq_req_to_hwq(hba, scsi_cmd_to_rq(lrbp->cmd));
+		spin_lock_irqsave(&hwq->cq_lock, flags);
+		if (ufshcd_cmd_inflight(lrbp->cmd))
+			ufshcd_release_scsi_cmd(hba, lrbp);
+		spin_unlock_irqrestore(&hwq->cq_lock, flags);
+	}
+
 	return *ret == 0;
 }
 
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index 10480eb582b2..5ec1e71a09de 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -167,19 +167,25 @@ struct scsi_device {
 	 * power state for system suspend/resume (suspend to RAM and
 	 * hibernation) operations.
 	 */
-	bool manage_system_start_stop;
+	unsigned manage_system_start_stop:1;
 
 	/*
 	 * If true, let the high-level device driver (sd) manage the device
 	 * power state for runtime device suspand and resume operations.
 	 */
-	bool manage_runtime_start_stop;
+	unsigned manage_runtime_start_stop:1;
 
 	/*
 	 * If true, let the high-level device driver (sd) manage the device
 	 * power state for system shutdown (power off) operations.
 	 */
-	bool manage_shutdown;
+	unsigned manage_shutdown:1;
+
+	/*
+	 * If set and if the device is runtime suspended, ask the high-level
+	 * device driver (sd) to force a runtime resume of the device.
+	 */
+	unsigned force_runtime_start_on_system_start:1;
 
 	unsigned removable:1;
 	unsigned changed:1;	/* Data invalid due to media change */

