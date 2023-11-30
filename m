Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F6B7FE6E0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 03:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344187AbjK3CgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 21:36:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbjK3CgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 21:36:04 -0500
Received: from rcdn-iport-8.cisco.com (rcdn-iport-8.cisco.com [173.37.86.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCE3D7D;
        Wed, 29 Nov 2023 18:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=15630; q=dns/txt;
  s=iport; t=1701311769; x=1702521369;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QCEmKX9TIcPoV3/PSECpINdzC3oCXavPfC2ME80WU0Q=;
  b=HJ54TSSTN5s9NT7gqpXKB8/qPD5CyXgjZE7fMc0CPGqmDC4bP/e+x8HV
   M0GQCYtiMVH920I2oWtLxMNEx02sKYFUZWLH/FstTR0E696MOHSM83KKH
   EmWyHVgfxFbnk5cXQe26EggZTiYOwVF4G1KTNeTL+C11U4KvQQQ7sEZex
   M=;
X-CSE-ConnectionGUID: IFmczDuiT9Kuht1ZrMIvoA==
X-CSE-MsgGUID: sIyvmlP9QSqOZQgORpxT1A==
X-IronPort-AV: E=Sophos;i="6.04,237,1695686400"; 
   d="scan'208";a="141992710"
Received: from rcdn-core-9.cisco.com ([173.37.93.145])
  by rcdn-iport-8.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 02:36:08 +0000
Received: from localhost.cisco.com ([10.193.101.253])
        (authenticated bits=0)
        by rcdn-core-9.cisco.com (8.15.2/8.15.2) with ESMTPSA id 3AU2YA49007614
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 30 Nov 2023 02:36:07 GMT
From:   Karan Tilak Kumar <kartilak@cisco.com>
To:     sebaddel@cisco.com
Cc:     arulponn@cisco.com, djhawar@cisco.com, gcboffa@cisco.com,
        mkai2@cisco.com, satishkh@cisco.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Karan Tilak Kumar <kartilak@cisco.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v4 07/13] scsi: fnic: Modify ISRs to support multiqueue(MQ)
Date:   Wed, 29 Nov 2023 18:33:56 -0800
Message-Id: <20231130023402.802282-8-kartilak@cisco.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231130023402.802282-1-kartilak@cisco.com>
References: <20231130023402.802282-1-kartilak@cisco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-User: kartilak@cisco.com
X-Outbound-SMTP-Client: 10.193.101.253, [10.193.101.253]
X-Outbound-Node: rcdn-core-9.cisco.com
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify interrupt service routines for INTx, MSI, and MSI-x
to support multiqueue.
Modify parameter list of fnic_wq_copy_cmpl_handler
to take cq_index.
Modify fnic_cleanup function to use the new
function call of fnic_wq_copy_cmpl_handler.
Refactor code to set
interrupt mode to MSI-x to a new function.
Add a new stat for intx_dummy.

Changes between v2 and v3:
    Incorporate the following review comments from Hannes:
        Replace cpy_wq_base with copy_wq_base.
	Remove C99 style comment.
    Extend review comments of FNIC_MAIN_DBG and FNIC_SCSI_DBG
    to FNIC_ISR_DBG:
        Use fnic_num as an argument to FNIC_ISR_DBG.
	Modify definition of FNIC_ISR_DBG.
	Host number is still used as an argument to
	FNIC_ISR_DBG since it in turn uses
	shost_printk.
	Removed reviewed by tag from Hannes due to
	additional modifications.

Changes between v1 and v2:
    Suppress warning from kernel test bot.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202310251847.4T8BVZAZ-lkp@intel.com/
Reviewed-by: Sesidhar Baddela <sebaddel@cisco.com>
Reviewed-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
Signed-off-by: Karan Tilak Kumar <kartilak@cisco.com>
---
 drivers/scsi/fnic/fnic.h       |   9 +-
 drivers/scsi/fnic/fnic_isr.c   | 166 ++++++++++++++++++++++++---------
 drivers/scsi/fnic/fnic_main.c  |   4 +-
 drivers/scsi/fnic/fnic_scsi.c  |  38 +++-----
 drivers/scsi/fnic/fnic_stats.h |   1 +
 5 files changed, 144 insertions(+), 74 deletions(-)

diff --git a/drivers/scsi/fnic/fnic.h b/drivers/scsi/fnic/fnic.h
index 07d67fe903f2..97a2e547584a 100644
--- a/drivers/scsi/fnic/fnic.h
+++ b/drivers/scsi/fnic/fnic.h
@@ -160,9 +160,11 @@ do {								\
 	FNIC_CHECK_LOGGING(FNIC_SCSI_LOGGING,			\
 			 shost_printk(kern_level, host, fmt, ##args);)
 
-#define FNIC_ISR_DBG(kern_level, host, fmt, args...)		\
+#define FNIC_ISR_DBG(kern_level, host, fnic_num, fmt, args...)		\
 	FNIC_CHECK_LOGGING(FNIC_ISR_LOGGING,			\
-			 shost_printk(kern_level, host, fmt, ##args);)
+			 shost_printk(kern_level, host,			\
+				"fnic<%d>: %s: %d: " fmt, fnic_num,\
+				__func__, __LINE__, ##args);)
 
 #define FNIC_MAIN_NOTE(kern_level, host, fmt, args...)          \
 	shost_printk(kern_level, host, fmt, ##args)
@@ -347,6 +349,7 @@ extern const struct attribute_group *fnic_host_groups[];
 
 void fnic_clear_intr_mode(struct fnic *fnic);
 int fnic_set_intr_mode(struct fnic *fnic);
+int fnic_set_intr_mode_msix(struct fnic *fnic);
 void fnic_free_intr(struct fnic *fnic);
 int fnic_request_intr(struct fnic *fnic);
 
@@ -373,7 +376,7 @@ void fnic_scsi_cleanup(struct fc_lport *);
 void fnic_scsi_abort_io(struct fc_lport *);
 void fnic_empty_scsi_cleanup(struct fc_lport *);
 void fnic_exch_mgr_reset(struct fc_lport *, u32, u32);
-int fnic_wq_copy_cmpl_handler(struct fnic *fnic, int);
+int fnic_wq_copy_cmpl_handler(struct fnic *fnic, int copy_work_to_do, unsigned int cq_index);
 int fnic_wq_cmpl_handler(struct fnic *fnic, int);
 int fnic_flogi_reg_handler(struct fnic *fnic, u32);
 void fnic_wq_copy_cleanup_handler(struct vnic_wq_copy *wq,
diff --git a/drivers/scsi/fnic/fnic_isr.c b/drivers/scsi/fnic/fnic_isr.c
index dff9689023e4..ff85441c6cea 100644
--- a/drivers/scsi/fnic/fnic_isr.c
+++ b/drivers/scsi/fnic/fnic_isr.c
@@ -38,8 +38,13 @@ static irqreturn_t fnic_isr_legacy(int irq, void *data)
 		fnic_log_q_error(fnic);
 	}
 
+	if (pba & (1 << FNIC_INTX_DUMMY)) {
+		atomic64_inc(&fnic->fnic_stats.misc_stats.intx_dummy);
+		vnic_intr_return_all_credits(&fnic->intr[FNIC_INTX_DUMMY]);
+	}
+
 	if (pba & (1 << FNIC_INTX_WQ_RQ_COPYWQ)) {
-		work_done += fnic_wq_copy_cmpl_handler(fnic, io_completions);
+		work_done += fnic_wq_copy_cmpl_handler(fnic, io_completions, FNIC_MQ_CQ_INDEX);
 		work_done += fnic_wq_cmpl_handler(fnic, -1);
 		work_done += fnic_rq_cmpl_handler(fnic, -1);
 
@@ -60,7 +65,7 @@ static irqreturn_t fnic_isr_msi(int irq, void *data)
 	fnic->fnic_stats.misc_stats.last_isr_time = jiffies;
 	atomic64_inc(&fnic->fnic_stats.misc_stats.isr_count);
 
-	work_done += fnic_wq_copy_cmpl_handler(fnic, io_completions);
+	work_done += fnic_wq_copy_cmpl_handler(fnic, io_completions, FNIC_MQ_CQ_INDEX);
 	work_done += fnic_wq_cmpl_handler(fnic, -1);
 	work_done += fnic_rq_cmpl_handler(fnic, -1);
 
@@ -109,12 +114,22 @@ static irqreturn_t fnic_isr_msix_wq_copy(int irq, void *data)
 {
 	struct fnic *fnic = data;
 	unsigned long wq_copy_work_done = 0;
+	int i;
 
 	fnic->fnic_stats.misc_stats.last_isr_time = jiffies;
 	atomic64_inc(&fnic->fnic_stats.misc_stats.isr_count);
 
-	wq_copy_work_done = fnic_wq_copy_cmpl_handler(fnic, io_completions);
-	vnic_intr_return_credits(&fnic->intr[FNIC_MSIX_WQ_COPY],
+	i = irq - fnic->msix[0].irq_num;
+	if (i >= fnic->wq_copy_count + fnic->copy_wq_base ||
+		i < 0 || fnic->msix[i].irq_num != irq) {
+		for (i = fnic->copy_wq_base; i < fnic->wq_copy_count + fnic->copy_wq_base ; i++) {
+			if (fnic->msix[i].irq_num == irq)
+				break;
+		}
+	}
+
+	wq_copy_work_done = fnic_wq_copy_cmpl_handler(fnic, io_completions, i);
+	vnic_intr_return_credits(&fnic->intr[i],
 				 wq_copy_work_done,
 				 1 /* unmask intr */,
 				 1 /* reset intr timer */);
@@ -128,7 +143,7 @@ static irqreturn_t fnic_isr_msix_err_notify(int irq, void *data)
 	fnic->fnic_stats.misc_stats.last_isr_time = jiffies;
 	atomic64_inc(&fnic->fnic_stats.misc_stats.isr_count);
 
-	vnic_intr_return_all_credits(&fnic->intr[FNIC_MSIX_ERR_NOTIFY]);
+	vnic_intr_return_all_credits(&fnic->intr[fnic->err_intr_offset]);
 	fnic_log_q_error(fnic);
 	fnic_handle_link_event(fnic);
 
@@ -186,26 +201,30 @@ int fnic_request_intr(struct fnic *fnic)
 		fnic->msix[FNIC_MSIX_WQ].isr = fnic_isr_msix_wq;
 		fnic->msix[FNIC_MSIX_WQ].devid = fnic;
 
-		sprintf(fnic->msix[FNIC_MSIX_WQ_COPY].devname,
-			"%.11s-scsi-wq", fnic->name);
-		fnic->msix[FNIC_MSIX_WQ_COPY].isr = fnic_isr_msix_wq_copy;
-		fnic->msix[FNIC_MSIX_WQ_COPY].devid = fnic;
+		for (i = fnic->copy_wq_base; i < fnic->wq_copy_count + fnic->copy_wq_base; i++) {
+			sprintf(fnic->msix[i].devname,
+				"%.11s-scsi-wq-%d", fnic->name, i-FNIC_MSIX_WQ_COPY);
+			fnic->msix[i].isr = fnic_isr_msix_wq_copy;
+			fnic->msix[i].devid = fnic;
+		}
 
-		sprintf(fnic->msix[FNIC_MSIX_ERR_NOTIFY].devname,
+		sprintf(fnic->msix[fnic->err_intr_offset].devname,
 			"%.11s-err-notify", fnic->name);
-		fnic->msix[FNIC_MSIX_ERR_NOTIFY].isr =
+		fnic->msix[fnic->err_intr_offset].isr =
 			fnic_isr_msix_err_notify;
-		fnic->msix[FNIC_MSIX_ERR_NOTIFY].devid = fnic;
+		fnic->msix[fnic->err_intr_offset].devid = fnic;
 
-		for (i = 0; i < ARRAY_SIZE(fnic->msix); i++) {
-			err = request_irq(pci_irq_vector(fnic->pdev, i),
-					  fnic->msix[i].isr, 0,
-					  fnic->msix[i].devname,
-					  fnic->msix[i].devid);
+		for (i = 0; i < fnic->intr_count; i++) {
+			fnic->msix[i].irq_num = pci_irq_vector(fnic->pdev, i);
+
+			err = request_irq(fnic->msix[i].irq_num,
+							fnic->msix[i].isr, 0,
+							fnic->msix[i].devname,
+							fnic->msix[i].devid);
 			if (err) {
-				shost_printk(KERN_ERR, fnic->lport->host,
-					     "MSIX: request_irq"
-					     " failed %d\n", err);
+				FNIC_ISR_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+							"request_irq failed with error: %d\n",
+							err);
 				fnic_free_intr(fnic);
 				break;
 			}
@@ -220,44 +239,99 @@ int fnic_request_intr(struct fnic *fnic)
 	return err;
 }
 
-int fnic_set_intr_mode(struct fnic *fnic)
+int fnic_set_intr_mode_msix(struct fnic *fnic)
 {
 	unsigned int n = ARRAY_SIZE(fnic->rq);
 	unsigned int m = ARRAY_SIZE(fnic->wq);
 	unsigned int o = ARRAY_SIZE(fnic->hw_copy_wq);
+	unsigned int min_irqs = n + m + 1 + 1; /*rq, raw wq, wq, err*/
 
 	/*
-	 * Set interrupt mode (INTx, MSI, MSI-X) depending
-	 * system capabilities.
-	 *
-	 * Try MSI-X first
-	 *
 	 * We need n RQs, m WQs, o Copy WQs, n+m+o CQs, and n+m+o+1 INTRs
 	 * (last INTR is used for WQ/RQ errors and notification area)
 	 */
-	if (fnic->rq_count >= n &&
-	    fnic->raw_wq_count >= m &&
-	    fnic->wq_copy_count >= o &&
-	    fnic->cq_count >= n + m + o) {
-		int vecs = n + m + o + 1;
-
-		if (pci_alloc_irq_vectors(fnic->pdev, vecs, vecs,
-				PCI_IRQ_MSIX) == vecs) {
+	FNIC_ISR_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		"rq-array size: %d wq-array size: %d copy-wq array size: %d\n",
+		n, m, o);
+	FNIC_ISR_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		"rq_count: %d raw_wq_count: %d wq_copy_count: %d cq_count: %d\n",
+		fnic->rq_count, fnic->raw_wq_count,
+		fnic->wq_copy_count, fnic->cq_count);
+
+	if (fnic->rq_count <= n && fnic->raw_wq_count <= m &&
+		fnic->wq_copy_count <= o) {
+		int vec_count = 0;
+		int vecs = fnic->rq_count + fnic->raw_wq_count + fnic->wq_copy_count + 1;
+
+		vec_count = pci_alloc_irq_vectors(fnic->pdev, min_irqs, vecs,
+					PCI_IRQ_MSIX | PCI_IRQ_AFFINITY);
+		FNIC_ISR_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					"allocated %d MSI-X vectors\n",
+					vec_count);
+
+		if (vec_count > 0) {
+			if (vec_count < vecs) {
+				FNIC_ISR_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+				"interrupts number mismatch: vec_count: %d vecs: %d\n",
+				vec_count, vecs);
+				if (vec_count < min_irqs) {
+					FNIC_ISR_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+								"no interrupts for copy wq\n");
+					return 1;
+				}
+			}
+
 			fnic->rq_count = n;
 			fnic->raw_wq_count = m;
-			fnic->wq_copy_count = o;
-			fnic->wq_count = m + o;
-			fnic->cq_count = n + m + o;
-			fnic->intr_count = vecs;
-			fnic->err_intr_offset = FNIC_MSIX_ERR_NOTIFY;
-
-			FNIC_ISR_DBG(KERN_DEBUG, fnic->lport->host,
-				     "Using MSI-X Interrupts\n");
-			vnic_dev_set_intr_mode(fnic->vdev,
-					       VNIC_DEV_INTR_MODE_MSIX);
+			fnic->copy_wq_base = fnic->rq_count + fnic->raw_wq_count;
+			fnic->wq_copy_count = vec_count - n - m - 1;
+			fnic->wq_count = fnic->raw_wq_count + fnic->wq_copy_count;
+			if (fnic->cq_count != vec_count - 1) {
+				FNIC_ISR_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+				"CQ count: %d does not match MSI-X vector count: %d\n",
+				fnic->cq_count, vec_count);
+				fnic->cq_count = vec_count - 1;
+			}
+			fnic->intr_count = vec_count;
+			fnic->err_intr_offset = fnic->rq_count + fnic->wq_count;
+
+			FNIC_ISR_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				"rq_count: %d raw_wq_count: %d copy_wq_base: %d\n",
+				fnic->rq_count,
+				fnic->raw_wq_count, fnic->copy_wq_base);
+
+			FNIC_ISR_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				"wq_copy_count: %d wq_count: %d cq_count: %d\n",
+				fnic->wq_copy_count,
+				fnic->wq_count, fnic->cq_count);
+
+			FNIC_ISR_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				"intr_count: %d err_intr_offset: %u",
+				fnic->intr_count,
+				fnic->err_intr_offset);
+
+			vnic_dev_set_intr_mode(fnic->vdev, VNIC_DEV_INTR_MODE_MSIX);
+			FNIC_ISR_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					"fnic using MSI-X\n");
 			return 0;
 		}
 	}
+	return 1;
+}
+
+int fnic_set_intr_mode(struct fnic *fnic)
+{
+	int ret_status = 0;
+
+	/*
+	 * Set interrupt mode (INTx, MSI, MSI-X) depending
+	 * system capabilities.
+	 *
+	 * Try MSI-X first
+	 */
+	ret_status = fnic_set_intr_mode_msix(fnic);
+	if (ret_status == 0)
+		return ret_status;
 
 	/*
 	 * Next try MSI
@@ -277,7 +351,7 @@ int fnic_set_intr_mode(struct fnic *fnic)
 		fnic->intr_count = 1;
 		fnic->err_intr_offset = 0;
 
-		FNIC_ISR_DBG(KERN_DEBUG, fnic->lport->host,
+		FNIC_ISR_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
 			     "Using MSI Interrupts\n");
 		vnic_dev_set_intr_mode(fnic->vdev, VNIC_DEV_INTR_MODE_MSI);
 
@@ -303,7 +377,7 @@ int fnic_set_intr_mode(struct fnic *fnic)
 		fnic->cq_count = 3;
 		fnic->intr_count = 3;
 
-		FNIC_ISR_DBG(KERN_DEBUG, fnic->lport->host,
+		FNIC_ISR_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
 			     "Using Legacy Interrupts\n");
 		vnic_dev_set_intr_mode(fnic->vdev, VNIC_DEV_INTR_MODE_INTX);
 
diff --git a/drivers/scsi/fnic/fnic_main.c b/drivers/scsi/fnic/fnic_main.c
index 021ddf33c4cc..32ae4b32e5ba 100644
--- a/drivers/scsi/fnic/fnic_main.c
+++ b/drivers/scsi/fnic/fnic_main.c
@@ -476,6 +476,7 @@ static int fnic_cleanup(struct fnic *fnic)
 {
 	unsigned int i;
 	int err;
+	int raw_wq_rq_counts;
 
 	vnic_dev_disable(fnic->vdev);
 	for (i = 0; i < fnic->intr_count; i++)
@@ -495,10 +496,11 @@ static int fnic_cleanup(struct fnic *fnic)
 		err = vnic_wq_copy_disable(&fnic->hw_copy_wq[i]);
 		if (err)
 			return err;
+		raw_wq_rq_counts = fnic->raw_wq_count + fnic->rq_count;
+		fnic_wq_copy_cmpl_handler(fnic, -1, i + raw_wq_rq_counts);
 	}
 
 	/* Clean up completed IOs and FCS frames */
-	fnic_wq_copy_cmpl_handler(fnic, io_completions);
 	fnic_wq_cmpl_handler(fnic, -1);
 	fnic_rq_cmpl_handler(fnic, -1);
 
diff --git a/drivers/scsi/fnic/fnic_scsi.c b/drivers/scsi/fnic/fnic_scsi.c
index 3498a8d670b1..f32781f8fdd0 100644
--- a/drivers/scsi/fnic/fnic_scsi.c
+++ b/drivers/scsi/fnic/fnic_scsi.c
@@ -1303,10 +1303,8 @@ static int fnic_fcpio_cmpl_handler(struct vnic_dev *vdev,
  * fnic_wq_copy_cmpl_handler
  * Routine to process wq copy
  */
-int fnic_wq_copy_cmpl_handler(struct fnic *fnic, int copy_work_to_do)
+int fnic_wq_copy_cmpl_handler(struct fnic *fnic, int copy_work_to_do, unsigned int cq_index)
 {
-	unsigned int wq_work_done = 0;
-	unsigned int i, cq_index;
 	unsigned int cur_work_done;
 	struct misc_stats *misc_stats = &fnic->fnic_stats.misc_stats;
 	u64 start_jiffies = 0;
@@ -1314,28 +1312,20 @@ int fnic_wq_copy_cmpl_handler(struct fnic *fnic, int copy_work_to_do)
 	u64 delta_jiffies = 0;
 	u64 delta_ms = 0;
 
-	for (i = 0; i < fnic->wq_copy_count; i++) {
-		cq_index = i + fnic->raw_wq_count + fnic->rq_count;
-
-		start_jiffies = jiffies;
-		cur_work_done = vnic_cq_copy_service(&fnic->cq[cq_index],
-						     fnic_fcpio_cmpl_handler,
-						     copy_work_to_do);
-		end_jiffies = jiffies;
-
-		wq_work_done += cur_work_done;
-		delta_jiffies = end_jiffies - start_jiffies;
-		if (delta_jiffies >
-			(u64) atomic64_read(&misc_stats->max_isr_jiffies)) {
-			atomic64_set(&misc_stats->max_isr_jiffies,
-					delta_jiffies);
-			delta_ms = jiffies_to_msecs(delta_jiffies);
-			atomic64_set(&misc_stats->max_isr_time_ms, delta_ms);
-			atomic64_set(&misc_stats->corr_work_done,
-					cur_work_done);
-		}
+	start_jiffies = jiffies;
+	cur_work_done = vnic_cq_copy_service(&fnic->cq[cq_index],
+					fnic_fcpio_cmpl_handler,
+					copy_work_to_do);
+	end_jiffies = jiffies;
+	delta_jiffies = end_jiffies - start_jiffies;
+	if (delta_jiffies > (u64) atomic64_read(&misc_stats->max_isr_jiffies)) {
+		atomic64_set(&misc_stats->max_isr_jiffies, delta_jiffies);
+		delta_ms = jiffies_to_msecs(delta_jiffies);
+		atomic64_set(&misc_stats->max_isr_time_ms, delta_ms);
+		atomic64_set(&misc_stats->corr_work_done, cur_work_done);
 	}
-	return wq_work_done;
+
+	return cur_work_done;
 }
 
 static bool fnic_cleanup_io_iter(struct scsi_cmnd *sc, void *data)
diff --git a/drivers/scsi/fnic/fnic_stats.h b/drivers/scsi/fnic/fnic_stats.h
index bdf639eef8cf..07d1556e3c32 100644
--- a/drivers/scsi/fnic/fnic_stats.h
+++ b/drivers/scsi/fnic/fnic_stats.h
@@ -103,6 +103,7 @@ struct misc_stats {
 	atomic64_t rport_not_ready;
 	atomic64_t frame_errors;
 	atomic64_t current_port_speed;
+	atomic64_t intx_dummy;
 };
 
 struct fnic_stats {
-- 
2.31.1

