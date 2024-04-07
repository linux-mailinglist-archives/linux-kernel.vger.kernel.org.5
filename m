Return-Path: <linux-kernel+bounces-134417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D4B89B13E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C56FF281998
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2164537E6;
	Sun,  7 Apr 2024 13:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RmnWRdnC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF6452F7D;
	Sun,  7 Apr 2024 13:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495501; cv=none; b=I1MOv32wySaZxt6IEJdXsg6/7CMLrf1yfXPsMDFj6xZ9k/FiOohqE/LUhNUOZnAE+TKZ0k1KQsu/F42LCfXdRhOpUdUoEn3e5WCJryaLFUTF2CuYdFAt6OV7ydWKeirccZvg3NzSGBZ+AxDPumdcDGSUEToGFbIawVk2FuQiejE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495501; c=relaxed/simple;
	bh=7HKnDkjbN7wVIAs9pKtsT904pSc1EH39QCVIhU/HJBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VdtBTBvr/I4KUff5vixBCZhO5ze7S5A48qcfx1/NYKYYFGfwFt7oBC9f+i2sevjQ37wQ8KpM8bDD6rXRw3SkWt4TU07U9E4YKwr/A1l4pqQfkXdF+ZPEH+27eP3Z6bAeCDOUOwvyoOmvapqtaRxPMlmouVNTWe0cJG9+ntR5oHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RmnWRdnC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51AD6C43399;
	Sun,  7 Apr 2024 13:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712495501;
	bh=7HKnDkjbN7wVIAs9pKtsT904pSc1EH39QCVIhU/HJBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RmnWRdnCD6RfG+RRtagEloN15mblD7qse7PUdT03G8QYVfPQDm2+P7fooyoiQ2Cpj
	 RDTV2mT/9ZY1p8TTE2omcymNE/x3htMJqddlgCY9X483sP521B/1aGN4O477NcEKfi
	 28txTMow/EZqbP1M+UkfOJfogB6SCPXsRc3DQzgqaXr+5xSChBiPgmpAvQ8UabRR0/
	 1Chz2oizQmTbUBvPa86Dnbp4km3O0BNpaxHRMapOYA12lS0iucr0fxiUBzztch655v
	 QY0ouEoiR6PzkBFt2JpSbxCPMdlI8nZJKHtzt0wYF2nt2VUX+YmGxavs6hu9Yvs/UI
	 TDI7aPyex8l4A==
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
Subject: [PATCH AUTOSEL 6.8 07/25] scsi: lpfc: Use a dedicated lock for ras_fwlog state
Date: Sun,  7 Apr 2024 09:10:55 -0400
Message-ID: <20240407131130.1050321-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240407131130.1050321-1-sashal@kernel.org>
References: <20240407131130.1050321-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.4
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
index d3a5d6ecdf7d2..6f97a04171c44 100644
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
index 7820a1a7aa6d1..858ca395c0bf0 100644
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
index c00b945947b1d..e1821072552a5 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -6849,9 +6849,9 @@ lpfc_ras_stop_fwlog(struct lpfc_hba *phba)
 {
 	struct lpfc_ras_fwlog *ras_fwlog = &phba->ras_fwlog;
 
-	spin_lock_irq(&phba->hbalock);
+	spin_lock_irq(&phba->ras_fwlog_lock);
 	ras_fwlog->state = INACTIVE;
-	spin_unlock_irq(&phba->hbalock);
+	spin_unlock_irq(&phba->ras_fwlog_lock);
 
 	/* Disable FW logging to host memory */
 	writel(LPFC_CTL_PDEV_CTL_DDL_RAS,
@@ -6894,9 +6894,9 @@ lpfc_sli4_ras_dma_free(struct lpfc_hba *phba)
 		ras_fwlog->lwpd.virt = NULL;
 	}
 
-	spin_lock_irq(&phba->hbalock);
+	spin_lock_irq(&phba->ras_fwlog_lock);
 	ras_fwlog->state = INACTIVE;
-	spin_unlock_irq(&phba->hbalock);
+	spin_unlock_irq(&phba->ras_fwlog_lock);
 }
 
 /**
@@ -6998,9 +6998,9 @@ lpfc_sli4_ras_mbox_cmpl(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 		goto disable_ras;
 	}
 
-	spin_lock_irq(&phba->hbalock);
+	spin_lock_irq(&phba->ras_fwlog_lock);
 	ras_fwlog->state = ACTIVE;
-	spin_unlock_irq(&phba->hbalock);
+	spin_unlock_irq(&phba->ras_fwlog_lock);
 	mempool_free(pmb, phba->mbox_mem_pool);
 
 	return;
@@ -7032,9 +7032,9 @@ lpfc_sli4_ras_fwlog_init(struct lpfc_hba *phba,
 	uint32_t len = 0, fwlog_buffsize, fwlog_entry_count;
 	int rc = 0;
 
-	spin_lock_irq(&phba->hbalock);
+	spin_lock_irq(&phba->ras_fwlog_lock);
 	ras_fwlog->state = INACTIVE;
-	spin_unlock_irq(&phba->hbalock);
+	spin_unlock_irq(&phba->ras_fwlog_lock);
 
 	fwlog_buffsize = (LPFC_RAS_MIN_BUFF_POST_SIZE *
 			  phba->cfg_ras_fwlog_buffsize);
@@ -7095,9 +7095,9 @@ lpfc_sli4_ras_fwlog_init(struct lpfc_hba *phba,
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


