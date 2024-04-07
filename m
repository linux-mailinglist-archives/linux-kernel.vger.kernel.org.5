Return-Path: <linux-kernel+bounces-134442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE7889B18B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C5D31C20C64
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D847E590;
	Sun,  7 Apr 2024 13:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ogrEm93/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F287E563;
	Sun,  7 Apr 2024 13:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495562; cv=none; b=AjW9M0YZQZ2xwMntMkxYrJ+Dw3t+/yHRgcI952J/0Ukg3GGDBoT1Gvu2ZInKi0/lSzhS219mQFsxjGJv1n4w6D0643QnBEkQfVZolSj0ENnNGr0BtIVG9ElwO44YnR4Zg0TnHTW+xxkcabI7II7lHIVzTypOIL+O3d+liP2qE7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495562; c=relaxed/simple;
	bh=0OpaY3f1UokZUbnZwDjdWqN3plIkjyGbW6ru4XC/ri8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=suI1aQYTM9xJRCNaydjFp7hzxO/ZL7UeYp/YpPH8bEppKpJxfp638EOKJen6/Dy3qWx/JmunU0O2Kh/vZ0TwrF5M2xgVewHaXR95WDv6DLbu9t9HxiJ107B4eK37FMj8QrBidC1OazdC/1SSxEQ8uE8j0bgY9mRZwsZISkM9w48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ogrEm93/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 336CDC433F1;
	Sun,  7 Apr 2024 13:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712495562;
	bh=0OpaY3f1UokZUbnZwDjdWqN3plIkjyGbW6ru4XC/ri8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ogrEm93/Sq2dDm2LTXwQqZIgPoWBkM03b52YZHtTMC8RdXjTq0V6+9lmzwjUqjV69
	 EwsxLkU4khacej559GheM0RjY11wqNRi0AjXLbQIkxCe94U3SXPzXP2ATjHDbaMFwd
	 WMzG0uFwafI4piwAcQRS9s6VlatAC3bCtYXnf1osva2f91U5W+B5I+RRQsZ7RkkLGf
	 r/qAFE2mFNWdDHMW4xD5aXCBhIFdNk+9bf6EovnFqxLiGYWyZWt3iTvXh8KkyRoe/b
	 fdSVgGEpawzqHzZ3krwJlARH3X6oBQ6o8BuI9gSD+C/bWLySaYghYlNC41vHiDsqK6
	 z0syoLJoB+W4A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Justin Tee <justin.tee@broadcom.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	james.smart@broadcom.com,
	dick.kennedy@broadcom.com,
	jejb@linux.ibm.com,
	linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 07/22] scsi: lpfc: Use a dedicated lock for ras_fwlog state
Date: Sun,  7 Apr 2024 09:12:06 -0400
Message-ID: <20240407131231.1051652-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240407131231.1051652-1-sashal@kernel.org>
References: <20240407131231.1051652-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.25
Content-Transfer-Encoding: 8bit

From: Justin Tee <justin.tee@broadcom.com>

[ Upstream commit f733a76ea0a9a84aee4ac41b81fad4d610ecbd8e ]

To reduce usage of and contention for hbalock, a separate dedicated lock is
used to protect ras_fwlog state.

Signed-off-by: Justin Tee <justin.tee@broadcom.com>
Link: https://lore.kernel.org/r/20240305200503.57317-8-justintee8345@gmail.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/lpfc/lpfc.h         |  1 +
 drivers/scsi/lpfc/lpfc_attr.c    |  4 ++--
 drivers/scsi/lpfc/lpfc_bsg.c     | 20 ++++++++++----------
 drivers/scsi/lpfc/lpfc_debugfs.c | 12 ++++++------
 drivers/scsi/lpfc/lpfc_init.c    |  3 +++
 drivers/scsi/lpfc/lpfc_sli.c     | 20 ++++++++++----------
 6 files changed, 32 insertions(+), 28 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc.h b/drivers/scsi/lpfc/lpfc.h
