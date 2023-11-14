Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A037EB97F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 23:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234185AbjKNWiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 17:38:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234159AbjKNWiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 17:38:23 -0500
Received: from rcdn-iport-5.cisco.com (rcdn-iport-5.cisco.com [173.37.86.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9A0C2;
        Tue, 14 Nov 2023 14:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=10197; q=dns/txt;
  s=iport; t=1700001500; x=1701211100;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KDPqCPZg3ZwZjtcY5i7ArvTW06Unl5ee8G+MmEbWMeQ=;
  b=VffGFj4bkW02bcuI14TkISfpF8FF0DrC6/fJzVlLueWIWM+qTl7keqb5
   Oj4aTlQIIrMGVyrHNNnIfgrMyJAScJJBb6+1rN07F6cgBXJFihUJFmPtx
   vlisp5sxtkB3sU6Siu8bMLgtpz6OQVAaIkqHcbLlFDAdhZgMscfhipkNg
   U=;
X-CSE-ConnectionGUID: J1F61qkQT26tU/CMAL5T/A==
X-CSE-MsgGUID: lIgx8DMMQZ2TCc5bD4+g/Q==
X-IronPort-AV: E=Sophos;i="6.03,303,1694736000"; 
   d="scan'208";a="138623835"
Received: from rcdn-core-8.cisco.com ([173.37.93.144])
  by rcdn-iport-5.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 22:38:19 +0000
Received: from localhost.cisco.com ([10.193.101.253])
        (authenticated bits=0)
        by rcdn-core-8.cisco.com (8.15.2/8.15.2) with ESMTPSA id 3AEMcCvs003313
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 14 Nov 2023 22:38:18 GMT
From:   Karan Tilak Kumar <kartilak@cisco.com>
To:     sebaddel@cisco.com
Cc:     arulponn@cisco.com, djhawar@cisco.com, gcboffa@cisco.com,
        mkai2@cisco.com, satishkh@cisco.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Karan Tilak Kumar <kartilak@cisco.com>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH v3 10/13] scsi: fnic: Add support for multiqueue (MQ) in fnic_main.c
Date:   Tue, 14 Nov 2023 14:38:10 -0800
Message-Id: <20231114223810.634200-1-kartilak@cisco.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-User: kartilak@cisco.com
X-Outbound-SMTP-Client: 10.193.101.253, [10.193.101.253]
X-Outbound-Node: rcdn-core-8.cisco.com
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set map_queues in the fnic_host_template to fnic_mq_map_queues_cpus.
Define fnic_mq_map_queues_cpus to set cpu assignment to
fnic queues.
Refactor code in fnic_probe to enable vnic queues before scsi_add_host.
Modify notify set to the correct index.

Changes between v2 and v3:
    Incorporate review comment from Hannes:
        Replace cpy_wq_base with copy_wq_base.
    Incorporate review comment from John Garry:
	Replace code in fnic_mq_map_queues_cpus
	with blk_mq_pci_map_queues.
    Replace shost_printk logs with FNIC_MAIN_DBG.

Reviewed-by: Sesidhar Baddela <sebaddel@cisco.com>
Reviewed-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Karan Tilak Kumar <kartilak@cisco.com>
---
 drivers/scsi/fnic/fnic.h      |   4 +-
 drivers/scsi/fnic/fnic_main.c | 109 ++++++++++++++++++++++++----------
 2 files changed, 78 insertions(+), 35 deletions(-)

diff --git a/drivers/scsi/fnic/fnic.h b/drivers/scsi/fnic/fnic.h
index 97a2e547584a..5777a54c99c3 100644
--- a/drivers/scsi/fnic/fnic.h
+++ b/drivers/scsi/fnic/fnic.h
@@ -109,7 +109,7 @@ static inline u64 fnic_flags_and_state(struct scsi_cmnd *cmd)
 #define FNIC_ABT_TERM_DELAY_TIMEOUT  500        /* mSec */
 
 #define FNIC_MAX_FCP_TARGET     256
-
+#define FNIC_PCI_OFFSET		2
 /**
  * state_flags to identify host state along along with fnic's state
  **/
@@ -384,7 +384,7 @@ void fnic_wq_copy_cleanup_handler(struct vnic_wq_copy *wq,
 int fnic_fw_reset_handler(struct fnic *fnic);
 void fnic_terminate_rport_io(struct fc_rport *);
 const char *fnic_state_to_str(unsigned int state);
-
+void fnic_mq_map_queues_cpus(struct Scsi_Host *host);
 void fnic_log_q_error(struct fnic *fnic);
 void fnic_handle_link_event(struct fnic *fnic);
 
diff --git a/drivers/scsi/fnic/fnic_main.c b/drivers/scsi/fnic/fnic_main.c
index 8bb0165490f4..93c457d88fc2 100644
--- a/drivers/scsi/fnic/fnic_main.c
+++ b/drivers/scsi/fnic/fnic_main.c
@@ -12,9 +12,11 @@
 #include <linux/pci.h>
 #include <linux/skbuff.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
 #include <linux/if_ether.h>
+#include <linux/blk-mq-pci.h>
 #include <scsi/fc/fc_fip.h>
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_transport.h>
@@ -116,6 +118,7 @@ static const struct scsi_host_template fnic_host_template = {
 	.shost_groups = fnic_host_groups,
 	.track_queue_depth = 1,
 	.cmd_size = sizeof(struct fnic_cmd_priv),
+	.map_queues = fnic_mq_map_queues_cpus,
 };
 
 static void
@@ -392,7 +395,7 @@ static int fnic_notify_set(struct fnic *fnic)
 		err = vnic_dev_notify_set(fnic->vdev, -1);
 		break;
 	case VNIC_DEV_INTR_MODE_MSIX:
-		err = vnic_dev_notify_set(fnic->vdev, FNIC_MSIX_ERR_NOTIFY);
+		err = vnic_dev_notify_set(fnic->vdev, fnic->wq_copy_count + fnic->copy_wq_base);
 		break;
 	default:
 		shost_printk(KERN_ERR, fnic->lport->host,
@@ -565,11 +568,6 @@ static int fnic_scsi_drv_init(struct fnic *fnic)
 	host->max_cmd_len = FCOE_MAX_CMD_LEN;
 
 	host->nr_hw_queues = fnic->wq_copy_count;
-	if (host->nr_hw_queues > 1)
-		shost_printk(KERN_ERR, host,
-				"fnic: blk-mq is not supported");
-
-	host->nr_hw_queues = fnic->wq_copy_count = 1;
 
 	shost_printk(KERN_INFO, host,
 			"fnic: can_queue: %d max_lun: %llu",
@@ -582,15 +580,42 @@ static int fnic_scsi_drv_init(struct fnic *fnic)
 	return 0;
 }
 
+void fnic_mq_map_queues_cpus(struct Scsi_Host *host)
+{
+	struct fc_lport *lp = shost_priv(host);
+	struct fnic *fnic = lport_priv(lp);
+	struct pci_dev *l_pdev = fnic->pdev;
+	int intr_mode = fnic->config.intr_mode;
+	struct blk_mq_queue_map *qmap = &host->tag_set.map[HCTX_TYPE_DEFAULT];
+
+	if (intr_mode == VNIC_DEV_INTR_MODE_MSI || intr_mode == VNIC_DEV_INTR_MODE_INTX) {
+		FNIC_MAIN_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+			"intr_mode is not msix\n");
+		return;
+	}
+
+	FNIC_MAIN_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			"qmap->nr_queues: %d\n", qmap->nr_queues);
+
+	if (l_pdev == NULL) {
+		FNIC_MAIN_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+						"l_pdev is null\n");
+		return;
+	}
+
+	blk_mq_pci_map_queues(qmap, l_pdev, FNIC_PCI_OFFSET);
+}
+
 static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	struct Scsi_Host *host;
 	struct fc_lport *lp;
 	struct fnic *fnic;
 	mempool_t *pool;
