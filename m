Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC0AE7FE6E4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 03:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344198AbjK3CgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 21:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344153AbjK3CgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 21:36:09 -0500
Received: from rcdn-iport-4.cisco.com (rcdn-iport-4.cisco.com [173.37.86.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA194D7D;
        Wed, 29 Nov 2023 18:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=10271; q=dns/txt;
  s=iport; t=1701311774; x=1702521374;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UYqpk+5Te3Of7WdQeb2x1BuiQlpqIfQK/u1dIBFYGRY=;
  b=G4KoGP5MxFk/gnWGmq75dGEOU1pp2+yyM+CtULm4Ff3xzQInHxvBiSfY
   MT4IJOv4sv5zk+om0bZC7qYANnjZnRvAhh9GkIpCNnoFQZv88lGXLYoRN
   Jx2xW7I0Z41v1VoNTim34kqVo1wbQ5sUIdcXv3CbtMniJb2LnfgUKiMda
   U=;
X-CSE-ConnectionGUID: lD06uO88Tf2QHjnLOiRK/A==
X-CSE-MsgGUID: 5AvtyRODTJGV/xTfgBIV3A==
X-IronPort-AV: E=Sophos;i="6.04,237,1695686400"; 
   d="scan'208";a="149343610"
Received: from rcdn-core-9.cisco.com ([173.37.93.145])
  by rcdn-iport-4.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 02:36:14 +0000
Received: from localhost.cisco.com ([10.193.101.253])
        (authenticated bits=0)
        by rcdn-core-9.cisco.com (8.15.2/8.15.2) with ESMTPSA id 3AU2YA4C007614
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 30 Nov 2023 02:36:13 GMT
From:   Karan Tilak Kumar <kartilak@cisco.com>
To:     sebaddel@cisco.com
Cc:     arulponn@cisco.com, djhawar@cisco.com, gcboffa@cisco.com,
        mkai2@cisco.com, satishkh@cisco.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Karan Tilak Kumar <kartilak@cisco.com>,
        Hannes Reinecke <hare@suse.de>,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v4 10/13] scsi: fnic: Add support for multiqueue (MQ) in fnic_main.c
Date:   Wed, 29 Nov 2023 18:33:59 -0800
Message-Id: <20231130023402.802282-11-kartilak@cisco.com>
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
Reviewed-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: Karan Tilak Kumar <kartilak@cisco.com>
---
 drivers/scsi/fnic/fnic.h      |   4 +-
 drivers/scsi/fnic/fnic_main.c | 107 ++++++++++++++++++++++++----------
 2 files changed, 77 insertions(+), 34 deletions(-)

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
index 32ae4b32e5ba..4ce933d5c15f 100644
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
@@ -114,6 +116,7 @@ static const struct scsi_host_template fnic_host_template = {
 	.shost_groups = fnic_host_groups,
 	.track_queue_depth = 1,
 	.cmd_size = sizeof(struct fnic_cmd_priv),
+	.map_queues = fnic_mq_map_queues_cpus,
 };
 
 static void
@@ -390,7 +393,7 @@ static int fnic_notify_set(struct fnic *fnic)
 		err = vnic_dev_notify_set(fnic->vdev, -1);
 		break;
 	case VNIC_DEV_INTR_MODE_MSIX:
-		err = vnic_dev_notify_set(fnic->vdev, FNIC_MSIX_ERR_NOTIFY);
+		err = vnic_dev_notify_set(fnic->vdev, fnic->wq_copy_count + fnic->copy_wq_base);
 		break;
 	default:
 		shost_printk(KERN_ERR, fnic->lport->host,
@@ -563,11 +566,6 @@ static int fnic_scsi_drv_init(struct fnic *fnic)
 	host->max_cmd_len = FCOE_MAX_CMD_LEN;
 
 	host->nr_hw_queues = fnic->wq_copy_count;
-	if (host->nr_hw_queues > 1)
-		shost_printk(KERN_ERR, host,
-				"fnic: blk-mq is not supported");
-
-	host->nr_hw_queues = fnic->wq_copy_count = 1;
 
 	shost_printk(KERN_INFO, host,
 			"fnic: can_queue: %d max_lun: %llu",
@@ -580,6 +578,32 @@ static int fnic_scsi_drv_init(struct fnic *fnic)
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
@@ -590,6 +614,7 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	int fnic_id = 0;
 	int i;
 	unsigned long flags;
+	int hwq;
 
 	/*
 	 * Allocate SCSI Host and set up association between host,
@@ -613,8 +638,8 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 	fnic->lport = lp;
 	fnic->ctlr.lp = lp;
-
 	fnic->link_events = 0;
+	fnic->pdev = pdev;
 
 	snprintf(fnic->name, sizeof(fnic->name) - 1, "%s%d", DRV_NAME,
 		 host->host_no);
@@ -623,11 +648,6 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	fnic->fnic_num = fnic_id;
 	fnic_stats_debugfs_init(fnic);
 
-	/* Setup PCI resources */
-	pci_set_drvdata(pdev, fnic);
-
-	fnic->pdev = pdev;
-
 	err = pci_enable_device(pdev);
 	if (err) {
 		shost_printk(KERN_ERR, fnic->lport->host,
@@ -729,7 +749,8 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_out_dev_close;
 	}
 
-	fnic_scsi_drv_init(fnic);
+	/* Setup PCI resources */
+	pci_set_drvdata(pdev, fnic);
 
 	fnic_get_res_counts(fnic);
 
@@ -749,6 +770,16 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
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
@@ -833,16 +864,32 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
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
@@ -851,9 +898,10 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (err) {
 		shost_printk(KERN_ERR, fnic->lport->host,
 			     "fnic: scsi_add_host failed...exiting\n");
-		goto err_out_free_rq_buf;
+		goto err_out_scsi_add_host;
 	}
 
+
 	/* Start local port initiatialization */
 
 	lp->link_up = 0;
@@ -877,7 +925,7 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (!fc_exch_mgr_alloc(lp, FC_CLASS_3, FCPIO_HOST_EXCH_RANGE_START,
 			       FCPIO_HOST_EXCH_RANGE_END, NULL)) {
 		err = -ENOMEM;
-		goto err_out_remove_scsi_host;
+		goto err_out_fc_exch_mgr_alloc;
 	}
 
 	fc_lport_init_stats(lp);
@@ -905,21 +953,8 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
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
@@ -931,12 +966,15 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
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
@@ -945,6 +983,8 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 err_out_free_ioreq_pool:
 	mempool_destroy(fnic->io_req_pool);
 err_out_free_resources:
+	for (hwq = 0; hwq < fnic->wq_copy_count; hwq++)
+		kfree(fnic->sw_copy_wq[hwq].io_req_table);
 	fnic_free_vnic_resources(fnic);
 err_out_clear_intr:
 	fnic_clear_intr_mode(fnic);
@@ -973,6 +1013,7 @@ static void fnic_remove(struct pci_dev *pdev)
 	struct fnic *fnic = pci_get_drvdata(pdev);
 	struct fc_lport *lp = fnic->lport;
 	unsigned long flags;
+	int hwq;
 
 	/*
 	 * Mark state so that the workqueue thread stops forwarding
@@ -1033,6 +1074,8 @@ static void fnic_remove(struct pci_dev *pdev)
 
 	fc_remove_host(fnic->lport->host);
 	scsi_remove_host(fnic->lport->host);
+	for (hwq = 0; hwq < fnic->wq_copy_count; hwq++)
+		kfree(fnic->sw_copy_wq[hwq].io_req_table);
 	fc_exch_mgr_free(fnic->lport);
 	vnic_dev_notify_unset(fnic->vdev);
 	fnic_free_intr(fnic);
-- 
2.31.1