index be016732ab2ea..9670cb2bf198e 100644
--- a/drivers/scsi/lpfc/lpfc.h
+++ b/drivers/scsi/lpfc/lpfc.h
@@ -1429,6 +1429,7 @@ struct lpfc_hba {
 	struct timer_list inactive_vmid_poll;
 
 	/* RAS Support */
+	spinlock_t ras_fwlog_lock; /* do not take while holding another lock */
 	struct lpfc_ras_fwlog ras_fwlog;
 
 	uint32_t iocb_cnt;
diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
index b1c9107d34083..79b45ea5fdb5e 100644
--- a/drivers/scsi/lpfc/lpfc_attr.c
+++ b/drivers/scsi/lpfc/lpfc_attr.c
@@ -5864,9 +5864,9 @@ lpfc_ras_fwlog_buffsize_set(struct lpfc_hba  *phba, uint val)
 	if (phba->cfg_ras_fwlog_func != PCI_FUNC(phba->pcidev->devfn))
 		return -EINVAL;
 
-	spin_lock_irq(&phba->hbalock);
+	spin_lock_irq(&phba->ras_fwlog_lock);
 	state = phba->ras_fwlog.state;
-	spin_unlock_irq(&phba->hbalock);
+	spin_unlock_irq(&phba->ras_fwlog_lock);
 
 	if (state == REG_INPROGRESS) {
 		lpfc_printf_log(phba, KERN_ERR, LOG_SLI, "6147 RAS Logging "
diff --git a/drivers/scsi/lpfc/lpfc_bsg.c b/drivers/scsi/lpfc/lpfc_bsg.c
index 595dca92e8db5..593b1cf78979e 100644
--- a/drivers/scsi/lpfc/lpfc_bsg.c
+++ b/drivers/scsi/lpfc/lpfc_bsg.c
@@ -5070,12 +5070,12 @@ lpfc_bsg_get_ras_config(struct bsg_job *job)
 		bsg_reply->reply_data.vendor_reply.vendor_rsp;
 
 	/* Current logging state */
-	spin_lock_irq(&phba->hbalock);
+	spin_lock_irq(&phba->ras_fwlog_lock);
 	if (ras_fwlog->state == ACTIVE)
 		ras_reply->state = LPFC_RASLOG_STATE_RUNNING;
 	else
 		ras_reply->state = LPFC_RASLOG_STATE_STOPPED;
-	spin_unlock_irq(&phba->hbalock);
+	spin_unlock_irq(&phba->ras_fwlog_lock);
 
 	ras_reply->log_level = phba->ras_fwlog.fw_loglevel;
 	ras_reply->log_buff_sz = phba->cfg_ras_fwlog_buffsize;
@@ -5132,13 +5132,13 @@ lpfc_bsg_set_ras_config(struct bsg_job *job)
 
 	if (action == LPFC_RASACTION_STOP_LOGGING) {
 		/* Check if already disabled */
-		spin_lock_irq(&phba->hbalock);
+		spin_lock_irq(&phba->ras_fwlog_lock);
 		if (ras_fwlog->state != ACTIVE) {
-			spin_unlock_irq(&phba->hbalock);
+			spin_unlock_irq(&phba->ras_fwlog_lock);
 			rc = -ESRCH;
 			goto ras_job_error;
 		}
-		spin_unlock_irq(&phba->hbalock);
+		spin_unlock_irq(&phba->ras_fwlog_lock);
 
 		/* Disable logging */
 		lpfc_ras_stop_fwlog(phba);
@@ -5149,10 +5149,10 @@ lpfc_bsg_set_ras_config(struct bsg_job *job)
 		 * FW-logging with new log-level. Return status
 		 * "Logging already Running" to caller.
 		 **/
-		spin_lock_irq(&phba->hbalock);
+		spin_lock_irq(&phba->ras_fwlog_lock);
 		if (ras_fwlog->state != INACTIVE)
 			action_status = -EINPROGRESS;
-		spin_unlock_irq(&phba->hbalock);
+		spin_unlock_irq(&phba->ras_fwlog_lock);
 
 		/* Enable logging */
 		rc = lpfc_sli4_ras_fwlog_init(phba, log_level,
@@ -5268,13 +5268,13 @@ lpfc_bsg_get_ras_fwlog(struct bsg_job *job)
 		goto ras_job_error;
 
 	/* Logging to be stopped before reading */
-	spin_lock_irq(&phba->hbalock);
+	spin_lock_irq(&phba->ras_fwlog_lock);
 	if (ras_fwlog->state == ACTIVE) {
-		spin_unlock_irq(&phba->hbalock);
+		spin_unlock_irq(&phba->ras_fwlog_lock);
 		rc = -EINPROGRESS;
 		goto ras_job_error;
 	}
-	spin_unlock_irq(&phba->hbalock);
+	spin_unlock_irq(&phba->ras_fwlog_lock);
 
 	if (job->request_len <
 	    sizeof(struct fc_bsg_request) +
diff --git a/drivers/scsi/lpfc/lpfc_debugfs.c b/drivers/scsi/lpfc/lpfc_debugfs.c
index ea9b42225e629..20662b4f339eb 100644
--- a/drivers/scsi/lpfc/lpfc_debugfs.c
+++ b/drivers/scsi/lpfc/lpfc_debugfs.c
@@ -2196,12 +2196,12 @@ static int lpfc_debugfs_ras_log_data(struct lpfc_hba *phba,
 
 	memset(buffer, 0, size);
 
-	spin_lock_irq(&phba->hbalock);
+	spin_lock_irq(&phba->ras_fwlog_lock);
 	if (phba->ras_fwlog.state != ACTIVE) {
-		spin_unlock_irq(&phba->hbalock);
+		spin_unlock_irq(&phba->ras_fwlog_lock);
 		return -EINVAL;
 	}
-	spin_unlock_irq(&phba->hbalock);
+	spin_unlock_irq(&phba->ras_fwlog_lock);
 
 	list_for_each_entry_safe(dmabuf, next,
 				 &phba->ras_fwlog.fwlog_buff_list, list) {
@@ -2252,13 +2252,13 @@ lpfc_debugfs_ras_log_open(struct inode *inode, struct file *file)
 	int size;
 	int rc = -ENOMEM;
 
-	spin_lock_irq(&phba->hbalock);
+	spin_lock_irq(&phba->ras_fwlog_lock);
 	if (phba->ras_fwlog.state != ACTIVE) {
-		spin_unlock_irq(&phba->hbalock);
+		spin_unlock_irq(&phba->ras_fwlog_lock);
 		rc = -EINVAL;
 		goto out;
 	}
-	spin_unlock_irq(&phba->hbalock);
+	spin_unlock_irq(&phba->ras_fwlog_lock);
 
 	if (check_mul_overflow(LPFC_RAS_MIN_BUFF_POST_SIZE,
 			       phba->cfg_ras_fwlog_buffsize, &size))
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 76c883cc66ed6..416816d74ea1c 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -7698,6 +7698,9 @@ lpfc_setup_driver_resource_phase1(struct lpfc_hba *phba)
 				"NVME" : " "),
 			(phba->nvmet_support ? "NVMET" : " "));
 
+	/* ras_fwlog state */
+	spin_lock_init(&phba->ras_fwlog_lock);
+
 	/* Initialize the IO buffer list used by driver for SLI3 SCSI */
 	spin_lock_init(&phba->scsi_buf_list_get_lock);
 	INIT_LIST_HEAD(&phba->lpfc_scsi_buf_list_get);
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 9dab33686a931..5af669b930193 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -6844,9 +6844,9 @@ lpfc_ras_stop_fwlog(struct lpfc_hba *phba)
 {
 	struct lpfc_ras_fwlog *ras_fwlog = &phba->ras_fwlog;
 
-	spin_lock_irq(&phba->hbalock);
+	spin_lock_irq(&phba->ras_fwlog_lock);
 	ras_fwlog->state = INACTIVE;
-	spin_unlock_irq(&phba->hbalock);
+	spin_unlock_irq(&phba->ras_fwlog_lock);
 
 	/* Disable FW logging to host memory */
 	writel(LPFC_CTL_PDEV_CTL_DDL_RAS,
@@ -6889,9 +6889,9 @@ lpfc_sli4_ras_dma_free(struct lpfc_hba *phba)
 		ras_fwlog->lwpd.virt = NULL;
 	}
 
-	spin_lock_irq(&phba->hbalock);
+	spin_lock_irq(&phba->ras_fwlog_lock);
 	ras_fwlog->state = INACTIVE;
-	spin_unlock_irq(&phba->hbalock);
+	spin_unlock_irq(&phba->ras_fwlog_lock);
 }
 
 /**
@@ -6993,9 +6993,9 @@ lpfc_sli4_ras_mbox_cmpl(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 		goto disable_ras;
 	}
 
-	spin_lock_irq(&phba->hbalock);
+	spin_lock_irq(&phba->ras_fwlog_lock);
 	ras_fwlog->state = ACTIVE;
-	spin_unlock_irq(&phba->hbalock);
+	spin_unlock_irq(&phba->ras_fwlog_lock);
 	mempool_free(pmb, phba->mbox_mem_pool);
 
 	return;
@@ -7027,9 +7027,9 @@ lpfc_sli4_ras_fwlog_init(struct lpfc_hba *phba,
 	uint32_t len = 0, fwlog_buffsize, fwlog_entry_count;
 	int rc = 0;
 
-	spin_lock_irq(&phba->hbalock);
+	spin_lock_irq(&phba->ras_fwlog_lock);
 	ras_fwlog->state = INACTIVE;
-	spin_unlock_irq(&phba->hbalock);
+	spin_unlock_irq(&phba->ras_fwlog_lock);
 
 	fwlog_buffsize = (LPFC_RAS_MIN_BUFF_POST_SIZE *
 			  phba->cfg_ras_fwlog_buffsize);
@@ -7090,9 +7090,9 @@ lpfc_sli4_ras_fwlog_init(struct lpfc_hba *phba,
 	mbx_fwlog->u.request.lwpd.addr_lo = putPaddrLow(ras_fwlog->lwpd.phys);
 	mbx_fwlog->u.request.lwpd.addr_hi = putPaddrHigh(ras_fwlog->lwpd.phys);
 
-	spin_lock_irq(&phba->hbalock);
+	spin_lock_irq(&phba->ras_fwlog_lock);
 	ras_fwlog->state = REG_INPROGRESS;
-	spin_unlock_irq(&phba->hbalock);
+	spin_unlock_irq(&phba->ras_fwlog_lock);
 	mbox->vport = phba->pport;
 	mbox->mbox_cmpl = lpfc_sli4_ras_mbox_cmpl;
 
-- 
2.43.0