-	int err;
+	int err = 0;
 	int i;
 	unsigned long flags;
+	int hwq;
 
 	atomic_inc(&fnic_num);
 	/*
@@ -607,8 +632,8 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	fnic = lport_priv(lp);
 	fnic->lport = lp;
 	fnic->ctlr.lp = lp;
-
 	fnic->link_events = 0;
+	fnic->pdev = pdev;
 
 	snprintf(fnic->name, sizeof(fnic->name) - 1, "%s%d", DRV_NAME,
 		 host->host_no);
@@ -617,11 +642,6 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	fnic->fnic_num = atomic_read(&fnic_num);
 	fnic_stats_debugfs_init(fnic);
 
-	/* Setup PCI resources */
-	pci_set_drvdata(pdev, fnic);
-
-	fnic->pdev = pdev;
-
 	err = pci_enable_device(pdev);
 	if (err) {
 		shost_printk(KERN_ERR, fnic->lport->host,
@@ -723,7 +743,8 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_out_dev_close;
 	}
 
-	fnic_scsi_drv_init(fnic);
+	/* Setup PCI resources */
+	pci_set_drvdata(pdev, fnic);
 
 	fnic_get_res_counts(fnic);
 
@@ -743,6 +764,16 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_out_clear_intr;
 	}
 
+	fnic_scsi_drv_init(fnic);
+
+	for (hwq = 0; hwq < fnic->wq_copy_count; hwq++) {
+		fnic->sw_copy_wq[hwq].ioreq_table_size = fnic->fnic_max_tag_id;
+		fnic->sw_copy_wq[hwq].io_req_table =
+					kzalloc((fnic->sw_copy_wq[hwq].ioreq_table_size + 1) *
+					sizeof(struct fnic_io_req *), GFP_KERNEL);
+	}
+	shost_printk(KERN_INFO, fnic->lport->host, "fnic copy wqs: %d, Q0 ioreq table size: %d\n",
+			fnic->wq_copy_count, fnic->sw_copy_wq[0].ioreq_table_size);
 
 	/* initialize all fnic locks */
 	spin_lock_init(&fnic->fnic_lock);
