Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6B277A568
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 09:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjHMHYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 03:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjHMHYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 03:24:50 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BB31701;
        Sun, 13 Aug 2023 00:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1691911491;
        bh=LrScp/3f3JWB9dOLcURJc2j1vXGsIYAWl9SOCrU0YO8=;
        h=Message-ID:Subject:From:To:Date:From;
        b=L4AwIXqQEqcSmO6Z/aNqBtqYp/Mr1Lv1c669SuShLxHObEucPbpvSnYvmuv46eKub
         98yn+iO6maCI0H2y4OHH0B4GVSxfc0rsdHRGxDQuaRSHjueVcsoRTWPC0O5KlT+r/M
         lG3OdSVPgmG1gEW4QGDf5Y1QQKNDC/r/amkJA1WA=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id BE8F71281BF5;
        Sun, 13 Aug 2023 03:24:51 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id 4OIt8vo2EI3I; Sun, 13 Aug 2023 03:24:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1691911491;
        bh=LrScp/3f3JWB9dOLcURJc2j1vXGsIYAWl9SOCrU0YO8=;
        h=Message-ID:Subject:From:To:Date:From;
        b=L4AwIXqQEqcSmO6Z/aNqBtqYp/Mr1Lv1c669SuShLxHObEucPbpvSnYvmuv46eKub
         98yn+iO6maCI0H2y4OHH0B4GVSxfc0rsdHRGxDQuaRSHjueVcsoRTWPC0O5KlT+r/M
         lG3OdSVPgmG1gEW4QGDf5Y1QQKNDC/r/amkJA1WA=
Received: from [IPv6:2a00:23c8:1005:a801:e95:68ca:9caa:7c8c] (unknown [IPv6:2a00:23c8:1005:a801:e95:68ca:9caa:7c8c])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 3EAB81281B8F;
        Sun, 13 Aug 2023 03:24:50 -0400 (EDT)
Message-ID: <1541bb28c8ffeec0a22fefbc4babd0dae167b9a5.camel@HansenPartnership.com>
Subject: [GIT PULL v2] SCSI fixes for 6.5-rc5
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Sun, 13 Aug 2023 08:24:47 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Fixed to have the correct merge base picking up 4 extra commits]

Eleven small fixes, ten in drivers.  Of the two fixes marked core, one
is in the raid helper class (used by some raid device drivers) and the
other one is the /proc/scsi/scsi parsing fix for potential reads beyond
the end of the buffer.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Alexandra Diupina (1):
      scsi: 53c700: Check that command slot is not NULL

Chengfeng Ye (1):
      scsi: qedi: Fix potential deadlock on &qedi_percpu->p_work_lock

Justin Tee (1):
      scsi: lpfc: Remove reftag check in DIF paths

Karan Tilak Kumar (1):
      scsi: fnic: Replace return codes in fnic_clean_pending_aborts()

Michael Kelley (1):
      scsi: storvsc: Fix handling of virtual Fibre Channel timeouts

Nilesh Javali (2):
      scsi: qedf: Fix firmware halt over suspend and resume
      scsi: qedi: Fix firmware halt over suspend and resume

Tony Battersby (1):
      scsi: core: Fix legacy /proc parsing buffer overflow

Yoshihiro Shimoda (1):
      scsi: ufs: renesas: Fix private allocation

Zhu Wang (2):
      scsi: snic: Fix possible memory leak if device_add() fails
      scsi: core: Fix possible memory leak if device_add() fails

And the diffstat:

 drivers/scsi/53c700.c          |  2 +-
 drivers/scsi/fnic/fnic.h       |  2 +-
 drivers/scsi/fnic/fnic_scsi.c  |  6 ++++--
 drivers/scsi/lpfc/lpfc_scsi.c  | 20 +++-----------------
 drivers/scsi/qedf/qedf_main.c  | 18 ++++++++++++++++++
 drivers/scsi/qedi/qedi_main.c  | 23 +++++++++++++++++++++--
 drivers/scsi/raid_class.c      |  1 +
 drivers/scsi/scsi_proc.c       | 30 +++++++++++++++++-------------
 drivers/scsi/snic/snic_disc.c  |  1 +
 drivers/scsi/storvsc_drv.c     |  4 ----
 drivers/ufs/host/ufs-renesas.c |  2 +-
 11 files changed, 68 insertions(+), 41 deletions(-)

