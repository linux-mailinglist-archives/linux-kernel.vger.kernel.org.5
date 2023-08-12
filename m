Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41C4779DC7
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 08:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjHLGpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 02:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjHLGpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 02:45:21 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C25213B
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 23:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1691822716;
        bh=HR3jOraXl1XZg2svBUjpwKgXfc9KMBYMRqJiRCrbKQc=;
        h=Message-ID:Subject:From:To:Date:From;
        b=BwKGsl1z8/o9L+kixz5x72MzA0A8K9gApk4goTxIQM/7J7ojtTlsyrm8qsyejwckV
         WQcYWn/K29fl11rVMdSu5TQ+AMwb/W+7Hla2uHVLlL8pUbU2K2JmGWyr72L7hHq+Ji
         UAXjfn4smi4zjV+/Hy+iwJwhilh976TxWA/OAzjc=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id DF99D128148B;
        Sat, 12 Aug 2023 02:45:16 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id 7WnYpx9648IH; Sat, 12 Aug 2023 02:45:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1691822716;
        bh=HR3jOraXl1XZg2svBUjpwKgXfc9KMBYMRqJiRCrbKQc=;
        h=Message-ID:Subject:From:To:Date:From;
        b=BwKGsl1z8/o9L+kixz5x72MzA0A8K9gApk4goTxIQM/7J7ojtTlsyrm8qsyejwckV
         WQcYWn/K29fl11rVMdSu5TQ+AMwb/W+7Hla2uHVLlL8pUbU2K2JmGWyr72L7hHq+Ji
         UAXjfn4smi4zjV+/Hy+iwJwhilh976TxWA/OAzjc=
Received: from [192.168.82.22] (unknown [172.58.142.188])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 4E0F21280889;
        Sat, 12 Aug 2023 02:45:15 -0400 (EDT)
Message-ID: <4987ff9fa2467bc036759afac47b95c77a415963.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 6.5-rc5
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Sat, 12 Aug 2023 07:45:11 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Seven small fixes, all in drivers (the one labelled core is actually an
error leg fix in the raid helper class).

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Chengfeng Ye (1):
      scsi: qedi: Fix potential deadlock on &qedi_percpu->p_work_lock

Justin Tee (1):
      scsi: lpfc: Remove reftag check in DIF paths

Nilesh Javali (2):
      scsi: qedf: Fix firmware halt over suspend and resume
      scsi: qedi: Fix firmware halt over suspend and resume

Yoshihiro Shimoda (1):
      scsi: ufs: renesas: Fix private allocation

Zhu Wang (2):
      scsi: snic: Fix possible memory leak if device_add() fails
      scsi: core: Fix possible memory leak if device_add() fails

And the diffstat:

 drivers/scsi/lpfc/lpfc_scsi.c  | 20 +++-----------------
 drivers/scsi/qedf/qedf_main.c  | 18 ++++++++++++++++++
 drivers/scsi/qedi/qedi_main.c  | 23 +++++++++++++++++++++--
 drivers/scsi/raid_class.c      |  1 +
 drivers/scsi/snic/snic_disc.c  |  1 +
 drivers/ufs/host/ufs-renesas.c |  2 +-
 6 files changed, 45 insertions(+), 20 deletions(-)

With full diff below.

James

---

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