@@ -827,16 +858,32 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	/* allocate RQ buffers and post them to RQ*/
 	for (i = 0; i < fnic->rq_count; i++) {
-		vnic_rq_enable(&fnic->rq[i]);
 		err = vnic_rq_fill(&fnic->rq[i], fnic_alloc_rq_frame);
 		if (err) {
 			shost_printk(KERN_ERR, fnic->lport->host,
 				     "fnic_alloc_rq_frame can't alloc "
 				     "frame\n");
-			goto err_out_free_rq_buf;
+			goto err_out_rq_buf;
 		}
 	}
 
+	/* Enable all queues */
+	for (i = 0; i < fnic->raw_wq_count; i++)
+		vnic_wq_enable(&fnic->wq[i]);
+	for (i = 0; i < fnic->rq_count; i++) {
+		if (!ioread32(&fnic->rq[i].ctrl->enable))
+			vnic_rq_enable(&fnic->rq[i]);
+	}
+	for (i = 0; i < fnic->wq_copy_count; i++)
+		vnic_wq_copy_enable(&fnic->hw_copy_wq[i]);
+
+	err = fnic_request_intr(fnic);
+	if (err) {
+		shost_printk(KERN_ERR, fnic->lport->host,
+			     "Unable to request irq.\n");
+		goto err_out_request_intr;
+	}
+
 	/*
 	 * Initialization done with PCI system, hardware, firmware.
 	 * Add host to SCSI
@@ -845,9 +892,10 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (err) {
 		shost_printk(KERN_ERR, fnic->lport->host,
 			     "fnic: scsi_add_host failed...exiting\n");
-		goto err_out_free_rq_buf;
+		goto err_out_scsi_add_host;
 	}
 
+
 	/* Start local port initiatialization */
 
 	lp->link_up = 0;
@@ -871,7 +919,7 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (!fc_exch_mgr_alloc(lp, FC_CLASS_3, FCPIO_HOST_EXCH_RANGE_START,
 			       FCPIO_HOST_EXCH_RANGE_END, NULL)) {
 		err = -ENOMEM;
-		goto err_out_remove_scsi_host;
+		goto err_out_fc_exch_mgr_alloc;
 	}
 
 	fc_lport_init_stats(lp);
@@ -899,21 +947,8 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	skb_queue_head_init(&fnic->frame_queue);
 	skb_queue_head_init(&fnic->tx_queue);
 
-	/* Enable all queues */
-	for (i = 0; i < fnic->raw_wq_count; i++)
-		vnic_wq_enable(&fnic->wq[i]);
-	for (i = 0; i < fnic->wq_copy_count; i++)
-		vnic_wq_copy_enable(&fnic->hw_copy_wq[i]);
-
 	fc_fabric_login(lp);
 
-	err = fnic_request_intr(fnic);
-	if (err) {
-		shost_printk(KERN_ERR, fnic->lport->host,
-			     "Unable to request irq.\n");
-		goto err_out_free_exch_mgr;
-	}
-
 	vnic_dev_enable(fnic->vdev);
 
 	for (i = 0; i < fnic->intr_count; i++)
@@ -925,12 +960,15 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 err_out_free_exch_mgr:
 	fc_exch_mgr_free(lp);
-err_out_remove_scsi_host:
+err_out_fc_exch_mgr_alloc:
 	fc_remove_host(lp->host);
 	scsi_remove_host(lp->host);
-err_out_free_rq_buf:
+err_out_scsi_add_host:
+	fnic_free_intr(fnic);
+err_out_request_intr:
 	for (i = 0; i < fnic->rq_count; i++)
 		vnic_rq_clean(&fnic->rq[i], fnic_free_rq_buf);
+err_out_rq_buf:
 	vnic_dev_notify_unset(fnic->vdev);
 err_out_free_max_pool:
 	mempool_destroy(fnic->io_sgl_pool[FNIC_SGL_CACHE_MAX]);
@@ -939,6 +977,8 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 err_out_free_ioreq_pool:
 	mempool_destroy(fnic->io_req_pool);
 err_out_free_resources:
+	for (hwq = 0; hwq < fnic->wq_copy_count; hwq++)
+		kfree(fnic->sw_copy_wq[hwq].io_req_table);
 	fnic_free_vnic_resources(fnic);
 err_out_clear_intr:
 	fnic_clear_intr_mode(fnic);
@@ -965,6 +1005,7 @@ static void fnic_remove(struct pci_dev *pdev)
 	struct fnic *fnic = pci_get_drvdata(pdev);
 	struct fc_lport *lp = fnic->lport;
 	unsigned long flags;
+	int hwq;
 
 	/*
 	 * Mark state so that the workqueue thread stops forwarding
@@ -1025,6 +1066,8 @@ static void fnic_remove(struct pci_dev *pdev)
 
 	fc_remove_host(fnic->lport->host);
 	scsi_remove_host(fnic->lport->host);
+	for (hwq = 0; hwq < fnic->wq_copy_count; hwq++)
+		kfree(fnic->sw_copy_wq[hwq].io_req_table);
 	fc_exch_mgr_free(fnic->lport);
 	vnic_dev_notify_unset(fnic->vdev);
 	fnic_free_intr(fnic);
-- 
2.31.1