With full diff below.

James

---

diff --git a/drivers/scsi/53c700.c b/drivers/scsi/53c700.c
index e1e4f9d10887..857be0f3ae5b 100644
--- a/drivers/scsi/53c700.c
+++ b/drivers/scsi/53c700.c
@@ -1598,7 +1598,7 @@ NCR_700_intr(int irq, void *dev_id)
 				printk("scsi%d (%d:%d) PHASE MISMATCH IN SEND MESSAGE %d remain, return %p[%04x], phase %s\n", host->host_no, pun, lun, count, (void *)temp, temp - hostdata->pScript, sbcl_to_string(NCR_700_readb(host, SBCL_REG)));
 #endif
 				resume_offset = hostdata->pScript + Ent_SendMessagePhaseMismatch;
-			} else if(dsp >= to32bit(&slot->pSG[0].ins) &&
+			} else if (slot && dsp >= to32bit(&slot->pSG[0].ins) &&
 				  dsp <= to32bit(&slot->pSG[NCR_700_SG_SEGMENTS].ins)) {
 				int data_transfer = NCR_700_readl(host, DBC_REG) & 0xffffff;
 				int SGcount = (dsp - to32bit(&slot->pSG[0].ins))/sizeof(struct NCR_700_SG_List);
diff --git a/drivers/scsi/fnic/fnic.h b/drivers/scsi/fnic/fnic.h
index d82de34f6fd7..e51e92f932fa 100644
--- a/drivers/scsi/fnic/fnic.h
+++ b/drivers/scsi/fnic/fnic.h
@@ -27,7 +27,7 @@
 
 #define DRV_NAME		"fnic"
 #define DRV_DESCRIPTION		"Cisco FCoE HBA Driver"
-#define DRV_VERSION		"1.6.0.54"
+#define DRV_VERSION		"1.6.0.55"
 #define PFX			DRV_NAME ": "
 #define DFX                     DRV_NAME "%d: "
 
diff --git a/drivers/scsi/fnic/fnic_scsi.c b/drivers/scsi/fnic/fnic_scsi.c
index 26dbd347156e..be89ce96df46 100644
--- a/drivers/scsi/fnic/fnic_scsi.c
+++ b/drivers/scsi/fnic/fnic_scsi.c
@@ -2139,7 +2139,7 @@ static int fnic_clean_pending_aborts(struct fnic *fnic,
 				     bool new_sc)
 
 {
-	int ret = SUCCESS;
+	int ret = 0;
 	struct fnic_pending_aborts_iter_data iter_data = {
 		.fnic = fnic,
 		.lun_dev = lr_sc->device,
@@ -2159,9 +2159,11 @@ static int fnic_clean_pending_aborts(struct fnic *fnic,
 
 	/* walk again to check, if IOs are still pending in fw */
 	if (fnic_is_abts_pending(fnic, lr_sc))
-		ret = FAILED;
+		ret = 1;
 
 clean_pending_aborts_end:
+	FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host,
+			"%s: exit status: %d\n", __func__, ret);
 	return ret;
 }
 
diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index a62e091894f6..d26941b131fd 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -109,8 +109,6 @@ lpfc_sli4_set_rsp_sgl_last(struct lpfc_hba *phba,
 	}
 }
 
-#define LPFC_INVALID_REFTAG ((u32)-1)
-
 /**
  * lpfc_rampdown_queue_depth - Post RAMP_DOWN_QUEUE event to worker thread
  * @phba: The Hba for which this call is being executed.
@@ -978,8 +976,6 @@ lpfc_bg_err_inject(struct lpfc_hba *phba, struct scsi_cmnd *sc,
 
 	sgpe = scsi_prot_sglist(sc);
 	lba = scsi_prot_ref_tag(sc);
-	if (lba == LPFC_INVALID_REFTAG)
-		return 0;
 
 	/* First check if we need to match the LBA */
 	if (phba->lpfc_injerr_lba != LPFC_INJERR_LBA_OFF) {
@@ -1560,8 +1556,6 @@ lpfc_bg_setup_bpl(struct lpfc_hba *phba, struct scsi_cmnd *sc,
 
 	/* extract some info from the scsi command for pde*/
 	reftag = scsi_prot_ref_tag(sc);
-	if (reftag == LPFC_INVALID_REFTAG)
-		goto out;
 
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
 	rc = lpfc_bg_err_inject(phba, sc, &reftag, NULL, 1);
@@ -1723,8 +1717,6 @@ lpfc_bg_setup_bpl_prot(struct lpfc_hba *phba, struct scsi_cmnd *sc,
 	/* extract some info from the scsi command */
 	blksize = scsi_prot_interval(sc);
 	reftag = scsi_prot_ref_tag(sc);
-	if (reftag == LPFC_INVALID_REFTAG)
-		goto out;
 
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
 	rc = lpfc_bg_err_inject(phba, sc, &reftag, NULL, 1);
@@ -1953,8 +1945,6 @@ lpfc_bg_setup_sgl(struct lpfc_hba *phba, struct scsi_cmnd *sc,
 
 	/* extract some info from the scsi command for pde*/
 	reftag = scsi_prot_ref_tag(sc);
-	if (reftag == LPFC_INVALID_REFTAG)
-		goto out;
 
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
 	rc = lpfc_bg_err_inject(phba, sc, &reftag, NULL, 1);
@@ -2154,8 +2144,6 @@ lpfc_bg_setup_sgl_prot(struct lpfc_hba *phba, struct scsi_cmnd *sc,
 	/* extract some info from the scsi command */
 	blksize = scsi_prot_interval(sc);
 	reftag = scsi_prot_ref_tag(sc);
-	if (reftag == LPFC_INVALID_REFTAG)
-		goto out;
 
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
 	rc = lpfc_bg_err_inject(phba, sc, &reftag, NULL, 1);
@@ -2746,8 +2734,6 @@ lpfc_calc_bg_err(struct lpfc_hba *phba, struct lpfc_io_buf *lpfc_cmd)
 
 		src = (struct scsi_dif_tuple *)sg_virt(sgpe);
 		start_ref_tag = scsi_prot_ref_tag(cmd);
-		if (start_ref_tag == LPFC_INVALID_REFTAG)
-			goto out;
 		start_app_tag = src->app_tag;
 		len = sgpe->length;
 		while (src && protsegcnt) {
@@ -3493,11 +3479,11 @@ lpfc_bg_scsi_prep_dma_buf_s4(struct lpfc_hba *phba,
 			     scsi_cmnd->sc_data_direction);
 
 	lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
-			"9084 Cannot setup S/G List for HBA"
-			"IO segs %d/%d SGL %d SCSI %d: %d %d\n",
+			"9084 Cannot setup S/G List for HBA "
+			"IO segs %d/%d SGL %d SCSI %d: %d %d %d\n",
 			lpfc_cmd->seg_cnt, lpfc_cmd->prot_seg_cnt,
 			phba->cfg_total_seg_cnt, phba->cfg_sg_seg_cnt,
-			prot_group_type, num_sge);
+			prot_group_type, num_sge, ret);
 
 	lpfc_cmd->seg_cnt = 0;
 	lpfc_cmd->prot_seg_cnt = 0;
diff --git a/drivers/scsi/qedf/qedf_main.c b/drivers/scsi/qedf/qedf_main.c
index 2a31ddc99dde..7825765c936c 100644
--- a/drivers/scsi/qedf/qedf_main.c
+++ b/drivers/scsi/qedf/qedf_main.c
@@ -31,6 +31,7 @@ static void qedf_remove(struct pci_dev *pdev);
 static void qedf_shutdown(struct pci_dev *pdev);
 static void qedf_schedule_recovery_handler(void *dev);
 static void qedf_recovery_handler(struct work_struct *work);
+static int qedf_suspend(struct pci_dev *pdev, pm_message_t state);
 
 /*
  * Driver module parameters.
@@ -3271,6 +3272,7 @@ static struct pci_driver qedf_pci_driver = {
 	.probe = qedf_probe,
 	.remove = qedf_remove,
 	.shutdown = qedf_shutdown,
+	.suspend = qedf_suspend,
 };
 
 static int __qedf_probe(struct pci_dev *pdev, int mode)
@@ -4000,6 +4002,22 @@ static void qedf_shutdown(struct pci_dev *pdev)
 	__qedf_remove(pdev, QEDF_MODE_NORMAL);
 }
 
+static int qedf_suspend(struct pci_dev *pdev, pm_message_t state)
+{
+	struct qedf_ctx *qedf;
+
+	if (!pdev) {
+		QEDF_ERR(NULL, "pdev is NULL.\n");
+		return -ENODEV;
+	}
+
+	qedf = pci_get_drvdata(pdev);
+
+	QEDF_ERR(&qedf->dbg_ctx, "%s: Device does not support suspend operation\n", __func__);
+
+	return -EPERM;
+}
+
 /*
  * Recovery handler code
  */
diff --git a/drivers/scsi/qedi/qedi_main.c b/drivers/scsi/qedi/qedi_main.c
index 450522b204d6..cd0180b1f5b9 100644
--- a/drivers/scsi/qedi/qedi_main.c
+++ b/drivers/scsi/qedi/qedi_main.c
@@ -69,6 +69,7 @@ static struct nvm_iscsi_block *qedi_get_nvram_block(struct qedi_ctx *qedi);
 static void qedi_recovery_handler(struct work_struct *work);
 static void qedi_schedule_hw_err_handler(void *dev,
 					 enum qed_hw_err_type err_type);
+static int qedi_suspend(struct pci_dev *pdev, pm_message_t state);
 
 static int qedi_iscsi_event_cb(void *context, u8 fw_event_code, void *fw_handle)
 {
@@ -1976,8 +1977,9 @@ static int qedi_cpu_offline(unsigned int cpu)
 	struct qedi_percpu_s *p = this_cpu_ptr(&qedi_percpu);
 	struct qedi_work *work, *tmp;
 	struct task_struct *thread;
+	unsigned long flags;
 
-	spin_lock_bh(&p->p_work_lock);
+	spin_lock_irqsave(&p->p_work_lock, flags);
 	thread = p->iothread;
 	p->iothread = NULL;
 
@@ -1988,7 +1990,7 @@ static int qedi_cpu_offline(unsigned int cpu)
 			kfree(work);
 	}
 
-	spin_unlock_bh(&p->p_work_lock);
+	spin_unlock_irqrestore(&p->p_work_lock, flags);
 	if (thread)
 		kthread_stop(thread);
 	return 0;
@@ -2510,6 +2512,22 @@ static void qedi_shutdown(struct pci_dev *pdev)
 	__qedi_remove(pdev, QEDI_MODE_SHUTDOWN);
 }
 
+static int qedi_suspend(struct pci_dev *pdev, pm_message_t state)
+{
+	struct qedi_ctx *qedi;
+
+	if (!pdev) {
+		QEDI_ERR(NULL, "pdev is NULL.\n");
+		return -ENODEV;
+	}
+
+	qedi = pci_get_drvdata(pdev);
+
+	QEDI_ERR(&qedi->dbg_ctx, "%s: Device does not support suspend operation\n", __func__);
+
+	return -EPERM;
+}
+
 static int __qedi_probe(struct pci_dev *pdev, int mode)
 {
 	struct qedi_ctx *qedi;
@@ -2868,6 +2886,7 @@ static struct pci_driver qedi_pci_driver = {
 	.remove = qedi_remove,
 	.shutdown = qedi_shutdown,
 	.err_handler = &qedi_err_handler,
+	.suspend = qedi_suspend,
 };
 
 static int __init qedi_init(void)
diff --git a/drivers/scsi/raid_class.c b/drivers/scsi/raid_class.c
index 898a0bdf8df6..711252e52d8e 100644
--- a/drivers/scsi/raid_class.c
+++ b/drivers/scsi/raid_class.c
@@ -248,6 +248,7 @@ int raid_component_add(struct raid_template *r,struct device *raid_dev,
 	return 0;
 
 err_out:
+	put_device(&rc->dev);
 	list_del(&rc->node);
 	rd->component_count--;
 	put_device(component_dev);
diff --git a/drivers/scsi/scsi_proc.c b/drivers/scsi/scsi_proc.c
index 4a6eb1741be0..41f23cd0bfb4 100644
--- a/drivers/scsi/scsi_proc.c
+++ b/drivers/scsi/scsi_proc.c
@@ -406,7 +406,7 @@ static ssize_t proc_scsi_write(struct file *file, const char __user *buf,
 			       size_t length, loff_t *ppos)
 {
 	int host, channel, id, lun;
-	char *buffer, *p;
+	char *buffer, *end, *p;
 	int err;
 
 	if (!buf || length > PAGE_SIZE)
@@ -421,10 +421,14 @@ static ssize_t proc_scsi_write(struct file *file, const char __user *buf,
 		goto out;
 
 	err = -EINVAL;
-	if (length < PAGE_SIZE)
-		buffer[length] = '\0';
-	else if (buffer[PAGE_SIZE-1])
-		goto out;
+	if (length < PAGE_SIZE) {
+		end = buffer + length;
+		*end = '\0';
+	} else {
+		end = buffer + PAGE_SIZE - 1;
+		if (*end)
+			goto out;
+	}
 
 	/*
 	 * Usage: echo "scsi add-single-device 0 1 2 3" >/proc/scsi/scsi
@@ -433,10 +437,10 @@ static ssize_t proc_scsi_write(struct file *file, const char __user *buf,
 	if (!strncmp("scsi add-single-device", buffer, 22)) {
 		p = buffer + 23;
 
-		host = simple_strtoul(p, &p, 0);
-		channel = simple_strtoul(p + 1, &p, 0);
-		id = simple_strtoul(p + 1, &p, 0);
-		lun = simple_strtoul(p + 1, &p, 0);
+		host    = (p     < end) ? simple_strtoul(p, &p, 0) : 0;
+		channel = (p + 1 < end) ? simple_strtoul(p + 1, &p, 0) : 0;
+		id      = (p + 1 < end) ? simple_strtoul(p + 1, &p, 0) : 0;
+		lun     = (p + 1 < end) ? simple_strtoul(p + 1, &p, 0) : 0;
 
 		err = scsi_add_single_device(host, channel, id, lun);
 
@@ -447,10 +451,10 @@ static ssize_t proc_scsi_write(struct file *file, const char __user *buf,
 	} else if (!strncmp("scsi remove-single-device", buffer, 25)) {
 		p = buffer + 26;
 
-		host = simple_strtoul(p, &p, 0);
-		channel = simple_strtoul(p + 1, &p, 0);
-		id = simple_strtoul(p + 1, &p, 0);
-		lun = simple_strtoul(p + 1, &p, 0);
+		host    = (p     < end) ? simple_strtoul(p, &p, 0) : 0;
+		channel = (p + 1 < end) ? simple_strtoul(p + 1, &p, 0) : 0;
+		id      = (p + 1 < end) ? simple_strtoul(p + 1, &p, 0) : 0;
+		lun     = (p + 1 < end) ? simple_strtoul(p + 1, &p, 0) : 0;
 
 		err = scsi_remove_single_device(host, channel, id, lun);
 	}
diff --git a/drivers/scsi/snic/snic_disc.c b/drivers/scsi/snic/snic_disc.c
index 3e2e5783924d..e429ad23c396 100644
--- a/drivers/scsi/snic/snic_disc.c
+++ b/drivers/scsi/snic/snic_disc.c
@@ -303,6 +303,7 @@ snic_tgt_create(struct snic *snic, struct snic_tgt_id *tgtid)
 			      "Snic Tgt: device_add, with err = %d\n",
 			      ret);
 
+		put_device(&tgt->dev);
 		put_device(&snic->shost->shost_gendev);
 		spin_lock_irqsave(snic->shost->host_lock, flags);
 		list_del(&tgt->list);
diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index f2823218670a..047ffaf7d42a 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1674,10 +1674,6 @@ static int storvsc_host_reset_handler(struct scsi_cmnd *scmnd)
  */
 static enum scsi_timeout_action storvsc_eh_timed_out(struct scsi_cmnd *scmnd)
 {
-#if IS_ENABLED(CONFIG_SCSI_FC_ATTRS)
-	if (scmnd->device->host->transportt == fc_transport_template)
-		return fc_eh_timed_out(scmnd);
-#endif
 	return SCSI_EH_RESET_TIMER;
 }
 
diff --git a/drivers/ufs/host/ufs-renesas.c b/drivers/ufs/host/ufs-renesas.c
index f8a5e79ed3b4..ab0652d8705a 100644
--- a/drivers/ufs/host/ufs-renesas.c
+++ b/drivers/ufs/host/ufs-renesas.c
@@ -359,7 +359,7 @@ static int ufs_renesas_init(struct ufs_hba *hba)
 {
 	struct ufs_renesas_priv *priv;
 
-	priv = devm_kmalloc(hba->dev, sizeof(*priv), GFP_KERNEL);
+	priv = devm_kzalloc(hba->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 	ufshcd_set_variant(hba, priv);

